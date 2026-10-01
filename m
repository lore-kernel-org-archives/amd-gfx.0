Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D05FCA5FB3
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 06:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0206110E1B9;
	Thu,  1 Oct 2026 06:25:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w88jQZFO";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011004.outbound.protection.outlook.com
 [40.93.194.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD4910E1B9
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 06:25:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPaC4vK13R8t1kMq0py0S7o42Got1o2TQMrwCfqc815FuIvlXGyolavq5iIxMO6FhN1n5hi8CrvJq2tSgvScvar91IUvmR+/SPmw1u30meSe/Na025OanFY98dRBjjXDs4pdQb0M1lLVxeISEvuXJ9OVXTSQIWs5F/hcICLue4IOX2Q2ifAHtBmWMjMpq/RhBMfN5aQUawpEV4nE2Vtfu+sYr4iXlctIoD466gil1uJIx4ZlrMvMG0s8HCKMtqCkUwG0BrHI7B3JB0b3l6d0F45syV4B/ArqfMEb87vB1mSofWOuCu9wYQY+p6BPdxTqWx0ig/PvorY6STvB+X5kKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsMEqhicF4ji3Lj2SEvnfdz5hHCH2WcDaRi7m1PCAEU=;
 b=p2cyTK7SqfbrpYQu0cxlCTJ8lYgPYMFiHhITG0w151PA/KxTO6NF6+tGz6TQZSjEth25P1OKftEF30Xwyauvatlowpsx0txVzy2ICVVk+TV/KizPZi+fEjF0aWAHk1VAm7Fk8Nf8ZEBdyGh7Cx2MXq1u2/VVr4hgD7zG/Bp41wEtwapsijGHZhG7ZZmbObk9nQ5vl0GWvi+ZHKPAMQJ6WsXfh4CQefKDBkhUBCvd1MR2Kx6cbUuGy80T/4eM+zSNat72NMgziY7NMQ/UdSYy1wqa26IYj4zYxuYE1NmxPm6duVUU/e6OiFO8rGdxiqnHWDFYZO0V5FpKvY0RRfR5jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsMEqhicF4ji3Lj2SEvnfdz5hHCH2WcDaRi7m1PCAEU=;
 b=w88jQZFO/lzmS6tXRGASpXGKiM0vjZWKzPGarAAAk9M884xTrBBa39ViGkiGT4dzcv3ZDknNJ/d9i6Deo16JblEmw/ZL7WyAjoOLrJi4+V7fGxR7+wVUMTlX9ohT9epUnfiKpf8BRmM5oXE+2oSgTnICIQfsqhLr9EbPqhAdv70=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB999251.namprd12.prod.outlook.com (2603:10b6:806:4dd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 06:25:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 06:25:05 +0000
Message-ID: <c5b1322c-7421-4f9d-8fb0-db894de55591@amd.com>
Date: Thu, 1 Oct 2026 08:24:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/amdgpu: fix cleared PDE/PTE flag generation
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Philip.Yang@amd.com, cascardo@igalia.com, tvrtko.ursulin@igalia.com,
 "Joshi, Mukul" <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260928151041.1857-1-christian.koenig@amd.com>
 <20260928151041.1857-2-christian.koenig@amd.com>
 <P3WG6T-ATwauPO6Yp0bWtQ@gmail.com>
 <cd5af67b-d2af-43a5-be86-216155f46ff8@amd.com>
 <7b1ec2f8-0619-4132-ac35-bc2722755b97@amd.com>
 <9b181f91-4de1-4c0d-8a38-dfd75c8eb98c@amd.com>
 <33693b8d-ed0a-4910-af87-eb29e887a1d5@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <33693b8d-ed0a-4910-af87-eb29e887a1d5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB999251:EE_
X-MS-Office365-Filtering-Correlation-Id: e38b6819-0a5f-40f0-26b9-08df1f84bb06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: Hwy/QuSwO/VDYlHz2l4AtmNHcbcGkvAJKq/X2V4u+9M5jxnDejnl49rIBEPLvmZvdveF2yYTkzRh304ponpIwQd1PzDIxL52Fb3Rsmqd46mpS1lF0m5Jkr4XaCqRTNLS29U+cVjpdBb5l0bI46X7oGo11MDKzC4lyV2Cs8aeukbCHMfd8EvoVX+5v6d8XB3kTddIbrJhxcjTZXKjVQ9CsRNrmU6k7eMbuh46sx8rHEvz9tt7FbeRBabwPOsMvaIUgG595kzDpA1N0hr8MC5Q12CLEJSIhODni76HnKNHyZXQhcgL/HVwS11CajM24tObcEJQNkRCFBkGTGoLYXageMRVNNWm8gw2AEkUPcAOdLP0IV33ENK2MtdEZ+hvkRygtDjFMStasslYD5oWdkQpo5SbaLDfDOBYc+p+bKjeDwWxhtqyBlS56/TFdaSYpieAHHk7i9Ok0UGRBQpVsUukCh99KGOG+4X36MHB6wrYTDSkBSBeL83eK2JOKAscPQErpo7MOBtq7FjIilYal0kYUCT+PHGkLdzkaKpleEUy81ZqyTs+3MOI1eMahB1QfYstT7wJp1t4WJwBJAXEl9Ert1AT1Z3bnYnOlKXCAY5CF+vrPsbCYrHEw1/NAlhELmXbV7bBmAaPMjgRCxFIc5yNXxwRqsEWrunPecyj0c43EjyR0nV2hSvS5YpgsXIDbvwS2KEMnRTcvTFf/aorN4eb1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czlKMk9SS3lzRnFpSjdWKy9SUVJHazc1QSthRjZFemdiNU5XSFhiZmtGaWNw?=
 =?utf-8?B?TTdXZUpWbzFQMG54VzIxM2tJMFJObGdYdUZSV0k2YnRWeVBLeUwwbHJwdW0r?=
 =?utf-8?B?bWE4eVZPcDY5UElRVm1yZWRvazRPRHVkWEhXdWY2UkJJQkRuMFUyNHJ3dnRa?=
 =?utf-8?B?WHRvcEx5QXNJVXV1UnJXRVpUdmtxTHNvVXNpc0JFd1pPdzYxMGRFTVB0NDVh?=
 =?utf-8?B?Vkx5RXFXWnB0Y1R0OUdJWU9ucmp0QUNrdUJ1MmdIZWYzNXBYaFF1UXRBWERl?=
 =?utf-8?B?dEVnVGRqQW1LRWpmUytQeUZBVFNKMjRVSjBaRlk4ZkhoMFFXc1FITm8wa01W?=
 =?utf-8?B?MGlDa3lQQXM0bGQxLytrQWpzS3hsc2VXNnRWMHdiRkRnSmEvWm9CVC9EYjd5?=
 =?utf-8?B?S3pXa2RMa3VXR2tJelQrMURhZU5OOUNQYlpReTg3R3QzRDg4VVZWZ043R0dZ?=
 =?utf-8?B?N241dG5RYWlVYUgwbFFPRG9UU2VIY1daeDFqRzB6RklhWkRxOUFhWGZDR1pv?=
 =?utf-8?B?L1RXNTdQYk4wYklMeENNZHI2MWNmN3hTQXo5TDlzdUVUWFR1Vmx2djI5OFV6?=
 =?utf-8?B?M1R2d29JU3YvSnozLzVMUHNHeXRQbE5RWXdqbjR2WXFuWU1UM1NQai9QNTJ1?=
 =?utf-8?B?WkRLT25UQ2VHVGpoSUxLQ2t4MkZyWEdXWHNlMnhHNXlUMWpCRGtEQmE3R0pw?=
 =?utf-8?B?dS9EZnBDaU1oakNpYnYvc2dqbFVMd2R5ZStTMlJ2SFg4a0pYT1NaYnZDRXJv?=
 =?utf-8?B?UDVmT0FKL3dtUTVwcFBYbldLTnNKNDdQdFMwa1Jjb2dzV1BOWDFMQkV2Mm5X?=
 =?utf-8?B?M1JHaU9rY3JHb2d0TWhVaEYvbkZ4TFp3ZysycHNFakVmSXFZRDJxNkFlNys5?=
 =?utf-8?B?M056MzNpYjAyL1BWY3B6NGpvSVZqMDY2UWMwSngwNkhyUXE2ZGVOYzkzS3hm?=
 =?utf-8?B?Y3NiUCtPU0tabU5CV3N1VnRnakZreEFUR1RwVEI2bFJ5T2t4c2FINnh4NXYx?=
 =?utf-8?B?NEh1L1AzVW5id3AxM1Zob3pGaHJjT20wTGwvUTY1ajI1MDdOTXAxaUFvZ1E1?=
 =?utf-8?B?b0hlYW1MNnRHeHlLN1plbENiUTNZQ21NTnpPYXlpV1RROWQzQTFDYnpxUGFI?=
 =?utf-8?B?VDdpWjRDdlJGZWE0cGdXcVZqWTEzSDJpZkFWQ0xBNFQraER5elpjLzJuMG02?=
 =?utf-8?B?NUltSURCYnVlNmJ5OFFHbW5ydEZIbnBLRWorTlA0V3JtaWUrTlBYcUIyek9t?=
 =?utf-8?B?cVNzd2lnM3hudEdzQ0RqWndPQktOU29hV3NxQnAxRTZ1M1I2eDVrMnZIYmMz?=
 =?utf-8?B?dEVSWjdyYmNqZXdib2VhaEg1QkdFTnhYVm13bk1kYVRMSlFPRmZHOGxOb01t?=
 =?utf-8?B?cGJodlR3TGxQM1ZQZmM2ZmlRM095MEloUzBNTitGQnBuOHkwaENIUWN3L2tz?=
 =?utf-8?B?bm9KdVowSVRoQ0kvbUdYRG9oQjdwNWJ0TUtCYVppMWsyZGtKdm56QzczakJa?=
 =?utf-8?B?cVJma2ppb2dIczljNkE3ZDhUUlNiQnB6M2pzaG15NmZMckk3d1NZRFQ2RWth?=
 =?utf-8?B?RnM5czQvQWdTMWR5cXlYL2xPa1A3S2c0ZG83VXM3UVhjUStwdjNuOFpTWlkx?=
 =?utf-8?B?cjZnRGhvRnB5V3pDcFBBZXBqK0V2UnB0Q0dIY2pCTDZuWFJibm4wOGErWkV6?=
 =?utf-8?B?M0lKV1dCVXorYXlPNnFyMm9zYUxBMEJXZnRyUS9TV1hnQzhkSUttVDVNY0V4?=
 =?utf-8?B?b3B2S0YwVWhlRWwzTWpUYVI2UkFWYW0zcW1UQXB2UnNkNFdnN1VHYVFlaGFM?=
 =?utf-8?B?ZmVPR3lIZitQamtacnVacFVJYjNGTXhxdUtpanhUQ0p3Rmo3SjlyRW9hZkFS?=
 =?utf-8?B?SHpxc2xwbXppODRhQW9BQ1RJK0pRT3BKbEtBclMwMFZ0NE1hZmpIeDdhYnZv?=
 =?utf-8?B?LzF5b2pkQWRQOVErTWlGaWJGcFVmQ1ZJNE5vTXdWOGs5V0p5VDd4UXRYRER6?=
 =?utf-8?B?cm1MVm5vZEZCUXF0WjlZd3ZRVmRXWDVtWEZnRklHUmtTZitsSllHWXlSanla?=
 =?utf-8?B?Y1NtZEFJYk8ybjk1eE5sekJ6dkFPQlRjeGJEREtmai9ZT215WElGZkZPNGRP?=
 =?utf-8?B?NitJK3hYYnZFNjdQcm1SMElNbW9jMms4U0NCNzNhQUNKTVBZclpYcE9CeWNw?=
 =?utf-8?B?aHhOOXdaKzh4M1JLSEhzcXhnUkx0aFdHSWlpa3ZyMm1xSUUwZGlyOVlBank2?=
 =?utf-8?B?eHY4b3lPWGlCZTFkMDlUWWhiSTM1T0JxSTBmR3hWQlRlT0UrZGlrOHJYVU1M?=
 =?utf-8?Q?6CdPRr51EQAJ02GApc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38b6819-0a5f-40f0-26b9-08df1f84bb06
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 06:25:04.5499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1a0Qw6vFzoI+/Uj2e3xDqekGMyUOWtUEwVhjipWOIi+BsH+gAnWJPikZbYE1uc9T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999251
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

On 9/30/26 18:12, Kuehling, Felix wrote:
> On 2026-09-30 10:59, Christian König wrote:
>> On 9/30/26 16:44, Kuehling, Felix wrote:
>>> [+Mukul]
>>>
>>> On 2026-09-30 05:02, Christian König wrote:
>>>> @Felix and @Philip any objections to this patch?
>>>>
>>>> It is actually a bug fix for the NPA support.
>>> As I understand it, this fixes the flags used when unmapping memory from the NPA VM. We passed adev->gmc.noretry_flags from amdgpu_ualink_unmap_npa_addr to amdgpu_vm_update_range explicitly in the flags parameter. I guess that's no longer needed with your fix. But I think the end result would be the same, right?
>> Not quite, passing adev->gmc.noretry_flags to amdgpu_vm_update_range() is completely broken as well and also need fixing.
>>
>> The flags parameter to amdgpu_vm_update_range() can't contain the AMDGPU_PTE_TF nor the AMDGPU_PDE_PTE flag because those are overwritten by the PTE callbacks.
> 
> I'm pretty sure Mukul tested this and got something that worked as expected, at least for a time. I'm not sure if it regressed since, maybe during upstreaming. @Mukul, can you comment?

It could be that this works by coincident, e.g. that we set the flag but never clear it. But it is definately not a good idea to rely on that.

>>
>> That's why setting the AMDGPU_PTE_IS_PTE for gfx12 through the init_pte_flags is completely broken as well.
>>
>> We seriously need to stop doing such hacks.
> 
> Is there any documentation that tells us what flags can be used where. This isn't obvious at all.

No, I mean I thought that this would be obvious.

The AMDGPU_PTE_TF, AMDGPU_PDE_PTE and AMDGPU_PTE_IS_PTE control the walker behavior.

So we need to set them depending on what the VM code decides on which layer PDEs and on which layer PTEs are.

I will add some comment to the code.

Thanks,
Christian.

> 
> Thanks,
>   Felix
> 
> 
>>
>> Regards,
>> Christian.
>>
>>> Regards,
>>>    Felix
>>>
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> On 9/28/26 21:08, Timur Kristóf wrote:
>>>>> On 2026. szeptember 28., hétfő 11:10:34 keleti államokbeli nyári idő Christian
>>>>> König wrote:
>>>>>> That was broken since adding the NPA support.
>>>>>>
>>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
>>>>>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 64 ++++++++++++-----------
>>>>>>    1 file changed, 33 insertions(+), 31 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c index
>>>>>> c03327f1242d3..e8f441e018839 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>>>> @@ -346,6 +346,33 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device
>>>>>> *adev, amdgpu_vm_pt_continue_dfs((start), (entry));
>>>>> \
>>>>>>             (entry) = (cursor).entry, amdgpu_vm_pt_next_dfs((adev),
>>>>> &(cursor)))
>>>>>> +/* Return the flags used for cleared PDEs/PTES */
>>>>>> +static uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
>>>>>> +                    struct amdgpu_vm *vm,
>>>>>> +                    unsigned int level)
>>>>>> +{
>>>>>> +    uint64_t flags;
>>>>>> +
>>>>>> +    if (adev->asic_type < CHIP_VEGA10)
>>>>>> +        return 0;
>>>>>> +
>>>>>> +    if (level != AMDGPU_VM_PTB) {
>>>>>> +        uint64_t value = 0;
>>>>>> +
>>>>>> +        flags = AMDGPU_PDE_PTE_FLAG(adev);
>>>>>> +        if (vm->is_npa)
>>>>>> +            flags |= adev->gmc.noretry_flags;
>>>>>> +        amdgpu_gmc_get_vm_pde(adev, level, &value, &flags);
>>>>>> +    } else if (vm->is_npa) {
>>>>>> +        flags = adev->gmc.noretry_flags;
>>>>>> +    } else {
>>>>>> +        /* Workaround for fault priority problem on GMC9 */
>>>>>> +        flags = AMDGPU_PTE_EXECUTABLE | adev->gmc.init_pte_flags;
>>>>>> +    }
>>>>>> +
>>>>>> +    return flags;
>>>>>> +}
>>>>>> +
>>>>>>    /**
>>>>>>     * amdgpu_vm_pt_clear - initially clear the PDs/PTs
>>>>>>     *
>>>>>> @@ -366,10 +393,9 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev,
>>>>>> struct amdgpu_vm *vm, struct ttm_operation_ctx ctx = { true, false };
>>>>>>        struct amdgpu_vm_update_params params;
>>>>>>        struct amdgpu_bo *ancestor = &vmbo->bo;
>>>>>> -    unsigned int entries;
>>>>>>        struct amdgpu_bo *bo = &vmbo->bo;
>>>>>> -    uint64_t value = 0, flags = 0;
>>>>>> -    uint64_t addr;
>>>>>> +    unsigned int entries;
>>>>>> +    uint64_t flags;
>>>>>>        int r, idx;
>>>>>>
>>>>>>        /* Figure out our place in the hierarchy */
>>>>>> @@ -404,26 +430,8 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev,
>>>>>> struct amdgpu_vm *vm, if (r)
>>>>>>            goto exit;
>>>>>>
>>>>>> -    addr = 0;
>>>>>> -
>>>>>> -    if (adev->asic_type >= CHIP_VEGA10) {
>>>>>> -        if (level != AMDGPU_VM_PTB) {
>>>>>> -            if (vm->is_npa)
>>>>>> -                flags = adev->gmc.noretry_flags;
>>>>>> -            /* Handle leaf PDEs as PTEs */
>>>>>> -            flags |= AMDGPU_PDE_PTE_FLAG(adev);
>>>>>> -            amdgpu_gmc_get_vm_pde(adev, level,
>>>>>> -                          &value, &flags);
>>>>>> -        } else if (vm->is_npa) {
>>>>>> -            flags = adev->gmc.noretry_flags;
>>>>>> -        } else {
>>>>>> -            /* Workaround for fault priority problem on
>>>>> GMC9 */
>>>>>> -            flags = AMDGPU_PTE_EXECUTABLE | adev-
>>>>>> gmc.init_pte_flags;
>>>>>> -        }
>>>>>> -    }
>>>>>> -
>>>>>> -    r = vm->update_funcs->update(&params, vmbo, addr, 0, entries,
>>>>>> -                     value, flags);
>>>>>> +    flags = amdgpu_vm_pt_clear_flags(adev, vm, level);
>>>>>> +    r = vm->update_funcs->update(&params, vmbo, 0, 0, entries, 0,
>>>>> flags);
>>>>>>        if (r)
>>>>>>            goto exit;
>>>>>>
>>>>>> @@ -712,15 +720,9 @@ static void amdgpu_vm_pte_update_flags(struct
>>>>>> amdgpu_vm_update_params *params, flags |=
>>>>>> AMDGPU_PDE_PTE_FLAG(params->adev);
>>>>>>            amdgpu_gmc_get_vm_pde(adev, level, &addr, &flags);
>>>>>>
>>>>>> -    } else if (adev->asic_type >= CHIP_VEGA10 &&
>>>>>> -           !(flags & AMDGPU_PTE_VALID) &&
>>>>>> +    } else if (!(flags & AMDGPU_PTE_VALID) &&
>>>>>>               !(flags & AMDGPU_PTE_PRT_FLAG(params->adev))) {
>>>>>> -
>>>>>> -        /* Workaround for fault priority problem on GMC9 and
>>>>> GFX12,
>>>>>> -         * EXECUTABLE for GMC9 fault priority and init_pte_flags
>>>>>> -         * (e.g. AMDGPU_PTE_IS_PTE on GFX12)
>>>>>> -         */
>>>>>> -        flags |= AMDGPU_PTE_EXECUTABLE | adev-
>>>>>> gmc.init_pte_flags;
>>>>>> +        flags |= amdgpu_vm_pt_clear_flags(adev, params->vm,
>>>>> level);
>>>>>>        }
>>>>>>
>>>>>>        /*
>>>>>
>>>>>

