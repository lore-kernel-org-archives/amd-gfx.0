Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30E2C3ABA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 14:05:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 354C910E4A5;
	Tue, 29 Apr 2025 14:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JvxuJyfZ";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD1DF10E4A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 14:05:53 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b143ad615f2so458980a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 07:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745935553; x=1746540353; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOMJzH2CanLqn+f6nS1N08VmQhZoMulbV/w93TSTuvY=;
 b=JvxuJyfZb/mg5u8DtenZ8KWO2iTfMlU5rPqwt54OxfR6IOItNC7U7BbxU0B4FgkGGn
 zspW+YBzevqi336F64hoJeumeQWco5nqoqDETKyKUDiLZE148ggjeRtVwud89WpMA4pi
 2YbO4AZGqhTJmUp0fSaHxU8111DdeNSogSS++r0GiP5HTe1+LZk4VpcMKWOsUudt6OJc
 hiig5hN9T/KqeBa/SFHumPTVJm/JcRpEzONpDCXiBcHKZ6kmRqmLqQaTh2QFLOqr5MXE
 QA/kh/ZGz44R82B9CcatsIUZCXW0L69RroDRp1QY8LULX4An/cgJrdZCRt0nhDL/IhmM
 Ey9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935553; x=1746540353;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zOMJzH2CanLqn+f6nS1N08VmQhZoMulbV/w93TSTuvY=;
 b=TAFkY6q3AwJu6TwE2htmfqgRf5lONTWRpa9HZQIG+CTeHpsQwoV4lkZC1BDTt6F6c6
 XbfX/Z4Za4mim1hkWBvQf12VaRae7/Jrex7agH/rjzi0cR0e0jHiNteFt/2gX4GDnkrQ
 fiSBpRHGf66xMOji+2+TuYNCYUoBTDfS1TfrF7Fd7hq+h/QX8zkduEgQpWAA20wwxoXs
 E0nIS7/q9090fiU2C49sg3gZxBdSxR6VLwf+vs1Fg7jjPyfLVJrV0zFdfWSMecuap5Ea
 u7QWY7NhN+WFp64KqDVbmrJ4hUiD/ff4fRrDDkuckl/Dx44RjSGD65yi402TjRzK+AqV
 h+MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7WeGAeE4+kTEWyUi36h3IdmowDqh7GtRYZFNC3zijltTHjIOrcd+AjGVi8L6Bd3O1kglypu74@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw78QHXeKygjY4OOnCY3YJNlg1JT7Qhj7zLiPiI2B79UFMAJarE
 p7iu3CwgPV5G1Bw36H5EGV2fBLlJhLq1PO/jlkBqewul+IQXwCvXYbWby6vT66K8R7i2iUDaXE/
 VgBmuPKp2ImYcxYailECDFnV6YQ6V6A==
X-Gm-Gg: ASbGncsWYu7IhjJqDsR9yMSUDRhdV9L4VnDNEEWcx+hQYHlYMXgaM8FzoXgLGH+xCoC
 aUNt5BgPurKCMeFzbduWvV9mGA0fa+TLoW2j25TzGlWS0oTy/h+C/ozB4CuDzgkVz2vHUTKdSiP
 wzZRMQFXQBi+RmXuqHKDAtrQ==
X-Google-Smtp-Source: AGHT+IETf1/5BfdrcM3edcj5Mnli036RXRfnkVO26eWtzaxCQ0EKy3M/K3NjYd/yF49CoJOeg8w875tw4984dBCS9XU=
X-Received: by 2002:a17:90b:4a05:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-309f7e9e312mr8805603a91.5.1745935553202; Tue, 29 Apr 2025
 07:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250429102954.3913983-1-ray.huang@amd.com>
 <34919514-46de-4e4d-9eae-e58bb8c7bb94@amd.com>
 <aBDb59NyMq1G0iW3@amd.com>
In-Reply-To: <aBDb59NyMq1G0iW3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Apr 2025 10:05:40 -0400
X-Gm-Features: ATxdqUFx61fInvxkpCOxK8TrmEZqd0sx955NCw6wGWOcVd8jaVUBnXJFLWS_5Dw
Message-ID: <CADnq5_OKugU+ogJ5+1=EyvPNyHyoBs6Ja+bTtTG=6JjnN5jzqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: remove re-route ih in psp v12
To: Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Trigger Huang <Trigger.Huang@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>
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

On Tue, Apr 29, 2025 at 10:02=E2=80=AFAM Huang Rui <ray.huang@amd.com> wrot=
e:
>
> On Tue, Apr 29, 2025 at 03:50:25PM +0200, Christian K=C3=B6nig wrote:
> > On 4/29/25 12:29, Huang Rui wrote:
> > > APU doesn't have second IH ring, so re-routing action here is a no-op=
.
> > > It will take a lot of time to wait timeout from PSP during the
> > > initialization. So remove the function in psp v12.
> >
> >
> > Not 100% sure, but I think this code is also used for non APUs.
> >
> > So we need to keep it around, just don't try to re-route faults to the =
second IH ring on APUs.
>
> Yes, psp v12 is only for APUs like Renoir and related APU kicker and won'=
t
> be applied to dGPU. I think we should make series to modify these series =
to
> update re-routing into dGPUs next step.

These functions have been in this file since it was originally added
specifically for APUs.  It looks like it was just copy and pasted from
another psp version.

Alex


>
> Thanks,
> Ray
>
> >
> > Regards,
> > Christian.
> >
> > >
> > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 34 ------------------------=
--
> > >  1 file changed, 34 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm=
/amd/amdgpu/psp_v12_0.c
> > > index 6331941440d9..ed24f61e1ab8 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> > > @@ -34,9 +34,6 @@
> > >  #include "sdma0/sdma0_4_0_offset.h"
> > >  #include "nbio/nbio_7_4_offset.h"
> > >
> > > -#include "oss/osssys_4_0_offset.h"
> > > -#include "oss/osssys_4_0_sh_mask.h"
> > > -
> > >  MODULE_FIRMWARE("amdgpu/renoir_asd.bin");
> > >  MODULE_FIRMWARE("amdgpu/renoir_ta.bin");
> > >  MODULE_FIRMWARE("amdgpu/green_sardine_asd.bin");
> > > @@ -142,35 +139,6 @@ static int psp_v12_0_bootloader_load_sos(struct =
psp_context *psp)
> > >     return ret;
> > >  }
> > >
> > > -static void psp_v12_0_reroute_ih(struct psp_context *psp)
> > > -{
> > > -   struct amdgpu_device *adev =3D psp->adev;
> > > -   uint32_t tmp;
> > > -
> > > -   /* Change IH ring for VMC */
> > > -   tmp =3D REG_SET_FIELD(0, IH_CLIENT_CFG_DATA, CREDIT_RETURN_ADDR, =
0x1244b);
> > > -   tmp =3D REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, CLIENT_TYPE, 1);
> > > -   tmp =3D REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
> > > -
> > > -   WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_69, 3);
> > > -   WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, tmp);
> > > -   WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GBR_IH_=
SET);
> > > -
> > > -   psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
> > > -                0x80000000, 0x8000FFFF, false);
> > > -
> > > -   /* Change IH ring for UMC */
> > > -   tmp =3D REG_SET_FIELD(0, IH_CLIENT_CFG_DATA, CREDIT_RETURN_ADDR, =
0x1216b);
> > > -   tmp =3D REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
> > > -
> > > -   WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_69, 4);
> > > -   WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, tmp);
> > > -   WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GBR_IH_=
SET);
> > > -
> > > -   psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
> > > -                0x80000000, 0x8000FFFF, false);
> > > -}
> > > -
> > >  static int psp_v12_0_ring_create(struct psp_context *psp,
> > >                             enum psp_ring_type ring_type)
> > >  {
> > > @@ -179,8 +147,6 @@ static int psp_v12_0_ring_create(struct psp_conte=
xt *psp,
> > >     struct psp_ring *ring =3D &psp->km_ring;
> > >     struct amdgpu_device *adev =3D psp->adev;
> > >
> > > -   psp_v12_0_reroute_ih(psp);
> > > -
> > >     if (amdgpu_sriov_vf(psp->adev)) {
> > >             /* Write low address of the ring to C2PMSG_102 */
> > >             psp_ring_reg =3D lower_32_bits(ring->ring_mem_mc_addr);
> >
