Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321FEC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 14:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 187A410E2B7;
	Thu, 29 Sep 2022 14:13:26 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA2210E2B7;
 Thu, 29 Sep 2022 14:13:22 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-131a7bce1acso1938653fac.7; 
 Thu, 29 Sep 2022 07:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=mloVIeljer3m4x3IP6zAVZuCniwYsBfPjozV1XjLZow=;
 b=LE/nSUG2sHQ/+H++WAaLzzsIBuq/3YWsc/o4Cf1YI3Xd+LcSi8f0TBy1MqScX00ozT
 1W/+yvIMxQxm9fq5PYrlP+SjqEhcHBZ0sdmaaRNZZw3CAzTERC6WgsVDZ9SStwLE0QlL
 yVB9v2Hh11KRx58IJ55B+nf/2ukYqd4WFS50qCfG22zxkXPLHVBnMnLMa0qhT8fRQ4E/
 6033HJ50CbdMGvrf88+UCMsJMDbYMdAJW16Ow0AltInVRd3h/NjGFaznnBAhFAbsZeqE
 lSbl+yNpCYTfKHmYEYLtV8IC71cZjkMA/oFGKRH0uDqt7TZWuIApv4NWDjFMnlL6nsnp
 /71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=mloVIeljer3m4x3IP6zAVZuCniwYsBfPjozV1XjLZow=;
 b=WATxTri/41gMx2oWz2ndV0ynDNdVovAxvOsgbSs/h5KslqygA3PtLnn9oZ/asiOi6C
 nr7DaaDpCNcNzdRKvfedRCqPAz057PDU7XHZsrf43i+GdREseCnhpK0jMK8pF1twUIFy
 i1VJD4onV5HK6RA2VQg/eANkRtdFch1NWSS+3EOo4kl1taQw7yoz8CttcdsjIa4rUnjk
 fNT9Jg6krnjqHRoJ9VGM++zX6BAaLqyMqSRLUAnjXjQKRE5fAtu0C3EN+WVVCkl7yl1Y
 gQe/SjHRIC8AsNVPO9fOeeSNXsAuOzyqtDjJiQoGU+DxE7wiKTzJLipj0nSVQS+gYT4P
 VLZQ==
X-Gm-Message-State: ACrzQf3T8hXpdJMohNrNxRDWHQxb6LEx3iyZE4DS3WCs4PnrAVA3u42V
 h4WW7IPCgRJWGguVzM0Dk/lUUsfVQQahAwC6IqA=
X-Google-Smtp-Source: AMsMyM5Abrogb9L+PSYxClr7zcD7GHO9mVSXAGr7zMh/FUb9Jj419xqale6vPsxVV5JO47kUfxb3ic5pfKDTmWmQ3SA=
X-Received: by 2002:a05:6870:c5a4:b0:131:6edd:3955 with SMTP id
 ba36-20020a056870c5a400b001316edd3955mr1991343oab.96.1664460801749; Thu, 29
 Sep 2022 07:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220830172851.269402-1-contact@emersion.fr>
In-Reply-To: <20220830172851.269402-1-contact@emersion.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Sep 2022 10:13:10 -0400
Message-ID: <CADnq5_NiWYaVoSDSjhqiJUd2NmmE9v_sXnYyfO_NsHzty67+eQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Add support for atomic async page-flips
To: Simon Ser <contact@emersion.fr>
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
Cc: andrealmeid@igalia.com, daniel.vetter@ffwll.ch,
 amd-gfx@lists.freedesktop.org, wayland-devel@lists.freedesktop.org,
 mwen@igalia.com, dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
 hwentlan@amd.com, nicholas.kazlauskas@amd.com, joshua@froggi.es
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Aug 30, 2022 at 1:29 PM Simon Ser <contact@emersion.fr> wrote:
>
> This series adds support for DRM_MODE_PAGE_FLIP_ASYNC for atomic
> commits, aka. "immediate flip" (which might result in tearing).
> The feature was only available via the legacy uAPI, however for
> gaming use-cases it may be desirable to enable it via the atomic
> uAPI too.
>
> - v1: https://patchwork.freedesktop.org/series/107683/
> - User-space patch: https://github.com/Plagman/gamescope/pull/595
> - IGT patch: https://patchwork.freedesktop.org/series/107681/
>
> Main changes in v2: add docs, fail atomic commit if async flip isn't
> possible.
>
> Tested on an AMD Picasso iGPU.

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Simon Ser (6):
>   amd/display: only accept async flips for fast updates
>   drm: document DRM_MODE_PAGE_FLIP_ASYNC
>   drm: introduce drm_mode_config.atomic_async_page_flip_not_supported
>   drm: allow DRM_MODE_PAGE_FLIP_ASYNC for atomic commits
>   drm: introduce DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP
>   amd/display: indicate support for atomic async page-flips on DC
>
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 ++++++
>  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 10 +++++++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |  1 +
>  drivers/gpu/drm/drm_atomic_uapi.c             | 28 +++++++++++++++++--
>  drivers/gpu/drm/drm_ioctl.c                   |  5 ++++
>  drivers/gpu/drm/i915/display/intel_display.c  |  1 +
>  drivers/gpu/drm/nouveau/nouveau_display.c     |  1 +
>  drivers/gpu/drm/vc4/vc4_kms.c                 |  1 +
>  include/drm/drm_mode_config.h                 | 11 ++++++++
>  include/uapi/drm/drm.h                        | 10 ++++++-
>  include/uapi/drm/drm_mode.h                   | 11 ++++++++
>  11 files changed, 83 insertions(+), 4 deletions(-)
>
> --
> 2.37.2
>
>
