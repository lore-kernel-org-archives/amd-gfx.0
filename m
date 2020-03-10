Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4825C18E5B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 13:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824C22467D
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 13:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xXKV7+9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824C22467D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381A36E0AA;
	Tue, 10 Mar 2020 13:01:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 619686E0AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 13:00:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0V56dvTQSxf7iN0TXVXougJsNNtnpig0yTlWfu0qj5V4g156Yl2hUQIrwTjS5pKV3SlF2jlPROS3jCsjsx6vUHN3Vwebc6xP1q9KKDoOmGiRmlMa9QKWhCJczUptR/nSpcKfuBwqvYGXXrkjGXlY5Nl9aglzStB5qz3vxe+dLuWLGRR3enbhoY6DjbbVsF/yl385EMn03KLVxbeWZuILok732arZo3ltR8TYTDh6t+3koWosoAOCJfuRXLvRPu6K2i8ZJ9AeAVMMqhTK9NUKd/p9QSGdhTZgLbDok9LRa/JjdO+XDZ99W7ghH8oxCKpE1nwVky1X+OZROSepGJN0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJgB8MKb4jM8DYvhKTVmR6XrvQRHFm2C4Urmbv2lSXg=;
 b=Oojj2N9s0Bv2ZmU0AMMZ6WBnbboKiQ5dJoes+gTmU1xIMM3GBXra0g5Xj5bpkMSYvuskuWe1NMcS2qwOb1BG54blBm2OPjrJEltacV2cWctDsLrv/RrLwDxf2EVGBhzJw3/v38dpkO+bRppS1hh7xQZc18M+G8/CzAFbfJvw/cbWY8z2ISHx3RPlYH/Mgy9tgW9Bf2zkTvBw25a3YnUH6xeyBd1gmCdWT3kNW0bI6/pp3xQFqb7NNLPNawDjoywyYXiywpFrML7AY8kXAhMBR5obVKI6Aib01d2WFQeNL3RNjLg4LpM3Qv+Ae5izstE+0FmiBv8zfY37vETRaLGXHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJgB8MKb4jM8DYvhKTVmR6XrvQRHFm2C4Urmbv2lSXg=;
 b=xXKV7+9xNGrmVue1VEgvQvEoAjiLivSOPSa0QY0McuJKjNA2ZtjziUFsvdc0NnVmPwfkGyF1O80RV+L0Ewqa2sy5gsBJU37B76kDy3b/IHTDdwvSZfqRa/SA/gePJ5YDQrRSKA1KQsTTH7mVKTJ0VMTanBOMOp5TaUSK1zXjuco=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1436.namprd12.prod.outlook.com (2603:10b6:3:78::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 13:00:56 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2793.013; Tue, 10 Mar
 2020 13:00:56 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: cleanup drm_gpu_scheduler array creation
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200310122456.3240-1-nirmoy.das@amd.com>
 <20200310122456.3240-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a6922665-28f5-8d48-8c99-c052b9f75b42@amd.com>
Date: Tue, 10 Mar 2020 14:00:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200310122456.3240-2-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::24) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR01CA0083.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend
 Transport; Tue, 10 Mar 2020 13:00:55 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: efe031a3-b512-42bb-c67e-08d7c4f31264
X-MS-TrafficTypeDiagnostic: DM5PR12MB1436:|DM5PR12MB1436:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB143642EC017C1E668468E84783FF0@DM5PR12MB1436.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(189003)(199004)(6666004)(4326008)(31686004)(31696002)(6486002)(36756003)(16526019)(478600001)(316002)(186003)(2906002)(5660300002)(66946007)(2616005)(66556008)(52116002)(8936002)(66476007)(8676002)(81156014)(86362001)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1436;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OI7mgh4smtSLHIL2HzwQQj6hVDuR+M9pk9KSti7gsMkK0t+1z/tHLYDGOdnE+6ZmyQl5wa5sAek+iDuyHsYnDnRng8nRIpCwMz3kV61hdxGbXDGHNSx2vT0LsbmRwyBtMPqJrKvuf4ZnR8hPxroN3LQv+fM+rD0qf7kXKv0dMOc0AXBZYlWSWUdpvacZMIGBrsVIoVuTZffOiH0aMb8TSed2dGOD2FaDJiY8EfjiWHKlelmi0mJp9TD5+PGoMRrN82dEX53eqXyh1L4ZI/AlcA27B+QAeQYy36LkwpF5rDZMHA1SmRKDzaxakYb5ecLclM0M2F+lwDnCCcr2feYKw8v0fSZz7zj3ETKN9JW/DKY7uBX5uENLPieIrefStMOJS3dG7T3VcNh9D/rIF6U+SlvOLkiVKOUVxR1QljBKPR+zLMYzXQvEFqxHj4edTRiM
X-MS-Exchange-AntiSpam-MessageData: z3Ote3j7FCTdRDoq09wvlEK2Apnefij9wZXqwbsc/M8oWCdHBwrsC+mmgFQVuR/kvpvYStz4aMXsQoZoXlizgQHB6flWzluMEd4dcd1V/RAJCIUly+yU2RYs/UgwTX9lid1iri7Ypux3wOwznSz88ge+0epJ0exNeUB0cLSduReyCCjvpbpH7WCJv9IdnMf6dcwHxiclgDP5kkzuR6U4Og==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe031a3-b512-42bb-c67e-08d7c4f31264
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 13:00:56.3434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0i5XD+udj/71wcsAjg8LyAw+Yrl/BpiL/3g165YHyub2XmplHwK4UX2t/zwl3yx2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1436
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.03.20 um 13:24 schrieb Nirmoy Das:
> Move initialization of struct drm_gpu_scheduler array,
> amdgpu_ctx_init_sched() to amdgpu_ring.c.

Moving the code around is a start, but it doesn't buy us much.

We could go for the big cleanup or at least move the individual 
scheduler arrays from the per IP structures into amdgpu_device.c

How much time can and want you to spend on it?

Christian.

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 75 -------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |  3 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   | 85 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  2 +
>   5 files changed, 88 insertions(+), 79 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index fa575bdc03c8..06d151c0fe4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -661,78 +661,3 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
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
> index a7e1d0425ed0..01faeb8b4ef2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -454,3 +454,88 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring)
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
> +	if (num_compute_sched_high == (AMDGPU_MAX_COMPUTE_RINGS - 1)) {
> +		/* When compute has no high priority rings then use */
> +		/* normal priority sched array */
> +		adev->gfx.compute_prio_sched[i] = &adev->gfx.compute_sched[0];
> +		adev->gfx.num_compute_sched[i] = num_compute_sched_normal;
> +	} else {
> +
> +		adev->gfx.compute_prio_sched[i] =
> +			&adev->gfx.compute_sched[num_compute_sched_high - 1];
> +		adev->gfx.num_compute_sched[i] =
> +			adev->gfx.num_compute_rings - num_compute_sched_normal;
> +	}
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
