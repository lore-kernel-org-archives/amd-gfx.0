Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77D0D38FEF
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1089210E664;
	Wed, 14 Jan 2026 16:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QZ828I/F";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F4910E65E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRp9CGcGLy16TJxInwEjc2yqpuy2y2yzp5l3QHHxx1tj60QpdkeA6B91hI2wOoA2+6MfjfiJqEo+s5eYNXFbPAUOFkCQf+GNNB0GgHJgCgyQus+enCPOLVE8hy+P9l7EBp/QRhcvVg9F8tlNhf5CJPctNXck4ZAjYi1V31/Gos+RyyoqmE51/ro2002o9XYMoS/wPzPQANxqdGYAjXQsw5AJf3W4DVFiXEgJBk/07DGtSQdDKf6SqM6wxY0ljHW1bkojN4QSQsUsxp63PtBL2CECTTVohzbYfhrAwAHQT+erS4QIM9kDzSiu+UH4Av6SsQmUS05xL+aUmNoq8JVymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DsV4Y64Kcnihp//QqL6bFFgwWRJ2js/PGYVSPjp/Yg=;
 b=NRWK3Jzbmw8u5QoMrLoVPdpMs7HbDiYyue3KxkZpxV7uN4TYPPrfw70MhSMtONvayBYqqzxY1v/qTcnn6P7kIcXefTe7bqASvkJo7IBsfo3K7E7fJe+I3MjApiPRIdo6e7XJzQrfmF0jDOF+ZWhiIYI4AQm1k9PmAv8UQAFIinoWJMee5okpUGneqk6Q8PIEUHDZ6if5W8eX9X9fKWu4xR97VhT3qep//66hWYh+lL/WaOODvcPfTH6Vruv8fIE+Oez0Em+Z1KDrzvX7tLNy5mrnD5TJgSp/nnZZU9dFtUv6Wn0o5nIzuW2zbdKbenOrP4xqGBU9xHK4ttnnxsse8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DsV4Y64Kcnihp//QqL6bFFgwWRJ2js/PGYVSPjp/Yg=;
 b=QZ828I/FgLXKtlPUOPHIIZYjwJc+e4yZnfbCf0o6fYg0J/Oh3p2UhyU92XUHyrk2ycGGVBcMIe+mSG+vTh5cizo5tvyjDBClx/g4HRPXhtGRElCXxVUq9m+dw4v9e4APi8l7Ww+l1uMO+EFXmbVlvNHTefhyhywKzkKHQ4a+cnk=
Received: from PH8PR02CA0008.namprd02.prod.outlook.com (2603:10b6:510:2d0::17)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:48:14 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::3) by PH8PR02CA0008.outlook.office365.com
 (2603:10b6:510:2d0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 16:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:53 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:53 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 36/42] drm/amdgpu: split vm flush and vm flush emit logic
Date: Wed, 14 Jan 2026 11:47:21 -0500
Message-ID: <20260114164727.15367-37-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|MW6PR12MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 18091e96-73b9-45cc-0ad7-08de538cb568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NAopBxaaz4zgWar7YkyIPsiMFfv0D5uqy6KvqY+8BLROJzBM+UJK+abuR86v?=
 =?us-ascii?Q?02vTjeP72CrshVKgDXoCJoV5OGyy2WYSF/YaRmwH4eFzxNvEOHf+bBNP0eCe?=
 =?us-ascii?Q?XR9Q/oEDeJoVJjmzxl9lIRTrXHvTvkfzSmu8qPdo/o6gk6PQA9bzVE44TV4l?=
 =?us-ascii?Q?qpl+4NCe9P557WNa3RtY08JAJUB+auOdkJMKtLyEpYJFaWUgLogSHZFP19BB?=
 =?us-ascii?Q?tVuU2KNUoU5DfKQKvA4DftCWr1Dl1CMtyp8kzhNsN0Y8Wq7JMn/RkAMADkZd?=
 =?us-ascii?Q?Nx5gbT3yOArQACl6JPmQjBqAhRQdSlxKO/LJv6jZfoOzF/uRPr4HYMkKYqy+?=
 =?us-ascii?Q?lo3GvRwsPdJL4UwX0irttY0cLza4hHQt2sbbW01o0cgSUzBw1+N7YDio7N8J?=
 =?us-ascii?Q?IBlTR+VvsjEzMATYUbT1Zewct8cPZIe9gV7l7jMZcb9JMaPgHf30zSonoLJu?=
 =?us-ascii?Q?5PL/d4/hsKd0GbswDCZubuwFyQ4KEMXJlLNAJz54hRFeOr6qygDLPdhh9ijs?=
 =?us-ascii?Q?lSC2p7wFhJoh/nl1SG0TpZUfvkFFX3Zf1+NU/ZFUPcKNk/FczpuIQQgy0Qc0?=
 =?us-ascii?Q?miWf5QpmRYX9NK3OfbIpb61M1rUzI5lPmiXKAPvgpF0jvXzWDj0hcttGikkW?=
 =?us-ascii?Q?Ler2z5tZ4AH0qriy5JY9REVvCb3GKAhiaYB2Bx8HM5ycYbc4FK2u6Zh2qSIy?=
 =?us-ascii?Q?+/bpWSqdkhvYDZhDVXS754WO726f5xZ0wSKfeQTpLfN3mE/Hr10xtGiTaL66?=
 =?us-ascii?Q?cb1PTA+LsQLNuQlsHCq1UG2QIi5UNMpVzyw8oAinYUFyE4ZkbnOOo/71nWmr?=
 =?us-ascii?Q?HHvfgJX/41Z82uvtq8llaaiRi2xX+Xt4i2HUuZrChebNPxsy7h6jhDZueEdL?=
 =?us-ascii?Q?86+WmXno7yCMpCrS9fljfBrrxCchcxQbU4KQOu2nSG8ojdQv5cZaDdMd19fo?=
 =?us-ascii?Q?q4Q1aXp7t1uwgvANREi5QHvyUEDNqZoPy18UhbkI4WQUNiRlEmW1vetPz7nI?=
 =?us-ascii?Q?FCDA8CJ8Mm424vTuO5JIF1PnJc7sQZetY/isR+W+jDsaOk+VTRmnrtVEoRf/?=
 =?us-ascii?Q?kz1FM8RVZ6x9K7gpdnHKG3+rImCO4vPSsj1NQFhxQcIVvKYWUcIzwypkB2qo?=
 =?us-ascii?Q?zFHeBfBwuMGhn5oAB9lK1ZcP2GL1CG79nZraTXM91XTz2C6YueYdb1zaVNGi?=
 =?us-ascii?Q?bi/UKSyUR4lH9srfu3zNz9vY3Tk/Wfz3gYhm5OtqacFA+W8wYb6OELvZkEjy?=
 =?us-ascii?Q?GbEJgKzhTjSsqZHoVE2UYG/eoYoDq30jfL8+RIk9umfGkQiCRxm4UuGSKji1?=
 =?us-ascii?Q?f7KoTF5ivdNTMtPOF7eGrWnPlQPHo7tIOPuAst1811tx85C6bzPhuVlR/ftF?=
 =?us-ascii?Q?Inwm/UGe91pgB1Yzbx0YMM2KbZJsxIMpiH11X+97rGtHtjETfjcLmsOamoJg?=
 =?us-ascii?Q?299oQyXnme2rFJSdK7PR21Y7Uqt89feBIGaBib3wOH18ATkjpqwHTXueaFFA?=
 =?us-ascii?Q?4kUK+DbPBzBVsQ2q+1tfynm+vDnyVusfW584+F2ezQjKPiyBrhZiWvwAsS8m?=
 =?us-ascii?Q?KRXDNViLDWIPB6LXF1/bfgKcSpJKfmD3xRfOUJlmZHWYo4BlcJEV0wmtISPK?=
 =?us-ascii?Q?zloF/8vJ9/heqzi3tLcC5VVDHLHc40Qo/FoQMdtYwQMN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:13.6344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18091e96-73b9-45cc-0ad7-08de538cb568
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706
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
index 49c32ad975203..f2b95ad57d97f 100644
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

