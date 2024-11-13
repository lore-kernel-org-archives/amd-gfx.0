Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204F6D41C00
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 05:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABC2F10E344;
	Wed, 13 Nov 2024 05:24:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TMhqHMzF";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E023110E67E
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 05:24:50 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-7edec25102dso196493a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 21:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731475490; x=1732080290; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ef2tBIymTvpk/6XwzUoFgfd80tXAgUUXwP16gfh6fsA=;
 b=TMhqHMzFk70dso/Wy4q++lwseJdhH9xPDN+zQ9ogPwB5R/+xV3JXSCvR6VioX+g7RK
 Rv/SHLSSlr76t4XyhEonzQ0SOMPPJSGGKErJ2Sb78kjfPAOPHy5yWXiFDCzA/LPcPZAs
 NWYVsdK/pekMkTmt9QNwktvqGmAtCh40oxdRwYnxdk6/IKOt0vOkKxzn0Giq7kvnWnF4
 PkM60QkDcHFPnOHvcRvDo0w8XtvpJFtbzqelaztIrJFyXHHLpW4QiycgPN+xHKmOdf40
 iasUAky0xryevE07zcLlADT2JqstuXPeTwbXWH376C2TwssB+KUbRpgYR7CpvsdyVtYl
 SRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731475490; x=1732080290;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ef2tBIymTvpk/6XwzUoFgfd80tXAgUUXwP16gfh6fsA=;
 b=k0nvk2+sXqbPNgRULpJXVCEfXC39fJo6Pk/jCpmt8z04psyzc/mRc564R7feJsRiNR
 21tTuluPIZAuWfb1GEDMmIcQriNua9+He0IPcNhxwDkg4/pdbAYEEZ45xmICjA2ItWvR
 pkh1V8g8EBZ7gAAY9tpX8j8SggZs/w7xN9okTLpp35khzaXs7JEFdgRybl0AGr9KcTEV
 xRCl3w59Bq5D7hJt/+dYpfqY3qTEMMoU+IXH85gUZTUmnFUVawgzOup317R7JaQMs4D3
 fAQge+jrm6U2pLI/2nv0r9P5TKYWJIwkXsjwWvecQK0AThuHUoYYuYLsuWXkDApn/Uqj
 9/Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmtti7ggEqClkRzuHpYqZXhG3GJ7r/L7J0DUeFndvTTUm9pSQkcl6z3WRw2fD31oBPVDxmPk0S@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBqNTI9Fxp4trJ5KW8B/dG9kzU8huWI7/4shSOlERzrgmGOrCH
 pEFQDqgHhK3HN1pR27VMEOAPLZp5SckgOEdDmdXqTAdI8hJEyxZRaeN/JJC7ho4427PFWPr209j
 bWOi9kFL+vNFZgvCGXaXeHQhb1V0=
X-Google-Smtp-Source: AGHT+IF3bgYzM6chRqetMjYW0KrKsugDWFOKaBiOKrOGalqKs6ppHyIpWSgF+CgaPVG/xiN960uRJqMouUaWaD68d/w=
X-Received: by 2002:a17:902:f70f:b0:207:14ab:c436 with SMTP id
 d9443c01a7336-2118357ff3fmr106622545ad.12.1731475490278; Tue, 12 Nov 2024
 21:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20241112143050.1931822-1-jesse.zhang@amd.com>
 <20241112143050.1931822-2-jesse.zhang@amd.com>
 <910caa3a-802a-41d6-ae07-c39292081d4d@amd.com>
 <DM4PR12MB51524E90E5A98A03BF7FDD8CE35A2@DM4PR12MB5152.namprd12.prod.outlook.com>
 <63fcdfc5-af2a-4065-ab5a-81ca5dca6db9@amd.com>
 <CADnq5_Pix7r90tHzXF85vNMrqk+KZSOGSgHRuCvHH1LSG6JVgQ@mail.gmail.com>
 <e8698f59-6fe2-41b3-b023-5e9af848a0c1@amd.com>
In-Reply-To: <e8698f59-6fe2-41b3-b023-5e9af848a0c1@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Nov 2024 00:24:38 -0500
Message-ID: <CADnq5_MNGZKhmd3JMy_=ZahBzUMPxgOtT+T-7j12GDBx7mF=Pg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix vcn sw init failed
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
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

On Wed, Nov 13, 2024 at 12:03=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 11/13/2024 10:16 AM, Alex Deucher wrote:
> > On Tue, Nov 12, 2024 at 10:24=E2=80=AFPM Lazar, Lijo <lijo.lazar@amd.co=
m> wrote:
> >>
> >>
> >>
> >> On 11/13/2024 7:58 AM, Zhang, Jesse(Jie) wrote:
> >>> [AMD Official Use Only - AMD Internal Distribution Only]
> >>>
> >>> Hi, Lijo,
> >>>
> >>> -----Original Message-----
> >>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> >>> Sent: Tuesday, November 12, 2024 10:54 PM
> >>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedeskto=
p.org
> >>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian=
 <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Huan=
g, Tim <Tim.Huang@amd.com>
> >>> Subject: Re: [PATCH 2/2] drm/amdgpu: fix vcn sw init failed
> >>>
> >>>
> >>>
> >>> On 11/12/2024 8:00 PM, Jesse.zhang@amd.com wrote:
> >>>> [ 2875.870277] [drm:amdgpu_device_init [amdgpu]] *ERROR* sw_init of =
IP
> >>>> block <vcn_v4_0_3> failed -22 [ 2875.880494] amdgpu 0000:01:00.0:
> >>>> amdgpu: amdgpu_device_ip_init failed [ 2875.887689] amdgpu
> >>>> 0000:01:00.0: amdgpu: Fatal error during GPU init [ 2875.894791] amd=
gpu 0000:01:00.0: amdgpu: amdgpu: finishing device.
> >>>>
> >>>> Add irqs with different IRQ source pointer for vcn0 and vcn1.
> >>>>
> >>>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> >>>> ---
> >>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 19 +++++++++++++------
> >>>>  1 file changed, 13 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >>>> index ef3dfd44a022..82b90f1e6f33 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >>>> @@ -83,6 +83,10 @@ static const struct amdgpu_hwip_reg_entry
> >>>> vcn_reg_list_4_0_3[] =3D {
> >>>>
> >>>>  #define NORMALIZE_VCN_REG_OFFSET(offset) \
> >>>>               (offset & 0x1FFFF)
> >>>> +static int amdgpu_ih_clientid_vcns[] =3D {
> >>>> +     SOC15_IH_CLIENTID_VCN,
> >>>> +     SOC15_IH_CLIENTID_VCN1
> >>>
> >>> This is not valid for 4.0.3. It uses only the same client id, differe=
nt node_id to distinguish. Also, there are max of 4 instances.
> >>>
> >>> I would say that entire IP instance series was done in a haste withou=
t applying thought and breaks other things including ip block mask.
> >>>
> >>> If the same client id is used, it returns -EINVAL (because of the fol=
lowing check) and sw init fails at step vcn_v4_0_3_sw_init / amdgpu_irq_add=
_id.
> >>>
> >>> amdgpu_irq_add_id:
> >>> if (adev->irq.client[client_id].sources[src_id] !=3D NULL)
> >>>         return -EINVAL;
> >>>
> >>
> >> We had some side discussions on IP block-per-instance approach.
> >> Personally, I was not in favour of it as I thought allowing IP block t=
o
> >> handle its own instances is the better approach and that could handle
> >> dependencies between instances. Turns out that there are more like
> >> handling common things for all instances as in this example.
> >
> > We tried that route as well before this one and it was ugly as well.
> >
> >>
> >> I would prefer to revert the patch series and consider all angles befo=
re
> >> moving forward on the approach. Will leave this to Alex/Christian/Leo =
on
> >> the final decsion.
> >
> > Do the attached patches fix it?
> >
>
> This is kind of a piece-meal fix. This doesn't address the larger
> problem of how to handle things common for all IP instances.

I think we'll need to handle them as we encounter them.  We can always
split common stuff out to helpers which can be used by multiple
instances.  But I think once we get past this refactoring it will put
us in a better place for dealing with multiple IP instances.  Consider
the case of a part with multiple blocks of the same type with
different IP versions.  Those would not easily be handled with a
single IP block handling multiple IP instances.

Alex

>
> Thanks,
> Lijo
>
> > Alex
> >
> >>
> >> Thanks,
> >> Lijo
> >>
> >>> Regards
> >>> Jesse
> >>>
> >>>
> >>> Thanks,
> >>> Lijo
> >>>
> >>>> +};
> >>>>
> >>>>  static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
> >>>> static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device
> >>>> *adev, int inst); @@ -150,9 +154,9 @@ static int vcn_v4_0_3_sw_init(=
struct amdgpu_ip_block *ip_block)
> >>>>       if (r)
> >>>>               return r;
> >>>>
> >>>> -     /* VCN DEC TRAP */
> >>>> -     r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
> >>>> -             VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.in=
st->irq);
> >>>> +     /* VCN UNIFIED TRAP */
> >>>> +     r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> >>>> +                     VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
> >>>> +&adev->vcn.inst[inst].irq);
> >>>>       if (r)
> >>>>               return r;
> >>>>
> >>>> @@ -174,7 +178,7 @@ static int vcn_v4_0_3_sw_init(struct
> >>>> amdgpu_ip_block *ip_block)
> >>>>
> >>>>       ring->vm_hub =3D AMDGPU_MMHUB0(adev->vcn.inst[inst].aid_id);
> >>>>       sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[inst].aid=
_id);
> >>>> -     r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, =
0,
> >>>> +     r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].=
irq, 0,
> >>>>                                AMDGPU_RING_PRIO_DEFAULT,
> >>>>                                &adev->vcn.inst[inst].sched_score);
> >>>>       if (r)
> >>>> @@ -1734,9 +1738,12 @@ static const struct amdgpu_irq_src_funcs vcn_=
v4_0_3_irq_funcs =3D {
> >>>>   */
> >>>>  static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, in=
t
> >>>> inst)  {
> >>>> -     adev->vcn.inst->irq.num_types++;
> >>>> +     if (adev->vcn.harvest_config & (1 << inst))
> >>>> +             return;
> >>>> +
> >>>> +     adev->vcn.inst[inst].irq.num_types =3D adev->vcn.num_enc_rings=
 + 1;
> >>>>
> >>>> -     adev->vcn.inst->irq.funcs =3D &vcn_v4_0_3_irq_funcs;
> >>>> +     adev->vcn.inst[inst].irq.funcs =3D &vcn_v4_0_3_irq_funcs;
> >>>>  }
> >>>>
> >>>>  static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block
> >>>> *ip_block, struct drm_printer *p)
