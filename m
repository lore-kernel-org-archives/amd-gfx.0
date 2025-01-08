Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9E8E77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 09:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BCEB10E3BE;
	Wed,  8 Jan 2025 09:19:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YG/4IfTo";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E661910E3BE
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 09:19:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsP+C5kNgfWoqX9/o3C+V7BJEYWt23IaI/Q99rHeJ5zumFwTbGF9DtP0eCkgglB/Es49GFe+Pu08Le6TDR/ln9uUHsZcHbQ28PDKevgwhcejXc/2L1ucCwSTDjAlxAuj+KYs0PS/VMt93AuOsy2S36F0GLgLUR8qjpiqfoTQxaABs17xnzXbx20VASc83crP14SEwoh1kuvMn07yzwLaqDXUm/tfXvF1o3rngi7V+tVeQmNYBY7rwvj3YCO1ERi0B+oeO/mlZ+d5i7EzlR1E8wuxloiHi6n6FOCnbC642Wpzt/CnhIplDqqM/8+ZqlP8JcCfKCcYvD6iu2qXRHLgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzSVgY1TD8oQDfc43EwyWee6TztcGUoJ16mb0y8tlCk=;
 b=RrgfWmCN8pMtYRMRaCFwAHGP6+S4lePT0LPqpfgzrTgOIQa7VM4qKjpnGfDkH3hU0VyjPFsT8zJTfdgqArVRt62Klb1IIqlzCfwqJwCz0fhNwwpmlCMH4wu7ld1RavFjh9QqVWfWakLh6GgO0NTeDvW9NtPflVwgtyfmwqhaFRQokNdzQKsfLJMtfX+6j6pkp028eBdJwUjRX8F+L0jV8xHPmaKanSYMDVTT6kC5Mcxh8djcLb6k9TJBTwjR3Ba1rHbHRNZr0//LzvtNUir1MuCKmo/cIeqr8Od51Sx3xVSC36jRswXxLexLc5Xqxj40WBpcOGhZmNStzE0Ckt0zMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzSVgY1TD8oQDfc43EwyWee6TztcGUoJ16mb0y8tlCk=;
 b=YG/4IfTooIAwWOIcM8tVW07hRZx+5fQWwlmWu7980F70skP0nujscjq5JXgQVMziQuN1AB+jYQmvfEcBYAA06DTFe6Le/7LrdRpa0z3tQtV/TsHbTiTIz6kdWVWMBju5ahiajBc1nYWpD+dNwMVD0bSNuU51KU2h1hu4KUO8Kfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 09:19:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 09:19:01 +0000
Message-ID: <e05a67b1-7b2f-460c-bd53-246ea1f55d5c@amd.com>
Date: Wed, 8 Jan 2025 10:18:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] amd/ttm: test fence->ops->signaled before use
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix.kuehling@amd.com
Cc: jamesz@amd.com
References: <20250107200140.1568268-1-James.Zhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250107200140.1568268-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0438.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ba4f6b-5a1d-4893-b8f6-08dd2fc57d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGthT3RQWGpuVHA1ZGJQU1psTW9DZmJoQmU5RThhbTc0eTJSWlRZWFB4bXNl?=
 =?utf-8?B?c1pSRERrbHZvK1ZJalR6czRIc3FsRnowR0k3Y1dsaWNEeE92Q1JFY2VTTjRa?=
 =?utf-8?B?Tm0zeUdTU1NXeTl6SlZDTEluSXRsNnNBSStPZ3c1ZnR3NUtnNUZ1R2xGRVhK?=
 =?utf-8?B?bnp2WXJMQ3psWmlaYkcxOTFmQWdGR2tkMWwrQzY5bUtIUmFkbHJGQkpRQVl6?=
 =?utf-8?B?YXhVb2RjVlhvTUtVUXh0RW5temZrNUsweXQxN2l1THFReW1Ma2JEMXUyNTlW?=
 =?utf-8?B?a09Fa0srelNScXE1bUhjUWRRcUZJd0gzcFhRY25WUEhOME9XQ0tWNTdYZmZB?=
 =?utf-8?B?Tm5NZWpaWnVNamJRQXNIekJNMld5M2Z6YTFwUHdEZ0hzTFoyOEd2ckZlRFFL?=
 =?utf-8?B?UTVkbmwyOTY4REF4RFp4ZGpMT2pmUU9xeGIwZVBOQk9qMzQ4c1BZZUlrQTRE?=
 =?utf-8?B?MXY3anh2VjlRQS9Zem1qaFZ3WEdkRU9zak95TENmL2ErdEdXNjVnRUUwTnhE?=
 =?utf-8?B?WHhIQjdxbHVUZHdLeU9rUXFOT3JOcmhpU2dXRXBVd1MwbFczMW1BeUFKdUs4?=
 =?utf-8?B?bGVLZTZEQzVSa2x1WFV1WDJqQzdOeUR1QWFJQVRpWFg0TGhkUHpJK01CUEpl?=
 =?utf-8?B?TkRCcTJMMi8xQmw4R0NJWmhCWGxBcUJQOFNORTBvSVA4WEQxWEtuU1hIeUpv?=
 =?utf-8?B?TFBpeGFpUmVrbnZ4YVI5QlZwMDMza0ZGUUZ5RFVLRDhXMlkydUhoVWlYNGxG?=
 =?utf-8?B?dHYzYlRzUzVaU05xR05Zd1J4a0t5Ry9mY3hsWWRtS09BTm9pWWVzS0g3SFJh?=
 =?utf-8?B?SHlmajQxbkZ4ckU2MzJhYVYxZUNwVzZyK3lrOWxKaFlhcDJRMU9Pc2ROelRo?=
 =?utf-8?B?N2VoNWVkeTRobTNzMnpUZW5Fc1piU25xM0ptc0NhYlpwTXUzWWFLNkxWTnNi?=
 =?utf-8?B?UGxyNFpFdEdudVd4WktiVkp4Tjk3bjhQRCs1LzQwL2tuM2V3bnpwMHBsS2Nx?=
 =?utf-8?B?aUQxLzJ5WFIwRTE0VHViMkM0eFlXMXVWUGl2bXhSNXRSajhqYjZpeHMyYkxa?=
 =?utf-8?B?V2tPQ3pwenZCMDNpUkRKRVAzcTk0b0wvNXFyQk1CMG1WMGJXZGozUUdOT01v?=
 =?utf-8?B?blZSMmg2RW13d2pwN2JCK3MveHdhT1JwTWlaQTAvcTN4MXNiTGxwUjF4RWRj?=
 =?utf-8?B?czBQQXhONExHOHhkSWI0QXQ1ZTlhdzNHQWFyU1Vvc1RMbjQ3TSt1MUUxSzdw?=
 =?utf-8?B?K2pCbldzUS9NY1JpRlI0OTdrOEFCc3hyblB3b1J0OTA1ZWhIOE0yZzB6MktI?=
 =?utf-8?B?eEJYLzR0bzRZMStWMmd3S2FEYy84QlVGdDRSUWoxU2gvcW5LSFkzaUFSa3lV?=
 =?utf-8?B?eGZ5NGo2L3hBZU9FM3N6ekVEMjBQSzRlRUYvQ1JLQ0ZKeU84UmhidjdLVlAv?=
 =?utf-8?B?eG5rMW82ZDZaSTNWYXFlOFhZeWY0S1Z2VzVzZjRMeDZxSGpJcitTYzgza2l2?=
 =?utf-8?B?bWI1QVNud29KY1d5MCtVK3VOTWlrNVpRYTJZWkZzQlQyQ01pSzN4cEw0eElj?=
 =?utf-8?B?TXJkaFNiRW1zM3phQUdFbUs3SmduYmlHMS9yOWFBVEVaakZkVytQUjNzRk5U?=
 =?utf-8?B?UzdOV0F5eW9ubk9EdzBiR1AzWDBjSlkyRTlMZkFTUU1RNnE4YnZJNHlXTk5r?=
 =?utf-8?B?aEhvQzVjeTNvTFY1NGlkQUFPcWJWVVM3OStlZ2ozV0h6T2sxWDdIdWtGYmd3?=
 =?utf-8?B?N0dJbjRLNXBwRngyMFBNLzlMbmxpa0VQbEIzQmpNUmE4UGxya3pmck1mdCtj?=
 =?utf-8?B?QXM4ZUNtWmVsRTdtWnM0enRqSXNlSlM5eFA0NFNWd0FZQ1JUai9wSFJ6Z3px?=
 =?utf-8?Q?axc0++dB6+0+2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RThpSExWMTlDMEU3SGFqUW8zWUFrZExrQm5tN3gxUk1aU0t0Q1czNGhxeVpV?=
 =?utf-8?B?Y1NvdWd1WlNrbmpzTlk4dGwvR0x2WVhCRnlCakpKWGZyNWtoNitVNHEvZ2lq?=
 =?utf-8?B?alY3R05DeGdIZlo0amRrYjBXVTZVOThJNmlkWU4zTEJ0MEsxRjZnVHRjaUlu?=
 =?utf-8?B?TWVXL1dISVd6RHlVenlyejJPZmpHbFZpam03OThWK2oyVTFkYXhHaUtPQU81?=
 =?utf-8?B?T1R6c21kNmJjT2lUL1BYaStqVU9DT2VWWk5WcTI5M1ZxelMyV2huMExwTFhv?=
 =?utf-8?B?cmpMOUlVQnAxTDZibHhJUitCRUpmekVkZTRDRndnM0xVdldNaEpNUUN5bTFI?=
 =?utf-8?B?UUVzOFZway9SdzRKajZjSkxPeGZLbDZQZEpUeWZ3cEhINVZBMDVpRGhuS1dp?=
 =?utf-8?B?THRDNjVYeXlkTUJuZW1oUm95QnI0VWcycUIyTXJqWDY5Rzc1NStGbkdSOHVp?=
 =?utf-8?B?TFVjSkNNYkRFRHlLeVAyS1RYNGxaMTRhZG9xYnFvdElzdkJTaWpwc3EyMTBF?=
 =?utf-8?B?Nlo1SEZtZzFJN3liMGo5RWlPNkNPNHl1U1lGSC9KVTNaTWlQT3FQMzAyNVgz?=
 =?utf-8?B?L2w4NCtESmlOL1h4UUVTR0QvZm5PTWdhREJCNzJCSkhaa0NVNlhBV0pWYXFz?=
 =?utf-8?B?ajJlTzg5c2NZQkpiMzhGcWk4dWlmd2x2YUpiK3ZRNzdtQjFlWnZKdlY3ZjhG?=
 =?utf-8?B?TVF4NHpLd3B1NFVsWmtCVDg1b25yclEzTzBBVEJMMk9Fc2MxMlVVODRsRWYx?=
 =?utf-8?B?K2kyMTgvUHYwemFWWHRuUVJRMERNR1pWUlB6UHBQM0MvbTBCdGY5dC9vRjNh?=
 =?utf-8?B?dTFIY3huUm91Z29rNC9HV2JZZDl6L090b01JRE5TenV3K3J4OGtndTcrYmVn?=
 =?utf-8?B?VnpVNkJrVzBkSGtSbmZlbFhna3pFSjhuM2JLWEZmVjBVMlBPTGRobXBHL3Ru?=
 =?utf-8?B?OXVnMml0cXl6Sm9zVWIySmdUS3Z1VkZYMUZLdC9Vd0F1WTYwS0p5SmNHdW9I?=
 =?utf-8?B?bEVWMG9tWW5tS3piMUdIdUliSk9ESDNuV3RTMkZENnFnWnNLU2xCSjhUTVdi?=
 =?utf-8?B?T3pmUkFXblJnYU9KRWVyOG0zYWZtNTVHMnYwWXNyeXM4RnRiZmwxSzl1YndE?=
 =?utf-8?B?SUs5WmFtdVZKdkUxMHJEcG1Fdzg3T3h0Z2Vpcm81NUtPcWFNYjRKQVd6Tmhr?=
 =?utf-8?B?cjhwU3p2SnpiQ2NPV1VReHRJbk9CYzdoVkszTklodXRyVDZGU0ZGMzFaSmpE?=
 =?utf-8?B?V1M1OUE2SGRMZ1FBcXh3VnBmeDlJdXJCTjdWMytUNU1FcU91WFQrU1pEczB4?=
 =?utf-8?B?M0k0UWFoSXBaYUhrYU1UL2t3Z3czZGJmamREN2s5WkNiN0tpTk5qdnFqL0wy?=
 =?utf-8?B?RW5UMk1SbkNrcXdkQlc2emRPcTMzNGo4S2gxQ1BacVQ2NWgwQ2RyM1BqS2Y2?=
 =?utf-8?B?Tk0wM2ZlMUlQcFJ0blIyYjhCMFlxV0ZtM0Q5TjdrbXhObC85SWFhbHV5VUgw?=
 =?utf-8?B?VW9pVGM2a3BkRFA0QjNRR2xoUW1zRXEzZlVocTNlanhIZ0RhQVh1RU9nWVRH?=
 =?utf-8?B?Zk1CdHRvWnAvbDV1ZDdIRmJydzlWK0txS2ZPYStnVmhIYVhGRW16VWxLVmZS?=
 =?utf-8?B?aDRCWXNsdWxwUCtPVE1LdTBWMmJiNmFvalpQR3VtNXQwYmlBY2psZkhvb1pO?=
 =?utf-8?B?cDBJSnlzTjYxcTJzV3VjSzZnaXhhTCtyWnlaS3p1R2UrWXNKUjZLWHQ4OS9m?=
 =?utf-8?B?RC82Tnl0MTFRdFpkZjF6dFl4S3A1N0tmdjZCRUlTbE8yVkIyRE9xTzNJNWVW?=
 =?utf-8?B?ajhyU3FEWVZwaGF2MzdrYTBoaDBqK2J3SFJqdVgvV25hRjRRaGJKVlF6ZXpH?=
 =?utf-8?B?cGtRZU1WQVhyS0VaWHZudWZqQy95RE4ycE5QN2dnU2J5WnpGRWhNOGpPTVdZ?=
 =?utf-8?B?MmR2eEdzejl3eXp5ajc1R1FFTnh5RGFrZFBvVGFwTlc1bjIxM2dLTTY4c0pG?=
 =?utf-8?B?VnlUdWJxUUNrUFNadXRGRU1Tc1RGS282ejVUa1RsWTh1RGtETmpLYjVJQldG?=
 =?utf-8?B?cGNXWVd2ZTZmUStBdXVQUlRvbFNPNlZ5SndEcTRYYnlPUCtNSEhxN0xIdDVs?=
 =?utf-8?Q?AenN46/GNM/Ygwm7hEacek9Sx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ba4f6b-5a1d-4893-b8f6-08dd2fc57d6a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 09:19:01.8068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WW86V7ZtY9fuH/JUoz9NOQVPrdU42+HuUPBeWJO4FL+YEa0evliIdjV/nvi1Z3sL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829
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

Am 07.01.25 um 21:01 schrieb James Zhu:
> this original test condition is unclear.

No that is completely unnecessary.

The point is that with fence->ops->signaled provided the fence should 
make progress even without enabling signaling.

Why would you want to add this?

Regards,
Christian.

>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 48c5365efca1..d40f07802c4f 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -218,7 +218,7 @@ static void ttm_bo_flush_all_fences(struct ttm_buffer_object *bo)
>   
>   	dma_resv_iter_begin(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP);
>   	dma_resv_for_each_fence_unlocked(&cursor, fence) {
> -		if (!fence->ops->signaled)
> +		if (fence->ops->signaled && !fence->ops->signaled(fence))
>   			dma_fence_enable_sw_signaling(fence);
>   	}
>   	dma_resv_iter_end(&cursor);

