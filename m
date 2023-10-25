Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B10C07545
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 17:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4289710E0FA;
	Wed, 25 Oct 2023 17:19:53 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FBA110E0FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 17:19:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COhACfR+jmq+Rkeszdzbr38eM17yLaGccKQX8IzV6N48M7QYZle3O1g0XFPCdLQPwGOXVOlV6UiGG/ndNPMSI6klNqWtVJE7wlx6V2phBp8B8nHdeX0AYpopI6S7kW74jshKhqO8Nou8NI/Lq00sYLKGXlFGbHXmAKDUbJwaAgi7Xj3uXdKNwjU52HI/RUCCHHwCgOr+9DqM+fpI1MAYxX59M8lu1dSr8v+mAArj1slhOD74423HmUGtzeXiZkdSH/lS3Zp4IDXxwp1bY4lGER71aj2sTC5lMtaih4+SE5LgZU+6uphcyUOJX5KVKMdhHmMVtfVGz4NeKZ1gZN707w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOP9fwiOyAyRMmbTy5dywpZCYz28szUim0gYM9EQQ5Y=;
 b=XcKNqCPQRop7Ps+u4UdtPUVXDpwcDhocLumtLZy8GKtN1+2OPRW/m8f+Qo+/YhREpbarobMB9ZIHmbHstj3yQk0iSTQ7uvvQ8FtO/K5KRsB3jstOWBWWAqKdblZ+GNGjSKjByWTLRhfo8hRzxB2+W1OnRf1wmf1tHnDeHNSGnL8r8bSw4rx2hcUhdwuvZIbhu2cNuHJx7mVmL4Z3zn5JJMVG70K/gXlxj5hL4tfhFarE/PD1yU+UHWkApHEcFuTgJ6N9EzrRoXLQ227dBYIDUlb6GmB0WKVOe8jIpePCdvhojeIutaW/Ol3q4ZcM8ed/lssHESxju9PET2YyypSa7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOP9fwiOyAyRMmbTy5dywpZCYz28szUim0gYM9EQQ5Y=;
 b=ntAqexjaZ83qDPAsva62jNmP8SGsXvnDf3W5QpdnpJmfqtYImSIZ++PVgaituT+iuMPw5VXyPFVK7Iomgg+VyW+5AKwpbrt7UHIXgPudx/oWaTkxWmT1O3v6qeay/AW509ysau355lpBeqoYYOFai/wEbADQ1SF24QY4XTxW0ls=
Received: from DS7PR05CA0081.namprd05.prod.outlook.com (2603:10b6:8:57::6) by
 IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 17:19:47 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::d4) by DS7PR05CA0081.outlook.office365.com
 (2603:10b6:8:57::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 17:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 17:19:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 12:19:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: move buffer funcs setting up a level
Date: Wed, 25 Oct 2023 13:19:28 -0400
Message-ID: <20231025171928.3318505-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|IA1PR12MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: 20afe415-3f95-442d-7297-08dbd57e9651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xz4dFb7Ba8sHf5TPla0Gt62nb3nvWPEQ5hIN9cH9FS8Xou64HFYOgsiNV9LsS3avucgo1whHR2IuFyO+SWbo5VX664VGLh1ObdqvHvisCwZXKiTjankKWg9cmKJf2DF2SklljDURFjfUwsxEFbioGkm65z7FXBRlf8bgu2BWzhUGNDs75VFdUfYxS9VcjlBOl1YTH3iFq06swL2x7Ue3TINsSIB+kkT8VvJ3lp5hMz22mwoBnzSl+qm1biz+CBl8fRcouBM29tknqkGwVtQ2A3PyH8e2T7DLkt0YpTiA0UL/3cIxodfey7NHMu2NBh/5KyOqt+n+yqI61yfpK1yg2DK06v8NbIL8dzd6qauz1S0/6Ol7OdCsSXg3OnZlFQuNKzRx/1pv4RJZa6Znlsq7qpSLrgWsE3Fas9GbmbivB89ae1Dv9sBBKIjT9BqP1nPmdklgSesTljg79kKY7M0plgGJQG/zT/EAGlE21RJFkBsxA9ZkTeRQbFztkj58Imi9KBzozZSJCGRdpk2KxUbAUMiwZ/UgcHQJbkPWCZy4aOyDS2ikhvew+7/f6tfsYAokRJKCaNCIPKq1R6UUlRk2Q39izmIvLo9KAF/8KkDL1CNhug08PdJ7PeDTHc1S50QSzqYzsSe2GKLbWqnTXGEsEkv3JTBeC9th4eRv6JalqEbLBfufVhTtkbVW4FVyIbYTYs33/1EBhLpQSeX59VEkujKmwHlXvUy8zkQFw0/dbGEi47i0YocUtpJsD3bVTX0lB4kFOTcNTRyF02BkJ7GhHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(30864003)(86362001)(1076003)(40460700003)(2906002)(36860700001)(41300700001)(54906003)(81166007)(478600001)(316002)(82740400003)(70586007)(16526019)(7696005)(6916009)(356005)(2616005)(47076005)(40480700001)(336012)(426003)(83380400001)(4326008)(36756003)(5660300002)(6666004)(8676002)(8936002)(70206006)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 17:19:46.6479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20afe415-3f95-442d-7297-08dbd57e9651
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rather than doing this in the IP code for the SDMA paging
engine, move it up to the core device level init level.
This should fix the scheduler init ordering.

v2: drop extra parens
v3: drop SDMA helpers

Tested-by: Luben Tuikov <luben.tuikov@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   | 21 ---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h   |  1 -
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  5 -----
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  5 -----
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  5 -----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     | 16 +---------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     | 10 +---------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     | 10 +---------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     | 10 +---------
 drivers/gpu/drm/amd/amdgpu/si_dma.c        |  5 -----
 11 files changed, 19 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2031a467b721..5c90080e93ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2662,6 +2662,9 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
+	if (adev->mman.buffer_funcs_ring->sched.ready)
+		amdgpu_ttm_set_buffer_funcs_status(adev, true);
+
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (!adev->gmc.xgmi.pending_reset) {
 		kgd2kfd_init_zone_device(adev);
@@ -3260,6 +3263,8 @@ int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
 		amdgpu_virt_request_full_gpu(adev, false);
 	}
 
+	amdgpu_ttm_set_buffer_funcs_status(adev, false);
+
 	r = amdgpu_device_ip_suspend_phase1(adev);
 	if (r)
 		return r;
@@ -3449,6 +3454,9 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
 
 	r = amdgpu_device_ip_resume_phase2(adev);
 
+	if (adev->mman.buffer_funcs_ring->sched.ready)
+		amdgpu_ttm_set_buffer_funcs_status(adev, true);
+
 	return r;
 }
 
@@ -4236,6 +4244,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	/* disable ras feature must before hw fini */
 	amdgpu_ras_pre_fini(adev);
 
+	amdgpu_ttm_set_buffer_funcs_status(adev, false);
+
 	amdgpu_device_ip_fini_early(adev);
 
 	amdgpu_irq_fini_hw(adev);
@@ -4407,6 +4417,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_ras_suspend(adev);
 
+	amdgpu_ttm_set_buffer_funcs_status(adev, false);
+
 	amdgpu_device_ip_suspend_phase1(adev);
 
 	if (!adev->in_s0ix)
@@ -5178,6 +5190,9 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				if (r)
 					goto out;
 
+				if (tmp_adev->mman.buffer_funcs_ring->sched.ready)
+					amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
+
 				if (vram_lost)
 					amdgpu_device_fill_reset_magic(tmp_adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index e8cbc4142d80..1d9d187de6ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -292,27 +292,6 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 	return err;
 }
 
-void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev)
-{
-	struct amdgpu_ring *sdma;
-	int i;
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (adev->sdma.has_page_queue) {
-			sdma = &adev->sdma.instance[i].page;
-			if (adev->mman.buffer_funcs_ring == sdma) {
-				amdgpu_ttm_set_buffer_funcs_status(adev, false);
-				break;
-			}
-		}
-		sdma = &adev->sdma.instance[i].ring;
-		if (adev->mman.buffer_funcs_ring == sdma) {
-			amdgpu_ttm_set_buffer_funcs_status(adev, false);
-			break;
-		}
-	}
-}
-
 int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
 {
 	int err = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 513ac22120c1..173a2a308078 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -169,7 +169,6 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
 			       bool duplicate);
 void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
         bool duplicate);
-void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev);
 int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index ee5dce6f6043..a3fccc4c1f43 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -308,8 +308,6 @@ static void cik_sdma_gfx_stop(struct amdgpu_device *adev)
 	u32 rb_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i]);
 		rb_cntl &= ~SDMA0_GFX_RB_CNTL__RB_ENABLE_MASK;
@@ -498,9 +496,6 @@ static int cik_sdma_gfx_resume(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index b58a13bd75db..45377a175250 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -339,8 +339,6 @@ static void sdma_v2_4_gfx_stop(struct amdgpu_device *adev)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i]);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
@@ -474,9 +472,6 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index c5ea32687eb5..2ad615be4bb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -513,8 +513,6 @@ static void sdma_v3_0_gfx_stop(struct amdgpu_device *adev)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i]);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
@@ -746,9 +744,6 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 683d51ae4bf1..3d68dd5523c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -877,8 +877,6 @@ static void sdma_v4_0_gfx_enable(struct amdgpu_device *adev, bool enable)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32_SDMA(i, mmSDMA0_GFX_RB_CNTL);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, enable ? 1 : 0);
@@ -913,8 +911,6 @@ static void sdma_v4_0_page_stop(struct amdgpu_device *adev)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32_SDMA(i, mmSDMA0_PAGE_RB_CNTL);
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_PAGE_RB_CNTL,
@@ -1402,13 +1398,7 @@ static int sdma_v4_0_start(struct amdgpu_device *adev)
 			r = amdgpu_ring_test_helper(page);
 			if (r)
 				return r;
-
-			if (adev->mman.buffer_funcs_ring == page)
-				amdgpu_ttm_set_buffer_funcs_status(adev, true);
 		}
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return r;
@@ -1921,11 +1911,8 @@ static int sdma_v4_0_hw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
-	if (amdgpu_sriov_vf(adev)) {
-		/* disable the scheduler for SDMA */
-		amdgpu_sdma_unset_buffer_funcs_helper(adev);
+	if (amdgpu_sriov_vf(adev))
 		return 0;
-	}
 
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
 		for (i = 0; i < adev->sdma.num_instances; i++) {
@@ -1964,7 +1951,6 @@ static int sdma_v4_0_resume(void *handle)
 	if (adev->in_s0ix) {
 		sdma_v4_0_enable(adev, true);
 		sdma_v4_0_gfx_enable(adev, true);
-		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 		return 0;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index be5d099c9898..c78027ebdcb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -559,8 +559,6 @@ static void sdma_v5_0_gfx_stop(struct amdgpu_device *adev)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
@@ -825,9 +823,6 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
@@ -1426,11 +1421,8 @@ static int sdma_v5_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (amdgpu_sriov_vf(adev)) {
-		/* disable the scheduler for SDMA */
-		amdgpu_sdma_unset_buffer_funcs_helper(adev);
+	if (amdgpu_sriov_vf(adev))
 		return 0;
-	}
 
 	sdma_v5_0_ctx_switch_enable(adev, false);
 	sdma_v5_0_enable(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index a3e8b10c071c..2e35f3571774 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -364,8 +364,6 @@ static void sdma_v5_2_gfx_stop(struct amdgpu_device *adev)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
@@ -625,9 +623,6 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
@@ -1284,11 +1279,8 @@ static int sdma_v5_2_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (amdgpu_sriov_vf(adev)) {
-		/* disable the scheduler for SDMA */
-		amdgpu_sdma_unset_buffer_funcs_helper(adev);
+	if (amdgpu_sriov_vf(adev))
 		return 0;
-	}
 
 	sdma_v5_2_ctx_switch_enable(adev, false);
 	sdma_v5_2_enable(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 445a34549d2c..1c6ff511f501 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -348,8 +348,6 @@ static void sdma_v6_0_gfx_stop(struct amdgpu_device *adev)
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		rb_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_ENABLE, 0);
@@ -561,9 +559,6 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
@@ -1308,11 +1303,8 @@ static int sdma_v6_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (amdgpu_sriov_vf(adev)) {
-		/* disable the scheduler for SDMA */
-		amdgpu_sdma_unset_buffer_funcs_helper(adev);
+	if (amdgpu_sriov_vf(adev))
 		return 0;
-	}
 
 	sdma_v6_0_ctxempty_int_enable(adev, false);
 	sdma_v6_0_enable(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 42c4547f32ec..9aa0e11ee673 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -115,8 +115,6 @@ static void si_dma_stop(struct amdgpu_device *adev)
 	u32 rb_cntl;
 	unsigned i;
 
-	amdgpu_sdma_unset_buffer_funcs_helper(adev);
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		/* dma0 */
 		rb_cntl = RREG32(DMA_RB_CNTL + sdma_offsets[i]);
@@ -177,9 +175,6 @@ static int si_dma_start(struct amdgpu_device *adev)
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-
-		if (adev->mman.buffer_funcs_ring == ring)
-			amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 
 	return 0;
-- 
2.41.0

