Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE79BC38A2D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 05:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64DC510E2CC;
	Thu, 27 Oct 2022 05:17:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2051410E2CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 05:16:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsO9J1TQb8sud99cLtSdPVXh/91BEJ4sNLi1ljxsxtW9e0TeFCvL1Ev6Jl1+YXCzc8mEud60e4nKWkyGhFX7qOLpSAkjBjc4q0OFHHa+D47U8weVVxRG41D3otv3XP/efVIanLbD3zhP0F4iHzwnrweGV6FI3m08IAHISG3FD1RihBWyapQrwe52eWbFRCVmmKDT4M35u2AqiePrUTrtr3Gwdg5jBbGGQun2YEroprFenjE638cbh7jADYnauuEQWeX/4JL2rGP2GKTGSmcTOoxE6L7ETIa3SFzn3tVr1Zq9Fo5fSLe+AogGgU5kdXIhg2qCast4x/8Zp1jU6vAZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gk7JRCF/JNDTI1q79vgpRjFxIXmhC4j58hAWGxudsqM=;
 b=ImXwizwfqG8IiF3GsRfQb5NfJD3SGqsXvfW1n4H2H8EjWWuCWv29mWQPeaO4pRG2gc+7LUlWXRCtXc+sx5bsUWNgX9yaJI2vTrf/8ozQG4IfmFpQ2+v6MfEpVvGS2y+D3qrd24lSkWX+LHViUqPqvuFaOt0sbesNoZ5VJDNXVDS6i7oMUmSz/QImKN24QwbG38OjnUhmitf6rNvf/w+eAmqz0P0UWMmbNUO9tK/v+75Nj+gz9gDiPfQ+/bcbKKp/zRMnbigdfpB19rP0aYi0vqmADud0SJcq1mbUbXjSvFUg6S4w1hry7Pe1Nz4TlFjTn3kZwdNfzMbmuP7tgEULlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gk7JRCF/JNDTI1q79vgpRjFxIXmhC4j58hAWGxudsqM=;
 b=cGFImHz/3larrBsIv8dyNVyOVzS2NVJFvzsmWl+hZ62k/oO9UOaiGx0tg4Jddm+8HarqywHHukMG0ld2Z6INtv0drO/YqhS8imfmt8XUldpGXnR7/2PGuDDduxSfNjy3yfyjZKlOk39ut+HgqbbgKI38GtX9q68mWrBMFVvGe+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 05:16:56 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::dda9:dc0a:4491:ac2]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::dda9:dc0a:4491:ac2%5]) with mapi id 15.20.5746.027; Thu, 27 Oct 2022
 05:16:56 +0000
Message-ID: <994380a1-8f74-29d1-6750-f6876ec31f59@amd.com>
Date: Thu, 27 Oct 2022 13:16:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/2] drm/amdkfd: Init the base cu processor id
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20221026090313.4117136-1-Jun.Ma2@amd.com>
 <a68d95b7-ed9f-6fbf-e655-8401e8ab5d3b@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <a68d95b7-ed9f-6fbf-e655-8401e8ab5d3b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: 6488bfe7-ae18-47f9-6186-08dab7da777c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rd2aH89XjFz5VM4JDMMzZ2ekH8/IhAE4NUS4++eB2RxfQ2TEzh98mwmkNuNDVHQVEE1yo3Jf+Ebf+RQsYxym3D18pvfX3clHsKW3V74yM8ey5+qWKAt4OUyFhqOu5in6ClgDEY1LC8aXWTfeIbw8c1xOQqRMvkgb5pRkUMFMfWrUHBqAEaKO9DWQJ5vwAeMtk8GD414t+LPOZodPzfZ9EhILwXDM2398tM9S+Arihhq30zfcazHBrPhSerDu14G+WhNuLxUl1ayOiIXzworCB9ZZs8IAGbJdqOIOjBocm8h11kfKgRGrAQecchbo/sIn2merzfvZWZ14IxMwuMoS6nJqKDb6qVY05YHm3lNjgTE1d1Unpf6W0iP/5PxbaVdhYSSlUAXQpwirKLcdCqYD+n0ywAUzig6gBjznkBg9Ph/yGv1rffsoXGepWx2H7fDIi4C2Q3GB7rCCsJGafsK5xf9Cy+WFrD46lEz7mVBfda0TPyq76HEtnlLbmyn6BV8DRHsTVW6BNXpUkgKA7bUXlPiE+UzBmt4Sh5QIzUFJ0U/KGy0TODhSfoGydg0t4/PxsHC0oZSa0QMQZyWip5ufvCbaq8kpYruKIoQcbIb+Z0c6EKg+yFt1Qwwvz5yMmNnX3/hm2Cr2pEbrm7gQEzoqnAZeBmFf6T7jmCPj/JfUiFPLF883RwT2Ysbk82ItUe7e88TsAD+kDesJcx2chTWoUKRynRRjHkmH9FrWUmXVDF+QoQLosezgWAR64B/QBDN5Nx/VseNvpk2YlghixDDzlx9QPTMSrED1ajTXogIQJk0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199015)(6506007)(26005)(2616005)(53546011)(186003)(6512007)(83380400001)(6666004)(2906002)(5660300002)(4001150100001)(8936002)(478600001)(66946007)(6636002)(6486002)(4326008)(66556008)(8676002)(41300700001)(316002)(110136005)(66476007)(31696002)(36756003)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVRaV1huRjZIOGVRTGVIdUtHZ05naXo5ZjFUZlFvQ3ZhZkxPOTNGWFdlUDBQ?=
 =?utf-8?B?NXVBTjJBUmFBWk93VTA2TWxKQ2MwUHFRUW5pV1VQQ0s4dGhTYkhwOWd1NEx1?=
 =?utf-8?B?RnoyeXRpUVJxeENDTDRaNjdudSthak8yVkQ3TkIydDdlZEg0aDYzNmhRZkhQ?=
 =?utf-8?B?TVZsNlpkdmRqb2djQ0k4bkdtVGswZ1ZIbHp0WXBPZTZPVkwxUnFXMnFEdXNZ?=
 =?utf-8?B?SUkwd0gvbHNuaE90TmNPL3RCYXB2ekZ5SjZObVdrYlBxVUZvdzFLNkV3clkv?=
 =?utf-8?B?N1cxeDJLaW9kRWlQazlGeHRrbmtnclpmYTZoOTM0ZEx1bE5hYmJsY2c3azcy?=
 =?utf-8?B?MGhZbXFiZlUrTG82ekNtdXpFSWdOem94cTd0WlZOK0pQMHZ4RG1CYjUzbUhI?=
 =?utf-8?B?SDMxQ3ZjTHI3SEV3L0xiZVZ6VG5UL1N6YUxuK25IZHk1Tk93anE4WEhmSlpt?=
 =?utf-8?B?bi9PSlhxS0ZuRjZKc2RhMVZ1eVE1WFBVR2oyVm5GWUdFdjdlWm8ycDBDTmdr?=
 =?utf-8?B?SzZoRVVTYk5ScTY0MzVzajc0elRnVm9HNElCby9oRk5kZHUwVWNtT1pNd0Yr?=
 =?utf-8?B?dy9pREJEbjFjUXFnRUlJK0FlT1Rpb2hZV2pXWk94MjZlNlZtTlI3SVJ3VGRZ?=
 =?utf-8?B?L3d2T1E2VkVtWUJJZ0tZZDVaUkhGWVdweFFCT21LMEQ3Q2I5MFh5djlRNFd4?=
 =?utf-8?B?bjVLODhMMW1oTGxNZjRkQkZSMDJXNGhFenlQdjVpbTNSMnpFMlYrNEllVUFO?=
 =?utf-8?B?Y3A1bkh3UXQ2UDBPS0Fxa2tBYkN5eG5KTVlmb2E4RStYY1UvNGpEU3htQW9t?=
 =?utf-8?B?djhwNmptbDhCaUZSY2h6VEpsa21iWVEyaG9zajdqck5VWm1wcFkydjlTYkd5?=
 =?utf-8?B?N3FqeDk3RFBEbU5jQUtRaHdBNTIxbkZmVm5qWUU4QW10cG80MndXZFFvQ04r?=
 =?utf-8?B?dllKUllGVFpjRFlxb1ZvY2NiUURUbzRKTWV6c2U3L29YQWMxRUx6RDRhalZt?=
 =?utf-8?B?R2RaZWhNcUxrTmQrNDNYbmNTd2lza2JkT1J4SXg1aFVBVmlPSWorTXo3cmI5?=
 =?utf-8?B?NUNxWjRLVVBGQXNnbGxIa3A0TE1NMi9Mb3Foa0trdHpwS2pYU01ET0tBVmJR?=
 =?utf-8?B?aHgwa0MyT2VmMGgxdFN5OXhQc1dzazFWenhXczJjaUFyWTd0NDEyeCt3TXBu?=
 =?utf-8?B?MHZuR2VoSjY5RTl6bjRWbGJ1OHorenFsNUpZMFF4dHFSTjMvQUVVR0NlWkRI?=
 =?utf-8?B?Z2wyanZ4aEtCTG4zMFhOeUowVGVxaENNcnV4dUcxWFVLWXhmM2R1enZPZzF4?=
 =?utf-8?B?TTBYeGwzZTJYdjF2YnhiQVZxVTVXeVQxN09jNmJyM3VIMGJMSElHU1FIT2Q4?=
 =?utf-8?B?aFVueXZmNkljWFpqWHRRQlVOL2luTXkyeDM3aUVmcUY5bjVLMkFLNzBzZFp4?=
 =?utf-8?B?b1ZDUUd2UkZoR2NrcU1kSEdLNnFqdFRoWTBFOWJwWW82dzNPek1NTVBIa1h6?=
 =?utf-8?B?UFhVaUoySEZ6Z1RxazlsTlVTOTlqbksxZmtSVGRkWWZ4TDNEQkJTbFdXbmNx?=
 =?utf-8?B?WkluZkg3TDdPQ2VLaFkrNlVmV3V6Sk53WWdZUWdZa1MrV2c0MG0rd2RnU2JW?=
 =?utf-8?B?MFNmRGp1Sk1ybGVIOUFTWUN3cFB5Q1hNZG9EczByd0VWUndLVlR5WTJjQ1cv?=
 =?utf-8?B?ZDBBV2J6Rmd5NG9nRG1YZ2E4NjhqbVh1TmJ4dDdjemdad1oxbE1MR3l2eW05?=
 =?utf-8?B?cHBBbC96SEMzTjhCT1FMb0JqcTQ5bitaM0hGTTlVTTVuTFI5b1FxTW55U3pq?=
 =?utf-8?B?a0tJWXBBajZSdXRxaGhDR0kwWDNwSkNUS1l4Q3dmMG9yd0dUbWN3MC9PdTdl?=
 =?utf-8?B?YlA5b3diSEhxdXlqUVR1Z0Q2eWdsM0FUUEVRc0ZCNHNTalhzSE9kMTBZMG9Y?=
 =?utf-8?B?Z1M5c01BaFFnTGh5TGY1UDlEOHhIS01EYzFRb0VNK0N5M2hLOWhCRGFQV1dW?=
 =?utf-8?B?WXBFTEpDZmc1MWxFbUYzV3FQWE02NjZRR0xKNFNvQ0QrWUlGTithNmdPRnpu?=
 =?utf-8?B?cVJ0RjlYMXJMMVZKUTRHc095SGhyWFFWS0k1UldvbzJYZGtuLzMzSTNRMDhV?=
 =?utf-8?Q?t2hh2v03EZR7YdeV6WotDqFZf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6488bfe7-ae18-47f9-6186-08dab7da777c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 05:16:56.4864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpzBeQbJ9pIzA7p1rVl3cSk/CBHYhaP/P5RRmfzCXkrd02E8BQztyqN+eSHMh4s/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Felix,

On 10/27/2022 3:07 AM, Felix Kuehling wrote:
> On 2022-10-26 05:03, Ma Jun wrote:
>> Init and save the base cu processor id for later use
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 20 +++++++++++++-------
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  3 +++
>>   2 files changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> index d25ac9cbe5b2..35d09e29aafb 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> @@ -41,13 +41,18 @@ static uint32_t gpu_processor_id_low = 0x80001000;
>>    *	@total_cu_count - Total CUs present in the GPU including ones
>>    *			  masked off
>>    */
>> -static inline unsigned int get_and_inc_gpu_processor_id(
>> -				unsigned int total_cu_count)
>> +static inline void assign_gpu_processor_id(struct kfd_dev *kfd)
>>   {
>> -	int current_id = gpu_processor_id_low;
>> +	struct amdgpu_device *adev = kfd->adev;
>> +	unsigned int array_count = 0;
>> +	unsigned int total_cu_count = 0;
>> +
>> +	kfd->processor_id_low = gpu_processor_id_low;
> 
> This still seems backwards. And I don't think you need it. You can 
> access this after the topology has been parsed from the 
> kfd_topology_device (dev->node_props.simd_id_base). I see you're using 
> it in the next patch in kfd_fill_cache_non_crat_info, which has a 
> kfd_topology_device parameter. This should run after parsing the CRAT 
> tables, so the info should be available at that time.

Thanks. I will use dev->node_props.simd_id_base in the second patch and drop
this one.

Regards
Ma Jun
> 
> Regards,
>    Felix
> 
> 
>> +
>> +	array_count = adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
>> +	total_cu_count = array_count * adev->gfx.config.max_cu_per_sh;
>>   
>>   	gpu_processor_id_low += total_cu_count;
>> -	return current_id;
>>   }
>>   
>>   /* Static table to describe GPU Cache information */
>> @@ -2223,7 +2228,6 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>>   	struct crat_subtype_computeunit *cu;
>>   	struct kfd_cu_info cu_info;
>>   	int avail_size = *size;
>> -	uint32_t total_num_of_cu;
>>   	int num_of_cache_entries = 0;
>>   	int cache_mem_filled = 0;
>>   	uint32_t nid = 0;
>> @@ -2275,8 +2279,10 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>>   	cu->wave_front_size = cu_info.wave_front_size;
>>   	cu->array_count = cu_info.num_shader_arrays_per_engine *
>>   		cu_info.num_shader_engines;
>> -	total_num_of_cu = (cu->array_count * cu_info.num_cu_per_sh);
>> -	cu->processor_id_low = get_and_inc_gpu_processor_id(total_num_of_cu);
>> +
>> +	assign_gpu_processor_id(kdev);
>> +	cu->processor_id_low = kdev->processor_id_low;
>> +
>>   	cu->num_cu_per_array = cu_info.num_cu_per_sh;
>>   	cu->max_slots_scatch_cu = cu_info.max_scratch_slots_per_cu;
>>   	cu->num_banks = cu_info.num_shader_engines;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 182eb67edbc5..4c06b233472f 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -370,6 +370,9 @@ struct kfd_dev {
>>   
>>   	/* Track per device allocated watch points. */
>>   	uint32_t alloc_watch_ids;
>> +
>> +	/* cu processor id base */
>> +	unsigned int	processor_id_low;
>>   };
>>   
>>   struct kfd_ipc_obj;
