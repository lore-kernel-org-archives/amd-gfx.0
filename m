Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9171C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 13:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ABF618B5A5;
	Tue, 19 Jul 2022 13:58:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F26B18B599
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 13:58:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebgO0S9Aq245ZPq40NkluzHlCben3kXDukZvUJ6eYUD732W5EBE21LaO39IU8xx4t1CKR0plmufb0EIGB4p4+GtpiEBGmPIHNplN1gdzbF0q8QGXli4F7PWwAhYCYZ9DJve/OCiipw4vKPev8wajZzQw93VYPFi9NZitepSdOXYucBcl8W9L8h762bVBjqXJQDaWK5K1Kta2r+XTDjtRAtaVY9sKi6OSbsTRdaHH8AwxD06FBJgZ98gZzrZkPPFTgU9nfFF+cXUwwooiERNWFrn1GU0VtP4juOegcUizVW7IFddp2/+1qEMM60mhfG2435UNSAKgB42vkRG7wpjMKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAT80Utr+LnOF0rGiyNGBh9ztnjNPUY+zgl+tn1g6t0=;
 b=Dk0irX6h6bjdYXkuC/SQD2gy/+HaR5kJcdC9//QGMXDidBPAayRYpHTxQoQIHgiUu16j07wyIKtOOVNCl28HW6Gc5Z2sDFdUx0DORnsoK/KSEVkTtQ01lBoTFUPRRjZqL4tuGoWitD1eHcQLHSDyUjg1TaIboiRBRoFLmP5jofGJ0JhN/xCGXQV/VlBQjRFE+/TnxLucbiZflBzdTxPyHHqtxPnKRpgm+zkIi5DpZfZ6KU3MIMq+Mdh6vr35XllEVs+sGO0vZOUYoVCpJ+8OpC4YazmipNiL8m5x7lp9cVAFT55kBOR3MDLaDIi23u1SZ83sU0fzKwWtV3HqdfA0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAT80Utr+LnOF0rGiyNGBh9ztnjNPUY+zgl+tn1g6t0=;
 b=uBXma0URKO9dv2zae83Vk9o9aToDCD009l9AZeew0GWhWQmEO55t8oTIQatkhQz4m4b61hsqgflomv8fY39xM+HdxUKDsFbZl8to83zc2ucF8w7jpJxGLjzYrPmY4922RRU05IKbhyHCklNO6QiyQvsT92C41pvcWz53WRN1gH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BYAPR12MB3430.namprd12.prod.outlook.com (2603:10b6:a03:ad::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Tue, 19 Jul
 2022 13:58:43 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 13:58:43 +0000
Message-ID: <bd9908fb-c5a9-4e0a-2efd-aa6e7c05faec@amd.com>
Date: Tue, 19 Jul 2022 15:58:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amdgpu: modify mcbp implement for gfx9
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220719020918.410753-1-Jiadong.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220719020918.410753-1-Jiadong.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR04CA0049.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::26) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7521ad2-17b3-4bb6-838c-08da698eca54
X-MS-TrafficTypeDiagnostic: BYAPR12MB3430:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USP+BYh2CgpJpEJDIHKGW+dSeYY3MEGNB7b+nXsJUJ9BRFO11L/17SkElQ/aDja1osMnrrL56/Rq9FExfDweBrpkniXL9PI1F5lAm77BVjXp293DjMTsNNacX6aAaqVThOnZdryrh7C6We6RAXFFsJW+wPhkEBJTBTeyWIr29GtU7K8RgzzaT4XKjIaOHKlj3SxljvDOkwHkfOkuH82sZBuKJTdTJXnBaup6RYzWtw9/r7nZIs6zYxRgLlaKPAfNlkk4+lD4MT5Nh+bZVgaIYIaM1S/9l/Ryd8DCe65x3lKDhHIwlV6MeTOT84Tmvt4xoylk7MT/dbXiRr8kMmrFEOYmCsW4DIq7NvcUYJwjgBsvZAgycNDhlBNrBIxMRXMUUi5FMh/dTjPOC3IcW/7fIrB8OTjSbjnDaQssa22WPpjcYxKxMtFmUv8qIN3A9t0Kum7Tbo1S1sLi6V0ul5yjBUh0tZAZH2wmOJF1Nvr2vYpHXAcqcFyGCL3r9Q4Df87+5nY9+rkgMnDJSw1wddtRG7pX9tQ7VLCFWiPoXU4YAdBnHoCl9EERmcW8NbRniXQBVaJv0ESvLhlYuVH5Oouk48aSQaTRn+tyrf0Gu+YnRVEvbEQaUzEoduaCEMe1J7i7sBQASsFbkJMgnt+yUUTAxFdFNgbv0l5TlI7YLJ1VIRBdTJ0th/qIVZuf3IUxZ11TIJe+QBvcJeYRENvDrGvVTCMbLwBZC6lXf1dMgVqajTx69Gc7P7PEGSbDXtRAJubcJwYzU8qArnKW84GuRtUm8Wu3e4z2m/uIEnuJXspfMAsatf/x7Z2yPLvfZGet/1E0sfanf/JJMbui1XBYPN+IZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(5660300002)(4326008)(316002)(66556008)(66476007)(8936002)(2906002)(66946007)(8676002)(83380400001)(31686004)(36756003)(6512007)(38100700002)(31696002)(86362001)(41300700001)(6666004)(6506007)(186003)(478600001)(6486002)(30864003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXY1UHhRKzhPN3czcVo4elVPbFpFdjFVcWpqd3ZKYVNrWUZQYXc0ejFOQmJH?=
 =?utf-8?B?NndXQ1pVQ2JxMy9uSktwL1dCSHRhbTRnZVo1dWlyWCtVNXc2ZEF1RlpiMHpT?=
 =?utf-8?B?ekdmZWJQMS96NFA5UmdUZW1URml6dyt4bmxWSnluTlJFRVVGYUtFc3ZwM05R?=
 =?utf-8?B?TExEOTBWWGNuOENQR1dmbnJSVEpiRVpRL2dBSmFEZlNXaU80YXoyaWRpQ0Er?=
 =?utf-8?B?RWgxTG8yNFdVWDVjMm0yZ2l5dG85QTliTFh1dWZuRFNGMnZIRys0OVBzTHR6?=
 =?utf-8?B?VGQyZk9SOWVkd0tDSHdRbkxhNnZmR3U1MlZ2S2Q2SU4xdUFuaEVsc2VqaU1S?=
 =?utf-8?B?N0ZPMzR0TldpQ3J2NUNSNGJNMGsyeTVLdlBXRkJxSE1vdzg3WnZySWJpRXI5?=
 =?utf-8?B?dVNvdHNVSWVaQk9Tak9sVmhyYXFlbUZGcUM4Q2xKQlNNSXh6bWN4a0czcjRG?=
 =?utf-8?B?czFtNjlleVg1RVZ1bGZBVm8wNXpOWEgyeG8rb1F0OXZYNzJhQUMyY3B2eDFQ?=
 =?utf-8?B?M2NDUXFNYzcxSHdJZ2NSOUR6RlRQK08rZFlFc3kvbzFmMWRlKzJWNzgxWXBk?=
 =?utf-8?B?SUxnRUkwb2Z5MDJWVzdyTlpiK2ZWd01JYXFPQ1Znc2hxaTNab0FWYkxGZFpo?=
 =?utf-8?B?MmgrVW1DU1RYd01ybXBxR3l5eW81Vk4xVzJqZmJFMDk1aURnZTg3blFQVFdN?=
 =?utf-8?B?MGlsWXVEcXN5QWJJTHFOUmpwTEFLckxaWlRmTFdSYWZaa0FGNS82ZUdRSUJI?=
 =?utf-8?B?SVI1SXhoVDRjdklQcFFjT244S0IzYWFrRkdRUWlLbXZ1N0g1UHZGQTVsaU5s?=
 =?utf-8?B?TnFSKzJ1WGVFTDdFOUFlUjlnRkVuVitYU0djVGd6aEN4NlRDS0JkMGdZYUpL?=
 =?utf-8?B?U2xDckVBdFluOUdBQ2Nyayt3SDdaRUM2TGFZNzFza0tyaGEzMDFZU3BrYW8v?=
 =?utf-8?B?d0tUQ3FZYUNoMzRDVnVNZkhCK3BTaXpuZ09DaGNqWWlHeSswVjZ5V0dNellh?=
 =?utf-8?B?MnNic2ZDNExmVVhCakRGelMxbkEwTGFpM3MrSHNnbDdqdGlWSGMyQ3h4cWlC?=
 =?utf-8?B?SmdQUG0rQVNXMzNpS3RmRFpKanJTRWw3eGJnQkpUbUJCSG14cERUZWlHYnRh?=
 =?utf-8?B?V2F5MnJZUVpnaTRta09ZSytOM2p0alBkM0lmOEdEV01GbmRqMzZ6TDczVXpj?=
 =?utf-8?B?Q3plU1Z2ZHpKMEwvSDJBRWszS1d5Yzh2L2dvNWp2RnIyMTdQRkZUREdLbUFt?=
 =?utf-8?B?cTgwVElEVGxYYWNCT3lxY3grb3VGWkw5NkpkUmJNUTdwVm1PbHB5d2Q5MytN?=
 =?utf-8?B?Z2hqNVloV2t0U0FOUVpTT0tYQS9mZDBnSWpKOFJoTktUNkFTdk8rZ21SOG13?=
 =?utf-8?B?SmtNVHFCdFd5SW9sRTd6aXluemxLeHZUbmkzNVhuZmt4bEtURXJxTEY1VnZG?=
 =?utf-8?B?bHpoTmpoeHowckM0cWRXMC81TlhtSUcrRmFHbU12UVg0VHpScTl1RjA4em5I?=
 =?utf-8?B?VVJiSXc5VlYrWjNoNmRsZnhBWFVzM1VPUE5pN1VRY3Y4TEorMGVTZXRieDBr?=
 =?utf-8?B?RktVVGdBaHF0VlpIczI5UitiY3J2RUdJVVVlS2IwRjU1Z1BBSU4zU3hFbDNY?=
 =?utf-8?B?VWZ2ZnZCTk9OMmZ5UEd1Ni9KbVZMU2NsRUZpZHV5alF0SDZTOWpZUDRNRTRL?=
 =?utf-8?B?UGFJeEsrTDFMTWZrMWMxc2xPOERZZ0VOQUxaT2VLTjZHbFZGVVJHbzhCZE9R?=
 =?utf-8?B?Y3ZUUHYveXU4Nm11SXhBV3p5SjdoZktXelRFcTVqbWVDOHA5MVRRWmxVbmkz?=
 =?utf-8?B?SGJnVDVWV0ZQMDZNM0FGVVpiQTVIS0JhZkNYUU9TTUMyd2NBWkFMQlNQMDl3?=
 =?utf-8?B?S2JhUDh6WGZ4SHVXc1grdkp0NldEU1FCeklGMDJ4SFJDbUdLM3kzVStFelJt?=
 =?utf-8?B?am1VOW9ZOFNtRmNzU0xxVmFjQmxjVWY5QmdyUGMxeTJGVWFmOUFYUWVodjVR?=
 =?utf-8?B?c05PT0QzUnZyY3JpSnhNWmgzTkkzS2pmb1JEMjc4cnBTM0JKNWRNQXM2VERQ?=
 =?utf-8?B?NEN3U3grcmNMUUdBcEtZNTJwRzliMVZnRFJQT1BMcnpxSEJHbG1GMGdlN0o1?=
 =?utf-8?B?QTVrOXhaY0hiOW9iUThrb3hPN0V0Ly9xbEVkdHk4QWh1UHovVTlpNENSWVRS?=
 =?utf-8?Q?vGcnWLrSL3Q1v7mZZT6cWE22/L2868Eq94wYTNd3wfYX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7521ad2-17b3-4bb6-838c-08da698eca54
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 13:58:43.1061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLTKx/j5xO9orh9vX5lb3lnp+gpIlUSI9DCGaHiHvtRSwhDwPK11z42TlfAB0V7L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3430
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
Cc: Ray.Huang@amd.com, aaron.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Well what's the background for this?

So far MCBP isn't a validated feature, we just added some debugfs 
interface for testing it.

Regards,
Christian.

Am 19.07.22 um 04:09 schrieb jiadong.zhu@amd.com:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>
> 1. Use unmap_queue package to trigger preemption on gfx9
>     Add trailing fence to track the preemption done.
> 2. Modify emit_ce_meta emit_de_meta functions
>     for the resumed ibs.
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 156 ++++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/soc15d.h      |   2 +
>   3 files changed, 138 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 82c178a9033a..ca626f0ad7b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -59,6 +59,7 @@ enum amdgpu_ring_priority_level {
>   #define AMDGPU_FENCE_FLAG_64BIT         (1 << 0)
>   #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
>   #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
> +#define AMDGPU_FENCE_FLAG_EXEC          (1 << 3)
>   
>   #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 5332899642dc..e2c614441691 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -751,7 +751,7 @@ static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
>   static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
>   				struct amdgpu_cu_info *cu_info);
>   static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
> -static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
> +static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume);
>   static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
>   static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
>   					  void *ras_error_status);
> @@ -824,9 +824,10 @@ static void gfx_v9_0_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
>   			PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(ring->doorbell_index));
>   
>   	if (action == PREEMPT_QUEUES_NO_UNMAP) {
> -		amdgpu_ring_write(kiq_ring, lower_32_bits(gpu_addr));
> -		amdgpu_ring_write(kiq_ring, upper_32_bits(gpu_addr));
> -		amdgpu_ring_write(kiq_ring, seq);
> +		amdgpu_ring_write(kiq_ring, lower_32_bits(ring->wptr & ring->buf_mask));
> +		amdgpu_ring_write(kiq_ring, 0);
> +		amdgpu_ring_write(kiq_ring, 0);
> +
>   	} else {
>   		amdgpu_ring_write(kiq_ring, 0);
>   		amdgpu_ring_write(kiq_ring, 0);
> @@ -5446,11 +5447,15 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>   
>   	control |= ib->length_dw | (vmid << 24);
>   
> -	if (amdgpu_sriov_vf(ring->adev) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
> +	if ((amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
>   		control |= INDIRECT_BUFFER_PRE_ENB(1);
>   
> +		if (flags & AMDGPU_IB_PREEMPTED)
> +			control |= INDIRECT_BUFFER_PRE_RESUME(1);
> +
>   		if (!(ib->flags & AMDGPU_IB_FLAG_CE) && vmid)
> -			gfx_v9_0_ring_emit_de_meta(ring);
> +			gfx_v9_0_ring_emit_de_meta(ring,
> +				 (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
>   	}
>   
>   	amdgpu_ring_write(ring, header);
> @@ -5505,6 +5510,7 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>   	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
>   	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
>   	bool writeback = flags & AMDGPU_FENCE_FLAG_TC_WB_ONLY;
> +	bool exec = flags & AMDGPU_FENCE_FLAG_EXEC;
>   
>   	/* RELEASE_MEM - flush caches, send int */
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
> @@ -5515,6 +5521,7 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>   					       EOP_TC_WB_ACTION_EN |
>   					       EOP_TC_MD_ACTION_EN)) |
>   				 EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
> +				 (exec ? EOP_EXEC : 0x0) |
>   				 EVENT_INDEX(5)));
>   	amdgpu_ring_write(ring, DATA_SEL(write64bit ? 2 : 1) | INT_SEL(int_sel ? 2 : 0));
>   
> @@ -5620,33 +5627,132 @@ static void gfx_v9_ring_emit_sb(struct amdgpu_ring *ring)
>   	amdgpu_ring_write(ring, 0);
>   }
>   
> -static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring)
> +static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume)
>   {
> +	struct amdgpu_device *adev = ring->adev;
>   	struct v9_ce_ib_state ce_payload = {0};
> -	uint64_t csa_addr;
> +	uint64_t offset, ce_payload_gpu_addr;
> +	void *ce_payload_cpu_addr;
>   	int cnt;
>   
>   	cnt = (sizeof(ce_payload) >> 2) + 4 - 2;
> -	csa_addr = amdgpu_csa_vaddr(ring->adev);
> +
> +	if (ring->is_mes_queue) {
> +		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
> +				  gfx[0].gfx_meta_data) +
> +			offsetof(struct v9_gfx_meta_data, ce_payload);
> +		ce_payload_gpu_addr =
> +			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +		ce_payload_cpu_addr =
> +			amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +	} else {
> +		offset = offsetof(struct v9_gfx_meta_data, ce_payload);
> +		ce_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
> +		ce_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
> +	}
>   
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt));
>   	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(2) |
>   				 WRITE_DATA_DST_SEL(8) |
>   				 WR_CONFIRM) |
>   				 WRITE_DATA_CACHE_POLICY(0));
> -	amdgpu_ring_write(ring, lower_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, ce_payload)));
> -	amdgpu_ring_write(ring, upper_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, ce_payload)));
> -	amdgpu_ring_write_multiple(ring, (void *)&ce_payload, sizeof(ce_payload) >> 2);
> +	amdgpu_ring_write(ring, lower_32_bits(ce_payload_gpu_addr));
> +	amdgpu_ring_write(ring, upper_32_bits(ce_payload_gpu_addr));
> +
> +	if (resume)
> +		amdgpu_ring_write_multiple(ring, ce_payload_cpu_addr,
> +					   sizeof(ce_payload) >> 2);
> +	else
> +		amdgpu_ring_write_multiple(ring, (void *)&ce_payload,
> +					   sizeof(ce_payload) >> 2);
> +}
> +
> +static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ring *ring)
> +{
> +	int i, r = 0;
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> +	struct amdgpu_ring *kiq_ring = &kiq->ring;
> +	unsigned long flags;
> +
> +	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&kiq->ring_lock, flags);
> +
> +	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +		return -ENOMEM;
> +	}
> +
> +	/* assert preemption condition */
> +	amdgpu_ring_set_preempt_cond_exec(ring, false);
> +
> +	ring->trail_seq += 1;
> +	amdgpu_ring_alloc(ring, 8);
> +	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
> +				  ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC);
> +	/* assert IB preemption, emit the trailing fence */
> +	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
> +				   ring->trail_fence_gpu_addr,
> +				   ring->trail_seq);
> +
> +	amdgpu_ring_commit(kiq_ring);
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +
> +	/* poll the trailing fence */
> +	for (i = 0; i < adev->usec_timeout; i++) {
> +		if (ring->trail_seq ==
> +		    le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> +			break;
> +		udelay(1);
> +	}
> +
> +	if (i >= adev->usec_timeout) {
> +		r = -EINVAL;
> +		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> +	}
> +
> +	amdgpu_ring_commit(ring);
> +	/*reset the CP_VMID_PREEMPT after trailing fence*/
> +	WREG32_SOC15(GC, 0, mmCP_VMID_PREEMPT, 0x0);
> +
> +	/* deassert preemption condition */
> +	amdgpu_ring_set_preempt_cond_exec(ring, true);
> +	return r;
>   }
>   
> -static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
> +static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
>   {
> +	struct amdgpu_device *adev = ring->adev;
>   	struct v9_de_ib_state de_payload = {0};
> -	uint64_t csa_addr, gds_addr;
> +	uint64_t offset, gds_addr, de_payload_gpu_addr;
> +	void *de_payload_cpu_addr;
>   	int cnt;
>   
> -	csa_addr = amdgpu_csa_vaddr(ring->adev);
> -	gds_addr = csa_addr + 4096;
> +	if (ring->is_mes_queue) {
> +		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
> +				  gfx[0].gfx_meta_data) +
> +			offsetof(struct v9_gfx_meta_data, de_payload);
> +		de_payload_gpu_addr =
> +			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +		de_payload_cpu_addr =
> +			amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +
> +		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
> +				  gfx[0].gds_backup) +
> +			offsetof(struct v9_gfx_meta_data, de_payload);
> +		gds_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +	} else {
> +		offset = offsetof(struct v9_gfx_meta_data, de_payload);
> +		de_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
> +		de_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
> +
> +		gds_addr = ALIGN(amdgpu_csa_vaddr(ring->adev) +
> +				 AMDGPU_CSA_SIZE - adev->gds.gds_size,
> +				 PAGE_SIZE);
> +	}
> +
>   	de_payload.gds_backup_addrlo = lower_32_bits(gds_addr);
>   	de_payload.gds_backup_addrhi = upper_32_bits(gds_addr);
>   
> @@ -5656,9 +5762,15 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
>   				 WRITE_DATA_DST_SEL(8) |
>   				 WR_CONFIRM) |
>   				 WRITE_DATA_CACHE_POLICY(0));
> -	amdgpu_ring_write(ring, lower_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, de_payload)));
> -	amdgpu_ring_write(ring, upper_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, de_payload)));
> -	amdgpu_ring_write_multiple(ring, (void *)&de_payload, sizeof(de_payload) >> 2);
> +	amdgpu_ring_write(ring, lower_32_bits(de_payload_gpu_addr));
> +	amdgpu_ring_write(ring, upper_32_bits(de_payload_gpu_addr));
> +
> +	if (resume)
> +		amdgpu_ring_write_multiple(ring, de_payload_cpu_addr,
> +					   sizeof(de_payload) >> 2);
> +	else
> +		amdgpu_ring_write_multiple(ring, (void *)&de_payload,
> +					   sizeof(de_payload) >> 2);
>   }
>   
>   static void gfx_v9_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
> @@ -5674,8 +5786,9 @@ static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
>   {
>   	uint32_t dw2 = 0;
>   
> -	if (amdgpu_sriov_vf(ring->adev))
> -		gfx_v9_0_ring_emit_ce_meta(ring);
> +	if (amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp)
> +		gfx_v9_0_ring_emit_ce_meta(ring,
> +				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
>   
>   	dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
>   	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
> @@ -7024,6 +7137,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>   	.emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
>   	.init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
>   	.patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
> +	.preempt_ib = gfx_v9_0_ring_preempt_ib,
>   	.emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
>   	.emit_wreg = gfx_v9_0_ring_emit_wreg,
>   	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> index 799925d22fc8..614e9f8467fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> @@ -162,6 +162,7 @@
>   		 * 2 - Bypass
>   		 */
>   #define     INDIRECT_BUFFER_PRE_ENB(x)		 ((x) << 21)
> +#define     INDIRECT_BUFFER_PRE_RESUME(x)           ((x) << 30)
>   #define	PACKET3_COPY_DATA				0x40
>   #define	PACKET3_PFP_SYNC_ME				0x42
>   #define	PACKET3_COND_WRITE				0x45
> @@ -184,6 +185,7 @@
>   #define		EOP_TC_ACTION_EN                        (1 << 17) /* L2 */
>   #define		EOP_TC_NC_ACTION_EN			(1 << 19)
>   #define		EOP_TC_MD_ACTION_EN			(1 << 21) /* L2 metadata */
> +#define		EOP_EXEC					(1 << 28) /* For Trailing Fence */
>   
>   #define		DATA_SEL(x)                             ((x) << 29)
>   		/* 0 - discard

