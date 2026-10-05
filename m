Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A520ECA5FF0
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 13:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D8A10E9FB;
	Mon,  5 Oct 2026 13:02:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tD+TMxEl";
	dkim-atps=neutral
Received: from mail-lr2-f3.google.com (mail-lr2-f3.google.com [74.125.230.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2208C10E24C
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 10:55:41 +0000 (UTC)
Received: by mail-lr2-f3.google.com with SMTP id
 38308e7fff4ca-3a77f4bc209so12937551fa.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Oct 2026 03:55:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791197739; cv=none;
 d=google.com; s=arc-20260327;
 b=HgtZQBGP6qKb13HxElfnJM/RTIsHzjfN6Y8jzmDwa0V6OtZ3cSJngFDA0z8J0bNIWH
 M1OKD86pI9wjGuEddj9aLzvOFIUPFk4FUPV1Ty59jso4796dIe2weagfKBVgt99u8zPP
 xaey9d14EbwbdvUljsc9vq5dxSMv1wPxLsHEu1b9HVqlzGkTksph2qDKp2czbCTI2rM4
 hqDU6Cv+4VPKz+YJmLzcK/5ftavt/1cRTFucRtw7U6j5mTY4U3jiWMlhl4Tq6AdcN1X2
 wJ378WTFiyvjjMelMNKnFlOkMaVEM4B5RtiLEKh/Y0vSC49ofpWEmzMv7F7vVzlXfkgm
 rzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=mEaljJNUsrOQzW1a2shbKKIoOuKOoBCB3XPvFs2X540=;
 fh=hs9oynQb3YjZT40omR8IZyt+l0QN8nu4Bye5abBVWug=;
 b=QcHECJ8rdOWeOgGNo1lOvfJlDS7g2cgyzkxX05Mcbdr1UrxqV3LBf/h6uZbyS3j27l
 mKg92K39gSjR3WguacIIZSlYaZqsOYnSe2+dyz7XV2RgY/NwJIrRVl4fbB5xet9dpsHl
 CiZhJIH0Jr5+h5cfwoHNABmcGaVi0jxFMrx1eXaecr/D14ibobJACUuEKU713fD3Bk7b
 yEsVd7NkRniRovQLaE+DiCpI+tPuc50cfObl1yRk/cKUOwL1IfhwMi6Gx1tBQB4r5gAZ
 lAZOfIjSwI9ufY5kyx3NcI8u3bmHafUXUigK5u4eMpp1VjLJR8MTqY3VNC3TZA//OvW+
 exmg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791197739; x=1791802539; darn=lists.freedesktop.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mEaljJNUsrOQzW1a2shbKKIoOuKOoBCB3XPvFs2X540=;
 b=tD+TMxElQb5ubUKNpAbOaubLcePQptu3rGPu6OWvXJvrIEA9SnMJWUXBaABWAaCJ5o
 UjdQXEYcQomROJxang2z2TkaFBIJGP+6FzzCpKFbU8X+5uyq7ZbRegKyj1JuDhiv5D7i
 0dk7V2ZCMTWiGxh5QvInhsQyiswKBHlqxPsSVUIKBGZe8nGHNg/7JMdfEwRv7p5cqsGM
 6p0mTZLFaauLEY/Rn0Yz/fGM0CqiXkSZY1Y+xMoSXhUgdtM4rk++M1ugfrTJPHWNhjVN
 ks31ebiDGdYgd9Q9RLu84oR2HV7MTIK62Y4XfXKBGtaXiDcMHmNRjsz871xgj0k7LXlA
 xmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791197739; x=1791802539;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mEaljJNUsrOQzW1a2shbKKIoOuKOoBCB3XPvFs2X540=;
 b=tENQqIKpKSaQ6mw9y+sGQPa+214+bmDqx91X4wz7medHzj+IXOivvSUw8Yjs6HS2So
 lRaHHQNhXRrHO75L5k0olzsvRwD9X7497MGvhZ2YOEs3qiAIRFCrGSaj8JojI7Vlx4Xc
 1oM7JoZ34McSkPaxDf4BN0U4jK2Y2/qMVwCTY3LBrgQqcTUpU0gbjNBH//1Rs7LwPNH3
 rep9f+l6ZZGN8EQAC/U6MX5g0ak95Fjfnd+45iinp9DlMKx/4JZ6JaFyiyVE9tTdr1+p
 XTPBwLagiyx0njYuBm/nFPdmu3VhMXnPJ49Mx5rH95RvUMtFx37hEa9Kp1SDuSxXHO3d
 zrVg==
X-Gm-Message-State: AFq9FYKHCXcLI1OFuTaCdB264DJWby32AlnD0hAMFzX2fHlOdRrc00cv
 /gUPzwDyY4jw+HjiBy+qNHcSlOPwYFm1mlJQm+8Bfc4IAr3z3GGl3OQoY3lfXKgI7f1QUFQiMqq
 qQgg19QEhOSJyl/3CzOVHW2qRL3DQJHOy6aVUaIO3hQ==
X-Gm-Gg: AYBFou20cYB7vvHMznpAzZDBI/iMEVqTMOYXINpn1ogKy9sG2Lt3M2IdG6YFgF0jJpW
 iRfpXInqhKaJaktuqyfJkcOANXYdTzfc+9FuN0W5swxIjhfGKaqn8EIfGpGOh6Z5R7v+LtLO2z3
 yZ96gVFSF54xdnhPyk0o0nnlcbyQJM9SNIBQ3t9W9efo9s8hbhaF1gausXVS3PRuZRWkVgJl+Gp
 fwyJedcQjNysbikD7fBSDDhBho6E8XtA0TkF4IoPB8+t/QXlMo2QeqSJ3eCbeSYGQ9j99UYPj42
 ivvK2n+Ld1rOfohE3olIaD0EBvlTT7UHr61xbYKaGyLwKmPP0qS2pkdu
X-Received: by 2002:a05:6512:118b:b0:5ba:356b:5a85 with SMTP id
 2adb3069b0e04-5bcb547d276mr2418392e87.43.1791197738911; Mon, 05 Oct 2026
 03:55:38 -0700 (PDT)
MIME-Version: 1.0
From: Wayne Pitterson <pittersonwayne@gmail.com>
Date: Mon, 5 Oct 2026 17:55:26 +0700
X-Gm-Features: AclHuK8PufrSeRsLtDkHUgLu5av7O7ElEx4jqHCsWpl07VSHPGVbIL88NmXNPwA
Message-ID: <CABMfxq4CmPe1UJcOC5WKZQQK543sBf4+srLfqerCjyX6s5dDWQ@mail.gmail.com>
Subject: Navi 22 (DCN 3.0): gfx_0.0.0 ring timeouts from UTCL2 permission
 faults - kernel-version independent,
 excluded from the NV3x 5s offdelay workaround
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000f34cfe065d15b8fa"
X-Mailman-Approved-At: Mon, 05 Oct 2026 13:02:18 +0000
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

--000000000000f34cfe065d15b8fa
Content-Type: text/plain; charset="UTF-8"

Hi all,

Adding supporting evidence and one new observation to the "2D OpenGL Hangs"
report at https://gitlab.freedesktop.org/drm/amd/-/issues/4663, tracked
against

  58a261bfc967 ("drm/amd/display: use a more lax vblank enable policy for
older
  ASICs")

I have seen the same kernel log signature on three different kernel
versions,
triggered by two different GL clients, and I believe the existing 5 s
off-delay
workaround does not cover this card because of its DCN stepping.

ENVIRONMENT
  GPU         AMD Radeon RX 6700 XT (Navi 22), PCI 1002:73df rev c5, DCN 3.0
  VRAM        12272 MiB
  VBIOS       115-D512BS0-100
  Display     DisplayPort, 1920x1080 @ 239.99 Hz
  OS          elementary OS 8 / Pantheon / Gala, X11
  Mesa        25.2.8-0ubuntu0.24.04.4 (radeonsi, navi22, LLVM 20.1.2, DRM
3.64)
  Xorg        2:21.1.12-1ubuntu1.8 (AMDGPU, GLAMOR acceleration)
  iGPU        disabled in BIOS - the dGPU is the only display device and
              enumerates as card1
  Kernels     7.0.0-31, 7.0.0-34, 7.0.0-38 - all affected
  Recovery    amdgpu gpu_recovery=1, auto-selected reset method ("bus")
  Clients     Xorg itself, and openboard (on-screen keyboard, Flatpak
              ch.openboard.OpenBoard, Chromium/CEF)

FAULT SIGNATURE (verbatim, captured from the running system)

  amdgpu 0000:03:00.0: [gfxhub] page fault (src_id:0 ring:24 vmid:7 pasid:6)
  amdgpu 0000:03:00.0:  Process Xorg pid 1582 thread Xorg:cs0 pid 1652
  amdgpu 0000:03:00.0: GCVM_L2_PROTECTION_FAULT_STATUS:0x00601030
  amdgpu 0000:03:00.0:          Faulty UTCL2 client ID: TCP (0x8)
  amdgpu 0000:03:00.0:          MORE_FAULTS: 0x0
  amdgpu 0000:03:00.0:          WALKER_ERROR: 0x0
  amdgpu 0000:03:00.0:          PERMISSION_FAULTS: 0x3
  amdgpu 0000:03:00.0:          MAPPING_ERROR: 0x0
  amdgpu 0000:03:00.0:          RW: 0x0
    (repeats 4-9x depending on occurrence)
  amdgpu 0000:03:00.0: ring gfx_0.0.0 timeout, signaled seq=37345, emitted
seq=37348
  amdgpu 0000:03:00.0:  Process Xorg pid 1582 thread Xorg:cs0 pid 1652
  amdgpu 0000:03:00.0: Starting gfx_0.0.0 ring reset
  amdgpu 0000:03:00.0: Ring gfx_0.0.0 reset succeeded
  amdgpu 0000:03:00.0: [drm] device wedged, but recovered through reset

Second occurrence, with openboard as the faulting client:

  amdgpu 0000:03:00.0: [gfxhub] page fault (src_id:0 ring:24 vmid:5
pasid:70)
  amdgpu 0000:03:00.0:  Process openboard pid 10092 thread openboard:cs0
pid 10114
  amdgpu 0000:03:00.0: GCVM_L2_PROTECTION_FAULT_STATUS:0x00501031
  amdgpu 0000:03:00.0:          PERMISSION_FAULTS: 0x3
  amdgpu 0000:03:00.0: ring gfx_0.0.0 timeout, signaled seq=955229, emitted
seq=955232

OBSERVATIONS

  1. The ring reset always succeeds and the device is reported as recovered,
     yet the desktop stays frozen, because the X server's own GL context
     (Xorg:cs0) is dead. The GPU is healthy; userspace is not. Recovery
     requires restarting the display manager.

  2. seq delta is consistently 2-3 (37345->37348, 955229->955232,
     11515049->11515052) - the ring stalls almost immediately rather than
     starving gradually.

  3. Independent of kernel version. Observed on 7.0.0-31, 7.0.0-34 and
     7.0.0-38. Rolling back to 7.0.0-34 fixed a separate display glitch
     (flickering lines) but did not stop these ring timeouts.

  4. Two distinct GL clients trigger it - the X server itself and openboard
-
     so it does not appear tied to one application's usage pattern.

  5. Early in the session. One occurrence had seq=37345, only about 37k
packets
     into the session, roughly 1-2 minutes after login. Not a sustained-load
     problem.

HIGH REFRESH RATE MAY AMPLIFY EXPOSURE

  The vblank off-delay for DCE_HWIP < 3.5.0 is computed from the current
  timing:

    offdelay = DIV64_U64_ROUND_UP((u64)20 * timing->v_total *
                                  timing->h_total,
                                  timing->pix_clk_100hz);
    config.offdelay_ms = offdelay ?: 30;

  It is a small multiple of a frame, so at 240 Hz
drm_vblank_disable_and_save
  fires far more often than at 60 Hz, widening the race window introduced by
  58a261bfc967.

  The workaround in "drm/amd/display: Restore 5s vbl offdelay for NV3x+
DGPUs"
  (Leo Li, April 2026) is guarded by:

    if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 2, 0) &&
        !(adev->flags & AMD_IS_APU)) {
            config.offdelay_ms = 5000;

  This card is DCN 3.0, so it is excluded from that workaround and still
uses
  the short computed off-delay.

  The global drm.vblank_offdelay module parameter is present and reads 5000,
  but the driver bypasses it for DCE_HWIP < 3.5.0, so it has no effect here.

FREQUENCY

  Roughly one occurrence every few days initially, rising to several per
hour
  on some days. Per-boot counts during the investigation: 1, 1, 1, 1, 1, and
  one boot with 5.

REPRODUCTION

  Ordinary desktop use, no games, no compute workloads. Triggers within
  minutes of login in at least one case. Reproduced on three kernel
versions.

QUESTIONS

  1. Is the UTCL2 TCP (0x8) / PERMISSION_FAULTS: 0x3 permission fault the
     cause of the ring stall, or a symptom of it? It consistently precedes
the
     timeout by about 2 seconds.
  2. Would extending the 5 s off-delay workaround to DCE_HWIP >= 3.0 rather
     than >= 3.2 be safe for Navi 22-class dGPUs? It would trade some power
     savings for stability.
  3. Should the "Restore 5s vbl offdelay" fix, currently only on the mailing
     list, be considered for stable, given that no affected hardware seems
to
     be excluded by the 3.2.0 guard?

NOTE ON DATA

  The journal has since rotated, so the raw logs for the individual
occurrences
  are no longer on disk. The excerpts above were captured directly from the
  running system during the investigation. I can provide the complete kernel
  log for a separate gfx_0.1.0 occurrence on the same machine if useful.

Thanks,
Wayne

--000000000000f34cfe065d15b8fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<br><br>Adding supporting evidence and one new obse=
rvation to the &quot;2D OpenGL Hangs&quot;<br>report at <a href=3D"https://=
gitlab.freedesktop.org/drm/amd/-/issues/4663">https://gitlab.freedesktop.or=
g/drm/amd/-/issues/4663</a>, tracked against<br><br>=C2=A0 58a261bfc967 (&q=
uot;drm/amd/display: use a more lax vblank enable policy for older<br>=C2=
=A0 ASICs&quot;)<br><br>I have seen the same kernel log signature on three =
different kernel versions,<br>triggered by two different GL clients, and I =
believe the existing 5 s off-delay<br>workaround does not cover this card b=
ecause of its DCN stepping.<br><br>ENVIRONMENT<br>=C2=A0 GPU =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 AMD Radeon RX 6700 XT (Navi 22), PCI 1002:73df rev c5, DCN 3.=
0<br>=C2=A0 VRAM =C2=A0 =C2=A0 =C2=A0 =C2=A012272 MiB<br>=C2=A0 VBIOS =C2=
=A0 =C2=A0 =C2=A0 115-D512BS0-100<br>=C2=A0 Display =C2=A0 =C2=A0 DisplayPo=
rt, 1920x1080 @ 239.99 Hz<br>=C2=A0 OS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0el=
ementary OS 8 / Pantheon / Gala, X11<br>=C2=A0 Mesa =C2=A0 =C2=A0 =C2=A0 =
=C2=A025.2.8-0ubuntu0.24.04.4 (radeonsi, navi22, LLVM 20.1.2, DRM 3.64)<br>=
=C2=A0 Xorg =C2=A0 =C2=A0 =C2=A0 =C2=A02:21.1.12-1ubuntu1.8 (AMDGPU, GLAMOR=
 acceleration)<br>=C2=A0 iGPU =C2=A0 =C2=A0 =C2=A0 =C2=A0disabled in BIOS -=
 the dGPU is the only display device and<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 enumerates as card1<br>=C2=A0 Kernels =C2=A0 =C2=A0 7.0.0=
-31, 7.0.0-34, 7.0.0-38 - all affected<br>=C2=A0 Recovery =C2=A0 =C2=A0amdg=
pu gpu_recovery=3D1, auto-selected reset method (&quot;bus&quot;)<br>=C2=A0=
 Clients =C2=A0 =C2=A0 Xorg itself, and openboard (on-screen keyboard, Flat=
pak<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ch.openboard.OpenBo=
ard, Chromium/CEF)<br><br>FAULT SIGNATURE (verbatim, captured from the runn=
ing system)<br><br>=C2=A0 amdgpu 0000:03:00.0: [gfxhub] page fault (src_id:=
0 ring:24 vmid:7 pasid:6)<br>=C2=A0 amdgpu 0000:03:00.0: =C2=A0Process Xorg=
 pid 1582 thread Xorg:cs0 pid 1652<br>=C2=A0 amdgpu 0000:03:00.0: GCVM_L2_P=
ROTECTION_FAULT_STATUS:0x00601030<br>=C2=A0 amdgpu 0000:03:00.0: =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Faulty UTCL2 client ID: TCP (0x8)<br>=C2=A0 amdgpu =
0000:03:00.0: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MORE_FAULTS: 0x0<br>=C2=A0 =
amdgpu 0000:03:00.0: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WALKER_ERROR: 0x0<br=
>=C2=A0 amdgpu 0000:03:00.0: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PERMISSION_F=
AULTS: 0x3<br>=C2=A0 amdgpu 0000:03:00.0: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0MAPPING_ERROR: 0x0<br>=C2=A0 amdgpu 0000:03:00.0: =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0RW: 0x0<br>=C2=A0 =C2=A0 (repeats 4-9x depending on occurrence=
)<br>=C2=A0 amdgpu 0000:03:00.0: ring gfx_0.0.0 timeout, signaled seq=3D373=
45, emitted seq=3D37348<br>=C2=A0 amdgpu 0000:03:00.0: =C2=A0Process Xorg p=
id 1582 thread Xorg:cs0 pid 1652<br>=C2=A0 amdgpu 0000:03:00.0: Starting gf=
x_0.0.0 ring reset<br>=C2=A0 amdgpu 0000:03:00.0: Ring gfx_0.0.0 reset succ=
eeded<br>=C2=A0 amdgpu 0000:03:00.0: [drm] device wedged, but recovered thr=
ough reset<br><br>Second occurrence, with openboard as the faulting client:=
<br><br>=C2=A0 amdgpu 0000:03:00.0: [gfxhub] page fault (src_id:0 ring:24 v=
mid:5 pasid:70)<br>=C2=A0 amdgpu 0000:03:00.0: =C2=A0Process openboard pid =
10092 thread openboard:cs0 pid 10114<br>=C2=A0 amdgpu 0000:03:00.0: GCVM_L2=
_PROTECTION_FAULT_STATUS:0x00501031<br>=C2=A0 amdgpu 0000:03:00.0: =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0PERMISSION_FAULTS: 0x3<br>=C2=A0 amdgpu 0000:03:=
00.0: ring gfx_0.0.0 timeout, signaled seq=3D955229, emitted seq=3D955232<b=
r><br>OBSERVATIONS<br><br>=C2=A0 1. The ring reset always succeeds and the =
device is reported as recovered,<br>=C2=A0 =C2=A0 =C2=A0yet the desktop sta=
ys frozen, because the X server&#39;s own GL context<br>=C2=A0 =C2=A0 =C2=
=A0(Xorg:cs0) is dead. The GPU is healthy; userspace is not. Recovery<br>=
=C2=A0 =C2=A0 =C2=A0requires restarting the display manager.<br><br>=C2=A0 =
2. seq delta is consistently 2-3 (37345-&gt;37348, 955229-&gt;955232,<br>=
=C2=A0 =C2=A0 =C2=A011515049-&gt;11515052) - the ring stalls almost immedia=
tely rather than<br>=C2=A0 =C2=A0 =C2=A0starving gradually.<br><br>=C2=A0 3=
. Independent of kernel version. Observed on 7.0.0-31, 7.0.0-34 and<br>=C2=
=A0 =C2=A0 =C2=A07.0.0-38. Rolling back to 7.0.0-34 fixed a separate displa=
y glitch<br>=C2=A0 =C2=A0 =C2=A0(flickering lines) but did not stop these r=
ing timeouts.<br><br>=C2=A0 4. Two distinct GL clients trigger it - the X s=
erver itself and openboard -<br>=C2=A0 =C2=A0 =C2=A0so it does not appear t=
ied to one application&#39;s usage pattern.<br><br>=C2=A0 5. Early in the s=
ession. One occurrence had seq=3D37345, only about 37k packets<br>=C2=A0 =
=C2=A0 =C2=A0into the session, roughly 1-2 minutes after login. Not a susta=
ined-load<br>=C2=A0 =C2=A0 =C2=A0problem.<br><br>HIGH REFRESH RATE MAY AMPL=
IFY EXPOSURE<br><br>=C2=A0 The vblank off-delay for DCE_HWIP &lt; 3.5.0 is =
computed from the current<br>=C2=A0 timing:<br><br>=C2=A0 =C2=A0 offdelay =
=3D DIV64_U64_ROUND_UP((u64)20 * timing-&gt;v_total *<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 timing-&gt;h_total,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 timing-&gt;pix_clk_100hz);<br>=C2=A0 =C2=A0 config.off=
delay_ms =3D offdelay ?: 30;<br><br>=C2=A0 It is a small multiple of a fram=
e, so at 240 Hz drm_vblank_disable_and_save<br>=C2=A0 fires far more often =
than at 60 Hz, widening the race window introduced by<br>=C2=A0 58a261bfc96=
7.<br><br>=C2=A0 The workaround in &quot;drm/amd/display: Restore 5s vbl of=
fdelay for NV3x+ DGPUs&quot;<br>=C2=A0 (Leo Li, April 2026) is guarded by:<=
br><br>=C2=A0 =C2=A0 if (amdgpu_ip_version(adev, DCE_HWIP, 0) &gt;=3D IP_VE=
RSION(3, 2, 0) &amp;&amp;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 !(adev-&gt;flags &=
amp; AMD_IS_APU)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config.off=
delay_ms =3D 5000;<br><br>=C2=A0 This card is DCN 3.0, so it is excluded fr=
om that workaround and still uses<br>=C2=A0 the short computed off-delay.<b=
r><br>=C2=A0 The global drm.vblank_offdelay module parameter is present and=
 reads 5000,<br>=C2=A0 but the driver bypasses it for DCE_HWIP &lt; 3.5.0, =
so it has no effect here.<br><br>FREQUENCY<br><br>=C2=A0 Roughly one occurr=
ence every few days initially, rising to several per hour<br>=C2=A0 on some=
 days. Per-boot counts during the investigation: 1, 1, 1, 1, 1, and<br>=C2=
=A0 one boot with 5.<br><br>REPRODUCTION<br><br>=C2=A0 Ordinary desktop use=
, no games, no compute workloads. Triggers within<br>=C2=A0 minutes of logi=
n in at least one case. Reproduced on three kernel versions.<br><br>QUESTIO=
NS<br><br>=C2=A0 1. Is the UTCL2 TCP (0x8) / PERMISSION_FAULTS: 0x3 permiss=
ion fault the<br>=C2=A0 =C2=A0 =C2=A0cause of the ring stall, or a symptom =
of it? It consistently precedes the<br>=C2=A0 =C2=A0 =C2=A0timeout by about=
 2 seconds.<br>=C2=A0 2. Would extending the 5 s off-delay workaround to DC=
E_HWIP &gt;=3D 3.0 rather<br>=C2=A0 =C2=A0 =C2=A0than &gt;=3D 3.2 be safe f=
or Navi 22-class dGPUs? It would trade some power<br>=C2=A0 =C2=A0 =C2=A0sa=
vings for stability.<br>=C2=A0 3. Should the &quot;Restore 5s vbl offdelay&=
quot; fix, currently only on the mailing<br>=C2=A0 =C2=A0 =C2=A0list, be co=
nsidered for stable, given that no affected hardware seems to<br>=C2=A0 =C2=
=A0 =C2=A0be excluded by the 3.2.0 guard?<br><br>NOTE ON DATA<br><br>=C2=A0=
 The journal has since rotated, so the raw logs for the individual occurren=
ces<br>=C2=A0 are no longer on disk. The excerpts above were captured direc=
tly from the<br>=C2=A0 running system during the investigation. I can provi=
de the complete kernel<br>=C2=A0 log for a separate gfx_0.1.0 occurrence on=
 the same machine if useful.<br><br><div>Thanks,</div><div>Wayne</div></div=
>

--000000000000f34cfe065d15b8fa--
