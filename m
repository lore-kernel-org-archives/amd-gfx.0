Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C44C47074
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 15:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C2A010E497;
	Thu,  4 Jan 2024 15:43:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00C0B10E497
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 15:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4eq+G3cQZYOzOHN9c1y4JtHtDhOP6kj5e50XE8Hn6x7R5F4A4uMfPNNQtAd3z6q9GUOSSkVn2lt/8/vL1vVfVTGwRO70CHzWAmWV0dam3s0te3mF2usi/Nx7mkF0RRuetsCRjH0KUY9alJHTw9cje3ITQKRLbAXkdsKk9tCFBXMXAXsvYYsXfMi5Ok2RamamHJ0LxlvW5SSYqoIhTKeM34+oJJ2J3lb220r1H+z9nfaqJX51rIWnC+ZtAauI2PizA2hzmhY5zvkM82XljDjxa4F9Ino9yAcUPSqxyXdmAt4LZGXjE9EOULQKAE41Dc/FW8Tg1FxYvAShsxvAGUyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fI001cwTvEa/b+kqCwjZOvvRiIweztRrTa2mFi41IFU=;
 b=iud7Muo7G9rYrs72OdokAHC8O0364W5awZJ/CNktZPCUNufl8lROvN3UqDoIXm6umwdxg/kqgsmvTQo/UtFgwCFd0m+RuGP8XdSNLpFrmtV3LCGJn9KVgK6z2dYh1UxHAgSXnbSvbhbUjhNhsCmcWSYh26Ji/0IxpfL1xeL4+h+WNpPKwIZW1SIXe2uulEvMgRfWoX6NoEFZjzBIFR7Haoop8V46miQU9htMB+VqQKBEnC/PDKBn4sGPHaZSPkov8i0dVaInFV07jEcXGg/joRqFRVQTYmAyoNY++Scg42KD7+7WraFn82kLQ7+fTnCYcQDvW2/iPoS+WZWECvqpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fI001cwTvEa/b+kqCwjZOvvRiIweztRrTa2mFi41IFU=;
 b=3Cx8Dmb7nAImrv/1CIHsxeKd1e5JOouQ3E9+oAD/mXww31fQxkCAVsY+m+cbfVnMLh5asd8lbNRt582nnEsbJhk4clCRpPKiQEVq146XYkipsGbbejehQ+Vn88PMV4XPGFDP8RAikAbyEBhT9XmOVRHeoNVZyb5JYwclST2UZY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB6901.namprd12.prod.outlook.com (2603:10b6:a03:47e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 15:43:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 15:43:43 +0000
Message-ID: <96eb2cd1-a160-43b8-9c60-c99754515f18@amd.com>
Date: Thu, 4 Jan 2024 10:43:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] drm/amdgpu: Auto-validate DMABuf imports in
 compute VMs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20240103231503.339427-1-felix.kuehling@amd.com>
 <9d37e60f-d627-4e66-96c6-b6061d29f2fc@gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <9d37e60f-d627-4e66-96c6-b6061d29f2fc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b324b7-1b2f-4138-6b8a-08dc0d3bee1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihz5cY1A3Nz7ZXF1M0RB2N6tp+L0Kg1gx0pmFkRcD10oNmmCNylHCTrxPT/GkN2rY8FbsBD5WLbgaqpbx4JZYnfzqx7rlUIu4JHnXtx7FWIQYs7lx/D/Idp/Dn0BWfFmvQFBkm0XhSEvcfm/1/BzWbpNURZ2ImmM5Yhy2fPlW4hk6LhXOhNL3+FqF652j4dUAk8gRyrmGCh256SKdano2n6Uz9ny8eOjbYUfBN7gFcoTNUdqqIqsoGolYXz5F7aHKL2dhXZDoBjbsdZvonv0qeMquaHoRr+nHuiP7ME7ygDbQpsf/Ha5DonuvDBEVcEssbLR1eOm13ewk3GBtlsPFmbDG059pV7GmamPqKJpug+iQJGXlazotgzvxVB5EHcnpvU+45PF3UR1qXtplfrozvEj5/w9yVb3e2h9IgIQ9BBmiNDPXWKVMvP9kbGl0KMRDO+vwUBQyDdYqRhsySENU4bN8pUUGE6/7JNGv7fn47aq0wfDitRVFfTOtiK6+n/CjDdqDTswbbFdFSyBfPegYcncNjcXZf+OROVeLawxYz0aOliZGdG9jrBafEHmkFU6LcKHZwXHZ6EDGAnAzOGjdr+BtF9mpUeQ+4wPB+WKTgFECVHvWTCOJHQDzu/1ipCHr8Xxnz4zF0F1xugu0xyzew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(39860400002)(136003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(478600001)(6486002)(31686004)(8936002)(38100700002)(6512007)(53546011)(6506007)(26005)(8676002)(66574015)(2616005)(316002)(44832011)(4326008)(66946007)(66556008)(66476007)(86362001)(31696002)(83380400001)(2906002)(36756003)(30864003)(5660300002)(15650500001)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEd4UWNBbHJ3TTJ6VjNYODcyZnBQdGZmNFM1eCtEbDNNSnJjWE1LMnB0bysv?=
 =?utf-8?B?dUNkeVg5b1ZxaUxpTG12RUV6SmFiSXhMS0wrVHlES3dqVGVJT2xaY3JHa01O?=
 =?utf-8?B?K1AxczBJNTFMMGQ1M2RXOHZOMzExWDIvalkxcC9CRFhuR2dzcllEYjdQK3lL?=
 =?utf-8?B?K29HWjlJS29zMzRldlVpcE1zVzd3YllBZ3JoK0ZubVkwVldVeHJITHo5cjhJ?=
 =?utf-8?B?RmlocEtkZHd3L2MwRlA4VWdNUGJUVTRObDQvN3NWTFhZanBNUW9zOXFvWVND?=
 =?utf-8?B?eWRlQzBubi8wcWFHVHdxdFhCYVFwSDEwUUhaWEJPVU5qM0twYlUzcGlnM2Mz?=
 =?utf-8?B?UmN3OUpLajhkdUN2QnhGQ0JDdGVvVDBSZkczVmtxQjVRbTJacG9CUm4zQ1Mz?=
 =?utf-8?B?ZmN5SGFNaXJwaG5YMDJ2L0xseGNqRTdWMkhvanFISkJYallYMEppcE5TWDVq?=
 =?utf-8?B?UGZuMzF6WlAzb2kzTzE3bm5KcHI5R3pubW1UMkVXUTdLOVF6eEVjY1VMVzl1?=
 =?utf-8?B?MGlWaHJSUzYyeDErM0c5R0hSS29XMmtnc0JzVENXY1lQUDJNZTJ5cG1WVEUr?=
 =?utf-8?B?VVZuaFBsbExlZWpRNDIzK3ZrRm8zN0RrMmt2ZURScmJLRUVxMjNWMnJ6Rit6?=
 =?utf-8?B?Z0xrN2N5Z1dMZ2EzR0RUdVdCTzltZHdPZEREb3FpcFErWWVGbWdXS0lZU1V2?=
 =?utf-8?B?dVIzVHdLUnprZG9iL21yYzJrRGlHKzhhemxkSHVrTEdIbzYzeXdNWkI4Ym0x?=
 =?utf-8?B?QTV4N1RON21wUThrMWsxd1J1b2srZ0IrbTdlMkpWekNSYmZnbkRPbnJsSFBV?=
 =?utf-8?B?ZitvQk4zMDJVNzZIVVNZeTNyNVcvVGcwTVlBTVVJeURGNXhRZmI1OWdUR3pp?=
 =?utf-8?B?N0RQNE9sc3pGOWZHWW80SXRXRDduUDMxQmMzT3l5U0xEQjlaMnRFSmRoaU9u?=
 =?utf-8?B?MG44NWVDUW5UcWl3bjZ4NFBHNVllRG5MK1VXSDUwYWM1MDZCbk55bS9VNi9p?=
 =?utf-8?B?bzB2VDdoR200alVQbjZLSUEzUDlrNEtlc3VLbnBLdXp3SHVycm96SWIyY09H?=
 =?utf-8?B?TzJ2TDhCSTliNENTb3pwRUFXTFdJU1duSFRscGVjQ3hoSE1hNUIvYWUzUE9D?=
 =?utf-8?B?SEhoRjlOelpLSzltNEZUY0k1YjN2R3FBYXR6NlJkbEhMZ042TlNtY1pacE5H?=
 =?utf-8?B?YUNXRytqSzNqOUtCQTdFR2d6blIwVm54cEpqNlVFcC9vVU43SGVzNHpZOGVp?=
 =?utf-8?B?V3lqdVpmZ2VjL3Y3b3IwaElSc1pYVGxjVWVURGhOL0E5TVlaeFZQbDBuaG53?=
 =?utf-8?B?U0ZkWVZpS3gzdjY4VjE3dlpPNmZ2NHRDNzJScStoUTNTNVoybThuSlZrWU1U?=
 =?utf-8?B?aGdjK1dsRjIxNW1JZ1JLdWRBZHZsMm5CWTBwU3R2VG9HZ1VvMnMvUjA3NEx3?=
 =?utf-8?B?NkcyQktiTFcydURSNGx4NEF4SmF4Wll2RGJpL2RGTm1COEgxUklqSFo0Yk5N?=
 =?utf-8?B?WStpSHFGU0ZWWmNabm5OTFEzeVRsNHZub3ZXbG1LQTcxaTNKR3FzNjRUeEZS?=
 =?utf-8?B?WG9MdFZ4dm1BYkp0UUFEKzBDSk9mRURkc2hhRzR5UjBnS21KdlUweGZPSjdu?=
 =?utf-8?B?emppUGI4V2NRdEl2WGgxV3VVQmdweG9jRWtONHRwVDZ3NlRBbzJNMURsYzlJ?=
 =?utf-8?B?dlRjS1p0cXMvRCtTNDBBSS9wOFdvL1VrazJKbGpwdWgzcE5aWWIvaTk2R3lj?=
 =?utf-8?B?OEduUGFhcGZJa0JEMkFMT2RiOTVCaWZzT2JXSGZqZFRncWhFa2xxZDY5VGZ1?=
 =?utf-8?B?RXZLYThBWFdCclVnRXovQVl1M3JQai9uZnNGazIxdnVFZ1NuaU5WL2tsMU9l?=
 =?utf-8?B?NGRiMy9peFI5TWUyOUpWdlVOTWFZWDI4dTYwSlVpT3dzQWwyVmpZMXNqZXBD?=
 =?utf-8?B?cmQ1UVB6eGQ0MEt4RTZPZnRRVXZPUzBlYVdDa2M5UmJ6Vm8vTmxiK2J5ekpB?=
 =?utf-8?B?blRKdHNSTUxIMyswZnFXSUFhOVk1MUpTU3p3NzlmRFFwYmdjdjFmcytYVlR3?=
 =?utf-8?B?d0JKUzBZeStrcjliZkMrZWFpb2JnbldLN1FFWXFobVJkYWpWb3JwZ2Y5a2dF?=
 =?utf-8?Q?2s07wKZMdQSRjp3ju5W+2aEl8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b324b7-1b2f-4138-6b8a-08dc0d3bee1e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 15:43:43.0753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7RJTEJg7o4Vju7wE3hsRDXKELkYesLPSKMNb2BA54U4Aoi14NZMA33KRmVD/sPtE3rW4w0L4CCpEczStIb0vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6901
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
Cc: xiaogang.chen@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2024-01-04 4:33, Christian König wrote:
> Am 04.01.24 um 00:15 schrieb Felix Kuehling:
>> DMABuf imports in compute VMs are not wrapped in a kgd_mem object on the
>> process_info->kfd_bo_list. There is no explicit KFD API call to validate
>> them or add eviction fences to them.
>>
>> This patch automatically validates and fences dymanic DMABuf imports 
>> when
>> they are added to a compute VM. Revalidation after evictions is handled
>> in the VM code.
>>
>> v2:
>> * Renamed amdgpu_vm_validate_evicted_bos to amdgpu_vm_validate
>> * Eliminated evicted_user state, use evicted state for VM BOs and 
>> user BOs
>> * Fixed and simplified amdgpu_vm_fence_imports, depends on reserved BOs
>> * Moved dma_resv_reserve_fences for amdgpu_vm_fence_imports into
>>    amdgpu_vm_validate, outside the vm->status_lock
>> * Added dummy version of amdgpu_amdkfd_bo_validate_and_fence for builds
>>    without KFD
>>
>> v4: Eliminate amdgpu_vm_fence_imports. It's not needed because the
>> reservation with its fences is shared with the export, as long as all
>> imports are from KFD, with the exports already reserved, validated and
>> fenced by the KFD restore worker.
>>
>> v5: Reintroduced separate evicted_user state to simplify the state 
>> machine
>> and CS error handling when amdgpu_vm_validate is called without a 
>> ticket.
>
> The problem with the separate state is that we now potentially allow 
> GFX submissions with stale page tables pointing to KFD DMA-buf imports.

I don't think that's true, though. amdgpu_dma_buf_move_notify 
invalidates the PTEs of moved DMABufs immediately by calling 
amdgpu_vm_handle_moved. In fact, that's the only way a DMABuf can get on 
the evicted_user list in the first place.

GFX submissions don't revalidate those DMABufs, so their PTEs remain 
invalid (V=0). That behavior is unchanged by my patch.

Regards,
   Felix


>
> So that is not really solving the problem either.
>
> As far as I can see the only solution is to have the same rules for 
> both GFX and KFD submissions regarding DMA-buf imports, but that is 
> something not easily doable in the short term.
>
> Regards,
> Christian.
>
>>
>> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 10 +++
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 39 ++++++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  6 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |  4 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 29 +++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 67 +++++++++++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        | 12 ++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 10 +--
>>   8 files changed, 141 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index f262b9d89541..584a0cea5572 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -191,6 +191,9 @@ struct amdgpu_amdkfd_fence 
>> *to_amdgpu_amdkfd_fence(struct dma_fence *f);
>>   int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo);
>>   int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
>>                   unsigned long cur_seq, struct kgd_mem *mem);
>> +int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
>> +                    uint32_t domain,
>> +                    struct dma_fence *fence);
>>   #else
>>   static inline
>>   bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
>> @@ -216,6 +219,13 @@ int amdgpu_amdkfd_evict_userptr(struct 
>> mmu_interval_notifier *mni,
>>   {
>>       return 0;
>>   }
>> +static inline
>> +int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
>> +                    uint32_t domain,
>> +                    struct dma_fence *fence)
>> +{
>> +    return 0;
>> +}
>>   #endif
>>   /* Shared API */
>>   int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t 
>> size,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 5f445d856769..6f3a4cb2a9ef 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -426,9 +426,9 @@ static int amdgpu_amdkfd_bo_validate(struct 
>> amdgpu_bo *bo, uint32_t domain,
>>       return ret;
>>   }
>>   -static int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
>> -                           uint32_t domain,
>> -                           struct dma_fence *fence)
>> +int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
>> +                    uint32_t domain,
>> +                    struct dma_fence *fence)
>>   {
>>       int ret = amdgpu_bo_reserve(bo, false);
>>   @@ -464,13 +464,15 @@ static int amdgpu_amdkfd_validate_vm_bo(void 
>> *_unused, struct amdgpu_bo *bo)
>>    * again. Page directories are only updated after updating page
>>    * tables.
>>    */
>> -static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
>> +static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm,
>> +                 struct ww_acquire_ctx *ticket)
>>   {
>>       struct amdgpu_bo *pd = vm->root.bo;
>>       struct amdgpu_device *adev = amdgpu_ttm_adev(pd->tbo.bdev);
>>       int ret;
>>   -    ret = amdgpu_vm_validate_pt_bos(adev, vm, 
>> amdgpu_amdkfd_validate_vm_bo, NULL);
>> +    ret = amdgpu_vm_validate(adev, vm, ticket,
>> +                 amdgpu_amdkfd_validate_vm_bo, NULL);
>>       if (ret) {
>>           pr_err("failed to validate PT BOs\n");
>>           return ret;
>> @@ -1310,14 +1312,15 @@ static int map_bo_to_gpuvm(struct kgd_mem *mem,
>>       return ret;
>>   }
>>   -static int process_validate_vms(struct amdkfd_process_info 
>> *process_info)
>> +static int process_validate_vms(struct amdkfd_process_info 
>> *process_info,
>> +                struct ww_acquire_ctx *ticket)
>>   {
>>       struct amdgpu_vm *peer_vm;
>>       int ret;
>>         list_for_each_entry(peer_vm, &process_info->vm_list_head,
>>                   vm_list_node) {
>> -        ret = vm_validate_pt_pd_bos(peer_vm);
>> +        ret = vm_validate_pt_pd_bos(peer_vm, ticket);
>>           if (ret)
>>               return ret;
>>       }
>> @@ -1402,7 +1405,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, 
>> void **process_info,
>>       ret = amdgpu_bo_reserve(vm->root.bo, true);
>>       if (ret)
>>           goto reserve_pd_fail;
>> -    ret = vm_validate_pt_pd_bos(vm);
>> +    ret = vm_validate_pt_pd_bos(vm, NULL);
>>       if (ret) {
>>           pr_err("validate_pt_pd_bos() failed\n");
>>           goto validate_pd_fail;
>> @@ -2043,7 +2046,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>>           bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
>>           is_invalid_userptr = true;
>>   -    ret = vm_validate_pt_pd_bos(avm);
>> +    ret = vm_validate_pt_pd_bos(avm, NULL);
>>       if (unlikely(ret))
>>           goto out_unreserve;
>>   @@ -2122,7 +2125,7 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
>>           goto unreserve_out;
>>       }
>>   -    ret = vm_validate_pt_pd_bos(avm);
>> +    ret = vm_validate_pt_pd_bos(avm, NULL);
>>       if (unlikely(ret))
>>           goto unreserve_out;
>>   @@ -2620,7 +2623,7 @@ static int validate_invalid_user_pages(struct 
>> amdkfd_process_info *process_info)
>>           }
>>       }
>>   -    ret = process_validate_vms(process_info);
>> +    ret = process_validate_vms(process_info, NULL);
>>       if (ret)
>>           goto unreserve_out;
>>   @@ -2880,11 +2883,6 @@ int 
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence 
>> __rcu *
>>         amdgpu_sync_create(&sync_obj);
>>   -    /* Validate PDs and PTs */
>> -    ret = process_validate_vms(process_info);
>> -    if (ret)
>> -        goto validate_map_fail;
>> -
>>       /* Validate BOs and map them to GPUVM (update VM page tables). */
>>       list_for_each_entry(mem, &process_info->kfd_bo_list,
>>                   validate_list) {
>> @@ -2935,6 +2933,13 @@ int 
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence 
>> __rcu *
>>       if (failed_size)
>>           pr_debug("0x%lx/0x%lx in system\n", failed_size, total_size);
>>   +    /* Validate PDs, PTs and evicted DMABuf imports last. 
>> Otherwise BO
>> +     * validations above would invalidate DMABuf imports again.
>> +     */
>> +    ret = process_validate_vms(process_info, &exec.ticket);
>> +    if (ret)
>> +        goto validate_map_fail;
>> +
>>       /* Update mappings not managed by KFD */
>>       list_for_each_entry(peer_vm, &process_info->vm_list_head,
>>               vm_list_node) {
>> @@ -3006,7 +3011,7 @@ int 
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence 
>> __rcu *
>> &process_info->eviction_fence->base,
>>                      DMA_RESV_USAGE_BOOKKEEP);
>>       }
>> -    /* Attach eviction fence to PD / PT BOs */
>> +    /* Attach eviction fence to PD / PT BOs and DMABuf imports */
>>       list_for_each_entry(peer_vm, &process_info->vm_list_head,
>>                   vm_list_node) {
>>           struct amdgpu_bo *bo = peer_vm->root.bo;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 83c7fc09218c..bbbd8ad0171f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -952,10 +952,10 @@ static int amdgpu_cs_parser_bos(struct 
>> amdgpu_cs_parser *p,
>>       p->bytes_moved = 0;
>>       p->bytes_moved_vis = 0;
>>   -    r = amdgpu_vm_validate_pt_bos(p->adev, &fpriv->vm,
>> -                      amdgpu_cs_bo_validate, p);
>> +    r = amdgpu_vm_validate(p->adev, &fpriv->vm, NULL,
>> +                   amdgpu_cs_bo_validate, p);
>>       if (r) {
>> -        DRM_ERROR("amdgpu_vm_validate_pt_bos() failed.\n");
>> +        DRM_ERROR("amdgpu_vm_validate() failed.\n");
>>           goto out_free_user_pages;
>>       }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> index decbbe3d4f06..055ba2ea4c12 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> @@ -377,6 +377,10 @@ amdgpu_dma_buf_move_notify(struct 
>> dma_buf_attachment *attach)
>>       struct amdgpu_vm_bo_base *bo_base;
>>       int r;
>>   +    /* FIXME: This should be after the "if", but needs a fix to 
>> make sure
>> +     * DMABuf imports are initialized in the right VM list.
>> +     */
>> +    amdgpu_vm_bo_invalidate(adev, bo, false);
>>       if (!bo->tbo.resource || bo->tbo.resource->mem_type == 
>> TTM_PL_SYSTEM)
>>           return;
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index b1ce22a9b186..7bd32601c2a7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -187,7 +187,34 @@ static int amdgpu_gem_object_open(struct 
>> drm_gem_object *obj,
>>       else
>>           ++bo_va->ref_count;
>>       amdgpu_bo_unreserve(abo);
>> -    return 0;
>> +
>> +    /* Validate and add eviction fence to DMABuf imports with dynamic
>> +     * attachment in compute VMs. Re-validation will be done by
>> +     * amdgpu_vm_validate. Fences are on the reservation shared with 
>> the
>> +     * export, which is currently required to be validated and fenced
>> +     * already by amdgpu_amdkfd_gpuvm_restore_process_bos.
>> +     *
>> +     * Nested locking below for the case that a GEM object is opened in
>> +     * kfd_mem_export_dmabuf. Since the lock below is only taken for 
>> imports,
>> +     * but not for export, this is a different lock class that 
>> cannot lead to
>> +     * circular lock dependencies.
>> +     */
>> +    if (!vm->is_compute_context || !vm->process_info)
>> +        return 0;
>> +    if (!obj->import_attach ||
>> +        !dma_buf_is_dynamic(obj->import_attach->dmabuf))
>> +        return 0;
>> +    mutex_lock_nested(&vm->process_info->lock, 1);
>> +    if (!WARN_ON(!vm->process_info->eviction_fence)) {
>> +        r = amdgpu_amdkfd_bo_validate_and_fence(abo, 
>> AMDGPU_GEM_DOMAIN_GTT,
>> + &vm->process_info->eviction_fence->base);
>> +        if (r)
>> +            dev_warn(adev->dev, "%d: validate_and_fence failed: %d\n",
>> +                 vm->task_info.pid, r);
>> +    }
>> +    mutex_unlock(&vm->process_info->lock);
>> +
>> +    return r;
>>   }
>>     static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index b8fcb6c55698..77d015ebb201 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -233,6 +233,22 @@ static void amdgpu_vm_bo_invalidated(struct 
>> amdgpu_vm_bo_base *vm_bo)
>>       spin_unlock(&vm_bo->vm->status_lock);
>>   }
>>   +/**
>> + * amdgpu_vm_bo_evicted_user - vm_bo is evicted
>> + *
>> + * @vm_bo: vm_bo which is evicted
>> + *
>> + * State for BOs used by user mode queues which are not at the 
>> location they
>> + * should be.
>> + */
>> +static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
>> +{
>> +    vm_bo->moved = true;
>> +    spin_lock(&vm_bo->vm->status_lock);
>> +    list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
>> +    spin_unlock(&vm_bo->vm->status_lock);
>> +}
>> +
>>   /**
>>    * amdgpu_vm_bo_relocated - vm_bo is reloacted
>>    *
>> @@ -427,21 +443,25 @@ uint64_t amdgpu_vm_generation(struct 
>> amdgpu_device *adev, struct amdgpu_vm *vm)
>>   }
>>     /**
>> - * amdgpu_vm_validate_pt_bos - validate the page table BOs
>> + * amdgpu_vm_validate - validate evicted BOs tracked in the VM
>>    *
>>    * @adev: amdgpu device pointer
>>    * @vm: vm providing the BOs
>> + * @ticket: optional reservation ticket used to reserve the VM
>>    * @validate: callback to do the validation
>>    * @param: parameter for the validation callback
>>    *
>> - * Validate the page table BOs on command submission if neccessary.
>> + * Validate the page table BOs and per-VM BOs on command submission if
>> + * necessary. If a ticket is given, also try to validate evicted 
>> user queue
>> + * BOs. They must already be reserved with the given ticket.
>>    *
>>    * Returns:
>>    * Validation result.
>>    */
>> -int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm,
>> -                  int (*validate)(void *p, struct amdgpu_bo *bo),
>> -                  void *param)
>> +int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm 
>> *vm,
>> +               struct ww_acquire_ctx *ticket,
>> +               int (*validate)(void *p, struct amdgpu_bo *bo),
>> +               void *param)
>>   {
>>       struct amdgpu_vm_bo_base *bo_base;
>>       struct amdgpu_bo *shadow;
>> @@ -484,6 +504,28 @@ int amdgpu_vm_validate_pt_bos(struct 
>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>           }
>>           spin_lock(&vm->status_lock);
>>       }
>> +    while (ticket && !list_empty(&vm->evicted_user)) {
>> +        bo_base = list_first_entry(&vm->evicted_user,
>> +                       struct amdgpu_vm_bo_base,
>> +                       vm_status);
>> +        spin_unlock(&vm->status_lock);
>> +
>> +        bo = bo_base->bo;
>> +
>> +        if (dma_resv_locking_ctx(bo->tbo.base.resv) != ticket) {
>> +            pr_warn_ratelimited("Evicted user BO is not reserved in 
>> pid %d\n",
>> +                        vm->task_info.pid);
>> +            return -EINVAL;
>> +        }
>> +
>> +        r = validate(param, bo);
>> +        if (r)
>> +            return r;
>> +
>> +        amdgpu_vm_bo_invalidated(bo_base);
>> +
>> +        spin_lock(&vm->status_lock);
>> +    }
>>       spin_unlock(&vm->status_lock);
>>         amdgpu_vm_eviction_lock(vm);
>> @@ -1426,11 +1468,21 @@ int amdgpu_vm_handle_moved(struct 
>> amdgpu_device *adev,
>>           }
>>             r = amdgpu_vm_bo_update(adev, bo_va, clear);
>> -        if (r)
>> -            return r;
>>             if (unlock)
>>               dma_resv_unlock(resv);
>> +        if (r)
>> +            return r;
>> +
>> +        /* Remember evicted DMABuf imports in compute VMs for later
>> +         * validation
>> +         */
>> +        if (vm->is_compute_context && bo_va->base.bo &&
>> +            bo_va->base.bo->tbo.base.import_attach &&
>> +            (!bo_va->base.bo->tbo.resource ||
>> +             bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
>> +            amdgpu_vm_bo_evicted_user(&bo_va->base);
>> +
>>           spin_lock(&vm->status_lock);
>>       }
>>       spin_unlock(&vm->status_lock);
>> @@ -2196,6 +2248,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm,
>>       for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
>>           vm->reserved_vmid[i] = NULL;
>>       INIT_LIST_HEAD(&vm->evicted);
>> +    INIT_LIST_HEAD(&vm->evicted_user);
>>       INIT_LIST_HEAD(&vm->relocated);
>>       INIT_LIST_HEAD(&vm->moved);
>>       INIT_LIST_HEAD(&vm->idle);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index b6cd565562ad..626641d97c99 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -288,9 +288,12 @@ struct amdgpu_vm {
>>       /* Lock to protect vm_bo add/del/move on all lists of vm */
>>       spinlock_t        status_lock;
>>   -    /* BOs who needs a validation */
>> +    /* Per-VM and PT BOs who needs a validation */
>>       struct list_head    evicted;
>>   +    /* BOs for user mode queues that need a validation */
>> +    struct list_head    evicted_user;
>> +
>>       /* PT BOs which relocated and their parent need an update */
>>       struct list_head    relocated;
>>   @@ -434,9 +437,10 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, 
>> struct drm_exec *exec,
>>                 unsigned int num_fences);
>>   bool amdgpu_vm_ready(struct amdgpu_vm *vm);
>>   uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm);
>> -int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm,
>> -                  int (*callback)(void *p, struct amdgpu_bo *bo),
>> -                  void *param);
>> +int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm 
>> *vm,
>> +               struct ww_acquire_ctx *ticket,
>> +               int (*callback)(void *p, struct amdgpu_bo *bo),
>> +               void *param);
>>   int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job 
>> *job, bool need_pipe_sync);
>>   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>                 struct amdgpu_vm *vm, bool immediate);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 2ac0c7788dfc..6b314e4d3ae0 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1515,9 +1515,9 @@ static int svm_range_reserve_bos(struct 
>> svm_validate_context *ctx, bool intr)
>>               goto unreserve_out;
>>           }
>>   -        r = amdgpu_vm_validate_pt_bos(pdd->dev->adev,
>> -                          drm_priv_to_vm(pdd->drm_priv),
>> -                          svm_range_bo_validate, NULL);
>> +        r = amdgpu_vm_validate(pdd->dev->adev,
>> +                       drm_priv_to_vm(pdd->drm_priv), NULL,
>> +                       svm_range_bo_validate, NULL);
>>           if (r) {
>>               pr_debug("failed %d validate pt bos\n", r);
>>               goto unreserve_out;
>> @@ -1641,7 +1641,9 @@ static int svm_range_validate_and_map(struct 
>> mm_struct *mm,
>>           goto free_ctx;
>>       }
>>   -    svm_range_reserve_bos(ctx, intr);
>> +    r = svm_range_reserve_bos(ctx, intr);
>> +    if (r)
>> +        goto free_ctx;
>>         p = container_of(prange->svms, struct kfd_process, svms);
>>       owner = kfd_svm_page_owner(p, find_first_bit(ctx->bitmap,
>
