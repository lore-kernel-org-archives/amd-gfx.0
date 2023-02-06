Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C388C05027
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 17:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC48310E18D;
	Mon,  6 Feb 2023 17:19:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B8C210E18D
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 17:19:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuZq4m7I2l5/cyCxInq0fW3FTRIy+1YGWs6lZvFyXAiY1IjTcf1XiX+pQa8OnFErQL0z0OLqumvPb8Ex1YL4kshC0xHUTWvi76p/jbqbo9RyvUfQtgL3xlScee5nIsAMuli1cLrC3UseOZ01SHrdWLp5HKJa106QYkBwcJzxKEnd7A+sHNNJtzRgBFaQBCJKJmnyHWQTNgLEXc7/bztqoiO9CkgRdG4SGo9J+YidA5uxpn+22SfSlHBiBAsWjWpEFLWMZZkEEvn6IA03OoqjOOdDINlaz6AXjO+yBA4bR9Ig/8W5segW3Ncd6gvdewrdXdTF77Xwy/SlZLD92A7MDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9dbaPb46Xp/0IZ8DdTSeMC3F2ZCGeM+AeZPIQzGwmU=;
 b=B1AxZMfVMw1ifPL/1XKDgLzy7AbSMcB2tww7X3DebbKR0FScuKEruOh/GGtb7Xnm3guVeHiQ/bqR3gDiK5+9S10Nd0l/SRaHcYVn/I26u1BwqLBllLZ7pbqxh4RJCQwSr4Akw/GgrE2uud762KPb/2M21aouO17qAxBXdGT1L1okNM/evKmLVdD3Qles43jakZ25Ps0xcMP+oluBiU8WDExLn1YAZbiheDu+MwshDcyDhsFOYAC+8A96bW6odt31VFqLsPVPRGGPIrrjosFKVsS0dDu49Ml2WeLmKKuT4wdoycKA8CwIkffckrEZanVcYmMv7GN9fcDhkVeaMKNnrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9dbaPb46Xp/0IZ8DdTSeMC3F2ZCGeM+AeZPIQzGwmU=;
 b=MBuRM+GqIMvwpxEEYLmoD/PHYqQ2zWPHxNEMzOLk0NDg6BqIiyOe6M37n2/oWiMjQCCYEXnZZWy04Jwlki+/4Pb7M7PKfYzXFdgjAD5ojdjv7++eyU0XKg1XzwRUdCJT1R6RmkzvF7v3wik7Eys2e8ERmuJSr+7l+MDBZ27g3bY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CY8PR12MB7753.namprd12.prod.outlook.com (2603:10b6:930:85::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 17:19:39 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 17:19:39 +0000
Message-ID: <aff2c322-a41f-2953-8307-bedf903a501a@amd.com>
Date: Mon, 6 Feb 2023 18:19:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 14/14] drm/amdgpu: introduce doorbell bo in kernel
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230203190836.1987-1-shashank.sharma@amd.com>
 <20230203190836.1987-20-shashank.sharma@amd.com>
 <82fa6b85-4f45-eb23-5e9f-88ca2d45c5b4@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <82fa6b85-4f45-eb23-5e9f-88ca2d45c5b4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::15) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CY8PR12MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 52105b59-a52c-4726-c4cd-08db086653c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ph5NepxXzezArZuxVkHbAhdPsCTjNWoWCmAhJ3Eu1N4+ZVd+vvcm6yCLyTWAXb3w6wnizBW4TcOIrz0TWAkaZ/9JMI9ECw4TZSwHnfo133Up9HAR71S6XXWtGXiZvBUXcrf29Df5b5Z4fSJb8YYITwiIlVk+s/kw5/dpRqJjV30mSuU4Kw0ja8MJUI0q2kGEuKA7qXC5RgJASFvETHYGBRIodnYUzOarCcFyCP641bw3REtTgSPb+jB52azrlbAslaX39TpkiolzpC9DJhyHnSKWpCHqSbwg/8CBci7U+I81hZp49nEacVwLJI+fogm6Tqs8uOu3kKgPOU90rEXOvDd2vbZcw4n+p+P//jm7jX28OkxknoAUhbKOFnmLXtTkEw0QkIW0T1pRWBA1fuBys3ZVHrNluV928SidXw39isTMoFONKoVQZe+gCXZWuN6pIKvGpu3G0v/WUD+PiN+wWg21g6ZsV5u3I9s5I/UHZ9rnqgrwFegoAslZH9M4EoQU1heUbYR+lw8hASxs1vf0KxZDnYByzDchyNgUdcYodLsBI1PaIi2sPyZ27PSgOdW6eWrP4+MvCWsWxUkId0c+Nz3meQzY2p3idM0ErlQUj36IcHqFyIwAUUjW0bO6mEkFB+JtF7p7Dj9MgXjNRCapSuEkGXOOCXYI8WdwdI/XaH56MYym9sEpwX6/HG4hTJfxRXDnvLRrRzw7QdLD/1uIZTzPU71nWLnnC6IPPOhbY8Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199018)(5660300002)(44832011)(8936002)(41300700001)(66574015)(83380400001)(31686004)(2906002)(66556008)(316002)(66476007)(66946007)(26005)(8676002)(6512007)(186003)(4326008)(31696002)(36756003)(86362001)(38100700002)(6486002)(2616005)(478600001)(53546011)(6506007)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0FUZXA5b2N6aE81R2NCemNseElhNjlhN1g2N0ZTTlF5RGFEbldoc0pPU3Bs?=
 =?utf-8?B?R0FOYXZRTmZSNVQzd0Viek9CN2F1aXVSY2p3MTYwNm0vVitNSWxwRXFvcTJP?=
 =?utf-8?B?WEZkL3hWU09xSkNuTUdabjNwMWgxdGdvQS9RazlGMUJZMU4xa05ER3JYOHRS?=
 =?utf-8?B?L25idTFYWVpLREpzMzA2M21EcnhITHdCY3BqajJrMkZJa1dNM0VHN2dkS3pM?=
 =?utf-8?B?c3k4KzNkQjN3QWpZQW5IOHJ6Q2VBc3F2cGZaZWN4ckwrT29WRXZOYXZ3R0Vj?=
 =?utf-8?B?UW5YTGZVU2s0Q3RYMG4wV3NHU2xJUHc0cVA5d3VKc0laWGZGZW5yUDgrMm1J?=
 =?utf-8?B?cmNGVHRWRGJTZGY2dXhjd2N3bXRCd3d4eUo2cmlsd0c4dDRtK3E3cnUzOW1E?=
 =?utf-8?B?ZUVuYkRBa0xmaUlReUx6QzU3cGRYblZHaXYxM0dmYW5lbjZOVzk1dDZrTUM3?=
 =?utf-8?B?TXA3SGxCeU9MUFBKNFNaK1pIT0FlSWRUK1YrdmY0RjFuV3MzOUIwWWpYb3Rj?=
 =?utf-8?B?cVhxdFh0NWdxQVNKSFlpdFpUZEdwcCs4U05QNmtkREFRdm8xRFJPcEhUOWU3?=
 =?utf-8?B?Y0VDOG1qSU00cXduV01VNXA3dytHazF2QjlSenR5Z0V0Wm1LR254OWc4SzQy?=
 =?utf-8?B?djA2WWxLQkVqTm9CaG4vRUEvNDBJbEo1TEZ1Y3pyN0prZXRnUXR0TnRHUFVv?=
 =?utf-8?B?TzFydXZQR1A3T3Q2aXh4dVYrMXZKeDNvUzdzbUtFOTllUEtpRU9MWlNkMkdH?=
 =?utf-8?B?SjNvdVlCQkMvcWlQeGZjd1hMNENxVldFY3cyS1c1NXBIbE9KSDI3Z2VjK0xx?=
 =?utf-8?B?eU96ejJkMEZXa3BlSk1zOWdQK1NYd3VUNjNxQzdaNVZnekFhNFdwMGpKZnJ2?=
 =?utf-8?B?djk5aitzam5lUEFQWGlXSFFJS0FDSlFQc3hReXBMa0h4T2NHdnBxVFJESkti?=
 =?utf-8?B?Q0ZHeWQ3Q0R2MXdpOEVROHNuQjFFWmJ2Y0JFNFFseGJjZ3dRMFhkYTVBZTVX?=
 =?utf-8?B?SmR5RDN4MklhRWU3MWl1b2N3Nk5NL0JBcjJzaVJlMTc1NjB4OVNab1crZ245?=
 =?utf-8?B?WGRFYWJXc3Z1c2k2MzZVM0Y3bG9iUVpyaXZNckdIQk50ejRRWDg5VkQ0ZHFh?=
 =?utf-8?B?ZWl2SGM3RHUvZzBjY1lXZzF6NXd6VjRLL0dzZW53aGRVWXNJMWUzV3VGK2Vm?=
 =?utf-8?B?QVdSdmVTZ1hkeW8wUmZYYVB1MTdYRlZsdkErN0JSb2gwUzliS21PekFZbEtX?=
 =?utf-8?B?akpsMWZxbGdlbFh6WEk3bjRmb0tGNEgxdGFGUXRIQ01Cdi82L2J1UGhITHpK?=
 =?utf-8?B?dkxGSDk5TUd3WWJQQWpvSEJjZmlaOFV2Ti9vMTRaV1ltMWxSNG5IcUdIS3BL?=
 =?utf-8?B?T3loTW52QmxCbTF2cDZOZUxaVG90TE4vaXhwY003ZkFIeG1Gdml2Yzl2WlFY?=
 =?utf-8?B?ejhOVzdoY285ZWNQRjFBNFFqZGV5RU9RZFZwcGlnbjdKQVNrRUd5cWwxczhw?=
 =?utf-8?B?U2VPbWlzdFdjeXZrb2MzOGc5S3cxaGdPTjQ5QXYyZVNDakFCR3VQc3dTYW9h?=
 =?utf-8?B?TnNGOUZkcnR4ZFZ2cDFmYWQ5LzZOVGt5SEs4OG9Sb0hkblIxRFl4dm8wbStQ?=
 =?utf-8?B?R2VBRnVtdWo5WVJ4UzdGLytQcWE4bUF6dmtYaXJYOUdSNmQwT2hUcldBR3g5?=
 =?utf-8?B?ZUpiRldrMWNWbUI2ZjJtcm9MWHR1UGlObmdRZmo4NzRRRlpxTE5MbUVRRnNC?=
 =?utf-8?B?d2hmQU8xU3E5WkV6b016YXVMQXdCS01nYzh3cWpiOTIvallMUUNLNEhkR1Vv?=
 =?utf-8?B?UE9uSDZPeGV4TUI4cHA4R3huMUlERENTZkFLMnB5VjhHRnNQNUQrVEw0UVVo?=
 =?utf-8?B?ZkdsY0JvRnFKQWFKTXNzMXZWL2NyMlB1WEpmeDdNVW0zSFJDd2JhOURpY0th?=
 =?utf-8?B?TGdNTmZTdkJBZ1MwbThwam13RTFoRDdLSW9hek9sVkxzTlRHWW40azFvRDZE?=
 =?utf-8?B?RHdKVlRSMU1aU253SnVYRms3UlBReFBSV1JpbEpBdndPUEtkYmNiVVVBcE41?=
 =?utf-8?B?Z05BN1pSWE15ZHlESDM4M09QbVVLSWJDak9LcU13ZVF1eGc0WHB4OVNwNncy?=
 =?utf-8?Q?Ep25XVwA1bw+FFqe2g1Qoi86T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52105b59-a52c-4726-c4cd-08db086653c4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 17:19:38.9710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhO08++A9jzhe3C9uzBgicWAgpppkC59qlrO1TSEYR9Nbq90FjHRDC1DjinfSaKPS4w2bOtnW/ab7k1Q0MBE0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7753
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 06/02/2023 17:57, Christian König wrote:
> Am 03.02.23 um 20:08 schrieb Shashank Sharma:
>> From: Alex Deucher <alexander.deucher@amd.com>
>>
>> This patch does the following:
>> - Removes doorbell ptr from adev.
>> - Moves doorbell.num_doorbells into mman.num_doorbells.
>> - Introduces a kernel bo for doorbell management in form of 
>> mman.doorbell_kernel_bo.
>>    This bo holds the doorbell space now.
>> - Introduces mman.doorbell_bo_size: to save total doorbell memory size.
>> - Also introduces mman.doorbell_va to save CPU address of doorbell BO
>>    mapping. This ptr will be used now for doorbell read/write from 
>> doorbell BAR.
>
> Please don't call any CPU address VA, this is a term we usually use 
> with GPUVM.
>
> Rather use doorbell_cpu_addr for this.
>
> Christian.

Noted,

- Shashank

>
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h          |  1 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  5 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 16 ++++++-------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  4 ----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      | 24 ++++++++++++++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  6 +++++
>>   6 files changed, 35 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index e1c1a360614e..dd3875ae1ad3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -834,7 +834,6 @@ struct amdgpu_device {
>>       spinlock_t audio_endpt_idx_lock;
>>       amdgpu_block_rreg_t        audio_endpt_rreg;
>>       amdgpu_block_wreg_t        audio_endpt_wreg;
>> -    struct amdgpu_doorbell        doorbell;
>>         /* clock/pll info */
>>       struct amdgpu_clock            clock;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 28076da2258f..aea943e337df 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -109,11 +109,10 @@ static void amdgpu_doorbell_get_kfd_info(struct 
>> amdgpu_device *adev,
>>           *aperture_base = adev->gmc.doorbell_aper_base;
>>           *aperture_size = 0;
>>           *start_offset = 0;
>> -    } else if (adev->gmc.doorbell_aper_size > 
>> adev->doorbell.num_doorbells *
>> -                        sizeof(u32)) {
>> +    } else if (adev->gmc.doorbell_aper_size > 
>> adev->mman.doorbell_kernel_bo_size) {
>>           *aperture_base = adev->gmc.doorbell_aper_base;
>>           *aperture_size = adev->gmc.doorbell_aper_size;
>> -        *start_offset = adev->doorbell.num_doorbells * sizeof(u32);
>> +        *start_offset = adev->mman.doorbell_kernel_bo_size;
>>       } else {
>>           *aperture_base = 0;
>>           *aperture_size = 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 7c21ffe63ebc..9c3ce1ae66ea 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -593,8 +593,8 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device 
>> *adev, u32 index)
>>       if (amdgpu_device_skip_hw_access(adev))
>>           return 0;
>>   -    if (index < adev->doorbell.num_doorbells) {
>> -        return readl(adev->mman.doorbell_aper_base_kaddr + index);
>> +    if (index < adev->mman.num_doorbells) {
>> +        return readl(adev->mman.doorbell_va + index);
>>       } else {
>>           DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", 
>> index);
>>           return 0;
>> @@ -616,8 +616,8 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device 
>> *adev, u32 index, u32 v)
>>       if (amdgpu_device_skip_hw_access(adev))
>>           return;
>>   -    if (index < adev->doorbell.num_doorbells) {
>> -        writel(v, adev->mman.doorbell_aper_base_kaddr + index);
>> +    if (index < adev->mman.num_doorbells) {
>> +        writel(v, adev->mman.doorbell_va + index);
>>       } else {
>>           DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", 
>> index);
>>       }
>> @@ -637,8 +637,8 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device 
>> *adev, u32 index)
>>       if (amdgpu_device_skip_hw_access(adev))
>>           return 0;
>>   -    if (index < adev->doorbell.num_doorbells) {
>> -        return atomic64_read((atomic64_t 
>> *)(adev->mman.doorbell_aper_base_kaddr + index));
>> +    if (index < adev->mman.num_doorbells) {
>> +        return atomic64_read((atomic64_t *)(adev->mman.doorbell_va + 
>> index));
>>       } else {
>>           DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", 
>> index);
>>           return 0;
>> @@ -660,8 +660,8 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device 
>> *adev, u32 index, u64 v)
>>       if (amdgpu_device_skip_hw_access(adev))
>>           return;
>>   -    if (index < adev->doorbell.num_doorbells) {
>> -        atomic64_set((atomic64_t 
>> *)(adev->mman.doorbell_aper_base_kaddr + index), v);
>> +    if (index < adev->mman.num_doorbells) {
>> +        atomic64_set((atomic64_t *)(adev->mman.doorbell_va + index), 
>> v);
>>       } else {
>>           DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", 
>> index);
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> index 464be28da4fb..97298a98561f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> @@ -24,10 +24,6 @@
>>   /*
>>    * GPU doorbell structures, functions & helpers
>>    */
>> -struct amdgpu_doorbell {
>> -    u32            num_doorbells;    /* Number of doorbells actually 
>> reserved for amdgpu. */
>> -};
>> -
>>   /* Reserved doorbells for amdgpu (including multimedia).
>>    * KFD can use all the rest in the 2M doorbell bar.
>>    * For asic before vega10, doorbell is 32-bit, so the
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index e38720b91958..8f0537f16cc8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -1742,7 +1742,7 @@ static int amdgpu_ttm_doorbell_init(struct 
>> amdgpu_device *adev)
>>       if (adev->asic_type < CHIP_BONAIRE) {
>>           adev->gmc.doorbell_aper_base = 0;
>>           adev->gmc.doorbell_aper_size = 0;
>> -        adev->doorbell.num_doorbells = 0;
>> +        adev->mman.num_doorbells = 0;
>>           adev->mman.doorbell_aper_base_kaddr = NULL;
>>           return 0;
>>       }
>> @@ -1759,13 +1759,13 @@ static int amdgpu_ttm_doorbell_init(struct 
>> amdgpu_device *adev)
>> adev->gmc.doorbell_aper_size);
>>         if (adev->enable_mes) {
>> -        adev->doorbell.num_doorbells =
>> +        adev->mman.num_doorbells =
>>               adev->gmc.doorbell_aper_size / sizeof(u32);
>>       } else {
>> -        adev->doorbell.num_doorbells =
>> +        adev->mman.num_doorbells =
>>               min_t(u32, adev->gmc.doorbell_aper_size / sizeof(u32),
>>                     adev->doorbell_index.max_assignment+1);
>> -        if (adev->doorbell.num_doorbells == 0)
>> +        if (adev->mman.num_doorbells == 0)
>>               return -EINVAL;
>>             /* For Vega, reserve and map two pages on doorbell BAR 
>> since SDMA
>> @@ -1775,7 +1775,7 @@ static int amdgpu_ttm_doorbell_init(struct 
>> amdgpu_device *adev)
>>            * the max num_doorbells should + 1 page (0x400 in dword)
>>            */
>>           if (adev->asic_type >= CHIP_VEGA10)
>> -            adev->doorbell.num_doorbells += 0x400;
>> +            adev->mman.num_doorbells += 0x400;
>>       }
>>         return 0;
>> @@ -1901,6 +1901,18 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>       if (r)
>>           return r;
>>   +    adev->mman.doorbell_kernel_bo_size = adev->mman.num_doorbells 
>> * sizeof(u32);
>> +    r = amdgpu_bo_create_kernel_at(adev,
>> +                      0,
>> +                      adev->mman.doorbell_kernel_bo_size,
>> +                      AMDGPU_GEM_DOMAIN_DOORBELL,
>> +                      &adev->mman.doorbell_kernel_bo,
>> +                      &adev->mman.doorbell_va);
>> +    if (r) {
>> +        DRM_ERROR("Failed to create doorbell BO\n");
>> +        return r;
>> +    }
>> +
>>       DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
>>            (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
>>   @@ -1992,6 +2004,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>>                         NULL, NULL);
>>       amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>>                       &adev->mman.sdma_access_ptr);
>> + amdgpu_bo_free_kernel(&adev->mman.doorbell_kernel_bo,
>> +                  NULL, &adev->mman.doorbell_va);
>>       amdgpu_ttm_fw_reserve_vram_fini(adev);
>>       amdgpu_ttm_drv_reserve_vram_fini(adev);
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index a492de079c2e..405294ca9834 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -98,6 +98,12 @@ struct amdgpu_mman {
>>       /* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>>       struct amdgpu_bo    *sdma_access_bo;
>>       void            *sdma_access_ptr;
>> +
>> +    /* doorbells reserved for the kernel driver */
>> +    u32            num_doorbells;    /* Number of doorbells actually 
>> reserved for amdgpu. */
>> +    uint64_t        doorbell_kernel_bo_size;
>> +    struct amdgpu_bo    *doorbell_kernel_bo;
>> +    void            *doorbell_va;
>>   };
>>     struct amdgpu_copy_mem {
>
