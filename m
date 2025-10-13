Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8EDCCD18D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 13:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7373910E380;
	Mon, 13 Oct 2025 13:44:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BhhJfjpP";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B24AB10E380
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 13:44:34 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-79cf7fd45afso59835b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 06:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760363074; x=1760967874; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8r66ZKjMX8hUTb7mM57w+FReEXT2W920iDabgn/p7do=;
 b=BhhJfjpPqzXyMJ8BCU6nWoIWysCrE54FqqAItSUsqjemnmlQ+VBDkzyTlshnb/jvSH
 e1E+/dz6WM/T9G7dPqo67gXvuzr9sl8k7GxxZkAqN5rgae7jFBVZl0r5r3pweG2sjOih
 DqSa8/2IpQ/a7M6fU1DVxsDnsPwg+q6kwnZc1OwHTK1Ure47WxvkVSA2rYXCumFT2U10
 9GBsYj8Zxmd0XUqREfNwvlj3qzsfhV112w0cj+/FSvcY3odFU/FFy9E/XpIb5wJuvbeX
 Nxx8o/p5fBkqAPLLnK2gSD7yb9Am/OibpEtkTMolId8AF9j3s5kWUS5RcrXEKujQ6L+l
 6+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760363074; x=1760967874;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8r66ZKjMX8hUTb7mM57w+FReEXT2W920iDabgn/p7do=;
 b=OjsoQh1HBo9dKlYM7D1bkLL4r61CUBUhcbMmq1Z88Ptddj3WmuhZdZ/aisZ9KP+A4m
 E9izahC6HBHO8dRHoTel7508DvZGI+Rtlc43Uw0TtjL71DBpGWTLLuh2NXOeW1tP0wC1
 gNBKh9rPAC2M+pvtFTEC2/n+p8ZqBnYqh9NZux8vwqiJCn9Dx84vIaeKVEck1RTrrHw5
 Mur8DbCvLxFAE5kMYDcnbBHaJ798sY58ytAJIq4RBsQlHK5oBb1LwCSyS4g2P6asIFWv
 y+I8vmhBhc7H3cyb2ZspK56UsZgXfrVD2/OOXDDQ02F8O6UxvWiDY0azOgJTh9Q7c/bz
 a8/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhXKIWw5yGkt/+poNWea3pnhOMhgV66IhdzI+jXLHXMifCGbCxdbrtwDGcX1s5AU/n+/5neepG@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzag6+Nvi3x2RjxQf0sTjhzTHqKYNUUs7jaMhNBSCapveGzj2sx
 GTkrhfyGv1Th7gv9mQHKQh63dWMLxhtWaIn+tRNLCRLCYkKA5zUFGWWVPUDupOIlq7ynBFiVlZP
 wGCTEk9Fsxo0gdrcT4mE3Ma63Lkemz6j8rA==
X-Gm-Gg: ASbGncumkjqWTzDvxqJdqWl4RsQ+IGWFQgj4fItP350d80CbZAXp3p9K94rygwTDLYI
 hAiVpRY3VGiNFqA1ipe0DAXrCCo0r0MaRewK07w3BhRTtANokvb52u+i3LkqNvuuic8Cylync9w
 W/qhciV3YIeuhIeRQeMWaxveIjj1R80BJeeeHbNpl1Zy6A/ID9sADJDkyzY7PvQZSxew5QMRVxp
 7yOj6nEzAGW7KH9J/ulE73Mp2ZNHq8eLLPs
X-Google-Smtp-Source: AGHT+IG35RGRb3XxxviBnj6w3f2ZmZepntQ27r6UB8264lIIPolbIWDHueNqgRIohh2V2DyjD2NuGRkvPkOpD0oqbWY=
X-Received: by 2002:a17:902:ea07:b0:264:cda8:7fd3 with SMTP id
 d9443c01a7336-2902743e550mr164215685ad.6.1760363074149; Mon, 13 Oct 2025
 06:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
 <20251010211510.1528572-3-alexander.deucher@amd.com>
 <DS7PR12MB6005A47FAE4B2CDE179E0A20FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005A47FAE4B2CDE179E0A20FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Oct 2025 09:44:22 -0400
X-Gm-Features: AS18NWDq0PlhXult2BA7RpL-OHwD_swXtfWTRgghebm3Di8fyWoz7dqPZtW038g
Message-ID: <CADnq5_PvKvj8wnNHuUWcUxGedF71vDjZA9Bq=M+N_c+x-cAXgQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment to shadow
 info
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Mon, Oct 13, 2025 at 4:54=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> [Public]
>
> We may need to update the userspace EOP buffer request; otherwise, the EO=
P buffer validation may fail.

Existing userspace should be ok.  It currently uses PAGE_SIZE which is
larger than 2048.

> Per this kernel change: Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Thanks!

Alex

>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Saturday, October 11, 2025 5:15 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment to shad=
ow info
> >
> > This is used by firmware for compute user queues.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 ++
> > drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 4 ++++
> > drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 4 ++++
> >  3 files changed, 10 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > index fb5f7a0ee029f..7109a2ad9ec36 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -328,6 +328,8 @@ struct amdgpu_gfx_shadow_info {
> >       u32 shadow_alignment;
> >       u32 csa_size;
> >       u32 csa_alignment;
> > +     u32 eop_size;
> > +     u32 eop_alignment;
> >  };
> >
> >  struct amdgpu_gfx_funcs {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > index 6f4c2e746165e..9c79bfa4f1ef6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -1052,10 +1052,14 @@ static void gfx_v11_0_select_me_pipe_q(struct
> > amdgpu_device *adev,  static void gfx_v11_0_get_gfx_shadow_info_nocheck=
(struct
> > amdgpu_device *adev,
> >                                        struct amdgpu_gfx_shadow_info
> > *shadow_info)  {
> > +     /* for gfx */
> >       shadow_info->shadow_size =3D MQD_SHADOW_BASE_SIZE;
> >       shadow_info->shadow_alignment =3D MQD_SHADOW_BASE_ALIGNMENT;
> >       shadow_info->csa_size =3D MQD_FWWORKAREA_SIZE;
> >       shadow_info->csa_alignment =3D MQD_FWWORKAREA_ALIGNMENT;
> > +     /* for compute */
> > +     shadow_info->eop_size =3D GFX11_MEC_HPD_SIZE;
> > +     shadow_info->eop_alignment =3D 256;
> >  }
> >
> >  static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev, d=
iff --git
> > a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > index 453e4034389f2..fd37f2355f86e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > @@ -909,10 +909,14 @@ static void gfx_v12_0_select_me_pipe_q(struct
> > amdgpu_device *adev,  static void gfx_v12_0_get_gfx_shadow_info_nocheck=
(struct
> > amdgpu_device *adev,
> >                                                 struct amdgpu_gfx_shado=
w_info
> > *shadow_info)  {
> > +     /* for gfx */
> >       shadow_info->shadow_size =3D MQD_SHADOW_BASE_SIZE;
> >       shadow_info->shadow_alignment =3D MQD_SHADOW_BASE_ALIGNMENT;
> >       shadow_info->csa_size =3D MQD_FWWORKAREA_SIZE;
> >       shadow_info->csa_alignment =3D MQD_FWWORKAREA_ALIGNMENT;
> > +     /* for compute */
> > +     shadow_info->eop_size =3D GFX12_MEC_HPD_SIZE;
> > +     shadow_info->eop_alignment =3D 256;
> >  }
> >
> >  static int gfx_v12_0_get_gfx_shadow_info(struct amdgpu_device *adev,
> > --
> > 2.51.0
>
