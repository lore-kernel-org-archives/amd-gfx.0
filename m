Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2FDC83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 14:13:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C56AF10E216;
	Tue, 15 Jul 2025 14:13:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MBVRRZIG";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B26610E216
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 14:13:54 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2355360ea88so7223915ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 07:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752588833; x=1753193633; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2WNQAQcX6mibVABTvaEgdUj3y7Qz8xATmJGhnzjUPz0=;
 b=MBVRRZIG1QisrjTkn4KdrZHyY/asWY4BkcvLKYsKVgPqxtXfs60wmXeZqzpfNzihAK
 fhXndSBeI/t9n0ETeMknDXSHpLDitsxbGoBGrWQY+QHo/S1BfqAa19K9dNGRnrruGvbo
 ZZggmQL9wA/qplp2vjB144V0bIdjSmsWNOysDank9DydSRWNSa5iAKNq+qZTM9RYlB5t
 XpJ1cemUazen+PKpTNFCZ9tclbXB6+kIAkRnNbXkrN5r7z5+OsU8h3GTrFWpbyELcR5F
 COh17RRSyZk2wyPEDyEE6ysM+4WZQ/i5DpcMFMQrAVeGmKMR4JuiB0yeAfdVz7Lrrh9Q
 dN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752588833; x=1753193633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2WNQAQcX6mibVABTvaEgdUj3y7Qz8xATmJGhnzjUPz0=;
 b=VzdVVd3PPU4pdrxH7v0NRoEAzjn0IE2IUMsmzgGvmJfQtdJfd36nroBRKMyIPghgIo
 ukCA9bh+0Lx8d3T2j0rXj9YC0CNtEtwnrWi0z9q2InXQm1R26bptH2cMpXJRmXp2H0tF
 bWDnVQKpJNsYp04454tpwQ3Bqj+ZKipWPCwJw816IKYZ2r2emdXlHhXZjZ9Ip+NoEmue
 L697MplOwceGYT6Uw4ba+KkS1031r/BVzh41EUcqWhiMoQc2AN+4nLWUTz6pmSHzzX60
 Ey06mtvQMNpA/QGHUzS4i3E1eicokcKSffgq/dqhmZxXUtO8ZDgAb+w0KGfhf6640TO4
 Kb8g==
X-Gm-Message-State: AOJu0Yyq5derHFS9Ts/nXP3JJvtTmuQ1S4umnTqvJuZFJlrB0Jrxj/+V
 w+qfyCENUW4vEn31vVjCNdps/qA36ZTw931v/drdUOFVElOxTSPMT2uSPnDxV4+cvSRKN73XW1Y
 3YHQZroIqIRg5EOQPkWPj7RYo0J7h7T8=
X-Gm-Gg: ASbGncv1jpyiPHOAxzQAaTATD3u/BURyKz3nLsuVPG6WRWx1Svp5CYzgvTNeDdCO9Es
 xJ37FbvHjfwlgIv0rbXiKc95PEkRsemerSjSUx7weGW1NqrkAZO/D8js3IN00nRb7PebZ2pxtkj
 xC2TBYSImKXM9af89ER6mUCaB4nuG9JUu+9X8eUNB5h96rPFRG21cznifPiskWcDKFMUX16JpEN
 lGflLtc
X-Google-Smtp-Source: AGHT+IFN7fdmQMbli5wJcOCpuNY21whSSZmwH2yL3AIE1I6WXN1B8WvGF4GTpm30iDsPhn6+EhpxBY311WGGrPgSKxM=
X-Received: by 2002:a17:903:230e:b0:236:71f1:d347 with SMTP id
 d9443c01a7336-23e1e980a72mr14851185ad.10.1752588833320; Tue, 15 Jul 2025
 07:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250714052218.1523140-1-lijo.lazar@amd.com>
 <bfbc0f0b-22f2-46c0-83f0-91a199ec1a5a@amd.com>
In-Reply-To: <bfbc0f0b-22f2-46c0-83f0-91a199ec1a5a@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Jul 2025 10:13:41 -0400
X-Gm-Features: Ac12FXzSBKR3Y17SaErRDPyxyOautEw14kXhStldpwQJrKaZBO81onmawbK9eM4
Message-ID: <CADnq5_Pmd+MtEVhoFkAV7+fEz24QVTnhZgr-Ro4n8BNgjaAH3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Increase reset counter only on success
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com
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

On Tue, Jul 15, 2025 at 5:49=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
> <ping>
>
> On 7/14/2025 10:52 AM, Lijo Lazar wrote:
> > Increment the reset counter only if soft recovery succeeded. This is
> > consistent with a ring hard reset behaviour where counter gets
> > incremented only if hard reset succeeded.
> >
> > Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.c
> > index 426834806fbf..6ac0ce361a2d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > @@ -427,6 +427,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *=
ring, unsigned int vmid,
> >  {
> >       unsigned long flags;
> >       ktime_t deadline;
> > +     bool ret;
> >
> >       if (unlikely(ring->adev->debug_disable_soft_recovery))
> >               return false;
> > @@ -441,12 +442,16 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring=
 *ring, unsigned int vmid,
> >               dma_fence_set_error(fence, -ENODATA);
> >       spin_unlock_irqrestore(fence->lock, flags);
> >
> > -     atomic_inc(&ring->adev->gpu_reset_counter);
> >       while (!dma_fence_is_signaled(fence) &&
> >              ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
> >               ring->funcs->soft_recovery(ring, vmid);
> >
> > -     return dma_fence_is_signaled(fence);
> > +     ret =3D dma_fence_is_signaled(fence);
> > +     /* increment the counter only if soft reset worked */
> > +     if (ret)
> > +             atomic_inc(&ring->adev->gpu_reset_counter);
> > +
> > +     return ret;
> >  }
> >
> >  /*
>
