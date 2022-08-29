Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C16ECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 16:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 821F410E186;
	Mon, 29 Aug 2022 16:07:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E535610E186
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 16:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+K8fO+G3O673cQynGO5qUYcXgmkwzPAsGsJg5XIKFUjxj5LcX6ZQGgnsw300OwvR6Ja2Ri0IfnmTyNrF/JqWt9jV7kwGgeTqfOQ8Avv7LSj2PGMKcquYPocsDFVjRcnGfqcBxNbcetLn1wWJt4m8xBrGV6appuYXD1IY1Q4Q1kPuklU0d8Bf5NJe/M+ew5spzKALQ0cnv/GeVuB0BQnposeYOJN8f/AM57hxWH/nZM/IQjzgX+GcfkfTYMxOIxkmXD3ckC44jy0sTrzRiA66OJV+32DkTTk0r0WZ8vG0sHtGL8lTS/tTRh4kc3fpCNwRRcu2kpB/fQ+HWupLkn4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7xJMErFPC3xmz4CJsUikb+pBeHiyJI0wJZZfMYDX58=;
 b=nVkU2Vb40HxFXyqJxK9vKwDypYchn2u/c+K7dnj9wmLNkVwm6MbFGjF08kAo+aZ8P7PjJOIO+dfGCkd29MrILh+k00fbrxqyr8kW141eC7nqp7GuYcLkQHQ5Hdj7ClFKGQ0jNt5DkgLJdwpuJsH9JDwibvO3yTW0jL4EcClsX2q/Pkl9qfbyA12KaOiAM3lU/8ieEKlwRbsr0KsP0+kOOAgZBKsdJvsu/ZPoILdpUHDgXg3nadgopfEssGip8/Evw9yMsF0i3NulF7h3bXOD0gBdselk5hIkjE1vcYMAzWe5vR/rBUuPRfjP/vb37X3XGkSDeZIZmY2SRRJEdStiWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7xJMErFPC3xmz4CJsUikb+pBeHiyJI0wJZZfMYDX58=;
 b=X02updPH1sfMx0DiYgyEdyIt896Kymk4Eca5lcLZ4DQDNd6Os1bRL53b9ShWv74fZSdLn0metU+lR/wHrRwESxbMzvAkJw0OccEwKkp7Oq1kGV0bgrtgsc/dxlh7WtUzG22lFK1PvSze6wdxLT7chighNSjJcCRraoODw9Gq9nw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB3326.namprd12.prod.outlook.com (2603:10b6:208:cb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 16:07:06 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 16:07:06 +0000
Message-ID: <09f808fb-908c-477e-5470-cdd75b539273@amd.com>
Date: Mon, 29 Aug 2022 12:07:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: Set pte_flags for actual BO location
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220826231654.335169-1-Felix.Kuehling@amd.com>
 <2707c040-2b99-8c48-237d-45dee65e8833@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <2707c040-2b99-8c48-237d-45dee65e8833@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0342.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 324450da-4c77-4b9f-b2ea-08da89d884df
X-MS-TrafficTypeDiagnostic: MN2PR12MB3326:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vl3v48hcKYcn3I57+1LPX/N4jUUlPvkWibnvO1aKDSo+IUkQrkAMQDjPtps6F3s0MNAK67sWx9rvwtVMm0FmqXWdlCw15j7//NAi19sVD1+DND6uUFYTlx1VFVmv58fQAdNjadNCitnvFpmbX6mK5WzcJjnvEwcTMIqpMGCxPOKHdKg7zVIXHcwrxDTihBt4WV7UH2iQZFLbxZZK7uKQ3KYr4tIrjFQ7YvsYQDMo7aOs2AW+dfvcLLGj1/RLSWmgWU8EPVZjZH/OdreXphQf6m2gf5eCA6dZISb6vdjXFfzEqKYTlH7vqcPzbfxYxH4OdmVHnyhdOTetJzVbVNo33bkxasw/KRm4xtkmYP9e2+0EexVJzka5YtwmBBEKLNdIcro/9xlZmYFfAm8eVs9YfoFVH/fIbBaN3R1YFaEaaHdIKtw2G/6s8U2tF9KcC3hZiayZBy6uaN4ra9wwBZClRZeIHdvuaKuACXIV9vJ6Zley2s4POCyF/L8MLCI/LqpfQEIetFQB7krrGl2mTsTANHgYvNfVIemkoYJQ3FGDHskQQuLzkkDvtJ0Kl58xEZvgAy810GFBn+eApI6Z4MxTruVC/oVHJw6BwFVXifw/quYtokEvFBRRXqlWoQbeAwA2Lr59j6KxhKpHd2xKfll/8Lyf+FbBz00l+yRNmWFQKS1YDVcgvel25TA3x5mH5GTo9CCyelb0879SmxXciCvmlZDTGxCTefv5i7ogaj9hvDoHrrngVUtWucClDUSAPxp8oBmbiBNB4tvepia7ON/5gTgMcLgJAVI0DLdqmQSWB5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(66574015)(186003)(2616005)(316002)(31686004)(36756003)(44832011)(2906002)(6506007)(83380400001)(6512007)(26005)(86362001)(31696002)(6486002)(8936002)(5660300002)(41300700001)(478600001)(38100700002)(66476007)(8676002)(66946007)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDIrOXdsWE5EODRnYlZRTzVHMjhTSldTYkMzMWNIZGRCU2NmQzhISmpjUk5R?=
 =?utf-8?B?MlcxOXNNRUVsYjRpZDBhN3grbFg4aTRNU004MlNETUEvcXRxT3dicWhzQTl2?=
 =?utf-8?B?amRGVHZ4M0ljYjVYMWplMkVhOExjV0l0OXdNSFd2Qkl6YVZVcVpHVTgzaUFu?=
 =?utf-8?B?aU5rVi9IL0Voc3hPWkhzcmZYVlRKTWVOenBKdEFQbG53Q0RuMDFpbGxJS0Vl?=
 =?utf-8?B?eTVVWml5L1VCT2t6Sm4xTGlkc1BkSDA5eEhqWXIvSmlRVGVzS20vdlpPQ2JZ?=
 =?utf-8?B?ck16UzhLU2N5aGlyWm9CZkkvbnhvMzN6YUdmY2dLNlI1aTAzQndrWmwrNHRo?=
 =?utf-8?B?WWVuNWxtMlRldHdNV2JGS1BDTFdIdDlXWWozUDc2ZzBlcDNhQUlwbVNuTnpp?=
 =?utf-8?B?b1NuQTBtb09KYmJxQVZpZHExS1k2NVNpWkxhWkF5NVFWZnBYQzF0R1JwS1FN?=
 =?utf-8?B?aUxyQUUya0g3T0xEdDhCZjI1RS9nVFpkTjF5cG44NEFDR0JGZjlSNDNZaWpG?=
 =?utf-8?B?b0J3aG5mM1J6YnBleGtadElVcXpPZzNwWE1xb040TXV1bjhaMXVmeWU4MHBG?=
 =?utf-8?B?dHdJSHV2UTIxUm9tQ3JGcDB3SDRURGVFcVpQYmdpbW90TVp6cWpTNEdCQ1Zv?=
 =?utf-8?B?RzhSanVuZjdMd3Vob1hxb2lLRUhnZytpQlRMT1VQS0hVeE1WaWJjSTFxWHNI?=
 =?utf-8?B?VVdHT2NiTVBLRTdYUCt4dFFVT1YvQ1cxMFc2c0tyMityZkt5dlcwRnlEb21o?=
 =?utf-8?B?WWNOdHE0eEw0NVA2WGpYc0hHV3VXL1hxRnR4WkdXc3lwUnc2c0JaWnlJTW1x?=
 =?utf-8?B?OVY1K0h0Y2JSa0pVc28rcVowa0Q5L3BGV1dBVy9sNVpkbkRlNStvekt6TFZL?=
 =?utf-8?B?TXFlTmp3YzhZcEZKclAxQzBBMVRzRlY1V2VuRUtLTmdFZUROWmwxVWVxMXJO?=
 =?utf-8?B?RTB3dnhXSDM0SlJXOExFUGRRRXRrQnh4aDQyd2c0eGJrdHlna3MrOGRIMVpD?=
 =?utf-8?B?VFRjOHBsd0FnSHp6RWhWeGhXQ3ppNy94VWw0SmRKNkcwVmhnejdWYjdENjlw?=
 =?utf-8?B?QXdwRDloTWZPeW50MFh4VXlnaWE5MkZkMXpqYTcxR3crQnJwKzcwUTJnalFM?=
 =?utf-8?B?T1FOUkt4NDlrSG9vMWNxODhXeGtQcDBkWU9jYUdzTTR4SFBRSjRScE5QaTdW?=
 =?utf-8?B?RXgwWTdXNmE5TmhERGpFTk8xeWh5ZEl0YjM4YVM1ckNobk9rdjFjd3N5N3gr?=
 =?utf-8?B?WHl1aWZsK0s0Z2ZaNGcyb2cybTZlbFIyNGs5clRWMXN0UElOd0IxUVE3bUdW?=
 =?utf-8?B?VmlkUXZ5cWJmSk0wSjFhcXREcm00Y0Z1WjF3UlJSNWk1eEdlQzJhdHM4ei9h?=
 =?utf-8?B?ODIvTjBvTnFOdTF6ZHZXTzNLUitQUUp0T1BZQjU1Z1VOOXNqZFJHeVBOcnNa?=
 =?utf-8?B?Y0d0TXByL3lkOFZXWlZXZkxxTU9kNG5hemtJeVUyUmhlakJoT3BRcS9ydXp3?=
 =?utf-8?B?bENhYitMelBnSjY5d1Q0YTB6bUtsaTBQYjRqbHJKcHF2ZEYzN1IvTHgva0Rh?=
 =?utf-8?B?NHlLZ3RjT0tJcjNCN0lXTmhuR0VSNVVWaEJFcWNNVjVpbUJzWU1TV25UZ255?=
 =?utf-8?B?SzRUQWU4Ukg1cUlUNCtRZmVlRUdvbkxadjhaNTIrN3daYUJ2M3VZOVFVNjNh?=
 =?utf-8?B?OUZsM3pvaTJLK29OazZHYWR2cnlOL1ZhUm9GYXQ1ZER4VDdYMnpSczdjSVE2?=
 =?utf-8?B?b1k4YmpTa1RCTXNUTVg2cnlYZ2JUbXQwTmlYTGl1akl0dC9MVFdTZTN5eGpx?=
 =?utf-8?B?Zys3WVE1WkZmSTRHRUZPYktsS1FJOUVnTjg3NXFiZGNFdnhtK0VNZ2h6aitz?=
 =?utf-8?B?ZnBlMXJHVndpR3BhdzFGZ2tnUGFMUlNuWmNibDMrU3V5OG1DRzVJWlhQVXJG?=
 =?utf-8?B?VGRyTU5lWUR3RDFHZE9VSHNyMUVTKzRVR0dHOXhPSFR6VkpkMGtlSXlkOTBa?=
 =?utf-8?B?VkJ1Wm1wRGQ4bWs5YW51bmVLOEg5T2dDTUFxSWtZVHN5QWduL3VvdFZMRmFS?=
 =?utf-8?B?T3A5a0MyZWVYQVo1VUhlbWt3cEV2ejlmTmtnMkxIaWM4UVh5aUFhTk9sRGZ1?=
 =?utf-8?Q?Csmt8bcBAUkavd0JyZ6Mj7hkv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324450da-4c77-4b9f-b2ea-08da89d884df
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 16:07:06.3727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51jhI9Zgb4PUmE/7TUYMuez8mgRlRTp2mXrllJOOX9g4qX/vCrTm5RLRT42HYEx2UKHi0r1U2rcD2ji31f5/4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3326
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

Am 2022-08-29 um 11:38 schrieb Christian König:
> Am 27.08.22 um 01:16 schrieb Felix Kuehling:
>> BOs can be in a different location than was intended at allocation time,
>> for example when restoring fails after an eviction or BOs get pinned in
>> system memory. On some GPUs the MTYPE for coherent mappings depends on
>> the actual memory location.
>>
>> Use the actual location to determine the pte_flags every time the page
>> tables are updated.
>
> For a workaround ok, but looks a bit awkward. Basically we need 
> different MTYPE based on the location, right?

Yes. On Aldebaran and Arcturus we need different MTYPEs for fine-grained 
coherence depending on the location.

Regards,
   Felix


>
> Christian.
>
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  9 ++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 19 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  1 +
>>   3 files changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index cbd593f7d553..5dd89f5a032f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -405,6 +405,7 @@ static int vm_update_pds(struct amdgpu_vm *vm, 
>> struct amdgpu_sync *sync)
>>   static uint64_t get_pte_flags(struct amdgpu_device *adev, struct 
>> kgd_mem *mem)
>>   {
>>       struct amdgpu_device *bo_adev = 
>> amdgpu_ttm_adev(mem->bo->tbo.bdev);
>> +    bool is_vram = mem->bo->tbo.resource->mem_type == TTM_PL_VRAM;
>>       bool coherent = mem->alloc_flags & 
>> KFD_IOC_ALLOC_MEM_FLAGS_COHERENT;
>>       bool uncached = mem->alloc_flags & 
>> KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED;
>>       uint32_t mapping_flags;
>> @@ -420,7 +421,7 @@ static uint64_t get_pte_flags(struct 
>> amdgpu_device *adev, struct kgd_mem *mem)
>>       switch (adev->asic_type) {
>>       case CHIP_ARCTURUS:
>>       case CHIP_ALDEBARAN:
>> -        if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>> +        if (is_vram) {
>>               if (bo_adev == adev) {
>>                   if (uncached)
>>                       mapping_flags |= AMDGPU_VM_MTYPE_UC;
>> @@ -1236,12 +1237,18 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
>>   {
>>       struct amdgpu_bo_va *bo_va = entry->bo_va;
>>       struct amdgpu_device *adev = entry->adev;
>> +    uint64_t pte_flags = get_pte_flags(adev, mem);
>>       int ret;
>>         ret = kfd_mem_dmamap_attachment(mem, entry);
>>       if (ret)
>>           return ret;
>>   +    if (unlikely(entry->pte_flags != pte_flags)) {
>> +        amdgpu_vm_bo_update_flags(bo_va, pte_flags);
>> +        entry->pte_flags = pte_flags;
>> +    }
>> +
>>       /* Update the page tables  */
>>       ret = amdgpu_vm_bo_update(adev, bo_va, false);
>>       if (ret) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 59cac347baa3..954a40d5d828 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1862,6 +1862,25 @@ void amdgpu_vm_bo_invalidate(struct 
>> amdgpu_device *adev,
>>       }
>>   }
>>   +/**
>> + * amdgpu_vm_bo_update_flags - Update mapping flags of invalid mappings
>> + *
>> + * @bo_va: identifies the BO and VM
>> + * @flags: new mapping flags
>> + *
>> + * The update is only applied to invalid mappings. This allows 
>> updating the
>> + * mapping flags after a migration to maintain the desired 
>> coherence. The next
>> + * call to amdgpu_vm_bo_update() will apply the new @flags to the 
>> page table.
>> + */
>> +void amdgpu_vm_bo_update_flags(struct amdgpu_bo_va *bo_va,
>> +                   uint64_t flags)
>> +{
>> +    struct amdgpu_bo_va_mapping *mapping;
>> +
>> +    list_for_each_entry(mapping, &bo_va->invalids, list)
>> +        mapping->flags = flags;
>> +}
>> +
>>   /**
>>    * amdgpu_vm_get_block_size - calculate VM page table size as power 
>> of two
>>    *
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 9ecb7f663e19..11793716cd8b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -413,6 +413,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>>   bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
>>   void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>>                    struct amdgpu_bo *bo, bool evicted);
>> +void amdgpu_vm_bo_update_flags(struct amdgpu_bo_va *bo_va, uint64_t 
>> flags);
>>   uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t 
>> addr);
>>   struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
>>                          struct amdgpu_bo *bo);
>
