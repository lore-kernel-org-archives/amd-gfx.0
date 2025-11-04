Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B989CCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 10:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F86610E5BD;
	Tue,  4 Nov 2025 10:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="n8K/Se0Y";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C57510E5BD
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 10:47:23 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-477563bcaacso3264885e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Nov 2025 02:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1762253242; x=1762858042; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wLoppb5CQUswcERQCnU5DvnE0SoVusDAerQor8GegQA=;
 b=n8K/Se0YN1bwD4+JPcInH+pwEdA9zxJZrcOyOjeD7fwSERRqv+R75VkLDUqK28R0/3
 tlToJbP8TNiOuRIeJpQcC18mFT19Q/CAZAE8PUjpwnJGjMJK58ptKfbFxAOMDYa+YIFm
 EMgNhW7wyISXvKDy5UKPA+5Mf2p5zzHQUKdvwCKIBE5G0NmBGjVbdMd17S2Bw/XcLceh
 C3jcRhWEctTeFmXlnO+cH3+NK0GEKSpbFvK9tKS4ixShiAqfw2kcCUu+byPz6zyThAtG
 FTDU8wrglqsY5G07/GwukbR3+bQqQuDbAR17QnpZi0VLStdoyTbflAlnsjB3VBMRFili
 eghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762253242; x=1762858042;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wLoppb5CQUswcERQCnU5DvnE0SoVusDAerQor8GegQA=;
 b=bag0kC9ytLEfuydcp98MNjrwxl/3K2JT+RW8qwYF1DCaCqwlv6WUaJmnyYYPHPPOVQ
 NDc8Zi5A1CLWEMZURQ0EVQsOVYqJVeD3oX5vxpBy7+1+AM43dg5F/LQPLyr911I4+C27
 QY/2D6NW+bGVEyCgFjr5p36Kp6f6yKw4YzifYA4Y8LrVcYktd342vYvGazKflzXN8w3Z
 WJ/43rXVXou/Ae/q8I4feUK1Z2/EhMO6M87haGxJWboRsG4jcfXM8j8wckSTPBZ5Z/20
 yx9cxyn5SynMd/1d73hsIGllP2NbNZtLA7vZPo2pKxEb+5M3SA7tQ/WeXsktDOMrNlnH
 +wOw==
X-Gm-Message-State: AOJu0YyJU24XMkoNog1Ko7qIHcXHwvxBcIBAbI8rrE61ZvuoNlcLKXLS
 dOb+9AqovEyD+tjr46Aeu7mupp6+es/3P0IG+FaijsnGVKTfLscvl8zQMZb4a4jvpiU=
X-Gm-Gg: ASbGncswf9u8vtHw28QPJW8fpgFz1TyZvEM10nQfn3nlUMKqQvpNaOLJoh7L/eGD6Ck
 Dl1FrDVN9mrbOC2wfk6+8c2jOG4QzOK+AoY0hmzQa4uan8dyqUV0WO/h3MV2eWjJ2rExTlkGsha
 5So+O5SlxoY8C62Cfzj6uk3txS98jo0dqzsVJUEPebA81iWQjyOHuNbVxtjsUqXn/gTJegZbRw9
 0QHZTHSYKYtQygKAj6qh5SqX28AHFZDDz66wC5kVmu41jGN1eRaCecK/WaoCrKyw24HT034Kiko
 DexjE/4igwi+S7ki7+O5APO/9coczfCDucKj4a3kqy0kQmV7LHOEK9xxu4Qn5fX6EORYQMZf0JK
 6Fpngq2rfVDiJxyn9X1Ab3kuJO3DlnxS83nCPl5+YGaXWU+T7dmFo6BOXvFjDCn8tpe6vVQNQuJ
 QD/wb4u7DIr5hNUe2e
X-Google-Smtp-Source: AGHT+IFCbkH9INpbmm9cSdQ2Iip0EhFXzFvC5BzRtSNU94WFKL9BCO8CMyeHxbhJhGp+b2+gppTcoQ==
X-Received: by 2002:a05:600c:501e:b0:471:152a:e566 with SMTP id
 5b1f17b1804b1-477307c2944mr135904865e9.13.1762253241362; 
 Tue, 04 Nov 2025 02:47:21 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477558e695esm15121335e9.2.2025.11.04.02.47.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 02:47:20 -0800 (PST)
Message-ID: <81de8314-0464-41c4-be2b-800929b2b45a@ursulin.net>
Date: Tue, 4 Nov 2025 10:47:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] drm/amd/ras: Add amdgpu ras system functions
To: Alex Deucher <alexdeucher@gmail.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
References: <20250918013507.2629620-1-YiPeng.Chai@amd.com>
 <20250918013507.2629620-6-YiPeng.Chai@amd.com>
 <CADnq5_OuPMaiTXuLjBtn7pHT9zVZbYUT6H3CnxU+qtknLVyyaA@mail.gmail.com>
 <CH2PR12MB4215C452FEFDDACD77865549FC11A@CH2PR12MB4215.namprd12.prod.outlook.com>
 <CADnq5_Mx3Miq+k8Nd5SLektvcsvdrOxpvyqHdky+m+NZihXQHQ@mail.gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <CADnq5_Mx3Miq+k8Nd5SLektvcsvdrOxpvyqHdky+m+NZihXQHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 19/09/2025 14:19, Alex Deucher wrote:
> On Thu, Sep 18, 2025 at 8:55 PM Chai, Thomas <YiPeng.Chai@amd.com> wrote:
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
>> Sent: Friday, September 19, 2025 4:05 AM
>> To: Chai, Thomas <YiPeng.Chai@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
>> Subject: Re: [PATCH 06/10] drm/amd/ras: Add amdgpu ras system functions
>>
>> On Wed, Sep 17, 2025 at 9:37 PM YiPeng Chai <YiPeng.Chai@amd.com> wrote:
>>>
>>> Add amdgpu ras system functions.
>>>
>>> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
>>> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
>>> ---
>>>   .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  | 268 ++++++++++++++++++
>>>   drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h     | 109 +++++++
>>>   2 files changed, 377 insertions(+)
>>>   create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
>>>   create mode 100644 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
>>>
>>> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
>>> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
>>> new file mode 100644
>>> index 000000000000..40071b876333
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
>>> @@ -0,0 +1,268 @@
>>> +// SPDX-License-Identifier: MIT
>>> +/*
>>> + * Copyright 2025 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person
>>> +obtaining a
>>> + * copy of this software and associated documentation files (the
>>> +"Software"),
>>> + * to deal in the Software without restriction, including without
>>> +limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute,
>>> +sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to whom
>>> +the
>>> + * Software is furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be
>>> +included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>> +EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>> +MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
>>> +SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>>> +DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>> +OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
>>> +OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +#include "ras_sys.h"
>>> +#include "amdgpu_ras_mgr.h"
>>> +#include "amdgpu_ras.h"
>>> +#include "amdgpu_reset.h"
>>> +
>>> +static int amdgpu_ras_sys_detect_fatal_event(struct ras_core_context
>>> +*ras_core, void *data) {
>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
>>> +       uint64_t seq_no;
>>> +
>>> +       seq_no = amdgpu_ras_mgr_gen_ras_event_seqno(adev, RAS_SEQNO_TYPE_UE);
>>> +       RAS_DEV_INFO(adev,
>>> +               "{%llu} Uncorrectable hardware error(ERREVENT_ATHUB_INTERRUPT) detected!\n",
>>> +               seq_no);
>>> +
>>> +       return amdgpu_ras_process_handle_unexpected_interrupt(adev,
>>> +data); }
>>> +
>>> +static int amdgpu_ras_sys_poison_consumption_event(struct ras_core_context *ras_core,
>>> +                               void *data) {
>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
>>> +       struct ras_event_req *req = (struct ras_event_req *)data;
>>> +       pasid_notify pasid_fn;
>>> +
>>> +       if (!req)
>>> +               return -EINVAL;
>>> +
>>> +       if (req->pasid_fn) {
>>> +               pasid_fn = (pasid_notify)req->pasid_fn;
>>> +               pasid_fn(adev, req->pasid, req->data);
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int amdgpu_ras_sys_gen_seqno(struct ras_core_context *ras_core,
>>> +                       enum ras_seqno_type seqno_type, uint64_t
>>> +*seqno) {
>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
>>> +       struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(adev);
>>> +       struct ras_event_manager *event_mgr;
>>> +       struct ras_event_state *event_state;
>>> +       struct amdgpu_hive_info *hive;
>>> +       enum ras_event_type event_type;
>>> +       uint64_t seq_no;
>>> +
>>> +       if (!ras_mgr || !seqno ||
>>> +               (seqno_type >= RAS_SEQNO_TYPE_COUNT_MAX))
>>> +               return -EINVAL;
>>> +
>>> +       switch (seqno_type) {
>>> +       case RAS_SEQNO_TYPE_UE:
>>> +               event_type = RAS_EVENT_TYPE_FATAL;
>>> +               break;
>>> +       case RAS_SEQNO_TYPE_CE:
>>> +       case RAS_SEQNO_TYPE_DE:
>>> +               event_type = RAS_EVENT_TYPE_POISON_CREATION;
>>> +               break;
>>> +       case RAS_SEQNO_TYPE_POISON_CONSUMPTION:
>>> +               event_type = RAS_EVENT_TYPE_POISON_CONSUMPTION;
>>> +               break;
>>> +       default:
>>> +               event_type = RAS_EVENT_TYPE_INVALID;
>>> +               break;
>>> +       }
>>> +
>>> +       hive = amdgpu_get_xgmi_hive(adev);
>>> +       event_mgr = hive ? &hive->event_mgr : &ras_mgr->ras_event_mgr;
>>> +       event_state = &event_mgr->event_state[event_type];
>>> +       if ((event_type == RAS_EVENT_TYPE_FATAL) && amdgpu_ras_in_recovery(adev)) {
>>> +               seq_no = event_state->last_seqno;
>>> +       } else {
>>> +               seq_no = atomic64_inc_return(&event_mgr->seqno);
>>> +               event_state->last_seqno = seq_no;
>>> +               atomic64_inc(&event_state->count);
>>> +       }
>>> +       amdgpu_put_xgmi_hive(hive);
>>> +
>>> +       *seqno = seq_no;
>>> +       return 0;
>>> +
>>> +}
>>> +
>>> +static int amdgpu_ras_sys_event_notifier(struct ras_core_context *ras_core,
>>> +                                  enum ras_notify_event event_id,
>>> +void *data) {
>>> +       struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(ras_core->dev);
>>> +       int ret = 0;
>>> +
>>> +       switch (event_id) {
>>> +       case RAS_EVENT_ID__BAD_PAGE_DETECTED:
>>> +               schedule_delayed_work(&ras_mgr->retire_page_dwork, 0);
>>> +               break;
>>> +       case RAS_EVENT_ID__POISON_CONSUMPTION:
>>> +               amdgpu_ras_sys_poison_consumption_event(ras_core, data);
>>> +               break;
>>> +       case RAS_EVENT_ID__RESERVE_BAD_PAGE:
>>> +               ret = amdgpu_ras_reserve_page(ras_core->dev, *(uint64_t *)data);
>>> +               break;
>>> +       case RAS_EVENT_ID__FATAL_ERROR_DETECTED:
>>> +               ret = amdgpu_ras_sys_detect_fatal_event(ras_core, data);
>>> +               break;
>>> +       case RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM:
>>> +               ret = amdgpu_dpm_send_hbm_bad_pages_num(ras_core->dev, *(uint32_t *)data);
>>> +               break;
>>> +       case RAS_EVENT_ID__UPDATE_BAD_CHANNEL_BITMAP:
>>> +               ret = amdgpu_dpm_send_hbm_bad_channel_flag(ras_core->dev, *(uint32_t *)data);
>>> +               break;
>>> +       case RAS_EVENT_ID__DEVICE_RMA:
>>> +               ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_RMA, NULL, NULL);
>>> +               ret = amdgpu_dpm_send_rma_reason(ras_core->dev);
>>> +               break;
>>> +       case RAS_EVENT_ID__RESET_GPU:
>>> +               ret = amdgpu_ras_mgr_reset_gpu(ras_core->dev, *(uint32_t *)data);
>>> +               break;
>>> +       default:
>>> +               RAS_DEV_WARN(ras_core->dev, "Invalid ras notify event:%d\n", event_id);
>>> +               break;
>>> +       }
>>> +
>>> +       return ret;
>>> +}
>>> +
>>> +static u64 amdgpu_ras_sys_get_utc_second_timestamp(struct
>>> +ras_core_context *ras_core) {
>>> +       return ktime_get_real_seconds(); }
>>> +
>>> +static int amdgpu_ras_sys_check_gpu_status(struct ras_core_context *ras_core,
>>> +                               uint32_t *status) {
>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
>>> +       uint32_t gpu_status = 0;
>>> +
>>> +       if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev))
>>> +               gpu_status |= RAS_GPU_STATUS__IN_RESET;
>>> +
>>> +       if (amdgpu_sriov_vf(adev))
>>> +               gpu_status |= RAS_GPU_STATUS__IS_VF;
>>> +
>>> +       *status = gpu_status;
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int amdgpu_ras_sys_get_device_system_info(struct ras_core_context *ras_core,
>>> +                       struct device_system_info *dev_info) {
>>> +       struct amdgpu_device *adev = (struct amdgpu_device
>>> +*)ras_core->dev;
>>> +
>>> +       dev_info->device_id = adev->pdev->device;
>>> +       dev_info->vendor_id = adev->pdev->vendor;
>>> +       dev_info->socket_id = adev->smuio.funcs->get_socket_id(adev);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int amdgpu_ras_sys_gpu_reset_lock(struct ras_core_context *ras_core,
>>> +                       bool down, bool try) {
>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
>>> +       int ret = 0;
>>> +
>>> +       if (down && try)
>>> +               ret = down_read_trylock(&adev->reset_domain->sem);
>>> +       else if (down)
>>> +               down_read(&adev->reset_domain->sem);
>>> +       else
>>> +               up_read(&adev->reset_domain->sem);
>>> +
>>> +       return ret;
>>> +}
>>> +
>>> +static bool amdgpu_ras_sys_detect_ras_interrupt(struct
>>> +ras_core_context *ras_core) {
>>> +       return !!atomic_read(&amdgpu_ras_in_intr);
>>> +}
>>> +
>>> +static int amdgpu_ras_sys_get_gpu_mem(struct ras_core_context *ras_core,
>>> +       enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem) {
>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
>>> +       struct psp_context *psp = &adev->psp;
>>> +       struct psp_ring *psp_ring;
>>> +       struct ta_mem_context *mem_ctx;
>>> +
>>> +       if (mem_type == GPU_MEM_TYPE_RAS_PSP_RING) {
>>> +               psp_ring = &psp->km_ring;
>>> +               gpu_mem->mem_bo = adev->firmware.rbuf;
>>> +               gpu_mem->mem_size = psp_ring->ring_size;
>>> +               gpu_mem->mem_mc_addr = psp_ring->ring_mem_mc_addr;
>>> +               gpu_mem->mem_cpu_addr = psp_ring->ring_mem;
>>> +       } else if (mem_type == GPU_MEM_TYPE_RAS_PSP_CMD) {
>>> +               gpu_mem->mem_bo = psp->cmd_buf_bo;
>>> +               gpu_mem->mem_size = PSP_CMD_BUFFER_SIZE;
>>> +               gpu_mem->mem_mc_addr = psp->cmd_buf_mc_addr;
>>> +               gpu_mem->mem_cpu_addr = psp->cmd_buf_mem;
>>> +       } else if (mem_type == GPU_MEM_TYPE_RAS_PSP_FENCE) {
>>> +               gpu_mem->mem_bo = psp->fence_buf_bo;
>>> +               gpu_mem->mem_size = PSP_FENCE_BUFFER_SIZE;
>>> +               gpu_mem->mem_mc_addr = psp->fence_buf_mc_addr;
>>> +               gpu_mem->mem_cpu_addr = psp->fence_buf;
>>> +       } else if (mem_type == GPU_MEM_TYPE_RAS_TA_FW) {
>>> +               gpu_mem->mem_bo = psp->fw_pri_bo;
>>> +               gpu_mem->mem_size = PSP_1_MEG;
>>> +               gpu_mem->mem_mc_addr = psp->fw_pri_mc_addr;
>>> +               gpu_mem->mem_cpu_addr = psp->fw_pri_buf;
>>> +       } else if (mem_type == GPU_MEM_TYPE_RAS_TA_CMD) {
>>> +               mem_ctx = &psp->ras_context.context.mem_context;
>>> +               gpu_mem->mem_bo = mem_ctx->shared_bo;
>>> +               gpu_mem->mem_size = mem_ctx->shared_mem_size;
>>> +               gpu_mem->mem_mc_addr = mem_ctx->shared_mc_addr;
>>> +               gpu_mem->mem_cpu_addr = mem_ctx->shared_buf;
>>> +       } else {
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       if (!gpu_mem->mem_bo || !gpu_mem->mem_size ||
>>> +               !gpu_mem->mem_mc_addr || !gpu_mem->mem_cpu_addr) {
>>> +               RAS_DEV_ERR(ras_core->dev, "The ras psp gpu memory is invalid!\n");
>>> +               return -ENOMEM;
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int amdgpu_ras_sys_put_gpu_mem(struct ras_core_context *ras_core,
>>> +       enum gpu_mem_type mem_type, struct gpu_mem_block *gpu_mem) {
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +const struct ras_sys_func amdgpu_ras_sys_fn = {
>>> +       .ras_notifier = amdgpu_ras_sys_event_notifier,
>>> +       .get_utc_second_timestamp = amdgpu_ras_sys_get_utc_second_timestamp,
>>> +       .gen_seqno = amdgpu_ras_sys_gen_seqno,
>>> +       .check_gpu_status = amdgpu_ras_sys_check_gpu_status,
>>> +       .get_device_system_info = amdgpu_ras_sys_get_device_system_info,
>>> +       .gpu_reset_lock = amdgpu_ras_sys_gpu_reset_lock,
>>> +       .detect_ras_interrupt = amdgpu_ras_sys_detect_ras_interrupt,
>>> +       .get_gpu_mem = amdgpu_ras_sys_get_gpu_mem,
>>> +       .put_gpu_mem = amdgpu_ras_sys_put_gpu_mem, };
>>> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
>>> b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
>>> new file mode 100644
>>> index 000000000000..c48ff26525d6
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
>>> @@ -0,0 +1,109 @@
>>> +/* SPDX-License-Identifier: MIT */
>>> +/*
>>> + * Copyright 2025 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person
>>> +obtaining a
>>> + * copy of this software and associated documentation files (the
>>> +"Software"),
>>> + * to deal in the Software without restriction, including without
>>> +limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute,
>>> +sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to whom
>>> +the
>>> + * Software is furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be
>>> +included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>> +EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>> +MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
>>> +SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>>> +DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>> +OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
>>> +OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +
>>> +#ifndef __RAS_SYS_H__
>>> +#define __RAS_SYS_H__
>>> +#include <linux/stdarg.h>
>>> +#include <linux/printk.h>
>>> +#include <linux/dev_printk.h>
>>> +#include "amdgpu.h"
>>> +
>>> +#define RAS_DEV_ERR(device, fmt, ...)                                               \
>>> +       do {                                                                      \
>>> +               if (device)                                                             \
>>> +                       dev_err(((struct amdgpu_device *)device)->dev, fmt, ##__VA_ARGS__); \
>>> +               else                                                                  \
>>> +                       printk(KERN_ERR fmt, ##__VA_ARGS__);                              \
>>> +       } while (0)
>>> +
>>> +#define RAS_DEV_WARN(device, fmt, ...)                                               \
>>> +       do {                                                                       \
>>> +               if (device)                                                              \
>>> +                       dev_warn(((struct amdgpu_device *)device)->dev, fmt, ##__VA_ARGS__); \
>>> +               else                                                                   \
>>> +                       printk(KERN_WARNING fmt, ##__VA_ARGS__);                           \
>>> +       } while (0)
>>> +
>>> +#define RAS_DEV_INFO(device, fmt, ...)                                                 \
>>> +       do {                                                                         \
>>> +               if (device)                                                                \
>>> +                       dev_info(((struct amdgpu_device *)device)->dev, fmt, ##__VA_ARGS__);   \
>>> +               else                                                                     \
>>> +                       printk(KERN_INFO fmt, ##__VA_ARGS__);                                \
>>> +       } while (0)
>>> +
>>> +#define RAS_DEV_DBG(device, fmt, ...)                                                  \
>>> +       do {                                                                         \
>>> +               if (device)                                                                \
>>> +                       dev_dbg(((struct amdgpu_device *)device)->dev, fmt, ##__VA_ARGS__);    \
>>> +               else                                                                     \
>>> +                       printk(KERN_DEBUG fmt, ##__VA_ARGS__);                               \
>>> +       } while (0)
>>> +
>>> +#define RAS_INFO(fmt, ...)  printk(KERN_INFO fmt, ##__VA_ARGS__)
>>
>>> Why do we need these wrappers?  Is there ever a case where we don't have a device?
>>
>>> Alex
>>
>> [Thomas] Wrappers are only called in ras module, during the initialization of the ras module ,before amdgpu device pointer is attached to ras device, these wrappers are called and device will be NULL.
>>
> 
> Thanks for clarifying.  It would probably be good to add some
> kerneldoc which explains the design of the ras core and the rasmgr
> components.  It would be helpful for code review and provide
> documentation for developers and customers.

Stumbled upon this while looking at something else.

Note also that dev_printk handles the NULL device. So wrappers could be 
removed.

Regards,

Tvrtko

> 
> Alex
> 
>>> +
>>> +#define RAS_DEV_RREG32_SOC15(dev, ip, inst, reg) \ ({ \
>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)dev; \
>>> +       __RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
>>> +                        0, ip##_HWIP, inst); \
>>> +})
>>> +
>>> +#define RAS_DEV_WREG32_SOC15(dev, ip, inst, reg, value) \ ({ \
>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)dev; \
>>> +       __WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), \
>>> +                         value, 0, ip##_HWIP, inst); \
>>> +})
>>> +
>>> +/* GET_INST returns the physical instance corresponding to a logical
>>> +instance */ #define RAS_GET_INST(dev, ip, inst) \ ({ \
>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)dev; \
>>> +       adev->ip_map.logical_to_dev_inst ? \
>>> +               adev->ip_map.logical_to_dev_inst(adev, ip##_HWIP,
>>> +inst) : inst; \
>>> +})
>>> +
>>> +#define RAS_GET_MASK(dev, ip, mask) \ ({ \
>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)dev; \
>>> +       (adev->ip_map.logical_to_dev_mask ? \
>>> +               adev->ip_map.logical_to_dev_mask(adev, ip##_HWIP,
>>> +mask) : mask); \
>>> +})
>>> +
>>> +static inline void *ras_radix_tree_delete_iter(struct radix_tree_root
>>> +*root, void *iter) {
>>> +       return radix_tree_delete(root, ((struct radix_tree_iter
>>> +*)iter)->index); }
>>> +
>>> +static inline long ras_wait_event_interruptible_timeout(void *wq_head,
>>> +                       int (*condition)(void *param), void *param,
>>> +unsigned int timeout) {
>>> +       return wait_event_interruptible_timeout(*(wait_queue_head_t *)wq_head,
>>> +                               condition(param), timeout); }
>>> +
>>> +extern const struct ras_sys_func amdgpu_ras_sys_fn;
>>> +
>>> +#endif
>>> --
>>> 2.34.1
>>>

