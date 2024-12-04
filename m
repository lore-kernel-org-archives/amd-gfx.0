Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80955E7716D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 23:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1813910E357;
	Wed,  4 Dec 2024 23:14:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uV7+aXB1";
	dkim-atps=neutral
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1801110E357
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 23:14:49 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2ffb5b131d0so2250821fa.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Dec 2024 15:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733354087; x=1733958887; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ByDBggfihaA7bzylhtE2nPcYIo+DwLJnDtkfjIDytqw=;
 b=uV7+aXB1OTFM17UJhS5k9FRXyR9YuNRgZKJDXE8UZi7V1fiy8FDPzQSoga/XB5CZbK
 SB/sosHL0DLY9dp9iWglazwgE95P2Xf3seEZvtdl7X2HbuAoUAr4UAwsOkhs53Xj2Dvu
 pSwkqXjIJeVzqGjvbOo8le68FjDZ/3gRFz1wz4/qypXSG1ZLD4/RkSeP39hN1Q7TeSjO
 4dr04xUQSQ/zf0U1YGVWyjPfAuFYqTfQ+K7ZqLwZ+lM0eq+aEdoe86OQDqqpw+hkO3lq
 ZF9Yf2Y5rYRgkwiL9XbVgkLIOcSCsGTuhWgxX9jHB0lUe107xc0paeOxifYmL/cB8zxI
 +Z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733354087; x=1733958887;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ByDBggfihaA7bzylhtE2nPcYIo+DwLJnDtkfjIDytqw=;
 b=Cupugp9ym1hBqiiH/K3GAHoF3wwKI5yGIjefETMo6j++5ltZtAEOxWhhRaPzfmUCHD
 PFk2bwrYamrBNYo8PvBm0SEB7u1015ROM2LZeixEqaKS3GtIsYY1G+VnOaGwkGem3+J0
 QReoplMrzCQBRGFFzrpxMFmXc8hbviqsdJRdnvmhfCVwjhmCVy0VxFZj75OcI9LmgWFY
 ayCyZsv7XEqx5f6UOyn8L8LiZL1zGvacVZZK/GvWNnL3LEUAZ9bvW2vqX1Ro7BE7Pp/X
 ZvBAqwFZG0i/7g+xypvILXZBhESfPqJVFMW1krYXOorUxYbUk0nmN6KBVt/y+KruO1rf
 pOcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHEaxB2mYw0taPPbysx8lL2tuSzXeU3k2FkGVz5YsAThydPgu9jclDom8uJ/1ig+OsSONt/HlE@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJxRdbXmrYk3ojtmhqbJiGIWnIFDVuL4pnzow1Q4fIimL4N4wC
 u16GGaUq/jvebPms7NFQ3dFc+JG7Ym/vIqU4BYh8OecjxA8HEU7/oJdwC64izeE=
X-Gm-Gg: ASbGncvLBHW6ysWKjn7YQQXDVJoNqqjop2w0xyeInQ4kvfUrtZlsgsAFuhF6l9rszpl
 WpVRhnTs7VR+PUu5zwS4Uulpx7WirlmR3hYLcj55iimZkOmOeFIO2S7P3zcwfV/PA9S7lSraIPC
 8GRxIAL/nEc/CpLIsZDAwMYOZ9QhgdIJXbY62yY0OAjAAIzSb1mAsjiF/4/VhAtZJUvnhu0IIQ6
 krOi5/aeKSDGbpBEK80LyCR1x/z/wX1AWlCG4zucz8iGaLGg3MTLw0qRhs6qMZrNcJI7knwuGil
 oZN2B7doAI4ypDDLl5BiFm7NMhmCPg==
X-Google-Smtp-Source: AGHT+IFuUS7Not1i5YzDB3gHy3ub9/hXvCvAwbQxzNqfeGQDqOoYZ6k6qPs0qszHy91ZjySfOh3ENQ==
X-Received: by 2002:a05:651c:210c:b0:2ff:7a4f:e770 with SMTP id
 38308e7fff4ca-30014eaa13cmr17797471fa.31.1733354087009; 
 Wed, 04 Dec 2024 15:14:47 -0800 (PST)
Received: from eriador.lumag.spb.ru
 (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30020e2085fsm158771fa.83.2024.12.04.15.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 15:14:45 -0800 (PST)
Date: Thu, 5 Dec 2024 01:14:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, Javier Martinez Canillas <javierm@redhat.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Simon Ser <contact@emersion.fr>, 
 Jeffrey Hugo <quic_jhugo@quicinc.com>, David Airlie <airlied@gmail.com>, 
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 amd-gfx@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 3/3] drm: remove driver date from struct drm_driver
 and all drivers
Message-ID: <couqmlshll3v6vgziqnt6sq7caf4nart42ljo5fbim3rg7ec5o@3ym66tyaytd2>
References: <cover.1733322525.git.jani.nikula@intel.com>
 <1f2bf2543aed270a06f6c707fd6ed1b78bf16712.1733322525.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f2bf2543aed270a06f6c707fd6ed1b78bf16712.1733322525.git.jani.nikula@intel.com>
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

On Wed, Dec 04, 2024 at 04:31:12PM +0200, Jani Nikula wrote:
> We stopped using the driver initialized date in commit 7fb8af6798e8
> ("drm: deprecate driver date") and (eventually) started returning "0"
> for drm_version ioctl instead.
> 
> Finish the job, and remove the unused date member from struct
> drm_driver, its initialization from drivers, along with the common
> DRIVER_DATE macros.
> 
> v2: Also update drivers/accel (kernel test robot)
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Acked-by: Simon Ser <contact@emersion.fr>
> Acked-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # msm

> 
> ---

-- 
With best wishes
Dmitry
