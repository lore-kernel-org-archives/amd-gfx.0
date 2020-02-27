Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D101BC4BA24
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 11:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E67D24693
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 11:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vM5umq/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E67D24693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57A8589E2A;
	Thu, 27 Feb 2020 11:47:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B459A89E2A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 11:47:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6yuzlxRDnMJFp4bd7QBzleKL4u1GA/NOZn22zqv2aAvDReCkCd6xQH03mJTnH8QD8CuKBBhYZHgJyI9xLEB8x4juqoh/vRPrs8RpQMBSJEsxL1JNejRDnACSPazAP++3pe0+9jqf89LJf6gQpscDfCa7KqZT9kz9UT3tORx5BWZCkmZQX9JrEOtd/p0bD6JFTG6fKN3K3pt7bgKiXFxk3H88SGBXQmL1lQVvEjHxMi/vwEoHECrvod+kh1Ca9ibX0ZYtfU+E12yQL58eGGfptGO2KjudZoVlVQIWawIL5jSYz46mi+ciSktGORNVT11vu7b/P8bhmtF6rI0nUqAjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49wU1twK9SojJX2ClNff5B6/6nC+eoGiyIbiP/BGYi8=;
 b=Y5fit3bGIzL7ejtn/6xlHPtFIHR3hFRpAXxWZySIM4uyBq9TlMNsUeNZmNqshT2F/sFCE9DlJfFo076J3xw0i1bKFQYhsbKXUqPv7EHJHM1euAlenxAV5glgTHtB4wSberTN4V5RF/gxiGZj10qiSVCpq6++1VxfSYBp6Ehh0ducPqwJ9D5yxRgkMhl/SXDw1JfKTuoQDyst4CcKxRjU687CZBVFdplTNa+S31js9RTz8ez0rW+BwWlBcdYmjIX4JO02ypMTJSLZLchLANxEXNbCZN0W/sZLtbr3fpobK1EKVHwJq2wgpANdclSZlLacZi0KRBAx4i63FG3+Bw9jpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49wU1twK9SojJX2ClNff5B6/6nC+eoGiyIbiP/BGYi8=;
 b=vM5umq/W23JpKsWHma7gHm3W31FCThSfebFgAgv1DCminYJWbYLOWmLSnNRM3cGQeD8bu8rn80Y9F97hjw9te6A5/6nIlRVmEhlz4WHUE+fB/GiAoJWl9VocSRU34S8W6ppKMGh5DFZx93teScmYwaU6P+81i1gFPCqMMY+zQdw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1259.namprd12.prod.outlook.com (2603:10b6:3:75::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 27 Feb
 2020 11:47:23 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2750.021; Thu, 27 Feb
 2020 11:47:23 +0000
Subject: Re: [PATCH v2] drm/amdgpu: fix the gfx hang while use per-ib secure
 flag (v2)
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1582803483-27446-1-git-send-email-ray.huang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <377c5042-8890-4ccf-b376-c282c1231970@amd.com>
Date: Thu, 27 Feb 2020 12:47:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <1582803483-27446-1-git-send-email-ray.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0054.eurprd02.prod.outlook.com
 (2603:10a6:208:d2::31) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0054.eurprd02.prod.outlook.com (2603:10a6:208:d2::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21 via Frontend Transport; Thu, 27 Feb 2020 11:47:21 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c065109-d1d6-4ed4-0f06-08d7bb7aceee
X-MS-TrafficTypeDiagnostic: DM5PR12MB1259:|DM5PR12MB1259:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB125966AB56E850418B9F4D1483EB0@DM5PR12MB1259.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(189003)(199004)(478600001)(4326008)(31696002)(86362001)(36756003)(81156014)(81166006)(8936002)(8676002)(16526019)(186003)(6486002)(316002)(66556008)(66476007)(66946007)(6666004)(52116002)(2616005)(54906003)(2906002)(5660300002)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1259;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8UYYbyTK3f2surEYuLSioOCL8vgAPmAVa6NTEMm/wNh8eotNyN4cenpXNAKdQuyagD5VAp5N2FuqYpzgjg6E5+q6J3y4cDrIF+aHLGk0EgdyiOrtWAmFn84FB+ZuM2layOS37SHcll5G1HrHuW8LVL2zm4XK7If3AVJ4aBg/9aVuLjfE3AONyrJQXYivuARvkbKloEVkv4avWjPxtVOV6Y3rvDWCrOIeqGxGfIT3uJu9oC4xaU/e4b7TYt8jUZW6uZm883jq8CvasxT+zjmsoARmWSP/bLnbLh16QnzGblwJfUnPI0zX0FPP3Bo5apFug46hROvQZQhxI+EP6Q5ZpXGH88tM7DgH9WdRq58HSVHslfiQnGFSnG17nSuD3Sr5ec2LuXBWJ7s6t0GdYeupB2i9VB2UxnKZV51dxuf/JCV+DhLc7vTEfQeKBBUWxE35
X-MS-Exchange-AntiSpam-MessageData: +nB4r1gX4Mz3v+yX7rmyFRsWSnGTT65ekbCekeK2KQN+H/XAYTXWZCWaSEg0+jV89XL8cw2vxNoEInPJF+S7YUMaWvbewFhhg3QJeY4kD2PiS+eYW8ro9u9Iy3rEaE3S4s8WiJe1dyFyRU6D4igocOkusdCv92zcpF8lEQYJbLarI1GfxUeKipKEew5YeP+paH3Zdpejdy0LcqUeXdDTTg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c065109-d1d6-4ed4-0f06-08d7bb7aceee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 11:47:23.2085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/Bx2g7RWHBwrGjjG0Id1IfcTqc5PeGtU2gpBJBVL5AEcQ72eqya8XSCtgkr5A0+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1259
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
 Luben Tuikov <luben.tuikov@amd.com>, Aaron Liu <aaron.liu@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.02.20 um 12:38 schrieb Huang Rui:
> Since 6643ba1 frame control packets are only issued in presence of secure IB(s).
> This causes hangs on some hardware (eg: Raven1). This patch restores the
> unconditionnal frame control packets issuing, that's to keep the per-IB logic
> regarding the secure flag.
>
> Fixes: 6643ba1 drm/amdgpu: Move to a per-IB secure flag (TMZ)
>
> v1 -> v2:
> As suggested by Luben, and accept part of implemetation from this patch:
> - Put "secure" closed to the loop and use optimization
> - Change "secure" to bool again, and move "secure == -1" out of loop.
>
> Reported-and-Tested-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 29 +++++++++++++++--------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 +++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 15 ++++++++-------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 13 +++++++------
>   4 files changed, 33 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 4b2342d..0f4909a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -216,7 +216,14 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   		amdgpu_ring_emit_cntxcntl(ring, status);
>   	}
>   
> +	/* Setup initial TMZiness and send it off.
> +	 */
>   	secure = false;
> +	if (job && ring->funcs->emit_frame_cntl) {

Does anybody remember why we check the job here in the first place?

Independent of that I think that the check if 
ring->funcs->emit_frame_cntl should be moved into the 
amdgpu_ring_emit_frame_cntl() function so that we don't need to repeat 
that over and over again.

If amdgpu_ring_emit_frame_cntl() is still a macro then that is probably 
also a good opportunity to change that.

> +		secure = ib->flags & AMDGPU_IB_FLAGS_SECURE ? true : false;
> +		amdgpu_ring_emit_frame_cntl(ring, true, secure);
> +	}
> +
>   	for (i = 0; i < num_ibs; ++i) {
>   		ib = &ibs[i];
>   
> @@ -228,27 +235,21 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   		    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
>   			continue;
>   
> -		/* If this IB is TMZ, add frame TMZ start packet,
> -		 * else, turn off TMZ.
> -		 */
> -		if (ib->flags & AMDGPU_IB_FLAGS_SECURE && ring->funcs->emit_tmz) {
> -			if (!secure) {
> -				secure = true;
> -				amdgpu_ring_emit_tmz(ring, true);
> +		if (job && ring->funcs->emit_frame_cntl) {
> +			if (!!secure ^ !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {

Maybe write this as (secure != !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)). 
That is probably easier to understand.

Regards,
Christian.

> +				amdgpu_ring_emit_frame_cntl(ring, false, secure);
> +				secure = !secure;
> +				amdgpu_ring_emit_frame_cntl(ring, true, secure);
>   			}
> -		} else if (secure) {
> -			secure = false;
> -			amdgpu_ring_emit_tmz(ring, false);
>   		}
>   
>   		amdgpu_ring_emit_ib(ring, job, ib, status);
>   		status &= ~AMDGPU_HAVE_CTX_SWITCH;
>   	}
>   
> -	if (secure) {
> -		secure = false;
> -		amdgpu_ring_emit_tmz(ring, false);
> -	}
> +	if (job && ring->funcs->emit_frame_cntl)
> +		amdgpu_ring_emit_frame_cntl(ring, false,
> +					    secure ? true : false);
>   
>   #ifdef CONFIG_X86_64
>   	if (!(adev->flags & AMD_IS_APU))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 24caff0..4d019d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -166,7 +166,8 @@ struct amdgpu_ring_funcs {
>   	void (*emit_reg_write_reg_wait)(struct amdgpu_ring *ring,
>   					uint32_t reg0, uint32_t reg1,
>   					uint32_t ref, uint32_t mask);
> -	void (*emit_tmz)(struct amdgpu_ring *ring, bool start);
> +	void (*emit_frame_cntl)(struct amdgpu_ring *ring, bool start,
> +				bool secure);
>   	/* priority functions */
>   	void (*set_priority) (struct amdgpu_ring *ring,
>   			      enum drm_sched_priority priority);
> @@ -247,7 +248,7 @@ struct amdgpu_ring {
>   #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
>   #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))
>   #define amdgpu_ring_emit_reg_write_reg_wait(r, d0, d1, v, m) (r)->funcs->emit_reg_write_reg_wait((r), (d0), (d1), (v), (m))
> -#define amdgpu_ring_emit_tmz(r, b) (r)->funcs->emit_tmz((r), (b))
> +#define amdgpu_ring_emit_frame_cntl(r, b, s) (r)->funcs->emit_frame_cntl((r), (b), (s))
>   #define amdgpu_ring_pad_ib(r, ib) ((r)->funcs->pad_ib((r), (ib)))
>   #define amdgpu_ring_init_cond_exec(r) (r)->funcs->init_cond_exec((r))
>   #define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec((r),(o))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 7b61583..748ac35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -256,7 +256,7 @@ static int gfx_v10_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev);
>   static int gfx_v10_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev);
>   static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume);
>   static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume);
> -static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start);
> +static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start, bool secure);
>   
>   static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
>   {
> @@ -4729,12 +4729,13 @@ static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
>   					   sizeof(de_payload) >> 2);
>   }
>   
> -static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start)
> +static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
> +				    bool secure)
>   {
> -	if (amdgpu_is_tmz(ring->adev)) {
> -		amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> -		amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
> -	}
> +	uint32_t v = secure ? FRAME_TMZ : 0;
> +
> +	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> +	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
>   }
>   
>   static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg)
> @@ -5188,7 +5189,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>   	.init_cond_exec = gfx_v10_0_ring_emit_init_cond_exec,
>   	.patch_cond_exec = gfx_v10_0_ring_emit_patch_cond_exec,
>   	.preempt_ib = gfx_v10_0_ring_preempt_ib,
> -	.emit_tmz = gfx_v10_0_ring_emit_tmz,
> +	.emit_frame_cntl = gfx_v10_0_ring_emit_frame_cntl,
>   	.emit_wreg = gfx_v10_0_ring_emit_wreg,
>   	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
>   	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 1c7a16b..fbde712 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5230,12 +5230,13 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
>   	amdgpu_ring_write_multiple(ring, (void *)&de_payload, sizeof(de_payload) >> 2);
>   }
>   
> -static void gfx_v9_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start)
> +static void gfx_v9_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
> +				   bool secure)
>   {
> -	if (amdgpu_is_tmz(ring->adev)) {
> -		amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> -		amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
> -	}
> +	uint32_t v = secure ? FRAME_TMZ : 0;
> +
> +	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
> +	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
>   }
>   
>   static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
> @@ -6477,7 +6478,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>   	.emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
>   	.init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
>   	.patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
> -	.emit_tmz = gfx_v9_0_ring_emit_tmz,
> +	.emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
>   	.emit_wreg = gfx_v9_0_ring_emit_wreg,
>   	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
>   	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
