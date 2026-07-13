Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27890C4450B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 18:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB12B10EAB2;
	Mon, 13 Jul 2026 18:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0F/mAmEO";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F35B10EAAB
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 18:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVwb9eakYYecekGXhvnHpDFR7hPR4dBMLPb/pHNvlDMs13SM+VnA1IBGW3IeXZZ12JtiaHSiByhorUJy0HFWlDHHnJsVr/WAFbbVwJ1W72gdPGLR2M3GdeFngRtNVJmj0YWBoyO2ysCXzBzwb4zqRke/yUkA5agiNwI+GRhreh7dXQHH08WEYS+qweEu2ANRMumsVvLYBH5JW2fx/EOMZTAAurm6tYVnURrrzShRrDiXG8X2g3NjiyWnKJJtlhbS5QmbVxNmFjbroTAcpQjmG0l33I2Ushgp0Wf5PJqWl8YF9Y7w702MnD/sPlZtDO1BWJLNdPa1T98KyjU4FG7ZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5doXf/PJ3xCaSyomf1V35KnBw9S5tCAcNK+fJCTBVGQ=;
 b=Xlbceoca9yyiu+OiyX0BVPBtZj8CK1CWutmd93z/aIlDHN0EwhV+lubX866OSfe1Tmgllr+8kT4gu2e6aRDy6hIX/D7ePRc4a7+yfSnBUj+O1DPRyoROz51Cum2/Ak9J5AOUuNgUze2EkOtGQn9DPNsHhdpdzny9ZOvhaXIZimZGaJgzzXFTI2pTu5PV+RkQlNi6gJ/s5iLiD5ZhejvduO1r+vcVMMZZP+azl9MNsXjteOjILcuvfPzh3AmSm/Bmwnp1lHl0v/ACnFpFla/7u/0pCKLysIrwH7mZD+MSqADifCMtKnH6YhSDMRVuxvNfAaOHUaT330CgD5ewCtK6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5doXf/PJ3xCaSyomf1V35KnBw9S5tCAcNK+fJCTBVGQ=;
 b=0F/mAmEOmT5FLW1DMEumZRRZMQuhYnE6stbNo0v8r4a2d3UmO6jV2W+c2Bf3cTpduyRuXEqJgc07bV/FDiFFCdl2A8XYWSyyTc+5oJBVURvrhfZYCSBTIkrIxPSId3fcplRRjectVxtJTiOMvy3lJnPgdFgGx6fwkNElT0XHClY=
Received: from SA9PR13CA0039.namprd13.prod.outlook.com (2603:10b6:806:22::14)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 18:27:49 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::6) by SA9PR13CA0039.outlook.office365.com
 (2603:10b6:806:22::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.8 via Frontend Transport; Mon, 13
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
Subject: [PATCH 12/14] drm/amdgpu/gmc10: switch to new gmc tlb inv helpers
Date: Mon, 13 Jul 2026 14:27:30 -0400
Message-ID: <20260713182732.630947-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713182732.630947-1-alexander.deucher@amd.com>
References: <20260713182732.630947-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9c9e68-2d52-4f3c-6159-08dee10c714a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: DrYBe75W83pWlRbr3G7+EL0PJAd05Pvxykrg5T/82DxSVLD39orEd20L2EdgksG0WvC0U6BlppR5K9cXAt20bl79FiQqdnkdOErrlbqS0vSWIjl7BRVg8b2ZBDEEF/sbPGZrYDV+AuspIYSILnSFkE7iXboFPRbpVoIw2EZu9v+ProfYnlKBqwVuuuQYDKnilQ6HiB3jxaDsLD1/EIJEI6I0XfBBRiBIDFQIJuymietrMDJi7jlZO7KxGPPmrutaHeW1l56KfwWr4BXVY3EmXmAIp5JT/ZuJ0bNz+QtidxYZ9tOoZUdOp24dH2getkRaPJHcLZ8v29pVfr9U8hGlYp3q8YxROJN/R38jEaWkZyPknk8c9DGMHxqR1N0rd49haNLj7inNMueEn5P3TKwlxsQK3Pf7d3UohKPzo/59edjoePNJkLUDxyJXFuIVCNPBiUvqrA/N9xKIbdnPMzBC1ZYrRHw7DNJGnx+HcTw5jN3dPmyRW4Fm/dmMymQdpGuAC1xiAomZVIOCxDI7Ba7RIWz/2dPX+/Vws7DfbiZt8nIFdEVDYN+YnCrtLfy+1PLr2bMSxbWFuuqhwrn9zNGFrVBBmOfWXuZ56Qn5cuKRPWghac8wT/eTDMzsR4OIgCj+WlO2lRfUf5GXL5FifYy8csLQhKN+SJP8wgCf/MbBxsXkl9smg6wvrDR8jPHuYQEevB4HFs7vz0eAIeIl0We20Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: azVX2KV2G0Dp1QqxgDarUK6m1gRFR0AlQfaLN5nhUVBmPyOwwRkQPBcLapfGPy0sxKYslGnjFJUKmxvPEuyJe90nYWEnbC2NrQ+Y8dSfGNaAt7Natt2tjerNdfeXuLVoJXGSolR1z7XE8LeSny1+Lpw93OSCirbn9CK6JA6Ixpde+2njDT9i0vHZgFgS9CT2r1accSOLVG1UF1+g7zan+uwobR19yIGh+Qehco1RpuPLLDdeqAUwEiL/E1S7UMHV7U3seQYng9682JMFZA2u6Eti6JB7rzAaqlN/XLomW9aNmTvwJ933g6Hhx7NaQVuTjyUybsnJnFPtuc0a/mKyo1iSL0+bVcT5h7kMwsgsSRUOO/ELGEEvww+uqSM+m2jCoKSfYYqoCVlEBdvCf6ceSzPVZ7O3Hap6iRbeZ1JYZgHTARWw2L4g5AuUEEFHZa4f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:27:48.9089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9c9e68-2d52-4f3c-6159-08dee10c714a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
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

Use the new gmc helpers for tlb invalidations.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 186 +------------------------
 1 file changed, 7 insertions(+), 179 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index cdbd0f74aeaf7..0b37b797454f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -188,20 +188,6 @@ static void gmc_v10_0_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * gmc_v10_0_use_invalidate_semaphore - judge whether to use semaphore
- *
- * @adev: amdgpu_device pointer
- * @vmhub: vmhub type
- *
- */
-static bool gmc_v10_0_use_invalidate_semaphore(struct amdgpu_device *adev,
-				       uint32_t vmhub)
-{
-	return ((vmhub == AMDGPU_MMHUB0(0)) &&
-		(!amdgpu_sriov_vf(adev)));
-}
-
 static bool gmc_v10_0_get_atc_vmid_pasid_mapping_info(
 					struct amdgpu_device *adev,
 					uint8_t vmid, uint16_t *p_pasid)
@@ -222,109 +208,6 @@ static bool gmc_v10_0_get_atc_vmid_pasid_mapping_info(
  * by the amdgpu vm/hsa code.
  */
 
-/**
- * gmc_v10_0_flush_gpu_tlb - gart tlb flush callback
- *
- * @adev: amdgpu_device pointer
- * @vmid: vm instance to flush
- * @vmhub: vmhub type
- * @flush_type: the flush type
- *
- * Flush the TLB for the requested page table.
- */
-static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
-					uint32_t vmhub, uint32_t flush_type)
-{
-	bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(adev, vmhub);
-	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
-	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
-	/* Use register 17 for GART */
-	const unsigned int eng = 17;
-	unsigned char hub_ip = 0;
-	u32 sem, req, ack;
-	unsigned int i;
-	u32 tmp;
-
-	sem = hub->vm_inv_eng0_sem + hub->eng_distance * eng;
-	req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
-	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
-
-	/* flush hdp cache */
-	amdgpu_device_flush_hdp(adev, NULL);
-
-	/* This is necessary for SRIOV as well as for GFXOFF to function
-	 * properly under bare metal
-	 */
-	if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
-						 1 << vmid, GET_INST(GC, 0));
-		return;
-	}
-
-	/* This path is needed before KIQ/MES/GFXOFF are set up */
-	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;
-
-	/* disabllow gfxoff when we invalidate */
-	if (hub_ip == GC_HWIP)
-		amdgpu_gfx_off_ctrl(adev, false);
-
-	spin_lock(&adev->gmc.invalidate_lock);
-	/*
-	 * It may lose gpuvm invalidate acknowldege state across power-gating
-	 * off cycle, add semaphore acquire before invalidation and semaphore
-	 * release after invalidation to avoid entering power gated state
-	 * to WA the Issue
-	 */
-
-	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore) {
-		for (i = 0; i < adev->usec_timeout; i++) {
-			/* a read return value of 1 means semaphore acuqire */
-			tmp = RREG32_RLC_NO_KIQ(sem, hub_ip);
-			if (tmp & 0x1)
-				break;
-			udelay(1);
-		}
-
-		if (i >= adev->usec_timeout)
-			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
-	}
-
-	WREG32_RLC_NO_KIQ(req, inv_req, hub_ip);
-
-	/*
-	 * Issue a dummy read to wait for the ACK register to be cleared
-	 * to avoid a false ACK due to the new fast GRBM interface.
-	 */
-	if ((vmhub == AMDGPU_GFXHUB(0)) &&
-	    (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 3, 0)))
-		RREG32_RLC_NO_KIQ(req, hub_ip);
-
-	/* Wait for ACK with a delay.*/
-	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32_RLC_NO_KIQ(ack, hub_ip);
-		tmp &= 1 << vmid;
-		if (tmp)
-			break;
-
-		udelay(1);
-	}
-
-	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore)
-		WREG32_RLC_NO_KIQ(sem, 0, hub_ip);
-
-	spin_unlock(&adev->gmc.invalidate_lock);
-
-	if (hub_ip == GC_HWIP)
-		amdgpu_gfx_off_ctrl(adev, true);
-
-	if (i >= adev->usec_timeout)
-		dev_err(adev->dev, "Timeout waiting for VM flush hub: %d!\n",
-			vmhub);
-}
-
 /**
  * gmc_v10_0_flush_gpu_tlb_pasid - tlb flush via pasid
  *
@@ -341,7 +224,7 @@ static void gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 					  bool all_hub, uint32_t inst)
 {
 	uint16_t queried;
-	int vmid, i;
+	int vmid;
 
 	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
 		bool valid;
@@ -351,66 +234,11 @@ static void gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		if (!valid || queried != pasid)
 			continue;
 
-		if (all_hub) {
-			for_each_set_bit(i, adev->vmhubs_mask,
-					 AMDGPU_MAX_VMHUBS)
-				gmc_v10_0_flush_gpu_tlb(adev, vmid, i,
-							flush_type);
-		} else {
-			gmc_v10_0_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(0),
-						flush_type);
-		}
+		amdgpu_gmc_flush_gpu_tlb_pasid_helper(adev, vmid, flush_type,
+						      all_hub, inst);
 	}
 }
 
-static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
-					     unsigned int vmid, uint64_t pd_addr)
-{
-	bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(ring->adev, ring->vm_hub);
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
-	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
-	unsigned int eng = ring->vm_inv_eng;
-
-	/*
-	 * It may lose gpuvm invalidate acknowldege state across power-gating
-	 * off cycle, add semaphore acquire before invalidation and semaphore
-	 * release after invalidation to avoid entering power gated state
-	 * to WA the Issue
-	 */
-
-	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore)
-		/* a read return value of 1 means semaphore acuqire */
-		amdgpu_ring_emit_reg_wait(ring,
-					  hub->vm_inv_eng0_sem +
-					  hub->eng_distance * eng, 0x1, 0x1);
-
-	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
-			      (hub->ctx_addr_distance * vmid),
-			      lower_32_bits(pd_addr));
-
-	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
-			      (hub->ctx_addr_distance * vmid),
-			      upper_32_bits(pd_addr));
-
-	amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
-					    hub->eng_distance * eng,
-					    hub->vm_inv_eng0_ack +
-					    hub->eng_distance * eng,
-					    req, 1 << vmid);
-
-	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore)
-		/*
-		 * add semaphore release after invalidation,
-		 * write with 0 means semaphore release
-		 */
-		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
-				      hub->eng_distance * eng, 0);
-
-	return pd_addr;
-}
-
 static void gmc_v10_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int vmid,
 					 unsigned int pasid)
 {
@@ -551,9 +379,9 @@ static unsigned int gmc_v10_0_get_vbios_fb_size(struct amdgpu_device *adev)
 }
 
 static const struct amdgpu_gmc_funcs gmc_v10_0_gmc_funcs = {
-	.flush_gpu_tlb = gmc_v10_0_flush_gpu_tlb,
+	.flush_gpu_tlb = amdgpu_gmc_flush_gpu_tlb_helper,
 	.flush_gpu_tlb_pasid = gmc_v10_0_flush_gpu_tlb_pasid,
-	.emit_flush_gpu_tlb = gmc_v10_0_emit_flush_gpu_tlb,
+	.emit_flush_gpu_tlb = amdgpu_gmc_emit_flush_gpu_tlb_helper,
 	.emit_pasid_mapping = gmc_v10_0_emit_pasid_mapping,
 	.get_vm_pde = gmc_v10_0_get_vm_pde,
 	.get_vm_pte = gmc_v10_0_get_vm_pte,
@@ -955,9 +783,9 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	if (!adev->in_s0ix)
 		adev->gfxhub.funcs->set_fault_enable_default(adev, value);
 	adev->mmhub.funcs->set_fault_enable_default(adev, value);
-	gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
+	adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
 	if (!adev->in_s0ix)
-		gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
+		adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
 
 	drm_info(adev_to_drm(adev), "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned int)(adev->gmc.gart_size >> 20),
-- 
2.55.0

