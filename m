Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE86C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 22:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B86A610F032;
	Wed, 25 May 2022 22:17:34 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26ACA10F032
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 22:17:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xm79ew5KGGOdBYbp6Jfa8dQhassznGiSbjXhxgoj8byi0aeBYXjoTCbm09ul1CoTRLDPJbgxV7U3gD/xgNXxbfBS9mevi71Mo60f85q/1XSbV50/7vs+X2rxxMQaao/Abv++MYB42QsuhVo58iAJ6MiHHgrjN93ldttmsUniLVy0kZfFKRZPFfzaNuTjGQTyWRE+r5ql2GtMn5KfaqBim3G56z2o2rfWjvujq/XX4n7GEHRVnup9UikYvQtx6ZlOrZveHhgRu8Mimn7Ap5de6aZmM9Ow71qoGUgbFYBn081jWWhc5NX0h8Hsfdg0gvg9nUEHaJ/W/UNob+C4DwbkjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24wO77ZaRRBScPcCrSQASrQ7bBuNlHa09QuIU+WOSBM=;
 b=EdqaSBbbQggk6U1i0eBjvSbcEe3XuOjogDnNRSGV1If1/mW2tx6IQ22mdZla/xVQELNNXgShACXOPtomky8f69ovdYctUl3psl+qEUcFN5lJGbL8whfHN8KHJKfAt/k/YEVaTSgbZ1HQX2Q2Qw+DVjTMnFuYdI10HL8mz8QZM/P8siF9TCqsBbihPe+Kg3mdmpKHU9dIdZFDn9d0VsqewqnCcNRjZOCPdRLU/u4AuFFx3/piD9B0jg5XSr9ZoFlrroCX+71i2Ut8CZyFylUvYrcwMk1N3UPWMSF5YAZbgGEnnb1dUfQCWWafmAzOPOe5zmR1lc6ENNU8FGYAnr+zNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24wO77ZaRRBScPcCrSQASrQ7bBuNlHa09QuIU+WOSBM=;
 b=aH9D4iEttiBw9Q5h4aoxObgJKsDcqFF6U39gCumscuMt9llmgwRjiRTlgCHPLdQgIWifuECpkKRqvE3L6yVO10lW3j3aKalEWVifGU63nUwyCcIHET8xNkUW8xVePFFK8OMUQikmwici1N+awtokrAv4jWywp8EVPy3eImSPXkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4857.namprd12.prod.outlook.com (2603:10b6:610:64::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 22:17:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 22:17:31 +0000
Message-ID: <e46a9b9f-f8ca-a701-530c-20080f50a3f8@amd.com>
Date: Wed, 25 May 2022 18:17:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdkfd: don't add DOORBELL and MMIO BOs to validate
 list
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Lang Yu <Lang.Yu@amd.com>
References: <20220525084324.1354886-1-Lang.Yu@amd.com>
 <eebb0612-6703-9408-ebf6-2813e13139ef@gmail.com>
 <Yo31/hZQ7qzs2KyO@lang-desktop>
 <77ece2f1-97e6-f44d-0a30-971b28693c3c@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <77ece2f1-97e6-f44d-0a30-971b28693c3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:208:32d::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 095d84d3-477f-4fc0-6c2f-08da3e9c5c7e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4857:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB485713E137D15184D0B2468E92D69@CH2PR12MB4857.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FP1WAtySYyY2mVujzNoDFcSV1id5lkNEHtnHKonBeGQ0GiOP7DfpISCbhTm8WijyrmP97k8x5JsK38YHNvMvUAclGOcW65n1CpsYEwlqF3sMqTRfS+1pF1OUYTqj3rIuCCiOyDo7imu/JpwD+qhrnm2TYIb6bfejujkdwaDCWqrd7a02UUjEQFIMeMN41KOZk0cc8uU/07o9d8KWggiVSCdOuECsnx7yi2Ho81Lz5k/84LAP5+LwulIJUJv1IqVMVN06GKK6kvYth5tTys+PLL4OVAxGrNPVfLdxjQgNF0R9hix23QRONmNTtDddpCSE2APgtXJ5+5mscpjw053rORyid+PuLA9GI0klQsCzt7d7uW7/+R+HfErEbZPo7o/b2SdH3go8Dbb4KUhB79LgVZscMDuw/rn8LZ1F1/gH1HRtzWYocsUlSHgGgBUGbUsRJdy7c+8lK7ZEgBlM4034cAUuYHy6Sg0KqPWpVer6yVRkuV89d4/jNSVlcTKZJ/bPl2b9KVMqehz4/UrLY5phx5Dcmdxn8iXP5KNXp19oqbu0TEakICMO4aL4f9MpSQG7rv3YJcJ0R4EofzENXUVlPOAfu2T2lnWBKavIvkXrXNpYW48Li32zSNTuh2g5HmYeIRuQhHnblJuyk2tvelpN9fAzjYcDazsqnP+LZeAKFjSZvS748TjbNuv2HLi5cTNgRiAuE8ge31qAalTNBvWYXcNrUf8cxgnJ2t3hA/MoG2n+AilwPr6hp4irFx/dWa+z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(54906003)(26005)(6512007)(8936002)(110136005)(5660300002)(31686004)(66574015)(53546011)(6506007)(36916002)(6636002)(66476007)(66556008)(66946007)(4326008)(8676002)(86362001)(15650500001)(83380400001)(2616005)(44832011)(36756003)(31696002)(186003)(316002)(6486002)(2906002)(508600001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVBiNlpKWUpSMGtYd2RDc0h4Yml4d2I0cU5WemJuTDlUWGVaRDIvRkkrY2Nt?=
 =?utf-8?B?R0VxWVY4dmNUQTRmUkhJT3pPcGVyOGlNdHAySEdpK245R08vd3d5TTkrWHk5?=
 =?utf-8?B?Sm91K2tHei9mMUl1MkZPYzMrZ2RzZmhlbE81Sm5BVlkxK0dOaTltWnlxM3l5?=
 =?utf-8?B?MWtnWVMxckd1MjZ3dXZHb0gxcnlWOFBZRm9qU1NKOHU3emNNY1czTmdneHJV?=
 =?utf-8?B?VmZmTU1wY05TZUlSZ2Y3Y2VldmxWelZPbkxoZi9HMkJvMU83ckRLYktNdnJK?=
 =?utf-8?B?eG1UYnJ4YnB5NnZFQUdqK3FuYzlRL0lyaDNJZ000YjBzN1UxNEZUVStFUlpI?=
 =?utf-8?B?dW5RRmJxbTVIMmQ0UERQcjVteTZrSlRVblhOcG92RDVKRmh6MU1OdzBaU2Yv?=
 =?utf-8?B?ekw1Zmkyb2UwRXJ4d1FuemRnTXpWWVIxd3VEK2FyZVVhdjNCUDlWMVVFR2h3?=
 =?utf-8?B?NCtySlZ5bllRQ3I1UVlEaXBWZ2loOVd5b2dvM0NRc0w5am5FZWpGelF0MmZB?=
 =?utf-8?B?Rjg2cUJpYmt4MGVBN1lRZFhyVGJlWnl5eXlWdmh6VDZacGtCUXJ0dGFVU2ph?=
 =?utf-8?B?SGVDTkFPOXBZQ1V1U1VkK1d6STY0czFtRzk4N05KOUs5a2tBWkh6UC8xSDJz?=
 =?utf-8?B?MVBKZlFGOGs5UXQrTFlyWHprYWdvYnRiT2YweDV2SGJITW5sUWdTbW83Z0U3?=
 =?utf-8?B?eFBid1BmSFdkcDhqNTdGT2N4NUxLTjNuSXBCVG9QT0F1SnJod0VvSlRXRDZP?=
 =?utf-8?B?K3dJcytyTnBOYVJJVGttL2RlT1hSekE4T1hOVWVia3BNU2M2WFZSM3Y2aWxw?=
 =?utf-8?B?YUl6dW5BYStGVy9nWnJFWGM2bEt3a004RWs2a0lPaE82RUtPbWlPS1MycEpr?=
 =?utf-8?B?cVE5OFhZU3NQRGF3cFI4TTBUZkVYcFZ3cGs5VWVSZVo0SEZweExzdXpPR1VM?=
 =?utf-8?B?d1MxQjhUeVpHOEN1Ykx5RUJ3dEtSYVNQa29zZGM5SGI4VkZUNnhvYlhLa1F5?=
 =?utf-8?B?NTVwejJBZzB4K1dJVE5tQnozOTdWZkIwUkl2emFBSnphZzhaNE1nVzROZC8x?=
 =?utf-8?B?K1dQS21oSGRoTFlVb1BMdmNlMGJMNkpCNDAwRDREc1pITHZzamZOUFMxakdZ?=
 =?utf-8?B?cDcvRVJzV0N5NUV1aGFKYjYzbnlFWGxCTjNJYzhFZ0VONVl2bllNZE1vdUU4?=
 =?utf-8?B?eWVDSVEyNHJOdWdFMmpSYXl1dWNRc3MzQTYxMW9GaXIrWDNwV0hHTE5ibnZa?=
 =?utf-8?B?R1pwTFZXRTNJcTlwREt4WEJiOVZZa0RiQnRxMjFFWGpKSXNrRXl0aTM2M29F?=
 =?utf-8?B?Mm5wSTBubVpxZmxTTUlRQ3laaEcrUnRPbUUrVGVKRXd6d0hJMDlSaWxIdUV6?=
 =?utf-8?B?blozQUUrelMvOU5Edm9ZY28zWDVpZndXY1N4T2pFak9vMy9LTUh1M3N5d0Ny?=
 =?utf-8?B?cEViNzlrZjFhQW1qQTBCOGdzQ1BHd0xHbFVjU1pXRzYzZnFRcjR1NzNvYUx2?=
 =?utf-8?B?Smtsa1VzWEJlYlg3K1RuaGozcDQvNHZRYzlxS0dzVWFpS20rcnp5eElQeHhT?=
 =?utf-8?B?NzBzS2Q4eE1XM0xFWkwvWTdRRVhCeVh5VW9MSVd0b0NLQzJ1SzV5T2I3UmF0?=
 =?utf-8?B?ejBZQVR1dlgwWFZxZGJmVzVvaTByalJNL2xhbzI5YjQ1ZWdyWU1zUDdBbS8z?=
 =?utf-8?B?ZkZvV3lhQjhqZ3h1NDF3QVg5TEFHL3dsOVBZZmVKaXJLT0FqV052K2FlWFdn?=
 =?utf-8?B?V0dFYkZhUVo4UUpNQlZCdUk2QnBtaTdqU2I0YjQzM3FsV3JLRmFFYyt6dDdB?=
 =?utf-8?B?VThGTkxjM0ZFbmkvcGRRY005bkRlMm1TWGErSVZxd0QyeVRtRkNBa3AyM25T?=
 =?utf-8?B?TlFZVGdpR04ydzFIYnJnTDljSjJncHF1R1J4UEdpb1hMR0oxaTFXNzlNdW1p?=
 =?utf-8?B?VE5UWlVYbEdJQnlNN3JMa1crSzE4a0VnamFoWVFxNE8zNVlhdWk3cmhNYzBx?=
 =?utf-8?B?SndHS0RIblF1a1VnTTRmRFZZNlJwUXRvam5ZdjhYbXgvSnlsWHU0dUlibElw?=
 =?utf-8?B?Wjk5WW9oaEZER1I2Vk1UTTZkRGxYRWJqcW1Mb3RRSjNCTysvbEc0N0ZFWTZO?=
 =?utf-8?B?bnF1bDYzMlpXTyswRkdSd1lDQlFOT0tIUklMeW5FYmpTYks5SFlnTG9sSUJm?=
 =?utf-8?B?THZIc0I5NUo2WnNsb01LRU9ZSnFkVDVPS2owSUF2MGJ4NU42TWlYZCtQNXB3?=
 =?utf-8?B?d2U0TCt4TGxvUHFnRjBPRzV5SnRwdkdhUzFCeEpQZVgxdzNCRWpoSWhaaEVC?=
 =?utf-8?B?dDVja0RUM2d3TTJNbHB5dFVqa0Z2di9tZGZRNzNIak5yZEtNeU5Ldz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095d84d3-477f-4fc0-6c2f-08da3e9c5c7e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 22:17:31.5361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohf1MmlxXaI7rp31xEMGuTajSQyuvqZDaO82wdRJxfMxDWVkZat7B4wHHyY2Ltp5g8zFNJng+HQcNU0zTf7I6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4857
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-05-25 06:37, Christian König wrote:
> Am 25.05.22 um 11:25 schrieb Lang Yu:
>> On 05/25/ , Christian König wrote:
>>> Am 25.05.22 um 10:43 schrieb Lang Yu:
>>>> DOORBELL and MMIO BOs never move once created.
>>>> No need to validate them after that.
>>> Yeah, but you still need to make sure their page tables are up to date.
>>>
>>> So this here might break horrible.
>> These BOs(and attachments) are validated when allocated and mapped.
>> Their page tables should be determined at this time.
>>
>> The kfd_bo_list is used to restore BOs after evictions.
>>
>> Do you mean their page tabes could be changed? Thanks.
>
> Yes, page tables can be destroyed under memory pressure as well.

Is that actually happening today, or is that some future optimization 
you have in mind? I know page tables can get evicted, but I didn't think 
they were destroyed unless the memory at that address is unmapped (which 
never happens for pinned BOs).


>
> Not sure how the KFD handles that, but in theory we should have every 
> BO used by a process on the validation list. Even the ones pinned.

Then we already have some other broken cases for the small number of 
kmapped BOs that are pinned and currently removed from the validation 
list (see amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel).

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>>
>>> Christian.
>>>
>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 
>>>> +++++++++-----
>>>>    1 file changed, 9 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> index 34ba9e776521..45de9cadd771 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> @@ -808,6 +808,10 @@ static void add_kgd_mem_to_kfd_bo_list(struct 
>>>> kgd_mem *mem,
>>>>        struct ttm_validate_buffer *entry = &mem->validate_list;
>>>>        struct amdgpu_bo *bo = mem->bo;
>>>> +    if (mem->alloc_flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
>>>> +                KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
>>>> +        return;
>>>> +
>>>>        INIT_LIST_HEAD(&entry->head);
>>>>        entry->num_shared = 1;
>>>>        entry->bo = &bo->tbo;
>>>> @@ -824,6 +828,10 @@ static void 
>>>> remove_kgd_mem_from_kfd_bo_list(struct kgd_mem *mem,
>>>>    {
>>>>        struct ttm_validate_buffer *bo_list_entry;
>>>> +    if (mem->alloc_flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
>>>> +                KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
>>>> +        return;
>>>> +
>>>>        bo_list_entry = &mem->validate_list;
>>>>        mutex_lock(&process_info->lock);
>>>>        list_del(&bo_list_entry->head);
>>>> @@ -1649,7 +1657,6 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>>>        unsigned long bo_size = mem->bo->tbo.base.size;
>>>>        struct kfd_mem_attachment *entry, *tmp;
>>>>        struct bo_vm_reservation_context ctx;
>>>> -    struct ttm_validate_buffer *bo_list_entry;
>>>>        unsigned int mapped_to_gpu_memory;
>>>>        int ret;
>>>>        bool is_imported = false;
>>>> @@ -1677,10 +1684,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>>>        }
>>>>        /* Make sure restore workers don't access the BO any more */
>>>> -    bo_list_entry = &mem->validate_list;
>>>> -    mutex_lock(&process_info->lock);
>>>> -    list_del(&bo_list_entry->head);
>>>> -    mutex_unlock(&process_info->lock);
>>>> +    remove_kgd_mem_from_kfd_bo_list(mem, process_info);
>>>>        /* No more MMU notifiers */
>>>>        amdgpu_mn_unregister(mem->bo);
>
