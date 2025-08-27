Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311E6CA0EFF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 13:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2DE510E811;
	Wed, 27 Aug 2025 13:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cWKVMSYt";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6759410E811
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 13:00:57 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-248999413easo1349585ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756299657; x=1756904457; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVY+6MXElkysYxfiZm1PjzBsICSE61ftyHN5xsewEtI=;
 b=cWKVMSYtyFJYYUBRdKIFpsf+PVRA64szKGdP9ci41yBW8Bp3xCLTSdHVLVKhZaiW0v
 86tOGyDTIiRVB5KmXGbtl5QxxY4HauX3nPTXJvd/SHmGkhSxHfv1O3UHBBr72aU+b6lp
 MknJx5HH8x1WnrwMJkHiaFWLynofy/CzzyKYCCnmIZlzPULD0WDG4TgmAqF/emb8Ot7R
 wBPZ6iP4HoXHbGSAU7sEk4a7XA/g895Uu7jdZkaQ1uVLhW0NqR457VC0QxDeQSkFRbpH
 ACLsv08gUca9Eo62Q1aHyOIWyTGepx74Kw/0ZojKnHEbbF3CYoZMuL9Y922ImGHLTLJd
 A7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756299657; x=1756904457;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nVY+6MXElkysYxfiZm1PjzBsICSE61ftyHN5xsewEtI=;
 b=rFIJdXLGwLf+0X4+9nfCBK2nKG2SAh8kJ+k5k/1uHZNv6Q0p9X3DFw/6Zv3bFgM7pn
 iFH0p1YkhcvKIVRxRkz+VarrGlBoyZQLvpup1yNZlZjclAyz6N38H/wVOgL2pS+hcvgn
 awxcBxvNX+NCd5H4bjoDrsNXYIdZczjEDfJsqeCtYiEXm+LzXklZImgi1UXbbV6PSiQP
 fGSkSNUXr4m5rjFBKz+mrO3T46v3c50HmFXNUtqwb8LD1XvyXVXIr/bycgl2UCQJTfD4
 vJ5nq3wV5vm6p2BCA8NNFFCDW1BAihBfc4Nyb4SC/xwd+vwMnfsg0DgtPh66aMaC9uBj
 p8gQ==
X-Gm-Message-State: AOJu0YxxcXwevOb5TecgB5Tszji01Ecsbt7x/0WE3hWHPL34pRf7NVSQ
 GfZn55pI8csr3SHzndIiMXfLSYYcdYdLxgMXmylTSuK4O8EELRAIrxlX5PhtQL1DQgv9dQ940ZL
 R2AuIu46g3dxe5kgGBtlU39kGpuIzfGg=
X-Gm-Gg: ASbGnctCkkwCscV+3ROcz9jWUR8AuPJjFfKhhc7/YqWzw0NIc3Zu/ptgwLPdOmQ+6rR
 sRp0UBRUK5YZri6b0ls3iIGVF7YXSoOndlEYsOGzd/QtWeCXrzry8eU46M9lS5qNGQvadCrbe5c
 eWshZe2hVDXvLeInD/lwR1SnstWF6Qz6YC51os4VX/95+xGp4nQfhtZv8GfyNlzY+UQPDhr6XpC
 K3paVY=
X-Google-Smtp-Source: AGHT+IH3IjafNN5+2hzr77C+DU+ixhdf9uWAjMNJt9LNuTOePod3rIxWn3i6zSrNYnqAx4FY7zu/+O3hqrNZXMi4SAY=
X-Received: by 2002:a17:902:e78f:b0:240:4d65:508f with SMTP id
 d9443c01a7336-2462ef99564mr120482515ad.6.1756299655482; Wed, 27 Aug 2025
 06:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250826060245.334880-1-kevinyang.wang@amd.com>
 <20250826060245.334880-2-kevinyang.wang@amd.com>
 <CADnq5_OT1dE1zUgjAuQijEOtWeOhvVOf3gDQ7Ys8qADN=dxsfA@mail.gmail.com>
 <PH7PR12MB5997FCE0E22637F15A45A5818239A@PH7PR12MB5997.namprd12.prod.outlook.com>
 <PH7PR12MB5997194D9CEA85EE07C56FC28238A@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997194D9CEA85EE07C56FC28238A@PH7PR12MB5997.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Aug 2025 09:00:43 -0400
X-Gm-Features: Ac12FXzJvG_R6_ApBV344Ri_xCLVTb75kCIjG9UalJ2vbV5pDk0qtjsUlSzwIJw
Message-ID: <CADnq5_O7EEAud5qeEhwoA776tKM7CnZ1trnt3x-004eG_rMKKQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: unified amdgpu ip block name
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kamal,
 Asad" <Asad.Kamal@amd.com>
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

On Wed, Aug 27, 2025 at 3:20=E2=80=AFAM Wang, Yang(Kevin)
<KevinYang.Wang@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: Wang, Yang(Kevin)
> Sent: Wednesday, August 27, 2025 02:13
> To: Alex Deucher <alexdeucher@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org; Kamal, Asad <Asad.Kamal@amd.com>
> Subject: RE: [PATCH] drm/amd/amdgpu: unified amdgpu ip block name
>
>
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Tuesday, August 26, 2025 9:49 PM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Kamal, Asad <Asad.Kamal@amd.com>
> Subject: Re: [PATCH] drm/amd/amdgpu: unified amdgpu ip block name
>
> On Tue, Aug 26, 2025 at 2:03=E2=80=AFAM Yang Wang <kevinyang.wang@amd.com=
> wrote:
> >
> > 1. Unified amdgpu ip block name print with format
> >    {ip_type}_v{major}_{minor}_{rev}
> >
> > 2. Avoid IP block name conflicts for SMU/PSP ip block
>
> What is the conflict?
>
> Kevin: all SMU/PSP IP blocks share the same name "smu"/"psp" , and there =
is no IP version information here.
>
> Best Regards,
> Kevin
>
> >
> > Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> > Reviewed-by: Asad Kamal <asad.kamal@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 35
> > ++++++++++++++++++++--
> >  1 file changed, 33 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index e117494e8054..5754b1fe77be 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2447,6 +2447,33 @@ int amdgpu_device_ip_block_version_cmp(struct am=
dgpu_device *adev,
> >         return 1;
> >  }
> >
> > +static const char *ip_block_names[] =3D {
> > +       [AMD_IP_BLOCK_TYPE_COMMON] =3D  "common",
> > +       [AMD_IP_BLOCK_TYPE_GMC] =3D "gmc",
> > +       [AMD_IP_BLOCK_TYPE_IH] =3D "ih",
> > +       [AMD_IP_BLOCK_TYPE_SMC] =3D "smu",
> > +       [AMD_IP_BLOCK_TYPE_PSP] =3D "psp",
> > +       [AMD_IP_BLOCK_TYPE_DCE] =3D "dce",
> > +       [AMD_IP_BLOCK_TYPE_GFX] =3D "gfx",
> > +       [AMD_IP_BLOCK_TYPE_SDMA] =3D "sdma",
> > +       [AMD_IP_BLOCK_TYPE_UVD] =3D "uvd",
> > +       [AMD_IP_BLOCK_TYPE_VCE] =3D "vce",
> > +       [AMD_IP_BLOCK_TYPE_ACP] =3D "acp",
> > +       [AMD_IP_BLOCK_TYPE_VCN] =3D "vcn",
> > +       [AMD_IP_BLOCK_TYPE_MES] =3D "mes",
> > +       [AMD_IP_BLOCK_TYPE_JPEG] =3D "jpeg",
> > +       [AMD_IP_BLOCK_TYPE_VPE] =3D "vpe",
> > +       [AMD_IP_BLOCK_TYPE_UMSCH_MM] =3D "umsch_mm",
> > +       [AMD_IP_BLOCK_TYPE_ISP] =3D "isp", };
> > +
> > +static const char *ip_block_name(struct amdgpu_device *adev, enum
> > +amd_ip_block_type type) {
> > +       int idx =3D (int)type;
> > +
> > +       return idx < ARRAY_SIZE(ip_block_names) ? ip_block_names[idx]
> > +: "unknown"; }
> > +
> >  /**
> >   * amdgpu_device_ip_block_add
> >   *
> > @@ -2475,8 +2502,12 @@ int amdgpu_device_ip_block_add(struct amdgpu_dev=
ice *adev,
> >                 break;
> >         }
> >
> > -       dev_info(adev->dev, "detected ip block number %d <%s>\n",
> > -                adev->num_ip_blocks, ip_block_version->funcs->name);
>
> Can we keep ip_block_version->funcs->name?  There is useful information e=
ncoded in that.  E.g. dm vs dce_v6_0 depending on whether DC is enabled or =
not or powerplay vs swsmu for SMU.
>
>
> Alex
>
> [Kevin]:
> Agree, it is ok for me, please ignore this patch, thanks.

I think the patch is a nice cleanup, just include the name as well.  E.g.,

 +       dev_info(adev->dev, "detected ip block number %d
<%s_v%d_%d_%d> (%s)\n",
 +                adev->num_ip_blocks,
 +                ip_block_name(adev, ip_block_version->type),
 +                ip_block_version->major,
 +                ip_block_version->minor,
 +                ip_block_version->rev,
 +                ip_block_version->funcs->name);

Alex

>
> Best Regards,
> Kevin
>
> > +       dev_info(adev->dev, "detected ip block number %d <%s_v%d_%d_%d>=
\n",
> > +                adev->num_ip_blocks,
> > +                ip_block_name(adev, ip_block_version->type),
> > +                ip_block_version->major,
> > +                ip_block_version->minor,
> > +                ip_block_version->rev);
> >
> >         adev->ip_blocks[adev->num_ip_blocks].adev =3D adev;
> >
> > --
> > 2.34.1
> >
