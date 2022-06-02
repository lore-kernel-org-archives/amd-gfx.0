Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952B2C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 06:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287EA10E1E2;
	Thu,  2 Jun 2022 06:53:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3780510E1E2
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 06:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lf181OlzZXL/7FYZtrOsDvOfccRxhShOXrnqC/qv8UiMeKuY5D6Wf0FmNmJj8PcnRXMr4i8oddpgVlv/TSf1i3mgX0s7FguapJU5ABsAer9uAgqSB7qsn/ou1YuiOFVMH+57DqQ0dbrWVnKVVeYs4DGXrU6k8VDttegr/6z8W4gBhu7HX281GhkT0m4VWvLuj4C++Dj3PGoLlWXy+n9lMKHVDdvLiic/50Va970HBhy4odLyEW6/CMO7VYqfp0Q/qGuKfgAi46ONrrifSVCML57y6WweYV+acD1zUo5RrQ7VEHdvOUAjSyfhXl6GC5i44j3f6bLtwDGmeKCO0WReaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIXsYfB8ETfV3EFksdq9WjPJfmag7pIgCTpjeSXDB/8=;
 b=XuogwQKAA4k4IOEDqi0qhijGubZKNisCvbWrMeIvqvkn3KDdPgIWPs1N8AaJLFyn4A0wJbkwMBgQMnPC+pJbqzMhtgIsbwYtEDVuVLhJ3/tCujmZ6NIPms7YoLQSX9/cmSxBy9G38KHGwlFcJlN1a76mYlgIvMSkn6HeoPzoQ+ZvWFM2bMSqGram7p0jepGd6C4SFYIYrEtj3hzLcwi3bsn4IFfVyrisyb+dvf+M8Ddrcnh4CHylrBuKmqdkvxCLB4ivLeXs49wAKKGwVcgv1dK/zfY12G2u+UIjwyvkKA7YZ7k9BIB8rqgHAKo6XxZ3SGXmifOa9z3H3+tVysAGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIXsYfB8ETfV3EFksdq9WjPJfmag7pIgCTpjeSXDB/8=;
 b=h3/3oCEVjhn1zDl4EDGMU5Dr7SvkTt/nE/HXboj2/5Tc42GeBuECXzPdvMNdSL3oq1+xAFbN2UDWpelXfSNmxjAZiNdHorDlO0XY8O09YxHsiat9SLUzbHHh3VKSUB6elnUUfS+SdYIa/yQfxuKj0ERb1Thr45SFsrxCajJ4Tqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 06:53:41 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 06:53:41 +0000
Message-ID: <da5c31ab-cd62-42e5-bad6-366a1eb348ad@amd.com>
Date: Thu, 2 Jun 2022 08:53:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] drm/amdgpu: Update PDEs flush TLB if PDEs is moved
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220601231246.28716-1-Philip.Yang@amd.com>
 <0795b580-c16a-f269-aa17-23db915b654a@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <0795b580-c16a-f269-aa17-23db915b654a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0196.eurprd06.prod.outlook.com
 (2603:10a6:20b:45d::22) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 870c79aa-9540-40ca-c725-08da4464a0dd
X-MS-TrafficTypeDiagnostic: CH0PR12MB5372:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB53729670DDF3B5A82D1FE5BB83DE9@CH0PR12MB5372.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2JpHXAK754QPz0L0jys1K2E+QDF7Z+wkgZNmQyXYqAI/zxKptAZ67jND6GKiEFkyv8nG+VZugAlGY+0ctyY3UW4fMeYZ+wVfGxAiFeNHlwfFVs7+TNucOGAZ2U2a9hevj77Z5WV89IxCTYB1HQLOahoL/DdZUgLdw/XgVQdbz9P+tkGESzoqbmorw1DHcgLoItoJKmfTtZfGkJ5Bc8jGlGR9jHI2vrH2F2SvJZXGiSovMGSskxG8xIX0yRnH+thTFaYR+Yb4hMs6qBHbDKLgB5gUzub6G9K5tHsPfUgU1qUR9tRK7D2hVi2rhbR7TFvrof1/AS/TBLboutFm2XOREk9cp/T2N4QOKSwWcypsJbUvgnaHLZcd47WBLyUfSaaTCRaB4jsz32FipiYfVmW1QzgNsSVl05/gqNGIXp9pFkn/rNYFm2oT3I5vGcbm9yF+5+/fmcJ2y+8Of7xTax8Kd7QmDyJFL6dQw0yQ2o/DKmnP2r5RO4WLqBWo0iUHfxnxh+CA/0yAGSr4wjNjwO8pdJk33ocnVU7wVHUUzseRLSmD3zBsSU9C2Fa4UH3aw+x6RihAD0NYT2/Rtr4mHWuswxTOMIqvdEq3hTZTpcemJ153VEDxjxoyCPx3ZfghlNryDSpuM4xJSjkyIYt8IK7IMQjrR66oDU8PUkkjjxC8OmATx7LeUtdPihfcNBEkzVzEEqaXCorntgvM7s2yr3Tum870rXuVSePZHKvXfs0RWQnJqPc19VRUF2T42dEsI8zQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(86362001)(66574015)(186003)(83380400001)(38100700002)(2616005)(316002)(5660300002)(110136005)(31686004)(8936002)(66476007)(8676002)(66556008)(66946007)(6666004)(2906002)(26005)(6512007)(6506007)(6486002)(15650500001)(508600001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFVObUFSQ0FKSzJpVStRL1lkeUpoTjFyRDV3c3JXanphWndUWHdVZW9WdHdS?=
 =?utf-8?B?WDVsbHUvWHVIVW5DVG1GM2MzOG4xYlBIV3ArWVlBaENsMDVLSnJmZms2Skhi?=
 =?utf-8?B?ak54Rjd2RVdraHBFdEJWZEZXOWtZN2VpWisxNUNhczEvd0F1RHhiODYwNGR6?=
 =?utf-8?B?WWpaeGUvUFg4SHQzd3J0dG5BeGZFUkJrN2l3UGdxWlFucGZBUVJvQnkzcHpJ?=
 =?utf-8?B?emlFbXVCMVl6bXZqazF2bWNVdnpOeHR6eWpwWTZJNUpnMDY1cGVmQVZqTnF4?=
 =?utf-8?B?bHovbWpDRmIrSGtkK2MrZU5hWnpnZngxVFVsSXkyeXNNZG1JUVlBN3gveENw?=
 =?utf-8?B?N01iSXpkWTJwVW9NNmJ6SjNuQUZrbmw4ckFxeTd2TnFMN1VqNG44N2VPbHY3?=
 =?utf-8?B?dWpYWW1IUVVCdWQ5bEtjS2I4UGpxRjNsRk45TTJJRE1yaEpRdjRKRTNiZkdS?=
 =?utf-8?B?bmh2MXU4ZzZVaEdiU1A2aElXckRSRlorNVdLcFRtNUpDVTRLbG91YTNCM0Vk?=
 =?utf-8?B?WU1HdXl3MHcxMGdNWnFsMm1zb1VtQm9vaFpZVlZpb2lEbjJSZnJ4b3F6cXI0?=
 =?utf-8?B?R0xZVGdhV0ZLNTFZakR4OUloNFY4NXBiU0VLVk4xa05HNHZySmJVRGNUa09Q?=
 =?utf-8?B?ZlpxMDV2eWdtMmtVQU5SbHBsT3h0UWtac1JIdk9MNHU0OWlFUTlpWkNwSWY1?=
 =?utf-8?B?cGg5bzRYdlh2blFuTmNCOFk1Z051RzIrWTY4Qk5KZmc0eDZhbm5HbHZUR1ho?=
 =?utf-8?B?NTdhcktJdkRDcWEwekpKRHY0N0ZPbW1JMW1UUWZxekRGaWNzdi9JbU5xZ2R5?=
 =?utf-8?B?RHlNWnAzYWxLRWVKdlViZHVuMGdRYzYvSjEvWURTNWVjalNYT0x0OXZnNmkw?=
 =?utf-8?B?ck1CaGkzeWp4bUYzeEpJVEdraWRaK3B1N0FIOVNJd0V5d2FUSjNtZW41eGZ2?=
 =?utf-8?B?K1VuSlpYN3Zvb2RNOSswTzRuakhYa0RDakNhZmUvZGRyQ0ZUQktoZm1XOU5W?=
 =?utf-8?B?RDlUdE82emNKV0JOVFVrTFZIMU1QbVRab0MrQXQrQTNKTDE4WDBIUFJxZWww?=
 =?utf-8?B?ZWh3N1VaZm5wZExlRTQ3aGRIYzM0RGtQb1F3T1U4djAyMURJNHdLRjVuZGE2?=
 =?utf-8?B?Q25hQ1I0bEtyakhpQmZ2dkRUb0pJUjFiaGxYYkhuaGQvbU5Cb1FnZUtNZy9C?=
 =?utf-8?B?UVdyNUF6QjE3blpJVjNyTkNMdHdSNjdEWjRwTDd3L1JkU1ZJTXd4eW1NQk1E?=
 =?utf-8?B?bkxFUDl6WTJwUUxYM3FkYUZxV2F6a1R0M3AxZVFPU0JnQjlJTzlmN3J5RzVG?=
 =?utf-8?B?dWdQSG1MaTFlOWttSTF6Nk5BMzRkWnplaGtKTmRzekJlZUdla3dNTVpTWWNr?=
 =?utf-8?B?YWVXZ1NMUUhwNEVkYWFKNkRrcEd2RHFoRG5LSHNUb0tNbFltRnJLR1h2TDEv?=
 =?utf-8?B?d1AxYVB2SWJzc0VNVlVkKzUzRnZ2MHRnK0NydWtJS2lJODJlSTFzeGVNT0dp?=
 =?utf-8?B?dExFU3lTbjQrL2ZvdU8raWZ5QjJLVjU0UVhaYnVaU0xuekY4SUZXT3BXZllv?=
 =?utf-8?B?R1BTQStsbW1HMnRLUmJBM29wWC92NHFsOGFPNmdVaDJ5eDBXTFM4OW9DNFdj?=
 =?utf-8?B?VC9IWUoxSmhyRGtWTkJCYklPYmZPQkcyYXhrdmswakR1NHlBQUZEQkxwRnBQ?=
 =?utf-8?B?Y0Fnd3Bpa3RqSk53NnUrdFg5dDQzVmpidlEweGpSU0Z5cCtpYnVGUFVzRDl6?=
 =?utf-8?B?QXRYSzVBdnZGWUttUWhxTUZYYXZjaUw1dWUxem9WeWU5RXllK1l6VGswR1dG?=
 =?utf-8?B?dzlPWjdEY01hdTh4QVJkOGN1MTA0N1ZDdEJKcjdQYXJzT2NtR0pIVUJlOEFq?=
 =?utf-8?B?RExZL1dQaWFmQUp5VzhrRzBZRzg5N3dCVldCU1pMdlpKdkN6STE1bnp5QjI0?=
 =?utf-8?B?L2VTcHRJR2VCVy9TNEt5ZDZ0SG50STR6bGZFd0duY0M5bEVKRURzTk5ZL3lE?=
 =?utf-8?B?WUtmNDQ5aHIxbUpweW5pZjhLSmRUOFFoK1RoRWJhRGxJUTFCY284Z1Z0M0Iv?=
 =?utf-8?B?MzY0SjBLb0R1WXFrN1hvdzNtMW5RUEhVcm5UcVVpOXVraXFQWVBzbnBrT0No?=
 =?utf-8?B?RUZzaXZkcGQwd3FjVHhKL0dBK1dCb1dZY1RTYUpLV1VkWXlmMUpweW5wZUpl?=
 =?utf-8?B?QmcwbUVwOEg3Q0xMSTJFallOT2FXbVEwUjRNOHhxeTBseVhDV0tuVU50djZM?=
 =?utf-8?B?LzhSRmdPNzhsdmRENTNTKzZrcnB4ZHN6cGNkZG5FOU44eXhSMzF3eVlaNFNQ?=
 =?utf-8?B?M1kwbEtJbzI1TEM5clF3WHF6N2VLK3l5RDgxY25aOUFtUW80SWlBQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870c79aa-9540-40ca-c725-08da4464a0dd
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 06:53:41.4684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1ZGQl+HNSZ4EccHvPDoDl7QmNVHgGuBWsiTc2OltljPwaz01GOH0T4o1FrsJoXE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5372
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

Am 02.06.22 um 01:19 schrieb Felix Kuehling:
> Am 2022-06-01 um 19:12 schrieb Philip Yang:
>> Update PDEs, PTEs don't need flush TLB after updating mapping, this will
>> remove the unnecessary TLB flush to reduce map to GPUs time.
>
> This description is unclear. I think what this change does is, flush 
> TLBs when existing PDEs are updated (because a PTB or PDB moved). But 
> it avoids unnecessary TLB flushes when new PDBs or PTBs are added to 
> the page table, which commonly happens when memory is mapped for the 
> first time.

Yes, agree. Additional to that (I know reviewing my own suggestion) 
setting a local variable and then incrementing the atomic only once 
might be better because atomics are barriers on x86.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 9596c22fded6..8cdfd09fd70d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -755,6 +755,10 @@ int amdgpu_vm_update_pdes(struct amdgpu_device 
>> *adev,
>>           goto error;
>>         list_for_each_entry(entry, &vm->relocated, vm_status) {
>> +        /* vm_flush_needed after updating moved PDEs */
>> +        if (entry->moved)
>> +            atomic64_inc(&vm->tlb_seq);
>> +
>>           r = amdgpu_vm_pde_update(&params, entry);
>>           if (r)
>>               goto error;
>> @@ -764,9 +768,6 @@ int amdgpu_vm_update_pdes(struct amdgpu_device 
>> *adev,
>>       if (r)
>>           goto error;
>>   -    /* vm_flush_needed after updating PDEs */
>> -    atomic64_inc(&vm->tlb_seq);
>> -
>>       while (!list_empty(&vm->relocated)) {
>>           entry = list_first_entry(&vm->relocated,
>>                        struct amdgpu_vm_bo_base,

