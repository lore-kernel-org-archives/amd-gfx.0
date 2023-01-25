Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB129C27C76
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jan 2023 18:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 435C410E043;
	Wed, 25 Jan 2023 18:36:10 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4307F10E043
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 18:36:09 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-16346330067so573426fac.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 10:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WiNtgOteKc1D1fo4SM18Bj6K7LIrU5shUeIrozs/DGI=;
 b=WsOnTWsdM6He9xFZTOGfIrgTYZno1TxOSlbycSyGG0SQyZchPmLxynwd74//5DJCUk
 y/JOpOJq4rwD8pFWanTLI7dGEZ1rw9kWDPgQGe+mUrrcHHELnGr4+10r3/QSzTm26Iyw
 60ssgAk1/kJ1xeU/vqJRYVA5xeAqS+V+pQ5/tBC0o8dqX9M+nE2dIUbrX2xH5f9R3s2+
 e+5t43tnmtV2R/nYs5fU72P/OGEyEwL4AqNLnkPpvrF3dcS+Whi0cNMSNhV16wOFrDlB
 qo0d5EdlzURgzmWZxhu8LM+Z7z/J7IgFUTgR8w5/iOpB4j/oiCGLx9V2w20BB+lrnMtq
 K27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WiNtgOteKc1D1fo4SM18Bj6K7LIrU5shUeIrozs/DGI=;
 b=tEesDuYYvxk+Xdo/ceF4Izn2Ca99Ls7wK9FyzkdvQ7t2RIHmmTaKOFmtNf5VvKc0+p
 I+pDozYZ2ldZsKt1KluC6YXRzwaHOXcE4FTZqfQN6ENML9CD5VBg8h0GuMc4TNgEEURT
 f9VA3DYbJgB33S0FCT2atS9DbkpzDdtJtJosZn94ogH6CseuSOPnKwkUuCFdf3BTgRic
 gmWAnV8jhtdiJdFkcqQQpZ+wMV/VRz7S/w9jPya8m72ZghTBy/Roc710XpjWxOkn/fSa
 ffIg97P9/jvXO8FdKLc/QgxF8xQ706C2RnSqbqIphJPuXBYWT+TndFWUwT0ISp1c4O/y
 baEQ==
X-Gm-Message-State: AFqh2kq31m3GslobvElLOcQAnKhDArBq9otRR5L0c73sI+OF8G/WzFq3
 BMKf7Z3QHoF6G8lb0mgOt6771kBPOrhzEN5mrajzHgxp
X-Google-Smtp-Source: AMrXdXvVv7QyNcz6IWET2VOhO8SQ8Sx5bcoZQZ+NHFbyG9U066Ycg1tqSfHwwj38VCsEQa7QA+l7tgPpPgspSogsezA=
X-Received: by 2002:a05:6870:7a18:b0:15f:5509:9a0d with SMTP id
 hf24-20020a0568707a1800b0015f55099a0dmr3072312oab.46.1674671768478; Wed, 25
 Jan 2023 10:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20230125183339.15664-1-mario.limonciello@amd.com>
In-Reply-To: <20230125183339.15664-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Jan 2023 13:35:57 -0500
Message-ID: <CADnq5_Pqa+qZFWzvTDPz+u3fXM6JVm4VTE9PEfquztuGRdcayQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Allow s0ix without BIOS support
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

On Wed, Jan 25, 2023 at 1:33 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> We guard the suspend entry code from running unless we have proper
> BIOS support for either S3 mode or s0ix mode.
>
> If a user's system doesn't support either of these modes the kernel
> still does offer s2idle in `/sys/power/mem_sleep` so there is an
> expectation from users that it works even if the power consumption
> remains very high.
>
> Rafael =C3=81vila de Esp=C3=ADndola reports that a system of his has a
> non-functional graphics stack after resuming.  That system doesn't
> support S3 and the FADT doesn't indicate support for low power idle.
>
> Through some experimentation it was concluded that even without the
> hardware s0i3 support provided by the amd_pmc driver the power
> consumption over suspend is decreased by running amdgpu's s0ix
> suspend routine.
>
> The numbers over suspend showed:
> * No patch: 9.2W
> * Skip amdgpu suspend entirely: 10.5W
> * Run amdgpu s0ix routine: 7.7W
>
> As this does improve the power, remove some of the guard rails in
> `amdgpu_acpi.c` for only running s0ix suspend routines in the right
> circumstances.
>
> However if this turns out to cause regressions for anyone, we should
> revert this change and instead opt for skipping suspend/resume routines
> entirely or try to fix the underlying behavior that makes graphics fail
> after resume without underlying platform support.
>
> Reported-by: Rafael =C3=81vila de Esp=C3=ADndola <rafael@espindo.la>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2364
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index 57b5e11446c65..fa7375b97fd47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1079,20 +1079,16 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_dev=
ice *adev)
>          * S0ix even though the system is suspending to idle, so return f=
alse
>          * in that case.
>          */
> -       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
> +       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
>                 dev_warn_once(adev->dev,
>                               "Power consumption will be higher as BIOS h=
as not been configured for suspend-to-idle.\n"
>                               "To use suspend-to-idle change the sleep mo=
de in BIOS setup.\n");
> -               return false;
> -       }
>
>  #if !IS_ENABLED(CONFIG_AMD_PMC)
>         dev_warn_once(adev->dev,
>                       "Power consumption will be higher as the kernel has=
 not been compiled with CONFIG_AMD_PMC.\n");
> -       return false;
> -#else
> -       return true;
>  #endif /* CONFIG_AMD_PMC */
> +       return true;
>  }
>
>  #endif /* CONFIG_SUSPEND */
> --
> 2.25.1
>
