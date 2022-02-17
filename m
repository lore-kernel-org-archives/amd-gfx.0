Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD788C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 03:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45DEE10E78E;
	Thu, 17 Feb 2022 03:54:31 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B50810E78E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 03:54:30 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id x24so4575610oie.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 19:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iXkZMP+TPklPYNTYQOOol5DgfyA3+dX6YRh3zZHKoCg=;
 b=g3so5tndtbBHtbL4AAytDADSeRPnFWSOL6i5WotmLQqHwxosYBeGymJS+WIQiDTMW5
 XqCWV9s57SwHV43vv+BI87zf8sMtfS86uuzsYFncVyK7kOWMLl++gT19Ajce+QSjtACn
 hSQyGGSkN3cHhzqNMQCa5foGJ7ITBdLb9f4+ahyg2fj4i5/Gvh2zHC4Sg5Y2nEneElix
 se4fI6BZIwu7m0fRcyoxW8i36jmmKl8deLphklk5ZEgXBOF/EDO8qcsQNIKvDF9IIbHv
 qJb+kPkkV8MygZftPlBnTAPLJ5ZTU1X+zICkkqhcIi1MfDrzkf/D2kJbkOJ5BBhvLKGn
 kJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iXkZMP+TPklPYNTYQOOol5DgfyA3+dX6YRh3zZHKoCg=;
 b=iLCLUtwORNdbl/sPl3hsLhx51HojfvTPJUFezzlVFpOUl4HnJle1nkIf7Eob7NL+DR
 uOzvWqhruP27zpfcudZWahSNNG7y8J+zhWpKQCducyJvtC8iMuJiHaABGMC642NYaHb4
 9g0i9Enw2bkhBkIvmi19bDRKSkYZh9fHiayL/Wy9V/TBUF5qyqBGghhXBCYUZs5fElUn
 QG/Taj0DcFW4A5K/r5WMbjs7fKOH5id+DbN4RKAShtMVV9lMnimbbJWbupG20rZyVkUL
 AcR4ktDPAWNRan4Zn3ZqebOGoG2SbfM5LLlTA6+szPeKkfrkQRdUcG9f2vkFNvWb/4hf
 N7bQ==
X-Gm-Message-State: AOAM532Ae9oWroI6QyAmkzfrPvMu8ZA6g//Zz4Z2ZG10ODFd9yaTOnAD
 6z2bFRzdjsEpUz3JYGbabEHp72+wGmiY/dAZ3Ps=
X-Google-Smtp-Source: ABdhPJxNGRxqDwoqt2Um09xouRPrOISVvN2FKNMNSoYjZ9MV/uVY8G7yfA25o396CRBzL7tqRoKIoqgn8CHic/VCv28=
X-Received: by 2002:a05:6808:f8b:b0:2ce:6ee7:2c99 with SMTP id
 o11-20020a0568080f8b00b002ce6ee72c99mr2065623oiw.199.1645070069833; Wed, 16
 Feb 2022 19:54:29 -0800 (PST)
MIME-Version: 1.0
References: <20220217034608.14733-1-mario.limonciello@amd.com>
In-Reply-To: <20220217034608.14733-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Feb 2022 22:54:18 -0500
Message-ID: <CADnq5_Odp1r_=wO2WJVqAK2dYtPZE3xjx7g-aq90S5=dqTmHPA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Check if ASPM is enabled from PCIe subsystem
To: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Koba Ko <koba.ko@canonical.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 16, 2022 at 10:46 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit 0064b0ce85bb ("drm/amd/pm: enable ASPM by default") enabled ASPM
> by default but a variety of hardware configurations it turns out that this
> caused a regression.
>
> * PPC64LE hardware does not support ASPM at a hardware level.
>   CONFIG_PCIEASPM is often disabled on these architectures.
> * Some dGPUs on ALD platforms don't work with ASPM enabled and PCIe
>   subsystem disables it
>
> Check with the PCIe subsystem to see that ASPM has been enabled
> or not.
>
> Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
> Link: https://wiki.raptorcs.com/w/images/a/ad/P9_PHB_version1.0_27July2018_pub.pdf
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1723
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1739
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1885
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1907
> Tested-by: koba.ko@canonical.com
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 5acd0473ed01..d2548fab51c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2008,6 +2008,9 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>                         return -ENODEV;
>         }
>
> +       if (amdgpu_aspm == -1 && !pcie_aspm_enabled(pdev))
> +               amdgpu_aspm = 0;
> +
>         if (amdgpu_virtual_display ||
>             amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
>                 supports_atomic = true;
> --
> 2.25.1
>
