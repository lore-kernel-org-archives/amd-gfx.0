Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BC1C5DF82
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 17:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28CE210E531;
	Tue, 18 Aug 2026 17:56:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n/EOBuP7";
	dkim-atps=neutral
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
 [209.85.217.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C1F710E087
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 17:56:20 +0000 (UTC)
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-73e516d6ddcso9281137.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 10:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787075779; cv=none;
 d=google.com; s=arc-20260327;
 b=Fvi0CJSUD/Zq2Tbsm8EUy69kBRBtrDqAnxGEl4Y6pNvOnDwJUFQAk9Kqxki/V4Yhab
 W86cbwMu/mYCx1l8j3JWFYGIsm8cYQp7ZF2aXDMzr7ygdk2LKow1D6XVhNM6k8kxRaxt
 BZkpq/KbuaxZndHnr8WhhkyiIV6DVb6kDh5/dBEAKv4dB1xzZs3emYrV8bAkuzVUjAnu
 TYQoxuG0Un8ljEH6N/JCzjFdQAqocHhW2rSygHIImBE/9yQ+rs3dM0IOILY5kqMrmCCQ
 gXdQ4v2GJMgqXjA+LApttJerBP0i1Q3W3vU84qa1cOtGGyxuwZcditvMZcMJ5fmlTNWo
 BuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O2Guo2cfQRnj9tcFfEAaGvAISaRSftC/+14D5jKa588=;
 fh=6iciWQ6ePHjRXa7VAdA3Cv9WyiVoQ8R+cZgN18/FND0=;
 b=WVhpY8vqmAltSGc23ZrFM8ZQ3ImySmjqfdNpT2p52QEn51KSC5C50uq4nfa1ceH9Xd
 kRjdG8N5rXP1HAS6FZASXbykcPiTtzm/8LFablwIYP6ORjOFc31gNESNMIgDRFWfusUp
 5Km5T1b2Jqra4oxOJJHo1yeSO/gM6GMCYeg2JkiLBpYKIX0PSFf0BhFRLZ2zajM2Rdv0
 TG9llrMjt8+OCbMa/QrJkVi+4zWmF3SRAFHuV391rn1kwM0s08GoVgiMEXoMB1e0tou/
 93cQqv2pmNMLHQL7eht2sPQdmtYX8qNkBQ/m8K6Jl2LETR2adtEodGCaaNt85PCQToli
 w7TQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787075779; x=1787680579; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O2Guo2cfQRnj9tcFfEAaGvAISaRSftC/+14D5jKa588=;
 b=n/EOBuP7y6maEoZ+y3fT8TzcheUxorEy8DFa4p+jRIlhzM3V2xsnj0iu2T/gfxC0Op
 dsc0XAta8VkowaWb8kAlbDQY7U+wXLscks3g/zY7kpnVMiFLCtDzzJa+qp5TV1F89OiC
 LQIKcOQS9RwKRHbMqPfCyVR6Nz1+iPFqOrsC6GlEwKHOrJk2YOws3QaoF5tsnT+IsVFg
 +KMGEVl71X3YwuEYgVJr8yswVvkkywMKw+DZWVpt5cyBeAKvz1J0Yr809lvVGJP3Auso
 FUdcUHJGwjzNHo8A6kkEKb/tk9cMxwHj32jEsMfiVxjDuiqGAVmTZOBITyn+F7Moa8iA
 92bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787075779; x=1787680579;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O2Guo2cfQRnj9tcFfEAaGvAISaRSftC/+14D5jKa588=;
 b=MiopcFP76hR+v9emL9xaxMZ87aZiX1/cs1MlfTHN9Be+yBzjXl2LgUuIvHBrRVPVer
 wO9rJsdXjRR1kmDc8MGeTmAjcIEJK5ZA2s0eAcG24BRR1zGmIoMO+uwDEqu5odHGQ7SF
 6dpPIhSi78UdFFu+mnUz67muznJNbni6cvAaYAwt5k6+klXUemZGla49zsxzZUqC4eu0
 FFsbICSVIkHNnAGk2Eaa9IsRW+9OQF3QNNG2ERet+QwPbkm5BkjnGT0b9PRmekIfXVzN
 z0QPgKkm7ag3DTZFLpIQ4AL9MRA6GWgdtenZlI81UFOEa6TUhIiuzkZ/Peb2sE6hhgip
 Rqig==
X-Forwarded-Encrypted: i=1;
 AHgh+Rod5OQd1zwzc81AbHQEXvS2t1KjooDQAKx5555KpddDbq9/Uqkk/w4TA1wRe7ooyQnFvP/WL/dB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YylHmWrqRRUKq+Cht1AlqMI3DI3U+eTARoAlHnl9Ld01b5/EFoW
 M966e1eh3+hFSTR/e8oM9gPVtXrrPA0E3a7eJex1a2P1xNFreNQNrh2GANbr+aKb6VSpzLyh9DI
 R/GZlsS2d93sKM9MzBKnjRU2aoVpyoe4=
X-Gm-Gg: AR+sD11CYSXv/w87u1FQP0nWzFTus1LZ+shcZMAr48reCxbCcdKh42T5gpnENQ+HwoP
 8XTCUQi4f9HlhPeFvnQMK5ea4JHM1rKAj2x5TPvq6z3dcE7f/ztdYqqqPz9k3Z8S0ooY6y6n4c7
 6t7f9+WVNTCChjj6BWKiSA8u/HN6RLvNcIgzfLBxji8XpLfL/EIc3Q5M+0UQtGXnFDyi7uIgv+Z
 PT46KhncJ0Z2SjObjKMBpPPyUmalx6AAssIX6qLnmHWNwVO+UtPdYw5YDQPhhzuiB97L68Mswa/
 20W18rgUMyz3PhHOjxkmW0rnbaeQTLU5EE/Au9T1sJNm1ep6W6+WI8598a6nxlUHZF3b1552Mt5
 YrUL5x+Pq1S7nzZkaU8PYvgkieHaGDAhMXkY1zg36NQ==
X-Received: by 2002:a05:6122:6d03:b0:5bd:ae1c:afcf with SMTP id
 71dfb90a1353d-5c591f935b9mr3403639e0c.3.1787075778874; Tue, 18 Aug 2026
 10:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260818-amdgpu-strcpy-v1-1-3ee9b111fafe@gmail.com>
 <CADnq5_NZQrSAqV4cTz8HaJYsatb9VWgc4J3--gTWvF8NTz6-xg@mail.gmail.com>
 <20260818152113.31b72e30@pumpkin>
 <CADnq5_MOSxt4=15C941PyuKH0V6bubx7Wi55x5zoWjAsBS2ffg@mail.gmail.com>
 <CAHfa7xV-pPN0nAdd4q=bDYS59snoMf563OwS96_LLg4eb3yqQQ@mail.gmail.com>
In-Reply-To: <CAHfa7xV-pPN0nAdd4q=bDYS59snoMf563OwS96_LLg4eb3yqQQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Aug 2026 13:56:06 -0400
X-Gm-Features: AcwNN1UV1BDx6Pxjqmx1q4CmVpcvGtmNjpr811EmS5vHb4kE8vmCcTuMpJjKRpk
Message-ID: <CADnq5_NhH0WC_r7SVPyXOG4r36O++sUGis2Ej-A9J4MNJu7GoA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Replace deprecated strcpy with strscpy
To: Amin <amin.gattout@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Aug 18, 2026 at 1:51=E2=80=AFPM Amin <amin.gattout@gmail.com> wrote=
:
>
> You raise a fair point about the compile-time truncation check.
> My reasoning follows the kernel's own deprecation guidance, which
> explicitly lists strcpy() as deprecated and names strscpy() as the
> safe replacement:
>
> https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

RIght.  My thinking was that strscpy() would be preferred to avoid
static checkers from complaining about strcpy().

Alex

>
> Regards.
> Amin.
>
> Le mar. 18 ao=C3=BBt 2026 =C3=A0 19:39, Alex Deucher <alexdeucher@gmail.c=
om> a =C3=A9crit :
> >
> > On Tue, Aug 18, 2026 at 10:21=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Tue, 18 Aug 2026 09:01:43 -0400
> > > Alex Deucher <alexdeucher@gmail.com> wrote:
> > >
> > > > Applied.  Thanks!
> > > >
> > > > On Tue, Aug 18, 2026 at 7:10=E2=80=AFAM Amin Gattout <amin.gattout@=
gmail.com> wrote:
> > > > >
> > > > > strcpy() has been deprecated because it performs no bounds checki=
ng
> > > > > on the destination buffer, which can lead to buffer overflows. Re=
place
> > > > > it with the safer strscpy().  No functional changes.
> > > > >
> > > > > Signed-off-by: Amin Gattout <amin.gattout@gmail.com>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_mca.c
> > > > > index cc6d1a4e4c3a..1caa393c44d5 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> > > > > @@ -97,7 +97,7 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_de=
vice *adev)
> > > > >                 return err;
> > > > >         }
> > > > >
> > > > > -       strcpy(ras->ras_block.ras_comm.name, "mca.mp0");
> > > > > +       strscpy(ras->ras_block.ras_comm.name, "mca.mp0");
> > >
> > > I missed this being proposed.
> > > Both strcpy() and strscpy() get converted to the same memcpy()
> > > (which might itself get converted to writing a 64bit constant).
> > >
> > > But if the string were too long strcpy() would generate a compile err=
or
> > > whereas strscpy() just trunctates the string.
> > >
> > > Which one is better?
> >
> > I don't know.  I can go either way on this.
> >
> > Alex
> >
> >
> > >
> > >         David
> > >
> > > > >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> > > > >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MC=
A_BLOCK__MP0;
> > > > >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_=
UNCORRECTABLE;
> > > > > @@ -122,7 +122,7 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_=
device *adev)
> > > > >                 return err;
> > > > >         }
> > > > >
> > > > > -       strcpy(ras->ras_block.ras_comm.name, "mca.mp1");
> > > > > +       strscpy(ras->ras_block.ras_comm.name, "mca.mp1");
> > > > >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> > > > >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MC=
A_BLOCK__MP1;
> > > > >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_=
UNCORRECTABLE;
> > > > > @@ -147,7 +147,7 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu=
_device *adev)
> > > > >                 return err;
> > > > >         }
> > > > >
> > > > > -       strcpy(ras->ras_block.ras_comm.name, "mca.mpio");
> > > > > +       strscpy(ras->ras_block.ras_comm.name, "mca.mpio");
> > > > >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> > > > >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MC=
A_BLOCK__MPIO;
> > > > >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_=
UNCORRECTABLE;
> > > > >
> > > > > ---
> > > > > base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
> > > > > change-id: 20260818-amdgpu-strcpy-0e92d18299c6
> > > > >
> > > > > Best regards,
> > > > > --
> > > > > Amin Gattout <amin.gattout@gmail.com>
> > > > >
> > > >
> > >
