Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E23EC07E9B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 14:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9EE611CE
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 14:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9EE611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 878E26E406;
	Tue, 20 Jul 2021 14:31:55 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 011476E406
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 14:31:53 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id u15so24722765oiw.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/kZ4EDZ54SsL5ftjQ6Ax8Zm+nbkVA1JQMGETvI0N/0o=;
 b=BZu4yTEhIR4pxwL6MVICDlaZLf4QVhGj6aseUHnIWFk94lZk13JOtz1Z/Fj4W2gB0t
 BvAAV8hUZWSY/BgbM8gx1Zul+UC/7QRJBqzuxxqDp6UkK0mtz5WcP8jUKtSnlEg6+KAP
 J12ABRuOcLsnRaTGgvtKCZWgG7N7snaWIBVfF/tgbVTvo7jA7SFWLPBKF4LU4kmBE1EN
 8V5iZXXR0SXNWEJQqi4sT9R1VIANcyYE9Rim84GkfXdfpkHwJeiYBpxila/zMl8d4HOb
 HYPH/qwIzmCVlhu3bIrF7A9/k/5kJFYfriSmwwY8Jr/RaJYYi7nEja32EvavooRV1b+T
 mNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/kZ4EDZ54SsL5ftjQ6Ax8Zm+nbkVA1JQMGETvI0N/0o=;
 b=LHcm74L7GTMoXlxR8OMZwofjEbMhTDYfwP/0AlWPPli1QZwrFxcyyTBhzQvchfQEg7
 /F/+tFAKjdPhDBj7v/DK7MnjgGdXCpeo8p7BQJ3M+pR2fAIc2oHf5kopj/WEp6KqZ4nJ
 P6HO5c7s1wd71bU6Gt3LOQs1Rh7DrW/fAAxNLyaWcYR0MfsVrl59dk1X40ILczd5zz9I
 +X+YFsUC9TeHo7liIjuhWtdQibSuEpqfVyshmUHWx8L67mLw1np0CsIdXw/7YaYeKwMb
 ygMzCg+s5S7aMhr6ESDRwcd2PdoKlf4SZr7LwwrGwVfKbVIIkyFTjfEBf/hjnvPP06Yw
 7yHQ==
X-Gm-Message-State: AOAM5314eNBaFN0HQfEVN6AwJKdjRohXpUyhqGVdmmCWAydTjdzWQIqz
 CwlllbRgHSS5NB+UZkekKZYmCGEY2wrTZO8YdMg=
X-Google-Smtp-Source: ABdhPJwpL0wv8vyPSBJnfHYDXHhRkIznuEMdCCJBJQ97J9M2vloziV0EEcMilFBDDlWzOiAIg41sPSanWMNEgmNXUdo=
X-Received: by 2002:aca:ac15:: with SMTP id v21mr24348744oie.5.1626791513294; 
 Tue, 20 Jul 2021 07:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210720033317.686726-1-stylon.wang@amd.com>
 <20210720033317.686726-3-stylon.wang@amd.com>
 <CADnq5_Pp4eriLdjT=1Bk=b1H22czzxcsSY1S=xHg_Axhnj_aVg@mail.gmail.com>
In-Reply-To: <CADnq5_Pp4eriLdjT=1Bk=b1H22czzxcsSY1S=xHg_Axhnj_aVg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Jul 2021 10:31:42 -0400
Message-ID: <CADnq5_MLai1y6qS_4gHQgKfsfTd1mpJHjrbd_M2t1nyq0q4cEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: Fix ASSR regression on embedded
 panels
To: Stylon Wang <stylon.wang@amd.com>
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
Cc: Eryk Brol <Eryk.Brol@amd.com>, "Leo \(Sunpeng\) Li" <Sunpeng.Li@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Anson Jacob <Anson.Jacob@amd.com>, Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 20, 2021 at 9:34 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Mon, Jul 19, 2021 at 11:34 PM Stylon Wang <stylon.wang@amd.com> wrote:
> >
> > [Why]
> > Regression found in some embedded panels traces back to the earliest
> > upstreamed ASSR patch. The changed code flow are causing problems
> > with some panels.
> >
> > [How]
> > - Change ASSR enabling code while preserving original code flow
> >   as much as possible
> > - Simplify the code on guarding with internal display flag
> >
> > Signed-off-by: Stylon Wang <stylon.wang@amd.com>
>
> Series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Please add:
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1620
Bug: https://bugzilla.kernel.org/show_bug.cgi?id=213779

Alex

>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > index cc62124b0b82..f56e061d35bc 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > @@ -1811,8 +1811,7 @@ bool perform_link_training_with_retries(
> >                                          */
> >                                         panel_mode = DP_PANEL_MODE_DEFAULT;
> >                                 }
> > -                       } else
> > -                               panel_mode = DP_PANEL_MODE_DEFAULT;
> > +                       }
> >                 }
> >  #endif
> >
> > @@ -4643,7 +4642,10 @@ enum dp_panel_mode dp_get_panel_mode(struct dc_link *link)
> >                 }
> >         }
> >
> > -       if (link->dpcd_caps.panel_mode_edp) {
> > +       if (link->dpcd_caps.panel_mode_edp &&
> > +               (link->connector_signal == SIGNAL_TYPE_EDP ||
> > +                (link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
> > +                 link->is_internal_display))) {
> >                 return DP_PANEL_MODE_EDP;
> >         }
> >
> > --
> > 2.32.0
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
