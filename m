Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7137CA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 16:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F7D910E6A9;
	Tue, 26 Aug 2025 16:32:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W9v228r7";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C801210E6B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 16:32:06 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b4c27bdc259so309414a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756225926; x=1756830726; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHSDypqHOOk6osgXzA+8WxKPxKWGxAytI2s6DahvMQ0=;
 b=W9v228r7fiIIzAsfP6+RT1UeGI2u5HsEWFaDzuEAsTNpPlm9c4qU5ndxPkoHA1WOsf
 N6/PNJtpaLX1m4IHRDRxbZQA/OLEPR/XWrRYeK10KQw1tFFvvwZPd6qYSxB0k19W1/6H
 +EQQ5/fomYGc6GF/jgAyFFprh1jQBjO3NQqndCwJedTvdny2+ljS+krZeuto7BN2dEe9
 cDL2pHwUSBJCN52FV6BA4NQHziLNU6sxcE8lwEEGj7/htZRX6OXFLD6i4/AC7aDElElK
 Js90DeO7DDKhccUWM4DqrYo4oWpfOJx9yTZ4eog0E1dmYiYY5FLDz0elkxgsuQIAA1TL
 Ja+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756225926; x=1756830726;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gHSDypqHOOk6osgXzA+8WxKPxKWGxAytI2s6DahvMQ0=;
 b=CAO/56W1dLcsFius1mm04AVWDIdieDqWHMmfUYKUgmohlwi+yV4tR0YSrHvY/qJ5fC
 zTh8lWDsmUyWadF2ZMHK2qoXiLppVi8Pry2RZeH/lRLE25q2Gf9ub04z98tXF/2wskqz
 RJOAx45Xha7inmI0nYoiyDuU8Po9t4/GN/edOG1EAkbsqEIIP0ASR1KSURa2SFljS5IC
 VWkwMH2/fubRWqqHsZFYoMl/q8nJJnqBAW3su2My63+jst4c6gUNaYGF8E/YyjATUqC7
 2txaHfAU6uZo3ikNIoLilDwsElsBwdY1lvhv7uxsyEkscCKcyB62FnMt5DeNsw7b9lYn
 NPDA==
X-Gm-Message-State: AOJu0Yw4w0EIsQNBhVQqNqu0pUgjfmOrX71u4gpapVgVqYDoIcKOV4OZ
 Ydz7O68dHq97rFAPoJ36rO2cV8aKTb+Rsvehq1QRDICSrt9C/bUGdP6GbZ9FJUlA9WGhNxWBqYZ
 t25S2ljmG9qQpTd16nyAfEOavICVL83M=
X-Gm-Gg: ASbGncue6eXLxLJ462DHWdkO1caf5GW/7Y8QTBhOvQ47rz0AkWrR2guNaMP07MhNTRn
 mR0y1oX71ozaSpfHaCt0FM2F1rUodo+qJmMJF9OMZ6QtLz0AbP/UT4wOJNblaKGWP9QLKq2ZqR0
 eGV3sRcTtDJfQtbLDR8JrORpPBGh3wT4LMwxOeuOhOVmCFYYHWhrS3Bm+Z/Xapt3OQgJzQx0FeS
 gfpRe4=
X-Google-Smtp-Source: AGHT+IEwIVXL4cP/21KjY3fa8n5tTQJGioOD3i1gbfi5T/iCcbNNr8lbNqtY5nd3xDUD9XzpX0EFInpr6SiO90xMbGs=
X-Received: by 2002:a17:90b:4b0f:b0:325:8f8c:4e13 with SMTP id
 98e67ed59e1d1-3258f8c503cmr6203380a91.2.1756225926186; Tue, 26 Aug 2025
 09:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250808151517.1596616-1-alexander.deucher@amd.com>
In-Reply-To: <20250808151517.1596616-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 12:31:54 -0400
X-Gm-Features: Ac12FXzaPTqWyhS_lK7IZdRsLFg3Tx236cSDKlNP6zTb32rf63B565jLFoSGzyc
Message-ID: <CADnq5_Mx8uEPttTvpuMhDQNMysR1+zi2P+LnRbrmESakFG1Bqg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: drop hw access in non-DC audio fini
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org, 
 oushixiong <oushixiong1025@163.com>
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

ping?

On Fri, Aug 8, 2025 at 11:23=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> We already disable the audio pins in hw_fini so
> there is no need to do it again in sw_fini.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4481
> Cc: stable@vger.kernel.org
> Cc: oushixiong <oushixiong1025@163.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 5 -----
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c | 5 -----
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 5 -----
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 5 -----
>  4 files changed, 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/dce_v10_0.c
> index bf7c22f81cda3..ba73518f5cdf3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -1462,17 +1462,12 @@ static int dce_v10_0_audio_init(struct amdgpu_dev=
ice *adev)
>
>  static void dce_v10_0_audio_fini(struct amdgpu_device *adev)
>  {
> -       int i;
> -
>         if (!amdgpu_audio)
>                 return;
>
>         if (!adev->mode_info.audio.enabled)
>                 return;
>
> -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> -               dce_v10_0_audio_enable(adev, &adev->mode_info.audio.pin[i=
], false);
> -
>         adev->mode_info.audio.enabled =3D false;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/dce_v11_0.c
> index 47e05783c4a0e..b01d88d078fa2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> @@ -1511,17 +1511,12 @@ static int dce_v11_0_audio_init(struct amdgpu_dev=
ice *adev)
>
>  static void dce_v11_0_audio_fini(struct amdgpu_device *adev)
>  {
> -       int i;
> -
>         if (!amdgpu_audio)
>                 return;
>
>         if (!adev->mode_info.audio.enabled)
>                 return;
>
> -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> -               dce_v11_0_audio_enable(adev, &adev->mode_info.audio.pin[i=
], false);
> -
>         adev->mode_info.audio.enabled =3D false;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index 276c025c4c03d..81760a26f2ffc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -1451,17 +1451,12 @@ static int dce_v6_0_audio_init(struct amdgpu_devi=
ce *adev)
>
>  static void dce_v6_0_audio_fini(struct amdgpu_device *adev)
>  {
> -       int i;
> -
>         if (!amdgpu_audio)
>                 return;
>
>         if (!adev->mode_info.audio.enabled)
>                 return;
>
> -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> -               dce_v6_0_audio_enable(adev, &adev->mode_info.audio.pin[i]=
, false);
> -
>         adev->mode_info.audio.enabled =3D false;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v8_0.c
> index e62ccf9eb73de..19a265bd4d196 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -1443,17 +1443,12 @@ static int dce_v8_0_audio_init(struct amdgpu_devi=
ce *adev)
>
>  static void dce_v8_0_audio_fini(struct amdgpu_device *adev)
>  {
> -       int i;
> -
>         if (!amdgpu_audio)
>                 return;
>
>         if (!adev->mode_info.audio.enabled)
>                 return;
>
> -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> -               dce_v8_0_audio_enable(adev, &adev->mode_info.audio.pin[i]=
, false);
> -
>         adev->mode_info.audio.enabled =3D false;
>  }
>
> --
> 2.50.1
>
