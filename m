Return-Path: <SRS0=YeOH=4B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442BAC2BA83
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 14:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1575E2073C
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 14:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uOPXEzEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1575E2073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBB806F5F9;
	Thu, 13 Feb 2020 14:57:24 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680073.outbound.protection.outlook.com [40.107.68.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23D636E31A
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2020 14:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXZbu4HGPHg/tYX9PC8FDAZAqC+onJfwyiIBXjQKMLroFBp0FOUCJZYJoKzx9G/6SMsVDYWoAKlQ6xWocYWyjNHA/qXnXxzN0OC2oyqmnaEsoNTqggLw5vmq3aTxOUXbXyWZuGbsleAIyPyzMp2QkotFaXeuoGmxp9AI/3TctDZGnwB/W+RUcGS7HoezMOUc6ObdXK8PYJ/ibOIC+2xINXk+W9VIO/fQKFiTIzma3j0WTLGW+gFgTNmAxXRFOZrtxDyYsNux8A/8fX/n9aBfZIJZtmWbWdmvyUrM3dfB/Czo93Bpr/e0JOgdhlt2MCCZBeVXu3h9c5hm6ce8LNPjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7q2KxkJSyDThbX6HrxWIwN08fSutqhIY4y1Y2FCwnzA=;
 b=XrCLeuiacumSGn74qJYfLJ2D+GFiadQkiaaXDvsGEKbaIExMwFcuKb6i9eYdT1K/oK8HFrB/tebSAu8bTCK4G/tkQM3cDxCuR7TbUM4n9su8//srb4ody1vJuqK8IGGiXmMFU2xTq/jQac0pupMycT084zeF+xba9XEu5FtVkTipkZKiSG4zYNit/oH8k8jdp0KBYTme7s75hFWVKSdN63wi0M1eSlVG/4dAHH+puiYAfRM2Sqm5AxVcWQHzG7+V88kxNrI/Clxeex9cKzxIzrHVQtKCPSK2Vmvt2dx2h9diCKlyojH/9CkrL4OCgjHy68OqYUVhm+0FbiBFaY73qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7q2KxkJSyDThbX6HrxWIwN08fSutqhIY4y1Y2FCwnzA=;
 b=uOPXEzEgQSmjQfwGXkQ3UtAgWS6j/tLi89KL1jzeELSFlasyStSOwWvG6VC0/c7ATdsGIyp05iCBYALYdMyUskdaMbsYe20OxZpEEGE2uOc4tOqiImckl8mdiKxYQPg1ubS2rHfqx3qB+h7E8abgrgKLv19bRuo1adgDIlb5GpI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3998.namprd12.prod.outlook.com (10.255.239.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Thu, 13 Feb 2020 14:57:19 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2729.025; Thu, 13 Feb 2020
 14:57:19 +0000
Date: Thu, 13 Feb 2020 22:57:11 +0800
From: Huang Rui <ray.huang@amd.com>
To: christian.koenig@amd.com
Subject: Re: [PATCH] drm/amdgpu: Move to a per-IB secure flag (TMZ)
Message-ID: <20200213145710.GD24828@jenkins-Celadon-RN>
References: <20200213005455.521401-1-luben.tuikov@amd.com>
 <e1b57c7e-138c-435a-8450-e1bf44e4e10d@gmail.com>
Content-Disposition: inline
In-Reply-To: <e1b57c7e-138c-435a-8450-e1bf44e4e10d@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR0302CA0006.apcprd03.prod.outlook.com
 (2603:1096:202::16) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR0302CA0006.apcprd03.prod.outlook.com (2603:1096:202::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.6 via Frontend Transport; Thu, 13 Feb 2020 14:57:18 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e489b92c-b4c4-4c5c-4e3b-08d7b0950637
X-MS-TrafficTypeDiagnostic: MN2PR12MB3998:|MN2PR12MB3998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB399801E5338282DECB291FFAEC1A0@MN2PR12MB3998.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(189003)(199004)(9686003)(33716001)(956004)(55016002)(8936002)(6496006)(45080400002)(30864003)(966005)(6636002)(478600001)(6666004)(2906002)(66556008)(66476007)(8676002)(66946007)(52116002)(5660300002)(81156014)(81166006)(26005)(34206002)(33656002)(16526019)(186003)(86362001)(4326008)(1076003)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3998;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +AqGG2OnpMgyPCddet/Lt+fVWRI0AhhUFCcyNGmUYId/Ha1N8DEeXaY3RWqRtypn3XOj7OuEQ4yVIt8+LemIrMj7zBH53FXTtIs7dW9ptQZO7zvIJUy/wDFc1Aydt/Q4lDyOl6G9e8HDChhCycWR7qGQiiUgb5KckvF3KT1ARbnLjcgB2XJ2aeS7+s/051qjENiYUninj0Z/fWFWcB6CKXkJSfzh1o7f3DVh9B3x7heekgiDEYrbpx5amXA42oi5x8C78UZBWxA0do96b5rl+qIdUPocKkjT4Wu1Vp4Mi9Fiu3Mek3Gk1/X0JdEm93cr+eXaMJOMITYHBBu3ESU3pDccutmotsaGhPfD8X/yDSLtENbxJfMDeLdPuDAswbgrGhn+i1dGLv9JHtOS6O5LH/rXJ5tIYrsCkmrAm2TIrFES1Ua98ksJ3Qfg36bCfUeI5AMUQINkOCP0AcFCx1GpOemlciGIK2vtKCYXkt38bVFrj8xJjQF/m3yiHvHtNiLTz8uui+FlKErMHru5sZhHeg==
X-MS-Exchange-AntiSpam-MessageData: DXTt8EEZWgwSNSaOLb0r0Gb89eoNv2q/aXEPfctszOk6OGMkcJequTuda4zHSHCtGr/lRw68WgCnR7+mVB8Svp++TuKo2mROiF9oPMVTA5YcGamDSj5sQazNsLIoXKUv6u0eErXH29adlEsz1Zi7yA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e489b92c-b4c4-4c5c-4e3b-08d7b0950637
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 14:57:19.8357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7n+jGBbNXegGhCuGyiTUgm69fS1AOselOV+3Qn722cOwJyT2xdeRH4p5VfSlIv8a0MwI5TnKGwy2uodXU0I3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3998
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
Cc: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 13, 2020 at 11:30:43AM +0100, Christian K=F6nig wrote:
> Am 13.02.20 um 01:54 schrieb Luben Tuikov:
> > Move from a per-CS secure flag (TMZ) to a per-IB
> > secure flag.
> =

> Well that seems to make a lot of sense to me, but need to bit of time to
> read into the PM4 handling of TMZ.
> =

> Especially what is the "start" parameter good for?

I see this patch just now. And yes, that's my purpose for the discussion.

Thanks!

Reviewed-by: Huang Rui <ray.huang@amd.com>

> =

> Regards,
> Christian.
> =

> > =

> > Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  2 --
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 23 ++++++++++++++++++++---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  3 ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  9 ++++-----
> >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 23 +++++++----------------
> >   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c    |  3 +--
> >   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    |  3 +--
> >   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    |  3 +--
> >   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 20 ++++++--------------
> >   include/uapi/drm/amdgpu_drm.h            |  7 ++++---
> >   10 files changed, 44 insertions(+), 52 deletions(-)
> > =

> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index 80ba6dfc54e2..f9fa6e104fef 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -231,8 +231,6 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_p=
arser *p, union drm_amdgpu_cs
> >   	if (ret)
> >   		goto free_all_kdata;
> > -	p->job->secure =3D cs->in.flags & AMDGPU_CS_FLAGS_SECURE;
> > -
> >   	if (p->ctx->vram_lost_counter !=3D p->job->vram_lost_counter) {
> >   		ret =3D -ECANCELED;
> >   		goto free_all_kdata;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ib.c
> > index 6e0f97afb030..cae81914c821 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > @@ -132,6 +132,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed num_ibs,
> >   	uint64_t fence_ctx;
> >   	uint32_t status =3D 0, alloc_size;
> >   	unsigned fence_flags =3D 0;
> > +	bool secure;
> >   	unsigned i;
> >   	int r =3D 0;
> > @@ -213,9 +214,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, u=
nsigned num_ibs,
> >   	if (job && ring->funcs->emit_cntxcntl) {
> >   		status |=3D job->preamble_status;
> >   		status |=3D job->preemption_status;
> > -		amdgpu_ring_emit_cntxcntl(ring, status, job->secure);
> > +		amdgpu_ring_emit_cntxcntl(ring, status);
> >   	}
> > +	secure =3D false;
> >   	for (i =3D 0; i < num_ibs; ++i) {
> >   		ib =3D &ibs[i];
> > @@ -227,12 +229,27 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, =
unsigned num_ibs,
> >   		    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib=
 must be inserted anyway */
> >   			continue;
> > +		/* If this IB is TMZ, add frame TMZ start packet,
> > +		 * else, turn off TMZ.
> > +		 */
> > +		if (ib->flags & AMDGPU_IB_FLAGS_SECURE && ring->funcs->emit_tmz) {
> > +			if (!secure) {
> > +				secure =3D true;
> > +				amdgpu_ring_emit_tmz(ring, true);
> > +			}
> > +		} else if (secure) {
> > +			secure =3D false;
> > +			amdgpu_ring_emit_tmz(ring, false);
> > +		}
> > +
> >   		amdgpu_ring_emit_ib(ring, job, ib, status);
> >   		status &=3D ~AMDGPU_HAVE_CTX_SWITCH;
> >   	}
> > -	if (ring->funcs->emit_tmz)
> > -		amdgpu_ring_emit_tmz(ring, false, job ? job->secure : false);
> > +	if (secure) {
> > +		secure =3D false;
> > +		amdgpu_ring_emit_tmz(ring, false);
> > +	}
> >   #ifdef CONFIG_X86_64
> >   	if (!(adev->flags & AMD_IS_APU))
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.h
> > index 31c4444b0203..2e2110dddb76 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > @@ -61,9 +61,6 @@ struct amdgpu_job {
> >   	/* user fence handling */
> >   	uint64_t		uf_addr;
> >   	uint64_t		uf_sequence;
> > -
> > -	/* the job is due to a secure command submission */
> > -	bool			secure;
> >   };
> >   int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.h
> > index 5134d0dd6dc2..930316e60155 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -158,8 +158,7 @@ struct amdgpu_ring_funcs {
> >   	void (*begin_use)(struct amdgpu_ring *ring);
> >   	void (*end_use)(struct amdgpu_ring *ring);
> >   	void (*emit_switch_buffer) (struct amdgpu_ring *ring);
> > -	void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags,
> > -			       bool trusted);
> > +	void (*emit_cntxcntl) (struct amdgpu_ring *ring, uint32_t flags);
> >   	void (*emit_rreg)(struct amdgpu_ring *ring, uint32_t reg);
> >   	void (*emit_wreg)(struct amdgpu_ring *ring, uint32_t reg, uint32_t v=
al);
> >   	void (*emit_reg_wait)(struct amdgpu_ring *ring, uint32_t reg,
> > @@ -167,7 +166,7 @@ struct amdgpu_ring_funcs {
> >   	void (*emit_reg_write_reg_wait)(struct amdgpu_ring *ring,
> >   					uint32_t reg0, uint32_t reg1,
> >   					uint32_t ref, uint32_t mask);
> > -	void (*emit_tmz)(struct amdgpu_ring *ring, bool start, bool trusted);
> > +	void (*emit_tmz)(struct amdgpu_ring *ring, bool start);
> >   	/* priority functions */
> >   	void (*set_priority) (struct amdgpu_ring *ring,
> >   			      enum drm_sched_priority priority);
> > @@ -243,12 +242,12 @@ struct amdgpu_ring {
> >   #define amdgpu_ring_emit_gds_switch(r, v, db, ds, wb, ws, ab, as) (r)=
->funcs->emit_gds_switch((r), (v), (db), (ds), (wb), (ws), (ab), (as))
> >   #define amdgpu_ring_emit_hdp_flush(r) (r)->funcs->emit_hdp_flush((r))
> >   #define amdgpu_ring_emit_switch_buffer(r) (r)->funcs->emit_switch_buf=
fer((r))
> > -#define amdgpu_ring_emit_cntxcntl(r, d, s) (r)->funcs->emit_cntxcntl((=
r), (d), (s))
> > +#define amdgpu_ring_emit_cntxcntl(r, d) (r)->funcs->emit_cntxcntl((r),=
 (d))
> >   #define amdgpu_ring_emit_rreg(r, d) (r)->funcs->emit_rreg((r), (d))
> >   #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d)=
, (v))
> >   #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wa=
it((r), (d), (v), (m))
> >   #define amdgpu_ring_emit_reg_write_reg_wait(r, d0, d1, v, m) (r)->fun=
cs->emit_reg_write_reg_wait((r), (d0), (d1), (v), (m))
> > -#define amdgpu_ring_emit_tmz(r, b, s) (r)->funcs->emit_tmz((r), (b), (=
s))
> > +#define amdgpu_ring_emit_tmz(r, b) (r)->funcs->emit_tmz((r), (b))
> >   #define amdgpu_ring_pad_ib(r, ib) ((r)->funcs->pad_ib((r), (ib)))
> >   #define amdgpu_ring_init_cond_exec(r) (r)->funcs->init_cond_exec((r))
> >   #define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec(=
(r),(o))
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v10_0.c
> > index 4e25b39ac14f..1a9787a0177e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -256,8 +256,7 @@ static int gfx_v10_0_rlc_backdoor_autoload_enable(s=
truct amdgpu_device *adev);
> >   static int gfx_v10_0_wait_for_rlc_autoload_complete(struct amdgpu_dev=
ice *adev);
> >   static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, boo=
l resume);
> >   static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, boo=
l resume);
> > -static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool sta=
rt,
> > -				    bool trusted);
> > +static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool sta=
rt);
> >   static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uin=
t64_t queue_mask)
> >   {
> > @@ -4564,8 +4563,7 @@ static void gfx_v10_0_ring_emit_sb(struct amdgpu_=
ring *ring)
> >   }
> >   static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
> > -					 uint32_t flags,
> > -					 bool trusted)
> > +					 uint32_t flags)
> >   {
> >   	uint32_t dw2 =3D 0;
> > @@ -4573,8 +4571,6 @@ static void gfx_v10_0_ring_emit_cntxcntl(struct a=
mdgpu_ring *ring,
> >   		gfx_v10_0_ring_emit_ce_meta(ring,
> >   				    flags & AMDGPU_IB_PREEMPTED ? true : false);
> > -	gfx_v10_0_ring_emit_tmz(ring, true, trusted);
> > -
> >   	dw2 |=3D 0x80000000; /* set load_enable otherwise this package is ju=
st NOPs */
> >   	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
> >   		/* set load_global_config & load_global_uconfig */
> > @@ -4731,17 +4727,12 @@ static void gfx_v10_0_ring_emit_de_meta(struct =
amdgpu_ring *ring, bool resume)
> >   					   sizeof(de_payload) >> 2);
> >   }
> > -static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool sta=
rt,
> > -				    bool trusted)
> > +static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool sta=
rt)
> >   {
> > -	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> > -	/*
> > -	 * cmd =3D 0: frame begin
> > -	 * cmd =3D 1: frame end
> > -	 */
> > -	amdgpu_ring_write(ring,
> > -			  ((amdgpu_is_tmz(ring->adev) && trusted) ? FRAME_TMZ : 0)
> > -			  | FRAME_CMD(start ? 0 : 1));
> > +	if (amdgpu_is_tmz(ring->adev)) {
> > +		amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> > +		amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
> > +	}
> >   }
> >   static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32=
_t reg)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v6_0.c
> > index 95bb2422b27c..31f44d05e606 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> > @@ -2973,8 +2973,7 @@ static uint64_t gfx_v6_0_get_gpu_clock_counter(st=
ruct amdgpu_device *adev)
> >   	return clock;
> >   }
> > -static void gfx_v6_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32=
_t flags,
> > -				      bool trusted)
> > +static void gfx_v6_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32=
_t flags)
> >   {
> >   	if (flags & AMDGPU_HAVE_CTX_SWITCH)
> >   		gfx_v6_0_ring_emit_vgt_flush(ring);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v7_0.c
> > index 648d767d14e7..8f20a5dd44fe 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > @@ -2320,8 +2320,7 @@ static void gfx_v7_0_ring_emit_ib_compute(struct =
amdgpu_ring *ring,
> >   	amdgpu_ring_write(ring, control);
> >   }
> > -static void gfx_v7_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32=
_t flags,
> > -				      bool trusted)
> > +static void gfx_v7_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32=
_t flags)
> >   {
> >   	uint32_t dw2 =3D 0;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v8_0.c
> > index a46ec1c9846e..fa245973de12 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > @@ -6386,8 +6386,7 @@ static void gfx_v8_ring_emit_sb(struct amdgpu_rin=
g *ring)
> >   	amdgpu_ring_write(ring, 0);
> >   }
> > -static void gfx_v8_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32=
_t flags,
> > -				      bool trusted)
> > +static void gfx_v8_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32=
_t flags)
> >   {
> >   	uint32_t dw2 =3D 0;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_0.c
> > index e5753746cbf9..9d3805488832 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -5212,29 +5212,21 @@ static void gfx_v9_0_ring_emit_de_meta(struct a=
mdgpu_ring *ring)
> >   	amdgpu_ring_write_multiple(ring, (void *)&de_payload, sizeof(de_payl=
oad) >> 2);
> >   }
> > -static void gfx_v9_0_ring_emit_tmz(struct amdgpu_ring *ring, bool star=
t,
> > -				   bool trusted)
> > +static void gfx_v9_0_ring_emit_tmz(struct amdgpu_ring *ring, bool star=
t)
> >   {
> > -	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> > -	/*
> > -	 * cmd =3D 0: frame begin
> > -	 * cmd =3D 1: frame end
> > -	 */
> > -	amdgpu_ring_write(ring,
> > -			  ((amdgpu_is_tmz(ring->adev) && trusted) ? FRAME_TMZ : 0)
> > -			  | FRAME_CMD(start ? 0 : 1));
> > +	if (amdgpu_is_tmz(ring->adev)) {
> > +		amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> > +		amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
> > +	}
> >   }
> > -static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32=
_t flags,
> > -				      bool trusted)
> > +static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32=
_t flags)
> >   {
> >   	uint32_t dw2 =3D 0;
> >   	if (amdgpu_sriov_vf(ring->adev))
> >   		gfx_v9_0_ring_emit_ce_meta(ring);
> > -	gfx_v9_0_ring_emit_tmz(ring, true, trusted);
> > -
> >   	dw2 |=3D 0x80000000; /* set load_enable otherwise this package is ju=
st NOPs */
> >   	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
> >   		/* set load_global_config & load_global_uconfig */
> > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_dr=
m.h
> > index 918ac3548cd3..eaf94a421901 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -556,9 +556,6 @@ struct drm_amdgpu_cs_chunk {
> >   	__u64		chunk_data;
> >   };
> > -/* Flag the command submission as secure */
> > -#define AMDGPU_CS_FLAGS_SECURE          (1 << 0)
> > -
> >   struct drm_amdgpu_cs_in {
> >   	/** Rendering context id */
> >   	__u32		ctx_id;
> > @@ -599,6 +596,10 @@ union drm_amdgpu_cs {
> >    */
> >   #define AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID (1 << 4)
> > +/* Flag the IB as secure (TMZ)
> > + */
> > +#define AMDGPU_IB_FLAGS_SECURE  (1 << 5)
> > +
> >   struct drm_amdgpu_cs_chunk_ib {
> >   	__u32 _pad;
> >   	/** AMDGPU_IB_FLAG_* */
> =

> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cray.hu=
ang%40amd.com%7C1749e47fe6294a1c615808d7b06fcb17%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637171866515740964&amp;sdata=3DIl9zrmo2G5zBlQW6BSRIl2qbD=
Qkine7Kdf%2B%2BN7SQA%2Bk%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
