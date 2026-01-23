Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4518FD778B0
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 20:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5DE010E0BC;
	Fri, 23 Jan 2026 20:47:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DXwSaFwh";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5350510E0BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 20:47:28 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-124713e4244so78814c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 12:47:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769201248; cv=none;
 d=google.com; s=arc-20240605;
 b=jtUN5gMJkYw9TclUK6LaOZ47OcvapgXtY6Y/w0kFghEwiV8i9csVZ+7yQssbO/XBAN
 2Jty3N1GGFUMfyieLGumUv/Rx2f0sYwu1LlZ9S74memp5oJiGc7Uzs+edZBskGTCpAx6
 OAhHp0sOz09UZVL7Eb0WLYdldFnZE1I9PS47NuFRFxgodjdFOGnHwIFVUIO8XGY9TZvx
 GEoaQR0+9BmVD13wzeTeGn03IxKn7amOVYGD30e9d8aFxBCcf/jDiVqNv/+si/mrHAJw
 MaHxTILLlGqf7PYLWsl3kqZRsu/BD8WzR8tQ9uEEEhJz5NdjEcKCVKtPfto7mXT2QrDV
 M47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QdFtIV2BHKW+UzsdbLGJY5qCbiOtUmJsUC4AaZV+BEk=;
 fh=hY26Edfw5zSfQ7k5ViI2NrfnfaMcpj1z2TiRTG9Zwhg=;
 b=fIMb6+ctn+NJPKbEL+eIDi6M5djLK/EP3bNEBt+q1phaCOie/K5xTQ0ffQYwCb//3p
 3YP46NOGQ+hyjqYGegvhmNCyzULBbdv1UAPBSoR0yHOFUWXUDsoMYFLNm6lJ1BUV8EM6
 +u0elYh/YhW2aV45WMrgnYYTrzuEw3QwXnWe8EnCfSSrhzbCC1F+lfRoYEvixN5XXJlJ
 ezwqx3gq3n3HlkaE9l12OX8I2NFzh8DZMGMJ9Qq4URCpnRGVHM6hPaiu63w+yJcTo/17
 zjJRzEGevQXt5phvQHmXUKkjMPAGlv3b+KJC8Om+3cAO6Hkg9AAszJumQrHSRxkKsOCr
 ZM5g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769201248; x=1769806048; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QdFtIV2BHKW+UzsdbLGJY5qCbiOtUmJsUC4AaZV+BEk=;
 b=DXwSaFwhO1H4I1iliHM38aHKz/DcVcfqDYyoohvoiS2Oiyj3QE4+RC1CQmP8ww/KUr
 +xbpf1YTlPc3kSLIFCsefIKY9tQX65lLVsLU4Id7Cq5XS/fELuHlCqBurKISLUIefWWt
 LiRszNOSejdWFIazrUAVM8ufsc2jGskYA4gCeiZZBvjn7+gzcOIbbqcLYg/DUqcbQgy6
 slIBoHbANgRTvUx9X2IDFbp/dcodJsjL1So53t5PqaPuvD7vILediBAyhCAzrgZkTTSN
 SgiCmn6R48Q7E+VnXoEVz3iu5R4AqNna0uwG2VlWFT1v8EnPgI40T3YmEx2MlSIr6Wys
 fpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769201248; x=1769806048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QdFtIV2BHKW+UzsdbLGJY5qCbiOtUmJsUC4AaZV+BEk=;
 b=ppPjy5b3oWLLp0KSnKCw0tbXjTm5PCh8Umy3BKWUmd9noxzgs4XEIffmJXOtZVGFSo
 050No67O4HAq3ad+j8L8cEld6fEOrYxsA3z844y8WB1gr+shtlWYle6R4SCe1cqat+3/
 Ge8hg5l+AcjMVINM9/W/nH2UOVdJOdwVBTkYLUdly7ZONM2s7DvdV6Z0imNmboocQpMC
 Kj+rGb0r3tF35Pl+afO2AID9AisrSDClp6eaLpHB8S6XECtwGkWxnxAwx6+0A9D0jfh3
 7ucXshRqC9g6vqHF/pGA4x5KxPUEQ4KoxmS4j2jQhTMSUC4giLehNBhqUKYV6XWY8SjP
 1VZA==
X-Gm-Message-State: AOJu0YzAhw7EW4KT7ILwtJxSEOgXMZdea1frnfkHI3OmOa9w3sSErmKs
 NwsnPwwzipvTs0zpfTT6C7VFI2RVQ66Dm8fAzqXLEg89ZixdVP5FHbo3caOAK6sRXQdRav/gGk0
 Id/v1+x5SjQ8I61cOxCH20wVY0EQtMyRXHQ==
X-Gm-Gg: AZuq6aKXpiDvUk2RF/QQLon+FrH46muNDQTELtX53v2lTVOyER7mjBDBI4lQcUscsux
 dDaeFyLTyV7yeFrIKui6fa+3vCAi+GIs8mvxHd1Sc4Vzyca0iy0pKiCLjIDpBNp1zaZVV6apNQn
 y3nU39gV1iBdPBz/WS5vn4kp1/tR70J9Mr261WNH2rj7tDfBt92HimMn9xJRId+aCrGCb02k9YW
 tx2BlaXp2lTZP57/yMAIwdKCYJfDA/gUvEKMjTTToPpRMNK19OUkIt2qNjNZiVtz25qxMz3
X-Received: by 2002:a05:7022:6289:b0:11b:acd7:4e48 with SMTP id
 a92af1059eb24-12485625ec3mr239500c88.2.1769201247268; Fri, 23 Jan 2026
 12:47:27 -0800 (PST)
MIME-Version: 1.0
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
 <20260122104118.1682154-8-lijo.lazar@amd.com>
In-Reply-To: <20260122104118.1682154-8-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Jan 2026 15:47:16 -0500
X-Gm-Features: AZwV_QixO-R1vG7B5vFDRMtxKQsariaGbFKGoB9HSvJYNEM2XWAgVTy9vulzAEk
Message-ID: <CADnq5_PdRhNAV-JAWrHhYcQgPjpnX7-YQjsd4GX=owkFcPYn8A@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] drm/amdgpu: Add user save area params to mqd
 input
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com
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

On Thu, Jan 22, 2026 at 5:52=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Add user save area parameters to mqd properties for queue creation.
> Validate the parameters before using for mqd initialization.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 24 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  5 +++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 14 +++++++++++++
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 16 +++++++++++++++
>  5 files changed, 63 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 218d8030a07c..26b757c95579 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -814,6 +814,10 @@ struct amdgpu_mqd_prop {
>         uint64_t fence_address;
>         bool tmz_queue;
>         bool kernel_queue;
> +       /* cwsr params*/
> +       uint64_t ctx_save_area_addr;
> +       uint32_t ctx_save_area_size;
> +       uint32_t ctl_stack_size;
>  };
>
>  struct amdgpu_mqd {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 37a526a1085f..119b84a0703e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -33,6 +33,7 @@
>  #include "amdgpu_userq.h"
>  #include "amdgpu_hmm.h"
>  #include "amdgpu_userq_fence.h"
> +#include "amdgpu_cwsr.h"
>
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
> @@ -265,6 +266,29 @@ int amdgpu_userq_input_va_validate(struct amdgpu_dev=
ice *adev,
>         return r;
>  }
>
> +int amdgpu_userq_input_cwsr_params_validate(
> +       struct amdgpu_usermode_queue *queue,
> +       struct amdgpu_cwsr_params *cwsr_params)
> +{
> +       struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(queue->userq_mgr);
> +       struct amdgpu_device *adev =3D queue->userq_mgr->adev;
> +       uint32_t cwsr_size;
> +       int num_xcc;
> +       int r;
> +
> +       num_xcc =3D amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
> +       r =3D amdgpu_cwsr_validate_params(queue->userq_mgr->adev, cwsr_pa=
rams,
> +                                       num_xcc);
> +       if (r)
> +               return r;
> +       cwsr_size =3D amdgpu_cwsr_size_needed(queue->userq_mgr->adev, num=
_xcc);
> +       if (!cwsr_size)
> +               return -EOPNOTSUPP;
> +
> +       return amdgpu_userq_input_va_validate(
> +               adev, queue, cwsr_params->ctx_save_area_address, cwsr_siz=
e);
> +}
> +
>  static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr=
)
>  {
>         struct amdgpu_bo_va_mapping *mapping;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 5845d8959034..a64292bc24dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -41,6 +41,7 @@ enum amdgpu_userq_state {
>  };
>
>  struct amdgpu_mqd_prop;
> +struct amdgpu_cwsr_params;
>
>  struct amdgpu_userq_obj {
>         void             *cpu_ptr;
> @@ -157,4 +158,8 @@ int amdgpu_userq_input_va_validate(struct amdgpu_devi=
ce *adev,
>  int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>                                        struct amdgpu_bo_va_mapping *mappi=
ng,
>                                        uint64_t saddr);
> +int amdgpu_userq_input_cwsr_params_validate(
> +       struct amdgpu_usermode_queue *queue,
> +       struct amdgpu_cwsr_params *cwsr_params);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 40660b05f979..5f6a6f630495 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3243,6 +3243,20 @@ static int gfx_v12_0_compute_mqd_init(struct amdgp=
u_device *adev, void *m,
>         mqd->fence_address_lo =3D lower_32_bits(prop->fence_address);
>         mqd->fence_address_hi =3D upper_32_bits(prop->fence_address);
>
> +       /* If non-zero, assume cwsr is enabled */
> +       if (prop->ctx_save_area_addr) {
> +               mqd->cp_hqd_persistent_state |=3D
> +                       (1 << CP_HQD_PERSISTENT_STATE__QSWITCH_MODE__SHIF=
T);
> +               mqd->cp_hqd_ctx_save_base_addr_lo =3D
> +                       lower_32_bits(prop->ctx_save_area_addr);
> +               mqd->cp_hqd_ctx_save_base_addr_hi =3D
> +                       upper_32_bits(prop->ctx_save_area_addr);
> +               mqd->cp_hqd_ctx_save_size =3D prop->ctx_save_area_size;
> +               mqd->cp_hqd_cntl_stack_size =3D prop->ctl_stack_size;
> +               mqd->cp_hqd_cntl_stack_offset =3D prop->ctl_stack_size;
> +               mqd->cp_hqd_wg_state_offset =3D prop->ctl_stack_size;
> +       }
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 27917614b1a8..7ad8297eb0d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -314,6 +314,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermod=
e_queue *queue,
>
>         if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
>                 struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
> +               struct amdgpu_cwsr_params cwsr_params;
>
>                 if (mqd_user->mqd_size !=3D sizeof(*compute_mqd)) {
>                         DRM_ERROR("Invalid compute IP MQD size\n");
> @@ -339,6 +340,21 @@ static int mes_userq_mqd_create(struct amdgpu_usermo=
de_queue *queue,
>                 userq_props->hqd_active =3D false;
>                 userq_props->tmz_queue =3D
>                         mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE=
_SECURE;
> +
> +               if (amdgpu_cwsr_is_enabled(adev)) {
> +                       cwsr_params.ctx_save_area_address =3D
> +                               userq_props->ctx_save_area_addr;
> +                       cwsr_params.cwsr_sz =3D userq_props->ctx_save_are=
a_size;
> +                       cwsr_params.ctl_stack_sz =3D userq_props->ctl_sta=
ck_size;
> +
> +                       r =3D amdgpu_userq_input_cwsr_params_validate(
> +                               queue, &cwsr_params);
> +                       if (r) {
> +                               kfree(compute_mqd);
> +                               goto free_mqd;
> +                       }
> +               }
> +
>                 kfree(compute_mqd);
>         } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) {
>                 struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
> --
> 2.49.0
>
