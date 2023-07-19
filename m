Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF0BC001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 19:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15FBB10E037;
	Wed, 19 Jul 2023 19:30:40 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00A1B10E4F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 19:30:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMZVWxKhExQquVCTusRTYOvbzzT7RGY0kn37sNFbN2RnABu7uLTcW1zCiNBnhofub72dJFMzSTiB20JKKD15wD9pcrGqKyJ4W9FfChtUm05xME9rJ7KVRcv2drmSdBJIwvMUhSr7MzY0fIVtKvCqAJMNxDa5Fv5Q1uUwzY9IjD83V3sH/xoCs3JDIKyOE5qhQMU9y2VTJxD+J2vKVJaq5gaMNvOUPirflyyPpEgdjWtv0Sg4Q49kalDQdBQ5RWScJ5Ex0jfen76mS6Y5tYnD0r9H8jr4DmVpbbe7fYpVR/TeBjUrhElHgWzGTkIDvrEvaDIrEvIteNf9vUp1eVYrIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgVVzjd9zm6F+HGeGfzlcJS0xw/upT1vFzqdDjwxfMc=;
 b=B/Booj20vf/5g0abN2YLdSpx6gEarpT/L93G+4IEGwwEDTC4RnQSIjdpXyIKKiWCm/fPzO67/IlvulPnFka9SPY2yPT4EAu1rqt+qsQ9YKGck6beGZ2lEMe83xLiFQ/rMeiA5+K/46Xlg+mNILu/4GoSD8+AyxFkSWeU7uHk8cuXalzPGDYmKNDrGi2p2QiNR9aR+wD1Yq6NG3WBpbcJG7Ah0YhZNeSb1vcs6VUfhyj+vYctnWhm5oncMRYWHazARsCYJFKC8AzqLMV0jzFivHtphcQRaJGKNvGoxNg2GmKGUP/x29NfezV+3edm74nHHXeu7NT+If85hUPgkCiNWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgVVzjd9zm6F+HGeGfzlcJS0xw/upT1vFzqdDjwxfMc=;
 b=DDhJDk4m9wxwiACH18qEcIwHPwzENnz/6s+IhcAfc1fBy3EXYw9bKZmbIct3s7cpL9iUuwv9MorvdV3qr7N33DZFBGehFVcEnr6BkHGUFvp7xpden/SXHfya6hrfcg5TGwB/TWx3NUbYMnz9Xm7E5lpC1tx/oWJ/BbK0dQV8/kk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 19:30:35 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1a2e:ca36:f117:d2b]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1a2e:ca36:f117:d2b%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 19:30:34 +0000
Message-ID: <7da0a432-82c6-07db-aa58-21b0bfce5133@amd.com>
Date: Wed, 19 Jul 2023 15:30:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/10] drm/amd/display: Add Replay supported/enabled checks
Content-Language: en-US
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
 <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
 <20230710192733.1344403-7-Bhawanpreet.Lakha@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230710192733.1344403-7-Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0264.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::25) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|BL1PR12MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf7d7d9-0ad4-49c8-d690-08db888e9f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAKyIhAVA5lYdJ2OFG17UHQ9JISwd00iti9tAVroP5PdlcjIFOoKbXAvAq397eEJtJmCHHiBjsKaFwl9jwoP21xdDlO67xxc8TxU0Jh1ck8yXtXK+CBda1TLsvLiY7ZEnMcoVnrDa/Hes+uzKD2lznLjnTv4SegVW2w5uWXJWSUtsd6wPaGfx7vBUsh/DnjMS/Tus/thxrIqPCgH/MdAd8c8E5KeR5UOqT28uqwsPeqZXZyKo4A8WIycGekOD7OfsMf1mYCJDUq/MYE85xwNKQKadu3kagbB/k0nKwQm56hr8DZeNEF6EAhAd373In1pjTAar6SYLduD/9C3YdBHwaspYfGIFdWooc6ef4fdiaHSf2fmfSzyKgX3ieF37JpPtTdkVuPzCVYb2Dylm5rf0YEOYezYXIT5HBRZRo42oDQ/fz66OyvQSxwD2Ms2WCdnBaQNIQc88/WBs3Pkja/2eK24j27uVScxggNrX0o1nOkm62jDH88G82cejifKWYGTiJsKcSymhKOg3RVZEDNQpVCtujKZ7Tg7pm6AM1lYDD/j/6fe7TPBhjtuj/Jgfw8pZBYtXk1nSyGn53UFoLq5XO1pMKSGHbiObQ1BPNxwdbB8MVYMvUzlDc/nkLqp9AfoOpQa6BTNcjXdsJDEC4SYTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(83380400001)(2616005)(2906002)(38100700002)(66556008)(66946007)(66476007)(316002)(41300700001)(53546011)(6636002)(6506007)(186003)(26005)(31686004)(478600001)(6486002)(6512007)(31696002)(5660300002)(36756003)(8676002)(8936002)(44832011)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUp4V3RheFAwVU1GVUR0N0lQM2ZiL1g0c3R3NDRiSUZSQStDTzdMcjYyTnVw?=
 =?utf-8?B?d2VFMjQ2c0cxellBUFRyM2krbHltTFdFZnNvWktSb2QrZ2JERnVoOFp6SXlD?=
 =?utf-8?B?WVdsZktSWUZab01Zc0lPVkFwQWtBUHJ6L3YwRmV1N29GMHZFdnVqNi8vcGN4?=
 =?utf-8?B?SkdLOUFqakFETXcvSDdvZUhKR0tIR2VVci80WXl6M2pLcXVuL3BhYTdVWUNp?=
 =?utf-8?B?aHBSTjRXak9kU1VyNWV5UEhobFJUaDFSYk5hMmg2OGg0UWVKcU05MUF4R2Rx?=
 =?utf-8?B?d3plZ0Vya0ZoUkN5REkrMzZaaVZPNThsVUVPOEVrTlJNUEhoeDV1Q0VLeURS?=
 =?utf-8?B?Q0g0VktlOGVSSnBXL0tLM2VucXpYd1RKd3dmMHZvb01UYU9EZE16K3NDTWZu?=
 =?utf-8?B?WlNwb3RyUU94MG1aMFNodVE1Z3R2alRFVC8zeG9ncFRGNWYzeTZPeGxCTUMx?=
 =?utf-8?B?eTlCWFNwRTJqQVRVWDdlTEwyNWtFYjI1bkUyZmJNMVhMdDVwNk5CUHBBU1RW?=
 =?utf-8?B?YU91Mkg3dklxNFgvOEZoQ1llb2dxNEk5ZUNSQXp4bzBxeGhvR3FHeGtEY0I5?=
 =?utf-8?B?aTBnSTNIODQvSWhiSitNajFVOTRRK3V3Y1JreUE5ZHNjcWpTNkRySStHZ0s1?=
 =?utf-8?B?WjJUaTZIb0VMSmZMRGVydDEyTENXcHBXMUYrbllEeWM2ankyK1gxTkd1amVa?=
 =?utf-8?B?VHYyY05nWmhiQUlQMTJieHZqc1FycVBjM08vNEVkSDdwekdBYW1yR0Vwd0hz?=
 =?utf-8?B?V3ZYUGpzSG91cTBaeUFOSEVUOWVQdDlPdVlacVZHMWpnZjlpNkRKS0VQcE9T?=
 =?utf-8?B?VnFQaFRNTWF5cFFnUktlcWY0ckx3MUNOS1dOQWdUZlZlRU1GTU5UWFFLbncx?=
 =?utf-8?B?UGk1ZTUxZmYvVTNjQnhTWnBacFg2Q3BTbmhqcVRQK0treHo0ZEgreU1RbElW?=
 =?utf-8?B?TFRRQXZqa2lkUHpkWllHenZnck9sU1ExcFNaWTFXdmVSamhKdHg1M3ZuNVlt?=
 =?utf-8?B?UVd4K2J2OExFd2FjcWR4N0ZvOEpnL0k2L2VGUDdHZGk1eFp2Y09ic3E4UzFD?=
 =?utf-8?B?SXU1NGk1Q1NEaDVvcGRNVjdabW9DOEdNREhDS0RFSERqbzg0YzJId0Via2Ja?=
 =?utf-8?B?WXJ2dGZtSWNhdDZ1dXBaVXV1RmJoYzl4dzgvQ3NORUxzbXR3bzBVVWRGOGg5?=
 =?utf-8?B?cms3ckIvZ3BlMzlzYUFiQzJHVnNjWmIrSVVYanBiNFAzS1BpMHFxencrQjd5?=
 =?utf-8?B?RVBPUk1zWmM0bDVBdDkvZFd1eXpHN3M3WmQ1eDZ5SVVOQXA5bHBXeEhUU1BE?=
 =?utf-8?B?cmJJOVdocWc4WE0vWEpwaXk4N05uVER4VDZVNExHK2U0U2JDeUM3L0l6RTBZ?=
 =?utf-8?B?Y25XVGxzNjNETms2amgyK3g2N2VWMXNOODRMbmZ0WWdFWFU2ckZMaEVjWW5z?=
 =?utf-8?B?NEZMN3VPbmdSUDFpSFBoNk10eDljdmV6cm9obWwrUkhFZ1NVR0pCVmp3VmNw?=
 =?utf-8?B?eDlyR3V1N1ZsbVgyR1ZtSUpVYytPbU11SUxUWlBrOEttelRKVkhJRGxHUEp0?=
 =?utf-8?B?MFFCaFZMZEpMZFNid2c0bHBRcjdrTFZ2OHlPZWpXL0dvV2Vwa2t0RlN0bnJM?=
 =?utf-8?B?Y2VxT1puZUdDYk9MUXV1R3UrajZzc3BPVCtqYU15NFpEdHNWWlVSN29ZdXFD?=
 =?utf-8?B?U2VyaXRFN3RTUHpHekRJUmpRYmwrOVd2OC9YaldvNXVvSlo2TlhqdEh3RFVu?=
 =?utf-8?B?K29TWTVPc1U4Y3JEWllEcGZOeWgzSG82KzF2MXk3R2NoQmdjdENZU0V1M3RF?=
 =?utf-8?B?bGRCOUZValFNY3h0MzJKNVR5N1dLcTVoUlpOTjJLRjdyT1JhdU1ZTS9IZi9l?=
 =?utf-8?B?ZUNCNW1sc011RUNYMmhlSUVGSy9ROUgzSDhSRkQ4L1lXd0FXcWZyclZzNWFI?=
 =?utf-8?B?MG9HWTNNTmdrRFRFK1R3VDkyQUdwSC9pbU9jRnhuL2R0QWluVUJ3ek5uby9F?=
 =?utf-8?B?WmloUTQ3UURWdXNmV0x2aWFXUUN0SytBbVIzMHQ4NnBGcnordEpWNGsyYWM0?=
 =?utf-8?B?ekpEcERNV3I2NkRPWGxieXpxYnZuVWliRk9XLy9nQ2V1QWFGVXd1Y2c2ZnNS?=
 =?utf-8?Q?O5U23IXH+kFL3bwtTkfhKf4//?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf7d7d9-0ad4-49c8-d690-08db888e9f96
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 19:30:34.8767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7ZWGMRnUoZZgoE9uhidqD/Vod2jG2Bz2BHkRr0e5f6pJc4jtPTwjeRbfraXlQeU5lKb2BMJl2rzLV4/yLvn1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
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



On 2023-07-10 15:27, Bhawanpreet Lakha wrote:
> - Add checks for Cursor update and dirty rects (sending updates to dmub)
> - Add checks for dc_notify_vsync, and fbc and subvp
> 
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c                    | 6 ++++++
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                | 3 +++
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 6 ++++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index dd3a9d06c6e2..dccb49e27f35 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3367,6 +3367,9 @@ static bool dc_dmub_should_send_dirty_rect_cmd(struct dc *dc, struct dc_stream_s
>  			&& stream->ctx->dce_version >= DCN_VERSION_3_1)
>  		return true;
>  
> +        if (stream->link->replay_settings.config.replay_supported)
> +                return true;
> +
>  	return false;
>  }
>  
> @@ -5116,6 +5119,9 @@ void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bo
>  	if (link->psr_settings.psr_feature_enabled)
>  		return;
>  
> +        if (link->replay_settings.replay_feature_enabled)
> +                return;

Use tabs, not spaces. I just noticed it here but it's elsewhere in this patch.
Please check the other patches as well.

> +
>  	/*find primary pipe associated with stream*/
>  	for (i = 0; i < MAX_PIPES; i++) {
>  		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> index c52c40b16387..706c49e015f6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -894,6 +894,9 @@ static bool dc_dmub_should_update_cursor_data(struct pipe_ctx *pipe_ctx)
>  		pipe_ctx->stream->ctx->dce_version >= DCN_VERSION_3_1)
>  		return true;
>  
> +	if (pipe_ctx->stream->link->replay_settings.config.replay_supported)
> +                return true;
> +
>  	return false;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index 6c9ca43d1040..16b53a4c5a42 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -1585,6 +1585,8 @@ static enum dc_status apply_single_controller_ctx_to_hw(
>  	 */
>  	if (pipe_ctx->stream->mall_stream_config.type != SUBVP_PHANTOM) {
>  		pipe_ctx->stream->link->psr_settings.psr_feature_enabled = false;
> +		printk("######  %s %d\n",__func__,__LINE__);

stray debug printk

Harry

> +		pipe_ctx->stream->link->replay_settings.replay_feature_enabled = false;
>  	}
>  	return DC_OK;
>  }
> @@ -2013,6 +2015,10 @@ static bool should_enable_fbc(struct dc *dc,
>  	if (pipe_ctx->stream->link->psr_settings.psr_feature_enabled)
>  		return false;
>  
> +	/* Replay should not be enabled */
> +        if (pipe_ctx->stream->link->replay_settings.replay_feature_enabled)
> +                return false;
> +
>  	/* Nothing to compress */
>  	if (!pipe_ctx->plane_state)
>  		return false;

