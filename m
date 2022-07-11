Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FBAC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 17:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38012903A9;
	Mon, 11 Jul 2022 17:54:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB55F90285
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 17:54:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZLhQ5+Xap9uPZP86B9qgKD/lOcxTdIb8QMsMhCSzE36oJSE5/+5jJ5lOcgAC4ir/as4fGkfV2nHJfT8S9tcFgWOnkx8tqvykuZ2DqxJqnlYPli0qrSheRnfXu4GheQcqDCG7NKm+gPWfkvWMKSKWD6FHjbPtrO3zD07wzMlRIx++MSPjw4+ID3Q1MOzrmGgpjOoO6Byj0bsBrHTasd1FEWnsS2CshC+r7BMoIwOun1n4hxEkYXQR8nPR5MaBwvytMml1IWNJ9mAA0NUnxEYXwpiswpKqJ7CBBiWV/U4xXIeyrTtQs9ybbXJmp5AcucGLh4QE1Tn0+VdzdxoNKGFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtR7oOlHHbwCc4BJwzs76M2gn+eQbVprosp5TJjf5PQ=;
 b=cH0xfPXgEbvJFijAlbj43QSBgzpiDGZ+jxbvGj0R6CCpgcdzS2M0RBXUJY7/my8lCW510JbcXVgpEifgbPSlI7PDgJ04FHJgUqbPVSzwIoysyvf7EUhs8lg/nPLVl/s6esG63uFA18Jt+k9GW6w5nF5lYphhSi/OL7XuADUJaqvtWE8Ssb31FlIx9vJs9mdLnN43Wd5pi/gYmWwinSpucgjsRDsNE8nYn2hmNldZEDyvTLYB/6G9ygBhPiL/Sy4xfW+1lEGJZnYPVag4vMlx5LH6P8BMERCwRmYliA0EHODpRPQj3t+SQKmy6bDHDA7En28h1Y9cyjG9L3Ju/5q0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtR7oOlHHbwCc4BJwzs76M2gn+eQbVprosp5TJjf5PQ=;
 b=uWvlHTTFORYVoiMUHUPxShYI2RTk23HUQxzADBuzst0EiO9kCNEYssjbA3YuCwt5K1qkNqlEDSGM/dt1ix0Ux+9aLF7sMRnP+DiZ2f/wE7zxuRbmEOviA8Ky255yaxoQSV8unw2PWDxeF2eypr+vhwL6Dt06wy96EyLXK5sLgr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DM6PR12MB3083.namprd12.prod.outlook.com (2603:10b6:5:11d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 17:54:34 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43%7]) with mapi id 15.20.5417.016; Mon, 11 Jul 2022
 17:54:34 +0000
Message-ID: <19959e9e-7362-dc74-a83e-db71522ef407@amd.com>
Date: Mon, 11 Jul 2022 13:54:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/display: fix unnecessary pipe split playing NV12
 1080p MPO video
Content-Language: en-US
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220708185605.1993083-1-aurabindo.pillai@amd.com>
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220708185605.1993083-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::24) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e085527-5994-44e7-86e5-08da636669ce
X-MS-TrafficTypeDiagnostic: DM6PR12MB3083:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tvfCW+mmT1RMCA7uS7pCEBd/XBexYVNfwPZtxvCwJQY01AP6hv31I7QJbQrJXYAcu6vQsTfRluAO/qUIVomoTh3o7JeWaafzstWDM+GVwGjR6tM7wbbgRoR0UnW2AjW7mRrYzAI0wudOJDs16AkQL3cjg5SWXBy/eUmrSQRn2vvczSEnwvwd7mvUYByKTKc0MHpuyZffaf7DcQ6J0dEn2m5tmHYiCKVx6EuNauF2zsZUxDWZFqJDlgMuDP4L6qI8QIdhnmLEmNKpfgH9OxVF7jCuVm9l9PWY8ss2y3FwxfK3IczNLczO4gx9f19aeI/RpGCfmdS09BpRaNLfK26Ymtlft1Qoowwq5ekT/WBqSgqlr7yFH0ItBCUKuw1BnPsbw3p4YRvzlvQcq+BrvXo17hDU7gL8dGiOaR9+zZCEfSPGIgtSNY4zoacSOpL7X6qiM4K1OeAHSDsORsSVH788JcwEJ0fFiBoA5whcN7bIutjtA/74X8n0szkoF7nqREIplj3OCnlX+WAqhfINrHO9qe1WH8P0s/a6fO8T/1tYPqGvVPaEq4cl6fj2egODzSzHuAOp/J6dGPljVR5G207oWLcZ9rxU183rSpjJVGwnLqlp4hOzKmJkclrLhtpwdsejvF6E0uidzirNVvReJl0jyUaizR/i/V80DiWdcY0DzmPx0Cyhb9rvf/HoZ/60fbHr0+62A/u5AaB3rsn7WZf1ipSxyeceplvTWT9Vr7gloaVG53ox8v8hsyZtetT4R70/zCLLkrqzZ0BQ8ucBadYueya+LQhrDdZpOxqjHmjMkN5SsPQKPGL8gk55IdY3oZr3ae2ntck71DV7ixhjg5iN6wFi5ZbKtvQgha06X10//nQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(5660300002)(38100700002)(31686004)(316002)(83380400001)(36756003)(8936002)(6512007)(2906002)(66476007)(31696002)(53546011)(6506007)(4326008)(86362001)(8676002)(6666004)(186003)(66556008)(2616005)(478600001)(6486002)(66946007)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1JMbFRBVTIxYSttZzdYMERWSUdadXc1alplYmpkNElxcTIzSkp4VU94SUlE?=
 =?utf-8?B?REV6WnptWkZJaEJkcFJBbG5WaXpwaFphS3ZCSFB2UDk1UW9PWUtkUWhLL29u?=
 =?utf-8?B?MEcxb3o0UE5Dc2pSb2tBMGIvYUc3UTlzNldKSEdsMVk1dzcyU2hEODFkZ1lL?=
 =?utf-8?B?NEo5ZXo3SVd6eW9zYitmYkJwcDZYYzViemdVTC9tM1pqbTcwVlVSMjd2T2NC?=
 =?utf-8?B?MWJTMGpsdXBHbDh1dk9KV2FNdVprb2hFa256SkJqNE5UV0VZSkZoZnBPOXh3?=
 =?utf-8?B?VGVzUzVnSU4vTVYwYlpRK0M1NFRFZmQxdUR0aWNDR3dSd25pY1lTL05UMU1B?=
 =?utf-8?B?VUwzL2p5WDFFS0Urd1psRDZsdVZ0T3JVTFlrdEZoUThpY0dKWXVRSGZqWjVL?=
 =?utf-8?B?USs5am1heUZmcCtFdmRyZG9NYit1YmdFaUxwcE1PWjZzQUpudzQxbHYxNDFj?=
 =?utf-8?B?cnFSa1ZSYjRQMm9iQlpHZUF3bTZWMkZGT2pSekQzSVRFRUY4WjNNcll3Qmcv?=
 =?utf-8?B?NjRxZ3R0TnRpaEFjanlkYTRFOU5Bb1VZcDBabnVCbW5IR0JYeHp3YlkrK2Zl?=
 =?utf-8?B?Nmk1d2k4SG94T09rRGJqS2MwMlZ5UUNnWnB6d24vVzZHZll0VzBTc250M2Fw?=
 =?utf-8?B?OVpYYTIvcGZXa3lBOUQ4d1dsRTBPTmE2di83YW8rYjBnRUJ5L004RDBBNVZS?=
 =?utf-8?B?a1k2TTVobGZRZnJ3VTl2REdCK2JFM1ZTeGRaVWRmMU0zb0g1YnBuY0V4SC9q?=
 =?utf-8?B?VEpVeEhRRWtybUdQNHVnUDhBckxtM0xMdUFranJIa3JHL0FwVUNjQnpnU2cv?=
 =?utf-8?B?RmhnL3NGL2JJaElEK3I0cHBKdjlqeEJ1bG5oRXVETEIvb2IvRkJyR2JIbWFn?=
 =?utf-8?B?OXVudmI2ellwTnF6NmNjaGlPNjhvbTRac0FWRXhQSS8vRVI1QjNndG5xWkl3?=
 =?utf-8?B?UGxiOXZuNXhZS29IOWlOZmpSUy9BZFNieDdyRVpzZDhMa1BZcEtSVHBkaSts?=
 =?utf-8?B?M2pJWGRFemI1M1hYVkRQZndCT3JQR1cvZHFMbGJvc0pWdlRXTmR6bmFuUWlM?=
 =?utf-8?B?aGZ2MG1tL3UvRTJJb20vVFpyMXd2QXVqUXA0ZVNvaTJXbTZvY05vNEd2N1JP?=
 =?utf-8?B?VHMwaDhUV0pyOWZCRUptU1JIMSs0enpPR1dUeXNiQW9QY3FPZjdzQmZ4T2Rv?=
 =?utf-8?B?dnNuaWZocjhnQjFFaWJBNUhUTGJBczlzSzUvWjhnMnRmeStaamwrODkvek1Y?=
 =?utf-8?B?bmJrbTdrMm5ZNGJlT0ZmNjRZVzI3cE5CZS9BOFdtOW83eVQvaHpGd3R4dFdS?=
 =?utf-8?B?UFRVQmlqOW1ScVF2TGxaL2NjVUFOQ1lsc3E2Sms4NnllY3hPRzhzWk9yQndR?=
 =?utf-8?B?ZHplZ0JwdUw1eEM4QUthSVlEd2IxZnVDaEwyMmZtT3J3MkJ2OGdBaEVCTEVu?=
 =?utf-8?B?QmNodStNYXllOC8rdFpzUkFZcXdWK3lqMzhkcEgzaWF4a2FSR2lUdWlIamI1?=
 =?utf-8?B?cGI4MjhYTzM2VHVHbXBQdGhJT3NJTjI1cHQra0N6SjZUTmlESC9VcTVhOCtC?=
 =?utf-8?B?T2ZsY2JxaGVyUUw2Sm13YldpbFJmNlljQUhXTzVhK3AwOUhjK0xqRXNPWG9V?=
 =?utf-8?B?K0NRL0g0alFXYlBxVUVqTndreGZlRTI5QUxScnhSRmpSNE55YURVWXNxaUlG?=
 =?utf-8?B?TCtPclRxbFlrVHNKK05xbWRMVzlKT1NMa1lSVWx4OTRTVHBnOUVTT0xNWjls?=
 =?utf-8?B?Yk4wL2JjakF5RWtGVEFDVFA2bE5wUHlBdjBPOHdqejdhRVA2aC95R3pOZFFB?=
 =?utf-8?B?amYzdDNTS04vU250dlZpdG5ITU0zc1F3NE9Oem1TTHZrVTFEU3dGeFJ1NUpm?=
 =?utf-8?B?a0lwQlZmU3d5K0hlcGJ2WU1wSGxhYXBJUDUzanpOK0ovZEcxb3ZLYXV4UGlI?=
 =?utf-8?B?ai9EbmJZMmREMUl4RVBPUDVYeHd3ZzdLVWpIZjNxemEyUzdvSFR2WTFBRGZN?=
 =?utf-8?B?bGU1RVVkWk1VWGxxT3FjRnY0R21PTytiMVp4MkhoOXc2U0Z4Ri9Gdnl0Ujhv?=
 =?utf-8?B?alc0OU1wMkVNN0VyejdYdmk2bkhKSUNxaUdKQ1BFbm9Hdmx1UTR1ellxNlp5?=
 =?utf-8?B?Rm5BdWxjaVVwbnNiRno5OEtPeFgwSWRGOFFyZkdSYmd1TmNXQXYzSWxHeWQr?=
 =?utf-8?B?ekE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e085527-5994-44e7-86e5-08da636669ce
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 17:54:34.0553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCQWYDO7+4jWZvTpbbmR+CbAk3u1x6EoBx2nOsWPtKKN/dLbga82vdB0fQUjqhkUNcCpr+tUusht2wFZppBxgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3083
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
Cc: alexdeucher@gmail.com, Harry.Wentland@amd.com,
 Samson Tam <Samson.Tam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 7/8/22 14:56, Aurabindo Pillai wrote:
> From: Samson Tam <Samson.Tam@amd.com>
>
> [Why]
> When playing NV12 1080p MPO video, it is pipe splitting so
> we see two pipes in fullscreen and four pipes in windowed
> mode. Pipe split is happening because we are setting
> MaximumMPCCombine = 1
>
> [How]
> Algorithm for MaximumMPCCombine has extra conditions we do
> not need.  Use DCN31 algorithm instead
>
> Signed-off-by: Samson Tam <Samson.Tam@amd.com>
> ---
>   .../dc/dml/dcn32/display_mode_vba_32.c        | 31 ++-----------------
>   1 file changed, 3 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> index 04b13e765a52..c6c3a9e6731a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> @@ -3733,35 +3733,10 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   			mode_lib->vba.ModeIsSupported = mode_lib->vba.ModeSupport[i][0] == true
>   					|| mode_lib->vba.ModeSupport[i][1] == true;
>   
> -			if ((mode_lib->vba.ModeSupport[i][0] == false && mode_lib->vba.ModeSupport[i][1] == true)
> -				|| MPCCombineMethodAsPossible
> -				|| (MPCCombineMethodAsNeededForPStateChangeAndVoltage
> -				&& mode_lib->vba.DRAMClockChangeRequirementFinal
> -				&& (((mode_lib->vba.DRAMClockChangeSupport[i][1] == dm_dram_clock_change_vactive
> -				|| mode_lib->vba.DRAMClockChangeSupport[i][1] ==
> -						dm_dram_clock_change_vactive_w_mall_full_frame
> -				|| mode_lib->vba.DRAMClockChangeSupport[i][1] ==
> -						dm_dram_clock_change_vactive_w_mall_sub_vp)
> -				&& !(mode_lib->vba.DRAMClockChangeSupport[i][0] == dm_dram_clock_change_vactive
> -				|| mode_lib->vba.DRAMClockChangeSupport[i][0] ==
> -						dm_dram_clock_change_vactive_w_mall_full_frame
> -				|| mode_lib->vba.DRAMClockChangeSupport[i][0] ==
> -						dm_dram_clock_change_vactive_w_mall_sub_vp))
> -				|| ((mode_lib->vba.DRAMClockChangeSupport[i][1] == dm_dram_clock_change_vblank
> -				|| mode_lib->vba.DRAMClockChangeSupport[i][1] ==
> -						dm_dram_clock_change_vblank_w_mall_full_frame
> -				|| mode_lib->vba.DRAMClockChangeSupport[i][1] ==
> -						dm_dram_clock_change_vblank_w_mall_sub_vp)
> -				&& mode_lib->vba.DRAMClockChangeSupport[i][0] == dm_dram_clock_change_unsupported)))
> -				|| (MPCCombineMethodAsNeededForPStateChangeAndVoltage &&
> -				mode_lib->vba.FCLKChangeRequirementFinal
> -				&& ((mode_lib->vba.FCLKChangeSupport[i][1] == dm_fclock_change_vactive
> -				&& mode_lib->vba.FCLKChangeSupport[i][0] != dm_fclock_change_vactive)
> -				|| (mode_lib->vba.FCLKChangeSupport[i][1] == dm_fclock_change_vblank
> -				&& mode_lib->vba.FCLKChangeSupport[i][0] == dm_fclock_change_unsupported)))) {
> -				MaximumMPCCombine = 1;
> -			} else {
> +			if (mode_lib->vba.ModeSupport[i][0] == true) {
>   				MaximumMPCCombine = 0;
> +			} else {
> +				MaximumMPCCombine = 1;
>   			}
>   		}
>   	}

LGTM,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

