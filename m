Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA22C28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 19:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B909310E106;
	Fri, 28 Mar 2025 19:04:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OxZsQyth";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97A3810E106
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 19:04:44 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-224104a9230so6137215ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 12:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743188684; x=1743793484; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KyFQKqys6ZpRKhAbWJgbRlS0/CFlF+NBYOVPN6mtFtE=;
 b=OxZsQythbuXWSsld82pyl1wOvf2KtsSS0d9xzWZ5FAgddliqHDVyNTcI5cKv4FyAJB
 PI639w5x1ZaU2qnAUKvDMndyaEqnA/CC8J7Rptdai4g7upecPqUsuP3ZqnFxn3ccd9zF
 YOc43BEnIGi1SknkANrb9tdnUB3m4rMtzdw9HDkHok0SyqKzWlpqbvOccD52xojIogjk
 YMHDz7t2xFxc1EBSkiYWsAf7xx+R6t4dve7WVLp1HrSFjUwc3m+hVbwSLMdOQD+Kw0Yx
 +HpcTPsFZ4recu0+OzE3qKCDxgEMMvrYP0UcKSgbiQUJKsebTURus5P56xbg7CSxQptr
 /AXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743188684; x=1743793484;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KyFQKqys6ZpRKhAbWJgbRlS0/CFlF+NBYOVPN6mtFtE=;
 b=hIsOG+o6Y3mrFPfiSi91jYJu6EEYh5IeLRoZyHGpBYK7HpeCg/vGU1WSJ8Wbmb5rYe
 CQ8k/vrNd3Qb0FFh213G9cj1WZcXi3lcLUMSEl1njLr6Ux6mG9jbC47/wafCOCIh4qyG
 TRLwfnGDTPrEGpPjEKJfoluywN5nttZjks1OPdwDuRYUGPqeg3qCeCWMEOGlsKeSbTim
 Yy/zecukBDf/fFylQj36VatjXr4TWG7GK23xBuu7PefR8VIDwQSRfGIH8MoqdYlnqHDV
 iwG6an/SALKho0lTFzrFlPPwQqvImd4smuohbuBAs6l36aCP/O2z8ifCVZRRqd37gtpF
 tt6w==
X-Gm-Message-State: AOJu0YzFO/sTFg0KDcuTxWXCmS4EDHDzHgqmXQkKBw5vHuGCMm3NdOjD
 NtJEQmSoONUe77vvLS2sdRS05GShHYzB96tmR3hvT2TSI/V+AkayY1G9hxJWBouVUumyhB9iZRx
 0K+3pEkwhXjnL40hzguXqw/cpaCh5Bg==
X-Gm-Gg: ASbGncuHjX3sEKqH05vgvKKnkB3j04QdJ9ECsKsGtcMPCSGq6KA5Ah8SijsJowxWP1O
 5QCU6S09jt6WYERXxqTb0i3gUeoeDHsZuFWgvYzCTXUXWptAjPoc4HMhvSzHz8ehbwBlmuaqqr1
 Umrj6esv/rHGKNrpUtjOtt4tqSAA==
X-Google-Smtp-Source: AGHT+IHx6rHSRxVMK62gVuINuRb5Upz2JsIufIECQ1wopPtoCA0l9StOlYccKzait0lG9F7ajhOgT0e1JDRbRgsn5f0=
X-Received: by 2002:a17:902:e946:b0:224:1579:b347 with SMTP id
 d9443c01a7336-2292f975354mr1479585ad.7.1743188683865; Fri, 28 Mar 2025
 12:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250327203858.3796086-1-superm1@kernel.org>
 <20250327203858.3796086-4-superm1@kernel.org>
In-Reply-To: <20250327203858.3796086-4-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Mar 2025 15:04:32 -0400
X-Gm-Features: AQ5f1JqbsJU-nGc8lJbLT_zadqtkW38iD-qwhkB7Hf7QE-0NnPkOigc0qFS9_pg
Message-ID: <CADnq5_PHok-aAjsYr0P-xbWowBU-0yRxgFGrkyxmcd_ZE2k1OA@mail.gmail.com>
Subject: Re: [PATCH 03/14] drm/amd: Convert dev_err_once() messages to
 drm_err_once()
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
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

On Thu, Mar 27, 2025 at 4:48=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> The errors for power consumption in amdgpu_acpi_is_s0ix_active() are
> under device scope. As they're drm errors, adjust to drm scope.

Is there an advantage to drm vs dev scope?  I guess just consistency
with core drm messages?  I presume the drm variants also print device
information so we can differentiate between multiple GPUs in a system?
 That was why we transitioned from the DRM to the dev variants in the
first place.

Alex

>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index 840901d65fed7..4372738bf2c9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1518,14 +1518,14 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_dev=
ice *adev)
>          * in that case.
>          */
>         if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
> -               dev_err_once(adev->dev,
> +               drm_err_once(adev_to_drm(adev),
>                               "Power consumption will be higher as BIOS h=
as not been configured for suspend-to-idle.\n"
>                               "To use suspend-to-idle change the sleep mo=
de in BIOS setup.\n");
>                 return false;
>         }
>
>  #if !IS_ENABLED(CONFIG_AMD_PMC)
> -       dev_err_once(adev->dev,
> +       drm_err_once(adev_to_drm(adev),
>                       "Power consumption will be higher as the kernel has=
 not been compiled with CONFIG_AMD_PMC.\n");
>         return false;
>  #else
> --
> 2.43.0
>
