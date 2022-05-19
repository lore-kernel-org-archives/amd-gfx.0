Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01141C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 13:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76AAA113E34;
	Thu, 19 May 2022 13:16:41 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05DD0113E34
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 13:16:39 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id m25so6441148oih.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 06:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Cs9DLx8eWsu1qa7RAlc/H60rSPEmNW9aoVf2VunHHNM=;
 b=IP268cvHCRM/Ynjz/GKYyUnz2t1WQ0yCX0z9bFOePOCKxcAMGfbfZUgYtKPHty/0L7
 i4zelNdiuQVPHTl6SlkW79tELEoQEbJj42ZAgwlBmJLSoPl9JPZpbJRMm0ESGcIdgOT8
 EGR21UD9fTya4jauhC9zWjZO7NmeNWV/uLWmopMzk8UOndmHxLWhQVs5yuV6WKMGyJKp
 MssOMHKp208Ji+SyxnWVjNtj1xsvh/5gpg86QWGU+sqCmk/Mmda/WHWYgi9l4J6mJfcD
 3mDlQcPbVOACJ3fja/jrumDW15YY7il4nojWuadIqtikKoJEQl8dBdX9SN/mIHq3EBpG
 s2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Cs9DLx8eWsu1qa7RAlc/H60rSPEmNW9aoVf2VunHHNM=;
 b=dJeRCdHB7aR4Kt1CHWxfmXbYmey+Zz30tu7kV7gSYwzrdjsGvlN88N6YTcrS7ptkvN
 +ViR/QkDKBrR6EZ1UHMPvMHcrmgf58zAKY2NSSdp+C4oTi0rEGi2aMtv+IvtdV1x2d/h
 dcUG9ZFoxr1JL9VSMLAHSrcU2mM5Eeznb0qLMjLEPHGO/kKEJjPZ0jJvktBPaOV58x3S
 Vfz+Alggjl+gXKtegjdO3DsUGD4GXpGc6Vbxab+A59bhr5y+mU2U7y7+6eF+F999ESgz
 n4CmKRrwQY0Sqg8nEoSpAFUXTfUDs1gPPiV3odU4iCPcZWce8DlPDLAoEu/du/3MxhbQ
 oS0w==
X-Gm-Message-State: AOAM53067PRO7WRpXmdkBS/lwJgKln/eGBLbqQRCEJiq9+wSLHAqs0fu
 1i0YzqlO3xZqAV7jjUC4wHrXDaPrpxXfu7VGhn8=
X-Google-Smtp-Source: ABdhPJyCV/jasvQwA4Kz6HYfJFF8O4DgKow9e8qEk6Zbg+BchDWQAJwwvyHgxjf68+hcHAPlITHLwxsrQPVStqNmtHY=
X-Received: by 2002:a05:6808:f8e:b0:328:a601:a425 with SMTP id
 o14-20020a0568080f8e00b00328a601a425mr2601394oiw.253.1652966199225; Thu, 19
 May 2022 06:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220519093150.1244888-1-evan.quan@amd.com>
In-Reply-To: <20220519093150.1244888-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 May 2022 09:16:28 -0400
Message-ID: <CADnq5_Prdphq_7ZmZxbpqV834Gios7KMcEb6LdmpHioZfq=Cog@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: suppress some compile warnings
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 kernel test robot <lkp@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 19, 2022 at 5:32 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Suppress two compile warnings about "no previous prototype".
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Change-Id: I74d029c6ebd8bf6bc08edada7a992d04786330d8
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/soc21.c            | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 881570dced41..16cdfb30b013 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1361,7 +1361,7 @@ union mall_info {
>         struct mall_info_v1_0 v1;
>  };
>
> -int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
> +static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
>  {
>         struct binary_header *bhdr;
>         union mall_info *mall_info;
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index c6a8520053bb..9e18a2b22607 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -42,6 +42,7 @@
>
>  #include "soc15.h"
>  #include "soc15_common.h"
> +#include "soc21.h"
>
>  static const struct amd_ip_funcs soc21_common_ip_funcs;
>
> --
> 2.29.0
>
