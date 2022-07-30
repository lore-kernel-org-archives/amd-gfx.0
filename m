Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFAFC04A68
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Jul 2022 14:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E7CA78E8;
	Sat, 30 Jul 2022 14:43:17 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27A23A7922
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Jul 2022 14:42:53 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id gk3so946074ejb.8
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Jul 2022 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=sQUy0WytJWUxyPIigCMd6sU9Ade1HcceW7RAIOk5zU0=;
 b=pP+ovfD/NJ1p4ywDjhFYjM3h1ZrOipz46MEIO6lm1YGwkggqbonXJdeT8nQeQFQIrr
 pKNVLnrFOXQm+5+lXOOeQgHJJcXJSKTVuL6y9utF4gaq7aLg2BfbIkJOtS70LnzpKhrP
 CDhBjViW1FDzTVqY/f7uD2wHawgWt71OGUhWwK03XjqkApwi2aSViI8NSunfyx7lsaSU
 McFzOBdOXfVTvYDBONJJYW4d9zKlv0WK4voReZXfvlOsAB9XXPS7x58dF1ncCT+lTd3V
 51h7agdbEZGzcpaN27e/KWWA/J96GYhuyuzT3rWu/ZnsyCcko4oyrSUTDDGSq/MBtofD
 EV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=sQUy0WytJWUxyPIigCMd6sU9Ade1HcceW7RAIOk5zU0=;
 b=MWiRhNdxwGxnlFGY3owskJj8fNVhLA/GNooQ/saNf0xshaYGGhYOnU3Wbr1rJnbebK
 ygktyW4bv/+/vSLUMNRTty6cVrzMa3KAHjOcRhaxYjvGz8RWbbjQVD08qt+ZW4EviRmu
 N9jYbZclZz2ZvFgc7TmGywDtAavodjQT1OmER9Bmt6Jy8aPE2zfu830YJTnvckJN2iR8
 0JJ7r5C/45HfvU+dXNh+XAr2Ytv+L8ADI6lU2JFwnlJe6TqM9+++4NfeUmme/MtOLTSR
 7Vaf568MJ6adMd819RBRBRF7LJP5aqpZ26ijLuHhUK2pTrMN9E02rVBiHqbCMrF/ldxm
 ChKA==
X-Gm-Message-State: AJIora/dovMnN8+M8yZClzxO2z07d1zJEerfC7aS8/MPUrZ2oj8ogXlp
 wuBnR4d6jbEbkWFmTPS5AALpme+pcuv1dKkaQFQ=
X-Google-Smtp-Source: AGRyM1vh31GjHqRE2VT6H71SRQJW4TaXIYVWaXFwbX62kAeynYfuuH/rGR4AF7pQ6Wcq3RpM7RmrM9rY1aBuYvhHLJk=
X-Received: by 2002:a17:907:a06f:b0:72b:564c:465b with SMTP id
 ia15-20020a170907a06f00b0072b564c465bmr6583963ejc.344.1659192171553; Sat, 30
 Jul 2022 07:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220729205028.3329595-1-praful.swarnakar@amd.com>
In-Reply-To: <20220729205028.3329595-1-praful.swarnakar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 30 Jul 2022 10:42:40 -0400
Message-ID: <CADnq5_OKpGEcxCbx=zRR4sbcr5bJ4aSAqyi3SpWYO2nxzE+u3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Increase frame-larger-than to 4096 in
 dml Makefile
To: Praful Swarnakar <praful.swarnakar@amd.com>
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
Cc: Tim Van Patten <timvp@google.com>, Leo Li <sunpeng.li@amd.com>,
 Raul Rangel <rrangel@google.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 29, 2022 at 4:51 PM Praful Swarnakar
<praful.swarnakar@amd.com> wrote:
>
> When enabling kcov and debug kernel configuration, stack frame size
> exceeds set limit, resulting into build error.
>
> Fixes the following build warnings:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3955:6:
> error: stack frame size (2344) exceeds limit (2048) in
> 'dml31_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]

Should be fixed with this patch:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/1b54a0121dba12af268fb75c413feabdb9f573d4

Alex

>
> Fixes: 5679b6e2c887 ("drm/amd/display: Enable building new display engine with KCOV enabled")
> Signed-off-by: Praful Swarnakar <praful.swarnakar@amd.com>
> Signed-off-by: Tim Van Patten <timvp@google.com>
> Suggested-by: Raul Rangel <rrangel@google.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index 359f6e9a1da0..42b1df843a6c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -51,7 +51,7 @@ endif
>  endif
>
>  ifneq ($(CONFIG_FRAME_WARN),0)
> -frame_warn_flag := -Wframe-larger-than=2048
> +frame_warn_flag := -Wframe-larger-than=4096
>  endif
>
>  CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
> --
> 2.25.1
>
