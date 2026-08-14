Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5287DC5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 15:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D1810F695;
	Fri, 14 Aug 2026 15:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KsylePrB";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011069.outbound.protection.outlook.com [52.101.57.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ECCD10F695
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 15:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duqtAlfTNhtOjXvOdhMo27Tmfr3vwpEQ4NXynqVruMswhK/RReFzrJTOv/Xza5FU5rdTwfGKbeIzeCNOUgXVMi2Hp6I+sox+cAut9qFzclHZQd7iw10XpaJu8bBRTtr5LQsGsZk2RUUCoLwMbclQeEYb/u1SjUqVLzC7O9koWL0eS+29wFsr7cW8UCCow5Y5RugSjf6TuOQ24uyF1M4jwnoZP+ZHTWn3/IppwTynwP3b4ESrE7uQ3Sm+vqG9eo6/UZnXk9SNQYwXZq67+t/Q3uoV038BaJehJlNH2Jh71XsTce/efj22ja+6kkrK1Jx+dxVOvINZjnJ5U00Zqop44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcDe4DWde1MngcBYl89RZXQfq5izyeoWoKawt/J3yHs=;
 b=USgRGFz9RAShFpl2HcKDXb+0c0QbeTNCraTcb3PcuH0hHSFVSoftPjXlZhiH33sM/IwTCznXnP6pUduOdnGdAPR62AORD2kUFGkf6uF/IfTWY0lziKbpzQsy09qK/DlKhiR+6SXWWNGJ9Zoq3uTmNAX4fVa8CU5qdNsDP5GLmrRtJkpmycPzMuG/vB05pDjeJ392LuJpfW4LvsngcE32vxAb6rOg6p2nOrZfVvEJZE2LHeL8l5EMX0/7KkVG4+kPoxt4dD28YBSy08KRowqV6YZh1RPAcm4HP2E8qTtPmYE/z28yKIFvxKW4PvlzvB6cJsZCZ2/nhpELRHpIeoAZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcDe4DWde1MngcBYl89RZXQfq5izyeoWoKawt/J3yHs=;
 b=KsylePrBuzY1U3wOaMdtM1iKicBiMmrzJwr7WbjYJuDhnWh0RkCvkaJs0N25ea/TDZ7Ts6YzjYMFDGlMEsynA1LxeTrvfMdQa54sqTw3hkS8e+b9FVy94/8GXrXVJ62pLPFjqTzRhaoU2q79Do0VtfOHFlY72BDcJkmuoP79/Js=
Received: from BLAPR03CA0037.namprd03.prod.outlook.com (2603:10b6:208:32d::12)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Fri, 14 Aug
 2026 15:42:24 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::97) by BLAPR03CA0037.outlook.office365.com
 (2603:10b6:208:32d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 15:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 15:42:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 10:42:23 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 10:42:23 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 10:42:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, David Rosca <david.rosca@amd.com>
Subject: [PATCH] drm/amdgpu: handle pipeline sync without a VM fence
Date: Fri, 14 Aug 2026 11:42:12 -0400
Message-ID: <20260814154212.2688253-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: c3809a24-d5d2-4f29-0856-08defa1aa2b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|10067099003|6133799003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: g5CIHfyH2IoJ70hj/xKvCHFG2ZGzhaUEC/ZausEoMhrmlQu95KtUblSbjFeEL6KsL8xa1uNk6/Fk39ikkn5A9XCQRvK2cmAv1l/4xSZBTkCP5jC7WRC2KEtOaX+xFHF3u56qSfDlgQtP4I8+3A5OozCxBVek+J9N+7A9Z58+UUNOOqVZh3JHMHXbUgA+ZXa0U8qAxlLB4LJrCzy9RWbo54pD+jM4jNEE5Z71J9T/vTAjlXonkUs8OiwsPXlTACapSpw9GhArR7oAxIN+8QrtQP/I6sKKWp+sacCOkk5dd327HKmBikxAP5RWYlw599owqELpTZweF4EpVhQ/lqkpXM6iU+IrUYKN9VWHiRbMtncVA1NnCC9yqf/rKdSXV8OnzMKgYcIuHBbCSn5Hxr1FUBRkZAugXOVq082u15v89X3AUONXDL6Petd3eyz/hZyuiXd+19fvlAE2YBmmtwemU8oo638zTJ3Urnhb9HlXXpVEJaHfO5MnV1Zf7NFg/ZGqPLB4HySg0kjI4lFYxL06gtCZO4hc04U+H+KYGreEPHJM5sKR2iARUdya/F5rXC+X82q2g2DdrJjaVcvcfo/A4MvRJb0Ku36UrmDEFLn39HSSFka3XNT5h6s25OIvsCmH9Sl007hkj0a/XeACtTdF04aESJlkZUUhmuSMnOmgESGVaiwe5O430lNLabLwBgludltvGQz9VFgzIYJ9uBa7Tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(10067099003)(6133799003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: loxFN5RDG/JM8FDWqEU/F78YDrDE1MVw/ce9iP7ariDLmf9t4xZ7UJHwdebv+12eO6gsvf6cV6uEocGfb/XZZjhH9nqJF+Zw+wwovTe4gnTNyLp0vWgb4cE+6MVZEE+/S1mEGLW5Lx5HAFLhO83EqbDaF54zbCc2bXa7js0gv9Hv74nXzRv7OfiaP9dLlEXYZTzSuUFUTvsvp5JxtKvtNRTC6+cdcUyap765FSuUk8lBQSJcIk22PnujIeWme91cUjTkMM1VqqYBxJ0LYtPvWUyPLjw4rV+qKhY4mEDTM7bKHaQR+q3PAFuKTjioH4t3cAXQdAaICEBySsGqL5p7xHjorpyqTvE0KLZHWArGnyWBrBjSmSk60hhoxVYVpbV+iodFQwVtc+3iC893UI2+O+GFLIz/26X1zOnYBIJNLfO3ogUy+IjV0ZRpp6s2+VdY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 15:42:23.8891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3809a24-d5d2-4f29-0856-08defa1aa2b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467
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

If we end up emitting a VM fence keep pipeline sync
associated with that fence.  If not, emit them as
part of the IB fence.

Cc: David Rosca <david.rosca@amd.com>
Fixes: cb1e657ccac8 ("drm/amdgpu: handle GDS and SPM without a VM fence")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index da4dc489e80bd..360e6f00cb7c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -222,7 +222,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		vm_af = job->hw_vm_fence;
 		/* VM sequence */
 		vm_af->ib_wptr = ring->wptr;
-		amdgpu_vm_flush(ring, job, need_pipe_sync, &emit_spm_needed,
+		amdgpu_vm_flush(ring, job, &need_pipe_sync, &emit_spm_needed,
 				&emit_gds_needed);
 		vm_af->ib_dw_size =
 			amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr, ring->wptr);
@@ -235,6 +235,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	if (ring->funcs->insert_start)
 		ring->funcs->insert_start(ring);
 
+	/* this may have been handled by amdgpu_vm_flush */
+	if (need_pipe_sync)
+		amdgpu_ring_emit_pipeline_sync(ring);
+
 	if (emit_spm_needed)
 		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 71050a86bcc3a..4bd9368b13d97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -772,7 +772,7 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
  * Emit a VM flush when it is necessary.
  */
 void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
-		     bool need_pipe_sync, bool *emit_spm_needed,
+		     bool *need_pipe_sync, bool *emit_spm_needed,
 		     bool *emit_gds_needed)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -847,8 +847,10 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		patch = amdgpu_ring_init_cond_exec(ring,
 						   ring->cond_exe_gpu_addr);
 
-	if (need_pipe_sync)
+	if (emit_fence && *need_pipe_sync) {
 		amdgpu_ring_emit_pipeline_sync(ring);
+		*need_pipe_sync = false;
+	}
 
 	if (cleaner_shader_needed)
 		ring->funcs->emit_cleaner_shader(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 7f2ba728e3ed3..d32183cd9e0fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -512,7 +512,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       int (*callback)(void *p, struct amdgpu_bo *bo),
 		       void *param);
 void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
-		     bool need_pipe_sync, bool *emit_spm_needed,
+		     bool *need_pipe_sync, bool *emit_spm_needed,
 		     bool *emit_gds_needed);
 int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate);
-- 
2.55.0

