Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC63E8B39F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 14:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60EE410E8D8;
	Thu,  5 Feb 2026 14:27:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lw8kl5QV";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F20510E8DF
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 14:27:01 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2b7063004daso62829eec.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 06:27:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770301620; cv=none;
 d=google.com; s=arc-20240605;
 b=fxAlycMJgwsV+/S+bvZ1NKvoNrcy2lPNhKc+podVFRHzOX4IodPGzoO8qoO1yWg5vu
 BTIo1+8asQMbCQvj0MLM6lDTj3FYMR8BekiPWitckKBcx2JDqDXzH8NrUnvlIgzbWZ9T
 qeFKCvyzelGWiJDGmKokK6OOT/NFgkbBW+njay2wSbUFOPOwiA4Y46+7OOYzjnviWX4S
 YM068hw0nwo0kiHD6+dXoLIBd8Dk2P0rbvUTv3jLvsZxR4YYyi8b0Lbl5C/jMtlAxtSM
 64YKNY3/C2dKuLX6wkfQIG5xGbrLaLsF3mq9P++VLlWO1E6DieUi2ZNvanesSEFsX/a1
 5vMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4kSDafBZ1O/nQaOVSNkX//AcWlMkPj7ag9VdKFas3Ks=;
 fh=K//1aK5LZgOCO+CyER79iCj5Rc9c0535pVdVr8xjXFo=;
 b=Zawn7MMxztb2rAKDFx38/G+Cap39DGv6KEcSSS2waqINri3YPUM27b9jKMvYwEcWLH
 U8D4EQO6UoKzObfLUAh1bgqbgysk1RmAHR7T+Voj3PkGzkR9EIbPa8wyPABYJDJ7F2Zl
 pM3/W9UbZaS4kYO4WPfDtetahx5y7fcui9A3pjX8bBRZg2IIC/+kXFpgW4jTf+NKhVk2
 XRmz71MzXqXos3a2OSXFtVLs6wLa9w5qEZu0VZovVB9Tm3iAr/WHXZiVifVn4uKTHpnt
 CmLp7M+KhtFFedENdQ19l8K5r2Pr7gFcikKYrnfrqhnYNuZRXUDG/SDkvpdj8ZJ/UJl0
 y0yA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770301620; x=1770906420; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4kSDafBZ1O/nQaOVSNkX//AcWlMkPj7ag9VdKFas3Ks=;
 b=Lw8kl5QVOydhaEzfu8IbCYBj7caaOrYDpeOY5NqxznluW6fBUEHGzHbHiu9IsRMOqk
 1WSJF9Mq8uGA+q/uD0BX1ftmJKq8LjjVzoLpAncmLwHiCsHW6Ju2oqZRaD7Vxc3a9Etv
 CeUYOdfaAAbOX7EN8E31boMJx7omucigf77YSwcHrw6tD9xD49FjdGDnENU/KvbEikkl
 umcoYKhE0AF471QtvAXYUFRzDRyq2ShPymQGikWWBZYnTjl6FQ3d0s+pmY+/YKVgXULv
 5SSxLUqBL37gbTVPQhwhuAlsClNYRqUFf+IkO5GE4Mj92ACWS2dQnTcYxcW4UR1UUXOx
 ruNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770301620; x=1770906420;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4kSDafBZ1O/nQaOVSNkX//AcWlMkPj7ag9VdKFas3Ks=;
 b=G2mXqL/KzJ8tZP1Axt/hxshIpY6TY2MEsvSauVGqNI39FYRfgS0xoK1LNwj5nQnAnv
 UYmKzUY2a0BQdD9JXEHWl2H5sqUtZ1Rh1EDGgznRz7aFK1a4T1MzsmmDVfQ0tDKTjvK6
 a31DWEh7VWalFjeXQy4QcNymzvZaYeg/uRe8alG+y6WcKROsTnmq/ffqrDAHfEQkwUSO
 yxjC1vurNT8nCPzv1NvYJwy0+NG4+oqoO8yDdkJBjeSvJrQCEJbI1PGQ1EF1UQh2No37
 2w5X9HNABMx5czI1+jUznzglK5QI74sqvb5ESMrNWXN/6PjQ4qhe659E2+tsYLWdhB97
 gR+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBs/hfJbxNdgBNcYN6+IavCfWz8zOPr9J+yQNgMXVbm/9v50RqucNniem5QKNs9FD31Jm3re3r@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz04Q8p61TAz0v4+YLR2wcH4fzELyvIga/2TDc1eXG8mPra7Uhc
 NJu9CQ5z6RoUlthcbrn4OWsnMz18jDSSS+ilkYmPGiBGPRnyOZAc2UGk9hEyAl4FulZiH/q449A
 4vCcz0yoxJL6W3pLXuPOIEYqwvb61dLc=
X-Gm-Gg: AZuq6aLzvrMUMyC++LNdUIs6If5Dcmqpt/tyxeG8jYDTNBRVyb8fAOV85G9QAyBp1id
 bb+El9KbGWZEEJ5Ci/1ThmjAMDXMSNh2TbvTTlrpmf9BFOOLtN82ZzaHNrNtyCsMv/9u5JySSVN
 FLwrswjidV9H2jA/eqXRj0l2QymLMJ4eDMyIGqZncPp/XmdL6qkCPwWRBeSY3NZfTjhoeoJY2ux
 0jKehnmTRWukG39Td7vgGK9XwvubQzkj87VS7v1RXmyYBarj2SSWpBXotNS+5zuoa9nqeuZ
X-Received: by 2002:a05:7022:2386:b0:11e:332:1e01 with SMTP id
 a92af1059eb24-126f47c9c62mr1308449c88.3.1770301620331; Thu, 05 Feb 2026
 06:27:00 -0800 (PST)
MIME-Version: 1.0
References: <20260130173042.15008-1-alexander.deucher@amd.com>
 <20260130173042.15008-6-alexander.deucher@amd.com>
 <937673e3-36a0-4ff0-a76d-c63a34885184@damsy.net>
In-Reply-To: <937673e3-36a0-4ff0-a76d-c63a34885184@damsy.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Feb 2026 09:26:48 -0500
X-Gm-Features: AZwV_QjDvUyqutQhbfuihu5NqHTIhQT6QH7WMV1uNwtvQO_VIl2FQcbFNVkCkbE
Message-ID: <CADnq5_OoDPEy2PM5YUmOWU8k8rLk9UBD88oU5rCndh=Hovcu_Q@mail.gmail.com>
Subject: Re: [PATCH 05/12] drm/amdgpu: don't call drm_sched_stop/start() in
 asic reset
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com
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

On Thu, Feb 5, 2026 at 9:22=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric@damsy.net> wrote:
>
>
>
> Le 30/01/2026 =C3=A0 18:30, Alex Deucher a =C3=A9crit :
> > We only want to stop the work queues, not mess with the
> > fences, etc.
> >
> > v2: add the job back to the pending list.
> > v3: return the proper job status so scheduler adds the
> >      job back to the pending list
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 6 ++----
> >   2 files changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index e69ab8a923e31..a5b43d57c7b05 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -6313,7 +6313,7 @@ static void amdgpu_device_halt_activities(struct =
amdgpu_device *adev,
> >                       if (!amdgpu_ring_sched_ready(ring))
> >                               continue;
> >
> > -                     drm_sched_stop(&ring->sched, job ? &job->base : N=
ULL);
> > +                     drm_sched_wqueue_stop(&ring->sched);
> >
> >                       if (need_emergency_restart)
> >                               amdgpu_job_stop_all_jobs_on_sched(&ring->=
sched);
> > @@ -6397,7 +6397,7 @@ static int amdgpu_device_sched_resume(struct list=
_head *device_list,
> >                       if (!amdgpu_ring_sched_ready(ring))
> >                               continue;
> >
> > -                     drm_sched_start(&ring->sched, 0);
> > +                     drm_sched_wqueue_start(&ring->sched);
> >               }
> >
> >               if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) &=
& !job_signaled)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.c
> > index df06a271bdf99..cd0707737a29b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -92,7 +92,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
> >       struct drm_wedge_task_info *info =3D NULL;
> >       struct amdgpu_task_info *ti =3D NULL;
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     enum drm_gpu_sched_stat status =3D DRM_GPU_SCHED_STAT_RESET;
> >       int idx, r;
> >
> >       if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
> > @@ -147,8 +146,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(=
struct drm_sched_job *s_job)
> >                               ring->sched.name);
> >                       drm_dev_wedged_event(adev_to_drm(adev),
> >                                            DRM_WEDGE_RECOVERY_NONE, inf=
o);
> > -                     /* This is needed to add the job back to the pend=
ing list */
> > -                     status =3D DRM_GPU_SCHED_STAT_NO_HANG;
> >                       goto exit;
> >               }
> >               dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.=
name);
> > @@ -184,7 +181,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(=
struct drm_sched_job *s_job)
> >   exit:
> >       amdgpu_vm_put_task_info(ti);
> >       drm_dev_exit(idx);
> > -     return status;
> > +     /* This is needed to add the job back to the pending list */
> > +     return DRM_GPU_SCHED_STAT_NO_HANG;
>
> This part seems unrelated to the patch and is overwriting what was done
> in patch 1/12.

Patch 1 fixes the pending list handling for per queue resets.  This
patch reworks the adapter reset path to match the behavior of the per
queue reset path.  After this patch they match so we can safely return
DRM_GPU_SCHED_STAT_NO_HANG in both cases.  Previously the adapter
reset path called drm_sched_wqueue_stop()/start() which handles
re-adding the job to the pending list.  Since it no longer does, we
need to return DRM_GPU_SCHED_STAT_NO_HANG for both cases.

Alex

>
> Pierre-Eric
>
>
> >   }
> >
> >   int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm=
,
