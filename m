Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12330C5AD49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 13:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B43510E600;
	Wed, 28 May 2025 13:43:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fGKn418L";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06CF410E600
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 13:43:20 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-234a45e69c8so2238095ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 06:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748439800; x=1749044600; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SrZPPvl784zq7hTxC667x184vyAxWb/26ipoRaWYJw0=;
 b=fGKn418LEBfNlkU24j1cucYsdSqqcgFkOmpaXP7uCTk92WeTn2qFhS9Q4yAfeCs19I
 x065+sLl2JArlFDnWgsnhdLjYiylgaOPaQnDuGDka47DevjnxYQyA0W0K0rn721k7M2e
 MVqRAgbE33A7lP1owX+Q7uuuBpoIk/3RqGSjAAmALOHTYj6mDYtdTHM28oMnaWdNuvGK
 SV9cWjpaHgSnsktG61S2h2qRBdSPTPUtn6bAAeQh3c5v7RkWM7dLHhQhp9C8/kL0eRvf
 G6egx4bSGpdaB5XbdSwm0AV27NpIrnfVGHtzp+QFetAwI1Rzjq2d7K/j6O3YnLipRalc
 wZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748439800; x=1749044600;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SrZPPvl784zq7hTxC667x184vyAxWb/26ipoRaWYJw0=;
 b=cXC3QsGJtJ1k5ez/r0nrOmxIbW4utgGepsKUh1pdDedrs7u5TPUfSn7RyFdaVt7TCi
 z6r91tlchPRN0g85nhg3PEV5Yg9WUgWvC8H1z4PzzPIsVz7j0F/1zv/M5EtugWaURfEe
 iHtJSTnnFVdhpsLnjOjw7GSiaUzzuDHZ33ON0D2JelyGoPcGCJIdz++Xi931lgnbkJ8V
 oQuqr1WKr0gW0LHGbb/QpMVqJUvpt7FgCA69CyyXxpaYsTXCE1ent4AqmewKEkHSMyOW
 NTNfhW8KrKJOHJ3nkmC+WMxAMbo8nq55Sxt7mZojm1DQ/NIH71jbsfzXRQoPTPvr9bGk
 Of8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8JYOQtv7v6UbDSXTTw9anW1wfr5G5U58kBXuXJ33dbXO+Tc3OvduwWbqITWwzUIqCnN5Tfiwq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwlKlpg3A1TJdZ4ILbF8tLe16C5NkJkiYur4HPrTxhSvaRaBJN5
 1PBj1ZM6JxKhte45KZO2DqEdhldapq+5JSQ3KvXcBqNYZPqGX4RiXpZjbH5wY4D99C7/f1gzun3
 G3oAz2N5gKKC2P3mu9TvUoG8w3YLSHMQ=
X-Gm-Gg: ASbGncvT4uq+RTov66PX1NP8K+5jldcaDtddGUFv8L3xAjoY8ks7/8rgsI8M3p3bK46
 MBtdaUTDqwEQvXQnTQj2ib3pOjr5xrGsQeNuagG6mW0GkcUrNjTVXdR2IiAR4ozXPoDDAfeEdvx
 GoLmvNF7xVnINJYELDlbxjZq29zd+rHcAvv777v0gHpjDT
X-Google-Smtp-Source: AGHT+IGzWEh5qLCfod/rTvV5TZ8jZDuUB1orhdBCcJBAghY2K/QY40s21BcsfQW8w1v5MHntAMjqaQYCp3G/9wsw5KE=
X-Received: by 2002:a17:903:2301:b0:233:fbbf:f8b3 with SMTP id
 d9443c01a7336-234cc160b07mr16156175ad.14.1748439800149; Wed, 28 May 2025
 06:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250528041914.5844-1-alexander.deucher@amd.com>
 <20250528041914.5844-16-alexander.deucher@amd.com>
 <63ba4500-bba6-4ea6-9759-3ef2a599d69f@amd.com>
In-Reply-To: <63ba4500-bba6-4ea6-9759-3ef2a599d69f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 May 2025 09:43:08 -0400
X-Gm-Features: AX0GCFtZ-lTDm3PvHkI02TlbF33qln4TxYdRJ2oVdfOKGeyq5zmIl7o6xF8XqXk
Message-ID: <CADnq5_NSWTx0q0Vvf5H-aZAt0zj+L4NfppCisnb+t0SWnSHyZg@mail.gmail.com>
Subject: Re: [PATCH 15/19] drm/amdgpu/gfx9: re-emit unprocessed state on kcq
 reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, May 28, 2025 at 7:50=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/28/25 06:19, Alex Deucher wrote:
> > Re-emit the unprocessed state after resetting the queue.
>
> I don't think we want any of this for compute queues.

Why not?  This allows us to do per job resets and can be trivially
extended to all engines.

Alex

>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_0.c
> > index d50e125fd3e0d..75681075f1fc8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -7216,13 +7216,22 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_rin=
g *ring,
> >       }
> >       kiq->pmf->kiq_map_queues(kiq_ring, ring);
> >       amdgpu_ring_commit(kiq_ring);
> > -     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> >       r =3D amdgpu_ring_test_ring(kiq_ring);
> > +     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> >       if (r) {
> >               DRM_ERROR("fail to remap queue\n");
> >               return r;
> >       }
> > -     return amdgpu_ring_test_ring(ring);
> > +
> > +     if (amdgpu_ring_alloc(ring, 8 + ring->ring_backup_entries_to_copy=
))
> > +             return -ENOMEM;
> > +     amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> > +                            ring->ring_backup_seq, 0);
> > +     for (i =3D 0; i < ring->ring_backup_entries_to_copy; i++)
> > +             amdgpu_ring_write(ring, ring->ring_backup[i]);
> > +     amdgpu_ring_commit(ring);
> > +
> > +     return gfx_v9_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
> >  }
> >
> >  static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct d=
rm_printer *p)
>
