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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CCAC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 13:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE12660F21
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 13:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE12660F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B77D6E852;
	Thu, 26 Aug 2021 13:49:25 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E36256E852
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 13:49:23 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 v33-20020a0568300921b0290517cd06302dso3506663ott.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 06:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5MqZ3FnG3JvhR2xYpRFWBSTA0QcVh19z5qBDZtxcnzQ=;
 b=eSgLR5nxR/hyjChfQziCGqj2HxfXzq+APWEyfU9xTUMcEmcOJshBjt6tiGIQWMx0BW
 h11SwevPpDa0y7EqAW2vfD64jOnVtMG0taEp0pzH/MzzKll5rrajWVQu1jIUFt0Qzs/A
 IO+cnByGSUUHzgq4XgH8W59KJdlR+2d4JS158OXDxfYQfV6/sxXRS7xDUwun4Y2M/lDE
 sGNiHIRRyxo+2CHuneh587zHI4iqdG9krPHXAzFYh0OgY4eaeznL42db8g/HmLELGagy
 2ZDolgNi1SzESdJnziaMJAuBuesHsiX/3CgVg/bQ4sdib/29nwJq/vxwSCUYT1elcEhO
 quOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5MqZ3FnG3JvhR2xYpRFWBSTA0QcVh19z5qBDZtxcnzQ=;
 b=ILhO5+84bTgHDwnLG3raTG7l0xGGH26rDJa7pMRYHY+U0wJ9ByEI3VB59dofQ3oTrN
 xMhpk4VikrfEzjjaRyyz5HVLrmCxZoscmaEZt5o3HqSNfjPx742c5ZniMyHUwlYk0Ihz
 C7sPwBfuPMYS5PhnyyPebHn6Br8TaHOVAswcdu2RqoTw63xEOtefR+4+Jmxx4P2PIAp9
 cVwGjjZqzAlQQKyAZcWlSXjwllP8yyNQbaDSWa0rRFGcpisO40qx2ohiQDDEXUXi1yyY
 YArbtRWpEAe5O0EFoO1e+W3ewFQUjRhlpyJyDPlyplHvyTkFoJjewdveRkh4TFy0G9KN
 eRDQ==
X-Gm-Message-State: AOAM532fsfnBAAWdd3O1+l/6yTkgQuMJf90nSohZlxV55EkyKcVJEUV6
 V+TSCRzllOvVNEroeKTJXQzMmE1mk4E/0oCsQxnbpNrORrE=
X-Google-Smtp-Source: ABdhPJzlmqKbPYu2muvW50kahXch+rN3amglw2TawUcUKEknxD1X6SDEOEdSC+C3ws0+Tl0N62qIYivZA8woAX10ZUk=
X-Received: by 2002:a05:6830:1c69:: with SMTP id
 s9mr3372916otg.132.1629985763254; 
 Thu, 26 Aug 2021 06:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210826013523.394705-1-koba.ko@canonical.com>
 <20210826013523.394705-2-koba.ko@canonical.com>
 <CADnq5_N8PxXeYKbPaQNRJWKNxxOdhgto1Sh8YcrHU8+dA4+9DA@mail.gmail.com>
 <CAJB-X+UPDDwPKcztOmAamJ6kKmM18C5LJ3v0-_v9kSSomoNwVA@mail.gmail.com>
In-Reply-To: <CAJB-X+UPDDwPKcztOmAamJ6kKmM18C5LJ3v0-_v9kSSomoNwVA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Aug 2021 09:49:12 -0400
Message-ID: <CADnq5_Nh1x_rQF6-t1fxj=ma9WKiNRbKnP=MOv-g7woGvCzeKg@mail.gmail.com>
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

On Thu, Aug 26, 2021 at 9:43 AM Koba Ko <koba.ko@canonical.com> wrote:
>
> On Thu, Aug 26, 2021, 9:22 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Wed, Aug 25, 2021 at 9:55 PM Koba Ko <koba.ko@canonical.com> wrote:
> > >
> > > AMD polaris GPUs have an issue about audio noise on RKL platform,
> > > they provide a commit to fix but for SMU7-based GPU still
> > > need another module parameter,
> >
> > For future readers, it might be better to provide a bit more detail in
> > the patch description.  Something like:
> >
> > "Due to high latency in PCIE gen switching on RKL platforms, disable
> > PCIE gen switching on polaris
> > GPUs to avoid HDMI/DP audio issues."
> >
> > Alex
>
> hi Alex,
> because I'm not the issue owner and don't know the details, could you
> please provide a full description?
> I would like to add in the comment.

How about this:

Due to high latency in PCIE clock switching on RKL platforms,
switching the PCIE clock dynamically at runtime can lead to HDMI/DP
audio problems.  On newer asics this is handled in the SMU firmware.
For SMU7-based asics, disable PCIE clock switching to avoid the issue.

Alex

>
> >
> > >
> > > modprobe amdgpu ppfeaturemask=0xfff7bffb
> > >
> > > to avoid the module parameter, switch PCI_DPM by determining
> > > intel platform in amd drm driver is a better way.
> > >
> > > Fixes: 1a31474cdb48 ("drm/amd/pm: workaround for audio noise issue")
> > > Ref: https://lists.freedesktop.org/archives/amd-gfx/2021-August/067413.html
> > > Signed-off-by: Koba Ko <koba.ko@canonical.com>
> > > ---
> > >  .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 15 ++++++++++++++-
> > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> > > index 0541bfc81c1b..6ce2a2046457 100644
> > > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> > > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> > > @@ -27,6 +27,7 @@
> > >  #include <linux/pci.h>
> > >  #include <linux/slab.h>
> > >  #include <asm/div64.h>
> > > +#include <asm/intel-family.h>
> > >  #include <drm/amdgpu_drm.h>
> > >  #include "ppatomctrl.h"
> > >  #include "atombios.h"
> > > @@ -1733,6 +1734,17 @@ static int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
> > >         return result;
> > >  }
> > >
> > > +static bool intel_core_rkl_chk(void)
> > > +{
> > > +#ifdef CONFIG_X86_64
> > > +       struct cpuinfo_x86 *c = &cpu_data(0);
> > > +
> > > +       return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
> > > +#else
> > > +       return false;
> > > +#endif
> > > +}
> > > +
> > >  static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
> > >  {
> > >         struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
> > > @@ -1758,7 +1770,8 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
> > >
> > >         data->mclk_dpm_key_disabled = hwmgr->feature_mask & PP_MCLK_DPM_MASK ? false : true;
> > >         data->sclk_dpm_key_disabled = hwmgr->feature_mask & PP_SCLK_DPM_MASK ? false : true;
> > > -       data->pcie_dpm_key_disabled = hwmgr->feature_mask & PP_PCIE_DPM_MASK ? false : true;
> > > +       data->pcie_dpm_key_disabled =
> > > +               intel_core_rkl_chk() || !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
> > >         /* need to set voltage control types before EVV patching */
> > >         data->voltage_control = SMU7_VOLTAGE_CONTROL_NONE;
> > >         data->vddci_control = SMU7_VOLTAGE_CONTROL_NONE;
> > > --
> > > 2.25.1
> > >
