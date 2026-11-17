Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68FE606A32F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nD0ZKuku
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA3410E62B;
	Tue, 17 Nov 2026 15:21:36 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45B8010E627
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 15:21:29 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-4bd3984f529so169094b6e.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 07:21:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794928888; cv=none;
 d=google.com; s=arc-20260327;
 b=Rwzxfc0AIeoySOHko9E1X0NqmnvSCuX0ezKKEnlohVVln+f71GAWpLUtrfTmDVOX0o
 V+yfLrrlv49qPF1gD8bxiBmjLnZdLsc/klB+eSNpNH84UP+lBlCqgpOzNdKkYG7CJsY6
 9uq91rZxmYHhdb7/scaLMEx2tFbgmzrceOfUZP2j1btMxiyFRuYbcFzhzRaaXwPdgsmP
 NeFpxC9m2qWlY5o2QHcDCr/wZGAP4t864DOm4wdzTMhQtdRkpZ4GcDjF+iKYBor4so1M
 C6q9dnwuluygxuLwqt6TZ5mFQy6+kPpigUm+1qT3GM2un85uPmcGryiQTTx2fUH32DNA
 Yu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ke40TRYV+31v2dWT1d7f9Y8DEHhP015519DfHcJRGeI=;
 fh=YClgO4us/db1gtlXwEdRWaphYLFLpa6I8vFZeZTzq64=;
 b=sF8LLFeG9ihplxOIYhIxHE6OBYm9oZWxlrCb175AazzQF2s3TsThPhVcfC9FWsdVL4
 BUn/tvEedcJQ0CJ24zMzfGU9d1Tow/tnjgo0zStGixvPl0qLVRcu+5D+Bj0AmkbFf8kz
 7JfQF4fwUriZA4mcmiN18iiGiMvs04o0bxVkvfjd9HsR5f51JXF0SrHlqvBODBQsJVlB
 xl/grrEvcnD19nqpy+tXbVfnYl2ZgO9IlGycThw4IVkyoEoqvWustWLvoi5Rl8um+JCV
 WBaJlMsfXpGNhhkMMrcSz3tL/OQZlrjgRYVUF6aS/WcM82V32R8y1c45CX1ZNVTyEPPV
 pw8w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794928888; x=1795533688; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ke40TRYV+31v2dWT1d7f9Y8DEHhP015519DfHcJRGeI=;
 b=nD0ZKuku1Udp1ypfRq3HMcXbGeAqItLnZyBV2gzHS/AwgNzNWWKIR08INLR3XWVgDo
 f26R+UeWKs3RWeEoLT8SXpAFOyogoNR8U8tDDXmOZ0+44KmsM8cc267yp+2QbfwmOe1e
 IHyfsRgRa2xfWHIxIn7M2+z+fOJr/EbGJBEh5LXfCz7b9gqbhynWOZ/KDGDccfDblgnc
 PrJdDlMwHKFa5/KPqiArtgHPiOh9WWlgw+bIEy90+fQIvgBfKi0UhFyOElv9H7luaC+M
 TpD7TyhmXpYpaa1YH2svYLw1B4fjFJf1t6f6VwxFmwhW9ZvjlqBW7KwORdr4iquXWSSG
 cqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794928888; x=1795533688;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ke40TRYV+31v2dWT1d7f9Y8DEHhP015519DfHcJRGeI=;
 b=QHGQwmR2HeQDSQgiIf7rewRJdAfxddWbN7gUA9M1vecj1eFaEpu2+7QhnuXNq0MOQF
 cxqtpS38ef3Kx820vLsH0akkl2tw0zAV5t6uyxckoYh5CamvVZAmWieRe/XrTg+raob6
 MgOUgSk9EISHHzAwGCtE4aD7528+YIWKGKuXCpZaFXzdSPackj4Lu6V8SVYkb/yhzkoh
 gqsCQxKI8jFAxTe0ulGQwKwm3MYaTL1s33w+gfs46U5DgBD1lOKu1roltI6kld2olgeO
 nszWW2GhCUD2i+490ULldgqnD0USkalwloc0Q717FMGeLYbZ8OCFZM7EAAwTvUdbHwzP
 s1pg==
X-Gm-Message-State: APuU4Z88J2GOwqeoCjiICZNcYD5K7wT1LF53MaopkQ+7SgyGIrkg5YTW
 0MQOSZI3vGoUHqJREsbE/ZY/xyFMAHTW7NzH5S2DCmpbKQUHcgrPXiWBu+FGnNNBvfeBHcH7Y+1
 bvH+ev6VhzHGREn/OOk/QpzQ3jpJH1Ts=
X-Gm-Gg: AYBFou3R132rmvtkl5a9fn9Ji9Y+u5aGNHHXH77R/oZJL55EIczV8FoQhzzpi5A+H0z
 Bb5qShX+xn67+ZF8DzcNJPMPy4oNzH/lwOa/tIA0keU+MHn5HDpZiNcavmRKqboQZShxfOumcez
 tPX/viynFiBp7/12T75nf1dhPX5Cq3oM/JMqO8DeYSzfypxKJ7OIRfJ/FT22Q/MZSqmSUypmBuk
 lV0RgIb9gbx6X5fVAvpRswa5T6k8xEK2O9H0dZ6wF5nApBTg2cYCms371zM7BuJk49vir2FIF1t
 G08ijGh5K4W7VTReXR74HRXn0we25ff2v7/892qx6JNcc8v2pa7fHua2otOOGB0QtPgTE9a03jz
 QY/eIppuM+KvP3jV/r8ihUAe//H5o+xsHLuXhHCf0QUcOtIRs30gacsF8fxlfNAgOlVJpa4lyiF
 Sc6JEBB7da6/AWE5J6KG5MYyq3yDN1c3SEEwaO97LncC2w50DkCyp6lrWKD/cakPqQgidRVWPZw
 ud9CtTp
X-Received: by 2002:a05:6808:1914:b0:55b:f88d:baa5 with SMTP id
 5614622812f47-56e66a9517emr17485100b6e.6.1794928888182; Tue, 17 Nov 2026
 07:21:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106224521.3568803-1-alexander.deucher@amd.com>
In-Reply-To: <20261106224521.3568803-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Nov 2026 10:21:16 -0500
X-Gm-Features: AclHuK9gXyrfxAJzPUS7os7RSyGhEDnmpBaw5TJkp1pMern_vyWaxEsPXVV5UsE
Message-ID: <CADnq5_O2747Y7r8770AuKq8Bsa_jaeiBWYhuwOFY5ptrjctxuA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Add soc v2_0 support
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 6, 2026 at 5:51=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> From: Hawking Zhang <Hawking.Zhang@amd.com>
>
> Add soc v2_0 implementation
>
> v2: remove need_full_reset part (Jack Gui)
> v3: squash in reset on init patches (Alex)
> v4: squash in various fixes
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile   |   2 +-
>  drivers/gpu/drm/amd/amdgpu/soc_v2_0.c | 552 ++++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/soc_v2_0.h |  30 ++
>  3 files changed, 583 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/soc_v2_0.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/soc_v2_0.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index aad4aa8fa1309..1d454d70d246e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -92,7 +92,7 @@ amdgpu-y +=3D \
>         sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.=
o hdp_v5_2.o lsdma_v6_0.o \
>         nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o =
nbif_v6_3_1.o \
>         cyan_skillfish_reg_init.o soc_v1_0.o lsdma_v7_1.o nbio_v6_3_2.o n=
bio_v7_11_5.o \
> -       nbif_v7_10.o hdp_v8_0.o lsdma_v8_0.o nbio_v7_11_4.o
> +       nbif_v7_10.o hdp_v8_0.o lsdma_v8_0.o nbio_v7_11_4.o soc_v2_0.o
>
>  # add DF block
>  amdgpu-y +=3D \
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/soc_v2_0.c
> new file mode 100644
> index 0000000000000..095d298f68675
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/soc_v2_0.c
> @@ -0,0 +1,552 @@
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#include <linux/firmware.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_ih.h"
> +#include "amdgpu_ucode.h"
> +#include "amdgpu_psp.h"
> +#include "amdgpu_smu.h"
> +#include "atom.h"
> +#include "amd_pcie.h"
> +
> +#include "gc/gc_13_0_1_offset.h"
> +#include "gc/gc_13_0_1_sh_mask.h"
> +#include "mp/mp_15_0_3_offset.h"
> +
> +#include "soc15.h"
> +#include "soc15_common.h"
> +#include "soc_v2_0.h"
> +#include "mxgpu_nv.h"
> +
> +static const struct amd_ip_funcs soc_v2_0_common_ip_funcs;
> +
> +static u32 soc_v2_0_get_config_memsize(struct amdgpu_device *adev)
> +{
> +       return adev->nbio.funcs->get_memsize(adev);
> +}
> +
> +static u32 soc_v2_0_get_xclk(struct amdgpu_device *adev)
> +{
> +       return adev->clock.spll.reference_freq;
> +}
> +
> +void soc_v2_0_grbm_select(struct amdgpu_device *adev,
> +                         u32 me, u32 pipe, u32 queue, u32 vmid)
> +{
> +       u32 grbm_gfx_cntl =3D 0;
> +       grbm_gfx_cntl =3D REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, PIP=
EID, pipe);
> +       grbm_gfx_cntl =3D REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, MEI=
D, me);
> +       grbm_gfx_cntl =3D REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, VMI=
D, vmid);
> +       grbm_gfx_cntl =3D REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, QUE=
UEID, queue);
> +
> +       WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, grbm_gfx_cntl);
> +}
> +
> +static struct soc15_allowed_register_entry soc_v2_0_allowed_read_registe=
rs[] =3D {
> +       { SOC15_REG_ENTRY(GC, 0, regGRBM_STATUS)},
> +       { SOC15_REG_ENTRY(GC, 0, regGRBM_STATUS2)},
> +       { SOC15_REG_ENTRY(GC, 0, regGRBM_STATUS_SE0)},
> +       { SOC15_REG_ENTRY(GC, 0, regGRBM_STATUS_SE1)},
> +       { SOC15_REG_ENTRY(GC, 0, regGRBM_STATUS_SE2)},
> +       { SOC15_REG_ENTRY(GC, 0, regGRBM_STATUS_SE3)},
> +       { SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_SDMA_STATUS_REG)},
> +       { SOC15_REG_ENTRY(SDMA1, 0, regSDMA1_SDMA_STATUS_REG)},
> +       { SOC15_REG_ENTRY(SDMA2, 0, regSDMA2_SDMA_STATUS_REG)},
> +       { SOC15_REG_ENTRY(SDMA3, 0, regSDMA3_SDMA_STATUS_REG)},
> +       { SOC15_REG_ENTRY(GC, 0, regCP_STAT)},
> +       { SOC15_REG_ENTRY(GC, 0, regCP_STALLED_STAT1)},
> +       { SOC15_REG_ENTRY(GC, 0, regCP_STALLED_STAT2)},
> +       { SOC15_REG_ENTRY(GC, 0, regCP_STALLED_STAT3)},
> +       { SOC15_REG_ENTRY(GC, 0, regCP_CPF_BUSY_STAT)},
> +       { SOC15_REG_ENTRY(GC, 0, regCP_CPF_STALLED_STAT1)},
> +       { SOC15_REG_ENTRY(GC, 0, regCP_CPF_STATUS)},
> +       { SOC15_REG_ENTRY(GC, 0, regCP_CPC_BUSY_STAT)},
> +       { SOC15_REG_ENTRY(GC, 0, regCP_CPC_STALLED_STAT1)},
> +       { SOC15_REG_ENTRY(GC, 0, regCP_CPC_STATUS)},
> +       { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> +};
> +
> +static uint32_t soc_v2_0_read_indexed_register(struct amdgpu_device *ade=
v,
> +                                              u32 se_num,
> +                                              u32 sh_num,
> +                                              u32 reg_offset)
> +{
> +       uint32_t val;
> +
> +       mutex_lock(&adev->grbm_idx_mutex);
> +       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> +               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff,=
 0);
> +
> +       val =3D RREG32(reg_offset);
> +
> +       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> +               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xf=
fffffff, 0);
> +       mutex_unlock(&adev->grbm_idx_mutex);
> +       return val;
> +}
> +
> +static uint32_t soc_v2_0_get_register_value(struct amdgpu_device *adev,
> +                                           bool indexed, u32 se_num,
> +                                           u32 sh_num, u32 reg_offset)
> +{
> +       if (indexed) {
> +               return soc_v2_0_read_indexed_register(adev, se_num, sh_nu=
m, reg_offset);
> +       } else {
> +               if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_ADDR_=
CONFIG) &&
> +                   adev->gfx.config.gb_addr_config)
> +                       return adev->gfx.config.gb_addr_config;
> +               return RREG32(reg_offset);
> +       }
> +}
> +
> +static int soc_v2_0_read_register(struct amdgpu_device *adev, u32 se_num=
,
> +                                 u32 sh_num, u32 reg_offset, u32 *value)
> +{
> +       uint32_t i;
> +       struct soc15_allowed_register_entry  *en;
> +
> +       *value =3D 0;
> +       for (i =3D 0; i < ARRAY_SIZE(soc_v2_0_allowed_read_registers); i+=
+) {
> +               en =3D &soc_v2_0_allowed_read_registers[i];
> +               if (!adev->reg_offset[en->hwip][en->inst])
> +                       continue;
> +               else if (reg_offset !=3D (adev->reg_offset[en->hwip][en->=
inst][en->seg]
> +                                       + en->reg_offset))
> +                       continue;
> +
> +               *value =3D soc_v2_0_get_register_value(adev,
> +                               soc_v2_0_allowed_read_registers[i].grbm_i=
ndexed,
> +                               se_num, sh_num, reg_offset);
> +               return 0;
> +       }
> +       return -EINVAL;
> +}
> +
> +static enum amd_reset_method soc_v2_0_asic_reset_method(struct amdgpu_de=
vice *adev)
> +{
> +       if (amdgpu_reset_method =3D=3D AMD_RESET_METHOD_MODE0 ||
> +           amdgpu_reset_method =3D=3D AMD_RESET_METHOD_MODE2 ||
> +           amdgpu_reset_method =3D=3D AMD_RESET_METHOD_BACO)
> +               return amdgpu_reset_method;
> +
> +       if (amdgpu_reset_method !=3D -1)
> +               dev_warn(adev->dev,
> +                        "Specified reset method:%d isn't supported, usin=
g AUTO instead.\n",
> +                        amdgpu_reset_method);
> +
> +       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> +       case IP_VERSION(15, 0, 3):
> +               return AMD_RESET_METHOD_MODE0;
> +       default:
> +               if (amdgpu_dpm_is_baco_supported(adev))
> +                       return AMD_RESET_METHOD_BACO;
> +               else
> +                       return AMD_RESET_METHOD_MODE0;
> +       }
> +}
> +
> +static int soc_v2_0_asic_reset(struct amdgpu_device *adev)
> +{
> +       int ret =3D 0;
> +
> +       switch (soc_v2_0_asic_reset_method(adev)) {
> +       case AMD_RESET_METHOD_PCI:
> +               dev_info(adev->dev, "PCI reset\n");
> +               ret =3D amdgpu_device_pci_reset(adev);
> +               break;
> +       case AMD_RESET_METHOD_BACO:
> +               dev_info(adev->dev, "BACO reset\n");
> +               ret =3D amdgpu_dpm_baco_reset(adev);
> +               break;
> +       case AMD_RESET_METHOD_MODE2:
> +               dev_info(adev->dev, "MODE2 reset\n");
> +               ret =3D amdgpu_dpm_mode2_reset(adev);
> +               break;
> +       default:
> +               dev_info(adev->dev, "MODE0 reset\n");
> +               /*TODO: replace mode1 with mode0 */
> +               ret =3D amdgpu_device_mode1_reset(adev);
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +const struct amdgpu_ip_block_version soc_v2_0_common_ip_block =3D {
> +       .type =3D AMD_IP_BLOCK_TYPE_COMMON,
> +       .major =3D 2,
> +       .minor =3D 0,
> +       .rev =3D 0,
> +       .funcs =3D &soc_v2_0_common_ip_funcs,
> +};
> +
> +static bool soc_v2_0_need_reset_on_init(struct amdgpu_device *adev)
> +{
> +       u32 sol_reg;
> +
> +       if (adev->flags & AMD_IS_APU)
> +               return false;
> +
> +       /*
> +        * Check the sOS sign-of-life register to confirm that the system
> +        * driver and sOS are already loaded.
> +        */
> +
> +       sol_reg =3D RREG32_SOC15(MP0, 0,
> +                               regMPASP_PCRU0_MPASP_C2PMSG_81);
> +       if (sol_reg)
> +               return true;
> +
> +       return false;
> +}
> +
> +static void soc_v2_0_init_doorbell_index(struct amdgpu_device *adev)
> +{
> +       adev->doorbell_index.kiq =3D AMDGPU_NAVI10_DOORBELL_KIQ;
> +       adev->doorbell_index.mec_ring0 =3D AMDGPU_NAVI10_DOORBELL_MEC_RIN=
G0;
> +       adev->doorbell_index.mec_ring1 =3D AMDGPU_NAVI10_DOORBELL_MEC_RIN=
G1;
> +       adev->doorbell_index.mec_ring2 =3D AMDGPU_NAVI10_DOORBELL_MEC_RIN=
G2;
> +       adev->doorbell_index.mec_ring3 =3D AMDGPU_NAVI10_DOORBELL_MEC_RIN=
G3;
> +       adev->doorbell_index.mec_ring4 =3D AMDGPU_NAVI10_DOORBELL_MEC_RIN=
G4;
> +       adev->doorbell_index.mec_ring5 =3D AMDGPU_NAVI10_DOORBELL_MEC_RIN=
G5;
> +       adev->doorbell_index.mec_ring6 =3D AMDGPU_NAVI10_DOORBELL_MEC_RIN=
G6;
> +       adev->doorbell_index.mec_ring7 =3D AMDGPU_NAVI10_DOORBELL_MEC_RIN=
G7;
> +       adev->doorbell_index.userqueue_start =3D AMDGPU_NAVI10_DOORBELL_U=
SERQUEUE_START;
> +       adev->doorbell_index.userqueue_end =3D AMDGPU_NAVI10_DOORBELL_USE=
RQUEUE_END;
> +       adev->doorbell_index.gfx_ring0 =3D AMDGPU_NAVI10_DOORBELL_GFX_RIN=
G0;
> +       adev->doorbell_index.gfx_ring1 =3D AMDGPU_NAVI10_DOORBELL_GFX_RIN=
G1;
> +       adev->doorbell_index.gfx_userqueue_start =3D
> +               AMDGPU_NAVI10_DOORBELL_GFX_USERQUEUE_START;
> +       adev->doorbell_index.gfx_userqueue_end =3D
> +               AMDGPU_NAVI10_DOORBELL_GFX_USERQUEUE_END;
> +       adev->doorbell_index.mes_ring0 =3D AMDGPU_NAVI10_DOORBELL_MES_RIN=
G0;
> +       adev->doorbell_index.mes_ring1 =3D AMDGPU_NAVI10_DOORBELL_MES_RIN=
G1;
> +       adev->doorbell_index.sdma_engine[0] =3D AMDGPU_NAVI10_DOORBELL_sD=
MA_ENGINE0;
> +       adev->doorbell_index.sdma_engine[1] =3D AMDGPU_NAVI10_DOORBELL_sD=
MA_ENGINE1;
> +       adev->doorbell_index.sdma_engine[2] =3D AMDGPU_NAVI10_DOORBELL_sD=
MA_ENGINE2;
> +       adev->doorbell_index.sdma_engine[3] =3D AMDGPU_NAVI10_DOORBELL_sD=
MA_ENGINE3;
> +       adev->doorbell_index.ih =3D AMDGPU_NAVI10_DOORBELL_IH;
> +       adev->doorbell_index.vcn.vcn_ring0_1 =3D AMDGPU_NAVI10_DOORBELL64=
_VCN0_1;
> +       adev->doorbell_index.vcn.vcn_ring2_3 =3D AMDGPU_NAVI10_DOORBELL64=
_VCN2_3;
> +       adev->doorbell_index.vcn.vcn_ring4_5 =3D AMDGPU_NAVI10_DOORBELL64=
_VCN4_5;
> +       adev->doorbell_index.vcn.vcn_ring6_7 =3D AMDGPU_NAVI10_DOORBELL64=
_VCN6_7;
> +       adev->doorbell_index.vpe_ring =3D AMDGPU_NAVI10_DOORBELL64_VPE;
> +       adev->doorbell_index.first_non_cp =3D AMDGPU_NAVI10_DOORBELL64_FI=
RST_NON_CP;
> +       adev->doorbell_index.last_non_cp =3D AMDGPU_NAVI10_DOORBELL64_LAS=
T_NON_CP;
> +
> +       adev->doorbell_index.max_assignment =3D AMDGPU_NAVI10_DOORBELL_MA=
X_ASSIGNMENT << 1;
> +       adev->doorbell_index.sdma_doorbell_range =3D 20;
> +}
> +
> +static int soc_v2_0_update_umd_stable_pstate(struct amdgpu_device *adev,
> +                                            bool enter)
> +{
> +       if (enter)
> +               amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> +       else
> +               amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> +
> +       if (adev->gfx.funcs &&
> +           adev->gfx.funcs->update_perfmon_mgcg)
> +               adev->gfx.funcs->update_perfmon_mgcg(adev, !enter);
> +
> +       return 0;
> +}
> +
> +static void soc_v2_0_get_fw_reserved_info(struct amdgpu_device *adev,
> +                                         u64 *reserve_size,
> +                                         u64 *offset)
> +{
> +       struct mem_reserved_info_table_v1_0 *table =3D
> +               adev->discovery.mem_reserved_table;
> +       u64 resv_start =3D U64_MAX, resv_end =3D 0;
> +       u64 vram_base, vram_end, start, end, size;
> +       u32 list_num, id, i;
> +
> +       if (!table) {
> +               dev_warn(adev->dev, "MEM_RESERVED_INFO table not availabl=
e\n");
> +               return;
> +       }
> +
> +       vram_base =3D adev->gmc.vram_start - adev->mmhub.funcs->get_fb_lo=
cation(adev);
> +       vram_end =3D vram_base + adev->gmc.real_vram_size;
> +
> +       list_num =3D min_t(u32, le32_to_cpu(table->list_num), MAX_MEM_REG=
ION_NUM);
> +       for (i =3D 0; i < list_num; i++) {
> +               id =3D le32_to_cpu(table->list[i].reserved_region_id);
> +               size =3D le64_to_cpu(table->list[i].reserved_region_size)=
;
> +               start =3D le64_to_cpu(table->list[i].reserved_region_star=
t);
> +
> +               if (id =3D=3D NO_RESERVED_REGION_ID ||
> +                   id =3D=3D SPECIFIC_PURPOSE_REGION_ID || !size)
> +                       continue;
> +
> +               if (check_add_overflow(start, size, &end))
> +                       continue;
> +
> +               if (end <=3D vram_base || start >=3D vram_end)
> +                       continue;
> +
> +               resv_start =3D min(resv_start, max(start, vram_base));
> +               resv_end =3D max(resv_end, min(end, vram_end));
> +       }
> +
> +       if (resv_start >=3D resv_end) {
> +               dev_warn(adev->dev,
> +                        "no MEM_RESERVED_INFO region inside VRAM [0x%llx=
, 0x%llx)\n",
> +                        vram_base, vram_end);
> +               return;
> +       }
> +
> +       *offset =3D resv_start - vram_base;
> +       *reserve_size =3D resv_end - resv_start;
> +}
> +
> +static const struct amdgpu_asic_funcs soc_v2_0_asic_funcs =3D {
> +       .read_bios_from_rom =3D &amdgpu_soc15_read_bios_from_rom,
> +       .read_register =3D &soc_v2_0_read_register,
> +       .reset =3D &soc_v2_0_asic_reset,
> +       .reset_method =3D &soc_v2_0_asic_reset_method,
> +       .get_xclk =3D &soc_v2_0_get_xclk,
> +       .get_config_memsize =3D &soc_v2_0_get_config_memsize,
> +       .init_doorbell_index =3D &soc_v2_0_init_doorbell_index,
> +       .need_reset_on_init =3D &soc_v2_0_need_reset_on_init,
> +       .supports_baco =3D &amdgpu_dpm_is_baco_supported,
> +       .update_umd_stable_pstate =3D &soc_v2_0_update_umd_stable_pstate,
> +       .get_fw_reserved_info =3D &soc_v2_0_get_fw_reserved_info,
> +};
> +
> +static int soc_v2_0_common_early_init(struct amdgpu_ip_block *ip_block)
> +{
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +
> +       adev->nbio.funcs->set_reg_remap(adev);
> +       adev->reg.pcie.rreg =3D &amdgpu_device_indirect_rreg;
> +       adev->reg.pcie.wreg =3D &amdgpu_device_indirect_wreg;
> +       adev->reg.pcie.rreg_ext =3D &amdgpu_device_indirect_rreg_ext;
> +       adev->reg.pcie.wreg_ext =3D &amdgpu_device_indirect_wreg_ext;
> +       adev->reg.pcie.rreg64 =3D &amdgpu_device_indirect_rreg64;
> +       adev->reg.pcie.wreg64 =3D &amdgpu_device_indirect_wreg64;
> +       adev->reg.pcie.port_rreg =3D &amdgpu_device_pcie_port_rreg;
> +       adev->reg.pcie.port_wreg =3D &amdgpu_device_pcie_port_wreg;
> +
> +       adev->asic_funcs =3D &soc_v2_0_asic_funcs;
> +
> +       adev->rev_id =3D amdgpu_device_get_rev_id(adev);
> +       adev->external_rev_id =3D 0xff;
> +
> +       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +       case IP_VERSION(13, 0, 1):
> +               adev->cg_flags =3D 0;
> +               adev->pg_flags =3D 0;
> +               adev->external_rev_id =3D adev->rev_id + 0x10;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       if (amdgpu_sriov_vf(adev)) {
> +               amdgpu_virt_init_setting(adev);
> +               xgpu_nv_mailbox_set_irq_funcs(adev);
> +       }
> +
> +       return 0;
> +}
> +
> +static int soc_v2_0_common_late_init(struct amdgpu_ip_block *ip_block)
> +{
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +
> +       if (amdgpu_sriov_vf(adev)) {
> +               xgpu_nv_mailbox_get_irq(adev);
> +       } else {
> +               if (adev->nbio.ras &&
> +                   adev->nbio.ras_err_event_athub_irq.funcs)
> +                       /* don't need to fail gpu late init
> +                        * if enabling athub_err_event interrupt failed
> +                        * nbif v6_3_1 only support fatal error hanlding
> +                        * just enable the interrupt directly
> +                        */
> +                       amdgpu_irq_get(adev, &adev->nbio.ras_err_event_at=
hub_irq, 0);
> +       }
> +
> +       /* Enable selfring doorbell aperture late because doorbell BAR
> +        * aperture will change if resize BAR successfully in gmc sw_init=
.
> +        */
> +       adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
> +
> +       return 0;
> +}
> +
> +static int soc_v2_0_common_sw_init(struct amdgpu_ip_block *ip_block)
> +{
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +
> +       if (amdgpu_sriov_vf(adev))
> +               xgpu_nv_mailbox_add_irq_id(adev);
> +
> +       return 0;
> +}
> +
> +static int soc_v2_0_common_hw_init(struct amdgpu_ip_block *ip_block)
> +{
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +
> +       /* setup nbio registers */
> +       if (adev->nbio.funcs &&
> +           adev->nbio.funcs->init_registers)
> +               adev->nbio.funcs->init_registers(adev);
> +       /* remap HDP registers to a hole in mmio space,
> +        * for the purpose of expose those registers
> +        * to process space
> +        */
> +       if (adev->nbio.funcs &&
> +           adev->nbio.funcs->remap_hdp_registers)
> +               adev->nbio.funcs->remap_hdp_registers(adev);
> +
> +       if (adev->df.funcs &&
> +           adev->df.funcs->hw_init)
> +               adev->df.funcs->hw_init(adev);
> +
> +       /* enable the doorbell aperture */
> +       if (adev->nbio.funcs &&
> +           adev->nbio.funcs->enable_doorbell_aperture)
> +               adev->nbio.funcs->enable_doorbell_aperture(adev, true);
> +
> +       return 0;
> +}
> +
> +static int soc_v2_0_common_hw_fini(struct amdgpu_ip_block *ip_block)
> +{
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +
> +       /* Disable the doorbell aperture and selfring doorbell aperture
> +        * separately in hw_fini because soc21_enable_doorbell_aperture
> +        * has been removed and there is no need to delay disabling
> +        * selfring doorbell.
> +        */
> +       if (adev->nbio.funcs &&
> +           adev->nbio.funcs->enable_doorbell_aperture)
> +               adev->nbio.funcs->enable_doorbell_aperture(adev, false);
> +       if (adev->nbio.funcs &&
> +           adev->nbio.funcs->enable_doorbell_selfring_aperture)
> +               adev->nbio.funcs->enable_doorbell_selfring_aperture(adev,=
 false);
> +
> +       if (amdgpu_sriov_vf(adev)) {
> +               xgpu_nv_mailbox_put_irq(adev);
> +       } else {
> +               if (adev->nbio.ras &&
> +                   adev->nbio.ras_err_event_athub_irq.funcs)
> +                       amdgpu_irq_put(adev, &adev->nbio.ras_err_event_at=
hub_irq, 0);
> +       }
> +
> +       return 0;
> +}
> +
> +static int soc_v2_0_common_suspend(struct amdgpu_ip_block *ip_block)
> +{
> +       return soc_v2_0_common_hw_fini(ip_block);
> +}
> +
> +static int soc_v2_0_common_resume(struct amdgpu_ip_block *ip_block)
> +{
> +       return soc_v2_0_common_hw_init(ip_block);
> +}
> +
> +static int soc_v2_0_common_set_clockgating_state(struct amdgpu_ip_block =
*ip_block,
> +                                                enum amd_clockgating_sta=
te state)
> +{
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +
> +       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
> +       case IP_VERSION(7, 10, 0):
> +               if (adev->nbio.funcs &&
> +                   adev->nbio.funcs->update_medium_grain_clock_gating)
> +                       adev->nbio.funcs->update_medium_grain_clock_gatin=
g(adev,
> +                                                       state =3D=3D AMD_=
CG_STATE_GATE);
> +               if (adev->nbio.funcs &&
> +                   adev->nbio.funcs->update_medium_grain_light_sleep)
> +                       adev->nbio.funcs->update_medium_grain_light_sleep=
(adev,
> +                                                       state =3D=3D AMD_=
CG_STATE_GATE);
> +               if (adev->hdp.funcs &&
> +                   adev->hdp.funcs->update_clock_gating)
> +                       adev->hdp.funcs->update_clock_gating(adev,
> +                                                       state =3D=3D AMD_=
CG_STATE_GATE);
> +               break;
> +       default:
> +               break;
> +       }
> +       return 0;
> +}
> +
> +static int soc_v2_0_common_set_powergating_state(struct amdgpu_ip_block =
*ip_block,
> +                                             enum amd_powergating_state =
state)
> +{
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +
> +       switch (amdgpu_ip_version(adev, LSDMA_HWIP, 0)) {
> +       case IP_VERSION(8, 0, 1):
> +               if (adev->lsdma.funcs &&
> +                   adev->lsdma.funcs->update_memory_power_gating)
> +                       adev->lsdma.funcs->update_memory_power_gating(ade=
v,
> +                                                       state =3D=3D AMD_=
PG_STATE_GATE);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return 0;
> +}
> +
> +static void soc_v2_0_common_get_clockgating_state(struct amdgpu_ip_block=
 *ip_block, u64 *flags)
> +{
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +
> +       if (adev->nbio.funcs &&
> +           adev->nbio.funcs->get_clockgating_state)
> +               adev->nbio.funcs->get_clockgating_state(adev, flags);
> +
> +       if (adev->hdp.funcs &&
> +           adev->hdp.funcs->get_clock_gating_state)
> +               adev->hdp.funcs->get_clock_gating_state(adev, flags);
> +
> +       return;
> +}
> +
> +static const struct amd_ip_funcs soc_v2_0_common_ip_funcs =3D {
> +       .name =3D "soc_v2_0_common",
> +       .early_init =3D soc_v2_0_common_early_init,
> +       .late_init =3D soc_v2_0_common_late_init,
> +       .sw_init =3D soc_v2_0_common_sw_init,
> +       .hw_init =3D soc_v2_0_common_hw_init,
> +       .hw_fini =3D soc_v2_0_common_hw_fini,
> +       .suspend =3D soc_v2_0_common_suspend,
> +       .resume =3D soc_v2_0_common_resume,
> +       .set_clockgating_state =3D soc_v2_0_common_set_clockgating_state,
> +       .set_powergating_state =3D soc_v2_0_common_set_powergating_state,
> +       .get_clockgating_state =3D soc_v2_0_common_get_clockgating_state,
> +};
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v2_0.h b/drivers/gpu/drm/amd/=
amdgpu/soc_v2_0.h
> new file mode 100644
> index 0000000000000..9ef80ffa7a0c4
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/soc_v2_0.h
> @@ -0,0 +1,30 @@
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#ifndef __SOC_V2_0_H__
> +#define __SOC_V2_0_H__
> +
> +extern const struct amdgpu_ip_block_version soc_v2_0_common_ip_block;
> +
> +void soc_v2_0_grbm_select(struct amdgpu_device *adev,
> +                         u32 me, u32 pipe, u32 queue, u32 vmid);
> +#endif
> --
> 2.56.0
>
