Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0BEC5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 17:29:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20C5910F6D5;
	Fri, 14 Aug 2026 17:29:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nqBrObED";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013026.outbound.protection.outlook.com
 [40.93.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2100210F6D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 17:29:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KlLUw/yKVJofDsXhECTNIaIkwmY87xIRKGPIasQ+kJltf+7nL6IhXJXMPHGYQWfPzau/FUsRVH2XWJhmpy99lxE66qc42aeOIttd5DOoqKMBhx1MQ8+L9zacFe57iZrFRLE+JCimHCroQ05GTC+DjIqUF1sdtz5hl5iRSKUkG6bN4+ue41W8RWxvJf/7qahPtAojA1dtr13zhpSt0kokI8n2ATU4bJF4swIRVRmwjshGGRyDOrSv8wzdP8FoJi5x6Po7cjEF8lBuQbGyZ7i2RrXBbIZsN1pJk0GuwJn6u3SPXS8pYcZOk7fBeuU9MgII0quDS+5IqnzthOch5B6yUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWg9aPK2fYryX1GDhCw0ocOMFB1qQfHIUqoMbsVPXeo=;
 b=CHi5AP/BY9y63c1U+kR+7Els25WuwT3vsKHTAm1BmxOftpLr57Z/K0K2ZbqphodnFMI2JrOvCmzyfpEYVITw+NyRMohRUkh7zfOgtqJobW1SFscsDJsUKn5i9IQ6MWMICi5mjbU/dOgNcPB9sp/8oan/MNOptRdWSIU6Zc+EKpsh6YBV4olX4SEkzP/gl8OsxRJCeKQ4pIT7j0Qv6WY1zJ3JQb6uwCIDyPHIt/KAaMkQqqtySVQF6GDEfWr5uM1sGFIftaPcUy6bza/zS3KEqnDlF/pfkk7xKID0qYM1uH8F1fm9DU28yEkdL9P9dKpcy6+YtoXSWfHftCZ66PBqaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWg9aPK2fYryX1GDhCw0ocOMFB1qQfHIUqoMbsVPXeo=;
 b=nqBrObEDdiqc5eMcqzUtc042k//QEDkghblxBk9pPzVqQfK4xxd0a+scnQ0trIi/HomsgY58mSN98PN7hNGOA345IWIF8F3HqkVA+hpgwCQQKeQ+kiXoqcN5m8pt/W9YKIExVByjdN8ZgqHp7bjK9du6DswmxHZmdKNdQD47hHI=
Received: from DS3P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:45f::8) by
 SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 17:29:44 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:8:45f:cafe::e) by DS3P220CA0012.outlook.office365.com
 (2603:10b6:8:45f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 17:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 17:29:43 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 12:29:42 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 12:29:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, David Rosca <david.rosca@amd.com>
Subject: [PATCH] drm/amdgpu: handle pipeline sync without a VM fence
Date: Fri, 14 Aug 2026 13:29:14 -0400
Message-ID: <20260814172914.2691513-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b35695-130a-4e07-0a05-08defa29a0ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|10067099003|56012099006|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 8r++vic66rjBqoyEqx3agOEesS3UNhAVaDh2TyC3auudYptFFNpx/w+Bab8DNRsUOPv6/8JXFhtPz7/edN/5rz7xbaJcH7zmLpepZu19c+wGefQrrfQbahYaClmIscc/X2EzfUdd4PxR3QjEOThRrEtujJqUok8CQsEGiqXCcpMdeA9TXhPWMdMfb97BMTFDfshdvcy6KZF7HO5S8Av1qmFrcuH0yrc3JoBham7fBlxt7bhN8HARapkQ1ogAI2e3pkIm2nyJfB80e0UxLn35b7gupGENQw1ekYzromlJwQVRsXGzGcRRjoXo0ZU/sQ8b0NLzmt/uJXkJCD3wog61XyeSBpcQOW3vf68LNUdyHg3NBENp0mDENOp0xV/On4ff8Niyy5sld34WSj1/Th+sTAQP6i34JozyfYOBCSzvJjyHG5pgnEJmzdsCWa++BkwZRxJkA1a+q7Jzh/5LQ3UaTdMsx59BuR1HNsmjVMfaBesC2RnR/U5Q5LR3dUQvSQ86ywEcf0/yOWc/oCuCCoyxWKFXtOChdurfzrp1DqGHGcxEOHJADhvc+sJ64Qyrf2rG6IZK+hTm0r4AUENa0eJEuar+qppYpof5uVZQQWAZLCjo4GJ9PpJKDABVJ1PhbgNTJfVwC1VTjyQnEBmkHCB0ux4gTRvzfaHOYgSUiQ90LE8ggDUljBWcIcn+SxFh6ykDTveCJvEyYMaUDpg/PWnuRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cv5iTlTfoSJpzuHzlAIrJ5tYEJPlf67YIFb1+YGX9/2NzqCWcsdQFHh1nJuZaci4ZGQiVllFKzN1si/ri+dAWpjUnoXjaY5xlEx9b2crvFhK0OaN+F4unSOmbsA+07L3xrKaCwEmTFloC1cJH2t3y/UZBX3eCUT+2nsxPlCHpagNihVRLBroDoQUUHZDwHHZXeYhhB2TbsjkwyApXoUd+WnS8H/HWSi0TF23M88esGALa5Zrjp1RgfmnIp2CeefNuUc6IKBIyUdr9jik19Ll9ZdmTBG3d+BEboIPUsmeF6u9jq/EQpWnGJ1e0twKYxkoFuqkKW9BUDZ6EVwwSTt9U2xNYYAnlRi5gsy6LC3TN6PbDzzaiW1T3to9H5EOW6PuPEYmsFKD2nxvdxpS8BRml409BCAKX/qvMWIfqSDokJlxzQgtxCNC7sjxkUfKdBHZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 17:29:43.4048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b35695-130a-4e07-0a05-08defa29a0ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974
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

v2: fix need_pipe_sync handling

Cc: David Rosca <david.rosca@amd.com>
Fixes: cb1e657ccac8 ("drm/amdgpu: handle GDS and SPM without a VM fence")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

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
index 71050a86bcc3a..b7d0461184d62 100644
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
@@ -827,7 +827,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (gds_switch_needed && emit_fence)
 		*emit_gds_needed = false;
 
-	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
+	if (!vm_flush_needed && !gds_switch_needed && !(*need_pipe_sync) &&
 	    !cleaner_shader_needed && !spm_update_needed)
 		return;
 
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

