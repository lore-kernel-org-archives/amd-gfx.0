Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F50D1D46A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED3510E77A;
	Thu,  8 Jan 2026 14:49:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y9qSCavL";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013003.outbound.protection.outlook.com
 [40.93.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76E8410E778
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPXRy/Q57jJ+ZiLlY3uiYtCE3nX82ViUsb0+OuDDTatRE9OlLCYVAbIY41jYdF/wyzPW3EEFvJEGUCa5MUSjToEG9f/MRPWiEb6mNu2rwEUD2+OTzhH87NTskG9sBZJzqzhIPAHsCd6FWXbfniXdvbVleg1nyxQMDsu11iJAz1Ybh21l4TisRnu6V5yvX1ktPIQ8UGQrPKn1YkLRC8SJx8H7VNDNf27I4RZwo0tAUqhXTd1qcK08WaN9+8P+IpU/8z4bD8e7XRGlSshZZULPkDdulzvTGqKFDRMOl8TRiCLUuW9xRo5/duZsNGqhRvgiP2AdybiDFRm1knTA96EGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe2DuY1622LkjchV/XeqjmQGHmdfFQ8c7VtTBQudv7Y=;
 b=jr9nhsNQYWhQ99G4nAH4MSjms/K0bJdnV5abcbs/JSXKalzWrS9PJ/OC1yo1rMRRbwG5D0B+9LWAGNmPmxQ/x/o9zaWbBh9UEabjzQOTEoT+GOWiLt41aNDVHeXY+jeGerbF42B//5vzUWdUK0gSIDx7STGqGI7BMtgSBeHzDIRjqyF8gRvLHtt3vf9kmExIZQlLYWo3QA1Ub1dFke5/bFhAiDxbd6WybA2INZ3y0b2WsVJ5iVJoaI3iTJzLxyUHH/W+x3rFTQUDMPazAwbgeLnnrw5upbnexU4DXpCarxzmfr/1uvUcDdyVN9jVQ4hXQvkMzcJf9CElwXqky/GmTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe2DuY1622LkjchV/XeqjmQGHmdfFQ8c7VtTBQudv7Y=;
 b=Y9qSCavLp0qdsicp4V/QwsCBpeUaEZ4z72C+DUL0v5UcbXgzrQg9oib9kJ3m/XRtPpRztOhy6jFIhn5Eoz4peL09CVpc1AZ/zW9Gh0x3FzkZtbcdLv6yOhUDozG3eAnO0H79Q0/Kz+050y/eluAJJhprBOuKp0TGP8wCmW8sDcI=
Received: from BL0PR02CA0133.namprd02.prod.outlook.com (2603:10b6:208:35::38)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:49:15 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::72) by BL0PR02CA0133.outlook.office365.com
 (2603:10b6:208:35::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:06 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:49:06 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 36/42] drm/amdgpu: split fence init and emit logic
Date: Thu, 8 Jan 2026 09:48:37 -0500
Message-ID: <20260108144843.493816-37-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: fed8bd78-660f-42e8-4550-08de4ec51852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3AJieKV/c3hwTooGaMScJiikjqTJwXFmioJQHtkOULoT9CPAnYBre7f8dUlR?=
 =?us-ascii?Q?8FUdT846k5ivhhi1y0GBl31oGAu3aJVTx7yNdFLCqjS6IpZ8omSA8cEpvoIx?=
 =?us-ascii?Q?cQRbxnAKdWjT7XIvpAP1Ud79sYJmlsJzAZjkm1d2FyglHGa8aF1ZJ/kFcK7+?=
 =?us-ascii?Q?+FG13jbM2/SB3Sr18f7ss967tk8R2zolG4d8jmIWbYmD0cvC/MMSFQlj1bL0?=
 =?us-ascii?Q?Z+xIyJRHPqm7if2KsoWysQYt7IvKM8P0Rw+tcPmBa1sIJVV3RVPNy4JmIeQ6?=
 =?us-ascii?Q?VVsmGD1o1wJagvWzUUIUr4WKAW/+bEAQImNstSIJgI55fOfCR2JQFbHOy3Ez?=
 =?us-ascii?Q?moQHC4xMEOgOZyJHRRIAXwNOZJSDVeeO28SuoAVGFXFr2YlTtmevOogcKZ/l?=
 =?us-ascii?Q?n2mLn5qiwDLrCYVeBGium7Lxl3Fa9n3Bze/hM2UfFilnQs41/m4BkjqEUR6Z?=
 =?us-ascii?Q?oidAo0Mpck1NZBMybOSut++b1Hssn/Z25kHaHrsyXuUZz3PD3qZ46J8Tts66?=
 =?us-ascii?Q?3eMEGdwgJQAWHh7ak2w7Uoj5k8hkBseFqiSWpo6pJ/lD6uguTfKB5OlrtdiW?=
 =?us-ascii?Q?41YUL+F36rfxE9Ekeypi7kdkQrhaCQIwA4NXlSev6hXeU5v1eI8EFLkE+DV0?=
 =?us-ascii?Q?0cGX2HBYpxS8IaAF/JZDFTeZHklRSjTCuoVs6JhzA6KA5n8vimSp2J8wN+2u?=
 =?us-ascii?Q?Soi1hO0JqOA+P7RdV4AygOgZKsK5R0I+MrQXt/VbzejqiF7FZjBAwR0Y+kJS?=
 =?us-ascii?Q?2fjkSdjvYE3DW3RA7UhsEqlyatmH1IvNYzGotTCjaIbpDV4FtGisAEORk9rf?=
 =?us-ascii?Q?9/Uivt73K+HM6typMHiNRqMq5lW0fCc04FEycxvmNW/id96LRlJWjyoEfOx7?=
 =?us-ascii?Q?Z7Mi3FkojLbybXn9yCR1guSEr0fYtQpDDhh6NxMMjV/uZzloCj95nMoBlT3X?=
 =?us-ascii?Q?BQ26O5bLm1aoVy1kvirHcOaiYAPgPi0L+gnU04T6BVhC3pRXk48YhHq9v/BH?=
 =?us-ascii?Q?heR1xHqHyyJup1XslNoCEgD3RXlyNgwXDV+t3VBLaYzhAisO30D7EAEbBWjT?=
 =?us-ascii?Q?gX/BI2UJRriaOneJ1BCE/364svjFOhIM4o2jTK1VGSQvJRiW9WjTXY5nfLqW?=
 =?us-ascii?Q?fYkZAbRPjndHJYP9uP4w8sqbEjTRGW3gtYuQIXyQA5EsgmJFtX0ibdcqD61C?=
 =?us-ascii?Q?wDwkfWcpuVMPPsQlkNVIV3eQlfimj29EnEYuR2MihSgb4yrX/55IZzwK9H3Q?=
 =?us-ascii?Q?Jcu+7iM3PqtSaXCv9mKN0hVgiPNcJnAqkcyu9l0IrfLA8wlCZmQQQy4LTfy1?=
 =?us-ascii?Q?madO81jeCx7oboWd1KbCDDbsgAc1c9YcnznphbadK5PRSYk23yGwBnVHzfOq?=
 =?us-ascii?Q?ZqHMCH+B9UN/QOerpSyP87KJdSA+z7zh5EOYyFmmdiMesKt96AGznxrvAVRz?=
 =?us-ascii?Q?TeoBQvOcRJZWow5Q3oAmq8j57Wu+5Y0Ps0rltOjftqus0Ghx/bILn8GQDQEd?=
 =?us-ascii?Q?1QsHS1X4Z7qZMEdD0zEz4rssIOPpLAesjYzQvHpDM/cPFq801tVoiGfv551q?=
 =?us-ascii?Q?hpy1/x/noKJz83CcEAE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:15.6320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fed8bd78-660f-42e8-4550-08de4ec51852
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095
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

No intended functional change.  Needed to help separate
the IB scheduling and emit logic.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 19 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  3 ++-
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index b1cf9550c259b..c1cb47e92d08c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -104,13 +104,11 @@ static void amdgpu_fence_save_fence_wptr_end(struct amdgpu_fence *af)
  *
  * @ring: ring the fence is associated with
  * @af: amdgpu fence input
- * @flags: flags to pass into the subordinate .emit_fence() call
  *
  * Emits a fence command on the requested ring (all asics).
  * Returns 0 on success, -ENOMEM on failure.
  */
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
-		      unsigned int flags)
+int amdgpu_fence_init(struct amdgpu_ring *ring, struct amdgpu_fence *af)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *fence;
@@ -126,11 +124,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
 		       &ring->fence_drv.lock,
 		       adev->fence_context + ring->idx, seq);
 
-	amdgpu_fence_save_fence_wptr_start(af);
-	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
-			       seq, flags | AMDGPU_FENCE_FLAG_INT);
-	amdgpu_fence_save_fence_wptr_end(af);
-	amdgpu_fence_save_wptr(af);
 	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
 	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
 	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
@@ -158,6 +151,16 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
 	return 0;
 }
 
+void amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
+		       unsigned int flags)
+{
+	amdgpu_fence_save_fence_wptr_start(af);
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       af->base.seqno, flags | AMDGPU_FENCE_FLAG_INT);
+	amdgpu_fence_save_fence_wptr_end(af);
+	amdgpu_fence_save_wptr(af);
+}
+
 /**
  * amdgpu_fence_emit_polling - emit a fence on the requeste ring
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 8c36eaba151e6..d2f03060d9d3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -277,7 +277,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
 	}
 
-	r = amdgpu_fence_emit(ring, af, fence_flags);
+	r = amdgpu_fence_init(ring, af);
 	if (r) {
 		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
 		if (job->vmid)
@@ -285,6 +285,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_ring_undo(ring);
 		return r;
 	}
+	amdgpu_fence_emit(ring, af, fence_flags);
 	*f = &af->base;
 	/* get a ref for the job */
 	dma_fence_get(*f);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index da437c349aab9..8aab82af2e0e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -173,8 +173,9 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
 int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
-		      unsigned int flags);
+int amdgpu_fence_init(struct amdgpu_ring *ring, struct amdgpu_fence *af);
+void amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
+		       unsigned int flags);
 int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
 			      uint32_t timeout);
 bool amdgpu_fence_process(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index e480a65dbdb1c..374991520ad2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -843,9 +843,10 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job)
 	if (job->vm_flush_needed ||
 	    job->pasid_mapping_needed ||
 	    job->cleaner_shader_needed) {
-		r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
+		r = amdgpu_fence_init(ring, job->hw_vm_fence);
 		if (r)
 			return r;
+		amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
 		fence = &job->hw_vm_fence->base;
 		/* get a ref for the job */
 		dma_fence_get(fence);
-- 
2.52.0

