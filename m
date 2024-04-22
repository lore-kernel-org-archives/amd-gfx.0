Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E246C07C79
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 14:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3C73112B6C;
	Mon, 22 Apr 2024 14:29:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YfESK34u";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA4D3112B68
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 14:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeaznQaY8sxBz4Y/5ufc7IA/Pi7c2tmenFrse2kxplIgm95pqPDwIs4FQuhIdMa1hyGQMyJj7RKAt1n43b1DQsA4vBgs19KO9zOi4ESfhvrozzUV+JFg6ebA1R99+FGsXWeEJS4hHy/kbrJJj5kM50bJ1UTgzeS6aY9uG6RzW4/tCmgE/5iHmDOlMQBJXXZBzQZcapJwCEpTlKV8jwJ3YZYkTTKzmrIiN6BPQLGo9K4h3ZD+jMs7mlT7wQ0pi/b6EfEKt9umbwVyXv5VqOC2NAZ5KqZL4TdjnEl9TN6WNhVmKObbYYjdgNxdmnza1ITloV/tXVCW91HRL8PwRUs0SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBSZxJoJ3wopKPya4CoYrgsAwnlf05ddnGPEWN/mo28=;
 b=Xqxn4KQjd4N34QlTwVgHbdGlcsqdSIxnBkfpiP0RjysxAn2ydDM+8xzm/Oah+7qMOCg52+FML9YnWfY5Kpsm0SyAw89asSA7pKsLvUC7C5SqXHC3DpWS6lqywjvv+WwI/mfCDY6FglLWsX79v321sFfPoUCic7H+m8022TuC0ZX757CdsPdoMPLpqK0/V1Ktlmzwm9fnSos4kxq+o5kjXV4CPt9H9ac34jnDoNa6A+Gj4MZoTPne3WxHfwACZNlf84QWfPwYvUZHSB0oaOPxYYwuanqn8aYLkn570vlstkjv0fxuWxIZp/if3L5At3Nz+onZZp9co2VgiJO3YFPDEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBSZxJoJ3wopKPya4CoYrgsAwnlf05ddnGPEWN/mo28=;
 b=YfESK34u4M5eXZ/wZcxz0Cm7Rtl6L9kPeds9KVR0qMsfwnJwGBgwggfSBz47vtCjXrJ7DejwT/R/h5RjE47Yi6w1IW4RgK5+YUDbOHbWWMOjJ1zNkkI6ZW6bLjYSvZMF5+Lapc2eFe3as93/usGyERyzL0LBZj6U3YX/ijAkSVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 14:29:31 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 14:29:31 +0000
Message-ID: <b5bec2a4-b15c-4021-9978-9e3c3a87d067@amd.com>
Date: Mon, 22 Apr 2024 10:29:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amd/display: Add fallback configuration when
 set DRR"
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Mark Broadworth <Mark.Broadworth@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>
References: <20240422135157.3341796-1-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240422135157.3341796-1-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::29) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MN6PR12MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4cf247-1f98-4c40-6c7b-08dc62d89fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0JGaVFwRjM5SytKdGZ4R1hUakpBZXVwVnhxWE1lTy8zTTFUQkJpczBpc1hk?=
 =?utf-8?B?RWlYaG83emg2YXZ0MFIzZzd4bUNUVWRNVHc5NTFuTGN6dTdsM05mcU1laFVY?=
 =?utf-8?B?eThWbHUwUTZqblVkcjFGVjBKdkJtcFRCVFVxTE1JZ1JGVW90Z0cyYUNKVnNx?=
 =?utf-8?B?ZW54cmpvWkFhR29FeU4wQm9ocHlqR2xsWXJodHNCSGttdUs5WGJyRUplRkg0?=
 =?utf-8?B?RjR4REVQZkdlQVZ1MFdRbmFwLzE3Y3I2NkJMeWtsOEE1aU5yazNEbThMT2lB?=
 =?utf-8?B?N2RDNTZKdEZhbWxncVBqZmZnYlRoUFBxQWp5VGlWMUMybUVLSVE0bW1rY0RP?=
 =?utf-8?B?cmpNeHQ4TWpkamF3Z1hYMjh1Rmg0RmdhbzJIb09ORE9aNmVKRjJWVGFKajFG?=
 =?utf-8?B?RVVKREFZWFFkaHU4TVJFWW9KakY5dXlMb1Y5bFl1VkJhQW4yOGJhcUlmamNj?=
 =?utf-8?B?OEJkcmNGbGRLSSt5YzIwRVB3bWxKSkpLZ1hrUzA4SVFLa2tXNnNNdHQ2aEU2?=
 =?utf-8?B?ZzF1SDVuUUJITWJZZDZ4TlBuZGpPeDdiK0syemYwWUVVZHpjY0Vwc3RmbmJ5?=
 =?utf-8?B?WTM5cUtndUpFWTdjQWtNV3FjSklQMERDUWs4ZXRIQ1gvZFBMK3hhazFoSEN3?=
 =?utf-8?B?OVlJVGVNQnNYQXJTSGZyenBtOVRlZXpXZDUyOWE5elpMUGpFKzlINUtjVnVN?=
 =?utf-8?B?SWo5dG5ad0owMFZmcUxRdEVDUy9ndFdsR1F4NUJXWmRyR3NLQ1laMUFnSjNP?=
 =?utf-8?B?Q1NFbEpCSjZUTFV0MFErWG5lL1JOekJ5elJtV1h0di9INW9wUEdzRWlWSDkx?=
 =?utf-8?B?MDdZS1RqTXJjaXZQVWtMdW9uMW1mRjJxeXArOEVDb0d2SGk1Q3ZOUGxGSXpX?=
 =?utf-8?B?c3FqVjFHcU9jaW5QUGMwM3pHRk5oR3BJVjkxb3lvZ3BHdmY2bDlMQ0xtaTJG?=
 =?utf-8?B?cFNGZzhhWWV5QUdyL3QxcXZLdXYwVVkzK0d4V3Y0c0JQVkNLS3pzZG5mcTRR?=
 =?utf-8?B?a3BrMExNRDBTQzJLaWozN3JJOHRwUmM0UTA2c3NEU0piL0RkenZ6MEtVVXBX?=
 =?utf-8?B?Z2RNZ3VXUWNCUGI5VFJDclZiWm82YjhReFhsa0swT2dQQnRZdTJzdXpvTjFN?=
 =?utf-8?B?Ykx4MWJsdS9DbVB1eEJJV2VnWWdEblFocGRIa1F4T0hRcnZFbWZvcXhvWWpk?=
 =?utf-8?B?WjRhbGNQTTIxU2ZvNXhzT3lyZ3BNclRiRHNsNU8yQ2prbkdFV05jMWN4VVBI?=
 =?utf-8?B?aEMyY1E0MVh4cnFSRXk0Q3hOb2RkQUFZQnY1aFhsTEJpc1Z5Y2g3NkJ4NzNj?=
 =?utf-8?B?MytLdjNCQjk0eTNURDdkb0NBMDhoa3FYdlFjSHBhOTdjYjZvaXU0VmhOZ09J?=
 =?utf-8?B?LzdmemFwaGk3MXFCK1BFQkVsM2xaL3ZFM3p1dWN0c3AzVEtDWEREUzJvL0VH?=
 =?utf-8?B?ekwraTRjQTJ5dnEweVM3VjlZdWdhK0d0SVdWSkJQeTU0K2E5NmJLNDBQSVhh?=
 =?utf-8?B?b3Z2ek9NL3N1ekV1U2YyVWtjYWpGNnkrSzVUZXhPZEVCTm53Y2I2Q2ViRXB4?=
 =?utf-8?B?Y1lpZlZza2U3NS9RVml3cEVBdEY4Qi9pTFAzNGNJanB5UW82Y1RVOG5YTzdw?=
 =?utf-8?B?RVN2ZkhIZGJrSXUvc1c1Q3BtV3M3YmQ4aDNQR2hqTkJZNmxNZThNNWRBMVhS?=
 =?utf-8?B?am9kSHRhM3BFeFZaUk1IUFlocmNFb2JseEdsMHNwVnovVGx6RkNmU2xBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWRkQ2ZYdEdZOFY3S25kRzBvUXZJTTh2RFZJNURpbnROTEhoS2FpQXNJd2c0?=
 =?utf-8?B?RlJ5MWtOYkhJb0pOb0JaL3hpMUt1QjB1UlM5UkEvV2JBeVdGRjZHNDBySCth?=
 =?utf-8?B?TXVGZ3JnRVZyYnlPU0dsS2hPSXlBRERRaWxaTVR5N0hqdHpFNGFseDc3NzJa?=
 =?utf-8?B?Ykx4NGRCWTc2UXhncktBc3lsc2grRVVFSE1XcnZGcFowTm40U3BJdk1HY1Q0?=
 =?utf-8?B?MVdSVnAweXgyU2dRRWFZeWR3SWthZkZEVm9mN1FXUW10Y2dWeThpZnRMRWJp?=
 =?utf-8?B?WFB0dVM2QmdWQkhzQ2xSMXBlSkQvQ1BxZzE2WXFMRFNTeSt1OEhyK08ycWtD?=
 =?utf-8?B?a0QwYmQrRE1JMGhsM2Voc2czVnBOMVZ3QmlRbHE0Z3pxRlFHNUx1S0NoVUs4?=
 =?utf-8?B?WmRMQzRmRzhPd0t2RkpYUzJkMG56bUI1NTgrVUFMRFpqSVlwblp0VEZkaHc4?=
 =?utf-8?B?UmxpK2p3Vll2OFdIVEdaL0RiMHZNM1BFOEF6cmFabFNRTTdYY2YxMzg0RHlZ?=
 =?utf-8?B?clJna2xJNkREQmpFWFo1Uyt1MFhqdnQ4OGF0T3dnVDJ2MUxNRnNtVkpNRDRL?=
 =?utf-8?B?cEs5YlRDeUVnYVYyRllOY2VzS0JlYnJ1UXFmUEVSOE8yOVlsSUpxM1NBVUJr?=
 =?utf-8?B?WGJJamFhRFpDUXhRZG9rT3dHclJ0dVNYREkzengzTHRiU0xKUXg2b3BobXhM?=
 =?utf-8?B?VU9uY2VBRFF1eGlvZXMvVGs2d29yb1gwU0NGVnNORWtRVXJNcDNvamVudmpB?=
 =?utf-8?B?NHFJak5OQXJ1dXkyQW9vcFVTVTBwNHFwUXJXRWZYanhyS3V0Q005QktSZ2Yw?=
 =?utf-8?B?K3Z4OVhDOWZhVGJuTVloWmFwKzQ5dUI1MDZ4Q1I4NTVQdzh5L2U3TkNNaXlI?=
 =?utf-8?B?N3lVTzhrQ25UVE9URkN3MHJhR3AxUXFqY002SUFQRzhQc0JTQndVMlNEZnZs?=
 =?utf-8?B?Q09UQVg1TXJoRHcwTlNCN2dPczNuWUxWV01ZTTFUQUduRUkxb3FNY2M5a2dP?=
 =?utf-8?B?N3l4TzNEeFpNZXJ6czVReVJMZmhScjdnMTVyWU9rWjlpT1NIUnJaY0M0bGh1?=
 =?utf-8?B?eUJoa0hxSG5LVHRsdHlWWWo2ckpLYUFWMkl0SVJlMkdjQXUvOWRlZHo4cmtY?=
 =?utf-8?B?R3ZSeTZzVmtkQmdNUUtzY3RUcFN6bytQWFZ2RkI4RCt0MFVnS21HWHRyd29Q?=
 =?utf-8?B?bXdhbmoya01JTmxpNzU4NWN5bThjQjBjcjFEakFpL2N3NEhNV0ttU0lWaFEw?=
 =?utf-8?B?SWxvOWs5RWszZmt2SjRpTWh6a01WVm5wRGcvQXltMHpMd3JmOVpyM2N4RjVz?=
 =?utf-8?B?OWlkRDJLRFgvRXZZeVVjUDQ0UDdZTDhCM2kzVXlTTERmR1FLMXVMTDNzUlRu?=
 =?utf-8?B?czhlT1ozQWU0cXFnL2NxaWQ4emc5SFZuM2ZJcXpHUERrcWRKYWdrdG1qL2VV?=
 =?utf-8?B?U1d4UUhkeFhOTnVlR0RwbU9IcDZJVkZCK0hPNlBGQlRuRE5ObG1jOG5ybmNE?=
 =?utf-8?B?WC9vUE9nQXUyd2ZJd3NOWUJ2bnJQUkF5MHByQzNyMmNZaTY2Qk1DZGZONkl2?=
 =?utf-8?B?RE1YZWZ5dlJIV3haajNFSUtVcG01OXJVSHB5NE9KcEk5Wkp6ejk5M2l2SGVH?=
 =?utf-8?B?b3JjcHg3dDcwY2FUNEtoVnN2YTJzNG9RdVo5dUFFbENVZUhLRjVIbGVaVDJx?=
 =?utf-8?B?RnkxWlJKK2FRa2w1MmhKMy91UnJMclc1WjhWa25CVTRnTXc2NG5JNnJ2WVZL?=
 =?utf-8?B?amwxWDdyeVQwdGt5WmxydDdtbWVKdTBiNEhoZGdKd3V4d0VvOHZkWVg5Lzhp?=
 =?utf-8?B?R3pGZGhNV1oxeWwyUVJ0N3gxVzN2aXR1eWtKZmhibTJwRE01WXcyQTVSMTVz?=
 =?utf-8?B?RU5OeWdZY0NBZ0YyOFJOMi9CaDFLZkl5QWhWNEJTM2dlMVEvdWIrRVRvM3NC?=
 =?utf-8?B?V01idXlzVG4rN095L2d0bjBMNm4va3NPUWU4SjdOSGlSS3JyZHVrYVNHd01H?=
 =?utf-8?B?ckxVNGtmaWVsbW5SMzczazFwYzJqKzdoZURIaDdFYVpFZFRuT1gwQ0hGbUc1?=
 =?utf-8?B?TVl5c28vcnJ3Q05HUUpYNmcyWVBFUHNVdndXTVk1a3lQcTFoNTZSb2VKZDRw?=
 =?utf-8?Q?XP1g0BofbKY9VUCAlHE9WpvuD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4cf247-1f98-4c40-6c7b-08dc62d89fcd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:29:31.4738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSOmE2KL+XB3OM9KmK3RRxiUk3jS4qYUuXroIX0QIhVUwl61zxXdmLnuihPeUL+7BISyqWDKVl+rlEIUCYnC9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591
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

On 2024-04-22 09:51, Rodrigo Siqueira wrote:
> This reverts commit 5ea4581611d14a6a0e8df40965802ec7bee9c671.
> 
> This change must be reverted since it caused soft hangs when changing
> the refresh rate to 122 & 144Hz when using a 7000 series GPU.
> 
> Reported-by: Mark Broadworth <Mark.Broadworth@amd.com>
> Cc: Daniel Wheeler <daniel.wheeler@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c    | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
> index c4f0e1951427..52eab8fccb7f 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
> @@ -293,16 +293,9 @@ static void optc32_set_drr(
>  		}
>  
>  		optc->funcs->set_vtotal_min_max(optc, params->vertical_total_min - 1, params->vertical_total_max - 1);
> -		optc32_setup_manual_trigger(optc);
> -	} else {
> -		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
> -				OTG_SET_V_TOTAL_MIN_MASK, 0,
> -				OTG_V_TOTAL_MIN_SEL, 0,
> -				OTG_V_TOTAL_MAX_SEL, 0,
> -				OTG_FORCE_LOCK_ON_EVENT, 0);
> -
> -		optc->funcs->set_vtotal_min_max(optc, 0, 0);
>  	}
> +
> +	optc32_setup_manual_trigger(optc);
>  }
>  
>  static struct timing_generator_funcs dcn32_tg_funcs = {

