Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDA5C19F32
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 19:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1FC610EB69;
	Thu, 27 Feb 2025 19:11:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eHV7TScU";
	dkim-atps=neutral
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com
 [209.85.221.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 020AA10EB67
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 19:11:39 +0000 (UTC)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-520ac2b9b7bso592957e0c.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 11:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740683499; x=1741288299; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Ud8q/24QIqze3UbOxHqHuaeIXRW53ofNmAXAQmXdHs=;
 b=eHV7TScUd0im1aEIVhclkXVpToecsUEUBHyy/SVySeP6PI1rljl84mK1sFpm/x7s1N
 nQUeABJn6lpv420ZIRbeMsnesdc9m3+4E1TR/YTCZkIlO5wH7SwZUDlZ7uzy31g35vxn
 WB6wYV7jqayScRGVgJo1NAebvLL1kQV/8wch7YNRnl+61/GwoY6jvFsGu37WRUsN3/NY
 hmZPFaR6bkgJZazkuAWG+dEBYfs1LGU20G36hX8udLRM2F7ikTOL1wPzwgkY0L/j7CVM
 C9kvndHI/ka1WKN8mNNzzQibSYy5w3PS5w7Y6jYR3vniAnznD+pbUxsRlmixdoLHjSWV
 Pd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740683499; x=1741288299;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Ud8q/24QIqze3UbOxHqHuaeIXRW53ofNmAXAQmXdHs=;
 b=OZFCt+B9ayLTLC9FeCqDEo/xHXGIy79ftpCMF2tKhoN7oFld3g4+3OeuiTD+2MQAzu
 mT7rXIXTN/FDSySdmnniAJW18BlZffY3+f2d5EYs3vylOcFYGTHGwl9dWKczGpf4MYah
 qFxgKDg7Nd7czGS4t10TUyFs7fjIfh+wsIvgl+/M0NQ2o+UEIYuhYLtspE9sUcSXQh9W
 BgTeNYeDSVfNIfL2dxYk0ApaipQThYKqq7eGDEpcwNeHWTf/tprycUbzQ3Jy0aQJHBCo
 vJoZAEwedrQuwN3WzIEk02YyuqQkn4cON2zIdroyAx4Pqe+3DIltvIqBKtONVcZi+GG6
 nBlw==
X-Gm-Message-State: AOJu0YwaN+RmgnvC0/HE1Gm0VGSMXJtwq7rM2wu6CacTvXRR/+WiWpQX
 3Bl2VsAfX0XQ/SepbG0qiQAUhJoGmmE0QW0aKH9TsZIf80Wjig1j5jMTm5XQBFK+EShlMF5xKP1
 iuI6+q6Bdi2IPaRtyVcnkcLVzQFc=
X-Gm-Gg: ASbGncugW6qg46gyHHgz9yMwphoO0/lACMrF1pRcdUmbYKGS0Md2gAiYjpImJeCj5+/
 eZrT+M9qAyaAeY/xFsB7DAN7ERUBjxKxjYEX3axE0Pjlb2RCu4h1c2Fstl0lKP0vMUjEkExHeAO
 VMtryrQw==
X-Google-Smtp-Source: AGHT+IGj8cIJMcmZnt0Z7gGhk8OOVQYJMJl1xYFqwobcxr/KUDnKSJoS0bhBTfnbQM6utafXH9MmTHPg6r2sg0Fycms=
X-Received: by 2002:a05:6122:d9e:b0:520:5a87:66ed with SMTP id
 71dfb90a1353d-5235b89104amr196900e0c.5.1740683498839; Thu, 27 Feb 2025
 11:11:38 -0800 (PST)
MIME-Version: 1.0
References: <20250227052241.171102-1-alexandre.f.demers@gmail.com>
 <20250227052241.171102-3-alexandre.f.demers@gmail.com>
 <CADnq5_NkXjnE9ymMxNyoQObB3=PHw5Ed+pYihu_ssCH8d8M6yw@mail.gmail.com>
 <CAPEhTTFDMQwoWjk18LE98MkdMd9skzykf3QTQeF=E6JrPf17eg@mail.gmail.com>
 <CADnq5_PRCvX=PV-jzmQqesxXz2UDOUBJGc4DrzOSaNOcyDvTeg@mail.gmail.com>
 <CADnq5_OUfPPdmoZCPs=c9X5GRor4iy_ThTReWxaRNUBYe8gK6Q@mail.gmail.com>
In-Reply-To: <CADnq5_OUfPPdmoZCPs=c9X5GRor4iy_ThTReWxaRNUBYe8gK6Q@mail.gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Thu, 27 Feb 2025 14:11:27 -0500
X-Gm-Features: AQ5f1Jo7A9sdvUJF_gnqQKbzb3asEI_2bxwmnyya9Dy_Ar1YsnCODTDlksvqBz0
Message-ID: <CAPEhTTHRXVyqi8i7-Di_Xwo5q1c=T=vSJJZKuNxA8Hd0Rnh-rw@mail.gmail.com>
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

On Thu, Feb 27, 2025 at 2:05=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Thu, Feb 27, 2025 at 2:01=E2=80=AFPM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > On Thu, Feb 27, 2025 at 1:52=E2=80=AFPM Alexandre Demers
> > <alexandre.f.demers@gmail.com> wrote:
> > >
> > > On Thu, Feb 27, 2025 at 9:23=E2=80=AFAM Alex Deucher <alexdeucher@gma=
il.com> wrote:
> > > >
> > > > On Thu, Feb 27, 2025 at 12:49=E2=80=AFAM Alexandre Demers
> > > > <alexandre.f.demers@gmail.com> wrote:
> > > > >
> > > > > DCE6 was missing soft reset, but it was easily identifiable under=
 radeon.
> > > > > This should be it, pretty much as it is done under DCE8 and DCE10=
.
> > > > >
> > > > > Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 62 +++++++++++++++++++++=
+++---
> > > > >  1 file changed, 57 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/=
drm/amd/amdgpu/dce_v6_0.c
> > > > > index bd763fde1c50..254cb73324c6 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > > > > @@ -371,27 +371,58 @@ static u32 dce_v6_0_hpd_get_gpio_reg(struct=
 amdgpu_device *adev)
> > > > >         return mmDC_GPIO_HPD_A;
> > > > >  }
> > > > >
> > > > > +static bool dce_v6_0_is_display_hung(struct amdgpu_device *adev)
> > > > > +{
> > > > > +       u32 crtc_hung =3D 0;
> > > > > +       u32 crtc_status[6];
> > > > > +       u32 i, j, tmp;
> > > > > +
> > > > > +       for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> > > > > +               if (RREG32(mmCRTC_CONTROL + crtc_offsets[i]) & CR=
TC_CONTROL__CRTC_MASTER_EN_MASK) {
> > > > > +                       crtc_status[i] =3D RREG32(mmCRTC_STATUS_H=
V_COUNT + crtc_offsets[i]);
> > > > > +                       crtc_hung |=3D (1 << i);
> > > > > +               }
> > > > > +       }
> > > > > +
> > > > > +       for (j =3D 0; j < 10; j++) {
> > > > > +               for (i =3D 0; i < adev->mode_info.num_crtc; i++) =
{
> > > > > +                       if (crtc_hung & (1 << i)) {
> > > > > +                               tmp =3D RREG32(mmCRTC_STATUS_HV_C=
OUNT + crtc_offsets[i]);
> > > > > +                               if (tmp !=3D crtc_status[i])
> > > > > +                                       crtc_hung &=3D ~(1 << i);
> > > > > +                       }
> > > > > +               }
> > > > > +               if (crtc_hung =3D=3D 0)
> > > > > +                       return false;
> > > > > +               udelay(100);
> > > > > +       }
> > > > > +
> > > > > +       return true;
> > > > > +}
> > > > > +
> > > > >  static void dce_v6_0_set_vga_render_state(struct amdgpu_device *=
adev,
> > > > >                                           bool render)
> > > > >  {
> > > > >         if (!render)
> > > > >                 WREG32(mmVGA_RENDER_CONTROL,
> > > > >                         RREG32(mmVGA_RENDER_CONTROL) & VGA_VSTATU=
S_CNTL);
> > > > > -
> > > > >  }
> > > > >
> > > > >  static int dce_v6_0_get_num_crtc(struct amdgpu_device *adev)
> > > > >  {
> > > > > +       int num_crtc =3D 0;
> > > > > +
> > > > >         switch (adev->asic_type) {
> > > > >         case CHIP_TAHITI:
> > > > >         case CHIP_PITCAIRN:
> > > > >         case CHIP_VERDE:
> > > > > -               return 6;
> > > > > +               num_crtc =3D 6;
> > > > >         case CHIP_OLAND:
> > > > > -               return 2;
> > > > > +               num_crtc =3D 2;
> > > > >         default:
> > > > > -               return 0;
> > > > > +               num_crtc =3D 0;
> > > > >         }
> > > > > +       return num_crtc;
> > > >
> > > > Any particular reason for this change?  It just adds an extra varia=
ble.
> > > >
> > > > Alex
> > >
> > > Just for uniformisation with DCE8 and DCE10. We could also remove the
> > > variable and use returns everywhere.
> > >
> > > Any preferences?
> >
> > ah, ok. I think the direct returns are cleaner.
>
> I would maybe split up your patches into maybe 3 logical patch sets:
> one to fix spelling typos and comments, one to make the DCE code more
> uniform across versions, and another to add new DCE6 functionality.
>
> Alex
>
Ok, I'll split them and send new patch sets. Should they be identified as V=
2?

Alexandre
> >
> > Alex
> >
> > > Alexandre
> > >
> > > >
> > > > >  }
> > > > >
> > > > >  void dce_v6_0_disable_dce(struct amdgpu_device *adev)
> > > > > @@ -2846,7 +2877,28 @@ static bool dce_v6_0_is_idle(void *handle)
> > > > >
> > > > >  static int dce_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
> > > > >  {
> > > > > -       DRM_INFO("xxxx: dce_v6_0_soft_reset --- no impl!!\n");
> > > > > +       u32 srbm_soft_reset =3D 0, tmp;
> > > > > +       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > +
> > > > > +       if (dce_v6_0_is_display_hung(adev))
> > > > > +               srbm_soft_reset |=3D SRBM_SOFT_RESET__SOFT_RESET_=
DC_MASK;
> > > > > +
> > > > > +       if (srbm_soft_reset) {
> > > > > +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> > > > > +               tmp |=3D srbm_soft_reset;
> > > > > +               dev_info(adev->dev, "SRBM_SOFT_RESET=3D0x%08X\n",=
 tmp);
> > > > > +               WREG32(mmSRBM_SOFT_RESET, tmp);
> > > > > +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> > > > > +
> > > > > +               udelay(50);
> > > > > +
> > > > > +               tmp &=3D ~srbm_soft_reset;
> > > > > +               WREG32(mmSRBM_SOFT_RESET, tmp);
> > > > > +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> > > > > +
> > > > > +               /* Wait a little for things to settle down */
> > > > > +               udelay(50);
> > > > > +       }
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > --
> > > > > 2.48.1
> > > > >
