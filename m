Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8F7C197BF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 19:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D51F10E27D;
	Thu, 27 Feb 2025 19:10:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E7yYEhqi";
	dkim-atps=neutral
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com
 [209.85.222.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3962310E27D
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 19:09:53 +0000 (UTC)
Received: by mail-ua1-f51.google.com with SMTP id
 a1e0cc1a2514c-868f169bb56so570848241.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 11:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740683392; x=1741288192; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4uCi2DtRTgCU/LPqlNfPNpUYuWuWVYtkBQrzsqCF23I=;
 b=E7yYEhqiALL3E8/SaNM+GWldhpg1a9X2AhHMNO82BHluSaDv8SaAw8s+9Jlwp9CieI
 oXGdm5GXEUT6gU/G+ZVmNdl5BtihfeXclNlVHqdZvEGN9m0jl1y9NEEiO+N8ABTLDFUG
 lDrzYsGxB2UTYcuE2v7+GHTVAM8SlSHg5rWMInyJLQP+qfnhW+3mf7y1rljg0/gXSeY2
 s9TfPM8i24iwv0gF632w6FXQNuQVnslr6ORD9FwC4J3UQwMd26Gjaj+RIMHY3dizX+9t
 MYDs51iBXBEN45V/xpwqDEhWIXtAtqMFZS8t8bVTShz/xHYLdM30C6R2O3y+UtDnauKR
 pAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740683392; x=1741288192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4uCi2DtRTgCU/LPqlNfPNpUYuWuWVYtkBQrzsqCF23I=;
 b=EeeXUIxxj6l8fIicbjYTQ4IHLqCyCtV9lj60Lk/tiiszjEsgRbIPZ6E18baUbqeBsK
 QRcaPAzc58wHrSJo5nZynHbnc8vjJh93i5vyCR1mGuDbTuZ68I8vL0iI7Hjr4UfoAEYa
 bfr/2zPLvTyNAtyqny/j9RE6/GJjPsLGKLZ6fFCLgaOOdbi+vop5q6HP2f/uEsqM1gN0
 uGgE6GnY/BtAdt52JMlpRKRMlyOIhFzB3fw38X3NFtzR4NxpZ2sNSgXd8TabbYd3uLqW
 uw8OpyvVeDY8G/Q+qyp25yW+RZWgcMGtG55A6JDl0FpZ/p/9DhGTlAoW6xD8LGUHPom8
 ofdQ==
X-Gm-Message-State: AOJu0YzQGrzNob/LRLLoLVQrZSQmO8SY2kyvvdhum5Ji4h6uxFkgETNw
 1cjOXrS3jQB9X1S5bYlFnXj7geSauYBQI4EK2wKSUS5VwSeaLVVQjIOwaQ79XPagPcjUaJFpOL8
 Drr4eCELKkAFH+uG4lVpUGuZsN8txDw==
X-Gm-Gg: ASbGnct48uDE1GMlvUV/JgcTdaGMUv0d0MdG3X72WNRmzww6wpzBYaLwmnwID7V+IJm
 FQNlTBIFhTG3MQr/LS+4Tj8NhM78KBtBNkhDAlDCA0aLoAjxBXMjjJ+NYatGz5fTYex56ZS4t4Z
 VYuznlLg==
X-Google-Smtp-Source: AGHT+IG0RJDvvDXzSIml1P5M/xXMhTF0m71vL30N2jh9AguIAnQAEv42PxCmqnFRexy1/sIa90wG0bP11ZiFMXaAgrY=
X-Received: by 2002:a05:6102:2d07:b0:4bb:ba51:7d48 with SMTP id
 ada2fe7eead31-4c044858737mr692556137.5.1740683392150; Thu, 27 Feb 2025
 11:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20250227052241.171102-1-alexandre.f.demers@gmail.com>
 <20250227052241.171102-3-alexandre.f.demers@gmail.com>
 <CADnq5_NkXjnE9ymMxNyoQObB3=PHw5Ed+pYihu_ssCH8d8M6yw@mail.gmail.com>
 <CAPEhTTFDMQwoWjk18LE98MkdMd9skzykf3QTQeF=E6JrPf17eg@mail.gmail.com>
 <CADnq5_PRCvX=PV-jzmQqesxXz2UDOUBJGc4DrzOSaNOcyDvTeg@mail.gmail.com>
In-Reply-To: <CADnq5_PRCvX=PV-jzmQqesxXz2UDOUBJGc4DrzOSaNOcyDvTeg@mail.gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Thu, 27 Feb 2025 14:09:40 -0500
X-Gm-Features: AQ5f1Jpa3j4E1Rbj37nWrRz2Hu51wiiqkvkOBUuMGvjQbVTu5AwHOcsj17eDNHw
Message-ID: <CAPEhTTF-_CTfErbRGvamWyMS04w=GGDEFQTLGOBM0Yn0Jt9DFg@mail.gmail.com>
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

On Thu, Feb 27, 2025 at 2:01=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Thu, Feb 27, 2025 at 1:52=E2=80=AFPM Alexandre Demers
> <alexandre.f.demers@gmail.com> wrote:
> >
> > On Thu, Feb 27, 2025 at 9:23=E2=80=AFAM Alex Deucher <alexdeucher@gmail=
.com> wrote:
> > >
> > > On Thu, Feb 27, 2025 at 12:49=E2=80=AFAM Alexandre Demers
> > > <alexandre.f.demers@gmail.com> wrote:
> > > >
> > > > DCE6 was missing soft reset, but it was easily identifiable under r=
adeon.
> > > > This should be it, pretty much as it is done under DCE8 and DCE10.
> > > >
> > > > Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 62 +++++++++++++++++++++++=
+---
> > > >  1 file changed, 57 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/dr=
m/amd/amdgpu/dce_v6_0.c
> > > > index bd763fde1c50..254cb73324c6 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > > > @@ -371,27 +371,58 @@ static u32 dce_v6_0_hpd_get_gpio_reg(struct a=
mdgpu_device *adev)
> > > >         return mmDC_GPIO_HPD_A;
> > > >  }
> > > >
> > > > +static bool dce_v6_0_is_display_hung(struct amdgpu_device *adev)
> > > > +{
> > > > +       u32 crtc_hung =3D 0;
> > > > +       u32 crtc_status[6];
> > > > +       u32 i, j, tmp;
> > > > +
> > > > +       for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> > > > +               if (RREG32(mmCRTC_CONTROL + crtc_offsets[i]) & CRTC=
_CONTROL__CRTC_MASTER_EN_MASK) {
> > > > +                       crtc_status[i] =3D RREG32(mmCRTC_STATUS_HV_=
COUNT + crtc_offsets[i]);
> > > > +                       crtc_hung |=3D (1 << i);
> > > > +               }
> > > > +       }
> > > > +
> > > > +       for (j =3D 0; j < 10; j++) {
> > > > +               for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> > > > +                       if (crtc_hung & (1 << i)) {
> > > > +                               tmp =3D RREG32(mmCRTC_STATUS_HV_COU=
NT + crtc_offsets[i]);
> > > > +                               if (tmp !=3D crtc_status[i])
> > > > +                                       crtc_hung &=3D ~(1 << i);
> > > > +                       }
> > > > +               }
> > > > +               if (crtc_hung =3D=3D 0)
> > > > +                       return false;
> > > > +               udelay(100);
> > > > +       }
> > > > +
> > > > +       return true;
> > > > +}
> > > > +
> > > >  static void dce_v6_0_set_vga_render_state(struct amdgpu_device *ad=
ev,
> > > >                                           bool render)
> > > >  {
> > > >         if (!render)
> > > >                 WREG32(mmVGA_RENDER_CONTROL,
> > > >                         RREG32(mmVGA_RENDER_CONTROL) & VGA_VSTATUS_=
CNTL);
> > > > -
> > > >  }
> > > >
> > > >  static int dce_v6_0_get_num_crtc(struct amdgpu_device *adev)
> > > >  {
> > > > +       int num_crtc =3D 0;
> > > > +
> > > >         switch (adev->asic_type) {
> > > >         case CHIP_TAHITI:
> > > >         case CHIP_PITCAIRN:
> > > >         case CHIP_VERDE:
> > > > -               return 6;
> > > > +               num_crtc =3D 6;
> > > >         case CHIP_OLAND:
> > > > -               return 2;
> > > > +               num_crtc =3D 2;
> > > >         default:
> > > > -               return 0;
> > > > +               num_crtc =3D 0;
> > > >         }
> > > > +       return num_crtc;
> > >
> > > Any particular reason for this change?  It just adds an extra variabl=
e.
> > >
> > > Alex
> >
> > Just for uniformisation with DCE8 and DCE10. We could also remove the
> > variable and use returns everywhere.
> >
> > Any preferences?
>
> ah, ok. I think the direct returns are cleaner.
>
> Alex

Ok. Should I submit a new version or should this patch go through and
be changed everywhere in a different patch?

Alexandre

>
> > Alexandre
> >
> > >
> > > >  }
> > > >
> > > >  void dce_v6_0_disable_dce(struct amdgpu_device *adev)
> > > > @@ -2846,7 +2877,28 @@ static bool dce_v6_0_is_idle(void *handle)
> > > >
> > > >  static int dce_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
> > > >  {
> > > > -       DRM_INFO("xxxx: dce_v6_0_soft_reset --- no impl!!\n");
> > > > +       u32 srbm_soft_reset =3D 0, tmp;
> > > > +       struct amdgpu_device *adev =3D ip_block->adev;
> > > > +
> > > > +       if (dce_v6_0_is_display_hung(adev))
> > > > +               srbm_soft_reset |=3D SRBM_SOFT_RESET__SOFT_RESET_DC=
_MASK;
> > > > +
> > > > +       if (srbm_soft_reset) {
> > > > +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> > > > +               tmp |=3D srbm_soft_reset;
> > > > +               dev_info(adev->dev, "SRBM_SOFT_RESET=3D0x%08X\n", t=
mp);
> > > > +               WREG32(mmSRBM_SOFT_RESET, tmp);
> > > > +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> > > > +
> > > > +               udelay(50);
> > > > +
> > > > +               tmp &=3D ~srbm_soft_reset;
> > > > +               WREG32(mmSRBM_SOFT_RESET, tmp);
> > > > +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> > > > +
> > > > +               /* Wait a little for things to settle down */
> > > > +               udelay(50);
> > > > +       }
> > > >         return 0;
> > > >  }
> > > >
> > > > --
> > > > 2.48.1
> > > >
