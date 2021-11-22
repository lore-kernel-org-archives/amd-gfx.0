Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73372C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 17:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E3D898B6;
	Mon, 22 Nov 2021 17:41:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C7F898B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 17:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a61HC9V7rVA6zGDa0tkCwHfv9apYhaGC3Y1/pydvC/siskEIW3490diFMvJUD5XAhQL342B9v9DoniTOF29Z+X4A2igQdDSDgirYQQH0W3/QKBZRLQCJrbOB2SNyeazBffEm4kjnLoVdLVbwllRvmDr67qO1RcVeZddc+kVKAl0V7FglpVdr3DW4pmMvYefu/UqRrnOE1MartBNs7UCDEGwsPI5xUEY39vMPLNIMUjNJnv5a4TllitvBD0K66BieHuH9MaJTrrtgiFUQwnOIbYoVylRJ0JdJbm6Mgl/qe11la7yD/phfHgXVWu450l6Z+RDhxnlGJIlRw195/MjhLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0DQ8uwVASk0SLt64kDdGoTg1ZNqZH1q1I33xTSCUjE=;
 b=gKzynBFuZybYqB/rqDrlbYBh/Sr5zKJrwlZYIfYu7zFk5um3S2KSD2boDm9UmzxgaE8hB9sXRD9vX96yYDHx01Q7dGQ8NOSF4VMnramSka7wylGJi9tF29+vZec1Mf9DVBBXEAUiz8v5FpVDWr7MJnlKx6n+trTSylEpYYZR1OouBzy3zHKTqGpTIBHniAhpfFckuF5VNTRzvvRthmWPCvKOFJ7Siz9T/Tk958o6u/FlTLtuOWNNsX2EBKSdAN02XxNRrYMKM29qAFAGRaRUuaHdNq+v3lUbHg5W4jccCkHtC7E56O01VM4FGr0acr3Po+j3LORFzvWM5M5HeDKP5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0DQ8uwVASk0SLt64kDdGoTg1ZNqZH1q1I33xTSCUjE=;
 b=XhbPbY4kSMR2u3H6hG1FX3Yn5kyalRrI7gl8OF9oSKLe6e+gsCrJx1eFFtEPYQMz7cNjkc3isFp/aJ6J80DmlMXltXyiyfvh5B46VR1e7QD7wn3+ptQOe1QkNWJ0SFwknye40+dEHqWGMg46yipoUj5TMZeNr8aP9M5Mkobv2P0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Mon, 22 Nov
 2021 17:41:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 17:41:07 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: move kfd post_reset out of reset_sriov
 function
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211118165737.27432-1-shaoyun.liu@amd.com>
 <9a6d5732-cdbc-1964-0b92-a7b64a7d529a@amd.com>
 <CH0PR12MB5372338AF20E1B11DF588E90F49F9@CH0PR12MB5372.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <415eeb37-15f2-8146-0127-9fa3147f6e2f@amd.com>
Date: Mon, 22 Nov 2021 12:41:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CH0PR12MB5372338AF20E1B11DF588E90F49F9@CH0PR12MB5372.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT3PR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Mon, 22 Nov 2021 17:41:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd381ebc-dbdf-49e2-6a74-08d9addf43a1
X-MS-TrafficTypeDiagnostic: BN9PR12MB5305:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5305E19508428B66F1EF7394929F9@BN9PR12MB5305.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eLyv+iitveh01QHkRs+Q4juRpRGoFfn6CBys2wMkQ0WDBRXmJwZO4e40ESY61nCLU1kj5OwF5kzyYcmiAwzGSz7sjxOQZF4P67Y5n+OZMp5A1jJkp5Q5G2yRalDp8Jt5GDucw6OuhlXptOKgpd78V4dEzeaITZouZW4qEwHLkMlKAoJW4uONMItI5HXREh+E5CJbs8W1DvNbQ7h9y7cSgUgHo3ITI1p0ceXfDF6DSdb1SfN4N5RSYo0WVsWAJLSD8DIeA00eBXpuyS2Zf8SOEvKUzsSvs9vDTTWB/DdWZWk3tcsVK8ecaI5fV8H7eunwne47zJ7hmvTCv41tsEutrGNm7T1WhY9sCYv9IpIuQDALJqXprp+OIhjWEmXsKTv9qguBguGjqBaAQXZPyX7zKKPi0BCKtSN4w7tuu3+S/g2PIG8Zo2Smg01qDdTpZLHtwRzfendc09O7gZye+30X8Q9YF5TbhB34EUf4xV804xAUKBsag2MKdIYOE3XOP6vv3MS94IkBqUiKfek6XIZy0+AXLVBpwhy1U3JEHCY1/dNvzzJ0RhVSEBE986OKuMZHFVsqPQMCv5mGhfFjnAEyzM3VLVbv7WDqrtqaRV2qogOLshnHZqLlj1f5YrDEPfk1I772urD4w8+fJT6h0A92FDvEu2O2IplOJakD9WubKeY+8lts81XwDRvYrjy6unBExo4tW6wP6KopYgDbPyRy9eqdTEukztNmr1VuIKBJ38w4wnGr6mj0AJcp31rxaf96
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(44832011)(8936002)(8676002)(36756003)(186003)(31696002)(66946007)(38100700002)(66556008)(66476007)(16576012)(86362001)(508600001)(4001150100001)(2616005)(110136005)(83380400001)(26005)(956004)(53546011)(5660300002)(2906002)(6486002)(31686004)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1BwQ0ZhOGE2QUJ3S1ZodE9hZThvZHZ2QVhhQXlnckxuQ0pJT3lpR1NGT0Uv?=
 =?utf-8?B?cDduOTdtQmtUUTgvc253LytIOTJBc05kVlpOdVo0YzBPM3U4a1NjbElDRTMw?=
 =?utf-8?B?dzFpb0dycTFWLzE2TE5ycThnbW11bEIwa28yODVHR2hqT2ZsT21rSW13VzlX?=
 =?utf-8?B?MGpPd1hSNGNPOVdJaTNZMlF0T2s5THVKM2JHMkVjSXhxeGFGck96TS9SZEJF?=
 =?utf-8?B?MC84YTFTSC9ySnphTDdSVDZaUlRkenI3WHpTK0d5WGlZV01JZDBpRGN4dDFq?=
 =?utf-8?B?dTZBanltNTVxcUN6NWY3QXNWU1ZMUFF6azJIV3p6TTdMdkxnYnVyVEdYYVR6?=
 =?utf-8?B?ZmFKeEREczRMazFXS3FJaGNiTWx1OXQxRnduZ0ZsMUduakdkNWRaTVVDVE9n?=
 =?utf-8?B?RFJ3UHkwbVRXU3o3MXMvNGVBTVgrT1NLeSt1Szd1c1hhR3E5bGZGSXdVNFgw?=
 =?utf-8?B?RDFtcE9uU0tlOFVkbThnY2tNK05haUdnVEFYVjh0U3ZnemtwaHhaMUZPNUZh?=
 =?utf-8?B?eGg4ZjhydXRMRnFNaFNQaDJDbDJVYkVaTFVvaERyYzFhd09IUzdMeCtFYitM?=
 =?utf-8?B?QTluUk9JTHI5ZS9TaG9aSG5LNFF4TmVTUHM1Ykp2d0ZUNTZ0KytaRGEyM2Q3?=
 =?utf-8?B?UjViWnovcnMvd3grQVVOVkFNc056MDBnbHZIZ0dNRWs3WDVDdk5kMElvRUMz?=
 =?utf-8?B?dHRYcFV3Mk9rTS9laWZFUGZRVDI2cG5Fcjd5UmxiQ0FjdXZUQ3ErMUs2Y2ll?=
 =?utf-8?B?ZlA4cGc1WjhhY2tSTkIrOGdETnJqeFdBdXVuNnlYOHA4WlRoOE1JdnZrZ0xt?=
 =?utf-8?B?a2FxaFlJWUpDSUJsc3IyYm5RbjlpLzhrSU9Ba0hCOUZOL0hPbVlQUlJCUFl2?=
 =?utf-8?B?T3k4cmZzbWd2TDdMMHN1eW5pRmJwWEUxWkgzNHExYzl0bnJ1N0FNNlR1OUh5?=
 =?utf-8?B?Q1U4NFB2cms3dndkWjVZVE5QVmZ3NTV2b3N5Ri9adlYwRmF4ZjFrMm1VWDdT?=
 =?utf-8?B?V1czc1h4dzNPSm5lcW1oUXdqUVd4UldDN1BwS2hGT2JCb01Sa3VST0t5eTU4?=
 =?utf-8?B?QVo1dWhwYTIvdjJjaVM1RWtYUVM0UzZ3cDZWWUpzaEM3MDRJYjR5TnJ1am5u?=
 =?utf-8?B?RWZSVjJndWY3S0JvVWhTcnRhTVZDVHRNdnZZUkFvS2NnaEx1Y0RTbC9Cd3Vw?=
 =?utf-8?B?c01EZUhzT0gwYTdnNUo5NGViVzNxd2swWmlPTlhaSGZ1TlQxeGViT0xFR0NM?=
 =?utf-8?B?cW90UnVnUjJ1L3JqM0syM1NjSjFZelo1WXlMM2xLSnZmNEtuNnViUzBQSVgy?=
 =?utf-8?B?aEtMTUhTYmtOTmFIeDNXK1FSSWZWL1F6NXBnV2JqSk9BemFNV1Y2SGYxOHhv?=
 =?utf-8?B?MjRzbXFHbXRnTXRLaXVkRnpuamxmTkcxYWhzVXRyblU0VmFoWWRGYTU4SVcy?=
 =?utf-8?B?OFEyRmZncXEyd2tGUU9YTnAyMWZFZHk2cUdpVVNlWFQ5czNYUk04ek5CV2Qv?=
 =?utf-8?B?RzFRYXNITjhxWFVFWllJS2xzMkI3Nml4WkVCeUNndE9tZFNXZ3ZaOEw2ajd6?=
 =?utf-8?B?enhvMHFVVWx5Qk9kN2dGbkc2Q0kwYVpiRjNZMlgrMnJFdDNzbkZkOFRmOTJU?=
 =?utf-8?B?UGw0TXdvVlB6ay9HYUZOQ21XSnhHWlZQZGI2QkpnUFNHYjZJYUFWR2ZkMi9M?=
 =?utf-8?B?UkphdUw5ZGhTc1JDVE43Q0xFVEFoMzJmVzI4ZkdOd0t6RVBmZ3ZQaXVUdTFx?=
 =?utf-8?B?WjdyTmYzdU1YWVRmUldjQUllbmRUeTgyUVlvQ2IybFI3ektab0ZHSTJCZ1U5?=
 =?utf-8?B?UjlrMFJBdjE4WUw1ZE02NnNpQUFMR01ETGpWSSsrVlpuaWVkTDUzUk9YZzIx?=
 =?utf-8?B?U0lqUkFIRU85TU4xdU5hcW04WmsxMVFUaEZXeFFzODNRYUo1L0ZScC9RdDdO?=
 =?utf-8?B?MlhPaUVOWCtseTUyYnZOYVVCMWtUcmpoajRicEJ0c3lMS216bmRrS2owUnox?=
 =?utf-8?B?ajNScnV0VEhzZXhFTmRBUDVFTXhPNTZFSFFsT25lS3JodUJoUm9XSEZmOWdG?=
 =?utf-8?B?QXFETWdqNUVvMWkwRHBHa0JXdElMcDhvcEs3d2hkTHZsVWJUZWlVRDdSUjRi?=
 =?utf-8?B?YnFwdVlaRHJ2OEZHWENlcEloSExGMndTcGFDVW9tU0FZSDFwQmwyakdwVjRF?=
 =?utf-8?Q?Afq4xfyWdXawUUEpiRdxC1k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd381ebc-dbdf-49e2-6a74-08d9addf43a1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 17:41:07.6228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0KVXh57egZqtae9Oi8jlGiwNGqGqoWsvWAgxi8KUhbggUKbBrYROPEDhco7cLKqJ5K+5Mo+ospR2lrnmHacWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5305
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

Am 2021-11-22 um 11:16 a.m. schrieb Liu, Shaoyun:
> [AMD Official Use Only]
>
> Thanks for the review .
> The hash for the previous change from gerrirgit/amd-staging-drm-next branch is 7079e7d5c6bf248bff,  so there is another drm-next branch that not in the  gerritgit for upstream ? 

Yes. amd-staging-drm-next is our AMD internal branch. Alex sends pull
requests to Dave Airlie's for his drm-next branch where they get
integrated with all the other DRM driver changes. That usually results
in different commit hashes.

Regards,
  Felix


>
> Thanks 
> Shaoyun.liu
>
>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com> 
> Sent: Monday, November 22, 2021 10:40 AM
> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amd/amdgpu: move kfd post_reset out of reset_sriov function
>
> Am 2021-11-18 um 11:57 a.m. schrieb shaoyunl:
>> For sriov XGMI  configuration, the host driver will handle the hive 
>> reset, so in guest side, the reset_sriov only be called once on one 
>> device. This will make kfd post_reset unblanced with kfd pre_reset 
>> since kfd pre_reset already been moved out of reset_sriov function. 
>> Move kfd post_reset out of reset_sriov function to make them balance .
>>
>> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> Please change the headline prefix to "drm/amdgpu: ". The extra "/amd" is redundant. And I'd also add a tag
>
> Fixes: 9f4f2c1a3524 ("drm/amd/amdgpu: fix the kfd pre_reset sequence in
> sriov")
>
> Note that the commit hash is the one from the drm-next branch, which is what will get merged into master eventually. With those changes, the patch is
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 10c8008d1da0..9a9d5493c676 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4308,7 +4308,6 @@ static int amdgpu_device_reset_sriov(struct 
>> amdgpu_device *adev,
>>  
>>  	amdgpu_irq_gpu_reset_resume_helper(adev);
>>  	r = amdgpu_ib_ring_tests(adev);
>> -	amdgpu_amdkfd_post_reset(adev);
>>  
>>  error:
>>  	if (!r && adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) 
>> { @@ -5081,7 +5080,7 @@ int amdgpu_device_gpu_recover(struct 
>> amdgpu_device *adev,
>>  
>>  	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
>>  	/* Actual ASIC resets if needed.*/
>> -	/* TODO Implement XGMI hive reset logic for SRIOV */
>> +	/* Host driver will handle XGMI hive reset for SRIOV */
>>  	if (amdgpu_sriov_vf(adev)) {
>>  		r = amdgpu_device_reset_sriov(adev, job ? false : true);
>>  		if (r)
>> @@ -5141,8 +5140,8 @@ int amdgpu_device_gpu_recover(struct 
>> amdgpu_device *adev,
>>  
>>  skip_sched_resume:
>>  	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>> -		/* unlock kfd: SRIOV would do it separately */
>> -		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
>> +		/* unlock kfd */
>> +		if (!need_emergency_restart)
>>  	                amdgpu_amdkfd_post_reset(tmp_adev);
>>  
>>  		/* kfd_post_reset will do nothing if kfd device is not initialized,
