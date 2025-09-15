Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979C9CAC592
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 22:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E7110E5BA;
	Mon, 15 Sep 2025 22:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RdbQT/Uu";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E11110E5BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 22:49:49 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2445806df50so38084635ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 15:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757976589; x=1758581389; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07Jg+24FRmI7XVgacLhhchdwDhmQKL9825gsY6p0jqk=;
 b=RdbQT/UujiKvYB1s5I+9B8+lzvCUuD0RoJnDBzpwMxo+PztBBaAXLJVmmMM1kDjtYm
 Y1wY4Bhhjv89KzmUSVYjriJ40eGdwMdiYHwAfCmJ/2pSrSx67I4zRMJtPKwj5E0Y9bNJ
 ddvmuFRuSui8uhfLYtDeh3cOFbUXoKsTLXgiWKk60ODeJD0l/k6HizrzIWLQmjSlXtQ7
 vB4SoKEMeeAGIlfZrzLqrtfv9UqyoGA0ywkdmU8SYz7676vuJaLp3kMOXfwYaYyDJnj3
 LQeLTRGOpZ6XPqk701Ce93URQLARnZGX3ckV9cgAchC9r75vOl2QaHo/v/9b/xYBs2w9
 Mzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757976589; x=1758581389;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=07Jg+24FRmI7XVgacLhhchdwDhmQKL9825gsY6p0jqk=;
 b=OLSNvoS/u8d8fQzRvUeJLX89KzFhMvWN29hh+ssm9utRPFfCK0h5/TiItvbRUcfHm9
 5ZFcdhoANiTpB3nmethdlYpGV2lkVvkJqZoHWCy/EwJEJ0UOYHdmyQAp8QMBbOk7pKHq
 cUUmYLwaI7IrUv/oddaeoUBO1TjnK/wL0p+mNdn/ud0cGI+MViSO/ereT3EBFlPqPf7q
 xDsuLMdGumEMV69ae/BemycL0B42JOIkwe0HYKMGo9Ir9c2L57eWlbRDNADEENUmksb9
 +WUYZRei7QVx/UQvbkd0Q8Pd52a33+WUwSP9AIz6xmoZ8d63X0X1Pu4H5EZ+F0vC2RwB
 WjVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBEh+Xag/yDH9S9qHbZ1iki9XlHQ7HQ1iSrjPIURD5U3wejaSDeg+Etqa3KSf46uZm5H9TPc+C@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVSU4RiLyQ7l+Cj0LfDUXFV+2uFb3PF38IRL64Pty4s1rJnmKT
 J6jVL3cdJ5z0SAurGkg9qlKTn5gUP25Oz+OFtL8/OfLN7c997tvsC/w3PQiOSg==
X-Gm-Gg: ASbGncv5mEmz0o/iqwowV7Yt+U3/xM0a6aPc8e3ENlQ05BiyM6QH/mwOwBL75ihhn14
 x/ZqHAdCWR902Yp2zXItqJPFnS5KPDiMigpiH72VC1Mp1GLdgFVouGKgLoGqqKaU0scQWqbwPW+
 x+guHktF9clsqEyQKptBWlChIYx+1opT5+u9NxzC1d9s/V8WXPw54aXqwbL5UTDUxrnzApyc0TH
 jMA8IgRMnU6w4Yn+N56IgIwoUX86Qv06Rpl169YUv09BlF4UawTcfQ1lqVjM+EPymp60uDWKV5w
 6431Zn6azjihf+BC0swFU6lhCBB2s9EgTzByG4/+NpSDiDtKX8vBap9fSJiITCM/EJcF90r85Do
 N70hckqA4dhLUwIsekx20p1nUDw6OCZ6WakynOoW9zXapcU/T4xmuDUP2K7+zgh/mRLuE7VP5WR
 EeFmEak+4N1eFT6YXGKkUjfJtFUjKL1H4XL1MG64nRcZLztAZkk69D9n72iBAXzmfrRfNH7fmz6
 g==
X-Google-Smtp-Source: AGHT+IFhDPeJCVBk3Jm1rMqeyPiVxDO6RzDHnmeYNxjDmi051edshHyIIF8xOVyxTx2c6oY01zc6uw==
X-Received: by 2002:a17:903:2444:b0:266:e8c3:4731 with SMTP id
 d9443c01a7336-266e8c35152mr63388445ad.23.1757976587613; 
 Mon, 15 Sep 2025 15:49:47 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24d7:a100:6cbc:3a09:ac01:5ce2?
 (20014C4E24D7A1006CBC3A09AC015CE2.dsl.pool.telekom.hu.
 [2001:4c4e:24d7:a100:6cbc:3a09:ac01:5ce2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25db018df8bsm107160925ad.151.2025.09.15.15.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 15:49:46 -0700 (PDT)
Message-ID: <7be2dfe9535ea13bc131f0a553ce8b302106496b.camel@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove non-DC DCE 11 code
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Date: Tue, 16 Sep 2025 00:49:40 +0200
In-Reply-To: <20250915202848.24733-1-alexander.deucher@amd.com>
References: <20250915202848.24733-1-alexander.deucher@amd.com>
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

On Mon, 2025-09-15 at 16:28 -0400, Alex Deucher wrote:
> DC has been the default for close to 10 years now and supports
> many things that the non-DC code does not (audio, DP MST, etc.).
> No DCE 11.x IPs ever supported analog encoders so that is not
> an issue.=C2=A0 Finally drop this code.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Nice!

As far as I can tell, DC was merged almost exactly 8 years ago. :)

Acked-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0 1 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c |=C2=A0=C2=A0=C2=A0 8 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/dce_v11_0.c=C2=A0=C2=A0 | 3817 ---------=
-----------
> --
> =C2=A0drivers/gpu/drm/amd/amdgpu/dce_v11_0.h=C2=A0=C2=A0 |=C2=A0=C2=A0 32=
 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/vi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 7 -
> =C2=A05 files changed, 3865 deletions(-)
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> =C2=A0delete mode 100644 drivers/gpu/drm/amd/amdgpu/dce_v11_0.h
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 2d0fea87af79f..64e7acff8f18d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -138,7 +138,6 @@ amdgpu-y +=3D \
> =C2=A0# add DCE block
> =C2=A0amdgpu-y +=3D \
> =C2=A0	dce_v10_0.o \
> -	dce_v11_0.o \
> =C2=A0	amdgpu_vkms.o
> =C2=A0
> =C2=A0# add GFX block
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> index 155bb9891a175..79bad9cbe2abd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -14,7 +14,6 @@
> =C2=A0#include "dce_v8_0.h"
> =C2=A0#endif
> =C2=A0#include "dce_v10_0.h"
> -#include "dce_v11_0.h"
> =C2=A0#include "ivsrcid/ivsrcid_vislands30.h"
> =C2=A0#include "amdgpu_vkms.h"
> =C2=A0#include "amdgpu_display.h"
> @@ -581,13 +580,6 @@ static int amdgpu_vkms_hw_init(struct
> amdgpu_ip_block *ip_block)
> =C2=A0	case CHIP_TONGA:
> =C2=A0		dce_v10_0_disable_dce(adev);
> =C2=A0		break;
> -	case CHIP_CARRIZO:
> -	case CHIP_STONEY:
> -	case CHIP_POLARIS10:
> -	case CHIP_POLARIS11:
> -	case CHIP_VEGAM:
> -		dce_v11_0_disable_dce(adev);
> -		break;
> =C2=A0	case CHIP_TOPAZ:
> =C2=A0#ifdef CONFIG_DRM_AMDGPU_SI
> =C2=A0	case CHIP_HAINAN:
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> deleted file mode 100644
> index e846088913000..0000000000000
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> +++ /dev/null
> @@ -1,3817 +0,0 @@
> -/*
> - * Copyright 2014 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person
> obtaining a
> - * copy of this software and associated documentation files (the
> "Software"),
> - * to deal in the Software without restriction, including without
> limitation
> - * the rights to use, copy, modify, merge, publish, distribute,
> sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom
> the
> - * Software is furnished to do so, subject to the following
> conditions:
> - *
> - * The above copyright notice and this permission notice shall be
> included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.=C2=A0 IN NO
> EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - */
> -
> -#include <drm/drm_edid.h>
> -#include <drm/drm_fourcc.h>
> -#include <drm/drm_modeset_helper.h>
> -#include <drm/drm_modeset_helper_vtables.h>
> -#include <drm/drm_vblank.h>
> -
> -#include "amdgpu.h"
> -#include "amdgpu_pm.h"
> -#include "amdgpu_i2c.h"
> -#include "vid.h"
> -#include "atom.h"
> -#include "amdgpu_atombios.h"
> -#include "atombios_crtc.h"
> -#include "atombios_encoders.h"
> -#include "amdgpu_pll.h"
> -#include "amdgpu_connectors.h"
> -#include "amdgpu_display.h"
> -#include "dce_v11_0.h"
> -
> -#include "dce/dce_11_0_d.h"
> -#include "dce/dce_11_0_sh_mask.h"
> -#include "dce/dce_11_0_enum.h"
> -#include "oss/oss_3_0_d.h"
> -#include "oss/oss_3_0_sh_mask.h"
> -#include "gmc/gmc_8_1_d.h"
> -#include "gmc/gmc_8_1_sh_mask.h"
> -
> -#include "ivsrcid/ivsrcid_vislands30.h"
> -
> -static void dce_v11_0_set_display_funcs(struct amdgpu_device *adev);
> -static void dce_v11_0_set_irq_funcs(struct amdgpu_device *adev);
> -static void dce_v11_0_hpd_int_ack(struct amdgpu_device *adev, int
> hpd);
> -
> -static const u32 crtc_offsets[] =3D
> -{
> -	CRTC0_REGISTER_OFFSET,
> -	CRTC1_REGISTER_OFFSET,
> -	CRTC2_REGISTER_OFFSET,
> -	CRTC3_REGISTER_OFFSET,
> -	CRTC4_REGISTER_OFFSET,
> -	CRTC5_REGISTER_OFFSET,
> -	CRTC6_REGISTER_OFFSET
> -};
> -
> -static const u32 hpd_offsets[] =3D
> -{
> -	HPD0_REGISTER_OFFSET,
> -	HPD1_REGISTER_OFFSET,
> -	HPD2_REGISTER_OFFSET,
> -	HPD3_REGISTER_OFFSET,
> -	HPD4_REGISTER_OFFSET,
> -	HPD5_REGISTER_OFFSET
> -};
> -
> -static const uint32_t dig_offsets[] =3D {
> -	DIG0_REGISTER_OFFSET,
> -	DIG1_REGISTER_OFFSET,
> -	DIG2_REGISTER_OFFSET,
> -	DIG3_REGISTER_OFFSET,
> -	DIG4_REGISTER_OFFSET,
> -	DIG5_REGISTER_OFFSET,
> -	DIG6_REGISTER_OFFSET,
> -	DIG7_REGISTER_OFFSET,
> -	DIG8_REGISTER_OFFSET
> -};
> -
> -static const struct {
> -	uint32_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg;
> -	uint32_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vblank;
> -	uint32_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vline;
> -	uint32_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hpd;
> -
> -} interrupt_status_offsets[] =3D { {
> -	.reg =3D mmDISP_INTERRUPT_STATUS,
> -	.vblank =3D
> DISP_INTERRUPT_STATUS__LB_D1_VBLANK_INTERRUPT_MASK,
> -	.vline =3D DISP_INTERRUPT_STATUS__LB_D1_VLINE_INTERRUPT_MASK,
> -	.hpd =3D DISP_INTERRUPT_STATUS__DC_HPD1_INTERRUPT_MASK
> -}, {
> -	.reg =3D mmDISP_INTERRUPT_STATUS_CONTINUE,
> -	.vblank =3D
> DISP_INTERRUPT_STATUS_CONTINUE__LB_D2_VBLANK_INTERRUPT_MASK,
> -	.vline =3D
> DISP_INTERRUPT_STATUS_CONTINUE__LB_D2_VLINE_INTERRUPT_MASK,
> -	.hpd =3D
> DISP_INTERRUPT_STATUS_CONTINUE__DC_HPD2_INTERRUPT_MASK
> -}, {
> -	.reg =3D mmDISP_INTERRUPT_STATUS_CONTINUE2,
> -	.vblank =3D
> DISP_INTERRUPT_STATUS_CONTINUE2__LB_D3_VBLANK_INTERRUPT_MASK,
> -	.vline =3D
> DISP_INTERRUPT_STATUS_CONTINUE2__LB_D3_VLINE_INTERRUPT_MASK,
> -	.hpd =3D
> DISP_INTERRUPT_STATUS_CONTINUE2__DC_HPD3_INTERRUPT_MASK
> -}, {
> -	.reg =3D mmDISP_INTERRUPT_STATUS_CONTINUE3,
> -	.vblank =3D
> DISP_INTERRUPT_STATUS_CONTINUE3__LB_D4_VBLANK_INTERRUPT_MASK,
> -	.vline =3D
> DISP_INTERRUPT_STATUS_CONTINUE3__LB_D4_VLINE_INTERRUPT_MASK,
> -	.hpd =3D
> DISP_INTERRUPT_STATUS_CONTINUE3__DC_HPD4_INTERRUPT_MASK
> -}, {
> -	.reg =3D mmDISP_INTERRUPT_STATUS_CONTINUE4,
> -	.vblank =3D
> DISP_INTERRUPT_STATUS_CONTINUE4__LB_D5_VBLANK_INTERRUPT_MASK,
> -	.vline =3D
> DISP_INTERRUPT_STATUS_CONTINUE4__LB_D5_VLINE_INTERRUPT_MASK,
> -	.hpd =3D
> DISP_INTERRUPT_STATUS_CONTINUE4__DC_HPD5_INTERRUPT_MASK
> -}, {
> -	.reg =3D mmDISP_INTERRUPT_STATUS_CONTINUE5,
> -	.vblank =3D
> DISP_INTERRUPT_STATUS_CONTINUE5__LB_D6_VBLANK_INTERRUPT_MASK,
> -	.vline =3D
> DISP_INTERRUPT_STATUS_CONTINUE5__LB_D6_VLINE_INTERRUPT_MASK,
> -	.hpd =3D
> DISP_INTERRUPT_STATUS_CONTINUE5__DC_HPD6_INTERRUPT_MASK
> -} };
> -
> -static const u32 cz_golden_settings_a11[] =3D
> -{
> -	mmCRTC_DOUBLE_BUFFER_CONTROL, 0x00010101, 0x00010000,
> -	mmFBC_MISC, 0x1f311fff, 0x14300000,
> -};
> -
> -static const u32 cz_mgcg_cgcg_init[] =3D
> -{
> -	mmXDMA_CLOCK_GATING_CNTL, 0xffffffff, 0x00000100,
> -	mmXDMA_MEM_POWER_CNTL, 0x00000101, 0x00000000,
> -};
> -
> -static const u32 stoney_golden_settings_a11[] =3D
> -{
> -	mmCRTC_DOUBLE_BUFFER_CONTROL, 0x00010101, 0x00010000,
> -	mmFBC_MISC, 0x1f311fff, 0x14302000,
> -};
> -
> -static const u32 polaris11_golden_settings_a11[] =3D
> -{
> -	mmDCI_CLK_CNTL, 0x00000080, 0x00000000,
> -	mmFBC_DEBUG_COMP, 0x000000f0, 0x00000070,
> -	mmFBC_DEBUG1, 0xffffffff, 0x00000008,
> -	mmFBC_MISC, 0x9f313fff, 0x14302008,
> -	mmHDMI_CONTROL, 0x313f031f, 0x00000011,
> -};
> -
> -static const u32 polaris10_golden_settings_a11[] =3D
> -{
> -	mmDCI_CLK_CNTL, 0x00000080, 0x00000000,
> -	mmFBC_DEBUG_COMP, 0x000000f0, 0x00000070,
> -	mmFBC_MISC, 0x9f313fff, 0x14302008,
> -	mmHDMI_CONTROL, 0x313f031f, 0x00000011,
> -};
> -
> -static void dce_v11_0_init_golden_registers(struct amdgpu_device
> *adev)
> -{
> -	switch (adev->asic_type) {
> -	case CHIP_CARRIZO:
> -		amdgpu_device_program_register_sequence(adev,
> -
> 							cz_mgcg_cgcg_init,
> -
> 							ARRAY_SIZE(cz_mgcg_cgcg_init));
> -		amdgpu_device_program_register_sequence(adev,
> -
> 							cz_golden_settings_a11,
> -
> 							ARRAY_SIZE(cz_golden_settings_a11));
> -		break;
> -	case CHIP_STONEY:
> -		amdgpu_device_program_register_sequence(adev,
> -
> 							stoney_golden_settings_a11,
> -
> 							ARRAY_SIZE(stoney_golden_settings_a11));
> -		break;
> -	case CHIP_POLARIS11:
> -	case CHIP_POLARIS12:
> -		amdgpu_device_program_register_sequence(adev,
> -
> 							polaris11_golden_settings_a11,
> -
> 							ARRAY_SIZE(polaris11_golden_settings_a11));
> -		break;
> -	case CHIP_POLARIS10:
> -	case CHIP_VEGAM:
> -		amdgpu_device_program_register_sequence(adev,
> -
> 							polaris10_golden_settings_a11,
> -
> 							ARRAY_SIZE(polaris10_golden_settings_a11));
> -		break;
> -	default:
> -		break;
> -	}
> -}
> -
> -static u32 dce_v11_0_audio_endpt_rreg(struct amdgpu_device *adev,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 u32 block_offset, u32 reg)
> -{
> -	unsigned long flags;
> -	u32 r;
> -
> -	spin_lock_irqsave(&adev->audio_endpt_idx_lock, flags);
> -	WREG32(mmAZALIA_F0_CODEC_ENDPOINT_INDEX + block_offset,
> reg);
> -	r =3D RREG32(mmAZALIA_F0_CODEC_ENDPOINT_DATA + block_offset);
> -	spin_unlock_irqrestore(&adev->audio_endpt_idx_lock, flags);
> -
> -	return r;
> -}
> -
> -static void dce_v11_0_audio_endpt_wreg(struct amdgpu_device *adev,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 block_offset, u32 reg, u32
> v)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&adev->audio_endpt_idx_lock, flags);
> -	WREG32(mmAZALIA_F0_CODEC_ENDPOINT_INDEX + block_offset,
> reg);
> -	WREG32(mmAZALIA_F0_CODEC_ENDPOINT_DATA + block_offset, v);
> -	spin_unlock_irqrestore(&adev->audio_endpt_idx_lock, flags);
> -}
> -
> -static u32 dce_v11_0_vblank_get_counter(struct amdgpu_device *adev,
> int crtc)
> -{
> -	if (crtc < 0 || crtc >=3D adev->mode_info.num_crtc)
> -		return 0;
> -	else
> -		return RREG32(mmCRTC_STATUS_FRAME_COUNT +
> crtc_offsets[crtc]);
> -}
> -
> -static void dce_v11_0_pageflip_interrupt_init(struct amdgpu_device
> *adev)
> -{
> -	unsigned i;
> -
> -	/* Enable pflip interrupts */
> -	for (i =3D 0; i < adev->mode_info.num_crtc; i++)
> -		amdgpu_irq_get(adev, &adev->pageflip_irq, i);
> -}
> -
> -static void dce_v11_0_pageflip_interrupt_fini(struct amdgpu_device
> *adev)
> -{
> -	unsigned i;
> -
> -	/* Disable pflip interrupts */
> -	for (i =3D 0; i < adev->mode_info.num_crtc; i++)
> -		amdgpu_irq_put(adev, &adev->pageflip_irq, i);
> -}
> -
> -/**
> - * dce_v11_0_page_flip - pageflip callback.
> - *
> - * @adev: amdgpu_device pointer
> - * @crtc_id: crtc to cleanup pageflip on
> - * @crtc_base: new address of the crtc (GPU MC address)
> - * @async: asynchronous flip
> - *
> - * Triggers the actual pageflip by updating the primary
> - * surface base address.
> - */
> -static void dce_v11_0_page_flip(struct amdgpu_device *adev,
> -				int crtc_id, u64 crtc_base, bool
> async)
> -{
> -	struct amdgpu_crtc *amdgpu_crtc =3D adev-
> >mode_info.crtcs[crtc_id];
> -	struct drm_framebuffer *fb =3D amdgpu_crtc->base.primary->fb;
> -	u32 tmp;
> -
> -	/* flip immediate for async, default is vsync */
> -	tmp =3D RREG32(mmGRPH_FLIP_CONTROL + amdgpu_crtc-
> >crtc_offset);
> -	tmp =3D REG_SET_FIELD(tmp, GRPH_FLIP_CONTROL,
> -			=C2=A0=C2=A0=C2=A0 GRPH_SURFACE_UPDATE_IMMEDIATE_EN, async
> ? 1 : 0);
> -	WREG32(mmGRPH_FLIP_CONTROL + amdgpu_crtc->crtc_offset, tmp);
> -	/* update pitch */
> -	WREG32(mmGRPH_PITCH + amdgpu_crtc->crtc_offset,
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fb->pitches[0] / fb->format->cpp[0=
]);
> -	/* update the scanout addresses */
> -	WREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS_HIGH + amdgpu_crtc-
> >crtc_offset,
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upper_32_bits(crtc_base));
> -	/* writing to the low address triggers the update */
> -	WREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS + amdgpu_crtc-
> >crtc_offset,
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lower_32_bits(crtc_base));
> -	/* post the write */
> -	RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS + amdgpu_crtc-
> >crtc_offset);
> -}
> -
> -static int dce_v11_0_crtc_get_scanoutpos(struct amdgpu_device *adev,
> int crtc,
> -					u32 *vbl, u32 *position)
> -{
> -	if ((crtc < 0) || (crtc >=3D adev->mode_info.num_crtc))
> -		return -EINVAL;
> -
> -	*vbl =3D RREG32(mmCRTC_V_BLANK_START_END +
> crtc_offsets[crtc]);
> -	*position =3D RREG32(mmCRTC_STATUS_POSITION +
> crtc_offsets[crtc]);
> -
> -	return 0;
> -}
> -
> -/**
> - * dce_v11_0_hpd_sense - hpd sense callback.
> - *
> - * @adev: amdgpu_device pointer
> - * @hpd: hpd (hotplug detect) pin
> - *
> - * Checks if a digital monitor is connected (evergreen+).
> - * Returns true if connected, false if not connected.
> - */
> -static bool dce_v11_0_hpd_sense(struct amdgpu_device *adev,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum amdgpu_hpd_id hpd)
> -{
> -	bool connected =3D false;
> -
> -	if (hpd >=3D adev->mode_info.num_hpd)
> -		return connected;
> -
> -	if (RREG32(mmDC_HPD_INT_STATUS + hpd_offsets[hpd]) &
> -	=C2=A0=C2=A0=C2=A0 DC_HPD_INT_STATUS__DC_HPD_SENSE_MASK)
> -		connected =3D true;
> -
> -	return connected;
> -}
> -
> -/**
> - * dce_v11_0_hpd_set_polarity - hpd set polarity callback.
> - *
> - * @adev: amdgpu_device pointer
> - * @hpd: hpd (hotplug detect) pin
> - *
> - * Set the polarity of the hpd pin (evergreen+).
> - */
> -static void dce_v11_0_hpd_set_polarity(struct amdgpu_device *adev,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum amdgpu_hpd_id hpd)
> -{
> -	u32 tmp;
> -	bool connected =3D dce_v11_0_hpd_sense(adev, hpd);
> -
> -	if (hpd >=3D adev->mode_info.num_hpd)
> -		return;
> -
> -	tmp =3D RREG32(mmDC_HPD_INT_CONTROL + hpd_offsets[hpd]);
> -	if (connected)
> -		tmp =3D REG_SET_FIELD(tmp, DC_HPD_INT_CONTROL,
> DC_HPD_INT_POLARITY, 0);
> -	else
> -		tmp =3D REG_SET_FIELD(tmp, DC_HPD_INT_CONTROL,
> DC_HPD_INT_POLARITY, 1);
> -	WREG32(mmDC_HPD_INT_CONTROL + hpd_offsets[hpd], tmp);
> -}
> -
> -/**
> - * dce_v11_0_hpd_init - hpd setup callback.
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Setup the hpd pins used by the card (evergreen+).
> - * Enable the pin, set the polarity, and enable the hpd interrupts.
> - */
> -static void dce_v11_0_hpd_init(struct amdgpu_device *adev)
> -{
> -	struct drm_device *dev =3D adev_to_drm(adev);
> -	struct drm_connector *connector;
> -	struct drm_connector_list_iter iter;
> -	u32 tmp;
> -
> -	drm_connector_list_iter_begin(dev, &iter);
> -	drm_for_each_connector_iter(connector, &iter) {
> -		struct amdgpu_connector *amdgpu_connector =3D
> to_amdgpu_connector(connector);
> -
> -		if (amdgpu_connector->hpd.hpd >=3D adev-
> >mode_info.num_hpd)
> -			continue;
> -
> -		if (connector->connector_type =3D=3D
> DRM_MODE_CONNECTOR_eDP ||
> -		=C2=A0=C2=A0=C2=A0 connector->connector_type =3D=3D
> DRM_MODE_CONNECTOR_LVDS) {
> -			/* don't try to enable hpd on eDP or LVDS
> avoid breaking the
> -			 * aux dp channel on imac and help (but not
> completely fix)
> -			 *
> https://bugzilla.redhat.com/show_bug.cgi?id=3D726143
> -			 * also avoid interrupt storms during dpms.
> -			 */
> -			tmp =3D RREG32(mmDC_HPD_INT_CONTROL +
> hpd_offsets[amdgpu_connector->hpd.hpd]);
> -			tmp =3D REG_SET_FIELD(tmp, DC_HPD_INT_CONTROL,
> DC_HPD_INT_EN, 0);
> -			WREG32(mmDC_HPD_INT_CONTROL +
> hpd_offsets[amdgpu_connector->hpd.hpd], tmp);
> -			continue;
> -		}
> -
> -		tmp =3D RREG32(mmDC_HPD_CONTROL +
> hpd_offsets[amdgpu_connector->hpd.hpd]);
> -		tmp =3D REG_SET_FIELD(tmp, DC_HPD_CONTROL, DC_HPD_EN,
> 1);
> -		WREG32(mmDC_HPD_CONTROL +
> hpd_offsets[amdgpu_connector->hpd.hpd], tmp);
> -
> -		tmp =3D RREG32(mmDC_HPD_TOGGLE_FILT_CNTL +
> hpd_offsets[amdgpu_connector->hpd.hpd]);
> -		tmp =3D REG_SET_FIELD(tmp, DC_HPD_TOGGLE_FILT_CNTL,
> -				=C2=A0=C2=A0=C2=A0 DC_HPD_CONNECT_INT_DELAY,
> -				=C2=A0=C2=A0=C2=A0
> AMDGPU_HPD_CONNECT_INT_DELAY_IN_MS);
> -		tmp =3D REG_SET_FIELD(tmp, DC_HPD_TOGGLE_FILT_CNTL,
> -				=C2=A0=C2=A0=C2=A0 DC_HPD_DISCONNECT_INT_DELAY,
> -				=C2=A0=C2=A0=C2=A0
> AMDGPU_HPD_DISCONNECT_INT_DELAY_IN_MS);
> -		WREG32(mmDC_HPD_TOGGLE_FILT_CNTL +
> hpd_offsets[amdgpu_connector->hpd.hpd], tmp);
> -
> -		dce_v11_0_hpd_int_ack(adev, amdgpu_connector-
> >hpd.hpd);
> -		dce_v11_0_hpd_set_polarity(adev, amdgpu_connector-
> >hpd.hpd);
> -		amdgpu_irq_get(adev, &adev->hpd_irq,
> amdgpu_connector->hpd.hpd);
> -	}
> -	drm_connector_list_iter_end(&iter);
> -}
> -
> -/**
> - * dce_v11_0_hpd_fini - hpd tear down callback.
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Tear down the hpd pins used by the card (evergreen+).
> - * Disable the hpd interrupts.
> - */
> -static void dce_v11_0_hpd_fini(struct amdgpu_device *adev)
> -{
> -	struct drm_device *dev =3D adev_to_drm(adev);
> -	struct drm_connector *connector;
> -	struct drm_connector_list_iter iter;
> -	u32 tmp;
> -
> -	drm_connector_list_iter_begin(dev, &iter);
> -	drm_for_each_connector_iter(connector, &iter) {
> -		struct amdgpu_connector *amdgpu_connector =3D
> to_amdgpu_connector(connector);
> -
> -		if (amdgpu_connector->hpd.hpd >=3D adev-
> >mode_info.num_hpd)
> -			continue;
> -
> -		tmp =3D RREG32(mmDC_HPD_CONTROL +
> hpd_offsets[amdgpu_connector->hpd.hpd]);
> -		tmp =3D REG_SET_FIELD(tmp, DC_HPD_CONTROL, DC_HPD_EN,
> 0);
> -		WREG32(mmDC_HPD_CONTROL +
> hpd_offsets[amdgpu_connector->hpd.hpd], tmp);
> -
> -		amdgpu_irq_put(adev, &adev->hpd_irq,
> amdgpu_connector->hpd.hpd);
> -	}
> -	drm_connector_list_iter_end(&iter);
> -}
> -
> -static u32 dce_v11_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
> -{
> -	return mmDC_GPIO_HPD_A;
> -}
> -
> -static bool dce_v11_0_is_display_hung(struct amdgpu_device *adev)
> -{
> -	u32 crtc_hung =3D 0;
> -	u32 crtc_status[6];
> -	u32 i, j, tmp;
> -
> -	for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> -		tmp =3D RREG32(mmCRTC_CONTROL + crtc_offsets[i]);
> -		if (REG_GET_FIELD(tmp, CRTC_CONTROL,
> CRTC_MASTER_EN)) {
> -			crtc_status[i] =3D
> RREG32(mmCRTC_STATUS_HV_COUNT + crtc_offsets[i]);
> -			crtc_hung |=3D (1 << i);
> -		}
> -	}
> -
> -	for (j =3D 0; j < 10; j++) {
> -		for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> -			if (crtc_hung & (1 << i)) {
> -				tmp =3D RREG32(mmCRTC_STATUS_HV_COUNT
> + crtc_offsets[i]);
> -				if (tmp !=3D crtc_status[i])
> -					crtc_hung &=3D ~(1 << i);
> -			}
> -		}
> -		if (crtc_hung =3D=3D 0)
> -			return false;
> -		udelay(100);
> -	}
> -
> -	return true;
> -}
> -
> -static void dce_v11_0_set_vga_render_state(struct amdgpu_device
> *adev,
> -					=C2=A0=C2=A0 bool render)
> -{
> -	u32 tmp;
> -
> -	/* Lockout access through VGA aperture*/
> -	tmp =3D RREG32(mmVGA_HDP_CONTROL);
> -	if (render)
> -		tmp =3D REG_SET_FIELD(tmp, VGA_HDP_CONTROL,
> VGA_MEMORY_DISABLE, 0);
> -	else
> -		tmp =3D REG_SET_FIELD(tmp, VGA_HDP_CONTROL,
> VGA_MEMORY_DISABLE, 1);
> -	WREG32(mmVGA_HDP_CONTROL, tmp);
> -
> -	/* disable VGA render */
> -	tmp =3D RREG32(mmVGA_RENDER_CONTROL);
> -	if (render)
> -		tmp =3D REG_SET_FIELD(tmp, VGA_RENDER_CONTROL,
> VGA_VSTATUS_CNTL, 1);
> -	else
> -		tmp =3D REG_SET_FIELD(tmp, VGA_RENDER_CONTROL,
> VGA_VSTATUS_CNTL, 0);
> -	WREG32(mmVGA_RENDER_CONTROL, tmp);
> -}
> -
> -static int dce_v11_0_get_num_crtc (struct amdgpu_device *adev)
> -{
> -	int num_crtc =3D 0;
> -
> -	switch (adev->asic_type) {
> -	case CHIP_CARRIZO:
> -		num_crtc =3D 3;
> -		break;
> -	case CHIP_STONEY:
> -		num_crtc =3D 2;
> -		break;
> -	case CHIP_POLARIS10:
> -	case CHIP_VEGAM:
> -		num_crtc =3D 6;
> -		break;
> -	case CHIP_POLARIS11:
> -	case CHIP_POLARIS12:
> -		num_crtc =3D 5;
> -		break;
> -	default:
> -		num_crtc =3D 0;
> -	}
> -	return num_crtc;
> -}
> -
> -void dce_v11_0_disable_dce(struct amdgpu_device *adev)
> -{
> -	/*Disable VGA render and enabled crtc, if has DCE engine*/
> -	if (amdgpu_atombios_has_dce_engine_info(adev)) {
> -		u32 tmp;
> -		int crtc_enabled, i;
> -
> -		dce_v11_0_set_vga_render_state(adev, false);
> -
> -		/*Disable crtc*/
> -		for (i =3D 0; i < dce_v11_0_get_num_crtc(adev); i++) {
> -			crtc_enabled =3D
> REG_GET_FIELD(RREG32(mmCRTC_CONTROL + crtc_offsets[i]),
> -
> 									 CRTC_CONTROL, CRTC_MASTER_EN);
> -			if (crtc_enabled) {
> -				WREG32(mmCRTC_UPDATE_LOCK +
> crtc_offsets[i], 1);
> -				tmp =3D RREG32(mmCRTC_CONTROL +
> crtc_offsets[i]);
> -				tmp =3D REG_SET_FIELD(tmp,
> CRTC_CONTROL, CRTC_MASTER_EN, 0);
> -				WREG32(mmCRTC_CONTROL +
> crtc_offsets[i], tmp);
> -				WREG32(mmCRTC_UPDATE_LOCK +
> crtc_offsets[i], 0);
> -			}
> -		}
> -	}
> -}
> -
> -static void dce_v11_0_program_fmt(struct drm_encoder *encoder)
> -{
> -	struct drm_device *dev =3D encoder->dev;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> -	struct amdgpu_encoder *amdgpu_encoder =3D
> to_amdgpu_encoder(encoder);
> -	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(encoder-
> >crtc);
> -	struct drm_connector *connector =3D
> amdgpu_get_connector_for_encoder(encoder);
> -	int bpc =3D 0;
> -	u32 tmp =3D 0;
> -	enum amdgpu_connector_dither dither =3D
> AMDGPU_FMT_DITHER_DISABLE;
> -
> -	if (connector) {
> -		struct amdgpu_connector *amdgpu_connector =3D
> to_amdgpu_connector(connector);
> -		bpc =3D amdgpu_connector_get_monitor_bpc(connector);
> -		dither =3D amdgpu_connector->dither;
> -	}
> -
> -	/* LVDS/eDP FMT is set up by atom */
> -	if (amdgpu_encoder->devices & ATOM_DEVICE_LCD_SUPPORT)
> -		return;
> -
> -	/* not needed for analog */
> -	if ((amdgpu_encoder->encoder_id =3D=3D
> ENCODER_OBJECT_ID_INTERNAL_KLDSCP_DAC1) ||
> -	=C2=A0=C2=A0=C2=A0 (amdgpu_encoder->encoder_id =3D=3D
> ENCODER_OBJECT_ID_INTERNAL_KLDSCP_DAC2))
> -		return;
> -
> -	if (bpc =3D=3D 0)
> -		return;
> -
> -	switch (bpc) {
> -	case 6:
> -		if (dither =3D=3D AMDGPU_FMT_DITHER_ENABLE) {
> -			/* XXX sort out optimal dither settings */
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_FRAME_RANDOM_ENABLE, 1);
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_HIGHPASS_RANDOM_ENABLE, 1);
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_SPATIAL_DITHER_EN, 1);
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_SPATIAL_DITHER_DEPTH, 0);
> -		} else {
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_TRUNCATE_EN, 1);
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_TRUNCATE_DEPTH, 0);
> -		}
> -		break;
> -	case 8:
> -		if (dither =3D=3D AMDGPU_FMT_DITHER_ENABLE) {
> -			/* XXX sort out optimal dither settings */
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_FRAME_RANDOM_ENABLE, 1);
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_HIGHPASS_RANDOM_ENABLE, 1);
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_RGB_RANDOM_ENABLE, 1);
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_SPATIAL_DITHER_EN, 1);
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_SPATIAL_DITHER_DEPTH, 1);
> -		} else {
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_TRUNCATE_EN, 1);
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_TRUNCATE_DEPTH, 1);
> -		}
> -		break;
> -	case 10:
> -		if (dither =3D=3D AMDGPU_FMT_DITHER_ENABLE) {
> -			/* XXX sort out optimal dither settings */
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_FRAME_RANDOM_ENABLE, 1);
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_HIGHPASS_RANDOM_ENABLE, 1);
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_RGB_RANDOM_ENABLE, 1);
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_SPATIAL_DITHER_EN, 1);
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_SPATIAL_DITHER_DEPTH, 2);
> -		} else {
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_TRUNCATE_EN, 1);
> -			tmp =3D REG_SET_FIELD(tmp,
> FMT_BIT_DEPTH_CONTROL, FMT_TRUNCATE_DEPTH, 2);
> -		}
> -		break;
> -	default:
> -		/* not needed */
> -		break;
> -	}
> -
> -	WREG32(mmFMT_BIT_DEPTH_CONTROL + amdgpu_crtc->crtc_offset,
> tmp);
> -}
> -
> -
> -/* display watermark setup */
> -/**
> - * dce_v11_0_line_buffer_adjust - Set up the line buffer
> - *
> - * @adev: amdgpu_device pointer
> - * @amdgpu_crtc: the selected display controller
> - * @mode: the current display mode on the selected display
> - * controller
> - *
> - * Setup up the line buffer allocation for
> - * the selected display controller (CIK).
> - * Returns the line buffer size in pixels.
> - */
> -static u32 dce_v11_0_line_buffer_adjust(struct amdgpu_device *adev,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_crtc
> *amdgpu_crtc,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_display_mode
> *mode)
> -{
> -	u32 tmp, buffer_alloc, i, mem_cfg;
> -	u32 pipe_offset =3D amdgpu_crtc->crtc_id;
> -	/*
> -	 * Line Buffer Setup
> -	 * There are 6 line buffers, one for each display
> controllers.
> -	 * There are 3 partitions per LB. Select the number of
> partitions
> -	 * to enable based on the display width.=C2=A0 For display widths
> larger
> -	 * than 4096, you need use to use 2 display controllers and
> combine
> -	 * them using the stereo blender.
> -	 */
> -	if (amdgpu_crtc->base.enabled && mode) {
> -		if (mode->crtc_hdisplay < 1920) {
> -			mem_cfg =3D 1;
> -			buffer_alloc =3D 2;
> -		} else if (mode->crtc_hdisplay < 2560) {
> -			mem_cfg =3D 2;
> -			buffer_alloc =3D 2;
> -		} else if (mode->crtc_hdisplay < 4096) {
> -			mem_cfg =3D 0;
> -			buffer_alloc =3D (adev->flags & AMD_IS_APU) ?
> 2 : 4;
> -		} else {
> -			DRM_DEBUG_KMS("Mode too big for LB!\n");
> -			mem_cfg =3D 0;
> -			buffer_alloc =3D (adev->flags & AMD_IS_APU) ?
> 2 : 4;
> -		}
> -	} else {
> -		mem_cfg =3D 1;
> -		buffer_alloc =3D 0;
> -	}
> -
> -	tmp =3D RREG32(mmLB_MEMORY_CTRL + amdgpu_crtc->crtc_offset);
> -	tmp =3D REG_SET_FIELD(tmp, LB_MEMORY_CTRL, LB_MEMORY_CONFIG,
> mem_cfg);
> -	WREG32(mmLB_MEMORY_CTRL + amdgpu_crtc->crtc_offset, tmp);
> -
> -	tmp =3D RREG32(mmPIPE0_DMIF_BUFFER_CONTROL + pipe_offset);
> -	tmp =3D REG_SET_FIELD(tmp, PIPE0_DMIF_BUFFER_CONTROL,
> DMIF_BUFFERS_ALLOCATED, buffer_alloc);
> -	WREG32(mmPIPE0_DMIF_BUFFER_CONTROL + pipe_offset, tmp);
> -
> -	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		tmp =3D RREG32(mmPIPE0_DMIF_BUFFER_CONTROL +
> pipe_offset);
> -		if (REG_GET_FIELD(tmp, PIPE0_DMIF_BUFFER_CONTROL,
> DMIF_BUFFERS_ALLOCATION_COMPLETED))
> -			break;
> -		udelay(1);
> -	}
> -
> -	if (amdgpu_crtc->base.enabled && mode) {
> -		switch (mem_cfg) {
> -		case 0:
> -		default:
> -			return 4096 * 2;
> -		case 1:
> -			return 1920 * 2;
> -		case 2:
> -			return 2560 * 2;
> -		}
> -	}
> -
> -	/* controller not enabled, so no lb used */
> -	return 0;
> -}
> -
> -/**
> - * cik_get_number_of_dram_channels - get the number of dram channels
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Look up the number of video ram channels (CIK).
> - * Used for display watermark bandwidth calculations
> - * Returns the number of dram channels
> - */
> -static u32 cik_get_number_of_dram_channels(struct amdgpu_device
> *adev)
> -{
> -	u32 tmp =3D RREG32(mmMC_SHARED_CHMAP);
> -
> -	switch (REG_GET_FIELD(tmp, MC_SHARED_CHMAP, NOOFCHAN)) {
> -	case 0:
> -	default:
> -		return 1;
> -	case 1:
> -		return 2;
> -	case 2:
> -		return 4;
> -	case 3:
> -		return 8;
> -	case 4:
> -		return 3;
> -	case 5:
> -		return 6;
> -	case 6:
> -		return 10;
> -	case 7:
> -		return 12;
> -	case 8:
> -		return 16;
> -	}
> -}
> -
> -struct dce10_wm_params {
> -	u32 dram_channels; /* number of dram channels */
> -	u32 yclk;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* band=
width per dram data pin in kHz */
> -	u32 sclk;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* engi=
ne clock in kHz */
> -	u32 disp_clk;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* display clock in kHz */
> -	u32 src_width;=C2=A0=C2=A0=C2=A0=C2=A0 /* viewport width */
> -	u32 active_time;=C2=A0=C2=A0 /* active display time in ns */
> -	u32 blank_time;=C2=A0=C2=A0=C2=A0 /* blank time in ns */
> -	bool interlaced;=C2=A0=C2=A0=C2=A0 /* mode is interlaced */
> -	fixed20_12 vsc;=C2=A0=C2=A0=C2=A0 /* vertical scale ratio */
> -	u32 num_heads;=C2=A0=C2=A0=C2=A0=C2=A0 /* number of active crtcs */
> -	u32 bytes_per_pixel; /* bytes per pixel display + overlay */
> -	u32 lb_size;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* line buffer allocat=
ed to pipe */
> -	u32 vtaps;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* vertical =
scaler taps */
> -};
> -
> -/**
> - * dce_v11_0_dram_bandwidth - get the dram bandwidth
> - *
> - * @wm: watermark calculation data
> - *
> - * Calculate the raw dram bandwidth (CIK).
> - * Used for display watermark bandwidth calculations
> - * Returns the dram bandwidth in MBytes/s
> - */
> -static u32 dce_v11_0_dram_bandwidth(struct dce10_wm_params *wm)
> -{
> -	/* Calculate raw DRAM Bandwidth */
> -	fixed20_12 dram_efficiency; /* 0.7 */
> -	fixed20_12 yclk, dram_channels, bandwidth;
> -	fixed20_12 a;
> -
> -	a.full =3D dfixed_const(1000);
> -	yclk.full =3D dfixed_const(wm->yclk);
> -	yclk.full =3D dfixed_div(yclk, a);
> -	dram_channels.full =3D dfixed_const(wm->dram_channels * 4);
> -	a.full =3D dfixed_const(10);
> -	dram_efficiency.full =3D dfixed_const(7);
> -	dram_efficiency.full =3D dfixed_div(dram_efficiency, a);
> -	bandwidth.full =3D dfixed_mul(dram_channels, yclk);
> -	bandwidth.full =3D dfixed_mul(bandwidth, dram_efficiency);
> -
> -	return dfixed_trunc(bandwidth);
> -}
> -
> -/**
> - * dce_v11_0_dram_bandwidth_for_display - get the dram bandwidth for
> display
> - *
> - * @wm: watermark calculation data
> - *
> - * Calculate the dram bandwidth used for display (CIK).
> - * Used for display watermark bandwidth calculations
> - * Returns the dram bandwidth for display in MBytes/s
> - */
> -static u32 dce_v11_0_dram_bandwidth_for_display(struct
> dce10_wm_params *wm)
> -{
> -	/* Calculate DRAM Bandwidth and the part allocated to
> display. */
> -	fixed20_12 disp_dram_allocation; /* 0.3 to 0.7 */
> -	fixed20_12 yclk, dram_channels, bandwidth;
> -	fixed20_12 a;
> -
> -	a.full =3D dfixed_const(1000);
> -	yclk.full =3D dfixed_const(wm->yclk);
> -	yclk.full =3D dfixed_div(yclk, a);
> -	dram_channels.full =3D dfixed_const(wm->dram_channels * 4);
> -	a.full =3D dfixed_const(10);
> -	disp_dram_allocation.full =3D dfixed_const(3); /* XXX worse
> case value 0.3 */
> -	disp_dram_allocation.full =3D dfixed_div(disp_dram_allocation,
> a);
> -	bandwidth.full =3D dfixed_mul(dram_channels, yclk);
> -	bandwidth.full =3D dfixed_mul(bandwidth,
> disp_dram_allocation);
> -
> -	return dfixed_trunc(bandwidth);
> -}
> -
> -/**
> - * dce_v11_0_data_return_bandwidth - get the data return bandwidth
> - *
> - * @wm: watermark calculation data
> - *
> - * Calculate the data return bandwidth used for display (CIK).
> - * Used for display watermark bandwidth calculations
> - * Returns the data return bandwidth in MBytes/s
> - */
> -static u32 dce_v11_0_data_return_bandwidth(struct dce10_wm_params
> *wm)
> -{
> -	/* Calculate the display Data return Bandwidth */
> -	fixed20_12 return_efficiency; /* 0.8 */
> -	fixed20_12 sclk, bandwidth;
> -	fixed20_12 a;
> -
> -	a.full =3D dfixed_const(1000);
> -	sclk.full =3D dfixed_const(wm->sclk);
> -	sclk.full =3D dfixed_div(sclk, a);
> -	a.full =3D dfixed_const(10);
> -	return_efficiency.full =3D dfixed_const(8);
> -	return_efficiency.full =3D dfixed_div(return_efficiency, a);
> -	a.full =3D dfixed_const(32);
> -	bandwidth.full =3D dfixed_mul(a, sclk);
> -	bandwidth.full =3D dfixed_mul(bandwidth, return_efficiency);
> -
> -	return dfixed_trunc(bandwidth);
> -}
> -
> -/**
> - * dce_v11_0_dmif_request_bandwidth - get the dmif bandwidth
> - *
> - * @wm: watermark calculation data
> - *
> - * Calculate the dmif bandwidth used for display (CIK).
> - * Used for display watermark bandwidth calculations
> - * Returns the dmif bandwidth in MBytes/s
> - */
> -static u32 dce_v11_0_dmif_request_bandwidth(struct dce10_wm_params
> *wm)
> -{
> -	/* Calculate the DMIF Request Bandwidth */
> -	fixed20_12 disp_clk_request_efficiency; /* 0.8 */
> -	fixed20_12 disp_clk, bandwidth;
> -	fixed20_12 a, b;
> -
> -	a.full =3D dfixed_const(1000);
> -	disp_clk.full =3D dfixed_const(wm->disp_clk);
> -	disp_clk.full =3D dfixed_div(disp_clk, a);
> -	a.full =3D dfixed_const(32);
> -	b.full =3D dfixed_mul(a, disp_clk);
> -
> -	a.full =3D dfixed_const(10);
> -	disp_clk_request_efficiency.full =3D dfixed_const(8);
> -	disp_clk_request_efficiency.full =3D
> dfixed_div(disp_clk_request_efficiency, a);
> -
> -	bandwidth.full =3D dfixed_mul(b, disp_clk_request_efficiency);
> -
> -	return dfixed_trunc(bandwidth);
> -}
> -
> -/**
> - * dce_v11_0_available_bandwidth - get the min available bandwidth
> - *
> - * @wm: watermark calculation data
> - *
> - * Calculate the min available bandwidth used for display (CIK).
> - * Used for display watermark bandwidth calculations
> - * Returns the min available bandwidth in MBytes/s
> - */
> -static u32 dce_v11_0_available_bandwidth(struct dce10_wm_params *wm)
> -{
> -	/* Calculate the Available bandwidth. Display can use this
> temporarily but not in average. */
> -	u32 dram_bandwidth =3D dce_v11_0_dram_bandwidth(wm);
> -	u32 data_return_bandwidth =3D
> dce_v11_0_data_return_bandwidth(wm);
> -	u32 dmif_req_bandwidth =3D
> dce_v11_0_dmif_request_bandwidth(wm);
> -
> -	return min(dram_bandwidth, min(data_return_bandwidth,
> dmif_req_bandwidth));
> -}
> -
> -/**
> - * dce_v11_0_average_bandwidth - get the average available bandwidth
> - *
> - * @wm: watermark calculation data
> - *
> - * Calculate the average available bandwidth used for display (CIK).
> - * Used for display watermark bandwidth calculations
> - * Returns the average available bandwidth in MBytes/s
> - */
> -static u32 dce_v11_0_average_bandwidth(struct dce10_wm_params *wm)
> -{
> -	/* Calculate the display mode Average Bandwidth
> -	 * DisplayMode should contain the source and destination
> dimensions,
> -	 * timing, etc.
> -	 */
> -	fixed20_12 bpp;
> -	fixed20_12 line_time;
> -	fixed20_12 src_width;
> -	fixed20_12 bandwidth;
> -	fixed20_12 a;
> -
> -	a.full =3D dfixed_const(1000);
> -	line_time.full =3D dfixed_const(wm->active_time + wm-
> >blank_time);
> -	line_time.full =3D dfixed_div(line_time, a);
> -	bpp.full =3D dfixed_const(wm->bytes_per_pixel);
> -	src_width.full =3D dfixed_const(wm->src_width);
> -	bandwidth.full =3D dfixed_mul(src_width, bpp);
> -	bandwidth.full =3D dfixed_mul(bandwidth, wm->vsc);
> -	bandwidth.full =3D dfixed_div(bandwidth, line_time);
> -
> -	return dfixed_trunc(bandwidth);
> -}
> -
> -/**
> - * dce_v11_0_latency_watermark - get the latency watermark
> - *
> - * @wm: watermark calculation data
> - *
> - * Calculate the latency watermark (CIK).
> - * Used for display watermark bandwidth calculations
> - * Returns the latency watermark in ns
> - */
> -static u32 dce_v11_0_latency_watermark(struct dce10_wm_params *wm)
> -{
> -	/* First calculate the latency in ns */
> -	u32 mc_latency =3D 2000; /* 2000 ns. */
> -	u32 available_bandwidth =3D dce_v11_0_available_bandwidth(wm);
> -	u32 worst_chunk_return_time =3D (512 * 8 * 1000) /
> available_bandwidth;
> -	u32 cursor_line_pair_return_time =3D (128 * 4 * 1000) /
> available_bandwidth;
> -	u32 dc_latency =3D 40000000 / wm->disp_clk; /* dc pipe latency
> */
> -	u32 other_heads_data_return_time =3D ((wm->num_heads + 1) *
> worst_chunk_return_time) +
> -		(wm->num_heads * cursor_line_pair_return_time);
> -	u32 latency =3D mc_latency + other_heads_data_return_time +
> dc_latency;
> -	u32 max_src_lines_per_dst_line, lb_fill_bw, line_fill_time;
> -	u32 tmp, dmif_size =3D 12288;
> -	fixed20_12 a, b, c;
> -
> -	if (wm->num_heads =3D=3D 0)
> -		return 0;
> -
> -	a.full =3D dfixed_const(2);
> -	b.full =3D dfixed_const(1);
> -	if ((wm->vsc.full > a.full) ||
> -	=C2=A0=C2=A0=C2=A0 ((wm->vsc.full > b.full) && (wm->vtaps >=3D 3)) ||
> -	=C2=A0=C2=A0=C2=A0 (wm->vtaps >=3D 5) ||
> -	=C2=A0=C2=A0=C2=A0 ((wm->vsc.full >=3D a.full) && wm->interlaced))
> -		max_src_lines_per_dst_line =3D 4;
> -	else
> -		max_src_lines_per_dst_line =3D 2;
> -
> -	a.full =3D dfixed_const(available_bandwidth);
> -	b.full =3D dfixed_const(wm->num_heads);
> -	a.full =3D dfixed_div(a, b);
> -	tmp =3D div_u64((u64) dmif_size * (u64) wm->disp_clk,
> mc_latency + 512);
> -	tmp =3D min(dfixed_trunc(a), tmp);
> -
> -	lb_fill_bw =3D min(tmp, wm->disp_clk * wm->bytes_per_pixel /
> 1000);
> -
> -	a.full =3D dfixed_const(max_src_lines_per_dst_line * wm-
> >src_width * wm->bytes_per_pixel);
> -	b.full =3D dfixed_const(1000);
> -	c.full =3D dfixed_const(lb_fill_bw);
> -	b.full =3D dfixed_div(c, b);
> -	a.full =3D dfixed_div(a, b);
> -	line_fill_time =3D dfixed_trunc(a);
> -
> -	if (line_fill_time < wm->active_time)
> -		return latency;
> -	else
> -		return latency + (line_fill_time - wm->active_time);
> -
> -}
> -
> -/**
> - * dce_v11_0_average_bandwidth_vs_dram_bandwidth_for_display - check
> - * average and available dram bandwidth
> - *
> - * @wm: watermark calculation data
> - *
> - * Check if the display average bandwidth fits in the display
> - * dram bandwidth (CIK).
> - * Used for display watermark bandwidth calculations
> - * Returns true if the display fits, false if not.
> - */
> -static bool
> dce_v11_0_average_bandwidth_vs_dram_bandwidth_for_display(struct
> dce10_wm_params *wm)
> -{
> -	if (dce_v11_0_average_bandwidth(wm) <=3D
> -	=C2=A0=C2=A0=C2=A0 (dce_v11_0_dram_bandwidth_for_display(wm) / wm-
> >num_heads))
> -		return true;
> -	else
> -		return false;
> -}
> -
> -/**
> - * dce_v11_0_average_bandwidth_vs_available_bandwidth - check
> - * average and available bandwidth
> - *
> - * @wm: watermark calculation data
> - *
> - * Check if the display average bandwidth fits in the display
> - * available bandwidth (CIK).
> - * Used for display watermark bandwidth calculations
> - * Returns true if the display fits, false if not.
> - */
> -static bool
> dce_v11_0_average_bandwidth_vs_available_bandwidth(struct
> dce10_wm_params *wm)
> -{
> -	if (dce_v11_0_average_bandwidth(wm) <=3D
> -	=C2=A0=C2=A0=C2=A0 (dce_v11_0_available_bandwidth(wm) / wm->num_heads))
> -		return true;
> -	else
> -		return false;
> -}
> -
> -/**
> - * dce_v11_0_check_latency_hiding - check latency hiding
> - *
> - * @wm: watermark calculation data
> - *
> - * Check latency hiding (CIK).
> - * Used for display watermark bandwidth calculations
> - * Returns true if the display fits, false if not.
> - */
> -static bool dce_v11_0_check_latency_hiding(struct dce10_wm_params
> *wm)
> -{
> -	u32 lb_partitions =3D wm->lb_size / wm->src_width;
> -	u32 line_time =3D wm->active_time + wm->blank_time;
> -	u32 latency_tolerant_lines;
> -	u32 latency_hiding;
> -	fixed20_12 a;
> -
> -	a.full =3D dfixed_const(1);
> -	if (wm->vsc.full > a.full)
> -		latency_tolerant_lines =3D 1;
> -	else {
> -		if (lb_partitions <=3D (wm->vtaps + 1))
> -			latency_tolerant_lines =3D 1;
> -		else
> -			latency_tolerant_lines =3D 2;
> -	}
> -
> -	latency_hiding =3D (latency_tolerant_lines * line_time + wm-
> >blank_time);
> -
> -	if (dce_v11_0_latency_watermark(wm) <=3D latency_hiding)
> -		return true;
> -	else
> -		return false;
> -}
> -
> -/**
> - * dce_v11_0_program_watermarks - program display watermarks
> - *
> - * @adev: amdgpu_device pointer
> - * @amdgpu_crtc: the selected display controller
> - * @lb_size: line buffer size
> - * @num_heads: number of display controllers in use
> - *
> - * Calculate and program the display watermarks for the
> - * selected display controller (CIK).
> - */
> -static void dce_v11_0_program_watermarks(struct amdgpu_device *adev,
> -					struct amdgpu_crtc
> *amdgpu_crtc,
> -					u32 lb_size, u32 num_heads)
> -{
> -	struct drm_display_mode *mode =3D &amdgpu_crtc->base.mode;
> -	struct dce10_wm_params wm_low, wm_high;
> -	u32 active_time;
> -	u32 line_time =3D 0;
> -	u32 latency_watermark_a =3D 0, latency_watermark_b =3D 0;
> -	u32 tmp, wm_mask, lb_vblank_lead_lines =3D 0;
> -
> -	if (amdgpu_crtc->base.enabled && num_heads && mode) {
> -		active_time =3D (u32) div_u64((u64)mode->crtc_hdisplay
> * 1000000,
> -					=C2=A0=C2=A0=C2=A0 (u32)mode->clock);
> -		line_time =3D (u32) div_u64((u64)mode->crtc_htotal *
> 1000000,
> -					=C2=A0 (u32)mode->clock);
> -		line_time =3D min_t(u32, line_time, 65535);
> -
> -		/* watermark for high clocks */
> -		if (adev->pm.dpm_enabled) {
> -			wm_high.yclk =3D
> -				amdgpu_dpm_get_mclk(adev, false) *
> 10;
> -			wm_high.sclk =3D
> -				amdgpu_dpm_get_sclk(adev, false) *
> 10;
> -		} else {
> -			wm_high.yclk =3D adev->pm.current_mclk * 10;
> -			wm_high.sclk =3D adev->pm.current_sclk * 10;
> -		}
> -
> -		wm_high.disp_clk =3D mode->clock;
> -		wm_high.src_width =3D mode->crtc_hdisplay;
> -		wm_high.active_time =3D active_time;
> -		wm_high.blank_time =3D line_time -
> wm_high.active_time;
> -		wm_high.interlaced =3D false;
> -		if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> -			wm_high.interlaced =3D true;
> -		wm_high.vsc =3D amdgpu_crtc->vsc;
> -		wm_high.vtaps =3D 1;
> -		if (amdgpu_crtc->rmx_type !=3D RMX_OFF)
> -			wm_high.vtaps =3D 2;
> -		wm_high.bytes_per_pixel =3D 4; /* XXX: get this from
> fb config */
> -		wm_high.lb_size =3D lb_size;
> -		wm_high.dram_channels =3D
> cik_get_number_of_dram_channels(adev);
> -		wm_high.num_heads =3D num_heads;
> -
> -		/* set for high clocks */
> -		latency_watermark_a =3D min_t(u32,
> dce_v11_0_latency_watermark(&wm_high), 65535);
> -
> -		/* possibly force display priority to high */
> -		/* should really do this at mode validation time...
> */
> -		if
> (!dce_v11_0_average_bandwidth_vs_dram_bandwidth_for_display(&wm_high)
> ||
> -		=C2=A0=C2=A0=C2=A0
> !dce_v11_0_average_bandwidth_vs_available_bandwidth(&wm_high) ||
> -		=C2=A0=C2=A0=C2=A0 !dce_v11_0_check_latency_hiding(&wm_high) ||
> -		=C2=A0=C2=A0=C2=A0 (adev->mode_info.disp_priority =3D=3D 2)) {
> -			DRM_DEBUG_KMS("force priority to high\n");
> -		}
> -
> -		/* watermark for low clocks */
> -		if (adev->pm.dpm_enabled) {
> -			wm_low.yclk =3D
> -				amdgpu_dpm_get_mclk(adev, true) *
> 10;
> -			wm_low.sclk =3D
> -				amdgpu_dpm_get_sclk(adev, true) *
> 10;
> -		} else {
> -			wm_low.yclk =3D adev->pm.current_mclk * 10;
> -			wm_low.sclk =3D adev->pm.current_sclk * 10;
> -		}
> -
> -		wm_low.disp_clk =3D mode->clock;
> -		wm_low.src_width =3D mode->crtc_hdisplay;
> -		wm_low.active_time =3D active_time;
> -		wm_low.blank_time =3D line_time - wm_low.active_time;
> -		wm_low.interlaced =3D false;
> -		if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> -			wm_low.interlaced =3D true;
> -		wm_low.vsc =3D amdgpu_crtc->vsc;
> -		wm_low.vtaps =3D 1;
> -		if (amdgpu_crtc->rmx_type !=3D RMX_OFF)
> -			wm_low.vtaps =3D 2;
> -		wm_low.bytes_per_pixel =3D 4; /* XXX: get this from fb
> config */
> -		wm_low.lb_size =3D lb_size;
> -		wm_low.dram_channels =3D
> cik_get_number_of_dram_channels(adev);
> -		wm_low.num_heads =3D num_heads;
> -
> -		/* set for low clocks */
> -		latency_watermark_b =3D min_t(u32,
> dce_v11_0_latency_watermark(&wm_low), 65535);
> -
> -		/* possibly force display priority to high */
> -		/* should really do this at mode validation time...
> */
> -		if
> (!dce_v11_0_average_bandwidth_vs_dram_bandwidth_for_display(&wm_low)
> ||
> -		=C2=A0=C2=A0=C2=A0
> !dce_v11_0_average_bandwidth_vs_available_bandwidth(&wm_low) ||
> -		=C2=A0=C2=A0=C2=A0 !dce_v11_0_check_latency_hiding(&wm_low) ||
> -		=C2=A0=C2=A0=C2=A0 (adev->mode_info.disp_priority =3D=3D 2)) {
> -			DRM_DEBUG_KMS("force priority to high\n");
> -		}
> -		lb_vblank_lead_lines =3D DIV_ROUND_UP(lb_size, mode-
> >crtc_hdisplay);
> -	}
> -
> -	/* select wm A */
> -	wm_mask =3D RREG32(mmDPG_WATERMARK_MASK_CONTROL + amdgpu_crtc-
> >crtc_offset);
> -	tmp =3D REG_SET_FIELD(wm_mask, DPG_WATERMARK_MASK_CONTROL,
> URGENCY_WATERMARK_MASK, 1);
> -	WREG32(mmDPG_WATERMARK_MASK_CONTROL + amdgpu_crtc-
> >crtc_offset, tmp);
> -	tmp =3D RREG32(mmDPG_PIPE_URGENCY_CONTROL + amdgpu_crtc-
> >crtc_offset);
> -	tmp =3D REG_SET_FIELD(tmp, DPG_PIPE_URGENCY_CONTROL,
> URGENCY_LOW_WATERMARK, latency_watermark_a);
> -	tmp =3D REG_SET_FIELD(tmp, DPG_PIPE_URGENCY_CONTROL,
> URGENCY_HIGH_WATERMARK, line_time);
> -	WREG32(mmDPG_PIPE_URGENCY_CONTROL + amdgpu_crtc-
> >crtc_offset, tmp);
> -	/* select wm B */
> -	tmp =3D REG_SET_FIELD(wm_mask, DPG_WATERMARK_MASK_CONTROL,
> URGENCY_WATERMARK_MASK, 2);
> -	WREG32(mmDPG_WATERMARK_MASK_CONTROL + amdgpu_crtc-
> >crtc_offset, tmp);
> -	tmp =3D RREG32(mmDPG_PIPE_URGENCY_CONTROL + amdgpu_crtc-
> >crtc_offset);
> -	tmp =3D REG_SET_FIELD(tmp, DPG_PIPE_URGENCY_CONTROL,
> URGENCY_LOW_WATERMARK, latency_watermark_b);
> -	tmp =3D REG_SET_FIELD(tmp, DPG_PIPE_URGENCY_CONTROL,
> URGENCY_HIGH_WATERMARK, line_time);
> -	WREG32(mmDPG_PIPE_URGENCY_CONTROL + amdgpu_crtc-
> >crtc_offset, tmp);
> -	/* restore original selection */
> -	WREG32(mmDPG_WATERMARK_MASK_CONTROL + amdgpu_crtc-
> >crtc_offset, wm_mask);
> -
> -	/* save values for DPM */
> -	amdgpu_crtc->line_time =3D line_time;
> -
> -	/* Save number of lines the linebuffer leads before the
> scanout */
> -	amdgpu_crtc->lb_vblank_lead_lines =3D lb_vblank_lead_lines;
> -}
> -
> -/**
> - * dce_v11_0_bandwidth_update - program display watermarks
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Calculate and program the display watermarks and line
> - * buffer allocation (CIK).
> - */
> -static void dce_v11_0_bandwidth_update(struct amdgpu_device *adev)
> -{
> -	struct drm_display_mode *mode =3D NULL;
> -	u32 num_heads =3D 0, lb_size;
> -	int i;
> -
> -	amdgpu_display_update_priority(adev);
> -
> -	for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> -		if (adev->mode_info.crtcs[i]->base.enabled)
> -			num_heads++;
> -	}
> -	for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> -		mode =3D &adev->mode_info.crtcs[i]->base.mode;
> -		lb_size =3D dce_v11_0_line_buffer_adjust(adev, adev-
> >mode_info.crtcs[i], mode);
> -		dce_v11_0_program_watermarks(adev, adev-
> >mode_info.crtcs[i],
> -					=C2=A0=C2=A0=C2=A0 lb_size, num_heads);
> -	}
> -}
> -
> -static void dce_v11_0_audio_get_connected_pins(struct amdgpu_device
> *adev)
> -{
> -	int i;
> -	u32 offset, tmp;
> -
> -	for (i =3D 0; i < adev->mode_info.audio.num_pins; i++) {
> -		offset =3D adev->mode_info.audio.pin[i].offset;
> -		tmp =3D RREG32_AUDIO_ENDPT(offset,
> -				=09
> ixAZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_CONFIGURATION_DEFAULT);
> -		if (((tmp &
> -
> 		AZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_CONFIGURATION_DEFAULT__PORT_CONNEC=
TIVITY_MASK)>>
> -
> 		AZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_CONFIGURATION_DEFAULT__PORT_CONNEC=
TIVITY__SHIFT)=3D=3D1)
> -			adev->mode_info.audio.pin[i].connected =3D
> false;
> -		else
> -			adev->mode_info.audio.pin[i].connected =3D
> true;
> -	}
> -}
> -
> -static struct amdgpu_audio_pin *dce_v11_0_audio_get_pin(struct
> amdgpu_device *adev)
> -{
> -	int i;
> -
> -	dce_v11_0_audio_get_connected_pins(adev);
> -
> -	for (i =3D 0; i < adev->mode_info.audio.num_pins; i++) {
> -		if (adev->mode_info.audio.pin[i].connected)
> -			return &adev->mode_info.audio.pin[i];
> -	}
> -	DRM_ERROR("No connected audio pins found!\n");
> -	return NULL;
> -}
> -
> -static void dce_v11_0_afmt_audio_select_pin(struct drm_encoder
> *encoder)
> -{
> -	struct amdgpu_device *adev =3D drm_to_adev(encoder->dev);
> -	struct amdgpu_encoder *amdgpu_encoder =3D
> to_amdgpu_encoder(encoder);
> -	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder-
> >enc_priv;
> -	u32 tmp;
> -
> -	if (!dig || !dig->afmt || !dig->afmt->pin)
> -		return;
> -
> -	tmp =3D RREG32(mmAFMT_AUDIO_SRC_CONTROL + dig->afmt->offset);
> -	tmp =3D REG_SET_FIELD(tmp, AFMT_AUDIO_SRC_CONTROL,
> AFMT_AUDIO_SRC_SELECT, dig->afmt->pin->id);
> -	WREG32(mmAFMT_AUDIO_SRC_CONTROL + dig->afmt->offset, tmp);
> -}
> -
> -static void dce_v11_0_audio_write_latency_fields(struct drm_encoder
> *encoder,
> -						struct
> drm_display_mode *mode)
> -{
> -	struct drm_device *dev =3D encoder->dev;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> -	struct amdgpu_encoder *amdgpu_encoder =3D
> to_amdgpu_encoder(encoder);
> -	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder-
> >enc_priv;
> -	struct drm_connector *connector;
> -	struct drm_connector_list_iter iter;
> -	struct amdgpu_connector *amdgpu_connector =3D NULL;
> -	u32 tmp;
> -	int interlace =3D 0;
> -
> -	if (!dig || !dig->afmt || !dig->afmt->pin)
> -		return;
> -
> -	drm_connector_list_iter_begin(dev, &iter);
> -	drm_for_each_connector_iter(connector, &iter) {
> -		if (connector->encoder =3D=3D encoder) {
> -			amdgpu_connector =3D
> to_amdgpu_connector(connector);
> -			break;
> -		}
> -	}
> -	drm_connector_list_iter_end(&iter);
> -
> -	if (!amdgpu_connector) {
> -		DRM_ERROR("Couldn't find encoder's connector\n");
> -		return;
> -	}
> -
> -	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> -		interlace =3D 1;
> -	if (connector->latency_present[interlace]) {
> -		tmp =3D REG_SET_FIELD(0,
> AZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_LIPSYNC,
> -				=C2=A0=C2=A0=C2=A0 VIDEO_LIPSYNC, connector-
> >video_latency[interlace]);
> -		tmp =3D REG_SET_FIELD(0,
> AZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_LIPSYNC,
> -				=C2=A0=C2=A0=C2=A0 AUDIO_LIPSYNC, connector-
> >audio_latency[interlace]);
> -	} else {
> -		tmp =3D REG_SET_FIELD(0,
> AZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_LIPSYNC,
> -				=C2=A0=C2=A0=C2=A0 VIDEO_LIPSYNC, 0);
> -		tmp =3D REG_SET_FIELD(0,
> AZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_LIPSYNC,
> -				=C2=A0=C2=A0=C2=A0 AUDIO_LIPSYNC, 0);
> -	}
> -	WREG32_AUDIO_ENDPT(dig->afmt->pin->offset,
> -			=C2=A0=C2=A0
> ixAZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_LIPSYNC, tmp);
> -}
> -
> -static void dce_v11_0_audio_write_speaker_allocation(struct
> drm_encoder *encoder)
> -{
> -	struct drm_device *dev =3D encoder->dev;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> -	struct amdgpu_encoder *amdgpu_encoder =3D
> to_amdgpu_encoder(encoder);
> -	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder-
> >enc_priv;
> -	struct drm_connector *connector;
> -	struct drm_connector_list_iter iter;
> -	struct amdgpu_connector *amdgpu_connector =3D NULL;
> -	u32 tmp;
> -	u8 *sadb =3D NULL;
> -	int sad_count;
> -
> -	if (!dig || !dig->afmt || !dig->afmt->pin)
> -		return;
> -
> -	drm_connector_list_iter_begin(dev, &iter);
> -	drm_for_each_connector_iter(connector, &iter) {
> -		if (connector->encoder =3D=3D encoder) {
> -			amdgpu_connector =3D
> to_amdgpu_connector(connector);
> -			break;
> -		}
> -	}
> -	drm_connector_list_iter_end(&iter);
> -
> -	if (!amdgpu_connector) {
> -		DRM_ERROR("Couldn't find encoder's connector\n");
> -		return;
> -	}
> -
> -	sad_count =3D drm_edid_to_speaker_allocation(amdgpu_connector-
> >edid, &sadb);
> -	if (sad_count < 0) {
> -		DRM_ERROR("Couldn't read Speaker Allocation Data
> Block: %d\n", sad_count);
> -		sad_count =3D 0;
> -	}
> -
> -	/* program the speaker allocation */
> -	tmp =3D RREG32_AUDIO_ENDPT(dig->afmt->pin->offset,
> -			=09
> ixAZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKER);
> -	tmp =3D REG_SET_FIELD(tmp,
> AZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKER,
> -			=C2=A0=C2=A0=C2=A0 DP_CONNECTION, 0);
> -	/* set HDMI mode */
> -	tmp =3D REG_SET_FIELD(tmp,
> AZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKER,
> -			=C2=A0=C2=A0=C2=A0 HDMI_CONNECTION, 1);
> -	if (sad_count)
> -		tmp =3D REG_SET_FIELD(tmp,
> AZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKER,
> -				=C2=A0=C2=A0=C2=A0 SPEAKER_ALLOCATION, sadb[0]);
> -	else
> -		tmp =3D REG_SET_FIELD(tmp,
> AZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKER,
> -				=C2=A0=C2=A0=C2=A0 SPEAKER_ALLOCATION, 5); /*
> stereo */
> -	WREG32_AUDIO_ENDPT(dig->afmt->pin->offset,
> -			=C2=A0=C2=A0
> ixAZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKER, tmp);
> -
> -	kfree(sadb);
> -}
> -
> -static void dce_v11_0_audio_write_sad_regs(struct drm_encoder
> *encoder)
> -{
> -	struct drm_device *dev =3D encoder->dev;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> -	struct amdgpu_encoder *amdgpu_encoder =3D
> to_amdgpu_encoder(encoder);
> -	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder-
> >enc_priv;
> -	struct drm_connector *connector;
> -	struct drm_connector_list_iter iter;
> -	struct amdgpu_connector *amdgpu_connector =3D NULL;
> -	struct cea_sad *sads;
> -	int i, sad_count;
> -
> -	static const u16 eld_reg_to_type[][2] =3D {
> -		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0,
> HDMI_AUDIO_CODING_TYPE_PCM },
> -		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR1,
> HDMI_AUDIO_CODING_TYPE_AC3 },
> -		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR2,
> HDMI_AUDIO_CODING_TYPE_MPEG1 },
> -		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR3,
> HDMI_AUDIO_CODING_TYPE_MP3 },
> -		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR4,
> HDMI_AUDIO_CODING_TYPE_MPEG2 },
> -		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR5,
> HDMI_AUDIO_CODING_TYPE_AAC_LC },
> -		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR6,
> HDMI_AUDIO_CODING_TYPE_DTS },
> -		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR7,
> HDMI_AUDIO_CODING_TYPE_ATRAC },
> -		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR9,
> HDMI_AUDIO_CODING_TYPE_EAC3 },
> -		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR10,
> HDMI_AUDIO_CODING_TYPE_DTS_HD },
> -		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR11,
> HDMI_AUDIO_CODING_TYPE_MLP },
> -		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR13,
> HDMI_AUDIO_CODING_TYPE_WMA_PRO },
> -	};
> -
> -	if (!dig || !dig->afmt || !dig->afmt->pin)
> -		return;
> -
> -	drm_connector_list_iter_begin(dev, &iter);
> -	drm_for_each_connector_iter(connector, &iter) {
> -		if (connector->encoder =3D=3D encoder) {
> -			amdgpu_connector =3D
> to_amdgpu_connector(connector);
> -			break;
> -		}
> -	}
> -	drm_connector_list_iter_end(&iter);
> -
> -	if (!amdgpu_connector) {
> -		DRM_ERROR("Couldn't find encoder's connector\n");
> -		return;
> -	}
> -
> -	sad_count =3D drm_edid_to_sad(amdgpu_connector->edid, &sads);
> -	if (sad_count < 0)
> -		DRM_ERROR("Couldn't read SADs: %d\n", sad_count);
> -	if (sad_count <=3D 0)
> -		return;
> -	BUG_ON(!sads);
> -
> -	for (i =3D 0; i < ARRAY_SIZE(eld_reg_to_type); i++) {
> -		u32 tmp =3D 0;
> -		u8 stereo_freqs =3D 0;
> -		int max_channels =3D -1;
> -		int j;
> -
> -		for (j =3D 0; j < sad_count; j++) {
> -			struct cea_sad *sad =3D &sads[j];
> -
> -			if (sad->format =3D=3D eld_reg_to_type[i][1]) {
> -				if (sad->channels > max_channels) {
> -					tmp =3D REG_SET_FIELD(tmp,
> AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0,
> -							=C2=A0=C2=A0=C2=A0
> MAX_CHANNELS, sad->channels);
> -					tmp =3D REG_SET_FIELD(tmp,
> AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0,
> -							=C2=A0=C2=A0=C2=A0
> DESCRIPTOR_BYTE_2, sad->byte2);
> -					tmp =3D REG_SET_FIELD(tmp,
> AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0,
> -							=C2=A0=C2=A0=C2=A0
> SUPPORTED_FREQUENCIES, sad->freq);
> -					max_channels =3D sad-
> >channels;
> -				}
> -
> -				if (sad->format =3D=3D
> HDMI_AUDIO_CODING_TYPE_PCM)
> -					stereo_freqs |=3D sad->freq;
> -				else
> -					break;
> -			}
> -		}
> -
> -		tmp =3D REG_SET_FIELD(tmp,
> AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0,
> -				=C2=A0=C2=A0=C2=A0 SUPPORTED_FREQUENCIES_STEREO,
> stereo_freqs);
> -		WREG32_AUDIO_ENDPT(dig->afmt->pin->offset,
> eld_reg_to_type[i][0], tmp);
> -	}
> -
> -	kfree(sads);
> -}
> -
> -static void dce_v11_0_audio_enable(struct amdgpu_device *adev,
> -				=C2=A0 struct amdgpu_audio_pin *pin,
> -				=C2=A0 bool enable)
> -{
> -	if (!pin)
> -		return;
> -
> -	WREG32_AUDIO_ENDPT(pin->offset,
> ixAZALIA_F0_CODEC_PIN_CONTROL_HOT_PLUG_CONTROL,
> -			=C2=A0=C2=A0 enable ?
> AZALIA_F0_CODEC_PIN_CONTROL_HOT_PLUG_CONTROL__AUDIO_ENABLED_MASK :
> 0);
> -}
> -
> -static const u32 pin_offsets[] =3D
> -{
> -	AUD0_REGISTER_OFFSET,
> -	AUD1_REGISTER_OFFSET,
> -	AUD2_REGISTER_OFFSET,
> -	AUD3_REGISTER_OFFSET,
> -	AUD4_REGISTER_OFFSET,
> -	AUD5_REGISTER_OFFSET,
> -	AUD6_REGISTER_OFFSET,
> -	AUD7_REGISTER_OFFSET,
> -};
> -
> -static int dce_v11_0_audio_init(struct amdgpu_device *adev)
> -{
> -	int i;
> -
> -	if (!amdgpu_audio)
> -		return 0;
> -
> -	adev->mode_info.audio.enabled =3D true;
> -
> -	switch (adev->asic_type) {
> -	case CHIP_CARRIZO:
> -	case CHIP_STONEY:
> -		adev->mode_info.audio.num_pins =3D 7;
> -		break;
> -	case CHIP_POLARIS10:
> -	case CHIP_VEGAM:
> -		adev->mode_info.audio.num_pins =3D 8;
> -		break;
> -	case CHIP_POLARIS11:
> -	case CHIP_POLARIS12:
> -		adev->mode_info.audio.num_pins =3D 6;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	for (i =3D 0; i < adev->mode_info.audio.num_pins; i++) {
> -		adev->mode_info.audio.pin[i].channels =3D -1;
> -		adev->mode_info.audio.pin[i].rate =3D -1;
> -		adev->mode_info.audio.pin[i].bits_per_sample =3D -1;
> -		adev->mode_info.audio.pin[i].status_bits =3D 0;
> -		adev->mode_info.audio.pin[i].category_code =3D 0;
> -		adev->mode_info.audio.pin[i].connected =3D false;
> -		adev->mode_info.audio.pin[i].offset =3D
> pin_offsets[i];
> -		adev->mode_info.audio.pin[i].id =3D i;
> -		/* disable audio.=C2=A0 it will be set up later */
> -		/* XXX remove once we switch to ip funcs */
> -		dce_v11_0_audio_enable(adev, &adev-
> >mode_info.audio.pin[i], false);
> -	}
> -
> -	return 0;
> -}
> -
> -static void dce_v11_0_audio_fini(struct amdgpu_device *adev)
> -{
> -	if (!amdgpu_audio)
> -		return;
> -
> -	if (!adev->mode_info.audio.enabled)
> -		return;
> -
> -	adev->mode_info.audio.enabled =3D false;
> -}
> -
> -/*
> - * update the N and CTS parameters for a given pixel clock rate
> - */
> -static void dce_v11_0_afmt_update_ACR(struct drm_encoder *encoder,
> uint32_t clock)
> -{
> -	struct drm_device *dev =3D encoder->dev;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> -	struct amdgpu_afmt_acr acr =3D amdgpu_afmt_acr(clock);
> -	struct amdgpu_encoder *amdgpu_encoder =3D
> to_amdgpu_encoder(encoder);
> -	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder-
> >enc_priv;
> -	u32 tmp;
> -
> -	tmp =3D RREG32(mmHDMI_ACR_32_0 + dig->afmt->offset);
> -	tmp =3D REG_SET_FIELD(tmp, HDMI_ACR_32_0, HDMI_ACR_CTS_32,
> acr.cts_32khz);
> -	WREG32(mmHDMI_ACR_32_0 + dig->afmt->offset, tmp);
> -	tmp =3D RREG32(mmHDMI_ACR_32_1 + dig->afmt->offset);
> -	tmp =3D REG_SET_FIELD(tmp, HDMI_ACR_32_1, HDMI_ACR_N_32,
> acr.n_32khz);
> -	WREG32(mmHDMI_ACR_32_1 + dig->afmt->offset, tmp);
> -
> -	tmp =3D RREG32(mmHDMI_ACR_44_0 + dig->afmt->offset);
> -	tmp =3D REG_SET_FIELD(tmp, HDMI_ACR_44_0, HDMI_ACR_CTS_44,
> acr.cts_44_1khz);
> -	WREG32(mmHDMI_ACR_44_0 + dig->afmt->offset, tmp);
> -	tmp =3D RREG32(mmHDMI_ACR_44_1 + dig->afmt->offset);
> -	tmp =3D REG_SET_FIELD(tmp, HDMI_ACR_44_1, HDMI_ACR_N_44,
> acr.n_44_1khz);
> -	WREG32(mmHDMI_ACR_44_1 + dig->afmt->offset, tmp);
> -
> -	tmp =3D RREG32(mmHDMI_ACR_48_0 + dig->afmt->offset);
> -	tmp =3D REG_SET_FIELD(tmp, HDMI_ACR_48_0, HDMI_ACR_CTS_48,
> acr.cts_48khz);
> -	WREG32(mmHDMI_ACR_48_0 + dig->afmt->offset, tmp);
> -	tmp =3D RREG32(mmHDMI_ACR_48_1 + dig->afmt->offset);
> -	tmp =3D REG_SET_FIELD(tmp, HDMI_ACR_48_1, HDMI_ACR_N_48,
> acr.n_48khz);
> -	WREG32(mmHDMI_ACR_48_1 + dig->afmt->offset, tmp);
> -
> -}
> -
> -/*
> - * build a HDMI Video Info Frame
> - */
> -static void dce_v11_0_afmt_update_avi_infoframe(struct drm_encoder
> *encoder,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *buffer, size_t
> size)
> -{
> -	struct drm_device *dev =3D encoder->dev;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> -	struct amdgpu_encoder *amdgpu_encoder =3D
> to_amdgpu_encoder(encoder);
> -	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder-
> >enc_priv;
> -	uint8_t *frame =3D buffer + 3;
> -	uint8_t *header =3D buffer;
> -
> -	WREG32(mmAFMT_AVI_INFO0 + dig->afmt->offset,
> -		frame[0x0] | (frame[0x1] << 8) | (frame[0x2] << 16)
> | (frame[0x3] << 24));
> -	WREG32(mmAFMT_AVI_INFO1 + dig->afmt->offset,
> -		frame[0x4] | (frame[0x5] << 8) | (frame[0x6] << 16)
> | (frame[0x7] << 24));
> -	WREG32(mmAFMT_AVI_INFO2 + dig->afmt->offset,
> -		frame[0x8] | (frame[0x9] << 8) | (frame[0xA] << 16)
> | (frame[0xB] << 24));
> -	WREG32(mmAFMT_AVI_INFO3 + dig->afmt->offset,
> -		frame[0xC] | (frame[0xD] << 8) | (header[1] << 24));
> -}
> -
> -static void dce_v11_0_audio_set_dto(struct drm_encoder *encoder, u32
> clock)
> -{
> -	struct drm_device *dev =3D encoder->dev;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> -	struct amdgpu_encoder *amdgpu_encoder =3D
> to_amdgpu_encoder(encoder);
> -	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder-
> >enc_priv;
> -	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(encoder-
> >crtc);
> -	u32 dto_phase =3D 24 * 1000;
> -	u32 dto_modulo =3D clock;
> -	u32 tmp;
> -
> -	if (!dig || !dig->afmt)
> -		return;
> -
> -	/* XXX two dtos; generally use dto0 for hdmi */
> -	/* Express [24MHz / target pixel clock] as an exact rational
> -	 * number (coefficient of two integer numbers.=C2=A0
> DCCG_AUDIO_DTOx_PHASE
> -	 * is the numerator, DCCG_AUDIO_DTOx_MODULE is the
> denominator
> -	 */
> -	tmp =3D RREG32(mmDCCG_AUDIO_DTO_SOURCE);
> -	tmp =3D REG_SET_FIELD(tmp, DCCG_AUDIO_DTO_SOURCE,
> DCCG_AUDIO_DTO0_SOURCE_SEL,
> -			=C2=A0=C2=A0=C2=A0 amdgpu_crtc->crtc_id);
> -	WREG32(mmDCCG_AUDIO_DTO_SOURCE, tmp);
> -	WREG32(mmDCCG_AUDIO_DTO0_PHASE, dto_phase);
> -	WREG32(mmDCCG_AUDIO_DTO0_MODULE, dto_modulo);
> -}
> -
> -/*
> - * update the info frames with the data from the current display
> mode
> - */
> -static void dce_v11_0_afmt_setmode(struct drm_encoder *encoder,
> -				=C2=A0 struct drm_display_mode *mode)
> -{
> -	struct drm_device *dev =3D encoder->dev;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> -	struct amdgpu_encoder *amdgpu_encoder =3D
> to_amdgpu_encoder(encoder);
> -	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder-
> >enc_priv;
> -	struct drm_connector *connector =3D
> amdgpu_get_connector_for_encoder(encoder);
> -	u8 buffer[HDMI_INFOFRAME_HEADER_SIZE +
> HDMI_AVI_INFOFRAME_SIZE];
> -	struct hdmi_avi_infoframe frame;
> -	ssize_t err;
> -	u32 tmp;
> -	int bpc =3D 8;
> -
> -	if (!dig || !dig->afmt)
> -		return;
> -
> -	/* Silent, r600_hdmi_enable will raise WARN for us */
> -	if (!dig->afmt->enabled)
> -		return;
> -
> -	/* hdmi deep color mode general control packets setup, if
> bpc > 8 */
> -	if (encoder->crtc) {
> -		struct amdgpu_crtc *amdgpu_crtc =3D
> to_amdgpu_crtc(encoder->crtc);
> -		bpc =3D amdgpu_crtc->bpc;
> -	}
> -
> -	/* disable audio prior to setting up hw */
> -	dig->afmt->pin =3D dce_v11_0_audio_get_pin(adev);
> -	dce_v11_0_audio_enable(adev, dig->afmt->pin, false);
> -
> -	dce_v11_0_audio_set_dto(encoder, mode->clock);
> -
> -	tmp =3D RREG32(mmHDMI_VBI_PACKET_CONTROL + dig->afmt->offset);
> -	tmp =3D REG_SET_FIELD(tmp, HDMI_VBI_PACKET_CONTROL,
> HDMI_NULL_SEND, 1);
> -	WREG32(mmHDMI_VBI_PACKET_CONTROL + dig->afmt->offset, tmp);
> /* send null packets when required */
> -
> -	WREG32(mmAFMT_AUDIO_CRC_CONTROL + dig->afmt->offset,
> 0x1000);
> -
> -	tmp =3D RREG32(mmHDMI_CONTROL + dig->afmt->offset);
> -	switch (bpc) {
> -	case 0:
> -	case 6:
> -	case 8:
> -	case 16:
> -	default:
> -		tmp =3D REG_SET_FIELD(tmp, HDMI_CONTROL,
> HDMI_DEEP_COLOR_ENABLE, 0);
> -		tmp =3D REG_SET_FIELD(tmp, HDMI_CONTROL,
> HDMI_DEEP_COLOR_DEPTH, 0);
> -		DRM_DEBUG("%s: Disabling hdmi deep color for %d
> bpc.\n",
> -			=C2=A0 connector->name, bpc);
> -		break;
> -	case 10:
> -		tmp =3D REG_SET_FIELD(tmp, HDMI_CONTROL,
> HDMI_DEEP_COLOR_ENABLE, 1);
> -		tmp =3D REG_SET_FIELD(tmp, HDMI_CONTROL,
> HDMI_DEEP_COLOR_DEPTH, 1);
> -		DRM_DEBUG("%s: Enabling hdmi deep color 30 for 10
> bpc.\n",
> -			=C2=A0 connector->name);
> -		break;
> -	case 12:
> -		tmp =3D REG_SET_FIELD(tmp, HDMI_CONTROL,
> HDMI_DEEP_COLOR_ENABLE, 1);
> -		tmp =3D REG_SET_FIELD(tmp, HDMI_CONTROL,
> HDMI_DEEP_COLOR_DEPTH, 2);
> -		DRM_DEBUG("%s: Enabling hdmi deep color 36 for 12
> bpc.\n",
> -			=C2=A0 connector->name);
> -		break;
> -	}
> -	WREG32(mmHDMI_CONTROL + dig->afmt->offset, tmp);
> -
> -	tmp =3D RREG32(mmHDMI_VBI_PACKET_CONTROL + dig->afmt->offset);
> -	tmp =3D REG_SET_FIELD(tmp, HDMI_VBI_PACKET_CONTROL,
> HDMI_NULL_SEND, 1); /* send null packets when required */
> -	tmp =3D REG_SET_FIELD(tmp, HDMI_VBI_PACKET_CONTROL,
> HDMI_GC_SEND, 1); /* send general control packets */
> -	tmp =3D REG_SET_FIELD(tmp, HDMI_VBI_PACKET_CONTROL,
> HDMI_GC_CONT, 1); /* send general control packets every frame */
> -	WREG32(mmHDMI_VBI_PACKET_CONTROL + dig->afmt->offset, tmp);
> -
> -	tmp =3D RREG32(mmHDMI_INFOFRAME_CONTROL0 + dig->afmt->offset);
> -	/* enable audio info frames (frames won't be set until audio
> is enabled) */
> -	tmp =3D REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0,
> HDMI_AUDIO_INFO_SEND, 1);
> -	/* required for audio info values to be updated */
> -	tmp =3D REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0,
> HDMI_AUDIO_INFO_CONT, 1);
> -	WREG32(mmHDMI_INFOFRAME_CONTROL0 + dig->afmt->offset, tmp);
> -
> -	tmp =3D RREG32(mmAFMT_INFOFRAME_CONTROL0 + dig->afmt->offset);
> -	/* required for audio info values to be updated */
> -	tmp =3D REG_SET_FIELD(tmp, AFMT_INFOFRAME_CONTROL0,
> AFMT_AUDIO_INFO_UPDATE, 1);
> -	WREG32(mmAFMT_INFOFRAME_CONTROL0 + dig->afmt->offset, tmp);
> -
> -	tmp =3D RREG32(mmHDMI_INFOFRAME_CONTROL1 + dig->afmt->offset);
> -	/* anything other than 0 */
> -	tmp =3D REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL1,
> HDMI_AUDIO_INFO_LINE, 2);
> -	WREG32(mmHDMI_INFOFRAME_CONTROL1 + dig->afmt->offset, tmp);
> -
> -	WREG32(mmHDMI_GC + dig->afmt->offset, 0); /* unset
> HDMI_GC_AVMUTE */
> -
> -	tmp =3D RREG32(mmHDMI_AUDIO_PACKET_CONTROL + dig->afmt-
> >offset);
> -	/* set the default audio delay */
> -	tmp =3D REG_SET_FIELD(tmp, HDMI_AUDIO_PACKET_CONTROL,
> HDMI_AUDIO_DELAY_EN, 1);
> -	/* should be suffient for all audio modes and small enough
> for all hblanks */
> -	tmp =3D REG_SET_FIELD(tmp, HDMI_AUDIO_PACKET_CONTROL,
> HDMI_AUDIO_PACKETS_PER_LINE, 3);
> -	WREG32(mmHDMI_AUDIO_PACKET_CONTROL + dig->afmt->offset,
> tmp);
> -
> -	tmp =3D RREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig->afmt-
> >offset);
> -	/* allow 60958 channel status fields to be updated */
> -	tmp =3D REG_SET_FIELD(tmp, AFMT_AUDIO_PACKET_CONTROL,
> AFMT_60958_CS_UPDATE, 1);
> -	WREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig->afmt->offset,
> tmp);
> -
> -	tmp =3D RREG32(mmHDMI_ACR_PACKET_CONTROL + dig->afmt->offset);
> -	if (bpc > 8)
> -		/* clear SW CTS value */
> -		tmp =3D REG_SET_FIELD(tmp, HDMI_ACR_PACKET_CONTROL,
> HDMI_ACR_SOURCE, 0);
> -	else
> -		/* select SW CTS value */
> -		tmp =3D REG_SET_FIELD(tmp, HDMI_ACR_PACKET_CONTROL,
> HDMI_ACR_SOURCE, 1);
> -	/* allow hw to sent ACR packets when required */
> -	tmp =3D REG_SET_FIELD(tmp, HDMI_ACR_PACKET_CONTROL,
> HDMI_ACR_AUTO_SEND, 1);
> -	WREG32(mmHDMI_ACR_PACKET_CONTROL + dig->afmt->offset, tmp);
> -
> -	dce_v11_0_afmt_update_ACR(encoder, mode->clock);
> -
> -	tmp =3D RREG32(mmAFMT_60958_0 + dig->afmt->offset);
> -	tmp =3D REG_SET_FIELD(tmp, AFMT_60958_0,
> AFMT_60958_CS_CHANNEL_NUMBER_L, 1);
> -	WREG32(mmAFMT_60958_0 + dig->afmt->offset, tmp);
> -
> -	tmp =3D RREG32(mmAFMT_60958_1 + dig->afmt->offset);
> -	tmp =3D REG_SET_FIELD(tmp, AFMT_60958_1,
> AFMT_60958_CS_CHANNEL_NUMBER_R, 2);
> -	WREG32(mmAFMT_60958_1 + dig->afmt->offset, tmp);
> -
> -	tmp =3D RREG32(mmAFMT_60958_2 + dig->afmt->offset);
> -	tmp =3D REG_SET_FIELD(tmp, AFMT_60958_2,
> AFMT_60958_CS_CHANNEL_NUMBER_2, 3);
> -	tmp =3D REG_SET_FIELD(tmp, AFMT_60958_2,
> AFMT_60958_CS_CHANNEL_NUMBER_3, 4);
> -	tmp =3D REG_SET_FIELD(tmp, AFMT_60958_2,
> AFMT_60958_CS_CHANNEL_NUMBER_4, 5);
> -	tmp =3D REG_SET_FIELD(tmp, AFMT_60958_2,
> AFMT_60958_CS_CHANNEL_NUMBER_5, 6);
> -	tmp =3D REG_SET_FIELD(tmp, AFMT_60958_2,
> AFMT_60958_CS_CHANNEL_NUMBER_6, 7);
> -	tmp =3D REG_SET_FIELD(tmp, AFMT_60958_2,
> AFMT_60958_CS_CHANNEL_NUMBER_7, 8);
> -	WREG32(mmAFMT_60958_2 + dig->afmt->offset, tmp);
> -
> -	dce_v11_0_audio_write_speaker_allocation(encoder);
> -
> -	WREG32(mmAFMT_AUDIO_PACKET_CONTROL2 + dig->afmt->offset,
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0xff <<
> AFMT_AUDIO_PACKET_CONTROL2__AFMT_AUDIO_CHANNEL_ENABLE__SHIFT));
> -
> -	dce_v11_0_afmt_audio_select_pin(encoder);
> -	dce_v11_0_audio_write_sad_regs(encoder);
> -	dce_v11_0_audio_write_latency_fields(encoder, mode);
> -
> -	err =3D drm_hdmi_avi_infoframe_from_display_mode(&frame,
> connector, mode);
> -	if (err < 0) {
> -		DRM_ERROR("failed to setup AVI infoframe: %zd\n",
> err);
> -		return;
> -	}
> -
> -	err =3D hdmi_avi_infoframe_pack(&frame, buffer,
> sizeof(buffer));
> -	if (err < 0) {
> -		DRM_ERROR("failed to pack AVI infoframe: %zd\n",
> err);
> -		return;
> -	}
> -
> -	dce_v11_0_afmt_update_avi_infoframe(encoder, buffer,
> sizeof(buffer));
> -
> -	tmp =3D RREG32(mmHDMI_INFOFRAME_CONTROL0 + dig->afmt->offset);
> -	/* enable AVI info frames */
> -	tmp =3D REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0,
> HDMI_AVI_INFO_SEND, 1);
> -	/* required for audio info values to be updated */
> -	tmp =3D REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0,
> HDMI_AVI_INFO_CONT, 1);
> -	WREG32(mmHDMI_INFOFRAME_CONTROL0 + dig->afmt->offset, tmp);
> -
> -	tmp =3D RREG32(mmHDMI_INFOFRAME_CONTROL1 + dig->afmt->offset);
> -	tmp =3D REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL1,
> HDMI_AVI_INFO_LINE, 2);
> -	WREG32(mmHDMI_INFOFRAME_CONTROL1 + dig->afmt->offset, tmp);
> -
> -	tmp =3D RREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig->afmt-
> >offset);
> -	/* send audio packets */
> -	tmp =3D REG_SET_FIELD(tmp, AFMT_AUDIO_PACKET_CONTROL,
> AFMT_AUDIO_SAMPLE_SEND, 1);
> -	WREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig->afmt->offset,
> tmp);
> -
> -	WREG32(mmAFMT_RAMP_CONTROL0 + dig->afmt->offset,
> 0x00FFFFFF);
> -	WREG32(mmAFMT_RAMP_CONTROL1 + dig->afmt->offset,
> 0x007FFFFF);
> -	WREG32(mmAFMT_RAMP_CONTROL2 + dig->afmt->offset,
> 0x00000001);
> -	WREG32(mmAFMT_RAMP_CONTROL3 + dig->afmt->offset,
> 0x00000001);
> -
> -	/* enable audio after to setting up hw */
> -	dce_v11_0_audio_enable(adev, dig->afmt->pin, true);
> -}
> -
> -static void dce_v11_0_afmt_enable(struct drm_encoder *encoder, bool
> enable)
> -{
> -	struct drm_device *dev =3D encoder->dev;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> -	struct amdgpu_encoder *amdgpu_encoder =3D
> to_amdgpu_encoder(encoder);
> -	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder-
> >enc_priv;
> -
> -	if (!dig || !dig->afmt)
> -		return;
> -
> -	/* Silent, r600_hdmi_enable will raise WARN for us */
> -	if (enable && dig->afmt->enabled)
> -		return;
> -	if (!enable && !dig->afmt->enabled)
> -		return;
> -
> -	if (!enable && dig->afmt->pin) {
> -		dce_v11_0_audio_enable(adev, dig->afmt->pin, false);
> -		dig->afmt->pin =3D NULL;
> -	}
> -
> -	dig->afmt->enabled =3D enable;
> -
> -	DRM_DEBUG("%sabling AFMT interface @ 0x%04X for encoder
> 0x%x\n",
> -		=C2=A0 enable ? "En" : "Dis", dig->afmt->offset,
> amdgpu_encoder->encoder_id);
> -}
> -
> -static int dce_v11_0_afmt_init(struct amdgpu_device *adev)
> -{
> -	int i;
> -
> -	for (i =3D 0; i < adev->mode_info.num_dig; i++)
> -		adev->mode_info.afmt[i] =3D NULL;
> -
> -	/* DCE11 has audio blocks tied to DIG encoders */
> -	for (i =3D 0; i < adev->mode_info.num_dig; i++) {
> -		adev->mode_info.afmt[i] =3D kzalloc(sizeof(struct
> amdgpu_afmt), GFP_KERNEL);
> -		if (adev->mode_info.afmt[i]) {
> -			adev->mode_info.afmt[i]->offset =3D
> dig_offsets[i];
> -			adev->mode_info.afmt[i]->id =3D i;
> -		} else {
> -			int j;
> -			for (j =3D 0; j < i; j++) {
> -				kfree(adev->mode_info.afmt[j]);
> -				adev->mode_info.afmt[j] =3D NULL;
> -			}
> -			return -ENOMEM;
> -		}
> -	}
> -	return 0;
> -}
> -
> -static void dce_v11_0_afmt_fini(struct amdgpu_device *adev)
> -{
> -	int i;
> -
> -	for (i =3D 0; i < adev->mode_info.num_dig; i++) {
> -		kfree(adev->mode_info.afmt[i]);
> -		adev->mode_info.afmt[i] =3D NULL;
> -	}
> -}
> -
> -static const u32 vga_control_regs[6] =3D
> -{
> -	mmD1VGA_CONTROL,
> -	mmD2VGA_CONTROL,
> -	mmD3VGA_CONTROL,
> -	mmD4VGA_CONTROL,
> -	mmD5VGA_CONTROL,
> -	mmD6VGA_CONTROL,
> -};
> -
> -static void dce_v11_0_vga_enable(struct drm_crtc *crtc, bool enable)
> -{
> -	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -	struct drm_device *dev =3D crtc->dev;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> -	u32 vga_control;
> -
> -	vga_control =3D RREG32(vga_control_regs[amdgpu_crtc->crtc_id])
> & ~1;
> -	if (enable)
> -		WREG32(vga_control_regs[amdgpu_crtc->crtc_id],
> vga_control | 1);
> -	else
> -		WREG32(vga_control_regs[amdgpu_crtc->crtc_id],
> vga_control);
> -}
> -
> -static void dce_v11_0_grph_enable(struct drm_crtc *crtc, bool
> enable)
> -{
> -	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -	struct drm_device *dev =3D crtc->dev;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> -
> -	if (enable)
> -		WREG32(mmGRPH_ENABLE + amdgpu_crtc->crtc_offset, 1);
> -	else
> -		WREG32(mmGRPH_ENABLE + amdgpu_crtc->crtc_offset, 0);
> -}
> -
> -static int dce_v11_0_crtc_do_set_base(struct drm_crtc *crtc,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_framebuffer *fb,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 int x, int y, int atomic)
> -{
> -	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -	struct drm_device *dev =3D crtc->dev;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> -	struct drm_framebuffer *target_fb;
> -	struct drm_gem_object *obj;
> -	struct amdgpu_bo *abo;
> -	uint64_t fb_location, tiling_flags;
> -	uint32_t fb_format, fb_pitch_pixels;
> -	u32 fb_swap =3D REG_SET_FIELD(0, GRPH_SWAP_CNTL,
> GRPH_ENDIAN_SWAP, ENDIAN_NONE);
> -	u32 pipe_config;
> -	u32 tmp, viewport_w, viewport_h;
> -	int r;
> -	bool bypass_lut =3D false;
> -
> -	/* no fb bound */
> -	if (!atomic && !crtc->primary->fb) {
> -		DRM_DEBUG_KMS("No FB bound\n");
> -		return 0;
> -	}
> -
> -	if (atomic)
> -		target_fb =3D fb;
> -	else
> -		target_fb =3D crtc->primary->fb;
> -
> -	/* If atomic, assume fb object is pinned & idle & fenced and
> -	 * just update base pointers
> -	 */
> -	obj =3D target_fb->obj[0];
> -	abo =3D gem_to_amdgpu_bo(obj);
> -	r =3D amdgpu_bo_reserve(abo, false);
> -	if (unlikely(r !=3D 0))
> -		return r;
> -
> -	if (!atomic) {
> -		abo->flags |=3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> -		r =3D amdgpu_bo_pin(abo, AMDGPU_GEM_DOMAIN_VRAM);
> -		if (unlikely(r !=3D 0)) {
> -			amdgpu_bo_unreserve(abo);
> -			return -EINVAL;
> -		}
> -	}
> -	fb_location =3D amdgpu_bo_gpu_offset(abo);
> -
> -	amdgpu_bo_get_tiling_flags(abo, &tiling_flags);
> -	amdgpu_bo_unreserve(abo);
> -
> -	pipe_config =3D AMDGPU_TILING_GET(tiling_flags, PIPE_CONFIG);
> -
> -	switch (target_fb->format->format) {
> -	case DRM_FORMAT_C8:
> -		fb_format =3D REG_SET_FIELD(0, GRPH_CONTROL,
> GRPH_DEPTH, 0);
> -		fb_format =3D REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_FORMAT, 0);
> -		break;
> -	case DRM_FORMAT_XRGB4444:
> -	case DRM_FORMAT_ARGB4444:
> -		fb_format =3D REG_SET_FIELD(0, GRPH_CONTROL,
> GRPH_DEPTH, 1);
> -		fb_format =3D REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_FORMAT, 2);
> -#ifdef __BIG_ENDIAN
> -		fb_swap =3D REG_SET_FIELD(fb_swap, GRPH_SWAP_CNTL,
> GRPH_ENDIAN_SWAP,
> -					ENDIAN_8IN16);
> -#endif
> -		break;
> -	case DRM_FORMAT_XRGB1555:
> -	case DRM_FORMAT_ARGB1555:
> -		fb_format =3D REG_SET_FIELD(0, GRPH_CONTROL,
> GRPH_DEPTH, 1);
> -		fb_format =3D REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_FORMAT, 0);
> -#ifdef __BIG_ENDIAN
> -		fb_swap =3D REG_SET_FIELD(fb_swap, GRPH_SWAP_CNTL,
> GRPH_ENDIAN_SWAP,
> -					ENDIAN_8IN16);
> -#endif
> -		break;
> -	case DRM_FORMAT_BGRX5551:
> -	case DRM_FORMAT_BGRA5551:
> -		fb_format =3D REG_SET_FIELD(0, GRPH_CONTROL,
> GRPH_DEPTH, 1);
> -		fb_format =3D REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_FORMAT, 5);
> -#ifdef __BIG_ENDIAN
> -		fb_swap =3D REG_SET_FIELD(fb_swap, GRPH_SWAP_CNTL,
> GRPH_ENDIAN_SWAP,
> -					ENDIAN_8IN16);
> -#endif
> -		break;
> -	case DRM_FORMAT_RGB565:
> -		fb_format =3D REG_SET_FIELD(0, GRPH_CONTROL,
> GRPH_DEPTH, 1);
> -		fb_format =3D REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_FORMAT, 1);
> -#ifdef __BIG_ENDIAN
> -		fb_swap =3D REG_SET_FIELD(fb_swap, GRPH_SWAP_CNTL,
> GRPH_ENDIAN_SWAP,
> -					ENDIAN_8IN16);
> -#endif
> -		break;
> -	case DRM_FORMAT_XRGB8888:
> -	case DRM_FORMAT_ARGB8888:
> -		fb_format =3D REG_SET_FIELD(0, GRPH_CONTROL,
> GRPH_DEPTH, 2);
> -		fb_format =3D REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_FORMAT, 0);
> -#ifdef __BIG_ENDIAN
> -		fb_swap =3D REG_SET_FIELD(fb_swap, GRPH_SWAP_CNTL,
> GRPH_ENDIAN_SWAP,
> -					ENDIAN_8IN32);
> -#endif
> -		break;
> -	case DRM_FORMAT_XRGB2101010:
> -	case DRM_FORMAT_ARGB2101010:
> -		fb_format =3D REG_SET_FIELD(0, GRPH_CONTROL,
> GRPH_DEPTH, 2);
> -		fb_format =3D REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_FORMAT, 1);
> -#ifdef __BIG_ENDIAN
> -		fb_swap =3D REG_SET_FIELD(fb_swap, GRPH_SWAP_CNTL,
> GRPH_ENDIAN_SWAP,
> -					ENDIAN_8IN32);
> -#endif
> -		/* Greater 8 bpc fb needs to bypass hw-lut to retain
> precision */
> -		bypass_lut =3D true;
> -		break;
> -	case DRM_FORMAT_BGRX1010102:
> -	case DRM_FORMAT_BGRA1010102:
> -		fb_format =3D REG_SET_FIELD(0, GRPH_CONTROL,
> GRPH_DEPTH, 2);
> -		fb_format =3D REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_FORMAT, 4);
> -#ifdef __BIG_ENDIAN
> -		fb_swap =3D REG_SET_FIELD(fb_swap, GRPH_SWAP_CNTL,
> GRPH_ENDIAN_SWAP,
> -					ENDIAN_8IN32);
> -#endif
> -		/* Greater 8 bpc fb needs to bypass hw-lut to retain
> precision */
> -		bypass_lut =3D true;
> -		break;
> -	case DRM_FORMAT_XBGR8888:
> -	case DRM_FORMAT_ABGR8888:
> -		fb_format =3D REG_SET_FIELD(0, GRPH_CONTROL,
> GRPH_DEPTH, 2);
> -		fb_format =3D REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_FORMAT, 0);
> -		fb_swap =3D REG_SET_FIELD(fb_swap, GRPH_SWAP_CNTL,
> GRPH_RED_CROSSBAR, 2);
> -		fb_swap =3D REG_SET_FIELD(fb_swap, GRPH_SWAP_CNTL,
> GRPH_BLUE_CROSSBAR, 2);
> -#ifdef __BIG_ENDIAN
> -		fb_swap =3D REG_SET_FIELD(fb_swap, GRPH_SWAP_CNTL,
> GRPH_ENDIAN_SWAP,
> -					ENDIAN_8IN32);
> -#endif
> -		break;
> -	default:
> -		DRM_ERROR("Unsupported screen format %p4cc\n",
> -			=C2=A0 &target_fb->format->format);
> -		return -EINVAL;
> -	}
> -
> -	if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE) =3D=3D
> ARRAY_2D_TILED_THIN1) {
> -		unsigned bankw, bankh, mtaspect, tile_split,
> num_banks;
> -
> -		bankw =3D AMDGPU_TILING_GET(tiling_flags, BANK_WIDTH);
> -		bankh =3D AMDGPU_TILING_GET(tiling_flags,
> BANK_HEIGHT);
> -		mtaspect =3D AMDGPU_TILING_GET(tiling_flags,
> MACRO_TILE_ASPECT);
> -		tile_split =3D AMDGPU_TILING_GET(tiling_flags,
> TILE_SPLIT);
> -		num_banks =3D AMDGPU_TILING_GET(tiling_flags,
> NUM_BANKS);
> -
> -		fb_format =3D REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_NUM_BANKS, num_banks);
> -		fb_format =3D REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_ARRAY_MODE,
> -					=C2=A0 ARRAY_2D_TILED_THIN1);
> -		fb_format =3D REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_TILE_SPLIT,
> -					=C2=A0 tile_split);
> -		fb_format =3D REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_BANK_WIDTH, bankw);
> -		fb_format =3D REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_BANK_HEIGHT, bankh);
> -		fb_format =3D REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_MACRO_TILE_ASPECT,
> -					=C2=A0 mtaspect);
> -		fb_format =3D REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_MICRO_TILE_MODE,
> -					=C2=A0
> ADDR_SURF_MICRO_TILING_DISPLAY);
> -	} else if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE) =3D=3D
> ARRAY_1D_TILED_THIN1) {
> -		fb_format =3D REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_ARRAY_MODE,
> -					=C2=A0 ARRAY_1D_TILED_THIN1);
> -	}
> -
> -	fb_format =3D REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_PIPE_CONFIG,
> -				=C2=A0 pipe_config);
> -
> -	dce_v11_0_vga_enable(crtc, false);
> -
> -	/* Make sure surface address is updated at vertical blank
> rather than
> -	 * horizontal blank
> -	 */
> -	tmp =3D RREG32(mmGRPH_FLIP_CONTROL + amdgpu_crtc-
> >crtc_offset);
> -	tmp =3D REG_SET_FIELD(tmp, GRPH_FLIP_CONTROL,
> -			=C2=A0=C2=A0=C2=A0 GRPH_SURFACE_UPDATE_H_RETRACE_EN, 0);
> -	WREG32(mmGRPH_FLIP_CONTROL + amdgpu_crtc->crtc_offset, tmp);
> -
> -	WREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS_HIGH + amdgpu_crtc-
> >crtc_offset,
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upper_32_bits(fb_location));
> -	WREG32(mmGRPH_SECONDARY_SURFACE_ADDRESS_HIGH + amdgpu_crtc-
> >crtc_offset,
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upper_32_bits(fb_location));
> -	WREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS + amdgpu_crtc-
> >crtc_offset,
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (u32)fb_location &
> GRPH_PRIMARY_SURFACE_ADDRESS__GRPH_PRIMARY_SURFACE_ADDRESS_MASK);
> -	WREG32(mmGRPH_SECONDARY_SURFACE_ADDRESS + amdgpu_crtc-
> >crtc_offset,
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (u32) fb_location &
> GRPH_SECONDARY_SURFACE_ADDRESS__GRPH_SECONDARY_SURFACE_ADDRESS_MASK);
> -	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset,
> fb_format);
> -	WREG32(mmGRPH_SWAP_CNTL + amdgpu_crtc->crtc_offset,
> fb_swap);
> -
> -	/*
> -	 * The LUT only has 256 slots for indexing by a 8 bpc fb.
> Bypass the LUT
> -	 * for > 8 bpc scanout to avoid truncation of fb indices to
> 8 msb's, to
> -	 * retain the full precision throughout the pipeline.
> -	 */
> -	tmp =3D RREG32(mmGRPH_LUT_10BIT_BYPASS + amdgpu_crtc-
> >crtc_offset);
> -	if (bypass_lut)
> -		tmp =3D REG_SET_FIELD(tmp, GRPH_LUT_10BIT_BYPASS,
> GRPH_LUT_10BIT_BYPASS_EN, 1);
> -	else
> -		tmp =3D REG_SET_FIELD(tmp, GRPH_LUT_10BIT_BYPASS,
> GRPH_LUT_10BIT_BYPASS_EN, 0);
> -	WREG32(mmGRPH_LUT_10BIT_BYPASS + amdgpu_crtc->crtc_offset,
> tmp);
> -
> -	if (bypass_lut)
> -		DRM_DEBUG_KMS("Bypassing hardware LUT due to 10 bit
> fb scanout.\n");
> -
> -	WREG32(mmGRPH_SURFACE_OFFSET_X + amdgpu_crtc->crtc_offset,
> 0);
> -	WREG32(mmGRPH_SURFACE_OFFSET_Y + amdgpu_crtc->crtc_offset,
> 0);
> -	WREG32(mmGRPH_X_START + amdgpu_crtc->crtc_offset, 0);
> -	WREG32(mmGRPH_Y_START + amdgpu_crtc->crtc_offset, 0);
> -	WREG32(mmGRPH_X_END + amdgpu_crtc->crtc_offset, target_fb-
> >width);
> -	WREG32(mmGRPH_Y_END + amdgpu_crtc->crtc_offset, target_fb-
> >height);
> -
> -	fb_pitch_pixels =3D target_fb->pitches[0] / target_fb->format-
> >cpp[0];
> -	WREG32(mmGRPH_PITCH + amdgpu_crtc->crtc_offset,
> fb_pitch_pixels);
> -
> -	dce_v11_0_grph_enable(crtc, true);
> -
> -	WREG32(mmLB_DESKTOP_HEIGHT + amdgpu_crtc->crtc_offset,
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_fb->height);
> -
> -	x &=3D ~3;
> -	y &=3D ~1;
> -	WREG32(mmVIEWPORT_START + amdgpu_crtc->crtc_offset,
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (x << 16) | y);
> -	viewport_w =3D crtc->mode.hdisplay;
> -	viewport_h =3D (crtc->mode.vdisplay + 1) & ~1;
> -	WREG32(mmVIEWPORT_SIZE + amdgpu_crtc->crtc_offset,
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (viewport_w << 16) | viewport_h);
> -
> -	/* set pageflip to happen anywhere in vblank interval */
> -	WREG32(mmCRTC_MASTER_UPDATE_MODE + amdgpu_crtc->crtc_offset,
> 0);
> -
> -	if (!atomic && fb && fb !=3D crtc->primary->fb) {
> -		abo =3D gem_to_amdgpu_bo(fb->obj[0]);
> -		r =3D amdgpu_bo_reserve(abo, true);
> -		if (unlikely(r !=3D 0))
> -			return r;
> -		amdgpu_bo_unpin(abo);
> -		amdgpu_bo_unreserve(abo);
> -	}
> -
> -	/* Bytes per pixel may have changed */
> -	dce_v11_0_bandwidth_update(adev);
> -
> -	return 0;
> -}
> -
> -static void dce_v11_0_set_interleave(struct drm_crtc *crtc,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_display_mode *mode)
> -{
> -	struct drm_device *dev =3D crtc->dev;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> -	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -	u32 tmp;
> -
> -	tmp =3D RREG32(mmLB_DATA_FORMAT + amdgpu_crtc->crtc_offset);
> -	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> -		tmp =3D REG_SET_FIELD(tmp, LB_DATA_FORMAT,
> INTERLEAVE_EN, 1);
> -	else
> -		tmp =3D REG_SET_FIELD(tmp, LB_DATA_FORMAT,
> INTERLEAVE_EN, 0);
> -	WREG32(mmLB_DATA_FORMAT + amdgpu_crtc->crtc_offset, tmp);
> -}
> -
> -static void dce_v11_0_crtc_load_lut(struct drm_crtc *crtc)
> -{
> -	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -	struct drm_device *dev =3D crtc->dev;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> -	u16 *r, *g, *b;
> -	int i;
> -	u32 tmp;
> -
> -	DRM_DEBUG_KMS("%d\n", amdgpu_crtc->crtc_id);
> -
> -	tmp =3D RREG32(mmINPUT_CSC_CONTROL + amdgpu_crtc-
> >crtc_offset);
> -	tmp =3D REG_SET_FIELD(tmp, INPUT_CSC_CONTROL,
> INPUT_CSC_GRPH_MODE, 0);
> -	WREG32(mmINPUT_CSC_CONTROL + amdgpu_crtc->crtc_offset, tmp);
> -
> -	tmp =3D RREG32(mmPRESCALE_GRPH_CONTROL + amdgpu_crtc-
> >crtc_offset);
> -	tmp =3D REG_SET_FIELD(tmp, PRESCALE_GRPH_CONTROL,
> GRPH_PRESCALE_BYPASS, 1);
> -	WREG32(mmPRESCALE_GRPH_CONTROL + amdgpu_crtc->crtc_offset,
> tmp);
> -
> -	tmp =3D RREG32(mmINPUT_GAMMA_CONTROL + amdgpu_crtc-
> >crtc_offset);
> -	tmp =3D REG_SET_FIELD(tmp, INPUT_GAMMA_CONTROL,
> GRPH_INPUT_GAMMA_MODE, 0);
> -	WREG32(mmINPUT_GAMMA_CONTROL + amdgpu_crtc->crtc_offset,
> tmp);
> -
> -	WREG32(mmDC_LUT_CONTROL + amdgpu_crtc->crtc_offset, 0);
> -
> -	WREG32(mmDC_LUT_BLACK_OFFSET_BLUE + amdgpu_crtc-
> >crtc_offset, 0);
> -	WREG32(mmDC_LUT_BLACK_OFFSET_GREEN + amdgpu_crtc-
> >crtc_offset, 0);
> -	WREG32(mmDC_LUT_BLACK_OFFSET_RED + amdgpu_crtc->crtc_offset,
> 0);
> -
> -	WREG32(mmDC_LUT_WHITE_OFFSET_BLUE + amdgpu_crtc-
> >crtc_offset, 0xffff);
> -	WREG32(mmDC_LUT_WHITE_OFFSET_GREEN + amdgpu_crtc-
> >crtc_offset, 0xffff);
> -	WREG32(mmDC_LUT_WHITE_OFFSET_RED + amdgpu_crtc->crtc_offset,
> 0xffff);
> -
> -	WREG32(mmDC_LUT_RW_MODE + amdgpu_crtc->crtc_offset, 0);
> -	WREG32(mmDC_LUT_WRITE_EN_MASK + amdgpu_crtc->crtc_offset,
> 0x00000007);
> -
> -	WREG32(mmDC_LUT_RW_INDEX + amdgpu_crtc->crtc_offset, 0);
> -	r =3D crtc->gamma_store;
> -	g =3D r + crtc->gamma_size;
> -	b =3D g + crtc->gamma_size;
> -	for (i =3D 0; i < 256; i++) {
> -		WREG32(mmDC_LUT_30_COLOR + amdgpu_crtc->crtc_offset,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((*r++ & 0xffc0) << 14) |
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((*g++ & 0xffc0) << 4) |
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (*b++ >> 6));
> -	}
> -
> -	tmp =3D RREG32(mmDEGAMMA_CONTROL + amdgpu_crtc->crtc_offset);
> -	tmp =3D REG_SET_FIELD(tmp, DEGAMMA_CONTROL, GRPH_DEGAMMA_MODE,
> 0);
> -	tmp =3D REG_SET_FIELD(tmp, DEGAMMA_CONTROL,
> CURSOR_DEGAMMA_MODE, 0);
> -	tmp =3D REG_SET_FIELD(tmp, DEGAMMA_CONTROL,
> CURSOR2_DEGAMMA_MODE, 0);
> -	WREG32(mmDEGAMMA_CONTROL + amdgpu_crtc->crtc_offset, tmp);
> -
> -	tmp =3D RREG32(mmGAMUT_REMAP_CONTROL + amdgpu_crtc-
> >crtc_offset);
> -	tmp =3D REG_SET_FIELD(tmp, GAMUT_REMAP_CONTROL,
> GRPH_GAMUT_REMAP_MODE, 0);
> -	WREG32(mmGAMUT_REMAP_CONTROL + amdgpu_crtc->crtc_offset,
> tmp);
> -
> -	tmp =3D RREG32(mmREGAMMA_CONTROL + amdgpu_crtc->crtc_offset);
> -	tmp =3D REG_SET_FIELD(tmp, REGAMMA_CONTROL, GRPH_REGAMMA_MODE,
> 0);
> -	WREG32(mmREGAMMA_CONTROL + amdgpu_crtc->crtc_offset, tmp);
> -
> -	tmp =3D RREG32(mmOUTPUT_CSC_CONTROL + amdgpu_crtc-
> >crtc_offset);
> -	tmp =3D REG_SET_FIELD(tmp, OUTPUT_CSC_CONTROL,
> OUTPUT_CSC_GRPH_MODE, 0);
> -	WREG32(mmOUTPUT_CSC_CONTROL + amdgpu_crtc->crtc_offset,
> tmp);
> -
> -	/* XXX match this to the depth of the crtc fmt block, move
> to modeset? */
> -	WREG32(mmDENORM_CONTROL + amdgpu_crtc->crtc_offset, 0);
> -	/* XXX this only needs to be programmed once per crtc at
> startup,
> -	 * not sure where the best place for it is
> -	 */
> -	tmp =3D RREG32(mmALPHA_CONTROL + amdgpu_crtc->crtc_offset);
> -	tmp =3D REG_SET_FIELD(tmp, ALPHA_CONTROL,
> CURSOR_ALPHA_BLND_ENA, 1);
> -	WREG32(mmALPHA_CONTROL + amdgpu_crtc->crtc_offset, tmp);
> -}
> -
> -static int dce_v11_0_pick_dig_encoder(struct drm_encoder *encoder)
> -{
> -	struct amdgpu_encoder *amdgpu_encoder =3D
> to_amdgpu_encoder(encoder);
> -	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder-
> >enc_priv;
> -
> -	switch (amdgpu_encoder->encoder_id) {
> -	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY:
> -		if (dig->linkb)
> -			return 1;
> -		else
> -			return 0;
> -	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY1:
> -		if (dig->linkb)
> -			return 3;
> -		else
> -			return 2;
> -	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY2:
> -		if (dig->linkb)
> -			return 5;
> -		else
> -			return 4;
> -	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY3:
> -		return 6;
> -	default:
> -		DRM_ERROR("invalid encoder_id: 0x%x\n",
> amdgpu_encoder->encoder_id);
> -		return 0;
> -	}
> -}
> -
> -/**
> - * dce_v11_0_pick_pll - Allocate a PPLL for use by the crtc.
> - *
> - * @crtc: drm crtc
> - *
> - * Returns the PPLL (Pixel PLL) to be used by the crtc.=C2=A0 For DP
> monitors
> - * a single PPLL can be used for all DP crtcs/encoders.=C2=A0 For non-DP
> - * monitors a dedicated PPLL must be used.=C2=A0 If a particular board
> has
> - * an external DP PLL, return ATOM_PPLL_INVALID to skip PLL
> programming
> - * as there is no need to program the PLL itself.=C2=A0 If we are not
> able to
> - * allocate a PLL, return ATOM_PPLL_INVALID to skip PLL programming
> to
> - * avoid messing up an existing monitor.
> - *
> - * Asic specific PLL information
> - *
> - * DCE 10.x
> - * Tonga
> - * - PPLL1, PPLL2 are available for all UNIPHY (both DP and non-DP)
> - * CI
> - * - PPLL0, PPLL1, PPLL2 are available for all UNIPHY (both DP and
> non-DP) and DAC
> - *
> - */
> -static u32 dce_v11_0_pick_pll(struct drm_crtc *crtc)
> -{
> -	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -	struct drm_device *dev =3D crtc->dev;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> -	u32 pll_in_use;
> -	int pll;
> -
> -	if ((adev->asic_type =3D=3D CHIP_POLARIS10) ||
> -	=C2=A0=C2=A0=C2=A0 (adev->asic_type =3D=3D CHIP_POLARIS11) ||
> -	=C2=A0=C2=A0=C2=A0 (adev->asic_type =3D=3D CHIP_POLARIS12) ||
> -	=C2=A0=C2=A0=C2=A0 (adev->asic_type =3D=3D CHIP_VEGAM)) {
> -		struct amdgpu_encoder *amdgpu_encoder =3D
> -			to_amdgpu_encoder(amdgpu_crtc->encoder);
> -		struct amdgpu_encoder_atom_dig *dig =3D
> amdgpu_encoder->enc_priv;
> -
> -		if
> (ENCODER_MODE_IS_DP(amdgpu_atombios_encoder_get_encoder_mode(amdgpu_c
> rtc->encoder)))
> -			return ATOM_DP_DTO;
> -
> -		switch (amdgpu_encoder->encoder_id) {
> -		case ENCODER_OBJECT_ID_INTERNAL_UNIPHY:
> -			if (dig->linkb)
> -				return ATOM_COMBOPHY_PLL1;
> -			else
> -				return ATOM_COMBOPHY_PLL0;
> -		case ENCODER_OBJECT_ID_INTERNAL_UNIPHY1:
> -			if (dig->linkb)
> -				return ATOM_COMBOPHY_PLL3;
> -			else
> -				return ATOM_COMBOPHY_PLL2;
> -		case ENCODER_OBJECT_ID_INTERNAL_UNIPHY2:
> -			if (dig->linkb)
> -				return ATOM_COMBOPHY_PLL5;
> -			else
> -				return ATOM_COMBOPHY_PLL4;
> -		default:
> -			DRM_ERROR("invalid encoder_id: 0x%x\n",
> amdgpu_encoder->encoder_id);
> -			return ATOM_PPLL_INVALID;
> -		}
> -	}
> -
> -	if
> (ENCODER_MODE_IS_DP(amdgpu_atombios_encoder_get_encoder_mode(amdgpu_c
> rtc->encoder))) {
> -		if (adev->clock.dp_extclk)
> -			/* skip PPLL programming if using ext clock
> */
> -			return ATOM_PPLL_INVALID;
> -		else {
> -			/* use the same PPLL for all DP monitors */
> -			pll =3D amdgpu_pll_get_shared_dp_ppll(crtc);
> -			if (pll !=3D ATOM_PPLL_INVALID)
> -				return pll;
> -		}
> -	} else {
> -		/* use the same PPLL for all monitors with the same
> clock */
> -		pll =3D amdgpu_pll_get_shared_nondp_ppll(crtc);
> -		if (pll !=3D ATOM_PPLL_INVALID)
> -			return pll;
> -	}
> -
> -	/* XXX need to determine what plls are available on each
> DCE11 part */
> -	pll_in_use =3D amdgpu_pll_get_use_mask(crtc);
> -	if (adev->flags & AMD_IS_APU) {
> -		if (!(pll_in_use & (1 << ATOM_PPLL1)))
> -			return ATOM_PPLL1;
> -		if (!(pll_in_use & (1 << ATOM_PPLL0)))
> -			return ATOM_PPLL0;
> -		DRM_ERROR("unable to allocate a PPLL\n");
> -		return ATOM_PPLL_INVALID;
> -	} else {
> -		if (!(pll_in_use & (1 << ATOM_PPLL2)))
> -			return ATOM_PPLL2;
> -		if (!(pll_in_use & (1 << ATOM_PPLL1)))
> -			return ATOM_PPLL1;
> -		if (!(pll_in_use & (1 << ATOM_PPLL0)))
> -			return ATOM_PPLL0;
> -		DRM_ERROR("unable to allocate a PPLL\n");
> -		return ATOM_PPLL_INVALID;
> -	}
> -	return ATOM_PPLL_INVALID;
> -}
> -
> -static void dce_v11_0_lock_cursor(struct drm_crtc *crtc, bool lock)
> -{
> -	struct amdgpu_device *adev =3D drm_to_adev(crtc->dev);
> -	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -	uint32_t cur_lock;
> -
> -	cur_lock =3D RREG32(mmCUR_UPDATE + amdgpu_crtc->crtc_offset);
> -	if (lock)
> -		cur_lock =3D REG_SET_FIELD(cur_lock, CUR_UPDATE,
> CURSOR_UPDATE_LOCK, 1);
> -	else
> -		cur_lock =3D REG_SET_FIELD(cur_lock, CUR_UPDATE,
> CURSOR_UPDATE_LOCK, 0);
> -	WREG32(mmCUR_UPDATE + amdgpu_crtc->crtc_offset, cur_lock);
> -}
> -
> -static void dce_v11_0_hide_cursor(struct drm_crtc *crtc)
> -{
> -	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -	struct amdgpu_device *adev =3D drm_to_adev(crtc->dev);
> -	u32 tmp;
> -
> -	tmp =3D RREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset);
> -	tmp =3D REG_SET_FIELD(tmp, CUR_CONTROL, CURSOR_EN, 0);
> -	WREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset, tmp);
> -}
> -
> -static void dce_v11_0_show_cursor(struct drm_crtc *crtc)
> -{
> -	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -	struct amdgpu_device *adev =3D drm_to_adev(crtc->dev);
> -	u32 tmp;
> -
> -	WREG32(mmCUR_SURFACE_ADDRESS_HIGH + amdgpu_crtc-
> >crtc_offset,
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upper_32_bits(amdgpu_crtc->cursor_=
addr));
> -	WREG32(mmCUR_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset,
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lower_32_bits(amdgpu_crtc->cursor_=
addr));
> -
> -	tmp =3D RREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset);
> -	tmp =3D REG_SET_FIELD(tmp, CUR_CONTROL, CURSOR_EN, 1);
> -	tmp =3D REG_SET_FIELD(tmp, CUR_CONTROL, CURSOR_MODE, 2);
> -	WREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset, tmp);
> -}
> -
> -static int dce_v11_0_cursor_move_locked(struct drm_crtc *crtc,
> -					int x, int y)
> -{
> -	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -	struct amdgpu_device *adev =3D drm_to_adev(crtc->dev);
> -	int xorigin =3D 0, yorigin =3D 0;
> -
> -	amdgpu_crtc->cursor_x =3D x;
> -	amdgpu_crtc->cursor_y =3D y;
> -
> -	/* avivo cursor are offset into the total surface */
> -	x +=3D crtc->x;
> -	y +=3D crtc->y;
> -	DRM_DEBUG("x %d y %d c->x %d c->y %d\n", x, y, crtc->x,
> crtc->y);
> -
> -	if (x < 0) {
> -		xorigin =3D min(-x, amdgpu_crtc->max_cursor_width -
> 1);
> -		x =3D 0;
> -	}
> -	if (y < 0) {
> -		yorigin =3D min(-y, amdgpu_crtc->max_cursor_height -
> 1);
> -		y =3D 0;
> -	}
> -
> -	WREG32(mmCUR_POSITION + amdgpu_crtc->crtc_offset, (x << 16)
> | y);
> -	WREG32(mmCUR_HOT_SPOT + amdgpu_crtc->crtc_offset, (xorigin
> << 16) | yorigin);
> -	WREG32(mmCUR_SIZE + amdgpu_crtc->crtc_offset,
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((amdgpu_crtc->cursor_width - 1) <=
< 16) |
> (amdgpu_crtc->cursor_height - 1));
> -
> -	return 0;
> -}
> -
> -static int dce_v11_0_crtc_cursor_move(struct drm_crtc *crtc,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int x, int y)
> -{
> -	int ret;
> -
> -	dce_v11_0_lock_cursor(crtc, true);
> -	ret =3D dce_v11_0_cursor_move_locked(crtc, x, y);
> -	dce_v11_0_lock_cursor(crtc, false);
> -
> -	return ret;
> -}
> -
> -static int dce_v11_0_crtc_cursor_set2(struct drm_crtc *crtc,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_file *file_priv,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t handle,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t width,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t height,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int32_t hot_x,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int32_t hot_y)
> -{
> -	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -	struct drm_gem_object *obj;
> -	struct amdgpu_bo *aobj;
> -	int ret;
> -
> -	if (!handle) {
> -		/* turn off cursor */
> -		dce_v11_0_hide_cursor(crtc);
> -		obj =3D NULL;
> -		goto unpin;
> -	}
> -
> -	if ((width > amdgpu_crtc->max_cursor_width) ||
> -	=C2=A0=C2=A0=C2=A0 (height > amdgpu_crtc->max_cursor_height)) {
> -		DRM_ERROR("bad cursor width or height %d x %d\n",
> width, height);
> -		return -EINVAL;
> -	}
> -
> -	obj =3D drm_gem_object_lookup(file_priv, handle);
> -	if (!obj) {
> -		DRM_ERROR("Cannot find cursor object %x for crtc
> %d\n", handle, amdgpu_crtc->crtc_id);
> -		return -ENOENT;
> -	}
> -
> -	aobj =3D gem_to_amdgpu_bo(obj);
> -	ret =3D amdgpu_bo_reserve(aobj, false);
> -	if (ret !=3D 0) {
> -		drm_gem_object_put(obj);
> -		return ret;
> -	}
> -
> -	aobj->flags |=3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> -	ret =3D amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
> -	amdgpu_bo_unreserve(aobj);
> -	if (ret) {
> -		DRM_ERROR("Failed to pin new cursor BO (%d)\n",
> ret);
> -		drm_gem_object_put(obj);
> -		return ret;
> -	}
> -	amdgpu_crtc->cursor_addr =3D amdgpu_bo_gpu_offset(aobj);
> -
> -	dce_v11_0_lock_cursor(crtc, true);
> -
> -	if (width !=3D amdgpu_crtc->cursor_width ||
> -	=C2=A0=C2=A0=C2=A0 height !=3D amdgpu_crtc->cursor_height ||
> -	=C2=A0=C2=A0=C2=A0 hot_x !=3D amdgpu_crtc->cursor_hot_x ||
> -	=C2=A0=C2=A0=C2=A0 hot_y !=3D amdgpu_crtc->cursor_hot_y) {
> -		int x, y;
> -
> -		x =3D amdgpu_crtc->cursor_x + amdgpu_crtc-
> >cursor_hot_x - hot_x;
> -		y =3D amdgpu_crtc->cursor_y + amdgpu_crtc-
> >cursor_hot_y - hot_y;
> -
> -		dce_v11_0_cursor_move_locked(crtc, x, y);
> -
> -		amdgpu_crtc->cursor_width =3D width;
> -		amdgpu_crtc->cursor_height =3D height;
> -		amdgpu_crtc->cursor_hot_x =3D hot_x;
> -		amdgpu_crtc->cursor_hot_y =3D hot_y;
> -	}
> -
> -	dce_v11_0_show_cursor(crtc);
> -	dce_v11_0_lock_cursor(crtc, false);
> -
> -unpin:
> -	if (amdgpu_crtc->cursor_bo) {
> -		struct amdgpu_bo *aobj =3D
> gem_to_amdgpu_bo(amdgpu_crtc->cursor_bo);
> -		ret =3D amdgpu_bo_reserve(aobj, true);
> -		if (likely(ret =3D=3D 0)) {
> -			amdgpu_bo_unpin(aobj);
> -			amdgpu_bo_unreserve(aobj);
> -		}
> -		drm_gem_object_put(amdgpu_crtc->cursor_bo);
> -	}
> -
> -	amdgpu_crtc->cursor_bo =3D obj;
> -	return 0;
> -}
> -
> -static void dce_v11_0_cursor_reset(struct drm_crtc *crtc)
> -{
> -	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -
> -	if (amdgpu_crtc->cursor_bo) {
> -		dce_v11_0_lock_cursor(crtc, true);
> -
> -		dce_v11_0_cursor_move_locked(crtc, amdgpu_crtc-
> >cursor_x,
> -					=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_crtc->cursor_y);
> -
> -		dce_v11_0_show_cursor(crtc);
> -
> -		dce_v11_0_lock_cursor(crtc, false);
> -	}
> -}
> -
> -static int dce_v11_0_crtc_gamma_set(struct drm_crtc *crtc, u16 *red,
> u16 *green,
> -				=C2=A0=C2=A0=C2=A0 u16 *blue, uint32_t size,
> -				=C2=A0=C2=A0=C2=A0 struct drm_modeset_acquire_ctx
> *ctx)
> -{
> -	dce_v11_0_crtc_load_lut(crtc);
> -
> -	return 0;
> -}
> -
> -static void dce_v11_0_crtc_destroy(struct drm_crtc *crtc)
> -{
> -	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -
> -	drm_crtc_cleanup(crtc);
> -	kfree(amdgpu_crtc);
> -}
> -
> -static const struct drm_crtc_funcs dce_v11_0_crtc_funcs =3D {
> -	.cursor_set2 =3D dce_v11_0_crtc_cursor_set2,
> -	.cursor_move =3D dce_v11_0_crtc_cursor_move,
> -	.gamma_set =3D dce_v11_0_crtc_gamma_set,
> -	.set_config =3D amdgpu_display_crtc_set_config,
> -	.destroy =3D dce_v11_0_crtc_destroy,
> -	.page_flip_target =3D amdgpu_display_crtc_page_flip_target,
> -	.get_vblank_counter =3D amdgpu_get_vblank_counter_kms,
> -	.enable_vblank =3D amdgpu_enable_vblank_kms,
> -	.disable_vblank =3D amdgpu_disable_vblank_kms,
> -	.get_vblank_timestamp =3D
> drm_crtc_vblank_helper_get_vblank_timestamp,
> -};
> -
> -static void dce_v11_0_crtc_dpms(struct drm_crtc *crtc, int mode)
> -{
> -	struct drm_device *dev =3D crtc->dev;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> -	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -	unsigned type;
> -
> -	switch (mode) {
> -	case DRM_MODE_DPMS_ON:
> -		amdgpu_crtc->enabled =3D true;
> -		amdgpu_atombios_crtc_enable(crtc, ATOM_ENABLE);
> -		dce_v11_0_vga_enable(crtc, true);
> -		amdgpu_atombios_crtc_blank(crtc, ATOM_DISABLE);
> -		dce_v11_0_vga_enable(crtc, false);
> -		/* Make sure VBLANK and PFLIP interrupts are still
> enabled */
> -		type =3D amdgpu_display_crtc_idx_to_irq_type(adev,
> -						amdgpu_crtc-
> >crtc_id);
> -		amdgpu_irq_update(adev, &adev->crtc_irq, type);
> -		amdgpu_irq_update(adev, &adev->pageflip_irq, type);
> -		drm_crtc_vblank_on(crtc);
> -		dce_v11_0_crtc_load_lut(crtc);
> -		break;
> -	case DRM_MODE_DPMS_STANDBY:
> -	case DRM_MODE_DPMS_SUSPEND:
> -	case DRM_MODE_DPMS_OFF:
> -		drm_crtc_vblank_off(crtc);
> -		if (amdgpu_crtc->enabled) {
> -			dce_v11_0_vga_enable(crtc, true);
> -			amdgpu_atombios_crtc_blank(crtc,
> ATOM_ENABLE);
> -			dce_v11_0_vga_enable(crtc, false);
> -		}
> -		amdgpu_atombios_crtc_enable(crtc, ATOM_DISABLE);
> -		amdgpu_crtc->enabled =3D false;
> -		break;
> -	}
> -	/* adjust pm to dpms */
> -	amdgpu_dpm_compute_clocks(adev);
> -}
> -
> -static void dce_v11_0_crtc_prepare(struct drm_crtc *crtc)
> -{
> -	/* disable crtc pair power gating before programming */
> -	amdgpu_atombios_crtc_powergate(crtc, ATOM_DISABLE);
> -	amdgpu_atombios_crtc_lock(crtc, ATOM_ENABLE);
> -	dce_v11_0_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
> -}
> -
> -static void dce_v11_0_crtc_commit(struct drm_crtc *crtc)
> -{
> -	dce_v11_0_crtc_dpms(crtc, DRM_MODE_DPMS_ON);
> -	amdgpu_atombios_crtc_lock(crtc, ATOM_DISABLE);
> -}
> -
> -static void dce_v11_0_crtc_disable(struct drm_crtc *crtc)
> -{
> -	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -	struct drm_device *dev =3D crtc->dev;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> -	struct amdgpu_atom_ss ss;
> -	int i;
> -
> -	dce_v11_0_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
> -	if (crtc->primary->fb) {
> -		int r;
> -		struct amdgpu_bo *abo;
> -
> -		abo =3D gem_to_amdgpu_bo(crtc->primary->fb->obj[0]);
> -		r =3D amdgpu_bo_reserve(abo, true);
> -		if (unlikely(r))
> -			DRM_ERROR("failed to reserve abo before
> unpin\n");
> -		else {
> -			amdgpu_bo_unpin(abo);
> -			amdgpu_bo_unreserve(abo);
> -		}
> -	}
> -	/* disable the GRPH */
> -	dce_v11_0_grph_enable(crtc, false);
> -
> -	amdgpu_atombios_crtc_powergate(crtc, ATOM_ENABLE);
> -
> -	for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> -		if (adev->mode_info.crtcs[i] &&
> -		=C2=A0=C2=A0=C2=A0 adev->mode_info.crtcs[i]->enabled &&
> -		=C2=A0=C2=A0=C2=A0 i !=3D amdgpu_crtc->crtc_id &&
> -		=C2=A0=C2=A0=C2=A0 amdgpu_crtc->pll_id =3D=3D adev->mode_info.crtcs[i]=
-
> >pll_id) {
> -			/* one other crtc is using this pll don't
> turn
> -			 * off the pll
> -			 */
> -			goto done;
> -		}
> -	}
> -
> -	switch (amdgpu_crtc->pll_id) {
> -	case ATOM_PPLL0:
> -	case ATOM_PPLL1:
> -	case ATOM_PPLL2:
> -		/* disable the ppll */
> -		amdgpu_atombios_crtc_program_pll(crtc, amdgpu_crtc-
> >crtc_id, amdgpu_crtc->pll_id,
> -						 0, 0, ATOM_DISABLE,
> 0, 0, 0, 0, 0, false, &ss);
> -		break;
> -	case ATOM_COMBOPHY_PLL0:
> -	case ATOM_COMBOPHY_PLL1:
> -	case ATOM_COMBOPHY_PLL2:
> -	case ATOM_COMBOPHY_PLL3:
> -	case ATOM_COMBOPHY_PLL4:
> -	case ATOM_COMBOPHY_PLL5:
> -		/* disable the ppll */
> -		amdgpu_atombios_crtc_program_pll(crtc,
> ATOM_CRTC_INVALID, amdgpu_crtc->pll_id,
> -						 0, 0, ATOM_DISABLE,
> 0, 0, 0, 0, 0, false, &ss);
> -		break;
> -	default:
> -		break;
> -	}
> -done:
> -	amdgpu_crtc->pll_id =3D ATOM_PPLL_INVALID;
> -	amdgpu_crtc->adjusted_clock =3D 0;
> -	amdgpu_crtc->encoder =3D NULL;
> -	amdgpu_crtc->connector =3D NULL;
> -}
> -
> -static int dce_v11_0_crtc_mode_set(struct drm_crtc *crtc,
> -				=C2=A0 struct drm_display_mode *mode,
> -				=C2=A0 struct drm_display_mode
> *adjusted_mode,
> -				=C2=A0 int x, int y, struct
> drm_framebuffer *old_fb)
> -{
> -	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -	struct drm_device *dev =3D crtc->dev;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> -
> -	if (!amdgpu_crtc->adjusted_clock)
> -		return -EINVAL;
> -
> -	if ((adev->asic_type =3D=3D CHIP_POLARIS10) ||
> -	=C2=A0=C2=A0=C2=A0 (adev->asic_type =3D=3D CHIP_POLARIS11) ||
> -	=C2=A0=C2=A0=C2=A0 (adev->asic_type =3D=3D CHIP_POLARIS12) ||
> -	=C2=A0=C2=A0=C2=A0 (adev->asic_type =3D=3D CHIP_VEGAM)) {
> -		struct amdgpu_encoder *amdgpu_encoder =3D
> -			to_amdgpu_encoder(amdgpu_crtc->encoder);
> -		int encoder_mode =3D
> -
> 			amdgpu_atombios_encoder_get_encoder_mode(amdgpu_crtc->encoder);
> -
> -		/* SetPixelClock calculates the plls and ss values
> now */
> -		amdgpu_atombios_crtc_program_pll(crtc, amdgpu_crtc-
> >crtc_id,
> -						 amdgpu_crtc-
> >pll_id,
> -						 encoder_mode,
> amdgpu_encoder->encoder_id,
> -						 adjusted_mode-
> >clock, 0, 0, 0, 0,
> -						 amdgpu_crtc->bpc,
> amdgpu_crtc->ss_enabled, &amdgpu_crtc->ss);
> -	} else {
> -		amdgpu_atombios_crtc_set_pll(crtc, adjusted_mode);
> -	}
> -	amdgpu_atombios_crtc_set_dtd_timing(crtc, adjusted_mode);
> -	dce_v11_0_crtc_do_set_base(crtc, old_fb, x, y, 0);
> -	amdgpu_atombios_crtc_overscan_setup(crtc, mode,
> adjusted_mode);
> -	amdgpu_atombios_crtc_scaler_setup(crtc);
> -	dce_v11_0_cursor_reset(crtc);
> -	/* update the hw version fpr dpm */
> -	amdgpu_crtc->hw_mode =3D *adjusted_mode;
> -
> -	return 0;
> -}
> -
> -static bool dce_v11_0_crtc_mode_fixup(struct drm_crtc *crtc,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 const struct drm_display_mode
> *mode,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_display_mode
> *adjusted_mode)
> -{
> -	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> -	struct drm_device *dev =3D crtc->dev;
> -	struct drm_encoder *encoder;
> -
> -	/* assign the encoder to the amdgpu crtc to avoid repeated
> lookups later */
> -	list_for_each_entry(encoder, &dev->mode_config.encoder_list,
> head) {
> -		if (encoder->crtc =3D=3D crtc) {
> -			amdgpu_crtc->encoder =3D encoder;
> -			amdgpu_crtc->connector =3D
> amdgpu_get_connector_for_encoder(encoder);
> -			break;
> -		}
> -	}
> -	if ((amdgpu_crtc->encoder =3D=3D NULL) || (amdgpu_crtc-
> >connector =3D=3D NULL)) {
> -		amdgpu_crtc->encoder =3D NULL;
> -		amdgpu_crtc->connector =3D NULL;
> -		return false;
> -	}
> -	if (!amdgpu_display_crtc_scaling_mode_fixup(crtc, mode,
> adjusted_mode))
> -		return false;
> -	if (amdgpu_atombios_crtc_prepare_pll(crtc, adjusted_mode))
> -		return false;
> -	/* pick pll */
> -	amdgpu_crtc->pll_id =3D dce_v11_0_pick_pll(crtc);
> -	/* if we can't get a PPLL for a non-DP encoder, fail */
> -	if ((amdgpu_crtc->pll_id =3D=3D ATOM_PPLL_INVALID) &&
> -	=C2=A0=C2=A0=C2=A0
> !ENCODER_MODE_IS_DP(amdgpu_atombios_encoder_get_encoder_mode(amdgpu_c
> rtc->encoder)))
> -		return false;
> -
> -	return true;
> -}
> -
> -static int dce_v11_0_crtc_set_base(struct drm_crtc *crtc, int x, int
> y,
> -				=C2=A0 struct drm_framebuffer *old_fb)
> -{
> -	return dce_v11_0_crtc_do_set_base(crtc, old_fb, x, y, 0);
> -}
> -
> -static int dce_v11_0_crtc_set_base_atomic(struct drm_crtc *crtc,
> -					 struct drm_framebuffer *fb,
> -					 int x, int y, enum
> mode_set_atomic state)
> -{
> -	return dce_v11_0_crtc_do_set_base(crtc, fb, x, y, 1);
> -}
> -
> -static const struct drm_crtc_helper_funcs
> dce_v11_0_crtc_helper_funcs =3D {
> -	.dpms =3D dce_v11_0_crtc_dpms,
> -	.mode_fixup =3D dce_v11_0_crtc_mode_fixup,
> -	.mode_set =3D dce_v11_0_crtc_mode_set,
> -	.mode_set_base =3D dce_v11_0_crtc_set_base,
> -	.mode_set_base_atomic =3D dce_v11_0_crtc_set_base_atomic,
> -	.prepare =3D dce_v11_0_crtc_prepare,
> -	.commit =3D dce_v11_0_crtc_commit,
> -	.disable =3D dce_v11_0_crtc_disable,
> -	.get_scanout_position =3D amdgpu_crtc_get_scanout_position,
> -};
> -
> -static void dce_v11_0_panic_flush(struct drm_plane *plane)
> -{
> -	struct drm_framebuffer *fb;
> -	struct amdgpu_crtc *amdgpu_crtc;
> -	struct amdgpu_device *adev;
> -	uint32_t fb_format;
> -
> -	if (!plane->fb)
> -		return;
> -
> -	fb =3D plane->fb;
> -	amdgpu_crtc =3D to_amdgpu_crtc(plane->crtc);
> -	adev =3D drm_to_adev(fb->dev);
> -
> -	/* Disable DC tiling */
> -	fb_format =3D RREG32(mmGRPH_CONTROL + amdgpu_crtc-
> >crtc_offset);
> -	fb_format &=3D ~GRPH_CONTROL__GRPH_ARRAY_MODE_MASK;
> -	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset,
> fb_format);
> -
> -}
> -
> -static const struct drm_plane_helper_funcs
> dce_v11_0_drm_primary_plane_helper_funcs =3D {
> -	.get_scanout_buffer =3D amdgpu_display_get_scanout_buffer,
> -	.panic_flush =3D dce_v11_0_panic_flush,
> -};
> -
> -static int dce_v11_0_crtc_init(struct amdgpu_device *adev, int
> index)
> -{
> -	struct amdgpu_crtc *amdgpu_crtc;
> -
> -	amdgpu_crtc =3D kzalloc(sizeof(struct amdgpu_crtc) +
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (AMDGPUFB_CONN_LIMIT * sizeof(struct
> drm_connector *)), GFP_KERNEL);
> -	if (amdgpu_crtc =3D=3D NULL)
> -		return -ENOMEM;
> -
> -	drm_crtc_init(adev_to_drm(adev), &amdgpu_crtc->base,
> &dce_v11_0_crtc_funcs);
> -
> -	drm_mode_crtc_set_gamma_size(&amdgpu_crtc->base, 256);
> -	amdgpu_crtc->crtc_id =3D index;
> -	adev->mode_info.crtcs[index] =3D amdgpu_crtc;
> -
> -	amdgpu_crtc->max_cursor_width =3D 128;
> -	amdgpu_crtc->max_cursor_height =3D 128;
> -	adev_to_drm(adev)->mode_config.cursor_width =3D amdgpu_crtc-
> >max_cursor_width;
> -	adev_to_drm(adev)->mode_config.cursor_height =3D amdgpu_crtc-
> >max_cursor_height;
> -
> -	switch (amdgpu_crtc->crtc_id) {
> -	case 0:
> -	default:
> -		amdgpu_crtc->crtc_offset =3D CRTC0_REGISTER_OFFSET;
> -		break;
> -	case 1:
> -		amdgpu_crtc->crtc_offset =3D CRTC1_REGISTER_OFFSET;
> -		break;
> -	case 2:
> -		amdgpu_crtc->crtc_offset =3D CRTC2_REGISTER_OFFSET;
> -		break;
> -	case 3:
> -		amdgpu_crtc->crtc_offset =3D CRTC3_REGISTER_OFFSET;
> -		break;
> -	case 4:
> -		amdgpu_crtc->crtc_offset =3D CRTC4_REGISTER_OFFSET;
> -		break;
> -	case 5:
> -		amdgpu_crtc->crtc_offset =3D CRTC5_REGISTER_OFFSET;
> -		break;
> -	}
> -
> -	amdgpu_crtc->pll_id =3D ATOM_PPLL_INVALID;
> -	amdgpu_crtc->adjusted_clock =3D 0;
> -	amdgpu_crtc->encoder =3D NULL;
> -	amdgpu_crtc->connector =3D NULL;
> -	drm_crtc_helper_add(&amdgpu_crtc->base,
> &dce_v11_0_crtc_helper_funcs);
> -	drm_plane_helper_add(amdgpu_crtc->base.primary,
> &dce_v11_0_drm_primary_plane_helper_funcs);
> -
> -	return 0;
> -}
> -
> -static int dce_v11_0_early_init(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev =3D ip_block->adev;
> -
> -	adev->audio_endpt_rreg =3D &dce_v11_0_audio_endpt_rreg;
> -	adev->audio_endpt_wreg =3D &dce_v11_0_audio_endpt_wreg;
> -
> -	dce_v11_0_set_display_funcs(adev);
> -
> -	adev->mode_info.num_crtc =3D dce_v11_0_get_num_crtc(adev);
> -
> -	switch (adev->asic_type) {
> -	case CHIP_CARRIZO:
> -		adev->mode_info.num_hpd =3D 6;
> -		adev->mode_info.num_dig =3D 9;
> -		break;
> -	case CHIP_STONEY:
> -		adev->mode_info.num_hpd =3D 6;
> -		adev->mode_info.num_dig =3D 9;
> -		break;
> -	case CHIP_POLARIS10:
> -	case CHIP_VEGAM:
> -		adev->mode_info.num_hpd =3D 6;
> -		adev->mode_info.num_dig =3D 6;
> -		break;
> -	case CHIP_POLARIS11:
> -	case CHIP_POLARIS12:
> -		adev->mode_info.num_hpd =3D 5;
> -		adev->mode_info.num_dig =3D 5;
> -		break;
> -	default:
> -		/* FIXME: not supported yet */
> -		return -EINVAL;
> -	}
> -
> -	dce_v11_0_set_irq_funcs(adev);
> -
> -	return 0;
> -}
> -
> -static int dce_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
> -{
> -	int r, i;
> -	struct amdgpu_device *adev =3D ip_block->adev;
> -
> -	for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> -		r =3D amdgpu_irq_add_id(adev,
> AMDGPU_IRQ_CLIENTID_LEGACY, i + 1, &adev->crtc_irq);
> -		if (r)
> -			return r;
> -	}
> -
> -	for (i =3D VISLANDS30_IV_SRCID_D1_GRPH_PFLIP; i < 20; i +=3D 2)
> {
> -		r =3D amdgpu_irq_add_id(adev,
> AMDGPU_IRQ_CLIENTID_LEGACY, i, &adev->pageflip_irq);
> -		if (r)
> -			return r;
> -	}
> -
> -	/* HPD hotplug */
> -	r =3D amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY,
> VISLANDS30_IV_SRCID_HOTPLUG_DETECT_A, &adev->hpd_irq);
> -	if (r)
> -		return r;
> -
> -	adev_to_drm(adev)->mode_config.funcs =3D &amdgpu_mode_funcs;
> -
> -	adev_to_drm(adev)->mode_config.async_page_flip =3D true;
> -
> -	adev_to_drm(adev)->mode_config.max_width =3D 16384;
> -	adev_to_drm(adev)->mode_config.max_height =3D 16384;
> -
> -	adev_to_drm(adev)->mode_config.preferred_depth =3D 24;
> -	adev_to_drm(adev)->mode_config.prefer_shadow =3D 1;
> -
> -	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported =3D
> true;
> -
> -	r =3D amdgpu_display_modeset_create_props(adev);
> -	if (r)
> -		return r;
> -
> -	adev_to_drm(adev)->mode_config.max_width =3D 16384;
> -	adev_to_drm(adev)->mode_config.max_height =3D 16384;
> -
> -
> -	/* allocate crtcs */
> -	for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> -		r =3D dce_v11_0_crtc_init(adev, i);
> -		if (r)
> -			return r;
> -	}
> -
> -	if
> (amdgpu_atombios_get_connector_info_from_object_table(adev))
> -
> 		amdgpu_display_print_display_setup(adev_to_drm(adev));
> -	else
> -		return -EINVAL;
> -
> -	/* setup afmt */
> -	r =3D dce_v11_0_afmt_init(adev);
> -	if (r)
> -		return r;
> -
> -	r =3D dce_v11_0_audio_init(adev);
> -	if (r)
> -		return r;
> -
> -	/* Disable vblank IRQs aggressively for power-saving */
> -	/* XXX: can this be enabled for DC? */
> -	adev_to_drm(adev)->vblank_disable_immediate =3D true;
> -
> -	r =3D drm_vblank_init(adev_to_drm(adev), adev-
> >mode_info.num_crtc);
> -	if (r)
> -		return r;
> -
> -	INIT_DELAYED_WORK(&adev->hotplug_work,
> -		=C2=A0 amdgpu_display_hotplug_work_func);
> -
> -	drm_kms_helper_poll_init(adev_to_drm(adev));
> -
> -	adev->mode_info.mode_config_initialized =3D true;
> -	return 0;
> -}
> -
> -static int dce_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev =3D ip_block->adev;
> -
> -	drm_edid_free(adev->mode_info.bios_hardcoded_edid);
> -
> -	drm_kms_helper_poll_fini(adev_to_drm(adev));
> -
> -	dce_v11_0_audio_fini(adev);
> -
> -	dce_v11_0_afmt_fini(adev);
> -
> -	drm_mode_config_cleanup(adev_to_drm(adev));
> -	adev->mode_info.mode_config_initialized =3D false;
> -
> -	return 0;
> -}
> -
> -static int dce_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
> -{
> -	int i;
> -	struct amdgpu_device *adev =3D ip_block->adev;
> -
> -	dce_v11_0_init_golden_registers(adev);
> -
> -	/* disable vga render */
> -	dce_v11_0_set_vga_render_state(adev, false);
> -	/* init dig PHYs, disp eng pll */
> -	amdgpu_atombios_crtc_powergate_init(adev);
> -	amdgpu_atombios_encoder_init_dig(adev);
> -	if ((adev->asic_type =3D=3D CHIP_POLARIS10) ||
> -	=C2=A0=C2=A0=C2=A0 (adev->asic_type =3D=3D CHIP_POLARIS11) ||
> -	=C2=A0=C2=A0=C2=A0 (adev->asic_type =3D=3D CHIP_POLARIS12) ||
> -	=C2=A0=C2=A0=C2=A0 (adev->asic_type =3D=3D CHIP_VEGAM)) {
> -		amdgpu_atombios_crtc_set_dce_clock(adev, adev-
> >clock.default_dispclk,
> -						=C2=A0=C2=A0
> DCE_CLOCK_TYPE_DISPCLK, ATOM_GCK_DFS);
> -		amdgpu_atombios_crtc_set_dce_clock(adev, 0,
> -						=C2=A0=C2=A0
> DCE_CLOCK_TYPE_DPREFCLK, ATOM_GCK_DFS);
> -	} else {
> -		amdgpu_atombios_crtc_set_disp_eng_pll(adev, adev-
> >clock.default_dispclk);
> -	}
> -
> -	/* initialize hpd */
> -	dce_v11_0_hpd_init(adev);
> -
> -	for (i =3D 0; i < adev->mode_info.audio.num_pins; i++) {
> -		dce_v11_0_audio_enable(adev, &adev-
> >mode_info.audio.pin[i], false);
> -	}
> -
> -	dce_v11_0_pageflip_interrupt_init(adev);
> -
> -	return 0;
> -}
> -
> -static int dce_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
> -{
> -	int i;
> -	struct amdgpu_device *adev =3D ip_block->adev;
> -
> -	dce_v11_0_hpd_fini(adev);
> -
> -	for (i =3D 0; i < adev->mode_info.audio.num_pins; i++) {
> -		dce_v11_0_audio_enable(adev, &adev-
> >mode_info.audio.pin[i], false);
> -	}
> -
> -	dce_v11_0_pageflip_interrupt_fini(adev);
> -
> -	flush_delayed_work(&adev->hotplug_work);
> -
> -	return 0;
> -}
> -
> -static int dce_v11_0_suspend(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev =3D ip_block->adev;
> -	int r;
> -
> -	r =3D amdgpu_display_suspend_helper(adev);
> -	if (r)
> -		return r;
> -
> -	adev->mode_info.bl_level =3D
> -
> 		amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
> -
> -	return dce_v11_0_hw_fini(ip_block);
> -}
> -
> -static int dce_v11_0_resume(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev =3D ip_block->adev;
> -	int ret;
> -
> -	amdgpu_atombios_encoder_set_backlight_level_to_reg(adev,
> -							=C2=A0=C2=A0 adev-
> >mode_info.bl_level);
> -
> -	ret =3D dce_v11_0_hw_init(ip_block);
> -
> -	/* turn on the BL */
> -	if (adev->mode_info.bl_encoder) {
> -		u8 bl_level =3D
> amdgpu_display_backlight_get_level(adev,
> -								=C2=A0
> adev->mode_info.bl_encoder);
> -		amdgpu_display_backlight_set_level(adev, adev-
> >mode_info.bl_encoder,
> -						=C2=A0=C2=A0=C2=A0 bl_level);
> -	}
> -	if (ret)
> -		return ret;
> -
> -	return amdgpu_display_resume_helper(adev);
> -}
> -
> -static bool dce_v11_0_is_idle(struct amdgpu_ip_block *ip_block)
> -{
> -	return true;
> -}
> -
> -static int dce_v11_0_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	u32 srbm_soft_reset =3D 0, tmp;
> -	struct amdgpu_device *adev =3D ip_block->adev;
> -
> -	if (dce_v11_0_is_display_hung(adev))
> -		srbm_soft_reset |=3D
> SRBM_SOFT_RESET__SOFT_RESET_DC_MASK;
> -
> -	if (srbm_soft_reset) {
> -		tmp =3D RREG32(mmSRBM_SOFT_RESET);
> -		tmp |=3D srbm_soft_reset;
> -		dev_info(adev->dev, "SRBM_SOFT_RESET=3D0x%08X\n",
> tmp);
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp =3D RREG32(mmSRBM_SOFT_RESET);
> -
> -		udelay(50);
> -
> -		tmp &=3D ~srbm_soft_reset;
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp =3D RREG32(mmSRBM_SOFT_RESET);
> -
> -		/* Wait a little for things to settle down */
> -		udelay(50);
> -	}
> -	return 0;
> -}
> -
> -static void dce_v11_0_set_crtc_vblank_interrupt_state(struct
> amdgpu_device *adev,
> -						=C2=A0=C2=A0=C2=A0=C2=A0 int crtc,
> -						=C2=A0=C2=A0=C2=A0=C2=A0 enum
> amdgpu_interrupt_state state)
> -{
> -	u32 lb_interrupt_mask;
> -
> -	if (crtc >=3D adev->mode_info.num_crtc) {
> -		DRM_DEBUG("invalid crtc %d\n", crtc);
> -		return;
> -	}
> -
> -	switch (state) {
> -	case AMDGPU_IRQ_STATE_DISABLE:
> -		lb_interrupt_mask =3D RREG32(mmLB_INTERRUPT_MASK +
> crtc_offsets[crtc]);
> -		lb_interrupt_mask =3D REG_SET_FIELD(lb_interrupt_mask,
> LB_INTERRUPT_MASK,
> -						=C2=A0
> VBLANK_INTERRUPT_MASK, 0);
> -		WREG32(mmLB_INTERRUPT_MASK + crtc_offsets[crtc],
> lb_interrupt_mask);
> -		break;
> -	case AMDGPU_IRQ_STATE_ENABLE:
> -		lb_interrupt_mask =3D RREG32(mmLB_INTERRUPT_MASK +
> crtc_offsets[crtc]);
> -		lb_interrupt_mask =3D REG_SET_FIELD(lb_interrupt_mask,
> LB_INTERRUPT_MASK,
> -						=C2=A0
> VBLANK_INTERRUPT_MASK, 1);
> -		WREG32(mmLB_INTERRUPT_MASK + crtc_offsets[crtc],
> lb_interrupt_mask);
> -		break;
> -	default:
> -		break;
> -	}
> -}
> -
> -static void dce_v11_0_set_crtc_vline_interrupt_state(struct
> amdgpu_device *adev,
> -						=C2=A0=C2=A0=C2=A0 int crtc,
> -						=C2=A0=C2=A0=C2=A0 enum
> amdgpu_interrupt_state state)
> -{
> -	u32 lb_interrupt_mask;
> -
> -	if (crtc >=3D adev->mode_info.num_crtc) {
> -		DRM_DEBUG("invalid crtc %d\n", crtc);
> -		return;
> -	}
> -
> -	switch (state) {
> -	case AMDGPU_IRQ_STATE_DISABLE:
> -		lb_interrupt_mask =3D RREG32(mmLB_INTERRUPT_MASK +
> crtc_offsets[crtc]);
> -		lb_interrupt_mask =3D REG_SET_FIELD(lb_interrupt_mask,
> LB_INTERRUPT_MASK,
> -						=C2=A0
> VLINE_INTERRUPT_MASK, 0);
> -		WREG32(mmLB_INTERRUPT_MASK + crtc_offsets[crtc],
> lb_interrupt_mask);
> -		break;
> -	case AMDGPU_IRQ_STATE_ENABLE:
> -		lb_interrupt_mask =3D RREG32(mmLB_INTERRUPT_MASK +
> crtc_offsets[crtc]);
> -		lb_interrupt_mask =3D REG_SET_FIELD(lb_interrupt_mask,
> LB_INTERRUPT_MASK,
> -						=C2=A0
> VLINE_INTERRUPT_MASK, 1);
> -		WREG32(mmLB_INTERRUPT_MASK + crtc_offsets[crtc],
> lb_interrupt_mask);
> -		break;
> -	default:
> -		break;
> -	}
> -}
> -
> -static int dce_v11_0_set_hpd_irq_state(struct amdgpu_device *adev,
> -					struct amdgpu_irq_src
> *source,
> -					unsigned hpd,
> -					enum amdgpu_interrupt_state
> state)
> -{
> -	u32 tmp;
> -
> -	if (hpd >=3D adev->mode_info.num_hpd) {
> -		DRM_DEBUG("invalid hpd %d\n", hpd);
> -		return 0;
> -	}
> -
> -	switch (state) {
> -	case AMDGPU_IRQ_STATE_DISABLE:
> -		tmp =3D RREG32(mmDC_HPD_INT_CONTROL +
> hpd_offsets[hpd]);
> -		tmp =3D REG_SET_FIELD(tmp, DC_HPD_INT_CONTROL,
> DC_HPD_INT_EN, 0);
> -		WREG32(mmDC_HPD_INT_CONTROL + hpd_offsets[hpd],
> tmp);
> -		break;
> -	case AMDGPU_IRQ_STATE_ENABLE:
> -		tmp =3D RREG32(mmDC_HPD_INT_CONTROL +
> hpd_offsets[hpd]);
> -		tmp =3D REG_SET_FIELD(tmp, DC_HPD_INT_CONTROL,
> DC_HPD_INT_EN, 1);
> -		WREG32(mmDC_HPD_INT_CONTROL + hpd_offsets[hpd],
> tmp);
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	return 0;
> -}
> -
> -static int dce_v11_0_set_crtc_irq_state(struct amdgpu_device *adev,
> -					struct amdgpu_irq_src
> *source,
> -					unsigned type,
> -					enum amdgpu_interrupt_state
> state)
> -{
> -	switch (type) {
> -	case AMDGPU_CRTC_IRQ_VBLANK1:
> -		dce_v11_0_set_crtc_vblank_interrupt_state(adev, 0,
> state);
> -		break;
> -	case AMDGPU_CRTC_IRQ_VBLANK2:
> -		dce_v11_0_set_crtc_vblank_interrupt_state(adev, 1,
> state);
> -		break;
> -	case AMDGPU_CRTC_IRQ_VBLANK3:
> -		dce_v11_0_set_crtc_vblank_interrupt_state(adev, 2,
> state);
> -		break;
> -	case AMDGPU_CRTC_IRQ_VBLANK4:
> -		dce_v11_0_set_crtc_vblank_interrupt_state(adev, 3,
> state);
> -		break;
> -	case AMDGPU_CRTC_IRQ_VBLANK5:
> -		dce_v11_0_set_crtc_vblank_interrupt_state(adev, 4,
> state);
> -		break;
> -	case AMDGPU_CRTC_IRQ_VBLANK6:
> -		dce_v11_0_set_crtc_vblank_interrupt_state(adev, 5,
> state);
> -		break;
> -	case AMDGPU_CRTC_IRQ_VLINE1:
> -		dce_v11_0_set_crtc_vline_interrupt_state(adev, 0,
> state);
> -		break;
> -	case AMDGPU_CRTC_IRQ_VLINE2:
> -		dce_v11_0_set_crtc_vline_interrupt_state(adev, 1,
> state);
> -		break;
> -	case AMDGPU_CRTC_IRQ_VLINE3:
> -		dce_v11_0_set_crtc_vline_interrupt_state(adev, 2,
> state);
> -		break;
> -	case AMDGPU_CRTC_IRQ_VLINE4:
> -		dce_v11_0_set_crtc_vline_interrupt_state(adev, 3,
> state);
> -		break;
> -	case AMDGPU_CRTC_IRQ_VLINE5:
> -		dce_v11_0_set_crtc_vline_interrupt_state(adev, 4,
> state);
> -		break;
> -	 case AMDGPU_CRTC_IRQ_VLINE6:
> -		dce_v11_0_set_crtc_vline_interrupt_state(adev, 5,
> state);
> -		break;
> -	default:
> -		break;
> -	}
> -	return 0;
> -}
> -
> -static int dce_v11_0_set_pageflip_irq_state(struct amdgpu_device
> *adev,
> -					=C2=A0=C2=A0=C2=A0 struct amdgpu_irq_src
> *src,
> -					=C2=A0=C2=A0=C2=A0 unsigned type,
> -					=C2=A0=C2=A0=C2=A0 enum
> amdgpu_interrupt_state state)
> -{
> -	u32 reg;
> -
> -	if (type >=3D adev->mode_info.num_crtc) {
> -		DRM_ERROR("invalid pageflip crtc %d\n", type);
> -		return -EINVAL;
> -	}
> -
> -	reg =3D RREG32(mmGRPH_INTERRUPT_CONTROL + crtc_offsets[type]);
> -	if (state =3D=3D AMDGPU_IRQ_STATE_DISABLE)
> -		WREG32(mmGRPH_INTERRUPT_CONTROL +
> crtc_offsets[type],
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg &
> ~GRPH_INTERRUPT_CONTROL__GRPH_PFLIP_INT_MASK_MASK);
> -	else
> -		WREG32(mmGRPH_INTERRUPT_CONTROL +
> crtc_offsets[type],
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg |
> GRPH_INTERRUPT_CONTROL__GRPH_PFLIP_INT_MASK_MASK);
> -
> -	return 0;
> -}
> -
> -static int dce_v11_0_pageflip_irq(struct amdgpu_device *adev,
> -				=C2=A0 struct amdgpu_irq_src *source,
> -				=C2=A0 struct amdgpu_iv_entry *entry)
> -{
> -	unsigned long flags;
> -	unsigned crtc_id;
> -	struct amdgpu_crtc *amdgpu_crtc;
> -	struct amdgpu_flip_work *works;
> -
> -	crtc_id =3D (entry->src_id - 8) >> 1;
> -	amdgpu_crtc =3D adev->mode_info.crtcs[crtc_id];
> -
> -	if (crtc_id >=3D adev->mode_info.num_crtc) {
> -		DRM_ERROR("invalid pageflip crtc %d\n", crtc_id);
> -		return -EINVAL;
> -	}
> -
> -	if (RREG32(mmGRPH_INTERRUPT_STATUS + crtc_offsets[crtc_id])
> &
> -	=C2=A0=C2=A0=C2=A0 GRPH_INTERRUPT_STATUS__GRPH_PFLIP_INT_OCCURRED_MASK)
> -		WREG32(mmGRPH_INTERRUPT_STATUS +
> crtc_offsets[crtc_id],
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> GRPH_INTERRUPT_STATUS__GRPH_PFLIP_INT_CLEAR_MASK);
> -
> -	/* IRQ could occur when in initial stage */
> -	if(amdgpu_crtc =3D=3D NULL)
> -		return 0;
> -
> -	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
> -	works =3D amdgpu_crtc->pflip_works;
> -	if (amdgpu_crtc->pflip_status !=3D AMDGPU_FLIP_SUBMITTED){
> -		DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status =3D %d !=3D
> "
> -					=09
> "AMDGPU_FLIP_SUBMITTED(%d)\n",
> -						 amdgpu_crtc-
> >pflip_status,
> -					=09
> AMDGPU_FLIP_SUBMITTED);
> -		spin_unlock_irqrestore(&adev_to_drm(adev)-
> >event_lock, flags);
> -		return 0;
> -	}
> -
> -	/* page flip completed. clean up */
> -	amdgpu_crtc->pflip_status =3D AMDGPU_FLIP_NONE;
> -	amdgpu_crtc->pflip_works =3D NULL;
> -
> -	/* wakeup usersapce */
> -	if(works->event)
> -		drm_crtc_send_vblank_event(&amdgpu_crtc->base,
> works->event);
> -
> -	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock,
> flags);
> -
> -	drm_crtc_vblank_put(&amdgpu_crtc->base);
> -	schedule_work(&works->unpin_work);
> -
> -	return 0;
> -}
> -
> -static void dce_v11_0_hpd_int_ack(struct amdgpu_device *adev,
> -				=C2=A0 int hpd)
> -{
> -	u32 tmp;
> -
> -	if (hpd >=3D adev->mode_info.num_hpd) {
> -		DRM_DEBUG("invalid hpd %d\n", hpd);
> -		return;
> -	}
> -
> -	tmp =3D RREG32(mmDC_HPD_INT_CONTROL + hpd_offsets[hpd]);
> -	tmp =3D REG_SET_FIELD(tmp, DC_HPD_INT_CONTROL, DC_HPD_INT_ACK,
> 1);
> -	WREG32(mmDC_HPD_INT_CONTROL + hpd_offsets[hpd], tmp);
> -}
> -
> -static void dce_v11_0_crtc_vblank_int_ack(struct amdgpu_device
> *adev,
> -					=C2=A0 int crtc)
> -{
> -	u32 tmp;
> -
> -	if (crtc < 0 || crtc >=3D adev->mode_info.num_crtc) {
> -		DRM_DEBUG("invalid crtc %d\n", crtc);
> -		return;
> -	}
> -
> -	tmp =3D RREG32(mmLB_VBLANK_STATUS + crtc_offsets[crtc]);
> -	tmp =3D REG_SET_FIELD(tmp, LB_VBLANK_STATUS, VBLANK_ACK, 1);
> -	WREG32(mmLB_VBLANK_STATUS + crtc_offsets[crtc], tmp);
> -}
> -
> -static void dce_v11_0_crtc_vline_int_ack(struct amdgpu_device *adev,
> -					 int crtc)
> -{
> -	u32 tmp;
> -
> -	if (crtc < 0 || crtc >=3D adev->mode_info.num_crtc) {
> -		DRM_DEBUG("invalid crtc %d\n", crtc);
> -		return;
> -	}
> -
> -	tmp =3D RREG32(mmLB_VLINE_STATUS + crtc_offsets[crtc]);
> -	tmp =3D REG_SET_FIELD(tmp, LB_VLINE_STATUS, VLINE_ACK, 1);
> -	WREG32(mmLB_VLINE_STATUS + crtc_offsets[crtc], tmp);
> -}
> -
> -static int dce_v11_0_crtc_irq(struct amdgpu_device *adev,
> -				struct amdgpu_irq_src *source,
> -				struct amdgpu_iv_entry *entry)
> -{
> -	unsigned crtc =3D entry->src_id - 1;
> -	uint32_t disp_int =3D
> RREG32(interrupt_status_offsets[crtc].reg);
> -	unsigned int irq_type =3D
> amdgpu_display_crtc_idx_to_irq_type(adev,
> -								=C2=A0=C2=A0=C2=A0
> crtc);
> -
> -	switch (entry->src_data[0]) {
> -	case 0: /* vblank */
> -		if (disp_int &
> interrupt_status_offsets[crtc].vblank)
> -			dce_v11_0_crtc_vblank_int_ack(adev, crtc);
> -		else
> -			DRM_DEBUG("IH: IH event w/o asserted irq
> bit?\n");
> -
> -		if (amdgpu_irq_enabled(adev, source, irq_type)) {
> -			drm_handle_vblank(adev_to_drm(adev), crtc);
> -		}
> -		DRM_DEBUG("IH: D%d vblank\n", crtc + 1);
> -
> -		break;
> -	case 1: /* vline */
> -		if (disp_int & interrupt_status_offsets[crtc].vline)
> -			dce_v11_0_crtc_vline_int_ack(adev, crtc);
> -		else
> -			DRM_DEBUG("IH: IH event w/o asserted irq
> bit?\n");
> -
> -		DRM_DEBUG("IH: D%d vline\n", crtc + 1);
> -
> -		break;
> -	default:
> -		DRM_DEBUG("Unhandled interrupt: %d %d\n", entry-
> >src_id, entry->src_data[0]);
> -		break;
> -	}
> -
> -	return 0;
> -}
> -
> -static int dce_v11_0_hpd_irq(struct amdgpu_device *adev,
> -			=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_irq_src *source,
> -			=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_iv_entry *entry)
> -{
> -	uint32_t disp_int, mask;
> -	unsigned hpd;
> -
> -	if (entry->src_data[0] >=3D adev->mode_info.num_hpd) {
> -		DRM_DEBUG("Unhandled interrupt: %d %d\n", entry-
> >src_id, entry->src_data[0]);
> -		return 0;
> -	}
> -
> -	hpd =3D entry->src_data[0];
> -	disp_int =3D RREG32(interrupt_status_offsets[hpd].reg);
> -	mask =3D interrupt_status_offsets[hpd].hpd;
> -
> -	if (disp_int & mask) {
> -		dce_v11_0_hpd_int_ack(adev, hpd);
> -		schedule_delayed_work(&adev->hotplug_work, 0);
> -		DRM_DEBUG("IH: HPD%d\n", hpd + 1);
> -	}
> -
> -	return 0;
> -}
> -
> -static int dce_v11_0_set_clockgating_state(struct amdgpu_ip_block
> *ip_block,
> -					=C2=A0 enum amd_clockgating_state
> state)
> -{
> -	return 0;
> -}
> -
> -static int dce_v11_0_set_powergating_state(struct amdgpu_ip_block
> *ip_block,
> -					=C2=A0 enum amd_powergating_state
> state)
> -{
> -	return 0;
> -}
> -
> -static const struct amd_ip_funcs dce_v11_0_ip_funcs =3D {
> -	.name =3D "dce_v11_0",
> -	.early_init =3D dce_v11_0_early_init,
> -	.sw_init =3D dce_v11_0_sw_init,
> -	.sw_fini =3D dce_v11_0_sw_fini,
> -	.hw_init =3D dce_v11_0_hw_init,
> -	.hw_fini =3D dce_v11_0_hw_fini,
> -	.suspend =3D dce_v11_0_suspend,
> -	.resume =3D dce_v11_0_resume,
> -	.is_idle =3D dce_v11_0_is_idle,
> -	.soft_reset =3D dce_v11_0_soft_reset,
> -	.set_clockgating_state =3D dce_v11_0_set_clockgating_state,
> -	.set_powergating_state =3D dce_v11_0_set_powergating_state,
> -};
> -
> -static void dce_v11_0_encoder_mode_set(struct drm_encoder *encoder,
> -			=C2=A0 struct drm_display_mode *mode,
> -			=C2=A0 struct drm_display_mode *adjusted_mode)
> -{
> -	struct amdgpu_encoder *amdgpu_encoder =3D
> to_amdgpu_encoder(encoder);
> -
> -	amdgpu_encoder->pixel_clock =3D adjusted_mode->clock;
> -
> -	/* need to call this here rather than in prepare() since we
> need some crtc info */
> -	amdgpu_atombios_encoder_dpms(encoder, DRM_MODE_DPMS_OFF);
> -
> -	/* set scaler clears this on some chips */
> -	dce_v11_0_set_interleave(encoder->crtc, mode);
> -
> -	if (amdgpu_atombios_encoder_get_encoder_mode(encoder) =3D=3D
> ATOM_ENCODER_MODE_HDMI) {
> -		dce_v11_0_afmt_enable(encoder, true);
> -		dce_v11_0_afmt_setmode(encoder, adjusted_mode);
> -	}
> -}
> -
> -static void dce_v11_0_encoder_prepare(struct drm_encoder *encoder)
> -{
> -	struct amdgpu_device *adev =3D drm_to_adev(encoder->dev);
> -	struct amdgpu_encoder *amdgpu_encoder =3D
> to_amdgpu_encoder(encoder);
> -	struct drm_connector *connector =3D
> amdgpu_get_connector_for_encoder(encoder);
> -
> -	if ((amdgpu_encoder->active_device &
> -	=C2=A0=C2=A0=C2=A0=C2=A0 (ATOM_DEVICE_DFP_SUPPORT | ATOM_DEVICE_LCD_SUP=
PORT)) ||
> -	=C2=A0=C2=A0=C2=A0 (amdgpu_encoder_get_dp_bridge_encoder_id(encoder) !=
=3D
> -	=C2=A0=C2=A0=C2=A0=C2=A0 ENCODER_OBJECT_ID_NONE)) {
> -		struct amdgpu_encoder_atom_dig *dig =3D
> amdgpu_encoder->enc_priv;
> -		if (dig) {
> -			dig->dig_encoder =3D
> dce_v11_0_pick_dig_encoder(encoder);
> -			if (amdgpu_encoder->active_device &
> ATOM_DEVICE_DFP_SUPPORT)
> -				dig->afmt =3D adev-
> >mode_info.afmt[dig->dig_encoder];
> -		}
> -	}
> -
> -	amdgpu_atombios_scratch_regs_lock(adev, true);
> -
> -	if (connector) {
> -		struct amdgpu_connector *amdgpu_connector =3D
> to_amdgpu_connector(connector);
> -
> -		/* select the clock/data port if it uses a router */
> -		if (amdgpu_connector->router.cd_valid)
> -
> 			amdgpu_i2c_router_select_cd_port(amdgpu_connector);
> -
> -		/* turn eDP panel on for mode set */
> -		if (connector->connector_type =3D=3D
> DRM_MODE_CONNECTOR_eDP)
> -
> 			amdgpu_atombios_encoder_set_edp_panel_power(connector,
> -							=C2=A0=C2=A0=C2=A0=C2=A0
> ATOM_TRANSMITTER_ACTION_POWER_ON);
> -	}
> -
> -	/* this is needed for the pll/ss setup to work correctly in
> some cases */
> -	amdgpu_atombios_encoder_set_crtc_source(encoder);
> -	/* set up the FMT blocks */
> -	dce_v11_0_program_fmt(encoder);
> -}
> -
> -static void dce_v11_0_encoder_commit(struct drm_encoder *encoder)
> -{
> -	struct drm_device *dev =3D encoder->dev;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> -
> -	/* need to call this here as we need the crtc set up */
> -	amdgpu_atombios_encoder_dpms(encoder, DRM_MODE_DPMS_ON);
> -	amdgpu_atombios_scratch_regs_lock(adev, false);
> -}
> -
> -static void dce_v11_0_encoder_disable(struct drm_encoder *encoder)
> -{
> -	struct amdgpu_encoder *amdgpu_encoder =3D
> to_amdgpu_encoder(encoder);
> -	struct amdgpu_encoder_atom_dig *dig;
> -
> -	amdgpu_atombios_encoder_dpms(encoder, DRM_MODE_DPMS_OFF);
> -
> -	if (amdgpu_atombios_encoder_is_digital(encoder)) {
> -		if
> (amdgpu_atombios_encoder_get_encoder_mode(encoder) =3D=3D
> ATOM_ENCODER_MODE_HDMI)
> -			dce_v11_0_afmt_enable(encoder, false);
> -		dig =3D amdgpu_encoder->enc_priv;
> -		dig->dig_encoder =3D -1;
> -	}
> -	amdgpu_encoder->active_device =3D 0;
> -}
> -
> -/* these are handled by the primary encoders */
> -static void dce_v11_0_ext_prepare(struct drm_encoder *encoder)
> -{
> -
> -}
> -
> -static void dce_v11_0_ext_commit(struct drm_encoder *encoder)
> -{
> -
> -}
> -
> -static void
> -dce_v11_0_ext_mode_set(struct drm_encoder *encoder,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_display_mode *mode,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_display_mode *adjusted_mode)
> -{
> -
> -}
> -
> -static void dce_v11_0_ext_disable(struct drm_encoder *encoder)
> -{
> -
> -}
> -
> -static void
> -dce_v11_0_ext_dpms(struct drm_encoder *encoder, int mode)
> -{
> -
> -}
> -
> -static const struct drm_encoder_helper_funcs
> dce_v11_0_ext_helper_funcs =3D {
> -	.dpms =3D dce_v11_0_ext_dpms,
> -	.prepare =3D dce_v11_0_ext_prepare,
> -	.mode_set =3D dce_v11_0_ext_mode_set,
> -	.commit =3D dce_v11_0_ext_commit,
> -	.disable =3D dce_v11_0_ext_disable,
> -	/* no detect for TMDS/LVDS yet */
> -};
> -
> -static const struct drm_encoder_helper_funcs
> dce_v11_0_dig_helper_funcs =3D {
> -	.dpms =3D amdgpu_atombios_encoder_dpms,
> -	.mode_fixup =3D amdgpu_atombios_encoder_mode_fixup,
> -	.prepare =3D dce_v11_0_encoder_prepare,
> -	.mode_set =3D dce_v11_0_encoder_mode_set,
> -	.commit =3D dce_v11_0_encoder_commit,
> -	.disable =3D dce_v11_0_encoder_disable,
> -	.detect =3D amdgpu_atombios_encoder_dig_detect,
> -};
> -
> -static const struct drm_encoder_helper_funcs
> dce_v11_0_dac_helper_funcs =3D {
> -	.dpms =3D amdgpu_atombios_encoder_dpms,
> -	.mode_fixup =3D amdgpu_atombios_encoder_mode_fixup,
> -	.prepare =3D dce_v11_0_encoder_prepare,
> -	.mode_set =3D dce_v11_0_encoder_mode_set,
> -	.commit =3D dce_v11_0_encoder_commit,
> -	.detect =3D amdgpu_atombios_encoder_dac_detect,
> -};
> -
> -static void dce_v11_0_encoder_destroy(struct drm_encoder *encoder)
> -{
> -	struct amdgpu_encoder *amdgpu_encoder =3D
> to_amdgpu_encoder(encoder);
> -	if (amdgpu_encoder->devices & (ATOM_DEVICE_LCD_SUPPORT))
> -
> 		amdgpu_atombios_encoder_fini_backlight(amdgpu_encoder);
> -	kfree(amdgpu_encoder->enc_priv);
> -	drm_encoder_cleanup(encoder);
> -	kfree(amdgpu_encoder);
> -}
> -
> -static const struct drm_encoder_funcs dce_v11_0_encoder_funcs =3D {
> -	.destroy =3D dce_v11_0_encoder_destroy,
> -};
> -
> -static void dce_v11_0_encoder_add(struct amdgpu_device *adev,
> -				 uint32_t encoder_enum,
> -				 uint32_t supported_device,
> -				 u16 caps)
> -{
> -	struct drm_device *dev =3D adev_to_drm(adev);
> -	struct drm_encoder *encoder;
> -	struct amdgpu_encoder *amdgpu_encoder;
> -
> -	/* see if we already added it */
> -	list_for_each_entry(encoder, &dev->mode_config.encoder_list,
> head) {
> -		amdgpu_encoder =3D to_amdgpu_encoder(encoder);
> -		if (amdgpu_encoder->encoder_enum =3D=3D encoder_enum) {
> -			amdgpu_encoder->devices |=3D supported_device;
> -			return;
> -		}
> -
> -	}
> -
> -	/* add a new one */
> -	amdgpu_encoder =3D kzalloc(sizeof(struct amdgpu_encoder),
> GFP_KERNEL);
> -	if (!amdgpu_encoder)
> -		return;
> -
> -	encoder =3D &amdgpu_encoder->base;
> -	switch (adev->mode_info.num_crtc) {
> -	case 1:
> -		encoder->possible_crtcs =3D 0x1;
> -		break;
> -	case 2:
> -	default:
> -		encoder->possible_crtcs =3D 0x3;
> -		break;
> -	case 3:
> -		encoder->possible_crtcs =3D 0x7;
> -		break;
> -	case 4:
> -		encoder->possible_crtcs =3D 0xf;
> -		break;
> -	case 5:
> -		encoder->possible_crtcs =3D 0x1f;
> -		break;
> -	case 6:
> -		encoder->possible_crtcs =3D 0x3f;
> -		break;
> -	}
> -
> -	amdgpu_encoder->enc_priv =3D NULL;
> -
> -	amdgpu_encoder->encoder_enum =3D encoder_enum;
> -	amdgpu_encoder->encoder_id =3D (encoder_enum & OBJECT_ID_MASK)
> >> OBJECT_ID_SHIFT;
> -	amdgpu_encoder->devices =3D supported_device;
> -	amdgpu_encoder->rmx_type =3D RMX_OFF;
> -	amdgpu_encoder->underscan_type =3D UNDERSCAN_OFF;
> -	amdgpu_encoder->is_ext_encoder =3D false;
> -	amdgpu_encoder->caps =3D caps;
> -
> -	switch (amdgpu_encoder->encoder_id) {
> -	case ENCODER_OBJECT_ID_INTERNAL_KLDSCP_DAC1:
> -	case ENCODER_OBJECT_ID_INTERNAL_KLDSCP_DAC2:
> -		drm_encoder_init(dev, encoder,
> &dce_v11_0_encoder_funcs,
> -				 DRM_MODE_ENCODER_DAC, NULL);
> -		drm_encoder_helper_add(encoder,
> &dce_v11_0_dac_helper_funcs);
> -		break;
> -	case ENCODER_OBJECT_ID_INTERNAL_KLDSCP_DVO1:
> -	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY:
> -	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY1:
> -	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY2:
> -	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY3:
> -		if (amdgpu_encoder->devices &
> (ATOM_DEVICE_LCD_SUPPORT)) {
> -			amdgpu_encoder->rmx_type =3D RMX_FULL;
> -			drm_encoder_init(dev, encoder,
> &dce_v11_0_encoder_funcs,
> -					 DRM_MODE_ENCODER_LVDS,
> NULL);
> -			amdgpu_encoder->enc_priv =3D
> amdgpu_atombios_encoder_get_lcd_info(amdgpu_encoder);
> -		} else if (amdgpu_encoder->devices &
> (ATOM_DEVICE_CRT_SUPPORT)) {
> -			drm_encoder_init(dev, encoder,
> &dce_v11_0_encoder_funcs,
> -					 DRM_MODE_ENCODER_DAC,
> NULL);
> -			amdgpu_encoder->enc_priv =3D
> amdgpu_atombios_encoder_get_dig_info(amdgpu_encoder);
> -		} else {
> -			drm_encoder_init(dev, encoder,
> &dce_v11_0_encoder_funcs,
> -					 DRM_MODE_ENCODER_TMDS,
> NULL);
> -			amdgpu_encoder->enc_priv =3D
> amdgpu_atombios_encoder_get_dig_info(amdgpu_encoder);
> -		}
> -		drm_encoder_helper_add(encoder,
> &dce_v11_0_dig_helper_funcs);
> -		break;
> -	case ENCODER_OBJECT_ID_SI170B:
> -	case ENCODER_OBJECT_ID_CH7303:
> -	case ENCODER_OBJECT_ID_EXTERNAL_SDVOA:
> -	case ENCODER_OBJECT_ID_EXTERNAL_SDVOB:
> -	case ENCODER_OBJECT_ID_TITFP513:
> -	case ENCODER_OBJECT_ID_VT1623:
> -	case ENCODER_OBJECT_ID_HDMI_SI1930:
> -	case ENCODER_OBJECT_ID_TRAVIS:
> -	case ENCODER_OBJECT_ID_NUTMEG:
> -		/* these are handled by the primary encoders */
> -		amdgpu_encoder->is_ext_encoder =3D true;
> -		if (amdgpu_encoder->devices &
> (ATOM_DEVICE_LCD_SUPPORT))
> -			drm_encoder_init(dev, encoder,
> &dce_v11_0_encoder_funcs,
> -					 DRM_MODE_ENCODER_LVDS,
> NULL);
> -		else if (amdgpu_encoder->devices &
> (ATOM_DEVICE_CRT_SUPPORT))
> -			drm_encoder_init(dev, encoder,
> &dce_v11_0_encoder_funcs,
> -					 DRM_MODE_ENCODER_DAC,
> NULL);
> -		else
> -			drm_encoder_init(dev, encoder,
> &dce_v11_0_encoder_funcs,
> -					 DRM_MODE_ENCODER_TMDS,
> NULL);
> -		drm_encoder_helper_add(encoder,
> &dce_v11_0_ext_helper_funcs);
> -		break;
> -	}
> -}
> -
> -static const struct amdgpu_display_funcs dce_v11_0_display_funcs =3D {
> -	.bandwidth_update =3D &dce_v11_0_bandwidth_update,
> -	.vblank_get_counter =3D &dce_v11_0_vblank_get_counter,
> -	.backlight_set_level =3D
> &amdgpu_atombios_encoder_set_backlight_level,
> -	.backlight_get_level =3D
> &amdgpu_atombios_encoder_get_backlight_level,
> -	.hpd_sense =3D &dce_v11_0_hpd_sense,
> -	.hpd_set_polarity =3D &dce_v11_0_hpd_set_polarity,
> -	.hpd_get_gpio_reg =3D &dce_v11_0_hpd_get_gpio_reg,
> -	.page_flip =3D &dce_v11_0_page_flip,
> -	.page_flip_get_scanoutpos =3D &dce_v11_0_crtc_get_scanoutpos,
> -	.add_encoder =3D &dce_v11_0_encoder_add,
> -	.add_connector =3D &amdgpu_connector_add,
> -};
> -
> -static void dce_v11_0_set_display_funcs(struct amdgpu_device *adev)
> -{
> -	adev->mode_info.funcs =3D &dce_v11_0_display_funcs;
> -}
> -
> -static const struct amdgpu_irq_src_funcs dce_v11_0_crtc_irq_funcs =3D
> {
> -	.set =3D dce_v11_0_set_crtc_irq_state,
> -	.process =3D dce_v11_0_crtc_irq,
> -};
> -
> -static const struct amdgpu_irq_src_funcs
> dce_v11_0_pageflip_irq_funcs =3D {
> -	.set =3D dce_v11_0_set_pageflip_irq_state,
> -	.process =3D dce_v11_0_pageflip_irq,
> -};
> -
> -static const struct amdgpu_irq_src_funcs dce_v11_0_hpd_irq_funcs =3D {
> -	.set =3D dce_v11_0_set_hpd_irq_state,
> -	.process =3D dce_v11_0_hpd_irq,
> -};
> -
> -static void dce_v11_0_set_irq_funcs(struct amdgpu_device *adev)
> -{
> -	if (adev->mode_info.num_crtc > 0)
> -		adev->crtc_irq.num_types =3D AMDGPU_CRTC_IRQ_VLINE1 +
> adev->mode_info.num_crtc;
> -	else
> -		adev->crtc_irq.num_types =3D 0;
> -	adev->crtc_irq.funcs =3D &dce_v11_0_crtc_irq_funcs;
> -
> -	adev->pageflip_irq.num_types =3D adev->mode_info.num_crtc;
> -	adev->pageflip_irq.funcs =3D &dce_v11_0_pageflip_irq_funcs;
> -
> -	adev->hpd_irq.num_types =3D adev->mode_info.num_hpd;
> -	adev->hpd_irq.funcs =3D &dce_v11_0_hpd_irq_funcs;
> -}
> -
> -const struct amdgpu_ip_block_version dce_v11_0_ip_block =3D
> -{
> -	.type =3D AMD_IP_BLOCK_TYPE_DCE,
> -	.major =3D 11,
> -	.minor =3D 0,
> -	.rev =3D 0,
> -	.funcs =3D &dce_v11_0_ip_funcs,
> -};
> -
> -const struct amdgpu_ip_block_version dce_v11_2_ip_block =3D
> -{
> -	.type =3D AMD_IP_BLOCK_TYPE_DCE,
> -	.major =3D 11,
> -	.minor =3D 2,
> -	.rev =3D 0,
> -	.funcs =3D &dce_v11_0_ip_funcs,
> -};
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.h
> b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.h
> deleted file mode 100644
> index 0d878ca3acbab..0000000000000
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.h
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -/*
> - * Copyright 2014 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person
> obtaining a
> - * copy of this software and associated documentation files (the
> "Software"),
> - * to deal in the Software without restriction, including without
> limitation
> - * the rights to use, copy, modify, merge, publish, distribute,
> sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom
> the
> - * Software is furnished to do so, subject to the following
> conditions:
> - *
> - * The above copyright notice and this permission notice shall be
> included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.=C2=A0 IN NO
> EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - */
> -
> -#ifndef __DCE_V11_0_H__
> -#define __DCE_V11_0_H__
> -
> -extern const struct amdgpu_ip_block_version dce_v11_0_ip_block;
> -extern const struct amdgpu_ip_block_version dce_v11_2_ip_block;
> -
> -void dce_v11_0_disable_dce(struct amdgpu_device *adev);
> -
> -#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> b/drivers/gpu/drm/amd/amdgpu/vi.c
> index 9b3510e531127..a611a73451250 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -67,7 +67,6 @@
> =C2=A0#include "sdma_v2_4.h"
> =C2=A0#include "sdma_v3_0.h"
> =C2=A0#include "dce_v10_0.h"
> -#include "dce_v11_0.h"
> =C2=A0#include "iceland_ih.h"
> =C2=A0#include "tonga_ih.h"
> =C2=A0#include "cz_ih.h"
> @@ -2124,8 +2123,6 @@ int vi_set_ip_blocks(struct amdgpu_device
> *adev)
> =C2=A0		else if (amdgpu_device_has_dc_support(adev))
> =C2=A0			amdgpu_device_ip_block_add(adev,
> &dm_ip_block);
> =C2=A0#endif
> -		else
> -			amdgpu_device_ip_block_add(adev,
> &dce_v11_2_ip_block);
> =C2=A0		amdgpu_device_ip_block_add(adev,
> &uvd_v6_3_ip_block);
> =C2=A0		amdgpu_device_ip_block_add(adev,
> &vce_v3_4_ip_block);
> =C2=A0		break;
> @@ -2142,8 +2139,6 @@ int vi_set_ip_blocks(struct amdgpu_device
> *adev)
> =C2=A0		else if (amdgpu_device_has_dc_support(adev))
> =C2=A0			amdgpu_device_ip_block_add(adev,
> &dm_ip_block);
> =C2=A0#endif
> -		else
> -			amdgpu_device_ip_block_add(adev,
> &dce_v11_0_ip_block);
> =C2=A0		amdgpu_device_ip_block_add(adev,
> &uvd_v6_0_ip_block);
> =C2=A0		amdgpu_device_ip_block_add(adev,
> &vce_v3_1_ip_block);
> =C2=A0#if defined(CONFIG_DRM_AMD_ACP)
> @@ -2163,8 +2158,6 @@ int vi_set_ip_blocks(struct amdgpu_device
> *adev)
> =C2=A0		else if (amdgpu_device_has_dc_support(adev))
> =C2=A0			amdgpu_device_ip_block_add(adev,
> &dm_ip_block);
> =C2=A0#endif
> -		else
> -			amdgpu_device_ip_block_add(adev,
> &dce_v11_0_ip_block);
> =C2=A0		amdgpu_device_ip_block_add(adev,
> &uvd_v6_2_ip_block);
> =C2=A0		amdgpu_device_ip_block_add(adev,
> &vce_v3_4_ip_block);
> =C2=A0#if defined(CONFIG_DRM_AMD_ACP)
