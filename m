Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FC2C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 15:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E3B61090
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 15:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 38E3B61090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D356E027;
	Wed, 22 Sep 2021 15:58:44 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A113A6E027
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 15:58:43 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 l16-20020a9d6a90000000b0053b71f7dc83so4110820otq.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j/C7iU2tDM1dPbLyR3LyTxfi6dlOU+mO6E8CPnp8YqU=;
 b=kyq0Cq8tx3Y1YJr7xFnQfXno4kWgtX4sVOSC2V+y0rMf4gIuUxDVagnD+HyHciXC99
 sNHj3sTRAeV0JC9LUrv18w4bxIeYN75XuAIQmPd1KrX766FeY33MrxnRLyFZMtG8bTsk
 er75jnXywNZf2CkTJpvWq1LN4rsi9/7nUjwAsLAQuN9rAugqmnt39JeSNk4+GzjWBH8Y
 VfnPArbzUYISydm9UyA+cAXIWWSktkhwywXrW/YyZY+FfGSGoELFvc9l+KlH5xpxI4mZ
 GtAiV6I8gOnCyifL4o+5ru8pQ3JT6es8dLl4gLrKZs/68uHH4khp61mIbHAexjNJWMul
 gEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j/C7iU2tDM1dPbLyR3LyTxfi6dlOU+mO6E8CPnp8YqU=;
 b=dZlI5eCJ7256Rp16KWZSwduamO1Q6S9fXMGj4Q/xye0oxsJihCoUY0PLNU6f09J+7M
 gbZsv/1VWxhsq3q6cEjq2/RkF0NvgEW3yr2p2IViZpgRIgZ0cdtkiN/UEhMGe7aNTfOP
 jCbcaaVNS4C0k4vNKOvtYNQ3+ajAekf3AcLZX8ryiOVaDl/CDPK6WC13HwWWs1uW2eSB
 QkHrAJ0wwoRSGVFzeZaeMfHO1qYi0fBM6Ii4fLMpUF3ZqAlW1rx0WazjSH7QiW0ZLkfS
 2BuQaOQo4Xus3sWOVjr9pqlKk0QQR1Qruv7L5tZzN99cfzU746oSWatyS+zmgh4rdU9M
 CFzA==
X-Gm-Message-State: AOAM532VQyh/Zm9gUgxZFZqPhP6t0MspZKwl67J7EOvse4EkXDgawzaZ
 GIDzgeBvBpUWWWdK0ijMSBx4nP+Mh/Gze7/ywMw=
X-Google-Smtp-Source: ABdhPJzRnHwzIaucVlbpCyKPQkCBH/0g/y5bR29PlzC6nLxyT+7CvSify6GXpEed4k2peiWvDdCP9J/EVOu/qeqeB0Q=
X-Received: by 2002:a05:6830:25d3:: with SMTP id
 d19mr444856otu.357.1632326322762; 
 Wed, 22 Sep 2021 08:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-34-alexander.deucher@amd.com>
 <4da2f4b6-d818-5a3e-d600-f8cedb6591cc@amd.com>
In-Reply-To: <4da2f4b6-d818-5a3e-d600-f8cedb6591cc@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Sep 2021 11:58:31 -0400
Message-ID: <CADnq5_MG=Q4szJuQWp27=E7hyuhEzsFOcyhL4tL9moC5QEe3Gw@mail.gmail.com>
Subject: Re: [PATCH 33/66] drm/amdgpu: add initial IP discovery support for
 vega based parts
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Wed, Sep 22, 2021 at 3:54 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 9/21/2021 11:36 PM, Alex Deucher wrote:
> > Hardcode the IP versions for asics without IP discovery tables
> > and then enumerate the asics based on the IP versions.
> >
> > TODO: fix SR-IOV support
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 417 ++++++++++++++++--
> >   1 file changed, 387 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > index 6a993043badc..e3b4578872f1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -26,6 +26,26 @@
> >   #include "soc15_hw_ip.h"
> >   #include "discovery.h"
> >
> > +#include "soc15.h"
> > +#include "gfx_v9_0.h"
> > +#include "gmc_v9_0.h"
> > +#include "df_v1_7.h"
> > +#include "df_v3_6.h"
> > +#include "nbio_v6_1.h"
> > +#include "nbio_v7_0.h"
> > +#include "nbio_v7_4.h"
> > +#include "hdp_v4_0.h"
> > +#include "vega10_ih.h"
> > +#include "vega20_ih.h"
> > +#include "sdma_v4_0.h"
> > +#include "uvd_v7_0.h"
> > +#include "vce_v4_0.h"
> > +#include "vcn_v1_0.h"
> > +#include "vcn_v2_0.h"
> > +#include "jpeg_v2_0.h"
> > +#include "vcn_v2_5.h"
> > +#include "jpeg_v2_5.h"
> > +#include "smuio_v9_0.h"
> >   #include "gmc_v10_0.h"
> >   #include "gfxhub_v2_0.h"
> >   #include "mmhub_v2_0.h"
> > @@ -45,6 +65,7 @@
> >   #include "mes_v10_1.h"
> >   #include "smuio_v11_0.h"
> >   #include "smuio_v11_0_6.h"
> > +#include "smuio_v13_0.h"
> >
> >   #define mmRCC_CONFIG_MEMSIZE        0xde3
> >   #define mmMM_INDEX          0x0
> > @@ -485,23 +506,166 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
> >       return 0;
> >   }
> >
> > -
> >   int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >   {
> >       int r;
> >
> > -     r = amdgpu_discovery_reg_base_init(adev);
> > -     if (r)
> > -             return -EINVAL;
> > +     switch (adev->asic_type) {
> > +     case CHIP_VEGA10:
> > +             vega10_reg_base_init(adev);
> > +             adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 0, 0);
> > +             adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 0, 0);
> > +             adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 0, 0);
> > +             adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 0, 0);
> > +             adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 0, 0);
> > +             adev->ip_versions[DF_HWIP] = IP_VERSION(2, 1, 0);
> > +             adev->ip_versions[NBIO_HWIP] = IP_VERSION(6, 1, 0);
> > +             adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 0, 0);
> > +             adev->ip_versions[MP0_HWIP] = IP_VERSION(9, 0, 0);
> > +             adev->ip_versions[MP1_HWIP] = IP_VERSION(9, 0, 0);
> > +             adev->ip_versions[THM_HWIP] = IP_VERSION(9, 0, 0);
> > +             adev->ip_versions[SMUIO_HWIP] = IP_VERSION(9, 0, 0);
> > +             adev->ip_versions[GC_HWIP] = IP_VERSION(9, 0, 1);
> > +             adev->ip_versions[UVD_HWIP] = IP_VERSION(7, 0, 0);
> > +             adev->ip_versions[VCE_HWIP] = IP_VERSION(4, 0, 0);
> > +             adev->ip_versions[DCI_HWIP] = IP_VERSION(12, 0, 0);
> > +             break;
> > +     case CHIP_VEGA12:
> > +             vega10_reg_base_init(adev);
> > +             adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 3, 0);
> > +             adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 3, 0);
> > +             adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 0, 1);
> > +             adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 0, 1);
> > +             adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 0, 1);
> > +             adev->ip_versions[DF_HWIP] = IP_VERSION(2, 5, 0);
> > +             adev->ip_versions[NBIO_HWIP] = IP_VERSION(6, 2, 0);
> > +             adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 1, 0);
> > +             adev->ip_versions[MP0_HWIP] = IP_VERSION(9, 0, 0);
> > +             adev->ip_versions[MP1_HWIP] = IP_VERSION(9, 0, 0);
> > +             adev->ip_versions[THM_HWIP] = IP_VERSION(9, 0, 0);
> > +             adev->ip_versions[SMUIO_HWIP] = IP_VERSION(9, 0, 1);
> > +             adev->ip_versions[GC_HWIP] = IP_VERSION(9, 2, 1);
> > +             adev->ip_versions[UVD_HWIP] = IP_VERSION(7, 0, 0);
> > +             adev->ip_versions[VCE_HWIP] = IP_VERSION(4, 0, 0);
> > +             adev->ip_versions[DCI_HWIP] = IP_VERSION(12, 0, 1);
> > +             break;
> > +     case CHIP_RAVEN:
> > +             vega10_reg_base_init(adev);
> > +             if (adev->apu_flags & AMD_APU_IS_RAVEN2) {
> > +                     adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 2, 0);
> > +                     adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 2, 0);
> > +                     adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 1, 1);
> > +                     adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 1, 1);
> > +                     adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 1, 1);
> > +                     adev->ip_versions[DF_HWIP] = IP_VERSION(2, 1, 1);
> > +                     adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 0, 1);
> > +                     adev->ip_versions[UMC_HWIP] = IP_VERSION(7, 5, 0);
> > +                     adev->ip_versions[MP0_HWIP] = IP_VERSION(10, 0, 1);
> > +                     adev->ip_versions[MP1_HWIP] = IP_VERSION(10, 0, 1);
> > +                     adev->ip_versions[THM_HWIP] = IP_VERSION(10, 1, 0);
> > +                     adev->ip_versions[SMUIO_HWIP] = IP_VERSION(10, 0, 1);
> > +                     adev->ip_versions[GC_HWIP] = IP_VERSION(9, 2, 2);
> > +                     adev->ip_versions[UVD_HWIP] = IP_VERSION(1, 0, 1);
> > +                     adev->ip_versions[DCE_HWIP] = IP_VERSION(1, 0, 1);
> > +             } else {
> > +                     adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 1, 0);
> > +                     adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 1, 0);
> > +                     adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 1, 0);
> > +                     adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 1, 0);
> > +                     adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 1, 0);
> > +                     adev->ip_versions[DF_HWIP] = IP_VERSION(2, 1, 0);
> > +                     adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 0, 0);
> > +                     adev->ip_versions[UMC_HWIP] = IP_VERSION(7, 0, 0);
> > +                     adev->ip_versions[MP0_HWIP] = IP_VERSION(10, 0, 0);
> > +                     adev->ip_versions[MP1_HWIP] = IP_VERSION(10, 0, 0);
> > +                     adev->ip_versions[THM_HWIP] = IP_VERSION(10, 0, 0);
> > +                     adev->ip_versions[SMUIO_HWIP] = IP_VERSION(10, 0, 0);
> > +                     adev->ip_versions[GC_HWIP] = IP_VERSION(9, 1, 0);
> > +                     adev->ip_versions[UVD_HWIP] = IP_VERSION(1, 0, 0);
> > +                     adev->ip_versions[DCE_HWIP] = IP_VERSION(1, 0, 0);
> > +             }
> > +             break;
> > +     case CHIP_VEGA20:
> > +             vega20_reg_base_init(adev);
> > +             adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 0);
> > +             adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 0);
> > +             adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 2, 0);
> > +             adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 2, 0);
> > +             adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 2, 0);
> > +             adev->ip_versions[DF_HWIP] = IP_VERSION(3, 6, 0);
> > +             adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 4, 0);
> > +             adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 1, 1);
> > +             adev->ip_versions[MP0_HWIP] = IP_VERSION(11, 0, 2);
> > +             adev->ip_versions[MP1_HWIP] = IP_VERSION(11, 0, 2);
> > +             adev->ip_versions[THM_HWIP] = IP_VERSION(11, 0, 2);
> > +             adev->ip_versions[SMUIO_HWIP] = IP_VERSION(11, 0, 2);
> > +             adev->ip_versions[GC_HWIP] = IP_VERSION(9, 4, 0);
> > +             adev->ip_versions[UVD_HWIP] = IP_VERSION(7, 2, 0);
> > +             adev->ip_versions[VCE_HWIP] = IP_VERSION(4, 1, 0);
> > +             adev->ip_versions[DCI_HWIP] = IP_VERSION(12, 1, 0);
> > +             break;
> > +     case CHIP_ARCTURUS:
> > +             arct_reg_base_init(adev);
> > +             adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 1);
> > +             adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 1);
> > +             adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 2, 1);
> > +             adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 2, 1);
> > +             adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 2, 2);
> > +             adev->ip_versions[DF_HWIP] = IP_VERSION(3, 6, 1);
> > +             adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 4, 1);
> > +             adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 1, 2);
> > +             adev->ip_versions[MP0_HWIP] = IP_VERSION(11, 0, 4);
> > +             adev->ip_versions[MP1_HWIP] = IP_VERSION(11, 0, 2);
>
> Just found that this version is shared with VG20. Since it's a soft IP
> version table anyway, any problem in changing to say 11.0.3 and avoid
> ASIC checks?

I thought about that, but wanted to stay consistent with the hw
versions documented internally.

Alex

>
> Thanks,
> Lijo
>
> > +             adev->ip_versions[THM_HWIP] = IP_VERSION(11, 0, 3);
> > +             adev->ip_versions[SMUIO_HWIP] = IP_VERSION(11, 0, 3);
> > +             adev->ip_versions[GC_HWIP] = IP_VERSION(9, 4, 1);
> > +             adev->ip_versions[UVD_HWIP] = IP_VERSION(2, 5, 0);
> > +             break;
> > +     case CHIP_ALDEBARAN:
> > +             aldebaran_reg_base_init(adev);
> > +             adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 2);
> > +             adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 2);
> > +             adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 4, 0);
> > +             adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 4, 0);
> > +             adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 4, 0);
> > +             adev->ip_versions[DF_HWIP] = IP_VERSION(3, 6, 2);
> > +             adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 4, 4);
> > +             adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 7, 0);
> > +             adev->ip_versions[MP0_HWIP] = IP_VERSION(13, 0, 2);
> > +             adev->ip_versions[MP1_HWIP] = IP_VERSION(13, 0, 2);
> > +             adev->ip_versions[THM_HWIP] = IP_VERSION(13, 0, 2);
> > +             adev->ip_versions[SMUIO_HWIP] = IP_VERSION(13, 0, 2);
> > +             adev->ip_versions[GC_HWIP] = IP_VERSION(9, 4, 2);
> > +             adev->ip_versions[UVD_HWIP] = IP_VERSION(2, 6, 0);
> > +             adev->ip_versions[XGMI_HWIP] = IP_VERSION(6, 1, 0);
> > +             break;
> > +     default:
> > +             r = amdgpu_discovery_reg_base_init(adev);
> > +             if (r)
> > +                     return -EINVAL;
> >
> > -     amdgpu_discovery_harvest_ip(adev);
> > +             amdgpu_discovery_harvest_ip(adev);
> >
> > -     if (!adev->mman.discovery_bin) {
> > -             DRM_ERROR("ip discovery uninitialized\n");
> > -             return -EINVAL;
> > +             if (!adev->mman.discovery_bin) {
> > +                     DRM_ERROR("ip discovery uninitialized\n");
> > +                     return -EINVAL;
> > +             }
> > +             break;
> >       }
> >
> >       switch (adev->ip_versions[GC_HWIP]) {
> > +     case IP_VERSION(9, 0, 1):
> > +     case IP_VERSION(9, 2, 1):
> > +     case IP_VERSION(9, 4, 0):
> > +     case IP_VERSION(9, 4, 1):
> > +     case IP_VERSION(9, 4, 2):
> > +             adev->family = AMDGPU_FAMILY_AI;
> > +             break;
> > +     case IP_VERSION(9, 1, 0):
> > +     case IP_VERSION(9, 2, 2):
> > +     case IP_VERSION(9, 3, 0):
> > +             adev->family = AMDGPU_FAMILY_RV;
> > +             break;
> >       case IP_VERSION(10, 1, 10):
> >       case IP_VERSION(10, 1, 1):
> >       case IP_VERSION(10, 1, 2):
> > @@ -527,6 +691,23 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >
> >       /* set NBIO version */
> >       switch (adev->ip_versions[NBIO_HWIP]) {
> > +     case IP_VERSION(6, 1, 0):
> > +     case IP_VERSION(6, 2, 0):
> > +             adev->nbio.funcs = &nbio_v6_1_funcs;
> > +             adev->nbio.hdp_flush_reg = &nbio_v6_1_hdp_flush_reg;
> > +             break;
> > +     case IP_VERSION(7, 0, 0):
> > +     case IP_VERSION(7, 0, 1):
> > +     case IP_VERSION(2, 5, 0):
> > +             adev->nbio.funcs = &nbio_v7_0_funcs;
> > +             adev->nbio.hdp_flush_reg = &nbio_v7_0_hdp_flush_reg;
> > +             break;
> > +     case IP_VERSION(7, 4, 0):
> > +     case IP_VERSION(7, 4, 1):
> > +     case IP_VERSION(7, 4, 4):
> > +             adev->nbio.funcs = &nbio_v7_4_funcs;
> > +             adev->nbio.hdp_flush_reg = &nbio_v7_4_hdp_flush_reg;
> > +             break;
> >       case IP_VERSION(7, 2, 0):
> >       case IP_VERSION(7, 2, 1):
> >       case IP_VERSION(7, 5, 0):
> > @@ -549,6 +730,15 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >       }
> >
> >       switch (adev->ip_versions[HDP_HWIP]) {
> > +     case IP_VERSION(4, 0, 0):
> > +     case IP_VERSION(4, 0, 1):
> > +     case IP_VERSION(4, 1, 0):
> > +     case IP_VERSION(4, 1, 1):
> > +     case IP_VERSION(4, 2, 0):
> > +     case IP_VERSION(4, 2, 1):
> > +     case IP_VERSION(4, 4, 0):
> > +             adev->hdp.funcs = &hdp_v4_0_funcs;
> > +             break;
> >       case IP_VERSION(5, 0, 0):
> >       case IP_VERSION(5, 0, 1):
> >       case IP_VERSION(5, 0, 2):
> > @@ -561,8 +751,34 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >               break;
> >       }
> >
> > +     switch (adev->ip_versions[DF_HWIP]) {
> > +     case IP_VERSION(3, 6, 0):
> > +     case IP_VERSION(3, 6, 1):
> > +     case IP_VERSION(3, 6, 2):
> > +             adev->df.funcs = &df_v3_6_funcs;
> > +             break;
> > +     case IP_VERSION(2, 1, 0):
> > +     case IP_VERSION(2, 1, 1):
> > +     case IP_VERSION(2, 5, 0):
> > +     case IP_VERSION(3, 5, 1):
> > +     case IP_VERSION(3, 5, 2):
> > +             adev->df.funcs = &df_v1_7_funcs;
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> >       switch (adev->ip_versions[SMUIO_HWIP]) {
> > +     case IP_VERSION(9, 0, 0):
> > +     case IP_VERSION(9, 0, 1):
> > +     case IP_VERSION(10, 0, 0):
> > +     case IP_VERSION(10, 0, 1):
> > +     case IP_VERSION(10, 0, 2):
> > +             adev->smuio.funcs = &smuio_v9_0_funcs;
> > +             break;
> >       case IP_VERSION(11, 0, 0):
> > +     case IP_VERSION(11, 0, 2):
> > +     case IP_VERSION(11, 0, 3):
> >       case IP_VERSION(11, 0, 4):
> >       case IP_VERSION(11, 0, 7):
> >       case IP_VERSION(11, 0, 8):
> > @@ -575,12 +791,25 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >       case IP_VERSION(13, 0, 1):
> >               adev->smuio.funcs = &smuio_v11_0_6_funcs;
> >               break;
> > +     case IP_VERSION(13, 0, 2):
> > +             adev->smuio.funcs = &smuio_v13_0_funcs;
> > +             break;
> >       default:
> >               break;
> >       }
> >
> >       /* what IP to use for this? */
> >       switch (adev->ip_versions[GC_HWIP]) {
> > +     case IP_VERSION(9, 0, 1):
> > +     case IP_VERSION(9, 1, 0):
> > +     case IP_VERSION(9, 2, 1):
> > +     case IP_VERSION(9, 2, 2):
> > +     case IP_VERSION(9, 3, 0):
> > +     case IP_VERSION(9, 4, 0):
> > +     case IP_VERSION(9, 4, 1):
> > +     case IP_VERSION(9, 4, 2):
> > +             amdgpu_device_ip_block_add(adev, &vega10_common_ip_block);
> > +             break;
> >       case IP_VERSION(10, 1, 10):
> >       case IP_VERSION(10, 1, 1):
> >       case IP_VERSION(10, 1, 2):
> > @@ -599,6 +828,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >
> >       /* use GC or MMHUB IP version */
> >       switch (adev->ip_versions[GC_HWIP]) {
> > +     case IP_VERSION(9, 0, 1):
> > +     case IP_VERSION(9, 1, 0):
> > +     case IP_VERSION(9, 2, 1):
> > +     case IP_VERSION(9, 2, 2):
> > +     case IP_VERSION(9, 3, 0):
> > +     case IP_VERSION(9, 4, 0):
> > +     case IP_VERSION(9, 4, 1):
> > +     case IP_VERSION(9, 4, 2):
> > +             amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
> > +             break;
> >       case IP_VERSION(10, 1, 10):
> >       case IP_VERSION(10, 1, 1):
> >       case IP_VERSION(10, 1, 2):
> > @@ -616,6 +855,18 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >       }
> >
> >       switch (adev->ip_versions[OSSSYS_HWIP]) {
> > +     case IP_VERSION(4, 0, 0):
> > +     case IP_VERSION(4, 0, 1):
> > +     case IP_VERSION(4, 1, 0):
> > +     case IP_VERSION(4, 1, 1):
> > +     case IP_VERSION(4, 3, 0):
> > +             amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
> > +             break;
> > +     case IP_VERSION(4, 2, 0):
> > +     case IP_VERSION(4, 2, 1):
> > +     case IP_VERSION(4, 4, 0):
> > +             amdgpu_device_ip_block_add(adev, &vega20_ih_ip_block);
> > +             break;
> >       case IP_VERSION(5, 0, 0):
> >       case IP_VERSION(5, 0, 1):
> >       case IP_VERSION(5, 0, 2):
> > @@ -630,7 +881,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >
> >       if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
> >               switch (adev->ip_versions[MP0_HWIP]) {
> > +             case IP_VERSION(9, 0, 0):
> > +                     amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
> > +                     break;
> > +             case IP_VERSION(10, 0, 0):
> > +             case IP_VERSION(10, 0, 1):
> > +                     amdgpu_device_ip_block_add(adev, &psp_v10_0_ip_block);
> > +                     break;
> >               case IP_VERSION(11, 0, 0):
> > +             case IP_VERSION(11, 0, 2):
> > +             case IP_VERSION(11, 0, 4):
> >               case IP_VERSION(11, 0, 5):
> >               case IP_VERSION(11, 0, 9):
> >               case IP_VERSION(11, 0, 7):
> > @@ -643,7 +903,12 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >               case IP_VERSION(11, 0, 8):
> >                       amdgpu_device_ip_block_add(adev, &psp_v11_0_8_ip_block);
> >                       break;
> > +             case IP_VERSION(11, 0, 3):
> > +             case IP_VERSION(12, 0, 1):
> > +                     amdgpu_device_ip_block_add(adev, &psp_v12_0_ip_block);
> > +                     break;
> >               case IP_VERSION(13, 0, 1):
> > +             case IP_VERSION(13, 0, 2):
> >               case IP_VERSION(13, 0, 3):
> >                       amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
> >                       break;
> > @@ -654,6 +919,15 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >
> >       if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
> >               switch (adev->ip_versions[MP1_HWIP]) {
> > +             case IP_VERSION(9, 0, 0):
> > +             case IP_VERSION(10, 0, 0):
> > +             case IP_VERSION(10, 0, 1):
> > +             case IP_VERSION(11, 0, 2):
> > +                     if (adev->asic_type == CHIP_ARCTURUS)
> > +                             amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
> > +                     else
> > +                             amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
> > +                     break;
> >               case IP_VERSION(11, 0, 0):
> >               case IP_VERSION(11, 0, 9):
> >               case IP_VERSION(11, 0, 7):
> > @@ -664,7 +938,12 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >               case IP_VERSION(11, 5, 0):
> >                       amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
> >                       break;
> > +             case IP_VERSION(12, 0, 0):
> > +             case IP_VERSION(12, 0, 1):
> > +                     amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
> > +                     break;
> >               case IP_VERSION(13, 0, 1):
> > +             case IP_VERSION(13, 0, 2):
> >               case IP_VERSION(13, 0, 3):
> >                       amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
> >                       break;
> > @@ -676,10 +955,13 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >       if (adev->enable_virtual_display || amdgpu_sriov_vf(adev)) {
> >               amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
> >   #if defined(CONFIG_DRM_AMD_DC)
> > -     } else {
> > +     } else if (adev->ip_versions[DCE_HWIP]) {
> >               switch (adev->ip_versions[DCE_HWIP]) {
> > +             case IP_VERSION(1, 0, 0):
> > +             case IP_VERSION(1, 0, 1):
> >               case IP_VERSION(2, 0, 2):
> >               case IP_VERSION(2, 0, 0):
> > +             case IP_VERSION(2, 1, 0):
> >               case IP_VERSION(3, 0, 0):
> >               case IP_VERSION(3, 0, 2):
> >               case IP_VERSION(3, 0, 3):
> > @@ -693,10 +975,29 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >               default:
> >                       return -EINVAL;
> >               }
> > -
> > +     } else if (adev->ip_versions[DCI_HWIP]) {
> > +             switch (adev->ip_versions[DCI_HWIP]) {
> > +             case IP_VERSION(12, 0, 0):
> > +             case IP_VERSION(12, 0, 1):
> > +             case IP_VERSION(12, 1, 0):
> > +                     amdgpu_device_ip_block_add(adev, &dm_ip_block);
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> >       }
> >   #endif
> >       switch (adev->ip_versions[GC_HWIP]) {
> > +     case IP_VERSION(9, 0, 1):
> > +     case IP_VERSION(9, 1, 0):
> > +     case IP_VERSION(9, 2, 1):
> > +     case IP_VERSION(9, 2, 2):
> > +     case IP_VERSION(9, 3, 0):
> > +     case IP_VERSION(9, 4, 0):
> > +     case IP_VERSION(9, 4, 1):
> > +     case IP_VERSION(9, 4, 2):
> > +             amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
> > +             break;
> >       case IP_VERSION(10, 1, 10):
> >       case IP_VERSION(10, 1, 2):
> >       case IP_VERSION(10, 1, 1):
> > @@ -714,6 +1015,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >       }
> >
> >       switch (adev->ip_versions[SDMA0_HWIP]) {
> > +     case IP_VERSION(4, 0, 0):
> > +     case IP_VERSION(4, 0, 1):
> > +     case IP_VERSION(4, 1, 0):
> > +     case IP_VERSION(4, 1, 1):
> > +     case IP_VERSION(4, 1, 2):
> > +     case IP_VERSION(4, 2, 0):
> > +     case IP_VERSION(4, 2, 2):
> > +     case IP_VERSION(4, 4, 0):
> > +             amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
> > +             break;
> >       case IP_VERSION(5, 0, 0):
> >       case IP_VERSION(5, 0, 1):
> >       case IP_VERSION(5, 0, 2):
> > @@ -734,6 +1045,15 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >
> >       if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
> >               switch (adev->ip_versions[MP1_HWIP]) {
> > +             case IP_VERSION(9, 0, 0):
> > +             case IP_VERSION(10, 0, 0):
> > +             case IP_VERSION(10, 0, 1):
> > +             case IP_VERSION(11, 0, 2):
> > +                     if (adev->asic_type == CHIP_ARCTURUS)
> > +                             amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
> > +                     else
> > +                             amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
> > +                     break;
> >               case IP_VERSION(11, 0, 0):
> >               case IP_VERSION(11, 0, 9):
> >               case IP_VERSION(11, 0, 7):
> > @@ -744,7 +1064,12 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >               case IP_VERSION(11, 5, 0):
> >                       amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
> >                       break;
> > +             case IP_VERSION(12, 0, 0):
> > +             case IP_VERSION(12, 0, 1):
> > +                     amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
> > +                     break;
> >               case IP_VERSION(13, 0, 1):
> > +             case IP_VERSION(13, 0, 2):
> >               case IP_VERSION(13, 0, 3):
> >                       amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
> >                       break;
> > @@ -753,26 +1078,58 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >               }
> >       }
> >
> > -     switch (adev->ip_versions[UVD_HWIP]) {
> > -     case IP_VERSION(2, 0, 0):
> > -     case IP_VERSION(2, 0, 2):
> > -             amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
> > -             amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
> > -             break;
> > -     case IP_VERSION(2, 0, 3):
> > -             break;
> > -     case IP_VERSION(3, 0, 0):
> > -     case IP_VERSION(3, 0, 16):
> > -     case IP_VERSION(3, 1, 1):
> > -     case IP_VERSION(3, 0, 2):
> > -             amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
> > -             amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
> > -             break;
> > -     case IP_VERSION(3, 0, 33):
> > -             amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
> > -             break;
> > -     default:
> > -             return -EINVAL;
> > +     if (adev->ip_versions[VCE_HWIP]) {
> > +             switch (adev->ip_versions[UVD_HWIP]) {
> > +             case IP_VERSION(7, 0, 0):
> > +             case IP_VERSION(7, 2, 0):
> > +                     amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +             switch (adev->ip_versions[VCE_HWIP]) {
> > +             case IP_VERSION(4, 0, 0):
> > +             case IP_VERSION(4, 1, 0):
> > +                     amdgpu_device_ip_block_add(adev, &vce_v4_0_ip_block);
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +     } else {
> > +             switch (adev->ip_versions[UVD_HWIP]) {
> > +             case IP_VERSION(1, 0, 0):
> > +             case IP_VERSION(1, 0, 1):
> > +                     amdgpu_device_ip_block_add(adev, &vcn_v1_0_ip_block);
> > +                     break;
> > +             case IP_VERSION(2, 0, 0):
> > +             case IP_VERSION(2, 0, 2):
> > +             case IP_VERSION(2, 2, 0):
> > +                     amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
> > +                     amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
> > +                     break;
> > +             case IP_VERSION(2, 0, 3):
> > +                     break;
> > +             case IP_VERSION(2, 5, 0):
> > +                     amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
> > +                     amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
> > +                     break;
> > +             case IP_VERSION(2, 6, 0):
> > +                     amdgpu_device_ip_block_add(adev, &vcn_v2_6_ip_block);
> > +                     amdgpu_device_ip_block_add(adev, &jpeg_v2_6_ip_block);
> > +                     break;
> > +             case IP_VERSION(3, 0, 0):
> > +             case IP_VERSION(3, 0, 16):
> > +             case IP_VERSION(3, 1, 1):
> > +             case IP_VERSION(3, 0, 2):
> > +                     amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
> > +                     amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
> > +                     break;
> > +             case IP_VERSION(3, 0, 33):
> > +                     amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> >       }
> >
> >       if (adev->enable_mes) {
> >
