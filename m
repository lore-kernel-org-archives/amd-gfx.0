Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43421C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 13:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFBF31129EA;
	Thu,  2 Jun 2022 13:46:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC77F1129F0
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 13:46:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSZfFNiftkdNlYUObq7bP/jhLk35P9+9aAMqhq4+otF/DfYQ5ZwcLwAoySNQP3V5Cz27IrdDTLEuERwW01C3f1RXHsuEN9lfHpnXf0JpQ4ILKTPjnfGO4jBsQNcyu29qV3Q7UNNmL9ic/qgTjrEvxP84LDDD8g/JIhY370VTm1c06Eof/oVrJkg/yPJRB4ynAeDyJ2KxEc91GNEJWYs7YT+0cGFG9/mvP+FilSHK5gcMZ7yDHelfxCOPqZg1I0GsdrgFdUEAjN7I22vhvkOxRLnsREy6KNz81maC71tjU92PwR6HsYOeP3SDv9cRvcMmeNBECBIBC9rP+aL0HjPpwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zPWkGKaHbyfYb4YNdnOn8f3NirEzIb7GwQk3jvHd+0=;
 b=MdrbD5iPlH17lW4kHv/+Q0tSpJYUrMx1ogYuQn4s1wAIwKetwAXM2TmJBoAVAwrYOamHWEWTE0JI6NP5MmBCOfggaBb9Gs4dmzy3BbaTz/hxKc6qbGMroGlEEUsZgSHcXyAaQzXO3gluXvt1GdDvCfsT9Jz6vahdEtcBzA9/EgJuBzKBmEuRpnVPtRNTId4sjzgYolabSGFFOmoObtqmJ6RjicGaseBH2N0GMI1B93sGgqG9R5BDGddBYBpc8RmfqcFYQ0mGImtUi3ap/tpUzfqlqyd++ko/+d5Fz7MU0qKuTfFSvfKRq8rNeDXLt28Ds+cIqUvmK69MXL1FqsSP0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zPWkGKaHbyfYb4YNdnOn8f3NirEzIb7GwQk3jvHd+0=;
 b=46P1zxmha59qZcTNfiE6CG3HC8ryRs91NZNqIseke8EmCvBBXAehGH6FA/d79XW3vLCzlLCaHMVWIZu71RUX88O8GBNnt9Di/lBTJii5QnMBg5eGnd2hpoQ3xURL50Id2b7aVSuSAAzM51j2tB+XAhHsKiYkH2mB5wFORpqbhvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 13:46:12 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 13:46:12 +0000
Message-ID: <f58157f0-ea9b-270f-0176-e5af391c983a@amd.com>
Date: Thu, 2 Jun 2022 15:46:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/1] drm/amdgpu: Update PDEs flush TLB if PTB/PDB moved
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220602132029.6225-1-Philip.Yang@amd.com>
 <60a9c99f-5a19-fd31-d4f5-ccf81717e3e2@amd.com>
 <cf5e5888-3857-9e23-e202-1e274ba690d4@amd.com>
 <912af5b5-219d-b104-76fc-52b3c9e89979@amd.com>
 <0b8999ec-7bd3-930f-1fc7-80826d155d41@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <0b8999ec-7bd3-930f-1fc7-80826d155d41@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR04CA0033.eurprd04.prod.outlook.com
 (2603:10a6:20b:46a::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed59bdcc-a3ce-4ce1-ec75-08da449e4194
X-MS-TrafficTypeDiagnostic: BY5PR12MB4161:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4161A845AF1BAEAAA156EB2983DE9@BY5PR12MB4161.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jauYdICArfzaDVVv3jpgq7LdS/jPXWuCAFzMWusuhI9H1Vxv4c57p+ov94SVlE/pxobZJoYF4MDiJzjiMXzim3A+J8Ng8bLKm/lwer0y4pKa1qI1+0fqs4gAXPIdBmsEjyR2gL032vDU0pXNYcmCjVhYa7A+dQQikUeKEf9Q0O+KcXVmdkL4u0UWz4xOM1RH9Cz68zJRgG57zZWlQnBAa0tVPmuNEXA5BJgRbqLZTob3iAuXOC/JrwaCQGMUN5BCikpKF0EnpSImpOplWCLPXUwC9FjqQ79MzR89qKUfEPxRu4gZJ1akAy1HY+e7qNiSIZwqG+Y591bqCEytOtxIznFFXEOBXT8l9iod1Up2Mno/VJ/u9pokMgxAbHWZnjir7pv155CXXnGEAPeD0uzSAWcOhQFT9IWfr6wUVdRYvaHM/c17XG4e8+TWfz5tunWKPDA/AN3LwVtDxH2YGWXKruIqXkOeZ5L3ZZqUcSeFFJe8t+3BUqC5M3Ls0711UhyeazVBFf7opHtgdZZIs5sHNsUQ3PWhd5I+fJQ+efapwPvzkMd/dDtVUn4Myftg0fbuA20XjUVjws673V4vWNoPRgARvcHpRD+6OBbtJVij+TZx5wmHuXAlFwwoEP0bZLBMmrD4T/hUNubYFfhB08j+dBpM3l5MG7ejsmeOSgc4EpzjZ4IpUfibdaU9CuYZ5X9vzslDbHFxmSf9bWJXgB2/B9Lg2XyIDCw8G5LRHh5mIdEb3cz6eVc1f3elmt24H/cq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66574015)(316002)(83380400001)(2906002)(186003)(2616005)(36756003)(15650500001)(8936002)(66946007)(66556008)(66476007)(6486002)(53546011)(6512007)(86362001)(31686004)(8676002)(6666004)(5660300002)(31696002)(6506007)(26005)(110136005)(38100700002)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0tqZ1AwWE1VNS9tQmthMzRzUUlvTW1HK3Q2blFpY00raFc1STJZaTRwNExV?=
 =?utf-8?B?WDZBVGNSeXpIcExxMmRabHVlMThLOVJna0JmcmlXMzdURmxzaEZ1YTUxT3dq?=
 =?utf-8?B?U3FkY2p0VDJwYVptTjJKRkRPcDcra2JkMGtTcjZjOTZuMGplbzBOMHo0aUJO?=
 =?utf-8?B?ajhwYTlZZzNiZzBMenA3SDQ2M3pGQlVna3dEcUJCc1FiMk9XbitRRXk0UHIy?=
 =?utf-8?B?MEw0WkJwemo2bnNyZUhrT3NTUkhqc1NYNlloenZ5ZVNoY25kUVZ1QWtGajdN?=
 =?utf-8?B?NHR3aHFma0M0Y1JxRnF3M29HZW9xSEo2bWpDWHpHMGlLaTdIRUhZd3dleDNW?=
 =?utf-8?B?Q1hNdlBmVTVSSmNUQm54akwzVndNMzhiSkVtVkk5ZnZEZm9hWU9TYUhmZmMz?=
 =?utf-8?B?Z25ZRDU4dXRGbGh6WjFRZTM2NngyZFA2SXRiN2Y1a2ErMXkwWCtaRHByOUY1?=
 =?utf-8?B?aEhsWlRaMUtnaUJHSlQ2UHRPNW9LUHc2YzFTSTBqRGRneGtqUVhTdzN0Ty9h?=
 =?utf-8?B?eG42L1lhdDJrZ3RsWjdLYU8rYVJ1NTE4amNKT0VNSS9yOHpLVWx0NitVTWVB?=
 =?utf-8?B?MjJDQkg5Vk5wdmNCT2I4VjNwK2w0cEdjMENnVXMvUnNLT3M3NXRRNzYyalhF?=
 =?utf-8?B?U1VFVlpWbEJQVk9Ga3BUaFI5aloyaFFPUG5ScGM5U0xOWjhQRll2Z1JqNndr?=
 =?utf-8?B?K1FyellQdVRaTzVxRlJ1ajNycWNoemw4RlhtUUtObWZxTXVuZmJzM0hmNGly?=
 =?utf-8?B?amptRFZCcCtORGpMRkJiOGtFN0VtWlArZ2xCK1hOenVuZXQ1T3M5eXZqSVhp?=
 =?utf-8?B?YVFoSTUrQ2k0Q2NidStML3JLaTcyMlBkWHBpV2I1ZThtS0dEWUVUbXRRUlFo?=
 =?utf-8?B?ZWhCOWVFQjNOTURmaDkxYXoveHprOFVsMVZqbWIyNmhybnN3aE1PQ0FsK1h4?=
 =?utf-8?B?Q3ZCdys1bDhJb2YyQjdRNkxuNVJpVmdWSSs0Tk1yVkJRVEFDeVFYZUZjeG05?=
 =?utf-8?B?c3I0MmVZcGRMMW9tRC9ad24rd0dJelhBR2VXL3JZN1dwTnhCQ0xhWGppc3li?=
 =?utf-8?B?UnJENXJRV2VscDY2dCtPUEtSdHVGdndTOHc0TGtpRUNKaFB4Wk1iTW40YVda?=
 =?utf-8?B?Z3ZmcGdTUFd2SlR5ZUd0T1ViY2haak13cWhnWTFhOWNmV3RnWkJqWUJWTGhY?=
 =?utf-8?B?K2hWcGR6UWMvSlFiQXU5NFhFUUVsREVUbUZUUERyYkhKa3Q4Tk14SEVSZlcz?=
 =?utf-8?B?VEJMOUttUERTQkttRWdlZFlFendwcC9yS1ZDcTZSMVFUbzI4ZVpZbUN3MC93?=
 =?utf-8?B?Zm5udWNIVUhReCt2MUQycU1kMWYyZThKOTZZMUExaDRkdVVMQkVMOCtQMk82?=
 =?utf-8?B?MHV3SE9rS1EvTlh1YXovT1lHTDFCaXJ0Wm42WDJLVjlNbkFxUUxQdGozK2Rv?=
 =?utf-8?B?WU9kQmJMNlA4YUI3dGh2SEdnTnF2TUJSRmNBWlp1Z0VXUVhFOW0xMVZUY3F3?=
 =?utf-8?B?RkpsbHIxeEFjQTRuRmxZQ2h0UlFrRzBKSGZJdXVuMENRNEpYc0l3eDRpazk1?=
 =?utf-8?B?bTBZZUN0eDZRUCtaTVB0ZmZpYkxKdjNrenExcE8zTVF6Z2hDSGRoQzlKNTVw?=
 =?utf-8?B?TkFpRW5nZkVVWVhBMjNoZWJMbWRreG5FdlNOMnJWWHhjcUtJcmtwVkZlTjFt?=
 =?utf-8?B?K1U4UWZubVNBSkZHWFFEVVIzTXVBOTgwajdQeFFKYk1LK0RFUDd5UC92TzJ3?=
 =?utf-8?B?U3FReEZFdW1rUDVBMmxsbzZUK0NEKzZPcFhqdytIL0VwVEsremJvd0FQdlMw?=
 =?utf-8?B?ODRVOHN3M1RZMFF2eGVlNk5PZHIwK2UrL3RvVkRXd0d3WFVMai9UcEFIVzVD?=
 =?utf-8?B?UXpBa0g2T2dSNmtSZlJVOFV2SU5kSG5OdlJmUXNwTlZkYzIwNzAxRC8rZG5V?=
 =?utf-8?B?V1pSeWpPVE82dUcraTNhWlZNdXh0NWdWbWpkQzJXVFk2WVAxSjdIeFdRY3hD?=
 =?utf-8?B?b2c0TENtSHFnZ0prNUFrNWV4MFVCUGg0RWZiL1MxYTVRQ1BkeDNyZVg2a2l3?=
 =?utf-8?B?L013Sk5SWWkxZVNtKys4ZklaZm5IQ0hrMUx2VTZNd0NOWVZ6WFFXemxOMTVM?=
 =?utf-8?B?YmwvUTcveFpDRlVxdUFwSEdCNmxjbkMzNXdmbW9TeW1qNHBQNFgzQVJJNDI2?=
 =?utf-8?B?QjBRNEoxMDlVNTJxbFlxdHljUGkzT2YxT1BlT0VFTm03VEJsR0tpT2tBU0g0?=
 =?utf-8?B?QW9FQjhoWlFHSWIvcmwxQkNKU1NuajlDdE1yUkxFUjNlQmRHNlNIOW5KdHZl?=
 =?utf-8?B?L0RRTjJ2dGQvb1Q5N05XUjFFM1F6ZlZvM1dpQkk2U3RraU5hNHpadz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed59bdcc-a3ce-4ce1-ec75-08da449e4194
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 13:46:12.4334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFsESIwGXuJVCQ/XwyE5opVMvmevzC6IJWomxt5I/Y8NrsLVLhIIOl7G8DA5oSa9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161
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

Am 02.06.22 um 15:44 schrieb Lazar, Lijo:
>
>
> On 6/2/2022 7:06 PM, Christian König wrote:
>> Am 02.06.22 um 15:26 schrieb Lazar, Lijo:
>>>
>>>
>>> On 6/2/2022 6:54 PM, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 6/2/2022 6:50 PM, Philip Yang wrote:
>>>>> Flush TLBs when existing PDEs are updated because a PTB or PDB moved,
>>>>> but avoids unnecessary TLB flushes when new PDBs or PTBs are added to
>>>>> the page table, which commonly happens when memory is mapped for the
>>>>> first time.
>>>>>
>>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++--
>>>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> index 9596c22fded6..1ea204218903 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> @@ -737,6 +737,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device 
>>>>> *adev,
>>>>>   {
>>>>>       struct amdgpu_vm_update_params params;
>>>>>       struct amdgpu_vm_bo_base *entry;
>>>>> +    bool flush_tlb_needed = false;
>>>>>       int r, idx;
>>>>>       if (list_empty(&vm->relocated))
>>>>> @@ -755,6 +756,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device 
>>>>> *adev,
>>>>>           goto error;
>>>>>       list_for_each_entry(entry, &vm->relocated, vm_status) {
>>>>> +        /* vm_flush_needed after updating moved PDEs */
>>>>> +        flush_tlb_needed |= entry->moved;
>>>>
>>>> That is a strange thing to do for a bool variable. Why not just 
>>>> assign it?
>>>>
>>>
>>> Hmm.. In a loop, perhaps you meant logical OR?
>>
>> Well IIRC C doesn't have a logical or assignment operator "||=", so 
>> "|=" is used instead which also gets the job done.
>>
>
> var = var || value;  also will work.
>
> BTW, v1 of this patch was incrementing vm->tlb_seq for every entry 
> moved. This one increments only once. So is this vm->tlb_seq required 
> only to be a bool?

No, it is required to only increment once. It's a sequence number and 
changing it signals that a TLB flush is necessary.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> Christian.
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> +
>>>>>           r = amdgpu_vm_pde_update(&params, entry);
>>>>>           if (r)
>>>>>               goto error;
>>>>> @@ -764,8 +768,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device 
>>>>> *adev,
>>>>>       if (r)
>>>>>           goto error;
>>>>> -    /* vm_flush_needed after updating PDEs */
>>>>> -    atomic64_inc(&vm->tlb_seq);
>>>>> +    if (flush_tlb_needed)
>>>>> +        atomic64_inc(&vm->tlb_seq);
>>>>>       while (!list_empty(&vm->relocated)) {
>>>>>           entry = list_first_entry(&vm->relocated,
>>>>>
>>

