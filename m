Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E044C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 20:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E269210E52D;
	Fri,  8 Apr 2022 20:51:57 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870CB10E52F
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 20:51:56 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id r8so10053097oib.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Apr 2022 13:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ck9RwvYx2un+dq8p7C7hd/0XvrkiXRwhvxORW6HKNls=;
 b=kTvShncfuCzFrOymTP1EjjcFTtluWEzYwhDhQY06HxkZ+veKU0cJArk70ohNXwdSaI
 dlDcikIoyU1qaP8SDgYYq4Bzmm/EFuPP9VvA9+c0hiycnyZ1wLS/akY1k6PaX0M1EcLV
 VPMCXbS9xusUBP0mX11iZQsmPyhaqoV+3MbIXIVW3KJGI57GqZ2BUircKUrb4zH0KHIF
 S9vlG5Caz3MIjWFmO2eGLI3THqmhGDVaN6WxwbQt+XhqyxE0ZOtN7qfeLMBvUyi1UBN4
 0vFs2McfqvfslmDr0V130XT/6VKUEruYpi+Gs57wNdTQwGyvrDLc/nHmvsFjiFqmwKnw
 WxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ck9RwvYx2un+dq8p7C7hd/0XvrkiXRwhvxORW6HKNls=;
 b=Qyyra0XfVOKWysslwrvtt7eKJ6oPvG4DYF/Kxj6EPm6qJdnE7DDkEbSAg3BTzymadz
 mPeFlXvWTw7iqDBexx4CAiuM23ycUOjsZrg4+KBJD624DkEDQOBwItCtY7CUe+QA7Bcu
 x3cop9o5nXyMqlqjGB6U6OzTNcLPhzbUxNuz40Qt3a06sN0bljE/V0gVL7NpmcUF1mrx
 IluxR0PKVCk78XQYYJodQx9kM9Ez9cTw7gzeVV2W4sVBBJ/6+EFTdZ4EnlCExhPtYHLS
 umDCih4HHwSPDAEUxdkMz4tugy6erCMHZw0ogq9CX0mGBvtwhnYpQXcbdBTe17vI+MAc
 WZ1A==
X-Gm-Message-State: AOAM530QDC4K+2xfynm636saYIlV1cWTRy6ljXlf2FlAhYsSpJMUfnaW
 gmItRPMeYNYUeOhYzneCHB9IC/kfxcd38c9coQ8=
X-Google-Smtp-Source: ABdhPJwVkNOCImoriy8AxbVcwNYw+VYMgCQs4hInupfnanT58S7t0DBIohO86mlRdpa4WFkZvfFhx2oBqiNurecM/dU=
X-Received: by 2002:a05:6808:1486:b0:2f9:e821:51d9 with SMTP id
 e6-20020a056808148600b002f9e82151d9mr759692oiw.253.1649451115907; Fri, 08 Apr
 2022 13:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220407195029.1581581-1-alexander.deucher@amd.com>
 <Yk90X7v8hIgmX5Q5@dev-arch.thelio-3990X>
In-Reply-To: <Yk90X7v8hIgmX5Q5@dev-arch.thelio-3990X>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Apr 2022 16:51:45 -0400
Message-ID: <CADnq5_OCiFFgR21L1xbj23J9u4oAJxdM3GCDAi8w5vy2=hCQ+w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix 64 bit divide in freesync code
To: Nathan Chancellor <nathan@kernel.org>
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, kernel test robot <lkp@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Angus Wang <Angus.Wang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 7, 2022 at 7:31 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Thu, Apr 07, 2022 at 03:50:29PM -0400, Alex Deucher wrote:
> > Use do_div() rather than a a 64 bit divide.
> >
> > Fixes: 3fe5739db48843 ("drm/amd/display: Add flip interval workaround")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Angus Wang <Angus.Wang@amd.com>
> > Cc: Anthony Koo <Anthony.Koo@amd.com>
> > Cc: Aric Cyr <Aric.Cyr@amd.com>
> > ---
> >  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > index 0130f1879116..70f06fa8cc2b 100644
> > --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> > @@ -1230,6 +1230,7 @@ void mod_freesync_handle_v_update(struct mod_freesync *mod_freesync,
> >  {
> >       struct core_freesync *core_freesync = NULL;
> >       unsigned int cur_timestamp_in_us;
> > +     unsigned long long tmp;
> >
> >       if ((mod_freesync == NULL) || (stream == NULL) || (in_out_vrr == NULL))
> >               return;
> > @@ -1239,7 +1240,9 @@ void mod_freesync_handle_v_update(struct mod_freesync *mod_freesync,
> >       if (in_out_vrr->supported == false)
> >               return;
> >
> > -     cur_timestamp_in_us = dm_get_timestamp(core_freesync->dc->ctx)/10;
> > +     tmp = dm_get_timestamp(core_freesync->dc->ctx);
> > +     do_div(tmp, 10);
> > +     cur_timestamp_in_us = tmp;
>
> Any reason not to use
>
> cur_timestamp_in_us = div_u64(dm_get_timestamp(core_freesync->dc->ctx), 10)
>
> and save a variable?

I can do that.

Alex

>
> >       in_out_vrr->flip_interval.vsyncs_between_flip++;
> >       in_out_vrr->flip_interval.v_update_timestamp_in_us = cur_timestamp_in_us;
> > --
> > 2.35.1
> >
> >
