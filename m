Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E53CCD199
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 14:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4846410EA0A;
	Thu, 16 Oct 2025 14:06:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rRLznYso";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012007.outbound.protection.outlook.com
 [40.93.195.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418E810EA00
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 14:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYmfwrJq7Jf+O91N46M+Qrokn9uCXWV8JuT619u+WXXJUGjHAq8k/frA/hLAEbmcjwq/lq0P/k7eJNeq/9p3/cLGcm5G5OjEvXURpo4OpPg6YkWd1Ikxi7jgSoA3w1w4uj0nnfOYANPOsPzrh9hEFVC2rmCYrRrs+KKM3W5IJwzFTzKBvnXuRgOpdGMgsxYF9Hweh/FiosZRIoMiEZfKUswEzyYlyVXCOYu9HmvFDxg8cISKqa+062UIecqX5c45epl2o6hIu12t42S5AuqGkoYSTYeLVvq6CYenQD4cQchp6g3sGJ7F20aSNEP0ucUgFFQowcxWnrhO3c0sd0cejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJ5Os3h1fO9x53nK+zxKHDfiEqNje/MDjYTBq+WB5Ko=;
 b=f+qWfRErIR1xWO2hFFv3vJuic2OvkzDa3x8IXDje/SO6ki1fnlJJS/9NWlgFpezJrQG0GhDmsB4XFoCiqxAwhJG4yLCb+okHEooTZZdqoW/il2tdcQrT52TWzIHaF8WM61NsxB/4GoHchEMCGMeLLVxFkTsPzHcJ221u9rJ0UGUyfUQEPSeL7Gwl2EV6QHALcnB7wL0v1KP1avw/RWsKgI11ZTTwWLu0HbE3hS4AYgNVpBMhow19FAXflNWBA1D+YygJu1IpVpFr6zS86VjO37dSsdT+umolgoqcG4aWMUAHdT34seSGqqfdwz2IlxixXkAkeGga77xj1/RKRdxnlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJ5Os3h1fO9x53nK+zxKHDfiEqNje/MDjYTBq+WB5Ko=;
 b=rRLznYso78tgyFjU2r64x/gRY6QppryYgVBTAlyYSFChYtb4SYRXO2fw/GOQn08Wx9j757zmfoLa8Kxm/jHqE/NiKtG/pTBHR271nMQeD/uIf2K7ypWQfki4RUHii6ZeHqYdQ6R/+rZTrFixq+zb+p/Avew4RxqR/bUzWZOf/sA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 14:06:40 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 14:06:40 +0000
Message-ID: <b87b294a-1cc4-44f9-a757-e4dc768824a8@amd.com>
Date: Thu, 16 Oct 2025 19:36:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to
 init from dynamic crit_region offsets
To: Alex Deucher <alexdeucher@gmail.com>, Ellen Pan <yunru.pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Jeffrey.Chan@amd.com
References: <20251015214848.11580-1-yunru.pan@amd.com>
 <20251015214848.11580-4-yunru.pan@amd.com>
 <CADnq5_MYkn6_WhPhG7y1+9_kPYWEUsPBWZ-fZ+S6+r7j2G4nyA@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_MYkn6_WhPhG7y1+9_kPYWEUsPBWZ-fZ+S6+r7j2G4nyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6bb857-06f9-4256-df0a-08de0cbd3a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Um1rNnZ3STY4TmdaOXdEOWNJTDNkYlRBQmVVRFg2b0dxMFd3TzB5YzY0eGZI?=
 =?utf-8?B?amMyaHYzYXRtSGVNUDVOaEEzOUUvci93VVJWQndjK0xUaGdBL241ZWJuUzhv?=
 =?utf-8?B?UlV4RmNEYjQzMHhGZm9odlY1QUFrWUNFWG02NFRHYmhEcWV2MERIMllab3pZ?=
 =?utf-8?B?dzB5dUk5WklOMXVUYVBkNWZsTExDKzZzQ0taSGdZUlFVaTZmOWNYclVuaXc1?=
 =?utf-8?B?MTk4VUVobmlqMkRjSEtTVHNSRGN0eWpFMTlWbzNaNFR4cWFHQ3RLQjF1NG9h?=
 =?utf-8?B?T0FEWXlOc1dJbHZFS05lMFVYTVFXUTZCT2VWNWtJUnB4MTNDR0I2YXFPbXM1?=
 =?utf-8?B?Y0hzemhWeXF0dS80VWlObS9hSnUxUkNTN29iT1plMldoNUZoWVgwbjJaRXZH?=
 =?utf-8?B?dk9uUDExUEh4MXA3L3dNY2pqTVM5REs5ZXlsNmd5L1ZTTFJVTkllRHdRRm5E?=
 =?utf-8?B?RHM5b0lZaVhGUlQzcjNLVVRjdzgwUExMczlnRENXRStCdW05cXBzaFJvYWFG?=
 =?utf-8?B?c2FvZkNJVVNhSlV2L1VwZEJqSnp5MGRwaUlrZTYwbVNiSU43N1BsTFRtQVlx?=
 =?utf-8?B?MDhvQkZxZUpzSWwyWEgrT055SEYzZ25JRFBHblVkNVJEaGtqS0xRZ1hqWGt6?=
 =?utf-8?B?MUs1QzJOWkhGZlRUWXVFRTJ1QXNnelJlVU5DTmZvN2lRb0hVaVdMNlk2SFlo?=
 =?utf-8?B?a3F3MHNhK1FJbmUvWFBnYXhFMEt5czBQNEJWNHlKbTY2OWtlaUJiZGc3SGJh?=
 =?utf-8?B?KzZBRzY1Nk1zdE5RSWVRNHhkS3RvQVFleG95VWFkUXE0ZG9PSjB0UTZjRFlh?=
 =?utf-8?B?cy93WE9NQWN6RitQa28rU0Z2VDhmd3I4S2tuTHZGUDhkdE15T0xVeGZHOTBa?=
 =?utf-8?B?b1JTVXFvVXlMVDQ2KzllV0lMejU3T0VmU1hyb1ZzNFc0SXdRL1VKV3F5ZVNn?=
 =?utf-8?B?cDdpUVJMR09FK2FCMHlzQWxwbmtlSlNwcnMxY1FhSHFCdkRPaERPZC9mSlJ0?=
 =?utf-8?B?VmtnSEwwWmtIamxJT0d0WnFLTFRHZ1IzNHN3RDVpUm5QTjNTcnhEQUJnUlRo?=
 =?utf-8?B?c2lmcTdiVS9ocE0vZzNSbWk0MDhTUTBCVXVrcXhVVERBZkpWR1FXWitxYlRN?=
 =?utf-8?B?bXhJZVFhQlN2NzIraXlWaVZvUjcxa0xVdTkvT0VxbjdEN2ZTQW0xRnNHUndr?=
 =?utf-8?B?aDlnMDJidG1teHkzNTlMcnpNbThoeVRoZ2tpcTh6MTRnNUlIKzlVNkc0cmRm?=
 =?utf-8?B?YVVKSDArQVZMQ1ZQN2xTNGMzVjQxVGxDYUVxdlNhdHZ2VzFwWksrTE5wN2o2?=
 =?utf-8?B?SEc5Ty9yclhtYnlOM0RUdGtQQ2V0WW01UWxnb0xjaGw1SVc4bFFlQU96NEha?=
 =?utf-8?B?UDhLdDRxZzdHb3Q5dGtSU3A5Qno5WWhsbXlXTERaNlQrdnluTEhraytTQ1VN?=
 =?utf-8?B?K1FhMFB0bWtBbUhCMzlwc1pMV1M1Qk10dlBhYmZTM1FvWDRicFMybTlYY3dF?=
 =?utf-8?B?L1hJVXBLRkw3djZkWmR3WDR5VkpaMzE0V0I0YXpjRFpFMC9OWmkyZWxZV0Y3?=
 =?utf-8?B?bythMjlZVjJkNEcrQXFSNTYrd0FwZ3lDOUFmOGx0NlNxazA0TXBkTjFjUUw1?=
 =?utf-8?B?UHNuSlpuUmlsQy96Z2o3ZjZ1Y0lqTzJCcEZIejVSQXpRTWdpWEVaVkZHTm9O?=
 =?utf-8?B?a3Iwb0NKYVp4Q1dvd0d1OElMN2JhL1JPTU0rWTF6WTJBRXJoR2t0VXJSc0JP?=
 =?utf-8?B?aTZVQWdkd2w3RnQ5Yk9VbHVyKzdxRGZ6OW1kTTBXU1g0ZTdmYitzOCtXYkVW?=
 =?utf-8?B?b090eUhnU0g3V3ZCODJnS3YxVDZXL2FoelV4YTY3MXZXcVFTL0ZRRW0rQSt0?=
 =?utf-8?B?L0w5b3hSWmszbDRMbWNiVEFkMDVwNGNvaHJJNUVNMGIzeE85N3hscjhrYUlq?=
 =?utf-8?Q?3gP6c7M2NoiN7OqKH+Jn21gP4/AYh1ck?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm9aK2dKWlFlTnVtMmlITk9KMjROR3Q0QmQ3citkSWFEcFE5NHZWT1RvTmlm?=
 =?utf-8?B?bUlpREJ1eUNXVEZrS3FqS3JzL2dRWnNFK3cwa2tSNUU3RS9icExndnU2Nzk1?=
 =?utf-8?B?bnpZbjNXUkpFd05NdjE1NTZ2eG1LblREOE5RV1AySFdQSG92dStCblJSSUZX?=
 =?utf-8?B?bkY1Q041RnFvZFFKN0R5OFpjZ1A1VncvaVdYRmQrOUFjSWRNaWhMTVBzSjJ4?=
 =?utf-8?B?eEhZelJYYklHODgxSXp2b2R2c0d2SmE3SHlnSEVSbTZzdVh0QXpHaE80M0NL?=
 =?utf-8?B?Q3VXUlpOV3hyWFRtTklsNnE3V1VhSG05T1Vld1EvdHFGdk5TRVZXa1YwbXVw?=
 =?utf-8?B?SzdsekUxVFBWaW1kM2YxSTJWWG4xbWpiM1BnWHBCNTBmY3cxZEdCNENPVkNQ?=
 =?utf-8?B?NENGQit1SnIxYmhSLzh0N0lNUjBTclVIdzFJMjJKaHZuS1VHRmJkUlVWejRt?=
 =?utf-8?B?YVd5TzNjZUI0UysrK3ZNNlpPcGhMRWxVWVg2dlJsMGF3Mm1wYmJVakpBRXln?=
 =?utf-8?B?NGZoZUhlSS9EcTc3aVVpYWs5d0NWU29VYjVZL0JSME5CVWlycnpKK2JveHZl?=
 =?utf-8?B?VXgzVit4YlZJdUl3aFA5YUR2MGphaThUOHFWTlNvTzNUUUZscWJtN1hjejI4?=
 =?utf-8?B?WDBUSHJ4aE8wK1YrU2t5MW91c3cvMmE5Yk4xSVgwZVI3VHhacC8zbXlXVVJI?=
 =?utf-8?B?ejV0eWlHd3l1U09wRk9MaDByR2kxRjg4UE1LcHNnV2RIc3dkWG50RGt4ZCt6?=
 =?utf-8?B?RUY3SXpxQkFKVWRRVGZOb1pYaVp1S2JNalZtekhDVmEvU1VoSlZaR1RsTU9H?=
 =?utf-8?B?RHUyUlpCa3BJaERxZmZUeU1vU3ZWcUtHQUhDdmpJcllTY3Nmc1Z4cGNnMlYy?=
 =?utf-8?B?SURaWkFuL1dTUEUxdUdCb3U0d3B5NTJpcG1XZWdlWWdENms3T1ZHdCtVajVP?=
 =?utf-8?B?QTl2cm5zc21vY09UNEVMSEJtWnBiczUrMzFOY2h0TXZqV2FPSzZUNERrWlp3?=
 =?utf-8?B?VXZkSUFDam1rSWVTdS9XQ3FJSUozQlBFQjUyamQxUjE1UTExbVRuN2cyUUxS?=
 =?utf-8?B?Qko0b2g4Tmg1dGh3dS9nR1JqakZmSGhPTnRQeC8rcUdZTCtIMEpRMmw4ZjNw?=
 =?utf-8?B?TXVLT1VHUHY3ZDVOS1B5MzRGNHQ3bnQrUXBIazdwWlM3QmRwRFF1Nk9yRlZi?=
 =?utf-8?B?cFJqVkpVQm1OY3ZaUlAxZGpJTURvQUo3VnlpNWZLbUJrWENyZDNBTW5KdGN2?=
 =?utf-8?B?Z0JsQnNnUk1XMlRFRWVxdGRPSTZWN2dMSUh2WlFvWjFlay9CTjN0bG9vcm5G?=
 =?utf-8?B?VWxiYS9CZWRPcnJjMFhzNzJsUUkrcUV4WDMwYkhMTW1DT2Ruak5zZWpGeWpt?=
 =?utf-8?B?OUFpeE1qTzVZYVpPZkVJM0Z0R1Zyb0E2Vi9aOTU5T1VNZ2VCMEVyK0JwMFNo?=
 =?utf-8?B?WmZrUkxVazZvTmlGNEt4RUVwRUg3MDY1VWFJYUFscm4zTjRuZHQ0VjR2aFdK?=
 =?utf-8?B?TkdkTnpCcHNGOEc0RTBNSTVGbnpwYWdYMzJBUzMwb0lZRzAxRGpnV1BPSkpi?=
 =?utf-8?B?Nk5MK2ZIQmp3L24zckIxQkFXQ2VLYlRlaFR0S2cwSXZvL082R1hwVkt5Sys2?=
 =?utf-8?B?UE80WGM1Z0ZGZnVGVi9RZ3hmb2tVWEZoZG13bHEwNlc0K2svYmdWOXp6S2Fn?=
 =?utf-8?B?SjZiR0x5REtob3JBVVNVQUREbkpoampnRkZ0dXQ1MFJ4U0YvTThHRXFSSXJH?=
 =?utf-8?B?MU43SzA0YUpzQ2dXTFB6VXp1V0wwVVN4bGVnanc4VUp3UG5SQk92VkF5Umdn?=
 =?utf-8?B?N0E5MlBoUlUwWkV6c21HNVBSc00yTm5QaXBQRjU5WTJxWFVYYm9jWm9FZUp6?=
 =?utf-8?B?aTNhdi9KTytjbFZtcHR4eFV3Nll5dUlWUWFGdnhIY2diaUJQV2wzZCtmWVlq?=
 =?utf-8?B?MW5leFV1UzJZekZRZTRsc0hVVGozb05RUGR0b0NFbm55cER5UTBqWCtFVVdk?=
 =?utf-8?B?dnZRbTRCbGo3Nkg1ZjlkdFVoSldicHFHNnF0L3piZlp0TGU3eU1ESkFrL2NZ?=
 =?utf-8?B?Q3hMTWhmcmpOSjZtdXMrcmtNMFhCeGt1NFYyd0RZeU5CRmpGN3lFcVNzSGZ6?=
 =?utf-8?Q?pQee5tfq5UEUO1uVRSX+tCDAY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6bb857-06f9-4256-df0a-08de0cbd3a29
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 14:06:40.2301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYX5jWqu5gk1tzc2tO8VMBu1ciw0tizSxxOM/IpIyUp2YkVVRlHDydgQeAyvs5uR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
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



On 10/16/2025 6:36 PM, Alex Deucher wrote:
> On Wed, Oct 15, 2025 at 5:56 PM Ellen Pan <yunru.pan@amd.com> wrote:
>>
>> 1. Added VF logic in amdgpu_virt to init IP discovery using the offsets from dynamic(v2) critical regions;
>> 2. Added VF logic in amdgpu_virt to init bios image using the offsets from dynamic(v2) critical regions;
>>
>> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      | 34 ++++++++++++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 23 ++++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 37 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  2 +
>>   4 files changed, 83 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> index 00e96419fcda..070fd61f8463 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> @@ -96,11 +96,12 @@ void amdgpu_bios_release(struct amdgpu_device *adev)
>>    * part of the system bios.  On boot, the system bios puts a
>>    * copy of the igp rom at the start of vram if a discrete card is
>>    * present.
>> - * For SR-IOV, the vbios image is also put in VRAM in the VF.
>> + * For SR-IOV, if dynamic critical region is not enabled,
>> + * the vbios image is also put at the start of VRAM in the VF.
>>    */
>>   static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
>>   {
>> -       uint8_t __iomem *bios;
>> +       uint8_t __iomem *bios = NULL;
>>          resource_size_t vram_base;
>>          resource_size_t size = 256 * 1024; /* ??? */
>>
>> @@ -114,18 +115,33 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
>>
>>          adev->bios = NULL;
>>          vram_base = pci_resource_start(adev->pdev, 0);
>> -       bios = ioremap_wc(vram_base, size);
>> -       if (!bios)
>> -               return false;
>>
>>          adev->bios = kmalloc(size, GFP_KERNEL);
>> -       if (!adev->bios) {
>> -               iounmap(bios);
>> +       if (!adev->bios)
>>                  return false;
>> +
>> +       /* For SRIOV with dynamic critical region is enabled,
>> +        * the vbios image is put at a dynamic offset of VRAM in the VF.
>> +        * If dynamic critical region is disabled, follow the existing logic as on baremetal.
>> +        */
>> +       if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
>> +               if (amdgpu_virt_get_dynamic_data_info(adev,
>> +                               AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev->bios, &size)) {
>> +                       amdgpu_bios_release(adev);
>> +                       return false;
>> +               }
>> +       } else {
>> +               bios = ioremap_wc(vram_base, size);
>> +               if (!bios) {
>> +                       amdgpu_bios_release(adev);
>> +                       return false;
>> +               }
>> +
>> +               memcpy_fromio(adev->bios, bios, size);
>> +               iounmap(bios);
>>          }
>> +
>>          adev->bios_size = size;
>> -       memcpy_fromio(adev->bios, bios, size);
>> -       iounmap(bios);
>>
>>          if (!check_atom_bios(adev, size)) {
>>                  amdgpu_bios_release(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index 4e75334f3b3a..1809deb86797 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -303,14 +303,29 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
>>           * then it is not required to be reserved.
>>           */
>>          if (sz_valid) {
>> -               uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
>> -               amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
>> -                                         adev->discovery.size, false);
>> -               adev->discovery.reserve_tmr = true;
>> +               if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
>> +                       /* For SRIOV VFs with dynamic critical region enabled,
>> +                        * we will get the IPD binary via below call.
>> +                        * If dynamic critical is disabled, fall through to normal seq.
>> +                        */
>> +                       if (amdgpu_virt_get_dynamic_data_info(adev,
>> +                                               AMD_SRIOV_MSG_IPD_TABLE_ID, binary,
>> +                                               (uint64_t *)&adev->mman.discovery_tmr_size)) {
> 
> I think this is adev->discovery.size now after Lijo's latest changes.
> @Lazar, Lijo I think we can remove adev->mman.discovery_tmr_size.
> It's no longer used by anything.  With that fixed,
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Will do. Other than that, and one comment below, this patch looks good 
to me as well.
	>
>> +                               ret = -EINVAL;
>> +                               goto exit;

The message printed at exit: label is not valid for this case. It's 
better to have another error message for this case.

Thanks,
Lijo
>> +                       }
>> +               } else {
>> +                       uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
>> +
>> +                       amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
>> +                                       adev->discovery.size, false);
>> +                       adev->discovery.reserve_tmr = true;
>> +               }
>>          } else {
>>                  ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
>>          }
>>
>> +exit:
>>          if (ret)
>>                  dev_err(adev->dev,
>>                          "failed to read discovery info from memory, vram size read: %llx",
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> index 12659990abe0..15157ed5df29 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> @@ -999,6 +999,14 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
>>                  goto out;
>>          }
>>
>> +       /* Validation for critical region info */
>> +       if (adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb > DISCOVERY_TMR_SIZE) {
>> +               dev_err(adev->dev, "Invalid IP discovery size: 0x%x\n",
>> +                               adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb);
>> +               r = -EINVAL;
>> +               goto out;
>> +       }
>> +
>>          /* reserved memory starts from crit region base offset with the size of 5MB */
>>          adev->mman.fw_vram_usage_start_offset = adev->virt.crit_regn.offset;
>>          adev->mman.fw_vram_usage_size = adev->virt.crit_regn.size_kb << 10;
>> @@ -1017,6 +1025,35 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
>>          return r;
>>   }
>>
>> +int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
>> +       int data_id, uint8_t *binary, uint64_t *size)
>> +{
>> +       uint32_t data_offset = 0;
>> +       uint32_t data_size = 0;
>> +       enum amd_sriov_msg_table_id_enum data_table_id = data_id;
>> +
>> +       if (data_table_id >= AMD_SRIOV_MSG_MAX_TABLE_ID)
>> +               return -EINVAL;
>> +
>> +       data_offset = adev->virt.crit_regn_tbl[data_table_id].offset;
>> +       data_size = adev->virt.crit_regn_tbl[data_table_id].size_kb << 10;
>> +
>> +       /* Validate on input params */
>> +       if (!binary || !size || *size < (uint64_t)data_size)
>> +               return -EINVAL;
>> +
>> +       /* Proceed to copy the dynamic content */
>> +       amdgpu_device_vram_access(adev,
>> +                       (uint64_t)data_offset, (uint32_t *)binary, data_size, false);
>> +       *size = (uint64_t)data_size; // update the size as out param.
>> +
>> +       dev_dbg(adev->dev,
>> +               "Got %s info from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
>> +               amdgpu_virt_dynamic_crit_table_name[data_id], data_offset, data_size);
>> +
>> +       return 0;
>> +}
>> +
>>   void amdgpu_virt_init(struct amdgpu_device *adev)
>>   {
>>          bool is_sriov = false;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> index 8d03a8620de9..2a13cc892a13 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>> @@ -442,6 +442,8 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
>>   void amdgpu_virt_init(struct amdgpu_device *adev);
>>
>>   int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
>> +int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
>> +       int data_id, uint8_t *binary, uint64_t *size);
>>
>>   bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
>>   int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
>> --
>> 2.34.1
>>

