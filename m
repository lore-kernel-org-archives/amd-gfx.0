Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA45CC61DA4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 19:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD9410E23C;
	Tue, 14 Feb 2023 19:04:01 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43C9010E23C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 19:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvj3dXizUxMHuSrCz0gts5u+mCgwHhiJgW5b+p/rXC+PS0D9gwSsS5FbxGUz9M6iy3hWqRQrPyAGmMKB5G9Le3JoQnvaoWpJG9P0C48utXSKdUa4TrLJnMgRntYN4iKOsppO8dOsFnsCZfC8UxKtCPjDt5l65AlvA2ncOlMbOz0n3DRV+OmFfTyOpUdD+eFfit87NeTf9kJZe42dMHryxcHkFfFLoDVI+/u8/HSqJcp/wiEmOgYuRJqeNTUi4um3qFeW6TKySOF8xC3aY6OHvUMW8L5SvvcQOnKrS0BtvKwH9ARv9ZvoJ8GczNcwQndGRcVVnE60ZHssj0hINwEbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLAxtD8X8j8/7Te8TeFZiuFORW1VyrDUgilfXwF/PfE=;
 b=kJGor3PJWZr3M02KM71DTP7jKp98ZCC6+CJlsC/Qj4LXkTR6hYC++70MSLOfSEzTmCDetW4a4AwRlHoGBZjq0egdRoGDXdg4LSu2N40SvoujRkX/XLvYcnH4dI4B+CuB0UXzfdYsOk0Hj9v0japSxk9/BpL4SG1lytJzdUcQe41LOXA2Olv6XyYivAhJmbfX0YiS3IuD3htGXyrFw7ZL2gPrv7QxPGWSWw6AZ1OPSEtmi0tLSonWS6rbtMdXAgX/oj9TyAfUtfKJY+zv3GkA9pu+GM1ysi84YkRipsAaYtdzxi3kkCCLZERq0mQG+jL491uYaIlcaKyqF4LJe34hWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLAxtD8X8j8/7Te8TeFZiuFORW1VyrDUgilfXwF/PfE=;
 b=aZY/+pxkFjM7gx0ZU5Mt6ZCSLTsOuKeenkd2IkTaE81cVi1oXtYwCpF1+93pkyIzZCg4MlkiwZqmIt3fkV/cxC4c8GPwxuqwxbevFPodylXc6HWyotLlVMWEx2StyzqxbjE6AoobI0mzhhlKc9kmA50aix/FK81XWhh6ASH1trA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 19:03:57 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 19:03:56 +0000
Message-ID: <f855cf1a-6b48-6f93-8c0e-ea1cb598f29a@amd.com>
Date: Tue, 14 Feb 2023 20:03:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/8] drm/amdgpu: replace aper_base_kaddr with
 vram_aper_base_kaddr
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230214161510.2153-1-shashank.sharma@amd.com>
 <20230214161510.2153-3-shashank.sharma@amd.com>
 <b5f538e1-6263-2802-7e8b-f7986e2e5447@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <b5f538e1-6263-2802-7e8b-f7986e2e5447@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::11) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e9927c-49c0-47c1-2bdf-08db0ebe3914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2DmzXplRADpNtaattLrnVaRbBHtfBoFVy2klqGu4GdTYcMegpez0JbMBnG/z842nmigOpYlbM0ZxFofTjff0TgCVRSaLYzUuZMxE6G9NOvaWVSRF2r1Pz8yTXCtFrv9633JGg4zFM9EBUlj5hFlvNMoN2Ci19WMawtHAJKkmd4o3vAn3MILJAHSFztb/tPXae5g9x1z8+TGZB/GtFL4CVRdTlBgUQ5WDm8OMLJH2ifM/u0OqoymgGeY6Fd80t1afJTuAUZfW14h1qyxPeJ3lfS8z81s8Aj5S8suCwGhCgO6uVIjUQsVe2M79Z4cAt3DareXQZMyBqUI/vF3b4JCDfj0vTxk8+e0BKHZF4ZE/O4FPCYVHPjUY2UkaQxFxG+aP0xD4cZwRlLkAakzjiqte9d1ZhzNtV47x7qIM4pMpEhdmxJ/1NKhxKXcQ2FEqxX5Qfpvwbg+XwzFhJrA5bHT1h881c3nwnyHPAM8yVBXHSmzTKto3TnvrXOw8QqVfQOcmsZpEp+e/xzqTSNxdB23fVBVlpr3FcehowT6F9oy/RenH7rbKOW3dQbD4gl8Kyew/90tmuqbSh3O+zv9cwyCAHAEgbB0rOnAs0P5k8YguDwbZ8vYYWDV5nrEhs2fX0cLYIaIqqN9OytVXa1BjO2XxZflW1501e+jDDrZswxmchUoRgPsY2GtXTbBIqi3m5ocqn/mZ06FcekQ4gCLARcKMoC38fti3uo5ME8SucEt1Qu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199018)(316002)(6486002)(478600001)(31696002)(86362001)(2906002)(6666004)(38100700002)(2616005)(53546011)(6506007)(186003)(26005)(5660300002)(6512007)(44832011)(66574015)(83380400001)(36756003)(4326008)(66946007)(41300700001)(31686004)(8676002)(66556008)(66476007)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVE0ckRXUWE5bDV4Nis4OFo2M0VtSGNVVmpRcDYvZzNacDNOQ1RpbTRWNXor?=
 =?utf-8?B?ZE00Q0tRRVJVL3hkVFNGY1ZNaWFKQ3RXTVZEQVBvVVBKcHhmdWlITmQzN2N2?=
 =?utf-8?B?L21KejFaZzNmbFEwbnFzQkMwZEtiT3BxMWY5WkxNYTNJeVVsMEtRVTJWR3o4?=
 =?utf-8?B?cFU5aUxoWlFRQzgwanRJVU9IQ3pzM0RQcVExNFR4OFdESnVCSGFvamUrRXVl?=
 =?utf-8?B?MHJTY1Z4SkhLRExyQlY0VVowUjZ1VEJoOEFya3NXWmFIY093R0UweDhhc1Np?=
 =?utf-8?B?UmRncXdnQnZkd1Mvc1pmWmVLYWcxbC9iTnJsaVZjR2FkQ2JCeDh1UVJ3OXVJ?=
 =?utf-8?B?QzRzS0RMaFZPbXllTzZyZzRiMmd6UXhXYk52SVF3aE5tY3ptamY1SWRBQWhM?=
 =?utf-8?B?QS9HTmNYWnpkSnQ2Rm00VlJpSVlVN2lPUVlPRTZ3anIwbXNWT1pKYUFVamI3?=
 =?utf-8?B?M2UxUGpvbG5BNkQyclZJaTYrY1J3bVQ1RTkzRHc1RDJud1FNOVZYeGZkQm1t?=
 =?utf-8?B?bnMxZzF4ZkdXUXB1eVRnZGpjRFViYk45WXlvek9Wb1ZQd3J6WjA5VGtaSVNq?=
 =?utf-8?B?Q2trYkx6TU1pdmRWY1FGOUpUMnM3STI0czV3WHF4cUswZENCMzRWWkJDTFNE?=
 =?utf-8?B?NlhhT0dMR3hRNVN0MlI0STRRRXBwSzFQSDhXN2RibXp3dWNGeFhxcVN0RkVn?=
 =?utf-8?B?Vmt3VVF6K291RHdmTTZ0dzJMTmxIK3NBNGFrSkNtM0x6WVVROHlLbVEzWHFT?=
 =?utf-8?B?bTFIdEdYbjhqMk8wb29mbDlRL0s1NFR0alFVdWs4Z1diTHJBOGF3YmVXUGVY?=
 =?utf-8?B?MVVoWDVPeFpEN0JBd3ZlYmJ1UitvWHZDazJCcEw2YzI2RjJDZlEraDlmWThw?=
 =?utf-8?B?OTNndzVqZDU0RDZSdzVZYmxLTnJFU0N3Q3JDVzhwTWdKcG9zZDlld0tCNk1a?=
 =?utf-8?B?SDM1RFNzVVR0MzVxTTZPcXZQcURTRGdvT0FCbjQzc0xvTnRxUjZ6bU1FOU5n?=
 =?utf-8?B?YTlpTHUreUFkWXlDQk9SNEw4YmpYcXdTYWZBa1UzY2IrM0svaW43RjhncXFs?=
 =?utf-8?B?K3pkRzJwVVRSMjBBY24wNGhBcEYyZDN0bjJFT2lsODJzdTNHWk9OUGxGT0ow?=
 =?utf-8?B?YzZFM0Fmb1p5aTlFUVhXUUEzenRqN1YxUHpjUUNVNkVZV3RoQ2NsdzMxdEtl?=
 =?utf-8?B?UG1SMUtHbG14ZGFRTU9vZHIyR0ZBTDlXM0FrdmNNejJmWWNkOTBGZlE2d3g4?=
 =?utf-8?B?RXJTY09aWGJWZFBBcFhMeUZLSlUvUGI4ZStsTHE2SXZIcVFUWGk3d2pvSDVu?=
 =?utf-8?B?MDVZcjNEYVR5RTgybjZ5L1k2aHdWZERMN1BrWEE2KzBHQ3hwa3QyOGFWZVlp?=
 =?utf-8?B?QUt4bU1XZkFZSEd3TnBKUzVQWEpWcnl6eEFONVk0c0x6a200dnkvMjliMkg0?=
 =?utf-8?B?Y1hJdXFHNlNGak9rVVlDcUh6cElmYnY3L2dnSGVKUFNocFd0aldMVWIzbnp5?=
 =?utf-8?B?L1lQM0QveWVvK2ZpQTBUWWFMMlFySzlJTmx0b0tTMHBXY2ZOanVZSWR3eEhF?=
 =?utf-8?B?Y2xSSWZaSGNCUUlUYzdWaHV6NE5NemFoRUk0b2NuZGZLazRkdHZnalhDTVlM?=
 =?utf-8?B?SXpnSkl3QWF6c0pqK0ZMS3d3YzA3NEtpN1ZRVExkYk14SnRGNTJXQXdBSTlJ?=
 =?utf-8?B?dFM4SFNreVpBOU1zL0dqQ3cyamtWcE1JUkVHaW9jYk1WOThIMmZvZlBpSUh1?=
 =?utf-8?B?L3UwbHBLUldIeVBPd09uNGVibmlCNzNpaFI3Q05JK0ZEcnQ4emxZL25pVC9v?=
 =?utf-8?B?eDlFbmE4eGp3ZEhpWURFOU1vSzVDSTFCNTBvU2VnUG5PTGErUUdIZzhGdlEv?=
 =?utf-8?B?c3hQV2VTRHVEN2hBTHduL1JUVENBNGoxRlJBMnhieG4wVnhvMDhYSWR2U21o?=
 =?utf-8?B?OTd1aWRHaFdaVS9xWFR5K2h3VUppY20zQU1xWENMa2l3UEFhUnVwaTVuSmdu?=
 =?utf-8?B?MFF4YVNUaytlNjk0bkVrQnFWNk4vSjNuaVZoOW5ZeE01VDNaRWhkYmhSTEJM?=
 =?utf-8?B?MDlrTlY3NC9wTStQQ2xhQkdMWS9oTnNSU0d1NzAxTmgyUjZTYkdrYzJ3QStk?=
 =?utf-8?Q?2upgSDs30a4B+w5I+l42pxx/o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e9927c-49c0-47c1-2bdf-08db0ebe3914
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 19:03:56.8349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6XxYiJzTZhzjjlsCf5/C1l3a8kawIO2BXgU/zNzIFQQOahDWQH7YhYF8rxyLRrjN9uZQQbENzm3EJ5vpYSGMmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236
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
Cc: alexander.deucher@amd.com, Arvind.Yadav@amd.com,
 Christian Koenig <christian.koenig@amid.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 14/02/2023 19:24, Christian König wrote:
> Am 14.02.23 um 17:15 schrieb Shashank Sharma:
>> From: Alex Deucher <alexander.deucher@amd.com>
>>
>> To differentiate it from the doorbell BAR.
>
> Since we removed the manual ioremap() for the doorbell BAR today we 
> don't really need that patch any more, don't we?
>
> On the other hand renaming the field still makes a lot of sense for 
> better documenting what it's good for.
>
> Christian.
>
Exactly, I was also in two minds about this patch, but then realized 
that if nothing, its making stuff more readable.

- Shashank


>>
>> V2: Added Christian's A-B
>>
>> Acked-by: Christian Koenig <christian.koenig@amid.com>
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 14 +++++++-------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c     | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/psp_v13_0.c     | 10 +++++-----
>>   5 files changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 2f28a8c02f64..0b6a394e109b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -354,12 +354,12 @@ size_t amdgpu_device_aper_access(struct 
>> amdgpu_device *adev, loff_t pos,
>>       size_t count = 0;
>>       uint64_t last;
>>   -    if (!adev->mman.aper_base_kaddr)
>> +    if (!adev->mman.vram_aper_base_kaddr)
>>           return 0;
>>         last = min(pos + size, adev->gmc.visible_vram_size);
>>       if (last > pos) {
>> -        addr = adev->mman.aper_base_kaddr + pos;
>> +        addr = adev->mman.vram_aper_base_kaddr + pos;
>>           count = last - pos;
>>             if (write) {
>> @@ -3954,9 +3954,9 @@ static void amdgpu_device_unmap_mmio(struct 
>> amdgpu_device *adev)
>>         iounmap(adev->rmmio);
>>       adev->rmmio = NULL;
>> -    if (adev->mman.aper_base_kaddr)
>> -        iounmap(adev->mman.aper_base_kaddr);
>> -    adev->mman.aper_base_kaddr = NULL;
>> +    if (adev->mman.vram_aper_base_kaddr)
>> +        iounmap(adev->mman.vram_aper_base_kaddr);
>> +    adev->mman.vram_aper_base_kaddr = NULL;
>>         /* Memory manager related */
>>       if (!adev->gmc.xgmi.connected_to_cpu) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 55e0284b2bdd..73b831b47892 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -578,9 +578,9 @@ static int amdgpu_ttm_io_mem_reserve(struct 
>> ttm_device *bdev,
>>           if ((mem->bus.offset + bus_size) > 
>> adev->gmc.visible_vram_size)
>>               return -EINVAL;
>>   -        if (adev->mman.aper_base_kaddr &&
>> +        if (adev->mman.vram_aper_base_kaddr &&
>>               mem->placement & TTM_PL_FLAG_CONTIGUOUS)
>> -            mem->bus.addr = (u8 *)adev->mman.aper_base_kaddr +
>> +            mem->bus.addr = (u8 *)adev->mman.vram_aper_base_kaddr +
>>                       mem->bus.offset;
>>             mem->bus.offset += adev->gmc.aper_base;
>> @@ -1752,12 +1752,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>   #ifdef CONFIG_64BIT
>>   #ifdef CONFIG_X86
>>       if (adev->gmc.xgmi.connected_to_cpu)
>> -        adev->mman.aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
>> +        adev->mman.vram_aper_base_kaddr = 
>> ioremap_cache(adev->gmc.aper_base,
>>                   adev->gmc.visible_vram_size);
>>         else
>>   #endif
>> -        adev->mman.aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
>> +        adev->mman.vram_aper_base_kaddr = 
>> ioremap_wc(adev->gmc.aper_base,
>>                   adev->gmc.visible_vram_size);
>>   #endif
>>   @@ -1904,9 +1904,9 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>>         if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>   -        if (adev->mman.aper_base_kaddr)
>> -            iounmap(adev->mman.aper_base_kaddr);
>> -        adev->mman.aper_base_kaddr = NULL;
>> +        if (adev->mman.vram_aper_base_kaddr)
>> +            iounmap(adev->mman.vram_aper_base_kaddr);
>> +        adev->mman.vram_aper_base_kaddr = NULL;
>>             drm_dev_exit(idx);
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index e2cd5894afc9..929bc8abac28 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -50,7 +50,7 @@ struct amdgpu_gtt_mgr {
>>   struct amdgpu_mman {
>>       struct ttm_device        bdev;
>>       bool                initialized;
>> -    void __iomem            *aper_base_kaddr;
>> +    void __iomem            *vram_aper_base_kaddr;
>>         /* buffer handling */
>>       const struct amdgpu_buffer_funcs    *buffer_funcs;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>> index bd3e3e23a939..f39d4f593a2f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
>> @@ -611,10 +611,10 @@ static int psp_v11_0_memory_training(struct 
>> psp_context *psp, uint32_t ops)
>>            */
>>           sz = GDDR6_MEM_TRAINING_ENCROACHED_SIZE;
>>   -        if (adev->gmc.visible_vram_size < sz || 
>> !adev->mman.aper_base_kaddr) {
>> -            DRM_ERROR("visible_vram_size %llx or aper_base_kaddr %p 
>> is not initialized.\n",
>> +        if (adev->gmc.visible_vram_size < sz || 
>> !adev->mman.vram_aper_base_kaddr) {
>> +            DRM_ERROR("visible_vram_size %llx or 
>> vram_aper_base_kaddr %p is not initialized.\n",
>>                     adev->gmc.visible_vram_size,
>> -                  adev->mman.aper_base_kaddr);
>> +                  adev->mman.vram_aper_base_kaddr);
>>               return -EINVAL;
>>           }
>>   @@ -625,7 +625,7 @@ static int psp_v11_0_memory_training(struct 
>> psp_context *psp, uint32_t ops)
>>           }
>>             if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>> -            memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
>> +            memcpy_fromio(buf, adev->mman.vram_aper_base_kaddr, sz);
>>               ret = psp_v11_0_memory_training_send_msg(psp, 
>> PSP_BL__DRAM_LONG_TRAIN);
>>               if (ret) {
>>                   DRM_ERROR("Send long training msg failed.\n");
>> @@ -634,7 +634,7 @@ static int psp_v11_0_memory_training(struct 
>> psp_context *psp, uint32_t ops)
>>                   return ret;
>>               }
>>   -            memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
>> +            memcpy_toio(adev->mman.vram_aper_base_kaddr, buf, sz);
>>               adev->hdp.funcs->flush_hdp(adev, NULL);
>>               vfree(buf);
>>               drm_dev_exit(idx);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
>> index e6a26a7e5e5e..9605c0971c11 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
>> @@ -510,10 +510,10 @@ static int psp_v13_0_memory_training(struct 
>> psp_context *psp, uint32_t ops)
>>            */
>>           sz = GDDR6_MEM_TRAINING_ENCROACHED_SIZE;
>>   -        if (adev->gmc.visible_vram_size < sz || 
>> !adev->mman.aper_base_kaddr) {
>> -            dev_err(adev->dev, "visible_vram_size %llx or 
>> aper_base_kaddr %p is not initialized.\n",
>> +        if (adev->gmc.visible_vram_size < sz || 
>> !adev->mman.vram_aper_base_kaddr) {
>> +            dev_err(adev->dev, "visible_vram_size %llx or 
>> vram_aper_base_kaddr %p is not initialized.\n",
>>                     adev->gmc.visible_vram_size,
>> -                  adev->mman.aper_base_kaddr);
>> +                  adev->mman.vram_aper_base_kaddr);
>>               return -EINVAL;
>>           }
>>   @@ -524,7 +524,7 @@ static int psp_v13_0_memory_training(struct 
>> psp_context *psp, uint32_t ops)
>>           }
>>             if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>> -            memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
>> +            memcpy_fromio(buf, adev->mman.vram_aper_base_kaddr, sz);
>>               ret = psp_v13_0_memory_training_send_msg(psp, 
>> PSP_BL__DRAM_LONG_TRAIN);
>>               if (ret) {
>>                   DRM_ERROR("Send long training msg failed.\n");
>> @@ -533,7 +533,7 @@ static int psp_v13_0_memory_training(struct 
>> psp_context *psp, uint32_t ops)
>>                   return ret;
>>               }
>>   -            memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
>> +            memcpy_toio(adev->mman.vram_aper_base_kaddr, buf, sz);
>>               adev->hdp.funcs->flush_hdp(adev, NULL);
>>               vfree(buf);
>>               drm_dev_exit(idx);
>
