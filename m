Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEF3EA7940
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 19:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5599510E75E;
	Wed,  4 Feb 2026 19:23:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DR8wV5In";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B94F10E75E
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 19:23:42 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-124abf957dcso13862c88.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Feb 2026 11:23:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770233021; cv=none;
 d=google.com; s=arc-20240605;
 b=ghvNmJj0BIDbZdK38AlOK3a3v6dOF8LdZYBlv/EqIyHf7iwTUWVLIXv/Utjk9FDWgI
 wQma32ZClrZP7MFOICDowTh1JylMVL+8hPiWt0MxLh+FdrEJdvx9P6mt6ExFmbEo4j3h
 BJn9hOsfQ6O10pes+i7OT09A/qTJnS232bs/erP+DMLnMQ10v1SdyHmnvtw+CgwEypS4
 ZR0iGY5UkFIXuEjutMu6aA9lcKaaDsghXIwAH8wZ5oocRjyALhCPGcLcjeClU9eV3Ml8
 us3GGnFQJnnkLYrXw1h9fqSklMAIuvxiCzV/NxdZGcEMoU0c2j7soMK1ETGteipIxRZY
 C5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uTHz/yhFwrtNxMR4y4sHCAMTA6CxLp3ndRJnFf/zKuE=;
 fh=vzonUuaMWZKvBG0gDe60k0xEVcmHv6XNXdJRIQzgbjU=;
 b=l0y1xJ+oWYciyiacZgvKjEyhq4PdxdmWcn7nLIdyLhrm1RhW857wboBXWSMnREMjPK
 2422UiCVfbn7XZdp/rqOJmribU42xuwcQ4fAvQyEBIF6iZFqF3IKHEQc7v1LoBxMntUD
 LQshwWtmUoaiHtgt1asVsOm+bwUqYBYXD6mPNdx0o4meUkGBn8wCEqp6iuZm+mAo6U66
 JoT4GaM2JlPCaBRfbCv5yJ402E19KhM9vezOf/bp4CdeIjXOdEZHG5p/drDTyT+tNNYj
 XVRdknkFDX2vAj3I6/eFbiHlV+hbWOwmhU2WTHZQjYnxn9v4/432W8pjRaKrK+znI2CG
 P6Bw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770233021; x=1770837821; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uTHz/yhFwrtNxMR4y4sHCAMTA6CxLp3ndRJnFf/zKuE=;
 b=DR8wV5In49/okBVMiSQyeh7rMC6QwFgJWGL0TOPxbTlFJIfZYU6JY3NfDOpNwuBruA
 0X295QMyrifrB5Rq/GUhpZxuV4R08QhBGi6MznUVQHwuN2J3DJ8juMK7xnkBF4VjOm6O
 Nq0EEBNSPZbIgJMuHHXxMHsOHOsKDHIwtn2r160Ntvajl3Lslp+y3meuQrP7Flbx8DTq
 jujUBsDCO+xqwzo9UTHvyUAtzXbjI9VFd2v5Nu5SzuxxtFyg9yRvLvYPuT8A3HQqOeHJ
 kim4JUpqC0OcRnE0g7yU7GZ4M+JXcN6YUSoaAiCKU84xHKZQvzvFwl0qzpESaKlglFM6
 fKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770233021; x=1770837821;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uTHz/yhFwrtNxMR4y4sHCAMTA6CxLp3ndRJnFf/zKuE=;
 b=ROGwVBTfXoYz3kdV5CDArglYpF5G32Vx/QJ53cm/DVRFxavSUBo/1xusmf58IYmIom
 p+6W9dNxaBGF781ppazrx9r/wDKwx5DQhpdnSPP2ECeYfhaxM46lVq+97EiLpRK2rRuM
 UQ1kwSSf2zHyPitFfM07qCIPsbtN8hdZqXPzM+4rsWjgEEDv+eaqrUupQO295j5fDN32
 7ysjf7A0Oc996/5r/qDzMe9NqV8bMYhkTgY1N588i7m57XSGWvOk06dm5cPsVHfNwOz8
 TMrTO1RuWC4n9k6OzoXtIdm+CLyCCey5w8qZ4/EbKmds7mjJGAXVPnzNVZ5TuLOu+Boe
 V6PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsoUwp0bXD2RFszief3MZzFN4cePmK4+R2pYv8+834wnhEAII2IPHHZ1ghNs0XCegEKEHJN5HY@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDHIo/Ui1mQuSgbkRlB7x+QDyJIz5TftPrYS3km7LfYhBw21YR
 2ufflL+zQddHfFlIawrEGf5yJ7orbsQga8uWLybdrZUXq4JCkihXgA0BIkfTyB8ZNjXCYvDdK33
 f3kWuyg14h4LgXvxGUD4WzbCKXFCdoMG9Uq4N
X-Gm-Gg: AZuq6aK/BtGK9KxUIKA2OsPxfafSZQAp5itu8fkDbSDtpJELKdgsMqaUDlMDvxHhi5f
 0oaJ67TJMMGbr9+rtNZmDIAzCp0rKJLNx0ZwxyZl4do+dPKon9CvErX96D1BlUtG+P+tmwr8vIY
 H1J819lUSZ26xqNW2nS+qgTDllCltWBY1/+TOpAT6+MHFEzWKW2AwXGdRG9x85LPMXZIor6HPGT
 llEeyEtMrnbD7VQHYXjYh3iqI0iRIinWu+ir+ze/a97NJPrvgji8R6g6jz1JUa97GscJEJ3pXHv
 N9jvXus=
X-Received: by 2002:a05:7023:b15:b0:11e:3e9:3ea5 with SMTP id
 a92af1059eb24-126f48d50d9mr845584c88.7.1770233021299; Wed, 04 Feb 2026
 11:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
 <20260204044338.96093-10-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20260204044338.96093-10-Pratik.Vishwakarma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Feb 2026 14:23:29 -0500
X-Gm-Features: AZwV_Qj7x1xsQdfjxwfZIgvKS4syeEXC-2qeSxq2UTZup8_ldEz5vQJlguT_o9I
Message-ID: <CADnq5_NbGxrV7GFt=i=gEDBFd8mQAJNkdbRayvy5wNpE2fvbWQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] drm/amd: Add CG/PG flags for GC 11.5.4
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Tue, Feb 3, 2026 at 11:52=E2=80=AFPM Pratik Vishwakarma
<Pratik.Vishwakarma@amd.com> wrote:
>
> Enable GFXOff for GC 11.5.4
>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/soc21.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amd=
gpu/soc21.c
> index 79d132fc8ca9..8122a5cacf07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -839,9 +839,28 @@ static int soc21_common_early_init(struct amdgpu_ip_=
block *ip_block)
>                 break;
>         case IP_VERSION(11, 5, 4):
>                 adev->cg_flags =3D AMD_CG_SUPPORT_VCN_MGCG |
> -                       AMD_CG_SUPPORT_JPEG_MGCG;
> +                       AMD_CG_SUPPORT_JPEG_MGCG |
> +                       AMD_CG_SUPPORT_GFX_CGCG |
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_FGCG |
> +                       AMD_CG_SUPPORT_REPEATER_FGCG |
> +                       AMD_CG_SUPPORT_GFX_PERF_CLK |
> +                       AMD_CG_SUPPORT_GFX_3D_CGCG |
> +                       AMD_CG_SUPPORT_GFX_3D_CGLS |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_MC_LS |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_HDP_DS |
> +                       AMD_CG_SUPPORT_HDP_SD |
> +                       AMD_CG_SUPPORT_ATHUB_MGCG |
> +                       AMD_CG_SUPPORT_ATHUB_LS |
> +                       AMD_CG_SUPPORT_IH_CG |
> +                       AMD_CG_SUPPORT_BIF_MGCG |
> +                       AMD_CG_SUPPORT_BIF_LS;
>                 adev->pg_flags =3D AMD_PG_SUPPORT_VCN |
> -                       AMD_PG_SUPPORT_JPEG;
> +                       AMD_PG_SUPPORT_JPEG |
> +                       AMD_PG_SUPPORT_GFX_PG;
>                 adev->external_rev_id =3D adev->rev_id + 0x1;
>                 break;
>         default:
> --
> 2.43.0
>
