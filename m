Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE0BC433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 18:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88CF164F4A
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 18:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CF164F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 012CB6E0FF;
	Mon, 15 Mar 2021 18:20:30 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F7A46E0F7;
 Mon, 15 Mar 2021 18:20:28 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id e45so7426839ote.9;
 Mon, 15 Mar 2021 11:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qgTmUjpAgS3oY88pdR8n43/ojqKRMNQdI1zf/7d2y7M=;
 b=lsQmoe0RiNR+jpApt3STJZDJUtuFImFAiD9QoNiIYO6y20pPJBBar89/PeF1lajqvL
 PE7PckeqNmolEc+09hLVnPOND3Za2nv2LkTxqd6t3zH06khxIPHswaeCyIczUsgedHsz
 tPVgkgaXNewd5XxYvAXYPUSLy76NwaYlMKXLtiZz9Q+npnXLheUux0fBJ0LojMSSrf+x
 RB1UFaGgSlaKkf2hbUz6Ij6zYbm6cdvJMN6gfbG29PGUAJ0zjJ+XWLG2o6k6jWTg9/x8
 sy1+PSc1bdle27kJf40dpjWGmx3A0CBvObWwJeUS7mER2VPdWKy1M9X+JVISVC39gL9U
 ZZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qgTmUjpAgS3oY88pdR8n43/ojqKRMNQdI1zf/7d2y7M=;
 b=TdB62awRrh0+Gyk3+aau8NeHdzd/C864Z4EldAL/7nT0dluwnYsSCnMUhubH6A2/hH
 VUGJrsn2/0YVivBRk/f9ywzM0x/tNK91TcA6hZ5HKyzWsljWdFGXaK8w3RgAf6m0VtsQ
 RvAS9wb88OkfLzYk2+/uGRwXPM7auwyfPV4Nd57no/uM6KcJ8+aIxdbclUy70SIY7Syd
 usYYP5j3HxAqGCfi4pojgJCnrKTqOV/YGZr5KNyNzdXAqY0HU8pyfbIY1HkaAsLD1TXt
 1xWkFZ3hhyJPjn5oWCy6VxbtdT+PBmpzuw9DruOnFJBIN31ooSHCrh9ZVzCriiHoQ6h0
 O+YQ==
X-Gm-Message-State: AOAM532NevV7GfnruYJbiaU0fQeh9R168Axj4g9jiTzsEaNJmmg3d6HA
 rFl8dVUBO1ydg+oxTDEeVSZTw2KeJqwtUK/1vjI=
X-Google-Smtp-Source: ABdhPJx5cwRZYD3x24+Y5vxu1axyhaBEq/xyonkkb7s5PsBur0DZqElaGFhhHFoWwp6u9qxGfa8lqI29fRn0xWQV1J0=
X-Received: by 2002:a9d:20c3:: with SMTP id x61mr309400ota.311.1615832427497; 
 Mon, 15 Mar 2021 11:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210311163417.59967-1-colin.king@canonical.com>
In-Reply-To: <20210311163417.59967-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Mar 2021 14:20:16 -0400
Message-ID: <CADnq5_PH0q+mAAjSyL5_067aT0gqVMO1XZHBP_zsG41WY89Reg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove redundant initialization of
 variable result
To: Colin King <colin.king@canonical.com>
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
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Mar 11, 2021 at 11:34 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable result is being initialized with a value that is
> never read and it is being updated later with a new value.  The
> initialization is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 099f43709060..47e6c33f73cb 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -4281,7 +4281,7 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
>
>                 if (edp_config_set.bits.PANEL_MODE_EDP
>                         != panel_mode_edp) {
> -                       enum dc_status result = DC_ERROR_UNEXPECTED;
> +                       enum dc_status result;
>
>                         edp_config_set.bits.PANEL_MODE_EDP =
>                         panel_mode_edp;
> --
> 2.30.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
