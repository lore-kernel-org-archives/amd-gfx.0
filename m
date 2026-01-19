Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A62CCF2C5
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 09:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B917C10E3A8;
	Mon, 19 Jan 2026 09:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ee6xvq0v";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17CFB10E3A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 09:00:16 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-64b791b5584so7290854a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 01:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768813214; x=1769418014; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zEQKOC/RUgdYWqGcKnSW3nXVS61BKAkBnEe2bFLZS98=;
 b=ee6xvq0vG3pRtHfEdpIMBkrjB8NPivp1ikgwQKyEnUNguPbvXnucqFvVlEYamwHHOJ
 sLGawUXlu71UWFpOL15wWG67Rkf+q1yXKG3hB5VXUgEj8kJkHv+AWmFbCk+WvGNjdHRg
 VkwfpPCcUc9lFtKdQ98z3TxdfcC7RF1oucxlJj+E0NjM/btxJ6mpm+CS8Js2toQJ+LdS
 M7fgVg+EPSyfPs/IrVi7tPfbYolFKjc9+iWo5J0h6n3AXFSHt71SYxVmB0MLQ7Vb8OsB
 K8jLN//Fx+ad15iPfLT/BRCnZLEym8m1Aeyt0HPwb5DDj55SnxTk09ukz4D7EmqbN07j
 tJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768813214; x=1769418014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zEQKOC/RUgdYWqGcKnSW3nXVS61BKAkBnEe2bFLZS98=;
 b=Wvjz4G3aeL4Y22S4heU2mrnPtCNMoRD2CWLiVQ3NuKOJb6YKB/9h2i6yA6v1TqV5Gh
 1RzRFB/bKlKoQF9Q6laOWZjEXbKYKKHblJW6BOlRRNNvozSfmao77u1+htzTfkZKP80k
 oXPeLzCh1mkczEKoJEWbIvB5Sy21Umo8G+eshQf1XJjYCoW5Z4DK+5g1olOkrPoftZii
 YZV6C5+LPO8mwURiEvTnIfGlCCMjKQnHS6pJWLcdN4yT5NzFlYAYEDqXqIrKWzglD39B
 1eUjRy7Ka+Rm5lDOefbbbnGWhbValHN+m75fuyCqGpjrXpaZbkGC9r4WqlhFsipP89ZY
 inWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDIO8Zcjuq9LtDFO5vKu2k7caxK7JEtt6L90bGbhuErU+MQY/Asbz15s2SMfHHMN+nE7atheo8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEwtdLgVxgLLuMEzwI8vQVDsjrhxgNX592B+fErJHqbw0QPcth
 eBqzoFOJbQtUZJ+n1qpWr5R0adGfWBj9DM43CPa3lDkdZOBS3aRTRPe0
X-Gm-Gg: AY/fxX53dNqMx+bTT4N+ya3AIHN5ImeEqpM/bOCMRiYGyVhNcQGxqnCT6fziFeXqF7c
 9gF+6Y7mLMx9evFob/mdNCyEUoN54Eiq9z6B56hdlRDIF7rrfHJI+IeVRGj77sVApHIydUcVaba
 891n+2OX7Ajxi0NcEEfoMIKByj5Y0u7YxaYfc1+eBnU8D9mf+ApQNrl/8Ew7MBedpVGxYq8P6wA
 d//+/10g4oPLeXKhXAY78L0VZN52gxvSx0cWjiRCQ+NhYcE4maHX7aITQBIJ6XC19ho8H+Jom2p
 JrOa+OJlh+8rQxiRu+uTqBkrFnkL1dgE98JJq/N14EPM8+tAC8EeTAY0neWbxIBUJZlbHMeAUl5
 EFS2G3tDAzwxf7wxDF7N4P3KlSLTET8gb9JkaavVEu//vQ6pThW5lfQgCp5OdztxhTY/kRYD2XZ
 LKp0NI0yi+btErRNQG+8XwAc1DCF7AtNsNVfCTtxFAw1ZNsZEReXBAVPzq8ytcu8EN82gAvo3Ob
 UYqWiYtTm5Dxll9aHCUEwhZ
X-Received: by 2002:a17:907:7f91:b0:b87:3b:12ab with SMTP id
 a640c23a62f3a-b87968e56d2mr789831166b.17.1768813213974; 
 Mon, 19 Jan 2026 01:00:13 -0800 (PST)
Received: from timur-hyperion.localnet
 (20014C4E24E47400AD77F2CC91C9A6FE.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:7400:ad77:f2cc:91c9:a6fe])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8794f93c34sm1090067566b.0.2026.01.19.01.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 01:00:13 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "Liang, Prike" <Prike.Liang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix validating flush_gpu_tlb_pasid()
Date: Mon, 19 Jan 2026 10:00:12 +0100
Message-ID: <27224237.1r3eYUQgxm@timur-hyperion>
In-Reply-To: <DS7PR12MB6005D5AA955F34114114F779FB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260118125746.40221-1-timur.kristof@gmail.com>
 <DS7PR12MB6005F0626EDB392DA9F554E3FB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
 <DS7PR12MB6005D5AA955F34114114F779FB88A@DS7PR12MB6005.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Monday, January 19, 2026 6:27:10=E2=80=AFAM Central European Standard Ti=
me Liang,=20
Prike wrote:
> [Public]
>=20
> In order to avoid being blocked by the lock issue on some older GFX, I wi=
ll
> push the patch to amd-staging-drm-next.
> If you have any concerns, please
> let me know.
>=20

Hi Prike,

Thank you, feel free to add the necessary tags and push the patch.

Best regards,
Timur

>=20
>=20
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lian=
g,
> > Prike
 Sent: Monday, January 19, 2026 9:58 AM
> > To: Timur Krist=C3=B3f <timur.kristof@gmail.com>;
> > amd-gfx@lists.freedesktop.org;
 Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Dan Carpenter <dan.carpenter@linaro.org>
> > Subject: RE: [PATCH] drm/amdgpu: Fix validating flush_gpu_tlb_pasid()
> >
> >
> >
> > [Public]
> >
> >
> >
> > Thank you for the fix. Could you please add the following the tags?
> >
> >
> >
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > | Closes: https://lore.kernel.org/r/202601190121.z9C0uml5-lkp@intel.com/
> >
> >
> >
> > Reviewed-by: Prike Liang <Prike.Liang@amd.com>
> >
> >
> >
> > Regards,
> >=20
> >       Prike
> >
> >
> >
> > > -----Original Message-----
> > > From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > Sent: Sunday, January 18, 2026 8:58 PM
> > > To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; Koenig, Christian
> > > <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>;
> > > Limonciello, Mario <Mario.Limonciello@amd.com>
> > > Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > Subject: [PATCH] drm/amdgpu: Fix validating flush_gpu_tlb_pasid()
> > >
> > >
> > >
> > > When a function holds a lock and we return without unlocking it, it
> > > deadlocks the kernel. We should always unlock before returning.
> > >
> > >
> > >
> > > This commit fixes suspend/resume on SI.
> > > Tested on two Tahiti GPUs: FirePro W9000 and R9 280X.
> > >
> > >
> > >
> > > Fixes: bc2dea30038a ("drm/amdgpu: validate the flush_gpu_tlb_pasid()")
> > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > ---
> > >=20
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > >
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > > index 0e67fa4338ff..4fa24be1bf45 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > > @@ -769,7 +769,7 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
> > > amdgpu_device *adev, uint16_t pasid,
> > >=20
> > >       struct amdgpu_ring *ring =3D &adev->gfx.kiq[inst].ring;
> > >       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[inst];
> > >       unsigned int ndw;
> > >=20
> > > -     int r, cnt =3D 0;
> > > +     int r =3D 0, cnt =3D 0;
> > >=20
> > >       uint32_t seq;
> > >
> > >
> > >
> > >       /*
> > >=20
> > > @@ -782,7 +782,7 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
> > > amdgpu_device *adev, uint16_t pasid,
> > >=20
> > >       if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
> > >
> > >
> > >
> > >               if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid)
> > >=20
> > > -                     return 0;
> > > +                     goto error_unlock_reset;
> > >
> > >
> > >
> > >               if (adev->gmc.flush_tlb_needs_extra_type_2)
> > >              =20
> > >                       adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev,
> > >=20
> > > pasid, @@ -797,7 +797,6 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
> > > amdgpu_device *adev, uint16_t pasid,
> > >=20
> > >               adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
> > >              =20
> > >                                                        flush_type,
> > >                                                        all_hub,
> > >                                                        inst);
> > >=20
> > > -             r =3D 0;
> > >=20
> > >       } else {
> > >      =20
> > >               /* 2 dwords flush + 8 dwords fence */
> > >               ndw =3D kiq->pmf->invalidate_tlbs_size + 8;
> > >=20
> > > --
> > > 2.52.0
>=20
>=20




