Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B56C71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 13:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5888810E37B;
	Mon, 16 Jun 2025 13:30:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZCiNuQff";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFF9310E37B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 13:30:13 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-312f53d0609so718913a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 06:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750080613; x=1750685413; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+QmnhYc0vGa92UC7MvCez/Zyxtl9c45qHEYK1lXUtU=;
 b=ZCiNuQffsQQixDQ0TCGTbzH2r281AZ6x75nupdsdaqPQgSuWNf9Smtg6bbDYGozMF8
 nss5RqLJqexTOX+1tj5McdeS/hQdVuZuQUkqCS5Y0ipSMYWjc/dIBqsAeTRLOnVDaaJ5
 hmUqsLC8Q1dX7lAq/U8OxRe4No57Om0QZrNizsxPJ/3sN43CnOE9NYF6U47gtwoUjHTb
 MdqNMsbPkNEZeBtjxuaCwEAYh3zsT2dmFBESBQ1GL21a5JOnKLeFS2pal1LoeJTQZIp1
 qJPMgrBW8vOIY6xDGQoXtifPHu14FYIjsi0EQNp7EDIROP3SiBEv+zNfxkUjXaEdifMc
 6NnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750080613; x=1750685413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B+QmnhYc0vGa92UC7MvCez/Zyxtl9c45qHEYK1lXUtU=;
 b=YmsOKjEPKya1gx4ivpT2X9bfKwlCwdP3su1/2JuUEa8b8uXB7UebCqp2CTy4wlrMYT
 TCIDACK7vRBYbRziWi24Xkv1pjXJbRKgQ6cOdNPmml3ku+NF2vRlT9OJ2BFxchrgsUkz
 rZPnwEBfaF0buuxE24u2r1DR9ac6pUKKB9ICAKpkBCNii2Vk4fqUwNm9vyQUEOhhGmAv
 a9+p1UaGrn8rJOz7td541Yq23GvBOiAcD0/5XkMK4VVfFygpH2HeBT5J2J6Xy8h6mQij
 3bDmfi6gOuxbcwJEfQyFUhQMGssPD70x/YurPz9QiukT3nzTlvuCcDg99oO/AKGLmN9i
 VMqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQiW0lZ1qTMjkVH0CjvCtgdyn0Oj9BaQka6niSUjePcgOb92vIGToNr1knPS3x7Tin3OH2yN9b@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/oCgpbQXPJ8N/qV8oAk68lSXvyR9RJd7ZvcOFQi281uCu9YPp
 vkQ98n+tUvITQike4FE8/+rl8Zt3G5TFrf6Yuhh68IZYnToQz6WRvosKhHFnb3RS6qq+xcW3epW
 KRlD8i4tH5WCANYYVuaAK4P+EVC0qjag=
X-Gm-Gg: ASbGncv+hwsAEP6C60yLrDZkc4rmyIYaSCCAKNERx6myIh9k76RSl4MePWVtKsNfrXZ
 tVSY6HdEsYgFY9y+GAH1DVbZZFx+PgW+KovzxLNRcdXadmMYD02dmNQ6Ub+OPcohFrNmnnjhmms
 DYyBnDw2A/Mn9ZkXbmNbn9fsjlzMgIQFYPcO5O8WR051rz
X-Google-Smtp-Source: AGHT+IGh7h6yA8zvALC5hiiGFj0J/FBflTGa0Uz6Pkt1gyHm0RW4BdoiBIlQbL9w6OGrh/35fpnh4uTxfdlAObUNoZM=
X-Received: by 2002:a17:90b:1ccc:b0:311:c939:c842 with SMTP id
 98e67ed59e1d1-313f1de6397mr5102153a91.7.1750080613063; Mon, 16 Jun 2025
 06:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <c415d9e0b08bcba068b01700225bf560@disroot.org>
 <CADnq5_PX1dYF2Jd3q7ghaBjpPhNLq9EmFJtN1w6YOSfVo++7sA@mail.gmail.com>
 <69b5ebaa719355994a383fa026dc3fba@disroot.org>
In-Reply-To: <69b5ebaa719355994a383fa026dc3fba@disroot.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Jun 2025 09:29:59 -0400
X-Gm-Features: AX0GCFthNM7567uej1TQBWHUevhiCE9wm4x56veEnyNPJYkkpKzt0iW-4Hg9ffs
Message-ID: <CADnq5_PkOuAHuDjMNXABEcenaZFZgU044G=9pTu=EgMr_grXbw@mail.gmail.com>
Subject: Re: Unplayable framerates in game but specific kernel versions work, 
 maybe amdgpu problem
To: machion@disroot.org
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jun 13, 2025 at 3:38=E2=80=AFPM <machion@disroot.org> wrote:
>
> Hi,
> sorry for the delay.
> Besides less time, I had to make myself familiar with bisecting and
> again kernel compiling. Last time I compiled the kernel myself was
> around 2010 I think.
>
> Anyway it seems I found the bad commit. The result after bisecting 10
> commits is:
>
> a53d959fe660341788cb8dbc3ac3330d90a09ecf is the first bad commit
> commit a53d959fe660341788cb8dbc3ac3330d90a09ecf
> Author: Christian K=C3=B6nig <christian.koenig@amd.com>
> Date:   Thu Mar 20 14:46:18 2025 +0100
>
>      drm/amdgpu: immediately use GTT for new allocations
>
>      commit a755906fb2b8370c43e91ba437ae1b3e228e8b02 upstream.
>
>      Only use GTT as a fallback if we already have a backing store. This
>      prevents evictions when an application constantly allocates and
> frees new
>      memory.
>
>      Partially fixes
>      https://gitlab.freedesktop.org/drm/amd/-/issues/3844#note_2833985.
>
>      Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>      Fixes: 216c1282dde3 ("drm/amdgpu: use GTT only as fallback for
> VRAM|GTT")
>      Acked-by: Alex Deucher <alexander.deucher@amd.com>
>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>      Cc: stable@vger.kernel.org
>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Unfortunately reverting that commit will reintroduce a similar
performance issue for lots of other uses.  See:
https://gitlab.freedesktop.org/drm/amd/-/issues/3844#note_2827990
for a description of the fundemental problem.

Alex

>
> Marion
>
>
> Am 2025-05-08 15:18, schrieb Alex Deucher:
> > On Thu, May 8, 2025 at 9:13=E2=80=AFAM <machion@disroot.org> wrote:
> >>
> >> Hello kernel/driver developers,
> >>
> >> I hope, with my information it's possible to find a bug/problem in the
> >> kernel. Otherwise I am sorry, that I disturbed you.
> >> I only use LTS kernels, but I can narrow it down to a hand full of
> >> them,
> >> where it works.
> >>
> >> The PC: Manjaro Stable/Cinnamon/X11/AMD Ryzen 5 2600/Radeon HD
> >> 7790/8GB
> >> RAM
> >> I already asked the Manjaro community, but with no luck.
> >>
> >> The game: Hellpoint (GOG Linux latest version, Unity3D-Engine v2021),
> >> uses vulkan
> >>
> >> ---
> >>
> >> I came a long road of kernels. I had many versions of 5.4, 5.10, 5.15,
> >> 6.1 and 6.6 and and the game was always unplayable, because the frames
> >> where around 1fps (performance of PC is not the problem).
> >> I asked the mesa and cinnamon team for help in the past, but also with
> >> no luck.
> >> It never worked, till on 2025-03-29 when I installed 6.12.19 for the
> >> first time and it worked!
> >>
> >> But it only worked with 6.12.19, 6.12.20 and 6.12.21
> >> When I updated to 6.12.25, it was back to unplayable.
> >
> > Can you bisect to see what fixed it in 6.12.19 or what broke it in
> > 6.12.25?  For example if it was working in 6.12.21 and not working in
> > 6.12.25, you can bisect between 6.12.21 and .25.
> >
> > Alex
> >
> >>
> >> For testing I installed 6.14.4 with the same result. It doesn't work.
> >>
> >> I also compared file /proc/config.gz of both kernels (6.12.21 <>
> >> 6.14.4), but can't seem to see drastic changes to the graphical part.
> >>
> >> I presume it has something to do with amdgpu.
> >>
> >> If you need more information, I would be happy to help.
> >>
> >> Kind regards,
> >> Marion
