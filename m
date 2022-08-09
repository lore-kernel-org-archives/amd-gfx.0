Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D590CC19F2D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 15:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4544DA6C0;
	Tue,  9 Aug 2022 15:10:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B55BDA633
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 15:10:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MK7sYneXgLs1VVfymFz27Yes94WinAdn5t6iYCOJnw+0n+7tYFMKSS16eneFFFnpFn7haavOuSGYG8MIAW+XwQFOjMxnoppty1spZAlFPSbW8iEhQluanXx52e3Zuotsg1n+IOURo4kWOMKvmZoKkUMKzOEG4CfmpUwe1v85DwevMqLAS18fPYEy8O6kYdaZOdzJcq4Ai2Ts5/t2ifeWg5hpHmHaQ3Bfw95aqpdANtDtc3m7LN0j2Crms42AptLzK5NrvN4V1NxDWcg1f3v4fdcWDM5pbVDd57YV6Zycp38IBRxvpGCh6l81sydAeLvpcTE6X7Wd08lvi6vyzWrP3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIjY9CZ71CAh79MNHLciyAW0T7U9gDZ0RXuFZXlw6bM=;
 b=KCZ91oET75oUT+8PrC/UwDvj1Ha/smpX1iGiQ8e9Lw2i8JufVfiqAQx/a2ZyUGfiPZu4oBoZCwWkNSEHzPFs7JkDyAG9o57Eyz45EsHY8wd7dI+saqIlbeLo6brEgxllLV8NUmcHWkxmcX+ZSWXqeNBtq6hEYwcsVGHuYeCFwDRqyGb7kgktRRAgidUhF/BNUwyfBfF4mAxGq7rtcUIM78y1uOJG+4iH88To49BwsEYMmh+G7o1QFirwYj5XE5fVB2+z7DJRj7+CI8oxYe+cQ5nTq8tDegwAk4mxbAfXdVemtRsotat2RX2lAFZikphLNrTIg/pU4yrymFmb1PMl4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIjY9CZ71CAh79MNHLciyAW0T7U9gDZ0RXuFZXlw6bM=;
 b=GIfyHzmV9DgpC9SdjUaMM03pcLydcFrIr+tf4HPC4pH4J7jGjHT5PhyqZ7LmzR5RR3s457Jra+/Y1dmBo/7Cw2KvB0x9hMlEy4zUwGc/GW9ujp+BH9HhmhYdRRStwKJPAPozEYwLIEiCOKo3wYNkeDjHxX7uI1HS2N//4KFd/Nc=
Received: from DM6PR06CA0076.namprd06.prod.outlook.com (2603:10b6:5:336::9) by
 CY4PR1201MB0215.namprd12.prod.outlook.com (2603:10b6:910:1d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.19; Tue, 9 Aug
 2022 15:10:11 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::30) by DM6PR06CA0076.outlook.office365.com
 (2603:10b6:5:336::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17 via Frontend
 Transport; Tue, 9 Aug 2022 15:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 15:10:11 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 9 Aug
 2022 10:10:07 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] Revert "drm/amdgpu: use generic fb helpers instead of
 setting up AMD own's."
Date: Tue, 9 Aug 2022 10:10:08 -0500
Message-ID: <20220809151008.20376-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809151008.20376-1-mario.limonciello@amd.com>
References: <20220809151008.20376-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9c32d9c-a581-4d64-8523-08da7a19414e
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0215:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wtEpUNAzihiV5FQip7HtGvqX6wYU24NOjQqsArjzAgtbyp4DQIggBYStltZBGKCM1AbK937t1uYnk7ZP1/WTKSkR/zH36Foj/LxeD3hISOhfSgF3wqR7uT6vI9g2lbusAaS3QDpZttOciPwp7iXO2TFSty3zpuxS9edGZYJneF9nW7cf3vEz3fhmrNQGSDZ280E876bNeB+4RAWc9a9OcU9vdLPGQGvb7BHPtnp9yVQwm2Z2XWgREZXBIrBZHQfteiuFwObVFJlcUaNrtt7HjqqwvmB2d9de/y3ta0IVDyjm0iU8WGbmZyta+H+ZBJ/xMiAlcPX0NOGZRBaSPsQ5vwJsrBKPexnOMg55FAFu2bKzz8Zg0C3VrADEYI4akD9wO4tFcUErcy4rWO/eymAp6XBCDnBwGVGvEJFO6wAgJZf73DdtsUhc1sZddngvnaL9lyHFWpH38vD7MrHE2D2dsa5EfMBsumMlr5yUEjr5ixuUoF+5spynWLqvLuYOCBbXvYGzs04jPveek2zuqKZrXh3YbxBSkCg+yuI0bgCeUybThTSyCeOKq0Eo0pykjucefzyzinAbeuWPlZ0XQwdn5SeZs9q7uK8gWujNKgRAtRsANm7BGqE5kLskRNxIalmKBsBYNWp274KeNbfUDsDzJQAayOAAIL8DOdpmm5Tw88lDOgbHgTMKs9vOj5xGKaDBRQN0SEgxm6sV3JTZfZQqi8CrS4PbihDlTH4YxWwq8JFRksP7eiELDbkNRdTjqecgFXJt/82Do5v6R3ndRWDFekWw16y32cOILRDtFZrZUw1N+T3IsN2YbLL6Vxkcllnv5xcdoloSoVk3nj9QBh82jSybntV2dl0/1A3N6DpikITHXzfjm9/1/6OGR4V4Ld45yIJ00yDQ6g3z4KAqWOiu4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966006)(40470700004)(36840700001)(26005)(40480700001)(8936002)(82310400005)(44832011)(2906002)(30864003)(966005)(86362001)(36756003)(2616005)(1076003)(16526019)(336012)(186003)(47076005)(54906003)(7696005)(41300700001)(478600001)(356005)(82740400003)(81166007)(83380400001)(5660300002)(70586007)(40460700003)(6916009)(316002)(70206006)(4326008)(426003)(36860700001)(8676002)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 15:10:11.3688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c32d9c-a581-4d64-8523-08da7a19414e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0215
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
Cc: Alexander.Deucher@amd.com, h.judt@gmx.at, Renjith.Pananchikkal@amd.com,
 Evan.Quan@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Although preferable to use the generic fb helpers there is an underlying issue
that causes problems for S4 that isn't yet identified.  As the workaround for
the S4 issue caused other problems for S3, revert the change to generic fb helpers.

If/when that underlying issue is identified switching back to generic fb helpers
can be brought back in for amdgpu.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216119
Fixes: 087451f372bf ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's.")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  13 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c      | 388 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |  30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    |  20 +
 7 files changed, 426 insertions(+), 50 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 4bde7ff55f8a..224d2dca2b7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -45,7 +45,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_atombios.o atombios_crtc.o amdgpu_connectors.o \
 	atom.o amdgpu_fence.o amdgpu_ttm.o amdgpu_object.o amdgpu_gart.o \
 	amdgpu_encoders.o amdgpu_display.o amdgpu_i2c.o \
-	amdgpu_gem.o amdgpu_ring.o \
+	amdgpu_fb.o amdgpu_gem.o amdgpu_ring.o \
 	amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
 	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
 	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c84fdef0ac45..a14e2c98d324 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3795,6 +3795,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* Get a log2 for easy divisions. */
 	adev->mm_stats.log2_max_MBps = ilog2(max(1u, max_MBps));
 
+	amdgpu_fbdev_init(adev);
+
 	r = amdgpu_pm_sysfs_init(adev);
 	if (r) {
 		adev->pm_sysfs_en = false;
@@ -3956,6 +3958,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	/* disable ras feature must before hw fini */
 	amdgpu_ras_pre_fini(adev);
 
+	amdgpu_fbdev_fini(adev);
+
 	amdgpu_device_ip_fini_early(adev);
 
 	amdgpu_irq_fini_hw(adev);
@@ -4066,7 +4070,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	drm_kms_helper_poll_disable(dev);
 
 	if (fbcon)
-		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, true);
+		amdgpu_fbdev_set_suspend(adev, 1);
 
 	cancel_delayed_work_sync(&adev->delayed_init_work);
 
@@ -4138,7 +4142,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	flush_delayed_work(&adev->delayed_init_work);
 
 	if (fbcon)
-		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, false);
+		amdgpu_fbdev_set_suspend(adev, 0);
 
 	drm_kms_helper_poll_enable(dev);
 
@@ -4856,7 +4860,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				if (r)
 					goto out;
 
-				drm_fb_helper_set_suspend_unlocked(adev_to_drm(tmp_adev)->fb_helper, false);
+				amdgpu_fbdev_set_suspend(tmp_adev, 0);
 
 				/*
 				 * The GPU enters bad state once faulty pages
@@ -5203,7 +5207,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		 */
 		amdgpu_unregister_gpu_instance(tmp_adev);
 
-		drm_fb_helper_set_suspend_unlocked(adev_to_drm(tmp_adev)->fb_helper, true);
+		amdgpu_fbdev_set_suspend(tmp_adev, 1);
 
 		/* disable ras on ALL IPs */
 		if (!need_emergency_restart &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 92281e57f3ac..eea6f8e34850 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1619,10 +1619,13 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 			continue;
 		}
 		robj = gem_to_amdgpu_bo(fb->obj[0]);
-		r = amdgpu_bo_reserve(robj, true);
-		if (r == 0) {
-			amdgpu_bo_unpin(robj);
-			amdgpu_bo_unreserve(robj);
+		/* don't unpin kernel fb objects */
+		if (!amdgpu_fbdev_robj_is_fb(adev, robj)) {
+			r = amdgpu_bo_reserve(robj, true);
+			if (r == 0) {
+				amdgpu_bo_unpin(robj);
+				amdgpu_bo_unreserve(robj);
+			}
 		}
 	}
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 429fcdf28836..74c246e9d1b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2109,19 +2109,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		goto err_pci;
 	}
 
-	/*
-	 * 1. don't init fbdev on hw without DCE
-	 * 2. don't init fbdev if there are no connectors
-	 */
-	if (adev->mode_info.mode_config_initialized &&
-	    !list_empty(&adev_to_drm(adev)->mode_config.connector_list)) {
-		/* select 8 bpp console on low vram cards */
-		if (adev->gmc.real_vram_size <= (32*1024*1024))
-			drm_fbdev_generic_setup(adev_to_drm(adev), 8);
-		else
-			drm_fbdev_generic_setup(adev_to_drm(adev), 32);
-	}
-
 	ret = amdgpu_debugfs_init(adev);
 	if (ret)
 		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
new file mode 100644
index 000000000000..cd0acbea75da
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -0,0 +1,388 @@
+/*
+ * Copyright © 2007 David Airlie
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ *
+ * Authors:
+ *     David Airlie
+ */
+
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/vga_switcheroo.h>
+
+#include <drm/amdgpu_drm.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_fourcc.h>
+
+#include "amdgpu.h"
+#include "cikd.h"
+#include "amdgpu_gem.h"
+
+#include "amdgpu_display.h"
+
+/* object hierarchy -
+   this contains a helper + a amdgpu fb
+   the helper contains a pointer to amdgpu framebuffer baseclass.
+*/
+
+static int
+amdgpufb_open(struct fb_info *info, int user)
+{
+	struct drm_fb_helper *fb_helper = info->par;
+	int ret = pm_runtime_get_sync(fb_helper->dev->dev);
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_mark_last_busy(fb_helper->dev->dev);
+		pm_runtime_put_autosuspend(fb_helper->dev->dev);
+		return ret;
+	}
+	return 0;
+}
+
+static int
+amdgpufb_release(struct fb_info *info, int user)
+{
+	struct drm_fb_helper *fb_helper = info->par;
+
+	pm_runtime_mark_last_busy(fb_helper->dev->dev);
+	pm_runtime_put_autosuspend(fb_helper->dev->dev);
+	return 0;
+}
+
+static const struct fb_ops amdgpufb_ops = {
+	.owner = THIS_MODULE,
+	DRM_FB_HELPER_DEFAULT_OPS,
+	.fb_open = amdgpufb_open,
+	.fb_release = amdgpufb_release,
+	.fb_fillrect = drm_fb_helper_cfb_fillrect,
+	.fb_copyarea = drm_fb_helper_cfb_copyarea,
+	.fb_imageblit = drm_fb_helper_cfb_imageblit,
+};
+
+
+int amdgpu_align_pitch(struct amdgpu_device *adev, int width, int cpp, bool tiled)
+{
+	int aligned = width;
+	int pitch_mask = 0;
+
+	switch (cpp) {
+	case 1:
+		pitch_mask = 255;
+		break;
+	case 2:
+		pitch_mask = 127;
+		break;
+	case 3:
+	case 4:
+		pitch_mask = 63;
+		break;
+	}
+
+	aligned += pitch_mask;
+	aligned &= ~pitch_mask;
+	return aligned * cpp;
+}
+
+static void amdgpufb_destroy_pinned_object(struct drm_gem_object *gobj)
+{
+	struct amdgpu_bo *abo = gem_to_amdgpu_bo(gobj);
+	int ret;
+
+	ret = amdgpu_bo_reserve(abo, true);
+	if (likely(ret == 0)) {
+		amdgpu_bo_kunmap(abo);
+		amdgpu_bo_unpin(abo);
+		amdgpu_bo_unreserve(abo);
+	}
+	drm_gem_object_put(gobj);
+}
+
+static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
+					 struct drm_mode_fb_cmd2 *mode_cmd,
+					 struct drm_gem_object **gobj_p)
+{
+	const struct drm_format_info *info;
+	struct amdgpu_device *adev = rfbdev->adev;
+	struct drm_gem_object *gobj = NULL;
+	struct amdgpu_bo *abo = NULL;
+	bool fb_tiled = false; /* useful for testing */
+	u32 tiling_flags = 0, domain;
+	int ret;
+	int aligned_size, size;
+	int height = mode_cmd->height;
+	u32 cpp;
+	u64 flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
+			       AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS     |
+			       AMDGPU_GEM_CREATE_VRAM_CLEARED;
+
+	info = drm_get_format_info(adev_to_drm(adev), mode_cmd);
+	cpp = info->cpp[0];
+
+	/* need to align pitch with crtc limits */
+	mode_cmd->pitches[0] = amdgpu_align_pitch(adev, mode_cmd->width, cpp,
+						  fb_tiled);
+	domain = amdgpu_display_supported_domains(adev, flags);
+	height = ALIGN(mode_cmd->height, 8);
+	size = mode_cmd->pitches[0] * height;
+	aligned_size = ALIGN(size, PAGE_SIZE);
+	ret = amdgpu_gem_object_create(adev, aligned_size, 0, domain, flags,
+				       ttm_bo_type_device, NULL, &gobj);
+	if (ret) {
+		pr_err("failed to allocate framebuffer (%d)\n", aligned_size);
+		return -ENOMEM;
+	}
+	abo = gem_to_amdgpu_bo(gobj);
+
+	if (fb_tiled)
+		tiling_flags = AMDGPU_TILING_SET(ARRAY_MODE, GRPH_ARRAY_2D_TILED_THIN1);
+
+	ret = amdgpu_bo_reserve(abo, false);
+	if (unlikely(ret != 0))
+		goto out_unref;
+
+	if (tiling_flags) {
+		ret = amdgpu_bo_set_tiling_flags(abo,
+						 tiling_flags);
+		if (ret)
+			dev_err(adev->dev, "FB failed to set tiling flags\n");
+	}
+
+	ret = amdgpu_bo_pin(abo, domain);
+	if (ret) {
+		amdgpu_bo_unreserve(abo);
+		goto out_unref;
+	}
+
+	ret = amdgpu_ttm_alloc_gart(&abo->tbo);
+	if (ret) {
+		amdgpu_bo_unreserve(abo);
+		dev_err(adev->dev, "%p bind failed\n", abo);
+		goto out_unref;
+	}
+
+	ret = amdgpu_bo_kmap(abo, NULL);
+	amdgpu_bo_unreserve(abo);
+	if (ret) {
+		goto out_unref;
+	}
+
+	*gobj_p = gobj;
+	return 0;
+out_unref:
+	amdgpufb_destroy_pinned_object(gobj);
+	*gobj_p = NULL;
+	return ret;
+}
+
+static int amdgpufb_create(struct drm_fb_helper *helper,
+			   struct drm_fb_helper_surface_size *sizes)
+{
+	struct amdgpu_fbdev *rfbdev = (struct amdgpu_fbdev *)helper;
+	struct amdgpu_device *adev = rfbdev->adev;
+	struct fb_info *info;
+	struct drm_framebuffer *fb = NULL;
+	struct drm_mode_fb_cmd2 mode_cmd;
+	struct drm_gem_object *gobj = NULL;
+	struct amdgpu_bo *abo = NULL;
+	int ret;
+
+	memset(&mode_cmd, 0, sizeof(mode_cmd));
+	mode_cmd.width = sizes->surface_width;
+	mode_cmd.height = sizes->surface_height;
+
+	if (sizes->surface_bpp == 24)
+		sizes->surface_bpp = 32;
+
+	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
+							  sizes->surface_depth);
+
+	ret = amdgpufb_create_pinned_object(rfbdev, &mode_cmd, &gobj);
+	if (ret) {
+		DRM_ERROR("failed to create fbcon object %d\n", ret);
+		return ret;
+	}
+
+	abo = gem_to_amdgpu_bo(gobj);
+
+	/* okay we have an object now allocate the framebuffer */
+	info = drm_fb_helper_alloc_fbi(helper);
+	if (IS_ERR(info)) {
+		ret = PTR_ERR(info);
+		goto out;
+	}
+
+	ret = amdgpu_display_gem_fb_init(adev_to_drm(adev), &rfbdev->rfb,
+					 &mode_cmd, gobj);
+	if (ret) {
+		DRM_ERROR("failed to initialize framebuffer %d\n", ret);
+		goto out;
+	}
+
+	fb = &rfbdev->rfb.base;
+
+	/* setup helper */
+	rfbdev->helper.fb = fb;
+
+	info->fbops = &amdgpufb_ops;
+
+	info->fix.smem_start = amdgpu_gmc_vram_cpu_pa(adev, abo);
+	info->fix.smem_len = amdgpu_bo_size(abo);
+	info->screen_base = amdgpu_bo_kptr(abo);
+	info->screen_size = amdgpu_bo_size(abo);
+
+	drm_fb_helper_fill_info(info, &rfbdev->helper, sizes);
+
+	/* setup aperture base/size for vesafb takeover */
+	info->apertures->ranges[0].base = adev_to_drm(adev)->mode_config.fb_base;
+	info->apertures->ranges[0].size = adev->gmc.aper_size;
+
+	/* Use default scratch pixmap (info->pixmap.flags = FB_PIXMAP_SYSTEM) */
+
+	if (info->screen_base == NULL) {
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	DRM_INFO("fb mappable at 0x%lX\n",  info->fix.smem_start);
+	DRM_INFO("vram apper at 0x%lX\n",  (unsigned long)adev->gmc.aper_base);
+	DRM_INFO("size %lu\n", (unsigned long)amdgpu_bo_size(abo));
+	DRM_INFO("fb depth is %d\n", fb->format->depth);
+	DRM_INFO("   pitch is %d\n", fb->pitches[0]);
+
+	vga_switcheroo_client_fb_set(adev->pdev, info);
+	return 0;
+
+out:
+	if (fb && ret) {
+		drm_gem_object_put(gobj);
+		drm_framebuffer_unregister_private(fb);
+		drm_framebuffer_cleanup(fb);
+		kfree(fb);
+	}
+	return ret;
+}
+
+static int amdgpu_fbdev_destroy(struct drm_device *dev, struct amdgpu_fbdev *rfbdev)
+{
+	struct amdgpu_framebuffer *rfb = &rfbdev->rfb;
+	int i;
+
+	drm_fb_helper_unregister_fbi(&rfbdev->helper);
+
+	if (rfb->base.obj[0]) {
+		for (i = 0; i < rfb->base.format->num_planes; i++)
+			drm_gem_object_put(rfb->base.obj[0]);
+		amdgpufb_destroy_pinned_object(rfb->base.obj[0]);
+		rfb->base.obj[0] = NULL;
+		drm_framebuffer_unregister_private(&rfb->base);
+		drm_framebuffer_cleanup(&rfb->base);
+	}
+	drm_fb_helper_fini(&rfbdev->helper);
+
+	return 0;
+}
+
+static const struct drm_fb_helper_funcs amdgpu_fb_helper_funcs = {
+	.fb_probe = amdgpufb_create,
+};
+
+int amdgpu_fbdev_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_fbdev *rfbdev;
+	int bpp_sel = 32;
+	int ret;
+
+	/* don't init fbdev on hw without DCE */
+	if (!adev->mode_info.mode_config_initialized)
+		return 0;
+
+	/* don't init fbdev if there are no connectors */
+	if (list_empty(&adev_to_drm(adev)->mode_config.connector_list))
+		return 0;
+
+	/* select 8 bpp console on low vram cards */
+	if (adev->gmc.real_vram_size <= (32*1024*1024))
+		bpp_sel = 8;
+
+	rfbdev = kzalloc(sizeof(struct amdgpu_fbdev), GFP_KERNEL);
+	if (!rfbdev)
+		return -ENOMEM;
+
+	rfbdev->adev = adev;
+	adev->mode_info.rfbdev = rfbdev;
+
+	drm_fb_helper_prepare(adev_to_drm(adev), &rfbdev->helper,
+			      &amdgpu_fb_helper_funcs);
+
+	ret = drm_fb_helper_init(adev_to_drm(adev), &rfbdev->helper);
+	if (ret) {
+		kfree(rfbdev);
+		return ret;
+	}
+
+	/* disable all the possible outputs/crtcs before entering KMS mode */
+	if (!amdgpu_device_has_dc_support(adev) && !amdgpu_virtual_display)
+		drm_helper_disable_unused_functions(adev_to_drm(adev));
+
+	drm_fb_helper_initial_config(&rfbdev->helper, bpp_sel);
+	return 0;
+}
+
+void amdgpu_fbdev_fini(struct amdgpu_device *adev)
+{
+	if (!adev->mode_info.rfbdev)
+		return;
+
+	amdgpu_fbdev_destroy(adev_to_drm(adev), adev->mode_info.rfbdev);
+	kfree(adev->mode_info.rfbdev);
+	adev->mode_info.rfbdev = NULL;
+}
+
+void amdgpu_fbdev_set_suspend(struct amdgpu_device *adev, int state)
+{
+	if (adev->mode_info.rfbdev)
+		drm_fb_helper_set_suspend_unlocked(&adev->mode_info.rfbdev->helper,
+						   state);
+}
+
+int amdgpu_fbdev_total_size(struct amdgpu_device *adev)
+{
+	struct amdgpu_bo *robj;
+	int size = 0;
+
+	if (!adev->mode_info.rfbdev)
+		return 0;
+
+	robj = gem_to_amdgpu_bo(adev->mode_info.rfbdev->rfb.base.obj[0]);
+	size += amdgpu_bo_size(robj);
+	return size;
+}
+
+bool amdgpu_fbdev_robj_is_fb(struct amdgpu_device *adev, struct amdgpu_bo *robj)
+{
+	if (!adev->mode_info.rfbdev)
+		return false;
+	if (robj == gem_to_amdgpu_bo(adev->mode_info.rfbdev->rfb.base.obj[0]))
+		return true;
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 8ef31d687ef3..6603fb7f30ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -875,32 +875,6 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
-static int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
-				  int width,
-				  int cpp,
-				  bool tiled)
-{
-	int aligned = width;
-	int pitch_mask = 0;
-
-	switch (cpp) {
-	case 1:
-		pitch_mask = 255;
-		break;
-	case 2:
-		pitch_mask = 127;
-		break;
-	case 3:
-	case 4:
-		pitch_mask = 63;
-		break;
-	}
-
-	aligned += pitch_mask;
-	aligned &= ~pitch_mask;
-	return aligned * cpp;
-}
-
 int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 			    struct drm_device *dev,
 			    struct drm_mode_create_dumb *args)
@@ -922,8 +896,8 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 	if (adev->mman.buffer_funcs_enabled)
 		flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
 
-	args->pitch = amdgpu_gem_align_pitch(adev, args->width,
-					     DIV_ROUND_UP(args->bpp, 8), 0);
+	args->pitch = amdgpu_align_pitch(adev, args->width,
+					 DIV_ROUND_UP(args->bpp, 8), 0);
 	args->size = (u64)args->pitch * args->height;
 	args->size = ALIGN(args->size, PAGE_SIZE);
 	domain = amdgpu_bo_get_preferred_domain(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index fb120abeec96..bca31b867cfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -232,6 +232,8 @@ struct amdgpu_i2c_chan {
 	struct mutex mutex;
 };
 
+struct amdgpu_fbdev;
+
 struct amdgpu_afmt {
 	bool enabled;
 	int offset;
@@ -307,6 +309,13 @@ struct amdgpu_framebuffer {
 	uint64_t address;
 };
 
+struct amdgpu_fbdev {
+	struct drm_fb_helper helper;
+	struct amdgpu_framebuffer rfb;
+	struct list_head fbdev_list;
+	struct amdgpu_device *adev;
+};
+
 struct amdgpu_mode_info {
 	struct atom_context *atom_context;
 	struct card_info *atom_card_info;
@@ -332,6 +341,8 @@ struct amdgpu_mode_info {
 	struct edid *bios_hardcoded_edid;
 	int bios_hardcoded_edid_size;
 
+	/* pointer to fbdev info structure */
+	struct amdgpu_fbdev *rfbdev;
 	/* firmware flags */
 	u32 firmware_flags;
 	/* pointer to backlight encoder */
@@ -609,6 +620,15 @@ bool amdgpu_crtc_get_scanout_position(struct drm_crtc *crtc,
 			int *hpos, ktime_t *stime, ktime_t *etime,
 			const struct drm_display_mode *mode);
 
+/* fbdev layer */
+int amdgpu_fbdev_init(struct amdgpu_device *adev);
+void amdgpu_fbdev_fini(struct amdgpu_device *adev);
+void amdgpu_fbdev_set_suspend(struct amdgpu_device *adev, int state);
+int amdgpu_fbdev_total_size(struct amdgpu_device *adev);
+bool amdgpu_fbdev_robj_is_fb(struct amdgpu_device *adev, struct amdgpu_bo *robj);
+
+int amdgpu_align_pitch(struct amdgpu_device *adev, int width, int bpp, bool tiled);
+
 /* amdgpu_display.c */
 void amdgpu_display_print_display_setup(struct drm_device *dev);
 int amdgpu_display_modeset_create_props(struct amdgpu_device *adev);
-- 
2.34.1

