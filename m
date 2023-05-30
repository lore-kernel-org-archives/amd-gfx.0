Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44C9C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 18:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D8F10E248;
	Tue, 30 May 2023 18:15:59 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCCDB10E3F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 18:15:57 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-19f0e612589so3122841fac.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 11:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685470556; x=1688062556;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNczwBD3HSU4iKcwJYB6oF9j5jRuDPS0VwlnTnY9V9E=;
 b=dzuQg0woF4n+ZcWMZyPE/1WF0jDgZaPCqlkoPL/Z1+wStEhAKdvKoeTEDfXAMS7DVb
 96Qpja/SP5wW6k5G0mwRYk2uB7+s6ctn10QtGyzlbxywffJ3FmCELHTro2Lj3f3bo8ru
 ekzxPb6E0bTtr7venC1IhdEQEPCzNudIeZzPqgxH7xTxVeZSa8xAmFomLfXHyBTyuKKr
 xNbouTvK/4PVF1Vu/sTB9j6AENL933QEtd7gdx/YY4EQPUZbTYDn0+QwJRRnqMYW0sFg
 cS9Ij2Nxy3oZ1rvW8snnV3GJYVtO3ucPYb7+o8/nk5XkRoUDQ95/nmLPaBdoIXGjlznE
 HOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685470556; x=1688062556;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hNczwBD3HSU4iKcwJYB6oF9j5jRuDPS0VwlnTnY9V9E=;
 b=Q5DyMskk+fWU29SM7tg5mKCJNminzvmqwU3R+VeCVid6g18xEx4vorjk7kF+CURDu1
 yPzr9wqEEHmowVihAOycqwA0F55YbYfoU3/Nk/JeLR28N3RHdzgKQhf55xrDJveZtPCx
 bo8wRoVsdoygxu0F4J0QP2XfIDhdIMADZJjAx4SorUzUY0qiBPOadhMN5Mn+dafR1tW/
 bmfhDqd2GLn9/1H/0cZAPDEmUAq6tpWkL8r0POllwwV241Fs2iokTpKBRhfUYBg+7dY3
 KPChM8nCqL/10xbWWJvttYItAiDuxVOPRqs40xy9xcahA7ucPLUfGaeg1YSJhR+NHo5F
 UceQ==
X-Gm-Message-State: AC+VfDzIMFDyB5ls/nlV47xaDUU+IejKyLeVj97ISRKC6teXJAeYxHVX
 r+UvLfmxK6GdLzypA8V3RdGdGue2PLEN/fenYvpAfjyV
X-Google-Smtp-Source: ACHHUZ47CNHs3MYPSvHlhbLMRxVEw/bAeCvop21RXe6I16P2Ha+dFrHXvLwQTSUIbqfr1jSFVfBJ9UGLLxA0YooYrYY=
X-Received: by 2002:a05:6870:4713:b0:19e:ad7a:bb02 with SMTP id
 b19-20020a056870471300b0019ead7abb02mr1890666oaq.11.1685470556451; Tue, 30
 May 2023 11:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230530175301.231070-1-mario.limonciello@amd.com>
In-Reply-To: <20230530175301.231070-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 May 2023 14:15:45 -0400
Message-ID: <CADnq5_M8XdDsyn0q-mM4CfFoMHH6g54VP_SG4cNztEYAwwB_hg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd: Disallow s0ix without BIOS support again
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
Cc: =?UTF-8?Q?Rafael_=C3=81vila_de_Esp=C3=ADndola?= <rafael@espindo.la>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 30, 2023 at 1:53=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support") showed
> improvements to power consumption over suspend when s0ix wasn't enabled i=
n
> BIOS and the system didn't support S3.
>
> This patch however was misguided because the reason the system didn't
> support S3 was because SMT was disabled in OEM BIOS setup.
> This prevented the BIOS from allowing S3.
>
> Also allowing GPUs to use the s2idle path actually causes problems if
> they're invoked on systems that may not support s2idle in the platform
> firmware. `systemd` has a tendency to try to use `s2idle` if `deep` fails
> for any reason, which could lead to unexpected flows.
>
> To make this the behavior discoverable and expected, revert commit
> cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support") and offer
> a message if SMT appears to be disabled.
>
> Cc: Rafael =C3=81vila de Esp=C3=ADndola <rafael@espindo.la>
> Link: https://github.com/torvalds/linux/blob/v6.1/drivers/gpu/drm/amd/amd=
gpu/amdgpu_acpi.c#L1060
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2599
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index 3a6b2e2089f6..a3523d03d769 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -28,6 +28,7 @@
>  #include <linux/xarray.h>
>  #include <linux/power_supply.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/sched/smt.h>
>  #include <linux/suspend.h>
>  #include <acpi/video.h>
>  #include <acpi/actbl.h>
> @@ -1473,6 +1474,13 @@ void amdgpu_acpi_release(void)
>   */
>  bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
>  {
> +#ifdef CONFIG_X86
> +       if (!sched_smt_active()) {
> +               dev_warn_once(adev->dev,
> +                             "SMT is disabled by the BIOS.\n"
> +                             "To use suspend-to-ram enable SMT in BIOS s=
etup.\n");
> +       }
> +#endif

Will this generate a spurious warning on platforms that are natively non-SM=
T?

Alex

>         return !(adev->flags & AMD_IS_APU) ||
>                 (pm_suspend_target_state =3D=3D PM_SUSPEND_MEM);
>  }
> @@ -1499,16 +1507,20 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_dev=
ice *adev)
>          * S0ix even though the system is suspending to idle, so return f=
alse
>          * in that case.
>          */
> -       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> +       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
>                 dev_warn_once(adev->dev,
>                               "Power consumption will be higher as BIOS h=
as not been configured for suspend-to-idle.\n"
>                               "To use suspend-to-idle change the sleep mo=
de in BIOS setup.\n");
> +               return false;
> +       }
>
>  #if !IS_ENABLED(CONFIG_AMD_PMC)
>         dev_warn_once(adev->dev,
>                       "Power consumption will be higher as the kernel has=
 not been compiled with CONFIG_AMD_PMC.\n");
> -#endif /* CONFIG_AMD_PMC */
> +       return false;
> +#else
>         return true;
> +#endif /* CONFIG_AMD_PMC */
>  }
>
>  #endif /* CONFIG_SUSPEND */
> --
> 2.34.1
>
