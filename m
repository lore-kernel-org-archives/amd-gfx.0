Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F63C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 18:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9387310FCB0;
	Thu,  7 Jul 2022 18:19:39 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2C9010FCB0
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 18:19:37 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id o25so33870516ejm.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Jul 2022 11:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wixbTUKGw6v/KYVrJD+0MJ30pPTbNQGpAShEP65D3hg=;
 b=PVPcvLv1jIUpAdYe6oWvatJBVJOeU/yylqB5WtMu1ZP3bVUm5EplsFPnweKXsxQnIY
 e6Iyx8mE+p6NadnH0IJUFuwiwrkB5e36rsAZEWR8uAL0FjCGYb4S8XVLjszaiaZldE2d
 blMaQXFuk3DWp2ZMbd8PBL0D+NZheb7vbq8zPpaP8TUoT8F8szSjPEu6PrjrqSNSbz0z
 p5zd0XcR4c9Cy+CtqZzYmEe8FFAZ+LZLR/qsD1LfnbKmOyGnJD1SVxBO6z95kLVFV/Jz
 GjcpoR85DbIr5WEM4lbpyLA0ErF2rGjPSoq3HZenNee8e6B9IjhCh83f++zz7tQq+rVf
 4zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wixbTUKGw6v/KYVrJD+0MJ30pPTbNQGpAShEP65D3hg=;
 b=UM4RikQw+dd0jt3LY18uGrjXyPsCXTOEbHxpzaAyMt3NVwxwHfYFwar2p3D4PtINid
 Z6GkeUtEom36jghVK3FqtexSbhgKf4NjgyPk2iM8n2+NT0EZv43rAx6XZ/UA4AkKZZdl
 cPd9dj+B5Emc1aWkGWEo7KT5RMzNVeIA2oL3Ssuc3UBhXSg3a8SmFIZBsbhNeQbCbJNj
 j4Noro/FBxXz7q+oIO538wQ+IEXTkXvuLDwu76+ZRg53xAjaSM/GrUxKnYN383bMTBWa
 aW6YqWYKHL9gyf4GDiKLIUiJr+onoIpGc6rnL2qAbuOP+7mARZs0sEyvIYsNqgsnI+ZM
 ZdwA==
X-Gm-Message-State: AJIora//HeTgbVTvIvKDNP/hbH2Gw+Kk9ToPp9vUNrRO2CVijNXbeiUV
 o5bjsdaLSjqQ+Q3Q5lWXsX/d8N634qtRcwesMAc=
X-Google-Smtp-Source: AGRyM1tz+cZU0wvekVWZnSjpNOKd6IRe391vbE3w6pk/lHxOoSQsqzJ5UYHw+IGIjq0dxCY18yL0h5hZp7gEWKpoXRw=
X-Received: by 2002:a17:907:75e1:b0:72a:ebee:5f61 with SMTP id
 jz1-20020a17090775e100b0072aebee5f61mr13952037ejc.171.1657217976438; Thu, 07
 Jul 2022 11:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220707125446.379104-1-sunliming@kylinos.cn>
In-Reply-To: <20220707125446.379104-1-sunliming@kylinos.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Jul 2022 14:19:24 -0400
Message-ID: <CADnq5_NM3h1go3QhTzQq-sbYCYhoVLxwBbS0X0RmoEDQyzBGsw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove redundant header file references.
To: sunliming <sunliming@kylinos.cn>
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
Cc: kernel test robot <yujie.liu@intel.com>, Dave Airlie <airlied@linux.ie>,
 kelulanainsley@gmail.com, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks for the patch, but someone else beat you to it.

Alex

On Thu, Jul 7, 2022 at 9:05 AM sunliming <sunliming@kylinos.cn> wrote:
>
> Fixes the following includecheck warning:
>
> drivers/gpu/drm/amd/display/dc/os_types.h: drm/drm_print.h is included more than once.
>
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/display/dc/os_types.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
> index 795dd486b6d6..6b88ae14f1f9 100644
> --- a/drivers/gpu/drm/amd/display/dc/os_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/os_types.h
> @@ -39,8 +39,6 @@
>  #include <drm/display/drm_dp_helper.h>
>  #include <drm/drm_print.h>
>
> -#include <drm/drm_print.h>
> -
>  #include "cgs_common.h"
>
>  #if defined(__BIG_ENDIAN) && !defined(BIGENDIAN_CPU)
> --
> 2.25.1
>
