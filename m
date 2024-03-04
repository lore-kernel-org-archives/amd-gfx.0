Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966BEC5478C
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Mar 2024 10:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D6610FF15;
	Mon,  4 Mar 2024 10:05:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FKgu8Kcx";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FEE310FF1A
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Mar 2024 10:05:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjC++JjODH9QFNtEvOYwwQlg+gzZPiYhmYvDP2SLNYXso+IEl55pT2ZR8bBEiZN/DlFYFEWfsYNag04/m9LxyAUNLbY3pmhvOSuCa8tn5DJWKH1zq89dilCZP7r3AmyNm+cVMBE7pZfNqGOWK+62sCxT/Cmkh2kwiJG4omaLyFUwyWhoEApnsqw0F3t/++n11MXgd3xrdhb+qormxCX/9oEyho714ZHADbFCs46lXosGooVze+/zwMpWFzNCKRBSqv0s7GRdKh6PgS3+YfnRMmDi7NVUoGQq/6rD/H8f2ytokH2Vwx6GHkO+EPf2gbzrkeCg/0NaWCOd7PfpnTTufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiyAVi7Gtdqof2SYbbOPibD4QFr0SkivaAtXYo7mBac=;
 b=Wy+xbBOhqZpebjJ4aRdUgLtfAgOlD+HipkY3861ZYe/w4YXf8ofxBtYToy4Ja+8ItPLhUjlwCNayadM8drwqXTN55AlJ5IgszSGPnGtNCUbwj6bgJ5vsTil9jOIJtJAtm0LLTrrwYlXXGt7gSc/DSX+V/LykN4dfIeZx0iDga6Iiy4JBoGCPI08jSTbI9ruwT0XlHyNo0Js1Nv5xkcoN+erzwszzuGpjHKTyqWxhAEk11HrtZwmQBoKuDmzFGrNA5ERpXwD9Yc027ZXV6Y+GVgBw0C9jWSDEHSMtK40o5f9R1lSGnKe4poZEJ3z238tC9l3xd9/2ZhwGEmO8MM10TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiyAVi7Gtdqof2SYbbOPibD4QFr0SkivaAtXYo7mBac=;
 b=FKgu8Kcx88YszIzyy5CMMX0OLsLqqFn09yhemI8bk765d3EEVIL0WLy7UvMxOpUpHA3KmGZbKQX/zBYaHoqXkSq06VM7pBG+SNqTemech0zslKJbNA8RGqhT79ypgIwWTLjcG1DjMkUCprtcn4BPFFYX5eBlYnfBNvsb3nCAocA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 10:05:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7339.031; Mon, 4 Mar 2024
 10:05:40 +0000
Message-ID: <d4620058-5465-4913-93f0-9bcbf3e4c3e1@amd.com>
Date: Mon, 4 Mar 2024 11:05:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/amdgpu: sync page table freeing with tlb flush
To: "Sharma, Shashank" <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip Yang <yangp@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
References: <20240301110724.947-1-shashank.sharma@amd.com>
 <20240301110724.947-2-shashank.sharma@amd.com>
 <fdc41038-62e8-4aa4-8a7f-86ca09324362@amd.com>
 <1d76d001-e018-770e-5315-f174169b68e6@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <1d76d001-e018-770e-5315-f174169b68e6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 3954663f-1cfc-41c3-727f-08dc3c32a513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1J4HvzvvSlXOhxvtrowVNBHZr4YttFtYluSLAuGECd7Q01W2yTjfpZSq2Don4+bkBq0dP0bsODntsKIgOI1Ixx1wth3tq9LuVha3N/WpRMVD4fUsz4sgXPhpI4ZPRkGX3RYDWt5Ym+qgUe1fmRv5o2khObp/kda3K8O0o2K+j0Bl7j6jpGPzJOgHtP+Pv8wssygFEX8rg0iMw3XIKO8sRSEb2C6o2q/yc6tPtel3jv+94TjDxSOlDP28Jnr+iPrLatVT3ryxFVHFNMv0x1mq37mMj//CJVMxq1YMuhqJzFI+uonjZ0q7+kda+hP49ndhYsScowaDlu0mMGPJuoM9zm2xUUO7XniWUkB2202+2AevTR1kl+p6kdYw5pxjVgFMkOzCvIiv80VzHkN8lrPIkDpwH3nV0w7WPcsV4SHOSts6yF7AJFF+3INvARqsRbUKMcPSC0GQJFJw1mHhQlD1RVnQ0f2WwMpyOhymM5Y1ae0hGTgg0XCitsGyP8UcALfzsm9PLz18wKztfaX/7WNRbcXk/5DUQbZBqgu32bp85VyO0IIeP+ZqJCGO9IlMwJfVGfv0prAQn5S8XGB64LzoA7+jg3kv9Etp7iRgi5EWMe4itiUQepLbolLt3yyYAJxg6I9Y9Dhtf3VZ0k6nlMT5SZZ6s6nqgEyxo8F1CTIQfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnNIakNUcnloWTZaVG5YRG1qejQrZllTMkp6Y2VHSzhvL1NBTENWUFFSRnRE?=
 =?utf-8?B?ZDFTT0dyYTdJMnRqRFh3MTNXTDY4alZ0QzNWdVVZVmFSMVZtVXNhZ1BNTDVR?=
 =?utf-8?B?LzNiYVhHOTZYWDdWa2RaejVWVjIzbUw2TWc3R0lyN0hkWUVUTEdKRkI1cEJF?=
 =?utf-8?B?b09oWW1VQkpVRmh5bGt2TGoyT050VTR4TjY1T2RBaThTNkVVUGh2cTl3RFdF?=
 =?utf-8?B?QVZhNjBsWFQ4d3BkR3ZHVFRPcEh3QmNTZmtYcEQwdnFhNmVLMkZkNEhkTHhK?=
 =?utf-8?B?WXRvSlNWSEpmT3lZbUFRUFhJcFdOclhBaE1tOHRvQ2dhYWU4YzJVOVJyc3M1?=
 =?utf-8?B?aXFOaW1TbVlPY0l4cE9oNUZGd2hNUExncE51a1ErVmdCeFlDZFBHSDZkOE92?=
 =?utf-8?B?TlRlcDFmOExxb29zNHNaK1p4S0NleUpxVHlzeCtQRDFOY2F0RTZUUVIzUFkz?=
 =?utf-8?B?MzJzMytseEFOMWpjU3N2dFZKeW5FQndwZ01zbitZYlBHZmp0c0h5ZUxJTi9C?=
 =?utf-8?B?Ym1IeXhLK3FOVEtnTDBmK2Y1Z0dGd1R1ZnlqL0FCRDQwdXpiZ01nNjIxOGNr?=
 =?utf-8?B?QmFVcjZ6ejBrVUlIRm9NVzc5NENCTnJiV3g2V2ExUGhmYVFDK1k2K0VxZklY?=
 =?utf-8?B?TlZ2SFpDZDhVYjh5UnNzWDJTWGxZK0x0M0wvUHlTVUFkR0lnRExnQ3crT21R?=
 =?utf-8?B?RitDSDVwQitGZ3puT3VvbmxBVGVRTVNmTzdBYmkzQmhrZlNtUUl5Vnd4aFA2?=
 =?utf-8?B?bW82VTVIUXplbGNMUndvSlVSYnJtK01uUmw2b1Q5bmczcGM3NkZKL21XMWlD?=
 =?utf-8?B?WXZEYU5IaVZGN0dBZnB1QStiS2EyeFdVQnBwaVdVb1pwYUNVQTUzQ3dmeFph?=
 =?utf-8?B?eVdmRXVtNU5KTjFuK1hJdUF2OVBaaW5kcnp6YmNmQkhEMUhsRDBkaUVKYTFU?=
 =?utf-8?B?TnVZZE1TQWNxaG9rdEVDcHluUU1FVmZsc0lNUGJSb1RuOWI0Ukc2MXJCM2FU?=
 =?utf-8?B?eE92WGFxbG0xQ0F6ZFhmeWhseEhhd3NaUGRZcjZGZlBodDZlR09CeHVUQnZy?=
 =?utf-8?B?SUM2cE8yalhxTzE1ZVBKV1VNT2pEajNycG0wRTRCZjBDdEloSXJNcU9mQlM4?=
 =?utf-8?B?RzZmdTVwOEZGbFVBbENMcityUzVFcDFsTkk0RjZPYUsvVitlM3pOaWRNSW1D?=
 =?utf-8?B?ck5keVNUaEE5ZW81QVRhVGJ1TXZ5S0N1dS8yYld5d2hRMmVqcG03KzVWaTZv?=
 =?utf-8?B?b2d5L3pvcGMweHVPeFBqd1lzWllRVENxWHJ4Yy9IMUxBNGliS0dWK0diS3lX?=
 =?utf-8?B?TFV3YVNGOVNQMVlIc3JZTHVKKzBDcVdXMGZqZWEvOWxrWEJ3Z0h3djdLR3ZX?=
 =?utf-8?B?Q09KMjZIMDhhNnZNRllHYStJbmVicXFWZFMrYlZqY2hMaUl0L09uRThpeW1r?=
 =?utf-8?B?QzdKVUFNcFFSY0tqZlVkaDN1Wk9VZnVMb1N0Wmd1dVN3cHZ0Yy9ySzJEaTBN?=
 =?utf-8?B?aGVBZGpPbVNoYjNoeHlNYy82eWFnR0xRTWVmREVBdDdJVFJ4Q0FzcitBbE1y?=
 =?utf-8?B?ZlZySEZhU3kxNGdQdHcydmNibGNSZ0h6eE5kQzJRTnVqNmxTSWNCQ1NkMnIy?=
 =?utf-8?B?aXNRUGdWZmgyNmo0L0NLRlBXS2FkcVJtWGJWN01ob3BoMDBVQy9oN0orSnN6?=
 =?utf-8?B?TFJQYXdvaGorbDZZQTluVWFxWG9xVmF5TU1BN081dmI5VS9SNlhjSnNDNzhM?=
 =?utf-8?B?aXY4SUxQZE1EOFBPVWRNa2drZVlVSHMrUjlLbjFnMTZ5NmNaN2VxSFVYbmJo?=
 =?utf-8?B?bURSSFNsUnFYb25wWVBESnRVZmdoNzh0b3NqeEllZkZPbTM2NFllSWJBSFBX?=
 =?utf-8?B?NTczeVpXZEd6NGs0Umg1SjYvSzlqWGVrUEpFb25OYkoyaTJwUzFrUFRaZ1g5?=
 =?utf-8?B?RWQyQjBVQVExNXhoQk9WZ3AxR0xGR0FGUitrM1h3YnBsTVV4UVY5cmpyWGY1?=
 =?utf-8?B?eEkvZktpUlZId3ZhSWgwaTVjcnBKMWRJaktobi82aVFvQSsybWloTG5QMDk5?=
 =?utf-8?B?eVJ1N2FRTGZTWTkyQmJKZXRLZ2YydnM1Q3hJN0krZkZNWmphOERLTlJScnY4?=
 =?utf-8?Q?pX4Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3954663f-1cfc-41c3-727f-08dc3c32a513
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 10:05:39.9646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qDeLKIDQuaKZQorLwmPHWwIwoqr1qC+qFOo9Jd9SVL1bKLhhStnrfLQOBE1XY01
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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

Am 01.03.24 um 21:17 schrieb Sharma, Shashank:
>
> On 01/03/2024 14:29, Christian König wrote:
>>
>>
>> Am 01.03.24 um 12:07 schrieb Shashank Sharma:
>>> The idea behind this patch is to delay the freeing of PT entry objects
>>> until the TLB flush is done.
>>>
>>> This patch:
>>> - Adds a tlb_flush_waitlist which will keep the objects that need to be
>>>    freed after tlb_flush
>>> - Adds PT entries in this list in amdgpu_vm_pt_free_dfs, instead of 
>>> freeing
>>>    them immediately.
>>> - Exports function amdgpu_vm_pt_free to be called dircetly.
>>> - Adds a 'force' input bool to amdgpu_vm_pt_free_dfs to differentiate
>>>    between immediate freeing of the BOs (like from
>>>    amdgpu_vm_pt_free_root) vs delayed freeing.
>>>
>>> V2: rebase
>>> V4: (Christian)
>>>      - add only locked PTEs entries in TLB flush waitlist.
>>>      - do not create a separate function for list flush.
>>>      - do not create a new lock for TLB flush.
>>>      - there is no need to wait on tlb_flush_fence exclusively.
>>>
>>> Cc: Christian König <Christian.Koenig@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Felix Kuehling <felix.kuehling@amd.com>
>>> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 10 ++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  4 ++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 21 ++++++++++++++-------
>>>   3 files changed, 28 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 310aae6fb49b..94581a1fe34f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -990,11 +990,20 @@ int amdgpu_vm_update_range(struct 
>>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>         /* Prepare a TLB flush fence to be attached to PTs */
>>>       if (!unlocked && params.needs_flush && vm->is_compute_context) {
>>> +        struct amdgpu_vm_bo_base *entry, *next;
>>> +
>>>           amdgpu_vm_tlb_fence_create(adev, vm, fence);
>>>             /* Makes sure no PD/PT is freed before the flush */
>>>           dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>>>                      DMA_RESV_USAGE_BOOKKEEP);
>>> +
>>> +        if (list_empty(&vm->tlb_flush_waitlist))
>>> +            goto error_unlock;
>>> +
>>> +        /* Now actually free the waitlist */
>>> +        list_for_each_entry_safe(entry, next, 
>>> &vm->tlb_flush_waitlist, vm_status)
>>> +            amdgpu_vm_pt_free(entry);
>>
>> This needs to be outside of the "if". We also need to free the 
>> PDs/PTs in non compute VMs.
>
>
> Noted,
>
>>
>>>       }
>>>     error_unlock:
>>> @@ -2214,6 +2223,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>>> struct amdgpu_vm *vm,
>>>       INIT_LIST_HEAD(&vm->pt_freed);
>>>       INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>>>       INIT_KFIFO(vm->faults);
>>> +    INIT_LIST_HEAD(&vm->tlb_flush_waitlist);
>>>         r = amdgpu_seq64_alloc(adev, &vm->tlb_seq_va, 
>>> &vm->tlb_seq_cpu_addr);
>>>       if (r)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 298f604b8e5f..ba374c2c61bd 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -343,6 +343,9 @@ struct amdgpu_vm {
>>>       uint64_t        *tlb_seq_cpu_addr;
>>>       uint64_t        tlb_fence_context;
>>>   +    /* temporary storage of PT BOs until the TLB flush */
>>> +    struct list_head    tlb_flush_waitlist;
>>> +
>>>       atomic64_t        kfd_last_flushed_seq;
>>>         /* How many times we had to re-generate the page tables */
>>> @@ -545,6 +548,7 @@ int amdgpu_vm_ptes_update(struct 
>>> amdgpu_vm_update_params *params,
>>>                 uint64_t start, uint64_t end,
>>>                 uint64_t dst, uint64_t flags);
>>>   void amdgpu_vm_pt_free_work(struct work_struct *work);
>>> +void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry);
>>>     #if defined(CONFIG_DEBUG_FS)
>>>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct 
>>> seq_file *m);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> index 95dc0afdaffb..cb14e5686c0f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> @@ -636,7 +636,7 @@ static int amdgpu_vm_pt_alloc(struct 
>>> amdgpu_device *adev,
>>>    *
>>>    * @entry: PDE to free
>>>    */
>>> -static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>>> +void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>>>   {
>>>       struct amdgpu_bo *shadow;
>>>   @@ -685,13 +685,15 @@ void amdgpu_vm_pt_free_work(struct 
>>> work_struct *work)
>>>    * @vm: amdgpu vm structure
>>>    * @start: optional cursor where to start freeing PDs/PTs
>>>    * @unlocked: vm resv unlock status
>>> + * @force: force free all PDs/PTs without waiting for TLB flush
>>>    *
>>>    * Free the page directory or page table level and all sub levels.
>>>    */
>>>   static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>>>                     struct amdgpu_vm *vm,
>>>                     struct amdgpu_vm_pt_cursor *start,
>>> -                  bool unlocked)
>>> +                  bool unlocked,
>>> +                  bool force)
>>>   {
>>>       struct amdgpu_vm_pt_cursor cursor;
>>>       struct amdgpu_vm_bo_base *entry;
>>> @@ -708,11 +710,15 @@ static void amdgpu_vm_pt_free_dfs(struct 
>>> amdgpu_device *adev,
>>>           return;
>>>       }
>>>   -    for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>>> -        amdgpu_vm_pt_free(entry);
>>> +    for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry) {
>>> +        if (!force)
>>> +            list_move(&entry->vm_status, &vm->tlb_flush_waitlist);
>>> +        else
>>> +            amdgpu_vm_pt_free(entry);
>>> +    }
>>>         if (start)
>>> -        amdgpu_vm_pt_free(start->entry);
>>> +        list_move(&start->entry->vm_status, &vm->tlb_flush_waitlist);
>>>   }
>>
>> The complexity inside amdgpu_vm_pt_free_dfs() really starts to make 
>> no sense any more.
>>
>> First of all ditch the usage in amdgpu_vm_pt_free_root(). Instead 
>> just inline the call to for_each_amdgpu_vm_pt_dfs_safe() to free up 
>> all of the page tables immediately.
>
>
> Noted,
>
>>
>> Then the other use case in amdgpu_vm_ptes_update():
>>
>> /* Make sure previous mapping is freed */
>> if (cursor.entry->bo) {
>>     params->table_freed = true;
>>     amdgpu_vm_pt_free_dfs(adev, params->vm, &cursor, params->unlocked);
>> }
>>
>> We should basically change params->table_freed into a list_head and 
>> put all to be freed entries on there. Something like that:
>>
>> spin_lock(&vm->status_lock);
>> for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>>     list_move(&entry->vm_status, &params->table_freed);
>> spin_unlock(&vm->status_lock);
>>
>> And then finally in amdgpu_vm_update_range() we should call 
>> amdgpu_vm_pt_free_dfs() to really free up all PDs/PTs (probably 
>> rename the function while at it).
>
> - in amdgpu_vm_pt_free_dfs, there are two different lists for locked 
> and unlocked PT entries
>
>   unlocked is saved in vm->pt_freed
>
>   locked is freed immediately, which we now want to add into another 
> list  (params->table_freed in your suggestion) and free after tlb_flush
>
>  which means we have to do something like this:
>
> in amdgpu_vm_ptes_update {
>
>  /* Make sure previous mapping is freed */
> if (cursor.entry->bo) {
>
>     for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>
>     if (unlocked) {
>
>         list_move(&entry->vm_status, &vm->pt_free);
>
>     else
>         list_move(&entry->vm_status, &params->table_freed);

No, here just move everything to params->tables_freed as necessary.

>
> }
>
> }
>
> and then we have to change the amdgpu_vm_pt_free_dfs() implementation 
> to simply free BOs, not searching anything like:
>
> if (unlocked) {

And then do here a list_splice() to move everything from tables_freed to 
pt_free.

>
>     schedule_work(pt_free_work)
>
> } else {
>
>    list_for_each(params->table_freed)
>
>     amdgpu_vm_pt_free(entry)
>
> }
>
> and then we would be able to call amdgpu_vm_pt_free_dfs() from 
> amdgpu_vm_update_range().
>
> Does that sound good to you ?

Very close, I just want to avoid any extra unlocked handling in the low 
level PTE update function.

Essentially we only record which PDs/PTs to free in there because we 
have a cursor at the right location in that moment.

The state machine itself is something I try to keep out of the PTE 
update code.

Regards,
Christian.

>
> - Shashank
>
>
>> Regards,
>> Christian.
>>
>>>     /**
>>> @@ -724,7 +730,7 @@ static void amdgpu_vm_pt_free_dfs(struct 
>>> amdgpu_device *adev,
>>>    */
>>>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct 
>>> amdgpu_vm *vm)
>>>   {
>>> -    amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>>> +    amdgpu_vm_pt_free_dfs(adev, vm, NULL, false, true);
>>>   }
>>>     /**
>>> @@ -1059,7 +1065,8 @@ int amdgpu_vm_ptes_update(struct 
>>> amdgpu_vm_update_params *params,
>>>                       params->needs_flush = true;
>>>                       amdgpu_vm_pt_free_dfs(adev, params->vm,
>>>                                     &cursor,
>>> -                                  params->unlocked);
>>> +                                  params->unlocked,
>>> +                                  false);
>>>                   }
>>>                   amdgpu_vm_pt_next(adev, &cursor);
>>>               }
>>

