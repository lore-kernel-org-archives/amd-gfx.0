Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B90D65C7E
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 14:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D887F10E061;
	Fri, 15 Nov 2024 14:24:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YgIEi6d8";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74C0610E061
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 14:24:58 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2e9b23d189cso266613a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 06:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731680698; x=1732285498; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p3B9n9zRLK4UepwJq68J0GUEbbv2DXqsttYOMrLg/Xw=;
 b=YgIEi6d8AyQV1YDzvL0aMSkudGMrwqrFDE42bV5ne9f1nbFpr585gVzKmIfKctU5pD
 Y4u3r5DZG7LMO/gBbuOkZe+NQ3ZQsOcHveRcCtpj/wRXp6Wrg6QwrejnE+WbqWnNt2rP
 ftJc6Xo7pZVl47EHlJBF4ejdhlAFZ5ltsyM9K98V/g9ROxIzPUzpoZoHZi+/FuPMkTy0
 s2Awfr1qc1H/5CwLB/ahF4GxSkiOUG+NDTPOkgofd81pOfHnw74F3sC6qHyfQmdknyOO
 yLbASbiM9O5JXXLZ844Ue7wN8rKSdyDBKP/tOG+2PWCbh7r2xsHHXvEPqLxJP7B1kfHG
 EyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680698; x=1732285498;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p3B9n9zRLK4UepwJq68J0GUEbbv2DXqsttYOMrLg/Xw=;
 b=jyJG7Nb7EHj/JjCxEOKKPdHSG/Vz4G8FKut2vOC42GgdL2Z0o/HII5Yx42WIBawGDb
 ca5vRbiUueWz4gkoyoWd3dffpntU9y0Z0n2iacwo2rteGWNDZlpVOla1/8RxCjzZqs6u
 a5oCp2jrfaGQbOzKpPU8w5DZjI5QvTkyVIq6zSbn9sz7VnD9FVoM0l7l9hfBtPoGPSqO
 0oy17Zh6oKu10KkHWtSmPOc5GvlNVTfGgVnfQPCD59mL4SX/OYHtTpDIgrbGVfcpUjsQ
 jfXdPd5qrV9dyccs7j1gSZFxWjRxCdCvW9i+VeH90mD4IpGaC0f3T1N66ADkSQEPx6+P
 E/0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJPrmyTVC9BU5xuJQSeqAbb5OufHV1cQGwS01raRra+i5v9LAcLqzG85BthCrO/8DyTlGHY5dE@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyfCz57jr9NDvpV3h+VUxfdTThIVLTSYrlijBsLeuBzEXKGf9vf
 6g4F/z4D8CKsd0KRmfLsoRB+Lhzq3V0lPEDuYQwtAadUMxyaki4nFEWnEP9GNEMCwJe6w4iv5nn
 aaOIlv3TL5h97NDre1oQkkOpte5VVfg==
X-Google-Smtp-Source: AGHT+IG+5FHyyuzcBplcH9xheXrFYObodOgAbZblaUj79/FhTUNWlV/mJ6YPYu1LbeQKI5L81ayYFCPzhaBxEpkDvIU=
X-Received: by 2002:a17:90b:38d2:b0:2d8:be3b:4785 with SMTP id
 98e67ed59e1d1-2ea15591f48mr1481213a91.6.1731680697786; Fri, 15 Nov 2024
 06:24:57 -0800 (PST)
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
 <CADnq5_O9RVN_oOVuxOrbfPyX5DGukJ3r65JYwrkfkfKJ1jXPgg@mail.gmail.com>
 <2380f3f1-e055-4ca7-80c4-182cb44bc3db@gmail.com>
In-Reply-To: <2380f3f1-e055-4ca7-80c4-182cb44bc3db@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 Nov 2024 09:24:45 -0500
Message-ID: <CADnq5_ORv-7Mf-5WeN_W7JdjExuo5f3MVC1upJabvro+EspjOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix vcn sw init failed
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: "Lazar, Lijo" <lijo.lazar@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>, 
 "Zhang, Boyuan" <Boyuan.Zhang@amd.com>
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

On Fri, Nov 15, 2024 at 7:34=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 13.11.24 um 22:43 schrieb Alex Deucher:
> > On Wed, Nov 13, 2024 at 12:32=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.co=
m> wrote:
> >>
> >>
> >> On 11/13/2024 10:54 AM, Alex Deucher wrote:
> >>> On Wed, Nov 13, 2024 at 12:03=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.=
com> wrote:
> >>>>
> >>>>
> >>>> On 11/13/2024 10:16 AM, Alex Deucher wrote:
> >>>>> On Tue, Nov 12, 2024 at 10:24=E2=80=AFPM Lazar, Lijo <lijo.lazar@am=
d.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 11/13/2024 7:58 AM, Zhang, Jesse(Jie) wrote:
> >>>>>>> [AMD Official Use Only - AMD Internal Distribution Only]
> >>>>>>>
> >>>>>>> Hi, Lijo,
> >>>>>>>
> >>>>>>> -----Original Message-----
> >>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> >>>>>>> Sent: Tuesday, November 12, 2024 10:54 PM
> >>>>>>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freede=
sktop.org
> >>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Chris=
tian <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; =
Huang, Tim <Tim.Huang@amd.com>
> >>>>>>> Subject: Re: [PATCH 2/2] drm/amdgpu: fix vcn sw init failed
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 11/12/2024 8:00 PM, Jesse.zhang@amd.com wrote:
> >>>>>>>> [ 2875.870277] [drm:amdgpu_device_init [amdgpu]] *ERROR* sw_init=
 of IP
> >>>>>>>> block <vcn_v4_0_3> failed -22 [ 2875.880494] amdgpu 0000:01:00.0=
:
> >>>>>>>> amdgpu: amdgpu_device_ip_init failed [ 2875.887689] amdgpu
> >>>>>>>> 0000:01:00.0: amdgpu: Fatal error during GPU init [ 2875.894791]=
 amdgpu 0000:01:00.0: amdgpu: amdgpu: finishing device.
> >>>>>>>>
> >>>>>>>> Add irqs with different IRQ source pointer for vcn0 and vcn1.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> >>>>>>>> ---
> >>>>>>>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 19 +++++++++++++----=
--
> >>>>>>>>   1 file changed, 13 insertions(+), 6 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >>>>>>>> index ef3dfd44a022..82b90f1e6f33 100644
> >>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >>>>>>>> @@ -83,6 +83,10 @@ static const struct amdgpu_hwip_reg_entry
> >>>>>>>> vcn_reg_list_4_0_3[] =3D {
> >>>>>>>>
> >>>>>>>>   #define NORMALIZE_VCN_REG_OFFSET(offset) \
> >>>>>>>>                (offset & 0x1FFFF)
> >>>>>>>> +static int amdgpu_ih_clientid_vcns[] =3D {
> >>>>>>>> +     SOC15_IH_CLIENTID_VCN,
> >>>>>>>> +     SOC15_IH_CLIENTID_VCN1
> >>>>>>> This is not valid for 4.0.3. It uses only the same client id, dif=
ferent node_id to distinguish. Also, there are max of 4 instances.
> >>>>>>>
> >>>>>>> I would say that entire IP instance series was done in a haste wi=
thout applying thought and breaks other things including ip block mask.
> >>>>>>>
> >>>>>>> If the same client id is used, it returns -EINVAL (because of the=
 following check) and sw init fails at step vcn_v4_0_3_sw_init / amdgpu_irq=
_add_id.
> >>>>>>>
> >>>>>>> amdgpu_irq_add_id:
> >>>>>>> if (adev->irq.client[client_id].sources[src_id] !=3D NULL)
> >>>>>>>          return -EINVAL;
> >>>>>>>
> >>>>>> We had some side discussions on IP block-per-instance approach.
> >>>>>> Personally, I was not in favour of it as I thought allowing IP blo=
ck to
> >>>>>> handle its own instances is the better approach and that could han=
dle
> >>>>>> dependencies between instances. Turns out that there are more like
> >>>>>> handling common things for all instances as in this example.
> >>>>> We tried that route as well before this one and it was ugly as well=
.
> >>>>>
> >>>>>> I would prefer to revert the patch series and consider all angles =
before
> >>>>>> moving forward on the approach. Will leave this to Alex/Christian/=
Leo on
> >>>>>> the final decsion.
> >>>>> Do the attached patches fix it?
> >>>>>
> >>>> This is kind of a piece-meal fix. This doesn't address the larger
> >>>> problem of how to handle things common for all IP instances.
> >>> I think we'll need to handle them as we encounter them.  We can alway=
s
> >>> split common stuff out to helpers which can be used by multiple
> >>> instances.
> >> I don't think so. It made a fundamental change. We changed the base
> >> layer of considering IP as a single block. A common swinit or swfini i=
s
> >> no longer the case. Consider how a sysfs initialization like
> >> enable_isolation could be handled if the same approach is taken for GF=
X IP.
> >>
> >> I would still say that we broke the current foundation with this
> >> approach and hoping that uppper layer fixes can help to hold things
> >> together. Or, it needs a start-from-scratch approach.
> > This was the original intention when we first designed the driver and
> > the IP block structures.  Unfortunately all of the early chips only
> > had one instance of each IP block and since then we've just built up
> > technical debt with respect to the instance handling.  That said, I
> > think the rework of this level at this point is probably too much, in
> > digging through the current state, there are just too many corner
> > cases to fix up.  I agree we should probably forgo it at this point.
>
> I would really like to keep the design as is. The fallout we see is
> basically just points out that we have some more broken concepts here.
>
> For example sysfs file should never be initialized from IP specific
> functions in the first place. Why the heck do we do that?

Where else would we do it?  At the moment all of the IPs set up their
IP specific sysfs files.  Also, if we have one IP block per instance,
we may have different reset capabilities per instance.  In that case,
the sysfs files should be per instance.

Alex

>
> We should probably rather keep the design for the VCN generation Boyuan
> actually tested and see what else we need to fix to get to that design.
>
> Regards,
> Christian.
>
> >
> > Alex
> >
> >
> > Alex
> >
> >> Thanks,
> >> Lijo
> >>
> >>    But I think once we get past this refactoring it will put
> >>> us in a better place for dealing with multiple IP instances.  Conside=
r
> >>> the case of a part with multiple blocks of the same type with
> >>> different IP versions.  Those would not easily be handled with a
> >>> single IP block handling multiple IP instances.
> >>>
> >>> Alex
> >>>
> >>>> Thanks,
> >>>> Lijo
> >>>>
> >>>>> Alex
> >>>>>
> >>>>>> Thanks,
> >>>>>> Lijo
> >>>>>>
> >>>>>>> Regards
> >>>>>>> Jesse
> >>>>>>>
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Lijo
> >>>>>>>
> >>>>>>>> +};
> >>>>>>>>
> >>>>>>>>   static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
> >>>>>>>> static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_devi=
ce
> >>>>>>>> *adev, int inst); @@ -150,9 +154,9 @@ static int vcn_v4_0_3_sw_i=
nit(struct amdgpu_ip_block *ip_block)
> >>>>>>>>        if (r)
> >>>>>>>>                return r;
> >>>>>>>>
> >>>>>>>> -     /* VCN DEC TRAP */
> >>>>>>>> -     r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
> >>>>>>>> -             VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vc=
n.inst->irq);
> >>>>>>>> +     /* VCN UNIFIED TRAP */
> >>>>>>>> +     r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst=
],
> >>>>>>>> +                     VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
> >>>>>>>> +&adev->vcn.inst[inst].irq);
> >>>>>>>>        if (r)
> >>>>>>>>                return r;
> >>>>>>>>
> >>>>>>>> @@ -174,7 +178,7 @@ static int vcn_v4_0_3_sw_init(struct
> >>>>>>>> amdgpu_ip_block *ip_block)
> >>>>>>>>
> >>>>>>>>        ring->vm_hub =3D AMDGPU_MMHUB0(adev->vcn.inst[inst].aid_i=
d);
> >>>>>>>>        sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[inst=
].aid_id);
> >>>>>>>> -     r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->i=
rq, 0,
> >>>>>>>> +     r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[in=
st].irq, 0,
> >>>>>>>>                                 AMDGPU_RING_PRIO_DEFAULT,
> >>>>>>>>                                 &adev->vcn.inst[inst].sched_scor=
e);
> >>>>>>>>        if (r)
> >>>>>>>> @@ -1734,9 +1738,12 @@ static const struct amdgpu_irq_src_funcs =
vcn_v4_0_3_irq_funcs =3D {
> >>>>>>>>    */
> >>>>>>>>   static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *ade=
v, int
> >>>>>>>> inst)  {
> >>>>>>>> -     adev->vcn.inst->irq.num_types++;
> >>>>>>>> +     if (adev->vcn.harvest_config & (1 << inst))
> >>>>>>>> +             return;
> >>>>>>>> +
> >>>>>>>> +     adev->vcn.inst[inst].irq.num_types =3D adev->vcn.num_enc_r=
ings + 1;
> >>>>>>>>
> >>>>>>>> -     adev->vcn.inst->irq.funcs =3D &vcn_v4_0_3_irq_funcs;
> >>>>>>>> +     adev->vcn.inst[inst].irq.funcs =3D &vcn_v4_0_3_irq_funcs;
> >>>>>>>>   }
> >>>>>>>>
> >>>>>>>>   static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block
> >>>>>>>> *ip_block, struct drm_printer *p)
>
