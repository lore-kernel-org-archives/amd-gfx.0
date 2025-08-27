Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6480BCA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 13:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0428510E815;
	Wed, 27 Aug 2025 13:09:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gXCaK5Bw";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A1C810E815
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 13:09:52 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2488be81066so2579945ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 06:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756300192; x=1756904992; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGy7OVDeZ3bTIH6Lfwo1x+yXANNuM4DepiiCUb/zzSI=;
 b=gXCaK5BwtzjhzEi3YaMwxXsApKLU5k/ouLu530+YFQ5qJP4aF6zPtt0RxUFieQnv10
 ybpoiTFYxsizW9ipwis9SIhFXAJJhsQluLuoC78W7hJ2qD5ylxa4fUBYRbQFKTRQ3Sys
 e+QCzjZSUqpSXDyaC5T2gvh8jmN5SP3zDXRbCn1lMsEktw6SXbcZpBERcj4ifWGZz7Ac
 yc4lEmVyrMo7XaZTpz/VTA3vUhlQCrq+69UHxtx6KU2R/OTi0G+zhQp6bmQ10VgaMZsz
 V+Twtgng5BfuHMNqXztRXBSRrM3fZPLDXQ6bWp4MnHsFcRp7sF4LW2NhIZNJGAdWz+Z+
 w4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756300192; x=1756904992;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CGy7OVDeZ3bTIH6Lfwo1x+yXANNuM4DepiiCUb/zzSI=;
 b=IxiBt930Ha6BHr75q7znXBUVWBYM5Ztvr8Xf4dsBC5w+/4qIMgUSLmd3S7w4XI3idC
 K+HnmSycWUrhShtGPu0KkdCIKWRdIEcD6GJidwY0OeYu7g40/WmmE2lVWX4ONoF2nyUi
 MsqMVzt0WB546SalK9NlYIuq3ykaoupvg0U4NwfPjxuEYuO7aHDYPl02AXqcYIJYZYhG
 o0zKEg0T4jQeT8MGeXs9lJiF/L04fFZ59PX8fjFBOElSXMiHz40xkATlG4v7NWLMhDEm
 axKJDBQiy2uS68Qip9EhFiCESik+vSYRU5kJlJib0xL/cM7INwHt579/xD7vaSLhS+hT
 NTsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFQ7n0BME5ZJmYq90Vqqsc7yFjDMj2JrdPGvTycfHbeB8NWSU9EeaQE9kt2nDKeC7z9YOIeoe+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyivzXUEJCHiuC4AAG9C6M/omN+OH5gBjGzJMnd/3XbBIl1ALXY
 aZc3tYuVCg/RdFG328mo4iipD/B1/xcf6qS82wQsHLv93t1vWWpNPoEVm6w5kgW8pw4FtMZyJCz
 x+zeF5hiG+zMgnKgc3jy+2f7w39wBIzc=
X-Gm-Gg: ASbGncsPraQ97/8sVrLZgr+80c4fdW+1/2ckwpW9xHbVY7xgRsETDD4lIUuiZ+OXfKI
 UxKQLwi79ImCCJ+yiCO1yRbE/9+iqtGx51ByY7DOTKCX68rUDB/lU3wf2Yp/bXdVTFYyOya/w8w
 gf/rQsvYGLEkfjtrvr+AZsWN8RDNX6260nCRCInicjxS7kfb/sB1Y/sDDCLCHrjPQtRW6qaio+k
 mqkRVmzHoT9EkBjSw==
X-Google-Smtp-Source: AGHT+IFlG+ZjZFqUNTfuhAVLzc6JsI1R1nEEtcH7V5xeC92w1PoiZ1kqWQPuuY7XaLnusDjBxlPkEthCtegHhgIy0D8=
X-Received: by 2002:a17:903:3ba5:b0:248:bac6:4fc6 with SMTP id
 d9443c01a7336-248bac65515mr5371465ad.1.1756300191450; Wed, 27 Aug 2025
 06:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250826193821.869445-1-David.Wu3@amd.com>
 <20250826193821.869445-3-David.Wu3@amd.com>
 <CADnq5_MCiwaLJEXG1y9-D0v8naz0ZnNVurs-cQXBDvAyL+oXDg@mail.gmail.com>
 <1b21a8e5-7aba-48b0-8201-2db619c1e3fd@amd.com>
 <CADnq5_MjdGMc_a4N1YJMbgSMAReqe6nQD68=8cOAXWMYRA_DXA@mail.gmail.com>
 <e5d8b64b-9a26-48c7-9a28-1a6805b3ca43@amd.com>
In-Reply-To: <e5d8b64b-9a26-48c7-9a28-1a6805b3ca43@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Aug 2025 09:09:39 -0400
X-Gm-Features: Ac12FXy5kGJ_W9Az0lJPFSmh974pl-2tgxZaPl9HH0XQ44jCEBM_nUV5TASSkvo
Message-ID: <CADnq5_PcR66KQxBMrKLu2NSLHwoKXNi42h7zvT8BwEvZG27FCw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: protect potential NULL pointer
 dereferencing
To: David Wu <davidwu2@amd.com>
Cc: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org
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

On Tue, Aug 26, 2025 at 5:57=E2=80=AFPM David Wu <davidwu2@amd.com> wrote:
>
> On 2025-08-26 17:20, Alex Deucher wrote:
>
> > On Tue, Aug 26, 2025 at 5:11=E2=80=AFPM David Wu <davidwu2@amd.com> wro=
te:
> >> On 2025-08-26 16:58, Alex Deucher wrote:
> >>
> >> On Tue, Aug 26, 2025 at 3:48=E2=80=AFPM David (Ming Qiang) Wu <David.W=
u3@amd.com> wrote:
> >>
> >> to_amdgpu_fence() could return NULL pointer which needs
> >> to be protected for dereferencing.
> >>
> >> I don't think any of these cases could ever be NULL.  The amdgpu_fence
> >> is a container for the dma_fence so it will alway be present.  See
> >> struct amdgpu_fence.
> >>
> >> hmmm... but - the function could return NULL based on base.ops - see b=
elow
> >> if it should never happen then we should remove the checking. I doubt =
we
> >> will ever return NULL, however someone knowledgeable PLEASE fix it pro=
perly.
> >> The patch is only to protect it just in case.
> > if you look at amdgpu_fence_emit() the fences will only be created
> > with either amdgpu_job_fence_ops or amdgpu_fence_ops so there is no
> > way it will be NULL.  It's a false positive.
> My proposition is  there is no guarantee for future even though it is a
> false positive now as the original code is not
> confident either about the condition should never met. I think there is
> no harm to protect it. Or better I can come up with
> another patch to remove the checking - I feel keeping NULL without being
> handled is not acceptable (at least to silence
> Coverity).
> Alex - please suggest - either removing the checking or do nothing. I am
> fine either way.

Ideally we'd clean up the fence handling so that we don't need
separate fence ops for the job and non-job case.  Then we could remove
the checks in to_amdgpu_fence().  At this point we could remove the
checks in there anyway.  I think it was mostly just added on the off
chance someone tries to lift that helper out of amdgpu_fence.c and
tries to use it for other cases.

Alex

> David
> > Alex
> >
> >> static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f=
)
> >>
> >> {
> >>      struct amdgpu_fence *__f =3D container_of(f, struct amdgpu_fence,=
 base);
> >>
> >>      if (__f->base.ops =3D=3D &amdgpu_fence_ops ||
> >>          __f->base.ops =3D=3D &amdgpu_job_fence_ops)
> >>          return __f;
> >>
> >>      return NULL;
> >> }
> >>
> >> Alex
> >>
> >> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 22 +++++++++++++++------=
-
> >>   1 file changed, 15 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fence.c
> >> index 2d58aefbd68a7..1432b64d379ef 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> >> @@ -160,7 +160,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, st=
ruct dma_fence **f,
> >>                  }
> >>          }
> >>
> >> -       to_amdgpu_fence(fence)->start_timestamp =3D ktime_get();
> >> +       am_fence =3D to_amdgpu_fence(fence);
> >> +       if (am_fence)
> >> +               am_fence->start_timestamp =3D ktime_get();
> >>
> >>          /* This function can't be called concurrently anyway, otherwi=
se
> >>           * emitting the fence would mess up the hardware ring buffer.
> >> @@ -387,6 +389,7 @@ u64 amdgpu_fence_last_unsignaled_time_us(struct am=
dgpu_ring *ring)
> >>          struct amdgpu_fence_driver *drv =3D &ring->fence_drv;
> >>          struct dma_fence *fence;
> >>          uint32_t last_seq, sync_seq;
> >> +       struct amdgpu_fence *f;
> >>
> >>          last_seq =3D atomic_read(&ring->fence_drv.last_seq);
> >>          sync_seq =3D READ_ONCE(ring->fence_drv.sync_seq);
> >> @@ -399,8 +402,8 @@ u64 amdgpu_fence_last_unsignaled_time_us(struct am=
dgpu_ring *ring)
> >>          if (!fence)
> >>                  return 0;
> >>
> >> -       return ktime_us_delta(ktime_get(),
> >> -               to_amdgpu_fence(fence)->start_timestamp);
> >> +       f =3D to_amdgpu_fence(fence);
> >> +       return f ? ktime_us_delta(ktime_get(), f->start_timestamp) : 0=
;
> >>   }
> >>
> >>   /**
> >> @@ -417,13 +420,16 @@ void amdgpu_fence_update_start_timestamp(struct =
amdgpu_ring *ring, uint32_t seq,
> >>   {
> >>          struct amdgpu_fence_driver *drv =3D &ring->fence_drv;
> >>          struct dma_fence *fence;
> >> +       struct amdgpu_fence *f;
> >>
> >>          seq &=3D drv->num_fences_mask;
> >>          fence =3D drv->fences[seq];
> >>          if (!fence)
> >>                  return;
> >>
> >> -       to_amdgpu_fence(fence)->start_timestamp =3D timestamp;
> >> +       f =3D to_amdgpu_fence(fence);
> >> +       if (f)
> >> +               f->start_timestamp =3D timestamp;
> >>   }
> >>
> >>   /**
> >> @@ -827,7 +833,8 @@ static const char *amdgpu_fence_get_driver_name(st=
ruct dma_fence *fence)
> >>
> >>   static const char *amdgpu_fence_get_timeline_name(struct dma_fence *=
f)
> >>   {
> >> -       return (const char *)to_amdgpu_fence(f)->ring->name;
> >> +       struct amdgpu_fence *am_f =3D to_amdgpu_fence(f);
> >> +       return (const char *) (am_f ? am_f->ring->name : "");
> >>   }
> >>
> >>   static const char *amdgpu_job_fence_get_timeline_name(struct dma_fen=
ce *f)
> >> @@ -847,8 +854,9 @@ static const char *amdgpu_job_fence_get_timeline_n=
ame(struct dma_fence *f)
> >>    */
> >>   static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
> >>   {
> >> -       if (!timer_pending(&to_amdgpu_fence(f)->ring->fence_drv.fallba=
ck_timer))
> >> -               amdgpu_fence_schedule_fallback(to_amdgpu_fence(f)->rin=
g);
> >> +       struct amdgpu_fence *am_f =3D to_amdgpu_fence(f);
> >> +       if (am_f && !timer_pending(&am_f->ring->fence_drv.fallback_tim=
er))
> >> +               amdgpu_fence_schedule_fallback(am_f->ring);
> >>
> >>          return true;
> >>   }
> >> --
> >> 2.43.0
> >>
