Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327BCCE7B1E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 15:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7D4810EA89;
	Fri,  6 Sep 2024 15:04:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P2ybn9Cc";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CEED10EA89
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 15:04:54 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2056129a6d7so968865ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Sep 2024 08:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725635093; x=1726239893; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/Gs4hKQucAoDlB4prDiA7wR1h8KOO+C8DI3qy19FeQ=;
 b=P2ybn9CcZ+9XR/o1JmwUm6ybUIDFMjymx223zbkx4cmcrTDGNJCREf6vW+ZsvZXD1k
 n5kJYSWktwSkmcegqAlIF2kz/tQk/Ifd4OrfOC6Gi1hTmg+y74/zTrxieocEKAKIDjzu
 1GNoLmCmA6M+nRHADHFLD84WSZx/91mjyq7DUcD379QwIRyAA6hPOXiW8RBDrCNxMh9M
 jhe5/XZYozi2/zQYfqA9/PmSsdFyh2Clsh/qaEmvwJyW20rto6wN+X1Wd35UOS/bfNAt
 e5GbHRQI2bXR7egEO/VDv+cQjby+KMrrmdHDcCIwkO8VTWIZfz95Yn/pvEP7cceSi9z+
 xlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725635093; x=1726239893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t/Gs4hKQucAoDlB4prDiA7wR1h8KOO+C8DI3qy19FeQ=;
 b=TVyx0PPQEWbWxN28N95mOqwqW7PFJtyNw26dRXzT81v9orEWjQfOj0v0EFKSBz/+/Z
 QiAVplOX2N92FAQmpCcrdJIt6c5ojB0WJBzYemifMhOBTCvPxFLPHziM2y2g0mMHavNQ
 wB51AQVS5eSj3SK114IEni0ElMiKFsjIvX6R6L9r3GNLmMzKzeumuxuQnKuSiNH/U5Z8
 bv4ctMnW1ykCKqfREPhpbnrccGOvKIxgR7+jgCyKHQtW0WFkZUD8PvtHn60SS6LFWKyF
 FiLP4J7r3hQ7XdMFrrp1wRV5YPp7MqOU6fdvWP0jtXLv/jjP7W/b/lJdso1zsJpnDdGa
 6hNQ==
X-Gm-Message-State: AOJu0Yzm9xi4Z90njGklvb9RjTwuEzME540323gLCGZwxTEoXa77hDGK
 T4m4yvbECB0wW3KcxnLfQqJhVGZ/TZpPJiVR26FC9b9YyI2yoz0NRsSg01411beph2k2wG1eSIW
 OZfoSx1o/EFXQxI8p7k5XQLR595w=
X-Google-Smtp-Source: AGHT+IHl7CSrHwU6Y4Iv1fFlHzwRpmIw1XhnRns1hXqsg8zod/AWx2mGdTlxrgRxjoRQvB5sWkslXtkWiOp9VQcWshw=
X-Received: by 2002:a17:902:f550:b0:206:ad19:c0f2 with SMTP id
 d9443c01a7336-206f04cf0fdmr16444805ad.1.1725635093273; Fri, 06 Sep 2024
 08:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240905214016.501543-1-David.Wu3@amd.com>
 <20240905214016.501543-2-David.Wu3@amd.com>
In-Reply-To: <20240905214016.501543-2-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Sep 2024 11:04:42 -0400
Message-ID: <CADnq5_PJN+C1_F2C6UsO8mNwADLYhHFKC44SuMkh7cE5-sF_UQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu: apply command submission parser for
 JPEG v1
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 Christian.Koenig@amd.com, leo.liu@amd.com
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

On Thu, Sep 5, 2024 at 5:40=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@amd=
.com> wrote:
>
> Similar to jpeg_v2_dec_ring_parse_cs() but it has different
> register ranges and a few other registers access.
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c | 76 +++++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h | 11 ++++
>  2 files changed, 86 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v1_0.c
> index 71f43a5c7f72..e8c0bd228ec7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> @@ -23,6 +23,7 @@
>
>  #include "amdgpu.h"
>  #include "amdgpu_jpeg.h"
> +#include "amdgpu_cs.h"
>  #include "soc15.h"
>  #include "soc15d.h"
>  #include "vcn_v1_0.h"
> @@ -34,6 +35,9 @@
>  static void jpeg_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>  static void jpeg_v1_0_set_irq_funcs(struct amdgpu_device *adev);
>  static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring);
> +static int jpeg_v1_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
> +                                    struct amdgpu_job *job,
> +                                    struct amdgpu_ib *ib);
>
>  static void jpeg_v1_0_decode_ring_patch_wreg(struct amdgpu_ring *ring, u=
int32_t *ptr, uint32_t reg_offset, uint32_t val)
>  {
> @@ -300,7 +304,10 @@ static void jpeg_v1_0_decode_ring_emit_ib(struct amd=
gpu_ring *ring,
>
>         amdgpu_ring_write(ring,
>                 PACKETJ(SOC15_REG_OFFSET(JPEG, 0, mmUVD_LMI_JRBC_IB_VMID)=
, 0, 0, PACKETJ_TYPE0));
> -       amdgpu_ring_write(ring, (vmid | (vmid << 4)));
> +       if (ring->funcs->parse_cs)
> +               amdgpu_ring_write(ring, 0);
> +       else
> +               amdgpu_ring_write(ring, (vmid | (vmid << 4)));
>
>         amdgpu_ring_write(ring,
>                 PACKETJ(SOC15_REG_OFFSET(JPEG, 0, mmUVD_LMI_JPEG_VMID), 0=
, 0, PACKETJ_TYPE0));
> @@ -554,6 +561,7 @@ static const struct amdgpu_ring_funcs jpeg_v1_0_decod=
e_ring_vm_funcs =3D {
>         .get_rptr =3D jpeg_v1_0_decode_ring_get_rptr,
>         .get_wptr =3D jpeg_v1_0_decode_ring_get_wptr,
>         .set_wptr =3D jpeg_v1_0_decode_ring_set_wptr,
> +       .parse_cs =3D jpeg_v1_dec_ring_parse_cs,
>         .emit_frame_size =3D
>                 6 + 6 + /* hdp invalidate / flush */
>                 SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
> @@ -611,3 +619,69 @@ static void jpeg_v1_0_ring_begin_use(struct amdgpu_r=
ing *ring)
>
>         vcn_v1_0_set_pg_for_begin_use(ring, set_clocks);
>  }
> +
> +/**
> + * jpeg_v1_dec_ring_parse_cs - command submission parser
> + *
> + * @parser: Command submission parser context
> + * @job: the job to parse
> + * @ib: the IB to parse
> + *
> + * Parse the command stream, return -EINVAL for invalid packet,
> + * 0 otherwise
> + */
> +static int jpeg_v1_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
> +                                    struct amdgpu_job *job,
> +                                    struct amdgpu_ib *ib)
> +{
> +       uint32_t i, reg, res, cond, type;
> +       int32_t ret =3D 0;
> +       struct amdgpu_device *adev =3D parser->adev;
> +
> +       for (i =3D 0; i < ib->length_dw ; i +=3D 2) {
> +               reg  =3D CP_PACKETJ_GET_REG(ib->ptr[i]);
> +               res  =3D CP_PACKETJ_GET_RES(ib->ptr[i]);
> +               cond =3D CP_PACKETJ_GET_COND(ib->ptr[i]);
> +               type =3D CP_PACKETJ_GET_TYPE(ib->ptr[i]);
> +
> +               if (res || cond !=3D PACKETJ_CONDITION_CHECK0) /* only al=
low 0 for now */
> +                       return -EINVAL;
> +
> +               if (reg >=3D JPEG_V1_REG_RANGE_START && reg <=3D JPEG_V1_=
REG_RANGE_END)
> +                       continue;
> +
> +               switch (type) {
> +               case PACKETJ_TYPE0:
> +                       if (reg !=3D JPEG_V1_LMI_JPEG_WRITE_64BIT_BAR_HIG=
H &&
> +                           reg !=3D JPEG_V1_LMI_JPEG_WRITE_64BIT_BAR_LOW=
 &&
> +                           reg !=3D JPEG_V1_LMI_JPEG_READ_64BIT_BAR_HIGH=
 &&
> +                           reg !=3D JPEG_V1_LMI_JPEG_READ_64BIT_BAR_LOW =
&&
> +                           reg !=3D JPEG_V1_REG_CTX_INDEX &&
> +                           reg !=3D JPEG_V1_REG_CTX_DATA) {
> +                               ret =3D -EINVAL;
> +                       }
> +                       break;
> +               case PACKETJ_TYPE1:
> +                       if (reg !=3D JPEG_V1_REG_CTX_DATA)
> +                               ret =3D -EINVAL;
> +                       break;
> +               case PACKETJ_TYPE3:
> +                       if (reg !=3D JPEG_V1_REG_SOFT_RESET)
> +                               ret =3D -EINVAL;
> +                       break;
> +               case PACKETJ_TYPE6:
> +                       if (ib->ptr[i] !=3D CP_PACKETJ_NOP)
> +                               ret =3D -EINVAL;
> +                       break;
> +               default:
> +                       ret =3D -EINVAL;
> +               }
> +
> +               if (ret) {
> +                       dev_err(adev->dev, "Invalid packet [0x%08x]!\n", =
ib->ptr[i]);
> +                       break;
> +               }
> +       }
> +
> +       return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v1_0.h
> index bbf33a6a3972..9654d22e0376 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h
> @@ -29,4 +29,15 @@ int jpeg_v1_0_sw_init(void *handle);
>  void jpeg_v1_0_sw_fini(void *handle);
>  void jpeg_v1_0_start(struct amdgpu_device *adev, int mode);
>
> +#define JPEG_V1_REG_RANGE_START        0x8000
> +#define JPEG_V1_REG_RANGE_END  0x803f
> +
> +#define JPEG_V1_LMI_JPEG_WRITE_64BIT_BAR_HIGH  0x8238
> +#define JPEG_V1_LMI_JPEG_WRITE_64BIT_BAR_LOW   0x8239
> +#define JPEG_V1_LMI_JPEG_READ_64BIT_BAR_HIGH   0x825a
> +#define JPEG_V1_LMI_JPEG_READ_64BIT_BAR_LOW    0x825b
> +#define JPEG_V1_REG_CTX_INDEX                  0x8328
> +#define JPEG_V1_REG_CTX_DATA                   0x8329
> +#define JPEG_V1_REG_SOFT_RESET                 0x83a0
> +
>  #endif /*__JPEG_V1_0_H__*/
> --
> 2.34.1
>
