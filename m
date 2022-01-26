Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3EEC2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 11:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31BD910E8EC;
	Wed, 26 Jan 2022 11:59:22 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D305110E8EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 11:59:20 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id f17so25349864wrx.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 03:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bDzXf0usARhljzvvnh2TZQtneiaK8sVuiWIlx9w2RGA=;
 b=dRpao5wqA/aruoU9lCWFCECQ4d4tRiKrwTjiZN3w3P76yd+mzkuAM54YIp659W3G2Q
 LU4aAAnN0g2i06lCnHXo7QkqmVPIGZLrNyJjUDXgcfGkO+ku5M9xnBMi9hBUqbh7dHZd
 GzsDx+xGdR9EUYfuqLX1cE+VvfkGCK16zDBe85sORSABCBNQK2BiM5iUvTuFO5EoQe/2
 RD5zyD4L5VR1Mjp85dmHDZytDVuwBB/L4TuuRjuhYLWdnLoKZ4Pe3Lullaqi7QO9pt3t
 VR36frOgHgz7+ETGYZdmkWD5lHBoazHNOrroEWbdUtsDOUNYYMf4mGet8R6X8TvzEuOE
 xEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bDzXf0usARhljzvvnh2TZQtneiaK8sVuiWIlx9w2RGA=;
 b=vOMXoBzh4MQBgDk2L+LQ7jvLjcCZZXCmkilh9xbT8+Q3Ofriam86AyvcmzEOjdPko+
 Rjl15RrCfkdUH3pLTFY38gIpRYUPCV56w1KwWkU9ka9tUMb/b9Wm0ARXTaq65VPwFCB/
 oZrqKWpu8EDwlUO8okWB/8FN/OJ99OKkji9lohXPbeJjer7izu8Dk9BVoB6/PzbR57Si
 2yh1c7YQJPFtnRY156u73UpMXTRLDpWeRoqsYkQN0nXCVaTjzX5aaEFpQGE90p2dLXrp
 +OgUBlZEtoQrWhTpYObuonKjQqYeTgHR/9esEhWTubkGA8ZdjNAZCYZFvEh5W/dC0UNl
 5jpA==
X-Gm-Message-State: AOAM532vXa1G8r3rhNDKZTdLCX6Bo0RBMcPrT40Nb91VeFIILjJPaQzd
 nf5cIOjvfCJJGwIumAavmlI=
X-Google-Smtp-Source: ABdhPJziT9JysKHKx8cQK1QMJ2A9M2h/Hbba4D5P67ii2WahzfCAPvdiVgUL8NYxjDH5FtoVewQL5w==
X-Received: by 2002:a05:6000:2cb:: with SMTP id
 o11mr6658564wry.628.1643198359370; 
 Wed, 26 Jan 2022 03:59:19 -0800 (PST)
Received: from baker.fritz.box (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id n26sm3217877wms.13.2022.01.26.03.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jan 2022 03:59:19 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Luben.Tuikov@amd.com,
	Tom.StDenis@amd.com
Subject: [PATCH 2/2] drm/amdgpu: add sysfs files for XGMI segment size and
 physical node id
Date: Wed, 26 Jan 2022 12:59:17 +0100
Message-Id: <20220126115917.60308-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126115917.60308-1-christian.koenig@amd.com>
References: <20220126115917.60308-1-christian.koenig@amd.com>
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

umr needs that to correctly calculate the VRAM base address
inside the MC address space.

Only compile tested!

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 34 ++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 68509f619ba3..21a5d07a1abf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -252,6 +252,26 @@ static ssize_t amdgpu_xgmi_show_device_id(struct device *dev,
 
 }
 
+static ssize_t amdgpu_xgmi_show_node_segment_size(struct device *dev,
+						  struct device_attribute *attr,
+						  char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	return sysfs_emit(buf, "%llu\n", adev->gmc.xgmi.node_segment_size);
+}
+
+static ssize_t amdgpu_xgmi_show_physical_node_id(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	return sysfs_emit(buf, "%u\n", adev->gmc.xgmi.physical_node_id);
+}
+
 #define AMDGPU_XGMI_SET_FICAA(o)	((o) | 0x456801)
 static ssize_t amdgpu_xgmi_show_error(struct device *dev,
 				      struct device_attribute *attr,
@@ -287,6 +307,10 @@ static ssize_t amdgpu_xgmi_show_error(struct device *dev,
 
 
 static DEVICE_ATTR(xgmi_device_id, S_IRUGO, amdgpu_xgmi_show_device_id, NULL);
+static DEVICE_ATTR(xgmi_node_segment_size, S_IRUGO,
+		   amdgpu_xgmi_show_node_segment_size, NULL);
+static DEVICE_ATTR(xgmi_physical_node_id, S_IRUGO,
+		   amdgpu_xgmi_show_physical_node_id, NULL);
 static DEVICE_ATTR(xgmi_error, S_IRUGO, amdgpu_xgmi_show_error, NULL);
 
 static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
@@ -295,6 +319,8 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
 	char node[10];
 
 	device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
+	device_remove_file(adev->dev, &dev_attr_xgmi_node_segment_size);
+	device_remove_file(adev->dev, &dev_attr_xgmi_physical_node_id);
 	device_remove_file(adev->dev, &dev_attr_xgmi_error);
 
 	if (hive->kobj.parent != (&adev->dev->kobj))
@@ -318,6 +344,14 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
+	r = device_create_file(adev->dev, &dev_attr_xgmi_node_segment_size);
+	if (r)
+		goto error;
+
+	r = device_create_file(adev->dev, &dev_attr_xgmi_physical_node_id);
+	if (r)
+		goto error;
+
 	/* Create sysfs link to hive info folder on the first device */
 	if (hive->kobj.parent != (&adev->dev->kobj)) {
 		r = sysfs_create_link(&adev->dev->kobj, &hive->kobj,
-- 
2.25.1

