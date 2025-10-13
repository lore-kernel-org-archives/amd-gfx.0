Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99E5CCD18D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 14:25:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37BB410E460;
	Mon, 13 Oct 2025 14:25:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A+qWzHpp";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C6210E45E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 14:25:44 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2699ef1b4e3so9135035ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760365544; x=1760970344; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iONp4oArSIM3f+jIZXb2b1HFBV8P/0Q8O72A7rKLtu0=;
 b=A+qWzHpptTzHZLeL3KSnwIxP7u4dhBbHyu8uYE/0SNXRXLWVSGE8GonRrKUSgVNdqK
 TLmzItgn+h0Y87VLhWyXAEBjeWTeS9eOxDLzKGWiAnUU8M8+dH1mtET8aKIaNBAClH/U
 b6kkl+uII8UfSLkVGBoowYJxmWJimMjI7RSzWAjEBD3gcRwwwxwbrdUcN2gXPkW7XH+p
 Kb+wcGNYgYWsTuUFSvK6gTy3Tl/L2TvLWkLGWhhSfjGOaXTd6Wzjomp6T8K6nBD2ythg
 wl2qNDRlUFX9aXUBJn2ixkGlzInkXKCZZquU1cBlVyUX17wtsklxjVFBMNrCxqX9gw4K
 6eNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760365544; x=1760970344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iONp4oArSIM3f+jIZXb2b1HFBV8P/0Q8O72A7rKLtu0=;
 b=HgyivGKPWzHG8NhbEItnb+nrMul0C7QPG8AwgSzEDmCwQr5OxFH5nvNNmrtErdfRc7
 8IWOeKBZak47wFpaXBLucIpw2O03uLcXEARUq9kVRU4VOLT+tBDmp7zmuxdcXej4qLLW
 23AzIZu9UHPzQJjQb/enSLSyHbv9BjlCM94jtk5nYQ6tlFjNCJddRfvhdrXw0bhJC0XQ
 /ELnI2bZaWN/yj6aM007HrccUvEHdS4XlbW1x5qu/odoc4GNhn2kW6/mN6EIoDhNlgMR
 jJ1xf9Frwa0C/hKs4clBFiR1iXGHMyBt3kd235scVrIiIPKMw9gHHYPoZCxtFtHbf/s5
 /vcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUggk1zqmx7CIBT3Sp6vFHKBQWhLI4VRYn/XjJHAI1IDcxRSUP+y1n+XbTrrzwBchoQlal0Y3V@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxh7ck7R0AVI2/To5xdbXjHlnixLVvPi6KnYkgO7lMnMfq3jVTQ
 yjYT5HPkiI2UKL+QT3FiMLs2IBFVsKl30qu4V5DPzcec1olJy+zPeBm7IltG4C3xUUmaB+4ZB/j
 gp27p3D9y5LFcjbXb9vUJy2RGj7cNoJE=
X-Gm-Gg: ASbGncvHv9KS5rvtRljhrC6auQPdgWzJLZ6W/e+8RnDR9enho32H6nQWl9ZGu+3VeM6
 jtolYCVNJPCSo4HCVttIvTTFTr0V+cSt/ybLb45mJipVnqG53PIOAwI+FBSxO6WJFYhD3YInltQ
 YsVO+gOzOdu6EXheHBIaRb2xaDY68Ijg9XTYPKJx8JCRFUoYk5C2tTEL2EiEy/qJfp+I9j5ASPo
 abB05AgKBYAsyMdQxL+r3Ok51CH42nVao6v
X-Google-Smtp-Source: AGHT+IGranWJRNJp0CjtLvsOYZWcNEw5TSMyc0VwA+VrOxBJwvHSYbow5DGnSXEMFWyku26tm5GRF9g2ybD2gl1mSjw=
X-Received: by 2002:a17:902:c947:b0:258:a3a1:9aa5 with SMTP id
 d9443c01a7336-290270fbf6fmr173619765ad.0.1760365544302; Mon, 13 Oct 2025
 07:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
 <20251010211510.1528572-3-alexander.deucher@amd.com>
 <DS7PR12MB6005A47FAE4B2CDE179E0A20FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_PvKvj8wnNHuUWcUxGedF71vDjZA9Bq=M+N_c+x-cAXgQ@mail.gmail.com>
 <DS7PR12MB600591DF5FF29AB6E2B159A6FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB600591DF5FF29AB6E2B159A6FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Oct 2025 10:25:32 -0400
X-Gm-Features: AS18NWDXmtrw6jzONQQgOju1oB3H6n2jdz2_83-2kx6zQ7pKBcN6dmHeJ_ZoQq8
Message-ID: <CADnq5_M1EaOk98C5742aQC+_hMNhmwmf6_K02e2ccPF6FpA=DQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment to shadow
 info
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, 
 "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>
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

On Mon, Oct 13, 2025 at 10:21=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com>=
 wrote:
>
> [Public]
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Monday, October 13, 2025 9:44 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> > gfx@lists.freedesktop.org
> > Subject: Re: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment to =
shadow
> > info
> >
> > On Mon, Oct 13, 2025 at 4:54=E2=80=AFAM Liang, Prike <Prike.Liang@amd.c=
om> wrote:
> > >
> > > [Public]
> > >
> > > We may need to update the userspace EOP buffer request; otherwise, th=
e EOP
> > buffer validation may fail.
> >
> > Existing userspace should be ok.  It currently uses PAGE_SIZE which is =
larger than
> > 2048.
> The mesa uses the EOP size as max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE)=
 which is sees larger than 2048, so the kernel validates the eop buffer can=
 be successful at this point.
>
> But the mesa may need to use the shadow_info->eop_size as well in the fut=
ure?

Ideally mesa would query the kernel to get the proper minimum size.
Yogesh will be looking at this.

Alex

>
> > > Per this kernel change: Reviewed-by: Prike Liang <Prike.Liang@amd.com=
>
> >
> > Thanks!
> >
> > Alex
> >
> > >
> > > Regards,
> > >       Prike
> > >
> > > > -----Original Message-----
> > > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > > Alex Deucher
> > > > Sent: Saturday, October 11, 2025 5:15 AM
> > > > To: amd-gfx@lists.freedesktop.org
> > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > > > Subject: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment to
> > > > shadow info
> > > >
> > > > This is used by firmware for compute user queues.
> > > >
> > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 ++
> > > > drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 4 ++++
> > > > drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 4 ++++
> > > >  3 files changed, 10 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > > index fb5f7a0ee029f..7109a2ad9ec36 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > > > @@ -328,6 +328,8 @@ struct amdgpu_gfx_shadow_info {
> > > >       u32 shadow_alignment;
> > > >       u32 csa_size;
> > > >       u32 csa_alignment;
> > > > +     u32 eop_size;
> > > > +     u32 eop_alignment;
> > > >  };
> > > >
> > > >  struct amdgpu_gfx_funcs {
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > > b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > > index 6f4c2e746165e..9c79bfa4f1ef6 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > > @@ -1052,10 +1052,14 @@ static void
> > > > gfx_v11_0_select_me_pipe_q(struct amdgpu_device *adev,  static void
> > > > gfx_v11_0_get_gfx_shadow_info_nocheck(struct
> > > > amdgpu_device *adev,
> > > >                                        struct amdgpu_gfx_shadow_inf=
o
> > > > *shadow_info)  {
> > > > +     /* for gfx */
> > > >       shadow_info->shadow_size =3D MQD_SHADOW_BASE_SIZE;
> > > >       shadow_info->shadow_alignment =3D MQD_SHADOW_BASE_ALIGNMENT;
> > > >       shadow_info->csa_size =3D MQD_FWWORKAREA_SIZE;
> > > >       shadow_info->csa_alignment =3D MQD_FWWORKAREA_ALIGNMENT;
> > > > +     /* for compute */
> > > > +     shadow_info->eop_size =3D GFX11_MEC_HPD_SIZE;
> > > > +     shadow_info->eop_alignment =3D 256;
> > > >  }
> > > >
> > > >  static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device
> > > > *adev, diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > > > b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > > > index 453e4034389f2..fd37f2355f86e 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > > > @@ -909,10 +909,14 @@ static void gfx_v12_0_select_me_pipe_q(struct
> > > > amdgpu_device *adev,  static void
> > > > gfx_v12_0_get_gfx_shadow_info_nocheck(struct
> > > > amdgpu_device *adev,
> > > >                                                 struct
> > > > amdgpu_gfx_shadow_info
> > > > *shadow_info)  {
> > > > +     /* for gfx */
> > > >       shadow_info->shadow_size =3D MQD_SHADOW_BASE_SIZE;
> > > >       shadow_info->shadow_alignment =3D MQD_SHADOW_BASE_ALIGNMENT;
> > > >       shadow_info->csa_size =3D MQD_FWWORKAREA_SIZE;
> > > >       shadow_info->csa_alignment =3D MQD_FWWORKAREA_ALIGNMENT;
> > > > +     /* for compute */
> > > > +     shadow_info->eop_size =3D GFX12_MEC_HPD_SIZE;
> > > > +     shadow_info->eop_alignment =3D 256;
> > > >  }
> > > >
> > > >  static int gfx_v12_0_get_gfx_shadow_info(struct amdgpu_device
> > > > *adev,
> > > > --
> > > > 2.51.0
> > >
