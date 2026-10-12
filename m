Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDF6CA9EC5
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 04:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7019C10E050;
	Mon, 12 Oct 2026 04:12:17 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 471D410E050
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 04:12:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeEhDwzhmji2Eecb7PvfMPWrmLlGeAYY7LJtDP3QFAKQVecZ42NhaFXLZs7BQM4h+/UFXqfqSxDF61/eN1jaDMayg9sMKDtfpzlVrQvL7rGpd+XgraCILK5AUttDe5z+MWMjOA7KL+Q+Y2I09oYoxMh4jGaNEqm4zy1qR17J4NcM9E1dnFOSVr4DCCImgMvLDIIHhsm86ySb55Kr3iIpKJkTdRgNHonQSSrnlhUjWR9oNpUY4UZQnJrYb5P4wC4ZOb1+R5K9WfjqeXMZs+9LdJoWvoWhezGmCkFFxgoKXn5aY9O2DqjdCe0LVPfQS4e2GVmamoXNznbgFVhwGGoKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lmn1nDEvHK2GHHzChMrbPuL9jw5u3M3thkLiRLZ1wY=;
 b=WMM7XTOM9mudmS8+w+X8ocYCnIlgS5FuPHh4B1dDEVMFz6+5OeKMwji/A38VCbbqapvjH/c8goud6dQ9Fjlxpp3XlNB2TzaHnvc/YsFNYoG6TUX5gtJAsFjnjGg/5JBK0eT7YCywxY8Jau/NsMiLsvPGfoKLeVckZuq++AhmdYM/AnoPH+hfj6HjvOehlM52Fxcn64t85WLTpo2OcA2k4cHHBPRGLzj0QuMoKuMgj9UNjsIJI9fw7WaaKkq0J4CLfGPRJsvrz2GFvI215vZOBJ8VBviTMR0VFg5iTVnN84yIzXOEqiZFS4AdGVm0zdJ1f3YUCa5cJSEoIPOlel2X9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lmn1nDEvHK2GHHzChMrbPuL9jw5u3M3thkLiRLZ1wY=;
 b=wyt9SDf9UFLxI/YRaEuI9iKckZy0yBfswIEJjGpli1kciKb4iD1VaCTYpnQyRYClTfTJYvLg1teVwdeyW70xeT7WB8EeGtH0HnWTZNXnyvKdjlcZLS+m4gUFe8NS1bztbbyhCVxxowupMmW16BZANYfabUfChw7cn4okbU+dPt8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 12 Oct
 2026 04:12:07 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0472.015; Mon, 12 Oct 2026
 04:12:07 +0000
Message-ID: <142bb98f-2b90-44ac-9e69-8700b4130e5c@amd.com>
Date: Mon, 12 Oct 2026 09:41:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: mark the current DPM clock level active
To: Kevin Wang <kevin.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20261012012748.3150968-1-kevin.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261012012748.3150968-1-kevin.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0237.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5dcd8a-d0b1-48d2-e9e2-08df2816fa6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|6133799003|10067099003|11063799006|261009223027099003;
X-Microsoft-Antispam-Message-Info: fG/0+UnnVTZsIuGWX0DMYqNzUR5++u1z68Lx4NKfMyD/elIbGUBSxb0GJblMPplWtD761c43fw517YDXw0iSxWQnxmUFObjDs5WmOCdM6zmuD9BiK9WQOnzsusKmVcRMYSwQgO216cQ/tpfn5DeuKXmJZR99R12mGaV+L9FOKxzseQnwuALFGa+OZXoGjFSlFIcR2x+HxyaUssdSIbBgtynq6jkR9m+k4M2M1QKY14OzmMuusx0CymTbpd1HdUj7McJEumjF/6EVxACFEt57W5cBFPJ55k4QyTXr1L7UPQZIQoU671Zda3/AzViiqdpyLOt+B0wRky6VapgPC1np76IP2lTaJ3wDJHXsK8hgdB3aW/pBFV/EHa5JNlEH/aEmxrLyypBQFrPd82bGzPoMOxXVyqgL7pnswKJgl6Qv64yn8ydDNdD94sScyHyrpMHfWFTBDXWY0hT+KbzSuNUDc4TQJizOuNB7xmE3bPJnzAKcxEos4fcFI17sQWJ9MUVJwIn1Qco1+KZd+db/HSjekDLmu7KK2MVZ2sAFhj6W/dY6QVi4f0W9hBYBd+fNtEalLF0qqE7R8UrRxZWwx+Vvh0UlUyA2EjSRpbab5j+MpaNp/TF9AGH9LJdMjNLWwTyIdCpkpR4EbZHXSVi6dTg7Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(11063799006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEJqLzVEQnRJZTk3RjRjeERtQUIwSzNaZFJOYVdEeDBydDV3WXRVQXBib3Va?=
 =?utf-8?B?S3hWTURaa3YrYXhKellleHFNZDFyQ251OGQrV3I3VVBIZWU3NnBEaVFTUFFo?=
 =?utf-8?B?YTZJVWtJZjlkS0Y2RGhMemp6UEFTT1Q2SG9jbU80VUVPSWJFOEJjMVQrOUYw?=
 =?utf-8?B?THMvOFNQYjNQQ1lETkpDaXVSaHNjbjFEOWF0eDdEWU5nbWdFVFBnWkd2RG1S?=
 =?utf-8?B?UUkrbThKTm1uQzdiNGVaYnp4ZEcxSTJxakJaejdBemRYd3hYYWtkS3BITXlV?=
 =?utf-8?B?L3p2Mm9tbVEvM0RUakwwMXpTcmpxM2RSUGRudmFmMUE4VFlpK0dQSFFPTWpl?=
 =?utf-8?B?bStrcXlNN0RoU2pMV0MwamhkbktBYTlMZlJXT2FpTHdmMU4vemdNTExmdjBx?=
 =?utf-8?B?bXlIWmRpc3EyRkRNUFBnNEtsTGJBVnRyMWp4L0krOGxFS3o2aGVEZFJ4RHFG?=
 =?utf-8?B?TzZYbnpJR1JGelExbWU4UHg1QnFmUkk0Q1N6d1p2M0FKSlJZVnBQcW9VSWI2?=
 =?utf-8?B?N29VbmFKaVhjek8zUUxTRmtRbjNVQlhBUTZFcjZsK0Z3dE51RjdYdCtucDVN?=
 =?utf-8?B?YkZsRVppRmNjQ3dGN0tqNHY5UjNURmdJYUZsR21pS1IrdkdsRVJNaXNxdTU0?=
 =?utf-8?B?REFlcVh6TnJDMVIyeTNZcXR2Mkt5cXMvdXZldElJMW5CdEFnQVFubWl6dTVT?=
 =?utf-8?B?eGJwNnB3MkovUzB4U3JyTXU5dFR5M2I2QzFDb0ZZMHVGTWpXdkFkeHFNQlor?=
 =?utf-8?B?Zzg4b1p4R3F6MDRLSHNGaGtCdm00Y3h4UFlkellpYnN0V3BsdW1NbTcrbTEv?=
 =?utf-8?B?YnJnTU55cm5ybnc4M3czVitJMXdyTUxFSTB1bnhUMTZmam5hRmJ0Y243T2tJ?=
 =?utf-8?B?Qjg0QmJrRlU3c3ArM2RPUDZFRGxpV2ZyVXVreHhNSFprRmRuQTBXTDE0Yks1?=
 =?utf-8?B?ZnZ2bnpMUDhKM2NuSFVEOXVGYjZzakVHVGtPY2FHd3NjQTMwQUNqdTkrYjBT?=
 =?utf-8?B?U2tkUVoyclZiQU0rajd3SFVvWHlxUUduZlZDemJ3MDZsNnBSbjdKL0pYOHVL?=
 =?utf-8?B?eFdPeTZFM25TVy84NXBFeUp0WHRsOXNmaVoyOGpZL1JHMG8xNzFDbFRZeVFB?=
 =?utf-8?B?WmNmMk13Z2JveFB3b3RjZi84bFFGL1k2QWVFNXBCbVJLNFBVY29FSFIyM21s?=
 =?utf-8?B?QzUwL1MyQmtSSXRQNllDRzNoSlNhYzh1NE14c09xVWRMdGJmNE1DVHRiVTZE?=
 =?utf-8?B?QW1ORG12SHRjYUcyMnp0N1gxMTM2U0MzNzlZbzBESWRTcERQeHBhbldnMVdO?=
 =?utf-8?B?OTlUQnhPWG55L2QwZWZzVm04Wk8xNzU0RWYxeXlHMlpEbW81Qkt0b3ZXblRr?=
 =?utf-8?B?aHBiaVNhMDZreFNlZHBCYWxMVTdFdFJhZ3g4clM1dU11RWFCN2IwcVVGK1ZT?=
 =?utf-8?B?aU9aZ0o4dlczVWxhdFFqVDhadEZlQ3hhdnZSeWpON3NXbVR6NVJDSFhQMDFB?=
 =?utf-8?B?OFQvRTR3bXd0RndJaHlMc2lIa2Z2ZWdldVhuYld3MzIwaFpoNEZrVDg4RzJ5?=
 =?utf-8?B?eDcwa0s1ZjJUajEyRzB4b2wrbUNyRnBFQXlKY0RqeENlOXpodUU0T2R0eEUz?=
 =?utf-8?B?M01PSVl0QkNKbkFvZUtleU5tZnNXdlZDbWh2aWMvelRudHI4a3R0VE43ZHBR?=
 =?utf-8?B?QzZSS2o3cW1vQXRKZG9XQ3pNamJIM0FvZUdVaTRNT3NkcGtucDhoSFdJRTJ4?=
 =?utf-8?B?WDZTV1k5ZEpRVnFuTnNDUm5MWXkyOWI5T0w1dWc5S3pkZXFlOTlBc0ZLVnNB?=
 =?utf-8?B?TC9PSkUzSUJlaG9MTDVwWXJtUnEyK2VQa2NHMEdVQk9Qdm1zVU56MmoxQnJ4?=
 =?utf-8?B?U2taTHhRYzRvZGV4RDgxc3hwZmVLb3pLOFRmQmJTN2hVWWhnNG9DVGJnaXhR?=
 =?utf-8?B?Zk5CdkJsMWphOUlpTG5GVS9ZNk9SamxaN2FyUkdVMnU1S3UwRWdMb2sySFc1?=
 =?utf-8?B?ekFuQjlkT0FyTXJGT3dDVlVXNnhmMmE4VTF3dnNkdEhXRnRWMUs3cDM0Z1VH?=
 =?utf-8?B?RWIxZmhTWWFVcXRhZ3MrWk5KQnYyL3NUaXZuVFY1T3Q2RE5iT0FGZEpIT2c2?=
 =?utf-8?B?dWlKVnM0Y3BsbnpBR0luUkI2MS9iSUdxdUdVeWdpNXA0cEF6dW9HOTFqUTdO?=
 =?utf-8?B?OWc2WUZxOUNtWTVGZmh2R3o1NFVIcXk2SEo2d3ArNTFxNmRydlZLQmErR091?=
 =?utf-8?B?UUZVWC9ocDlJSW4vWnNOT1RJalcwdmo1dGpzMmM1L3Rrdi9EdXlXdDdBc1p2?=
 =?utf-8?Q?THaXJBDejZLZDD5sx7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5dcd8a-d0b1-48d2-e9e2-08df2816fa6d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 04:12:06.9058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0VXGFiJhY3octvynEoZbXayLoY6+jE47U0TqyuDQBR1xLczbFP2h6JBM2V3oGfm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
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



On 12-Oct-26 6:57 AM, Kevin Wang wrote:
> PMFW can report clocks outside or between advertised DPM levels.
> 
> Report a clock below DPM0 as a special active S level.
> Mark the nearest level active for a discrete DPM table.
> Clamp a clock above the table range to the maximum DPM level.
> Keep reporting the actual clock for a fine-grained DPM table.
> 
> Signed-off-by: Kevin Wang <kevin.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 35 ++++++++++++++++++++------
>   1 file changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 361657c19ea3..8cf616517ddd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -1391,11 +1391,12 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
>   				 uint32_t cur_clk, char *buf, int *offset)
>   {
>   	uint32_t min_clk, max_clk, level_index, count;
> +	uint32_t nearest_level = 0, nearest_diff = U32_MAX;
>   	uint32_t freq_values[3];
> +	uint32_t clk_diff, level_clk;
>   	int size, lvl, i;
>   	bool is_fine_grained;
>   	bool is_deep_sleep;
> -	bool freq_match;
>   
>   	if (!dpm_table || !buf)
>   		return -EINVAL;
> @@ -1407,23 +1408,41 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
>   	min_clk = SMU_DPM_TABLE_MIN(dpm_table);
>   	max_clk = SMU_DPM_TABLE_MAX(dpm_table);
>   
> -	/* Deep sleep - current clock < min_clock/2, TBD: cur_clk = 0 as GFXOFF */
> -	is_deep_sleep = cur_clk < min_clk / 2;
> +	/* A clock below DPM0 is reported as a special deep-sleep level. */
> +	is_deep_sleep = cur_clk < min_clk;
>   	if (is_deep_sleep) {
>   		size += sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk);
>   		level_index = 1;
>   	}
>   
> +	/*
> +	 * Discrete tables mark the level nearest to the current clock.  Clamp
> +	 * clocks above the advertised range to the last level.  Fine-grained
> +	 * tables keep reporting the actual current clock between min and max.
> +	 */
>   	if (!is_fine_grained || count == 1) {
> +		if (!is_deep_sleep) {
> +			if (cur_clk >= max_clk) {
> +				nearest_level = count - 1;
> +			} else {
> +				for (i = 0; i < count; i++) {
> +					level_clk = dpm_table->dpm_levels[i].value;
> +					clk_diff = cur_clk > level_clk ?
> +						   cur_clk - level_clk : level_clk - cur_clk;
> +					if (clk_diff < nearest_diff) {
> +						nearest_diff = clk_diff;
> +						nearest_level = i;
> +					}
> +				}
> +			}
> +		}
> +
>   		for (i = 0; i < count; i++) {
> -			freq_match = !is_deep_sleep &&
> -				     smu_cmn_freqs_match(
> -					     cur_clk,
> -					     dpm_table->dpm_levels[i].value);

By this change, if this function is no longer used, it can be removed as 
well.

Thanks,
Lijo

>   			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
>   					      level_index + i,
>   					      dpm_table->dpm_levels[i].value,
> -					      freq_match ? "*" : "");
> +					      (!is_deep_sleep &&
> +					       i == nearest_level) ? "*" : "");
>   		}
>   	} else {
>   		count = 2;

