Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA54EC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 03:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A43360ED8
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 03:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A43360ED8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFED689E33;
	Tue, 10 Aug 2021 03:25:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F20D689E33
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 03:25:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rydt0BBCLNAl2uA2sPqpAeFPXjacbmX+wzZvCC7jARO+glzoT9YTSZi+XCV1LO3TOOrH6PkV3DMKDvEGvhn5bXKzf4x7y98dN+t24HcSfAGeBeUre0ERr+mqmlrl26jiVgAK+Wvj1VHjwlGiCQSmyleuhIffmqBHlwY/kwRdeBIbaRR24eWx6UX6kCSFiDhM9kU3PVSkxkZLNuhtbRUEVtoPWSudL/KxNXVyEqTCEEHnvXcTXPsiahZQB855ZSszMFEkRqbNA32nb/cPMyc/XcWBbGfqXVr0po92Z5Uk3JxaKbgAtMbZUSaY/kgBAnITkcWb56kppDc4BvG/vUDtJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wy9TN4Ao38lQcQ1xuiwZoSE3pncBgbXe209BeRulmW4=;
 b=gQ0oXQYJ6l2aZnorS/AeQiRbAycizaD1vxAzp6Omj9EISbINR/oLcOE7S5/UQxAfeaWaAH42mIOnmZE0J9oXI4F+EOe68doQi+vofzfXZsAslzK/8LjtJXie6PL1RTqZuyOlacNKl0SoBlO6HX3O6tps0dncWbZTmpDQ0AR3Wfm5OOAi6H0nhUO2x2FtmRBkqUbrF7OpQfGLlxl86psnxLAP5UsjhOzVDgQBk81RwZthBwIU5MZWerrA4melcGE8NxF71sNWiALKDSFBSLgq4DiDmkmKewL0k02QKx9e6s0XX0QhSGUuzp3o1RwVeyAhtEjxxDaBSsm2C0w2f+izog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wy9TN4Ao38lQcQ1xuiwZoSE3pncBgbXe209BeRulmW4=;
 b=rYhxX1w7AXaBQYYQVC0trMOKeRO8pQM7ef+2SvpUOPZZBd6Efxaa+eYHDTO32XVX6NjplAXTJwUJLf0Lp3fCmXkgc7ndb+4/6ixzytfwca0p++Nha/HnKfV3Rzti6kksr1HAY2HikpXGlJabWre4PnqbBiDi6j6Wd3+8vBXTCBc=
Received: from MWHPR20CA0031.namprd20.prod.outlook.com (2603:10b6:300:ed::17)
 by BY5PR12MB5510.namprd12.prod.outlook.com (2603:10b6:a03:1d2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 10 Aug
 2021 03:25:46 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::3f) by MWHPR20CA0031.outlook.office365.com
 (2603:10b6:300:ed::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend
 Transport; Tue, 10 Aug 2021 03:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 03:25:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 9 Aug
 2021 22:25:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 9 Aug
 2021 22:25:45 -0500
Received: from wayne-dev (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Mon, 9 Aug 2021 22:25:43 -0500
Date: Tue, 10 Aug 2021 11:25:42 +0800
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <monk.liu@amd.com>, <christian.koenig@amd.com>, Jack Zhang
 <Jack.Zhang7@hotmail.com>
Subject: Re: [PATCHv2 2/2] drm/amd/amdgpu: add tdr support for embeded hw_fence
Message-ID: <20210810032542.is4uztvdyjt5ni62@wayne-dev>
References: <20210805083146.324741-1-Jingwen.Chen2@amd.com>
 <20210805083146.324741-2-Jingwen.Chen2@amd.com>
 <f6c8da78-c925-e9a4-3591-0c27132962f3@amd.com>
 <20210810025117.cicf5icoesgzntky@wayne-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210810025117.cicf5icoesgzntky@wayne-dev>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5fcdd53-d577-4bf8-0b79-08d95bae8aff
X-MS-TrafficTypeDiagnostic: BY5PR12MB5510:
X-Microsoft-Antispam-PRVS: <BY5PR12MB5510DB9F8D7E81AC1577A2A2B7F79@BY5PR12MB5510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZOEnQWKNdQWLrR2+3Q4LxIz9gBf+hh/RuBqbMzPQ1xZSSt16HX5EUmoUz3TE8cJK5NhRKAWKEmRiPl0jrO4yTYzhE9pl2gUMnHW6CmOaiO00T480daZp0sV9eC5SK5BV0WgaB2WOzsXdpQgJHCUqQs9pZ0odgaR7sFu94qo02UeLBSEx0MaIcOkWt0Z4JuQ2z6mq4JnuM6rsZYPgsBu32uvIayMqQBlli1gf5F7eY1nqSlCUxZjy434Eg1OeDwMg+PC9WBlwAyVNiX0n+UHtI+aAvL5frV9BH+t/kzINhhI/gKcdCzkgVxj5XvrJUEOpGjzqdhWkjGYU/sDT8Yi9lqxClB1f3mh5EMs/ZTsujWgVp1LoJa49CFQyYvd7/djfEiVL0BXlo626D2qmVFlg7ZdEcTHbMNUt4zdCzD1Zo3T2Dfez3dD+zgPBjVbZqa4zrwWcDQXVWLcythDQjrKEYyFve4sY8Qg/ieomzyC/aaS847I1uODR7p8f2RgCovW221HWZN1MVGcor537P8YCS2ASaxDqCVRHHdQplJNE0Jnu4rTrKqNWnzV3ZRu6vPMKqyap4rzEIVzclpVFhcrgtKP9BCBEf2iamByoWwBIaQZJDXbBNwAqKbAvXg4sw5ml3ijIYawzRu4+6qFAdDkJI4tx6iPx0D1Q5ECCQm9Lwzhk4/9Evs6/cg91TPDib+EwJRBAJMj5y6ffvLAibb1D9kvNIXafgY1HWZ7GoeBzmZKTovVv0XX+d0d0S9VKE1ivb1zmpkWA1nS9qLDEEk7b1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(84040400005)(36840700001)(53546011)(478600001)(1076003)(356005)(32650700002)(82310400003)(9686003)(70586007)(70206006)(45080400002)(83380400001)(8676002)(55016002)(426003)(34020700004)(81166007)(82740400003)(5660300002)(26005)(33716001)(316002)(36860700001)(2906002)(110136005)(336012)(54906003)(4326008)(86362001)(186003)(8936002)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 03:25:46.2384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fcdd53-d577-4bf8-0b79-08d95bae8aff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5510
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

Hi Andrey,

The latest patch [PATCH v4] drm/amd/amdgpu embed hw_fence into
amdgpu_job has been sent to amd-gfx. can you help review this patch?

Best Regards,
Jingwen
On Tue Aug 10, 2021 at 10:51:17AM +0800, Jingwen Chen wrote:
> On Mon Aug 09, 2021 at 12:24:37PM -0400, Andrey Grodzovsky wrote:
> > 
> > On 2021-08-05 4:31 a.m., Jingwen Chen wrote:
> > > [Why]
> > > After embeded hw_fence to amdgpu_job, we need to add tdr support
> > > for this feature.
> > > 
> > > [How]
> > > 1. Add a resubmit_flag for resubmit jobs.
> > > 2. Clear job fence from RCU and force complete vm flush fences in
> > >     pre_asic_reset
> > > 3. skip dma_fence_get for resubmit jobs and add a dma_fence_put
> > >     for guilty jobs.
> > > v2:
> > > use a job_run_counter in amdgpu_job to replace the resubmit_flag in
> > > drm_sched_job. When the job_run_counter >= 1, it means this job is a
> > > resubmit job.
> > > 
> > > Signed-off-by: Jack Zhang <Jack.Zhang7@hotmail.com>
> > > Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++-
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 13 +++++++++----
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  5 ++++-
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  3 +++
> > >   4 files changed, 27 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > index 9e53ff851496..ade2fa07a50a 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -4447,7 +4447,7 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
> > >   int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
> > >   				 struct amdgpu_reset_context *reset_context)
> > >   {
> > > -	int i, r = 0;
> > > +	int i, j, r = 0;
> > >   	struct amdgpu_job *job = NULL;
> > >   	bool need_full_reset =
> > >   		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
> > > @@ -4471,6 +4471,16 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
> > >   		if (!ring || !ring->sched.thread)
> > >   			continue;
> > > +		/*clear job fence from fence drv to avoid force_completion
> > > +		 *leave NULL and vm flush fence in fence drv */
> > > +		for (j = 0; j <= ring->fence_drv.num_fences_mask; j ++) {
> > > +			struct dma_fence *old,**ptr;
> > > +			ptr = &ring->fence_drv.fences[j];
> > > +			old = rcu_dereference_protected(*ptr, 1);
> > > +			if (old && test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &old->flags)) {
> > > +				RCU_INIT_POINTER(*ptr, NULL);
> > > +			}
> > > +		}
> > >   		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
> > >   		amdgpu_fence_driver_force_completion(ring);
> > >   	}
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > index 5e29d797a265..c9752cf794fb 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > @@ -159,10 +159,15 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
> > >   	}
> > >   	seq = ++ring->fence_drv.sync_seq;
> > > -	dma_fence_init(fence, &amdgpu_fence_ops,
> > > -		       &ring->fence_drv.lock,
> > > -		       adev->fence_context + ring->idx,
> > > -		       seq);
> > > +	if (job != NULL && job->job_run_counter) {
> > > +		/* reinit seq for resubmitted jobs */
> > > +		fence->seqno = seq;
> > > +	} else {
> > > +		dma_fence_init(fence, &amdgpu_fence_ops,
> > > +				&ring->fence_drv.lock,
> > > +				adev->fence_context + ring->idx,
> > > +				seq);
> > > +	}
> > 
> > 
> > I think this should be in the first patch actually (and the counter too),
> > without it the first patch is buggy.
> > 
> I was originally split these two patches by adding job submission
> seqence and adding tdr sequence, But yes, I should merge these two
> patches otherwise the tdr sequence will fail without second patch.
> Will send a merged version today.
> 
> Best Regards,
> Jingwen
> > 
> > >   	if (job != NULL) {
> > >   		/* mark this fence has a parent job */
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > index 65a395060de2..19b13a65c73b 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > @@ -254,6 +254,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
> > >   		dma_fence_set_error(finished, -ECANCELED);/* skip IB as well if VRAM lost */
> > >   	if (finished->error < 0) {
> > > +		dma_fence_put(&job->hw_fence);
> > 
> > 
> > Would put this check bellow with the job_run_counter check
> > 
> > 
> > >   		DRM_INFO("Skip scheduling IBs!\n");
> > >   	} else {
> > >   		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
> > > @@ -262,7 +263,9 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
> > >   			DRM_ERROR("Error scheduling IBs (%d)\n", r);
> > >   	}
> > > -	dma_fence_get(fence);
> > > +	if (!job->job_run_counter)
> > > +		dma_fence_get(fence);
> > > +	job->job_run_counter ++;
> > >   	amdgpu_job_free_resources(job);
> > 
> > 
> > Here you  modify code you already changed in patch 1, looks to me
> > like those 2 patches should be squashed into one patch as the changes are
> > directly dependent and it's hard to follow
> > 
> > Andrey
> > 
> > 
> > >   	fence = r ? ERR_PTR(r) : fence;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > > index 92324c978534..1fa667f245e1 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > > @@ -64,6 +64,9 @@ struct amdgpu_job {
> > >   	/* user fence handling */
> > >   	uint64_t		uf_addr;
> > >   	uint64_t		uf_sequence;
> > > +
> > > +	/* job_run_counter >= 1 means a resubmit job */
> > > +	uint32_t		job_run_counter;
> > >   };
> > >   int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
