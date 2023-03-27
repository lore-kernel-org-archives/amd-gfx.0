Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC7DC76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F253610E71D;
	Mon, 27 Mar 2023 19:36:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7124210E714
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBThdXwYcANmFY6eDvEBmHRpr8pPEl7hDDf0sTS2KL3W2KFr2FZJ3CaoDL89nKjv9tnB9StKJZbb+Q7FlS61H/6mUg1d0ujdPsyvekVjBg+7XcDSLJ20sazidceSI97c1T7HecK+HX+Dbuc4QMUKve+l8p1HMZTZdOOe+vBSoOhlZr610o5KhAFXKzK2ExITGlU1YINoyXdnL46GdBrC80ONivJOPhErl8Won/rDhwvq7KJbCIqCP8Bzhxf+gKHKUOMpmyE52x758EiBe9fdOLkBd0jAsSitqps9tuLL1gwJ89NjKoG4Z+Szmn3ypS4vlZHnHueIUKiQsuiYKSyQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfvDUwGIS3krteyWWsWw0qVy63FoiYFZJYk1240bO+0=;
 b=ApM7jEdHW5XcxD05N/MPAlsLmbYQWOZAl2TykrI/OyWuYBg4F3HIjB1Ys/S8+6YjUe7ZFHdZD792Ke+acfeSD6+BaCnsa2D7jZJr8i2zHEP36/ok4gj8lc9deOdhbI15SqSw3B9CVr5YtKrddsoDTmC4H6KedgqUrIUeMIG/G1C0DLGLZo1dd8RuXVEpxLGNVq40bYAlpfC69+dI0QGhGE333tSdpVdOwvXswV0hYtv2gfxJXECybyRJNnLN90Gm3TSehE8wi3oTMET98tBgeOC4DrhH7gBpWvfU8btgpQ5ot10KZ4SBQ0jK8qBCuPxrFVOW9Z0/mkSiwSrkvXsp/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfvDUwGIS3krteyWWsWw0qVy63FoiYFZJYk1240bO+0=;
 b=4p8c21W60H/0O5qhut8XzC9pHPCtCovs78wHbGyiALWzogG1clZRQLgnFoY3GZrdKJ+iiD0q3HL+XrE1BiPqCo4Fj0MWjd7OpMVe321VcG5gQnWht02qXYw3yZAdHnpnaymeJoJ+HoSxIRuY/nyi9oNOTb0Xos+4dqtPI5C7FAM=
Received: from BN8PR15CA0040.namprd15.prod.outlook.com (2603:10b6:408:80::17)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:36:20 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::51) by BN8PR15CA0040.outlook.office365.com
 (2603:10b6:408:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/28] drm/amdgpu: move vmhub out of amdgpu_ring_funcs (v4)
Date: Mon, 27 Mar 2023 15:35:35 -0400
Message-ID: <20230327193602.7901-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de97812-187c-4324-abf3-08db2efa8a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M17tECmd9pxDAXF3MY6Ip7MqI1eI0gnaCa7J1wiZp3i3V4VqcG/Yt9BYTJdyKR+miPXxHY54darz346MhSeUkWwDQxAQwNIuRYR6InEQMh0jsiWR0VPVRiEvqaxDeUu1Fgk8IyIzB5BfkNxvkIgMPzYLZ2CUpn+UEJzRqptB4lPn4PtuhBg71XonoA9QUVG5HRcIUIeprrZmJb4GFBMYs7Txsz+AvwRi9WAQQvN+W51BsIZcqemdBmZLC8c5l9vlaCc2cWkZNdrlXsltWcctZcqQ9g/PhqN9scKsp2m0hub/nTaZQb92T0xJ3RIVVDv87foCz9p8PHDKZ+JQ9Dcde2dBAdQlIrlKuoQ2BBK3jIXXAVUqKK67QFovv2amy4pZUI+Q+3hAz3bbCpEzCvo/2IqzBaDw5xEBNgS+tduy4MdK3AgNAC/VaXiZ8bCvTK2JUXeVx+jEY9klikQXjlfWK0wDw0QSJ+9UFfS0xsoJZhA6geZ/9bQ7CH4rg9HFITV5G6+WiVeBcbkBGwFUIhTIx2+3mt5PrJh71Tg4PHuXRAPafCyNK7MAhle7Mr/n0FoCcbhpf/xUCY8W6ilVrqX9TSm4+Kr8XjFt+EY8IPPU3jjUlG34hJ1xZ07ewHXS9/+ntwf/z4L56KV1tzm1O43KiWKIbWOAz4e37vVr8LnopIHg/ESdS4tQrRCRQnM5lXX1D+oqy9x08UOYFPriw32GVivYXk1NWoyGdPuktbBTh8U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(54906003)(316002)(478600001)(7696005)(36756003)(2906002)(40460700003)(30864003)(6916009)(70206006)(40480700001)(4326008)(41300700001)(5660300002)(70586007)(8676002)(8936002)(356005)(82740400003)(81166007)(86362001)(16526019)(186003)(2616005)(82310400005)(1076003)(26005)(6666004)(36860700001)(83380400001)(66574015)(426003)(336012)(47076005)(36900700001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:20.2716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de97812-187c-4324-abf3-08db2efa8a7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

It looks better to place this field in ring
structure. Also drop the repeated ring funcs definitions
if there's no difference except for vmhub field.

v2: rename the field to vm_hub like others (Le)
v3: apply the changes to new ip blocks (Hawking)
v4: fix vcn sw ring (Alex)

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c   |  8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    |  5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    |  5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     |  7 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c    |  6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c    |  6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  8 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c    |  6 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c    | 99 ++++-------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c  |  4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c     |  8 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c     |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  8 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  8 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 84 +++----------------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     |  3 +-
 31 files changed, 92 insertions(+), 219 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c50d59855011..9d3a0542c996 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -305,6 +305,7 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 	ring->ring_obj = NULL;
 	ring->use_doorbell = true;
 	ring->doorbell_index = adev->doorbell_index.kiq;
+	ring->vm_hub = AMDGPU_GFXHUB_0;
 
 	r = amdgpu_gfx_kiq_acquire(adev, ring);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 2256284625d1..5906763e6e0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -523,7 +523,7 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->num_rings; ++i) {
 		ring = adev->rings[i];
-		vmhub = ring->funcs->vmhub;
+		vmhub = ring->vm_hub;
 
 		if (ring == &adev->mes.ring)
 			continue;
@@ -539,7 +539,7 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
 
 		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
-			 ring->name, ring->vm_inv_eng, ring->funcs->vmhub);
+			 ring->name, ring->vm_inv_eng, ring->vm_hub);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index bcccc348dbe2..2b6fdcf3bf60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -267,7 +267,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	if (r) {
 		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
 		if (job && job->vmid)
-			amdgpu_vmid_reset(adev, ring->funcs->vmhub, job->vmid);
+			amdgpu_vmid_reset(adev, ring->vm_hub, job->vmid);
 		amdgpu_ring_undo(ring);
 		return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 3f07b1a2ce47..c991ca0b7a1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -202,7 +202,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_vm *vm,
 				 struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	unsigned vmhub = ring->funcs->vmhub;
+	unsigned vmhub = ring->vm_hub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	struct dma_fence **fences;
 	unsigned i;
@@ -277,7 +277,7 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 				     struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	unsigned vmhub = ring->funcs->vmhub;
+	unsigned vmhub = ring->vm_hub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	uint64_t fence_context = adev->fence_context + ring->idx;
 	bool needs_flush = vm->use_cpu_for_update;
@@ -338,7 +338,7 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 				 struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	unsigned vmhub = ring->funcs->vmhub;
+	unsigned vmhub = ring->vm_hub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	uint64_t fence_context = adev->fence_context + ring->idx;
 	uint64_t updates = amdgpu_vm_tlb_seq(vm);
@@ -398,7 +398,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 		     struct amdgpu_job *job, struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	unsigned vmhub = ring->funcs->vmhub;
+	unsigned vmhub = ring->vm_hub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	struct amdgpu_vmid *idle = NULL;
 	struct amdgpu_vmid *id = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 3989e755a5b4..fd269d6ddbf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -164,7 +164,6 @@ struct amdgpu_ring_funcs {
 	bool			support_64bit_ptrs;
 	bool			no_user_fence;
 	bool			secure_submission_supported;
-	unsigned		vmhub;
 	unsigned		extra_dw;
 
 	/* ring read/write ptr handling */
@@ -274,6 +273,7 @@ struct amdgpu_ring {
 	unsigned		cond_exe_offs;
 	u64			cond_exe_gpu_addr;
 	volatile u32		*cond_exe_cpu_addr;
+	unsigned		vm_hub;
 	unsigned		vm_inv_eng;
 	struct dma_fence	*vmid_wait;
 	bool			has_compute_vm_bug;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 98d91ebf5c26..525dffbe046a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -233,7 +233,7 @@ TRACE_EVENT(amdgpu_vm_grab_id,
 			   __entry->pasid = vm->pasid;
 			   __assign_str(ring, ring->name);
 			   __entry->vmid = job->vmid;
-			   __entry->vm_hub = ring->funcs->vmhub,
+			   __entry->vm_hub = ring->vm_hub,
 			   __entry->pd_addr = job->vm_pd_addr;
 			   __entry->needs_flush = job->vm_needs_flush;
 			   ),
@@ -427,7 +427,7 @@ TRACE_EVENT(amdgpu_vm_flush,
 	    TP_fast_assign(
 			   __assign_str(ring, ring->name);
 			   __entry->vmid = vmid;
-			   __entry->vm_hub = ring->funcs->vmhub;
+			   __entry->vm_hub = ring->vm_hub;
 			   __entry->pd_addr = pd_addr;
 			   ),
 	    TP_printk("ring=%s, id=%u, hub=%u, pd_addr=%010Lx",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index af6f26a97fc5..fa8f48a0fa84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -482,7 +482,7 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
 				  struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
-	unsigned vmhub = ring->funcs->vmhub;
+	unsigned vmhub = ring->vm_hub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 
 	if (job->vmid == 0)
@@ -516,7 +516,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		    bool need_pipe_sync)
 {
 	struct amdgpu_device *adev = ring->adev;
-	unsigned vmhub = ring->funcs->vmhub;
+	unsigned vmhub = ring->vm_hub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
 	bool spm_update_needed = job->spm_update_needed;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 516409989235..f5b5ce1051a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4461,6 +4461,7 @@ static int gfx_v10_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
 		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
 	else
 		ring->doorbell_index = adev->doorbell_index.gfx_ring1 << 1;
+	ring->vm_hub = AMDGPU_GFXHUB_0;
 	sprintf(ring->name, "gfx_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 
 	irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + ring->pipe;
@@ -4489,6 +4490,7 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	ring->doorbell_index = (adev->doorbell_index.mec_ring0 + ring_id) << 1;
 	ring->eop_gpu_addr = adev->gfx.mec.hpd_eop_gpu_addr
 				+ (ring_id * GFX10_MEC_HPD_SIZE);
+	ring->vm_hub = AMDGPU_GFXHUB_0;
 	sprintf(ring->name, "comp_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 
 	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
@@ -9249,7 +9251,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,
-	.vmhub = AMDGPU_GFXHUB_0,
 	.get_rptr = gfx_v10_0_ring_get_rptr_gfx,
 	.get_wptr = gfx_v10_0_ring_get_wptr_gfx,
 	.set_wptr = gfx_v10_0_ring_set_wptr_gfx,
@@ -9304,7 +9305,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.align_mask = 0xff,
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
-	.vmhub = AMDGPU_GFXHUB_0,
 	.get_rptr = gfx_v10_0_ring_get_rptr_compute,
 	.get_wptr = gfx_v10_0_ring_get_wptr_compute,
 	.set_wptr = gfx_v10_0_ring_set_wptr_compute,
@@ -9340,7 +9340,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
 	.align_mask = 0xff,
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
-	.vmhub = AMDGPU_GFXHUB_0,
 	.get_rptr = gfx_v10_0_ring_get_rptr_compute,
 	.get_wptr = gfx_v10_0_ring_get_wptr_compute,
 	.set_wptr = gfx_v10_0_ring_set_wptr_compute,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ecf8ceb53311..c3b15d878bb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -866,6 +866,7 @@ static int gfx_v11_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
 		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
 	else
 		ring->doorbell_index = adev->doorbell_index.gfx_ring1 << 1;
+	ring->vm_hub = AMDGPU_GFXHUB_0;
 	sprintf(ring->name, "gfx_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 
 	irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + ring->pipe;
@@ -896,6 +897,7 @@ static int gfx_v11_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	ring->doorbell_index = (adev->doorbell_index.mec_ring0 + ring_id) << 1;
 	ring->eop_gpu_addr = adev->gfx.mec.hpd_eop_gpu_addr
 				+ (ring_id * GFX11_MEC_HPD_SIZE);
+	ring->vm_hub = AMDGPU_GFXHUB_0;
 	sprintf(ring->name, "comp_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 
 	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
@@ -6191,7 +6193,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,
-	.vmhub = AMDGPU_GFXHUB_0,
 	.get_rptr = gfx_v11_0_ring_get_rptr_gfx,
 	.get_wptr = gfx_v11_0_ring_get_wptr_gfx,
 	.set_wptr = gfx_v11_0_ring_set_wptr_gfx,
@@ -6239,7 +6240,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.align_mask = 0xff,
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
-	.vmhub = AMDGPU_GFXHUB_0,
 	.get_rptr = gfx_v11_0_ring_get_rptr_compute,
 	.get_wptr = gfx_v11_0_ring_get_wptr_compute,
 	.set_wptr = gfx_v11_0_ring_set_wptr_compute,
@@ -6275,7 +6275,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
 	.align_mask = 0xff,
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
-	.vmhub = AMDGPU_GFXHUB_0,
 	.get_rptr = gfx_v11_0_ring_get_rptr_compute,
 	.get_wptr = gfx_v11_0_ring_get_wptr_compute,
 	.set_wptr = gfx_v11_0_ring_set_wptr_compute,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ae09fc1cfe6b..ac0f53888dcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1995,6 +1995,7 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	ring->doorbell_index = (adev->doorbell_index.mec_ring0 + ring_id) << 1;
 	ring->eop_gpu_addr = adev->gfx.mec.hpd_eop_gpu_addr
 				+ (ring_id * GFX9_MEC_HPD_SIZE);
+	ring->vm_hub = AMDGPU_GFXHUB_0;
 	sprintf(ring->name, "comp_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 
 	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
@@ -2094,6 +2095,7 @@ static int gfx_v9_0_sw_init(void *handle)
 
 		/* disable scheduler on the real ring */
 		ring->no_scheduler = true;
+		ring->vm_hub = AMDGPU_GFXHUB_0;
 		r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
 				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
 				     AMDGPU_RING_PRIO_DEFAULT, NULL);
@@ -2111,6 +2113,7 @@ static int gfx_v9_0_sw_init(void *handle)
 			ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
 			ring->is_sw_ring = true;
 			hw_prio = amdgpu_sw_ring_priority(i);
+			ring->vm_hub = AMDGPU_GFXHUB_0;
 			r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
 					     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP, hw_prio,
 					     NULL);
@@ -6750,7 +6753,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,
-	.vmhub = AMDGPU_GFXHUB_0,
 	.get_rptr = gfx_v9_0_ring_get_rptr_gfx,
 	.get_wptr = gfx_v9_0_ring_get_wptr_gfx,
 	.set_wptr = gfx_v9_0_ring_set_wptr_gfx,
@@ -6804,7 +6806,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,
-	.vmhub = AMDGPU_GFXHUB_0,
 	.get_rptr = amdgpu_sw_ring_get_rptr_gfx,
 	.get_wptr = amdgpu_sw_ring_get_wptr_gfx,
 	.set_wptr = amdgpu_sw_ring_set_wptr_gfx,
@@ -6858,7 +6859,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.align_mask = 0xff,
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
-	.vmhub = AMDGPU_GFXHUB_0,
 	.get_rptr = gfx_v9_0_ring_get_rptr_compute,
 	.get_wptr = gfx_v9_0_ring_get_wptr_compute,
 	.set_wptr = gfx_v9_0_ring_set_wptr_compute,
@@ -6897,7 +6897,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
 	.align_mask = 0xff,
 	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
 	.support_64bit_ptrs = true,
-	.vmhub = AMDGPU_GFXHUB_0,
 	.get_rptr = gfx_v9_0_ring_get_rptr_compute,
 	.get_wptr = gfx_v9_0_ring_get_wptr_compute,
 	.set_wptr = gfx_v9_0_ring_set_wptr_compute,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d99821692ba3..7d6f4a68f416 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -479,8 +479,8 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 					     unsigned vmid, uint64_t pd_addr)
 {
-	bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(ring->adev, ring->funcs->vmhub);
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
+	bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(ring->adev, ring->vm_hub);
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
 	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
 	unsigned eng = ring->vm_inv_eng;
 
@@ -534,7 +534,7 @@ static void gmc_v10_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid
 	if (ring->is_mes_queue)
 		return;
 
-	if (ring->funcs->vmhub == AMDGPU_GFXHUB_0)
+	if (ring->vm_hub == AMDGPU_GFXHUB_0)
 		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_VMID_0_LUT) + vmid;
 	else
 		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_VMID_0_LUT_MM) + vmid;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 9f4f28192c60..d809f2ed5600 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -378,8 +378,8 @@ static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 static uint64_t gmc_v11_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 					     unsigned vmid, uint64_t pd_addr)
 {
-	bool use_semaphore = gmc_v11_0_use_invalidate_semaphore(ring->adev, ring->funcs->vmhub);
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
+	bool use_semaphore = gmc_v11_0_use_invalidate_semaphore(ring->adev, ring->vm_hub);
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
 	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
 	unsigned eng = ring->vm_inv_eng;
 
@@ -433,7 +433,7 @@ static void gmc_v11_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid
 	if (ring->is_mes_queue)
 		return;
 
-	if (ring->funcs->vmhub == AMDGPU_GFXHUB_0)
+	if (ring->vm_hub == AMDGPU_GFXHUB_0)
 		reg = SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid;
 	else
 		reg = SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT_MM) + vmid;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 67ad92097a65..327ef9d51cfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -990,9 +990,9 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 					    unsigned vmid, uint64_t pd_addr)
 {
-	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(ring->adev, ring->funcs->vmhub);
+	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(ring->adev, ring->vm_hub);
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_vmhub *hub = &adev->vmhub[ring->funcs->vmhub];
+	struct amdgpu_vmhub *hub = &adev->vmhub[ring->vm_hub];
 	uint32_t req = gmc_v9_0_get_invalidate_req(vmid, 0);
 	unsigned eng = ring->vm_inv_eng;
 
@@ -1043,10 +1043,10 @@ static void gmc_v9_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid,
 	uint32_t reg;
 
 	/* Do nothing because there's no lut register for mmhub1. */
-	if (ring->funcs->vmhub == AMDGPU_MMHUB_1)
+	if (ring->vm_hub == AMDGPU_MMHUB_1)
 		return;
 
-	if (ring->funcs->vmhub == AMDGPU_GFXHUB_0)
+	if (ring->vm_hub == AMDGPU_GFXHUB_0)
 		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_VMID_0_LUT) + vmid;
 	else
 		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_VMID_0_LUT_MM) + vmid;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 9360204da7fb..a3076eb8af6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -376,7 +376,7 @@ static void jpeg_v1_0_decode_ring_emit_reg_wait(struct amdgpu_ring *ring,
 static void jpeg_v1_0_decode_ring_emit_vm_flush(struct amdgpu_ring *ring,
 		unsigned vmid, uint64_t pd_addr)
 {
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
 	uint32_t data0, data1, mask;
 
 	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
@@ -485,6 +485,7 @@ int jpeg_v1_0_sw_init(void *handle)
 		return r;
 
 	ring = &adev->jpeg.inst->ring_dec;
+	ring->vm_hub = AMDGPU_MMHUB_0;
 	sprintf(ring->name, "jpeg_dec");
 	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq,
 			     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
@@ -548,7 +549,6 @@ static const struct amdgpu_ring_funcs jpeg_v1_0_decode_ring_vm_funcs = {
 	.nop = PACKET0(0x81ff, 0),
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
-	.vmhub = AMDGPU_MMHUB_0,
 	.extra_dw = 64,
 	.get_rptr = jpeg_v1_0_decode_ring_get_rptr,
 	.get_wptr = jpeg_v1_0_decode_ring_get_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index f3c1af5130ab..0eddf7c824a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -86,6 +86,7 @@ static int jpeg_v2_0_sw_init(void *handle)
 	ring = &adev->jpeg.inst->ring_dec;
 	ring->use_doorbell = true;
 	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1;
+	ring->vm_hub = AMDGPU_MMHUB_0;
 	sprintf(ring->name, "jpeg_dec");
 	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq,
 			     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
@@ -613,7 +614,7 @@ void jpeg_v2_0_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 void jpeg_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 				unsigned vmid, uint64_t pd_addr)
 {
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
 	uint32_t data0, data1, mask;
 
 	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
@@ -762,7 +763,6 @@ static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
-	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = jpeg_v2_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_0_dec_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 6b1887808782..b040f51d9aa9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -127,6 +127,10 @@ static int jpeg_v2_5_sw_init(void *handle)
 
 		ring = &adev->jpeg.inst[i].ring_dec;
 		ring->use_doorbell = true;
+		if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(2, 5, 0))
+			ring->vm_hub = AMDGPU_MMHUB_1;
+		else
+			ring->vm_hub = AMDGPU_MMHUB_0;
 		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + 8 * i;
 		sprintf(ring->name, "jpeg_dec_%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst[i].irq,
@@ -645,7 +649,6 @@ static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
-	.vmhub = AMDGPU_MMHUB_1,
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_5_dec_ring_set_wptr,
@@ -675,7 +678,6 @@ static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_6_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
-	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_5_dec_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index a1b751d9ac06..c55e09432e26 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -100,6 +100,7 @@ static int jpeg_v3_0_sw_init(void *handle)
 	ring = &adev->jpeg.inst->ring_dec;
 	ring->use_doorbell = true;
 	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1;
+	ring->vm_hub = AMDGPU_MMHUB_0;
 	sprintf(ring->name, "jpeg_dec");
 	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
 			     AMDGPU_RING_PRIO_DEFAULT, NULL);
@@ -559,7 +560,6 @@ static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
-	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = jpeg_v3_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v3_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v3_0_dec_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 5f2a034b9ec0..a6ad678fd507 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -108,6 +108,7 @@ static int jpeg_v4_0_sw_init(void *handle)
 	ring = &adev->jpeg.inst->ring_dec;
 	ring->use_doorbell = true;
 	ring->doorbell_index = amdgpu_sriov_vf(adev) ? (((adev->doorbell_index.vcn.vcn_ring0_1) << 1) + 4) : ((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1);
+	ring->vm_hub = AMDGPU_MMHUB_0;
 
 	sprintf(ring->name, "jpeg_dec");
 	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
@@ -715,7 +716,6 @@ static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v4_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
-	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = jpeg_v4_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_dec_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index b5affba22156..c94398565514 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1823,6 +1823,15 @@ static int sdma_v4_0_sw_init(void *handle)
 		/* doorbell size is 2 dwords, get DWORD offset */
 		ring->doorbell_index = adev->doorbell_index.sdma_engine[i] << 1;
 
+		/*
+		 * On Arcturus, SDMA instance 5~7 has a different vmhub
+		 * type(AMDGPU_MMHUB_1).
+		 */
+		if (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 2, 2) && i >= 5)
+			ring->vm_hub = AMDGPU_MMHUB_1;
+		else
+			ring->vm_hub = AMDGPU_MMHUB_0;
+
 		sprintf(ring->name, "sdma%d", i);
 		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
 				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
@@ -1841,6 +1850,11 @@ static int sdma_v4_0_sw_init(void *handle)
 			ring->doorbell_index = adev->doorbell_index.sdma_engine[i] << 1;
 			ring->doorbell_index += 0x400;
 
+			if (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 2, 2) && i >= 5)
+				ring->vm_hub = AMDGPU_MMHUB_1;
+			else
+				ring->vm_hub = AMDGPU_MMHUB_0;
+
 			sprintf(ring->name, "page%d", i);
 			r = amdgpu_ring_init(adev, ring, 1024,
 					     &adev->sdma.trap_irq,
@@ -2294,44 +2308,6 @@ static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs = {
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,
-	.vmhub = AMDGPU_MMHUB_0,
-	.get_rptr = sdma_v4_0_ring_get_rptr,
-	.get_wptr = sdma_v4_0_ring_get_wptr,
-	.set_wptr = sdma_v4_0_ring_set_wptr,
-	.emit_frame_size =
-		6 + /* sdma_v4_0_ring_emit_hdp_flush */
-		3 + /* hdp invalidate */
-		6 + /* sdma_v4_0_ring_emit_pipeline_sync */
-		/* sdma_v4_0_ring_emit_vm_flush */
-		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
-		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
-		10 + 10 + 10, /* sdma_v4_0_ring_emit_fence x3 for user fence, vm fence */
-	.emit_ib_size = 7 + 6, /* sdma_v4_0_ring_emit_ib */
-	.emit_ib = sdma_v4_0_ring_emit_ib,
-	.emit_fence = sdma_v4_0_ring_emit_fence,
-	.emit_pipeline_sync = sdma_v4_0_ring_emit_pipeline_sync,
-	.emit_vm_flush = sdma_v4_0_ring_emit_vm_flush,
-	.emit_hdp_flush = sdma_v4_0_ring_emit_hdp_flush,
-	.test_ring = sdma_v4_0_ring_test_ring,
-	.test_ib = sdma_v4_0_ring_test_ib,
-	.insert_nop = sdma_v4_0_ring_insert_nop,
-	.pad_ib = sdma_v4_0_ring_pad_ib,
-	.emit_wreg = sdma_v4_0_ring_emit_wreg,
-	.emit_reg_wait = sdma_v4_0_ring_emit_reg_wait,
-	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
-};
-
-/*
- * On Arcturus, SDMA instance 5~7 has a different vmhub type(AMDGPU_MMHUB_1).
- * So create a individual constant ring_funcs for those instances.
- */
-static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs_2nd_mmhub = {
-	.type = AMDGPU_RING_TYPE_SDMA,
-	.align_mask = 0xf,
-	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
-	.support_64bit_ptrs = true,
-	.secure_submission_supported = true,
-	.vmhub = AMDGPU_MMHUB_1,
 	.get_rptr = sdma_v4_0_ring_get_rptr,
 	.get_wptr = sdma_v4_0_ring_get_wptr,
 	.set_wptr = sdma_v4_0_ring_set_wptr,
@@ -2364,40 +2340,6 @@ static const struct amdgpu_ring_funcs sdma_v4_0_page_ring_funcs = {
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,
-	.vmhub = AMDGPU_MMHUB_0,
-	.get_rptr = sdma_v4_0_ring_get_rptr,
-	.get_wptr = sdma_v4_0_page_ring_get_wptr,
-	.set_wptr = sdma_v4_0_page_ring_set_wptr,
-	.emit_frame_size =
-		6 + /* sdma_v4_0_ring_emit_hdp_flush */
-		3 + /* hdp invalidate */
-		6 + /* sdma_v4_0_ring_emit_pipeline_sync */
-		/* sdma_v4_0_ring_emit_vm_flush */
-		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
-		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
-		10 + 10 + 10, /* sdma_v4_0_ring_emit_fence x3 for user fence, vm fence */
-	.emit_ib_size = 7 + 6, /* sdma_v4_0_ring_emit_ib */
-	.emit_ib = sdma_v4_0_ring_emit_ib,
-	.emit_fence = sdma_v4_0_ring_emit_fence,
-	.emit_pipeline_sync = sdma_v4_0_ring_emit_pipeline_sync,
-	.emit_vm_flush = sdma_v4_0_ring_emit_vm_flush,
-	.emit_hdp_flush = sdma_v4_0_ring_emit_hdp_flush,
-	.test_ring = sdma_v4_0_ring_test_ring,
-	.test_ib = sdma_v4_0_ring_test_ib,
-	.insert_nop = sdma_v4_0_ring_insert_nop,
-	.pad_ib = sdma_v4_0_ring_pad_ib,
-	.emit_wreg = sdma_v4_0_ring_emit_wreg,
-	.emit_reg_wait = sdma_v4_0_ring_emit_reg_wait,
-	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
-};
-
-static const struct amdgpu_ring_funcs sdma_v4_0_page_ring_funcs_2nd_mmhub = {
-	.type = AMDGPU_RING_TYPE_SDMA,
-	.align_mask = 0xf,
-	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
-	.support_64bit_ptrs = true,
-	.secure_submission_supported = true,
-	.vmhub = AMDGPU_MMHUB_1,
 	.get_rptr = sdma_v4_0_ring_get_rptr,
 	.get_wptr = sdma_v4_0_page_ring_get_wptr,
 	.set_wptr = sdma_v4_0_page_ring_set_wptr,
@@ -2429,19 +2371,10 @@ static void sdma_v4_0_set_ring_funcs(struct amdgpu_device *adev)
 	int i;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 2, 2) && i >= 5)
-			adev->sdma.instance[i].ring.funcs =
-					&sdma_v4_0_ring_funcs_2nd_mmhub;
-		else
-			adev->sdma.instance[i].ring.funcs =
-					&sdma_v4_0_ring_funcs;
+		adev->sdma.instance[i].ring.funcs = &sdma_v4_0_ring_funcs;
 		adev->sdma.instance[i].ring.me = i;
 		if (adev->sdma.has_page_queue) {
-			if (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 2, 2) && i >= 5)
-				adev->sdma.instance[i].page.funcs =
-					&sdma_v4_0_page_ring_funcs_2nd_mmhub;
-			else
-				adev->sdma.instance[i].page.funcs =
+			adev->sdma.instance[i].page.funcs =
 					&sdma_v4_0_page_ring_funcs;
 			adev->sdma.instance[i].page.me = i;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 1b04700a4d55..64dcaa2670dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1309,6 +1309,7 @@ static int sdma_v4_4_2_sw_init(void *handle)
 
 		/* doorbell size is 2 dwords, get DWORD offset */
 		ring->doorbell_index = adev->doorbell_index.sdma_engine[i] << 1;
+		ring->vm_hub = AMDGPU_MMHUB_0;
 
 		sprintf(ring->name, "sdma%d", i);
 		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
@@ -1327,6 +1328,7 @@ static int sdma_v4_4_2_sw_init(void *handle)
 			 */
 			ring->doorbell_index = adev->doorbell_index.sdma_engine[i] << 1;
 			ring->doorbell_index += 0x400;
+			ring->vm_hub = AMDGPU_MMHUB_0;
 
 			sprintf(ring->name, "page%d", i);
 			r = amdgpu_ring_init(adev, ring, 1024,
@@ -1741,7 +1743,6 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.align_mask = 0xf,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
-	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = sdma_v4_4_2_ring_get_rptr,
 	.get_wptr = sdma_v4_4_2_ring_get_wptr,
 	.set_wptr = sdma_v4_4_2_ring_set_wptr,
@@ -1773,7 +1774,6 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 	.align_mask = 0xf,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
-	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = sdma_v4_4_2_ring_get_rptr,
 	.get_wptr = sdma_v4_4_2_page_ring_get_wptr,
 	.set_wptr = sdma_v4_4_2_page_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 1941b3b7c5d9..92e1299be021 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1389,6 +1389,7 @@ static int sdma_v5_0_sw_init(void *handle)
 			(adev->doorbell_index.sdma_engine[0] << 1) //get DWORD offset
 			: (adev->doorbell_index.sdma_engine[1] << 1); // get DWORD offset
 
+		ring->vm_hub = AMDGPU_GFXHUB_0;
 		sprintf(ring->name, "sdma%d", i);
 		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
 				     (i == 0) ? AMDGPU_SDMA_IRQ_INSTANCE0 :
@@ -1765,7 +1766,6 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,
-	.vmhub = AMDGPU_GFXHUB_0,
 	.get_rptr = sdma_v5_0_ring_get_rptr,
 	.get_wptr = sdma_v5_0_ring_get_wptr,
 	.set_wptr = sdma_v5_0_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 8e445eb9dd49..ca7e8757d78e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1253,6 +1253,7 @@ static int sdma_v5_2_sw_init(void *handle)
 		ring->doorbell_index =
 			(adev->doorbell_index.sdma_engine[i] << 1); //get DWORD offset
 
+		ring->vm_hub = AMDGPU_GFXHUB_0;
 		sprintf(ring->name, "sdma%d", i);
 		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
 				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
@@ -1653,7 +1654,6 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,
-	.vmhub = AMDGPU_GFXHUB_0,
 	.get_rptr = sdma_v5_2_ring_get_rptr,
 	.get_wptr = sdma_v5_2_ring_get_wptr,
 	.set_wptr = sdma_v5_2_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 40e6b22daa22..67e937158724 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1272,6 +1272,7 @@ static int sdma_v6_0_sw_init(void *handle)
 		ring->doorbell_index =
 			(adev->doorbell_index.sdma_engine[i] << 1); // get DWORD offset
 
+		ring->vm_hub = AMDGPU_GFXHUB_0;
 		sprintf(ring->name, "sdma%d", i);
 		r = amdgpu_ring_init(adev, ring, 1024,
 				     &adev->sdma.trap_irq,
@@ -1528,7 +1529,6 @@ static const struct amdgpu_ring_funcs sdma_v6_0_ring_funcs = {
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,
-	.vmhub = AMDGPU_GFXHUB_0,
 	.get_rptr = sdma_v6_0_ring_get_rptr,
 	.get_wptr = sdma_v6_0_ring_get_wptr,
 	.set_wptr = sdma_v6_0_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index e407be6cb63c..e32b656b3dab 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -444,6 +444,7 @@ static int uvd_v7_0_sw_init(void *handle)
 			continue;
 		if (!amdgpu_sriov_vf(adev)) {
 			ring = &adev->uvd.inst[j].ring;
+			ring->vm_hub = AMDGPU_MMHUB_0;
 			sprintf(ring->name, "uvd_%d", ring->me);
 			r = amdgpu_ring_init(adev, ring, 512,
 					     &adev->uvd.inst[j].irq, 0,
@@ -454,6 +455,7 @@ static int uvd_v7_0_sw_init(void *handle)
 
 		for (i = 0; i < adev->uvd.num_enc_rings; ++i) {
 			ring = &adev->uvd.inst[j].ring_enc[i];
+			ring->vm_hub = AMDGPU_MMHUB_0;
 			sprintf(ring->name, "uvd_enc_%d.%d", ring->me, i);
 			if (amdgpu_sriov_vf(adev)) {
 				ring->use_doorbell = true;
@@ -1397,7 +1399,7 @@ static void uvd_v7_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 static void uvd_v7_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 					unsigned vmid, uint64_t pd_addr)
 {
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
 	uint32_t data0, data1, mask;
 
 	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
@@ -1440,7 +1442,7 @@ static void uvd_v7_0_enc_ring_emit_reg_wait(struct amdgpu_ring *ring,
 static void uvd_v7_0_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
 					    unsigned int vmid, uint64_t pd_addr)
 {
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
 
 	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
@@ -1802,7 +1804,6 @@ static const struct amdgpu_ring_funcs uvd_v7_0_ring_vm_funcs = {
 	.align_mask = 0xf,
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
-	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = uvd_v7_0_ring_get_rptr,
 	.get_wptr = uvd_v7_0_ring_get_wptr,
 	.set_wptr = uvd_v7_0_ring_set_wptr,
@@ -1835,7 +1836,6 @@ static const struct amdgpu_ring_funcs uvd_v7_0_enc_ring_vm_funcs = {
 	.nop = HEVC_ENC_CMD_NO_OP,
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
-	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = uvd_v7_0_enc_ring_get_rptr,
 	.get_wptr = uvd_v7_0_enc_ring_get_wptr,
 	.set_wptr = uvd_v7_0_enc_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 66cd3d11aa4b..57b85bb6a1e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -466,6 +466,7 @@ static int vce_v4_0_sw_init(void *handle)
 		enum amdgpu_ring_priority_level hw_prio = amdgpu_vce_get_ring_prio(i);
 
 		ring = &adev->vce.ring[i];
+		ring->vm_hub = AMDGPU_MMHUB_0;
 		sprintf(ring->name, "vce%d", i);
 		if (amdgpu_sriov_vf(adev)) {
 			/* DOORBELL only works under SRIOV */
@@ -1021,7 +1022,7 @@ static void vce_v4_0_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 static void vce_v4_0_emit_vm_flush(struct amdgpu_ring *ring,
 				   unsigned int vmid, uint64_t pd_addr)
 {
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
 
 	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
@@ -1103,7 +1104,6 @@ static const struct amdgpu_ring_funcs vce_v4_0_ring_vm_funcs = {
 	.nop = VCE_CMD_NO_OP,
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
-	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vce_v4_0_ring_get_rptr,
 	.get_wptr = vce_v4_0_ring_get_wptr,
 	.set_wptr = vce_v4_0_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
index 1ceda3d0cd5b..2b9ddb3d2fe1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
@@ -65,7 +65,7 @@ void vcn_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 void vcn_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	uint32_t vmid, uint64_t pd_addr)
 {
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
 	uint32_t data0, data1, mask;
 
 	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index c305b2cb8490..761c28fa6ec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -120,6 +120,7 @@ static int vcn_v1_0_sw_init(void *handle)
 		return r;
 
 	ring = &adev->vcn.inst->ring_dec;
+	ring->vm_hub = AMDGPU_MMHUB_0;
 	sprintf(ring->name, "vcn_dec");
 	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
 			     AMDGPU_RING_PRIO_DEFAULT, NULL);
@@ -141,6 +142,7 @@ static int vcn_v1_0_sw_init(void *handle)
 		enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
 
 		ring = &adev->vcn.inst->ring_enc[i];
+		ring->vm_hub = AMDGPU_MMHUB_0;
 		sprintf(ring->name, "vcn_enc%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
 				     hw_prio, NULL);
@@ -1548,7 +1550,7 @@ static void vcn_v1_0_dec_ring_emit_reg_wait(struct amdgpu_ring *ring,
 static void vcn_v1_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 					    unsigned vmid, uint64_t pd_addr)
 {
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
 	uint32_t data0, data1, mask;
 
 	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
@@ -1693,7 +1695,7 @@ static void vcn_v1_0_enc_ring_emit_reg_wait(struct amdgpu_ring *ring,
 static void vcn_v1_0_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
 					    unsigned int vmid, uint64_t pd_addr)
 {
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
 
 	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
@@ -1977,7 +1979,6 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
 	.secure_submission_supported = true,
-	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
 	.set_wptr = vcn_v1_0_dec_ring_set_wptr,
@@ -2012,7 +2013,6 @@ static const struct amdgpu_ring_funcs vcn_v1_0_enc_ring_vm_funcs = {
 	.nop = VCN_ENC_CMD_NO_OP,
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
-	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v1_0_enc_ring_get_rptr,
 	.get_wptr = vcn_v1_0_enc_ring_get_wptr,
 	.set_wptr = vcn_v1_0_enc_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 4b4cd88414e0..7c2b3aa48083 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -129,6 +129,7 @@ static int vcn_v2_0_sw_init(void *handle)
 
 	ring->use_doorbell = true;
 	ring->doorbell_index = adev->doorbell_index.vcn.vcn_ring0_1 << 1;
+	ring->vm_hub = AMDGPU_MMHUB_0;
 
 	sprintf(ring->name, "vcn_dec");
 	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
@@ -159,6 +160,7 @@ static int vcn_v2_0_sw_init(void *handle)
 
 		ring = &adev->vcn.inst->ring_enc[i];
 		ring->use_doorbell = true;
+		ring->vm_hub = AMDGPU_MMHUB_0;
 		if (!amdgpu_sriov_vf(adev))
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + i;
 		else
@@ -1511,7 +1513,7 @@ void vcn_v2_0_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 void vcn_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 				unsigned vmid, uint64_t pd_addr)
 {
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
 	uint32_t data0, data1, mask;
 
 	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
@@ -1671,7 +1673,7 @@ void vcn_v2_0_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 void vcn_v2_0_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
 				unsigned int vmid, uint64_t pd_addr)
 {
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
 
 	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
@@ -2014,7 +2016,6 @@ static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
 	.secure_submission_supported = true,
-	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v2_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v2_0_dec_ring_get_wptr,
 	.set_wptr = vcn_v2_0_dec_ring_set_wptr,
@@ -2045,7 +2046,6 @@ static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
-	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v2_0_enc_ring_get_rptr,
 	.get_wptr = vcn_v2_0_enc_ring_get_wptr,
 	.set_wptr = vcn_v2_0_enc_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 223e7dfe4618..ab0b45d0ead1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -186,6 +186,12 @@ static int vcn_v2_5_sw_init(void *handle)
 
 		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
 				(amdgpu_sriov_vf(adev) ? 2*j : 8*j);
+
+		if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(2, 5, 0))
+			ring->vm_hub = AMDGPU_MMHUB_1;
+		else
+			ring->vm_hub = AMDGPU_MMHUB_0;
+
 		sprintf(ring->name, "vcn_dec_%d", j);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq,
 				     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
@@ -201,6 +207,11 @@ static int vcn_v2_5_sw_init(void *handle)
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
 					(amdgpu_sriov_vf(adev) ? (1 + i + 2*j) : (2 + i + 8*j));
 
+			if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(2, 5, 0))
+				ring->vm_hub = AMDGPU_MMHUB_1;
+			else
+				ring->vm_hub = AMDGPU_MMHUB_0;
+
 			sprintf(ring->name, "vcn_enc_%d.%d", j, i);
 			r = amdgpu_ring_init(adev, ring, 512,
 					     &adev->vcn.inst[j].irq, 0,
@@ -1562,38 +1573,6 @@ static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
 	.secure_submission_supported = true,
-	.vmhub = AMDGPU_MMHUB_1,
-	.get_rptr = vcn_v2_5_dec_ring_get_rptr,
-	.get_wptr = vcn_v2_5_dec_ring_get_wptr,
-	.set_wptr = vcn_v2_5_dec_ring_set_wptr,
-	.emit_frame_size =
-		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
-		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
-		8 + /* vcn_v2_0_dec_ring_emit_vm_flush */
-		14 + 14 + /* vcn_v2_0_dec_ring_emit_fence x2 vm fence */
-		6,
-	.emit_ib_size = 8, /* vcn_v2_0_dec_ring_emit_ib */
-	.emit_ib = vcn_v2_0_dec_ring_emit_ib,
-	.emit_fence = vcn_v2_0_dec_ring_emit_fence,
-	.emit_vm_flush = vcn_v2_0_dec_ring_emit_vm_flush,
-	.test_ring = vcn_v2_0_dec_ring_test_ring,
-	.test_ib = amdgpu_vcn_dec_ring_test_ib,
-	.insert_nop = vcn_v2_0_dec_ring_insert_nop,
-	.insert_start = vcn_v2_0_dec_ring_insert_start,
-	.insert_end = vcn_v2_0_dec_ring_insert_end,
-	.pad_ib = amdgpu_ring_generic_pad_ib,
-	.begin_use = amdgpu_vcn_ring_begin_use,
-	.end_use = amdgpu_vcn_ring_end_use,
-	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
-	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
-	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
-};
-
-static const struct amdgpu_ring_funcs vcn_v2_6_dec_ring_vm_funcs = {
-	.type = AMDGPU_RING_TYPE_VCN_DEC,
-	.align_mask = 0xf,
-	.secure_submission_supported = true,
-	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v2_5_dec_ring_get_rptr,
 	.get_wptr = vcn_v2_5_dec_ring_get_wptr,
 	.set_wptr = vcn_v2_5_dec_ring_set_wptr,
@@ -1693,7 +1672,6 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
-	.vmhub = AMDGPU_MMHUB_1,
 	.get_rptr = vcn_v2_5_enc_ring_get_rptr,
 	.get_wptr = vcn_v2_5_enc_ring_get_wptr,
 	.set_wptr = vcn_v2_5_enc_ring_set_wptr,
@@ -1719,36 +1697,6 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
-static const struct amdgpu_ring_funcs vcn_v2_6_enc_ring_vm_funcs = {
-        .type = AMDGPU_RING_TYPE_VCN_ENC,
-        .align_mask = 0x3f,
-        .nop = VCN_ENC_CMD_NO_OP,
-        .vmhub = AMDGPU_MMHUB_0,
-        .get_rptr = vcn_v2_5_enc_ring_get_rptr,
-        .get_wptr = vcn_v2_5_enc_ring_get_wptr,
-        .set_wptr = vcn_v2_5_enc_ring_set_wptr,
-        .emit_frame_size =
-                SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
-                SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
-                4 + /* vcn_v2_0_enc_ring_emit_vm_flush */
-                5 + 5 + /* vcn_v2_0_enc_ring_emit_fence x2 vm fence */
-                1, /* vcn_v2_0_enc_ring_insert_end */
-        .emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
-        .emit_ib = vcn_v2_0_enc_ring_emit_ib,
-        .emit_fence = vcn_v2_0_enc_ring_emit_fence,
-        .emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
-        .test_ring = amdgpu_vcn_enc_ring_test_ring,
-        .test_ib = amdgpu_vcn_enc_ring_test_ib,
-        .insert_nop = amdgpu_ring_insert_nop,
-        .insert_end = vcn_v2_0_enc_ring_insert_end,
-        .pad_ib = amdgpu_ring_generic_pad_ib,
-        .begin_use = amdgpu_vcn_ring_begin_use,
-        .end_use = amdgpu_vcn_ring_end_use,
-        .emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
-        .emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
-        .emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
-};
-
 static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
 	int i;
@@ -1756,10 +1704,7 @@ static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
-		if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(2, 5, 0))
-			adev->vcn.inst[i].ring_dec.funcs = &vcn_v2_5_dec_ring_vm_funcs;
-		else /* CHIP_ALDEBARAN */
-			adev->vcn.inst[i].ring_dec.funcs = &vcn_v2_6_dec_ring_vm_funcs;
+		adev->vcn.inst[i].ring_dec.funcs = &vcn_v2_5_dec_ring_vm_funcs;
 		adev->vcn.inst[i].ring_dec.me = i;
 		DRM_INFO("VCN(%d) decode is enabled in VM mode\n", i);
 	}
@@ -1773,10 +1718,7 @@ static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
 		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
-			if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(2, 5, 0))
-				adev->vcn.inst[j].ring_enc[i].funcs = &vcn_v2_5_enc_ring_vm_funcs;
-			else /* CHIP_ALDEBARAN */
-				adev->vcn.inst[j].ring_enc[i].funcs = &vcn_v2_6_enc_ring_vm_funcs;
+			adev->vcn.inst[j].ring_enc[i].funcs = &vcn_v2_5_enc_ring_vm_funcs;
 			adev->vcn.inst[j].ring_enc[i].me = j;
 		}
 		DRM_INFO("VCN(%d) encode is enabled in VM mode\n", j);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 66439388faee..3eab186261aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -189,6 +189,7 @@ static int vcn_v3_0_sw_init(void *handle)
 		} else {
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i;
 		}
+		ring->vm_hub = AMDGPU_MMHUB_0;
 		sprintf(ring->name, "vcn_dec_%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
 				     AMDGPU_RING_PRIO_DEFAULT,
@@ -212,6 +213,7 @@ static int vcn_v3_0_sw_init(void *handle)
 			} else {
 				ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
 			}
+			ring->vm_hub = AMDGPU_MMHUB_0;
 			sprintf(ring->name, "vcn_enc_%d.%d", i, j);
 			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
 					     hw_prio, &adev->vcn.inst[i].sched_score);
@@ -1738,7 +1740,6 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
 	.align_mask = 0x3f,
 	.nop = VCN_DEC_SW_CMD_NO_OP,
 	.secure_submission_supported = true,
-	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v3_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v3_0_dec_ring_get_wptr,
 	.set_wptr = vcn_v3_0_dec_ring_set_wptr,
@@ -1899,7 +1900,6 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
 	.secure_submission_supported = true,
-	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v3_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v3_0_dec_ring_get_wptr,
 	.set_wptr = vcn_v3_0_dec_ring_set_wptr,
@@ -2000,7 +2000,6 @@ static const struct amdgpu_ring_funcs vcn_v3_0_enc_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
-	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v3_0_enc_ring_get_rptr,
 	.get_wptr = vcn_v3_0_enc_ring_get_wptr,
 	.set_wptr = vcn_v3_0_enc_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 720ab36f9c92..bf0674039598 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -149,7 +149,7 @@ static int vcn_v4_0_sw_init(void *handle)
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + i * (adev->vcn.num_enc_rings + 1) + 1;
 		else
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + 8 * i;
-
+		ring->vm_hub = AMDGPU_MMHUB_0;
 		sprintf(ring->name, "vcn_unified_%d", i);
 
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
@@ -1798,7 +1798,6 @@ static const struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
-	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v4_0_unified_ring_get_rptr,
 	.get_wptr = vcn_v4_0_unified_ring_get_wptr,
 	.set_wptr = vcn_v4_0_unified_ring_set_wptr,
-- 
2.39.2

