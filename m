Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8136BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 13:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 028C710EA7E;
	Wed,  1 Jun 2022 13:36:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FE2610EA79
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 13:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egVJ4dOtrezLnEk4Sox2HFiiNHVUkHKY2CyOyhiVAoWRumDMrYfNmekrkHcEFus/NstpoiNcsynOIPewvhjP8Yy5QReclevLIr8Hbs265WMNwpXJ0+ltgevC4OUBqTsoZe463Q9hvWm3DeG2kbllE9AcPYEFhFQjWsVAjipp0oB31ZfpGQdaN7PIoL1TmCFkdjLS+1twY65fyU1F96ub2CUrYxeTm1naoulaj3UoT2O2O+rQj4+XN2UexSr/BaMuNOqmLqU4h5jmFVk4ARS5T5rEwSihmCFbm4jks1GR/Tad191zO/wqOoznvI6TNOmVx2q6/7md8XdRBM69GPHGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXV3C0RRcyIzwYTc1Gca8kexFKC9644kG02LOEbrPng=;
 b=d1dz9c8s/vzOQJdPpCI29yuAahp/FaRD/2YZaD/WK/pvn/GcIBwz1r8LeX6tdOxzpXRQ0jq9xWyj1AymjG4o+Oy7WeEfvU4eaoyJoix8buJmAP1G0OanfLSvbB7pXThCf47W6BEfw312ZGLudHbNK0FPvep26sh4iehy0fYa++KtT0r1iMx+8MpPFRN/6bvs77YEg6k5QW7VXboMgl/3yE/RZVIyOreHK0zjXSqu5f7MTN1ySuXL3jol5WxBEcUHa4qj+SBbzjt4310BuZ6Jkh6h4RfwnvYn9Y/MEhEOt237c8tA2FHQp+7FMtn86W3seWvzzwBkmV29ULvsqCnx3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXV3C0RRcyIzwYTc1Gca8kexFKC9644kG02LOEbrPng=;
 b=F3smhUEwLHN056Z6kJ8G42htLhidJhugDQq7473mqHksWHcSautoxkenq56KAcxwlBSB3yPMwI9SEU6DMespY3GJtzIOih3GRVzITRxAFAbXYDOhbGf5FSpRk8lWS87xJdCn52pUS6R3xmrP/VEe4NScFdHNQTWiR58Ugx7urrU=
Received: from MWHPR17CA0053.namprd17.prod.outlook.com (2603:10b6:300:93::15)
 by DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Wed, 1 Jun 2022 13:36:25 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::13) by MWHPR17CA0053.outlook.office365.com
 (2603:10b6:300:93::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Wed, 1 Jun 2022 13:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 13:36:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 1 Jun
 2022 08:35:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 1 Jun
 2022 08:35:51 -0500
Received: from yiqinyao-Pro-E800-G4-WS950T.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Wed, 1 Jun 2022 08:35:50 -0500
From: Yiqing Yao <yiqing.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix refcount underflow in device reset
Date: Wed, 1 Jun 2022 21:35:23 +0800
Message-ID: <20220601133523.2370337-1-yiqing.yao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca669cdd-1843-461e-cfe1-08da43d3b936
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB541317E35BCA100183FF395485DF9@DM8PR12MB5413.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQnEkyDflgBGCOeS5cnXQHGlQWuhmtn+KzZ9TWyOsuCP69i5LrL1DgvLmTOPoaOR0EYSnp2sK+aL53v4MNUohbGy0MsXysbvozPMSiul1Z7GYgg6b6r/fTf7ztmhHMkOlIixIabZRhjffZeJXRiCYiCg8AD61o1ckh8Kpi8+WxuR/6Gy/QzEcS3KYCaUbEw5pPbwXv0gAQVJ5YHu/lB84ieTRlPb9xn5p4/37f3TJiooaXMdi3jFjbjm5gyChy45E08X9/gyiSX/vyNAuk4N7cJDu46Iqfk459FCR1P/FtJacweve31lcCNMDmXRCsT95RzO8gouauBUbg0r6C8Mr74n1Q1NPz8uAe59WKX9sUw1yHikAuQxGYTRL/9mIjN+pQ7sv5H5N+6B96xs5FtBU0ui1aOJSTER/okDFQqoRo1dsNpbFTUV/ymZDHLY+KKryPFKEdZV8PaNWtVHajGnybOD6P36VQYYJNoFn9lrixn5/OMxCyN6dc3A5i1Qa9+H2y3YQJB3p5d38WViTMF9vlnl6vwirg4GjD5Evf+Ag7lhEr4mL97ReIQUrF55lNVp9iS8/9iF8W37e5ZzmAVCWAf60lCVcrUwQatlTQtdn5V8FC4ZOPeEWPWE6UnvWV0glnybk0deVe+QVIQfkGqq1ulJI1Tfuo9ZJVL6r+9dRS6kT3QI8JMGKlszF3fIeuTV/s4KovgtKDHLiPBiP9vLWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(4326008)(8676002)(82310400005)(36756003)(26005)(70206006)(70586007)(40460700003)(36860700001)(54906003)(6916009)(83380400001)(186003)(2906002)(336012)(1076003)(6666004)(8936002)(81166007)(86362001)(356005)(7696005)(2616005)(5660300002)(508600001)(44832011)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 13:36:24.9009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca669cdd-1843-461e-cfe1-08da43d3b936
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
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
Cc: jingwen.chen2@amd.com, horace.chen@amd.com, monk.liu@amd.com,
 Yiqing Yao <yiqing.yao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
A gfx job may be processed but not finished when reset begin from
compute job timeout. drm_sched_resubmit_jobs_ext in sched_main
assume submitted job unsignaled and always put parent fence.
Resubmission for that job cause underflow. This fix is done in
device reset to avoid changing drm sched_main.

[how]
Check if the job to submit has signaled and avoid submission if
signaled in device reset for both advanced TDR and normal job
resume.

Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 72 ++++++++++++----------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f16f105a737b..29b307af97eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4980,39 +4980,43 @@ static void amdgpu_device_recheck_guilty_jobs(
 		/* for the real bad job, it will be resubmitted twice, adding a dma_fence_get
 		 * to make sure fence is balanced */
 		dma_fence_get(s_job->s_fence->parent);
-		drm_sched_resubmit_jobs_ext(&ring->sched, 1);
 
-		ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched.timeout);
-		if (ret == 0) { /* timeout */
-			DRM_ERROR("Found the real bad job! ring:%s, job_id:%llx\n",
-						ring->sched.name, s_job->id);
+		/* avoid submission for signaled hw fence */
+		if(!dma_fence_is_signaled(s_job->s_fence->parent)){
 
-			/* set guilty */
-			drm_sched_increase_karma(s_job);
+			drm_sched_resubmit_jobs_ext(&ring->sched, 1);
+
+			ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched.timeout);
+			if (ret == 0) { /* timeout */
+				DRM_ERROR("Found the real bad job! ring:%s, job_id:%llx\n",
+							ring->sched.name, s_job->id);
+
+				/* set guilty */
+				drm_sched_increase_karma(s_job);
 retry:
-			/* do hw reset */
-			if (amdgpu_sriov_vf(adev)) {
-				amdgpu_virt_fini_data_exchange(adev);
-				r = amdgpu_device_reset_sriov(adev, false);
-				if (r)
-					adev->asic_reset_res = r;
-			} else {
-				clear_bit(AMDGPU_SKIP_HW_RESET,
-					  &reset_context->flags);
-				r = amdgpu_do_asic_reset(device_list_handle,
-							 reset_context);
-				if (r && r == -EAGAIN)
-					goto retry;
-			}
+				/* do hw reset */
+				if (amdgpu_sriov_vf(adev)) {
+					amdgpu_virt_fini_data_exchange(adev);
+					r = amdgpu_device_reset_sriov(adev, false);
+					if (r)
+						adev->asic_reset_res = r;
+				} else {
+					clear_bit(AMDGPU_SKIP_HW_RESET,
+						&reset_context->flags);
+					r = amdgpu_do_asic_reset(device_list_handle,
+								reset_context);
+					if (r && r == -EAGAIN)
+						goto retry;
+				}
 
-			/*
-			 * add reset counter so that the following
-			 * resubmitted job could flush vmid
-			 */
-			atomic_inc(&adev->gpu_reset_counter);
-			continue;
+				/*
+				* add reset counter so that the following
+				* resubmitted job could flush vmid
+				*/
+				atomic_inc(&adev->gpu_reset_counter);
+				continue;
+			}
 		}
-
 		/* got the hw fence, signal finished fence */
 		atomic_dec(ring->sched.score);
 		dma_fence_put(s_job->s_fence->parent);
@@ -5221,13 +5225,19 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
 
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
-
+			struct drm_sched_job *s_job;
 			if (!ring || !ring->sched.thread)
 				continue;
 
+			s_job = list_first_entry_or_null(&ring->sched.pending_list,
+				struct drm_sched_job, list);
+
+			if(s_job){
 			/* No point to resubmit jobs if we didn't HW reset*/
-			if (!tmp_adev->asic_reset_res && !job_signaled)
-				drm_sched_resubmit_jobs(&ring->sched);
+				if (!tmp_adev->asic_reset_res && !job_signaled 
+					&& !dma_fence_is_signaled(s_job->s_fence->parent))
+					drm_sched_resubmit_jobs(&ring->sched);
+			}
 
 			drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
 		}
-- 
2.25.1

