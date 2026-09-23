Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99DBC9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 289FD10F161;
	Wed, 23 Sep 2026 19:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5p+ugVdv";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 691C810F156
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIHhpveOWY9eCZYSk+MhWcQriyb2JJQrPxjcLqkmcQ2Mkto7RZ3zBuc/rD6/ufaSQPwe/LnneTqRLXYj53OFeZDy3B23Z7jxULjVXD8cJz6yvOx+SaQZvLNehOJPQF9l9nUTw5oOhBZna3NmKhuxdq7SJIsFXS46ntwkEJzWWRppRpGUlnMbI/xch/zmAGBsjc4N4d4jfHT4ofSVaJyHgecU/0j+Jh4ziEqfgPgpUAUgycPlkWA5DtOKU1ALvenRFRmLqYRewGxCFoZSQ8JWL/xaqA5dfLhOv8cxUuDvza6hr6QkvJvVrtwHzOtjHXMyEVYUk3R8T2ROPziRAjjmTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q77oxFGdMDFQsn4TkBA7pVB39o/cHCy67dOM4D3GIPc=;
 b=xL9ppRZb2SlsAj06Kl/aDkOYgAfH856QhME8ts64nt7F9J9Yr2aKlPAaDkSx6nLY9+nJHUxsXuHAqfXfN8WiqxMubxnCyog7QuMGB1vHOyltq5x2d3drEtShCEG0iYhwxTFdoknXac6NscHGzxaLNgdOp6Zq/5F72G5f5JyxFXyy2Y/K9ShRFv+jU7tg59u7YIS5rbkabhVY97xGc86k/qkVquZaiV6XioUWNaOu66EFY8dnvN8tGpCC4tN0EocViUrtbUj9idqFXr5WZD0fqdXEr4RP8Mb3FfFQa3yhg3k1X9PRJdOr8s1OgzOg2AqAkWzH1m4UBpDC5dL3TcR5Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q77oxFGdMDFQsn4TkBA7pVB39o/cHCy67dOM4D3GIPc=;
 b=5p+ugVdvjkIxu+0FiB2vHuK14iZ7ApBrL0bnYsT7ZI9C2pL88zWtH2VwOe5OCHVgW8i7AohPxXJZ8zgU/SAYzaD9R+886ffiPPbgIhyvhnrQAnZJnmV/vWCOzqdB0TJQpurCuMclJWct87GQBaaKLr4Zb4Kz55jV/lYTS8dzaKs=
Received: from SA9P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::24)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 19:34:26 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::2d) by SA9P223CA0019.outlook.office365.com
 (2603:10b6:806:26::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Wed,
 23 Sep 2026 19:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 19:34:26 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 14:34:21 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v3 07/10] drm/amdgpu: get rid of amdgpu_drm_ioctl
Date: Wed, 23 Sep 2026 15:33:43 -0400
Message-ID: <20260923193346.2292597-8-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923193346.2292597-1-shahyan.soltani@amd.com>
References: <20260923193346.2292597-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 90006f0c-53fb-4b46-221c-08df19a9ad84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|10067099003|56012099006|3023799007|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: TBbYrQtmCJN9PhnjIvtRW6CBSreqnImrRr+F14MsE35ODSbcaJGgkqBNmytX2FBbs1AOMxxS5RLRnmPGXbg/Xag/UbKWsbc1IAj65tWNokFIjMW62EK/euBI3qi7aiO+jjHvnOeklRlf2WWEabMzPWoVYUweBaWOT9pggyfWZ7hSk01RNrs0Rg8kzqoKbajXF/KwQnR2hugteWj6rhiiva52mY+8d8mZuIQHpMlkpcRb/pANKfC6HqFniPykoxIdI7x22Gi4pOD1KGcAa9MhD2mZ7+uImgs669v+2hAYwLcErmKwar3XDC7D0Qb7KdijjXWIZsnop4UymSFhN4iz+4LFX/QogVHEuqEHTD8aS6d/2i1AgslHF0JY/ALl34vie6ryhC8HphXJUrPAMOtCz+fq1qU1cpZpMX7O+Pnuh2vtsTD/o6AS0yT9xXj3skDZracFJAJ+zhO2h6kc+r8UemSO5FwxkSvu4Vavgax1vIiyrxoqbC5QgcFftEYJmRPuGhlP6AU7cvkAbBhmsYl0jHt9Ue6oaB9fSfgc+YKIDGVVNE4tBOgyKlIaMp4rNhfJ8LHU2KNWQ8G/9w3G0321rem5Wmf0yPonNp2gDEfiuJJKRaC6Ath8LZIMkfmBJuqxR89ojMkZ7x6dVg5e4sgamlkS+rz/KpSLZkEqXvEf+nBEN2AMrXN4Ay68tPxgpMd6SJV+yQL0zXDYcW/CWevK/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5luU0B1fxDXqq/201iXe0UJbT1iWhM2G7tHuPfUSpFM1jUcT+WDH/bHeg4/BzoGiaaET/ebUeP4+Gz3nTpO6AgvX8rabQg0VcjhvvyIgUQg0Or6pPBDEEt2WtxnlMDvoMf1dc/ArQNFIIDljX6irZVpr1smaVWfdEgRSvoJR3516NM5NIUwVZeiXh0cmG0an1YiJBJkPzvExErrNrPQM6S4L/8x5u9ZummYn9mz1KUr8VHTEktEH0MNWBHaqivEvjo08LRx/bYc0TgmGERpubBNsjzazQM7Qgye/19d9ftNinwK/13nTgB1BE3flkSzlmx2/fxEz0GB3Ow3xsUf0iKfNwSwsbtQxPUkri9a/A7Otk6qx1tTx+eU1WNjZJI7qFP0Udm+mFUGcZvlRnxGUFsgPaiZ6zMDB4HcPx0twAZPBc2CGQo3cvg9o8izuS6gp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:34:26.0523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90006f0c-53fb-4b46-221c-08df19a9ad84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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

