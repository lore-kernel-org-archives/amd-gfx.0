Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA85C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 04:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BFA510E48F;
	Fri, 31 May 2024 04:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S2xqAL6Y";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07CAA10E48F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 04:04:57 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2c1a4192d55so1193826a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 21:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717128297; x=1717733097; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a1vrnaFpVoHESBs7pudgdOKXtJcP06P2q0pXuuhaqWU=;
 b=S2xqAL6YofcDatVmNBK8T2xMbvn9usHaIFikep8rrKrOBleTVL3CSsqHrOaOfV8vKH
 oJKPKpAZfhQ/vFFVNUfY/uu+ftBSXnRPtHBmtuk/SC/pzk818xUBb3Cvi73hoo5+/myh
 a2g+MSzxFw3RN/N34Qa87d2YbjtbDji0HxUxpCEGfTFsM0eHNznXj8JliLUjtGgkiUMQ
 D6eiIJml+g+1M4hCWRw1kxq+517yQNouT85Wgsc5UJxCpN86/qzvimypdPXuuTO/SIQh
 nI4qhElqZB7xRMCoUnxnKGIOytHYFZDmCT3LaWLqSeiQm1vNbb4ZnXTALSzjuV0z0Wh5
 XVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717128297; x=1717733097;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a1vrnaFpVoHESBs7pudgdOKXtJcP06P2q0pXuuhaqWU=;
 b=KxZ61m59c6fEgRL1O5PgENzZDfMinWtEYcrcw4Cf+tNj7gEb2ITGtyICsk5dyKVAAP
 VFI5XbY2VNSYo9OVrohWD4IPfL5KbyjRVqzpO/2xmfNW2paHeWXrzElUzEzZcJVl843A
 Ou01c1DtiV8aUVIVibiqiSrSRr2B9lhtGPfN/aKBI3Tg+MZgKx9DnnErTT5tKQ9G+wU+
 K7lBMlRpVXBhfNKHFt9+oJVOuGVeX5XLOtqvwyVyYlO+TVmxd1/CyDZd36dx7JRReLg5
 JuHCAFBiYMg0Hn2ZBfrXkO6B1c4fnyR8eqMzlvSmN5VHmCfhKg/+tCIeWRv22ETJr3Or
 zEUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSzDDvyQAGIaeE5D2z8g2Q+xL9APXhLGLEuHpRrh65PQ0T587L/8VLbGZa+PtT+RG0+jS0gH1JrSm5Im6YT+jexuRvLEJqLFSFABzFwg==
X-Gm-Message-State: AOJu0YyFXsgbPU7j3eOP5r/q7cX8hDl2aj7XNUpKnoiLdVcSXs6qcKte
 wt9VuSWyDF8An/U8iTWei0VQBSfh2jtW5RBJgx5Iz9jwPBSXbTuwkMJnCDI/Q3C9D7+Mha+GpYC
 YChJ2A4Mcg8RxfM624Yu+kzGSkbWgzMII
X-Google-Smtp-Source: AGHT+IEBCev/gwSjB9iZqxr07aql+vJ1s5sgK9sMn7LDsoZa3gQYPPSXgk7NH11D2pDSvAwLYwO0RoF/aYHQU4sKfPw=
X-Received: by 2002:a17:90b:2348:b0:2b4:a57:4bee with SMTP id
 98e67ed59e1d1-2c1dc57da90mr604723a91.17.1717128296697; Thu, 30 May 2024
 21:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240529095032.1669886-1-sunil.khatri@amd.com>
 <20240529095032.1669886-4-sunil.khatri@amd.com>
In-Reply-To: <20240529095032.1669886-4-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 31 May 2024 00:04:44 -0400
Message-ID: <CADnq5_NHmCKv9AfKVec+3PwCHUDdeRmwUoWn2p4ai=UdhVQLZg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drm/amdgpu: add cp queue registers for gfx9 ipdump
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Wed, May 29, 2024 at 5:50=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Add gfx9 support of CP queue registers for all queues
> to be used by devcoredump.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 110 +++++++++++++++++++++++++-
>  1 file changed, 108 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index f3d281de2a34..f1a7b60e73ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -237,6 +237,47 @@ static const struct amdgpu_hwip_reg_entry gc_reg_lis=
t_9[] =3D {
>         SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3)
>  };
>
> +static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_9[] =3D {
> +       /* compute queue registers */
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_VMID),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_ACTIVE),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PERSISTENT_STATE),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PIPE_PRIORITY),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_QUEUE_PRIORITY),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_QUANTUM),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_BASE),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_BASE_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_BASE_ADDR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_BASE_ADDR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_REQUEST),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_BASE_ADDR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_WPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_EVENTS),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_BASE_ADDR_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_BASE_ADDR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CNTL_STACK_OFFSET),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CNTL_STACK_SIZE),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_WG_STATE_OFFSET),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_SIZE),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_GDS_RESOURCE_STATE),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_ERROR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_WPTR_MEM),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_GFX_STATUS),
> +};
> +
>  enum ta_ras_gfx_subblock {
>         /*CPC*/
>         TA_RAS_BLOCK__GFX_CPC_INDEX_START =3D 0,
> @@ -2086,6 +2127,7 @@ static void gfx_v9_0_alloc_ip_dump(struct amdgpu_de=
vice *adev)
>  {
>         uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_9);
>         uint32_t *ptr;
> +       uint32_t inst;
>
>         ptr =3D kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
>         if (ptr =3D=3D NULL) {
> @@ -2094,6 +2136,19 @@ static void gfx_v9_0_alloc_ip_dump(struct amdgpu_d=
evice *adev)
>         } else {
>                 adev->gfx.ip_dump_core =3D ptr;
>         }
> +
> +       /* Allocate memory for compute queue registers for all the instan=
ces */
> +       reg_count =3D ARRAY_SIZE(gc_cp_reg_list_9);
> +       inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
> +               adev->gfx.mec.num_queue_per_pipe;
> +
> +       ptr =3D kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
> +       if (ptr =3D=3D NULL) {
> +               DRM_ERROR("Failed to allocate memory for GFX CP IP Dump\n=
");
> +               adev->gfx.ip_dump_cp_queues =3D NULL;
> +       } else {
> +               adev->gfx.ip_dump_cp_queues =3D ptr;

As a follow on patch, you may want to rename this to
ip_dump_compute_queues since these are compute queue registers.
Other than that, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +       }
>  }
>
>  static int gfx_v9_0_sw_init(void *handle)
> @@ -2311,6 +2366,7 @@ static int gfx_v9_0_sw_fini(void *handle)
>         gfx_v9_0_free_microcode(adev);
>
>         kfree(adev->gfx.ip_dump_core);
> +       kfree(adev->gfx.ip_dump_cp_queues);
>
>         return 0;
>  }
> @@ -6949,7 +7005,7 @@ static void gfx_v9_0_emit_wave_limit(struct amdgpu_=
ring *ring, bool enable)
>  static void gfx_v9_ip_print(void *handle, struct drm_printer *p)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -       uint32_t i;
> +       uint32_t i, j, k, reg, index =3D 0;
>         uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_9);
>
>         if (!adev->gfx.ip_dump_core)
> @@ -6960,12 +7016,36 @@ static void gfx_v9_ip_print(void *handle, struct =
drm_printer *p)
>                            gc_reg_list_9[i].reg_name,
>                            adev->gfx.ip_dump_core[i]);
>
> +       /* print compute queue registers for all instances */
> +       if (!adev->gfx.ip_dump_cp_queues)
> +               return;
> +
> +       reg_count =3D ARRAY_SIZE(gc_cp_reg_list_9);
> +       drm_printf(p, "\nnum_mec: %d num_pipe: %d num_queue: %d\n",
> +                  adev->gfx.mec.num_mec,
> +                  adev->gfx.mec.num_pipe_per_mec,
> +                  adev->gfx.mec.num_queue_per_pipe);
> +
> +       for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
> +               for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
> +                       for (k =3D 0; k < adev->gfx.mec.num_queue_per_pip=
e; k++) {
> +                               drm_printf(p, "\nmec %d, pipe %d, queue %=
d\n", i, j, k);
> +                               for (reg =3D 0; reg < reg_count; reg++) {
> +                                       drm_printf(p, "%-50s \t 0x%08x\n"=
,
> +                                                  gc_cp_reg_list_9[reg].=
reg_name,
> +                                                  adev->gfx.ip_dump_cp_q=
ueues[index + reg]);
> +                               }
> +                               index +=3D reg_count;
> +                       }
> +               }
> +       }
> +
>  }
>
>  static void gfx_v9_ip_dump(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -       uint32_t i;
> +       uint32_t i, j, k, reg, index =3D 0;
>         uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_9);
>
>         if (!adev->gfx.ip_dump_core)
> @@ -6976,6 +7056,32 @@ static void gfx_v9_ip_dump(void *handle)
>                 adev->gfx.ip_dump_core[i] =3D RREG32(SOC15_REG_ENTRY_OFFS=
ET(gc_reg_list_9[i]));
>         amdgpu_gfx_off_ctrl(adev, true);
>
> +       /* dump compute queue registers for all instances */
> +       if (!adev->gfx.ip_dump_cp_queues)
> +               return;
> +
> +       reg_count =3D ARRAY_SIZE(gc_cp_reg_list_9);
> +       amdgpu_gfx_off_ctrl(adev, false);
> +       mutex_lock(&adev->srbm_mutex);
> +       for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
> +               for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
> +                       for (k =3D 0; k < adev->gfx.mec.num_queue_per_pip=
e; k++) {
> +                               /* ME0 is for GFX so start from 1 for CP =
*/
> +                               soc15_grbm_select(adev, 1 + i, j, k, 0, 0=
);
> +
> +                               for (reg =3D 0; reg < reg_count; reg++) {
> +                                       adev->gfx.ip_dump_cp_queues[index=
 + reg] =3D
> +                                               RREG32(SOC15_REG_ENTRY_OF=
FSET(
> +                                                       gc_cp_reg_list_9[=
reg]));
> +                               }
> +                               index +=3D reg_count;
> +                       }
> +               }
> +       }
> +       soc15_grbm_select(adev, 0, 0, 0, 0, 0);
> +       mutex_unlock(&adev->srbm_mutex);
> +       amdgpu_gfx_off_ctrl(adev, true);
> +
>  }
>
>  static const struct amd_ip_funcs gfx_v9_0_ip_funcs =3D {
> --
> 2.34.1
>
