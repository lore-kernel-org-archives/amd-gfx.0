Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF75CD6E4C
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 07:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 815C910ED1D;
	Thu, 28 May 2026 07:29:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HgTHkkXs";
	dkim-atps=neutral
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1598110E262
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 16:31:33 +0000 (UTC)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-65c477a3278so12150738d50.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 09:31:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779899492; cv=none;
 d=google.com; s=arc-20240605;
 b=azQoynpX33EzpwjFl6r+h5b5UUzIRv1PFAbCAb9H5Cch0jrsOabTiUj1tbTM74upLl
 phX0AcwQO2MRiBYobw6WbPHEB8mpDmkwWZAWFDJypWeTm9FYxajzwSmwr4uOmoNofEyd
 bhiQQwgUAoWwj0YGPKd88yKOYK8QI/7IeNCH5furiKvPtTz8fT+zSvsXOb2GU817aIrV
 aYiZ+L0ldQc2klugWsvkyfilB0V8al/GQF4LzJZVJjwHJWIBm5KEUdLDhWIL4C2gSLFg
 z13D4gSTUWPDvaMmituRRLUU116a6PHrrGq8HpYIA/SR7S8R4/pkdUvdBvC+n0Z7jClk
 mz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9tLf8lt1YoAuBidXkoX7o9PfBwuIjJNOIKz1xekd6O8=;
 fh=ayRqx3dXxB5T6J1sKtvX6ZXjY0pF42Wr914CRkD6ujw=;
 b=IcBxDnE0q/7RnjINpzvurhCSbVcYpqVdEzFRZGF5iL1S3zDEBrHLsFiKNekNhh1YAK
 dFcHTK1HW6Z4R8DdOAuz+ynlWzCf+4GeN4cd/HmgFtX//+5jZz1gPSMS+camRdg0ojjv
 +A3etk4jLkpGouVFSUjkA0OKClbuD+V2zX3k2UPEbR5dlOTgmyebfK0boEAEJ7G8w6ZI
 TSQ0cIZ6rEsnRCDEdqgqXImGODJF/hLbsb8fT13SKCPu1Qcv7UrVKddd7IUQ718jptVf
 7r2bmTlRA21PWQduEtJVVMBgkHCVCsjr2QJEvsWln/fLohSJSK8aEkDplcZZYxPfr3SP
 A+Tg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779899492; x=1780504292; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tLf8lt1YoAuBidXkoX7o9PfBwuIjJNOIKz1xekd6O8=;
 b=HgTHkkXs1YFtJgdmjxxPR2z72ubtM+as7l37XQ2VN55lTUEkJBMJuywBSlctIswxlm
 xp9wFZBdUgyGKMJ3Gs6/oqMhwLInDsfdetp9FwQDtZ24W3a7vbWGMKpr4v1/rWox6Dga
 uE9dcomPb9JFzqpg/Ekg7wSiIR+BDs+2GF4QDa1OHTWW6WiFu7val09x5Mh08K/FcQV8
 7wrUP0yB0tWZ0rrWCXot6Ptv5XrPLeeLxnw8E3jyLPJDt1ekPcJpxMxQPcHYPKZVJ1rw
 jtbS+mQ89/DtWqyLhyWUnXe17bwJue4IWx+M+2HI1XqMb7B5WB6GoZseJmq8YJ6QHYWm
 WnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779899492; x=1780504292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9tLf8lt1YoAuBidXkoX7o9PfBwuIjJNOIKz1xekd6O8=;
 b=dQVLeBqk+QbiXf5kEHxH7j7miJhs51HulujzQR1FvnluqGmrhqzMmP1rlMUqAl2T+F
 mjA780sbYUbtape4xT2dd96iYYjTZ1yTRfjLoOsbWH4oKCoNz6qGU5cZCHc/FpIwV1w3
 SGqKEyxPn6oK4HaYqfgZq3FxV0SSjUvTqV4fH+yVZbP66QiEIg9NGmuHk4SR8RKnyiWK
 1v+1T916pO8mWcWVDauKNwSkHAL2T2Vs3XdF1I83gyg4qJsCfj9zqZK9UbM9gA9OLxdP
 hUdpkI+ZVMFLBBr0o9o0OL3MJXZB1ErcY+lRRNBOJln9gE8ki4oI6rWolF03L8CL2lGO
 2xbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8b5Gkm6jj1etu0M/sEf+sRX0pUxRjWGfMRLkvkHW2/0JDEsqs7bHkzePLQUl7bU/Cit1m1D8CQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTtLBeL7a9klAt79ZM5nXj397tcpyQLVKCDZc4Ue6JAFOefEK/
 AligW1ShbLzOIDmejWHN6pTFpAF7RoDN5BDFoLelBz6hD0I6SnRAABwArQM7qt520RuhaKKwIkm
 /6BWdy7YVHQTKBSpQWGKBLEJzOBmaQ0I=
X-Gm-Gg: Acq92OG41AavTn8U7xo2k+Nk57cptHi39HdTxdt829bAra4X2szFq1VmxMFZUGORLEZ
 lduPqhf9HiMBEs2nUizqiZ69r42aUwdB+8MBcZQ1dYK6vqPI73F0/MsuLVIhttEt3Bs8yRowEC5
 onFhVG639/z9jPKkC6In9eRyezrE8Rwinny+teJIrMQw6Y4d10DJ3zjc/KLolMPaCYLY142nGqX
 uglI7I7AD1v+GYbQfH2/9G9xm/eMgTWw3wglBWYI+xwmFhk+2MYRdQ7lOUQKcJA0jWh7aGv5/kJ
 DVlkUPRgmgfWwQWwVCuq8jwTMuLQTnooxmScLbkvrG4zZgzeztBgt32SKNnvvxtiwl1TNeKi
X-Received: by 2002:a05:690e:158f:10b0:65e:14b6:b1c3 with SMTP id
 956f58d0204a3-65ec965c9f8mr17896814d50.16.1779899491716; Wed, 27 May 2026
 09:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260527133917.207150-1-tzimmermann@suse.de>
In-Reply-To: <20260527133917.207150-1-tzimmermann@suse.de>
From: Julian Orth <ju.orth@gmail.com>
Date: Wed, 27 May 2026 18:31:22 +0200
X-Gm-Features: AVHnY4LiGKeklklqrya8rDzPqcZQqpOuXv9liIo0k9FzrL8MbPYNMzvo_QUUG_E
Message-ID: <CAHijbEVZBRTK7yhZy8gaZwb19JMzUD_nA2S1LOKX2NrK19RBsQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] drm: Limit DRM_IOCTL_WAIT_VBLANK to vblank
 interrupts
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, airlied@gmail.com, mdaenzer@redhat.com, 
 pekka.paalanen@collabora.com, jadahl@gmail.com, contact@emersion.fr, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, mhklinux@outlook.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 wayland-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, 
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 28 May 2026 07:29:41 +0000
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

On Wed, May 27, 2026 at 3:39=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> DRM's WAIT_VBLANK ioctl synchronizes user-space clients to display
> refresh. This is meaningless with vblank timers, which run unrelated
> to the hardware's vblank.
>
> Disable the ioctl for simulated vblanks. Set DRM_VBLANK_FLAG_SIMULATED
> for CRTCs with simulated vblank events in all such drivers. The vblank
> timers of these devices still rate-limit the number of page-flip events
> to match the display refresh.
>
> According to maintainers, user-space compositors do not require the ioctl
> for rate-limitting display output. Weston, Kwin and Mutter rely on comple=
tion
> events. Mutter optionally uses the WAIT_VBLANK ioctl only to optimize the
> time from input to output.
>
> When testing with mutter and weston, the page-flip rate appears correct
> with the patch set applied.

To avoid this being a regression, you need to test that this change
does not regress input latency.

As discussed on IRC, compositors use vblank data to predict the time
of the next flip event. For each device that you are touching here,
there are two possibilities:

- The vblank data is related to the flip timing, i.e. flip events and
vblank events are sent at almost the same time. In this case removing
these apis removes the path for compositors to predict the time of the
next flip event. Input latency will therefore regress after idle
periods when the compositor no longer has the time of the last vblank.

- The vblank data has nothing to do with the time of the next flip
event. In this case this series could in fact improve latency because
it removes the incorrect data from the compositor.

Whether the times of the flip events correspond to hardware timings is
not relevant. Everything in wayland compositors is scheduled against
flip event timings and they are also forwarded to clients for their
frame scheduling. If the flip timings are wrong/out of sync with the
hardware, then removing the vblank apis does not improve this
situation.

>
> This change has been discussed at length on IRC recently.
>
> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&highl=
ight_names=3D&date=3D2026-05-08&show_html=3Dtrue
> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&highl=
ight_names=3D&date=3D2026-05-12&show_html=3Dtrue
> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&highl=
ight_names=3D&date=3D2026-05-13&show_html=3Dtrue
> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&highl=
ight_names=3D&date=3D2026-05-15&show_html=3Dtrue
>
> v2:
> - add filter to CRTC_GET_SEQUENCE and CRTC_QUEUE_SEQUENCE ioctls (Michel)
> - clarify Mutter's behavior in cover letter (Michel)
>
> Thomas Zimmermann (9):
>   drm/vblank: Add drmm_vblank_init() to indicate managed cleanup
>   drm/vblank: Add DRM_VBLANK_FLAG_SIMULATED
>   drm/amdgpu: vkms: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/bochs: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/cirrus: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/hypervdrm: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/qxl: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/virtgpu: Set DRM_VBLANK_FLAG_SIMULATED
>   drm/vkms: Set DRM_VBLANK_FLAG_SIMULATED
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c    |  3 ++-
>  drivers/gpu/drm/drm_vblank.c                | 26 +++++++++++++++------
>  drivers/gpu/drm/drm_vblank_helper.c         |  2 +-
>  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c |  2 +-
>  drivers/gpu/drm/qxl/qxl_display.c           |  2 +-
>  drivers/gpu/drm/tiny/bochs.c                |  2 +-
>  drivers/gpu/drm/tiny/cirrus-qemu.c          |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_display.c    |  2 +-
>  drivers/gpu/drm/vkms/vkms_drv.c             |  4 ++--
>  include/drm/drm_crtc.h                      |  2 +-
>  include/drm/drm_device.h                    |  2 +-
>  include/drm/drm_vblank.h                    | 15 +++++++++++-
>  12 files changed, 45 insertions(+), 19 deletions(-)
>
>
> base-commit: 5fb5a9a63cf5ece68e0eeb6fa397da27712bccf0
> --
> 2.54.0
>
