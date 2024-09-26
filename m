Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8548FCDE003
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 13:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D40510E281;
	Thu, 26 Sep 2024 13:20:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CUgfkosO";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FD3310E281
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 13:20:18 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-7a9afa7545cso7279285a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727356817; x=1727961617; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+QYt58MHtvlQ7qGVAk2h0D01nuzI4jVIGRv/Z/uyaPI=;
 b=CUgfkosO933gUcvjZsbWwvfZLTJBXupXwHkkOgR5ZcsqqjLr2/VrhRDmH3AVjCz84v
 FPmLmsf0rp6oPwNa9OTQ1nn5u/I1KArE3szK3xvYXA9AttlK4Czo+W3O9xdaItdPBMwj
 pbSVQuORj7ijcIfhODMn3XTspbJ+PakosD/BOmh86O4gehMp/6kPckRyFkJgQT/cUELg
 YfzuqpwhEb1AqluU5ctgIjAtCnS+oqONxfWiQ1sq66QZIFD4F8zuBX6nBxUAEx+haIoY
 l1LLuaLWtZASZDgsRf7CAN4rucVgHRbAR5JcxFESEz3T+2eaLNNSizV1h5LiqyKaS9An
 eiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727356817; x=1727961617;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+QYt58MHtvlQ7qGVAk2h0D01nuzI4jVIGRv/Z/uyaPI=;
 b=MWVGEAmx14fyVvRs2+OzIFVhuuXfAuc7yq5IxFdcbWaYr5nWgpctwzqlZmhem4TWcf
 41EaaIoZZY5hETs5jyGaqfnwrRTp9pas9BWwbJnVzP5oCpwB6Yw4sRKyM8tQthvItgiV
 B0ii/SpX1/Thfnw0YP3SBXuvLTicljipb2Fch6/zevNkiog7G1gdPKth6dvaKeMQmW4s
 4YC/elCMNSj4xTdgJ1eB/4LU3Maovqcz8/uqvQMUIZf2FwMu6CPK/cRZm2q+XL6LZed9
 zaTDnj0MxkjDmvT6JHQwezg/6uAVRI/G5+Hm3Cs/t/nKR/zQgMTbgIm965AOYoVYkpcL
 Dlgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhMS4A+5X4Z9aazB74pW5Ve6sRRpA989/CfRoFD1beamKk2QSucfH/nKS2FkmbPu7iQIvqW4Go@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYsqU/6gDOy4fDVUDmP3ulA2zdSSx2fYRMGF1mwLS40DTCSMzt
 Tw2SzzT/7tcnw1rPgNoTaldaR6NFGynyCtmlCdDIIbS1+refN7vx5MkM/qnmyOfCr/WcdT2GQHv
 h6zcXuGqY+NeQUmrHNDp6uaKtoWc=
X-Google-Smtp-Source: AGHT+IEwUdU1DlItNL27NbCQ+g86B8ouRcD+LeiO46K9rSvNkPQxnTw7ZvScTlDddTSbyLIDO1I9EVTbaG2KlaP+KGg=
X-Received: by 2002:a05:620a:3905:b0:7a9:a632:3fdf with SMTP id
 af79cd13be357-7ace745d967mr401586785a.13.1727356817478; Thu, 26 Sep 2024
 06:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240925182011.1194698-1-alexander.deucher@amd.com>
 <815cb8d5-0808-4322-9d15-0c6b402e64bf@amd.com>
In-Reply-To: <815cb8d5-0808-4322-9d15-0c6b402e64bf@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Sep 2024 09:20:04 -0400
Message-ID: <CADnq5_OBiyAckxTqc+94VEP3ab=Mny++txk+mGUJPMRD9UzBUg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix vbios fetching for SR-IOV
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Thu, Sep 26, 2024 at 7:18=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 9/25/2024 11:50 PM, Alex Deucher wrote:
> > SR-IOV fetches the vbios from VRAM in some cases.
> > Re-enable the VRAM path for dGPUs and rename the function
> > to make it clear that it is not IGP specific.
> >
> > Fixes: 042658d17a54 ("drm/amdgpu: clean up vbios fetching code")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_bios.c
> > index 46bf623919d7c..45affc02548c1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> > @@ -87,8 +87,9 @@ static bool check_atom_bios(uint8_t *bios, size_t siz=
e)
> >   * part of the system bios.  On boot, the system bios puts a
> >   * copy of the igp rom at the start of vram if a discrete card is
> >   * present.
> > + * For SR-IOV, the vbios image is also put in VRAM in the VF.
> >   */
> > -static bool igp_read_bios_from_vram(struct amdgpu_device *adev)
> > +static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
> >  {
> >       uint8_t __iomem *bios;
> >       resource_size_t vram_base;
> > @@ -414,7 +415,7 @@ static bool amdgpu_get_bios_apu(struct amdgpu_devic=
e *adev)
> >               goto success;
> >       }
> >
> > -     if (igp_read_bios_from_vram(adev)) {
> > +     if (amdgpu_read_bios_from_vram(adev)) {
> >               dev_info(adev->dev, "Fetched VBIOS from VRAM BAR\n");
> >               goto success;
> >       }
> > @@ -448,6 +449,12 @@ static bool amdgpu_get_bios_dgpu(struct amdgpu_dev=
ice *adev)
> >               goto success;
> >       }
> >
> > +     /* this is required for SR-IOV */
> > +     if (amdgpu_read_bios_from_vram(adev)) {
>
> If this is only expected for VFs, then it's better to add
> amdgpu_sriov_vf(adev) check for this call.

I think that is the case, but I'm not 100% sure.  I can ask the vbios team.

Alex


>
> Thanks,
> Lijo
>
> > +             dev_info(adev->dev, "Fetched VBIOS from VRAM BAR\n");
> > +             goto success;
> > +     }
> > +
> >       if (amdgpu_read_platform_bios(adev)) {
> >               dev_info(adev->dev, "Fetched VBIOS from platform\n");
> >               goto success;
