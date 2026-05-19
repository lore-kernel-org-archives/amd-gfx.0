Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC11CD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 12:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F8A10ECC2;
	Tue, 19 May 2026 12:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R/OQAbdd";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCE9210ECBF
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 12:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJLfBnh17CcRH50djs5PUlYN01pRwcyHfKkwPJZzIVM9i1j+amTMkcxrYfLN94e4cuZiVnKy95Ey9pis7ifbP9dJfaFxYcjhZxi8ZY1jxgQfZe8zFHpO/dKyde6bOm1VoYHxj9TtSuUapzVMLyU97GqOXeV2cydhZiOOj7liC4VKvTJiq81OheHwmHs0qZRjpe4P3UJT5h0QLD5E4+fPZuAk0noDCFo9sfq7WKvmtLZIsKgpqbX5ct8JqyWhBfJQXd+3mKHOPqOSLj/v1EOMluRYI2X8YXCuhlwpswK0GH5QrAkVPajLPNQ9lZRF0L1OhMp2EMp/Icx2mfQ2XtOsiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTxZL3aZxjnkbmJyID1lD4/oUFjyJc3TSmakmN4V5zo=;
 b=XYQFBlejMhGWVK6oiyby+/BLydhY0kAR3Oy6dvUzPl8eNkKR5Lihlo49k3zj5c6Xx20b/tz6ahsqAQ6N/MG5a3MGkIWUOGq4vsXIjspdbCv826Urcrf7+cuTnC0NynYw+sah7Rf5GEt4+lYbVUSiF5ViPNtNT/hYE+rHlzvqoTtx9STXsUUUpQCCCT84RdtKFvaZ1EG66a096ykkDU/THQBClTRv4BpWafmVPcuhd1EAwSDDYxqujeiuUfHBKvpvoHrKFS/R0uWILoBP+mX+OY7aTtFsM420o5c/AhWGKgclEVn2dvIBS/rjKvOG492JSAkAcHwLfKd1P8Q4mg2agQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTxZL3aZxjnkbmJyID1lD4/oUFjyJc3TSmakmN4V5zo=;
 b=R/OQAbddSuKR3qTmpniGK5bL1IAmnujaISlMrSM4N5anQKnBnXD2JaTy23NAy1AeTleBJCjw+uhOYvyPzwwqODNTM+Zn40kHSg0GQwBZDtXndMNNsWMmtCb6gPaSXaVOa8HjDHWaTo+JSFiHaMbwjTUyuLPwflqRa+leqDKEubs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6379.namprd12.prod.outlook.com (2603:10b6:208:3b2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 12:57:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 12:57:56 +0000
Message-ID: <31fcec2b-cefb-412e-841a-ff98e0479a20@amd.com>
Date: Tue, 19 May 2026 14:57:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] drm/amd: Delete defunct DAL power level code
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20260519102118.246466-1-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260519102118.246466-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a7d114-6aa8-4b15-b9da-08deb5a63f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799006|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: HpBtzAPj5S6y/gPed/0iWonojQk/GxpytBb67t2ztIt/+wtO6MwJ47b1BlH9RacrT53ZIiS/D//cgXnxKIjrBksAn41pZeBLjoJ6z/JlKXL+hMzlEB1K0JKWieQQnBW9sCqiKkG5LmZvJzMCCRryDlfVmatPmXKLAg2eZyMgnTx6iPszyXp/sKA2396Cum+PnDb1ayyfg3MxAvo1vlgZ7JjUEyuuKjKLd/TflLKonfW2LzHZpjsMhfpX2SUKKwqwfYiz3zJs6oUOjIr2DSm3hzhSHEHjvoSp9pJds16IDZpmwcPxBBU6fQcUqBhsmXXKsDX78BRGKLZxJan5PkkT0nmDFcLylnJrcLB20Vn5Feb2xCqev2VqkfYA7lkHTmV++JyyYd7qftAOz/0wUq8AjCdkv/Tv2KEwZ+Ac3I3M5P5dCrrOvPaVkfSzbWNJSYDRxpO+KgjpL6JyLLa+cxMUbdbXE5gTaXEka9Ol0ZCeP3eJz2Vc2RB1cCqgw+vyQVYXB/Jjtqy/wJLwITbHuoKRj9y6JBTjdYPR0WTMWQFhAjFyELAgoljYMQfS/Su46n0ur3RUUzfbMOu10cQgSvgzUw+a1loJlesAQ9MwKkVEwR6mePn9IClBZtGX9/WKFza3y+9+037aM3eKGz7zEH7LCiIXfvVlRhz767uVQ6lGW5gY3YKR+si1hVupuvYFGYbh7hxTcuR8DKyYQa/q0ALdBkHlMnHyCY+ftNzcljgEcXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlVaYUtyWWpGTTByMmdLdkNtWmdkcG1PeGZueGY3L2xpbEtTaFN0S200M2Ix?=
 =?utf-8?B?aU1HSXdCSmdPY3hrUGhWQXNHeUE2QnM4SmxHaCtaK0FvRmlaMGZUKy85WitU?=
 =?utf-8?B?eE5COTlNQ3ByMGZIcWlYYncrQkNiYmgvMUpMcUxWV1YxNjd0UkpvYmxyMUlF?=
 =?utf-8?B?elplRm9kN3RNekdHSFZjWDVpMzgzdHloT2xoemhtNmg1Ukc0S1dIMzJCOUhH?=
 =?utf-8?B?Y25DcVQvMlVIQ1EwMlMxWnMvSHpaaHhHdnBUa004emsrTzN0Z0lqY3lRWGZx?=
 =?utf-8?B?SDduMXpjNVJ3QUR4Q3BZRStxOFl4eFVUOEUybWxacHh4UFBVT09CN2RHK1Q2?=
 =?utf-8?B?SS83Z3ZsTUg1SHJUZWhYWUNMVzNqRDhWQkZ4MWs3TXJoS0hhSEsvTlpta01z?=
 =?utf-8?B?YmY5M1RZTWNJRmhSMzlnRkhsK1BiNWYxRTF1Mm1OdGw4b3hscENQOVJiY3Ex?=
 =?utf-8?B?UHl1R0ZvanRGWlNrSkZLRm80N0VMcFM3ZHdKMGRXVTRTUis0U3cvaTFLc2d6?=
 =?utf-8?B?QVoxbzBMeTNVSEx2WnUwcjR3c1I0TDRaa2paUllmQW1IRi9CZ2tIOVlXVFc2?=
 =?utf-8?B?Mk9nSFVvVEVpUGV1L21Za2FnSkYxSXB2cUgzMFVLeURNbHBRaVlkMGE5dTZN?=
 =?utf-8?B?NTJZU2U4TTRQWXlkUU84eFMwRXdnMWpVWHYxY1NpVkw2OG4yYUhvb3NyUW1L?=
 =?utf-8?B?OG9WZXp1Zlk2ZVFnUWVQOWZDZVhINlh1YlEwRTVtV2thMmQyTTB3M3hoVHJC?=
 =?utf-8?B?V3hTbThtdG5pL2d6dmVYYTdvSUpaRzBWVG1PcVBva1J3QXQwMUQ3clZxNktW?=
 =?utf-8?B?RmxNS2RqdExCMlNtdzAvSzJmSW9uc1dRR3RsaktOcmhHbkpheEt1Vngydjhq?=
 =?utf-8?B?NjlybGNkMXBsTGozMm1tYjdacCsyMDkwb3BHR1Q0Y2tGVTVadGV3T3FaYlNJ?=
 =?utf-8?B?MTVYOXlrT1gyT0ZuTFF5UVdqekNYTlRpcUxJaHJjTW5lWGJCQTdsajlLTHR1?=
 =?utf-8?B?QzloNVpSTWh3ZUlTalZPOUQ0VUI4SVoyd2w0aVFXZTYzUGl1UTNoWWF1ZFhS?=
 =?utf-8?B?a0RSMUx6d3A3c1FIelQzN1hOQmxudjI1WFNBVjlKajJwNGpjUnI5aGpuS2Qx?=
 =?utf-8?B?YlNTTllTdWhteU1XbHJpLzdHbWNQMEd0dWFPNHpjMzNvKzl3YnlFeWxDUXBC?=
 =?utf-8?B?cGlWVjQzbmIra1hsWit6NFhsTmJNdmlXcW5Yc2kxVjJxaEpVWmZOcWdjMWc1?=
 =?utf-8?B?RkVLZUY5S1dWWEFWWnJnZ1VvWEJPcjQ3Y1luSjZrbkVjTUtvMUZrMGl2blBh?=
 =?utf-8?B?M0toN1E2MGs0MHkra1gyM01xbFVhTTlvRHRXWGcxbjl0RDBnVE1CS2RmSlhR?=
 =?utf-8?B?eDVFTHlIejF2NnIyVElCOEMwOHBScklFLytSODhPMjVzb01qekFnWVUyZmRW?=
 =?utf-8?B?NjVBWGczcyt0SCtXd0E4VkVVZzB3aDZqa3BWS3A3SkFHZUZ0TWNaQ3BRQW1a?=
 =?utf-8?B?dkZyWDNEZ3NjSS9LWTNCbHNYakg0QmU3OEQyOGtOWURDenFGNWNpSEg0ekhV?=
 =?utf-8?B?bWFZQVgzb3VYVlc1WEsxRVA5T3V5NVBnTzRLYlJPcFBOYjZzaWJHcG1meXFn?=
 =?utf-8?B?T3dSRFpYZmc2bUp1Z01DdHI3RzVwRTcvc3EvT3hLNndaeTY2amF5cmM0Q3JW?=
 =?utf-8?B?Yzk4Tm9JY2tlaVJpYWxVM0R5Nk9CcG82dWpDTkIwZWZJb0xTdk1tcW82UjIx?=
 =?utf-8?B?dTlVNHgyL2pWN3ZTM3lpNkU4UkxDN1JWdmd0TEpVMGh4bEF3cFVZbUx1Ump2?=
 =?utf-8?B?emVmdFdGWFFvVlBzeGJZTmxiZmJJeFlVVnVFcll1TGR0cVlWNXVPRmIrdVd2?=
 =?utf-8?B?eXh0RW45dC9FdDZjVytWS3JRWm93MGs5TS94VTFtbzBhYXpZRU42WitHVlNR?=
 =?utf-8?B?Y0ZQZFpHNGRpcUlaZGFlN1lwVnFJdFZ3Yi9TYjRZSGt2bFd3ekFsdGlPUGZO?=
 =?utf-8?B?bHVMVUxmNExPdmpsMFczcjBNS25QbnQxZFJ6WERkT2NQSWJ2OCsvaU5SKzFi?=
 =?utf-8?B?eXlYVEhMLzhNUzVZQ1FLTXhzcXMweS9uU0RiRmFqQnpoZFQ2MEpYSzNnaE9p?=
 =?utf-8?B?RTQ0c1pwb3ZDYzBhbTkrTTdaMDRZbC9GSURUVFZkYmpzNkVOU2R5dHlSbHJK?=
 =?utf-8?B?amFrdDk1MGxrV2EzZGsrSDhjMjlERTNpK0lKcWRGSkUzdGZseXpFTVh5bTJt?=
 =?utf-8?B?bHVyaWsrTXJjSGlFdDhhaTVhWmtaQW40ek82Wkh4ZjBKSW9sMk44blZSSVBM?=
 =?utf-8?Q?uW3de8LzvTFiFEN4LQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a7d114-6aa8-4b15-b9da-08deb5a63f19
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 12:57:56.3574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcNbfUWIiQJbFf011qs/QXVIernmuiyXmvY1ZRM8ePZOEQi0M83TmZgsEtL16PZa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6379
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

On 5/19/26 12:21, Timur Kristóf wrote:
> Delete unused code related to DAL power levels.
> It seems that the DAL power level concept has been
> never fully implemented and was thus non-functional
> in amdgpu.
> 
> DCE 11.0 and 11.2 never actually relied on the
> power level because they calculate all necessary
> power requirements in dce_calcs and communicate
> that using dm_pp_apply_display_requirements() to
> the power management code.
> 
> DCE 6, 8 and 10 also didn't rely on power levels
> because they always just set the maximum possible
> display clock and the power management code
> already takes that into account when setting the
> power state. This was somewhat improved recently
> by also using dm_pp_apply_display_requirements()
> on these DCE versions.
> 
> The code base for newer GPUs doesn't use the
> concept of power levels anymore either, so
> this change reduces the maintenance burden
> of the old DCE code.
> 
> On the DC side:
> 
> dm_pp_apply_power_level_change_request() was never
> implemented in amdgpu_dm, and DC has been working
> fine for years without it. Let's delete the dummy
> function and the code that calls it.
> 
> With that, we can also delete the power levels
> and the static arrays containing hardcoded power
> level values. These were never used for anything,
> only for finding the maximum supported display clock.
> 
> On the AMDGPU PM side:
> 
> The get_dal_power_level() implementations were
> dummy on SMU10, Vega10, Vega12 and Vega20 meaning
> that they didn't return an actual DAL power level,
> and were non-functional on SMU8 which always
> returned the highest possible power level.
> Nothing actually relied on the power level
> returned by these functions. Let's delete them.
> 
> What's next:
> 
> After this code cleanup lands, I have plans to
> further improve display power management on old DCE.
> 
> Changes in v2:
> 
> Applied review suggestions.

Acked-by: Christian König <christian.koenig@amd.com> to the full series.

Thanks a lot for taking care of that.

Regards,
Christian.

> 
> Timur Kristóf (14):
>   drm/amd/display: Delete unimplemented
>     dm_pp_apply_power_level_change_request() (v2)
>   drm/amd/display: Delete dce_get_required_clocks_state()
>   drm/amd/display: Remove min/max clock levels from clk_mgr (v2)
>   drm/amd/display: Delete max_clocks_state
>   drm/amd/display: Set max supported display clock without
>     max_clks_by_state (v2)
>   drm/amd/display: Delete max_clks_by_state from DCE clock manager (v2)
>   drm/amd/display: Delete disp_clk_voltage from integrated info (v2)
>   drm/amd/display: Delete dm_pp_clocks_state
>   drm/amd/pm: Delete unused get_display_power_level() function
>   drm/amd/pm: Delete dummy get_dal_power_level implementations
>   drm/amd/pm: Delete non-functional SMU8 get_dal_power_level
>     implementation
>   drm/amd/pm: Delete vddc_dep_on_dal_pwrl
>   drm/amd/pm: Delete get_dal_power_level
>   drm/amd/pm: Delete PP_DAL_POWERLEVEL
> 
>  .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  55 -------
>  .../gpu/drm/amd/display/dc/bios/bios_parser.c |  36 -----
>  .../drm/amd/display/dc/bios/bios_parser2.c    |  18 ---
>  .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 144 ++----------------
>  .../display/dc/clk_mgr/dce100/dce_clk_mgr.h   |   3 -
>  .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |  25 ---
>  .../dc/clk_mgr/dce112/dce112_clk_mgr.c        |  41 -----
>  .../dc/clk_mgr/dce120/dce120_clk_mgr.c        |  16 --
>  drivers/gpu/drm/amd/display/dc/dm_services.h  |   8 -
>  .../drm/amd/display/dc/dm_services_types.h    |  30 ----
>  .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  10 --
>  .../display/include/grph_object_ctrl_defs.h   |   9 --
>  drivers/gpu/drm/amd/include/dm_pp_interface.h |  19 ---
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |   2 -
>  .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  22 ---
>  .../amd/pm/powerplay/hwmgr/hardwaremanager.c  |  10 --
>  .../amd/pm/powerplay/hwmgr/processpptables.c  |   1 -
>  .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |  48 ------
>  .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |  64 --------
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c |  18 ---
>  .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c |  16 --
>  .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |  17 ---
>  .../amd/pm/powerplay/inc/hardwaremanager.h    |   3 -
>  drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |   4 -
>  24 files changed, 11 insertions(+), 608 deletions(-)
> 

