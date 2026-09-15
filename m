Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A579BC88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 07:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F19110FA48;
	Tue, 15 Sep 2026 07:33:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CTkNi5AS";
	dkim-atps=neutral
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com
 [209.85.161.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F6410F939
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 04:26:07 +0000 (UTC)
Received: by mail-oo1-f50.google.com with SMTP id
 006d021491bc7-6b0496f4bbcso2944000eaf.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 21:26:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789446367; cv=none;
 d=google.com; s=arc-20260327;
 b=io8MFLJxkVtLtbDmGcurryfFCXl9O5sJ6YVNYG5Rok3U2AQ+vHwymAbBv1h0DK1QZM
 H5Ak8xV5/FZpHIxy5xIB6fWY01nJQ21N8fY+CprNFB0taSPfg376FWSZXBka6aKDmkS8
 suDBBWrK7G1GX6Lb4UhkMfksYnHC2SWp3LTGXVN70ePHDKnn3Edlg18Q3uZg1fM36Ayj
 mDGNB4Sy6SactzRbpHGrjCRuk2IfgQTSTDf2NgHDNYvGrSJNTow2Mv6FwZYnrlzj9P4Q
 6cQ1uazQ4mvuOXeFwPEWdsq0FcNIeDsjRodojQ9Gh0efSUYhNM0flmP4Kc3mhRh3CU1k
 VTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=AtLW9RBOVTP6jR12SHNVtKY14cTH39WAvZjrvfY8xVo=;
 fh=hs9oynQb3YjZT40omR8IZyt+l0QN8nu4Bye5abBVWug=;
 b=BnVo2CxLtrTJQdhniP6WSnyNL9LbKWgibkVz54p7QCJqsiQ27leuBxbRIaKT3jg5h3
 etZYjrvuX2/pd4PH+Dcgz1YiJKPeve2MEo/MdTAuifmKrREYwg2os5aG6RkxqxIH2HPu
 hUj7OWmRB2/as7k2bucY6BtGE4F8xNxHroMbphPutu7Sb7xjjfS32TOIH/OFPjlGqG1M
 4VsrqBo5mLgL8bqvi1+O0h1fkId+tLGIH3Yrx9pJ11lFtF0H/5XJ2rqGs1RyV2zrjwt0
 SBNYjvpny5qXy8clFUJhQdz/WVCI6Fz14rFzP0GpnVB9r0qpVoeMjEJJ/2CbQzyx0N1+
 a95Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789446367; x=1790051167; darn=lists.freedesktop.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AtLW9RBOVTP6jR12SHNVtKY14cTH39WAvZjrvfY8xVo=;
 b=CTkNi5ASGsdariRv5w+avXRIEOGWIKxnzOyM/rr3FYO6YeTWRCSsBP07C/621IXvBv
 Yv+jtEzOcwifWW48DoKIhgDMv+PjpWHSrGRUnPu8NovJ5FlnjaBUHrXr6ULy/RB7/OlQ
 9vze7szwulOyCqfOcY4a4S1zse8nqN2W0Ek6MJmiYtfn4+gsM0HRm1ja4UnvnzCEDP13
 XRzD+Hk6RtpZ0+mpjLCI3z9+PHzWqWgRFQEiI23guwzu2GHuUoN/jIpyFlM1H8p7AzOa
 6cII1QQtx6rLjx/dPRVm142gfLgjFnY1jBh5n+BFrAY/h0KPjCrOjS623ww3lxpkHjbO
 xgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789446367; x=1790051167;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AtLW9RBOVTP6jR12SHNVtKY14cTH39WAvZjrvfY8xVo=;
 b=2UaQi9NvVkiglla3VNakmoupggkxOZKKqYp/4IYQEszTlm3nrCxMEYHr4SDuFKa9Fs
 uo4UFegOnJ7x3nO/fL2TkjsTB1jvMAfBXhhlrcutFAcAp9TL219lMyuqOTdQ7IMfZQMn
 NDGkne0JP/dG4oOwLr3XoBrWkNqhsfK29gpfUrp/fnP2YvEOTVeIoPHb+mmVC4di1x91
 PpRgR7AzmlNkEgiouFAohaIolQhFTTIXUMg6rK9TeBS2RciChiPbLohn9TpEGeBGdgad
 Ur3kpIDHRNd01baoVpNjT35CB6vHiI4+Xu0HkuBssPzFhwwEA492E1w/2MFsY1Wzm4Lp
 SOWw==
X-Gm-Message-State: AFuF++n76dHf/OPUHYvAnw3wbGBkcQwu62MvozebkXxlRKp/53azL3VP
 /Hri1DtYE/W7Kj5/nSvHRmPonQDsjCsZ6LtQnFKCo6CBxR28i9V7LNR1JNy1F/5jfHV2LckWlBD
 toLYdbiMweK21TrLSLJcWbaEzt+q8L9yvLQ==
X-Gm-Gg: AYBFou3QwT49gOfSYSiWysOf4pgFsNNh/7QRsjzBqNeXVkQwBHEogeC0zfhEPDbhxN0
 HH4RdpDD+/XSWqa6aEmEXLEsjy+RyLbUrX5Y3rBe7juDs2d8zAFOChopsXzdq1+wmX0PP1FNwzR
 eR1Tr3DZ856AzSvIYiE71R/l2gUP+LjJdD/lEsec7KeBEklzRDtc7oJLVuEHAyoNnDr8+ah98l+
 9gF8m+/2d7g9rPtG+sVQ/c271/22gViDEROVEWCoAdDuGXDz/gqLbXJ+OsZPuLVHwn72QA7ne4P
 r7QQoYmC1fEQaCyPxU0stpQ9LeIzkGJjuJShvUB+O2Kjg9p5APvAh3S1+UE9Xg1u6Q==
X-Received: by 2002:a4a:e842:0:b0:6b8:1306:8567 with SMTP id
 006d021491bc7-6c542a39205mr2994419eaf.57.1789446366671; Mon, 14 Sep 2026
 21:26:06 -0700 (PDT)
MIME-Version: 1.0
From: Nakildias Professionnel <nakildiaspro@gmail.com>
Date: Tue, 15 Sep 2026 00:26:01 -0400
X-Gm-Features: AcwNN1WOGIo1AhHE-fkZcQHXthzxbSpMdTAcTziXLVdKBkisEgstC-sgO2vRT9Y
Message-ID: <CAKp7ksXoZmWC23JOG3xX7=7d0fSerxtCNPB+8PMnVqqRCAAdoA@mail.gmail.com>
Subject: [BUG] amd/display: planes advertise DRM_FORMAT_RGBA8888 but atomic
 check rejects it
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000007b962065b7df328"
X-Mailman-Approved-At: Tue, 15 Sep 2026 07:32:47 +0000
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

--00000000000007b962065b7df328
Content-Type: text/plain; charset="UTF-8"

Hi,

amdgpu lists DRM_FORMAT_RGBA8888 (RA24) as a supported format on every
primary and overlay plane, both in the plane's format list and in its
IN_FORMATS blob. Any atomic commit that puts an RA24 framebuffer on one
of those planes, TEST_ONLY included, fails with -EINVAL:

  amdgpu 0000:03:00.0: [drm] *ERROR* Unsupported screen format RA24
little-endian (0x34324152)
  [drm:amdgpu_dm_atomic_check [amdgpu]] dm_update_plane_state() failed
  [drm:amdgpu_dm_atomic_check [amdgpu]] Atomic check failed with err: -22
  [drm:drm_atomic_check_only] atomic driver check for 00000000e90a6d65
failed: -22

A compositor that trusts the advertised list and picks RA24 can't light
the display. KWin 6.7 does this on most starts: it ranks RA24 equal to
AR24 and AB24, and the order among the three is random. It then fails
every output configuration, retries for one to two seconds, and stops
presenting for several seconds, which shows up as a freeze at every
login. I'm reporting the KWin side to KDE separately, but fixing the
driver removes the trap for every compositor.


Where in the source
-------------------

Checked against mainline at v7.3-rc3:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c

  DRM_FORMAT_RGBA8888 is in rgb_formats[] and overlay_formats[], the
  lists passed to drm_universal_plane_init(), so userspace sees it. It is
  also in alpha_formats[] in the blending setup.

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

  fill_dc_plane_info_and_addr() switches on fb->format->format to choose a
  SURFACE_PIXEL_FORMAT_*. It has cases for C8, RGB565, XRGB/ARGB8888,
  XBGR/ABGR8888, the 2101010 and 16161616 formats, NV12/NV21/P010 and the
  half-float formats. There is no case for DRM_FORMAT_RGBA8888, so it falls
  through to default:, logs "Unsupported screen format %p4cc" and returns
  -EINVAL.

So either RGBA8888 should come out of rgb_formats[] and overlay_formats[]
(and alpha_formats[]), or fill_dc_plane_info_and_addr() needs a mapping
for it. I haven't checked whether DC has a surface pixel format that
fits, so I don't know which of the two is right.


Reproduction
------------

1. On an affected card, read any primary plane's formats with drm_info,
   drmModeGetPlane() or the IN_FORMATS blob. RA24 is listed. Here every
   primary and overlay plane lists 20 formats, RA24 among them, and 17 of
   the 340 IN_FORMATS format/modifier pairs are RA24. The cursor planes
   list only AR24.

2. As DRM master, create an RA24 framebuffer and do an atomic commit, or a
   TEST_ONLY one, with it on a primary plane of an active CRTC.

3. The commit fails with -EINVAL, and the kernel log shows the lines
   above.

In practice the easiest way to hit it is Plasma Wayland with KWin 6.7:
log in a few times and grep the kernel log for "Unsupported screen format
RA24". Most starts produce hundreds of lines. When RA24 is hidden from
KWin (an LD_PRELOAD wrapper that removes it from drmModeGetPlane() and
drmModeFormatModifierBlobIterNext()), the same configuration succeeds
first time on every start, and the primary planes run AB30.


System
------

  GPU: AMD Radeon RX 9070 XT, Navi 48 [1002:7550] rev c0
  Display Core: v3.2.384 on DCN 4.0.1
  Kernel: 7.2.4-arch1-2 (Arch Linux)
  linux-firmware: 20260910
  Mesa: 26.2.2
  libdrm: 2.4.134
  Compositor: KWin 6.7.5, Plasma Wayland
  Displays: 3x AOC Q27G41ZE, 2560x1440 @ 240 Hz, DisplayPort
                  (DP-1, DP-2, DP-3)
  Command line: root=UUID=... rw loglevel=3 quiet video=2560x1440-32

Not bisected. Going by the source, mainline still has the mismatch, and
since rgb_formats[] is shared by every GPU that DC drives, other AMD
cards are presumably affected as well. I've only tested this one.


Log
---

Kernel with drm.debug=0x16, one failing check during KWin's first modeset
for DP-2 (CRTC 437, primary plane 152). 10 bpc is pruned for link
bandwidth and 8 bpc validates, so the stream itself is fine. The plane
state is what fails:

  [drm:drm_atomic_set_fb_for_plane] Set [FB:495] for [PLANE:152:plane-2]
state 000000001159dc5f
  [drm:drm_atomic_set_mode_prop_for_crtc] Set [MODE:2560x1440] for
[CRTC:437:crtc-1] state 0000000007556867
  [drm:drm_atomic_check_only] checking 00000000e90a6d65
  [drm:drm_atomic_helper_check_modeset] [CRTC:437:crtc-1] mode changed
  [drm:drm_atomic_helper_check_modeset] [CONNECTOR:459:DP-2] keeps
[ENCODER:458:TMDS-458], now on [CRTC:437:crtc-1]
  [drm:amdgpu_dm_atomic_check [amdgpu]] Disabling DRM plane: 152 on DRM
crtc 437
  [drm:dm_update_crtc_state [amdgpu]] Disabling DRM crtc: 437
  [drm:create_validate_stream_for_sink [amdgpu]] Trying with 10 bpc
  [drm:create_validate_stream_for_sink [amdgpu]] Pruned mode 2560 x 1440
(clk 992260) RGB 10-bpc -- No DP link bandwidth
  [drm:create_validate_stream_for_sink [amdgpu]] Trying with 8 bpc
  [drm:dm_update_crtc_state [amdgpu]] Enabling DRM crtc: 437
  [drm:amdgpu_dm_atomic_check [amdgpu]] Enabling DRM plane: 152 on DRM crtc
437
  [drm] *ERROR* Unsupported screen format RA24 little-endian (0x34324152)
  [drm:amdgpu_dm_atomic_check [amdgpu]] dm_update_plane_state() failed
  [drm:amdgpu_dm_atomic_check [amdgpu]] Atomic check failed with err: -22
  [drm:drm_atomic_check_only] atomic driver check for 00000000e90a6d65
failed: -22

In one 4-second capture of KWin starting, all 602 failed atomic checks
were this same RA24 rejection, on planes 206 and 152.

Formats per plane, as read from userspace:

  plane 44: XR24 AR24 RA24 XR30 XB30 AR30 AB30 XR48 XB48 AR48 AB48 XB24
AB24 RG16 NV12 P010 XR4H AR4H XB4H AB4H
  plane 98: same
  plane 152: same
  plane 206: same
  plane 260: same
  plane 316: same
  plane 372: same
  plane 428: AR24 (cursor)
  plane 433: AR24
  plane 438: AR24
  plane 443: AR24

I can capture a longer drm.debug log or test a patch if that helps.

Thanks,

--00000000000007b962065b7df328
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span style=3D"background-color:transparent">Hi,</spa=
n></div><div><br></div><div>amdgpu lists DRM_FORMAT_RGBA8888 (RA24) as a su=
pported format on every</div><div>primary and overlay plane, both in the pl=
ane&#39;s format list and in its</div><div>IN_FORMATS blob. Any atomic comm=
it that puts an RA24 framebuffer on one</div><div>of those planes, TEST_ONL=
Y included, fails with -EINVAL:</div><div><br></div><div>=C2=A0 amdgpu 0000=
:03:00.0: [drm] *ERROR* Unsupported screen format RA24 little-endian (0x343=
24152)</div><div>=C2=A0 [drm:amdgpu_dm_atomic_check [amdgpu]] dm_update_pla=
ne_state() failed</div><div>=C2=A0 [drm:amdgpu_dm_atomic_check [amdgpu]] At=
omic check failed with err: -22</div><div>=C2=A0 [drm:drm_atomic_check_only=
] atomic driver check for 00000000e90a6d65 failed: -22</div><div><br></div>=
<div>A compositor that trusts the advertised list and picks RA24 can&#39;t =
light</div><div>the display. KWin 6.7 does this on most starts: it ranks RA=
24 equal to</div><div>AR24 and AB24, and the order among the three is rando=
m. It then fails</div><div>every output configuration, retries for one to t=
wo seconds, and stops</div><div>presenting for several seconds, which shows=
 up as a freeze at every</div><div>login. I&#39;m reporting the KWin side t=
o KDE separately, but fixing the</div><div>driver removes the trap for ever=
y compositor.</div><div><br></div><div><br></div><div>Where in the source</=
div><div>-------------------</div><div><br></div><div>Checked against mainl=
ine at v7.3-rc3:</div><div><br></div><div>drivers/gpu/drm/amd/display/amdgp=
u_dm/amdgpu_dm_plane.c</div><div><br></div><div>=C2=A0 DRM_FORMAT_RGBA8888 =
is in rgb_formats[] and overlay_formats[], the</div><div>=C2=A0 lists passe=
d to drm_universal_plane_init(), so userspace sees it. It is</div><div>=C2=
=A0 also in alpha_formats[] in the blending setup.</div><div><br></div><div=
>drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c</div><div><br></div><div=
>=C2=A0 fill_dc_plane_info_and_addr() switches on fb-&gt;format-&gt;format =
to choose a</div><div>=C2=A0 SURFACE_PIXEL_FORMAT_*. It has cases for C8, R=
GB565, XRGB/ARGB8888,</div><div>=C2=A0 XBGR/ABGR8888, the 2101010 and 16161=
616 formats, NV12/NV21/P010 and the</div><div>=C2=A0 half-float formats. Th=
ere is no case for DRM_FORMAT_RGBA8888, so it falls</div><div>=C2=A0 throug=
h to default:, logs &quot;Unsupported screen format %p4cc&quot; and returns=
</div><div>=C2=A0 -EINVAL.</div><div><br></div><div>So either RGBA8888 shou=
ld come out of rgb_formats[] and overlay_formats[]</div><div>(and alpha_for=
mats[]), or fill_dc_plane_info_and_addr() needs a mapping</div><div>for it.=
 I haven&#39;t checked whether DC has a surface pixel format that</div><div=
>fits, so I don&#39;t know which of the two is right.</div><div><br></div><=
div><br></div><div>Reproduction</div><div>------------</div><div><br></div>=
<div>1. On an affected card, read any primary plane&#39;s formats with drm_=
info,</div><div>=C2=A0 =C2=A0drmModeGetPlane() or the IN_FORMATS blob. RA24=
 is listed. Here every</div><div>=C2=A0 =C2=A0primary and overlay plane lis=
ts 20 formats, RA24 among them, and 17 of</div><div>=C2=A0 =C2=A0the 340 IN=
_FORMATS format/modifier pairs are RA24. The cursor planes</div><div>=C2=A0=
 =C2=A0list only AR24.</div><div><br></div><div>2. As DRM master, create an=
 RA24 framebuffer and do an atomic commit, or a</div><div>=C2=A0 =C2=A0TEST=
_ONLY one, with it on a primary plane of an active CRTC.</div><div><br></di=
v><div>3. The commit fails with -EINVAL, and the kernel log shows the lines=
</div><div>=C2=A0 =C2=A0above.</div><div><br></div><div>In practice the eas=
iest way to hit it is Plasma Wayland with KWin 6.7:</div><div>log in a few =
times and grep the kernel log for &quot;Unsupported screen format</div><div=
>RA24&quot;. Most starts produce hundreds of lines. When RA24 is hidden fro=
m</div><div>KWin (an LD_PRELOAD wrapper that removes it from drmModeGetPlan=
e() and</div><div>drmModeFormatModifierBlobIterNext()), the same configurat=
ion succeeds</div><div>first time on every start, and the primary planes ru=
n AB30.</div><div><br></div><div><br></div><div>System</div><div>------</di=
v><div><br></div><div>=C2=A0 GPU:            AMD Radeon RX 9070 XT, Navi 48=
 [1002:7550] rev c0</div><div>=C2=A0 Display Core:   v3.2.384 on DCN 4.0.1<=
/div><div>=C2=A0 Kernel:         7.2.4-arch1-2 (Arch Linux)</div><div>=C2=
=A0 linux-firmware: 20260910</div><div>=C2=A0 Mesa:           26.2.2</div><=
div>=C2=A0 libdrm:         2.4.134</div><div>=C2=A0 Compositor:     KWin 6.=
7.5, Plasma Wayland</div><div>=C2=A0 Displays:       3x AOC Q27G41ZE, 2560x=
1440 @ 240 Hz, DisplayPort</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (DP-1, DP-2, DP-3)</div><div>=C2=A0 Command line: =
  root=3DUUID=3D... rw loglevel=3D3 quiet video=3D2560x1440-32</div><div><b=
r></div><div>Not bisected. Going by the source, mainline still has the mism=
atch, and</div><div>since rgb_formats[] is shared by every GPU that DC driv=
es, other AMD</div><div>cards are presumably affected as well. I&#39;ve onl=
y tested this one.</div><div><br></div><div><br></div><div>Log</div><div>--=
-</div><div><br></div><div>Kernel with drm.debug=3D0x16, one failing check =
during KWin&#39;s first modeset</div><div>for DP-2 (CRTC 437, primary plane=
 152). 10 bpc is pruned for link</div><div>bandwidth and 8 bpc validates, s=
o the stream itself is fine. The plane</div><div>state is what fails:</div>=
<div><br></div><div>=C2=A0 [drm:drm_atomic_set_fb_for_plane] Set [FB:495] f=
or [PLANE:152:plane-2] state 000000001159dc5f</div><div>=C2=A0 [drm:drm_ato=
mic_set_mode_prop_for_crtc] Set [MODE:2560x1440] for [CRTC:437:crtc-1] stat=
e 0000000007556867</div><div>=C2=A0 [drm:drm_atomic_check_only] checking 00=
000000e90a6d65</div><div>=C2=A0 [drm:drm_atomic_helper_check_modeset] [CRTC=
:437:crtc-1] mode changed</div><div>=C2=A0 [drm:drm_atomic_helper_check_mod=
eset] [CONNECTOR:459:DP-2] keeps [ENCODER:458:TMDS-458], now on [CRTC:437:c=
rtc-1]</div><div>=C2=A0 [drm:amdgpu_dm_atomic_check [amdgpu]] Disabling DRM=
 plane: 152 on DRM crtc 437</div><div>=C2=A0 [drm:dm_update_crtc_state [amd=
gpu]] Disabling DRM crtc: 437</div><div>=C2=A0 [drm:create_validate_stream_=
for_sink [amdgpu]] Trying with 10 bpc</div><div>=C2=A0 [drm:create_validate=
_stream_for_sink [amdgpu]] Pruned mode 2560 x 1440 (clk 992260) RGB 10-bpc =
-- No DP link bandwidth</div><div>=C2=A0 [drm:create_validate_stream_for_si=
nk [amdgpu]] Trying with 8 bpc</div><div>=C2=A0 [drm:dm_update_crtc_state [=
amdgpu]] Enabling DRM crtc: 437</div><div>=C2=A0 [drm:amdgpu_dm_atomic_chec=
k [amdgpu]] Enabling DRM plane: 152 on DRM crtc 437</div><div>=C2=A0 [drm] =
*ERROR* Unsupported screen format RA24 little-endian (0x34324152)</div><div=
>=C2=A0 [drm:amdgpu_dm_atomic_check [amdgpu]] dm_update_plane_state() faile=
d</div><div>=C2=A0 [drm:amdgpu_dm_atomic_check [amdgpu]] Atomic check faile=
d with err: -22</div><div>=C2=A0 [drm:drm_atomic_check_only] atomic driver =
check for 00000000e90a6d65 failed: -22</div><div><br></div><div>In one 4-se=
cond capture of KWin starting, all 602 failed atomic checks</div><div>were =
this same RA24 rejection, on planes 206 and 152.</div><div><br></div><div>F=
ormats per plane, as read from userspace:</div><div><br></div><div>=C2=A0 p=
lane  44: XR24 AR24 RA24 XR30 XB30 AR30 AB30 XR48 XB48 AR48 AB48 XB24 AB24 =
RG16 NV12 P010 XR4H AR4H XB4H AB4H</div><div>=C2=A0 plane  98: same</div><d=
iv>=C2=A0 plane 152: same</div><div>=C2=A0 plane 206: same</div><div>=C2=A0=
 plane 260: same</div><div>=C2=A0 plane 316: same</div><div>=C2=A0 plane 37=
2: same</div><div>=C2=A0 plane 428: AR24 (cursor)</div><div>=C2=A0 plane 43=
3: AR24</div><div>=C2=A0 plane 438: AR24</div><div>=C2=A0 plane 443: AR24</=
div><div><br></div><div>I can capture a longer drm.debug log or test a patc=
h if that helps.</div><div><br></div><div>Thanks,</div><div><br></div></div=
>

--00000000000007b962065b7df328--
