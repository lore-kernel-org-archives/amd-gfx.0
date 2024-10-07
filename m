Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE25CFB441
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Oct 2024 14:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E5610E3A9;
	Mon,  7 Oct 2024 14:17:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i2ZiVM+L";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5743810E086
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Oct 2024 14:17:52 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-7e9f8714b9bso266648a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Oct 2024 07:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728310672; x=1728915472; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LgTL8WZkpzMUoCcntE6f7tMeS9WALppsB5GpkmsaFFg=;
 b=i2ZiVM+LI33yTZDK43EvGzXXz1wZcq7s1ycSDjEN5FydSqms4A38auTeHd1M8TlwN+
 iBkeEAi+7rXI4p4sxXQ0mTCP3NwUao5ErGU9metV97MkzJu+GUbYraEDbJvnXPFKEN5X
 z83Izb3+kPr9rbWOIGDIzjUl3pEpwKqSk7YLaEcCrBls61rKQ4tBChCG3RfoVnK/dg+6
 NcSeUajvXlCTe/yqnaLQevAnUZJAuoAmVftqI+HnDT6fD6uu+FBFAz9w25v+2naBcWWC
 sr1mmfwSZfXgRgadCeRyGdzHMC62Q5lip69r2LG25EA5m6sgnCuA2GYmB671SSUkbrBF
 EhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728310672; x=1728915472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LgTL8WZkpzMUoCcntE6f7tMeS9WALppsB5GpkmsaFFg=;
 b=g3uU8JEWuOMxAti/YqNylk8hO04YguVlJ1Ad2U2jBNkcWqyd3TSF7ACMEiBvtUR2b3
 g3Lraw1SFAlWPK+E1YFq1Z2EskurhlFxheapfnsHbY+l6sBWdCLzsC9ICJSyqZz1Ll5T
 4eBe3JMEZlTM2tg2N5S60Tx8rR5tgN84wXUlM0g4jlupChFaBGvUe5bxR/fbgFEpobBl
 7++w5CeZV+jzNWAOn8JzyddW5n6HuwlCa5Oxr9rkKZhHJzZLw1x5/+TnDYl5gyUZH+/2
 BGYv9HRsRwIgIsIQcb9Wj1PMY0iJDJooM8vS7wJJtp43b8XhqYM2FoItDxoRWdwrbazb
 oO5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK2ATD9hJK4NfPlsWKo1j3lQVabo7bZMkSOrFrVMSEeZCVrMeRYV4nkhUlm5fURZUfbQ+TH5VG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGC5ijS+47M873jZaSrcLZx2DmQjX1c++Zkdm+uj7lkAykT6iK
 ShpduvA7DnaEIIWqam8yUVDeHS99nlZlVDuOdETZ4mQgmGDT1jWOaO/gEGmVTMnJJk6qgibJr7P
 GoDZzMtBvqlKnZEoF21OD2Vv8YIk=
X-Google-Smtp-Source: AGHT+IFB5IQoDjw3EAMNzpN0qmIVBz8o3pLG4ryYO6GyG+qjhRmBgh9ENqNtK+KPWVZuv9Wwb4h++jtKhCtdMCAuLAE=
X-Received: by 2002:a17:902:d50f:b0:206:b1fa:ccb9 with SMTP id
 d9443c01a7336-20bfe39ffcfmr72466715ad.6.1728310671493; Mon, 07 Oct 2024
 07:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
 <20241004184444.435356-12-boyuan.zhang@amd.com>
 <4a7b5736-f60b-433b-a021-fef2cf4f2338@amd.com>
 <2d260d2c-d052-4b07-9cbf-0e5fc4199f98@amd.com>
 <5f4babf7-f8b9-4a93-8858-849b8b32c3b9@amd.com>
In-Reply-To: <5f4babf7-f8b9-4a93-8858-849b8b32c3b9@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Oct 2024 10:17:39 -0400
Message-ID: <CADnq5_NK2fQMo=N=KEnnw3Not9PnWAw4nBK4+JUfY-Km7dX1Aw@mail.gmail.com>
Subject: Re: [PATCH 11/18] drm/amdgpu: power vcn 2_5 by instance
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Boyuan Zhang <Boyuan.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 leo.liu@amd.com, 
 christian.koenig@amd.com, alexander.deucher@amd.com, sunil.khatri@amd.com
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

On Mon, Oct 7, 2024 at 9:58=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wro=
te:
>
>
>
> On 10/7/2024 7:03 PM, Boyuan Zhang wrote:
> >
> > On 2024-10-07 01:22, Lazar, Lijo wrote:
> >>
> >> On 10/5/2024 12:14 AM, boyuan.zhang@amd.com wrote:
> >>> From: Boyuan Zhang <boyuan.zhang@amd.com>
> >>>
> >>> For vcn 2_5, add ip_block for each vcn instance during discovery stag=
e.
> >>>
> >>> And only powering on/off one of the vcn instance using the
> >>> instance value stored in ip_block, instead of powering on/off all
> >>> vcn instances. Modify the existing functions to use the instance valu=
e
> >>> in ip_block, and remove the original for loop for all vcn instances.
> >>>
> >>> v2: rename "i"/"j" to "inst" for instance value.
> >>>
> >>> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +-
> >>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 565 +++++++++------=
---
> >>>   2 files changed, 280 insertions(+), 289 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>> index 9f9a1867da72..de1053cc2a2b 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>> @@ -2278,6 +2278,7 @@ static int
> >>> amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
> >>>     static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device
> >>> *adev)
> >>>   {
> >>> +    int i;
> >>>       if (amdgpu_ip_version(adev, VCE_HWIP, 0)) {
> >>>           switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
> >>>           case IP_VERSION(7, 0, 0):
> >>> @@ -2321,7 +2322,8 @@ static int
> >>> amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
> >>>           case IP_VERSION(2, 0, 3):
> >>>               break;
> >>>           case IP_VERSION(2, 5, 0):
> >>> -            amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
> >>> +            for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i)
> >>> +                amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block)=
;
> >>
> >> This introduces a totally confusing design now. At a higher level an I=
P
> >> block type manages multiple instances and their power states. Now ther=
e
> >> is a mix where no definition can be attributed to an IP block. Or, if
> >> this were to be done uniformly for other IPs, then for some SOCs there
> >> could be 16 SDMA blocks, 8 GFX blocks and so forth.
> >>
> >> What is the reason to do this way? Can't VCN IP block maintain the sta=
te
> >> of multiple instances within itself?
> >>
> >> Thanks,
> >> Lijo
> > This is part of the fundamental design change for separating IP block
> > per instance, in order to
> > handle each instance separately within same IP block (e.g. separate
> > power/clock management).
> >
> > Part 1, Change all adev ptr handle to amdgpu_ip_block ptr in all
> > callbacks (hw_init/fini, sw_init/fini,
> > suspend, etc...) for all IP blocks, so that each IP knows which IP_bloc=
k
> > (and which instance) the
> > callback is for. Most parts of this changes have been submitted by Suni=
l.
> >
> > Part 2, Separate IP block per instance.
> >
> > Part 3, Since callbacks can pass in IP_block now after Part 1 change an=
d
> > instance value can be
> > obtained from each IP block in Part 2, IP can then choose to handle
> > callbacks ONLY for the given
> > instance of a given IP block (or still handling for all instances as
> > before).
> > For VCN, all callbacks will be handled only for the given one instance,
> > instead of the original for-
> > loop for all instance. As a result, each VCN instance can be
> > start/stop/int/fini/suspend separately.
> >
> > Part 4, Change all VCN helper functions to handle only the given
> > instance, instead of the original
> > for-loop for all instance.
> >
> > Each instance can have its own states, so we think it makes more sense
> > to separate them on IP
> > block level to handle each of them separately.
>
>
> Such a change should not be done unless all IPs follow the same design.
> You didn't answer the question - what necessitates this change? What is
> special about VCN that it cannot manage the states of multiple instances
> within the IP block?

We want to be able to manage the powergating independently for each
VCN instance for both power management and VCN reset.  Right now power
gating is handled at the IP level so it's not easy or clean to handle
powergating of individual IP instances.

Alex

>
> Thanks,
> Lijo
>
> >
> > Thanks,
> > Boyuan
> >>
> >>>               amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
> >>>               break;
> >>>           case IP_VERSION(2, 6, 0):
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> >>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> >>> index d00df51bc400..1f8738ae360a 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> >>> @@ -158,35 +158,34 @@ static int vcn_v2_5_early_init(struct
> >>> amdgpu_ip_block *ip_block)
> >>>   static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
> >>>   {
> >>>       struct amdgpu_ring *ring;
> >>> -    int i, j, r;
> >>> +    int i, r;
> >>>       uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_2_5);
> >>>       uint32_t *ptr;
> >>>       struct amdgpu_device *adev =3D ip_block->adev;
> >>> +    int inst =3D ip_block->instance;
> >>>   -    for (j =3D 0; j < adev->vcn.num_vcn_inst; j++) {
> >>> -        if (adev->vcn.harvest_config & (1 << j))
> >>> -            continue;
> >>> -        /* VCN DEC TRAP */
> >>> -        r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
> >>> -                VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT,
> >>> &adev->vcn.inst[j].irq);
> >>> -        if (r)
> >>> -            return r;
> >>> -
> >>> -        /* VCN ENC TRAP */
> >>> -        for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
> >>> -            r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j]=
,
> >>> -                i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
> >>> &adev->vcn.inst[j].irq);
> >>> -            if (r)
> >>> -                return r;
> >>> -        }
> >>> +    if (adev->vcn.harvest_config & (1 << inst))
> >>> +        goto sw_init;
> >>> +    /* VCN DEC TRAP */
> >>> +    r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> >>> +            VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT,
> >>> &adev->vcn.inst[inst].irq);
> >>> +    if (r)
> >>> +        return r;
> >>>   -        /* VCN POISON TRAP */
> >>> -        r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
> >>> -            VCN_2_6__SRCID_UVD_POISON,
> >>> &adev->vcn.inst[j].ras_poison_irq);
> >>> +    /* VCN ENC TRAP */
> >>> +    for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
> >>> +        r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> >>> +            i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
> >>> &adev->vcn.inst[inst].irq);
> >>>           if (r)
> >>>               return r;
> >>>       }
> >>>   +    /* VCN POISON TRAP */
> >>> +    r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> >>> +        VCN_2_6__SRCID_UVD_POISON,
> >>> &adev->vcn.inst[inst].ras_poison_irq);
> >>> +    if (r)
> >>> +        return r;
> >>> +sw_init:
> >>>       r =3D amdgpu_vcn_sw_init(adev);
> >>>       if (r)
> >>>           return r;
> >>> @@ -197,76 +196,74 @@ static int vcn_v2_5_sw_init(struct
> >>> amdgpu_ip_block *ip_block)
> >>>       if (r)
> >>>           return r;
> >>>   -    for (j =3D 0; j < adev->vcn.num_vcn_inst; j++) {
> >>> -        volatile struct amdgpu_fw_shared *fw_shared;
> >>> +    volatile struct amdgpu_fw_shared *fw_shared;
> >>>   -        if (adev->vcn.harvest_config & (1 << j))
> >>> -            continue;
> >>> -        adev->vcn.internal.context_id =3D
> >>> mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
> >>> -        adev->vcn.internal.ib_vmid =3D
> >>> mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
> >>> -        adev->vcn.internal.ib_bar_low =3D
> >>> mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
> >>> -        adev->vcn.internal.ib_bar_high =3D
> >>> mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
> >>> -        adev->vcn.internal.ib_size =3D mmUVD_RBC_IB_SIZE_INTERNAL_OF=
FSET;
> >>> -        adev->vcn.internal.gp_scratch8 =3D
> >>> mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
> >>> -
> >>> -        adev->vcn.internal.scratch9 =3D mmUVD_SCRATCH9_INTERNAL_OFFS=
ET;
> >>> -        adev->vcn.inst[j].external.scratch9 =3D SOC15_REG_OFFSET(VCN=
,
> >>> j, mmUVD_SCRATCH9);
> >>> -        adev->vcn.internal.data0 =3D
> >>> mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
> >>> -        adev->vcn.inst[j].external.data0 =3D SOC15_REG_OFFSET(VCN, j=
,
> >>> mmUVD_GPCOM_VCPU_DATA0);
> >>> -        adev->vcn.internal.data1 =3D
> >>> mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
> >>> -        adev->vcn.inst[j].external.data1 =3D SOC15_REG_OFFSET(VCN, j=
,
> >>> mmUVD_GPCOM_VCPU_DATA1);
> >>> -        adev->vcn.internal.cmd =3D mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFF=
SET;
> >>> -        adev->vcn.inst[j].external.cmd =3D SOC15_REG_OFFSET(VCN, j,
> >>> mmUVD_GPCOM_VCPU_CMD);
> >>> -        adev->vcn.internal.nop =3D mmUVD_NO_OP_INTERNAL_OFFSET;
> >>> -        adev->vcn.inst[j].external.nop =3D SOC15_REG_OFFSET(VCN, j,
> >>> mmUVD_NO_OP);
> >>> -
> >>> -        ring =3D &adev->vcn.inst[j].ring_dec;
> >>> +    if (adev->vcn.harvest_config & (1 << inst))
> >>> +        goto done;
> >>> +    adev->vcn.internal.context_id =3D mmUVD_CONTEXT_ID_INTERNAL_OFFS=
ET;
> >>> +    adev->vcn.internal.ib_vmid =3D mmUVD_LMI_RBC_IB_VMID_INTERNAL_OF=
FSET;
> >>> +    adev->vcn.internal.ib_bar_low =3D
> >>> mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
> >>> +    adev->vcn.internal.ib_bar_high =3D
> >>> mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
> >>> +    adev->vcn.internal.ib_size =3D mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET=
;
> >>> +    adev->vcn.internal.gp_scratch8 =3D mmUVD_GP_SCRATCH8_INTERNAL_OF=
FSET;
> >>> +
> >>> +    adev->vcn.internal.scratch9 =3D mmUVD_SCRATCH9_INTERNAL_OFFSET;
> >>> +    adev->vcn.inst[inst].external.scratch9 =3D SOC15_REG_OFFSET(VCN,
> >>> inst, mmUVD_SCRATCH9);
> >>> +    adev->vcn.internal.data0 =3D mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFF=
SET;
> >>> +    adev->vcn.inst[inst].external.data0 =3D SOC15_REG_OFFSET(VCN,
> >>> inst, mmUVD_GPCOM_VCPU_DATA0);
> >>> +    adev->vcn.internal.data1 =3D mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFF=
SET;
> >>> +    adev->vcn.inst[inst].external.data1 =3D SOC15_REG_OFFSET(VCN,
> >>> inst, mmUVD_GPCOM_VCPU_DATA1);
> >>> +    adev->vcn.internal.cmd =3D mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
> >>> +    adev->vcn.inst[inst].external.cmd =3D SOC15_REG_OFFSET(VCN, inst=
,
> >>> mmUVD_GPCOM_VCPU_CMD);
> >>> +    adev->vcn.internal.nop =3D mmUVD_NO_OP_INTERNAL_OFFSET;
> >>> +    adev->vcn.inst[inst].external.nop =3D SOC15_REG_OFFSET(VCN, inst=
,
> >>> mmUVD_NO_OP);
> >>> +
> >>> +    ring =3D &adev->vcn.inst[inst].ring_dec;
> >>> +    ring->use_doorbell =3D true;
> >>> +
> >>> +    ring->doorbell_index =3D (adev->doorbell_index.vcn.vcn_ring0_1 <=
<
> >>> 1) +
> >>> +            (amdgpu_sriov_vf(adev) ? 2*inst : 8*inst);
> >>> +
> >>> +    if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D IP_VERSION(2, 5,=
 0))
> >>> +        ring->vm_hub =3D AMDGPU_MMHUB1(0);
> >>> +    else
> >>> +        ring->vm_hub =3D AMDGPU_MMHUB0(0);
> >>> +
> >>> +    sprintf(ring->name, "vcn_dec_%d", inst);
> >>> +    r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].ir=
q,
> >>> +                 0, AMDGPU_RING_PRIO_DEFAULT, NULL);
> >>> +    if (r)
> >>> +        return r;
> >>> +
> >>> +    for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
> >>> +        enum amdgpu_ring_priority_level hw_prio =3D
> >>> amdgpu_vcn_get_enc_ring_prio(i);
> >>> +
> >>> +        ring =3D &adev->vcn.inst[inst].ring_enc[i];
> >>>           ring->use_doorbell =3D true;
> >>>             ring->doorbell_index =3D
> >>> (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> >>> -                (amdgpu_sriov_vf(adev) ? 2*j : 8*j);
> >>> +                (amdgpu_sriov_vf(adev) ? (1 + i + 2*inst) : (2 + i +
> >>> 8*inst));
> >>>   -        if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D IP_VERSION=
(2,
> >>> 5, 0))
> >>> +        if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D
> >>> +            IP_VERSION(2, 5, 0))
> >>>               ring->vm_hub =3D AMDGPU_MMHUB1(0);
> >>>           else
> >>>               ring->vm_hub =3D AMDGPU_MMHUB0(0);
> >>>   -        sprintf(ring->name, "vcn_dec_%d", j);
> >>> -        r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].i=
rq,
> >>> -                     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
> >>> +        sprintf(ring->name, "vcn_enc_%d.%d", inst, i);
> >>> +        r =3D amdgpu_ring_init(adev, ring, 512,
> >>> +                     &adev->vcn.inst[inst].irq, 0,
> >>> +                     hw_prio, NULL);
> >>>           if (r)
> >>>               return r;
> >>> -
> >>> -        for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
> >>> -            enum amdgpu_ring_priority_level hw_prio =3D
> >>> amdgpu_vcn_get_enc_ring_prio(i);
> >>> -
> >>> -            ring =3D &adev->vcn.inst[j].ring_enc[i];
> >>> -            ring->use_doorbell =3D true;
> >>> -
> >>> -            ring->doorbell_index =3D
> >>> (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> >>> -                    (amdgpu_sriov_vf(adev) ? (1 + i + 2*j) : (2 + i
> >>> + 8*j));
> >>> -
> >>> -            if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D
> >>> -                IP_VERSION(2, 5, 0))
> >>> -                ring->vm_hub =3D AMDGPU_MMHUB1(0);
> >>> -            else
> >>> -                ring->vm_hub =3D AMDGPU_MMHUB0(0);
> >>> -
> >>> -            sprintf(ring->name, "vcn_enc_%d.%d", j, i);
> >>> -            r =3D amdgpu_ring_init(adev, ring, 512,
> >>> -                         &adev->vcn.inst[j].irq, 0,
> >>> -                         hw_prio, NULL);
> >>> -            if (r)
> >>> -                return r;
> >>> -        }
> >>> -
> >>> -        fw_shared =3D adev->vcn.inst[j].fw_shared.cpu_addr;
> >>> -        fw_shared->present_flag_0 =3D
> >>> cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
> >>> -
> >>> -        if (amdgpu_vcnfw_log)
> >>> -            amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> >>>       }
> >>>   +    fw_shared =3D adev->vcn.inst[inst].fw_shared.cpu_addr;
> >>> +    fw_shared->present_flag_0 =3D
> >>> cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
> >>> +
> >>> +    if (amdgpu_vcnfw_log)
> >>> +        amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> >>> +done:
> >>>       if (amdgpu_sriov_vf(adev)) {
> >>>           r =3D amdgpu_virt_alloc_mm_table(adev);
> >>>           if (r)
> >>> @@ -1005,197 +1002,192 @@ static int vcn_v2_5_start_dpg_mode(struct
> >>> amdgpu_device *adev, int inst_idx, boo
> >>>       return 0;
> >>>   }
> >>>   -static int vcn_v2_5_start(struct amdgpu_device *adev)
> >>> +static int vcn_v2_5_start(struct amdgpu_device *adev, unsigned int
> >>> inst)
> >>>   {
> >>>       struct amdgpu_ring *ring;
> >>>       uint32_t rb_bufsz, tmp;
> >>> -    int i, j, k, r;
> >>> +    int j, k, r;
> >>>   -    for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> >>> -        if (adev->pm.dpm_enabled)
> >>> -            amdgpu_dpm_enable_vcn(adev, true, i);
> >>> -    }
> >>> -
> >>> -    for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> >>> -        if (adev->vcn.harvest_config & (1 << i))
> >>> -            continue;
> >>> -        if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> >>> -            r =3D vcn_v2_5_start_dpg_mode(adev, i,
> >>> adev->vcn.indirect_sram);
> >>> -            continue;
> >>> -        }
> >>> +    if (adev->pm.dpm_enabled)
> >>> +        amdgpu_dpm_enable_vcn(adev, true, inst);
> >>>   -        /* disable register anti-hang mechanism */
> >>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
> >>> -            ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> >>> +    if (adev->vcn.harvest_config & (1 << inst))
> >>> +        return 0;
> >>>   -        /* set uvd status busy */
> >>> -        tmp =3D RREG32_SOC15(VCN, i, mmUVD_STATUS) |
> >>> UVD_STATUS__UVD_BUSY;
> >>> -        WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
> >>> +    if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> >>> +        r =3D vcn_v2_5_start_dpg_mode(adev, inst,
> >>> adev->vcn.indirect_sram);
> >>> +        return r;
> >>>       }
> >>>   +    /* disable register anti-hang mechanism */
> >>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS), 0,
> >>> +        ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> >>> +
> >>> +    /* set uvd status busy */
> >>> +    tmp =3D RREG32_SOC15(VCN, inst, mmUVD_STATUS) | UVD_STATUS__UVD_=
BUSY;
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_STATUS, tmp);
> >>> +
> >>>       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> >>>           return 0;
> >>>         /*SW clock gating */
> >>>       vcn_v2_5_disable_clock_gating(adev);
> >>>   -    for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> >>> -        if (adev->vcn.harvest_config & (1 << i))
> >>> -            continue;
> >>> -        /* enable VCPU clock */
> >>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> >>> -            UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK)=
;
> >>> -
> >>> -        /* disable master interrupt */
> >>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
> >>> -            ~UVD_MASTINT_EN__VCPU_EN_MASK);
> >>> -
> >>> -        /* setup mmUVD_LMI_CTRL */
> >>> -        tmp =3D RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
> >>> -        tmp &=3D ~0xff;
> >>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
> >>> -            UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK    |
> >>> -            UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> >>> -            UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> >>> -            UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> >>> -
> >>> -        /* setup mmUVD_MPC_CNTL */
> >>> -        tmp =3D RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
> >>> -        tmp &=3D ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> >>> -        tmp |=3D 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> >>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
> >>> -
> >>> -        /* setup UVD_MPC_SET_MUXA0 */
> >>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
> >>> -            ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> >>> -            (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> >>> -            (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> >>> -            (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> >>> -
> >>> -        /* setup UVD_MPC_SET_MUXB0 */
> >>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
> >>> -            ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> >>> -            (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> >>> -            (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> >>> -            (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> >>> -
> >>> -        /* setup mmUVD_MPC_SET_MUX */
> >>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
> >>> -            ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> >>> -            (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> >>> -            (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> >>> -    }
> >>> +    if (adev->vcn.harvest_config & (1 << inst))
> >>> +        return 0;
> >>> +
> >>> +    /* enable VCPU clock */
> >>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
> >>> +        UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> >>> +
> >>> +    /* disable master interrupt */
> >>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN), 0,
> >>> +        ~UVD_MASTINT_EN__VCPU_EN_MASK);
> >>> +
> >>> +    /* setup mmUVD_LMI_CTRL */
> >>> +    tmp =3D RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL);
> >>> +    tmp &=3D ~0xff;
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL, tmp | 0x8|
> >>> +        UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK    |
> >>> +        UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> >>> +        UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> >>> +        UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> >>> +
> >>> +    /* setup mmUVD_MPC_CNTL */
> >>> +    tmp =3D RREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL);
> >>> +    tmp &=3D ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> >>> +    tmp |=3D 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL, tmp);
> >>> +
> >>> +    /* setup UVD_MPC_SET_MUXA0 */
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXA0,
> >>> +        ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> >>> +        (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> >>> +        (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> >>> +        (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> >>> +
> >>> +    /* setup UVD_MPC_SET_MUXB0 */
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXB0,
> >>> +        ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> >>> +        (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> >>> +        (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> >>> +        (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> >>> +
> >>> +    /* setup mmUVD_MPC_SET_MUX */
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUX,
> >>> +        ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> >>> +        (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> >>> +        (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> >>>         vcn_v2_5_mc_resume(adev);
> >>>   -    for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> >>> -        volatile struct amdgpu_fw_shared *fw_shared =3D
> >>> adev->vcn.inst[i].fw_shared.cpu_addr;
> >>> -        if (adev->vcn.harvest_config & (1 << i))
> >>> -            continue;
> >>> -        /* VCN global tiling registers */
> >>> -        WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
> >>> -            adev->gfx.config.gb_addr_config);
> >>> -        WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
> >>> -            adev->gfx.config.gb_addr_config);
> >>> +    volatile struct amdgpu_fw_shared *fw_shared =3D
> >>> adev->vcn.inst[inst].fw_shared.cpu_addr;
> >>> +    if (adev->vcn.harvest_config & (1 << inst))
> >>> +        return 0;
> >>> +
> >>> +    /* VCN global tiling registers */
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
> >>> +        adev->gfx.config.gb_addr_config);
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
> >>> +        adev->gfx.config.gb_addr_config);
> >>>   -        /* enable LMI MC and UMC channels */
> >>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
> >>> -            ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> >>> +    /* enable LMI MC and UMC channels */
> >>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_LMI_CTRL2), 0,
> >>> +        ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> >>>   -        /* unblock VCPU register access */
> >>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
> >>> -            ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> >>> +    /* unblock VCPU register access */
> >>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL), 0,
> >>> +        ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> >>>   -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> >>> -            ~UVD_VCPU_CNTL__BLK_RST_MASK);
> >>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
> >>> +        ~UVD_VCPU_CNTL__BLK_RST_MASK);
> >>>   -        for (k =3D 0; k < 10; ++k) {
> >>> -            uint32_t status;
> >>> -
> >>> -            for (j =3D 0; j < 100; ++j) {
> >>> -                status =3D RREG32_SOC15(VCN, i, mmUVD_STATUS);
> >>> -                if (status & 2)
> >>> -                    break;
> >>> -                if (amdgpu_emu_mode =3D=3D 1)
> >>> -                    msleep(500);
> >>> -                else
> >>> -                    mdelay(10);
> >>> -            }
> >>> -            r =3D 0;
> >>> +    for (k =3D 0; k < 10; ++k) {
> >>> +        uint32_t status;
> >>> +
> >>> +        for (j =3D 0; j < 100; ++j) {
> >>> +            status =3D RREG32_SOC15(VCN, inst, mmUVD_STATUS);
> >>>               if (status & 2)
> >>>                   break;
> >>> +            if (amdgpu_emu_mode =3D=3D 1)
> >>> +                msleep(500);
> >>> +            else
> >>> +                mdelay(10);
> >>> +        }
> >>> +        r =3D 0;
> >>> +        if (status & 2)
> >>> +            break;
> >>>   -            DRM_ERROR("VCN decode not responding, trying to reset
> >>> the VCPU!!!\n");
> >>> -            WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> >>> -                UVD_VCPU_CNTL__BLK_RST_MASK,
> >>> -                ~UVD_VCPU_CNTL__BLK_RST_MASK);
> >>> -            mdelay(10);
> >>> -            WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> >>> -                ~UVD_VCPU_CNTL__BLK_RST_MASK);
> >>> +        DRM_ERROR("VCN decode not responding, trying to reset the
> >>> VCPU!!!\n");
> >>> +        WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
> >>> +            UVD_VCPU_CNTL__BLK_RST_MASK,
> >>> +            ~UVD_VCPU_CNTL__BLK_RST_MASK);
> >>> +        mdelay(10);
> >>> +        WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
> >>> +            ~UVD_VCPU_CNTL__BLK_RST_MASK);
> >>>   -            mdelay(10);
> >>> -            r =3D -1;
> >>> -        }
> >>> +        mdelay(10);
> >>> +        r =3D -1;
> >>> +    }
> >>>   -        if (r) {
> >>> -            DRM_ERROR("VCN decode not responding, giving up!!!\n");
> >>> -            return r;
> >>> -        }
> >>> +    if (r) {
> >>> +        DRM_ERROR("VCN decode not responding, giving up!!!\n");
> >>> +        return r;
> >>> +    }
> >>>   -        /* enable master interrupt */
> >>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
> >>> -            UVD_MASTINT_EN__VCPU_EN_MASK,
> >>> -            ~UVD_MASTINT_EN__VCPU_EN_MASK);
> >>> +    /* enable master interrupt */
> >>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN),
> >>> +        UVD_MASTINT_EN__VCPU_EN_MASK,
> >>> +        ~UVD_MASTINT_EN__VCPU_EN_MASK);
> >>>   -        /* clear the busy bit of VCN_STATUS */
> >>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
> >>> -            ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> >>> +    /* clear the busy bit of VCN_STATUS */
> >>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_STATUS), 0,
> >>> +        ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> >>>   -        WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_VMID, 0);
> >>>   -        ring =3D &adev->vcn.inst[i].ring_dec;
> >>> -        /* force RBC into idle state */
> >>> -        rb_bufsz =3D order_base_2(ring->ring_size);
> >>> -        tmp =3D REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz=
);
> >>> -        tmp =3D REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
> >>> -        tmp =3D REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
> >>> -        tmp =3D REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1)=
;
> >>> -        tmp =3D REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1=
);
> >>> -        WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
> >>> +    ring =3D &adev->vcn.inst[inst].ring_dec;
> >>> +    /* force RBC into idle state */
> >>> +    rb_bufsz =3D order_base_2(ring->ring_size);
> >>> +    tmp =3D REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
> >>> +    tmp =3D REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
> >>> +    tmp =3D REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
> >>> +    tmp =3D REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
> >>> +    tmp =3D REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_CNTL, tmp);
> >>>   -        fw_shared->multi_queue.decode_queue_mode |=3D
> >>> FW_QUEUE_RING_RESET;
> >>> -        /* program the RB_BASE for ring buffer */
> >>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
> >>> -            lower_32_bits(ring->gpu_addr));
> >>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> >>> -            upper_32_bits(ring->gpu_addr));
> >>> +    fw_shared->multi_queue.decode_queue_mode |=3D FW_QUEUE_RING_RESE=
T;
> >>> +    /* program the RB_BASE for ring buffer */
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
> >>> +        lower_32_bits(ring->gpu_addr));
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> >>> +        upper_32_bits(ring->gpu_addr));
> >>>   -        /* Initialize the ring buffer's read and write pointers */
> >>> -        WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
> >>> +    /* Initialize the ring buffer's read and write pointers */
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR, 0);
> >>>   -        ring->wptr =3D RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
> >>> -        WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
> >>> -                lower_32_bits(ring->wptr));
> >>> -        fw_shared->multi_queue.decode_queue_mode &=3D
> >>> ~FW_QUEUE_RING_RESET;
> >>> +    ring->wptr =3D RREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR);
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_WPTR,
> >>> +            lower_32_bits(ring->wptr));
> >>> +    fw_shared->multi_queue.decode_queue_mode &=3D ~FW_QUEUE_RING_RES=
ET;
> >>>   -        fw_shared->multi_queue.encode_generalpurpose_queue_mode |=
=3D
> >>> FW_QUEUE_RING_RESET;
> >>> -        ring =3D &adev->vcn.inst[i].ring_enc[0];
> >>> -        WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr=
));
> >>> -        WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr=
));
> >>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
> >>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI,
> >>> upper_32_bits(ring->gpu_addr));
> >>> -        WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
> >>> -        fw_shared->multi_queue.encode_generalpurpose_queue_mode &=3D
> >>> ~FW_QUEUE_RING_RESET;
> >>> -
> >>> -        fw_shared->multi_queue.encode_lowlatency_queue_mode |=3D
> >>> FW_QUEUE_RING_RESET;
> >>> -        ring =3D &adev->vcn.inst[i].ring_enc[1];
> >>> -        WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2,
> >>> lower_32_bits(ring->wptr));
> >>> -        WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2,
> >>> lower_32_bits(ring->wptr));
> >>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
> >>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2,
> >>> upper_32_bits(ring->gpu_addr));
> >>> -        WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
> >>> -        fw_shared->multi_queue.encode_lowlatency_queue_mode &=3D
> >>> ~FW_QUEUE_RING_RESET;
> >>> -    }
> >>> +    fw_shared->multi_queue.encode_generalpurpose_queue_mode |=3D
> >>> FW_QUEUE_RING_RESET;
> >>> +    ring =3D &adev->vcn.inst[inst].ring_enc[0];
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR, lower_32_bits(ring->wptr)=
);
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR, lower_32_bits(ring->wptr)=
);
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO, ring->gpu_addr);
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI,
> >>> upper_32_bits(ring->gpu_addr));
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE, ring->ring_size / 4);
> >>> +    fw_shared->multi_queue.encode_generalpurpose_queue_mode &=3D
> >>> ~FW_QUEUE_RING_RESET;
> >>> +
> >>> +    fw_shared->multi_queue.encode_lowlatency_queue_mode |=3D
> >>> FW_QUEUE_RING_RESET;
> >>> +    ring =3D &adev->vcn.inst[inst].ring_enc[1];
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr=
));
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr=
));
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO2, ring->gpu_addr);
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI2,
> >>> upper_32_bits(ring->gpu_addr));
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE2, ring->ring_size / 4);
> >>> +    fw_shared->multi_queue.encode_lowlatency_queue_mode &=3D
> >>> ~FW_QUEUE_RING_RESET;
> >>>         return 0;
> >>>   }
> >>> @@ -1424,72 +1416,69 @@ static int vcn_v2_5_stop_dpg_mode(struct
> >>> amdgpu_device *adev, int inst_idx)
> >>>       return 0;
> >>>   }
> >>>   -static int vcn_v2_5_stop(struct amdgpu_device *adev)
> >>> +static int vcn_v2_5_stop(struct amdgpu_device *adev, unsigned int in=
st)
> >>>   {
> >>>       uint32_t tmp;
> >>> -    int i, r =3D 0;
> >>> +    int r =3D 0;
> >>>   -    for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> >>> -        if (adev->vcn.harvest_config & (1 << i))
> >>> -            continue;
> >>> -        if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> >>> -            r =3D vcn_v2_5_stop_dpg_mode(adev, i);
> >>> -            continue;
> >>> -        }
> >>> +    if (adev->vcn.harvest_config & (1 << inst))
> >>> +        goto done;
> >>>   -        /* wait for vcn idle */
> >>> -        r =3D SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS,
> >>> UVD_STATUS__IDLE, 0x7);
> >>> -        if (r)
> >>> -            return r;
> >>> +    if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> >>> +        r =3D vcn_v2_5_stop_dpg_mode(adev, inst);
> >>> +        goto done;
> >>> +    }
> >>>   -        tmp =3D UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> >>> -            UVD_LMI_STATUS__READ_CLEAN_MASK |
> >>> -            UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> >>> -            UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> >>> -        r =3D SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp)=
;
> >>> -        if (r)
> >>> -            return r;
> >>> +    /* wait for vcn idle */
> >>> +    r =3D SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS,
> >>> UVD_STATUS__IDLE, 0x7);
> >>> +    if (r)
> >>> +        return r;
> >>>   -        /* block LMI UMC channel */
> >>> -        tmp =3D RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
> >>> -        tmp |=3D UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> >>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
> >>> +    tmp =3D UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> >>> +        UVD_LMI_STATUS__READ_CLEAN_MASK |
> >>> +        UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> >>> +        UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> >>> +    r =3D SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
> >>> +    if (r)
> >>> +        return r;
> >>>   -        tmp =3D UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
> >>> -            UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> >>> -        r =3D SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp)=
;
> >>> -        if (r)
> >>> -            return r;
> >>> +    /* block LMI UMC channel */
> >>> +    tmp =3D RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2);
> >>> +    tmp |=3D UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2, tmp);
> >>>   -        /* block VCPU register access */
> >>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
> >>> -            UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> >>> -            ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> >>> +    tmp =3D UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
> >>> +        UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> >>> +    r =3D SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
> >>> +    if (r)
> >>> +        return r;
> >>>   -        /* reset VCPU */
> >>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> >>> -            UVD_VCPU_CNTL__BLK_RST_MASK,
> >>> -            ~UVD_VCPU_CNTL__BLK_RST_MASK);
> >>> +    /* block VCPU register access */
> >>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL),
> >>> +        UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> >>> +        ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> >>>   -        /* disable VCPU clock */
> >>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> >>> -            ~(UVD_VCPU_CNTL__CLK_EN_MASK));
> >>> +    /* reset VCPU */
> >>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
> >>> +        UVD_VCPU_CNTL__BLK_RST_MASK,
> >>> +        ~UVD_VCPU_CNTL__BLK_RST_MASK);
> >>>   -        /* clear status */
> >>> -        WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
> >>> +    /* disable VCPU clock */
> >>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
> >>> +        ~(UVD_VCPU_CNTL__CLK_EN_MASK));
> >>>   -        vcn_v2_5_enable_clock_gating(adev);
> >>> +    /* clear status */
> >>> +    WREG32_SOC15(VCN, inst, mmUVD_STATUS, 0);
> >>>   -        /* enable register anti-hang mechanism */
> >>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
> >>> -            UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
> >>> -            ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> >>> -    }
> >>> +    vcn_v2_5_enable_clock_gating(adev);
> >>>   -    for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> >>> -        if (adev->pm.dpm_enabled)
> >>> -            amdgpu_dpm_enable_vcn(adev, false, i);
> >>> -    }
> >>> +    /* enable register anti-hang mechanism */
> >>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS),
> >>> +        UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
> >>> +        ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> >>> +done:
> >>> +    if (adev->pm.dpm_enabled)
> >>> +        amdgpu_dpm_enable_vcn(adev, false, inst);
> >>>         return 0;
> >>>   }
> >>> @@ -1838,9 +1827,9 @@ static int
> >>> vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
> >>>           return 0;
> >>>         if (state =3D=3D AMD_PG_STATE_GATE)
> >>> -        ret =3D vcn_v2_5_stop(adev);
> >>> +        ret =3D vcn_v2_5_stop(adev, inst);
> >>>       else
> >>> -        ret =3D vcn_v2_5_start(adev);
> >>> +        ret =3D vcn_v2_5_start(adev, inst);
> >>>         if (!ret)
> >>>           adev->vcn.cur_state[inst] =3D state;
