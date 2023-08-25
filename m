Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0503C3DA6F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 18:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DF7910E15D;
	Fri, 25 Aug 2023 18:55:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5957710E15D
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 18:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KR4Ttqu9NHOKQNAw960/A79d4XQ2ciugop7BU8OOXstustvbhG8CZSNG/ouKLYSCnpryELBv1yShAI+05bV2RXqk/zgAckJXL/zBadTZBeWQs/5zcfigio2iogpA4T9aEnV490UXoz48D1LtnXaib0WgH+pDa4gI0zPsM4Z+bVdA+M9g8aktsnY7W+Okvavas3DpRwWAjnytp0SyTIqRxYPgKKjY1BkCpz1cg36T6IpXLPzl/+CjrC1GLsulaIbAeYjcYSKTjsl6kw7ralCHjbHsPoI7MQMzfNnYGewewiwo/DcVcUwS0DZ/Fbcmp1QI7sD0vV+0EGW7DZIWTgM86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qG+Q0A4JERs/VaDsWdn6Y5crYxWf53PhKHepQp2fC5o=;
 b=W07fJckGBBura5GBeoMKTpbWFaDErK/0JwXFeuPN6RXqmNCE8KX/PZlbYqu13MvvP8mQc98gIO8UAUh4rMq3Be+vvGshv1hrWBtuXH4y8ayNQUIh0IVq29GB5HenYa7Dk34Bn9wQMJDi6YSbIc5JQgepyeiMliMhkbEyS+yoZY55oz/NW6mVnJrBok6bxqE/jJuyqwMMXBKvXMgNPINU+kc/3xq4gCetZLEFhGN8bW0BXP6wXG1ISRP84uZCPHs5JY0nAor3saJpxES12xxFT6TC2ZRyPqHXcucp+m8fO8i3jkeoNmOod8s7+ElUXQ7kw2zxjyfuYd/+A8v2Jn0dRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG+Q0A4JERs/VaDsWdn6Y5crYxWf53PhKHepQp2fC5o=;
 b=eXJFbPP1mPmqBPSnRQGPnpU6j+lqMZ2cXE0lO2BsgPigYm4aB5+iog/nF3mZ5uxL6JJ90m8/yr+d2Mx9XFctGSyFOOeWcUetF5Jhkp1/i8VYYbO/2bt+7+BbDywMRr+sbiLoMOqirFwKq/2FgDdk7ZegUjmBTvVZIeZfDpH00L4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 18:55:23 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::236b:d4e2:6fbf:6c2b]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::236b:d4e2:6fbf:6c2b%5]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 18:55:23 +0000
Message-ID: <5dd3a2c6-b960-4821-81e3-24eca3c6506a@amd.com>
Date: Fri, 25 Aug 2023 14:55:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix up kdoc format for 'dc_set_edp_power'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Ian Chen <ian.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230825103834.1176177-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230825103834.1176177-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::34) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|BL1PR12MB5378:EE_
X-MS-Office365-Filtering-Correlation-Id: 124c7c90-0591-4176-2e64-08dba59cd643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wP/etNaArU5UyN6HhLclVvlea+1JQhfEy6XNvyAQAb7N4EDeHHZX4g1NU9gXxt8/49pgkiPxtlNEA2LZ3eclt+MybN3lTPeJRsbfovGCNf8wCknfu+BT96mQONEj+beCajw95qLeMrat7f+IXqpyvwVOP2j7PL7CklSwg2xGkWtkA9puJNdz5uLArv+wWKNZ3NjxYX5XleO6R3xUQlPDxqeP/iOaD1KS0U8kiwGltCHOXzHU0xXkzjkLUHwXPOAkKTK5GpIzIQ5SL2m5GrCjawd39xlEFMd812bCnkG63rnTjLfgNIN2FgmuRrQ8GKMSUPE/w8ux7cQ51ooAaD91UQU62v0j53rsBvnW3FSuLZhT6bU3ynB0zKvL3WbrfhCmRN9DjbCQUtAef7vCh0W3B+MudF8OcWOEbg420gcAzUoYuNzfM7QwZkiFwSobxghvc+I2amFCAoizlriC+FPxvxSG4YwYSkMxKYBWXqmZoHQUlXyuYVCUa2BO4V7rRPc+xtTay1a22E5ymfKnX5IB8dM8Pgy0c/meH/kG69wIgbPYa/TIrWezfFssZR4pFL/lnwFljlyiuv3Zex+F1+vl1RxPJK9kOa/KlT5u5d0qV3xWtlM0QTCT1dvy8YUqi5ZtN/RJ9gtRZhb+CaiweVKk+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199024)(1800799009)(186009)(38100700002)(8676002)(4326008)(8936002)(31696002)(41300700001)(6506007)(6486002)(53546011)(316002)(6666004)(36756003)(66476007)(6636002)(66556008)(86362001)(66946007)(110136005)(6512007)(26005)(478600001)(44832011)(83380400001)(31686004)(2906002)(2616005)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cS9samJmczJJNWVDbUpwS09EVWw1MzJVR09UeTNkTUZwaXJWaVFxNFJpZFcx?=
 =?utf-8?B?cW45anJCYW1vVnJHWStMQ1ZBNFVVdHJCTW5IUzZyYkxteEUyYkVsQzZlNTky?=
 =?utf-8?B?Y0luZTdWR3pvRXFVMUdoS01TZWhkQjVsQk9xSVEycldxdWNrVTJYZVFMclky?=
 =?utf-8?B?NVZDVHpIVlhGcFRBeDAwc3gyMTNzWXM3cEhyOTRqREN4cmhQYUh1dk5IL3JK?=
 =?utf-8?B?SUJaYkV0T001U3pKbDByNFZtWTErL2Fzc2QvSmw4Vzk1QktJNWQxY1NrTFRt?=
 =?utf-8?B?aEkrOFZZU0gwbGdCREtVVXFkdGNmK1VLMnF1ZklqUVVoY1BJdUZveEp3RDJW?=
 =?utf-8?B?a24rM0RMRlRheElFL1E4amp5NHpFR3R3dmpWTWtNNTYzRlArOFZBeTY2K0pM?=
 =?utf-8?B?QW9Tb05nUmFrdlViM2tySVpIaGVhUWVlWUpNaDVBMHM1Q01iWGxjTnIxMU40?=
 =?utf-8?B?c1pybGFWbEhEdkRpbEZBKzZZWTJVUWgvWlQweFJrK1haTG1MWTRuVFpqUmk4?=
 =?utf-8?B?ZTFROWFabzBTdnIwMEIxV3luKy9DM2trTzA5TFFoV0FTSVRCa3hkTmZrbWJY?=
 =?utf-8?B?TlpnajRIQVFwelpZNVRsTWFKNmp3L3BPU3QxYy8vemlZQW9wNCtqVGRGRDZI?=
 =?utf-8?B?V2xjdHhYVkkwOXVyS3hFSjlZU2V5WE5qb2krR2k1dWdQQ2d4WFZqQ1pwSCsy?=
 =?utf-8?B?L3VaWkt5U3VLbkRSamFmMDdnT3A4TnM4NExlT1MwblVjSXBrTDFOT3lWTFZ4?=
 =?utf-8?B?T3V6OVhTOFU3Wm10N0dRMkdmaHNlTVBYeUpEV3liWEFFaDZiL1ZVdmIwanN0?=
 =?utf-8?B?cDJJK0NQTzUveU9NNGxYOHc3bWNRZDJ3cXJheW81QjlOTndvTXdsMnRFR25J?=
 =?utf-8?B?RWNyZmJpNDJidlZyL1MrQldMZUpaRzhoTzY4ZnAwZnZsb1FPQWtOL2RzWkxs?=
 =?utf-8?B?aENtKzdXWTN2dUNnTk1UblRkek9IelpJRThvZVEzZGJ4OHhrQjhmb2N6a0hL?=
 =?utf-8?B?YnIvbHlUT0hzdGFOaDdvQWt2a1dKK0l0YXVxbklXQmpuanFGaDY2bXBQc0E0?=
 =?utf-8?B?WGY5U0hPMkZ0aHhGUC8rREZ1YmxqeEZFOEtzNlhVSk44ZSthcjV1WnphdkpO?=
 =?utf-8?B?V1BQRUdhNzB5TkpPRVNzVXEyZC9YTTNwZjdpTTBvWGJyQ2lwUHFiRnREV1c1?=
 =?utf-8?B?Nm8zNUZGZ1NReFhzbVZWQnhqUEF5TnFpdGIrenpSMzl0cElUQi9YZnhSS1FR?=
 =?utf-8?B?RExYK0xFd1UxOVp4cHJBcjBaV1pmZlR4SldreHNqSWpzeUYzVmdsNUFtUGdx?=
 =?utf-8?B?NWZ4WVoxZWZSMjNEbnJuT0tlajcvV1ZMKzVINStvMjdYUHAzeUJub3ZIN0cy?=
 =?utf-8?B?Yjc5dFlJYlJDMmVtRTl2bVhaSzcvWFZscFFRZXJRNXgvQXRyWVpzUHBpVnpG?=
 =?utf-8?B?UjRhWS8wS0s3MVBZRWFDQ1pDYmFvVXgzeGM4L2J0dGVhdCtlWnZEZUhiUzhH?=
 =?utf-8?B?Wjd3czQvbXRzY3MzK1dDeTJZTkRkZFpqcEFuTnlQYnJlR1RVVmVVM21lY1d5?=
 =?utf-8?B?UTJwZXZ4eW1peFIvRTBhbVJ6WnY5WjJCZ29qTUFsNk5kcVdab3pITi9mRE9W?=
 =?utf-8?B?M04yN0RTZFUvTVZDSEt4ME94aEMwU2Y0aHhna0liUUN1WEhZblF6UXMrQklD?=
 =?utf-8?B?NFdCaTUwZG50UjBnYWY3RFo2YlBQREZWY2V6SkQ4by92cVpydXNRMjhOTXpp?=
 =?utf-8?B?bTNIRFR3emRwY2V5cDZ5THl3SmNRS3Mzd3hhR1RFTllSb0RkcEVyU1pFcStL?=
 =?utf-8?B?UjY2c05WeFpVUUl5SHlFMjdJVjNWSnl6RFZWUHVBQUdlYjZRdTRmV1dNU1V4?=
 =?utf-8?B?dTg3cHRTU0FISXJPNkFRTkR4YVZKa2UyL3JYejZYeHRmSmFsZ3Z6U3JPalFs?=
 =?utf-8?B?WnpnQVNKanRhd04vMmRTTFdmVFh3WFFQVWYwK1Qxb2tHMWlXUG1OcGpkVjFq?=
 =?utf-8?B?dFQydWJ3Wnprb0lENnY5QzY0SEtQdXFWbzZEaHZqZ3RVVTVTcGFFU0h0SGlX?=
 =?utf-8?B?WEJyQWFwcU1NS3QrL2V6UXdFOVhxOGUrYndSYTNuOXh1RHllb2pYVXRFQSts?=
 =?utf-8?Q?kEe0zgDXKc/pDFyQJG+vsMiNp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124c7c90-0591-4176-2e64-08dba59cd643
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 18:55:23.3821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcJ6SL+pJCS8hb4OsGEUZU2QzUPgjDuyp2SAsGMz9r7D4pxDmg8dqFtZ7tMvSi5DvmSbfFLLUcRFo21Gn/GtlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-08-25 06:38, Srinivasan Shanmugam wrote:
> Fixes the following W=1 kernel build warning:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:5261: warning: Cannot understand  *******************************************
> 
> Cc: Ian Chen <ian.chen@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 025e0fdf486d..ed225e1a1299 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -5258,13 +5258,16 @@ void dc_query_current_properties(struct dc *dc, struct dc_current_properties *pr
>   }
>   
>   /**
> - *****************************************************************************
>    * dc_set_edp_power() - DM controls eDP power to be ON/OFF
>    *
>    * Called when DM wants to power on/off eDP.
>    *     Only work on links with flag skip_implict_edp_power_control is set.
>    *
> - *****************************************************************************
> + * @dc: Current DC state
> + * @edp_link: a link with eDP connector signal type
> + * @powerOn: power on/off eDP
> + *
> + * Return: void
>    */
>   void dc_set_edp_power(const struct dc *dc, struct dc_link *edp_link,
>   				 bool powerOn)
