Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E133E9E311
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 14:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1397810E61C;
	Wed, 11 Feb 2026 14:18:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hrHsy6JG";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 474EF10E5FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 14:18:10 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-124b07e5fe4so533892c88.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 06:18:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770819489; cv=none;
 d=google.com; s=arc-20240605;
 b=e3OcctM+tDZkz4mPyLiYvyE6U9imBGrSOXI/Q6QuUGUT5LYTiWU81s1dUGFsm38Z4M
 NMoQKZQ/h50PPr3Fp8sjpFmVsc4/JmN3ZYIjjapX3NM18OLhCHTLtERPLm/mbBkqUXYX
 EQhM7aAdO37tVxXXL+mjzX66GCfmzCOHi3mhT9JUKyakK5hgpBLMT6QbLOpO+B1uWeY0
 xH47DeGqdKosTj33Lttat6O0wLduMpxwcjRq0kUiZS3JiieEl3HeTpoEp1yl8f11dYAn
 Fe2D9Tz03C81YoAQSV7yPpuFsjQNZVtooNhDJpi6dJs2QI87KRKc9xEQK184svkcjFMw
 iIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=goBWqa/XBAUCU/USU+7vOgmq/PVsWb+UivWg7c+q+G4=;
 fh=kP4WtfpaYcPfg9D2ckp31Oj2ioAgBoIFusaUjo7vWmU=;
 b=QE6tgMWT38U3tusO229MLqqHbAswFaIFu+h/Ld7WX4bhyyJIC5d9XZNxo7QN/tgG0Q
 XdUACSV8cNcbfIum2PncqoYMktJguCZXkCeStkZV4ylwjx/Si9SweJYPFVnrCC6ozPIU
 iqhgpxPy2dPVpkMPChiw0J2yrNPF/fkEevbwcF0UEzmwYASWqFKEcQpGdhwTAkEVicrX
 kUyxXlLknzGy9fUiVciIx32ilPU7COrvZbUnm93GI+4AX/Hpj/j9/Rse/EiJIynvlwjm
 UYXB6L7bfyUi5B0JuQ4bbGFztAiZhGmwKpLVFwqePUJRfFAF9QcadGkMLwvpmPGXQbEN
 6AXw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770819489; x=1771424289; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=goBWqa/XBAUCU/USU+7vOgmq/PVsWb+UivWg7c+q+G4=;
 b=hrHsy6JG9sD4opKHYeBuVzFRfpYvjneZeYNSUTbwTrZPCCuKha2yB2/JDlkJsibr0T
 DhcJoXlCiNc5xpzUSFr8Ru7I+ezkW39scB/34NPAqEh+S/1dOE3O5/koyVgxv3nYd23m
 vDirWj947IIqJurB/VAxsrMvjEhjSYs7pvG87oNC7sSQFh497v559AWiYlIiaueKZHUx
 0fw31+QUrSerBMUpUaSMItJI7fEyVqhkMyPgjZppeiYGSyTMIdiAk8B7wSpKopdsUZgD
 Cl0QKlIJlryVBlkrvrRhodH2Y49mcZPTM4tx57T9seQYkcbKTwGu7OHnEt9bXWghNxMN
 ld/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770819489; x=1771424289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=goBWqa/XBAUCU/USU+7vOgmq/PVsWb+UivWg7c+q+G4=;
 b=WBKp8+rSWHdNQFFSdHnyeHaQx3yZ03738uzZRampQDD37yXds2C96X2A91m1b5KT2+
 uF67EWi5n2zPZy7gT6p2426MObWuoHvHuqdT3fxRaRmaO0HJZdGjfRjlh/V1AUfSlNMA
 Hj79KlLvX0cTJhCdcdqeTb0q6/bb/fqWnHY1UfuabLWet8LQjcZSi9EdAhY9rM/VgUiT
 wjPgHJ3RvSvhA18B7YYichXbGZOebzbgGLOb/Zm89fIPiIuZu0lbUasF+er7Ri3yU/kz
 RJvJQ4HV5RczpZlzmhXpduj5VVh7oqlU8oELywbWryloqNkFThlKyED1mf1fJDMrqZHV
 iWRA==
X-Gm-Message-State: AOJu0YyZ9Vp3V4cc0lesG9snxNNxI2WnpRBkwBrNDEbwtgr6d1MA1HkS
 Xij9k5OCNQI1eeIxfOumarCirjHdxw0IWHD3HeaQAtvPciSk7g/vuwm/44Qtd6cm3BpLOKSFPp2
 KfxUS140RVaCpocp3yXDhw2gT2ABKG4M=
X-Gm-Gg: AZuq6aJlJIRqdg32N4hpHHsUDojCPvFlYnwGHk/2nqBbQpyEj1TooeNFdEB3kJ2p/Fw
 9Nk2TEoVbI761Zw4wqXwl0o1GS2a2OQXnxko8SEysCgvNJVtvmDQqkPEgAUE46s4qWhLMlz22Y5
 tHj5l7LVcn3t50S99PdWecMfhcja0rxJjduDSQx36I2B51UOdji6w8v2A0GjaoUxInhbZzkkM+j
 R7VTiinIwQyKKhvAt3JLGi+0osc8Sd/W50ycgnGazwMKJQ25KrYRXHGDeG6a1Li1SYsnwlc+iWb
 MwxrNM6D30yZrt5SW8Y=
X-Received: by 2002:a05:7022:ec11:b0:123:308f:667b with SMTP id
 a92af1059eb24-1272a7728cdmr416122c88.2.1770819489253; Wed, 11 Feb 2026
 06:18:09 -0800 (PST)
MIME-Version: 1.0
References: <20260210072309.14911-1-decce6@proton.me>
In-Reply-To: <20260210072309.14911-1-decce6@proton.me>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Feb 2026 09:17:57 -0500
X-Gm-Features: AZwV_QiPLTEeETb9o-odEKXS3UkM5PUZZ_yDmvKK0LDZ2SxwLbh-oK6gcsMssh0
Message-ID: <CADnq5_MRvfNk83C6fd_gFTN8Sv8hgi56vJgEENajxpmQo3xd9Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add HAINAN clock adjustment
To: decce6 <decce6@proton.me>
Cc: amd-gfx@lists.freedesktop.org, Kenneth Feng <kenneth.feng@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Lijo Lazar <lijo.lazar@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>, 
 "chr[]" <chris@rudorff.com>, Sunil Khatri <sunil.khatri@amd.com>, 
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

Applied both patches.  Thanks!

Alex

On Tue, Feb 10, 2026 at 3:20=E2=80=AFAM decce6 <decce6@proton.me> wrote:
>
> This patch limits the clock speeds of the AMD Radeon R5 M420 GPU from
> 850/1000MHz (core/memory) to 800/950 MHz, making it work stably. This
> patch is for amdgpu.
>
> Signed-off-by: decce6 <decce6@proton.me>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/si_dpm.c
> index 1f539cc65f41..b5d895537477 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -3468,6 +3468,11 @@ static void si_apply_state_adjust_rules(struct amd=
gpu_device *adev,
>                         max_sclk =3D 60000;
>                         max_mclk =3D 80000;
>                 }
> +               if ((adev->pdev->device =3D=3D 0x666f) &&
> +                   (adev->pdev->revision =3D=3D 0x00)) {
> +                       max_sclk =3D 80000;
> +                       max_mclk =3D 95000;
> +               }
>         } else if (adev->asic_type =3D=3D CHIP_OLAND) {
>                 if ((adev->pdev->revision =3D=3D 0xC7) ||
>                     (adev->pdev->revision =3D=3D 0x80) ||
> --
> 2.43.0
>
>
