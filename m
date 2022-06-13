Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C1EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 13:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FF6810E7E6;
	Mon, 13 Jun 2022 13:52:13 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA64A10E7E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 13:52:11 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id w16so7807288oie.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 06:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Fp1cDnXgOIWqir0CMfVfAFuQ1aAfw7Z4rzEujTjvR1o=;
 b=MEXGMjkrjWvrpMPTXfttCaD2NFO1dNPHsG9NE+VvBxPBddzAi2IXtZ2vSNbHqU2oa5
 GnpOLK6bD7W0/nhzDQEEVBri72zvH3lNIHaVtkCYbZI9hnpgCT1hOglKDUPnx49O9sLV
 Fp6nkUc19AzxxaUKueLdOmyVCPYFaQpFH/tVStsb+mxBDZmpdmluYL6SJcKRyW5e8+yi
 3FRMBizhTHtBTB56yuU2vuiU/QRrkc6KkGI0kUNYui6kQRnoKlrJW74ahanbFKYvQ24S
 iGkAaPi2Q/U4obeuT7eIx8ETVu031PoatxGJ0qHaU2Fge3horQgRhyuwsaHB2qRPSyvG
 ntgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Fp1cDnXgOIWqir0CMfVfAFuQ1aAfw7Z4rzEujTjvR1o=;
 b=CsZVh9NhaXnPeiuyB4FA/1PGOGB21XIMGu3SuE87x0w1IYxyyPHn7b+E3FlQCjNv1L
 G2SvO9G1kcoBvc1ZtNpSLnKMMNftyH2L8FFITlcdRulbNnj4Kg6lBydKxArxrpIawMfC
 W9qos15vPWLSHPxHtm0fYcsmV90c+/Eul+HU8AgvwO81Vi9v3e2+iN+14VTb0oji3G2M
 TaZa9uKrOkOq4UnPNUffK9EZAlN1vE42giC/JFRXbDK+MoycGusIp9klpAXMXTHvMP+w
 BJKREsNyYKEsuhPoB1ocGokLsjHdUsOylS2Tf7WxPL8x7HXp/pc+9GBU5ID6TTWdZrfS
 +hXw==
X-Gm-Message-State: AOAM532ZWyHBrkFB8ju/URF4EWG+f1QZW5Ah9+4kIkpb2ICjPGAO6Lyf
 C2h6GYoOZ61TBM938h5NDumP4e4oHM1VQsY6Ee4=
X-Google-Smtp-Source: ABdhPJxbL/MRzApceF7ivG2hJwUeqEAgdakUX++s8eXXnh79QjFv+61OT/g2nTMUYnTVL2TXKn1gtuJSGliFu/XZp9s=
X-Received: by 2002:a05:6808:114f:b0:32b:1be0:2316 with SMTP id
 u15-20020a056808114f00b0032b1be02316mr6436113oiu.200.1655128331037; Mon, 13
 Jun 2022 06:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220610154247.338073-1-alexander.deucher@amd.com>
In-Reply-To: <20220610154247.338073-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jun 2022 09:52:00 -0400
Message-ID: <CADnq5_NRFXCNFJ-rXnPgs=e-NbhtfL85zdOxkwLOAmnX0n10Jw@mail.gmail.com>
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

Ping?

On Fri, Jun 10, 2022 at 11:43 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Use the same pattern as the DML Makefile and while we are here
> add a missing x86 guard around the msse flags for DCN3.2.x.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile | 3 +--
>  drivers/gpu/drm/amd/display/dc/dcn201/Makefile  | 1 -
>  drivers/gpu/drm/amd/display/dc/dcn30/Makefile   | 6 ++----
>  drivers/gpu/drm/amd/display/dc/dcn302/Makefile  | 8 +++++++-
>  drivers/gpu/drm/amd/display/dc/dcn32/Makefile   | 5 +++--
>  drivers/gpu/drm/amd/display/dc/dcn321/Makefile  | 5 +++--
>  6 files changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> index c935c10b5f4f..7b505e1e9308 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> @@ -180,7 +180,7 @@ CLK_MGR_DCN32 = dcn32_clk_mgr.o dcn32_clk_mgr_smu_msg.o
>  AMD_DAL_CLK_MGR_DCN32 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn32/,$(CLK_MGR_DCN32))
>
>  ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -msse
> +CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -mhard-float -msse
>  endif
>
>  ifdef CONFIG_PPC64
> @@ -191,7 +191,6 @@ ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> -CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -mhard-float
>  endif
>
>  ifdef CONFIG_X86
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> index f68038ceb1b1..96cbd4ccd344 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> @@ -18,7 +18,6 @@ ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> -CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o += -mhard-float
>  endif
>
>  ifdef CONFIG_X86
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> index dfd77b3cc84d..c20331eb62e0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> @@ -32,8 +32,8 @@ DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
>
>
>  ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -msse
> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse
>  endif
>
>  ifdef CONFIG_PPC64
> @@ -45,8 +45,6 @@ ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -mhard-float
> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o += -mhard-float
>  endif
>
>  ifdef CONFIG_X86
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> index f9561d7f97a1..e4b69ad0dde5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> @@ -8,7 +8,7 @@
>  DCN3_02 = dcn302_init.o dcn302_hwseq.o dcn302_resource.o
>
>  ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -msse
>  endif
>
>  ifdef CONFIG_PPC64
> @@ -16,6 +16,12 @@ CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -maltivec
>  endif
>
>  ifdef CONFIG_X86
> +ifdef CONFIG_CC_IS_GCC
> +ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> +IS_OLD_GCC = 1
> +endif
> +endif
> +
>  ifdef IS_OLD_GCC
>  # Stack alignment mismatch, proceed with caution.
>  # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> index 3d09db3070f4..34f2e37b6704 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> @@ -16,7 +16,7 @@ DCN32 = dcn32_resource.o dcn32_hubbub.o dcn32_hwseq.o dcn32_init.o \
>                 dcn32_mpc.o
>
>  ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -mhard-float -msse
>  endif
>
>  ifdef CONFIG_PPC64
> @@ -27,9 +27,9 @@ ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> -CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -mhard-float
>  endif
>
> +ifdef CONFIG_X86
>  ifdef IS_OLD_GCC
>  # Stack alignment mismatch, proceed with caution.
>  # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> @@ -38,6 +38,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -mpreferred-stack-boundary=4
>  else
>  CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -msse2
>  endif
> +endif
>
>  AMD_DAL_DCN32 = $(addprefix $(AMDDALPATH)/dc/dcn32/,$(DCN32))
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> index 5896ca303e39..e554fd6c16f2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> @@ -13,7 +13,7 @@
>  DCN321 = dcn321_resource.o dcn321_dio_link_encoder.o
>
>  ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -mhard-float -msse
>  endif
>
>  ifdef CONFIG_PPC64
> @@ -24,9 +24,9 @@ ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> -CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -mhard-float
>  endif
>
> +ifdef CONFIG_X86
>  ifdef IS_OLD_GCC
>  # Stack alignment mismatch, proceed with caution.
>  # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> @@ -35,6 +35,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -mpreferred-stack-boundary=4
>  else
>  CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -msse2
>  endif
> +endif
>
>  AMD_DAL_DCN321 = $(addprefix $(AMDDALPATH)/dc/dcn321/,$(DCN321))
>
> --
> 2.35.3
>
