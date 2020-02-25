Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4A6C35DE1
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 14:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E78121744
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 14:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l3DG/dg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E78121744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2288B6EAE4;
	Tue, 25 Feb 2020 14:10:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D136EAE4
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 14:10:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZYsvwUbUX8UytCZQ3iEZWmo2ULy9sbdFSI+065EyH/HmczKhacVf/Vl0mwFsphQuM4Fs+SYSBzJxEh1dWJEEqMEtQ/Oe9dKKZUOKusZFdVicQV4F+dLiow4sZ1GVV6brEq25TPKGm+8hrB3bOGUXSQmC5zO5gSgxgzXytXyKoC+hQTMP3EofWaSoQHVFZ6jJiuV41dojzRsvIvL3PmdG36wDoddEDgtF/xHDbGMpfLDcQg0+OTQ2uVbx6FssBUj3iwEv6Kt57kInM+ZMR4OjQWLdOddE4u/Q/ZdrYDb3GoWlLL0SnNBqtSzKYRgGgbOi1eK0/JWT9I1n2Q2SvxneA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfUZO97KVOWL/mrdjGLc8SSRhpIyJqA8YnuOIMP7ztY=;
 b=DmXcmR3G0jgZL2aYRlkVEyaJEKKuW0JzqQH2JtogwhSrLtFz8JyMFvyx5eZ2NhFk3KpLT2jDcQP/5irxrJOcS5499GaPMudEvxWDmJbGTF3FryfS15pxclmkv8ITJCXdsCWN+8p6olnqV82yP75a5+AmppcZI0DRjwvu/hCwp5JZq2643gC7C0snUKm8MYQTmSKzhwx8QRBHLld0H4QVXPlil69T4jC71n8dKPXLvBldHbBikXrPOflydCesWWqEQ3KkwTS/5CyXMMJVYceP2LpmJbLOEZW4CgiYV/krLcYi5iXJG9N4EX1Lp7lLoxvgNvCM4UAg+Tzf+WYeGt4E5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfUZO97KVOWL/mrdjGLc8SSRhpIyJqA8YnuOIMP7ztY=;
 b=l3DG/dg6oYEW25bCWW4sZsuEGvhFsGW0Mwh/j3tfjAIJvs0ZOPRVW5m9XP9e3NE173rBKP72+KH/vpI4SC9yO4gq5EklAhHK0YMDFphYOc/qJgkJ9rCKsjezxngWeWUIg/0BvJZ0wV7P9NZh5A+946Rs4/35N2+54R1NQhmS9eU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Pierre-eric.Pelloux-prayer@amd.com; 
Received: from BL0PR12MB2420.namprd12.prod.outlook.com (2603:10b6:207:4c::23)
 by BL0PR12MB2388.namprd12.prod.outlook.com (2603:10b6:207:4a::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 14:10:27 +0000
Received: from BL0PR12MB2420.namprd12.prod.outlook.com
 ([fe80::bc14:f6fc:614f:3dc6]) by BL0PR12MB2420.namprd12.prod.outlook.com
 ([fe80::bc14:f6fc:614f:3dc6%6]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 14:10:27 +0000
Subject: Re: [PATCH] drm/amdgpu: fix the gfx hang while use per-ib secure flag
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1582639073-16555-1-git-send-email-ray.huang@amd.com>
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Message-ID: <7264c9ee-7d5e-95dd-59e0-4fae252cf6c9@amd.com>
Date: Tue, 25 Feb 2020 15:10:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <1582639073-16555-1-git-send-email-ray.huang@amd.com>
Content-Language: fr
X-ClientProxiedBy: PR0P264CA0047.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::35) To BL0PR12MB2420.namprd12.prod.outlook.com
 (2603:10b6:207:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.234] (109.190.135.109) by
 PR0P264CA0047.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 14:10:25 +0000
X-Originating-IP: [109.190.135.109]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 913eed6c-ab47-4fc6-0e70-08d7b9fc769b
X-MS-TrafficTypeDiagnostic: BL0PR12MB2388:|BL0PR12MB2388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2388BEC4D87F38C8FF71BF6E8DED0@BL0PR12MB2388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(199004)(189003)(5660300002)(54906003)(66476007)(66946007)(66556008)(31686004)(2906002)(36756003)(6666004)(478600001)(316002)(16576012)(26005)(86362001)(8676002)(52116002)(31696002)(55236004)(956004)(16526019)(2616005)(8936002)(81166006)(6486002)(53546011)(186003)(81156014)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2388;
 H:BL0PR12MB2420.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1UEGm1ljlL8YY9LvJH/SyJ0DtU59iBuXlaFWsqg/EQVp5ymYNL34aVkS/8SqohBG1L1McFOaj38LEhdhi9dJNCqJ3eUCmlWqxML7tgsVQHrbfncs3dUJ4x42grGrc1W+bh6TbOODTIiZzF8J871euDDZkq70dK+/LC/zxVwCTZba9DK4koDR3I2Wmb2jZsCfOJT0YsMjg2itCzJP7DYx5vaDB2meCvFzZeol+yjoD7z/ElofLGu8ts+Kym7bPbXhvfhGMA1un9opCVTEw59+78S6/3rN/+/Ey2QNDImb5sfNa6/jkiSlWXdYMG6+cOfIykm+ZS2soK3Xtv9/TBSegHyrK4jMwpi8nlla4B3uvzwapJyNp55l8xVvYH3mMHt8BqVvxUQG4CHP6T/whe2utIiNgV/OTyaW4Pl1x5aQxiqo0BN/su5s5hsfTvHr/7W7
X-MS-Exchange-AntiSpam-MessageData: gxAFVpwPOVo3lkzFu8OUkQvkXW5ox8IwssmvQP2Gldv/61zxSK6GFDyZdlfjZ0KCknwBi+NU4w/RqOFyBwW1RTqwHn0pjwhRSlrbYo0vKwKxSlq6AhOwKTGLCl7F1vbimEuKE+9zFSGfs40fnWqRXA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913eed6c-ab47-4fc6-0e70-08d7b9fc769b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 14:10:27.0943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3wIQGvLCQ/wdeea/Dn7W7WJrE1pG72ZtORuc543fbsLN45gsBiFwxqGEMpWdANzjA+GJs8voUj8/+L87G1WeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2388
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
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Ray,

I confirm that this fixes the hang I had when running libdrm's amdgpu_test.
Thanks!

Tested-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>


On 25/02/2020 14:57, Huang Rui wrote:
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
>  
>  	unsigned i;
>  	int r = 0;
> @@ -216,7 +216,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>  		amdgpu_ring_emit_cntxcntl(ring, status);
>  	}
>  
> -	secure = false;
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
