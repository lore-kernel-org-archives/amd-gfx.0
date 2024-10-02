Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232E8CF6D3D
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 16:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF6F410E226;
	Wed,  2 Oct 2024 16:44:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SjynKzQw";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB4410E226
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 16:44:00 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2e0ad414718so8442a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Oct 2024 09:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727887440; x=1728492240; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vKtJZnX9dd5etStjrwL02zKDZne3PVzADbGd2xch6E8=;
 b=SjynKzQw/Nwg7LI36awek92ft6j/zSfIwKsWGExQjb7+mSoyUf/SM2dchh6Y/ispp+
 tvwANy0IUPlrlC+txqPGKwNkrfZclw9p23xMMk4/nQgF+hdkEWu5bbWT6/r3H8Hosg2+
 1ijUJl8OjvHtBqbxpQsuxH9VwHWdShIWDMKvAM5TUIya+vLMGJK5OvTbGTDhnzs3QBuP
 exoQrTeSObB83XcqgUvTHUhBfMIxNS1yV5n84ylUZJqe4RnVpIWb5zCRnJOXWiUw2xtT
 wg4vEhmv0d1kvrOyuyS38lmTviZKeagEnHVg1mf6mHDdTu2UnZwnqnyyeZkie5KGkzDI
 8cpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727887440; x=1728492240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vKtJZnX9dd5etStjrwL02zKDZne3PVzADbGd2xch6E8=;
 b=F305kpKQIyEIpmwfgjVBnoNSg/ACHI+1/sONF+Kjt+qwDKjXEFfhJn4eNF+/Cfdq1h
 GLS4y1u2pPo5smMkviuFdlkIRs56cSHd4wM2UwGB2UJsSW+tyB8kho4v2rVW9EoMY/EZ
 S8nzeuvnSo9mgGvRoPUSYl15Ju9sXtwJ1AYj1apnJMqz2JBSA0mKGd4jYyOIQZ9l7io1
 +4KumSg+qBOcDRQPWfmWCJvWx4Mi3Ex76bCFepbWotH35cP1dAylaVh3gcY3nWm3qPcd
 wa5y5qqPltNH5bO+sMnUellITp/UlSszmFa3FndwBcZcN7R7fFhMiDvXredWfd7VxPhW
 HLtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI91qefWpwIEsvaZA631u14gynEJwHPXGS/5rPj3ss4qSGkkZ3FzDVjLGl2L2cPn5X9ZNRVQb3@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yya66QkgAuMeijTu0/n2taI1PVlJv4AWJSLEO2lGeZwmmFYQhaI
 YrgcHSQjtyxQIp/JjbYfneIri3vPj88a2CqMeHBjpVbK+dansqMD0ZZdw+22fRK3IgesYzkk0po
 BeUwz+LqJiA0Sx+frumUBOxZ3XCk=
X-Google-Smtp-Source: AGHT+IG1Cc0QhlyGf4aRX5Zf0qenolidIcVVrt8ClVOwYHtRJDM0Y+76pGwI3p6wiOI3s3HtYTslGbwemMgxVK11Zto=
X-Received: by 2002:a17:90a:ec0d:b0:2e0:9147:7dc1 with SMTP id
 98e67ed59e1d1-2e184993a92mr1897517a91.6.1727887439929; Wed, 02 Oct 2024
 09:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
 <20241002043936.2960921-5-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241002043936.2960921-5-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Oct 2024 12:43:48 -0400
Message-ID: <CADnq5_OQphPVkiv2ARn77ykfn8+2wwwJo2=KbG15bcTH4PPKNA@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/amdgpu/gfx12: Implement cleaner shader support
 for GFX12 hardware
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

On Wed, Oct 2, 2024 at 12:58=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This patch adds support for the PACKET3_RUN_CLEANER_SHADER packet in the
> gfx_v12_0 module. This packet is used to emit the cleaner shader, which
> is used to clear GPU memory before it's reused, helping to prevent data
> leakage between different processes.
>
> Finally, the patch updates the ring function structures to include the
> new gfx_v12_0_ring_emit_cleaner_shader function. This allows the
> cleaner shader to be emitted as part of the ring's operations.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 28 ++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 63e1a2803503..df4a30f8a205 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -886,6 +886,7 @@ static int gfx_v12_0_gpu_early_init(struct amdgpu_dev=
ice *adev)
>                 BUG();
>                 break;
>         }
> +       adev->gfx.xcc_mask =3D 1;

Same comment as patch 1.

Alex

>
>         return 0;
>  }
> @@ -1346,6 +1347,12 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                 break;
>         }
>
> +       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +       default:
> +               adev->gfx.enable_cleaner_shader =3D false;
> +               break;
> +       }
> +
>         /* recalculate compute rings to use based on hardware configurati=
on */
>         num_compute_rings =3D (adev->gfx.mec.num_pipe_per_mec *
>                              adev->gfx.mec.num_queue_per_pipe) / 2;
> @@ -1460,6 +1467,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>
>         gfx_v12_0_alloc_ip_dump(adev);
>
> +       r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +       if (r)
> +               return r;
> +
>         return 0;
>  }
>
> @@ -1519,6 +1530,8 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>
>         gfx_v12_0_free_microcode(adev);
>
> +       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +
>         kfree(adev->gfx.ip_dump_core);
>         kfree(adev->gfx.ip_dump_compute_queues);
>         kfree(adev->gfx.ip_dump_gfx_queues);
> @@ -5038,6 +5051,13 @@ static void gfx_v12_ring_insert_nop(struct amdgpu_=
ring *ring, uint32_t num_nop)
>                 amdgpu_ring_write(ring, ring->funcs->nop);
>  }
>
> +static void gfx_v12_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
> +{
> +       /* Emit the cleaner shader */
> +       amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER, 0));
> +       amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zer=
o */
> +}
> +
>  static void gfx_v12_ip_print(struct amdgpu_ip_block *ip_block, struct dr=
m_printer *p)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> @@ -5297,7 +5317,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_rin=
g_funcs_gfx =3D {
>                 3 + /* CNTX_CTRL */
>                 5 + /* HDP_INVL */
>                 8 + 8 + /* FENCE x2 */
> -               8, /* gfx_v12_0_emit_mem_sync */
> +               8 + /* gfx_v12_0_emit_mem_sync */
> +               2, /* gfx_v12_0_ring_emit_cleaner_shader */
>         .emit_ib_size =3D 4, /* gfx_v12_0_ring_emit_ib_gfx */
>         .emit_ib =3D gfx_v12_0_ring_emit_ib_gfx,
>         .emit_fence =3D gfx_v12_0_ring_emit_fence,
> @@ -5318,6 +5339,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_rin=
g_funcs_gfx =3D {
>         .soft_recovery =3D gfx_v12_0_ring_soft_recovery,
>         .emit_mem_sync =3D gfx_v12_0_emit_mem_sync,
>         .reset =3D gfx_v12_0_reset_kgq,
> +       .emit_cleaner_shader =3D gfx_v12_0_ring_emit_cleaner_shader,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute =3D {
> @@ -5336,7 +5358,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_rin=
g_funcs_compute =3D {
>                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>                 2 + /* gfx_v12_0_ring_emit_vm_flush */
>                 8 + 8 + 8 + /* gfx_v12_0_ring_emit_fence x3 for user fenc=
e, vm fence */
> -               8, /* gfx_v12_0_emit_mem_sync */
> +               8 + /* gfx_v12_0_emit_mem_sync */
> +               2, /* gfx_v12_0_ring_emit_cleaner_shader */
>         .emit_ib_size =3D 7, /* gfx_v12_0_ring_emit_ib_compute */
>         .emit_ib =3D gfx_v12_0_ring_emit_ib_compute,
>         .emit_fence =3D gfx_v12_0_ring_emit_fence,
> @@ -5353,6 +5376,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_rin=
g_funcs_compute =3D {
>         .soft_recovery =3D gfx_v12_0_ring_soft_recovery,
>         .emit_mem_sync =3D gfx_v12_0_emit_mem_sync,
>         .reset =3D gfx_v12_0_reset_kcq,
> +       .emit_cleaner_shader =3D gfx_v12_0_ring_emit_cleaner_shader,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq =3D {
> --
> 2.34.1
>
