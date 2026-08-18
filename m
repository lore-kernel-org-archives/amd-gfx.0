Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72017C5DF6D
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 06:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D499E10E069;
	Wed, 19 Aug 2026 06:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tMq5g2Nn";
	dkim-atps=neutral
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com
 [209.85.222.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C22A10E4BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 17:51:43 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id
 a1e0cc1a2514c-97bf92018a5so30744241.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 10:51:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787075502; cv=none;
 d=google.com; s=arc-20260327;
 b=T/MKzImNc70C2CBP+hymd76GGwaUkb3RYb85TY0WBmc4fCiyYMI+DHm1qFV0Qf3KM5
 TB4ZOQ8YRvIJc/Eb6NeWqpO1JraBt8xQabRl6dg9RcqdXC4xooX17CUulMRbNvSxJ7mW
 msOraWxVnM/Aat9d6xIUmWTpsJtTxq1Hwe1RF8EM1pBGcyaZGDDTpY0yXa38JcdNoJqe
 juC9niw5wcR868YMTxYppxE0TbNbt/yLcr9tDmIXAaRgUKt57ZIf8vl+4clDX89gpcyT
 mQyQtO1887VVb7Be1xbD3jvZah8LcIn6iOsVJWMd4xBOhvsYIzJc9PDuDvZrU2oEQaD2
 syUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fj10KLB7ZYx6C7bHsVdJNlLRg+uyLYRvpM0Ff5BHU6c=;
 fh=1lIMTLdZBjLcY/IoPHjE/tWGSc+o1WyJ2RJl7DDhnfw=;
 b=sQpd0CovjAgPJxd6IPuep7WLsMzziIzAfJ/xA6fUnPux2GuuE7OOz0atSuh4VI0Oa2
 oOzTDnhyrPBBo5GFOiHX8soNnfCp5c7l2LqazGAB8NntDIHGHAQmovXNPlqgYzUIML6V
 gtcbF8oYsnJ0nI72j8ppdHorYckbUcayVzC9yyzrOpz1JbG38AfhxtLXTx9QcOCDyBug
 5UdpU7g5EFwjWb+u+6M7wApn2OkADlBzdZwN5GQb4RCit77dp+RdKMIkiu2EhTUjO9CK
 +h0eL8FbukdDW5iKbpmiiHPMkg1q9hm9JGux02MRGSutXF7+B0euveA6se47unHnWHOX
 a58A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787075502; x=1787680302; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fj10KLB7ZYx6C7bHsVdJNlLRg+uyLYRvpM0Ff5BHU6c=;
 b=tMq5g2NnRWF06AQtuUu1NfxYL6C2EQqY/tjdMS0PxOA0jcktiExj3CYplerAZjaLc2
 TnC+TpEoDce69dLD34E8orUgok/L0FiIewQUcbsTfgEzLbvhVcRQUdONR488wR5LiSuA
 k150x0uJAMZ6+IOBr94YshYaUzXczHbUeGDcI5c73iHiMEXtWANW5udZG9UxQVQyvuPH
 jIjCmW/1fqSsZoq1dlzJ1z+mtGTKGunAs6WkIr3qdgbm/corT72/6rxt2Umxax6Ui2kK
 xGFEWUSvuE3pNr+T7M3wQouQz9uuJ3ToR3QBPgcyax5YJnmIKSTBxZC5hcpBMBxxBMdA
 r3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787075502; x=1787680302;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fj10KLB7ZYx6C7bHsVdJNlLRg+uyLYRvpM0Ff5BHU6c=;
 b=f10e6mEBIRLwylGGkqJ3OEKcHEhMumBUciPksurF0POR430uGNwF9YcBfZXpxRFE7f
 CQOjY3J6Ek5nijS9mpJH2nfG2ShItt+h7seN2U2ZK1iAp+WommGT/aFMUQ+TAleaXvFl
 gJldFH1EuB5L+vU9b8+UfRnLzz1gaZctSoEaPj8uJVVX8xKuAR/AWFBp8G0ZFDGAvLcr
 YSzoKRrpHeEysUAe6PIg9cy/JhUeZ9UJ1IsuIFZS1WIuLdESjjSHZ08+WzZa5ZZJwt00
 yuC2TfpVlNhm+PiYAgsjYIyzmH2zfzc51NB9P5uW1OPKYvHvGAzkcnTpKs7A6fYk5tjg
 h7JQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOUuMXXKgS1l2FeDj0Y74mOCx1cVb0e/4OhSIpjpiGAnjcu/0glre/t54CNt8lzD4o0iWDwxCC@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8Nyt3o4YpG7fjY7EvlAETrRav7iOAdGVOLkcwRZWaGFdJbAWI
 HID84kh6hu8XvtVlB9E0+FtcJtmm3KfY0FYrHdxiVvTmAu2C3OO8J6+tQKNgeMTnvPdPVVSWMEi
 Y3yMS1+07+MVV63sSxoZ4vJ0qe6QY4wc=
X-Gm-Gg: AR+sD13sWgR3fuyT3o5H+Uwzl/hprE+x1NtF9tUNCeXtxGaX0yUmCa5lC6flr4Ofbwj
 hMirHQb574y8ZPpoQfTWqcU0F3CTZDDGVJy6CI9itZqGv8Jwx5LDcvqKHELymLKvV22/8+JGahc
 Mhu1m24BZNZ9/8AW7ICzuNhVC/tut5sV2DYaKmG+XKP2jiP7P2LWjmeG53A7pnKtzYoEcievHBx
 JSdPf3SeXAeYlLM3bLlJ9Ip3D6dUgszHeJDQHjdA6dZOHIZE9LB2DeypFzGqp4otipdu7mNQXop
 7xVytkRsZ1cSlch209CSm/H09h94Dhi3Oj306EU15V4gkqhxe00wPIB80qeoV7AzlJ6QnOKZMLH
 nag==
X-Received: by 2002:a05:6102:94c:b0:774:ffde:3d47 with SMTP id
 ada2fe7eead31-774ffde3e02mr2066845137.7.1787075501861; Tue, 18 Aug 2026
 10:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260818-amdgpu-strcpy-v1-1-3ee9b111fafe@gmail.com>
 <CADnq5_NZQrSAqV4cTz8HaJYsatb9VWgc4J3--gTWvF8NTz6-xg@mail.gmail.com>
 <20260818152113.31b72e30@pumpkin>
 <CADnq5_MOSxt4=15C941PyuKH0V6bubx7Wi55x5zoWjAsBS2ffg@mail.gmail.com>
In-Reply-To: <CADnq5_MOSxt4=15C941PyuKH0V6bubx7Wi55x5zoWjAsBS2ffg@mail.gmail.com>
From: Amin <amin.gattout@gmail.com>
Date: Tue, 18 Aug 2026 19:51:30 +0200
X-Gm-Features: AcwNN1VaQkT_kHjaCjLZSVMRLFOY1oYzfkYTo6gr0E6vTM151Wv16NiuEE2yq98
Message-ID: <CAHfa7xV-pPN0nAdd4q=bDYS59snoMf563OwS96_LLg4eb3yqQQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Replace deprecated strcpy with strscpy
To: Alex Deucher <alexdeucher@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

You raise a fair point about the compile-time truncation check.
My reasoning follows the kernel's own deprecation guidance, which
explicitly lists strcpy() as deprecated and names strscpy() as the
safe replacement:

https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

Regards.
Amin.

Le mar. 18 ao=C3=BBt 2026 =C3=A0 19:39, Alex Deucher <alexdeucher@gmail.com=
> a =C3=A9crit :
>
> On Tue, Aug 18, 2026 at 10:21=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Tue, 18 Aug 2026 09:01:43 -0400
> > Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > > Applied.  Thanks!
> > >
> > > On Tue, Aug 18, 2026 at 7:10=E2=80=AFAM Amin Gattout <amin.gattout@gm=
ail.com> wrote:
> > > >
> > > > strcpy() has been deprecated because it performs no bounds checking
> > > > on the destination buffer, which can lead to buffer overflows. Repl=
ace
> > > > it with the safer strscpy().  No functional changes.
> > > >
> > > > Signed-off-by: Amin Gattout <amin.gattout@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_mca.c
> > > > index cc6d1a4e4c3a..1caa393c44d5 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> > > > @@ -97,7 +97,7 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_devi=
ce *adev)
> > > >                 return err;
> > > >         }
> > > >
> > > > -       strcpy(ras->ras_block.ras_comm.name, "mca.mp0");
> > > > +       strscpy(ras->ras_block.ras_comm.name, "mca.mp0");
> >
> > I missed this being proposed.
> > Both strcpy() and strscpy() get converted to the same memcpy()
> > (which might itself get converted to writing a 64bit constant).
> >
> > But if the string were too long strcpy() would generate a compile error
> > whereas strscpy() just trunctates the string.
> >
> > Which one is better?
>
> I don't know.  I can go either way on this.
>
> Alex
>
>
> >
> >         David
> >
> > > >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> > > >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_=
BLOCK__MP0;
> > > >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UN=
CORRECTABLE;
> > > > @@ -122,7 +122,7 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_de=
vice *adev)
> > > >                 return err;
> > > >         }
> > > >
> > > > -       strcpy(ras->ras_block.ras_comm.name, "mca.mp1");
> > > > +       strscpy(ras->ras_block.ras_comm.name, "mca.mp1");
> > > >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> > > >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_=
BLOCK__MP1;
> > > >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UN=
CORRECTABLE;
> > > > @@ -147,7 +147,7 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_d=
evice *adev)
> > > >                 return err;
> > > >         }
> > > >
> > > > -       strcpy(ras->ras_block.ras_comm.name, "mca.mpio");
> > > > +       strscpy(ras->ras_block.ras_comm.name, "mca.mpio");
> > > >         ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MCA;
> > > >         ras->ras_block.ras_comm.sub_block_index =3D AMDGPU_RAS_MCA_=
BLOCK__MPIO;
> > > >         ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UN=
CORRECTABLE;
> > > >
> > > > ---
> > > > base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
> > > > change-id: 20260818-amdgpu-strcpy-0e92d18299c6
> > > >
> > > > Best regards,
> > > > --
> > > > Amin Gattout <amin.gattout@gmail.com>
> > > >
> > >
> >
