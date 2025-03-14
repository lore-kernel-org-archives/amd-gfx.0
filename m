Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A82C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 13:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A6D210E9E5;
	Fri, 14 Mar 2025 13:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hGJuwhV5";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FDC310E9E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 13:28:23 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2ff66327419so513027a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 06:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741958903; x=1742563703; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HTHxGPCKfM8qpTQVIHmQvr2uaKpPRyCf5PcaA5e0Qo8=;
 b=hGJuwhV5wBWUrgF3Wt16lT+o23orvJQMK/wfwEAQ8PMAW5nCgg6lXt7c3XxHtgrAgO
 VfG/QxkZmSjnEjtVB5tT7NtfCnrpQHKXVhN2GL7ptGpim9ejInNnYWLwV8uHuLp/TT2B
 OP0GoqWrwvTzTQpO83COfcX3vuuB/KUVKdnK6WCnRN9GY1TQyZk4LrykzRMedGHxoGMp
 A0vXcRy4PXkp2nGvFFZjmNVP9TtW5dkhcpun9oEaCnVTcOEyU25tbcFOZUValaW+5tvA
 Yw7iam0zDhKNb2HWMVmkRCzrCeuRNX37A44bSbWUwR2Zl2/NIF0HxdhO1kak1l/D187u
 t6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741958903; x=1742563703;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HTHxGPCKfM8qpTQVIHmQvr2uaKpPRyCf5PcaA5e0Qo8=;
 b=I8Kh5W5BgGHw4kxME5wrn439f0Xt4S7pTjA0CfspDfxcO1Cq6WFrl1Jsi4hRmFpGRV
 ZfX4SI4vp8tpjAwM3pTzlCPowRwAZ4SovmdDHoWf0/1MtaDHmhzixckZ1YSPsX4PmAOG
 dRf8fuYv4yBXdwsJdxb08eN3fCxOQvklAu0hCyhaY0j2dsipR2JiOVXqCA3lkZRwAl30
 g6DSg/PzHsasGHaeOt/3yQN60gzG1ZrUWmnQFcTMr4m7EQp07R3gNlsLxISxSBcAHYzK
 l48HngKZN3AIISCnNWjZ7KwO3UErg+6fHVr8RwcLjDQE9MmUcUTiK23ZntzdDI8JaGg2
 L+8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV052v/2wOIrDEA3paQEAb+P29aUwZoOkmOx4wMpG+U0kc4QPHyUNH+TnG0m0Kjr9FyvM475u99@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKJ5+AqZMletZ8Jny9cmM1VdY8vIM78daVXdUFgK6QZ/Be1GZA
 pwiVz08aZcDPkr0tQG84OnAW7H2V8TBoZUZg1Ve/aH36h7Sg5nYETN1moltkqpgzDm7sTNksG2Z
 4VWREGYez6LvTVmbrGuah5Fewl7lPiw==
X-Gm-Gg: ASbGncvhzDSUkkN/v28rpqftTpG9GLQwPgKGLtl6zGTPyfwLie5N0mxk5zf9Miw+uIM
 Tn0defeHg56HuUDZJQ660f/Vu/4TpKWFBLsFgXmBk5SA+lX99DQ7j0i2zyPAvpHcMoxHJ/m71RQ
 nLHkqtL20iRnr/PbxTfCVa8Y7EOQ==
X-Google-Smtp-Source: AGHT+IECESTssRqzhuHUJpz0oVLvjuYLG9FTZePY+qfdpCWXSULWF732BTWpFeJxZlfHSrabVmOVV0zY72nBU0fxl/o=
X-Received: by 2002:a17:90b:38ce:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-30151d68999mr1258724a91.3.1741958902818; Fri, 14 Mar 2025
 06:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250314095428.2914973-1-flora.cui@amd.com>
 <20250314095428.2914973-3-flora.cui@amd.com>
 <debc9622-7460-475f-977d-90fbdc89f896@amd.com>
In-Reply-To: <debc9622-7460-475f-977d-90fbdc89f896@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Mar 2025 09:28:11 -0400
X-Gm-Features: AQ5f1Jrq4sLRrohVSarjnd4UjVEFV15dBUGtXbGgJA76qsVF7OOJWfXTywFDFbI
Message-ID: <CADnq5_M_W0fHsegFhM=M9MmLYziOnKiHN0Xc6ZsRTDhPUc_WjQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/discovery: optionally use fw based ip
 discovery
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Flora Cui <flora.cui@amd.com>, amd-gfx@lists.freedesktop.org, 
 Alexander.Deucher@amd.com, Li.Meng@amd.com
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

On Fri, Mar 14, 2025 at 6:28=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 3/14/2025 3:24 PM, Flora Cui wrote:
> > From: Alex Deucher <alexander.deucher@amd.com>
> >
> > On chips without native IP discovery support, use the fw binary
> > if available, otherwise we can continue without it.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 38 +++++++++++++++----
> >  1 file changed, 30 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_discovery.c
> > index fff438baf64b..cf286fde18d5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -2536,6 +2536,36 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu=
_device *adev)
> >  {
> >       int r;
> >
> > +     switch (adev->asic_type) {
> > +     case CHIP_VEGA10:
> > +     case CHIP_VEGA12:
> > +     case CHIP_RAVEN:
> > +     case CHIP_VEGA20:
> > +     case CHIP_ARCTURUS:
> > +     case CHIP_ALDEBARAN:
> > +             /* this is not fatal.  We have a fallback below
> > +              * if the new firmwares are not present.
> > +              */
> > +             r =3D amdgpu_discovery_reg_base_init(adev);
> > +             if (!r) {
> > +                     amdgpu_discovery_harvest_ip(adev);
> > +                     amdgpu_discovery_get_gfx_info(adev);
> > +                     amdgpu_discovery_get_mall_info(adev);
> > +                     amdgpu_discovery_get_vcn_info(adev);
> > +             }
> > +             break;
> > +     default:
> > +             r =3D amdgpu_discovery_reg_base_init(adev);
> > +             if (r)
> > +                     return -EINVAL;
> > +
> > +             amdgpu_discovery_harvest_ip(adev);
> > +             amdgpu_discovery_get_gfx_info(adev);
> > +             amdgpu_discovery_get_mall_info(adev);
> > +             amdgpu_discovery_get_vcn_info(adev);
> > +             break;
> > +     }
> > +
> >       switch (adev->asic_type) {
>
> Looks like this fallback gets executed regardless of the
> presence/absence of new firmware.

That's by design.  The hardcoded settings we have today are not quite
the same as what the ip discovery table provides so we want them to
override what comes from the firmware either way.  We really just want
the ip discovery table so that we can setup the sysfs ip discovery
files because the ROCm profiler uses them for getting the GC register
offsets and wants to have them available for all gfx9+ parts.

Alex

>
> Thanks,
> Lijo
>
> >       case CHIP_VEGA10:
> >               vega10_reg_base_init(adev);
> > @@ -2700,14 +2730,6 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu=
_device *adev)
> >               adev->ip_versions[XGMI_HWIP][0] =3D IP_VERSION(6, 1, 0);
> >               break;
> >       default:
> > -             r =3D amdgpu_discovery_reg_base_init(adev);
> > -             if (r)
> > -                     return -EINVAL;
> > -
> > -             amdgpu_discovery_harvest_ip(adev);
> > -             amdgpu_discovery_get_gfx_info(adev);
> > -             amdgpu_discovery_get_mall_info(adev);
> > -             amdgpu_discovery_get_vcn_info(adev);
> >               break;
> >       }
> >
>
