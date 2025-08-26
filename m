Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F242FCA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 13:28:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B6C710E2F2;
	Tue, 26 Aug 2025 13:28:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DQx2WX/Y";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEE8410E2F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 13:28:43 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b471741b839so1175523a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 06:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756214923; x=1756819723; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KMxqO0Vs3CDduYcj1ujJRrgDGwFMgNTzih/PPpW3Iqo=;
 b=DQx2WX/Y4LxxmAUNnrdBl7DQBrKYVw9HBHxt2NDXKBcRNCKMnTz6qzlATHjGSNiAmc
 ARvNaB5CE+COr4U/SKrTrYhEsm8a0+dhDVqLWteQ5Bn6QTB6teFXW+hdL5r6+DV5K9UA
 vMKaIgLKP6ZOZckw7mqY94epGIuyevtIPux/VypOfOeROGmfd0aE/H9gno92bIb9CgYz
 Bmx+v555Gtl9hw6oZedXKWBQptHXSTDrdRLkkJP7lRhQiKjNYbNHm5puBvo06G8F/kiY
 /YhUsUUGeNImDPpSNP04nW2SreIik6MLC+bacbs0W16qmBnS5kxLhLvmSl/JG83a+PyN
 /bUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756214923; x=1756819723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KMxqO0Vs3CDduYcj1ujJRrgDGwFMgNTzih/PPpW3Iqo=;
 b=XFwd/8JVQcUqNarGXjXitX7vw4hElLcKoyse95A0H/ZBjsTKiavcuF4P96K6Zi8dgz
 91H9c3UF7DXZKO48xUNRWGwxDqH7y8B5uBlMHT9WaJIxbHG9tzCDa/10XGMla1obY0q/
 fF8hJkrHDNkK6kMtaRjhLHPgb0JJw4FtpNKhMx426pJkqnWxXmcSRP9QFsAbpoZ1LcQ7
 1C3JXDvN+NYDy/yS2aAmvRBr0b8bfK7YPJFS1OUwAInCcm88k/93hntqX0OLpwQ8XZQV
 vWIsLJVAkCm7Cw2gzUvtEP7DcxSDqwMWnQ8TkBOwtQXdwqSz3aFUYFDJrLmZCXKy6KSy
 4tog==
X-Gm-Message-State: AOJu0Yyhtxtt8S/aNpwou17+O6yWwxWZcM4msS+U+oADDhRX6IJ805A3
 Hkx+4f9kIjsZqCGK8Dq8LguCSExj+10jnMRTFAVZ4dpAI3dBQME2QItQd8ekL/NO2fcmOLDYOeA
 ysb9EYWtuQ9kaswZRHaD+iPy6doSMA6c=
X-Gm-Gg: ASbGncvB1rjQb/1GUd5QWAgpcFN8s2Q0PQJzmF4z6C9Sa85uRw2ntWtVVoSydXW1h5N
 Hxc7d4MzQy0/08jX0FTFs/tZ+w+nkVxZtUwObSIVP7j6SbB1p81lJuZG536g/6npCLAQWXLGp+h
 dfl0A5S4rTS/Qb25u8+bs2y/+2zw3+N7ZTfD9a3ulimR86mZmnPVFlMmRYmiudASiYp/P03KNc4
 IJH3pk6N46mzWopaAsHHbdqvQGv
X-Google-Smtp-Source: AGHT+IFGt6qD8FaOKomADZuI+17XcGIUnTDPQ664drQKA6SaA5pNoKRjmHj16RlJLtLa37KFBRoJqd41MhcCaqPBq/8=
X-Received: by 2002:a17:903:2f88:b0:246:b35a:c655 with SMTP id
 d9443c01a7336-246b35aca38mr62355095ad.8.1756214923136; Tue, 26 Aug 2025
 06:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250826094142.1750970-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250826094142.1750970-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 09:28:31 -0400
X-Gm-Features: Ac12FXyWgJplV_n7PnxDTEzyRc56Rm9Sl12jEU6h1sAfED1CPZRfnsjw3TyfV1k
Message-ID: <CADnq5_PkzsHu0P9sbh1hT+RkL3JS7K9UhhkCQuu6012qjXy+Ng@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: update firmware version checks for user queue
 support
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Tue, Aug 26, 2025 at 5:41=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> The minimum firmware versions required for user queue functionality
> have been increased to address an issue where the queue privilege
> state was lost during queue connect operations.
>
> The problem occurred because the privilege state was being restored
> to its initial value at the beginning of the function, overwriting
> the state that was properly set during the queue connect case.
>
> This commit updates the minimum version requirements:
> - ME firmware from 2390 to 2420
> - PFP firmware from 2530 to 2580
> - MEC firmware from 2600 to 2650
> - MES firmware remains at 120
>
> These updated firmware versions contain the necessary fixes to
> properly maintain queue privilege state throughout connect operations.
>
> Fixes: d84f90e2bcec ("drm/amdgpu: Add fw minimum version check for usermo=
de queue")
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 456ba758fa94..c85de8c8f6f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1612,9 +1612,9 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         case IP_VERSION(11, 0, 2):
>         case IP_VERSION(11, 0, 3):
>                 if (!adev->gfx.disable_uq &&
> -                   adev->gfx.me_fw_version  >=3D 2390 &&
> -                   adev->gfx.pfp_fw_version >=3D 2530 &&
> -                   adev->gfx.mec_fw_version >=3D 2600 &&
> +                   adev->gfx.me_fw_version  >=3D 2420 &&
> +                   adev->gfx.pfp_fw_version >=3D 2580 &&
> +                   adev->gfx.mec_fw_version >=3D 2650 &&
>                     adev->mes.fw_version[0] >=3D 120) {
>                         adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_me=
s_funcs;
>                         adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &user=
q_mes_funcs;
> --
> 2.49.0
>
