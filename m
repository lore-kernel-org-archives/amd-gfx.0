Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B927FC77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 13:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F8510E1C8;
	Wed, 31 May 2023 13:26:40 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E905710E1C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 13:26:38 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-19f22575d89so2377423fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 06:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685539597; x=1688131597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VBSeV8skhsdfB3yeHdSXZHeyjAD00anZ8UI378xqJiU=;
 b=Pabroi95v5JwUsMDZNeWcC/JfEBXpo+LZhEqyZP+r4vRAPh5I1DLr+MHl/Vk2O8w3p
 VD9TjavupC2rhoBahZJfC1nSZ72YKz/DEhzYN6YR88tnwkhFtLGftA8krROyIGpm1Sx6
 +U2KLzF5DsPoaeggI5q2cCFbYq2emjZKfufCzor8YPo3cFRu7u/wzAzVmYGZiU5/iv4r
 9zAnnrf4I07m2vrrHZOaiTxL5/9se5cfiDyCHIopIiK/MRb2KySiJB1YFakFPJQQkzVY
 nnJUHfJ9xQG04AcSsGc61rMFwdKnQWX6/Fa2f7IwuWffpltl5dWtRokvGrlvw1J4N6jW
 9wBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685539597; x=1688131597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VBSeV8skhsdfB3yeHdSXZHeyjAD00anZ8UI378xqJiU=;
 b=BOlWXkXdzHwCEq7MQfyTnaS25rwcrri/5YIs8n9Y3gRj/4lWW8DV81y6knAArXpaio
 IA+0delkWiRmBT3UNfwEoMxNII29h2acGoDZCQ9tG+EPuwenl8gUB/1jluXl5eKtb/S0
 hqHCckmsDBfXghZtvNAH+QnBLOc1D+m+RDydTEhktURfIlC0q7ZDgavgqX1e5z2wn9XK
 r8C5EM+TziLKsVNQcJuAvx4Jrvg5dhN7yAgTAFBqpEZrlnLjgcTotAMPCV5POQD8h9fJ
 k+MYzybFg2zonCkTCGAWw9hRU9K/zMG+YPy5D6G3f0F8MsCfmTI+YSNyB0Vs+VUaOTi/
 DIaQ==
X-Gm-Message-State: AC+VfDxKk/D1fxCQFBNZ9aiGSA4Z+PPSQLvogF9qBFY3+KrmbCfPucIy
 dDtsbfQodNmb5S4fI+kSMTurwKfXF3bESj0jZCHPcbzVGHY=
X-Google-Smtp-Source: ACHHUZ6jbqFha+bBzs4mUXS3WAdYE59To4j1HK3V8hTkT3qne/l05SVCpWcOImso5Mw9EYM7WUpbXaPl3qwx4Ehk0Zc=
X-Received: by 2002:a05:6870:3a2e:b0:19f:5701:8c34 with SMTP id
 du46-20020a0568703a2e00b0019f57018c34mr2347764oab.41.1685539597651; Wed, 31
 May 2023 06:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230530204848.231842-1-mario.limonciello@amd.com>
In-Reply-To: <20230530204848.231842-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 31 May 2023 09:26:26 -0400
Message-ID: <CADnq5_N64zscFAjTj2JtBGqyoZRUjazSrW75NGAJqPKWBXL68Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amd: Disallow s0ix without BIOS support again
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

On Tue, May 30, 2023 at 6:34=E2=80=AFPM Mario Limonciello
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
> The original commit also fixed a problem during resume from suspend to id=
le
> without hardware support, but this is no longer necessary with commit
> ca4751866397 ("drm/amd: Don't allow s0ix on APUs older than Raven")
>
> Revert commit cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support")
> to make it match the expected behavior again.
>
> Cc: Rafael =C3=81vila de Esp=C3=ADndola <rafael@espindo.la>
> Link: https://github.com/torvalds/linux/blob/v6.1/drivers/gpu/drm/amd/amd=
gpu/amdgpu_acpi.c#L1060
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2599
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Patch 1 is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Patch 2 seems a bit much, but I could be convinced if you think it
will actually help more than a warn would.  Users already assume warn
is a kernel crash.  I'm not sure the average user makes a distinction
between warn and err.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index aeeec211861c..e1b01554e323 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1092,16 +1092,20 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_dev=
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
