Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB2ACD4F57
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 09:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEFDD10EB73;
	Tue, 19 May 2026 09:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3P/snxFW";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013037.outbound.protection.outlook.com
 [40.93.196.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E518910EB84
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 09:01:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdKIwJUzX73ujYWJRsGf5dCobcFNbp0etoNKaN+A9qB+MG2PtLkhTJTq0BNp94TxhbTQYgLVqWHdNfGHCx9lKqQSJNPR4gzo4XAWPX19GVbTr4Fa64FPNll1ARLFSrrdYB10SypQ0mpHSXTzODC0aUPVu5Ah95Uqg8lwl+r8mHHg80s/OtMp/4ezT+f7DrMeNLGDCSYhxw5tDtbjae6Xe0LKCyPfeKgd1UQkcpMQmg6iPurp6Fv2WKqapDUha79auSNi3T6/lI+dVBUbG7CEQKPg9lO87rZfF6BT9M7HznW1GKok3PhJLbcCrK5Lb3PRJj3rU/22LyXZNW0t8Gfyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bo5a9l9+IPYWVAfW9XGOAIDlqO0XDz2bre36+EWx3yE=;
 b=iX2TsDyGemOWR5TF2NvB1T6J2EFjERaDMqo7BPnp6AvIi7cEu4TinxtfpRxfer4DRpxSpYJEWAKEK5Co3w1t8cLm7Zmi4iryiifoExBzU+/n4JYasHEhNEpKrW+bLFr0tgw3EdNiiPIIwxUyRtB10fzrvRkHRDLp5XpTOL14VKc9c01k5cWYokUfcYxKySmHPHK8M7Du9Z9wetPA0AtX75yrN/8sG+u2uTLFHNpetDk/TNKKBMIgheQHPtgil7vd8CHNEyK+k7CuCprkoO/IiPcqGJ0rRM7huJ+R+Rgb2q/1vEtEP3oew7eM/8W1aezNYZq2gV+s7dOLo3sJCRH09w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo5a9l9+IPYWVAfW9XGOAIDlqO0XDz2bre36+EWx3yE=;
 b=3P/snxFWo/FJ5KnhINS7+bHJHIy5VzSHv1IYPzDz05MaTllcZ/4A6K5CoVHCvt1FARo0L54Aut+LObVFoHt7NqjQysLk+1mqO5amqkWszu5CWSVKhbNygDI40Gz3uWc9GPyNqCLTw5ppO7m8y6NeV1X2hPzMCN1zNSU92MdKgLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PPFC8B3B7859.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::622) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Tue, 19 May
 2026 09:01:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 09:01:55 +0000
Message-ID: <97a4608b-133b-4c87-ab61-ea45c638693d@amd.com>
Date: Tue, 19 May 2026 11:01:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm/amdgpu: Use placements of 256M GART segments for
 SI/CIK
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, John Olender <john.olender@gmail.com>,
 Liu Leo <Leo.Liu@amd.com>
References: <20260519082204.60811-1-timur.kristof@gmail.com>
 <20260519082204.60811-3-timur.kristof@gmail.com>
 <69dcb4d8-1199-45f7-88dc-c77efb248542@amd.com>
 <2219923.9o76ZdvQCi@timur-hyperion>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2219923.9o76ZdvQCi@timur-hyperion>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PPFC8B3B7859:EE_
X-MS-Office365-Filtering-Correlation-Id: f55492a7-4e8a-476a-676a-08deb5854677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|4143699003|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: P7pi3a1g2Kut23dXmeZj0bja3Ti/X8jkEr+CcMEJCAyvUe3kVOULOIaLcQSjdu6ZE37+o5S4VGcqkOJUBu11RSRrt7oIag4m46YpkSCGBbI8o8UxscdZoa3gdiHZqZ1qtqyLuCfGXv577M+QZ/ljgH4+jW0erJ2or/2N/sPq3Zu0FehWTwkdnLUcSDWFs+oZ1Q7pkT5KT67yFaRjCPkxhQmbWjNaqtB6UJ6M+JA1cH4g4SB6rGt6E9Fjgul7qJ1tjj1b6cRFWgXdM9ZUXIt0N/UQ09muCG+P/O07zHzQZlKO2xxZM0ZTtlFg3U/DsCiOu43diuFdRLw2fth6HDAUjkATaZrtvdI3RXZXC25ujR1n54/vf9zc0i1DFvpE36IilXRmC7fKlP2CqOhwBp+Tuu5WpbcNZoIMA3JrhbKin9qeieqYnPjpFreCYSTSVoHdbL+e/ZvpJMWeuFbNVsyJkwncQtaTeN2znnpPkL3A7bD6k2NZazqd2O5Ktmr+eXVVJjYThQXUIFNUTwFXYY9joio+r2gzJXxhjuylD/0XRQ4pAt/JFuOzgAFiKdAwbO4zsCmxnCmul6wtQEgJ+kUppJ8I/bk2NYWV0yeKuC6y5SNcwnAQTVrWT9ucN6yvQpu2O2NdKhlpn0td+a+qb9zqCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(4143699003)(18002099003)(22082099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHJTQUorbVFGU0RLdXNCT0kzb1B6aXljRDRZaERhNFUvMU9hLzBSQW5vQ25C?=
 =?utf-8?B?cU1DWmFEOTd1MFRuYUM5MUhCVG0xS25KK0xWYWszemkwZzVhSUN4SEtTRk5u?=
 =?utf-8?B?UWh4dnJqdFRKdzhld2ZoY2FYRVduUkVQLzJXcVJxMXV6UGhZSXI3eFkrS0hJ?=
 =?utf-8?B?MXVnbkF2Zis1eXk4NnRvRDhybjVrMUtjYmdiK1ZFUExPKy9RbmppNWd5Yldz?=
 =?utf-8?B?L1dpZThvZ3JHeTlzYjhIYms0UXhST3BtU0c1QUk0KzdmaHRQc21JWm9zdkVH?=
 =?utf-8?B?QzJiK2pCV3Aza2N1ZGZEbDNzUDd4bFV5RUdTNGFCQTdNYllSWVNxYWtYNW43?=
 =?utf-8?B?SjlMMmhLU0F4REhJQkdVVVRWY2haVDFqRkF2dUk2cS9adFBCM1dkbEQ5bktn?=
 =?utf-8?B?QTR4TGhvUGJrRTBJVFpxL21BbFg2SUVXMzk0dy8vWWRPczh1bko5ZEU5TDdH?=
 =?utf-8?B?NkM1d0xUL0JRQ3FoWmIzSkFiR29TZjlVeEhqcDFERXJKelIra2xIdVRxY3I2?=
 =?utf-8?B?eXVZQTBlQlVDZTQvZVA3Y0greFV2eE9TckEwMnA3S24rUGlRN3NDdWdCUFFi?=
 =?utf-8?B?VnV2VTlTWFFSUVExeXV6WkZoSmdraS9NTlE4UFUyNnBYYmoyckJ6akVrTFJy?=
 =?utf-8?B?QkxnRGRhUmxzSjBrTEV3Nks2bTNlZU03d2RreklITlNTUkljaG5GQ3FRdnZH?=
 =?utf-8?B?RU1ZSEFQYkVrbC9xMU5RcWdqWGRNQ3VTVVZjWC95WklJQzU4ZTFnUDdhcjJ5?=
 =?utf-8?B?RnFPZkxLQW53QUlDaXowVjVoaHgxVy9lNFVZYXhsWUJjL3kxbGsvL2I3Rmxx?=
 =?utf-8?B?S1dSRkd5UnRXeDFkTjZ0MVlGZ1VQdzNJUndUS3VRMUZmaE9yTUpjblNnMS8v?=
 =?utf-8?B?SHZ5RGloTlZRdkpZdHp2Y2RzR1BEdVhlOXNiMTF5Q244d29xNjEyZlJMc09Y?=
 =?utf-8?B?dlRHdnpLZUhIRGxwTWhUN3ZlUTEyZzU2bTFyeDFrMGhpWEZ6SFpNdHMrWWhm?=
 =?utf-8?B?anhrN2c4cXJFVjdTUnAxTnZGNkQ2UHFRWDM2VGhOejNJeHBDemxGUGJ6cVlK?=
 =?utf-8?B?QWEwcGkxSGRKRHhocVlzcGxDVEZubEhYZDh4bFlYNXQ3Y2pYUDdqaWZhTjRM?=
 =?utf-8?B?MUVRYWVtdjRiNnVyQlB6a0hPaVI3OVlLNnhRd0FqQ0tvOThSQUxGdmZ0YlZ0?=
 =?utf-8?B?Z2tlUWd6L09RK2dodC9wR0JOOUt1bmhlbHpaTmQxdkpaN1dNQ29QRjFGcEFu?=
 =?utf-8?B?TTNweGlKckpVZFFqWWpKcTZoVU04eEZxTHQrdGVrdFRwYThuMGI0ejMzYVNv?=
 =?utf-8?B?djBodHk5ckI1bVE0YldUaFJYUTV1VytSSjFQVFFKQzhWT1NpdmFoRmNjYzIx?=
 =?utf-8?B?NkZLWmNmWU9DdjNJVURCOGZaZEg5c1RBU1dNRkNwcXFKemZOUFAvUWU2SDlr?=
 =?utf-8?B?OUVrMElUL2RpYTVVUTFMOHJCK3d0ZGowcEJuTktoOFJiWVIxYmFQaHdGZkw2?=
 =?utf-8?B?bWQzdW5WbXVRRXNRMFBWMmdtVDcyMDRmWm9TK2dDNUU1cTcrRHU0ZG9HVDdP?=
 =?utf-8?B?RWlaK0NUc1FYQmdVM2JHWHBHcURBT3lTbmplYk5VUjUrSVpXMlZIdWRrMHBY?=
 =?utf-8?B?OTVQdUhnQi9jVWV6U1E2S1NqTllFNlVZSCtQbHNqdm9XU2M4RlBoS2JEQUJW?=
 =?utf-8?B?eDU5d3lLcHlMVEZHUjdNNEFLK2xEU01kUEI2TWZoSHZBQ1NjV0ZZU1NlOGNn?=
 =?utf-8?B?TVgrY1FaZHkrRW11UnZMNWZKVzExcjVSUzlVQ1lKZnpORXpRaGJ2WDZTaDIw?=
 =?utf-8?B?b1V6b1hKMiswcnkrbmw5bWJKY3YrYzlrRHhKdDVGZnhUK2xtNVRPbks0c2VX?=
 =?utf-8?B?QmJUSXF6RGNMT1dPM25STlZWV1B0L01ZN3lyZFo2NUYxOEplZENPYmNBazFS?=
 =?utf-8?B?ZFY2VzNLaFA4YXRPUWFkZ01NWHYwZ3FlKzI4NFAzOG8zTGNuejQ5bUhCTlZU?=
 =?utf-8?B?cmgxdE10SVQ1bnpXY2FvamlvKzJCSlVrY0xtUjJaYlZubDBXRWxYb1JvMWZ3?=
 =?utf-8?B?TUIrQ2ZVWTJEV0NBQklGdmhSM3I4aFhTeFNpczBBWGszU3h6elgwR1VsQ0ZD?=
 =?utf-8?B?cEdva1JrK2pjVlhMVTdOZ1I4cVl0cDRGNStjTDlXRTZZTGh3NE0wK1E1U1Jj?=
 =?utf-8?B?ZFBXZnptUldhejdGSHloeGwzdmFTK3NNRE5hSFRET3ExdzJiRTlKblJVRERa?=
 =?utf-8?B?a2NZT2tCUlZDQ1lML3BNWkJlYjFaYTZLYjJQZFB6SVBoVThTOXE3cklaNjhW?=
 =?utf-8?Q?I+kqakowS83QD/DWKT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55492a7-4e8a-476a-676a-08deb5854677
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:01:55.1891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLvTR91JY0Bmb/bqiVpKKCf+Bm9Yvzdo2BPNuHPeQqf8jfgck4owHVCATFUm7PnV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC8B3B7859
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

On 5/19/26 10:59, Timur Kristóf wrote:
> On Tuesday, May 19, 2026 10:54:10 AM Central European Summer Time Christian 
> König wrote:
>> On 5/19/26 10:22, Timur Kristóf wrote:
>>> UVD 4.x and older require that BOs don't cross 256M segments.
>>> We need to respect that in amdgpu_ttm_alloc_gart().
>>> We can't move the BOs later because GTT->GTT moves are
>>> not implemented. We also can't force all BOs to VRAM
>>> because that becomes very problematic in low VRAM scenarios.
>>>
>>> This fixes UVD CS BOs crossing 256M segments
>>> when they are placed in the GART.
>>
>> Clear NAK for that approach.
>>
>> This is the general TTM interface function and shouldn't have any HW
>> generation dependent code in it.
> 
> I don't see how else to solve this, since GTT->GTT moves are not implemented,
> so we can't move the BO to a suitable address later. We also can't move it to 
> VRAM.

GTT to GTT moves should be relatively easy to implement.

We just need to wait for the BO to be idle, unbind, move and bind again.

Regards,
Christian.

> 
> Please suggest a better approach if you don't like this one.
> 
> 
>>
>> Regards,
>> Christian.
>>
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4799
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 56 ++++++++++++++++++++++---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  3 ++
>>>  2 files changed, 53 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c index
>>> 6c6ab4dd6ea9..a106c7e77e26 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -959,6 +959,40 @@ static int amdgpu_ttm_backend_bind(struct ttm_device
>>> *bdev,> 
>>>  	return 0;
>>>  
>>>  }
>>>
>>> +/**
>>> + * amdgpu_ttm_fill_gart_256M_placements() - Fill placements array with
>>> 256M GART segments + *
>>> + * @bo: TTM buffer objects whose placements should be filled
>>> + * @placements: Pointer to an array of placements
>>> + * @max_placements: Size of the placements array
>>> + *
>>> + * Fill the specified placements array with 256M GART segments,
>>> + * starting from the highest address in order to reduce the
>>> + * contention of the lowest segment.
>>> + *
>>> + * Returns the number of placements filled.
>>> + */
>>> +u32 amdgpu_ttm_fill_gart_256M_placements(struct ttm_buffer_object *bo,
>>> +					 struct ttm_place 
> *placements,
>>> +					 u32 max_placements)
>>> +{
>>> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>>> +	u32 i;
>>> +
>>> +	/* Fill the placements array with 256M segments, starting from 
> highest.
>>> */ +	for (i = 0; i < max_placements; ++i) {
>>> +		if (i * SZ_256M >= adev->gmc.gart_size)
>>> +			break;
>>> +
>>> +		placements[i].lpfn = (adev->gmc.gart_size - i * 
> SZ_256M) >> PAGE_SHIFT;
>>> +		placements[i].fpfn = ALIGN_DOWN(placements[i].lpfn - 1, 
> SZ_256M >>
>>> PAGE_SHIFT); +		placements[i].mem_type = TTM_PL_TT;
>>> +		placements[i].flags = bo->resource->placement;
>>> +	}
>>> +
>>> +	return i;
>>> +}
>>> +
>>>
>>>  /*
>>>  
>>>   * amdgpu_ttm_alloc_gart - Make sure buffer object is accessible either
>>>   * through AGP or GART aperture.
>>>
>>> @@ -973,7 +1007,7 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object
>>> *bo)> 
>>>  	struct ttm_operation_ctx ctx = { false, false };
>>>  	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(bo->ttm);
>>>  	struct ttm_placement placement;
>>>
>>> -	struct ttm_place placements;
>>> +	struct ttm_place placements[AMDGPU_BO_MAX_PLACEMENTS];
>>>
>>>  	struct ttm_resource *tmp;
>>>  	uint64_t addr, flags;
>>>  	int r;
>>>
>>> @@ -987,11 +1021,21 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object
>>> *bo)> 
>>>  	/* allocate GART space */
>>>  	placement.num_placement = 1;
>>>
>>> -	placement.placement = &placements;
>>> -	placements.fpfn = 0;
>>> -	placements.lpfn = adev->gmc.gart_size >> PAGE_SHIFT;
>>> -	placements.mem_type = TTM_PL_TT;
>>> -	placements.flags = bo->resource->placement;
>>> +	placement.placement = &placements[0];
>>> +	placements[0].fpfn = 0;
>>> +	placements[0].lpfn = adev->gmc.gart_size >> PAGE_SHIFT;
>>> +	placements[0].mem_type = TTM_PL_TT;
>>> +	placements[0].flags = bo->resource->placement;
>>> +
>>> +	/*
>>> +	 * UVD 4.x and older require that BOs don't cross 256M segments.
>>> +	 * We need to respect that here. We can't move the BO later
>>> +	 * because GTT->GTT moves are not implemented.
>>> +	 */
>>> +	if (bo->base.size < SZ_256M && adev->family <= AMDGPU_FAMILY_KV)
>>> +		placement.num_placement =
>>> +			amdgpu_ttm_fill_gart_256M_placements(bo, 
> placements,
>>> +							     
> ARRAY_SIZE(placements));
>>>
>>>  	r = ttm_bo_mem_space(bo, &placement, &tmp, &ctx);
>>>  	if (unlikely(r))
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h index
>>> 2d72fa217274..e9de628c8d2d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -202,6 +202,9 @@ int amdgpu_ttm_clear_buffer(struct
>>> amdgpu_ttm_buffer_entity *entity,> 
>>>  			    u64 k_job_id);
>>>  
>>>  struct amdgpu_ttm_buffer_entity *amdgpu_ttm_next_clear_entity(struct
>>>  amdgpu_device *adev);> 
>>> +u32 amdgpu_ttm_fill_gart_256M_placements(struct ttm_buffer_object *bo,
>>> +					 struct ttm_place 
> *placements,
>>> +					 u32 max_placements);
>>>
>>>  int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>>>  void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>>  uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t
>>>  type);
> 
> 
> 
> 

