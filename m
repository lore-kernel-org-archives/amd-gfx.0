Return-Path: <SRS0=WIfX=EV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336CBC56202
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Nov 2020 15:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68AAD22409
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Nov 2020 15:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="KEGRwcVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AAD22409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 733336E9B0;
	Sun, 15 Nov 2020 15:48:53 +0000 (UTC)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9A4A6E9AD
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Nov 2020 15:48:52 +0000 (UTC)
Received: by mail-il1-x143.google.com with SMTP id l13so599162ilg.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Nov 2020 07:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ldoygcZvwmHBr2LihqdGJdHmsiaQ8Ox3v1+2IXOyC/Y=;
 b=KEGRwcVl1affchl5stJpoRryPTUjdZH0hRjio1s01SssbdzvL6jcCXSp+q0ZWCqOXl
 tf0YUXJ+6Mz3hXrQtgNCOSgzM2znemVTcCPRyXW9RpptpfHxo8SL/B8lFGr4EvoDf45U
 nE6C0o2mlr+3WbEvyDUd/Q9vCPJJN75u9Pn79PKcCz03Y8HELuM4EXEwlTi3UEvuoqT3
 z9hplF61nBW66plhMamlkkNm/fIDErpNQLJXOgE1Axt+GdKrw4ZT/Nh1UyQ135o297rC
 GLFV+fEa5rdL+ZmhGQ5Dh5dhyumFxp+6O5ruXdAyq2YkhSoQHU1//Lm7WbOcbjedhtMS
 uefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ldoygcZvwmHBr2LihqdGJdHmsiaQ8Ox3v1+2IXOyC/Y=;
 b=l872/k7i1ijgN3gRU9OLERWs1GBmxZQlwl7gGbsdDs8YO340GQbADH4CbmlmC0XqeG
 EQiB+9YgUjy1GXPbLQPBNlpIPDkgWsMrYSzKOkPFUWPWRKGPkTUABl4HtLCOYPM0Tujo
 JIdXpebu4AnNjbVtkp0hzi+xHakBNqZjlod93/UObGjGNJz9ShipafxjJ5h1j7MoPynE
 dmL1fl1KZMB3XnKZgaxhYKak+Z+1V0C20q8S6aqB+ctDw3h1SbHejjuRFqWU+U+IqoLN
 5yNvZR4PXuw0OYI7SzSTbQ3D9mp4Gr+0jjr09wDDP4swQQUZDsseNFVKpxncIYHDg/pk
 62kw==
X-Gm-Message-State: AOAM530ChlR7cQhrXM3uuwOy12y5hzbIcEjyXtyxbKabj82YksaAZ5ub
 XnaV8ddyrNIfkHYNBwkUj8Y3loHcV1dq/jcEjqobTA==
X-Google-Smtp-Source: ABdhPJxd7r4mxb99HJVhGPFZd1NyUgk39chxk7fuOxMyWjpwCJwakV0c0uK6fVHqzWWurmFN46P9LCfT0WD1GXB7RJ4=
X-Received: by 2002:a92:c7a2:: with SMTP id f2mr5839047ilk.294.1605455332127; 
 Sun, 15 Nov 2020 07:48:52 -0800 (PST)
MIME-Version: 1.0
References: <6NXsveJa7IUiRftZcOguXi1dj0UifPcrDRtR1oOgrU@cp3-web-009.plabs.ch>
In-Reply-To: <6NXsveJa7IUiRftZcOguXi1dj0UifPcrDRtR1oOgrU@cp3-web-009.plabs.ch>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Sun, 15 Nov 2020 16:48:49 +0100
Message-ID: <CAP+8YyHLjEe718h2LZUNCYKx4VBw9J2=0BO9-ogzu9NTzCGdng@mail.gmail.com>
Subject: Re: [PATCH] drm/fourcc: fix AMD modifiers PACKERS field doc
To: Simon Ser <contact@emersion.fr>
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
Cc: Alex Deucher <alexdeucher@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

On Sun, Nov 15, 2020 at 10:39 AM Simon Ser <contact@emersion.fr> wrote:
>
> This field doesn't alias with BANK_XOR_BITS: PACKERS is bits 26:28 while
> BANK_XOR_BITS is bits 23:25.
>
> Fixes: 8ba16d599374 ("drm/fourcc: Add AMD DRM modifiers.")
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Cc: Alex Deucher <alexdeucher@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
>  include/uapi/drm/drm_fourcc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index ca48ed0e6bc1..29c7a8694479 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -1196,7 +1196,7 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
>  #define AMD_FMT_MOD_PIPE_XOR_BITS_MASK 0x7
>  #define AMD_FMT_MOD_BANK_XOR_BITS_SHIFT 23
>  #define AMD_FMT_MOD_BANK_XOR_BITS_MASK 0x7
> -#define AMD_FMT_MOD_PACKERS_SHIFT 26 /* aliases with BANK_XOR_BITS */
> +#define AMD_FMT_MOD_PACKERS_SHIFT 26
>  #define AMD_FMT_MOD_PACKERS_MASK 0x7
>  #define AMD_FMT_MOD_RB_SHIFT 29
>  #define AMD_FMT_MOD_RB_MASK 0x7
> --
> 2.29.2
>
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
