Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61136C43602
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 13:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDAA888784;
	Tue,  7 Jul 2026 13:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MHw8Nhg3";
	dkim-atps=neutral
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A41C688784
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 13:23:16 +0000 (UTC)
Received: by mail-ua1-f47.google.com with SMTP id
 a1e0cc1a2514c-96942d43d65so98151241.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2026 06:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783430595; cv=none;
 d=google.com; s=arc-20260327;
 b=J+28VYDj6ZKsPekgVF6NOJ6TGn/i8p07BmNaKhOGz72IL2uJYnX6lurFXjxjWYnESR
 3MjIc1g/P0/nknjoRGlSTtMwzoqNKZDpI1+5NQNxVfy1fX49kwYxw2VySmet74vji0V5
 nQJfgcYGoY+itb2tSL8NzWUrVOtevpGksoNnLuf8uMH4su1Y6s+5sy8IbPRYcXL+326y
 uRNvinQphKKpCdrtRdXp3oj8YzWJ+V6q6IopEvrdFqbCFJYy/FsukG3jamQuLy3CMMkn
 AyL+UilSoj7Psncsy7GKpNVN23eRLDGCDT6V8nbCU/DztbUgL3cl3+VHWmSdS8+e0+4Q
 d0Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zsRbd2iXQS4Pv9VQ95qVDWTuZqDNYcSM1NPff7gLUVQ=;
 fh=qsxv4CT9Glly1JpmFCnYUVR+2SiI27sX2Y2K4GsxsPc=;
 b=PRlK4rDBV87cSPZbyifz30i0wvromEacJ40br/e9ZHcYAy7n+1AZyB+E3gVUzttpDQ
 +Sc+W6PZwPJBxP5PgFZR2Yplq4kz35DxSLhxQvSKQ1tXC9JGC9OtV4Zf3JMLDFDjbr1E
 WLyy2059v/b/pNJTW19JCANu91IjJ03m2OVRYoqnpYBlsDlnsBgEiu0YYjG2yOWe2x4U
 vFF6ZKHFtiF5YZJOEOp5/lS6f/05lYgS4x7ruX+38whS20FiINCQ7uV/mbhOhEQDGrdS
 +nEZzq4sDPoA/lbfBsrnSQE396p6DbenhJkjugQ92dmrHnjZYoqEAnLfY9YrBoQwG9/7
 srAQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783430595; x=1784035395; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zsRbd2iXQS4Pv9VQ95qVDWTuZqDNYcSM1NPff7gLUVQ=;
 b=MHw8Nhg3xWAIw2j1Irci47rMLoBbpR5/db1W1MGJ1KWZmBeAn6B1ueqOp8xH3f/0In
 ev9j9/o1eq3/8yvjaPTlSHGR52NkIwc1ZgLEzHXjZFxdsQ4ePEAmdgFcSUZ4eBHKLXBJ
 oei4wktKspFPvof+Wn3Fk7mJcXQRj7dS9iUN05z6n1kvSzJxeZP3gryTVnvoCueTj1yh
 Oo50T0siyUBAFJlmXXIzZxe4eF83Tyzva9B0DJCcLupaSXOO0cTbUxO+XZ4lltSiYGLn
 MM+mbe0Pog5JCBYV8Fai8UgC8MltsvwTlKGMMrFyEYW9andQIBvlA2vvrV6zYTtDhe+u
 s2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430595; x=1784035395;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zsRbd2iXQS4Pv9VQ95qVDWTuZqDNYcSM1NPff7gLUVQ=;
 b=azFy+lf9ZARNR5SWaTYuQMfyn4H6kxk7XzPKHgiPo8opqXhsJu0JGZb+42AqDpgb9N
 rTvWEJbBb+hlpiYTd3XNzkebJqTpu0OC/VK0Uf2KLiUAUgcr6DCcH/ago5FBZjuEr+WL
 lsycIrgsk73me7aBEcpAeeb950xCOAufPhewnN65CF7pjwKlzuTUp8ucocfocSrJsuFo
 oWAE4ZhgKMW+k9EPlldegiEoB7fxHFMZOFdFRaRYXVFTFXFtqRLoqayLTbylCsIgHKNE
 Rh0HF3Vh4W4YeZ6KJgAdhM/7vVe1dgi5JuepizHjsKnBBDKE1YUm/wHbSUdLhRUU9gi1
 jPbw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5iejOrIvUvU51G9ryprPRS2ONT5Rwvh1qFsAJapc2jiFQhBap2gC0okTO2xbKFdXE4G7rfDkq@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8+GsDFXHqW/gc5Gs/zNnN3k4pssjSgVE4pomEPnzoPWoQYOGB
 pJtCPwNQD9rN67IyPSy4B9oyZua9Vcp7znpEjxatcKrbF+P3bdWXzTj2T/hywFrb2eSOHaef5J9
 C7EWyHfUdWbTkMbKwXgIDV7J4rtzbs+Y=
X-Gm-Gg: AfdE7cla5cstCABXj2fRfq5oqOrxK6CGFpsKuK2Rny/O0REugPwYLS6Mec/egTj9hcP
 Znmt9iq67NJjDdUnbHNsUt3m9BbpPBGtsdO0xKwfyQy64yc0GUgTp4zapCnwuqty9+U2e1femXO
 qScB6TNHZgagu25J3XPHzYpHdl0Sg1NJnmF+nKHrKY3QSwSNSEHAHKJiuRb5dPD5oJbTHk9bQZ+
 myNbgqocBEaSQoAGY+E3LkjBFUieC4595oS5hv9fShyefMpyCdIsZdi2lv9W1bDIDe7ROQbBgLM
 q29ldZVj5mDRCPtsxBJ9Lf8iBReM95eVR/AztdfGd2LRaypTDF6pLIxf8Ho=
X-Received: by 2002:a05:6102:5f05:b0:62f:46c:40bb with SMTP id
 ada2fe7eead31-744c115adcamr680244137.5.1783430595240; Tue, 07 Jul 2026
 06:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260706200600.15071-1-alexander.deucher@amd.com>
 <6513b774-2d75-4819-b76c-20c6447705f2@amd.com>
In-Reply-To: <6513b774-2d75-4819-b76c-20c6447705f2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jul 2026 09:23:02 -0400
X-Gm-Features: AVVi8Ce8t43Zlfo70RiTLljoF7rYdkcg3rnzMk-O1LbUrdJrXdDxhoJJbiZJqqc
Message-ID: <CADnq5_NDnqvuRbKDQySF0w-1HW-5ckUK4C+O2eC9BWBE69kK+A@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/amdgpu/gfx10: disallow gfxoff around GPU reset
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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

On Tue, Jul 7, 2026 at 8:04=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wro=
te:
>
>
>
> On 07-Jul-26 1:35 AM, Alex Deucher wrote:
> > If gfx is hung, we shouldn't need this since gfx won't be
> > powered down, but we could potentially have a case where
> > a queue can be preempted, but due logic errors in the commands,
> > the fence never signals.  GFX could potentially go into
> > the off state.  Protect against that.
> >
> > Assisted-by: Claude:claude-opus-4.6
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 34 +++++++++++++++++--------=
-
> >   1 file changed, 23 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v10_0.c
> > index f03cbf358cd7b..516a621d11faa 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -9528,6 +9528,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring=
 *ring,
> >               return -ENOMEM;
> >       }
> >
> > +     amdgpu_gfx_off_ctrl(adev, false);
>
> Can this be moved to helper begin/end logic - check against
> sdma/compute/gfx rings? It doesn't harm to include sdma even for SOCs
> where it's outside of GFX domain.

If something in the reset path fails, the end helper doesn't get run
so the ref count will be off.  It could potentially be moved to the
job_timedout() and kfd queue reset paths however.

Alex

>
> Thanks,
> Lijo
>
>
> >       addr =3D amdgpu_bo_gpu_offset(ring->mqd_obj) +
> >               offsetof(struct v10_gfx_mqd, cp_gfx_hqd_active);
> >       tmp =3D REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid)=
;
> > @@ -9547,28 +9548,33 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ri=
ng *ring,
> >       r =3D amdgpu_ring_test_ring(kiq_ring);
> >       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> >       if (r)
> > -             return r;
> > +             goto fail;
> >
> >       r =3D gfx_v10_0_kgq_init_queue(ring, true);
> >       if (r) {
> >               DRM_ERROR("fail to init kgq\n");
> > -             return r;
> > +             goto fail;
> >       }
> >
> >       spin_lock_irqsave(&kiq->ring_lock, flags);
> >
> >       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size)) {
> >               spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > -             return -ENOMEM;
> > +             r =3D -ENOMEM;
> > +             goto fail;
> >       }
> >       kiq->pmf->kiq_map_queues(kiq_ring, ring);
> >       amdgpu_ring_commit(kiq_ring);
> >       r =3D amdgpu_ring_test_ring(kiq_ring);
> >       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> >       if (r)
> > -             return r;
> > +             goto fail;
> >
> > -     return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > +     r =3D amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > +
> > +fail:
> > +     amdgpu_gfx_off_ctrl(adev, true);
> > +     return r;
> >   }
> >
> >   static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
> > @@ -9593,13 +9599,14 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ri=
ng *ring,
> >               return -ENOMEM;
> >       }
> >
> > +     amdgpu_gfx_off_ctrl(adev, false);
> >       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
> >                                  0, 0);
> >       amdgpu_ring_commit(kiq_ring);
> >       r =3D amdgpu_ring_test_ring(kiq_ring);
> >       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> >       if (r)
> > -             return r;
> > +             goto fail;
> >
> >       /* make sure dequeue is complete*/
> >       amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> > @@ -9617,28 +9624,33 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ri=
ng *ring,
> >       amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> >       if (r) {
> >               dev_err(adev->dev, "fail to wait on hqd deactivate\n");
> > -             return r;
> > +             goto fail;
> >       }
> >
> >       r =3D gfx_v10_0_kcq_init_queue(ring, true);
> >       if (r) {
> >               dev_err(adev->dev, "fail to init kcq\n");
> > -             return r;
> > +             goto fail;
> >       }
> >
> >       spin_lock_irqsave(&kiq->ring_lock, flags);
> >       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size)) {
> >               spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > -             return -ENOMEM;
> > +             r =3D -ENOMEM;
> > +             goto fail;
> >       }
> >       kiq->pmf->kiq_map_queues(kiq_ring, ring);
> >       amdgpu_ring_commit(kiq_ring);
> >       r =3D amdgpu_ring_test_ring(kiq_ring);
> >       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> >       if (r)
> > -             return r;
> > +             goto fail;
> > +
> > +     r =3D amdgpu_ring_reset_helper_end(ring, timedout_fence);
> >
> > -     return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > +fail:
> > +     amdgpu_gfx_off_ctrl(adev, true);
> > +     return r;
> >   }
> >
> >   static void gfx_v10_ip_print(struct amdgpu_ip_block *ip_block, struct=
 drm_printer *p)
>
