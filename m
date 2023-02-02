Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD2BC05027
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Feb 2023 03:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27E2D10E1BD;
	Thu,  2 Feb 2023 03:49:27 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A46AE10E1BD
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Feb 2023 03:49:24 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-16332831ed0so934124fac.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Feb 2023 19:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hP1zDGXgCJM9/Zlc/Vjz8LCV90QhvNKSjxx7mIADnVo=;
 b=l2iVtqGgAXXMFMc2pvBttpwuXmXk2rgFBZA6+Pzuz7YKTsIUerbCr0N5i8GnGkjHWE
 Xmk0eM+B/GoIOk/AfTWSaYbmzQxlsYmQZEKHSG1yrY/vBup3f9XWpbeYI3JxIgAqRnyL
 r3AlHX7XRm+AtlsOkQK8FR3XiMIHS0JLvFy8X5b7Yko4YCw17kVbXsrOSHTPDYVRLh9i
 O2gCJZSJi8QveIUptzGlsqTYANA/JsMUu/8393wyqkjdTyIO1qW4nIaoOj1mj1AAOcMu
 tInXJaWjU4I4GFrmPXGIyNbvcbc4JV9BkPx0Tlibk2DTirFE11d+2IaQ9HXXDWAYFom9
 P9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hP1zDGXgCJM9/Zlc/Vjz8LCV90QhvNKSjxx7mIADnVo=;
 b=US1FHHe8GMUeIDsK17C19uj7HXEKKWm+p3gbLX07ZiryZVOns/uYDrLjVFJv1SRpsx
 tLYIhyw7y6ifB02/DBfBHFTJCR2sFl7lkgYaP3/JeCV3UH4WbiNgZZnlaiEIVKMToJfc
 vyjluoyb+cxSLV+dtI1M4VLoVIh2iw1XpQa2pOMEsn2KktjN1IUrRL5Y5k3KO0uf7XzC
 41YGNLtbFASuc4i+7kwgAXfY/1NnmplRc6lbQB8F7sB8KFs2oSZL+ADVu9/thBfAcWWs
 JX0amVZEXuJbp65jUA1ftCHfPpuzLPu4AcWnaFLWO4tH5xTbhYk/Eu7lqg0ulLXRZ6+o
 7+Tw==
X-Gm-Message-State: AO0yUKWGYbxhypceuJWRG0FR2Wk0pG3HoYvfYWP0o3tWBR3HkRRm6zrh
 UyPG0AURtqYRdsYpJvpVZ3ooDpHa5wqOnTiEFp0=
X-Google-Smtp-Source: AK7set/aIHx4qW1r6bUrGWen90e75NWvrG9wH/bN5qftVmqHbdsVbly0K0WaCv/vjYSNHNMFZulKEZQ2cbI5soLBJRE=
X-Received: by 2002:a05:6870:891f:b0:163:8cc6:86a with SMTP id
 i31-20020a056870891f00b001638cc6086amr172668oao.46.1675309763880; Wed, 01 Feb
 2023 19:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20230125183339.15664-1-mario.limonciello@amd.com>
In-Reply-To: <20230125183339.15664-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Feb 2023 22:49:12 -0500
Message-ID: <CADnq5_NvUVJG8k_VPrm6N48ZUhnJTDBBB3WUrpCpeBTuq8YP8w@mail.gmail.com>
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

Thinking about this more, I think we may need to check the asic type
here.  Pre-Raven APUs didn't support S0ix at all so this may break
them if they have any checks that use amdgpu_acpi_is_s0ix_active() in
their code paths.

Alex


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
