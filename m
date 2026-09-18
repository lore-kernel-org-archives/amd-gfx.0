Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00E4C982D8
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 14:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 359EC10EC97;
	Fri, 18 Sep 2026 14:25:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ut3IdoGW";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013015.outbound.protection.outlook.com
 [40.107.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56E4510F3E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 14:25:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejRCCbpgD1o3P4bvxRmd9QP6ANUhDHIuaJ1/2hz+lH293MiWLGm1j7+yOuVC/nJqP2QdmH3GX2HuZGk9E3+P10m3ejLj3fvtd4nhO8FX4o3NLK/jzln8ugNP9xY5ngx6DHhR8wvLcQxlZ2elJte1lYptOZ08LvS+XpI7RaNkhVCMdcBLiLuzFLtGoKXHzRTnv46EMxqWV9+MZs+6tPf7RfySbifRxWThcas1WuWoTRhWZOgH8VW7ULPJY8quOR2MZoaAO6DxuyhonK0i9pzEk+x978ElLtvy3Mx3NxRM6B7xCJ937eRQRhSh5h9kS6WCBFa32Wgioz/99zAQT5+TCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hA0YBENco1qLBJBS5I7EHcjcVf/7a/OYrQQ80ZVEf9E=;
 b=UukvMcNxwofVwA6vey2lAUUGEKkO6os2qLOXTBY/g1TUyOiPL9EUu4lBgdGZh8JMJLfFZLfHywGl2x3rcORsAvU5HLJC17L/pLgaC6PvC0uGti9jdvvhN1H9neXDlkDTo9/u+snFSTj5lMFceAkHoToKae/YlrKttXgSE02smRaumQffS/y+4DdNmzlwUo2A5uqSyoOd91xyUoan5ZQbQlfgxf/vVxvzUvGAbPkXdO3tSc8yXYxFz6R+kLR9ZGRNzNzpqwFa7RWQF4H7NA3RO4lnFDRhumwVuWAji3TnHCHbe8NkyugmPAVDA3kG6uYEdq68MFLLPDmithMYPF1sfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hA0YBENco1qLBJBS5I7EHcjcVf/7a/OYrQQ80ZVEf9E=;
 b=ut3IdoGW3qGrmWwOKGFlRmykuqc699EHVd040TDWZ4Ld/Uo4B6lka22GzWKHNYXnwpIEG5/MtXOWXkESwtjsQWxvRO6Yf0L5E0uu+G9Vhz77KCpESuSjsj8p7sXfXaxMUfIgAmbLrt5YgBZtmLxGWdtr3oCs+vhpqNDFFhVbvtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:25:09 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 14:25:07 +0000
Message-ID: <95af58a6-f89f-4430-9be2-d4d4a18dd1e9@amd.com>
Date: Fri, 18 Sep 2026 19:55:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] drm/amdgpu: More compact VCN IB emission
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20260918120518.96922-1-tvrtko.ursulin@igalia.com>
 <20260918120518.96922-2-tvrtko.ursulin@igalia.com>
 <474139b2-c3c2-4d2b-81d7-e209231870f2@amd.com>
 <84ae6c9c-6ea5-4e02-9dbe-5ba855580da1@igalia.com>
 <de963600-ba53-4e34-bba1-2a838cbc2457@amd.com>
 <052c9390-8906-4f8f-a501-30730c41f011@igalia.com>
 <04dc6bc5-4fb0-4e8b-a3f4-bc681ddf0b73@amd.com>
 <720027b8-deec-4953-a1e5-8b1781285c8c@igalia.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <720027b8-deec-4953-a1e5-8b1781285c8c@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb2e616-de13-41e9-06b9-08df1590a370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|11063799006|6133799003|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: BfpWK09yLHuaI3C7H3cH28s+DVwPU7b+u0mNnAf144xV6fjRVlGmdtoZ8dICTozI9Z5cpfulj5vMHWHZwRfyKv5Jxo3BnlRmoGN9pl+I6ucOAjjgL636/zF0FWmQtB9I7N2aC3NbJ6TqDmpxAFD/00gToHn2bvPgYN7mmySGtXRdQbBtReE3npGwrzZllUILQpQ7Dp7cY2WtRZwOgh5JbzIovjac0J9D1Ubp45cmFnVs+hetTm7R3v13tS5QJ+bLOfBZGXKOrlosdTPohsqMTcfknmdxjZuekBPRiQziS/OMn19dtFe/BxDFGHin1XinSn676njzbtUO6sWm6Fj2IoJdevR8NzBPjysLf+lZnLopsTofJuCySR4JV6KKH8DMZV8rUItiUCRhqQU75gV2ss4lZGAI8fjch5ubLAkK7DZ+tAanXH82Ibqq0u0Y9jxSllKfTCxMsMdlX0w66Jzmnwx2X3gDc99iqKUNQ2xUC49qQNDpfJz+jt+FBnfRBN5+yEygwPLTwifZoaMuIWnAYuUGe+HwWzxK/YBBEZoqeUl+RF2ZhnS4zHJWtkkHxepiDFkpBilSNMsh2vsz+hereJclkj84nC0scWFQ8Vf2QdGmNlCJJbNF1ceVPEoUn/xWomqY/etztstBA+t4IT8Y4Yo5prBAI24r0+RZb15siQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bklYbEZQT2hjUjdIVGhCQ2tXaFFnNzBGRWJuemdkWmRUT3ZUQ2ZlWHNFWk4v?=
 =?utf-8?B?KytKcXZyeks0dGFrSVljREJxVUU3amtWTzdqYXMyYld6bnJXQ0c1S1BSYzVz?=
 =?utf-8?B?U2dKUzdXaHV2V1hhKzJ3RTRsU2RQaktiV1hLMVF5QlNUMWxoclRIMWhhbFBs?=
 =?utf-8?B?NUNqZHczWThpSm5KRk5KV014MUVRQk5YMEpmK3dCUy9YdXFocURRZGVkcENY?=
 =?utf-8?B?Y1NWelY4WjJ3bDVIWGpRYTdTZkFlV3F4ekxySXZIQ3Z4QUdyUTFRdHlZOWtF?=
 =?utf-8?B?NCtpRWVzNXgzUzlsc3ZSN0tXOHdhK3MrWERabktJa2cvcUhjaUd3Vzloay9Q?=
 =?utf-8?B?NVZMMEIremdSTjFKNWY4K2JnbzJzTFZUNE9UaDJSS3lPaU9uTnRqU3k4U29K?=
 =?utf-8?B?L0RZWjJkMDl6YmJPcjlTY1Q2a08zQUd5czdrRjRFSlRuTkk0cUNGaGoyQStv?=
 =?utf-8?B?RUVDYjBjSDJjeFlpLzhhbGpJNk9UMzlNZ0o0T2R2VXMyYzVuQTVJRzNNdjFD?=
 =?utf-8?B?a3NRSUx4QlllVUlMLzhEZHJhZ3RTLzJOc1dNL0FSbG53OGJtR2VnalZpUE5p?=
 =?utf-8?B?VDVlVVkrazN2RDVWdUVEemdZc1R6T2ZhQktuMUN3d0hJZk1FbUFkWGZtMVhk?=
 =?utf-8?B?aHFFeEJkVThwNUJBWlZIOE9GQ2RNc1NDMU9yNzA5SDBzdm9JalhqTnBJSTE5?=
 =?utf-8?B?UFRQQmw3Y3pMcWRJLy9WM1VQRlJSZzc5akh2NEZsWTFkNFgvdlFWak5aV0xJ?=
 =?utf-8?B?VVpNZTdEdU5BdUVCampWTFdVSGxGN2pWNzNuRmZ1Znl5NHBQU1c4dHp4ZHUy?=
 =?utf-8?B?eC8xZEx5cXZyTWRuTktReTUyc0xMdzJ0KzVRSGtPVTBUWlZUQ0o2QjVTNDhJ?=
 =?utf-8?B?OWtSbFZtelVWSDdVWGczNUZzZVByeDk4Tm1XRWU4UTZXb3M0NjkyV2RPTzd4?=
 =?utf-8?B?am92aFFlZzJWcy82SnN0VnJSTlpjNktQQVJrM1pyRUhMVUlMbUVLYXZFOWlw?=
 =?utf-8?B?a25UcWdyeDV0TXkzNndoWEpoVmRqaDB6RlloZjNDSWpaQTNVb2ZZWlUxOUFB?=
 =?utf-8?B?SkNycTVxL0RiaGRZTDVySEthSkpkek0zQjI5dzQ2ZDR6RWJ1OVJ1Q29FM2E3?=
 =?utf-8?B?bUEyakNHajMrbStiYU9tbngxdFVZTXpuaE9aWlJ6aXBYT01VVTd2U3RLM01O?=
 =?utf-8?B?SU1EQXczbUVIYnEwa1lEcDQ2Ym5wZU1zWWdRMk5mWDIvTWtnZW1FMkVHcHY4?=
 =?utf-8?B?M3ZNZUNuYWhQb2pjT1dhTWt5eFlnTys0aUZzS1BLWUpBdlA1WFNhWnZRd0lo?=
 =?utf-8?B?aUNvY3VmNmRnek15K1JFUXBuWEJqMFg1cXJiTGpuVXF4TnpUOXFiV1UrdkVm?=
 =?utf-8?B?djYzU3Q2WktUQmVnSjBJMUFmcGx6cXRVcDVxV2RCUXlYcmViNEdRWkxYSjJ1?=
 =?utf-8?B?TEhGYmRXaDBmbGtUVnVVQ0dMYXlURjBKOFd4dWx4ajhFbm1EWVZRWkFmUWxt?=
 =?utf-8?B?MHlyVVRjc1JWUzQyQUNWRkd2SExaSVV6NjNkc0E5ZzJlcTBmZmdhcWxxNnF4?=
 =?utf-8?B?ZE05d2tBMzB5TUFtbGU0a29wRC9rblpINTl1NnRWMTM2OGVubWVNdU85OXZY?=
 =?utf-8?B?RXAzVUJ6T1grdWZmUHBOc210U2FjdWc0WlNDSjdobTgxcjN0Q1hmU3pYdm5T?=
 =?utf-8?B?VUlWeTR1Qjg2a05KTmpwb1o5OHpyZ1BUVGREZllHYWZPNTVsWWt3eE1OTWZH?=
 =?utf-8?B?RVhOK09OYkpZb01yRkNGayswVGllQjRGQndaYW1VaUNucmIwS1ppQktjOG5V?=
 =?utf-8?B?eE4zeFhsU2d0WEs5T0x6UkZJVlFOOWNkQ3FWN2dGOHNzWFNWTlhMSjZBTHcx?=
 =?utf-8?B?UnVrNDZwM0NoNThhRDZjZmtlS1NGamxHcmllbTVkZXJzZm9zREFzZytQcjJV?=
 =?utf-8?B?dkxHZDJyV1ZsNnJNdnBJZ2haai9pZ1l1S1NQSDNUekFSbXlrVHIvSzhtcEE4?=
 =?utf-8?B?dVQ5ZGdlM0JMQ25sUDR6dDZCdm1iS0xRQWlNbWd3Wk5kRExPcTBnR0FNenFX?=
 =?utf-8?B?NWNpQXRsUlNwaXkxL0pyMGxRUjBwS1lKRm1lV3lXcEdxanpXTC94QmV6dzVT?=
 =?utf-8?B?cVA4WUU2MEp1TnUzUUtCaDFwVzlJOEdZK0cvQ1BNOFlHbEZQVTA3RVRFMi9C?=
 =?utf-8?B?bmVYQ2dXajFJYzRqaUtxUEsvVG9kY2NjYnJZVFdzc0tYMmtPOTlQYW9Wb01r?=
 =?utf-8?B?OHFUWklZc0dMZEJhUCtiUDhNbUc1d3JvU2FUZVh5V2w4KzV3bWZObDgvMWJk?=
 =?utf-8?Q?Fx7xfQaUmV0Z5UzQZ+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb2e616-de13-41e9-06b9-08df1590a370
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:25:07.2972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qi8mFYOlAAo4X4KoZw/EZ/QuNlYHVVCvwnVL+uJGcVB3OhEak594O+2tixNNGM3J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228
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



On 18-Sep-26 7:37 PM, Tvrtko Ursulin wrote:
> 
> On 18/09/2026 14:34, Lazar, Lijo wrote:
>> On 18-Sep-26 6:59 PM, Tvrtko Ursulin wrote:
>>>
>>> On 18/09/2026 14:23, Lazar, Lijo wrote:
>>>> On 18-Sep-26 6:43 PM, Tvrtko Ursulin wrote:
>>>>>
>>>>> On 18/09/2026 14:08, Lazar, Lijo wrote:
>>>>>>
>>>>>>
>>>>>> On 18-Sep-26 5:35 PM, Tvrtko Ursulin wrote:
>>>>>>> Avoid constant register reloads while emitting IBs by using a 
>>>>>>> local write
>>>>>>> pointer and only updating the size at the end of each helper.
>>>>>>>
>>>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>>>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>> ---
>>>>>>> v2:
>>>>>>>   *  Fix decode buffer overwrite
>>>>>>
>>>>>> Overall for this series, below type of calculation  -
>>>>>>
>>>>>>      ib->length_dw = ptr - ib->ptr;
>>>>>>
>>>>>> is not anticipating a case like below.
>>>>>>
>>>>>>          r = amdgpu_vcn_enc_get_create_msg(ring, 1, &ib, NULL);
>>>>>>          if (r)
>>>>>>                  goto error;
>>>>>>
>>>>>>          r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, &ib, &fence);
>>>>>>          if (r)
>>>>>>                  goto error;
>>>>>
>>>>> So amdgpu_vcn_enc_ring_test_ib() - are you saying there is a bug 
>>>>> there? Help me see it please.
>>>>>
>>>>> ib->length_dw update is enclosed in both of those helpers, same as 
>>>>> before the patch.
>>>>>
>>>>
>>>> What I'm saying is -
>>>>
>>>> It's the same ib pointer that is passed to back to back calls.
>>>>
>>>> Legacy implementation fills like -
>>>>
>>>> ib->ptr[ib->length_dw++]
>>>>
>>>> So no assumption that it is starting from offset 0 always. After the 
>>>> function is filled, length gets updated based on what is filled.
>>>>
>>>> I don't see the same with an assignment like
>>>>
>>>>      ib->length_dw = ptr - ib->ptr;
>>>
>>> Hm, but both of those helpers emit separate jobs with their own 
>>> respective IB.
>>>
>>
>> Wouldn't this kind of logic help to be on the safer side -
>>
>> ib->length_dw += ptr - &ib->ptr[start_size];
> 
> I am not sure at which call sites you would suggest that?
> 
> I used the pattern of whoever writes to the IB starts their block with:
> 
>      u32 *ptr = &ib->ptr[ib->length_dw];
> 
> Then they emit their stuff, and finally close with:
> 
>      ib->length_dw = ptr - ib->ptr;
> 
> By that design callers are safe since all are self-contained. I at the 
> moment do not see how making that more complicated would make it safer.
> 

I would say all places where the function starts like below without 
keeping any assumptions.

	ib->ptr[ib->length_dw++] = <value>;

I don't see the complication with a code like this

	ib->length_dw += ptr - &ib->ptr[ib->length_dw];

It keeps the same behavior as before.

Thanks,
Lijo

> Regards,
> 
> Tvrtko
> 
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 134 ++++++++++++ 
>>>>>>> +-----------
>>>>>>>   1 file changed, 75 insertions(+), 59 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/ 
>>>>>>> gpu/ drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>> index 17db7264269e..2c367ee6e182 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>> @@ -622,9 +622,12 @@ static int amdgpu_vcn_dec_send_msg(struct 
>>>>>>> amdgpu_ring *ring,
>>>>>>>   {
>>>>>>>       u64 addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>>>>       struct amdgpu_device *adev = ring->adev;
>>>>>>> +    struct amdgpu_vcn_reg *internal = &adev->vcn.inst[ring- 
>>>>>>> >me].internal;
>>>>>>> +    uint32_t nop = PACKET0(internal->nop, 0);
>>>>>>>       struct dma_fence *f = NULL;
>>>>>>>       struct amdgpu_job *job;
>>>>>>>       struct amdgpu_ib *ib;
>>>>>>> +    uint32_t *ptr;
>>>>>>>       int i, r;
>>>>>>>       r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>>>>>>> @@ -635,15 +638,16 @@ static int amdgpu_vcn_dec_send_msg(struct 
>>>>>>> amdgpu_ring *ring,
>>>>>>>           goto err;
>>>>>>>       ib = &job->ibs[0];
>>>>>>> -    ib->ptr[0] = PACKET0(adev->vcn.inst[ring- 
>>>>>>> >me].internal.data0, 0);
>>>>>>> -    ib->ptr[1] = addr;
>>>>>>> -    ib->ptr[2] = PACKET0(adev->vcn.inst[ring- 
>>>>>>> >me].internal.data1, 0);
>>>>>>> -    ib->ptr[3] = addr >> 32;
>>>>>>> -    ib->ptr[4] = PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0);
>>>>>>> -    ib->ptr[5] = 0;
>>>>>>> +    ptr = ib->ptr;
>>>>>>> +    *ptr++ = PACKET0(internal->data0, 0);
>>>>>>> +    *ptr++ = addr;
>>>>>>> +    *ptr++ = PACKET0(internal->data1, 0);
>>>>>>> +    *ptr++ = addr >> 32;
>>>>>>> +    *ptr++ = PACKET0(internal->cmd, 0);
>>>>>>> +    *ptr++ = 0;
>>>>>>>       for (i = 6; i < 16; i += 2) {
>>>>>>> -        ib->ptr[i] = PACKET0(adev->vcn.inst[ring- 
>>>>>>> >me].internal.nop, 0);
>>>>>>> -        ib->ptr[i+1] = 0;
>>>>>>> +        *ptr++ = nop;
>>>>>>> +        *ptr++ = 0;
>>>>>>>       }
>>>>>>>       ib->length_dw = 16;
>>>>>>> @@ -763,17 +767,20 @@ int amdgpu_vcn_dec_ring_test_ib(struct 
>>>>>>> amdgpu_ring *ring, long timeout)
>>>>>>>   static uint32_t *amdgpu_vcn_unified_ring_ib_header(struct 
>>>>>>> amdgpu_ib *ib,
>>>>>>>                           uint32_t ib_pack_in_dw, bool enc)
>>>>>>>   {
>>>>>>> +    u32 *ptr = &ib->ptr[ib->length_dw];
>>>>>>>       uint32_t *ib_checksum;
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000010; /* single queue 
>>>>>>> checksum */
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x30000002;
>>>>>>> -    ib_checksum = &ib->ptr[ib->length_dw++];
>>>>>>> -    ib->ptr[ib->length_dw++] = ib_pack_in_dw;
>>>>>>> +    *ptr++ = 0x00000010; /* single queue checksum */
>>>>>>> +    *ptr++ = 0x30000002;
>>>>>>> +    ib_checksum = ptr++;
>>>>>>> +    *ptr++ = ib_pack_in_dw;
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000010; /* engine info */
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x30000001;
>>>>>>> -    ib->ptr[ib->length_dw++] = enc ? 0x2 : 0x3;
>>>>>>> -    ib->ptr[ib->length_dw++] = ib_pack_in_dw * sizeof(uint32_t);
>>>>>>> +    *ptr++ = 0x00000010; /* engine info */
>>>>>>> +    *ptr++ = 0x30000001;
>>>>>>> +    *ptr++ = enc ? 0x2 : 0x3;
>>>>>>> +    *ptr++ = ib_pack_in_dw * sizeof(uint32_t);
>>>>>>> +
>>>>>>> +    ib->length_dw = ptr - ib->ptr;
>>>>>>>       return ib_checksum;
>>>>>>>   }
>>>>>>> @@ -803,7 +810,8 @@ static int amdgpu_vcn_dec_sw_send_msg(struct 
>>>>>>> amdgpu_ring *ring,
>>>>>>>       uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>>>>       uint32_t *ib_checksum;
>>>>>>>       uint32_t ib_pack_in_dw;
>>>>>>> -    int i, r;
>>>>>>> +    u32 *ptr;
>>>>>>> +    int r;
>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>           ib_size_dw += 8;
>>>>>>> @@ -825,18 +833,20 @@ static int 
>>>>>>> amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>>>>>>>           ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 
>>>>>>> ib_pack_in_dw, false);
>>>>>>>       }
>>>>>>> -    ib->ptr[ib->length_dw++] = sizeof(struct 
>>>>>>> amdgpu_vcn_decode_buffer) + 8;
>>>>>>> -    ib->ptr[ib->length_dw++] = 
>>>>>>> cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
>>>>>>> -    decode_buffer = (struct amdgpu_vcn_decode_buffer *)&(ib- 
>>>>>>> >ptr[ib- >length_dw]);
>>>>>>> -    ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
>>>>>>> +    ptr = &ib->ptr[ib->length_dw];
>>>>>>> +
>>>>>>> +    *ptr++ = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
>>>>>>> +    *ptr++ = cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
>>>>>>> +    decode_buffer = (struct amdgpu_vcn_decode_buffer *)ptr;
>>>>>>> +    ptr += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
>>>>>>> +    ib->length_dw = ptr - ib->ptr;
>>>>>>>       memset(decode_buffer, 0, sizeof(struct 
>>>>>>> amdgpu_vcn_decode_buffer));
>>>>>>>       decode_buffer->valid_buf_flag |= 
>>>>>>> cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
>>>>>>>       decode_buffer->msg_buffer_address_hi = cpu_to_le32(addr >> 
>>>>>>> 32);
>>>>>>>       decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
>>>>>>> -    for (i = ib->length_dw; i < ib_size_dw; ++i)
>>>>>>> -        ib->ptr[i] = 0x0;
>>>>>>> +    memset32(ptr, 0, ib_size_dw - ib->length_dw);
>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>           amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 
>>>>>>> ib_pack_in_dw);
>>>>>>> @@ -934,7 +944,8 @@ static int 
>>>>>>> amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t 
>>>>>>> hand
>>>>>>>       struct dma_fence *f = NULL;
>>>>>>>       uint32_t *ib_checksum = NULL;
>>>>>>>       uint64_t addr;
>>>>>>> -    int i, r;
>>>>>>> +    u32 *ptr;
>>>>>>> +    int r;
>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>           ib_size_dw += 8;
>>>>>>> @@ -947,31 +958,33 @@ static int 
>>>>>>> amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t 
>>>>>>> hand
>>>>>>>           return r;
>>>>>>>       ib = &job->ibs[0];
>>>>>>> -    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>>>> -
>>>>>>>       ib->length_dw = 0;
>>>>>>> +    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>           ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 
>>>>>>> 0x11, true);
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000018;
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000001; /* session info */
>>>>>>> -    ib->ptr[ib->length_dw++] = handle;
>>>>>>> -    ib->ptr[ib->length_dw++] = upper_32_bits(addr);
>>>>>>> -    ib->ptr[ib->length_dw++] = addr;
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>>>>> +    ptr = &ib->ptr[ib->length_dw];
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000014;
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000002; /* task info */
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x0000001c;
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>>>>> +    *ptr++ = 0x00000018;
>>>>>>> +    *ptr++ = 0x00000001; /* session info */
>>>>>>> +    *ptr++ = handle;
>>>>>>> +    *ptr++ = upper_32_bits(addr);
>>>>>>> +    *ptr++ = addr;
>>>>>>> +    *ptr++ = 0x00000000;
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000008;
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x08000001; /* op initialize */
>>>>>>> +    *ptr++ = 0x00000014;
>>>>>>> +    *ptr++ = 0x00000002; /* task info */
>>>>>>> +    *ptr++ = 0x0000001c;
>>>>>>> +    *ptr++ = 0x00000000;
>>>>>>> +    *ptr++ = 0x00000000;
>>>>>>> -    for (i = ib->length_dw; i < ib_size_dw; ++i)
>>>>>>> -        ib->ptr[i] = 0x0;
>>>>>>> +    *ptr++ = 0x00000008;
>>>>>>> +    *ptr++ = 0x08000001; /* op initialize */
>>>>>>> +
>>>>>>> +    ib->length_dw = ptr - ib->ptr;
>>>>>>> +
>>>>>>> +    memset32(ptr, 0, ib_size_dw - ib->length_dw);
>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>           amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
>>>>>>> @@ -1002,7 +1015,8 @@ static int 
>>>>>>> amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t 
>>>>>>> han
>>>>>>>       struct dma_fence *f = NULL;
>>>>>>>       uint32_t *ib_checksum = NULL;
>>>>>>>       uint64_t addr;
>>>>>>> -    int i, r;
>>>>>>> +    u32 *ptr;
>>>>>>> +    int r;
>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>           ib_size_dw += 8;
>>>>>>> @@ -1015,31 +1029,33 @@ static int 
>>>>>>> amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t 
>>>>>>> han
>>>>>>>           return r;
>>>>>>>       ib = &job->ibs[0];
>>>>>>> -    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>>>> -
>>>>>>>       ib->length_dw = 0;
>>>>>>> +    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>           ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 
>>>>>>> 0x11, true);
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000018;
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000001;
>>>>>>> -    ib->ptr[ib->length_dw++] = handle;
>>>>>>> -    ib->ptr[ib->length_dw++] = upper_32_bits(addr);
>>>>>>> -    ib->ptr[ib->length_dw++] = addr;
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>>>>> +    ptr = &ib->ptr[ib->length_dw];
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000014;
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000002;
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x0000001c;
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>>>>> +    *ptr++ = 0x00000018;
>>>>>>> +    *ptr++ = 0x00000001;
>>>>>>> +    *ptr++ = handle;
>>>>>>> +    *ptr++ = upper_32_bits(addr);
>>>>>>> +    *ptr++ = addr;
>>>>>>> +    *ptr++ = 0x00000000;
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000008;
>>>>>>> -    ib->ptr[ib->length_dw++] = 0x08000002; /* op close session */
>>>>>>> +    *ptr++ = 0x00000014;
>>>>>>> +    *ptr++ = 0x00000002;
>>>>>>> +    *ptr++ = 0x0000001c;
>>>>>>> +    *ptr++ = 0x00000000;
>>>>>>> +    *ptr++ = 0x00000000;
>>>>>>> -    for (i = ib->length_dw; i < ib_size_dw; ++i)
>>>>>>> -        ib->ptr[i] = 0x0;
>>>>>>> +    *ptr++ = 0x00000008;
>>>>>>> +    *ptr++ = 0x08000002; /* op close session */
>>>>>>> +
>>>>>>> +    ib->length_dw = ptr - ib->ptr;
>>>>>>> +
>>>>>>> +    memset32(ptr, 0, ib_size_dw - ib->length_dw);
>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>           amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
>>>>>>
>>>>>
>>>>
>>>
>>
> 

