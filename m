Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE313C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 14:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A23E10F608;
	Thu,  2 May 2024 14:10:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T/uiD0hA";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5396110F608
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 14:10:33 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-6f043f9e6d7so8023873b3a.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 May 2024 07:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714659032; x=1715263832; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8E2bJiEP4h+95tfAkZCkGrLwMUH95CnzFzWS1alZgcc=;
 b=T/uiD0hA98PyWHANSteCvWjf+/uOPFHAWZTESdQUxnvASB4wxIk7C+huBSpKREY9bJ
 nBITqVbNczDBWZ9ZYicHeLvcGJSmgjjK7rnsCvbMzSkY6BfIzU5rYGhJ+4mMIfQnJr4+
 1JL5OnPCiz90YkT8nIuf0Q6iz9VlvjvwUiu1ZiNSMEUQ4fPhrPTU8/+iIm7FeVcFQ3GX
 rQ5aOaIJtrCrOMqqKtwT6R2FWkBoUUVnM50v2DE0Gg0zIj82DyCzfi3KWZyhMXWTa/oX
 48XWD0bA1Yo/DeKCoL8KCf3A2zSP9zbeeoYuU3Mzwu78qyX7ZYsaoDPVwfKeLginC0q5
 JlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714659032; x=1715263832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8E2bJiEP4h+95tfAkZCkGrLwMUH95CnzFzWS1alZgcc=;
 b=ttxrs7fTaTxAE+w9+eD/mtIPIDjPUe8LvdutCmgPE7ooCm/5u8QEpJAcBNDSOJX3o2
 QmTbz540FFgZ1C8+t49eMkW5ci/lKfg6jQqgTE+87vywr+cEeNb5Si2D5/i/hmis6oMA
 ua3RCGHEwAJLLp95hYyWEFw63B4UNo//mcyEelCqzYs6KX4Yh97Xmv7/akf8KegS6kva
 M/KQQKK1zd3M1IK6lrJynBKy05RH8BF5+0xz+eUNhM//4wRuvvyc+IBsU+2DfMj1kg9K
 RnJvVAh/6lLNncVnMG/d/Z63kD1Z9JOaEfgxPfajCX3bNAhiAS6zONsOV+qr60VgmkoJ
 p8QQ==
X-Gm-Message-State: AOJu0YyLpG+vSvPVQOBWXsBynjoVLHG9PMJB/K73+SKroRWEtRpguemi
 pbwRV67pxJDoXThojM/vPPa5WrfUZT6AmCjFAoZ7ZX2ZwnUMUoLzoUfLhyYjM50Zk/rDeV3Vq8Q
 htF1rZntOFlisDdaeOCUuER3VF2EiiA==
X-Google-Smtp-Source: AGHT+IGWICiJ0ecXpDmaMIWkHnUT7GcgNSRQzIxqX7Z/+lAfB90ST52Awc9ekr+p3FXJCRgIoknav0bQqvwZqlcgJy8=
X-Received: by 2002:a05:6a20:5601:b0:1a7:2ceb:e874 with SMTP id
 ir1-20020a056a20560100b001a72cebe874mr6503733pzc.37.1714659032563; Thu, 02
 May 2024 07:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-14-shashank.sharma@amd.com>
 <CADnq5_OQHhmPZXsPdQfygAR3=EsWMB3r3n=Y0ajJFBhA+voY+A@mail.gmail.com>
 <1f34c3b7-0c3a-b83b-efe4-d3f5750cfa34@amd.com>
In-Reply-To: <1f34c3b7-0c3a-b83b-efe4-d3f5750cfa34@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 May 2024 10:10:21 -0400
Message-ID: <CADnq5_M2ErBmKHeg8hE-xsf_xZGWSZ-r35F8Py44yn+NNXSRwQ@mail.gmail.com>
Subject: Re: [PATCH v9 13/14] drm/amdgpu: enable compute/gfx usermode queue
To: "Sharma, Shashank" <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
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

On Thu, May 2, 2024 at 1:51=E2=80=AFAM Sharma, Shashank <shashank.sharma@am=
d.com> wrote:
>
>
> On 01/05/2024 22:44, Alex Deucher wrote:
> > On Fri, Apr 26, 2024 at 10:27=E2=80=AFAM Shashank Sharma
> > <shashank.sharma@amd.com> wrote:
> >> From: Arvind Yadav <arvind.yadav@amd.com>
> >>
> >> This patch does the necessary changes required to
> >> enable compute workload support using the existing
> >> usermode queues infrastructure.
> >>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: Christian Koenig <christian.koenig@amd.com>
> >> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> >> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c    |  3 ++-
> >>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c           |  2 ++
> >>   drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c | 10 +++++++++-
> >>   include/uapi/drm/amdgpu_drm.h                    |  1 +
> >>   4 files changed, 14 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_userqueue.c
> >> index e516487e8db9..78d34fa7a0b9 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >> @@ -189,7 +189,8 @@ amdgpu_userqueue_create(struct drm_file *filp, uni=
on drm_amdgpu_userq *args)
> >>          int qid, r =3D 0;
> >>
> >>          /* Usermode queues are only supported for GFX/SDMA engines as=
 of now */
> >> -       if (args->in.ip_type !=3D AMDGPU_HW_IP_GFX && args->in.ip_type=
 !=3D AMDGPU_HW_IP_DMA) {
> >> +       if (args->in.ip_type !=3D AMDGPU_HW_IP_GFX && args->in.ip_type=
 !=3D AMDGPU_HW_IP_DMA
> >> +                       && args->in.ip_type !=3D AMDGPU_HW_IP_COMPUTE)=
 {
> >>                  DRM_ERROR("Usermode queue doesn't support IP type %u\=
n", args->in.ip_type);
> >>                  return -EINVAL;
> >>          }
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v11_0.c
> >> index 525bd0f4d3f7..27b86f7fe949 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >> @@ -1350,6 +1350,7 @@ static int gfx_v11_0_sw_init(void *handle)
> >>                  adev->gfx.mec.num_pipe_per_mec =3D 4;
> >>                  adev->gfx.mec.num_queue_per_pipe =3D 4;
> >>                  adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_mes_v1=
1_0_funcs;
> >> +               adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &userq_mes=
_v11_0_funcs;
> >>                  break;
> >>          case IP_VERSION(11, 0, 1):
> >>          case IP_VERSION(11, 0, 4):
> >> @@ -1362,6 +1363,7 @@ static int gfx_v11_0_sw_init(void *handle)
> >>                  adev->gfx.mec.num_pipe_per_mec =3D 4;
> >>                  adev->gfx.mec.num_queue_per_pipe =3D 4;
> >>                  adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_mes_v1=
1_0_funcs;
> >> +               adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &userq_mes=
_v11_0_funcs;
> >>                  break;
> >>          default:
> >>                  adev->gfx.me.num_me =3D 1;
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/driver=
s/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> >> index a5e270eda37b..d61d80f86003 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> >> @@ -183,7 +183,8 @@ static int mes_v11_0_userq_create_ctx_space(struct=
 amdgpu_userq_mgr *uq_mgr,
> >>          }
> >>
> >>          /* We don't need to set other FW objects for SDMA queues */
> >> -       if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA)
> >> +       if ((queue->queue_type =3D=3D AMDGPU_HW_IP_DMA) ||
> >> +           (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE))
> >>                  return 0;
> >>
> >>          /* Shadow and GDS objects come directly from userspace */
> >> @@ -246,6 +247,13 @@ static int mes_v11_0_userq_mqd_create(struct amdg=
pu_userq_mgr *uq_mgr,
> >>          userq_props->use_doorbell =3D true;
> >>          userq_props->doorbell_index =3D queue->doorbell_index;
> >>
> >> +       if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
> >> +               userq_props->eop_gpu_addr =3D mqd_user->eop_va;
> >> +               userq_props->hqd_pipe_priority =3D AMDGPU_GFX_PIPE_PRI=
O_NORMAL;
> >> +               userq_props->hqd_queue_priority =3D AMDGPU_GFX_QUEUE_P=
RIORITY_MINIMUM;
> >> +               userq_props->hqd_active =3D false;
> >> +       }
> >> +
> >>          queue->userq_prop =3D userq_props;
> >>
> >>          r =3D mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_p=
tr, userq_props);
> >> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_d=
rm.h
> >> index 22f56a30f7cb..676792ad3618 100644
> >> --- a/include/uapi/drm/amdgpu_drm.h
> >> +++ b/include/uapi/drm/amdgpu_drm.h
> >> @@ -375,6 +375,7 @@ struct drm_amdgpu_userq_mqd {
> >>           * sized.
> >>           */
> >>          __u64   csa_va;
> >> +       __u64   eop_va;
> >>   };
> > Let's add a new mqd descriptor for compute since it's different from
> > gfx and sdma.
> the only different thing is this object (vs csa and gds objects), apart
> from that, the mqd is the same as they all are MES based. Am I missing
> something here ?

The scheduling entity is irrelevant.  The mqd is defined by the engine
itself.  E.g., v11_structs.h.  Gfx has one set of requirements,
compute has different ones, and SDMA has different ones.  VPE and VCN
also have mqds.  When we add support for them in the future, they may
have additional requirements.  I want to make it clear in the
interface what additional data are required for each ring type.

> >
> > Also, can we handle the eop buffer as part of the
> > kernel metadata for compute user queues rather than having the user
> > specify it?
>
> Sure, we can do it.

Thinking about it more, I think the eop has to be in the user's GPU
virtual address space so it probably makes more sense for the user to
allocate this, but ideally we'd take an extra ref count on it while
the queue is active to avoid the user freeing it while the queue is
active, but that can probably be a future improvement.

Alex

>
> - Shashank
>
> >
> > Alex
> >
> >>   struct drm_amdgpu_userq_in {
> >> --
> >> 2.43.2
> >>
