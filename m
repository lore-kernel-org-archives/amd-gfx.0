Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263A8FED3C9
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 14:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8F8610F5D5;
	Fri, 24 Apr 2026 14:28:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cWLN6kwR";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60C9F10F5D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 14:28:10 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12dc9b6beceso25742c88.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 07:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777040890; cv=none;
 d=google.com; s=arc-20240605;
 b=B6EW+/E1JwGzYPhgRxnnPNxcFWF/goS9n6JCE9zrj8A+SGA9BjxF6Bpvwe1BN6Z1ED
 +xzkkI9CSS7XIQaZa0easH4PM+zZoTo8RXPSON+Jn2Obn/8cJp+DK2N2ynNs+t5Mul31
 9MPie+lHWhp+F5GRFkOHPDQCelf2wUHImaSCeUXfKvsfhTAbZkH4eAUCfMFLd38o79Si
 Jslc+klH84MovqfXxOAFw1qwhrWvdEYwllauHDTUoTLTfohsTtG3vzMAR5EjWooOS2kD
 IqUVQaxrrmJjl/JpZCgjBYsDw+3TxWTJug5hIBEG6vq6365J81E1UPpRGprk0GOwVzI+
 5+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VUnGOxMsE5B5u4ajUmOXsj9fKAVq9wRll5g8iH5CF4I=;
 fh=0WsmBrIQS2Ll7QRuXg48SYwbRTRIZL3zTZig8gxeHjA=;
 b=MLWka4eGyUFwtqLQETkK6C22C7WHSVrxvj+rLNKlFpsNcJ64XWi7Ug9siZ/Otkwp9A
 ayV37XRrPUUW0txkiQZVnSkfSeoSJLOQvMohg6FyNBuTrMkoD9wxrPt7h1Brpl7I34GE
 KUQGeU1a+cyhhGKoU7s8zSME/AeFD21TIHgawEg7vg/ewWZ+ZWDPKUccfcR3S5QL+uOb
 QUwcnI7NCkQJVCoAk5ke4TZC7Fbm+R6MReM/+9zD+GMPLkDICaxN9hqUz5Em6spFCPZ9
 /akBoGCjABwfb/XossEpKl6ecfnmA/6QLc9goYwm9cF/ZMTkUQPND/fZyCyssFvgERWJ
 L4Wg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777040890; x=1777645690; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUnGOxMsE5B5u4ajUmOXsj9fKAVq9wRll5g8iH5CF4I=;
 b=cWLN6kwRmzPqxtAZ4C9A/mqkc1VveBlwbnvUzl4cKZhHY9QayCHUQfb0PtuwgQe7pr
 RSyZePgxiM/T5sjSAOZwz1TFiuIzZtkd25da5k1mW9UF4S79sBjikvRR+p/mSUwqkezM
 r48qUznKPLS64efzNFdusnbaNaRu/kQ2RfSFoPux5BgWpgFMv3pYza2d6cgImnGmPctc
 N1iIpjF7Uf19BvJSFYzHiNBwnZQoap/MciGS6G8qxAoQVR2/hpvA4L9OOVxtTcKnBUB1
 AkqhGhYE26zadoX+s//YrrKb0RxhP/J/nXgdn3AvmbJ2TKDZ0q27gh6t78HRtLplzJ4F
 Yu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777040890; x=1777645690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VUnGOxMsE5B5u4ajUmOXsj9fKAVq9wRll5g8iH5CF4I=;
 b=HwY5YnrlJ+YrZWxd5Vn7ov8vqUxvkB7Wt6HJUF7YVLQPNNck2NmCO3dgME5GhRmpDN
 +U1+P3oWvUNMHK5Zac6vF9xPMQwa85V6/tqFvWmG2C+0JS5Sw849yqcv3C7lCEwKnaHM
 ymRY3amIwVZFXlwEUSPZuCnA9HePR+WgUkeF8de5epqfBMMcmRZUoWU7J1GqXH3DDz4Z
 RBe5cP5nPtbkMPopxE1ROdzOMVczADskaQ35kobTU8jg6L2d/tOz8t0lQUHXsQaUyP/L
 zdz9bbNKT3Iwrtpoe0DRXYhIMclOlOfSLrRcEbp/Fjy7+0GpVfqV7HIUncnGuEtayxpw
 zD9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9oosM9kGcw8KEZlj/MJG/K4WoaBtuFSPsmyYnOwfA5uSL2BzJoRAhH/a0V9coaXfT0TFE6/R+r@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8UzP7M17lZvyazrLSn9lq3vDM6ZjSJtuHMnC0rObOje7oglQK
 wHSYG9zhOfZ4OkFeKdTlpS/WLYr45X8ZlfLlSc6iLlbBt1UqfCZANdWC3LDRMs6I4Q/fyPdw8jf
 y0r/ccA5hVJRk3kNtUIkkdYvhOX8v4w4=
X-Gm-Gg: AeBDiev73CNxNbiAG72lC6bYouP2iV+XBzhiXN1+5gcays82h1KaoKQQ4Zaw7CSR715
 g9wfziG3ohQZ3e6BCcR+Eb4BwPd9Q8In9/WONo8Zb2J0DpYgHU0CuebxKgn3h3AWUJF6zQI6PC2
 PHLFsBL4wEAugdQ/vlroTrxFn8mOUEinr1XuyYYezaRMcLUypdnO4VHfX+KA5WnQPoWhrVO3jrP
 EbKvlTaX6HjD6C9ZeiJ3wyCn5wXQxf26d1g9ij8kVarm2QCT+4B9JhdsDqO6BEQ6YBF4/cvnluN
 ur3syRRjDXuDQSjM4coLA2cwcSWOPhra5qOcfnVWTxi2fNvta+tZgjIAiizy6mo52ChMsqBjRVz
 40GOp
X-Received: by 2002:a05:7022:f8c:b0:12d:c6d9:5faa with SMTP id
 a92af1059eb24-12dc6d96099mr513846c88.4.1777040889420; Fri, 24 Apr 2026
 07:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260424004910.21003-1-gabrielsousa230@gmail.com>
 <20260424004910.21003-2-gabrielsousa230@gmail.com>
 <975a945c-1bb8-4dbe-9767-d39f3c98e778@amd.com>
In-Reply-To: <975a945c-1bb8-4dbe-9767-d39f3c98e778@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Apr 2026 10:27:57 -0400
X-Gm-Features: AQROBzCkU-HE18UMY_snK4d5BoDk-5ksSQuIfTmlSXvsabkGuvzO2DiI1ybJMeQ
Message-ID: <CADnq5_OTtKYeuaVBF+e+n=m9tTQ_K862-rS9Ax5XDWLEZqdw5A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: move read_indexed_register to
 amdgpu_reg_access
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Gabriel Almeida <gabrielsousa230@gmail.com>, alexander.deucher@amd.com,
 airlied@gmail.com, 
 simona@ffwll.ch, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

Applied the series.  Thanks!

Alex

On Fri, Apr 24, 2026 at 3:49=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/24/26 02:49, Gabriel Almeida wrote:
> > The read_indexed_register helper is duplicated across multiple files
> > with identical logic.
> >
> > Move it to amdgpu_reg_access.c as
> > amdgpu_read_indexed_register and update all users accordingly.
> >
> > No functional changes intended.
>
> Yeah, as far as I can see we have already abstracted the HW generation de=
pending parts in amdgpu_gfx_select_se_sh(), so the change is most likely a =
valid cleanup.
>
> > Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
> > ---
> > v3:
> > - split into two patches as requested
> >
> > v2:
> > - move read_indexed_register to amdgpu_reg_access.c
> > - drop amdgpu_common
> >
> >  .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 18 ++++++++++++++++
> >  .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |  3 +++
> >  drivers/gpu/drm/amd/amdgpu/nv.c               | 19 +----------------
> >  drivers/gpu/drm/amd/amdgpu/soc15.c            | 19 +----------------
> >  drivers/gpu/drm/amd/amdgpu/soc21.c            | 19 +----------------
> >  drivers/gpu/drm/amd/amdgpu/soc24.c            | 21 +------------------
> >  drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         | 20 +-----------------
> >  7 files changed, 26 insertions(+), 93 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_reg_access.c
> > index 540040c76..daefbeeee 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> > @@ -956,3 +956,21 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_=
device *adev, uint32_t inst,
> >       }
> >       return ret;
> >  }
> > +
> > +
>
> A bit kerneldoc here would be nice to have, but not mandatory.
>
> With that done Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.co=
m>
>
> Regards,
> Christian.
>
> > +uint32_t amdgpu_read_indexed_register(struct amdgpu_device *adev,
> > +                            u32 se_num, u32 sh_num, u32 reg_offset)
> > +{
> > +     uint32_t val;
> > +
> > +     mutex_lock(&adev->grbm_idx_mutex);
> > +     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > +             amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> > +
> > +     val =3D RREG32(reg_offset);
> > +
> > +     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > +             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> > +     mutex_unlock(&adev->grbm_idx_mutex);
> > +     return val;
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_reg_access.h
> > index 4d88e5cd1..a1011af6b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
> > @@ -160,4 +160,7 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_d=
evice *adev, uint32_t inst,
> >                                   uint32_t reg_addr, char reg_name[],
> >                                   uint32_t expected_value, uint32_t mas=
k);
> >
> > +uint32_t amdgpu_read_indexed_register(struct amdgpu_device *adev,
> > +                                     u32 se_num, u32 sh_num, u32 reg_o=
ffset);
> > +
> >  #endif /* __AMDGPU_REG_ACCESS_H__ */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdg=
pu/nv.c
> > index 030d80664..72edf5326 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> > @@ -354,29 +354,12 @@ static struct soc15_allowed_register_entry nv_all=
owed_read_registers[] =3D {
> >       { SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
> >  };
> >
> > -static uint32_t nv_read_indexed_register(struct amdgpu_device *adev, u=
32 se_num,
> > -                                      u32 sh_num, u32 reg_offset)
> > -{
> > -     uint32_t val;
> > -
> > -     mutex_lock(&adev->grbm_idx_mutex);
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> > -
> > -     val =3D RREG32(reg_offset);
> > -
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> > -     mutex_unlock(&adev->grbm_idx_mutex);
> > -     return val;
> > -}
> > -
> >  static uint32_t nv_get_register_value(struct amdgpu_device *adev,
> >                                     bool indexed, u32 se_num,
> >                                     u32 sh_num, u32 reg_offset)
> >  {
> >       if (indexed) {
> > -             return nv_read_indexed_register(adev, se_num, sh_num, reg=
_offset);
> > +             return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
> >       } else {
> >               if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_C=
ONFIG))
> >                       return adev->gfx.config.gb_addr_config;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/a=
mdgpu/soc15.c
> > index 27bcbbae5..87b398dd0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > @@ -401,29 +401,12 @@ static struct soc15_allowed_register_entry soc15_=
allowed_read_registers[] =3D {
> >       { SOC15_REG_ENTRY(GC, 0, mmDB_DEBUG2)},
> >  };
> >
> > -static uint32_t soc15_read_indexed_register(struct amdgpu_device *adev=
, u32 se_num,
> > -                                      u32 sh_num, u32 reg_offset)
> > -{
> > -     uint32_t val;
> > -
> > -     mutex_lock(&adev->grbm_idx_mutex);
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> > -
> > -     val =3D RREG32(reg_offset);
> > -
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> > -     mutex_unlock(&adev->grbm_idx_mutex);
> > -     return val;
> > -}
> > -
> >  static uint32_t soc15_get_register_value(struct amdgpu_device *adev,
> >                                        bool indexed, u32 se_num,
> >                                        u32 sh_num, u32 reg_offset)
> >  {
> >       if (indexed) {
> > -             return soc15_read_indexed_register(adev, se_num, sh_num, =
reg_offset);
> > +             return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
> >       } else {
> >               if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_C=
ONFIG))
> >                       return adev->gfx.config.gb_addr_config;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/a=
mdgpu/soc21.c
> > index 7e4353d0c..93c002e51 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> > @@ -306,29 +306,12 @@ static struct soc15_allowed_register_entry soc21_=
allowed_read_registers[] =3D {
> >       { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> >  };
> >
> > -static uint32_t soc21_read_indexed_register(struct amdgpu_device *adev=
, u32 se_num,
> > -                                      u32 sh_num, u32 reg_offset)
> > -{
> > -     uint32_t val;
> > -
> > -     mutex_lock(&adev->grbm_idx_mutex);
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> > -
> > -     val =3D RREG32(reg_offset);
> > -
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> > -     mutex_unlock(&adev->grbm_idx_mutex);
> > -     return val;
> > -}
> > -
> >  static uint32_t soc21_get_register_value(struct amdgpu_device *adev,
> >                                     bool indexed, u32 se_num,
> >                                     u32 sh_num, u32 reg_offset)
> >  {
> >       if (indexed) {
> > -             return soc21_read_indexed_register(adev, se_num, sh_num, =
reg_offset);
> > +             return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
> >       } else {
> >               if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_ADDR_=
CONFIG) && adev->gfx.config.gb_addr_config)
> >                       return adev->gfx.config.gb_addr_config;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/a=
mdgpu/soc24.c
> > index d1adf19a5..265db9331 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> > @@ -132,31 +132,12 @@ static struct soc15_allowed_register_entry soc24_=
allowed_read_registers[] =3D {
> >       { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> >  };
> >
> > -static uint32_t soc24_read_indexed_register(struct amdgpu_device *adev=
,
> > -                                         u32 se_num,
> > -                                         u32 sh_num,
> > -                                         u32 reg_offset)
> > -{
> > -     uint32_t val;
> > -
> > -     mutex_lock(&adev->grbm_idx_mutex);
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> > -
> > -     val =3D RREG32(reg_offset);
> > -
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> > -     mutex_unlock(&adev->grbm_idx_mutex);
> > -     return val;
> > -}
> > -
> >  static uint32_t soc24_get_register_value(struct amdgpu_device *adev,
> >                                        bool indexed, u32 se_num,
> >                                        u32 sh_num, u32 reg_offset)
> >  {
> >       if (indexed) {
> > -             return soc24_read_indexed_register(adev, se_num, sh_num, =
reg_offset);
> > +             return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
> >       } else {
> >               if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_ADDR_=
CONFIG) &&
> >                   adev->gfx.config.gb_addr_config)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/am=
d/amdgpu/soc_v1_0.c
> > index 709b1669b..4a5fe8e9d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> > @@ -184,31 +184,13 @@ static struct soc15_allowed_register_entry soc_v1=
_0_allowed_read_registers[] =3D {
> >       { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG_1) },
> >  };
> >
> > -static uint32_t soc_v1_0_read_indexed_register(struct amdgpu_device *a=
dev,
> > -                                            u32 se_num,
> > -                                            u32 sh_num,
> > -                                            u32 reg_offset)
> > -{
> > -     uint32_t val;
> > -
> > -     mutex_lock(&adev->grbm_idx_mutex);
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> > -
> > -     val =3D RREG32(reg_offset);
> > -
> > -     if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> > -     mutex_unlock(&adev->grbm_idx_mutex);
> > -     return val;
> > -}
> >
> >  static uint32_t soc_v1_0_get_register_value(struct amdgpu_device *adev=
,
> >                                           bool indexed, u32 se_num,
> >                                           u32 sh_num, u32 reg_offset)
> >  {
> >       if (indexed) {
> > -             return soc_v1_0_read_indexed_register(adev, se_num, sh_nu=
m, reg_offset);
> > +             return amdgpu_read_indexed_register(adev, se_num, sh_num,=
 reg_offset);
> >       } else {
> >               if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_ADDR_=
CONFIG_1) &&
> >                   adev->gfx.config.gb_addr_config)
>
