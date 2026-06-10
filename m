Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD92CD98C5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 13:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17D3410E8F2;
	Wed, 10 Jun 2026 13:29:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4QVEh9xC";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012005.outbound.protection.outlook.com
 [40.107.200.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1F1110E8F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 13:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WljSB5MK250kujiOS+uiVbHdu+XNLEED0cJlC8LB6V82Wjophpxg5mx29GIhIB4eXc/TidfSPeiRiR/W+LXQQcBtFT7nbSRowOnHuGZS4ERi/c6b6QIgdIugx/0NZTcLXEEdf23pghMo3YYFCRR+1qATTCtAvPvO+h2T7HZet5HDeptQbAU5zAuPELFYpFgGNtQMqhzyEgRavBJuqldJFaF+uOjl/jaDjVo8xQ06X/2GK/KUK9i4hqAuihsYjoizRtRNb/GHrlTwgSm69JohwZq0I202AtjAHtQ1bFbvSq/+XVPQtvLoideIAUoRZMe4tUo3ybtZ1Vi2PaCLvzrjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzOeythD/op4Hfe3acq8DPi6Ti1e1OkGmb1K5o77u78=;
 b=LIO29SV8nzROFNtjbi47yhzwJ1juTXXBWBgoVMfcLGv8vGijUvzbwqR9otgmJgktCFrVw/3EdptoY+pFCCqtGLNygu4L4+oovOna7MkysSYmE5920afEFTLfAuZOrPmSbi2jxIKPL3n0nQbfb+TZOkG6lcsoDcrGnhXDnk1sAvWerLI2nfHHUbPR87QQqWUCj0YG1IcrTvqXQoWzdo5xWTmAmQ4k+jDIgMstl18K2FqcpMc+Fwr+NSXkOaGUxXVDkp23+J2PQ8894yYXVY02i6TbNFq+PFkycSQAom4kJYnhEs/YPenCkgfkDHF1FzQ25seEZueReZh9Qs3MOSjI+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzOeythD/op4Hfe3acq8DPi6Ti1e1OkGmb1K5o77u78=;
 b=4QVEh9xCawU/j3ctjbQfyJ1UU9rl6kGsGgSh8otMYwlhUTf9Uw6eJ63mVgTqSXiKkAOoovHRu4umFWHhMHN9wvf929f+GCcfO2FeytQEz8IoNsGPU3ho9tg9pYfnNZDxwwdgXgOCWu78jksuiiVISt9XN+AF83pOr251Pgp76YE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 13:29:10 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 13:29:10 +0000
Message-ID: <04061de3-10d3-4fa1-b166-5bcf3139037d@amd.com>
Date: Wed, 10 Jun 2026 18:59:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amd/pm: smu_v14_0_0: add DCLK and VCLK1/DCLK1
 metric handlers
To: Priya Hosur <Priya.Hosur@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Mario.Limonciello@amd.com, Kenneth.Feng@amd.com
Cc: Pratik.Vishwakarma@amd.com, Veerabadhran.Gopalakrishnan@amd.com
References: <20260610120944.124040-1-Priya.Hosur@amd.com>
 <20260610120944.124040-2-Priya.Hosur@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260610120944.124040-2-Priya.Hosur@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0222.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bd06f2-e94d-4bda-fc1d-08dec6f44150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: m+51HGOM/NsZU6fb4zmm+qEibHgfokSRb7FrImL3y+SZOyfg6MxcX2Mu2+AxNEVVEMr0/RujimGk69/jx3N36XS3BCObmztc5hk7PCfSwlrLLULvbxsyuBPVG5lYnhqiwcqpJrbHJr8vc1DVIYjaTa42tuiawcdSmQxhvXta9Uf5MjfhaK/OHu7GLbqxs3+aPwJruyTIP6UW0j0T1IYOM85YcK4MQB4GyittaugfDbdM52dYJFfm8dsMQk2s1rPnmROSGsjq2kG+BJuRTaRpH1zumv8A/hzQ2RYKiKPduQ8o5umhISQmVWfKoLXN0FTitq9DEvXyMFWHEuDTaK3tCmjiddbH5iQBRrahPNFqKehiTUeeZeDnPMA2BYk+kj7cav5/oicsdk0XQeKgV998a8US8B6axAERMZDZwecfdu9FmYBk16W3giE/csINDAPSjcx5sWZpy6HLiymHWeOuhIDasmG2010/va5cUzrz43dqDo/zSIW9onRQr16M/AI1c4+GQblXYsx54LfnU+tOqKhp1PXc+rYhTzhJLidIBXB6HTQyRAlOA/Uox8pF79Q9zPxJDvNyL1dK9XqT9F5IR0YT4roHimE1uR/1xqAD/Jq/kwVfd5EIq4dHYM01meUbej/XSrfVyrLBiRMxy1tZ+TpbvjXAwthvX8Njrphe25WVvNL6SbVoJo0FHBdvftLN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTAxZEF1dE14b1cyZ1ZjV21rTUpqUHJFQUphMWdjYncyT3M1Ni91dzhYTkE5?=
 =?utf-8?B?aHVUL1pUcG5BUW1GU2lPMkJzN2NQdm5oaXNpWmRaTEdoNEdMZ0VpT1Y5YWpS?=
 =?utf-8?B?dXVyWW1lYU1HZTQ5THhUdUhrelg1Ti92T3RVcU83ZkpqbnVLejlHZDVVTEZU?=
 =?utf-8?B?OUhtSW1nVlRIN3AwelpmVk05azYzZUo4UFBNVHZWdjV4aHN5RDl4K2FnbTlB?=
 =?utf-8?B?QmZrbU0reHEwVVkxeHFscWRtcWhQaU5xN1NlK3Y2enF0MHhrU3ZGZXRkT0xv?=
 =?utf-8?B?S2tQQWVMcXhHeGRMZTR1Y0hvS0hQRmM2R1psQXpzYlFLWjFETWxZN3luK3kw?=
 =?utf-8?B?RG5YK293VHpMemlMdXZ2TEhjeTNRZ2JDZTk5azMzYVJ5YXhmNktSdkxvVndm?=
 =?utf-8?B?OW05Z2g0Z2Vab0dtME5QTUdoQzNzTW1xUTlIU0d2TkQyR2pYVW1DNkJHN0RP?=
 =?utf-8?B?dElGZlhGUDVsVkJWaGk5Y0Y3UUJ5Q0UzSG5UWEVISy94TDJFWitreE96dW8x?=
 =?utf-8?B?UTFLd0Z6dEY0WUlSaXE3cEgvNzlDeFJBdWZhdmVwQnNBMHcrQ2FNYWE2aHNu?=
 =?utf-8?B?TllEVlZMT3QwYk5pWUVmNTRJeEkwY0hiRFY2YkdFQzZxU2J3MERlTVlBQjJV?=
 =?utf-8?B?dGRTaDFDREFTYkI1UnA2UzNQTGhOZjg2QUNOU0s4L3RHVFZSYlRYS2lCbThB?=
 =?utf-8?B?Mnd2MUUxM3FWeTViaTJ0eGpkazl1eExybEJERUZ4dXlZU2hWVmZUUWJjWmhS?=
 =?utf-8?B?TkF4OUZvT3hpUkVwWThZblJtc2VyZ09nMldCR1dpZlN1SFB6NWRla1krNUdM?=
 =?utf-8?B?cjF1Y0VjR3JINE4xY0NXWlpMeHliZ1ZjTjJkMHcwM3dOcG13WFJyRzB2UWtQ?=
 =?utf-8?B?bTVGdVlIdFk3YVZ4L2dYVjIvZVZsUHlRSE5kK0lnM09BSWNkdUxXcWxsdE12?=
 =?utf-8?B?aGdwMDErdkRIWVg2aU9xOFcyY0lWTExUMFFVQjBwMDZKVCt3cHVTQU8yT21H?=
 =?utf-8?B?Y0xjcE1DM1hxR09TV2I1cVRrdGNZWjdBMDd5UUdnQ2xWN0E4aTA5U05KZ2Ev?=
 =?utf-8?B?RGFvWVdUZHZjL1RLSVlMQ0FyRXRFRXlWczR6VTF3Q1RZWGF2U1FmL1BYZHlr?=
 =?utf-8?B?VUpyanF6ek80VW1VakMvU0JRRHBGTG1La2piMkRxMitqbkFQQXFIT293My8w?=
 =?utf-8?B?MmdwNldjQnh3YjRpVjNOUUFjL0paRjdTT1lscGpENUNPbm93amo2eDFVaWZE?=
 =?utf-8?B?TE5tKzFuaVRUbTA5QWNxVVVpOVI5WEFONnBLUmdBRHpXSFhtU1BWS1NHeWhW?=
 =?utf-8?B?LzFybk5PZCthaGpha0RsblVyczNJcWkwckNpSXZYVzdrSXN0eEJFemhtbGdo?=
 =?utf-8?B?enhmcUNscEx1bkE5MVN4cFRSTGlwaDczaHpHUEhkQnJHRnF3SDdLcklKZlJT?=
 =?utf-8?B?ZWVBNjhPUW5xYXo0am5lK1VlaExOSmxwY0o3MWtldGxGazVUK2lxV2I0WktE?=
 =?utf-8?B?bHU4K1dibU5XK0JvYUV5VkVMd1k1TytSNjM5cHVyWmJhc3dadlVjR29VenB1?=
 =?utf-8?B?dWlGdncxU1dNM3hScDVBdkx1d0NINS9iZ2k4dm9sQlZEdHZzMVJwV0lrbHZP?=
 =?utf-8?B?cExpcTdhWEIzSW4yQ1cxYUZldStSdy9Gd1ZsMTBtYy9ud2hMOWU3UjBMZk80?=
 =?utf-8?B?aXZnM0lJc0lFMzZhUFlPb1hYYjAwU2dzZlpza2FKaEtaUExqRUFvc2hIWW4w?=
 =?utf-8?B?UHMyVVg2UDNWbXlPSTYyTHEvSDRlQmtDakdEQURZT2tzQ01QM2RuaWpFNFNt?=
 =?utf-8?B?Uzk0ZWU2ZHB3d3RVOVQrVEFLWm51Vjlna0RGakpIcEhnenVYcE5QcjZweHBs?=
 =?utf-8?B?L054R3BXbEVxOTl5UWhwaWh3Z2lINlZ1b0pxMC9ha2JjdkRDK1lFQU5hMGxy?=
 =?utf-8?B?c1Ayek5LM0hWbGpyS2s0L08rQW9wb1lraWtoTGo2eWRmRVFlcUcyMGNvVG91?=
 =?utf-8?B?WHQrSEw1SW1VeGZJMmkyYzlibzBkOGJnbkE1TDdBdEtjQXd6OHhxRFdxbG1o?=
 =?utf-8?B?SnNMVmg4ZURNRHNHUFJQU0RLWXZOdzlmNWJldWNITWJLd0M5dGx4Rk1UeEdY?=
 =?utf-8?B?eEFoKzB4ZFBmU0Z2ZUxUUEdmWEFJV1V0ekNmcTdwU0FMQ05CK2p1M3I4djNI?=
 =?utf-8?B?bzRaajBLNXFtbjJtK21ESjNVM0ltOTlmNFJwb2tlR3lpbFFvMmcxQzdNeU9G?=
 =?utf-8?B?SFJRUmJ0NytVdWxTdytkN1R1SnhOK0ZoWHA5bkN2VUxJd3FyRzZwT0JjVERX?=
 =?utf-8?Q?vnETtLSgxcsAbtoJ2P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bd06f2-e94d-4bda-fc1d-08dec6f44150
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 13:29:10.7342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnTMh4c9oUPdXugg/QtU4Hf8tpONYmJu7kgaY2aJzK73KAVWB7Q0YAfQNAyi/CSM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074
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



On 10-Jun-26 5:39 PM, Priya Hosur wrote:
> Merge METRICS_AVERAGE_VCLK and METRICS_AVERAGE_DCLK into a single
> fall-through case mapping both to VclkFrequency, since SmuMetrics_t
> has no DclkFrequency field and DCLK tracks VCLK on VCN. Add
> VCLK1/DCLK1 metric handlers returning 0 as the struct has no fields
> for these, avoiding UINT_MAX default that causes N/A in amd-smi.
> 
> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index 2fe006de927a..c977681d8946 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -281,9 +281,13 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
>   		*value = metrics->SocclkFrequency;
>   		break;
>   	case METRICS_AVERAGE_VCLK:
> +	case METRICS_AVERAGE_DCLK:
> +		/* No DclkFrequency in SmuMetrics_t; DCLK tracks VCLK on VCN */
>   		*value = metrics->VclkFrequency;
>   		break;
> -	case METRICS_AVERAGE_DCLK:
> +	case METRICS_AVERAGE_VCLK1:
> +	case METRICS_AVERAGE_DCLK1:
> +		/* No Vclk1/Dclk1 in v14.0.0 SmuMetrics_t; avoid UINT_MAX default */

These are clocks for the second VCN instance. If adding them to FW 
metrics is not an option, then reporting the value as UINT_MAX is better 
as that indicates N/A (not applicable/available).

Thanks,
Lijo>   		*value = 0;
>   		break;
>   	case METRICS_AVERAGE_UCLK:

