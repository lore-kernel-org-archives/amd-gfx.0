Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4076ACD5BB1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 10:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FDBC10E48F;
	Tue, 26 May 2026 10:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XhLs1kvn";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2B7A10E18A
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 10:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEEr3tCovqydW0Iu45jYFHaHAeUGqMaeHhnhaA0s1cAB2T49TWAZUG1pH6BuW9NEg4AouKdgCI7LhB3tAu/xRDT/Aw+RL33d4a46MPgKF7oINbIhvAEfJoJOQu1Ku7ci2CszBfkw3OIseiK8hEMklPRY032zQNuWtXqp2L+N9TcRtIrQ0J3nIojqOcPu53uhr9JRxF57bGKdP29bvNQfHWVSPHl/qrvawWJLlhEFCxeBbVaD3/idBwcdNEb2Im1SiXVZe4XOi4AcD4QubU5G1Q919y3uxxogoNlt8L6WbroxArfn2Ddy5MXtwtBQcQdrqjtCo/4KjcRUmRWV3WOsFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCsQW2URzoONxLjCFv9Z3cFMTkE876rpUNeKuWo1ms8=;
 b=hHl21c7ATfmbFbeeoDDDVZwu5ZUuOku1IHr7B1SvIgkOx2VTzSic8VGInb4roRunvUz5vb8/L/sFGzWSaOdK5PuEYQ5J3daeELrUZm2ZQWwGOuZskahTrYZxN9o7yg76VXSk4ce6EBM15+U9kNLFQcg0ByKFdwHZJJUV50UUTz+teB8IVjanXUAESVgB/vriYSzwiSl+rSzdSagJq7uvQNIUopvNqQVw0zvJ1YN7bmuo84TTW9zojMAxC9biU/uIoAZA2ZaRKY4PNuGFRqVlzKcIBjhhzEe5XyzPb1RgZ4mevnD1O5rUv38qiu800Rh2GrmJvG2L5/UCQ+hLtArG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCsQW2URzoONxLjCFv9Z3cFMTkE876rpUNeKuWo1ms8=;
 b=XhLs1kvnG4E3EubyhkScPHIiQbI6OaLpjqI8NGI61X9n//MRqQ3SuWi/G09TgIpfrA+9SMQNCf4wvl7JJDeYTPXJybz9/JuESEp/XDEqJgnHqgUVRGVsyhXaSVXc+mHvFMQ1/vgoAR6xUqoXUKylvEPCqHYZunpJgD+51iUB90Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPFF62310189.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 26 May
 2026 10:46:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 10:46:41 +0000
Message-ID: <77438daf-1132-45f8-ab6c-c6fca98a0e43@amd.com>
Date: Tue, 26 May 2026 12:46:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu/uvd: Fix forcing MSG, FB BOs into VCPU
 segment when it isn't at 0 (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 John Olender <john.olender@gmail.com>, Liu Leo <Leo.Liu@amd.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
References: <20260525113321.17953-1-timur.kristof@gmail.com>
 <20260525113321.17953-5-timur.kristof@gmail.com>
 <eed791bd-ef86-4d0a-baf4-f779ed70326a@amd.com> <2641264.XAFRqVoOGU@timur-max>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2641264.XAFRqVoOGU@timur-max>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: IA4P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPFF62310189:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4ec877-a3c0-4952-9386-08debb1411f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|4143699003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: kCYc87z/xgt9o0QFcMtHGc8s7tsK/4iHN0l75n3dOQnMQ5WZi8vyDZ2h3leZbwA+Pwop8I/7jXxKlUWY5rW7+qpBoX1S7JzI2HkYwbj7SgJ/x8N6FMDGYbCzNUcDgARzsenF/irGdLOdlhrxsC+ihAJMYt+9dZkPoe0BqnEXojMpccJFuguFs4KvW7YzPrIVbgKm/kDiboEhbKwaWbR4qwDTy3DIEjFirQzlZkz2SjLtIbXjZF+d8SRU2A//Lc2ae/LQVQn2ssIsYOanWuo1lFHwO3nKnXx8jcCYgdoQ7qVp6XuFQ7DZqflZefSqJ8jNHPgj91H52BW788PlWOKt+PmpA24CoRNBSTQLmGWzVm+17yLcCXoDd0STCneSVFBrNHyV6mFbC0r0cX/gpL4qoaMG1Z5g4TkJoryov5HZUZISW643exTJ98/wnsNMDd/DK6pa/cSNeo3xzs0O2nchn/sAr6sGwF89LNYwHwsecrV3Lu9hTYITwxEOA9aTGR34hnwWxc6Y6gZ6aAYUxlI7HPdSVMBMseV/BomzhJv74Kp/jtShSAlfL4X/qZYGD1SKCmXrgU0RaUyTOufoXYCahzOoOujN9Qj1tmbXo5JcMObCTHpWzr/8vjAdL9gUWC3oyBpwQT6xiyiGkSXluLrmPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(4143699003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eExSZEJMYnV4NDZLWVI2TkwvajBmN21YOTlzQUV3b3ZISFBUb0g0d3QrNCtN?=
 =?utf-8?B?cWpEZnZzWE04UWNrUGFBeGtCNEdLUHNoWUtydUZ4Vkw4dzFxMGhCV3FKS0lr?=
 =?utf-8?B?ZUJsdFhGSy9rMkUxZjVNV2ErQ2xrQnUyU2Z6ZlFISEM2WjR2K2ZuWDV4L1Zm?=
 =?utf-8?B?ODNwN1dDS2tzWUVsdFYzejZJVDdDZnc0RUx2ekhDSVhkUFNyM1lVUkdLSmxX?=
 =?utf-8?B?c3RVRVN3VnA3elJ3djdZanNTSWpCZEFvdFFGZ3pPbzBEdlJvL2ZiNVZLc1d2?=
 =?utf-8?B?bTh1QU9ML2Era211WE55Wkk4bXJMRysrZHZnTkttbm5DcWY4Rzk1bUNoVks3?=
 =?utf-8?B?ZGxwa3orS2FFZEN5alVhVVZtY2ZrTStMMnNsT0dScncyQTZRZXRZN05rUGg5?=
 =?utf-8?B?cEQ4eksvaEhKZEp6RUJTUkwvWjZJZzJ5TmN5UHR1d0RQZFhGekJzMkdIZUh1?=
 =?utf-8?B?SnZrQ0dTbitYQjJFWjM5Z3BRMW5SZVViMUZnUGsxUzR5VjNjajFiSTJGWDdI?=
 =?utf-8?B?N1hUNWhVOEtpNTVVR0VoNXV6SldrV3VpUmMvVjJLZ2F6U250OFIxMDVyZHFD?=
 =?utf-8?B?Rk54cERnUVd3MkVSTEUvcUYvcytWN0RhVzBUaGdtaXNNOEtJNVdZeTdTVlF3?=
 =?utf-8?B?MWVSS09MVDZ5QmMrRDhGYnFPaDAydlZiYnhkMkdtSUVhdXhQS0lqUGFUcW9Q?=
 =?utf-8?B?V0Y4ZFAydUd5bE8xbUJxT3VGS1FwVTYweFFmeG5OQ1czck95bm5qTWRSZ0tE?=
 =?utf-8?B?SG5qckdOK29OclljakR1ZnpzYlFtU0R6VDQwdUo3MjVKR3ZXVDhYWFdVQ3Ja?=
 =?utf-8?B?YU80blpBeElzdkc1TVBFazR2WllLaitBWlJWODRMZW43Q1JNcE9ZTlJsMWs5?=
 =?utf-8?B?cURkTUZZUGV3NnFOa2RPdjZOV05MQWJiN2U0UzJIc1hGdzhEVHhqTVNvclNj?=
 =?utf-8?B?UGdZUmxMYXp5MWY2TTVRTHZNN2JZMk8rdXNSNERJRVRUQmxwbGY3ZSt1SW4y?=
 =?utf-8?B?ZjMzc1FWUTV5YmxNYnplVHFyMWVWamI1NXpGT1RtdEhqUXNMMy95c2VBT0xD?=
 =?utf-8?B?aDhLYVA2UDBkbnpEclZGditYTDRTdVRwd3lVbFd3bGVudFdNSkptYmc2Mkhu?=
 =?utf-8?B?N25BMWNpOGh1ZWo5amt5WWdJMk1NOGtHRnBhQUtkRStzWm9pS0hRUXJwUGJI?=
 =?utf-8?B?cVFzTWR2ZERiUTZCN0lrcXFBVnkvRWs3QlQ2WnRaVVZjSWhCL0NoeldFTzJi?=
 =?utf-8?B?UlFWS01hLzJ2VkV2WGthUkhmQzh2eW82VUMxOEg1UHhVY2M5RDBDNlpENFpY?=
 =?utf-8?B?aFZKV0NQZWpYYXdkRWJyamFPRjlmK2JsNURucGRucGdvL3JKWU9OQ3V3bjFs?=
 =?utf-8?B?ZEFvTlhpSVRjRkd3OHRjWFlNZk5pY3ZzN3FqSFdIV0FGWVg2ZmFQM21GYTRx?=
 =?utf-8?B?ZzJjTlVZU1kxekpwdTlLS2NLazVDTVNBTkxYd1g1NHJiMjdkQkQ2c2N3dUJm?=
 =?utf-8?B?c2ZYNlMxYWFJRGM0WE5SZ0phR1RydFhueVhuTGFSRFZZYStqNW1vL0hPS3F1?=
 =?utf-8?B?Q0hFdDJYVHJIVzNBc3U3amo5cG9vemxhdHo1ZzVHcFNwK2M1L0VaYU9xZVpt?=
 =?utf-8?B?T3dTMEFuSXZyNUo1VjBHY2FXZVRtbExFY1V0Qk9TNzh6SUdMR0N2cnkvUTJP?=
 =?utf-8?B?MThNSS9oQytDSUkzOHlXbVhDZDZFZS9uTkxJODdvc2kzay9hZW81L2pWL29p?=
 =?utf-8?B?S3VaT2F4NzRBdnBXaUd4akNyNytzekZWUFBNTlFzZkVnQ3NhY1IzdGRPbGFr?=
 =?utf-8?B?SFVWZCt6UmZXRU9iYnNmRG50dlN1WEJTWC9vQkdRRXpKc3V0ZlI2aG5KQk1n?=
 =?utf-8?B?MlJ3K1dtL0JVVXpBdUp4Yk9PNVFyaEhmNTlYWFZvVklLOFVORmYvN2NuNWdO?=
 =?utf-8?B?d0g0SDJlNFpvQitHeUlSaFJQeHdqMjdRRVdjZVN5QTZpTzF4TGFNZTU3UkRN?=
 =?utf-8?B?VG8xVzI0a1JnSU4xR2Rta3FMelc4ZEVKeFB3aXlITTJHcTRVK0svSGF6YUdz?=
 =?utf-8?B?dG1SRkt2OVY2cHNZMUdSR1MyTllMTTIwR09WWTBDRmd1b1hqa0ZER1V4K2sz?=
 =?utf-8?B?cXBSbkJUWnJKYU02cXIreWI1OGVXQnZscUN5RU1IVVF4MEsySk1YaVQ0MVRv?=
 =?utf-8?B?dkE4U3I2VXBpWEJiT3NsOHk3a3NiK2M4djQ5cGZzdGU5WW9VeHhRemlxYzIw?=
 =?utf-8?B?Rm5WRlVTcUgvQkxMYWYxRVZoQ1FqSmdLbHFmUHB0cXBZMlgxREdvOHVrcEFJ?=
 =?utf-8?Q?NW4lKSLy/vtf7UxXN+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4ec877-a3c0-4952-9386-08debb1411f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 10:46:40.9901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvMllcIbKJfTnBKNJ7JUkc6JEuZpv7w5mGcpCZQrawYU771xu3YsSw4FFYwuZlYw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF62310189
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 5/26/26 12:13, Timur Kristóf wrote:
> On 2026. május 26., kedd 10:10:33 közép-európai nyári idő Christian König 
> wrote:
>> On 5/25/26 13:33, Timur Kristóf wrote:
>>> UVD 4.x and older can only access MSG, FEEDBACK buffers from a
>>> specific 256M VRAM segment that the VCPU BO is also located in.
>>> We already modify all placements of the given BO to ensure
>>> the BO is placed within this segment.
>>>
>>> Previously, it always assumed that the VCPU segment is
>>> the first 256M of VRAM, even though under some conditions
>>> the VCPU BO could be allocated outside this segment,
>>> which made UVD non-functional as the BOs were
>>> not inside the same segment as the UVD VCPU BO.
>>>
>>> Solve that by using the segment where the VCPU BO actually is.
>>>
>>> This fixes an issue with UVD failing to initialize on SI/CIK
>>> when resizable BAR is enabled and the VCPU BO is allocated
>>> in a different segment.
>>>
>>> v2:
>>> - For other BOs, keep using the same UVD segment as before.
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/3851
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 33 ++++++++++++++++++-------
>>>  1 file changed, 24 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c index
>>> 1e59ca924abe..480bf88def46 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>> @@ -135,7 +135,7 @@ MODULE_FIRMWARE(FIRMWARE_VEGA12);
>>>
>>>  MODULE_FIRMWARE(FIRMWARE_VEGA20);
>>>  
>>>  static void amdgpu_uvd_idle_work_handler(struct work_struct *work);
>>>
>>> -static void amdgpu_uvd_force_into_uvd_segment(struct amdgpu_bo *abo);
>>> +static void amdgpu_uvd_force_into_vcpu_segment(struct amdgpu_bo *abo);
>>>
>>>  static int amdgpu_uvd_create_msg_bo_helper(struct amdgpu_device *adev,
>>>  
>>>  					   uint32_t size,
>>>
>>> @@ -158,7 +158,7 @@ static int amdgpu_uvd_create_msg_bo_helper(struct
>>> amdgpu_device *adev,> 
>>>  	amdgpu_bo_kunmap(bo);
>>>  	amdgpu_bo_unpin(bo);
>>>  	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
>>>
>>> -	amdgpu_uvd_force_into_uvd_segment(bo);
>>> +	amdgpu_uvd_force_into_vcpu_segment(bo);
>>>
>>>  	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>  	if (r)
>>>  	
>>>  		goto err;
>>>
>>> @@ -550,6 +550,24 @@ void amdgpu_uvd_free_handles(struct amdgpu_device
>>> *adev, struct drm_file *filp)> 
>>>  	}
>>>  
>>>  }
>>>
>>> +static void amdgpu_uvd_force_into_vcpu_segment(struct amdgpu_bo *bo)
>>> +{
>>> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>> +	struct amdgpu_bo *vcpu_bo = adev->uvd.inst[0].vcpu_bo;
>>> +	struct amdgpu_res_cursor vcpu_cur;
>>> +
>>> +	amdgpu_res_first(vcpu_bo->tbo.resource, 0,
>>> +			 amdgpu_bo_size(vcpu_bo), &vcpu_cur);
>>> +
>>> +	bo->placement.num_placement = 1;
>>> +	bo->placement.placement = &bo->placements[0];
>>> +	bo->placements[0].fpfn = ALIGN_DOWN(vcpu_cur.start, SZ_256M) >>
>>> PAGE_SHIFT; +	bo->placements[0].lpfn = bo->placements[0].fpfn + 
> (SZ_256M
>>>>> PAGE_SHIFT); +	bo->placements[0].mem_type =
>>> vcpu_bo->tbo.resource->mem_type;
>>> +	if (bo->placements[0].mem_type == TTM_PL_VRAM)
>>> +		bo->placements[0].flags |= TTM_PL_FLAG_CONTIGUOUS;
>>
>> You need to call ttm_bo_validate() here.
> 
> Can you say why?
> ttm_bo_validate() is already called by both callers of this function.


My bad, I was misreading the code.

In that case Reviewed-by: Christian König <christian.koenig@amd.com>

Thanks,
Christian.

> 
> 
> 
> 

