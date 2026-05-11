Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67673CD484E
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 23:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA35C10E902;
	Mon, 11 May 2026 23:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hkAeUVRc";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B24910E902
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 23:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778541122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0UCe28zV972AZiRYDMg8zfbzIHf06WRxGbzFTsKV4rk=;
 b=hkAeUVRcKy3yWV2CGUpfZPTR4wJoP1l4mwMV6z3RCpTFSEs4QH9b5UemYXB6DbHO5uWtrA
 nJLkEwJAM9HJfw2WwnXZk/nx9M7+E9XDv3ROdy1tvOLrGKNsKYBl3ejzpEKsSe/q20CHcP
 QQ1nZRSpJTDYMz+p6JpyOE7QAJac55E=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-OomPuNxGOyaKQzYYT-xx4Q-1; Mon, 11 May 2026 19:12:01 -0400
X-MC-Unique: OomPuNxGOyaKQzYYT-xx4Q-1
X-Mimecast-MFC-AGG-ID: OomPuNxGOyaKQzYYT-xx4Q_1778541120
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-367fd7b8825so2301919a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 16:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778541120; x=1779145920;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0UCe28zV972AZiRYDMg8zfbzIHf06WRxGbzFTsKV4rk=;
 b=eEwrsRYBMBfBtEDRmA9kHLcm3xdU8CEXQkmMJoe66kljiRngwxuwrhFWDzd/c98Dc5
 +PGdfc/ib/0D1uM1ZDyeFrs9VKLKWWRDmSbak1Ea9VjjqfrBy8m7CCFioo9h9NQFg/2K
 UmEbCgu+/CCT2zkgusJNHxjq9xFitaOYz+4+NWyr+PXMNJaFlk+nVHKjID5gjCjxbjg8
 79tTT48nqoWXLRVXCqFV5Pp8GQ854tj/oTPeZo6bgmaainmXwAG9t9GpVp+uIptmbdrF
 bF5v/bxA0uuTKiUq4MDGqQI7Xvg4zTinOZ5T6/kYwWGDkDIWQH50jHKQIwBBM7Ue2fjO
 NH6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/AO9U8ikqyFDM9EL65LY/ZK5/QZv58D6XnM9tXcEfUww6q8jZa4yKQ012nXurZtta3WcGR6nJB@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxc14kZ0vko8l+FLBdsncNiEn+p2vTt9JePiACOvmDYG6hVuOKS
 7urPwkGpAATpkxB2DKcGg8a1tS9N4UseVwYyZJs+FvJFjeTdxbGxFLI/aLajIvwkB1gM7gJgDSr
 F5VmUY9i5CrkGCJJrUbFWy6xj5lbIXtonES8weZvyXioQH7EqU9+S5C6HgH6TQmJfRPQywxcWM8
 X1JclRKCxnd7i4ucP3gjcervj1WGFGLtWfXijs7fALmQ==
X-Gm-Gg: Acq92OEmtXHr+VGmfg5lkJVpg4E8Tg4/0is0QkLXzVizl7C7D8ASgvLP9T+VgEE7LjA
 sAYpDy5mqaEKAaxDZuL2iITNSFWdzLJee/FqMe8ZTuR0huvzPSMroAzVAGC2jZnDRl5FugX3qXa
 eXl5vAsdSbPqr8EDrQYQqh+iHE26I8Xi5Kj1MiokAI13NMgPLB3GIvgqGYpUjyO2ST9WHB+1dR1
 GKwcpxZ4hqxdI2OivsONefk0TFPbmLWXZ5wPzY=
X-Received: by 2002:a17:90b:3c0e:b0:366:4a47:f26d with SMTP id
 98e67ed59e1d1-367d4890ab9mr11754009a91.14.1778541119966; 
 Mon, 11 May 2026 16:11:59 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0e:b0:366:4a47:f26d with SMTP id
 98e67ed59e1d1-367d4890ab9mr11753982a91.14.1778541119467; Mon, 11 May 2026
 16:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260424220953.167058-1-mario.limonciello@amd.com>
In-Reply-To: <20260424220953.167058-1-mario.limonciello@amd.com>
From: Sebastian Wick <sebastian.wick@redhat.com>
Date: Tue, 12 May 2026 01:11:48 +0200
X-Gm-Features: AVHnY4Lm9uuWDwEERXpiOWtAgRKphjtR16AykzOhcOiW8C0tKuItbULL4Vrthtk
Message-ID: <CA+hFU4wEODFP=oPw522MyQs1asGq+KyYw6rcKpxxxj0y75fPXg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Add support for a DRM backlight capability
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com, 
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <superm1@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MfAjRQ6EB9YHlVuovTpIKR3ZCNdg5bNSldbfpn5oZsQ_1778541120
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

On Sat, Apr 25, 2026 at 12:10=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> From: Mario Limonciello (AMD) <superm1@kernel.org>
>
> At Display Next Hackfest 2025 we discussed the renewed need for moving
> brightness control into the DRM connector properties.  I've taken the
> previous efforts from David and Marta, rebased and adjusted for the
> current kernel.

Thanks a lot for this!

I've wired it up for mutter but I don't have a machine with AMD
graphics and an internal panel, so I can't really test it.

https://gitlab.gnome.org/swick/mutter/-/commits/wip/kms-luminance-prop

I've also noticed a few things while doing so:

1. There isn't a bit of information which tells user space if the
property is actually backed by anything
2. A fixed range from 0 to uint16_t max might be problematic for
backlights with very few steps

Could maybe fix both of those issues by making the range dynamic to
the actual numbers of steps, where zero means that there isn't any
backing backlight device.

> The legacy sysfs interface is synchronized with the DRM connector (althou=
gh
> the scale may be different as DRM connector property is u16).
>
> Later after this has been adopted by enough userspace, it may make sense =
to
> configure the legacy sysfs interface to be configurable so that only
> DRM master controls backlight.
>
> I've done a first implementation with amdgpu with eDP connectors; but
> conceivably this can be extended to other connectors like DP for displays
> that can be controlled via DDC as well later.
>
> I have also used DRM review prompts to review this series and fix some bu=
gs
> which were caught with two different Claude models.  The fixes are squash=
ed
> into the patches.
>
> Assisted-by: Claude Opus
> Assisted-by: Claude Sonnet
>
> For ease of testing; this series is also available on this branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=
=3Dsuperm1/backlight-property-v3
>
> David Rheinsberg (1):
>   backlight: add kernel-internal backlight API
>
> Mario Limonciello (6):
>   drm: link connectors to backlight devices
>   DRM: Add support for client and driver indicating support for
>     luminance
>   drm/amd/display: Pass up errors reading actual brightness
>   drm/amd: Indicate driver supports luminance
>   drm/amd/display: Allow backlight registration to fail
>   drm/amd/display: use drm backlight
>
> Marta Lofstedt (1):
>   backlight: expose the current brightness in the new kernel API
>
>  drivers/gpu/drm/Kconfig                       |   1 +
>  drivers/gpu/drm/Makefile                      |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  88 +++-
>  drivers/gpu/drm/drm_atomic_uapi.c             |  24 ++
>  drivers/gpu/drm/drm_backlight.c               | 406 ++++++++++++++++++
>  drivers/gpu/drm/drm_connector.c               |  12 +
>  drivers/gpu/drm/drm_drv.c                     |   8 +
>  drivers/gpu/drm/drm_ioctl.c                   |  10 +
>  drivers/gpu/drm/drm_mode_config.c             |   7 +
>  drivers/gpu/drm/drm_mode_object.c             |  66 ++-
>  drivers/gpu/drm/drm_sysfs.c                   |  54 +++
>  drivers/video/backlight/backlight.c           |  83 ++++
>  include/drm/drm_backlight.h                   |  45 ++
>  include/drm/drm_connector.h                   |   8 +
>  include/drm/drm_drv.h                         |   7 +
>  include/drm/drm_file.h                        |   8 +
>  include/drm/drm_mode_config.h                 |   5 +
>  include/linux/backlight.h                     |  30 ++
>  include/uapi/drm/drm.h                        |  10 +
>  20 files changed, 852 insertions(+), 23 deletions(-)
>  create mode 100644 drivers/gpu/drm/drm_backlight.c
>  create mode 100644 include/drm/drm_backlight.h
>
> --
> 2.53.0
>

