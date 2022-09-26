Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6363FC07E9D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 15:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2765A10E6CF;
	Mon, 26 Sep 2022 15:03:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CE7810E47C
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 15:03:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZYHTJ4vfRIv3NGN4UzllCeTUap/W467afztL95H2qLpNWUvJqle9mgF6ifiJDUFIZss2YYOSBjwAYuU4C9WNTRTR/kJNELvVRob+JJWbTO+4VdARANqZcwVuTrXr9MIeyW+IOFb56VRTVUDvJw4ZR5zsQx0gBLMOaqsEgoNxjD7IkSlERVFpzqBVrZpgSgmunDxVXpZmhZ3dZi5dLdJUB9YtyeAJFuZgYN5ol1OmZowjhq3hO7j1zeKdsuCYF6PMJ/pKrj+KLJXgEY/K3GwGk9X3EddvxQbCog74IugLBGTs08lzkNSZhbJcg+03ymYMX9D0qx7UZXI5RMUglwABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32X0Em1FuHDCSWZ3q1Elhf2tdVuRXHen+Ujm+mToPWM=;
 b=Y8nQ5H4woSBMJWDDdkSGhVOhmCZuoPUNY6YYols2qsWDBWgZ+lz29tgubehNLyjqwgzl2VKEHUvtXAAGBUIE2Wbeqrg2S8R/QCxjfkKUI4lwB02sm7ZJq5+QSqEcG0xxT5pDEkbbSjbsC3Fb36dfgjDPNkkZtVFLnhaRXALVvi5/skut4UuShvDtoxOzg8C3LPpXq8DLtDBeWYVa8kRBvUGgrkSn/OiZSLlD9QpxHa5M3t2kOI8qrpZ+DSuCSnnYos7+4GMvaalaQNklI240t8WTUPZ1ECAXwcsTcHiZQsqlSelNFaOGt0i8ggXjGBtqEBCFsKPMTRhzsArR8b/8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32X0Em1FuHDCSWZ3q1Elhf2tdVuRXHen+Ujm+mToPWM=;
 b=Rqmt0xrP8OA3LF32FcNLZYjusciCwWdwOiZsm5+FXf75xETBtJlhO2GGwiA/8j/7vG8QZR6DhysReo4nogEUwAWbADVPBRnHrxnrNzb7mckhZ95a3s9hklm0TwFh8je0ebiPsoysApHNymwNbrWZxdfG4DyWG54G5SrjanUFvEE=
Received: from MW4PR04CA0365.namprd04.prod.outlook.com (2603:10b6:303:81::10)
 by CH2PR12MB4102.namprd12.prod.outlook.com (2603:10b6:610:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 15:03:14 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::82) by MW4PR04CA0365.outlook.office365.com
 (2603:10b6:303:81::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 15:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 15:03:14 +0000
Received: from shashanks-target.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 10:03:12 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/5] drm/amdgpu: switch GPU workload profile
Date: Mon, 26 Sep 2022 17:02:51 +0200
Message-ID: <20220926150252.18635-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926150252.18635-1-shashank.sharma@amd.com>
References: <20220926150252.18635-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|CH2PR12MB4102:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dfef970-ee1e-4979-fa00-08da9fd03c89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRbJIwLeWT7P6sQXnHi7CfaRF71A3Zsg6MVOI91eoDw2lmidD51z9PtVAr0M7AvVYLcrh8T0bBuUdlrYr4gvsuRU6m9yIPGJJGP3j5KBSbs3rGvq/fwSf1YPvsKGd2WmyhHPQr9M1G1q2KjDJabLf4D+D+s4g5NVQ0WH3vepO49MMrPELV6+mwWNSF9ZG8crPUPOYbCQrcmRHhW/H0MAryOC7uRCiHaVV8lUUVo7kqJ7zxRKJwsSPFNTYEEsp2tEVLtW7gDuIazY48hOePabMR0zvuzOmWqRbKKBbElBChKkd95Kls/hHifla8d8fmisMUnXPtyZiQ0BlE6IxIk5Wzc8yyAEnfd7qG9Z9dbPAqmdRkUzCp+kACGQFaf4BySYfpwMIMAkQxeYtRpXbAM79MeRGH0aE44tnrUovQpoAv+9rL9pWIu3ew8P979aFIbRBw2HdgXVo3+HrfamuQoYE2jzPGlotsDE7c7fZZjLoKFNUHaFjkmoSa9DAVpr6/o0Ob6R8aDsER/96Q3aWWJlK04kWhEimGzhX1nEYwePNpHzOxqLsWz+y56NEgRgeBF0yb436/w7wyt1h2hauiCQd7VRBFkNEHMnslyulu+C0P9ClAg6aHOoU86my81qS1JgIlADo3BMDR5L24uu83rFfTZYloyka6MCwk7NmeoMLbuxZTNtkMyrwcAMAJmM7bS8diL0s08CxfVNTFKF9g76z8D6Xv7bKz9oZJQA5VYo2GCisgM1XoBd9iPWe+c0UJCJsaAdzT5Rvkv78FuT9YzeMXdGdh2F/naoq0KGhPYMD18=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(81166007)(356005)(83380400001)(336012)(16526019)(186003)(426003)(36860700001)(2616005)(82740400003)(1076003)(26005)(7696005)(478600001)(6666004)(41300700001)(8936002)(47076005)(70206006)(4326008)(70586007)(8676002)(2906002)(82310400005)(40460700003)(44832011)(5660300002)(6916009)(54906003)(316002)(36756003)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 15:03:14.2160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfef970-ee1e-4979-fa00-08da9fd03c89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4102
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com, Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch and switches the GPU workload based profile based
on the workload hint information saved in the workload context.
The workload profile is reset to NONE when the job is done.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c |  4 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c          | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h          |  3 +++
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index b7bae833c804..de906a42144f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -237,6 +237,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 		goto free_all_kdata;
 	}
 
+	p->job->workload_mode = p->ctx->workload_mode;
+
 	if (p->uf_entry.tv.bo)
 		p->job->uf_addr = uf_offset;
 	kvfree(chunk_array);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
index a11cf29bc388..625114804121 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
@@ -55,15 +55,11 @@ int amdgpu_set_workload_profile(struct amdgpu_device *adev,
 
 	mutex_lock(&adev->pm.smu_workload_lock);
 
-	if (adev->pm.workload_mode == hint)
-		goto unlock;
-
 	ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
 	if (!ret)
 		adev->pm.workload_mode = hint;
 	atomic_inc(&adev->pm.workload_switch_ref);
 
-unlock:
 	mutex_unlock(&adev->pm.smu_workload_lock);
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index c2fd6f3076a6..9300e86ee7c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -30,6 +30,7 @@
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_reset.h"
+#include "amdgpu_ctx_workload.h"
 
 static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 {
@@ -144,6 +145,14 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 {
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
+	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
+
+	if (job->workload_mode != AMDGPU_CTX_WORKLOAD_HINT_NONE) {
+		if (amdgpu_clear_workload_profile(ring->adev, job->workload_mode))
+			DRM_WARN("Failed to come out of workload profile %s\n",
+				amdgpu_workload_profile_name(job->workload_mode));
+		job->workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
+	}
 
 	drm_sched_job_cleanup(s_job);
 
@@ -256,6 +265,12 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 			DRM_ERROR("Error scheduling IBs (%d)\n", r);
 	}
 
+	if (job->workload_mode != AMDGPU_CTX_WORKLOAD_HINT_NONE) {
+		if (amdgpu_set_workload_profile(ring->adev, job->workload_mode))
+			DRM_WARN("Failed to set workload profile to %s\n",
+				  amdgpu_workload_profile_name(job->workload_mode));
+	}
+
 	job->job_run_counter++;
 	amdgpu_job_free_resources(job);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index babc0af751c2..573e8692c814 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -68,6 +68,9 @@ struct amdgpu_job {
 	/* job_run_counter >= 1 means a resubmit job */
 	uint32_t		job_run_counter;
 
+	/* workload mode hint for pm */
+	uint32_t		workload_mode;
+
 	uint32_t		num_ibs;
 	struct amdgpu_ib	ibs[];
 };
-- 
2.34.1

