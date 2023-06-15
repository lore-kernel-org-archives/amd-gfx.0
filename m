Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03831EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 13:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62B0110E4EC;
	Thu, 15 Jun 2023 13:17:58 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 440C210E4EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 13:17:56 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1a997531cceso776382fac.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686835075; x=1689427075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qr4AoZXjL5L96SLIgTgOKclQUNJfxz+SPCij3ZQRDtw=;
 b=CuhaPs4bDFPFpRsEhcthm+E3yLh1dvI624vDInAHXYHLoY9KK1ZWkpfoXt+tPLzYKq
 ABYEaF2WEsoRadelZGiJL73Z88HOzPkOMrQDXyqgocZLYXIcZW/aRQ8gIJBxwH1Zepyg
 PfUX815Phj891ib1QHbZ3dDdCx2uWNhr739smJfYLhduKeRNa09D3V4EKf314Yn9AYRm
 8f7ZZOGXM/+Ls7vVRPIc23Rr2SJ5jUdj3f1QEiI2cFl74pOBXAJGKYQWSRWGcfFEfDL2
 BHW9vnDS5iCHmtMTyAoGHub0s0vzURNayBr4liwWuK2FRgG4IBq109g3o6k954vQwtaw
 +LsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686835075; x=1689427075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qr4AoZXjL5L96SLIgTgOKclQUNJfxz+SPCij3ZQRDtw=;
 b=B5IktD5RQ/QnPUj2DVoYlONNnzeEYLkdmSvTKbQIB7NNqljYV66TkfnsOAgZIKcmp3
 XEH44ZTCbE7z/Xa8iUFChGdc71RPm04ji5UlLE+V5mXnfzbOGXkwJnD+av/F4hGW39mj
 rOLU2pURJOvPUGVKFr247nbzfz7sbp55dJ2zerTOfMgbu1oOLI5Tm+hU87QiMlrzbfKo
 SKLRscZcGYnXxJVxIiWKWeqZIOVyxEUCoxmz7JBH6VrjEBQnZV1suFJ+Hz9UbZlyR4TC
 DJog3odr6pemYDwiGnrYZ5DIwQPZ+zPDn7kJa0u7lc8gSJfj1U0VWEgRgrKHIT1Q0m23
 CqlQ==
X-Gm-Message-State: AC+VfDw9cGU9gUgmXUqq8/mggSzYKcr012a9w94gs84eY+HtFlHReDoK
 Ogth0xaRKC2GIsvx3YiHv/1hlakXdSnTVixustHYK92X
X-Google-Smtp-Source: ACHHUZ7oGVjQthbacrBt6W3BA99qpVAOoryecDWKHmhzdzeeDxsNIs9LXYBY7a6U7vKd1bl4/6THygvNa+f6MHvJ3uM=
X-Received: by 2002:a05:6870:b782:b0:1a0:2fd5:116a with SMTP id
 ed2-20020a056870b78200b001a02fd5116amr10489899oab.16.1686835075053; Thu, 15
 Jun 2023 06:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230607164604.961913-1-alexander.deucher@amd.com>
 <CADnq5_Nwf_8iqMsFGO9x-PdUbBoUf1RqU4KzqrEKVPdwmkDW2g@mail.gmail.com>
In-Reply-To: <CADnq5_Nwf_8iqMsFGO9x-PdUbBoUf1RqU4KzqrEKVPdwmkDW2g@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Jun 2023 09:17:43 -0400
Message-ID: <CADnq5_MyLN79FEjjVx5tt4REGWwBVV7=4xJ+TnYCXnEGxOjk6A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/atomfirmware: fix DDR5 width reporting
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Mon, Jun 12, 2023 at 5:47=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Ping?
>
> On Wed, Jun 7, 2023 at 12:46=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > DDR5 channels are 32 bit rather than 64, report the width properly
> > in the log.
> >
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2468
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 20 +++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> > index ef4b9a41f20a..6b3bdc27f778 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> > @@ -327,10 +327,14 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_d=
evice *adev,
> >                                         mem_channel_number =3D igp_info=
->v11.umachannelnumber;
> >                                         if (!mem_channel_number)
> >                                                 mem_channel_number =3D =
1;
> > -                                       /* channel width is 64 */
> > -                                       if (vram_width)
> > -                                               *vram_width =3D mem_cha=
nnel_number * 64;
> >                                         mem_type =3D igp_info->v11.memo=
rytype;
> > +                                       if ((mem_type =3D=3D Ddr5MemTyp=
e) ||
> > +                                           (mem_type =3D=3D LpDdr5MemT=
ype))
> > +                                               mem_channel_width =3D 3=
2;
> > +                                       else
> > +                                               mem_channel_width =3D 6=
4;
> > +                                       if (vram_width)
> > +                                               *vram_width =3D mem_cha=
nnel_number * mem_channel_width;
> >                                         if (vram_type)
> >                                                 *vram_type =3D convert_=
atom_mem_type_to_vram_type(adev, mem_type);
> >                                         break;
> > @@ -345,10 +349,14 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_d=
evice *adev,
> >                                         mem_channel_number =3D igp_info=
->v21.umachannelnumber;
> >                                         if (!mem_channel_number)
> >                                                 mem_channel_number =3D =
1;
> > -                                       /* channel width is 64 */
> > -                                       if (vram_width)
> > -                                               *vram_width =3D mem_cha=
nnel_number * 64;
> >                                         mem_type =3D igp_info->v21.memo=
rytype;
> > +                                       if ((mem_type =3D=3D Ddr5MemTyp=
e) ||
> > +                                           (mem_type =3D=3D LpDdr5MemT=
ype))
> > +                                               mem_channel_width =3D 3=
2;
> > +                                       else
> > +                                               mem_channel_width =3D 6=
4;
> > +                                       if (vram_width)
> > +                                               *vram_width =3D mem_cha=
nnel_number * mem_channel_width;
> >                                         if (vram_type)
> >                                                 *vram_type =3D convert_=
atom_mem_type_to_vram_type(adev, mem_type);
> >                                         break;
> > --
> > 2.40.1
> >
