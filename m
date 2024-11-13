Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBA4D637CA
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 21:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C520C10E060;
	Wed, 13 Nov 2024 21:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="alT8lmsJ";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A96510E298
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 21:44:01 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-71e702c0ac2so226694b3a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 13:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731534240; x=1732139040; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=svlWZldEBYWwS4MkWKrhihhVNqjQb8U5hbFTbwjU96Y=;
 b=alT8lmsJZ7MqftpvhP4tNJ6dv64KfPV/AjSBUl28ZZ2kSHsM6GC5nUfGw+GJQwFr2e
 UGhlM/dCQc0F8lY2rdM8rPpznN4+dHh0luAaS7AvAWL7gE1pg7PoRPOam7ix0A1ATSb8
 e16PFXr0zaMj2zKcUKgNcyI3W1GrI+X1yAb8znTWcalybKynyWywFNqXd83cEGvzltOW
 yuJpnka+nEXP1+y0Z8xVfYdEHtJEiVijkX7dp5BAIRiNxcO4HWZStgipehWs6rvfhhDa
 Mgnr5FlIcdShZKoYRb7lLArzLtJQO76FOTcqpR3Vz9uj7z3l8i0Jn53kuB7uhk/8HQD5
 yX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731534240; x=1732139040;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=svlWZldEBYWwS4MkWKrhihhVNqjQb8U5hbFTbwjU96Y=;
 b=fMaWjn6tVJxkXs3uMq3wuHXcVD2UUK5VxYCtUhM+IRoDvHFey0FDcdmHY/cE3dpboF
 CdDCbD9gCNgvBTzPVtE7cR5gyuRGMW6z0Pf6oGYRwUdScwM+onM0wcXJSdRJ/tdGbC/d
 6zYmFb/FB1tqJ7MLm/9YBEhkvM0Xp7kmcqiA+4uEFo2ZOyhsI+11gf7OxOCudP3u/LsO
 iPQEMf/qrLPiHr5e9GKp4Fqag9Xu+RVvuXCnZfVM07uU4WNg3fJOM71NFOCVXVIWPWFm
 BfGvw6EcebQPPDW4GBKlsNv5KcUx3BCeuhnZsczUJ+skc98kBnAJT28nHV9tyBjjoM37
 6Sxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9w5wEvlurRkPPZFhBqgBHA3P5wBMg7Zj92EEemgoL82HjRjlx57c4mhix5qCU0Tc0ClZ+gS6d@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBRFTOPi5/vkILc02W+Nqwd2OivRZUNfUkBiqu2W1TWOaqfXGS
 J5DdxGDgs1aFomUm+G1GEiSvFFscEc3DtjOp5Hs8Lg0k2bO3AcLemKrYustnCt2EZd8yF8StHev
 Ak81X3M3qcpRwx17WqjbZ9JTTpos=
X-Google-Smtp-Source: AGHT+IH7gk1ZZGMb7j3lM/QfUa2d2eADx98j1G4rBl5yDbOyQjHmb8BLmL+o/Q5eQYR2aBOSrgD5k3CYV+rafyDbuEA=
X-Received: by 2002:a05:6a00:66d0:b0:724:453a:fd0 with SMTP id
 d2e1a72fcca58-724453a1c17mr5196456b3a.6.1731534240495; Wed, 13 Nov 2024
 13:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20241112143050.1931822-1-jesse.zhang@amd.com>
 <20241112143050.1931822-2-jesse.zhang@amd.com>
 <910caa3a-802a-41d6-ae07-c39292081d4d@amd.com>
 <DM4PR12MB51524E90E5A98A03BF7FDD8CE35A2@DM4PR12MB5152.namprd12.prod.outlook.com>
 <63fcdfc5-af2a-4065-ab5a-81ca5dca6db9@amd.com>
 <CADnq5_Pix7r90tHzXF85vNMrqk+KZSOGSgHRuCvHH1LSG6JVgQ@mail.gmail.com>
 <e8698f59-6fe2-41b3-b023-5e9af848a0c1@amd.com>
 <CADnq5_MNGZKhmd3JMy_=ZahBzUMPxgOtT+T-7j12GDBx7mF=Pg@mail.gmail.com>
 <e568ec2b-028c-4221-ab21-940e600e1508@amd.com>
In-Reply-To: <e568ec2b-028c-4221-ab21-940e600e1508@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Nov 2024 16:43:48 -0500
Message-ID: <CADnq5_O9RVN_oOVuxOrbfPyX5DGukJ3r65JYwrkfkfKJ1jXPgg@mail.gmail.com>
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

On Wed, Nov 13, 2024 at 12:32=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 11/13/2024 10:54 AM, Alex Deucher wrote:
> > On Wed, Nov 13, 2024 at 12:03=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.co=
m> wrote:
> >>
> >>
> >>
> >> On 11/13/2024 10:16 AM, Alex Deucher wrote:
> >>> On Tue, Nov 12, 2024 at 10:24=E2=80=AFPM Lazar, Lijo <lijo.lazar@amd.=
com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 11/13/2024 7:58 AM, Zhang, Jesse(Jie) wrote:
> >>>>> [AMD Official Use Only - AMD Internal Distribution Only]
> >>>>>
> >>>>> Hi, Lijo,
> >>>>>
> >>>>> -----Original Message-----
> >>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> >>>>> Sent: Tuesday, November 12, 2024 10:54 PM
> >>>>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesk=
top.org
> >>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christi=
an <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Hu=
ang, Tim <Tim.Huang@amd.com>
> >>>>> Subject: Re: [PATCH 2/2] drm/amdgpu: fix vcn sw init failed
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 11/12/2024 8:00 PM, Jesse.zhang@amd.com wrote:
> >>>>>> [ 2875.870277] [drm:amdgpu_device_init [amdgpu]] *ERROR* sw_init o=
f IP
> >>>>>> block <vcn_v4_0_3> failed -22 [ 2875.880494] amdgpu 0000:01:00.0:
> >>>>>> amdgpu: amdgpu_device_ip_init failed [ 2875.887689] amdgpu
> >>>>>> 0000:01:00.0: amdgpu: Fatal error during GPU init [ 2875.894791] a=
mdgpu 0000:01:00.0: amdgpu: amdgpu: finishing device.
> >>>>>>
> >>>>>> Add irqs with different IRQ source pointer for vcn0 and vcn1.
> >>>>>>
> >>>>>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> >>>>>> ---
> >>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 19 +++++++++++++------
> >>>>>>  1 file changed, 13 insertions(+), 6 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >>>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >>>>>> index ef3dfd44a022..82b90f1e6f33 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >>>>>> @@ -83,6 +83,10 @@ static const struct amdgpu_hwip_reg_entry
> >>>>>> vcn_reg_list_4_0_3[] =3D {
> >>>>>>
> >>>>>>  #define NORMALIZE_VCN_REG_OFFSET(offset) \
> >>>>>>               (offset & 0x1FFFF)
> >>>>>> +static int amdgpu_ih_clientid_vcns[] =3D {
> >>>>>> +     SOC15_IH_CLIENTID_VCN,
> >>>>>> +     SOC15_IH_CLIENTID_VCN1
> >>>>>
> >>>>> This is not valid for 4.0.3. It uses only the same client id, diffe=
rent node_id to distinguish. Also, there are max of 4 instances.
> >>>>>
> >>>>> I would say that entire IP instance series was done in a haste with=
out applying thought and breaks other things including ip block mask.
> >>>>>
> >>>>> If the same client id is used, it returns -EINVAL (because of the f=
ollowing check) and sw init fails at step vcn_v4_0_3_sw_init / amdgpu_irq_a=
dd_id.
> >>>>>
> >>>>> amdgpu_irq_add_id:
> >>>>> if (adev->irq.client[client_id].sources[src_id] !=3D NULL)
> >>>>>         return -EINVAL;
> >>>>>
> >>>>
> >>>> We had some side discussions on IP block-per-instance approach.
> >>>> Personally, I was not in favour of it as I thought allowing IP block=
 to
> >>>> handle its own instances is the better approach and that could handl=
e
> >>>> dependencies between instances. Turns out that there are more like
> >>>> handling common things for all instances as in this example.
> >>>
> >>> We tried that route as well before this one and it was ugly as well.
> >>>
> >>>>
> >>>> I would prefer to revert the patch series and consider all angles be=
fore
> >>>> moving forward on the approach. Will leave this to Alex/Christian/Le=
o on
> >>>> the final decsion.
> >>>
> >>> Do the attached patches fix it?
> >>>
> >>
> >> This is kind of a piece-meal fix. This doesn't address the larger
> >> problem of how to handle things common for all IP instances.
> >
> > I think we'll need to handle them as we encounter them.  We can always
> > split common stuff out to helpers which can be used by multiple
> > instances.
>
> I don't think so. It made a fundamental change. We changed the base
> layer of considering IP as a single block. A common swinit or swfini is
> no longer the case. Consider how a sysfs initialization like
> enable_isolation could be handled if the same approach is taken for GFX I=
P.
>
> I would still say that we broke the current foundation with this
> approach and hoping that uppper layer fixes can help to hold things
> together. Or, it needs a start-from-scratch approach.

This was the original intention when we first designed the driver and
the IP block structures.  Unfortunately all of the early chips only
had one instance of each IP block and since then we've just built up
technical debt with respect to the instance handling.  That said, I
think the rework of this level at this point is probably too much, in
digging through the current state, there are just too many corner
cases to fix up.  I agree we should probably forgo it at this point.

Alex


Alex

>
> Thanks,
> Lijo
>
>   But I think once we get past this refactoring it will put
> > us in a better place for dealing with multiple IP instances.  Consider
> > the case of a part with multiple blocks of the same type with
> > different IP versions.  Those would not easily be handled with a
> > single IP block handling multiple IP instances.
> >
> > Alex
> >
> >>
> >> Thanks,
> >> Lijo
> >>
> >>> Alex
> >>>
> >>>>
> >>>> Thanks,
> >>>> Lijo
> >>>>
> >>>>> Regards
> >>>>> Jesse
> >>>>>
> >>>>>
> >>>>> Thanks,
> >>>>> Lijo
> >>>>>
> >>>>>> +};
> >>>>>>
> >>>>>>  static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
> >>>>>> static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device
> >>>>>> *adev, int inst); @@ -150,9 +154,9 @@ static int vcn_v4_0_3_sw_ini=
t(struct amdgpu_ip_block *ip_block)
> >>>>>>       if (r)
> >>>>>>               return r;
> >>>>>>
> >>>>>> -     /* VCN DEC TRAP */
> >>>>>> -     r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
> >>>>>> -             VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.=
inst->irq);
> >>>>>> +     /* VCN UNIFIED TRAP */
> >>>>>> +     r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> >>>>>> +                     VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
> >>>>>> +&adev->vcn.inst[inst].irq);
> >>>>>>       if (r)
> >>>>>>               return r;
> >>>>>>
> >>>>>> @@ -174,7 +178,7 @@ static int vcn_v4_0_3_sw_init(struct
> >>>>>> amdgpu_ip_block *ip_block)
> >>>>>>
> >>>>>>       ring->vm_hub =3D AMDGPU_MMHUB0(adev->vcn.inst[inst].aid_id);
> >>>>>>       sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[inst].a=
id_id);
> >>>>>> -     r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq=
, 0,
> >>>>>> +     r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst=
].irq, 0,
> >>>>>>                                AMDGPU_RING_PRIO_DEFAULT,
> >>>>>>                                &adev->vcn.inst[inst].sched_score);
> >>>>>>       if (r)
> >>>>>> @@ -1734,9 +1738,12 @@ static const struct amdgpu_irq_src_funcs vc=
n_v4_0_3_irq_funcs =3D {
> >>>>>>   */
> >>>>>>  static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, =
int
> >>>>>> inst)  {
> >>>>>> -     adev->vcn.inst->irq.num_types++;
> >>>>>> +     if (adev->vcn.harvest_config & (1 << inst))
> >>>>>> +             return;
> >>>>>> +
> >>>>>> +     adev->vcn.inst[inst].irq.num_types =3D adev->vcn.num_enc_rin=
gs + 1;
> >>>>>>
> >>>>>> -     adev->vcn.inst->irq.funcs =3D &vcn_v4_0_3_irq_funcs;
> >>>>>> +     adev->vcn.inst[inst].irq.funcs =3D &vcn_v4_0_3_irq_funcs;
> >>>>>>  }
> >>>>>>
> >>>>>>  static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block
> >>>>>> *ip_block, struct drm_printer *p)
