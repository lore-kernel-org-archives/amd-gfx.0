Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01CACAC597
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 20:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72BA310E1B6;
	Thu, 18 Sep 2025 20:04:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DNuSDUl+";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 819C710E1B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 20:04:43 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-7728ec910caso191567b3a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 13:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758225883; x=1758830683; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1etmDimaQxlrC+VR/vs28BVYTK+6v1//M6LNnNQWIk8=;
 b=DNuSDUl+IOx5e+wC/65NpB6ApfIey0GpOmir3LSbcurRZ+CfmQD180r8RPOM8V8q+M
 ICE70AxSmXOvsxLvP/9MuSDEMq84JR7ZUCmrTCrBh7g0i8orsPjSG7ON8nW27GYG9NjJ
 2vGwInMphoikjxhcprrutK5Z5eONKeubcbgpGQH0ydj9CpVIiSoZeytS8XM1q4SFbW/Z
 FizZA58FdrgqiO5SWhuvo7eZxf917Avavqz/efLoO+DNxtZGbFNogxdyTeIhc38L4UxJ
 SpJOnpYfgllyfWS5LyzljAhgBKRL5ZGCCxdCfMmDLtm0ZqoYhJodxuMRw18H5ER+TX0n
 wa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758225883; x=1758830683;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1etmDimaQxlrC+VR/vs28BVYTK+6v1//M6LNnNQWIk8=;
 b=SzZlG48IhwQusWUOnrYrcSvfCOlU223Y0b/r+lOs4wsEC0j2bgnRLpz8lLmhiEv9/g
 +6g4JOsdvoTxTUYvoMz8tNt4JvlV5Wx6PhwTLvtDO3PLSDhWYPr6ghiAlDggT3bHurCn
 YChkwh+NuEZc8iFNTJR9Q6GcUr7SVga+MWrxDOKRGLLbJeKPdRtIa72sG+x4SxvXXEjA
 EI0olJSO7QWIPqahvkivvrv9XkEOGGuMw/0tDHluq5PwEzQxlIDSlFDgquO5OTItW3s9
 9pRLWY3Jx0v3GVEQX3/VSeEu03X3XqmUL1AwfwnsTW8tK8+Q5pAEQH8k3UhL4TJiCiUM
 C+Ag==
X-Gm-Message-State: AOJu0YyK3mQja6+rqqnejVtXhWAfSNXDoTLTfuRcZkEfguUau2SjCVcN
 M2nNKn0rWF9G02T0SpSUWiC4FxoyGUJJ0TGZdMESdI2DzlslQHMX9+zCMxndnx/V4xPSOs2ulMF
 VBpp90k79wuz4cAmyQjSP5z/gQMT05mG0hw==
X-Gm-Gg: ASbGncuUyEefKJk6pvJWmCwaFZI5iPozpnkw58YlFt3MYto4EcoUCKsLg8Z0UliOEhz
 0L0TkHNJHdSF1IF7nCucLyxALg03+p1MoT7my90suWnTDul89rnEVrQa3Z8U82MkytyoLtS/r0s
 dRsya8hbaBdhCssiZRz32J3SI/P8FdWJVgghwqtRMKSJPtKSctcqxFZh+7GjyPxs0qVt8gK2afv
 3p5uaztLRhylg1iZ8wmFKDCay7GsdL0StsH
X-Google-Smtp-Source: AGHT+IGuiNk4EcYmONvmEmRPxWyO1MzqoxacPKo6FhLRxoOOlFdUpLWqqgoxENaBQQkSnz+BvqnnHm4CigqAy3uePcA=
X-Received: by 2002:a17:902:8f90:b0:269:85aa:3776 with SMTP id
 d9443c01a7336-269ba565f84mr3981965ad.11.1758225882896; Thu, 18 Sep 2025
 13:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
 <20250918013507.2629620-6-YiPeng.Chai@amd.com>
In-Reply-To: <20250918013507.2629620-6-YiPeng.Chai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Sep 2025 16:04:30 -0400
X-Gm-Features: AS18NWCFL81rj-AqVi7TC-ucBbCU5Wkc-uhrd8E8URuoJcT8nAv4YHyDyu0UGuI
Message-ID: <CADnq5_OuPMaiTXuLjBtn7pHT9zVZbYUT6H3CnxU+qtknLVyyaA@mail.gmail.com>
Subject: Re: [PATCH 06/10] drm/amd/ras: Add amdgpu ras system functions
To: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, 
 Candice.Li@amd.com, Stanley.Yang@amd.com
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

On Wed, Sep 17, 2025 at 9:37=E2=80=AFPM YiPeng Chai <YiPeng.Chai@amd.com> w=
rote:
>
> Add amdgpu ras system functions.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  | 268 ++++++++++++++++++
>  drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h     | 109 +++++++
>  2 files changed, 377 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
>  create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/g=
pu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> new file mode 100644
> index 000000000000..40071b876333
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#include "ras_sys.h"
> +#include "amdgpu_ras_mgr.h"
> +#include "amdgpu_ras.h"
> +#include "amdgpu_reset.h"
> +
> +static int amdgpu_ras_sys_detect_fatal_event(struct ras_core_context *ra=
s_core, void *data)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->=
dev;
> +       uint64_t seq_no;
> +
> +       seq_no =3D amdgpu_ras_mgr_gen_ras_event_seqno(adev, RAS_SEQNO_TYP=
E_UE);
> +       RAS_DEV_INFO(adev,
> +               "{%llu} Uncorrectable hardware error(ERREVENT_ATHUB_INTER=
RUPT) detected!\n",
> +               seq_no);
> +
> +       return amdgpu_ras_process_handle_unexpected_interrupt(adev, data)=
;
> +}
> +
> +static int amdgpu_ras_sys_poison_consumption_event(struct ras_core_conte=
xt *ras_core,
> +                               void *data)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->=
dev;
> +       struct ras_event_req *req =3D (struct ras_event_req *)data;
> +       pasid_notify pasid_fn;
> +
> +       if (!req)
> +               return -EINVAL;
> +
> +       if (req->pasid_fn) {
> +               pasid_fn =3D (pasid_notify)req->pasid_fn;
> +               pasid_fn(adev, req->pasid, req->data);
> +       }
> +
> +       return 0;
> +}
> +
> +static int amdgpu_ras_sys_gen_seqno(struct ras_core_context *ras_core,
> +                       enum ras_seqno_type seqno_type, uint64_t *seqno)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->=
dev;
> +       struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(ade=
v);
> +       struct ras_event_manager *event_mgr;
> +       struct ras_event_state *event_state;
> +       struct amdgpu_hive_info *hive;
> +       enum ras_event_type event_type;
> +       uint64_t seq_no;
> +
> +       if (!ras_mgr || !seqno ||
> +               (seqno_type >=3D RAS_SEQNO_TYPE_COUNT_MAX))
> +               return -EINVAL;
> +
> +       switch (seqno_type) {
> +       case RAS_SEQNO_TYPE_UE:
> +               event_type =3D RAS_EVENT_TYPE_FATAL;
> +               break;
> +       case RAS_SEQNO_TYPE_CE:
> +       case RAS_SEQNO_TYPE_DE:
> +               event_type =3D RAS_EVENT_TYPE_POISON_CREATION;
> +               break;
> +       case RAS_SEQNO_TYPE_POISON_CONSUMPTION:
> +               event_type =3D RAS_EVENT_TYPE_POISON_CONSUMPTION;
> +               break;
> +       default:
> +               event_type =3D RAS_EVENT_TYPE_INVALID;
> +               break;
> +       }
> +
> +       hive =3D amdgpu_get_xgmi_hive(adev);
> +       event_mgr =3D hive ? &hive->event_mgr : &ras_mgr->ras_event_mgr;
> +       event_state =3D &event_mgr->event_state[event_type];
> +       if ((event_type =3D=3D RAS_EVENT_TYPE_FATAL) && amdgpu_ras_in_rec=
overy(adev)) {
> +               seq_no =3D event_state->last_seqno;
> +       } else {
> +               seq_no =3D atomic64_inc_return(&event_mgr->seqno);
> +               event_state->last_seqno =3D seq_no;
> +               atomic64_inc(&event_state->count);
> +       }
> +       amdgpu_put_xgmi_hive(hive);
> +
> +       *seqno =3D seq_no;
> +       return 0;
> +
> +}
> +
> +static int amdgpu_ras_sys_event_notifier(struct ras_core_context *ras_co=
re,
> +                                  enum ras_notify_event event_id, void *=
data)
> +{
> +       struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(ras=
_core->dev);
> +       int ret =3D 0;
> +
> +       switch (event_id) {
> +       case RAS_EVENT_ID__BAD_PAGE_DETECTED:
> +               schedule_delayed_work(&ras_mgr->retire_page_dwork, 0);
> +               break;
> +       case RAS_EVENT_ID__POISON_CONSUMPTION:
> +               amdgpu_ras_sys_poison_consumption_event(ras_core, data);
> +               break;
> +       case RAS_EVENT_ID__RESERVE_BAD_PAGE:
> +               ret =3D amdgpu_ras_reserve_page(ras_core->dev, *(uint64_t=
 *)data);
> +               break;
> +       case RAS_EVENT_ID__FATAL_ERROR_DETECTED:
> +               ret =3D amdgpu_ras_sys_detect_fatal_event(ras_core, data)=
;
> +               break;
> +       case RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM:
> +               ret =3D amdgpu_dpm_send_hbm_bad_pages_num(ras_core->dev, =
*(uint32_t *)data);
> +               break;
> +       case RAS_EVENT_ID__UPDATE_BAD_CHANNEL_BITMAP:
> +               ret =3D amdgpu_dpm_send_hbm_bad_channel_flag(ras_core->de=
v, *(uint32_t *)data);
> +               break;
> +       case RAS_EVENT_ID__DEVICE_RMA:
> +               ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_RMA, N=
ULL, NULL);
> +               ret =3D amdgpu_dpm_send_rma_reason(ras_core->dev);
> +               break;
> +       case RAS_EVENT_ID__RESET_GPU:
> +               ret =3D amdgpu_ras_mgr_reset_gpu(ras_core->dev, *(uint32_=
t *)data);
> +               break;
> +       default:
> +               RAS_DEV_WARN(ras_core->dev, "Invalid ras notify event:%d\=
n", event_id);
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static u64 amdgpu_ras_sys_get_utc_second_timestamp(struct ras_core_conte=
xt *ras_core)
> +{
> +       return ktime_get_real_seconds();
> +}
> +
> +static int amdgpu_ras_sys_check_gpu_status(struct ras_core_context *ras_=
core,
> +                               uint32_t *status)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->=
dev;
> +       uint32_t gpu_status =3D 0;
> +
> +       if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev))
> +               gpu_status |=3D RAS_GPU_STATUS__IN_RESET;
> +
> +       if (amdgpu_sriov_vf(adev))
> +               gpu_status |=3D RAS_GPU_STATUS__IS_VF;
> +
> +       *status =3D gpu_status;
> +
> +       return 0;
> +}
> +
> +static int amdgpu_ras_sys_get_device_system_info(struct ras_core_context=
 *ras_core,
> +                       struct device_system_info *dev_info)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->=
dev;
> +
> +       dev_info->device_id =3D adev->pdev->device;
> +       dev_info->vendor_id =3D adev->pdev->vendor;
> +       dev_info->socket_id =3D adev->smuio.funcs->get_socket_id(adev);
> +
> +       return 0;
> +}
> +
> +static int amdgpu_ras_sys_gpu_reset_lock(struct ras_core_context *ras_co=
re,
> +                       bool down, bool try)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->=
dev;
> +       int ret =3D 0;
> +
> +       if (down && try)
> +               ret =3D down_read_trylock(&adev->reset_domain->sem);
> +       else if (down)
> +               down_read(&adev->reset_domain->sem);
> +       else
> +               up_read(&adev->reset_domain->sem);
> +
> +       return ret;
> +}
> +
> +static bool amdgpu_ras_sys_detect_ras_interrupt(struct ras_core_context =
*ras_core)
> +{
> +       return !!atomic_read(&amdgpu_ras_in_intr);
> +}
> +
> +static int amdgpu_ras_sys_get_gpu_mem(struct ras_core_context *ras_core,
> +       enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->=
dev;
> +       struct psp_context *psp =3D &adev->psp;
> +       struct psp_ring *psp_ring;
> +       struct ta_mem_context *mem_ctx;
> +
> +       if (mem_type =3D=3D GPU_MEM_TYPE_RAS_PSP_RING) {
> +               psp_ring =3D &psp->km_ring;
> +               gpu_mem->mem_bo =3D adev->firmware.rbuf;
> +               gpu_mem->mem_size =3D psp_ring->ring_size;
> +               gpu_mem->mem_mc_addr =3D psp_ring->ring_mem_mc_addr;
> +               gpu_mem->mem_cpu_addr =3D psp_ring->ring_mem;
> +       } else if (mem_type =3D=3D GPU_MEM_TYPE_RAS_PSP_CMD) {
> +               gpu_mem->mem_bo =3D psp->cmd_buf_bo;
> +               gpu_mem->mem_size =3D PSP_CMD_BUFFER_SIZE;
> +               gpu_mem->mem_mc_addr =3D psp->cmd_buf_mc_addr;
> +               gpu_mem->mem_cpu_addr =3D psp->cmd_buf_mem;
> +       } else if (mem_type =3D=3D GPU_MEM_TYPE_RAS_PSP_FENCE) {
> +               gpu_mem->mem_bo =3D psp->fence_buf_bo;
> +               gpu_mem->mem_size =3D PSP_FENCE_BUFFER_SIZE;
> +               gpu_mem->mem_mc_addr =3D psp->fence_buf_mc_addr;
> +               gpu_mem->mem_cpu_addr =3D psp->fence_buf;
> +       } else if (mem_type =3D=3D GPU_MEM_TYPE_RAS_TA_FW) {
> +               gpu_mem->mem_bo =3D psp->fw_pri_bo;
> +               gpu_mem->mem_size =3D PSP_1_MEG;
> +               gpu_mem->mem_mc_addr =3D psp->fw_pri_mc_addr;
> +               gpu_mem->mem_cpu_addr =3D psp->fw_pri_buf;
> +       } else if (mem_type =3D=3D GPU_MEM_TYPE_RAS_TA_CMD) {
> +               mem_ctx =3D &psp->ras_context.context.mem_context;
> +               gpu_mem->mem_bo =3D mem_ctx->shared_bo;
> +               gpu_mem->mem_size =3D mem_ctx->shared_mem_size;
> +               gpu_mem->mem_mc_addr =3D mem_ctx->shared_mc_addr;
> +               gpu_mem->mem_cpu_addr =3D mem_ctx->shared_buf;
> +       } else {
> +               return -EINVAL;
> +       }
> +
> +       if (!gpu_mem->mem_bo || !gpu_mem->mem_size ||
> +               !gpu_mem->mem_mc_addr || !gpu_mem->mem_cpu_addr) {
> +               RAS_DEV_ERR(ras_core->dev, "The ras psp gpu memory is inv=
alid!\n");
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static int amdgpu_ras_sys_put_gpu_mem(struct ras_core_context *ras_core,
> +       enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem)
> +{
> +
> +       return 0;
> +}
> +
> +const struct ras_sys_func amdgpu_ras_sys_fn =3D {
> +       .ras_notifier =3D amdgpu_ras_sys_event_notifier,
> +       .get_utc_second_timestamp =3D amdgpu_ras_sys_get_utc_second_times=
tamp,
> +       .gen_seqno =3D amdgpu_ras_sys_gen_seqno,
> +       .check_gpu_status =3D amdgpu_ras_sys_check_gpu_status,
> +       .get_device_system_info =3D amdgpu_ras_sys_get_device_system_info=
,
> +       .gpu_reset_lock =3D amdgpu_ras_sys_gpu_reset_lock,
> +       .detect_ras_interrupt =3D amdgpu_ras_sys_detect_ras_interrupt,
> +       .get_gpu_mem =3D amdgpu_ras_sys_get_gpu_mem,
> +       .put_gpu_mem =3D amdgpu_ras_sys_put_gpu_mem,
> +};
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h b/drivers/gpu/drm/=
amd/ras/ras_mgr/ras_sys.h
> new file mode 100644
> index 000000000000..c48ff26525d6
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> @@ -0,0 +1,109 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __RAS_SYS_H__
> +#define __RAS_SYS_H__
> +#include <linux/stdarg.h>
> +#include <linux/printk.h>
> +#include <linux/dev_printk.h>
> +#include "amdgpu.h"
> +
> +#define RAS_DEV_ERR(device, fmt, ...)                                   =
            \
> +       do {                                                             =
         \
> +               if (device)                                              =
               \
> +                       dev_err(((struct amdgpu_device *)device)->dev, fm=
t, ##__VA_ARGS__); \
> +               else                                                     =
             \
> +                       printk(KERN_ERR fmt, ##__VA_ARGS__);             =
                 \
> +       } while (0)
> +
> +#define RAS_DEV_WARN(device, fmt, ...)                                  =
             \
> +       do {                                                             =
          \
> +               if (device)                                              =
                \
> +                       dev_warn(((struct amdgpu_device *)device)->dev, f=
mt, ##__VA_ARGS__); \
> +               else                                                     =
              \
> +                       printk(KERN_WARNING fmt, ##__VA_ARGS__);         =
                  \
> +       } while (0)
> +
> +#define RAS_DEV_INFO(device, fmt, ...)                                  =
               \
> +       do {                                                             =
            \
> +               if (device)                                              =
                  \
> +                       dev_info(((struct amdgpu_device *)device)->dev, f=
mt, ##__VA_ARGS__);   \
> +               else                                                     =
                \
> +                       printk(KERN_INFO fmt, ##__VA_ARGS__);            =
                    \
> +       } while (0)
> +
> +#define RAS_DEV_DBG(device, fmt, ...)                                   =
               \
> +       do {                                                             =
            \
> +               if (device)                                              =
                  \
> +                       dev_dbg(((struct amdgpu_device *)device)->dev, fm=
t, ##__VA_ARGS__);    \
> +               else                                                     =
                \
> +                       printk(KERN_DEBUG fmt, ##__VA_ARGS__);           =
                    \
> +       } while (0)
> +
> +#define RAS_INFO(fmt, ...)  printk(KERN_INFO fmt, ##__VA_ARGS__)

Why do we need these wrappers?  Is there ever a case where we don't
have a device?

Alex

> +
> +#define RAS_DEV_RREG32_SOC15(dev, ip, inst, reg) \
> +({ \
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)dev; \
> +       __RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE=
_IDX] + reg, \
> +                        0, ip##_HWIP, inst); \
> +})
> +
> +#define RAS_DEV_WREG32_SOC15(dev, ip, inst, reg, value) \
> +({ \
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)dev; \
> +       __WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BAS=
E_IDX] + reg), \
> +                         value, 0, ip##_HWIP, inst); \
> +})
> +
> +/* GET_INST returns the physical instance corresponding to a logical ins=
tance */
> +#define RAS_GET_INST(dev, ip, inst) \
> +({ \
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)dev; \
> +       adev->ip_map.logical_to_dev_inst ? \
> +               adev->ip_map.logical_to_dev_inst(adev, ip##_HWIP, inst) :=
 inst; \
> +})
> +
> +#define RAS_GET_MASK(dev, ip, mask) \
> +({ \
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)dev; \
> +       (adev->ip_map.logical_to_dev_mask ? \
> +               adev->ip_map.logical_to_dev_mask(adev, ip##_HWIP, mask) :=
 mask); \
> +})
> +
> +static inline void *ras_radix_tree_delete_iter(struct radix_tree_root *r=
oot, void *iter)
> +{
> +       return radix_tree_delete(root, ((struct radix_tree_iter *)iter)->=
index);
> +}
> +
> +static inline long ras_wait_event_interruptible_timeout(void *wq_head,
> +                       int (*condition)(void *param), void *param, unsig=
ned int timeout)
> +{
> +       return wait_event_interruptible_timeout(*(wait_queue_head_t *)wq_=
head,
> +                               condition(param), timeout);
> +}
> +
> +extern const struct ras_sys_func amdgpu_ras_sys_fn;
> +
> +#endif
> --
> 2.34.1
>
