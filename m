Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3280EC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 18:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5F0610EAC2;
	Mon, 13 Jul 2026 18:28:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yVbDI7Uu";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B90F10EAB8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 18:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTEzfTP12z1170CwQSOnIinZA6XjxhfPolIT0Xd/Rn6F/6Qv52zrgdLm4dNhdakuEVLTgwT6IDNaO2B7hpmvFoEq6v6d36FBWznPsrnj6Vf35nl7VYy2mSL6l3pJZW1LmwYmXkhnRptV2keuQDwIeXGag8CGYhBE0FIM7wMobAusF0GjrjU5mr4wO5SsEq26Q3PVfIPTvWs8+eJwhov8DnxtkNNMqdNA781kec6GFmYFaLiqw0ytEGyEFNl9CR+/M+MBMmGJlEXcpH+SSLaqgZoCiM/8h33F2CEOFxVa9EmOF8/qC0dv5bjpTX0KYqDrv2scG/+Qa50sLMRyNStTCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRfhjw9ZzPYYxGWZIWuce+41p6jXm6OJd3ka2rsTXzg=;
 b=FHJ9/lkwW7XcjduZHpQr62f0B0c77A/3lZgzAZg8esOovTloCndJlfpwoXMYWQaGgtM9lGSApoHnSPWTGMkgL74jb7roB7QOjX4LhFmrKyp3YXxNgI4SHwZU5SwYkiJztyKMytomb2krtFbnefWa4HBVMg1W8IoJR816q7/JuZA1pGOkuz1VzPUwLwp9+d4pRmErVdpVcqlin7Li9vKMtdAshp/3nnpr15/tM+HMaAsuVSbN7DkBRC5DRL6oplCje5U5Goh+VksUn/+bHIQcezWxq8I/gsbVaIC1K3mOoPuhT/A3oWsCX2tSGOcV1e9hPwAGChMIWCSQ1nRWjPTZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRfhjw9ZzPYYxGWZIWuce+41p6jXm6OJd3ka2rsTXzg=;
 b=yVbDI7Uuy2uZUDLWmTQilSsqVC1R9Yefg4/jHqtM71g0SqTAqkVVMGVaBy8nmkCD5YKDIIPOgKrGw2cdaCcoKZRp+QeLXp+bm0uf6e5vylLbFvaumwxAnw9ZSEYPSAOCOW1CQnxhHNJl+fK3hHCUiIH+CRkSIah6fvx3H44ZZro=
Received: from SA9PR13CA0033.namprd13.prod.outlook.com (2603:10b6:806:22::8)
 by CY8PR12MB8267.namprd12.prod.outlook.com (2603:10b6:930:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 18:27:53 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::9c) by SA9PR13CA0033.outlook.office365.com
 (2603:10b6:806:22::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Mon, 13
 Jul 2026 18:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:27:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 13:27:49 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 13:27:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/14] drm/amdgpu/gmc12: switch to new gmc tlb inv helpers
Date: Mon, 13 Jul 2026 14:27:32 -0400
Message-ID: <20260713182732.630947-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713182732.630947-1-alexander.deucher@amd.com>
References: <20260713182732.630947-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|CY8PR12MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: 762e6638-8655-42e1-5224-08dee10c73b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: KThTlsXsCD3abJod69dYNTaqz7vQXDiUCdDQvjMBHtWiyW2bNd1YWavrB+upNyAlZr7lsfFC4wg31ShAdSnJ+8loRtPXlk3VrIF9/YW8/ao2eCHpcdBQVG88AeoD3LROldGiuHVHC0fDSSzy121Gsw6bD1al5C3SbatZg7n3l+jKq63Zx8EyBJB1POZdWSTnPlwfjOfAwc+6ieEv31aXW9kTAzJtDIHAVF5WUf6d8SiB/Xqy2fFmwY2P9hkTdCinFuwE+Xow9c0YsaYesIIzQiwmtZbd71luAUTnqoI/MGIRhg2VG7sD4VnSBZPvkVFlYa6dGuThnp+Ok8UQDhNvh1DuOo+5dTuEREUoss6SfVAvlA56QzZMhb73uuamfSueGt+DHn+3tC6g6l2656oJ+jistesX18vhBfiTN8sLKDXHaBlyrmNkOhbE/BJwAleMgX9S3knoPXTxKkbmhoB9ypUolJzcfZ24RDERfIwAMmi2kgWGF3S6v/7mQ88aYQG/71npZMe+aqhynlPgLsyca1ihoPm70cDc5DGC6fo+7e3lUh9IgDMWtbELz/1cKe41JGEe+B0z3+f5vImIwEibk5omVMburDBkrmM0zQFeY+iXvN2OFIePbpvLPgqIUObh/HNIAfs4HspErPd2Q70aAhcpfrmIVivWUVXNAJ3nEYuEXhXYG8QhABA9Gg5f6/8ooUXQrhkwa5fQh8aHWz1vGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rLQgrLJCW8vMQxDPa0OZv0FTS6EjhrrDfRN2MQr7IItpHlmd4aBc6kQmrJVsrTvibhRhZzor1BfmznEy276sWSQk9ol8P0sZCE4yKPD+yao2tdv4mR7GApSjOLF4eLDtjt2fD2lrK8nE0Ewa2fnAM3yFyQTGsEFv4NZ7wmVEmOzsq1RULuxPon2WFgvxk8xX0NMSu4Ozb3AqZ7Y9kqLJDBsfxx1aRdOeQfnmcQ3plr6zCnCFN/biST/cwnGs0kFjg6UVzlj66gcRQfR+jYTj/7X42JP25fVqt1HgidhyglqhoE/ySL06WEKX27sU3oMse7JsdEgXDtoWcnZdK+2Hqn1lhPqBG1HJHrZOQ5Fi15XD0XbKuI35+OpK4CD7oK89BEmu53cITYsMBGTZWLQTxrrPeZfAC9G9YxZA6l2TSfsbkGqeeQjGaFxpqXjdZTMm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:27:52.9781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 762e6638-8655-42e1-5224-08dee10c73b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8267
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
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 213 +------------------------
 1 file changed, 5 insertions(+), 208 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index dba83a90550da..54686066094f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -180,20 +180,6 @@ static void gmc_v12_0_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * gmc_v12_0_use_invalidate_semaphore - judge whether to use semaphore
- *
- * @adev: amdgpu_device pointer
- * @vmhub: vmhub type
- *
- */
-static bool gmc_v12_0_use_invalidate_semaphore(struct amdgpu_device *adev,
-				       uint32_t vmhub)
-{
-	return ((vmhub == AMDGPU_MMHUB0(0)) &&
-		(!amdgpu_sriov_vf(adev)));
-}
-
 static bool gmc_v12_0_get_vmid_pasid_mapping_info(
 					struct amdgpu_device *adev,
 					uint8_t vmid, uint16_t *p_pasid)
@@ -203,140 +189,6 @@ static bool gmc_v12_0_get_vmid_pasid_mapping_info(
 	return !!(*p_pasid);
 }
 
-/*
- * GART
- * VMID 0 is the physical GPU addresses as used by the kernel.
- * VMIDs 1-15 are used for userspace clients and are handled
- * by the amdgpu vm/hsa code.
- */
-
-static void gmc_v12_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
-				   unsigned int vmhub, uint32_t flush_type)
-{
-	bool use_semaphore = gmc_v12_0_use_invalidate_semaphore(adev, vmhub);
-	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
-	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
-	u32 tmp;
-	/* Use register 17 for GART */
-	const unsigned eng = 17;
-	unsigned int i;
-	unsigned char hub_ip = 0;
-
-	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ?
-		   GC_HWIP : MMHUB_HWIP;
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
-			tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
-					    hub->eng_distance * eng, hub_ip);
-			if (tmp & 0x1)
-				break;
-			udelay(1);
-		}
-
-		if (i >= adev->usec_timeout)
-			dev_err(adev->dev,
-				"Timeout waiting for sem acquire in VM flush!\n");
-	}
-
-	WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req, hub_ip);
-
-	/* Wait for ACK with a delay.*/
-	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_ack +
-				    hub->eng_distance * eng, hub_ip);
-		tmp &= 1 << vmid;
-		if (tmp)
-			break;
-
-		udelay(1);
-	}
-
-	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
-	if (use_semaphore)
-		/*
-		 * add semaphore release after invalidation,
-		 * write with 0 means semaphore release
-		 */
-		WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
-			      hub->eng_distance * eng, 0, hub_ip);
-
-	/* Issue additional private vm invalidation to MMHUB */
-	if ((vmhub != AMDGPU_GFXHUB(0)) &&
-	    (hub->vm_l2_bank_select_reserved_cid2) &&
-		!amdgpu_sriov_vf(adev)) {
-		inv_req = RREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2);
-		/* bit 25: RSERVED_CACHE_PRIVATE_INVALIDATION */
-		inv_req |= (1 << 25);
-		/* Issue private invalidation */
-		WREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2, inv_req);
-		/* Read back to ensure invalidation is done*/
-		RREG32_NO_KIQ(hub->vm_l2_bank_select_reserved_cid2);
-	}
-
-	spin_unlock(&adev->gmc.invalidate_lock);
-
-	if (i < adev->usec_timeout)
-		return;
-
-	dev_err(adev->dev, "Timeout waiting for VM flush ACK!\n");
-}
-
-/**
- * gmc_v12_0_flush_gpu_tlb - gart tlb flush callback
- *
- * @adev: amdgpu_device pointer
- * @vmid: vm instance to flush
- * @vmhub: which hub to flush
- * @flush_type: the flush type
- *
- * Flush the TLB for the requested page table.
- */
-static void gmc_v12_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
-					uint32_t vmhub, uint32_t flush_type)
-{
-	if ((vmhub == AMDGPU_GFXHUB(0)) && !adev->gfx.is_poweron)
-		return;
-
-	/* flush hdp cache */
-	amdgpu_device_flush_hdp(adev, NULL);
-
-	/* This is necessary for SRIOV as well as for GFXOFF to function
-	 * properly under bare metal
-	 */
-	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring[0].sched.ready) &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
-		const unsigned eng = 17;
-		u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
-		u32 req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
-		u32 ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
-
-		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid, GET_INST(GC, 0));
-		return;
-	}
-
-	/* disabllow gfxoff when we invalidate */
-	if (vmhub == AMDGPU_GFXHUB(0))
-		amdgpu_gfx_off_ctrl(adev, false);
-
-	gmc_v12_0_flush_vm_hub(adev, vmid, vmhub, 0);
-
-	if (vmhub == AMDGPU_GFXHUB(0))
-		amdgpu_gfx_off_ctrl(adev, true);
-}
-
 /**
  * gmc_v12_0_flush_gpu_tlb_pasid - tlb flush via pasid
  *
@@ -353,7 +205,7 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 					  bool all_hub, uint32_t inst)
 {
 	uint16_t queried;
-	int vmid, i;
+	int vmid;
 
 	if (adev->enable_uni_mes && adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready &&
 	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x84) {
@@ -379,66 +231,11 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		if (!valid || queried != pasid)
 			continue;
 
-		if (all_hub) {
-			for_each_set_bit(i, adev->vmhubs_mask,
-					 AMDGPU_MAX_VMHUBS)
-				gmc_v12_0_flush_gpu_tlb(adev, vmid, i,
-							flush_type);
-		} else {
-			gmc_v12_0_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(0),
-						flush_type);
-		}
+		amdgpu_gmc_flush_gpu_tlb_pasid_helper(adev, vmid, flush_type,
+						      all_hub, inst);
 	}
 }
 
-static uint64_t gmc_v12_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
-					     unsigned vmid, uint64_t pd_addr)
-{
-	bool use_semaphore = gmc_v12_0_use_invalidate_semaphore(ring->adev, ring->vm_hub);
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
-	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
-	unsigned eng = ring->vm_inv_eng;
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
 static void gmc_v12_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid,
 					 unsigned pasid)
 {
@@ -577,9 +374,9 @@ static unsigned int gmc_v12_0_get_dcc_alignment(struct amdgpu_device *adev)
 }
 
 static const struct amdgpu_gmc_funcs gmc_v12_0_gmc_funcs = {
-	.flush_gpu_tlb = gmc_v12_0_flush_gpu_tlb,
+	.flush_gpu_tlb = amdgpu_gmc_flush_gpu_tlb_helper,
 	.flush_gpu_tlb_pasid = gmc_v12_0_flush_gpu_tlb_pasid,
-	.emit_flush_gpu_tlb = gmc_v12_0_emit_flush_gpu_tlb,
+	.emit_flush_gpu_tlb = amdgpu_gmc_emit_flush_gpu_tlb_helper,
 	.emit_pasid_mapping = gmc_v12_0_emit_pasid_mapping,
 	.get_vm_pde = gmc_v12_0_get_vm_pde,
 	.get_vm_pte = gmc_v12_0_get_vm_pte,
-- 
2.55.0

