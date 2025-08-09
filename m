Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7812C87FCB
	for <amd-gfx@archiver.kernel.org>; Sat,  9 Aug 2025 19:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BF1B10E00F;
	Sat,  9 Aug 2025 19:56:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JVLd45zz";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CFC010E00F
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Aug 2025 19:56:27 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-af95525bac4so594657366b.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 09 Aug 2025 12:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754769386; x=1755374186; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RF38vWSJfW/pOyo6T4sgD/VVWC8vVkqw6fz/PzPAuTQ=;
 b=JVLd45zzlIJTOAZizHQYofsaB9N9laSGq+6C3mfUPwLmVqflzjzj//eVaiKFPC4M8+
 0B9+Zav/M6bcTDwEHyYPMdsRFuaoAfFuFw/4XX/8kyeffxz4jz17LokYPj4hBx3hXZVD
 ardSmCYii5l4RnY0p7CqyORFt/brLYx54k2czlFeJ0jTx5ChExI6g88IY4VcGqdUrym/
 sjwofvHH/caF6LSIQTZAM9jGRb68sYGZv0vJWBOJIfxVM543HrmBDj5q7RAOTaI7FioX
 HMayOr3D4jl0ohwvOy6DlDeIVl82VNRbm5+AEj0QJ8Usxjtw9HyF/jycIec1U/IU4FVW
 HXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754769386; x=1755374186;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RF38vWSJfW/pOyo6T4sgD/VVWC8vVkqw6fz/PzPAuTQ=;
 b=UaphXA9wf0amDBA1l+Mf4W9fX+QD19B1puSCEm/Xlriym7e1TX5m4ouBOcTxiVlSIS
 gSiVXGUjQ8SaSG2tdvE9Us7atlPuDY93dx3BuPkb5b94v5DyEKYk5ep7ZvPqF2iWLlKS
 IwHUQBCrK1a1WXRxHrhOpI5JzP/fyuQzPF3bF7zErXkFvKSkkw+6F6sUwDO4M0j32JEI
 U5xGveZrbJSVTnGFY7eJILofLZjRMcLPWCKW+sV1i2IhJ/bmkAebbdW3wTMIzCtdCrqW
 iWPG40672rYPZmVos/JavJFAHIOd2a8QaaJ9RpR+Kk0Ib0Ak8jDTpft8YmrIbfCoBIvj
 ynpg==
X-Gm-Message-State: AOJu0YzVTn7jaa40UijYoIl0UU0OySeysu1kYStIn2/TRyAPzdxegW+4
 no9fXnoVVSV++xrJnomBvZYvpGrMwd3CJvDSkAatvpS5EtnaRQ2XdAuN
X-Gm-Gg: ASbGncsrCTOJpplz8gFozrOHZ8Pj7QGxgoHf7NYOB7mTOu3AdWKvCMJhMazRj+fXuPR
 MoxctydTfQOE2AxSkqokIGg9S3jF9f8xaAKFqqoVOqAmgEWg+ExptD+vpWwq+wmB/KM/99CHDxt
 byfzDajS7JCbPrNbyV1y4ry+Du9YxgP7i3mIMY8w4BiQ5y880sMLa/hV/Af42G3H/FU6Nx1MIBd
 uIz+MT7VG1yPKGL2wk6JspAFdGFsUN8Qg0AXZDuOI6WritVf1biEmIB0TdqRdgS1+rxRKdauGfv
 ZAM9vKd4TPe1i/bpXgB1/wwASM33nhCnp1ZXAzuDqkJto3tRS1GDq+7woIo4pk1NFlw8NOXRakU
 90VSNCgv2hmFfAV+Y3uKovfh5S5nwOd/f
X-Google-Smtp-Source: AGHT+IG0aFl36ku3DTBCmMwGCaalNOG90EVWWLq0RTfuop1LtJrXFRpgnlpH92LvqDqhL4GmMqb0vA==
X-Received: by 2002:a17:907:c25:b0:ade:316e:bfc with SMTP id
 a640c23a62f3a-af9c6457eb7mr638227966b.21.1754769385445; 
 Sat, 09 Aug 2025 12:56:25 -0700 (PDT)
Received: from [192.168.88.129] ([212.92.10.129])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a0a1bf9sm1718493666b.31.2025.08.09.12.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Aug 2025 12:56:25 -0700 (PDT)
Message-ID: <86487e05ea8cf4e720e05fb7b4bf3f464937c319.camel@gmail.com>
Subject: Re: [PATCH 4/6] drm/amd/pm: Fix si_upload_smc_data
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Date: Sat, 09 Aug 2025 21:56:24 +0200
In-Reply-To: <CADnq5_NmfCoB-Bk+TC9WafXdvMhQr9sUyoodnhOf5__TY5mr5g@mail.gmail.com>
References: <20250804134154.95875-1-timur.kristof@gmail.com>
 <20250804134154.95875-5-timur.kristof@gmail.com>
 <CADnq5_P6EsOrX8e8B3bRh_KEaPVisUAEWxZ9uXX62TY=a-dO3g@mail.gmail.com>
 <4c002dfef88f033832d0be5221fed0019c0feaf0.camel@gmail.com>
 <CADnq5_MSd5CeDwFH2n7fqNtmt9iiXaRrruSJJ887dG_CK=4jGQ@mail.gmail.com>
 <11315cd2289dd111db673b0d3832f373d268c833.camel@gmail.com>
 <CADnq5_NmfCoB-Bk+TC9WafXdvMhQr9sUyoodnhOf5__TY5mr5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
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

On Fri, 2025-08-08 at 15:04 -0400, Alex Deucher wrote:
> On Fri, Aug 8, 2025 at 4:22=E2=80=AFAM Timur Krist=C3=B3f
> <timur.kristof@gmail.com> wrote:
> >=20
> > On Mon, 2025-08-04 at 13:31 -0400, Alex Deucher wrote:
> > > On Mon, Aug 4, 2025 at 12:16=E2=80=AFPM Timur Krist=C3=B3f
> > > <timur.kristof@gmail.com> wrote:
> > > >=20
> > > > On Mon, 2025-08-04 at 11:32 -0400, Alex Deucher wrote:
> > > > > On Mon, Aug 4, 2025 at 9:42=E2=80=AFAM Timur Krist=C3=B3f
> > > > > <timur.kristof@gmail.com> wrote:
> > > > > >=20
> > > > > > The si_upload_smc_data function uses
> > > > > > si_write_smc_soft_register
> > > > > > to set some register values in the SMC, and expects the
> > > > > > result
> > > > > > to be PPSMC_Result_OK which is 1.
> > > > > >=20
> > > > > > The PPSMC_Result_OK / PPSMC_Result_Failed values are used
> > > > > > for
> > > > > > checking the result of a command sent to the SMC.
> > > > > >=20
> > > > > > However, the si_write_smc_soft_register actually doesn't
> > > > > > send
> > > > > > any commands to the SMC and returns zero on success,
> > > > > > so this check was incorrect.
> > > > > >=20
> > > > > > Fix that by correctly interpreting zero as success.
> > > > > > This seems to fix an SMC hang that happens in
> > > > > > si_set_sw_state.
> > > > > >=20
> > > > > > Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
> > > > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > > > ---
> > > > > > =C2=A0drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 31
> > > > > > +++++++++++++-
> > > > > > ----
> > > > > > ----
> > > > > > =C2=A01 file changed, 19 insertions(+), 12 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > > > > b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > > > > index 33b9d4beec84..e9f034ade214 100644
> > > > > > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > > > > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > > > > @@ -5820,6 +5820,7 @@ static int si_upload_smc_data(struct
> > > > > > amdgpu_device *adev)
> > > > > > =C2=A0{
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_crtc *=
amdgpu_crtc =3D NULL;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (adev->pm.dpm.new=
_active_crtc_count =3D=3D 0)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > > @@ -5837,20 +5838,26 @@ static int
> > > > > > si_upload_smc_data(struct
> > > > > > amdgpu_device *adev)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (amdgpu_crtc->lin=
e_time <=3D 0)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > >=20
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (si_write_smc_soft_reg=
ister(adev,
> > > > > > -
> > > > > > SI_SMC_SOFT_REGISTER_crtc_index,
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 amdgpu_crtc-
> > > > > > >crtc_id) !=3D
> > > > > > PPSMC_Result_OK)
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D si_write_smc_soft=
_register(
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 adev,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 SI_SMC_SOFT_REGISTER_crtc_index,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_crtc->crtc_id);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > > > >=20
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (si_write_smc_soft_reg=
ister(adev,
> > > > > > -
> > > > > > SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 amdgpu_crtc->wm_high
> > > > > > /
> > > > > > amdgpu_crtc->line_time) !=3D PPSMC_Result_OK)
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D si_write_smc_soft=
_register(
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 adev,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_crtc->wm_high / amdgpu_crtc-
> > > > > > >line_time);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > > > >=20
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (si_write_smc_soft_reg=
ister(adev,
> > > > > > -
> > > > > > SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 amdgpu_crtc->wm_low
> > > > > > /
> > > > > > amdgpu_crtc->line_time) !=3D PPSMC_Result_OK)
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D si_write_smc_soft=
_register(
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 adev,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_crtc->wm_low / amdgpu_crtc-
> > > > > > >line_time);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > > >=20
> > > > > This patch changes the behavior of this function (i.e., it
> > > > > always
> > > > > returns 0 before this patch).=C2=A0 Not sure if that matters or
> > > > > not.
> > > > > I
> > > > > think this could be simplified to something like the
> > > > > following to
> > > > > retain the current behavior.
> > > >=20
> > > > Actually now that I think of it more, I think it may be
> > > > entirely
> > > > unnecessary to check the return value.
> > > >=20
> > > > si_upload_smc_data calls:
> > > > si_write_smc_soft_register
> > > > amdgpu_si_write_smc_sram_dword
> > > > si_set_smc_sram_address
> > > >=20
> > > > This last one, si_set_smc_sram_address returns -EINVAL when its
> > > > smc_address parameter is not dword-aligned or out of bounds.
> > > > Otherwise
> > > > all of the above functions return 0 (success). Considering that
> > > > all
> > > > of
> > > > the addresses passed by si_upload_smc_data are compile time
> > > > constants,
> > > > we know they are correct so there is no reason why any of those
> > > > functions would return an error.
> > > >=20
> > > > Looking at other callers of si_write_smc_soft_register, I see
> > > > that
> > > > they
> > > > don't check the return value at all.
> > > >=20
> > > > So, I'd actually simplify this even more and just not check the
> > > > return
> > > > values. What do you think about that?
> > >=20
> > > Sure.=C2=A0 Works for me.
> > >=20
> > > Alex
> >=20
> > Alex, before I send a new version of this series, can you please
> > clarify what these registers are and verify that the actual
> > programming
> > of these SMC registers is correct?
>=20
> This code was based on what the windows code did.

Makes sense. Let's assume that it's correct then.

>=20
> >=20
> > The reason I ask is because due the the bug being fixed by these
> > patch,
> > these registers were never actually written, which makes me wonder
> > if
> > the value we program them to is actually correct.
> >=20
> > I mean the values that we program these registers to:
> >=20
> > SI_SMC_SOFT_REGISTER_crtc_index - we just program the index of the
> > first active CRTC, seems straightforward enough, but it's unclear
> > what
> > the SMC uses this for. Why does the SMC care which crtc we use?
> >=20
> > SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min - programmed to the
> > high
> > display watermark divided by the line time. But I can't find any
> > information about what this information represents or what the SMC
> > uses
> > it for. Judging by the name it has to do with mclk switching?
> >=20
> > SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max - same concern as
> > _min.
>=20
> For mclk switching, the mclk has to be changed during the display
> blanking period to avoid display artifacts.=C2=A0 This is presumably part
> of that, but I don't remember exactly what all of these do anymore.
>=20
> Alex

Thank you. I will make the changes that we discussed above and send a
second version of this series next week.

>=20
> >=20
> > Thanks,
> > Timur
> >=20
> >=20
> > >=20
> > > >=20
> > > >=20
> > > > >=20
> > > > > diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > > > b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > > > index 52e732be59e36..3dd0115aa15f8 100644
> > > > > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > > > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > > > > @@ -5836,17 +5836,17 @@ static int si_upload_smc_data(struct
> > > > > amdgpu_device *adev)
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (si_write_smc_soft_=
register(adev,
> > > > >=20
> > > > > SI_SMC_SOFT_REGISTER_crtc_index,
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 amdgpu_crtc->crtc_id)
> > > > > !=3D
> > > > > PPSMC_Result_OK)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 amdgpu_crtc->crtc_id))
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (si_write_smc_soft_=
register(adev,
> > > > >=20
> > > > > SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 amdgpu_crtc->wm_high /
> > > > > amdgpu_crtc->line_time) !=3D PPSMC_Result_OK)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 amdgpu_crtc->wm_high /
> > > > > amdgpu_crtc->line_time))
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (si_write_smc_soft_=
register(adev,
> > > > >=20
> > > > > SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 amdgpu_crtc->wm_low /
> > > > > amdgpu_crtc->line_time) !=3D PPSMC_Result_OK)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 amdgpu_crtc->wm_low /
> > > > > amdgpu_crtc->line_time))
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > >=20
> > > > >=20
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > > =C2=A0}
> > > > > > --
> > > > > > 2.50.1
> > > > > >=20
