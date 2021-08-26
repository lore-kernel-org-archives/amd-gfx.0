Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FDBC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 13:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E107B60F21
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 13:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E107B60F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6579B6E85D;
	Thu, 26 Aug 2021 13:49:37 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9506788FFE
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 09:34:58 +0000 (UTC)
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1086E40791
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 09:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1629970496;
 bh=0znhEzj9vj+U3GtFlNN0nex7PLuhgWbBBX9vS/PxRaY=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=MnTnS5Azrrgs2rwSSxkqwQ9K5r2/0AVbFLRlYdOFNBWqMqlNCj+UNTSlq41zHlIml
 YglENPMlND7AlBmHmPETTlXYIPWZN5+Wr2KL4jKKxfRuGNHDhWQK1EnRHdKNvwgl/5
 Qr9yXUYfmug6e++pDoTsyZQcgp23sXexiWFSZff0rP3Zy2yG/n+vieKJt9RGuG4evU
 yFKb6yxVyQ8K61GKzrkrTCXlMkjAeXSZU/vzkZx60oCnmCO6YF9USUw9KWwmSk/VEr
 NnvXoZB2Cx7goteZOisbD+dBuloqG6NGWnHhSuzc4S73KRLrDajuQQJTnqYeIl+nYW
 KUKNpN+NkzNFg==
Received: by mail-ua1-f71.google.com with SMTP id
 n64-20020ab044c60000b02902ab5cf38d51so631013uan.21
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 02:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0znhEzj9vj+U3GtFlNN0nex7PLuhgWbBBX9vS/PxRaY=;
 b=oEH0uxOigjkFelm6e0O0+5ROnUOpijgbk4E4WBX9Ftmm8x8NGqC0WQooKXfvxX1QNe
 L2KrzHVmYD/MXYDnonMNKdx4fgTRK7EO2lx5hpxyTBJG5tpC8SXTezbyKOfySe0eqPtJ
 +D7uJBJ6hLhd8KnzVV9/A6BWmjbIc51sYYBGXw1slaAFcq6taGllZ07HG+ZaTIB4L1FP
 Q4Px4MeLb/7UrMhVxj1NmSTxuAmSi9jhUWk8gODrN47h3f+zwdFFHKfNR8bM+ljozVhD
 9RqCN1/jmQ+Q38DY8BtSY5n1xuda9+8/h1ClKxsRMPEWnkdb0kcIc1CyhZkN7l1yQ5yY
 A7cg==
X-Gm-Message-State: AOAM532z0wFJ28kf1Z7nglQy7C5D0Tj752rE54hX29Ota42vkekW/KAB
 MybjMQ7RX7Q0Dq47jY5SLYElIAeRdP3QKwIozPO1aMIbr/nUbalh9xNzDdzwulZUeSs/6+jTvRe
 O/ctWc+5brbaSfauTRN6MMF19agEhg+i8j57mZyF1MzubSMaOL90c4KNFJ5E=
X-Received: by 2002:a9f:35ca:: with SMTP id u10mr1354034uad.82.1629970494910; 
 Thu, 26 Aug 2021 02:34:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5a1dJHFZxjENh+dcqOTIx9HMJT68hAQ5GlB/eOjNv/fphw+c9+RumlMivkPsshJEmRiBTaVjayId7azv7EUA=
X-Received: by 2002:a9f:35ca:: with SMTP id u10mr1354027uad.82.1629970494633; 
 Thu, 26 Aug 2021 02:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210826013523.394705-1-koba.ko@canonical.com>
 <20210826013523.394705-2-koba.ko@canonical.com>
 <b95b0e84-8fbc-bdd9-2079-a2dd84dff70f@amd.com>
In-Reply-To: <b95b0e84-8fbc-bdd9-2079-a2dd84dff70f@amd.com>
From: Koba Ko <koba.ko@canonical.com>
Date: Thu, 26 Aug 2021 17:34:43 +0800
Message-ID: <CAJB-X+UBwqYSgm57B+1hhWJYNYoqwPPQrOP+i+cih+qZ8pn4Gg@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 26 Aug 2021 13:49:35 +0000
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

On Thu, Aug 26, 2021 at 5:07 PM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 8/26/2021 7:05 AM, Koba Ko wrote:
> > AMD polaris GPUs have an issue about audio noise on RKL platform,
> > they provide a commit to fix but for SMU7-based GPU still
> > need another module parameter,
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
> >   .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 15 ++++++++++++++-
> >   1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> > index 0541bfc81c1b..6ce2a2046457 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> > @@ -27,6 +27,7 @@
> >   #include <linux/pci.h>
> >   #include <linux/slab.h>
> >   #include <asm/div64.h> > +#include <asm/intel-family.h>
>
> Maybe, include conditionally for X86_64.
>
> >   #include <drm/amdgpu_drm.h>
> >   #include "ppatomctrl.h"
> >   #include "atombios.h"
> > @@ -1733,6 +1734,17 @@ static int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
> >       return result;
> >   }
> >
> > +static bool intel_core_rkl_chk(void)
> > +{
> > +#ifdef CONFIG_X86_64
>
> Better to use IS_ENABLED() here.
>
> Apart from that, looks fine to me.
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks for the comments.
I will send v3.

>
> Thanks,
> Lijo
>
> > +     struct cpuinfo_x86 *c = &cpu_data(0);
> > +
> > +     return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
> > +#else
> > +     return false;
> > +#endif
> > +}
> > +
> >   static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
> >   {
> >       struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
> > @@ -1758,7 +1770,8 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
> >
> >       data->mclk_dpm_key_disabled = hwmgr->feature_mask & PP_MCLK_DPM_MASK ? false : true;
> >       data->sclk_dpm_key_disabled = hwmgr->feature_mask & PP_SCLK_DPM_MASK ? false : true;
> > -     data->pcie_dpm_key_disabled = hwmgr->feature_mask & PP_PCIE_DPM_MASK ? false : true;
> > +     data->pcie_dpm_key_disabled =
> > +             intel_core_rkl_chk() || !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
> >       /* need to set voltage control types before EVV patching */
> >       data->voltage_control = SMU7_VOLTAGE_CONTROL_NONE;
> >       data->vddci_control = SMU7_VOLTAGE_CONTROL_NONE;
> >
