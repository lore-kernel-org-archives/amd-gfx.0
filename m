Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB86AC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 17:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1039710F4C2;
	Wed, 13 Jul 2022 17:14:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A0610F241
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 17:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qy6x91d8srt1WTjcbz+fccCYRMzGH1K1w0upAjyG3uHRyJeUiLYUxucYw/xQzaEWYZorScI5R9SxsWwmVywlDRQr933nN7ROHLBoHgS/KFTQ/DL21YUCSh/xa0Ml0nwux1EsH6wfcGtfuUGCA6HMIwAWDoaVNFB3O3eELHt4f8fnkhsvPUGOiQHszxuhN+52bZw/Wi+WMGwaxzO5M8catTsodANFengEkLc6ImloW30kLLzr+ntl6FCmNHEHQ1iHxltWg+TUAZ+YRgv3fDlprmMlX025G8ig7MzktajeXw2QvZTu/jnrttmLA4ONfsZKZTk+XOmBJhIhwR43VpCCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiDe0NAcG7cOawPbC365N2tsZTng3lRtXhPoZHhHLaY=;
 b=DYmCzJwtxxj5So/f+UtYUKCm/1yWI9+CV8MzM27EKfC7YGTbelFwQg9nXD3wV78RNlYxJGsdMiNxfnJlwbD1OAxtWdPrJenXuPCyukl7wOO/O2gGFt0fLs10L77w0yK3gNRqSHZRCbu//WnSbBUq19qq8PiZyhQxCAdc38nv7G8FRGa0OaQho0Ynlu/9tLCNVsgSGNgdmtIILHM1aL2EyxKl9cf3OK+IHMZ5s0DT9dgdEoFY1PsjoqI9H9P495jaWoNblVX52iQ0OrjEB7MvCLUZrqXkJsVRbQg4KQesaX/KTZ6o5pqVc34a/UJDzig1REsLLHy3EAaiVSfoBWfFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiDe0NAcG7cOawPbC365N2tsZTng3lRtXhPoZHhHLaY=;
 b=e2/Ta6CxM3IpJ4ju7qlPOzaxFE4gSQeQmf8McSe2aBJmyfjsFhjWIBlLQuWZi7I+PDdH7gVdvCUFoOKtY5x0nqgh2plOY+CcAnNqZHO7C+BJ3kIKxQSgxCdHYYNGoS6T9ks+LwTH0etilsTBUvUtkxQEX4efzOpJNZo981hstZs=
Received: from BN8PR03CA0017.namprd03.prod.outlook.com (2603:10b6:408:94::30)
 by DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Wed, 13 Jul
 2022 17:13:55 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::49) by BN8PR03CA0017.outlook.office365.com
 (2603:10b6:408:94::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23 via Frontend
 Transport; Wed, 13 Jul 2022 17:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 17:13:55 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 13 Jul 2022 12:13:54 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Get rid of amdgpu_job->external_hw_fence
Date: Wed, 13 Jul 2022 13:13:40 -0400
Message-ID: <20220713171340.495314-1-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f57b8bf0-f56e-4460-df14-08da64f3112b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2485:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dY984rB6kculXm1IDAg8ioTXMXLtXL3M1l2k6IGhSGJ8a/KNeIY0RIFOzTXVz103TyZsp1l1bQCWOSq1tXHHx9SzDhK7Da5s5nulA9SUj75orkIFzf3yCUrvoAlhq1jgG4cmlcY+89fqi+1O1Fjgeb5ewM6lmWDeLANM3J93e7lSi/3c0RuP3ezq/FTTvpl6gxg/1scYxAIz8VxnGyODszcK82rEdnRu+TMvv38VKs08myuwt1OHqlYlWayl6WSAqp6yJT+XV/3D0EnH9ul2QMw0UoeWlIZUF0yhbam8DvF4lvoBxJZiXyGFf83PNXmsl3SbaPz1quamkf2KYcvPMsdRIeerLyhJf8m4tfW1HMUVqxlMhHGyCeQJZZccEB378AiPbmca42vfPnU4KfeEDsVIwmsb0X9mEPFrt1o1r15nb3LJrqU95DOAcY8qfHjyjkuq5NaI1YXyIMo3VNdntvfiOEjIoIlxD3PxbJRXFWuV0vZSMKfRpkJQa1UtW3JkhWTw8JYhUbdsVt3vaV3aSQQ2Mt/2uD0NBxEiGJg1Ymosgrq1APeXgZRNLFn2ieXoiOlIJcP4M+eqi8gC+D42ad0WVBcp9bDSvOL6rXlxfWWnq3whB1Jz/X0uJF25WtruI/z6hnU3VPY8yYslxe7iw+CLMS5cqi0EQwjkqwnytiTqu5KFXD/u9yNs2nozgplik63xO1A73johaPu3mOtop7XWvCGTObhFHuAc8TjE49Wpfg093gh675W9ixdjrGUrfPWiuixDaVxRiqAZ3I3bMe9SGer3GKObTJrePcbJ3DRA2KGZdSLirW/lIkjZOJYTy7BBKjsOgtFdoWCJoQFEIWB+Rxvftm4yuSS76O3fziRNxDsk+W3l4lhYQtNAIm6grDiXoHHexEFsQodlyytw+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(396003)(346002)(39860400002)(40470700004)(46966006)(36840700001)(5660300002)(81166007)(2906002)(44832011)(4326008)(36756003)(70586007)(966005)(70206006)(8936002)(86362001)(40480700001)(8676002)(316002)(54906003)(40460700003)(82310400005)(36860700001)(6916009)(26005)(356005)(478600001)(186003)(47076005)(41300700001)(336012)(66574015)(2616005)(426003)(6666004)(16526019)(82740400003)(83380400001)(7696005)(1076003)(26583001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 17:13:55.3639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f57b8bf0-f56e-4460-df14-08da64f3112b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, jingwen.chen2@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a follow-up cleanup to [1]. See bellow refcount balancing
for calling amdgpu_job_submit_direct after this cleanup as far
as I calculated.

amdgpu_fence_emit
	dma_fence_init 1
	dma_fence_get(fence) 2
	rcu_assign_pointer(*ptr, dma_fence_get(fence) 3

---> amdgpu_job_submit_direct completes before fence signaled
			amdgpu_sa_bo_free
				(*sa_bo)->fence = dma_fence_get(fence) 4

			amdgpu_job_free
				dma_fence_put 3

			amdgpu_vcn_enc_get_destroy_msg
				*fence = dma_fence_get(f) 4
				dma_fence_put(f); 3

			amdgpu_vcn_enc_ring_test_ib
				dma_fence_put(fence) 2

			amdgpu_fence_process
				dma_fence_put 1

			amdgpu_sa_bo_remove_locked
				dma_fence_put 0

---> amdgpu_job_submit_direct completes after fence signaled
			amdgpu_fence_process
				dma_fence_put 2

			amdgpu_job_free
				dma_fence_put 1

			amdgpu_vcn_enc_get_destroy_msg
				*fence = dma_fence_get(f) 2
				dma_fence_put(f); 1

			amdgpu_vcn_enc_ring_test_ib
				dma_fence_put(fence) 0

[1] - https://patchwork.kernel.org/project/dri-devel/cover/20220624180955.485440-1-andrey.grodzovsky@amd.com/

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 27 ++++------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  1 -
 3 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 16faea7ed1cd..b79ee4ffb879 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5229,8 +5229,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 *
 	 * job->base holds a reference to parent fence
 	 */
-	if (job && (job->hw_fence.ops != NULL) &&
-	    dma_fence_is_signaled(&job->hw_fence)) {
+	if (job && dma_fence_is_signaled(&job->hw_fence)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
 		goto skip_hw_reset;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 6fa381ee5fa0..10fdd12cf853 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -134,16 +134,10 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
 	struct dma_fence *f;
-	struct dma_fence *hw_fence;
 	unsigned i;
 
-	if (job->hw_fence.ops == NULL)
-		hw_fence = job->external_hw_fence;
-	else
-		hw_fence = &job->hw_fence;
-
 	/* use sched fence if available */
-	f = job->base.s_fence ? &job->base.s_fence->finished : hw_fence;
+	f = job->base.s_fence ? &job->base.s_fence->finished :  &job->hw_fence;
 	for (i = 0; i < job->num_ibs; ++i)
 		amdgpu_ib_free(ring->adev, &job->ibs[i], f);
 }
@@ -157,11 +151,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 	amdgpu_sync_free(&job->sync);
 	amdgpu_sync_free(&job->sched_sync);
 
-    /* only put the hw fence if has embedded fence */
-	if (job->hw_fence.ops != NULL)
-		dma_fence_put(&job->hw_fence);
-	else
-		kfree(job);
+	dma_fence_put(&job->hw_fence);
 }
 
 void amdgpu_job_free(struct amdgpu_job *job)
@@ -170,11 +160,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
 	amdgpu_sync_free(&job->sync);
 	amdgpu_sync_free(&job->sched_sync);
 
-	/* only put the hw fence if has embedded fence */
-	if (job->hw_fence.ops != NULL)
-		dma_fence_put(&job->hw_fence);
-	else
-		kfree(job);
+	dma_fence_put(&job->hw_fence);
 }
 
 int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
@@ -204,15 +190,12 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
 	int r;
 
 	job->base.sched = &ring->sched;
-	r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, NULL, fence);
-	/* record external_hw_fence for direct submit */
-	job->external_hw_fence = dma_fence_get(*fence);
+	r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job, fence);
+
 	if (r)
 		return r;
 
 	amdgpu_job_free(job);
-	dma_fence_put(*fence);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index d599c0540b46..babc0af751c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -50,7 +50,6 @@ struct amdgpu_job {
 	struct amdgpu_sync	sync;
 	struct amdgpu_sync	sched_sync;
 	struct dma_fence	hw_fence;
-	struct dma_fence	*external_hw_fence;
 	uint32_t		preamble_status;
 	uint32_t                preemption_status;
 	bool                    vm_needs_flush;
-- 
2.25.1

