Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9525CC0219C
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 18:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D46610EB9E;
	Fri,  7 Feb 2025 18:28:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LeUqfHOf";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C220D10EB9C
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 18:27:55 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2f9f90103bbso556673a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Feb 2025 10:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738952875; x=1739557675; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KXtAStvOg0Y0ZWI8F59cjjRMyjmp5VhfHTQryZY42Yg=;
 b=LeUqfHOfysUSWBQeyNmyprU4VCdPc0t9UNDkt3iQNCZGiut8g6lgJyBGSPFE9Jkktp
 25qyICuCUAU39If5FxkXIplxwWB5Uoj5qJSEAAty+llhTAbZXask3yp4MWKNfRftH7JO
 2UW6BMXoclHg5kCjhl34c/AKD8gWKjJqq9r62l7oHe0SmPfh1Eyzcjw4gwSCMzWGy//B
 zMZq/E0++m66xL41U4UMYDktZGZPdwb/UJQEHcRQHMgz0S5/Hagqeqe5LmWJVgBTzCFy
 pexVZP65ODDjV7E+LNyaG1kD+/CIh4N+EULE6e4uEdGWgXpj6fYky7CSeRgRjx4ehn08
 VDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738952875; x=1739557675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KXtAStvOg0Y0ZWI8F59cjjRMyjmp5VhfHTQryZY42Yg=;
 b=R0JANyAMzmMPiB1Dbl37gBggf0qZMXkRsr6PUj6ZTnwM+9jI+I2px/CnH6DA+8U6bB
 1BdzFVBCSnKMMKoSDJ2AEIvznARPZ6c0WNZTqQz7V19WU1a1ckrwDVlUQ743L58SRfM3
 yGhiQ6xfk33hWc9bG3JNVuOwTR706B9+Wb91TE5H3DuCRXUYtzRXLyJthhTchCgEHzLZ
 thvMyqNilifhWaQBeGvfenGJ+uY6hUaT4BkiWCOAe6ej4NqwOgQgRkCp/Mcjw+kAvKde
 waaw2LaeYtM9nAtkAgCodgM4FkeM/7+paE2R4G0fd5oKs/rs03xqUEr7hEkyF3WZ6EOT
 IHXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/EIPw+3ag5becmR/hwv2cMAvJT2VTFnd0JrL9L+VfxsmL3v+0Kmd1/iwWZYDCa/ceOjECMhS7@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAQgHQBcleEyNbngYC2h+V2so/k1+AFnft7DyZ3r7tgcgm7buZ
 /wLKvNmYm5SO/RDppzZTcXDO7HFutZzTMhev1BHqpeIhVhkgM7WyB5fpqbidpbswzzfulfs0XcX
 MIILvBWVl1y/cerL+XTjEYmiJQaU=
X-Gm-Gg: ASbGncvRiyJ/Oygx1aGTDsfTNHOHP92Y7s/a7MVY/0hSxuz+xbq0iW46Z9jHD/o2nNg
 YQEkohBIS3lQsaRjZk+FTx9Zx8yP+bMR5jjxdKCHByR+SNStVFndVXbShbTGiFx6+dpzEllIl
X-Google-Smtp-Source: AGHT+IFT/NirgKbAm8qZNUrJp4yJtJ/GCDcqqTtMYLxILqD1fxrtp4PevZD/5ZrMZCqTP4U9/3AEqnkW5GLEsZoOpXM=
X-Received: by 2002:a17:90b:1d92:b0:2ee:f440:bb93 with SMTP id
 98e67ed59e1d1-2fa242e75f7mr2504280a91.4.1738952875271; Fri, 07 Feb 2025
 10:27:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1738909308.git.gerry@linux.alibaba.com>
 <d6d0b42a335784ae16500664ed3a0fc17bbe0476.1738909308.git.gerry@linux.alibaba.com>
 <2c412261-20df-4b2a-9cf2-cae0688d3887@amd.com>
In-Reply-To: <2c412261-20df-4b2a-9cf2-cae0688d3887@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Feb 2025 13:27:43 -0500
X-Gm-Features: AWEUYZnDB1gc4pLxfs9gvg8vSbytD8D5-g_bvM7xSwJqw9gW6K_EHvbU2PfbQfg
Message-ID: <CADnq5_NHYB=E1c0y+6ORo_N_oK379O8NWr=47QSF0-ApJ0TCAg@mail.gmail.com>
Subject: Re: [v1 3/4] drm/amdgpu: bail out when failed to load fw in
 psp_init_cap_microcode()
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com, 
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com, 
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com, 
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
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

Added the fixes tag and applied.  Thanks!

On Fri, Feb 7, 2025 at 6:07=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wro=
te:
>
>
>
> On 2/7/2025 11:58 AM, Jiang Liu wrote:
> > In function psp_init_cap_microcode(), it should bail out when failed to
> > load firmware, otherwise it may cause invalid memory access.
> >
> > Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>
> You may also add
>
>         Fixes: 07dbfc6b102e ("drm/amd: Use `amdgpu_ucode_*` helpers for P=
SP")
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Thanks,
> Lijo
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_psp.c
> > index 0d1eb7b8e59b..952da6c7943d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -3838,9 +3838,10 @@ int psp_init_cap_microcode(struct psp_context *p=
sp, const char *chip_name)
> >               if (err =3D=3D -ENODEV) {
> >                       dev_warn(adev->dev, "cap microcode does not exist=
, skip\n");
> >                       err =3D 0;
> > -                     goto out;
> > +             } else {
> > +                     dev_err(adev->dev, "fail to initialize cap microc=
ode\n");
> >               }
> > -             dev_err(adev->dev, "fail to initialize cap microcode\n");
> > +             goto out;
> >       }
> >
> >       info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_CAP];
>
