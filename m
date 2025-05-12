Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8210C3ABC3
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 14:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DA3610E1A3;
	Mon, 12 May 2025 14:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aAN2Y18C";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5854C10E1A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 14:41:45 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-22e53c8b816so5152845ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747060905; x=1747665705; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYGEiD1Frxc+PmDuLLOq5gJweJKAqKeZcqbKbfoaXK4=;
 b=aAN2Y18CVjZQATWMkz+RoXrHM8IJsIP30KWGhWrVq/jdrYCaYWy8xI4AqnTVhopIQY
 FT+riEkaOIdG976uGnKp4nccOkXdWbclbR8rQu05VAeom67MhJEUox2pvWroH4SESKrh
 lRkcsOuF1ka9XfYtZXOZiqAARJKx4BgB/1YTqpYMS7Nc44EYuU7ygDzBiTQcN2Qz6I5Y
 C278AnTBaAYIm4ENFlelYnhEctJscSO8o4UM0tIjAJWyMQ3SoKXKndpTOySsO5ladV8h
 K7MX0BGME8eE4eCzaSIu0kuY2ssTn+4iCrnSQISg7uXQvchcF+kGfTVrWjmYWg8KEW+T
 X0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747060905; x=1747665705;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYGEiD1Frxc+PmDuLLOq5gJweJKAqKeZcqbKbfoaXK4=;
 b=N2Jx0B8QXFzF6rsJlRcaG37LrBCEM2TzHTBXYq9XODKXBVGz2EHu12aSP+Gl2aWVYz
 4cB1i12DfYyy3UDn5a2XKTTfNWvfUXFx+hOSD7zalO22spwBycHqBbWyvH6dG9qxDFiZ
 1iwcR3OmhAOrodhRHMEsf2SdKHBIw0nyDqoRWp18TpA24HUUhbLu751Ir6OPTyebcqe4
 +MLfVBQZcKoVFQPkE5MG0BY1Cw6ALeJWpPqjoBFxdMLsVnkcEb6n2taT3oBaHj51PY61
 CtE25wBB/oZPbS6eyHin9EyoNHhEQswrTRr63z4Fqh2zcNHQ1NNQmMcsknVo5esbo38V
 MM+A==
X-Gm-Message-State: AOJu0YyULDrhe9CoVUIgjdGt8M9Ee9uKq8xmCm5HqU7i+leWbAonCs/7
 KDWpBTqELtrkd2qAwTszxx9OE3K5b3pGRfChk29o6SQIC8OeKz7E2rgSmKumwq11XvzWQ6u1EqP
 BSWi7D0eB49y20wrN4XgWqz3zACk=
X-Gm-Gg: ASbGnctCrwKvc7Jn29Wk//3VLxnQeso+Pz6KmFaqGoOFpBbm+1o/BI0prRG6S/lC1ZG
 fxDaipLFFzPNBCPEpvkltRUcpdl6yZ8/YEKGBPzl4+JhNXFZZXEoIcRXshG4YndW0XkJi71Gmof
 ve4wE+MNr6iCGEP7O2Wee6Ep9iTsj3Fhwi
X-Google-Smtp-Source: AGHT+IGpU/lBFakzhiOA77CK+tIXtgeMsmAR3k6AHyUg4E4BQ7YaY/L7zJ4SoR3qmfOgrtzj7/Rj8l2PNjWwTSmmPCo=
X-Received: by 2002:a17:902:e94d:b0:22e:6ea8:8a07 with SMTP id
 d9443c01a7336-22fc9087803mr68115535ad.9.1747060904675; Mon, 12 May 2025
 07:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250512034403.381441-1-FangSheng.Huang@amd.com>
 <20250512034403.381441-4-FangSheng.Huang@amd.com>
In-Reply-To: <20250512034403.381441-4-FangSheng.Huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 12 May 2025 10:41:33 -0400
X-Gm-Features: AX0GCFsJlNsnjZ2ItlN0_4Clec3TQrq_z5hPwgV9oSENgsiOMykeg0UWtAKxP5s
Message-ID: <CADnq5_MocuPFqC_1+BeyNwRe4oV70DV8OZCiaRkc3OgRSnEN=Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/jpeg: sriov support for jpeg_v5_0_1
To: fanhuang <FangSheng.Huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Ahmad.Rehman@amd.com, Vignesh.Chander@amd.com
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

On Sun, May 11, 2025 at 11:44=E2=80=AFPM fanhuang <FangSheng.Huang@amd.com>=
 wrote:
>
> initialization table handshake with mmsch
>
> Signed-off-by: fanhuang <FangSheng.Huang@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 142 +++++++++++++++++++++--
>  1 file changed, 131 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_1.c
> index 6f73033d78b5..cb94bd71300f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -28,11 +28,13 @@
>  #include "soc15d.h"
>  #include "jpeg_v4_0_3.h"
>  #include "jpeg_v5_0_1.h"
> +#include "mmsch_v5_0.h"
>
>  #include "vcn/vcn_5_0_0_offset.h"
>  #include "vcn/vcn_5_0_0_sh_mask.h"
>  #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
>
> +static int jpeg_v5_0_1_start_sriov(struct amdgpu_device *adev);
>  static void jpeg_v5_0_1_set_dec_ring_funcs(struct amdgpu_device *adev);
>  static void jpeg_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
>  static int jpeg_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_=
block,
> @@ -163,14 +165,9 @@ static int jpeg_v5_0_1_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                                         (adev->doorbell_index.vcn.vcn_rin=
g0_1 << 1) +
>                                         1 + j + 11 * jpeg_inst;
>                         } else {
> -                               if (j < 4)
> -                                       ring->doorbell_index =3D
> -                                               (adev->doorbell_index.vcn=
.vcn_ring0_1 << 1) +
> -                                               4 + j + 32 * jpeg_inst;
> -                               else
> -                                       ring->doorbell_index =3D
> -                                               (adev->doorbell_index.vcn=
.vcn_ring0_1 << 1) +
> -                                               8 + j + 32 * jpeg_inst;
> +                               ring->doorbell_index =3D
> +                                       (adev->doorbell_index.vcn.vcn_rin=
g0_1 << 1) +
> +                                       2 + j + 32 * jpeg_inst;
>                         }
>                         sprintf(ring->name, "jpeg_dec_%d.%d", adev->jpeg.=
inst[i].aid_id, j);
>                         r =3D amdgpu_ring_init(adev, ring, 512, &adev->jp=
eg.inst->irq, 0,
> @@ -237,7 +234,10 @@ static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>         int i, j, r, jpeg_inst;
>
>         if (amdgpu_sriov_vf(adev)) {
> -               /* jpeg_v5_0_1_start_sriov(adev); */
> +               r =3D jpeg_v5_0_1_start_sriov(adev);
> +               if (r)
> +                       return r;
> +
>                 for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>                         for (j =3D 0; j < adev->jpeg.num_jpeg_rings; ++j)=
 {
>                                 ring =3D &adev->jpeg.inst[i].ring_dec[j];
> @@ -291,8 +291,10 @@ static int jpeg_v5_0_1_hw_fini(struct amdgpu_ip_bloc=
k *ip_block)
>
>         cancel_delayed_work_sync(&adev->jpeg.idle_work);
>
> -       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE)
> -               ret =3D jpeg_v5_0_1_set_powergating_state(ip_block, AMD_P=
G_STATE_GATE);
> +       if (!amdgpu_sriov_vf(adev)) {
> +               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE)
> +                       ret =3D jpeg_v5_0_1_set_powergating_state(ip_bloc=
k, AMD_PG_STATE_GATE);
> +       }
>
>         return ret;
>  }
> @@ -422,6 +424,119 @@ static void jpeg_v5_0_1_init_jrbc(struct amdgpu_rin=
g *ring)
>                                          reg_offset);
>  }
>
> +static int jpeg_v5_0_1_start_sriov(struct amdgpu_device *adev)
> +{
> +       struct amdgpu_ring *ring;
> +       uint64_t ctx_addr;
> +       uint32_t param, resp, expected;
> +       uint32_t tmp, timeout;
> +
> +       struct amdgpu_mm_table *table =3D &adev->virt.mm_table;
> +       uint32_t *table_loc;
> +       uint32_t table_size;
> +       uint32_t size, size_dw, item_offset;
> +       uint32_t init_status;
> +       int i, j, jpeg_inst;
> +
> +       struct mmsch_v5_0_cmd_direct_write
> +               direct_wt =3D { {0} };
> +       struct mmsch_v5_0_cmd_end end =3D { {0} };
> +       struct mmsch_v5_0_init_header header;
> +
> +       direct_wt.cmd_header.command_type =3D
> +               MMSCH_COMMAND__DIRECT_REG_WRITE;
> +       end.cmd_header.command_type =3D
> +               MMSCH_COMMAND__END;
> +
> +       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; i++) {
> +               jpeg_inst =3D GET_INST(JPEG, i);
> +
> +               memset(&header, 0, sizeof(struct mmsch_v5_0_init_header))=
;
> +               header.version =3D MMSCH_VERSION;
> +               header.total_size =3D sizeof(struct mmsch_v5_0_init_heade=
r) >> 2;
> +
> +               table_loc =3D (uint32_t *)table->cpu_addr;
> +               table_loc +=3D header.total_size;
> +
> +               item_offset =3D header.total_size;
> +
> +               for (j =3D 0; j < adev->jpeg.num_jpeg_rings; j++) {
> +                       ring =3D &adev->jpeg.inst[i].ring_dec[j];
> +                       table_size =3D 0;
> +
> +                       tmp =3D SOC15_REG_OFFSET(JPEG, 0, regUVD_LMI_JRBC=
_RB_64BIT_BAR_LOW);
> +                       MMSCH_V5_0_INSERT_DIRECT_WT(tmp, lower_32_bits(ri=
ng->gpu_addr));
> +                       tmp =3D SOC15_REG_OFFSET(JPEG, 0, regUVD_LMI_JRBC=
_RB_64BIT_BAR_HIGH);
> +                       MMSCH_V5_0_INSERT_DIRECT_WT(tmp, upper_32_bits(ri=
ng->gpu_addr));
> +                       tmp =3D SOC15_REG_OFFSET(JPEG, 0, regUVD_JRBC_RB_=
SIZE);
> +                       MMSCH_V5_0_INSERT_DIRECT_WT(tmp, ring->ring_size =
/ 4);
> +
> +                       if (j < 5) {
> +                               header.mjpegdec0[j].table_offset =3D item=
_offset;
> +                               header.mjpegdec0[j].init_status =3D 0;
> +                               header.mjpegdec0[j].table_size =3D table_=
size;
> +                       } else {
> +                               header.mjpegdec1[j - 5].table_offset =3D =
item_offset;
> +                               header.mjpegdec1[j - 5].init_status =3D 0=
;
> +                               header.mjpegdec1[j - 5].table_size =3D ta=
ble_size;
> +                       }
> +                       header.total_size +=3D table_size;
> +                       item_offset +=3D table_size;
> +               }
> +
> +               MMSCH_V5_0_INSERT_END();
> +
> +               /* send init table to MMSCH */
> +               size =3D sizeof(struct mmsch_v5_0_init_header);
> +               table_loc =3D (uint32_t *)table->cpu_addr;
> +               memcpy((void *)table_loc, &header, size);
> +
> +               ctx_addr =3D table->gpu_addr;
> +               WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_CTX_ADDR_LO, low=
er_32_bits(ctx_addr));
> +               WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_CTX_ADDR_HI, upp=
er_32_bits(ctx_addr));
> +
> +               tmp =3D RREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_VMID);
> +               tmp &=3D ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
> +               tmp |=3D (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
> +               WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_VMID, tmp);
> +
> +               size =3D header.total_size;
> +               WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_CTX_SIZE, size);
> +
> +               WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_MAILBOX_RESP, 0)=
;
> +
> +               param =3D 0x00000001;
> +               WREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF_MAILBOX_HOST, pa=
ram);
> +               tmp =3D 0;
> +               timeout =3D 1000;
> +               resp =3D 0;
> +               expected =3D MMSCH_VF_MAILBOX_RESP__OK;
> +               init_status =3D
> +                       ((struct mmsch_v5_0_init_header *)(table_loc))->m=
jpegdec0[i].init_status;
> +               while (resp !=3D expected) {
> +                       resp =3D RREG32_SOC15(VCN, jpeg_inst, regMMSCH_VF=
_MAILBOX_RESP);
> +
> +                       if (resp !=3D 0)
> +                               break;
> +                       udelay(10);
> +                       tmp =3D tmp + 10;
> +                       if (tmp >=3D timeout) {
> +                               DRM_ERROR("failed to init MMSCH. TIME-OUT=
 after %d usec"\
> +                                       " waiting for regMMSCH_VF_MAILBOX=
_RESP "\
> +                                       "(expected=3D0x%08x, readback=3D0=
x%08x)\n",
> +                                       tmp, expected, resp);
> +                               return -EBUSY;
> +                       }
> +               }
> +               if (resp !=3D expected && resp !=3D MMSCH_VF_MAILBOX_RESP=
__INCOMPLETE &&
> +                               init_status !=3D MMSCH_VF_ENGINE_STATUS__=
PASS)
> +                       DRM_ERROR("MMSCH init status is incorrect! readba=
ck=3D0x%08x, header init status for jpeg: %x\n",
> +                                       resp, init_status);
> +
> +       }
> +       return 0;
> +}
> +
>  /**
>   * jpeg_v5_0_1_start - start JPEG block
>   *
> @@ -581,6 +696,11 @@ static int jpeg_v5_0_1_set_powergating_state(struct =
amdgpu_ip_block *ip_block,
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int ret;
>
> +       if (amdgpu_sriov_vf(adev)) {
> +               adev->jpeg.cur_state =3D AMD_PG_STATE_UNGATE;
> +               return 0;
> +       }
> +
>         if (state =3D=3D adev->jpeg.cur_state)
>                 return 0;
>
> --
> 2.34.1
>
