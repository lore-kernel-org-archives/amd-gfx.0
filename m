Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9D5EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 18:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7336010E3AE;
	Wed,  5 Jul 2023 18:21:47 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FEB810E0A4
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 18:21:45 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1b06a46e1a9so6180962fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Jul 2023 11:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688581304; x=1691173304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r1Yw5UCW3Szvl/dtUnhF3H5AbPAGRRAbivBga2vAb30=;
 b=BhZuUErw6ub1kZlwSZDEzqWI6sU+gxO+eIVaDBPUiyZrag4QMrclfT1MxsEMFpypPp
 ynQP3JydHFax6I7N+T1aYd4dicZQiHk6XgDnQ+pTmb9DzlWAJRGa5X8wMmoIvUBQl5mS
 DLFqnYBQRDOM+IaqHWcv+y1dAqn7FEu83Taq0M1aVasYZGJtttdI4efjDRxD1VqaZKQp
 C5UIrzCHCrg/8hpA32OIjCjctyOKZ9NeUQQnU19k1A3g7NOz1saCz09wUul0/QKiBG6x
 LgNpPiJvR0NGXR6Sn37z5kpiepKbxjmexSAFD1iAqAdZXWk7sm+jwN2a4yDQGr1McC5I
 bkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688581304; x=1691173304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r1Yw5UCW3Szvl/dtUnhF3H5AbPAGRRAbivBga2vAb30=;
 b=D2Ta+R2ncJHMrDq29juOrtQtwJLKsvQNmOsgNMgnz8y7qi6LJy1CaR5RNgVq4IuSI0
 DH5bo6CLcf0R8dEWndGDNxflEfJuuyHmdx2+Qx26QEsz8oSqMVqiuAmb5/4vNDCLZA0a
 ufH4wiwBi77rLxYsapZnAkYMbEMb6xPFiNDCHoxgOkk3d3SVXSDcitC6aju2zVDydzh7
 TC90GBr4uy5aWiTmSaVwB1K1o/68vDXnCL7U2PZ5oUlnYBjIb8h+DhrQ4x1gCl/SP8EV
 /ibIZI8hlvppB2V6K39KHKY/2VQaUl3T2Lj84jFgDmlq3gVTLXuYw6R9pnIXTrbjTvxb
 lRcg==
X-Gm-Message-State: ABy/qLZbJu9FuF/QIsXTNx9k1AEdLb1fMrrhHIP2wEViVertBkyNR9E1
 +dZaHSsZpd4GNeKbSc3J4YgSUWpC934Ljnw9DL4=
X-Google-Smtp-Source: ACHHUZ7s48BCZAYSqbSoLw1KwJ0+NncdvTmsLFfY/WOtjLmj6XBb0ft7ijuYzR7hKGAgkwP9sQCaxljqFDX0RikYVuM=
X-Received: by 2002:a05:6871:4094:b0:1b0:4d44:8155 with SMTP id
 kz20-20020a056871409400b001b04d448155mr15954685oab.47.1688581304259; Wed, 05
 Jul 2023 11:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230705180633.21538-1-mario.limonciello@amd.com>
 <20230705180633.21538-2-mario.limonciello@amd.com>
In-Reply-To: <20230705180633.21538-2-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Jul 2023 14:21:32 -0400
Message-ID: <CADnq5_MuUmnamDdn3nXy7XNOw__bTNv=tigGx1AZsj5THMc=Ug@mail.gmail.com>
Subject: Re: [RFC 2/2] drm/amd: Extend ASPM disablement for Intel Sapphire
 rapids host + AMD dGPU
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: koba.ko@canonical.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 5, 2023 at 2:07=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Sapphire rapids is reported to have problems with Navi3x dGPUs where the
> screen freezes and the following message is in the logs:
> ```
> [CRTC:56:crtc-0] flip_done timed out
> ```
>
> These issues go away when ASPM has been disabled. Extend the disablement
> for Sapphire Rapids.
>
> Reported-by: Koba Ko <koba.ko@canonical.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2663
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index ef22a0a6065e..e9206993c743 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1476,6 +1476,11 @@ static bool amdgpu_device_aspm_support_quirk(void)
>          *   c08c079692da0 ("drm/amdgpu/nv: Apply ASPM quirk on Intel ADL=
 + AMD Navi")
>          */
>         case INTEL_FAM6_ALDERLAKE:
> +       /* Problems reported for Sapphire Rapids
> +        * Navi 3x:
> +        *   https://gitlab.freedesktop.org/drm/amd/-/issues/2663
> +        */
> +       case INTEL_FAM6_SAPPHIRERAPIDS_X:
>                 return false;
>         }
>  #endif
> --
> 2.34.1
>
