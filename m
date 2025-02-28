Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E29C19776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 14:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC3810ECCC;
	Fri, 28 Feb 2025 14:32:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TCcCFncC";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DB1210ECC7
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 14:32:19 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2f74e6c6cbcso586498a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 06:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740753139; x=1741357939; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SxqZPp3MWbB/20sL7gQy1tqy1o2CBUkEtG2KGbDiY08=;
 b=TCcCFncCREE4SfuT2eI2mI/8WVX5jYr+fgcIDJcdcplDpnohNL/SNf7AeEODr4eWXm
 Ww7VjPTmMChZoOWNk8pDvyXFKdhToWniCALBrkHWLXeQWBQFCbg2K6XOlRGtBR0VOkkb
 VX/6bhdmN3UjlGtEoeLyPHwDj0BG5vJ7FQ5aZawxmZ4XgPlAfi0JWSzOukYG2AZLKdNP
 c2oCpsbU0S1UgX4wldnHu2S8u/uE5LRfu4PjyQhnr0sBtNR7vtxALeU0SO2hMLPAUG0f
 8afCW2pTIP45GoqloDFN1RZ5D/l9ejJAX6xbpiFTe34wxBvk+HpY+4Iqvgm7/Nub8xnV
 hheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740753139; x=1741357939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SxqZPp3MWbB/20sL7gQy1tqy1o2CBUkEtG2KGbDiY08=;
 b=A6Bd4bFqPkQcrbnudcEfhU0BwjrkPlN7ibppDLo4ifSUE1zW36/9RXPvZ2MqK4BgMN
 X+7s7myoxLRJrwNga22yllk2IOjnqk6PlrYl9+gqxkEa6rX2fCoZ+PXQ4NqQgoJ250mD
 UV9H2tJMZwnXyDVntogCxrni5ltSFpmN1l0Vn5TTNGCAf7lizjuKikDVCgIwD1P/hZaz
 TicJ0p00XNJXvS72bIX582qAk3iuVlFeDn4I76gMUYtz3ht838/CXjcZj9mD2kYLrlc5
 nMskI16G9hl8m2sAjm2FKQmEdeodtybTGggyq92isHl0SXl0GgjtxsBe1dNJM4h2RtR5
 S/9Q==
X-Gm-Message-State: AOJu0YyrB/b99gfonORqAO8tUqFFdqEEW+hCxfe0YiNIR26HoB+6gpAd
 zhpdVk3yF1r4mq+6yTc6DBh/9SdQ5IIcY0SM0oYq77NZV/MJgvnktytqmRy7XH5bIlgQ2YiQUWz
 D+ACVBfHlO5foioBvXs1K7SmHxZ8nLA==
X-Gm-Gg: ASbGnctQNmAQp9nrefmr+g+EreWv6HNenX0aq0CHSLgPQoBKUktNZjbWOmk7NhknYo/
 RYgu2h4QRl5eeJpduRZ3kSiOTxnZq0HU6IErfDPn03brCA177cBPd24sNpjtm7VbxrpS7ENLDc8
 v8sA74Xg8=
X-Google-Smtp-Source: AGHT+IEOqOnctGeStGiJZHT84zyC6ESOZQTiBNulZOzaB7vczqMXQ1DJEENU87R81e+jGpU0c9OYCRxge4NCNN6SRzw=
X-Received: by 2002:a17:90b:1805:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-2febabdc1cbmr2234342a91.3.1740753138709; Fri, 28 Feb 2025
 06:32:18 -0800 (PST)
MIME-Version: 1.0
References: <20250227052241.171102-1-alexandre.f.demers@gmail.com>
 <20250227052241.171102-3-alexandre.f.demers@gmail.com>
 <CADnq5_NkXjnE9ymMxNyoQObB3=PHw5Ed+pYihu_ssCH8d8M6yw@mail.gmail.com>
 <CAPEhTTFDMQwoWjk18LE98MkdMd9skzykf3QTQeF=E6JrPf17eg@mail.gmail.com>
 <CADnq5_PRCvX=PV-jzmQqesxXz2UDOUBJGc4DrzOSaNOcyDvTeg@mail.gmail.com>
 <CADnq5_OUfPPdmoZCPs=c9X5GRor4iy_ThTReWxaRNUBYe8gK6Q@mail.gmail.com>
 <CAPEhTTHRXVyqi8i7-Di_Xwo5q1c=T=vSJJZKuNxA8Hd0Rnh-rw@mail.gmail.com>
In-Reply-To: <CAPEhTTHRXVyqi8i7-Di_Xwo5q1c=T=vSJJZKuNxA8Hd0Rnh-rw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Feb 2025 09:32:07 -0500
X-Gm-Features: AQ5f1Jqg69SXFeud62tBBnGUMrDJaUQXJKBkk0cu3i_kdGhipiNQt1hiYgfljjs
Message-ID: <CADnq5_M=Q9FhU5MiJxGzM3M85_9d+5kvTy7yKE7G=_wj+1NfnA@mail.gmail.com>
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

On Thu, Feb 27, 2025 at 2:11=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> On Thu, Feb 27, 2025 at 2:05=E2=80=AFPM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > On Thu, Feb 27, 2025 at 2:01=E2=80=AFPM Alex Deucher <alexdeucher@gmail=
.com> wrote:
> > >
> > > On Thu, Feb 27, 2025 at 1:52=E2=80=AFPM Alexandre Demers
> > > <alexandre.f.demers@gmail.com> wrote:
> > > >
> > > > On Thu, Feb 27, 2025 at 9:23=E2=80=AFAM Alex Deucher <alexdeucher@g=
mail.com> wrote:
> > > > >
> > > > > On Thu, Feb 27, 2025 at 12:49=E2=80=AFAM Alexandre Demers
> > > > > <alexandre.f.demers@gmail.com> wrote:
> > > > > >
> > > > > > DCE6 was missing soft reset, but it was easily identifiable und=
er radeon.
> > > > > > This should be it, pretty much as it is done under DCE8 and DCE=
10.
> > > > > >
> > > > > > Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> > > > > > ---
> > > > > >  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 62 +++++++++++++++++++=
+++++---
> > > > > >  1 file changed, 57 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gp=
u/drm/amd/amdgpu/dce_v6_0.c
> > > > > > index bd763fde1c50..254cb73324c6 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > > > > > @@ -371,27 +371,58 @@ static u32 dce_v6_0_hpd_get_gpio_reg(stru=
ct amdgpu_device *adev)
> > > > > >         return mmDC_GPIO_HPD_A;
> > > > > >  }
> > > > > >
> > > > > > +static bool dce_v6_0_is_display_hung(struct amdgpu_device *ade=
v)
> > > > > > +{
> > > > > > +       u32 crtc_hung =3D 0;
> > > > > > +       u32 crtc_status[6];
> > > > > > +       u32 i, j, tmp;
> > > > > > +
> > > > > > +       for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> > > > > > +               if (RREG32(mmCRTC_CONTROL + crtc_offsets[i]) & =
CRTC_CONTROL__CRTC_MASTER_EN_MASK) {
> > > > > > +                       crtc_status[i] =3D RREG32(mmCRTC_STATUS=
_HV_COUNT + crtc_offsets[i]);
> > > > > > +                       crtc_hung |=3D (1 << i);
> > > > > > +               }
> > > > > > +       }
> > > > > > +
> > > > > > +       for (j =3D 0; j < 10; j++) {
> > > > > > +               for (i =3D 0; i < adev->mode_info.num_crtc; i++=
) {
> > > > > > +                       if (crtc_hung & (1 << i)) {
> > > > > > +                               tmp =3D RREG32(mmCRTC_STATUS_HV=
_COUNT + crtc_offsets[i]);
> > > > > > +                               if (tmp !=3D crtc_status[i])
> > > > > > +                                       crtc_hung &=3D ~(1 << i=
);
> > > > > > +                       }
> > > > > > +               }
> > > > > > +               if (crtc_hung =3D=3D 0)
> > > > > > +                       return false;
> > > > > > +               udelay(100);
> > > > > > +       }
> > > > > > +
> > > > > > +       return true;
> > > > > > +}
> > > > > > +
> > > > > >  static void dce_v6_0_set_vga_render_state(struct amdgpu_device=
 *adev,
> > > > > >                                           bool render)
> > > > > >  {
> > > > > >         if (!render)
> > > > > >                 WREG32(mmVGA_RENDER_CONTROL,
> > > > > >                         RREG32(mmVGA_RENDER_CONTROL) & VGA_VSTA=
TUS_CNTL);
> > > > > > -
> > > > > >  }
> > > > > >
> > > > > >  static int dce_v6_0_get_num_crtc(struct amdgpu_device *adev)
> > > > > >  {
> > > > > > +       int num_crtc =3D 0;
> > > > > > +
> > > > > >         switch (adev->asic_type) {
> > > > > >         case CHIP_TAHITI:
> > > > > >         case CHIP_PITCAIRN:
> > > > > >         case CHIP_VERDE:
> > > > > > -               return 6;
> > > > > > +               num_crtc =3D 6;
> > > > > >         case CHIP_OLAND:
> > > > > > -               return 2;
> > > > > > +               num_crtc =3D 2;
> > > > > >         default:
> > > > > > -               return 0;
> > > > > > +               num_crtc =3D 0;
> > > > > >         }
> > > > > > +       return num_crtc;
> > > > >
> > > > > Any particular reason for this change?  It just adds an extra var=
iable.
> > > > >
> > > > > Alex
> > > >
> > > > Just for uniformisation with DCE8 and DCE10. We could also remove t=
he
> > > > variable and use returns everywhere.
> > > >
> > > > Any preferences?
> > >
> > > ah, ok. I think the direct returns are cleaner.
> >
> > I would maybe split up your patches into maybe 3 logical patch sets:
> > one to fix spelling typos and comments, one to make the DCE code more
> > uniform across versions, and another to add new DCE6 functionality.
> >
> > Alex
> >
> Ok, I'll split them and send new patch sets. Should they be identified as=
 V2?

Yes, sounds good.

Thanks,

Alex

>
> Alexandre
> > >
> > > Alex
> > >
> > > > Alexandre
> > > >
> > > > >
> > > > > >  }
> > > > > >
> > > > > >  void dce_v6_0_disable_dce(struct amdgpu_device *adev)
> > > > > > @@ -2846,7 +2877,28 @@ static bool dce_v6_0_is_idle(void *handl=
e)
> > > > > >
> > > > > >  static int dce_v6_0_soft_reset(struct amdgpu_ip_block *ip_bloc=
k)
> > > > > >  {
> > > > > > -       DRM_INFO("xxxx: dce_v6_0_soft_reset --- no impl!!\n");
> > > > > > +       u32 srbm_soft_reset =3D 0, tmp;
> > > > > > +       struct amdgpu_device *adev =3D ip_block->adev;
> > > > > > +
> > > > > > +       if (dce_v6_0_is_display_hung(adev))
> > > > > > +               srbm_soft_reset |=3D SRBM_SOFT_RESET__SOFT_RESE=
T_DC_MASK;
> > > > > > +
> > > > > > +       if (srbm_soft_reset) {
> > > > > > +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> > > > > > +               tmp |=3D srbm_soft_reset;
> > > > > > +               dev_info(adev->dev, "SRBM_SOFT_RESET=3D0x%08X\n=
", tmp);
> > > > > > +               WREG32(mmSRBM_SOFT_RESET, tmp);
> > > > > > +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> > > > > > +
> > > > > > +               udelay(50);
> > > > > > +
> > > > > > +               tmp &=3D ~srbm_soft_reset;
> > > > > > +               WREG32(mmSRBM_SOFT_RESET, tmp);
> > > > > > +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> > > > > > +
> > > > > > +               /* Wait a little for things to settle down */
> > > > > > +               udelay(50);
> > > > > > +       }
> > > > > >         return 0;
> > > > > >  }
> > > > > >
> > > > > > --
> > > > > > 2.48.1
> > > > > >
