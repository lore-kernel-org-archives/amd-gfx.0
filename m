Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5BCC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 06:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A0F410E698;
	Mon, 13 Jun 2022 06:08:00 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6345210E6DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 06:07:59 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id me5so9109043ejb.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Jun 2022 23:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=rGKNhhr0UukTtEnNd/htFjC9pzdX6WYbuqW9LOnCIZk=;
 b=ZIB0qTag2ndcCJLO0ghH3TbsILa2/JaPQzfUqhOg4erqnqA6yjeVoFu+vJ5Q1tdsdD
 +NQ0dkYWsI7g1Bcn4HzN1xDOwjC/JGiK6DnJYW34VG+NqqKbTuUmvtI0umFZUToIqkxR
 9VX8SMzvdWcZzR8q4C5dsTk/x2+DcGtKdIVBeqyuh5stY6FWGq87I3ryANcgrZq+az5P
 s23/hFbU0RyQlh2uY5Uz20QclUlinU4u6Rz7YpFt4WsvfPWkmXRRCfOgAeH03PtFN7pT
 490Qw76LFDt1+tFV8g/6PtjeZYwGw7e0wob3u7j8tKbIvk0tp4grn4IfN0ccm8h7mDhq
 8ieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=rGKNhhr0UukTtEnNd/htFjC9pzdX6WYbuqW9LOnCIZk=;
 b=bfgkhD62KfFKEonzDZ7ndRoxBmLF1A+3r60UuUZnrDmRTRJMurZqFET7vxTqQ8I/E9
 7dcgloQ+ui4cpcocZvutxCSvMzYThDPeZietkuWYN5Wl8tHMnMBxxBl0lOLnFGEHlY7i
 d2jywVgKxURYvH9BEKmE/c33Q0gn1bfpX0y2A6QSuvbjJuZxdPe2A6Uz8yegeH48MXgs
 2c1uemU0z0Ospl6uOoCAKl+hQH6D/ocdEoNx9ed0gz+XXs8bzeV9DxTBTH8IogyDcWuo
 af0rN2x1C3+UsB0qXPFPExCJq/UT/FPrkm/U3cGrBWIdoS/sgvnImud5bZdYuD9yl/hf
 r7Og==
X-Gm-Message-State: AOAM532f3cK6fQVLfKDGguEjD+CeeF7Zdi5nYAxKI9Eo+ITu9pyQNt02
 LdK6mL/Zx1HwiiLZsdp6KOlCHMgL2Wk=
X-Google-Smtp-Source: ABdhPJyfRswHTaYSi3TpdYOObQ6Ro1KKpK9JYluWthbPsoyq+hilAbY0uLwaunY1DsAQFGKLJffl0w==
X-Received: by 2002:a17:906:b18f:b0:716:89ce:a724 with SMTP id
 w15-20020a170906b18f00b0071689cea724mr4514364ejy.390.1655100477795; 
 Sun, 12 Jun 2022 23:07:57 -0700 (PDT)
Received: from [192.168.178.21] (p57b0b659.dip0.t-ipconnect.de.
 [87.176.182.89]) by smtp.gmail.com with ESMTPSA id
 d1-20020a056402144100b00431665f1203sm4299796edx.73.2022.06.12.23.07.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jun 2022 23:07:56 -0700 (PDT)
Message-ID: <140c121a-f8b9-d7cc-5b77-c41e90b5829c@gmail.com>
Date: Mon, 13 Jun 2022 08:07:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu/display: make FP handling in Makefiles
 consistent
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20220610154247.338073-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220610154247.338073-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 10.06.22 um 17:42 schrieb Alex Deucher:
> Use the same pattern as the DML Makefile and while we are here
> add a missing x86 guard around the msse flags for DCN3.2.x.

IIRC the idea was to limit the whole float handling to the DML and 
remove it from the rest of the code.

But not sure if that's already completed yet.

Christian.

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile | 3 +--
>   drivers/gpu/drm/amd/display/dc/dcn201/Makefile  | 1 -
>   drivers/gpu/drm/amd/display/dc/dcn30/Makefile   | 6 ++----
>   drivers/gpu/drm/amd/display/dc/dcn302/Makefile  | 8 +++++++-
>   drivers/gpu/drm/amd/display/dc/dcn32/Makefile   | 5 +++--
>   drivers/gpu/drm/amd/display/dc/dcn321/Makefile  | 5 +++--
>   6 files changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> index c935c10b5f4f..7b505e1e9308 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> @@ -180,7 +180,7 @@ CLK_MGR_DCN32 = dcn32_clk_mgr.o dcn32_clk_mgr_smu_msg.o
>   AMD_DAL_CLK_MGR_DCN32 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn32/,$(CLK_MGR_DCN32))
>   
>   ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -msse
> +CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -mhard-float -msse
>   endif
>   
>   ifdef CONFIG_PPC64
> @@ -191,7 +191,6 @@ ifdef CONFIG_CC_IS_GCC
>   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>   IS_OLD_GCC = 1
>   endif
> -CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -mhard-float
>   endif
>   
>   ifdef CONFIG_X86
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> index f68038ceb1b1..96cbd4ccd344 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> @@ -18,7 +18,6 @@ ifdef CONFIG_CC_IS_GCC
>   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>   IS_OLD_GCC = 1
>   endif
> -CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o += -mhard-float
>   endif
>   
>   ifdef CONFIG_X86
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> index dfd77b3cc84d..c20331eb62e0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> @@ -32,8 +32,8 @@ DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
>   
>   
>   ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -msse
> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse
>   endif
>   
>   ifdef CONFIG_PPC64
> @@ -45,8 +45,6 @@ ifdef CONFIG_CC_IS_GCC
>   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>   IS_OLD_GCC = 1
>   endif
> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -mhard-float
> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o += -mhard-float
>   endif
>   
>   ifdef CONFIG_X86
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> index f9561d7f97a1..e4b69ad0dde5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> @@ -8,7 +8,7 @@
>   DCN3_02 = dcn302_init.o dcn302_hwseq.o dcn302_resource.o
>   
>   ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -msse
>   endif
>   
>   ifdef CONFIG_PPC64
> @@ -16,6 +16,12 @@ CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -maltivec
>   endif
>   
>   ifdef CONFIG_X86
> +ifdef CONFIG_CC_IS_GCC
> +ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> +IS_OLD_GCC = 1
> +endif
> +endif
> +
>   ifdef IS_OLD_GCC
>   # Stack alignment mismatch, proceed with caution.
>   # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> index 3d09db3070f4..34f2e37b6704 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> @@ -16,7 +16,7 @@ DCN32 = dcn32_resource.o dcn32_hubbub.o dcn32_hwseq.o dcn32_init.o \
>   		dcn32_mpc.o
>   
>   ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -mhard-float -msse
>   endif
>   
>   ifdef CONFIG_PPC64
> @@ -27,9 +27,9 @@ ifdef CONFIG_CC_IS_GCC
>   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>   IS_OLD_GCC = 1
>   endif
> -CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -mhard-float
>   endif
>   
> +ifdef CONFIG_X86
>   ifdef IS_OLD_GCC
>   # Stack alignment mismatch, proceed with caution.
>   # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> @@ -38,6 +38,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -mpreferred-stack-boundary=4
>   else
>   CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -msse2
>   endif
> +endif
>   
>   AMD_DAL_DCN32 = $(addprefix $(AMDDALPATH)/dc/dcn32/,$(DCN32))
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> index 5896ca303e39..e554fd6c16f2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> @@ -13,7 +13,7 @@
>   DCN321 = dcn321_resource.o dcn321_dio_link_encoder.o
>   
>   ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -mhard-float -msse
>   endif
>   
>   ifdef CONFIG_PPC64
> @@ -24,9 +24,9 @@ ifdef CONFIG_CC_IS_GCC
>   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>   IS_OLD_GCC = 1
>   endif
> -CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -mhard-float
>   endif
>   
> +ifdef CONFIG_X86
>   ifdef IS_OLD_GCC
>   # Stack alignment mismatch, proceed with caution.
>   # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> @@ -35,6 +35,7 @@ CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -mpreferred-stack-boundary=4
>   else
>   CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -msse2
>   endif
> +endif
>   
>   AMD_DAL_DCN321 = $(addprefix $(AMDDALPATH)/dc/dcn321/,$(DCN321))
>   

