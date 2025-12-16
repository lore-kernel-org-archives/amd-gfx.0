Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAD4D609C2
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 16:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A888910E879;
	Tue, 16 Dec 2025 16:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mvf5Qdgw";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5701C10E875
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 16:41:02 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-7ba92341f07so347084b3a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 08:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765903262; x=1766508062; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYxDnKUc2qWaioRhZMbKV4wvikVga61M/Vfs5K5jum0=;
 b=Mvf5Qdgwm9ks583YRgPJ5ygOMewkYHHZSmF4mYsTJYLW2BPZBq84SB4MlfJanyHBL5
 aP6waF2xlIdAO7uML5P31uerP7dRFpu46hJ7FUc3S7u9dEjm6eSrfBxJ7VgTSp37vIM3
 nt8QSYU/+9uVvtbLehOu9AKu3o/4t60Pt0ZPxIPERfBBR6zEEH7Vmgv1Nh3v0LtdXwsG
 FI8jmzRICA/RuElltL9eDd6FL2GxU4umQGUzthiqgImeTnDwrZHpNoDX4xdwkO70wpb9
 bL38spSMxQL9xGKVAnv0JmwY4WBwbj/l9jXFCi67wTI0qDeoQbKQ4OIEvGxurK/4XT4j
 dC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765903262; x=1766508062;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OYxDnKUc2qWaioRhZMbKV4wvikVga61M/Vfs5K5jum0=;
 b=C7SY2rCwunWlJ6oU/sUQZdRXAd7pU1VFAqA6t/uWLWUsaWms3y5wzkoNMexMjkkytT
 I7Kz3fWNvdKMSI3/NYdZKSTv26117dkT06b6IRVMZbdK6sMu7TjGrefxvJVXxL/rIUUT
 WS14jrUTugxxWMGPToePpLKCtfabsUyaBLJsbdRpGLWnYGy1c/EilZd9rQ66LuQ4Mz7w
 K2YLR1KOwomAhB8gawdvi8uUZNuiEbN21iij0c8CKiJnJ23aUFLQdGUDlDfF7ukE/h2M
 ahEV18fTKRBVZs6e93EsqvIfcIZ94zEktp8552ukOtSCRZMT8tMDx8Z3/GCcuzW+ib4j
 8jjQ==
X-Gm-Message-State: AOJu0Yyrck38i/jOrsvCf/5v2SQVE+NfYptIc6cDT1OGfLp/FlYbU8p4
 shZUgldUB8dCmuRuHrh/wTIQ+Sg0LnQ92OEtFAe41UvKVtMLGKThJdJmtheY0UGbe1qWRkga7jF
 0t/f/Y6gYUszNIcTdyTaSZL3uF+MGcbA=
X-Gm-Gg: AY/fxX7JZh9dzD1x9VYJqcq/GC7LdkmStLuN7LE5NI2/GuWZe3EgQkUQCbD+QTheqLN
 6vkUpOW5sIlnV4hBxrE7VH7ThivZw6LZnzxopvxVXBFNA5k21koXuMjTIIVqpIpKYw1AJIisG82
 kdDPtlsiZ8eLZmd6d8aoeaswGtK7mcdy2N8ipe18XV5/0YzmoCWLMMwUoTPhbBejUG+65i+ZxXM
 tCsgWftArfMcwERwCmGCrsFviCIZY0gTB+6rbMl0M+pTYWa4I/Us0EwgRkvzJbPDH9dS3vB
X-Google-Smtp-Source: AGHT+IGpfm9aGpHrZy/GdwWB0fPE1A9Pn7+efPDcNu2kysmZAa5pEJqow1kLFE8FZDmQ6+Md0R88y27dU/iEIUpKPZk=
X-Received: by 2002:a05:7022:6390:b0:119:e55a:95a1 with SMTP id
 a92af1059eb24-11f34c47486mr6205027c88.3.1765903261590; Tue, 16 Dec 2025
 08:41:01 -0800 (PST)
MIME-Version: 1.0
References: <20251203130436.745633-1-lijo.lazar@amd.com>
 <20251203130436.745633-4-lijo.lazar@amd.com>
In-Reply-To: <20251203130436.745633-4-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 11:40:47 -0500
X-Gm-Features: AQt7F2oBsZfLYoW2pwdP5FBIQ0NTLHNric-hNO1mqc7Vrnc2sxa1POOMyyCTirY
Message-ID: <CADnq5_Mq86MucvBCGZp5RMbnSBQ+BwerfGHh_9WATd-XN=88=A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 03/10] drm/amdgpu: Fill cwsr save area details
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

On Wed, Dec 3, 2025 at 8:14=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Calculate control stack and total save area size required.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 103 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |   4 +
>  2 files changed, 107 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cwsr.c
> index c0fc5a383071..4252c31eac4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> @@ -32,6 +32,13 @@ extern int cwsr_enable;
>  #define AMDGPU_CWSR_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
>  #define AMDGPU_CWSR_TMA_OFFSET (AMDGPU_CWSR_TBA_MAX_SIZE)
>
> +#define SGPR_SIZE_PER_CU 0x4000
> +#define LDS_SIZE_PER_CU 0x10000
> +#define HWREG_SIZE_PER_CU 0x1000
> +#define DEBUGGER_BYTES_ALIGN 64
> +#define DEBUGGER_BYTES_PER_WAVE 32
> +#define SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER 40
> +
>  enum amdgpu_cwsr_region {
>         AMDGPU_CWSR_TBA,
>         AMDGPU_CWSR_TMA,
> @@ -115,6 +122,100 @@ static void amdgpu_cwsr_init_isa_details(struct amd=
gpu_device *adev,
>         }
>  }
>
> +static uint32_t amdgpu_cwsr_get_vgpr_size_per_cu(struct amdgpu_device *a=
dev)
> +{
> +       uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
> +       uint32_t vgpr_size;
> +
> +       switch (gc_ver) {
> +       case IP_VERSION(9, 4, 1): /* GFX_VERSION_ARCTURUS */
> +       case IP_VERSION(9, 4, 2): /* GFX_VERSION_ALDEBARAN */
> +       case IP_VERSION(9, 4, 3): /* GFX_VERSION_AQUA_VANJARAM */
> +       case IP_VERSION(9, 4, 4): /* GFX_VERSION_AQUA_VANJARAM */
> +       case IP_VERSION(9, 5, 0):
> +               vgpr_size =3D 0x80000;
> +               break;
> +       case IP_VERSION(11, 0, 0):
> +       case IP_VERSION(11, 0, 2):
> +       case IP_VERSION(11, 0, 3):
> +       case IP_VERSION(12, 0, 0):
> +       case IP_VERSION(12, 0, 1):
> +               vgpr_size =3D 0x60000;
> +               break;
> +       default:
> +               vgpr_size =3D 0x40000;
> +               break;
> +       }
> +
> +       return vgpr_size;
> +}
> +
> +static uint32_t amdgpu_cwsr_get_wg_ctxt_size_per_cu(struct amdgpu_device=
 *adev)
> +{
> +       uint32_t lds_sz_per_cu;
> +
> +       lds_sz_per_cu =3D
> +               (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9,=
 5, 0)) ?
> +                       (adev->gfx.cu_info.lds_size << 10) :
> +                       LDS_SIZE_PER_CU;
> +
> +       return amdgpu_cwsr_get_vgpr_size_per_cu(adev) + SGPR_SIZE_PER_CU =
+
> +              lds_sz_per_cu + HWREG_SIZE_PER_CU;
> +}
> +
> +static uint32_t amdgpu_cwsr_ctl_stack_bytes_per_wave(struct amdgpu_devic=
e *adev)
> +{
> +       uint32_t sz;

new line here.  Other than that:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> +       if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(10, 1, 0)=
)
> +               sz =3D 12;
> +       else
> +               sz =3D 8;
> +       return sz;
> +}
> +
> +static void amdgpu_cwsr_init_save_area_info(struct amdgpu_device *adev,
> +                                           struct amdgpu_cwsr_info *cwsr=
_info)
> +{
> +       struct amdgpu_gfx_config *gfx_info =3D &adev->gfx.config;
> +       uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
> +       uint32_t ctl_stack_size, wg_data_size, dbg_mem_size;
> +       uint32_t array_count;
> +       uint32_t wave_num;
> +       uint32_t cu_num;
> +
> +       if (gc_ver < IP_VERSION(9, 0, 1))
> +               return;
> +
> +       array_count =3D gfx_info->max_shader_engines * gfx_info->max_sh_p=
er_se;
> +
> +       cu_num =3D adev->gfx.cu_info.number / NUM_XCC(adev->gfx.xcc_mask)=
;
> +       wave_num =3D (gc_ver < IP_VERSION(10, 1, 0)) ? /* GFX_VERSION_NAV=
I10 */
> +                          min(cu_num * 40,
> +                              array_count / gfx_info->max_sh_per_se * 51=
2) :
> +                          cu_num * 32;
> +
> +       wg_data_size =3D ALIGN(cu_num * amdgpu_cwsr_get_wg_ctxt_size_per_=
cu(adev),
> +                            PAGE_SIZE);
> +       ctl_stack_size =3D
> +               wave_num * amdgpu_cwsr_ctl_stack_bytes_per_wave(adev) + 8=
;
> +       ctl_stack_size =3D
> +               ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stac=
k_size,
> +                     PAGE_SIZE);
> +       dbg_mem_size =3D
> +               ALIGN(wave_num * DEBUGGER_BYTES_PER_WAVE, DEBUGGER_BYTES_=
ALIGN);
> +       /*
> +       * HW design limits control stack size to 0x7000.
> +       * This is insufficient for theoretical PM4 cases
> +       * but sufficient for AQL, limited by SPI events.
> +       */
> +       if (IP_VERSION_MAJ(gc_ver) =3D=3D 10)
> +               ctl_stack_size =3D min(ctl_stack_size, 0x7000);
> +
> +       cwsr_info->xcc_ctl_stack_sz =3D ctl_stack_size;
> +       cwsr_info->xcc_cwsr_sz =3D ctl_stack_size + wg_data_size;
> +       cwsr_info->xcc_dbg_mem_sz =3D dbg_mem_size;
> +}
> +
>  int amdgpu_cwsr_init(struct amdgpu_device *adev)
>  {
>         struct amdgpu_cwsr_info *cwsr_info __free(kfree) =3D NULL;
> @@ -139,6 +240,8 @@ int amdgpu_cwsr_init(struct amdgpu_device *adev)
>                 return r;
>
>         memcpy(ptr, cwsr_info->isa_buf, cwsr_info->isa_sz);
> +
> +       amdgpu_cwsr_init_save_area_info(adev, cwsr_info);
>         adev->cwsr_info =3D no_free_ptr(cwsr_info);
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cwsr.h
> index 26ed9308f70b..3c80d057bbed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> @@ -50,6 +50,10 @@ struct amdgpu_cwsr_info {
>         struct amdgpu_bo *isa_bo;
>         const void *isa_buf;
>         uint32_t isa_sz;
> +       /* cwsr size info per XCC*/
> +       uint32_t xcc_ctl_stack_sz;
> +       uint32_t xcc_dbg_mem_sz;
> +       uint32_t xcc_cwsr_sz;
>  };
>
>  int amdgpu_cwsr_init(struct amdgpu_device *adev);
> --
> 2.49.0
>
