Return-Path: <SRS0=bavc=6T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E437C47247
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 15:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 701B9206B9
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 15:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="V3zxz3Ro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701B9206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 254B66E7D9;
	Tue,  5 May 2020 15:50:44 +0000 (UTC)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94D276E5D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2020 15:48:49 +0000 (UTC)
Received: by mail-pg1-x541.google.com with SMTP id s8so1250464pgq.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2020 08:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nM/a1FepYTfbkMrKI3vIR1lNGJ72CBefKVP3/JZIHXY=;
 b=V3zxz3RoRcV4XcGG/nIKdTOXlXD48jyMwltpXd49vu+/cH8gzV/KVIF/XscLHQs4yt
 WSaHm8hKTeUiUJw9u0xsAuxeoTRcilZXrxJuKgc/C/QNylpCD2f0f+lyOTX+qmrdi3wb
 F39vPLJPZF4hPUD49GJZ5HlSTHsliK0wErZlK+eq3dZzz2H1uAXvWL1mq6/mnwbCYHrc
 evjonFrybtwVM21q0sbrQZTwjWO4wjTpeFSWDlDc6gLrRcgFyK5TnaPAv5nz9EUnh2fe
 bxPw4R4YTHpwJLk9igT1vOwGkbGessoDwgGmon792+t6hITyJ2TwZ5RFYVoaGKbXKatJ
 oWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nM/a1FepYTfbkMrKI3vIR1lNGJ72CBefKVP3/JZIHXY=;
 b=DThtltCm0qJxub5UVXDLRMUxEOJWJv0B5XYGTyCSiYY3iv6a+hN4gLfr10Jh8gmxIP
 79lpHj2KxByi20GGUw1WLj8q4zVJYbCnjjqXq8W4Sh6oiDWffevHh5WWwh1IuIZLfn7Q
 dsq2ziGxmzIrqwzTRGa9um8l9EvdKmdtK087oqnwzcQaMxZIgtBFY1oIdiEoMron7GIb
 Aks1ebdqZ2WQ79qci/i3PDjE2xv54B1oi3YRO9wUESIgHCCrOOykaBC51Efmzcqql9/7
 HZJejlJ5SR5S+Vs6EVLqneeLVfiMYVFyHfA5M+/e+CVj5W7jZwYLQe4T4BeUz8AwQtNp
 nyyA==
X-Gm-Message-State: AGi0PuadVUUDqqrl0m+TQ4EAwTY/j0ln7xJirN4d3mpGPztXqOjCeAYr
 dHAIR1jq1dr3heThrA7E6rBOXzrH881xK0WqGDMQOA==
X-Google-Smtp-Source: APiQypJLl6xf4mRfh1BGf7W7IqcP4tJGvKSfO7yOCHR5PvUo1fpA2IsH/BSNnBIpKpMOsBeYdKt3ZFm8WhmVKrT8wx4=
X-Received: by 2002:a65:5b84:: with SMTP id i4mr3510551pgr.263.1588693728706; 
 Tue, 05 May 2020 08:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200505142519.1138945-1-arnd@arndb.de>
In-Reply-To: <20200505142519.1138945-1-arnd@arndb.de>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 5 May 2020 08:48:36 -0700
Message-ID: <CAKwvOdnBqYs1qJPm4apkGeHUgEZ+ZKe0j0h=eXWy9ACF+OS_HA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/dc: don't pass -mhard-float to clang
To: Arnd Bergmann <arnd@arndb.de>
X-Mailman-Approved-At: Tue, 05 May 2020 15:50:42 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, Leo Li <sunpeng.li@amd.com>,
 Marc Zyngier <maz@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, David Airlie <airlied@linux.ie>,
 Timothy Pearson <tpearson@raptorengineering.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Charlene Liu <charlene.liu@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 5, 2020 at 7:25 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Clang does not appear to care, and instead prints a warning:
>
> clang: warning: argument unused during compilation: '-mhard-float' [-Wunused-command-line-argument]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I want to be super careful here, this part of the build has been super
tricky in the past.  Just noting before this potentially gets merged
without any testing; we should verify the generated code does not
change with Clang.  In the past, this code compiled but would GPF
sometimes when called into via userspace (see my previous commits
here).

> ---
>  drivers/gpu/drm/amd/display/dc/calcs/Makefile | 5 +++--
>  drivers/gpu/drm/amd/display/dc/dcn20/Makefile | 5 +++--
>  drivers/gpu/drm/amd/display/dc/dcn21/Makefile | 5 +++--
>  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 5 +++--
>  drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 5 +++--
>  5 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> index 4674aca8f206..64195cacf6fc 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> @@ -26,14 +26,15 @@
>  #
>
>  ifdef CONFIG_X86
> -calcs_ccflags := -mhard-float -msse
> +calcs_ccflags := -msse
>  endif
>
>  ifdef CONFIG_PPC64
> -calcs_ccflags := -mhard-float -maltivec
> +calcs_ccflags := -maltivec
>  endif
>
>  ifdef CONFIG_CC_IS_GCC
> +calcs_ccflags += -mhard-float
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
> index 5fcaf78334ff..0d3ce716c753 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
> @@ -10,14 +10,15 @@ DCN20 = dcn20_resource.o dcn20_init.o dcn20_hwseq.o dcn20_dpp.o dcn20_dpp_cm.o d
>  DCN20 += dcn20_dsc.o
>
>  ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o := -mhard-float -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o := -msse
>  endif
>
>  ifdef CONFIG_PPC64
> -CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o := -mhard-float -maltivec
> +CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o := -maltivec
>  endif
>
>  ifdef CONFIG_CC_IS_GCC
> +CFLAGS_$(AMDDALPATH)/dc/dcn20/dcn20_resource.o += -mhard-float
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> index 07684d3e375a..fd209d1cf6bb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> @@ -6,14 +6,15 @@ DCN21 = dcn21_init.o dcn21_hubp.o dcn21_hubbub.o dcn21_resource.o \
>          dcn21_hwseq.o dcn21_link_encoder.o
>
>  ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -msse
>  endif
>
>  ifdef CONFIG_PPC64
> -CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -maltivec
> +CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -maltivec
>  endif
>
>  ifdef CONFIG_CC_IS_GCC
> +CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o += -mhard-float
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index 7ee8b8460a9b..fb74e79e15a2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -26,14 +26,15 @@
>  # subcomponents.
>
>  ifdef CONFIG_X86
> -dml_ccflags := -mhard-float -msse
> +dml_ccflags := -msse
>  endif
>
>  ifdef CONFIG_PPC64
> -dml_ccflags := -mhard-float -maltivec
> +dml_ccflags := -maltivec
>  endif
>
>  ifdef CONFIG_CC_IS_GCC
> +dml_ccflags += -mhard-float
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> index 3f66868df171..b0077f5c318d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> @@ -3,14 +3,15 @@
>  # Makefile for the 'dsc' sub-component of DAL.
>
>  ifdef CONFIG_X86
> -dsc_ccflags := -mhard-float -msse
> +dsc_ccflags := -msse
>  endif
>
>  ifdef CONFIG_PPC64
> -dsc_ccflags := -mhard-float -maltivec
> +dsc_ccflags := -maltivec
>  endif
>
>  ifdef CONFIG_CC_IS_GCC
> +dsc_ccflags += -mhard-float
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> --
> 2.26.0
>


-- 
Thanks,
~Nick Desaulniers
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
