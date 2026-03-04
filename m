Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002F4EF8FF8
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 15:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 615E210EA30;
	Wed,  4 Mar 2026 15:32:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DgejnDls";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E8D410EA44
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 15:32:41 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2be21f91e58so148847eec.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Mar 2026 07:32:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772638360; cv=none;
 d=google.com; s=arc-20240605;
 b=NbWh9OMQ6WNqRZMTcJ1Y9z/mCQph86jztuJZL8P7dF7JvYREp8jfkIkLT0WST+trpk
 1OzyephLF/04U54jUWTEQUzrRZHVWqLVBSA0tBkF8S+kYob2t7vTBix0fc4o2FqijsWs
 2P8gRLxIJh+zUT2xHQmDQpia9nEDqpRi2h8E2ItlWmbd/krt+9aE5DX0E+ji7pyhF3Kp
 ajMFypSLijD5KLenUnb6QRke7Z5rhCM61eBfwA/l5Ddn+REzR41j+RW4CuoNDE1a+1GH
 +B+8JB2D+sIj7A3TAjPvEzc80vG1abDWlO8v0xIYNj355okvFzbjHvNQeid7I1WfjbbH
 Avuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KYv4PP2uEvL51Fzv0RGNmZxfT3KZdCrW4OS259XvvQI=;
 fh=DYq7nmuotv9Ts6g9maR73X+n+rd/1bOHDIyBuuJqo6k=;
 b=d/r+pfQTbOQhIFMEbUgiCg9FO978mGqOxk4yG2RUsXNzbo2PuDudF2MuLh+LNGsgLp
 xugtXYzSzNmG4+zpgu67qHpPRh0T75VmN5egFVE6l21SmHphuLJrwHoDcQKaegkP991B
 jCGhknxEm3XIXde6bLWXWoOPbHaaJvUHpPWQNB1ujvtevkUyUTLw26gbc4TfslTHDYUU
 XhabwLRwL9gry9Eh/7p4ADJJ3rZGURUgnHy8+SOI3Iw3oh7hffOpwvxH1jC4ah5LmuuM
 MDlqh/7Nr60fzxANk+ArofGfDBmFrBrZTe75m7Wvh57y9hKAOHtqCElEsx134IXZmQyj
 DU+w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772638360; x=1773243160; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYv4PP2uEvL51Fzv0RGNmZxfT3KZdCrW4OS259XvvQI=;
 b=DgejnDls/Y/offzyNKarHbrED2jwW2YCrpb0qVgzTP2u2I1GnTYAKQqhth7NZ2SI7u
 1dUU6Q64cFkM6m3kcGinE5B1kCVEs/nkloa+NAYHFnKSWubD6V2sMAXcXJxnAtH5hTLq
 u5Lrv739orWqX4GMy16s0qGC7TPaG55kXZzPdMASvbCmdxEqeZcZgA2qbyh63zZB7YK8
 147r00oNIbPjELZqL5eJGPx1bYOL/1o1jg24tZNti6gF8ydAqdgilBQQ6oRRBjPuVy39
 DGNRwEAggfLpcTRdHx/MGN94YhkXupI3fwC13n2H1Y5Vf5w+SVpk50lEEWEGMG3bl+8Z
 Xv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772638360; x=1773243160;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KYv4PP2uEvL51Fzv0RGNmZxfT3KZdCrW4OS259XvvQI=;
 b=Uo5EKX4iySbsDs4xlVFdKXw/2MU1iRaFaPMCv/EA9h9uNtwi3oQOXDO+aj4Qfll/wO
 QHynjWUfu0UtSIM/dw72AI8kWVZb3ijiDBPSqmhu0uI/bhrudGFiBpuhy93BwFMajbpf
 nk00+6IgdbbQHWP7Bf/mzcg9pJu97WNG8TL4iv+9n2iDgq4LKVlVedvnfkRVcz/FfJ0T
 AYA4opb6lihXZsqrCZHKDA+SNuXMrAkZ1+rMhoN3+VA5jqGWvzOCBdOBylRfOJ4/RjUc
 sawnmxkD/I497p7tjlKFaLLFI+GFHH9Rsb9Ukay2BV6GeWoNOOHocuUMxsz4hWbMGO7B
 tGzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtPlt5J5pnIc6YXpQvzZue+8/Y88VNk2YTuw6qIxKxKfjL1upwSzd5RX+gfShUtNv4rqqQLXsc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPv9BbuYePLonNYQghPcei37gunS2919E9+yf4Og39Qx/gdlZB
 Extb4vvP2SjMUwlyZQNay4bxO46oGaa3hBHg9ws0Hg87sXIARYyh5NtgdkJS9Btd85+dFXuwU4w
 wE/o7zImPzOpCROVUCmN64KWI+Q8hmh4=
X-Gm-Gg: ATEYQzz+1QoZLgUl7WvYhfzMhu/DwCH6kcJoH2HVoOat5EOBkWg65pCWu/58R4dBXW3
 sTsY4jWXBC3W/GJbE48oKVECV9BLT3HmyyxNYuctXSWVRNX2tvK6ts5LVcWLmf8Ga5AVZ/Zadjx
 avj04bq1S/0lHhf7qStIJRq/LJ4FzBx+BSLN9zdvWvbevLODvIhl0+KZighDV2fqNIpDUowiAAh
 IlAlGySPr/U/IGRkUebg2DdqJUY/M6nvZA10/nfDxpXYJzQoNQd13UCCl573w8MMt9pc7Q1BTDi
 Qpb86emVpwehnZx8xbmn4X6R/EjK3cHD3cnlD9Hhv6uCjWQPL3zuRHg1SOlcj+pRUXdWlQ==
X-Received: by 2002:a05:7022:44:b0:127:1186:812f with SMTP id
 a92af1059eb24-128b70d3621mr513183c88.7.1772638360316; Wed, 04 Mar 2026
 07:32:40 -0800 (PST)
MIME-Version: 1.0
References: <20260304130250.59008-1-tzimmermann@suse.de>
 <20260304130250.59008-3-tzimmermann@suse.de>
In-Reply-To: <20260304130250.59008-3-tzimmermann@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Mar 2026 10:32:28 -0500
X-Gm-Features: AaiRm534esRrXZBHpNNKTIK1pnZprllOmefgM8hv06GL0SY8C4uPIjHNf-makYY
Message-ID: <CADnq5_NyHuvQfggvZ2aUJ4uv_3HAwKTA5fYWxQej1=QtF7PJBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/radeon: Test for fbdev GEM object with generic
 helper
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Wed, Mar 4, 2026 at 8:03=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
>
> Replace radeon's test for the fbdev GEM object with a call to the
> generic helper.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Did you want me to pick these up or did you want to land them in drm-misc?

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_device.c |  7 ++++---
>  drivers/gpu/drm/radeon/radeon_fbdev.c  | 17 -----------------
>  drivers/gpu/drm/radeon/radeon_mode.h   |  5 -----
>  3 files changed, 4 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/rad=
eon/radeon_device.c
> index 5d523d5dae88..705c012fcf9e 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -37,6 +37,7 @@
>  #include <drm/drm_client_event.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_device.h>
> +#include <drm/drm_fb_helper.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_probe_helper.h>
> @@ -1574,7 +1575,6 @@ int radeon_suspend_kms(struct drm_device *dev, bool=
 suspend,
>         list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
>                 struct radeon_crtc *radeon_crtc =3D to_radeon_crtc(crtc);
>                 struct drm_framebuffer *fb =3D crtc->primary->fb;
> -               struct radeon_bo *robj;
>
>                 if (radeon_crtc->cursor_bo) {
>                         struct radeon_bo *robj =3D gem_to_radeon_bo(radeo=
n_crtc->cursor_bo);
> @@ -1588,9 +1588,10 @@ int radeon_suspend_kms(struct drm_device *dev, boo=
l suspend,
>                 if (fb =3D=3D NULL || fb->obj[0] =3D=3D NULL) {
>                         continue;
>                 }
> -               robj =3D gem_to_radeon_bo(fb->obj[0]);
>                 /* don't unpin kernel fb objects */
> -               if (!radeon_fbdev_robj_is_fb(rdev, robj)) {
> +               if (!drm_fb_helper_gem_is_fb(dev->fb_helper, fb->obj[0]))=
 {
> +                       struct radeon_bo *robj =3D gem_to_radeon_bo(fb->o=
bj[0]);
> +
>                         r =3D radeon_bo_reserve(robj, false);
>                         if (r =3D=3D 0) {
>                                 radeon_bo_unpin(robj);
> diff --git a/drivers/gpu/drm/radeon/radeon_fbdev.c b/drivers/gpu/drm/rade=
on/radeon_fbdev.c
> index 18d61f3f7344..3e243f5e2f44 100644
> --- a/drivers/gpu/drm/radeon/radeon_fbdev.c
> +++ b/drivers/gpu/drm/radeon/radeon_fbdev.c
> @@ -274,20 +274,3 @@ int radeon_fbdev_driver_fbdev_probe(struct drm_fb_he=
lper *fb_helper,
>         radeon_fbdev_destroy_pinned_object(gobj);
>         return ret;
>  }
> -
> -bool radeon_fbdev_robj_is_fb(struct radeon_device *rdev, struct radeon_b=
o *robj)
> -{
> -       struct drm_fb_helper *fb_helper =3D rdev_to_drm(rdev)->fb_helper;
> -       struct drm_gem_object *gobj;
> -
> -       if (!fb_helper)
> -               return false;
> -
> -       gobj =3D drm_gem_fb_get_obj(fb_helper->fb, 0);
> -       if (!gobj)
> -               return false;
> -       if (gobj !=3D &robj->tbo.base)
> -               return false;
> -
> -       return true;
> -}
> diff --git a/drivers/gpu/drm/radeon/radeon_mode.h b/drivers/gpu/drm/radeo=
n/radeon_mode.h
> index 088af85902f7..ae1ecdc2e189 100644
> --- a/drivers/gpu/drm/radeon/radeon_mode.h
> +++ b/drivers/gpu/drm/radeon/radeon_mode.h
> @@ -936,14 +936,9 @@ int radeon_fbdev_driver_fbdev_probe(struct drm_fb_he=
lper *fb_helper,
>                                     struct drm_fb_helper_surface_size *si=
zes);
>  #define RADEON_FBDEV_DRIVER_OPS \
>         .fbdev_probe =3D radeon_fbdev_driver_fbdev_probe
> -bool radeon_fbdev_robj_is_fb(struct radeon_device *rdev, struct radeon_b=
o *robj);
>  #else
>  #define RADEON_FBDEV_DRIVER_OPS \
>         .fbdev_probe =3D NULL
> -static inline bool radeon_fbdev_robj_is_fb(struct radeon_device *rdev, s=
truct radeon_bo *robj)
> -{
> -       return false;
> -}
>  #endif
>
>  void radeon_crtc_handle_vblank(struct radeon_device *rdev, int crtc_id);
> --
> 2.53.0
>
