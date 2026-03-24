Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C300FEC0FC
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FBE410E072;
	Tue, 24 Mar 2026 21:13:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FrkiQwyT";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 767D510E072
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:13:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqQZP8EA53YBYdemebyDKSjJnsm3g+O+04oAtjsuiphYRorDl2gPV3fe8LiQ/ElwBJ4bZUUaAK0B+5jIkA7dqlRHgWJH8cW5BZNdXpD2wyNhz3wUzcRVRw22fenLzM0Mmc9F6T7RSLi4t3hMXCxPWypAA9sXsuduVSuhyUibVLMKDVdDUfY+96z9yINYBm/JIHCe0hChisK1fAxJ9LbdAazGSifUdCzmcAT5F7ZQgR+mZk9u6gloP0E6TPi/KKb27QAW/JVpQhW/5OQ+0bzE/1HTA8fl8Zr9LE6KXo7hWtte2JZmTV/4ZnkwhYrF/iz0meZ1Fq3hn54GJvXoCaU2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2tpJAgLj9m/VViDUhKydV5ab3awUO05pbOixOMuNP4=;
 b=bT5eoll6zqr+zT5enVBekNTRf1R4ivgUX/gFJ8cEOECn2QlNCsiBMwEFuChxJVmZOJjzbMPZKSXnUziRpIgxl585h1ra1INvKh/N8w4rLuQWxa/kuz4zUGs5otlLMi2DrhKof0G8Opz96bs3+FbZSvebk8pSwHd0HiM+9qM0Cbjlc3QjksZav3lcaLbcmQzYIR/1Tdwch54DDdxUDoAlHtNhvrnQglwpUbszxagpJoaNSUJz7v9gQvk6ZRxujuX5XqxkdrY3mLtmXc+7CqNThiiBiDqHMIshZvde8oBdQdrhtEqJWhNvzkYbfGAggF1fWODxIQXdhom8yelI4u4QOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2tpJAgLj9m/VViDUhKydV5ab3awUO05pbOixOMuNP4=;
 b=FrkiQwyT3GnnwjsdmAGQ586/J5HEcAudmq5SbPuc4T7EBByD06kPkF7PlusY57XfgmFuqSRMOChW0W4XehNncGMBWLNUGhAGjQcUqBh3tWqmDRjqFp9XHzzC0Cm10+jYM/NkUiTrvBZbSY7xxefpfFYQS6YcgRUdiFqj15c07v4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by CY5PR12MB6623.namprd12.prod.outlook.com (2603:10b6:930:41::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:13:52 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 21:13:51 +0000
Message-ID: <105991f8-ec51-4ae9-8fa9-edd9b78b6539@amd.com>
Date: Tue, 24 Mar 2026 17:13:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Dither when plane bpc is higher than
 output bpc
To: amd-gfx@lists.freedesktop.org
Cc: "Kovac, Krunoslav" <Krunoslav.Kovac@amd.com>,
 "Hung, Alex" <Alex.Hung@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Mario Kleiner <mario.kleiner.de@gmail.com>
References: <CAEsyxyiCN6KmyDBGZBJYKv+wt6w6j5QdUfTa1zJojAQ20V84xg@mail.gmail.com>
 <20260324210447.541630-2-harry.wentland@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260324210447.541630-2-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::14) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|CY5PR12MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: fa8ecb24-9e62-47f5-76a5-08de89ea3fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: +K1ltfbRkfjbEjEfCY/RzQKppNSjr4jtpEjVhyJH1a2Gn0HgUahHZUgC1FzP+uaUxtswZFEh5+7fCnUHjozFWS3rcoc88Sl1558tgTzsCWef+r+7gcZuvMoTwUPbmrbjJI/BMQIYlxVTGkdKI8tnX8esMO7Yadfk9nhsm6Sy6Vuvx1DI+thGJjGb7i6Z7J0EZp6KbnNs2iPc2NcSVfkghYXgCHNQZE+nsUtU/9TYA5kHYnPGXGWeM3rrLWBBM+7N4+jVes/e/2QX4STFHvDgLyt/UmZg5c96kAkGG+VE62aq+CaXiTjTntlUGX79Xkf89zEST5wYYb2h32s91wKjTT69ubV3DhXpPMauHQWnMXyGfu0+9DD/HEh4q9KVghcbWWnNPo0vSBDElltSgPo8CSv1usGPr51euNaMRsz/tX4dqeYA3x03HFRE8kIf8P+rXgbxTp3SUl7PFcr33fQ554JO28Aj12qQc31W6hbl1Kcj8Dc+UgMorAPAFucKtVV1AJ5UMqjTv1CWL/mH86CRdwOdAMZNiLyjStA7FNMg/cJqrNlJGdd5My3Ap1cY87PGwdcYjFW2Y+6UWtF0ujgs6+o6gr2q7AsxaTn/Gi/JnfxiEHJeSO8hnOX6oMxtvDNwwbYPkcT09rOedX2AnsFa7dhsNn5VOtDDm1JzZaLpnOrJNYPLCOqTrYY5PkllTlYch6t3B1+83LN0mFt/MHL/ixVoFA/q5QXlrP48UPR8Xjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm1vZE02VThwZytyaUoreGVZeUdoWURWYTgxTXozMjFYckdwL0FscTNoc1NN?=
 =?utf-8?B?VXQ3dDgyTlg3ZVcxcUwyUzVFQU1CSWxHREZQcTJZZ1hDSEZRV1A3UGRRMlcz?=
 =?utf-8?B?bzFSb1ZLdWJ2MXBGS1FsQ1F5R25QMzZjRnlscnFQWXdtNHJocDhKOWtiVXJt?=
 =?utf-8?B?azhtb3dwSVFqdk91MUhIMTh0dXA2clhrRlI2cTlaM094R2NwTzgzcnI4NkRJ?=
 =?utf-8?B?L0V4NEp0SUxhalFHZFBST0tRa08zcXZCM3JzTHVoUU02RVRGdGp3YU9tdnFO?=
 =?utf-8?B?UG5zZ3N3SXhqWHQ0RnRFRVIzcHZpRE5STHBERVZxbkNvZmpXQlZzQlZiZUJs?=
 =?utf-8?B?Z0R4UmZOMDJHMGxwcWc3ZkdUWlNRaURMbTRTMFlVVnNzZk9PWUp1UTR5Vlhj?=
 =?utf-8?B?TVBhK29pbmx3L1M4aE95cFVhaGRKSFBoengyS1Ixdi94ZFlNK3RWeE5jbkJy?=
 =?utf-8?B?M2V3MkhWd3k0SXBnNzQvWWQ1SHFUbTRmZjU3RzIxYVR6TksvZUFaVitEMGEr?=
 =?utf-8?B?TzRVRGZuNEZmMUVGODRnRFFzTmQzOUpEb3Juc3FOV09CWTNJbUJ3eE5pRnFO?=
 =?utf-8?B?TFkrVHFPTytob1cvUDRoaG1jWFMwdncvWkEwclRUaEk1REFBNGI0bHd6N1hx?=
 =?utf-8?B?SGxlVE04SVRwNysyc3VYZUFVaEdWaUFwMnhBZk1OOHNPNVYzeUE3b0c0YjhT?=
 =?utf-8?B?L09RclhrTzhzMEt4MFVTZzR1dVpHNW8yL3RXM0Nuc3VEMWEvRUJMbkg1OXIr?=
 =?utf-8?B?Wk5jSzNpM2hFWjM3L3Y5bEI1Uk5sM1FlUUhxVUNCR1V1b1hpbkpNTUZSS1lY?=
 =?utf-8?B?YjIrSThxb1VYWWE0YXhSRkE1S1NDTGg3ajFNM0gwSndLWHh6eW1wVEdDZjVt?=
 =?utf-8?B?ZkpUMEdEeWYxZEFkK2VlNjVjd2FmT0puWmhOSjkxMzdRdEIxaTJqQVEvYTlY?=
 =?utf-8?B?aEtxYnlTZzcrOFFKL1dFTFJmVTR5NmxEUFBidWFtdHNwYXpnK3V3Wi9YVElI?=
 =?utf-8?B?VlIvY21pVThaclIwMkcyTDdIRTBlaktZbHVnRUl6ZyszN0JmMjVMbTEzem15?=
 =?utf-8?B?czVZUG9EVUZDVjFqRCsxZ3F6Q01tQU9TaWl4TkZ3aG8xKytzTFNveGo0Nmp5?=
 =?utf-8?B?WllRSmVBdE5udjMySXdpa1FvZjBpeGsxS0R1SU9KZ2ZlNHVEQUZaeFdocTRu?=
 =?utf-8?B?OHRUeEJEeUgrcWhGTzVKMk9CYklVNEpWdjBtdjZNanhkcWNkRnhTYmRkWVpH?=
 =?utf-8?B?S01uOG0weGkrcVg5N2xyQk4vQzdtekFlc2ZQT0hERDdFYnd4Tm0xczlkUUVh?=
 =?utf-8?B?eWtUMjdCY25nUzFOL1VJTzZqQ2RCQm5wWnJxZWhyb2JCM1hHNldRa1lvWmQ2?=
 =?utf-8?B?dUxzWFJDL2Nsak9ncGN2dkZaWkQwY0JvRkJHRUl0Sko1N0w0YmJLb0pqQ29m?=
 =?utf-8?B?bmhCcEwvZmJqS0VNTnFXS1ZYUC9qQzFsdkp1RWE4ZEw5bjJRckJhYkE1bmZG?=
 =?utf-8?B?RjRMQkszTUxWNU5hcytLY0ZjNTBFcjZJQ2l1SnpwZjlFaXJPak9QRU00SkxZ?=
 =?utf-8?B?MzJteVpueTlTZVVNazZ0Vm9jd0Yyb0ttMlR4LzNpdndHRXk4Y2l2amMxTnZF?=
 =?utf-8?B?Rm9oU3pjQnYwcjAzYUl1cWFpVWVtTU9qbGJHc0xKaFo2c0k4MllQcjhkblNO?=
 =?utf-8?B?ay9oQnFoMHVGczEvdUM0TzBoNFdUOVc0MzNDa3hYNTI1YmViWVVhOS9hblU3?=
 =?utf-8?B?OHhDMlJ0dFR0MWFiU21uZ1A1eWIzVXIrZG4wdFJoSnNsOFhGSDY3MXY1Y1F6?=
 =?utf-8?B?VHplRE5uNmxUa2F4OTBCanQwUVRIWHR1MnA2TWVwV2hqbFNoa2FaQzdYNkI0?=
 =?utf-8?B?NFVmMzFJWUlOQ0RodDBrMlNYMHZjWFF3U3VIdUlaT2t4eG9UUUFsbTdkSXFR?=
 =?utf-8?B?QWxwdi84dTJ6S1ZJcGlDWnVJNUVwQk5YQnNKWEZaZXF0TWsya3k3NEZrazM5?=
 =?utf-8?B?Vnk1YW1zTUFPeVZEUzBsZzZQckZtcnFObVgydVNOUnlGUmpGTnBuV21IdTVw?=
 =?utf-8?B?UWw1MlJ5aFNVZ01FWDJNQldjR3ByS1E5NllaYVhUOUxiQzZPY2FkZW9KNHNi?=
 =?utf-8?B?eFRIN240UVVXeXBhZVF6WEdrVHhyY2liWTI4OXZNTjVMTHRYcGNhTDVFck5q?=
 =?utf-8?B?QlppSTA4SHlVeS9QbGxyTCtLeWIzdFlkSGJCSjlnOUtSSytlSnNURGp4WUc3?=
 =?utf-8?B?STRyOUNWaG42SW0rTHk5QkdETHpRYnptY1pSVnpRanlmMktNK0tCV2w2cExp?=
 =?utf-8?B?NVJFK0ExUk1pTHVyVjlvK0FkM1FlNUczcjZkaGIydlVjV2xuL00zUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8ecb24-9e62-47f5-76a5-08de89ea3fb5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:13:51.8613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvU4CNmpGr6X9g+1Iv3Ujl46dMSlXCJ8h1Tett7R+OfM890t++SATOtYFWBIEvt2/wOsQtq8DUcoANK6XQsb1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6623
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

On 2026-03-24 17:04, Harry Wentland wrote:
> We don't want to dither when a 10bpc buffer is output on a 10bpc
> connection as we'd get off-by-one errors. But we do want to dither
> if we have planes with a higher bit depth.
> 
> In order to solve this, look at all planes, and pick TRUN dither
> when input bit depth doesn't exceed output bit depth, otherwise
> pick SPATIAL.
> 

Forgot to add, for completeness:

Assisted-by: Claude:claude-sonnet-4.6

Harry

> Cc: Kovac, Krunoslav <Krunoslav.Kovac@amd.com>
> Cc: Hung, Alex <Alex.Hung@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Reported-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
> 
> Mario, Kruno,
> 
> this patch looks at planes and picks dither based on the max
> bit depth of all planes on the stream. Would this work for
> both of you?
> 
> I've only made sure my Rembrandt system boots with this but
> haven't been able to confirm that the correct dither mode is
> selected.
> 
> Harry
> 
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |   5 +-
>  .../drm/amd/display/dc/core/dc_hw_sequencer.c |   3 +-
>  .../gpu/drm/amd/display/dc/core/dc_resource.c | 110 +++++++++++++++++-
>  drivers/gpu/drm/amd/display/dc/inc/resource.h |   3 +-
>  .../display/dc/link/accessories/link_dp_cts.c |   3 +-
>  .../dc/resource/dce110/dce110_resource.c      |   3 +-
>  .../dc/resource/dcn10/dcn10_resource.c        |   3 +-
>  .../dc/resource/dcn20/dcn20_resource.c        |   3 +-
>  8 files changed, 122 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 8b21816cf7c8..56d6f9d2fcca 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -788,7 +788,7 @@ void dc_stream_set_dither_option(struct dc_stream_state *stream,
>  	stream->dither_option = option;
>  
>  	memset(&params, 0, sizeof(params));
> -	resource_build_bit_depth_reduction_params(stream, &params);
> +	resource_build_bit_depth_reduction_params(stream, &params, stream->ctx->dc);
>  	stream->bit_depth_params = params;
>  
>  	if (pipes->plane_res.xfm &&
> @@ -3841,7 +3841,8 @@ static void commit_planes_do_stream_update(struct dc *dc,
>  			if (stream_update->dither_option) {
>  				struct pipe_ctx *odm_pipe = pipe_ctx->next_odm_pipe;
>  				resource_build_bit_depth_reduction_params(pipe_ctx->stream,
> -									&pipe_ctx->stream->bit_depth_params);
> +									&pipe_ctx->stream->bit_depth_params,
> +									pipe_ctx->stream->ctx->dc);
>  				pipe_ctx->stream_res.opp->funcs->opp_program_fmt(pipe_ctx->stream_res.opp,
>  						&stream->bit_depth_params,
>  						&stream->clamping);
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> index 5b3695e72e19..a042b31b57ba 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> @@ -2485,7 +2485,8 @@ void hwss_opp_program_bit_depth_reduction(union block_sequence_params *params)
>  	if (use_default_params)
>  		memset(&bit_depth_params, 0, sizeof(bit_depth_params));
>  	else
> -		resource_build_bit_depth_reduction_params(pipe_ctx->stream, &bit_depth_params);
> +		resource_build_bit_depth_reduction_params(pipe_ctx->stream,
> +			&bit_depth_params, pipe_ctx->stream->ctx->dc);
>  
>  	if (opp->funcs->opp_program_bit_depth_reduction)
>  		opp->funcs->opp_program_bit_depth_reduction(opp, &bit_depth_params);
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index 8271b12c1a66..10b7e14ef66f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -5037,25 +5037,129 @@ bool pipe_need_reprogram(
>  	return false;
>  }
>  
> +/**
> + * get_bit_depth_from_surface_pixel_format - Get effective bit depth from surface format
> + * @format: Surface pixel format
> + *
> + * Returns the effective bit depth per channel for the given surface format.
> + * This is used to determine if input precision is higher than output precision
> + * for dithering decisions.
> + *
> + * Return: Bits per channel (6, 8, 10, 12, or 16)
> + */
> +static unsigned int get_bit_depth_from_surface_pixel_format(enum surface_pixel_format format)
> +{
> +	switch (format) {
> +	case SURFACE_PIXEL_FORMAT_GRPH_PALETA_256_COLORS:
> +		return 8;
> +	case SURFACE_PIXEL_FORMAT_GRPH_ARGB1555:
> +		return 5; /* 5 bits per channel */
> +	case SURFACE_PIXEL_FORMAT_GRPH_RGB565:
> +		return 6;
> +	case SURFACE_PIXEL_FORMAT_GRPH_ARGB8888:
> +	case SURFACE_PIXEL_FORMAT_GRPH_ABGR8888:
> +	case SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr:
> +	case SURFACE_PIXEL_FORMAT_VIDEO_420_YCrCb:
> +		return 8;
> +	case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
> +	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
> +	case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010_XR_BIAS:
> +	case SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCbCr:
> +	case SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb:
> +		return 10;
> +	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
> +	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616:
> +		return 16; /* 16-bit fixed point */
> +	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F:
> +	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F:
> +		return 16; /* FP16 has higher effective precision */
> +	case SURFACE_PIXEL_FORMAT_GRPH_RGBE:
> +	case SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA:
> +		return 8; /* 8-bit mantissa per channel */
> +	default:
> +		return 8;
> +	}
> +}
> +
> +/**
> + * get_max_input_bpc_for_stream - Get maximum input plane bit depth for a stream
> + * @dc: DC context
> + * @stream: The stream to check
> + *
> + * Iterate through all pipes in the current DC state to find planes attached
> + * to this stream, and return the maximum bit depth across all those planes.
> + * This is used to determine if spatial dithering (for higher precision inputs
> + * like FP16/RGBA16) or rounding (for bit-accurate matching precision like
> + * RGB10->10bpc) should be used.
> + *
> + * Returns: Maximum bits per channel across all planes for this stream,
> + *          or 0 if no planes found or no current state.
> + */
> +static unsigned int get_max_input_bpc_for_stream(const struct dc *dc,
> +						 struct dc_stream_state *stream)
> +{
> +	unsigned int max_bpc = 0;
> +	int i;
> +
> +	if (!dc || !dc->current_state || !stream)
> +		return 0;
> +
> +	/* Iterate through all pipes to find planes for this stream */
> +	for (i = 0; i < MAX_PIPES; i++) {
> +		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
> +		unsigned int plane_bpc;
> +
> +		if (!pipe->plane_state || pipe->stream != stream)
> +			continue;
> +
> +		plane_bpc = get_bit_depth_from_surface_pixel_format(
> +				pipe->plane_state->format);
> +
> +		if (plane_bpc > max_bpc)
> +			max_bpc = plane_bpc;
> +	}
> +
> +	return max_bpc;
> +}
> +
>  void resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
> -		struct bit_depth_reduction_params *fmt_bit_depth)
> +		struct bit_depth_reduction_params *fmt_bit_depth,
> +		const struct dc *dc)
>  {
>  	enum dc_dither_option option = stream->dither_option;
>  	enum dc_pixel_encoding pixel_encoding =
>  			stream->timing.pixel_encoding;
> +	unsigned int max_plane_bpp;
>  
>  	memset(fmt_bit_depth, 0, sizeof(*fmt_bit_depth));
>  
> +	/* Get max input bpc from planes attached to this stream */
> +	max_plane_bpp = get_max_input_bpc_for_stream(dc, stream);
> +
>  	if (option == DITHER_OPTION_DEFAULT) {
>  		switch (stream->timing.display_color_depth) {
>  		case COLOR_DEPTH_666:
>  			option = DITHER_OPTION_SPATIAL6;
>  			break;
>  		case COLOR_DEPTH_888:
> -			option = DITHER_OPTION_SPATIAL8;
> +			/* Use spatial dithering if we don't know plane bpp (0) or
> +			 * if plane precision > output precision, otherwise use
> +			 * rounding/truncation for bit accuracy.
> +			 */
> +			if (max_plane_bpp == 0 || max_plane_bpp > 8)
> +				option = DITHER_OPTION_SPATIAL8;
> +			else
> +				option = DITHER_OPTION_TRUN8;
>  			break;
>  		case COLOR_DEPTH_101010:
> -			option = DITHER_OPTION_TRUN10;
> +			/* Use spatial dithering if we don't know plane bpp (0) or
> +			 * if plane precision > output precision, otherwise use
> +			 * rounding for bit accuracy.
> +			 */
> +			if (max_plane_bpp == 0 || max_plane_bpp > 10)
> +				option = DITHER_OPTION_SPATIAL10;
> +			else
> +				option = DITHER_OPTION_TRUN10;
>  			break;
>  		default:
>  			option = DITHER_OPTION_DISABLE;
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
> index cecd3282a29f..2d040e735521 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
> @@ -591,7 +591,8 @@ bool pipe_need_reprogram(
>  		struct pipe_ctx *pipe_ctx);
>  
>  void resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
> -		struct bit_depth_reduction_params *fmt_bit_depth);
> +		struct bit_depth_reduction_params *fmt_bit_depth,
> +		const struct dc *dc);
>  
>  void update_audio_usage(
>  		struct resource_context *res_ctx,
> diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
> index 693d852b1c40..377e02095867 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
> @@ -543,7 +543,8 @@ static void set_crtc_test_pattern(struct dc_link *link,
>  	case DP_TEST_PATTERN_VIDEO_MODE:
>  	{
>  		/* restore bitdepth reduction */
> -		resource_build_bit_depth_reduction_params(pipe_ctx->stream, &params);
> +		resource_build_bit_depth_reduction_params(pipe_ctx->stream, &params,
> +			pipe_ctx->stream->ctx->dc);
>  		pipe_ctx->stream->bit_depth_params = params;
>  		if (pipe_ctx->stream_res.tg->funcs->set_test_pattern) {
>  			opp->funcs->opp_program_bit_depth_reduction(opp, &params);
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
> index 7c09825cd9bd..6433f48e9158 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
> @@ -928,7 +928,8 @@ void dce110_resource_build_pipe_hw_param(struct pipe_ctx *pipe_ctx)
>  		&pipe_ctx->stream_res.pix_clk_params,
>  		&pipe_ctx->pll_settings);
>  	resource_build_bit_depth_reduction_params(pipe_ctx->stream,
> -			&pipe_ctx->stream->bit_depth_params);
> +			&pipe_ctx->stream->bit_depth_params,
> +			pipe_ctx->stream->ctx->dc);
>  	pipe_ctx->stream->clamping.pixel_encoding = pipe_ctx->stream->timing.pixel_encoding;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
> index 9c1a57a1f989..6cd16b64baae 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
> @@ -1042,7 +1042,8 @@ static void build_pipe_hw_param(struct pipe_ctx *pipe_ctx)
>  	pipe_ctx->stream->clamping.pixel_encoding = pipe_ctx->stream->timing.pixel_encoding;
>  
>  	resource_build_bit_depth_reduction_params(pipe_ctx->stream,
> -					&pipe_ctx->stream->bit_depth_params);
> +					&pipe_ctx->stream->bit_depth_params,
> +					pipe_ctx->stream->ctx->dc);
>  	build_clamping_params(pipe_ctx->stream);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> index b28e877fb99d..f2786bfc87c1 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> @@ -1302,7 +1302,8 @@ static enum dc_status build_pipe_hw_param(struct pipe_ctx *pipe_ctx)
>  	pipe_ctx->stream->clamping.pixel_encoding = pipe_ctx->stream->timing.pixel_encoding;
>  
>  	resource_build_bit_depth_reduction_params(pipe_ctx->stream,
> -					&pipe_ctx->stream->bit_depth_params);
> +					&pipe_ctx->stream->bit_depth_params,
> +					pipe_ctx->stream->ctx->dc);
>  	build_clamping_params(pipe_ctx->stream);
>  
>  	return DC_OK;

