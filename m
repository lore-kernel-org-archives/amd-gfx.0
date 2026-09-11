Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC2CC88E4D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E91C810F6A3;
	Fri, 11 Sep 2026 17:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TRxwnyJB";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF8010F6A7
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZX34zhFpT4CKcuCWbKQz96HuI1axgnKfPm4lQMYImpbAsFBysNYtDTYXyq+el914p4U4dhGqXPptDHPmaghsqEqo2w1MqKbfJxWhpoyMo+aSnWwnS6kxnzfCkslsa1j27KXimi0fhlCf6xG1Q8ahMo6vnE2vabAJDxoLA5OPEz1KirCn/Uc1BkKKFLgkutOTuynCouwn8+XvUs8N78rsOQJBRFDNJeAnaPFLPluegY/ca2iQKM2E28D004dStt6+AR7OCdnIp0tx94NBSE9no7ah86lWx4oQfSeBEQA1IoOAM3vkxkGhRYF+ixba5Kwqbj3LTjCTwgNIc4UPbqE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AW+NL/fZmumQ84pOvLs5wTnAm9Oenv8sx2LqinXcZec=;
 b=eI9ziKZa2LK4nRPwxh81YN0sJEO+MkYvarB18jxgdO0DNqnAO+QQYBMnTP8f5LjohzyEPUVU1RERnc2Dsr3vRQn6uoLSKqhdWGKK2jqjUemHdrlg3BUXX3gADPV09Y/JQr3Nl7DaTqvyr5wc4pTBs4ESaDR9K/gfafonII1aDeo9iVRKRfKbQMsF+wEZpctkc4g2QXhtJzIBXTv7Mj90CCmSR7TL5ZWlgUvxCHi1jRCF8MhJnKvEKgKTQh43b1ogmSFoWpT0Sm+4pzckVtgflSN/9qEPSsSjRIzo6fk35DYz5mI8v41shePVZHIocO38zyguUQV3hSXnTIwaVqkbOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW+NL/fZmumQ84pOvLs5wTnAm9Oenv8sx2LqinXcZec=;
 b=TRxwnyJBWwWW6boE31sXonFzRM7YaRjJx0OQOM7NfV7eqyWzUcnq/ByByGnhZfxNQTuiQs+bXkxpIDCd8p/WEO+EulZ+84w9KByDY7gQGY6iUEDE7WgYyruuVwj2y4tf4yXAUPqbM3nmqHQcMuae041qWmy14VEe2eyiBxyeJOY=
Received: from CH0PR03CA0192.namprd03.prod.outlook.com (2603:10b6:610:e4::17)
 by SA5PPFE91247D15.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:56:17 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::18) by CH0PR03CA0192.outlook.office365.com
 (2603:10b6:610:e4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 17:56:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A7FF.mail.protection.outlook.com (10.167.245.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:04 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:03 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:56:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/23] drm/amdgpu/gmc: rework pasid flushing
Date: Fri, 11 Sep 2026 13:55:37 -0400
Message-ID: <20260911175544.1314467-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|SA5PPFE91247D15:EE_
X-MS-Office365-Filtering-Correlation-Id: 28670679-6ecd-4ea0-2a8d-08df102df86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: hOFm3DkycB2scnaa2ibMrK6bczWVh5waxS4mzj+xGj4hUVoYw5J/1Z/PUPSUieiVpDa3FLbUfmhHtOVFHkCsO4bHK0jxlnOFnUnjp7cpe7lArRCIaYsCg/PBH5ktn13jBOFbF364fS+/5Ci1a08NI7vda97GNs7CNZIyjJzZKoKjOnoNi/oSmWDk9iN3s6F0Sdw7zbiAVUSxLmjXSkM0xET1Y0FYfdOWEK241vwP31PBAxlMJFLFXi2mW+4ra84/ero4LPXC7vt09HtKEKuMx01tMRcJQG1BtiMix2/P7MhxJJHdG773WvcOkUxltzrXrpU2Q3mE77BDULfFXvK2p69l0VAwR1/bF7Bc1B1/eKaGXZecEBVOncAZom1DhQ1T7qqvCGqLU/EIhfyHCMOZusW09mbzEsOxpFCYS0HQbr69hRvO5NmhLgCFCa3nSXIg5QA/cvaukAF7v7dg2KdxuJDsDxje0Uy8VMjPbFAw0HxatGDAQIJoP/9rucbO80j5AE9ipbDyzLCL2GloQlqia3dcrKD2k0gNp6TpajNYWmtpLHJlaPHnWRizmKBeLIEsemhsr5XYFZoww5ZRL/1g0deDo2eqrQAIHi/SboENuZL8/ZW8/X/zvwi1Y/qTV5uQSoFJ+X4w4QkoCVV2eR4ONf01AUfmNszPsvAo3ujzRfs2s2KPJpi6xopvbc8BpJS9v5zLj5/DZmBG/utSeXaEiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yLBpw1Fu/Vt77TOaPOO4aUV27ICKb2OLc420y9bt6eS9pUQk5Dg6dcCcwHyr6+avHPKY5TNIoQCS3C8G3TL2bPNPlUrXTjplb8WOSsV53No403SqttRepV43dhVbEZsvflD8qDlPVs7/1Z8cbUBrT2kAKcfGJk1ZzEREe4FjQeIeI73xdibKAfV74xm+0vCqfZ2sCwieVLA2cWglB1b4WHtXKx5iXAobnyL2V2bTRZ91ODSwqCyF3XwxMF2xUSD0zyhleBnVXSEDOuFb/rhC29DD3hcvttjjYvK6FrRxJzPzZa3Csr4BqO7fP1C7DKdA1fXZ6+3oGyp7VCkVyFo8pD3LSDPL/dpQYKv045H8W/rSHsfE0d4hFqu9dXmVOKtCH5T9LJuqrA4d3j60sByfWtVHElXlFJ0WDalimUs1+TrjUaJLpL4VUJe5vAljrrW4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:13.6934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28670679-6ecd-4ea0-2a8d-08df102df86d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE91247D15
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
one to use.  No intended change in behavior.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 247 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |   2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |   2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  |  16 --
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  |  28 ---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |   2 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  |   4 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  |   4 +
 8 files changed, 209 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index f1c7bb37cfb8e..ed132878e390f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -794,9 +794,66 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
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
@@ -804,6 +861,110 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
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
@@ -811,8 +972,38 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
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
@@ -831,54 +1022,6 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
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
index 4b3303ab4bff9..1e1339f36c2a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -975,6 +975,8 @@ static int gmc_v10_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 
 	adev->gmc.flush_pasid_uses_kiq = !amdgpu_emu_mode;
+	if (adev->gmc.flush_pasid_uses_kiq)
+		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v10_0_init_golden_registers(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 2d7ef1e1fd8cc..8f5587743c2be 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -955,6 +955,8 @@ static int gmc_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 
 	adev->gmc.flush_pasid_uses_kiq = !amdgpu_emu_mode;
+	if (adev->gmc.flush_pasid_uses_kiq)
+		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v11_0_init_golden_registers(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 1da76d19eb3c5..89e271b0e9653 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -359,22 +359,6 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint16_t queried;
 	int vmid, i;
 
-	if (adev->enable_uni_mes && adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready &&
-	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x84) {
-		struct mes_inv_tlbs_pasid_input input = {0};
-		input.pasid = pasid;
-		input.flush_type = flush_type;
-		input.hub_id = AMDGPU_GFXHUB(0);
-		/* MES will invalidate all gc_hub for the device from master */
-		adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
-		if (all_hub) {
-			/* Only need to invalidate mm_hub now, gfx12 only support one mmhub */
-			input.hub_id = AMDGPU_MMHUB0(0);
-			adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
-		}
-		return;
-	}
-
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 1c0d0121ad8ab..6561129022864 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -442,34 +442,6 @@ static void gmc_v12_1_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint16_t queried;
 	int vmid, i;
 
-	if (adev->mes.ring[0].sched.ready &&
-	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x6f) {
-		struct mes_inv_tlbs_pasid_input input = {0};
-		input.xcc_id = inst;
-		input.pasid = pasid;
-		input.flush_type = flush_type;
-
-		/* MES will invalidate hubs for the device(including slave xcc) from master, ignore request from slave */
-		if (!amdgpu_gfx_is_master_xcc(adev, inst))
-			return;
-
-		input.hub_id = AMDGPU_GFXHUB(0);
-		adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
-
-		if (all_hub) {
-			/* invalidate mm_hub */
-			if (test_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask)) {
-				input.hub_id = AMDGPU_MMHUB0(0);
-				adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
-			}
-			if (test_bit(AMDGPU_MMHUB1(0), adev->vmhubs_mask)) {
-				input.hub_id = AMDGPU_MMHUB1(0);
-				adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
-			}
-		}
-		return;
-	}
-
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 8e2b89c36a4da..047d0ce5c5ab4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2164,6 +2164,8 @@ static int gmc_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int i, r;
 
 	adev->gmc.flush_pasid_uses_kiq = true;
+	if (adev->gmc.flush_pasid_uses_kiq)
+		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
 
 	/* Vega20+XGMI caches PTEs in TC and TLB. Add a heavy-weight TLB flush
 	 * (type 2), which flushes both. Due to a race condition with
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index ee72afdb0a1d3..dd68db14c43f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -2097,6 +2097,10 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev->gfx.kiq[0].ring.sched.ready = false;
 	adev->mes.ring[0].sched.ready = true;
 
+	if (adev->enable_uni_mes &&
+	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x84)
+		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_MES;
+
 	return 0;
 
 failure:
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index a69f9b9c5cd67..3781d088d283f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -1817,6 +1817,10 @@ static int mes_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	if (adev->enable_uni_mes &&
+	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x6f)
+		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_MES;
+
 	return 0;
 }
 
-- 
2.55.0

