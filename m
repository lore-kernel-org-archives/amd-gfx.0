Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D8DC27C75
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jun 2024 20:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F3B210E1ED;
	Wed, 12 Jun 2024 20:45:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PvNkLHP0";
	dkim-atps=neutral
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACAFA10E8FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jun 2024 20:45:04 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-2ebe6495aedso2370681fa.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jun 2024 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718225102; x=1718829902; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SEA70tBJ4PwBkoOMmWe3ULbP4tpxOmjC5IUbkfsrBUs=;
 b=PvNkLHP0fFkU15p6qNkki/dKXRDhCrJgtpsUc14fMYYKn2astgSmiP4ETTSt9yRUrR
 GdFNlKph4Xk4jvXHzxLOI3nEYmB8MgoPYQf2auGaXWadWA5LiXt/WMGtJHpEhl2Pg8J/
 FU09ARf05/NX39+1aM91DmByGRTw1g9PYf4F+SNVTLrGwgOU/3pv3vmSAe0mCT4hKC7c
 nfo3dTAl7InGkHq1EAuckCuEId/uVdvW0b1bGUtnZqKVpKDvY0Vfoj/D5Bs8U7fUdpFe
 veXEv4P+cbdZOFOtuzxw2Ks+WdAWTB3q0xct4YIJRRCEeVaZS6CLDYm5FV0upshYIZJE
 1WPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718225102; x=1718829902;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SEA70tBJ4PwBkoOMmWe3ULbP4tpxOmjC5IUbkfsrBUs=;
 b=vI6fdzQLTQY0okw6N/YAjz+eXUEHGRpboyt4xHFG53WxtpGNp2nc/raeix6ELO2FXf
 zcT5WGcp5B9LKGtXJC0iHGbZoghtX/plRc9AnxF3ByHBNRjegCCYhbYguZPHAzb+i9Z1
 YBUwJ9hgZ8VpFMJOKhQzFmT0JhtDzUq0q5Rf6l8117muFj0DN90MHawLA4EdXSec26sx
 BDwzHm/dAYkaMLHnWPlfSxUA76GOztVhwRXiEsGWUyghh9OCKVtvhCeWy9w7AMYEbB9n
 W1AB7EPn/vHaprO02EA3I1ApPD1/A0Yve3JVK0DtsMPmhdjTY5gX+rvEqIiiXftT5Hrd
 WKWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFlEGKKmLeXaXz55GntNd+TKmEUd8kLLLNirYp8H0fVGlOIirCMyjdvDX7+QxemSHXG2vsMJd6GCXkKR7Il9M6F0fJvRb4h34eh8CjAA==
X-Gm-Message-State: AOJu0YzEIOeJFD1heGT2FMhsIJdRZ+3cFMxnBBzwrihv56dLovnmNd21
 uvf2HFN+9goZQYnaJ7ZUCQ6+T9rzUxaBs7zLjit0gvEd6neNJ0J1yf2Yg4wV/ro=
X-Google-Smtp-Source: AGHT+IGVRVhHEiIlwITe9DlEo5WfJ4Eof41I9EM1LQ/eq9af4QfavH0OfsPqZ0JOdpEI84p8RNKzSw==
X-Received: by 2002:a2e:9ed1:0:b0:2eb:e840:4a1b with SMTP id
 38308e7fff4ca-2ebfc8feb43mr16792821fa.7.1718225102385; 
 Wed, 12 Jun 2024 13:45:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru
 (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ebe4169b35sm16912301fa.135.2024.06.12.13.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 13:45:01 -0700 (PDT)
Date: Wed, 12 Jun 2024 23:45:00 +0300
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
Subject: Re: [PATCH v5 2/3] drm: Allow drivers to choose plane types to async
 flip
Message-ID: <pu4nawhvy52imqgpib4lx3s5lsbatmfrq3e7aa4zxfmewt6xrn@ki7woraegakt>
References: <20240612193713.167448-1-andrealmeid@igalia.com>
 <20240612193713.167448-3-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612193713.167448-3-andrealmeid@igalia.com>
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

On Wed, Jun 12, 2024 at 04:37:12PM -0300, André Almeida wrote:
> Different planes may have different capabilities of doing async flips,
> so create a field to let drivers allow async flip per plane type.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 4 ++--
>  drivers/gpu/drm/drm_plane.c       | 3 +++
>  include/drm/drm_plane.h           | 5 +++++
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 57662a1fd345..bbcec3940636 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -385,6 +385,9 @@ static int __drm_universal_plane_init(struct drm_device *dev,
>  
>  	drm_modeset_lock_init(&plane->mutex);
>  
> +	if (type == DRM_PLANE_TYPE_PRIMARY)
> +		plane->async_flip = true;
> +

Why? Also note that the commit message writes about adding the field,
not about enabling it for the primary planes.

>  	plane->base.properties = &plane->properties;
>  	plane->dev = dev;
>  	plane->funcs = funcs;


-- 
With best wishes
Dmitry
