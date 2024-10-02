Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0387ACEB2E0
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 17:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4D5110E21B;
	Wed,  2 Oct 2024 17:43:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L1smhZae";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4A0910E21B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 17:43:00 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2e13718283bso19801a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Oct 2024 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727890980; x=1728495780; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xSp4bByC598eyNFYpmdP77jO+FYPee5hNYpsHKNrbKM=;
 b=L1smhZaeWMr/b9ourvAUD+UwkC/IAR5jAwxdEKtSDELD6DOA0V2130NlkxQs7htzjn
 AuY44PbO/gM42grhfIaE21ScnesFX8Z5vcf8djUYJWFjWIxKRPMLORm5ARnpisIdCQXP
 V8b6oA3UQIqTbjS3XnAKkkrZbKZmzWDi48F8mt7aIfxiQYxaTon6HDNiwj73OsymGenQ
 WmHkIhAgthj4psqlN9pttqHQk+CJntzzdZOj3mnyMh2AjxbZm0aUnvgnysdVxb5x539V
 wlk5PiBGBTGNBMGUjSpCj0Wt/Mv2Ox1D85GJnzItPchNCzklWKce7q/AW+MzO+btYCDr
 tO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727890980; x=1728495780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xSp4bByC598eyNFYpmdP77jO+FYPee5hNYpsHKNrbKM=;
 b=QJlkOq3KNStX46N7hB2GhnzzEPkERPF2+0820U0jkYONbGdhN6+IejF3wRbga2/rsq
 FAZ2ppqzUggFN2elCQIlrKFIVxAyVJn+Cbyj5i2ZsK9KrThm+35G7+ffC2749uK0pgCJ
 JH0Ogoh4aFpCU+XOhuH/HJ9H6Dt4Xp9UFQryGQ8mnQPT/9rZiRlYLvNixHPIcUumbGRI
 ETvyZAedGm8NFi/qH78ExmcKeGNzmzyDIWR9zuzgr3BnYRR1T3xJYLWx/pUM32udaZzl
 hyxwBxFUbS06lThp+NoI3aDB5LTwXpiLPN4mxeYCjXTR/FczZZm/I1j8xIn72teu5jyC
 1PIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyEBcSfVWAuALWxOjoTaL2v3HPiZLb9FH0i2MokgXJEO2z5sw1Z4iILA1ITAYXZFode2t7yxBa@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEq3kc99ER9+dZSHONlJmaI3GP8K73gD4NLO/z7V+JbeenGGxe
 RhlZk9ts98SDjKXnK7axhb5eGhrlWcSdmf5CTObDXl7Yj97zS0pwQFRXO5gHbzIUaSqcayezmgA
 9nn76YRs9D/vVVvF2R2PItZjrwN6cww==
X-Google-Smtp-Source: AGHT+IHXjXpodpf+X2jgFueHKUeZhtGZdUB6414Ry7ZoovD8uqL8SnKOiE2Jv2ukEBn4mv1UXrZ5V64ekXToiatcfmM=
X-Received: by 2002:a17:90a:17ec:b0:2db:60b:9be4 with SMTP id
 98e67ed59e1d1-2e18499420cmr1955371a91.7.1727890980202; Wed, 02 Oct 2024
 10:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20241002043936.2960921-5-srinivasan.shanmugam@amd.com>
 <20241002170202.3179466-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241002170202.3179466-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Oct 2024 13:42:48 -0400
Message-ID: <CADnq5_NCRwrwrKntE5+-eLtEHiTPFnZobLJi_BBofZ1Wa-xftg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] drm/amdgpu/gfx12: Implement cleaner shader support
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

Patches 1, 3, 5 are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Oct 2, 2024 at 1:02=E2=80=AFPM Srinivasan Shanmugam
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
> v2:
>     Removed xcc mask, as it is calculated in amdgpu_discovery.c for
>     devices which have an IP discovery table. (Alex)
>
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 27 ++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 63e1a2803503..60d403038d6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1346,6 +1346,12 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_bloc=
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
> @@ -1460,6 +1466,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_bloc=
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
> @@ -1519,6 +1529,8 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>
>         gfx_v12_0_free_microcode(adev);
>
> +       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +
>         kfree(adev->gfx.ip_dump_core);
>         kfree(adev->gfx.ip_dump_compute_queues);
>         kfree(adev->gfx.ip_dump_gfx_queues);
> @@ -5038,6 +5050,13 @@ static void gfx_v12_ring_insert_nop(struct amdgpu_=
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
> @@ -5297,7 +5316,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_rin=
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
> @@ -5318,6 +5338,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_rin=
g_funcs_gfx =3D {
>         .soft_recovery =3D gfx_v12_0_ring_soft_recovery,
>         .emit_mem_sync =3D gfx_v12_0_emit_mem_sync,
>         .reset =3D gfx_v12_0_reset_kgq,
> +       .emit_cleaner_shader =3D gfx_v12_0_ring_emit_cleaner_shader,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute =3D {
> @@ -5336,7 +5357,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_rin=
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
> @@ -5353,6 +5375,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_rin=
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
