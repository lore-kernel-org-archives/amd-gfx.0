Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC0DC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 15:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 888A110EC09;
	Fri, 11 Apr 2025 15:55:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BHfsI+kM";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0944D10EC09
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 15:55:39 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2ff67f44fcaso385559a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 08:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744386938; x=1744991738; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=63qY4N3FxtT0lv3MECz8CzPrb2GGjrKYRyFrH0oIFOY=;
 b=BHfsI+kMq4m82y1xWEAikIhGDgJ545U81R34n+QuXTj6vh0y5Bnieph7nHL0Kg5Jul
 Qt82n22gHNFOwCRG4iwPsvCVoYxMZ528O90NVbLJ/RzxC7jp4S1LPNAZLS23TrALWmpM
 p8R+nJFTPSBQJja6GoI8l1giwbg3fO8ujs8yeNvmWaFW7VoIMR/kqC2PAuXsspNnSR4G
 WxSKq7rdHdifflrv8yHGYdHj4UZPAAhLq3/i5xqKkMUU4yT4sDdmYRm9X6RrYaJ2khUB
 wYlEQnF9kiOVp/Y+C4Cvcd0/+bV2IIy14RGDAP4DWHFerWjT1YgW5NZj3KV6/qsw74nU
 EaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744386938; x=1744991738;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=63qY4N3FxtT0lv3MECz8CzPrb2GGjrKYRyFrH0oIFOY=;
 b=MsmS9ku284q6BvSGKyKyUSPNrSInRBWZdA6CdbZqQh2brl7WcDyDnTPdZeLBCSg0RQ
 ILEDy9P3IPBUaz7D0B3R8npp7j6Mtvn4gPEiVh8tBFR14kTlcPgLqhlT9MDit4YpaJkd
 8aq5P+zDa34m/TN0eqdezhCnzTZ2DLg20jhWo9yunT32gaiNMZfZvNcrhQcFP8jM3klO
 gd50nNkRmQEZSwgyVxfu334oWfcVF2msTHrVRkOjGui5XtiXXwF1MDmQKRMfCCZdwmdA
 t6rkAli5eBdDhMJuIdgVH1bVhD+ChrfzuOstW8PUhPOjPBuWD6asihVBK3geqzoKp7SP
 q/jQ==
X-Gm-Message-State: AOJu0YxpObe5d5qfr6mnOxRE2i3TRfc54TU6V/bmlW7SjN7iLdFC88kg
 Iu0OCPdnZWDdpc9raa7E0ECNfJjSp1Gt0km24y8jYyKwMJ+J/nvMVhs3pW5jSE7Ko56FQGB+tfg
 q9esJuGEx3NcEurSJROhSUGP8BNg=
X-Gm-Gg: ASbGncsjTb6WcfnmFWwzyk2cjPcfck6AmR4RzjNPVceSegEydmtfkBy8FX7vGokdKxT
 zFbHBkyTwIX7WRFsaAFbQI/x763J2Croa8+VOdB/cAcnMwdxFG98KUOquqPC3+9I7Oe4Co+1Vp3
 LPbicZRMwDrBZ8NSn44DVvWw==
X-Google-Smtp-Source: AGHT+IEnGk79CG7XB0JJsbhIW0sM7BiPKTj0p+rLmvf/DRq/1WLMcaK8N+QTGIR5MLIBBhXFtsmAIYth1NwPS3PDTKA=
X-Received: by 2002:a17:90b:1b0d:b0:301:1c11:aa7a with SMTP id
 98e67ed59e1d1-308236744f7mr1765236a91.3.1744386938425; Fri, 11 Apr 2025
 08:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250411082921.3228498-1-jesse.zhang@amd.com>
 <20250411082921.3228498-6-jesse.zhang@amd.com>
In-Reply-To: <20250411082921.3228498-6-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Apr 2025 11:55:26 -0400
X-Gm-Features: ATxdqUEGKzNc6rNOoTJe95Sy3zRRBz08mhu4Vb2euk-dZMH2ER5R-8ubCWG9Agw
Message-ID: <CADnq5_MYXEpk0_G4zTqMyd=qy27VgP826b4o7itjmEu3EwmWXA@mail.gmail.com>
Subject: Re: [v5 6/6] drm/amdgpu:remove old sdma reset callback mechanism
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, jonathan.kim@amd.com,
 jiadong.zhu@amd.com
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

On Fri, Apr 11, 2025 at 4:30=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@am=
d.com> wrote:
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> This patch removes the deprecated SDMA reset callback mechanism, which wa=
s previously used to register pre-reset and post-reset callbacks for SDMA e=
ngine resets.
>  The callback mechanism has been replaced with a more direct and efficien=
t approach using `stop_queue` and `start_queue` functions in the ring's fun=
ction table.
>
> The SDMA reset callback mechanism allowed KFD and AMDGPU to register pre-=
reset and post-reset functions for handling SDMA engine resets.
> However, this approach added unnecessary complexity and was no longer nee=
ded after the introduction of the `stop_queue` and `start_queue` functions =
in the ring's function table.
>
> 1. **Remove Callback Mechanism**:
>    - Removed the `amdgpu_sdma_register_on_reset_callbacks` function and i=
ts associated data structures (`sdma_on_reset_funcs`).
>    - Removed the callback registration logic from the SDMA v4.4.2 initial=
ization code.
>
> 2. **Clean Up Related Code**:
>    - Removed the `sdma_v4_4_2_set_engine_reset_funcs` function, which was=
 used to register the callbacks.
>    - Removed the `sdma_v4_4_2_engine_reset_funcs` structure, which contai=
ned the pre-reset and post-reset callback functions.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 25 ------------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  8 --------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 10 ----------
>  3 files changed, 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index b271a0626886..ac6d811f4824 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -531,31 +531,6 @@ bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_dev=
ice *adev, struct amdgpu_rin
>                 return false;
>  }
>
> -/**
> - * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbac=
ks
> - * @adev: Pointer to the AMDGPU device
> - * @funcs: Pointer to the callback structure containing pre_reset and po=
st_reset functions
> - *
> - * This function allows KFD and AMDGPU to register their own callbacks f=
or handling
> - * pre-reset and post-reset operations for engine reset. These are neede=
d because engine
> - * reset will stop all queues on that engine.
> - */
> -void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev,=
 struct sdma_on_reset_funcs *funcs)
> -{
> -       if (!funcs)
> -               return;
> -
> -       /* Ensure the reset_callback_list is initialized */
> -       if (!adev->sdma.reset_callback_list.next) {
> -               INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
> -       }
> -       /* Initialize the list node in the callback structure */
> -       INIT_LIST_HEAD(&funcs->list);
> -
> -       /* Add the callback structure to the global list */
> -       list_add_tail(&funcs->list, &adev->sdma.reset_callback_list);
> -}
> -
>  static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instan=
ce_id)
>  {
>         struct amdgpu_sdma_instance *sdma_instance =3D &adev->sdma.instan=
ce[instance_id];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.h
> index a6c8f07a0da4..41cf29531652 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -109,13 +109,6 @@ struct amdgpu_sdma_ras {
>         struct amdgpu_ras_block_object ras_block;
>  };
>
> -struct sdma_on_reset_funcs {
> -       int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id=
);
> -       int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_i=
d);
> -       /* Linked list node to store this structure in a list; */
> -       struct list_head list;
> -};
> -
>  struct amdgpu_sdma {
>         struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
>         struct amdgpu_irq_src   trap_irq;
> @@ -177,7 +170,6 @@ struct amdgpu_buffer_funcs {
>                                  uint32_t byte_count);
>  };
>
> -void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev,=
 struct sdma_on_reset_funcs *funcs);
>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instan=
ce_id);
>
>  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffe=
r_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index c663c63485f4..e343aaaea12d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -106,7 +106,6 @@ static void sdma_v4_4_2_set_buffer_funcs(struct amdgp=
u_device *adev);
>  static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
> -static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *ade=
v);
>  static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev);
>  static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring);
>  static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring);
> @@ -1358,7 +1357,6 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_=
block *ip_block)
>         sdma_v4_4_2_set_vm_pte_funcs(adev);
>         sdma_v4_4_2_set_irq_funcs(adev);
>         sdma_v4_4_2_set_ras_funcs(adev);
> -       sdma_v4_4_2_set_engine_reset_funcs(adev);
>         return 0;
>  }
>
> @@ -1747,14 +1745,6 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu=
_ring *ring)
>         return sdma_v4_4_2_inst_start(adev, inst_mask, true);
>  }
>
> -static struct sdma_on_reset_funcs sdma_v4_4_2_engine_reset_funcs =3D {
> -};
> -
> -static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *ade=
v)
> -{
> -       amdgpu_sdma_register_on_reset_callbacks(adev, &sdma_v4_4_2_engine=
_reset_funcs);
> -}
> -
>  static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
>                                         struct amdgpu_irq_src *source,
>                                         unsigned type,
> --
> 2.25.1
>
