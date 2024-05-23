Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A991C25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 18:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AACAC10E125;
	Thu, 23 May 2024 18:15:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kObxPAoK";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD2CD10E125
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 18:15:00 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-6818811cb8aso46372a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 11:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716488100; x=1717092900; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HgKqByU7iBjPUSGCJuxEqNypmyT8ednvHoTtn98SBKw=;
 b=kObxPAoK+C+nuSwszre9SUfds/e/8Dr6KMdLINTT7A5PCSa8tbnSMt8H0IQPurn5TG
 nAm3fPimxOGShJZEsXPz8yZrj6YLJr1EGLDL/R4eRYF++5rGJ6sYBmSw60gWGDHOCZNc
 oy0IVfJ6dq/RMg886jWgcrKvd9HJ3OfqAUjnpwiPHv/jYwkqvnTHHpCgDek/Rms/655g
 4Zow5viCrOYIdTvQSswKFqCPVx+NNQEuDb6Q0KpYNBp4ITJxfuyubRUYtqp9llPUiFYe
 6Ys1KQQEOUu6PDl0HprMPnj+AEBvbSs2QgQMWSDy7wlhicETle6YfetKH8CvEs4uaYlB
 aHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716488100; x=1717092900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HgKqByU7iBjPUSGCJuxEqNypmyT8ednvHoTtn98SBKw=;
 b=XHMqG6B5x1v3fqWAQ5sNtJZoXDyQ55qb/89HZ7DDnho5fFMO+KJIYeUT+pwI8z78i6
 Sljj0+AicCLIHZhhE6OQpBW0n08iEEYCABiMoAr8YP4oXl0OTTMSU3IwOVXhaiHN36Nj
 nUuIr0FggbB3xusE+jiXWrSSLC/6TdVbze7wuFUOGkzrgpXurgjdih5oKbFIdOo4Tcxi
 rSaYSMWXqd0tpfUUkr287uUNHUWXWng/SFJoeBPasUKCcV8NyEPs1gpFGksJhfyppa86
 JkHigXj1l28gcaOTTdlqqa0yz07wcNc/8zgMQFjah/4aQIXE7TOKX8ikH0P5SLp+TMLF
 0xqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmUaq8dQowTlh0v7pTId4dAZi6/DeBAOrY+WgROAHcZ+8bQVCYmZ9CNNRPl/Xh1KCI+rv+AXUOhul3lxnr1elisMaolErZJgjGPiQmqA==
X-Gm-Message-State: AOJu0YzvoeKQLzHdqu1LO4sfPToZj4Y1t9PHfc4xk+Z6YFa6/ycZpae4
 gWl0ZcuBqy7seprJqM00oxW6Tt8OZNZcyCfA54L5ZLApxz3THs5OnKk8E4284fXqP3c0Nwm07hx
 r2eDQxNkJCzWPdfy9i7l5QggysEk=
X-Google-Smtp-Source: AGHT+IEhNgo/3czwTfowf+qqhQpxkSTr7noiCKz4uVROGDpm71gODl85J1sNfrL32VjMPapa6n/lQ8SIG2u0HJwh2pA=
X-Received: by 2002:a17:90a:51e5:b0:2a0:86b6:2e9 with SMTP id
 98e67ed59e1d1-2bd9f4895acmr5379717a91.12.1716488100140; Thu, 23 May 2024
 11:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240522172721.14085-1-Yunxiang.Li@amd.com>
 <20240522172721.14085-4-Yunxiang.Li@amd.com>
 <5025dc06-8471-4f74-affc-1070fc7e6dca@amd.com>
 <SA1PR12MB8599116F019C2EFFF427C50AEDF42@SA1PR12MB8599.namprd12.prod.outlook.com>
 <38598dc3-c815-4328-afa5-6eaa9997c755@amd.com>
In-Reply-To: <38598dc3-c815-4328-afa5-6eaa9997c755@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 May 2024 14:14:48 -0400
Message-ID: <CADnq5_PLJo-Ha1ZN3A5AEqCqB6kSHyhEyiBFrMoiXCB+m5UfnA@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: prevent gpu access during reset recovery
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gao,
 Likun" <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
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

On Thu, May 23, 2024 at 11:32=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 23.05.24 um 13:36 schrieb Li, Yunxiang (Teddy):
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> >>> +void amdgpu_lock_hw_access(struct amdgpu_device *adev); void
> >>> +amdgpu_unlock_hw_access(struct amdgpu_device *adev); int
> >>> +amdgpu_begin_hw_access(struct amdgpu_device *adev); void
> >>> +amdgpu_end_hw_access(struct amdgpu_device *adev);
> >> Don't add anything to amdgpu.h. We are slowly decomposing that file.
> > Where would be a better place? I just wanted to have them next to amdgp=
u_in_reset
>
> amdgpu_reset.h if you have time feel free to move amdgpu_in_reset() over
> there as well.
>
> >
> >>> @@ -5816,6 +5816,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_dev=
ice *adev,
> >>>              goto skip_hw_reset;
> >>>      }
> >>>
> >>> +   amdgpu_lock_hw_access(adev);
> >> That should already be locked here. So this will most likely deadlock.
> >>
> >>>    retry:    /* Rest of adevs pre asic reset from XGMI hive. */
> >>>      list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
> >>>              r =3D amdgpu_device_pre_asic_reset(tmp_adev, reset_conte=
xt); @@
> >>> -5852,6 +5853,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device=
 *adev,
> >>>               */
> >>>              amdgpu_device_stop_pending_resets(tmp_adev);
> >>>      }
> >>> +   amdgpu_unlock_hw_access(adev);
> >>>
> >>>    skip_hw_reset:
> >> Don't add helpers for that, especially not with that name.
> >>
> >> We don't block HW access, but just prevent concurrent resets.
> > Here is taking a different lock than the reset_domain->sem. It is a sep=
erate reset_domain->gpu_sem that is only locked when we will actuall do res=
et, it is not taken in the skip_hw_reset path.
>
> Exactly that is what you should *not* do. Please don't add any new lock
> to the code. This is already complicated enough.
>
> If you think that adding wrappers for reset lock makes sense then we can
> probably do that, bot don't add any lock for hw access.
>
>
> >
> >>>      uint32_t seq;
> >>>
> >>> -   if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready ||
> >>> -       !down_read_trylock(&adev->reset_domain->sem)) {
> >>> +   /*
> >>> +   * A GPU reset should flush all TLBs anyway, so no need to do
> >>> +   * this while one is ongoing.
> >>> +   */
> >>> +   if (!amdgpu_begin_hw_access(adev))
> >>> +           return 0;
> >>>
> >>> +   if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready ||
> >>> +       amdgpu_in_reset(adev)) {
> >> That check doesn't makes sense now any more.
> > same here, the two checks are for different scope, although I wasn't su=
re if the original check is correct or not, is there a possibility that !ad=
ev->gmc.flush_pasid_uses_kiq and !ring->sched.ready are false but amdgpu_in=
_reset(adev) is true? and to we want to take this branch when that happens?
>
> amdgpu_in_reset() in used incorrect in quite a lot of places. It should
> only be used inside the HW backend code to distinct between initial load
> and reset.
>
> All other use cases especially the ones in the IOCTL front end functions
> as well as here in the midlayer which isn't used by GPU reset are incorre=
ct.

FWIW, I started to clean this up earlier this year, but never got
around to finishing up the patches:
https://lists.freedesktop.org/archives/amd-gfx/2024-February/104582.html

Alex

>
> >
> >>> @@ -684,12 +684,18 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgp=
u_device *adev, uint16_t pasid,
> >>>      struct amdgpu_ring *ring =3D &adev->gfx.kiq[inst].ring;
> >>>      struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[inst];
> >>>      unsigned int ndw;
> >>> -   signed long r;
> >>> +   signed long r =3D 0;
> >> Please don't initialize local variables if it isn't necessary.
> >>
> >>>              if (adev->gmc.flush_tlb_needs_extra_type_2)
> >>>                      adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, p=
asid,
> >>>                                                               2, all_=
hub,
> >>> @@ -703,46 +709,42 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgp=
u_device *adev, uint16_t pasid,
> >>>              adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
> >>>                                                       flush_type, all=
_hub,
> >>>                                                       inst);
> >>> -           return 0;
> >>> -   }
> >>> +   } else {
> >> That the locking is missing here should be a separate bug fix independ=
ent of other changes.
> > I will split this off into a seperate patch, initializing r is needed b=
ecause I consolidated the return paths to drop the read lock.
>
> In that case better set r when it's not initialized in some path.
>
> Regards,
> Christian.
>
