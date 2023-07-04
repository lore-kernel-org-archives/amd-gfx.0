Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ED7EB64D9
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jul 2023 17:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3854B10E2F9;
	Tue,  4 Jul 2023 17:07:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BAE610E2F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jul 2023 17:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688490430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cxitRDWtqKaSeISnWqetN+vP9rXpKkg2ERtZVvgyCDU=;
 b=O2qkVnSwsI1JNbinBKP85Q701qgtuCk6pWMjUNm005zWGObRZaD3ZoMJ0kUDuw8XjmoeA9
 DiboNPUEoRmN5nZOhf0+cfopasUSz3FQgNkHPm6ogr4y10m/cB2VkIBVLwu4y5q0ikqcId
 H+cuyW6c4+YMXjsywUE33X59DErQmbY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-s0fDDf-zPu6WNykIC-aNFw-1; Tue, 04 Jul 2023 13:07:09 -0400
X-MC-Unique: s0fDDf-zPu6WNykIC-aNFw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fb7ea6652bso5414730e87.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Jul 2023 10:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688490428; x=1691082428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cxitRDWtqKaSeISnWqetN+vP9rXpKkg2ERtZVvgyCDU=;
 b=gDvwczVwPJZFyQbXKepb67ODdjgiRx5LMnKgKlXYQsNPhlT76VAFGO/SATmTrm7LdH
 lX8BGGXPobZ+1wCB4zNS9OEIbdNAOmh8FdEma93zBaHTdnH+VtLrCCCfoQix8jTdpduN
 fA+MHHXeck2dJSaSx3ZzNqsikr6g0Ccm+ZyttjNh1f8Lg1jB+LdRzifwnb0EnDuoBhMg
 N9HkhS/VTrvsEv1DJhBfqitv4z2HoEORCuauSDUSLFEUY9gHg6ToquFBD1Tl4W3GFe2E
 eO31A8q7mKYZ4cRGr0E+2uzDHAALV9dwR2pPLEN0KDfx8kz+8kHXBlGZopxW2Z/B5p7L
 8wdQ==
X-Gm-Message-State: ABy/qLbcYpzf2M/8Xxt2tJ+ljnCOQV+KWGUnya8M/gkD4ZDa4rCeY5lJ
 vvkH8NUiDolsTyMRRM/bySsqe3hKiUK29mgG2zY3dCMJnQQWhHn5nGN1BBcB0V5WLqts/pWdc1q
 nP6uuOPTH8iPRCL3V6JAgxpotWx6vfU/h8/b5c3CzAw==
X-Received: by 2002:a19:500c:0:b0:4fb:745e:dd01 with SMTP id
 e12-20020a19500c000000b004fb745edd01mr9084731lfb.45.1688490428165; 
 Tue, 04 Jul 2023 10:07:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEtGg/VHsl594gLv/LD23psq2DZuofu/ztcmw5O3ofd1hrfk+5+Hy+SGLWPHtlMSbjFgCiDNab5FKJSs9aHqXk=
X-Received: by 2002:a19:500c:0:b0:4fb:745e:dd01 with SMTP id
 e12-20020a19500c000000b004fb745edd01mr9084715lfb.45.1688490427795; Tue, 04
 Jul 2023 10:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230701020917.143394-1-andrealmeid@igalia.com>
 <20230701020917.143394-2-andrealmeid@igalia.com>
In-Reply-To: <20230701020917.143394-2-andrealmeid@igalia.com>
From: Sebastian Wick <sebastian.wick@redhat.com>
Date: Tue, 4 Jul 2023 19:06:56 +0200
Message-ID: <CA+hFU4y+kHitNsqb1WC6dHE5hr=1S6gJeyHXC5mv9Ads5mdgWw@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] drm: allow DRM_MODE_PAGE_FLIP_ASYNC for atomic
 commits
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mimecast-Spam-Score: 0
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Italo Nicola <italonicola@collabora.com>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org, Pekka Paalanen <ppaalanen@gmail.com>,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 alexander.deucher@amd.com, hwentlan@amd.com, christian.koenig@amd.com,
 joshua@froggi.es
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Jul 1, 2023 at 4:09=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@igal=
ia.com> wrote:
>
> From: Simon Ser <contact@emersion.fr>
>
> If the driver supports it, allow user-space to supply the
> DRM_MODE_PAGE_FLIP_ASYNC flag to request an async page-flip.
> Set drm_crtc_state.async_flip accordingly.
>
> Document that drivers will reject atomic commits if an async
> flip isn't possible. This allows user-space to fall back to
> something else. For instance, Xorg falls back to a blit.
> Another option is to wait as close to the next vblank as
> possible before performing the page-flip to reduce latency.
>
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Co-developed-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> v4: no changes
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 28 +++++++++++++++++++++++++---
>  include/uapi/drm/drm_mode.h       |  9 +++++++++
>  2 files changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index d867e7f9f2cd..dfd4cf7169df 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1286,6 +1286,18 @@ static void complete_signaling(struct drm_device *=
dev,
>         kfree(fence_state);
>  }
>
> +static void
> +set_async_flip(struct drm_atomic_state *state)
> +{
> +       struct drm_crtc *crtc;
> +       struct drm_crtc_state *crtc_state;
> +       int i;
> +
> +       for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
> +               crtc_state->async_flip =3D true;
> +       }
> +}
> +
>  int drm_mode_atomic_ioctl(struct drm_device *dev,
>                           void *data, struct drm_file *file_priv)
>  {
> @@ -1326,9 +1338,16 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>         }
>
>         if (arg->flags & DRM_MODE_PAGE_FLIP_ASYNC) {
> -               drm_dbg_atomic(dev,
> -                              "commit failed: invalid flag DRM_MODE_PAGE=
_FLIP_ASYNC\n");
> -               return -EINVAL;
> +               if (!dev->mode_config.async_page_flip) {
> +                       drm_dbg_atomic(dev,
> +                                      "commit failed: DRM_MODE_PAGE_FLIP=
_ASYNC not supported\n");
> +                       return -EINVAL;
> +               }
> +               if (dev->mode_config.atomic_async_page_flip_not_supported=
) {
> +                       drm_dbg_atomic(dev,
> +                                      "commit failed: DRM_MODE_PAGE_FLIP=
_ASYNC not supported with atomic\n");
> +                       return -EINVAL;
> +               }
>         }
>
>         /* can't test and expect an event at the same time. */
> @@ -1426,6 +1445,9 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>         if (ret)
>                 goto out;
>
> +       if (arg->flags & DRM_MODE_PAGE_FLIP_ASYNC)
> +               set_async_flip(state);
> +
>         if (arg->flags & DRM_MODE_ATOMIC_TEST_ONLY) {
>                 ret =3D drm_atomic_check_only(state);
>         } else if (arg->flags & DRM_MODE_ATOMIC_NONBLOCK) {
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 46becedf5b2f..56342ba2c11a 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -949,6 +949,15 @@ struct hdr_output_metadata {
>   * Request that the page-flip is performed as soon as possible, ie. with=
 no
>   * delay due to waiting for vblank. This may cause tearing to be visible=
 on
>   * the screen.
> + *
> + * When used with atomic uAPI, the driver will return an error if the ha=
rdware
> + * doesn't support performing an asynchronous page-flip for this update.
> + * User-space should handle this, e.g. by falling back to a regular page=
-flip.
> + *
> + * Note, some hardware might need to perform one last synchronous page-f=
lip
> + * before being able to switch to asynchronous page-flips. As an excepti=
on,
> + * the driver will return success even though that first page-flip is no=
t
> + * asynchronous.

What would happen if one commits another async KMS update before the
first page flip? Does one receive EAGAIN, does it amend the previous
commit? What happens to the timing feedback?

This seems really risky to include tbh. I would prefer if we would not
add such special cases for now.

>   */
>  #define DRM_MODE_PAGE_FLIP_ASYNC 0x02
>  #define DRM_MODE_PAGE_FLIP_TARGET_ABSOLUTE 0x4
> --
> 2.41.0
>

