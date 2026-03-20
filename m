Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BC61099B3A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 20:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026BF10EB10;
	Fri, 20 Mar 2026 20:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="RhHsNnN/";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD8510EB04
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 20:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774038439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AJMXPSFWArYmrnP7zLSkM+CTFVv6oJClq2Ka1iADR9M=;
 b=RhHsNnN/i7WVOmW6KhKvohRwQtvEIeLF3rrePujJJC8AtmY7ey8sMvbaxAmX8pqqMPyLBl
 OzdOaW6fK9ZIRWO6a5Sd1Jn8cwHLlVhxD9Pu3/uwVB7AiK8lEjgp6QkYgbxp7g//zv9FpS
 nk6/UkE9WL09aj4FsqZAS7XuwXlP2Uw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-xtNd_MRMNUKlOGknk7A2Hg-1; Fri, 20 Mar 2026 16:27:17 -0400
X-MC-Unique: xtNd_MRMNUKlOGknk7A2Hg-1
X-Mimecast-MFC-AGG-ID: xtNd_MRMNUKlOGknk7A2Hg_1774038437
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89c50acdd4eso134101496d6.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 13:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774038437; x=1774643237;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MB0+rSNGBKBl0fATluwYhfYR/8s/ouHiFI/my1DN3XI=;
 b=IdyM1tWlj1nujkFi3X4OO0JnciPHmj3AwmbP86sZGqYx3yVc/M/LQc0cM9Vd1Jgbdy
 +m2ywGYRTU98UrphwW4TMBQiCbhqLwk6CogN/MuVVzrnBti3CgwoG7lf8w4zXjqFV5rU
 mkSzphi1jvowEDaiE0ZxIglWCgmJKFH1W0lmHYx6kSgcMkeFWjFTwUtV6qkfmSZ+E7sQ
 juadzFEa+3r7RKoo35XJxKOB4cBM3jhoZeisJWMRLhGtM78g7oLrDKUykF2B4VpSjY/d
 d1ccno6sjibrLci1NdlxZ+yS0A7ASrmRqHabbpbPn/Dn9bazHZcDGMbnO7rGxL+3LknJ
 YBjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLDHz08tcIOA/ymlHCsYHkD/fjgrtWr+rojU+ralWZG3T/gprj6FWnZ1RE9ruUaJXHcyOt/hhZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywwUiebTRS59qzMY5adcyFxLnGalIt8ftXrzM7GQCLsp0F4EzC
 zjcE6w7lwWLF/RPPiB3xErcI8RkjuRJUrTuGwN3EyB6GIi+b8XJowR/fpCrMGTVxyJWVTNeSxX/
 JciQAljCHADRrjM06xr0Dqgi0WPc6UTuE9Yh3jti8ZFV7ZrDIrjySrTfV9Ah2/kF8ONc=
X-Gm-Gg: ATEYQzwt3zHa9bs3M22NCOXFckYppzgmecg25D27b8d98vyDJpbbREuu4TH7ujunGnX
 ahzHxIEpWG6PZiw8gmsneg/x4xxXjBVvbuNXWF6Yh69OrwxeBZmCsB0Xh4VQGpNfkmedxR19JfE
 Frx7PYY9yzqbMuTx0N2u9gPFGPAYa/C/ksCY81qi1BltjRq3zKlKEAh70PoVPIuZVYM8+D0pnXN
 TMHHaDoSpCK7fUeo6Nhghcr7m3KFn3+J6zLRFEjXWk3F6N4AZ2VFpDZqCU+3MvZAFXJZ7c1iq8I
 wWzHbId/o8lnlh3t6zF2HolQ2rS7XGEgi/G8VP9Y0VnzBOLE8sZGV6vM+kZI+99c2ay6hmvUGbv
 dTextHHOIJGOrY5wkVw==
X-Received: by 2002:ad4:5968:0:b0:89c:4ea7:a70f with SMTP id
 6a1803df08f44-89c859e8c82mr70322256d6.14.1774038437334; 
 Fri, 20 Mar 2026 13:27:17 -0700 (PDT)
X-Received: by 2002:ad4:5968:0:b0:89c:4ea7:a70f with SMTP id
 6a1803df08f44-89c859e8c82mr70321736d6.14.1774038436929; 
 Fri, 20 Mar 2026 13:27:16 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c85361ac2sm27015786d6.41.2026.03.20.13.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:27:16 -0700 (PDT)
Message-ID: <5cbcc6ff5b5dd72e0c4737cdff8ef897fa10cb61.camel@redhat.com>
Subject: Re: [PATCH v11 43/65] drm-dyndbg: DRM_CLASSMAP_USE in nouveau
From: lyude@redhat.com
To: Jim Cromie <jim.cromie@gmail.com>, airlied@gmail.com, simona@ffwll.ch, 
 jbaron@akamai.com, gregkh@linuxfoundation.org, Danilo Krummrich
 <dakr@kernel.org>,  Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann	
 <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: jani.nikula@intel.com, ville.syrjala@linux.intel.com, 
 christian.koenig@amd.com, matthew.auld@intel.com, 
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Date: Fri, 20 Mar 2026 16:27:15 -0400
In-Reply-To: <20260313132103.2529746-44-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-44-jim.cromie@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _WbV8JsGZ8XIv5DPhwkc-zLg1kLi9EN1qifCUiUrld4_1774038437
X-Mimecast-Originator: redhat.com
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Fri, 2026-03-13 at 07:20 -0600, Jim Cromie wrote:
> Following the dyndbg-api-fix, replace DECLARE_DYNDBG_CLASSMAP with
> DRM_CLASSMAP_USE.=C2=A0 This refs the defined & exported classmap, rather
> than re-declaring it redundantly, and error-prone-ly.
>=20
> This resolves the appearance of "class:_UNKNOWN_" in the control file
> for the driver's drm_dbg()s.
>=20
> Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2
> helpers, 3 drivers.")
>=20
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_drm.c | 12 +-----------
> =C2=A01 file changed, 1 insertion(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c
> b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 5d8475e4895e..d205b58aff70 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -74,17 +74,7 @@
> =C2=A0#include "nouveau_uvmm.h"
> =C2=A0#include "nouveau_sched.h"
> =C2=A0
> -DECLARE_DYNDBG_CLASSMAP(drm_debug_classes,
> DD_CLASS_TYPE_DISJOINT_BITS, 0,
> -=09=09=09"DRM_UT_CORE",
> -=09=09=09"DRM_UT_DRIVER",
> -=09=09=09"DRM_UT_KMS",
> -=09=09=09"DRM_UT_PRIME",
> -=09=09=09"DRM_UT_ATOMIC",
> -=09=09=09"DRM_UT_VBL",
> -=09=09=09"DRM_UT_STATE",
> -=09=09=09"DRM_UT_LEASE",
> -=09=09=09"DRM_UT_DP",
> -=09=09=09"DRM_UT_DRMRES");
> +DRM_CLASSMAP_USE(drm_debug_classes);
> =C2=A0
> =C2=A0MODULE_PARM_DESC(config, "option string to pass to driver core");
> =C2=A0static char *nouveau_config;

