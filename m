Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5626BC04FF6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 16:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E7DF10F1C6;
	Thu, 11 Apr 2024 16:11:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mn7RGTS0";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8B7710F1C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 16:11:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4UCNTSGkAIU9ftEwEkps+3DXnFHrHCGsUujvsM83PhRv9yN8VDUgHT5co0JyWnLtWllZOq6s3UyBK5jVhTZwQ/EVAM/eTDYfRZz/gb5hB+MneI1Tugxd0hvd60GQVqs6c8VJejx1SkbmWGQm0jYyK0aCucb8vT0gdDWazQF74NzOZ99CQ2k8jl4vC4gApui+lBQpyZ4X2Dala2mSNwQU9eME/JfY8+L7Gs53Wh8hJhAC7lHvp6yaOFr2tHjGr2IAQ2RUw4flNC5AukG8Q5merqQQKJcLxaJGFFZF76Ovmc70peX4wyz64W39bN5Qq2ndKgduyhdIdmo4wCu+24+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krp1QRuUdQRQGPMVcSISTiVP0NTVudb5SPTGxdjy680=;
 b=ZAaNRow7NTibb3kBLuqUek3k2Gz5NUZ4BXPGpBcn5fsWH6w+DH4ptFSCUh47sQVb7Pbaau08b+F6tyeCLHph51fS3Cl+XRI+Rl5MMCGhz7VTWEnlWLT9up4nxHZFLfliUXeOCdoGB99vozLYv1/m1z93Hwd3Vy3D7wJ5njkh2yj6aEzEnwFzTMVN4r8d6whAmrmQ0woK5Q+SxKFodtWkgftLqggoo2h0rG7WtPJo7Bi6a2CtbOQLimktIFTR+I4/8tPfhuttj88hS7bVRFhRx46Ms0cDnvcR6xhCPS820ErO5CdgoKnAu8577wkEBaki7b0GXAEixrsH+xT1OS1QEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krp1QRuUdQRQGPMVcSISTiVP0NTVudb5SPTGxdjy680=;
 b=Mn7RGTS0Ay2mmnsiPO+iTNuR5vlhnPTmUt895LI37nTsVVI2Ir//pSDB9nDTnqvocFY4316AVxuxOr59XyHISnNM/R48D9xd1rXR8gqe2tz26JWd2gVfkfQxVWgz1pHRZBorcxZXv6sh5XedCDyGSdKFFmIaVENRe/u8IZZzX0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Thu, 11 Apr 2024 16:11:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 16:11:50 +0000
Message-ID: <2eed2681-d469-4fc0-99b1-599b09cc024c@amd.com>
Date: Thu, 11 Apr 2024 18:11:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: validate the parameters of
 amdgpu_vm_bo_clear_mappings
To: Jann Horn <jannh@google.com>
Cc: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, Vlad Stolyarov <hexed@google.com>
References: <20240411032844.41839-1-xinhui.pan@amd.com>
 <81623e99-58d0-4ab8-9e8e-6b75351a6729@amd.com>
 <CAG48ez1WFe9C5B3a8A8TLSUE51UBNDzN993ybqFAOpi4hf=UCQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAG48ez1WFe9C5B3a8A8TLSUE51UBNDzN993ybqFAOpi4hf=UCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0249.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e059acd-aecd-43c3-c660-08dc5a421825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1a4rd/OIrnoQY+dCxvETBqTGTpVgv0DylZx4qmdzRsSzSZxUNetSuMDRFYN90ojCAc4SzKqrMmwnAhcGL8vf6vt0f+4h3qDjc9/ZW2cxQfBnmoSgf84PQN+gigFiJQfwmAxqoFT+n8vmFfw/MR4YCW5kzBKkRQ0N9LsXf96N9+oceGb4Wc4GCLb3Yd4lHjKoTSgGxxHXIsIyDbsd4qRxHaOYSEn6xFcTLGGYPhv4tciD3MJPts3Bn4EZOwvXu+W73PQNeaQYfrb0KbOa9T03goeb+FKzD9QTJ13PDPv2ZtLLyIktZQPxaW9NYmmRV0DxdwzitrFL4qwt9Mn0W4LWUABl4atAha/e81S0KOX21DLc0SNKVlXXHnk5XOLs+8Cw74NNoRBjpjsKhCvMjWAbZ3z3XlHi2Yq6D2KpbfPTLaH8TLRoaIg2OGXdlFDMOkfmfY1qtOtBvv22acJDRon82+DC2fXdoaERKHOkvgwp8BuP6/sjVj66ThUI7CaB/F+uDad4yM3ajDjmv1qs8wZwdZ2zN9WPsu6JyibOSI7v2upROYiL+uZu5JSC8OQM/slA4d6OVi82uFgRIX5JPTDjPz6fDl68x9uJpywUa0vwcnZ3+xPdkxBUHlPL+ws7YeQ5ZJE/g7+C0gqjOsmqn+JbMZvBfxE8lBrzrCjEMDAPrc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alF1aGRkL2xCM3JXK21SV3c5eVNTNXMrdzRROVcvMU9TOTdzc3BpazJXK1VY?=
 =?utf-8?B?TUpveW9tTHV5VFQ3eGFBc2laeHBNa1EzbU5sczduMGhrRGxVS0p2Z3JUWklu?=
 =?utf-8?B?elhvNzRGQlFRQmdxKzNsQW9IS3JRQTNWa1UzMmJmN0tUK3VuWXROVEpNZm03?=
 =?utf-8?B?SFB1ZzBBWjFZemxuS25neHF0TzZKYWhuY3NqV293RTAxM2tWLzhpam5jeHNG?=
 =?utf-8?B?azhLQmxSWnZnM2FKR2g4TWROTktETStuTWQvMCtXY0tWN2hOSFA1a1lnWmw2?=
 =?utf-8?B?YjN6dE1mQ1l0SlhwcStYSVFkb0RGN0E2Tmpyc2Y5SDBwV0JHT1RzdUdpUGJK?=
 =?utf-8?B?TDE3Zmk2MmtBMm9yV3RwaXdFRmRIZGVFb2kwTVNPNlkzdjRkdzBhMFNQSUd0?=
 =?utf-8?B?aTRGeVg3MmVWOE1ONEFORlFBMEREWnc3YU5vanZJNGJUbWNhbG9JdFlMaUls?=
 =?utf-8?B?aGVmbndGT1ZQOGZja3FLRWdwbE1MUWdNWUpVQzNnZHAyRWxudS9BeTdORWIw?=
 =?utf-8?B?MzhOcUJaQzAvWDFuVHh6THFOdDJMdjlqaEFFRU1PRElrN25SWlRJNkNZa2Fw?=
 =?utf-8?B?VmU1VzJlUUFDNHE2MEVPdXQyL0RGTm5CV3pPRnVSTmovUHdMRVo1TE5rZmJ2?=
 =?utf-8?B?WTIraC9xQnQ5S0dLbU1Tc1FlOU1GY0k4Y0lGQmg1MW5HNitFRXRuUG84SlJO?=
 =?utf-8?B?bGdDYzZmMkRPczNqZWxZUU5uVDAxWHA0UUlsc2kybUVqbUh3ZXdFQWhEaGs4?=
 =?utf-8?B?QzRjVGgxVEhXZnhOOEc0WUlpaE5iNkJSV09oeEUvQXZldzdsT3NJUUlUbXBN?=
 =?utf-8?B?aFNOQXRUN1JqVG1zTkZtdFRJTkZ4elVkVFBNQXBmTUlDUjZjK2QraE02VWMy?=
 =?utf-8?B?NUVkS1B6OXc1bERxUFo4YjNtTThTdWU0VFhZZ09JTXRYMS85WEJRb2RFUy8r?=
 =?utf-8?B?YytqYThTTWI1c0FDZGRieHRCYjhUdVd5YnV5czFsZk5JaHN5MnBwVENyZnlk?=
 =?utf-8?B?bytuNjdEWlAzVll1M29jazZPWnBaWUt4OEw5aWp6dGZRVG5UZGdBSktrQm1W?=
 =?utf-8?B?NkhIQnpPZXA3SnVid3NOempyMFpPSzJHckJqVmJYTlFEU0w0QUVSb3FBSEw1?=
 =?utf-8?B?akJwUEtwSEQ3WXVZU0Zwc0pROXFtaS9JU3dCOUVzN0lneHZobWtNZ1dZU0xt?=
 =?utf-8?B?T1ZiZWF6b09uYms4YmtGeEJqOUtIQ2ZQOG56dDZPdUxRTUhVdEJjVTNDak9u?=
 =?utf-8?B?b0xNdHlmWFYyaW50UFpqOGd3UlVnR3hKQUgyYXRKdGdvbDgwV0pqd0JPenYw?=
 =?utf-8?B?Ly9KS2FSL2lPOCt4VHlxRjM2NEJkSlk4S1VBaUdUVlZHWXFJcXB0SGNTM21K?=
 =?utf-8?B?YzE2RlM4UDJEcisvSEQ3a0t2MlJCcVQ2SmJxYW01SENaUytvYWNuTU95RWd2?=
 =?utf-8?B?WDZnRGE4eXdDOFNrMm9jN3lLWUtLWVNsZUpGUFc5MmhLUytrd0ZJTXJSWGZ6?=
 =?utf-8?B?bVJObW1tcGo1TllSK3kvWmIvT0hER1lua0VYYjd5b0oxM1hDOEdGalpyYkV6?=
 =?utf-8?B?QUZDYkRsaUo0MU02SVBOMVdvRUhtMGxUMWVrTDh0bFV2YVl6N2c3Q05sL01K?=
 =?utf-8?B?RnlRR0ZwRGtQRHFKWUJaeVJRRm1HeHEyV3p3QTdMTUxqNXJBODNJSzhqNEgy?=
 =?utf-8?B?UlhWQmZLSnVWQ2FBVFMzL2krbkpRVWhRdzBmRXE4TUUvSjNlMWJQVUlxRlhs?=
 =?utf-8?B?L29TZFdHL1pxa05GMmFjNVluZHRIWjkya05RcE5kcG5FTGp0a2hJZ0NMLy9h?=
 =?utf-8?B?TnpXaXFudTl2bmtJcFZFWHlGcmlnUCswK0I1SzlWNmJ2Q3F5V3ZPSU84dDlL?=
 =?utf-8?B?VWk2ajVmWVhiTGFsTlVVZVU5czcydFZVNDNldkFUN3UvMzVVQnJuM3pGUVov?=
 =?utf-8?B?OUhGMHE4ckgrQ0U1YWc2TlVEbk80Mi9aaDRXcU1STUNvYzFOYkVSMjhlNng1?=
 =?utf-8?B?WVhjTjhVUHVPdVgvRGUrUllMRmFyZ1Z4Q2tsb05SL3N0VnZZYmlqZWQ2Y1JP?=
 =?utf-8?B?VWlrTWZEQ0F1ZmtFNDczak9oT3pNOEFjclI5WCtMMVpZUk8yTkV4RTNXanlv?=
 =?utf-8?Q?n6Xs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e059acd-aecd-43c3-c660-08dc5a421825
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 16:11:50.0883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBOyWSKKzZ5nfoVPV99eVznaKqKvGKIeMJhqzZdPq9NfvuZxtRObBNvpuNYQqJQx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072
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

Am 11.04.24 um 17:44 schrieb Jann Horn:
> On Thu, Apr 11, 2024 at 12:25 PM Christian König
> <christian.koenig@amd.com> wrote:
>> Am 11.04.24 um 05:28 schrieb xinhui pan:
>>> Ensure there is no address overlapping.
>>>
>>> Reported-by: Vlad Stolyarov <hexed@google.com>
>>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 8af3f0fd3073..f1315a854192 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1852,6 +1852,12 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>>>        LIST_HEAD(removed);
>>>        uint64_t eaddr;
>>>
>>> +     /* validate the parameters */
>>> +     if (saddr & ~PAGE_MASK || size & ~PAGE_MASK)
>>> +             return -EINVAL;
>> Well as general rule: *never* use PAGE_MASK and other PAGE_* macros
>> here. This is GPUVM and not related to the CPUVM space.
>>
>>> +     if (saddr + size <= saddr)
>>> +             return -EINVAL;
>>> +
>> Mhm, so basically size is not checked for a wraparound?
> Yeah, exactly.
>
>>>        eaddr = saddr + size - 1;
>>>        saddr /= AMDGPU_GPU_PAGE_SIZE;
>>>        eaddr /= AMDGPU_GPU_PAGE_SIZE;
>> If that's the case then I would rather check for saddr < eaddr here.
> FWIW, it would probably a good idea to keep the added check analogous
> to other functions called from amdgpu_gem_va_ioctl() like
> amdgpu_vm_bo_replace_map(), which also checks "if (saddr + size <=
> saddr || offset + size <= offset)" before the division.

I would also change that function as well.

The eaddr needs to be checked against the max_pfn as well and we 
currently shift that around for this check which looks quite ugly.

Only the overflow check can probably be before it.

>
>> But that actually shouldn't matter since this code here:
>>
>>           /* Now gather all removed mappings */
>>           tmp = amdgpu_vm_it_iter_first(&vm->va, saddr, eaddr);
>>           while (tmp) {
>>
>> Then shouldn't return anything, so the operation is basically a NO-OP then.
> That's not how it works; the interval tree is not designed to be fed
> bogus ranges that end before they start. (Or at least I don't think it
> is - if it is, it is buggy.) I think basically if the specified start
> and end addresses are both within an rbtree node, this rbtree node is
> returned from the lookup, even if the specified end address is before
> the specified start address.

Ah, yeah that makes sense. The search functions checks if a node only 
partially intersects with start and end and not if it is covered by it.

Thanks,
Christian.

>
> A more verbose example:
> Let's assume the interval tree contains a single entry from address A
> to address D.
> Looking at the _iter_first implementation in interval_tree_generic.h,
> when it is called with a start address C which is between A and D, and
> an end address B (result of an addition that wraps around to an
> address below C but above A), it does the following:
>
> 1. bails out if "node->ITSUBTREE < start" (meaning if the specified
> start address C is after the range covered by the root node - which is
> not the case)
> 2. bails out if "ITSTART(leftmost) > last" (meaning if the specified
> end address is smaller than the entry start address A - which is not
> the case)
> 3. enters _subtree_search. in there:
> 4. the root node has no children, so "node->ITRB.rb_left" is NULL
> 5. the specified end address B is after the node's start address A, so
> "Cond1" is fulfilled
> 6. the specified start address C is before the node's end address D,
> so "Cond2" is fulfilled
> 7. the root node is returned from the lookup

