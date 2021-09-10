Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C93DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 03:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D78C61074
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 03:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D78C61074
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44D746E95A;
	Fri, 10 Sep 2021 03:25:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04A4D6E95A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 03:25:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3owMi/+kuDmjNfPtOiEleq4SBNa7wEmCQU4SXGyWzqtquHZezlRmeuX9J7noVkttpv3Dzim7J8FJtwhGLl2OqV6hlmeYBz5pkXw4UqVQwjOTgUbXNPQb2ddnshLvUiMv/jqL828UVEfs/TSfF/LRc5WEvognu/uUYYoxeYybt63Lofnzm/Z1MwNBzFn55Ykccn5CMgocpOapx/mQypNd6wLolr9QWiSnnK1iZPREYNn9aaojbOkZ/KAluQOz7uL0tlJz0nQkc+Rj17H/C8bxr6pfXJdw6wR+XoIjBdr32dPzjupBw6n6v4PCUV0SYPAUAd0pDZ8gHK8Y0gGeaHWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=iQEQEtV90HU5wjOGVNTkOnNgLZ4AdLZx713v8pBzyJo=;
 b=Z/x8coxYbLironxO8xdN64J89VpO616YLH8dcZBTz1mGpnJ6FyyeuezXTZ4YqTnY8CslkgGWuHCS5o6GgJmBGUkzE6IWZjzgBNFE2wooNwqmbDQy7/oG8DpAjzsXw/MYD0oIDz8EH/PujzLq43FN9KgXXuzYkBKAstffYjuDsV5KykejuTa15glKyMFTqbyo44FwyXN+zp84Nd29ObPLrALz+6e5Puh8eykSSdqwYejNspo7tV/uqDJBftWz9CyYDeugFPnrlEkJ6We9QQ+2JKYM17PL2P6hp8wiaIPhLafP6B8/4g8YOggTy29XAnbubuVYr6rRiXnbjcIxQZiQkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQEQEtV90HU5wjOGVNTkOnNgLZ4AdLZx713v8pBzyJo=;
 b=AGrirWGOm+T9Ug78Rg3pVOz1JP4t7zlKuWnR/jTcRB0Dzy0jURyibFwKM3wDTpeUpUIyewVayT2dRdBMUlUKjTbEikyHG7kcJOumXtMNiINdHYPbtE4wFq497Wk9yyStwoU1hMtDcdCsImd3FyAmLwVyXzSQasOhtXjUIwkD88k=
Received: from BN9PR03CA0328.namprd03.prod.outlook.com (2603:10b6:408:112::33)
 by CY4PR1201MB0166.namprd12.prod.outlook.com (2603:10b6:910:24::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Fri, 10 Sep
 2021 03:25:49 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::f0) by BN9PR03CA0328.outlook.office365.com
 (2603:10b6:408:112::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend
 Transport; Fri, 10 Sep 2021 03:25:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 03:25:48 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 22:25:46 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <tzimmermann@suse.de>, Evan Quan
 <evan.quan@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: use generic fb helpers instead of setting up AMD
 own's.
Date: Fri, 10 Sep 2021 11:25:30 +0800
Message-ID: <20210910032530.725067-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64563abc-b1c6-47ba-a218-08d9740aaf45
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0166:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01660341E9519056E2C59B71E4D69@CY4PR1201MB0166.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z3WhsKEaEpvlA5BdmwiFBlOphmYsd/eh48cjNZKc9+9q7d6jTr/CA9EGkhkJ6m0fDy2PZO4xCCoCPMyqHODU6hvX6eSyb5UGAhPzLeITAeScftv9u/Dk19wNzAiHasGS9oIsilu+verYIzY7GZy1d08mOsYHWvDnP6ZTC0oQk1f3IL4p9c3Fr+NqlKT9/bF88/Zdv2S8HdWBVoy/63ERGNZReshUDwrqgFBvtE2F3retd2taU+NG21RdepA2keYajebhQgliPtfA6v9lbgwR9I4JFpJKgbRyw3w13xtyEO1fGJIZybp81xIuvInZwBkieWEiM2flMaoMlOxyykV3jYlYKelnaBoiGOduHjg38DzycaHvGzZ8M+5uzmPutA6oh+5M4ddcEcBl7jHgacgsf6xrUS69u5GjryM5sZ3owYBLMJPkJsVOfUJb0YsCCMGQjvqLNXfQx5jPVUIWOEPjXfmfgKRX0O07hKA9WoguxjcVyDrnvg3nasxPg/YlykWGPX8bfEF8VLB8TB1EtSsZmPyYs985DvTPvcqISoKIJHiQ9P6Q40oiu6OJN0n32goyk/cqa0BHIN14c3h0RncfHJCAj3XsGE0GVpkpJ0E0BHpqI8Vmr3+6BFf0M5erjXetqCpS4FGI3eW6bImKXlTNzoyv5jj0EEz/+aPJR+rL9M50d/Q3Q0T+IMa7H4MfZB+o7mCCFGi1IjsRzj0m1F0mA4Pr3InCa9AcvI9n43XdtXeNfllyT+YP22BecLDhScepCsUk31etL94k3MH00LSJfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(36840700001)(46966006)(6916009)(70206006)(70586007)(6666004)(54906003)(4326008)(478600001)(8936002)(82310400003)(86362001)(16526019)(44832011)(2906002)(30864003)(36756003)(7696005)(8676002)(186003)(1076003)(426003)(316002)(66574015)(47076005)(5660300002)(82740400003)(356005)(2616005)(26005)(81166007)(83380400001)(36860700001)(336012)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 03:25:48.8277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64563abc-b1c6-47ba-a218-08d9740aaf45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0166
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

With the shadow buffer support from generic framebuffer emulation, it's
possible now to have runpm kicked when no update for console.

Change-Id: I285472c9100ee6f649d3f3f3548f402b9cd34eaf
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
--
v1->v2:
  - rename amdgpu_align_pitch as amdgpu_gem_align_pitch to align with
    other APIs from the same file (Alex)
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c      | 388 --------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |  30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    |  20 -
 7 files changed, 50 insertions(+), 426 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 8d0748184a14..73a2151ee43f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -45,7 +45,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_atombios.o atombios_crtc.o amdgpu_connectors.o \
 	atom.o amdgpu_fence.o amdgpu_ttm.o amdgpu_object.o amdgpu_gart.o \
 	amdgpu_encoders.o amdgpu_display.o amdgpu_i2c.o \
-	amdgpu_fb.o amdgpu_gem.o amdgpu_ring.o \
+	amdgpu_gem.o amdgpu_ring.o \
 	amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o amdgpu_test.o \
 	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
 	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 682d459e992a..bcc308b7f826 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3695,8 +3695,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* Get a log2 for easy divisions. */
 	adev->mm_stats.log2_max_MBps = ilog2(max(1u, max_MBps));
 
-	amdgpu_fbdev_init(adev);
-
 	r = amdgpu_pm_sysfs_init(adev);
 	if (r) {
 		adev->pm_sysfs_en = false;
@@ -3854,8 +3852,6 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 		amdgpu_ucode_sysfs_fini(adev);
 	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
 
-	amdgpu_fbdev_fini(adev);
-
 	amdgpu_irq_fini_hw(adev);
 
 	amdgpu_device_ip_fini_early(adev);
@@ -3931,7 +3927,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	drm_kms_helper_poll_disable(dev);
 
 	if (fbcon)
-		amdgpu_fbdev_set_suspend(adev, 1);
+		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, true);
 
 	cancel_delayed_work_sync(&adev->delayed_init_work);
 
@@ -4009,7 +4005,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	flush_delayed_work(&adev->delayed_init_work);
 
 	if (fbcon)
-		amdgpu_fbdev_set_suspend(adev, 0);
+		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, false);
 
 	drm_kms_helper_poll_enable(dev);
 
@@ -4638,7 +4634,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				if (r)
 					goto out;
 
-				amdgpu_fbdev_set_suspend(tmp_adev, 0);
+				drm_fb_helper_set_suspend_unlocked(adev_to_drm(tmp_adev)->fb_helper, false);
 
 				/*
 				 * The GPU enters bad state once faulty pages
@@ -5025,7 +5021,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		 */
 		amdgpu_unregister_gpu_instance(tmp_adev);
 
-		amdgpu_fbdev_set_suspend(tmp_adev, 1);
+		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, true);
 
 		/* disable ras on ALL IPs */
 		if (!need_emergency_restart &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 7a7316731911..58bfc7f00d76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1572,13 +1572,10 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 			continue;
 		}
 		robj = gem_to_amdgpu_bo(fb->obj[0]);
-		/* don't unpin kernel fb objects */
-		if (!amdgpu_fbdev_robj_is_fb(adev, robj)) {
-			r = amdgpu_bo_reserve(robj, true);
-			if (r == 0) {
-				amdgpu_bo_unpin(robj);
-				amdgpu_bo_unreserve(robj);
-			}
+		r = amdgpu_bo_reserve(robj, true);
+		if (r == 0) {
+			amdgpu_bo_unpin(robj);
+			amdgpu_bo_unreserve(robj);
 		}
 	}
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 987482c26b1a..db21af5e84ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1348,6 +1348,19 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		goto err_pci;
 	}
 
+	/*
+	 * 1. don't init fbdev on hw without DCE
+	 * 2. don't init fbdev if there are no connectors
+	 */
+	if (adev->mode_info.mode_config_initialized &&
+	    !list_empty(&adev_to_drm(adev)->mode_config.connector_list)) {
+		/* select 8 bpp console on low vram cards */
+		if (adev->gmc.real_vram_size <= (32*1024*1024))
+			drm_fbdev_generic_setup(adev_to_drm(adev), 8);
+		else
+			drm_fbdev_generic_setup(adev_to_drm(adev), 32);
+	}
+
 	ret = amdgpu_debugfs_init(adev);
 	if (ret)
 		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
deleted file mode 100644
index cd0acbea75da..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ /dev/null
@@ -1,388 +0,0 @@
-/*
- * Copyright © 2007 David Airlie
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
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
- * DEALINGS IN THE SOFTWARE.
- *
- * Authors:
- *     David Airlie
- */
-
-#include <linux/module.h>
-#include <linux/pm_runtime.h>
-#include <linux/slab.h>
-#include <linux/vga_switcheroo.h>
-
-#include <drm/amdgpu_drm.h>
-#include <drm/drm_crtc.h>
-#include <drm/drm_crtc_helper.h>
-#include <drm/drm_fb_helper.h>
-#include <drm/drm_fourcc.h>
-
-#include "amdgpu.h"
-#include "cikd.h"
-#include "amdgpu_gem.h"
-
-#include "amdgpu_display.h"
-
-/* object hierarchy -
-   this contains a helper + a amdgpu fb
-   the helper contains a pointer to amdgpu framebuffer baseclass.
-*/
-
-static int
-amdgpufb_open(struct fb_info *info, int user)
-{
-	struct drm_fb_helper *fb_helper = info->par;
-	int ret = pm_runtime_get_sync(fb_helper->dev->dev);
-	if (ret < 0 && ret != -EACCES) {
-		pm_runtime_mark_last_busy(fb_helper->dev->dev);
-		pm_runtime_put_autosuspend(fb_helper->dev->dev);
-		return ret;
-	}
-	return 0;
-}
-
-static int
-amdgpufb_release(struct fb_info *info, int user)
-{
-	struct drm_fb_helper *fb_helper = info->par;
-
-	pm_runtime_mark_last_busy(fb_helper->dev->dev);
-	pm_runtime_put_autosuspend(fb_helper->dev->dev);
-	return 0;
-}
-
-static const struct fb_ops amdgpufb_ops = {
-	.owner = THIS_MODULE,
-	DRM_FB_HELPER_DEFAULT_OPS,
-	.fb_open = amdgpufb_open,
-	.fb_release = amdgpufb_release,
-	.fb_fillrect = drm_fb_helper_cfb_fillrect,
-	.fb_copyarea = drm_fb_helper_cfb_copyarea,
-	.fb_imageblit = drm_fb_helper_cfb_imageblit,
-};
-
-
-int amdgpu_align_pitch(struct amdgpu_device *adev, int width, int cpp, bool tiled)
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
-static void amdgpufb_destroy_pinned_object(struct drm_gem_object *gobj)
-{
-	struct amdgpu_bo *abo = gem_to_amdgpu_bo(gobj);
-	int ret;
-
-	ret = amdgpu_bo_reserve(abo, true);
-	if (likely(ret == 0)) {
-		amdgpu_bo_kunmap(abo);
-		amdgpu_bo_unpin(abo);
-		amdgpu_bo_unreserve(abo);
-	}
-	drm_gem_object_put(gobj);
-}
-
-static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
-					 struct drm_mode_fb_cmd2 *mode_cmd,
-					 struct drm_gem_object **gobj_p)
-{
-	const struct drm_format_info *info;
-	struct amdgpu_device *adev = rfbdev->adev;
-	struct drm_gem_object *gobj = NULL;
-	struct amdgpu_bo *abo = NULL;
-	bool fb_tiled = false; /* useful for testing */
-	u32 tiling_flags = 0, domain;
-	int ret;
-	int aligned_size, size;
-	int height = mode_cmd->height;
-	u32 cpp;
-	u64 flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
-			       AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS     |
-			       AMDGPU_GEM_CREATE_VRAM_CLEARED;
-
-	info = drm_get_format_info(adev_to_drm(adev), mode_cmd);
-	cpp = info->cpp[0];
-
-	/* need to align pitch with crtc limits */
-	mode_cmd->pitches[0] = amdgpu_align_pitch(adev, mode_cmd->width, cpp,
-						  fb_tiled);
-	domain = amdgpu_display_supported_domains(adev, flags);
-	height = ALIGN(mode_cmd->height, 8);
-	size = mode_cmd->pitches[0] * height;
-	aligned_size = ALIGN(size, PAGE_SIZE);
-	ret = amdgpu_gem_object_create(adev, aligned_size, 0, domain, flags,
-				       ttm_bo_type_device, NULL, &gobj);
-	if (ret) {
-		pr_err("failed to allocate framebuffer (%d)\n", aligned_size);
-		return -ENOMEM;
-	}
-	abo = gem_to_amdgpu_bo(gobj);
-
-	if (fb_tiled)
-		tiling_flags = AMDGPU_TILING_SET(ARRAY_MODE, GRPH_ARRAY_2D_TILED_THIN1);
-
-	ret = amdgpu_bo_reserve(abo, false);
-	if (unlikely(ret != 0))
-		goto out_unref;
-
-	if (tiling_flags) {
-		ret = amdgpu_bo_set_tiling_flags(abo,
-						 tiling_flags);
-		if (ret)
-			dev_err(adev->dev, "FB failed to set tiling flags\n");
-	}
-
-	ret = amdgpu_bo_pin(abo, domain);
-	if (ret) {
-		amdgpu_bo_unreserve(abo);
-		goto out_unref;
-	}
-
-	ret = amdgpu_ttm_alloc_gart(&abo->tbo);
-	if (ret) {
-		amdgpu_bo_unreserve(abo);
-		dev_err(adev->dev, "%p bind failed\n", abo);
-		goto out_unref;
-	}
-
-	ret = amdgpu_bo_kmap(abo, NULL);
-	amdgpu_bo_unreserve(abo);
-	if (ret) {
-		goto out_unref;
-	}
-
-	*gobj_p = gobj;
-	return 0;
-out_unref:
-	amdgpufb_destroy_pinned_object(gobj);
-	*gobj_p = NULL;
-	return ret;
-}
-
-static int amdgpufb_create(struct drm_fb_helper *helper,
-			   struct drm_fb_helper_surface_size *sizes)
-{
-	struct amdgpu_fbdev *rfbdev = (struct amdgpu_fbdev *)helper;
-	struct amdgpu_device *adev = rfbdev->adev;
-	struct fb_info *info;
-	struct drm_framebuffer *fb = NULL;
-	struct drm_mode_fb_cmd2 mode_cmd;
-	struct drm_gem_object *gobj = NULL;
-	struct amdgpu_bo *abo = NULL;
-	int ret;
-
-	memset(&mode_cmd, 0, sizeof(mode_cmd));
-	mode_cmd.width = sizes->surface_width;
-	mode_cmd.height = sizes->surface_height;
-
-	if (sizes->surface_bpp == 24)
-		sizes->surface_bpp = 32;
-
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
-							  sizes->surface_depth);
-
-	ret = amdgpufb_create_pinned_object(rfbdev, &mode_cmd, &gobj);
-	if (ret) {
-		DRM_ERROR("failed to create fbcon object %d\n", ret);
-		return ret;
-	}
-
-	abo = gem_to_amdgpu_bo(gobj);
-
-	/* okay we have an object now allocate the framebuffer */
-	info = drm_fb_helper_alloc_fbi(helper);
-	if (IS_ERR(info)) {
-		ret = PTR_ERR(info);
-		goto out;
-	}
-
-	ret = amdgpu_display_gem_fb_init(adev_to_drm(adev), &rfbdev->rfb,
-					 &mode_cmd, gobj);
-	if (ret) {
-		DRM_ERROR("failed to initialize framebuffer %d\n", ret);
-		goto out;
-	}
-
-	fb = &rfbdev->rfb.base;
-
-	/* setup helper */
-	rfbdev->helper.fb = fb;
-
-	info->fbops = &amdgpufb_ops;
-
-	info->fix.smem_start = amdgpu_gmc_vram_cpu_pa(adev, abo);
-	info->fix.smem_len = amdgpu_bo_size(abo);
-	info->screen_base = amdgpu_bo_kptr(abo);
-	info->screen_size = amdgpu_bo_size(abo);
-
-	drm_fb_helper_fill_info(info, &rfbdev->helper, sizes);
-
-	/* setup aperture base/size for vesafb takeover */
-	info->apertures->ranges[0].base = adev_to_drm(adev)->mode_config.fb_base;
-	info->apertures->ranges[0].size = adev->gmc.aper_size;
-
-	/* Use default scratch pixmap (info->pixmap.flags = FB_PIXMAP_SYSTEM) */
-
-	if (info->screen_base == NULL) {
-		ret = -ENOSPC;
-		goto out;
-	}
-
-	DRM_INFO("fb mappable at 0x%lX\n",  info->fix.smem_start);
-	DRM_INFO("vram apper at 0x%lX\n",  (unsigned long)adev->gmc.aper_base);
-	DRM_INFO("size %lu\n", (unsigned long)amdgpu_bo_size(abo));
-	DRM_INFO("fb depth is %d\n", fb->format->depth);
-	DRM_INFO("   pitch is %d\n", fb->pitches[0]);
-
-	vga_switcheroo_client_fb_set(adev->pdev, info);
-	return 0;
-
-out:
-	if (fb && ret) {
-		drm_gem_object_put(gobj);
-		drm_framebuffer_unregister_private(fb);
-		drm_framebuffer_cleanup(fb);
-		kfree(fb);
-	}
-	return ret;
-}
-
-static int amdgpu_fbdev_destroy(struct drm_device *dev, struct amdgpu_fbdev *rfbdev)
-{
-	struct amdgpu_framebuffer *rfb = &rfbdev->rfb;
-	int i;
-
-	drm_fb_helper_unregister_fbi(&rfbdev->helper);
-
-	if (rfb->base.obj[0]) {
-		for (i = 0; i < rfb->base.format->num_planes; i++)
-			drm_gem_object_put(rfb->base.obj[0]);
-		amdgpufb_destroy_pinned_object(rfb->base.obj[0]);
-		rfb->base.obj[0] = NULL;
-		drm_framebuffer_unregister_private(&rfb->base);
-		drm_framebuffer_cleanup(&rfb->base);
-	}
-	drm_fb_helper_fini(&rfbdev->helper);
-
-	return 0;
-}
-
-static const struct drm_fb_helper_funcs amdgpu_fb_helper_funcs = {
-	.fb_probe = amdgpufb_create,
-};
-
-int amdgpu_fbdev_init(struct amdgpu_device *adev)
-{
-	struct amdgpu_fbdev *rfbdev;
-	int bpp_sel = 32;
-	int ret;
-
-	/* don't init fbdev on hw without DCE */
-	if (!adev->mode_info.mode_config_initialized)
-		return 0;
-
-	/* don't init fbdev if there are no connectors */
-	if (list_empty(&adev_to_drm(adev)->mode_config.connector_list))
-		return 0;
-
-	/* select 8 bpp console on low vram cards */
-	if (adev->gmc.real_vram_size <= (32*1024*1024))
-		bpp_sel = 8;
-
-	rfbdev = kzalloc(sizeof(struct amdgpu_fbdev), GFP_KERNEL);
-	if (!rfbdev)
-		return -ENOMEM;
-
-	rfbdev->adev = adev;
-	adev->mode_info.rfbdev = rfbdev;
-
-	drm_fb_helper_prepare(adev_to_drm(adev), &rfbdev->helper,
-			      &amdgpu_fb_helper_funcs);
-
-	ret = drm_fb_helper_init(adev_to_drm(adev), &rfbdev->helper);
-	if (ret) {
-		kfree(rfbdev);
-		return ret;
-	}
-
-	/* disable all the possible outputs/crtcs before entering KMS mode */
-	if (!amdgpu_device_has_dc_support(adev) && !amdgpu_virtual_display)
-		drm_helper_disable_unused_functions(adev_to_drm(adev));
-
-	drm_fb_helper_initial_config(&rfbdev->helper, bpp_sel);
-	return 0;
-}
-
-void amdgpu_fbdev_fini(struct amdgpu_device *adev)
-{
-	if (!adev->mode_info.rfbdev)
-		return;
-
-	amdgpu_fbdev_destroy(adev_to_drm(adev), adev->mode_info.rfbdev);
-	kfree(adev->mode_info.rfbdev);
-	adev->mode_info.rfbdev = NULL;
-}
-
-void amdgpu_fbdev_set_suspend(struct amdgpu_device *adev, int state)
-{
-	if (adev->mode_info.rfbdev)
-		drm_fb_helper_set_suspend_unlocked(&adev->mode_info.rfbdev->helper,
-						   state);
-}
-
-int amdgpu_fbdev_total_size(struct amdgpu_device *adev)
-{
-	struct amdgpu_bo *robj;
-	int size = 0;
-
-	if (!adev->mode_info.rfbdev)
-		return 0;
-
-	robj = gem_to_amdgpu_bo(adev->mode_info.rfbdev->rfb.base.obj[0]);
-	size += amdgpu_bo_size(robj);
-	return size;
-}
-
-bool amdgpu_fbdev_robj_is_fb(struct amdgpu_device *adev, struct amdgpu_bo *robj)
-{
-	if (!adev->mode_info.rfbdev)
-		return false;
-	if (robj == gem_to_amdgpu_bo(adev->mode_info.rfbdev->rfb.base.obj[0]))
-		return true;
-	return false;
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 9e2525b96d04..355db8438522 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -876,6 +876,32 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+static int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
+				  int width,
+				  int cpp,
+				  bool tiled)
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
 int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 			    struct drm_device *dev,
 			    struct drm_mode_create_dumb *args)
@@ -896,8 +922,8 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 	if (adev->mman.buffer_funcs_enabled)
 		flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
 
-	args->pitch = amdgpu_align_pitch(adev, args->width,
-					 DIV_ROUND_UP(args->bpp, 8), 0);
+	args->pitch = amdgpu_gem_align_pitch(adev, args->width,
+					     DIV_ROUND_UP(args->bpp, 8), 0);
 	args->size = (u64)args->pitch * args->height;
 	args->size = ALIGN(args->size, PAGE_SIZE);
 	domain = amdgpu_bo_get_preferred_domain(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 89fb372ed49c..6043bf6fd414 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -232,8 +232,6 @@ struct amdgpu_i2c_chan {
 	struct mutex mutex;
 };
 
-struct amdgpu_fbdev;
-
 struct amdgpu_afmt {
 	bool enabled;
 	int offset;
@@ -309,13 +307,6 @@ struct amdgpu_framebuffer {
 	uint64_t address;
 };
 
-struct amdgpu_fbdev {
-	struct drm_fb_helper helper;
-	struct amdgpu_framebuffer rfb;
-	struct list_head fbdev_list;
-	struct amdgpu_device *adev;
-};
-
 struct amdgpu_mode_info {
 	struct atom_context *atom_context;
 	struct card_info *atom_card_info;
@@ -341,8 +332,6 @@ struct amdgpu_mode_info {
 	struct edid *bios_hardcoded_edid;
 	int bios_hardcoded_edid_size;
 
-	/* pointer to fbdev info structure */
-	struct amdgpu_fbdev *rfbdev;
 	/* firmware flags */
 	u32 firmware_flags;
 	/* pointer to backlight encoder */
@@ -631,15 +620,6 @@ bool amdgpu_crtc_get_scanout_position(struct drm_crtc *crtc,
 			int *hpos, ktime_t *stime, ktime_t *etime,
 			const struct drm_display_mode *mode);
 
-/* fbdev layer */
-int amdgpu_fbdev_init(struct amdgpu_device *adev);
-void amdgpu_fbdev_fini(struct amdgpu_device *adev);
-void amdgpu_fbdev_set_suspend(struct amdgpu_device *adev, int state);
-int amdgpu_fbdev_total_size(struct amdgpu_device *adev);
-bool amdgpu_fbdev_robj_is_fb(struct amdgpu_device *adev, struct amdgpu_bo *robj);
-
-int amdgpu_align_pitch(struct amdgpu_device *adev, int width, int bpp, bool tiled);
-
 /* amdgpu_display.c */
 void amdgpu_display_print_display_setup(struct drm_device *dev);
 int amdgpu_display_modeset_create_props(struct amdgpu_device *adev);
-- 
2.29.0

