Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DCCCCF9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 22:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5318510E86A;
	Wed, 29 Oct 2025 22:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LNpavRQi";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D0C310E869
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 22:48:31 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b704db3686cso90614166b.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 15:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761778109; x=1762382909; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7K3IIJkFKmnhQ1NcDF7dycm4shHeyKpJFJO1rg5och8=;
 b=LNpavRQiRiXMy/IPArtlPDKWQiWdEDmc+b0v+aQThxfcsFfHNDNPaunQym3nnadA1x
 0ACJiP4Hm5tco4HCph3le3oUz3CFEt6aUpR6lvPkYAbfPPRIc4LxpGskde3y9BE0lSgq
 Qg5HhnjpOekdj06vHj3nN5qDZmLrpHluMW+DX5340MtXSipaP8MIaaH61ro8HNNJXXEG
 EjZOckips01+R96wtVmAu1NZGwmp1JH0Dq0l19F/TLRc0LgoTSI0W/Qa8GRPUo9Gm30u
 ihHTrCYnCWyOMfdl8HOlaCqwgUAVG0qaritV2ts4L/7Bug3whnFEyRzQd7XB0NAcl2Zf
 Ruhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761778109; x=1762382909;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7K3IIJkFKmnhQ1NcDF7dycm4shHeyKpJFJO1rg5och8=;
 b=Hz6whuG4tqJsH7fDVAZARW2V/LplE0KC7JI5JdcnH3aK4PQtVzLtmpjD3G5kW2DDf+
 WfOMi34mzvShB8BPCttLIFjRDa71dVeBudVUw205xIAwOO1i7OM4N8qYPL/PM4VTaobc
 n4kZLu6xoCmhSXX46YEm00hXkyWzFhf99tH+oGByOi9jY1wSGHnbO8ZgBxSj5lqvWvF5
 6kvlroah+yXTALATJ0MfZaB1cmNrGdr3i2AnGnp7QUQmpu5NB0P4ra954OdaDCvBME9W
 HsOA/WgFa31f0MOQ8X3mzeeic2sYRvKn4nqeQYoltKzk/fMJyDfzhmezllPqMeGDKwwe
 8nFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYX+fWW5af1Qr0rDqXznZvLl8o29dJ8WqaXB21gbSmh9saI1DCKvr6XoHhhcq0aq6UTi3U4Hqh@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZ55fDBgIxeZfimZ8fv2NWyxGSUzB5f9zp4Rioi06bTUGW/goe
 IpTM2nvZjrfgWSPoxbwjsG6FeFi1LGA1oQUxFiOVEh4PIDUYkp9DF+CeMfyqgMp9
X-Gm-Gg: ASbGnctJ47FAcINkk4tj2r+Mh9YGdJzKeqX7w4TARDwuu2I4RMmVE6IVsFNE/3Q1y4e
 zTaKdRXbbKewQ3PWPOUlIdPJcSPJNJ4JM7rwugsVpe0Fg7Mz2r0Qgti6M2VxCbrPXLL5ppImUEW
 4QHr41EmRbvP4xtr9gulyuSuuv+mtkPuBgdLhq9qbHOnYLr6ObNS022sndAtHTnc17hDPhQnUeb
 w7oUC7F2JKIJt4lsFy5rmalplPfLxqcjylEXS1rkGtfZTKdfNx9QTbtMn0hDeotywHolgfKw7k6
 keVWDz9aMsbbKrzBm4TT06FTYVQ79kzv0jckhp/jnuXk4p8d9JJkX41LNoj0Mu6+0jtouKdEL7A
 dlAwkptsOXArvRa44KZVZsseb8QXbr6QVvPYJidNTBlrFvabgaZvFi3Z3X3qkfROgIpU7s1R/dJ
 4bKdwXCmg4hUJslBXeqEKKh/I4Kh1XJ7Y7kWG7NROAFgQEeSZ9Z+Vc+ALl+R53Wr4Dtw==
X-Google-Smtp-Source: AGHT+IGOfypYfbBq7WPWeYonU4kW6HZ9ZuSJw18G1GS4vkdEYgSB4zDHTdQnZTUzrT6yj+EG+eWK7Q==
X-Received: by 2002:a17:907:746:b0:b3d:f869:747 with SMTP id
 a640c23a62f3a-b703d301a96mr462696266b.21.1761778109199; 
 Wed, 29 Oct 2025 15:48:29 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24cb:f700:23e8:3719:bda9:8268?
 ([2001:4c4e:24cb:f700:23e8:3719:bda9:8268])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85338663sm1558432866b.17.2025.10.29.15.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 15:48:28 -0700 (PDT)
Message-ID: <18151c2a64164be39f257a407752a5f5dab1eb82.camel@gmail.com>
Subject: Re: [PATCH 10/14] drm/amdgpu/vce1: Implement VCE1 IP block
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Alexandre Demers <alexandre.f.demers@gmail.com>, Rodrigo Siqueira
 <siqueira@igalia.com>
Date: Wed, 29 Oct 2025 23:48:25 +0100
In-Reply-To: <9da7f3f0-58d8-4a7d-bbf9-1223e458e710@amd.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-11-timur.kristof@gmail.com>
 <9da7f3f0-58d8-4a7d-bbf9-1223e458e710@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
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

On Wed, 2025-10-29 at 12:38 +0100, Christian K=C3=B6nig wrote:
> On 10/28/25 23:06, Timur Krist=C3=B3f wrote:
> > Implement the necessary functionality to support the VCE1.
> > This implementation is based on:
> >=20
> > - VCE2 code from amdgpu
> > - VCE1 code from radeon (the old driver)
> > - Some trial and error
> >=20
> > A subsequent commit will ensure correct mapping for
> > the VCPU BO, which will make this actually work.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> > Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> > Co-developed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/Makefile=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 2 +-
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/gpu/drm/amd/amdgpu/vce_v1_0.c=C2=A0=C2=A0 | 805
> > ++++++++++++++++++++++++
> > =C2=A0drivers/gpu/drm/amd/amdgpu/vce_v1_0.h=C2=A0=C2=A0 |=C2=A0 32 +
> > =C2=A04 files changed, 839 insertions(+), 1 deletion(-)
> > =C2=A0create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> > =C2=A0create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.h
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> > b/drivers/gpu/drm/amd/amdgpu/Makefile
> > index ebe08947c5a3..c88760fb52ea 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> > +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> > @@ -78,7 +78,7 @@ amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+=3D cik.o cik_ih.o
> > \
> > =C2=A0	dce_v8_0.o gfx_v7_0.o cik_sdma.o uvd_v4_2.o vce_v2_0.o
> > =C2=A0
> > =C2=A0amdgpu-$(CONFIG_DRM_AMDGPU_SI)+=3D si.o gmc_v6_0.o gfx_v6_0.o
> > si_ih.o si_dma.o dce_v6_0.o \
> > -	uvd_v3_1.o
> > +	uvd_v3_1.o vce_v1_0.o
> > =C2=A0
> > =C2=A0amdgpu-y +=3D \
> > =C2=A0	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o
> > nbio_v7_0.o vega10_reg_init.o \
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> > index 22acd7b35945..050783802623 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> > @@ -51,6 +51,7 @@ struct amdgpu_vce {
> > =C2=A0	struct drm_sched_entity	entity;
> > =C2=A0	uint32_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 srbm_soft_reset;
> > =C2=A0	unsigned		num_rings;
> > +	uint32_t		keyselect;
> > =C2=A0};
> > =C2=A0
> > =C2=A0int amdgpu_vce_early_init(struct amdgpu_device *adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> > b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> > new file mode 100644
> > index 000000000000..e62fd8ed1992
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> > @@ -0,0 +1,805 @@
> > +// SPDX-License-Identifier: MIT
> > +/*
> > + * Copyright 2013 Advanced Micro Devices, Inc.
> > + * Copyright 2025 Valve Corporation
> > + * Copyright 2025 Alexandre Demers
> > + * All Rights Reserved.
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> > obtaining a
> > + * copy of this software and associated documentation files (the
> > + * "Software"), to deal in the Software without restriction,
> > including
> > + * without limitation the rights to use, copy, modify, merge,
> > publish,
> > + * distribute, sub license, and/or sell copies of the Software,
> > and to
> > + * permit persons to whom the Software is furnished to do so,
> > subject to
> > + * the following conditions:
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO
> > EVENT SHALL
> > + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE
> > FOR ANY CLAIM,
> > + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
> > TORT OR
> > + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
> > SOFTWARE OR THE
> > + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> > + *
> > + * The above copyright notice and this permission notice
> > (including the
> > + * next paragraph) shall be included in all copies or substantial
> > portions
> > + * of the Software.
> > + *
> > + * Authors: Christian K=C3=B6nig <christian.koenig@amd.com>
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Timur Krist=
=C3=B3f <timur.kristof@gmail.com>
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Alexandre Dem=
ers <alexandre.f.demers@gmail.com>
> > + */
> > +
> > +#include <linux/firmware.h>
> > +
> > +#include "amdgpu.h"
> > +#include "amdgpu_vce.h"
> > +#include "sid.h"
> > +#include "vce_v1_0.h"
> > +#include "vce/vce_1_0_d.h"
> > +#include "vce/vce_1_0_sh_mask.h"
> > +#include "oss/oss_1_0_d.h"
> > +#include "oss/oss_1_0_sh_mask.h"
> > +
> > +#define VCE_V1_0_FW_SIZE	(256 * 1024)
> > +#define VCE_V1_0_STACK_SIZE	(64 * 1024)
> > +#define VCE_V1_0_DATA_SIZE	(7808 * (AMDGPU_MAX_VCE_HANDLES +
> > 1))
> > +#define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK	0x02
> > +
> > +static void vce_v1_0_set_ring_funcs(struct amdgpu_device *adev);
> > +static void vce_v1_0_set_irq_funcs(struct amdgpu_device *adev);
> > +
> > +struct vce_v1_0_fw_signature {
> > +	int32_t offset;
> > +	uint32_t length;
> > +	int32_t number;
> > +	struct {
> > +		uint32_t chip_id;
> > +		uint32_t keyselect;
> > +		uint32_t nonce[4];
> > +		uint32_t sigval[4];
> > +	} val[8];
> > +};
> > +
> > +/**
> > + * vce_v1_0_ring_get_rptr - get read pointer
> > + *
> > + * @ring: amdgpu_ring pointer
> > + *
> > + * Returns the current hardware read pointer
> > + */
> > +static uint64_t vce_v1_0_ring_get_rptr(struct amdgpu_ring *ring)
> > +{
> > +	struct amdgpu_device *adev =3D ring->adev;
> > +
> > +	if (ring->me =3D=3D 0)
> > +		return RREG32(mmVCE_RB_RPTR);
> > +	else
> > +		return RREG32(mmVCE_RB_RPTR2);
> > +}
> > +
> > +/**
> > + * vce_v1_0_ring_get_wptr - get write pointer
> > + *
> > + * @ring: amdgpu_ring pointer
> > + *
> > + * Returns the current hardware write pointer
> > + */
> > +static uint64_t vce_v1_0_ring_get_wptr(struct amdgpu_ring *ring)
> > +{
> > +	struct amdgpu_device *adev =3D ring->adev;
> > +
> > +	if (ring->me =3D=3D 0)
> > +		return RREG32(mmVCE_RB_WPTR);
> > +	else
> > +		return RREG32(mmVCE_RB_WPTR2);
> > +}
> > +
> > +/**
> > + * vce_v1_0_ring_set_wptr - set write pointer
> > + *
> > + * @ring: amdgpu_ring pointer
> > + *
> > + * Commits the write pointer to the hardware
> > + */
> > +static void vce_v1_0_ring_set_wptr(struct amdgpu_ring *ring)
> > +{
> > +	struct amdgpu_device *adev =3D ring->adev;
> > +
> > +	if (ring->me =3D=3D 0)
> > +		WREG32(mmVCE_RB_WPTR, lower_32_bits(ring->wptr));
> > +	else
> > +		WREG32(mmVCE_RB_WPTR2, lower_32_bits(ring->wptr));
> > +}
> > +
> > +static int vce_v1_0_lmi_clean(struct amdgpu_device *adev)
> > +{
> > +	int i, j;
> > +
> > +	for (i =3D 0; i < 10; ++i) {
> > +		for (j =3D 0; j < 100; ++j) {
> > +			if (RREG32(mmVCE_LMI_STATUS) & 0x337f)
> > +				return 0;
> > +
> > +			mdelay(10);
> > +		}
> > +	}
> > +
> > +	return -ETIMEDOUT;
> > +}
> > +
> > +static int vce_v1_0_firmware_loaded(struct amdgpu_device *adev)
> > +{
> > +	int i, j;
> > +
> > +	for (i =3D 0; i < 10; ++i) {
> > +		for (j =3D 0; j < 100; ++j) {
> > +			if (RREG32(mmVCE_STATUS) &
> > VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK)
> > +				return 0;
> > +			mdelay(10);
> > +		}
> > +
> > +		dev_err(adev->dev, "VCE not responding, trying to
> > reset the ECPU\n");
> > +
> > +		WREG32_P(mmVCE_SOFT_RESET,
> > +			VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,
> > +			~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> > +		mdelay(10);
> > +		WREG32_P(mmVCE_SOFT_RESET, 0,
> > +			~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> > +		mdelay(10);
> > +	}
> > +
> > +	return -ETIMEDOUT;
> > +}
> > +
> > +static void vce_v1_0_init_cg(struct amdgpu_device *adev)
> > +{
> > +	u32 tmp;
> > +
> > +	tmp =3D RREG32(mmVCE_CLOCK_GATING_A);
> > +	tmp |=3D VCE_CLOCK_GATING_A__CGC_DYN_CLOCK_MODE_MASK;
> > +	WREG32(mmVCE_CLOCK_GATING_A, tmp);
> > +
> > +	tmp =3D RREG32(mmVCE_CLOCK_GATING_B);
> > +	tmp |=3D 0x1e;
> > +	tmp &=3D ~0xe100e1;
> > +	WREG32(mmVCE_CLOCK_GATING_B, tmp);
> > +
> > +	tmp =3D RREG32(mmVCE_UENC_CLOCK_GATING);
> > +	tmp &=3D ~0xff9ff000;
> > +	WREG32(mmVCE_UENC_CLOCK_GATING, tmp);
> > +
> > +	tmp =3D RREG32(mmVCE_UENC_REG_CLOCK_GATING);
> > +	tmp &=3D ~0x3ff;
> > +	WREG32(mmVCE_UENC_REG_CLOCK_GATING, tmp);
> > +}
> > +
> > +/**
> > + * vce_v1_0_load_fw_signature - load firmware signature into VCPU
> > BO
> > + *
> > + * @adev: amdgpu_device pointer
> > + *
> > + * The VCE1 firmware validation mechanism needs a firmware
> > signature.
> > + * This function finds the signature appropriate for the current
> > + * ASIC and writes that into the VCPU BO.
> > + */
> > +static int vce_v1_0_load_fw_signature(struct amdgpu_device *adev)
> > +{
> > +	const struct common_firmware_header *hdr;
> > +	struct vce_v1_0_fw_signature *sign;
> > +	unsigned int ucode_offset;
> > +	uint32_t chip_id;
> > +	u32 *cpu_addr;
> > +	int i, r;
> > +
> > +	hdr =3D (const struct common_firmware_header *)adev->vce.fw-
> > >data;
> > +	ucode_offset =3D le32_to_cpu(hdr->ucode_array_offset_bytes);
> > +
> > +	sign =3D (void *)adev->vce.fw->data + ucode_offset;
> > +
> > +	switch (adev->asic_type) {
> > +	case CHIP_TAHITI:
> > +		chip_id =3D 0x01000014;
> > +		break;
> > +	case CHIP_VERDE:
> > +		chip_id =3D 0x01000015;
> > +		break;
> > +	case CHIP_PITCAIRN:
> > +		chip_id =3D 0x01000016;
> > +		break;
> > +	default:
> > +		dev_err(adev->dev, "asic_type %#010x was not
> > found!", adev->asic_type);
> > +		return -EINVAL;
> > +	}
> > +
>=20
> > +	ASSERT(adev->vce.vcpu_bo);
>=20
> Please drop that.

Sure, but can you say why?

>=20
> > +
> > +	r =3D amdgpu_bo_reserve(adev->vce.vcpu_bo, false);
> > +	if (r) {
> > +		dev_err(adev->dev, "%s (%d) failed to reserve VCE
> > bo\n", __func__, r);
> > +		return r;
> > +	}
> > +
> > +	r =3D amdgpu_bo_kmap(adev->vce.vcpu_bo, (void **)&cpu_addr);
> > +	if (r) {
> > +		amdgpu_bo_unreserve(adev->vce.vcpu_bo);
> > +		dev_err(adev->dev, "%s (%d) VCE map failed\n",
> > __func__, r);
> > +		return r;
> > +	}
>=20
> That part is actually pretty pointless the cpu addr is already
> available as adev->vce.cpu_addr.

I don't think so. amdgpu_vce_resume actually unmaps and unreserves the
VCE BO, so I think we need to map and reserve it again if we want to
access it again. Am I misunderstanding something?

>=20
> > +
> > +	for (i =3D 0; i < le32_to_cpu(sign->number); ++i) {
> > +		if (le32_to_cpu(sign->val[i].chip_id) =3D=3D chip_id)
> > +			break;
> > +	}
> > +
> > +	if (i =3D=3D le32_to_cpu(sign->number)) {
> > +		dev_err(adev->dev, "%s chip_id %#010x was not
> > found for %s in VCE firmware",
> > +			__func__, chip_id, amdgpu_asic_name[adev-
> > >asic_type]);
>=20
> Drop the __func__ here. It should be obvious where we are fro the
> message.

Sure.

>=20
> > +		return -EINVAL;
> > +	}
> > +
> > +	cpu_addr +=3D (256 - 64) / 4;
> > +	cpu_addr[0] =3D sign->val[i].nonce[0];
> > +	cpu_addr[1] =3D sign->val[i].nonce[1];
> > +	cpu_addr[2] =3D sign->val[i].nonce[2];
> > +	cpu_addr[3] =3D sign->val[i].nonce[3];
> > +	cpu_addr[4] =3D cpu_to_le32(le32_to_cpu(sign->length) + 64);
> > +
> > +	memset(&cpu_addr[5], 0, 44);
> > +	memcpy(&cpu_addr[16], &sign[1], hdr->ucode_size_bytes -
> > sizeof(*sign));
>=20
> That should probably be memcpy_io() and the direct writes to cpu_addr
> modified as well.

Sure, I can do that but can you explain why?

>=20
> > +
> > +	cpu_addr +=3D (le32_to_cpu(sign->length) + 64) / 4;
> > +	cpu_addr[0] =3D sign->val[i].sigval[0];
> > +	cpu_addr[1] =3D sign->val[i].sigval[1];
> > +	cpu_addr[2] =3D sign->val[i].sigval[2];
> > +	cpu_addr[3] =3D sign->val[i].sigval[3];
> > +
> > +	adev->vce.keyselect =3D le32_to_cpu(sign->val[i].keyselect);
> > +
>=20
>=20
> > +	amdgpu_bo_kunmap(adev->vce.vcpu_bo);
> > +	amdgpu_bo_unreserve(adev->vce.vcpu_bo);
>=20
> That can be dropped as well.
>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static int vce_v1_0_wait_for_fw_validation(struct amdgpu_device
> > *adev)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < 10; ++i) {
> > +		mdelay(10);
> > +		if (RREG32(mmVCE_FW_REG_STATUS) &
> > VCE_FW_REG_STATUS__DONE_MASK)
> > +			break;
> > +	}
> > +
> > +	if (!(RREG32(mmVCE_FW_REG_STATUS) &
> > VCE_FW_REG_STATUS__DONE_MASK)) {
> > +		dev_err(adev->dev, "%s VCE validation timeout\n",
> > __func__);
> > +		return -ETIMEDOUT;
> > +	}
> > +
> > +	if (!(RREG32(mmVCE_FW_REG_STATUS) &
> > VCE_FW_REG_STATUS__PASS_MASK)) {
> > +		dev_err(adev->dev, "%s VCE firmware validation
> > failed\n", __func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i =3D 0; i < 10; ++i) {
> > +		mdelay(10);
> > +		if (!(RREG32(mmVCE_FW_REG_STATUS) &
> > VCE_FW_REG_STATUS__BUSY_MASK))
> > +			break;
> > +	}
> > +
> > +	if (RREG32(mmVCE_FW_REG_STATUS) &
> > VCE_FW_REG_STATUS__BUSY_MASK) {
> > +		dev_err(adev->dev, "%s VCE firmware busy
> > timeout\n", __func__);
>=20
> Here as well, please drop the __func__ arguments.
>=20
> > +		return -ETIMEDOUT;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int vce_v1_0_mc_resume(struct amdgpu_device *adev)
> > +{
> > +	uint32_t offset;
> > +	uint32_t size;
> > +
> > +	/* When the keyselect is already set, don't perturb VCE
> > FW.
> > +	 * Validation seems to always fail the second time.
> > +	 */
>=20
> Coding style for multi line /* */ comments! checkpatch.pl should
> point out when that is wrong.

Please note that I check every patch with the check patch script before
I send them to the mailing list, and it didn't raise any issues with
this comment.

That being said, sure I can change the comment style to whatever you
prefer.

>=20
> > +	if (RREG32(mmVCE_LMI_FW_START_KEYSEL)) {
> > +		dev_dbg(adev->dev, "%s keyselect already set: 0x%x
> > (on CPU: 0x%x)\n",
> > +			__func__,
> > RREG32(mmVCE_LMI_FW_START_KEYSEL), adev->vce.keyselect);
> > +
> > +		WREG32_P(mmVCE_LMI_CTRL2, 0x0, ~0x100);
> > +		return 0;
> > +	}
> > +
> > +	WREG32_P(mmVCE_CLOCK_GATING_A, 0, ~(1 << 16));
> > +	WREG32_P(mmVCE_UENC_CLOCK_GATING, 0x1FF000, ~0xFF9FF000);
> > +	WREG32_P(mmVCE_UENC_REG_CLOCK_GATING, 0x3F, ~0x3F);
> > +	WREG32(mmVCE_CLOCK_GATING_B, 0);
> > +
> > +	WREG32_P(mmVCE_LMI_FW_PERIODIC_CTRL, 0x4, ~0x4);
> > +
> > +	WREG32(mmVCE_LMI_CTRL, 0x00398000);
> > +
> > +	WREG32_P(mmVCE_LMI_CACHE_CTRL, 0x0, ~0x1);
> > +	WREG32(mmVCE_LMI_SWAP_CNTL, 0);
> > +	WREG32(mmVCE_LMI_SWAP_CNTL1, 0);
> > +	WREG32(mmVCE_LMI_VM_CTRL, 0);
> > +
> > +	WREG32(mmVCE_VCPU_SCRATCH7, AMDGPU_MAX_VCE_HANDLES);
> > +
> > +	offset =3D=C2=A0 adev->vce.gpu_addr + AMDGPU_VCE_FIRMWARE_OFFSET;
> > +	size =3D VCE_V1_0_FW_SIZE;
> > +	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x7fffffff);
> > +	WREG32(mmVCE_VCPU_CACHE_SIZE0, size);
> > +
> > +	offset +=3D size;
> > +	size =3D VCE_V1_0_STACK_SIZE;
> > +	WREG32(mmVCE_VCPU_CACHE_OFFSET1, offset & 0x7fffffff);
> > +	WREG32(mmVCE_VCPU_CACHE_SIZE1, size);
> > +
> > +	offset +=3D size;
> > +	size =3D VCE_V1_0_DATA_SIZE;
> > +	WREG32(mmVCE_VCPU_CACHE_OFFSET2, offset & 0x7fffffff);
> > +	WREG32(mmVCE_VCPU_CACHE_SIZE2, size);
> > +
> > +	WREG32_P(mmVCE_LMI_CTRL2, 0x0, ~0x100);
> > +
> > +	dev_dbg(adev->dev, "VCE keyselect: %d", adev-
> > >vce.keyselect);
> > +	WREG32(mmVCE_LMI_FW_START_KEYSEL, adev->vce.keyselect);
> > +
> > +	return vce_v1_0_wait_for_fw_validation(adev);
>=20
> Maybe inline wait_for_fw_validation here, it doesn't make much sense
> to write START_KEYSEL outside and then have that in a separate
> function.

OK.

>=20
>=20
> > +}
> > +
> > +/**
> > + * vce_v1_0_is_idle() - Check idle status of VCE1 IP block
> > + *
> > + * @ip_block: amdgpu_ip_block pointer
> > + *
> > + * Check whether VCE is busy according to VCE_STATUS.
> > + * Also check whether the SRBM thinks VCE is busy, although
> > + * SRBM_STATUS.VCE_BUSY seems to be bogus because it
> > + * appears to mirror the VCE_STATUS.VCPU_REPORT_FW_LOADED bit.
> > + */
> > +static bool vce_v1_0_is_idle(struct amdgpu_ip_block *ip_block)
> > +{
> > +	struct amdgpu_device *adev =3D ip_block->adev;
> > +	bool busy =3D
> > +		(RREG32(mmVCE_STATUS) & (VCE_STATUS__JOB_BUSY_MASK
> > | VCE_STATUS__UENC_BUSY_MASK)) ||
> > +		(RREG32(mmSRBM_STATUS2) &
> > SRBM_STATUS2__VCE_BUSY_MASK);
> > +
> > +	return !busy;
> > +}
> > +
> > +static int vce_v1_0_wait_for_idle(struct amdgpu_ip_block
> > *ip_block)
> > +{
> > +	struct amdgpu_device *adev =3D ip_block->adev;
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < adev->usec_timeout; i++) {
> > +		udelay(1);
> > +		if (vce_v1_0_is_idle(ip_block))
> > +			return 0;
> > +	}
> > +	return -ETIMEDOUT;
> > +}
> > +
> > +/**
> > + * vce_v1_0_start - start VCE block
> > + *
> > + * @adev: amdgpu_device pointer
> > + *
> > + * Setup and start the VCE block
> > + */
> > +static int vce_v1_0_start(struct amdgpu_device *adev)
> > +{
> > +	struct amdgpu_ring *ring;
> > +	int r;
> > +
> > +	WREG32_P(mmVCE_STATUS, 1, ~1);
> > +
> > +	r =3D vce_v1_0_mc_resume(adev);
> > +	if (r)
> > +		return r;
> > +
> > +	ring =3D &adev->vce.ring[0];
> > +	WREG32(mmVCE_RB_RPTR, lower_32_bits(ring->wptr));
> > +	WREG32(mmVCE_RB_WPTR, lower_32_bits(ring->wptr));
> > +	WREG32(mmVCE_RB_BASE_LO, lower_32_bits(ring->gpu_addr));
> > +	WREG32(mmVCE_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> > +	WREG32(mmVCE_RB_SIZE, ring->ring_size / 4);
> > +
> > +	ring =3D &adev->vce.ring[1];
> > +	WREG32(mmVCE_RB_RPTR2, lower_32_bits(ring->wptr));
> > +	WREG32(mmVCE_RB_WPTR2, lower_32_bits(ring->wptr));
> > +	WREG32(mmVCE_RB_BASE_LO2, lower_32_bits(ring->gpu_addr));
> > +	WREG32(mmVCE_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
> > +	WREG32(mmVCE_RB_SIZE2, ring->ring_size / 4);
> > +
> > +	WREG32_P(mmVCE_VCPU_CNTL, VCE_VCPU_CNTL__CLK_EN_MASK,
> > +		 ~VCE_VCPU_CNTL__CLK_EN_MASK);
> > +
> > +	WREG32_P(mmVCE_SOFT_RESET,
> > +		VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
> > +		VCE_SOFT_RESET__FME_SOFT_RESET_MASK,
> > +		~(VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
> > +		=C2=A0 VCE_SOFT_RESET__FME_SOFT_RESET_MASK));
> > +
> > +	mdelay(100);
> > +
> > +	WREG32_P(mmVCE_SOFT_RESET, 0,
> > +		~(VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
> > +		=C2=A0 VCE_SOFT_RESET__FME_SOFT_RESET_MASK));
> > +
> > +	r =3D vce_v1_0_firmware_loaded(adev);
> > +
> > +	/* Clear VCE_STATUS, otherwise SRBM thinks VCE1 is busy.
> > */
> > +	WREG32(mmVCE_STATUS, 0);
> > +
> > +	if (r) {
> > +		dev_err(adev->dev, "VCE not responding, giving
> > up!!!\n");
> > +		return r;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int vce_v1_0_stop(struct amdgpu_device *adev)
> > +{
> > +	struct amdgpu_ip_block *ip_block;
> > +	int status;
> > +	int i;
> > +
> > +	ip_block =3D amdgpu_device_ip_get_ip_block(adev,
> > AMD_IP_BLOCK_TYPE_VCE);
> > +	if (!ip_block)
> > +		return -EINVAL;
> > +
> > +	if (vce_v1_0_lmi_clean(adev))
> > +		dev_warn(adev->dev, "%s VCE is not idle\n",
> > __func__);
> > +
> > +	if (vce_v1_0_wait_for_idle(ip_block))
> > +		dev_warn(adev->dev, "VCE is busy: VCE_STATUS=3D0x%x,
> > SRBM_STATUS2=3D0x%x\n",
> > +			RREG32(mmVCE_STATUS),
> > RREG32(mmSRBM_STATUS2));
> > +
> > +	/* Stall UMC and register bus before resetting VCPU */
> > +	WREG32_P(mmVCE_LMI_CTRL2, 1 << 8, ~(1 << 8));
> > +
> > +	for (i =3D 0; i < 100; ++i) {
> > +		status =3D RREG32(mmVCE_LMI_STATUS);
> > +		if (status & 0x240)
> > +			break;
> > +		mdelay(1);
> > +	}
> > +
> > +	WREG32_P(mmVCE_VCPU_CNTL, 0, ~VCE_VCPU_CNTL__CLK_EN_MASK);
> > +
> > +	WREG32_P(mmVCE_SOFT_RESET,
> > +		VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
> > +		VCE_SOFT_RESET__FME_SOFT_RESET_MASK,
> > +		~(VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
> > +		=C2=A0 VCE_SOFT_RESET__FME_SOFT_RESET_MASK));
> > +
> > +	WREG32(mmVCE_STATUS, 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static void vce_v1_0_enable_mgcg(struct amdgpu_device *adev, bool
> > enable)
> > +{
> > +	u32 tmp;
> > +
> > +	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_VCE_MGCG))
> > {
> > +		tmp =3D RREG32(mmVCE_CLOCK_GATING_A);
> > +		tmp |=3D
> > VCE_CLOCK_GATING_A__CGC_DYN_CLOCK_MODE_MASK;
> > +		WREG32(mmVCE_CLOCK_GATING_A, tmp);
> > +
> > +		tmp =3D RREG32(mmVCE_UENC_CLOCK_GATING);
> > +		tmp &=3D ~0x1ff000;
> > +		tmp |=3D 0xff800000;
> > +		WREG32(mmVCE_UENC_CLOCK_GATING, tmp);
> > +
> > +		tmp =3D RREG32(mmVCE_UENC_REG_CLOCK_GATING);
> > +		tmp &=3D ~0x3ff;
> > +		WREG32(mmVCE_UENC_REG_CLOCK_GATING, tmp);
> > +	} else {
> > +		tmp =3D RREG32(mmVCE_CLOCK_GATING_A);
> > +		tmp &=3D
> > ~VCE_CLOCK_GATING_A__CGC_DYN_CLOCK_MODE_MASK;
> > +		WREG32(mmVCE_CLOCK_GATING_A, tmp);
> > +
> > +		tmp =3D RREG32(mmVCE_UENC_CLOCK_GATING);
> > +		tmp |=3D 0x1ff000;
> > +		tmp &=3D ~0xff800000;
> > +		WREG32(mmVCE_UENC_CLOCK_GATING, tmp);
> > +
> > +		tmp =3D RREG32(mmVCE_UENC_REG_CLOCK_GATING);
> > +		tmp |=3D 0x3ff;
> > +		WREG32(mmVCE_UENC_REG_CLOCK_GATING, tmp);
> > +	}
> > +}
> > +
> > +static int vce_v1_0_early_init(struct amdgpu_ip_block *ip_block)
> > +{
> > +	struct amdgpu_device *adev =3D ip_block->adev;
> > +	int r;
> > +
> > +	r =3D amdgpu_vce_early_init(adev);
> > +	if (r)
> > +		return r;
> > +
> > +	adev->vce.num_rings =3D 2;
> > +
> > +	vce_v1_0_set_ring_funcs(adev);
> > +	vce_v1_0_set_irq_funcs(adev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int vce_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
> > +{
> > +	struct amdgpu_device *adev =3D ip_block->adev;
> > +	struct amdgpu_ring *ring;
> > +	int r, i;
> > +
> > +	r =3D amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY,
> > 167, &adev->vce.irq);
> > +	if (r)
> > +		return r;
> > +
> > +	r =3D amdgpu_vce_sw_init(adev, VCE_V1_0_FW_SIZE +
> > +		VCE_V1_0_STACK_SIZE + VCE_V1_0_DATA_SIZE);
> > +	if (r)
> > +		return r;
> > +
> > +	r =3D amdgpu_vce_resume(adev);
> > +	if (r)
> > +		return r;
> > +	r =3D vce_v1_0_load_fw_signature(adev);
> > +	if (r)
> > +		return r;
> > +
> > +	for (i =3D 0; i < adev->vce.num_rings; i++) {
> > +		enum amdgpu_ring_priority_level hw_prio =3D
> > amdgpu_vce_get_ring_prio(i);
> > +
> > +		ring =3D &adev->vce.ring[i];
> > +		sprintf(ring->name, "vce%d", i);
> > +		r =3D amdgpu_ring_init(adev, ring, 512, &adev-
> > >vce.irq, 0,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 hw_prio, NULL);
> > +		if (r)
> > +			return r;
> > +	}
> > +
> > +	return r;
> > +}
> > +
> > +static int vce_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
> > +{
> > +	struct amdgpu_device *adev =3D ip_block->adev;
> > +	int r;
> > +
> > +	r =3D amdgpu_vce_suspend(adev);
> > +	if (r)
> > +		return r;
> > +
> > +	return amdgpu_vce_sw_fini(adev);
> > +}
> > +
> > +/**
> > + * vce_v1_0_hw_init - start and test VCE block
> > + *
> > + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
> > + *
> > + * Initialize the hardware, boot up the VCPU and do some testing
> > + */
> > +static int vce_v1_0_hw_init(struct amdgpu_ip_block *ip_block)
> > +{
> > +	struct amdgpu_device *adev =3D ip_block->adev;
> > +	int i, r;
> > +
> > +	if (adev->pm.dpm_enabled)
> > +		amdgpu_dpm_enable_vce(adev, true);
> > +	else
> > +		amdgpu_asic_set_vce_clocks(adev, 10000, 10000);
> > +
> > +	for (i =3D 0; i < adev->vce.num_rings; i++) {
> > +		r =3D amdgpu_ring_test_helper(&adev->vce.ring[i]);
> > +		if (r)
> > +			return r;
> > +	}
> > +
> > +	dev_info(adev->dev, "VCE initialized successfully.\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int vce_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
> > +{
> > +	int r;
> > +
> > +	r =3D vce_v1_0_stop(ip_block->adev);
> > +	if (r)
> > +		return r;
> > +
> > +	cancel_delayed_work_sync(&ip_block->adev->vce.idle_work);
> > +	return 0;
> > +}
> > +
> > +static int vce_v1_0_suspend(struct amdgpu_ip_block *ip_block)
> > +{
> > +	struct amdgpu_device *adev =3D ip_block->adev;
> > +	int r;
> > +
> > +	/*
> > +	 * Proper cleanups before halting the HW engine:
> > +	 *=C2=A0=C2=A0 - cancel the delayed idle work
> > +	 *=C2=A0=C2=A0 - enable powergating
> > +	 *=C2=A0=C2=A0 - enable clockgating
> > +	 *=C2=A0=C2=A0 - disable dpm
> > +	 *
> > +	 * TODO: to align with the VCN implementation, move the
> > +	 * jobs for clockgating/powergating/dpm setting to
> > +	 * ->set_powergating_state().
> > +	 */
> > +	cancel_delayed_work_sync(&adev->vce.idle_work);
> > +
> > +	if (adev->pm.dpm_enabled) {
> > +		amdgpu_dpm_enable_vce(adev, false);
> > +	} else {
> > +		amdgpu_asic_set_vce_clocks(adev, 0, 0);
> > +		amdgpu_device_ip_set_powergating_state(adev,
> > AMD_IP_BLOCK_TYPE_VCE,
> > +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > AMD_PG_STATE_GATE);
> > +		amdgpu_device_ip_set_clockgating_state(adev,
> > AMD_IP_BLOCK_TYPE_VCE,
> > +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > AMD_CG_STATE_GATE);
> > +	}
> > +
> > +	r =3D vce_v1_0_hw_fini(ip_block);
> > +	if (r) {
> > +		dev_err(adev->dev, "vce_v1_0_hw_fini() failed with
> > error %i", r);
> > +		return r;
> > +	}
> > +
> > +	return amdgpu_vce_suspend(adev);
> > +}
> > +
> > +static int vce_v1_0_resume(struct amdgpu_ip_block *ip_block)
> > +{
> > +	struct amdgpu_device *adev =3D ip_block->adev;
> > +	int r;
> > +
> > +	r =3D amdgpu_vce_resume(adev);
> > +	if (r)
> > +		return r;
> > +	r =3D vce_v1_0_load_fw_signature(adev);
> > +	if (r)
> > +		return r;
> > +
> > +	return vce_v1_0_hw_init(ip_block);
> > +}
> > +
> > +static int vce_v1_0_set_interrupt_state(struct amdgpu_device
> > *adev,
> > +					struct amdgpu_irq_src
> > *source,
> > +					unsigned int type,
> > +					enum
> > amdgpu_interrupt_state state)
> > +{
> > +	uint32_t val =3D 0;
> > +
> > +	if (state =3D=3D AMDGPU_IRQ_STATE_ENABLE)
> > +		val |=3D
> > VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK;
> > +
> > +	WREG32_P(mmVCE_SYS_INT_EN, val,
> > +	=09
> > ~VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK);
> > +	return 0;
> > +}
> > +
> > +static int vce_v1_0_process_interrupt(struct amdgpu_device *adev,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_irq_src
> > *source,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_iv_entry
> > *entry)
> > +{
> > +	dev_dbg(adev->dev, "IH: VCE\n");
> > +	switch (entry->src_data[0]) {
> > +	case 0:
> > +	case 1:
> > +		amdgpu_fence_process(&adev->vce.ring[entry-
> > >src_data[0]]);
> > +		break;
> > +	default:
> > +		dev_err(adev->dev, "Unhandled interrupt: %d %d\n",
> > +			=C2=A0 entry->src_id, entry->src_data[0]);
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int vce_v1_0_set_clockgating_state(struct amdgpu_ip_block
> > *ip_block,
> > +					=C2=A0 enum
> > amd_clockgating_state state)
> > +{
> > +	struct amdgpu_device *adev =3D ip_block->adev;
> > +
> > +	vce_v1_0_init_cg(adev);
> > +	vce_v1_0_enable_mgcg(adev, state =3D=3D AMD_CG_STATE_GATE);
> > +
> > +	return 0;
> > +}
> > +
> > +static int vce_v1_0_set_powergating_state(struct amdgpu_ip_block
> > *ip_block,
> > +					=C2=A0 enum
> > amd_powergating_state state)
> > +{
> > +	struct amdgpu_device *adev =3D ip_block->adev;
> > +
> > +	/* This doesn't actually powergate the VCE block.
> > +	 * That's done in the dpm code via the SMC.=C2=A0 This
> > +	 * just re-inits the block as necessary.=C2=A0 The actual
> > +	 * gating still happens in the dpm code.=C2=A0 We should
> > +	 * revisit this when there is a cleaner line between
> > +	 * the smc and the hw blocks
> > +	 */
> > +	if (state =3D=3D AMD_PG_STATE_GATE)
> > +		return vce_v1_0_stop(adev);
> > +	else
> > +		return vce_v1_0_start(adev);
> > +}
> > +
> > +static const struct amd_ip_funcs vce_v1_0_ip_funcs =3D {
> > +	.name =3D "vce_v1_0",
> > +	.early_init =3D vce_v1_0_early_init,
> > +	.sw_init =3D vce_v1_0_sw_init,
> > +	.sw_fini =3D vce_v1_0_sw_fini,
> > +	.hw_init =3D vce_v1_0_hw_init,
> > +	.hw_fini =3D vce_v1_0_hw_fini,
> > +	.suspend =3D vce_v1_0_suspend,
> > +	.resume =3D vce_v1_0_resume,
> > +	.is_idle =3D vce_v1_0_is_idle,
> > +	.wait_for_idle =3D vce_v1_0_wait_for_idle,
> > +	.set_clockgating_state =3D vce_v1_0_set_clockgating_state,
> > +	.set_powergating_state =3D vce_v1_0_set_powergating_state,
> > +};
> > +
> > +static const struct amdgpu_ring_funcs vce_v1_0_ring_funcs =3D {
> > +	.type =3D AMDGPU_RING_TYPE_VCE,
> > +	.align_mask =3D 0xf,
> > +	.nop =3D VCE_CMD_NO_OP,
> > +	.support_64bit_ptrs =3D false,
> > +	.no_user_fence =3D true,
> > +	.get_rptr =3D vce_v1_0_ring_get_rptr,
> > +	.get_wptr =3D vce_v1_0_ring_get_wptr,
> > +	.set_wptr =3D vce_v1_0_ring_set_wptr,
> > +	.parse_cs =3D amdgpu_vce_ring_parse_cs,
> > +	.emit_frame_size =3D 6, /* amdgpu_vce_ring_emit_fence=C2=A0 x1 no
> > user fence */
> > +	.emit_ib_size =3D 4, /* amdgpu_vce_ring_emit_ib */
> > +	.emit_ib =3D amdgpu_vce_ring_emit_ib,
> > +	.emit_fence =3D amdgpu_vce_ring_emit_fence,
> > +	.test_ring =3D amdgpu_vce_ring_test_ring,
> > +	.test_ib =3D amdgpu_vce_ring_test_ib,
> > +	.insert_nop =3D amdgpu_ring_insert_nop,
> > +	.pad_ib =3D amdgpu_ring_generic_pad_ib,
> > +	.begin_use =3D amdgpu_vce_ring_begin_use,
> > +	.end_use =3D amdgpu_vce_ring_end_use,
> > +};
> > +
> > +static void vce_v1_0_set_ring_funcs(struct amdgpu_device *adev)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < adev->vce.num_rings; i++) {
> > +		adev->vce.ring[i].funcs =3D &vce_v1_0_ring_funcs;
> > +		adev->vce.ring[i].me =3D i;
> > +	}
> > +};
> > +
> > +static const struct amdgpu_irq_src_funcs vce_v1_0_irq_funcs =3D {
> > +	.set =3D vce_v1_0_set_interrupt_state,
> > +	.process =3D vce_v1_0_process_interrupt,
> > +};
> > +
> > +static void vce_v1_0_set_irq_funcs(struct amdgpu_device *adev)
> > +{
> > +	adev->vce.irq.num_types =3D 1;
> > +	adev->vce.irq.funcs =3D &vce_v1_0_irq_funcs;
> > +};
> > +
> > +const struct amdgpu_ip_block_version vce_v1_0_ip_block =3D {
> > +	.type =3D AMD_IP_BLOCK_TYPE_VCE,
> > +	.major =3D 1,
> > +	.minor =3D 0,
> > +	.rev =3D 0,
> > +	.funcs =3D &vce_v1_0_ip_funcs,
> > +};
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.h
> > b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.h
> > new file mode 100644
> > index 000000000000..206e7bec897f
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.h
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: MIT */
> > +/*
> > + * Copyright 2025 Advanced Micro Devices, Inc.
> > + * Copyright 2025 Valve Corporation
> > + * Copyright 2025 Alexandre Demers
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> > obtaining a
> > + * copy of this software and associated documentation files (the
> > "Software"),
> > + * to deal in the Software without restriction, including without
> > limitation
> > + * the rights to use, copy, modify, merge, publish, distribute,
> > sublicense,
> > + * and/or sell copies of the Software, and to permit persons to
> > whom the
> > + * Software is furnished to do so, subject to the following
> > conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be
> > included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.=C2=A0 IN NO
> > EVENT SHALL
> > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> > DAMAGES OR
> > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> > OTHERWISE,
> > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> > USE OR
> > + * OTHER DEALINGS IN THE SOFTWARE.
> > + *
> > + */
> > +
> > +#ifndef __VCE_V1_0_H__
> > +#define __VCE_V1_0_H__
> > +
> > +extern const struct amdgpu_ip_block_version vce_v1_0_ip_block;
> > +
> > +#endif
