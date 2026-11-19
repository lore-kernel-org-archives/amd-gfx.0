Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75839606A326
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oEDMUChq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D99A310E206;
	Thu, 19 Nov 2026 20:07:29 +0000 (UTC)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E36F10E206
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 20:07:23 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-4c1ff2eabc0so12360b6e.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 12:07:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795118842; cv=none;
 d=google.com; s=arc-20260327;
 b=Qukp9weiWL+DOWNQMlAQwiHG5YF3Hu4pkWGRHMpQ5faUkxGt/DWIVo2WrP2UtNht4q
 LnQHokK7Ohnr6daoV+qX1ntytOy9eeckY2NskVMWWY8nyzRvobVuLpL2Y3ZQ7s6F8cRk
 ttAtPHDntjOnaUBL3gOpRD4yUsewfWL1h9cgL2vnJ9NaLi6UBuNQjs++a3dAbVGsLZ9Q
 HBAjOUnaQGgoQsEkYNrXy1xfb16W0liG+EcFGWrPb4ZR/UpX0HG5NdNe3x+dVSSg2hv8
 E+tRlFy9PJz+m+slZjwKxFulGWNxoKqGVH8MOzoT/3l1VVptPQrDTe2Pt3vsxiE85Xa9
 pfeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AnQjIzsvA3d9NQtd3OBG7pI5CafhAxzLM1ClsuuhXFU=;
 fh=aP5XtmAVOHnZooMt8NhX3GLJNEFCtpScmyFY7S8Q64Y=;
 b=iSKllEA9wbpexq+RIFwzzc0MOQ9tOQp3HKgGTqFplpXGcHBw8GBIIck0cceFJiW9os
 WZubnDxuVdS12IIgTU0AAtPEkyaqoj/iSAeya5D1UHqKG3SgFKkSB47Cazxx7cNjy8GY
 96NCJC9rQSEkeeBaqMYe9kPnaVOI6QKKSc6H/EE6uBrDajvc615LKpo+JVVVn9ublXpY
 +SLgZ9dbi6bDi+z7inMdSbWxNxMMmy+4hksRQ+S3GH1QshVB2XfviYx1+oVtVghI/CkI
 cogDahb7SrqfKSkCBVpceIG0vFG4NgzGKCcQYnPbZpHKBcfirt0O33TzBAEX2QI//8lH
 cO4w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795118842; x=1795723642; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AnQjIzsvA3d9NQtd3OBG7pI5CafhAxzLM1ClsuuhXFU=;
 b=oEDMUChqbN16mYhNV56LjteCPZIUsc2H0PK/ZaQhgAHLYoNaNUfOA3lzvVE5Sd7pKW
 l6wd9dEgkJE19nQ0MUcccHCW8hPFH4WlQwVaAP4poY4FV9h2/oHLRL4ZlQm3cRJhcRd9
 4ySITa51t86iEkiHFkhSDKSq4910vw6hETMyRqjImoYQjH4KXQlPAD0RZ8SGvPO05+7j
 kZ1v4wgTMTPxjmp+lc52tFgrDq4hKMGEdqRzmaN3QcIYFMbIwjIt7s7ZPS7mTGUB+eXa
 CfBMORBeGrEXRgOKgAiLd9+OqTg+yfepF89f++s2wMeBD7yn/9lcElFa8QMq7Qry0vYN
 vFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795118842; x=1795723642;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AnQjIzsvA3d9NQtd3OBG7pI5CafhAxzLM1ClsuuhXFU=;
 b=lV+Xc5EGy297B0o+gGolr8iffHhcXUJ83swBc9GqftHveZGIHmS5o+dfyc6bHpvzo5
 dhfcUowoqjZR7B2Y3YqPGFnJp3ur8qHM9wC8SdbM8a8/ckRy6Dq0pzuCWkr9bZdjhRQr
 ll5Wt2GuQK5xTKNeJUm3cJfA0TvIQRX64G85Mk4XqEa4hi4QrcjqgMd7VKhggKeTBhBX
 3jHqYRGlSxy+QmcezkonBFMMKomuWSqjMutTBr520iVglcpeNtJyN94l/qTel2AjD/JL
 +HBpwUwzsIKtCC9cHjiBuZkLjwBTjJR8cL9bhsVNeEKNK8sbZ55FSY+F5AgHGmqeca4q
 WaKQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGf4srmA8mMsmtXHmGDzAqHSKXT0wUWZwhbrZLTm34FQrQU3fAlL78JqZ2R7vhbnU5o3leO2s7R@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/HAYakO+wasUMhU1L6EFKGgPDSvcE9ITXYq75bmMY/CkoiRhqP
 enpoIquP1iibftsDe2wMLiMj+bpQCwOxUDvUeRxukjEowPeoqRDSlsAgcDpnUsVY+LtyKTqGjZD
 h1lftDt99Amr10txp/WLyxNJFc4RTbqI=
X-Gm-Gg: AYBFou1i7AqpQVrJv+mNHgWrLoqFxp2THa+uRBKRWcQeA3WTA1a1429SqnaHuCTz8Pr
 N2/KumRn1cbLHiI6cUY3j1yAJLpAcb/OyCMqvTcNvwVgNCxSK4B9sr9TZtHmoi9W3mVBBpo5x/0
 3vVzCugzWd4FtkCKdWMSJaOuulo7wYmZYUeyHzdPyXgXHZ5zS5CI4M1nvxF1QghtQ1YBhXH/Fg2
 fbIsUC8Y3O68QUhnulJM+l//LLMH/l1oa+ivqfRojEqNt1HnexQHhNhsBQKEIvGMfCRoF9wERhK
 KcyDyLOlsJEbNMUJryi7pYLZwi87QtDstK63KpwtWA1KFTk1ASFL6nt8E5+iVA9rraTBdAdbN9+
 ygiRP61/Ig2KPI/OQr8/YvFEqVcL3PYe1ZLn+BTp9hZD/J8MYy3VzJfUz8Tadlb2ISnvlHe6wt/
 RLfVhajMp9nuQtHTUJ/mypGRdwVYoLvvdKCV+bJvt+gco7Yr35wVqPXTU67nU=
X-Received: by 2002:a05:6808:6711:b0:4f3:6ac0:27d7 with SMTP id
 5614622812f47-57a05ae9f8bmr1485649b6e.1.1795118842351; Thu, 19 Nov 2026
 12:07:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118080513.1677783-1-srinivasan.shanmugam@amd.com>
 <20261118080513.1677783-5-srinivasan.shanmugam@amd.com>
In-Reply-To: <20261118080513.1677783-5-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Nov 2026 15:07:10 -0500
X-Gm-Features: AclHuK977DhSJvphnCg25uxiv9Dn0I3JuD45FsrIkqa24FQR7PgCVzB9Ir7Ysmc
Message-ID: <CADnq5_NqhV9aue6=mUwbf_WyGpRpSsj8k1PwGMYP-QviVH03yg@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] drm/amdgpu/uapi: Add SET/CLEAR L2 TRAP to VM ioctl
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Felix Kuehling <felix.kuehling@amd.com>, Lancelot Six <lancelot.six@amd.com>, 
 James Zhu <james.zhu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, 
 Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 3:11=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Add SET_L2_TRAP and CLEAR_L2_TRAP operations to the VM ioctl.
>
> The second-level trap handler is set per GPUVM. All shader waves using
> the same GPUVM use the same second-level trap handler, regardless of the
> queue type.
>
> SET_L2_TRAP sets the userspace TBA and TMA addresses for the GPUVM. The
> kernel checks that both address ranges are mapped in the GPUVM before
> using them.
>
> CLEAR_L2_TRAP clears the second-level TBA and TMA addresses from the
> first-level trap descriptor.
>
> Userspace must keep the TBA and TMA mappings valid after SET_L2_TRAP.
> The mappings can be removed after CLEAR_L2_TRAP completes successfully.
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: James Zhu <james.zhu@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Samuel Pitoiset <hakzsam@gmail.com>
> Cc: Natalie Vock <natalie.vock@gmx.de>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 36 ++++++++++++++-
>  include/uapi/drm/amdgpu_drm.h          | 63 ++++++++++++++++++++++++++

This also adds UAPI.  We need proposed userspace before we can land this.

Alex

>  2 files changed, 98 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index eafd4367d3b1..df3a8dda606a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3064,19 +3064,53 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
>                 }
>                 return r;
>         }
> +
>         case AMDGPU_VM_OP_UNRESERVE_VMID: {
>                 struct amdgpu_bo *root =3D vm->root.bo;
>
>                 amdgpu_bo_reserve(root, true);
> +
>                 /* Wait for the jobs which might still use the reserved V=
MID */
>                 if (vm->reserved_vmid[AMDGPU_GFXHUB(0)])
>                         dma_resv_wait_timeout(root->tbo.base.resv,
> -                                             DMA_RESV_USAGE_READ, false,
> +                                             DMA_RESV_USAGE_READ,
> +                                             false,
>                                               MAX_SCHEDULE_TIMEOUT);
> +
>                 amdgpu_vmid_free_spm(adev, vm, AMDGPU_GFXHUB(0));
>                 amdgpu_bo_unreserve(root);
> +
>                 break;
>         }
> +
> +       case AMDGPU_VM_OP_SET_L2_TRAP:
> +               /*
> +                * Install or replace the per-VM second-level trap handle=
r.
> +                * Applies to all shader waves using this GPUVM regardles=
s of
> +                * queue type.
> +                */
> +               if (!vm->trap_obj)
> +                       return -EOPNOTSUPP;
> +
> +               return amdgpu_trap_vm_set_l2_trap(adev, vm,
> +                                                 vm->trap_obj,
> +                                                 args->in.l2trap.tba_va,
> +                                                 args->in.l2trap.tba_sz,
> +                                                 args->in.l2trap.tma_va,
> +                                                 args->in.l2trap.tma_sz)=
;
> +
> +       case AMDGPU_VM_OP_CLEAR_L2_TRAP:
> +               if (memchr_inv(&args->in.l2trap, 0,
> +                              sizeof(args->in.l2trap)))
> +                       return -EINVAL;
> +
> +               /* Disable the per-VM second-level trap handler. */
> +               if (!vm->trap_obj)
> +                       return -EOPNOTSUPP;
> +
> +               return amdgpu_trap_vm_clear_l2_trap(adev, vm,
> +                                                   vm->trap_obj);
> +
>         default:
>                 return -EINVAL;
>         }
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 9317018330ec..b576d62bcd87 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -614,10 +614,73 @@ struct drm_amdgpu_userq_wait {
>  #define AMDGPU_VM_OP_RESERVE_VMID      1
>  #define AMDGPU_VM_OP_UNRESERVE_VMID    2
>
> +/**
> + * AMDGPU_VM_OP_SET_L2_TRAP - install or replace the second-level trap
> + * handler for this GPUVM.
> + *
> + * The second-level trap handler is a per-GPUVM setting. All shader wave=
s
> + * using this GPUVM use the same handler regardless of queue type.
> + *
> + * TBA is the GPU virtual address of the second-level trap handler code.
> + * TMA is the GPU virtual address of the second-level trap handler scrat=
ch
> + * memory. Each range must be non-empty and contained within a single ma=
pping
> + * in this GPUVM.
> + *
> + * This operation may block until outstanding GPUVM work completes.
> + *
> + * Userspace must keep the TBA and TMA mappings valid while the second-l=
evel
> + * trap handler is installed.
> + *
> + * Returns:
> + *  0             on success;
> + *  -EOPNOTSUPP   if the first-level CWSR handler is unavailable;
> + *  -EINVAL       if TBA/TMA is invalid or not mapped in this GPUVM;
> + *  negative errno if waiting for GPUVM work or reserving the GPUVM fail=
s.
> + */
> +#define AMDGPU_VM_OP_SET_L2_TRAP       3
> +
> +/**
> + * AMDGPU_VM_OP_CLEAR_L2_TRAP - disable the second-level trap handler.
> + *
> + * This operation may block until outstanding GPUVM work completes.
> + *
> + * The l2trap input members must be zero for this operation.
> + *
> + * After this operation succeeds, userspace may remove the second-level
> + * TBA and TMA mappings.
> + *
> + * Returns:
> + *  0             on success;
> + *  -EOPNOTSUPP   if the first-level CWSR handler is unavailable;
> + *  -EINVAL       if the GPUVM trap state is invalid;
> + *  negative errno if waiting for GPUVM work or reserving the GPUVM fail=
s.
> + */
> +#define AMDGPU_VM_OP_CLEAR_L2_TRAP     4
> +
>  struct drm_amdgpu_vm_in {
>         /** AMDGPU_VM_OP_* */
>         __u32   op;
>         __u32   flags;
> +       union {
> +               struct {
> +                       /** GPU VA of second-level trap handler code buff=
er */
> +                       __u64 tba_va;
> +
> +                       /** GPU VA of second-level trap handler scratch b=
uffer */
> +                       __u64 tma_va;
> +
> +                       /** TBA buffer size in bytes */
> +                       __u32 tba_sz;
> +
> +                       /** TMA buffer size in bytes */
> +                       __u32 tma_sz;
> +               } l2trap;
> +               /**
> +                * Reserved; keeps the union at a fixed 32-byte size for
> +                * future operations.
> +                */
> +               __u64 reserved[4];
> +       };
>  };
>
>  struct drm_amdgpu_vm_out {
> --
> 2.34.1
>
