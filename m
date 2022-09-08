Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26E1C38145
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 09:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4016D10E9E6;
	Thu,  8 Sep 2022 09:18:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 271A810EA03
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 09:18:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+DO0ykMyN7186fnycVrbD5UcSgjFPJIERRT1kFnewEu0Mjd2rN7lD/clrQb4Yl+BSYzdlJGG3JZVaCrPyz3/VzlSSy95f3dRI5Luw9nTo81hinMtPMYAMXTzKDYObslflOGYnyT1riTqwSmlpAmKs2VsQ9usvAR3P/lQqNaro2FBtetMOposMgiu4GnEayA6+KciDNi/SjMiHXwWy3x9QbEiTSvfpWjB8xbSax0cX5ULIwDEh48Nfu7+bqKywum/klKVsMvcGuIpY9tYleFbjJ3r43aum9BIakRb+WXVvEtxqVX5FGFhwe7b2HNKEBAmZclMvfO0HnlJ9bhXqaRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksT2dTS/ka24dVL5OgL80lJFQxDp8R9tmFTbazDVggg=;
 b=XnRE9lBrgO3YQ5rHlydxhRh/xu6kugb93scj7M7xjnHnUzUmcqcg+2V5buH/RMlFuvx4/4aH1aIYY8NQgDJ2eT0piCZIb8t2YAFKzWWmoWfoivp66gqnOQQOIJvVQKaaIPe9hGfG4Z7g3cGe6gE5p1mPmlM9VkclfWFBk1vgtIRbtkG8Bbt8OmzCYfVFa2i+MCGtJeiLf8G0Hi8bUPiV3WTaImLFkicoS/K9V0k6KiywWdG2HdIhZ0RmrF38Add7NwgCBEHw1Optkl3+0fURDc0qxQnLYUwVNKdCWMWUlmYDX77NreSo96hCnD5So6ljTB2ykkmRDuls8KhXbBiX5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksT2dTS/ka24dVL5OgL80lJFQxDp8R9tmFTbazDVggg=;
 b=YtAYy1IbKTk/C5y+7muCPBb44oFDf+qy0yaYWXllX/7tQAR7/UVwETxSsfRRgFdMaJmnMuooBJ4Bn2fouvRCNXKUcsB3czJMBExFfMfGJOFDmNRN3NPyljdF3ITidjrMU0iqXW9of7OpZ58E1SkGjxlnnyKBHCHJkAAvhSv7Nj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 09:18:10 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5612.015; Thu, 8 Sep 2022
 09:18:09 +0000
Message-ID: <7df85e02-daa9-2f23-89a7-06803f8c0a40@amd.com>
Date: Thu, 8 Sep 2022 11:17:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 11/21] drm/amd/display: Round cursor width up for MALL
 allocation
Content-Language: en-US
To: Pavle Kotarac <pavle.kotarac@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
 <20220907181200.54726-11-pavle.kotarac@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220907181200.54726-11-pavle.kotarac@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BY5PR12MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d2cf3f-aa36-4b9f-daa8-08da917b0bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0EdPnRSyMqr9A1XZfWY9xOjlrFwOvTCOfK2LzT62MLKcsK9RT/p6nSZoI9SAkK7fdGFIkVxygWACKHGyKtXMD7aVMyWY+RGBWDjHmWX8LPxfil8m8hVU57MY3JDKcC2vsWf+NvGu6w31dpQX9pJrrfMDZrytP3YIAkzrZl/aJhG3GC2GdKKCu9wubILRkA+FLxBOG4rWBekEFMKAXUZRI5iO+eNcQz7Pw42JNvJgVan3pq0MH6ZwRAK3Ofa4hAdInE6X0OYknHr1FD6rmvCYyfjw+EO7pNuZBuxmNCVIZccMsdjHPiE3M1B8D4+o/aeNNmzHLRo1nZX41g3qc4Oa4joSa7zb4Ax8G5L8P+hSkofpa4uBdtg5IXOCIKE6yumkEmODWEcQ97KlsUyL1cD3oukXuTUnzDsxwJ4O+UXUvhJ08TaNDjkwgisxpJItxxMjR8ERT0zVSJZTRC77dqj9aSyHYGAjG5a4gycSzJwp3u4RqW+lAVCE/2CM5e2Jxqtjhyd0VsxZi6j+k/y/Pk48xoamfVPth2pEYGkrVG4V30odeStPUPmPyPR69NMHnWIXBSOwECvoQ7bqOogwi/OlxOfDOKegiiYnf6vvJsyGzCOHRoDh2wANzPvAVGnmVcAkI7FMnEcIdv6gx0MLfRHaRNewm/CCCV4reR5Gqag3M8cw3Lpy1d4c/6snyd4PfOF2fH/mr8sJNVzVmvWVWJDn3oQDeXiyRyH/6vu1vjReYmJZOhLpwgDG38kxLN2GuMDnx51z6fgPMzOX7YhnbpwteNf04QJH64UlxtAl5mjORM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(83380400001)(54906003)(26005)(6512007)(478600001)(6666004)(316002)(6506007)(36756003)(31686004)(86362001)(31696002)(186003)(66946007)(2616005)(66556008)(66476007)(8676002)(4326008)(5660300002)(2906002)(8936002)(41300700001)(6486002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TldOVDlEd1EzSkM0MC9HV2svMVI0UURxZXVnbDN1Z2lnNVlHUDJWYnVyd3Z3?=
 =?utf-8?B?Uzg2dTVOOG5HanRlMDd0anNIRW84Wk1UWENkMjBQNTZNUFA4ajJpK0NYOEVz?=
 =?utf-8?B?Wno2UGtiZTVGYVREbCs1TUZXdERaUG85QUg4T25KTmpXcFd1Y29BL0FPTWR0?=
 =?utf-8?B?cDBVSGhpL25VZ1RsVHMvYTJRbGlIMWN6V2JhNWIrRDllTEh0MzRSRk9KYkx2?=
 =?utf-8?B?OG9oWlhMWVZockp4M0JqMWdQSyt3Zlp1aXlpYmgvTUZSa29RbnNnVE4rOHFF?=
 =?utf-8?B?dDM0N1JldTU4YmhIbTlaY2MzRVhTdjIwdnpQSUcyU2FoRE5ObVRFb2M4VzE0?=
 =?utf-8?B?aTIxYmZzNFV5c3lHZEM5aGU2Q2FxVHZMVTIvazNxVzRRazJSZ2djTFNWOTZx?=
 =?utf-8?B?d0ZhSGVYVUd4aG9kam9BbGdOVE4yZmhpcDlaQWJ1dElaRXJGSU90cWdmNUlk?=
 =?utf-8?B?NEc2a1lrRGZQcDdXb2Z3a0VFOHRDWFhxUk5qZ3lLZzhWcVBhU2o5VVlpYTlY?=
 =?utf-8?B?YmEzK2NHeUswVjFQUGUzY3BaYS9JQmhKM3JFUThxYnZDMzBnUDJ3bjZiWFF2?=
 =?utf-8?B?K2Y3WmFOZFFRaEl4SVgzMXQwNTFkTzI0cmFnYmsxNGZ5ejhTK0ZyN1hiWDV4?=
 =?utf-8?B?ZmttSWxtNjcwNytJVVlnMFBqcVFJWGd2Mzg5ZHZIZkxod1pWT2RZN1dPZmRw?=
 =?utf-8?B?UEpqa0VTNmR6Qi9uNG9TaDI1QWlsdHQxR1VwT0tjYVJMMGJxdjBvRVlJZEJI?=
 =?utf-8?B?cTZzQnFLQUZaSUp1Y01kM2NtUkFwTGp6ZVZVMk5FR1BhamNTQWY2QTZscU80?=
 =?utf-8?B?KzNON1hrVExFaEFxQzRzMCt6YWxtWHBmc09RVjU4RUxkc1hkdjRPK0lhWllw?=
 =?utf-8?B?WEVqd1lqTGMvQXJHY1h6R1JBV1FPVFYxbHpJM0lndWV5c0h4SzlPV0UreEZM?=
 =?utf-8?B?NStmaXpwcXRaaVFQMFRKd1I3OVZtRFkrU3NzVEsrTStZNElmZGRSSVo3OU81?=
 =?utf-8?B?RHhOeDU2Z0JUWWJoRVFWT2hHRGxTeC83UlpOMnFTYTNzYlZLa0ZFMitXRWpV?=
 =?utf-8?B?L2RaSUFHOVJBdUx5eEtmNDkzTUZodEtTQytRbWQ1Mi9EYXNjU2Uwb1k1WndC?=
 =?utf-8?B?bnl0cml6czdpUTBUbEdMUTlwZlIwblVhWGhGNGo3UU9neDR4UC9TMkNmZ1dS?=
 =?utf-8?B?c2xjc3hnZDBKeUNrZVBrYjM5TWs3OWUyOUtpbzRwSHJzWDNQV2xzQ0taTVIr?=
 =?utf-8?B?QUsvaHNsVkhaK3htYzF4MFU1aitDSS8wZXRQSEdmcnNlQ0YzanRxbCtURzBx?=
 =?utf-8?B?cXJWeVBwS1ZUT0dPeVJxeHBrUVBSbGVwNlVDSnhTTFlWVS91ckxHWWE1R0dC?=
 =?utf-8?B?L1d2MTdBRTZhL3V3bUNQdjd5NHJoSCtNbUFxU2xQbTJqdkJ0eHhlQTJZWnc1?=
 =?utf-8?B?MzZjVnZLcmg5Q0RsYi90Y1hHZTZjSE91UWIvYklUa1cwRFl2QWg4bjhZb0hw?=
 =?utf-8?B?djBqd052TEQ2eGdLT25JM1Z1Y1B4MGtvU0xaL0RDbzJ1bFVEaVA3UVBZZjAx?=
 =?utf-8?B?SEV5NGgxV3JFc1hYZ3l1QTdhUlpRS0pIQW9mQjJDaHdCOUhsM2dnVzRBeW9P?=
 =?utf-8?B?a01HWjZCczI3MlUrcFpDWllPdWxVQVErVXYzQ0tuckdaQXIrR0tNbFM4TVow?=
 =?utf-8?B?eEs2K0wrMmJ1U25XRVVOaldwbTN2WkpGU2tzeTBiUzBPYWFUd0YxcWVHSzN0?=
 =?utf-8?B?eDFETitSSXNXcXI3L2lXaWF0T01HeHVRdE9uVHpzalRtRjlCb3pQR3EvUld0?=
 =?utf-8?B?c1NKczZkdVJUeklsTmhQbms0VTRnRG4rMjJMaGhmQmIxaGx1STdKL2IwbHV4?=
 =?utf-8?B?aDdPdnQ4UXJNbk9OZVFkdkNNeGdheDNhc253eGgzQmkvZUxTdVZ3b3AyOGxw?=
 =?utf-8?B?cC9rQ2pRdWlDTlF5TXd4N1VaL2hLZFppVFpLMlJtZHFRMnFDemU1djZGTnJV?=
 =?utf-8?B?YXZGMmVtZEtRbEZMa0wwRjF3K3lpdDdGSzJIem8yOTlPNWpCNjRtbVlyN3Zz?=
 =?utf-8?B?MklmMENoT1c4bU9Wc3ZsMFkyMkdJc1RvQ1dYd1o2ajZVMUtUbHlvNGNnMVB4?=
 =?utf-8?Q?Ci3dnIMSuJuXDJpbXtHBewPE2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d2cf3f-aa36-4b9f-daa8-08da917b0bfa
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 09:18:09.7621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9i8ylNslv0gykAVJh0Vimh3Z7Ls45l/fmJ127ibg/gU6kBbaaHVZCsEpRB+gBMc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Taimur Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 07.09.22 um 20:11 schrieb Pavle Kotarac:
> From: Taimur Hassan <Syed.Hassan@amd.com>
>
> [Why & How]
> When calculating cursor size for MALL allocation, the cursor width should
> be the actual width rounded up to 64 alignment. Additionally, the bit
> depth should vary depending on color format.
>
> Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
> Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
> Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
> ---
>   .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c | 24 ++++++++++++++++++-
>   .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 24 ++++++++++++++++++-
>   2 files changed, 46 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
> index 6ec1c52535b9..2038cbda33f7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
> @@ -103,6 +103,11 @@ void hubp32_cursor_set_attributes(
>   	enum cursor_lines_per_chunk lpc = hubp2_get_lines_per_chunk(
>   			attr->width, attr->color_format);
>   
> +	//Round cursor width up to next multiple of 64

Please no // style comments in kernel code.

Regards,
Christian.

> +	uint32_t cursor_width = ((attr->width + 63) / 64) * 64;
> +	uint32_t cursor_height = attr->height;
> +	uint32_t cursor_size = cursor_width * cursor_height;
> +
>   	hubp->curs_attr = *attr;
>   
>   	REG_UPDATE(CURSOR_SURFACE_ADDRESS_HIGH,
> @@ -126,7 +131,24 @@ void hubp32_cursor_set_attributes(
>   			 /* used to shift the cursor chunk request deadline */
>   			CURSOR0_CHUNK_HDL_ADJUST, 3);
>   
> -	if (attr->width * attr->height * 4 > 16384)
> +	switch (attr->color_format) {
> +	case CURSOR_MODE_MONO:
> +		cursor_size /= 2;
> +		break;
> +	case CURSOR_MODE_COLOR_1BIT_AND:
> +	case CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA:
> +	case CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA:
> +		cursor_size *= 4;
> +		break;
> +
> +	case CURSOR_MODE_COLOR_64BIT_FP_PRE_MULTIPLIED:
> +	case CURSOR_MODE_COLOR_64BIT_FP_UN_PRE_MULTIPLIED:
> +	default:
> +		cursor_size *= 8;
> +		break;
> +	}
> +
> +	if (cursor_size > 16384)
>   		REG_UPDATE(DCHUBP_MALL_CONFIG, USE_MALL_FOR_CURSOR, true);
>   	else
>   		REG_UPDATE(DCHUBP_MALL_CONFIG, USE_MALL_FOR_CURSOR, false);
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> index 769171ab8ef6..dbf2d7cc96c5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> @@ -741,7 +741,29 @@ void dcn32_update_mall_sel(struct dc *dc, struct dc_state *context)
>   		struct hubp *hubp = pipe->plane_res.hubp;
>   
>   		if (pipe->stream && pipe->plane_state && hubp && hubp->funcs->hubp_update_mall_sel) {
> -			if (hubp->curs_attr.width * hubp->curs_attr.height * 4 > 16384)
> +			//Round cursor width up to next multiple of 64
> +			int cursor_width = ((hubp->curs_attr.width + 63) / 64) * 64;
> +			int cursor_height = hubp->curs_attr.height;
> +			int cursor_size = cursor_width * cursor_height;
> +
> +			switch (hubp->curs_attr.color_format) {
> +			case CURSOR_MODE_MONO:
> +				cursor_size /= 2;
> +				break;
> +			case CURSOR_MODE_COLOR_1BIT_AND:
> +			case CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA:
> +			case CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA:
> +				cursor_size *= 4;
> +				break;
> +
> +			case CURSOR_MODE_COLOR_64BIT_FP_PRE_MULTIPLIED:
> +			case CURSOR_MODE_COLOR_64BIT_FP_UN_PRE_MULTIPLIED:
> +			default:
> +				cursor_size *= 8;
> +				break;
> +			}
> +
> +			if (cursor_size > 16384)
>   				cache_cursor = true;
>   
>   			if (pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {

