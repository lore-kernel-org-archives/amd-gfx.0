Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227C0CD6E7B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 19:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA79911AAD8;
	Fri,  5 Jun 2026 19:21:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I7NDiSnn";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F55011AAD8
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 19:21:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqmaCaebeyGswgu7m1cO69X9kfindqrcrAyV93iXl+k85apx3rkDMXQ1AZqnn7AyGxh3y3zQ9qTVaYIf6CefM/9vZSKra03ieqi3JcSlueyO/yszluYSxZwNN2YR75JMjTwB5dCEr66/jqBhySk8mpJG0fDb2lYsWNCSDAN0UaplzIYorrZX+yBpfxbfLvI7gkJPLRIrQ2h7QNVmvzqqhGSF9RrCTfqtKveKRL6Gv8TCg7czSs1AWjx/J1NtLpp7wbc3sQsSzvJ9b3XnqM3W3HyQQawT5OeLXOCnVB6eJeEjGO331fRGveBPauqpX5ebemty48TECZ6ctQoU2L4B5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z45dLvJO2/wCyoHHhLPhp5PeAVZFj4NUeEQW3j4XPWE=;
 b=y7v3OBiu/InnpKc3SFYOJ3VGrqYdFCuvyTsg9I1Z4DcoZ9yEFMCVU1GDLgUhKsaDv5C48x+OVQqoZZgB7caZnfMr3ZKwwcdQ/OEZKC2ylhyMh/UUP7oOLwpe12xHhhhRB9lBTdm+4ysUo4Jg06I7N/JGRhnhUjd7R5G7GG/C8nVbsYs+keCl55CT3cPSOIGkaAgng2YaDrsRnsvHM3Y4XGw6z2bdlZLp+GF38Prf+0q4STXc7P8n+YpQqmHPea2pH8lTjhyb5ZqSmKYFlHr0gg9KM773fC2Ho7tjyiAkYJrHscKtzxSEPGsOlBd7uVHJ7K9puwj9XrHt23GeGIyI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z45dLvJO2/wCyoHHhLPhp5PeAVZFj4NUeEQW3j4XPWE=;
 b=I7NDiSnnK/6AN6l0o127LRGGNczj1+V9XGUKAZ37XTSCL+6rkNOTPlKbdEyngNAOa8IDCkIuiMQgT0p70ErSk2QeHCFETEaWerQTVpyZDF4CyfOeWIjwmEP0iVrM9/MB7fMsMF7aVsOL6KfEPq9jOr9G8eIUL0Lje1t6cXhMLY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) by
 CH2PR12MB9519.namprd12.prod.outlook.com (2603:10b6:610:27c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 19:21:49 +0000
Received: from DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c]) by DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 19:21:48 +0000
Message-ID: <bf6f98fe-3301-400b-8c3e-3918d63fcfa8@amd.com>
Date: Fri, 5 Jun 2026 15:21:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] drm/amdgpu: split amdgpu_vm_update_range
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-9-christian.koenig@amd.com>
 <4644fc6d-81cb-48d0-b899-a9a4ec4caf46@amd.com>
 <fcb12fbc-8629-4867-befa-17009d2e37a2@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <fcb12fbc-8629-4867-befa-17009d2e37a2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::9) To DS4PR12MB9612.namprd12.prod.outlook.com
 (2603:10b6:8:278::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9612:EE_|CH2PR12MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5edc34-2f0b-425d-3015-08dec337b08a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|4143699003|5023799004|11063799006|56012099006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fs5Mlwe427BHuS0wvyPON0u/P25vIUz6R47YyJkDVwJSJx/7lWwwCMwnQK900fWgVb0So3EAJ17cJCZqdRvDiGiIetUBPb5pqCAQKMrXWYMHmrCtNqkUvZW5waoNXPe/PP0h4PS71wYdrpxO2/P5RWxJ46oa4WCxJa4RfJ8eFU3z8j+Dv7dtrmIs/khngZ/u0Uz9IEK4pM3+/7/133wllywIURzyhs3Yp3tP35NAoTkIqrCTrs+Awl29upa3X7O5D9ZKhMsvyvnMihMu1NyrXXaSmlZYMDl7Dq4OCaPPamD6UGRg+01O1spljDQUY5yqwXIyFRuaWwzt7ma2Bof4aKdvf3brk8SSUGIR/94YjMWcEPlMY94VFkB0PhpRKfa5u7djgwJxNcHghOgY6SHCWUTvUrQPM+pr80kTx9dXH539bCe0dg2EnSF9vh9j5S/sonZ+xVFloTh3zCKSk7/lt+vTZn5ltf2rCbniSVHpOUrGNdpqJw5kj8fwJY4WJMj6Fn/VqzFZS54i0TAQsCoIT9TzLzrYcjaBqqfh+xeBvM1Mm5squIbYFSk6MxyajHMd76Sm46Cb5KNvw4SiWsS0akevVup5MNEWMhztAeufrceBr+txytNZugwJl1GjcpvXzRaULwxir6dZzuzMVPyAEqfDLNjp5U1o0EjUzdp2C+DakAY+3M9cq/lEyB4wzDLa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR12MB9612.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(5023799004)(11063799006)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUtYN2ptQUxRZnhCaFNsVzZsLy9TdFhNZ0FhSGt5M0o1YTlYQlhBa2tVdWxE?=
 =?utf-8?B?bDlsa3JDU1dVd2pMcExYZVhnanFQQlhyeFBNYWZQRXVHelJzZDlsbHlZelhy?=
 =?utf-8?B?Y2lSQkNWVnBJOXBYbXZaT2RjU0xXYndyNy8yR1UwZDZMWTZjRE1RS3lmTFBF?=
 =?utf-8?B?UzZURkRvMXRseTNtU2t4K3BUSGczdThZTXpleTA0cE5RZ05MQUF1OWJmZ2Fi?=
 =?utf-8?B?NDJlU0FzVjVGWDlaNDA3OXZwSWhWVll1NWRKT3NKS3BOelpxUGUyUVpQVTk1?=
 =?utf-8?B?UkpkQlgvaGx3N2cxQmk2aGxOMndlbkNZd3V1UnNWbWRPaGlkT1JtYjdLcjhO?=
 =?utf-8?B?dkpoK0l5YnZEbnJqZWdKMnV4QmRGTllHaUtpaVVDelExcm9WU3FoYVpGaWRK?=
 =?utf-8?B?OGFHZnlmUDNtcEFsRWhISHBZc2R1RGdUTFhidDdFSmEzOXMwWW5PSWp6TkZB?=
 =?utf-8?B?ejhEVWpZRDVqeFgwK21FVHV0OFlzN2d2ZVJERjh1RHk0OFBIQUNramgrME00?=
 =?utf-8?B?dm1RejBOcmFVaVBXS0JURTVkQzl6N3hZU1ROQVBhT1AyYVZ2bHBrRzV2YzFP?=
 =?utf-8?B?djByZ3lMMmx0VVdSckVxYll0b3hoOHA2dU5CU2Zmck9OR2pFeVFDTURCVmpk?=
 =?utf-8?B?QmRtWmU1TUxMeGR5OXpHaVpMWWllSlJBZzZyOG9kN1NyK0J1YjN3WCswQnpS?=
 =?utf-8?B?Z1ZkUDZ6ZEFpT3ZTQVpuUFFxdEJwMDNDNVQ4d3FPamtYZHlJOVN1dmtibEpr?=
 =?utf-8?B?dDdJaG9QTDFCSUpGOWFwYmFOcW53aVYyYUpaeVc1azZVTU9TOXVVakp2aXdV?=
 =?utf-8?B?ZU1pMVFCclMyN2N5aVBWYlRDMktEZDFiQlJ0d3JXL0o1TGdRdm1odmlaV0t5?=
 =?utf-8?B?a1BybXcvU1gzWTdYQU9CK1VOcE1YNlk1Y2pOcEx3dWwxL3FoTStYb016TStr?=
 =?utf-8?B?ZzU0VjRPbjQ3eGNQVTZGYS9nd2FkNlpsbEFOUHI4RlZOL0pNWmEwWlpWMHRE?=
 =?utf-8?B?NHFTZnRyN09LSDl6cTJ1SlRlUVNlRTNqYXhiZGppOThZd25mbVdBM3Q3R25u?=
 =?utf-8?B?OHk1TGFOd3NxN0VWWDFlY09VOGMzbDJiR2VxQW1uS0FSZ2RDSEFiRTF2QVZW?=
 =?utf-8?B?eHBRc2hRUWhhTFU2WTNEcmN1UTdDbGFoNzYxRHp5VEFZeVpsc1hURmtlaDU1?=
 =?utf-8?B?OHRFb2JpQmQvSDQ5MXoveUJ4Mk1jYitIUXpsVFFaMXFQZ3hRTVlxenZrYWFC?=
 =?utf-8?B?RWVZNWxLSVRoSE5iWUxxS3FZTUdWZFk2M2cyVUg2cXRsR1VLcU4zOHY0WmFa?=
 =?utf-8?B?MS9BYmhpWFUrRTh2Z1hvU2dvS0tSbEQybXBmVTg5SEdtS3NJanlhQ1JJSGli?=
 =?utf-8?B?RkpiUWNiVWV6TW9MTGZNVEc0VXlKSGFYMGVlUThmSVNsN2ZlelJaMzdnWE43?=
 =?utf-8?B?ckVqbTcxU1lrV0k0SytxS2FHUW56QnZCbGdUNGpDT0ZIUmdoVU82bVp6RmY0?=
 =?utf-8?B?elMyMjdzYmhHc2Fzd0FURi9VZkFURExyb1N3aXRYeXh5T1RhVHVhbVpET1R0?=
 =?utf-8?B?eG1zVUZuY0ZUbzNKaHdyazJja2M2OXdkem9QYXZKbVE5THFwb2hGVkpEaUdK?=
 =?utf-8?B?OWpZSXBkQ281cnFHMmxUSEJ6VWU1TUQrUy9nekxpYks0V1BGWC9vdGpNYStq?=
 =?utf-8?B?eGZESjdqM0M4WE5hbWZVaXljUkhBRW1ZL245aXFBY2V5TEFXYWQvcTNuMkY3?=
 =?utf-8?B?OUljNEdqOFJRWnVNVGZiZmdhR0xqUzEzOHkxVGZ3QlNpVHBDZ2VYZWp4VFFq?=
 =?utf-8?B?a3E3TStYVEpxRmJSRGpKVlFBQWpTWmVHOTRkLzVIODkvQjlTVUpWR2dPQUNr?=
 =?utf-8?B?OVdwMTUvaDFkRTNNSVdxN3lTTHhUR2JoVEE3VGxPU0w3UGl5ZnhDdGJIaVVF?=
 =?utf-8?B?WVJ0c1N3N3hiZmsvbnQ4b2NzQy9yREs2WlIyaTkwY1ZoazFGQi9wZXJIcGFN?=
 =?utf-8?B?TFY0aXJQbEQ4SmNGV3o1K0xnOGlJTk9aeVNOOE53MGJkWGpXNDFpcTRPYnky?=
 =?utf-8?B?WHJsd2RmWmsvTUQyV3RoSHAzaE5CN0ZuYmF3WGk2SjB4dkxxR1Z0NlhYbkR2?=
 =?utf-8?B?Vnp1cmxHLzdpdmM4ZzgyTnUxYXUvZm9UWUd1RjhtUG5TUzRnTDVZYjFNWGlR?=
 =?utf-8?B?cHNWYy9qNlN0ZzVkWXZZZWg3bFozN1FtWWdNaXdEdnBNNWo5TDFnWHRwRmJk?=
 =?utf-8?B?T29pdEJkSWlXcEt2VlhMaUVXOVJmdlVENmdkRzM5Sko1WWx1VGcxRUJ2Z2FS?=
 =?utf-8?B?S1BsdFhRWlJtVUt2a3FnQ2Zaa09TWDliSE01Q2dkaEI5SnBUQ1Ztdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5edc34-2f0b-425d-3015-08dec337b08a
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9612.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 19:21:48.7697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qg1Zx533ORTjltSNaDwlarPu2YIbU4wE5d71OvvK7pvi9OAjqg7u2norAUBV/18j//t0Dc4uhhO7MSW9Knf+8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9519
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


On 2026-06-05 05:21, Christian König wrote:
> On 6/3/26 19:54, Kuehling, Felix wrote:
> ...
>>> +    r = vm->update_funcs->prepare(&params, sync,
>>> +                      AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE);
>>> +    if (r)
>>> +        goto error_free;
>>> +
>>> +    amdgpu_vm_update_leaves(&params, start, last, 0, flags);
>>> +
>>> +    r = vm->update_funcs->commit(&params, fence);
>>> +    if (r)
>>> +        goto error_free;
>> So this wraps amdgpu_vm_update_leaves with all the stuff that's necessary to actually execute the page table update.
> Yes, exactly that.
>
>> I don't understand how amdgpu_vm_update_leaves works without this when you call it directly from amdgpu_vm_handle_fault (in patch 6).
> It does mostly the same, but not 100%.
>
>> Shouldn't you use amdgpu_vm_unmap_range there instead?
> No, the main difference is that calling amdgpu_vm_update_leaves() from the fault handler needs to bypass the normal sequencial handling of VM updates.
>
> Background is that this is a band aid for a dma_fence based submission to avoid a full GPU lockup and instead just continue even when the rendering is incorrect.

I'm still missing something. amdgpu_vm_unmap_range calls 
vm->update_funcs->prepare, and vm->update_funcs->commit. 
amdgpu_vm_update_leaves doesn't. Neither does amdgpu_vm_handle_fault. So 
how do you e.g. create and submit an SDMA job for the page table update 
in the VM fault handler?

Or is this only meant to work with CPU page table updates? But then 
you're still missing some synchronization and HDP flushing if you never 
call prepare and commit.

Regards,
   Felix


>
>> And if that's true, then maybe you can use the name amdgpu_vm_update_leaves for this instead.
> I'm certainly open for better naming.
>
> Maybe we should call the function in amdgpu_vm_pt.c amdgpu_vm_pt_update_leaves() and the higher level function in amdgpu_vm.c just amdgpu_vm_update_leaves() ?
>
> Thanks for the review,
> Christian.
>
>
>> Regards,
>>    Felix
>>
>>
>>> +
>>> +    amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
>>> +    amdgpu_vm_pt_free_list(adev, &params);
>>> +    tlb_cb = NULL;
>>> +
>>> +error_free:
>>> +    kfree(tlb_cb);
>>> +    amdgpu_vm_eviction_unlock(vm);
>>> +    drm_dev_exit(idx);
>>> +    return r;
>>> +}
>>> +
>>>    void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>>>                  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
>>>    {
>>> @@ -1362,11 +1434,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>>>              trace_amdgpu_vm_bo_update(mapping);
>>>    -        r = amdgpu_vm_update_range(adev, vm, false, flush_tlb,
>>> -                       !uncached, &sync, mapping->start,
>>> -                       mapping->last, update_flags,
>>> -                       mapping->offset, vram_base, mem,
>>> -                       pages_addr, last_update);
>>> +        r = amdgpu_vm_map_range(adev, vm, flush_tlb, !uncached, &sync,
>>> +                    mapping->start, mapping->last,
>>> +                    update_flags, mapping->offset,
>>> +                    vram_base, mem, pages_addr,
>>> +                    last_update);
>>>            if (r)
>>>                goto error_free;
>>>        }
>>> @@ -1565,9 +1637,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>>>                struct amdgpu_bo_va_mapping, list);
>>>            list_del(&mapping->list);
>>>    -        r = amdgpu_vm_update_range(adev, vm, false, true, false,
>>> -                       &sync, mapping->start, mapping->last,
>>> -                       0, 0, 0, NULL, NULL, &f);
>>> +        r = amdgpu_vm_map_range(adev, vm, true, false,
>>> +                    &sync, mapping->start, mapping->last,
>>> +                    0, 0, 0, NULL, NULL, &f);
>>>            amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>>            if (r) {
>>>                dma_fence_put(f);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 3e86a2a470f0..561f2873d2ec 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -529,12 +529,16 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
>>>                    uint32_t xcc_mask);
>>>    void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>>>                    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
>>> -int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>> -               bool unlocked, bool flush_tlb, bool allow_override,
>>> +int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>> +            bool flush_tlb, bool allow_override,
>>> +            struct amdgpu_sync *sync, uint64_t start,
>>> +            uint64_t last, uint64_t flags, uint64_t offset,
>>> +            uint64_t vram_base, struct ttm_resource *res,
>>> +            dma_addr_t *pages_addr, struct dma_fence **fence);
>>> +int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>                   struct amdgpu_sync *sync, uint64_t start,
>>> -               uint64_t last, uint64_t flags, uint64_t offset,
>>> -               uint64_t vram_base, struct ttm_resource *res,
>>> -               dma_addr_t *pages_addr, struct dma_fence **fence);
>>> +               uint64_t last, uint64_t flags,
>>> +               struct dma_fence **fence);
>>>    int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>>>                struct amdgpu_bo_va *bo_va,
>>>                bool clear);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> index 6f5415d5a1bc..ac3f3e31e2e2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> @@ -553,7 +553,6 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>>>                    struct amdgpu_vm_update_params *params)
>>>    {
>>>        struct amdgpu_vm_bo_base *entry, *next;
>>> -    bool unlocked = params->unlocked;
>>>          if (list_empty(&params->tlb_flush_waitlist))
>>>            return;
>>> @@ -561,7 +560,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>>>        /*
>>>         * unlocked unmap clear page table leaves, warning to free the page entry.
>>>         */
>>> -    WARN_ON(unlocked);
>>> +    WARN_ON(params->unlocked);
>>>          list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status)
>>>            amdgpu_vm_pt_free(entry);
>>> @@ -801,24 +800,17 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>>>            uint64_t incr, entry_end, pe_start;
>>>            struct amdgpu_bo *pt;
>>>    -        if (!params->unlocked) {
>>> -            /* make sure that the page tables covering the
>>> -             * address range are actually allocated
>>> -             */
>>> -            r = amdgpu_vm_pt_alloc(params->adev, params->vm,
>>> -                           &cursor);
>>> -            if (r)
>>> -                return r;
>>> -        }
>>> +        /* make sure that the page tables covering the
>>> +         * address range are actually allocated
>>> +         */
>>> +        r = amdgpu_vm_pt_alloc(params->adev, params->vm, &cursor);
>>> +        if (r)
>>> +            return r;
>>>              shift = amdgpu_vm_pt_level_shift(adev, cursor.level);
>>>            parent_shift = amdgpu_vm_pt_level_shift(adev, cursor.level - 1);
>>> -        if (params->unlocked) {
>>> -            /* Unlocked updates are only allowed on the leaves */
>>> -            if (amdgpu_vm_pt_descendant(adev, &cursor))
>>> -                continue;
>>> -        } else if (adev->asic_type < CHIP_VEGA10 &&
>>> -               (flags & AMDGPU_PTE_VALID)) {
>>> +        if (adev->asic_type < CHIP_VEGA10 &&
>>> +            (flags & AMDGPU_PTE_VALID)) {
>>>                /* No huge page support before GMC v9 */
>>>                if (cursor.level != AMDGPU_VM_PTB) {
>>>                    if (!amdgpu_vm_pt_descendant(adev, &cursor))
>>> @@ -864,14 +856,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>>>            mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
>>>            pe_start = ((cursor.pfn >> shift) & mask) * 8;
>>>    -        if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
>>> -            /*
>>> -             * MMU notifier callback unlocked unmap huge page, leave is PDE entry,
>>> -             * only clear one entry. Next entry search again for PDE or PTE leave.
>>> -             */
>>> -            entry_end = 1ULL << shift;
>>> -        else
>>> -            entry_end = ((uint64_t)mask + 1) << shift;
>>> +        entry_end = ((uint64_t)mask + 1) << shift;
>>>            entry_end += cursor.pfn & ~(entry_end - 1);
>>>            entry_end = min(entry_end, end);
>>>    diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 37b5166e9a14..d0ea20dea3e1 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1372,9 +1372,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>            return -EINVAL;
>>>        }
>>>    -    return amdgpu_vm_update_range(adev, vm, true, true, false, NULL, gpu_start,
>>> -                      gpu_end, init_pte_value, 0, 0, NULL, NULL,
>>> -                      fence);
>>> +    return amdgpu_vm_unmap_range(adev, vm, NULL, gpu_start, gpu_end,
>>> +                     init_pte_value, fence);
>>>    }
>>>      static int
>>> @@ -1489,12 +1488,11 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>>>                 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
>>>                 pte_flags);
>>>    -        r = amdgpu_vm_update_range(adev, vm, false, flush_tlb, true,
>>> -                       NULL, gpu_start, gpu_end,
>>> -                       pte_flags,
>>> -                       (last_start - prange->start) << PAGE_SHIFT,
>>> -                       bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
>>> -                       NULL, dma_addr, &vm->last_update);
>>> +        r = amdgpu_vm_map_range(adev, vm, flush_tlb, true, NULL,
>>> +                    gpu_start, gpu_end, pte_flags,
>>> +                    (last_start - prange->start) << PAGE_SHIFT,
>>> +                    bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
>>> +                    NULL, dma_addr, &vm->last_update);
>>>              for (j = last_start - prange->start; j <= i; j++)
>>>                dma_addr[j] |= last_domain;
