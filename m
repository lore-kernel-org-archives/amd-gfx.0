Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12146C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 12:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD31261139
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 12:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD31261139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC2066E200;
	Wed, 25 Aug 2021 12:34:20 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E97C6E1D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 11:17:04 +0000 (UTC)
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 81D6240798
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 11:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1629890222;
 bh=U9QQFl5Opzoo7vM4oOl3EDgsVMzT1JgHmeDCV1Rl+dE=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=s1ohigfiJebWixlsgJC/cqk5oaGJyOHKho3NHEH8/F3n7BGSGUvfHJqnsRaFTXW4l
 niS94qyjVHgxQk+WBGnfYdCZ3nOWrPvoAcy6/cvBPrEy7Sv1/TnwaPvZgebOTxD+Ef
 qEcatrcPJ7jLAoyC04+rmxP8SqBkQ8yFTk8WWPgE8BjNnZ4yzVgRmHGzBedWImXvTV
 UTG5Of49o0nybPkCvt4kdN+3kYpoqgw9NA+GlJeMiVTWBihsPxgkpoPPmQb0thxMN+
 7TYq/ZIE8kXIPEnp33TGaOcoyuJCogLfe9u7mfi79NF/PEzflV/JnBczzhpFZmdAIt
 nOeOHBMcA+H3g==
Received: by mail-vs1-f72.google.com with SMTP id
 u27-20020a67d99b000000b002c432a98a69so62917vsj.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 04:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U9QQFl5Opzoo7vM4oOl3EDgsVMzT1JgHmeDCV1Rl+dE=;
 b=ZqA/ygA7OEP68Q5rHpgkz4LX3rb6seqqApp2VTHZ8evF8TOPU2lLcTSNduU1SQJs0G
 MouJ9dAsQNW2cfOmSiZ74/fJFm+Q2pmR/ArnUTn0tyhNt8RsOP+XCPfrGfZh8ODXYDfy
 SQeDPyS0zkH7+hiG8Y1IMlxT8lgg7vytcmOmLoFl8puxNDgxRymT1Bj+jFoaadXIVPIc
 RlPElVU21Ca9MWYBubPSIPNQsiikfQLvfdhIk8+HYoHKl7+uj5hPcTr3wdy+bZXY0gg6
 YxfA8lHtJG8c2bOcZihxMP2rWunzhWq7O4Od0aFnNk2DQQuTeHzaKI4wQylO23nYmkYZ
 IXzA==
X-Gm-Message-State: AOAM531DNX0pemLeT0tchxaJZX2nCro/hAOgho5k9snVJnDsCavBqF+8
 Jghv1q2yLjhojsqSCLuB8KeM9YuWVUa7ifwuCwxypqQ/LLWV7WhJ1K9MDJr9+zUaOwpBK+h2sSl
 EtksuKVEaS4qTzYTQmiJK7F42HFr0zDJbctE/Fgim7Udswv0l5OQvH3o4RzQ=
X-Received: by 2002:a1f:4603:: with SMTP id t3mr28784118vka.18.1629890221313; 
 Wed, 25 Aug 2021 04:17:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfQMmGZ+VAjItxBG9b2Zmz5F0+Y1F54Vj1E3z6ZjBS7IBcworuARNWFfikqOgWPUirjD3reZGUYoqB9y6IzRQ=
X-Received: by 2002:a1f:4603:: with SMTP id t3mr28784105vka.18.1629890221023; 
 Wed, 25 Aug 2021 04:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210825043522.346512-1-koba.ko@canonical.com>
 <20210825043522.346512-2-koba.ko@canonical.com> <87y28pev59.fsf@intel.com>
 <CAJB-X+X2Vbj9bAj98yxfAhi2-LMk0=_Hq=b1-1o5iOykQRj5fQ@mail.gmail.com>
 <87sfyxes9b.fsf@intel.com>
In-Reply-To: <87sfyxes9b.fsf@intel.com>
From: Koba Ko <koba.ko@canonical.com>
Date: Wed, 25 Aug 2021 19:16:50 +0800
Message-ID: <CAJB-X+WAS0-O436qbXAHO9Q0GDEoUW8bU7VvgX74fonUiBD1Ew@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 25 Aug 2021 12:34:20 +0000
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

On Wed, Aug 25, 2021 at 6:24 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Wed, 25 Aug 2021, Koba Ko <koba.ko@canonical.com> wrote:
> > On Wed, Aug 25, 2021 at 5:22 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >>
> >> On Wed, 25 Aug 2021, Koba Ko <koba.ko@canonical.com> wrote:
> >> > AMD polaris GPUs have an issue about audio noise on RKL platform,
> >> > they provide a commit to fix but for SMU7-based GPU still
> >> > need another module parameter,
> >> >
> >> > For avoiding the module parameter, switch PCI_DPM by determining
> >> > intel platform in amd drm driver.
> >>
> >> I'll just note that you could have a Tiger Lake PCH combined with a
> >> number of platforms other than Rocket Lake, including not just the
> >> obvious Tiger Lake but also Sky Lake, Kaby Lake, Coffee Lake, and Comet
> >> Lake.
> >>
> >> Again, I don't know what the root cause or fix should be, the workaround
> >> presented here impacts a much larger number of platforms than where
> >> you're claiming the issue is.
> >
> > Hi Jani, thanks for your feedback.
> > Is there any way to identify the RKL PCH?
> > I trace the intel_pch.c and can't find the only pch id for RKL.
> >
> > INTEL_PCH_TGP_DEVICE_ID_TYPE is used by both TGL and RKL.
> >
> > so it seems that using IS_ROCKETLAKE() is the only way.
>
> I don't think there is a Rocket Lake PCH. But is the problem related to
> the PCH or not?

I thought its' not because the issue wouldn't be observed on the TGL platform.
I only tried RKL platform and it use
INTEL_PCH_TGP_DEVICE_ID_TYPE/INTEL_PCH_TGP2_DEVICE_ID_TYPE,
As per AMD guys, they said the issue is only triggered in RKL platform.

>
> The GPU PCI IDs are in i915_pciids.h. See INTEL_RKL_IDS() for
> RKL. There's a lot of indirection, but that's what IS_ROCKETLAKE() boils
> down to. But again, I'm not sure if that's what you want or not.
Thanks for suggestions,

Just want a way to check if it's a RKL platform,
After tracing the kernel, can check by CPU VENDOR(lacks type), check
igpu(but there're cpus without igpu)
and check pch type(it seems one pch has multiple combinations with CPU).
for check igpu, as per my current understanding,  only found RKL CPU with igpu.
Is there a RKL CPU without integrated gpu?

>
> BR,
> Jani.
>
>
> >
> > Thanks
> >>
> >> BR,
> >> Jani.
> >>
> >>
> >> >
> >> > Fixes: 1a31474cdb48 ("drm/amd/pm: workaround for audio noise issue")
> >> > Ref: https://lists.freedesktop.org/archives/amd-gfx/2021-August/067413.html
> >> > Signed-off-by: Koba Ko <koba.ko@canonical.com>
> >> > ---
> >> >  .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 21 ++++++++++++++++++-
> >> >  1 file changed, 20 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> >> > index 0541bfc81c1b..346110dd0f51 100644
> >> > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> >> > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> >> > @@ -1733,6 +1733,25 @@ static int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
> >> >       return result;
> >> >  }
> >> >
> >> > +#include <drm/intel_pch.h>
> >> > +
> >> > +static bool intel_tgp_chk(void)
> >> > +{
> >> > +     struct pci_dev *pch = NULL;
> >> > +     unsigned short id;
> >> > +
> >> > +     while ((pch = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, pch))) {
> >> > +             if (pch->vendor != PCI_VENDOR_ID_INTEL)
> >> > +                     continue;
> >> > +
> >> > +             id = pch->device & INTEL_PCH_DEVICE_ID_MASK;
> >> > +             if (id == INTEL_PCH_TGP_DEVICE_ID_TYPE || INTEL_PCH_TGP2_DEVICE_ID_TYPE)
> >>
> >> PS. This is always true. ;)
> >
> > got, thanks
> >
> >>
> >> > +                     return true;
> >> > +     }
> >> > +
> >> > +     return false;
> >> > +}
> >> > +
> >> >  static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
> >> >  {
> >> >       struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
> >> > @@ -1758,7 +1777,7 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
> >> >
> >> >       data->mclk_dpm_key_disabled = hwmgr->feature_mask & PP_MCLK_DPM_MASK ? false : true;
> >> >       data->sclk_dpm_key_disabled = hwmgr->feature_mask & PP_SCLK_DPM_MASK ? false : true;
> >> > -     data->pcie_dpm_key_disabled = hwmgr->feature_mask & PP_PCIE_DPM_MASK ? false : true;
> >> > +     data->pcie_dpm_key_disabled = intel_tgp_chk() || !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
> >> >       /* need to set voltage control types before EVV patching */
> >> >       data->voltage_control = SMU7_VOLTAGE_CONTROL_NONE;
> >> >       data->vddci_control = SMU7_VOLTAGE_CONTROL_NONE;
> >>
> >> --
> >> Jani Nikula, Intel Open Source Graphics Center
>
> --
> Jani Nikula, Intel Open Source Graphics Center
