Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4529CC3601A
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Apr 2025 19:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4379F10E0A0;
	Sun,  6 Apr 2025 19:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="epJ1OeBN";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF8D110E0A0
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Apr 2025 19:58:24 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-301317939a0so379067a91.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 06 Apr 2025 12:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743969502; x=1744574302; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cxcANlwy/TuT8NdysHDYuF4y6YQwyUXQsRmzniJmli0=;
 b=epJ1OeBNKyfQteM7oDalYWPKFJNlIon0T4Ns+p7yE761NMbahvIGMnxPW7FEEWg3qf
 CGNGFQmjcTMptEYvGeMc6I7V0wge1tsIdm+yCPYwW8lhKOhSgFGKjcbpR+M+oX3jB39X
 x2BmrWCDM1anUeN6KDpNlrTK3M5uozkn55IZsJTJ6pHGVuUyyPUVwe69uU4C9Xmy4rMk
 3obPnZKv4qZsaoVDYL9AbbLJt2qWORLiUMmp04gjxFV7hNOi8HfeQXUiF0ck7lLv40U0
 ir6mkffZsOvWBqbUHHF1QzS0oqRoOcIJ3X+vwRekPa+g9Hk7F9HLGAtYUmORQ4qkjYlt
 WQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743969502; x=1744574302;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cxcANlwy/TuT8NdysHDYuF4y6YQwyUXQsRmzniJmli0=;
 b=QmEGWBE/tmitfl/7LtMeyR1X7ufemLH72YRGLKRHBwsWhhiO/WLSrke6BqbpBKi3cb
 zXNOkMNvoa9cY5HjGTtMWRykXb7Rp24S14gng9jijOs0gFOaAiTSq1acYq4YlIi5O4cL
 fHseznPt2JCxnlWizOo+YSecKXXQ6UwgkVvrIl0GFPYRYrOOvCCO1Rhi2RdJxz4FZJ4N
 m2dlLNZu6Nj1QnVX6AnB5Z/zj3r2sHw/1F/FTSTkT+CUowrXezVRLeaEZF/baQ893GmK
 ucU53KsNr4AQqDW71/6/VRP/cPyzG7c4LIrdRP5muvxw/4stvHqsYlaUozDEXvRSaiGZ
 BDKw==
X-Gm-Message-State: AOJu0YwBHrqdjLiYNBdyNGkEy7JhWU/+XK2sGYH/7OSvw0jsM8ux24i/
 zVnWsn4rxxHGyZ1RuxncsnodG71F+y1AaHEhD3n7eV6BNiI9qAshlYIoRqgbAcxN5sguFZZr/64
 4Z6pGxM6vi+YXntikElBRlCnTZd7NneTK
X-Gm-Gg: ASbGncuIoZPlCf7Z/emqR+j62oeXuu738965YO/yr7LM7ihnRDG+W/onkEuPoVaFzvk
 4UePQW0tiuITcY0B81J0Dz8SdqfZNJFZ62KQKU7ScsuXeVAne0Cza7SYVXDXzM9Yv6Y4Wr1dE7m
 sLQ6qaSSP8+aYAXTTiZzu3f4yqHQ==
X-Google-Smtp-Source: AGHT+IGtc+ldaOLm7KArL70HQY0VrWV1PdkFvz1jwPK7d6K9S9gz8W+9q2yV9oI0URUDJ5tAD/phWgEV3047IlKMYjg=
X-Received: by 2002:a17:90b:4f89:b0:2ff:4b7a:f0a4 with SMTP id
 98e67ed59e1d1-306a4865251mr5017956a91.3.1743969502145; Sun, 06 Apr 2025
 12:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250403031148.1266785-1-superm1@kernel.org>
 <CADnq5_Nz76WBm8wsU8k4LUpXrjKk6AbJfYV0CpaV3sXAJ2McEQ@mail.gmail.com>
 <1d762b4d-3aae-4fad-b464-d1baa124e86e@kernel.org>
In-Reply-To: <1d762b4d-3aae-4fad-b464-d1baa124e86e@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sun, 6 Apr 2025 15:58:10 -0400
X-Gm-Features: ATxdqUFLFnmSSVproTi7WU_dg9mrbI-mS0B3mke3nK0PsoBa7IQn3-rY_-nB5eY
Message-ID: <CADnq5_NKAHX1NOyS2GNx1v7uYq2d9D9op4BDqgbYxcCwD_QRjQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd: Add pre-zen AMD hardware to PCIe dynamic
 switching exclusions
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
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

On Thu, Apr 3, 2025 at 3:13=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 4/3/2025 10:48 AM, Alex Deucher wrote:
> > On Wed, Apr 2, 2025 at 11:12=E2=80=AFPM Mario Limonciello <superm1@kern=
el.org> wrote:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> AMD RX580 when added AMD Phenom 2 has problems with overheating. This =
is due to
> >
> > I don't think this is entirely accurate.  I think the GPU gets hot
> > because the device hangs due to a problem with changing the PCIe
> > clocks.
> >
> >> changes with PCIe dynamic switching introduced by commit 466a7d115326e
> >> ("drm/amd: Use the first non-dGPU PCI device for BW limits").
> >>
> >> To avoid risks of other issues with old hardware require at least Zen =
hardware
> >> for AMD side to enable PCIe dynamic switching.
> >
> > I'm pretty sure PCIe reclocking worked on pre-Zen hardware.  We've
> > supported this on our GPUs going back at least 15 or more years.  I
> > suspect the actual problem is that some links may not reliably train
> > at the full bandwidth on some motherboards.  Forcing a higher link
> > speed may cause problems.
>
> That seems odd to me it would advertise a higher link speed than it
> could train at.

That's why we train the link; to determine what speed is reliable.  It
could be that there is a marginal trace on the motherboard that has
deteriorated over time or was never reliable to begin with.   It would
be interesting to know if the link used to work reliably on this
board.

>
> > Maybe it would be better to limit the max
> > PCIe link rate to whatever the link is currently trained to.  IIRC,
> > PCIe links will train at the fastest link possible by default.  The
> > previous behavior was to limit the max clock to the slowest link in
> > the topology to save power, but then we changed it to use the fastest
> > link possible based on the PCIe link caps.  Perhaps limiting it to the
> > fastest currently trained link rate would be better.
>
> I mean that's essentially what happens when
> amdgpu_device_pcie_dynamic_switching_supported() returns that it doesn't
> work.

I mean rather than checking the PCIe caps, check the current link
speed instead.  pcie_bandwidth_available() returns the speed and lanes
of the slowest link in the topology; what we want is the current speed
that the link upstream of the GPU is trained at.  If there is no
USB4/TB or limited speed bridge upstream of the GPU, then that
function should return the current speed of the link which would be
fine.  The problem is that
amdgpu_device_pcie_dynamic_switching_supported() returning false
disables PCIe DPM so we don't dynamically change the PCIe speed/lanes
at runtime.  I suspect that would work fine as long as we don't go
past the current speed the link is currently trained at.

>
> If your theory is right; maybe what we really need is a pile of DMI
> quirks for M/B that are having this problem.

Depends on whether it's a general problem or something specific to
this particular board.  I.e., the slot on this board has deteriorated.
I think what we want is to enable PCIe DPM, but just limit the link
the the max current speed rather than the max speed.  If the links are
reliable the links should train at the max speed on power up.

Alex

>
> >
> > Alex
> >
> >>
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4098
> >> Fixes: 466a7d115326e ("drm/amd: Use the first non-dGPU PCI device for =
BW limits")
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >> v2:
> >>   * Cover more hardware
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c
> >> index a30111d2c3ea0..caa44ee788c8f 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -1854,6 +1854,9 @@ bool amdgpu_device_seamless_boot_supported(struc=
t amdgpu_device *adev)
> >>    *
> >>    * https://edc.intel.com/content/www/us/en/design/products/platforms=
/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-o=
f-2/005/pci-express-support/
> >>    * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
> >> + *
> >> + * AMD Phenom II X6 1090T has a similar issue
> >> + * https://gitlab.freedesktop.org/drm/amd/-/issues/4098
> >>    */
> >>   static bool amdgpu_device_pcie_dynamic_switching_supported(struct am=
dgpu_device *adev)
> >>   {
> >> @@ -1866,6 +1869,8 @@ static bool amdgpu_device_pcie_dynamic_switching=
_supported(struct amdgpu_device
> >>
> >>          if (c->x86_vendor =3D=3D X86_VENDOR_INTEL)
> >>                  return false;
> >> +       if (c->x86_vendor =3D=3D X86_VENDOR_AMD && !cpu_feature_enable=
d(X86_FEATURE_ZEN))
> >> +               return false;
> >>   #endif
> >>          return true;
> >>   }
> >> --
> >> 2.43.0
> >>
>
