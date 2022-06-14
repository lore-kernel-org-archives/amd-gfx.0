Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDEFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jun 2022 13:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2AB5112006;
	Tue, 14 Jun 2022 13:30:44 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4D1F10FFFE
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 13:30:43 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 f2-20020a4a8f42000000b0035e74942d42so1744189ool.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 06:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LDwOg6CdUW4yZQixWxnqJhsFvY9Q5z8gbQ+qzkTzac4=;
 b=YpD0VGb7sYYzB2pZXEDvIqpgiQxCMYXc6Q7bxSnw9ISwJvyKo1WlsGf2pnVrNdK6xY
 i54Us4Ii5/Iyvv74syWnHP5o1Mxztn9RLNeYAlCxOqzv+myMAQamdT5nP/7gEINf+dXl
 vxMsbBwF6yttQjiFWnvdNMonxyAOVJ7+bXY0NIInSbUz+KS3Syex/7FnGTS6krp1Mmeh
 K0FJUKptyyHnyHvmQsh2RSMLrhrLn3oej4nBTm0zkzC/QSkS+Oo/WjRq3vdDakvls2L+
 W9z5RWjIJYqJ5CVU0x0Ar4TY3GKr3Web/m8FSFAAAWeJ99N19AreuRAtMuQX1D6aclON
 FTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LDwOg6CdUW4yZQixWxnqJhsFvY9Q5z8gbQ+qzkTzac4=;
 b=a8SBVVA+FQWO42VpO2TJUIZOu05nFu34Yjhs/HkUbKicLU5wckQyMvE58RUcwLlFHS
 nu5+ollCNcTjOZzGVPTbghx/BXp23Jh2Z/gGWyQroCneyTLXVY1VNdVRybZ85LnSbQ4O
 q+dOZ0oK1YSZbcdDbQ1VGVVIJcvzdbOKzRDqiY3Y+q3dTZWm8Eb4TrtgsgzlFY/B1lfM
 82uqKaXdid9onu2syul5kzblmpdk7FuCTQ6tTAZYodWcV3JicRl+2x5zT/VoVEDcI9gW
 yiWyEC6WJNBg7LYEpxj0X1S2blKM8gjhF8QVFzUgTX4HwnSTZN7YFxHgiFHoHwqtbjuv
 z/Fg==
X-Gm-Message-State: AOAM530edC/iGlgSgcdaalub2n5EVZEA68r/5ZvlB0qEm/yp0tAHIMpy
 eOR45s9Mm7p6+kc3uvRSTp2Ntoaut8sJUR3+4KUmMwrS
X-Google-Smtp-Source: ABdhPJwHiWXeR8P3X/MiPfNfsvcEVCEWbyxaHrmVxh60IXN5jQiCCeqeV9oOr+lXM0QLIXHaBV+ADV06K/zP0lWCpeQ=
X-Received: by 2002:a4a:d382:0:b0:41c:1484:100c with SMTP id
 i2-20020a4ad382000000b0041c1484100cmr1433757oos.68.1655213442762; Tue, 14 Jun
 2022 06:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220610154247.338073-1-alexander.deucher@amd.com>
 <CADnq5_NRFXCNFJ-rXnPgs=e-NbhtfL85zdOxkwLOAmnX0n10Jw@mail.gmail.com>
In-Reply-To: <CADnq5_NRFXCNFJ-rXnPgs=e-NbhtfL85zdOxkwLOAmnX0n10Jw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jun 2022 09:30:31 -0400
Message-ID: <CADnq5_NwbEsm_h0G1iFDsQ8mXQcemGjctasfVNzE7x+0Yf60LQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: make FP handling in Makefiles
 consistent
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Anyone?  This fixes the build on non-x86.

Alex

On Mon, Jun 13, 2022 at 9:52 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Ping?
>
> On Fri, Jun 10, 2022 at 11:43 AM Alex Deucher <alexander.deucher@amd.com> wrote:
> >
> > Use the same pattern as the DML Makefile and while we are here
> > add a missing x86 guard around the msse flags for DCN3.2.x.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile | 3 +--
> >  drivers/gpu/drm/amd/display/dc/dcn201/Makefile  | 1 -
> >  drivers/gpu/drm/amd/display/dc/dcn30/Makefile   | 6 ++----
> >  drivers/gpu/drm/amd/display/dc/dcn302/Makefile  | 8 +++++++-
> >  drivers/gpu/drm/amd/display/dc/dcn32/Makefile   | 5 +++--
> >  drivers/gpu/drm/amd/display/dc/dcn321/Makefile  | 5 +++--
> >  6 files changed, 16 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> > index c935c10b5f4f..7b505e1e9308 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> > @@ -180,7 +180,7 @@ CLK_MGR_DCN32 = dcn32_clk_mgr.o dcn32_clk_mgr_smu_msg.o
> >  AMD_DAL_CLK_MGR_DCN32 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn32/,$(CLK_MGR_DCN32))
> >
> >  ifdef CONFIG_X86
> > -CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -msse
> > +CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -mhard-float -msse
> >  endif
> >
> >  ifdef CONFIG_PPC64
> > @@ -191,7 +191,6 @@ ifdef CONFIG_CC_IS_GCC
> >  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> >  IS_OLD_GCC = 1
> >  endif
> > -CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -mhard-float
> >  endif
> >
> >  ifdef CONFIG_X86
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> > index f68038ceb1b1..96cbd4ccd344 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> > @@ -18,7 +18,6 @@ ifdef CONFIG_CC_IS_GCC
> >  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> >  IS_OLD_GCC = 1
> >  endif
> > -CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o += -mhard-float
> >  endif
> >
> >  ifdef CONFIG_X86
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> > index dfd77b3cc84d..c20331eb62e0 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> > @@ -32,8 +32,8 @@ DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
> >
> >
> >  ifdef CONFIG_X86
> > -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -msse
> > -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -msse
> > +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
> > +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse
> >  endif
> >
> >  ifdef CONFIG_PPC64
> > @@ -45,8 +45,6 @@ ifdef CONFIG_CC_IS_GCC
> >  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> >  IS_OLD_GCC = 1
> >  endif
> > -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -mhard-float
> > -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o += -mhard-float
> >  endif
> >
> >  ifdef CONFIG_X86
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> > index f9561d7f97a1..e4b69ad0dde5 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> > @@ -8,7 +8,7 @@
> >  DCN3_02 = dcn302_init.o dcn302_hwseq.o dcn302_resource.o
> >
> >  ifdef CONFIG_X86
> > -CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -msse
> > +CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -msse
> >  endif
> >
> >  ifdef CONFIG_PPC64
> > @@ -16,6 +16,12 @@ CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -maltivec
> >  endif
> >
> >  ifdef CONFIG_X86
> > +ifdef CONFIG_CC_IS_GCC
> > +ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> > +IS_OLD_GCC = 1
> > +endif
> > +endif
> > +
> >  ifdef IS_OLD_GCC
> >  # Stack alignment mismatch, proceed with caution.
> >  # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> > index 3d09db3070f4..34f2e37b6704 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> > @@ -16,7 +16,7 @@ DCN32 = dcn32_resource.o dcn32_hubbub.o dcn32_hwseq.o dcn32_init.o \
> >                 dcn32_mpc.o
> >
> >  ifdef CONFIG_X86
> > -CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -msse
> > +CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -mhard-float -msse
> >  endif
> >
> >  ifdef CONFIG_PPC64
> > @@ -27,9 +27,9 @@ ifdef CONFIG_CC_IS_GCC
> >  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> >  IS_OLD_GCC = 1
> >  endif
> > -CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -mhard-float
> >  endif
> >
> > +ifdef CONFIG_X86
> >  ifdef IS_OLD_GCC
> >  # Stack alignment mismatch, proceed with caution.
> >  # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> > @@ -38,6 +38,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -mpreferred-stack-boundary=4
> >  else
> >  CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -msse2
> >  endif
> > +endif
> >
> >  AMD_DAL_DCN32 = $(addprefix $(AMDDALPATH)/dc/dcn32/,$(DCN32))
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> > index 5896ca303e39..e554fd6c16f2 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> > @@ -13,7 +13,7 @@
> >  DCN321 = dcn321_resource.o dcn321_dio_link_encoder.o
> >
> >  ifdef CONFIG_X86
> > -CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -msse
> > +CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -mhard-float -msse
> >  endif
> >
> >  ifdef CONFIG_PPC64
> > @@ -24,9 +24,9 @@ ifdef CONFIG_CC_IS_GCC
> >  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> >  IS_OLD_GCC = 1
> >  endif
> > -CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -mhard-float
> >  endif
> >
> > +ifdef CONFIG_X86
> >  ifdef IS_OLD_GCC
> >  # Stack alignment mismatch, proceed with caution.
> >  # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> > @@ -35,6 +35,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -mpreferred-stack-boundary=4
> >  else
> >  CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -msse2
> >  endif
> > +endif
> >
> >  AMD_DAL_DCN321 = $(addprefix $(AMDDALPATH)/dc/dcn321/,$(DCN321))
> >
> > --
> > 2.35.3
> >
