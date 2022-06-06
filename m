Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAE3C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 07:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92C60112E1E;
	Mon,  6 Jun 2022 07:44:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D7A112E1E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 07:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+ZzaY82BPU5Tm5Lm5ef0XbZzMQaInmAWxxAXILoXnZUUqBH8dx3ry8GxcobYnnVHUEbx3GBUY1wIYFfltGilHiAnr0AzpoZ1UoSau4sW+ODs5VsauMOuWgLakOE8n1df0vRILsquf/WQsD7pf4xlCyFQfIB76jvOAvPSAnxn1GyqtIDKKqEQm1CKXYi561W0L6IjmEhQN/blsyju9XzSRNIlwOxNT0LVfF07LJ5tzV4ifX2SUvp6cKGrB9bMvCuxD96wEBMmK/vMPgGdJ9sR93Iw1ssG/1jRYhvFx6BN+5t96GUQoGtg6E8YGQyD3zLkQgPdiNukqBc0ti8hPkfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXV3C0RRcyIzwYTc1Gca8kexFKC9644kG02LOEbrPng=;
 b=DimYsKJZ78jVhvOdUP5v3pOGyja4+CkOahmiD7YuOfUG8b18TS3dWVO8/bCpw+GQWDE+ficMPoMdzSFqZDi7rGx9pQlJjmZjjtQX9A4PPtIJ2yr8DmIEL8eH8inTLKALIFib0CgX6TeaUCgNAlmt5vJ5JRnXXAGpI6QBOr1HEY/6LaF9jRwRfzCnWLwZw/ot0bqePqXr446uRpeoVbZt4thcQs1X3f0bxGS4wCzcMI6k6V3JERV2Brapk9oy3w042Nz4Vj9noLCeeamdCy7tveAe5q92mrdxqLLfboHXJqpz3CbfJW4b8WfIGS0pggHZRqr9IFNHh8n35GobHfIilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXV3C0RRcyIzwYTc1Gca8kexFKC9644kG02LOEbrPng=;
 b=WZ1BiTjYL0q+eqr0qWQOJ/HtHIJvNWxEV+2w4GZggSekBflGHpve/T7BfTagTBSKrcaT7gxnXUAPORvM285PKU7pqQB7VVfK/cQ4wcNHWO8dTkY8FCoh7jbB4SbrS9yeNIbNidj3tqav1WXftlSw7YJQutsJaECWLMXUIo6eDVM=
Received: from BN9PR03CA0529.namprd03.prod.outlook.com (2603:10b6:408:131::24)
 by BN6PR12MB1713.namprd12.prod.outlook.com (2603:10b6:404:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 07:44:15 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::58) by BN9PR03CA0529.outlook.office365.com
 (2603:10b6:408:131::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Mon, 6 Jun 2022 07:44:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 07:44:15 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 6 Jun
 2022 02:44:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 6 Jun
 2022 00:44:15 -0700
Received: from yiqinyao-Pro-E800-G4-WS950T.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Mon, 6 Jun 2022 02:44:13 -0500
From: Yiqing Yao <yiqing.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix refcount underflow in device reset
Date: Mon, 6 Jun 2022 15:43:52 +0800
Message-ID: <20220606074352.1326835-1-yiqing.yao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4775fb6-6e63-41f0-dc05-08da47905b41
X-MS-TrafficTypeDiagnostic: BN6PR12MB1713:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1713FF7952184A22CC66A96585A29@BN6PR12MB1713.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lTQA6viskU55gLEXvyaMp87btKfMYgL7Wc6GnQRIa91AscpA3c6SH2pPzSP9vfJ+Ul6WTlalRYb0B0Tseb/RP5XE+VS7LQSghlEv4/eBKvaPvrfi3cipmKqAfanp2CACQ0GoIm6PFRVhzZ557Uva+BOWpvdocnwbguG/5PDKgl0iGbugbiUSO9Dstg+DcZc4F6u4x+v4eAV+X3peVyikOu7wCMSPpzWg3B/NZC7W5EeU0aq2UFn1lyFcVBV0bVdmDLflpPE41b/oimIk68SRNWrvv27VA0rJ0cK5zXumga2egeBUQRbz7NQZcfEokCcOed4En9q5GIt/o3eQatXSIb7nEdjmJIGrZucd1LiKXa/nCjgHjj1XWp302UnmP1EbaI2wrz2CHKrapS8HItGcavA9coGDcXuIZ5KQsGDR7+30nPSW3PHF4DzxeOgVg7x6b6YaTNNd23MyY7iJqLtzy+AHptH/gZ+7Cslqp4Xq1Sa+9NWc8QGiByfNcrnhLie29wtFEGNqJ30B8CfHvvSk/bMPI8DlbELwentQvBEMjaEMyDpAPGZoRaE42zGJ7mZkm9D5+kEcLd5g6BuYtVfqGGsbWSiP900miETXFRcr6DlpwxvW96VfM/inqmhK5l5e/AzmZilZNugJ/ogm4G3+1+EKRrQDHeyw/qRxW9yZiEDIs75Ux2elqQrcBvvv9gaC284x7rQT1hvulNE6LQv9zA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2616005)(1076003)(316002)(8936002)(336012)(47076005)(186003)(26005)(426003)(40460700003)(86362001)(83380400001)(7696005)(36756003)(8676002)(81166007)(70206006)(54906003)(4326008)(5660300002)(44832011)(356005)(508600001)(2906002)(70586007)(82310400005)(6666004)(36860700001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 07:44:15.7627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4775fb6-6e63-41f0-dc05-08da47905b41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1713
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
Cc: andrey.grodzovsky@amd.com, jingwen.chen2@amd.com, christian.koenig@amd.com,
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

