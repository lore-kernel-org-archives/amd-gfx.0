Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3F3C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 13:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B75460F21
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 13:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B75460F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEE896E859;
	Thu, 26 Aug 2021 13:49:36 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12FAC6E852
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 13:43:51 +0000 (UTC)
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 86A6840791
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 13:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1629985428;
 bh=ZXJQPIF4ZcY4GX2lwaWCHZKGSAQAMeDpPYIOREEKyJk=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=ExxR+DAmH6yyZlFvXB0dCQN896u5oQZvb5thqtAg1h3S55JT4iV31ZDEk/BUcND7K
 PzG5othOwN7+IOO3igk7NX3BGR2eRBi55HLG/rEqzx5OITAvG/XvvEg0iJ0mYTCYCi
 ogCOLOxOQ1QwYhiAixLzx2xzYUEHYCeIR2yMqWaFgHPorQnvhsJlGPleYke1qCUCrB
 ZugJU+gUe1FMoPhatGJGGmt9+5eojTl2OZ7KKsR4wzJnr2oACUPh04p9+tXNTEGLE9
 7LR7t+P/TP3aLnh7FHoXi4qO2iJjxXhrBhQa0tHTiT9EdgdHAsj128UCNwh88AisPf
 AbN1wNqNquuNw==
Received: by mail-ua1-f71.google.com with SMTP id
 x7-20020ab036e7000000b002ae794f3105so819724uau.16
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 06:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZXJQPIF4ZcY4GX2lwaWCHZKGSAQAMeDpPYIOREEKyJk=;
 b=Oeq+lEgJk8LwlommlnHA8UGRQFIp1X0VoxgYtjVYnCtlk4HEoSfYFh2KcFiY5Nzgv5
 ib1XSCkcKguHA2AvI/in+vaq3qhX7aWmwefCEW3aIhCTBIcBVfZs3P3yOT6Eg3V4Orow
 pfScRFF06JgHBxVGSzzawUeYnAlAjq7jA8VXSR6kAEphd8KKMvWNdb1bIMetzIvyQviZ
 vGSRrkhwYkkYidVcnYcKtdHgtMLn0ZDEnEj3YOVQkRLtfmtx1u2zze4SIRvDp9XtdfI+
 ktQun5g9jbVGgQgGUXMetGZ/C6A/4pBv0UaYQyif1Cxm/FbORfxFme2/Km28qP0cJ61Q
 upuw==
X-Gm-Message-State: AOAM530g48y93TvkikC0kwCsUFAudtE2e8/zWtdUN5xGzEYFqm0ndV7e
 9/ZlQImnWFupzPDYHP3BYm5uZVKi817ibFxBzadm44FGNU8l2KoswjvLfw7Xx3hDKH1MKKpK9e1
 YV+NahUQRSLLMIGyo73k8dipHttYNvw601ugnm6nqApNU7ckYlaW5H+Ecv3E=
X-Received: by 2002:a1f:d943:: with SMTP id q64mr2364365vkg.23.1629985426017; 
 Thu, 26 Aug 2021 06:43:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSAqpM8EvcNCb3YckwB+VAKSWaZ3zSYR7U8P0qKU94FlkI8cMRo/3q1h4eLXhQv4z8t2mM1WBwK7+tPCk1IIY=
X-Received: by 2002:a1f:d943:: with SMTP id q64mr2364202vkg.23.1629985424230; 
 Thu, 26 Aug 2021 06:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210826013523.394705-1-koba.ko@canonical.com>
 <20210826013523.394705-2-koba.ko@canonical.com>
 <CADnq5_N8PxXeYKbPaQNRJWKNxxOdhgto1Sh8YcrHU8+dA4+9DA@mail.gmail.com>
In-Reply-To: <CADnq5_N8PxXeYKbPaQNRJWKNxxOdhgto1Sh8YcrHU8+dA4+9DA@mail.gmail.com>
From: Koba Ko <koba.ko@canonical.com>
Date: Thu, 26 Aug 2021 21:43:32 +0800
Message-ID: <CAJB-X+UPDDwPKcztOmAamJ6kKmM18C5LJ3v0-_v9kSSomoNwVA@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 26 Aug 2021 13:49:36 +0000
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

On Thu, Aug 26, 2021, 9:22 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Aug 25, 2021 at 9:55 PM Koba Ko <koba.ko@canonical.com> wrote:
> >
> > AMD polaris GPUs have an issue about audio noise on RKL platform,
> > they provide a commit to fix but for SMU7-based GPU still
> > need another module parameter,
>
> For future readers, it might be better to provide a bit more detail in
> the patch description.  Something like:
>
> "Due to high latency in PCIE gen switching on RKL platforms, disable
> PCIE gen switching on polaris
> GPUs to avoid HDMI/DP audio issues."
>
> Alex

hi Alex,
because I'm not the issue owner and don't know the details, could you
please provide a full description?
I would like to add in the comment.

>
> >
> > modprobe amdgpu ppfeaturemask=0xfff7bffb
> >
> > to avoid the module parameter, switch PCI_DPM by determining
> > intel platform in amd drm driver is a better way.
> >
> > Fixes: 1a31474cdb48 ("drm/amd/pm: workaround for audio noise issue")
> > Ref: https://lists.freedesktop.org/archives/amd-gfx/2021-August/067413.html
> > Signed-off-by: Koba Ko <koba.ko@canonical.com>
> > ---
> >  .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> > index 0541bfc81c1b..6ce2a2046457 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/slab.h>
> >  #include <asm/div64.h>
> > +#include <asm/intel-family.h>
> >  #include <drm/amdgpu_drm.h>
> >  #include "ppatomctrl.h"
> >  #include "atombios.h"
> > @@ -1733,6 +1734,17 @@ static int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
> >         return result;
> >  }
> >
> > +static bool intel_core_rkl_chk(void)
> > +{
> > +#ifdef CONFIG_X86_64
> > +       struct cpuinfo_x86 *c = &cpu_data(0);
> > +
> > +       return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
> > +#else
> > +       return false;
> > +#endif
> > +}
> > +
> >  static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
> >  {
> >         struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
> > @@ -1758,7 +1770,8 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
> >
> >         data->mclk_dpm_key_disabled = hwmgr->feature_mask & PP_MCLK_DPM_MASK ? false : true;
> >         data->sclk_dpm_key_disabled = hwmgr->feature_mask & PP_SCLK_DPM_MASK ? false : true;
> > -       data->pcie_dpm_key_disabled = hwmgr->feature_mask & PP_PCIE_DPM_MASK ? false : true;
> > +       data->pcie_dpm_key_disabled =
> > +               intel_core_rkl_chk() || !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
> >         /* need to set voltage control types before EVV patching */
> >         data->voltage_control = SMU7_VOLTAGE_CONTROL_NONE;
> >         data->vddci_control = SMU7_VOLTAGE_CONTROL_NONE;
> > --
> > 2.25.1
> >
