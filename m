Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36E4C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 13:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE3710E23C;
	Tue, 23 Apr 2024 13:18:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XWm2xzQo";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A105810E23C
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 13:18:31 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so3867545a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713878311; x=1714483111; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOHGqgtpP1HZJl/Fsj3Lm7NWDDZpqW8Btn+9BlQBV94=;
 b=XWm2xzQoGL5kMpzYIjb91A1iPLcDCPyaphmIoH/xsWGgrGbWbfQri0o7YUT3u+mJU2
 L0oJ+x+7y5xOKHVgX1ns6mAvSgpuq9YOungJYRy3RALRF7DlLsxiO8WVw0o4nX1MEHW7
 VJAvwVt5FpUu2FP6btfZjeqb7zcWZSYR7+8UDKHVuu+fP9MGovbycnxQFZgMdTMr96oA
 EM9/az70bpEL6GhijdeG84e7S56xMpnrQOxzV19/HXjNzTyWcKuNf758Gu/vRxnzsC1n
 GhAHEwT25hp4fztWP/j3LVzNwfAcLlRTnUuzw+/6I1iyWO3BBmw21Zs+IdOuCyyNDOTM
 JYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878311; x=1714483111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EOHGqgtpP1HZJl/Fsj3Lm7NWDDZpqW8Btn+9BlQBV94=;
 b=MghKwQAHNKbWwmNWKCNglxAW6M5/GD9n6IOmahq4ATthBi2wD22VIwyehNRnT1kQUV
 g6+nQSoXI1EG8qdVhYf+kSGWE1wIafZsrFm5A5QQilY4mCIm0K+6sWczTJccR2EKMYIn
 Jk+bWveiO+X5W80lVlcjGr05qKSaiicB9IfudbQ9A25QpddSCbnbtHFD/NV6gT6A3qMz
 0f10ZtHOZDsWCrMrPqi8AIjEl/uhDrx9qtvtvufC59fkck+U4mDr1RYCib30H/da8rhK
 EIyvWL0ggw4Los/SwoeA3sEaNk7WBgWKnz1bN2Z+lVrzbcjedgq3W4d71yV2YjY/gBDZ
 pMBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoaccWRwAaKZ43TVf0FBpBf0Z+pYb0Ovd7rCP6TNMDC4jIz0u7WtUZG6MuTatGof/RkS1KTT8upP+C7d20O6pH+xK27JFOQ2muGT6HRQ==
X-Gm-Message-State: AOJu0Yy7AA3Mx36uJcZfZtTKo00dx55//rXeWQtXRU7uSNn7QFeIVcqP
 aenj9ToDyH+On3aOk6l+smhdc8SSAmvFkXWYVcDkrtOPihHcoWij0IowZDUWvNyWwBdmgSJf8aU
 4uZKQpQ089QmfA0RnBKvYuSxLQ+k=
X-Google-Smtp-Source: AGHT+IHtxHY1+kSiRUCLXHyHwbw6NX78jS+uH/XGjfFjjPxcYiSWnGUwhgq1W/svtjUg22eg3ZgHEbHu142IIsehikY=
X-Received: by 2002:a17:90a:b108:b0:2a5:733c:3105 with SMTP id
 z8-20020a17090ab10800b002a5733c3105mr12091193pjq.26.1713878310807; Tue, 23
 Apr 2024 06:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240422143738.322710-1-alexander.deucher@amd.com>
 <959d6fe8-b5e4-4ffe-918c-cbd29a2342e1@gmail.com>
In-Reply-To: <959d6fe8-b5e4-4ffe-918c-cbd29a2342e1@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Apr 2024 09:18:18 -0400
Message-ID: <CADnq5_PzNC8qWq=XP5KCuvR15-UEJ0QDMtaK821wFVu-p_=Jsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: add a spinlock to wb allocation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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

On Tue, Apr 23, 2024 at 2:57=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 22.04.24 um 16:37 schrieb Alex Deucher:
> > As we use wb slots more dynamically, we need to lock
> > access to avoid racing on allocation or free.
>
> Wait a second. Why are we using the wb slots dynamically?
>

See patch 2.  I needed a way to allocate small GPU accessible memory
locations on the fly.  Using WB seems like a good solution.

Alex

> The number of slots made available is statically calculated, when this
> is suddenly used dynamically we have quite a bug here.
>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++++++++++-
> >   2 files changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index cac0ca64367b..f87d53e183c3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -502,6 +502,7 @@ struct amdgpu_wb {
> >       uint64_t                gpu_addr;
> >       u32                     num_wb; /* Number of wb slots actually re=
served for amdgpu. */
> >       unsigned long           used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER=
_LONG)];
> > +     spinlock_t              lock;
> >   };
> >
> >   int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index f8a34db5d9e3..869256394136 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -1482,13 +1482,17 @@ static int amdgpu_device_wb_init(struct amdgpu_=
device *adev)
> >    */
> >   int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb)
> >   {
> > -     unsigned long offset =3D find_first_zero_bit(adev->wb.used, adev-=
>wb.num_wb);
> > +     unsigned long flags, offset;
> >
> > +     spin_lock_irqsave(&adev->wb.lock, flags);
> > +     offset =3D find_first_zero_bit(adev->wb.used, adev->wb.num_wb);
> >       if (offset < adev->wb.num_wb) {
> >               __set_bit(offset, adev->wb.used);
> > +             spin_unlock_irqrestore(&adev->wb.lock, flags);
> >               *wb =3D offset << 3; /* convert to dw offset */
> >               return 0;
> >       } else {
> > +             spin_unlock_irqrestore(&adev->wb.lock, flags);
> >               return -EINVAL;
> >       }
> >   }
> > @@ -1503,9 +1507,13 @@ int amdgpu_device_wb_get(struct amdgpu_device *a=
dev, u32 *wb)
> >    */
> >   void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
> >   {
> > +     unsigned long flags;
> > +
> >       wb >>=3D 3;
> > +     spin_lock_irqsave(&adev->wb.lock, flags);
> >       if (wb < adev->wb.num_wb)
> >               __clear_bit(wb, adev->wb.used);
> > +     spin_unlock_irqrestore(&adev->wb.lock, flags);
> >   }
> >
> >   /**
> > @@ -4061,6 +4069,7 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
> >       spin_lock_init(&adev->se_cac_idx_lock);
> >       spin_lock_init(&adev->audio_endpt_idx_lock);
> >       spin_lock_init(&adev->mm_stats.lock);
> > +     spin_lock_init(&adev->wb.lock);
> >
> >       INIT_LIST_HEAD(&adev->shadow_list);
> >       mutex_init(&adev->shadow_list_lock);
>
