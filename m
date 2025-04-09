Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1732CC36002
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 14:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91CC810E913;
	Wed,  9 Apr 2025 14:43:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B0ehFggv";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DC6B10E913
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 14:43:00 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-227e29b6c55so6680185ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Apr 2025 07:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744209780; x=1744814580; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c4KY3Kcpsi0pF5CJ2lYhDxLZG7qwTA0OcKy6JzPMJzs=;
 b=B0ehFggvOHoQl7LSz6bZ33fAkxfarKeWxFhYK9YlLaLxQ/PQDZScsURAaa1N8SHscY
 C0TreXAaZwHwbRgjDdKj8Iq2fmxg56dpHng8ba5fi/AYTNTHMLsH2kMPIib7OWfkGetn
 Yt+HbRvCc1HlDu0xmbQtuOylkUUdk7FqbBCNSn8bIRNlPjMbLkH0rpMiXJyK+KhwIy6B
 /0cGqsm6tiwRNZSqjOKD+FPl5QGPOWc5QSInxRQlF1bP/j+QoDzWHlNnT7AOMrdzPDW/
 cwt5p8qcdf5hJC917adjxMyvEDZwWfUJhqdw22pLv47zjxGiOmNZWkDZ77OS059WE4Vm
 ebMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744209780; x=1744814580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c4KY3Kcpsi0pF5CJ2lYhDxLZG7qwTA0OcKy6JzPMJzs=;
 b=WYQ5vvoNSd/5WODu3BEu09LVh9oUZlB8bdP2znHECOKurDmiLwhmlK+jC6Jsck2OyM
 Y167OdnNPG2Bk1bYYeK/PuUTCAf6yIx8OaoYCVR2UJVCFbPgaQ7PXlKo98GHDVhfyg8+
 9Zm1RiKNAGMVYaLYxig1f9mLWKkUo9bVCxfl9kGq8MlTvisSD95FNJsFP9OpAnebcHnN
 /lYiNwQeoNTAper9jOSPBafOHatt5mEkawhaEGvB/8KjzPyXbNfQ8LdRkn9jlhaxnV6Z
 gM0kezjtRD1MXmRwIP8ukspdqv622krqZABYxnzyIM575r/sy0j/aX0W/eAe6Qvpb/c7
 e3kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW93rAjgDJuvHZNoE6Z9zrYmIrfbdoA825xCzlAAyMtE7JKSZHMKDaVDCyepefoMLj6JZIz8TAx@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxuHDn5vvN+MNjUhoq6HE2w8ipLv/SgiVUZeGGPBjxSRpXLyv2O
 O/IO3Vjp/uT5IjGPgWcyGyLyr5PGdeIVY3+SuJrsOBvqbZ/sZcaeW+mkrMH8e0bp6E0hUbzE41q
 kqdkjza6kznyUI+HqQKSoEsIHHGw=
X-Gm-Gg: ASbGncvfZROIryjHwDp3H/jBCifQkv+7zcaH1QjO3WX+6iY15x+U5p/vhGI1EA7z9Mv
 a9hMJEhvoBXK4PzRca6897Xk0LVFQaxIGdzKFmrga9BsKY4GghDznje2zQHhjs3rp0yt7ct88QB
 GZrMamvxSYoxMM9OPt+BhidiYIGi+GzjHm
X-Google-Smtp-Source: AGHT+IEm6/kQoQgCxNAE+/mKLGMuAeUPdVG1Tfs1wu2aIc42JgT2vZwV9bTkDKeaf+mRQoV/USgAuR9fCxwbJmc0dUk=
X-Received: by 2002:a17:902:f60f:b0:223:5696:44d6 with SMTP id
 d9443c01a7336-22ac2c2f69amr19309245ad.12.1744209779704; Wed, 09 Apr 2025
 07:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250408160000.3149409-1-alexander.deucher@amd.com>
 <20250408160000.3149409-3-alexander.deucher@amd.com>
 <243270dd-f7a6-4eee-a5c7-904085b25472@amd.com>
In-Reply-To: <243270dd-f7a6-4eee-a5c7-904085b25472@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Apr 2025 10:42:47 -0400
X-Gm-Features: ATxdqUHgirWjBL4YKXd5BxIBuocejRuTGPUg2DjcB20MHovtzYuM6b8OqsmpGEI
Message-ID: <CADnq5_MY9wi9ytZ1xhVoauQHVrEDGsO3xyH=9PyJRwPafooqSQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: adjust enforce_isolation handling
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
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

On Wed, Apr 9, 2025 at 10:36=E2=80=AFAM SRINIVASAN SHANMUGAM
<srinivasan.shanmugam@amd.com> wrote:
>
>
> On 4/8/2025 9:30 PM, Alex Deucher wrote:
> > Switch from a bool to an enum and allow more options
> > for enforce isolation.  There are now 3 modes of operation:
> > - Disabled (0)
> > - Enabled (serialization and cleaner shader) (1)
> > - Enabled in legacy mode (no serialization or cleaner shader) (2)
> > This provides better flexibility for more use cases.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 11 +++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        | 16 +++++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 22 ++++++++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 12 +++---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 39 ++++++++++++++----=
-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c       |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h       |  1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  3 +-
> >   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  2 +-
> >   .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 11 +++---
> >   12 files changed, 93 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index 804d377037095..468c6ce09e3ef 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -230,7 +230,7 @@ extern int amdgpu_force_asic_type;
> >   extern int amdgpu_smartshift_bias;
> >   extern int amdgpu_use_xgmi_p2p;
> >   extern int amdgpu_mtype_local;
> > -extern bool enforce_isolation;
> > +extern int amdgpu_enforce_isolation;
> >   #ifdef CONFIG_HSA_AMD
> >   extern int sched_policy;
> >   extern bool debug_evictions;
> > @@ -873,6 +873,13 @@ struct amdgpu_init_level {
> >   struct amdgpu_reset_domain;
> >   struct amdgpu_fru_info;
> >
> > +enum amdgpu_enforce_isolation_mode {
> > +     AMDGPU_ENFORCE_ISOLATION_DISABLE =3D 0,
> > +     AMDGPU_ENFORCE_ISOLATION_ENABLE =3D 1,
> > +     AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY =3D 2,
> > +};
> > +
> > +
> >   /*
> >    * Non-zero (true) if the GPU has VRAM. Zero (false) otherwise.
> >    */
> > @@ -1224,7 +1231,7 @@ struct amdgpu_device {
> >
> >       /* Protection for the following isolation structure */
> >       struct mutex                    enforce_isolation_mutex;
> > -     bool                            enforce_isolation[MAX_XCP];
> > +     enum amdgpu_enforce_isolation_mode      enforce_isolation[MAX_XCP=
];
> >       struct amdgpu_isolation {
> >               void                    *owner;
> >               struct dma_fence        *spearhead;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index 4a5cd7a111fc4..34a688fc5bf35 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -296,7 +296,21 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser=
 *p,
> >                                      num_ibs[i], &p->jobs[i]);
> >               if (ret)
> >                       goto free_all_kdata;
> > -             p->jobs[i]->enforce_isolation =3D p->adev->enforce_isolat=
ion[fpriv->xcp_id];
> > +             switch (p->adev->enforce_isolation[fpriv->xcp_id]) {
> > +             case AMDGPU_ENFORCE_ISOLATION_DISABLE:
> > +             default:
> > +                     p->jobs[i]->enforce_isolation =3D false;
> > +                     p->jobs[i]->run_cleaner_shader =3D false;
> > +                     break;
> > +             case AMDGPU_ENFORCE_ISOLATION_ENABLE:
> > +                     p->jobs[i]->enforce_isolation =3D true;
> > +                     p->jobs[i]->run_cleaner_shader =3D true;
> > +                     break;
> > +             case AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY:
> > +                     p->jobs[i]->enforce_isolation =3D true;
> > +                     p->jobs[i]->run_cleaner_shader =3D false;
>
>
> Hi Alex,
>
> Even for legacy enforce_isolation, just to double check, we expect
> cleaner shader to run, cz by default when we trigger modprobe amdgpu
> enforce_isolation =3D 1, for this usecase, we expect cleaner shader to be
> triggered that means legacy , am I correct pls?

The idea is that this option brings back the enforce isolation
behavior prior to adding the cleaner shader functionality if you
select 2.  So no cleaner shader and no serialization with KFD; just
serialization within KFD.  So:
0 - enforce isolation disabled
1 - enable serialization between KFD and KGD and within KFD and KGD,
cleaner shader between processes
2 - enable serialization within KGD (the original enforce isolation behavio=
r)

Alex

>
> Best regards,
> Srini
>
>
> > +                     break;
> > +             }
> >       }
> >       p->gang_leader =3D p->jobs[p->gang_leader_idx];
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 8b43f350447a9..700304bbe3982 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2115,8 +2115,26 @@ static int amdgpu_device_check_arguments(struct =
amdgpu_device *adev)
> >
> >       adev->firmware.load_type =3D amdgpu_ucode_get_load_type(adev, amd=
gpu_fw_load_type);
> >
> > -     for (i =3D 0; i < MAX_XCP; i++)
> > -             adev->enforce_isolation[i] =3D !!enforce_isolation;
> > +     for (i =3D 0; i < MAX_XCP; i++) {
> > +             switch (amdgpu_enforce_isolation) {
> > +             case -1:
> > +             case 0:
> > +             default:
> > +                     /* disable */
> > +                     adev->enforce_isolation[i] =3D AMDGPU_ENFORCE_ISO=
LATION_DISABLE;
> > +                     break;
> > +             case 1:
> > +                     /* enable */
> > +                     adev->enforce_isolation[i] =3D
> > +                             AMDGPU_ENFORCE_ISOLATION_ENABLE;
> > +                     break;
> > +             case 2:
> > +                     /* enable legacy mode */
> > +                     adev->enforce_isolation[i] =3D
> > +                             AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
> > +                     break;
> > +             }
> > +     }
> >
> >       return 0;
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index d7b27b7a0d519..5132003d85a29 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -179,7 +179,7 @@ uint amdgpu_pg_mask =3D 0xffffffff;
> >   uint amdgpu_sdma_phase_quantum =3D 32;
> >   char *amdgpu_disable_cu;
> >   char *amdgpu_virtual_display;
> > -bool enforce_isolation;
> > +int amdgpu_enforce_isolation =3D -1;
> >   int amdgpu_modeset =3D -1;
> >
> >   /* Specifies the default granularity for SVM, used in buffer
> > @@ -1038,11 +1038,13 @@ module_param_named(user_partt_mode, amdgpu_user=
_partt_mode, uint, 0444);
> >
> >
> >   /**
> > - * DOC: enforce_isolation (bool)
> > - * enforce process isolation between graphics and compute via using th=
e same reserved vmid.
> > + * DOC: enforce_isolation (int)
> > + * enforce process isolation between graphics and compute.
> > + * (-1 =3D auto, 0 =3D disable, 1 =3D enable, 2 =3D enable legacy mode=
)
> >    */
> > -module_param(enforce_isolation, bool, 0444);
> > -MODULE_PARM_DESC(enforce_isolation, "enforce process isolation between=
 graphics and compute . enforce_isolation =3D on");
> > +module_param_named(enforce_isolation, amdgpu_enforce_isolation, int, 0=
444);
> > +MODULE_PARM_DESC(enforce_isolation,
> > +"enforce process isolation between graphics and compute. (-1 =3D auto,=
 0 =3D disable, 1 =3D enable, 2 =3D enable legacy mode)");
> >
> >   /**
> >    * DOC: modeset (int)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.c
> > index ff53401aae5a4..9b4272fbc470c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -1460,6 +1460,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(stru=
ct amdgpu_ring *ring)
> >               goto err;
> >
> >       job->enforce_isolation =3D true;
> > +     /* always run the cleaner shader */
> > +     job->run_cleaner_shader =3D true;
> >
> >       ib =3D &job->ibs[0];
> >       for (i =3D 0; i <=3D ring->funcs->align_mask; ++i)
> > @@ -1591,7 +1593,7 @@ static ssize_t amdgpu_gfx_set_run_cleaner_shader(=
struct device *dev,
> >    * Provides the sysfs read interface to get the current settings of t=
he 'enforce_isolation'
> >    * feature for each GPU partition. Reading from the 'enforce_isolatio=
n'
> >    * sysfs file returns the isolation settings for all partitions, wher=
e '0'
> > - * indicates disabled and '1' indicates enabled.
> > + * indicates disabled, '1' indicates enabled, and '2' indicates enable=
d in legacy mode.
> >    *
> >    * Return: The number of bytes read from the sysfs file.
> >    */
> > @@ -1626,9 +1628,10 @@ static ssize_t amdgpu_gfx_get_enforce_isolation(=
struct device *dev,
> >    * @count: The size of the input data
> >    *
> >    * This function allows control over the 'enforce_isolation' feature,=
 which
> > - * serializes access to the graphics engine. Writing '1' or '0' to the
> > - * 'enforce_isolation' sysfs file enables or disables process isolatio=
n for
> > - * each partition. The input should specify the setting for all partit=
ions.
> > + * serializes access to the graphics engine. Writing '1', '2', or '0' =
to the
> > + * 'enforce_isolation' sysfs file enables (full or legacy) or disables=
 process
> > + * isolation for each partition. The input should specify the setting =
for all
> > + * partitions.
> >    *
> >    * Return: The number of bytes written to the sysfs file.
> >    */
> > @@ -1665,13 +1668,29 @@ static ssize_t amdgpu_gfx_set_enforce_isolation=
(struct device *dev,
> >               return -EINVAL;
> >
> >       for (i =3D 0; i < num_partitions; i++) {
> > -             if (partition_values[i] !=3D 0 && partition_values[i] !=
=3D 1)
> > +             if (partition_values[i] !=3D 0 &&
> > +                 partition_values[i] !=3D 1 &&
> > +                 partition_values[i] !=3D 2)
> >                       return -EINVAL;
> >       }
> >
> >       mutex_lock(&adev->enforce_isolation_mutex);
> > -     for (i =3D 0; i < num_partitions; i++)
> > -             adev->enforce_isolation[i] =3D partition_values[i];
> > +     for (i =3D 0; i < num_partitions; i++) {
> > +             switch (partition_values[i]) {
> > +             case 0:
> > +             default:
> > +                     adev->enforce_isolation[i] =3D AMDGPU_ENFORCE_ISO=
LATION_DISABLE;
> > +                     break;
> > +             case 1:
> > +                     adev->enforce_isolation[i] =3D
> > +                             AMDGPU_ENFORCE_ISOLATION_ENABLE;
> > +                     break;
> > +             case 2:
> > +                     adev->enforce_isolation[i] =3D
> > +                             AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
> > +                     break;
> > +             }
> > +     }
> >       mutex_unlock(&adev->enforce_isolation_mutex);
> >
> >       amdgpu_mes_update_enforce_isolation(adev);
> > @@ -2026,7 +2045,7 @@ amdgpu_gfx_enforce_isolation_wait_for_kfd(struct =
amdgpu_device *adev,
> >       bool wait =3D false;
> >
> >       mutex_lock(&adev->enforce_isolation_mutex);
> > -     if (adev->enforce_isolation[idx]) {
> > +     if (adev->enforce_isolation[idx] =3D=3D AMDGPU_ENFORCE_ISOLATION_=
ENABLE) {
> >               /* set the initial values if nothing is set */
> >               if (!adev->gfx.enforce_isolation_jiffies[idx]) {
> >                       adev->gfx.enforce_isolation_jiffies[idx] =3D jiff=
ies;
> > @@ -2093,7 +2112,7 @@ void amdgpu_gfx_enforce_isolation_ring_begin_use(=
struct amdgpu_ring *ring)
> >       amdgpu_gfx_enforce_isolation_wait_for_kfd(adev, idx);
> >
> >       mutex_lock(&adev->enforce_isolation_mutex);
> > -     if (adev->enforce_isolation[idx]) {
> > +     if (adev->enforce_isolation[idx] =3D=3D AMDGPU_ENFORCE_ISOLATION_=
ENABLE) {
> >               if (adev->kfd.init_complete)
> >                       sched_work =3D true;
> >       }
> > @@ -2130,7 +2149,7 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(st=
ruct amdgpu_ring *ring)
> >               return;
> >
> >       mutex_lock(&adev->enforce_isolation_mutex);
> > -     if (adev->enforce_isolation[idx]) {
> > +     if (adev->enforce_isolation[idx] =3D=3D AMDGPU_ENFORCE_ISOLATION_=
ENABLE) {
> >               if (adev->kfd.init_complete)
> >                       sched_work =3D true;
> >       }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ids.c
> > index 4c4e087230ac5..359c19de9a5b9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> > @@ -588,7 +588,7 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *ade=
v)
> >       }
> >       /* alloc a default reserved vmid to enforce isolation */
> >       for (i =3D 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcps : 1); =
i++) {
> > -             if (adev->enforce_isolation[i])
> > +             if (adev->enforce_isolation[i] !=3D AMDGPU_ENFORCE_ISOLAT=
ION_DISABLE)
> >                       amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i)=
);
> >       }
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.h
> > index ce6b9ba967fff..f2c049129661f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> > @@ -78,6 +78,7 @@ struct amdgpu_job {
> >
> >       /* enforce isolation */
> >       bool                    enforce_isolation;
> > +     bool                    run_cleaner_shader;
> >
> >       uint32_t                num_ibs;
> >       struct amdgpu_ib        ibs[];
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_mes.c
> > index 36f2e87161264..38ea64d87a0ac 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > @@ -768,7 +768,7 @@ int amdgpu_mes_update_enforce_isolation(struct amdg=
pu_device *adev)
> >       if (adev->enable_mes && adev->gfx.enable_cleaner_shader) {
> >               mutex_lock(&adev->enforce_isolation_mutex);
> >               for (i =3D 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcp=
s : 1); i++) {
> > -                     if (adev->enforce_isolation[i])
> > +                     if (adev->enforce_isolation[i] =3D=3D AMDGPU_ENFO=
RCE_ISOLATION_ENABLE)
> >                               r |=3D amdgpu_mes_set_enforce_isolation(a=
dev, i, true);
> >                       else
> >                               r |=3D amdgpu_mes_set_enforce_isolation(a=
dev, i, false);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index b5ddfcbbc9fc9..dadf6715b98be 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -676,7 +676,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struc=
t amdgpu_job *job,
> >       pasid_mapping_needed &=3D adev->gmc.gmc_funcs->emit_pasid_mapping=
 &&
> >               ring->funcs->emit_wreg;
> >
> > -     cleaner_shader_needed =3D adev->gfx.enable_cleaner_shader &&
> > +     cleaner_shader_needed =3D job->run_cleaner_shader &&
> > +             adev->gfx.enable_cleaner_shader &&
> >               ring->funcs->emit_cleaner_shader && job->base.s_fence &&
> >               &job->base.s_fence->scheduled =3D=3D isolation->spearhead=
;
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/mes_v11_0.c
> > index 344d32268c3cd..f7aa45775eadb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > @@ -724,7 +724,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu=
_mes *mes)
> >                                       mes->event_log_gpu_addr;
> >       }
> >
> > -     if (adev->enforce_isolation[0])
> > +     if (adev->enforce_isolation[0] =3D=3D AMDGPU_ENFORCE_ISOLATION_EN=
ABLE)
> >               mes_set_hw_res_pkt.limit_single_process =3D 1;
> >
> >       return mes_v11_0_submit_pkt_and_poll_completion(mes,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/a=
md/amdgpu/mes_v12_0.c
> > index be43e19b7b7fa..b0e042a4cea19 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > @@ -762,7 +762,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu=
_mes *mes, int pipe)
> >                               pipe * (AMDGPU_MES_LOG_BUFFER_SIZE + AMDG=
PU_MES_MSCRATCH_SIZE);
> >       }
> >
> > -     if (adev->enforce_isolation[0])
> > +     if (adev->enforce_isolation[0] =3D=3D AMDGPU_ENFORCE_ISOLATION_EN=
ABLE)
> >               mes_set_hw_res_pkt.limit_single_process =3D 1;
> >
> >       return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> > index 2893fd5e5d003..fa28c57692b86 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> > @@ -43,7 +43,7 @@ static int pm_map_process_v9(struct packet_manager *p=
m,
> >       memset(buffer, 0, sizeof(struct pm4_mes_map_process));
> >       packet->header.u32All =3D pm_build_pm4_header(IT_MAP_PROCESS,
> >                                       sizeof(struct pm4_mes_map_process=
));
> > -     if (adev->enforce_isolation[kfd->node_id])
> > +     if (adev->enforce_isolation[kfd->node_id] =3D=3D AMDGPU_ENFORCE_I=
SOLATION_ENABLE)
> >               packet->bitfields2.exec_cleaner_shader =3D 1;
> >       packet->bitfields2.diq_enable =3D (qpd->is_debug) ? 1 : 0;
> >       packet->bitfields2.process_quantum =3D 10;
> > @@ -102,7 +102,8 @@ static int pm_map_process_aldebaran(struct packet_m=
anager *pm,
> >       memset(buffer, 0, sizeof(struct pm4_mes_map_process_aldebaran));
> >       packet->header.u32All =3D pm_build_pm4_header(IT_MAP_PROCESS,
> >                       sizeof(struct pm4_mes_map_process_aldebaran));
> > -     if (adev->enforce_isolation[knode->node_id])
> > +     if (adev->enforce_isolation[knode->node_id] =3D=3D
> > +         AMDGPU_ENFORCE_ISOLATION_ENABLE)
> >               packet->bitfields2.exec_cleaner_shader =3D 1;
> >       packet->bitfields2.diq_enable =3D (qpd->is_debug) ? 1 : 0;
> >       packet->bitfields2.process_quantum =3D 10;
> > @@ -165,9 +166,9 @@ static int pm_runlist_v9(struct packet_manager *pm,=
 uint32_t *buffer,
> >        * hws_max_conc_proc has been done in
> >        * kgd2kfd_device_init().
> >        */
> > -     concurrent_proc_cnt =3D adev->enforce_isolation[kfd->node_id] ?
> > -                     1 : min(pm->dqm->processes_count,
> > -                     kfd->max_proc_per_quantum);
> > +     concurrent_proc_cnt =3D (adev->enforce_isolation[kfd->node_id] =
=3D=3D
> > +                            AMDGPU_ENFORCE_ISOLATION_ENABLE) ?
> > +             1 : min(pm->dqm->processes_count, kfd->max_proc_per_quant=
um);
> >
> >       packet =3D (struct pm4_mes_runlist *)buffer;
> >
