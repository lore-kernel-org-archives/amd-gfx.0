Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3403C61DD6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58ED810EF15;
	Tue,  1 Sep 2026 20:11:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PMhLFiV9";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71DE810EF15
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKsTWQ32ltM8sqdmRyiWMhzUHI4/3NBSp7JdOTCP/lSmcSCOo03dJmX2qppoPj7j5274zk7fO1+iOM8yWRkUyseHPoGvLhM0ct+GoCBo0fq1HZ6U/YuzeqYP5xPY7vOBuEk0EDXkCYgmi0s4jfGCfv6AKYy53r7sTTGJJbxteCHppA7QChRjun48H6dhE9lFSHEri0BoHcKVRQqVXiaKmc0+5IyJ47uVDGvDZQYVVTLfnh1tUl/+KFpXBXxI1HJXoXfV0cb44QcDEmbWYmxppr+EELlGYkhzCuxGuD06slRCT6RPM7te93j3pVFKzlk+bfzu42Yy/mBxZOBR7To1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGxb6g4WyJ1gO+HyhzqP7z9cBk3LDGkTG+VKv9liRlA=;
 b=q9PMzoOPDyBa5WzSMm6nS6zkOyR4SB35V/F7uZmledhtfkmAGmWFHWvCR6WH3H07tv0rLeP86DZOeJipzhxOh18bpqd11JoNdeIiwoSJyj9bemgdqYHxAkE0x7nusGE23qme0wYHuz6xg/bAbOz/I49V5Ol9GEWDqcIcV19augfk2prWrIQkxYWUl+PWtossh223fyvGtReYnW7WPBeDco6hs8F0NtAlFfoXs0A3p4xermB827ho3RqNWAuL5egrj9H1wTcIVuE452mlOfL433CQuHcgpCWpnYUdqo5CImqqC4psQ+vHWErIHGGjMIwSuvcS5q0SgUNlnt6pSMSkVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGxb6g4WyJ1gO+HyhzqP7z9cBk3LDGkTG+VKv9liRlA=;
 b=PMhLFiV9CXi3jRjCFmleqX7E5cEXgPdkTpc6cPQTzSRpEuConMyQDj+rbiaq7z6PdI6n3K+yfWEOeypv53nAyi5EShryA0tnX7Rw/YdcoRwSSz/RoHVRyqhZKNTTB/p4zMJG7HYz7lFBzJ1W/xpUfGLzYRyqHy84Wwn/9DzuAZY=
Received: from CH0PR13CA0032.namprd13.prod.outlook.com (2603:10b6:610:b2::7)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:11:07 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::a4) by CH0PR13CA0032.outlook.office365.com
 (2603:10b6:610:b2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:11:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/31] drm/amdgpu/gmc: rework pasid flushing
Date: Tue, 1 Sep 2026 16:10:25 -0400
Message-ID: <20260901201034.2960437-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df226c0-9e2d-4b98-849f-08df0865277e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 9C2LKRTizWpnsvRVEFeYIw0HTJ7re8fuq/kLRyfLSXKegCW77VqlOJlUzzNxWTgoZwwdp0z0T0Ab4+VGXpbm9RW0NyLwuxp9UwlvI78KK+ENzxWmOXqqfkftLCS2n0Jqbehi42OB15JXXMnTghtbki4esONhDqjIZblme3hnUiR3V1QYjnMqOIQDtFEzoNLV+yujbGR+ONPcQyuHUrp37VL64Gca6wHupUUI8jG9knd/8XTHVlN8Inm81+XOKgAV7J7ps9PwmUaxYn6SbKuTtkBpjhLAiwhDftM5+Fy/UofEO7LEvpMtj/rSelWjRjiwkzVypWyufCnX3fW/mtmv9ZkB1lfQykQqH5VAiTfLjNEJvRTIzFj+Vs+bUmHiJst86XBMfJkaGZsXgOkhgE8juoAIjtB5wHfjU5xCjDR2B4+FikN0QgmSZRVdY9Ze4i8PkZIzmxN1Jhw7pfjvgYjw8CVGMVZqECnt3ZTkHPV95ZYYOZjeL+Poqb3ro0+eLVHmmK/j++sC7u2xrvyzg//zL+mmiIkUD+OlodwpRlr0MI2jJ1oi3WqphSGYDIJR6j22a1PtDMxp8veYyHI9EptgcNtLYyNqIbQRmu4MZ40WZHh4Yi7WOkSDYOE/HW6cqtgIub0WE3lVhDDmLrAdFsWuyMVuFptDopikvgKhb4gH9DslaoxFA5SYF+CNCKMI2Ky6CdwZOJbweTCyZHyXO3G4hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8m9DZjQql95nLR5u/c8VapA5UajuUoTC6BD7aYCiA9ynd5pFJdVa1n7Qpynu3amLWKmbtPIEe5LCvDQb+X1H2gaAkZ7kt6mxn5n+jMut9ALjBB7Dj+wMKUhW+mqzXzVsVk6PJZ1A8qCTf3eNXIY4SkBwlj8S7ka8lhk20bjfXt5A+cnyE1fWLcHilk/cqh8qVCzDwfYrCtN0K2/0ovUuT4qEvvtbL6aC8Fdy3HqSwmfGhrAVAHF7CGKYmOTVa/9+u3Jr6WrLsJYhy+qBA0iu+p0WujsIMI6Is30cqmBHNpGkhHPcHvR9nDZ6EQ2iePH6r3WK8bhxIMjtq/EpSSiwDrcVuD52wC6eo1sl59WP4f9CwgdU2LmGSUmEIdNEnM18BOi5GrMJRrbacEHUqKtI2HdM6glHNes3Gb+hGa/ATs1zOltcNusXa3qJzWrovPRK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:11:05.6786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df226c0-9e2d-4b98-849f-08df0865277e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139
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

Split out all of the various flush methods and use
the new pasid flush method enum to determine which
one to use.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 247 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |   2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |   2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |   2 +
 4 files changed, 201 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 8a975eddd75c7..2800eebe50649 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -788,9 +788,66 @@ void amdgpu_gmc_flush_gpu_tlb_gart(struct amdgpu_device *adev,
 	dev_err(adev->dev, "Error flushing GPU TLB using the SDMA (%d)!\n", r);
 }
 
-int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
-				   uint32_t flush_type, bool all_hub,
-				   uint32_t inst)
+static int amdgpu_gmc_flush_gpu_tlb_sdma_helper(struct amdgpu_device *adev,
+						uint16_t pasid, uint32_t flush_type,
+						bool all_hub, uint32_t inst)
+{
+	struct amdgpu_ring *ring;
+	struct dma_fence *fence;
+	struct amdgpu_job *job;
+	uint16_t queried;
+	/* Use register 17 for GART */
+	u32 eng = 17;
+	int vmid, r, i, ndw;
+
+	/* flush hdp cache */
+	amdgpu_device_flush_hdp(adev, NULL);
+
+	ndw = ALIGN(adev->mman.buffer_funcs->tlb_inv_num_dw * 16 * AMDGPU_MAX_VMHUBS, 8);
+	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
+
+	mutex_lock(&adev->mman.default_entity.lock);
+	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.default_entity.base,
+				     AMDGPU_FENCE_OWNER_UNDEFINED,
+				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
+				     AMDGPU_KERNEL_JOB_ID_VM_UPDATE,
+				     &job);
+	if (r)
+		goto exit;
+
+	for (vmid = 1; vmid < 16; vmid++) {
+		bool valid;
+
+		valid = adev->gmc.gmc_funcs->get_vmid_pasid_mapping_info(adev, vmid, inst,
+									 &queried);
+		if (!valid || queried != pasid)
+			continue;
+
+		if (all_hub) {
+			for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
+				amdgpu_emit_tlb_inv(adev, &job->ibs[0], vmid, i, eng,
+						    flush_type, inst);
+		} else {
+			amdgpu_emit_tlb_inv(adev, &job->ibs[0], vmid, AMDGPU_GFXHUB(inst), eng,
+					    flush_type, inst);
+		}
+	}
+	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
+	fence = amdgpu_job_submit(job);
+	mutex_unlock(&adev->mman.default_entity.lock);
+
+	dma_fence_wait(fence, false);
+	dma_fence_put(fence);
+
+exit:
+	mutex_unlock(&adev->mman.default_entity.lock);
+
+	return r;
+}
+
+static int amdgpu_gmc_flush_gpu_tlb_kiq_helper(struct amdgpu_device *adev,
+					       uint16_t pasid, uint32_t flush_type,
+					       bool all_hub, uint32_t inst)
 {
 	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
@@ -798,6 +855,110 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 	int r, cnt = 0;
 	uint32_t seq;
 
+	/* 2 dwords flush + 8 dwords fence */
+	ndw = kiq->pmf->invalidate_tlbs_size + 8;
+
+	if (adev->gmc.flush_tlb_needs_extra_type_2)
+		ndw += kiq->pmf->invalidate_tlbs_size;
+
+	if (adev->gmc.flush_tlb_needs_extra_type_0)
+		ndw += kiq->pmf->invalidate_tlbs_size;
+
+	spin_lock(&adev->gfx.kiq[inst].ring_lock);
+	r = amdgpu_ring_alloc(ring, ndw);
+	if (r) {
+		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
+		return r;
+	}
+	if (adev->gmc.flush_tlb_needs_extra_type_2)
+		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
+
+	if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
+		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
+
+	kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
+	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
+	if (r) {
+		amdgpu_ring_undo(ring);
+		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
+		return r;
+	}
+
+	amdgpu_ring_commit(ring);
+	spin_unlock(&adev->gfx.kiq[inst].ring_lock);
+
+	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+
+	might_sleep();
+	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
+	       !amdgpu_reset_pending(adev->reset_domain)) {
+		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+	}
+
+	if (cnt > MAX_KIQ_REG_TRY) {
+		dev_err(adev->dev, "timeout waiting for kiq fence\n");
+		r = -ETIME;
+	} else
+		r = 0;
+
+	return r;
+}
+
+static int amdgpu_gmc_flush_gpu_tlb_mes_helper(struct amdgpu_device *adev,
+					       uint16_t pasid, uint32_t flush_type,
+					       bool all_hub, uint32_t inst)
+{
+	struct mes_inv_tlbs_pasid_input input = {0};
+	int r;
+
+	input.xcc_id = inst;
+	input.pasid = pasid;
+	input.flush_type = flush_type;
+
+	/* MES will invalidate hubs for the device(including slave xcc)
+	 * from master, ignore request from slave
+	 */
+	if (!amdgpu_gfx_is_master_xcc(adev, inst))
+		return -EINVAL;
+
+	input.hub_id = AMDGPU_GFXHUB(0);
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		return r;
+
+	if (all_hub) {
+		/* invalidate mm_hub */
+		if (test_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask)) {
+			input.hub_id = AMDGPU_MMHUB0(0);
+			amdgpu_mes_lock(&adev->mes);
+			r = adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
+			amdgpu_mes_unlock(&adev->mes);
+			if (r)
+				return r;
+		}
+		if (test_bit(AMDGPU_MMHUB1(0), adev->vmhubs_mask)) {
+			input.hub_id = AMDGPU_MMHUB1(0);
+			amdgpu_mes_lock(&adev->mes);
+			r = adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
+			amdgpu_mes_unlock(&adev->mes);
+			if (r)
+				return r;
+		}
+	}
+	return 0;
+}
+
+int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
+				   uint32_t flush_type, bool all_hub,
+				   uint32_t inst)
+{
+	struct amdgpu_ring *ring;
+	bool use_mmio = false;
+	int r;
+
 	/*
 	 * A GPU reset should flush all TLBs anyway, so no need to do
 	 * this while one is ongoing.
@@ -805,8 +966,38 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return 0;
 
-	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
+	switch (adev->gmc.pasid_inv_method) {
+	case AMDGPU_TLB_INV_METHOD_MMIO:
+	default:
+		use_mmio = true;
+		break;
+	case AMDGPU_TLB_INV_METHOD_SDMA:
+		ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
+		if (!ring->sched.ready)
+			use_mmio = true;
+		else
+			r = amdgpu_gmc_flush_gpu_tlb_sdma_helper(adev, pasid, flush_type,
+								 all_hub, inst);
+		break;
+	case AMDGPU_TLB_INV_METHOD_KIQ:
+		ring = &adev->gfx.kiq[inst].ring;
+		if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready)
+			use_mmio = true;
+		else
+			r = amdgpu_gmc_flush_gpu_tlb_kiq_helper(adev, pasid, flush_type,
+								all_hub, inst);
+		break;
+	case AMDGPU_TLB_INV_METHOD_MES:
+		ring = &adev->mes.ring[MES_PIPE_INST(inst, 0)];
+		if (!ring->sched.ready)
+			use_mmio = true;
+		else
+			r = amdgpu_gmc_flush_gpu_tlb_mes_helper(adev, pasid, flush_type,
+								all_hub, inst);
+		break;
+	}
 
+	if (use_mmio) {
 		if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid) {
 			r = 0;
 			goto error_unlock_reset;
@@ -825,54 +1016,6 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
 							 flush_type, all_hub,
 							 inst);
-		r = 0;
-	} else {
-		/* 2 dwords flush + 8 dwords fence */
-		ndw = kiq->pmf->invalidate_tlbs_size + 8;
-
-		if (adev->gmc.flush_tlb_needs_extra_type_2)
-			ndw += kiq->pmf->invalidate_tlbs_size;
-
-		if (adev->gmc.flush_tlb_needs_extra_type_0)
-			ndw += kiq->pmf->invalidate_tlbs_size;
-
-		spin_lock(&adev->gfx.kiq[inst].ring_lock);
-		r = amdgpu_ring_alloc(ring, ndw);
-		if (r) {
-			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-			goto error_unlock_reset;
-		}
-		if (adev->gmc.flush_tlb_needs_extra_type_2)
-			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
-
-		if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
-			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
-
-		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
-		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
-		if (r) {
-			amdgpu_ring_undo(ring);
-			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-			goto error_unlock_reset;
-		}
-
-		amdgpu_ring_commit(ring);
-		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-
-		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
-
-		might_sleep();
-		while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
-		       !amdgpu_reset_pending(adev->reset_domain)) {
-			msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
-			r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
-		}
-
-		if (cnt > MAX_KIQ_REG_TRY) {
-			dev_err(adev->dev, "timeout waiting for kiq fence\n");
-			r = -ETIME;
-		} else
-			r = 0;
 	}
 
 error_unlock_reset:
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 4bb10a89ce582..e7c529620199b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -974,6 +974,8 @@ static int gmc_v10_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 
 	adev->gmc.flush_pasid_uses_kiq = !amdgpu_emu_mode;
+	if (adev->gmc.flush_pasid_uses_kiq)
+		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v10_0_init_golden_registers(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index acab9f4180da6..a35c84cc7385f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -950,6 +950,8 @@ static int gmc_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 
 	adev->gmc.flush_pasid_uses_kiq = !amdgpu_emu_mode;
+	if (adev->gmc.flush_pasid_uses_kiq)
+		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v11_0_init_golden_registers(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3c13a6920171a..317b44412b5a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2162,6 +2162,8 @@ static int gmc_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int i, r;
 
 	adev->gmc.flush_pasid_uses_kiq = true;
+	if (adev->gmc.flush_pasid_uses_kiq)
+		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
 
 	/* Vega20+XGMI caches PTEs in TC and TLB. Add a heavy-weight TLB flush
 	 * (type 2), which flushes both. Due to a race condition with
-- 
2.55.0

