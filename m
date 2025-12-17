Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADABDD66BA6
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 20:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51DE510E32D;
	Wed, 17 Dec 2025 20:47:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PhmyG/z5";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8422610E32D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 20:47:31 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-29e619586deso9482755ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 12:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766004451; x=1766609251; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PvgN624qGlhiq6ScOCT4XhCK/j/Vom8DsLwX5VER0zA=;
 b=PhmyG/z5gKSiWPDYWU419qVM+yCYi+iRKejmyywfOFPqH++22a774WDUgwfziKwKXa
 aImmgPm3aKXUghgWgPSnZ0ft/jg2uNGCE99frXt8nX+GAJh95N+3waIrlsVthAzTXBoi
 TRHexvH+MX3AfVoBRD44vaAVnahnzwY46GiWJKSTLj1jhAc7/wuNW+XP6SYGhNS/zOIq
 YV4mJeMofMUHp8rzk0Vq+lnW/I1m3mDO8WzR609QC+R0PxGzOfefOl4iYi0J03PzwCEB
 nOqP4WySzBS8vpEtSf4LVaNaiwXJwcAe70X+YsZRD5rxl1dl2c489Ob6PtjmaYWVAYxl
 RVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766004451; x=1766609251;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PvgN624qGlhiq6ScOCT4XhCK/j/Vom8DsLwX5VER0zA=;
 b=qQ130+oaWrBju82frA/KZs4fNs8qrbXM5hD5b3PIM7NpL73weAgRtNF1Ie4qB6VO0w
 j9RbkyqAHME5CINKIUWNINKwLJDQJ6lI+pWQohrPESayZLZkLOhK8rGZwaoRMM21c6HQ
 VvH4im0WAZI3ExBA+zqO3ijqcPq5tMy8zJ05+ismzqiud4gFcig05nmqA4K9ttCFszVm
 IV6NwMym5MwfcTqkzjRToXKFbTDkfd+mIiOr9B+ufOweQLPFzKUbmLKSQ6bdKG+WaQGH
 N/Uacs+OdGqk9Ggv5pqZaEBNYhlcUVmqTD/wIwl5ewOY8MkJjK5SyEaOCTXB7R3VBo3j
 Js/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAInRT5gfjvvRVLMr0cu9RfMxEo/+FdciX8Jymp7LaAxf6Hyz4fP0uKYv/ssM6cvSiC65DXPu/@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGB55AlKMC6h/koaV1a+typEv3WjfBOcWFCCTchGUOYmyU1gSk
 C36uG72b2QkQUIwwUl6FVWdsiNgaQV3pQNcCdC6MvHt869qKN1gmCGltfb1RE9wGT+Wrl5Fm1qx
 TfvBMOkm5KWgPMxidUivUcTwKjFkIQ0w=
X-Gm-Gg: AY/fxX6YPp0R+IwJc5YRPx0n8sig7UKt3POBZ5ZYePvSRnUYJCSBGrwt36WoumJK37J
 x8kaXCFwZdIzuSnVcUsY4y7hJeManCtB/ARiwYO2xI2JZGGSX2xFjkmI9/49VwPpQI6/qv7mfP8
 IVICQ901J0duPzqkt3mW/e8SStTIbufL3v34V4yhDXQEFxMV34avyRrcVbm6ENg/Xg3+fYCl0QI
 HBYSb4iiu/s7tJZkXaWVVcdMbY4rqiehPRlBxVEf25nGDo/CuAsXN6Qegd2Cs6bPygO6KrX
X-Google-Smtp-Source: AGHT+IF+4/iYNgw2tTd/iJwNM9Kgwh7HXFrE7ECHJ61LxO/UbWyTJLw+/EKL8rX5Iyh2iN6ohQAu0Dubxj78y+FpV7g=
X-Received: by 2002:a05:7022:ec0b:b0:11b:1c6d:98ed with SMTP id
 a92af1059eb24-11f349a9d7emr9245508c88.2.1766004450774; Wed, 17 Dec 2025
 12:47:30 -0800 (PST)
MIME-Version: 1.0
References: <20251217153521.2018841-1-alexander.deucher@amd.com>
 <20251217153521.2018841-2-alexander.deucher@amd.com>
 <4c6a9a94-8bc5-49b2-ba03-0f81266b3797@amd.com>
In-Reply-To: <4c6a9a94-8bc5-49b2-ba03-0f81266b3797@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Dec 2025 15:47:19 -0500
X-Gm-Features: AQt7F2pLVu_CExGWGPZpz6pB7Nu-ndl6GjcwNzcoPG7FNqvse4IqIwiP-ZuqGfk
Message-ID: <CADnq5_O_3akUX_rRpas3yFMj-Nu_YGzuMtfGTcUJ1t6U-0mibg@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/amdgpu/jpeg: Add jpeg 5.3.0 support
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
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

On Wed, Dec 17, 2025 at 2:22=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/17/25 9:35 AM, Alex Deucher wrote:
> > From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> >
> > Add the Jpeg IP v5_3_0 code base.
> >
> > Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/Makefile      |   3 +-
> >   drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 695 ++++++++++++++++++++++=
+
> >   drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h |  35 ++
> >   3 files changed, 732 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> >   create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/=
amdgpu/Makefile
> > index d0c506a445695..4b9cb9b681b65 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> > +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> > @@ -221,7 +221,8 @@ amdgpu-y +=3D \
> >       jpeg_v4_0_3.o \
> >       jpeg_v4_0_5.o \
> >       jpeg_v5_0_0.o \
> > -     jpeg_v5_0_1.o
> > +     jpeg_v5_0_1.o \
> > +     jpeg_v5_3_0.o
> >
> >   # add VPE block
> >   amdgpu-y +=3D \
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v5_3_0.c
> > new file mode 100644
> > index 0000000000000..084e592fb838f
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> > @@ -0,0 +1,695 @@
> > +/*
> > + * Copyright 2025 Advanced Micro Devices, Inc.
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> > + * copy of this software and associated documentation files (the "Soft=
ware"),
> > + * to deal in the Software without restriction, including without limi=
tation
> > + * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> > + * and/or sell copies of the Software, and to permit persons to whom t=
he
> > + * Software is furnished to do so, subject to the following conditions=
:
> > + *
> > + * The above copyright notice and this permission notice shall be incl=
uded in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> > + * OTHER DEALINGS IN THE SOFTWARE.
> > + *
> > + */
> > +
> > +#include "amdgpu.h"
> > +#include "amdgpu_jpeg.h"
> > +#include "amdgpu_pm.h"
> > +#include "soc15.h"
> > +#include "soc15d.h"
> > +#include "jpeg_v2_0.h"
> > +#include "jpeg_v4_0_3.h"
> > +
> > +#include "vcn/vcn_5_3_0_offset.h"
> > +#include "vcn/vcn_5_3_0_sh_mask.h"
> > +#include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
> > +#include "jpeg_v5_3_0.h"
> > +
> > +static void jpeg_v5_3_0_set_dec_ring_funcs(struct amdgpu_device *adev)=
;
> > +static void jpeg_v5_3_0_set_irq_funcs(struct amdgpu_device *adev);
> > +static int jpeg_v5_3_0_set_powergating_state(struct amdgpu_ip_block *i=
p_block,
> > +                             enum amd_powergating_state state);
>
> As it's "new code", could the functions be ordered in a way that
> prototypes aren't needed?
>
> IE:
> * put jpeg_v5_3_0_set_irq_funcs() and jpeg_v5_3_0_set_dec_ring_funcs()
> before jpeg_v5_3_0_early_init()?
> * put jpeg_v5_3_0_set_powergating_state() before jpeg_v5_3_0_hw_fini()

Not particularly easily unfortunately.

Alex

>
> > +
> > +
> > +/**
> > + * jpeg_v5_3_0_early_init - set function pointers
> > + *
> > + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
> > + *
> > + * Set ring and irq function pointers
> > + */
> > +static int jpeg_v5_3_0_early_init(struct amdgpu_ip_block *ip_block)
> > +{
> > +     struct amdgpu_device *adev =3D ip_block->adev;
> > +
> > +     adev->jpeg.num_jpeg_inst =3D 1;
> > +     adev->jpeg.num_jpeg_rings =3D 1;
> > +
> > +     jpeg_v5_3_0_set_dec_ring_funcs(adev);
> > +     jpeg_v5_3_0_set_irq_funcs(adev);
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * jpeg_v5_3_0_sw_init - sw init for JPEG block
> > + *
> > + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
> > + *
> > + * Load firmware and sw initialization
> > + */
> > +static int jpeg_v5_3_0_sw_init(struct amdgpu_ip_block *ip_block)
> > +{
> > +     struct amdgpu_device *adev =3D ip_block->adev;
> > +     struct amdgpu_ring *ring;
> > +     int r;
> > +
> > +     /* JPEG TRAP */
> > +     r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
> > +             VCN_5_0__SRCID__JPEG_DECODE, &adev->jpeg.inst->irq);
> > +     if (r)
> > +             return r;
> > +
> > +     r =3D amdgpu_jpeg_sw_init(adev);
> > +     if (r)
> > +             return r;
> > +
> > +     r =3D amdgpu_jpeg_resume(adev);
> > +     if (r)
> > +             return r;
> > +
> > +     ring =3D adev->jpeg.inst->ring_dec;
> > +     ring->use_doorbell =3D true;
> > +     ring->doorbell_index =3D (adev->doorbell_index.vcn.vcn_ring0_1 <<=
 1) + 1;
> > +     ring->vm_hub =3D AMDGPU_MMHUB0(0);
> > +
> > +     sprintf(ring->name, "jpeg_dec");
> > +     r =3D amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
> > +                          AMDGPU_RING_PRIO_DEFAULT, NULL);
> > +     if (r)
> > +             return r;
> > +
> > +     adev->jpeg.internal.jpeg_pitch[0] =3D regUVD_JPEG_PITCH_INTERNAL_=
OFFSET;
> > +     adev->jpeg.inst->external.jpeg_pitch[0] =3D SOC15_REG_OFFSET(JPEG=
, 0, regUVD_JPEG_PITCH);
> > +
> > +     /* TODO: Add queue reset mask when FW fully supports it */
> > +     adev->jpeg.supported_reset =3D
> > +             amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_=
dec[0]);
> > +     r =3D amdgpu_jpeg_sysfs_reset_mask_init(adev);
> > +     if (r)
> > +             return r;
> > +     return 0;
> > +}
> > +
> > +/**
> > + * jpeg_v5_3_0_sw_fini - sw fini for JPEG block
> > + *
> > + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
> > + *
> > + * JPEG suspend and free up sw allocation
> > + */
> > +static int jpeg_v5_3_0_sw_fini(struct amdgpu_ip_block *ip_block)
> > +{
> > +     struct amdgpu_device *adev =3D ip_block->adev;
> > +     int r;
> > +
> > +     r =3D amdgpu_jpeg_suspend(adev);
> > +     if (r)
> > +             return r;
> > +
> > +     amdgpu_jpeg_sysfs_reset_mask_fini(adev);
> > +     r =3D amdgpu_jpeg_sw_fini(adev);
> > +
> > +     return r;
> > +}
> > +
> > +/**
> > + * jpeg_v5_3_0_hw_init - start and test JPEG block
> > + *
> > + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
> > + *
> > + */
> > +static int jpeg_v5_3_0_hw_init(struct amdgpu_ip_block *ip_block)
> > +{
> > +     struct amdgpu_device *adev =3D ip_block->adev;
> > +     struct amdgpu_ring *ring =3D adev->jpeg.inst->ring_dec;
> > +     int r;
> > +
> > +     adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> > +                     (adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
> > +
> > +     /* Skip ring test because pause DPG is not implemented. */
> > +     if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG)
> > +             return 0;
> > +
> > +     r =3D amdgpu_ring_test_helper(ring);
> > +     if (r)
> > +             return r;
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * jpeg_v5_3_0_hw_fini - stop the hardware block
> > + *
> > + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
> > + *
> > + * Stop the JPEG block, mark ring as not ready any more
> > + */
> > +static int jpeg_v5_3_0_hw_fini(struct amdgpu_ip_block *ip_block)
> > +{
> > +     struct amdgpu_device *adev =3D ip_block->adev;
> > +
> > +     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> > +
> > +     if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
> > +           RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS))
> > +             jpeg_v5_3_0_set_powergating_state(ip_block, AMD_PG_STATE_=
GATE);
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * jpeg_v5_3_0_suspend - suspend JPEG block
> > + *
> > + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
> > + *
> > + * HW fini and suspend JPEG block
> > + */
> > +static int jpeg_v5_3_0_suspend(struct amdgpu_ip_block *ip_block)
> > +{
> > +     int r;
> > +
> > +     r =3D jpeg_v5_3_0_hw_fini(ip_block);
> > +     if (r)
> > +             return r;
> > +
> > +     r =3D amdgpu_jpeg_suspend(ip_block->adev);
> > +
> > +     return r;
> > +}
> > +
> > +/**
> > + * jpeg_v5_3_0_resume - resume JPEG block
> > + *
> > + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
> > + *
> > + * Resume firmware and hw init JPEG block
> > + */
> > +static int jpeg_v5_3_0_resume(struct amdgpu_ip_block *ip_block)
> > +{
> > +     int r;
> > +
> > +     r =3D amdgpu_jpeg_resume(ip_block->adev);
> > +     if (r)
> > +             return r;
> > +
> > +     r =3D jpeg_v5_3_0_hw_init(ip_block);
> > +
> > +     return r;
> > +}
> > +
> > +static void jpeg_v5_3_0_disable_clock_gating(struct amdgpu_device *ade=
v)
> > +{
> > +     uint32_t data =3D 0;
> > +
> > +     WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);
> > +
> > +     data =3D RREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL);
> > +     data &=3D ~(JPEG_CGC_CTRL__JPEG0_DEC_MODE_MASK
> > +             | JPEG_CGC_CTRL__JPEG_ENC_MODE_MASK);
> > +     WREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL, data);
> > +}
> > +
> > +static void jpeg_v5_3_0_enable_clock_gating(struct amdgpu_device *adev=
)
> > +{
> > +     uint32_t data =3D 0;
> > +
> > +     data =3D RREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL);
> > +
> > +     data |=3D 1 << JPEG_CGC_CTRL__JPEG0_DEC_MODE__SHIFT;
> > +     WREG32_SOC15(JPEG, 0, regJPEG_CGC_CTRL, data);
> > +
> > +     data =3D RREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE);
> > +     data |=3D (JPEG_CGC_GATE__JPEG0_DEC_MASK
> > +             |JPEG_CGC_GATE__JPEG_ENC_MASK
> > +             |JPEG_CGC_GATE__JMCIF_MASK
> > +             |JPEG_CGC_GATE__JRBBM_MASK);
> > +     WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);
> > +}
> > +
> > +static int jpeg_v5_3_0_disable_power_gating(struct amdgpu_device *adev=
)
> > +{
> > +     uint32_t data =3D 0;
> > +
> > +     data =3D 1 << UVD_IPX_DLDO_CONFIG_ONO1__ONO1_PWR_CONFIG__SHIFT;
> > +     WREG32_SOC15(JPEG, 0, regUVD_IPX_DLDO_CONFIG_ONO1, data);
> > +     SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_IPX_DLDO_STATUS, 0,
> > +                     UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS_MASK);
> > +
> > +     /* disable anti hang mechanism */
> > +     WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), 0,
> > +             ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
> > +
> > +     return 0;
> > +}
> > +
> > +static int jpeg_v5_3_0_enable_power_gating(struct amdgpu_device *adev)
> > +{
> > +     /* enable anti hang mechanism */
> > +     WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS),
> > +             UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
> > +             ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
> > +
> > +     if (adev->pg_flags & AMD_PG_SUPPORT_JPEG) {
> > +             WREG32(SOC15_REG_OFFSET(JPEG, 0, regUVD_IPX_DLDO_CONFIG_O=
NO1),
> > +                     2 << UVD_IPX_DLDO_CONFIG_ONO1__ONO1_PWR_CONFIG__S=
HIFT);
> > +             SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_IPX_DLDO_STATUS,
> > +                     1 << UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS__SHIFT,
> > +                     UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS_MASK);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void jpeg_engine_5_0_0_dpg_clock_gating_mode(struct amdgpu_devi=
ce *adev,
> > +            int inst_idx, uint8_t indirect)
> > +{
> > +     uint32_t data =3D 0;
> > +
> > +     // JPEG disable CGC
> > +     if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG)
> > +             data =3D 1 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> > +     else
> > +             data =3D 0 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> > +
> > +     data |=3D 1 << JPEG_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
> > +     data |=3D 4 << JPEG_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> > +
> > +     if (indirect) {
> > +             ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_CGC_CTRL, =
data, indirect);
> > +
> > +             // Turn on All JPEG clocks
> > +             data =3D 0;
> > +             ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_CGC_GATE, =
data, indirect);
> > +     } else {
> > +             WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_CGC_CTRL, =
data, indirect);
> > +
> > +             // Turn on All JPEG clocks
> > +             data =3D 0;
> > +             WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_CGC_GATE, =
data, indirect);
> > +     }
> > +}
> > +
> > +/**
> > + * jpeg_v5_3_0_start_dpg_mode - Jpeg start with dpg mode
> > + *
> > + * @adev: amdgpu_device pointer
> > + * @inst_idx: instance number index
> > + * @indirect: indirectly write sram
> > + *
> > + * Start JPEG block with dpg mode
> > + */
> > +static int jpeg_v5_3_0_start_dpg_mode(struct amdgpu_device *adev, int =
inst_idx, bool indirect)
> > +{
> > +     struct amdgpu_ring *ring =3D adev->jpeg.inst[inst_idx].ring_dec;
> > +     uint32_t reg_data =3D 0;
> > +
> > +     jpeg_v5_3_0_enable_power_gating(adev);
> > +
> > +     // enable dynamic power gating mode
> > +     reg_data =3D RREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATU=
S);
> > +     reg_data |=3D UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK;
> > +     WREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS, reg_data);
> > +
> > +     if (indirect)
> > +             adev->jpeg.inst[inst_idx].dpg_sram_curr_addr =3D
> > +                     (uint32_t *)adev->jpeg.inst[inst_idx].dpg_sram_cp=
u_addr;
> > +
> > +     jpeg_engine_5_0_0_dpg_clock_gating_mode(adev, inst_idx, indirect)=
;
> > +
> > +     /* MJPEG global tiling registers */
> > +     if (indirect)
> > +             ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_DEC_GFX10_=
ADDR_CONFIG,
> > +                     adev->gfx.config.gb_addr_config, indirect);
> > +     else
> > +             WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_DEC_GFX10_=
ADDR_CONFIG,
> > +                     adev->gfx.config.gb_addr_config, 1);
> > +
> > +     /* enable System Interrupt for JRBC */
> > +     if (indirect)
> > +             ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_SYS_INT_EN=
,
> > +                     JPEG_SYS_INT_EN__DJRBC0_MASK, indirect);
> > +     else
> > +             WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_SYS_INT_EN=
,
> > +                     JPEG_SYS_INT_EN__DJRBC0_MASK, 1);
> > +
> > +     if (indirect) {
> > +             /* add nop to workaround PSP size check */
> > +             ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipUVD_NO_OP, 0, i=
ndirect);
> > +
> > +             amdgpu_jpeg_psp_update_sram(adev, inst_idx, 0);
> > +     }
> > +
> > +     WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
> > +             ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
> > +             VCN_JPEG_DB_CTRL__EN_MASK);
> > +
> > +     WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_VMID, 0);
> > +     WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC0_UVD_JRBC_RB_CNTL, (0x00=
000001L | 0x00000002L));
> > +     WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
> > +             lower_32_bits(ring->gpu_addr));
> > +     WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
> > +             upper_32_bits(ring->gpu_addr));
> > +     WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC0_UVD_JRBC_RB_RPTR, 0);
> > +     WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC0_UVD_JRBC_RB_WPTR, 0);
> > +     WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC0_UVD_JRBC_RB_CNTL, 0x000=
00002L);
> > +     WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC0_UVD_JRBC_RB_SIZE, ring-=
>ring_size / 4);
> > +     ring->wptr =3D RREG32_SOC15(JPEG, inst_idx, regUVD_JRBC0_UVD_JRBC=
_RB_WPTR);
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * jpeg_v5_3_0_stop_dpg_mode - Jpeg stop with dpg mode
> > + *
> > + * @adev: amdgpu_device pointer
> > + * @inst_idx: instance number index
> > + *
> > + * Stop JPEG block with dpg mode
> > + */
> > +static void jpeg_v5_3_0_stop_dpg_mode(struct amdgpu_device *adev, int =
inst_idx)
> > +{
> > +     uint32_t reg_data =3D 0;
> > +
> > +     reg_data =3D RREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATU=
S);
> > +     reg_data &=3D ~UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK;
> > +     WREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS, reg_data);
> > +}
> > +
> > +/**
> > + * jpeg_v5_3_0_start - start JPEG block
> > + *
> > + * @adev: amdgpu_device pointer
> > + *
> > + * Setup and start the JPEG block
> > + */
> > +static int jpeg_v5_3_0_start(struct amdgpu_device *adev)
> > +{
> > +     struct amdgpu_ring *ring =3D adev->jpeg.inst->ring_dec;
> > +     int r;
> > +
> > +     if (adev->pm.dpm_enabled)
> > +             amdgpu_dpm_enable_jpeg(adev, true);
> > +
> > +     if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
> > +             r =3D jpeg_v5_3_0_start_dpg_mode(adev, 0, adev->jpeg.indi=
rect_sram);
> > +             return r;
> > +     }
> > +
> > +     /* disable power gating */
> > +     r =3D jpeg_v5_3_0_disable_power_gating(adev);
> > +     if (r)
> > +             return r;
> > +
> > +     /* JPEG disable CGC */
> > +     jpeg_v5_3_0_disable_clock_gating(adev);
> > +
> > +     /* MJPEG global tiling registers */
> > +     WREG32_SOC15(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG,
> > +             adev->gfx.config.gb_addr_config);
> > +
> > +     /* enable JMI channel */
> > +     WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL), 0,
> > +             ~UVD_JMI_CNTL__SOFT_RESET_MASK);
> > +
> > +     /* enable System Interrupt for JRBC */
> > +     WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regJPEG_SYS_INT_EN),
> > +             JPEG_SYS_INT_EN__DJRBC0_MASK,
> > +             ~JPEG_SYS_INT_EN__DJRBC0_MASK);
> > +
> > +     WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
> > +             ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
> > +             VCN_JPEG_DB_CTRL__EN_MASK);
> > +
> > +     WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_VMID, 0);
> > +     WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_CNTL, (0x00000001L=
 | 0x00000002L));
> > +     WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
> > +             lower_32_bits(ring->gpu_addr));
> > +     WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
> > +             upper_32_bits(ring->gpu_addr));
> > +     WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_RPTR, 0);
> > +     WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR, 0);
> > +     WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_CNTL, 0x00000002L)=
;
> > +     WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_SIZE, ring->ring_s=
ize / 4);
> > +     ring->wptr =3D RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPT=
R);
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * jpeg_v5_3_0_stop - stop JPEG block
> > + *
> > + * @adev: amdgpu_device pointer
> > + *
> > + * stop the JPEG block
> > + */
> > +static int jpeg_v5_3_0_stop(struct amdgpu_device *adev)
> > +{
> > +     int r;
> > +
> > +     if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
> > +             jpeg_v5_3_0_stop_dpg_mode(adev, 0);
> > +     } else {
> > +
> > +             /* reset JMI */
> > +             WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL),
> > +                     UVD_JMI_CNTL__SOFT_RESET_MASK,
> > +                     ~UVD_JMI_CNTL__SOFT_RESET_MASK);
> > +
> > +             jpeg_v5_3_0_enable_clock_gating(adev);
> > +
> > +             /* enable power gating */
> > +             r =3D jpeg_v5_3_0_enable_power_gating(adev);
> > +             if (r)
> > +                     return r;
> > +     }
> > +
> > +     if (adev->pm.dpm_enabled)
> > +             amdgpu_dpm_enable_jpeg(adev, false);
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * jpeg_v5_3_0_dec_ring_get_rptr - get read pointer
> > + *
> > + * @ring: amdgpu_ring pointer
> > + *
> > + * Returns the current hardware read pointer
> > + */
> > +static uint64_t jpeg_v5_3_0_dec_ring_get_rptr(struct amdgpu_ring *ring=
)
> > +{
> > +     struct amdgpu_device *adev =3D ring->adev;
> > +
> > +     return RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_RPTR);
> > +}
> > +
> > +/**
> > + * jpeg_v5_3_0_dec_ring_get_wptr - get write pointer
> > + *
> > + * @ring: amdgpu_ring pointer
> > + *
> > + * Returns the current hardware write pointer
> > + */
> > +static uint64_t jpeg_v5_3_0_dec_ring_get_wptr(struct amdgpu_ring *ring=
)
> > +{
> > +     struct amdgpu_device *adev =3D ring->adev;
> > +
> > +     if (ring->use_doorbell)
> > +             return *ring->wptr_cpu_addr;
> > +     else
> > +             return RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPT=
R);
> > +}
> > +
> > +/**
> > + * jpeg_v5_3_0_dec_ring_set_wptr - set write pointer
> > + *
> > + * @ring: amdgpu_ring pointer
> > + *
> > + * Commits the write pointer to the hardware
> > + */
> > +static void jpeg_v5_3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
> > +{
> > +     struct amdgpu_device *adev =3D ring->adev;
> > +
> > +     if (ring->use_doorbell) {
> > +             *ring->wptr_cpu_addr =3D lower_32_bits(ring->wptr);
> > +             WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wpt=
r));
> > +     } else {
> > +             WREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR, lowe=
r_32_bits(ring->wptr));
> > +     }
> > +}
> > +
> > +static bool jpeg_v5_3_0_is_idle(struct amdgpu_ip_block *ip_block)
> > +{
> > +     struct amdgpu_device *adev =3D ip_block->adev;
> > +     int ret =3D 1;
> > +
> > +     ret &=3D (((RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS) &
> > +             UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK) =3D=3D
> > +             UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK));
> > +
> > +     return ret;
> > +}
> > +
> > +static int jpeg_v5_3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
> > +{
> > +     struct amdgpu_device *adev =3D ip_block->adev;
> > +
> > +     return SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS,
> > +             UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
> > +             UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
> > +}
> > +
> > +static int jpeg_v5_3_0_set_clockgating_state(struct amdgpu_ip_block *i=
p_block,
> > +                                       enum amd_clockgating_state stat=
e)
> > +{
> > +     struct amdgpu_device *adev =3D ip_block->adev;
> > +     bool enable =3D (state =3D=3D AMD_CG_STATE_GATE) ? true : false;
> > +
> > +     if (enable) {
> > +             if (!jpeg_v5_3_0_is_idle(ip_block))
> > +                     return -EBUSY;
> > +             jpeg_v5_3_0_enable_clock_gating(adev);
> > +     } else {
> > +             jpeg_v5_3_0_disable_clock_gating(adev);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int jpeg_v5_3_0_set_powergating_state(struct amdgpu_ip_block *i=
p_block,
> > +                                       enum amd_powergating_state stat=
e)
> > +{
> > +     struct amdgpu_device *adev =3D ip_block->adev;
> > +     int ret;
> > +
> > +     if (state =3D=3D adev->jpeg.cur_state)
> > +             return 0;
> > +
> > +     if (state =3D=3D AMD_PG_STATE_GATE)
> > +             ret =3D jpeg_v5_3_0_stop(adev);
> > +     else
> > +             ret =3D jpeg_v5_3_0_start(adev);
> > +
> > +     if (!ret)
> > +             adev->jpeg.cur_state =3D state;
> > +
> > +     return ret;
> > +}
> > +
> > +static int jpeg_v5_3_0_set_interrupt_state(struct amdgpu_device *adev,
> > +                                     struct amdgpu_irq_src *source,
> > +                                     unsigned int type,
> > +                                     enum amdgpu_interrupt_state state=
)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int jpeg_v5_3_0_process_interrupt(struct amdgpu_device *adev,
> > +                                   struct amdgpu_irq_src *source,
> > +                                   struct amdgpu_iv_entry *entry)
> > +{
> > +     DRM_DEBUG("IH: JPEG TRAP\n");
> > +
> > +     switch (entry->src_id) {
> > +     case VCN_5_0__SRCID__JPEG_DECODE:
> > +             amdgpu_fence_process(adev->jpeg.inst->ring_dec);
> > +             break;
> > +     default:
> > +             DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
> > +                       entry->src_id, entry->src_data[0]);
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct amd_ip_funcs jpeg_v5_3_0_ip_funcs =3D {
> > +     .name =3D "jpeg_v5_3_0",
> > +     .early_init =3D jpeg_v5_3_0_early_init,
> > +     .sw_init =3D jpeg_v5_3_0_sw_init,
> > +     .sw_fini =3D jpeg_v5_3_0_sw_fini,
> > +     .hw_init =3D jpeg_v5_3_0_hw_init,
> > +     .hw_fini =3D jpeg_v5_3_0_hw_fini,
> > +     .suspend =3D jpeg_v5_3_0_suspend,
> > +     .resume =3D jpeg_v5_3_0_resume,
> > +     .is_idle =3D jpeg_v5_3_0_is_idle,
> > +     .wait_for_idle =3D jpeg_v5_3_0_wait_for_idle,
> > +     .set_clockgating_state =3D jpeg_v5_3_0_set_clockgating_state,
> > +     .set_powergating_state =3D jpeg_v5_3_0_set_powergating_state,
> > +};
> > +
> > +static const struct amdgpu_ring_funcs jpeg_v5_3_0_dec_ring_vm_funcs =
=3D {
> > +     .type =3D AMDGPU_RING_TYPE_VCN_JPEG,
> > +     .align_mask =3D 0xf,
> > +     .get_rptr =3D jpeg_v5_3_0_dec_ring_get_rptr,
> > +     .get_wptr =3D jpeg_v5_3_0_dec_ring_get_wptr,
> > +     .set_wptr =3D jpeg_v5_3_0_dec_ring_set_wptr,
> > +     .parse_cs =3D amdgpu_jpeg_dec_parse_cs,
> > +     .emit_frame_size =3D
> > +             SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
> > +             SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
> > +             8 + /* jpeg_v5_3_0_dec_ring_emit_vm_flush */
> > +             22 + 22 + /* jpeg_v5_3_0_dec_ring_emit_fence x2 vm fence =
*/
> > +             8 + 16,
> > +     .emit_ib_size =3D 22, /* jpeg_v5_3_0_dec_ring_emit_ib */
> > +     .emit_ib =3D jpeg_v4_0_3_dec_ring_emit_ib,
> > +     .emit_fence =3D jpeg_v4_0_3_dec_ring_emit_fence,
> > +     .emit_vm_flush =3D jpeg_v4_0_3_dec_ring_emit_vm_flush,
> > +     .test_ring =3D amdgpu_jpeg_dec_ring_test_ring,
> > +     .test_ib =3D amdgpu_jpeg_dec_ring_test_ib,
> > +     .insert_nop =3D jpeg_v4_0_3_dec_ring_nop,
> > +     .insert_start =3D jpeg_v4_0_3_dec_ring_insert_start,
> > +     .insert_end =3D jpeg_v4_0_3_dec_ring_insert_end,
> > +     .pad_ib =3D amdgpu_ring_generic_pad_ib,
> > +     .begin_use =3D amdgpu_jpeg_ring_begin_use,
> > +     .end_use =3D amdgpu_jpeg_ring_end_use,
> > +     .emit_wreg =3D jpeg_v4_0_3_dec_ring_emit_wreg,
> > +     .emit_reg_wait =3D jpeg_v4_0_3_dec_ring_emit_reg_wait,
> > +     .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_=
helper,
> > +};
> > +
> > +static void jpeg_v5_3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
> > +{
> > +     adev->jpeg.inst->ring_dec->funcs =3D &jpeg_v5_3_0_dec_ring_vm_fun=
cs;
> > +}
> > +
> > +static const struct amdgpu_irq_src_funcs jpeg_v5_3_0_irq_funcs =3D {
> > +     .set =3D jpeg_v5_3_0_set_interrupt_state,
> > +     .process =3D jpeg_v5_3_0_process_interrupt,
> > +};
> > +
> > +static void jpeg_v5_3_0_set_irq_funcs(struct amdgpu_device *adev)
> > +{
> > +     adev->jpeg.inst->irq.num_types =3D 1;
> > +     adev->jpeg.inst->irq.funcs =3D &jpeg_v5_3_0_irq_funcs;
> > +}
> > +
> > +const struct amdgpu_ip_block_version jpeg_v5_3_0_ip_block =3D {
> > +     .type =3D AMD_IP_BLOCK_TYPE_JPEG,
> > +     .major =3D 5,
> > +     .minor =3D 3,
> > +     .rev =3D 0,
> > +     .funcs =3D &jpeg_v5_3_0_ip_funcs,
> > +};
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v5_3_0.h
> > new file mode 100644
> > index 0000000000000..c1e7537d0f183
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h
> > @@ -0,0 +1,35 @@
> > +/*
> > + * Copyright 2025 Advanced Micro Devices, Inc.
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> > + * copy of this software and associated documentation files (the "Soft=
ware"),
> > + * to deal in the Software without restriction, including without limi=
tation
> > + * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> > + * and/or sell copies of the Software, and to permit persons to whom t=
he
> > + * Software is furnished to do so, subject to the following conditions=
:
> > + *
> > + * The above copyright notice and this permission notice shall be incl=
uded in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,
> > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR
> > + * OTHER DEALINGS IN THE SOFTWARE.
> > + *
> > + */
> > +
> > +#ifndef __JPEG_V5_3_0_H__
> > +#define __JPEG_V5_3_0_H__
> > +
> > +#define vcnipJPEG_CGC_GATE                                 0x4160
> > +#define vcnipJPEG_CGC_CTRL                                 0x4161
> > +#define vcnipJPEG_SYS_INT_EN                               0x4141
> > +#define vcnipUVD_NO_OP                                     0x0029
> > +#define vcnipJPEG_DEC_GFX10_ADDR_CONFIG                    0x404A
> > +
> > +extern const struct amdgpu_ip_block_version jpeg_v5_3_0_ip_block;
> > +
> > +#endif /* __JPEG_V5_0_0_H__ */
>
