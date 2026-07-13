Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41042C44508
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 18:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD2B510EABA;
	Mon, 13 Jul 2026 18:28:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IbhAX3qy";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DB3810EA95
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 18:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gksN3lfCPI8J4zKgfoQo4NCe5FDDISWeIUjsoIboStbvgDAw5UKRgb558bHug7Uj2San3uMY3P5M6jT0GFBtPkQ8d6R/9Z1cYrBIFketdfnHJxJzzm8mJf4owNp7cLNf5zSt3sbjypIw6jBuIdNKW3KNY1Sgjf/Hx272LFiPtuAycsfrTwZyiJSRO9Hv9hQRiezmD9snIlfGLHeroW0AXd2npZXe3qMssUJvl9/KIQf4ugrvrO3glWnBbv4bZVc0y6ukC8hEF59eC+JyRIF2NspdD6/0QvHmfWOW1+uJp85k8YCqulZPteAYefwDj9Ps1CaATrGrdfxi547Vk0VfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1Uvkt8H6VASKQyqwwSEv6n3fNQ8ic9bFDNdOl0Xaoc=;
 b=PZaqJjgQzK3Du87Z+gdyj/CyIaK6x3nFYR3Z9Gq6Tx9BSamGASi6OLlWr+KYCxFKvRWRIdbJn1O+cmvT9DD0YiQv/d+rTGgn4EJY4gwb6cWg0r/DcPbGu/5YUHnqsAmACv3+Cocdlo3sjQuyG2sWJcF2N49utpPpibsO+2D85nz8VhCNBCH2VMkehfY0eig++Fuz7xY6V9MiMsTiQ2y4zwfqzW9C03tJjPq+QPqwfutO+WlNaDZe50XLnzqZOemq9K/jVXgHJFu5XhEXvyoyqaXrvBmtS+WnvNnB3Uy197mo7n/6L+BNmR1m70Hns2bdHUiphKzmMmpbLNHjquV96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1Uvkt8H6VASKQyqwwSEv6n3fNQ8ic9bFDNdOl0Xaoc=;
 b=IbhAX3qycZVHWkwnSRYKtJxaHQC5Br0YJv7kPuV6JHd+3jyHLUyMt0+hFol+YUaaML7Ka/AWWGeD/w9ZBpk2/CFWtp4Js4lcfNOXNMboSrW7TmP6BsEZK4n1/Jxjj9NlZl15a/UpKFKM5Ftckjc17XFkmEY9vzoRtt3efFYkj5E=
Received: from SA9PR13CA0048.namprd13.prod.outlook.com (2603:10b6:806:22::23)
 by SA1PR12MB999228.namprd12.prod.outlook.com (2603:10b6:806:4db::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 13 Jul
 2026 18:27:48 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::74) by SA9PR13CA0048.outlook.office365.com
 (2603:10b6:806:22::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 13
 Jul 2026 18:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:27:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 13:27:47 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 13:27:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/14] drm/amdgpu/gmc: add more gmc tlb inv helpers
Date: Mon, 13 Jul 2026 14:27:29 -0400
Message-ID: <20260713182732.630947-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713182732.630947-1-alexander.deucher@amd.com>
References: <20260713182732.630947-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SA1PR12MB999228:EE_
X-MS-Office365-Filtering-Correlation-Id: 45764917-8e2f-4b14-835f-08dee10c7114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|56012099006|22082099003|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: Lgtqt/R/tiKdynuwZc3dgq0ypwMrVYzSdg7BoSPmGL98pKi7e3E+SqxNNjRr5hxppdQYiHx/HQTxOphdkOHeKwp930/YRgpeoX20v3lszqBcQbt6F5Crk6Gu4KGOJtYhqwt+x9aw/N7ERfPNE4RVkmLU/omAcXoUW0+8d3R5xhONhI1hMgc1Ww7D7d8Efpb3rU0g4Uq/QoMAUIhl4KFJmIPnACHm6cK+62YflZHSGgNl2ylLwDoG0HI8RHfi1nBM2QgBWBvwsDU7riVJacwH9MQ0PUH4hfTUgljyRs7U4uyUJkxzC2TK33MfjbS4ifpjULlE7caIwdUAhcdN/uVsonvoQQi6fVphD5v++fk0ON9Uh5hu92j7Lp4SpEztipk2JFQYO5nCgXmGmNX+h8gieEyySMVwvDdFkB0N2OVLIiepygXW5Dg2xGtQwh2CmscQEPEe7imudFdTFXtohJ+SjNy7u0u2HIA8jl7JG6ho+hLJgNUDx6firBV+26V9IlIa2vV6wmUNW0dA53oZ86+Fz1EXlAaOEQaGb4JovPGJT8N/aSL90D5MSUvqUofMb5Z48dp9eR3UrJlNHfH848ftzzePRydl9I1paV7r6DWAi1cxV/SkEmHQkEV32HNnWYDUfqQi2lJhPCIHdQ70aOb1nQ/wxG2s0gpcnj1oI4cf4JyGr9oaBuD4l3sD9GHbgPelVo9yDIUYVkVPd40eG5XShA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(56012099006)(22082099003)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B6fcX2cpVdTMQ0f/9pq9/dkoXYZiTD/u/aHWigSLp1XNW3FEEDqjaQRwS6V/H5CgsuVAAUWNVOJRzQQPj+Laf8u0XwxMOoDBXdWTiMbYuFk3ANWTAdCCsdg4UFhwfDZQN3+Rb0L8Gtunbx7rMT9X5vLsaO0Iutmr/Up7WdMVHKzWd25YdwdGW9YohMafovd99BKeYoTFn8xUKXNgMfeo9dTuSXmHPmdNyUGTN4Vv/AYwSFq4Xq7ervuUZsFUGbuE4y0y3Vku+vc3Ph4k2Qlkt7SvmaUvXkUbMgdUSGcXr9y7tRe5VkkoFkB865iIy9IcSLM7IundRE92PGMVgIy2yID8v4jM02yvOB+NQpnPb6xZmM86FNmfL87mTnFNJP2kPbbQIK5U7mJMH2ZQRcv5uwg4ws14Yg7jtqylkeQvGRsOJUVmUVI6pxTbw1NwawNV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:27:48.5554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45764917-8e2f-4b14-835f-08dee10c7114
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999228
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

Move more of the common code into the gmc.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 172 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   9 +-
 2 files changed, 174 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 5c1237a30b865..bbdedcaff4086 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -928,16 +928,158 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 	dev_err(adev->dev, "failed to write reg %x wait reg %x\n", reg0, reg1);
 }
 
-int amdgpu_gmc_flush_gpu_tlb_helper(struct amdgpu_device *adev, uint32_t vmid,
-				    uint32_t vmhub, uint32_t flush_type)
+static bool amdgpu_gmc_use_invalidate_semaphore(struct amdgpu_device *adev,
+						uint32_t vmhub)
+{
+	return (!AMDGPU_IS_GFXHUB(vmhub) &&
+		!amdgpu_sriov_vf(adev));
+}
+
+uint64_t amdgpu_gmc_emit_flush_gpu_tlb_helper(struct amdgpu_ring *ring,
+					      unsigned vmid, uint64_t pd_addr)
+{
+	bool use_semaphore = amdgpu_gmc_use_invalidate_semaphore(ring->adev, ring->vm_hub);
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
+	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
+	unsigned eng = ring->vm_inv_eng;
+
+	/*
+	 * It may lose gpuvm invalidate acknowldege state across power-gating
+	 * off cycle, add semaphore acquire before invalidation and semaphore
+	 * release after invalidation to avoid entering power gated state
+	 * to WA the Issue
+	 */
+
+	if (use_semaphore)
+		/* a read return value of 1 means semaphore acuqire */
+		amdgpu_ring_emit_reg_wait(ring,
+					  hub->vm_inv_eng0_sem +
+					  hub->eng_distance * eng, 0x1, 0x1);
+
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
+			      (hub->ctx_addr_distance * vmid),
+			      lower_32_bits(pd_addr));
+
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
+			      (hub->ctx_addr_distance * vmid),
+			      upper_32_bits(pd_addr));
+
+	amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
+					    hub->eng_distance * eng,
+					    hub->vm_inv_eng0_ack +
+					    hub->eng_distance * eng,
+					    req, 1 << vmid);
+
+	if (use_semaphore)
+		/*
+		 * add semaphore release after invalidation,
+		 * write with 0 means semaphore release
+		 */
+		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
+				      hub->eng_distance * eng, 0);
+
+	return pd_addr;
+}
+
+static void amdgpu_gmc_flush_vm_hub_mmio(struct amdgpu_device *adev,
+					 uint32_t vmid, unsigned int vmhub,
+					 uint32_t flush_type)
+{
+	bool use_semaphore = amdgpu_gmc_use_invalidate_semaphore(adev, vmhub);
+	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
+	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
+	u32 tmp;
+	/* Use register 17 for GART */
+	const unsigned eng = 17;
+	unsigned int i;
+	unsigned char hub_ip = 0;
+
+	hub_ip = AMDGPU_IS_GFXHUB(vmhub) ?
+		   GC_HWIP : MMHUB_HWIP;
+
+	/* disabllow gfxoff when we invalidate */
+	if (hub_ip == GC_HWIP)
+		amdgpu_gfx_off_ctrl(adev, false);
+
+	spin_lock(&adev->gmc.invalidate_lock);
+	/*
+	 * It may lose gpuvm invalidate acknowldege state across power-gating
+	 * off cycle, add semaphore acquire before invalidation and semaphore
+	 * release after invalidation to avoid entering power gated state
+	 * to WA the Issue
+	 */
+	if (use_semaphore) {
+		for (i = 0; i < adev->usec_timeout; i++) {
+			/* a read return value of 1 means semaphore acuqire */
+			tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
+					    hub->eng_distance * eng, hub_ip);
+			if (tmp & 0x1)
+				break;
+			udelay(1);
+		}
+
+		if (i >= adev->usec_timeout)
+			dev_err(adev->dev,
+				"Timeout waiting for sem acquire in VM flush!\n");
+	}
+
+	WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng,
+			  inv_req, hub_ip);
+
+	/* Wait for ACK with a delay.*/
+	for (i = 0; i < adev->usec_timeout; i++) {
+		tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_ack +
+				    hub->eng_distance * eng, hub_ip);
+		tmp &= 1 << vmid;
+		if (tmp)
+			break;
+
+		udelay(1);
+	}
+
+	if (use_semaphore)
+		/*
+		 * add semaphore release after invalidation,
+		 * write with 0 means semaphore release
+		 */
+		WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
+			      hub->eng_distance * eng, 0, hub_ip);
+
+	/* Issue additional private vm invalidation to MMHUB */
+	if (!AMDGPU_IS_GFXHUB(vmhub) &&
+	    hub->vm_l2_bank_select_reserved_cid2 &&
+	    !amdgpu_sriov_vf(adev)) {
+		inv_req = RREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2);
+		/* bit 25: RSERVED_CACHE_PRIVATE_INVALIDATION */
+		inv_req |= (1 << 25);
+		/* Issue private invalidation */
+		WREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2, inv_req);
+		/* Read back to ensure invalidation is done*/
+		RREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2);
+	}
+
+	spin_unlock(&adev->gmc.invalidate_lock);
+
+	if (hub_ip == GC_HWIP)
+		amdgpu_gfx_off_ctrl(adev, true);
+
+	if (i < adev->usec_timeout)
+		return;
+
+	dev_err(adev->dev, "Timeout waiting for VM flush ACK!\n");
+}
+
+void amdgpu_gmc_flush_gpu_tlb_helper(struct amdgpu_device *adev, uint32_t vmid,
+				     uint32_t vmhub, uint32_t flush_type)
 {
 	struct dma_fence *fence;
 	/* Use register 17 for GART */
-	u32 inst, eng = 17;
+	const unsigned eng = 17;
+	u32 inst;
 	int r;
 
 	if (AMDGPU_IS_GFXHUB(vmhub) && !adev->gfx.is_poweron)
-		return 0;
+		return;
 
 	if (vmhub >= AMDGPU_MMHUB0(0))
 		inst = 0;
@@ -947,6 +1089,7 @@ int amdgpu_gmc_flush_gpu_tlb_helper(struct amdgpu_device *adev, uint32_t vmid,
 	/* flush hdp cache */
 	amdgpu_device_flush_hdp(adev, NULL);
 
+	/* use SDMA */
 	mutex_lock(&adev->mman.default_entity.lock);
 	r = amdgpu_ttm_tlb_inv(adev, vmid, vmhub, eng, flush_type, inst,
 			       &adev->mman.default_entity,
@@ -961,7 +1104,26 @@ int amdgpu_gmc_flush_gpu_tlb_helper(struct amdgpu_device *adev, uint32_t vmid,
 exit:
 	mutex_unlock(&adev->mman.default_entity.lock);
 
-	return r;
+	/* if SDMA fails, use MMIO */
+	if (r)
+		amdgpu_gmc_flush_vm_hub_mmio(adev, vmid, vmhub, flush_type);
+}
+
+void amdgpu_gmc_flush_gpu_tlb_pasid_helper(struct amdgpu_device *adev,
+					   unsigned int vmid, uint32_t flush_type,
+					   bool all_hub, uint32_t inst)
+{
+	int i;
+
+	if (all_hub) {
+		for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
+			amdgpu_gmc_flush_gpu_tlb_helper(adev, vmid, i,
+							flush_type);
+	} else {
+		amdgpu_gmc_flush_gpu_tlb_helper(adev, vmid,
+						AMDGPU_GFXHUB(inst),
+						flush_type);
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 0135be1418a91..64d02d38044bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -450,8 +450,13 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 				      uint32_t reg0, uint32_t reg1,
 				      uint32_t ref, uint32_t mask,
 				      uint32_t xcc_inst);
-int amdgpu_gmc_flush_gpu_tlb_helper(struct amdgpu_device *adev, uint32_t vmid,
-				    uint32_t vmhub, uint32_t flush_type);
+uint64_t amdgpu_gmc_emit_flush_gpu_tlb_helper(struct amdgpu_ring *ring,
+					      unsigned vmid, uint64_t pd_addr);
+void amdgpu_gmc_flush_gpu_tlb_helper(struct amdgpu_device *adev, uint32_t vmid,
+				     uint32_t vmhub, uint32_t flush_type);
+void amdgpu_gmc_flush_gpu_tlb_pasid_helper(struct amdgpu_device *adev,
+					   unsigned int vmid, uint32_t flush_type,
+					   bool all_hub, uint32_t inst);
 
 extern void amdgpu_gmc_tmz_set(struct amdgpu_device *adev);
 extern void amdgpu_gmc_noretry_set(struct amdgpu_device *adev);
-- 
2.55.0

