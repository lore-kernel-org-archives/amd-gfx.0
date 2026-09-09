Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B39C79FB7
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 20:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF6F310EA23;
	Wed,  9 Sep 2026 20:38:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UV+yoxql";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36AC510EA23
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 20:38:20 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 ada2fe7eead31-783249c8d82so203078137.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Sep 2026 13:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788986299; cv=none;
 d=google.com; s=arc-20260327;
 b=k0rbEtFdQ7W4t+CW12FXTsta7z6i5Z7yYWS70rhHV1+RyqJB5kpjAJVfvzhh+SC+qL
 tmLu1rr+z4GwZIhe+jnw8xPtbfjq931VgvyPPirmGp/+ZmKqbHC/b53qGW9dZbhwfPLq
 fy//lLN9m6G/rFR4wo3Odtlh5S80pRJvub71Oe6dnSWaqWxAo46/WCOJFq4IDBAMbjQo
 bg/21detnyOX4o5q15IAibgVqrgJoLD/nDflcXoqOkNbIEgULdtZvY7IY6Ckv1X7rOFV
 H8WmmnwQQSrblKbhKGqUStgCggjf33wi7k7gTtJcl84j7xhJaDlMjX0whVr8DJX6Erlv
 5lZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lEECfjC917gj6nW+pTb2FJ9aHFg02GqG3z060dnF27c=;
 fh=MPehFUqdEzuDjbYJHO5yXRWKIRbzFnx3ovQH7ElPDfM=;
 b=J245sZAzhOQurwtIDcscFu0x+go7FOnOQolqNhL6punGeJDpHuR+oY1x7YxuOe23LU
 alNN7wrR5yVttCiQT9CQizihPdqF+RtsaH20NsTcaYzSWtbbkPjOMW1nfvGtow2S7032
 yik9fJTJNiUv/SHi/caQhEhbr7WZ3DhnEfBOQHndDFVWSiNlqI7x1bONmGkxkSRmKI7Y
 +lqLEmgXzpeYfLzV7DCLPKf8u/9mG2H2yjezXz4r/6dFfoczGFinnYfbp3elr/keuwJ+
 +T4Fln3jJlZPYm/gfMMKnHA3E9EsSxLKpARsCL0Wuk8eaGQ2KXGr9ZGJpKNZxmeM52uD
 Oe1w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788986299; x=1789591099; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lEECfjC917gj6nW+pTb2FJ9aHFg02GqG3z060dnF27c=;
 b=UV+yoxql2hTJrZOCb8TmMKuaSKs9hom5TKBxPULlJ0STCwz6Mm5ZaATc/LjiJ35TFE
 2lCVJjY1e6OizXHpY0SA/NgU/J4C4v+71g0MXXu5XL2mUJKWhVaiHwaqhBVH2MPUwvXH
 G03Kb9N6hWAeEYXsN/ZIYvvhUkdUfqwX/TViGWVMXCddDgJIso1zq4rDH1ZtGFcaU72q
 uGadq9WeVUiUVzoYMOe3rn+dyLuTwDmKrim8dDeA9vUv6mrdvTvtRbOc2nTywbzzVqZC
 1hQLdhh3Cd8PFlCc2rXnBoqKT9c+bbEVNafIhRGhdlhrD8vX+3b08VhdGG2OGhEhMe31
 r5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788986299; x=1789591099;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lEECfjC917gj6nW+pTb2FJ9aHFg02GqG3z060dnF27c=;
 b=ZpzMP2wyVneJ6eM6yYQ2dT3ZJprF0GrWOJHf/xOktsG7vogMsmKRB4tB3HOBLwIyGR
 tMRMiWOC3Llko16IZ0XKm1QBUyy/hXtGariZRD6CoosnFHkMbCSlIh0maiaq+jpX65Md
 Fd4cw8TOY8yyMQg4tqa3MOm7AjYIMoTcd6S1xBBNNV0sQ77BoptT7RLf0vqSP8di6Kpb
 6FaQ5iV09Lb8JoWaBsfjL7z/xLetea6gAP6MkraIeB71mOaxJ0AfHqme7BqMJ2I7uNOL
 6YT9oIatTmufNdf9XSN+HrVU8um6ADowLLNUwxGJa95rap8YNo1sat/pmFGLjpF7vXdQ
 BRvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByydGh2M0UNKrNY/zzmZsSvaBkuStHzrsKP8IvlDgP44Z40lozu2TyFwbGtHh4hcJIUtr/vDog1@lists.freedesktop.org
X-Gm-Message-State: AFuF++kRApkBGGuLl/+ikkp3J04br8YqPlMHoOepQ6704fF/XiFRLrLn
 TT6I4qQSKfHZSeKqJMSIg2WQC5hEjxALRXzlZFUxz6NzaHqAL3sIX9L/o7IPNW/968LWf/Npf5M
 mN1tTYcj3KDzimRpuF1SbP7SGg/7pyR4=
X-Gm-Gg: AYBFou2AGaM8xlkRLT3mnyldik9K3jnyk45+3zJQ4rHQADFQTMBNbD9sIaE604EYgqF
 F+rLB4OMBkzrv61zFJFIrZ/TXRf6Kc7YQOi3jaV9ERM7WulGw9zQbGaKrOu7sWpP3GAfFo0F5HY
 oOZxypaH96mEe3MrT59iFv4Aghg3wKi0SiUNxkwJnWXs2e1GY97HqfOLkP5IRyRJ8NGIoZ0e2+p
 Atoe+SvxqF01PJ7PkPE5vL4r2nGsCawY08qG2U/6C08j77arCxUfTFog59WMh7uJauCrHaRI7t6
 CJBQP5zXcEd322YqkQlj8XwaxBekA9rSnQy7+PjRjksk28TIjcEjizJ5QDp76amNAgpVOeCm0xg
 fPNuAuOLgopDSdVOa09vbK6a3wdWdMBKMiaSfCz58vlhO0txqY69C
X-Received: by 2002:a05:6102:508e:b0:786:d38d:f7c2 with SMTP id
 ada2fe7eead31-78a60ee3f0bmr5162096137.1.1788986298627; Wed, 09 Sep 2026
 13:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
 <20260905081935.338775-3-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260905081935.338775-3-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Sep 2026 16:38:05 -0400
X-Gm-Features: AcwNN1VYzATSaRr1bY6EjH1KvHGoXR-Gtpy6oWV6ief2niRAGwydFcIHJDkmq4c
Message-ID: <CADnq5_PiRvdDU3cz58AgqeMQFYWqB9hExvVGbYW4qzROXi_MKw@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Implement kernel VMID SQ_SHADER_TBA/TMA
 programming for GFX10/11/12
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Lijo Lazar <lijo.lazar@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>
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

On Sat, Sep 5, 2026 at 5:15=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Implement the program_kernel_trap_vmids() vmhub callback for all
> supported hardware generations. Each implementation programs
> SQ_SHADER_TBA/TMA for kernel queue VMIDs (1..first_kfd_vmid-1)
> via SRBM select.
>
> TBA points to the device-level CWSR ISA BO =E2=80=94 same binary for all =
VMIDs.
> TMA is set to AMDGPU_VA_RESERVED_TRAP_START, the fixed virtual address
> where each VM's kq_tma_bo is mapped. The hardware resolves this VA
> through the active VMID's page tables, giving each process its own
> physical TMA buffer without requiring per-submission register updates.
>
> User queue VMIDs (first_kfd_vmid..15) must not be touched here =E2=80=94 =
they
> are programmed by MES via the ADD_QUEUE packet's trap_handler_addr field.
>
> The function is called at two points:
>   1. amdgpu_trap_init()     =E2=80=94 first boot, after ISA BO is ready
>   2. setup_vmid_config()    =E2=80=94 GPU resume, after GART is restored
>
> GFX versions covered:
>   GFX10   (gfxhub_v2_0):    mm-prefixed registers, single XCC
>   GFX11   (gfxhub_v3_0):    reg-prefixed registers, single XCC
>   GFX11.5 (gfxhub_v11_5_0): reg-prefixed registers, single XCC
>   GFX12   (gfxhub_v12_0):   reg-prefixed registers, single XCC
>   GFX12.1 (gfxhub_v12_1):   reg-prefixed registers, multi-XCC
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Suggested-by: Alexander Deucher <alexander.deucher@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Cc: Samuel Pitoiset <hakzsam@gmail.com>
> Cc: Natalie Vock <natalie.vock@gmx.de>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Change-Id: I2fa05a8ac96e5fe4b6e5f79dbdf62f32b8dbf96f
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 38 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 38 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 36 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 38 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 33 ++++++++++++++++++
>  5 files changed, 183 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/dr=
m/amd/amdgpu/gfxhub_v11_5_0.c
> index 652eea6eae4a..b6f43c8274d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
> @@ -22,6 +22,7 @@
>   */
>
>  #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>  #include "gfxhub_v11_5_0.h"
>
>  #include "gc/gc_11_5_0_offset.h"
> @@ -290,6 +291,39 @@ static void gfxhub_v11_5_0_disable_identity_aperture=
(struct amdgpu_device *adev)
>
>  }
>
> +/*
> + * MES owns kernel VMIDs but does not program trap handler registers.
> + * Program SQ_SHADER_TBA/TMA directly via SRBM select so the first-level
> + * CWSR handler is active for kernel queue VMIDs.
> + */
> +static void gfxhub_v11_5_0_program_kernel_trap_vmids(struct amdgpu_devic=
e *adev)

I'd suggest renaming it to something like
program_kernel_trap_tba_tma() since it's not really programming the
vmids, they just happen to be per vmid.

> +{
> +       u64 tba_addr =3D amdgpu_bo_gpu_offset(adev->trap_info->isa_bo);
> +       u64 tma_addr =3D AMDGPU_VA_RESERVED_TRAP_START(adev);
> +       int i;
> +
> +       if (!adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
> +               return;
> +
> +       WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +
> +       mutex_lock(&adev->srbm_mutex);
> +       for (i =3D 1; i < adev->vm_manager.first_kfd_vmid; i++) {
> +               amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, i, 0);
> +               WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
> +                            lower_32_bits(tba_addr >> 8));
> +               WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
> +                            upper_32_bits(tba_addr >> 8) |
> +                            (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));

If we set the enable bit, we need to make sure trap handler is valid
for each vmid.

> +               WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
> +                            lower_32_bits(tma_addr >> 8));
> +               WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
> +                            upper_32_bits(tma_addr >> 8));
> +       }
> +       amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +       mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
>  {
>         struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -337,6 +371,9 @@ static void gfxhub_v11_5_0_setup_vmid_config(struct a=
mdgpu_device *adev)
>         }
>
>         hub->vm_cntx_cntl =3D tmp;
> +
> +       if (amdgpu_trap_is_enabled(adev))
> +               gfxhub_v11_5_0_program_kernel_trap_vmids(adev);
>  }
>
>  static void gfxhub_v11_5_0_program_invalidation(struct amdgpu_device *ad=
ev)
> @@ -459,6 +496,7 @@ static void gfxhub_v11_5_0_set_fault_enable_default(s=
truct amdgpu_device *adev,
>  static const struct amdgpu_vmhub_funcs gfxhub_v11_5_0_vmhub_funcs =3D {
>         .print_l2_protection_fault_status =3D gfxhub_v11_5_0_print_l2_pro=
tection_fault_status,
>         .get_invalidate_req =3D gfxhub_v11_5_0_get_invalidate_req,
> +       .program_kernel_trap_vmids =3D gfxhub_v11_5_0_program_kernel_trap=
_vmids,

What do we need the callback for?

Alex

>  };
>
>  static void gfxhub_v11_5_0_init(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfxhub_v12_0.c
> index 6cbf837d50dd..5b2f0f59b895 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> @@ -22,6 +22,7 @@
>   */
>
>  #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>  #include "gfxhub_v12_0.h"
>
>  #include "gc/gc_12_0_0_offset.h"
> @@ -295,6 +296,39 @@ static void gfxhub_v12_0_disable_identity_aperture(s=
truct amdgpu_device *adev)
>
>  }
>
> +/*
> + * MES owns kernel VMIDs but does not program trap handler registers.
> + * Program SQ_SHADER_TBA/TMA directly via SRBM select so the first-level
> + * CWSR handler is active for kernel queue VMIDs.
> + */
> +static void gfxhub_v12_0_program_kernel_trap_vmids(struct amdgpu_device =
*adev)
> +{
> +       u64 tba_addr =3D amdgpu_bo_gpu_offset(adev->trap_info->isa_bo);
> +       u64 tma_addr =3D AMDGPU_VA_RESERVED_TRAP_START(adev);
> +       int i;
> +
> +       if (!adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
> +               return;
> +
> +       WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +
> +       mutex_lock(&adev->srbm_mutex);
> +       for (i =3D 1; i < adev->vm_manager.first_kfd_vmid; i++) {
> +               amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, i, 0);
> +               WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
> +                            lower_32_bits(tba_addr >> 8));
> +               WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
> +                            upper_32_bits(tba_addr >> 8) |
> +                            (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +               WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
> +                            lower_32_bits(tma_addr >> 8));
> +               WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
> +                            upper_32_bits(tma_addr >> 8));
> +       }
> +       amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +       mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v12_0_setup_vmid_config(struct amdgpu_device *adev)
>  {
>         struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -342,6 +376,9 @@ static void gfxhub_v12_0_setup_vmid_config(struct amd=
gpu_device *adev)
>         }
>
>         hub->vm_cntx_cntl =3D tmp;
> +
> +       if (amdgpu_trap_is_enabled(adev))
> +               gfxhub_v12_0_program_kernel_trap_vmids(adev);
>  }
>
>  static void gfxhub_v12_0_program_invalidation(struct amdgpu_device *adev=
)
> @@ -464,6 +501,7 @@ static void gfxhub_v12_0_set_fault_enable_default(str=
uct amdgpu_device *adev,
>  static const struct amdgpu_vmhub_funcs gfxhub_v12_0_vmhub_funcs =3D {
>         .print_l2_protection_fault_status =3D gfxhub_v12_0_print_l2_prote=
ction_fault_status,
>         .get_invalidate_req =3D gfxhub_v12_0_get_invalidate_req,
> +       .program_kernel_trap_vmids =3D gfxhub_v12_0_program_kernel_trap_v=
mids,
>  };
>
>  static void gfxhub_v12_0_init(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/=
amd/amdgpu/gfxhub_v12_1.c
> index 4c2fd1e6616e..528917913950 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> @@ -21,6 +21,7 @@
>   *
>   */
>  #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>  #include "amdgpu_xcp.h"
>  #include "gfxhub_v12_1.h"
>
> @@ -406,6 +407,37 @@ static void gfxhub_v12_1_xcc_disable_identity_apertu=
re(struct amdgpu_device *ade
>         }
>  }
>
> +static void gfxhub_v12_1_program_kernel_trap_vmids(struct amdgpu_device =
*adev)
> +{
> +       u64 tba_addr =3D amdgpu_bo_gpu_offset(adev->trap_info->isa_bo);
> +       u64 tma_addr =3D AMDGPU_VA_RESERVED_TRAP_START(adev);
> +       u32 xcc_mask =3D GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
> +       int i, j;
> +
> +       if (!adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
> +               return;
> +
> +       WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +
> +       for_each_inst(j, xcc_mask) {
> +               mutex_lock(&adev->srbm_mutex);
> +               for (i =3D 1; i < adev->vm_manager.first_kfd_vmid; i++) {
> +                       amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, i, j);
> +                       WREG32_SOC15(GC, GET_INST(GC, j), regSQ_SHADER_TB=
A_LO,
> +                                    lower_32_bits(tba_addr >> 8));
> +                       WREG32_SOC15(GC, GET_INST(GC, j), regSQ_SHADER_TB=
A_HI,
> +                                    upper_32_bits(tba_addr >> 8) |
> +                                    (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHI=
FT));
> +                       WREG32_SOC15(GC, GET_INST(GC, j), regSQ_SHADER_TM=
A_LO,
> +                                    lower_32_bits(tma_addr >> 8));
> +                       WREG32_SOC15(GC, GET_INST(GC, j), regSQ_SHADER_TM=
A_HI,
> +                                    upper_32_bits(tma_addr >> 8));
> +               }
> +               amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, j);
> +               mutex_unlock(&adev->srbm_mutex);
> +       }
> +}
> +
>  static void gfxhub_v12_1_xcc_setup_vmid_config(struct amdgpu_device *ade=
v,
>                                                uint32_t xcc_mask)
>  {
> @@ -468,6 +500,9 @@ static void gfxhub_v12_1_xcc_setup_vmid_config(struct=
 amdgpu_device *adev,
>
>                 hub->vm_cntx_cntl =3D tmp;
>         }
> +
> +       if (amdgpu_trap_is_enabled(adev))
> +               gfxhub_v12_1_program_kernel_trap_vmids(adev);
>  }
>
>  static void gfxhub_v12_1_xcc_program_invalidation(struct amdgpu_device *=
adev,
> @@ -751,6 +786,7 @@ static void gfxhub_v12_1_print_l2_protection_fault_st=
atus(struct amdgpu_device *
>  static const struct amdgpu_vmhub_funcs gfxhub_v12_1_vmhub_funcs =3D {
>         .print_l2_protection_fault_status =3D gfxhub_v12_1_print_l2_prote=
ction_fault_status,
>         .get_invalidate_req =3D gfxhub_v12_1_get_invalidate_req,
> +       .program_kernel_trap_vmids =3D gfxhub_v12_1_program_kernel_trap_v=
mids,
>  };
>
>  static void gfxhub_v12_1_xcc_init(struct amdgpu_device *adev, uint32_t x=
cc_mask)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v2_0.c
> index 9ea593e2c719..47a25df2a0c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -22,6 +22,7 @@
>   */
>
>  #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>  #include "gfxhub_v2_0.h"
>
>  #include "gc/gc_10_1_0_offset.h"
> @@ -280,6 +281,39 @@ static void gfxhub_v2_0_disable_identity_aperture(st=
ruct amdgpu_device *adev)
>
>  }
>
> +/*
> + * MES owns kernel VMIDs but does not program trap handler registers.
> + * Program SQ_SHADER_TBA/TMA directly via SRBM select so the first-level
> + * CWSR handler is active for kernel queue VMIDs.
> + */
> +static void gfxhub_v2_0_program_kernel_trap_vmids(struct amdgpu_device *=
adev)
> +{
> +       u64 tba_addr =3D amdgpu_bo_gpu_offset(adev->trap_info->isa_bo);
> +       u64 tma_addr =3D AMDGPU_VA_RESERVED_TRAP_START(adev);
> +       int i;
> +
> +       if (!adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
> +               return;
> +
> +       WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +
> +       mutex_lock(&adev->srbm_mutex);
> +       for (i =3D 1; i < adev->vm_manager.first_kfd_vmid; i++) {
> +               amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, i, 0);
> +               WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_LO,
> +                            lower_32_bits(tba_addr >> 8));
> +               WREG32_SOC15(GC, 0, mmSQ_SHADER_TBA_HI,
> +                            upper_32_bits(tba_addr >> 8) |
> +                            (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +               WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_LO,
> +                            lower_32_bits(tma_addr >> 8));
> +               WREG32_SOC15(GC, 0, mmSQ_SHADER_TMA_HI,
> +                            upper_32_bits(tma_addr >> 8));
> +       }
> +       amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +       mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
>  {
>         struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -327,6 +361,9 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdg=
pu_device *adev)
>         }
>
>         hub->vm_cntx_cntl =3D tmp;
> +
> +       if (amdgpu_trap_is_enabled(adev))
> +               gfxhub_v2_0_program_kernel_trap_vmids(adev);
>  }
>
>  static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
> @@ -428,6 +465,7 @@ static void gfxhub_v2_0_set_fault_enable_default(stru=
ct amdgpu_device *adev,
>  static const struct amdgpu_vmhub_funcs gfxhub_v2_0_vmhub_funcs =3D {
>         .print_l2_protection_fault_status =3D gfxhub_v2_0_print_l2_protec=
tion_fault_status,
>         .get_invalidate_req =3D gfxhub_v2_0_get_invalidate_req,
> +       .program_kernel_trap_vmids =3D gfxhub_v2_0_program_kernel_trap_vm=
ids,
>  };
>
>  static void gfxhub_v2_0_init(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v3_0.c
> index 9e6a6e13dec0..2f59de6e9407 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> @@ -22,6 +22,7 @@
>   */
>
>  #include "amdgpu.h"
> +#include "amdgpu_trap.h"
>  #include "gfxhub_v3_0.h"
>
>  #include "gc/gc_11_0_0_offset.h"
> @@ -287,6 +288,34 @@ static void gfxhub_v3_0_disable_identity_aperture(st=
ruct amdgpu_device *adev)
>
>  }
>
> +static void gfxhub_v3_0_program_kernel_trap_vmids(struct amdgpu_device *=
adev)
> +{
> +       u64 tba_addr =3D amdgpu_bo_gpu_offset(adev->trap_info->isa_bo);
> +       u64 tma_addr =3D AMDGPU_VA_RESERVED_TRAP_START(adev);
> +       int i;
> +
> +       if (!adev->gfx.funcs || !adev->gfx.funcs->select_me_pipe_q)
> +               return;
> +
> +       WARN_ON(!IS_ALIGNED(tba_addr, 256));
> +
> +       mutex_lock(&adev->srbm_mutex);
> +       for (i =3D 1; i < adev->vm_manager.first_kfd_vmid; i++) {
> +               amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, i, 0);
> +               WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_LO,
> +                            lower_32_bits(tba_addr >> 8));
> +               WREG32_SOC15(GC, 0, regSQ_SHADER_TBA_HI,
> +                            upper_32_bits(tba_addr >> 8) |
> +                            (1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
> +               WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_LO,
> +                            lower_32_bits(tma_addr >> 8));
> +               WREG32_SOC15(GC, 0, regSQ_SHADER_TMA_HI,
> +                            upper_32_bits(tma_addr >> 8));
> +       }
> +       amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> +       mutex_unlock(&adev->srbm_mutex);
> +}
> +
>  static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
>  {
>         struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_GFXHUB(0)];
> @@ -334,6 +363,9 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdg=
pu_device *adev)
>         }
>
>         hub->vm_cntx_cntl =3D tmp;
> +
> +       if (amdgpu_trap_is_enabled(adev))
> +               gfxhub_v3_0_program_kernel_trap_vmids(adev);
>  }
>
>  static void gfxhub_v3_0_program_invalidation(struct amdgpu_device *adev)
> @@ -456,6 +488,7 @@ static void gfxhub_v3_0_set_fault_enable_default(stru=
ct amdgpu_device *adev,
>  static const struct amdgpu_vmhub_funcs gfxhub_v3_0_vmhub_funcs =3D {
>         .print_l2_protection_fault_status =3D gfxhub_v3_0_print_l2_protec=
tion_fault_status,
>         .get_invalidate_req =3D gfxhub_v3_0_get_invalidate_req,
> +       .program_kernel_trap_vmids =3D gfxhub_v3_0_program_kernel_trap_vm=
ids,
>  };
>
>  static void gfxhub_v3_0_init(struct amdgpu_device *adev)
> --
> 2.34.1
>
