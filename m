Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EF4CFC28A
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Nov 2025 14:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C6B10E0C8;
	Fri, 21 Nov 2025 14:58:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GM6Pq4UG";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1D8910E0C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 14:58:57 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-7b8ba3c8ca1so355028b3a.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 06:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763737137; x=1764341937; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kpSpt3Ro96J7sFmz46aFkovdYwQiSU7TNX0g0jDRRe8=;
 b=GM6Pq4UGVH8FYRvykdzr7VlQkq8KVWrEW8RCXo3JM9Spgzf50Rs34BqjB0TFEwSW9Z
 qu5hOPIT2mhc/E/QFvtTy7crUejRahs6tBM42TBn7SIcgz/9T2lCjMtm3mU3+gjcxklH
 VSAD6UB3owWS93UzYFE4JkY2acilc9ZEKoeRaBLzQJWOkIqwcXodRAvifFtwOPyOiaRw
 ClzFHwVkTzuLVjmIju/bQwES4eB6SNh2QqfuI0mdPCQLjPiElBKyJMY5d0PTVEg0LPIW
 tm3qt5KLkpKiYi+gSXs7a4BqSugbStTlwd20Hj6KOS2qHJmueTSU/6BLrRSCnlk1SSuy
 fOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763737137; x=1764341937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kpSpt3Ro96J7sFmz46aFkovdYwQiSU7TNX0g0jDRRe8=;
 b=Uuh8pfO0ZQ62x1g4nF8HHGm7UOt9VfzxYIccaM40o8fE56mu1Oepl9QqKwyxqrOKsM
 0jySu6YsHg8Oc2e+Z7aMQvQUGbtIkUPF3sdYYpRz1dF5RB2NYUrvqGCkpXQFgKYbpB4u
 k+lsPMnrhU7+GlpibARkOMR6+xvHM8VZ+nDNhtKRrp0zGuuKwECGzF9hYT5Ed40UkePA
 8sKFdFYtLHpCRA8SsRNIKiilpIk5/+OJDB0B1VSRpiPdhwdIB1uY2xsQph0SsctYyrX/
 I2jmLoaOO2Zf5VvRqsrRNeTUwqf9Q6bSCTLFoFiU9aTM3AxCwx/kyvsxjeZl+cJH6ANU
 PfwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUStxtikEaZ+13F/2GX5XT6jS/Rzyjc3j6TTHp07h/AMDp1Fq36TO+/PM9npd9vlTig45cHX5Fx@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtajVlcKoYYIU/fS89Stygzzb/AslroMC+TCxEEah/k2k0cuur
 jm9Js2Ny1h3igQADg66eueUOTlRl/q/zBLkrqyOe4HYPtmw57MAEuAcgwowvCO5Nf0fgFXrXnnT
 ioMv4K1LrAzhbxNXg8ZMvroWgzmmDyqY=
X-Gm-Gg: ASbGncugOSYRL1kYXq2iwhHBlm31AtGxdYTjT7fTqy3A0qRuQEwG04vzHXD05mr8riO
 4xYuUW7TUWYjj2p5ne+/xWgPoaF7bYo+Muzl6ShRVcbvfEU93oC+E0T4zWG7vhw99ihpHQSCLNq
 XsrfxMJPYBa1frJE9uQdAoTGgAzYD0sQisXA0DOykNBT+v9S/OTZdSwzWZyifyv8NwVFeU5qcvA
 UQe0SiWHZVCEF0p0OhgBEoAancg1jv5tGLokWc7cQvnONoF4kNUJ4eXKFeNZvOWTip1v4SC2/go
 GPTNZg==
X-Google-Smtp-Source: AGHT+IHvSGZphzQR7fwb4wDWaJUIIEO3k3KYct8rJgGFLqUFCwr43waEHL2DC9NtAWqB1CrDXbcts5N27WyWXeUthM8=
X-Received: by 2002:a05:7022:6299:b0:11b:1c6d:98ed with SMTP id
 a92af1059eb24-11c9f31a210mr491363c88.2.1763737137318; Fri, 21 Nov 2025
 06:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20251121135658.459620-1-siqueira@igalia.com>
 <20251121135658.459620-3-siqueira@igalia.com>
In-Reply-To: <20251121135658.459620-3-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Nov 2025 09:58:46 -0500
X-Gm-Features: AWmQ_bnJgmT67BgbjpEu1KuKJN3caKXz3qCAKiqt0jpWDzuwsHr2e0Oga_vGg1I
Message-ID: <CADnq5_PSTgGym3gyGhTwNYn74q+88O4+nxz-k9u_3OAq2sLiDA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] Revert "drm/amd: fix gfx hang on renoir in IGT
 reload test"
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Mario Limonciello <superm1@kernel.org>,
 Robert Beckett <bob.beckett@collabora.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
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

Applied the series.  Thanks!

Alex

On Fri, Nov 21, 2025 at 8:57=E2=80=AFAM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> The original patch introduced additional latency during boot time
> because it triggers a driver reload to avoid a CP hang when the driver
> is reloaded multiple times. This has been addressed with a more generic
> solution that triggers the GPU reset only during the unload phase,
> avoiding extra latency during boot time. For this reason, this commit
> reverts the original change.
>
> This reverts commit 72a98763b473890e6605604bfcaf71fc212b4720.
>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amd=
gpu/soc15.c
> index 9785fada4fa7..42f5d9c0e3af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -853,10 +853,6 @@ static bool soc15_need_reset_on_init(struct amdgpu_d=
evice *adev)
>  {
>         u32 sol_reg;
>
> -       /* CP hangs in IGT reloading test on RN, reset to WA */
> -       if (adev->asic_type =3D=3D CHIP_RENOIR)
> -               return true;
> -
>         if (amdgpu_gmc_need_reset_on_init(adev))
>                 return true;
>         if (amdgpu_psp_tos_reload_needed(adev))
> --
> 2.51.0
>
