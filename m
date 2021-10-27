Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C3BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 13:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 333BA60F56
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 13:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 333BA60F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C13FC6E5CE;
	Wed, 27 Oct 2021 13:05:26 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D510D6E5CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 13:05:25 +0000 (UTC)
Received: by mail-lj1-x232.google.com with SMTP id k13so4526374ljj.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 06:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aqS6Bkhj91+MM1aFYo7m18OwXpDohUPAMvxp+gd6XYU=;
 b=HD6UtO6R45uXyFxs+GyXx6AwrALy6xxOEi09dzMlQxl/vUOlImUTYdRblOa+vEgBlm
 Tjz1dA5x1qcdEDq0PlHo2ZL6pX1InR6/yWVaoS/BSHuFJv/IN3hV0H6JDmecUn82x4Ay
 SCg7YCxtuBG1eTYXniG18h8mDVUDMr40lIiwyHuy19C4KmfA74xk7d0S7Hs2iyVHB659
 DHxKY3Z/5OB4SBwt8vIyWEGkM5vQNhjPXuI7oNV6rxaUAfAtkwGjDXced/dnkpVqYXXe
 +pvVUb1riFD5zJVFvQfIzbMVLL0ABQNZxA2VP7vUX+jW0ZM8o9q0tXRUU6lerZDpoP4e
 z4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aqS6Bkhj91+MM1aFYo7m18OwXpDohUPAMvxp+gd6XYU=;
 b=ApT2aClDJKzhs8lGl38is0SdflFC8QFhNTJ8VDSYvstiO6DzK67XHcJ9ik9hS3zQqh
 40DhHfrS8RN55M96sBrcL3qOELMSgzFVCIdlJxQ8TQp+mmPJCewiiYogxp6q2vIinqmg
 QiIgleYXUZIGr+HzmdJkd6hGFw8nzQ/IKpWeqsWvw+tHAE6lI/RbgI9jfNaRJS5/OZfJ
 MzxRCe/VqXsNgRzpkS5LG2+4sBMgcGeUnl7U+DOz6QJGcszCDdFNL9Lm1tATKZUyvKHk
 K98+B9FMc5THm4ka4FB0AVxsOeseterjWqcT1XUdUAnneimN2PD2MJaywFuCYVvQdn69
 WdyA==
X-Gm-Message-State: AOAM533ZPloiBJcHZ8k96x5m/Y384yZjmxhGaatXG/3AEE+hbtUG8JHE
 KBAb4BGfRVsF33apho1n5e/0iuaHuzn2ke21auE=
X-Google-Smtp-Source: ABdhPJz+zy4O5cf2dyZfSefNgUgNzTM9MO5+UIHRNBH9431w/+KdIlS9T9EiRHKtIeGov8M2R6BTkCRXp/KRf9lQh1o=
X-Received: by 2002:a2e:8584:: with SMTP id b4mr6021911lji.14.1635339922690;
 Wed, 27 Oct 2021 06:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <CADN=F_ngDhs10tBOtQy4kz0T6ZEjLJ_q0P+7bpen=JU04cpUXg@mail.gmail.com>
 <CADnq5_NctQdhD4UqnK9DLuLZx8F048i24hOBNQwC+EMpZOsxoA@mail.gmail.com>
 <CAMeQTsZcEXSQswdUuZRbh7y7ik83KwQngzxqs04QDTqOWLO5pA@mail.gmail.com>
In-Reply-To: <CAMeQTsZcEXSQswdUuZRbh7y7ik83KwQngzxqs04QDTqOWLO5pA@mail.gmail.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Wed, 27 Oct 2021 15:05:11 +0200
Message-ID: <CAMeQTsa7bmCwEsHc-vAMCh=NhSScJa_KTrKfcPxOU6gf0x2c5w@mail.gmail.com>
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

On Wed, Oct 27, 2021 at 12:08 PM Patrik Jakobsson
<patrik.r.jakobsson@gmail.com> wrote:
>
> On Wed, Oct 13, 2021 at 10:41 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Wed, Oct 13, 2021 at 4:04 PM T. Williams <tdwilliamsiv@gmail.com> wrote:
> > >
> >
> > The description and s-o-b should go here and the patch seems to be
> > mangled.  I've manually applied this.  Please fix up your mailer in
> > the future.
> >
> > Thanks for the fix.
>
> Hi Thelford and Alex
>
> There are several more instances of size being used instead of
> wr_buf_size in amdgpu_dm_debugfs.c.
>
> IMO the proper fix here would be to revert
> 918698d5c2b50433714d2042f55b55b090faa167

Actually, there's one instance that a revert doesn't cover. Instead I
sent out a patch to fix the remaining ones.

>
> -Patrik
>
> >
> > Alex
> >
> >
> > > ---
> > >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > > index 87daa78a32b8..17f2756a64dc 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > > @@ -263,7 +263,7 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
> > >         if (!wr_buf)
> > >                 return -ENOSPC;
> > >
> > > -       if (parse_write_buffer_into_params(wr_buf, size,
> > > +       if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> > >                                            (long *)param, buf,
> > >                                            max_param_num,
> > >                                            &param_nums)) {
> > > --
> > >
> > > Size can be any value and is user controlled resulting in overwriting the 40 byte array wr_buf with an arbitrary length of data from buf.
> > >
> > > Signed-off-by: Thelford Williams <tdwilliamsiv@gmail.com>
