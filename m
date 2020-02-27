Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62669C4BA24
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 12:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB5624695
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 12:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hdbRkTW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB5624695
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E88F06E86D;
	Thu, 27 Feb 2020 12:06:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0061A6E86D
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 12:06:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbICgJux9CiPX6Quf5rqVuOjOZULDycH3X8zMViFmyVF9s7GrEOtwIuaiBTmMFRaFyaDWvcX4byJEHvJecI4XRZJsB2tU04DekW5JQEHovY47OchRRyh2UPBo6gYQWOFgJI9W14Gd+6/BaMmu+vlQhaqXGJyO+m8PsTuZXpt2HU2D0wGHpf53uW9Imx47bguAEQLbYJLjNvGXs8sJYA/SzH+9oRC1qO6oFRTOz7v9OJ1liV8DYbYaQ2sMZ2Ih+JONeLUMFcIdb+ASGJqQ3qqDfZK5DnqX8qJFMqwR/s3pAmmtjScmnvIMUXYusMF23bJv0y23gX3IXnNRBvLAalbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2xST0S9ws7x2aS8hF8YEGze5ATM2Zp0uE6Rt0KRp7E=;
 b=RXSyn0pTjrHt9SKKOKhkfFfoUPoiKLoKBXCJVgmNzrxc4JNWNkiGU/8sK7SNbrmDiVE1l6pmkxOGzz8Yo4e4suwNrAVYo7GQc4BEPnZHjE9tvBFJnSavh8uh3w7lyY3uHXQYw12dCZYFHpH/uQr46p2WZXKIZwacHNZXL0FnXRa27ap8gYDiUxs7CKXpVKqvYPI5QF0Pv+fGDA29tO1/63DE83v+z1JOQ52jRIQ8neDjiBQyjZXdOKU0YFIfcl5EDwNUQRC3QA+iJeNDAWwJBu9I8lGn4gZQf0REubDiR3C16DyVTgcAu/88UWziEQgXCQ67m9FIHNBJdIxLsi8HsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2xST0S9ws7x2aS8hF8YEGze5ATM2Zp0uE6Rt0KRp7E=;
 b=hdbRkTW4bQpYWUNVCp4Qy7Jj3tc9QcSLZbe+rGQUUrEt/VxvZ9IZ62xXnfR7i/gn8Zt1P/d57vw3v+DJrVr51GWPkSOUtDtOPevHiPEl6HUGqz+KPNwOLEYbV3hf548SJPcbDsH+5QcSDDhL+tYW+vKsgBlgwnXvPeaYXDoFyTg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 12:06:26 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 12:06:26 +0000
Date: Thu, 27 Feb 2020 20:06:16 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix the gfx hang while use per-ib secure
 flag (v2)
Message-ID: <20200227120615.GC13364@jenkins-Celadon-RN>
References: <1582803483-27446-1-git-send-email-ray.huang@amd.com>
 <377c5042-8890-4ccf-b376-c282c1231970@amd.com>
Content-Disposition: inline
In-Reply-To: <377c5042-8890-4ccf-b376-c282c1231970@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::22) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.5 via Frontend Transport; Thu, 27 Feb 2020 12:06:24 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cdc763d2-da9c-426f-e27d-08d7bb7d787a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4333:|MN2PR12MB4333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4333DF1097AAD25C24260DD2ECEB0@MN2PR12MB4333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(189003)(199004)(33656002)(5660300002)(478600001)(33716001)(956004)(66556008)(66476007)(2906002)(4326008)(66946007)(6862004)(26005)(86362001)(316002)(6636002)(54906003)(8936002)(52116002)(6496006)(16526019)(186003)(6666004)(1076003)(55016002)(8676002)(9686003)(81166006)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4333;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cb78EFM5fGWxT3tOvYgLKNr1h+F/Am3MCxYpbOizLVjDNCcvbPJVAzswGdN6XiJdCSwIwCnohELePL5LYwokJCiC8++mizL1PskW01SpvDgZuWUkoeyMoEzSzgeGBaHZz3KiTknfQkDy9xtixTipt4dYKpcQ36I+xUqPYnD6ZMh1W7Nw03vUm8AoN4xTgkFeUtGT60vXVNxDem3lmekL5zq8SzY7oOqpW+KjFzuj3Udj3snGPDHCAHaYeVp6RhTPpJOzSRE7eBYnO8p9FD0esycGBC7OvO7g9t54I5pd2PGMmn4gYI72jTq2DKbuPQm0Cc6kyB+A7eqDJ/Wul5thIz49OSXETio7ICd6pQ62tlBNDv4JIJnjBVz/YZlzRVd5OHgcKF6tubgZncneXyp4mPjhHmH4LvvFCFw4nEkLzKpUEOGXYN85NZNcgFueARkh
X-MS-Exchange-AntiSpam-MessageData: 9kU675RPaOhFVJxrsE+aEMCQO6EAm23qB2PQhs20tfNA6rzDhZttX13vcJXdzO85y0NF5RVsdHKIJz7PKpvmsw00pUefTvJST6I1j46nz8j079mt9H2AtuOpNk0RaMPLNACxF3TJwdhZXrH4K6s1kg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc763d2-da9c-426f-e27d-08d7bb7d787a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 12:06:26.5938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJtbWSySwMYSFXrBbl4KHCL9NNr/D62UxwRjqGuDmRWTeoTlFsCGPFxs6F/hTpbRKkmQCLzO3+Rprb4fZODvgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pelloux-prayer,
 Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 27, 2020 at 07:47:17PM +0800, Koenig, Christian wrote:
> Am 27.02.20 um 12:38 schrieb Huang Rui:
> > Since 6643ba1 frame control packets are only issued in presence of secure IB(s).
> > This causes hangs on some hardware (eg: Raven1). This patch restores the
> > unconditionnal frame control packets issuing, that's to keep the per-IB logic
> > regarding the secure flag.
> >
> > Fixes: 6643ba1 drm/amdgpu: Move to a per-IB secure flag (TMZ)
> >
> > v1 -> v2:
> > As suggested by Luben, and accept part of implemetation from this patch:
> > - Put "secure" closed to the loop and use optimization
> > - Change "secure" to bool again, and move "secure == -1" out of loop.
> >
> > Reported-and-Tested-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 29 +++++++++++++++--------------
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 +++--
> >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 15 ++++++++-------
> >   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 13 +++++++------
> >   4 files changed, 33 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > index 4b2342d..0f4909a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > @@ -216,7 +216,14 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
> >   		amdgpu_ring_emit_cntxcntl(ring, status);
> >   	}
> >   
> > +	/* Setup initial TMZiness and send it off.
> > +	 */
> >   	secure = false;
> > +	if (job && ring->funcs->emit_frame_cntl) {
> 
> Does anybody remember why we check the job here in the first place?

Align with previous logic, we only issue this packet while it's user mode
submission. Looks ib tests needn't this.

> 
> Independent of that I think that the check if 
> ring->funcs->emit_frame_cntl should be moved into the 
> amdgpu_ring_emit_frame_cntl() function so that we don't need to repeat 
> that over and over again.
> 
> If amdgpu_ring_emit_frame_cntl() is still a macro then that is probably 
> also a good opportunity to change that.

Agree, this looks better.

> 
> > +		secure = ib->flags & AMDGPU_IB_FLAGS_SECURE ? true : false;
> > +		amdgpu_ring_emit_frame_cntl(ring, true, secure);
> > +	}
> > +
> >   	for (i = 0; i < num_ibs; ++i) {
> >   		ib = &ibs[i];
> >   
> > @@ -228,27 +235,21 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
> >   		    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
> >   			continue;
> >   
> > -		/* If this IB is TMZ, add frame TMZ start packet,
> > -		 * else, turn off TMZ.
> > -		 */
> > -		if (ib->flags & AMDGPU_IB_FLAGS_SECURE && ring->funcs->emit_tmz) {
> > -			if (!secure) {
> > -				secure = true;
> > -				amdgpu_ring_emit_tmz(ring, true);
> > +		if (job && ring->funcs->emit_frame_cntl) {
> > +			if (!!secure ^ !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
> 
> Maybe write this as (secure != !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)). 
> That is probably easier to understand.

Actually, I spend quit a few minutes to understand previous checking. :-)
I am fine to change if Lunben has no objection.

Thanks,
Ray

> 
> Regards,
> Christian.
> 
> > +				amdgpu_ring_emit_frame_cntl(ring, false, secure);
> > +				secure = !secure;
> > +				amdgpu_ring_emit_frame_cntl(ring, true, secure);
> >   			}
> > -		} else if (secure) {
> > -			secure = false;
> > -			amdgpu_ring_emit_tmz(ring, false);
> >   		}
> >   
> >   		amdgpu_ring_emit_ib(ring, job, ib, status);
> >   		status &= ~AMDGPU_HAVE_CTX_SWITCH;
> >   	}
> >   
> > -	if (secure) {
> > -		secure = false;
> > -		amdgpu_ring_emit_tmz(ring, false);
> > -	}
> > +	if (job && ring->funcs->emit_frame_cntl)
> > +		amdgpu_ring_emit_frame_cntl(ring, false,
> > +					    secure ? true : false);
> >   
> >   #ifdef CONFIG_X86_64
> >   	if (!(adev->flags & AMD_IS_APU))
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > index 24caff0..4d019d6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -166,7 +166,8 @@ struct amdgpu_ring_funcs {
> >   	void (*emit_reg_write_reg_wait)(struct amdgpu_ring *ring,
> >   					uint32_t reg0, uint32_t reg1,
> >   					uint32_t ref, uint32_t mask);
> > -	void (*emit_tmz)(struct amdgpu_ring *ring, bool start);
> > +	void (*emit_frame_cntl)(struct amdgpu_ring *ring, bool start,
> > +				bool secure);
> >   	/* priority functions */
> >   	void (*set_priority) (struct amdgpu_ring *ring,
> >   			      enum drm_sched_priority priority);
> > @@ -247,7 +248,7 @@ struct amdgpu_ring {
> >   #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
> >   #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))
> >   #define amdgpu_ring_emit_reg_write_reg_wait(r, d0, d1, v, m) (r)->funcs->emit_reg_write_reg_wait((r), (d0), (d1), (v), (m))
> > -#define amdgpu_ring_emit_tmz(r, b) (r)->funcs->emit_tmz((r), (b))
> > +#define amdgpu_ring_emit_frame_cntl(r, b, s) (r)->funcs->emit_frame_cntl((r), (b), (s))
> >   #define amdgpu_ring_pad_ib(r, ib) ((r)->funcs->pad_ib((r), (ib)))
> >   #define amdgpu_ring_init_cond_exec(r) (r)->funcs->init_cond_exec((r))
> >   #define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec((r),(o))
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > index 7b61583..748ac35 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -256,7 +256,7 @@ static int gfx_v10_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev);
> >   static int gfx_v10_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev);
> >   static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume);
> >   static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume);
> > -static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start);
> > +static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start, bool secure);
> >   
> >   static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
> >   {
> > @@ -4729,12 +4729,13 @@ static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
> >   					   sizeof(de_payload) >> 2);
> >   }
> >   
> > -static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start)
> > +static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
> > +				    bool secure)
> >   {
> > -	if (amdgpu_is_tmz(ring->adev)) {
> > -		amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> > -		amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
> > -	}
> > +	uint32_t v = secure ? FRAME_TMZ : 0;
> > +
> > +	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> > +	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
> >   }
> >   
> >   static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
> > @@ -5188,7 +5189,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
> >   	.init_cond_exec = gfx_v10_0_ring_emit_init_cond_exec,
> >   	.patch_cond_exec = gfx_v10_0_ring_emit_patch_cond_exec,
> >   	.preempt_ib = gfx_v10_0_ring_preempt_ib,
> > -	.emit_tmz = gfx_v10_0_ring_emit_tmz,
> > +	.emit_frame_cntl = gfx_v10_0_ring_emit_frame_cntl,
> >   	.emit_wreg = gfx_v10_0_ring_emit_wreg,
> >   	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
> >   	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index 1c7a16b..fbde712 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -5230,12 +5230,13 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
> >   	amdgpu_ring_write_multiple(ring, (void *)&de_payload, sizeof(de_payload) >> 2);
> >   }
> >   
> > -static void gfx_v9_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start)
> > +static void gfx_v9_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
> > +				   bool secure)
> >   {
> > -	if (amdgpu_is_tmz(ring->adev)) {
> > -		amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> > -		amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
> > -	}
> > +	uint32_t v = secure ? FRAME_TMZ : 0;
> > +
> > +	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> > +	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
> >   }
> >   
> >   static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
> > @@ -6477,7 +6478,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
> >   	.emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
> >   	.init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
> >   	.patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
> > -	.emit_tmz = gfx_v9_0_ring_emit_tmz,
> > +	.emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
> >   	.emit_wreg = gfx_v9_0_ring_emit_wreg,
> >   	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
> >   	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
