Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EB7C4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 14:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DDF0112468;
	Fri,  3 May 2024 14:43:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gp4Hn/Nv";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C94E4112468
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 14:43:57 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-1ec92e355bfso30178115ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 May 2024 07:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714747437; x=1715352237; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2iSNt/BKqutP4XlUeoXXxOxl2XgHPMXDo0BNyHEMAHA=;
 b=Gp4Hn/Nvjwn2UmC+vY8gmYIQNlNgn4tr58Fx+QDdhXecq+XWovGaCiiNh8cmZpeHu0
 Usoj+a5fdlFHLXZcX9TUoGIjxR3u/PUuAm92DBaT48eTxRaEEdVW5nCJSyF/tCiVDBTD
 fuvCzUvhGy4LRWCqAhXxKryONB71A+jsayPzlUuJLTQwF+6JD3vgetx7fW0TNASBPz4j
 ci1Cc3JpeYZuwOd08n4KCPijngwcQNrUXX2CjxQ1pMPNrMBdfcdX81F2qpdBe3OTAvBS
 yxgv2b0HFaHp8v+KwaV1jMKuDfew6FCzVdq6LLnQizLiTwojwG/SFaYT++4HBy0Mdqte
 ynFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714747437; x=1715352237;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2iSNt/BKqutP4XlUeoXXxOxl2XgHPMXDo0BNyHEMAHA=;
 b=t/PyHPPmoBYKJMqtQAylaVAXAv0FYSi/kUgGskkmuR0XXDZ6YnpnZHGyOQZFVyTTPF
 Ux+O79Ug3bnHC/ZjAIhkOH8MT0QgADrkPkNWyzOjGtFqmzi33nzYh2YAIkWK/k5QRl1V
 ZI+SfJPFENhOHWEFh5UwbWtILnnvADL6QZVp9mTBPdFD7CQCKpxygRim/Gt8ToM+aY3e
 0VXfUHMdxqCoCYy318SixSAEnrEMIf+cjQxakJdxuDX5YOgZWSS7C65byBLDLT4NS4Hy
 AsSjRPZdaTMW2CIu8DGGouvuXlFn97JQyKqbYrsQQ1Z5NeQHMkppVhWA2tkmuAwcb35O
 Ozvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQnRVi7/2OiJtNJKM2OU6OrTqJ3VcL6gSkr9LhVQ+7cAe7lGIK1ifnbO6XwN5G5MbK9I14LxAZ5DgNqMu/niwiDoVqIEIhoiJ3hKTEnw==
X-Gm-Message-State: AOJu0Ywlkl6TowR1gReDyafq5Q0Xb4FOrggPto2krf8Dg00zvOABGUeC
 xRkxPs/Ur7b/7pUECTrf7IPgqOXCjmOqeScbv1ZJJNbE2XOUG5DCoIvZBJOtNfAO7rhb1DDhzXk
 HNqAIm4Z8TPxgpxvHsmgiuPOB2az/IHZm
X-Google-Smtp-Source: AGHT+IFKmQl6uhsHINAstMxXU+Dw3EL38+tHU5X7tMQ4iknaVDggnBkUPFRafqWOfoi+ibUgywgmrz5OWzxX0OG6be4=
X-Received: by 2002:a17:902:e802:b0:1e5:11ac:a283 with SMTP id
 u2-20020a170902e80200b001e511aca283mr3229242plg.9.1714747437069; Fri, 03 May
 2024 07:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240430172748.61576-1-tursulin@igalia.com>
 <20240430172748.61576-6-tursulin@igalia.com>
 <00d43d65-333e-4b2d-861e-11d01e7931b0@gmail.com>
 <d76f9bb6-b5e1-449e-957f-e7fb965e5f9f@igalia.com>
 <CADnq5_NqUNp=bEgnAQKA7VWa0S4eWzGenc-pC4m8any=uBPqrw@mail.gmail.com>
 <57d26797-76cf-4376-9563-24913c0c39fc@igalia.com>
In-Reply-To: <57d26797-76cf-4376-9563-24913c0c39fc@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 May 2024 10:43:45 -0400
Message-ID: <CADnq5_OJkFp_J-d5L7=aAOv4YCsjHkY7MA0uWjLo+0J9pM7M7w@mail.gmail.com>
Subject: Re: [RFC 5/5] drm/amdgpu: Only show VRAM in fdinfo if it exists
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com
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

On Fri, May 3, 2024 at 10:01=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@igalia.com> wrote:
>
>
> On 03/05/2024 14:47, Alex Deucher wrote:
> > On Fri, May 3, 2024 at 3:50=E2=80=AFAM Tvrtko Ursulin <tvrtko.ursulin@i=
galia.com> wrote:
> >>
> >>
> >> On 02/05/2024 14:16, Christian K=C3=B6nig wrote:
> >>> Am 30.04.24 um 19:27 schrieb Tvrtko Ursulin:
> >>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >>>>
> >>>> Do not emit the key-value pairs if the VRAM does not exist ie. VRAM
> >>>> placement is not valid and accessible.
> >>>
> >>> Yeah, that's unfortunately rather misleading.
> >>>
> >>> Even APUs have VRAM or rather stolen system memory which is managed b=
y
> >>> the graphics driver.
> >>>
> >>> We only have a single compute model which really doesn't have VRAM at=
 all.
> >>
> >> Hm what is misleading and how more precisely? :) Maybe in other words,
> >> if is_app_apu is not the right criteria to know when TTM_PL_VRAM is
> >> impossible, what is? Is the compute model you mentio the only thing
> >> which sets is_app_apu and uses the dummy vram manager?
> >
> > Probably better to check if adev->gmc.real_vram_size is non-0.
>
> Hmm "real VRAM" - will that handle APUs correctly?

Yes.  In the client APU case "VRAM" will be the UMA carve out region
reserved by the sbios.

>
> I am looking at this:
>
>         if (!adev->gmc.is_app_apu) {
>                 man->func =3D &amdgpu_vram_mgr_func;
>
>                 err =3D drm_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
>                 if (err)
>                         return err;
>         } else {
>                 man->func =3D &amdgpu_dummy_vram_mgr_func;
>                 DRM_INFO("Setup dummy vram mgr\n");
>         }
>
> And assuming that unless the dummy manager is used, TTM_PL_VRAM will be
> valid. Wrong assumption?

Today checking is_app_apu would be fine, but It's supposed to
distinguish datacenter APUs, not whether or not the device has a
"VRAM" pool or not, but its usage has gotten sort of overloaded.  Just
want to avoid overloading what it means in too many more places.

Alex

>
> Regards,
>
> Tvrtko
>
>
> > Alex
> >
> >>
> >> Regards,
> >>
> >> Tvrtko
> >>
> >>> Regards,
> >>> Christian.
> >>>
> >>>>
> >>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 29 +++++++++++++----=
-----
> >>>>    1 file changed, 17 insertions(+), 12 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> >>>> index a09944104c41..603a5c010f5d 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> >>>> @@ -83,25 +83,30 @@ void amdgpu_show_fdinfo(struct drm_printer *p,
> >>>> struct drm_file *file)
> >>>>         */
> >>>>        drm_printf(p, "pasid:\t%u\n", fpriv->vm.pasid);
> >>>> -    drm_printf(p, "drm-memory-vram:\t%llu KiB\n", stats.vram/1024UL=
);
> >>>>        drm_printf(p, "drm-memory-gtt: \t%llu KiB\n", stats.gtt/1024U=
L);
> >>>>        drm_printf(p, "drm-memory-cpu: \t%llu KiB\n", stats.cpu/1024U=
L);
> >>>> -    drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
> >>>> -           stats.visible_vram/1024UL);
> >>>> -    drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
> >>>> -           stats.evicted_vram/1024UL);
> >>>> -    drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
> >>>> -           stats.evicted_visible_vram/1024UL);
> >>>> -    drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
> >>>> -           stats.requested_vram/1024UL);
> >>>> -    drm_printf(p, "amd-requested-visible-vram:\t%llu KiB\n",
> >>>> -           stats.requested_visible_vram/1024UL);
> >>>>        drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
> >>>>               stats.requested_gtt/1024UL);
> >>>> -    drm_printf(p, "drm-shared-vram:\t%llu KiB\n",
> >>>> stats.vram_shared/1024UL);
> >>>>        drm_printf(p, "drm-shared-gtt:\t%llu KiB\n",
> >>>> stats.gtt_shared/1024UL);
> >>>>        drm_printf(p, "drm-shared-cpu:\t%llu KiB\n",
> >>>> stats.cpu_shared/1024UL);
> >>>> +    if (!adev->gmc.is_app_apu) {
> >>>> +        drm_printf(p, "drm-memory-vram:\t%llu KiB\n",
> >>>> +               stats.vram/1024UL);
> >>>> +        drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
> >>>> +               stats.visible_vram/1024UL);
> >>>> +        drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
> >>>> +               stats.evicted_vram/1024UL);
> >>>> +        drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
> >>>> +               stats.evicted_visible_vram/1024UL);
> >>>> +        drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
> >>>> +               stats.requested_vram/1024UL);
> >>>> +        drm_printf(p, "amd-requested-visible-vram:\t%llu KiB\n",
> >>>> +               stats.requested_visible_vram/1024UL);
> >>>> +        drm_printf(p, "drm-shared-vram:\t%llu KiB\n",
> >>>> +               stats.vram_shared/1024UL);
> >>>> +    }
> >>>> +
> >>>>        for (hw_ip =3D 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
> >>>>            if (!usage[hw_ip])
> >>>>                continue;
> >>>
