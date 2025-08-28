Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C17AC8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4306D10EA24;
	Thu, 28 Aug 2025 15:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iwxZgCvS";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9318010EA24
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:21:07 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2489b6b6cbdso1392675ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756394467; x=1756999267; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hiy5C+qghZ3LXzD+QxR+aAYax+MlG62RwJLuFK1GJt0=;
 b=iwxZgCvSU/BsCXdns54sYMTjmVEAXhHJq67AQ9SMhSewNA7W/igjXrOx/NLOcexSb9
 bll9Dy+xJshQRBs5+h064ytTx7E8cgqv4uJdvNYlYlWV9ZLLioMWd/Ww/lxzolOFpuFk
 kzQ4QPqieq+k3Lj5ax62io/9s1JfI2avtWhXk52TjUFhFyWr/hNRDqvISltvyguetrAp
 MfOaS/STU3WDrWoA6nuivXzLg9Tmi6ooQa8cazM7E3WMvbT8bgc/BnD352Ca4zy1KCfh
 4QRokrJnVR9IuS3UdeU7FZNn9CDb0vIP/e045+ePz+t3bL7BTxmj65XDZGq/CwsPGD7Y
 3S1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756394467; x=1756999267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hiy5C+qghZ3LXzD+QxR+aAYax+MlG62RwJLuFK1GJt0=;
 b=spdpPHRZiaIn47/9zGxwSeWDCE+t8H9KKZYVeZ3++9R10cEQNl5ga/9vBpIDzc/XpH
 wMBefccjgGdGTKOpMc/hbmjHdLy2pGfbkqUi29YJ+F86VmL/9Z2xNt1L59DMCWMJSX6m
 mMB5QEhPIHk1cjhyJg3BuFTDXFOPxXeUYpEYRcc6N/B6bCNc0+vRMaHWn0ounM+9t5cA
 WIZBvNkh9r5JNPI1Ax5+UirAiv1/2WfGakR/5sf+/3h3/mHKb8Oa+oUTWDL1FnFnthJn
 8vFWJ7HXQQHwaKaaDHd6N1MxUfCswUsrJvhz0bFjobiyPa+j84dhH0taYEc1GOAynPgr
 6cig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhsYZnws6OhsN/oByQh3No7BHApBj10NshwLfGMl2lcEn5sj19Tmnv4pvJCSkDzHWs/M4bwU+S@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxN0KlWBexEg/48en7xw9aXXu5t9M0+dmBAQFgI+SCL2YiNlU+h
 1QofyDUVQsjFwRjjvTiot4ggAGmqRIv71v/P6j+BMvqWidWgJDfwyF6Wda436FLxda4MjOQh9/g
 IeTEw6ekmlL9reoJ+7WtYZVs89ISfYmM=
X-Gm-Gg: ASbGnct1/hrO7B3lJnbeCcn/jk8F3kIxqKF/hlcw0Z6JMw9iJ/ptFf+JLJKI531W43y
 JuFlWzFKtAFBUimWwrExGLrOu8ZiJRObXqeypYqlgrQioDd6mMk5Gap5HNBEtPw4qdODtXbuV00
 3cxQVjrwDh+p8kmBouIXI14aPp9WqBlUyNkGZrVVSiS3xAiZgOXnvan9ighF7bcQUsW27dtk0ke
 /ejvbI=
X-Google-Smtp-Source: AGHT+IE6KQD9tyOs4gxrxNQSEgd05A8EEg0pZNYnfXd3X20pPwn3PMH/Q68vX99C3CT912FAmI1McW+rdpZZyVDkoN0=
X-Received: by 2002:a17:902:d506:b0:246:b1cf:fec2 with SMTP id
 d9443c01a7336-246b1d002d1mr122234935ad.4.1756394466993; Thu, 28 Aug 2025
 08:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
 <20250828071335.3948819-3-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250828071335.3948819-3-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Aug 2025 11:20:54 -0400
X-Gm-Features: Ac12FXx1RLa090AQYk7I0FYUmsIajCz36hehgxqW5LSfwNcjgQxP_Xa_21ILMAE
Message-ID: <CADnq5_Mr0uh5Srsm4f9CYDVrSmap6d0G2+mFVaASecfXFP8uRw@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] drm/ttm: Bump TTM_NUM_MEM_TYPES to 9 (Prep for
 AMDGPU_PL_MMIO_REMAP)
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Aug 28, 2025 at 11:13=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Increase TTM_NUM_MEM_TYPES from 8 to 9 to accommodate the upcoming
> AMDGPU_PL_MMIO_REMAP placement.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  include/drm/ttm/ttm_resource.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resourc=
e.h
> index e52bba15012f..f49daa504c36 100644
> --- a/include/drm/ttm/ttm_resource.h
> +++ b/include/drm/ttm/ttm_resource.h
> @@ -36,7 +36,7 @@
>  #include <drm/ttm/ttm_kmap_iter.h>
>
>  #define TTM_MAX_BO_PRIORITY    4U
> -#define TTM_NUM_MEM_TYPES 8
> +#define TTM_NUM_MEM_TYPES 9
>
>  struct dmem_cgroup_device;
>  struct ttm_device;
> --
> 2.34.1
>
