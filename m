Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EAFC5DF6D
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 06:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E3C410ED39;
	Wed, 19 Aug 2026 06:48:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Az+NFpOA";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C66E10EBBA
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 14:21:23 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4994c49f588so12849655e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787062882; x=1787667682; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xh6sznIcTWQR5cHVojCsxyM98WEjQuypf/fmpziWKAg=;
 b=Az+NFpOAu6PbeZF6+mJ3XoeEpyYSuqIb8lLQqHRDjm+5RNzBervVUXprw/mDDb0PHr
 SNUX0G52Itk0/FwKlSqbtgMeFwzJPjQHMCny/tXlPyYTrmae+UaLmFvaFE1rLFvEN+jf
 0LokU34HIPjfPWRRjr63FoWDd9RexVfik5MmMa5gr+mmUYrPO6kwwiPI8rpQg3pjkgi8
 cKjMAk8Szwp3J4zLCSyzyBJLNjIeF/IBn/JAXI/KDTAO3zpdv0xHJQObaKefiM7RyZri
 klpeB+jHVzlwQ30bK0iweabxQG3TxogR1c14HIW3oryz+5RK5/vN7qcyYSkzoH15WadM
 MRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787062882; x=1787667682;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xh6sznIcTWQR5cHVojCsxyM98WEjQuypf/fmpziWKAg=;
 b=IwkEyYrCIfMMRUu+Wk7cgKx9HfKSumTItnl91GYSwgZr/V3UhnH7h0m1eevTJjh+f5
 SwIes7fwP+8QV2rTEjx3P2fkG/dBySCEOceyWqxJJZ2x+ROFKyZcfxChY4IHdXAexM6b
 lflwlmBmyVoPOA0Hajs3Ke6/3GQuoAwPzin/PqBxl5ysFZJ6xctEdFtH2TEexw3P3tE/
 kr39k40IRhOfah6fvDJ1b/Xz3n3F0N5iURP4hQiP/kUmwqptwidBHZiVYH5vExjkDLBa
 PL5UCWd4eDVaxHVtMwnO6j/LhavhQtS8AnU5iZhoTyu6vrC9/wJebWDV/MsaNmjkBayt
 96pQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9DOp6M64n64iiY+ocQPQ09PCD1eV0Pt+CF/4m+YpCFCg+3zgG6hyESYJNa932bse2QURd/DAw@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwL9fZGzuuSwlr21aDHV8pVeAEck2jl/+D0LnEw5UMgEyozJFyD
 L8D/aeJNg9+sX/NyVkQX9BOpwa3QjUNx/A8BvKugEIY5be6qfYNpHkX7
X-Gm-Gg: AR+sD10Ra3aEZ/XHr1ViYU1mcwFlDfkKhe1nFq6xU+nnCLGaWpQvq2ecJ4KpoIya0eh
 a1JMFx1QM0KiG7U9K5N2k5Y+zG+bZHJzrysdwf7e8axn+HBUZpiXhfnvx3oHfIqx4iTafPbUmtZ
 UUiAsW4MvCcfytdv50x9+afUtZ31NiyuKHdpGk4D5ii5/1IcMDUKkA+P1KgEH8tvntQYH3yd72N
 c10eDnBYM7xJBYnHq3V4t2z0PnP0Ula2skQYLj8G7HyiGzXFnWwzlSPv2HtgGmgvTJPLhcB6INN
 lZCg2ReIpGlxEmh1Dt5N27m4DXfA3zPphMTfnrprFAA25m+Ycvo7I5Kz30/pd3QH5im0VHkR/9h
 nj+qj6YPzBVsdD1LmkGQxhP655YsMF6J2dB/bIvvFa0avUJKuWBebjDuTEAtYpXnmXDVokJiuOL
 tCsbYgqctHLK0Il6GHTn7Ag9inWqmqze/gK3xwvPhsq8udjGMj8cgu+OHDsTk8BfBKGX5CnXlz3
 7agIbt6s1fh6VHsy0JcnHdkIA==
X-Received: by 2002:a05:600c:858e:b0:499:5f81:8ca1 with SMTP id
 5b1f17b1804b1-499a08d2c5fmr119294355e9.6.1787062881505; 
 Tue, 18 Aug 2026 07:21:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b81715sm12428769f8f.35.2026.08.18.07.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:21:20 -0700 (PDT)
Date: Tue, 18 Aug 2026 15:21:13 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Amin Gattout <amin.gattout@gmail.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: Replace deprecated strcpy with strscpy
Message-ID: <20260818152113.31b72e30@pumpkin>
In-Reply-To: <CADnq5_NZQrSAqV4cTz8HaJYsatb9VWgc4J3--gTWvF8NTz6-xg@mail.gmail.com>
References: <20260818-amdgpu-strcpy-v1-1-3ee9b111fafe@gmail.com>
 <CADnq5_NZQrSAqV4cTz8HaJYsatb9VWgc4J3--gTWvF8NTz6-xg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:48:34 +0000
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

On Tue, 18 Aug 2026 09:01:43 -0400
Alex Deucher <alexdeucher@gmail.com> wrote:

> Applied.  Thanks!
>=20
> On Tue, Aug 18, 2026 at 7:10=E2=80=AFAM Amin Gattout <amin.gattout@gmail.=
com> wrote:
> >
> > strcpy() has been deprecated because it performs no bounds checking
> > on the destination buffer, which can lead to buffer overflows. Replace
> > it with the safer strscpy().  No functional changes.
> >
> > Signed-off-by: Amin Gattout <amin.gattout@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_mca.c
> > index cc6d1a4e4c3a..1caa393c44d5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> > @@ -97,7 +97,7 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device *=
adev)
> >                 return err;
> >         }
> >
> > -       strcpy(ras->ras_block.ras_comm.name, "mca.mp0");
> > +       strscpy(ras->ras_block.ras_comm.name, "mca.mp0");

I missed this being proposed.
Both strcpy() and strscpy() get converted to the same memcpy()
(which might itself get converted to writing a 64bit constant).

But if the string were too long strcpy() would generate a compile error
whereas strscpy() just trunctates the string.

Which one is better?

	David

> >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BLOC=
K__MP0;
> >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCORR=
ECTABLE;
> > @@ -122,7 +122,7 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device=
 *adev)
> >                 return err;
> >         }
> >
> > -       strcpy(ras->ras_block.ras_comm.name, "mca.mp1");
> > +       strscpy(ras->ras_block.ras_comm.name, "mca.mp1");
> >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BLOC=
K__MP1;
> >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCORR=
ECTABLE;
> > @@ -147,7 +147,7 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_devic=
e *adev)
> >                 return err;
> >         }
> >
> > -       strcpy(ras->ras_block.ras_comm.name, "mca.mpio");
> > +       strscpy(ras->ras_block.ras_comm.name, "mca.mpio");
> >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_BLOC=
K__MPIO;
> >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCORR=
ECTABLE;
> >
> > ---
> > base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
> > change-id: 20260818-amdgpu-strcpy-0e92d18299c6
> >
> > Best regards,
> > --
> > Amin Gattout <amin.gattout@gmail.com>
> > =20
>=20

