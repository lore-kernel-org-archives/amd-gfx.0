Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB63CF6D3D
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 16:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6599210E62A;
	Wed,  2 Oct 2024 16:43:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PG5r5Brn";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC95810E62A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 16:43:08 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-20b05ba4192so6096715ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Oct 2024 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727887388; x=1728492188; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q9xcyH3n468t9VkiyhVMU+kW9c9ajudDGpeLsp2nWrI=;
 b=PG5r5BrnCSpBPNyvePN6XDCEFgMTubk7mYKHgvpMnTmmIpY1t5GHitmOxLlpzOLDmk
 d4b3giGbwjQPDdcuUVPCHyJThmHfss+3nYXynfjhItdvUdajdcUW9xi/evN3qEgpOu4i
 GWy2hBErwMq/UGrNKAkuwn1S0ONUj5OmcCu+7/ASkO/clV/QHw6wgOvDR8ioX0D7tcFP
 TmELmr1tefb1C2AmAw5i+TjIV1GXniNm5z92HXUf04wacI7KvAM1V96V/iUcUgMDgueO
 tgMrROOYnYL/Te35YutT01+hoEuXuLalLa7FhOIPxPiQEDjO2HzIuUa07q6+uEgtwkTh
 5bNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727887388; x=1728492188;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q9xcyH3n468t9VkiyhVMU+kW9c9ajudDGpeLsp2nWrI=;
 b=en2wsmgIWMEGW6A0U+5FgguLV65ugUViqTAbgjvo7aAPUzduasutVlVEsUEevgeHt+
 Msu+L2/B/AXpifu1jkvDcRBSD9ZD22UQMXczYodNpQmngHqGd9o+NGu6N53s7AS8Q0HX
 EIAXGqeaJNRKirP3lw0PcbFtnoDyi/CC/D7hJ0rDVm3mT6SeOt9n2vYF+goDzFBWCL9R
 +MfDi7dvx7Se6SfWE+PSBkL9FXU5ypDGgKnTZ+zDJIGDNYn5Zmyx8NV4wqmHQP8v03sT
 5CuNoqiI50rleEtm8iUJEPottDUF5zm5QjhgsnBSpvr0zmb3oU46oxggXzrzdTkmydpQ
 PfQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp4MDW9x4Z5carAoIbuSk6LaRuJW9PoKXS6gAuFGZNT287lp+UQptwKVG2x9lEdGFz238nskWA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxgQfTdMSGPHhT/1ItJ2dCy8Lk45xJYas1F5HRWVR0jtLA8m8u
 QEm1qfE3M5uqLMYidmNdFdd0npyyCMHp7WXAdBdbGlHLkuC3wtT/GW5biqpz5fyoFzZ+v/Cg66K
 8tjLMH1Ieb2kiTE9Sks3TnFsAKcc=
X-Google-Smtp-Source: AGHT+IEH0iS8VUMbcq0r5QXFxtU2s0nTO45f0fO3XycpxFbd1hevsrAWukn6rT6cTVMbBxkoj1Lq4pdlNBHT8rLXUj0=
X-Received: by 2002:a17:903:41c6:b0:20b:4ea4:dd08 with SMTP id
 d9443c01a7336-20bc5a13669mr22593065ad.6.1727887388170; Wed, 02 Oct 2024
 09:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
 <20241002043936.2960921-3-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241002043936.2960921-3-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Oct 2024 12:42:56 -0400
Message-ID: <CADnq5_MnoR-Z_4uhLWjBDZ6JyiAHaptZ=b8OQUJdTryN7x2PCw@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/amdgpu/gfx11: Implement cleaner shader support
 for GFX11 hardware
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
> The patch modifies the gfx_v11_0_kiq_set_resources function to write
> the cleaner shader's memory controller address to the ring buffer. It
> also adds a new function, gfx_v11_0_ring_emit_cleaner_shader, which
> emits the PACKET3_RUN_CLEANER_SHADER packet to the ring buffer.
>
> This patch adds support for the PACKET3_RUN_CLEANER_SHADER packet in the
> gfx_v11_0 module. This packet is used to emit the cleaner shader, which
> is used to clear GPU memory before it's reused, helping to prevent data
> leakage between different processes.
>
> Finally, the patch updates the ring function structures to include the
> new gfx_v11_0_ring_emit_cleaner_shader function. This allows the
> cleaner shader to be emitted as part of the ring's operations.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 40 +++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index a0f80cc993cf..745996ed2380 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -293,14 +293,20 @@ static void gfx_v11_0_update_perf_clk(struct amdgpu=
_device *adev,
>
>  static void gfx11_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64=
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
>                           PACKET3_SET_RESOURCES_UNMAP_LATENTY(0xa) | /* u=
nmap_latency: 0xa (~ 1s) */
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
> @@ -1087,6 +1093,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_d=
evice *adev)
>                 BUG();
>                 break;
>         }
> +       adev->gfx.xcc_mask =3D 1;

Same comment as with patch 1.

Alex

>
>         return 0;
>  }
> @@ -1574,6 +1581,11 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                 adev->gfx.mec.num_queue_per_pipe =3D 8;
>                 break;
>         }
> +       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +       default:
> +               adev->gfx.enable_cleaner_shader =3D false;
> +       }
> +
>
>         /* Enable CG flag in one VF mode for enabling RLC safe mode enter=
/exit */
>         if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(11, 0, =
3) &&
> @@ -1700,6 +1712,9 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>
>         gfx_v11_0_alloc_ip_dump(adev);
>
> +       r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +       if (r)
> +               return r;
>         return 0;
>  }
>
> @@ -1749,6 +1764,8 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>                 amdgpu_gfx_kiq_fini(adev, 0);
>         }
>
> +       amdgpu_gfx_cleaner_shader_sw_fini(adev);
> +
>         gfx_v11_0_pfp_fini(adev);
>         gfx_v11_0_me_fini(adev);
>         gfx_v11_0_rlc_fini(adev);
> @@ -1758,6 +1775,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>                 gfx_v11_0_rlc_autoload_buffer_fini(adev);
>
>         gfx_v11_0_free_microcode(adev);
> +       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>
>         kfree(adev->gfx.ip_dump_core);
>         kfree(adev->gfx.ip_dump_compute_queues);
> @@ -4575,6 +4593,9 @@ static int gfx_v11_0_hw_init(void *handle)
>         int r;
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
> +       amdgpu_gfx_cleaner_shader_init(adev, adev->gfx.cleaner_shader_siz=
e,
> +                                      adev->gfx.cleaner_shader_ptr);
> +
>         if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_RLC_BACKDOOR_A=
UTO) {
>                 if (adev->gfx.imu.funcs) {
>                         /* RLC autoload sequence 1: Program rlc ram */
> @@ -6772,6 +6793,13 @@ static void gfx_v11_ip_dump(struct amdgpu_ip_block=
 *ip_block)
>         amdgpu_gfx_off_ctrl(adev, true);
>  }
>
> +static void gfx_v11_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
> +{
> +       /* Emit the cleaner shader */
> +       amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER, 0));
> +       amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zer=
o */
> +}
> +
>  static const struct amd_ip_funcs gfx_v11_0_ip_funcs =3D {
>         .name =3D "gfx_v11_0",
>         .early_init =3D gfx_v11_0_early_init,
> @@ -6821,7 +6849,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_rin=
g_funcs_gfx =3D {
>                 5 + /* HDP_INVL */
>                 22 + /* SET_Q_PREEMPTION_MODE */
>                 8 + 8 + /* FENCE x2 */
> -               8, /* gfx_v11_0_emit_mem_sync */
> +               8 + /* gfx_v11_0_emit_mem_sync */
> +               2, /* gfx_v11_0_ring_emit_cleaner_shader */
>         .emit_ib_size =3D 4, /* gfx_v11_0_ring_emit_ib_gfx */
>         .emit_ib =3D gfx_v11_0_ring_emit_ib_gfx,
>         .emit_fence =3D gfx_v11_0_ring_emit_fence,
> @@ -6844,6 +6873,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_rin=
g_funcs_gfx =3D {
>         .soft_recovery =3D gfx_v11_0_ring_soft_recovery,
>         .emit_mem_sync =3D gfx_v11_0_emit_mem_sync,
>         .reset =3D gfx_v11_0_reset_kgq,
> +       .emit_cleaner_shader =3D gfx_v11_0_ring_emit_cleaner_shader,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute =3D {
> @@ -6864,7 +6894,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_rin=
g_funcs_compute =3D {
>                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>                 2 + /* gfx_v11_0_ring_emit_vm_flush */
>                 8 + 8 + 8 + /* gfx_v11_0_ring_emit_fence x3 for user fenc=
e, vm fence */
> -               8, /* gfx_v11_0_emit_mem_sync */
> +               8 + /* gfx_v11_0_emit_mem_sync */
> +               2, /* gfx_v11_0_ring_emit_cleaner_shader */
>         .emit_ib_size =3D 7, /* gfx_v11_0_ring_emit_ib_compute */
>         .emit_ib =3D gfx_v11_0_ring_emit_ib_compute,
>         .emit_fence =3D gfx_v11_0_ring_emit_fence,
> @@ -6882,6 +6913,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_rin=
g_funcs_compute =3D {
>         .soft_recovery =3D gfx_v11_0_ring_soft_recovery,
>         .emit_mem_sync =3D gfx_v11_0_emit_mem_sync,
>         .reset =3D gfx_v11_0_reset_kcq,
> +       .emit_cleaner_shader =3D gfx_v11_0_ring_emit_cleaner_shader,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq =3D {
> --
> 2.34.1
>
