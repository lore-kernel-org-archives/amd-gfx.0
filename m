Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090E7C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 14:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 802D110E235;
	Mon, 14 Mar 2022 14:05:53 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCA4510E235
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 14:05:51 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id j83so17409670oih.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QtquIvG7ipxv0cTj0hgqjGojaL5MvSLTnQogvrt9p5U=;
 b=BPJogphfxNcR9JosMb/6HSYcm65MbfazbVSsJWVTSuZd/3eWY/o79pZmsuI9unNRB0
 ixlFlqGGdmhsMs7qf1O7tbi/HWq1fpx5OoyAqtPRfJYogRiQMNfQ/IYN47cBtjSUOy8r
 17fEVgYFVxtltavMnKWIg4HR4CR1eQlIIazGPDrD360IDKd9cLBKFEvMqdyp1hTIqxbd
 a02Ryr0sjZvoMyY/LwIgOlIjb2Ptm+WoeLwWoUMkvlaNHAlApt5xwGVTlPMpm3S6eBeT
 Mcy5sKAUVtlkJ/ob8603n4qFi6iOUcm/dDf5oxPrfLnl2IMIPc3TEGGUJP4D8QE4FC31
 chXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QtquIvG7ipxv0cTj0hgqjGojaL5MvSLTnQogvrt9p5U=;
 b=ppMHcKQPb79p7+Ys5SdufzX9cx1l72cVmmU9Q+jOXNivTGLPkyJHVPcNynDN9I41dr
 d0qCXA29zAxCVa2MLm1v7DMzI2kSh7jgDtO59MQYwwSTQvBSUdqlFHlprYtZiNLJP09s
 cjwv2KBShrzxv92rdYh00osaO9ua/20LInQ4cseyT1+A6a0x40scCHcIRkhoH4R3QZ9z
 r5XRTVJ9QaewN5J0gH9FsbAdUoOa6YvtC+Jdb+Gh6rujtb6/0O1kBPMWX1+QEfrVZZnA
 xfRX3LfS9TSWe71tEjZiF7wAG5Mxkf4wDLaleIlC/CcDt4jLubmHyN9lCBt0iRthPAQ4
 mrhg==
X-Gm-Message-State: AOAM5323fs9uk4i9S8aofMOY0/WOekwX5UsTV9dyI+3tuAmGBqiz1bpv
 ZMe+clKSSHAcPZvjRP2bCrEzIlvK0KRb2xsFWbM=
X-Google-Smtp-Source: ABdhPJwUhfIRfMqgoLwPx3wqOlKcgho3pIftLSEN0glD8ufTWF810egE4OCs/vD89t9UM/He3gVjGGHSu1GfSnDIkq0=
X-Received: by 2002:aca:d07:0:b0:2ec:eaaf:a036 with SMTP id
 7-20020aca0d07000000b002eceaafa036mr2907138oin.253.1647266751044; Mon, 14 Mar
 2022 07:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <YicG3THG9sem8Uet@lang-desktop>
 <cbebb9b6-705e-e6fc-9ff0-41c35c3ee94b@gmail.com>
 <YicOku9HhC3wJUb8@lang-desktop> <1c02d3b8-987a-3c4e-d123-6de8fd86dcab@amd.com>
 <ec57da49-8a3f-852b-aaee-5bacdeb56c80@amd.com>
 <95e6f48e-fdc7-e535-1803-080a8d189d33@amd.com>
 <Yim6vIBYKLd3Uqxu@lang-desktop> <f16e10f2-fa3f-7e63-c260-aaf1a70f8011@amd.com>
 <d6c3cf48-7699-7192-5655-4c5bd7f7a37b@amd.com>
 <b1277562-f425-b466-856f-f9590dd9a38a@amd.com>
 <Yiq0sdkgNFw9w8g0@lang-desktop>
In-Reply-To: <Yiq0sdkgNFw9w8g0@lang-desktop>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Mar 2022 10:05:39 -0400
Message-ID: <CADnq5_PTm-GUVMgqTbh1jyOSb8HmWS_-MGm2upW8gL947Z+upA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: add workarounds for Raven VCN TMZ issue
To: Lang Yu <Lang.Yu@amd.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 10, 2022 at 9:32 PM Lang Yu <Lang.Yu@amd.com> wrote:
>
> On 03/10/ , Christian K=C3=B6nig wrote:
> > Ok, thanks.
> >
> > Lang is that case your patch should work fine.
> >
> > Just add another patch with a check for the encode case to reject any C=
S
> > with TMZ buffers in it.
>
> Only VCN decode ring is cared in this patch. For encode ring
> (AMDGPU_HW_IP_VCN_ENC and AMDGPU_HW_IP_VCN_JPEG), is it fine
> we just reject secure IBs in amdgpu_ib_schedule like compute ring?
>

Yes,  correct.

Alex

> Regards,
> Lang
>
> > Thanks,
> > Christian.
> >
> > Am 10.03.22 um 15:17 schrieb Leo Liu:
> > > No need for encode. Encrypting uses TEE/TA to convert clear bitstream=
 to
> > > encrypted bitstream, and has nothing to do with VCN encode and tmz.
> > >
> > > Regards,
> > >
> > > Leo
> > >
> > >
> > > On 2022-03-10 04:53, Christian K=C3=B6nig wrote:
> > > > Leo you didn't answered the question if we need TMZ for encode as w=
ell.
> > > >
> > > > Regards,
> > > > Christian.
> > > >
> > > > Am 10.03.22 um 09:45 schrieb Lang Yu:
> > > > > Ping.
> > > > >
> > > > > On 03/08/ , Leo Liu wrote:
> > > > > > On 2022-03-08 11:18, Leo Liu wrote:
> > > > > > > On 2022-03-08 04:16, Christian K=C3=B6nig wrote:
> > > > > > > > Am 08.03.22 um 09:06 schrieb Lang Yu:
> > > > > > > > > On 03/08/ , Christian K=C3=B6nig wrote:
> > > > > > > > > > Am 08.03.22 um 08:33 schrieb Lang Yu:
> > > > > > > > > > > On 03/08/ , Christian K=C3=B6nig wrote:
> > > > > > > > > > > > Am 08.03.22 um 04:39 schrieb Lang Yu:
> > > > > > > > > > > > > It is a hardware issue that VCN can't handle a GT=
T
> > > > > > > > > > > > > backing stored TMZ buffer on Raven.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Move such a TMZ buffer to VRAM domain before comm=
and
> > > > > > > > > > > > > submission.
> > > > > > > > > > > > >
> > > > > > > > > > > > > v2:
> > > > > > > > > > > > >      - Use patch_cs_in_place callback.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Suggested-by: Christian K=C3=B6nig <christian.koe=
nig@amd.com>
> > > > > > > > > > > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >      drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 68
> > > > > > > > > > > > > +++++++++++++++++++++++++++
> > > > > > > > > > > > >      1 file changed, 68 insertions(+)
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git
> > > > > > > > > > > > > a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > > > > > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > > > > > > > index 7bbb9ba6b80b..810932abd3af 100644
> > > > > > > > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > > > > > > > > > > > @@ -24,6 +24,7 @@
> > > > > > > > > > > > >      #include <linux/firmware.h>
> > > > > > > > > > > > >      #include "amdgpu.h"
> > > > > > > > > > > > > +#include "amdgpu_cs.h"
> > > > > > > > > > > > >      #include "amdgpu_vcn.h"
> > > > > > > > > > > > >      #include "amdgpu_pm.h"
> > > > > > > > > > > > >      #include "soc15.h"
> > > > > > > > > > > > > @@ -1905,6 +1906,72 @@ static const struct
> > > > > > > > > > > > > amd_ip_funcs vcn_v1_0_ip_funcs =3D {
> > > > > > > > > > > > >          .set_powergating_state
> > > > > > > > > > > > > =3D
> > > > > > > > > > > > > vcn_v1_0_set_powergating_state,
> > > > > > > > > > > > >      };
> > > > > > > > > > > > > +/**
> > > > > > > > > > > > > + * It is a hardware issue that Raven VCN can't
> > > > > > > > > > > > > handle a GTT TMZ buffer.
> > > > > > > > > > > > > + * Move such a GTT TMZ buffer to VRAM domain
> > > > > > > > > > > > > before command submission.
> > > > > > > > > > > > > + */
> > > > > > > > > > > > > +static int
> > > > > > > > > > > > > vcn_v1_0_validate_bo(struct
> > > > > > > > > > > > > amdgpu_cs_parser *parser,
> > > > > > > > > > > > > +                struct amdgpu_job *job,
> > > > > > > > > > > > > +                uint64_t addr)
> > > > > > > > > > > > > +{
> > > > > > > > > > > > > +    struct ttm_operation_ctx ctx =3D { false, fa=
lse };
> > > > > > > > > > > > > +    struct amdgpu_fpriv *fpriv =3D parser->filp-=
>driver_priv;
> > > > > > > > > > > > > +    struct amdgpu_vm *vm =3D &fpriv->vm;
> > > > > > > > > > > > > +    struct amdgpu_bo_va_mapping *mapping;
> > > > > > > > > > > > > +    struct amdgpu_bo *bo;
> > > > > > > > > > > > > +    int r;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +    addr &=3D AMDGPU_GMC_HOLE_MASK;
> > > > > > > > > > > > > +    if (addr & 0x7) {
> > > > > > > > > > > > > +        DRM_ERROR("VCN messages must be 8 byte a=
ligned!\n");
> > > > > > > > > > > > > +        return -EINVAL;
> > > > > > > > > > > > > +    }
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +    mapping =3D amdgpu_vm_bo_lookup_mapping(vm,
> > > > > > > > > > > > > addr/AMDGPU_GPU_PAGE_SIZE);
> > > > > > > > > > > > > +    if (!mapping ||
> > > > > > > > > > > > > !mapping->bo_va ||
> > > > > > > > > > > > > !mapping->bo_va->base.bo)
> > > > > > > > > > > > > +        return -EINVAL;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +    bo =3D mapping->bo_va->base.bo;
> > > > > > > > > > > > > +    if (!(bo->flags & AMDGPU_GEM_CREATE_ENCRYPTE=
D))
> > > > > > > > > > > > > +        return 0;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +
> > > > > > > > > > > > > amdgpu_bo_placement_from_domain(bo,
> > > > > > > > > > > > > AMDGPU_GEM_DOMAIN_VRAM);
> > > > > > > > > > > > > +    r =3D ttm_bo_validate(&bo->tbo, &bo->placeme=
nt, &ctx);
> > > > > > > > > > > > > +    if (r) {
> > > > > > > > > > > > > +        DRM_ERROR("Failed validating the VCN
> > > > > > > > > > > > > message BO (%d)!\n", r);
> > > > > > > > > > > > > +        return r;
> > > > > > > > > > > > > +    }
> > > > > > > > > > > > Well, exactly that won't work.
> > > > > > > > > > > >
> > > > > > > > > > > > The message structure isn't TMZ protected because
> > > > > > > > > > > > otherwise the driver won't
> > > > > > > > > > > > be able to stitch it together.
> > > > > > > > > > > >
> > > > > > > > > > > > What is TMZ protected are the surfaces the message
> > > > > > > > > > > > structure is pointing to.
> > > > > > > > > > > > So what you would need to do is to completely parse
> > > > > > > > > > > > the structure and then
> > > > > > > > > > > > move on the relevant buffers into VRAM.
> > > > > > > > > > > >
> > > > > > > > > > > > Leo or James, can you help with that?
> > > > > > > > > > >    From my observations, when decoding secure content=
s, register
> > > > > > > > > > > GPCOM_VCPU_DATA0 and GPCOM_VCPU_DATA1 are set to a TM=
Z
> > > > > > > > > > > buffer address.
> > > > > > > > > > > And this way works when allocating TMZ buffers in GTT=
 domain.
> > > > > > > > > > As far as I remember that's only the case for the decod=
ing,
> > > > > > > > > > encoding works
> > > > > > > > > > by putting the addresses into the message buffer.
> > > > > > > > > >
> > > > > > > > > > But could be that decoding is sufficient, Leo and James=
 need
> > > > > > > > > > to comment on
> > > > > > > > > > this.
> > > > > > > > > It seems that only decode needs TMZ buffers. Only observe
> > > > > > > > > si_vid_create_tmz_buffer()
> > > > > > > > > was called in rvcn_dec_message_decode() in
> > > > > > > > > src/gallium/drivers/radeon/radeon_vcn_dec.c.
> > > > > > > > Mhm, good point. Let's wait for Leo and James to wake up, w=
hen we
> > > > > > > > don't need encode support than that would makes things much=
 easier.
> > > > > > > For secure playback, the buffer required in TMZ are dpb,
> > > > > > > dt and ctx, for
> > > > > > > the rest esp. those for CPU access don't need that E.g.
> > > > > > > msg buffer, and
> > > > > > > bitstream buffer.
> > > > > > >
> > > > > > >  From radeon_vcn_dec.c, you can see the buffer for dpb
> > > > > > > and ctx, and dt
> > > > > > > buffer frontend/va/surface is set to PIPE_BIND_PROTECTED.
> > > > > > >
> > > > > > >
> > > > > > > Regards,
> > > > > > >
> > > > > > > Leo
> > > > > > >
> > > > > > For VCN1, due to performance reason, the msg and fb buffer
> > > > > > was allocated
> > > > > > into VRAM instead of GTT(for other HW), but those are not
> > > > > > TMZ in order to
> > > > > > have CPU access.
> > > > > >
> > > > > >
> > > > > > Regards,
> > > > > >
> > > > > > Leo
> > > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > > Regards,
> > > > > > > > Christian.
> > > > > > > >
> > > > > > > > > Regards,
> > > > > > > > > Lang
> > > > > > > > >
> > > > > > > > > > Regards,
> > > > > > > > > > Christian.
> > > > > > > > > >
> > > > > > > > > > > Regards,
> > > > > > > > > > > Lang
> > > > > > > > > > >
> > > > > > > > > > > > Regards,
> > > > > > > > > > > > Christian.
> > > > > > > > > > > >
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +    return r;
> > > > > > > > > > > > > +}
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +static int
> > > > > > > > > > > > > vcn_v1_0_ring_patch_cs_in_place(struct
> > > > > > > > > > > > > amdgpu_cs_parser *p,
> > > > > > > > > > > > > +                       struct amdgpu_job *job,
> > > > > > > > > > > > > +                       struct amdgpu_ib *ib)
> > > > > > > > > > > > > +{
> > > > > > > > > > > > > +    uint32_t msg_lo =3D 0, msg_hi =3D 0;
> > > > > > > > > > > > > +    int i, r;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +    for (i =3D 0; i < ib->length_dw; i +=3D 2) {
> > > > > > > > > > > > > +        uint32_t reg =3D amdgpu_ib_get_value(ib,=
 i);
> > > > > > > > > > > > > +        uint32_t val =3D amdgpu_ib_get_value(ib,=
 i + 1);
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +        if (reg =3D=3D PACKET0(p->adev->vcn.inte=
rnal.data0, 0)) {
> > > > > > > > > > > > > +            msg_lo =3D val;
> > > > > > > > > > > > > +        } else if (reg =3D=3D
> > > > > > > > > > > > > PACKET0(p->adev->vcn.internal.data1, 0)) {
> > > > > > > > > > > > > +            msg_hi =3D val;
> > > > > > > > > > > > > +        } else if (reg =3D=3D
> > > > > > > > > > > > > PACKET0(p->adev->vcn.internal.cmd,
> > > > > > > > > > > > > 0)) {
> > > > > > > > > > > > > +            r =3D vcn_v1_0_validate_bo(p, job,
> > > > > > > > > > > > > +                         ((u64)msg_hi) << 32 | m=
sg_lo);
> > > > > > > > > > > > > +            if (r)
> > > > > > > > > > > > > +                return r;
> > > > > > > > > > > > > +        }
> > > > > > > > > > > > > +    }
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +    return 0;
> > > > > > > > > > > > > +}
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +
> > > > > > > > > > > > >      static const struct amdgpu_ring_funcs
> > > > > > > > > > > > > vcn_v1_0_dec_ring_vm_funcs =3D {
> > > > > > > > > > > > >          .type =3D AMDGPU_RING_TYPE_VCN_DEC,
> > > > > > > > > > > > >          .align_mask =3D 0xf,
> > > > > > > > > > > > > @@ -1914,6 +1981,7 @@ static const struct
> > > > > > > > > > > > > amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs =3D =
{
> > > > > > > > > > > > >          .get_rptr =3D vcn_v1_0_dec_ring_get_rptr=
,
> > > > > > > > > > > > >          .get_wptr =3D vcn_v1_0_dec_ring_get_wptr=
,
> > > > > > > > > > > > >          .set_wptr =3D vcn_v1_0_dec_ring_set_wptr=
,
> > > > > > > > > > > > > +    .patch_cs_in_place =3D vcn_v1_0_ring_patch_c=
s_in_place,
> > > > > > > > > > > > >          .emit_frame_size =3D
> > > > > > > > > > > > >              6 + 6 + /* hdp invalidate / flush */
> > > > > > > > > > > > >              SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
> > > >
> >
