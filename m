Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0397CC54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 20:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9779E10ECE7;
	Wed, 20 Mar 2024 20:21:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cLpNs7bb";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A417C10ECE7
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 20:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/XYl7/r+W6WEib0FHSYZ1lktnrAso/wWL5mUX4FtbcDq2hD/NWnSqdgQWG4QEebzLy7ffgOoWw+vsHjtbe/ZSRf6lBicgWgjitZG8tmQLUWkrdI6rkyAGMI+sjSQ1+b0VwUQ4pGnT+T/fbrbljQ9T9RMh85Rg9uY266aaKrT4EUQcHGWeVJSftqjn/rly6uX+HqNuGrXG9WB/RYXayfyrzXRMBjDoMeVAIruXpMIJ1xeMftC2zW8KmHSJ8D0uz4DYiYGxvage0U2EOIyDutXAI6s5J+5f140x9UurBMTGCwzWQic0/Ir/4+Nu8bV4+Vfq0RxQpzVvXJZgmdMUOdvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8FYeuJ8gVPiYT6P/FIxJsROQC+ziQu0/cYD06UX+aU=;
 b=XT7sLi9qKWCmn1yey0rU+OSOAcGSV3XEo0GRVtyhWklIaNd8l7yVy3G7TTdacwKmsQslOcv9cWQE0NayKFeKbhw0bTzPOT2pm4jsx9j/7ItupEFWl7LjE21RUgoOSD5Fo0SvDU8fEls04haHmjCyM64Lq844Wm73I9RYn2DKb95dGZpkeTudWdll9vADQf58FDs1bxOqiWibE7yGtGLNX2/3/P5Y20RQMiYtWJTwEbwiYA7dsRKSqUS1L+CiQ7c6BxMU4+/S1Ho2i9r2OJQivF86Q+89dq6V2HmfLLakmWu0ZjC9PW/mXK7DRYZvHL3/RQ9a8t3wmuyqX+OV04e3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8FYeuJ8gVPiYT6P/FIxJsROQC+ziQu0/cYD06UX+aU=;
 b=cLpNs7bbDZAvo5XDK3O77fa/QRnzEJgt6JA5/m9Ukj5VNF6xPHZq0l117XHplDqfW5QGqDWJ835yXiCBhp5d/AUPv5RqzyMeA++oy4Qjs0otWABSWi9G7NFarf2tqSOFR1CoqaZELxH7cjXUUNDSQ0o9mf/mfHWBA484WzvC9lU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6627.namprd12.prod.outlook.com (2603:10b6:208:3a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 20:21:46 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 20:21:45 +0000
Message-ID: <7e4eb11f-feea-46ab-902f-891f1e15e58b@amd.com>
Date: Wed, 20 Mar 2024 16:21:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Check cgroup when returning DMABuf info
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240315181756.685335-1-mukul.joshi@amd.com>
 <48148998-5124-4a66-8d1a-767d94f6c284@amd.com>
In-Reply-To: <48148998-5124-4a66-8d1a-767d94f6c284@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0308.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: afcd39fe-5c6c-406b-b4dc-08dc491b5ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bH9LT+m7+Zz2q1R3lrQCsQTquFUDM7TNthMXxWb7APPx/RqEtvcQzYTQMftMP3j/DELqEHVUvvuOnNdubSLtNATdlA5qXP+MF1LdYrL+CUqZ+AbpcwUuE3zq8A12qfXq14XTA8k6WkIkTT6Peb07l0ht89qkdAW6U51dObec778OODkyH/yyss3xCUUzb7x0q3pFMoBBojQo229q7sVstcIJE0kJPWbdXGS6xVJhCKLmZFME1noFHtCoXqXBccEL6zGQH990IVk8wv0YfG/hjzE/PeT+yApiGdL/Y04rSPjb+IGVzdkAoje8T5Op7vS4nw98rqE+C5J+1/VHTAmZVxlNVn1hH0U5tueFvBa23OqDtlG5zz6EDGmE7+6nLR22TsG9prfCjVtu94CPxYoSupF/78MXG0zh5nmD5qwbNCWubwqwOGOw7646eJk6/BP1CCF6QxfpY5sEyqCPoF0FPKEkVYdnNdycFdTJ7ScXkuGHysfUC8wk7WGzg3fK5LLyZpvdj08GG+UBrOEqd90DcW0Hp6bxUEO5B/rzp6iq41DtZY6F4ZpNAyJQTU5TwXkDASURFxbDlfcJP9ESsLCc4nnw0M7bHkmVPcbKKbJotCCkeKZMXE+mpVaPstZzIOFprXMLGzXatOdCiO/74iJa222Nd0uG359riinJjeIFB4U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0dOWk03RWtQeUVnQVdkSlkvN3dvUVdZd2hsVzRPWk9kb3RRZEdBNkxlQ2Nk?=
 =?utf-8?B?YTFTUlljaXhjdktXQ3duSDZUSVQvMkp2dklGaitiYUQzQm9BUUwrbFhaMFdx?=
 =?utf-8?B?TnhELzh4ampubXhoblp0ckczS0pDWHdNNlhacnZFR2NTbmk1NUpackowTkVZ?=
 =?utf-8?B?VnNRNWErYW9HZFFJZTJEVGxCc3k1ODByWUVPVENmMExVY0hGUko3dFo0dEJQ?=
 =?utf-8?B?dlF6RTY5M2E5T0d0VG5RWTAxSGpzL2R5c3JxdWFkaFBmMVdlQ2UrQnl0TjVh?=
 =?utf-8?B?NlVYWENiRmh6OUpSOWg2bitZUVNNamNyZE0zQ29lNVV5cVNmRWdtWm40b29j?=
 =?utf-8?B?b1J2T0wzTVlTK2sranhsbXZrL0NiQjVGUVFqUmg3MmlCOFVqZUFsVWhjNkxN?=
 =?utf-8?B?RlV0aFdsWXBRdlRPajh5by8yNzVrdVpzRnJSeWhDUFRpeitQQUJsdFFMN053?=
 =?utf-8?B?cnJyVWp2dm5VdjB5cDUrWVpZdzkyTkU1SHBvL0FPTjUxUHdJM1pOM2hUVUVH?=
 =?utf-8?B?dTYzSlJNblB6ckl3YTlPTmlLVUowZURaa25JY3h2NnE1UDBMdFB0RWdrSG9v?=
 =?utf-8?B?KzlJMXNsNU1rV0FXYzBDRWE3SWUwV3d4UkVIcHkvQ1M4RGNrOVgwK2tlOFpW?=
 =?utf-8?B?ajFvYm9BK1R5cG9MMnpvNE5YVEhYejRHZkVjaTFOZWhkdXN4YzNCTUlhVEFG?=
 =?utf-8?B?c2NaaFpsbzBPM1g0RkJiZEVnSCtVUmVaVCt0aVlYc09mcDAxaDVLdG9xaVA2?=
 =?utf-8?B?ckxOWkV5VkR6RDdycTdSQytBSFhlVkx2dEF4TzZwbDN0eWxoOHRrMGJ3Z3NU?=
 =?utf-8?B?UWc1clA0MEVncDhCVFdBOXVMTU1KUEdrREkzck1PaFJsK1ZpVEhTaHZGMEVP?=
 =?utf-8?B?RlhmemFQZk9HNVgya1d5NWJHOFhNSGtNVU5JdlZIZEMxRkZXVVU3U3pINXg3?=
 =?utf-8?B?VnZkM0FtekJ6YjNTdHZiR2Z0OWhSanZQU0VaWXh4Ym9PQUFKbjZ4aXovTmNO?=
 =?utf-8?B?S2p5TE96MlcvaHVXVjYxNTR6YmZjYUpKcmtQQWh1eTBqSSs0QmtPQW1MS2hH?=
 =?utf-8?B?OE56YmdrMjVnZ2lKS09IcTMrTlFZMlFTSjROY1I5ZzNiZWtTNklYYjdhdHBx?=
 =?utf-8?B?WkNVVVpkUzBPZThnWUZqdzFXSmM4YzRkVVVrV0tIdmVKcitYNE4reXIzSFZp?=
 =?utf-8?B?T0c1NkMzVnlGa1hpWlRuVldNeG1rcFAxWHI1K3c4REFpVE9jeVhERUJOcXJx?=
 =?utf-8?B?ME15SXo2bkFNR0FacmtubWl1VzdoYlJENFQ5bDR2dWpRLzRyTUlwWjdLZVpk?=
 =?utf-8?B?anNsWnNvTitnTENoUlI5MUZtcEdSZTl2ci9VTzBzSlNPK0Nqdkh2N05QOFI1?=
 =?utf-8?B?NkNDWHA4U2FYV1k0Sk5UTFRSY1dsbi85Rm9CdG1ReDRFNnh1dHAzT0ZiUTRI?=
 =?utf-8?B?NVhmTkNpdUxhTjBRMmdtcEdJWTR2cjlrRXJ3Q1cwc0tpa3ovU1pxMkk4dGd6?=
 =?utf-8?B?WGsvQTVMMWZQbW5CdTNYVEN6MXlNaWRRcWJscG00VG1kZXN4dTRBZm52WEF3?=
 =?utf-8?B?WThvQjl1TnFyZWtpb01ONHNRUDZqZ2xpM09tSng5UHloejZZbGI2Wkk3MHJB?=
 =?utf-8?B?RVV2MnJyRmRuQzVHYlM1aFJvTUhiaDlWbkJBalI0aGUxcStFeXNaMEZCRXFl?=
 =?utf-8?B?NFVEUW9NSnhNSTJwOFl4N2s1ZFo4RzhkSEFrWDZZbnR4RnFJN2t6TWlIb1R4?=
 =?utf-8?B?SWRZeDFqMXZHUGJ0OVVsU0xUNSs5Ym9IUTFQWDZ2YlZZVVVrSnB6TjFXVDBB?=
 =?utf-8?B?TTlzZmkwRmtoS3duNlZTaXpMVUwwbWNKdThPRjF1TC83R2VIVUZEbEZFQ3dC?=
 =?utf-8?B?TmJNUSt2YXRHSStzcjdKak5LUk5TSVRaTzZydmgvM0dHTnBwVjlRTFRONjhl?=
 =?utf-8?B?ZEtMWDZnZTNMakZ2SEZ1UUt6b2w5dGtLamVacElxbUdXWFZNMzJxcmlUYjl5?=
 =?utf-8?B?eXBLME92dDFScUp3eDVtUmRNNTVOZnp6WlE3MysyVURROHQ1ck9FK2VvemNQ?=
 =?utf-8?B?VWJjQ3dDR25ESTVnUzIrVE5xUmRlOW5jb3BVeFc1QTlib1JaWHRKN2ZxWDRh?=
 =?utf-8?Q?zqDkH0/46Kd3vBgEk0oSzh6C2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afcd39fe-5c6c-406b-b4dc-08dc491b5ccb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 20:21:45.0705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJiVi71U9m2S/WTewY5VFU0QlCWGWYLsN9bQDxPo3ow807uJ2Q6ZAZ0U7hMZKUhMbpV5vb+qbtbdAeDjWY6/Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6627
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

On 2024-03-18 16:12, Felix Kuehling wrote:
>
> On 2024-03-15 14:17, Mukul Joshi wrote:
>> Check cgroup permissions when returning DMA-buf info and
>> based on cgroup check return the id of the GPU that has
>> access to the BO.
>>
>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index dfa8c69532d4..f9631f4b1a02 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1523,7 +1523,7 @@ static int kfd_ioctl_get_dmabuf_info(struct 
>> file *filep,
>>         /* Find a KFD GPU device that supports the get_dmabuf_info 
>> query */
>>       for (i = 0; kfd_topology_enum_kfd_devices(i, &dev) == 0; i++)
>> -        if (dev)
>> +        if (dev && !kfd_devcgroup_check_permission(dev))
>>               break;
>>       if (!dev)
>>           return -EINVAL;
>> @@ -1545,7 +1545,7 @@ static int kfd_ioctl_get_dmabuf_info(struct 
>> file *filep,
>>       if (xcp_id >= 0)
>>           args->gpu_id = dmabuf_adev->kfd.dev->nodes[xcp_id]->id;
>>       else
>> -        args->gpu_id = dmabuf_adev->kfd.dev->nodes[0]->id;
>> +        args->gpu_id = dev->id;
>
> If I remember correctly, this was meant as a fallback in case for GTT 
> BOs where the exporting partition wasn't known and the application 
> didn't have access to the first partition. I think the way you wrote 
> this, it could also change the behaviour (report the wrong GPU ID) on 
> single-partition GPUs, which is probably not intended.

Never mind. I double checked: On single-partition GPUs, bo->xcp_id 
always seems to be 0. So your code won't change the behaviour here. The 
patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>



> Maybe this would preserve the behaviour for that case:
>
>     ...
> -    else
> +    else if 
> (!kfd_devcgroup_check_permission(dmabuf_adev->kfd.dev->nodes[0]))
>          args->gpu_id = dmabuf_adev->kfd.dev->nodes[0]->id;
> +    else
> +        args->gpu_id = dev->id;
>
> Or maybe a more general solution would make DMABuf import work when 
> the exporter is really unknown or not even a GPU. This came up not so 
> long ago in the context of interop with 3rd-party devices. This may 
> require user mode changes as well.
>
> Regards,
>   Felix
>
>
>>       args->flags = flags;
>>         /* Copy metadata buffer to user mode */
