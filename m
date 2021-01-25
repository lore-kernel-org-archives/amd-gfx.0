Return-Path: <SRS0=8/fv=G4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35262C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 15:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D64FC21707
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 15:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64FC21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8C389C07;
	Mon, 25 Jan 2021 15:51:26 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6381089C07;
 Mon, 25 Jan 2021 15:51:25 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id k8so13158584otr.8;
 Mon, 25 Jan 2021 07:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AnH8Zx3d2Pw4vQ7JjSbzPf+jFEKtnCEURYKMXZ7izF4=;
 b=ZcxU7anJ2ZSWMdXAhgnTS6vQEEaxIWbMi+Sl+qOBbZIW5+oXuoVr2qGbaXlCtdyBZV
 Aa7S5SWpJxIKk/p5bp5oozc2iQ7Nk1DfJjxzTFy2mO2M0rmvHXUwH3bvrhyzJngc+jRQ
 N7iOVvDIrbxs3ktZ23PBBxzgcg4o5Sek/QAVmLZY3BH6YyWNH/YfXEXA0XRpCM4VH2y0
 X6fCWC5YmfgsR9kSlOo3kHtWmUW1/36BHlts/+u8vXOhqnhVmg7cCpbtPFIuk8Q6GIpS
 QxOSH6I02N5gup190GQSXndTJdlB1RKSikDgABqI9KkBxNjQb32svdstebhNzsZRlM5y
 OoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AnH8Zx3d2Pw4vQ7JjSbzPf+jFEKtnCEURYKMXZ7izF4=;
 b=o01SVp9+l7iToT/2r2e++hQDQk78I597peU+MpXBijxI1WO6VAUHFlhq4xwPI6fc8V
 AtaV9KBx3CUAxysTXlKyDXzed7LsFCYRs+RLlaVeuh5Esx1L8ytXowfupUpyt2B/pH7r
 Gg76BcruC5FwSzCE3uYPrz3m6DkVZ85zJi8hFRZ87Uo6IsXw4FD1qqJteggoIaCPbTMR
 zRYkazWciPulMY1vNbfW1X9klmA/3P4azBA73QDxrvbflqMtYTYY0Hbgl9P11TD8FKOG
 luPmanfWzkRZZzDcwUcqCNj5S9dTnpl+M3dGwOFoB28N+EDagwTgx6hhLbSfsQtsRSiT
 tIsw==
X-Gm-Message-State: AOAM5314vDM+41jIZVPfSpOAywNAdK+1psqKWzDCIp9nJdKBTzXhHE78
 G7jLcbgANIODKQfNf4XfyOdZrC1t83sYmL1BcUY=
X-Google-Smtp-Source: ABdhPJxkHywTepuBn+fqbpyLJEosnBpNCyVcv27jF2qPKIMyyV4cAkh1nb0ayowYwrnFaAztgS4G1/tHe/M5JWEe6AA=
X-Received: by 2002:a9d:784a:: with SMTP id c10mr931304otm.132.1611589884729; 
 Mon, 25 Jan 2021 07:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20210125122402.4036126-1-arnd@kernel.org>
In-Reply-To: <20210125122402.4036126-1-arnd@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Jan 2021 10:51:13 -0500
Message-ID: <CADnq5_MLYdu+cY88yzmv+D6A0twg64C0vLBEhPazCgGseEWg=Q@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: fix clang build warning
To: Arnd Bergmann <arnd@kernel.org>
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Roman Li <Roman.Li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 Will Deacon <will@kernel.org>, Nirmoy Das <nirmoy.das@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 25, 2021 at 7:24 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang warns about the -mhard-float command line arguments
> on architectures that do not support this:
>
> clang: error: argument unused during compilation: '-mhard-float' [-Werror,-Wunused-command-line-argument]
>
> Move this into the gcc-specific arguments.
>
> Fixes: e77165bf7b02 ("drm/amd/display: Add DCN3 blocks to Makefile")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/Makefile  | 6 ++++--
>  drivers/gpu/drm/amd/display/dc/dcn301/Makefile | 3 ++-
>  drivers/gpu/drm/amd/display/dc/dcn302/Makefile | 3 ++-
>  3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> index c20331eb62e0..dfd77b3cc84d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> @@ -32,8 +32,8 @@ DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
>
>
>  ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -msse
>  endif
>
>  ifdef CONFIG_PPC64
> @@ -45,6 +45,8 @@ ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -mhard-float
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o += -mhard-float
>  endif
>
>  ifdef CONFIG_X86
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
> index 3ca7d911d25c..09264716d1dc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
> @@ -14,7 +14,7 @@ DCN301 = dcn301_init.o dcn301_resource.o dcn301_dccg.o \
>                 dcn301_dio_link_encoder.o dcn301_hwseq.o dcn301_panel_cntl.o dcn301_hubbub.o
>
>  ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn301/dcn301_resource.o := -mhard-float -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn301/dcn301_resource.o := -msse
>  endif
>
>  ifdef CONFIG_PPC64
> @@ -25,6 +25,7 @@ ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> +CFLAGS_$(AMDDALPATH)/dc/dcn301/dcn301_resource.o += -mhard-float
>  endif
>
>  ifdef CONFIG_X86
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> index 8d4924b7dc22..101620a8867a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> @@ -13,7 +13,7 @@
>  DCN3_02 = dcn302_init.o dcn302_hwseq.o dcn302_resource.o
>
>  ifdef CONFIG_X86
> -CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -msse
>  endif
>
>  ifdef CONFIG_PPC64
> @@ -24,6 +24,7 @@ ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> +CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o += -mhard-float
>  endif
>
>  ifdef CONFIG_X86
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
