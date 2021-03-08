Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3428C433E9
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 12:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475E6651C3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 12:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475E6651C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49F966E04A;
	Mon,  8 Mar 2021 12:34:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B769D6E04A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 12:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWRQQui9iE2hYTpIHm0EblffixMKb04MtryW4jlc5dv5f9DesUwdZa2xJK4hgSHSNWEDRl/EWa5WJkayDTQUcF5G6pNNR7qQLHt45nCYLUH6Sm7aV3JbcZFwqeKUlgJ/zJzJ+h8mor0cEH0KswccVCK+TRYg+sTP/yQ1TQUMKF6Umggiqm0Vw+7YYlHHZFnmLVVK6w28pthedvc+CrOEwRT3bPX/ZC2c0RRaXCEVLUH8qeEBzsoOPzoEzjJRfJzpTIxoJLDT+FjpjxTzCB9SyUfa0vd3J/mp75Jm3kgECwfNZx0kZM4+cTCszrUNbqO/z+WnFZjgk1tunfDbpptloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrWdULGhLNEJwVM12gGTRM+5SKNAVF3swOlEklhH3WA=;
 b=DN+Du4BM5dUt2H6EHXuEB8aJ3SIECYVjY2D6R6zdbFbrAe7r3VKoPu+aNG9FfF2GOgHMQA60w02PGMM4zPtyzdtFE5rpJCiKvnkR7oBigrP/XwT4YvCLnJNHgXvQ2oPJY6oJ70PdEtbMwrNXMRpQ+0T4B5SVL4+33s3/NUDm+XqVE9Tvxdsa28NTA9yGyFT1dJE7YU26Xnki2s1rqyK35p8UfW4m84HlfacHchl+4vfvD5hGbo2P8Pa+Tr0D0A0Vr7uVzXExrZqRNcHAo+HelVpR/qEiZNxalDpn3UCPJZYCpxlusjrxplCRM1BAo5yJZ3tugPi8m8CDGTMPaOBb0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrWdULGhLNEJwVM12gGTRM+5SKNAVF3swOlEklhH3WA=;
 b=aoYqssR4mWRRH21AjoJ+18uORLeuvQbxbO63fE3ImiqeIhgvZPBFEyrHo2oADgJf/gbbrvmuLb2gLJY9d23iiWU7NiC3U/SHILbg2aAczjx268WDA34MzvUWeJFCHTO0cp81VOQcDWvRsytzpg0dAyaZ7QVgGri/m5sv6pW7FG0=
Received: from DM3PR12CA0132.namprd12.prod.outlook.com (2603:10b6:0:51::28) by
 MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Mon, 8 Mar 2021 12:34:02 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::58) by DM3PR12CA0132.outlook.office365.com
 (2603:10b6:0:51::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Mon, 8 Mar 2021 12:34:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 12:34:01 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 8 Mar 2021
 06:34:00 -0600
Received: from ubuntuBBNew.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Mon, 8 Mar 2021 06:33:58 -0600
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <Andrey.Grodzovsky@amd.com>, <Monk.Liu@amd.com>, <Emily.Deng@amd.com>
Subject: [PATCH v3] drm/amd/amdgpu implement tdr advanced mode
Date: Mon, 8 Mar 2021 20:33:56 +0800
Message-ID: <20210308123356.243375-1-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88093843-bdaf-4c9b-d223-08d8e22e73cd
X-MS-TrafficTypeDiagnostic: MW3PR12MB4442:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4442027FB16B98054300C752BB939@MW3PR12MB4442.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LnYuf58MTfbrvk/jCSctUWb8PfIJrLPK6TVyOpngpY0A2BI+wVXXBzCF5tI+FeryVGcK6rPhvJNWoVhoe7gKoXyoUtfBRSASNl1MCKjy0e6p/jUQ7pi2Uw+GX/OHQ71FNQ1EfsKLig2ohSY7h/h+G3XLk7CIjdXHLKMXQfOw6bSvzs2AjhyyhP18PbUeNbxeZGq00mDOyzuKZ9CcyO/EZnc33m2XkFN8dqKuRBoFJ3NMYnglCusjDXDoUQ9PNDOq9UjrUR0cIRaI5wueluCmaeAA6GH9EkPavFyOzJiLPh/HHqG7IYQT9HAU2j557r9sqIfTpbWieh4sgvDHEdekhFDwofIklnq9sQTxycF6SwFFqRKjSRq/HqohitT79PWWF7FYU9nmAWzQ9GNl+1ox1WIw26yxZ9vX+nN46k+8G4sQ7KDdfomSkSb96FSraRFe45A/ZvckKuWi6jmZUkR61n5JX8E0ehlJ9durkWpDk/gLJVBmJF3WcTTK1qnSb95ndXoMiUEMaUrGqt6Ze//HkVP9XqZiHiC3kltFrxcDWjE3E/PDbiymNlYScrSwY/EGG5EbCxEKmR0EwlKNdcxBT1WC206m4M2FWewKIbCEP8xEGz+eYN9VgPBOc/4vxaugyikvtLZ97TWog6YGQTGLWN4EslViOylaqIZfaxEY0exbEXT+x48cCJrwKfDJN3BV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966006)(36840700001)(336012)(356005)(47076005)(70586007)(82740400003)(36756003)(81166007)(70206006)(26005)(2906002)(426003)(4326008)(36860700001)(186003)(83380400001)(8936002)(2616005)(82310400003)(5660300002)(8676002)(7696005)(478600001)(86362001)(1076003)(110136005)(6636002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 12:34:01.1247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88093843-bdaf-4c9b-d223-08d8e22e73cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442
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
This patch implements an advanced tdr mode.
1.It synchronized resubmit wait step to find the real bad job. If the
job's hw fence get timeout, we decrease the old job's karma, treat
the new found one as a guilty one,do hw reset to recover hw. After
that, we conitue the resubmit step to resubmit the left jobs.

2. For whole gpu reset(vram lost), do resubmit as the old style.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 57 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 33 +++++++++++++
 3 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e247c3a2ec08..fa53c6c00ee9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4639,7 +4639,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	int i, r = 0;
 	bool need_emergency_restart = false;
 	bool audio_suspended = false;
-
+	int	tmp_vram_lost_counter;
 	/*
 	 * Special case: RAS triggered and full reset isn't supported
 	 */
@@ -4788,6 +4788,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		}
 	}
 
+	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
 	/* Actual ASIC resets if needed.*/
 	/* TODO Implement XGMI hive reset logic for SRIOV */
 	if (amdgpu_sriov_vf(adev)) {
@@ -4807,17 +4808,67 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
+			int ret = 0;
+			struct drm_sched_job *s_job = NULL;
 
 			if (!ring || !ring->sched.thread)
 				continue;
 
 			/* No point to resubmit jobs if we didn't HW reset*/
-			if (!tmp_adev->asic_reset_res && !job_signaled)
+			if (!tmp_adev->asic_reset_res && !job_signaled) {
 				drm_sched_resubmit_jobs(&ring->sched);
 
-			drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
+				if (amdgpu_gpu_recovery == 2 &&
+					!list_empty(&ring->sched->ring_mirror_list)
+					&& !(tmp_vram_lost_counter < atomic_read(&adev->vram_lost_counter)
+					 ) {
+
+					s_job = list_first_entry_or_null(&ring->sched->ring_mirror_list, struct drm_sched_job, node);
+					ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched->timeout);
+					if (ret == 0) { /* timeout */
+						/*reset karma to the right job*/
+						if (job && job != s_job)
+							amdgpu_sched_decrease_karma(&job->base);
+						drm_sched_increase_karma(s_job);
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
+
+						/* add reset counter so that the following resubmitted job could flush vmid */
+						atomic_inc(&tmp_adev->gpu_reset_counter);
+
+						//resubmit again the left jobs
+						drm_sched_resubmit_jobs(&ring->sched);
+						}
+					}
+				}
+			}
+			if (amdgpu_gpu_recovery != 2)
+				drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
+		}
+
+		if (amdgpu_gpu_recovery == 2) {
+			/* delay sched start until all jobs are submitted for advanced tdr mode */
+			for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
+				struct amdgpu_ring *ring = tmp_adev->rings[i];
+				int ret = 0;
+
+				if (!ring || !ring->sched.thread)
+					continue;
+
+				drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
+			}
 		}
 
+
 		if (!amdgpu_device_has_dc_support(tmp_adev) && !job_signaled) {
 			drm_helper_resume_force_mode(adev_to_drm(tmp_adev));
 		}
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
index 759b34799221..3457792b5d20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -281,6 +281,39 @@ void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched)
 	}
 }
 
+void amdgpu_sched_decrease_karma(struct drm_sched_job *bad)
+{
+	int i;
+	struct drm_sched_entity *tmp;
+	struct drm_sched_entity *entity;
+	struct drm_gpu_scheduler *sched = bad->sched;
+
+	/* don't decrease @bad's karma if it's from KERNEL RQ,
+	 * because sometimes GPU hang would cause kernel jobs (like VM updating jobs)
+	 * corrupt but keep in mind that kernel jobs always considered good.
+	 */
+	if (bad->s_priority != DRM_SCHED_PRIORITY_KERNEL) {
+		atomic_dec(&bad->karma);
+		for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_KERNEL;
+		     i++) {
+			struct drm_sched_rq *rq = &sched->sched_rq[i];
+
+			spin_lock(&rq->lock);
+			list_for_each_entry_safe(entity, tmp, &rq->entities, list) {
+				if (bad->s_fence->scheduled.context ==
+				    entity->fence_context) {
+						if (entity->guilty)
+							atomic_set(entity->guilty, 0);
+					break;
+				}
+			}
+			spin_unlock(&rq->lock);
+			if (&entity->list != &rq->entities)
+				break;
+		}
+	}
+}
+
 const struct drm_sched_backend_ops amdgpu_sched_ops = {
 	.dependency = amdgpu_job_dependency,
 	.run_job = amdgpu_job_run,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
