Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0CBCCF9E5
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 22:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D8DC10E191;
	Mon, 27 Oct 2025 22:03:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YDjXMnak";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013020.outbound.protection.outlook.com
 [40.93.196.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6129510E55D
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 22:03:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6RZYI2kRgA+U3ZSZqgpXNrm1MmDrRFoz1rNUpx8oiJapw4DUtNjdi7P8kaTT9Yv7QhzKL7tzr9zBwvpOiOZcu6MO5N1YR9hAgBU1QOJaXAIkMsu1j1ddsI8F72tVgAOiJwxpBNa3EnD5lFbx/zcaEuTrS7uE1t+fZ2m3YHxkme4QH+Nzzpt4zZNNPqhOxSnTQAV60MhJK1/DIee1HprSQcAaoFY5BVgl//mCNrjPZ9DrI6b7dZzFhcczHLzL6moIpXMblovb6coiKpQvZsXouqDPJ4PwnCirJBH9CCHiNwAqKH1vKA3zh8Wi5pcX54T67LtIC3V1spu5remiozgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPIH9PQU8LNeAuCTWASSIHXVfZXQ2NoORn4+XNTpmTc=;
 b=JnRg9mE8wlFdeFzFBeVJdaWZFm/kPYaLU668wCAQkd3Giwhbmt9+9AOliLSSRuaKo30zqfCXsQc3wtHGJJDT2r1LLD0Y64zp7shwlf2EwVFdM2fPrYPAYLBoZExmm6vTVARcwya89mttbfGpI4L3VDC16Q5yvvFqO5WBsZsB+/WcCTtHgxOHxW1lXh33buY+5PTU70nOLJGQP5PdSXwVQILlhSGmo+dboMf2J3ab9igRMTDTJYaNH969bBAH5w4//ihCXZefSsS3To+BJwaQXJK8ieAExm0EiU0rmqYCG3e8xfH1d4Q9KYtQyLmyxbohtZmfrr9KT5xIJJ+b3x9Lww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPIH9PQU8LNeAuCTWASSIHXVfZXQ2NoORn4+XNTpmTc=;
 b=YDjXMnakk+T7GoRr1IfrPsZ9jDXtv/xdoyzul3ZL7JJsPXpc2f9MHthjXFE145iBMWG0lbwM8Z5CXqWA17dTWFUAPa9pm7PW/HlQN1rH0H7rkC1BP5Xo6ycBREE/cQDbNXoqRiDAhe0nSUZ/iDOeuG0SBLJgOnG08zu+1mEr/98=
Received: from BY5PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:1d0::20)
 by BN7PPFB3F5C406F.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 22:03:15 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::1) by BY5PR04CA0010.outlook.office365.com
 (2603:10b6:a03:1d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Mon,
 27 Oct 2025 22:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 22:03:14 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Oct
 2025 15:03:13 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix possible fence leaks from job structure
Date: Mon, 27 Oct 2025 18:02:55 -0400
Message-ID: <20251027220255.507105-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|BN7PPFB3F5C406F:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d187885-eaad-49af-1aae-08de15a4a093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wvnocyh71KrBxeuia9d674SDMD8CT2Qv+eIM6dEYIjVzipHSrO5f5awZfd0d?=
 =?us-ascii?Q?ee2+CP7XyBADLPZ35ouuVMDGgRQOuhhuZeCCc7ikjeDSTkoa1LJXXPXHqqO0?=
 =?us-ascii?Q?Rz/4DDIkPZIHq23GMsVDltCaLn+mWZmB/dX8SbT+pByKvabYy63u1lYyt8mR?=
 =?us-ascii?Q?SizVBEc3B/FCj2jrTdPkgSXk9wdFhn+CplDjZ7RYIeHPFMOdIZxfXoEf1G/x?=
 =?us-ascii?Q?W5gQ61Yq2rxXCKsMReC7iEp0+PcHTlnzWc0hIjoH4tWdrF0s2ISMkk4JY1L5?=
 =?us-ascii?Q?zOhL4jauWn3dD9JG+tFSw7LTx/goPDemmlp+5V3lXs7PnrEB5MXxmLfwjuYU?=
 =?us-ascii?Q?8JxH0SS4wfMFMdFLfa94hZKk219zp16qI4EUYTn9X+LbtfL6T9n3HYVA9fdk?=
 =?us-ascii?Q?yD/9g9adgKMNwfTleixy8b91BjFrOB1w84VVWmS/Mwplv08/FZMBNiHTiNPk?=
 =?us-ascii?Q?Oy7Y4jP/wQQKzfDFLv2/p6LwgeFRLKOOUXD4bHmfCqb2YbHzJb8vYSkeNGaU?=
 =?us-ascii?Q?9p5xNp/11P9U2rOD+IH9QNBKanN2xEcQ7X0XYJ+hw4e0dSgwsObvKUX0V+9G?=
 =?us-ascii?Q?1ngM/nrD3IuyfPnvDNBloa1XLEN9yemTeTIc2bQ/Ae6tRmn7Sb339P7H+jEw?=
 =?us-ascii?Q?wpWJKg9wfWlYDiXmTaT4vx4zeZqb1506iGrZN6Xa+8vwMeKbok4YgCigDzZb?=
 =?us-ascii?Q?lTqWto5hjRP2BdFSEDrI838uwso9DacFIj+D69s2wqUz0UIb90SMmEkx+Fke?=
 =?us-ascii?Q?iuS6qiOQxeW6wQzaAAXW6bqE4w9jKZvhOV/7/Fp2aerMVzwmZFeUUg/ZvIfm?=
 =?us-ascii?Q?+3FXNmmWvqwYfzsIELHsYa+utX4Q8Di91Pu3ay3UJPdEGHR1MJFPiEUqzPvG?=
 =?us-ascii?Q?uB5QlxFdlxVHQ8NqU0lGI3TlFVv6aue6xjuIwivH4kXA+HhiadPvp5zNDEUI?=
 =?us-ascii?Q?ZKilZn7N6ofTc+DL/Ric+7l99Az9nhPwyXGihVNR2wo+qIgO8+LfXoEIYtjj?=
 =?us-ascii?Q?KX/h3iMa53SI5pY29qHaR+ZN+/q/eIV5sPBA/4s67Kp7P2KwJqvIrcj7uKIv?=
 =?us-ascii?Q?ZWgXPJkHCT+HpHkpP1/TmquAUHACSgXj/bq1fraR0PJmryDCBS1Wlx9vfAKD?=
 =?us-ascii?Q?3ajd//9iwAJDMVnqhyHDk56eZuQJ8Ah95t03+MjD3fRpN7WbLiqz04IRQmDI?=
 =?us-ascii?Q?Th+GNPIbpUfF5OtKZKJG2kFQebt+e5hCCGSZq6s/OAhK10I1M6FDat9cAIPH?=
 =?us-ascii?Q?EFlRUQA+syN1IzdAR7GpGaoLV8p7vrp2ljlSZFBzfC2oxZkbEYnZArVVYsNJ?=
 =?us-ascii?Q?PuLfPZ9QcwknBsJIrwzCMpFjTFKGPiZ3cadYGtmx3YcjJR77MtPWDeKXQvd1?=
 =?us-ascii?Q?LBiOZcuEyMIC+isdFbLBdWskgbp8IsrYKoIjQ2HNQgmF/rxUricK7BIxDqjr?=
 =?us-ascii?Q?INLgDHlBffPJqOc10jeswIDhamJRMhySbGuGHogPYHFvmCH9D7T7xeAB+vhT?=
 =?us-ascii?Q?4rJTJNgswyuNnbvUyn9zfMSNBCC/LusmlMgwx+QZpm89CFtcvR7aNYEBw/FI?=
 =?us-ascii?Q?HZ+gmgvCZzR1GMrm9yg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 22:03:14.4602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d187885-eaad-49af-1aae-08de15a4a093
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFB3F5C406F
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
we free the job.

v2: take a reference to the fences if we emit them

Fixes: db36632ea51e ("drm/amdgpu: clean up and unify hw fence handling")
Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 39229ece83f83..0596114377600 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -302,6 +302,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		return r;
 	}
 	*f = &af->base;
+	/* get a ref for the job */
+	dma_fence_get(*f);
 
 	if (ring->funcs->insert_end)
 		ring->funcs->insert_end(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 55c7e104d5ca0..dc970f5fe601b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -295,6 +295,15 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 
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
 
@@ -324,6 +333,15 @@ void amdgpu_job_free(struct amdgpu_job *job)
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
index db66b4232de02..f8c67840f446f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -845,6 +845,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		if (r)
 			return r;
 		fence = &job->hw_vm_fence->base;
+		/* get a ref for the job */
+		dma_fence_get(fence);
 	}
 
 	if (vm_flush_needed) {
-- 
2.51.0

