package com.xiaosuokeji.yilan.admin.controller.bulkio;

import com.xiaosuokeji.yilan.admin.enumeration.API;
import com.xiaosuokeji.yilan.admin.model.resource.Category;
import com.xiaosuokeji.yilan.admin.model.resource.Website;
import com.xiaosuokeji.yilan.admin.util.WebUtils;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

/**
 * 批量操作网站<br/>
 * Created by xuxiaowei on 2017/8/10.
 */
@Controller("bulkWebsiteController")
@RequestMapping("/admin")
public class BulkWebsiteController {

    @RequestMapping(value = "/website/template/download", method = RequestMethod.GET)
    public void downloadTemplate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        JSONObject jsonObject = WebUtils.doRawRequest(API.WEBSITE_CATEGORY_COMBO_TREE, new Website());
        JSONArray jsonArray = jsonObject.getJSONArray("data");
        Workbook wb = new XSSFWorkbook();
        for (int i=0; i<jsonArray.length(); ++i) {
            JSONObject category = jsonArray.getJSONObject(i);
            if(category.has("children")){
                JSONArray children = category.getJSONArray("children");
                for (int j=0; j<children.length(); ++j) {
                    JSONObject item = children.getJSONObject(j);
                    Sheet sheet = wb.createSheet(item.getString("name") +
                            "-" + String.valueOf(item.getLong("id")));
                    Row row = sheet.createRow(0);
                    row.createCell(0).setCellValue("名称");
                    row.createCell(1).setCellValue("链接");
                    row.createCell(2).setCellValue("开发者");

                    sheet.setColumnWidth(0, 30 * 256);
                    sheet.setColumnWidth(1, 120 * 256);
                    sheet.setColumnWidth(2, 30 * 256);
                }
            }


        }
        response.setHeader("Content-disposition", "attachment; filename=" +
                URLEncoder.encode("医览网-网站模板.xlsx", "UTF-8"));
        wb.write(response.getOutputStream());
    }

    @RequestMapping(value = "/website/template/upload", method = RequestMethod.POST)
    @ResponseBody
    public String uploadTemplate(MultipartFile file) throws Exception {
        Workbook wb = WorkbookFactory.create(file.getInputStream());
        List<Website> websites = new ArrayList<>();
        for (int i=0; i<wb.getNumberOfSheets(); ++i) {
            Sheet sheet = wb.getSheetAt(i);
            for (int j=1; j<=sheet.getLastRowNum(); ++j) {
                Row row = sheet.getRow(j);
                Website website = new Website();
                website.setName(row.getCell(0) == null ? "" : row.getCell(0).getStringCellValue());
                website.setUrl(row.getCell(1) == null ? "" : row.getCell(1).getStringCellValue());
                website.setDeveloper(row.getCell(2) == null ? "" : row.getCell(2).getStringCellValue());
                Category category = new Category();
                category.setId(Long.valueOf(sheet.getSheetName().split("-")[1]) );
                website.setCategory(category);
                websites.add(website);
            }
        }
        Website website = new Website();
        website.setWebsites(websites);
        return WebUtils.doRawRequest(API.BULK_WEBSITE_IMPORT, website).toString();
    }
}
