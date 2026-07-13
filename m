Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E548AC4450A
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 18:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D6210EABD;
	Mon, 13 Jul 2026 18:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xAFrzaPa";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013062.outbound.protection.outlook.com
 [40.93.196.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F05210EAB9
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 18:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEcBmwQaX28l6suZRoF0EfWUjlo9EVIG6XvGhOFD777zEqloUukm+/f86kYN3NRpckKla24QxQUDaq/DWCWFrUOGhLNZ3cIPQIwjvoLfSEylOlBYr7fAzGvo2IiLQrtkp88wnaesHHFlOsRABfHGVjRA57KXDE/6HguxvGq9D0hBurKoTeqsidO1+hYlhovd8/eQ35o77vYhxznyrh1RpDXH0AErteI55djnFfMTVs4sre6HAKHNwO3zyDckPhqiaN8VrKzcu7etwwpbuw2eYW0TiXwXdu1G9XcdnzAsPYbI3HZwSOnse9noI7MjF68Q7rmEo9lCN2u3qMC1KG6SpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiRGiiCiOeDJ0m8ssH8bQVd076gWdIv3tu0jFNK9tzM=;
 b=ZFaPhQecZOuC/4PcJBMvAehtVwK22KVB7kO8KRGYhYOsblByh7XIoHrlMh/gCeGDgX1d9mIoiKNy+0cX8TZOW/wxk5+k0Rn5z5sAXbJomzSsT+/k3+UTrazv3zP6PWiKJ5woad3XaVzA0li/jGx+MMO8xg1Y/Zp7ASHqma8TBmbejGWDfzhYlPzq7SvfIBnHjR0BFsntSF+wcCg2jHufwwTl5yG/Eva8bJEb0OAi1/St/Rp9xsitcbWgxtBVc4wJpkU3pxcReHlXo+0ysjPjgAUQsswPpQ0UJgQiAlpHv1DZUQmUUapRCP1tqJVq+ws2oeFKEBO3W48wzLRiRM9IWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiRGiiCiOeDJ0m8ssH8bQVd076gWdIv3tu0jFNK9tzM=;
 b=xAFrzaPag82Pg1K0LE2om0rYurL1xnrv+ifENttNZq9Gpsaknx6M1iEIn6B0xsLrqwhCnxcOOsSnq+0CpyFD5tzh9Ky+8ISoQxChbXT0Vj7f67n5ZOpi3ClBVBvf4iBmZLZ0N2BPSY8IlzzDoYvR1iPlX0DU4MINtk/r2bgxi/Q=
Received: from SA9PR13CA0050.namprd13.prod.outlook.com (2603:10b6:806:22::25)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 18:27:52 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::23) by SA9PR13CA0050.outlook.office365.com
 (2603:10b6:806:22::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.8 via Frontend Transport; Mon, 13
 Jul 2026 18:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:27:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 13:27:48 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 13:27:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/14] drm/amdgpu/gmc11: switch to new gmc tlb inv helpers
Date: Mon, 13 Jul 2026 14:27:31 -0400
Message-ID: <20260713182732.630947-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713182732.630947-1-alexander.deucher@amd.com>
References: <20260713182732.630947-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d33a022-4c78-4bf4-60d7-08dee10c71c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: xMPe/jM4Jgk4+TmNGIsLyWcceV9JhymzQW1DtXAU71q67DYwNeQdfPudKnQik+96scKkrJmRtOIJkAQACw4Qx6xrYHj3EUgnhu7GHzxHK7DztqCdxR+thDnbtSw7HnVoUy9ZqEPJKwRIdPCP4I+aHbGyETr5A13FRMdTXcrp6BND5XrbVM2xvv/rg0PmtpTzElq8Kh1U4XhBcC5zdAPmcH5t5ARpnP8FZaP+dt3l58jLUKxAy/QQWnR+bcL2XrU1t7nKuYcZlQtFhHpiBxJxsDPAJxxykYcDCMUO8Iu5QrlVQBcziRmMFuzt3sxQPVbFOmi90wacKO9f9tx3a7RVWQhKnsdyguxFLjNtUo+sy86bwKZPAsLH/Y9a+rvm426E69kD4yU6ADcB0eSltIHP3VcUckRa+0H1mTA+7GzlhhnkoxK1zVTOX0jOuzYmbQVDlqp/HEnOpDnV5sSWANQxwjUfxM0DP52sGIwEoiiMlkkSmYqJ21+WC7OJY0LmM15AcsgEcbZQfJU/jrCFDA9aoR9ym6FcH6zda1TxUW9wrN43E6TOiv5X7ZLWig9EaAKGgXoz4xo8MDcHTni9mw1lV3T7eiT+cXIEhZ0AP+VcbgJGKarfES7gnzlZ7rlaleb1lIF/b1OyFfzuzK8RXRVdztMopGUnd+BnIco9HCVzBdjr3hUQ7gfLzNGW7YRfD4pvKiPF7vegDLDRdfsnb5m5wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K7pOrrE0a5wGkt5sJnZq++E1+zV4a/ynx05Bc/TRDRnffy7Hb3BqT2H4W9tyZGSzvC1d1XV2RnrKf3c3EtPjJVqwPTk5EmegoLcxyAJlQnzsrdG/nIayIySZJidQ7XbOJJGx6g+yUINjGgzDjRZ6E4vHcWMKKGhRjDvh1PWsnnaA69Vo0H1nTbPPvr1Ctk+pj/mW2DKNFQCSUJiDkq1TRxbvbAxSdRgjkqbn6QINje8TBA4wt3/3XbCgJFhHlSbD5QzrAuU3SeaTtC4VRhezzqmEGoRkqSNLfj9GDkXI/f/VOqMuKDyIDxB6Jg2pOXyJFhCkD6hK6TtOpKVj5oNNomebx9ve3qajODD+GSjpuSmqqmFVmTKlKOjNMwNYnqLKhtLzDZ+wENitakKZSRG1dQbyF2kLpIdrZdoMzK+nz6es3uTOjIxSTOnyooERZMyG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:27:49.7191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d33a022-4c78-4bf4-60d7-08dee10c71c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685
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
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 191 +------------------------
 1 file changed, 6 insertions(+), 185 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index e3d74dcd8373d..5ea8e323e98ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -184,20 +184,6 @@ static void gmc_v11_0_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * gmc_v11_0_use_invalidate_semaphore - judge whether to use semaphore
- *
- * @adev: amdgpu_device pointer
- * @vmhub: vmhub type
- *
- */
-static bool gmc_v11_0_use_invalidate_semaphore(struct amdgpu_device *adev,
-				       uint32_t vmhub)
-{
-	return ((vmhub == AMDGPU_MMHUB0(0)) &&
-		(!amdgpu_sriov_vf(adev)));
-}
-
 static bool gmc_v11_0_get_vmid_pasid_mapping_info(
 					struct amdgpu_device *adev,
 					uint8_t vmid, uint16_t *p_pasid)
@@ -207,116 +193,6 @@ static bool gmc_v11_0_get_vmid_pasid_mapping_info(
 	return !!(*p_pasid);
 }
 
-/**
- * gmc_v11_0_flush_gpu_tlb - gart tlb flush callback
- *
- * @adev: amdgpu_device pointer
- * @vmid: vm instance to flush
- * @vmhub: which hub to flush
- * @flush_type: the flush type
- *
- * Flush the TLB for the requested page table.
- */
-static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
-					uint32_t vmhub, uint32_t flush_type)
-{
-	bool use_semaphore = gmc_v11_0_use_invalidate_semaphore(adev, vmhub);
-	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
-	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
-	/* Use register 17 for GART */
-	const unsigned int eng = 17;
-	unsigned char hub_ip;
-	u32 sem, req, ack;
-	unsigned int i;
-	u32 tmp;
-
-	if ((vmhub == AMDGPU_GFXHUB(0)) && !adev->gfx.is_poweron)
-		return;
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
-	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring[0].sched.ready) &&
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
-	if (hub_ip == GC_HWIP)
-		amdgpu_gfx_off_ctrl(adev, true);
-
-	if (i >= adev->usec_timeout)
-		dev_err(adev->dev, "Timeout waiting for VM flush ACK!\n");
-}
-
 /**
  * gmc_v11_0_flush_gpu_tlb_pasid - tlb flush via pasid
  *
@@ -333,7 +209,7 @@ static void gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 					  bool all_hub, uint32_t inst)
 {
 	uint16_t queried;
-	int vmid, i;
+	int vmid;
 
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
@@ -343,66 +219,11 @@ static void gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		if (!valid || queried != pasid)
 			continue;
 
-		if (all_hub) {
-			for_each_set_bit(i, adev->vmhubs_mask,
-					 AMDGPU_MAX_VMHUBS)
-				gmc_v11_0_flush_gpu_tlb(adev, vmid, i,
-							flush_type);
-		} else {
-			gmc_v11_0_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(0),
-						flush_type);
-		}
+		amdgpu_gmc_flush_gpu_tlb_pasid_helper(adev, vmid, flush_type,
+						      all_hub, inst);
 	}
 }
 
-static uint64_t gmc_v11_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
-					     unsigned int vmid, uint64_t pd_addr)
-{
-	bool use_semaphore = gmc_v11_0_use_invalidate_semaphore(ring->adev, ring->vm_hub);
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
 static void gmc_v11_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int vmid,
 					 unsigned int pasid)
 {
@@ -542,9 +363,9 @@ static unsigned int gmc_v11_0_get_vbios_fb_size(struct amdgpu_device *adev)
 }
 
 static const struct amdgpu_gmc_funcs gmc_v11_0_gmc_funcs = {
-	.flush_gpu_tlb = gmc_v11_0_flush_gpu_tlb,
+	.flush_gpu_tlb = amdgpu_gmc_flush_gpu_tlb_helper,
 	.flush_gpu_tlb_pasid = gmc_v11_0_flush_gpu_tlb_pasid,
-	.emit_flush_gpu_tlb = gmc_v11_0_emit_flush_gpu_tlb,
+	.emit_flush_gpu_tlb = amdgpu_gmc_emit_flush_gpu_tlb_helper,
 	.emit_pasid_mapping = gmc_v11_0_emit_pasid_mapping,
 	.get_vm_pde = gmc_v11_0_get_vm_pde,
 	.get_vm_pte = gmc_v11_0_get_vm_pte,
@@ -933,7 +754,7 @@ static int gmc_v11_0_gart_enable(struct amdgpu_device *adev)
 	value = amdgpu_vm_fault_stop != AMDGPU_VM_FAULT_STOP_ALWAYS;
 
 	adev->mmhub.funcs->set_fault_enable_default(adev, value);
-	gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
+	adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
 
 	drm_info(adev_to_drm(adev), "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned int)(adev->gmc.gart_size >> 20),
-- 
2.55.0

