Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D3BC52D6F
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 20:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C53610E3F3;
	Tue,  6 Aug 2024 20:09:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XSEfbQ4t";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B32510E3F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 20:09:28 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-70d1d6369acso164382b3a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Aug 2024 13:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722974968; x=1723579768; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5fOCofwbCwLERLPtcV5uxTqI5VCEqyrok7zop1Q6Ec=;
 b=XSEfbQ4tG64fUvZyqsztDekhYbFEm3rlCOgWczYGF3zLpTXBQYTCXRe2CQccPAvTuO
 bfwhOnAOZAyaAJC/yj/aG72CM9/ei/I2nlRoBPM/YKwJMlBLet04dkQwRm7PFQXSzuCG
 cgGZQWMPF1S/HP5vGWG8/bCABCgiiFLeqUy+S1DiVRxOjiIJjnZdjgnuUNTNMo7adwLa
 cyn51pU78FVHyFN7r1peIj2+OA0fBYIblzNsqcl9XC0YRAxv6iAbcy4G7sEo6RvK9rsO
 7gh1+6LBSqb9ucEYE/v2lLf/IGye8C98FsjLZse/VOC/Q3nnwKETCNBPM5YikbswvrLx
 +BIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722974968; x=1723579768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q5fOCofwbCwLERLPtcV5uxTqI5VCEqyrok7zop1Q6Ec=;
 b=CGAwTT0hSCTPuqTyKJPVx4ziRu11WTtThRLoHKlJ2xyZIbv0wZngMqwwwgZU/OtkPU
 pcdj6A3e0k79Fs2RlvRaiWVMPR2WsGaGC2ukIrSIBVmZMQ59JGSU6tXoMkut7xTlg61G
 cd4dP8QjmeLK6XLErpbpKB3oiQoKn48a9n8fBJpVdBGrQ3CUKIpdZSZe5YrnhuzJD3L7
 ybwfxy5VxTb3L5vg8ddpVTfveVjlXGriKgHYpe8lDdkzc/Cggr5oMROf3x5bL7PuVDda
 +FwckPqogKW8Ihkmw6Q3GFa5G2zR9Gpe9WevBR+Yf+DSzReK/oSKlStn2zrkgvQKv5wH
 B2Hg==
X-Gm-Message-State: AOJu0YwD7jToxmQmnajxGhlDV7xz97x6A13eJQFRLpcfqGrXZCNSBP+k
 q2o2AVTBhu7c1SVilR5CesTaSDXHJ7fjH+S78BoseKV0lYZ2iFwl4DUiujJuCrdO11FWKIdqhvL
 HKe548ZmiD6e+JH4rO9gFGc4v/I5Mzg==
X-Google-Smtp-Source: AGHT+IHeQgfLTUZkUH+zchshvIsQ42NveLYBVzYmX1UEzuOw5/5h8AKEv8/6H3n+Klq/iW2/TXyXH5e62U69Z8GPwVY=
X-Received: by 2002:a05:6a20:d8b:b0:1c3:f4b6:f83c with SMTP id
 adf61e73a8af0-1c69a6dba66mr19602932637.26.1722974967704; Tue, 06 Aug 2024
 13:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240806160012.234633-1-David.Wu3@amd.com>
In-Reply-To: <20240806160012.234633-1-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 Aug 2024 16:09:14 -0400
Message-ID: <CADnq5_NvEEYqXw9HL+6SyauxwGK_KbJg-3CSgjyOatkdV1ehgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/amdgpu: command submission parser for JPEG
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, 
 alexander.deucher@amd.com, leo.liu@amd.com
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

On Tue, Aug 6, 2024 at 12:00=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@am=
d.com> wrote:
>
> Add JPEG IB command parser to ensure registers
> in the command are within the JPEG IP block.
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  3 ++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 58 +++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h |  7 ++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/soc15d.h      |  6 +++
>  5 files changed, 73 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 1e167d925b64..78b3c067fea7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1061,6 +1061,9 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_par=
ser *p,
>                         r =3D amdgpu_ring_parse_cs(ring, p, job, ib);
>                         if (r)
>                                 return r;
> +
> +                       if (ib->sa_bo)
> +                               ib->gpu_addr =3D  amdgpu_sa_bo_gpu_addr(i=
b->sa_bo);
>                 } else {
>                         ib->ptr =3D (uint32_t *)kptr;
>                         r =3D amdgpu_ring_patch_cs_in_place(ring, p, job,=
 ib);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v4_0_3.c
> index ad524ddc9760..6ccf61d7c13d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -782,7 +782,11 @@ void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring=
 *ring,
>
>         amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JRBC_IB_VMID_INTERNAL_=
OFFSET,
>                 0, 0, PACKETJ_TYPE0));
> -       amdgpu_ring_write(ring, (vmid | (vmid << 4)));
> +
> +       if (ring->funcs->parse_cs)
> +               amdgpu_ring_write(ring, 0);
> +       else
> +               amdgpu_ring_write(ring, (vmid | (vmid << 4)));
>
>         amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JPEG_VMID_INTERNAL_OFF=
SET,
>                 0, 0, PACKETJ_TYPE0));
> @@ -1084,6 +1088,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_d=
ec_ring_vm_funcs =3D {
>         .get_rptr =3D jpeg_v4_0_3_dec_ring_get_rptr,
>         .get_wptr =3D jpeg_v4_0_3_dec_ring_get_wptr,
>         .set_wptr =3D jpeg_v4_0_3_dec_ring_set_wptr,
> +       .parse_cs =3D jpeg_v4_0_3_dec_ring_parse_cs,
>         .emit_frame_size =3D
>                 SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
>                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
> @@ -1248,3 +1253,54 @@ static void jpeg_v4_0_3_set_ras_funcs(struct amdgp=
u_device *adev)
>  {
>         adev->jpeg.ras =3D &jpeg_v4_0_3_ras;
>  }
> +
> +/**
> + * jpeg_v4_0_3_dec_ring_parse_cs - command submission parser
> + *
> + * @parser: Command submission parser context
> + * @job: the job to parse
> + * @ib: the IB to parse
> + *
> + * Parse the command stream, return -EINVAL for invalid packet

Needs a comma at the end of this line.

Alex

> + * 0 otherwise
> + */
> +int jpeg_v4_0_3_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
> +                            struct amdgpu_job *job,
> +                            struct amdgpu_ib *ib)
> +{
> +       uint32_t i, reg, res, cond, type;
> +
> +       for (i =3D 0; i < ib->length_dw ; i +=3D 2) {
> +               reg  =3D CP_PACKETJ_GET_REG(ib->ptr[i]);
> +               res  =3D CP_PACKETJ_GET_RES(ib->ptr[i]);
> +               cond =3D CP_PACKETJ_GET_COND(ib->ptr[i]);
> +               type =3D CP_PACKETJ_GET_TYPE(ib->ptr[i]);
> +
> +               if(res) /* only support 0 at the moment */
> +                       return -EINVAL;
> +
> +               switch (type) {
> +               case PACKETJ_TYPE0:
> +                       if (cond !=3D PACKETJ_CONDITION_CHECK0 || reg < J=
PEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
> +                               DRM_ERROR("Invalid packet [0x%08x]!\n", i=
b->ptr[i]);
> +                               return -EINVAL;
> +                       }
> +                       break;
> +               case PACKETJ_TYPE3:
> +                       if (cond !=3D PACKETJ_CONDITION_CHECK3 || reg < J=
PEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
> +                               DRM_ERROR("Invalid packet [0x%08x]!\n", i=
b->ptr[i]);
> +                               return -EINVAL;
> +                       }
> +                       break;
> +               case PACKETJ_TYPE6:
> +                       if (ib->ptr[i] =3D=3D CP_PACKETJ_NOP)
> +                               continue;
> +                       return -EINVAL;
> +               default:
> +                       DRM_ERROR("Unknown packet type %d !\n", type);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v4_0_3.h
> index 747a3e5f6856..71c54b294e15 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
> @@ -46,6 +46,9 @@
>
>  #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR                               0=
x18000
>
> +#define JPEG_REG_RANGE_START                                           0=
x4000
> +#define JPEG_REG_RANGE_END                                             0=
x41c2
> +
>  extern const struct amdgpu_ip_block_version jpeg_v4_0_3_ip_block;
>
>  void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
> @@ -62,5 +65,7 @@ void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring=
 *ring);
>  void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t r=
eg, uint32_t val);
>  void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32=
_t reg,
>                                         uint32_t val, uint32_t mask);
> -
> +int jpeg_v4_0_3_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
> +                                 struct amdgpu_job *job,
> +                                 struct amdgpu_ib *ib);
>  #endif /* __JPEG_V4_0_3_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_0.c
> index d694a276498a..f4daff90c770 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -646,6 +646,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec=
_ring_vm_funcs =3D {
>         .get_rptr =3D jpeg_v5_0_0_dec_ring_get_rptr,
>         .get_wptr =3D jpeg_v5_0_0_dec_ring_get_wptr,
>         .set_wptr =3D jpeg_v5_0_0_dec_ring_set_wptr,
> +       .parse_cs =3D jpeg_v4_0_3_dec_ring_parse_cs,
>         .emit_frame_size =3D
>                 SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
>                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/am=
dgpu/soc15d.h
> index 2357ff39323f..e74e1983da53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> @@ -76,6 +76,12 @@
>                          ((cond & 0xF) << 24) |                         \
>                          ((type & 0xF) << 28))
>
> +#define CP_PACKETJ_NOP         0x60000000
> +#define CP_PACKETJ_GET_REG(x)  ((x) & 0x3FFFF)
> +#define CP_PACKETJ_GET_RES(x)  (((x) >> 18) & 0x3F)
> +#define CP_PACKETJ_GET_COND(x) (((x) >> 24) & 0xF)
> +#define CP_PACKETJ_GET_TYPE(x) (((x) >> 28) & 0xF)
> +
>  /* Packet 3 types */
>  #define        PACKET3_NOP                                     0x10
>  #define        PACKET3_SET_BASE                                0x11
> --
> 2.34.1
>
