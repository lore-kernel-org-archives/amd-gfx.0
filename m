Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856BEC677F1
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 15:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A2A410E8FF;
	Thu, 12 Jan 2023 15:26:59 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D417D10E8FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 15:26:57 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 s13-20020a17090a6e4d00b0022900843652so2389829pjm.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 07:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WVlLxH2Rj+8QSEZoiILadbKJQqSAUcthH+jBOnJMZHA=;
 b=JftHModyBQyWOf9IbcHgv+wM+wAMjzeIgqay2Sc8xYfkI5JHsWwEEaR0BrMLIrDI0F
 yxykKOAvVOboJ8Q3inG5JiMM5zD9V4Wn648fS3KtICCIxD5uZqOMV4/KjWnV0Hk62u/K
 0g4zOe1NM3yXUlV8A36BJ7zUBJLOFJCN2pqMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WVlLxH2Rj+8QSEZoiILadbKJQqSAUcthH+jBOnJMZHA=;
 b=EGsR12pDobu97sv3EZfEgHPh87KyTXe3Brc60jEmP3JSx6Z1H/+uFhCHRfqvq6gDsb
 3/AArC1rnM0eUNJm412d8Ju8A5HDNK8ogPk4gTqcdHmTFGTPOlKQEYlh+vokh4NFzpqY
 8/nD/+qDQzestSn19fu3vYKfGLJi8wYEZX+JbkO/3TaYlxcMwx6GUJ369thsiU1Rg5s0
 vVfgpcRFrLr81giLSlogLMKVIZarMyU9maCGf8lcy1zedBkIj5tVKJX733UB0mbGY7Sa
 IMHxao7bUOXt2VC6L4he+lbdBH/7NEgWj+kh+vPncw+Tl2c2TkCqSRVjHHhmI6pp0FR2
 1dvQ==
X-Gm-Message-State: AFqh2ko0mjzYV6t5IfglvTiikWdzYyj6AfHc2NHruQ6f94BW0n+hs59m
 +L77zwv8AQOJpjiRtB+wIawMJjuRgwI5yhy6RMxhsA==
X-Google-Smtp-Source: AMrXdXszpIuyfj/mHnCEnh6uhFgYKDm3M6iMpGAaIQNcUe0iGzTUPpaT/7EySwmrAqTumWdnNX0AssRqS0MYKX5qVxs=
X-Received: by 2002:a17:902:bf45:b0:189:505b:73dd with SMTP id
 u5-20020a170902bf4500b00189505b73ddmr5104347pls.143.1673537217363; Thu, 12
 Jan 2023 07:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20230104175633.1420151-1-dragos.panait@windriver.com>
 <20230104175633.1420151-2-dragos.panait@windriver.com>
 <Y8ABeXQLzWdoaGAY@kroah.com>
In-Reply-To: <Y8ABeXQLzWdoaGAY@kroah.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 12 Jan 2023 16:26:45 +0100
Message-ID: <CAKMK7uEgzJU8ukgR3sQtSUB5+wrD9VyMwCHOA-SReFWd0tKzzw@mail.gmail.com>
Subject: Re: [PATCH 5.10 1/1] drm/amdkfd: Check for null pointer after calling
 kmemdup
To: Greg KH <gregkh@linuxfoundation.org>
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
Cc: Oded Gabbay <oded.gabbay@gmail.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Dragos-Marian Panait <dragos.panait@windriver.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Kent Russell <kent.russell@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, 12 Jan 2023 at 13:47, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Jan 04, 2023 at 07:56:33PM +0200, Dragos-Marian Panait wrote:
> > From: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> >
> > [ Upstream commit abfaf0eee97925905e742aa3b0b72e04a918fa9e ]
> >
> > As the possible failure of the allocation, kmemdup() may return NULL
> > pointer.
> > Therefore, it should be better to check the 'props2' in order to prevent
> > the dereference of NULL pointer.
> >
> > Fixes: 3a87177eb141 ("drm/amdkfd: Add topology support for dGPUs")
> > Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> > Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Dragos-Marian Panait <dragos.panait@windriver.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > index 86b4dadf772e..02e3c650ed1c 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > @@ -408,6 +408,9 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
> >                       return -ENODEV;
> >               /* same everything but the other direction */
> >               props2 = kmemdup(props, sizeof(*props2), GFP_KERNEL);
> > +             if (!props2)
> > +                     return -ENOMEM;
>
> Not going to queue this up as this is a bogus CVE.

Are we at the point where CVE presence actually contraindicates
backporting? At least I'm getting a bit the feeling there's a surge of
automated (security) fixes that just don't hold up to any scrutiny.
Last week I had to toss out an fbdev locking patch due to static
checker that has no clue at all how refcounting works, and so
complained that things need more locking ... (that was -fixes, but
would probably have gone to stable too if I didn't catch it).

Simple bugfixes from random people was nice when it was checkpatch
stuff and I was fairly happy to take these aggressively in drm. But my
gut feeling says things seem to be shifting towards more advanced
tooling, but without more advanced understanding by submitters. Does
that holder in other areas too?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
