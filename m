Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E189CF34C63
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 16:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 844D910E4CE;
	Mon, 13 Apr 2026 16:12:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gVfkzB9g";
	dkim-atps=neutral
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F90710E4E9
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 16:12:34 +0000 (UTC)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-56d90654608so205321e0c.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 09:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776096753; cv=none;
 d=google.com; s=arc-20240605;
 b=jhkuKsXl9JddM7/EAr6qQEZpTebSw7BkCy5hCzT4/VeFLv/JhlSEMKI3VXGhWflgLl
 0MXQrD+KyMLnP6WiHFNXBI8HIKk8/KtX6XWdqBAJQyaNxmQ7AB6xcihgCsoOndakgve4
 pFQkVvsk7pws+128305hA7eg9wTr5578FBLFxy2dYLHSNC6/ni/cAAd8zCX4/Cw0gXDB
 m0ul6DtklFaYTjoF6oTHpDAcbiWWEu/BxhF9aeDvsVTcLLPclSnJaduLaCkoO03jwQS8
 nxRX7/Sb+0jbHLUELGNmlKV5iXtGZu5fkzA92j4LM92oLp3OwqZieuiuYkeIhqSc/ihw
 SPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GiZTL1QHqTENi+X8Hcl+iefGIVn90mkEwf/uGIfBTKw=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=FKNNE7gXjM8pvq8ZuUTG8ZbBQL3MmcBwxtEGjqU1QDP7pfQKUB7U4QzKyB5AyiHlsX
 /X1Ji4Nk7WcoKqkwQ+pJOMTUDECWFRtoBJddJ3VQ4g2KHfQ9QZBxGLYe8ECgqsBJ6SOZ
 O2bJZz2ePpMZPk4UCVIkMHa+s04qaAVo6PPIhWhO3n7DVxcR3vEp5P6nvTDSKhhv3bUL
 +enOZgW80Znp+LTz8Ka/BSSvsEb+cB89JqKkCeWE6jrwYOnaCDlikgqPtQp7pGo54y6e
 6V92RgaZqHEUAhaiu1u30vbANig/PdvTt1Sadr41ZPby6Rftupqmm8ISTvT1ykcGvXfc
 1Skw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776096753; x=1776701553; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GiZTL1QHqTENi+X8Hcl+iefGIVn90mkEwf/uGIfBTKw=;
 b=gVfkzB9gUWgkJUl+2BUra0wML7oyCd183f12u8Z393UR/IskA0T5exH6GLVKI+xn/y
 FUs+BAnodiS81YpnBNF9cKUvxnWPY0LzKeCm1fXHkrV8snno1EEL8Wj0pwz3+Az+xMWh
 ihHzpziNPaZByupwXBawaAOgctkaYOUj7u9svp4fsfeKs8jZGLo1aQFGtkroKsc2Nq8W
 +4Kre46vftRQpA69O5qJVgnXcVcp441LgY41NXvRtdIhWq41XzBFuIKDzeNufGlmwU6H
 pVbJER5L8qW14DYgdlc+7riUhoAl7sH5tEY0oWIijfJH6az0k3tWRWIcTHcdii5QTDt6
 DpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776096753; x=1776701553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GiZTL1QHqTENi+X8Hcl+iefGIVn90mkEwf/uGIfBTKw=;
 b=iurAv3POqtEfb5OpJfmFhv0NSe2p70YdcfUCFKhfBNQwjLViVXoysyNrTmQ/e1Jv8z
 PcumGIwpaxiF0lng/vGsrB8UWPuLiC++zhMGDMCwg5EWXuPMyp4cPDwMPhsFlEzFHOCC
 597EorGfBtOxlF2j97GtJkXMTpgjA2a9l5rBw093rGM4VpFyBPvZltuffU5yBNxAJidM
 z1QRLakG9/EYxRUOwdzCU6hcnfCA/CdVF4yJ6KN6vfu2rki/52uDmDWTie7gAV8WiN+A
 QhAeje5VO+32REUAvsQFIuE0f/jZtroPj2MG/MXHlx4budFbpBSngn9rE36gbQyFCgd/
 cejQ==
X-Gm-Message-State: AOJu0YwDGeWhXgu0LLqEf+IHzMOISTVg3NMbdjJhdukMYh7Sng6jSKDt
 vY7YcGQTvs2IeDg4tQt1n6ogP3bwHo5mA6eFg/0+DHoHFosMzQ2XQDfDPeWKKw6a8HycvldZ1RG
 3hE5Kr629F6Rz9uxCudzfYlrU0V5YZcE=
X-Gm-Gg: AeBDievMZRw6UIRLQVbVuksPqhxIXU3peoX0/nFh9kYum7/JSE1EW02Ek2T35q3kv6X
 D2elU2c9GuHjD99wRAhnOqQRB4HOkbavq/GCAo/okQEJnNSjYt5F8/G/X6dhGgpO+y2IlPGkd/q
 fp6d2gLQVysA48Mtft/9+IemPQsg5JsamhH+hu/dbfuIsS5zK/TQhrPkAvbgZowdVBLSsC2SFlu
 4Cc9NsL8I2XDGPvqcPc15ESwrZ5LHlgb36cMzmIu96k0Li5VMiKet1ijftrPdFM65/KSLPkkWmL
 Q3bfK0hmfOwXfVUbgK8LEQPt3lR1zoMzbePqOAFU8lhM9UHurSR6WC4ZPkaI/6akh/duTw==
X-Received: by 2002:a05:6122:6138:b0:56d:a70d:7f06 with SMTP id
 71dfb90a1353d-56f3b98c3ddmr2196315e0c.0.1776096752731; Mon, 13 Apr 2026
 09:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260326175140.52753-1-alexander.deucher@amd.com>
 <CADnq5_ONMWOCPR3wdWLEKPz7EeOHDS3ZMeFe9VD_5N5CXQ3Piw@mail.gmail.com>
In-Reply-To: <CADnq5_ONMWOCPR3wdWLEKPz7EeOHDS3ZMeFe9VD_5N5CXQ3Piw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Apr 2026 12:12:20 -0400
X-Gm-Features: AQROBzC4Z4vZeeZ5QEse7jds0-tTtBBJdE-C-OiOf94MYGFXhecvSGRSymaOBmA
Message-ID: <CADnq5_N4_0bC-y1FPBq4tP0PpbT8OgDi9Rx3j+m78RTmDoQR-A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sdma7.1: add support for disable_kq
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping?

On Fri, Apr 3, 2026 at 10:01=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Ping?
>
> On Thu, Mar 26, 2026 at 2:09=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > Plumb in support for disabling kernel queues and make it
> > the default.  For testing, kernel queues can be re-enabled
> > by setting amdgpu.user_queue=3D0.  Kernel queues are still
> > created for use by the kernel driver for memory management,
> > etc., just not user submissions.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v7_1.c
> > index f20e0fc3fc743..061934a2e93a3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> > @@ -1268,6 +1268,18 @@ static int sdma_v7_1_early_init(struct amdgpu_ip=
_block *ip_block)
> >         struct amdgpu_device *adev =3D ip_block->adev;
> >         int r;
> >
> > +       switch (amdgpu_user_queue) {
> > +       case -1:
> > +       default:
> > +               adev->sdma.no_user_submission =3D true;
> > +               adev->sdma.disable_uq =3D true;
> > +               break;
> > +       case 0:
> > +               adev->sdma.no_user_submission =3D false;
> > +               adev->sdma.disable_uq =3D true;
> > +               break;
> > +       }
> > +
> >         r =3D amdgpu_sdma_init_microcode(adev, 0, true);
> >         if (r) {
> >                 DRM_ERROR("Failed to init sdma firmware!\n");
> > --
> > 2.53.0
> >
