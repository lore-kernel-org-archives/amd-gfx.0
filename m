Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE11C7EE2E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 02:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 991F910E0D9;
	Tue, 13 Jun 2023 02:14:34 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA43E10E0D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 02:14:32 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f7ebb2b82cso52164735e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 19:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20221208.gappssmtp.com; s=20221208; t=1686622469; x=1689214469;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KRtNz5XmC20i4MEqH2wLeCYZrIPKHzFjc7f91Y1yBQg=;
 b=wnPFj/DRCLSvp80sByEMSDDJ/SdAI+ihgCVUgCDblPd5XEOzzzy4eN2GwHNXGz13tu
 9N2hYBlPNfDffHErk5wfcbe1UYUpS33ThFnVHreBsQIJ6mXkKJc6JbABS5gCP54RRo/h
 fRUedj4PV9nm3Vahyv4YNhCV2E4+3Qb6O++YvBAFl+CYXioibJ1tUg+/e//OaBe9PvLt
 WcqWe1G1IqUkbfBQ1UAvkK4ykOKOtUnyWOdWDqz6eJa4h2giOe6gJI/wKlroaGYpVPYl
 dNYMHepGzLTKmk4dV0Zm3bZ2Jp0nMAb8/21zD1/Jyj4wo8TNKFfPb23i972sT8RNJ2jH
 6gVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686622469; x=1689214469;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KRtNz5XmC20i4MEqH2wLeCYZrIPKHzFjc7f91Y1yBQg=;
 b=TK3mmwd5hCW4QBLQ7S3el1+i9pPoxJAjgu60fe+m3W+dlWOVdLhHKLaVxH2fpqhb9x
 7BhaYfnsYxJa+T7+wt0sDzsVzoxcYtizDFk4lCzNj55d8b0h3u+LKm/5aUURyiNdBf23
 eViiW+eYmxtS+soNfr9P3mxIXHd+qyQdWqlTO6cMclzNIKw3yCefwsAd0rKZ7G53vZrv
 EW0UNORpQmFHhSPFQLYhE38GaCySdVr6ygahIDQTmbrgY4iC4GAxE/qNaGQpTCPhCgSO
 +nDpxmiStln3zuABr0jGInMuU6Ajg/2WChq+LsEA23A97KY91yN/6VwlMifgfnMlL2vY
 UH2g==
X-Gm-Message-State: AC+VfDwREHOwvYlGZddLVfqFF77P/f4lE+87gxTSy2NQYukempK8cBE8
 BQBZT8T5sOW5PjH8AR+SOcgWB8YKqJSM4NFGem2kjw==
X-Google-Smtp-Source: ACHHUZ6wm/rg/odUeTCEX8geHc4ucER1n7BEc2be4cGAmvJGrxhlyIH6QvX0ZmWY5faGkXjUmItcHSIMdA3kCOAxrTE=
X-Received: by 2002:a7b:cc84:0:b0:3f6:476:915 with SMTP id
 p4-20020a7bcc84000000b003f604760915mr8434541wma.6.1686622468926; 
 Mon, 12 Jun 2023 19:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230612140019.720959-1-alexander.deucher@amd.com>
 <50548877-3012-2869-21eb-1e5224700a9b@amd.com>
In-Reply-To: <50548877-3012-2869-21eb-1e5224700a9b@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Tue, 13 Jun 2023 03:14:18 +0100
Message-ID: <CAHbf0-FKeTtq=UyK8kUP7rWJPCnBLqs-WESwzO5C8OG5divr=g@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: fix dpms_off issue when
 disabling bios mode"
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Zhongwei <Zhongwei.Zhang@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks

I'm happy to help debug this further

On Mon, 12 Jun 2023 at 15:18, Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 6/12/23 10:00, Alex Deucher wrote:
> > This reverts commit 58e67bb3c131da5ee14e4842b08e53f4888dce0a.
> >
> > This patch was reverted, but came back again as
> > commit 58e67bb3c131 ("drm/amd/display: fix dpms_off issue when disabling bios mode")
> > Revert it again as it breaks Asus G513QY / 6800M laptops.
> >
> > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2259
> > Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > Cc: Zhongwei <Zhongwei.Zhang@amd.com>
> > Cc: Harry Wentland <harry.wentland@amd.com>
> > Cc: Mike Lothian <mike@fireburn.co.uk>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > index be72e03cdf92..5d3d61faeb28 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > @@ -1296,7 +1296,7 @@ static void disable_vbios_mode_if_required(
> >
> >                                       if (pix_clk_100hz != requested_pix_clk_100hz) {
> >                                               dc->link_srv->set_dpms_off(pipe);
> > -                                             pipe->stream->dpms_off = true;
> > +                                             pipe->stream->dpms_off = false;
> >                                       }
> >                               }
> >                       }
>
