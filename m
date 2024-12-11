Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF69EE7717D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 19:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C45710E40E;
	Wed, 11 Dec 2024 19:35:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qPSsMiQO";
	dkim-atps=neutral
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9198B10E40E
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 19:35:22 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-540215984f0so3406803e87.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 11:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733945721; x=1734550521; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mlmxBycUGwX5pHsGKJE1We114Ns4Oa+/FIJwhXU3Bf0=;
 b=qPSsMiQONcwc7c+1YpPu+evtAjgnpbp5PSTefi7UT0T4ZZxqU26tOMmcfprPKBji8J
 on19O/k2G0Di/rq1NBbeRUDPcBd6E7bGe/qJXK3zUiRVW+roxosmNe/LknF94BvBmTvs
 qNec1LuaXGrJLc06tmnpOz7aV5WB1J1TYmcOXp4sfevFS9wwqS69yKcgRgzN6xW5VxKl
 HGSUSZgoUTWul8YpJv9LF55j4W6izk+XnZqxoXIb5f2W9eDlPA0Va5k8MB4H+HVJM/7B
 THeY0OyIDL/D41LgQqZpsdAWn7VwmKNGKWIAdcy+iVceALPS0ViXqvivQpJTk2iOZbiB
 iOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733945721; x=1734550521;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mlmxBycUGwX5pHsGKJE1We114Ns4Oa+/FIJwhXU3Bf0=;
 b=J3z4sxWqQ3sxOo0T78baf6621LXs1wrGRMp9WzVcbAvfy0lt5XEuDbMYhtk9fr+09x
 LcUoMV279qtM0yU8qmoREq+QMs5Ww/+VL33IKkVFpCrVFKPPFNEL67k07icKiUUFGra/
 SpYibYCeP3+l5nCj5AdLCCNH4Pgpk6zSJclUreVBCa9ZRLjOzJrnGW9j2udYTCT0cENJ
 1rJO+hiMwnMLXRMN+ZJ0b436UcOLFsrgcexCiLYIB5r0PNO/9gk8qkSuNTeGeFvXo7fz
 jc8RpehwrkgUDzwNkj6Cf8jtRtkgv9LtrsR8w83fk5pBejSKGpYP5P5o/Ay71Ef/hNvy
 Y7Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjl36IPM7SLISieBltB30jEHOvlTpd6nJ8gNn7fPvHbRRezj9z6L/DlB4mQA0y7FQ8h6ssVLQM@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxbU2OlIj0hR2m032eMEaQejosel+pq8jymoCB2NvjPIpWTiScz
 TBXa9VZ/u2fnYnbh4QykPqUBqYltCq4y0VxVD8KaklrC+UMSoIPZb1wFbJ2mkHU=
X-Gm-Gg: ASbGncsTRUjz6bK0SP63OIqa+C+Mbw+yrp1RzzFgaDTIjj75xRD4SfVWEJtlYacCDBe
 aXqUJkiaONAnaikLgId1jBZP3xHT8EaD1FBhzT4Fmu9BL1xum+DJNHbmtltw2/+LqfjNz7U5ACS
 CkOeXzlQ6PweWUWrc1N7m0389Htl3InWlD1+Hjxknr1iuWk/id+aRvdqO6kXzvodKsDiwyX6kDU
 3HhEwoBce8iUaBnTe+f32ZsZSemCgR32/S9VEncVSil+yyO6dYmOHek0pxk4NfZ8aKzymj0ISKl
 XXhhwb5+vqQYFm60HwGSyBhlem8x2UnXQg==
X-Google-Smtp-Source: AGHT+IFXG9kNop6Dow/dfMq9L/6cEoHmDiwAQOF9Wkw7NDsQvYPpji8SHNbXQPAGHwNjq9pSMY6jew==
X-Received: by 2002:a05:6512:1302:b0:540:17ac:b372 with SMTP id
 2adb3069b0e04-5402a5eae13mr1520110e87.30.1733945720766; 
 Wed, 11 Dec 2024 11:35:20 -0800 (PST)
Received: from eriador.lumag.spb.ru
 (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53e229c0d92sm2113398e87.171.2024.12.11.11.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 11:35:19 -0800 (PST)
Date: Wed, 11 Dec 2024 21:35:17 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, Simon Ser <contact@emersion.fr>, 
 joshua@froggi.es, Xaver Hugl <xaver.hugl@gmail.com>, 
 Daniel Stone <daniel@fooishbar.org>, ville.syrjala@linux.intel.com,
 kernel-dev@igalia.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v10 0/2] drm/atomic: Ease async flip restrictions
Message-ID: <ouyulceg7zrnjirg2yf4qbgp5pfovz4y6hq5v6e573yx7ih5qe@uqqne6yq27wl>
References: <20241211-tonyk-async_flip-v10-0-6b1ff04847c2@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211-tonyk-async_flip-v10-0-6b1ff04847c2@igalia.com>
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

On Wed, Dec 11, 2024 at 12:25:07AM -0300, André Almeida wrote:
> Hi,
> 
> The goal of this work is to find a nice way to allow amdgpu to perform
> async page flips in the overlay plane as well, not only on the primary
> one. Currently, when using the atomic uAPI, this is the only type of
> plane allowed to do async flips, and every driver accepts it.
> 
> This patchset re-uses the per-plane function atomic_async_check() to
> this purpose, so drivers can allow different plane types. There's a
> `bool flip` parameter so the atomic_async_check() can do different
> decisions if it's a complete page flip or a plane update.
> 
> igt test: https://lore.kernel.org/igt-dev/20241211031820.115844-1-andrealmeid@igalia.com/
> 
> Changelog
>  v9: https://lore.kernel.org/r/20241101-tonyk-async_flip-v9-0-681814efbfbe@igalia.com
>  - Add a 'flip' flag to indicate where the atomic_async_check() is being called from.

I think something went wrong. There is no changelog for v10 and also no
tags that you've got for v9.

> 
>  v8: https://lore.kernel.org/lkml/20240806135300.114469-1-andrealmeid@igalia.com/
>  - Rebased on top of 6.12-rc1 (drm/drm-next)
> 
>  v7: https://lore.kernel.org/dri-devel/20240618030024.500532-1-andrealmeid@igalia.com/
>  - Complete rewrite
> 
> ---
> André Almeida (2):
>       drm/atomic: Let drivers decide which planes to async flip
>       drm/amdgpu: Enable async flip on overlay planes
> 
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 11 ++++---
>  drivers/gpu/drm/drm_atomic_helper.c                |  2 +-
>  drivers/gpu/drm/drm_atomic_uapi.c                  | 37 ++++++++++++++++------
>  drivers/gpu/drm/loongson/lsdc_plane.c              |  3 +-
>  drivers/gpu/drm/mediatek/mtk_plane.c               |  2 +-
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  2 +-
>  drivers/gpu/drm/tegra/dc.c                         |  3 +-
>  drivers/gpu/drm/vc4/vc4_plane.c                    |  2 +-
>  include/drm/drm_modeset_helper_vtables.h           |  7 +++-
>  10 files changed, 49 insertions(+), 22 deletions(-)
> ---
> base-commit: c40c32cf71b90d85386fcc066c19feb23eb42804
> change-id: 20241002-tonyk-async_flip-828cfe9cf3ca
> 
> Best regards,
> -- 
> André Almeida <andrealmeid@igalia.com>
> 

-- 
With best wishes
Dmitry
