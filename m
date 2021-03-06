Return-Path: <SRS0=7qc2=IE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1870DC433DB
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 17:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD43D65017
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Mar 2021 17:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD43D65017
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D9CB6E523;
	Sat,  6 Mar 2021 17:25:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB31D6E523
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Mar 2021 17:25:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYTA3zsYSrfrPvGwyI+mpRTQsRHFxLqAYNGaNM6B49IKGSx/zln75WLktiS2ZQC/erJBuMi/1gS+AKFakvONENenUmpQ0Bz1AQcecS3IXoX6fcnvbU/8fkaR79yFi359OQQkEOachBY5VFTTjYHG5PECPY6LJc8Sn60WL9EO38b+kbB8w9y8YYtp9WtLJQpLgwWrsdSCxGmRj5+wA7UWve07AzeMBGl67ToLmcHy1TAGPJzOI1SkPapT4Uc8aiftJsd6Onw0Gl/8lrDQDRevdkEw4qZVolr7b5kJldQqEYp1evj/yPuhFI9Xrb1VVSdZ7jGzPRCWpjQkgmJIIR2uXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N51l1Pk/UcXouhLiX0LOl2jJXNdFBP14MApKNPwrHGA=;
 b=hvGkIrLBBoND9tNBCYW37bDnm55CVfua94oOSFTue8ebilCQpPfKmbur4GL3kk4k65PutQF2tZIsCqcPzx/+VeXAv+D+bw7B8DAQWdeM4ZpAlEPJUoQTvKcRnoD7yW3RlYRb7ELp+nCPc9tFKsAeX9b82G50PYbcMD+jTWnVOckJy+MvdwFzmD58EtFqjkvZ0J+gRp+IvC/lNGXEz/1R01I3aNFpPV4J/XDgTJY4NNR3HfYhOifyeQnGhh6VePmPDxBAlXDZeluQR6rVZTw/b4ldVcFeomBrlj/UO7hcpDjNldP3KgaxzTLahaW8jh9Xc4okBFDW9ie8rnM8sy/mPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N51l1Pk/UcXouhLiX0LOl2jJXNdFBP14MApKNPwrHGA=;
 b=h9WTOCle5Rfsy7kPQtK+xrx09x3YPmPLAVjE2GEelFhSOXPzjAz2u7hmYuRfjRj4qK+peK6rbV/2zY3v6OCJW4Tx74gScTrqIW6xaplYUPUTbQjYzbrGtBl/ZSAiDNY+czJocxdS1RLcEPsB1ZnlbwhoyvGCApdm4wBaYBh9fjY=
Received: from DM5PR13CA0038.namprd13.prod.outlook.com (2603:10b6:3:7b::24) by
 BN9PR12MB5114.namprd12.prod.outlook.com (2603:10b6:408:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Sat, 6 Mar
 2021 17:25:36 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::5b) by DM5PR13CA0038.outlook.office365.com
 (2603:10b6:3:7b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.16 via Frontend
 Transport; Sat, 6 Mar 2021 17:25:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Sat, 6 Mar 2021 17:25:35 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sat, 6 Mar 2021
 11:25:34 -0600
Received: from ubuntuBBNew.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Sat, 6 Mar 2021 11:25:33 -0600
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Andrey.Grodzovsky@amd.com>, <Monk.Liu@amd.com>, <Emily.Deng@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu implement tdr advanced mode
Date: Sun, 7 Mar 2021 01:25:07 +0800
Message-ID: <20210306172507.202243-1-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cb08ddb-4df1-4241-da48-08d8e0c4da7f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5114:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5114E27A123CD02205390C9EBB959@BN9PR12MB5114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uzY+t9Xtxd0MKkezA11EGp+Hc9XZzZnjyjlj7bvyNQL69rloZwkEka+yuN4ISWymZHoxmXbvJA7FZd6KRe/7NFPS9TLozh5BmotsbCPNaZJFPmW2JjtOe5+2Q2iEN+2V+b57N29rBJD4CRo3A81MVRfcSEw8KJ+zXKY9j8fiq5T5mSKj8PqQbxZzKfnTnrhlxb5/5hieeffAIu+YhwvaDhxeaINttIUc89xyzug7a1VSxu/yooqe0py5mpFDJkugiIHEUKi22CMEY9WZNGkOIQIdD6oh62QgiNrtJR6FRklHblfo9OPyumPXRbj7CHBvuxe4vE2wcsuUFRhiudjvKxHSAYTnkaLiloFGGmH2ln/28+7eksvnEIUK0zNcU6GbEWKbEpEQ9vSOPGsvQkju5nq3zjR1DoH0mgOlzhmNjhnZrEd+KarfRN/ZcnPmU0wSo/gjLIxCoQtoPCo8Q3Z0leRSHbEfr9EzswSjATRtFrynDHfOHNe6QCeBrBqn4Y6QQmVyubcincdjFi7sqfXi8zrZriqiLm+5mDZzD1/s2VflWc1ZANz1mDHKMKMGl4lO3eSjxgddGcCKW2DStxW2NzzAjzvaumoYNPk/zvTfdUbM3NmyP6s4ePWxaAp49TGijyWfU5sDvL45o8B3lTKsjbDvaRgzCo/avN2oLdm01/48+1LzGndKDq0ZgiYpu5ht
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(36840700001)(36860700001)(316002)(4326008)(82740400003)(110136005)(7696005)(2906002)(36756003)(86362001)(8936002)(8676002)(47076005)(356005)(81166007)(1076003)(30864003)(82310400003)(70206006)(70586007)(83380400001)(336012)(26005)(6636002)(426003)(186003)(2616005)(478600001)(5660300002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2021 17:25:35.5929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb08ddb-4df1-4241-da48-08d8e0c4da7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5114
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Previous tdr design treats the first job in job_timeout as the bad job.
But sometimes a later bad compute job can block a good gfx job and
cause an unexpected gfx job timeout because gfx and compute ring share
internal GC HW mutually.

[How]
This patch implements an advanced tdr mode.It involves an additinal
synchronous pre-resubmit step(Step0 Resubmit) before normal resubmit
step in order to find the real bad job.

1. For Bailing TDR job, re-insert it to mirror_list, don't set it to
guilty and leave it to be handled by the main reset thread.

2. Don't set the job to guilty in pre_asic_reset, and leave it to be
handled by Step0 Resubmit Stage.

3. At Step0 Resubmit stage, it first resubmit jobs asynchronously,
then it iterate each ring mirror_list, synchronously pend for each hw
fence being signaled. If the a job's hw fence get timeout, we identify
it as guilty and do hw reset to recover hw. After that, we would do the
normal resubmit step to resubmit left jobs.

4. For whole gpu reset(vram lost), skip Step0 Resubmit as each job
after vram lost was considered as bad job.

5. Involve the concept "Affinity Group".
Doing two hw resets is not necessary when there's only one ring that
has jobs among some hw-related rings.Thus, we involve "affinity group".
Hw-related rings could be added into a common affinity group, such as
gfx and compute ring. When tdr happens, we iterate all rings in
affinity group, skip Step0 Resubmit stage if there's only one ring's
mirror_list that has valid sched jobs.

V2:
    -fix a cherry-pick mistake for bailing TDR handling.

    -do affinity_group check according to the bad job's sched rather
     than the default "1" so that there could be multiple affinity
     groups being pre-defined in future.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 102 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  47 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  27 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   1 +
 include/drm/gpu_scheduler.h                |   1 +
 7 files changed, 173 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e247c3a2ec08..8632d7071292 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4188,6 +4188,37 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 	return false;
 }
 
+bool amdgpu_affinity_group_has_only_or_null_working_ring(struct amdgpu_device *adev, struct drm_sched_job *s_job)
+{
+       int i;
+       int working_ring_num = 0;
+
+	/*
+	 * The job is considered as the real bad one
+	 * if job's sched is not in affinity group
+	 */
+	if (s_job->sched.affinity_group == 0)
+			return true;
+
+       for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
+               struct amdgpu_ring *ring = adev->rings[i];
+
+               if (!ring || !ring->sched.thread)
+                       continue;
+
+               /* for non-empty affinity ring, increase working_ring_num */
+               if (ring->sched.affinity_group == s_job->sched.affinity_group) {
+                       if (!list_empty(&ring->sched.ring_mirror_list))
+                               working_ring_num++;
+               }
+       }
+
+       if (working_ring_num > 1) {
+               return false;
+       }
+       return true;
+}
+
 /**
  * amdgpu_device_should_recover_gpu - check if we should try GPU recovery
  *
@@ -4310,8 +4341,10 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		amdgpu_fence_driver_force_completion(ring);
 	}
 
-	if(job)
-		drm_sched_increase_karma(&job->base);
+	if (amdgpu_gpu_recovery != 2) {
+		if (job)
+			drm_sched_increase_karma(&job->base);
+	}
 
 	/* Don't suspend on bare metal if we are not going to HW reset the ASIC */
 	if (!amdgpu_sriov_vf(adev)) {
@@ -4639,7 +4672,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	int i, r = 0;
 	bool need_emergency_restart = false;
 	bool audio_suspended = false;
-
+	int	tmp_vram_lost_counter;
 	/*
 	 * Special case: RAS triggered and full reset isn't supported
 	 */
@@ -4690,8 +4723,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 					job ? job->base.id : -1);
 
 		/* even we skipped this reset, still need to set the job to guilty */
-		if (job)
-			drm_sched_increase_karma(&job->base);
+		if (job) {
+			if (amdgpu_gpu_recovery == 2) {
+				if (&job->base) {
+					spin_lock(&job->base.sched->job_list_lock);
+					list_add(&job->base.node, &job->base.sched->ring_mirror_list);
+					spin_unlock(&job->base.sched->job_list_lock);
+				}
+			} else
+				drm_sched_increase_karma(&job->base);
+		}
 		goto skip_recovery;
 	}
 
@@ -4788,6 +4829,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		}
 	}
 
+	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
 	/* Actual ASIC resets if needed.*/
 	/* TODO Implement XGMI hive reset logic for SRIOV */
 	if (amdgpu_sriov_vf(adev)) {
@@ -4804,18 +4846,64 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	/* Post ASIC reset for all devs .*/
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
+		int step = 1;
 
+		if (amdgpu_gpu_recovery == 2) {
+			if (amdgpu_affinity_group_has_only_or_null_working_ring(adev,&job->base)
+				|| tmp_vram_lost_counter < atomic_read(&adev->vram_lost_counter)) {
+				DRM_INFO("Skip Stage0 Resubmit Stage\n");
+				/* set guilty */
+				drm_sched_increase_karma(&job->base);
+				step = 1;
+			} else {
+				DRM_INFO("Do Stage0 Resubmit Stage\n");
+				step = 0;
+			}
+		}
+
+retry_resubmit:
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
+			int ret = 0;
+			struct drm_sched_job *s_bad_job = NULL;
 
 			if (!ring || !ring->sched.thread)
 				continue;
 
 			/* No point to resubmit jobs if we didn't HW reset*/
-			if (!tmp_adev->asic_reset_res && !job_signaled)
+			if (!tmp_adev->asic_reset_res && !job_signaled) {
+
 				drm_sched_resubmit_jobs(&ring->sched);
 
-			drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
+				if (amdgpu_gpu_recovery == 2 && step == 0) {
+					ret = amdgpu_wait_resubmitted_jobs_completion(&ring->sched, ring->sched.timeout, &s_bad_job);
+					if (ret == -1) {
+						DRM_ERROR("Found the real bad job! ring:%s, job_id:%llx\n", ring->sched.name, s_bad_job->id);
+						/* set guilty */
+						drm_sched_increase_karma(s_bad_job);
+
+						/* do hw reset */
+						if (amdgpu_sriov_vf(adev)) {
+							amdgpu_virt_fini_data_exchange(adev);
+							r = amdgpu_device_reset_sriov(adev, false);
+							if (r)
+								adev->asic_reset_res = r;
+						} else {
+							r  = amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset, false);
+							if (r && r == -EAGAIN)
+								goto retry;
+						}
+
+						/* add reset counter so that the following resubmitted job could flush vmid */
+						atomic_inc(&tmp_adev->gpu_reset_counter);
+						step = 1;
+						goto retry_resubmit;
+					}
+				}
+			}
+
+			if (step == 1)
+				drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
 		}
 
 		if (!amdgpu_device_has_dc_support(tmp_adev) && !job_signaled) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 865f924772b0..9c3f4edb7532 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -509,7 +509,7 @@ module_param_named(compute_multipipe, amdgpu_compute_multipipe, int, 0444);
  * DOC: gpu_recovery (int)
  * Set to enable GPU recovery mechanism (1 = enable, 0 = disable). The default is -1 (auto, disabled except SRIOV).
  */
-MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 = enable, 0 = disable, -1 = auto)");
+MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (2 = advanced tdr mode, 1 = enable, 0 = disable, -1 = auto)");
 module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 759b34799221..28cda321157a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -281,6 +281,53 @@ void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
 	}
 }
 
+int amdgpu_wait_resubmitted_jobs_completion(struct drm_gpu_scheduler *sched, long timeout, struct drm_sched_job **s_bad_job)
+{
+	struct drm_sched_job *s_job, *tmp;
+	int ret = 0;
+
+	list_for_each_entry_safe(s_job, tmp, &sched->ring_mirror_list, node) {
+		struct drm_sched_fence *s_fence = s_job->s_fence;
+
+			if (s_fence->parent == NULL) { /* fail to get a hw fence */
+				/* process a job */
+				atomic_dec(&sched->num_jobs);
+				dma_fence_get(&s_fence->finished);
+				dma_fence_signal(&s_fence->finished);
+				dma_fence_put(&s_fence->finished);
+
+				/* remove node from mirror_list and free the job */
+				spin_lock(&sched->job_list_lock);
+				list_del_init(&s_job->node);
+				spin_unlock(&sched->job_list_lock);
+				sched->ops->free_job(s_job);
+				continue;
+			}
+
+			ret = dma_fence_wait_timeout(s_fence->parent, false, timeout);
+
+			if (ret > 0) { /* succeed */
+				/* process a job */
+				atomic_dec(&sched->num_jobs);
+				dma_fence_get(&s_fence->finished);
+				dma_fence_signal(&s_fence->finished);
+				dma_fence_put(&s_fence->finished);
+
+				/* remove node from mirror_list and free the job */
+				spin_lock(&sched->job_list_lock);
+				list_del_init(&s_job->node);
+				spin_unlock(&sched->job_list_lock);
+				sched->ops->free_job(s_job);
+				continue;
+			} else if (ret == 0) {
+				*s_bad_job = s_job;
+				return -1; /* timeout */
+			}
+	}
+
+	return 0;
+}
+
 const struct drm_sched_backend_ops amdgpu_sched_ops = {
 	.dependency = amdgpu_job_dependency,
 	.run_job = amdgpu_job_run,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 81caac9b958a..25292f4699fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -76,5 +76,5 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
 			     struct dma_fence **fence);
 
 void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched);
-
+int amdgpu_wait_resubmitted_jobs_completion(struct drm_gpu_scheduler *sched, long timeout, struct drm_sched_job **s_bad_job);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index b644c78475fd..cb50bfc80bc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -35,6 +35,11 @@
 #include "amdgpu.h"
 #include "atom.h"
 
+static char *amdgpu_affinity_group[] = {
+"gfx",
+"comp"
+};
+
 /*
  * Rings
  * Most engines on the GPU are fed via ring buffers.  Ring
@@ -189,6 +194,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 		ring->adev = adev;
 		ring->idx = adev->num_rings++;
 		adev->rings[ring->idx] = ring;
+		amdgpu_ring_set_affinity_group(ring);
 		r = amdgpu_fence_driver_init_ring(ring, sched_hw_submission);
 		if (r)
 			return r;
@@ -459,3 +465,24 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring)
 	ring->sched.ready = !r;
 	return r;
 }
+
+int amdgpu_ring_set_affinity_group(struct amdgpu_ring *ring)
+{
+       struct amdgpu_device *adev = ring->adev;
+       int i;
+
+       for (i = 0; i < ARRAY_SIZE(amdgpu_affinity_group); i++) {
+               char *temp_name = amdgpu_affinity_group[i];
+
+               /* set ring's affinity_group bit if find it in affinity_group list */
+               if (strncmp(ring->name, temp_name, strlen(temp_name)) == 0) {
+                       DRM_DEV_INFO(adev->dev, "set ring:%s in affinity_group\n",
+                             ring->name);
+                       ring->sched.affinity_group = 1;
+                       return 0;
+               }
+       }
+
+       ring->sched.affinity_group = 0;
+       return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 56acec1075ac..6b0d217e6f5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -350,4 +350,5 @@ int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 			     struct amdgpu_ring *ring);
 void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
 
+int amdgpu_ring_set_affinity_group(struct amdgpu_ring *ring);
 #endif
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 1c815e0a14ed..589cbaea35dc 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -301,6 +301,7 @@ struct drm_gpu_scheduler {
 	atomic_t                        _score;
 	bool				ready;
 	bool				free_guilty;
+	int				affinity_group;
 };
 
 int drm_sched_init(struct drm_gpu_scheduler *sched,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
