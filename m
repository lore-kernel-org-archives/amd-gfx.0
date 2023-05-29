Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50114C7EE23
	for <amd-gfx@archiver.kernel.org>; Mon, 29 May 2023 19:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBF3B10E24E;
	Mon, 29 May 2023 19:49:19 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD38310E24E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 May 2023 19:49:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NW0DQd0eEJGgt7fgy/7b2kC/4k86/dqjxUGb+jKQBDQJI4MpV3m+awOLBPvvhE6uTnJJGtFoqSdEVBX/HD+hhQGGXd6Kl9V/xp6kZByWi3vrrs5pxQ/EALnGSgnxfJOmAOpO+kqhBjeesJ6IjHRWoA9IPrB1J7sMx3jMOml8yHidI5u5g6reGRU9jBx+fheYdYf1BSVbWcsSHyf50mc8OCxuwY4lqvEhufXgTY9QYjZscGDP6wpzGeo0vfuaaEIvtDOAiq3Rws+jISYKq9NKVfaD1tnckv0sUUyR61E0A1nR7oboHIf15hvQIz5aVeZLuESYrZYr2i058I0PNBiaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IytiTomdADT+vmHRer6aMosD+Xq17DiAPl8JpTYmJpo=;
 b=eXAamRU0xKlhAgEuTo/W/A9yHMr8zriz/MT4q4ae2jbaSWXTPnVh9lJ1lPQSmRNTEOHMhyaLJw898345DKkcLs1Ll8uaIj0wgeQNE+4rxNUCphchlxtXn/4V5nTt10RX/vOawpjLC/izvORw271ea7sgDhux1bdPMbIl5qptj3D0FDpXUv/hbyw30xAiWJBi8B69aa/SgqjlkbdFW9BEIALqmueEu278CqrQ6norHXOcWJOObc9S5ZbjQErFF3rMzawv0X+7ggrM31Ye4U45uHa/9Aj4PUOOFNKsKhErOMqrJuZqxsFO56ItxvF3shA5hPXcIM+JPcMjECbcGkQZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IytiTomdADT+vmHRer6aMosD+Xq17DiAPl8JpTYmJpo=;
 b=ErocLQkOpph8tSIoEAOAgoq2ICqbc7VPSsto6NiDOsYiyKwBsJGcPkrqr54WrM+9b7GoUa0LzWU3VIRC6mqd+yQseeBrdyi2jVRZn73mHuP9uU7sECOG0YgdAx/+ctC9Smf3IQd5IE1QQ+R1ZXpTlyAIjF/smCqgs5K3f2UtFE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 19:49:14 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::4d3e:94ab:56ef:6e11]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::4d3e:94ab:56ef:6e11%3]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 19:49:13 +0000
Message-ID: <3590cc3b-9eba-e2bc-bc1f-14e1cabb219a@amd.com>
Date: Mon, 29 May 2023 15:49:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/display: Fix up kdoc formats in dcn32_fpu.c
Content-Language: en-US, en-CA
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>
References: <20230527164207.1527732-1-srinivasan.shanmugam@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230527164207.1527732-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::24) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: b52629a1-9f23-42b9-a55f-08db607dc71d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9jzw7cMr5VXoC1IiAjiFV/m0Fi3ZrtkNJEW4rVsfbolltT86fkA9kMHfQ3C+LZvkTRPG6MrHrvxlJftxll6fEjspxM+J0oQUguzJKFKgz/Axwq6kvmAYs1KgchIZKITccgDTBYUKjNfnCDAf4sazxUH3HZOqLkoOwXiLV2+4SdMXs9lDNxMmOC08DNRD9zG7L7WmTvZshi4DYNrke4xCQmFyzPeD2al4Re0bkqkp3C57IoR5HaPk2pCpVPctIiYO4VUh2WTTmHrk7IyXEx45J53na1iYkAj72g5BKOeAyQU3iznl3fmm92Ef5Wz8AdDIy0KUSdR+OnakveKj2FLyiABCXKxtjxC9ou63M7z2JD6hiUydMTNEC2VnKHP4g9/91j2lniFFyY0AjEiXaOZh93JPfs+c+2vlkTMyPoSfDb6RtxaZwV55KlYII3MH+GguGr2bHb9BlnA/p5zdn8JHv+JH7ru2emRJ2rG1bG/POaUD/2+jQLKI8tHbBA5XvUGQbSQ67Uq4uCHebGgnb1dLGZYcG6FaRoPEnu4Ot0ct98zHMstfUb7TtytxZaOI/fFU7wOOfkhXeVkkxz+2TJ9u5p1W6DPKG1mvE6kI2fDL7RlsnrLTgWNYKIb8M8ZxK6TMgcTnA328IOguug4P0tlsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199021)(6486002)(2906002)(31686004)(966005)(41300700001)(38100700002)(186003)(86362001)(31696002)(8936002)(8676002)(2616005)(110136005)(478600001)(26005)(53546011)(6512007)(316002)(6506007)(66556008)(83380400001)(6636002)(4326008)(66946007)(66476007)(36756003)(44832011)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWtuVDJPSEY1clM2ZjdjbHFPV2FGdGNVWmx1T1pXdVY0WnJXNGJ2R1pRcWQx?=
 =?utf-8?B?SDU4Nkg5UThiSXNzRWxOVWJyZ3ZJUXptSUN1QUhtUkw3QVAxQS9VeVlWQ2U2?=
 =?utf-8?B?S1V5bjlmZWZnQXhKRmlIY0xxZ1ZvYytRUGVMYWF0ektKU2p3cWowVUxLbHU1?=
 =?utf-8?B?TnFld3BFQll4SVJVdTkvMGVCRXd3cXNwbHNneGJXN3o2UzVzUXpYdkU3Q0ow?=
 =?utf-8?B?emQ2Z29HVlUraHlHMm5MZUZpYzhhVUw3d2NmQ0Z4ZVBYaXYvRHBmc1lqeVZX?=
 =?utf-8?B?RmVnVFVEWFBLL0NSbTlOcUZlOTZzR002TjVwOEhPRzNpTFpIV3ZDU3lwZXVE?=
 =?utf-8?B?b2hoZzNFdm1rVnNFRE44RUpSQWtLUXNoeFErRXNZZmRzWkg3OEFFZ2o4RlhT?=
 =?utf-8?B?clF6Szg1UHJnL0p5UkJpcnJ0WkNPbjVvS1gzeHVDOW5VWGxxRm5XSElSREdU?=
 =?utf-8?B?NzBNdDRuSVJZL0tXYnBGZVE2R1psNlFWaHR4Qk1vc0dpMjZmRTVGZGJnb2Vw?=
 =?utf-8?B?N1Z1WXhTU1ZURnRUd1Y3eHJlUm5NN2pJLzNKKzlmSVRrRUFnamRLeG1PR0Nu?=
 =?utf-8?B?SFBGTTVQYnUyOVZKNFhWYTdlbEw5aW4vb2pWc1hIV21SVmdxQUpWeFdOQlNu?=
 =?utf-8?B?YTEvV0xYUllaOFFhRyt1NTM3aHJzMEVSdEl3bjdtdjF2YzUrblVhOGorR1h1?=
 =?utf-8?B?ZGFqRFp3cTJINjZ2dEtHdEZyQkZPY2VhNm5TZDRIRWdoZWZJdWRpbEMzbnJT?=
 =?utf-8?B?Sk9tNVRpdnJ2QTIvK05DZzM3Q3pOTURWN29OUGJoRkNOL0NVWVdlcHdhaUlH?=
 =?utf-8?B?dGhxZWs2VlllVTRDa1dzc3V6MGUveHFoK1dGLzNrYnJFeWlkTWltWnZqRGcr?=
 =?utf-8?B?eTBiK29VRkVPb2M2alRwWUNBVVJCbzN3MHNXR2oyUjlyZ2MxYjBHRm9FRXRS?=
 =?utf-8?B?VnJ3K29qVU5qM1BsY2Y3bmhDeHFiWlREc09vd1FZNWxNY1ZZd3UzUXJORWNo?=
 =?utf-8?B?R0VuYjRyc2tDL0wvSUhyblEvU0RZUmFOS2RFZ0dia01SSGpOdWRXVmhhWEtK?=
 =?utf-8?B?L0UraHJqQ0hoRlRFZGk1UUt2SnJWaEhRMzVIQjEzc0hOSXdCSnlpLzRDZitw?=
 =?utf-8?B?Qk5WT3BjUHQzMGNjRm9jWkN6RkRrTVZHMnhMcEVJZlBGamR1b0s2N2t5YUYx?=
 =?utf-8?B?bjlJZXRCWDh1bnJEWWxDVmJXQUN5RndGSEVrbSsvbjBvQVlLYWFmRU41MHZl?=
 =?utf-8?B?QlNuVHlaNnQyTjdxa20xdit0dUp2NFlBSDZzaEVEMUM2SHRwVTFoSkJYQ0RO?=
 =?utf-8?B?M1hKclZiSHJHYTJBTnd6Um9wSHRxMzYxNlNDd1pDYVVyWG4zNUpUVHA0Zzgx?=
 =?utf-8?B?U3M3RFBhejFjQVNvclkvMVY4c1F4ZzNGcHo0M2wrUFlFMDYzVkx0MVRZMTJm?=
 =?utf-8?B?OUtUQjM2YVM1Nm1BTnR3N2FHKzVKUEtDQ2xRWkl1bjhjNmFKYyt3U1FITVRs?=
 =?utf-8?B?QXltM1ZmaDByblN2eTJ6N21nUjloMlZzdlZaTCsyUUdwb0puY0pBMExpR1JK?=
 =?utf-8?B?RmhIVitvY0hQZy8xSDhrS0orSlN4ajVSUy81TENrWXk3a1JSSjhFTlE1WC9u?=
 =?utf-8?B?Sk1HYlp4OFVnSlRlUmdHbFl6VUlwS0gyVzJneWltcm11Y0Y5MTk5T3o0Q1Bk?=
 =?utf-8?B?b0E1OXNwSmRmdVhINEMrem1xMkE5TG1UeXN4K3JIL0lzdk9yZzBPSG9wZnFD?=
 =?utf-8?B?YkJVTG5pYmtBUEkwVlFpTHFXRVJ6U05UcnZ5Rm9qenZXVkFtYUQ5OGxaYXFq?=
 =?utf-8?B?MHduY1c0RE02OU03R3FhQys2R0F5TERBd3hsSTNDWnY4dHZtb1hpQ0JFT243?=
 =?utf-8?B?UUIzR09hdWx1dEFQbXF2QzNpd1MxejV2QVhtcnhMaU5FWG5BQ0x6YWJSOG0r?=
 =?utf-8?B?Q1RwMFE2RXdJMXVZc1Nub0F1ZXlCWjNHcUNFNWZjeFB1WWRZb2hPaVVWK3d3?=
 =?utf-8?B?V3poS2kxTnF2ZDU2ZzlPQnRHNUZlZjYzRndtai9DeDE0RktlaTh2VEUxM2p4?=
 =?utf-8?B?NjNFMlNnQjJSZENKY3FjRldKdFlFWEg2cCsyV1hwbHN3MjJXb3JQcXBIY2xh?=
 =?utf-8?Q?WzRdl5YO18bRsLBSnLaHsDV1g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52629a1-9f23-42b9-a55f-08db607dc71d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 19:49:13.5803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5dTwQSOcoEHgTR2XF8sXBed4oBj5YveqwDo0kXcfJIr8CVaIHRCsjdKttrVHfgwoRYBSzIZYsg2gYlXp1SC1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309
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

Hi Srinivasan,

Please see my inline comments:

On 5/27/23 12:42, Srinivasan Shanmugam wrote:
> Fixes the following gcc with W=1:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2806: warning: Cannot understand  * *************************************************************************
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2855: warning: Cannot understand  * *************************************************************************
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2900: warning: Function parameter or member 'dc' not described in 'dcn32_assign_fpo_vactive_candidate'
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2900: warning: Function parameter or member 'context' not described in 'dcn32_assign_fpo_vactive_candidate'
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2900: warning: Function parameter or member 'fpo_candidate_stream' not described in 'dcn32_assign_fpo_vactive_candidate'
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2929: warning: Function parameter or member 'dc' not described in 'dcn32_find_vactive_pipe'
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2929: warning: Function parameter or member 'context' not described in 'dcn32_find_vactive_pipe'
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2929: warning: Function parameter or member 'vactive_margin_req_us' not described in 'dcn32_find_vactive_pipe'
> 
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 46 +++++++++----------
>  1 file changed, 22 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> index 137ff970c9aa..6d8dda4cb065 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> @@ -2802,13 +2802,12 @@ bool dcn32_allow_subvp_with_active_margin(struct pipe_ctx *pipe)
>  	return allow;
>  }
>  
> -/**
> - * ************************************************************************************************
> +/*
>   * dcn32_allow_subvp_high_refresh_rate: Determine if the high refresh rate config will allow subvp
>   *
> - * @param [in]: dc: Current DC state
> - * @param [in]: context: New DC state to be programmed
> - * @param [in]: pipe: Pipe to be considered for use in subvp
> + * @dc: Current DC state
> + * @context: New DC state to be programmed
> + * @pipe: Pipe to be considered for use in subvp
>   *
>   * On high refresh rate display configs, we will allow subvp under the following conditions:
>   * 1. Resolution is 3840x2160, 3440x1440, or 2560x1440
> @@ -2817,9 +2816,8 @@ bool dcn32_allow_subvp_with_active_margin(struct pipe_ctx *pipe)
>   * 4. Freesync is inactive
>   * 5. For single display cases, freesync must be disabled
>   *
> - * @return: True if pipe can be used for subvp, false otherwise
> - *
> - * ************************************************************************************************
> + * Returns:
> + *	True if pipe can be used for subvp, false otherwise
>   */
>  bool dcn32_allow_subvp_high_refresh_rate(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe)
>  {
> @@ -2851,16 +2849,15 @@ bool dcn32_allow_subvp_high_refresh_rate(struct dc *dc, struct dc_state *context
>  	return allow;
>  }
>  
> -/**
> - * *******************************************************************************************
> +/*
>   * dcn32_determine_max_vratio_prefetch: Determine max Vratio for prefetch by driver policy
>   *
> - * @param [in]: dc: Current DC state
> - * @param [in]: context: New DC state to be programmed
> + * @dc: Current DC state
> + * @context: New DC state to be programmed
>   *
> - * @return: Max vratio for prefetch
> + * Returns:
> + *	Max vratio for prefetch
>   *
> - * *******************************************************************************************
>   */
>  double dcn32_determine_max_vratio_prefetch(struct dc *dc, struct dc_state *context)
>  {
> @@ -2881,7 +2878,7 @@ double dcn32_determine_max_vratio_prefetch(struct dc *dc, struct dc_state *conte
>  	return max_vratio_pre;
>  }
>  
> -/**
> +/*
>   * dcn32_assign_fpo_vactive_candidate - Assign the FPO stream candidate for FPO + VActive case
>   *
>   * This function chooses the FPO candidate stream for FPO + VActive cases (2 stream config).
> @@ -2890,11 +2887,12 @@ double dcn32_determine_max_vratio_prefetch(struct dc *dc, struct dc_state *conte
>   * ActiveMargin <= 0 to be the FPO stream candidate if found.
>   *
>   *
> - * @param [in]: dc - current dc state
> - * @param [in]: context - new dc state
> - * @param [out]: fpo_candidate_stream - pointer to FPO stream candidate if one is found
> + * @dc: current dc state
> + * @context: new dc state
> + * @fpo_candidate_stream: pointer to FPO stream candidate if one is found
>   *
> - * Return: void
> + * Return:
> + *	void
>   */
>  void dcn32_assign_fpo_vactive_candidate(struct dc *dc, const struct dc_state *context, struct dc_stream_state **fpo_candidate_stream)
>  {
> @@ -2915,13 +2913,13 @@ void dcn32_assign_fpo_vactive_candidate(struct dc *dc, const struct dc_state *co
>  	}
>  }
>  
> -/**
> +/*
>   * dcn32_find_vactive_pipe - Determines if the config has a pipe that can switch in VACTIVE
>   *
> - * @param [in]: dc - current dc state
> - * @param [in]: context - new dc state
> - * @param [in]: vactive_margin_req_us - The vactive marign required for a vactive pipe to be
> - *                                      considered "found"
> + * @dc: current dc state
> + * @context: new dc state
> + * @vactive_margin_req_us: The vactive marign required for a vactive pipe to be
> + *                              considered "found"

Multiline description for arguments should start at the same line as the previous. Please see https://www.kernel.org/doc/html/v5.0/doc-guide/kernel-doc.html for details.
>   *
>   * Return: True if VACTIVE display is found, false otherwise
>   */




Return section in kernel-doc does not recognize line breaks, so you could put them into the same line itself, or you would need use something like:

* Return:
* * 0             - OK to runtime suspend the device
* * -EBUSY        - Device should not be runtime suspended

For this patch, multiline issue with Return section is not an issue. With the argument multiline issue fixed, the patch is:

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
