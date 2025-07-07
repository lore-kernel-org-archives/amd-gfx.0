Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AE5C83F07
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 13:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B67AB10E4A2;
	Mon,  7 Jul 2025 13:58:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iyxA4BfD";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9982E895B9
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 13:58:42 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-313bcf6e565so702461a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Jul 2025 06:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751896722; x=1752501522; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v8d5cTHk11Tuk38oLtZNbclUrv9SLFVJ2BnRwwlZQv0=;
 b=iyxA4BfD1dwMno5m+QIALRPPPGBI5XaGHuCrl8h4TvLjnwU8FakPkqbWjUomUaUh2E
 jJ3OfdyUqc7ihT2XRBDFnUavvMWnzKa2ni+uT4rLEOxARmIHZolqE0IcmLNMC9WtdwFF
 egMPjhQJUgKUcELBakBf0PEQxD9prJsiRcG50h9OT5oPSJsxFp8Hy3pWq4LN4ZpxZ8F0
 mhMEzvHcuFtFvPJReIccILPvtQ2o/AxHM5tlOLiTjK+f4q4F3VPFjPVE+D7W/pKW4zyd
 7Y3QGJFwkIv8kqbJxnll/uOLm1hSdfyEV/ebctq+YIBkJqTmR93ukvPAJ42zPM6ehGl1
 N3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751896722; x=1752501522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v8d5cTHk11Tuk38oLtZNbclUrv9SLFVJ2BnRwwlZQv0=;
 b=F1lftkmHl0/qquBTBR0K8LudlEXNnfkJFxwyg3k/kvTpX/FHnrfh+OarxvigOnFSTi
 jmxo9GxBCKyf6wPbR3AcF7midHmlPppwmFTQmyFcbaERBiX5VH/pd7z/w4WE/AL67W0a
 3RefxerUvRwy1nTyd0woX4zJ9RTKT4X2/4C55upPWJbtG78hTh2zXGBqEcEFeKwYg3jG
 UkVPr9A8x0XLGP6Grk1cttxO+U2/i3Vwf1J2fB5Q0SSBhjW7hC56UleEzSmS2qZVSqLj
 h4w8Z0xdvlM323cKG7xh6L+ky5hrz1UP54+MUza8aEUnYuNNfokKIPRtfh9BMNYT7sve
 wySw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5EVLYTU3RdNHpCC/rOREnkxFHL/Q0IL6M3Tmy4M/UeAOntjKqnMECplJDs8pyvKU6Woqt7E2f@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJ8gG/e1C/xSpNqik2XN+PKiGZrxR4wQMVVcDzn71jpIcZ1IdF
 v9PRXMZrMeuOyhRKvNAeaV9tr6+VvEsC/N/4du93RrB70CYbqOTz/rYD0zYp0iWbzxLg6NTBMbE
 9t+TWwicHALtUJn5v8rtJvKXQNLbXubUMFw==
X-Gm-Gg: ASbGncsOQb+lm4O2mJVqQ0E8xv7FCrmZdKSQB3LQEFBvjlACuoZQPJdksm22mX1Mka9
 /zGHWVyVMeMeltfBDBZHmsf94tDCU2yYxhubmWAyh1rOHUaC+5sjm+XR0M3iPFCEmMlttSVZ908
 5mWURkKBjIwWggQcKgwNxnjItSaNSTur3p7v9Yh7fxo7tR
X-Google-Smtp-Source: AGHT+IFCwNxnTGiRuJbhZPJqrqrCr1BGY3MWbMwLJFUGQS8AE0CRMoGSyb8YDrcuU3uK6VtB0Igix8hAk6N4qb2OenM=
X-Received: by 2002:a17:90b:3fc3:b0:311:a314:c2c9 with SMTP id
 98e67ed59e1d1-31aac44a149mr7603504a91.1.1751896721943; Mon, 07 Jul 2025
 06:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250701184451.11868-1-alexander.deucher@amd.com>
 <20250701184451.11868-5-alexander.deucher@amd.com>
 <32lz64s3r636pphzd4d2o4vbfzzr42rn4gt2m2jvq6qarrimfk@jc6qru354hbi>
In-Reply-To: <32lz64s3r636pphzd4d2o4vbfzzr42rn4gt2m2jvq6qarrimfk@jc6qru354hbi>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Jul 2025 09:58:29 -0400
X-Gm-Features: Ac12FXyth0BYhKiHzvaMT7LgfKYt5Z8PetZYXRMuXV-JWiW6rzIKb3o2iLU8p-g
Message-ID: <CADnq5_Ne9zQtPj9Vvp6f77LCxePp+g2c=MqxtBJ18y7R1FLqTQ@mail.gmail.com>
Subject: Re: [PATCH 04/28] drm/amdgpu/gfx9: re-emit unprocessed state on kcq
 reset
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com, sasundar@amd.com
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

On Sun, Jul 6, 2025 at 10:56=E2=80=AFAM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> On 07/01, Alex Deucher wrote:
> > Re-emit the unprocessed state after resetting the queue.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_0.c
> > index 76ba664efecb3..30f6b04cf82e4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -7187,7 +7187,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring =
*ring,
> >       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> >               return -EINVAL;
> >
> > -     drm_sched_wqueue_stop(&ring->sched);
> > +     amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> >
> >       spin_lock_irqsave(&kiq->ring_lock, flags);
> >
> > @@ -7238,19 +7238,13 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_rin=
g *ring,
> >       }
> >       kiq->pmf->kiq_map_queues(kiq_ring, ring);
> >       amdgpu_ring_commit(kiq_ring);
> > -     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> >       r =3D amdgpu_ring_test_ring(kiq_ring);
> > +     spin_unlock_irqrestore(&kiq->ring_lock, flags);
>
> Is this `spin_unlock_irqrestore` part something that maybe should be in
> another commit?  Maybe one commit that make this change for all of the
> GFXs?

Sure.  I'll split them out as bug fixes.

Alex

>
> Thanks
>
> >       if (r) {
> >               DRM_ERROR("fail to remap queue\n");
> >               return r;
> >       }
> > -
> > -     r =3D amdgpu_ring_test_ring(ring);
> > -     if (r)
> > -             return r;
> > -     amdgpu_fence_driver_force_completion(ring);
> > -     drm_sched_wqueue_start(&ring->sched);
> > -     return 0;
> > +     return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> >  }
> >
> >  static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct d=
rm_printer *p)
> > --
> > 2.50.0
> >
>
> --
> Rodrigo Siqueira
