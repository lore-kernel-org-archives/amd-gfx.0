Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18031C52D71
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 17:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B71FE10E3D0;
	Tue,  6 Aug 2024 17:08:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FtQhsORR";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F9BC10E3D0
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 17:08:14 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-1fd6ed7688cso10231165ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Aug 2024 10:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722964093; x=1723568893; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypev+JLpngqdQC+9wat8siRQJJdZ7CezmniUzM7fATg=;
 b=FtQhsORRP4qzn8Jg8FHPYJfyzztLuV6YlTTzLlqIMh7AUXYcptJxF/roCm3F+xgnDy
 /yZ8MkvcuTW26Cj0zZvnj2mmBdxvVMTGaw92YxTX0niM6UgJVC+G3wSHjFtMK89v9k9K
 fI5bzLi5Xq+pX3sVf64FD/wA8aIIXsOPEhpRqUjblrHFPjpIlGos6Q4fPnsQomiJ6Oqh
 qYjOwBhcuCvnNJfZzPP44q71zJ4N0xGRXmJuOb24LChhm66kVKVQOLQetUBItDBkV6Uz
 E4fwVCFjE9BmXG/c6bA1RC9cNCMFtler9CasauTwwEeSgIGN3PovLmA7/GtcewZLd7Hw
 UTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722964093; x=1723568893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ypev+JLpngqdQC+9wat8siRQJJdZ7CezmniUzM7fATg=;
 b=msXZW6s67opUwSf8CRy55R1hy4mtsESxv+b+f/1/2yL+vCrE4xzukiRp/2se6fLc6Y
 dZQJXJHnsZSJMpcDPB6KVDzE8i7hOzM3qkYgovQFjxGEOQgNWEPBXaZmJWi7ChjQd+28
 3xLvEfnNDZCEEs7GMFseqoB3EIAFARajPrUCuskyfQ/hH5AKD1pvwByapkA8eKNj+9g1
 8Pc5ga57ggi9p26mZMpN9D7XmJmxVwj/sL92wPZ0L7qLXB0UdWjNano//hb15XmEdtQs
 L7MvbU3tVzQpNa5Sef+6Z9EXd4zSqSnjMxCMAS8T5kLwqmlxfbx3ayD4U3wCNVB54rvm
 GLNw==
X-Gm-Message-State: AOJu0YwLrJqLo2drVP3IMa9nSmTJBuVqgNlpeDka/yXvGMM+ruK+Im8m
 C5mcDib+QG/1Jz2TrhCXKikdS4wZrpwvbo36aL4Uy3hVq0ctL0sRtakkZL0PF0/Q9OuRarutRtE
 HhBC3skLSyCz8Z+i61f8pYdRo5Dc=
X-Google-Smtp-Source: AGHT+IHe3sE9eVlyeEv8/BPnK1j3upyVq6PLjF77jFJAHzAwB7IlrV6D6LwcLMOwqWwqKQ8lgNX4egnj7C+d5ZgAVx4=
X-Received: by 2002:a17:902:d4c3:b0:1fd:9b96:32d4 with SMTP id
 d9443c01a7336-1ff57459864mr170122015ad.51.1722964093490; Tue, 06 Aug 2024
 10:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240806160012.234633-1-David.Wu3@amd.com>
In-Reply-To: <20240806160012.234633-1-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 Aug 2024 13:08:01 -0400
Message-ID: <CADnq5_Ov6hnKmKXRe00JEgdWLyphEbMHDghHuN+UNRoq70CFQA@mail.gmail.com>
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

This part doesn't make sense to me.  If we use vmid 0, we'll need to
also patch any addresses in the IB itself to use vmid 0 as well unless
there is a way to use a vmid 0 address for the IB base, but a
different vmid for the addresses in the IB.  If it's the latter, then
we need to make sure that is set up and specify the vmid to use.

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

space between if and (.

> +                       return -EINVAL;
> +
> +               switch (type) {
> +               case PACKETJ_TYPE0:
> +                       if (cond !=3D PACKETJ_CONDITION_CHECK0 || reg < J=
PEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
> +                               DRM_ERROR("Invalid packet [0x%08x]!\n", i=
b->ptr[i]);

use dev_err() so we can differentiate between multiple GPUs.

> +                               return -EINVAL;
> +                       }
> +                       break;
> +               case PACKETJ_TYPE3:
> +                       if (cond !=3D PACKETJ_CONDITION_CHECK3 || reg < J=
PEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
> +                               DRM_ERROR("Invalid packet [0x%08x]!\n", i=
b->ptr[i]);

Same here.

> +                               return -EINVAL;
> +                       }
> +                       break;
> +               case PACKETJ_TYPE6:
> +                       if (ib->ptr[i] =3D=3D CP_PACKETJ_NOP)
> +                               continue;
> +                       return -EINVAL;
> +               default:
> +                       DRM_ERROR("Unknown packet type %d !\n", type);

And here.

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
