Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697D1CAC59A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 13:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF18D10E23C;
	Fri, 19 Sep 2025 13:20:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FQMyUDeW";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D0AE10E23C
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 13:19:59 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-26816246a0aso4283475ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 06:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758287999; x=1758892799; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lj3Vwl0aCh9MIVY9bpGiyjlRbZkpZ1RjkDSl2uuC5jI=;
 b=FQMyUDeWp7zxQzDzJw7Dqf17esot0icVKVAQNCOziNyBl/n5r51ZJ5QqVdpbUnxWCa
 J4NDyyNkfKBy688DIfj3DHCXKjBLmiM+vZt4jLB/oAiWxDFmiDypdXbNQNhO1Lzwk8OV
 aa0n/Ur94nRrSKdtSGhz+4ucWphX1SdOjbsQBuS2B8IUSOE8oQPeNAgsHpor3TFtGmmb
 GiedrwUdaWckB9F2VLBvaKcOyUgqKlwbnnZ/Jt3S7s6BwNdw5ytWLJ0NMC4tP6z1ElKs
 ntisKl2TRugjGeAZFbHrqtJyahhTn9SesEf8IqVdDUXe18KqUYvXsM5yWCKP8lR4mawO
 7ZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758287999; x=1758892799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lj3Vwl0aCh9MIVY9bpGiyjlRbZkpZ1RjkDSl2uuC5jI=;
 b=ieSJpsFKXNNk3d6UnpAOdjq0n58o9Peg2qRzjDF3EY8dGOJ56eOLSeF1UunmH1FHZz
 ID1ZR9+dKthg1VjCgGwMLM7UN4Lz3O2wo7JnYVUU4RDfpRJxe4HAu0sRtymIfbZDDe3o
 o7ouu4gtspNOXJQtZHrUo+9jRF7O3bOAzUKtUWj0YHm9IwbxEnwCjoKFXgjQ/QUYaw5n
 bh57qKErAUzEu08EPoOtwbnRLDtUfmBDQ1d+I5CsEvaBLSvlKW8WcxC88uUsYZBPrN/5
 I9pS9QOL54ZTrlfuI96jS4EZV/4b3HFRrr2D9ZQZoswziFpExhX2+pcO0HpS2T8W0V/m
 dVVQ==
X-Gm-Message-State: AOJu0YxtHjfaMsHrmJr8alE5z7n/S67gnCBLxu2NeYWANgZpsoMuJpUr
 vtio8R4gMtuAfVd3vlRhLFZPn2D0++o/aBrxfatkC2qCQt3tKy/J8pnJlMwCDpWuC7incRaJb0B
 eO6B7Xj5d4NCS6y+sLIrHB3h8sPm3rWh9Jw==
X-Gm-Gg: ASbGnctVUXoXin2C9c3ZTUD+XUgnrq6xv0VS7a46BpVUuX1oLexBf4MMdlPjwFOeYgq
 UzHWxxucq6bPM+Gi77ptzVi80oJHtxRc0ROX0OSm4/0+Ptw1JXgPhS1DfGs02JJqbeHNd5CdQ5A
 NGctTbybiX7GmtlKKuuXoSzFJnY9Vq+tbcnszKrTJuHILAr+tsc6EJUBmmt3L5NPR3I+P8YkyoO
 L2UWxs=
X-Google-Smtp-Source: AGHT+IFcMoGadQ+ZkOvfcvemyoJ7a3659mTfrzbb3rsMlMuaGpIWzU0+0bGltC1+d3+/fLUNI7/LwfUSlMRBt7Hpo6I=
X-Received: by 2002:a17:902:ce91:b0:264:67cd:d175 with SMTP id
 d9443c01a7336-269ba4c2ddcmr26740685ad.5.1758287998944; Fri, 19 Sep 2025
 06:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
 <20250918013507.2629620-6-YiPeng.Chai@amd.com>
 <CADnq5_OuPMaiTXuLjBtn7pHT9zVZbYUT6H3CnxU+qtknLVyyaA@mail.gmail.com>
 <CH2PR12MB4215C452FEFDDACD77865549FC11A@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4215C452FEFDDACD77865549FC11A@CH2PR12MB4215.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Sep 2025 09:19:47 -0400
X-Gm-Features: AS18NWBgWteo4EnUUMidzlSqEe0wlmzs_elpw83eW023BU1hnPR8dnyoNiMr-XA
Message-ID: <CADnq5_Mx3Miq+k8Nd5SLektvcsvdrOxpvyqHdky+m+NZihXQHQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] drm/amd/ras: Add amdgpu ras system functions
To: "Chai, Thomas" <YiPeng.Chai@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, 
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, 
 "Yang, Stanley" <Stanley.Yang@amd.com>
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

On Thu, Sep 18, 2025 at 8:55=E2=80=AFPM Chai, Thomas <YiPeng.Chai@amd.com> =
wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Friday, September 19, 2025 4:05 AM
> To: Chai, Thomas <YiPeng.Chai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>=
; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang, S=
tanley <Stanley.Yang@amd.com>
> Subject: Re: [PATCH 06/10] drm/amd/ras: Add amdgpu ras system functions
>
> On Wed, Sep 17, 2025 at 9:37=E2=80=AFPM YiPeng Chai <YiPeng.Chai@amd.com>=
 wrote:
> >
> > Add amdgpu ras system functions.
> >
> > Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> > Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
> > ---
> >  .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  | 268 ++++++++++++++++++
> >  drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h     | 109 +++++++
> >  2 files changed, 377 insertions(+)
> >  create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> >  create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> >
> > diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> > b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> > new file mode 100644
> > index 000000000000..40071b876333
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> > @@ -0,0 +1,268 @@
> > +// SPDX-License-Identifier: MIT
> > +/*
> > + * Copyright 2025 Advanced Micro Devices, Inc.
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> > +obtaining a
> > + * copy of this software and associated documentation files (the
> > +"Software"),
> > + * to deal in the Software without restriction, including without
> > +limitation
> > + * the rights to use, copy, modify, merge, publish, distribute,
> > +sublicense,
> > + * and/or sell copies of the Software, and to permit persons to whom
> > +the
> > + * Software is furnished to do so, subject to the following conditions=
:
> > + *
> > + * The above copyright notice and this permission notice shall be
> > +included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > +EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > +MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> > +SHALL
> > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> > +DAMAGES OR
> > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> > +OTHERWISE,
> > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> > +OR
> > + * OTHER DEALINGS IN THE SOFTWARE.
> > + *
> > + */
> > +#include "ras_sys.h"
> > +#include "amdgpu_ras_mgr.h"
> > +#include "amdgpu_ras.h"
> > +#include "amdgpu_reset.h"
> > +
> > +static int amdgpu_ras_sys_detect_fatal_event(struct ras_core_context
> > +*ras_core, void *data) {
> > +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core=
->dev;
> > +       uint64_t seq_no;
> > +
> > +       seq_no =3D amdgpu_ras_mgr_gen_ras_event_seqno(adev, RAS_SEQNO_T=
YPE_UE);
> > +       RAS_DEV_INFO(adev,
> > +               "{%llu} Uncorrectable hardware error(ERREVENT_ATHUB_INT=
ERRUPT) detected!\n",
> > +               seq_no);
> > +
> > +       return amdgpu_ras_process_handle_unexpected_interrupt(adev,
> > +data); }
> > +
> > +static int amdgpu_ras_sys_poison_consumption_event(struct ras_core_con=
text *ras_core,
> > +                               void *data) {
> > +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core=
->dev;
> > +       struct ras_event_req *req =3D (struct ras_event_req *)data;
> > +       pasid_notify pasid_fn;
> > +
> > +       if (!req)
> > +               return -EINVAL;
> > +
> > +       if (req->pasid_fn) {
> > +               pasid_fn =3D (pasid_notify)req->pasid_fn;
> > +               pasid_fn(adev, req->pasid, req->data);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int amdgpu_ras_sys_gen_seqno(struct ras_core_context *ras_core,
> > +                       enum ras_seqno_type seqno_type, uint64_t
> > +*seqno) {
> > +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core=
->dev;
> > +       struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(a=
dev);
> > +       struct ras_event_manager *event_mgr;
> > +       struct ras_event_state *event_state;
> > +       struct amdgpu_hive_info *hive;
> > +       enum ras_event_type event_type;
> > +       uint64_t seq_no;
> > +
> > +       if (!ras_mgr || !seqno ||
> > +               (seqno_type >=3D RAS_SEQNO_TYPE_COUNT_MAX))
> > +               return -EINVAL;
> > +
> > +       switch (seqno_type) {
> > +       case RAS_SEQNO_TYPE_UE:
> > +               event_type =3D RAS_EVENT_TYPE_FATAL;
> > +               break;
> > +       case RAS_SEQNO_TYPE_CE:
> > +       case RAS_SEQNO_TYPE_DE:
> > +               event_type =3D RAS_EVENT_TYPE_POISON_CREATION;
> > +               break;
> > +       case RAS_SEQNO_TYPE_POISON_CONSUMPTION:
> > +               event_type =3D RAS_EVENT_TYPE_POISON_CONSUMPTION;
> > +               break;
> > +       default:
> > +               event_type =3D RAS_EVENT_TYPE_INVALID;
> > +               break;
> > +       }
> > +
> > +       hive =3D amdgpu_get_xgmi_hive(adev);
> > +       event_mgr =3D hive ? &hive->event_mgr : &ras_mgr->ras_event_mgr=
;
> > +       event_state =3D &event_mgr->event_state[event_type];
> > +       if ((event_type =3D=3D RAS_EVENT_TYPE_FATAL) && amdgpu_ras_in_r=
ecovery(adev)) {
> > +               seq_no =3D event_state->last_seqno;
> > +       } else {
> > +               seq_no =3D atomic64_inc_return(&event_mgr->seqno);
> > +               event_state->last_seqno =3D seq_no;
> > +               atomic64_inc(&event_state->count);
> > +       }
> > +       amdgpu_put_xgmi_hive(hive);
> > +
> > +       *seqno =3D seq_no;
> > +       return 0;
> > +
> > +}
> > +
> > +static int amdgpu_ras_sys_event_notifier(struct ras_core_context *ras_=
core,
> > +                                  enum ras_notify_event event_id,
> > +void *data) {
> > +       struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(r=
as_core->dev);
> > +       int ret =3D 0;
> > +
> > +       switch (event_id) {
> > +       case RAS_EVENT_ID__BAD_PAGE_DETECTED:
> > +               schedule_delayed_work(&ras_mgr->retire_page_dwork, 0);
> > +               break;
> > +       case RAS_EVENT_ID__POISON_CONSUMPTION:
> > +               amdgpu_ras_sys_poison_consumption_event(ras_core, data)=
;
> > +               break;
> > +       case RAS_EVENT_ID__RESERVE_BAD_PAGE:
> > +               ret =3D amdgpu_ras_reserve_page(ras_core->dev, *(uint64=
_t *)data);
> > +               break;
> > +       case RAS_EVENT_ID__FATAL_ERROR_DETECTED:
> > +               ret =3D amdgpu_ras_sys_detect_fatal_event(ras_core, dat=
a);
> > +               break;
> > +       case RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM:
> > +               ret =3D amdgpu_dpm_send_hbm_bad_pages_num(ras_core->dev=
, *(uint32_t *)data);
> > +               break;
> > +       case RAS_EVENT_ID__UPDATE_BAD_CHANNEL_BITMAP:
> > +               ret =3D amdgpu_dpm_send_hbm_bad_channel_flag(ras_core->=
dev, *(uint32_t *)data);
> > +               break;
> > +       case RAS_EVENT_ID__DEVICE_RMA:
> > +               ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_RMA,=
 NULL, NULL);
> > +               ret =3D amdgpu_dpm_send_rma_reason(ras_core->dev);
> > +               break;
> > +       case RAS_EVENT_ID__RESET_GPU:
> > +               ret =3D amdgpu_ras_mgr_reset_gpu(ras_core->dev, *(uint3=
2_t *)data);
> > +               break;
> > +       default:
> > +               RAS_DEV_WARN(ras_core->dev, "Invalid ras notify event:%=
d\n", event_id);
> > +               break;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static u64 amdgpu_ras_sys_get_utc_second_timestamp(struct
> > +ras_core_context *ras_core) {
> > +       return ktime_get_real_seconds(); }
> > +
> > +static int amdgpu_ras_sys_check_gpu_status(struct ras_core_context *ra=
s_core,
> > +                               uint32_t *status) {
> > +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core=
->dev;
> > +       uint32_t gpu_status =3D 0;
> > +
> > +       if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev))
> > +               gpu_status |=3D RAS_GPU_STATUS__IN_RESET;
> > +
> > +       if (amdgpu_sriov_vf(adev))
> > +               gpu_status |=3D RAS_GPU_STATUS__IS_VF;
> > +
> > +       *status =3D gpu_status;
> > +
> > +       return 0;
> > +}
> > +
> > +static int amdgpu_ras_sys_get_device_system_info(struct ras_core_conte=
xt *ras_core,
> > +                       struct device_system_info *dev_info) {
> > +       struct amdgpu_device *adev =3D (struct amdgpu_device
> > +*)ras_core->dev;
> > +
> > +       dev_info->device_id =3D adev->pdev->device;
> > +       dev_info->vendor_id =3D adev->pdev->vendor;
> > +       dev_info->socket_id =3D adev->smuio.funcs->get_socket_id(adev);
> > +
> > +       return 0;
> > +}
> > +
> > +static int amdgpu_ras_sys_gpu_reset_lock(struct ras_core_context *ras_=
core,
> > +                       bool down, bool try) {
> > +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core=
->dev;
> > +       int ret =3D 0;
> > +
> > +       if (down && try)
> > +               ret =3D down_read_trylock(&adev->reset_domain->sem);
> > +       else if (down)
> > +               down_read(&adev->reset_domain->sem);
> > +       else
> > +               up_read(&adev->reset_domain->sem);
> > +
> > +       return ret;
> > +}
> > +
> > +static bool amdgpu_ras_sys_detect_ras_interrupt(struct
> > +ras_core_context *ras_core) {
> > +       return !!atomic_read(&amdgpu_ras_in_intr);
> > +}
> > +
> > +static int amdgpu_ras_sys_get_gpu_mem(struct ras_core_context *ras_cor=
e,
> > +       enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem) {
> > +       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core=
->dev;
> > +       struct psp_context *psp =3D &adev->psp;
> > +       struct psp_ring *psp_ring;
> > +       struct ta_mem_context *mem_ctx;
> > +
> > +       if (mem_type =3D=3D GPU_MEM_TYPE_RAS_PSP_RING) {
> > +               psp_ring =3D &psp->km_ring;
> > +               gpu_mem->mem_bo =3D adev->firmware.rbuf;
> > +               gpu_mem->mem_size =3D psp_ring->ring_size;
> > +               gpu_mem->mem_mc_addr =3D psp_ring->ring_mem_mc_addr;
> > +               gpu_mem->mem_cpu_addr =3D psp_ring->ring_mem;
> > +       } else if (mem_type =3D=3D GPU_MEM_TYPE_RAS_PSP_CMD) {
> > +               gpu_mem->mem_bo =3D psp->cmd_buf_bo;
> > +               gpu_mem->mem_size =3D PSP_CMD_BUFFER_SIZE;
> > +               gpu_mem->mem_mc_addr =3D psp->cmd_buf_mc_addr;
> > +               gpu_mem->mem_cpu_addr =3D psp->cmd_buf_mem;
> > +       } else if (mem_type =3D=3D GPU_MEM_TYPE_RAS_PSP_FENCE) {
> > +               gpu_mem->mem_bo =3D psp->fence_buf_bo;
> > +               gpu_mem->mem_size =3D PSP_FENCE_BUFFER_SIZE;
> > +               gpu_mem->mem_mc_addr =3D psp->fence_buf_mc_addr;
> > +               gpu_mem->mem_cpu_addr =3D psp->fence_buf;
> > +       } else if (mem_type =3D=3D GPU_MEM_TYPE_RAS_TA_FW) {
> > +               gpu_mem->mem_bo =3D psp->fw_pri_bo;
> > +               gpu_mem->mem_size =3D PSP_1_MEG;
> > +               gpu_mem->mem_mc_addr =3D psp->fw_pri_mc_addr;
> > +               gpu_mem->mem_cpu_addr =3D psp->fw_pri_buf;
> > +       } else if (mem_type =3D=3D GPU_MEM_TYPE_RAS_TA_CMD) {
> > +               mem_ctx =3D &psp->ras_context.context.mem_context;
> > +               gpu_mem->mem_bo =3D mem_ctx->shared_bo;
> > +               gpu_mem->mem_size =3D mem_ctx->shared_mem_size;
> > +               gpu_mem->mem_mc_addr =3D mem_ctx->shared_mc_addr;
> > +               gpu_mem->mem_cpu_addr =3D mem_ctx->shared_buf;
> > +       } else {
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (!gpu_mem->mem_bo || !gpu_mem->mem_size ||
> > +               !gpu_mem->mem_mc_addr || !gpu_mem->mem_cpu_addr) {
> > +               RAS_DEV_ERR(ras_core->dev, "The ras psp gpu memory is i=
nvalid!\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int amdgpu_ras_sys_put_gpu_mem(struct ras_core_context *ras_cor=
e,
> > +       enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem) {
> > +
> > +       return 0;
> > +}
> > +
> > +const struct ras_sys_func amdgpu_ras_sys_fn =3D {
> > +       .ras_notifier =3D amdgpu_ras_sys_event_notifier,
> > +       .get_utc_second_timestamp =3D amdgpu_ras_sys_get_utc_second_tim=
estamp,
> > +       .gen_seqno =3D amdgpu_ras_sys_gen_seqno,
> > +       .check_gpu_status =3D amdgpu_ras_sys_check_gpu_status,
> > +       .get_device_system_info =3D amdgpu_ras_sys_get_device_system_in=
fo,
> > +       .gpu_reset_lock =3D amdgpu_ras_sys_gpu_reset_lock,
> > +       .detect_ras_interrupt =3D amdgpu_ras_sys_detect_ras_interrupt,
> > +       .get_gpu_mem =3D amdgpu_ras_sys_get_gpu_mem,
> > +       .put_gpu_mem =3D amdgpu_ras_sys_put_gpu_mem, };
> > diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> > b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> > new file mode 100644
> > index 000000000000..c48ff26525d6
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> > @@ -0,0 +1,109 @@
> > +/* SPDX-License-Identifier: MIT */
> > +/*
> > + * Copyright 2025 Advanced Micro Devices, Inc.
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> > +obtaining a
> > + * copy of this software and associated documentation files (the
> > +"Software"),
> > + * to deal in the Software without restriction, including without
> > +limitation
> > + * the rights to use, copy, modify, merge, publish, distribute,
> > +sublicense,
> > + * and/or sell copies of the Software, and to permit persons to whom
> > +the
> > + * Software is furnished to do so, subject to the following conditions=
:
> > + *
> > + * The above copyright notice and this permission notice shall be
> > +included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > +EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > +MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> > +SHALL
> > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> > +DAMAGES OR
> > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> > +OTHERWISE,
> > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> > +OR
> > + * OTHER DEALINGS IN THE SOFTWARE.
> > + *
> > + */
> > +
> > +#ifndef __RAS_SYS_H__
> > +#define __RAS_SYS_H__
> > +#include <linux/stdarg.h>
> > +#include <linux/printk.h>
> > +#include <linux/dev_printk.h>
> > +#include "amdgpu.h"
> > +
> > +#define RAS_DEV_ERR(device, fmt, ...)                                 =
              \
> > +       do {                                                           =
           \
> > +               if (device)                                            =
                 \
> > +                       dev_err(((struct amdgpu_device *)device)->dev, =
fmt, ##__VA_ARGS__); \
> > +               else                                                   =
               \
> > +                       printk(KERN_ERR fmt, ##__VA_ARGS__);           =
                   \
> > +       } while (0)
> > +
> > +#define RAS_DEV_WARN(device, fmt, ...)                                =
               \
> > +       do {                                                           =
            \
> > +               if (device)                                            =
                  \
> > +                       dev_warn(((struct amdgpu_device *)device)->dev,=
 fmt, ##__VA_ARGS__); \
> > +               else                                                   =
                \
> > +                       printk(KERN_WARNING fmt, ##__VA_ARGS__);       =
                    \
> > +       } while (0)
> > +
> > +#define RAS_DEV_INFO(device, fmt, ...)                                =
                 \
> > +       do {                                                           =
              \
> > +               if (device)                                            =
                    \
> > +                       dev_info(((struct amdgpu_device *)device)->dev,=
 fmt, ##__VA_ARGS__);   \
> > +               else                                                   =
                  \
> > +                       printk(KERN_INFO fmt, ##__VA_ARGS__);          =
                      \
> > +       } while (0)
> > +
> > +#define RAS_DEV_DBG(device, fmt, ...)                                 =
                 \
> > +       do {                                                           =
              \
> > +               if (device)                                            =
                    \
> > +                       dev_dbg(((struct amdgpu_device *)device)->dev, =
fmt, ##__VA_ARGS__);    \
> > +               else                                                   =
                  \
> > +                       printk(KERN_DEBUG fmt, ##__VA_ARGS__);         =
                      \
> > +       } while (0)
> > +
> > +#define RAS_INFO(fmt, ...)  printk(KERN_INFO fmt, ##__VA_ARGS__)
>
> > Why do we need these wrappers?  Is there ever a case where we don't hav=
e a device?
>
> > Alex
>
> [Thomas] Wrappers are only called in ras module, during the initializatio=
n of the ras module ,before amdgpu device pointer is attached to ras device=
, these wrappers are called and device will be NULL.
>

Thanks for clarifying.  It would probably be good to add some
kerneldoc which explains the design of the ras core and the rasmgr
components.  It would be helpful for code review and provide
documentation for developers and customers.

Alex

> > +
> > +#define RAS_DEV_RREG32_SOC15(dev, ip, inst, reg) \ ({ \
> > +       struct amdgpu_device *adev =3D (struct amdgpu_device *)dev; \
> > +       __RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BA=
SE_IDX] + reg, \
> > +                        0, ip##_HWIP, inst); \
> > +})
> > +
> > +#define RAS_DEV_WREG32_SOC15(dev, ip, inst, reg, value) \ ({ \
> > +       struct amdgpu_device *adev =3D (struct amdgpu_device *)dev; \
> > +       __WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_B=
ASE_IDX] + reg), \
> > +                         value, 0, ip##_HWIP, inst); \
> > +})
> > +
> > +/* GET_INST returns the physical instance corresponding to a logical
> > +instance */ #define RAS_GET_INST(dev, ip, inst) \ ({ \
> > +       struct amdgpu_device *adev =3D (struct amdgpu_device *)dev; \
> > +       adev->ip_map.logical_to_dev_inst ? \
> > +               adev->ip_map.logical_to_dev_inst(adev, ip##_HWIP,
> > +inst) : inst; \
> > +})
> > +
> > +#define RAS_GET_MASK(dev, ip, mask) \ ({ \
> > +       struct amdgpu_device *adev =3D (struct amdgpu_device *)dev; \
> > +       (adev->ip_map.logical_to_dev_mask ? \
> > +               adev->ip_map.logical_to_dev_mask(adev, ip##_HWIP,
> > +mask) : mask); \
> > +})
> > +
> > +static inline void *ras_radix_tree_delete_iter(struct radix_tree_root
> > +*root, void *iter) {
> > +       return radix_tree_delete(root, ((struct radix_tree_iter
> > +*)iter)->index); }
> > +
> > +static inline long ras_wait_event_interruptible_timeout(void *wq_head,
> > +                       int (*condition)(void *param), void *param,
> > +unsigned int timeout) {
> > +       return wait_event_interruptible_timeout(*(wait_queue_head_t *)w=
q_head,
> > +                               condition(param), timeout); }
> > +
> > +extern const struct ras_sys_func amdgpu_ras_sys_fn;
> > +
> > +#endif
> > --
> > 2.34.1
> >
