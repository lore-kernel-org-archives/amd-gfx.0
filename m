Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555AFC2BD09
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 14:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F83C10E8EE;
	Wed,  3 Jul 2024 14:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EmwCyvI4";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D44D10E8E3
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 14:29:10 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2c97aceb6e4so469307a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jul 2024 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720016950; x=1720621750; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mBJzSFLzwdLsyCRgN9qRxy6yyFkDUjl+4YzWMMfFEcQ=;
 b=EmwCyvI42sKG7FjSBVS1Zo8EJWBy6Ab6INjWHX7VstLW3o6Du/dumZoyB3xpgHcREn
 MxSuiepKT0BjrmZcom8m1CgjW4Kl4Iuo65OBeqLUuWzFzGmYJIhtKkRcMQJAQMzJZrty
 qUuwvf9VnYslo/N0lJr9+oCSlo3uexYjaUPUTDomUHE3ICHHBlbseWCjIcCJcP2EB86f
 kGEniS7KJRGXFfHsTnS+XklUJQ+cDvN1cE134fS7pN1xQBUDxpFP6m1TNl/7VlkQCAWF
 /zEc2/Zvjlf4S0rWk+IjXMrctxXAY9CZa7PiLTCYS+n8yhEwZpxW4EXpxceVIERtKEhH
 OKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720016950; x=1720621750;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mBJzSFLzwdLsyCRgN9qRxy6yyFkDUjl+4YzWMMfFEcQ=;
 b=dz+O6wNlSWYTJ6Y+vNF0BnPJHBzeO+fdswxFZsfVrhG/h7IhE+OldzCSEjAenbcKRo
 gWUeEXRDvSF16RwnfZ/ULwHbow3ekFq5e6jD4p0IQy+CML1xB3emCJpe/JlLctC+/r3x
 Ik4SOedeY4L3jiEhZODXVUkbAGYIT/wRRs/lnQienuKp9TbUasYPWItittDbrztbkaek
 yplGbYdbayb4gGE1WSpjJ/R8ukS4P0/J6363YtB3uH8nbVO1riF14yjF0f/NUgT1VtQl
 Wb0XZWQO9yf85vGJwlXz8DVz/ito4gR1Gs+0H0Jx0lOS2E7UNoVCuG4uMalzBU8bQ5Aa
 AP9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPC1tlIkSkwLZAD2dBMmdqdxq03mXxBhGcgmdQiDM+Wyvbh6eIY45KiIp+D7sNXwGeznjYy5Ha+ecSH851RD8yDMbb/YYzRBjNIqg1dQ==
X-Gm-Message-State: AOJu0Yy3mXMvlkRCAndFwCdBhIYYlZzYZxqIit8rwsL/wx7hp60wMyUp
 m+ofbu9uahPVgPGflzIU1i+cqLWyfsXdG3N5rXvsBqnfBrJ8qcIu7N1AiBEIC6xJ+mIG2ttjGT6
 A+1VFzbT/Ogk6u6VP0/jnL+zc/7I=
X-Google-Smtp-Source: AGHT+IH4sMt/hHsooimbrYAqshyD0yLAfQb38UNB3cGEJCt0f4At/IUkjN2g9mZGLG/gLBG/6jyvodoqferngqiqed8=
X-Received: by 2002:a17:90a:5106:b0:2c9:6791:a752 with SMTP id
 98e67ed59e1d1-2c96791a7e9mr2901548a91.44.1720016949901; Wed, 03 Jul 2024
 07:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240703073901.914348-1-sunil.khatri@amd.com>
 <20240703073901.914348-5-sunil.khatri@amd.com>
In-Reply-To: <20240703073901.914348-5-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Jul 2024 10:28:57 -0400
Message-ID: <CADnq5_P-RuiYM63bqe=rkvhuC5pR=QZ_2btiRG5h=najnWSZNQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] drm/amdgpu: add gfx queue support for gfx12 ipdump
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jul 3, 2024 at 3:39=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com> =
wrote:
>
> Add support of all the CP GFX queues for gfx12 ipdump
> to be used by devcoredump.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 94 ++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 21b8167f39bd..cf7209b93617 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -173,6 +173,35 @@ static const struct amdgpu_hwip_reg_entry gc_cp_reg_=
list_12[] =3D {
>         SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_STATUS)
>  };
>
> +static const struct amdgpu_hwip_reg_entry gc_gfx_queue_reg_list_12[] =3D=
 {
> +       /* gfx queue registers */
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_ACTIVE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_VMID),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_QUEUE_PRIORITY),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_QUANTUM),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_BASE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_BASE_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_OFFSET),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_CNTL),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_CSMD_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_WPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_WPTR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_DEQUEUE_REQUEST),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_MAPPED),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_QUE_MGR_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_HQ_CONTROL0),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_HQ_STATUS0),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_MQD_BASE_ADDR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_MQD_BASE_ADDR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR_POLL_ADDR_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR_POLL_ADDR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ)
> +};
> +
>  #define DEFAULT_SH_MEM_CONFIG \
>         ((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) |=
 \
>          (SH_MEM_ALIGNMENT_MODE_UNALIGNED << SH_MEM_CONFIG__ALIGNMENT_MOD=
E__SHIFT) | \
> @@ -1265,6 +1294,19 @@ static void gfx_v12_0_alloc_ip_dump(struct amdgpu_=
device *adev)
>         } else {
>                 adev->gfx.ip_dump_compute_queues =3D ptr;
>         }
> +
> +       /* Allocate memory for gfx queue registers for all the instances =
*/
> +       reg_count =3D ARRAY_SIZE(gc_gfx_queue_reg_list_12);
> +       inst =3D adev->gfx.me.num_me * adev->gfx.me.num_pipe_per_me *
> +               adev->gfx.me.num_queue_per_pipe;
> +
> +       ptr =3D kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
> +       if (ptr =3D=3D NULL) {
> +               DRM_ERROR("Failed to allocate memory for GFX Queues IP Du=
mp\n");
> +               adev->gfx.ip_dump_gfx_queues =3D NULL;
> +       } else {
> +               adev->gfx.ip_dump_gfx_queues =3D ptr;
> +       }
>  }
>
>  static int gfx_v12_0_sw_init(void *handle)
> @@ -1462,6 +1504,7 @@ static int gfx_v12_0_sw_fini(void *handle)
>
>         kfree(adev->gfx.ip_dump_core);
>         kfree(adev->gfx.ip_dump_compute_queues);
> +       kfree(adev->gfx.ip_dump_gfx_queues);
>
>         return 0;
>  }
> @@ -4853,6 +4896,31 @@ static void gfx_v12_ip_print(void *handle, struct =
drm_printer *p)
>                         }
>                 }
>         }
> +
> +       /* print gfx queue registers for all instances */
> +       if (!adev->gfx.ip_dump_gfx_queues)
> +               return;
> +
> +       index =3D 0;
> +       reg_count =3D ARRAY_SIZE(gc_gfx_queue_reg_list_12);
> +       drm_printf(p, "\nnum_me: %d num_pipe: %d num_queue: %d\n",
> +                  adev->gfx.me.num_me,
> +                  adev->gfx.me.num_pipe_per_me,
> +                  adev->gfx.me.num_queue_per_pipe);
> +
> +       for (i =3D 0; i < adev->gfx.me.num_me; i++) {
> +               for (j =3D 0; j < adev->gfx.me.num_pipe_per_me; j++) {
> +                       for (k =3D 0; k < adev->gfx.me.num_queue_per_pipe=
; k++) {
> +                               drm_printf(p, "\nme %d, pipe %d, queue %d=
\n", i, j, k);
> +                               for (reg =3D 0; reg < reg_count; reg++) {
> +                                       drm_printf(p, "%-50s \t 0x%08x\n"=
,
> +                                                  gc_gfx_queue_reg_list_=
12[reg].reg_name,
> +                                                  adev->gfx.ip_dump_gfx_=
queues[index + reg]);
> +                               }
> +                               index +=3D reg_count;
> +                       }
> +               }
> +       }
>  }
>
>  static void gfx_v12_ip_dump(void *handle)
> @@ -4893,6 +4961,32 @@ static void gfx_v12_ip_dump(void *handle)
>         soc24_grbm_select(adev, 0, 0, 0, 0);
>         mutex_unlock(&adev->srbm_mutex);
>         amdgpu_gfx_off_ctrl(adev, true);
> +
> +       /* dump gfx queue registers for all instances */
> +       if (!adev->gfx.ip_dump_gfx_queues)
> +               return;
> +
> +       index =3D 0;
> +       reg_count =3D ARRAY_SIZE(gc_gfx_queue_reg_list_12);
> +       amdgpu_gfx_off_ctrl(adev, false);
> +       mutex_lock(&adev->srbm_mutex);
> +       for (i =3D 0; i < adev->gfx.me.num_me; i++) {
> +               for (j =3D 0; j < adev->gfx.me.num_pipe_per_me; j++) {
> +                       for (k =3D 0; k < adev->gfx.me.num_queue_per_pipe=
; k++) {
> +                               soc24_grbm_select(adev, i, j, k, 0);
> +
> +                               for (reg =3D 0; reg < reg_count; reg++) {
> +                                       adev->gfx.ip_dump_gfx_queues[inde=
x + reg] =3D
> +                                               RREG32(SOC15_REG_ENTRY_OF=
FSET(
> +                                                       gc_gfx_queue_reg_=
list_12[reg]));
> +                               }
> +                               index +=3D reg_count;
> +                       }
> +               }
> +       }
> +       soc24_grbm_select(adev, 0, 0, 0, 0);
> +       mutex_unlock(&adev->srbm_mutex);
> +       amdgpu_gfx_off_ctrl(adev, true);
>  }
>
>  static const struct amd_ip_funcs gfx_v12_0_ip_funcs =3D {
> --
> 2.34.1
>
