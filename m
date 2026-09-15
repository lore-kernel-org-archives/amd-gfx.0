Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8A8C88E7B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 13:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0855110E22F;
	Tue, 15 Sep 2026 13:28:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rdITowwC";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E73B610E22F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 13:28:24 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 71dfb90a1353d-5c6560f7a78so128129e0c.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 06:28:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789478904; cv=none;
 d=google.com; s=arc-20260327;
 b=RcqV288XZdBPrf2GjqXs0DH79Eg9y9gk5f6pFZAYQSgkdWNd3WZnrzKySySr1Vbtu7
 5DfPz1KS6mHBesImFxmTM9RWQ+/qKEbd0TIgqXRU4fOI4dbgFpWTuh4XcGe7tbrYussN
 KPe11qIjR1rOYhqBJqomtHVmjhsCKID3B/LF90+h3wwAy0bSh5F39a59CVtMh4WfVHz3
 Z3/rRVe1TTZCeM0uRWFLobwF9/5k6FHVzjDd6PPlLfdPQ7QKqZJBfuncIlBT6dEaIuZh
 kILTFzwHMcw9UT9sY1KmdfQHsSCC4aa9nIGeMuSlUiK5B0nupgtUAmZ3HNqUySVyhGAM
 cFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ksqut+SFMGozKUh2aW7b3gP0VFTuqBmkuZSHWKj21Zw=;
 fh=96Y6V5a5kyh9Xtmi3wHzFpWy5VOX1QgW3w/S4UWRGow=;
 b=JK/j4tddkokETzSWg87b9pbd+NcGbtITJgluNv0jokuqNjLtLMQS8SkKg+pnhBi4FJ
 iDAAe7R/JbSyFmEi3v/G8jGy3Lsy6FlSel8PSTjrDiwCG6BYE1Uhy+o75f1QGf1nIzTL
 1POb+TeuzdcZ7lZqrMcOWbPXq/MJ9X8fnXPiu8u5zpinlDSgYC722hP4bwz8m1p/SlDP
 6PmEk1SHiF4akFFGG7GDXedPOAzlXHQ0EyVtXn69tccFNkf7pqu+J419R5ZZx14EC+Tv
 k/TNjCfSnm8lou2o6edf9RJCtSch9jwOnRexO0k7hFEeoPG5qtGjnTjwkVIeYAhx1C54
 e08A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789478904; x=1790083704; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ksqut+SFMGozKUh2aW7b3gP0VFTuqBmkuZSHWKj21Zw=;
 b=rdITowwC0rc4ane2A66X25PeFXMURtUAdTSst8Aw8gEMtTkj8GF+5u1hnXP8ReA2Ol
 d7wGw/qv06K5CYZKaeSfNeL3qSaKE9RcIzGvQ0L7q6rVl1vBTI2SvZ7qrBLtIUAs/b5c
 6TmZGxOzsxWrVakCgxErvw2YKwkKWH1c74v8DoKyI5YczJLSVhACOwTSVIUKKwRB7oYS
 98ZzqCAYsjVDF/V1LyDeEKcpAoGMRh8uxX+kXkRl7nV+S/AkeMJ+i/jI/ybVJNBCCpTu
 dhHa/Tn7s/pniZ/iv4/l9f8vdtVzHNQ2hMSINjHmQWTA1o9pwNLlsf8snYm/Z4nRAgyh
 mBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789478904; x=1790083704;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ksqut+SFMGozKUh2aW7b3gP0VFTuqBmkuZSHWKj21Zw=;
 b=XFWPjS2BVtrB4F3wVEsDSymhgeT6P8MN1w03FvVvQv8yKKwR65G2KcENAT3hNMW1e8
 MeBHZkFifebZPYu5jm4K/koZPIgaQRHZH6mbqTlBnTjWKWkJ/Cgsokogpj85CrmssPD2
 tJDYxyaIuZK6Y2UndYZ8v36mP8w3iJ1M4JRQwRb4j4BykZzIzeOnvSEzAjz+RBHhgQ4w
 bKgLOequJa6qcL+rgpiaKhWySfHCl2aBAnWDRnx6A7VGJbeQHW0JfCuG9w2DsroGuRUq
 MWUFixHWKyRcjIoKA6hJLjA+QDCKzzUN1XSwC+D6f+m/0CA4rT3Up2mNMZwQdYg+tfie
 wuAQ==
X-Gm-Message-State: AFuF++nLj+CfSCNuSKUpWeSPIlGnaOXH5NMytuc5P1IOTwKwy5bJ9GSI
 VC8Tkp5QVfNG34UxXdbGT56KAYF+X3YjxTHqfu5HxkvbT6saOrTFszPkDccd1ImTbmzM5W8MPLo
 RdYgM+qoqkXrE48QlgMJNZM8VBhxK0Dg=
X-Gm-Gg: AYBFou2NfFjKQjbFoTXcKxEmIVPSUdMzskGJnXJLNfORNrQXsF1wz1SQlYHLdx/0HYL
 HLW7v7aul524n769Mtw61tAeqTcK1hxLiGheosdr3ggaxeEiXdQDVwsjTgRLMKvwVpkKqNZ4Ttq
 OOpbEAV1+uAbsHdoMZlGdLb1SOKI6jihRL7AXAwocD9792FJhrGQkbKJcpJDpKqqjsZc03qFTYI
 VtkcnnSCPEHYrGMPG023zpXeQFbu08ueHaTUdM+BHgGiRVfRBldbFD++X2t6QMcFtpzqSlHlIQC
 rsBdvPf+1H3yaCeLwpsq4Mth1MNX7xrGRiv6cxbIDdD3K/L5vXCVLzmvQsWqaFZHlBE7Iu5Bbj5
 XN8o3Ml8MSDNKt0kuLK307M+7rVE8AaEGPIupRXNtYg==
X-Received: by 2002:a05:6122:4a52:20b0:5c8:356d:c872 with SMTP id
 71dfb90a1353d-5c981ebdb36mr2425819e0c.3.1789478903526; Tue, 15 Sep 2026
 06:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAKp7ksXoZmWC23JOG3xX7=7d0fSerxtCNPB+8PMnVqqRCAAdoA@mail.gmail.com>
In-Reply-To: <CAKp7ksXoZmWC23JOG3xX7=7d0fSerxtCNPB+8PMnVqqRCAAdoA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2026 09:28:11 -0400
X-Gm-Features: AcwNN1VsmFmI8RxJM9vORQJp26J6-Rk-p2V-Hqwq4524rXR7NmU_FWoc4vownyw
Message-ID: <CADnq5_My0iBc+VLJ8E82QDurakCRHbdjC2RK_LjW53G+eZobxw@mail.gmail.com>
Subject: Re: [BUG] amd/display: planes advertise DRM_FORMAT_RGBA8888 but
 atomic check rejects it
To: Nakildias Professionnel <nakildiaspro@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Tue, Sep 15, 2026 at 3:51=E2=80=AFAM Nakildias Professionnel
<nakildiaspro@gmail.com> wrote:
>
> Hi,
>
> amdgpu lists DRM_FORMAT_RGBA8888 (RA24) as a supported format on every
> primary and overlay plane, both in the plane's format list and in its
> IN_FORMATS blob. Any atomic commit that puts an RA24 framebuffer on one
> of those planes, TEST_ONLY included, fails with -EINVAL:
>
>   amdgpu 0000:03:00.0: [drm] *ERROR* Unsupported screen format RA24 littl=
e-endian (0x34324152)
>   [drm:amdgpu_dm_atomic_check [amdgpu]] dm_update_plane_state() failed
>   [drm:amdgpu_dm_atomic_check [amdgpu]] Atomic check failed with err: -22
>   [drm:drm_atomic_check_only] atomic driver check for 00000000e90a6d65 fa=
iled: -22
>
> A compositor that trusts the advertised list and picks RA24 can't light
> the display. KWin 6.7 does this on most starts: it ranks RA24 equal to
> AR24 and AB24, and the order among the three is random. It then fails
> every output configuration, retries for one to two seconds, and stops
> presenting for several seconds, which shows up as a freeze at every
> login. I'm reporting the KWin side to KDE separately, but fixing the
> driver removes the trap for every compositor.

Please see this ticket for discussion and patches:
https://gitlab.freedesktop.org/drm/amd/-/work_items/5339

Alex

>
>
> Where in the source
> -------------------
>
> Checked against mainline at v7.3-rc3:
>
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>
>   DRM_FORMAT_RGBA8888 is in rgb_formats[] and overlay_formats[], the
>   lists passed to drm_universal_plane_init(), so userspace sees it. It is
>   also in alpha_formats[] in the blending setup.
>
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>
>   fill_dc_plane_info_and_addr() switches on fb->format->format to choose =
a
>   SURFACE_PIXEL_FORMAT_*. It has cases for C8, RGB565, XRGB/ARGB8888,
>   XBGR/ABGR8888, the 2101010 and 16161616 formats, NV12/NV21/P010 and the
>   half-float formats. There is no case for DRM_FORMAT_RGBA8888, so it fal=
ls
>   through to default:, logs "Unsupported screen format %p4cc" and returns
>   -EINVAL.
>
> So either RGBA8888 should come out of rgb_formats[] and overlay_formats[]
> (and alpha_formats[]), or fill_dc_plane_info_and_addr() needs a mapping
> for it. I haven't checked whether DC has a surface pixel format that
> fits, so I don't know which of the two is right.
>
>
> Reproduction
> ------------
>
> 1. On an affected card, read any primary plane's formats with drm_info,
>    drmModeGetPlane() or the IN_FORMATS blob. RA24 is listed. Here every
>    primary and overlay plane lists 20 formats, RA24 among them, and 17 of
>    the 340 IN_FORMATS format/modifier pairs are RA24. The cursor planes
>    list only AR24.
>
> 2. As DRM master, create an RA24 framebuffer and do an atomic commit, or =
a
>    TEST_ONLY one, with it on a primary plane of an active CRTC.
>
> 3. The commit fails with -EINVAL, and the kernel log shows the lines
>    above.
>
> In practice the easiest way to hit it is Plasma Wayland with KWin 6.7:
> log in a few times and grep the kernel log for "Unsupported screen format
> RA24". Most starts produce hundreds of lines. When RA24 is hidden from
> KWin (an LD_PRELOAD wrapper that removes it from drmModeGetPlane() and
> drmModeFormatModifierBlobIterNext()), the same configuration succeeds
> first time on every start, and the primary planes run AB30.
>
>
> System
> ------
>
>   GPU: AMD Radeon RX 9070 XT, Navi 48 [1002:7550] rev c0
>   Display Core: v3.2.384 on DCN 4.0.1
>   Kernel: 7.2.4-arch1-2 (Arch Linux)
>   linux-firmware: 20260910
>   Mesa: 26.2.2
>   libdrm: 2.4.134
>   Compositor: KWin 6.7.5, Plasma Wayland
>   Displays: 3x AOC Q27G41ZE, 2560x1440 @ 240 Hz, DisplayPort
>                   (DP-1, DP-2, DP-3)
>   Command line: root=3DUUID=3D... rw loglevel=3D3 quiet video=3D2560x1440=
-32
>
> Not bisected. Going by the source, mainline still has the mismatch, and
> since rgb_formats[] is shared by every GPU that DC drives, other AMD
> cards are presumably affected as well. I've only tested this one.
>
>
> Log
> ---
>
> Kernel with drm.debug=3D0x16, one failing check during KWin's first modes=
et
> for DP-2 (CRTC 437, primary plane 152). 10 bpc is pruned for link
> bandwidth and 8 bpc validates, so the stream itself is fine. The plane
> state is what fails:
>
>   [drm:drm_atomic_set_fb_for_plane] Set [FB:495] for [PLANE:152:plane-2] =
state 000000001159dc5f
>   [drm:drm_atomic_set_mode_prop_for_crtc] Set [MODE:2560x1440] for [CRTC:=
437:crtc-1] state 0000000007556867
>   [drm:drm_atomic_check_only] checking 00000000e90a6d65
>   [drm:drm_atomic_helper_check_modeset] [CRTC:437:crtc-1] mode changed
>   [drm:drm_atomic_helper_check_modeset] [CONNECTOR:459:DP-2] keeps [ENCOD=
ER:458:TMDS-458], now on [CRTC:437:crtc-1]
>   [drm:amdgpu_dm_atomic_check [amdgpu]] Disabling DRM plane: 152 on DRM c=
rtc 437
>   [drm:dm_update_crtc_state [amdgpu]] Disabling DRM crtc: 437
>   [drm:create_validate_stream_for_sink [amdgpu]] Trying with 10 bpc
>   [drm:create_validate_stream_for_sink [amdgpu]] Pruned mode 2560 x 1440 =
(clk 992260) RGB 10-bpc -- No DP link bandwidth
>   [drm:create_validate_stream_for_sink [amdgpu]] Trying with 8 bpc
>   [drm:dm_update_crtc_state [amdgpu]] Enabling DRM crtc: 437
>   [drm:amdgpu_dm_atomic_check [amdgpu]] Enabling DRM plane: 152 on DRM cr=
tc 437
>   [drm] *ERROR* Unsupported screen format RA24 little-endian (0x34324152)
>   [drm:amdgpu_dm_atomic_check [amdgpu]] dm_update_plane_state() failed
>   [drm:amdgpu_dm_atomic_check [amdgpu]] Atomic check failed with err: -22
>   [drm:drm_atomic_check_only] atomic driver check for 00000000e90a6d65 fa=
iled: -22
>
> In one 4-second capture of KWin starting, all 602 failed atomic checks
> were this same RA24 rejection, on planes 206 and 152.
>
> Formats per plane, as read from userspace:
>
>   plane 44: XR24 AR24 RA24 XR30 XB30 AR30 AB30 XR48 XB48 AR48 AB48 XB24 A=
B24 RG16 NV12 P010 XR4H AR4H XB4H AB4H
>   plane 98: same
>   plane 152: same
>   plane 206: same
>   plane 260: same
>   plane 316: same
>   plane 372: same
>   plane 428: AR24 (cursor)
>   plane 433: AR24
>   plane 438: AR24
>   plane 443: AR24
>
> I can capture a longer drm.debug log or test a patch if that helps.
>
> Thanks,
>
