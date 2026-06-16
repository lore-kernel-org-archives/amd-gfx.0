Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345B8CD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 11:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C88D710EA78;
	Tue, 16 Jun 2026 11:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rz/bc4NW";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 376C510EA40
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 11:54:23 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso39520955e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 04:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781610862; x=1782215662; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z0fUMhFMYh/qjR3B5Y1e0xAda9bjKDBGHYiysGtLTN8=;
 b=rz/bc4NW42nG78y7TB80xOuzvkc9KaQ0gF1203ScQnp6GDHplfC+kbNJ56zsztqcbB
 QhZfB6LmUvK8RAQ4afxdZoMv1LwD3TkOoTx9arNM02tXXgyUfMeDGf0gjTohDF0mQ5Rs
 MtrPXWMhXMA77KE0cluoqjZrxy6Ci3zVhKbkYrzVLRc4SXNZtZdQMnO0oQ/MnRYY5dwG
 V1xVl/UnjYtwe+G7Q4xCTx6ABOVIgQGb+Rsk01l8HhlXbG5cnSWAVQB004CVA4iElQ3G
 Nyrk0LCNExQx5LKHx7AP7HjI+tMowKk2QSlog9T8ydlpQSu/Rou7InNjMlw3Pbjj9p3l
 JjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781610862; x=1782215662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z0fUMhFMYh/qjR3B5Y1e0xAda9bjKDBGHYiysGtLTN8=;
 b=AXu1zm/Ecu83q1J7laiOKbnoexG/4+B6o+xGoZBJVqXUZQJd04abFEwB3FVI+aKNNk
 o5eWBIjZ9pyUSOwfIraELGjPRrl6mauZ0JTK54FjQCEv4tvzCXLiDIuwKKQ/fzOs8iXi
 s6rtpHz3IXgzlcrKxNn/+uX7SKqgwcArgxqoA60X87s8kmT17jJiPpWVYeQMvk1BCDj/
 7CekhbAbOcvbXIo3soPnfpJwuOeTMK0rw38xUF0rqz8+ouT+b+nJzc2NE7vfgxbXNiPa
 v+RehfpXl89D/z+iHFakf5R8lIW6nVTObaohwBFnhPIE4RGZVpJ+75PEBKkqT5Lzf/LI
 3a1g==
X-Gm-Message-State: AOJu0YxBjtgoVP/RMMPDQlQAHnNMVC7yA9bowGKR0/2Cu7FeT2RTctni
 KlL8vqzSPnytURUek8p2PfS5IUzMtpM9pl8ytSDS6MDYl5POdqPl55HZx92+qg==
X-Gm-Gg: Acq92OGgeVNGxfsmZQFjGrxm5juFpQ7hbSl3uv9LKlaTGihxIyHEEQqG0nSWyEreYtt
 COjea1n1m/VwJeOgv16OcdJ+bJUJOTFZPbmbcXUvgBJhOd8MyEHnvdkqG5CoIhvDrEG9b+mjizR
 iagD91E23dNhdIhgmwWVBDR4h1raWm5crW0bmSe673WgN5/YycmwsoRjF2KoRF1+FiKYuY5rc2l
 qTpXh2lFXTE2KOEkHqVioD7ck2dYfmSYNduaNiXfDCzyuS+Wb1R+2DhvkHdtJ9zn+CTcCFybCka
 tEB3O4mGGZp41H+CmR12JtDXmMMpRsp8dYSnD6kxKlkBaR1dbZVy1+i4xRlS59YMxpr00QilrKJ
 bNVssUkH3NemQiz72y9fzGBjI/TRB9dl8ib+EqbcdEf2Lsrqj1iUDKki8fD0KCq2VP0RkfWTx/9
 N23t2qG3y35guhRQLbfC8oTfnoEBBg4KTyVteXsu2nb/DY3Fnb+y9euauFzE5Z37uRhq4GIt+4h
 xwcHpaj
X-Received: by 2002:a7b:c041:0:b0:490:50eb:b777 with SMTP id
 5b1f17b1804b1-492200514f3mr144068825e9.5.1781610861311; 
 Tue, 16 Jun 2026 04:54:21 -0700 (PDT)
Received: from timur-hyperion.localnet (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4601esm61009175e9.1.2026.06.16.04.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 04:54:20 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 5/7] drm/amdgpu/gfxhub: Enable retry fault interrupts when
 needed
Date: Tue, 16 Jun 2026 13:54:20 +0200
Message-ID: <10181145.eNJFYEL58v@timur-hyperion>
In-Reply-To: <c08e20bc-ab15-4de8-8eb4-e01c090868d4@ursulin.net>
References: <20260525114507.24566-1-timur.kristof@gmail.com>
 <20260525114507.24566-6-timur.kristof@gmail.com>
 <c08e20bc-ab15-4de8-8eb4-e01c090868d4@ursulin.net>
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

On Tuesday, June 16, 2026 10:02:44=E2=80=AFAM Central European Summer Time =
Tvrtko=20
Ursulin wrote:
> On 25/05/2026 12:45, Timur Krist=C3=B3f wrote:
> > Enable retry fault interrupts when initializing the GFXHUB
> > system aperture registers according to whether retrying
> > page faults is enabled in amdgpu (ie. amdgpu.noretry=3D0).
> >=20
> > Needs to be done for each GFXHUB version at once,
> > because none of them actually enabled this interrupt.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 9 +++++++--
> >   drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 9 +++++++--
> >   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 9 +++++++--
> >   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 2 ++
> >   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 9 +++++++--
> >   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 9 +++++++--
> >   drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 9 +++++++--
> >   drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 9 +++++++--
> >   8 files changed, 51 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c index
> > 652eea6eae4a..ef20eafd59ae 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> > @@ -155,6 +155,7 @@ static void
> > gfxhub_v11_5_0_init_gart_aperture_regs(struct amdgpu_device *adev)>=20
> >   static void gfxhub_v11_5_0_init_system_aperture_regs(struct
> >   amdgpu_device *adev) {
> >  =20
> >   	uint64_t value;
> >=20
> > +	u32 tmp;
> >=20
> >   	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
> >   	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, adev->gmc.agp_start >>=20
24);
> >=20
> > @@ -180,8 +181,12 @@ static void
> > gfxhub_v11_5_0_init_system_aperture_regs(struct amdgpu_device *adev)>=20
> >   	WREG32_SOC15(GC, 0,=20
regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
> >   =09
> >   		     (u32)((u64)adev->dummy_page_addr >> 44));
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
>=20
> As a side note, I have two patches which shrink these register access
> macros considerably:
>=20
> https://patchwork.freedesktop.org/patch/720726/?series=3D165432&rev=3D1
>=20
> Going back to this patch, a question - how do gfxhub ip versions relate
> to the default set from gc ip versions in amdgpu_gmc_noretry_set()? I am
> wondering on which platforms, if any, do at this point in the series,
> retry fault interrupts get enabled where they previously were not.

As far as I know, currently retry faults are only enabled by default on som=
e=20
datacenter GPUs and not for any consumer GPUs.

This patch just makes sure to actually program the registers to enable retr=
y=20
faults when they need to be enabled (at the moment, this means, when the us=
er=20
has amdgpu.noretry=3D0 on their kernel command line). The series does not c=
hange=20
which generations have it enabled by default.

In order to enable retry faults by default, I would like to make work relia=
bly=20
first. At the moment that blocked by Christian's recent refactor which is=20
currently under review. I will have to rebase those two patches once=20
Christian's work lands. Then we can consider enabling retry faults by defau=
lt=20
on Navi 3 and Navi 4 dGPUs.

Note that APUs and Navi 1-2 dGPUs will still need more work because they do=
n't=20
have the retry CAM so they will need a better way to filter the page fault=
=20
interrupts. However I don't want to start working on that until the current=
=20
three series is reviewed.


Thanks,
Timur


>=20
> >   }
> >  =20
> >   static void gfxhub_v11_5_0_init_tlb_regs(struct amdgpu_device *adev)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c index
> > 6cbf837d50dd..ec3ff4dec674 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> > @@ -158,6 +158,7 @@ static void
> > gfxhub_v12_0_init_gart_aperture_regs(struct amdgpu_device *adev)>=20
> >   static void gfxhub_v12_0_init_system_aperture_regs(struct amdgpu_devi=
ce
> >   *adev) {
> >  =20
> >   	uint64_t value;
> >=20
> > +	u32 tmp;
> >=20
> >   	/* Program the AGP BAR */
> >   	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
> >=20
> > @@ -184,8 +185,12 @@ static void
> > gfxhub_v12_0_init_system_aperture_regs(struct amdgpu_device *adev)>=20
> >   	WREG32_SOC15(GC, 0,=20
regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
> >   =09
> >   		     (u32)((u64)adev->dummy_page_addr >> 44));
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
> >   }
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c index
> > bfe247b1a333..27d7f7cb903f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> > @@ -91,6 +91,7 @@ static void gfxhub_v1_0_init_gart_aperture_regs(struct
> > amdgpu_device *adev)>=20
> >   static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device
> >   *adev) {
> >  =20
> >   	uint64_t value;
> >=20
> > +	u32 tmp;
> >=20
> >   	if (!amdgpu_sriov_vf(adev) || adev->asic_type <=3D CHIP_VEGA10) {
> >   =09
> >   		/* Program the AGP BAR */
> >=20
> > @@ -134,8 +135,12 @@ static void
> > gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)>=20
> >   		WREG32_SOC15(GC, 0,=20
mmVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
> >   	=09
> >   			     (u32)((u64)adev->dummy_page_addr >>=20
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
> >   	}
> >   =09
> >   	/* In the case squeezing vram into GART aperture, we don't use
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> > b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c index
> > fbdf46070b38..ed9a64bc5aaa 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> > @@ -176,6 +176,8 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct
> > amdgpu_device *adev,>=20
> >   			tmp =3D RREG32_SOC15(GC, GET_INST(GC, i),
> >   			regVM_L2_PROTECTION_FAULT_CNTL2);
> >   			tmp =3D REG_SET_FIELD(tmp,=20
VM_L2_PROTECTION_FAULT_CNTL2,
> >   		=09
> >   					   =20
ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
> >=20
> > +			tmp =3D REG_SET_FIELD(tmp,=20
VM_L2_PROTECTION_FAULT_CNTL2,
> > +					   =20
ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
> >=20
> >   			WREG32_SOC15(GC, GET_INST(GC, i),=20
regVM_L2_PROTECTION_FAULT_CNTL2,
> >   			tmp);
> >   	=09
> >   		}
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c index
> > 9ea593e2c719..152b2735d360 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> > @@ -151,6 +151,7 @@ static void gfxhub_v2_0_init_gart_aperture_regs(str=
uct
> > amdgpu_device *adev)>=20
> >   static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device
> >   *adev) {
> >  =20
> >   	uint64_t value;
> >=20
> > +	u32 tmp;
> >=20
> >   	if (!amdgpu_sriov_vf(adev)) {
> >   =09
> >   		/* Program the AGP BAR */
> >=20
> > @@ -178,8 +179,12 @@ static void
> > gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)>=20
> >   	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
> >   =09
> >   		     (u32)((u64)adev->dummy_page_addr >> 44));
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
> >   }
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> > b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c index
> > 30b90d35abd0..83c2ddbbd292 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> > @@ -154,6 +154,7 @@ static void gfxhub_v2_1_init_gart_aperture_regs(str=
uct
> > amdgpu_device *adev)>=20
> >   static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device
> >   *adev) {
> >  =20
> >   	uint64_t value;
> >=20
> > +	u32 tmp;
> >=20
> >   	if (amdgpu_sriov_vf(adev))
> >   =09
> >   		return;
> >=20
> > @@ -182,8 +183,12 @@ static void
> > gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)>=20
> >   	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
> >   =09
> >   		     (u32)((u64)adev->dummy_page_addr >> 44));
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
> >   }
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c index
> > 9e6a6e13dec0..90bbb2fe4884 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> > @@ -150,6 +150,7 @@ static void gfxhub_v3_0_init_gart_aperture_regs(str=
uct
> > amdgpu_device *adev)>=20
> >   static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device
> >   *adev) {
> >  =20
> >   	uint64_t value;
> >=20
> > +	u32 tmp;
> >=20
> >   	/* Program the AGP BAR */
> >   	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
> >=20
> > @@ -176,8 +177,12 @@ static void
> > gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)>=20
> >   	WREG32_SOC15(GC, 0,=20
regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
> >   =09
> >   		     (u32)((u64)adev->dummy_page_addr >> 44));
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
> >   }
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> > b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c index
> > b3b1085c7cd3..1b3c067ab48c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> > @@ -153,6 +153,7 @@ static void
> > gfxhub_v3_0_3_init_gart_aperture_regs(struct amdgpu_device *adev)>=20
> >   static void gfxhub_v3_0_3_init_system_aperture_regs(struct amdgpu_dev=
ice
> >   *adev) {
> >  =20
> >   	uint64_t value;
> >=20
> > +	u32 tmp;
> >=20
> >   	if (amdgpu_sriov_vf(adev))
> >   =09
> >   		return;
> >=20
> > @@ -181,8 +182,12 @@ static void
> > gfxhub_v3_0_3_init_system_aperture_regs(struct amdgpu_device *adev)>=20
> >   	WREG32_SOC15(GC, 0,=20
regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
> >   =09
> >   		     (u32)((u64)adev->dummy_page_addr >> 44));
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
> >   }




