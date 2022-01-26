Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20722C2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 11:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFB7310E8DB;
	Wed, 26 Jan 2022 11:59:20 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06C9B10E8DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 11:59:20 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 q141-20020a1ca793000000b00347b48dfb53so4113619wme.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 03:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=I8ig2JH2eSznFy18lrwYd7NFid347W1bBP5XFs31DOU=;
 b=kZ9U1UURL6VxnvbbD9jDC7rGn7UfumKkqEIyYucRppEX4K7jTeSYidyxCapyxNjNoM
 8wc4JsvVd92H8PtLLRyimtWj1FTeHvJG1d90fjEgmtiUpn8PLFPc4H0n4XeOg2aRXzJr
 SKRilk/O/6PDbrPHPB4Se35xodujQ9hA3FF7FXvQJxSF0wyQYf914OFCB1XWHkxuc6l7
 QDgzagFwaZLKrF/CSFIntNsCWfiS+JsVhWha5msPxlWZ7vGgw/k5bNvkGJVquCw2wPYk
 TSLiHZKnvb0F/bWotXWbZQYeQ1DucqdxMC2jTng7JNB5QPocExUaY0YAecXkyCXLjbf3
 NIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=I8ig2JH2eSznFy18lrwYd7NFid347W1bBP5XFs31DOU=;
 b=GNFP8ARt7hb5uiGjUZATQb5KE3p4XI9SmUUj9NPiWy1PjPhhLEoI5DkjnUBGqO8Y4u
 p6/q6M3koZzLaOj8DR6wglMGzsic6bppyWYDqhkIHhxpwofd2G1J8Rfad/0Mcto8hNwv
 4t+pcQn33n+wE+q+nbgqRRgzbxbRNnd6gaugZhOTt1HclosXmTu16fXFZUeFiFuGo4Ep
 LGe5/OcDSHt8gRsi2FflqzcZSOoi84FmWrG+EkrizlAE2xSLxj0DmfDEjuF3BwYgYRHw
 Jadt/xNHCmzuv8uMYvr1/aqtS6L1uda+3a7PApIkfyZRksg8cWn9J7dV3YJow45wpuAp
 FHlA==
X-Gm-Message-State: AOAM531cCAgM8qEA2MbCPEveb8LvRl+LT5D9r3RPSytSJKV2OAdpN9BP
 ZJARxVTg2e+4N6EyFgBTI43+qWuUB5g=
X-Google-Smtp-Source: ABdhPJx1WDSw9SiW1NPO8mlC+++RGoDG2F4WwM29vVopYCsnmcyK72tLlOL2y65ym4JJPpLRyXVv6w==
X-Received: by 2002:a05:600c:d7:: with SMTP id
 u23mr7106009wmm.16.1643198358614; 
 Wed, 26 Jan 2022 03:59:18 -0800 (PST)
Received: from baker.fritz.box (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id n26sm3217877wms.13.2022.01.26.03.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jan 2022 03:59:18 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Luben.Tuikov@amd.com,
	Tom.StDenis@amd.com
Subject: [PATCH 1/2] drm/amdgpu: cleanup amdgpu_xgmi_sysfs_add_dev_info
Date: Wed, 26 Jan 2022 12:59:16 +0100
Message-Id: <20220126115917.60308-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Don't initialize variables if it isn't absolutely necessary.

Use amdgpu_xgmi_sysfs_rem_dev_info to cleanup when something goes wrong.

Drop the explicit warnings since the sysfs core warns about things like
duplicate files itself.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 85 +++++++++---------------
 1 file changed, 33 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 5929d6f528c9..68509f619ba3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -289,61 +289,10 @@ static ssize_t amdgpu_xgmi_show_error(struct device *dev,
 static DEVICE_ATTR(xgmi_device_id, S_IRUGO, amdgpu_xgmi_show_device_id, NULL);
 static DEVICE_ATTR(xgmi_error, S_IRUGO, amdgpu_xgmi_show_error, NULL);
 
-static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
-					 struct amdgpu_hive_info *hive)
-{
-	int ret = 0;
-	char node[10] = { 0 };
-
-	/* Create xgmi device id file */
-	ret = device_create_file(adev->dev, &dev_attr_xgmi_device_id);
-	if (ret) {
-		dev_err(adev->dev, "XGMI: Failed to create device file xgmi_device_id\n");
-		return ret;
-	}
-
-	/* Create xgmi error file */
-	ret = device_create_file(adev->dev, &dev_attr_xgmi_error);
-	if (ret)
-		pr_err("failed to create xgmi_error\n");
-
-
-	/* Create sysfs link to hive info folder on the first device */
-	if (hive->kobj.parent != (&adev->dev->kobj)) {
-		ret = sysfs_create_link(&adev->dev->kobj, &hive->kobj,
-					"xgmi_hive_info");
-		if (ret) {
-			dev_err(adev->dev, "XGMI: Failed to create link to hive info");
-			goto remove_file;
-		}
-	}
-
-	sprintf(node, "node%d", atomic_read(&hive->number_devices));
-	/* Create sysfs link form the hive folder to yourself */
-	ret = sysfs_create_link(&hive->kobj, &adev->dev->kobj, node);
-	if (ret) {
-		dev_err(adev->dev, "XGMI: Failed to create link from hive info");
-		goto remove_link;
-	}
-
-	goto success;
-
-
-remove_link:
-	sysfs_remove_link(&adev->dev->kobj, adev_to_drm(adev)->unique);
-
-remove_file:
-	device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
-
-success:
-	return ret;
-}
-
 static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
 					  struct amdgpu_hive_info *hive)
 {
 	char node[10];
-	memset(node, 0, sizeof(node));
 
 	device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
 	device_remove_file(adev->dev, &dev_attr_xgmi_error);
@@ -353,10 +302,42 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
 
 	sprintf(node, "node%d", atomic_read(&hive->number_devices));
 	sysfs_remove_link(&hive->kobj, node);
-
 }
 
+static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
+					 struct amdgpu_hive_info *hive)
+{
+	char node[10];
+	int r;
+
+	r = device_create_file(adev->dev, &dev_attr_xgmi_device_id);
+	if (r)
+		return r;
+
+	r = device_create_file(adev->dev, &dev_attr_xgmi_error);
+	if (r)
+		goto error;
 
+	/* Create sysfs link to hive info folder on the first device */
+	if (hive->kobj.parent != (&adev->dev->kobj)) {
+		r = sysfs_create_link(&adev->dev->kobj, &hive->kobj,
+				      "xgmi_hive_info");
+		if (r)
+			goto error;
+	}
+
+	/* Create sysfs link form the hive folder to yourself */
+	sprintf(node, "node%d", atomic_read(&hive->number_devices));
+	r = sysfs_create_link(&hive->kobj, &adev->dev->kobj, node);
+	if (r)
+		goto error;
+
+	return 0;
+
+error:
+	amdgpu_xgmi_sysfs_rem_dev_info(adev, hive);
+	return r;
+}
 
 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 {
-- 
2.25.1

