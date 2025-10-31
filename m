Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346E3CCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 17:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF41710EBFF;
	Fri, 31 Oct 2025 17:43:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WR8km/yh";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9C1B10EBFF
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 17:43:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzqfMEIW4qLeTzhEfMvaoZ2ykqYoAAkVwBSX3DrP34wmb+gxtql6faouQyhMy3Zw8XnJ8tNDdkOn3IJ1c44J27UK644GTDORYs0SJw9jM7KqK6Dzur94uAY3CWcIXriw+4E/A23+yYz4qeFqZeeF/Z1qQfptXYZgfJoQOcBQHwkl277Q8RWbcRI1gKhZoDTT1Q7V2522x/g33jWS58QHRyWGlG4WkbfHLsZ+WgYOIlPCuRiHIIoCBNFfS18u+E2ZYnwTh/daKy/U914RsBQemFglFdPISjxvBEZ9obPV7boyhlCTbGPtH3l8KLAmxRBW3qmcrIt3Dl0aK7erBew1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdiZFE+83ahJrXSC7EvJGquN8IagVebBtlLJmfrc9EY=;
 b=qAxywoPxYwRR9InwWmn9OodPWctXfVvsj+5bEMui2ZcYRZHMetiexKxxdSnaBh3ie+W7Wv0qmEbycWNK7GqmTHh07NEnSPNNCAVTdt5fufhrHRPl9pNsMPAwVoSgASTf/YuNoLJ9/wrsZwgFBqM+FOgdptwsmOfbOqhnMl3zssB6krcdKlI3ivPgLvv8vGIoV1UzogSTc9PadOSk7kZ3nBws1+O+RD/DbOSv/uZ5mVVcOSjBAP3WvXc+AJO6HQXHgNCcFFK22M8F7JRh0onN7C9PVT/syruwCaU3Jvqwd07QKgTc48plWa2zMacIUTQ2Qp/1dwckShEW7Ln5O65UdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdiZFE+83ahJrXSC7EvJGquN8IagVebBtlLJmfrc9EY=;
 b=WR8km/yhHQ4MNv5ia97ie/4Xj4DeOjZFGunN9Fdxi2EmX92FlsqU+0szI6Wrx/dXCbx6uiSMSb/CDOphxsqDuSysrUBFyOyQpw8Y6EZ4htgFKlJBTAldAazAazInssfIebisd6bnp23IkiBtQI9sf7lrnJfH5rYVhrggNTKHTHk=
Received: from BN1PR14CA0024.namprd14.prod.outlook.com (2603:10b6:408:e3::29)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 17:43:23 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::4b) by BN1PR14CA0024.outlook.office365.com
 (2603:10b6:408:e3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 17:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Fri, 31 Oct 2025 17:43:22 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 31 Oct
 2025 10:43:22 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix possible fence leaks from job structure
Date: Fri, 31 Oct 2025 13:43:08 -0400
Message-ID: <20251031174308.5234-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ecb19a-9a43-4801-f6e2-08de18a4fcc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SXDMdgRiXwV/OxqbZZ3iWbZxZTfVs422umfaUbm1monHl9rDTZZBoZxfeKSZ?=
 =?us-ascii?Q?v2TgFmJ3l+bCKbf7b1RQN794yuL4jh4ZYOUvgithw5m96hnqig7mYLmv2rrv?=
 =?us-ascii?Q?XweU2oViI7i3mYZdTe7PZNsmawbWasWaCpTr/4lwGtBiVoYg45Zo8u6P3ZGS?=
 =?us-ascii?Q?U8TDZBFsxGzMV5iPf9JqXLiQhmhYfYOvWui3Qui9fbYX3exputAU0oECX/Gn?=
 =?us-ascii?Q?yOKBj7b8M/3JSxm8J0M8Sxhx07QC6xbMCOSPiL5yajBhH35wSCHT7R18wioM?=
 =?us-ascii?Q?FUvuHUl6xIcsKWiOQoqn60Ay61esUPS7p/Gw841JRd7o5ANFZ7BCHVoe/Kkn?=
 =?us-ascii?Q?weDnNveJ6OnAfB5piFEKmjVjEmBtmpdqdLcEchysji7poBifEu7Fzu02RGEM?=
 =?us-ascii?Q?+W9N3kFlpP6hRi98UXBzN2fNbvb0UZTmLnE7ZD0zV6yNkHyVsf3HmhdIdOi+?=
 =?us-ascii?Q?SdTlwT/0ByxfReDBXBPr3m42GumiwjAh1V5RlOJeRRse7AFaCY24dCB5t0gW?=
 =?us-ascii?Q?vFGvJGR/s4Mabh/VQi2d4T0sKTko43HqM15IoOD/CaetxpMzqDPCYyUsHq13?=
 =?us-ascii?Q?OaI+2bA1hiOIv6zvCxBW+Dt9sD7BP4pcvgbUC6JlWtEUMOPS6p2Q5MZKGqHZ?=
 =?us-ascii?Q?qmNZSK2IrMTti+30VELmldYSBrvg8MCRVmTL7fiAuyLVRAqGjq2quTG+H2Lt?=
 =?us-ascii?Q?efxKIHAJpAlYuAJe+yDZrnI8zK4euU2zQJU6m5SHZ9TZb6Us8H6S14b3fFG4?=
 =?us-ascii?Q?/MbXtF41auwCsf4kA+4+KcHrT8hr5LwX5khz8xN9kNL33oPb3WqaiJcNFrjG?=
 =?us-ascii?Q?QkqWb9dx3cqimU/gUkBz4E23gvaxHTm6yQNpsi6xcE3gPCSjEPjhIamX86Ty?=
 =?us-ascii?Q?Zmjaa89x8OEZebDl/mzaYUOUgC9RQ0ihWz1GOpb3LJ+rkMPx+pO3gPRaXe4c?=
 =?us-ascii?Q?JvemQXqDhgCwD8kMPNqorYAyxBja1vlYvnNS6fpCMsVtaXSumYSO857dVWRh?=
 =?us-ascii?Q?SLGk+jQleCVmHarbPiMbuggcubHRXrL6uXpicrG04fJybCa/5l8NHGnIL+GV?=
 =?us-ascii?Q?Gb0RzIhU9ptfOa10kR6DcOoC+kIUsD1/i857PODXXZwOpWD/0l1vs81NOdcX?=
 =?us-ascii?Q?FIpuGmbSrsNWtdOYmdR7bbAaU9QX9NRsDrTrobF8KAzjEWU+rgCemGiGncgU?=
 =?us-ascii?Q?iRkZ/tWPp+r/4qVHGtDboeRXkyrxbKKxLEAHNJKNZYFcPKo8T7e0mFLr2AnK?=
 =?us-ascii?Q?FsCJ2Xy7KuEf1bRQWkN4D6MHyIyICFdm1e1DQAP4M0zIMHY+Wk24l1DFnEgP?=
 =?us-ascii?Q?eA0EldCCWlL6fEevCfdf+7bPn3QirZnAIcAAvo6E9G7jH7JWyDKm8OBdC+Pd?=
 =?us-ascii?Q?kPxXD/OknC8mtWPddctjhun1FScKm6hDSX7Cspqk4117uBI+AsZUVIRcw65+?=
 =?us-ascii?Q?iXI5oSX3LNPaXZ1KWo+GcQCqnoCIfM4hEKwtjz1sbmarJ1h+bBfybB1AUzFM?=
 =?us-ascii?Q?/WoRTOfwF7qRzDQDtVw7QOdDx9qh4nQRmf8BkihV0GamIGT/5gLVlqdsy3/Z?=
 =?us-ascii?Q?sZg6sobjKmvfgxuTsak=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 17:43:22.7102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ecb19a-9a43-4801-f6e2-08de18a4fcc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203
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

If we don't end up initializing the fences, free them when
we free the job.  We can't set the hw_fence to NULL after
emitting it because we need it in the cleanup path for the
submit direct case.

v2: take a reference to the fences if we emit them
v3: handle non-job fence in error paths

Fixes: db36632ea51e ("drm/amdgpu: clean up and unify hw fence handling")
Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 19 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  2 ++
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 39229ece83f83..586a58facca10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -176,18 +176,21 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 
 	if (!ring->sched.ready) {
 		dev_err(adev->dev, "couldn't schedule ib on ring <%s>\n", ring->name);
-		return -EINVAL;
+		r = -EINVAL;
+		goto free_fence;
 	}
 
 	if (vm && !job->vmid) {
 		dev_err(adev->dev, "VM IB without ID\n");
-		return -EINVAL;
+		r = -EINVAL;
+		goto free_fence;
 	}
 
 	if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
 	    (!ring->funcs->secure_submission_supported)) {
 		dev_err(adev->dev, "secure submissions not supported on ring <%s>\n", ring->name);
-		return -EINVAL;
+		r = -EINVAL;
+		goto free_fence;
 	}
 
 	alloc_size = ring->funcs->emit_frame_size + num_ibs *
@@ -196,7 +199,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	r = amdgpu_ring_alloc(ring, alloc_size);
 	if (r) {
 		dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
-		return r;
+		goto free_fence;
 	}
 
 	need_ctx_switch = ring->current_ctx != fence_ctx;
@@ -302,6 +305,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		return r;
 	}
 	*f = &af->base;
+	/* get a ref for the job */
+	if (job)
+		dma_fence_get(*f);
 
 	if (ring->funcs->insert_end)
 		ring->funcs->insert_end(ring);
@@ -328,6 +334,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	amdgpu_ring_commit(ring);
 
 	return 0;
+
+free_fence:
+	if (!job)
+		kfree(af);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index fd6aade7ee9e3..efa3281145f6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -293,6 +293,15 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 
 	amdgpu_sync_free(&job->explicit_sync);
 
+	if (job->hw_fence->base.ops)
+		dma_fence_put(&job->hw_fence->base);
+	else
+		kfree(job->hw_fence);
+	if (job->hw_vm_fence->base.ops)
+		dma_fence_put(&job->hw_vm_fence->base);
+	else
+		kfree(job->hw_vm_fence);
+
 	kfree(job);
 }
 
@@ -322,6 +331,15 @@ void amdgpu_job_free(struct amdgpu_job *job)
 	if (job->gang_submit != &job->base.s_fence->scheduled)
 		dma_fence_put(job->gang_submit);
 
+	if (job->hw_fence->base.ops)
+		dma_fence_put(&job->hw_fence->base);
+	else
+		kfree(job->hw_fence);
+	if (job->hw_vm_fence->base.ops)
+		dma_fence_put(&job->hw_vm_fence->base);
+	else
+		kfree(job->hw_vm_fence);
+
 	kfree(job);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c3dfb949a9b87..82e897cd5feac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -849,6 +849,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		if (r)
 			return r;
 		fence = &job->hw_vm_fence->base;
+		/* get a ref for the job */
+		dma_fence_get(fence);
 	}
 
 	if (vm_flush_needed) {
-- 
2.51.1

