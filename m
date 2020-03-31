Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2642C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 01:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F29F2054F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 01:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z/x3DAG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F29F2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C78989CF3;
	Tue, 31 Mar 2020 01:01:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B197889CF3
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 01:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8F3NfHCCm06LO0PFeLy3vt7qy2BYDx9XvwkpJft7Syul5cf56hIXFyDWePtLf7IO6i8iqhSBXU9HJX33Q/9LSGVlbmha/8uIQKcZC19t5MC+rBM35mlTYxzE1CoNJpYzxYQhEtoFykVkVrBxxCGvppF8CXbIo0NwqY0uL7iwYhCZFBg/Vve/45ifVqUnSI/5dZCqItZJfvvdfb1VUjhOFpKUnHhnb1YUr6U2DqdxIoJXhTuaEeS6F2CROAvjHNnRtYI3++Qq+EMgdDtgoNzJISJbNSjqOsBEkRAnO4c4EhAA783tmvlOIglwuRJk7CAxTghsKshv0Ei6WqciuQHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Clx+DB4gFKOQrCkRUBu46ggRMFa+hBdT74oMXzBXsEo=;
 b=Vg0kOcxqFZUAQExneN5+WVHM8Ic/s0ar9iYd4/vzCP780NS+32GShqsFnAlKWKNTrn+OEwWWR1w1dY1u4xRzEiSZ6rjHHfKY1xyKb/9/JfvgRMRPedE0AWDrFghYXX6Cib1YRKpyKov4Ypc4F4eLBlf7Vn763aizFTbjY++xbcBHwYcMfI6oJOw5WQnO2Sv+mSK7tA54fEhG34qDs6lofRXk9FEO+RbhbX3FKqMKhpCE6J8ruLw5ix/FsmFbnNFtv1I/BujO6TB7IgoSEWoccOsogWarcGCSFKG3Ga/3jseg2nka0l9De08XUt+qQD4Y0cKY5kTw7CsmhtXV8thbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Clx+DB4gFKOQrCkRUBu46ggRMFa+hBdT74oMXzBXsEo=;
 b=Z/x3DAG/2tacXFoYPMRDeSQoSOy7ISY+3DvrbWRi6ElR7AhTAxJCZ80mDeitSCXuFzYCs1uAqSbzbx52QjU3lZL7W9QP/qmdxdTaLqZmBLaaArUWoYgy2kpTF6cIbFg2kR9WzfReuLN0D7C8npkEWqcOvOIePg5Bo5PhPo4WB5U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB2729.namprd12.prod.outlook.com (2603:10b6:5:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 01:01:38 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 01:01:37 +0000
Subject: Re: [PATCH v3 1/1] drm/amdgpu: rework sched_list generation
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200330154909.51100-1-nirmoy.das@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <7ee60b3e-5c8b-9af3-499b-f2326c97da7d@amd.com>
Date: Mon, 30 Mar 2020 21:01:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200330154909.51100-1-nirmoy.das@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: BN6PR2001CA0010.namprd20.prod.outlook.com
 (2603:10b6:404:b4::20) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN6PR2001CA0010.namprd20.prod.outlook.com (2603:10b6:404:b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Tue, 31 Mar 2020 01:01:35 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b4eb473b-1360-4dbc-27fc-08d7d50f1031
X-MS-TrafficTypeDiagnostic: DM6PR12MB2729:|DM6PR12MB2729:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB272906DEF9D387D7BB04DC0799C80@DM6PR12MB2729.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0359162B6D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(66946007)(86362001)(30864003)(478600001)(66476007)(4326008)(31696002)(8936002)(45080400002)(66556008)(52116002)(2906002)(81156014)(8676002)(44832011)(81166006)(956004)(966005)(2616005)(53546011)(6506007)(6486002)(186003)(36756003)(316002)(31686004)(6512007)(16526019)(5660300002)(26005)(579004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7DhPV89BegTbBYqpNwM1FbsNuR217uYdOAv7iFXy7BPvUD0tjDXQX7jeIOXSzr8KJJXacGc1WufZb+ZyqTdGzcrZKrFtiYm2RmfaGAa6g/PG3b++5ccuc71XGmfooypfDHtBUZwFcw+b7nl8oQe4Z7I6OnrvuCZR1Pt+PB6mJXTWPu+f8fzIRyE2tiwvcR129sQxz7ISw8h+/WyCsFTLvO2QUNwO+EBHT2gdDdnbhYpUq3VYBiEf6KHpikHvL3Bx6EdNScp0qCO4xyL2vdPocwukWChh0mnC3NPec+srA/XAHFMk0r48DsgAr9xUQNB32w43Abq2JJ/1mp5kpeYXf4Us3llt/t/AIcAAFFK0l0wGlnflXI3NkhZu+S/8x6m9VuWQAUdJf4MgrE0y+jgmUBhrxeelMp4FPcgCgqLf15yrrVpss5d/aQDJfd4hacUNeCNwkziVD19LBB+sr1WeEJ9NWukm5WcmIGfcdR601pw=
X-MS-Exchange-AntiSpam-MessageData: lZ9MxNjhgBgVachpNh3X7byaWQ7SloUm+1O6Xe4fLWSKKqEroi62coCx1vIjAutqluf8kFeu+6eWdIniDCCG3/m7fhXllnGXJm6yTiII1rT6yQ2h8nhp/YPuISh5aPLIQE/2cqS5zy7D3Bl0hrcy2A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4eb473b-1360-4dbc-27fc-08d7d50f1031
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2020 01:01:37.6343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49gF51kCEr29LB7qlRPB3NGR1UWjlHtb0aj4+Svhyota2neywmNL/iYV5LoH9BaJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2729
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
Cc: alexander.deucher@amd.com, ray.huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch seems to be using DOS line-endings. After converting
it to UNIX line-endings, the output of "git am" using "scripts/checkpatch.pl"
via the pre-commit hook is appended last to my thoughts below.

On 2020-03-30 11:49 a.m., Nirmoy Das wrote:
> Generate HW IP's sched_list in amdgpu_ring_init() instead of
> amdgpu_ctx.c. This makes amdgpu_ctx_init_compute_sched(),
> ring.has_high_prio and amdgpu_ctx_init_sched() unnecessary.
> This patch also stores sched_list for all HW IPs in one big
> array in struct amdgpu_device which makes amdgpu_ctx_init_entity()
> much more leaner.
> 
> v2:
> fix a coding style issue
> do not use drm hw_ip const to populate amdgpu_ring_type enum
> 
> v3:
> remove ctx reference and move sched array and num_sched to a struct
> use num_scheds to detect uninitialized scheduler list
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   8 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 156 ++++-----------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |   3 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   2 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |   5 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h   |   2 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  24 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  12 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h   |   2 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h    |   4 -
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |   3 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  13 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c      |   5 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |   5 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  11 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  13 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c     |   3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c     |   3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c     |   3 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |   3 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |   3 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |   6 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     |   3 +-
>  drivers/gpu/drm/amd/amdgpu/si_dma.c        |   3 +-
>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c      |   3 +-
>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c      |   3 +-
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c      |   7 +-
>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c      |   6 +-
>  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c      |   2 +-
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c      |   3 +-
>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c      |   3 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c      |   6 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c      |   6 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c      |   6 +-
>  35 files changed, 145 insertions(+), 198 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 29f0a410091b..27abbdc603dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -721,6 +721,11 @@ struct amd_powerplay {
>  	const struct amd_pm_funcs *pp_funcs;
>  };
> 
> +struct amdgpu_sched {
> +	uint32_t			num_scheds;
> +	struct drm_gpu_scheduler	*sched[HWIP_MAX_INSTANCE];
> +};
> +
>  #define AMDGPU_RESET_MAGIC_NUM 64
>  #define AMDGPU_MAX_DF_PERFMONS 4
>  struct amdgpu_device {
> @@ -858,6 +863,8 @@ struct amdgpu_device {
>  	struct amdgpu_ring		*rings[AMDGPU_MAX_RINGS];
>  	bool				ib_pool_ready;
>  	struct amdgpu_sa_manager	ring_tmp_bo[AMDGPU_IB_POOL_MAX];
> +	/* drm scheduler list */
> +	struct amdgpu_sched		gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];

That's a 2-dimensional array of "struct amdgpu_sched".
I think that the comment should be removed, or at least
not say "drm scheduler list". (I can see the structure
definition above.)

If this is the path you want to go, consider removing
"num_scheds" and creating a three dimensional array,
which would really essentialize the direction you want
to go:

struct drm_gpu_scheduler *gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX][HWIP_MAX_INSTANCE];

Now that this architecture is stripped down to its essentials,
perhaps we can see some optimizations...?

Also consider that since you're creating an array of pointers,
you don't necessarily need to know their count. Your hot-path
algorithms should not need to know it. If you need to print
their count, say in sysfs, then you can count them up on
behalf of the user-space process cat-ing the sysfs entry.

> 
>  	/* interrupts */
>  	struct amdgpu_irq		irq;
> @@ -993,6 +1000,7 @@ struct amdgpu_device {
>  	char				product_number[16];
>  	char				product_name[32];
>  	char				serial[16];
> +
>  };

Unnecessary empty line above.

> 
>  static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 6ed36a2c5f73..331646d472e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -72,13 +72,30 @@ static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sch
>  	}
>  }
> 
> +static unsigned int amdgpu_ctx_sched_prio_to_hw_prio(struct amdgpu_device *adev,
> +						     enum drm_sched_priority prio,
> +						     const int hw_ip)
> +{

The name of this function could be normalized from
the current pattern of "sched_prio_to_hw_prio" where "prio"
is repeated, to <domain>-<from>-<to> as follows:

amdgpu_ctx_prio_sched_to_hw(...)

Where the domain is "priority" and we're converting from "scheduler"
to "hw" priority.

> +	unsigned int hw_prio;
> +
> +	hw_prio = (hw_ip == AMDGPU_HW_IP_COMPUTE) ?
> +			amdgpu_ctx_sched_prio_to_compute_prio(prio) :
> +			AMDGPU_RING_PRIO_DEFAULT;

Parenthesis are unnecessary--relational = has higher priority than
ternary operator.

> +
> +	/* set to default prio if sched_list is NULL */
> +	if (!adev->gpu_sched[hw_ip][hw_prio].num_scheds)
> +		hw_prio = AMDGPU_RING_PRIO_DEFAULT;

That comment is a bit confusing--it talks about a list
not being NULL, while the conditional implicitly checks
against 0.

I'd much rather that integer comparison be performed against
integers, as opposed to using logical NOT operator (which is
implicit in comparing against 0), i.e.,

if (adev->gpu_sched[hw_ip][hw_prio].num_scheds == 0)

Also, architecturally, there seems to be informational
redundancy, in keeping an integer count and list of
objects at the same time, as the above if-conditional
exposes: the comment talks about a list and NULL but
the if-conditional implicitly checks for 0.

Perhaps, we don't need "num_scheds" and you can just
check if the index is NULL and assign PRIO_DEFAULT.

> +
> +	return hw_prio;
> +}
> +
>  static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const u32 ring)
>  {
>  	struct amdgpu_device *adev = ctx->adev;
>  	struct amdgpu_ctx_entity *entity;
>  	struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
>  	unsigned num_scheds = 0;
> -	enum gfx_pipe_priority hw_prio;
> +	unsigned int hw_prio;
>  	enum drm_sched_priority priority;
>  	int r;
> 
> @@ -90,52 +107,16 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const
>  	entity->sequence = 1;
>  	priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
>  				ctx->init_priority : ctx->override_priority;
> -	switch (hw_ip) {
> -	case AMDGPU_HW_IP_GFX:
> -		sched = &adev->gfx.gfx_ring[0].sched;
> -		scheds = &sched;
> -		num_scheds = 1;
> -		break;
> -	case AMDGPU_HW_IP_COMPUTE:
> -		hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(priority);
> -		scheds = adev->gfx.compute_prio_sched[hw_prio];
> -		num_scheds = adev->gfx.num_compute_sched[hw_prio];
> -		break;
> -	case AMDGPU_HW_IP_DMA:
> -		scheds = adev->sdma.sdma_sched;
> -		num_scheds = adev->sdma.num_sdma_sched;
> -		break;
> -	case AMDGPU_HW_IP_UVD:
> -		sched = &adev->uvd.inst[0].ring.sched;
> -		scheds = &sched;
> -		num_scheds = 1;
> -		break;
> -	case AMDGPU_HW_IP_VCE:
> -		sched = &adev->vce.ring[0].sched;
> -		scheds = &sched;
> -		num_scheds = 1;
> -		break;
> -	case AMDGPU_HW_IP_UVD_ENC:
> -		sched = &adev->uvd.inst[0].ring_enc[0].sched;
> -		scheds = &sched;
> -		num_scheds = 1;
> -		break;
> -	case AMDGPU_HW_IP_VCN_DEC:
> -		sched = drm_sched_pick_best(adev->vcn.vcn_dec_sched,
> -					    adev->vcn.num_vcn_dec_sched);
> -		scheds = &sched;
> -		num_scheds = 1;
> -		break;
> -	case AMDGPU_HW_IP_VCN_ENC:
> -		sched = drm_sched_pick_best(adev->vcn.vcn_enc_sched,
> -					    adev->vcn.num_vcn_enc_sched);
> +	hw_prio = amdgpu_ctx_sched_prio_to_hw_prio(adev, priority, hw_ip);
> +
> +
> +	scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
> +	num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
> +
> +	if (hw_ip == AMDGPU_HW_IP_VCN_ENC || hw_ip == AMDGPU_HW_IP_VCN_DEC) {
> +		sched = drm_sched_pick_best(scheds, num_scheds);
>  		scheds = &sched;
>  		num_scheds = 1;
> -		break;
> -	case AMDGPU_HW_IP_VCN_JPEG:
> -		scheds = adev->jpeg.jpeg_sched;
> -		num_scheds =  adev->jpeg.num_jpeg_sched;
> -		break;
>  	}
> 
>  	r = drm_sched_entity_init(&entity->entity, priority, scheds, num_scheds,
> @@ -178,7 +159,6 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>  	ctx->override_priority = DRM_SCHED_PRIORITY_UNSET;
> 
>  	return 0;
> -
>  }
> 
>  static void amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
> @@ -525,7 +505,7 @@ static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
>  					    enum drm_sched_priority priority)
>  {
>  	struct amdgpu_device *adev = ctx->adev;
> -	enum gfx_pipe_priority hw_prio;
> +	unsigned int hw_prio;
>  	struct drm_gpu_scheduler **scheds = NULL;
>  	unsigned num_scheds;
> 
> @@ -534,9 +514,10 @@ static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
> 
>  	/* set hw priority */
>  	if (hw_ip == AMDGPU_HW_IP_COMPUTE) {
> -		hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(priority);
> -		scheds = adev->gfx.compute_prio_sched[hw_prio];
> -		num_scheds = adev->gfx.num_compute_sched[hw_prio];
> +		hw_prio = amdgpu_ctx_sched_prio_to_hw_prio(adev, priority,
> +							   AMDGPU_HW_IP_COMPUTE);
> +		scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
> +		num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
>  		drm_sched_entity_modify_sched(&aentity->entity, scheds,
>  					      num_scheds);
>  	}
> @@ -665,78 +646,3 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
>  	idr_destroy(&mgr->ctx_handles);
>  	mutex_destroy(&mgr->lock);
>  }
> -
> -
> -static void amdgpu_ctx_init_compute_sched(struct amdgpu_device *adev)
> -{
> -	int num_compute_sched_normal = 0;
> -	int num_compute_sched_high = AMDGPU_MAX_COMPUTE_RINGS - 1;
> -	int i;
> -
> -	/* use one drm sched array, gfx.compute_sched to store both high and
> -	 * normal priority drm compute schedulers */
> -	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -		if (!adev->gfx.compute_ring[i].has_high_prio)
> -			adev->gfx.compute_sched[num_compute_sched_normal++] =
> -				&adev->gfx.compute_ring[i].sched;
> -		else
> -			adev->gfx.compute_sched[num_compute_sched_high--] =
> -				&adev->gfx.compute_ring[i].sched;
> -	}
> -
> -	/* compute ring only has two priority for now */
> -	i = AMDGPU_GFX_PIPE_PRIO_NORMAL;
> -	adev->gfx.compute_prio_sched[i] = &adev->gfx.compute_sched[0];
> -	adev->gfx.num_compute_sched[i] = num_compute_sched_normal;
> -
> -	i = AMDGPU_GFX_PIPE_PRIO_HIGH;
> -	if (num_compute_sched_high == (AMDGPU_MAX_COMPUTE_RINGS - 1)) {
> -		/* When compute has no high priority rings then use */
> -		/* normal priority sched array */
> -		adev->gfx.compute_prio_sched[i] = &adev->gfx.compute_sched[0];
> -		adev->gfx.num_compute_sched[i] = num_compute_sched_normal;
> -	} else {
> -		adev->gfx.compute_prio_sched[i] =
> -			&adev->gfx.compute_sched[num_compute_sched_high - 1];
> -		adev->gfx.num_compute_sched[i] =
> -			adev->gfx.num_compute_rings - num_compute_sched_normal;
> -	}
> -}
> -
> -void amdgpu_ctx_init_sched(struct amdgpu_device *adev)
> -{
> -	int i, j;
> -
> -	amdgpu_ctx_init_compute_sched(adev);
> -	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> -		adev->gfx.gfx_sched[i] = &adev->gfx.gfx_ring[i].sched;
> -		adev->gfx.num_gfx_sched++;
> -	}
> -
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		adev->sdma.sdma_sched[i] = &adev->sdma.instance[i].ring.sched;
> -		adev->sdma.num_sdma_sched++;
> -	}
> -
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		adev->vcn.vcn_dec_sched[adev->vcn.num_vcn_dec_sched++] =
> -			&adev->vcn.inst[i].ring_dec.sched;
> -	}
> -
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		for (j = 0; j < adev->vcn.num_enc_rings; ++j)
> -			adev->vcn.vcn_enc_sched[adev->vcn.num_vcn_enc_sched++] =
> -				&adev->vcn.inst[i].ring_enc[j].sched;
> -	}
> -
> -	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> -		if (adev->jpeg.harvest_config & (1 << i))
> -			continue;
> -		adev->jpeg.jpeg_sched[adev->jpeg.num_jpeg_sched++] =
> -			&adev->jpeg.inst[i].ring_dec.sched;
> -	}
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index de490f183af2..f54e10314661 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -88,7 +88,4 @@ void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);
>  long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout);
>  void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
> 
> -void amdgpu_ctx_init_sched(struct amdgpu_device *adev);
> -
> -
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 8faaa17ac296..d94eff9886a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3212,8 +3212,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  			adev->gfx.config.max_cu_per_sh,
>  			adev->gfx.cu_info.number);
> 
> -	amdgpu_ctx_init_sched(adev);
> -
>  	adev->accel_working = true;
> 
>  	amdgpu_vm_check_compute_bug(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 6b9c9193cdfa..92f2e59056c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -320,7 +320,8 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
>  	ring->eop_gpu_addr = kiq->eop_gpu_addr;
>  	sprintf(ring->name, "kiq_%d.%d.%d", ring->me, ring->pipe, ring->queue);
>  	r = amdgpu_ring_init(adev, ring, 1024,
> -			     irq, AMDGPU_CP_KIQ_IRQ_DRIVER0);
> +			     irq, AMDGPU_CP_KIQ_IRQ_DRIVER0,
> +			     AMDGPU_RING_PRIO_DEFAULT);
>  	if (r)
>  		dev_warn(adev->dev, "(%d) failed to init kiq ring\n", r);
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 5825692d07e4..634746829024 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -286,13 +286,8 @@ struct amdgpu_gfx {
>  	bool				me_fw_write_wait;
>  	bool				cp_fw_write_wait;
>  	struct amdgpu_ring		gfx_ring[AMDGPU_MAX_GFX_RINGS];
> -	struct drm_gpu_scheduler	*gfx_sched[AMDGPU_MAX_GFX_RINGS];
> -	uint32_t			num_gfx_sched;
>  	unsigned			num_gfx_rings;
>  	struct amdgpu_ring		compute_ring[AMDGPU_MAX_COMPUTE_RINGS];
> -	struct drm_gpu_scheduler        **compute_prio_sched[AMDGPU_GFX_PIPE_PRIO_MAX];
> -	struct drm_gpu_scheduler	*compute_sched[AMDGPU_MAX_COMPUTE_RINGS];
> -	uint32_t                        num_compute_sched[AMDGPU_GFX_PIPE_PRIO_MAX];
>  	unsigned			num_compute_rings;
>  	struct amdgpu_irq_src		eop_irq;
>  	struct amdgpu_irq_src		priv_reg_irq;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> index bd9ef9cc86de..5131a0a1bc8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> @@ -43,8 +43,6 @@ struct amdgpu_jpeg {
>  	uint8_t	num_jpeg_inst;
>  	struct amdgpu_jpeg_inst inst[AMDGPU_MAX_JPEG_INSTANCES];
>  	struct amdgpu_jpeg_reg internal;
> -	struct drm_gpu_scheduler *jpeg_sched[AMDGPU_MAX_JPEG_INSTANCES];
> -	uint32_t num_jpeg_sched;
>  	unsigned harvest_config;
>  	struct delayed_work idle_work;
>  	enum amd_powergating_state cur_state;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index a7e1d0425ed0..fadd91a04e07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -49,6 +49,18 @@
>   * them until the pointers are equal again.
>   */
> 
> +const unsigned int amdgpu_ring_type_to_drm_hw_ip[AMDGPU_HW_IP_NUM] = {
> +	[AMDGPU_RING_TYPE_GFX]      = AMDGPU_HW_IP_GFX,
> +	[AMDGPU_RING_TYPE_COMPUTE]  = AMDGPU_HW_IP_COMPUTE,
> +	[AMDGPU_RING_TYPE_SDMA]     = AMDGPU_HW_IP_DMA,
> +	[AMDGPU_RING_TYPE_UVD]      = AMDGPU_HW_IP_UVD,
> +	[AMDGPU_RING_TYPE_VCE]      = AMDGPU_HW_IP_VCE,
> +	[AMDGPU_RING_TYPE_UVD_ENC]  = AMDGPU_HW_IP_UVD_ENC,
> +	[AMDGPU_RING_TYPE_VCN_DEC]  = AMDGPU_HW_IP_VCN_DEC,
> +	[AMDGPU_RING_TYPE_VCN_ENC]  = AMDGPU_HW_IP_VCN_ENC,
> +	[AMDGPU_RING_TYPE_VCN_JPEG] = AMDGPU_HW_IP_VCN_JPEG,
> +};
> +

I'd just call this "amdgpu_ring_to_drm_hwip" for simplicity and brevity.

>  /**
>   * amdgpu_ring_alloc - allocate space on the ring buffer
>   *
> @@ -162,11 +174,13 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)
>   * Returns 0 on success, error on failure.
>   */
>  int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
> -		     unsigned max_dw, struct amdgpu_irq_src *irq_src,
> -		     unsigned irq_type)
> +		     unsigned int max_dw, struct amdgpu_irq_src *irq_src,
> +		     unsigned int irq_type, unsigned int hw_prio)
>  {
>  	int r, i;
>  	int sched_hw_submission = amdgpu_sched_hw_submission;
> +	unsigned int *num_sched;
> +	unsigned int hw_ip;
> 
>  	/* Set the hw submission limit higher for KIQ because
>  	 * it's used for a number of gfx/compute tasks by both
> @@ -258,6 +272,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  	ring->priority = DRM_SCHED_PRIORITY_NORMAL;
>  	mutex_init(&ring->priority_mutex);
> 
> +	if (ring->funcs->type != AMDGPU_RING_TYPE_KIQ) {
> +		hw_ip = amdgpu_ring_type_to_drm_hw_ip[ring->funcs->type];
> +		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
> +		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] = &ring->sched;
> +	}

This seems unnecessarily complicated. Perhaps we can remove
"num_scheds", as recommended above, and keep a running pointer
while initialization is being done...?

Just my thoughts.

Regards,
Luben
P.S. After converting from DOS line-endings:

$git am /tmp/\[PATCH\ v3\ 1_1\]\ drm_amdgpu\:\ rework\ sched_list\ generation.eml
Applying: drm/amdgpu: rework sched_list generation
-:10: CHECK: Prefer kernel type 'u32' over 'uint32_t'
#10: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu.h:725:
+	uint32_t			num_scheds;

-:22: WARNING: line over 81 characters
#22: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu.h:867:
+	struct amdgpu_sched		gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];

-:43: WARNING: line over 81 characters
#43: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c:76:
+						     enum drm_sched_priority prio,

-:115: CHECK: Please don't use multiple blank lines
#115: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c:112:
+
+

-:357: WARNING: line over 81 characters
#357: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:278:
+		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] = &ring->sched;

-:461: WARNING: line over 81 characters
#461: FILE: drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:1302:
+			     &adev->gfx.eop_irq, irq_type, AMDGPU_RING_PRIO_DEFAULT);

-:510: WARNING: line over 81 characters
#510: FILE: drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c:3113:
+				     &adev->gfx.eop_irq, AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,

-:520: WARNING: line over 81 characters
#520: FILE: drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c:3136:
+				     &adev->gfx.eop_irq, irq_type, AMDGPU_RING_PRIO_DEFAULT);

-:542: WARNING: line over 81 characters
#542: FILE: drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c:4508:
+				     &adev->gfx.eop_irq, AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,

-:827: WARNING: line over 81 characters
#827: FILE: drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c:455:
+			r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst[j].irq, 0,

-:837: WARNING: line over 81 characters
#837: FILE: drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c:475:
+			r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst[j].irq, 0,

-:851: WARNING: line over 81 characters
#851: FILE: drivers/gpu/drm/amd/amdgpu/vce_v2_0.c:437:
+				     &adev->vce.irq, 0, AMDGPU_RING_PRIO_DEFAULT);

-:950: WARNING: line over 81 characters
#950: FILE: drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:207:
+			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq, 0,

total: 0 errors, 11 warnings, 2 checks, 675 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
$_


> +
>  	for (i = 0; i < DRM_SCHED_PRIORITY_MAX; ++i)
>  		atomic_set(&ring->num_jobs[i], 0);
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 080024d21d3e..219fb1a07b12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -35,6 +35,9 @@
>  #define AMDGPU_MAX_VCE_RINGS		3
>  #define AMDGPU_MAX_UVD_ENC_RINGS	2
> 
> +#define AMDGPU_RING_PRIO_DEFAULT	1
> +#define AMDGPU_RING_PRIO_MAX		AMDGPU_GFX_PIPE_PRIO_MAX
> +
>  /* some special values for the owner field */
>  #define AMDGPU_FENCE_OWNER_UNDEFINED	((void *)0ul)
>  #define AMDGPU_FENCE_OWNER_VM		((void *)1ul)
> @@ -52,11 +55,11 @@ enum amdgpu_ring_type {
>  	AMDGPU_RING_TYPE_SDMA,
>  	AMDGPU_RING_TYPE_UVD,
>  	AMDGPU_RING_TYPE_VCE,
> -	AMDGPU_RING_TYPE_KIQ,
>  	AMDGPU_RING_TYPE_UVD_ENC,
>  	AMDGPU_RING_TYPE_VCN_DEC,
>  	AMDGPU_RING_TYPE_VCN_ENC,
> -	AMDGPU_RING_TYPE_VCN_JPEG
> +	AMDGPU_RING_TYPE_VCN_JPEG,
> +	AMDGPU_RING_TYPE_KIQ
>  };
> 
>  struct amdgpu_device;
> @@ -221,7 +224,6 @@ struct amdgpu_ring {
>  	struct mutex		priority_mutex;
>  	/* protected by priority_mutex */
>  	int			priority;
> -	bool			has_high_prio;
> 
>  #if defined(CONFIG_DEBUG_FS)
>  	struct dentry *ent;
> @@ -259,8 +261,8 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
>  void amdgpu_ring_commit(struct amdgpu_ring *ring);
>  void amdgpu_ring_undo(struct amdgpu_ring *ring);
>  int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
> -		     unsigned ring_size, struct amdgpu_irq_src *irq_src,
> -		     unsigned irq_type);
> +		     unsigned int ring_size, struct amdgpu_irq_src *irq_src,
> +		     unsigned int irq_type, unsigned int prio);
>  void amdgpu_ring_fini(struct amdgpu_ring *ring);
>  void amdgpu_ring_emit_reg_write_reg_wait_helper(struct amdgpu_ring *ring,
>  						uint32_t reg0, uint32_t val0,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 2f4412e030a4..e5b8fb8e75c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -61,8 +61,6 @@ struct amdgpu_sdma_ras_funcs {
> 
>  struct amdgpu_sdma {
>  	struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
> -	struct drm_gpu_scheduler    *sdma_sched[AMDGPU_MAX_SDMA_INSTANCES];
> -	uint32_t		    num_sdma_sched;
>  	struct amdgpu_irq_src	trap_irq;
>  	struct amdgpu_irq_src	illegal_inst_irq;
>  	struct amdgpu_irq_src	ecc_irq;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 6fe057329de2..2d0633d5515f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -196,10 +196,6 @@ struct amdgpu_vcn {
>  	uint8_t	num_vcn_inst;
>  	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
>  	struct amdgpu_vcn_reg	 internal;
> -	struct drm_gpu_scheduler *vcn_enc_sched[AMDGPU_MAX_VCN_ENC_RINGS];
> -	struct drm_gpu_scheduler *vcn_dec_sched[AMDGPU_MAX_VCN_INSTANCES];
> -	uint32_t		 num_vcn_enc_sched;
> -	uint32_t		 num_vcn_dec_sched;
> 
>  	unsigned	harvest_config;
>  	int (*pause_dpg_mode)(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> index cc1033784720..20f108818b2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -979,7 +979,8 @@ static int cik_sdma_sw_init(void *handle)
>  				     &adev->sdma.trap_irq,
>  				     (i == 0) ?
>  				     AMDGPU_SDMA_IRQ_INSTANCE0 :
> -				     AMDGPU_SDMA_IRQ_INSTANCE1);
> +				     AMDGPU_SDMA_IRQ_INSTANCE1,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 51be7aa2d5ec..18e6d1b0dee9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -1299,7 +1299,7 @@ static int gfx_v10_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
> 
>  	irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + ring->pipe;
>  	r = amdgpu_ring_init(adev, ring, 1024,
> -			     &adev->gfx.eop_irq, irq_type);
> +			     &adev->gfx.eop_irq, irq_type, AMDGPU_RING_PRIO_DEFAULT);
>  	if (r)
>  		return r;
>  	return 0;
> @@ -1310,7 +1310,8 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>  {
>  	int r;
>  	unsigned irq_type;
> -	struct amdgpu_ring *ring = &adev->gfx.compute_ring[ring_id];
> +	struct amdgpu_ring *ring;
> +	int hw_prio;
> 
>  	ring = &adev->gfx.compute_ring[ring_id];
> 
> @@ -1329,10 +1330,11 @@ static int gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>  	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
>  		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
>  		+ ring->pipe;
> -
> +	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
> +			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
>  	/* type-2 packets are deprecated on MEC, use type-3 instead */
>  	r = amdgpu_ring_init(adev, ring, 1024,
> -			     &adev->gfx.eop_irq, irq_type);
> +			     &adev->gfx.eop_irq, irq_type, hw_prio);
>  	if (r)
>  		return r;
> 
> @@ -3261,11 +3263,8 @@ static void gfx_v10_0_compute_mqd_set_priority(struct amdgpu_ring *ring, struct
>  	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>  		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
>  			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
> -			ring->has_high_prio = true;
>  			mqd->cp_hqd_queue_priority =
>  				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
> -		} else {
> -			ring->has_high_prio = false;
>  		}
>  	}
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> index 73d2b96e02b1..e5252aafabf0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -3110,7 +3110,8 @@ static int gfx_v6_0_sw_init(void *handle)
>  		ring->ring_obj = NULL;
>  		sprintf(ring->name, "gfx");
>  		r = amdgpu_ring_init(adev, ring, 1024,
> -				     &adev->gfx.eop_irq, AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP);
> +				     &adev->gfx.eop_irq, AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>  		if (r)
>  			return r;
>  	}
> @@ -3132,7 +3133,7 @@ static int gfx_v6_0_sw_init(void *handle)
>  		sprintf(ring->name, "comp_%d.%d.%d", ring->me, ring->pipe, ring->queue);
>  		irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP + ring->pipe;
>  		r = amdgpu_ring_init(adev, ring, 1024,
> -				     &adev->gfx.eop_irq, irq_type);
> +				     &adev->gfx.eop_irq, irq_type, AMDGPU_RING_PRIO_DEFAULT);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index f5ab0f1c6ca6..bb489246f9aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4433,7 +4433,7 @@ static int gfx_v7_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
> 
>  	/* type-2 packets are deprecated on MEC, use type-3 instead */
>  	r = amdgpu_ring_init(adev, ring, 1024,
> -			&adev->gfx.eop_irq, irq_type);
> +			&adev->gfx.eop_irq, irq_type, AMDGPU_RING_PRIO_DEFAULT);
>  	if (r)
>  		return r;
> 
> @@ -4505,7 +4505,8 @@ static int gfx_v7_0_sw_init(void *handle)
>  		ring->ring_obj = NULL;
>  		sprintf(ring->name, "gfx");
>  		r = amdgpu_ring_init(adev, ring, 1024,
> -				     &adev->gfx.eop_irq, AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP);
> +				     &adev->gfx.eop_irq, AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 5e5d7bae57ec..2da78ea55b8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1894,6 +1894,7 @@ static int gfx_v8_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>  	int r;
>  	unsigned irq_type;
>  	struct amdgpu_ring *ring = &adev->gfx.compute_ring[ring_id];
> +	int hw_prio;
> 
>  	ring = &adev->gfx.compute_ring[ring_id];
> 
> @@ -1913,9 +1914,11 @@ static int gfx_v8_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>  		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
>  		+ ring->pipe;
> 
> +	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
> +			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_RING_PRIO_DEFAULT;
>  	/* type-2 packets are deprecated on MEC, use type-3 instead */
>  	r = amdgpu_ring_init(adev, ring, 1024,
> -			&adev->gfx.eop_irq, irq_type);
> +			&adev->gfx.eop_irq, irq_type, hw_prio);
>  	if (r)
>  		return r;
> 
> @@ -2019,7 +2022,8 @@ static int gfx_v8_0_sw_init(void *handle)
>  		}
> 
>  		r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
> -				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP);
> +				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>  		if (r)
>  			return r;
>  	}
> @@ -4432,11 +4436,8 @@ static void gfx_v8_0_mqd_set_priority(struct amdgpu_ring *ring, struct vi_mqd *m
>  	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>  		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
>  			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
> -			ring->has_high_prio = true;
>  			mqd->cp_hqd_queue_priority =
>  				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
> -		} else {
> -			ring->has_high_prio = false;
>  		}
>  	}
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 1fea077ef748..1486e612da39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2190,6 +2190,7 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>  	int r;
>  	unsigned irq_type;
>  	struct amdgpu_ring *ring = &adev->gfx.compute_ring[ring_id];
> +	int hw_prio;
> 
>  	ring = &adev->gfx.compute_ring[ring_id];
> 
> @@ -2208,10 +2209,11 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>  	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
>  		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
>  		+ ring->pipe;
> -
> +	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
> +			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
>  	/* type-2 packets are deprecated on MEC, use type-3 instead */
>  	r = amdgpu_ring_init(adev, ring, 1024,
> -			     &adev->gfx.eop_irq, irq_type);
> +			     &adev->gfx.eop_irq, irq_type, hw_prio);
>  	if (r)
>  		return r;
> 
> @@ -2305,7 +2307,9 @@ static int gfx_v9_0_sw_init(void *handle)
>  		ring->use_doorbell = true;
>  		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
>  		r = amdgpu_ring_init(adev, ring, 1024,
> -				     &adev->gfx.eop_irq, AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP);
> +				     &adev->gfx.eop_irq,
> +				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>  		if (r)
>  			return r;
>  	}
> @@ -3369,11 +3373,8 @@ static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd *m
>  	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>  		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue)) {
>  			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
> -			ring->has_high_prio = true;
>  			mqd->cp_hqd_queue_priority =
>  				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
> -		} else {
> -			ring->has_high_prio = false;
>  		}
>  	}
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> index 0debfd9f428c..0105519a856f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> @@ -480,7 +480,8 @@ int jpeg_v1_0_sw_init(void *handle)
> 
>  	ring = &adev->jpeg.inst->ring_dec;
>  	sprintf(ring->name, "jpeg_dec");
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0);
> +	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
> +			     AMDGPU_RING_PRIO_DEFAULT);
>  	if (r)
>  		return r;
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index ba6aeff122da..9ae8247fb13b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -106,7 +106,8 @@ static int jpeg_v2_0_sw_init(void *handle)
>  	ring->use_doorbell = true;
>  	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1;
>  	sprintf(ring->name, "jpeg_dec");
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0);
> +	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
> +			     AMDGPU_RING_PRIO_DEFAULT);
>  	if (r)
>  		return r;
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index c04c2078a7c1..54f66926f0d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -118,7 +118,8 @@ static int jpeg_v2_5_sw_init(void *handle)
>  		ring->use_doorbell = true;
>  		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + 8 * i;
>  		sprintf(ring->name, "jpeg_dec_%d", i);
> -		r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst[i].irq, 0);
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst[i].irq, 0,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>  		if (r)
>  			return r;
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> index 9211583adfa8..5f304d61999e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -873,7 +873,8 @@ static int sdma_v2_4_sw_init(void *handle)
>  				     &adev->sdma.trap_irq,
>  				     (i == 0) ?
>  				     AMDGPU_SDMA_IRQ_INSTANCE0 :
> -				     AMDGPU_SDMA_IRQ_INSTANCE1);
> +				     AMDGPU_SDMA_IRQ_INSTANCE1,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index 8077b01c1f52..c59f6f6f4c09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -1157,7 +1157,8 @@ static int sdma_v3_0_sw_init(void *handle)
>  				     &adev->sdma.trap_irq,
>  				     (i == 0) ?
>  				     AMDGPU_SDMA_IRQ_INSTANCE0 :
> -				     AMDGPU_SDMA_IRQ_INSTANCE1);
> +				     AMDGPU_SDMA_IRQ_INSTANCE1,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index db03bcff3348..352cd9632770 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1859,7 +1859,8 @@ static int sdma_v4_0_sw_init(void *handle)
> 
>  		sprintf(ring->name, "sdma%d", i);
>  		r = amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
> -				     AMDGPU_SDMA_IRQ_INSTANCE0 + i);
> +				     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>  		if (r)
>  			return r;
> 
> @@ -1877,7 +1878,8 @@ static int sdma_v4_0_sw_init(void *handle)
>  			sprintf(ring->name, "page%d", i);
>  			r = amdgpu_ring_init(adev, ring, 1024,
>  					     &adev->sdma.trap_irq,
> -					     AMDGPU_SDMA_IRQ_INSTANCE0 + i);
> +					     AMDGPU_SDMA_IRQ_INSTANCE0 + i,
> +					     AMDGPU_RING_PRIO_DEFAULT);
>  			if (r)
>  				return r;
>  		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index d6299786a068..5e6e4ea1a8ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1234,7 +1234,8 @@ static int sdma_v5_0_sw_init(void *handle)
>  				     &adev->sdma.trap_irq,
>  				     (i == 0) ?
>  				     AMDGPU_SDMA_IRQ_INSTANCE0 :
> -				     AMDGPU_SDMA_IRQ_INSTANCE1);
> +				     AMDGPU_SDMA_IRQ_INSTANCE1,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> index 3da3422c2d77..7d2bbcbe547b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> @@ -504,7 +504,8 @@ static int si_dma_sw_init(void *handle)
>  				     &adev->sdma.trap_irq,
>  				     (i == 0) ?
>  				     AMDGPU_SDMA_IRQ_INSTANCE0 :
> -				     AMDGPU_SDMA_IRQ_INSTANCE1);
> +				     AMDGPU_SDMA_IRQ_INSTANCE1,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> index 957e14e2c155..3cafba726587 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -118,7 +118,8 @@ static int uvd_v4_2_sw_init(void *handle)
> 
>  	ring = &adev->uvd.inst->ring;
>  	sprintf(ring->name, "uvd");
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0);
> +	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0,
> +			     AMDGPU_RING_PRIO_DEFAULT);
>  	if (r)
>  		return r;
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> index 2aad6689823b..a566ff926e90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -116,7 +116,8 @@ static int uvd_v5_0_sw_init(void *handle)
> 
>  	ring = &adev->uvd.inst->ring;
>  	sprintf(ring->name, "uvd");
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0);
> +	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0,
> +			     AMDGPU_RING_PRIO_DEFAULT);
>  	if (r)
>  		return r;
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index 81186be66600..0a880bc101b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -418,7 +418,8 @@ static int uvd_v6_0_sw_init(void *handle)
> 
>  	ring = &adev->uvd.inst->ring;
>  	sprintf(ring->name, "uvd");
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0);
> +	r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0,
> +			     AMDGPU_RING_PRIO_DEFAULT);
>  	if (r)
>  		return r;
> 
> @@ -430,7 +431,9 @@ static int uvd_v6_0_sw_init(void *handle)
>  		for (i = 0; i < adev->uvd.num_enc_rings; ++i) {
>  			ring = &adev->uvd.inst->ring_enc[i];
>  			sprintf(ring->name, "uvd_enc%d", i);
> -			r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst->irq, 0);
> +			r = amdgpu_ring_init(adev, ring, 512,
> +					     &adev->uvd.inst->irq, 0,
> +					     AMDGPU_RING_PRIO_DEFAULT);
>  			if (r)
>  				return r;
>  		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index eef56211b3a2..db8364667177 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -452,7 +452,8 @@ static int uvd_v7_0_sw_init(void *handle)
>  		if (!amdgpu_sriov_vf(adev)) {
>  			ring = &adev->uvd.inst[j].ring;
>  			sprintf(ring->name, "uvd_%d", ring->me);
> -			r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst[j].irq, 0);
> +			r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst[j].irq, 0,
> +					     AMDGPU_RING_PRIO_DEFAULT);
>  			if (r)
>  				return r;
>  		}
> @@ -471,7 +472,8 @@ static int uvd_v7_0_sw_init(void *handle)
>  				else
>  					ring->doorbell_index = adev->doorbell_index.uvd_vce.uvd_ring2_3 * 2 + 1;
>  			}
> -			r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst[j].irq, 0);
> +			r = amdgpu_ring_init(adev, ring, 512, &adev->uvd.inst[j].irq, 0,
> +					     AMDGPU_RING_PRIO_DEFAULT);
>  			if (r)
>  				return r;
>  		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index b6837fcfdba7..74c9f567bcd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -434,7 +434,7 @@ static int vce_v2_0_sw_init(void *handle)
>  		ring = &adev->vce.ring[i];
>  		sprintf(ring->name, "vce%d", i);
>  		r = amdgpu_ring_init(adev, ring, 512,
> -				     &adev->vce.irq, 0);
> +				     &adev->vce.irq, 0, AMDGPU_RING_PRIO_DEFAULT);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 217db187207c..6d9108fa22e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -442,7 +442,8 @@ static int vce_v3_0_sw_init(void *handle)
>  	for (i = 0; i < adev->vce.num_rings; i++) {
>  		ring = &adev->vce.ring[i];
>  		sprintf(ring->name, "vce%d", i);
> -		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0);
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index 5e986dea4645..a0fb119240f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -476,7 +476,8 @@ static int vce_v4_0_sw_init(void *handle)
>  			else
>  				ring->doorbell_index = adev->doorbell_index.uvd_vce.vce_ring2_3 * 2 + 1;
>  		}
> -		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0);
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index f570ac72a351..1ad79155ed00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -127,7 +127,8 @@ static int vcn_v1_0_sw_init(void *handle)
> 
>  	ring = &adev->vcn.inst->ring_dec;
>  	sprintf(ring->name, "vcn_dec");
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0);
> +	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> +			     AMDGPU_RING_PRIO_DEFAULT);
>  	if (r)
>  		return r;
> 
> @@ -145,7 +146,8 @@ static int vcn_v1_0_sw_init(void *handle)
>  	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>  		ring = &adev->vcn.inst->ring_enc[i];
>  		sprintf(ring->name, "vcn_enc%d", i);
> -		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0);
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index b3b5e5cac400..89ebeb28f499 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -133,7 +133,8 @@ static int vcn_v2_0_sw_init(void *handle)
>  	ring->doorbell_index = adev->doorbell_index.vcn.vcn_ring0_1 << 1;
> 
>  	sprintf(ring->name, "vcn_dec");
> -	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0);
> +	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> +			     AMDGPU_RING_PRIO_DEFAULT);
>  	if (r)
>  		return r;
> 
> @@ -163,7 +164,8 @@ static int vcn_v2_0_sw_init(void *handle)
>  		else
>  			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + i;
>  		sprintf(ring->name, "vcn_enc%d", i);
> -		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0);
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 22540265aee5..c881e1b28481 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -191,7 +191,8 @@ static int vcn_v2_5_sw_init(void *handle)
>  		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
>  				(amdgpu_sriov_vf(adev) ? 2*j : 8*j);
>  		sprintf(ring->name, "vcn_dec_%d", j);
> -		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq, 0);
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq, 0,
> +				     AMDGPU_RING_PRIO_DEFAULT);
>  		if (r)
>  			return r;
> 
> @@ -203,7 +204,8 @@ static int vcn_v2_5_sw_init(void *handle)
>  					(amdgpu_sriov_vf(adev) ? (1 + i + 2*j) : (2 + i + 8*j));
> 
>  			sprintf(ring->name, "vcn_enc_%d.%d", j, i);
> -			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq, 0);
> +			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq, 0,
> +					     AMDGPU_RING_PRIO_DEFAULT);
>  			if (r)
>  				return r;
>  		}
> --
> 2.25.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cluben.tuikov%40amd.com%7C05503615828d419b121d08d7d4c14931%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637211798960734673&amp;sdata=t4PJwt2ooR471rAFEt1pDCwqyX4N7%2B6pSTpNpf%2B8s4o%3D&amp;reserved=0
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
