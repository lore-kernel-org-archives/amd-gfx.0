Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9898DC43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 05:53:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2399E10E2ED;
	Mon,  6 Jul 2026 05:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SoPoxZIS";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012008.outbound.protection.outlook.com
 [40.107.200.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DE5210E2ED
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 05:53:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThArkjQfeX/W9zuAqBEC8ljRclyxRmJhQuuAkBSduC0nr2ZZ2a0h/PFAquwJr3LP1QpijO0uGw7OUE56tvtROWk+wGyHbQSgQTcOUYKmRFJ1LnnTMh1g1aT0i/X17phJeqrMKNqiVuOAqavjTcmUOvEEHVs9EW9FEDCWhrYpiU22rNfzdQYPkfBdbHOAiprIMSjuo20XXQo3ICv00IaKfkCj/4/YYt/tjbTgfw2Y5MM8ykqf6x/xM8e7Jnoisa6yAx5PY8Yn2a0PIZOVLEXFyElE3PRK+442psFb+0RePcm7IbRtASbgTzkExHtpzUz9L7Oo8MqFRHGvZkLpieeVKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpFJE6bt+hOHiywVQUPzGLfNaRqKDLI0MPpKII624lg=;
 b=H+zGXuQgl//H8BtR1bUTSKKRTXzA4PKw3rc446QgbJW7nciuPDoILs9/GId03nIuCIYNF6nb64hO3xm+oTJEmrw/wYLsXd3eH7ihil5OYZagmr6AwMDMF/5NwS4JQVvGSneTy0G+2QOB/vu9bw2dMY5s6FnGlQHa1Omch0tYiL714xLew0VAED7+IazRmFeuDIMxZ/ZJ8dgTJJWeCEwc58jGVXSSAiLSaq16qJbz9tAosJ5kMmt9/ziEsh2fg43BjRq+s1/+mLhmOrfOtLnsbUKCAy6gH20/SaMeUKRPqj9wicg/63/SbW9RsCGF+Fh4mNsWilCQvUjQEvNumltZtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpFJE6bt+hOHiywVQUPzGLfNaRqKDLI0MPpKII624lg=;
 b=SoPoxZIS6gUQkzbDmHHrmsiUK/BBv/MnXGgboAvTRA+oAnvud7XMa3Il1gxwCO3blKfkKtZfjtB3UhkqjQdQNWWrE4Zuh2qlmImn6PZ0LzHkhiVYPJGrImDx3bnObIG9hoNKIYMxmEfd3H1Mv+LtlMKWYzV5G+q7E/MSfaFcCx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Mon, 6 Jul 2026 05:53:10 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%3]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 05:53:10 +0000
Message-ID: <6e10a3d6-bce9-4e85-bb17-e5f530f90b49@amd.com>
Date: Mon, 6 Jul 2026 11:23:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: fix smu14 power limit range calculation
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20260706013807.1051660-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260706013807.1051660-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::7) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|DS7PR12MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac2855d-1451-4658-d959-08dedb22dc31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QojLJe2lV3WJws9auhhRE3HWYkrt4bseT4f6it2BQYLBNTLUW8pyUGEc0/YqTKfENFa6pKNoIkg47prumGJDzRoDdNawBaE0PSsnCCszrLTk3j533qOW8KbP+wlRNdG7kjWTyqRQ1tSIo8WURY4J7tBB/RwKMmWYMArA4wAb+e5tq9eEoBXi65TAgOYqJ2S0nn4LTcF/f58xyfXNJM6jmc2avZ0OG1my2YO8m/G/n0g57Y+BjepUHXMvjF9ApXS5we5e2G0tJw9eY5XSAaoE6KklJqzUfpEx/OTCVxapiFJPm4BRJsBzxLhJpEghRn4MZHaWq4rHMMDnzFq8GfXJbo5clbc+WAMpR+q18g0GmEwTW4d++q5bmIIhWGTV8+GyESrbQZ3rK9oahLTakMNvAaurGUSCI9g6KFZE/SAT3JOE0ArCyQWo6hy7ARns1IcrFhHNWB4FySQduXgcz7hYEWJUV/nYPvOEZlL/Th5K2uXthu6RAi1qbbK87HT2hIjRyev0pJxmMtWTLKWxeg84SR/07AK2OaY5cnMhvhIBJafo68DYX4NII76tHW3zgGkIBRaBH3E4JWfjSFNMeRyykRwOKLRmGbR7G8fUld+I6EEiFz7YreIhEFdq5KkBZrE9C5ncjglLJBBfS/7ea9a6dbmvzELH9OqhdGDOgkvRCX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUQweXE1NG5WOUxzTlBtQ3EySnk0b1QyWndhSmZXelp3V1lzOE1KWGwrdEFN?=
 =?utf-8?B?bkMrVWhPTlJ6WGhFM3F1OVlINm1VK3BuM3J0K0NOQVJ5OFRvYjB3a0RlWmhR?=
 =?utf-8?B?M1dqYTJsTnVGN01NT1hTN0RyYVBza213Sm0vS3hhc3FGdFp3VVpab0trMmJI?=
 =?utf-8?B?S3ZJMHBhSzNhb1gxWE5iSXhOeEd1cXhpd0FvQUlVZTE2a1N0SGQ4VG9qSE91?=
 =?utf-8?B?dTJkaEppRVVTQlh0SWJMdWJxckJnMTl2Nkw0TmNySm9OZjY2ODBVRklEeHRF?=
 =?utf-8?B?WFZmYkFpZWVPZHgycVhJVmlVUTZBaENSeUNNT1VoZWJhamJ1TW1YTmhwYWIv?=
 =?utf-8?B?VldabVowSmhxcS9nRTlpTHZDRzUyWnZRbzd1NUZTQWZIMDJNTjNJOXcvcU0z?=
 =?utf-8?B?dlIrR2Y4UTBSaGRnUWVQa0t0Ri9WWXZ1ZGpHT1NmNmxXcXlTMmkzU0JwNG55?=
 =?utf-8?B?VEVzY2VzVTRNSXNERHcwa2w2RlpicG1CV01ONUZ4b0ZMOXdBcTdNZUdOYnNB?=
 =?utf-8?B?LzZ5dVc5M1Bmd1VFYlpPUFNpM0tTclpoa3dOR3k0ZDVrVElNS3dtMndLd01m?=
 =?utf-8?B?aEZGb1JIZXU0TE9IR0d4WTZaSXp3Tm52eHRmTW5SWFhxVjRZbXJCeGtNOFda?=
 =?utf-8?B?VmkrOUFDNmRBSDdwMzRrNkFHMmFic2lyRTFrc2lqVmhMakQxZEY3UmVKMUdX?=
 =?utf-8?B?NTZpQ25ORHByc3VTZGc1UUpoakF6WFVwWWJCaDA0c2ZvWWJyK2ZnZW80Y3lO?=
 =?utf-8?B?VUxZUGRrV0ZiMmtpVjY5dTN1NnRSMys5UDFyb0xjdzNCZ0FXaEsyT2ZVVzk4?=
 =?utf-8?B?SGcxVGZiM0tENGMwL1JEODlJV0pXeGUvdXhQY2lmbkNFQnBjdXZ2MDcyV25y?=
 =?utf-8?B?OXVhRi9HSXRsQWd2YjV4aE4yS0YzK1IxdkYvN00xYWVYN1BNK0Y2MkpmTmo2?=
 =?utf-8?B?ZWFjYkZLRS9KTlZIWjc1ZjNnZHZXcmpGbFNHNW1WOFhQWFhCT1NpUmpvSHQx?=
 =?utf-8?B?cTc4WDYyZ1NBcHlCQmVuR0ZCTE0wa09WNFNkNS9Pcit0Q1ZpcS93VWhyNG55?=
 =?utf-8?B?VEFPQTdQclFqNE5KRzJIYzZxNzYwZnBWdVJxOEZSMWtqa2hreDVhcXYxY3Zy?=
 =?utf-8?B?REdTYk9IdGc5ZFhrazdOcHhHeS9yNzVzcTJDcWJ3angzZWx5UWJHNE9XQ0p3?=
 =?utf-8?B?Vk4zSmloRTN4SUhvdnhVZDFBTENSWi81UUVBWDhnbEg1anJ5RmlaNjdNRUpO?=
 =?utf-8?B?ekdRK1BaTVZtQ3poMVBiaTAzVFRyQW1wbXZyMjZEM0lWeHVhMlY1a1VpNjZ2?=
 =?utf-8?B?Mm9PMUhXY05ocW11d3E4OEhrNVBHWEZsMkNzUTRuTVNQN0dRTEY4emVUVlRM?=
 =?utf-8?B?eEhlcHFyYVlpaXVaUkIvQndDeWNvV0VsM3dteWt0RStRWTJTMENMT0sxNXZJ?=
 =?utf-8?B?Ui8vV3VYNXMwdFB6RytzdUdiWVZSU0o3clVYTEtJM3V6TlpxRUQvRE9iYXll?=
 =?utf-8?B?aXFzdzV0V3JFazZGZm9jT0RXSFdLcmp2N01RbEx3cUJ6TzVxMVlhdWErZGR1?=
 =?utf-8?B?WUFSVGF3cnNHaUYyR2RxV3pWdGhiSVdYeW12dmNPdVdXT0JoWVZmWUswVk9z?=
 =?utf-8?B?eG04alNBNHY2Tjc2R1E2ekh1Y1hXK05TOUNiUTBqaDNaSUtJdFZoZ1BwT1pB?=
 =?utf-8?B?T1kzOWV2elpya1BCNUJtZWRsQWVmZUp6NmxuZndpazd1UkU2bGhQWW51emNV?=
 =?utf-8?B?SWFpT0tCT2N3aXd5bTNQN0cxYlFGdE5HaFB0QU5McFp6YmdMNldrRUFWSDg5?=
 =?utf-8?B?L1pWcGNORGQ3UzJDZ2JHNmZYeVRQYTFKMU8xdUF3RnQrYVVMc0ptcTR3S1pj?=
 =?utf-8?B?eHdHNU9HeEt3ZnJNVFI3RzdCaDRiWU1xbmVOWTltczhydy8raElZVlhwQW1Z?=
 =?utf-8?B?azdZajhJZW5MajVqczZvZGZuV0dqMXlkSXM0aDVqbmhzUTVnbC9lekd1YSs0?=
 =?utf-8?B?QU9nYjRHVWQxZ29CSncrYnFTTENrK3dYeHNsTGFsbktXdHV3b25QaXN0MTRM?=
 =?utf-8?B?RmdCeTVPQnNRaks5RVFiUWluSzBjUUk5WGxyMzZ0T2FrZ3UzTTJjTVZGbjhh?=
 =?utf-8?B?TVc0cjVLTk5sZWlLWHA3UVNGOE5WMGVLS0JaMU55MkgzWmlWM3pJV3RSMEFP?=
 =?utf-8?B?Yks2MmltVXgyZE1IUk9odGxwV3R3anpYUmZ0Rm4vTU41bTF2QnNmS05zZ1NH?=
 =?utf-8?B?N2hBa2t1dlJPMjY2YjF6M0lUa2NVY0lZQ1p5M2ViY09GWUVZOHJSTHU2Tnh6?=
 =?utf-8?B?RGlzMmk5djFmeG9hZERnZ0o1dzd0c2duZ05CdnJ3djAxTmkvZS81UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac2855d-1451-4658-d959-08dedb22dc31
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 05:53:10.6355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Mxbm52OWYqMLCY8wY/7kX4/ZRzjMRlWXNRNRLMp/q/X2f2gD8ntfECpWe7Xup3e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215
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



On 06-Jul-26 7:08 AM, Yang Wang wrote:
> SMU14 derives the default PPT limit from SocketPowerLimitAc/Dc, but
> MsgLimits.Power may expose a different firmware limit for the same PPT0
> throttler. Using those values independently as fixed min/max bases can
> report an incorrect configurable power range.
> 
> Keep the socket power limit as the default value and as the fallback for
> current-limit queries. Calculate the reported range from both firmware
> values instead, using the lower value as the minimum base and the higher
> value as the maximum base before applying OD percentages.
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 28 +++++++++++--------
>   1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index edc5140f6ab6..b8584a1e6bcc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1622,19 +1622,23 @@ static int smu_v14_0_2_get_power_limit(struct smu_context *smu,
>   		table_context->power_play_table;
>   	PPTable_t *pptable = table_context->driver_pptable;
>   	CustomSkuTable_t *skutable = &pptable->CustomSkuTable;
> -	int16_t od_percent_upper = 0, od_percent_lower = 0;
> +	uint32_t pp_limit = smu->adev->pm.ac_power ?
> +		skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0] :
> +		skutable->SocketPowerLimitDc[PPT_THROTTLER_PPT0];
>   	uint32_t msg_limit = pptable->SkuTable.MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];

May not be related to the current patch. Is there a DC msg limit also 
which needs to be picked for DC case?

Thanks,
Lijo

> -	uint32_t power_limit;
> +	uint32_t min_limit = min_t(uint32_t, pp_limit, msg_limit);
> +	uint32_t max_limit = max_t(uint32_t, pp_limit, msg_limit);
> +	int16_t od_percent_upper = 0, od_percent_lower = 0;
> +	int ret;
>   
> -	if (smu_v14_0_get_current_power_limit(smu, &power_limit))
> -		power_limit = smu->adev->pm.ac_power ?
> -			      skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0] :
> -			      skutable->SocketPowerLimitDc[PPT_THROTTLER_PPT0];
> +	if (current_power_limit) {
> +		ret = smu_v14_0_get_current_power_limit(smu, current_power_limit);
> +		if (ret)
> +			*current_power_limit = pp_limit;
> +	}
>   
> -	if (current_power_limit)
> -		*current_power_limit = power_limit;
>   	if (default_power_limit)
> -		*default_power_limit = power_limit;
> +		*default_power_limit = pp_limit;
>   
>   	if (powerplay_table) {
>   		if (smu->od_enabled &&
> @@ -1648,15 +1652,15 @@ static int smu_v14_0_2_get_power_limit(struct smu_context *smu,
>   	}
>   
>   	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
> -					od_percent_upper, od_percent_lower, power_limit);
> +					od_percent_upper, od_percent_lower, pp_limit);
>   
>   	if (max_power_limit) {
> -		*max_power_limit = msg_limit * (100 + od_percent_upper);
> +		*max_power_limit = max_limit * (100 + od_percent_upper);
>   		*max_power_limit /= 100;
>   	}
>   
>   	if (min_power_limit) {
> -		*min_power_limit = power_limit * (100 + od_percent_lower);
> +		*min_power_limit = min_limit * (100 + od_percent_lower);
>   		*min_power_limit /= 100;
>   	}
>   

