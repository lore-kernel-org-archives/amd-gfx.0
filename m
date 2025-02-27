Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD20C197BF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 19:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2591310E258;
	Thu, 27 Feb 2025 19:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JHT+Aeps";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C264510E00B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 19:01:56 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2fe851fa123so339622a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 11:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740682916; x=1741287716; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z1NbcPU0ZPAoena2oLizDoBL0c42+iFEzbFOJ3vCtPQ=;
 b=JHT+Aeps4Kvj+eJQibrIJTD4Xr1FHSNy4PdYfQalY2JKHxw3YvDRtM8BOUMmcqGvbK
 NBoTpfTV71CAIVbo7y3aZDR7MsV7W8QstJOLNzThE1nEKZLC85roUdCV3vIl2rGj4X9A
 0tPHEVgAivsQL396XXaaYOVjLn6uqjSO7kuM2PnGwwnHm/8LWhCcO4fyfgipaZIA1bFe
 c8Iz0xtY9LRFf5HyAfauAGXi0ktOPTANeTPw9VMVKZH+4lHlHyrUQhgTY1RwVur20NcJ
 M5tUMdZO6IJPNNYEL2dzMJVfGnyNtSQrX8l2lthWm8sEy17/FV4KtowYqykMo2PWB1OX
 Idaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740682916; x=1741287716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z1NbcPU0ZPAoena2oLizDoBL0c42+iFEzbFOJ3vCtPQ=;
 b=hd9y9Vs3FrzUbdw1DvYyy6by528zsHAzCNhmOZe/iJ9ugMeISZJ1eOzOnIgvPppa9b
 w7hUM6vkbsjuaMJpKUxB5S1NLO5t3WSMFXvB3JMI5BbzE/91tQI1ukWtmr4JTIScVgna
 A8n/ge9ZzUfYWBDXNkFCLhziU6bD/pnGw/srKVg3FCbjvetXXAQ8bOq2IcbcDhnZL6AQ
 38Xr29igazGQ98FZ8PvWMaJ/0bgsatNLj/1pP96om/s5lZ5JL0z5P8QNmS1rifC04eeX
 S5kLXLpm4N2FjU/DDNvR4qWg6QZhKyxJWUDwVXSbQ3/ttvzXIB4Nlc2ULusiTeiy0FfJ
 bgTA==
X-Gm-Message-State: AOJu0Yw9rX2o+DmcyvAUew13zqzUEKFqbjq7qwiZF2yTIZW1oFJsgft4
 gZvKuiLym4wGxkFxjEOuSm/brmXuu4zGDaiW/grY95pxr3SjeMqeCdrHsrBWm40MjUlnVNa+M33
 dbM5z4D43QJNUnsQiP/b2UnPVLh/u+g==
X-Gm-Gg: ASbGncuvowyaAEGzp7rg82TMeHUp1sX+QR3qvMZVDkQ/9K/V/xbR+qjkgU98CZGH4Td
 9cUvX8x7nB6TJTkWvdMoic5yCoyZg2iYIwWLn47GPI8UXADbuTBKg9pCsOuHLuEarmvEcFwqJZP
 icSv2trBo=
X-Google-Smtp-Source: AGHT+IFbaQMploH2gF1awcXqv3HPPuez1ClDfY5exVlNe5QkbkCHpzCJhfbuugrgoU3xKPc4nMvW4uiJUGwIepJt0XA=
X-Received: by 2002:a17:90b:3b8d:b0:2fa:6055:17e7 with SMTP id
 98e67ed59e1d1-2febac10932mr251548a91.8.1740682916060; Thu, 27 Feb 2025
 11:01:56 -0800 (PST)
MIME-Version: 1.0
References: <20250227052241.171102-1-alexandre.f.demers@gmail.com>
 <20250227052241.171102-3-alexandre.f.demers@gmail.com>
 <CADnq5_NkXjnE9ymMxNyoQObB3=PHw5Ed+pYihu_ssCH8d8M6yw@mail.gmail.com>
 <CAPEhTTFDMQwoWjk18LE98MkdMd9skzykf3QTQeF=E6JrPf17eg@mail.gmail.com>
In-Reply-To: <CAPEhTTFDMQwoWjk18LE98MkdMd9skzykf3QTQeF=E6JrPf17eg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Feb 2025 14:01:44 -0500
X-Gm-Features: AQ5f1JqMtBdiGGS8dCyhXbA6hTZLtN8SEuKxl2woMKlF3SXTPWOkMEZAA-Mve-0
Message-ID: <CADnq5_PRCvX=PV-jzmQqesxXz2UDOUBJGc4DrzOSaNOcyDvTeg@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/amdgpu: add dce_v6_0_soft_reset() to DCE6
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Feb 27, 2025 at 1:52=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> On Thu, Feb 27, 2025 at 9:23=E2=80=AFAM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > On Thu, Feb 27, 2025 at 12:49=E2=80=AFAM Alexandre Demers
> > <alexandre.f.demers@gmail.com> wrote:
> > >
> > > DCE6 was missing soft reset, but it was easily identifiable under rad=
eon.
> > > This should be it, pretty much as it is done under DCE8 and DCE10.
> > >
> > > Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 62 ++++++++++++++++++++++++-=
--
> > >  1 file changed, 57 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/=
amd/amdgpu/dce_v6_0.c
> > > index bd763fde1c50..254cb73324c6 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > > @@ -371,27 +371,58 @@ static u32 dce_v6_0_hpd_get_gpio_reg(struct amd=
gpu_device *adev)
> > >         return mmDC_GPIO_HPD_A;
> > >  }
> > >
> > > +static bool dce_v6_0_is_display_hung(struct amdgpu_device *adev)
> > > +{
> > > +       u32 crtc_hung =3D 0;
> > > +       u32 crtc_status[6];
> > > +       u32 i, j, tmp;
> > > +
> > > +       for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> > > +               if (RREG32(mmCRTC_CONTROL + crtc_offsets[i]) & CRTC_C=
ONTROL__CRTC_MASTER_EN_MASK) {
> > > +                       crtc_status[i] =3D RREG32(mmCRTC_STATUS_HV_CO=
UNT + crtc_offsets[i]);
> > > +                       crtc_hung |=3D (1 << i);
> > > +               }
> > > +       }
> > > +
> > > +       for (j =3D 0; j < 10; j++) {
> > > +               for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> > > +                       if (crtc_hung & (1 << i)) {
> > > +                               tmp =3D RREG32(mmCRTC_STATUS_HV_COUNT=
 + crtc_offsets[i]);
> > > +                               if (tmp !=3D crtc_status[i])
> > > +                                       crtc_hung &=3D ~(1 << i);
> > > +                       }
> > > +               }
> > > +               if (crtc_hung =3D=3D 0)
> > > +                       return false;
> > > +               udelay(100);
> > > +       }
> > > +
> > > +       return true;
> > > +}
> > > +
> > >  static void dce_v6_0_set_vga_render_state(struct amdgpu_device *adev=
,
> > >                                           bool render)
> > >  {
> > >         if (!render)
> > >                 WREG32(mmVGA_RENDER_CONTROL,
> > >                         RREG32(mmVGA_RENDER_CONTROL) & VGA_VSTATUS_CN=
TL);
> > > -
> > >  }
> > >
> > >  static int dce_v6_0_get_num_crtc(struct amdgpu_device *adev)
> > >  {
> > > +       int num_crtc =3D 0;
> > > +
> > >         switch (adev->asic_type) {
> > >         case CHIP_TAHITI:
> > >         case CHIP_PITCAIRN:
> > >         case CHIP_VERDE:
> > > -               return 6;
> > > +               num_crtc =3D 6;
> > >         case CHIP_OLAND:
> > > -               return 2;
> > > +               num_crtc =3D 2;
> > >         default:
> > > -               return 0;
> > > +               num_crtc =3D 0;
> > >         }
> > > +       return num_crtc;
> >
> > Any particular reason for this change?  It just adds an extra variable.
> >
> > Alex
>
> Just for uniformisation with DCE8 and DCE10. We could also remove the
> variable and use returns everywhere.
>
> Any preferences?

ah, ok. I think the direct returns are cleaner.

Alex

> Alexandre
>
> >
> > >  }
> > >
> > >  void dce_v6_0_disable_dce(struct amdgpu_device *adev)
> > > @@ -2846,7 +2877,28 @@ static bool dce_v6_0_is_idle(void *handle)
> > >
> > >  static int dce_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
> > >  {
> > > -       DRM_INFO("xxxx: dce_v6_0_soft_reset --- no impl!!\n");
> > > +       u32 srbm_soft_reset =3D 0, tmp;
> > > +       struct amdgpu_device *adev =3D ip_block->adev;
> > > +
> > > +       if (dce_v6_0_is_display_hung(adev))
> > > +               srbm_soft_reset |=3D SRBM_SOFT_RESET__SOFT_RESET_DC_M=
ASK;
> > > +
> > > +       if (srbm_soft_reset) {
> > > +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> > > +               tmp |=3D srbm_soft_reset;
> > > +               dev_info(adev->dev, "SRBM_SOFT_RESET=3D0x%08X\n", tmp=
);
> > > +               WREG32(mmSRBM_SOFT_RESET, tmp);
> > > +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> > > +
> > > +               udelay(50);
> > > +
> > > +               tmp &=3D ~srbm_soft_reset;
> > > +               WREG32(mmSRBM_SOFT_RESET, tmp);
> > > +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> > > +
> > > +               /* Wait a little for things to settle down */
> > > +               udelay(50);
> > > +       }
> > >         return 0;
> > >  }
> > >
> > > --
> > > 2.48.1
> > >
