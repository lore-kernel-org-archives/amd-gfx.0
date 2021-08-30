Return-Path: <SRS0=q6mt=NV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB864C432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 16:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB32D61004
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Aug 2021 16:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB32D61004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4497189AEE;
	Mon, 30 Aug 2021 16:04:42 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9950289AEE
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Aug 2021 16:04:40 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id bi4so16674029oib.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Aug 2021 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iFouTVS5fc8HbBaCxjT30Amx7cyjvTvCmj1iYS3XiNg=;
 b=Wb3Oxu4fU0iYMW2FLrID6J2FoqW9Tsz2DYi19jXE7Qcp0gIXpS2an8KZRWOCTbqxOQ
 GfO2k7tgpU7g+fIxcaxUTsZ0HzJGIahUd1fuIik5aSTQYytYCGPEfTe6Mkqro7F0Yn+S
 Z/neCyPE+bmtBzPMb4BwlSSi1MfZVASoMzKns1QBbSZ0dpJMiswrsgxc0eK0JixvLfzB
 /V422yJ7kilZwevXIyTVc3KbWyfRxAttHFBxMoISET/gEywFpJc2XD610p1ENIeHRbox
 8ol+f63ze/Pyqn6QrsBCqSYpjF+hiFA2DxOlbljCh4e0zOMDGrEOBZ7BBS2oAu6rXK+Q
 OW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iFouTVS5fc8HbBaCxjT30Amx7cyjvTvCmj1iYS3XiNg=;
 b=iPA2rMQtzuhd+DZnj7CSH/s8XNf9nXP1MXGT6jV5VqYY65vAXTh5LaFrdXkDjJ/1Kc
 nnTmnkC5csxPoWZB67cFKrLdsxUVvMrVZb64tAigAClelkc3qaY+afGeEysnZA4oAI4L
 Vm+GHUo7QzeYdegBifRLphR6jmfVLKb6ORMumz56xd8Jexfowwo4Bvxg/igZIcktZbpD
 NnoeWTvpapqUk9wLWKM9yHUF7yZPNvW4VpTm6cFnR18/G8gvpJ1HU2/7vXLAOk2nuhVX
 jcLiR2GpvaNmMXoIVsxm1fP0f5Uf422EzmcXkay8wmW4njq8pDDs8a71sVmldK94G5EA
 pjjg==
X-Gm-Message-State: AOAM531FpFYVRUkYP/FghiSdkx2lS/O2O3GgG+Zp6bobR30Ys6/3p2CN
 faAW2o98Q6Eget6MkAoFul2LTgCVYI+phb3hoA0=
X-Google-Smtp-Source: ABdhPJxJc+Ls1w4Fog4M9yGsyy0hlPVfNA0QCLaFFZonVJyLmaYvFgz7RUozOulrZCHxtSYpKO1JA+BVpS/fUXuj0EA=
X-Received: by 2002:a05:6808:6d2:: with SMTP id
 m18mr15841966oih.120.1630339477397; 
 Mon, 30 Aug 2021 09:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210830020200.611574-1-koba.ko@canonical.com>
 <20210830020200.611574-2-koba.ko@canonical.com>
In-Reply-To: <20210830020200.611574-2-koba.ko@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Aug 2021 12:04:26 -0400
Message-ID: <CADnq5_PCRAtZNJo_R=iLSEtv_zk+_b02YRAZcgXgjBLs4Cy0fQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/1] drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform
To: Koba Ko <koba.ko@canonical.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Aug 30, 2021 at 3:17 AM Koba Ko <koba.ko@canonical.com> wrote:
>
> Due to high latency in PCIE clock switching on RKL platforms,
> switching the PCIE clock dynamically at runtime can lead to HDMI/DP
> audio problems. On newer asics this is handled in the SMU firmware.
> For SMU7-based asics, disable PCIE clock switching to avoid the issue.
>
> AMD provide a parameter to disable PICE_DPM.
>
> modprobe amdgpu ppfeaturemask=0xfff7bffb
>
> It's better to contorl PCIE_DPM in amd gpu driver,
> switch PCI_DPM by determining intel RKL platform for SMU7-based asics.
>
> Fixes: 1a31474cdb48 ("drm/amd/pm: workaround for audio noise issue")
> Ref: https://lists.freedesktop.org/archives/amd-gfx/2021-August/067413.html
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> ---
>  .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 0541bfc81c1b..1d76cf7cd85d 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -27,6 +27,9 @@
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <asm/div64.h>
> +#if IS_ENABLED(CONFIG_X86_64)
> +#include <asm/intel-family.h>
> +#endif
>  #include <drm/amdgpu_drm.h>
>  #include "ppatomctrl.h"
>  #include "atombios.h"
> @@ -1733,6 +1736,17 @@ static int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
>         return result;
>  }
>
> +static bool intel_core_rkl_chk(void)
> +{
> +#if IS_ENABLED(CONFIG_X86_64)
> +       struct cpuinfo_x86 *c = &cpu_data(0);
> +
> +       return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
> +#else
> +       return false;
> +#endif
> +}
> +
>  static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
>  {
>         struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
> @@ -1758,7 +1772,8 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
>
>         data->mclk_dpm_key_disabled = hwmgr->feature_mask & PP_MCLK_DPM_MASK ? false : true;
>         data->sclk_dpm_key_disabled = hwmgr->feature_mask & PP_SCLK_DPM_MASK ? false : true;
> -       data->pcie_dpm_key_disabled = hwmgr->feature_mask & PP_PCIE_DPM_MASK ? false : true;
> +       data->pcie_dpm_key_disabled =
> +               intel_core_rkl_chk() || !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
>         /* need to set voltage control types before EVV patching */
>         data->voltage_control = SMU7_VOLTAGE_CONTROL_NONE;
>         data->vddci_control = SMU7_VOLTAGE_CONTROL_NONE;
> --
> 2.25.1
>
