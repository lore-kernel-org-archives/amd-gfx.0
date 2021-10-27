Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF0CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 10:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC3E60E05
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 10:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8EC3E60E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BA0C6E47E;
	Wed, 27 Oct 2021 10:09:00 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBAF86E47E
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 10:08:58 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id bi35so4996645lfb.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 03:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=art/DjRqBvIz0kk/VsufVNHdRSEhVJahvxd1P5Vlwhg=;
 b=fZpr9wGXxaC6yZc2hkV8lzZzJY5BSfndXmP0dHfD7TlyuspcXmJuDhEd/E354J7JkC
 yenZ805mldkirpzBkA9pR5Ij/t8lnNQIIOtR4nvbFo9xwnIz9Zxg/6UL7P/oOpc5Pr1C
 faTq3HavaPskGqIvdwKo8U9hiWt5EUHC1k7py5MRFzaTA+locgeGMtJsdR/nEhdANPs9
 Ep5kXrdIUOmJf1pXKw7wiReO6dnJt4sh1+Arp58MD9OuACZOp22aKm2INJN8BjnB1YLf
 l6uMw01k59E5GjXRj6TtCnOUisUGqSYJWJn83iJVUWlNtwHtEvVe9yICvto5TZEK4ldR
 8pAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=art/DjRqBvIz0kk/VsufVNHdRSEhVJahvxd1P5Vlwhg=;
 b=wu9SpPDFAa+6IfDt/Av3Fy/HST67ZJsEbw7LjQsofCTp1bHY7qUDFrHEH0RYHBxPne
 a7uysg6W3W+PqwqGkSuSaUCOaKXt3mwcCIaJPuOnK26ZT5BFDqt2LAPvVQfQeBkZHbGZ
 fv9ZzUeAAD4eJmu3L5aZfTM9FMpEuyh+bQ2mvHwX/pxp5AYCMVeVS2mPznEIca97uOvQ
 0yKEHhrJSPvRyyIiH9ysB1H9RexYl8aSKIC7qz31eyAuOT5099j/H1RrTlU8WKCetfdJ
 4IBe+PzcKFAqjmkSGfpcWiDSAvVoYInJXD6X508JFuxlkDyCtxULTkiGszDeu4E7Rl/d
 vkFw==
X-Gm-Message-State: AOAM5333dc8tvG1FzDa3xZ4u0EvOEhw7DswqO9RLp6XYPcvjwYWNOF0J
 Pyi7Ro8lEG94FqrYNRogvMWSzHZqSbhTpg0GiIc=
X-Google-Smtp-Source: ABdhPJwBHJ1mG+dd8sFy03T2sQSrusXEy7jL5gyH97NBXm5Nm0uLnQ0dnf32165WxXyNsRT0DqL+FU09ge1NM7XIZlU=
X-Received: by 2002:ac2:4c56:: with SMTP id o22mr28182314lfk.196.1635329337208; 
 Wed, 27 Oct 2021 03:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <CADN=F_ngDhs10tBOtQy4kz0T6ZEjLJ_q0P+7bpen=JU04cpUXg@mail.gmail.com>
 <CADnq5_NctQdhD4UqnK9DLuLZx8F048i24hOBNQwC+EMpZOsxoA@mail.gmail.com>
In-Reply-To: <CADnq5_NctQdhD4UqnK9DLuLZx8F048i24hOBNQwC+EMpZOsxoA@mail.gmail.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Wed, 27 Oct 2021 12:08:46 +0200
Message-ID: <CAMeQTsZcEXSQswdUuZRbh7y7ik83KwQngzxqs04QDTqOWLO5pA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix out of bounds write
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "T. Williams" <tdwilliamsiv@gmail.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, 
 "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, Dave Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, 
 Wayne Lin <Wayne.Lin@amd.com>, "Lipski, Mikita" <mikita.lipski@amd.com>, 
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 Stylon Wang <stylon.wang@amd.com>, 
 Eryk Brol <eryk.brol@amd.com>, Jerry Zuo <Jerry.Zuo@amd.com>, 
 Victor Lu <victorchengchi.lu@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, 
 Nirmoy Das <nirmoy.das@amd.com>, Anson Jacob <Anson.Jacob@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 13, 2021 at 10:41 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Oct 13, 2021 at 4:04 PM T. Williams <tdwilliamsiv@gmail.com> wrote:
> >
>
> The description and s-o-b should go here and the patch seems to be
> mangled.  I've manually applied this.  Please fix up your mailer in
> the future.
>
> Thanks for the fix.

Hi Thelford and Alex

There are several more instances of size being used instead of
wr_buf_size in amdgpu_dm_debugfs.c.

IMO the proper fix here would be to revert
918698d5c2b50433714d2042f55b55b090faa167

-Patrik

>
> Alex
>
>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > index 87daa78a32b8..17f2756a64dc 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > @@ -263,7 +263,7 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
> >         if (!wr_buf)
> >                 return -ENOSPC;
> >
> > -       if (parse_write_buffer_into_params(wr_buf, size,
> > +       if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> >                                            (long *)param, buf,
> >                                            max_param_num,
> >                                            &param_nums)) {
> > --
> >
> > Size can be any value and is user controlled resulting in overwriting the 40 byte array wr_buf with an arbitrary length of data from buf.
> >
> > Signed-off-by: Thelford Williams <tdwilliamsiv@gmail.com>
