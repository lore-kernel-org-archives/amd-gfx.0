Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFB0EEAA44
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 14:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5589410E26C;
	Thu, 14 Sep 2023 14:18:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56D5C10E26C
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 14:18:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdZenq0+X2cY9gflVM+HGlEvYK/1HtRSsbwrddS4WWB/G/4GEFwUKfpIAdgRulxubesBX+blgp9LjweASLqh9tFyu7pzswuzB3LpAhKdp5Vh3CPRleYgz4mnahYG/Vm4SONbKT4qX7n52yxtbYLXLRPWLnhfZ+RW4cVUB1p+tQ7PqcopPFvYhXLxU7Kihxgj2Rx3EH9UiCV33xW2VAeEnESasoMdf+cDqScLkk+h7a1s1+6Aj7aGOG8HZQz9o4W9uguolbLP1tpVTaKwaCh3gMufhchp0LXOxXUXZdQj0B5u7PuEsvU9TG5xL9dIgZSYxYIb2Anu0pAxCZ50ljzywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6JJWCyat/FFw7Icc7DwyL9RDf6ApfboLlW1zuA7PUo=;
 b=NjBbczTPpKIWuBK0YfuYDMcrBgrF3Ze4vvcUFf4GamrNwy21u42xk4r6q2VKMosg48E4MuL9ScLmMsmnsLyD4OAmcdmh2Wn3L9wGDfhWoYD4sXcudglRE94h2fGXl7tdtmKHhmHWSL4or83qOQVHIGwA8xt8YK0lvIqmf45dCMOAbgnQj4ta5NdHALn2hWwKyYBFb77PDArN4JfvIlYRkIX4kzp32+v/3xf24zM7VtdHL3l95DeJxrFlPUj6dosyE6tTS0YsS+MVNn8jFQv9eBCbixfhdavYXHj32YN5Utp/ucoYj0eWhfjM2g1ZUW0YJLqS8vm9XkUiTqj4MhoBCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6JJWCyat/FFw7Icc7DwyL9RDf6ApfboLlW1zuA7PUo=;
 b=vgTGbwEniTfIfZc5Uj0s8QigN/1Eecaqg46HXPngN093h8JujdIKLhASDbfJZBgAK78kFX9zrDQ8ZN8NK9GKHpBVoTpeb7zjk7yVp9LgsiQa+5/GrV2CsLPZqpEuc8Rz6BDEkphSChLmNL66+S7Bdv+49d+TF/eAkQDxGbGigu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB8540.namprd12.prod.outlook.com (2603:10b6:208:454::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 14:18:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 14:18:05 +0000
Content-Type: multipart/alternative;
 boundary="------------0XC9An06glw6i000PPIOglGR"
Message-ID: <e7913001-ff45-169d-7110-3f2bef86208a@amd.com>
Date: Thu, 14 Sep 2023 10:17:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] drm/amdgpu: always use legacy tlb flush on
 cyan_skilfish
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230914092350.3512016-1-Lang.Yu@amd.com>
 <40c096af-6c59-ce6d-af26-5cce7bceab83@amd.com>
 <1317e1a5-b1c0-2c3d-6082-b628fde5ab4d@amd.com>
 <745145aa-76fb-bb17-6065-c5e29c37f3c6@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <745145aa-76fb-bb17-6065-c5e29c37f3c6@amd.com>
X-ClientProxiedBy: YQXPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: aad8b595-cf7d-4a5c-e260-08dbb52d698e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CqhSrypwph2XOOumFCsU8GTN6fO+2+UFWjpatHetnBGggsKAAMrpsrahqHqdA3wx1izTeAcOuhVqS40hIh4FGGAdix4r5m83AmkzbLH3+GwlBIOZ1k6RF2ippy3LM1w+PqtqLWeT5sl0rtlvhQdZPSIgfiZfzcrIvdSiuhX5lBfRFIdQgxXH3PLbITumTKTtWk1KXKd3kx2yl0BMSlD50p6sKJCOEAubWyr4PzgiILfhp8XB8ei4WRoRKycVAWC46x3Y1gGOO0OFic4gwreCj9NDe5rPwSHtBs2kJCMG8xdPFPAtg8CyttS+nHUsx9ulexVhI2VGRxPMSp0ODlOuu9oocQI3DY3acUGvthJ/vjCWDQ9H8uxWgYcjTwFr41Tlqb6JMccWXgYGQlX5rdgkUQdEKjowOEPf3Wtts2eqZLHoCspNp3T9cTiuei3E89DI4g+VWyoOHWKHPIppeQBS6vGivvt77UXG4bz1xN36/R1q25QzfwoeWp1krzNUqmzPB3ES/CajuCNbP6C5fU6nPPq7z07MIVhuN8tIxQIjkBINPE5yAF/IeshtEAwAG/M0lPha6xvbVZwqEcycMKMiq1Ym4XUTb0xr5up6WxbTN4y9X3s7CWQCjvQ8puABOQ1e8xcpwgmf97sgWvD1cJdm1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(1800799009)(186009)(451199024)(31686004)(38100700002)(2906002)(54906003)(66899024)(6512007)(4326008)(66556008)(36756003)(41300700001)(316002)(8936002)(66476007)(8676002)(44832011)(5660300002)(6666004)(6506007)(31696002)(33964004)(53546011)(6486002)(2616005)(66574015)(86362001)(110136005)(26005)(66946007)(478600001)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzgwcTlrOFlWNjBCSStxdS9EM0EyejJNejBKTGdxMEZXWGJEZVF6RzV5bDlY?=
 =?utf-8?B?THMxaE9nTjVIcXNIY0VyTHNCRi9jUUtRVnRoZjJIRE85YWcyd05BMEZXM3Va?=
 =?utf-8?B?L2txZ3pGTllJS2tvTHJDL0NJcTZBRzI3NncrODkxRTB5M21TZTFraWpmSGVz?=
 =?utf-8?B?Q1FKWmdjN25iV2k1UWZLTVNxcFRVVURDY3J1cHRUQ05QbVhENi93WXRyRis5?=
 =?utf-8?B?di9jeHUzUTZkSk9BcHV4c2xnSXhEL3hHRU5CQTRJOU5LSkJPTzlscThidDBE?=
 =?utf-8?B?NjN3Mk5mdGpGbkNzYTk1cGROYWM3Vk1Cc3VUVHRySUpPMjFXV05XbTQ1K3cx?=
 =?utf-8?B?L3c1MVN1NmRyZ3JteFo2U1FiL3pHS3dvSzBqV3JiUEh3b3BKb2trZUJOb1ly?=
 =?utf-8?B?eWRMdG0wQXlWeE4zbnhoc3dlUzZ1TjlrWEI3NXE5cVNoeU1ITk9Sek11SnFX?=
 =?utf-8?B?eXJ0SndVMTFhS0dMd21sb2wzNisvaW1zNXJNM1IwVzlDYjMvM3BlNGlFaVo4?=
 =?utf-8?B?QVZsdjBob1lZVklEL1IwVktjV0ZxRFQxSWlXYlZ4dzFpbVZndUhhYUd6Ukk5?=
 =?utf-8?B?ZVNxdGFpMUtpd21ZZjRkNU1RL3U3Q2RaYXBsQzgrR1lHT2VHekE0dTc0KzVu?=
 =?utf-8?B?Ym9jSklmOHM4WklNa1RLUGN2Vm9KRk5WT1ErdXQrQ0RaRlFsRndUR3dDRGto?=
 =?utf-8?B?YkdXWTBzK0JrTEthandveUpQNlpmMG9scWM4Z2FRZ3pSb2I4c25VNFp2bHky?=
 =?utf-8?B?UW1EaUN1czhYb0Y4dk1rMTg4TkIzd3FUS1A2Vnk5eE4yVFE3NVdZUkI3QVVu?=
 =?utf-8?B?K2hUeGgwUmVVd0U1Q3JKdGZIbGpmNGp3WEFFSFY3Mm1MWmJLM0ovNTAydEt2?=
 =?utf-8?B?MEpRbVVjdHRtaTdmZGVWNUpQVlVoWjEwdmVCdWp3c2loZmpoN0VEN3NJS1lT?=
 =?utf-8?B?YkpNOUlhUmJ3TVcwZTJGbk9nUURualUxVFMrNFhYcWttajVoNzQ1TXQrL2xt?=
 =?utf-8?B?MWI1b1ViVVpoV0o0NGp2R2NZZjB2cnM1MXVaUmFaY0JMQWhKZkFmSENMcHBB?=
 =?utf-8?B?aVJVV2loMWE3dFFxQ2FOalhVdS9xYlorOWZGMmlQWldQbmoyYzZFZFF2OXUv?=
 =?utf-8?B?QnpQY2dSMklTZGFGeDljYUNQN01JbHErcDBDTHMvK3ViY1JFQWtIdnNYTlhM?=
 =?utf-8?B?b29KRnZRdVIvMnJEK1BvSU9wQjBlWTJqTTF6bVJpSnMxRHVXSjVaUDlaT0k1?=
 =?utf-8?B?TEIzd0V3MmJUSlQ5Nkk4VzRyN3RuMkJIL0hmYnFFb3VtRVdOZmJWMkx4cllD?=
 =?utf-8?B?OUJTcHNsNWIwSmFUajY2VXoxZENMZHFMNVg3MkM0VjNYcEY3TlBGKzZydVF6?=
 =?utf-8?B?WHdaSTFXTXIxaHV1VkRYV21IVVpBQ05BQ1JxWHZPd2dyQ3MwTXRoMi9Ma0J4?=
 =?utf-8?B?Wk0yYi81RVh5R3NrMXlsY0lNdHFkVzZka0VWNzNLcXpOQ2V3WklKZjA3TTZz?=
 =?utf-8?B?TlY2L1NRNjh5OXFtUGFGNlF5YUpmODdJSHVKcUQrenI4ZW11MUlYSXllQ2U4?=
 =?utf-8?B?N1ZDL0w5WnI3U0RydVowMkgxeGt0aUwvK2VERG8zd2hENnBWNG16WnZSeG1m?=
 =?utf-8?B?N2xUVk1LT0VwQ09aQ29TRnJJOFppRHQ4cXVrR1BoODR6NHhsU3dUc0F3OFBR?=
 =?utf-8?B?K3I1V2d1Y3FMUUF4dGtZMFhJbnVWY1JUU3JuMFBLb1BnOTRid0xEdncxKzBs?=
 =?utf-8?B?dXNteWhHbi9aUVdSYWd1aHVTK2NhRXljUGtsUFd5enFldEZldjB5eVZ6YWRa?=
 =?utf-8?B?RVluVTZPMU9pOEV4TWRtWk81cmlnenhXbEY0aDRLVlNHdW9ZeTBIMU5xbXRR?=
 =?utf-8?B?b2dNQjRHWGNQWTIvVFRmTzRvOU5Cc2UveVoxSVVaZmxrZDR0eTFPTUd2NHZ4?=
 =?utf-8?B?ZTByVlY4Q1hWWU1maFBlZHRLTDVXV09pVVhaT0tYY0R4ZEtqQjBIdklrTzhJ?=
 =?utf-8?B?akR2anlDbjZGZGZueEJySjdCeDFCQ3RTbmQzeGF6NWUweHptYThCVDkxS2tk?=
 =?utf-8?B?OUZrN1djeGtlUk5GMGZRNjJydURFQVQ1VXNoQUE2UVZlYmUrdU1MT0FjN3ov?=
 =?utf-8?Q?xmhG2Ldj5RA7PUB4nvS5/qC+a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad8b595-cf7d-4a5c-e260-08dbb52d698e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:18:05.3883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kz2KfA/mbeouUZ8Zocqr8T0Q2gsFrDslBbJxjs+LFbYPeUVYt66DBOLzxmyrJJOIWhYR1KDNzK9+aN7BIpDyMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8540
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
 Yifan Zhang <yifan1.zhang@amd.com>, stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------0XC9An06glw6i000PPIOglGR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-09-14 10:02, Christian König wrote:
>
>
> Am 14.09.23 um 15:59 schrieb Felix Kuehling:
>>
>> On 2023-09-14 9:39, Christian König wrote:
>>> Is a single legacy flush sufficient to emulate an heavyweight flush 
>>> as well?
>>>
>>> On previous generations we needed to issue at least two legacy 
>>> flushes for this.
>> I assume you are referring to the Vega20 XGMI workaround. That is a 
>> very different issue. Because PTEs would be cached in L2, we had to 
>> always use a heavy-weight flush that would also flush the L2 cache as 
>> well, and follow that with another legacy flush to deal with race 
>> conditions where stale PTEs could be re-fetched from L2 before the L2 
>> flush was complete.
>
> No, we also have another (badly documented) workaround which issues a 
> legacy flush before each heavy weight on some hw generations. See the 
> my TLB flush cleanup patches.
>
>>
>> A heavy-weight flush guarantees that there are no more possible 
>> memory accesses using the old PTEs. With physically addressed caches 
>> on GFXv9 that includes a cache flush because the address translation 
>> happened before putting data into the cache. I think the address 
>> translation and cache architecture works differently on GFXv10. So 
>> maybe the cache-flush is not required here.
>>
>> But even then a legacy flush probably allows for in-flight memory 
>> accesses with old physical addresses to complete after the TLB flush. 
>> So there is a small risk of memory corruption that was assumed to not 
>> be accessed by the GPU any more. Or when using IOMMU device isolation 
>> it would result in IOMMU faults if the DMA mappings are invalidated 
>> slightly too early.
>
> Mhm, that's quite bad. Any idea how to avoid that?

A few ideas

  * Add an arbitrary delay and hope that it is longer than the FIFOs in
    the HW
  * Execute an atomic operation to memory on some GPU engine that could
    act as a fence, maybe just a RELEASE_MEM on the CP to some writeback
    location would do the job
  * If needed, RELEASE_MEM could also perform a cache flush

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> And please don't push before getting an rb from Felix as well.
>>>
>>> Regards,
>>> Christian.
>>>
>>>
>>> Am 14.09.23 um 11:23 schrieb Lang Yu:
>>>> cyan_skilfish has problems with other flush types.
>>>>
>>>> v2: fix incorrect ternary conditional operator usage.(Yifan)
>>>>
>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>> Cc: <stable@vger.kernel.org> # v5.15+
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 ++++++-
>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>> index d3da13f4c80e..c6d11047169a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>> @@ -236,7 +236,8 @@ static void gmc_v10_0_flush_vm_hub(struct 
>>>> amdgpu_device *adev, uint32_t vmid,
>>>>   {
>>>>       bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(adev, 
>>>> vmhub);
>>>>       struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>>>> -    u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, 
>>>> flush_type);
>>>> +    u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid,
>>>> +              (adev->asic_type != CHIP_CYAN_SKILLFISH) ? 
>>>> flush_type : 0);
>>>>       u32 tmp;
>>>>       /* Use register 17 for GART */
>>>>       const unsigned int eng = 17;
>>>> @@ -331,6 +332,8 @@ static void gmc_v10_0_flush_gpu_tlb(struct 
>>>> amdgpu_device *adev, uint32_t vmid,
>>>>         int r;
>>>>   +    flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH) ? 
>>>> flush_type : 0;
>>>> +
>>>>       /* flush hdp cache */
>>>>       adev->hdp.funcs->flush_hdp(adev, NULL);
>>>>   @@ -426,6 +429,8 @@ static int 
>>>> gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>>>>       struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
>>>>       struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>>>   +    flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH) ? 
>>>> flush_type : 0;
>>>> +
>>>>       if (amdgpu_emu_mode == 0 && ring->sched.ready) {
>>>>           spin_lock(&adev->gfx.kiq[0].ring_lock);
>>>>           /* 2 dwords flush + 8 dwords fence */
>>>
>
--------------0XC9An06glw6i000PPIOglGR
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2023-09-14 10:02, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:745145aa-76fb-bb17-6065-c5e29c37f3c6@amd.com">
      <br>
      <br>
      Am 14.09.23 um 15:59 schrieb Felix Kuehling:
      <br>
      <blockquote type="cite">
        <br>
        On 2023-09-14 9:39, Christian König wrote:
        <br>
        <blockquote type="cite">Is a single legacy flush sufficient to
          emulate an heavyweight flush as well?
          <br>
          <br>
          On previous generations we needed to issue at least two legacy
          flushes for this.
          <br>
        </blockquote>
        I assume you are referring to the Vega20 XGMI workaround. That
        is a very different issue. Because PTEs would be cached in L2,
        we had to always use a heavy-weight flush that would also flush
        the L2 cache as well, and follow that with another legacy flush
        to deal with race conditions where stale PTEs could be
        re-fetched from L2 before the L2 flush was complete.
        <br>
      </blockquote>
      <br>
      No, we also have another (badly documented) workaround which
      issues a legacy flush before each heavy weight on some hw
      generations. See the my TLB flush cleanup patches.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        A heavy-weight flush guarantees that there are no more possible
        memory accesses using the old PTEs. With physically addressed
        caches on GFXv9 that includes a cache flush because the address
        translation happened before putting data into the cache. I think
        the address translation and cache architecture works differently
        on GFXv10. So maybe the cache-flush is not required here.
        <br>
        <br>
        But even then a legacy flush probably allows for in-flight
        memory accesses with old physical addresses to complete after
        the TLB flush. So there is a small risk of memory corruption
        that was assumed to not be accessed by the GPU any more. Or when
        using IOMMU device isolation it would result in IOMMU faults if
        the DMA mappings are invalidated slightly too early.
        <br>
      </blockquote>
      <br>
      Mhm, that's quite bad. Any idea how to avoid that?
      <br>
    </blockquote>
    <p>A few ideas<br>
    </p>
    <ul>
      <li>Add an arbitrary delay and hope that it is longer than the
        FIFOs in the HW</li>
      <li>Execute an atomic operation to memory on some GPU engine that
        could act as a fence, maybe just a RELEASE_MEM on the CP to some
        writeback location would do the job</li>
      <li>If needed, RELEASE_MEM could also perform a cache flush<br>
      </li>
    </ul>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:745145aa-76fb-bb17-6065-c5e29c37f3c6@amd.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Regards,
        <br>
        &nbsp; Felix
        <br>
        <br>
        <br>
        <blockquote type="cite">
          <br>
          And please don't push before getting an rb from Felix as well.
          <br>
          <br>
          Regards,
          <br>
          Christian.
          <br>
          <br>
          <br>
          Am 14.09.23 um 11:23 schrieb Lang Yu:
          <br>
          <blockquote type="cite">cyan_skilfish has problems with other
            flush types.
            <br>
            <br>
            v2: fix incorrect ternary conditional operator usage.(Yifan)
            <br>
            <br>
            Signed-off-by: Lang Yu <a class="moz-txt-link-rfc2396E" href="mailto:Lang.Yu@amd.com">&lt;Lang.Yu@amd.com&gt;</a>
            <br>
            Cc: <a class="moz-txt-link-rfc2396E" href="mailto:stable@vger.kernel.org">&lt;stable@vger.kernel.org&gt;</a> # v5.15+
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 ++++++-
            <br>
            &nbsp; 1 file changed, 6 insertions(+), 1 deletion(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
            b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
            <br>
            index d3da13f4c80e..c6d11047169a 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
            <br>
            @@ -236,7 +236,8 @@ static void
            gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t
            vmid,
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool use_semaphore =
            gmc_v10_0_use_invalidate_semaphore(adev, vmhub);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vmhub *hub = &amp;adev-&gt;vmhub[vmhub];
            <br>
            -&nbsp;&nbsp;&nbsp; u32 inv_req =
            hub-&gt;vmhub_funcs-&gt;get_invalidate_req(vmid,
            flush_type);
            <br>
            +&nbsp;&nbsp;&nbsp; u32 inv_req =
            hub-&gt;vmhub_funcs-&gt;get_invalidate_req(vmid,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type != CHIP_CYAN_SKILLFISH) ?
            flush_type : 0);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Use register 17 for GART */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const unsigned int eng = 17;
            <br>
            @@ -331,6 +332,8 @@ static void
            gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t
            vmid,
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;
            <br>
            &nbsp; +&nbsp;&nbsp;&nbsp; flush_type = (adev-&gt;asic_type !=
            CHIP_CYAN_SKILLFISH) ? flush_type : 0;
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* flush hdp cache */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;hdp.funcs-&gt;flush_hdp(adev, NULL);
            <br>
            &nbsp; @@ -426,6 +429,8 @@ static int
            gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
            &amp;adev-&gt;gfx.kiq[0].ring;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq = &amp;adev-&gt;gfx.kiq[0];
            <br>
            &nbsp; +&nbsp;&nbsp;&nbsp; flush_type = (adev-&gt;asic_type !=
            CHIP_CYAN_SKILLFISH) ? flush_type : 0;
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_emu_mode == 0 &amp;&amp;
            ring-&gt;sched.ready) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;adev-&gt;gfx.kiq[0].ring_lock);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 2 dwords flush + 8 dwords fence */
            <br>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------0XC9An06glw6i000PPIOglGR--
