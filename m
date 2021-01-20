Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C3DC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 22:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7A4235FF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 22:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7A4235FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36EE06E457;
	Wed, 20 Jan 2021 22:00:29 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 625876E457;
 Wed, 20 Jan 2021 22:00:28 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id r189so17079570oih.4;
 Wed, 20 Jan 2021 14:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=saDKMA0jB6EqXW9G0YL6Gf41CyarOu27mR26evtWnko=;
 b=BtvepDc1t5xMKDzkpkJDpstu6FHBOPnYBTqAWWHihI1oDL4ApXjvM6idp3egQajSz7
 fNwZ772pD1IQa6zfAhQf5X4bDazRxUDWpY73pefPy8zI5cNjEgw0VYZy4DVcwr54TflY
 OD3+YrUVc4qxJKU6r37mMI/Yd6PE+t67LTPGXrWZb/5EnQBCJhds9PuxxS9jhFagYH2F
 nipwUsTK/dU9ID4Tz0fC8TzBAE4SloyfNWQVWrJyHkqA1Io3lo5ii+f6MvQOspTg7axR
 ZHLAUCmZzqGfbGNp8hZSFWEY2zvrR3UKTU1eqvELhPCrBhhXq1zL6tdhO/atNcHyL1GF
 8ACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=saDKMA0jB6EqXW9G0YL6Gf41CyarOu27mR26evtWnko=;
 b=Wr0Qrl8LOqBChF+nTG4eaFGS56t9wV9N6b0zRP5ud6xbADT6ehZ32HxWebF+Llj3XA
 ngTOKTIoWyCDMOLDMfTD/r77KOdW//L/fhf5F+mKKBI5/uPEh2/Spc2p/uk7T9FoX9ut
 KQ6mCUaJkx0HDXqW9kl5BRlKYnB/lrmsqyFiYObPhLg/57QhuEl2FSmQmEA8GPsGP8BV
 BuYlHkqRDP3PcQ0k8sYRQcIR3ki+WHaN/1s3OKD0afC/JFA9CpOPKwvVqKZXP0oEL2zX
 HlEC/5KwwfAKa8+kS2WKcnhWPoYwXucCBFQuSPeptS6Q30Fif5wVvECdU/bzz4dI/ubJ
 GS0w==
X-Gm-Message-State: AOAM530pfFkniaDbTOJZcPEHG/z0V/4746om+bGEQW30r7HSE2zvbPOW
 o8xooXU3XnbknX/s5YVFOAARl8YNHxaxwFzq0Ws=
X-Google-Smtp-Source: ABdhPJzP2F7SIwkHGhdxKuUWAyKeMMGxwJDgWTGxnefy59uLaMXn/jA5IJF7QAjnU6rYRkJ4JLpq++9GBXSyjAg7zvE=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr4089486oib.123.1611180027641; 
 Wed, 20 Jan 2021 14:00:27 -0800 (PST)
MIME-Version: 1.0
References: <1611127007-39308-1-git-send-email-abaci-bugfix@linux.alibaba.com>
 <3e2d3292-8611-68de-e1ed-7266fd41ce76@amd.com>
In-Reply-To: <3e2d3292-8611-68de-e1ed-7266fd41ce76@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Jan 2021 17:00:16 -0500
Message-ID: <CADnq5_MXyZ5O8qroFjFhEupaiauXNVu7yT4KY3CGeQnVa0BkOA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Assign boolean values to a bool variable
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: "Tuikov, Luben" <luben.tuikov@amd.com>,
 "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>, Dave Airlie <airlied@linux.ie>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Eric Bernstein <Eric.Bernstein@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, Ye Bin <yebin10@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Jan 20, 2021 at 10:05 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2021-01-20 2:16 a.m., Jiapeng Zhong wrote:
> > Fix the following coccicheck warnings:
> >
> > ./drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c:
> > 1009:6-16: WARNING: Assignment of 0/1 to bool variable.
> >
> > ./drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c:
> > 200:2-10: WARNING: Assignment of 0/1 to bool variable.
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >   .../display/dc/dml/dcn30/display_rq_dlg_calc_30.c  | 32 +++++++++++-----------
> >   1 file changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> > index 5b5916b..0f14f20 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> > @@ -165,8 +165,8 @@ static void handle_det_buf_split(struct display_mode_lib *mode_lib,
> >       unsigned int swath_bytes_c = 0;
> >       unsigned int full_swath_bytes_packed_l = 0;
> >       unsigned int full_swath_bytes_packed_c = 0;
> > -     bool req128_l = 0;
> > -     bool req128_c = 0;
> > +     bool req128_l = false;
> > +     bool req128_c = false;
> >       bool surf_linear = (pipe_src_param.sw_mode == dm_sw_linear);
> >       bool surf_vert = (pipe_src_param.source_scan == dm_vert);
> >       unsigned int log2_swath_height_l = 0;
> > @@ -191,37 +191,37 @@ static void handle_det_buf_split(struct display_mode_lib *mode_lib,
> >               total_swath_bytes = 2 * full_swath_bytes_packed_l;
> >
> >       if (total_swath_bytes <= detile_buf_size_in_bytes) { //full 256b request
> > -             req128_l = 0;
> > -             req128_c = 0;
> > +             req128_l = false;
> > +             req128_c = false;
> >               swath_bytes_l = full_swath_bytes_packed_l;
> >               swath_bytes_c = full_swath_bytes_packed_c;
> >       } else if (!rq_param->yuv420) {
> > -             req128_l = 1;
> > -             req128_c = 0;
> > +             req128_l = true;
> > +             req128_c = false;
> >               swath_bytes_c = full_swath_bytes_packed_c;
> >               swath_bytes_l = full_swath_bytes_packed_l / 2;
> >       } else if ((double)full_swath_bytes_packed_l / (double)full_swath_bytes_packed_c < 1.5) {
> > -             req128_l = 0;
> > -             req128_c = 1;
> > +             req128_l = false;
> > +             req128_c = true;
> >               swath_bytes_l = full_swath_bytes_packed_l;
> >               swath_bytes_c = full_swath_bytes_packed_c / 2;
> >
> >               total_swath_bytes = 2 * swath_bytes_l + 2 * swath_bytes_c;
> >
> >               if (total_swath_bytes > detile_buf_size_in_bytes) {
> > -                     req128_l = 1;
> > +                     req128_l = true;
> >                       swath_bytes_l = full_swath_bytes_packed_l / 2;
> >               }
> >       } else {
> > -             req128_l = 1;
> > -             req128_c = 0;
> > +             req128_l = true;
> > +             req128_c = false;
> >               swath_bytes_l = full_swath_bytes_packed_l/2;
> >               swath_bytes_c = full_swath_bytes_packed_c;
> >
> >               total_swath_bytes = 2 * swath_bytes_l + 2 * swath_bytes_c;
> >
> >               if (total_swath_bytes > detile_buf_size_in_bytes) {
> > -                     req128_c = 1;
> > +                     req128_c = true;
> >                       swath_bytes_c = full_swath_bytes_packed_c/2;
> >               }
> >       }
> > @@ -1006,8 +1006,8 @@ static void dml_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
> >
> >       double min_dst_y_ttu_vblank = 0;
> >       unsigned int dlg_vblank_start = 0;
> > -     bool dual_plane = 0;
> > -     bool mode_422 = 0;
> > +     bool dual_plane = false;
> > +     bool mode_422 = false;
> >       unsigned int access_dir = 0;
> >       unsigned int vp_height_l = 0;
> >       unsigned int vp_width_l = 0;
> > @@ -1021,7 +1021,7 @@ static void dml_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
> >       double hratio_c = 0;
> >       double vratio_l = 0;
> >       double vratio_c = 0;
> > -     bool scl_enable = 0;
> > +     bool scl_enable = false;
> >
> >       double line_time_in_us = 0;
> >       //      double vinit_l;
> > @@ -1156,7 +1156,7 @@ static void dml_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
> >       // Source
> >       //                       dcc_en                   = src.dcc;
> >       dual_plane = is_dual_plane((enum source_format_class)(src->source_format));
> > -     mode_422 = 0; // TODO
> > +     mode_422 = false; // TODO
> >       access_dir = (src->source_scan == dm_vert); // vp access direction: horizontal or vertical accessed
> >       vp_height_l = src->viewport_height;
> >       vp_width_l = src->viewport_width;
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
