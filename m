Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E748D38FEE
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9780910E65E;
	Wed, 14 Jan 2026 16:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zwzT5/4l";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013061.outbound.protection.outlook.com
 [40.107.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65B6510E668
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVz8GKh/UBLt9bGQ4psSVJLJX+EWETaxZgt1l3TNiraiNQF4HUC6GSOv0WXACkR9BhO991KmoKXFMPqGqI98Wj3y7lHZPq/Bsluqn24YBo8z6oerYcdekd48fX0EGWXctPUqGxn4RRndzLxXUnbXX5y69LVqo7UU+yOxJrSgrkcF9XzkspRt6aTbo0X0XZLtGS5AP9bUr96TDkEyqNYzhg5Ll2CXF8+fI27ZtdJLIQ/Qtm1c7hyFXC0F7GqXfmC4KB/3NHBMBbFvH5pfJfYuCD1FxV9u6NbPP6GrBOXJWuKF5Sfx1h8rv+sCnQbkKIjy/NbbjbHzf+bF9BdZXpoUXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyR8LIU7JznZUkthaABn+/YC3x87U3Ebob25pGycaS0=;
 b=g1rQYn8vY9sdRA87DbV48m+Biq7YBtIrzCF3jm2SjFqKbJOk+hmWL26A32GxAvA+7TAlE4P52WcNZBbb/FXYDroQe/DYVSgXdqv42IVeS2bKI72otadAwRO3nbnewhfyxuosif0NAooGTB39HMv+OgaxM4bWjJEs2ujY8Vvu02flqFUlwmBuUMZBO/4xFuhpWcq6LSk4KkgwcUzFROxQEk03EMDpQWvN55wwGyPoL+Ln+nPlQ0+S8cCLFrdy3F0aKY96iXXkB7b/Rd4T2ErP7H5NL++hj5WQmiJ/3/1bO0yM4Ok7g+bE2wVoVvdkocotRVciZotKyxQ0Co/NxCKw4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyR8LIU7JznZUkthaABn+/YC3x87U3Ebob25pGycaS0=;
 b=zwzT5/4lbx9nNhyJSqhBXpChquGZB0Sh79etrXaxtN2cZjPsn5a07NT0dJUbP4+Ds0msZfhxyNaWixYxp+uKsZRqkpDgXMfAHWfs+H+PDMfIV044jocIzeSQOcv3cKlQqscCBwFysyEJZ92hAojGBGR0PfGkWOiYCMJTYBOHwVA=
Received: from MN2PR18CA0014.namprd18.prod.outlook.com (2603:10b6:208:23c::19)
 by DS7PR12MB8273.namprd12.prod.outlook.com (2603:10b6:8:ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:48:12 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::ed) by MN2PR18CA0014.outlook.office365.com
 (2603:10b6:208:23c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 16:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:51 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:51 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 33/42] drm/amdgpu: move need_ctx_switch into amdgpu_job
Date: Wed, 14 Jan 2026 11:47:18 -0500
Message-ID: <20260114164727.15367-34-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|DS7PR12MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c35715b-4ad8-4824-d62a-08de538cb4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eURtJaBAEwiye7brghrgY8jTJzp6O8imSpwJJzf2jZTUcpYqYQwkThld6xXR?=
 =?us-ascii?Q?DvKZABWNwOtP5ele/UbxJ8xCD5ZWpqKLX/r4drbxVAeF73eZzGpBOaqwHhXW?=
 =?us-ascii?Q?H2lbj9lJer0sIS479zm41JEFlYqYiHgr96iOrpBa5HjuVn8ogiUwTYaHgA6p?=
 =?us-ascii?Q?IEkYTL2R9XI6z8fB9UZNfYMOfaS0kPFfM7chBb2rK8Cd/yDLJ/5+kGcWpqaY?=
 =?us-ascii?Q?RavKjVfp7x2j8ynkC4rl6jQ5MeDycUK3EKMBV7CeIfkeY4wqhAIWMB/edJSn?=
 =?us-ascii?Q?st+dmFkSCIniOsSX6SiWl+1WtbzZjRdtuodvAGzkd78JITT9i9NYoZf+9SgV?=
 =?us-ascii?Q?PbIPkfvtuJnHrqkHyUn6M9caUdqJbFF0E3xJ1OPF1So/DC8G8sjZNQ1pOp0t?=
 =?us-ascii?Q?OVX375uM9YKAG1IhfQMpIMMph0fFwuXWS625jMeWBDoRY7iIMV5YBDX+hvIJ?=
 =?us-ascii?Q?4zSY/73otgvilNOT8yCF1/0qnyaawATFv4Cgw/QNaxNAhykpDajK5g3MOQ9h?=
 =?us-ascii?Q?D5yy9LPokx0KlG8+qiIV2R/Hcw/LuWKKg+bDun92TDrdiXgvo4LGLoZARZp+?=
 =?us-ascii?Q?ltbWVU2IrxMrlGsiwsS+FJJStaqhzWQOtjMi4jfWcGrgB8m1XQprAkHh4oEz?=
 =?us-ascii?Q?yHyYH9DzL5eETkZW1VlmWeXbSqPRo7oi2Pc4Qv1io2iHsGOF6ZJpHY4M9nwV?=
 =?us-ascii?Q?v6OMrJLM4CfwrkzJmHVikRYiH9y5uGUs2IlYQ5jjqep44fG5XCp9Kt9N3ocA?=
 =?us-ascii?Q?MPbkLShDfvtTCO1+6lO+SE7k+GtFVsm0NZO+l/sD1KbRHOu1BlA271C/sEVR?=
 =?us-ascii?Q?o9/yciZVSq0Hz/I9i2nbBsy2/W2emPInXcvaUzRGlXPFc288ct+rN4EDfs56?=
 =?us-ascii?Q?1HpIMIK7L08+urTaT6+H/M9JlF7BEiwzmoSkhZgcP1jd2NG1iv2dqQsL6OCZ?=
 =?us-ascii?Q?kPECd51m4CGW4XjnlXHrR8vraPlH2ksPW2huH44tVA9bc3L9EbzagASo7G3B?=
 =?us-ascii?Q?ypPWctUUsd+1odAoyAznFKoG2j3NwUAcFN7tWUZTXcL5rFanJUwRYaJp0q3x?=
 =?us-ascii?Q?lQAKwtWr23aQ68CvMPcHn5Lm4BKIqkfkbxUOPCokF9bFgyNYyD+ZR0uM8eTP?=
 =?us-ascii?Q?qJ0iwqYu+xpAqHsq8MUQAWS9dyNscJVMd6U1UnL5LLOVSpqDexJaPJ6TEIYJ?=
 =?us-ascii?Q?gH/4za9LRN+JKwXKCdJK0vkhTouTMgK0Q2oF5D+C4CthA8W7Qxvep1HIJivw?=
 =?us-ascii?Q?oLxyMeEp71lLOdS92aRt5WCb1j7odZzziKjgVMFqaywR37fwAGApZznlNFCp?=
 =?us-ascii?Q?kTqG96jiKljwq7pRIk7DDyRAIF+90hacK+1TMrkMa/5BiKpT11vF00yHtT72?=
 =?us-ascii?Q?VxKP+EkMUFmrGtE1AViqwxo+7R96Zk174pG5PrVs0majRkCBJwT1D/SzJ8ty?=
 =?us-ascii?Q?RBupyiaOOSokiV4KRCRLXc9UIYeq05pZzLnfjTj96wrtzNrjNuUPtEK6W5Ql?=
 =?us-ascii?Q?5FiqgdJC6uRAO8sQPaOQO3FGpwcvdGTs+1trT4ktgjHwR4KtRRmD4daWgbBX?=
 =?us-ascii?Q?kKrVQpVsnYi398cxJxZuP+eHOQ1esnKCt1JSSSuvxMScT7GgcKe/8SxD6vwq?=
 =?us-ascii?Q?Ym8nV3UaVqIc0SyGPBHeX1kH261AerSsO+/WmFGAm8dV/sZSwLYSTLQmoG8B?=
 =?us-ascii?Q?VGyJjQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:12.6206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c35715b-4ad8-4824-d62a-08de538cb4c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8273
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 7 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h | 1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 17176e51c0398..036a9fb4e1ca3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -126,7 +126,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	struct amdgpu_ib *ib;
 	struct dma_fence *tmp = NULL;
 	struct amdgpu_fence *af;
-	bool need_ctx_switch;
 	struct amdgpu_vm *vm;
 	uint64_t fence_ctx;
 	uint32_t status = 0, alloc_size;
@@ -185,10 +184,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		return r;
 	}
 
-	need_ctx_switch = ring->current_ctx != fence_ctx;
+	job->need_ctx_switch = ring->current_ctx != fence_ctx;
 	if (ring->funcs->emit_pipeline_sync && job &&
 	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
-	     need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
+	     job->need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
 
 		job->need_pipe_sync = true;
 		job->pipe_sync_seq = ring->fence_drv.sync_seq;
@@ -227,7 +226,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 
 	amdgpu_device_flush_hdp(adev, ring);
 
-	if (need_ctx_switch)
+	if (job->need_ctx_switch)
 		status |= AMDGPU_HAVE_CTX_SWITCH;
 
 	if (ring->funcs->emit_cntxcntl) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 908239d45bd3f..21e1941ce356a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -104,6 +104,7 @@ struct amdgpu_job {
 	/* job state */
 	bool			need_pipe_sync;
 	u32			pipe_sync_seq;
+	bool			need_ctx_switch;
 
 	uint32_t		num_ibs;
 	struct amdgpu_ib	ibs[];
-- 
2.52.0

