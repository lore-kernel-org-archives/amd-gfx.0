Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350C2F8FA79
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 13:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABEB210E1FB;
	Tue, 21 Apr 2026 13:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l+dB0H8R";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0591B10E1FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 13:42:35 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2daaab98000so275591eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 06:42:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776778954; cv=none;
 d=google.com; s=arc-20240605;
 b=Pft74wA4EXP6qtxr7m23Ksb0NK4mSVrnyN/KmPmboVwm1UzyfAV8rkPwfIOEcUKFcc
 UGq8iPMlv6bw2BgqgbJwbNrErWVbGUVXaGDvgz2CepXSKbe0DKYDr3zxWc8G8if/079i
 blGQtYA08+FHvHg3pvoLscW4OUeBafxi7+5omDUfwhR5ta7m1N78AQK9Rfe2QLpQfOTq
 331aQ0uGaQ1PuHKA0Ffa4dCZy6LxvMEO/pQGl9e+AVJx15jdjjo2xBna+8ciyfTT89XZ
 DHcCIXTIUVayDf6SjzFBrc6xWlCk38mj7ozujcZErKNUZATsqKKG2jZj6VdTxVTM9ZTu
 J3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AontFqJ29O9B4XddB2vlqOXKOaoCcdqy5Wv6UVFlFKM=;
 fh=fRKBMZzmYTzRRKMJHkX4yshagjlNv2AVcLJhDxyfvDA=;
 b=GLlTK+fZCMCiTV3ZTMNqPxzeeFE5uN515qXRXjl1to+joJ3ACU1RPXiP+SybMyt7R5
 E3PPl5DAX2nmtdUd/IiGUE+z1ZtAFJt1J5Tb1r3QkajsOlDvpqcM/ZltUUb9q1JvSSmH
 44EOwhw9WT3cgpAy1c5JbOLQnMBxLZ9BCRg2vcqsvE6UcUWQFzCdV3KDc63aAk5jX5GC
 5ugHircVjZx1Xx0Hg6DLHS7EoBb2sKmdqepMFNJpwsGjQyGHR8Jxn7nv8r3MEG1TSKpE
 iV5pmrIjnECr9TGIIVkKC9JgsmX1SS1ntP+bqcvIZGJdV2YMxOkMIc7AnEd5vQKLWfNe
 tltw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776778954; x=1777383754; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AontFqJ29O9B4XddB2vlqOXKOaoCcdqy5Wv6UVFlFKM=;
 b=l+dB0H8RP+FHPEf/nZlUoB4zQtfErGqGtKlYOjMFwFDYdoU/FsJscYobNXNnb4C/Qh
 BoQlkSc9Oa344EyPN985zJYXiq/WrnNIUmwgWZk0Npjwc5C5Vgfmy7eS+MaXLil3+oPX
 gKtKY01FqaR/jga5pINv9h+jsvXMIEQL3wEmozKPCMjxdTZbhUd89rCa1JliFbG3FJdJ
 eDlv+7aYIiu7EteZxX5BTZEQbjGMW3dbKCAnKqbJnQZATh+d5z/y3F8//h8UO0v5eyN5
 l41Gpzh/x4HO6dMyYtOKlEyJQXGVMtuPnijTdCVwPn82/NbJAruap/XCGQgfSmeA8rfl
 7UaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776778954; x=1777383754;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AontFqJ29O9B4XddB2vlqOXKOaoCcdqy5Wv6UVFlFKM=;
 b=XWiwhr3mNJP4EhDZwqx/B5I03l8B0DP4Wfy3kYZZKr5UlxVY2UTHJsu5TvposdX7+i
 2tMZtShuFUnfYYG2+yzuNrBJh4RylmVU/5NX/O0xnwGLzu9qanKvAe8CSt4ve9Z/zvHY
 XmA9qdNl4ttTZLEGCPrj+NPlDUVLorS9YyCvIVHh7Un2Wje5CT5hP1TI3ow3F4/WgvxN
 n82cqfmEL8eCElYFhigWYtrjqc4mZd1x7lZvDsTaDh1gGVDhLthQR9kU8paVP1/fwY1r
 GXEFlaz62tRqg3XwdulA2QE/EVltNZgoaeqX+dt1f4ctAVIYi7DXrd4GWtWSL3jSR2cQ
 TPeA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mGF6fWEZBBUiY6uP2FgmXo3SOOTlWxhhOpuOjNvj1EKIp0zv9Jo97EiaC8+NMDr2Dg+wwNvo1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGs7EgzrLA/5TvQzDkyRm+yqc435wP0kEOfiqvveqXZtZ2lf7J
 jfM4GwjB25jhyD9jIHMqLIer27ggqaM3txOL4iBFIHzGOtnctBahNhEMNYheRCrAg8JvRZIeE8J
 MqCq6LMJ3HExSgz9xTCfRL9xP+JnWbRM=
X-Gm-Gg: AeBDievKpxOLOVKKCb68Dwsgz8S6S4pPD/btVjfYXMRpwgfcLJtjAkJUi8cqS6Cjf7g
 OuqePQIX4pHNTCddzEpKnm7N4qyu9ThcPVm+hRYm/RpLum7kkEt8CkxTUXtV7vEW/3Rkoz99nb7
 Fm7GstfulXRg7d7wwlhTr8wh1FF11e6qFDDCdQCdRqz+2oxwiuu5GyBHTJyC8niE7WBNfmxM63O
 xldXi1NCQfo9MywfOXu1WG+BP05c23YZGz1i9qV08sft4kyTtvTMMsnuoHCXDT1my6+/K5dXuEA
 i2HJpYIPYQdF6C3nrOeUXqBY7Wwy/kkfMhQZQWPnT86oZSW7BcAVfaJUmh3PnUwbQ7MCC5QRo5/
 rvg3k
X-Received: by 2002:a05:7022:6889:b0:124:af80:9d0c with SMTP id
 a92af1059eb24-12c73d26cc4mr3678862c88.0.1776778953884; Tue, 21 Apr 2026
 06:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <bug-221376-2300@https.bugzilla.kernel.org/>
 <20260420215717.223372-1-arjan@linux.intel.com>
 <34718f21-712a-4161-98e0-079dd9390ae6@amd.com>
In-Reply-To: <34718f21-712a-4161-98e0-079dd9390ae6@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Apr 2026 09:42:22 -0400
X-Gm-Features: AQROBzDeqv9bDX2RaJLbOqX6UXVA0203SVdcLBSCszkeeI82FwKP2sCJ2EAHOV4
Message-ID: <CADnq5_McEDYBcU8B+T4MeRKoST10EhA=LWXju1y2BL48kJPBNA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix zero-size GDS range init on RDNA4
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: arjan@linux.intel.com, amd-gfx@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Tue, Apr 21, 2026 at 2:59=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/20/26 23:57, arjan@linux.intel.com wrote:
> >
> > RDNA4 (GFX 12) hardware removes the GDS, GWS, and OA on-chip memory
> > resources. The gfx_v12_0 initialisation code correctly leaves
> > adev->gds.gds_size, adev->gds.gws_size, and adev->gds.oa_size at
> > zero to reflect this.
> >
> > amdgpu_ttm_init() unconditionally calls amdgpu_ttm_init_on_chip() for
> > each of these resources regardless of size. When the size is zero,
> > amdgpu_ttm_init_on_chip() forwards the call to ttm_range_man_init(),
> > which calls drm_mm_init(mm, 0, 0). drm_mm_init() immediately fires
> > DRM_MM_BUG_ON(start + size <=3D start) -- trivially true when size is
> > zero -- crashing the kernel during modprobe of amdgpu on an RX 9070 XT.
>
> Mhm in general not a bad idea, but we are having tons of GFX 12 systems i=
n our test machines and nothing is crashing there.
>
> We are clearly missing something here. Is that on an upstream kernel or s=
omething backported?

Looks like that check only asserts if CONFIG_DRM_DEBUG_MM is set in
the user's kernel config.  I guess no one uses that option.  These
chips have been in the market for over a year and no one has reported
that until now.  Applied with a note about this in the commit message.

Thanks!

Alex

>
> Regards,
> Christian.
>
> >
> > Guard against this by returning 0 early from
> > amdgpu_ttm_init_on_chip() when size_in_page is zero. This skips TTM
> > resource manager registration for hardware resources that are absent,
> > without affecting any other GPU type.
> >
> > Link: https://lore.kernel.org/all/bug-221376-2300@https.bugzilla.kernel=
.org%2F/
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221376
> > Oops-Analysis: http://oops.fenrus.org/reports/bugzilla.korg/221376/repo=
rt.html
> > Assisted-by: GitHub Copilot:Claude Sonnet 4.6 linux-kernel-oops-x86.
> > Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> >
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |    3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index afaaab6496def..8075ac735321e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -75,6 +75,9 @@ static int amdgpu_ttm_init_on_chip(struct amdgpu_devi=
ce *adev,
> >                                     unsigned int type,
> >                                     uint64_t size_in_page)
> >  {
> > +       if (!size_in_page)
> > +               return 0;
> > +
> >         return ttm_range_man_init(&adev->mman.bdev, type,
> >                                   false, size_in_page);
> >  }
>
