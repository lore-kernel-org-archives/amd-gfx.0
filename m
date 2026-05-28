Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9567BCD6E49
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 07:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C69310FA40;
	Fri, 29 May 2026 07:44:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g3a498FF";
	dkim-atps=neutral
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD34210EF50
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 10:01:10 +0000 (UTC)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-65e15fb394bso8880829d50.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 03:01:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779962469; cv=none;
 d=google.com; s=arc-20240605;
 b=apcLSeTp3uJlRToIolM7C6Ltr3Qe2JNzwxOz6q8D5hN4rqBzpmrZ94KnA+W3KvnorO
 +Cas/cayY0tkqno1UWvDefmkg3XzTCHETlJDt735r84JYM5rqux1TTNzYcewQ+8EuPpR
 AMyEe8eK2J/9FiEGOtToP9c4qzK10KOZVJANkx+phIxVmigD5+HyLezxDp0CFQdnRdT1
 lFi3mC5hO5HrYoV1bZFYvANKnoyC++ESDudb7LSbeidzAILnKdLblyfYLDRSZIs2thXR
 zj7z2mJ59d0QwR2dfyMOPxxT5WyYS3SZYWrtcnBAOEu97AD405BMSSC3+ZvUdFepObEy
 EUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ENaGop7hdOhRvlo9/v6zprcr5Co1+opC5qv3HonlvMs=;
 fh=Ca8+V5bvQf7cz/uQ/rOEXYD6EvMa4d0I040Bpe5rBS4=;
 b=DpPGu0m0LFQO5/1G6pnckSAFP3WWTBmCnoADLb5Lk6kaARqofTIP7uJmnjamCtMVpT
 m1FEO3fUj1bwco3Uo65yEXOQCp+tU4BKeofVCIPTVGEFEBdMbzOiCmoR9ChDCCwdaZN6
 SvWmyX1+LRmgD7DtdD1+1aZ/YW9XIdUxjJIb9pXuyDo1o+Rfw0dsI2+Udy0qtQvffDmw
 rDfWAB5s/OfprG7Ieg2Nm7VJ9jEk3jWMvlSXJlNp6PCjrASCzwjhSI14sYUl+/y/YbN+
 Qu3a0mKqHqoYfUDu7hd1AEeorKJYHcsfW+BchszjzGWCZ4J54xcJN/R8YL8Hs/PdSrDq
 6Hdg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779962469; x=1780567269; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ENaGop7hdOhRvlo9/v6zprcr5Co1+opC5qv3HonlvMs=;
 b=g3a498FFqNwSL3udJYupbXixF1mM8SbJqcFdB0qUQFsl0RityJQbCYMCt+BgvOghcL
 ZpenSjKsysi8tYOfPTVYgxKn78OXzgyDwSRsuBqiHsVmisand58F5nmOHnbqx7+f/TQq
 5LbTNF96HJ1NTQSGxbfKMV998TZEAY0kZzjvjA+yTdjR+QGaJMP+bGC8J/Qsj1B8ek2I
 GP3ukQlZFIchWC937OP8wMEF9x3pPKfETmfJZGzKXsl5/sQ1F/+W1a9WpHOcXoDXJzUY
 qy7t0gxORyd1Vq04esnvMJSN86X3r9NtEMqKm66AqNaFcD9nK1ZGwAtR4VIyHSK0XMuO
 /wfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779962469; x=1780567269;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ENaGop7hdOhRvlo9/v6zprcr5Co1+opC5qv3HonlvMs=;
 b=ky/qieBTNFVRLbnzoWD846Ohhk2E15hFp7ehwW5TMEy6TH/x4y4dEyqZkXtoRcEEfZ
 1BUQZHrMHE7Y83Iyjt/DJzLLvpAsHw9kTzR1ETnLKriCGdGLGnZgWd2we9ij4MD0pPNa
 Y3SuzTgxvQGm4f8idEOoouvV97t2rs6pjPE4b/URXikXwF16m3EbFouUxDDgL4hcNLla
 wIaLXXRF6s1Yy/7WY/kAtIwSD5/frVjrYgPzWwpp/3fDFWawZOQeaMiLbYU2Bw9thms2
 rSu6YmhVGb1xb32ZmOGdDkypbIHJN2e3tnHZFRZuylKHpJiYf6Le0/PR9wB2S4g75qbQ
 Z+LQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9PQiG7id04ugeuuwKayUHqPzBNgtTp2AmUIfy33tzKl0JytGclyLzW/yQBI2fkkXjnQAi6ZcEL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAd1aaeYq7w7msW1iroo2AsfB4oPxzeR9tNRj2AQZXpSwgyDus
 74ktmGZ8zLY8EjHKt+IDzZGT6y8RCeJun+7srDxJXbV65Wm1BjcjgBknDsObwky41yZw0xeDcWz
 FvDw1jeU1mnKkDDDv+pvFePb2LzU4PJc=
X-Gm-Gg: Acq92OFKbMUyzNjiuFDOMGIUHZlyqgiDyC+uj0URj3VDaOABCFAh90gMj9Ycbj2nFM/
 tjR3moNBtkRAViJaZUUxp7FSX4VA2/Ao1EEKYGyG6LjzwrexIyiTpZYeVQe7K6Yt/p5QAvr6MJ4
 0Oi/n9/eoDmi+6/FkpYNrb5MThQjpip+cp4AHKOzTdmYCNyPf5mF0+iGCmEJum10KG3vqdtpWme
 uZs8ekPLSxlI68DcqABAVZEk2efuzvDYQf9Nxq/eLiSsWZGO+D8ENwf7IqhiE4HOv49ERlp1uy+
 /XumoQvL2ge7c5EOOvDJGnqxamWKFFnaeLi4Ih9XbU/EY32YppKvF7cci2JoF0/y5fN9DcisidJ
 eUx6rpQ==
X-Received: by 2002:a05:690e:4090:b0:65e:421f:25a with SMTP id
 956f58d0204a3-65ec9938b9dmr23205364d50.53.1779962469261; Thu, 28 May 2026
 03:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260527133917.207150-1-tzimmermann@suse.de>
 <CAHijbEVZBRTK7yhZy8gaZwb19JMzUD_nA2S1LOKX2NrK19RBsQ@mail.gmail.com>
 <1d399c2d-b50f-4d19-8170-9db8961e4227@suse.de>
In-Reply-To: <1d399c2d-b50f-4d19-8170-9db8961e4227@suse.de>
From: Julian Orth <ju.orth@gmail.com>
Date: Thu, 28 May 2026 12:01:01 +0200
X-Gm-Features: AVHnY4Kd6TXNqqh3i-IesxOIMTyuSSIzXsJX_ARE_lWWTyd_wM1yd783Bw12QD0
Message-ID: <CAHijbEUKpOuDLJES9AbSp8Pk+egeDPe7KPyBy1xBFM9ET9peCg@mail.gmail.com>
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
X-Mailman-Approved-At: Fri, 29 May 2026 07:44:33 +0000
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

On Thu, May 28, 2026 at 9:54=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 27.05.26 um 18:31 schrieb Julian Orth:
> > On Wed, May 27, 2026 at 3:39=E2=80=AFPM Thomas Zimmermann <tzimmermann@=
suse.de> wrote:
> >> DRM's WAIT_VBLANK ioctl synchronizes user-space clients to display
> >> refresh. This is meaningless with vblank timers, which run unrelated
> >> to the hardware's vblank.
> >>
> >> Disable the ioctl for simulated vblanks. Set DRM_VBLANK_FLAG_SIMULATED
> >> for CRTCs with simulated vblank events in all such drivers. The vblank
> >> timers of these devices still rate-limit the number of page-flip event=
s
> >> to match the display refresh.
> >>
> >> According to maintainers, user-space compositors do not require the io=
ctl
> >> for rate-limitting display output. Weston, Kwin and Mutter rely on com=
pletion
> >> events. Mutter optionally uses the WAIT_VBLANK ioctl only to optimize =
the
> >> time from input to output.
> >>
> >> When testing with mutter and weston, the page-flip rate appears correc=
t
> >> with the patch set applied.
> > To avoid this being a regression, you need to test that this change
> > does not regress input latency.
>
> Let me stress that the current situation is that there's high-quality,
> and low-quality and no timing information. Depends on the driver and
> hardware.
>
> >
> > As discussed on IRC, compositors use vblank data to predict the time
> > of the next flip event. For each device that you are touching here,
> > there are two possibilities:
> >
> > - The vblank data is related to the flip timing, i.e. flip events and
> > vblank events are sent at almost the same time. In this case removing
> > these apis removes the path for compositors to predict the time of the
> > next flip event. Input latency will therefore regress after idle
> > periods when the compositor no longer has the time of the last vblank.
>
> User-space compositors seem to operate under this assumption. That, I
> think, makes sense on better hardware with rendering and vblank IRQs.
> Page flips are fast on such systems.
>
> >
> > - The vblank data has nothing to do with the time of the next flip
> > event. In this case this series could in fact improve latency because
> > it removes the incorrect data from the compositor.
>
> Most of the hardware that would use vblank timers falls in this
> category. Page flips often consist of memcpys into video memory, or they
> transfer pixel data over slow peripheral busses. The amount of work per
> page flip varies with the size of the damage rectangles.
>
> Any vblank timing information here is therefore of low quality. For some
> scenarios, it would be common to miss a vblank or even the one after it.

What matters is if the flip event will be aligned to _some_ vblank
event. As long as that is the case, the compositor can estimate which
vblank it will hit based on previous frames and can schedule its work
accordingly. I believe KWin and Mutter already support scheduling
frames for multiple vblanks in the future to support low-powered
devices or devices that are under high load. I have not looked into
this myself.

But even on high-powered devices compositors already take per-commit
kernel work into account. For example, by default I aim to commit 1.5
ms before vblank. This grace period is adjusted dynamically if I miss
the expected vblank.

Therefore I don't think this is an argument against exposing vblank
info. Even if the hardware had such an interrupt, the memcpy and
slow-bus issues would continue to apply.

>
>
> IMHO, the first thing to discuss is whether having possibly low-quality
> timing information is preferable to having either high-quality timing or
> none. I have no strong opinion, but would tend to the latter.

If you want to make userspace aware that vblank events are not backed
by hardware interrupts, then maybe this could be exposed as a driver
cap or a flag in the vblank event. Userspace could then decide on
their own what to do with that information.

Currently I don't think any compositor would use that information
since they target flip times and don't care if those times are driven
by hardware or software (since this is not actionable by userspace
anyway). So maybe the useful flag would be "flip times will not be
aligned to any vblank event" if that applies to any driver.

>
> Best regards
> Thomas
>
>
> >
> > Whether the times of the flip events correspond to hardware timings is
> > not relevant. Everything in wayland compositors is scheduled against
> > flip event timings and they are also forwarded to clients for their
> > frame scheduling. If the flip timings are wrong/out of sync with the
> > hardware, then removing the vblank apis does not improve this
> > situation.
> >
> >> This change has been discussed at length on IRC recently.
> >>
> >> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&hi=
ghlight_names=3D&date=3D2026-05-08&show_html=3Dtrue
> >> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&hi=
ghlight_names=3D&date=3D2026-05-12&show_html=3Dtrue
> >> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&hi=
ghlight_names=3D&date=3D2026-05-13&show_html=3Dtrue
> >> https://people.freedesktop.org/~cbrill/dri-log/?channel=3Ddri-devel&hi=
ghlight_names=3D&date=3D2026-05-15&show_html=3Dtrue
> >>
> >> v2:
> >> - add filter to CRTC_GET_SEQUENCE and CRTC_QUEUE_SEQUENCE ioctls (Mich=
el)
> >> - clarify Mutter's behavior in cover letter (Michel)
> >>
> >> Thomas Zimmermann (9):
> >>    drm/vblank: Add drmm_vblank_init() to indicate managed cleanup
> >>    drm/vblank: Add DRM_VBLANK_FLAG_SIMULATED
> >>    drm/amdgpu: vkms: Set DRM_VBLANK_FLAG_SIMULATED
> >>    drm/bochs: Set DRM_VBLANK_FLAG_SIMULATED
> >>    drm/cirrus: Set DRM_VBLANK_FLAG_SIMULATED
> >>    drm/hypervdrm: Set DRM_VBLANK_FLAG_SIMULATED
> >>    drm/qxl: Set DRM_VBLANK_FLAG_SIMULATED
> >>    drm/virtgpu: Set DRM_VBLANK_FLAG_SIMULATED
> >>    drm/vkms: Set DRM_VBLANK_FLAG_SIMULATED
> >>
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c    |  3 ++-
> >>   drivers/gpu/drm/drm_vblank.c                | 26 +++++++++++++++----=
--
> >>   drivers/gpu/drm/drm_vblank_helper.c         |  2 +-
> >>   drivers/gpu/drm/hyperv/hyperv_drm_modeset.c |  2 +-
> >>   drivers/gpu/drm/qxl/qxl_display.c           |  2 +-
> >>   drivers/gpu/drm/tiny/bochs.c                |  2 +-
> >>   drivers/gpu/drm/tiny/cirrus-qemu.c          |  2 +-
> >>   drivers/gpu/drm/virtio/virtgpu_display.c    |  2 +-
> >>   drivers/gpu/drm/vkms/vkms_drv.c             |  4 ++--
> >>   include/drm/drm_crtc.h                      |  2 +-
> >>   include/drm/drm_device.h                    |  2 +-
> >>   include/drm/drm_vblank.h                    | 15 +++++++++++-
> >>   12 files changed, 45 insertions(+), 19 deletions(-)
> >>
> >>
> >> base-commit: 5fb5a9a63cf5ece68e0eeb6fa397da27712bccf0
> >> --
> >> 2.54.0
> >>
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG N=C3=
=BCrnberg)
>
>
