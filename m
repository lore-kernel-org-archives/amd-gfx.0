Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15406F588C4
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 13:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 735AA10E5C0;
	Mon, 20 Apr 2026 13:02:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tB+tarb7";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44F2F10E032
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 14:51:08 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6634bb959a2so1069937a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 07:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776437467; cv=none;
 d=google.com; s=arc-20240605;
 b=kXC+QpX8SCoJ9rVZ9Gwj0RbYf9N+LKO6fG3LhEYFo/quUdVFhHBPrQMTaEJMhDOH0Z
 Qsk53m0hf1ECbcydc/p1n43lyJkHDxRd6D9Gec7c9pGEGYmDvKs/Ye7YbXxcCOG6fcxT
 wPGYCHy7YRVmFki1QsfdIJO2eqRWbU/80e7KlducMyb0uKanRW4cHnJ+MJ+WTzlBNgRW
 Vm0+1zbFprv8Z40jhJXIO2T/Jhmr6AKtIwnQ4XINRBW1KPhK8F1wugpEDp6oTy0Pq/iR
 90UA+7VVkl2e/vapfibL7fM8QkHKbtXLJ2HV0MmPETmYBHhMLPOEpmm3aYpAh9wyZKSB
 86YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GqspcooKgst7WD1YTyYSebsG6+WnjIGRXNERmo7wEPU=;
 fh=h8bOCy5Zboyj9VHfqNhCkMRxt1YJrf1mvUQ/9FWNKgw=;
 b=hTOKs+EQN8sW1gok3YlLd9bjDRoJEiHqWmQUiDCyByQ/A5lC3mVhXKTFHUh/rx60lX
 UKbh6aDLQDVdY8HfWz1pTzr2UwoizixuUkw4kwxzGFU2TkeJu9qQhN7Ssxr1aGfIxBFq
 aDmJBbcwlltOAMSDzDAL/GjLhWGKDylIxcybthEEO2qFRvdPG1JjrQFXwjgmQi31tcWR
 2iW1tn7A7Jz61TRxFa5VcSghvR+7vO1xdksn6mspzQ8pD7VuT+wjnyvZX1esXnux1/5q
 lrMSl/qHqBS3vVaX1WHw68vz0f9K1o3Veeh+4ZBe7l1RMyUn5x5ASicqnwj0jcSzX+sx
 O1Pw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776437467; x=1777042267; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GqspcooKgst7WD1YTyYSebsG6+WnjIGRXNERmo7wEPU=;
 b=tB+tarb7x7a9ZHzL09LlUJMvki6nFqHVGNwd9p/xSMVmV9LSDygpXaYcsyYSdqTZDQ
 4HBMZReBwUdw+7NAWCtBRJUHsH1GvEupE/F2K1rlbSF06rV2oxLO68dSZ0EOZvs3UJ6w
 6oJeN4avA/6hfYQRwocX80HfRDGS/0Plt1Z7L73ZzxGCGbfN8VFhcALuquEkxCJ7ZeGX
 kBlqo3vk7iEfdDqHpgJ7Hh/7GREILwq+87mxOMYu7t7/0xchu9BsNx0LizGfVeBSFvPG
 n9MLX2ATxtbbq2JS0mt56FRms5mwotjkpKU5cc6Y2rhHT03js/oYJeQrmaL+3FZsfIrC
 A6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776437467; x=1777042267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GqspcooKgst7WD1YTyYSebsG6+WnjIGRXNERmo7wEPU=;
 b=fDXe320B2zqIIOThdSPtOSM81YFevlKtVaKsThaDPBaTihkeHwLMR31uHnYP2RkXFH
 N+x/1DaCvh8RhHILtcwlEPCi+7vdZ6yBUgqQeBGKNEdQpHq1jBKRFtxgXpJHU9ETP1EH
 E0L2Y6ezAye73qy4vuTYaNtDcYzDbK8OrbfGhH0fPBQT+PNWrWzo3GtL+kIohwi0mA3I
 WPo5gCsMH8PKx4+OwIEiy19kSRmHIjKP4kO9NY82hJLz3ZNuAyABHOUI26nKZywYgbN5
 S1q2aabkgvpV1fwzDkoWynIc7WSny/2g6/P0yiMTZyZ4Jnw2ALluJhXoIehz9cN07ZNk
 GNIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/sp/cM3lLklqaR9e/S3NYvexxhPi6I8k6YcUbqi8kV0swLC8Byh1PMjWmM6ktM0XQahrfxff4V@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMtnUcDvb6YNAKcs5A5GFvAFLpIrG0eajJZDnmk+453JtOoaF6
 4cHmqG6/jOBdB+dO6qfw6L2qMwZo2E0pR0dyLP1/Ve6pUBI1LgZz0mc6BDi4apifCfof9sS5NO8
 qU/EQcISNTJEi3ckV5wjEOYs9rS8UnXY=
X-Gm-Gg: AeBDievpYlqdC+deJbtjZELEIpC4mur8mCVXQGV/R0aQr9Lt1cZpjLCwUSOvsOp64IP
 nlRdaQD11lMsSkZTHrKmLTlvplSmznChJfeP6UyK46r9bDyQY5v8AMN53y4eDMZrJtJvK0X1W2T
 r+meC087RbD8mZuRuHo8KcXxGicP1QSriuudlp2myMC0YESQFqITm36cRXRt8y7XnaX+W14VnwH
 kq4x3gTFNO1uZjw22isuj+ircv84S/ttDkqs+fjH2VaPVyZUi9T6VXYdfJBBmCp3/hdI+0AA0AW
 2X1iYAvIzEV9UIeW
X-Received: by 2002:a05:6402:2b99:b0:672:f75:5095 with SMTP id
 4fb4d7f45d1cf-672bfd82182mr1549620a12.4.1776437466608; Fri, 17 Apr 2026
 07:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260416195537.3632-1-dbgh9129@gmail.com>
 <CADnq5_NrVgGwAYbBGgGc9t-ke5xt_0iJNExXARb7LxdnHSwDQA@mail.gmail.com>
In-Reply-To: <CADnq5_NrVgGwAYbBGgGc9t-ke5xt_0iJNExXARb7LxdnHSwDQA@mail.gmail.com>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Fri, 17 Apr 2026 10:50:54 -0400
X-Gm-Features: AQROBzC7i9ei1CiJnYg6HROzf4GBLzx1H6GJ7IgyCxXJkBfyW-5LW2DspgZwtVg
Message-ID: <CACrCO_VKvhA-zx1KPhDxbOR4HzDs87Hsbdtc5SZXgvLeK9ZX=A@mail.gmail.com>
Subject: Re: [PATCH v1] drm/radeon: fix memory leak in radeon_ring_restore()
 on lock failure
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 "Kim, Taegyu" <tmk5904@psu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 20 Apr 2026 13:02:49 +0000
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

Dear Alex,

Thank you for applying the patch.

Best regards,
Yuho Choi

On Fri, 17 Apr 2026 at 10:05, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Applied.  Thanks!
>
> On Fri, Apr 17, 2026 at 3:06=E2=80=AFAM Yuho Choi <dbgh9129@gmail.com> wr=
ote:
> >
> > radeon_ring_restore() takes ownership of the data buffer allocated by
> > radeon_ring_backup(). The caller (radeon_gpu_reset()) only frees it in
> > the non-restore branch; in the restore branch it relies on
> > radeon_ring_restore() to free it.
> >
> > If radeon_ring_lock() fails, the function returned early without callin=
g
> > kvfree(data), leaking the ring backup buffer on every GPU reset that
> > fails at the lock stage. During repeated GPU resets this causes
> > cumulative kernel memory exhaustion.
> >
> > Free data before returning the error.
> >
> > Fixes: 55d7c22192be ("drm/radeon: implement ring saving on reset v4")
> > Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> > ---
> >  drivers/gpu/drm/radeon/radeon_ring.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_ring.c b/drivers/gpu/drm/rad=
eon/radeon_ring.c
> > index 581ae20c46e4b..a5dff072c1ac0 100644
> > --- a/drivers/gpu/drm/radeon/radeon_ring.c
> > +++ b/drivers/gpu/drm/radeon/radeon_ring.c
> > @@ -356,8 +356,10 @@ int radeon_ring_restore(struct radeon_device *rdev=
, struct radeon_ring *ring,
> >
> >         /* restore the saved ring content */
> >         r =3D radeon_ring_lock(rdev, ring, size);
> > -       if (r)
> > +       if (r) {
> > +               kvfree(data);
> >                 return r;
> > +       }
> >
> >         for (i =3D 0; i < size; ++i) {
> >                 radeon_ring_write(ring, data[i]);
> > --
> > 2.50.1 (Apple Git-155)
> >
