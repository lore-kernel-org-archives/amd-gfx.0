Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFF7C32792
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 19:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D87E11BC0A;
	Mon, 22 Aug 2022 19:50:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CAF79FE8C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 19:49:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPT7vEDiJmeZOUAikCNCN1Jm+cCVzRcby/1rc1t/4C5ywwFUY5TQ8jvjHis5drTVNkvANGF5Ch356Qfx8Lo1vOUmhbNX//YDFiGhryzVvSJnw01ue4klgtyPzwBAB2DaqjopKoV5kN0loODK5R37+4KBHwiEP55FYC7iWPK99JO/dFHogiWASOe4R9BboafSsnKFcRJzADCfSHUrooEHPytkqOXiYgc4+1MzgwWaE5XbXK2gH2YmjomioR6TUhFsVtdj+MerhD7yObqd6P3ES9dZgLiCV7ay+EKX2G99UErbyaNi6/+jF0dqmhOvpVdFBfaWkmQ4np8YulpKXw/WUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdpH6jWSHhtTveizVQy6yHd67jBrlKdBkmp6o2d4qew=;
 b=I7VBvTmVEOdG70ndxIDAjn8AjjWIjo3O9PwwMEnC5JAVSjsXxaWvP80B8OZ8flZaIUdgQyrm9kyDh6vjQ8Bpx6mCQXq8P+lSvOwEe23+bJe3QLGUKHRbihiSYoR3DQpJIXZJKtP439rEBCSJ3bx9/KjblfDB0oMR4XlmU4didEO13y0K15uH0+QGy38mYAByPh+XTPL2huYQcjy/xJTr8qunVZo3JqSszjQkL+l/XtI8hwgJSq6Es8rc+ONsVxL0NMizREDsr1p9x9AZCvMobENabeaFtL/UuApML+X1M9Ybqw0QLAJ4ucdkWsyZ2cMhthU+QHwHTs1dsbKlUT7Tnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdpH6jWSHhtTveizVQy6yHd67jBrlKdBkmp6o2d4qew=;
 b=ebg3Aht6cj6yXxzMkda1HjMoggz/B+DWQdqtTQrYiZH3NuOtZrzTRGafS+eG5u93W60gzV37V8BVshRrK0d9Fa1bCNa+f1ykHkSM0HKDsRFFZ9VLJJOf5Qpv/unE+5DQGvqLDmLwEVBzlvps7R9p6QzW6+qFOd02Ew900yVhSt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 19:49:47 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::b44e:8a66:63eb:e8ee]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::b44e:8a66:63eb:e8ee%8]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 19:49:47 +0000
Message-ID: <cda644a2-b62b-d50f-4d4a-341e36c93fa7@amd.com>
Date: Mon, 22 Aug 2022 15:49:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] drm/amd/display: enable PCON support for dcn314
Content-Language: en-US
To: Roman.Li@amd.com, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, harry.wentland@amd.com
References: <20220822193816.22943-1-Roman.Li@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20220822193816.22943-1-Roman.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0271.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::6) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c2f7825-1dc9-43b3-49af-08da847777ba
X-MS-TrafficTypeDiagnostic: IA1PR12MB6090:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3cL4hb3oPIsSsGg/2aAl/HpPZpYLXuPdh0wXP1L/7LVNhKEncBd6YrfYluKpF4tedNhfRN20lhGJunP3hblTf83ZG1Q/2ZpeYabQ5Y6OA2mA3J94I42gsO91XoE3r2tWs28ewF7snn6MpmI+gL2seEYvk5Xp1CiR1R5lYQ+38XtTSEkNP0LXAA7l9+dIC/6Pdx4wlCChCD2WJwoERfR71FVjOknJITyOauWC9HxMibcG948vnN0SPvnG3niXBmZXyQA+fhU9yLMwfjqVRBxKnSdupw4PdtFTSkFXX+2gSF8ojH/FW6ibjTCBLsRJ9EpM/LgXSfJ8OIaPWDV5IV/ZbDq14b41MJrju7chQdY9ixUrAmfwMpH40836edopjZI/hiAcOt6xSYGa7lO7QAdD6ytRIBM0LGhL9T80tkO8iJCgn2TuGccJaGFKflLxSU+FnAIjrHpwdI0HInGyVfh0GDWLCcPNiJaWTEFiY4gXjlLpT1D5jRCdSTELPfcVubigB/0VTffNDjBx3MeJm3hOP8OetpgyEKgkor4LFPdoBE9Eop7JZK73CGAMx7TMyNsrFcIi3kHz5LaOshwM/7wMV5Y64+Akdo4z2ygvL3hAcswbabhgihm8MCUvF9l8iiQjUnk+gs3fm6eSPZzjEqYWZMNbpzWrP1wjtw5H8FOs9vjgNlpZJuP1mOd2M3Pxwia0l17og8AXz7cp1l018CvgjOei9r8QNQykbHoEsg8nB8ln4Gi3vmPstDN6p5eVTunCofVqrJhbaVGg6S1TZjb0KseUcKJMIGivmjyHp0gtZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(66946007)(31686004)(66476007)(8676002)(66556008)(86362001)(31696002)(6636002)(36756003)(38100700002)(186003)(8936002)(6512007)(26005)(53546011)(6666004)(41300700001)(6506007)(6486002)(478600001)(316002)(2906002)(44832011)(2616005)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3BMYnM1WERHNXJONXZIR3lDSkNDUW56V1czWVNuZWtDcG5LZDdRNXVxeEl5?=
 =?utf-8?B?TUg0NGtBRStoZkRkTmtOU3hhREs5cFZ5TVAya3UrY0FBb0pZakVsVEtRcWJv?=
 =?utf-8?B?amhOTk1EWTZmRHB2U0pzcHp0V3psZU83SnR6Q0cyZXVLaWQxUkNyRTNFMzcx?=
 =?utf-8?B?Wm9lczkxMUpBVFJCYUZnQW5zb2NrSDQwNmVEa2NBaHRsRXc0eWxrV2xIeUx3?=
 =?utf-8?B?TnRzeFFya1JPdWpVWldwd2g0YUNVUnlMOUdabnpXZGJBVTZvdUsvNXBSR0lj?=
 =?utf-8?B?ZkJ2RXY3amV0ZmtWK0hXcDY4cWFpNTR3Um1uelZtSkxGdGNHL0g5dnVzZHlL?=
 =?utf-8?B?eEFnSkR1SC9RZXNWQ2h4dEdJR3lzS1E0bURSbzN2QlhUZVZXS1lienNYZ28z?=
 =?utf-8?B?V3BnYUpIQWZFeDR1WmVCcmRVZnBSSWpEZklNbzc2em1Hd0tOTTh5NkVGS0pX?=
 =?utf-8?B?cE1LTHVCUS9hRzNhQnVMZHJuMndlUktLNnlwU3ZNa0JDV0d2L0d5K3UrbDZJ?=
 =?utf-8?B?ZXg2Z3FxZFZtQ3ZrZTUwMEZjVTBJVElpRTRJM3dQWE85ZlBCdmlYdjRlWk5V?=
 =?utf-8?B?bHo2QWdDTlk0TGlwTmdFMWhBalQ3QTBNTkRzUTJ0bnY3MHoyN1BuTUtMRjYr?=
 =?utf-8?B?bkhDK0xuRGFSenA2b2NkNXdVbVZLMzZuVFhIVS9EUnUvVWRGclBjY2FSWXpl?=
 =?utf-8?B?SlZIWDJ1VDh4WWdST3RiSzBVTGxhK0xvSkJES05CVkdpT2gwaHNYSTNpUTVj?=
 =?utf-8?B?UlpqT0l5K3pqVG8rZUQwN0xoZnpGdFdOU1VJd2I1SStaUWpqVWg2azRDTUJV?=
 =?utf-8?B?UVpIY0l2ZHhkNERHc0IwNkdiVVJleHVpRk53U3RqRUE5cVc4U0JHR0tqdVhq?=
 =?utf-8?B?bWtCV285citRMDYyWTgxU2ZpM3NKWmdlanhZZzdOTnFiZHkwaXR1SWFmREN1?=
 =?utf-8?B?RWdUWmhHN3h0blNYSlN6eGdBYlRQd3pDaHd6cnFhaDZxSXpPQk5MVyt1S3N1?=
 =?utf-8?B?SEFQejhwaG1pbXJ3VmxsVmVFNXA0MTM2L08vUFZIalRSM0h4ajVRR3RCMFJC?=
 =?utf-8?B?aEdna0sraWgza3AxTHZkYXQremUwTm9VUU81LzU4Q0hPVDVNMkZhYlBpUkJk?=
 =?utf-8?B?L2x0dlVNL2JkdnpQWmwxMDFwUHFxdEtvVjB4ZGNobkVOOHFua1pMTmdNQ2Uv?=
 =?utf-8?B?VHRUWUlVT0FvL09lcU5UT2NoaUFzbWJOODQ4bEdYUHF0YlhXTkRUNUlvQk4z?=
 =?utf-8?B?ZGZJMmgwU3c1VlE4U0hoS1RtaGV5UWdkSm5QbFV4RlhVWFFGVWttZGNTdFNq?=
 =?utf-8?B?TXZOVkpZY2ZCVVJPV2JmYzFIaEE5SS9qNmE5VGlXa2x0enVvb1FnSGwxK2hK?=
 =?utf-8?B?VEpKcXl2bzROdjJZMVN1ZzVBNVZYek9yLzZUWXYvYXNERzY2NVJhQnZpTmRn?=
 =?utf-8?B?Wk9SWHhpdDdRK0NjVDdFdGE0V0JLNUtKeVg2L0dyK3ZxREFOS0V4ck02STZu?=
 =?utf-8?B?OFJLVXlPdG95R1Q0bjg5Tkg0bjdkVllJdEczTFBEb3hQTkw5QXBla0dLem5t?=
 =?utf-8?B?YzR6NFJscUV5TUJ6RGl1bi9ieklReUpsd1JsQ2R1Q09Gd0c5YjRrdXVxcVFx?=
 =?utf-8?B?ODM3blNvOE9BeTVVSE1ORWJJM0hrT0tMZWErdWJGZyt3YTRpSGovN1YvSWQx?=
 =?utf-8?B?OE50V0I1SHUrK2RsenpxbVZXbXNWWEd1bTJRWTRzbDB5ZnJONzhlQXY3TDdL?=
 =?utf-8?B?TS9kOUhkMHQ4TmxQRTJRMjQ0Lzd3THkvdWNHNHhrc2tLZ3k0RjYrakFIajdD?=
 =?utf-8?B?UzlGcVJDcUNja2llUkZsUDVQQXliMWtkdEhWbHI2ZU1RTmpJcHovamV6WTZD?=
 =?utf-8?B?allkRUdXaUtiR0lBQXE0QllWNklLTS94dHQySGNTMzhZMmtxUTJ3SVg0SXlo?=
 =?utf-8?B?SzU1bjNCQVIvalZtUjZoRjdGbENEdThFS010S2RrVWdBTHMwL2lNZnlsNjRo?=
 =?utf-8?B?Q3FvbGs1ZEhLTTRSbnViRmo2ekhWN2htdlZJTGVWN2NybzBVUWJxSStVRmU5?=
 =?utf-8?B?WTJaSU1kaXk2U3lmTEM2dDY3MEhuT3o4TkpieFROY3oyeVNHZFNtcWRsQ2Rv?=
 =?utf-8?Q?VfhoNMnV9e2Ha/B9hMvUc1NGL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2f7825-1dc9-43b3-49af-08da847777ba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 19:49:47.2124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PL/Wh7bpT46w5/oQXhCe7ppWAzAWg/yW93FBwExsP0zlUWptksSKe2aLd3qH0H04Qb1i4/Z+cLl/S2gOTJrPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
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

On 2022-08-22 15:38, Roman.Li@amd.com wrote:
> From: Roman Li <roman.li@amd.com>
> 
> [Why]
> DCN314 supports PCON.
> 
> [How]
> Explicitly enable it in dcn314 resources.
> 
> Signed-off-by: Roman Li <roman.li@amd.com>

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> index 85f32206a766..3a9e3870b3a9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> @@ -1750,6 +1750,7 @@ static bool dcn314_resource_construct(
>   	dc->caps.post_blend_color_processing = true;
>   	dc->caps.force_dp_tps4_for_cp2520 = true;
>   	dc->caps.dp_hpo = true;
> +	dc->caps.dp_hdmi21_pcon_support = true;
>   	dc->caps.edp_dsc_support = true;
>   	dc->caps.extended_aux_timeout_support = true;
>   	dc->caps.dmcub_support = true;

-- 
Hamza

