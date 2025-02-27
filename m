Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D9EC197BF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 18:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D29A510EB57;
	Thu, 27 Feb 2025 18:52:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FV1eq3s2";
	dkim-atps=neutral
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com
 [209.85.222.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F6CA10EB71
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 18:52:12 +0000 (UTC)
Received: by mail-ua1-f41.google.com with SMTP id
 a1e0cc1a2514c-86b2aaf84daso492895241.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 10:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740682331; x=1741287131; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QyI61OCRkdOANPTOpIF9RJPDyAwfK3Xl88NZsBOJpdI=;
 b=FV1eq3s2vOq5E/jGIxDNtqKF/ZW24u2a+GfVD9Y8cEoKRZBkzDsOUgpUcXIV2zRH4Z
 9CMnbaiMjP54Cq6kKVRCpc2C/sOd8RKXWeMGIpDE6XvgstzRvF0MTs/53rU1AGyJo39z
 h5cMYfAhW6GgRADs5hY0WMfAW4lxGyOlpkNERM8iMK060sxO6g45fRPhUhdkB74cUQAd
 IUuSCs0stTu5+ihJzXFsdiMuAPbVUHz43cSvHgl653XjazdiTkPzGbnvYR4uCH3JRySq
 kDX00wFX++JdzJfe83FZorCJv5LnBNMpSk9RjGyIIJN0CEbyRUdIXHouXJD4Kg91uBk9
 Diag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740682331; x=1741287131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QyI61OCRkdOANPTOpIF9RJPDyAwfK3Xl88NZsBOJpdI=;
 b=thvbtW7qDxpUVwaQ81ICYFgEiFvmaqO+4H7ZNuW8Olxm31HrWFSK1kGXEEcZHNBbRw
 2ew1tiYKh1+BxvhodDZ5FZ6HfVUqHYxNH/SPaBQVggaUmRc6IlOVuVKUazbh0BxBe6oK
 tDgUn7ZNDpdaFiMm7FrWXsND+/ZWVdzGVgqbsu0hIUa3o7Kx3au4Og0DGhCqkNiJvauj
 MUxB6rz9ht3/yFMuspi7K/Ypk+noFYgx7fqYn42otNzmU/iYlAV+EvYB34/o0olBhQcy
 4WfZUu3zfe5tGC40C2h6GFORwueSkHYRKBqfxTItGs3XN2RyXuhFEGUm4N34AteTLoys
 nmBg==
X-Gm-Message-State: AOJu0YxwuWzo9WnrCGWRswGR1V+xdvIwZSHSG2xy1P5xQVZ0SAJx8FNQ
 55VCUZszEzrC2G0T/pJDNWC4JQlW570p3q5Grst6i+wa6eXMV336ogYnPkPec/60tdWbZNeJM0f
 qIa1RI1GA5FZh9UqdG9VbZ/icEgs=
X-Gm-Gg: ASbGncsJsnW2dOUgL9X6GXV2o8x9z4avkAFGWxWNeB9/iAXyo9HtzUXSX1oDyHeKO09
 GFTqCP2d4D45NElKWdJYycDh/ZLzPjAsOkzmvZPcQdGsn0mW+T+b7v+wRQcyeDWxXbvhHsU8th/
 WANlse5Q==
X-Google-Smtp-Source: AGHT+IFzdsAQPKdRqj8VtCe4e3K5IBbTJ6oKB+pHNPJ5QZiaxI4QR6CghMQHZCA/tNn4qUKahrG8yNH0aRnapyXi8Yk=
X-Received: by 2002:a05:6102:32c8:b0:4bb:dc3c:1b43 with SMTP id
 ada2fe7eead31-4c044aff68dmr597645137.8.1740682330999; Thu, 27 Feb 2025
 10:52:10 -0800 (PST)
MIME-Version: 1.0
References: <20250227052241.171102-1-alexandre.f.demers@gmail.com>
 <20250227052241.171102-3-alexandre.f.demers@gmail.com>
 <CADnq5_NkXjnE9ymMxNyoQObB3=PHw5Ed+pYihu_ssCH8d8M6yw@mail.gmail.com>
In-Reply-To: <CADnq5_NkXjnE9ymMxNyoQObB3=PHw5Ed+pYihu_ssCH8d8M6yw@mail.gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Thu, 27 Feb 2025 13:51:59 -0500
X-Gm-Features: AQ5f1JraWSch1kBl2Kp5B2T6WrlEbuYT1w4w-lp_CAKiUnQIkGk-jHgZaK4QmCM
Message-ID: <CAPEhTTFDMQwoWjk18LE98MkdMd9skzykf3QTQeF=E6JrPf17eg@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/amdgpu: add dce_v6_0_soft_reset() to DCE6
To: Alex Deucher <alexdeucher@gmail.com>
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

On Thu, Feb 27, 2025 at 9:23=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Thu, Feb 27, 2025 at 12:49=E2=80=AFAM Alexandre Demers
> <alexandre.f.demers@gmail.com> wrote:
> >
> > DCE6 was missing soft reset, but it was easily identifiable under radeo=
n.
> > This should be it, pretty much as it is done under DCE8 and DCE10.
> >
> > Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 62 ++++++++++++++++++++++++---
> >  1 file changed, 57 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/dce_v6_0.c
> > index bd763fde1c50..254cb73324c6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > @@ -371,27 +371,58 @@ static u32 dce_v6_0_hpd_get_gpio_reg(struct amdgp=
u_device *adev)
> >         return mmDC_GPIO_HPD_A;
> >  }
> >
> > +static bool dce_v6_0_is_display_hung(struct amdgpu_device *adev)
> > +{
> > +       u32 crtc_hung =3D 0;
> > +       u32 crtc_status[6];
> > +       u32 i, j, tmp;
> > +
> > +       for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> > +               if (RREG32(mmCRTC_CONTROL + crtc_offsets[i]) & CRTC_CON=
TROL__CRTC_MASTER_EN_MASK) {
> > +                       crtc_status[i] =3D RREG32(mmCRTC_STATUS_HV_COUN=
T + crtc_offsets[i]);
> > +                       crtc_hung |=3D (1 << i);
> > +               }
> > +       }
> > +
> > +       for (j =3D 0; j < 10; j++) {
> > +               for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> > +                       if (crtc_hung & (1 << i)) {
> > +                               tmp =3D RREG32(mmCRTC_STATUS_HV_COUNT +=
 crtc_offsets[i]);
> > +                               if (tmp !=3D crtc_status[i])
> > +                                       crtc_hung &=3D ~(1 << i);
> > +                       }
> > +               }
> > +               if (crtc_hung =3D=3D 0)
> > +                       return false;
> > +               udelay(100);
> > +       }
> > +
> > +       return true;
> > +}
> > +
> >  static void dce_v6_0_set_vga_render_state(struct amdgpu_device *adev,
> >                                           bool render)
> >  {
> >         if (!render)
> >                 WREG32(mmVGA_RENDER_CONTROL,
> >                         RREG32(mmVGA_RENDER_CONTROL) & VGA_VSTATUS_CNTL=
);
> > -
> >  }
> >
> >  static int dce_v6_0_get_num_crtc(struct amdgpu_device *adev)
> >  {
> > +       int num_crtc =3D 0;
> > +
> >         switch (adev->asic_type) {
> >         case CHIP_TAHITI:
> >         case CHIP_PITCAIRN:
> >         case CHIP_VERDE:
> > -               return 6;
> > +               num_crtc =3D 6;
> >         case CHIP_OLAND:
> > -               return 2;
> > +               num_crtc =3D 2;
> >         default:
> > -               return 0;
> > +               num_crtc =3D 0;
> >         }
> > +       return num_crtc;
>
> Any particular reason for this change?  It just adds an extra variable.
>
> Alex

Just for uniformisation with DCE8 and DCE10. We could also remove the
variable and use returns everywhere.

Any preferences?
Alexandre

>
> >  }
> >
> >  void dce_v6_0_disable_dce(struct amdgpu_device *adev)
> > @@ -2846,7 +2877,28 @@ static bool dce_v6_0_is_idle(void *handle)
> >
> >  static int dce_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
> >  {
> > -       DRM_INFO("xxxx: dce_v6_0_soft_reset --- no impl!!\n");
> > +       u32 srbm_soft_reset =3D 0, tmp;
> > +       struct amdgpu_device *adev =3D ip_block->adev;
> > +
> > +       if (dce_v6_0_is_display_hung(adev))
> > +               srbm_soft_reset |=3D SRBM_SOFT_RESET__SOFT_RESET_DC_MAS=
K;
> > +
> > +       if (srbm_soft_reset) {
> > +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> > +               tmp |=3D srbm_soft_reset;
> > +               dev_info(adev->dev, "SRBM_SOFT_RESET=3D0x%08X\n", tmp);
> > +               WREG32(mmSRBM_SOFT_RESET, tmp);
> > +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> > +
> > +               udelay(50);
> > +
> > +               tmp &=3D ~srbm_soft_reset;
> > +               WREG32(mmSRBM_SOFT_RESET, tmp);
> > +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> > +
> > +               /* Wait a little for things to settle down */
> > +               udelay(50);
> > +       }
> >         return 0;
> >  }
> >
> > --
> > 2.48.1
> >
