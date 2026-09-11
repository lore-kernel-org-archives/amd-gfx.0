Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E1CC88E50
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 15:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19FC910F695;
	Fri, 11 Sep 2026 15:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GWA/UB2p";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95C0410F695
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 15:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUV/Cj02liwxQ+H9rmGpb2dFxEy7D74CHuonlHb35FxqAPwIwgZFKrraJpAOeyzooxbXR/CEZbmuRLJ/cGi4x/79ibVcrq+fnHoJpuu/vgS8UlTzELhn9skAcynaUGsiCiWqS7VgcS8umGZ5RUXJJPQn8gb/Xn/qWACMtkDZBO7HjKD4m89mjzEtI9VPIOrCH5xpQAsVKY5j3WYJaQ+L8Wo2igC9dJPdGPYBoEAcnjsIhkBPBO/koNERBvsQlNtEFV6QA6X/y0sBx+xI+9YWUeRpPIBFqL7GG7jI5cMdZy1OJB9mqqF8rzP2X48I3vWHzH6TcjVa/5s5ZpeGtEdsAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Pz1VaKdk2yyzMFztOJJMf8hAMvZjuXijJ6GdPytsTQ=;
 b=pNlX9VMpoVCXEEtKCTRnZXLAYaNzJI1TQTF7dwojJuF0QQPwUPHJLnCuCNAMN515hcXFGhkXORil41GWdcTaxkFU3e8IB28ZdCBhnsEG0POJMA/6cbFNggBcgshpDOaLLQ5MgSTLpPOD9hu6Fon6Il/4PRzRtP/HAAs6PSbz9iA2WVSF/71ShNdH60DPu/KHJ96Rj96XHVTDaMYP+ct9/Ie+KBOYoOYdmx/2SdEK6sILHOi1Hh7ZdsUGJUbLcINW/kpXOwxsKjRa09Nn0Axw1Jpz5LJbERi3DJ8xVQ9omEojs2klMQvGUI/dbECqABjgWn5Od3pawkSvAGRafbQjGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Pz1VaKdk2yyzMFztOJJMf8hAMvZjuXijJ6GdPytsTQ=;
 b=GWA/UB2p7ljXCdfivVmAQbviTgx2kCz05rjDCQkHOMOhuighbGjUHv1XfsWXzdT4MMMAeAPUFInX9uJ5f6U7/s1KQbFd6FpdGL46xG7R8mfrER08dftdqt0rCQidP/YI7KBCZCzZICxn6+AV06b84qynMRJcOirOI7hjOX1Cf3E=
Received: from CH2PR07CA0045.namprd07.prod.outlook.com (2603:10b6:610:5b::19)
 by CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:42:30 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::39) by CH2PR07CA0045.outlook.office365.com
 (2603:10b6:610:5b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 15:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:42:29 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 10:42:26 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 7/8] drm/amdgpu: get rid of amdgpu_drm_ioctl
Date: Fri, 11 Sep 2026 11:42:10 -0400
Message-ID: <20260911154212.591213-8-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911154212.591213-1-shahyan.soltani@amd.com>
References: <20260911154212.591213-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: 0deadb93-1702-4cef-825c-08df101b49cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: txDhx2Moksl8O9YUynpBAegaA4Kyi6jQ33HNj4bf8csGTTK8MIx65vQG4FeSx8DWY8hyLBpW7ojazoeCm1UxqM/6QuxF/iZitGADbL6u28GzMQ90WRrW5uHdC0j8QONxFaHKHDp4CyCvj6FM+3rHSA1xD47hwvqbHS/Qc3gVWKals8qBfS2u6+IAX8flAZXc6u5eqqvnxHA31Cp92fBrEdSI1P2MmNuwJuxg+KOKr1Km/43K95j05Y9pgbiIIuX9xDEX0eASBgOLdyQkQplYpDFc1qwKA1A1MmzdeO3ah3aXocOHI3yJD5pCxXSepnuKvByaQo/gYIvFWnXUaZxgqn1i/LXX40TAFFELCAuNP0dP1z3eRFBstPGeXn/FFGS+6/hoCDgfZRhai/A4zFU1c3aS/Sy7nf9JY6WG02VqrdY0Kmu8UqBtTBZSu0dNAC4xjxZVIGwb4MnEPbolKVOnIhtTcwCyHTsD9Z3rYqQx6X8P49JkRzp19uPoCnkAQWr/c2cT3UwPjbW3MwmOVOV9OXFfECZqMZL82PjeQPvVVU5Wyq9ItZfFacq25b0dK2tCf57zqzkHFqydGXOFOEOCN/rTPCGBakNLAIcvwK9bhnyqDYMJQBfhsTnjgMe6rvbApkbt4vW5HzRTs7dVQS8WQfvSbOV9aXFRQ/1OcQifLj1UjwSDF4mKdT4p9sCveYo1Y+DrZT/gyg0FkI17L2IoEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tdvSV9URSKlaZhf9YRU/TdbeB64Iyowd65dFXJ/PmKjnbBmlz3jHKGn5FnDaZKPyDSJOhO4uhu31l6tzsSI+WEojzDDKMLu2oHJTvEBzta8Rex9g88Wsid6BANsgPuN1c3wQhjiEV1xF7W8+lpOWzrY38MsTCy58+6azwvROTYDE/hvMGLkcvYj2lmPdY4z7HZH4NKfnxL/qQP58y1HB/mokyuy5Uf/ddrRHqY4r4f+nLPuA5N4FWabGNqDPC3S//LYAh80b+VwwU2IiIaaeR/2MU5knvg4TVFg/6sK3qifP9LMhMBI901/5lTiY6k1Ezll4JExMGU/f0Nwy+lHhPDQ0iMpMP8P7kIshmQThK5NDsPPrNMpNJvaFVAsJvO9ZRcEeak51KL/webKqBtUvtme9ckL55zgYzNdNHqWSvpzMt+iZhs+FFP9ol7Q8EAvb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:42:29.7638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0deadb93-1702-4cef-825c-08df101b49cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Remove the entire amdgpu_drm_ioctl handler system in favor of drm_ioctl.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
[shahyan.soltani@amd.com: Added commit description]
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile       |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 23 +-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h   |  6 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c | 45 -----------------------
 4 files changed, 2 insertions(+), 73 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 7b08814a24da..d5ddf236a6f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -321,7 +321,6 @@ include $(FULL_AMD_PATH)/acp/Makefile
 amdgpu-y += $(AMD_ACP_FILES)
 endif
 
-amdgpu-$(CONFIG_COMPAT) += amdgpu_ioc32.o
 amdgpu-$(CONFIG_VGA_SWITCHEROO) += amdgpu_atpx_handler.o
 amdgpu-$(CONFIG_ACPI) += amdgpu_acpi.o
 amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 9c5e93cd3ee6..f51f03ae5241 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3019,25 +3019,6 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 	return drm_release(inode, filp);
 }
 
-long amdgpu_drm_ioctl(struct file *filp,
-		      unsigned int cmd, unsigned long arg)
-{
-	struct drm_file *file_priv = filp->private_data;
-	struct drm_device *dev;
-	long ret;
-
-	dev = file_priv->minor->dev;
-	ret = pm_runtime_get_sync(dev->dev);
-	if (ret < 0)
-		goto out;
-
-	ret = drm_ioctl(filp, cmd, arg);
-
-out:
-	pm_runtime_put_autosuspend(dev->dev);
-	return ret;
-}
-
 static const struct dev_pm_ops amdgpu_pm_ops = {
 	.prepare = pm_sleep_ptr(amdgpu_pmops_prepare),
 	.complete = pm_sleep_ptr(amdgpu_pmops_complete),
@@ -3070,12 +3051,12 @@ static const struct file_operations amdgpu_driver_kms_fops = {
 	.open = drm_open,
 	.flush = amdgpu_flush,
 	.release = amdgpu_drm_release,
-	.unlocked_ioctl = amdgpu_drm_ioctl,
+	.unlocked_ioctl = drm_ioctl,
 	.mmap = drm_gem_mmap,
 	.poll = drm_poll,
 	.read = drm_read,
 #ifdef CONFIG_COMPAT
-	.compat_ioctl = amdgpu_kms_compat_ioctl,
+	.compat_ioctl = drm_compat_ioctl,
 #endif
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo = drm_show_fdinfo,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
index 2d86cc6f7f4d..6b06c0956e48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
@@ -43,10 +43,4 @@
 
 extern const struct drm_driver amdgpu_partition_driver;
 
-long amdgpu_drm_ioctl(struct file *filp,
-		      unsigned int cmd, unsigned long arg);
-
-long amdgpu_kms_compat_ioctl(struct file *filp,
-			     unsigned int cmd, unsigned long arg);
-
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
deleted file mode 100644
index a1cbd7c3deb2..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * \file amdgpu_ioc32.c
- *
- * 32-bit ioctl compatibility routines for the AMDGPU DRM.
- *
- * \author Paul Mackerras <paulus@samba.org>
- *
- * Copyright (C) Paul Mackerras 2005
- * All Rights Reserved.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice (including the next
- * paragraph) shall be included in all copies or substantial portions of the
- * Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE AUTHOR BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
- * IN THE SOFTWARE.
- */
-#include <linux/compat.h>
-
-#include <drm/amdgpu_drm.h>
-#include <drm/drm_ioctl.h>
-
-#include "amdgpu_drv.h"
-
-long amdgpu_kms_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
-{
-	unsigned int nr = DRM_IOCTL_NR(cmd);
-
-	if (nr < DRM_COMMAND_BASE)
-		return drm_compat_ioctl(filp, cmd, arg);
-
-	return amdgpu_drm_ioctl(filp, cmd, arg);
-}
-- 
2.55.0

