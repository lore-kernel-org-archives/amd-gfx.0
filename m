Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A238DC48297
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 13:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19FFF10ED72;
	Tue,  6 Feb 2024 13:52:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hIJCJrjb";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9AAF10ED72
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 13:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aD5jp5WmFuEDWgEgEEIfMuhA96nFXLqcSQE6ErEwn6Z0CKOwLnt7X+M5Ts5kgoaB7SEckNQ2QXGVEIVYIyKkBb68dp27kT1RHwH8f8t9OKyH+niCnXcHpR05JVCG8wnarNkE59EOH85uRLz1gkPb4AhtyjNPUIaBKlVjoVJqJS0/0HWxuc0LLCNwnxy9uIA71g5epRGjXamKg8DD8EJ1NKHU5m1AqilDy1iabOTnGSOSanH3SJKDHKOJU7kqNaOKygc0DDk96PZA66RaMQ4tfU1WrcDIM0FtlrsOYPsLmtq52AkJ1+OoVKg1Ke3zsfdc1IRvj2GMYHLOwPy7Vy7VHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtxIYsCL3ooHKeJyIYwQwC18lu8fJKb8USgUmB4Ist0=;
 b=Zueu8T6THKlB8VlCSnOzlDfiminHfxydKXR5S/jgT6XU5dvU4CqrfJWU3YL/g6t8qPfa4uPrM2cKK57wXUQbeyjbhAEuyJA/DKiEtEGzWR1R9zF0ChlCpNDsGO96t9YenqrE3IghHkzI1boVqoNhxW7WmUHY/r0C5qQQgye7Ds3hDYario5KiNrzkJ+uzg2mBnpzML6+bVlNw+/qjf1X1KT7I3yEp62aGWi2k2kvKxSwchsHzH6lMUByg732z30XIoUsXqrc08x0pw7lP6qEHH4YR3MkRyoPbOrJl3hKq/J3TjqmN9tLbwAc1nZ6iBYwtYgMKMFMUeBxu9slTGb6Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtxIYsCL3ooHKeJyIYwQwC18lu8fJKb8USgUmB4Ist0=;
 b=hIJCJrjbU5aZfbtzCqQLFebkcZWrcvysnsdxY2w9UMOh69Ol/H7Vcpgq/mi0o66ppGFbsGvhTGqijYm1olyrvttRqvOnHNCB52qelu5uT0KstQU2diP2hQG6FoTYCe7g4HmH2Jwv1OSfMq4f7TcdSZBI7jT04TtRwOxMyPJZEQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 13:52:22 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f8bf:e004:1555:f21c]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f8bf:e004:1555:f21c%7]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 13:52:22 +0000
Message-ID: <b4f61c99-8de6-edc1-7ca4-f4b495c1b2ad@amd.com>
Date: Tue, 6 Feb 2024 14:52:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/3] drm/amdgpu: sync page table freeing with tlb flush
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
References: <20240131171434.256-1-shashank.sharma@amd.com>
 <20240131171434.256-3-shashank.sharma@amd.com>
 <5c724b4e-9c40-451f-bef7-6bf8eab030b8@amd.com>
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <5c724b4e-9c40-451f-bef7-6bf8eab030b8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::17) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: a2addaf3-a92f-4354-645b-08dc271ad7ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJh5dMAVJFJ8/eCovDVZFbkzTLeWGtuOqTepmTV4xx2AI/cvR04jk/RqJpDck4JZ1yYqwa4rzVyJ+DEg631CAELCjSGWFqXPM91NBlmlnAljoGzU9lKQCmZuAsOJIkF/tCwuPDmHdFmYZ/nmgTWn1Mj0b6ZAFjFss715ypk3RVPZyMVFfet3D/s8DF2G5nQUMY1JKZc95uCcbYe9odkvys9qXy640vQ0YbXb+79/aUEqpUgWxfxuBTrGyYBXdeTAGOMFpugHOoxdAtN2y3Vbqrslsbo/Q9HRTCcnW+5UusRKsuNlGUDkYBUGOMJRr8So8SxMyrCADGyJTa3EnA+2CkFazfFa4rE9zw+pFbFO3lF144Xb7GMbNcW4m+pfUgjl7v8AdiUqDzitOgtUfpoiO3qH/ZN5wMTvG+eoiuE94Hy5FOmIXlNuSoM3GMG6oAovCmDgN28VUfHLyyDfQF6kChaNSfjSqhPI18xCu+o4Tps8v8/elXkY/VxQhe0csHvUH+UnqbkR11dK0jCd8Xfrb6UV4y1Rw1FpAeqs5DsXGNkfQnqOrfziib4hhHDUzTzn0VwNbKN4Ae66ZtM5L2pfSvraeakA7zMjlfXtYN/cUETXyvBGsOd8hFQO24itx42pmPvIvdRi724NiZS+auJL5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(316002)(66946007)(66556008)(8936002)(4326008)(8676002)(5660300002)(66476007)(54906003)(86362001)(36756003)(41300700001)(6486002)(38100700002)(6506007)(53546011)(26005)(83380400001)(6512007)(6666004)(31696002)(478600001)(66574015)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXN6N1JWWjh0bUtFK0dCRkhkSEsrd21HcUFDU09COVBtWFJFeVN0WFZpQ1VE?=
 =?utf-8?B?eVRIVUNlT2JFcVh1emFOUy9xamh2blhQUTNVN3RqNmVSRXlJNHRQWjQzWGZJ?=
 =?utf-8?B?VS9sWHkvUHlMUWk5NEpDOXRDUmo3QUhsaWFmUHB1N0JYZ0dSN1F2RTY2SFk0?=
 =?utf-8?B?cnE1dDlZK2N4YzE4Ulg2UVlScm9za1h3MXBGbmRhN21JS3hYcXpyb3ZBWmhK?=
 =?utf-8?B?K2RJdEFnQjdxV2pDYjNlZWw2ZXNFajJwR0M5ZldqOEhoc1ZWcDJWbEpjQmJV?=
 =?utf-8?B?SkxjMVd2dTB6WlVjV1ZkZlIzNlI4Q0YwOVJQbk1pMVJoc2YrRGpQNGZSOGxa?=
 =?utf-8?B?YjBhaDlpWi9NMjllK2hJTHAxV3lnNFQvUGZydmgvTjFNMkU0UWl5YjlyQXF6?=
 =?utf-8?B?WFpUSW1LVlp2eHJ6ZEgyTjZ2MUl5dms2TEVyeVhsazJDWk1lT0NrOUhZeGhx?=
 =?utf-8?B?QUZqUms5R0ZEWmowMlpoNnk3Nk5WZGFZdXlRbS9BV2UvcE10eXNwUUtPQnQv?=
 =?utf-8?B?NzhCbzJuV3FiMElOT2V4Y3VrWUZaVzJZblZwemt4RzEvT2EreFF3S2M5aHpJ?=
 =?utf-8?B?d0tXMW5oTE4zVEZTNzB6ZVdna2tjM21oYWxzdlI5V2lSSWhLTXFRVHN1NUJM?=
 =?utf-8?B?RkZCdSt0d3FzWDNtVC92blc0YTN0Wm1Id1lKc1l6eVRXdWNhem9BdHhaaHZz?=
 =?utf-8?B?NzRsbWJBaVZad3dHZkJpckhhNzNEZlg4VzV4aU9ZbFFHWHJkN2M1MEZ6T0Vm?=
 =?utf-8?B?N0hmQkNwcWRKN05FaHlmTFcyRnprSW5sdmszSUJLbHZPU1RCMXl3ektUaWdl?=
 =?utf-8?B?ZHUyTnlpQXRzakc5aURtRzV2ZEVHVVpzeklhUkl0OUY0TnNPTWthUVpLMC8r?=
 =?utf-8?B?d2piOVE1QVAySGNTcGJEbkhqRThEMDVTdHR5ZXArei96VFBkanhQdW0vd2Nk?=
 =?utf-8?B?d2xhMkdCRDFmTnU4Smhva2lTcUxvT1ZzSkh4RCsxbDIvTW1lam1DSW1sVjZk?=
 =?utf-8?B?ZXN0K0NJUmlKZEluOWI1VnN2QkNwTWpxODZGZmNBVzRiRUJualhBOFF5VDZo?=
 =?utf-8?B?Q1dvSWRUWWxrWGNXdW9hWmNjaDduQVZTNktOT2lIWUxIR3UyN0hobm5OL0Rn?=
 =?utf-8?B?cDdNL21EVVRyRnpvS0VGVEJVSHJReTNjSGZmaTN5QzFsQ0pxbmMyNXJMdm9M?=
 =?utf-8?B?cUtJS3NUdHRtWkZSdW5vZDdiME51bkJhN1JDMTE5OWw5NTFIb2psOEZzYzFT?=
 =?utf-8?B?S010TnI2L1JXRkszMUltRmVxcldoRFhaMzdCUyt5WXpHYVFkNS93c0FJcG5l?=
 =?utf-8?B?Z1pCZXVTdHVrT3Rxd2pUZEY0ZlY2blJQbFBNWEx2UUMrSHc0eHVyUGdjTjZq?=
 =?utf-8?B?anU4dXdWNlFldk1maHV4VS90Q2xCeGdyWnh3NjY5cHd4L3g1RUxQRDcrNjFj?=
 =?utf-8?B?L3RCK2lnYmc1Q29qdmNWWStaOTVNWGxGZk8yYzhUY1JDTXVBSzJCQ0JvOGNk?=
 =?utf-8?B?MER2Z2Nkb2I5UngwdHJIb3hXVHZ1MDNzQ2FncU1RbkhzN2dtTHdKWWllT2hC?=
 =?utf-8?B?TkVpMDB0K3F0bWVWZytBUS9kME1COGZkOG9ka21zcFc5N1dCaGNFUjZPakpo?=
 =?utf-8?B?UGVPU0I0RHlUYWtyTGJDcXYyNXRsSlpoREtuWFNXRzVERjNVSU5ZRGhuVW1K?=
 =?utf-8?B?UDRIcHdFRFhhZFZReGpneGlwU3RqVEpxRWprWW1Oa3ZNWmh0OTVCcEJhMTFp?=
 =?utf-8?B?cGl5SXBnMXJzSnpmMGxTZXlJb1VQVW5JY0VDRmRienVtZkRuSE10bmE4azBK?=
 =?utf-8?B?Zk5nb2YrRjVCMGNZOHVWUm5tQVlGSzlkMkcyVnQ4UWlyKytWRHBjN2NPQnZM?=
 =?utf-8?B?MWlJUUM4RHJUWEQ1cnN3R1d1alNudGRVUFZ2N29lVEk2c2ZPekYwT2xaOCtD?=
 =?utf-8?B?SVlpbGFtNzkrSWlSbE9GYUNzejZZZEd5Y29TNEUvNHFzSkFNdDdCSnhTaTM0?=
 =?utf-8?B?NlY1dWVzdEs0R1ZKMzlYWi9xNisxYWJGYnFxeVdMNjB5Q2FTNkgyTVAvVlps?=
 =?utf-8?B?YUQ3N2JmWG52WkVId2NINEh2RW9xc1g5dHhLQTU0TnNYOXpsUVdXRDlQeExC?=
 =?utf-8?Q?g2k4Wy7S9Qt5HrIq1cteDvFbw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2addaf3-a92f-4354-645b-08dc271ad7ba
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 13:52:22.4794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQJK6NzPQOX1IWgubrewpFAE8Y0HGLPg1DNj+KVmcmCkRu2Fyhrz6yMH6vVqfRHANlKfqxdrp0HuVOz1Nfi3Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
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

Hey Christian,

On 01/02/2024 14:48, Christian König wrote:
>
>
> Am 31.01.24 um 18:14 schrieb Shashank Sharma:
>> This patch:
>> - Attaches the TLB flush fence to the PT objects being freed
>> - Adds a new ptr in VM to save this last TLB flush fence
>> - Adds a new lock in VM to prevent out-of-context update of saved
>>    TLB flush fence
>> - Adds a new ptr in tlb_flush structure to save vm
>>
>> The idea is to delay freeing of page table objects until we have the
>> respective TLB entries flushed.
>>
>> V2: rebase
>>
>> Cc: Christian König <Christian.Koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Felix Kuehling <felix.kuehling@amd.com>
>> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  3 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  4 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 27 +++++++++++++++++++
>>   .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 13 +++++++--
>>   4 files changed, 45 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 67c690044b97..b0e81c249e3a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2245,6 +2245,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm,
>>       vm->generation = 0;
>>         mutex_init(&vm->eviction_lock);
>> +    mutex_init(&vm->tlb_flush_lock);
>>       vm->evicting = false;
>>       vm->tlb_fence_context = dma_fence_context_alloc(1);
>>   @@ -2360,7 +2361,9 @@ int amdgpu_vm_make_compute(struct 
>> amdgpu_device *adev, struct amdgpu_vm *vm)
>>       }
>>         dma_fence_put(vm->last_update);
>> +    dma_fence_put(vm->tlb_fence_last);
>>       vm->last_update = dma_fence_get_stub();
>> +    vm->tlb_fence_last = dma_fence_get_stub();
>>       vm->is_compute_context = true;
>>         /* Free the shadow bo for compute VM */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 8e6fd25d07b7..b05bc586237f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -334,6 +334,10 @@ struct amdgpu_vm {
>>       uint64_t        *tlb_seq_cpu_addr;
>>       uint64_t        tlb_fence_context;
>>   +    /* Ptr and lock to maintain tlb flush sync */
>> +    struct mutex        tlb_flush_lock;
>> +    struct dma_fence        *tlb_fence_last;
>> +
>>       atomic64_t        kfd_last_flushed_seq;
>>         /* How many times we had to re-generate the page tables */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 95dc0afdaffb..f1c4418c4d63 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -631,6 +631,18 @@ static int amdgpu_vm_pt_alloc(struct 
>> amdgpu_device *adev,
>>       return r;
>>   }
>>   +static inline
>> +void amdgpu_vm_attach_tlb_fence(struct amdgpu_bo *bo, struct 
>> dma_fence *fence)
>> +{
>> +    if (!bo || !fence)
>> +        return;
>> +
>> +    if (!dma_resv_reserve_fences(bo->tbo.base.resv, 1)) {
>> +        dma_resv_add_fence(bo->tbo.base.resv, fence,
>> +                   DMA_RESV_USAGE_BOOKKEEP);
>> +    }
>> +}
>> +
>>   /**
>>    * amdgpu_vm_pt_free - free one PD/PT
>>    *
>> @@ -638,6 +650,7 @@ static int amdgpu_vm_pt_alloc(struct 
>> amdgpu_device *adev,
>>    */
>>   static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>>   {
>> +    struct amdgpu_vm *vm;
>>       struct amdgpu_bo *shadow;
>>         if (!entry->bo)
>> @@ -646,9 +659,23 @@ static void amdgpu_vm_pt_free(struct 
>> amdgpu_vm_bo_base *entry)
>>       entry->bo->vm_bo = NULL;
>>       shadow = amdgpu_bo_shadowed(entry->bo);
>>       if (shadow) {
>> +        vm = shadow->vm_bo->vm;
>> +
>> +        mutex_lock(&vm->tlb_flush_lock);
>> +        if (vm->tlb_fence_last)
>> +            amdgpu_vm_attach_tlb_fence(shadow, vm->tlb_fence_last);
>> +        mutex_unlock(&vm->tlb_flush_lock);
>> +
>>           ttm_bo_set_bulk_move(&shadow->tbo, NULL);
>>           amdgpu_bo_unref(&shadow);
>>       }
>> +
>> +    vm = entry->vm;
>> +    mutex_lock(&vm->tlb_flush_lock);
>> +    if (vm->tlb_fence_last)
>> +        amdgpu_vm_attach_tlb_fence(entry->bo, vm->tlb_fence_last);
>> +    mutex_unlock(&vm->tlb_flush_lock);
>> +
>
> That approach doesn't make sense. Instead add the freed PT/PDs to a 
> linked list in the parameters structure and only really free them 
> after adding the fence to the root PD.

Sure, I will do those changes.

Just for the curiosity, why wouldn't this approach work ? Wouldn't this 
delay the actual freeing of buffers TTM until the fence signal ?

- Shashank

>
>
>> ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>>         spin_lock(&entry->vm->status_lock);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> index 569681badd7c..54ec81d30034 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> @@ -31,6 +31,7 @@
>>   struct amdgpu_tlb_fence {
>>       struct dma_fence    base;
>>       struct amdgpu_device    *adev;
>> +    struct amdgpu_vm    *vm;
>
> Big NAK to that. The VM might not live long enough to see the end of 
> the TLB flush.
>
> Regards,
> Christian.
>
>>       struct dma_fence    *dependency;
>>       struct work_struct    work;
>>       spinlock_t        lock;
>> @@ -51,6 +52,7 @@ static const char 
>> *amdgpu_tlb_fence_get_timeline_name(struct dma_fence *f)
>>   static void amdgpu_tlb_fence_work(struct work_struct *work)
>>   {
>>       struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), work);
>> +    struct amdgpu_vm *vm = f->vm;
>>       int r;
>>         r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 2, 
>> true, 0);
>> @@ -62,6 +64,10 @@ static void amdgpu_tlb_fence_work(struct 
>> work_struct *work)
>>         dma_fence_signal(&f->base);
>>       dma_fence_put(&f->base);
>> +
>> +    mutex_lock(&vm->tlb_flush_lock);
>> +    vm->tlb_fence_last = NULL;
>> +    mutex_unlock(&vm->tlb_flush_lock);
>>   }
>>     static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
>> @@ -92,6 +98,7 @@ void amdgpu_vm_tlb_fence_create(struct 
>> amdgpu_device *adev, struct amdgpu_vm *vm
>>       f->adev = adev;
>>       f->dependency = *fence;
>>       f->pasid = vm->pasid;
>> +    f->vm = vm;
>>       INIT_WORK(&f->work, amdgpu_tlb_fence_work);
>>       spin_lock_init(&f->lock);
>>   @@ -99,8 +106,10 @@ void amdgpu_vm_tlb_fence_create(struct 
>> amdgpu_device *adev, struct amdgpu_vm *vm
>>                  vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
>>         /* TODO: We probably need a separate wq here */
>> -    dma_fence_get(&f->base);
>> -    schedule_work(&f->work);
>> +    mutex_lock(&vm->tlb_flush_lock);
>> +    vm->tlb_fence_last = dma_fence_get(&f->base);
>> +    mutex_unlock(&vm->tlb_flush_lock);
>>   +    schedule_work(&f->work);
>>       *fence = &f->base;
>>   }
>
