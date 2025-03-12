Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D358C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 18:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39B4A8825B;
	Wed, 12 Mar 2025 18:52:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V934DOyG";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 348B310E15D
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 18:52:49 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2ff6b9a7f91so54062a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 11:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741805569; x=1742410369; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dT6zlSkdP1LOEOHl2O0oUwOvULQYcxin+fKLwAiy5lg=;
 b=V934DOyG/3RPvG2gfjtT4czwbpSTeUtQ0RVmssvc7WxzgwkceiNJ5C3l13QVjJc8U5
 MIEj/gDr4rJTWmBqYwKDAr5zQxeiJqdhZAHCIMr0zwGCqY9sGMI1mF9UhW8WBOBRT+n/
 uKUIRulfd1OJEhprSCImts6dgbC1fSLxmXG7/SDHQaRuKJrSbaWhYpkRYES+6dJm3ah/
 XUXTxKZn0ORdy8zxNH/QJbK+u21M6gPWVDcrbbVZprLxmnyxogPzv5ihff++X3NniQ2P
 QgmTFYAIeTt8lxY5guuO4LuC7R82Gnd7O/dEc70ZMDlm17s8Aiys/Ps98UZiZQ/pMRfB
 R0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741805569; x=1742410369;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dT6zlSkdP1LOEOHl2O0oUwOvULQYcxin+fKLwAiy5lg=;
 b=ZNpUzHSbouYtuRupvxyeiHR9bySgvPjp3kw/G2DJ/DZJTPEjcZZxgnNYsy7tR0uIIO
 AvessVXiF54ZndXsOq/UWYmrNxMekvsoR58NPy+08z9c8vhZN4r9CV3bFragdwKkz9Ev
 5niZV+OqsuQeqISadnN9GmSMqXx/yMGxZPstHNsZP0SwLz2ycswnG66GQ7c72qdc/249
 YcChZ0W0h2b4kde61+PfyqeDyUY+XRXpxprPMlQ4EpGcx+kncpEYXkkWL8mwTNLM6QMA
 bVG5ZT8vZ2VuTurBUo1IHnQPJy/W/nlL8lt3Q7Ox5h4e9Efj/b+B5JkJJz679Vo5smjd
 4DOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVYvqW20fe903VR7b1tZQzAmnMqsgX+p7ALNnpZys/d85/LgijiS//hcxF8Eu3lXAhHbPFbvhW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZyHzyQpz/6yHFTYryucg7JD1lKvr7MO8TuSK3xCrOqufEOx/w
 ONYRHoJ8NrA3gYrVO5yoA6EVt13A83dJ2PILAPuUOwGRkVNcYUbK9vPTJ6zN/J8mkA5ejvNH2XK
 3pqAK/M1WOeFeu6OXBBpnm/P9qqg=
X-Gm-Gg: ASbGnctTxfx7weAlDLRaCZOxC5bQWkpTuG0XZHc3IMAWCZNV07TjqOd1O+Eegh5KBHJ
 3X9biIk0no78I5Ha5l5Y7tyv4dtsojCrS6AgRAqz1Edzj1g5imWEYARVMEplRF9Moh2sKMDqdoT
 5TPTxA4YgHzjUjtOyRLI1xrTn3bYjg+puhiYeo
X-Google-Smtp-Source: AGHT+IEPdT/nuirCRBemYthe8mkccLZvZ8LZBo/ZEb36stIjbsL2FWzj9zqT/ouD7bQ6EgxP+5pON3LGDNdbf1M1kQ0=
X-Received: by 2002:a17:90b:2241:b0:2fe:b77a:2eba with SMTP id
 98e67ed59e1d1-300a2b6fb91mr10119655a91.1.1741805568696; Wed, 12 Mar 2025
 11:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250307151605.946109-1-alexander.deucher@amd.com>
 <20250307151605.946109-4-alexander.deucher@amd.com>
 <DS7PR12MB60052B3DBC10717066711791FBD12@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB60052B3DBC10717066711791FBD12@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Mar 2025 14:52:36 -0400
X-Gm-Features: AQ5f1JqAyaIyCFBRfoiV1hD9mOKwDs7nu_zuKi2yoG8ahB3USf5kmNGCxcBDdWU
Message-ID: <CADnq5_PjnZ43FQSMzMXJ+Ns9sqPxjzywS=-QxLnrYA9pZ=FAFA@mail.gmail.com>
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

On Tue, Mar 11, 2025 at 10:18=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com>=
 wrote:
>
> [Public]
>
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Friday, March 7, 2025 11:16 PM
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
> > index a194bf3347cbc..2c78185a33218 100644
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
> Maybe here need to disable the flag enable_cleaner_shader as well?

We still need it, but the MES runs it when switching queues rather
than the driver in the userq case.

Alex

>
> Thanks,
> Prike
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
