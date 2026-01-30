Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A12BE6BF30
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 17:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A313A10EA29;
	Fri, 30 Jan 2026 17:31:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yvDf7ErR";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010017.outbound.protection.outlook.com
 [40.93.198.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C1A10EA2B
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 17:31:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJmaGVHqkWnpQFWkKQER+YfD3R3TEwjaXxyPx8U91UD3r8ScEqp01HoYpdUNtM7CIaIBB9MfYVvi1WsMbX/k1PypKFKbTv+BbmgLWTp9W17uw6ww2bglkbEZdSWJ6iuBQMyhw4wjoypRWQwDwLz0Vp1MUGm3NOmD1g0TTQPmhKbn072mHm/j3EYbEnTrUEcTjk/w/NwpRgcq1T+3/GJ1BSDgEnHdGTQ9N8xRVhRwd5I9+LmfYOOjVK3M5BySltC3bWNgw8x+ffC8kTsxNpUGVkxoGTa80YkQ/SJlvH6Ce95spNrUQl4Cis2cCYpEVQaEBp4AVXtaidIKnZd+9gW3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdlNvRoZE20A//i+I2R52lNv6WknKVhRXwjbMcv6zLI=;
 b=lbSzC7g9+j1kh9uSsJ51AmyQ7zbzdhN1W8q133PCSCfXy75cFHFRULkBlYjcKMJK67sS9wXtNi6g0aSlNZ3PFkiJQpcELXiy8r415K01wUFnj2SzhTIXN9e6xxObTRbp9NSbfC3dzXUNz9eg+Um3y7xbugq+0VbPp6HkXeoIdjvms7SAmEpFH27ux94MW+CNNS4rTqyHUG7i9N60UHL7xLC64m3X3Lrg3dJ0MXJ3hp+Qg+vugG4WXDBtWqorkPa7d9Hxk2siV0xKZbYbTR95X+WRIiWv0urfujhwjyH99MhHy6LNMPevagtL5pnewlQEtgV5a/w9ATHAnzx8FQlw1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdlNvRoZE20A//i+I2R52lNv6WknKVhRXwjbMcv6zLI=;
 b=yvDf7ErR/L7LNLDoLmx2pwLmPIljhn92Sb+uA0OdtyTXKMvceufp1eK6W5PTweGkXBHBj3Q5JgC/fKlBgAWQkAa7F+z2mVAtxVAfdUnfccMdBA9g18yh6AoD6BpSpNqp+STXJWrLUhno5GuO6mglUJ0t8ZnwyphbyC68RwBm5FQ=
Received: from BY3PR05CA0050.namprd05.prod.outlook.com (2603:10b6:a03:39b::25)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 17:30:57 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::36) by BY3PR05CA0050.outlook.office365.com
 (2603:10b6:a03:39b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.5 via Frontend Transport; Fri,
 30 Jan 2026 17:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 17:30:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 11:30:55 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 30 Jan 2026 09:30:55 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/12] drm/amdgpu: re-add the bad job to the pending list for
 ring resets
Date: Fri, 30 Jan 2026 12:30:31 -0500
Message-ID: <20260130173042.15008-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130173042.15008-1-alexander.deucher@amd.com>
References: <20260130173042.15008-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2c51dd-974c-425e-911d-08de602553cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I7IpNfdAm5SuvMZPVKFHgpxtpVv6G71JuWbZZqDuINycIZqefoQGtQRq+HzB?=
 =?us-ascii?Q?u9i0Na3cFnLnTIUJ53WoT5WF2roqaYr3szsJDtXVGuzPHuh5hoEG6K53yiUo?=
 =?us-ascii?Q?tEiceIxjc55090MTM62VhU8Ydygjxw1TTCLWylwtgwpU/NoyF/SRoDekNzIS?=
 =?us-ascii?Q?7p8PNG+/yoC7FHYXjSvr6896bsVVvgkqyQ1CorZWYLWbU+1ZdVCk4iEJE4DE?=
 =?us-ascii?Q?mr0l0G/F/DeOklD/g/LFkne+ox8eUBpJcuCAqPLxKu9CdKlJrLLrWjSQXbtd?=
 =?us-ascii?Q?PQ+DhiWVCWnfX9rEsuEVBBNK13i7atJMgY0RuV5PRwGWFzlQnSsvLE1SF1qM?=
 =?us-ascii?Q?5+TFMRF2N4QadS2xvMJo+ueme9KXCAhh4hv8F2xUC+fCgwSp4/3yShCdSidj?=
 =?us-ascii?Q?DCs9gICG7feWyQHicboODNgJiUXQwekrzWdkxAMFkkBc8rUKXAj7GJgrp3ug?=
 =?us-ascii?Q?nXOgtmRpgLo7u2Ydavc9NskV6asUybW3dqQBPwur0X3w7HRQe9r7lOwgVyD/?=
 =?us-ascii?Q?R/oxoaRPuwnzztfFGjgD9Xn2OKkWnKIR4N//dejlo63Lu8IRluImkHurmYGb?=
 =?us-ascii?Q?b03/8cSSjbgpFKbGXbLLMG/MQ0cD1asFGzfCNX4GqOQj06ZkSa6UFEBwnd7o?=
 =?us-ascii?Q?1luo+3izxT3C3aRHrYDRR/k8VMLl45lNjayO/SrmtIyOGJKXafDtbvzeZLcI?=
 =?us-ascii?Q?Ht8Bg98Cql6zacr8nECLseRYyqGWYHTMbz7rcVHx2mx/zGCCBI3zrL2c2GzE?=
 =?us-ascii?Q?Jm/kq6Fd4nTfYsKp3Z4QTGErWZmZyW/fuwh3OIZ0v1Em7MLWteMM9ESUgOD+?=
 =?us-ascii?Q?6Wb8Ujg2XJKnP6kPRCC8GcXIER5MWMi92HvG229R2pNKxnvTS4np8P17tdNU?=
 =?us-ascii?Q?BxjMWPeUjH/0EgpJ4VpTlrv3Rco90GNC7RnQkLaUZxhm+XJbkc0tKGRayY0X?=
 =?us-ascii?Q?8aMnb3/SU2H5R1yPaS0oPzCc41WC4Uu6aN832gR/qSrQkRNjKbX5fsHlL/RX?=
 =?us-ascii?Q?1KYalWZNGlQOc6vWMG7a8xsEPzy6c1EjgOcRTgi2gejj7qLjZqqbsd4Ut5uN?=
 =?us-ascii?Q?xTLnNEfZ17vMJAUZss51GosgPCIV01E3Ko7GRYlknqDCEEs3pTHTDqVggz8G?=
 =?us-ascii?Q?4lE6b9cvHQQ7KgtvQvzaCYzCsLKYJDXFEufvmAjlYXnk5czYgwC53m20KTg7?=
 =?us-ascii?Q?wyKE3UkGIMc+w+aErUmAhyBIa/HOQXeLPZVV31k6x+d9Ect/ZglkFBcjKxp5?=
 =?us-ascii?Q?hK8ti5SpceIYjfN3CsOwVVfmX+gRBzeol8jhUFGuB104EXH0X1j8cpsjpDi7?=
 =?us-ascii?Q?7p+XmuoBmf68sFmAI1qagpafa73uQVO9NBRwulbs7zBJGlkKRizsM73nK440?=
 =?us-ascii?Q?a34AtYk0tdOHfdNY3dUPL1fUDHPI+nOFFjd7WAPo9tNRkU9LHJtuY+X7IAS5?=
 =?us-ascii?Q?sLODBT2VAy1F3OlneeNOVZEcHoTvf6aCYiCAoNunHH7XPFKXhyygsvBqLisi?=
 =?us-ascii?Q?/hPF0R1m2XQ8vCtmYsbtnDr76FWxb6GvQa4OGDfi+hemikJ4yuCxXJKz6qW9?=
 =?us-ascii?Q?UsL/Y9WZFe72nujP3W650AFHFfZ9Wf5XasldcWEjFBlsjf28rhxgS/YUQSjR?=
 =?us-ascii?Q?7Y2dwboAUEemIcQPT996pjw2UGW7fdbw0MD42JWjLAEzUK1p+GJkKq++9s0z?=
 =?us-ascii?Q?5GZlfA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ledX4gpg4w4AfcYS+Juywe/JOQvi9lRnpBMnGu+9x1sb/TBsXR2ujmGIlZVPUyqkzY7JZaOLR2nOdJaxgfwf08k53O0UdkweEYQiddUviqAFFIf+iov1Tva1/+5lMhBhaUlyjIE7tS6PxNERejA0P9zM8+y1SvnnV+H8QU4R40CP4cdWJBFpyyMSROIuoPoU5A2IN6Qdr1bfxwsxOZLRDERlpMBjERjlh0xqCWQsSZqx/WdIhMcuQFuTrBZjv0QyuR6T8qWVb3J2OxawQdDRMB2YwWJ4eVA2mwwMC+Kw6ZKw9aKHCAIB9JLbkEsbJjPtD9Vdllo8i8K2lA/bA+GurWHB+UqSB4xivdQu8tZpGLMej1gCOEWdAYpmm0orGhZdQlMe0LTwwEVSm/kC4cvV+PzqX5IMfQdeXLsBvkOSFyYCGD4WunK1SPSxOBgR22uH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:30:56.8327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2c51dd-974c-425e-911d-08de602553cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450
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

Returning DRM_GPU_SCHED_STAT_NO_HANG causes the scheduler
to add the bad job back the pending list.  We've already
set the errors on the fence and killed the bad job at this point
so it's the correct behavior.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 ----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index aaf5477fcd7ac..2c82d9e8c0be1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -92,6 +92,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct drm_wedge_task_info *info = NULL;
 	struct amdgpu_task_info *ti = NULL;
 	struct amdgpu_device *adev = ring->adev;
+	enum drm_gpu_sched_stat status = DRM_GPU_SCHED_STAT_RESET;
 	int idx, r;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
@@ -135,13 +136,19 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	    ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
+		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
+		drm_sched_wqueue_stop(&ring->sched);
 		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
 		if (!r) {
+			/* Start the scheduler again */
+			drm_sched_wqueue_start(&ring->sched);
 			atomic_inc(&ring->adev->gpu_reset_counter);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
 				ring->sched.name);
 			drm_dev_wedged_event(adev_to_drm(adev),
 					     DRM_WEDGE_RECOVERY_NONE, info);
+			/* This is needed to add the job back to the pending list */
+			status = DRM_GPU_SCHED_STAT_NO_HANG;
 			goto exit;
 		}
 		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
@@ -177,7 +184,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 exit:
 	amdgpu_vm_put_task_info(ti);
 	drm_dev_exit(idx);
-	return DRM_GPU_SCHED_STAT_RESET;
+	return status;
 }
 
 int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index b82357c657237..129ad51386535 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -868,8 +868,6 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 				    struct amdgpu_fence *guilty_fence)
 {
-	/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
-	drm_sched_wqueue_stop(&ring->sched);
 	/* back up the non-guilty commands */
 	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
 }
@@ -895,8 +893,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 			amdgpu_ring_write(ring, ring->ring_backup[i]);
 		amdgpu_ring_commit(ring);
 	}
-	/* Start the scheduler again */
-	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
-- 
2.52.0

