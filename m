Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AC1C44501
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 13:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C48D510E37B;
	Thu, 16 Jul 2026 13:31:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VfljxeEM";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B376810F316
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 13:31:48 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-381f03d7be0so917808a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 06:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784208708; cv=none;
 d=google.com; s=arc-20260327;
 b=kslgY6SLNJ1XlO+mkbn31B9JjC0wOUJLI+ZjgiHv19kugoqK7qSdM8Z9WvMSutK7k8
 FELu9dHZkllQ5X56JWIrOU3LmFY8C4UXwn9ceIpoykXcumBmqfLKlXruaxOB3eGkJM98
 5/ZlxYfSqrYLhwat180guwGY3IUt4L3j0MexoNLAdwobGV5hByymqQz7VMAht+gSY2fa
 +gbc3FKWXEpV8Rxt81I34R2aBBosF+IgQKW9qQHsqli5BMb4MjiKypgeCJk7R/I2Ck+T
 repHI4T324t5d7YqzBN8bS9Qo4U1ItudG+cEijnVVGjrqi1OHeKPXSxCT1EwdMcchU0O
 vhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L9EPVrSfRLnUJCuiMGZiYyO4X0gEsxu1t+W0Qw5ky7o=;
 fh=vS9Iu/jsqATHvgcAj6lBYaTuuZWz+Qfe5KBsPjOkcPU=;
 b=jC9BdM8lfkwnbLspeW7iYxYvEaPVKnq0vSAcvtThJBpFsa/+XjbDkDgiTYOTTmdLQp
 qxzkS+7p4lzqC5LefudF1LLHpO94Ulnu4NhY5RKzaSjrTJfXLBY8dccHzCjY6CdJD1h2
 KyvCE9qySlsXvmW6eqDH5bKAm6DNIdpdJXYymrh4MAnDhLrOZbRdenHAFJmf1PnnGIG3
 hXP8Nl6s8Sc8LXHhJyKVSF2KOLiwGg8S4cV+Wt9d0BWxQiWxQaEaHSD+GdCCfnia+Pcq
 bzPAAph0Z6+KdlzT/zpc4QBmp8d7YQkaz3qqfVOoPj02foZVAN0WsFJupj3Z5wXx06Bd
 LNKA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784208708; x=1784813508; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L9EPVrSfRLnUJCuiMGZiYyO4X0gEsxu1t+W0Qw5ky7o=;
 b=VfljxeEMRE68lcQDSUA7fgqnLvIuB5HZiJrPcx7cOm8do6phBBUalMTwOcslAuItK2
 mOYueflO1h/nZdtw5l390BkT+ij/5T35vgar2ij7V9yvC0yu2EHw9jXp8TX9eWZzcLzn
 04L6724MDpQ5/a1E7HIFsyqPznDCH9uLGPVbm1xGV/h9u+GnUrsGC//s4S8pOUAx4uyN
 GkqfrvNZ5hai81z3CbCp80hsfWU9lFvYPk3p5K+tFnGT4pNhXBeb156W80PJrGhYQ+FV
 Fkvj9zIcYFOp8fzfPP5kGl81VV3haUhtwkGs+hhMuGrpbIUkdmJ7Ej2KvWWbXFGNB80L
 lYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784208708; x=1784813508;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L9EPVrSfRLnUJCuiMGZiYyO4X0gEsxu1t+W0Qw5ky7o=;
 b=M7j22XHhX8XCDCRdPmtnp+gja+Kt+N/luSjytdmzOIr97h5NtR2hZcDT/lfEtAlA30
 Yf7irIkxp7qD+bEL2e3CZd/7pdZX/66uSgNPp/D8AgJmeG/420i83pZ1pD/WlRIvlwdl
 qlWmeNQYwIiqVZx+lOMmLLGj5ngfDbm2FPNKZonThuLUpYzX3fZ0nYYVyssUq4czEPpR
 njSj7jeZarOiC2BF7agcXOVCMkLNpw0LUpURJGwXLSrokV3qqvwZEYsTs5eEikCqlCdM
 RJ4ljQ3InOA2C1YaFEP5cAl+QCx0Extidq5YQBQDExzy0wHDSey8644m6OkdrMaOqtAd
 W43g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqlV3EHEi5O2c0WUJ5OL5mLJQjcvS/T7ufqh515U15v1ZIQ5oopPbu6UW151nd5Vc/bbShKo7MY@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwhtKav0IJ4IzPJJpOdXulP9VBS8cWuh5IIWYct4YSZk2IeWm0Z
 1jCKE9qYDK02Q4qBU2us+du5Q3iaS0QtwhLas8bJjWipr8Fy9r9ul32GUp3Qr7LcXRY5UA5+3uQ
 4YItabaVBw1DqpepsvvFSxAW9gsPwT0g=
X-Gm-Gg: AfdE7ckJIRlSAbU/4nYNqPC22vh+yT85FNFjyEomz3EIXEEsmooG60qSXfTYg6JcZhW
 wbskADWMa+Q60uvWC/dlUC6Ds4gmOTw8kDZVhGz+iLDC/iq5G89yIxjrfjadDeLo4EOXV/C5R7W
 44vxtL+qa5VYvr3KnvfUbDf1P68AAQrmO7aXGY3cq2syXzGlgbPQN9ykOnJ6lQi9cQPN0HQI3N+
 7UVgB/bNA/ZZVByKnCqvFPXvMoRt1vSNm1o6pHeCtEb+n45VEr7GiDyV7FQgAHh3mFhHrZt6KX3
 Hhfs0nM2odST58YDrjF6b52Cc+hlL1wFL0n771B+LcsMi7WP
X-Received: by 2002:a17:90b:564c:b0:37f:eda5:516f with SMTP id
 98e67ed59e1d1-38dc760604fmr16112285a91.0.1784208707925; Thu, 16 Jul 2026
 06:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260716123646.1933293-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260716123646.1933293-2-u.kleine-koenig@baylibre.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jul 2026 09:31:35 -0400
X-Gm-Features: AUfX_mw91-WulFiTIn96-pWiC0oRVioqeCJ6cIWsVesGEKRmY4KxYzLzHLTYcMw
Message-ID: <CADnq5_Ov7t1LQh908G69vRRGkB+mHAMaKss3_zdAYno3ALKB3w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Only define radeon_acpi_vfct_match when
 actually used
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Thu, Jul 16, 2026 at 9:04=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> This fixes the build failure
>
> drivers/gpu/drm/radeon/radeon_bios.c:614:12: error: =E2=80=98radeon_acpi_=
vfct_match=E2=80=99 defined but not used [-Werror=3Dunused-function]
>   614 | static int radeon_acpi_vfct_match(struct radeon_device *rdev,
>       |            ^~~~~~~~~~~~~~~~~~~~~~
>
> for builds with CONFIG_ACPI unset.
>
> Fixes: 33a18ecd2fbf ("drm/radeon: Fix VFCT bus number matching with soft =
filter")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>
> 33a18ecd2fbf is currently in next via
>
>         https://gitlab.freedesktop.org/agd5f/linux.git drm-next
>
> .
>
> Best regards
> Uwe
>
>  drivers/gpu/drm/radeon/radeon_bios.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeo=
n/radeon_bios.c
> index cc10880af096..cd7a5d458157 100644
> --- a/drivers/gpu/drm/radeon/radeon_bios.c
> +++ b/drivers/gpu/drm/radeon/radeon_bios.c
> @@ -596,6 +596,7 @@ static bool radeon_read_disabled_bios(struct radeon_d=
evice *rdev)
>                 return legacy_read_disabled_bios(rdev);
>  }
>
> +#ifdef CONFIG_ACPI
>  /**
>   * radeon_acpi_vfct_match() - Check if a VFCT entry matches the device
>   * @rdev: Radeon device
> @@ -635,7 +636,6 @@ static int radeon_acpi_vfct_match(struct radeon_devic=
e *rdev,
>         return 0;
>  }
>
> -#ifdef CONFIG_ACPI
>  static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
>  {
>         struct acpi_table_header *hdr;
>
> base-commit: 33a18ecd2fbf6bcbf803836e94eb31c26f4c7f41
> --
> 2.55.0.11.g153666a7d9bb
>
