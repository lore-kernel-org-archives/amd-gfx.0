Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BF5D38FED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41CC210E63D;
	Wed, 14 Jan 2026 16:53:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vX+C/T7w";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010027.outbound.protection.outlook.com
 [52.101.193.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11B4A10E63D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCQqTTNCtoFCNsK9imErUSK0oVSO5m+O5qBFD2PMuAHK8IzfAnd+apBPpFwgNt8XFA9f13yK6HrPES4rqbFDVdC2WiZNdFFNRLyWkc17NqmZf6faowR9CiFIE7a42nrdqOy+r5flzA9kqTC2mZZ0da7mkMUwa4SyoPHGNx7B2wkgIAnP2837DzyVVkQbbebSDL5HePkEIXAz6DtymTfVlRQ3Agh735Sor3my33qKfVl9F2AOFz5pl6TD9dtPlc9djMUD86QaLCmDEIiz30uGOl0cyxumE0zhV9HR+9poNtAz/OsKyQnXThNe5WIWFmIReVg29vENmrYe6fV9dfft2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+lIAUDixGJN5jVOBDJVxuDpEWY/arp+WwLaARCTmXI=;
 b=gdM7VD3O88u3VWctPXJaahznWp7w47gcsxRBoa737mJmfuRwDcWEsJU5Rj24HjfrBlXV+pG+fJCyO67St/jXQ6ljYHKIUF+BelYUIvdwzUn9nI+QMBp5AFcDb+UcNag0O6/jWG4XMZlLdL9/8MupXt04+/nsBeFt5YqUkMUTmzZa91vmaypUZwfVWhQxpBPhawLoCrLVymptuSMDMP5N7bpceiP1O0piOzmtOolva6OowicU3VwBZCuk62IcKeAENw7fCIqhG+oX7905CNcUjFXT9gQ1WAxsu5tVVVVvFWQZud9cbMm4gnTRunkahvP9/Lc5Bcrvi+rbXBNotMT7Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+lIAUDixGJN5jVOBDJVxuDpEWY/arp+WwLaARCTmXI=;
 b=vX+C/T7wVQNFzh1SNHCej/ShVnJBSvo6kI681G4l67QNN/lV4xIweSSDHw+KSahgBbmi/slEhPRfIYBifwVyfuH3lGl4ELyzAm4R/YUza9Rnli8x/IVkiau2YgD41t86HwxvUR6PhAOcXgfo7G1i/oeE1vtZydFXe5LZbBIBLYs=
Received: from SJ0PR13CA0223.namprd13.prod.outlook.com (2603:10b6:a03:2c1::18)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:53:07 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::62) by SJ0PR13CA0223.outlook.office365.com
 (2603:10b6:a03:2c1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:53:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:53 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Jan
 2026 10:47:52 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:52 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 35/42] drm/amdgpu: split fence init and emit logic
Date: Wed, 14 Jan 2026 11:47:20 -0500
Message-ID: <20260114164727.15367-36-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 92aea5d2-4c71-4d48-9ec1-08de538d6414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QSalFRM74ETRnT7ujef7pRF/3O3z7uxbAMTHGHYK3ur72+qK8QyYg1MOSwPK?=
 =?us-ascii?Q?uIGh5Iqy0SXkcg6r4OaFgt36ZCySMIa0pnZ8gxbmHn5gEl8CpUKRXzObpq3o?=
 =?us-ascii?Q?wk19nws750g4l6KVbMZNeV+s+6yfR05bCQJNC8vmCLUi9gLb8KDD36JBbA1Y?=
 =?us-ascii?Q?iFFS9ioH9K0xDnUGy3+CNizPWirGwuLUNZ8YKwsg2M2jalCnzz2Bqli02qSO?=
 =?us-ascii?Q?8UKvXhy3r/49cnDz8b43onTyAwqc46+KpGFjRVAtYJcaJLaJsQ93Gqrb92Fh?=
 =?us-ascii?Q?RbfGZis4E27jvRMz1cfvQKjEYqa0Ilv0NVZgvlV6Y6lW3WZC3tf8mAjInaGg?=
 =?us-ascii?Q?yL+qrA3PygqnC9Rm/dRszz/nkxN3fBCUObxgQ0LdqKFg4lvtJ0pZw2DNETTX?=
 =?us-ascii?Q?aDBWMWSa8ylgMvCwsx8PSp5bTzKrLt8hccuvm7URNv1qEbMcGYNCQHM11kte?=
 =?us-ascii?Q?UL6xSnA5Sud65of7IvCW/9Ieo3h5QPivjJFDQv3QtcZW4HgVSLGY5z84hRDJ?=
 =?us-ascii?Q?Wgv+kDUYJ87ysXf5lQzT4HT6pqjGm+9JwsHpIVFA53AGa+wV7j4/IMTGO5+a?=
 =?us-ascii?Q?K4CyyJ7g/Fg3YGlfLk3buh2+tUfr8X4nEn3mwTizHQanl4ZpMM8xCKo1Yzpt?=
 =?us-ascii?Q?VVeiuDxBSwCd2koZZdqK7D2McfbAlbrzkoL+J5J2ma2kNBTEGEHqLaG9cOWI?=
 =?us-ascii?Q?5f2GkDdz51zkXxxMVoCtTiZJTsFgp6Lgj7dOOxKCO+g+5jBPNmQAj0IwuXDi?=
 =?us-ascii?Q?XpS7X0N6jL71RScBQmo0TSKInlbzI0caYQD1Q0mtEftp5HM2GjLO4NOLMXDt?=
 =?us-ascii?Q?A1qxTp5Ddy0gwBb2moxgRcn5Xd+J/DIv2ATEzwKIlxTc+SWhK+cQDV/p00nL?=
 =?us-ascii?Q?IxqxzEoQDyz+LU5RtPISm5BjYT2OqCLlsHGcqnmBLMt4OQsDvfxafl00mQod?=
 =?us-ascii?Q?v6FA4bbW0A7gXev5MrEma0/2afg92QbhKtbea0Eq4SziGXXHXvSUbHIhCwBS?=
 =?us-ascii?Q?HLYkCxFffgDD18BIPvONIfgLFgC5Crfoy6nwIh9Q1vhw0gmxaH0Hwz1agW1M?=
 =?us-ascii?Q?YyvV7F6o/HlKnlL5b6IKv93M65HoC5xt71RLWh08QUebn/AfBSSurfy2tqaI?=
 =?us-ascii?Q?PyDnV6cVgL4iOChmA+nGSm3/FhVjj8SmjpWIC0JzmFjHI7vzGNnH62bo2bW5?=
 =?us-ascii?Q?89T+3vV5xOshUn4Ml3Ig0iC2Hfilv7ZAZfcP7XtAJBh7vd3Gnws14FC1wKH4?=
 =?us-ascii?Q?z1T1km6n6ixx2gmsWOl7rDpRitEC2/JkObXMAZVhdqGCNBlwB3nMDsxBGFci?=
 =?us-ascii?Q?oO/jyU2bftEa7gbi5NEqT70XH3GQOWpvHISvayWE+weNEbiECUK9n2H2fjGX?=
 =?us-ascii?Q?Fvxa/zlLxTaH0ptVlketXngzKcLJ9exNh5+Ruw1g11sFmowDuCUoRJrMq+q4?=
 =?us-ascii?Q?ersEDx4dbkv7i4R6L6nhsUN7v8DuzsG8Yo4h+NXdcU6JSe/ewgnwyH3CNUFB?=
 =?us-ascii?Q?vWDyfVAhZo/8BwQRY3qAploYM5umPbL+A0BbvfbP6jFeneB7wSs9Fyc8AAvJ?=
 =?us-ascii?Q?Wh4H7YGIIVi9XQSRTARLah8/c8uOd1jtUtixs1aArU8uYm1CtWcbX3grGxMf?=
 =?us-ascii?Q?IX/uVNDH4a+c46DFbdfHRIlNKMeuZfpqCusNNvngNEALvZMsTJh7Oc5tCxa1?=
 =?us-ascii?Q?gQY/1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:53:06.6423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92aea5d2-4c71-4d48-9ec1-08de538d6414
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
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
index 036a9fb4e1ca3..49c32ad975203 100644
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

