Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BFEC53200
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 14:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EFFC10EC45;
	Wed, 29 Jul 2026 14:02:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JEUhCpqg";
	dkim-atps=neutral
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24F5710EC45
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 14:01:59 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-4a453848173so31024b6e.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 07:01:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785333718; cv=none;
 d=google.com; s=arc-20260327;
 b=mWgTKAkmosc81CEPUnFgGjwiIP8+zD2mCMxhFrF7QTCN+I96eZ9WElPTZ+4QqFicbY
 xd31Ym0QXju2fmZuFzCYYbX+Q3Xd3KvfV4iMms5tfMrDqHkEVKqjrOHOqrpyLIkNXZDY
 /MkNJXDM/XYCsOBp/SwkIT07/jWjqjynemGXCPexUEj4CgQ8V1uOuIE4ZvIkf5n39+xE
 bdVrCwtdG6dCe9JS1nvco/RRttp5gOg12P6Xt1ssA5L3oPIMe5eHriI/Rfrby/VaECYM
 IJ0h5cvfpsJaK0nwfDrn40Ky1uyvaxjgJJeTPhnUyaCc5PlmVUfLkmF/XTw3zC5nlXwU
 ANLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zI4CONeLAqVV0cC30nGZPveCd3tYM+ZX1deEevEnvbc=;
 fh=pVXkSRI4iWxMX2nwzh6GHNF3uSMfA8RBUzqfkxIWt8U=;
 b=Cqhf7t5m4hePFhESCdxuYGefyI1vVLWK0i9zzyG3zmvR9Be6LzP58hkU3SxqYGgSHu
 DHzSBdcz7x0Zz7H2eL8FEuuRe20KsErJwmE/ZicLdbV4lxcAsHWQd7C3xdZRtrax009D
 P1Ohu3TG6e1xQr1jh0t1MliOt4mkLDHLldmOM0drBvjU6ejAxhQtA77lOon2mHs4co37
 k8EgpxrjerA4nXOujctnoKBgajP9XAsygHTe/12pB5oK3OHbF0FM6zo5/7mDziwDkRhm
 oTaZUzGbS4LQUq2JOA6gxpGEwgcKmtljTmgVx4zZwKkbhyKl48Ky7tzFlBXZOACzyt+j
 fh9A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785333718; x=1785938518; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zI4CONeLAqVV0cC30nGZPveCd3tYM+ZX1deEevEnvbc=;
 b=JEUhCpqgpc6tQZPNs7D5le9D5QBHxLCXEH8LeuzXGRG4azZ1GxHooQ5eBBvba/Eqou
 ZX753QQR5NS/tMxnVPkNxJgnJJ0AerEl0UuHGRVEH79bNG680XJfsntXluJBYpSEQgqC
 2P6rIJE4Lirm6k6ZgPEux2BZmes0NkD/TsDap1b+i8jIvYAd3z7t55HmXOmiekw6Jsrl
 xyohQ1tO9AJy6ndAjWK4aTS6siAODP5pnly3+n77G9zpLgNsPSnncDgaZsEEcph+oYmO
 nKZcP58Yv99OQcFT+WFJhaKMw37+vF7MBcYn4pZORkIph2GZwoouo+PiEghVN5DBhefZ
 a0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785333718; x=1785938518;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zI4CONeLAqVV0cC30nGZPveCd3tYM+ZX1deEevEnvbc=;
 b=NlRoTLrtPJ9CXYOYfhdxRgRIQ6MSQTxVrNjrLFqNBSJ4wDhpiB1kotfyjQQnDbu9cK
 CtmhjHY1NK4g19JTQwmJO6B+uywiPQPiDHX5UiGRiX1+uvJoy63xoQVw1fv8je3ML5xW
 D1uLPiKXyuljVVKRYxeQ0RBitL0DNytor6ac6xVxzBbitjMTx/dNjB6Q2LZjMx9p+6k3
 qajeoXUvpOCPLsqsLHLOrRjTMp1t4zKgZ9uFSMnyaz6bMPuKFOu/qvdKrifEyXOLk65b
 3nuny8yWCcHeDGGTq56BRmiQWqgTgPKeCQgYryYk0Cj7lK/ruuSlIxvK4aqv6ssECLQH
 8WXQ==
X-Gm-Message-State: AOJu0Yw5+C4Sw28kfwtfqKVtGjyIo0NA5ST3iMv+k0tBtNz3XvA4CVeJ
 ySHa8C3IiTXOd4MYOs9Htwt5JpDaoRhFzhkhiLQ3UOUqS4m+s50+jrYRPNUjBduNKYEZG68IGmA
 IFQ4pQPr759ndqHNOdp3PdE4SgkTDv50=
X-Gm-Gg: AR+sD11lyQEnlCOj1pvgujWlFYlIenMM090DbZFpUnzrYSflceuXoBblFcazJTiVq7Z
 S/NjbzS2AwT4dTZlo6tfKPEW5ioeQV0Ux/vnQaziI3iNi8kP5o/Y/ci8WkZC45QJUX9ps9SmPWF
 ggEfHiY8vliAlXHGG0IdWxP1drm+Yq70dFLWj8aEdI6A1dXtNLia8aGHU/B60QLumQf/RTRYPBl
 NJyniiCobWAac87Ah5OgzAzrsil4FHU0jkFG96HqjAP+FjtFJ+kbFMZdDvrTgX8Yi/H/QaHxTj6
 b0AOuYkw0yNqL4kIlmKUeqhscVg8EnqHLO65j2F4jxCFOKnwS9XGZ6YNlQ9XtYYg
X-Received: by 2002:a05:6808:30a8:b0:4a4:866:c2c0 with SMTP id
 5614622812f47-4ad5bc0c5acmr3830826b6e.4.1785333717971; Wed, 29 Jul 2026
 07:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260729085838.1338931-1-Jesse.Zhang@amd.com>
 <20260729085838.1338931-3-Jesse.Zhang@amd.com>
In-Reply-To: <20260729085838.1338931-3-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Jul 2026 10:01:46 -0400
X-Gm-Features: AUfX_mzy98y83GTj_48oRSGLPA9U5MxzKi6uWj_r7sy76hG35vcXb60QHz3ykWM
Message-ID: <CADnq5_O_KqeS=Uh9LdER2Esv6OeWHXM2GT0=-nOKG5U-v-n5Yw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: fix JPEG v5.3.0 queue reset failure in
 DPG mode
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jul 29, 2026 at 5:08=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> Like jpeg_v5_0_0, in DPG mode the ring reset path only clears the
> JPEG_PG_MODE bit and never resets a hung JRBC, so the post-reset ring tes=
t
> times out and the driver falls back to a full MODE1 reset.
>
> Temporarily force the static power-gating path during the reset so the
> stop/start sequence power-cycles the JPEG block (JMI soft reset + power
> off/on), matching the jpeg_v4_0 reset.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_3_0.c
> index 68152b2ce015..c929d6f83bac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> @@ -637,15 +637,28 @@ static int jpeg_v5_3_0_ring_reset(struct amdgpu_rin=
g *ring,
>                                   unsigned int vmid,
>                                   struct amdgpu_fence *timedout_fence)
>  {
> +       struct amdgpu_device *adev =3D ring->adev;
> +       u32 pg_flags =3D adev->pg_flags;
>         int r;
>
>         amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> -       r =3D jpeg_v5_3_0_stop(ring->adev);
> -       if (r)
> -               return r;
> -       r =3D jpeg_v5_3_0_start(ring->adev);
> +
> +       /*
> +        * The DPG stop path only clears the JPEG_PG_MODE bit and never r=
esets a
> +        * hung JRBC, so the post-reset ring test times out and the drive=
r falls
> +        * back to a full MODE1 reset. Temporarily force the static power=
-gating
> +        * path so the stop/start sequence actually power-cycles the JPEG=
 block
> +        * (JMI soft reset + static power off/on), matching the working j=
peg_v4_0
> +        * reset.
> +        */
> +       adev->pg_flags &=3D ~AMD_PG_SUPPORT_JPEG_DPG;
> +       r =3D jpeg_v5_3_0_stop(adev);
> +       if (!r)
> +               r =3D jpeg_v5_3_0_start(adev);
> +       adev->pg_flags =3D pg_flags;
>         if (r)
>                 return r;
> +
>         return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>  }
>
> --
> 2.49.0
>
