Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3272CD040D
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jan 2026 22:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F2710E049;
	Mon,  5 Jan 2026 22:40:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mJKSbS6s";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C9D10E049
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jan 2026 22:40:05 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-802e9abb429so67624b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Jan 2026 14:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767652805; x=1768257605; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aEHbWEu8o4hRs0gJSzo6S0CVOnW+0088t3zAhxxgAlg=;
 b=mJKSbS6s1uO+JlSCI72qV74tiUTKIiN60Ho1F4gptmG63jQAGBEgR7WJjv6Wd5BRO1
 o6fOIbf5Hn6JPp2+Z+n4NNFY4hGxjM/1hNDUIt26+jybo7nMNARYPi8xqiQpEhoXaOif
 uo5gCDrmwcE7c/CF+sp1J1G+/A974qGf1R0LcKLTBfsLZiEaYfbOZ/SN3E/+kEQGDVcJ
 c0cPLuD0fMUIrUC3jXOYuv9YjncmC4Z5MWAUjUM7TrAyxIWZhpxCYrtR7iYytNsm90XX
 FTl+MorucRcf+MkL4M7uuGmcA2EBkO4lOmM6556GZTB9YzaXAjEg1HO8bta4bXCgqoFh
 h/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767652805; x=1768257605;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aEHbWEu8o4hRs0gJSzo6S0CVOnW+0088t3zAhxxgAlg=;
 b=OOdSHcPLkwX4pNEQZ6+59oErdkh781OGxtAfPk3JAwE5b1nCYD+r6VWr9yk/VYlcPn
 J7A+yeuXghquotEDDZtRDGqIDR2rAaQszbxR9F6agWh3ZLPU2ecsur4vM60vl4DPt3nL
 /z2gQwed5kcoV8aJ+9BDi7NS7/YrC6DuYgIlzmeNnCowh8WYc0Cbj5cmONtQVxE5jJ7f
 u0/lsWGU8KTrFCjm+ZPktn6fJQuXrejVnpfDmzSE+kQdY++TIxiglWQZQriRN+W5fc0L
 Y1vVcaqPX/nIv0iebuYs1h8oMX2mE7HPbg7CabIUVtYQmTZW61aeOdqgfO3cp8Znbl2e
 E47A==
X-Gm-Message-State: AOJu0Yz3NThsKxwlIW9vVE0Aj/iW6bA6naU+A2PJuFrEJBVsNYYrHJpv
 5hqwyTlOR/D5FxSnNNE1vWoKZZj8dc37iIovxNXEMrA/uOG1YHRP3BP4pUthyvsDJ2t72vpJ3MU
 d7Q6bmEirGqzVvT2M2wkrfk+pyG27y+M=
X-Gm-Gg: AY/fxX6mKw92RyJZJciAiF8dUVf7RHJ/iVcQVbkxwaMnRyi6HYIuRQ+xzJWz/ITWwGu
 9zRgrDRT88OCtpuH5igkgVrX9AbcIo1gmko1CM05umsC5JCwApb7bWPgpmJcPrnXW/sTfVLg6xX
 VGVXyRDjpHpW7RuNysRfkS+U7qRYQyeFLs/4TaizLbBxfAm9v8QvJXD/sqO+TwnlQw+Xa9b6VJ/
 Dc5DRv02midVQkCTDziM9LEqivKuqZ3ZXqQUeulUQ6SwjVQb0P0FuXMrrLFqYh02cAAU/y0
X-Google-Smtp-Source: AGHT+IEo3RJ1x+Q3tAvwYE+eTtMVDMRtv/NSYV5gcKZ2pJFCXuomPhuDvqkWj0AuC1QREa9eyntAV30GKnlkYvMblJA=
X-Received: by 2002:a05:7022:686:b0:11e:3e9:3e9b with SMTP id
 a92af1059eb24-121f18f05femr461345c88.6.1767652804825; Mon, 05 Jan 2026
 14:40:04 -0800 (PST)
MIME-Version: 1.0
References: <20251226081800.2475186-1-perry.yuan@amd.com>
In-Reply-To: <20251226081800.2475186-1-perry.yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 5 Jan 2026 17:39:51 -0500
X-Gm-Features: AQt7F2rdV53ARn8nO1w2oaWJw2OIxgYnwmWcg85ovHzAz_ntCHaFry9VmvqNsCM
Message-ID: <CADnq5_MSrvCuE6_=kx2xNw38-XZUVVa5sp_-3WUhVV2+Ey4RGw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Disable MMIO access during SMU Mode 1 reset
To: Perry Yuan <perry.yuan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Yifan1.Zhang@amd.com
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

On Fri, Dec 26, 2025 at 4:36=E2=80=AFAM Perry Yuan <perry.yuan@amd.com> wro=
te:
>
> During Mode 1 reset, the ASIC undergoes a reset cycle and becomes
> temporarily inaccessible via PCIe. Any attempt to access MMIO registers
> during this window (e.g., from interrupt handlers or other driver threads=
)
> can result in uncompleted PCIe transactions, leading to NMI panics or
> system hangs.
>
> To prevent this, set the `no_hw_access` flag to true immediately after
> triggering the reset. This signals other driver components to skip
> register accesses while the device is offline.
>
> A memory barrier `smp_mb()` is added to ensure the flag update is
> globally visible to all cores before the driver enters the sleep/wait
> state.

Seems like it would make sense to extend this to all asics which
support mode1 reset.

Alex

>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           | 3 +++
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 7 ++++++-
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 9 +++++++--
>  3 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 824c5489ec85..75b1b78c0437 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5776,6 +5776,9 @@ int amdgpu_device_mode1_reset(struct amdgpu_device =
*adev)
>         if (ret)
>                 goto mode1_reset_failed;
>
> +       /* enable mmio access after mode 1 reset completed */
> +       adev->no_hw_access =3D false;
> +
>         amdgpu_device_load_pci_state(adev->pdev);
>         ret =3D amdgpu_psp_wait_for_bootloader(adev);
>         if (ret)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 8e35d501e81d..dcb169b25916 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2850,8 +2850,13 @@ static int smu_v13_0_0_mode1_reset(struct smu_cont=
ext *smu)
>                 break;
>         }
>
> -       if (!ret)
> +       if (!ret) {
> +               /* disable mmio access while doing mode 1 reset*/
> +               smu->adev->no_hw_access =3D true;
> +               /* ensure no_hw_access is globally visible before any MMI=
O */
> +               smp_mb();
>                 msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
> +       }
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index af1bc7b4350b..b1016debdf06 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -2069,10 +2069,15 @@ static int smu_v14_0_2_mode1_reset(struct smu_con=
text *smu)
>
>         ret =3D smu_cmn_send_debug_smc_msg(smu, DEBUGSMC_MSG_Mode1Reset);
>         if (!ret) {
> -               if (amdgpu_emu_mode =3D=3D 1)
> +               if (amdgpu_emu_mode =3D=3D 1) {
>                         msleep(50000);
> -               else
> +               } else {
> +                       /* disable mmio access while doing mode 1 reset*/
> +                       smu->adev->no_hw_access =3D true;
> +                       /* ensure no_hw_access is globally visible before=
 any MMIO */
> +                       smp_mb();
>                         msleep(1000);
> +               }
>         }
>
>         return ret;
> --
> 2.34.1
>
