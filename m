Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DA8C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 14:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E643B10E431;
	Wed, 17 May 2023 14:46:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3396310E431
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 14:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaACbsR6ULrEHsObCn4LYLX2T9mq26QQ21/jz69GWO87dau8dWOQkh3nznxLtSmbYJ8s8wOmJ15QHUyFoxdyRgn5TiE272qS7ic9kSfnSYsQWUtjzX1LQsiMgJVM+2MlIlPNT+Y+FftViYgjre4Gmuzfo6rZi969mzS2DS2L5tgbBWn04s5rdOhZ/549TmLNNx/ETMo702wAjpN+QiQt0ply+OYG2WzrePXB2zs8KwNrkF1fvxrkD30lVWD3n7qY3Fz3bNOP08tMKv64yrMDSHHTNtXMmhoH0zo+yCA+Abdi2/RY127qvsWiDajepf4sJEh619eP+1G2OG5J0zsnuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdoAxoqFefu6e2tU8kDrYZ34bSRbtzKQLAcy2fHzFa4=;
 b=c359Mha3a2WKIg02kO0oz5MFjQYllmBKkO1+3dOgGw98gdM6GU0MK/PKP2bvFTH4nNld0QDkPlRwmblX9rJSvKCJX8RJcal4mrLcSexTve7bBezEZilOW770rN9HvLGCBzHODTv0gCTARgmzVgMg9uGwdkPOVgBWrczzWzY/9Ke5grnt84MP3cp4tWhH7VNXu7dKifcGB027TZAz2ZJqQjXjzKVm9DloKz6aB+8QZhO76DPODalUgXpiOnQNkvS7JRkeZbhGJ8HtulO2jykF1opEI4ofriq8COCh9RPYXs7sjNTHai/XJOIDaUp61lGuj1PSyaHrASBX7vjCxbOZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdoAxoqFefu6e2tU8kDrYZ34bSRbtzKQLAcy2fHzFa4=;
 b=j38wSJjwVtsDNLG/Mu/mlej7ZEDpVfidSy6qYXr29bL/9LOHuaSG4Ohf2dtgT+lnMuOSVQJcJmM0pnvSNkwqoKBnSRO6N5/QtzDFsXMODl/4acfimgwFaHvvSiOLjFX8WpQLQGB6vDnk0jRHpV2WwczC4ltZjLX5WohGguZ/BNk=
Received: from BL1PR13CA0012.namprd13.prod.outlook.com (2603:10b6:208:256::17)
 by SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 14:46:30 +0000
Received: from BL02EPF000108EA.namprd05.prod.outlook.com
 (2603:10b6:208:256:cafe::c7) by BL1PR13CA0012.outlook.office365.com
 (2603:10b6:208:256::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 14:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000108EA.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.11 via Frontend Transport; Wed, 17 May 2023 14:46:30 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 09:46:25 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix error & warnings in amdgpu_ttm.c
Date: Wed, 17 May 2023 20:15:44 +0530
Message-ID: <20230517144544.2326651-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EA:EE_|SA0PR12MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: c1cf5ac4-0307-436d-e9ca-08db56e5806b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akssIhZTyEMDQAgMDGY2+u2XI90HxmQTt5qq2g4kuo2V0Uk0GnTfYPH2QQXpKs1sXDZPfwsc2SApr/11HJygTagLtqG0ji2heRxMuTQdHhomLYvAmTHAxwPVuIJp8i4dHR4UKFA1eFRfO0Cwtkx2eAeJlXYgfH1huoDyRjYFbcNaIK3R9OKFhb+UjwZd9554NJkelOnwiUkCd1G3M8zNTMwAteO3tUK9vpFCwRYRQKuE9wFHIWO2hgAOVdY0m7mQHimeEajQevkkErZx0QiTQUYygFYkToZcEahoX9HJlqn2WI1i6447Olg903EVVAVPeY9xRuSikkiHEpK9U7bePd+JANQRKkLu6LU7U9C6v1zuW0GrVdsjyOQ7MkBcxeZck/iry88hqLwN8X7c3OjQEMYlmcvjo8+s+5vPzNL4KR35mAU9/Tx9Zozl3x/MMtKCAsRba6xDbYevLr+GAIAJY6sfEMP/HSB3jmLjsR7YWrlKCkU80cRo82sqRK073Vh+Sclx6UMR5e+R3clv5wV17CF34Vh3Mg58ssRGFfFedL20W8rRUiviw+/h6BoT+Q1g+fOOq0oKpg6VwW5+UuMBkVNgFms5IiUBktIYWAkEO03qxmjmMJfBltaDYV9GjD746N25azhgxXNfyT9zwnorR/G38uGjrMNUiGR+sFTxvoXHnFV9GyNg/BtHWw5BxqQl3jvs2j/ZPLIOzzLyI4EZy66gv9+bx11ioIBKCDsnHTYKZNOCou+uxBtqkmk/W4g8DhrsB1oMdb8ZY2rvGSRW2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(7696005)(8676002)(6666004)(8936002)(47076005)(83380400001)(41300700001)(66574015)(478600001)(40460700003)(54906003)(110136005)(16526019)(186003)(40480700001)(70586007)(26005)(2906002)(82740400003)(70206006)(36756003)(86362001)(426003)(316002)(82310400005)(2616005)(81166007)(1076003)(36860700001)(356005)(336012)(44832011)(4326008)(5660300002)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 14:46:30.4643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cf5ac4-0307-436d-e9ca-08db56e5806b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7003
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix below checkpatch insisted error & warnings:

ERROR: Macros with complex values should be enclosed in parentheses
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: braces {} are not necessary for single statement blocks
WARNING: Block comments use a trailing */ on a separate line
WARNING: Missing a blank line after declarations

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ad664ef640ff..f6d9f904b20b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -65,7 +65,7 @@
 
 MODULE_IMPORT_NS(DMA_BUF);
 
-#define AMDGPU_TTM_VRAM_MAX_DW_READ	(size_t)128
+#define AMDGPU_TTM_VRAM_MAX_DW_READ	((size_t)128)
 
 static int amdgpu_ttm_backend_bind(struct ttm_device *bdev,
 				   struct ttm_tt *ttm,
@@ -184,11 +184,11 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 				 struct ttm_resource *mem,
 				 struct amdgpu_res_cursor *mm_cur,
-				 unsigned window, struct amdgpu_ring *ring,
+				 unsigned int window, struct amdgpu_ring *ring,
 				 bool tmz, uint64_t *size, uint64_t *addr)
 {
 	struct amdgpu_device *adev = ring->adev;
-	unsigned offset, num_pages, num_dw, num_bytes;
+	unsigned int offset, num_pages, num_dw, num_bytes;
 	uint64_t src_addr, dst_addr;
 	struct amdgpu_job *job;
 	void *cpu_addr;
@@ -1061,9 +1061,9 @@ static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
 	enum ttm_caching caching;
 
 	gtt = kzalloc(sizeof(struct amdgpu_ttm_tt), GFP_KERNEL);
-	if (gtt == NULL) {
+	if (!gtt)
 		return NULL;
-	}
+
 	gtt->gobj = &bo->base;
 	if (adev->gmc.mem_partitions && abo->xcp_id >= 0)
 		gtt->pool_id = KFD_XCP_MEM_ID(adev, abo->xcp_id);
@@ -1848,9 +1848,8 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 *place on the VRAM, so reserve it early.
 	 */
 	r = amdgpu_ttm_fw_reserve_vram_init(adev);
-	if (r) {
+	if (r)
 		return r;
-	}
 
 	/*
 	 *The reserved vram for driver must be pinned to the specified
@@ -1874,7 +1873,8 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	/* allocate memory as required for VGA
 	 * This is used for VGA emulation and pre-OS scanout buffers to
 	 * avoid display artifacts while transitioning between pre-OS
-	 * and driver.  */
+	 * and driver.
+	 */
 	if (!adev->gmc.is_app_apu) {
 		r = amdgpu_bo_create_kernel_at(adev, 0,
 					       adev->mman.stolen_vga_size,
@@ -1903,7 +1903,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	}
 
 	DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
-		 (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
+		 (unsigned int)(adev->gmc.real_vram_size / (1024 * 1024)));
 
 	/* Compute GTT size, either based on TTM limit
 	 * or whatever the user passed on module init.
@@ -1920,7 +1920,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 	DRM_INFO("amdgpu: %uM of GTT memory ready.\n",
-		 (unsigned)(gtt_size / (1024 * 1024)));
+		 (unsigned int)(gtt_size / (1024 * 1024)));
 
 	/* Initialize preemptible memory pool */
 	r = amdgpu_preempt_mgr_init(adev);
@@ -1962,6 +1962,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 void amdgpu_ttm_fini(struct amdgpu_device *adev)
 {
 	int idx;
+
 	if (!adev->mman.initialized)
 		return;
 
@@ -2090,10 +2091,10 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 		       bool vm_needs_flush, bool tmz)
 {
 	struct amdgpu_device *adev = ring->adev;
-	unsigned num_loops, num_dw;
+	unsigned int num_loops, num_dw;
 	struct amdgpu_job *job;
 	uint32_t max_bytes;
-	unsigned i;
+	unsigned int i;
 	int r;
 
 	if (!direct_submit && !ring->sched.ready) {
-- 
2.25.1

