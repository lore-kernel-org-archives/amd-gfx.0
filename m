Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291D5C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 13:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E29D560FDC
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 13:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E29D560FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B19E6E84B;
	Thu, 26 Aug 2021 13:22:57 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04ECD6E84B
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 13:22:55 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 m7-20020a9d4c87000000b0051875f56b95so3426513otf.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 06:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xZk1yK/RKN8KbmLA1P7+61RnS5vT9rIMIy74uPj2aso=;
 b=uxzHheZEfxGUm9otamlCui95TGqhN3JBfuRyKI1kK1e9exaxncae3X7CAl7EMPUCUL
 cCPSTfsrl7tcKD4/kmAV5/EXv0iSvO0Ptr07oqfb6AK1FWXgQVKU7cBavmrRPiiVzoGi
 PhNsry435iSxGVBhksO2llrq9J4qvZmpEl+pU7FKZRiqf7R+hxkcVEbv4vJ7f/iDk4e3
 8kaRybqoByjeRMvXIqGXpb8IHjahiBU3wEo66TWLjqqZuy2q6l7+V+gflVoFNqOj5PNu
 BKSFSk6KBi6Uw5Jg5yfvzUJUwbLApu+XqZCW8cC++P1RsjM95eHu2L2HvCyb9l2/eoas
 EjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xZk1yK/RKN8KbmLA1P7+61RnS5vT9rIMIy74uPj2aso=;
 b=kbMMFkUwCe3NAvSIqQlADabEj+K+bSL/wceg0PBmuHTKOnUs+u54GXYkst9cY8G3DN
 YkOV5V38nFpdtIUBESnTuWxAf5J8w2tLW1b6mamerDPg0Cyu6BS/YwgXeDNzpOLHgJYI
 cZL6Q0hAHt30+Wnj+zVBBJ/V7J3UbZnragbBgAwX/kmpqhAYyYzkUGyqCotCJcygm2vA
 Dp7POIrW4B3+p5OeKUQzSTwGGfaZAlludbHbcQ16FBf068aNwcrpHU/bEcaK1/CsbXeh
 QWL/pjaTV4+zMcSL6IefHTvMafV4XYObG+O77/eEJL8F1zj/wx3F0Engnq9rrghDskBV
 eeDg==
X-Gm-Message-State: AOAM531VTTFe3dBiFvn2oElNV5GmMY+oy3AzC1YAWzU36JQLrhHj/rzu
 HRcXE0HHzFHeZDCdlU0HFmv4V2HRrnYNFZVS+J0=
X-Google-Smtp-Source: ABdhPJwGnuWcwi1mmW4C/PNFF5qDIKFO7FvtUSeo0Fh9NL/2ndTeXzrqOT7iGssEO+7QswfZMWo/Po/sUYk8KxWqnFo=
X-Received: by 2002:a05:6830:1c69:: with SMTP id
 s9mr3257874otg.132.1629984175141; 
 Thu, 26 Aug 2021 06:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210826013523.394705-1-koba.ko@canonical.com>
 <20210826013523.394705-2-koba.ko@canonical.com>
In-Reply-To: <20210826013523.394705-2-koba.ko@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Aug 2021 09:22:44 -0400
Message-ID: <CADnq5_N8PxXeYKbPaQNRJWKNxxOdhgto1Sh8YcrHU8+dA4+9DA@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform
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

On Wed, Aug 25, 2021 at 9:55 PM Koba Ko <koba.ko@canonical.com> wrote:
>
> AMD polaris GPUs have an issue about audio noise on RKL platform,
> they provide a commit to fix but for SMU7-based GPU still
> need another module parameter,

For future readers, it might be better to provide a bit more detail in
the patch description.  Something like:

"Due to high latency in PCIE gen switching on RKL platforms, disable
PCIE gen switching on polaris
GPUs to avoid HDMI/DP audio issues."

Alex

>
> modprobe amdgpu ppfeaturemask=0xfff7bffb
>
> to avoid the module parameter, switch PCI_DPM by determining
> intel platform in amd drm driver is a better way.
>
> Fixes: 1a31474cdb48 ("drm/amd/pm: workaround for audio noise issue")
> Ref: https://lists.freedesktop.org/archives/amd-gfx/2021-August/067413.html
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> ---
>  .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 0541bfc81c1b..6ce2a2046457 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -27,6 +27,7 @@
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <asm/div64.h>
> +#include <asm/intel-family.h>
>  #include <drm/amdgpu_drm.h>
>  #include "ppatomctrl.h"
>  #include "atombios.h"
> @@ -1733,6 +1734,17 @@ static int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
>         return result;
>  }
>
> +static bool intel_core_rkl_chk(void)
> +{
> +#ifdef CONFIG_X86_64
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
> @@ -1758,7 +1770,8 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
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
