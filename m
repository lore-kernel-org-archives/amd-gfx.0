Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68233C197BF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 19:05:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D64010E15C;
	Thu, 27 Feb 2025 19:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FdtUMG7V";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84EC610E15C
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 19:05:51 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-216513f8104so2825195ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 11:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740683150; x=1741287950; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vm0nP1OFJRHbMTeZMGvNXnhATFQ3hEe85dMw9L0AZFM=;
 b=FdtUMG7V48tPUZESjK/kbZPFL6RiYKOh5tDGYNdUbqGwcqUvxmll/xoujaZc0GorC/
 otsnGxCDwQMc56Q6ba28IqWogX2eL7fFM3OzA9JYI/bE4egLheY8eZhMwgamQdBCQNlw
 roRQqUC3BDHechAu+en+LsBencQFnPeYpr07L3tseD81qXwwJRMzxXf8srJHXBo1OwU0
 huJ7PXX5K6tAwSfCFjTk9fmC3V6q9+SAJin+cJy1KvPr9iAcrFJTDlhQJTEA/y2sYlcg
 6PB9+J8l/+HBJeesHQ1RjRXVuTR4NkAwWtNtbwwtmtwwxcXwhiWrzbe37/CJUr/6u0Vk
 TYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740683150; x=1741287950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vm0nP1OFJRHbMTeZMGvNXnhATFQ3hEe85dMw9L0AZFM=;
 b=urdj48b+5easpwQH8rbpCisr7Iz3Pkm4NrgmEWUQ8gq0Z9v84ToTAKNFQLYe1zVupO
 hFVN5EvuwsbKZl9KdxMfuVPzyvwhPl9vLo62es/xC3Z6HGAxEDxoaSSSOiPXKpvi1z9k
 Jkbjo5+skipAAqBnk7mEx+E616FojxuoKM8SSMHbvgvZ3fuS247EnAzZxmIeZUEAaBVr
 iUJLg+nV7ALyAHbnk2/SEWmUlx/nk2dd3wqGDPRN8g5tJ/RHAFC8N7qqJeLy9GCQbdW9
 nBz5SCMfeR9ALgapFja4b2X4hEOqmbuDvdQMtZazVcx2fxG1LgO4850bR6lUrpO/dktz
 8T0Q==
X-Gm-Message-State: AOJu0Yyq5HjEJGxmsjdDBHmmkKgojCVgzlc7mjBXTmQexgme0HinjqIT
 fg/IrERIAp6g8gqCkkJnH28nRjK7AVUUfzu3HmDs57g9ZBLThFm2BW8Y+tC0F9WJ3SW/2QHpSq9
 hEdvvhkIQzYHuzsQZOn0pLFjgsbiumQ==
X-Gm-Gg: ASbGnctcS/E0zkK4f3fZzUFQ43MXTCakMaK+PjFITCloIadEq157T0sJNo9Fqm28CR0
 4rYNF4/++0uXZb/+XeX1b5u3BBoO6FZ4sEk+Bq61S9o7hH7SMVEFutouzK5RRezZo1d1UEOelB1
 6ZYvqyNTY=
X-Google-Smtp-Source: AGHT+IGETt/b2o1au2QMpy7i0bLWEq2euWNqCQIPOl32C0Lxx7pGMlOJ2w1hn+tSLZvAQFLelGLKU0ul/NJOpJmRTHM=
X-Received: by 2002:a17:903:32c8:b0:21b:b115:1dd9 with SMTP id
 d9443c01a7336-22368fce12dmr1750455ad.5.1740683149993; Thu, 27 Feb 2025
 11:05:49 -0800 (PST)
MIME-Version: 1.0
References: <20250227052241.171102-1-alexandre.f.demers@gmail.com>
 <20250227052241.171102-3-alexandre.f.demers@gmail.com>
 <CADnq5_NkXjnE9ymMxNyoQObB3=PHw5Ed+pYihu_ssCH8d8M6yw@mail.gmail.com>
 <CAPEhTTFDMQwoWjk18LE98MkdMd9skzykf3QTQeF=E6JrPf17eg@mail.gmail.com>
 <CADnq5_PRCvX=PV-jzmQqesxXz2UDOUBJGc4DrzOSaNOcyDvTeg@mail.gmail.com>
In-Reply-To: <CADnq5_PRCvX=PV-jzmQqesxXz2UDOUBJGc4DrzOSaNOcyDvTeg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Feb 2025 14:05:38 -0500
X-Gm-Features: AQ5f1JpAZpo7Hq5LHAcEFGjrI47oMsqYOdODasy1URn4vZi1wu78rp62jnSY54s
Message-ID: <CADnq5_OUfPPdmoZCPs=c9X5GRor4iy_ThTReWxaRNUBYe8gK6Q@mail.gmail.com>
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

I would maybe split up your patches into maybe 3 logical patch sets:
one to fix spelling typos and comments, one to make the DCE code more
uniform across versions, and another to add new DCE6 functionality.

Alex

>
> Alex
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
