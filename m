Return-Path: <SRS0=Y/Ds=M5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A4CC4320A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 05:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B2761104
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 05:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 49B2761104
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAFE56EA73;
	Fri,  6 Aug 2021 05:52:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E176EB04
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Aug 2021 05:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApPb539cNhWbOl+MSYt/r3dKPp8JOjq0jnwRirXYIfI2n4320AR/KnTwt3ZWn+vTI2NkWhYXU7p8PVovMfBTjyvgNYgfOnU2ClNFiLREFtfI3pzMDBM4Hw1ZHWPYIJKwIOxNQogpRIcaG7wXJ379K08i9TvBUPb+qNdIXDSIDR4wrpY5tQlZUO7krU1LdkzrPEBvkNK2CNddaJy8wFF7QeVDpPvkAFbnCysoV1DelG11yC2sUhp6B4tmpEpmfRR5o/dT4yVrzun/0XOl6eo6cPWjEnHAFlGttOcDcKVXm2Bq9vBV/DSun9b+fiU4ftXaed6SKxaHF4rQxd8SSZrKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6nEkuEi/8+6jOZH4WsF/HZVew75P8/TG0jeJvr17WI=;
 b=cRJniAnRXImt7UsS4F5RvvkP8VFPRsFCnW+mhD58HGHrkIzHl4muYVa0GPnkRazY8zGtIIbosz64xJRS9NqEoSQ9mFHpz+2FCMU0sOKezJ3AbW0NP4nU5hMONqbglmGuVo0Jbr+frib1+QvSela6qvq9RJyv+ILGZtzkuzNg/FJta98IZodP4Q4qg3lsQBR9TJoFOZo1YDSGYbH9UVVyEpWdp7L6kBduzdEogBjD0AtWjVf2Ss3mHOBPimMEMmGFGrWEmrdOJQFo2mECgokWQoCpjua2W/SEqniqY4wTPOFuVXv+lPK7Z0LIRp03YDNMpJv9vJzji8boMyiJNxR4rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=hotmail.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6nEkuEi/8+6jOZH4WsF/HZVew75P8/TG0jeJvr17WI=;
 b=gQ9EHEEXvmRZc0MgXjHdRZeewOGswHwNCoest79qvMvMQee1bCiVaIKGI5mX1Cfrtn8toOND3QnIRJJDjznVl4939y2pqP4C7ppYJVcvcxrrclgy+BX4fZpL7skbtGJlcEbQKdhf7HwNPamujyKLA84TjkptPtPcqczUuYkn1Vs=
Received: from DM6PR07CA0049.namprd07.prod.outlook.com (2603:10b6:5:74::26) by
 BYAPR12MB2949.namprd12.prod.outlook.com (2603:10b6:a03:12f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.26; Fri, 6 Aug
 2021 05:52:40 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::43) by DM6PR07CA0049.outlook.office365.com
 (2603:10b6:5:74::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Fri, 6 Aug 2021 05:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; hotmail.com; dkim=none (message not signed)
 header.d=none;hotmail.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 05:52:39 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 6 Aug
 2021 00:52:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 5 Aug
 2021 22:52:39 -0700
Received: from wayne-dev (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12 via Frontend
 Transport; Fri, 6 Aug 2021 00:52:37 -0500
Date: Fri, 6 Aug 2021 13:52:34 +0800
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, <monk.liu@amd.com>,
 <christian.koenig@amd.com>, Jack Zhang <Jack.Zhang7@hotmail.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCHv2 1/2] drm/amd/amdgpu embed hw_fence into amdgpu_job
Message-ID: <20210806054723.gblvo7qa5fqcijfk@wayne-dev>
References: <20210805083146.324741-1-Jingwen.Chen2@amd.com>
 <f3ddf3e1-bbc5-f42f-d9f3-7306ed4b9f69@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3ddf3e1-bbc5-f42f-d9f3-7306ed4b9f69@amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33cd69b3-a1c1-4ec2-85e7-08d9589e669b
X-MS-TrafficTypeDiagnostic: BYAPR12MB2949:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2949585F220B1A01300AEA4CB7F39@BYAPR12MB2949.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:428;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6YMOeaAzLz2C0fTZmDemni+/8r97HJx1UrNGD7PXGM4jCcU38GfJz1WMz3wcwJpKW0qnEyyfvl+mIAn68P/fy6dZuJrj0gZ3bQHeJvI4a/pGODMgFWqzd4lR+lEoNueIkzBWjYqiAKBzDQB9gDixGfsOH45PUfq2M8aJMV0kLAWsoDFn77kYwSfLJq2dembXufCCEod+hMtVjUSN0vSj6IaP5n86YAgpyHOyAsKl+i0REx0FBH3yCWhCop6ZfsL+eyg5AzgZW8WSkiEZ+QLfANIZ+vYqkI8L/DsdzNa877r8wmEjapIStrjmUJyzpi1Q3pYBwaSryJiPI5b8U1mepIStCGG/+Ib2HtyArqc43Gz4nnUql95wVBYnSL6FDu6sO9XtNP3poTngzfxKFP6f/b/vTr9nyFLsBLCYo1EF9A3YFuCyBO7n5AUpFXufJAlKLiGF3wfvg8X3ngM4zyjlzcNlrgKuw3CqsgeFbn0o5QvqfsMUy+vwzQifsKgMZQ+gejwFDqZegiHAhMztAinQec0U3BFT5ZiQ0X42Z4OfGKR9MInmNrpVzdCO5/UAbsG/k/Wr8yyu8Xk2yiDimEs55KQXIXqX1RsAxlasoB+gdhjHGSYUv33k/L+cXs+mam/Vg5NiHPA+m5ESLQmMxg43YuL6C4ade9qepv6rvK6uzjP6EEqKlU6wuKS6mg9KsJK4eJTtiLP3r0BNOi1qFy3/mhIFTbZWp/Re/ItrHU7TEk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(36840700001)(9686003)(55016002)(110136005)(82310400003)(186003)(32650700002)(70206006)(70586007)(6666004)(45080400002)(426003)(478600001)(316002)(2906002)(81166007)(36860700001)(82740400003)(1076003)(53546011)(26005)(33716001)(30864003)(5660300002)(8676002)(8936002)(356005)(336012)(86362001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 05:52:39.8201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cd69b3-a1c1-4ec2-85e7-08d9589e669b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2949
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

On Thu Aug 05, 2021 at 05:13:22PM -0400, Andrey Grodzovsky wrote:
> 
> On 2021-08-05 4:31 a.m., Jingwen Chen wrote:
> > From: Jack Zhang <Jack.Zhang1@amd.com>
> > 
> > Why: Previously hw fence is alloced separately with job.
> > It caused historical lifetime issues and corner cases.
> > The ideal situation is to take fence to manage both job
> > and fence's lifetime, and simplify the design of gpu-scheduler.
> > 
> > How:
> > We propose to embed hw_fence into amdgpu_job.
> > 1. We cover the normal job submission by this method.
> > 2. For ib_test, and submit without a parent job keep the
> > legacy way to create a hw fence separately.
> > v2:
> > use AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT to show that the fence is
> > embeded in a job.
> > 
> > Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> > Signed-off-by: Jack Zhang <Jack.Zhang7@hotmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  1 -
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 63 ++++++++++++++++-----
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 35 ++++++++----
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  4 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  5 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
> >   8 files changed, 84 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > index 7b46ba551cb2..3003ee1c9487 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > @@ -714,7 +714,6 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
> >   	ret = dma_fence_wait(f, false);
> >   err_ib_sched:
> > -	dma_fence_put(f);
> >   	amdgpu_job_free(job);
> >   err:
> >   	return ret;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > index 536005bff24a..277128846dd1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -1414,7 +1414,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
> >   			continue;
> >   		}
> >   		job = to_amdgpu_job(s_job);
> > -		if (preempted && job->fence == fence)
> > +		if (preempted && (&job->hw_fence) == fence)
> >   			/* mark the job as preempted */
> >   			job->preemption_status |= AMDGPU_IB_PREEMPTED;
> >   	}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > index 7495911516c2..5e29d797a265 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > @@ -129,30 +129,46 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
> >    *
> >    * @ring: ring the fence is associated with
> >    * @f: resulting fence object
> > + * @job: job the fence is embeded in
> >    * @flags: flags to pass into the subordinate .emit_fence() call
> >    *
> >    * Emits a fence command on the requested ring (all asics).
> >    * Returns 0 on success, -ENOMEM on failure.
> >    */
> > -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> > +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amdgpu_job *job,
> >   		      unsigned flags)
> >   {
> >   	struct amdgpu_device *adev = ring->adev;
> > -	struct amdgpu_fence *fence;
> > +	struct dma_fence *fence;
> > +	struct amdgpu_fence *am_fence;
> >   	struct dma_fence __rcu **ptr;
> >   	uint32_t seq;
> >   	int r;
> > -	fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_KERNEL);
> > -	if (fence == NULL)
> > -		return -ENOMEM;
> > +	if (job == NULL) {
> > +		/* create a sperate hw fence */
> > +		am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
> > +		if (am_fence == NULL)
> > +			return -ENOMEM;
> > +		fence = &am_fence->base;
> > +		am_fence->ring = ring;
> > +	} else {
> > +		/* take use of job-embedded fence */
> > +		fence = &job->hw_fence;
> > +		job->ring = ring;
> 
> 
> If you would make hw_fence of type amdgpu_fence
> you could probably avoid the special job->ring = ring
> See more in related comment at the bottom
> 
Hi Andry,

I'm only make the amdgpu_fence for the fence without job parameter
provided to amdgpu_fence_emit. For embeded fence which is the hw_fence
in amdgpu_job, it will be allocated along with amdgpu_job as dma_fence.

Regards,
Jingwen Chen
> 
> > +	}
> >   	seq = ++ring->fence_drv.sync_seq;
> > -	fence->ring = ring;
> > -	dma_fence_init(&fence->base, &amdgpu_fence_ops,
> > +	dma_fence_init(fence, &amdgpu_fence_ops,
> >   		       &ring->fence_drv.lock,
> >   		       adev->fence_context + ring->idx,
> >   		       seq);
> > +
> > +	if (job != NULL) {
> > +		/* mark this fence has a parent job */
> > +		set_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &fence->flags);
> > +	}
> > +
> >   	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> >   			       seq, flags | AMDGPU_FENCE_FLAG_INT);
> >   	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
> > @@ -175,9 +191,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> >   	/* This function can't be called concurrently anyway, otherwise
> >   	 * emitting the fence would mess up the hardware ring buffer.
> >   	 */
> > -	rcu_assign_pointer(*ptr, dma_fence_get(&fence->base));
> > +	rcu_assign_pointer(*ptr, dma_fence_get(fence));
> > -	*f = &fence->base;
> > +	*f = fence;
> >   	return 0;
> >   }
> > @@ -621,8 +637,16 @@ static const char *amdgpu_fence_get_driver_name(struct dma_fence *fence)
> >   static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
> >   {
> > -	struct amdgpu_fence *fence = to_amdgpu_fence(f);
> > -	return (const char *)fence->ring->name;
> > +	struct amdgpu_ring *ring;
> > +
> > +	if (test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &f->flags)) {
> > +		struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
> > +
> > +		ring = job->ring;
> > +	} else {
> > +		ring = to_amdgpu_fence(f)->ring;
> > +	}
> 
> 
> Same as above
> 
> 
> > +	return (const char *)ring->name;
> >   }
> >   /**
> > @@ -656,8 +680,20 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
> >   static void amdgpu_fence_free(struct rcu_head *rcu)
> >   {
> >   	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
> > -	struct amdgpu_fence *fence = to_amdgpu_fence(f);
> > -	kmem_cache_free(amdgpu_fence_slab, fence);
> > +
> > +	if (test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &f->flags)) {
> > +	/* free job if fence has a parent job */
> > +		struct amdgpu_job *job;
> > +
> > +		job = container_of(f, struct amdgpu_job, hw_fence);
> > +		kfree(job);
> > +	} else {
> > +	/* free fence_slab if it's separated fence*/
> > +		struct amdgpu_fence *fence;
> > +
> > +		fence = to_amdgpu_fence(f);
> > +		kmem_cache_free(amdgpu_fence_slab, fence);
> > +	}
> >   }
> >   /**
> > @@ -680,6 +716,7 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
> >   	.release = amdgpu_fence_release,
> >   };
> > +
> >   /*
> >    * Fence debugfs
> >    */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > index ec65ab0ddf89..c076a6b9a5a2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > @@ -262,7 +262,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
> >   				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
> >   	}
> > -	r = amdgpu_fence_emit(ring, f, fence_flags);
> > +	r = amdgpu_fence_emit(ring, f, job, fence_flags);
> >   	if (r) {
> >   		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
> >   		if (job && job->vmid)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > index d33e6d97cc89..65a395060de2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -127,11 +127,16 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
> >   {
> >   	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
> >   	struct dma_fence *f;
> > +	struct dma_fence *hw_fence;
> >   	unsigned i;
> > -	/* use sched fence if available */
> > -	f = job->base.s_fence ? &job->base.s_fence->finished : job->fence;
> > +	if (job->hw_fence.ops == NULL)
> > +		hw_fence = job->external_hw_fence;
> > +	else
> > +		hw_fence = &job->hw_fence;
> > +	/* use sched fence if available */
> > +	f = job->base.s_fence ? &job->base.s_fence->finished : hw_fence;
> >   	for (i = 0; i < job->num_ibs; ++i)
> >   		amdgpu_ib_free(ring->adev, &job->ibs[i], f);
> >   }
> > @@ -142,20 +147,27 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
> >   	drm_sched_job_cleanup(s_job);
> > -	dma_fence_put(job->fence);
> >   	amdgpu_sync_free(&job->sync);
> >   	amdgpu_sync_free(&job->sched_sync);
> > -	kfree(job);
> > +
> > +    /* only put the hw fence if has embedded fence */
> > +	if (job->hw_fence.ops != NULL)
> > +		dma_fence_put(&job->hw_fence);
> > +	else
> > +		kfree(job);
> >   }
> >   void amdgpu_job_free(struct amdgpu_job *job)
> >   {
> >   	amdgpu_job_free_resources(job);
> > -
> > -	dma_fence_put(job->fence);
> >   	amdgpu_sync_free(&job->sync);
> >   	amdgpu_sync_free(&job->sched_sync);
> > -	kfree(job);
> > +
> > +	/* only put the hw fence if has embedded fence */
> > +	if (job->hw_fence.ops != NULL)
> > +		dma_fence_put(&job->hw_fence);
> > +	else
> > +		kfree(job);
> >   }
> >   int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
> > @@ -184,11 +196,14 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
> >   	job->base.sched = &ring->sched;
> >   	r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, NULL, fence);
> > -	job->fence = dma_fence_get(*fence);
> > +	/* record external_hw_fence for direct submit */
> > +	job->external_hw_fence = dma_fence_get(*fence);
> >   	if (r)
> >   		return r;
> >   	amdgpu_job_free(job);
> > +	dma_fence_put(*fence);
> > +
> >   	return 0;
> >   }
> > @@ -246,10 +261,8 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
> >   		if (r)
> >   			DRM_ERROR("Error scheduling IBs (%d)\n", r);
> >   	}
> > -	/* if gpu reset, hw fence will be replaced here */
> > -	dma_fence_put(job->fence);
> > -	job->fence = dma_fence_get(fence);
> > +	dma_fence_get(fence);
> >   	amdgpu_job_free_resources(job);
> >   	fence = r ? ERR_PTR(r) : fence;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > index 81caac9b958a..92324c978534 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > @@ -46,7 +46,9 @@ struct amdgpu_job {
> >   	struct amdgpu_sync	sync;
> >   	struct amdgpu_sync	sched_sync;
> >   	struct amdgpu_ib	*ibs;
> > -	struct dma_fence	*fence; /* the hw fence */
> > +	struct dma_fence	hw_fence;
> > +	struct amdgpu_ring *ring;
> 
> Why not instead of 2 fields above just embed   struct amdgpu_fence as
> hw_fence  and by this save the extra 'ring' field handling ?
> 
> Andrey
> 
> 
> > +	struct dma_fence	*external_hw_fence;
> >   	uint32_t		preamble_status;
> >   	uint32_t                preemption_status;
> >   	uint32_t		num_ibs;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > index 9c11ced4312c..03d4b29a76d6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -48,6 +48,9 @@
> >   #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
> >   #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
> > +/* fence flag bit to indicate the face is embeded in job*/
> > +#define AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT		(DMA_FENCE_FLAG_USER_BITS + 1)
> > +
> >   #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
> >   #define AMDGPU_IB_POOL_SIZE	(1024 * 1024)
> > @@ -118,7 +121,7 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
> >   void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
> >   int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
> >   void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
> > -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence,
> > +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence, struct amdgpu_job *job,
> >   		      unsigned flags);
> >   int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
> >   			      uint32_t timeout);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > index 2a88ed5d983b..2af8860d74cc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -1218,7 +1218,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> >   		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
> >   	if (vm_flush_needed || pasid_mapping_needed) {
> > -		r = amdgpu_fence_emit(ring, &fence, 0);
> > +		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
> >   		if (r)
> >   			return r;
> >   	}
