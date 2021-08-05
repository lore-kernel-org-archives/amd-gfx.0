Return-Path: <SRS0=ROs4=M4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221D7C4338F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 08:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE4AB60F38
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 08:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE4AB60F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 715876E3DB;
	Thu,  5 Aug 2021 08:32:25 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2086.outbound.protection.outlook.com [40.107.100.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2CE06E3DB
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Aug 2021 08:32:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaTzWGDM11yckZ6+PDgwz0/bClNRbd0ZBSXiWOe4Dvv7JjQec3M5+5okAD0xMy3Ii204W6bKjxTwQdQBJebYRyaFRxt6kPFNIuuXYKXqjxETx0PklDinfbD+WWzZxunrwanBokXBfv4ZGa4NvaQ+9TDG8T8g8nHyPE8CQg4xzgeB/37Egpb6Stf5njHyG05iI+lc8R0oEfCVSYrmvRgIKP1CrMjGsU5ttC7NgQwyI1hpYN1EOYZcPsZtWcZ9X8gXjwLZf3qqER1FqsbVxr9bOpFqz1Z4oD3ZqEDcNscpiXuG7dmDFohi4sxrtvbBYYk4Vcr+JDSg03WU6iJOEBcaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sk9ApCrvwdaqnivkJlbDblLp2iQju1j+fa6O/a78yYc=;
 b=a4J7k34+Spf4Ts7+afG1lbHmi0Bnj2xqoIjzPBdO75IzCIFTBVGZ+r7AiU6eaLsFvQAIIEoguN5B8e3gaqVNDmidgvYJyfjkF5c/tQiDAYRQ/c/8up5pkrqc5kZz0NzONqPZaC5VuruC8hSIgOAeD4j+dzuoMI63yzoorczatUv5JfcMAXEQU23gF/5oE/a6QL/jwCWfKfX2GjJEzWAbkVZjZmSuNgsv/U5i13iKuS0sLQhOdTItN8QxvhwdFPDqP65mRvexoyEFH5YhP8ivAfH1g1T6DPtursV5LAOHV/1KhrpHdVZ2JJqRyeNlWGwjKA3eXL2MjObXeUJ9/aw/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sk9ApCrvwdaqnivkJlbDblLp2iQju1j+fa6O/a78yYc=;
 b=4FuEMG1jRvd/oSJYv9V+pGRvePkYTSsaGJU3qPCmeQBPtXlyv1GTtVBCRe3QcQGfDQuOJ3gyq1RWzG7eUwHCy08sfdnRqONVwSin5rwiLYUTARuO9H3IWc1vd8Y1a583Zfk/4GMcLFvxw2M/osGWb6rpnaelbhO7II72YHBYziI=
Received: from DM6PR13CA0038.namprd13.prod.outlook.com (2603:10b6:5:134::15)
 by BN9PR12MB5292.namprd12.prod.outlook.com (2603:10b6:408:105::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 5 Aug
 2021 08:32:22 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::8d) by DM6PR13CA0038.outlook.office365.com
 (2603:10b6:5:134::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.4 via Frontend
 Transport; Thu, 5 Aug 2021 08:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Thu, 5 Aug 2021 08:32:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 5 Aug
 2021 03:32:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 5 Aug
 2021 03:32:21 -0500
Received: from wayne-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 5 Aug 2021 03:32:19 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <monk.liu@amd.com>, <christian.koenig@amd.com>,
 <Andrey.Grodzovsky@amd.com>, Jingwen Chen <Jingwen.Chen2@amd.com>, Jack Zhang
 <Jack.Zhang7@hotmail.com>
Subject: [PATCHv2 2/2] drm/amd/amdgpu: add tdr support for embeded hw_fence
Date: Thu, 5 Aug 2021 16:31:48 +0800
Message-ID: <20210805083146.324741-2-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805083146.324741-1-Jingwen.Chen2@amd.com>
References: <20210805083146.324741-1-Jingwen.Chen2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fd8495c-9b6b-4d88-ef27-08d957eb8bb4
X-MS-TrafficTypeDiagnostic: BN9PR12MB5292:
X-Microsoft-Antispam-PRVS: <BN9PR12MB52928CE417AF996F00C3F7C1B7F29@BN9PR12MB5292.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gfJ/EzB4cPW64NczARWMoLaQfFmJTcxQ2KK51kD8TxWm1fdpZdzS9x/EVo/3N3yp9t7HwotdvZWWj+FIhXur3Zwttk1Jhpagv7JZld+aTZh3LfhqcEjV6CxuhxQFtFyuoYzhDECBqv7DLP5tPqNw+jabhVv31ZJrSLVpKIci5uO9+k+Z58BDPOWE7//GAxrd7LIZ0sVY+41DIsmh4kl5QCDhAPtJ21FU3Mlq86FXAwZQrQDJ1bSKfHqRX5yYpaq7Tbn/+Hj2XYVnxCyVX8TRkckdXL4edtrzA6NRDDd1yJs9rRIXq+jD7UrU0uJuEOuVoQlEyE2La0D3Kls3hhTO/2l7odKL+vFU3GR9SmjQwHl1lURoMjHY+ehxK9hi6eiiMpQPJxKcQQy5yrvXmsMvb0Ar0vhyLbJkMSG4bICcFhG9B2kaAQ8TJEngMJR4uoye4Uq9N+Wtu1eIlssL+eDzbuXSbg0qhTQckj/lrhMa5Xkts8qstq56ORhEta69E2ZKxCecLU824F8SU0PApxUWHBEVuC8gcW+ihR42cMPaFsMxVNlrwoJg90rabU8BOMjdCBuCVfy0aS8yBh95eVJ02vw6BCI4vf0G8TSJa9S+9dUVnAQ78iRkonWrgSDQpR8TBqQOYrRaxy3w8mhx4jk9/tSqSHObmKTQ16SoA82OoA4kZGxDWm/IGpXm3AXPbxTzKwz1xDKjz6U2+fQbGQkOU/UUEsi8QeHuNMprZ6GfUgg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(36840700001)(356005)(70206006)(426003)(1076003)(8676002)(86362001)(36860700001)(2616005)(7696005)(70586007)(6666004)(5660300002)(478600001)(82740400003)(8936002)(81166007)(2906002)(336012)(186003)(45080400002)(4326008)(316002)(32650700002)(36756003)(83380400001)(54906003)(26005)(82310400003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 08:32:22.1558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd8495c-9b6b-4d88-ef27-08d957eb8bb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5292
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

[Why]
After embeded hw_fence to amdgpu_job, we need to add tdr support
for this feature.

[How]
1. Add a resubmit_flag for resubmit jobs.
2. Clear job fence from RCU and force complete vm flush fences in
   pre_asic_reset
3. skip dma_fence_get for resubmit jobs and add a dma_fence_put
   for guilty jobs.
v2:
use a job_run_counter in amdgpu_job to replace the resubmit_flag in
drm_sched_job. When the job_run_counter >= 1, it means this job is a
resubmit job.

Signed-off-by: Jack Zhang <Jack.Zhang7@hotmail.com>
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 13 +++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  3 +++
 4 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9e53ff851496..ade2fa07a50a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4447,7 +4447,7 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 				 struct amdgpu_reset_context *reset_context)
 {
-	int i, r = 0;
+	int i, j, r = 0;
 	struct amdgpu_job *job = NULL;
 	bool need_full_reset =
 		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
@@ -4471,6 +4471,16 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		if (!ring || !ring->sched.thread)
 			continue;
 
+		/*clear job fence from fence drv to avoid force_completion
+		 *leave NULL and vm flush fence in fence drv */
+		for (j = 0; j <= ring->fence_drv.num_fences_mask; j ++) {
+			struct dma_fence *old,**ptr;
+			ptr = &ring->fence_drv.fences[j];
+			old = rcu_dereference_protected(*ptr, 1);
+			if (old && test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &old->flags)) {
+				RCU_INIT_POINTER(*ptr, NULL);
+			}
+		}
 		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
 		amdgpu_fence_driver_force_completion(ring);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 5e29d797a265..c9752cf794fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -159,10 +159,15 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
 	}
 
 	seq = ++ring->fence_drv.sync_seq;
-	dma_fence_init(fence, &amdgpu_fence_ops,
-		       &ring->fence_drv.lock,
-		       adev->fence_context + ring->idx,
-		       seq);
+	if (job != NULL && job->job_run_counter) {
+		/* reinit seq for resubmitted jobs */
+		fence->seqno = seq;
+	} else {
+		dma_fence_init(fence, &amdgpu_fence_ops,
+				&ring->fence_drv.lock,
+				adev->fence_context + ring->idx,
+				seq);
+	}
 
 	if (job != NULL) {
 		/* mark this fence has a parent job */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 65a395060de2..19b13a65c73b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -254,6 +254,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 		dma_fence_set_error(finished, -ECANCELED);/* skip IB as well if VRAM lost */
 
 	if (finished->error < 0) {
+		dma_fence_put(&job->hw_fence);
 		DRM_INFO("Skip scheduling IBs!\n");
 	} else {
 		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
@@ -262,7 +263,9 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 			DRM_ERROR("Error scheduling IBs (%d)\n", r);
 	}
 
-	dma_fence_get(fence);
+	if (!job->job_run_counter)
+		dma_fence_get(fence);
+	job->job_run_counter ++;
 	amdgpu_job_free_resources(job);
 
 	fence = r ? ERR_PTR(r) : fence;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 92324c978534..1fa667f245e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -64,6 +64,9 @@ struct amdgpu_job {
 	/* user fence handling */
 	uint64_t		uf_addr;
 	uint64_t		uf_sequence;
+
+	/* job_run_counter >= 1 means a resubmit job */
+	uint32_t		job_run_counter;
 };
 
 int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
-- 
2.25.1

