Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F09C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 09:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6CC60F23
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 09:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BC6CC60F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8193B6F91C;
	Fri, 23 Jul 2021 09:25:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B28716F91C
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 09:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kA7/VXHI//qnIjRSAsDkPebkNBgFV4dHnc4B1ac5CwqUxY9lxkCxGH0XE+iZyKP06YpIHbNiZwjoT0+yO2yjWih7a3r3sRj3avRnqrKCvV383vSlpisJ/2gfuyz1Mk6d4S6P/UcJVZhW44MLfzz5OhPhx4+dvpuARZTw0Bl8RU1tsyO1Bda2Tp6uEPsnd1VXi/DsSOp6RpUpYECn85I7dXLpixRfyl1G3RWoro3lOvf8C9W58lQblhr9kETUN3EzhLrsacPWGEFlpIJMYFttN/ssqZI45aqEtqvBFgJ419wDej95mXZynq143cC70iaU4Xjsddr447ALjwJqkadNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FP6qTtU7uvSzMX8Uzu+L8nkWuw6a5wH+Zby6sXOFO4A=;
 b=WjsftY7eGiwV/KDXwOKa2cxoHeWohHoOj0IoWmNiPjfvxqb6JIjuQAgX01IL68/AXLkmheN6qzLK+VJ8MUKyRhJMfXpwWMOVqcotNepyATyPbISU1nyzX5d6uaqEb97jWvFbRCteE9LV2UssGUVzS0+3p8wIi2gl1LhEt7Pp7yAgfet+eRbYqMQVa0kf+wqX8SlpNhPEyZChMWf+rIH7i1Mat4o2Cv1SogCF5tGXDPbwweBH7N2sKbo2hTpR35TCL5PWyWBfgAEmRQY3ePcIiZ/4Sueo+GlorLSnqCD2akNudmLBysi6Dc2sWbwjv+kO93v71xnXFa0fOYqpxCggxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FP6qTtU7uvSzMX8Uzu+L8nkWuw6a5wH+Zby6sXOFO4A=;
 b=M3yNvUCfx5S79NoZcGSZAupU7e1qQKZBvUrI0vz5LkXnCvyfH+9LwEFWxHBlzPDQ8smm/SLyNbMQGdOR3rkg2NyrF/hOh/68uVwwjbyPbv2dw/XW0xWx1KmiaCgzeDsWH/gW18qdXqwxnoD8z2iWztbRhBhvOYYhXCCAil3hz48=
Received: from DM6PR17CA0011.namprd17.prod.outlook.com (2603:10b6:5:1b3::24)
 by CY4PR12MB1797.namprd12.prod.outlook.com (2603:10b6:903:124::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Fri, 23 Jul
 2021 09:25:40 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::e) by DM6PR17CA0011.outlook.office365.com
 (2603:10b6:5:1b3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Fri, 23 Jul 2021 09:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Fri, 23 Jul 2021 09:25:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 04:25:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 04:25:38 -0500
Received: from wayne-build (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 23 Jul 2021 04:25:37 -0500
Date: Fri, 23 Jul 2021 17:25:36 +0800
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>, "Andrey
 Grodzovsky" <andrey.grodzovsky@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm: add tdr support for embeded hw_fence
Message-ID: <20210723092536.ru63kkl2mqsxnxdr@wayne-build>
References: <20210721031352.413888-1-Jingwen.Chen2@amd.com>
 <20210721031352.413888-2-Jingwen.Chen2@amd.com>
 <36f53a64-2d9c-947b-a5fb-21d9fc06c5e4@amd.com>
 <20210722104525.okcnb43goxg6uqej@wayne-build>
 <0699ff85-4aec-0e33-711b-665307fbbc24@amd.com>
 <9dacfe83-da10-9806-81e0-70077dedce9f@gmail.com>
 <20210722164704.age63nzbviqg4y7v@wayne-build>
 <37b6c44f-2fa7-c507-7b77-13608285b362@gmail.com>
 <20210723070714.6h5pmxjebopv4zge@wayne-build>
 <39e0cad8-c991-d685-1553-cdf87ab2d395@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <39e0cad8-c991-d685-1553-cdf87ab2d395@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2825398f-d70f-4e65-f4dc-08d94dbbd681
X-MS-TrafficTypeDiagnostic: CY4PR12MB1797:
X-Microsoft-Antispam-PRVS: <CY4PR12MB17975524F0D7607B8639D48DB7E59@CY4PR12MB1797.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TPTDZgFnG1WNmYofQB2Fsomjv8m+JQGMHpJgmkuhRTUcJD8D3V8LVqtlmdS0pkzlLOsw0S/prtHoDPzRpfU+shKfVJEIkEBDvM49z0qyh31AGPqvps3OUSNYFfsagpnzn5VKU0Qws1OxnnlproeQxG4/s7qtqkapz3AgOZMIzW5ycdNRhlHBDkLHR7fOYaddf16G9nvgDV8PH82os7kt/kZ+Mms7oTbH6nHO/wTm2ktV2U4W0Zd4ayqGKLtBwYMC2jQXhIa6zziW078QenvezDEMwAN39LQEp1hFWn9o2dIhN3YxbPfaqZgTFbtDGWjb3Qw2Aujl4RiAt7magvXqOlAF9quxN+OZMDspq6G5xEg5KqMsuiWDyKNRlKpMF5zFBMO95aGKvMuvBpYhqB0o+SJzKEf1f+1R6YSys8AaD2nCm8gPxEhi/Uz2OKu2L5+kFWD28U9NMlFbqvpbkXCuN+QRydB4grye/sdZlkN4Q3VMSxWNV46Ewy9ASwAgbWS6h2yqnMcDftvz89QJ+Xsz9bQRwwJlBVhZpIvKDJwdwh4TauCXRetvBnAJt9aEfdbIyf8XBPpLzwcQwiFWz/rnzSDIvVqdP7lcdRRptcLL3yUQa4bq2A0WdYTWq6yEXnAaQ+y3A594Fuf0+pEVb03MUhgJrJjvLlOzVkV7FGsKa8nYw1lH5llkUMdbLhz9P19oy0umAqmiMHFn06+qKthauK4xl8uIBb0AuGDhvbbQfoLurEdgGbq+Ro6v9s6Sqsuo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(36840700001)(4326008)(82740400003)(316002)(1076003)(478600001)(26005)(426003)(83380400001)(110136005)(336012)(5660300002)(2906002)(8936002)(86362001)(82310400003)(70586007)(55016002)(8676002)(81166007)(356005)(32650700002)(33716001)(54906003)(186003)(36860700001)(9686003)(70206006)(66574015)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 09:25:40.1540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2825398f-d70f-4e65-f4dc-08d94dbbd681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1797
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
Cc: horace.chen@amd.com, Jack.Zhang7@hotmail.com, monk.liu@amd.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri Jul 23, 2021 at 10:45:49AM +0200, Christian K=F6nig wrote:
> Am 23.07.21 um 09:07 schrieb Jingwen Chen:
> > [SNIP]
> > Hi Christian,
> > =

> > The thing is vm flush fence has no job passed to amdgpu_fence_emit, so
> > go through the jobs cannot help find the vm flush fence. And keep the
> > rest fences in the RCU array will lead to signaling them in the ib_test
> > right after ASIC reset. While they will be signaled again during
> > resubmission. What I'm doning here is just trying to cleanup the fences
> > without a parent job and make sure the rest fences won't be signaled
> > twice.
> =

> It took me a moment to realize what you are talking about here.
> =

> This is for the KIQ! You need different handling for the KIQ than for the
> scheduler controlled rings.
> =

> It is not only the flush jobs, but the KIQ needs a complete reset because=
 of
> the register writes pushed there as well.
> =

> > > And please drop any usage of DMA_FENCE_FLAG_USER_BITS. That is not so=
mething
> > > which should be abused for reset handling.
> > > =

> > The DMA_FENCE_FLAG_USER_BITS here is to mark this fence has a parent
> > job. If this is not a proper usage here, do you have any suggestions
> > about how to identify whether the fence has a parent job?
> =

> You don't need to mark the fences at all. Everything on the KIQ ring needs
> to be force completed since none of the fences on that ring have a parent
> job.
> =

> Christian.
>
Hi Christian

Yes KIQ ring fences all need force_completion. But we do need to mark the
fences. Say we have a gfx ring job with vm_flush=3D1 sending to
amdgpu_ib_schedule, then in amdgpu_vm_flush, after the
amdgpu_ring_emit_vm_flush is done, we will create a vm flush fence on
gfx ring with amdgpu_fence_emit(ring, &fence, NULL, 0).

Then this vm flush fence we create here has no parent job but it's on
gfx ring. =

If we only do force_completion for KIQ ring and just clear the
RCU array for the scheduler controlled rings, nobody will signal and put th=
is
gfx ring vm_flush fence again. When this job is resubmitted, it will
just create a new vm_flush fence. This is a memleak and I have seen this
memleak during my test.

Best Regards,
JingWen Chen
> > =

> > Best Regards,
> > JingWen Chen
> > > Regards,
> > > Christian.
> > > =

> > > > =

> > > > Best Regards,
> > > > JingWen Chen
> > > > > > Andrey
> > > > > > =

> > > > > > =

> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* after all hw jobs are=
 reset, hw fence is
> > > > > > > > > meaningless, so force_completion */
> > > > > > > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 amdgpu_fence_driver_forc=
e_completion(ring);
> > > > > > > > >   =A0=A0=A0=A0=A0=A0 }
> > > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > > > > > index eecf21d8ec33..815776c9a013 100644
> > > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > > > > > @@ -156,11 +156,17 @@ int amdgpu_fence_emit(struct
> > > > > > > > > amdgpu_ring *ring, struct dma_fence **f, struct amd
> > > > > > > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 job->ring =3D ring;
> > > > > > > > >   =A0=A0=A0=A0=A0=A0 }
> > > > > > > > > -=A0=A0=A0 seq =3D ++ring->fence_drv.sync_seq;
> > > > > > > > > -=A0=A0=A0 dma_fence_init(fence, &amdgpu_fence_ops,
> > > > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &ring->fence_=
drv.lock,
> > > > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->fence_c=
ontext + ring->idx,
> > > > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 seq);
> > > > > > > > > +=A0=A0=A0 if (job !=3D NULL && job->base.resubmit_flag =
=3D=3D 1) {
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 /* reinit seq for resubmitted jobs=
 */
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 seq =3D ++ring->fence_drv.sync_seq;
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 fence->seqno =3D seq;
> > > > > > > > > +=A0=A0=A0 } else {
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 seq =3D ++ring->fence_drv.sync_seq;
> > > > > > > > Seems like you could do the above line only once above if-e=
lse
> > > > > > > > as it was
> > > > > > > > before
> > > > > > > Sure, I will modify this.
> > > > > > > =

> > > > > > > =

> > > > > > > Best Regards,
> > > > > > > JingWen Chen
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 dma_fence_init(fence, &amdgpu_fenc=
e_ops,
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &ring->fen=
ce_drv.lock,
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->fenc=
e_context + ring->idx,
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 seq);
> > > > > > > > > +=A0=A0=A0 }
> > > > > > > > >   =A0=A0=A0=A0=A0=A0 if (job !=3D NULL) {
> > > > > > > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* mark this fence has a=
 parent job */
> > > > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > > > > > index 7c426e225b24..d6f848adc3f4 100644
> > > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > > > > > @@ -241,6 +241,7 @@ static struct dma_fence
> > > > > > > > > *amdgpu_job_run(struct drm_sched_job *sched_job)
> > > > > > > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dma_fence_set_error(fini=
shed, -ECANCELED);/* skip
> > > > > > > > > IB as well if VRAM lost */
> > > > > > > > >   =A0=A0=A0=A0=A0=A0 if (finished->error < 0) {
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 dma_fence_put(&job->hw_fence);
> > > > > > > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DRM_INFO("Skip schedulin=
g IBs!\n");
> > > > > > > > >   =A0=A0=A0=A0=A0=A0 } else {
> > > > > > > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r =3D amdgpu_ib_schedule=
(ring, job->num_ibs, job->ibs, job,
> > > > > > > > > @@ -249,7 +250,8 @@ static struct dma_fence
> > > > > > > > > *amdgpu_job_run(struct drm_sched_job *sched_job)
> > > > > > > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DRM_ERROR("E=
rror scheduling IBs (%d)\n", r);
> > > > > > > > >   =A0=A0=A0=A0=A0=A0 }
> > > > > > > > > -=A0=A0=A0 dma_fence_get(fence);
> > > > > > > > > +=A0=A0=A0 if (!job->base.resubmit_flag)
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 dma_fence_get(fence);
> > > > > > > > >   =A0=A0=A0=A0=A0=A0 amdgpu_job_free_resources(job);
> > > > > > > > >   =A0=A0=A0=A0=A0=A0 fence =3D r ? ERR_PTR(r) : fence;
> > > > > > > > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > > > b/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > > > index f4f474944169..5a36ab5aea2d 100644
> > > > > > > > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > > > @@ -544,6 +544,7 @@ void drm_sched_resubmit_jobs_ext(stru=
ct
> > > > > > > > > drm_gpu_scheduler *sched, int max)
> > > > > > > > > dma_fence_set_error(&s_fence->finished, -ECANCELED);
> > > > > > > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dma_fence_put(s_job->s_f=
ence->parent);
> > > > > > > > > +=A0=A0=A0=A0=A0=A0=A0 s_job->resubmit_flag =3D 1;
> > > > > > > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fence =3D sched->ops->ru=
n_job(s_job);
> > > > > > > > >   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i++;
> > > > > > > > > diff --git a/include/drm/gpu_scheduler.h b/include/drm/gp=
u_scheduler.h
> > > > > > > > > index 4ea8606d91fe..06c101af1f71 100644
> > > > > > > > > --- a/include/drm/gpu_scheduler.h
> > > > > > > > > +++ b/include/drm/gpu_scheduler.h
> > > > > > > > > @@ -198,6 +198,7 @@ struct drm_sched_job {
> > > > > > > > >   =A0=A0=A0=A0=A0=A0 enum drm_sched_priority=A0=A0=A0=A0=
=A0=A0=A0 s_priority;
> > > > > > > > >   =A0=A0=A0=A0=A0=A0 struct drm_sched_entity=A0=A0=A0=A0=
=A0=A0=A0=A0 *entity;
> > > > > > > > >   =A0=A0=A0=A0=A0=A0 struct dma_fence_cb=A0=A0=A0=A0=A0=
=A0=A0 cb;
> > > > > > > > > +=A0=A0=A0 int resubmit_flag;
> > > > > > > > >   =A0=A0 };
> > > > > > > > >   =A0=A0 static inline bool drm_sched_invalidate_job(stru=
ct
> > > > > > > > > drm_sched_job *s_job,
> =

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
