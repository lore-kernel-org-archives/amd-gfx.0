Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7B6C77B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 06:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5EDF10E1F8;
	Tue, 24 Jun 2025 06:36:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QxtM07I4";
	dkim-atps=neutral
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4E8410E1F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 06:36:20 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-2da3c572a0bso49937fac.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 23:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750746980; x=1751351780; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XN6TuGeyrIqut9p4j/N7jW+heUn3/vlQTRZgcGd/JL0=;
 b=QxtM07I4tQrm4KnuH0Cz4r64jQmhnG9U8sV67uVx0t/LOCeX2oT+MJcxj46/KNSh8B
 IPs1fW3o+YNRv0T0IpvQZRgAZPImoVXP82S7k8KRCD/dDHdob3aqTZBG2Jl2nvMx13mD
 oQPSahnAQu4r+KiImQku7Kml1RNNkTn/Tgdv8Ds+WYUm1UATQiT/p4aFcM2uzcrDvpp+
 2JmIacn9qBJlRO7+Aa0gpjsU138Gd+lVOyHZCUdfRrp5nbvOPxvKGPBbaYfU5d39UHW1
 feVILA7fIoxD6p9doqq3ECkCO/lFEusjBBS6xPQ1yLX2eO50sj2/y1ZWb3QIGySId1ve
 Rs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750746980; x=1751351780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XN6TuGeyrIqut9p4j/N7jW+heUn3/vlQTRZgcGd/JL0=;
 b=pmh+mVMHFVt70toL9gAk2RyVPTW/iEnUpRmtjGUg1GjJN7/wOVtdGR+aRBiXvFcLPS
 AVRvmHR1tNReWhhGOQ/R19leCxcyqmxznq5jbMSxkrHE5eonD491g4Cz/EMdU6oTDIn5
 DVWl6fYL1D8/dSAHuCLHTqgczR6MMOhUH0+0cbNkPl7dfFVdFT5slGirspCyLD5EF8FT
 JUnXeFw0DiEoh9TBcqSd8uWiJ8wXcC0qHRE74ehxhinuc6M8WAYSz0Iw1NjRWVqS8U6Q
 XPIc8NiTtrLNxso6mNz9bjRUSYM2KNuWuEmZ9n1IveUzeGVScc6KXrPKS/rtRE7TzPvb
 CBEw==
X-Gm-Message-State: AOJu0Ywv7AevgytW6TN/nlUJ+OUhzOqssUfttebpUXHAiWcz7+3QedjH
 DV58ufGh9MluByIWzdJ0SBENNXOgSgc6j+juaGP70wXuCO+sPzBHKh9r7GkAqu7inGebtBhntfz
 lNkXZEDSINM0NkBwkoXJnpLzvHaaTYQU=
X-Gm-Gg: ASbGncusZYEsOQz6zNS8hp7FsNTTHFsWTfjxsbb/oaRwXXun8e7ZT1JC4jgT1WdJEkD
 AhSIPZiC2J27d2Nqes1jvwraAVBqLonbb8JaWPic/jWbPxHtiidJBepdQlrUBaINTEORdtlSEcQ
 1Qv+FtxKBmW3BM8affgRVx6Wnbkaz+37F40G8kKndfVgw=
X-Google-Smtp-Source: AGHT+IEwJlPe4Rh+pIHQ04ZYNNI+pgmi+uqmaXg1K1gDDKcTidI3yhmuoBBv3daHJmGRRFvDmAZel7CiAIg7wjSEeTw=
X-Received: by 2002:a05:6871:7a4:b0:2d5:d5c:a851 with SMTP id
 586e51a60fabf-2eeda4d760cmr10413543fac.6.1750746979927; Mon, 23 Jun 2025
 23:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250618213217.3862490-1-superm1@kernel.org>
In-Reply-To: <20250618213217.3862490-1-superm1@kernel.org>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Tue, 24 Jun 2025 02:36:08 -0400
X-Gm-Features: Ac12FXxfG1yTD3Kn5PxQE1v4c5rVGLsyiFPvbo-rwE0RJMXI_8qkODk_Qp4wvEk
Message-ID: <CAPEhTTFOZh1_xntmj1ETOq77Ja1KkBTH7hi3ZDmnCVtq9DT4CQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Decrease message level for legacy-pm prints
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

I think we need to also modify kv_dpm_print_power_state() and
si_dpm_print_power_state(). Both send power state info through
DRM_INFO, which should be decreased in the same way.

On Wed, Jun 18, 2025 at 5:32=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> legacy-pm has prints while changing power states that don't have
> a level and thus are printed by default.  These are not useful at
> runtime for most people, so decrease them to debug.
>
> Reported-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4322
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu=
/drm/amd/pm/legacy-dpm/legacy_dpm.c
> index c7518b13e7879..5b09c5fd9dc13 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> @@ -123,14 +123,10 @@ void amdgpu_dpm_print_cap_info(u32 caps)
>  void amdgpu_dpm_print_ps_status(struct amdgpu_device *adev,
>                                 struct amdgpu_ps *rps)
>  {
> -       printk("\tstatus:");
> -       if (rps =3D=3D adev->pm.dpm.current_ps)
> -               pr_cont(" c");
> -       if (rps =3D=3D adev->pm.dpm.requested_ps)
> -               pr_cont(" r");
> -       if (rps =3D=3D adev->pm.dpm.boot_ps)
> -               pr_cont(" b");
> -       pr_cont("\n");
> +       drm_dbg(adev_to_drm(adev), "\tstatus:%s%s%s\n",
> +               rps =3D=3D adev->pm.dpm.current_ps ? " c" : "",
> +               rps =3D=3D adev->pm.dpm.requested_ps ? " r" : "",
> +               rps =3D=3D adev->pm.dpm.boot_ps ? " b" : "");
>  }
>
>  void amdgpu_pm_print_power_states(struct amdgpu_device *adev)
> @@ -943,9 +939,9 @@ static int amdgpu_dpm_change_power_state_locked(struc=
t amdgpu_device *adev)
>                 return -EINVAL;
>
>         if (amdgpu_dpm =3D=3D 1 && pp_funcs->print_power_state) {
> -               printk("switching from power state:\n");
> +               drm_dbg(adev_to_drm(adev), "switching from power state\n"=
);
>                 amdgpu_dpm_print_power_state(adev, adev->pm.dpm.current_p=
s);
> -               printk("switching to power state:\n");
> +               drm_dbg(adev_to_drm(adev), "switching to power state\n");
>                 amdgpu_dpm_print_power_state(adev, adev->pm.dpm.requested=
_ps);
>         }
>
> --
> 2.43.0
>
