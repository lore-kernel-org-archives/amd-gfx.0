Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F22C4BA04
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 23:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E3320637
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 23:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i4nEWi8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E3320637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E31F88E26;
	Tue, 25 Feb 2020 23:40:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BE8488E26
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 23:40:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4249RFwBjqSv5tMES598Y4G9cPvsLrFnjD+CRQg8F3aocNyCcJr+VJGCxOzx+7NRWZ38yJp/DBIUGHWsj5kfTTlP3Q/FSRBcN+Ku4JfrK939SGi2kDIpsy21ctevKcwrPKId6oWN7fBCUudSJED6nE6AELrZirpqp6TS4RIoKl2IyOclgpmV8/9Wshs6F+JuSkke42OEIYhRbqZSHrC1hwzSnj9Rh0zab7jA/aS1+HgAoMCOMm+pZzl3NGhnoxCmDxaKsqk4LptZIgQngOOHzDkX1aZOVFYfPL2lF81R9Hl5pm2MrwJnzwNNJwJe+749mIVx3hAzfOEx7YMiGbCyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SotgyLp2NpxbVzt3uOjri2RFoJBRlgCbJhXl2HP+J24=;
 b=JT7vTyOy9qM0+fyvtUmSTpXZ9gpcnTDBixRVUp2JxCC1/N88AHcfmNSMpptTe70S2QeY+3HIHQ6G0x9mPDEy5FIANN+IRDTsbWWbOrJkg2MDDB8DIoyW1gY2HXaPapbjdaltrU59w56Gz1eopdJkg8f4sQgTodeLaTcCLXKOxyuemdH2Xlm6QrSY3bzDxJEytbC+4Nk3ymHNYfuO0gVIWx923/RsFo3LmwSm5nT+yI9GTX9uHR12h8Tp6phcVdxGdPdopQ/jDz2GPzap5Ak7mQ6hKPM1wtWQ+WxZDCCyFKx7YhWgHm7nu5h0iTbgAzUcrDssJIujleign139wXLdug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SotgyLp2NpxbVzt3uOjri2RFoJBRlgCbJhXl2HP+J24=;
 b=i4nEWi8JQXSz0lFT4anD639I63RHyHV6DtRU8SSPWWZ2sVmgc4Bc2EkbIO96W887DI66T44nf/z7eoj171/k+hBki1VrxMD7Qn1aKL/MGS44y8i3Gl0QZRTK8tbTQhNmV13xrQau91GVGform7nEajby/9q6PKUV7bZYf2Ke//I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3769.namprd12.prod.outlook.com (2603:10b6:5:14a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 23:40:09 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 23:40:09 +0000
Subject: Re: [PATCH] drm/amdgpu: fix the gfx hang while use per-ib secure flag
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1582639073-16555-1-git-send-email-ray.huang@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <478627e0-3954-e729-f8ed-c5a8fac8e81d@amd.com>
Date: Tue, 25 Feb 2020 18:40:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <1582639073-16555-1-git-send-email-ray.huang@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTBPR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::20) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 25 Feb 2020 23:40:08 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 243a1eb6-ac8e-4816-7d77-08d7ba4c0c8a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3769:|DM6PR12MB3769:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB376904EB24BD9A127CBE384299ED0@DM6PR12MB3769.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(189003)(199004)(36756003)(8936002)(5660300002)(6486002)(81166006)(2906002)(81156014)(54906003)(316002)(31696002)(52116002)(86362001)(8676002)(53546011)(6512007)(2616005)(66476007)(956004)(478600001)(16526019)(4326008)(26005)(186003)(44832011)(66946007)(6506007)(31686004)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3769;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gAVrtmAiNIGLBpEepgIijZFw3mM+Z+IFkuZHdWtFPRp+zosKC9F7agMniyh8DJVcrJVCK6Sn78lWn1hgYDEkmJnwwD0HD8GY9TgiLgS5tOGgSjPXJfxmD0PBQ9+6aL0+qsadCEnp2mF5Jz1lh91mM5iUNztmn30E1RJrN/ilVbQbgd2pKbBO898j+3T2Dr7Qt5o6sWktlAhU5hwF4VbykkXtKsBBlm35dUJ9Km6A+FSwsRFsLHJLCPSU4x5gNkRqzSoHIZcznhLC5nq11uq7YqHTJtQvPcP4OyocXh6wZliILu6X/05GwTCumupSQZzIWDIIvbPn6izxT7BRS9dMYhZDR8nj72mAPR94qemHqJtI6xXBNKL/UclHGkDi5PU2j8+HFwQJBTMjgu/qUcdSXoHT0BDnLgt4CXPieL3+1uRFk9nNLmMwS8aPb0EVmFu
X-MS-Exchange-AntiSpam-MessageData: 4HvUo8cBLtrBqCqnbeUpQWzCPm4x0Y8E8pLFwYfqj81rSDhj+90+g3FC19IkCPJuRliTf7XHALGONSSUqpvTpnX0NotayE+lpAbYnTGw0IH2z7LxeUd+WO6sjHDku4YuQrYKc/EEq2hxLhbyVJtZSQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243a1eb6-ac8e-4816-7d77-08d7ba4c0c8a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 23:40:08.8806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1YLJgf1qvro3I7d904rFZjgN9RPvxbGJip1g5c9WtPOorEC4NlxABl/gf6Xu/YU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3769
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-02-25 8:57 a.m., Huang Rui wrote:
> Since 6643ba1 frame control packets are only issued in presence of secure IB(s).
> This causes hangs on some hardware (eg: Raven1). This patch restores the
> unconditionnal frame control packets issuing, that's to keep the per-IB logic
> regarding the secure flag.
> 
> Fixes: 6643ba1 drm/amdgpu: Move to a per-IB secure flag (TMZ)
> 
> Reported-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 41 +++++++++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 15 ++++++------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 13 +++++-----
>  4 files changed, 43 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 4b2342d..9713a7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -131,7 +131,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>  	uint64_t fence_ctx;
>  	uint32_t status = 0, alloc_size;
>  	unsigned fence_flags = 0;
> -	bool secure;
> +	int secure = -1;

Don't initialize them far away from where they're being
used. That's a very bad habit.
This function is pretty long.
Initialize "secure" next to where it is being used--right
above the for-loop so that it is clear how it's used.

>  
>  	unsigned i;
>  	int r = 0;
> @@ -216,7 +216,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>  		amdgpu_ring_emit_cntxcntl(ring, status);
>  	}
>  
> -	secure = false;

Set "secure" here, close to where it is used.
This makes the code modular, so that it is easy
to see what is happening _locally_. Another
advantage is that should ever this code be pulled
out into its own function, we don't have to chase
variables around.

>  	for (i = 0; i < num_ibs; ++i) {
>  		ib = &ibs[i];
>  
> @@ -228,27 +227,37 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>  		    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
>  			continue;
>  
> -		/* If this IB is TMZ, add frame TMZ start packet,
> -		 * else, turn off TMZ.
> -		 */
> -		if (ib->flags & AMDGPU_IB_FLAGS_SECURE && ring->funcs->emit_tmz) {
> -			if (!secure) {
> -				secure = true;
> -				amdgpu_ring_emit_tmz(ring, true);
> +		if (job && ring->funcs->emit_frame_cntl) {
> +			if (secure == -1) {
> +				if (ib->flags & AMDGPU_IB_FLAGS_SECURE) {
> +					secure = 1;
> +					amdgpu_ring_emit_frame_cntl(ring, true, true);
> +				} else {
> +					secure = 0;
> +					amdgpu_ring_emit_frame_cntl(ring, true, false);
> +				}

So the above is executed only once. At the very first
iteration, since "secure" is set to -1. You can pull
that out of the loop and have a more straightforward
body of the loop.

Regards,
Luben

> +			} else {
> +				if (secure == 1 &&
> +				    !(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
> +					secure = 0;
> +					amdgpu_ring_emit_frame_cntl(ring, false, true);
> +					amdgpu_ring_emit_frame_cntl(ring, true, false);
> +				} else if (secure == 0 &&
> +					   ib->flags & AMDGPU_IB_FLAGS_SECURE) {
> +					secure = 1;
> +					amdgpu_ring_emit_frame_cntl(ring, false, false);
> +					amdgpu_ring_emit_frame_cntl(ring, true, true);
> +				}
>  			}
> -		} else if (secure) {
> -			secure = false;
> -			amdgpu_ring_emit_tmz(ring, false);
>  		}
>  
>  		amdgpu_ring_emit_ib(ring, job, ib, status);
>  		status &= ~AMDGPU_HAVE_CTX_SWITCH;
>  	}
>  
> -	if (secure) {
> -		secure = false;
> -		amdgpu_ring_emit_tmz(ring, false);
> -	}
> +	if (job && ring->funcs->emit_frame_cntl)
> +		amdgpu_ring_emit_frame_cntl(ring, false,
> +					    (secure == 1) ? true : false);
>  
>  #ifdef CONFIG_X86_64
>  	if (!(adev->flags & AMD_IS_APU))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 24caff0..4d019d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -166,7 +166,8 @@ struct amdgpu_ring_funcs {
>  	void (*emit_reg_write_reg_wait)(struct amdgpu_ring *ring,
>  					uint32_t reg0, uint32_t reg1,
>  					uint32_t ref, uint32_t mask);
> -	void (*emit_tmz)(struct amdgpu_ring *ring, bool start);
> +	void (*emit_frame_cntl)(struct amdgpu_ring *ring, bool start,
> +				bool secure);
>  	/* priority functions */
>  	void (*set_priority) (struct amdgpu_ring *ring,
>  			      enum drm_sched_priority priority);
> @@ -247,7 +248,7 @@ struct amdgpu_ring {
>  #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
>  #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))
>  #define amdgpu_ring_emit_reg_write_reg_wait(r, d0, d1, v, m) (r)->funcs->emit_reg_write_reg_wait((r), (d0), (d1), (v), (m))
> -#define amdgpu_ring_emit_tmz(r, b) (r)->funcs->emit_tmz((r), (b))
> +#define amdgpu_ring_emit_frame_cntl(r, b, s) (r)->funcs->emit_frame_cntl((r), (b), (s))
>  #define amdgpu_ring_pad_ib(r, ib) ((r)->funcs->pad_ib((r), (ib)))
>  #define amdgpu_ring_init_cond_exec(r) (r)->funcs->init_cond_exec((r))
>  #define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec((r),(o))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 7b61583..748ac35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -256,7 +256,7 @@ static int gfx_v10_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev);
>  static int gfx_v10_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev);
>  static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume);
>  static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume);
> -static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start);
> +static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start, bool secure);
>  
>  static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
>  {
> @@ -4729,12 +4729,13 @@ static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
>  					   sizeof(de_payload) >> 2);
>  }
>  
> -static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start)
> +static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
> +				    bool secure)
>  {
> -	if (amdgpu_is_tmz(ring->adev)) {
> -		amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> -		amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
> -	}
> +	uint32_t v = secure ? FRAME_TMZ : 0;
> +
> +	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> +	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
>  }
>  
>  static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
> @@ -5188,7 +5189,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>  	.init_cond_exec = gfx_v10_0_ring_emit_init_cond_exec,
>  	.patch_cond_exec = gfx_v10_0_ring_emit_patch_cond_exec,
>  	.preempt_ib = gfx_v10_0_ring_preempt_ib,
> -	.emit_tmz = gfx_v10_0_ring_emit_tmz,
> +	.emit_frame_cntl = gfx_v10_0_ring_emit_frame_cntl,
>  	.emit_wreg = gfx_v10_0_ring_emit_wreg,
>  	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 1c7a16b..fbde712 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5230,12 +5230,13 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
>  	amdgpu_ring_write_multiple(ring, (void *)&de_payload, sizeof(de_payload) >> 2);
>  }
>  
> -static void gfx_v9_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start)
> +static void gfx_v9_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
> +				   bool secure)
>  {
> -	if (amdgpu_is_tmz(ring->adev)) {
> -		amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> -		amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
> -	}
> +	uint32_t v = secure ? FRAME_TMZ : 0;
> +
> +	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> +	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
>  }
>  
>  static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
> @@ -6477,7 +6478,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>  	.emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
>  	.init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
>  	.patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
> -	.emit_tmz = gfx_v9_0_ring_emit_tmz,
> +	.emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
>  	.emit_wreg = gfx_v9_0_ring_emit_wreg,
>  	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
