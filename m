Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8757C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 13:33:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7050F10E083;
	Mon, 17 Mar 2025 13:33:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S6muGGxN";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7611589CD3
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 13:33:00 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2ff5544af03so499482a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 06:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742218380; x=1742823180; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0SzNA3cbabiHptKfEPnfxstb8BiiUz58/fkJsUKqb0=;
 b=S6muGGxNc/rOOWG/HS12JgMmo21e7r8eoptZftM40yx1jjaCQR2GuI386baXmdP/Wz
 3oHchwAqsZsjcv3qSMXLR2FEskj7K+MlFQfmJ6GdTpiRxHz/G2Bdc2FrTIhKkxbXVRFX
 tBmkPWO8Ddcjt7Ni7TM7pyLPeAiVLxCbnX52cgiJZECV/DhVeyjIFPcLjvwf7T0e8KwD
 erQsuFumEazM793P9ZRchENeEz9MfEUNPmOPKFDebhdlRlUv5eRxhJhknttCyQoLUJAB
 ujPkZKAOIbgbZmVei3a1D75OpQKEjWi+raottE2/q3PJyWTk5FpFv8NEb7bblAb9BNlr
 mAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742218380; x=1742823180;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S0SzNA3cbabiHptKfEPnfxstb8BiiUz58/fkJsUKqb0=;
 b=tsSJy3zi+Ptz4WGFbBNv1GZ+jvpsnQwjkvDxjhZVe2q0LLTc/AgdhHfJ7i6of/xgiZ
 KHSmXxpo0f99sTlOmrDj4EA00qjApm+nMCnyIqJ/hj3HnaiIulBAFarbg3g5DBRuL6yt
 hJxEnT7uvXPziMP0PDRuooW4RcbJk/C+fA1NYPI6Yk1SUybxb2udSCdlJQ9feFvyIZGK
 kP8DaKrzVg4JKyj5jHzlkkG0ZcAVhSZsJ0RVna32gQm5v/Pxxt4ETO8v6C8ZOf0MKCQN
 nI1MFTReiqvunxe3NPxHXtNsUw2ba/sLGWut4UmAkuYrKkVaMFqZSHmHnEC+giWOQ1Yl
 QagA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpSTHv7mfq4NRkqTbTUbc7l77QvEQSTs9FMJzHB4GU3iLrH8B01nkWB4ST46HjVXO95cQqbbTY@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywpph4imIWFH6CtuodjMLIKYDQO9VyccDHaDqyr3+p7XUOGZP/P
 YcwDZI5dWKYCKaZZHZzhQaVrztAT3ysEsfFB3Lek2b+nOEjcLzrNUCD2kMYAybLMjgLLlZdbajg
 gH5hzF2sR2ZYTdAaPSGB4cjjs4/k=
X-Gm-Gg: ASbGncsbzez6bQL4BabtxyIij5TMVHobbBqkTfkBAv72QPbjZwcCko90DxN/vYYrj//
 8ycwBF4ckB5/nkxZb7/Mx3qnjpeuY/P1/ULtB/Yf/vhUl39WGLauvmA1lJJ3wuQQ++/hIerZXfe
 wwoEVq75FWyh6tA1z4lMzAaHp04Q==
X-Google-Smtp-Source: AGHT+IGZga7K+1b+fKChx/CKmiKwF4XxQ7yRT3iOLOsMV6VJdeBLQJwp1HXx8zu+NFfATx98njSH9gcyPuAPuyMc3Oc=
X-Received: by 2002:a17:90b:388e:b0:2fa:6055:17e7 with SMTP id
 98e67ed59e1d1-30151d8eb02mr6043412a91.8.1742218380097; Mon, 17 Mar 2025
 06:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <20250313144136.1117072-4-alexander.deucher@amd.com>
 <DS7PR12MB6005F4F38F75F94DC2262703FBDF2@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005F4F38F75F94DC2262703FBDF2@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Mar 2025 09:32:48 -0400
X-Gm-Features: AQ5f1JoubGnI0g6-SmZu_eCqnIKw6cH9LM80SHoW8PHmgwxuUKkz4mFr-sh2HbM
Message-ID: <CADnq5_N9BA5jz+iucHv-bPUz7ypxVHg_a47US92-Yr8Pu0cvTQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] drm/amdgpu/gfx: add generic handling for disable_kq
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Mon, Mar 17, 2025 at 5:07=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> [Public]
>
> When disabling the gfx kernel queue, then the related ring function callb=
ack should be unassigned, and the clean shader callback should also not be =
further invoked. To avoid the clean shader resource allocated, we may need =
to drop the shader clean initialized at *_ sw_init() when disable gfx kerne=
l queue.

This patch prevents the cleaner shader from being run via sysfs
already.  We still need to allocate the cleaner shader resources
though because they are used by the MES and CP firmware for user
queues.

Alex

>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Thursday, March 13, 2025 10:41 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: [PATCH 03/11] drm/amdgpu/gfx: add generic handling for disable=
_kq
> >
> > Add proper checks for disable_kq functionality in gfx helper functions.=
  Add special
> > logic for families that require the clear state setup.
> >
> > v2: use ring count as per Felix suggestion
> > v3: fix num_gfx_rings handling in amdgpu_gfx_graphics_queue_acquire()
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 8 ++++++--
> > drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 ++
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > index 984e6ff6e4632..a08243dd0798e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -258,8 +258,9 @@ void amdgpu_gfx_graphics_queue_acquire(struct
> > amdgpu_device *adev)
> >       }
> >
> >       /* update the number of active graphics rings */
> > -     adev->gfx.num_gfx_rings =3D
> > -             bitmap_weight(adev->gfx.me.queue_bitmap,
> > AMDGPU_MAX_GFX_QUEUES);
> > +     if (adev->gfx.num_gfx_rings)
> > +             adev->gfx.num_gfx_rings =3D
> > +                     bitmap_weight(adev->gfx.me.queue_bitmap,
> > AMDGPU_MAX_GFX_QUEUES);
> >  }
> >
> >  static int amdgpu_gfx_kiq_acquire(struct amdgpu_device *adev, @@ -1544=
,6
> > +1545,9 @@ static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct devi=
ce
> > *dev,
> >       if (adev->in_suspend && !adev->in_runpm)
> >               return -EPERM;
> >
> > +     if (adev->gfx.disable_kq)
> > +             return -ENOTSUPP;
> > +
> >       ret =3D kstrtol(buf, 0, &value);
> >
> >       if (ret)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > index ddf4533614bac..8fa68a4ac34f1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -483,6 +483,8 @@ struct amdgpu_gfx {
> >
> >       atomic_t                        total_submission_cnt;
> >       struct delayed_work             idle_work;
> > +
> > +     bool                            disable_kq;
> >  };
> >
> >  struct amdgpu_gfx_ras_reg_entry {
> > --
> > 2.48.1
>
