Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEFDC5AD49
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 14:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A649710E2C2;
	Mon,  2 Jun 2025 14:36:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nl+kPXda";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13E9510E2C2
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 14:36:58 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b2ef619e80eso106251a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Jun 2025 07:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748875017; x=1749479817; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TwLLxOtyzwNRCD7WJ1tcg2VyQGX+XuPuOo1oWYARZ4s=;
 b=nl+kPXdawURtHNl2tgT9U5Lsf4zPKvZZwcfzq8dznBIuEhoGPzSVfr0G7Pu+nyzONR
 xJeub3vgita0UUK1F+rd8LthGtGiVBRNbQYhl4colAGKli6SyKoJRg540XsiXvl4jBxg
 KAFCNXsc3+pTPbuCcTs0vEgW9kEPmu+HC/TwDl1Xa2EfSlg4NALCpr82a8g1PyeJQzrL
 tBjfLn+qTblHbynvzUMtJ4BJuR70SXRihxSd8g9CUfWbO/idl8P8BA13+loeGFNZntfO
 nYdCutOgIoWp8HVvBXT3Q5b2OIv7q6CRPJijqPIjVFCLu0l3y2cGifcSXPq4DdhylMav
 XHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748875017; x=1749479817;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TwLLxOtyzwNRCD7WJ1tcg2VyQGX+XuPuOo1oWYARZ4s=;
 b=VGBeMk6Gwfn0U0+OynJ+HARYRfeL1TVCwKLsLcH5qvYLeFtO6oT+r6BvqNC9ewPI/j
 X/HuXjLVbgBF+vK78/VhH8Ea/g5mba8KzV19pRt/L2JY5kynarnnQbLIJbGZry5g8C3e
 9PPScJFjdNuxY4JYExvJ8kxZzYDGGgPOl3x6W43siuoMo/EsGlMThhnFNBDBgvc68/c5
 cf6zQs0AsUG5X9BtAtT9pWnpMmpNfqg19nJbIfE0rDFYL1KLBe2sxqUYUULc3OHsXpBj
 PmOiJC1ctMQpLVRLPSaaUxTB0hlA0YEZIr89EGrLL35v5Y6xsATiA1ROHwxVVB7xhHKk
 tWlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm76Nnu1VtCxFU+UfJqOYv7T04bnAhQGoExSa3hIr2RRAjVazGt8zd9yh1lJ0HiKPBf2FblOxE@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw91evQ5zPVNVNk3434Yn7Ttzbp4geZOUAYw+23xz5lA5j9Yacr
 ZfMfuMzu3Jo2rPyxIN2BWM0v4pGk58l4OWgvSQQw+2OcmA6S+30Aau5hdYe6fq/TFK+oESiEszF
 FXbzd/KDug5des5X2Frh5F1bCDZfaMns=
X-Gm-Gg: ASbGncttru5pJQalZBgklpmDxrKREK5eacJDJavKjVe4Oez62SfwEO22AMYd1M70slH
 EZSDN+uvNT/l333FFs61oW6up4vOTHO/px5J7BPQR0geNbrh+reJis1OCimZZAMIEDY9cDIREY2
 58Z9v3qMK6G0ab3AoWE2dN81ct82AqNp5tE48LeemeZWIO
X-Google-Smtp-Source: AGHT+IGq9yLkAPA+OMP0AO/eJhMFgsV9iFf3/17X4ZzKr9HaKOop2pdBsVw5FJ6XehVpRcOhpkegb0wQqWsrc6TVzxQ=
X-Received: by 2002:a17:90b:5828:b0:311:a314:c2c9 with SMTP id
 98e67ed59e1d1-31240940d9cmr7837825a91.1.1748875017268; Mon, 02 Jun 2025
 07:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250529200758.6326-1-alexander.deucher@amd.com>
 <20250529200758.6326-3-alexander.deucher@amd.com>
 <bacfb6ea-68bc-4581-a08c-c3019b558ce3@amd.com>
In-Reply-To: <bacfb6ea-68bc-4581-a08c-c3019b558ce3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Jun 2025 10:36:45 -0400
X-Gm-Features: AX0GCFvKa2bkmABEwVPZBuVixust2MFfbfi39VsDWsZ94DrN4GKg_7vcU4mhqxY
Message-ID: <CADnq5_N=oiyooXUCnCxaOM9Q57+tN+uWerDrpLkjpZmaVefU+Q@mail.gmail.com>
Subject: Re: [PATCH 02/28] drm/amdgpu/gfx7: drop reset_kgq
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

On Mon, Jun 2, 2025 at 8:57=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 5/29/25 22:07, Alex Deucher wrote:
> > It doesn't work reliably and we have soft recover and
> > full adapter reset so drop this.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> I was really hoping that this would be more reliable than soft recovery a=
t some point. And from my testing on gfx9 it seems to work rather reliable.
>
> Are you sure we should just drop that?

I couldn't get it to work reliably at all on any of the gfx8 or 9
hardware I tried.  We can always revert the patches if anyone wants to
work on it again.

Alex

>
> Regards,
> Christian.
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 71 ---------------------------
> >  1 file changed, 71 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v7_0.c
> > index da0534ff1271a..2aa323dab34e3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > @@ -4884,76 +4884,6 @@ static void gfx_v7_0_emit_mem_sync_compute(struc=
t amdgpu_ring *ring)
> >       amdgpu_ring_write(ring, 0x0000000A);    /* poll interval */
> >  }
> >
> > -static void gfx_v7_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_se=
l,
> > -                               int mem_space, int opt, uint32_t addr0,
> > -                               uint32_t addr1, uint32_t ref, uint32_t =
mask,
> > -                               uint32_t inv)
> > -{
> > -     amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
> > -     amdgpu_ring_write(ring,
> > -                       /* memory (1) or register (0) */
> > -                       (WAIT_REG_MEM_MEM_SPACE(mem_space) |
> > -                        WAIT_REG_MEM_OPERATION(opt) | /* wait */
> > -                        WAIT_REG_MEM_FUNCTION(3) |  /* equal */
> > -                        WAIT_REG_MEM_ENGINE(eng_sel)));
> > -
> > -     if (mem_space)
> > -             BUG_ON(addr0 & 0x3); /* Dword align */
> > -     amdgpu_ring_write(ring, addr0);
> > -     amdgpu_ring_write(ring, addr1);
> > -     amdgpu_ring_write(ring, ref);
> > -     amdgpu_ring_write(ring, mask);
> > -     amdgpu_ring_write(ring, inv); /* poll interval */
> > -}
> > -
> > -static void gfx_v7_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint=
32_t reg,
> > -                                     uint32_t val, uint32_t mask)
> > -{
> > -     gfx_v7_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
> > -}
> > -
> > -static int gfx_v7_0_reset_kgq(struct amdgpu_ring *ring, unsigned int v=
mid)
> > -{
> > -     struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> > -     struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> > -     unsigned long flags;
> > -     u32 tmp;
> > -     int r;
> > -
> > -     if (amdgpu_sriov_vf(adev))
> > -             return -EINVAL;
> > -
> > -     if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> > -             return -EINVAL;
> > -
> > -     spin_lock_irqsave(&kiq->ring_lock, flags);
> > -
> > -     if (amdgpu_ring_alloc(kiq_ring, 5)) {
> > -             spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > -             return -ENOMEM;
> > -     }
> > -
> > -     tmp =3D REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid)=
;
> > -     gfx_v7_0_ring_emit_wreg(kiq_ring, mmCP_VMID_RESET, tmp);
> > -     amdgpu_ring_commit(kiq_ring);
> > -
> > -     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > -
> > -     r =3D amdgpu_ring_test_ring(kiq_ring);
> > -     if (r)
> > -             return r;
> > -
> > -     if (amdgpu_ring_alloc(ring, 7 + 12 + 5))
> > -             return -ENOMEM;
> > -     gfx_v7_0_ring_emit_fence_gfx(ring, ring->fence_drv.gpu_addr,
> > -                                  ring->fence_drv.sync_seq, AMDGPU_FEN=
CE_FLAG_EXEC);
> > -     gfx_v7_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
> > -     gfx_v7_0_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
> > -
> > -     return amdgpu_ring_test_ring(ring);
> > -}
> > -
> >  static const struct amd_ip_funcs gfx_v7_0_ip_funcs =3D {
> >       .name =3D "gfx_v7_0",
> >       .early_init =3D gfx_v7_0_early_init,
> > @@ -5003,7 +4933,6 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ri=
ng_funcs_gfx =3D {
> >       .emit_wreg =3D gfx_v7_0_ring_emit_wreg,
> >       .soft_recovery =3D gfx_v7_0_ring_soft_recovery,
> >       .emit_mem_sync =3D gfx_v7_0_emit_mem_sync,
> > -     .reset =3D gfx_v7_0_reset_kgq,
> >  };
> >
> >  static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute =3D =
{
>
