Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BDECAC583
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 13:37:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13ACD10E739;
	Tue,  9 Sep 2025 13:37:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VmtMQXX4";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF36A10E739
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 13:37:12 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-b4fc0249e41so238910a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757425032; x=1758029832; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tObwF+Z08H79MDMKWC6zGt+hFazMP8SQpHHt/ZJ99zc=;
 b=VmtMQXX4qXGn134aInSfe4TdJ/khsOPs2piUgIcNYfQuMilR8yHAaJst6lEpsIJfff
 Xnp8dn//wdJfQfgECwzCCMqM0uFQ8jbNDQBbrYtcJDNS5HjoWxr0JaUZsSfcQ3vmzt8e
 gKs+ebJkNBdOBD/aKHZ630Cp38vZ8teKPJaITus00xhWVaccQ4jTLg9HrG1oWf1LM2Tz
 RaO4Fkt8vl0l1DTu+vvn0h8fO2EeXciwHuyESfFASTnewHkNvfKK06K8kmmMrU33BzYa
 2BvieKyD27a8vzGfnO4lL5vnGPfrgtSzXSlSVWeBhUR9ug9ltDvLiQjwOgN5UJjYzgc8
 owbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757425032; x=1758029832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tObwF+Z08H79MDMKWC6zGt+hFazMP8SQpHHt/ZJ99zc=;
 b=MdyNl2hSbWf/UToIqUwG2ELy/Ai7WTDQv4iRKqMlAg2jmBkkmznOrb8tDSzgEUmkju
 FbkLKimizijHNSXEX2WEryY9T6AS1BI6h/PwvsXaQSM4iRL1bckLZ1iTq2qcKFc1qoB/
 0ZtTim5NopHtSAwEym0RVZtNoh2hQnVsbgsIma7R98ycViqns4qwV4CQY0BnyJGTr+lb
 Fif1Dm3NRmR+vsJIemCegmQym/haGtOcVUXt3ngsoepe952pR2D2L6+V2Jcs0xbyh9Og
 btH60cCkYw+Lv3BsMHwIr0Ok+g/9B38F3A/Udw0v1kKOQyviklQ0k814Ow/t7/STrvZ0
 C+nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs/vS88MOUWl3mM1oScmOrFSK45Tb6j+Pr6c2I6luSoALEO9+HfEyChyQDUMRcgMTaenS0HyK3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPObgwgqTN9YCtWhXmDpt0OZFS6+910Hnh9axj5TyaxeeN1MCu
 WZXoGxyRYApHlSHIXR8eTXe641Tc9pVlABHsVdeOwxOJbAfmJbf2lORxIkdkwXu7zrwB7dZsSa9
 5p9vaYWIuBSc9+QBHINyYT6TfFrY21/g=
X-Gm-Gg: ASbGnctdXE8/x7AsEpPhrFR3sPxRVzworbJcCF/FvvtOn6ML7T20cE6Uq1EY6+YXiWv
 DoSnwxIeeK0NlFbDM41RZYZ9g7NO8ez5tH1lYQmEUv9aRMmO2a7Vdb5VM4XflPabEXGZw1fCvEk
 W3EyitYddVLM18G2zO9OlWQmSgcQ56GUWqlRuV30aPay4DwgxPwXiv26tjfRCs+qcM4rdL/LsnR
 jYMOWNwijQJ/y08OA==
X-Google-Smtp-Source: AGHT+IHOvEUNBPtasBBqDVGrC3boG1QFPoLsPBUKZG/vU4sKHUOzXJ8cpzdtz7sFr+UjNvP3nBS1m8FRoIPx0JfHBlk=
X-Received: by 2002:a17:902:f682:b0:24c:b6b6:e54c with SMTP id
 d9443c01a7336-2516e4b07f1mr82434165ad.3.1757425032140; Tue, 09 Sep 2025
 06:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250908211559.519892-1-thorsten.blum@linux.dev>
 <4005498b-d866-4e41-a8a4-d8228b2062e7@ursulin.net>
In-Reply-To: <4005498b-d866-4e41-a8a4-d8228b2062e7@ursulin.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Sep 2025 09:36:59 -0400
X-Gm-Features: Ac12FXw7muqg4kVuUdM_LumdYu1y5udy9p_-qPeA0dWyuOGO6hI58DbsamVKYbk
Message-ID: <CADnq5_NDrq_S7rcpr6_MY-USfVGr8-QcJ2hqnai7VEm5D_OyxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Replace kzalloc + copy_from_user with
 memdup_user
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Sep 9, 2025 at 4:17=E2=80=AFAM Tvrtko Ursulin <tursulin@ursulin.net=
> wrote:
>
>
> On 08/09/2025 22:15, Thorsten Blum wrote:
> > Replace kzalloc() followed by copy_from_user() with memdup_user() to
> > improve and simplify ta_if_load_debugfs_write() and
> > ta_if_invoke_debugfs_write().
> >
> > No functional changes intended.
> >
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 20 ++++++--------------
> >   1 file changed, 6 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_psp_ta.c
> > index 38face981c3e..6e8aad91bcd3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> > @@ -171,13 +171,9 @@ static ssize_t ta_if_load_debugfs_write(struct fil=
e *fp, const char *buf, size_t
> >
> >       copy_pos +=3D sizeof(uint32_t);
> >
> > -     ta_bin =3D kzalloc(ta_bin_len, GFP_KERNEL);
> > -     if (!ta_bin)
> > -             return -ENOMEM;
> > -     if (copy_from_user((void *)ta_bin, &buf[copy_pos], ta_bin_len)) {
> > -             ret =3D -EFAULT;
> > -             goto err_free_bin;
> > -     }
> > +     ta_bin =3D memdup_user(&buf[copy_pos], ta_bin_len);
> > +     if (IS_ERR(ta_bin))
> > +             return PTR_ERR(ta_bin);
> >
> >       /* Set TA context and functions */
> >       set_ta_context_funcs(psp, ta_type, &context);
> > @@ -327,13 +323,9 @@ static ssize_t ta_if_invoke_debugfs_write(struct f=
ile *fp, const char *buf, size
> >               return -EFAULT;
> >       copy_pos +=3D sizeof(uint32_t);
> >
> > -     shared_buf =3D kzalloc(shared_buf_len, GFP_KERNEL);
> > -     if (!shared_buf)
> > -             return -ENOMEM;
> > -     if (copy_from_user((void *)shared_buf, &buf[copy_pos], shared_buf=
_len)) {
> > -             ret =3D -EFAULT;
> > -             goto err_free_shared_buf;
> > -     }
> > +     shared_buf =3D memdup_user(&buf[copy_pos], shared_buf_len);
> > +     if (IS_ERR(shared_buf))
> > +             return PTR_ERR(shared_buf);
> >
> >       set_ta_context_funcs(psp, ta_type, &context);
> >
>
> More complete than the one I sent in June^1.

I never received this series.  I didn't see it in patchwork either.
Seems it never made it to amd-gfx.  Sorry I missed it. I've applied
the applicable patches now.

>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Applied.  Thanks!

Alex

>
> I had some other in that series, not sure if you caught those.
>
> Regards,
>
> Tvrtko
>
> 1)
> https://lore.kernel.org/amd-gfx/20250612104430.41169-1-tvrtko.ursulin@iga=
lia.com/
>
