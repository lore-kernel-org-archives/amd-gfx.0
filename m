Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9106AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 15:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 288FD11A260;
	Mon,  6 Jun 2022 15:47:22 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7166E11A260
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 15:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asuY+rnaRY+Uj95u7+E0WI1DPSNJn/1OOIz4hn6Py4zVbxhP8DkMh8V+QWhBA78vzNhtefG/3N8kGkxjC8NK54yoKwCSgiPKmnLpedc35lg4jNgg50gwhxT9S1D/efopDKGDxNXDERzobGJsJ4PR2jx3BRQmn0tcS0XGO/l+JmsXqyRopyjspB7LbNJUKxAmtS+vVwXs+atRAiKZqpw4T8I2I7shY5oVH9+ofWjoyfGm7/QFby/MZp6C6zSLqy7Se5UgLvm36LNko8/ixVF+olcLd/NxSgYQj56kkWm5/kgg+Rhd4dk7ZReZVyoxmq+Tq8ss+Fdk8rygPN71/TxgoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qs+TwdSuTDuIgiAFKeXXWshgexMsmAbUulQwwpdvCk=;
 b=frpWV/2A7oz3pATU3WJ8zYPmrquhtXq62GxFmihzo2CHA9ZWZgc9o9CX0xJAA/d0GmDY/aJB9SlmRVqQoHobr3Tg1/yI1vAgBme4k/uen0O6mzJN0EepPS6ucZB4d4TcdD4Zl4s7bLQhgcq+VG/T5e1gyKsjKFYBMSnZ6bW53cwvC2qshtBjE9jlxCeCUbVH5LIra4+dvTskAruvP0S0aq3TNlrLgNhcBktg7b/3kcOX7WT/z+L79VUT/zUNsTzDkqS0duR5AwmchDa4a147A9hmRQTEMyg4fA6kkI0Rl5URYUj9ZrCuzUOMAr2/NKdRPZOykHdUBVm4eOl2OAByjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qs+TwdSuTDuIgiAFKeXXWshgexMsmAbUulQwwpdvCk=;
 b=xU7wlXRpS5yfvRd4TCN3IjD42zLqPJXMREl5JwGhM5NEy50j+wLATE7t+pncI8fqNAXk9tqXdgBAs7yCAtHHuJlX7ms3PzEColHGmPOafVH5esyYUtqLF2f9SeSIO8D4zYYnG/fOkP9S8avIC+Ssdfd42KqVKtHl1yUhS+fjN4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MWHPR12MB1567.namprd12.prod.outlook.com (2603:10b6:301:d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Mon, 6 Jun
 2022 15:47:18 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 15:47:18 +0000
Message-ID: <b2278abd-50e7-a924-0222-f25d89fa350f@amd.com>
Date: Mon, 6 Jun 2022 11:46:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] drm/amdgpu/display: make some functions static
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220606154228.839904-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220606154228.839904-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:208:239::35) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbceb8ff-46ee-4cea-a6ef-08da47d3d5e7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1567:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB15673F7464EC39465217DEBA8CA29@MWHPR12MB1567.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4dHqeiVVJVTEZ4xJM8IVoQRhuCYS4PTVvn1Cmr4koReYD/o0wZ84XRiMNLVBmH29hTP6jEgnNI2as6Z78/N+/lzyGU71ENpexjXuunxTMpg8ngEVYqerOd48YS5HXkcgELENpnwkz5RSqaqKB+aWz+jQd7vnSzOlwgMTiamWZr+KJq9FySbSlUNCmXO7EUlvaaQUjCuS+kOxZ/VLgzegDzbuA2fM93rr8iz4TKf0aeE8LLB/BnmffcSrj2SgjwkIRwvKWksn6ej1DOOZZrUic94GO9dURXrNxbfC9VxJGJv0PI1nAMRPkg/xMg/Li/exkuua9AWeAJ/OXjff66mou0+eRUIGzcn2Z7ubExRHL2qPCcV88cLWcDUj33uPLlzN3uonN68MDOfs05zWgjTLGBaI4yGBoP8CgAAmcfAO9yGSEQVUjF/RT8t8Dv1eLHNjeg/l0b5n4Z7v/o+CZK+/xXIvRHPXfph1xtKkLvWPBvyyjTgTX2bt+yv+qegbC0Fngn/xg3OTUyPPdMtN34nn7NLRm6rNRrBqYjOk2IE1dwTClMLG22wGpaM6mgso7ZUssUJiXXcARVs/qJXJxtCQ1EmQkadS4yaCC9JyclpE3iXYiyFeRs6ifXN81oMRtOdfqlabPPApfT7fciOTVxR+DnJfCuMPORsJR52KD3sPOMS6HLn3f8ZsLyxG/mEGbZfbmGjF9uGTgrJGYvnO+BqKx0T5FiBxLUI27LxqQTQEx8f2MhwX14+VUdorzv+QSUb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(6506007)(8936002)(26005)(2906002)(5660300002)(6666004)(38100700002)(6512007)(53546011)(6486002)(83380400001)(316002)(8676002)(36756003)(44832011)(66556008)(4326008)(66946007)(66476007)(2616005)(31686004)(186003)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qy9hR25yUUxyS0R1WEsrTWc5cmdFdDVnNXRndTlsaTN5UmJjcFlVLzlMRWY1?=
 =?utf-8?B?SGVuc2xJby9WWmU3RXZFT3pMNHFpcmhvanhxWWRydS9TdVBPZm9nNHZFMVZL?=
 =?utf-8?B?QXdQQzJuSWw1OWJCNktuMEx1WGFiK3JhMjN2Zk1mWU8yclRYdGQrVVErd3NR?=
 =?utf-8?B?TmplV09QanNWV0hqWmQ4SUZmbi9SSXRYSnRRQVN2Wi9mM3RmdkNSbFhzYkdu?=
 =?utf-8?B?Z0RzYlY2dGlFSlNwaUVQV01xcnd2RjhDL05HOXdzYng1Wmt1bFJ2RkJLcm8y?=
 =?utf-8?B?SWVtSGhQU2w3dlNCMzlwcVJVNWhPQ1lmWFQ1djZFOU94VWNHYmMxTmwzejRa?=
 =?utf-8?B?L29rS3FTVHBxMG83N1VZU3J5TzlxbG8wNWtWN2pDZlk1RjFyeTlXYzZwdG14?=
 =?utf-8?B?OVBSa3dyWVRiaDBUM0w2T1Fab2hKa1o5eDdSbkhMY2VpY0NiUnU1c0toMGRv?=
 =?utf-8?B?ZUxQWWZSZ2NWYzJZcWlqalZicFBkdmtPWmRyd0hoMlFnQndseHYrVktHS0Zj?=
 =?utf-8?B?UVJJb1dCeG4vUWJEL0syT2lZRnEyWnZoVjQzMHYwZkNFcm5pUis0TW5VL2Nh?=
 =?utf-8?B?Z3JGVVdXZ3RLRHNnQklXRWhxN3hBbG55ck5FWDJySVJ2Q0YxelZUeUw5dkcz?=
 =?utf-8?B?Mnd2VjJYMElzZkgyVnV6T3FESG45TGtOTXBOekViNUswa2ZYN3ltcHp5Tzhs?=
 =?utf-8?B?VWF3UldBcURzUGE4dW1xKzIxelZ3bm5Zd1pMSk5obzdCMTZERXRsMzRDSERY?=
 =?utf-8?B?dmdaODFSa2d4ald0RDJRRThrTVNYVDF4aVpDS1hqMzdXOWg2eHAvcG5TN0Vy?=
 =?utf-8?B?TEp3ZFMrRGtkTXQxcEdybmZLeW9Ec3JhUEFoSjh3ZThyUkkybnlZb3hCT3Ix?=
 =?utf-8?B?cVh6bEJ2TDJnR09LMk42YTBLN3BDQTY1UEpZWThLY0xEbkhaKzF2YmJURWVp?=
 =?utf-8?B?Wk42UWQwMjlBRmZzWFUxWUNUVEtqUFpwR0hCQWgzbEc2TEg3eXlGalVoaGxu?=
 =?utf-8?B?MUxOYmdyZFFHR2xoM3gzamxuWUVYVmtsak43dHJocXlGcW9lNm10ZnJBVmlM?=
 =?utf-8?B?Sms1TGQ1K0NrVzF4eVN6Q05pdFQwUWVjZmZheHVrcjhLQlkwTE1mWFVNeHB3?=
 =?utf-8?B?c0xsTm93QmN2d01raDZEOVl4UUZ2VGJEWUdBc01DdUdCRDdSZWEyWmtHOHJt?=
 =?utf-8?B?MDhUQXFrblZ0TEJhS1hHN2MzNlpNcjNseEVmLzhwaEJuQlg2S1JkSktWYWhZ?=
 =?utf-8?B?YmFNVGtDR0laOTRBcXBxd3pKMWFKZktQUFBVcGhUREUwSVhUYWRNTzUvUU5a?=
 =?utf-8?B?bzNyd2l1ZGZSRDFSMFd2cmhCejRVeTRaQ2FOcXN3RzlsSEUweTcxMXYrYURq?=
 =?utf-8?B?UEtxK0MxN1dEd1MzMTJMWjVlU3VsZExqL1FGOVRTRzFXaWMzL0pQZ2dFOUZ4?=
 =?utf-8?B?N0tKTlROZU1icGRySXViTGlFVHcxVlRsY3pGdFBOaFBqbjlQYlVqamVmTVZi?=
 =?utf-8?B?eWpSb0M5RWUrMlR4L25CSThnM3ZWbnMxd0ZCSEJ1c0hNSVdUdXVTbEZSdGE2?=
 =?utf-8?B?TkFjUHF1UHN1UVFFR0dVSVNFVXlJaUlNeHdrMkNEUWtGYld1Y2pJV2haZVlN?=
 =?utf-8?B?dlJWc2hyUlBvd2Y3aXQzdjh6MjdHci9jN1ZGNW02d001a0NMWktpWERMQ3Rt?=
 =?utf-8?B?SWxRZ25XT2VlMGlyLzFXRVcvVXhoSm9HcEx4RXNUbCsraldtVVRlTG9Ma25n?=
 =?utf-8?B?NmxSYVFXNHNBOCtBd3pxcmhtaENjS005STc3Z0VBZ3VKVUZxQ01iUFdmUU8x?=
 =?utf-8?B?VlRJRkxEU1VyNDJsQnc1bzNnSk9SbU9tbEswc3haUXcwTGMyYlc0bEN4dC9x?=
 =?utf-8?B?aExWNkcrY3ozR0NrR3dBYzhWUzRIREpnSUQwL1NjOHdBQ01ZZVEwMW4zNGc0?=
 =?utf-8?B?Z1JXTTlrbmd3bE9iODVwaHVNZzJPcWhhbHlzTHBkUStMek96S1dSOVdUZjB1?=
 =?utf-8?B?cDViRFl0Q1dWWkpyQ2czTmk1MG94WlNQUDFSMHpUZlFwWlFWN2dDbHJVK0h0?=
 =?utf-8?B?ekdLai8vOTBET0pDUE9CcGFULzlvZmNoTGZ2WXE0Y0FZc2p6TnVnaERiakc3?=
 =?utf-8?B?T3RtRVQ5MUVJTjFLOER6dUM4YTc2NmRlTGhjZFVPU2ZQRHYxeURCOXc4Zmor?=
 =?utf-8?B?OXMvVU9DQllBdERDUW5qR2hXN2pzNmFyOFVCNDNnSUNGYTRnQ2dwSnFyRTA0?=
 =?utf-8?B?elFlRG9XN1FKY3pkU0VYZTVMN08ycU9XcE1uNEgweldOS284YURFdXdyaGxo?=
 =?utf-8?B?YW4yWXFYZEpSS2NtTndCdTc0K1JNNU8wd0dYU2JTUXk4SXhuMWIvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbceb8ff-46ee-4cea-a6ef-08da47d3d5e7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 15:47:18.0008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PzorkmX/Wvf9yrVfau7Dl4ANRAmX+rySk/K+r4Cvt6y0nIh0MH6m4EaTHUVC6tN5JTU+ujjGOmcih8UjW+I+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1567
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
Cc: kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-06-06 11:42, Alex Deucher wrote:
> Fixes "no previous prototype" warnings.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c         | 8 ++++----
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c         | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
> index 1db61029481b..ed70ae10bdb1 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
> @@ -487,7 +487,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
>  				clk_mgr_base->clks.dispclk_khz / 1000 / 7);
>  }
>  
> -void dcn32_clock_read_ss_info(struct clk_mgr_internal *clk_mgr)
> +static void dcn32_clock_read_ss_info(struct clk_mgr_internal *clk_mgr)
>  {
>  	struct dc_bios *bp = clk_mgr->base.ctx->dc_bios;
>  	int ss_info_num = bp->funcs->get_ss_entry_number(
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
> index 8eeb3b69b5b9..0faa1abd35ba 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
> @@ -662,8 +662,8 @@ void dccg31_init(struct dccg *dccg)
>  	}
>  }
>  
> -void dccg31_otg_add_pixel(struct dccg *dccg,
> -		uint32_t otg_inst)
> +static void dccg31_otg_add_pixel(struct dccg *dccg,
> +				 uint32_t otg_inst)
>  {
>  	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
>  
> @@ -671,8 +671,8 @@ void dccg31_otg_add_pixel(struct dccg *dccg,
>  			OTG_ADD_PIXEL[otg_inst], 1);
>  }
>  
> -void dccg31_otg_drop_pixel(struct dccg *dccg,
> -		uint32_t otg_inst)
> +static void dccg31_otg_drop_pixel(struct dccg *dccg,
> +				  uint32_t otg_inst)
>  {
>  	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
> index 08232d05d894..152a76ad7957 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
> @@ -177,7 +177,7 @@ void dccg32_set_dtbclk_dto(
>  	}
>  }
>  
> -void dccg32_set_valid_pixel_rate(
> +static void dccg32_set_valid_pixel_rate(
>  		struct dccg *dccg,
>  		int ref_dtbclk_khz,
>  		int otg_inst,

