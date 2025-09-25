Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2ABCAC5B1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 17:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9144B10E9A8;
	Thu, 25 Sep 2025 17:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V/7GrYYb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED91410E99A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 17:48:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 87FA544523
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 17:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF00C4AF0B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 17:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758822480;
 bh=mA6PkKtltuAiGHc5QXkbQgm+Jc9JdGxHMRsx2t5JAa8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=V/7GrYYbG90wPN9IeN6OMZ83mlNDE3igM4dkz3fdMWzvJe7mU2VRzgxQhz00aVQyg
 Iv/4bn57iSmYnRmaTj0t3smavt1pcT9Uh8BwilmtDX5GLiMVAbSA3836Uj0zIHtI20
 JBBnsiCd+wfimv2MFVuQ6ZHxvvRmnq6RFOmwI5sstoMB+i5d4Wqx7FhHqF2kuguNYl
 avsQc72YNA97LUz4XHSFRZ4Vw/MGqiQBTKf6ZzvGp62QbPCpOPi+cd30DOky2bh5li
 UgbdClnQN2KKqHUO7PHoB078kI/W63pafrn/bBay33D+GnhkJvLLT5TdK2elH1aJ6w
 I5ounCoEoyKxQ==
Received: by mail-oo1-f48.google.com with SMTP id
 006d021491bc7-6335ef8e4c6so821392eaf.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 10:48:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU12Ewjx62rHaRNDHZlY3roQU6CJpM9luAyWasfwco8iLfs6RVsVtqO5RONg6NsjxgX4j9m/dEf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHyuZ0eyHk9EDmhfwSTo78MiNh1fyionEEK1lDZminvY2E7EDu
 3iXjzf/VqN1pmWyrrLMFPZMhNkrk25MyxDZd0/+4lNjRB4jtgRnUKQWtcljKmrw+JmsrVCXbm6e
 QGdrJeTtCx/k8IiXkHgNdQRHa34JSU0A=
X-Google-Smtp-Source: AGHT+IGlc2LORVQXnI7VA1514vSo/kHP6Wqb6lBZqoQ96Nmevq5N74ZhgngOLd9Sro1/zeQCUINxqFTmTUK3pRtHRx8=
X-Received: by 2002:a05:6820:22a6:b0:621:76b6:b3c with SMTP id
 006d021491bc7-63a3659aacdmr1802623eaf.4.1758822479378; Thu, 25 Sep 2025
 10:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250925155918.2725474-1-superm1@kernel.org>
 <20250925155918.2725474-2-superm1@kernel.org>
In-Reply-To: <20250925155918.2725474-2-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Sep 2025 19:47:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g1rm3w=93mWBRJaFiX9qMOkDMzEsU=_ScLBHSL-2i15A@mail.gmail.com>
X-Gm-Features: AS18NWClcr_8M-xeE1slFLHmD5kELB__HFAlr-1gHiqIRjQCMegR0T57WHvk7A4
Message-ID: <CAJZ5v0g1rm3w=93mWBRJaFiX9qMOkDMzEsU=_ScLBHSL-2i15A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PM: hibernate: Fix hybrid-sleep
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Samuel Zhang <guoqing.zhang@amd.com>, 
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
 "open list:HIBERNATION (aka Software Suspend,
 aka swsusp)" <linux-pm@vger.kernel.org>, Ionut Nechita <ionut_n2001@yahoo.com>,
 Kenneth Crudup <kenny@panix.com>
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

On Thu, Sep 25, 2025 at 5:59=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> Hybrid sleep will hibernate the system followed by running through
> the suspend routine.  Since both the hibernate and the suspend routine
> will call pm_restrict_gfp_mask(), pm_restore_gfp_mask() must be called
> before starting the suspend sequence.
>
> Add an explicit call to pm_restore_gfp_mask() to power_down() before
> the suspend sequence starts. Don't call pm_restore_gfp_mask() when
> exiting suspend sequence it is already called:
>
> ```
> power_down()
> ->suspend_devices_and_enter()
> -->dpm_resume_end()
> ```
>
> Reported-by: Ionut Nechita <ionut_n2001@yahoo.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
> Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
> Fixes: 12ffc3b1513eb ("PM: Restrict swap use to later in the suspend sequ=
ence")
> Tested-by: Kenneth Crudup <kenny@panix.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v2:
>  * Move under CONFIG_SUSPEND scope (LKP robot)
>  * Add tags
> ---
>  kernel/power/hibernate.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 2f66ab4538231..52c1818749724 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -695,6 +695,7 @@ static void power_down(void)
>
>  #ifdef CONFIG_SUSPEND
>         if (hibernation_mode =3D=3D HIBERNATION_SUSPEND) {
> +               pm_restore_gfp_mask();
>                 error =3D suspend_devices_and_enter(mem_sleep_current);
>                 if (error) {
>                         hibernation_mode =3D hibernation_ops ?
> @@ -862,7 +863,15 @@ int hibernate(void)
>                                 power_down();
>                 }
>                 in_suspend =3D 0;
> -               pm_restore_gfp_mask();
> +               switch (hibernation_mode) {
> +#ifdef CONFIG_SUSPEND
> +               case HIBERNATION_SUSPEND:
> +                       break;
> +#endif
> +               default:
> +                       pm_restore_gfp_mask();
> +                       break;
> +               }

You're breaking HIBERNATION_TEST_RESUME here AFAICS and power_down()
doesn't return.

>         } else {
>                 pm_pr_dbg("Hibernation image restored successfully.\n");
>         }
> --
