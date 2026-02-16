Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0674E83837
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 21:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35B8110E3EA;
	Mon, 16 Feb 2026 21:14:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PhE7LMuu";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012053.outbound.protection.outlook.com
 [40.107.200.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2153E10E0E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 21:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yw7JOkPd6/Nos+WZJJrh3OnAwyETggZu3kZV+teqvFkdyx7x+VHVdbWCG/vgYXY/sLvZ6x6J2vrfPQfKlQVfjbrQnfxxG9XEUjQXKYu6FBn2fKDFM6Heg3jNESh64zdMB8ZIiayGmQZtSE+kOxSJWzsC9LXSqv7W4A6wLuzcv2wKWYpIRTvlrTOSexVDcfanPyfGrK7y3FYRRE4R3JrZet3KVs0uFLFeMr8J9oEWsXXi3wg/wz+12q2iJVnO/WUZVtDk3r9jy0S49TFxXSTDjbp8kJ/KQyvUSvcdaFQV+fKy0vQyF0yMd0y9iPGq0jGVhMI2dz9XyghacA3nI5ex7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1/u97oH/zWd+BOicTxV5sQTt67q6mQi/T6CbySqyYQ=;
 b=drGK3HWLVhta8W8F5iTM0ND6Z64eb7kxBY3k3quXt05UKmiRPgOuKR6nS/7Yl+2MJ4IPVmuSwNuVK9d+NHrozRJzB9RMpVFNAudWspt4ru92n0UHGE2Zp5T67QFfRp5F2Tfkr4AENCHsPQobnswAUyIwloqaDbwYhveKjrNGZKvYXM4Gz8AnbOt93BBwSYKgQp/UmX5vlpKu+hMlCoaxrN9DsrerDzgoC2zAaFsgpmUA5AuxeyM6BrjOigYTG9Ja2e473ls42r2ces+nEHbRi3pzyorlC7X7649EduORPASLoODbqQ4OjDV9nDOT+Y66BJiiTE6+u02/Oxy6ERYGZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1/u97oH/zWd+BOicTxV5sQTt67q6mQi/T6CbySqyYQ=;
 b=PhE7LMuuls0tc3ZxK3ALdxDQZn5NEcTMmW6wKxMs7BoEfQmPxwhExgDN2pAB8HYqTydYO0X45osp5ZRL6Z55+V1MyRps5UNUS51fGHpyATO7udRTDNG4yxVp+iAZ6ugs1CthVkCoZEySBfXJ2zuaYfORTe/BTjLpKZrHGVjX8TU=
Received: from SJ0PR03CA0179.namprd03.prod.outlook.com (2603:10b6:a03:338::34)
 by SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 21:13:52 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::ea) by SJ0PR03CA0179.outlook.office365.com
 (2603:10b6:a03:338::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 21:13:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 21:13:52 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 15:13:51 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Feb 2026 15:13:50 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 4/8] drm/amdgpu: require a job to schedule an IB
Date: Mon, 16 Feb 2026 16:13:36 -0500
Message-ID: <20260216211340.16364-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216211340.16364-1-alexander.deucher@amd.com>
References: <20260216211340.16364-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|SJ1PR12MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dbfba89-218b-47b4-0769-08de6da0495d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/PmFI5msJ57ZHle/9hoUndCVOEkuZ6bNjfkS5ld8FBs0Wij3cJcEpgotH7us?=
 =?us-ascii?Q?nQ2L4GcaBJjb6w/TxtMa+TCLE/6rH9KkRR7CiCOjL8cjbPb2mH1q9CLoZAMf?=
 =?us-ascii?Q?P2PTLMBm2Dfpma2q5F54fjhkUNEpiV6ICMxYInEdJET0NZQFsOkAX9jjBIbc?=
 =?us-ascii?Q?LGyKx4I9zgjhNxTUqJeBOtmg4BF/v9aWnslCGiR/IuHOeEPAd4YE2bGBtZ8Z?=
 =?us-ascii?Q?AQuRE05mmpNXVwYWkk1VusqV30wZu7xPjPTTLGmqJUalfYlvDkhjXWf2uj9s?=
 =?us-ascii?Q?YnlC2svxj8PficeGvCQcaM9cU8l66mmVQ0VK46mZ8gmInWXPK70U44QOy2hC?=
 =?us-ascii?Q?981m4UEPfvIDtpjjt5XvPFIooOmqTWjUIwGFg9eHvsyZ0hpFuBeiXt4lKBUi?=
 =?us-ascii?Q?W4+9e6+EPVY/aT/FcLCWWNIdfq3SAtwpLzLi1CA82brmXB+azrVsYbZJVzBn?=
 =?us-ascii?Q?wM1TJcZZQqmcTVHxnhhsLahd068dEvdkjY9bwF3AGmxgj0cWs1I3cPf//rJU?=
 =?us-ascii?Q?h+NyoR/k+ar3CC3bQ5aC9IYwHGXJOOYZo/BzK32ZvroFxxDVaQ1PL01y/B3W?=
 =?us-ascii?Q?SFH34dZg6WI20uT7+0wNnxQ+Gw06fYSoAf9U9+vl3zeNiOfeyxpkAJhK45kY?=
 =?us-ascii?Q?qkE+/buMAY4lDSZszs2zgHqrPPUJDHPo0mXQG8GGc1l78wp+u1TjIIiLiHay?=
 =?us-ascii?Q?vUVxMey75mwuX1M7HD/xmBUlMl5yyUQ66YCEqXJlJpEk71cNBA6VDuOMlfx3?=
 =?us-ascii?Q?tjAa4gLiOK4dNt8ZwLUnbY3hMXQ+NMv7sv8OOJa8Q0Hyxp62dKc5Yja70Aud?=
 =?us-ascii?Q?7rto+VOYhBpKDLFOsVnQStz//3JoBvWLyWqVHfb2pbQqzod/0g75o3JS1TiU?=
 =?us-ascii?Q?DAUB0fwWTz6Zxz5+v7S6qMkh/h16pYIAu9oMLOpMsK25JQTi2mZXKxyuRHNI?=
 =?us-ascii?Q?EI5b3RedqXy+s/A/iRFbtUCCg/934V24uVSbij63SN1Wd1JXdnr7RHjC8VqR?=
 =?us-ascii?Q?T7u3EJrE4hp3+LPcbzVQNIWGdMuaQ8CqZlj3okB0I0QyqxvyaoB9HO6wdvMk?=
 =?us-ascii?Q?4VyclRREeZCZQArATgTuVQ9pQIAKNZgNrUOhIYTvAbdbzFgmOIQoVsgE+86C?=
 =?us-ascii?Q?QaLREhRK2U9VbiBsFjzkbHgVBPZ8h24DHO2DJkRJQlS+EqRDjRSUGfjDDJIf?=
 =?us-ascii?Q?LV8B7242nvWNk2ePSkl9r5+UkD2iOntLOIYI/AhmTYDlY2WV/D5xB88UZDlN?=
 =?us-ascii?Q?hbtxxuGWltVKetbJhtAiazkYTNR0UFRzCF3kGQvyWH4p0kXCilrySg3hoYzU?=
 =?us-ascii?Q?UpKYOPuPkPs2pL8KXE8CcdQJCvta3dEQsj/f/ZLS9hZ2AZF1HCXbv7rXHn5R?=
 =?us-ascii?Q?r92oJqZfbAdi94I4VOI47a5UQa0uw7exWoyDlhKRELbOWTCe29QBkVoN+dFt?=
 =?us-ascii?Q?0fiB7Lw88GOqaSapIoVvRjefvanqIju5XyXFm244erSoY0as81oeHAn0pEyr?=
 =?us-ascii?Q?6nVVOz4YjBrcXagRP78ubpJsDcotb7gdegGUVdK7227aTLtmVCkPH74MgsnI?=
 =?us-ascii?Q?hQZUnh4dmFR7jSeXYwHyZIuQ6KzDsDSVKHfV5ymbySBDcnJLor/lNMSzkFSi?=
 =?us-ascii?Q?QinF8L4D2Fq44F8CzkVR0RvhpWtGyCbSL9zL8jxoRouRrIZQnmw9dpiLqT5y?=
 =?us-ascii?Q?xZEsWQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B9ZmQ1L4I9UgVjYLTRu3CKOiKO2Kr8IM4MT5VY08XavMeSrAPGSsxglEnWEcc4xkMMNV8uwV10BqPWQStwnVlkDzw1/84YT57oYeIIeLp4laz0mA3X7yue+P0uOxh1YtiZJacuJwvlk0QwLYhqZBOLPfxy8hwymCNEjJV6nuZfg4Gi1Pe3YIDQH1KioKjtLeYTgreB8NCQO890NXktj+zuE+YZjsqkUlSc7XD5LiSop+ef0JnHd6/ftEuxFcam7jaYVdXZdlEqJZPdop6OltkjJ63VHyJsQrxNW0sRtOONBvq8gKpDRhhhjNvGu8ry9MdssDv5FxnwxH1aNdBl5RQtYS7YpHTCmmXTw+b/XsyvWtKpAd6GzyZ592gGw3hWmujymEVIGkLt+KQUtVXXMAK+eYq5BJViDsWu7NrPzUWOkIeGYg8Jp6BWWtfjC9G+Ue
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 21:13:52.4863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbfba89-218b-47b4-0769-08de6da0495d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361
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

Remove the old direct submit path.  This simplifies
the code.

v2: remove more local variables

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 113 ++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   3 +-
 4 files changed, 45 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 823b92005689a..4ec1058b7cdfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -685,7 +685,7 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 	job->vmid = vmid;
 	job->num_ibs = 1;
 
-	ret = amdgpu_ib_schedule(ring, 1, ib, job, &f);
+	ret = amdgpu_ib_schedule(ring, job, &f);
 
 	if (ret) {
 		drm_err(adev_to_drm(adev), "failed to schedule IB.\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 80565c4a31bdf..55a9670f1dd90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -103,8 +103,6 @@ void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f)
  * amdgpu_ib_schedule - schedule an IB (Indirect Buffer) on the ring
  *
  * @ring: ring index the IB is associated with
- * @num_ibs: number of IBs to schedule
- * @ibs: IB objects to schedule
  * @job: job to schedule
  * @f: fence created during this submission
  *
@@ -121,90 +119,70 @@ void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f)
  * a CONST_IB), it will be put on the ring prior to the DE IB.  Prior
  * to SI there was just a DE IB.
  */
-int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
-		       struct amdgpu_ib *ibs, struct amdgpu_job *job,
+int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		       struct dma_fence **f)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib *ib = &ibs[0];
+	struct amdgpu_ib *ib;
 	struct dma_fence *tmp = NULL;
 	struct amdgpu_fence *af;
 	struct amdgpu_fence *vm_af;
 	bool need_ctx_switch;
-	struct amdgpu_vm *vm;
 	uint64_t fence_ctx;
 	uint32_t status = 0, alloc_size;
 	unsigned int fence_flags = 0;
-	bool secure, init_shadow;
-	u64 shadow_va, csa_va, gds_va;
+	bool secure;
 	int vmid = AMDGPU_JOB_GET_VMID(job);
 	bool need_pipe_sync = false;
 	unsigned int cond_exec;
 	unsigned int i;
 	int r = 0;
 
-	if (num_ibs == 0)
+	if (!job)
+		return -EINVAL;
+	if (job->num_ibs == 0)
 		return -EINVAL;
 
-	/* ring tests don't use a job */
-	if (job) {
-		vm = job->vm;
-		fence_ctx = job->base.s_fence ?
-			job->base.s_fence->finished.context : 0;
-		shadow_va = job->shadow_va;
-		csa_va = job->csa_va;
-		gds_va = job->gds_va;
-		init_shadow = job->init_shadow;
-		af = job->hw_fence;
-		/* Save the context of the job for reset handling.
-		 * The driver needs this so it can skip the ring
-		 * contents for guilty contexts.
-		 */
-		af->context = fence_ctx;
-		/* the vm fence is also part of the job's context */
-		job->hw_vm_fence->context = fence_ctx;
-	} else {
-		vm = NULL;
-		fence_ctx = 0;
-		shadow_va = 0;
-		csa_va = 0;
-		gds_va = 0;
-		init_shadow = false;
-		af = kzalloc(sizeof(*af), GFP_ATOMIC);
-		if (!af)
-			return -ENOMEM;
-	}
+	ib = &job->ibs[0];
+	fence_ctx = job->base.s_fence ?
+		job->base.s_fence->finished.context : 0;
+	af = job->hw_fence;
+	vm_af = job->hw_vm_fence;
+	/* Save the context of the job for reset handling.
+	 * The driver needs this so it can skip the ring
+	 * contents for guilty contexts.
+	 */
+	af->context = fence_ctx;
+	/* the vm fence is also part of the job's context */
+	vm_af->context = fence_ctx;
 
 	if (!ring->sched.ready) {
 		dev_err(adev->dev, "couldn't schedule ib on ring <%s>\n", ring->name);
-		r = -EINVAL;
-		goto free_fence;
+		return -EINVAL;
 	}
 
-	if (vm && !job->vmid) {
+	if (job->vm && !job->vmid) {
 		dev_err(adev->dev, "VM IB without ID\n");
-		r = -EINVAL;
-		goto free_fence;
+		return -EINVAL;
 	}
 
 	if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
 	    (!ring->funcs->secure_submission_supported)) {
 		dev_err(adev->dev, "secure submissions not supported on ring <%s>\n", ring->name);
-		r = -EINVAL;
-		goto free_fence;
+		return -EINVAL;
 	}
 
-	alloc_size = ring->funcs->emit_frame_size + num_ibs *
+	alloc_size = ring->funcs->emit_frame_size + job->num_ibs *
 		ring->funcs->emit_ib_size;
 
 	r = amdgpu_ring_alloc(ring, alloc_size);
 	if (r) {
 		dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
-		goto free_fence;
+		return r;
 	}
 
 	need_ctx_switch = ring->current_ctx != fence_ctx;
-	if (ring->funcs->emit_pipeline_sync && job &&
+	if (ring->funcs->emit_pipeline_sync &&
 	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
 	     need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
 
@@ -216,14 +194,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		dma_fence_put(tmp);
 	}
 
-	if (job) {
-		vm_af = job->hw_vm_fence;
-		/* VM sequence */
-		vm_af->ib_wptr = ring->wptr;
-		amdgpu_vm_flush(ring, job, need_pipe_sync);
-		vm_af->ib_dw_size =
-			amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr, ring->wptr);
-	}
+	/* VM sequence */
+	vm_af->ib_wptr = ring->wptr;
+	amdgpu_vm_flush(ring, job, need_pipe_sync);
+	vm_af->ib_dw_size =
+		amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr, ring->wptr);
 
 	/* IB sequence */
 	af->ib_wptr = ring->wptr;
@@ -240,8 +215,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		ring->funcs->emit_wave_limit(ring, true);
 
 	if (ring->funcs->emit_gfx_shadow && adev->gfx.cp_gfx_shadow)
-		amdgpu_ring_emit_gfx_shadow(ring, shadow_va, csa_va, gds_va,
-					    init_shadow, vmid);
+		amdgpu_ring_emit_gfx_shadow(ring, job->shadow_va, job->csa_va, job->gds_va,
+					    job->init_shadow, vmid);
 
 	if (ring->funcs->init_cond_exec)
 		cond_exec = amdgpu_ring_init_cond_exec(ring,
@@ -255,7 +230,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	if (need_ctx_switch)
 		status |= AMDGPU_HAVE_CTX_SWITCH;
 
-	if (job && ring->funcs->emit_cntxcntl) {
+	if (ring->funcs->emit_cntxcntl) {
 		status |= job->preamble_status;
 		status |= job->preemption_status;
 		amdgpu_ring_emit_cntxcntl(ring, status);
@@ -264,15 +239,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	/* Setup initial TMZiness and send it off.
 	 */
 	secure = false;
-	if (job && ring->funcs->emit_frame_cntl) {
+	if (ring->funcs->emit_frame_cntl) {
 		secure = ib->flags & AMDGPU_IB_FLAGS_SECURE;
 		amdgpu_ring_emit_frame_cntl(ring, true, secure);
 	}
 
-	for (i = 0; i < num_ibs; ++i) {
-		ib = &ibs[i];
+	for (i = 0; i < job->num_ibs; ++i) {
+		ib = &job->ibs[i];
 
-		if (job && ring->funcs->emit_frame_cntl) {
+		if (ring->funcs->emit_frame_cntl) {
 			if (secure != !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
 				amdgpu_ring_emit_frame_cntl(ring, false, secure);
 				secure = !secure;
@@ -284,7 +259,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		status &= ~AMDGPU_HAVE_CTX_SWITCH;
 	}
 
-	if (job && ring->funcs->emit_frame_cntl)
+	if (ring->funcs->emit_frame_cntl)
 		amdgpu_ring_emit_frame_cntl(ring, false, secure);
 
 	amdgpu_device_invalidate_hdp(adev, ring);
@@ -296,7 +271,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		fence_flags |= AMDGPU_FENCE_FLAG_TC_WB_ONLY;
 
 	/* wrap the last IB with fence */
-	if (job && job->uf_addr) {
+	if (job->uf_addr) {
 		amdgpu_ring_emit_fence(ring, job->uf_addr, job->uf_sequence,
 				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
 	}
@@ -310,8 +285,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	amdgpu_fence_emit(ring, af, fence_flags);
 	*f = &af->base;
 	/* get a ref for the job */
-	if (job)
-		dma_fence_get(*f);
+	dma_fence_get(*f);
 
 	if (ring->funcs->insert_end)
 		ring->funcs->insert_end(ring);
@@ -319,7 +293,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	amdgpu_ring_patch_cond_exec(ring, cond_exec);
 
 	ring->current_ctx = fence_ctx;
-	if (job && ring->funcs->emit_switch_buffer)
+	if (ring->funcs->emit_switch_buffer)
 		amdgpu_ring_emit_switch_buffer(ring);
 
 	if (ring->funcs->emit_wave_limit &&
@@ -333,11 +307,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	amdgpu_ring_commit(ring);
 
 	return 0;
-
-free_fence:
-	if (!job)
-		kfree(af);
-	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 95aa87b4406eb..cd0707737a29b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -377,7 +377,7 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
 	int r;
 
 	job->base.sched = &ring->sched;
-	r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job, fence);
+	r = amdgpu_ib_schedule(ring, job, fence);
 
 	if (r)
 		return r;
@@ -447,8 +447,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 		dev_dbg(adev->dev, "Skip scheduling IBs in ring(%s)",
 			ring->name);
 	} else {
-		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
-				       &fence);
+		r = amdgpu_ib_schedule(ring, job, &fence);
 		if (r)
 			dev_err(adev->dev,
 				"Error scheduling IBs (%d) in ring(%s)", r,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index ce5af137ee400..fafb876d73da1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -575,8 +575,7 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		  enum amdgpu_ib_pool_type pool,
 		  struct amdgpu_ib *ib);
 void amdgpu_ib_free(struct amdgpu_ib *ib, struct dma_fence *f);
-int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
-		       struct amdgpu_ib *ibs, struct amdgpu_job *job,
+int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		       struct dma_fence **f);
 int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
-- 
2.53.0

