Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D08C6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 11:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5EDE10FC81;
	Tue,  2 Apr 2024 11:38:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gDdJcOo5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2118.outbound.protection.outlook.com [40.107.223.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A8EF10FC81
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 11:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzhs90ods+fhwUANZhbAFD9C0a5H7VvmsnNvzgSxFoQH5Qz9ZWBR4xo9GWtiHoNdC3zub4Dc7djaoAIEGhSUCwTTtWbCG8PMoEtsOfg/UsCOrkX3/A4QOq2KJVX1ouDE83GCy7QLTrLfmNT8L2YGnQQtRHnnFdNSyGt/PqP5tynvpuU5YMC+4S8qzD01ls61j1uLUOt3n5eL3VPOOgoVb2qdZYu698+MKPPCRsCLVjtUjdSJlrqR1wxMft48h0ofTtzdznb7Nq2C0Nag7M+MMwCucFBDTlfJt5Yvqak0su3mLRgOav+TJKSR0A/es3PEtTmZJ6pyU9q/QaSAtqr25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GxXFe6NXSeZ3HTWG40V5qVVE8kx/VPiXasNHmoOO9w=;
 b=T7pJ6jSnHrWbg3kZSL90BZZdllWdqWIX59wRKxDLsoM2HW50zOYjEoTCqMMlqbVq85e7DFwI4fhC6Z9ON5oJbFaBApHU9oYc+3lfsM0l3Z+Xu8e+Xl0JLInwdtWlgzr/cx4y069eaI9qb4w4nqRWhRPpPUsDD7xmKc9wSeGF1I/l/jcnZJI8imEgvtO/R7+n/ag4GbBy414lIWtYKgkjrhYpa9CWsjVj5qTX/8Z9yhMTWJtblX5EPhKqtJe6RyAyIgCpb4X8IYlvzl7hoHopf3YBF/XqyDubT12iK3iaY3LC33pSaj8tPxjqPuH6UtJHzcXxH/ggP1h5oFqC78MGmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GxXFe6NXSeZ3HTWG40V5qVVE8kx/VPiXasNHmoOO9w=;
 b=gDdJcOo5ET6ZIFLxRqsZQpWpKPhZkEpQN34d5wwz8K5YSIYNsyQnoc1nl3QimZvgl9FqDF4Ovf+QKSylJM0rX0VRJiG2ZwN63ePT8Mh5I5wi7+5xF3MDoAYuaipWKWVDQ28t/T6jbPZB6D8Q4XdcXhxzopINqzOg/+HUXfeopk4=
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:38:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 11:38:14 +0000
Message-ID: <ff4041d3-de4f-4171-b1df-455219baec33@amd.com>
Date: Tue, 2 Apr 2024 13:38:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clear set_q_mode_offs when VM changed
To: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240402063737.2935698-1-zhenguo.yin@amd.com>
 <1fbcd7b2-d152-4931-a7c7-2cc82ff9b543@amd.com>
 <SA1PR12MB6680D43F47AD24B03AFC4941E93E2@SA1PR12MB6680.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB6680D43F47AD24B03AFC4941E93E2@SA1PR12MB6680.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7782:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6p3R7mLQAIYogsmkwRlXdQztvPVXrZ7WGGe/13D8dJwL6/8wsrIcTArk1TdQEIGnwNXhqqbBWfEmTm1K4gIn35tUz1z8JDqTYti+Qjw2R2365DweEkxTCEWFdAC5U+tPy+GvsjOFJ6JaBsJiKOZugEAAYNx2ctJx0g8BjvxNu7b87it7u69R7ROx3ovODyAJ16/zOrpPRPy/tAFD2lfHyRkwfoZ9KLcqYl3MUEfVCkkJ5jnI/dXcZpopKX4r8aTODXpjNX1NJ/vLURKpzasP5EoddLwNOb94SrB7iNU+2R8kv0z6FQAFIfrpiCBCThbWxhxWkPRIDFbPbP+cSX9yKzh7QNiVHQBjkdOdzQkl1g3bZho2huWNoRKEKzBy7qG+TT9kpOy/pY3A72abvEG53BcbKaGSkKl+pIDqFFjbAmmK3kvZOC3xib9jBScFwMoZION6wSgQIx9v+ZW8BaorFYIeflKZsn4zx1USV6FeSWGxtdb8WwKzQgiNdWVA1KsqKx1wGeQkz5VzOuPs2BxrWN/8hd2xt+CFDgBStm8p+VxpymOtuE5C5o8iJayp7xHELqlOKy+5QUwfg+DtwXDpA0j8TrTf2+mc2GNH9Lkeom3d9t9url3YInI2cs1j8s4DHKFfFYvB5cb5u0mf3diRYRBjjsjPOBZVNAcXFJSZxJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWw5NlFUVVlBb3dBVWIwcTh5cGRlZjFHMnF5dTJvRW1zRzdvNUNnRzlMVlVH?=
 =?utf-8?B?QjlHWk1MdzBLK0U4WHVhZk5HV2F1UnMzN0NJOWNwN0hJdFBLbWdWUVo5SFZF?=
 =?utf-8?B?U3RQT0MzcmlyRWlUQllPOG15dXQySDd6VEZQY1JBd2FLQ2hUdHFSQTdva3Fn?=
 =?utf-8?B?aUxqMDRkUFJoN3NZbldPS0xLeTExYXdES1hndUVsaWxtNk56VlZjK0FhM3Iz?=
 =?utf-8?B?KzMyNXJxVmlkdWRRbUZYNGM2ZllqcU41ZUFUcGtwMm96YThjQ0hkM0RZaDg2?=
 =?utf-8?B?dnNFbDVrdUFNL3crY2pNOTU1eXY0VUpabW5LSzEzN0YvUlV3MkhRL2hlWjA5?=
 =?utf-8?B?aCtxOXloWDhuSHRvWndDLytsYUJVVHBmYkhGWm9OdSthMEZmYm1WZ013aW5r?=
 =?utf-8?B?WGVnOE5lTnQyVW02a2lPZUxVK2VseWlCY25WbW5HZ0NnRnhTeXhXTzVURUlv?=
 =?utf-8?B?czVpYlZPdlNkc2pPcFpDUG9LU0p4T0lmQWptWGtTTU9qTVNZdU5QUnVjMFUv?=
 =?utf-8?B?OEsxS05Ra2pFakxMWlYzUEFvOGcwRmZ3UWNraGxzR0ZEblhMMTliZ2xxa3RI?=
 =?utf-8?B?SjdUaTlOT0EwdmlYV1ZNdjFyRXJKanp6RTBwNEJlVnBOSVRXOUJwSDdXYnJx?=
 =?utf-8?B?MlZIeWE1UmVwajYxZHhhMzRDYTJWdG5BaDJzdTVtdmhQOFpkcU56Nmp1RkFq?=
 =?utf-8?B?L055ekJTcktoenh0WXpxODUyN0Q4K0dGTFlwdWkyTDZWYnp4U0E5aWpJcDA3?=
 =?utf-8?B?QW82cUZaTitqWDFzK1R3bnhYV2NpbzlDNEYwUFR3MWJkUXFFcGY1ZFVPWWh5?=
 =?utf-8?B?V20rNWlDWTJKR1RIYVIwUHBrS0lnTE9GWmlmVFZZVVJGZGtqajlUZ3phSXQz?=
 =?utf-8?B?TDlhd29XTTluTlFqdFBDWVRJQTdIb0ROcWZNK1RsWEtieUNBWDBxcGRvYUdy?=
 =?utf-8?B?WFlYNktxMVU3YXdIemJWMEVKV0NaTUZCZkRvc2NJOWdESmpwY1dGRXVQVldv?=
 =?utf-8?B?RFVmNXg5N0tmRVVPcHFoVjJIM2E5TmtlY3Rya2Zicjg5TGRpd2wyUlpCVGJW?=
 =?utf-8?B?SjFtVmIvVzBCZGpVcGRkbzd2K0VJSFVnS1cxcFZacExyNTIvZUxybmFwckk5?=
 =?utf-8?B?OUJ2dTFxTTJqOE5iV3RPVndDcUFyQjdUWERXVHBiS1Azenk2a25CYzhZWnNK?=
 =?utf-8?B?NHhHR3VPOHhueEY5MDZtTTlmMm14Vm1ocUthazlYWC92NVI0Ni9rdXpwZ2xy?=
 =?utf-8?B?dmRZaS85MWRZZlpVU3hXV2FnTnJFampkZXB6dzJlZXhZWXEyc0t5bTR4R2lH?=
 =?utf-8?B?OGFmb2t6TENTeUFpQ0Q5OXJOcHIwTnA2ajViRG4zdUVWdEVGWXVaNG5DVTRu?=
 =?utf-8?B?RkNRWkJock9KRFk4T0svWmUvMnpielpsTitpL2pGMWVLOE5yTzNIeVYvV0po?=
 =?utf-8?B?WHlHZlovb0ViTFpsaThkMmhmWW0vY21uL0pzWW1DNFE5UG9rVVpNa0QvWmN3?=
 =?utf-8?B?VVN5OXUrS1JXSkE2TGlGUCtDVDJoZTU5WXJHR0hWUkRVNU50SHBranlabC9m?=
 =?utf-8?B?cXFRdWZJd0tzc1ZFR1YrTlVNNi9NYlhZd1VkSGY3Q0Vyb1VicVQybDVBZk1J?=
 =?utf-8?B?ZGF4RGxtYjlmb0ZLVURhSG9WZnNacTRQa0VxWUplWng1M3Jlb1hOejNOaW1P?=
 =?utf-8?B?b2RaZXpwNWNGTDJwSFg3TDBTS04vRTV3dVcrUjZFVTV1SEl5aTBVd0R1MHd5?=
 =?utf-8?B?cDd1WTVaMGx0d0RYR1IrMk1nMkEzRHoyOW9oSzJWQWVVNUthMThwODl5bHRO?=
 =?utf-8?B?aGw2Zk1IQVVDUGI1R0wzL3ZYZEtqOGlCUU40YW04R21XVTFZdnFRQk9walRQ?=
 =?utf-8?B?ZW5iRFFrZnhvU0RLWStZNnFuZUQ5cW14bWdMK3Rxd2luc1AzaUhybHlINHo4?=
 =?utf-8?B?SVMrZHZzbWNUcmR1WmFoOFZrRXVPRllISUswbVI1cFU3NWZqa2tJY3N5RmUv?=
 =?utf-8?B?cGpUeG04cnJ3bVVHWUw0bFVSSmhRdFRBS2tVL2Zza1JudHBpMzk1U3ZqcUht?=
 =?utf-8?B?amVPVUUraDBlTVNPbDY5ZHlUcHZSV3ZhdGpmSHhZT3ZNdVNCMFJpcXBFbGQr?=
 =?utf-8?Q?FrnJGxG1shv20Dx2s1EpWLvB/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c037f4-607a-4570-b49d-08dc5309622a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:38:14.8953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ll+azdifDAWzRtZdw05VabuII8LgF9HvuGMgtz25vjEDkTM8cG8/vYaW2/GsoF90
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
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

If this solution here works then stick with that for now.

At least I still hope to switch to user queues sometimes soon and that 
would completely avoid this problem here in the first place.

Regards,
Christian.


Am 02.04.24 um 10:35 schrieb Yin, ZhenGuo (Chris):
> [AMD Official Use Only - General]
>
> Yeah, I agree.  But I have no idea which place is better.
>
> Best,
> Zhenguo
> Cloud-GPU Core team, SRDC
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Tuesday, April 2, 2024 4:14 PM
> To: Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: clear set_q_mode_offs when VM changed
>
> Am 02.04.24 um 08:37 schrieb ZhenGuo Yin:
>> [Why]
>> set_q_mode_offs don't get cleared after GPU reset, nexting SET_Q_MODE
>> packet to init shadow memory will be skiped, hence there has a page fault.
>>
>> [How]
>> VM flush is needed after GPU reset, clear set_q_mode_offs when
>> emitting VM flush.
>>
>> Fixes: 8dad9c062355 ("drm/amdgpu: workaround to avoid SET_Q_MODE
>> packets v2")
>> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
> Good catch, yeah it probably doesn't make much sense to execute this after a VM flush.
>
> Reviewed-by: Christian König <christian.koenig@amd.com>
>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 7a906318e451..c11c6299711e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -5465,6 +5465,7 @@ static void gfx_v11_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
>>        /* Make sure that we can't skip the SET_Q_MODE packets when the VM
>>         * changed in any way.
>>         */
>> +     ring->set_q_mode_offs = 0;
>>        ring->set_q_mode_ptr = NULL;
>>    }
>>

