Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB1DC7882F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Sep 2024 12:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CBDE10E82B;
	Fri, 20 Sep 2024 12:28:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZGvjFT3/";
	dkim-atps=neutral
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B800010E82B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 12:28:43 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-536562739baso1939022e87.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 05:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726835322; x=1727440122; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KmyYTSzJGsL/YMovQsb/XKINA9qbOmIqA08DqAcjnQM=;
 b=ZGvjFT3/8nnbZrNc8s+fYOSwPBqCA4zAZdxHzKuVU1DjEpkmTyA5sqdhiq/kVZ+ZMu
 I9JwQv8HvNy0einWnX2dndpZgk8zDOhAgrUdj0XgnmxQoyVpQwUs2VN+xWPgsivqOw12
 xCNX4YxBJKXJ1SlVtOsqnrL9rmznjwA6lLcu11kro4u5frNlRg5Mzj/10t8rWIp2Jm8l
 YKhBfPwRr0QUNrajQitLPKBFHah8K4CT7EbBLNhITNfMz0pkpcKcPmwwxIemZUp1Jrik
 qfnuU7725HXL3SeucEWtckl+hOswEd3NHvB4yMZg5L5tppHOBk/zI+fUpbrmj5l/R3So
 B5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726835322; x=1727440122;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KmyYTSzJGsL/YMovQsb/XKINA9qbOmIqA08DqAcjnQM=;
 b=GLh8dBnxlBGli+D3EyFt+og4a1ZLrgNMp4WQY8qUN6J/0h/XyR5EH2oFR1aoPgWJ/+
 vMj4QHJCgJFB/4+5EhG6hnLZCA9j5Oog+dKokcAOamW4A9yvNU3kY7z4E/9ZfRktozsL
 U8N9Wu7m/v8PIfXcaofCcR/MTtJx7Uxoc321f00uM7Y+84qEIx5ADwXg7Is41DTjN8Sg
 oWyZiQpF2lbDZWI+N+EkRASY2iiducLAFcMNcif+yLrcg0/HY4JPKCj6Gep7M2B67SMp
 GGVpNui7EzcA+Ku78kes31Bb/b448sD5x+Z0cbD0Q1eKcSeR6QYaNAOvO9ZVJue/TC4p
 6uNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQrn6vEuyAgKdlfZWXxUMXSXDRUhiKKQiTV9cnqM+T8ETcHODG4ngInbCeUjlN6EtQFmgu0juW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyI0Ge95oN0zCBcwgrtzkYVBTlwCmAb4UpRPvy+vz+OPYliI6ga
 KHxRDRBjb9o17+6P6bHP2ARYuUJoyCRjnIrTRbfBv/j23nISQ9LcI49iQx0JiXM=
X-Google-Smtp-Source: AGHT+IHqUCZSjDBGtSw+A8NmpVy9eKMCzlJUf0BJqZSjg4++cq0bIVZpdwJeTY8vMubkrtJMtyGRdA==
X-Received: by 2002:a05:6512:304d:b0:535:6a75:8ac8 with SMTP id
 2adb3069b0e04-536ac2e5e21mr1760442e87.23.1726835321653; 
 Fri, 20 Sep 2024 05:28:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru
 (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53687096993sm2149440e87.140.2024.09.20.05.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 05:28:40 -0700 (PDT)
Date: Fri, 20 Sep 2024 15:28:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Simon Ser <contact@emersion.fr>, 
 Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch,
 Daniel Stone <daniel@fooishbar.org>, 
 'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
 Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com, 
 Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>, 
 Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Subject: Re: [PATCH RESEND v8 1/2] drm/atomic: Let drivers decide which
 planes to async flip
Message-ID: <h2nyiovf5ixbqjrmtqcofmj6uwigcps7yjwfu67j3xdewnoj5x@fyu6ee7qjgk4>
References: <20240806135300.114469-1-andrealmeid@igalia.com>
 <20240806135300.114469-2-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240806135300.114469-2-andrealmeid@igalia.com>
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

On Tue, Aug 06, 2024 at 10:52:59AM GMT, André Almeida wrote:
> Currently, DRM atomic uAPI allows only primary planes to be flipped
> asynchronously. However, each driver might be able to perform async
> flips in other different plane types. To enable drivers to set their own
> restrictions on which type of plane they can or cannot flip, use the
> existing atomic_async_check() from struct drm_plane_helper_funcs to
> enhance this flexibility, thus allowing different plane types to be able
> to do async flips as well.
> 
> In order to prevent regressions and such, we keep the current policy: we
> skip the driver check for the primary plane, because it is always
> allowed to do async flips on it.

Unfortunately this needs to be rebased on top of 929725bd7eb4
("drm/atomic: allow no-op FB_ID updates for async flips"), but the
approach looks good to me and it fits the existing API.

> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index fc16fddee5c5..8568c2428670 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -27,8 +27,9 @@
>   * Daniel Vetter <daniel.vetter@ffwll.ch>
>   */
>  
> -#include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_drv.h>
> @@ -1059,6 +1060,7 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
>  		struct drm_plane *plane = obj_to_plane(obj);
>  		struct drm_plane_state *plane_state;
>  		struct drm_mode_config *config = &plane->dev->mode_config;
> +		const struct drm_plane_helper_funcs *plane_funcs = plane->helper_private;
>  
>  		plane_state = drm_atomic_get_plane_state(state, plane);
>  		if (IS_ERR(plane_state)) {
> @@ -1073,11 +1075,20 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
>  			break;
>  		}
>  
> -		if (async_flip && plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY) {
> -			drm_dbg_atomic(prop->dev,
> -				       "[OBJECT:%d] Only primary planes can be changed during async flip\n",
> -				       obj->id);
> -			ret = -EINVAL;
> +		if (async_flip) {
> +			/* we always allow primary planes */
> +			if (plane->type != DRM_PLANE_TYPE_PRIMARY) {
> +				ret = -EINVAL;
> +
> +				if (plane_funcs && plane_funcs->atomic_async_check)
> +					ret = plane_funcs->atomic_async_check(plane, state);
> +
> +				if (ret) {
> +					drm_dbg_atomic(prop->dev,
> +						       "[PLANE:%d] does not support async flips\n",
> +							obj->id);
> +				}
> +			}
>  			break;
>  		}
>  
> -- 
> 2.46.0
> 

-- 
With best wishes
Dmitry
