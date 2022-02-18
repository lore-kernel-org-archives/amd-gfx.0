Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CB6C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 22:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D9810EDFB;
	Fri, 18 Feb 2022 22:26:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0749810EDDF
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 22:26:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaVcmtQMwqZ89jAntrlGxdaCexHA+B9V20MHd7Hwct1TYNVFUWiPfC+qlUe2WCsMu6fWaxBr7+MGsOhZG+eITllkvuJMXlNAp+SMXzOvrQM812261OAEWF0fqVLNd6xoGEatNb54xKA6JzmUfmZImJFWAHLdEY56oEoMUP8pCwC1Hdo7vQxe9uqIDYZUljYksMs7UgGNbAMiPmkLeNnGqKOez+2qLtCeOeqVZn3k85Jtg0Vq7/R4NcHGL39Lakk+G8poTw2T7fROgiyyv5WPwy48gmqpuyR8AkodfgHU3KQl6M7rG78vuSIS0JdEAKvdATI1Kktwr9mgDkvB0Sm3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mwZAJ9y3VZTGpDSI9GRx2Xn6OVeNTsb4GAt+F6tgfw=;
 b=TiwXu5olXgZLPHT50PtEKNocXFkFWB9pjOM+D7VpriQx1gi5HtaoYW50dLSlB8d0Vcu/3g+G9lz9fCa6kCgFKrt1JLmglMsI8FaPGZ0HHdlxqzS6mCSDj4AM3WdqJUr4j6Gc8u7ljg5ly37bJyLUz+2/3p/lCOVS25v/z5ZnwMy0ru3ehRcnK9uizYelDDRGQ7ngFwEchtwFW4siRIyiheupnRLvzumQe/+6bPwijxySkfmzO5Gx0J/PcWw98s14w65TeT7YSgMd+dRnQfzQJ587hXqW5reEeI2TJHvARu+cpMVDy+nxHURJxG09V3D/QUOV4v4mbeGDPTn8CxLGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mwZAJ9y3VZTGpDSI9GRx2Xn6OVeNTsb4GAt+F6tgfw=;
 b=5XJMctZprRelP/UVwxl1/VwEQ8mM1RTVa2LJYHK04MzItoc6A2Bg/S+wdDn1LTU9YIl+H3NJ1nLMagUIaRQlP6KhACyCML9qqDzf7GiehFnKXqXE7XLXF5GGnhO8SERWXvS9smLZuomBzZWBXkbOf5n0iCxeBj/gxA+LFsajWos=
Received: from MW4PR03CA0251.namprd03.prod.outlook.com (2603:10b6:303:b4::16)
 by DM6PR12MB3642.namprd12.prod.outlook.com (2603:10b6:5:11f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 22:26:20 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::c2) by MW4PR03CA0251.outlook.office365.com
 (2603:10b6:303:b4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Fri, 18 Feb 2022 22:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 22:26:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 16:26:17 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amdgpu: drop testing module parameter
Date: Fri, 18 Feb 2022 17:26:03 -0500
Message-ID: <20220218222603.25470-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218222603.25470-1-alexander.deucher@amd.com>
References: <20220218222603.25470-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55d1091a-eced-4feb-bd8c-08d9f32dafee
X-MS-TrafficTypeDiagnostic: DM6PR12MB3642:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3642E84BB923DA652DA5E3CBF7379@DM6PR12MB3642.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOfCDJwjxIkTR5/ySOtfFkj2iFxmoQw5JKSAYhFkSRpT5jLutFtrCE0+7zqPNagbq/8uxFh6D864ojnliQuwxyFj3+isHH8QsmkbxgglrHHObtEkJCLqRxkSAz5+hLc5mX+6fXEep2Ouq90FyBhnBSyKGwMStKEjjbUXg3rYUEnJRyQaX7t/c9lbgC+As183S4dQ2lEttS2tLOLC+1uYmC1MVf4OyTH1wZVKVy0g99R259Cv2yv711U0WLTUzdjSvLyn5/tg6qNDJkKac8izJzk0Cumio5jfyNq6B3kiLkg/jsxj+SuVjomzPhSuZ3z7bieLl9C4qGFCxA2KMFvpAmwptbg4pfP1aSt4MLqT+0EAx5Qel5KQNkTgVwWS5I2PvF6zfTTSKMOFMLcNxL1EHbw/uTbRqdPb9J/5eeT/zMocYXQEAWbQPv1LZuWrara6CVoRepnC7aL4ihVutHeuvKGbHn4HMM+IxMw+KtpW2lPZ5sJQeGyaR5UqASw4OtzebhGB15CEf+z3qf1a/T2EBHPMGITk8t+O6DQfQnmfER4qJuzJs2Znu+qJyO/f174SaBOkT9x41rSH1C1j40QhG2RjYTdzq43wsIpm2xfEeeds1HVYmnfb30Oxf64d4uvuXIgpDXwG2p4XGzVzQCsSD7xfEX+JZHjozLHthUL9R3yi7S3XZbbCLvwFuxHeyFvnch+gK7zbLZZPwHgK5SFwgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6916009)(6666004)(26005)(16526019)(186003)(47076005)(2616005)(36756003)(66574015)(36860700001)(426003)(316002)(336012)(7696005)(86362001)(1076003)(8936002)(2906002)(83380400001)(5660300002)(8676002)(508600001)(40460700003)(82310400004)(81166007)(4326008)(30864003)(70206006)(70586007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 22:26:19.8497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d1091a-eced-4feb-bd8c-08d9f32dafee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3642
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This was always duplicate functionality with the benchmark tests.
Drop it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   7 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   7 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   8 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c   | 250 ---------------------
 5 files changed, 1 insertion(+), 273 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 7fedbb725e17..5dfe08cb045e 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -46,7 +46,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	atom.o amdgpu_fence.o amdgpu_ttm.o amdgpu_object.o amdgpu_gart.o \
 	amdgpu_encoders.o amdgpu_display.o amdgpu_i2c.o \
 	amdgpu_gem.o amdgpu_ring.o \
-	amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o amdgpu_test.o \
+	amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
 	atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
 	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
 	amdgpu_dma_buf.o amdgpu_vm.o amdgpu_ib.o amdgpu_pll.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d6cf2e343a43..a117b40f03a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -155,7 +155,6 @@ extern int amdgpu_vis_vram_limit;
 extern int amdgpu_gart_size;
 extern int amdgpu_gtt_size;
 extern int amdgpu_moverate;
-extern int amdgpu_testing;
 extern int amdgpu_audio;
 extern int amdgpu_disp_priority;
 extern int amdgpu_hw_i2c;
@@ -587,12 +586,6 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb);
  */
 int amdgpu_benchmark(struct amdgpu_device *adev, int test_number);
 
-
-/*
- * Testing
- */
-void amdgpu_test_moves(struct amdgpu_device *adev);
-
 /*
  * ASIC specific register table accessible by UMD
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 02863e2ea3c4..ae420a5c6407 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3805,13 +3805,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	} else
 		adev->ucode_sysfs_en = true;
 
-	if ((amdgpu_testing & 1)) {
-		if (adev->accel_working)
-			amdgpu_test_moves(adev);
-		else
-			DRM_INFO("amdgpu: acceleration disabled, skipping move tests\n");
-	}
-
 	/*
 	 * Register gpu instance before amdgpu_device_enable_mgpu_fan_boost.
 	 * Otherwise the mgpu fan boost feature will be skipped due to the
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a76d78a6dc54..a0990f2e5562 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -110,7 +110,6 @@ int amdgpu_vis_vram_limit;
 int amdgpu_gart_size = -1; /* auto */
 int amdgpu_gtt_size = -1; /* auto */
 int amdgpu_moverate = -1; /* auto */
-int amdgpu_testing;
 int amdgpu_audio = -1;
 int amdgpu_disp_priority;
 int amdgpu_hw_i2c;
@@ -230,13 +229,6 @@ module_param_named(gttsize, amdgpu_gtt_size, int, 0600);
 MODULE_PARM_DESC(moverate, "Maximum buffer migration rate in MB/s. (32, 64, etc., -1=auto, 0=1=disabled)");
 module_param_named(moverate, amdgpu_moverate, int, 0600);
 
-/**
- * DOC: test (int)
- * Test BO GTT->VRAM and VRAM->GTT GPU copies. The default is 0 (Skip test, only set 1 to run test).
- */
-MODULE_PARM_DESC(test, "Run tests");
-module_param_named(test, amdgpu_testing, int, 0444);
-
 /**
  * DOC: audio (int)
  * Set HDMI/DPAudio. Only affects non-DC display handling. The default is -1 (Enabled), set 0 to disabled it.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
deleted file mode 100644
index 909d830b513e..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
+++ /dev/null
@@ -1,250 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR MIT
-/*
- * Copyright 2009 VMware, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: Michel Dänzer
- */
-
-#include <drm/amdgpu_drm.h>
-#include "amdgpu.h"
-#include "amdgpu_uvd.h"
-#include "amdgpu_vce.h"
-
-/* Test BO GTT->VRAM and VRAM->GTT GPU copies across the whole GTT aperture */
-static void amdgpu_do_test_moves(struct amdgpu_device *adev)
-{
-	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
-	struct amdgpu_bo *vram_obj = NULL;
-	struct amdgpu_bo **gtt_obj = NULL;
-	struct amdgpu_bo_param bp;
-	uint64_t gart_addr, vram_addr;
-	unsigned n, size;
-	int i, r;
-
-	size = 1024 * 1024;
-
-	/* Number of tests =
-	 * (Total GTT - gart_pin_size - (2 transfer windows for buffer moves)) / test size
-	 */
-	n = adev->gmc.gart_size - atomic64_read(&adev->gart_pin_size);
-	n -= AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS *
-		AMDGPU_GPU_PAGE_SIZE;
-	n /= size;
-
-	gtt_obj = kcalloc(n, sizeof(*gtt_obj), GFP_KERNEL);
-	if (!gtt_obj) {
-		DRM_ERROR("Failed to allocate %d pointers\n", n);
-		r = 1;
-		goto out_cleanup;
-	}
-	memset(&bp, 0, sizeof(bp));
-	bp.size = size;
-	bp.byte_align = PAGE_SIZE;
-	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
-	bp.flags = 0;
-	bp.type = ttm_bo_type_kernel;
-	bp.resv = NULL;
-	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
-
-	r = amdgpu_bo_create(adev, &bp, &vram_obj);
-	if (r) {
-		DRM_ERROR("Failed to create VRAM object\n");
-		goto out_cleanup;
-	}
-	r = amdgpu_bo_reserve(vram_obj, false);
-	if (unlikely(r != 0))
-		goto out_unref;
-	r = amdgpu_bo_pin(vram_obj, AMDGPU_GEM_DOMAIN_VRAM);
-	if (r) {
-		DRM_ERROR("Failed to pin VRAM object\n");
-		goto out_unres;
-	}
-	vram_addr = amdgpu_bo_gpu_offset(vram_obj);
-	for (i = 0; i < n; i++) {
-		void *gtt_map, *vram_map;
-		void **gart_start, **gart_end;
-		void **vram_start, **vram_end;
-		struct dma_fence *fence = NULL;
-
-		bp.domain = AMDGPU_GEM_DOMAIN_GTT;
-		r = amdgpu_bo_create(adev, &bp, gtt_obj + i);
-		if (r) {
-			DRM_ERROR("Failed to create GTT object %d\n", i);
-			goto out_lclean;
-		}
-
-		r = amdgpu_bo_reserve(gtt_obj[i], false);
-		if (unlikely(r != 0))
-			goto out_lclean_unref;
-		r = amdgpu_bo_pin(gtt_obj[i], AMDGPU_GEM_DOMAIN_GTT);
-		if (r) {
-			DRM_ERROR("Failed to pin GTT object %d\n", i);
-			goto out_lclean_unres;
-		}
-		r = amdgpu_ttm_alloc_gart(&gtt_obj[i]->tbo);
-		if (r) {
-			DRM_ERROR("%p bind failed\n", gtt_obj[i]);
-			goto out_lclean_unpin;
-		}
-		gart_addr = amdgpu_bo_gpu_offset(gtt_obj[i]);
-
-		r = amdgpu_bo_kmap(gtt_obj[i], &gtt_map);
-		if (r) {
-			DRM_ERROR("Failed to map GTT object %d\n", i);
-			goto out_lclean_unpin;
-		}
-
-		for (gart_start = gtt_map, gart_end = gtt_map + size;
-		     gart_start < gart_end;
-		     gart_start++)
-			*gart_start = gart_start;
-
-		amdgpu_bo_kunmap(gtt_obj[i]);
-
-		r = amdgpu_copy_buffer(ring, gart_addr, vram_addr,
-				       size, NULL, &fence, false, false, false);
-
-		if (r) {
-			DRM_ERROR("Failed GTT->VRAM copy %d\n", i);
-			goto out_lclean_unpin;
-		}
-
-		r = dma_fence_wait(fence, false);
-		if (r) {
-			DRM_ERROR("Failed to wait for GTT->VRAM fence %d\n", i);
-			goto out_lclean_unpin;
-		}
-
-		dma_fence_put(fence);
-		fence = NULL;
-
-		r = amdgpu_bo_kmap(vram_obj, &vram_map);
-		if (r) {
-			DRM_ERROR("Failed to map VRAM object after copy %d\n", i);
-			goto out_lclean_unpin;
-		}
-
-		for (gart_start = gtt_map, gart_end = gtt_map + size,
-		     vram_start = vram_map, vram_end = vram_map + size;
-		     vram_start < vram_end;
-		     gart_start++, vram_start++) {
-			if (*vram_start != gart_start) {
-				DRM_ERROR("Incorrect GTT->VRAM copy %d: Got 0x%p, "
-					  "expected 0x%p (GTT/VRAM offset "
-					  "0x%16llx/0x%16llx)\n",
-					  i, *vram_start, gart_start,
-					  (unsigned long long)
-					  (gart_addr - adev->gmc.gart_start +
-					   (void *)gart_start - gtt_map),
-					  (unsigned long long)
-					  (vram_addr - adev->gmc.vram_start +
-					   (void *)gart_start - gtt_map));
-				amdgpu_bo_kunmap(vram_obj);
-				goto out_lclean_unpin;
-			}
-			*vram_start = vram_start;
-		}
-
-		amdgpu_bo_kunmap(vram_obj);
-
-		r = amdgpu_copy_buffer(ring, vram_addr, gart_addr,
-				       size, NULL, &fence, false, false, false);
-
-		if (r) {
-			DRM_ERROR("Failed VRAM->GTT copy %d\n", i);
-			goto out_lclean_unpin;
-		}
-
-		r = dma_fence_wait(fence, false);
-		if (r) {
-			DRM_ERROR("Failed to wait for VRAM->GTT fence %d\n", i);
-			goto out_lclean_unpin;
-		}
-
-		dma_fence_put(fence);
-		fence = NULL;
-
-		r = amdgpu_bo_kmap(gtt_obj[i], &gtt_map);
-		if (r) {
-			DRM_ERROR("Failed to map GTT object after copy %d\n", i);
-			goto out_lclean_unpin;
-		}
-
-		for (gart_start = gtt_map, gart_end = gtt_map + size,
-		     vram_start = vram_map, vram_end = vram_map + size;
-		     gart_start < gart_end;
-		     gart_start++, vram_start++) {
-			if (*gart_start != vram_start) {
-				DRM_ERROR("Incorrect VRAM->GTT copy %d: Got 0x%p, "
-					  "expected 0x%p (VRAM/GTT offset "
-					  "0x%16llx/0x%16llx)\n",
-					  i, *gart_start, vram_start,
-					  (unsigned long long)
-					  (vram_addr - adev->gmc.vram_start +
-					   (void *)vram_start - vram_map),
-					  (unsigned long long)
-					  (gart_addr - adev->gmc.gart_start +
-					   (void *)vram_start - vram_map));
-				amdgpu_bo_kunmap(gtt_obj[i]);
-				goto out_lclean_unpin;
-			}
-		}
-
-		amdgpu_bo_kunmap(gtt_obj[i]);
-
-		DRM_INFO("Tested GTT->VRAM and VRAM->GTT copy for GTT offset 0x%llx\n",
-			 gart_addr - adev->gmc.gart_start);
-		continue;
-
-out_lclean_unpin:
-		amdgpu_bo_unpin(gtt_obj[i]);
-out_lclean_unres:
-		amdgpu_bo_unreserve(gtt_obj[i]);
-out_lclean_unref:
-		amdgpu_bo_unref(&gtt_obj[i]);
-out_lclean:
-		for (--i; i >= 0; --i) {
-			amdgpu_bo_unpin(gtt_obj[i]);
-			amdgpu_bo_unreserve(gtt_obj[i]);
-			amdgpu_bo_unref(&gtt_obj[i]);
-		}
-		if (fence)
-			dma_fence_put(fence);
-		break;
-	}
-
-	amdgpu_bo_unpin(vram_obj);
-out_unres:
-	amdgpu_bo_unreserve(vram_obj);
-out_unref:
-	amdgpu_bo_unref(&vram_obj);
-out_cleanup:
-	kfree(gtt_obj);
-	if (r) {
-		pr_warn("Error while testing BO move\n");
-	}
-}
-
-void amdgpu_test_moves(struct amdgpu_device *adev)
-{
-	if (adev->mman.buffer_funcs)
-		amdgpu_do_test_moves(adev);
-}
-- 
2.35.1

