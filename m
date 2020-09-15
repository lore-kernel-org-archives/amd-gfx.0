Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13A6C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 19:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A9D206B2
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 19:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uF0v2qSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A9D206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCAE86E14C;
	Tue, 15 Sep 2020 19:18:39 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D8DE6E14C;
 Tue, 15 Sep 2020 19:18:39 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id l9so598674wme.3;
 Tue, 15 Sep 2020 12:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G/X0kPNzrsM6p6b+lxt3nMCOYmOHQKIBg29Sofy0KXM=;
 b=uF0v2qSS9zDREj+6qqNypGZh8hcdiqOqlYhQer2PYoZWyE2Ld6v1CUhFqykffdALD6
 qUq83ch4WvQATgF3c2qjQRDoc/M51bgwXMERec/TwtHs60IAVtYUa5lEThYNppJxII1h
 LWjpI3YmwFdKja7JosS2mqmV5qYAfbpg2RPVVVclLdxaMwMiszeLgHypUV0zem80pbRM
 9b7iFG6oWl9szHZ/AJzL1iKFj5DQ8G+JEhldt7D1i6jO96MlYv1um0Sbyr5Av0/u4vJT
 0LWrsoydArYLmz3EMXfI3MTud7ibPZkBD03ZF+yOxCaLeGTHvk/0xoiaZZG+ImnRzztl
 nJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G/X0kPNzrsM6p6b+lxt3nMCOYmOHQKIBg29Sofy0KXM=;
 b=Baq6bhZhm9bLTyBZ/Zcwaig7FHPgJyuTlSODQ1lKLmMC0R7QRVXQYfFCTnY5Y2kfYS
 g67HHIVg1UWfQZa97sHd7pACFqJ7F7/WBCRziY2FK6rBTnvjfln/1M9TAY5VR5qpdzMz
 VxkY8flQzz0PLNhi7fKvLTL4N+8/2yKVfmYtXx6HyGFVKcyZUuAvWKqXU3zbUsW2FqOm
 SfJhKzthuhRwCRKiwFUsHRoIQhU78APJcvXkrpTlRUh24m9L6XEvWKL7YhE2AmNsLkkk
 C7RMAxqvhDEQW8yewqh5iUOrkNk5SnlKJsL+feKqWK2Y8dT9/xm62Lp28DPg7+aJcYu3
 LCoQ==
X-Gm-Message-State: AOAM531pbzwFZFNw1yK/WJSzEVXvTWWnK9uAHK35JfnWh5NlKOMv2/ND
 vLYPNbkKDpP+RQB40o3P3eJdkNXxjL7SEUCMmC4=
X-Google-Smtp-Source: ABdhPJxgHA6GYBXBtpwTuEnRRMJTLGbVacOxKpOGXOEt+I2uucTSssj2I4MLSQEl07O7b7daVG90ScPubjl2P3IuJmk=
X-Received: by 2002:a7b:c141:: with SMTP id z1mr853417wmi.79.1600197517755;
 Tue, 15 Sep 2020 12:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200910020520.9973-1-bernard@vivo.com>
In-Reply-To: <20200910020520.9973-1-bernard@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2020 15:18:26 -0400
Message-ID: <CADnq5_P4an7Jx0vPxBY9Mt8OHNOZsyx0MxCG4Mi8XVdMX-70yA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: optimize code runtime a bit
To: Bernard Zhao <bernard@vivo.com>
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
Cc: opensource.kernel@vivo.com, Aric Cyr <aric.cyr@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
 Hersen Wu <hersenxs.wu@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, abdoulaye berthe <abdoulaye.berthe@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 jinlong zhang <jinlong.zhang@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Sep 10, 2020 at 3:23 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> In fnction is_cr_done & is_ch_eq_done, when done = false
> happened once, no need to circle left ln_count.
> This change is to make the code run a bit fast.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index b2be6ad5101d..53e30be8b66a 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -373,34 +373,30 @@ static void dpcd_set_lt_pattern_and_lane_settings(
>  static bool is_cr_done(enum dc_lane_count ln_count,
>         union lane_status *dpcd_lane_status)
>  {
> -       bool done = true;
>         uint32_t lane;
>         /*LANEx_CR_DONE bits All 1's?*/
>         for (lane = 0; lane < (uint32_t)(ln_count); lane++) {
>                 if (!dpcd_lane_status[lane].bits.CR_DONE_0)
> -                       done = false;
> +                       return false;
>         }
> -       return done;
> -
> +       return true;
>  }
>
>  static bool is_ch_eq_done(enum dc_lane_count ln_count,
>         union lane_status *dpcd_lane_status,
>         union lane_align_status_updated *lane_status_updated)
>  {
> -       bool done = true;
>         uint32_t lane;
>         if (!lane_status_updated->bits.INTERLANE_ALIGN_DONE)
> -               done = false;
> +               return false;
>         else {
>                 for (lane = 0; lane < (uint32_t)(ln_count); lane++) {
>                         if (!dpcd_lane_status[lane].bits.SYMBOL_LOCKED_0 ||
>                                 !dpcd_lane_status[lane].bits.CHANNEL_EQ_DONE_0)
> -                               done = false;
> +                               return false;
>                 }
>         }
> -       return done;
> -
> +       return true;
>  }
>
>  static void update_drive_settings(
> --
> 2.28.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
