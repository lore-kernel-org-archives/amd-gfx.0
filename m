Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F321CC6377D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 15:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25AD61009
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 15:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25AD61009
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CBA76E872;
	Thu, 22 Jul 2021 15:08:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B11E6E872
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 15:08:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSOtmYCBAy2Ldf6MAiFeu4F+tT+FkeUoroE5MtclK/50uO0IhDiZTsxJTVSA5Kd9LeLTbhUnErIuZfQh4Fld/xez/3LgCJFel0QpPKcDswFFXFYAUwIy09idrdDIkfpDrNbZmviu+X/10rSzP4VKtITxZHZv64bzvGgTRT9Pa3lMPdn9tqQzVBQEc2XFXhjv94oFjr8cUve0OSCoVjM9M9RyjGgEBLHAlXl5l/hWi8fBj6nqEPMwtNGQLj83UiOHxrDgaQLRzpzzwvy9tRcl9c8yl52UUqi6lB369t81Ct64cr89WKu0fEqwzhC03R2g3isZkXfOBJe4NEtHKcxs4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jquz86MNTvSm2DpbcMyTxleZCiA1n6egln6YHQxAvsg=;
 b=l6mubQstYEVa5dipGK1GBf+IowYYAIVxr9lkORrIX2glwkQYTk90Zj648OoGCmYHygkeN/G8ADnKhYr7d0p9veSXoVMevZh8lTqdd0unxfM2GzQBbBPTpjiucHer3rjeezIaBr10DGfQoHJsLcNggu8VgOp0Jq7i06DyQ9qND4vRzYuQV1QD3NVseqmGlRwC8anM9HI2eyAskds5YfZwpw1sgyl/QMdbSQst1+X1tiExeO/vRTCEuAGQnxx66IBp6rj5/0dqAzPRfCkwY7yNtaTBZN3HS9q15gmDdBssjkzA0j6Au9lparipsb/MyXuJNICqWfATikoTohzO3IR3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jquz86MNTvSm2DpbcMyTxleZCiA1n6egln6YHQxAvsg=;
 b=BrZljdHvei1PsXP20KagKASlPqbCuPGXAcMe4+MHjZVQoBHRo7VyrvI9SePnOTzRR+DkzpFntlCuKnKvyLhNWpHdUyyAODk1FYARX1+r1h36iPaw9BHP+Xxtmpx7fGoWBeCk/mIUXAuv15Tp9c4+Q9px+8NzGoZRxQcvyG9KRZg=
Received: from BN9P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::6)
 by DM8PR12MB5446.namprd12.prod.outlook.com (2603:10b6:8:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Thu, 22 Jul
 2021 15:08:51 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e::4) by BN9P220CA0001.outlook.office365.com
 (2603:10b6:408:13e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Thu, 22 Jul 2021 15:08:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 15:08:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Jul
 2021 10:08:50 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Jul
 2021 10:08:50 -0500
Received: from wayne-build (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 22 Jul 2021 10:08:48 -0500
Date: Thu, 22 Jul 2021 23:08:47 +0800
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm: add tdr support for embeded hw_fence
Message-ID: <20210722150847.26pq2y34hwbsoifd@wayne-build>
References: <20210721031352.413888-1-Jingwen.Chen2@amd.com>
 <20210721031352.413888-2-Jingwen.Chen2@amd.com>
 <36f53a64-2d9c-947b-a5fb-21d9fc06c5e4@amd.com>
 <20210722104525.okcnb43goxg6uqej@wayne-build>
 <0699ff85-4aec-0e33-711b-665307fbbc24@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0699ff85-4aec-0e33-711b-665307fbbc24@amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2721dfb0-3646-45e6-d6e3-08d94d229d1f
X-MS-TrafficTypeDiagnostic: DM8PR12MB5446:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5446695FCBA481AF3D2DD0D2B7E49@DM8PR12MB5446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJlNV0w2tL+m7GNFPhDtS/FvCkpN97PYrHFcVZMJJYOz3UMOFhH8h+0CFhUihzvnNKo9Jevm1iwFPlWlzj0XwB9Cur/BLenrDfs/JXvC+Qkxjt+S9q3MYAeK3DCIxhq7reWrrSg8GFcDqEv2tfLIsQ1lBvGJkhEPUC1HS/Ku7d7rc/CAQysPzyenby9THVEYW11wGS+KgbKh+jiq59GBsrcqBR7WMp2b2U33EINr78PYC59G9ETyOwfSnyu6OaUJuvIgjMDXNt+E9sp0C3LH0uMnWO6MX6PU+wrEdQctxJambdkjEtdTyovYQWvNhcJM7Sqe+AdzLp2Akwpimz81sTstJm+mOU2f5L9SNdWSSUqiv1X8D7oAvzBhOWgQYOddOySj8dN6c/JE0pfYtPcLywcLDIOWVhypfUeovkiqVAqQF6LBZzdElgXja/Ax/XQvD7G4nyZ9u1kAsxjUSXHLrPOBoRx3gRCae5c2GjIgNXPeJ7uGy4o2oCvH1W928M8uowH2R6OH8Pyrm0P+Id6828hIF44RYSwGgDKw1o3WKKJi7LvRPY4h0UAkCRSITOcWZRFwxCljSEc+GZx4T7WODiAGpzMiarbSV1eM7GxvBCBwFIkbhauSkmVFoXSk/V1n1dpvTzwQ7OOluo8+QvHeARRt0B1P0w1552m93IzJEQaBd4FVWCynxPKEZrroc45tkMzEgQ0tXeHAFmA48qc71NgX3MFPZYc+QptAVcXC5AX4U0kt0NyNfodjXV4II87l
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39850400004)(36840700001)(46966006)(186003)(26005)(5660300002)(70586007)(53546011)(426003)(110136005)(86362001)(82740400003)(336012)(83380400001)(2906002)(4326008)(316002)(356005)(54906003)(70206006)(82310400003)(478600001)(81166007)(9686003)(1076003)(47076005)(36860700001)(33716001)(55016002)(8936002)(8676002)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 15:08:50.9432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2721dfb0-3646-45e6-d6e3-08d94d229d1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5446
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
Cc: ckoenig.leichtzumerken@gmail.com, horace.chen@amd.com,
 "jingwen.chen2@amd.com Jack Zhang" <Jack.Zhang1@amd.com>, monk.liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu Jul 22, 2021 at 10:45:40AM -0400, Andrey Grodzovsky wrote:
> 
> On 2021-07-22 6:45 a.m., Jingwen Chen wrote:
> > On Wed Jul 21, 2021 at 12:53:51PM -0400, Andrey Grodzovsky wrote:
> > > On 2021-07-20 11:13 p.m., Jingwen Chen wrote:
> > > > [Why]
> > > > After embeded hw_fence to amdgpu_job, we need to add tdr support
> > > > for this feature.
> > > > 
> > > > [How]
> > > > 1. Add a resubmit_flag for resubmit jobs.
> > > > 2. Clear job fence from RCU and force complete vm flush fences in
> > > >      pre_asic_reset
> > > > 3. skip dma_fence_get for resubmit jobs and add a dma_fence_put
> > > >      for guilty jobs.
> > > > 
> > > > Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> > > > Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> > > > ---
> > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++-
> > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 16 +++++++++++-----
> > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  4 +++-
> > > >    drivers/gpu/drm/scheduler/sched_main.c     |  1 +
> > > >    include/drm/gpu_scheduler.h                |  1 +
> > > >    5 files changed, 27 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > index 40461547701a..fe0237f72a09 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > @@ -4382,7 +4382,7 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
> > > >    int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
> > > >    				 struct amdgpu_reset_context *reset_context)
> > > >    {
> > > > -	int i, r = 0;
> > > > +	int i, j, r = 0;
> > > >    	struct amdgpu_job *job = NULL;
> > > >    	bool need_full_reset =
> > > >    		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
> > > > @@ -4406,6 +4406,16 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
> > > >    		if (!ring || !ring->sched.thread)
> > > >    			continue;
> > > > +		/*clear job fence from fence drv to avoid force_completion
> > > > +		 *leave NULL and vm flush fence in fence drv */
> > > > +		for (j = 0; j <= ring->fence_drv.num_fences_mask; j ++) {
> > > > +			struct dma_fence *old,**ptr;
> > > > +			ptr = &ring->fence_drv.fences[j];
> > > > +			old = rcu_dereference_protected(*ptr, 1);
> > > > +			if (old && test_bit(DMA_FENCE_FLAG_USER_BITS, &old->flags))) {
> > > > +				RCU_INIT_POINTER(*ptr, NULL);
> > > > +			}
> > > 
> > > Is this to avoid premature job free because of dma_fence_put inside
> > > amdgpu_fence_process ?
> > > I can't currently remember why but we probably want all the HW fences
> > > currently in the ring to
> > > be forced signaled - maybe better to test for DMA_FENCE_FLAG_USER_BITS
> > > inside amdgpu_fence_process
> > > and still do the signaling but not the dma_fence_put part
> > > 
> > > Andrey
> > Hi Andrey,
> > 
> > This is to avoid signaling the same fence twice. If we still do the
> > signaling, then the job in the pending list will be signaled first in
> > force_completion, and later be signaled in resubmit. This will go to
> > BUG() in amdgpu_fence_process.
> 
> 
> Oh, i see, how about just adding 'skip' flag to amdgpu_ring and setting it
> before calling
> amdgpu_fence_driver_force_completion and resetting it after, then inside
> amdgpu_fence_driver_force_completion
> you can just skip the signaling part with this flag for fences with
> DMA_FENCE_FLAG_USER_BITS set
> Less lines of code at least.
> 
> Andrey
Hi Andrey,

In this way, this issue still exists. If we just skip it in the
force_completion, these fences are still in the RCU fence array. So when
the FLR finishes, the eop interrupt function of ib_test will call
amdgpu_fence_process, the skipped fences will be signaled along with
ib_test fences and signaled again during resubmission.


Best Regards,
JingWen Chen
> 
> > 
> > > > +		}
> > > >    		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
> > > >    		amdgpu_fence_driver_force_completion(ring);
> > > >    	}
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > index eecf21d8ec33..815776c9a013 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > @@ -156,11 +156,17 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
> > > >    		job->ring = ring;
> > > >    	}
> > > > -	seq = ++ring->fence_drv.sync_seq;
> > > > -	dma_fence_init(fence, &amdgpu_fence_ops,
> > > > -		       &ring->fence_drv.lock,
> > > > -		       adev->fence_context + ring->idx,
> > > > -		       seq);
> > > > +	if (job != NULL && job->base.resubmit_flag == 1) {
> > > > +		/* reinit seq for resubmitted jobs */
> > > > +		seq = ++ring->fence_drv.sync_seq;
> > > > +		fence->seqno = seq;
> > > > +	} else {
> > > > +		seq = ++ring->fence_drv.sync_seq;
> > > 
> > > Seems like you could do the above line only once above if-else as it was
> > > before
> > Sure, I will modify this.
> > 
> > 
> > Best Regards,
> > JingWen Chen
> > > > +		dma_fence_init(fence, &amdgpu_fence_ops,
> > > > +				&ring->fence_drv.lock,
> > > > +				adev->fence_context + ring->idx,
> > > > +				seq);
> > > > +	}
> > > >    	if (job != NULL) {
> > > >    		/* mark this fence has a parent job */
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > index 7c426e225b24..d6f848adc3f4 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > @@ -241,6 +241,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
> > > >    		dma_fence_set_error(finished, -ECANCELED);/* skip IB as well if VRAM lost */
> > > >    	if (finished->error < 0) {
> > > > +		dma_fence_put(&job->hw_fence);
> > > >    		DRM_INFO("Skip scheduling IBs!\n");
> > > >    	} else {
> > > >    		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
> > > > @@ -249,7 +250,8 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
> > > >    			DRM_ERROR("Error scheduling IBs (%d)\n", r);
> > > >    	}
> > > > -	dma_fence_get(fence);
> > > > +	if (!job->base.resubmit_flag)
> > > > +		dma_fence_get(fence);
> > > >    	amdgpu_job_free_resources(job);
> > > >    	fence = r ? ERR_PTR(r) : fence;
> > > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> > > > index f4f474944169..5a36ab5aea2d 100644
> > > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > > @@ -544,6 +544,7 @@ void drm_sched_resubmit_jobs_ext(struct drm_gpu_scheduler *sched, int max)
> > > >    			dma_fence_set_error(&s_fence->finished, -ECANCELED);
> > > >    		dma_fence_put(s_job->s_fence->parent);
> > > > +		s_job->resubmit_flag = 1;
> > > >    		fence = sched->ops->run_job(s_job);
> > > >    		i++;
> > > > diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> > > > index 4ea8606d91fe..06c101af1f71 100644
> > > > --- a/include/drm/gpu_scheduler.h
> > > > +++ b/include/drm/gpu_scheduler.h
> > > > @@ -198,6 +198,7 @@ struct drm_sched_job {
> > > >    	enum drm_sched_priority		s_priority;
> > > >    	struct drm_sched_entity         *entity;
> > > >    	struct dma_fence_cb		cb;
> > > > +	int resubmit_flag;
> > > >    };
> > > >    static inline bool drm_sched_invalidate_job(struct drm_sched_job *s_job,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
