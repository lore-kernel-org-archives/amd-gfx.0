Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7897CF6D3B
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 16:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7859410E214;
	Wed,  2 Oct 2024 16:41:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DXJVNOwj";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E893910E214
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 16:41:27 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2e13718283bso7699a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Oct 2024 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727887287; x=1728492087; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YsVXLADyYv/1D8crzdN9Xtw9a3OFd3TmKleDywX28mE=;
 b=DXJVNOwjR3zQMCvr7ynNGGUSlNfB3cKSE/Nh+VqfGs2EH8F3EskYotjO3QzmOUKQDt
 GAo0yv2wGVvvOsOytkHLAkBkIkDHDVz9PVSEk40j9xIE2S1cSXEEnsVFpKNRGCNuuH2U
 QFeUSxSWAD2JlCpe49LYlPjlKoYlz2X+7s7N/xVzz6WYQpBkqEl0NMaPBQXpDi2fG43D
 9LoXCHIDi0AUIVLb4pa4oWxszMGbrEQ5QhLWjoBe4Ace92lts1Vpdq2O84txV6ENtJzi
 uGqlt69VXeOcrTbZ31toQTS1b69DU/mKVnMHZ3knAhMbSuV72QJjHih2D7cjpeLy/+vT
 Zt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727887287; x=1728492087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YsVXLADyYv/1D8crzdN9Xtw9a3OFd3TmKleDywX28mE=;
 b=rVer56UjREolquEOIHdcMoovnKk65tttgd3QzrW/Inx/D5F4m5KZIaaTEdZ1JyK2mA
 hiEKkBKEeqYwahXfAnBKUjCSQprWD0/0YcrvDpXSgPhp2esLmfz0TMARcdU5Pr+KmcX8
 FRD2/i6Bml+LlaCooEGy7J5MH/P4FPUA/HIasl8APOahVpb7kWraW4DaGTDBmO5i7cEg
 Y7P0kZuqAhUqQ4cjvDAm+rjtHjLxMYs85OSqLvL7ufX40aLj2pV3m0YXxJuqh7OMVQ8c
 Ksh54Tjo+ns79xJvhuVafLRljkn7AQt4mWo4pOIssBM+eZbIWkCcaIBF4367TEJqy/9u
 nBew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMiv8/Fdp0Ho4NTiOXpuJgBzXilWlfFLc06zAP/GPjzPQlDfQ6oohU1kE9ABKVrY74vZ3x9h3H@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyn5b9cQiUDKBBmUwyD7r9HGVxqpwujIMbfSLXkoPuFbVOFq/Qq
 9YA+cuTayi4HjEnCziaM0VNgqgy2YZLGtknwoZeDnkiefTV6uGVCB5N7kIi+bJgWWeF4ML/Lhh5
 8adG9VqxSeiyfws0TNzI7JkPElGc=
X-Google-Smtp-Source: AGHT+IHlp4lqRAyg8L6kSdzFwBtn+bLD1mhfRvRBvw95FdZjy3lX6rQoLjkhGSzk1NBH/K8zzEt/UNBAual4KrReZqA=
X-Received: by 2002:a17:90b:388c:b0:2e0:9d55:3784 with SMTP id
 98e67ed59e1d1-2e182ca86fbmr1920067a91.0.1727887287306; Wed, 02 Oct 2024
 09:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Oct 2024 12:41:14 -0400
Message-ID: <CADnq5_PFugHf3iBJMWBidhe12XG_H3Dj5qBkPABFtL_-0tORpQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/amdgpu/gfx10: Implement cleaner shader support
 for GFX10 hardware
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Oct 2, 2024 at 12:41=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> The patch modifies the gfx_v10_0_kiq_set_resources function to write
> the cleaner shader's memory controller address to the ring buffer. It
> also adds a new function, gfx_v10_0_ring_emit_cleaner_shader, which
> emits the PACKET3_RUN_CLEANER_SHADER packet to the ring buffer.
>
> This patch adds support for the PACKET3_RUN_CLEANER_SHADER packet in the
> gfx_v10_0 module. This packet is used to emit the cleaner shader, which
> is used to clear GPU memory before it's reused, helping to prevent data
> leakage between different processes.
>
> Finally, the patch updates the ring function structures to include the
> new gfx_v10_0_ring_emit_cleaner_shader function. This allows the
> cleaner shader to be emitted as part of the ring's operations.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 40 +++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index c544ea2aea6e..2b230971c58a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3677,13 +3677,19 @@ static int gfx_v10_0_set_powergating_state(void *=
handle,
>                                           enum amd_powergating_state stat=
e);
>  static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64=
_t queue_mask)
>  {
> +       struct amdgpu_device *adev =3D kiq_ring->adev;
> +       u64 shader_mc_addr;
> +
> +       /* Cleaner shader MC address */
> +       shader_mc_addr =3D adev->gfx.cleaner_shader_gpu_addr >> 8;
> +
>         amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
>         amdgpu_ring_write(kiq_ring, PACKET3_SET_RESOURCES_VMID_MASK(0) |
>                           PACKET3_SET_RESOURCES_QUEUE_TYPE(0)); /* vmid_m=
ask:0 queue_type:0 (KIQ) */
>         amdgpu_ring_write(kiq_ring, lower_32_bits(queue_mask)); /* queue =
mask lo */
>         amdgpu_ring_write(kiq_ring, upper_32_bits(queue_mask)); /* queue =
mask hi */
> -       amdgpu_ring_write(kiq_ring, 0); /* gws mask lo */
> -       amdgpu_ring_write(kiq_ring, 0); /* gws mask hi */
> +       amdgpu_ring_write(kiq_ring, lower_32_bits(shader_mc_addr)); /* cl=
eaner shader addr lo */
> +       amdgpu_ring_write(kiq_ring, upper_32_bits(shader_mc_addr)); /* cl=
eaner shader addr hi */
>         amdgpu_ring_write(kiq_ring, 0); /* oac mask */
>         amdgpu_ring_write(kiq_ring, 0); /* gds heap base:0, gds heap size=
:0 */
>  }
> @@ -4557,6 +4563,7 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_=
device *adev)
>                 break;
>         }
>
> +       adev->gfx.xcc_mask =3D 1;

I think you can drop this.  The xcc mask is calculated in
amdgpu_discovery.c for devices which have an IP discovery table.

Alex

>         adev->gfx.config.gb_addr_config =3D gb_addr_config;
>
>         adev->gfx.config.gb_addr_config_fields.num_pipes =3D 1 <<
> @@ -4726,6 +4733,11 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                 adev->gfx.mec.num_queue_per_pipe =3D 8;
>                 break;
>         }
> +       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +       default:
> +               adev->gfx.enable_cleaner_shader =3D false;
> +               break;
> +       }
>
>         /* KIQ event */
>         r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP,
> @@ -4842,6 +4854,9 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>
>         gfx_v10_0_alloc_ip_dump(adev);
>
> +       r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +       if (r)
> +               return r;
>         return 0;
>  }
>
> @@ -4881,6 +4896,8 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>         amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[0].ring);
>         amdgpu_gfx_kiq_fini(adev, 0);
>
> +       amdgpu_gfx_cleaner_shader_sw_fini(adev);
> +
>         gfx_v10_0_pfp_fini(adev);
>         gfx_v10_0_ce_fini(adev);
>         gfx_v10_0_me_fini(adev);
> @@ -4891,6 +4908,7 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>                 gfx_v10_0_rlc_backdoor_autoload_buffer_fini(adev);
>
>         gfx_v10_0_free_microcode(adev);
> +       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>
>         kfree(adev->gfx.ip_dump_core);
>         kfree(adev->gfx.ip_dump_compute_queues);
> @@ -7374,6 +7392,9 @@ static int gfx_v10_0_hw_init(void *handle)
>         if (!amdgpu_emu_mode)
>                 gfx_v10_0_init_golden_registers(adev);
>
> +       amdgpu_gfx_cleaner_shader_init(adev, adev->gfx.cleaner_shader_siz=
e,
> +                                      adev->gfx.cleaner_shader_ptr);
> +
>         if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) {
>                 /**
>                  * For gfx 10, rlc firmware loading relies on smu firmwar=
e is
> @@ -9699,6 +9720,13 @@ static void gfx_v10_ip_dump(struct amdgpu_ip_block=
 *ip_block)
>         amdgpu_gfx_off_ctrl(adev, true);
>  }
>
> +static void gfx_v10_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
> +{
> +       /* Emit the cleaner shader */
> +       amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER, 0));
> +       amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zer=
o */
> +}
> +
>  static const struct amd_ip_funcs gfx_v10_0_ip_funcs =3D {
>         .name =3D "gfx_v10_0",
>         .early_init =3D gfx_v10_0_early_init,
> @@ -9749,7 +9777,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_rin=
g_funcs_gfx =3D {
>                 5 + /* HDP_INVL */
>                 8 + 8 + /* FENCE x2 */
>                 2 + /* SWITCH_BUFFER */
> -               8, /* gfx_v10_0_emit_mem_sync */
> +               8 + /* gfx_v10_0_emit_mem_sync */
> +               2, /* gfx_v10_0_ring_emit_cleaner_shader */
>         .emit_ib_size =3D 4, /* gfx_v10_0_ring_emit_ib_gfx */
>         .emit_ib =3D gfx_v10_0_ring_emit_ib_gfx,
>         .emit_fence =3D gfx_v10_0_ring_emit_fence,
> @@ -9772,6 +9801,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_rin=
g_funcs_gfx =3D {
>         .soft_recovery =3D gfx_v10_0_ring_soft_recovery,
>         .emit_mem_sync =3D gfx_v10_0_emit_mem_sync,
>         .reset =3D gfx_v10_0_reset_kgq,
> +       .emit_cleaner_shader =3D gfx_v10_0_ring_emit_cleaner_shader,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute =3D {
> @@ -9791,7 +9821,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_rin=
g_funcs_compute =3D {
>                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>                 2 + /* gfx_v10_0_ring_emit_vm_flush */
>                 8 + 8 + 8 + /* gfx_v10_0_ring_emit_fence x3 for user fenc=
e, vm fence */
> -               8, /* gfx_v10_0_emit_mem_sync */
> +               8 + /* gfx_v10_0_emit_mem_sync */
> +               2, /* gfx_v10_0_ring_emit_cleaner_shader */
>         .emit_ib_size =3D 7, /* gfx_v10_0_ring_emit_ib_compute */
>         .emit_ib =3D gfx_v10_0_ring_emit_ib_compute,
>         .emit_fence =3D gfx_v10_0_ring_emit_fence,
> @@ -9809,6 +9840,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_rin=
g_funcs_compute =3D {
>         .soft_recovery =3D gfx_v10_0_ring_soft_recovery,
>         .emit_mem_sync =3D gfx_v10_0_emit_mem_sync,
>         .reset =3D gfx_v10_0_reset_kcq,
> +       .emit_cleaner_shader =3D gfx_v10_0_ring_emit_cleaner_shader,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq =3D {
> --
> 2.34.1
>
