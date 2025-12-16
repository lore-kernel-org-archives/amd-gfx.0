Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80459D609BB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 16:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C26F10E81C;
	Tue, 16 Dec 2025 16:43:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cKFRgnHn";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF3BE10E81C
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 16:43:21 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-b9a5f4435adso112220a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 08:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765903401; x=1766508201; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s2aXkCpVhJK5d1agdII8liJLXZsRDkIcS4e8oC69kFc=;
 b=cKFRgnHnWuHXC2kLSju81CPcRnBFn1VDScoP3a785Rv+kIvuJfjwUsgGJKLQtnQ7Jp
 Ljf9+WGqOXoEpkrl9JVUie5gT+iY5ZAhVd/ZJYOfMBR0V6c6Vz6fVTZFboZmiEDKtQPJ
 oEUqs2Ast2+3Y0h50EVG0aaMuGm7nTq86xTOVu4RXNNXmkw5+BwCHko97N5wXL6nRmNm
 T+45X1etHWxJRty73CJjvReXNh3fABW/lf4FvO9iztiuh1kUEllZdCNMkgVAgtsrCttz
 E0UV/m896YJOJpVra/NgWJp/AfTBbT+SEt85U/o0hanNvbBYC2gjr+cPYeGl3e3yw8rn
 Vrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765903401; x=1766508201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s2aXkCpVhJK5d1agdII8liJLXZsRDkIcS4e8oC69kFc=;
 b=W34+Iu5068ZRDgv8SVxKbUtGkq3dLsrPD+FbAB+2iRSFMgvqZdA7uf0Jz+yXfgoHEQ
 8+pBJvOxVUcbzl4kvDYtMWCd+Cx9YSPle3aIrZOl+cvqW+i+NVT9V5XMjnqp4OGEX9pf
 ym5C1y0jtU8dEYkymderU9mo7PoSYJ9JTMW5DRW43PraDPGzCnpeV3GoNrEKidid7j5s
 OugfrSOA1Vvmm8BOdmqdpsz5yuspDW4KsysZauO+nF5fEPFHLivu3pdgeNcL74vioxZg
 eh1zauG7ovF+AGZxIt3IrvaFkh1tQYxKOw6uEwZXmP4TkGYz0jR9rdUBuPPygMiYuFxZ
 95Wg==
X-Gm-Message-State: AOJu0YzhebW9TjqfSl/f3SmlCcvD8V1sjXcWu9/bh8kRre1OINYiENYn
 UVglp90YSdd4U4b1sWwS6etd56nHFXvjss3kILPCd/B/ADKz5cT97iwXHmcwV5B1h/EfhWMZZv6
 5QLCrKtQmsMU1rQNEuOJIhi+HO83I+LY=
X-Gm-Gg: AY/fxX6NX4oViBdli5LicfTmI3I++rFuPyGewbjgR7aD49umOaMaPNZ8Gvy82IPTSoB
 8d8oH5zS6vBAzQ7YLFTPzaEhZPDBisPpyy33otup3ZPGnW0xSLVsbIwYXPO+omHX2GXLoTnvtZs
 5Y2k8JmAQas6W2173hi4RTjkb1maaqFRYKW9OdTTWOeNWH7u9mlqRWgDbT8DxD4Eesc5BPVh+UQ
 zI2SnCEpu93JJ6RtJ00VM7taVHQBkEpOclF0oF6vkttlQJ0efXoQ7T2GIeLeKSRFeMLXNe6
X-Google-Smtp-Source: AGHT+IFn7A/LAHnbvmod19WcXuGFnLbLDa/Q0FF+90k+ux44Cup5eHbHOXWY/rUO//c1hqIMOIELKT+T8bg3sECKkpk=
X-Received: by 2002:a05:7300:5709:b0:2ab:ca55:89cb with SMTP id
 5a478bee46e88-2ac3027b0a0mr6183678eec.6.1765903401289; Tue, 16 Dec 2025
 08:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20251203130436.745633-1-lijo.lazar@amd.com>
 <20251203130436.745633-7-lijo.lazar@amd.com>
In-Reply-To: <20251203130436.745633-7-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 11:43:09 -0500
X-Gm-Features: AQt7F2p7oRe6cVpkhNa0_qQCbqQf9x5lgsFOTYyMrRWRpVL6imHfYSO5FALQ_jE
Message-ID: <CADnq5_MvojFQC5g+UuAEeUEt8OXPst0SkTcS3A8=4MBdmGB0ig@mail.gmail.com>
Subject: Re: [RFC PATCH v3 06/10] drm/amdgpu: Add first level cwsr handler to
 userq
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com
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

On Wed, Dec 3, 2025 at 8:14=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Add cwsr_trap_obj to render file handle. It maps the first level cwsr
> handler to the vm with which the file handle is associated. Use
> cwsr trap object's tba/tma address for the userqueue.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 8 ++++++++
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 6 ++++++
>  3 files changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index b9920cab5d31..ec2919a9c636 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -332,6 +332,7 @@ struct amdgpu_hive_info;
>  struct amdgpu_reset_context;
>  struct amdgpu_reset_control;
>  struct amdgpu_cwsr_isa;
> +struct amdgpu_cwsr_trap_obj;
>
>  enum amdgpu_cp_irq {
>         AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP =3D 0,
> @@ -505,6 +506,7 @@ struct amdgpu_fpriv {
>         struct idr              bo_list_handles;
>         struct amdgpu_ctx_mgr   ctx_mgr;
>         struct amdgpu_userq_mgr userq_mgr;
> +       struct amdgpu_cwsr_trap_obj *cwsr_trap;
>
>         /* Eviction fence infra */
>         struct amdgpu_eviction_fence_mgr evf_mgr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index b3e6b3fcdf2c..398d6c8d343c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -46,6 +46,7 @@
>  #include "amdgpu_reset.h"
>  #include "amd_pcie.h"
>  #include "amdgpu_userq.h"
> +#include "amdgpu_cwsr.h"
>
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>  {
> @@ -1452,6 +1453,12 @@ int amdgpu_driver_open_kms(struct drm_device *dev,=
 struct drm_file *file_priv)
>         if (r)
>                 DRM_WARN("Can't setup usermode queues, use legacy workloa=
d submission only\n");
>
> +       if (amdgpu_cwsr_is_enabled(adev)) {
> +               r =3D amdgpu_cwsr_alloc(adev, &fpriv->vm, &fpriv->cwsr_tr=
ap);
> +               if (r)
> +                       dev_dbg(adev->dev, "cwsr trap not enabled");
> +       }
> +
>         r =3D amdgpu_eviction_fence_init(&fpriv->evf_mgr);
>         if (r)
>                 goto error_vm;
> @@ -1524,6 +1531,7 @@ void amdgpu_driver_postclose_kms(struct drm_device =
*dev,
>         }
>
>         amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
> +       amdgpu_cwsr_free(adev, &fpriv->vm, &fpriv->cwsr_trap);
>         amdgpu_vm_fini(adev, &fpriv->vm);
>
>         if (pasid)
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 8b0aeb89025a..480f4806e951 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -26,6 +26,7 @@
>  #include "amdgpu_gfx.h"
>  #include "mes_userqueue.h"
>  #include "amdgpu_userq_fence.h"
> +#include "amdgpu_cwsr.h"
>
>  #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>  #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> @@ -116,6 +117,7 @@ static int convert_to_mes_priority(int priority)
>  static int mes_userq_map(struct amdgpu_usermode_queue *queue)
>  {
>         struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
> +       struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
>         struct amdgpu_device *adev =3D uq_mgr->adev;
>         struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
>         struct amdgpu_mqd_prop *userq_props =3D queue->userq_prop;
> @@ -145,6 +147,10 @@ static int mes_userq_map(struct amdgpu_usermode_queu=
e *queue)
>         queue_input.doorbell_offset =3D userq_props->doorbell_index;
>         queue_input.page_table_base_addr =3D amdgpu_gmc_pd_addr(queue->vm=
->root.bo);
>         queue_input.wptr_mc_addr =3D queue->wptr_obj.gpu_addr;
> +       if (fpriv->cwsr_trap) {
> +               queue_input.tba_addr =3D fpriv->cwsr_trap->tba_gpu_va_add=
r;
> +               queue_input.tma_addr =3D fpriv->cwsr_trap->tma_gpu_va_add=
r;
> +       }
>
>         amdgpu_mes_lock(&adev->mes);
>         r =3D adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
> --
> 2.49.0
>
