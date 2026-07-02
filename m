Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53D0C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 09:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BE1410E48D;
	Thu,  2 Jul 2026 09:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p6PNlso6";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 725EC10E48D
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 09:14:58 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-474560436c3so1443840f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jul 2026 02:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782983697; x=1783588497; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=29f4SD0+cuIdt7uUAWu2KXYyw6Lpe9CVRPAKxYC7PxE=;
 b=p6PNlso6U25sTAsZEdHDY/HzeirruHnY+hJTfbpcLgLVcjYmy4dBELhbXeVOptQ/Ci
 MXoBRpmmmgGGRzu20Rc4BA593FojAdS2Pv/TI2cAj5l1D+ijnBGOKflGiMVPS/dY78l5
 RKsy1NbPm1HltIQWnYzgzBT0ftBIuMWzPQ+TYDFmy58ZXzyB+KPpOfVXuHnYEGE1nduH
 LGGGRmZrNsJQWnnhbHxcIFkXA501Eb29L8wzCjqSV0SsV/s5X0cvHmwFV5JAHvdyDCQ6
 3451YwHtUyhLLU8HStKaDLT0lYO/mgX1YY+PJ824zJCe0pevcGEpIVN25suJsCI9nqm7
 7oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782983697; x=1783588497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=29f4SD0+cuIdt7uUAWu2KXYyw6Lpe9CVRPAKxYC7PxE=;
 b=YhSIKvyf60gIJu/CrXySeVvDmW8w4ZDkp0FsUBCZEZWBj8cnMbUG6rI4FWuK8i0dT8
 ruezbQL8pxEAlg+zCmwLBfWN07O2OfJlTDPZH+Nl2NRNuwFggcOYWqxX5kPQyOBZl8+J
 HMIAvJZiO3n0ZtQ56TV6k/UemkA9dj+nKvHdr/CaQnPZgPtLV3nVt4+oRlmGhITopYGE
 hQ1/XPaDmaMdez+ldqdCzRbmNnG5KRVOYcDaVpUamHzBeIoE5hvenYSy6nRujfAZPGxo
 ajjdRtq4v3JT40s0rAW80h/TgFZm+wdhjoEl1n3uYGOopAn2isnWNKzkT5FcC2jU1Ojt
 +RIg==
X-Gm-Message-State: AOJu0Yz4N4oKNiq4NXeNpiX3P3xW4hi/RwkVlPsLdnRXINsxtr7pnvrT
 x6oIc/8YztdoWBbdCvtS8PfPlU4HeMV2YmBd5kPaGZ0sEV13AP1EMRu0C+Jb+y3k
X-Gm-Gg: AfdE7cmc7vLq20gDSSrtpRh/LpPAZELN6sWZeedZXZKt6QP1ZXHYQHChU/EPalPAmYJ
 CO1BGEdhVblTE2GFPUhu75mqiBQlvmPv6cXR6Cqr5D1IhS5UkG+wMHz+DGWp4kvOYD6w41oigni
 lFhzFpHN1xTNan+XldcpTJ8iPv3ejDBwp9HjH8Rad5Y1C+Ts8t8RV7ttHiANNlXncvlfk6jwimg
 cHkaOuEM143yYkowmqZFKXRdPh0VxC+gmqOJzzcfqBmZowE0D4KREIrBin724acq0xUGbryo7gX
 tPB7TRcEJPbJdOIvTd/AoMr/Zzi6bVAOUfsU5jwkzUwhq0C4Zw+9gyJ/UJkwoYsL9QTy5pEL+hy
 uNBNy3G+KuCCDiaNI3o19C8GbmOnAgXaFtVLVSyjRDvrby4Rb3NVzVY126kPqMJDeeuoWPRMZry
 vtZXfnAyh5ICCxct4Cdzt5jFgep74xkYMlxlzeZcLVtSGc0zAzp9lVn9SXYZLWzseMJn9e3JeGp
 jxrMN6yuSwn4J5fjg==
X-Received: by 2002:a05:6000:2c0d:b0:476:cfa0:a976 with SMTP id
 ffacd0b85a97d-477aeb5c312mr6474731f8f.5.1782983696554; 
 Thu, 02 Jul 2026 02:14:56 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EF0F0080162CDB5B2DFACF.dsl.pool.telekom.hu.
 [2001:4c4e:24ef:f00:8016:2cdb:5b2d:facf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477ddf0fb15sm6300861f8f.29.2026.07.02.02.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 02:14:56 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 02/14] drm/amdgpu/gfxhub: Enable retry fault interrupts
 when needed
Date: Thu, 02 Jul 2026 11:14:53 +0200
Message-ID: <2821958.vuYhMxLoTh@timur-max>
In-Reply-To: <be24281a-465b-420b-9279-a749ebd79ba1@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-3-timur.kristof@gmail.com>
 <be24281a-465b-420b-9279-a749ebd79ba1@amd.com>
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

On 2026. j=C3=BAlius 2., cs=C3=BCt=C3=B6rt=C3=B6k 10:10:10 k=C3=B6z=C3=A9p-=
eur=C3=B3pai ny=C3=A1ri id=C5=91 Christian K=C3=B6nig=20
wrote:
> On 7/1/26 18:17, Timur Krist=C3=B3f wrote:
> > Enable retry fault interrupts when initializing the GFXHUB
> > system aperture registers according to whether retrying
> > page faults is enabled in amdgpu (ie. amdgpu.noretry=3D0).
> >=20
> > Needs to be done for each GFXHUB version at once,
> > because none of them actually enabled this interrupt.
>=20
> Thinking more about it we are clearly missing something here. The retry
> fault interrupt itself should be enabled all the time.

Why would it be enabled all the time?
I haven't seen any retry faults on neither Navi 3 nor Navi 4 without enabli=
ng=20
the ENABLE_RETRY_FAULT_INTERRUPT bit.

>=20
> IIRC only the RETRY_PERMISSION_OR_INVALID_PAGE_FAULT bit in the
> VM_CONTEXT0_CNTL register should be set or cleared by the kernel driver or
> firmware to control if the HW retries the access or not.

That is clearly not the case on GFX12.1 and I haven't seen any indication t=
hat=20
it would be different on GFX11.x and 12.0 either.


> > ---
> >=20
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 9 +++++++--
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 9 +++++++--
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 9 +++++++--
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 2 ++
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 9 +++++++--
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 9 +++++++--
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 9 +++++++--
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 9 +++++++--
> >  8 files changed, 51 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c index
> > 652eea6eae4a..ef20eafd59ae 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> > @@ -155,6 +155,7 @@ static void
> > gfxhub_v11_5_0_init_gart_aperture_regs(struct amdgpu_device *adev)>=20
> >  static void gfxhub_v11_5_0_init_system_aperture_regs(struct amdgpu_dev=
ice
> >  *adev) {
> > =20
> >  	uint64_t value;
> >=20
> > +	u32 tmp;
> >=20
> >  	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
> >  	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, adev->gmc.agp_start >>=20
24);
> >=20
> > @@ -180,8 +181,12 @@ static void
> > gfxhub_v11_5_0_init_system_aperture_regs(struct amdgpu_device *adev)>=20
> >  	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
> >  =09
> >  		     (u32)((u64)adev->dummy_page_addr >> 44));
> >=20
> > -	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
> > -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> > +	tmp =3D RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
> > +	tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> > +				=20
ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> > +	tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> > +				 ENABLE_RETRY_FAULT_INTERRUPT, !
adev->gmc.noretry);
> > +	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
> >=20
> >  }
> > =20
> >  static void gfxhub_v11_5_0_init_tlb_regs(struct amdgpu_device *adev)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c index
> > 6cbf837d50dd..ec3ff4dec674 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> > @@ -158,6 +158,7 @@ static void
> > gfxhub_v12_0_init_gart_aperture_regs(struct amdgpu_device *adev)>=20
> >  static void gfxhub_v12_0_init_system_aperture_regs(struct amdgpu_device
> >  *adev) {
> > =20
> >  	uint64_t value;
> >=20
> > +	u32 tmp;
> >=20
> >  	/* Program the AGP BAR */
> >  	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
> >=20
> > @@ -184,8 +185,12 @@ static void
> > gfxhub_v12_0_init_system_aperture_regs(struct amdgpu_device *adev)>=20
> >  	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
> >  =09
> >  		     (u32)((u64)adev->dummy_page_addr >> 44));
> >=20
> > -	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
> > -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> > +	tmp =3D RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
> > +	tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> > +				=20
ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> > +	tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> > +				 ENABLE_RETRY_FAULT_INTERRUPT, !
adev->gmc.noretry);
> > +	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
> >=20
> >  }
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c index
> > bfe247b1a333..27d7f7cb903f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> > @@ -91,6 +91,7 @@ static void gfxhub_v1_0_init_gart_aperture_regs(struct
> > amdgpu_device *adev)>=20
> >  static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device
> >  *adev) {
> > =20
> >  	uint64_t value;
> >=20
> > +	u32 tmp;
> >=20
> >  	if (!amdgpu_sriov_vf(adev) || adev->asic_type <=3D CHIP_VEGA10) {
> >  =09
> >  		/* Program the AGP BAR */
> >=20
> > @@ -134,8 +135,12 @@ static void
> > gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)>=20
> >  		WREG32_SOC15(GC, 0,=20
mmVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
> >  	=09
> >  			     (u32)((u64)adev->dummy_page_addr >>=20
44));
> >=20
> > -		WREG32_FIELD15(GC, 0, VM_L2_PROTECTION_FAULT_CNTL2,
> > -			       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY,=20
1);
> > +		tmp =3D RREG32_SOC15(GC, 0,=20
mmVM_L2_PROTECTION_FAULT_CNTL2);
> > +		tmp =3D REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
> > +					=20
ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> > +		tmp =3D REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
> > +					=20
ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
> > +		WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL2,=20
tmp);
> >=20
> >  	}
> >  =09
> >  	/* In the case squeezing vram into GART aperture, we don't use
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> > b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c index
> > fbdf46070b38..ed9a64bc5aaa 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> > @@ -176,6 +176,8 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct
> > amdgpu_device *adev,>=20
> >  			tmp =3D RREG32_SOC15(GC, GET_INST(GC, i),
> >  			regVM_L2_PROTECTION_FAULT_CNTL2);
> >  			tmp =3D REG_SET_FIELD(tmp,=20
VM_L2_PROTECTION_FAULT_CNTL2,
> >  		=09
> >  					   =20
ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> >=20
> > +			tmp =3D REG_SET_FIELD(tmp,=20
VM_L2_PROTECTION_FAULT_CNTL2,
> > +					   =20
ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
> >=20
> >  			WREG32_SOC15(GC, GET_INST(GC, i),=20
regVM_L2_PROTECTION_FAULT_CNTL2,
> >  			tmp);
> >  	=09
> >  		}
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c index
> > 9ea593e2c719..152b2735d360 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> > @@ -151,6 +151,7 @@ static void gfxhub_v2_0_init_gart_aperture_regs(str=
uct
> > amdgpu_device *adev)>=20
> >  static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device
> >  *adev) {
> > =20
> >  	uint64_t value;
> >=20
> > +	u32 tmp;
> >=20
> >  	if (!amdgpu_sriov_vf(adev)) {
> >  =09
> >  		/* Program the AGP BAR */
> >=20
> > @@ -178,8 +179,12 @@ static void
> > gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)>=20
> >  	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
> >  =09
> >  		     (u32)((u64)adev->dummy_page_addr >> 44));
> >=20
> > -	WREG32_FIELD15(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
> > -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> > +	tmp =3D RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2);
> > +	tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> > +				=20
ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> > +	tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> > +				 ENABLE_RETRY_FAULT_INTERRUPT, !
adev->gmc.noretry);
> > +	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
> >=20
> >  }
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> > b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c index
> > 30b90d35abd0..83c2ddbbd292 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> > @@ -154,6 +154,7 @@ static void gfxhub_v2_1_init_gart_aperture_regs(str=
uct
> > amdgpu_device *adev)>=20
> >  static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device
> >  *adev) {
> > =20
> >  	uint64_t value;
> >=20
> > +	u32 tmp;
> >=20
> >  	if (amdgpu_sriov_vf(adev))
> >  =09
> >  		return;
> >=20
> > @@ -182,8 +183,12 @@ static void
> > gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)>=20
> >  	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
> >  =09
> >  		     (u32)((u64)adev->dummy_page_addr >> 44));
> >=20
> > -	WREG32_FIELD15(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
> > -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> > +	tmp =3D RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2);
> > +	tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> > +				=20
ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> > +	tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> > +				 ENABLE_RETRY_FAULT_INTERRUPT, !
adev->gmc.noretry);
> > +	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
> >=20
> >  }
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c index
> > 9e6a6e13dec0..90bbb2fe4884 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> > @@ -150,6 +150,7 @@ static void gfxhub_v3_0_init_gart_aperture_regs(str=
uct
> > amdgpu_device *adev)>=20
> >  static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device
> >  *adev) {
> > =20
> >  	uint64_t value;
> >=20
> > +	u32 tmp;
> >=20
> >  	/* Program the AGP BAR */
> >  	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
> >=20
> > @@ -176,8 +177,12 @@ static void
> > gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)>=20
> >  	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
> >  =09
> >  		     (u32)((u64)adev->dummy_page_addr >> 44));
> >=20
> > -	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
> > -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> > +	tmp =3D RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
> > +	tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> > +				=20
ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> > +	tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> > +				 ENABLE_RETRY_FAULT_INTERRUPT, !
adev->gmc.noretry);
> > +	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
> >=20
> >  }
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> > b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c index
> > b3b1085c7cd3..1b3c067ab48c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> > @@ -153,6 +153,7 @@ static void
> > gfxhub_v3_0_3_init_gart_aperture_regs(struct amdgpu_device *adev)>=20
> >  static void gfxhub_v3_0_3_init_system_aperture_regs(struct amdgpu_devi=
ce
> >  *adev) {
> > =20
> >  	uint64_t value;
> >=20
> > +	u32 tmp;
> >=20
> >  	if (amdgpu_sriov_vf(adev))
> >  =09
> >  		return;
> >=20
> > @@ -181,8 +182,12 @@ static void
> > gfxhub_v3_0_3_init_system_aperture_regs(struct amdgpu_device *adev)>=20
> >  	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
> >  =09
> >  		     (u32)((u64)adev->dummy_page_addr >> 44));
> >=20
> > -	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
> > -		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> > +	tmp =3D RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
> > +	tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> > +				=20
ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> > +	tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
> > +				 ENABLE_RETRY_FAULT_INTERRUPT, !
adev->gmc.noretry);
> > +	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
> >=20
> >  }




