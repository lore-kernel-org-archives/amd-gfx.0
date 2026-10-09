Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388FCCA601F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 18:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B09510EAAB;
	Fri,  9 Oct 2026 18:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2/f9hwIM";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012049.outbound.protection.outlook.com
 [40.93.195.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EE6B10E1A8
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 18:00:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueIO8vDY8moihgxmv79pgU35EFEDWqRe4VijU3bm/9bkSHx6wJVsmbiim02tQQsFWRN0i0eX9K2kLT0bs7OQXm7flMX9EShR92+I0uKb9AcNF6NCe5eWLfUXAyzh2lVWuee7n80LxMuANBsg5rTLC+ns0D1vkX8D54zkhzZ1e+KpPNmYG5qwhA+vN71Q/wB8/8tSBkZ3E1PybUs2KoYnH2URvRnbt5UEZkOscStd/nc4COOOpLzDkEymz6HxuXpAisEeuO8svJgFNk+cO+365ZfEU3nHGxcRcWsDwm/hy9O7e8Qw1GLmvYFJfTzGAQ/YURl1uZr6uDaZyFfzEGZh0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhOzRxRV9oEyITy5rOhkpNWGFD30nGWKkZ/jba9+xnI=;
 b=PtZ/fI4qxHrPOnhmt8AWOAjDQi9QqmSeee14LeK2ewwZKtMC4HJZgow9Gz4TwnPrEojqbIPoRouRbVjTn26Nx3B9vUcLD3OHkPW/lhqTlL8DrssTnhAgCAUTLl1GVrKdnVgfaRFaq8sYD47dDlXBR2qDOLN18uEt7xge4ZDosyKrTxLml9Y9sNkBjS/IPXG3GuGWbPiJw5NVXW06hooHRsh1o2zYrihPADDj2bYlsplxYR397LbCDb6QMX2kUSrWlE+OLAQ0Exjb/sm09Cj0x3HCUwYEpPbxRmYRQ+d8Y/OshQWJSXMo93Oxu3gQSXecnJhxofu0KDHtLJPHLlWTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhOzRxRV9oEyITy5rOhkpNWGFD30nGWKkZ/jba9+xnI=;
 b=2/f9hwIMg3MPfqc/E34JFpGNGlA5HAvsn40HjhzHJnVTDmf/QtHo/xNSkz9DRoIiPYHyJKKErkDZJQAiDJWhs5vp92+THtgovfikGvqv7RfNRv2WklCqE4xAAUzHmkfvuBN0Iu80Oh2V+WgydpdY5PazzGhkx7LtWPwaKqJWqjs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by IA0PR12MB7625.namprd12.prod.outlook.com
 (2603:10b6:208:439::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 18:00:04 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:00:04 +0000
Content-Type: multipart/alternative;
 boundary="------------giZOM3G4ccAQKCsAVlptdkfw"
Message-ID: <90be0ade-a7d3-45bc-b83a-4d28c1b6bcf6@amd.com>
Date: Fri, 9 Oct 2026 14:00:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: place GFX12 compute queue MQDs in CPU-visible
 VRAM
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Geramy Loveless <gloveless@jqluv.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <01534506-891e-4d0d-8d0c-fb5e82264c03@jqluv.com>
 <01f9a0f8-63c3-4e84-a17e-51ea8f9b6104@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <01f9a0f8-63c3-4e84-a17e-51ea8f9b6104@amd.com>
X-ClientProxiedBy: YQZPR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::14) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: a9be8dc8-ba41-4e44-dc44-08df262f253f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: 8YB8EdxIgZUnELpws6DtID8iSfkJd/QtBnyX/8rHz0HhtYH4L3u8C1CaCL/Htz4RdWLbD9CFloEzy4t2xrSwq/0hkRlXkMPeRnsvVQj6IU/so+EdAerssuDu+BKzEkvVTxqPavcrxhhah/ttLkMZJ/R5x87QvpCIDVD1WcUBaj2MRteN9hpp7QzmEDTa3rUEdmKu00WiNFJdz6fB3J+EuuLQNZdXllOU0ZZX776QRNBEhEIQ0pjeOyWtR3g0rRLGZvSjshyhTBCk21FY6WfQ1xug3Q+VNPniE9az1vYONO63ydi3kXfqFmTAqKF5ZoDkrHYJgF1uEfs4/ctvoEVvdTB79P56RahhtOEQIMF9RUhk1LsfavFAeBHNHL2VIEH64d3jiND8NKi7mB3viPBQI8SQYoy03XPeX7D6Tw1JEohknYrUO3PZfSP7tQG8KHY66yoFIAQL67t1ukO5326TDokCiEu1dj2FW0rd+xuOdr9mZpzCjnQOvqyNs84dQO8wazdAWKDvmUbRtyI7om1hMKs93Cfs0TQCRD1WnY05oZc0Xc77bp9HCswj/0V6ShyvwllG6+yzp7z3OQFmHEAiMoCNe4M/MQzvc7JMzn1r3q+1Y3sHKqG4BcGmXnqCSdpl8VtY+jutbjV6zJJGVPqPdEMBBHQDQAkdEuF5uZCxh4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NndIN1pGYnpJQkFLaHZNYjN6dEFScjlhUzI5bTNEOHNNQ2xEZEluRnVyOFh3?=
 =?utf-8?B?YlV1TFFyV2FkNWlQZWZTVkorMDJCUzAzSXRoRTA5RDRpVXhHT3FxS0lBREhG?=
 =?utf-8?B?NGp6QythZEY0OUhsdjRYUTZBU1o5Z0JxT0YrWXVGaERXRnRtQkJQaElXM3l0?=
 =?utf-8?B?MFhlcTRTWXEvYmNrbFV5ZE9oSWVrUXhNRFhjY3R3TlREbnJhN002a3g5UkIr?=
 =?utf-8?B?TlM1QUdCYTlkMzd6Q3BPT0NxOHpFMndncUZiTytDSkhVYThWOW55b2hWVTlQ?=
 =?utf-8?B?QkZ0SEFJMmZvVytJOExHRk5KbTd0U1FkSXdERG5rSUVISjE1WFlZdzFWN2xW?=
 =?utf-8?B?cFp0OHlhMWw2VUZGRkVRZHc4QXpMREV0RzJGbWQrY1Ezd0U4NGZheG9JalM4?=
 =?utf-8?B?N3J3VHZiTlpIeGJ6Vmh1b25XSTY1aS9hc242QmFmeTl3YTIwcUk2bUh6TWsv?=
 =?utf-8?B?Y3ZTVWJ4NzA1R09TU3RzM2dtdmwwME5HYmJzTm1CRlJLR2RTa2x3K1hDVWwx?=
 =?utf-8?B?eTNXdDk5cEt3NFFCSk5nbW5LUHRYZ0J5cmZVZTMxNTh2MnFtSHVZYjA4ek8r?=
 =?utf-8?B?eWRmY2o4WFFkVGpCa1gzbVFwVWhaUXhqNzdlMDFjeEpncmVVWEJpaFhIOTU5?=
 =?utf-8?B?UFlVdmcyMTV1V283Rkx1d2tQRHR3a3RYQkdkb3JsaUxpRk5RSEdVV3NSek1O?=
 =?utf-8?B?aWluVHUwbXVobGpMQkhJWmZ0d1c0WFhUc2FWL2xscEZXaUNyNW0wK3lYd2xk?=
 =?utf-8?B?NkVjYitKNDhXRVFNeWlvTmNHeUdKVVhOczY1UGxENHA0eDZTYzhmNG1aV1Zn?=
 =?utf-8?B?S3RaK1UxT0xIcmtRcnczNTBMLy9pemxvQ3dwZ3FKVU9UZndDcXRjSURsY3Za?=
 =?utf-8?B?cDdYdGNZZDExdnBLWFJ5aEFwbzM1bWpCSjBLUy9NTC84QnFNR0I2eDc1blJl?=
 =?utf-8?B?RjlERGNtN2lMZzFOVEVocW5ySnJWQVkwNWlEek44RUlCQVRvZVJKMVJnd0xR?=
 =?utf-8?B?QWhib1VxejJhQnN5SUZ3Vjdwb2s0eDlsMUZRMG04WGZKRk9pbno1UE5hWGJ1?=
 =?utf-8?B?QWRZZ0FISXlRZDBVL2FSZGdoeExQRmdjTkVmQkZIelZ3aFRmMXk2QjBvLzhI?=
 =?utf-8?B?MU1TSTNnUHoyRnRGU3JNa0tBYks0cENBYm9ERUFKbHZzY3d6bkF2Y1NIaFFI?=
 =?utf-8?B?dlByZVNSM2xQMWFXVkwzamVGRmJYOERuZWM0QU1xU2ZDTjQ2Wk9mM0tKWGdr?=
 =?utf-8?B?TkN6YWN6L09hOFJFTlAxY1B1Nmh3dXdJNWZudFhRWUpVVksyOG95ZVlzd2li?=
 =?utf-8?B?UXV5emJVRCtOcExaSzNBcGdlYWFZOHk3OHJOaWd0THoya2hwZmdSZDdsTWJT?=
 =?utf-8?B?NVdXbmlkWFhxeVZiMHVCaWlNODhkLzJGb2NwT1krRyt1b1lteUg4YVJpSXpQ?=
 =?utf-8?B?cXJjMW04b1p4MUZvakZYdTdWZFc2L09DaHpJaG5GRDZ0T1dCT2IvaU1WR2VP?=
 =?utf-8?B?QXM4OHFLRUlqU09NNktFbGhjY3U3MkpQVG5iejNiMkpoUmN3S3dUQzR2Nkt1?=
 =?utf-8?B?WDZUa3JFUnY1bU1kVHNzdW1lYnovWXFTdEk3STZtV216Q1NWdGJPdnVIa2xz?=
 =?utf-8?B?R2pCb3hmTW9zWUJuK0IxMm9KZnIvM3laQlBlaVVMT3dLZDRzQXdkKzEwMGJz?=
 =?utf-8?B?aWFuSkMwT2NzVHkzQ1luTUttbEE3Z1FBcHl0UklzcjJVN3ZmVEdma3JvWTFD?=
 =?utf-8?B?WE0rUkk0VnZ5UWJtSXUyYVJpUnVxWWJXb2NQTlJmbElmcXlDbVNsRkJmNVI3?=
 =?utf-8?B?QVE4SDlkYXRHY3Uxcjl2QjdMQ1BFZXEzRkVmcWh6NHBGWDJaZ1JhaWlELzlN?=
 =?utf-8?B?QldCaXJKbnQ2UFR4Y1lkem43M1R1eDFDdGpGK2RybUswbFcvY2pMekRiNkVY?=
 =?utf-8?B?QkNxRmlET2l4eWtoT2lkeUxSRTh2UUF5NHkrV1hoQ1M0S20rYkNzcU5sOVlD?=
 =?utf-8?B?bTFCUE53R0IxTlpFMVcrbG0rZ0FiRVJSdzhxd1RDdmxpb0QwcTFCMkExanlz?=
 =?utf-8?B?a256T3pudHluTjN3RFpXK3Y1NytZaFVvVTdVMlVhaVRYTm5lYkJJNEVrSWli?=
 =?utf-8?B?NFNENXBSSVczSWFhdk9naDdWTjBFdHJvdmJLTzZ3M1JraU05Tk9CRDNpZ3pY?=
 =?utf-8?B?TWg5eXp3bUw3cTE0SjU3TitrTmtiemdYbUpya1JnRFJjTFErOE9oaEtrNDR2?=
 =?utf-8?B?WGNlK0ZIY1VaSTFiOVNUYUN5NDhDUnZ1VlNPZjNRbDlZMU82czNqTVRnM2tG?=
 =?utf-8?B?SFFIdXJGTVp6RTc1TXFPNnNmTy9ZcUUrWTRxZzBaMHdVWWl2cll1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9be8dc8-ba41-4e44-dc44-08df262f253f
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 18:00:04.1545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKbWC2mfOp+Rp2koQc894HsMHvRxhUQHkJ+EQtFPwuG+den+Ph7g5jazswdXW0HNC+5AVNNd/oJibCWiQF0myA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
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

--------------giZOM3G4ccAQKCsAVlptdkfw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-10-09 03:07, Christian König wrote:
> On 10/9/26 00:11, Geramy Loveless wrote:
>> KFD sub-allocates the MQD of every GFX12 user compute queue from its
>> GTT pool, so the MQD is in system memory. The CP accesses the MQD while
>> it runs the queue. A dispatch that exactly fills a shader engine is
>> retired through a path that accesses the MQD, so with the MQD in system
>> memory that dispatch pays the PCIe/host-link latency.
>>
>> Measured with an empty kernel, median of 200 dispatches, on a Radeon AI
>> PRO R9700 (gfx1201), for a dispatch of 253-256 workgroups x 256
>> threads:
>>
>>    - stock Linux (MQD in GTT): 26 us, against 7.9 us for 252
>>      workgroups.
>>    - Thunderbolt-attached R9700 to MacOS running mac_linuxgpu running the same amdgpu code under a
>>      different host OS: 51 us with the MQD in system memory, 17 us with
>>      the MQD in VRAM.
>>
>> On dGPUs, allocate GFX12 compute queue MQDs with
>> amdgpu_bo_create_kernel() in VRAM. That sets CPU_ACCESS_REQUIRED, so
>> the BO is placed in the CPU-visible part of VRAM, which is needed
>> because the CPU writes the MQD. Flush HDP after CPU writes to the MQD:
>> at the end of update_mqd() (init_mqd() ends with it), in restore_mqd(),
>> and in a new update_mqd_gpu_addr().
>>
>> Add GC 12.0.0 and 12.0.1 to mqd_on_vram() so the existing S4 handling
>> (unpin at suspend, repin on resume) covers these MQDs, and implement
>> update_mqd_gpu_addr() for v12 so the MQD base address is fixed up after
>> a repin.
>>
>> This follows existing practice: KFD already places compute queue MQDs
>> in VRAM on GFX 9.4.2, 9.4.3, 9.4.4 and 9.5.0 (mqd_on_vram()), and
>> amdgpu places its kernel compute queue MQDs in VRAM on GFX10+
>> (amdgpu_gfx_mqd_sw_init()).
>>
>> Only GFX12 (GC 12.0.x) is affected. SDMA, HIQ and DIQ MQDs are
>> unchanged, as are APUs that prefer GTT.
>>
>> Testing: compile-tested on amd-staging-drm-next. The patched kernel has
>> not been measured on Linux yet; the VRAM number above is from the other
>> host OS.
>>
>> for macos r9700 support reference where i prove the gains:
>> https://github.com/lemonade-sdk/mac_linuxgpu
> Absolutely clear NAK!
>
> You are missing tons and I mean litterally hundreds of technical pre-requisites of doing this.
>
> Keep in mind that VRAM is not coherent, you need HDP flushes and iosys_map() handling for all memory accesses to the MQD for that to work correctly.
>
> We have some internal patches to do this, but IIRC they are still not full stable.

This is already enabled on some GFX9 HW:

commit d4a814f400d4f3bd1e52f9b82e7d1f11b2721cf8
Author: Philip Yang<Philip.Yang@amd.com>
Date:   Thu Nov 20 16:43:04 2025 -0500

     drm/amdkfd: Move gfx9.4.3 and gfx 9.5 MQD to HBM
     
     To reduce queue switch latency further, move MQD to VRAM domain, CP
     access MQD and control stack via FB aperture, this requires contiguous
     pages.
     
     After MQD is initialized, updated or restored, flush HDP to guarantee
     the data is written to HBM and GPU cache is invalidated, then CP will
     read the new MQD.
     
     Signed-off-by: Philip Yang<Philip.Yang@amd.com>
     Reviewed-by: Felix Kuehling<felix.kuehling@amd.com>
     Signed-off-by: Alex Deucher<alexander.deucher@amd.com>

Regards,
   Felix


>
> Regards,
> Christian.
>
>> Signed-off-by: Geramy Loveless<gloveless@jqluv.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
>>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  | 54 ++++++++++++++++++-
>>   2 files changed, 55 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> index 9b7859a77..e6b45950e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> @@ -326,6 +326,8 @@ bool mqd_on_vram(struct amdgpu_device *adev)
>>   	case IP_VERSION(9, 4, 3):
>>   	case IP_VERSION(9, 4, 4):
>>   	case IP_VERSION(9, 5, 0):
>> +	case IP_VERSION(12, 0, 0):
>> +	case IP_VERSION(12, 0, 1):
>>   		return true;
>>   	default:
>>   		return false;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
>> index 6ea09b031..d3a8c2aed 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
>> @@ -92,6 +92,37 @@ static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
>>   	return mqd_mem_obj;
>>   }
>>   
>> +/*
>> + * The CP accesses the MQD while the queue is running, so keep compute queue
>> + * MQDs in VRAM. The CPU writes the MQD, so it must be CPU visible.
>> + */
>> +static struct kfd_mem_obj *allocate_cp_mqd(struct mqd_manager *mm,
>> +					   struct queue_properties *q)
>> +{
>> +	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>> +	struct amdgpu_device *adev = mm->dev->adev;
>> +	struct kfd_mem_obj *mqd_mem_obj;
>> +	struct amdgpu_bo *bo = NULL;
>> +
>> +	if (!mqd_on_vram(adev))
>> +		return allocate_mqd(mm, q);
>> +
>> +	mqd_mem_obj = kzalloc_obj(*mqd_mem_obj);
>> +	if (!mqd_mem_obj)
>> +		return NULL;
>> +
>> +	if (amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
>> +				    AMDGPU_GEM_DOMAIN_VRAM, &bo,
>> +				    &mqd_mem_obj->gpu_addr,
>> +				    (void **)&mqd_mem_obj->cpu_ptr)) {
>> +		kfree(mqd_mem_obj);
>> +		return NULL;
>> +	}
>> +	mqd_mem_obj->mem = bo;
>> +
>> +	return mqd_mem_obj;
>> +}
>> +
>>   static void init_mqd(struct mqd_manager *mm, void **mqd,
>>   			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
>>   			struct queue_properties *q)
>> @@ -242,6 +273,23 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>>   	set_priority(m, q);
>>   
>>   	q->is_active = QUEUE_IS_ACTIVE(*q);
>> +
>> +	if (mqd_on_vram(mm->dev->adev))
>> +		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
>> +}
>> +
>> +static void update_mqd_gpu_addr(struct mqd_manager *mm, void *mqd,
>> +				struct kfd_mem_obj *mqd_mem_obj,
>> +				struct queue_properties *qp)
>> +{
>> +	struct v12_compute_mqd *m = get_mqd(mqd);
>> +	u64 addr = mqd_mem_obj->gpu_addr;
>> +
>> +	m->cp_mqd_base_addr_lo = lower_32_bits(addr);
>> +	m->cp_mqd_base_addr_hi = upper_32_bits(addr);
>> +
>> +	if (mqd_on_vram(mm->dev->adev))
>> +		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
>>   }
>>   
>>   static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
>> @@ -409,6 +457,9 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
>>   		*gart_addr = addr;
>>   
>>   	qp->is_active = 0;
>> +
>> +	if (mqd_on_vram(mm->dev->adev))
>> +		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
>>   }
>>   
>>   static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
>> @@ -454,7 +505,7 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_TYPE type,
>>   	switch (type) {
>>   	case KFD_MQD_TYPE_CP:
>>   		pr_debug("%s@%i\n", __func__, __LINE__);
>> -		mqd->allocate_mqd = allocate_mqd;
>> +		mqd->allocate_mqd = allocate_cp_mqd;
>>   		mqd->init_mqd = init_mqd;
>>   		mqd->free_mqd = kfd_free_mqd_cp;
>>   		mqd->load_mqd = load_mqd;
>> @@ -465,6 +516,7 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_TYPE type,
>>   		mqd->get_wave_state = get_wave_state;
>>   		mqd->mqd_stride = kfd_mqd_stride;
>>   		mqd->restore_mqd = restore_mqd;
>> +		mqd->update_mqd_gpu_addr = update_mqd_gpu_addr;
>>   #if defined(CONFIG_DEBUG_FS)
>>   		mqd->debugfs_show_mqd = debugfs_show_mqd;
>>   #endif
--------------giZOM3G4ccAQKCsAVlptdkfw
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-10-09 03:07, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:01f9a0f8-63c3-4e84-a17e-51ea8f9b6104@amd.com">
      <pre wrap="" class="moz-quote-pre">On 10/9/26 00:11, Geramy Loveless wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">KFD sub-allocates the MQD of every GFX12 user compute queue from its
GTT pool, so the MQD is in system memory. The CP accesses the MQD while
it runs the queue. A dispatch that exactly fills a shader engine is
retired through a path that accesses the MQD, so with the MQD in system
memory that dispatch pays the PCIe/host-link latency.

Measured with an empty kernel, median of 200 dispatches, on a Radeon AI
PRO R9700 (gfx1201), for a dispatch of 253-256 workgroups x 256
threads:

  - stock Linux (MQD in GTT): 26 us, against 7.9 us for 252
    workgroups.
  - Thunderbolt-attached R9700 to MacOS running mac_linuxgpu running the same amdgpu code under a
    different host OS: 51 us with the MQD in system memory, 17 us with
    the MQD in VRAM.

On dGPUs, allocate GFX12 compute queue MQDs with
amdgpu_bo_create_kernel() in VRAM. That sets CPU_ACCESS_REQUIRED, so
the BO is placed in the CPU-visible part of VRAM, which is needed
because the CPU writes the MQD. Flush HDP after CPU writes to the MQD:
at the end of update_mqd() (init_mqd() ends with it), in restore_mqd(),
and in a new update_mqd_gpu_addr().

Add GC 12.0.0 and 12.0.1 to mqd_on_vram() so the existing S4 handling
(unpin at suspend, repin on resume) covers these MQDs, and implement
update_mqd_gpu_addr() for v12 so the MQD base address is fixed up after
a repin.

This follows existing practice: KFD already places compute queue MQDs
in VRAM on GFX 9.4.2, 9.4.3, 9.4.4 and 9.5.0 (mqd_on_vram()), and
amdgpu places its kernel compute queue MQDs in VRAM on GFX10+
(amdgpu_gfx_mqd_sw_init()).

Only GFX12 (GC 12.0.x) is affected. SDMA, HIQ and DIQ MQDs are
unchanged, as are APUs that prefer GTT.

Testing: compile-tested on amd-staging-drm-next. The patched kernel has
not been measured on Linux yet; the VRAM number above is from the other
host OS.

for macos r9700 support reference where i prove the gains:
<a class="moz-txt-link-freetext" href="https://github.com/lemonade-sdk/mac_linuxgpu">https://github.com/lemonade-sdk/mac_linuxgpu</a>
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Absolutely clear NAK!

You are missing tons and I mean litterally hundreds of technical pre-requisites of doing this.

Keep in mind that VRAM is not coherent, you need HDP flushes and iosys_map() handling for all memory accesses to the MQD for that to work correctly.

We have some internal patches to do this, but IIRC they are still not full stable.</pre>
    </blockquote>
    <p>This is already enabled on some GFX9 HW:</p>
    <pre>commit d4a814f400d4f3bd1e52f9b82e7d1f11b2721cf8
Author: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
Date:   Thu Nov 20 16:43:04 2025 -0500

    drm/amdkfd: Move gfx9.4.3 and gfx 9.5 MQD to HBM
    
    To reduce queue switch latency further, move MQD to VRAM domain, CP
    access MQD and control stack via FB aperture, this requires contiguous
    pages.
    
    After MQD is initialized, updated or restored, flush HDP to guarantee
    the data is written to HBM and GPU cache is invalidated, then CP will
    read the new MQD.
    
    Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
    Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
    Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>

</pre>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:01f9a0f8-63c3-4e84-a17e-51ea8f9b6104@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Signed-off-by: Geramy Loveless <a class="moz-txt-link-rfc2396E" href="mailto:gloveless@jqluv.com">&lt;gloveless@jqluv.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  | 54 ++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 9b7859a77..e6b45950e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -326,6 +326,8 @@ bool mqd_on_vram(struct amdgpu_device *adev)
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
 	case IP_VERSION(9, 5, 0):
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
 		return true;
 	default:
 		return false;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 6ea09b031..d3a8c2aed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -92,6 +92,37 @@ static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
 	return mqd_mem_obj;
 }
 
+/*
+ * The CP accesses the MQD while the queue is running, so keep compute queue
+ * MQDs in VRAM. The CPU writes the MQD, so it must be CPU visible.
+ */
+static struct kfd_mem_obj *allocate_cp_mqd(struct mqd_manager *mm,
+					   struct queue_properties *q)
+{
+	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm-&gt;mqd_size);
+	struct amdgpu_device *adev = mm-&gt;dev-&gt;adev;
+	struct kfd_mem_obj *mqd_mem_obj;
+	struct amdgpu_bo *bo = NULL;
+
+	if (!mqd_on_vram(adev))
+		return allocate_mqd(mm, q);
+
+	mqd_mem_obj = kzalloc_obj(*mqd_mem_obj);
+	if (!mqd_mem_obj)
+		return NULL;
+
+	if (amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM, &amp;bo,
+				    &amp;mqd_mem_obj-&gt;gpu_addr,
+				    (void **)&amp;mqd_mem_obj-&gt;cpu_ptr)) {
+		kfree(mqd_mem_obj);
+		return NULL;
+	}
+	mqd_mem_obj-&gt;mem = bo;
+
+	return mqd_mem_obj;
+}
+
 static void init_mqd(struct mqd_manager *mm, void **mqd,
 			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
 			struct queue_properties *q)
@@ -242,6 +273,23 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	set_priority(m, q);
 
 	q-&gt;is_active = QUEUE_IS_ACTIVE(*q);
+
+	if (mqd_on_vram(mm-&gt;dev-&gt;adev))
+		amdgpu_device_flush_hdp(mm-&gt;dev-&gt;adev, NULL);
+}
+
+static void update_mqd_gpu_addr(struct mqd_manager *mm, void *mqd,
+				struct kfd_mem_obj *mqd_mem_obj,
+				struct queue_properties *qp)
+{
+	struct v12_compute_mqd *m = get_mqd(mqd);
+	u64 addr = mqd_mem_obj-&gt;gpu_addr;
+
+	m-&gt;cp_mqd_base_addr_lo = lower_32_bits(addr);
+	m-&gt;cp_mqd_base_addr_hi = upper_32_bits(addr);
+
+	if (mqd_on_vram(mm-&gt;dev-&gt;adev))
+		amdgpu_device_flush_hdp(mm-&gt;dev-&gt;adev, NULL);
 }
 
 static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
@@ -409,6 +457,9 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
 		*gart_addr = addr;
 
 	qp-&gt;is_active = 0;
+
+	if (mqd_on_vram(mm-&gt;dev-&gt;adev))
+		amdgpu_device_flush_hdp(mm-&gt;dev-&gt;adev, NULL);
 }
 
 static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
@@ -454,7 +505,7 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_TYPE type,
 	switch (type) {
 	case KFD_MQD_TYPE_CP:
 		pr_debug(&quot;%s@%i\n&quot;, __func__, __LINE__);
-		mqd-&gt;allocate_mqd = allocate_mqd;
+		mqd-&gt;allocate_mqd = allocate_cp_mqd;
 		mqd-&gt;init_mqd = init_mqd;
 		mqd-&gt;free_mqd = kfd_free_mqd_cp;
 		mqd-&gt;load_mqd = load_mqd;
@@ -465,6 +516,7 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_TYPE type,
 		mqd-&gt;get_wave_state = get_wave_state;
 		mqd-&gt;mqd_stride = kfd_mqd_stride;
 		mqd-&gt;restore_mqd = restore_mqd;
+		mqd-&gt;update_mqd_gpu_addr = update_mqd_gpu_addr;
 #if defined(CONFIG_DEBUG_FS)
 		mqd-&gt;debugfs_show_mqd = debugfs_show_mqd;
 #endif
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------giZOM3G4ccAQKCsAVlptdkfw--
