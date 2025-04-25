Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BA8C369D7
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 16:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C6A810E99A;
	Fri, 25 Apr 2025 16:03:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q/245fls";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C96A10E97A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 16:03:18 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-b1a04f13ad9so78730a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 09:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745596997; x=1746201797; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xV9nqFLeoodBHxsojviZbiTh6w1ctRI5NC/yJCxXZFE=;
 b=Q/245fls8H3/iw2otNYRUGQq2CncgNww4ft4Zrztdxo0a61fY8qGA3Pjt8Aeubnf/4
 TrnJKkQFs4j6D9dn5/P2iQLwnduoCDtStBQWg781PS81JTPyzEDrXs9cHpZJNB2KbIvX
 D0yXrHZooLUdYPSKGlUdHoPGsEeX1DHY+6P0dFlCPu7vpyhEJNJefFeqyF3v2frX8msE
 nmcdKbaAvfEdGAaRt3uciW3lqw15z2evDEGzYZjT89UdGO18Z9J7zKmmI1A6ieJtp/qS
 HNYqbsRzOkzvCRVK/yU4TvDO0ld2/K17zFoemtzuBRHoEhk3fyPLSq/Sm6riy9zPshs9
 ROsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745596997; x=1746201797;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xV9nqFLeoodBHxsojviZbiTh6w1ctRI5NC/yJCxXZFE=;
 b=InzY2G0a+a9RxMb1KxMFxN/FUk7G2SbTh4MfCL9994odynYdgFc+ltGffGayKTSCCO
 eONfrQ/egqNV97CjFI9BOg+lTyucGAAxNKVsNhIJn91rDgX4Q/Ka6wxNOh7wcmi8M8Hs
 +UH/DNR8dOVHKvEYZOheaOmMU2aALQoeS/133M4HvhiNZhV30coCSYSptCiz7DDZ+gyy
 n5k2N2XaBBJOlGOaqr87RzBPqif1Pgtvxrs4uawFJKEgI1Ecre3r8LVi/cVaoN2sIrLP
 ZCZ7pBBO4xMbUkLU7w3eZAeni3zfaVYz2CAeWXo+qFZObn1jYRnxIidFWb0Y9ROAiA65
 XLdw==
X-Gm-Message-State: AOJu0YymVXQnilTYcTUJr4FJqQ5QeznTEivr2buBVqWEB+Rd8oFmlTe5
 A1ojkGWDFZtkZ4l3YIdJ15WlNW0BSGYRc2B3/pPqd88cnXKSj+9Hz8LyLwKOgwpKut10gu7KOIZ
 xrppfzH3sWd4dKFxNxw5YAFzDPhKyWQ==
X-Gm-Gg: ASbGnctH5skUpmK/zKQedO3Hc+ty2CqVp7BIh78eFwjW7AKsfe8ZXEZT35PJamS+tlE
 b1SNPslVJdQ5nnT/89AZCLW3CeeOdj6LnD5GtOY2L+6Cepre79oX+Q73TSfpJ2WcbaCA0moU4kj
 elJu850d+eOJMG3wqKiwfUVxdSaht9tf4R
X-Google-Smtp-Source: AGHT+IEx1B8CpeLBr5veeZF2Rs8/QdTPIyJXDoI+SzmdAmbdq7b/ORtvs6chycLALxATReeUCZawhqHkOywLvsX3Vqo=
X-Received: by 2002:a17:90b:3504:b0:308:2a7b:547b with SMTP id
 98e67ed59e1d1-309f7d9ff09mr1714933a91.1.1745596997262; Fri, 25 Apr 2025
 09:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250425150748.1338-3-nipetrov@amd.com>
In-Reply-To: <20250425150748.1338-3-nipetrov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 25 Apr 2025 12:03:05 -0400
X-Gm-Features: ATxdqUFLqW7oreBW8EMmpj7COVYqLAyBduYAxSK2rTIiZUQ39v58TDy8kyWwfTg
Message-ID: <CADnq5_P8Sd3fOg3wSTikv1vacY8D__a4azYzRsVU-pMuXjPbnw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix GPU reset handling after WGR is
 triggered
To: Nikola Petrovic <nipetrov@amd.com>
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

On Fri, Apr 25, 2025 at 11:58=E2=80=AFAM Nikola Petrovic <nipetrov@amd.com>=
 wrote:
>
> I've identified a critical issue with the existing GPU reset mechanism th=
at causes a BSOD on the Windows Hyper-V platform. The current function:
>
> static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>
> incorrectly sets the AMDGPU_HOST_FLR flag if any engine is hanging. This =
approach wrongly assumes that the Host PF is always responsible for trigger=
ing FLR. However, a VF (VM-guest) can also cause a GPU hang, which results =
in an unsuccessful VM reset. This ultimately causes a FULL_ACCESS_TIMEOUT o=
n the host side, leading to six attempts to retrigger a Whole Guest Reset (=
WGR), which results in a BSOD after five to six failed restarts.
>
> Additionally, the current sequence sends a READY_TO_RESTART event and the=
n requests FULL_ACCESS, which seems incorrect to me.
>
> My fix addresses this problem by using REQ_GPU_RESET to initiate the nece=
ssary restart while appropriately handling the FULL ACCESS request. My impl=
ementation has successfully passed 100 loop tests, confirming its effective=
ness.
>
> Signed-off-by: Nikola Petrovic <nipetrov@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 7f354cd532dc..a2a436707200 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5314,11 +5314,12 @@ static int amdgpu_device_reset_sriov(struct amdgp=
u_device *adev,
>         struct amdgpu_hive_info *hive =3D NULL;
>
>         if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags)) {
> +               r =3D amdgpu_virt_wait_reset(adev);
> +               if (r)
> +                       return r;
>                 if (!amdgpu_ras_get_fed_status(adev))
> -                       amdgpu_virt_ready_to_reset(adev);
> -               amdgpu_virt_wait_reset(adev);
> +                       amdgpu_virt_reset_gpu(adev);
>                 clear_bit(AMDGPU_HOST_FLR, &reset_context->flags);
> -               r =3D amdgpu_virt_request_full_gpu(adev, true);
>         } else {
>                 r =3D amdgpu_virt_reset_gpu(adev);
>         }
> --
> 2.43.0
>
