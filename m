Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05C2C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 15:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FBA510E2BE;
	Tue,  8 Mar 2022 15:15:08 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86F9010E2BE
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 15:15:06 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id s207so2369404oie.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Mar 2022 07:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jk9Hqvn2+LDQnjWqt9l6eoqKpLsdojCyq8UcDLbfej4=;
 b=nnwcR0BphbBVbSMxgm1mghoS6LlABjOM7z1ClRB2TRxppXCY+MzNtp3x8idIC/WO+M
 i2VMsTfB8bDb/BSLOIOtMeZSh/2Gthrn1543rQIqB9E5TBrxniUgN/gX3w5PqGqppKUL
 4U13z11N5/dSoCt/M+t7UVC7xUqgG6TEGFvCyvb0U4aMDuN8kNapCcP0Wx4Rm/JetDCw
 Zg2x4CXCxfWmZGnDYGAbRmgogDR9gI0c91nwG1g+g8dNivnR4MBaZHtttF76cQ/ZvC8U
 R4afwoxwfhxMP9oJOgIn4Gu78REkkPXMlZ9U40OkvpjZn89CkGOFynBTq9mzDqlYYtbj
 751Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jk9Hqvn2+LDQnjWqt9l6eoqKpLsdojCyq8UcDLbfej4=;
 b=Nec+icKgzdHKnlsrM8J212Q0ga6FHXlw/d0LrXSbBduAcOJDyD4jnlD6A5zYA+8cSm
 uItvZq1chqUp7e3Mp+7OfRQECw8/x6amvMCvEQyeH47Ea12ycKJyqmC4ckrjTzR04nBd
 N6HHHr6h+nx5hMTTRgNnElVcBAt9ITPqaXyD8i24hDGhVCq/LMWDSp/Fa0FtU6ed/nB6
 33PBUKrrpzeVAoLF2X/knmO7hUMSSbly4W6btaPTyaqIa91EiN3Tp5m2U0Sr+Tbt6uMB
 7xyVfe7TRw/lAqg1htKNyDHu/6FctK/HM5uoZlOMBW4PlefhHoG8fjqefXA1yL3rvrd3
 N9pA==
X-Gm-Message-State: AOAM533rRQUwlDARo1Y1M1UnvC77CIYOgNKf87l1ZGsgHjHPCcT892nj
 9rkXRumfcyCrCu5F6Zcj8BBoSGle+V0p4OFaacM=
X-Google-Smtp-Source: ABdhPJwlx6QlXfbFiSIyRJbRR8EGbdJjasvdHJ/13SOor9X92M/CFpIBkyt/HPuPvYcpDgdKakWU4RY5gWxCOCxpqD4=
X-Received: by 2002:a05:6808:140a:b0:2da:8c3:c92d with SMTP id
 w10-20020a056808140a00b002da08c3c92dmr2783034oiv.200.1646752505825; Tue, 08
 Mar 2022 07:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20220308033941.999933-1-Lang.Yu@amd.com>
 <0f785eed-9b48-9782-c817-30fbb24eaf4f@gmail.com>
 <YicG3THG9sem8Uet@lang-desktop>
 <cbebb9b6-705e-e6fc-9ff0-41c35c3ee94b@gmail.com>
 <YicOku9HhC3wJUb8@lang-desktop> <1c02d3b8-987a-3c4e-d123-6de8fd86dcab@amd.com>
In-Reply-To: <1c02d3b8-987a-3c4e-d123-6de8fd86dcab@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Mar 2022 10:14:54 -0500
Message-ID: <CADnq5_PQF9srEfsqctbyowfz0gxP9c70ibbOn__wsDvvQimVFA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: add workarounds for Raven VCN TMZ issue
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: "Liu, Leo" <Leo.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 8, 2022 at 4:16 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 08.03.22 um 09:06 schrieb Lang Yu:
> > On 03/08/ , Christian K=C3=B6nig wrote:
> >> Am 08.03.22 um 08:33 schrieb Lang Yu:
> >>> On 03/08/ , Christian K=C3=B6nig wrote:
> >>>> Am 08.03.22 um 04:39 schrieb Lang Yu:
> >>>>> It is a hardware issue that VCN can't handle a GTT
> >>>>> backing stored TMZ buffer on Raven.
> >>>>>
> >>>>> Move such a TMZ buffer to VRAM domain before command
> >>>>> submission.
> >>>>>
> >>>>> v2:
> >>>>>     - Use patch_cs_in_place callback.
> >>>>>
> >>>>> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> >>>>> ---
> >>>>>     drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 68 ++++++++++++++++++++=
+++++++
> >>>>>     1 file changed, 68 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/dr=
m/amd/amdgpu/vcn_v1_0.c
> >>>>> index 7bbb9ba6b80b..810932abd3af 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> >>>>> @@ -24,6 +24,7 @@
> >>>>>     #include <linux/firmware.h>
> >>>>>     #include "amdgpu.h"
> >>>>> +#include "amdgpu_cs.h"
> >>>>>     #include "amdgpu_vcn.h"
> >>>>>     #include "amdgpu_pm.h"
> >>>>>     #include "soc15.h"
> >>>>> @@ -1905,6 +1906,72 @@ static const struct amd_ip_funcs vcn_v1_0_ip=
_funcs =3D {
> >>>>>           .set_powergating_state =3D vcn_v1_0_set_powergating_state=
,
> >>>>>     };
> >>>>> +/**
> >>>>> + * It is a hardware issue that Raven VCN can't handle a GTT TMZ bu=
ffer.
> >>>>> + * Move such a GTT TMZ buffer to VRAM domain before command submis=
sion.
> >>>>> + */
> >>>>> +static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
> >>>>> +                         struct amdgpu_job *job,
> >>>>> +                         uint64_t addr)
> >>>>> +{
> >>>>> + struct ttm_operation_ctx ctx =3D { false, false };
> >>>>> + struct amdgpu_fpriv *fpriv =3D parser->filp->driver_priv;
> >>>>> + struct amdgpu_vm *vm =3D &fpriv->vm;
> >>>>> + struct amdgpu_bo_va_mapping *mapping;
> >>>>> + struct amdgpu_bo *bo;
> >>>>> + int r;
> >>>>> +
> >>>>> + addr &=3D AMDGPU_GMC_HOLE_MASK;
> >>>>> + if (addr & 0x7) {
> >>>>> +         DRM_ERROR("VCN messages must be 8 byte aligned!\n");
> >>>>> +         return -EINVAL;
> >>>>> + }
> >>>>> +
> >>>>> + mapping =3D amdgpu_vm_bo_lookup_mapping(vm, addr/AMDGPU_GPU_PAGE_=
SIZE);
> >>>>> + if (!mapping || !mapping->bo_va || !mapping->bo_va->base.bo)
> >>>>> +         return -EINVAL;
> >>>>> +
> >>>>> + bo =3D mapping->bo_va->base.bo;
> >>>>> + if (!(bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED))
> >>>>> +         return 0;
> >>>>> +
> >>>>> + amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> >>>>> + r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> >>>>> + if (r) {
> >>>>> +         DRM_ERROR("Failed validating the VCN message BO (%d)!\n",=
 r);
> >>>>> +         return r;
> >>>>> + }
> >>>> Well, exactly that won't work.
> >>>>
> >>>> The message structure isn't TMZ protected because otherwise the driv=
er won't
> >>>> be able to stitch it together.
> >>>>
> >>>> What is TMZ protected are the surfaces the message structure is poin=
ting to.
> >>>> So what you would need to do is to completely parse the structure an=
d then
> >>>> move on the relevant buffers into VRAM.
> >>>>
> >>>> Leo or James, can you help with that?
> >>>   From my observations, when decoding secure contents, register
> >>> GPCOM_VCPU_DATA0 and GPCOM_VCPU_DATA1 are set to a TMZ buffer address=
.
> >>> And this way works when allocating TMZ buffers in GTT domain.
> >> As far as I remember that's only the case for the decoding, encoding w=
orks
> >> by putting the addresses into the message buffer.
> >>
> >> But could be that decoding is sufficient, Leo and James need to commen=
t on
> >> this.
> > It seems that only decode needs TMZ buffers. Only observe si_vid_create=
_tmz_buffer()
> > was called in rvcn_dec_message_decode() in src/gallium/drivers/radeon/r=
adeon_vcn_dec.c.
>
> Mhm, good point. Let's wait for Leo and James to wake up, when we don't
> need encode support than that would makes things much easier.

If we don't support encrypted encode, we should add a check to prevent
it like we do for compute.

Alex

>
> Regards,
> Christian.
>
> >
> > Regards,
> > Lang
> >
> >> Regards,
> >> Christian.
> >>
> >>> Regards,
> >>> Lang
> >>>
> >>>> Regards,
> >>>> Christian.
> >>>>
> >>>>> +
> >>>>> + return r;
> >>>>> +}
> >>>>> +
> >>>>> +static int vcn_v1_0_ring_patch_cs_in_place(struct amdgpu_cs_parser=
 *p,
> >>>>> +                                    struct amdgpu_job *job,
> >>>>> +                                    struct amdgpu_ib *ib)
> >>>>> +{
> >>>>> + uint32_t msg_lo =3D 0, msg_hi =3D 0;
> >>>>> + int i, r;
> >>>>> +
> >>>>> + for (i =3D 0; i < ib->length_dw; i +=3D 2) {
> >>>>> +         uint32_t reg =3D amdgpu_ib_get_value(ib, i);
> >>>>> +         uint32_t val =3D amdgpu_ib_get_value(ib, i + 1);
> >>>>> +
> >>>>> +         if (reg =3D=3D PACKET0(p->adev->vcn.internal.data0, 0)) {
> >>>>> +                 msg_lo =3D val;
> >>>>> +         } else if (reg =3D=3D PACKET0(p->adev->vcn.internal.data1=
, 0)) {
> >>>>> +                 msg_hi =3D val;
> >>>>> +         } else if (reg =3D=3D PACKET0(p->adev->vcn.internal.cmd, =
0)) {
> >>>>> +                 r =3D vcn_v1_0_validate_bo(p, job,
> >>>>> +                                      ((u64)msg_hi) << 32 | msg_lo=
);
> >>>>> +                 if (r)
> >>>>> +                         return r;
> >>>>> +         }
> >>>>> + }
> >>>>> +
> >>>>> + return 0;
> >>>>> +}
> >>>>> +
> >>>>> +
> >>>>>     static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_func=
s =3D {
> >>>>>           .type =3D AMDGPU_RING_TYPE_VCN_DEC,
> >>>>>           .align_mask =3D 0xf,
> >>>>> @@ -1914,6 +1981,7 @@ static const struct amdgpu_ring_funcs vcn_v1_=
0_dec_ring_vm_funcs =3D {
> >>>>>           .get_rptr =3D vcn_v1_0_dec_ring_get_rptr,
> >>>>>           .get_wptr =3D vcn_v1_0_dec_ring_get_wptr,
> >>>>>           .set_wptr =3D vcn_v1_0_dec_ring_set_wptr,
> >>>>> + .patch_cs_in_place =3D vcn_v1_0_ring_patch_cs_in_place,
> >>>>>           .emit_frame_size =3D
> >>>>>                   6 + 6 + /* hdp invalidate / flush */
> >>>>>                   SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
>
