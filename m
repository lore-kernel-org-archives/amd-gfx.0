Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0595ACD98CF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 15:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BCE110E520;
	Mon, 15 Jun 2026 15:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DN7NMKFn";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53FB010E4AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 15:42:35 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-304f8e80b7eso272268eec.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 08:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781538154; cv=none;
 d=google.com; s=arc-20240605;
 b=hoAJLEF0TnAqMtM3tm0AJWQJjJ4kOz0c2F4ebPRKG85klBom/G5EwxC6XpRqLvZJkI
 xis6E7bCI6iTCiXXLC1fLqSMIsNEb6cb66NnxHzv3Gj2ib6OKLi1oodEzXU+ye/VlsjE
 dP4ivG0qdvsZs6qzAeDWHcmJ2KfazwdbUZxZYlrPG66w6dgdEQ1poTHQy95KLp6S4qER
 3yulCpy3LNCt3gs4A48KXFcPTHmubO95JQ8IPFLsGxfzVuJIuYJGGPkLBXz81FWJJGJx
 uFu4De9/MWkcJVbK2h3JlHC2YT+bWI71eSFIGr4RoCNYkuh7/lgmlSBgDSl9Xr1JCXOj
 6m1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HB5OTOAis4aNREHBYkXcEkOC2lkh0rrUy7H3L0anj/A=;
 fh=JMovUKso387tvChwt/7uOKEYUMRv9JjMKmD+VuzEEAI=;
 b=A42MoE+KM6ix27pKnZTT+qWWoMMB4JAIhh5DAgMZqXMQzbw/N2CnK8PLVjAQb46Gy6
 Pt4L7YE5UsbhnLU8Rmq2rRa5ICaZfO4RBclMJON4lA+9q7mniEeY/zxhmWc+DUwcAEa8
 MtIhBMj5Zc6KB9Y4AFJIEy14sC24z+JdP2VZEABRd5xCx6BX/bt8unQ6gflfhwX0dqBi
 +7mFHQ2P6BQf1J+6c+en8L+UktktkckEvDyBygI3jaHOnx3CXhrOd+Q7lZHv1yniLfOe
 XhexFeckJ+td1Z4D8/GmihrOHirAOH3GyHqv6yTaSTIAGO64iMdQmRHpz1pCC2fa38ir
 pQ/A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781538154; x=1782142954; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HB5OTOAis4aNREHBYkXcEkOC2lkh0rrUy7H3L0anj/A=;
 b=DN7NMKFnyz+nxGGmjOz1tIdXF3uSbj3NHTINwNlzeJfeKbJ9orusRqvtRiBpjIbDw4
 Grv7OTgUWJtp1aG1U8qED2b1cSJ541Y80AGLahMvV4wcHibqnZL5rZue4uQYAOgadaDK
 lJfA/nkcyF4lW7o/OhBe9D8+EPzoza44TSPRgo6oO/l8m5sARwBBFysIb5KekJrI1NXg
 THSNNvyxK1I3gXTu+hSoimUFzsk66ZIovpHH09A40dFq1KM0S3ieIzOnr4vRhqth1JOc
 vdidoB4/6ic6i3SiwaqZggQUQP+CCFYAd9gXZQzwITwWQjAtjAGM2ov7lctq6M0OeTSN
 JxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781538154; x=1782142954;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HB5OTOAis4aNREHBYkXcEkOC2lkh0rrUy7H3L0anj/A=;
 b=KX0lpwpk+0PsQKcvKg7oACBe+WByqeuEa0lO3V++D4YCmENkZjwjIBofJjrzH1S1hG
 DTSBcj45Wj/urrbRYMoYN2P9Mcicf6lyvapqI+H1whD4QyMJDK2DN9p6+22jDevcgelY
 JCw4GXVO213lPBy+5TQPb/4deXFDpjDyogsVQSdWMJJr6NckZKFizm3NiqF7vTfEpWoW
 VmS84itH/ct0m2/n+kjqDx/z5JP7JK/A6EBl1p4paura09bGfFXlJlLk2bI2kfqyCpTt
 wTAjUK+1Enie8nff1ckEQixSANife8tA1sGDlWCcyR1tn4dK30BOLu+fXvY8BUvZsXcP
 UF/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8L1DZSZ3ACQ50rl79NqgYyZYOo7QG0eGfXS+kqp1k9SjsZIL21aZRlvKtKU+upCvrHQiyyBXXz@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygEXhbJHuSfwMz0UKdQECvafTAiPgviWzNahtH2Z1DIWdg+MvX
 q5ZR0eB3LiDc3x2E0SvuVbGVqnponNgxIRIydN3tHHo6j0W+n0rrBtQLwDkbPPU6PZQLGOxdh4g
 zmxXaJumJmWg5LYW7krX1z3ek9o9fWxY=
X-Gm-Gg: Acq92OHmPUNB5gZwtG1nDVyxywyCJ49u5bDbbRITuG0BFWHJmdPvkYy7mg7uYBWYHnL
 r9Kke/eBXt5FHchsa/5v8wyN4/IaQkiO8vVUlSswD32oXXOdCopCzK3yvpy/PGOQydDYSF1pwjJ
 m2VX2twfGW7VlWJ8WKU4GMVjcGrn2Vj1XlQWtzq3lMJLOQNggxg7vHqJamHA/cJms+Preze7WnS
 jtnH0wzxq2JcakamS/X17D9OfMvQbGgY32FPqW+dQwYXQfUyiT4V0BQ+puYJRFLhR6+ybMRwimL
 kRkTuJfTLO7hp3JZyXUDiIgtRpSJwnbyvqoCi6hBaQ55n+2mn24gRbZRtLtlL28/hVXabMMaUZV
 pn105
X-Received: by 2002:a05:7022:68a0:b0:137:ef27:e297 with SMTP id
 a92af1059eb24-139724e2eaamr2051152c88.3.1781538154433; Mon, 15 Jun 2026
 08:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260610083245.1057241-1-pavel.ondracka@gmail.com>
 <f0041fae-2703-480b-be9a-51a1df964a01@amd.com>
In-Reply-To: <f0041fae-2703-480b-be9a-51a1df964a01@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 11:42:21 -0400
X-Gm-Features: AVVi8CfkqX2jHXjaMSoirH3Cv4qa5toEnvBVc9Ay0ocL4YvWUTf4hiVAjEFqETY
Message-ID: <CADnq5_MxrcO7GX+jGQbkuaF40QipnkxSq_+P1cbDmanO2K05uA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix r100_copy_blit for large BOs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Pavel_Ondra=C4=8Dka?= <pavel.ondracka@gmail.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 alexander.deucher@amd.com, stable@vger.kernel.org
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

Applied.  Thanks!

On Wed, Jun 10, 2026 at 5:24=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 6/10/26 10:32, Pavel Ondra=C4=8Dka wrote:
> >
> > r100_copy_blit() copies BOs as 1024-pixel-wide ARGB8888 blits, so one
> > GPU page becomes one blit row. Large copies are split into chunks of at
> > most 8191 rows.
> >
> > The kernel register header names the packet coordinate dwords SRC_Y_X
> > and DST_Y_X. In the BITBLT_MULTI description in
> > R5xx_Acceleration_v1.5.pdf docs, these correspond to [SRC_X1 | SRC_Y1]
> > and [DST_X1 | DST_Y1], which are signed 13-bit coordinates in the
> > -8192..8191 range. The old code kept SRC/DST_PITCH_OFFSET at the BO bas=
e
> > and used SRC_Y_X/DST_Y_X as the chunk address, so large BO moves could
> > exceed that coordinate range.
> >
> > Compute per-chunk SRC/DST_PITCH_OFFSET bases and emit zero source and
> > destination coordinates. r100_copy_blit() already packs
> > SRC/DST_PITCH_OFFSET as pitch plus base offset, so large chunk addresse=
s
> > belong there rather than in the coordinate fields.
> >
> > This fixes Prison Architect corruption with 4096x4096 mipped textures
> > after they are evicted to GTT under memory pressure on RV530.
>
> Wow, impressive piece of work.
>
> > Closes: https://gitlab.freedesktop.org/mesa/mesa/-/work_items/6716
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Pavel Ondra=C4=8Dka <pavel.ondracka@gmail.com>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Thanks a lot for digging into this,
> Christian.
>
> > ---
> >  drivers/gpu/drm/radeon/r100.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r10=
0.c
> > index 3ac1a79b6f13..533215d6e9cb 100644
> > --- a/drivers/gpu/drm/radeon/r100.c
> > +++ b/drivers/gpu/drm/radeon/r100.c
> > @@ -906,6 +906,7 @@ struct radeon_fence *r100_copy_blit(struct radeon_d=
evice *rdev,
> >  {
> >         struct radeon_ring *ring =3D &rdev->ring[RADEON_RING_TYPE_GFX_I=
NDEX];
> >         struct radeon_fence *fence;
> > +       uint64_t cur_src_offset, cur_dst_offset;
> >         uint32_t cur_pages;
> >         uint32_t stride_bytes =3D RADEON_GPU_PAGE_SIZE;
> >         uint32_t pitch;
> > @@ -934,6 +935,10 @@ struct radeon_fence *r100_copy_blit(struct radeon_=
device *rdev,
> >                         cur_pages =3D 8191;
> >                 }
> >                 num_gpu_pages -=3D cur_pages;
> > +               cur_src_offset =3D src_offset +
> > +                       (uint64_t)num_gpu_pages * RADEON_GPU_PAGE_SIZE;
> > +               cur_dst_offset =3D dst_offset +
> > +                       (uint64_t)num_gpu_pages * RADEON_GPU_PAGE_SIZE;
> >
> >                 /* pages are in Y direction - height
> >                    page width in X direction - width */
> > @@ -950,13 +955,13 @@ struct radeon_fence *r100_copy_blit(struct radeon=
_device *rdev,
> >                                   RADEON_DP_SRC_SOURCE_MEMORY |
> >                                   RADEON_GMC_CLR_CMP_CNTL_DIS |
> >                                   RADEON_GMC_WR_MSK_DIS);
> > -               radeon_ring_write(ring, (pitch << 22) | (src_offset >> =
10));
> > -               radeon_ring_write(ring, (pitch << 22) | (dst_offset >> =
10));
> > +               radeon_ring_write(ring, (pitch << 22) | (cur_src_offset=
 >> 10));
> > +               radeon_ring_write(ring, (pitch << 22) | (cur_dst_offset=
 >> 10));
> >                 radeon_ring_write(ring, (0x1fff) | (0x1fff << 16));
> >                 radeon_ring_write(ring, 0);
> >                 radeon_ring_write(ring, (0x1fff) | (0x1fff << 16));
> > -               radeon_ring_write(ring, num_gpu_pages);
> > -               radeon_ring_write(ring, num_gpu_pages);
> > +               radeon_ring_write(ring, 0);
> > +               radeon_ring_write(ring, 0);
> >                 radeon_ring_write(ring, cur_pages | (stride_pixels << 1=
6));
> >         }
> >         radeon_ring_write(ring, PACKET0(RADEON_DSTCACHE_CTLSTAT, 0));
> > --
> > 2.52.0
> >
>
