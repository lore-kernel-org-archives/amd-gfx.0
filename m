Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16044C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 14:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49EC010FC76;
	Tue, 23 Apr 2024 14:09:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gJebP/Wl";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC6E910FC76
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 14:09:50 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2a52c544077so4004118a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 07:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713881390; x=1714486190; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pnwdRdDuSQSUWlymX4w13Cy33095rZy6XDaoEsFoO8Y=;
 b=gJebP/Wlz++j923k/c5x3KvZhJjmmFTzTqvzZBokG2YuVkY3c/UVK38G7gbSpmbAnm
 iQdctLeoebAI9q9ge9uejdM2K92KJ+g8TPi58E7AjBPVaglQXGqCRPKw4tzDpSMRImBc
 coriSqRfZ6RDcuVFyBiLctDKQKtxconOYRsJJM0tgBJ5aAW7UChMVqLXohXDD90TA3Mq
 QLQgHZ4tP7Uz0scvVxJhhheV+FXrJQKFb1dxFcvDAQVfEDg9NCADPGb92tY+Z5PFiFyN
 0keAx25ky22RtkepgXnnfu+4vqfVLEbLMCyBFkotS8XRI96wX5cD4pAgI1rHvoPheLKR
 /+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713881390; x=1714486190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pnwdRdDuSQSUWlymX4w13Cy33095rZy6XDaoEsFoO8Y=;
 b=L7LnYv/jsQpfEXlvk0EF1RqBIqjlEBIRsDrLBqsrIE8nJMrvQhaCNm9sphGmmLl8i4
 8vIWOd/Wdk/AdlTvq4sq7/YyCrfRat6G3GwFiGXii55wHcSP0eIfSBgKkYV05zGaRwL+
 XByocxEfY7MRY/6dBJTr8vgAQL5WgSRHZ9A/5vSWm4j1xQm7ZeFC8ozkP4hWsOrn5lTV
 ZdMz56xwKqwQKMp9L2NIqn76RC05CRXTBvir5EVJkaKhKnXOEjTrrZkArQIsihyHGlCK
 jH5Bme6m8jii+DLRk8sOlp8Zz+nzNHGjLdjqDP1iWRdbo4zCLyAi0Nfdrjrz3qQjqgta
 UBWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcS8ka7gmHfkt8keF4GXUQHF7RP+74HbEucVdaM5OjMuuPBPeh+ZchA7zrJMFzsVDgcPzyY2JRFP+IW4xsgvhWPbniGls7pPLsn1pV/g==
X-Gm-Message-State: AOJu0YyPju5oFif5WS4I5HX1j+BPzsAzgozAYV2GuNHV/mBWGTtBHNX9
 HwCU3u02xBcq+6E7cPDPf14u9ef+aDMj7/3/NNy9JKbfyOQUztvfT9b4TR/qVE+QB/aGI5wDjC7
 V1WCCVyts0hJ/KNMxPs5MMW+FZdA=
X-Google-Smtp-Source: AGHT+IH+PeA3CwV5mndaDhPMKRr6vfmSM0Q78pQTV12plrx6mIztQ2SNtQlZeROZ5jijEvLeDFs3D/WLLWj6wCRK/Ck=
X-Received: by 2002:a17:90a:ae08:b0:2a0:215f:dc9c with SMTP id
 t8-20020a17090aae0800b002a0215fdc9cmr12297301pjq.35.1713881390000; Tue, 23
 Apr 2024 07:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240422143738.322710-1-alexander.deucher@amd.com>
 <959d6fe8-b5e4-4ffe-918c-cbd29a2342e1@gmail.com>
 <CADnq5_PzNC8qWq=XP5KCuvR15-UEJ0QDMtaK821wFVu-p_=Jsw@mail.gmail.com>
 <2e0941f9-a5b0-40a7-b1ad-329d4ae53cd6@gmail.com>
In-Reply-To: <2e0941f9-a5b0-40a7-b1ad-329d4ae53cd6@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Apr 2024 10:09:37 -0400
Message-ID: <CADnq5_PNLQw6C3QaMGOoBdN2T8ti0Odp7fkjUCjnU0qEa1SZmQ@mail.gmail.com>
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

On Tue, Apr 23, 2024 at 9:58=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 23.04.24 um 15:18 schrieb Alex Deucher:
> > On Tue, Apr 23, 2024 at 2:57=E2=80=AFAM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >> Am 22.04.24 um 16:37 schrieb Alex Deucher:
> >>> As we use wb slots more dynamically, we need to lock
> >>> access to avoid racing on allocation or free.
> >> Wait a second. Why are we using the wb slots dynamically?
> >>
> > See patch 2.  I needed a way to allocate small GPU accessible memory
> > locations on the fly.  Using WB seems like a good solution.
>
> That's probably better done with the seq64 allocator. At least the
> original idea was that it is self containing and can be used by many
> threads at the same time.

Sure, but that is mapped into the user VMs and has sequence numbers
handling which we don't really need for handling the MES.  It also
makes seq64 a requirement for this fix which makes it harder to port
back to older kernels.

Alex

>
> Apart from that I really think we need to talk with the MES guys about
> changing that behavior ASAP. This is really a bug we need to fix and not
> work around like that.
>
> Christian.
>
> >
> > Alex
> >
> >> The number of slots made available is statically calculated, when this
> >> is suddenly used dynamically we have quite a bug here.
> >>
> >> Regards,
> >> Christian.
> >>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++++++++++-
> >>>    2 files changed, 11 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu.h
> >>> index cac0ca64367b..f87d53e183c3 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>> @@ -502,6 +502,7 @@ struct amdgpu_wb {
> >>>        uint64_t                gpu_addr;
> >>>        u32                     num_wb; /* Number of wb slots actually=
 reserved for amdgpu. */
> >>>        unsigned long           used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_=
PER_LONG)];
> >>> +     spinlock_t              lock;
> >>>    };
> >>>
> >>>    int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb);
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_device.c
> >>> index f8a34db5d9e3..869256394136 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> @@ -1482,13 +1482,17 @@ static int amdgpu_device_wb_init(struct amdgp=
u_device *adev)
> >>>     */
> >>>    int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb)
> >>>    {
> >>> -     unsigned long offset =3D find_first_zero_bit(adev->wb.used, ade=
v->wb.num_wb);
> >>> +     unsigned long flags, offset;
> >>>
> >>> +     spin_lock_irqsave(&adev->wb.lock, flags);
> >>> +     offset =3D find_first_zero_bit(adev->wb.used, adev->wb.num_wb);
> >>>        if (offset < adev->wb.num_wb) {
> >>>                __set_bit(offset, adev->wb.used);
> >>> +             spin_unlock_irqrestore(&adev->wb.lock, flags);
> >>>                *wb =3D offset << 3; /* convert to dw offset */
> >>>                return 0;
> >>>        } else {
> >>> +             spin_unlock_irqrestore(&adev->wb.lock, flags);
> >>>                return -EINVAL;
> >>>        }
> >>>    }
> >>> @@ -1503,9 +1507,13 @@ int amdgpu_device_wb_get(struct amdgpu_device =
*adev, u32 *wb)
> >>>     */
> >>>    void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
> >>>    {
> >>> +     unsigned long flags;
> >>> +
> >>>        wb >>=3D 3;
> >>> +     spin_lock_irqsave(&adev->wb.lock, flags);
> >>>        if (wb < adev->wb.num_wb)
> >>>                __clear_bit(wb, adev->wb.used);
> >>> +     spin_unlock_irqrestore(&adev->wb.lock, flags);
> >>>    }
> >>>
> >>>    /**
> >>> @@ -4061,6 +4069,7 @@ int amdgpu_device_init(struct amdgpu_device *ad=
ev,
> >>>        spin_lock_init(&adev->se_cac_idx_lock);
> >>>        spin_lock_init(&adev->audio_endpt_idx_lock);
> >>>        spin_lock_init(&adev->mm_stats.lock);
> >>> +     spin_lock_init(&adev->wb.lock);
> >>>
> >>>        INIT_LIST_HEAD(&adev->shadow_list);
> >>>        mutex_init(&adev->shadow_list_lock);
>
