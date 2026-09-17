Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72849C982D0
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 19:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E801D10F0D8;
	Thu, 17 Sep 2026 19:58:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EvNaWSaK";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7813310F0D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 19:58:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uj8G8ljJnJruBSY8SouxakjWryXfwV+UOmjoCuzRbDcD3Bg5PRjZ78XjYgDm2YTOh/16O+vBpiFCmhhDvIfaIwBZP4aIlOxWJQjdx6sJVu0O1xn6sZqsZvsKD99XLdZjm5zypkNSdn4Hc4MvXKGaWPzC52+ZlXJGwhKBjN1taBJx2SbQuCwjxaHvnEQu5E2hQ7Z1eKlrVm+FBiLhjZRfWC6omgGMW9ZxT+kbg5BQFVzRYn+aj0vE0VJG8wMWlEDljDoIFvjZNspG9baLRHxv+WbAruwZt7rbFNJIa01S/H7in9cXxFvUMfMHUmqhewjcf3rs//ydDHi5+0OBcPHTFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q77oxFGdMDFQsn4TkBA7pVB39o/cHCy67dOM4D3GIPc=;
 b=gjyrtzFrLDjpeeJPYvDEw2Bn4GAf7kNncf0ajBb5Nc/bjw62RahCgYU7/Ow4XBKrODR1LR1IWX4Lufp/jdg8OX08WcNQEotlr4AKqhnBLHk68+xs4x8eYCYjMeKeQ8iK3hohw1joIF3nud22HnwLKrZ5orLe/CokbRRRzuM0WAyiRwjCWP4W5EWMSPkf3VwDgNbX6xy83rphf7vpSaUCxF8Tf1aijuIT2WsHkRyl1+ic+UqLMcU6vuiKFjhdIc0MXXKwqqxa+llTBVlbkR8hUrdZlI/q+QwDKPoObf553B2vqVhBcdjC1i8jjz6do5acTOlrIeFIWj5XsXPVXxOaiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q77oxFGdMDFQsn4TkBA7pVB39o/cHCy67dOM4D3GIPc=;
 b=EvNaWSaKt+LbnytqhU65wIpTB8pwxq+PKGSoCjZuLZpckm1TDA1Gtn1BmzglASixkOh7cpz54apLtWUCyywMaSR2iO8TwxTLL8pDbw7BM7eofFIO8bgKwUszKKImgxmPXqOuIJwdgShgqaf78Uz+6PAgd9T4pNbwX63/mj3ys+8=
Received: from MN0PR04CA0009.namprd04.prod.outlook.com (2603:10b6:208:52d::30)
 by DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 19:58:34 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::22) by MN0PR04CA0009.outlook.office365.com
 (2603:10b6:208:52d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 19:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 19:58:32 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 14:58:25 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v2 7/8] drm/amdgpu: get rid of amdgpu_drm_ioctl
Date: Thu, 17 Sep 2026 15:58:08 -0400
Message-ID: <20260917195812.72917-8-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917195812.72917-1-shahyan.soltani@amd.com>
References: <20260917195812.72917-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DM4PR12MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ebfaf03-e8c0-4570-755b-08df14f60cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|11063799006|3023799007|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0kNsTGFFd7iUBwnXlmOVnehDRhVKGifa89hDWoE3kU2kMeKaZ3P63X0EXDxlBnGVkGkRChY8RcW7UR0YCcjzlrzOuA8BCdGS2SFglw5R9poJLuUU/RDfoDW/5Po9NzAeXurqPuFZNKQSWmySZ7W2/l1eQihou4pKPuea4O1uuCtx4bgBH0LIzf/MSr4mAHeE24YP+f3FPE+kqCmnV9cUZcNXm37e/gYR0m74My+SaqeOz9NhIoR7bR1bkEImAzWlD56LAgbjIeA3KCh5XNRJccBMEUaoTxjxqECPB+yyd1innSXhzN0SUlNNlL6bFhKPRKLlBeHg2/E2ncOtjfZ5Lk4zzzJwrN4KMxmb8f3hHKII1Bw3pkjTAH+WEvALmG4sosO0NLHPXKMRMV2A1ngv4A4IMefde5HrRYiz6I9fSrY1+d1cZ1g9FLjLQwdYYdZ83GWazuVgnkTDVWBFWS3/frwyzf1vNnVlXmUJM5s+3I87XXCAnRZnd24WJb/rzEI+0cvySfbGtlbrk+Jy3uf+tPiMvbF2G3/ftlWit7ZG7jdiSEyg70odw+MQFxygIdcQvMWYYGMb/R+gYGCeCZKzyhF46bBdMxpNtGb2vIYJUL7d0/gCPwK9PKPt4stYxWVy7A3UANdae2rXZ8Uh9aP69nhtBQT+dj+/KHd7uUTEzByTLocaadtNHsqeSgMBWaoxPS+zgZyXJRUVhWkjuBVpOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(11063799006)(3023799007)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IymEZ8isWnJIFErtSRz7jfHlzrdoKaIEkp30CG6L7sSj+5tiC8BZxmZXx5kIQplpi5KGHhCDAX/mjkElOWXyPvg37UOli8JjZSdQ4w/jPbJymMbtHzRxru7mLyS7qz3oP8bkOImOZp5d3IZVrjOtpY558Rf85krk1HqTYVndhBy7IUC8aa32cTwEZ8Ll8tgXT+55OarovGhwfrRangYVAykKqLE50lfDJ1ESrDLsUhI7pjv7QRjDyUfa9HU88mY2RRWr7AZdJV2AxsrTVU3IxMpiOFy1rDlB7r+o65jNmHjJt5ooWYgyNDIfrexMG1PrvQmpK2QUm4GeJSGG7b3BqaBlcDpm08sKMBhUcoySEyr6nBut08fB3lPOi7C297cxqxOc9jq1sfg+jKXwxpJy3XfHrhbYf1Uym/f6EK+/xxsc6/MrO9wQQizvLzFrJV8C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 19:58:32.0879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ebfaf03-e8c0-4570-755b-08df14f60cfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6637
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
v2 (Shahyan): Added commit description
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
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

