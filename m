Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B6ACDB470
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 06:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A653010E035;
	Wed, 24 Jun 2026 06:14:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="exE9CAsq";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EA4510E035
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 06:14:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmJvSuRnkHZ92glzEQGwvp5O+Kr9/V1ZkyUG2C22v3g9VxWjeFBmCXqvR2t8trIXufoEsb2HJQsXd0HWGSYa8sRQZ4jH4Qpu+5tV8o+jrcllNMfwAowGfZCakvV4Uaxf7TKSCBsIs3xgouB86D3Fv4YbcmtaHU51PzoBr8ChjELsYx0iwY7ye+B5BJAfROG9dwyM0N54kzIL0b6+0HrSVBdxo5XTZZt5zs6CSNZgfHJTkiuZm6YagKqKVAJX5NHk+I/KjSs8vuM8d1qAB2B6oPCopc1Mplbn8wqjMFbMGe1N674Kr1wBzYBiH8Duu4dR7gp+0jkPc8Us4CueegM75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcT6aX8nqjbjliL7Wa7xPcDwwjNksvO24CjKCuILgrk=;
 b=QCeapsX/xJZmer8tyaGjLgLu+jdSK0hAwnY3f9umxkGG2lxb4bltCGVizP38lkUh3qQebKkAgk+pbHzFpUuvto61LXpLrEbRldxFMyPu1jr8fgsElSDRz8bhnm8uMBtp7o399dG/ExHlX8p2sfHlvKeR9vHT8qzUdMBiEDvFmu1seS34zztq3c4Vyh0wCKZRzHLn0gd4lRwVyOBjZ44Tm+cb2NT8v0D1ZiejhVDTFGSFcSyc91QwjFQOaI6VyANunPm0HAkoMlvjI+5RYwxzBIGAYo9QvRFmSD7A/f+VMVfn7SHkR2aihN8y0Q/McYcIIPmWkm0k4nSFCip/tyqkVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcT6aX8nqjbjliL7Wa7xPcDwwjNksvO24CjKCuILgrk=;
 b=exE9CAsqjhtzYycN1IIbrpeEVU47B8zYPISJGnDzPjw7zXpjkErIUKbWMpJaqfHxFLb7pw0Jk1AotcMLaUnubBAENVGk+amysmAPP0pigLuays4Txea0MtpcYIvz8/7IhiVjWPL0QnG4nH5rBKwT+SKQAAiTkJcUwqUOAL9302E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 06:14:11 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 06:14:11 +0000
Message-ID: <fb663452-4bfd-4f4f-b019-3b126e773615@amd.com>
Date: Wed, 24 Jun 2026 11:44:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: drop unused smu pptable callbacks
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20260624060653.992690-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260624060653.992690-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0032.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 6692a4f2-dea8-40e7-9b82-08ded1b7cec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: /e7oVjM7LWn8+5QzJZX3e+JFSfsLE13MQyFiR3I15uitLmUGf6FVaJOHhlRBH3NuyTuhmH0MGDduIqDLLkA0r9rqnJNRGCjmFM3Qz16Vc1aLKjeJG8/35dhoiURkoM6IMTg5DPX2K+K+8958wLipgantX7nddZhpmt6ao0xsVWy2BJRJ5CfXfPdLflEsa8wBc5BzuAm1Mt/1iMSTi2MLNUDqn46BEM3bXGO59wEea9lwJDbJQuvba5XL16h40NTocV0C2NWG4PAnokrVltxVvS/t9e7RsG+mN/wZBDNb9MEiX7ncs7dibQg9eY7r6JZa/X/+lo1uw9Dno4Ru9AcLVgQUeSCA5/mIHlNDV9AFy63WFYByx0Boqfm7/A6Ao+UwK+7w/Af8/WQnsb/5QrEYWRNEsUczbe6VhAul5UWdTFprzsR5MoQ4lZR/qT+jpAlCP4Md3oCMrijFCodGrfg1Hd+E0VwxnJumBWVSnpHn03orVjIHDpXXVEIyhmVQ2kw1PU6bjQOD00yNbM5LfDcui93daMjRmDqhYrYlSXy5AgLRHs62v/mK7/kDp60CPMcHhPVAGllSNESoG9m0BnMRi14/WhczwXbGLGENocT6yqHQFdgi2VBkCoVAHDYSFHZ/9AQh+A+6F5S31nQu6H6YrYwmGg+ajt7vvmLsIMk2kBE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUp2dmFhbWVhRC9FN3hqdTlmbklFeENTTWsrSURncVZsT1lsTW8vN2hGOXlR?=
 =?utf-8?B?dXlmS3dVazV1cGk4QUo3OXJvaCt4K0k5bitZWHpxSjQ0MFlJY3kzeUN2ajg1?=
 =?utf-8?B?MWE4TlVCK0pKR1NrVjZMZ0k4dmZTVDZiS1pzNWhURU8ra0t3ZTIvMkd4bVFY?=
 =?utf-8?B?L2xJenhQbFdDdzZTQk44UHp0TFE0Ny9QNCtrbHhxOUFJeTNIMmlTR0ZPcVJa?=
 =?utf-8?B?NkkzOHRPTW51QVoyRmpUYzBKR1NpTGJhWXo2RDVEZERrODhaemVONElobzhr?=
 =?utf-8?B?YUNaaElkbmxONEFZOE1VcWYvS2NLdEp5Q2N3THdhdWg2NGEzeUVnREpHK21T?=
 =?utf-8?B?VktuZFdwMmQ5OS85TzZYUG9vRmJlOXRkcXN1aS9WNzVsL3AySUVFRGx1SjlM?=
 =?utf-8?B?L2svbnVsRXd3eUk4Q0RnQ3FPbXdVYnMzWWp2b09FRTJvZi9YbnVTVE9Ba09n?=
 =?utf-8?B?aU9zdXhyM0xrd05nRVpLdWZ2KzI4dmtlM1V3a3FXMXFvTzMvZHREVlUrMDR2?=
 =?utf-8?B?aURwNmhwM3VJU0FnOG8yQVh4ZlMzMjB1cW9hQVVNZjJzQkQzTktHN0RrVWd5?=
 =?utf-8?B?T2diUVRuMDIvMzBUSmg5dzd0M3pBQmdPQUx0Smk3Nlk3VDR5OStBYXJJbFRJ?=
 =?utf-8?B?SXAxNFpnem12OTRFMm8xanR4MDNwNVZmTXpwQ3JyQnROUXlNeWZSOTcrVjVY?=
 =?utf-8?B?VTJRRWJYelV5UEtOZmttMnN0cFNVZDZuRzJ0YlJMMVZhR0t3dy9VVUhEb1dB?=
 =?utf-8?B?T1lXU1llRUFmSGZpL29QQW5DeDJRNW1Vci9kYzlEa1grZnA2S0czMGlVS0Zr?=
 =?utf-8?B?b2MxeGMyNGR2YUl2K0JZL2pOekJyQTN3TDJzTy8wbnFMYXBvMUMrRkpMdnRu?=
 =?utf-8?B?V1BSVGFnQXZocHJSOExBOGt3MVJoR3UzMXlVYkovOFpQWmpPbUxJdEg2OTlm?=
 =?utf-8?B?L1JKL0JnbG04d2lycmN3cEZaTnpaOGJ1bEVhMGRrVi8wYUhIeVo4Rm5lUlZ1?=
 =?utf-8?B?TWdXWGxRdE96VjBNa011S0U5WlAvKzRQdzZDclZGVlFoZmJRZS84YWE2R1By?=
 =?utf-8?B?ZDdFWjEzNUdhSmp1OW5ZTkpxTDRSeHZYYkVacmp5SjBzRkZxemw3VzVkTmg1?=
 =?utf-8?B?VnR6YnBwUTkxMURnaGNGQlk1OWtvR0M2QVdnK0Uzb21DZWlUckFZb1h4ZkhF?=
 =?utf-8?B?bjA3bTVRd2pYVHZUSWlvKytOL0hHQXorRkRvdWhkRHFzc041NDRDRmV0Rk1U?=
 =?utf-8?B?K1FMMit4cWxqUkYrQ0FaeWMvdnZWV3B1cUxCaTQxTkJ2L0NBVUdKMlZtMkth?=
 =?utf-8?B?RXRFaGNia0pUbmpQa3J6MW1pR083d0JaS20ycHp5UVQwcThBTEZpNnhnNE1Z?=
 =?utf-8?B?RmN5Y2pRVzQwQjFtMzhBVGFLYS9mNVdXRERINGZpeTZ0dzZGOEZRajdTZU9l?=
 =?utf-8?B?SXFoSG5mU0VxYWZpVWNCb242THRzK0trYmJLYlByZEFFaGNzTVFVVEhtZnNH?=
 =?utf-8?B?dFVRbHpBWlkzN01VSXRGTlRoamUyVytxOUFJRlhGVXlwOWxFekswNHB6aUp5?=
 =?utf-8?B?b0hKMkNtVVZTdk1IK1ZFWmtTN2FyblhzZU9rRlFXV3hWMXd5a2YwSXJFR3pI?=
 =?utf-8?B?bmc1THVaYnlLbHd5bEdTdkFrbGlXM3pTT254Q1FqY01VV0FoTmQ2dFhkcDJR?=
 =?utf-8?B?OVVrZ3dqYVhNU2VmWS9ZYm5ZNWpaeXJHcWxqZDhEbU82L3lxVkcydytNQVRJ?=
 =?utf-8?B?UG5EN09XUGt4ZlVWTTdneFg2ZHd4RGo4eWxsbTZhZ3lVV0szdVNOaDRpRGwv?=
 =?utf-8?B?Nkw5bTRQOU12aGNVRmdHdGY0WjM1N3RsbjAyOUREMTJmM1dqZy9FcUUvY1c5?=
 =?utf-8?B?Ym81VXhKS1BuVUh1Z1E5Y2lkVkpqUUFVMzNWWnE3Mmx2UTJ3aDhaUG1IME81?=
 =?utf-8?B?SXFQY0kwUXVpL2dld1h2ZVFZSVYzcmVYcGRNZlk5TTFVUkZPOWZ4YnNuRmNs?=
 =?utf-8?B?ZlFkWkxqNUZxbDEwclZFaXJVdXcySCtDeUJtWWlHZUV4TTduaEdOamRULzd3?=
 =?utf-8?B?SkZydWJGektSbjFUQVFaclc3cVFBemJBVGVMaGNaUHhQVHBsbTFhOEZCdlhl?=
 =?utf-8?B?VDlLK21DckswVTlaUldueWJUcnZFd21DRkNSVUhHSy9BZHVrcWZDY1RZWnEw?=
 =?utf-8?B?YURtVU9tbUJTK0c1alZNRHp2MVBCQmswWlRvaDB2eVVTb3FWRjFQZ2EvaS9w?=
 =?utf-8?B?SG9udVpIU1drWnUrb2hRT1YvK1d4R0hWQVJBQmp6TDZRckNrTFdmRlRhcjg0?=
 =?utf-8?Q?Qyeb4I2nuO769xmaIg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6692a4f2-dea8-40e7-9b82-08ded1b7cec5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 06:14:11.2985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgGRxDGuujGI1WyoBlEPzkLutEJptIcf/2DMXVbWWVRVJLfCFXlYFpEnKjv5PAun
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364
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



On 24-Jun-26 11:36 AM, Yang Wang wrote:
> struct pptable_funcs still carries callback slots that no longer have
> call paths, drop the following unused callback slots:
> 
> - baco_get_state()
> - baco_set_state()
> - set_power_state()
> - get_clock_by_type_with_voltage()
> - set_azalia_d3_pme()
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 29 -------------------
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  |  2 --
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  2 --
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 -
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 -
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  1 -
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  5 ----
>   .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  1 -
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1 -
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  9 ------
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  2 --
>   11 files changed, 54 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index d76e0b005308..38a8249570a9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -849,8 +849,6 @@ struct pptable_funcs {
>   	 */
>   	int (*set_default_dpm_table)(struct smu_context *smu);
>   
> -	int (*set_power_state)(struct smu_context *smu);
> -
>   	/**
>   	 * @populate_umd_state_clk: Populate the UMD power state table with
>   	 *                          defaults.
> @@ -903,16 +901,6 @@ struct pptable_funcs {
>   					      struct
>   					      pp_clock_levels_with_latency
>   					      *clocks);
> -	/**
> -	 * @get_clock_by_type_with_voltage: Get the speed and voltage of a clock
> -	 *                                  domain.
> -	 */
> -	int (*get_clock_by_type_with_voltage)(struct smu_context *smu,
> -					      enum amd_pp_clock_type type,
> -					      struct
> -					      pp_clock_levels_with_voltage
> -					      *clocks);
> -
>   	/**
>   	 * @get_power_profile_mode: Print all power profile modes to
>   	 *                          buffer. Star current mode.
> @@ -1354,11 +1342,6 @@ struct pptable_funcs {
>   	 */
>   	int (*register_irq_handler)(struct smu_context *smu);
>   
> -	/**
> -	 * @set_azalia_d3_pme: Wake the audio decode engine from d3 sleep.
> -	 */
> -	int (*set_azalia_d3_pme)(struct smu_context *smu);
> -
>   	/**
>   	 * @get_max_sustainable_clocks_by_dc: Get a copy of the max sustainable
>   	 *                                    clock speeds table.
> @@ -1375,18 +1358,6 @@ struct pptable_funcs {
>   	 */
>   	int (*get_bamaco_support)(struct smu_context *smu);
>   
> -	/**
> -	 * @baco_get_state: Get the current BACO state.
> -	 *
> -	 * Return: Current BACO state.
> -	 */
> -	enum smu_baco_state (*baco_get_state)(struct smu_context *smu);
> -
> -	/**
> -	 * @baco_set_state: Enter/exit BACO.
> -	 */
> -	int (*baco_set_state)(struct smu_context *smu, enum smu_baco_state state);
> -
>   	/**
>   	 * @baco_enter: Enter BACO.
>   	 */
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> index dd94e8a9e218..c0accee9a9c8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> @@ -199,8 +199,6 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable);
>   
>   int smu_v11_0_register_irq_handler(struct smu_context *smu);
>   
> -int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu);
> -
>   int smu_v11_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
>   		struct pp_smu_nv_clock_table *max_clocks);
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> index 68f4de5f800c..7f21f867d73c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -180,8 +180,6 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable);
>   
>   int smu_v13_0_register_irq_handler(struct smu_context *smu);
>   
> -int smu_v13_0_set_azalia_d3_pme(struct smu_context *smu);
> -
>   int smu_v13_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
>   					       struct pp_smu_nv_clock_table *max_clocks);
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 051a0008aa10..99abfddff856 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1934,7 +1934,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>   	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
>   	.gfx_off_control = smu_v11_0_gfx_off_control,
>   	.register_irq_handler = smu_v11_0_register_irq_handler,
> -	.set_azalia_d3_pme = smu_v11_0_set_azalia_d3_pme,
>   	.get_max_sustainable_clocks_by_dc = smu_v11_0_get_max_sustainable_clocks_by_dc,
>   	.get_bamaco_support = smu_v11_0_get_bamaco_support,
>   	.baco_enter = smu_v11_0_baco_enter,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 2f2a5953dbbc..52c23bd3b201 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -3340,7 +3340,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>   	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
>   	.gfx_off_control = smu_v11_0_gfx_off_control,
>   	.register_irq_handler = smu_v11_0_register_irq_handler,
> -	.set_azalia_d3_pme = smu_v11_0_set_azalia_d3_pme,
>   	.get_max_sustainable_clocks_by_dc = smu_v11_0_get_max_sustainable_clocks_by_dc,
>   	.get_bamaco_support = smu_v11_0_get_bamaco_support,
>   	.baco_enter = navi10_baco_enter,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 70897c70db32..e5370267fda3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3146,7 +3146,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>   	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
>   	.gfx_off_control = smu_v11_0_gfx_off_control,
>   	.register_irq_handler = smu_v11_0_register_irq_handler,
> -	.set_azalia_d3_pme = smu_v11_0_set_azalia_d3_pme,
>   	.get_max_sustainable_clocks_by_dc = smu_v11_0_get_max_sustainable_clocks_by_dc,
>   	.get_bamaco_support = smu_v11_0_get_bamaco_support,
>   	.baco_enter = sienna_cichlid_baco_enter,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index ac8f84f1e30e..f5155a4dc5a2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1417,11 +1417,6 @@ int smu_v11_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
>   	return 0;
>   }
>   
> -int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu)
> -{
> -	return smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
> -}
> -
>   int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu,
>   				      enum smu_baco_seq baco_seq)
>   {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 0349dba2503a..e5d319cda52b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -1444,7 +1444,6 @@ static int renoir_get_enabled_mask(struct smu_context *smu,
>   }
>   
>   static const struct pptable_funcs renoir_ppt_funcs = {
> -	.set_power_state = NULL,
>   	.emit_clk_levels = renoir_emit_clk_levels,
>   	.get_current_power_state = renoir_get_current_power_state,
>   	.dpm_set_vcn_enable = renoir_dpm_set_vcn_enable,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 3a19f0ffcf3c..7c0d4e40b9b6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -2005,7 +2005,6 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
>   	.disable_thermal_alert = smu_v13_0_disable_thermal_alert,
>   	.set_xgmi_pstate = smu_v13_0_set_xgmi_pstate,
>   	.register_irq_handler = smu_v13_0_register_irq_handler,
> -	.set_azalia_d3_pme = smu_v13_0_set_azalia_d3_pme,
>   	.get_max_sustainable_clocks_by_dc = smu_v13_0_get_max_sustainable_clocks_by_dc,
>   	.get_bamaco_support = aldebaran_get_bamaco_support,
>   	.get_dpm_ultimate_freq = aldebaran_get_dpm_ultimate_freq,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index d511f03354a6..67d20213ad07 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1321,15 +1321,6 @@ int smu_v13_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
>   	return 0;
>   }
>   
> -int smu_v13_0_set_azalia_d3_pme(struct smu_context *smu)
> -{
> -	int ret = 0;
> -
> -	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
> -
> -	return ret;
> -}
> -
>   static int smu_v13_0_wait_for_reset_complete(struct smu_context *smu,
>   					     uint64_t event_arg)
>   {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 9c09b2640a0c..edc5140f6ab6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -2891,8 +2891,6 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
>   	.deep_sleep_control = smu_v14_0_deep_sleep_control,
>   	.gfx_ulv_control = smu_v14_0_gfx_ulv_control,
>   	.get_bamaco_support = smu_v14_0_get_bamaco_support,
> -	.baco_get_state = smu_v14_0_baco_get_state,
> -	.baco_set_state = smu_v14_0_baco_set_state,
>   	.baco_enter = smu_v14_0_2_baco_enter,
>   	.baco_exit = smu_v14_0_2_baco_exit,
>   	.mode1_reset_is_support = smu_v14_0_2_is_mode1_reset_supported,

