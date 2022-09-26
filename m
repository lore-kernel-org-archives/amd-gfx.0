Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497F5C6FA8E
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 21:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A760410E7BF;
	Mon, 26 Sep 2022 21:41:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE6010E7BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 21:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDC2o/wGohMB8zpiB+2pY2+uXMg4VqJydt+s3zhPgh/PaKINifoL1niGWLG/ySGTEKzcx0JiIcHPOLftIuPK6CqEDRL6WX/VLBY2Fpfq74EvbkNVftnP4oAGWTY+zszXeABUnXeTBGVqVBbe1OfJw2r41lanCa6f3WbCeKp+QabCN2vbk6MljB9EZ6HPSCtkXFrLGcvfjo+rSwGVA04BFGu5v+3ax8tT457+WlclntsHNJtW3rGcVB9Nlj/D/TGuoadBCjSkG1GPHqn7VD/x69+lv0lu7xNdedwB8oyipEgoQSrUbdEsDSOBrMse6Vr026W8BAhsT92tUvOgBvq/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32X0Em1FuHDCSWZ3q1Elhf2tdVuRXHen+Ujm+mToPWM=;
 b=ZCxdIJRJCGH1e1n220F9O9igutWs9NVrmLs8UrdaG97M3cm2msi09SU0ZyY3kdnHi98eqAi3kfcXbC/lMTgYHoO68a5GYVJ4eppS1IvlL3BNDL1p/3NEAlwqelFSv4z66PwCdEXQxzsjQ5/MH/lnnSGbxmNc8MTm8wWj/Jriq6R49HeCR7TOS/FTtI05jOWbcOkrLOZvy/+utgGA8u0g0fFtopSoYonRXqYx8EZobJRzdv4zqcCWrZBdZvgOzvQU7vUTZ5OYvXkbjBXFjhXEYdI0XSeZO7tW8i/fFHxBwqVhiHD0u4pB9vzDynrFvhFwAIpbpJH83nltGPGieb1E3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32X0Em1FuHDCSWZ3q1Elhf2tdVuRXHen+Ujm+mToPWM=;
 b=hEvbVkN0WtQwUuNOxDO2qumzFjC6FF+4/fbIc2ptOcOXiXXrVQEdIVbRIV6VPGvrcAYy0QHUcmN4mY76bLcgPXn3Pgesa+N3bJ9o/UfGrc6CqOXSJTmALo/tQmgxC+im9b6K1BLCICbE9FXvhO1KlJ6y8A+huIvb2CZsOxasNxY=
Received: from DM6PR21CA0016.namprd21.prod.outlook.com (2603:10b6:5:174::26)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 21:41:13 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::27) by DM6PR21CA0016.outlook.office365.com
 (2603:10b6:5:174::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.0 via Frontend
 Transport; Mon, 26 Sep 2022 21:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 21:41:13 +0000
Received: from shashanks-target.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 16:40:43 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 4/5] drm/amdgpu: switch GPU workload profile
Date: Mon, 26 Sep 2022 23:40:13 +0200
Message-ID: <20220926214014.5450-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926214014.5450-1-shashank.sharma@amd.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|PH7PR12MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a20a03-846c-4196-4ccd-08daa007d5af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n1P1f5Y1RWBIfpsDnDtWDjxoD/AOfZbgzVAYxWlGnY0tfntj4iqtGRTTTGGqAuEHk5asiSW3qzqIWzk66qru4HKodFkdpm7xobC8drcP2co7mmU1DiBsLmQQ4FWeFIh4xf+zVIL96u0VPgSh0hrN3kIH1tROhoRX8ogiYqFY3VXhwhUAtuhTdWu/6mK4B1/9/tUbZ04YyrQfxnlm0LnSJdiZDedmCo/W0JLEwZCe+DRdXxjjRJz2sDYVD+7Uk4seTkQJXSmpYph3ElJ9UYFbBojAFfvU+t2I8IFI9/dyK8zBGFxbR4l8NW2de5ySL3QpG8N2upHZ5fc6eFPJt+ijwEvbJO94kxkCbKm64Rcyo2AxTx4O8lzhAMCnRJJPP1KEW343jYSL/ej7sQXK7fpY19XHLy5JPKeE9NJKl85oTlPURUCKxVcm/EIey3rY9ez/KHfWKYhv4ZOstwWymCzZpgr4EkMciMQLK7VL1lxdZX2vdgPz+Ify3vmOR6AfoYEZdbSDNAP9u8wn1fzpMCgzdIL2qJVrbfJqDXoz7/3B41SHOfrzMnBVn9cHYX2L2kccEAbKQJmi5OsD3K+PUGhMDRxZ8W5DqTC9Ez+uBWBTIVEgDGZFYTw/2CKaTzRgbPOmuW0BmCCL3D6dQt97djsESeSB+ePTTNORSDd7pNmcJEKwHeruQURKFqJkWWnmQkaypD9zBGUvK62/CkVtFWWTbXhOwWuZXK5FEEER+fIsZrrTldg9BrYrZ4sv/rrDKccdYTeWsVoYeyVENKHIc6r6vmURS00qBKMP8iskgWff6pg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199015)(40470700004)(36840700001)(46966006)(16526019)(81166007)(82740400003)(5660300002)(26005)(36860700001)(44832011)(336012)(6916009)(2616005)(86362001)(1076003)(186003)(36756003)(54906003)(70206006)(426003)(70586007)(47076005)(40480700001)(316002)(6666004)(356005)(82310400005)(7696005)(8936002)(2906002)(83380400001)(41300700001)(478600001)(8676002)(4326008)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 21:41:13.5503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a20a03-846c-4196-4ccd-08daa007d5af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
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

