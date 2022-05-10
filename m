Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C5FC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 13:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A841C10F982;
	Tue, 10 May 2022 13:21:51 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7694610F983
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 13:21:50 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-ee1e7362caso14118626fac.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 06:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=x48e/jIz/Eimg57HuFCm6GmPSC9pGBEcnmUV1VDLLtE=;
 b=gCkMnSnHrqW3I6EkpkP8ByKviNNXtTqe4Nu6q5GuWQJtmwR+TerKUuvrZ7QngWkioP
 Msnk3b0twV2Zo8DfAjjtbiIrGdtZHNxNxGENp7eJQn6kSxvodMcDhnKoop98EVCwothm
 5ITnCzuU6W4Cdbmjtclo3wdwGXyCeQIYzbTsZAPSOD7b7ob8a18ocqMDcOk1ZoasKCpa
 +gUCPOijnJcOnAqwRFw7WgS7NzeOJO8tKXB3KLija6svTPokfBOO1q46hcPNEW2ZwMfE
 b9EBcG9q48mDjsGdpdhLNhgU4/Du012kdqOtm1dbD8KAPH2/50cJuvN+UZraVo1oa6o2
 6eKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=x48e/jIz/Eimg57HuFCm6GmPSC9pGBEcnmUV1VDLLtE=;
 b=o3toTp6ipzwZeMuJFrJaCXzdAFnjkBWU25R5sXc6xp3OAkL5PL3KWKOv1y+2jBFtpv
 pZUVar7voYczrutTUiSipsGy+o0myLAOd8lBEbn274FrpQ2FgihadLxOOIzI1QiH+w/e
 sqs+KOLrTkOE/D7joasgkb9k5nSurllhG73azTHxXNe7lwixeOqkGVB5Ln5CbLrJAqQ6
 aeVom6fBD6Oghh/RAJekIkfgB6GtnOLJ1mmMJMcq0fCz3O5z2edk5uOzjbmdLdmclr7t
 tvEClHjLxQlJyIsRhi5fT25EDK3YzgADHMne48Cqtg91KHr3Xup4usMO5RM9zetyu0Bu
 zugg==
X-Gm-Message-State: AOAM530i1mq0GmwI1SMJD+2jHcH612WnqtQsdw/JKLyp3+kjSIcSJqXp
 G+CimeFSeoUqD43aN1LUA25FEVi8BaAggOQ/e9Y=
X-Google-Smtp-Source: ABdhPJwJVKeOvCw48HzBzzuNXCQLMwcSETKoqTFKCEKrllYGaxctA0rBpS+yLbhkGfeWhsAV8wF95+MPpkAQ1i3Agqk=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr8334oaa.200.1652188909689; Tue, 10 May
 2022 06:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220509190657.478625-1-alexander.deucher@amd.com>
 <661503a2-064f-476d-3683-d7a0bd40fb16@molgen.mpg.de>
In-Reply-To: <661503a2-064f-476d-3683-d7a0bd40fb16@molgen.mpg.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 May 2022 09:21:38 -0400
Message-ID: <CADnq5_Prf8KYwTqiqCn7LDvUimNUR3_rxyE_g2NLbDiVtReO7A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx11: fix mes mqd settings and map_queue
 packet
To: Paul Menzel <pmenzel@molgen.mpg.de>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 10, 2022 at 3:30 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Alex, dear Jack,
>
>
> Thank you for the patch.
>
> Am 09.05.22 um 21:06 schrieb Alex Deucher:
> > From: Jack Xiao <Jack.Xiao@amd.com>
> >
> > a. use correct mes mqd settings
>
> Can you please elaborate? What is wrong with the old ones, and what are
> the correct ones?

Use the gfx11 mqd structures rather than the gfx10 structures.

>
> > b. fix me field in map_queue packet
>
> Can you please add some background? The new value is 2. What does it do?

The ME is the microengine.  You need to select the right engine based
on the queue type.

>
> It=E2=80=99d be great, if you could make it two patches.
>
> > Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> > Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c |  7 +++++--
> >   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 20 ++++++++++----------
> >   2 files changed, 15 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v11_0.c
> > index 7614f38ff381..8a1bec70c719 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -145,16 +145,19 @@ static void gfx11_kiq_map_queues(struct amdgpu_ri=
ng *kiq_ring,
> >   {
> >       uint64_t mqd_addr =3D amdgpu_bo_gpu_offset(ring->mqd_obj);
> >       uint64_t wptr_addr =3D ring->wptr_gpu_addr;
> > -     uint32_t eng_sel =3D 0;
> > +     uint32_t me =3D 0, eng_sel =3D 0;
> >
> >       switch (ring->funcs->type) {
> >       case AMDGPU_RING_TYPE_COMPUTE:
> > +             me =3D 1;
> >               eng_sel =3D 0;
> >               break;
> >       case AMDGPU_RING_TYPE_GFX:
> > +             me =3D 0;
> >               eng_sel =3D 4;
> >               break;
> >       case AMDGPU_RING_TYPE_MES:
> > +             me =3D 2;
> >               eng_sel =3D 5;
> >               break;
> >       default:
> > @@ -168,7 +171,7 @@ static void gfx11_kiq_map_queues(struct amdgpu_ring=
 *kiq_ring,
> >                         PACKET3_MAP_QUEUES_VMID(0) | /* VMID */
> >                         PACKET3_MAP_QUEUES_QUEUE(ring->queue) |
> >                         PACKET3_MAP_QUEUES_PIPE(ring->pipe) |
> > -                       PACKET3_MAP_QUEUES_ME((ring->me =3D=3D 1 ? 0 : =
1)) |
> > +                       PACKET3_MAP_QUEUES_ME((me)) |
> >                         PACKET3_MAP_QUEUES_QUEUE_TYPE(0) | /*queue_type=
: normal compute queue */
> >                         PACKET3_MAP_QUEUES_ALLOC_FORMAT(0) | /* alloc f=
ormat: all_on_one_pipe */
> >                         PACKET3_MAP_QUEUES_ENGINE_SEL(eng_sel) |
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/mes_v11_0.c
> > index 5d4d54cabf70..fcf51947bb18 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > @@ -29,7 +29,7 @@
> >   #include "gc/gc_11_0_0_offset.h"
> >   #include "gc/gc_11_0_0_sh_mask.h"
> >   #include "gc/gc_11_0_0_default.h"
> > -#include "v10_structs.h"
> > +#include "v11_structs.h"
> >   #include "mes_v11_api_def.h"
> >
> >   MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes.bin");
> > @@ -637,7 +637,7 @@ static int mes_v11_0_allocate_eop_buf(struct amdgpu=
_device *adev,
> >
> >   static int mes_v11_0_mqd_init(struct amdgpu_ring *ring)
> >   {
> > -     struct v10_compute_mqd *mqd =3D ring->mqd_ptr;
> > +     struct v11_compute_mqd *mqd =3D ring->mqd_ptr;
> >       uint64_t hqd_gpu_addr, wb_gpu_addr, eop_base_addr;
> >       uint32_t tmp;
> >
> > @@ -724,22 +724,22 @@ static int mes_v11_0_mqd_init(struct amdgpu_ring =
*ring)
> >       mqd->cp_hqd_vmid =3D 0;
> >       /* activate the queue */
> >       mqd->cp_hqd_active =3D 1;
> > -     mqd->cp_hqd_persistent_state =3D regCP_HQD_PERSISTENT_STATE_DEFAU=
LT;
> > +
> > +     tmp =3D regCP_HQD_PERSISTENT_STATE_DEFAULT;
> > +     tmp =3D REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE,
> > +                         PRELOAD_SIZE, 0x55);
> > +     mqd->cp_hqd_persistent_state =3D tmp;
> > +
> >       mqd->cp_hqd_ib_control =3D regCP_HQD_IB_CONTROL_DEFAULT;
> >       mqd->cp_hqd_iq_timer =3D regCP_HQD_IQ_TIMER_DEFAULT;
> >       mqd->cp_hqd_quantum =3D regCP_HQD_QUANTUM_DEFAULT;
> >
> > -     tmp =3D regCP_HQD_GFX_CONTROL_DEFAULT;
> > -     tmp =3D REG_SET_FIELD(tmp, CP_HQD_GFX_CONTROL, DB_UPDATED_MSG_EN,=
 1);
> > -     /* offset: 184 - this is used for CP_HQD_GFX_CONTROL */
> > -     mqd->cp_hqd_suspend_cntl_stack_offset =3D tmp;
> > -
>
> What was wrong with this?

It doesn't exist in the gfx11 structure.

Alex

>
>
> Kind regards,
>
> Paul
>
>
> >       return 0;
> >   }
> >
> >   static void mes_v11_0_queue_init_register(struct amdgpu_ring *ring)
> >   {
> > -     struct v10_compute_mqd *mqd =3D ring->mqd_ptr;
> > +     struct v11_compute_mqd *mqd =3D ring->mqd_ptr;
> >       struct amdgpu_device *adev =3D ring->adev;
> >       uint32_t data =3D 0;
> >
> > @@ -910,7 +910,7 @@ static int mes_v11_0_kiq_ring_init(struct amdgpu_de=
vice *adev)
> >   static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
> >                                enum admgpu_mes_pipe pipe)
> >   {
> > -     int r, mqd_size =3D sizeof(struct v10_compute_mqd);
> > +     int r, mqd_size =3D sizeof(struct v11_compute_mqd);
> >       struct amdgpu_ring *ring;
> >
> >       if (pipe =3D=3D AMDGPU_MES_KIQ_PIPE)
