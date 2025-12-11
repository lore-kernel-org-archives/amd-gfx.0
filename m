Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02A5D41C35
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 13:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D9FF10E81B;
	Thu, 11 Dec 2025 13:46:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bgAjf13N";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F38310E2DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 13:46:38 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-bd2decde440so15681a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 05:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765460798; x=1766065598; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9aIGDeyrIxZvmKTpcZxtD3gnAwpuwiG+I9y7ASCFa0=;
 b=bgAjf13NpNMb0vNf97hURrvARtavhaHmsSu1+hJf2BGMhvyHX58RQckFtGEgjtZLgr
 paTxvArGk/WWwNzsWACmYIGtcwIolTMVe4XcNj/mLh/cN4V0lLzqcJ3fpGHEsg0AKY4L
 0EIeeLUNjkplCWkeZnSdowxlH1KRg2+i4O7i2Pq1be3X4soU7oTRsaDlr3pR0NpZUGON
 Iud/6vzQAY5E1bsL5jaEChEqPPwNnc2kuTjOGeNQylaWZpm+KTRJbRCtPnsnshRJKQM/
 swbIFivupLBjgGk2jwyk5bXjMAis9XTFuqSsjhuB2gywTZpog+nxoK3ef26ZfBd+AOP2
 6qMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765460798; x=1766065598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O9aIGDeyrIxZvmKTpcZxtD3gnAwpuwiG+I9y7ASCFa0=;
 b=TjM95t3sBPrFnj5qk0H/OopE6sfgAb7NblYq2mUQa/ITZF9woMyRkDGLdcSCXTUL4S
 kA3+mP8+eIq/E1662tHGyYoHyEoZISVaYzPnD0ehnGyNjyZL624cLsbsTggich02ZN9j
 /RnwAOKrQXBrQ+dkKuoIknLOJahG5wCkpJysPd5vQV7vsoJxbq7L01XBD+KjNwX49cyP
 PWPruhEChlTWHfESXlQvivLTl2UaR05MBxn0MsNe9XjQEkAs488Mj//adsC3UlMNhNC+
 V7c4Z0+9dp8MO74ALxn17otlRWl23ggKDg2YwcdeL+kH/zlKW1KkJ5/9bee+we7bTVUH
 ostw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUavpAtm1yhan1JURt9KXre+S0vkqZSgVdlMtccrTzSQSjqzz6WN29C+J+aoOJCGMP0uzEZYPUs@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxEGVT65ITobpA643acvkfAX+t9gK4WpEcXXYXADf1hknDRRv+2
 Rm10dbK0JI22e9g0k6NBVFoT0bKWLCsCjL63tNwgo9BqI7Vu2WL9B+Fp8d38n2iUnq0O3V0wfY1
 ihEUkNSe6v42PwA9KqV5i9LTpRFsI9zA=
X-Gm-Gg: AY/fxX42/qBAbTEVxu8imONob2OfyCex9lMAfHeyxdGnKsF8TW36bYjLkoHw9UGGqTw
 /7o+QGs4O/+R2tqsby37P6dgqFjX8hg+I5I0SiB63xWQHT7BUkfFms1K32hav+wE4T0ed+4z1WH
 420voLUQjLbABKJwrlxoK9Hfslv7nEkHbJOcEqRrQ7v3hE4o1Wzb2HSjWouxjCRE2xN+dWIfsR+
 Kf0Za25CFU5H763DihV6rcpyRKMyAoRcOpsXdz1yLgnAs1T4+NioFjDvjjD8EhBD+XthKo=
X-Google-Smtp-Source: AGHT+IGF1ZNoBl/TMctM27cqds6lRHPzbAe/9QTLAgLDfzVhvSgMWLfvDcOOJ6U9T8xfbmS/YHGfMyWMYHJiPgEciqk=
X-Received: by 2002:a05:7300:230a:b0:2a6:cb65:1974 with SMTP id
 5a478bee46e88-2ac1b05b4d6mr1146167eec.1.1765460797557; Thu, 11 Dec 2025
 05:46:37 -0800 (PST)
MIME-Version: 1.0
References: <20251210125740.9551-1-christian.koenig@amd.com>
 <3c90635b46f1a867365fba026edbc28a33ad9d9d.camel@mailbox.org>
 <5f55a311-8924-44cd-af55-c0ccc4d20218@gmail.com>
In-Reply-To: <5f55a311-8924-44cd-af55-c0ccc4d20218@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Dec 2025 08:46:25 -0500
X-Gm-Features: AQt7F2p1Wz3AWWKuTzhYXPbe_H7RBw98shutZCJ_cWFp4zvega-h-GcwwVHx91U
Message-ID: <CADnq5_OBM=E5XPXxFHyR6e4OVWrsa3qrAnqffCrkN9A9mh8eeg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: cache the pasid in amdgpu_device_gpu_recover
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: phasta@kernel.org, alexander.deucher@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
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

On Thu, Dec 11, 2025 at 7:44=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> On 12/10/25 14:00, Philipp Stanner wrote:
> > On Wed, 2025-12-10 at 13:57 +0100, Christian K=C3=B6nig wrote:
> >> The job might already be freed up here. So cache the pasid for later
> >> use.
> >>
> >> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> Suggested-by: Philipp Stanner <phasta@mailbox.org>
> >
> > No! :D
> >
> > You read the wrong quote.
> > Matthew found your issue (in the middle of my time zone's night, while
> > I was peacefully asleep).
>
> Oh, good point. Sorry the credits go to Matthew of course.
>
> >
> >> Fixes: a72002cb181f ("drm/amdgpu: Make use of drm_wedge_task_info")
> >
> > I think there was a gitlab ticket about that a month ago? Could be
> > added to Closes:
>
> Yeah, I remember that as well but I can't find it of hand.
>
> Does anybody have the right link at hand?

I looked for it yesterday, but couldn't find it.

Alex

>
> Thanks,
> Christian.
>
> >
> >
> > P.
> >
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c
> >> index 654f4844b7ad..84bb89498e12 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -6506,8 +6506,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_devi=
ce *adev,
> >>      struct list_head device_list;
> >>      bool job_signaled =3D false;
> >>      struct amdgpu_hive_info *hive =3D NULL;
> >> -    int r =3D 0;
> >>      bool need_emergency_restart =3D false;
> >> +    unsigned int pasid =3D job->pasid;
> >> +    int r =3D 0;
> >>
> >>      /*
> >>       * If it reaches here because of hang/timeout and a RAS error is
> >> @@ -6605,7 +6606,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devi=
ce *adev,
> >>              struct amdgpu_task_info *ti =3D NULL;
> >>
> >>              if (job)
> >> -                    ti =3D amdgpu_vm_get_task_info_pasid(adev, job->p=
asid);
> >> +                    ti =3D amdgpu_vm_get_task_info_pasid(adev, pasid)=
;
> >>
> >>              drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVER=
Y_NONE,
> >>                                   ti ? &ti->task : NULL);
> >
>
