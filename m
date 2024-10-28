Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E63D3E2BA
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA67410E542;
	Mon, 28 Oct 2024 19:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HoDNif8t";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0DF010E542
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:44:24 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-20b533c6865so3939835ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730144664; x=1730749464; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WmEJ6tg+89xdOf5Vyi31v/5wU/7DLexORIxcc/Hw7hA=;
 b=HoDNif8toCBt1sni7mVu913ixJUExPB6C2syh6hl+duohI40+qntf9DfIRc4MWodgy
 7XOeL1o5MnOrRTzieUEcKOsG6InfosAeRaPvpgfDK/+RhNeeIHL5ABl6UYPI3Uvr3NbB
 +IAa+aFbuiToAiVtD4wtr1QMgdJmMn0PidrMWr0sfAgTQWnxYwavvZwyCfbPBINFmsaY
 Bwu7rAgRcFQ8ha3uzmD5k9I9GUClsAM5AAmn0bDJihvMepKmr8EwkSkYP424n4xoWseu
 pzHvuvLvNEf+6MxifgNXcilXN3ofjFmxShit5r7mk6CQMXZFAImAq/v/Ge5r12nIAkmY
 nxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730144664; x=1730749464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WmEJ6tg+89xdOf5Vyi31v/5wU/7DLexORIxcc/Hw7hA=;
 b=Q9wC3R2wg+P4P2APpopIKSzU1uO6v91IAGD52ZzU7hZVbVSBy8eQ7bvtQewnRFNvaP
 upHDdZSxpIAnIxl/RHWfPdhI/xZ+ipUd3DeKkWxHPSPkbC/4d+QYkpVgkllF4IOdXx5R
 j89tPaew5FmNp6DIHl5x+zjKuzAw43JYuNC/wj+DxZ/AAsS9b8IlXvEmLdKeTBYxL26R
 tRl59lm0oe5jAHr5LRbAS6kW961rf1OtklHPRC/ZDyiADSMF124X1+voy5qv/SD/7kQd
 CI1FmNkCUJWE23Tk2RC3E2U3WlXJ71dvmtjikUhUzmCB+gsVLv+OJdV9ko2vE+nS4fT6
 h8pw==
X-Gm-Message-State: AOJu0Yxeh/3Pj8xQu1CJu/WvxzIGzuOnoXCWDw8QvRMQ2qbdhvOEGpLl
 Gexg2jjreRz0QZolyJ2ZrY5Y+Dye+igJ/aMRcoS6X39E2zaLZ1X1JZ8Wxdx1MAGCI+BdYhGuVQH
 tHAbTgKLFh7T1c+i1yS53IUOWg3A=
X-Google-Smtp-Source: AGHT+IFwCq5UL2Dh/muDTN117Vt3Lg2n/TK/ppgieklrwoOlkHWKRnNqm4iBcrT4bW3OCS0jezmN4oUlZIxSg8ms9xo=
X-Received: by 2002:a05:6a21:32a8:b0:1d9:6ec9:30f2 with SMTP id
 adf61e73a8af0-1d9a83da994mr6841313637.6.1730144663912; Mon, 28 Oct 2024
 12:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-28-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-28-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:44:12 -0400
Message-ID: <CADnq5_PyJTBA1AMw_1S9_Ep9dr5BLYVgWr+u-k7GUYFpbDT88Q@mail.gmail.com>
Subject: Re: [PATCH 27/29] drm/amdgpu: set funcs for each vcn instance
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
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

On Thu, Oct 24, 2024 at 11:13=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Pass instance parameter to set_dec_ring_funcs(), set_enc_ring_funcs(),
> and set_irq_funcs(), and perform function setup ONLY for the given vcn
> instance, instead of for all vcn instances. Modify each vcn generation
> accordingly.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 59 +++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 62 +++++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 46 ++++++++----------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 31 ++++++-------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 36 ++++++--------
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 36 ++++++--------
>  6 files changed, 112 insertions(+), 158 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index 0d84cb4279e3..2e5888b905fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -92,9 +92,9 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_=
2_5[] =3D {
>         SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_DPG_PAUSE)
>  };
>
> -static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
> -static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
> -static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
> +static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev, int =
inst);
> +static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev, int =
inst);
> +static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev, int inst)=
;
>  static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_blo=
ck,
>                                 enum amd_powergating_state state);
>  static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
> @@ -139,9 +139,9 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block=
 *ip_block)
>                 adev->vcn.num_enc_rings =3D 2;
>         }
>
> -       vcn_v2_5_set_dec_ring_funcs(adev);
> -       vcn_v2_5_set_enc_ring_funcs(adev);
> -       vcn_v2_5_set_irq_funcs(adev);
> +       vcn_v2_5_set_dec_ring_funcs(adev, inst);
> +       vcn_v2_5_set_enc_ring_funcs(adev, inst);
> +       vcn_v2_5_set_irq_funcs(adev, inst);
>         vcn_v2_5_set_ras_funcs(adev);
>
>         return amdgpu_vcn_early_init(adev, inst);
> @@ -1737,29 +1737,25 @@ static const struct amdgpu_ring_funcs vcn_v2_5_en=
c_ring_vm_funcs =3D {
>         .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_=
helper,
>  };
>
> -static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
> +static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev, int =
inst)
>  {
> -       int i;
> +               if (adev->vcn.harvest_config & (1 << inst))
> +                       return;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> -               adev->vcn.inst[i].ring_dec.funcs =3D &vcn_v2_5_dec_ring_v=
m_funcs;
> -               adev->vcn.inst[i].ring_dec.me =3D i;
> -       }
> +               adev->vcn.inst[inst].ring_dec.funcs =3D &vcn_v2_5_dec_rin=
g_vm_funcs;
> +               adev->vcn.inst[inst].ring_dec.me =3D inst;
>  }
>
> -static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev)
> +static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev, int =
inst)
>  {
> -       int i, j;
> +       int i;
>
> -       for (j =3D 0; j < adev->vcn.num_vcn_inst; ++j) {
> -               if (adev->vcn.harvest_config & (1 << j))
> -                       continue;
> -               for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
> -                       adev->vcn.inst[j].ring_enc[i].funcs =3D &vcn_v2_5=
_enc_ring_vm_funcs;
> -                       adev->vcn.inst[j].ring_enc[i].me =3D j;
> -               }
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return;
> +
> +       for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
> +               adev->vcn.inst[inst].ring_enc[i].funcs =3D &vcn_v2_5_enc_=
ring_vm_funcs;
> +               adev->vcn.inst[inst].ring_enc[i].me =3D inst;
>         }
>  }
>
> @@ -1904,19 +1900,16 @@ static const struct amdgpu_irq_src_funcs vcn_v2_6=
_ras_irq_funcs =3D {
>         .process =3D amdgpu_vcn_process_poison_irq,
>  };
>
> -static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev)
> +static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev, int inst)
>  {
> -       int i;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> -               adev->vcn.inst[i].irq.num_types =3D adev->vcn.num_enc_rin=
gs + 1;
> -               adev->vcn.inst[i].irq.funcs =3D &vcn_v2_5_irq_funcs;
> +       adev->vcn.inst[inst].irq.num_types =3D adev->vcn.num_enc_rings + =
1;
> +       adev->vcn.inst[inst].irq.funcs =3D &vcn_v2_5_irq_funcs;
>
> -               adev->vcn.inst[i].ras_poison_irq.num_types =3D adev->vcn.=
num_enc_rings + 1;
> -               adev->vcn.inst[i].ras_poison_irq.funcs =3D &vcn_v2_6_ras_=
irq_funcs;
> -       }
> +       adev->vcn.inst[inst].ras_poison_irq.num_types =3D adev->vcn.num_e=
nc_rings + 1;
> +       adev->vcn.inst[inst].ras_poison_irq.funcs =3D &vcn_v2_6_ras_irq_f=
uncs;
>  }
>
>  static void vcn_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, st=
ruct drm_printer *p)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 03fc50b3aa05..0d1c1534db40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -102,9 +102,9 @@ static int amdgpu_ih_clientid_vcns[] =3D {
>  };
>
>  static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
> -static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
> -static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
> -static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
> +static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev, int =
inst);
> +static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev, int =
inst);
> +static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev, int inst)=
;
>  static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_blo=
ck,
>                         enum amd_powergating_state state);
>  static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
> @@ -144,9 +144,9 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block=
 *ip_block)
>                         adev->vcn.num_enc_rings =3D 2;
>         }
>
> -       vcn_v3_0_set_dec_ring_funcs(adev);
> -       vcn_v3_0_set_enc_ring_funcs(adev);
> -       vcn_v3_0_set_irq_funcs(adev);
> +       vcn_v3_0_set_dec_ring_funcs(adev, inst);
> +       vcn_v3_0_set_enc_ring_funcs(adev, inst);
> +       vcn_v3_0_set_irq_funcs(adev, inst);
>
>         return amdgpu_vcn_early_init(adev, inst);
>  }
> @@ -2062,34 +2062,28 @@ static const struct amdgpu_ring_funcs vcn_v3_0_en=
c_ring_vm_funcs =3D {
>         .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_=
helper,
>  };
>
> -static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
> +static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev, int =
inst)
>  {
> -       int i;
> -
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return;
>
> -               if (!DEC_SW_RING_ENABLED)
> -                       adev->vcn.inst[i].ring_dec.funcs =3D &vcn_v3_0_de=
c_ring_vm_funcs;
> -               else
> -                       adev->vcn.inst[i].ring_dec.funcs =3D &vcn_v3_0_de=
c_sw_ring_vm_funcs;
> -               adev->vcn.inst[i].ring_dec.me =3D i;
> -       }
> +       if (!DEC_SW_RING_ENABLED)
> +               adev->vcn.inst[inst].ring_dec.funcs =3D &vcn_v3_0_dec_rin=
g_vm_funcs;
> +       else
> +               adev->vcn.inst[inst].ring_dec.funcs =3D &vcn_v3_0_dec_sw_=
ring_vm_funcs;
> +       adev->vcn.inst[inst].ring_dec.me =3D inst;
>  }
>
> -static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev)
> +static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev, int =
inst)
>  {
> -       int i, j;
> +       int j;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return;
>
> -               for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
> -                       adev->vcn.inst[i].ring_enc[j].funcs =3D &vcn_v3_0=
_enc_ring_vm_funcs;
> -                       adev->vcn.inst[i].ring_enc[j].me =3D i;
> -               }
> +       for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
> +               adev->vcn.inst[inst].ring_enc[j].funcs =3D &vcn_v3_0_enc_=
ring_vm_funcs;
> +               adev->vcn.inst[inst].ring_enc[j].me =3D inst;
>         }
>  }
>
> @@ -2231,17 +2225,13 @@ static const struct amdgpu_irq_src_funcs vcn_v3_0=
_irq_funcs =3D {
>         .process =3D vcn_v3_0_process_interrupt,
>  };
>
> -static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev)
> +static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
>  {
> -       int i;
> -
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return;
>
> -               adev->vcn.inst[i].irq.num_types =3D adev->vcn.num_enc_rin=
gs + 1;
> -               adev->vcn.inst[i].irq.funcs =3D &vcn_v3_0_irq_funcs;
> -       }
> +       adev->vcn.inst[inst].irq.num_types =3D adev->vcn.num_enc_rings + =
1;
> +       adev->vcn.inst[inst].irq.funcs =3D &vcn_v3_0_irq_funcs;
>  }
>
>  static void vcn_v3_0_print_ip_state(struct amdgpu_ip_block *ip_block, st=
ruct drm_printer *p)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index c52ed8166d9d..e9a8e027d5f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -94,8 +94,8 @@ static int amdgpu_ih_clientid_vcns[] =3D {
>  };
>
>  static int vcn_v4_0_start_sriov(struct amdgpu_device *adev);
> -static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
> -static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
> +static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev, =
int inst);
> +static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev, int inst)=
;
>  static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_blo=
ck,
>          enum amd_powergating_state state);
>  static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
> @@ -127,8 +127,8 @@ static int vcn_v4_0_early_init(struct amdgpu_ip_block=
 *ip_block)
>         /* re-use enc ring as unified ring */
>         adev->vcn.num_enc_rings =3D 1;
>
> -       vcn_v4_0_set_unified_ring_funcs(adev);
> -       vcn_v4_0_set_irq_funcs(adev);
> +       vcn_v4_0_set_unified_ring_funcs(adev, inst);
> +       vcn_v4_0_set_irq_funcs(adev, inst);
>         vcn_v4_0_set_ras_funcs(adev);
>
>         return amdgpu_vcn_early_init(adev, inst);
> @@ -1923,21 +1923,17 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_=
ring_vm_funcs =3D {
>   *
>   * Set unified ring functions
>   */
> -static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev)
> +static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev, =
int inst)
>  {
> -       int i;
> -
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return;
>
> -               if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSIO=
N(4, 0, 2))
> -                       vcn_v4_0_unified_ring_vm_funcs.secure_submission_=
supported =3D true;
> +       if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(4, 0, =
2))
> +               vcn_v4_0_unified_ring_vm_funcs.secure_submission_supporte=
d =3D true;
>
> -               adev->vcn.inst[i].ring_enc[0].funcs =3D
> -                      (const struct amdgpu_ring_funcs *)&vcn_v4_0_unifie=
d_ring_vm_funcs;
> -               adev->vcn.inst[i].ring_enc[0].me =3D i;
> -       }
> +       adev->vcn.inst[inst].ring_enc[0].funcs =3D
> +                  (const struct amdgpu_ring_funcs *)&vcn_v4_0_unified_ri=
ng_vm_funcs;
> +       adev->vcn.inst[inst].ring_enc[0].me =3D inst;
>  }
>
>  /**
> @@ -2135,20 +2131,16 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0=
_ras_irq_funcs =3D {
>   *
>   * Set VCN block interrupt irq functions
>   */
> -static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev)
> +static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev, int inst)
>  {
> -       int i;
> -
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return;
>
> -               adev->vcn.inst[i].irq.num_types =3D adev->vcn.num_enc_rin=
gs + 1;
> -               adev->vcn.inst[i].irq.funcs =3D &vcn_v4_0_irq_funcs;
> +       adev->vcn.inst[inst].irq.num_types =3D adev->vcn.num_enc_rings + =
1;
> +       adev->vcn.inst[inst].irq.funcs =3D &vcn_v4_0_irq_funcs;
>
> -               adev->vcn.inst[i].ras_poison_irq.num_types =3D adev->vcn.=
num_enc_rings + 1;
> -               adev->vcn.inst[i].ras_poison_irq.funcs =3D &vcn_v4_0_ras_=
irq_funcs;
> -       }
> +       adev->vcn.inst[inst].ras_poison_irq.num_types =3D adev->vcn.num_e=
nc_rings + 1;
> +       adev->vcn.inst[inst].ras_poison_irq.funcs =3D &vcn_v4_0_ras_irq_f=
uncs;
>  }
>
>  static void vcn_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, st=
ruct drm_printer *p)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 2468a5e409c1..716bc85141cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -85,8 +85,8 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_=
4_0_3[] =3D {
>                 (offset & 0x1FFFF)
>
>  static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
> -static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev=
);
> -static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
> +static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev=
, int inst);
> +static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, int ins=
t);
>  static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_b=
lock,
>                 enum amd_powergating_state state);
>  static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
> @@ -110,8 +110,8 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_blo=
ck *ip_block)
>         /* re-use enc ring as unified ring */
>         adev->vcn.num_enc_rings =3D 1;
>
> -       vcn_v4_0_3_set_unified_ring_funcs(adev);
> -       vcn_v4_0_3_set_irq_funcs(adev);
> +       vcn_v4_0_3_set_unified_ring_funcs(adev, inst);
> +       vcn_v4_0_3_set_irq_funcs(adev, inst);
>         vcn_v4_0_3_set_ras_funcs(adev);
>
>         return amdgpu_vcn_early_init(adev, inst);
> @@ -1525,17 +1525,15 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_=
unified_ring_vm_funcs =3D {
>   *
>   * Set unified ring functions
>   */
> -static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev=
)
> +static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev=
, int inst)
>  {
> -       int i, vcn_inst;
> +       int vcn_inst;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               adev->vcn.inst[i].ring_enc[0].funcs =3D &vcn_v4_0_3_unifi=
ed_ring_vm_funcs;
> -               adev->vcn.inst[i].ring_enc[0].me =3D i;
> -               vcn_inst =3D GET_INST(VCN, i);
> -               adev->vcn.inst[i].aid_id =3D
> -                       vcn_inst / adev->vcn.num_inst_per_aid;
> -       }
> +       adev->vcn.inst[inst].ring_enc[0].funcs =3D &vcn_v4_0_3_unified_ri=
ng_vm_funcs;
> +       adev->vcn.inst[inst].ring_enc[0].me =3D inst;
> +       vcn_inst =3D GET_INST(VCN, inst);
> +       adev->vcn.inst[inst].aid_id =3D
> +               vcn_inst / adev->vcn.num_inst_per_aid;
>  }
>
>  /**
> @@ -1718,13 +1716,10 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0=
_3_irq_funcs =3D {
>   *
>   * Set VCN block interrupt irq functions
>   */
> -static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
> +static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, int ins=
t)
>  {
> -       int i;
> +       adev->vcn.inst->irq.num_types++;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               adev->vcn.inst->irq.num_types++;
> -       }
>         adev->vcn.inst->irq.funcs =3D &vcn_v4_0_3_irq_funcs;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index f43604d7fb1a..b74b2c0942c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -93,8 +93,8 @@ static int amdgpu_ih_clientid_vcns[] =3D {
>         SOC15_IH_CLIENTID_VCN1
>  };
>
> -static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev=
);
> -static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
> +static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev=
, int inst);
> +static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev, int ins=
t);
>  static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_b=
lock,
>                 enum amd_powergating_state state);
>  static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev,
> @@ -116,8 +116,8 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_blo=
ck *ip_block)
>
>         /* re-use enc ring as unified ring */
>         adev->vcn.num_enc_rings =3D 1;
> -       vcn_v4_0_5_set_unified_ring_funcs(adev);
> -       vcn_v4_0_5_set_irq_funcs(adev);
> +       vcn_v4_0_5_set_unified_ring_funcs(adev, inst);
> +       vcn_v4_0_5_set_irq_funcs(adev, inst);
>
>         return amdgpu_vcn_early_init(adev, inst);
>  }
> @@ -1424,17 +1424,13 @@ static const struct amdgpu_ring_funcs vcn_v4_0_5_=
unified_ring_vm_funcs =3D {
>   *
>   * Set unified ring functions
>   */
> -static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev=
)
> +static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev=
, int inst)
>  {
> -       int i;
> -
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return;
>
> -               adev->vcn.inst[i].ring_enc[0].funcs =3D &vcn_v4_0_5_unifi=
ed_ring_vm_funcs;
> -               adev->vcn.inst[i].ring_enc[0].me =3D i;
> -       }
> +       adev->vcn.inst[inst].ring_enc[0].funcs =3D &vcn_v4_0_5_unified_ri=
ng_vm_funcs;
> +       adev->vcn.inst[inst].ring_enc[0].me =3D inst;
>  }
>
>  /**
> @@ -1599,17 +1595,13 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0=
_5_irq_funcs =3D {
>   *
>   * Set VCN block interrupt irq functions
>   */
> -static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev)
> +static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev, int ins=
t)
>  {
> -       int i;
> -
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return;
>
> -               adev->vcn.inst[i].irq.num_types =3D adev->vcn.num_enc_rin=
gs + 1;
> -               adev->vcn.inst[i].irq.funcs =3D &vcn_v4_0_5_irq_funcs;
> -       }
> +       adev->vcn.inst[inst].irq.num_types =3D adev->vcn.num_enc_rings + =
1;
> +       adev->vcn.inst[inst].irq.funcs =3D &vcn_v4_0_5_irq_funcs;
>  }
>
>  static void vcn_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, =
struct drm_printer *p)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index d61428c75c88..3fbc2aafcd29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -76,8 +76,8 @@ static int amdgpu_ih_clientid_vcns[] =3D {
>         SOC15_IH_CLIENTID_VCN1
>  };
>
> -static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev=
);
> -static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
> +static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev=
, int inst);
> +static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev, int ins=
t);
>  static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_b=
lock,
>                 enum amd_powergating_state state);
>  static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
> @@ -100,8 +100,8 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_blo=
ck *ip_block)
>         /* re-use enc ring as unified ring */
>         adev->vcn.num_enc_rings =3D 1;
>
> -       vcn_v5_0_0_set_unified_ring_funcs(adev);
> -       vcn_v5_0_0_set_irq_funcs(adev);
> +       vcn_v5_0_0_set_unified_ring_funcs(adev, inst);
> +       vcn_v5_0_0_set_irq_funcs(adev, inst);
>
>         return amdgpu_vcn_early_init(adev, inst);
>  }
> @@ -1151,17 +1151,13 @@ static const struct amdgpu_ring_funcs vcn_v5_0_0_=
unified_ring_vm_funcs =3D {
>   *
>   * Set unified ring functions
>   */
> -static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev=
)
> +static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev=
, int inst)
>  {
> -       int i;
> -
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return;
>
> -               adev->vcn.inst[i].ring_enc[0].funcs =3D &vcn_v5_0_0_unifi=
ed_ring_vm_funcs;
> -               adev->vcn.inst[i].ring_enc[0].me =3D i;
> -       }
> +       adev->vcn.inst[inst].ring_enc[0].funcs =3D &vcn_v5_0_0_unified_ri=
ng_vm_funcs;
> +       adev->vcn.inst[inst].ring_enc[0].me =3D inst;
>  }
>
>  /**
> @@ -1326,17 +1322,13 @@ static const struct amdgpu_irq_src_funcs vcn_v5_0=
_0_irq_funcs =3D {
>   *
>   * Set VCN block interrupt irq functions
>   */
> -static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev)
> +static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev, int ins=
t)
>  {
> -       int i;
> -
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return;
>
> -               adev->vcn.inst[i].irq.num_types =3D adev->vcn.num_enc_rin=
gs + 1;
> -               adev->vcn.inst[i].irq.funcs =3D &vcn_v5_0_0_irq_funcs;
> -       }
> +       adev->vcn.inst[inst].irq.num_types =3D adev->vcn.num_enc_rings + =
1;
> +       adev->vcn.inst[inst].irq.funcs =3D &vcn_v5_0_0_irq_funcs;
>  }
>
>  static void vcn_v5_0_print_ip_state(struct amdgpu_ip_block *ip_block, st=
ruct drm_printer *p)
> --
> 2.34.1
>
