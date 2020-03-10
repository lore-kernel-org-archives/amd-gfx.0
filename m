Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8CBC10F27
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 11:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5478E24681
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 11:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RHWxrP71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5478E24681
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D520489D83;
	Tue, 10 Mar 2020 11:35:29 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760047.outbound.protection.outlook.com [40.107.76.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5943989CF7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 11:35:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nduhmqo381N3RrzxbHSFGD4bzKaZKHadbhj7PBSXgvBIcTnbEVJw/PgqBAtaYKkgvhRjwZoHyj1GZ5zx4Uatab1Kj/gKwVdy2Mzox4hpPvvo5c1pD8lb1w4/jgSU6+6B0p+a59gpspEdbWcVvhl/h+Hft0jb3DHFzPmbZBFO16+Vjva+HRfP36k5xU6RFHOiI4rxuiSI9U03zyT+X9Zt+feMaPJN5266/tVD3gQcpLz7kaEsXAPSLR34J2DeyTGJUxD85vKIaTfUpcSfzMRviTyCjUU9by4MzGd7+wMsVQO+YsYZA6iTSFJIOvBLYtFQOQXnU5nW/Jq1EpMMPvft2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSgDtEa+puCmPbhdwZAYOPTP/hO/QGDQJ+m0O2qKxjM=;
 b=QnU01OMnEpYh6QUN6J17GgMqX1nPYN7wmpVB8XjedCBQeVfnMnKP5uBUtjA6/lE7knXNt1KarNmUqnwqeKWS4jHWRsXpLdHuCP9ellHh2JCMeVg0lV+vfAd2rrkXB6ud7Nn/pj6Hegz62IEWmOQHkew0chuTqSE2I/Goz946jm/AP+OTdj3Zhy3v3eQTQVpS19qLn6/wdME+Nc2P+DJupkewVqjZ9dtt+SsKHUIPgY5sNfJqEztjE/sXyiMUhwbzyAlcIRPMqtJe9ZFNX5OPZb+/ceBOPRU4lF1ey13dDnmhdEmAGvntnz4zbcUx8l5LtgcpzTSaPGq1Na4iONgsXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSgDtEa+puCmPbhdwZAYOPTP/hO/QGDQJ+m0O2qKxjM=;
 b=RHWxrP71IEEi5P3DT3rDQfAL1rzzefuTrwqOSqVf0YMR+GgUMlvLNjSxFhb79WnXDwsgRq/in6kgD+mIReZxjw/YajCpYj1Vox3tGCXMPS+cspPZypxqatZc5sy4jCRRZrxvPg1uT3tl8TyXoUdKVyaFYv6xYB/lSBcJ/+vdiRo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1290.namprd12.prod.outlook.com (2603:10b6:3:74::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 11:35:27 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 11:35:27 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: cleanup drm_gpu_scheduler array creation
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200310112748.4899-1-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <ed446f25-2666-0926-8ed9-8d873ca9af7f@amd.com>
Date: Tue, 10 Mar 2020 12:39:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200310112748.4899-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR0202CA0009.eurprd02.prod.outlook.com
 (2603:10a6:208:1::22) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f32:a800:70e0:f409:f185:3dfd]
 (2003:c5:8f32:a800:70e0:f409:f185:3dfd) by
 AM0PR0202CA0009.eurprd02.prod.outlook.com (2603:10a6:208:1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend
 Transport; Tue, 10 Mar 2020 11:35:25 +0000
X-Originating-IP: [2003:c5:8f32:a800:70e0:f409:f185:3dfd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f75e567-3646-4c8f-791a-08d7c4e72118
X-MS-TrafficTypeDiagnostic: DM5PR12MB1290:|DM5PR12MB1290:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1290B560E3ADC388F896364B8BFF0@DM5PR12MB1290.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(8936002)(2906002)(31696002)(36756003)(66476007)(53546011)(4326008)(81166006)(6666004)(66556008)(31686004)(81156014)(6486002)(52116002)(2616005)(186003)(66946007)(16526019)(8676002)(316002)(478600001)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1290;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGvohiou9OSUa/dgfQbki5xKwEJb74s9+P5gt5nZ97ryHBkZ80X1kFfzvvAU1/UucdJ8xCuLW4N/zVc1PkkAcnLtBnZqDF6BNmEoymR+S0dAY1N2zMfTfkT03HL0YqRCqPUyc37fTu56X/ELpbNgjZHJIQZIUYgnPd8/BGoLJHLWW3+hURSfBmgDGHPGyRyjjxB6dyASThKZDQaQbjqLJ23OkT7NNtljlMwXGGkWuSx9iqtXR8a4FqFF8QXUr9/YWUWTmuV3vo6ykdQ8lSVwL//9cVmwzQx0LjVE7zak/GJgJtA82f0NzK0iYaP26E2mvwaEyLpC45fwgUmN7Ym7nIRVmoXO0njecRjbWAGAQTmsHSBCPP8WlUFStlfPskxPlmw2oZDTQhedaVAJTyAMF+frGB4K8JUJJQBtdnbVYs0cRlekt3WHkjSLnEKmZ063
X-MS-Exchange-AntiSpam-MessageData: +Pics0SHh1uLDxyHFoakuWR0EB0AGckRZ+AJk6HDjG0+iwPQCYNX53Cdqun0z/Hvz5llqE+GZv4ZkhE8rnmtom9SZWfYw/x4rHBTJt/WPObj+X4E2HyjGmmCnymY/U8ImsQs9+MbPQI9cCmXTGG+HfPz53Hl0Si4MwO/jWDytWi+5QuA5/3+nYThMbJbGTrMDuoWUhEC7MJrATSXmA3M9A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f75e567-3646-4c8f-791a-08d7c4e72118
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 11:35:26.9015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceTNRxN/crTo+4DNN/dHYTh5qqhpgytXx5g0YWmSE24ambuvftEdKcSa9CHKLMcL70litGvkH4M93Og8Hp3GGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1290
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Christian,


I think we still need amdgpu_ring.has_high_prio bool. I was thinking of 
using

amdgpu_gfx_is_high_priority_compute_queue() to see if a ring is set to 
high priority

but then I realized we don't support high priority gfx queue on gfx7 and 
less.


Regards,

Nirmoy

On 3/10/20 12:27 PM, Nirmoy Das wrote:
> Move initialization of struct drm_gpu_scheduler array,
> amdgpu_ctx_init_sched() to amdgpu_ring.c.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 68 -------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |  3 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   | 77 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  2 +
>   5 files changed, 80 insertions(+), 72 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 3b2370ad1e47..06d151c0fe4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -661,71 +661,3 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
>   	idr_destroy(&mgr->ctx_handles);
>   	mutex_destroy(&mgr->lock);
>   }
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
> -	adev->gfx.compute_prio_sched[i] =
> -		&adev->gfx.compute_sched[num_compute_sched_high - 1];
> -	adev->gfx.num_compute_sched[i] =
> -		adev->gfx.num_compute_rings - num_compute_sched_normal;
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
>   long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout);
>   void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
>   
> -void amdgpu_ctx_init_sched(struct amdgpu_device *adev);
> -
> -
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 572eb6ea8eab..b2a99f9fc223 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3092,7 +3092,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   			adev->gfx.config.max_cu_per_sh,
>   			adev->gfx.cu_info.number);
>   
> -	amdgpu_ctx_init_sched(adev);
> +	amdgpu_ring_init_sched(adev);
>   
>   	adev->accel_working = true;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index a7e1d0425ed0..99875dd633e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -454,3 +454,80 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring)
>   	ring->sched.ready = !r;
>   	return r;
>   }
> +
> +static void amdgpu_ring_init_compute_sched(struct amdgpu_device *adev)
> +{
> +	int num_compute_sched_normal = 0;
> +	int num_compute_sched_high = AMDGPU_MAX_COMPUTE_RINGS - 1;
> +	int i;
> +
> +	/* use one drm sched array, gfx.compute_sched to store both high and */
> +	/* normal priority drm compute schedulers */
> +	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +		if (!adev->gfx.compute_ring[i].has_high_prio)
> +			adev->gfx.compute_sched[num_compute_sched_normal++] =
> +				&adev->gfx.compute_ring[i].sched;
> +		else
> +			adev->gfx.compute_sched[num_compute_sched_high--] =
> +				&adev->gfx.compute_ring[i].sched;
> +	}
> +
> +	/* compute ring only has two priority for now */
> +	i = AMDGPU_GFX_PIPE_PRIO_NORMAL;
> +	adev->gfx.compute_prio_sched[i] = &adev->gfx.compute_sched[0];
> +	adev->gfx.num_compute_sched[i] = num_compute_sched_normal;
> +
> +	i = AMDGPU_GFX_PIPE_PRIO_HIGH;
> +	adev->gfx.compute_prio_sched[i] =
> +		&adev->gfx.compute_sched[num_compute_sched_high - 1];
> +	adev->gfx.num_compute_sched[i] =
> +		adev->gfx.num_compute_rings - num_compute_sched_normal;
> +}
> +
> +/**
> + * amdgpu_ring_init_sched - populate array of drm scheds for each HW IP
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Populate an array of struct drm_gpu_schedulers for each HW IP which
> + * can be use by amdgpu_ctx_get_entity() to initialize an entity.
> + *
> + */
> +
> +void amdgpu_ring_init_sched(struct amdgpu_device *adev)
> +{
> +	int i, j;
> +
> +	amdgpu_ring_init_compute_sched(adev);
> +	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +		adev->gfx.gfx_sched[i] = &adev->gfx.gfx_ring[i].sched;
> +		adev->gfx.num_gfx_sched++;
> +	}
> +
> +	for (i = 0; i < adev->sdma.num_instances; i++) {
> +		adev->sdma.sdma_sched[i] = &adev->sdma.instance[i].ring.sched;
> +		adev->sdma.num_sdma_sched++;
> +	}
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		adev->vcn.vcn_dec_sched[adev->vcn.num_vcn_dec_sched++] =
> +			&adev->vcn.inst[i].ring_dec.sched;
> +	}
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +		for (j = 0; j < adev->vcn.num_enc_rings; ++j)
> +			adev->vcn.vcn_enc_sched[adev->vcn.num_vcn_enc_sched++] =
> +				&adev->vcn.inst[i].ring_enc[j].sched;
> +	}
> +
> +	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> +		if (adev->jpeg.harvest_config & (1 << i))
> +			continue;
> +		adev->jpeg.jpeg_sched[adev->jpeg.num_jpeg_sched++] =
> +			&adev->jpeg.inst[i].ring_dec.sched;
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 9a443013d70d..4ccd056d4353 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -326,4 +326,6 @@ int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>   			     struct amdgpu_ring *ring);
>   void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
>   
> +void amdgpu_ring_init_sched(struct amdgpu_device *adev);
> +
>   #endif
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
