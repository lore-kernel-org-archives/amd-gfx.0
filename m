Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7899C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 14:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4974310E2D7;
	Fri,  3 Jun 2022 14:11:58 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82E6E10E359
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 14:11:56 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-f2cbceefb8so10710784fac.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Jun 2022 07:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EHg/gK2/zj5xirIjckPsVbQWuF97sc8NOmmttkqFJmE=;
 b=U3uBv9JSBFpyruARhN8Vqrl6gZYp7srH3niURvvmMfeH2GZsndnmcM21lr/USvuP+W
 2QJ9fKdv6a2SA+G5KD/ys3kOTEyMtIgvc9RlUuk3WjTJe7wOP1/fpKcZrkqRXGfftdQe
 Y9sjvN/j/QR8VhXEX/H0ePUecbqd9+k2q07Yo9HYZ8QOp7zyF30LOJ0xc0GEa/Zo2Yo8
 oiW7zPeAie9eTcpThSL5e+/p0XLz6THjl7CNqYgChYii5mrU70WZBxQVqI+Ykh4yY8aV
 /Cmv6pM3YIxPKEHKsHpDJFh+CqWF7KIAg3MBmMQ3Wgk+dYYQCB6gIeZW4IVR5Ybbg7U7
 zBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EHg/gK2/zj5xirIjckPsVbQWuF97sc8NOmmttkqFJmE=;
 b=7I3l5VqpxF9FM3FwlgT6Qj4I/tmZTKUxo2wmf0VM5I/cPFp0AfXgxDca/uJRzMz3Z/
 iT25xG/sKU3Rln6tbksHDLA+TpKC98oVUtRIZ0ZEkTtegD16ukWnEfEif21hxwZsTMm6
 3P4zBCSrdCGJjeUqu1LqTAwFSxUzn/rkaUL0+x6UeOcNEvMDoPHFzZXSl7oXJ4SViEpt
 7I+gfL1YuzOopQA1wfJt8iTDk6btjQrlIgLeG6aSVQzFtdjBguV+xImOX8yyIjW2qXCL
 jtzbWGOPDT5r4+mDrnXVfJ2reBtgtgNh9W/NkXV/CFEbDWvrxJKxiQ+dFrnck2LUfLRX
 Th/Q==
X-Gm-Message-State: AOAM533sOIKJjjtdeOh+bK6LE4wk4xGxQWW78yzB4cZdhVux8iMG7etD
 iGjK4ZJRtlYQFlm2tb/GatEVpRaCfl25dbH9vJqAoH9W
X-Google-Smtp-Source: ABdhPJx/EA/z2zdRooJJCwvPhF7X8uBiqLI/2womH5xY4WqkQYb9WhcfAYOCf0xkjHAYxLCUsf1/PrAepQomzaWlcLk=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr5893818oap.253.1654265515608; Fri, 03
 Jun 2022 07:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220603102106.149508-1-christian.koenig@amd.com>
 <cd4958ab-897e-d8b0-76bb-0f6045a542d3@amd.com>
 <5f7710f2-7d66-e48f-dab8-c99177743c92@gmail.com>
 <CADnq5_NS49jdkQuXK58CdfShNW9j1q4HwXtBZtqJ2m3MACD8uA@mail.gmail.com>
In-Reply-To: <CADnq5_NS49jdkQuXK58CdfShNW9j1q4HwXtBZtqJ2m3MACD8uA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Jun 2022 10:11:44 -0400
Message-ID: <CADnq5_OEsnjhmp_g0zXjNjAfv=0uN2jq79wTMtxnae_OYjUEjw@mail.gmail.com>
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

Do the other uvd/vce/vcn ring parse functions need a similar fix?

Alex


On Fri, Jun 3, 2022 at 10:08 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Fri, Jun 3, 2022 at 8:10 AM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > Am 03.06.22 um 14:08 schrieb Pierre-Eric Pelloux-Prayer:
> > > Hi Christian,
> > >
> > > The patch is: Tested-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pell=
oux-prayer@amd.com>
> > >
> > > Could you add a reference to https://gitlab.freedesktop.org/drm/amd/-=
/issues/2037 in the commit message?
> >
> > Sure, can you also give me an rb or acked-by so that I can push it?
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> >
> > Thanks,
> > Christian.
> >
> > >
> > > Thanks,
> > > Pierre-Eric
> > >
> > > On 03/06/2022 12:21, Christian K=C3=B6nig wrote:
> > >> The job is not yet initialized here.
> > >>
> > >> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > >> Fixes: 1027d5d791b7 ("drm/amdgpu: use job and ib structures directly=
 in CS parsers")
> > >> ---
> > >>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 17 +++++++----------
> > >>   1 file changed, 7 insertions(+), 10 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm=
/amd/amdgpu/vcn_v3_0.c
> > >> index 3cabceee5f57..39405f0db824 100644
> > >> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > >> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > >> @@ -1761,23 +1761,21 @@ static const struct amdgpu_ring_funcs vcn_v3=
_0_dec_sw_ring_vm_funcs =3D {
> > >>      .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wai=
t_helper,
> > >>   };
> > >>
> > >> -static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
> > >> -                            struct amdgpu_job *job)
> > >> +static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p)
> > >>   {
> > >>      struct drm_gpu_scheduler **scheds;
> > >>
> > >>      /* The create msg must be in the first IB submitted */
> > >> -    if (atomic_read(&job->base.entity->fence_seq))
> > >> +    if (atomic_read(&p->entity->fence_seq))
> > >>              return -EINVAL;
> > >>
> > >>      scheds =3D p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
> > >>              [AMDGPU_RING_PRIO_DEFAULT].sched;
> > >> -    drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
> > >> +    drm_sched_entity_modify_sched(p->entity, scheds, 1);
> > >>      return 0;
> > >>   }
> > >>
> > >> -static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdg=
pu_job *job,
> > >> -                        uint64_t addr)
> > >> +static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t ad=
dr)
> > >>   {
> > >>      struct ttm_operation_ctx ctx =3D { false, false };
> > >>      struct amdgpu_bo_va_mapping *map;
> > >> @@ -1848,7 +1846,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_p=
arser *p, struct amdgpu_job *job,
> > >>              if (create[0] =3D=3D 0x7 || create[0] =3D=3D 0x10 || cr=
eate[0] =3D=3D 0x11)
> > >>                      continue;
> > >>
> > >> -            r =3D vcn_v3_0_limit_sched(p, job);
> > >> +            r =3D vcn_v3_0_limit_sched(p);
> > >>              if (r)
> > >>                      goto out;
> > >>      }
> > >> @@ -1862,7 +1860,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(str=
uct amdgpu_cs_parser *p,
> > >>                                         struct amdgpu_job *job,
> > >>                                         struct amdgpu_ib *ib)
> > >>   {
> > >> -    struct amdgpu_ring *ring =3D to_amdgpu_ring(job->base.sched);
> > >> +    struct amdgpu_ring *ring =3D to_amdgpu_ring(p->entity->rq->sche=
d);
> > >>      uint32_t msg_lo =3D 0, msg_hi =3D 0;
> > >>      unsigned i;
> > >>      int r;
> > >> @@ -1881,8 +1879,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(str=
uct amdgpu_cs_parser *p,
> > >>                      msg_hi =3D val;
> > >>              } else if (reg =3D=3D PACKET0(p->adev->vcn.internal.cmd=
, 0) &&
> > >>                         val =3D=3D 0) {
> > >> -                    r =3D vcn_v3_0_dec_msg(p, job,
> > >> -                                         ((u64)msg_hi) << 32 | msg_=
lo);
> > >> +                    r =3D vcn_v3_0_dec_msg(p, ((u64)msg_hi) << 32 |=
 msg_lo);
> > >>                      if (r)
> > >>                              return r;
> > >>              }
> > >>
> >
