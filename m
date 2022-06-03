Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52763C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 14:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F49810E16B;
	Fri,  3 Jun 2022 14:08:42 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 786F510E16B
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 14:08:41 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 30-20020a9d0121000000b0060ae97b9967so5607130otu.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Jun 2022 07:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=e5334rbeKsAs+F6Ypea5BgGsq121VSnMQbe5YY4ZKp0=;
 b=ka8dqW4og2QKv49Gxke3Et4x8dha66WChMmyRyH14nSgz4HbK8w5SHebOgpZUaij9V
 BcksuG1oEHY/5r7P679sIIiqrPp73MhbUHOI+4apnsMTQqLz99Cl76qEQVUW3GExpAB+
 qrZBDjLSNS6f/cZzoKIal2OsdhLDzsCr/kns16eKOxK3g8etEMHMJr3M0UyfOju6zGix
 6nAZifwu1xxn1jJ4e4jI2vdZ3VWs5gjm6DfDxFfRGcCi8sE5MdwuT9ys6VyrsB9YARhr
 wCp8EeYdULfikONWkrad6LthdefY0REjWlikDlH01S0dKjHc4p8wJbWisntgC3BZENHx
 EJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=e5334rbeKsAs+F6Ypea5BgGsq121VSnMQbe5YY4ZKp0=;
 b=3Jxs7jCEhu/FHHzt27d6AdFh2otGoaE6CmD2QY1MhGn3teQgod+0msRWQRSdDRoRhQ
 fXSCS4h5hkSz4RPOG2hDAxj6NZqUaavXjMjUzHmZi90Lr/i5g44uAXSuu8qsbHLx7vti
 YkwJS1wXqtFKUz7RCwXkjm9aiwQQ6l45M9tgYM/0rb6vlL7/wXzVpvQ7Rvf/J08mV4XT
 ANOsj3t7rvOtvBHV9S4f2lAZKDYwwoFsVQ0UqVHYvLyq28QStF5RSLFrEh1omwtj0Ydp
 u1yiwmjWQ2ByXQaGdvZvjhweW2NV+KdSFBxyLXjfQJxmnEK5tXBNoB+n6k8zU8xBU6c1
 60Iw==
X-Gm-Message-State: AOAM5325bJ9ndcSKjtJphlpur1eoiND7SfvqJBMyFcQ81xV1iJNUn+68
 lckwDrwyekhnZyLOvYOGD5BjouRQ5rYBoKi/vTs=
X-Google-Smtp-Source: ABdhPJxR4VMGQw9+SizQy0RRzzyzqahjdF7mIPGCAVcQ6b/68+0f17OpXKXtTArDPSwMIvR5j7WeGXe6H+l7aLpF3Io=
X-Received: by 2002:a9d:6b98:0:b0:60b:c54:e22b with SMTP id
 b24-20020a9d6b98000000b0060b0c54e22bmr4237102otq.357.1654265320706; Fri, 03
 Jun 2022 07:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220603102106.149508-1-christian.koenig@amd.com>
 <cd4958ab-897e-d8b0-76bb-0f6045a542d3@amd.com>
 <5f7710f2-7d66-e48f-dab8-c99177743c92@gmail.com>
In-Reply-To: <5f7710f2-7d66-e48f-dab8-c99177743c92@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Jun 2022 10:08:29 -0400
Message-ID: <CADnq5_NS49jdkQuXK58CdfShNW9j1q4HwXtBZtqJ2m3MACD8uA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix limiting AV1 to the first instance on VCN3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 3, 2022 at 8:10 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 03.06.22 um 14:08 schrieb Pierre-Eric Pelloux-Prayer:
> > Hi Christian,
> >
> > The patch is: Tested-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pellou=
x-prayer@amd.com>
> >
> > Could you add a reference to https://gitlab.freedesktop.org/drm/amd/-/i=
ssues/2037 in the commit message?
>
> Sure, can you also give me an rb or acked-by so that I can push it?

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Thanks,
> Christian.
>
> >
> > Thanks,
> > Pierre-Eric
> >
> > On 03/06/2022 12:21, Christian K=C3=B6nig wrote:
> >> The job is not yet initialized here.
> >>
> >> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> Fixes: 1027d5d791b7 ("drm/amdgpu: use job and ib structures directly i=
n CS parsers")
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 17 +++++++----------
> >>   1 file changed, 7 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/a=
md/amdgpu/vcn_v3_0.c
> >> index 3cabceee5f57..39405f0db824 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> >> @@ -1761,23 +1761,21 @@ static const struct amdgpu_ring_funcs vcn_v3_0=
_dec_sw_ring_vm_funcs =3D {
> >>      .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_=
helper,
> >>   };
> >>
> >> -static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
> >> -                            struct amdgpu_job *job)
> >> +static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p)
> >>   {
> >>      struct drm_gpu_scheduler **scheds;
> >>
> >>      /* The create msg must be in the first IB submitted */
> >> -    if (atomic_read(&job->base.entity->fence_seq))
> >> +    if (atomic_read(&p->entity->fence_seq))
> >>              return -EINVAL;
> >>
> >>      scheds =3D p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
> >>              [AMDGPU_RING_PRIO_DEFAULT].sched;
> >> -    drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
> >> +    drm_sched_entity_modify_sched(p->entity, scheds, 1);
> >>      return 0;
> >>   }
> >>
> >> -static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu=
_job *job,
> >> -                        uint64_t addr)
> >> +static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr=
)
> >>   {
> >>      struct ttm_operation_ctx ctx =3D { false, false };
> >>      struct amdgpu_bo_va_mapping *map;
> >> @@ -1848,7 +1846,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_par=
ser *p, struct amdgpu_job *job,
> >>              if (create[0] =3D=3D 0x7 || create[0] =3D=3D 0x10 || crea=
te[0] =3D=3D 0x11)
> >>                      continue;
> >>
> >> -            r =3D vcn_v3_0_limit_sched(p, job);
> >> +            r =3D vcn_v3_0_limit_sched(p);
> >>              if (r)
> >>                      goto out;
> >>      }
> >> @@ -1862,7 +1860,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(struc=
t amdgpu_cs_parser *p,
> >>                                         struct amdgpu_job *job,
> >>                                         struct amdgpu_ib *ib)
> >>   {
> >> -    struct amdgpu_ring *ring =3D to_amdgpu_ring(job->base.sched);
> >> +    struct amdgpu_ring *ring =3D to_amdgpu_ring(p->entity->rq->sched)=
;
> >>      uint32_t msg_lo =3D 0, msg_hi =3D 0;
> >>      unsigned i;
> >>      int r;
> >> @@ -1881,8 +1879,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(struc=
t amdgpu_cs_parser *p,
> >>                      msg_hi =3D val;
> >>              } else if (reg =3D=3D PACKET0(p->adev->vcn.internal.cmd, =
0) &&
> >>                         val =3D=3D 0) {
> >> -                    r =3D vcn_v3_0_dec_msg(p, job,
> >> -                                         ((u64)msg_hi) << 32 | msg_lo=
);
> >> +                    r =3D vcn_v3_0_dec_msg(p, ((u64)msg_hi) << 32 | m=
sg_lo);
> >>                      if (r)
> >>                              return r;
> >>              }
> >>
>
