Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C4EC43334
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 20:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D72E10E515;
	Tue,  7 Jun 2022 20:23:10 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB51E10E515
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 20:23:09 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-f2cbceefb8so24596185fac.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jun 2022 13:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vxKpV6vfY5kZOoS6ZFAp/bUIG3sCjIjN976Rd+MTAIs=;
 b=dYArv53EyHExal3NCFL+wiub3F2clYLCfEIKJfNf0/hfOtuG8CmJBdvIQLv0b2AWc4
 4FPobrA87Cw06CyXu5SeRj3NINMpHqnH/s+46V8RuxKSSsX6pswszu1Mrc7KYSUpPs7G
 ylUQmq9vnluholcZx2gRK2SpFeOgQ2HzR0kWjqkQ6DLXhZeOIumFNPEFwRCds8Ew0toE
 hREp+dcPGxwSoAJbbq9ecaO0mL0P5XMykyrty5oYe/d6WzDwmClhZ7EPgy+iE2UFVGol
 MRqbzSBVMDntHIqfx9iI9d6uPtR0ydH0pwffUcykifZyXqpqTagkHkgOlq+z4OZ9RTVZ
 foxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vxKpV6vfY5kZOoS6ZFAp/bUIG3sCjIjN976Rd+MTAIs=;
 b=CKBCAZsfJpz3qdmbHw9niWrBPzZQJ6Jq74pit9OCy3syudXsXDLU5s4cq+I1UGjO9O
 gO7W9RF0mwsE9gAG3cEwaCgYleTm1V1etbznQHuMaN3nxFT4VGp0Idr0dYxb9rG5JN6/
 HQcvdTsp/K3R/TLefBRkKqQvD/B7MyYJ8vPBhOLnOVt7idqjGHbA17N1ayR5tKSdmFP9
 QqFSLApsUxRvj8GEJ+CBrabvWRvlRy4ECPHxhQuqG+GQIt24ExA1ijUNAqgBAMbPgu+g
 gnwa8XfEiUeV/+gnwO2/dFE4WCZ6A30wsqr+Ke6Wn40lAE3VRtnjiRq5QG8/Drv6KD63
 xIbg==
X-Gm-Message-State: AOAM53036Umgp6lMF7Fjd8gDwNSZx+pJFy5NgvDQeLeYBKt75keUC26h
 EsjLLJjCLb5mN1AM233vqKBa//9q2UKrxhzPZEDxrAWy
X-Google-Smtp-Source: ABdhPJymnJvgQzM+M68j/2fzQB+j8SXyK+B/RIOVwFTOeMQneoiqMcnf0MD0E/DDICBmolqRSEOe98aWhg0447j8jfs=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr395853oap.253.1654633389018; Tue, 07 Jun
 2022 13:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220603102106.149508-1-christian.koenig@amd.com>
 <cd4958ab-897e-d8b0-76bb-0f6045a542d3@amd.com>
 <5f7710f2-7d66-e48f-dab8-c99177743c92@gmail.com>
 <CADnq5_NS49jdkQuXK58CdfShNW9j1q4HwXtBZtqJ2m3MACD8uA@mail.gmail.com>
 <CADnq5_OEsnjhmp_g0zXjNjAfv=0uN2jq79wTMtxnae_OYjUEjw@mail.gmail.com>
 <CH2PR12MB3927CE81E4A14A41359DC1FB95A59@CH2PR12MB3927.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB3927CE81E4A14A41359DC1FB95A59@CH2PR12MB3927.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jun 2022 16:22:57 -0400
Message-ID: <CADnq5_Pq8M4AgjtwknyKmb1p8RqFYuxYb0b2B2-tpiVTqqWKDA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix limiting AV1 to the first instance on VCN3
To: "Dong, Ruijing" <Ruijing.Dong@amd.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Pelloux-Prayer,
 Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We'll need to implement the parse callbacks for vcn4 as well if we
haven't already.

Alex

On Tue, Jun 7, 2022 at 4:20 PM Dong, Ruijing <Ruijing.Dong@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> I can see for VCN4, AV1 dec/enc also need to limit to the first instance.
>
> Thanks,
> Ruijing
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Friday, June 3, 2022 10:12 AM
> To: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> Cc: Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>; amd=
-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amdgpu: fix limiting AV1 to the first instance o=
n VCN3
>
> Do the other uvd/vce/vcn ring parse functions need a similar fix?
>
> Alex
>
>
> On Fri, Jun 3, 2022 at 10:08 AM Alex Deucher <alexdeucher@gmail.com> wrot=
e:
> >
> > On Fri, Jun 3, 2022 at 8:10 AM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> > >
> > > Am 03.06.22 um 14:08 schrieb Pierre-Eric Pelloux-Prayer:
> > > > Hi Christian,
> > > >
> > > > The patch is: Tested-by: Pierre-Eric Pelloux-Prayer
> > > > <pierre-eric.pelloux-prayer@amd.com>
> > > >
> > > > Could you add a reference to https://nam11.safelinks.protection.out=
look.com/?url=3Dhttps%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissu=
es%2F2037&amp;data=3D05%7C01%7CRuijing.Dong%40amd.com%7C5ba73dfe91ba47e21dd=
608da456b0609%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6378986232218060=
51%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h=
aWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DWgIZD299Xe0XVG%2Ftb2rn14njS%=
2FgHIhtIHIDAZ2Fj40k%3D&amp;reserved=3D0 in the commit message?
> > >
> > > Sure, can you also give me an rb or acked-by so that I can push it?
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > >
> > > Thanks,
> > > Christian.
> > >
> > > >
> > > > Thanks,
> > > > Pierre-Eric
> > > >
> > > > On 03/06/2022 12:21, Christian K=C3=B6nig wrote:
> > > >> The job is not yet initialized here.
> > > >>
> > > >> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > >> Fixes: 1027d5d791b7 ("drm/amdgpu: use job and ib structures
> > > >> directly in CS parsers")
> > > >> ---
> > > >>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 17 +++++++----------
> > > >>   1 file changed, 7 insertions(+), 10 deletions(-)
> > > >>
> > > >> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > >> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > >> index 3cabceee5f57..39405f0db824 100644
> > > >> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > >> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > >> @@ -1761,23 +1761,21 @@ static const struct amdgpu_ring_funcs vcn_=
v3_0_dec_sw_ring_vm_funcs =3D {
> > > >>      .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_w=
ait_helper,
> > > >>   };
> > > >>
> > > >> -static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
> > > >> -                            struct amdgpu_job *job)
> > > >> +static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p)
> > > >>   {
> > > >>      struct drm_gpu_scheduler **scheds;
> > > >>
> > > >>      /* The create msg must be in the first IB submitted */
> > > >> -    if (atomic_read(&job->base.entity->fence_seq))
> > > >> +    if (atomic_read(&p->entity->fence_seq))
> > > >>              return -EINVAL;
> > > >>
> > > >>      scheds =3D p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
> > > >>              [AMDGPU_RING_PRIO_DEFAULT].sched;
> > > >> -    drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
> > > >> +    drm_sched_entity_modify_sched(p->entity, scheds, 1);
> > > >>      return 0;
> > > >>   }
> > > >>
> > > >> -static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct am=
dgpu_job *job,
> > > >> -                        uint64_t addr)
> > > >> +static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t
> > > >> +addr)
> > > >>   {
> > > >>      struct ttm_operation_ctx ctx =3D { false, false };
> > > >>      struct amdgpu_bo_va_mapping *map; @@ -1848,7 +1846,7 @@
> > > >> static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amd=
gpu_job *job,
> > > >>              if (create[0] =3D=3D 0x7 || create[0] =3D=3D 0x10 || =
create[0] =3D=3D 0x11)
> > > >>                      continue;
> > > >>
> > > >> -            r =3D vcn_v3_0_limit_sched(p, job);
> > > >> +            r =3D vcn_v3_0_limit_sched(p);
> > > >>              if (r)
> > > >>                      goto out;
> > > >>      }
> > > >> @@ -1862,7 +1860,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(s=
truct amdgpu_cs_parser *p,
> > > >>                                         struct amdgpu_job *job,
> > > >>                                         struct amdgpu_ib *ib)
> > > >>   {
> > > >> -    struct amdgpu_ring *ring =3D to_amdgpu_ring(job->base.sched);
> > > >> +    struct amdgpu_ring *ring =3D
> > > >> + to_amdgpu_ring(p->entity->rq->sched);
> > > >>      uint32_t msg_lo =3D 0, msg_hi =3D 0;
> > > >>      unsigned i;
> > > >>      int r;
> > > >> @@ -1881,8 +1879,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(s=
truct amdgpu_cs_parser *p,
> > > >>                      msg_hi =3D val;
> > > >>              } else if (reg =3D=3D PACKET0(p->adev->vcn.internal.c=
md, 0) &&
> > > >>                         val =3D=3D 0) {
> > > >> -                    r =3D vcn_v3_0_dec_msg(p, job,
> > > >> -                                         ((u64)msg_hi) << 32 | ms=
g_lo);
> > > >> +                    r =3D vcn_v3_0_dec_msg(p, ((u64)msg_hi) << 32
> > > >> + | msg_lo);
> > > >>                      if (r)
> > > >>                              return r;
> > > >>              }
> > > >>
> > >
