Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03825CCA47E
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 17:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9373710F612;
	Tue,  7 Jun 2022 17:41:57 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD28610F612
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 17:41:56 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-fb6b4da1dfso6079031fac.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jun 2022 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gxX5NswbPKeet5SgZmAw0l6rjpMzjEwBkp5xJ9iNkcU=;
 b=LBiV1kh7h/DJcrNlREyYlAw5rlB9zHqSb9K3h8I4rEIHTcQJ+wFUUbNHJYy36Ys+Cz
 JHYnvP9S6DVQaHI7/OYTaXlDhD5EWsqV9xj7QMAfN+TDibhttfwVCoyAlfuWCx0pKo9L
 DJuhI3SgaQQ7hN6gSOMRlWw+xGrzmA5o6Rf0/H5EtlQxJoZMzY8t5kkpa4/5QRd/VDIS
 Q9GW931H+MymXEDE+yHHrAH5Bn+TibL8/orM5QqAmpkhBvFCyc3crvgSD8mNO2L4gnq2
 SbfsX7jGn/YZNZUUHlP2QziE5CrNBZ3OUEWzIsKsDG8+oHs8BeNC47ywFulBLvQOIL8q
 eHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gxX5NswbPKeet5SgZmAw0l6rjpMzjEwBkp5xJ9iNkcU=;
 b=Xypz7BwdSoVoR3m4fANMn1YJ4PstEWKav3UuIjuwBqaWQIzkqh3h6dub9XJ2Zb6Mg2
 KpZ56B3x6h/wcg5jOlF0eo03sgWCqn0WMigtSs/LY6T5P16H5KV9Tq8kP6mUi24fle7C
 RRI7u4OxYkAkMRY4tmRimQpSaFPQ3YYTHnxrgtBi/MizZwtk02rullVenHOWhVOkfTmn
 B0maDxb2mLbd7YGuzS1avQ404JKrWKn3wLFYq4GcuRqgI5D1oa4+jiCUia/0pAPXTU0v
 uIMMwVhXXlTkQ6ymOur5Y7ZmSWGOpKP5fQhPRIHO3FWX9kCX8TUN5e5G8NrvelfR+pec
 q5eQ==
X-Gm-Message-State: AOAM530YzU5RMC8EBudgvkTSVkWAmafTC5ttaKz+gvRM8QJVqJHD1cdH
 SEf7CVX3mArwj0Yn+PMHCjb1dAMwaJ7iEaqHT7DQUESD
X-Google-Smtp-Source: ABdhPJw9X+Lz8xnQln9s0xNEPnfbJ9uJN83aPm1eBrmWkuCc07VPe2EYBegL7QtHBgR7r6AG+N8+inGiMIgJh3lmF9E=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr17603051oap.253.1654623716108; Tue, 07
 Jun 2022 10:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220607170647.217574-1-aurabindo.pillai@amd.com>
 <a4d82dce-784e-03ca-52aa-abe57b4e5448@amd.com>
In-Reply-To: <a4d82dce-784e-03ca-52aa-abe57b4e5448@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jun 2022 13:41:44 -0400
Message-ID: <CADnq5_PgLGiNFiLBTSACdLi9f+3pg_EK=OXXs+BDe=9GuQJnGA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix null pointer deref error
To: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Jerry Zuo <jerry.zuo@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 7, 2022 at 1:40 PM Rodrigo Siqueira Jordao
<Rodrigo.Siqueira@amd.com> wrote:
>
>
>
> On 2022-06-07 13:06, Aurabindo Pillai wrote:
> > [Why]
> > 0 was passed in place of a pointer which triggered null pointer
> > dereference.
> >
> > [How]
> > Pass in a pointer that contains nullified parameters instead of null
> > pointer.
> >
> > Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> > ---
> >   .../gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c  | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > index 631a8a2f9fc3..e7944c881148 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> > @@ -2191,15 +2191,18 @@ static void dce110_setup_audio_dto(
> >                       build_audio_output(context, pipe_ctx, &audio_output);
> >
> >                       if (dc->res_pool->dccg && dc->res_pool->dccg->funcs->set_audio_dtbclk_dto) {
> > -                             /* disable audio DTBCLK DTO */
> > -                             dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
> > -                                     dc->res_pool->dccg, 0);
> > +                             struct dtbclk_dto_params dto_params = {0};
> >
> >                               pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
> >                                               pipe_ctx->stream_res.audio,
> >                                               pipe_ctx->stream->signal,
> >                                               &audio_output.crtc_info,
> >                                               &audio_output.pll_info);
> > +
> > +                             /* disable audio DTBCLK DTO */
> > +                             dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
> > +                                     dc->res_pool->dccg, &dto_params);
> > +
> >                       } else
> >                               pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
> >                                       pipe_ctx->stream_res.audio,
>
> Maybe it is a good idea to add the Fixes tag that points to the commit
> that introduced this regression. Anyway, I'm ok with this change.

Or at least explain in what case you might hit it or an example backtrace.

Alex

>
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>
