Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A13C433EF
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Apr 2022 15:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 503F410EB1E;
	Sun,  3 Apr 2022 15:09:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F66710EB1E
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Apr 2022 15:09:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhQd3AOfYKbm8zm3gKRDwPKeeVm2V9Jqs0J55UcDINkB8XYc5q8q88LXdGFAsosnavn38eFKIseJ6hDTDqqSUqSX+Pb8/qYbMQdiI5oFPorVDT89P6WmxqQtiZ+eScSCdd6+N1aMMBAcE5ue5rBSHA9C/WsNBiRjSrxUXM7RMTU7UkO0mpUfrx2e6nXN6vpb6KWumjmbOK+QMchZOmKITeEYp0ex69A1L90ZEHbGnoTNuaJQJusZINKXXYST+YrhvTZa3bQI5KPlGCFF5Szn9ik2jdCDhCibwNqHnn+Ee5NYgW+5ORo0bgREYndmyTmEP5e+L0SGLXxorhya+9h7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDZONx2m/+PthwKdcnZ+5oU9A36g749MgcWDByvH3Do=;
 b=TKAmGAkDYQTuyeh0c099zCtdJzuUcpjks/OBEF5pVbEbSsRqNB9sYq6csGI7pml6pIeDRIqMgWHHKoH20CbDU+GcCL7QUxhCk8q9RGQIWsc2JfWcaHwL+7h0LAyyDyHEfGpyvUi79a9UdHcfqngSadKJHFdkToopgblFaIBnLHt4kCuC1pfX/mgi7klMANI4z098MJzvl/E/j8hqFUzJZZGuak9z01rFe3YXo2FuggoYQuz9swF5kpsLjOZDdCrPsiHVXWQXdTaBivCONTQoQaOSFnnuUExl8YIvCM7hs1W4HaVsNuNUSEackKbCsHe5Fhrg/y6M9Qfjyeo8OOajWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDZONx2m/+PthwKdcnZ+5oU9A36g749MgcWDByvH3Do=;
 b=gN0jxTQs2tujWfR+JoDCw+D72NG9M0JxE3McFK0Vk9MJLQmJZTBaHYZX50rn9KlB+2IkN4/Aksadnsrvwu+2FPa83J+rSJeycxYLK7a4K57DHI+1BblgLZPwbgsUseiuMC41PncYxz5TImlgR+Rzdz/yFqnbZRIup46lJMKUWhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM5PR12MB1340.namprd12.prod.outlook.com (2603:10b6:3:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Sun, 3 Apr
 2022 15:09:30 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5123.031; Sun, 3 Apr 2022
 15:09:29 +0000
Message-ID: <506759c5-3cb9-7110-d81e-52ea19b08d79@amd.com>
Date: Sun, 3 Apr 2022 17:09:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: fix TLB flushing during eviction
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 philip yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org,
 Philip.Yang@amd.com
References: <20220330090032.16218-1-christian.koenig@amd.com>
 <d1191314-478d-cacd-76b3-14a39157231c@amd.com>
 <e957191b-789d-af36-6951-049f038bc47c@gmail.com>
 <03623d90-5e39-a2fb-1068-db15c592f9f9@amd.com>
 <c561a97f-2d72-e50b-2e86-e52c605247a5@gmail.com>
 <b968acc1-53d7-1562-30f9-20f80fbd83ea@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <b968acc1-53d7-1562-30f9-20f80fbd83ea@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR07CA0003.eurprd07.prod.outlook.com
 (2603:10a6:20b:451::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 416801a7-47be-4e18-b418-08da1583f372
X-MS-TrafficTypeDiagnostic: DM5PR12MB1340:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB134068EEE34826E4BA390B4A83E29@DM5PR12MB1340.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3khOEflYklQhroSmPkSacCSAQCq8N2vEDxCjsvQ3v8Hjrd3ib/TmkGXNAeZEarYBrsj0U/mJNP9voGnowmeAmbwDXmqknkPohAoDGcmxIK1UPpHFXME9MiP8x4Q10CmfKoBgm0JFWwxMQ9DYfZIAAZuvrGlP9dw3z95Od9EJdLbUbgBw6aeoXBogWhl7hNzNehqssy0EvfBgNwlf8Nfq/42UvWK8lIDHlGohF6LDtCO99jTbUsz4KpL0bIiyzC00td8+vfb9+0TcyYsCbsFrZzaWtV5zNUqM8yisKEpp2CkHGpGfp3RFtNgb3BHFb/VT3RqxVfR0Ski+LwAXkdgou3IzKIK0fL+CK91lBK57DLzxm/scfCAroLLsDqqApHCdKTQVDfburxIov4H5wKgdyoE1wQvh466YbZcVNEm1QLAjOf5zDqrqtV1uhSwsXzEk/xavJnPb2w4RuA/NgHvFL8F68uQtjqCI9iuebO4NJv3o5lv4WG1/JhE2sORIBT49Z9oAbVTQMudQw80jzS/8KWTkDcUKXtvkv8F1rauaO565WOcnIsZYIOGQDwsR3kucRaXa3MIySSTCT71csV17nvF+3JPclJiaAH5A3+VWu8gpphN5oLQWLH0nXsQYc7Bbf3zKjw3Q2PsM8AxygUk+z0qZpvt0hSz9HwZ/cjfd9rdbBJ1IDet5T6MYGIY1zNA8u+9H7eVwGzl8V06ANjhqxRikjKeX1YuO8GPBTq3lGBA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(6506007)(6666004)(31696002)(30864003)(8936002)(6512007)(2906002)(38100700002)(53546011)(508600001)(86362001)(110136005)(316002)(6636002)(66574015)(83380400001)(31686004)(186003)(66946007)(8676002)(6486002)(36756003)(66476007)(66556008)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1pFN0ErcTFwTjlYTURlUURTaEYvYS9RSmIwcTZURWlKUVNuMjhsdnVHWFo5?=
 =?utf-8?B?S2VadlcxenJtQ1pVc3pRZk82RDF5RlhDd21hdkVqTEpWTDV0VzNveVZUVmo4?=
 =?utf-8?B?d05sWTRRV0ZKaFR5djJYNXc3ZkY2K05QVkp4UDc2ZkNWRHUxaFJUVkxIMExV?=
 =?utf-8?B?U0UwOTFSbGlIQ0xHMjdQNTVBdEp5MW0rNGc5bkdIck5XZWZtbzNnK3c5NVli?=
 =?utf-8?B?REJvQlRyY05IK01JSGJ6SXJuaXBUeVc3T2ZtVGRScE1Tai9NcE9lSHRJMDlh?=
 =?utf-8?B?SGlYUVB1QkZiNzhNOU1mWWNNSy94ZDRxMnV5dkFnR255WCsyM2YxZ3hwVVFS?=
 =?utf-8?B?dzNQaVlMenF2WXRIamJwUWJ4ZnAvclBCS1RtQWJwNTI5NVB3Q3JONWFCNWxQ?=
 =?utf-8?B?RXFjSTVKYU1JaXpFTWpuc2R1RDlMUWRhRDZWazR2RVdQcUpOWnpKNFRHckVl?=
 =?utf-8?B?cHVOTWYvTTY4NU55Um1kK0ZjQ1FTRFBqU29NVEJMVHI1TU9lT3NFZDkvR2R4?=
 =?utf-8?B?bmwzdGR1alRYM1hCYzNmMHJGSHZCVFNHZmx5emdPNzlYdW81alZLTExVMGlK?=
 =?utf-8?B?Q3VqOHJqVU83QmVYdVNJTWVyYjhxS2c4OHNwcVM5d1dXL05SdVVhdUEzT09u?=
 =?utf-8?B?SUFVSS9GNTJrRVFpWk95NXFpOE83eUJUd203dmdHcUM4KzhrNTZFQnhuK21O?=
 =?utf-8?B?SjhNKzNBRmlXdlRMNlp5czlXMm0wNjRNc3JHNzlzQWhoOEVzTWhCVTdXRnlk?=
 =?utf-8?B?QUk2eEJPUDl5R2lmYk11czdzZ0h1bkZPcXRHakh6Umg0c3RYdW5ZalNhLzlV?=
 =?utf-8?B?SGZjVFpnVXJ4SldReEtVRlZRQWJMMHcyeEZTY3p5N0c5TTdSWi9ZdWJ5NXNV?=
 =?utf-8?B?bzJ2RGIyZ0pzMm5DWGppZzlWaEE4cUxHZkpIbCtOV0l6Si9VMFYvUjAyRUZQ?=
 =?utf-8?B?eTNxYVdZNUlRUFpqVjNjNTk4bWk0dm1aMlRhWmpoZjExaUlRTlZPeWxYcVN4?=
 =?utf-8?B?KzFBeDlnbXRaTnJmaWx1Sjd4TEpoaDNIWDFXY2RlY1J6eXlYaFBsbWFjcTVs?=
 =?utf-8?B?Rjg1K2dkVnZPQnVlUU1vT09IMlRuazFvZE0vWU9TNTI0azJiQmpOOExwTy9x?=
 =?utf-8?B?Yys5bEpVeE54VzZmSmFwajlrRUYwT1BWaFlYVGMwQ0FBMWJwWi9jMnMvM0dI?=
 =?utf-8?B?TnJlblo3TU1YM2FiVVQ4TWdMYlNvdmJDTWI0aHNZL2dXeDYzaDd4cFRkZW1N?=
 =?utf-8?B?TTM1MTFyUTFyMWxubzN5ZFc3ZlZ1UVRQcjVZUHJqeVE5eUJjZHNzMFdMMmc3?=
 =?utf-8?B?K1F1WEcwTlAxNnZMNmhodlppbFRJYk53Wjl1M1RISmx2WFlvTUJMODEyY0Ni?=
 =?utf-8?B?bkZYVXZuLzQ0enJiS1Q0UDRPaEtNMVpXQjNGZko0c3BNdVlYMmtxQnV6QzJv?=
 =?utf-8?B?UlN3SUpSOHhSMHZwU3phL09pVktpRmNaNVZ0M0pDeHptbE12QTF2Q3RlOE90?=
 =?utf-8?B?S1p2S2J0dytON3pMME5xU1E0dVdydVlZNHFtVnZDbnRNL0pyTE5zYnZ5a1Jo?=
 =?utf-8?B?NlJxZUU2NjNKYkJOQml1YXdGaUMrREFDbkpocmd2K0lWMnFwYWxWeXJadWxy?=
 =?utf-8?B?Uk05YlBoUy9maFh1RWsvZmd5bmRjb0FDS0xtcEdZS1BORHhRdE9VMERVNUlQ?=
 =?utf-8?B?b3JiYVpBUzhPVThrOEpXS2NHaFB2NTRYbEsyQ3BwR0NRamhmRnoyWnpOTTJC?=
 =?utf-8?B?T243aXdWbjd6T2JYOENvdFBXRlI2MzFvR3o3K2tUK2hMcTNQNW9UUUZPVzI5?=
 =?utf-8?B?NDJUSnhwMy9RY2IvKzM4UWVYUUpIQUF0Y0JQSWZuSHlxcDRiK1BHNG1xYjNr?=
 =?utf-8?B?N005OHJUay9XNmVHTytZKzdwVzkraEQ1RkFCTG5CdUtYSmVSeUdObCtCcGVt?=
 =?utf-8?B?cDEzZnBxdUpOc2l5RHNmaWxtVUVpUXpEdFNNN3pQZFZKbVFVREU1enMxb2F5?=
 =?utf-8?B?cDRtY1l1VEU4K2JPb1J2SHlpanlzNnR5THljQy92U0hHTGVHa3pyaS9YSzY5?=
 =?utf-8?B?S09ZSU9PRCttNnF1akNLRkw5V1NKUHBhT3JIRzNmT0RrTFNhWTBoR2JCNkUy?=
 =?utf-8?B?Szl2VmJIOHRkM2FBTXpUaitNWVUxaVJ5eFNXclhFdEYyZ3N0QXl6WEovejNF?=
 =?utf-8?B?bHlZbGV5NEJxdzBkZWYxY3dQTldVd1IxRzllcW1Ga1pqenFhY1QzRnlOZ1l1?=
 =?utf-8?B?aVdHTnBuVlZWMzI3WG81cGRyYUhEaDlZcWV2eWJKc3h5WlNGWXRCREYrODdM?=
 =?utf-8?B?ZU05M2lvNnNwLythdUxja2NLMHpHd1lDVkpSTUgwYzVOWmJpNVZUa3ViUVBx?=
 =?utf-8?Q?bY5etMl8nTgavDASKF4HH7RSOllhlKNMuByE7KipS0wjY?=
X-MS-Exchange-AntiSpam-MessageData-1: YImBpLhFAHNSHQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416801a7-47be-4e18-b418-08da1583f372
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2022 15:09:29.7657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pxzrcs/kgDSwJFVQgANQvF73J2BU5tey1NjzgNCIgPgCozej0zq+Ih6a0R5EwolZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1340
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

Am 01.04.22 um 21:47 schrieb Felix Kuehling:
>
> On 2022-04-01 04:24, Christian König wrote:
>> Am 31.03.22 um 16:37 schrieb Felix Kuehling:
>>> Am 2022-03-31 um 02:27 schrieb Christian König:
>>>> Am 30.03.22 um 22:51 schrieb philip yang:
>>>>>
>>>>>
>>>>> On 2022-03-30 05:00, Christian König wrote:
>>>>>> Testing the valid bit is not enough to figure out if we
>>>>>> need to invalidate the TLB or not.
>>>>>>
>>>>>> During eviction it is quite likely that we move a BO from VRAM to 
>>>>>> GTT and
>>>>>> update the page tables immediately to the new GTT address.
>>>>>>
>>>>>> Rework the whole function to get all the necessary parameters 
>>>>>> directly as
>>>>>> value.
>>>>>>
>>>>>> Signed-off-by: Christian König<christian.koenig@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 63 
>>>>>> ++++++++++++++------------
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 15 +++---
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 18 ++++----
>>>>>>   3 files changed, 48 insertions(+), 48 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> index 9992a7311387..1cac90ee3318 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> @@ -793,18 +793,19 @@ static void amdgpu_vm_tlb_seq_cb(struct 
>>>>>> dma_fence *fence,
>>>>>>   }
>>>>>>     /**
>>>>>> - * amdgpu_vm_bo_update_mapping - update a mapping in the vm page 
>>>>>> table
>>>>>> + * amdgpu_vm_update_range - update a range in the vm page table
>>>>>>    *
>>>>>> - * @adev: amdgpu_device pointer of the VM
>>>>>> - * @bo_adev: amdgpu_device pointer of the mapped BO
>>>>>> - * @vm: requested vm
>>>>>> + * @adev: amdgpu_device pointer to use for commands
>>>>>> + * @vm: the VM to update the range
>>>>>>    * @immediate: immediate submission in a page fault
>>>>>>    * @unlocked: unlocked invalidation during MM callback
>>>>>> + * @flush_tlb: trigger tlb invalidation after update completed
>>>>>>    * @resv: fences we need to sync to
>>>>>>    * @start: start of mapped range
>>>>>>    * @last: last mapped entry
>>>>>>    * @flags: flags for the entries
>>>>>>    * @offset: offset into nodes and pages_addr
>>>>>> + * @vram_base: base for vram mappings
>>>>>>    * @res: ttm_resource to map
>>>>>>    * @pages_addr: DMA addresses to use for mapping
>>>>>>    * @fence: optional resulting fence
>>>>>> @@ -812,17 +813,14 @@ static void amdgpu_vm_tlb_seq_cb(struct 
>>>>>> dma_fence *fence,
>>>>>>    * Fill in the page table entries between @start and @last.
>>>>>>    *
>>>>>>    * Returns:
>>>>>> - * 0 for success, -EINVAL for failure.
>>>>>> + * 0 for success, negative erro code for failure.
>>>>>>    */
>>>>>> -int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>>>>>> -                struct amdgpu_device *bo_adev,
>>>>>> -                struct amdgpu_vm *vm, bool immediate,
>>>>>> -                bool unlocked, struct dma_resv *resv,
>>>>>> -                uint64_t start, uint64_t last,
>>>>>> -                uint64_t flags, uint64_t offset,
>>>>>> -                struct ttm_resource *res,
>>>>>> -                dma_addr_t *pages_addr,
>>>>>> -                struct dma_fence **fence)
>>>>>> +int amdgpu_vm_update_range(struct amdgpu_device *adev, struct 
>>>>>> amdgpu_vm *vm,
>>>>>> +               bool immediate, bool unlocked, bool flush_tlb,
>>>>>> +               struct dma_resv *resv, uint64_t start, uint64_t 
>>>>>> last,
>>>>>> +               uint64_t flags, uint64_t offset, uint64_t vram_base,
>>>>>> +               struct ttm_resource *res, dma_addr_t *pages_addr,
>>>>>> +               struct dma_fence **fence)
>>>>>>   {
>>>>>>       struct amdgpu_vm_update_params params;
>>>>>>       struct amdgpu_vm_tlb_seq_cb *tlb_cb;
>>>>>> @@ -910,8 +908,7 @@ int amdgpu_vm_bo_update_mapping(struct 
>>>>>> amdgpu_device *adev,
>>>>>>               }
>>>>>>             } else if (flags & (AMDGPU_PTE_VALID | 
>>>>>> AMDGPU_PTE_PRT)) {
>>>>>> -            addr = bo_adev->vm_manager.vram_base_offset +
>>>>>> -                cursor.start;
>>>>>> +            addr = vram_base + cursor.start;
>>>>>>           } else {
>>>>>>               addr = 0;
>>>>>>           }
>>>>>> @@ -927,7 +924,7 @@ int amdgpu_vm_bo_update_mapping(struct 
>>>>>> amdgpu_device *adev,
>>>>>>         r = vm->update_funcs->commit(&params, fence);
>>>>>>   -    if (!(flags & AMDGPU_PTE_VALID) || params.table_freed) {
>>>>>> +    if (flush_tlb || params.table_freed) {
>>>>>
>>>>> All change look good to me, but when I look at previous changes 
>>>>> again, kfd_ioctl_map_memory_to_gpu is not correct now, as this 
>>>>> should flush TLB if (!kfd_flush_tlb_after_unmap(dev)).
>>>>>
>>>>
>>>> That was intentionally dropped as Felix said it wouldn't be 
>>>> necessary any more with the TLB flush rework.
>>>>
>>>> Is that really causing any trouble?
>>>
>>> I discussed it with Philip offline. The TLB flushing in 
>>> kfd_ioctl_map_memory_to_gpu is still there, but it is no longer 
>>> conditional on !kfd_flush_tlb_after_unmap. Instead kfd_flush_tlb 
>>> checks the sequence number to find out if the flush is needed 
>>> (presumably because we didn't flush after unmap).
>>>
>>> There is one case on Vega20+XGMI where PTEs get inadvertently cached 
>>> in L2 texture cache.
>>
>> Ah, that one. Yeah I do remember that issue.
>>
>>> In that case, we probably need to flush more frequently because a 
>>> cache line in L2 may contain stale invalid PTEs. So kfd_flush_tlb 
>>> would need to ignore the sequence number and heavy-weight flush TLB 
>>> unconditionally in this case.
>>
>> Ok, but I think that is outside of the scope of the VM handling then. 
>> Or should we somehow handle that in the VM code as well?
>
> I think it would make sense to apply the workaround in the VM code 
> now. You'd need to do this on all mappings on Vega20+XGMI. It doesn't 
> matter whether the mapping itself involves XGMI. AIUI, the incorrect 
> caching happens for all mappings when the XGMI bridge is physically 
> present.

Good point! Looks like Philip already send a patch for this, going to 
review that one then.

Thanks,
Christian.

>
>
>>
>> I mean incrementing the sequence when the involved BO is mapped 
>> through XGMI is trivial. I just can't easily signal that we need a 
>> heavy-weight flush.
>
> There is already code in gmc_v9_0.c to force heavy-weight flushing, 
> and doing an double flush to make sure the TLB is flushed after the L2 
> texture cache. grep -A4 "Vega20+XGMI" gmc_v9_0.c for details.
>
> Regards,
>   Felix
>
>
>>
>> Thanks,
>> Christian.
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>>
>>>> Christian.
>>>>
>>>>> To fix it, seems we need beow change, then pass flush_tlb flag via 
>>>>> kfd_ioctl_map_memory_to_gpu -> map_bo_to_gpuvm -> update_gpuvm_pte 
>>>>> -> amdgpu_vm_bo_update
>>>>>
>>>>> -int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct 
>>>>> amdgpu_bo_va *bo_va,
>>>>>             bool clear)
>>>>>
>>>>> -    bool flush_tlb = clear;
>>>>>
>>>>> +int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct 
>>>>> amdgpu_bo_va *bo_va,
>>>>>             bool clear, bool flush_tlb)
>>>>>
>>>>> + flush_tlb |= clear;
>>>>>
>>>>> Regards,
>>>>>
>>>>> Philip
>>>>>
>>>>>>           tlb_cb->vm = vm;
>>>>>>           if (!fence || !*fence ||
>>>>>>               dma_fence_add_callback(*fence, &tlb_cb->cb,
>>>>>> @@ -1010,9 +1007,10 @@ int amdgpu_vm_bo_update(struct 
>>>>>> amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>>>>>>       dma_addr_t *pages_addr = NULL;
>>>>>>       struct ttm_resource *mem;
>>>>>>       struct dma_fence **last_update;
>>>>>> +    bool flush_tlb = clear;
>>>>>>       struct dma_resv *resv;
>>>>>> +    uint64_t vram_base;
>>>>>>       uint64_t flags;
>>>>>> -    struct amdgpu_device *bo_adev = adev;
>>>>>>       int r;
>>>>>>         if (clear || !bo) {
>>>>>> @@ -1037,14 +1035,18 @@ int amdgpu_vm_bo_update(struct 
>>>>>> amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>>>>>>       }
>>>>>>         if (bo) {
>>>>>> +        struct amdgpu_device *bo_adev = adev;
>>>>>> +
>>>>>>           flags = amdgpu_ttm_tt_pte_flags(adev, bo->tbo.ttm, mem);
>>>>>>             if (amdgpu_bo_encrypted(bo))
>>>>>>               flags |= AMDGPU_PTE_TMZ;
>>>>>>             bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>>>>> +        vram_base = bo_adev->vm_manager.vram_base_offset;
>>>>>>       } else {
>>>>>>           flags = 0x0;
>>>>>> +        vram_base = 0;
>>>>>>       }
>>>>>>         if (clear || (bo && bo->tbo.base.resv ==
>>>>>> @@ -1054,7 +1056,7 @@ int amdgpu_vm_bo_update(struct 
>>>>>> amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>>>>>>           last_update = &bo_va->last_pt_update;
>>>>>>         if (!clear && bo_va->base.moved) {
>>>>>> -        bo_va->base.moved = false;
>>>>>> +        flush_tlb = true;
>>>>>>           list_splice_init(&bo_va->valids, &bo_va->invalids);
>>>>>>         } else if (bo_va->cleared != clear) {
>>>>>> @@ -1077,11 +1079,11 @@ int amdgpu_vm_bo_update(struct 
>>>>>> amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>>>>>>             trace_amdgpu_vm_bo_update(mapping);
>>>>>>   -        r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, 
>>>>>> false, false,
>>>>>> -                        resv, mapping->start,
>>>>>> -                        mapping->last, update_flags,
>>>>>> -                        mapping->offset, mem,
>>>>>> -                        pages_addr, last_update);
>>>>>> +        r = amdgpu_vm_update_range(adev, vm, false, false, 
>>>>>> flush_tlb,
>>>>>> +                       resv, mapping->start, mapping->last,
>>>>>> +                       update_flags, mapping->offset,
>>>>>> +                       vram_base, mem, pages_addr,
>>>>>> +                       last_update);
>>>>>>           if (r)
>>>>>>               return r;
>>>>>>       }
>>>>>> @@ -1104,6 +1106,7 @@ int amdgpu_vm_bo_update(struct 
>>>>>> amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>>>>>>         list_splice_init(&bo_va->invalids, &bo_va->valids);
>>>>>>       bo_va->cleared = clear;
>>>>>> +    bo_va->base.moved = false;
>>>>>>         if (trace_amdgpu_vm_bo_mapping_enabled()) {
>>>>>>           list_for_each_entry(mapping, &bo_va->valids, list)
>>>>>> @@ -1272,10 +1275,10 @@ int amdgpu_vm_clear_freed(struct 
>>>>>> amdgpu_device *adev,
>>>>>>               mapping->start < AMDGPU_GMC_HOLE_START)
>>>>>>               init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
>>>>>>   -        r = amdgpu_vm_bo_update_mapping(adev, adev, vm, false, 
>>>>>> false,
>>>>>> -                        resv, mapping->start,
>>>>>> -                        mapping->last, init_pte_value,
>>>>>> -                        0, NULL, NULL, &f);
>>>>>> +        r = amdgpu_vm_update_range(adev, vm, false, false, true, 
>>>>>> resv,
>>>>>> +                       mapping->start, mapping->last,
>>>>>> +                       init_pte_value, 0, 0, NULL, NULL,
>>>>>> +                       &f);
>>>>>>           amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>>>>>           if (r) {
>>>>>>               dma_fence_put(f);
>>>>>> @@ -2519,8 +2522,8 @@ bool amdgpu_vm_handle_fault(struct 
>>>>>> amdgpu_device *adev, u32 pasid,
>>>>>>           goto error_unlock;
>>>>>>       }
>>>>>>   -    r = amdgpu_vm_bo_update_mapping(adev, adev, vm, true, 
>>>>>> false, NULL, addr,
>>>>>> -                    addr, flags, value, NULL, NULL, NULL);
>>>>>> +    r = amdgpu_vm_update_range(adev, vm, true, false, false, 
>>>>>> NULL, addr,
>>>>>> +                   addr, flags, value, 0, NULL, NULL, NULL);
>>>>>>       if (r)
>>>>>>           goto error_unlock;
>>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>> index 6b7682fe84f8..1a814fbffff8 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>> @@ -402,15 +402,12 @@ int amdgpu_vm_handle_moved(struct 
>>>>>> amdgpu_device *adev,
>>>>>>                  struct amdgpu_vm *vm);
>>>>>>   void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>>>>>>                   struct amdgpu_vm *vm, struct amdgpu_bo *bo);
>>>>>> -int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>>>>>> -                struct amdgpu_device *bo_adev,
>>>>>> -                struct amdgpu_vm *vm, bool immediate,
>>>>>> -                bool unlocked, struct dma_resv *resv,
>>>>>> -                uint64_t start, uint64_t last,
>>>>>> -                uint64_t flags, uint64_t offset,
>>>>>> -                struct ttm_resource *res,
>>>>>> -                dma_addr_t *pages_addr,
>>>>>> -                struct dma_fence **fence);
>>>>>> +int amdgpu_vm_update_range(struct amdgpu_device *adev, struct 
>>>>>> amdgpu_vm *vm,
>>>>>> +               bool immediate, bool unlocked, bool flush_tlb,
>>>>>> +               struct dma_resv *resv, uint64_t start, uint64_t 
>>>>>> last,
>>>>>> +               uint64_t flags, uint64_t offset, uint64_t vram_base,
>>>>>> +               struct ttm_resource *res, dma_addr_t *pages_addr,
>>>>>> +               struct dma_fence **fence);
>>>>>>   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>>>>>>               struct amdgpu_bo_va *bo_va,
>>>>>>               bool clear);
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>>> index 27533f6057e0..907b02045824 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>>> @@ -1188,9 +1188,9 @@ svm_range_unmap_from_gpu(struct 
>>>>>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>>>         pr_debug("[0x%llx 0x%llx]\n", start, last);
>>>>>>   -    return amdgpu_vm_bo_update_mapping(adev, adev, vm, false, 
>>>>>> true, NULL,
>>>>>> -                       start, last, init_pte_value, 0,
>>>>>> -                       NULL, NULL, fence);
>>>>>> +    return amdgpu_vm_update_range(adev, vm, false, true, true, 
>>>>>> NULL, start,
>>>>>> +                      last, init_pte_value, 0, 0, NULL, NULL,
>>>>>> +                      fence);
>>>>>>   }
>>>>>>     static int
>>>>>> @@ -1277,12 +1277,12 @@ svm_range_map_to_gpu(struct 
>>>>>> kfd_process_device *pdd, struct svm_range *prange,
>>>>>>                (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
>>>>>>                pte_flags);
>>>>>>   -        r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, 
>>>>>> false, false,
>>>>>> -                        NULL, last_start,
>>>>>> -                        prange->start + i, pte_flags,
>>>>>> -                        last_start - prange->start,
>>>>>> -                        NULL, dma_addr,
>>>>>> -                        &vm->last_update);
>>>>>> +        r = amdgpu_vm_update_range(adev, vm, false, false, 
>>>>>> false, NULL,
>>>>>> +                       last_start, prange->start + i,
>>>>>> +                       pte_flags,
>>>>>> +                       last_start - prange->start,
>>>>>> + bo_adev->vm_manager.vram_base_offset,
>>>>>> +                       NULL, dma_addr, &vm->last_update);
>>>>>>             for (j = last_start - prange->start; j <= i; j++)
>>>>>>               dma_addr[j] |= last_domain;
>>>>
>>

