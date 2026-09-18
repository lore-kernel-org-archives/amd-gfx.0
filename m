Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D73C982DA
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 14:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43CB210E924;
	Fri, 18 Sep 2026 14:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A76nC4HP";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F111B10E924
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 14:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdMNS3a3Q98JJCtIFuJGVbWGGfT18LnoDl0xQGqmAaufCk4+1vVG2E5HJAMHlWISbREpIoFV9SX5BpFwwgM+w2zWO8Ocl3UwRs3Oj4rGNoLw17v4vJ2P5aCnDp0wJwcoTx/sMb9pzBs1U+UJIBmRpwkXVzsh2OBdxLCkjewlVq7v26vgdTIq1P780zAngFxpoaLwL/XYCjONTIY2x18jxf7kxRXT/BOzqWbbaE5EAhXrfU0sVmPypjT5siKQtRglZrTrbHgzq1keYyxbjri4+51FGSpO54zsHsWglNUiISGYsWNOy0A3xL6efna7B33AqVzfUcL2ZXxeViRHxMSDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OOMcQOQgu9KlOAF0o3fhJA8NeXk9yfDnGa+fbgw2xk=;
 b=s7kwlfBIogVHWJFciZasvNz4pbPiIqD9bXR4dNJgp+MP9OTHMFHNs6on2t6tAY6VEax8Gzte64zrWYb7y4/OXDYP2u8wMxv2iLrGlt7B43quVedVXDaYmM3N2ZiMRadLAi/GWg8NdtUhBPdv0Z8447+t+lkkrBj2ju2nRaE8QwV4PCYtolhsLbQahh/4BCqPi/RQeAMblVk8jGX6yGkUVdQ8Mui4ZN6yaHotPRcvVq55QAROd5gtGLZgTafCiuaqtSZI0DnFZYxYuiB+0omcgkjU5D3OWhMRZNpE/odx4UYUIj+SdtKsPmCauqVZ/9j21gUaEZR4XPCmqAR+UlTizg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OOMcQOQgu9KlOAF0o3fhJA8NeXk9yfDnGa+fbgw2xk=;
 b=A76nC4HPavDnYFr+ZNVFzsW4munUSxWCp7xeu6vaBridQoh1Qa3hiR5K+FtgFzJehwXItkfzH+1qT9bw0lJQIsrwqLX1B5KEZp2/CDAh2/w2ZtpuyGyN2sYRGZidqdVmYCm1D8bOBFoBkkBOXSHbLmc7SwMtHoD3poIeNWOm7eI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 14:58:35 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 14:58:35 +0000
Message-ID: <f0874f34-8f55-49a5-aee3-89c529f7f83a@amd.com>
Date: Fri, 18 Sep 2026 20:28:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] drm/amdgpu: More compact VCN IB emission
From: "Lazar, Lijo" <lijo.lazar@amd.com>
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
 <95af58a6-f89f-4430-9be2-d4d4a18dd1e9@amd.com>
 <6a1d885b-56bd-4b08-8d1e-cf0967bc7a14@amd.com>
Content-Language: en-US
In-Reply-To: <6a1d885b-56bd-4b08-8d1e-cf0967bc7a14@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH8PR12MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d25ec17-d336-4c8b-f3ad-08df1595505e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: jerGEGuslNnYOyTlJT58cqtr4H7fqjJzOkMTdt+GW7yMvrhk1G51NwUTNkwdFSF8AA1PUr2nyKlwqmuH6q2rLCs5YKOyS5hE8gXbnUrN349DfzANE6Mgls9/MpX/cqsgyIb6k9gIiv+f+rwUIGgNQ1WJfx+M2ouyMaskmrL5hbH3ZXgYLNrKRYIWazEin0gufAnLMGIlziQWFzmex8Jg7IIAzkjGOU4ZX656Ii2/PsBXYw6Bi1zcjLSo1D0bMg+lfCn7YtvH3vKCiItAHfbsAUmLUGUOPGb01HaAFcYTkOLTlgPU+txixIUd9VOri5pvHWFnzhL3Pr/kqid4Y/SG1Vbobo29q6knd8hkXcYOLpgCKFEokzYddmVleS6IXJST2xE+BHsbLnDFiJ6cgSi2RbXrovyVGy62tXUFdflBCIIUJoYs4K1BJWyakJP+TZRIpqbGPrTOP5o9P6zNF+LtxDaQaTdY4A4Rm2EbeROjysThv3SGqXT8NnERjJgrBZTdq5nFQaohBhHYf3n40CqZAZdV4LMh9qXPUr1KIJ/KO6RrHQ8cuNF0KWWeAnOIEPMUuDWwcOhiKdmrPSFkZ32vXHBxQJbEhzJyn20G9t9k1iHu8RbNwAxWnJHnRPV2LWJUM+zSmyn7Mh9G0+e3xaVUzuALpgeUxo7qcu3jO5u4/Yg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDFvV1lYemtiaWxVb2toek9hOWlTbmpNQlBiaU5hUkpjbG5vQnFwQ3lKaFVq?=
 =?utf-8?B?SlVkMGhZeTZGSU8zbnd4NXlQd2JvSzJLK1R4V2VjVm9RZFFhelFMNVc5VVp0?=
 =?utf-8?B?azZYVVhmbGJEU2lNd0pVbURTKzlTZ2JaVzJONjdhaUVnWTlFZk5KMTFleDds?=
 =?utf-8?B?bFJ6Ujk2ZjNOTDJJa0dLUTNXZlF6UzVhV1ByOE1yV2d4Wlp6Mk1NVWxvZ3RV?=
 =?utf-8?B?ZUJmVHdRa2dScWw4a2V3R0NOM2lQbXVTQTlGSzIvWVpEK0dkMmpHeUx6b0p6?=
 =?utf-8?B?TTVuM3FLOTBqRU93OHZLV0d3VGxaU1lOUURGdDBtREkyS01GZDRlNW5PUzFV?=
 =?utf-8?B?MndNaGR6WmNVdGszNHA3OWhJNENlUzFCRjVwVDh2LytXWGlVdmZOTmRkVVRQ?=
 =?utf-8?B?cmZYa1c3MlE3VW9nL1hZKzVucDJWSVEwRnIwbXZ1OHJWQnpwZHNKZGhOWTVI?=
 =?utf-8?B?RCtKTEZTeFA0UGRyVDlDSGl3QmFBRlVkdGEyYnlkYWZ1ajd2d25TT041Mm1L?=
 =?utf-8?B?Z2VTeWt3QnlQYmdaYVJ4MFB5WFgwZXpqOWdnVXNEQzdFdGczQ1kzcVFmam5v?=
 =?utf-8?B?STFRN1ZqWnJUV1p4N2lHQ3prODdWeUpvOFZFY2x2cEQxUWNjNnBhOHY1bDFx?=
 =?utf-8?B?NnNjNmRnd2hsbzNDUXo1MHhJOVpzckVrUlFrNStTaUlqNEFUQi9IMmxHUmQr?=
 =?utf-8?B?OENaTjFNODV1RUJERk56U21MSFg4QkhBT3NYVjU0L0ZYQU9uTFArUjcwRFR1?=
 =?utf-8?B?N1JGMGhCbmU2VHFvUnMrbFZkN3EybmRaV25HRlE1Q05Vek9SS0NWYzhseUNK?=
 =?utf-8?B?S2hTQWsxdjVmR0c5d28zTGxHK2NZUTNuMUpTUm8vVnIxbEdsRTQ3OW9lUUUr?=
 =?utf-8?B?UkxLbC9ycjRCZUZrTUdpbXZ4Y0R2V1IrMnQyUXlEazZsR1NKWWpoVUVDa0pk?=
 =?utf-8?B?RzZyNGIvd0hWbUNnME5rdXFmNG1JN09BOEFZT1dwa01JSjBJNmNaSTJBdXBR?=
 =?utf-8?B?VDVWTjhFY2tSeGdYTjVGa2NGRS9nT3lMQ09yQ2wvd1YxRGhZaDJ1a2drSU12?=
 =?utf-8?B?Z1RrcmJQNzlvMHdEVmZLT1NOWFNwWGV6N3FnRHM1VjBVcVYwYnFsNFFMY2E3?=
 =?utf-8?B?cWUvYU9Sb3o2K2treWN0OTdUUmRxbUFENFNER09YajQwMzlwb1p6Um9ra1Ey?=
 =?utf-8?B?cWYrWXpWLytSVHVCUHYzeEsxNXVIRTJJVFZxVkhKUGxsMUpyMVRuekc3cXBP?=
 =?utf-8?B?eXRiUzFhdHo2cFAvdkQ0QzI0YVRscVBsSGlrcEJHN3VxRVVNOVZNYklBTjBD?=
 =?utf-8?B?dFdoY3dYaWtuWkRvRkQ1eXRqK0JkM2FoN0VIVzhlZ3FjRnRoNGxnYzNHUkFr?=
 =?utf-8?B?blZxMTFtcVBjbXFnNitVMTdOakpLaW1vcVQ4eENldmd0MHhUUmErdHg1eU5z?=
 =?utf-8?B?OExwL2dGTm5mb200WlI2OU12Qk10RTZkaVpmL0ZpOGsrWEx6VHFZUnZucXFK?=
 =?utf-8?B?eXRzQ2VZTnZoWTlYbkwwQ215M1ZGZXdoYXNlS3RLZ2k3ZVhyN2R0RDA2MUc1?=
 =?utf-8?B?UE5KRU1nZ2pSM0xHKzU5RDl4SDNnaFZvbnlMVUpETUFHeHNpQXhudm9jNW9H?=
 =?utf-8?B?aFk4RWpjaWkrOElPZ3pscnJ2N0RVejRxbm9tRHZmU3JzM0REMkRnbjZWMWdr?=
 =?utf-8?B?a01QYTNJZ0lVV0ozL05Nc09nbWlDSTlpWGl0aTNPL0drV01LL1FLUHB1QnM2?=
 =?utf-8?B?WjF5S1FjUEZYWVVxTkM2QUR3SG52VHVOMThNSENWYk9wR2l3N0VDR0hpeVpN?=
 =?utf-8?B?RDRrUXRxZ0cydTNRNGxiZmI5b3NUbHB1bjU4ZjRSOVArS1lIVVBSM3gxVEZt?=
 =?utf-8?B?UTkxdjZNZDE0Yjl1T0czOHhOUWgwMnRGZnpIcmQ5NEJselpoUDdWNDl1NjlG?=
 =?utf-8?B?R0VpU1k1T0pXd09RRXR1Q1lJS2xRUHF6WEcyalRQcHNndHNBVnZ4ek1oZEU1?=
 =?utf-8?B?QXBhMlRjK0thZHBGakVka29FRVVTVENqeGRQcHQ4MU1TNkJEQ2VCQnhrc08w?=
 =?utf-8?B?eTFZcEJxN3U4Ym5oVkpybkd1N2N2azM1aVZPWXBkOWtTc1lTckxKWmxQbDRt?=
 =?utf-8?B?emI5T01pdDJDSVlrWDdtcFZUck0vM2wySzdrMVNyektucEY4Ty8wRlRiOCsy?=
 =?utf-8?B?WVkwckJSYzB5L0ZGcjdXZlcwMStFSFJwYWRQTUp4MXZNNHpwa0pNRXZ5Y1B4?=
 =?utf-8?B?UFhHRmRHK2RGRFhxbFZUdlM4dmlvcXBKQThsWW9xTWVJSkJBa0xReEgyeU05?=
 =?utf-8?Q?ccLtNf82K93R0cSzCZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d25ec17-d336-4c8b-f3ad-08df1595505e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:58:35.6814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IgEYI3Io3EE8884sOIzYUsbQoI1Vy3Xb16sTT6tbsz2d9Bg+MD62vjDcBdy2LBR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279
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



On 18-Sep-26 8:01 PM, Lazar, Lijo wrote:
> 
> 
> On 18-Sep-26 7:55 PM, Lazar, Lijo wrote:
>>
>>
>> On 18-Sep-26 7:37 PM, Tvrtko Ursulin wrote:
>>>
>>> On 18/09/2026 14:34, Lazar, Lijo wrote:
>>>> On 18-Sep-26 6:59 PM, Tvrtko Ursulin wrote:
>>>>>
>>>>> On 18/09/2026 14:23, Lazar, Lijo wrote:
>>>>>> On 18-Sep-26 6:43 PM, Tvrtko Ursulin wrote:
>>>>>>>
>>>>>>> On 18/09/2026 14:08, Lazar, Lijo wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 18-Sep-26 5:35 PM, Tvrtko Ursulin wrote:
>>>>>>>>> Avoid constant register reloads while emitting IBs by using a 
>>>>>>>>> local write
>>>>>>>>> pointer and only updating the size at the end of each helper.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>>>>>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>>>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>> ---
>>>>>>>>> v2:
>>>>>>>>>   *  Fix decode buffer overwrite
>>>>>>>>
>>>>>>>> Overall for this series, below type of calculation  -
>>>>>>>>
>>>>>>>>      ib->length_dw = ptr - ib->ptr;
>>>>>>>>
>>>>>>>> is not anticipating a case like below.
>>>>>>>>
>>>>>>>>          r = amdgpu_vcn_enc_get_create_msg(ring, 1, &ib, NULL);
>>>>>>>>          if (r)
>>>>>>>>                  goto error;
>>>>>>>>
>>>>>>>>          r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, &ib, &fence);
>>>>>>>>          if (r)
>>>>>>>>                  goto error;
>>>>>>>
>>>>>>> So amdgpu_vcn_enc_ring_test_ib() - are you saying there is a bug 
>>>>>>> there? Help me see it please.
>>>>>>>
>>>>>>> ib->length_dw update is enclosed in both of those helpers, same 
>>>>>>> as before the patch.
>>>>>>>
>>>>>>
>>>>>> What I'm saying is -
>>>>>>
>>>>>> It's the same ib pointer that is passed to back to back calls.
>>>>>>
>>>>>> Legacy implementation fills like -
>>>>>>
>>>>>> ib->ptr[ib->length_dw++]
>>>>>>
>>>>>> So no assumption that it is starting from offset 0 always. After 
>>>>>> the function is filled, length gets updated based on what is filled.
>>>>>>
>>>>>> I don't see the same with an assignment like
>>>>>>
>>>>>>      ib->length_dw = ptr - ib->ptr;
>>>>>
>>>>> Hm, but both of those helpers emit separate jobs with their own 
>>>>> respective IB.
>>>>>
>>>>
>>>> Wouldn't this kind of logic help to be on the safer side -
>>>>
>>>> ib->length_dw += ptr - &ib->ptr[start_size];
>>>
>>> I am not sure at which call sites you would suggest that?
>>>
>>> I used the pattern of whoever writes to the IB starts their block with:
>>>
>>>      u32 *ptr = &ib->ptr[ib->length_dw];
>>>
>>> Then they emit their stuff, and finally close with:
>>>
>>>      ib->length_dw = ptr - ib->ptr;
>>>
>>> By that design callers are safe since all are self-contained. I at 
>>> the moment do not see how making that more complicated would make it 
>>> safer.
>>>
>>
>> I would say all places where the function starts like below without 
>> keeping any assumptions.
>>
>>      ib->ptr[ib->length_dw++] = <value>;
>>
>> I don't see the complication with a code like this
>>
>>      ib->length_dw += ptr - &ib->ptr[ib->length_dw];
>>
>> It keeps the same behavior as before.
>>
> 
> As such the patch logic conflicts itself.
> 
> For this to be true -
>      ib->length_dw = ptr - ib->ptr;
> 
> It should start like.
> 
>      u32 *ptr = ib->ptr;
> 
> Now it starts like
>      u32 *ptr = &ib->ptr[ib->length_dw];
> 
> So if you feel the new way is self contained, I would expect a change 
> here as well. Otherwise, this could be read as a bug.
> 

Sorry for the noise. Got confused for a while; now I see what you meant.

Thanks,
Lijo

> Thanks,
> Lijo
> 
>> Thanks,
>> Lijo
>>
>>> Regards,
>>>
>>> Tvrtko
>>>
>>>>>>>>> ---
>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 134 ++++++++++++ 
>>>>>>>>> +-----------
>>>>>>>>>   1 file changed, 75 insertions(+), 59 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/ 
>>>>>>>>> gpu/ drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>> index 17db7264269e..2c367ee6e182 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>> @@ -622,9 +622,12 @@ static int amdgpu_vcn_dec_send_msg(struct 
>>>>>>>>> amdgpu_ring *ring,
>>>>>>>>>   {
>>>>>>>>>       u64 addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>>>>>>       struct amdgpu_device *adev = ring->adev;
>>>>>>>>> +    struct amdgpu_vcn_reg *internal = &adev->vcn.inst[ring- 
>>>>>>>>> >me].internal;
>>>>>>>>> +    uint32_t nop = PACKET0(internal->nop, 0);
>>>>>>>>>       struct dma_fence *f = NULL;
>>>>>>>>>       struct amdgpu_job *job;
>>>>>>>>>       struct amdgpu_ib *ib;
>>>>>>>>> +    uint32_t *ptr;
>>>>>>>>>       int i, r;
>>>>>>>>>       r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>>>>>>>>> @@ -635,15 +638,16 @@ static int amdgpu_vcn_dec_send_msg(struct 
>>>>>>>>> amdgpu_ring *ring,
>>>>>>>>>           goto err;
>>>>>>>>>       ib = &job->ibs[0];
>>>>>>>>> -    ib->ptr[0] = PACKET0(adev->vcn.inst[ring- 
>>>>>>>>> >me].internal.data0, 0);
>>>>>>>>> -    ib->ptr[1] = addr;
>>>>>>>>> -    ib->ptr[2] = PACKET0(adev->vcn.inst[ring- 
>>>>>>>>> >me].internal.data1, 0);
>>>>>>>>> -    ib->ptr[3] = addr >> 32;
>>>>>>>>> -    ib->ptr[4] = PACKET0(adev->vcn.inst[ring- 
>>>>>>>>> >me].internal.cmd, 0);
>>>>>>>>> -    ib->ptr[5] = 0;
>>>>>>>>> +    ptr = ib->ptr;
>>>>>>>>> +    *ptr++ = PACKET0(internal->data0, 0);
>>>>>>>>> +    *ptr++ = addr;
>>>>>>>>> +    *ptr++ = PACKET0(internal->data1, 0);
>>>>>>>>> +    *ptr++ = addr >> 32;
>>>>>>>>> +    *ptr++ = PACKET0(internal->cmd, 0);
>>>>>>>>> +    *ptr++ = 0;
>>>>>>>>>       for (i = 6; i < 16; i += 2) {
>>>>>>>>> -        ib->ptr[i] = PACKET0(adev->vcn.inst[ring- 
>>>>>>>>> >me].internal.nop, 0);
>>>>>>>>> -        ib->ptr[i+1] = 0;
>>>>>>>>> +        *ptr++ = nop;
>>>>>>>>> +        *ptr++ = 0;
>>>>>>>>>       }
>>>>>>>>>       ib->length_dw = 16;
>>>>>>>>> @@ -763,17 +767,20 @@ int amdgpu_vcn_dec_ring_test_ib(struct 
>>>>>>>>> amdgpu_ring *ring, long timeout)
>>>>>>>>>   static uint32_t *amdgpu_vcn_unified_ring_ib_header(struct 
>>>>>>>>> amdgpu_ib *ib,
>>>>>>>>>                           uint32_t ib_pack_in_dw, bool enc)
>>>>>>>>>   {
>>>>>>>>> +    u32 *ptr = &ib->ptr[ib->length_dw];
>>>>>>>>>       uint32_t *ib_checksum;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000010; /* single queue 
>>>>>>>>> checksum */
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x30000002;
>>>>>>>>> -    ib_checksum = &ib->ptr[ib->length_dw++];
>>>>>>>>> -    ib->ptr[ib->length_dw++] = ib_pack_in_dw;
>>>>>>>>> +    *ptr++ = 0x00000010; /* single queue checksum */
>>>>>>>>> +    *ptr++ = 0x30000002;
>>>>>>>>> +    ib_checksum = ptr++;
>>>>>>>>> +    *ptr++ = ib_pack_in_dw;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000010; /* engine info */
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x30000001;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = enc ? 0x2 : 0x3;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = ib_pack_in_dw * sizeof(uint32_t);
>>>>>>>>> +    *ptr++ = 0x00000010; /* engine info */
>>>>>>>>> +    *ptr++ = 0x30000001;
>>>>>>>>> +    *ptr++ = enc ? 0x2 : 0x3;
>>>>>>>>> +    *ptr++ = ib_pack_in_dw * sizeof(uint32_t);
>>>>>>>>> +
>>>>>>>>> +    ib->length_dw = ptr - ib->ptr;
>>>>>>>>>       return ib_checksum;
>>>>>>>>>   }
>>>>>>>>> @@ -803,7 +810,8 @@ static int 
>>>>>>>>> amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>>>>>>>>>       uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>>>>>>       uint32_t *ib_checksum;
>>>>>>>>>       uint32_t ib_pack_in_dw;
>>>>>>>>> -    int i, r;
>>>>>>>>> +    u32 *ptr;
>>>>>>>>> +    int r;
>>>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>>>           ib_size_dw += 8;
>>>>>>>>> @@ -825,18 +833,20 @@ static int 
>>>>>>>>> amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>>>>>>>>>           ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 
>>>>>>>>> ib_pack_in_dw, false);
>>>>>>>>>       }
>>>>>>>>> -    ib->ptr[ib->length_dw++] = sizeof(struct 
>>>>>>>>> amdgpu_vcn_decode_buffer) + 8;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 
>>>>>>>>> cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
>>>>>>>>> -    decode_buffer = (struct amdgpu_vcn_decode_buffer *)&(ib- 
>>>>>>>>> >ptr[ib- >length_dw]);
>>>>>>>>> -    ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
>>>>>>>>> +    ptr = &ib->ptr[ib->length_dw];
>>>>>>>>> +
>>>>>>>>> +    *ptr++ = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
>>>>>>>>> +    *ptr++ = cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
>>>>>>>>> +    decode_buffer = (struct amdgpu_vcn_decode_buffer *)ptr;
>>>>>>>>> +    ptr += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
>>>>>>>>> +    ib->length_dw = ptr - ib->ptr;
>>>>>>>>>       memset(decode_buffer, 0, sizeof(struct 
>>>>>>>>> amdgpu_vcn_decode_buffer));
>>>>>>>>>       decode_buffer->valid_buf_flag |= 
>>>>>>>>> cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
>>>>>>>>>       decode_buffer->msg_buffer_address_hi = cpu_to_le32(addr 
>>>>>>>>> >> 32);
>>>>>>>>>       decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
>>>>>>>>> -    for (i = ib->length_dw; i < ib_size_dw; ++i)
>>>>>>>>> -        ib->ptr[i] = 0x0;
>>>>>>>>> +    memset32(ptr, 0, ib_size_dw - ib->length_dw);
>>>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>>>           amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 
>>>>>>>>> ib_pack_in_dw);
>>>>>>>>> @@ -934,7 +944,8 @@ static int 
>>>>>>>>> amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, 
>>>>>>>>> uint32_t hand
>>>>>>>>>       struct dma_fence *f = NULL;
>>>>>>>>>       uint32_t *ib_checksum = NULL;
>>>>>>>>>       uint64_t addr;
>>>>>>>>> -    int i, r;
>>>>>>>>> +    u32 *ptr;
>>>>>>>>> +    int r;
>>>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>>>           ib_size_dw += 8;
>>>>>>>>> @@ -947,31 +958,33 @@ static int 
>>>>>>>>> amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, 
>>>>>>>>> uint32_t hand
>>>>>>>>>           return r;
>>>>>>>>>       ib = &job->ibs[0];
>>>>>>>>> -    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>>>>>> -
>>>>>>>>>       ib->length_dw = 0;
>>>>>>>>> +    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>>>           ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 
>>>>>>>>> 0x11, true);
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000018;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000001; /* session info */
>>>>>>>>> -    ib->ptr[ib->length_dw++] = handle;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = upper_32_bits(addr);
>>>>>>>>> -    ib->ptr[ib->length_dw++] = addr;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>>>>>>> +    ptr = &ib->ptr[ib->length_dw];
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000014;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000002; /* task info */
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x0000001c;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>>>>>>> +    *ptr++ = 0x00000018;
>>>>>>>>> +    *ptr++ = 0x00000001; /* session info */
>>>>>>>>> +    *ptr++ = handle;
>>>>>>>>> +    *ptr++ = upper_32_bits(addr);
>>>>>>>>> +    *ptr++ = addr;
>>>>>>>>> +    *ptr++ = 0x00000000;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000008;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x08000001; /* op initialize */
>>>>>>>>> +    *ptr++ = 0x00000014;
>>>>>>>>> +    *ptr++ = 0x00000002; /* task info */
>>>>>>>>> +    *ptr++ = 0x0000001c;
>>>>>>>>> +    *ptr++ = 0x00000000;
>>>>>>>>> +    *ptr++ = 0x00000000;
>>>>>>>>> -    for (i = ib->length_dw; i < ib_size_dw; ++i)
>>>>>>>>> -        ib->ptr[i] = 0x0;
>>>>>>>>> +    *ptr++ = 0x00000008;
>>>>>>>>> +    *ptr++ = 0x08000001; /* op initialize */
>>>>>>>>> +
>>>>>>>>> +    ib->length_dw = ptr - ib->ptr;
>>>>>>>>> +
>>>>>>>>> +    memset32(ptr, 0, ib_size_dw - ib->length_dw);
>>>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>>>           amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
>>>>>>>>> @@ -1002,7 +1015,8 @@ static int 
>>>>>>>>> amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, 
>>>>>>>>> uint32_t han
>>>>>>>>>       struct dma_fence *f = NULL;
>>>>>>>>>       uint32_t *ib_checksum = NULL;
>>>>>>>>>       uint64_t addr;
>>>>>>>>> -    int i, r;
>>>>>>>>> +    u32 *ptr;
>>>>>>>>> +    int r;
>>>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>>>           ib_size_dw += 8;
>>>>>>>>> @@ -1015,31 +1029,33 @@ static int 
>>>>>>>>> amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, 
>>>>>>>>> uint32_t han
>>>>>>>>>           return r;
>>>>>>>>>       ib = &job->ibs[0];
>>>>>>>>> -    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>>>>>> -
>>>>>>>>>       ib->length_dw = 0;
>>>>>>>>> +    addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>>>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>>>           ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 
>>>>>>>>> 0x11, true);
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000018;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000001;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = handle;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = upper_32_bits(addr);
>>>>>>>>> -    ib->ptr[ib->length_dw++] = addr;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>>>>>>> +    ptr = &ib->ptr[ib->length_dw];
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000014;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000002;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x0000001c;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000000;
>>>>>>>>> +    *ptr++ = 0x00000018;
>>>>>>>>> +    *ptr++ = 0x00000001;
>>>>>>>>> +    *ptr++ = handle;
>>>>>>>>> +    *ptr++ = upper_32_bits(addr);
>>>>>>>>> +    *ptr++ = addr;
>>>>>>>>> +    *ptr++ = 0x00000000;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x00000008;
>>>>>>>>> -    ib->ptr[ib->length_dw++] = 0x08000002; /* op close session */
>>>>>>>>> +    *ptr++ = 0x00000014;
>>>>>>>>> +    *ptr++ = 0x00000002;
>>>>>>>>> +    *ptr++ = 0x0000001c;
>>>>>>>>> +    *ptr++ = 0x00000000;
>>>>>>>>> +    *ptr++ = 0x00000000;
>>>>>>>>> -    for (i = ib->length_dw; i < ib_size_dw; ++i)
>>>>>>>>> -        ib->ptr[i] = 0x0;
>>>>>>>>> +    *ptr++ = 0x00000008;
>>>>>>>>> +    *ptr++ = 0x08000002; /* op close session */
>>>>>>>>> +
>>>>>>>>> +    ib->length_dw = ptr - ib->ptr;
>>>>>>>>> +
>>>>>>>>> +    memset32(ptr, 0, ib_size_dw - ib->length_dw);
>>>>>>>>>       if (adev->vcn.inst[ring->me].using_unified_queue)
>>>>>>>>>           amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

