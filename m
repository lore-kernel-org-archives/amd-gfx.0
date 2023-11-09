Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C31C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 22:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A30010E38D;
	Thu,  9 Nov 2023 22:30:52 +0000 (UTC)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1075910E34C
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 22:30:43 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-586beb5e6a7so766293eaf.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Nov 2023 14:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699569042; x=1700173842; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0GJxq/h12yDf80y3OOB67VUasw0FUtytPfVRV7f1ko=;
 b=MJ2tzWtty3kUBbkDifpRW7vpleEkRfhdJbfCeM+0JeVBAJlPs3Lv0QSlB0tl/I/g+S
 5Y0ga3WNyGqjUo9k9rQjQbhJbVq9ib+toqjWPpguBRMEUPX/XjoHK+aEtVA22KMdapo2
 nglsYNQ5lFCcsUcn4ABOBKsuYvrWVyCKyWeXJ6MYqxKAlqHJxwABYjnFTRHVd1L675a1
 Mg3wahXozPYxHmC2q7IEZGxmvFyuExSRguh6klG8fJBduG80tnrhgdKfso+fBb+Mahuc
 I1CrmW0Ef6fJ4dHTu31xGLusbbBaAHiIAk9hDtBuTQR1R1UcI4ZGL+Zsbst/0A3Ryk6x
 zCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699569042; x=1700173842;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0GJxq/h12yDf80y3OOB67VUasw0FUtytPfVRV7f1ko=;
 b=HmiKlmWrRko8zMsZKNxiFkDs/pJaDO4pkmifwuVZm3ZFssjb6KrJ/vID8td0iJ0cv5
 N+amLrDW1ddCGTsPGjm568yeptYE1papAFPY8Ls8+8IHyG1l+RXR7hyA/wcBpoc1141O
 hkVN48mh3eh+ZqnPJH6uKOim/WjQT4nhyTgXlNw9m0+EjmADPGVjcM9rLMglqfbFnapd
 4tB0hmXN2hL0xY/cJqKyP2bwdllpqb2N7qJ0dq9H2jqUyLyjnm7FSJN3s/7tiI1B512E
 9ez1T/1IC2nbdJyQgt/uP9rzTk3dF1YK1MSCvhzDW0lNbKGI0C/GDycV5PcBXyShwIk5
 UphQ==
X-Gm-Message-State: AOJu0YzuTaHL4z7MhkR4j8KsMK0lFe4RMzH3sgIPKSEkCIqPQbVBU3Iz
 8yZGZy6KQeZ4lEf5TXEV/skQUsyuvbAq7ogkxSobCvcX
X-Google-Smtp-Source: AGHT+IGOv273GuA3CR6CdBQ5fYgFF07ITwhJgShSEwuGQS5Ex56r4t0Xr8odKDiys+b7OOPdUc5DyzdGdak9phxGXBE=
X-Received: by 2002:a05:6870:1090:b0:1f0:d96:8d9f with SMTP id
 16-20020a056870109000b001f00d968d9fmr5451454oaq.57.1699569042097; Thu, 09 Nov
 2023 14:30:42 -0800 (PST)
MIME-Version: 1.0
References: <20231108184152.4755-1-alexander.deucher@amd.com>
 <CADnq5_Msooo0n7=hLS9vXL3sn-_AGHaauejkCE+NP-AUuaEJEg@mail.gmail.com>
 <55c7fe4c-b594-4442-971e-3d4adefdb664@gmail.com>
In-Reply-To: <55c7fe4c-b594-4442-971e-3d4adefdb664@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Nov 2023 17:30:30 -0500
Message-ID: <CADnq5_M5O0mWyg3FWrbgbEg9Ng6jFgtjPc9ECpntushdfexMow@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: move UVD and VCE sched entity init after
 sched init
To: Luben Tuikov <ltuikov89@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 9, 2023 at 4:35=E2=80=AFPM Luben Tuikov <ltuikov89@gmail.com> w=
rote:
>
> On 2023-11-09 11:13, Alex Deucher wrote:
> > Ping?
> >
> > On Wed, Nov 8, 2023 at 1:42=E2=80=AFPM Alex Deucher <alexander.deucher@=
amd.com> wrote:
> >>
> >> We need kernel scheduling entities to deal with handle clean up
> >> if apps are not cleaned up properly.  With commit 56e449603f0ac5
> >> ("drm/sched: Convert the GPU scheduler to variable number of run-queue=
s")
> >> the scheduler entities have to be created after scheduler init, so
> >> change the ordering to fix this.
> >>
> >> v2: Leave logic in UVD and VCE code
> >>
> >> Fixes: 56e449603f0ac5 ("drm/sched: Convert the GPU scheduler to variab=
le number of run-queues")
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: ltuikov89@gmail.com
>
> Reviewed-by: Luben Tuikov <ltuikov89@gmail.com>

Thanks Luben!

Alex

>
> Regards,
> Luben
>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c    | 22 ++++++++++----------
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h    |  2 +-
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    | 24 +++++++++++----------=
-
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h    |  2 +-
> >>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c      |  2 --
> >>  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c      |  2 --
> >>  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c      |  2 --
> >>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c      |  2 --
> >>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c      |  4 ----
> >>  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c      |  2 --
> >>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c      |  2 --
> >>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c      |  5 -----
> >>  13 files changed, 37 insertions(+), 46 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c
> >> index 43a95feba884..03e669c34033 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -2499,6 +2499,18 @@ static int amdgpu_device_init_schedulers(struct=
 amdgpu_device *adev)
> >>                                   ring->name);
> >>                         return r;
> >>                 }
> >> +               r =3D amdgpu_uvd_entity_init(adev, ring);
> >> +               if (r) {
> >> +                       DRM_ERROR("Failed to create UVD scheduling ent=
ity on ring %s.\n",
> >> +                                 ring->name);
> >> +                       return r;
> >> +               }
> >> +               r =3D amdgpu_vce_entity_init(adev, ring);
> >> +               if (r) {
> >> +                       DRM_ERROR("Failed to create VCE scheduling ent=
ity on ring %s.\n",
> >> +                                 ring->name);
> >> +                       return r;
> >> +               }
> >>         }
> >>
> >>         amdgpu_xcp_update_partition_sched_list(adev);
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_uvd.c
> >> index 815b7c34ed33..65949cc7abb9 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> >> @@ -399,20 +399,20 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *ade=
v)
> >>   *
> >>   * @adev: amdgpu_device pointer
> >>   *
> >> + * Initialize the entity used for handle management in the kernel dri=
ver.
> >>   */
> >> -int amdgpu_uvd_entity_init(struct amdgpu_device *adev)
> >> +int amdgpu_uvd_entity_init(struct amdgpu_device *adev, struct amdgpu_=
ring *ring)
> >>  {
> >> -       struct amdgpu_ring *ring;
> >> -       struct drm_gpu_scheduler *sched;
> >> -       int r;
> >> +       if (ring =3D=3D &adev->uvd.inst[0].ring) {
> >> +               struct drm_gpu_scheduler *sched =3D &ring->sched;
> >> +               int r;
> >>
> >> -       ring =3D &adev->uvd.inst[0].ring;
> >> -       sched =3D &ring->sched;
> >> -       r =3D drm_sched_entity_init(&adev->uvd.entity, DRM_SCHED_PRIOR=
ITY_NORMAL,
> >> -                                 &sched, 1, NULL);
> >> -       if (r) {
> >> -               DRM_ERROR("Failed setting up UVD kernel entity.\n");
> >> -               return r;
> >> +               r =3D drm_sched_entity_init(&adev->uvd.entity, DRM_SCH=
ED_PRIORITY_NORMAL,
> >> +                                         &sched, 1, NULL);
> >> +               if (r) {
> >> +                       DRM_ERROR("Failed setting up UVD kernel entity=
.\n");
> >> +                       return r;
> >> +               }
> >>         }
> >>
> >>         return 0;
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_uvd.h
> >> index a9f342537c68..9dfad2f48ef4 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> >> @@ -73,7 +73,7 @@ struct amdgpu_uvd {
> >>
> >>  int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
> >>  int amdgpu_uvd_sw_fini(struct amdgpu_device *adev);
> >> -int amdgpu_uvd_entity_init(struct amdgpu_device *adev);
> >> +int amdgpu_uvd_entity_init(struct amdgpu_device *adev, struct amdgpu_=
ring *ring);
> >>  int amdgpu_uvd_prepare_suspend(struct amdgpu_device *adev);
> >>  int amdgpu_uvd_suspend(struct amdgpu_device *adev);
> >>  int amdgpu_uvd_resume(struct amdgpu_device *adev);
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vce.c
> >> index 1904edf68407..0954447f689d 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> >> @@ -231,20 +231,20 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *ade=
v)
> >>   *
> >>   * @adev: amdgpu_device pointer
> >>   *
> >> + * Initialize the entity used for handle management in the kernel dri=
ver.
> >>   */
> >> -int amdgpu_vce_entity_init(struct amdgpu_device *adev)
> >> +int amdgpu_vce_entity_init(struct amdgpu_device *adev, struct amdgpu_=
ring *ring)
> >>  {
> >> -       struct amdgpu_ring *ring;
> >> -       struct drm_gpu_scheduler *sched;
> >> -       int r;
> >> -
> >> -       ring =3D &adev->vce.ring[0];
> >> -       sched =3D &ring->sched;
> >> -       r =3D drm_sched_entity_init(&adev->vce.entity, DRM_SCHED_PRIOR=
ITY_NORMAL,
> >> -                                 &sched, 1, NULL);
> >> -       if (r !=3D 0) {
> >> -               DRM_ERROR("Failed setting up VCE run queue.\n");
> >> -               return r;
> >> +       if (ring =3D=3D &adev->vce.ring[0]) {
> >> +               struct drm_gpu_scheduler *sched =3D &ring->sched;
> >> +               int r;
> >> +
> >> +               r =3D drm_sched_entity_init(&adev->vce.entity, DRM_SCH=
ED_PRIORITY_NORMAL,
> >> +                                         &sched, 1, NULL);
> >> +               if (r !=3D 0) {
> >> +                       DRM_ERROR("Failed setting up VCE run queue.\n"=
);
> >> +                       return r;
> >> +               }
> >>         }
> >>
> >>         return 0;
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vce.h
> >> index ea680fc9a6c3..6e53f872d084 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> >> @@ -55,7 +55,7 @@ struct amdgpu_vce {
> >>
> >>  int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size=
);
> >>  int amdgpu_vce_sw_fini(struct amdgpu_device *adev);
> >> -int amdgpu_vce_entity_init(struct amdgpu_device *adev);
> >> +int amdgpu_vce_entity_init(struct amdgpu_device *adev, struct amdgpu_=
ring *ring);
> >>  int amdgpu_vce_suspend(struct amdgpu_device *adev);
> >>  int amdgpu_vce_resume(struct amdgpu_device *adev);
> >>  void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_f=
ile *filp);
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/a=
md/amdgpu/uvd_v3_1.c
> >> index 58a8f78c003c..a6006f231c65 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> >> @@ -577,8 +577,6 @@ static int uvd_v3_1_sw_init(void *handle)
> >>         ptr +=3D ucode_len;
> >>         memcpy(&adev->uvd.keyselect, ptr, 4);
> >>
> >> -       r =3D amdgpu_uvd_entity_init(adev);
> >> -
> >>         return r;
> >>  }
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/a=
md/amdgpu/uvd_v4_2.c
> >> index d3b1e31f5450..1aa09ad7bbe3 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> >> @@ -127,8 +127,6 @@ static int uvd_v4_2_sw_init(void *handle)
> >>         if (r)
> >>                 return r;
> >>
> >> -       r =3D amdgpu_uvd_entity_init(adev);
> >> -
> >>         return r;
> >>  }
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/a=
md/amdgpu/uvd_v5_0.c
> >> index 5a8116437abf..f8b229b75435 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> >> @@ -125,8 +125,6 @@ static int uvd_v5_0_sw_init(void *handle)
> >>         if (r)
> >>                 return r;
> >>
> >> -       r =3D amdgpu_uvd_entity_init(adev);
> >> -
> >>         return r;
> >>  }
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/uvd_v6_0.c
> >> index 74c09230aeb3..a9a6880f44e3 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> >> @@ -432,8 +432,6 @@ static int uvd_v6_0_sw_init(void *handle)
> >>                 }
> >>         }
> >>
> >> -       r =3D amdgpu_uvd_entity_init(adev);
> >> -
> >>         return r;
> >>  }
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/a=
md/amdgpu/uvd_v7_0.c
> >> index 1c42cf10cc29..6068b784dc69 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> >> @@ -480,10 +480,6 @@ static int uvd_v7_0_sw_init(void *handle)
> >>         if (r)
> >>                 return r;
> >>
> >> -       r =3D amdgpu_uvd_entity_init(adev);
> >> -       if (r)
> >> -               return r;
> >> -
> >>         r =3D amdgpu_virt_alloc_mm_table(adev);
> >>         if (r)
> >>                 return r;
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/a=
md/amdgpu/vce_v2_0.c
> >> index 67eb01fef789..a08e7abca423 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> >> @@ -441,8 +441,6 @@ static int vce_v2_0_sw_init(void *handle)
> >>                         return r;
> >>         }
> >>
> >> -       r =3D amdgpu_vce_entity_init(adev);
> >> -
> >>         return r;
> >>  }
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/a=
md/amdgpu/vce_v3_0.c
> >> index 18f6e62af339..f4760748d349 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> >> @@ -450,8 +450,6 @@ static int vce_v3_0_sw_init(void *handle)
> >>                         return r;
> >>         }
> >>
> >> -       r =3D amdgpu_vce_entity_init(adev);
> >> -
> >>         return r;
> >>  }
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/a=
md/amdgpu/vce_v4_0.c
> >> index e0b70cd3b697..06d787385ad4 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> >> @@ -486,11 +486,6 @@ static int vce_v4_0_sw_init(void *handle)
> >>                         return r;
> >>         }
> >>
> >> -
> >> -       r =3D amdgpu_vce_entity_init(adev);
> >> -       if (r)
> >> -               return r;
> >> -
> >>         r =3D amdgpu_virt_alloc_mm_table(adev);
> >>         if (r)
> >>                 return r;
> >> --
> >> 2.41.0
> >>
