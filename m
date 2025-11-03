Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87804CCF9F8
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 14:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2996310E400;
	Mon,  3 Nov 2025 14:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pt+mT4+G";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B857910E400
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 14:14:25 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-7a432101883so431880b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 06:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762179265; x=1762784065; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jaLYV1JpC36U8ihQ7DvzLFDu2u8LvSFVsUTcudLbQHE=;
 b=Pt+mT4+Gj7K/4/GumSqtnt4rE7PrME7XAAy70s7sHPJTBOHhw5HdCYsze2WLN7yl6G
 uYtoHf7dYCReZeL2I8gmS2nlgnYICxwwLDx/+8zBA61OZUQ4pioPhBr6yTRX39y0LhAa
 bFjy8Lz3XJeKMwMhj0ZISA3qzY9sJ5LeE5cFSj6FthBiQjqScXWSgwIOei/TGXam8qum
 R3flObd2z2idLrKVcHEHYtfxqaQqyvtHj5OnTy6AxbMWuvxc8tayQLLS1ILelhtombPj
 dKFlqR2II/s7u2FEf06l3J9GP0zpMiPeWZySAw4nwwdsC1gC1gE5GugLgHfnWcUi2TSG
 hNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762179265; x=1762784065;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jaLYV1JpC36U8ihQ7DvzLFDu2u8LvSFVsUTcudLbQHE=;
 b=GQWqffuZYN4z3+dW+xAnEBHhnUGfmw8yEPwK3UfeMbD/He9M6JxgsywZVrEUqOEk/N
 cZwiSjxQnER/1Jy4dHO57BdvbBwENk1XxbmlNzvAHwjmZ6lzMlRN793HaT/6k43wmXP4
 KXep0IJ28ySO6oDNhctCwNUI2mCX7xPYu6zHZoQSzTcm5qogkKX57Ow3zl21EEIBoLAF
 AW9eLTUOAjKeBr19G5Ub+FtJzWVjF8XQz//Qy19yDAuPJ8XKM8BQVZ7x3fulhfJ0P1wu
 rW1ddiRDN6mFs49mRVsHtDC0hhRjxVh6Ml0l0/RsHTJ4B6CR9nIi4KFFLFPbLztYtwwF
 DkWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbINdfMXsJo0tO3kIRqJnpsoOOY+7yY80Se2up/Wf3CqUiXGO+0m/uXPxRmZrQScz/TYZZ3HQe@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+RZFQ1hZFxwj3T7uB9yTajHQOx8rUv+gQ9NZ9NYs2hUW46o57
 Bqk5TsYs5QqkYcK1EOJWgdaWLj7uFvyEH9xkCwGJa+xYiBKyjtwZjIxhSlhvmauAIVT8QmFQW1Z
 Pu/Katy/ZCpEy6lXWjfqMpr2K9b7p4BA=
X-Gm-Gg: ASbGncsIjn60Mr9L61F0EJRZq3G+SJ6ztgZrYtFlQ2Le4+FqUxgPGz8WZkZulneoZGy
 yQyI9uOR18oqofN8okzTGaXm1rpRXyVwbfJi1tY+DP1hF7pucrvP9wGErLfOX7gn+6hrVxbIaIX
 fgjqdHysLKDMd/+j1NyxtmY6BVzIL4XMb9mbR433jB0JB89wKB2iQcFTuqkblzftUnpcx9JtAJ2
 miWn5eCsno0h9Y702jeko9kxcvvOAGU2cBIHGJghLXs8LOmMhIYuaiWBldc
X-Google-Smtp-Source: AGHT+IGpEXTVjWYL0SXLLqoJupNVzpY4E9zm6G2/MwHaPQwd7vmX8GlW/8EBNe7wshmARInA7wKBOaoegMI9wGMCepI=
X-Received: by 2002:a17:903:4910:b0:295:290d:4af9 with SMTP id
 d9443c01a7336-295290d512dmr50085445ad.11.1762179265070; Mon, 03 Nov 2025
 06:14:25 -0800 (PST)
MIME-Version: 1.0
References: <20251027220255.507105-1-alexander.deucher@amd.com>
 <20b7418c-c091-4e4f-aa40-556dd68605ee@amd.com>
 <CADnq5_P0fT6PFDOz1Fn7mWz4Q=aC1G8vX-D3XbPmSx1dc9KLJg@mail.gmail.com>
 <c4b73b23-441e-46c0-a752-3fe30d1bd9a0@amd.com>
 <CADnq5_NT-P-izFo-hWi7dpfDtU8WZitEw4xaKOjczRmgzwH5SQ@mail.gmail.com>
 <eaefde24-1b5d-4cbd-b23e-6a5a608493fa@amd.com>
In-Reply-To: <eaefde24-1b5d-4cbd-b23e-6a5a608493fa@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Nov 2025 09:14:13 -0500
X-Gm-Features: AWmQ_bl39r9n1uDr7X9IDL3DyZVdT73wNM4OYgPKn2v7TSshCAanGG3-FObdjY4
Message-ID: <CADnq5_N=3tVjqxLUgNoAhdy2RvH54zALtOw-eN=JOGieAW1SNw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix possible fence leaks from job structure
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Jesse Zhang <Jesse.Zhang@amd.com>
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

On Mon, Nov 3, 2025 at 5:51=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 10/31/25 16:28, Alex Deucher wrote:
> > On Fri, Oct 31, 2025 at 10:01=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 10/31/25 14:53, Alex Deucher wrote:
> >>> On Fri, Oct 31, 2025 at 4:40=E2=80=AFAM Christian K=C3=B6nig
> >>> <christian.koenig@amd.com> wrote:
> >>>>
> >>>> On 10/27/25 23:02, Alex Deucher wrote:
> >>>>> If we don't end up initializing the fences, free them when
> >>>>> we free the job.
> >>>>>
> >>>>> v2: take a reference to the fences if we emit them
> >>>>>
> >>>>> Fixes: db36632ea51e ("drm/amdgpu: clean up and unify hw fence handl=
ing")
> >>>>> Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com> (v1)
> >>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>>> ---
> >>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  2 ++
> >>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 18 ++++++++++++++++++
> >>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  2 ++
> >>>>>  3 files changed, 22 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ib.c
> >>>>> index 39229ece83f83..0596114377600 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> >>>>> @@ -302,6 +302,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring=
, unsigned int num_ibs,
> >>>>>               return r;
> >>>>>       }
> >>>>>       *f =3D &af->base;
> >>>>> +     /* get a ref for the job */
> >>>>> +     dma_fence_get(*f);
> >>>>
> >>>> I think it would be better to set the fence inside the job to NULL a=
s soon as it is consumed/initialized.
> >>>
> >>> We need the pointer for the job timed out handling.
> >>
> >> I don't think that is true. During a timeout we should have job->s_fen=
ce->parent for the HW fence.
> >
> > We also need to keep it around for job_submit_direct() so we can free
> > the IBs used for that.
>
> Good point, but that handling here is really not straight forward.
>
> Anyway feel free to add my rb for now, but we need to re-visite that at s=
ome point.

Thanks.  I found a leak of the non-job fence.  Please see the latest
revision of the patch.

Alex

>
> Regards,
> Christian.
>
> >
> > Alex
> >
> >>
> >> But even when we go down that route here, you only grab a reference to=
 the hw_fence but not the hw_vm_fence.
> >>
> >> That looks broken to me.
> >>
> >> Christian.
> >>
> >>>
> >>> Alex
> >>>
> >>>>
> >>>>>
> >>>>>       if (ring->funcs->insert_end)
> >>>>>               ring->funcs->insert_end(ring);
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_job.c
> >>>>> index 55c7e104d5ca0..dc970f5fe601b 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>>> @@ -295,6 +295,15 @@ static void amdgpu_job_free_cb(struct drm_sche=
d_job *s_job)
> >>>>>
> >>>>>       amdgpu_sync_free(&job->explicit_sync);
> >>>>>
> >>>>> +     if (job->hw_fence->base.ops)
> >>>>> +             dma_fence_put(&job->hw_fence->base);
> >>>>> +     else
> >>>>> +             kfree(job->hw_fence);
> >>>>> +     if (job->hw_vm_fence->base.ops)
> >>>>> +             dma_fence_put(&job->hw_vm_fence->base);
> >>>>> +     else
> >>>>> +             kfree(job->hw_vm_fence);
> >>>>> +
> >>>>
> >>>> This way that here can just be a kfree(..).
> >>>>
> >>>> Regards,
> >>>> Christian.
> >>>>
> >>>>>       kfree(job);
> >>>>>  }
> >>>>>
> >>>>> @@ -324,6 +333,15 @@ void amdgpu_job_free(struct amdgpu_job *job)
> >>>>>       if (job->gang_submit !=3D &job->base.s_fence->scheduled)
> >>>>>               dma_fence_put(job->gang_submit);
> >>>>>
> >>>>> +     if (job->hw_fence->base.ops)
> >>>>> +             dma_fence_put(&job->hw_fence->base);
> >>>>> +     else
> >>>>> +             kfree(job->hw_fence);
> >>>>> +     if (job->hw_vm_fence->base.ops)
> >>>>> +             dma_fence_put(&job->hw_vm_fence->base);
> >>>>> +     else
> >>>>> +             kfree(job->hw_vm_fence);
> >>>>> +
> >>>>>       kfree(job);
> >>>>>  }
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vm.c
> >>>>> index db66b4232de02..f8c67840f446f 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>>>> @@ -845,6 +845,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, s=
truct amdgpu_job *job,
> >>>>>               if (r)
> >>>>>                       return r;
> >>>>>               fence =3D &job->hw_vm_fence->base;
> >>>>> +             /* get a ref for the job */
> >>>>> +             dma_fence_get(fence);
> >>>>>       }
> >>>>>
> >>>>>       if (vm_flush_needed) {
> >>>>
> >>
>
