Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34663C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 20:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C360910E155;
	Tue, 17 Jun 2025 20:14:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D/AY7i3k";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C89310E155
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 20:14:47 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-31384c8ba66so1130752a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 13:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750191287; x=1750796087; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a8aTEevQAWgYaRvxqt27PfCdxy8FCJ+UBGx0ZwoQDI4=;
 b=D/AY7i3kbb9xepjOYY2SiOkiUVBuPvzsfdmCoIuzoBeQ0DJqEfJZ++xc/bsqM5RS91
 ZRGiuoZ9eTyUDCjlTUQoZWnx6eKdcB1kjNM+oNt1h3BNYB54AXsGsH3j7N8G+kxgv4eZ
 PO02ng8kkyYhfbwrb7PMXjv3g/vOH8mrt3oLgjdcySrSRwLfJhadwuVJLmwbmSUjXmbq
 i76+FdyRqPJ64i/KjF0xnmdksUvaeysvoGgAmqpXr0USKTX0eRf9CjtFZDJWG0KVm6KP
 iwcUY0Dskjl2vx21LMA6J7MMaIfYJerMUIG2esZWrh96kuYIKI+s7/OmPPXQ9xverWw2
 lLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750191287; x=1750796087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a8aTEevQAWgYaRvxqt27PfCdxy8FCJ+UBGx0ZwoQDI4=;
 b=rzhN/Ai3HXJg2S/j4cGdFbI0JT5v0lm9yUv41pYlK6k1LwsXXlm8jxU1T4g9zvuZMe
 cqvcetSfnRZirNMd5t6QB/hSlj81THRTFYE9FCD2eAEn1jDg45F1ErJX3O5oRckjtVFA
 g1uKLAKlvwLzPBaTR7fXG1wEEFi2svyLv0d8Ixl9vkLMWjUx78pmjW/CeG+R2zmYE6qo
 tis1/N9W8IWFnqLgYwZzXT6RipJdWQfe53jhfQOFrWWJxNrtk8hf8mK8lLB8DDLNTc+o
 pRuN0zAsC6GRike70RTYWl7yMom4COP+HndSnba9vb/lFNpdfzwPlKhiTPU/UGrBiYr+
 WHIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt6R5MzSLjqHM6YxgiTy10XuDT/Fmicw5ugOsa7rO5fm3hJWHtyeBMwMFqvtHDY6YnFXDuEIby@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyaMsmVXAXBAC5pvc1TNeRMR0QCHA9WXI4YvcbIYW3c4VIbjr+
 hCuvy9wg3sdvjK7kFIYGuehey0cCEvSHMxC1wTrfooS8Ko9EvhhrFyz8BCrUTJlx2zcAewUnPFy
 qnou4DvplPwm0YSnpschj8NjNFxnhW1A=
X-Gm-Gg: ASbGncuPKtn/yjGz6efL89KyvuFGKt8GONY4zVwNGJaTPveyOZrM6wZvN96SrmJxGWk
 8HrKzkYSy86CYpCTZL0yEf7AOTzdeqIIdVZv6LgwFIzqitga91qPgahAGDuypzb6eW1hUdt5B0E
 GUqTayAHMOG6bwARz6LSEsxqTd5hlSXfKeDSNKth+fjkTJ
X-Google-Smtp-Source: AGHT+IHZ7VoZv/W4i1xtxid3Ud2J2wPn84Qc1itoJkkZ0bldmWu9zZkOiQycs5vI3MGvIEszRaTuk//l+vzcSQtwGig=
X-Received: by 2002:a17:90b:2c85:b0:310:8d54:3209 with SMTP id
 98e67ed59e1d1-3142562bd6fmr2437849a91.2.1750191286993; Tue, 17 Jun 2025
 13:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-37-alexander.deucher@amd.com>
 <f8b4bf5b-17ca-442a-a515-7860037a8afd@amd.com>
In-Reply-To: <f8b4bf5b-17ca-442a-a515-7860037a8afd@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Jun 2025 16:14:35 -0400
X-Gm-Features: AX0GCFvVldZ3mrFgJdN52M-CIPUBrS2_9ljyJ2vRvssp7_rN30gt18Mai7sMru8
Message-ID: <CADnq5_OisducAyYtztD5-L+ib_j8dh6p0HhCN9a3tV63duaDWA@mail.gmail.com>
Subject: Re: [PATCH 36/36] drm/amdgpu/vcn3: implement ring reset
To: "Sundararaju, Sathishkumar" <sasundar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com
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

On Tue, Jun 17, 2025 at 4:02=E2=80=AFPM Sundararaju, Sathishkumar
<sasundar@amd.com> wrote:
>
> Hi Alex,
>
> On 6/17/2025 8:38 AM, Alex Deucher wrote:
> > Use the new helpers to handle engine resets for VCN.
> >
> > Untested.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 24 ++++++++++++++++++++++++
> >   1 file changed, 24 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v3_0.c
> > index 9fb0d53805892..ec4d2ab75fc4d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > @@ -110,6 +110,7 @@ static int vcn_v3_0_set_pg_state(struct amdgpu_vcn_=
inst *vinst,
> >                                enum amd_powergating_state state);
> >   static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> >                                  struct dpg_pause_state *new_state);
> > +static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst);
> >
> >   static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
> >   static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
> > @@ -289,6 +290,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block =
*ip_block)
> >
> >               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> >                       adev->vcn.inst[i].pause_dpg_mode =3D vcn_v3_0_pau=
se_dpg_mode;
> > +             adev->vcn.inst[i].reset =3D vcn_v3_0_reset;
> >       }
> >
> >       if (amdgpu_sriov_vf(adev)) {
> > @@ -1869,6 +1871,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_de=
c_sw_ring_vm_funcs =3D {
> >       .emit_wreg =3D vcn_dec_sw_ring_emit_wreg,
> >       .emit_reg_wait =3D vcn_dec_sw_ring_emit_reg_wait,
> >       .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_=
helper,
> > +     .reset =3D amdgpu_vcn_ring_reset,
>
> You probably wanted to add reset callback to vcn_v3_0_enc_ring_vm_funcs
> instead ofvcn_v3_0_dec_sw_ring_vm_funcs.

I'll fix that up.

>
> With that, the vcn and jpeg changes in this series are :-
>
> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>

You mentioned that the start/stop sequence didn't work for some chips.
What sequence should I use for those?

Alex

>
> Test exceptions: VCN/JPEG 4_0_3 and VCN/JPEG 5_0_1.
>
> Regards,
> Sathish
>
> >   };
> >
> >   static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
> > @@ -2033,6 +2036,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_de=
c_ring_vm_funcs =3D {
> >       .emit_wreg =3D vcn_v2_0_dec_ring_emit_wreg,
> >       .emit_reg_wait =3D vcn_v2_0_dec_ring_emit_reg_wait,
> >       .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_=
helper,
> > +     .reset =3D amdgpu_vcn_ring_reset,
> >   };
> >
> >   /**
> > @@ -2164,6 +2168,26 @@ static void vcn_v3_0_set_enc_ring_funcs(struct a=
mdgpu_device *adev)
> >       }
> >   }
> >
> > +static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst)
> > +{
> > +     int i, r;
> > +
> > +     vcn_v3_0_stop(vinst);
> > +     vcn_v3_0_start(vinst);
> > +     r =3D amdgpu_ring_test_ring(&vinst->ring_dec);
> > +     if (r)
> > +             return r;
> > +     for (i =3D 0; i < vinst->num_enc_rings; i++) {
> > +             r =3D amdgpu_ring_test_ring(&vinst->ring_enc[i]);
> > +             if (r)
> > +                     return r;
> > +     }
> > +     amdgpu_fence_driver_force_completion(&vinst->ring_dec);
> > +     for (i =3D 0; i < vinst->num_enc_rings; i++)
> > +             amdgpu_fence_driver_force_completion(&vinst->ring_enc[i])=
;
> > +     return 0;
> > +}
> > +
> >   static bool vcn_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
> >   {
> >       struct amdgpu_device *adev =3D ip_block->adev;
>
