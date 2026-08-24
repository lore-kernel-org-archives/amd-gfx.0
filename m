Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B06C5DF9C
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C05C110E873;
	Mon, 24 Aug 2026 22:14:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m/+eG7r9";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F18D410E867
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsiLBOmmRJ5CKJv7SyBiljc/rdEqh71Ov8dzsHFjkdZjFa9p4+kgETHni4gGhT2+EvHCrKL7I1TqVB2mIqf+b+06SERHj93TbBuVhfgXFr2ceMALFtrPWIqsdHmJTITUatPdiwlD5R3tkG1EqI1HR50E3VUZEJin0UCwKeE0BWah0YJp4jVZ8NWeH8+g0rlSi9zF0bsqxSPJRImufymHdD10qUf//JZHSK305yc5CRLlYMGU4lBQG9Vf99l7wi4FPTP/gEZRzY/Eqrk9x+6ehwqFuafhYAr/5NZ9iMAQ9Y0VBIjTiEcvtLsLqR3tilfLHicSzBnGsaVmbY3HdktgLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L84cGlxHUBNOApjyE620+Qjb8p/K4qJUWk7r/TR1XmY=;
 b=omW+zgkC487xhfVfKO3wzw3yfALmsysmrH+2tYfOD8SUZ7q3WivxzJOJALMLfxkmG2Hj7lVDDPNp/nvAhiTfEjTrr8OV3qzcaaFMt3hI/IPt7zMLmSPgxE5AytgKBPerltUgHdkq1cZoZfAD0+wC1ou3lHXVPGBRCVtgXSRfetQt24xPpHuvUXN7jjmFriO0xQ7IRfiV0RZbQsTXjzyZV6iakjfdMlxe65Ekm9wICeAgtcz874UBqX3SgWgobH7GbjvbO+qnVwMaHfWvmmGX3gPENx5TVzJ4j6NNDgtmLMIAijDoJ6zm7oMfDCf0cyrx3cp3HfaHs3t1oy6xboi1MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L84cGlxHUBNOApjyE620+Qjb8p/K4qJUWk7r/TR1XmY=;
 b=m/+eG7r9KyGV2D3Cyk21ikYwr1MA1rxx/5lJZeDVrPsAdtTW0qFnsJ2mxPZB2msQ2DzDPLeopRYbN5TCpeYzbTT4VZFYPm9zYder3q/5xQwZW+zMytVXvFxmNubZAZldhdYBFRsNvC/p+CSUHtesfOLjvGbEGxIQow/i4d3B8EU=
Received: from BN9PR03CA0515.namprd03.prod.outlook.com (2603:10b6:408:131::10)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Mon, 24 Aug
 2026 22:14:20 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::28) by BN9PR03CA0515.outlook.office365.com
 (2603:10b6:408:131::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:16 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 21/30] drm/amdgpu/gmc: rework pasid flushing
Date: Mon, 24 Aug 2026 18:13:43 -0400
Message-ID: <20260824221352.1793542-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: e7553bd7-e200-462c-b18b-08df022d0b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ntlEh+CVr6xZzRCLkzg/S6PD5pgv04E4ZxLdqYitIR33lUA/uvq/VuG15wFcj0BOjVIqteWsEIHa+y5vVnLh71jHBcsq84lnkkpuE5qUw7C1sq21/JpqhPXsxVuHM0owssxzI6J4QS0P7q71gF16mdb/lluMAeFsqWK4QEB3lW5x4VU51O4XWBZlsIdQ9TrDz494L8wFTi8m1O8tsp4LcziqQaeO0WTK6/60z3QvwYugG9hjXDAcwIvvYkebmRCywby/LMsniRvKsLC6MS6Bzp2pOLj2HdH8OiBYMaOz0Mt8MEeX+b8SZEo6PKIwf4PLj2KYR9i09CRtDRrw6ZYYnBzb7pkGWYX25FfQ6/v/4fJYFKZdxrjM3jROjEnadisQbQ2cKI92Owm26WsafzxpZAdQmY7Ue6v8xBMNaLwzOL9aEDHqqAaW7q+z2Nmxos3A/xzPGYKwFfl2Yu5NbjYNg6KEcHK5KNOz/9O+pnBflldDzQqyV0AizTiwCm4KVo7STRZJsnnkCxe5jtdemXGsZGj2LspNFDRNIybYgphhP3yVUWeHZ2P5L6xVL4Eus4F9wxfu88nHLqSRgIbzOR1NoA6H4aZ69+OVOl01t8IZiIyVe8C/7J2mqKXXmoo2fMOWaTCts+VoaBM5mUvFklBJdDlnhHmoMSq7wuHZkFFMHbesxDrYRduEotFWi30aJtdpFjQbTxRp9JKFk0T7vaTvyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /Gk6z3eoRZWWeN0D5gB4e1vTOW1tcCTRuiSnf3GXIFQEd/44U6U9Fpfml03cTa67Z9QMpuhTK6LhdjyJu+iF1Mj19pwJ3zcXlFOBPMbouYEah6IRNWAKzCOXCNSNOzvgHbecBeMWsOY9dBlSNp5BB8oXcw9Xlr/p4xwL0EmMJ7SYWHvegvBqPguDl3kQudwDNSoUnLmyyIQ2ZBmifajwI9Gf1II3WZ/bzbEZ/pAcpEUBwE4ykk+dDX5h/MK089qSffqrI9PAEjCtZ3YgENlyzZTLjsVeljjKpECDuLgdYMFRqEukH5TRR736FyA6FQ4S/BQtIHJBOlGsSNgL9NuIPg14DRCfbSdlO7VA7lJuzF5extRPND19HglCBCx3NJw9uIjVbct5qmFk6Mye36yeKgh5a5q4UnvMaGfmSRuSuhjR/SFRmiKPVfVtVqcSpK2F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:20.0521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7553bd7-e200-462c-b18b-08df022d0b93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
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
index 13423258d33ed..e9e5a1e183231 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2181,6 +2181,8 @@ static int gmc_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int i, r;
 
 	adev->gmc.flush_pasid_uses_kiq = true;
+	if (adev->gmc.flush_pasid_uses_kiq)
+		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
 
 	/* Vega20+XGMI caches PTEs in TC and TLB. Add a heavy-weight TLB flush
 	 * (type 2), which flushes both. Due to a race condition with
-- 
2.55.0

