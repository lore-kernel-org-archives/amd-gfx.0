Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B38E77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 17:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B92710EE67;
	Thu,  9 Jan 2025 17:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JipdrpCs";
	dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51FD810EE67
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 17:06:15 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2f45244a81fso226936a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jan 2025 09:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736442375; x=1737047175; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GZCRsAHA2197qfgmiag0BNGWXlLf8JeAEs7A5YtIAjA=;
 b=JipdrpCs5BhGVN1giN+uOv8uBuluU0SDvIa/VQ7yUg2SVf1/6NvJcYYKrh5edYp6kK
 +ds6uF88BlUzN4NzDy5SjGSNkKX2fsbB1zfAR/pAQR3k69aP++l6Z+KAlVfqU3RsJki/
 MZf/RvQ1IBngSvzwNT//C/3LiiYXdqMnowp2GNenxut5oVgpI7jK6h32hRAy8ot5CvbJ
 JLFf8Z5OrqxptJftw6CkWkep6dhwZUWCwMvTGSn6hxZYAFJIf3O7EySHcHo5H6t01CS1
 Jkb/rSZYjop/ylgZ7aR6T5J6OWXMy+Np4VgtQaNogt6dufxqCFkkUsEtBiEgn1sMx0qN
 BQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442375; x=1737047175;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GZCRsAHA2197qfgmiag0BNGWXlLf8JeAEs7A5YtIAjA=;
 b=wwdaAp7oeT8AFrLvFc6XEaQPaqvsxWbXjDWONk/MmzXigQTk3bU14PE/wgNM/7hJBX
 zbJye0/Cw0CRkkRs83UWhDKNiYRtEEYzeiQhq4OQSKjS2vUvJVOyyrnQ2aX7SbmbIQip
 tfjBleZE+4szFwKtvvovThBBmGz2N7jYncYUn2eHnnFvmcvBHFZrt0JDg/eiEnr1Gg6a
 IHMIZUfw43qJhPxejVo8Q4hCdhokvYqRHObTcHUdmwnwxKhjZrz+EzDAbAid3cQzBaIW
 0IxeqGF67C95AM4gwNb5BJhz3EvdqkSA6RrcRqoJOzCXHF925kTmKS1sJlDPIOh30ZRu
 TCGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD3jXj0EAgC3PUApRk77MmYPLSN7F+Ou+2CHkR06IFtRx1lUF1E+V4mvvN67QdGq1Z8DAh9ytW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDPIEOb2M2Gmder0CYW4yxUzsFYBZLdk5CvHdbzPFCxjQgJJ43
 TPVei3YYAZ5PVsYHybLuDtL9ExP+JWPQEnr35zytSNKyIBqDUOuciELnJYJkUXU10qB+L3Rjz0U
 J7FIuz7uoHSiK3J7TpNPZpMnf848YqA==
X-Gm-Gg: ASbGncvcHjHd42utjP8hIFyrEV6x3hbnBH5J1lNViIG9crXQQgT+iBYUCWmC9YOJOfc
 8CLKxdRrRo3wKwJlecM/CjJ8ZodDTVx0G2q/AzQ==
X-Google-Smtp-Source: AGHT+IHykwN5HOhD6y5rIi9dPld4TR7lgmiiyG6WbnL+9t1Dp4/WKiin75X6KC/LtAufChVr+tIYnnkmR1/OGbWi/TM=
X-Received: by 2002:a17:90a:d2c4:b0:2ee:f1e3:fd0c with SMTP id
 98e67ed59e1d1-2f548f75c6bmr3848078a91.8.1736442374696; Thu, 09 Jan 2025
 09:06:14 -0800 (PST)
MIME-Version: 1.0
References: <20250108225627.14063-1-alexander.deucher@amd.com>
 <589ecdc0-9f5d-4b79-b11d-01b6d22fbf15@amd.com>
In-Reply-To: <589ecdc0-9f5d-4b79-b11d-01b6d22fbf15@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Jan 2025 12:06:03 -0500
X-Gm-Features: AbW1kvYKxyW4mLJJSiacHKh2txDpuXonaQh-hj9NdNygs3NjPia7yQEhnK8ho4M
Message-ID: <CADnq5_NrJ7xqkxk-ccYnQeuVRoWuN95Wyq59UVYtdRUMVVqCvw@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdgpu/gfx: add ring helpers for setting workload
 profile
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 aurabindo.pillai@amd.com, kenneth.feng@amd.com
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

On Thu, Jan 9, 2025 at 12:59=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 1/9/2025 4:26 AM, Alex Deucher wrote:
> > Add helpers to switch the workload profile dynamically when
> > commands are submitted.  This allows us to switch to
> > the FULLSCREEN3D or COMPUTE profile when work is submitted.
> > Add a delayed work handler to delay switching out of the
> > selected profile if additional work comes in.  This works
> > the same as the VIDEO profile for VCN.  This lets dynamically
> > enable workload profiles on the fly and then move back
> > to the default when there is no work.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 57 +++++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 11 +++++
> >  2 files changed, 68 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.c
> > index 6d5d81f0dc4e7..c542617121393 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -2110,6 +2110,63 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(s=
truct amdgpu_ring *ring)
> >       mutex_unlock(&adev->enforce_isolation_mutex);
> >  }
> >
> > +void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work)
> > +{
> > +     struct amdgpu_device *adev =3D
> > +             container_of(work, struct amdgpu_device, gfx.idle_work.wo=
rk);
> > +     enum PP_SMC_POWER_PROFILE profile;
> > +     u32 i, fences =3D 0;
> > +     int r;
> > +
> > +     if (adev->gfx.num_gfx_rings)
> > +             profile =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> > +     else
> > +             profile =3D PP_SMC_POWER_PROFILE_COMPUTE;
>
> Since profile selection is in generic code, it makes sense to first
> check if the profile is supported for the family. Otherwise, this needs
> to be passed by the respective GFX family.

The generic code already handles this.  If you select an unsupported
profile, it's ignored when the mask is updated.

Alex

>
> Thanks,
> Lijo
>
> > +
> > +     for (i =3D 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
> > +             fences +=3D amdgpu_fence_count_emitted(&adev->gfx.gfx_rin=
g[i]);
> > +     for (i =3D 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTA=
NCES); ++i)
> > +             fences +=3D amdgpu_fence_count_emitted(&adev->gfx.compute=
_ring[i]);
> > +     if (!fences && !atomic_read(&adev->gfx.total_submission_cnt)) {
> > +             r =3D amdgpu_dpm_switch_power_profile(adev, profile, fals=
e);
> > +             if (r)
> > +                     dev_warn(adev->dev, "(%d) failed to disable %s po=
wer profile mode\n", r,
> > +                              profile =3D=3D PP_SMC_POWER_PROFILE_FULL=
SCREEN3D ?
> > +                              "fullscreen 3D" : "compute");
> > +     } else {
> > +             schedule_delayed_work(&adev->gfx.idle_work, GFX_PROFILE_I=
DLE_TIMEOUT);
> > +     }
> > +}
> > +
> > +void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
> > +{
> > +     struct amdgpu_device *adev =3D ring->adev;
> > +     enum PP_SMC_POWER_PROFILE profile;
> > +     int r;
> > +
> > +     if (adev->gfx.num_gfx_rings)
> > +             profile =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> > +     else
> > +             profile =3D PP_SMC_POWER_PROFILE_COMPUTE;
> > +
> > +     atomic_inc(&adev->gfx.total_submission_cnt);
> > +
> > +     if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
> > +             r =3D amdgpu_dpm_switch_power_profile(adev, profile, true=
);
> > +             if (r)
> > +                     dev_warn(adev->dev, "(%d) failed to disable %s po=
wer profile mode\n", r,
> > +                              profile =3D=3D PP_SMC_POWER_PROFILE_FULL=
SCREEN3D ?
> > +                              "fullscreen 3D" : "compute");
> > +     }
> > +}
> > +
> > +void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)
> > +{
> > +     atomic_dec(&ring->adev->gfx.total_submission_cnt);
> > +
> > +     schedule_delayed_work(&ring->adev->gfx.idle_work, GFX_PROFILE_IDL=
E_TIMEOUT);
> > +}
> > +
> >  /*
> >   * debugfs for to enable/disable gfx job submission to specific core.
> >   */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.h
> > index 7f9e261f47f11..6c84598caec21 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -57,6 +57,9 @@ enum amdgpu_gfx_pipe_priority {
> >  #define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
> >  #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
> >
> > +/* 1 second timeout */
> > +#define GFX_PROFILE_IDLE_TIMEOUT     msecs_to_jiffies(1000)
> > +
> >  enum amdgpu_gfx_partition {
> >       AMDGPU_SPX_PARTITION_MODE =3D 0,
> >       AMDGPU_DPX_PARTITION_MODE =3D 1,
> > @@ -477,6 +480,9 @@ struct amdgpu_gfx {
> >       bool                            kfd_sch_inactive[MAX_XCP];
> >       unsigned long                   enforce_isolation_jiffies[MAX_XCP=
];
> >       unsigned long                   enforce_isolation_time[MAX_XCP];
> > +
> > +     atomic_t                        total_submission_cnt;
> > +     struct delayed_work             idle_work;
> >  };
> >
> >  struct amdgpu_gfx_ras_reg_entry {
> > @@ -585,6 +591,11 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_=
device *adev,
> >  void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
> >  void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *r=
ing);
> >  void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *rin=
g);
> > +
> > +void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work);
> > +void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring);
> > +void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring);
> > +
> >  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
> >  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev=
);
> >
>
