Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B566BC4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 13:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E72B10F5DC;
	Thu,  2 May 2024 13:56:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VOQEA6LZ";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DB6D10F5DC
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 13:56:11 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2b2bc7b37bcso2142913a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 May 2024 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714658171; x=1715262971; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FypqaXtDfb7S1xgrBvUy1cCDwtrA2x+Od8V/bWRJs2o=;
 b=VOQEA6LZR3AowSi69F7SAX5UKE1JF/zK/xFhQ9PXmflPayz3huIRRyv1WlbSGkLmSQ
 DoonP/VbheKJSk79Y/TiHgddXTBIK64tLQdTTMkxrUr846raYEzvPhZnrw0KYZM8cWOY
 PXzMWH3NwaQ2jZpiQENlI5bz5vDBVtf7B2n0oUcYT3EY5OZ+Q6VIww3f9deZ+4XGhYe+
 +m0ln9Itq0e77l+kpmLzJRyS1HAqwwUlSGdFed127ZY61Xsft9QiULXzVtc0ScwO9fGO
 bieYXHoskqwXq9gyW98hS3tuVAM6XFc7JivXtLeZL1ttbaI4WD4aFt1jfjedYaMcmQKO
 Afgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714658171; x=1715262971;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FypqaXtDfb7S1xgrBvUy1cCDwtrA2x+Od8V/bWRJs2o=;
 b=xIt+Vruf1ZyH6pRRUhpQ7l77L0v5ZCAJXJQqHQbcK8x7qAShZb1gbvi+HVpSA7v57N
 E1f3PD9x2LRBCvzkwrw4tC/ZxLoCyc0DwVAIJqSz4IUWh3pqJyDI/xcIuo9dt1fv516x
 DihbyLGajk8FaJA44f/qtlVDt5p9+1OmrQAVKIXXZcIU5zhJ6rZ+GeTdGSBkQKMNdA8R
 aELOvVfg+rPCKvofk3ZBGfPNhFGHUlxUQt6yQDN8bGrO3RaXesfeflIZxMezQ6Ej5Adc
 9eBaSNRUKyvQeuBzXWK2naUvrfbHBhe8Q2hAeK3AOZ4en/Setw1thP6BAevix3OkMLFI
 VoUw==
X-Gm-Message-State: AOJu0YzUN/jzOxI5xTwE22A/boOIrcF9VTcuxj/otP/x9KVX1T/Ed5mx
 VNyKJTKaQTW5cFWplQx/WFId3qtKcANnX2hF1dSBjBRfuMKdME/GxgI3MmZeCUl9tyDnZqAhSrR
 zdzAYp03zpSZivD12FeNgTzoEC9k=
X-Google-Smtp-Source: AGHT+IFbtTXBeexMznr4HljwhnXqQl9odbX6WlAi0xxfWLYQXK3zzwLtUQlUxM+YVqc6B1l2liAAJSoUz+r3sqeqtlQ=
X-Received: by 2002:a17:90a:d481:b0:2b2:7ad2:e0c6 with SMTP id
 s1-20020a17090ad48100b002b27ad2e0c6mr5961495pju.1.1714658170644; Thu, 02 May
 2024 06:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-13-shashank.sharma@amd.com>
 <CADnq5_OKanvT1co22rxHEjBc_4RJwN4Ss5VrZ4Btx_bDFh0F2Q@mail.gmail.com>
 <3d61136d-9fe6-4c97-63fb-024face67b93@amd.com>
In-Reply-To: <3d61136d-9fe6-4c97-63fb-024face67b93@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 May 2024 09:55:59 -0400
Message-ID: <CADnq5_NT7zspQFCTX=jJJX99Q6W_gGxMsvcjkCXM52CEyMmp4w@mail.gmail.com>
Subject: Re: [PATCH v9 12/14] drm/amdgpu: enable SDMA usermode queues
To: "Sharma, Shashank" <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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

On Thu, May 2, 2024 at 1:47=E2=80=AFAM Sharma, Shashank <shashank.sharma@am=
d.com> wrote:
>
>
> On 01/05/2024 22:41, Alex Deucher wrote:
> > On Fri, Apr 26, 2024 at 10:27=E2=80=AFAM Shashank Sharma
> > <shashank.sharma@amd.com> wrote:
> >> This patch does necessary modifications to enable the SDMA
> >> usermode queues using the existing userqueue infrastructure.
> >>
> >> V9: introduced this patch in the series
> >>
> >> Cc: Christian K=C3=B6nig <Christian.Koenig@amd.com>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> >> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c    | 2 +-
> >>   drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c | 4 ++++
> >>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c           | 3 +++
> >>   3 files changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_userqueue.c
> >> index 781283753804..e516487e8db9 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >> @@ -189,7 +189,7 @@ amdgpu_userqueue_create(struct drm_file *filp, uni=
on drm_amdgpu_userq *args)
> >>          int qid, r =3D 0;
> >>
> >>          /* Usermode queues are only supported for GFX/SDMA engines as=
 of now */
> >> -       if (args->in.ip_type !=3D AMDGPU_HW_IP_GFX) {
> >> +       if (args->in.ip_type !=3D AMDGPU_HW_IP_GFX && args->in.ip_type=
 !=3D AMDGPU_HW_IP_DMA) {
> >>                  DRM_ERROR("Usermode queue doesn't support IP type %u\=
n", args->in.ip_type);
> >>                  return -EINVAL;
> >>          }
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/driver=
s/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> >> index a6c3037d2d1f..a5e270eda37b 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> >> @@ -182,6 +182,10 @@ static int mes_v11_0_userq_create_ctx_space(struc=
t amdgpu_userq_mgr *uq_mgr,
> >>                  return r;
> >>          }
> >>
> >> +       /* We don't need to set other FW objects for SDMA queues */
> >> +       if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA)
> >> +               return 0;
> >> +
> >>          /* Shadow and GDS objects come directly from userspace */
> >>          mqd->shadow_base_lo =3D mqd_user->shadow_va & 0xFFFFFFFC;
> >>          mqd->shadow_base_hi =3D upper_32_bits(mqd_user->shadow_va);
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/=
amd/amdgpu/sdma_v6_0.c
> >> index 361835a61f2e..90354a70c807 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> >> @@ -1225,6 +1225,8 @@ static int sdma_v6_0_early_init(void *handle)
> >>          return 0;
> >>   }
> >>
> >> +extern const struct amdgpu_userq_funcs userq_mes_v11_0_funcs;
> > Can you include the header rather than adding an extern?
> Noted,
> >
> >> +
> >>   static int sdma_v6_0_sw_init(void *handle)
> >>   {
> >>          struct amdgpu_ring *ring;
> >> @@ -1265,6 +1267,7 @@ static int sdma_v6_0_sw_init(void *handle)
> >>                  return -EINVAL;
> >>          }
> >>
> >> +       adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_v11_0_funcs=
;
> >>          return r;
> >>   }
> > I think we need a new mqd descriptor in amdgpu_drm.h as well since the
> > sdma metadata is different from gfx and compute.
>
> Can you please elaborate on this ? AFAIK SDMA queue doesn't need any
> specific metadata objects (like GFX).

Right.  I want to make it clear in the IOCTL interface what buffers
are required for which ring types.  E.g., UMD might allocate a shadow
buffer for SDMA, but they don't need it so there is no need to
allocate it.  If we have separate mqd structures for every ring type,
it makes it clear which additional buffers are needed for which ring
types.

Alex

>
> - Shashank
>
> > Alex
> >
> >> --
> >> 2.43.2
> >>
