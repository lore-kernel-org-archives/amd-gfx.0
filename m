Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06863C4BA04
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 22:56:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF7220838
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 22:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZIK1DGDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF7220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D78E89242;
	Tue, 25 Feb 2020 22:56:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E52889242
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 22:56:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/00Death4IaaJi1szlcq9zJ7BxX0t3pE7YlbRHft2t3izVSe5tSc9AMdwuHQCrPbyBeICvKUgKFxfMkCL3o16HW7VwcOPoHeql5DMdx4vNcvjYx0kKX/iQ1BWaFiTvN5KkvmeCP2yHaIPrNwv2zjx6lXhwy/DpbU9g+qXkIuYWq8gIzG/M5FUYlQKlkPZyfz0CeDMef0yhbEKIUU2ja9V0W2Ra1FWDHYLEOo+KVTWYVFVGnpUtTRnLCRFQFUtJ/41CHIMJ+hvxEq1x7glcccENOFURj73PPAbqSvZEitXlpRZJiRmP5fS3FBfJk1UGqtfVVnlbeM20/44yCMQf7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KCohlzNPLLHd/cELKI62MCjaYYL3GeyL2d8bt/TjvU=;
 b=lb39pM+3JCO4hGket5Y6O4meo/+mBYgG0Hk/HRs8Va2qNUSoc2SRdVghutXN2yD/ZfavTYkUamGxXjijcFs4mIx9DOVPqhUzSfCdQOCCjE1IgmCOUqv8k0g6iZ35rHR7Lx75aqGpoXB7xyNGUBx27p7SvfDK2E3bpVaQbGwJEzOrI9YdKXwEfkG7Zvw7zpRkpKasz22R6cKip01QwFwSiL1nwpHVP2eg++Wad52TDLb6u94srfmZCYdKeMHNNRWuJlG09B1RZEh8Sgky/twlsSB08q/j5PdWXuUBACo7QnWqCMSL0W+rbbPipVFj2O8kczpugTiEWDEhCkHldd90gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KCohlzNPLLHd/cELKI62MCjaYYL3GeyL2d8bt/TjvU=;
 b=ZIK1DGDQ7hr0Rt1S77G3tkKAddhO9mNXgi/aK+vFNqegDs2YdBPq14u8lcdhuVAMxC5xntKNMH+2Hwtl+waUyFcoFJatxQssClovVxrt24Y5r1THFwBTNEXeDKTzHL2BHq6wXpTt0w+hZk3COuzAJM1XI+0F41Rux4RZwwoi2kQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 22:56:36 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 22:56:36 +0000
Subject: Re: [PATCH] drm/amdgpu: fix the gfx hang while use per-ib secure flag
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1582639073-16555-1-git-send-email-ray.huang@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <19bad72c-202e-115c-2974-d4ab8cf75f4a@amd.com>
Date: Tue, 25 Feb 2020 17:56:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <1582639073-16555-1-git-send-email-ray.huang@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTOPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::26) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTOPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Tue, 25 Feb 2020 22:56:35 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7739ff97-2271-4feb-80f3-08d7ba45f704
X-MS-TrafficTypeDiagnostic: DM6PR12MB4092:|DM6PR12MB4092:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4092CF3FC780CD592362EFCF99ED0@DM6PR12MB4092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(199004)(189003)(478600001)(53546011)(36756003)(31686004)(6486002)(2906002)(86362001)(31696002)(316002)(4326008)(5660300002)(52116002)(54906003)(44832011)(81166006)(2616005)(26005)(186003)(8936002)(66476007)(956004)(16526019)(66556008)(8676002)(81156014)(6512007)(66946007)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4092;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LW8sHgrXFxLfn6QGXxnhE1WxCTdNIratNLdJljtPglZpkGWGP4IY4QQUQtXPNtOplxqkZr1l6TV1m0yTdHNr1Ue8oJwmHHGjE8+nBMndZhMsJPMwTIk5RzXowO4eV7oxtHHaE3fzbN3hsaG/JD4vtD8zAsSytbPi4fwEd9gORN3/tT0EAesqA/zG0ELjAytcOAnVSs5Mw1Nm/nxT+IO008WB8pLCgGZpO/118h/nOB/Rc2uP/RO/ZrYuQxkpfIJgqCpAA9g566EgPL1fNOX3mpON7emoHdYhVWAHdVpxQsplg00DbRZEMHIy1Dx0ByB3ts7p4e4IuD/Xk94pzWJ8AzLEQVOzazgROYU/U6hD05nVcuutMhuiLqAXJx/PGvMQe1B28Jd8ROQMqbBjD9TboNUQ08jmA309yQzBSU8/5YAJ+srFJJvN9AMTH64X88WQ
X-MS-Exchange-AntiSpam-MessageData: f/5SkONuDaD8IZKpr07NloORvrCrkvExiWB9PHHjuIHpAQY5r/wXUsrE4xrfh/PLgzN1NI44nxzDkDzm2jp5aLBGp825mJq2/C1UReni9djiu8b2bTklvsE2frDf82GEEXqWFja0g5gYOZmC7JtkVg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7739ff97-2271-4feb-80f3-08d7ba45f704
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 22:56:35.8750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WJ72ClKn0Kw5t67xNG4Y6TpuKhB1nEjgaggDkwkJT/CyHM5KNzkqLPW3zf91aDC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
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

Thanks for fixing this Ray.

I think we can simplify the logic introduced in this patch.

Regards,
Luben

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
