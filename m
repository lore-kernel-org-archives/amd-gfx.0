Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EA3C35240
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 18:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F243A20661
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 18:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UF3Vd6UJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F243A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B066FA1B;
	Thu, 30 Jan 2020 18:51:44 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CBAA6FA1B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 18:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuV1pybdNemxjTh6gsbhCK66uHXNFtPZnxfbiJKf8S9MvW6k4wOioROP2AFkqH6nQi9bFE/+jtR8tY5cIPJhWni363yzhDdxIwIAp0QLU4VieFrxWKp807+oIM04LvVHUg3V1Kc9o0WOpeZULazZj7o3BvN89X+U2XyzK16URpCwuASN76UwCvPaunyMxwrW3zmBqf1ZfXMYQ0+do1cA35qMZVuqtvnerOAUYeeV6ygbcXoLwtgqw4gSF0P6F5TLAWIOCKoiSt7Q5Co6WsEmLJn08cD9bBbpxKmEfV4Yu6wxwiYnj4f/HjsODjf4ItFefAk+W0C1xyr0DDvIGRT48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuXzJzcOkWDDg8f0b/2DDz2Si03CtcF1vcxB15s/89M=;
 b=HvvQgA21VRgeqOoFKHDmiHznqlx8sQIrdZTf1LGDwtGJ8OEkwSnm+HP8TL3a2+CCMeKivOePa+1DoGPLZBriFd3YP3uixfiwQkCsIcxYsQ/+OcRfc5JFC5DqJYcr1ST+k/p2w7c/T0i6vbXGSl7RiIKjQ1MFwjy//8NuwNDcGdlP1OYxjcAAJH10Yn213yRdikeHzqjxufX/EDzYd+2Ou1ofqBWyGf7hnXxfZELpv2HGNJd5qqqSJhWv4HSiOJLBOC6taEvfrBBnZlAXsoEWqVSPq+b1av9CJwuQv8+yq5l8nakmVZxyLY4odhDX2QAqf0z4peOgiuQU/k6XyPSnTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuXzJzcOkWDDg8f0b/2DDz2Si03CtcF1vcxB15s/89M=;
 b=UF3Vd6UJ6OlJgTaohuz/aDdp9TWA+LDkU0ZJPWESP5aw2Rbjw89WGWe2WRlg18Xwi8RnuvjZFLyzKeJheConJqxwhX0Y5fbDqKaSZ0ok0Elm3sj/rSJWBmFF4udZkXWH6z6PGPtqqQfNjetkgxGUvknHiMyy2WPFYgBcv5wWp+8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0056.namprd12.prod.outlook.com (10.172.78.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Thu, 30 Jan 2020 18:51:41 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f%9]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 18:51:40 +0000
Subject: Re: [PATCH] drm/amd/display: Only enable cursor on pipes that need it
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200130182905.28249-1-nicholas.kazlauskas@amd.com>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <b69c62a0-7969-e09f-e1b0-c942decd1c0a@amd.com>
Date: Thu, 30 Jan 2020 13:51:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <20200130182905.28249-1-nicholas.kazlauskas@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR19CA0080.namprd19.prod.outlook.com
 (2603:10b6:404:133::18) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:9240:e3a::2] (2607:fea8:9240:e3a::2) by
 BN6PR19CA0080.namprd19.prod.outlook.com (2603:10b6:404:133::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend
 Transport; Thu, 30 Jan 2020 18:51:39 +0000
X-Originating-IP: [2607:fea8:9240:e3a::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1adb89cd-0bc6-492c-adc4-08d7a5b57100
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0056:|CY4PR1201MB0056:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0056E12119F0B2529A7497778C040@CY4PR1201MB0056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(199004)(189003)(316002)(36756003)(2616005)(5660300002)(478600001)(6486002)(2906002)(31686004)(66556008)(66476007)(8676002)(81156014)(81166006)(52116002)(66946007)(186003)(8936002)(16526019)(53546011)(31696002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0056;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fB77AA3XhJwWKN7LH8Yfk74+bo+SUV479c6JuhF/iXP7nKZlksM6BkOgkr7e+tiMnaOc2Dege/WXXyDUPIs/Rw3FaQr1Yl732gKmmK6B381GVtGeg586AIKcJRQch2h3Tmdkgv1+ecciSH6pdihFKv2Qna1zVDTR9DkkrL72eMhBjQH/ZHKmzqu+UUyTq78uEYcwBk6lNKmVHJOE5QBNv2wx+GE6Fee17mrPS52Tgoo91Xv/11G5vXvjG1xXPszdpLbq6hNjtQUzIEGQiKV0hu/FJsYEeKO14mEd5SH4kbC6o9re/HkWkYT7SHXY1Y/48yI9XPUpwz9AgU07lCyAIOy4k7cxZEykonM11rkcRBZkWbyuFKvkJTNWoud1YOY1C+Ul6vcOmhmQ0TyCAqa+/D7gLYHDkemsSWoVu3CCC0k2GN6D39O3mh89vSjLXYqp
X-MS-Exchange-AntiSpam-MessageData: SgD00ltDZYCFZL4MfM1yktFi6/Gm7pgfW7GWoCD/gpp7N6f+ejMIC7TRa4wu4QAQTDAzn0NRnDw2By2eRLqHtdFCHa/4xT/wo4O0LSVnl02Cl6zNXZBt2bVCD57BPhW/tdE2BHoD/48trntaCd4ymXddzXqBSpw787cVkdi2r+U=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adb89cd-0bc6-492c-adc4-08d7a5b57100
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 18:51:40.6295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmhXyfy8Viwksv5dU9EQA2ulWJBbQvUcjRUgY6ByhIoZRL7titixkQYdriIYMXEVLZgz6vnRareQdhVhJ/TMVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0056
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-01-30 1:29 p.m., Nicholas Kazlauskas wrote:
> [Why]
> In current code we're essentially drawing the cursor on every pipe
> that contains it. This only works when the planes have the same
> scaling for src to dest rect, otherwise we'll get "double cursor" where
> one cursor is incorrectly filtered and offset from the real position.
> 
> [How]
> Without dedicated cursor planes on DCN we require at least one pipe
> that matches the scaling of the current timing.
> 
> This is an optimization and workaround for the most common case where
> the top-most plane is not scaled but the bottom-most plane is scaled.
> 
> Whenever a pipe has a parent pipe in the blending tree whose recout
> fully contains the current pipe we can disable the pipe.
> 
> This only applies when the pipe is actually visible of course.
> 
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index f2127afb37b2..1008ac8a0f2a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -2911,6 +2911,33 @@ void dcn10_update_dchub(struct dce_hwseq *hws, struct dchub_init_data *dh_data)
>  	hubbub->funcs->update_dchub(hubbub, dh_data);
>  }
>  
> +static bool dcn10_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
> +{
> +	struct pipe_ctx *test_pipe;
> +	const struct rect *r1 = &pipe_ctx->plane_res.scl_data.recout, *r2;
> +	int r1_r = r1->x + r1->width, r1_b = r1->y + r1->height, r2_r, r2_b;
> +
> +	/**
> +	 * Disable the cursor if there's another pipe above this with a
> +	 * plane that contains this pipe's viewport to prevent double cursor
> +	 * and incorrect scaling artifacts.
> +	 */
> +	for (test_pipe = pipe_ctx->top_pipe; test_pipe;
> +	     test_pipe = test_pipe->top_pipe) {
> +		if (!test_pipe->plane_state->visible)
> +			continue;
> +
> +		r2 = &test_pipe->plane_res.scl_data.recout;
> +		r2_r = r2->x + r2->width;
> +		r2_b = r2->y + r2->height;
> +
> +		if (r1->x >= r2->x && r1->y >= r2->y && r1_r <= r2_r && r1_b <= r2_b)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
>  {
>  	struct dc_cursor_position pos_cpy = pipe_ctx->stream->cursor_position;
> @@ -2956,6 +2983,9 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
>  			== PLN_ADDR_TYPE_VIDEO_PROGRESSIVE)
>  		pos_cpy.enable = false;
>  
> +	if (pos_cpy.enable && dcn10_can_pipe_disable_cursor(pipe_ctx))
> +		pos_cpy.enable = false;
> +
>  	// Swap axis and mirror horizontally
>  	if (param.rotation == ROTATION_ANGLE_90) {
>  		uint32_t temp_x = pos_cpy.x;
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
