Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1158CC10F1A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 13:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8185D10F986;
	Tue,  7 May 2024 13:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ITFcgyRw";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8C4710F986
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 13:51:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKwZWXSIG/m23sRdUX68tEguLCLr3LGMdjoZPq1o/LWFEcKz1gaorIS3WJRX7tMuxkLcULIS7XSANWqACJVl2AbQRfCkuxeEz4GvQ5G2jeliMV6ut8KC2/b9UjgHzPrOzPOC7BilefG7bKs5F2kslrJXg2uRLmDk8Qm1AImG5LfZycZCvJhDBvYLoZCURePVCKygs2qIK+PDiV4xN8CTK9MG3JViieCMlTyuL6GdxbAmQBqXnYn22IN7IoR/6zs6V2yqNTMRLXK5dmEJHVwtmHnhYTKpFagYvG+IkglPTV91lFi+VZCzISsWjBfgQ60FvmNxLDl9iovTy0LnL760gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRI6VQN2L93uxeQE12zBVrKhXy5SnBsVcT2znb4vr+Y=;
 b=Hwx0QTfdnwK8xAN3RnkZDrHtc8+b/BBe4w7qiunH1ECn8pMxX70wHSldR7lvrQWoY0H1sU80vp5mBBEqKoyftXXYZyikUH5xw6LE2878N22rLLIOhQ1bF4rJ+A2U22MPGzoCwqA8tJPiySeUj4oLMly9+iYJMLQ6dijkt3tmz6MB6KxUiMDTdkdRXBysQkp1cHOgFh8Yx+GbddrTMb5WnLT/79Io6gC1LH+cakx5N15GKOhL898n04biwKM5sku0dKIklH/czEZdVIcKh5gfNSToPGiBOr+PDLuExEVAOcWU3obzMJojdHHEzrWXgZn0qFe3W6p+L5jarf2Yw22s6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRI6VQN2L93uxeQE12zBVrKhXy5SnBsVcT2znb4vr+Y=;
 b=ITFcgyRw84Xi171znwCwOaAyJxHpjVo5YlPG2JST0PU4r3f6sUSfIRuP1Yd+vs48FwSDiFLSAGNA1xABfFB3R7ct9POpqNFXvtxHeBPsT+gXVCUSbUYvtCQVDcrxYnVOfkSrNI4gzNmG36yvBu3rvPj4dE7anRbkoziLHwE90KA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ0PR12MB7066.namprd12.prod.outlook.com (2603:10b6:a03:4ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 13:51:05 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 13:51:05 +0000
Message-ID: <3e9da7ae-6f3c-425f-ac7f-9809c8da8142@amd.com>
Date: Tue, 7 May 2024 09:51:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Assign correct bits for SDMA HDP flush
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com,
 Alexander.Deucher@amd.com, Le.Ma@amd.com
References: <20240417115743.167530-1-lijo.lazar@amd.com>
 <CADnq5_Nu85f-UkAwnVzizxwKMhmW6UN11JuBpx68Se-SpLhm1g@mail.gmail.com>
 <d6cf999f-c44a-4f70-90fe-7cce1eea4a5e@amd.com>
 <fb683aec-e96b-49e0-8ba9-e351cd800bce@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <fb683aec-e96b-49e0-8ba9-e351cd800bce@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0197.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::7) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SJ0PR12MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: d26e404c-30b2-45c7-dd4a-08dc6e9cbd4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dW9qYWRiUGRhdk9RaUp6Z0xFUDNESDFnOEhJQU44ZEM1OXBPSldOaDlsYkF2?=
 =?utf-8?B?dlZxSE1ENFM0dmVSZi9lbGtnTXJERFVBSzBhY05QSTVBOENsMUl0c1Q1bXRK?=
 =?utf-8?B?TmpvT2UyK1FGb1YzS2dxL0lBMFY0TU9PQURhWC9wZ3lRWXlrMWtQR0pZMnZ3?=
 =?utf-8?B?RVpXTGFhNWRqWXRPK1JLYStjbTBvS25rWkFXaVJZNkJjb0R2WHBSWWpuMDNh?=
 =?utf-8?B?VittVFFNamdkWndQT24xcEM5SFVoLzg4Qjl5RlVpa241dWJNb2xpekJrQlBK?=
 =?utf-8?B?T2ZwNm1sQlR0TjZwRHdHVU5LRlU1MzBieTZSZXJ0QUVGeG00dDZSM1BBakJw?=
 =?utf-8?B?OUkxa2Z2aUxhcFFVL2FjUnpySU1PTFl4WWM5ZTFpN3FxWUVxWE9aWnowekY3?=
 =?utf-8?B?RjlPaVBTeHgydklBYWd0Mm5GQUFmNVpXRHN3ZFNHVE1sRmh0Rit2WTZFSitm?=
 =?utf-8?B?bGlGNkp6RGpwU2FTVGwzYW5sR01wL3NkVUYxRGZoMHJHYkkxSlJzSlUxR0V2?=
 =?utf-8?B?dkw5Vy9FSEVCbFVZVTgvNUI5STFTalNUZFN2ME0xbE42emwwa2VlYis0L09M?=
 =?utf-8?B?RVRCb2xFQUdGcCtFUm1BQk9rYTZWVjBhR1hPSVA1MS9JU0ZmMGF5TkFIYUQv?=
 =?utf-8?B?ZnNaaDNCakdrZnpxTVIvM29Vb0Y5NXdPSzYwYlFVQ1dzRkwzSDRheFlZdXA1?=
 =?utf-8?B?SDhzK0sxOWMyVVZnOUtsLzZlL2FaTkN2cVRzVXp1YzUyVHAwNDJNbXlXdWxL?=
 =?utf-8?B?SFVCWjk2Qk5nVjVGUFZhb01VOUpXZlRsVVkxMjdrZWM1aUNVZ1VJOXdXUjRK?=
 =?utf-8?B?Z1E1ck1wZlJFUkdiKzBqZHNpd1JBaGhlcjNNM1l4b2FyVmFLZ1hnTjhqdnZl?=
 =?utf-8?B?MXRINVlCYlJIUG9lTHEzRFh5ejVVZ0lSRFFqOFdlOWxTUU50TFllL0JEeEd0?=
 =?utf-8?B?V3hia0wwSEU2R0VBL21mRS9RZFM2bnhuaXpBUVlwenY3eXZlWlpGSGYramNm?=
 =?utf-8?B?cmdYOEdkRFVUQ1h1VkFMK0o1ZkZycVlTYzdDbUVnRCtIOVI1SCtoOFIwTnhv?=
 =?utf-8?B?bWVyeUJtVXNORitmQU4vZ0tuQkRYVS81RUNiVGJGTksvOXY4RjcrTks5VVA5?=
 =?utf-8?B?YUF0WXBuK1pCY2tNQ3RjWmVNSEQrSFVXSk9jVm95clFrM3N0SWFoTlFKRVFa?=
 =?utf-8?B?ZFFmSmVxbUl5ZHY3emh1Ky94Y00ySU15K05LS0xpRk1hRGhTVlhkYW5lamc0?=
 =?utf-8?B?cFNRWkcvbVppcFVkR1oxMlNOZkp6ZUZISXFEdjQ3S0pVcjBNS1NqR2RPZ2ts?=
 =?utf-8?B?ZU5DOXp5WmJOTGxvZWlmSk5ZN1Frb1VTcmM0Ylh0REZEL2kxNVhES2lLdTBE?=
 =?utf-8?B?WFBnNDVxc3E3ZkNEVDUwSEE2ZEkydEVLZHRTdXdETHB3K2FjZGIzQW1XMjJz?=
 =?utf-8?B?TUxPVW1hRnJaeW9CVHQ2Rzh2Y0ZCSEltcDRJR01xQTI2dUluczArdFpzc1Nh?=
 =?utf-8?B?ZzFqRUFwMDhoWUlrQURBM3ZLZWFQSStjWmltakx4LzBSUjZVdW1vNUxQb2lH?=
 =?utf-8?B?Z3VaRzVTV1oyOUREdTdlVFlQZXZiampiRTB6dm1naUZQamlWVmxUR0w0NjZj?=
 =?utf-8?B?a2NacUpMcFpjb2tEU01oa3BDbkhpdENEUy8yRy9HbS9HTm8ycFJpUWczWUE2?=
 =?utf-8?B?MzNjWmczTFovUUxvKy9LUzRrUGo2NkNWSThUaFlWc3BnUWEvRVFmOVRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHRXSkVuMFFMRVRGYTRUd0VUSkxSeFN0dnZ4cExEVU9rT202OHE2WFVoUDdv?=
 =?utf-8?B?WmtBNEFPRFM1S1hJdENWaE5JeDBUTXZTRk50eUlJYjRwL3JUNy9yWkI2UE9w?=
 =?utf-8?B?NE43SjN1R3BHeTRYRXR4MlRheDNYNTA5OE9CTXlZSXk2cW9Wd2tuWjI0V003?=
 =?utf-8?B?dGJkM3dJOXZHalpkQmZFVy9ZQW56UDh1b2VNcjk1VHlYU3k3eGcweEFkQmRR?=
 =?utf-8?B?aXJ3ZkxaRVFjYzIrVjJUR0xYdlR0a3Y1aEFnRkE5Vy9rUVpHSEllU3RlUVk0?=
 =?utf-8?B?NUJSWXcxMWFYQ0ZxU1ZvRnJubXNqM2VSd2lzd0xKcFNNaFo1b1lRRFZyWnZF?=
 =?utf-8?B?a0JOdUt4R2JIZzZBZnhqdDlNdTlnckJBK3gzWmtla08xZ0dhNUJlZ3p1b0Vv?=
 =?utf-8?B?S2o3VmZvRnZHdzBGQXR3eENQWXhDdFBpVldob0RqT0t4QWQ5aUJNOGpTWTN6?=
 =?utf-8?B?STBob3dCTjl6dXd5SG12RFZGWXZ5dEJaVWdWZG95NituVjQxT3RaT2FFellY?=
 =?utf-8?B?T0ZsMUoza3k1ekxJalgxS05PdFBjVzhzWVRqZ3FXdGhiUUdxejdCNU14S3Np?=
 =?utf-8?B?RG5JUk8vanJWZlgyd3FsRXM3a24wWVd5U3IwWWdYemZ1em85TFlwZUUxZ2pj?=
 =?utf-8?B?QWNsL2dKNlJQNUtPdEtQZEZaZldKL1FOTlZ6TnB3ZTZjTzF2SFlxVU5lQm1a?=
 =?utf-8?B?NHNPL29VV2IvRXhFTytkY2VybnhXckJZUWpwVUhNanV3ejRSTWd1ZHg3ZkJ4?=
 =?utf-8?B?MmhXS3lLc3FOUjZMSjM5TlgrY0YwYzB6cTAzVUFNd2luQjJ1ZHJudVM4eDV5?=
 =?utf-8?B?SnhvRm0ySUZTdHllRzhhbVc2Q3VoVEI4VUk5akFNTjBMaTY0ZWJkTFJkZFlN?=
 =?utf-8?B?cHlyZGNtcWt6aU9wY2txcWl6Q1puSkUwTGREejRzSFhXcFlzRVBuQjEvN2Vr?=
 =?utf-8?B?SVI2SHNuNVU0WXAzeE9EYTdOczVNY04xZnB1V3RoSmdVcTBPcFNBL3NKQXJr?=
 =?utf-8?B?L3NLcWFtK2hTOEVsYmFmOGxOQm10M2JIQldzNHJ2WWszL1ZLY1o3aTlMTnlS?=
 =?utf-8?B?bVpMVWVaZkV0T2Nxa0NPOERQeDhQSXVVaEV4ejQwZklkQmJrMWswRXBlMU9N?=
 =?utf-8?B?UzY2MFc2ckVhMkZPME0yelVoVDE0ZmtiYmt2ZnBWSFY0NmZjNHpkM2YvV3Vs?=
 =?utf-8?B?cmJEOFoxTnVNWGZSSXNQYTdrUkFjM3haSUhmVVlRampHYmxHNkY1eW4wL0JS?=
 =?utf-8?B?NU5UQ3hZZlV6VWhDTmpjNTZEd05jOEtOcjI3cGJoOGJhWERxQlpyOVRGeUJn?=
 =?utf-8?B?ekhiQTZ1aFFhZFAwdWlqSVNpVTIxcGxXZXQ4LzlvVWVGdWd5NC93bnVWbVF2?=
 =?utf-8?B?cXdyQ2pVSGpSQWlJb2JWKzBWbmd5cGYrV3M2U3ByUVJoMzAreU9kUFVqNFll?=
 =?utf-8?B?Z01YQUNIT0cvV210ZXZWQ2JpV1dEL09VVzFUdWdHOWJwZWVucXY1QWJ6d2Jk?=
 =?utf-8?B?SzJsNlArV25zVU5WY1k2T1NqMGJvMkljNjlZa2V6UlZZMzR1M3U1WjV4cnVO?=
 =?utf-8?B?L0NXTVpRU2c3REIzWTkxanI0aFlRUXhPRzZQYXhPR3RrL1daMlkrKzFKN214?=
 =?utf-8?B?bEovaFh2cWFhVXFjc3pDb3p3TVVjb1RsSUdJMThsdU9udHVEaFlCMGp6NnBN?=
 =?utf-8?B?bHVnQVB3VDQ3TUdaR09WTUxyOEdOT2hDRXRtZEdxZTdDWHE3dVpCL3R4dVUr?=
 =?utf-8?B?bHZYNTc5TzYxODEwWjNkSU5sOUNUSTZZeWhwcHBUalVwUWVWSDlYVEdnNEs3?=
 =?utf-8?B?WXkzaFdyMW1TdExTRHBJa1NRTWg5aXp1VkF0Z2tMVFlvNE9TNnJQaE91WlZz?=
 =?utf-8?B?Ri9ZdEw2a3ZuSFNQc216V3F4R1RTbUVDaEpMSzFERkZURDBHMUphOExZVStk?=
 =?utf-8?B?RnNUZGI1WWNLcm54Qk5BL0xLU0ZvQzVKNHBKOG9DK1FTUzNiOTBtMmZzTHJp?=
 =?utf-8?B?eEs4MnNlUWllMUJoTEI4NzZPSGk2ZjBCT09lbzg5QlNKT042aTFodDhQTFM2?=
 =?utf-8?B?dzBsQ2pOT0hvc0twb1FRb2lZYmZwbTNqekhGcmlxWkdUblhIbXV2NERqYUl5?=
 =?utf-8?Q?5Ddvaf5bGOLT2wJuWpYyvVvl5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26e404c-30b2-45c7-dd4a-08dc6e9cbd4b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 13:51:05.4375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e206AKHqQK3XVgpidH8l8l1G2r9KtUJczy6+adtMiIoUYUHjpxG1COkzbyRTiJrdQq1VUHWvegapk4JrFnLtbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7066
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



On 2024-05-06 22:50, Lazar, Lijo wrote:
> 
> 
> On 5/7/2024 6:00 AM, Harry Wentland wrote:
>> This patch is causing crashes of Manor Lords on my Navi 21 on the 6.8.9
>> stable kernel. It leads to an assertion failure in wine:
>>
>> File: ../src-wine/dlls/winevulkan/loader_thunks.c
>> Line: 3621
>>
>> Expression "!status && vkEndCommandBuffer""
>>
>> This happens both with radv and amdvlk. It starts happening on v6.8.8
>> with this patch. The previous patch (drm/amdgpu/sdma5.2: use legacy HDP
>> flush for SDMA2/3) is fine.
>>
> 
> This patch will affect only aquavanjaram SOCs and shouldn't affect any
> NV series (unless there is something going totally wrong and coming to
> this path).
> 
> .emit_hdp_flush = sdma_v4_4_2_ring_emit_hdp_flush,
> 

That makes sense. I am pretty sure when I regressed the problem it lead
to this patch but will double-check when I have time. Will probably have to
wait a couple weeks as I'll be travelling starting tomorrow.

Harry

> Thanks,
> Lijo
> 
>> Harry
>>
>> On 2024-04-17 09:19, Alex Deucher wrote:
>>> On Wed, Apr 17, 2024 at 8:07 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>>>
>>>> HDP Flush request bit can be kept unique per AID, and doesn't need to be
>>>> unique SOC-wide. Assign only bits 10-13 for SDMA v4.4.2.
>>>>
>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>
>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>> index f8e2cd514493..09e45ef16c0d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>> @@ -368,7 +368,8 @@ static void
>>>> sdma_v4_4_2_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>>>          u32 ref_and_mask = 0;
>>>>          const struct nbio_hdp_flush_reg *nbio_hf_reg =
>>>> adev->nbio.hdp_flush_reg;
>>>>
>>>> -       ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0 << ring->me;
>>>> +       ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0
>>>> +                      << (ring->me % adev->sdma.num_inst_per_aid);
>>>>
>>>>          sdma_v4_4_2_wait_reg_mem(ring, 0, 1,
>>>>                                
>>>> adev->nbio.funcs->get_hdp_flush_done_offset(adev),
>>>> -- 
>>>> 2.25.1
>>>>

