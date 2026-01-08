Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86822D1D468
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1691510E782;
	Thu,  8 Jan 2026 14:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m4UFICNB";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26DCE10E77B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1c1sxP+gm/0fA3JCi/LfT4LAs19vMognSJrctmL5QuMyhPiI4SDkBSQH5J+IJBZ9Q5nT+gMKvSzCwa/2cvkgSERcfsbZlVjtiG5LO9XGUyEWap0n1OxChUWk0djyHsCFyh1rGMXAKW1UXngEgZ7ti45uo+VLKr++nXZubicr6zmo9BUaYxmWawSBQ7I+tc2x5JpjjWTuNiudA0dB2lywNGqGJZvky/fz9CuJxqtUD1jyIyHuHYF6LyN+XMOAY3/bMHpkpLo6LUZ8hY1N2N28LzQycQMjvUsyEkCQakahcNHlt937KLxq/jw9NQvz3vv1v/sEoDQERBiF6QjF85kTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziGVQ3WbrCDAoqFPbx1yTVRQ2dwEWZ+XCYn+d8p2Lv0=;
 b=e53dBaIYXYXRTcvVbNsyBHhLlIgZsfAMqcP3wzbizH7DxCpj9ku2GDF94iecqIMqceg/2bmOSc25v+/gkqAHpy917z75nMkP2zu/Lxk4IHtILp5vn1nIhTDkjRW30Vmz1AKl10D4klSu7trcDppd3BvNcMfP2Q+mQa58loX9krhC+mCSAf1nxkJhqXe6S9nWoc96+LVcicTOMRQh8hnrLVbPcmEM8c7AyuT9iWgYXDLDlG0ZuiIvWK1PKdoSPFcmH1WsWAoXvHFakxmmRGOODUpOw1/nRHMk0w4BGeoEizaCfZQsRsPziHS6QysT+WLtileQB3UO56i7ZdlWNFcoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziGVQ3WbrCDAoqFPbx1yTVRQ2dwEWZ+XCYn+d8p2Lv0=;
 b=m4UFICNBRtWhkmUOm4acNM/4k84tsL2iqORC85O7TC/EWxEhJ3PmA0Co2Q3noIIBXuf4drqe9xafYU5cb88sX5HczR/gsL0GP+qR4obm6A9O+udnr21GMOy7EbkZRuB35G+k39R+hmnf01UkwCJWb5VKqEJCYrxFlYDzkG1iB4k=
Received: from BYAPR02CA0040.namprd02.prod.outlook.com (2603:10b6:a03:54::17)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:49:17 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:54:cafe::d8) by BYAPR02CA0040.outlook.office365.com
 (2603:10b6:a03:54::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:07 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 06:49:06 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:49:06 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 37/42] drm/amdgpu: split vm flush and vm flush emit logic
Date: Thu, 8 Jan 2026 09:48:38 -0500
Message-ID: <20260108144843.493816-38-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 3abb728e-c5c5-4b94-071a-08de4ec51981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W/4GRtVPo7mTkvI7DcwnpXW+69ZkGVZBQhZxmiS4s4UsWOkDvtTpI0rU42Qn?=
 =?us-ascii?Q?ssB8iuxV5UH9xj6whk/NHurmOfrwdsPI+VAE57/L7ngV8nNvJ2eTQFmRtbyD?=
 =?us-ascii?Q?fcV6KyF9nzVLJdJjm6xJ4R4V/02zoPp1qERviPnmOw75tkDysUhFTHWhBuRE?=
 =?us-ascii?Q?75yig2YtkKO4kb2bec+gNntAYizZahiEGXW07ZVeJxnIOm62Do6Ucpy/XVKd?=
 =?us-ascii?Q?nvl7w7ecm9EodIMQQ3gaxGueZBa9oWNP1ABYL4FubjCq+qcNrEUsG/xSosem?=
 =?us-ascii?Q?SYEMKRxOaH1glFK5fCf39u8z5xFymJN5oerWnwhkTuwPh4MJxcmhMutI/mD0?=
 =?us-ascii?Q?VT9GFWhGTfgE5UB2BA07/gYEoee3hblqNvY0mGy2w5U7TagZH8inM8RgZfn5?=
 =?us-ascii?Q?3A/8jQ0xezQxAx1kEl9v1r+Hy3f/JSL2fjMC/YNSXGsy9MvKXnKJYQ2h1isk?=
 =?us-ascii?Q?6mA9MV++W2A2so+XUe1d9zgXa2JlBBM+QUfqhlumoBxqklLafXP1Bwk82z2T?=
 =?us-ascii?Q?ujYHBHjeV5mLNItO1Pq7g0RI0XSuBmcsqjIObIHjyRTVaCet1xLjpzM5ZoJE?=
 =?us-ascii?Q?g8bfNSAADQBaQZukkPJIcCvlKQwgPGGpLPARv8xQgc4dtL/87rgVm60IfFrm?=
 =?us-ascii?Q?gbvgSVBaMzgMMlH46u/IRo194NLuwN72zdIVazdGNOo3uUHKk/fjmAmWMtM0?=
 =?us-ascii?Q?UfcvXrD7ASw3jZMY0eV91N8RPIXVIumbZDV1ArkiuxvDDLSkVa9kbGTb032t?=
 =?us-ascii?Q?JalVjgBpJOnGOPw1TJv6u4PTLdyT8tiurIwHhdqfdw/QjXyNdWKFGsLMnkIQ?=
 =?us-ascii?Q?7+5Ffs+KY/lTNtDZ3MqFy95xkwYzWKAuJQwjfE9jSCpacQlGAcGfULzm0QyP?=
 =?us-ascii?Q?vnu/btqOjfF4oKQ1szA0COLidAZnm0aPnkAjKzKtszIvfwMeguJs5DZlmPw7?=
 =?us-ascii?Q?LHq28pFeRXuf1TzOdgfLjrLmikuuixLWQ3LFWVnnEoduoo0slMOdAWd7mwzE?=
 =?us-ascii?Q?vw8EI2IXfb0ka7UefXtX9xNU4mSh2e9iff2CMWFJVO1zPgMQBaTaR3JOtbde?=
 =?us-ascii?Q?pcIWzsM70i9li1TSTiKNNZRec2qV30u8eFUYv5H8dhAP42CF0ibUAcS5sLXZ?=
 =?us-ascii?Q?noeTuV7Vel5nXyPP3zkiF2SHN295Kli45KLXCz4XpL4Gc3v2jKNIAdhDDm9F?=
 =?us-ascii?Q?C6IA+owLgJLDisv+vj+TCzNH6QoGQnj2D1nKYFdMTqhqX0VfOBOKCazyV+AA?=
 =?us-ascii?Q?woNC8Xbh6dtcdcvojvgohikMzMxl6YJMKANojkVe0VY1y8hRUenfrrL3flEC?=
 =?us-ascii?Q?ybiy8O/Sc4G3PIIcpCNi0oQvCxfw4hsHXQt38qkvVqFEmxH8sz4FLKSjI0At?=
 =?us-ascii?Q?6MaSJDkn7I4xss8Jmgws2O8XCfOhtCvSkQ6r4E4Ga3Uc6eAHsX91WDEkqgAY?=
 =?us-ascii?Q?pS6vppN6qEcPxcbmktj4tRX/tJc/brq9Psybg2U3Yha71AnEJPjoRb9OR+i4?=
 =?us-ascii?Q?5zT6snu1xzzqANdfgBduQEyiHYP229DpTjOq0Jfw8X0QL173IPeVQHCC9w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:17.5249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abb728e-c5c5-4b94-071a-08de4ec51981
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906
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

No intended functional change.  Split the logic into
two functions, one to set the state and one to use
the state to emit the ring contents.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 92 ++++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  1 +
 4 files changed, 56 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index d2f03060d9d3a..54d7a975a74c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -213,6 +213,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_ring_undo(ring);
 		return r;
 	}
+	amdgpu_vm_emit_flush(ring, job);
 
 	amdgpu_ring_ib_begin(ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index d53c13322a648..72d50602a8e52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -108,6 +108,7 @@ struct amdgpu_job {
 	bool			vm_flush_needed;
 	bool			cleaner_shader_needed;
 	bool			pasid_mapping_needed;
+	bool			emit_vm_fence;
 
 	uint32_t		num_ibs;
 	struct amdgpu_ib	ibs[];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 374991520ad2c..6c84677daad4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -756,6 +756,57 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
 	return false;
 }
 
+void amdgpu_vm_emit_flush(struct amdgpu_ring *ring, struct amdgpu_job *job)
+{
+	struct amdgpu_device *adev = ring->adev;
+	unsigned int patch;
+
+	if (!job->vm_flush_needed && !job->gds_switch_needed && !job->need_pipe_sync &&
+	    !job->cleaner_shader_needed)
+		return;
+
+	amdgpu_ring_ib_begin(ring);
+	if (ring->funcs->init_cond_exec)
+		patch = amdgpu_ring_init_cond_exec(ring,
+						   ring->cond_exe_gpu_addr);
+
+	if (job->need_pipe_sync)
+		amdgpu_ring_emit_pipeline_sync(ring, job->pipe_sync_seq);
+
+	if (job->cleaner_shader_needed)
+		ring->funcs->emit_cleaner_shader(ring);
+
+	if (job->vm_flush_needed)
+		amdgpu_ring_emit_vm_flush(ring, job->vmid, job->vm_pd_addr);
+
+	if (job->pasid_mapping_needed)
+		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
+
+	if (job->spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
+
+	if (ring->funcs->emit_gds_switch &&
+	    job->gds_switch_needed) {
+		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
+					    job->gds_size, job->gws_base,
+					    job->gws_size, job->oa_base,
+					    job->oa_size);
+	}
+
+	if (job->emit_vm_fence)
+		amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
+
+	amdgpu_ring_patch_cond_exec(ring, patch);
+
+	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
+	if (ring->funcs->emit_switch_buffer) {
+		amdgpu_ring_emit_switch_buffer(ring);
+		amdgpu_ring_emit_switch_buffer(ring);
+	}
+
+	amdgpu_ring_ib_end(ring);
+}
+
 /**
  * amdgpu_vm_flush - hardware flush the vm
  *
@@ -775,7 +826,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job)
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
 	struct dma_fence *fence = NULL;
-	unsigned int patch;
 	int r;
 
 	job->gds_switch_needed = ring->funcs->emit_gds_switch &&
@@ -810,35 +860,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job)
 	    !job->cleaner_shader_needed)
 		return 0;
 
-	amdgpu_ring_ib_begin(ring);
-	if (ring->funcs->init_cond_exec)
-		patch = amdgpu_ring_init_cond_exec(ring,
-						   ring->cond_exe_gpu_addr);
-
-	if (job->need_pipe_sync)
-		amdgpu_ring_emit_pipeline_sync(ring, job->pipe_sync_seq);
-
-	if (job->cleaner_shader_needed)
-		ring->funcs->emit_cleaner_shader(ring);
-
-	if (job->vm_flush_needed) {
+	if (job->vm_flush_needed)
 		trace_amdgpu_vm_flush(ring, job->vmid, job->vm_pd_addr);
-		amdgpu_ring_emit_vm_flush(ring, job->vmid, job->vm_pd_addr);
-	}
-
-	if (job->pasid_mapping_needed)
-		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
-
-	if (job->spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
-
-	if (ring->funcs->emit_gds_switch &&
-	    job->gds_switch_needed) {
-		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
-					    job->gds_size, job->gws_base,
-					    job->gws_size, job->oa_base,
-					    job->oa_size);
-	}
 
 	if (job->vm_flush_needed ||
 	    job->pasid_mapping_needed ||
@@ -846,7 +869,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job)
 		r = amdgpu_fence_init(ring, job->hw_vm_fence);
 		if (r)
 			return r;
-		amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
+		job->emit_vm_fence = true;
 		fence = &job->hw_vm_fence->base;
 		/* get a ref for the job */
 		dma_fence_get(fence);
@@ -882,15 +905,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job)
 	}
 	dma_fence_put(fence);
 
-	amdgpu_ring_patch_cond_exec(ring, patch);
-
-	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
-	if (ring->funcs->emit_switch_buffer) {
-		amdgpu_ring_emit_switch_buffer(ring);
-		amdgpu_ring_emit_switch_buffer(ring);
-	}
-
-	amdgpu_ring_ib_end(ring);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 89b76639cb273..0ce37aab8b518 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -512,6 +512,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct ww_acquire_ctx *ticket,
 		       int (*callback)(void *p, struct amdgpu_bo *bo),
 		       void *param);
+void amdgpu_vm_emit_flush(struct amdgpu_ring *ring, struct amdgpu_job *job);
 int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job);
 int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate);
-- 
2.52.0

