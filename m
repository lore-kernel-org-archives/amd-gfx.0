Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7D9C2BD09
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 18:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCECE10E1D9;
	Mon, 24 Jun 2024 18:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CQPJgB7L";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D656D10E1D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 18:36:15 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-42138eadf64so39782245e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 11:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719254174; x=1719858974; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+51Ldu5BFzr1GJMJFwYpedhma3niOLTjz75x3xUSZzk=;
 b=CQPJgB7LOzYc773Qyfs+/tHU8JJ5sYs3tajAG5yrWYmven553bLF5Hhsi06A0/gqhb
 VseneOBzLUX9JON70LsvispQt7lS64UjrhuZXmllrIsqvzBCvAk+ODguMHugKJ7r+DuU
 KhmxID9FnFauMoYfvmdARaIRP3R/gR8iGmuJkcbJrbmAR57Hm4BMlKSa3Uyx6xNOxy5W
 EtIqccddOCFQR/c0iwbRPJKTHhNZkZIzya5pnRVCcodQF0Qo5BHsCRLds7q65FDpCsHH
 VYIc6Y71bgIEpY2ifZa3IDSVfADYuDFHqGhh9GkgZ2sJ7BpQxe+7herpQUmuBk+9A9FK
 mJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719254174; x=1719858974;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+51Ldu5BFzr1GJMJFwYpedhma3niOLTjz75x3xUSZzk=;
 b=JiWRJofGvz9r+KkQudPlCymi2Rjfk2yUmqksFUWmVDIuV/aTMiQSvbANpDoDZCcU4+
 8MgbbQ/ElNx8Z3rEMA/BuEMLyALvJ4wuJZXPs56QRWNkzoNfXSarSWVmWmp3D/3JlOnu
 PwzAazZixUVh8i1L19QHJZFyPTZOYE+vERoibTSwp4ianPrbm4JOjFQaQxB1K+bzbI49
 TzOrmKM+xUA94quJ5/cYKw8BzkoEdiRJXOB9kmK7bsh3/mVF/HY94GxvLrzxtzfn531M
 ewgZ1RqBTGuPhY/mR4bO0JJ2/Wt/U3gPVvIP3OM7EhTAIluUrBNTS04s7bO7xrHi8yKe
 Lx5Q==
X-Gm-Message-State: AOJu0YzsKjUYbLfmz9b6IgHeSMrUtVe9g+xWaeWGPdlltNN4Qqeehe6S
 FsqDEOXkby6a2XRBoPDxsRg1GDoREA9HjPRiOhgE0uhKu33VJnzE
X-Google-Smtp-Source: AGHT+IFLRK7IeIeoiHg5ZbvSrGQhxR+/XvkSpeU76+bdHl7yYC+t6A6d+e7//FWRczM8V/dmST0zcw==
X-Received: by 2002:a05:600c:4c23:b0:421:7e6b:1b75 with SMTP id
 5b1f17b1804b1-4248cc343a7mr38961375e9.17.1719254173343; 
 Mon, 24 Jun 2024 11:36:13 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36638301cffsm10826079f8f.10.2024.06.24.11.36.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 11:36:12 -0700 (PDT)
Message-ID: <10af605c-e416-4c1f-a7ff-234724154da4@gmail.com>
Date: Mon, 24 Jun 2024 20:36:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: normalize registers as local xcc to
 read/write under sriov in TLB flush
To: "Jian, Jane" <Jane.Jian@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240624091318.2487733-1-Jane.Jian@amd.com>
 <0cf4b8a0-d36c-4cbd-ad33-f74c2d1eff29@gmail.com>
 <PH0PR12MB5481151188FFD142CD5D8281FFD42@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <PH0PR12MB5481151188FFD142CD5D8281FFD42@PH0PR12MB5481.namprd12.prod.outlook.com>
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

Well as far as I know under SRIOV most of the registers accesses go 
through the KIQ.

When the KIQ is limited in it's accessibility to only the local XCD then 
we need to handle that in the KIQ code and *not* in every user of 
register reads and writes.

So please drop that approach and implement that in the KIQ backend.

Regards,
Christian.

Am 24.06.24 um 15:50 schrieb Jian, Jane:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Christian,
> I want to explain here that:
> 1. add the normalization func in the asic file: this was modified according to previous Lijo's comments, he thought it would be more convenient if further asics need that way as well.
> 2. currently we only covered gpu flush tlb path since blocking issues, later I will submit part 2 that covers the normalization for  all sriov read/write cases(not only KIQ code.
>
> Thanks,
> Jane
>
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Monday, June 24, 2024 7:58 PM
> To: Jian, Jane <Jane.Jian@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: normalize registers as local xcc to read/write under sriov in TLB flush
>
> Am 24.06.24 um 11:13 schrieb Jane Jian:
>> [WHY]
>> sriov has the higher bit violation when flushing tlb
>>
>> [HOW]
>> normalize the registers to keep lower 16-bit(dword aligned) to aviod
>> higher bit violation RLCG will mask xcd out and always assume it's
>> accessing its own xcd
>>
>> [TODO]
>> later will add the normalization in sriovw/rreg after fixing bugs
>>
>> v2
>> rename the normalized macro, add ip block type for further use move
>> asics func declaration after ip block type since new func refers ip
>> block type add normalization in emit flush tlb as well
>>
>> v3
>> declare the new func in the asic specific header
>>
>> Signed-off-by: Jane Jian <Jane.Jian@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 112 +++++++++++----------
>>    drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c |  17 ++++
>>    drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h |  28 ++++++
>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  32 ++++--
>>    drivers/gpu/drm/amd/amdgpu/soc15.c         |   2 +
>>    drivers/gpu/drm/amd/amdgpu/soc15_common.h  |   5 +-
>>    6 files changed, 130 insertions(+), 66 deletions(-)
>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 083f353cff6e..070fd9e601fe 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -583,61 +583,6 @@ struct amdgpu_video_codecs {
>>        const struct amdgpu_video_codec_info *codec_array;
>>    };
>>
>> -/*
>> - * ASIC specific functions.
>> - */
>> -struct amdgpu_asic_funcs {
>> -     bool (*read_disabled_bios)(struct amdgpu_device *adev);
>> -     bool (*read_bios_from_rom)(struct amdgpu_device *adev,
>> -                                u8 *bios, u32 length_bytes);
>> -     int (*read_register)(struct amdgpu_device *adev, u32 se_num,
>> -                          u32 sh_num, u32 reg_offset, u32 *value);
>> -     void (*set_vga_state)(struct amdgpu_device *adev, bool state);
>> -     int (*reset)(struct amdgpu_device *adev);
>> -     enum amd_reset_method (*reset_method)(struct amdgpu_device *adev);
>> -     /* get the reference clock */
>> -     u32 (*get_xclk)(struct amdgpu_device *adev);
>> -     /* MM block clocks */
>> -     int (*set_uvd_clocks)(struct amdgpu_device *adev, u32 vclk, u32 dclk);
>> -     int (*set_vce_clocks)(struct amdgpu_device *adev, u32 evclk, u32 ecclk);
>> -     /* static power management */
>> -     int (*get_pcie_lanes)(struct amdgpu_device *adev);
>> -     void (*set_pcie_lanes)(struct amdgpu_device *adev, int lanes);
>> -     /* get config memsize register */
>> -     u32 (*get_config_memsize)(struct amdgpu_device *adev);
>> -     /* flush hdp write queue */
>> -     void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
>> -     /* invalidate hdp read cache */
>> -     void (*invalidate_hdp)(struct amdgpu_device *adev,
>> -                            struct amdgpu_ring *ring);
>> -     /* check if the asic needs a full reset of if soft reset will work */
>> -     bool (*need_full_reset)(struct amdgpu_device *adev);
>> -     /* initialize doorbell layout for specific asic*/
>> -     void (*init_doorbell_index)(struct amdgpu_device *adev);
>> -     /* PCIe bandwidth usage */
>> -     void (*get_pcie_usage)(struct amdgpu_device *adev, uint64_t *count0,
>> -                            uint64_t *count1);
>> -     /* do we need to reset the asic at init time (e.g., kexec) */
>> -     bool (*need_reset_on_init)(struct amdgpu_device *adev);
>> -     /* PCIe replay counter */
>> -     uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
>> -     /* device supports BACO */
>> -     int (*supports_baco)(struct amdgpu_device *adev);
>> -     /* pre asic_init quirks */
>> -     void (*pre_asic_init)(struct amdgpu_device *adev);
>> -     /* enter/exit umd stable pstate */
>> -     int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
>> -     /* query video codecs */
>> -     int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
>> -                               const struct amdgpu_video_codecs **codecs);
>> -     /* encode "> 32bits" smn addressing */
>> -     u64 (*encode_ext_smn_addressing)(int ext_id);
>> -
>> -     ssize_t (*get_reg_state)(struct amdgpu_device *adev,
>> -                              enum amdgpu_reg_state reg_state, void *buf,
>> -                              size_t max_size);
>> -};
>> -
>>    /*
>>     * IOCTL.
>>     */
>> @@ -728,6 +673,63 @@ enum amd_hw_ip_block_type {
>>        MAX_HWIP
>>    };
>>
>> +/*
>> + * ASIC specific functions.
>> + */
>> +struct amdgpu_asic_funcs {
>> +     bool (*read_disabled_bios)(struct amdgpu_device *adev);
>> +     bool (*read_bios_from_rom)(struct amdgpu_device *adev,
>> +                                u8 *bios, u32 length_bytes);
>> +     int (*read_register)(struct amdgpu_device *adev, u32 se_num,
>> +                          u32 sh_num, u32 reg_offset, u32 *value);
>> +     void (*set_vga_state)(struct amdgpu_device *adev, bool state);
>> +     int (*reset)(struct amdgpu_device *adev);
>> +     enum amd_reset_method (*reset_method)(struct amdgpu_device *adev);
>> +     /* get the reference clock */
>> +     u32 (*get_xclk)(struct amdgpu_device *adev);
>> +     /* MM block clocks */
>> +     int (*set_uvd_clocks)(struct amdgpu_device *adev, u32 vclk, u32 dclk);
>> +     int (*set_vce_clocks)(struct amdgpu_device *adev, u32 evclk, u32 ecclk);
>> +     /* static power management */
>> +     int (*get_pcie_lanes)(struct amdgpu_device *adev);
>> +     void (*set_pcie_lanes)(struct amdgpu_device *adev, int lanes);
>> +     /* get config memsize register */
>> +     u32 (*get_config_memsize)(struct amdgpu_device *adev);
>> +     /* flush hdp write queue */
>> +     void (*flush_hdp)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
>> +     /* invalidate hdp read cache */
>> +     void (*invalidate_hdp)(struct amdgpu_device *adev,
>> +                            struct amdgpu_ring *ring);
>> +     /* check if the asic needs a full reset of if soft reset will work */
>> +     bool (*need_full_reset)(struct amdgpu_device *adev);
>> +     /* initialize doorbell layout for specific asic*/
>> +     void (*init_doorbell_index)(struct amdgpu_device *adev);
>> +     /* PCIe bandwidth usage */
>> +     void (*get_pcie_usage)(struct amdgpu_device *adev, uint64_t *count0,
>> +                            uint64_t *count1);
>> +     /* do we need to reset the asic at init time (e.g., kexec) */
>> +     bool (*need_reset_on_init)(struct amdgpu_device *adev);
>> +     /* PCIe replay counter */
>> +     uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
>> +     /* device supports BACO */
>> +     int (*supports_baco)(struct amdgpu_device *adev);
>> +     /* pre asic_init quirks */
>> +     void (*pre_asic_init)(struct amdgpu_device *adev);
>> +     /* enter/exit umd stable pstate */
>> +     int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
>> +     /* query video codecs */
>> +     int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
>> +                               const struct amdgpu_video_codecs **codecs);
>> +     /* encode "> 32bits" smn addressing */
>> +     u64 (*encode_ext_smn_addressing)(int ext_id);
>> +
>> +     ssize_t (*get_reg_state)(struct amdgpu_device *adev,
>> +                              enum amdgpu_reg_state reg_state, void *buf,
>> +                              size_t max_size);
>> +     /* normalize offset to keep in lower 16-bit */
>> +     u32 (*normalize_reg_offset)(enum amd_hw_ip_block_type hwip, u32
>> +offset); };
>> +
>>    #define HWIP_MAX_INSTANCE   44
>>
>>    #define HW_ID_MAX           300
>> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> index 2c9a0aa41e2d..7cdd4b9d08ba 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> @@ -29,6 +29,7 @@
>>    #include "gfx_v9_4_3.h"
>>    #include "gfxhub_v1_2.h"
>>    #include "sdma_v4_4_2.h"
>> +#include "aqua_vanjaram.h"
>>
>>    #define XCP_INST_MASK(num_inst, xcp_id)                                        \
>>        (num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0) @@
>> -1085,3 +1086,19 @@ ssize_t aqua_vanjaram_get_reg_state(struct
>> amdgpu_device *adev,
>>
>>        return size;
>>    }
>> +
>> +u32 aqua_vanjaram_normalize_reg_offset(enum amd_hw_ip_block_type
>> +hwip, u32 offset) {
>> +     u32 normalized_offset;
>> +
>> +     switch (hwip) {
>> +     case GC_HWIP:
>> +             normalized_offset = offset & 0xffff;
>> +             break;
>> +     default:
>> +             normalized_offset = offset;
>> +             break;
>> +     }
>> +
>> +     return normalized_offset;
>> +}
> Please completely drop that approach. This is KIQ specific and should be handled inside the KIQ code and not here.
>
> Regards,
> Christian.
>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h
>> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h
>> new file mode 100644
>> index 000000000000..8d1b7a89cb71
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.h
>> @@ -0,0 +1,28 @@
>> +/*
>> + * Copyright 2024 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person
>> +obtaining a
>> + * copy of this software and associated documentation files (the
>> +"Software"),
>> + * to deal in the Software without restriction, including without
>> +limitation
>> + * the rights to use, copy, modify, merge, publish, distribute,
>> +sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom
>> +the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> +included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> +EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> +MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
>> +SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>> +DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>> +OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
>> +OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +#ifndef __AQUA_VANJARAM_H__
>> +#define __AQUA_VANJARAM_H__
>> +
>> +u32 aqua_vanjaram_normalize_reg_offset(enum amd_hw_ip_block_type
>> +hwip, u32 offset);
>> +
>> +#endif
>> \ No newline at end of file
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 88b4644f8e96..19e4429db37c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -853,8 +853,12 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>         */
>>        if (adev->gfx.kiq[inst].ring.sched.ready &&
>>            (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
>> -             uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
>> -             uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>> +
>> +             /* Select lower 16 bits to write in local xcc */
>> +             if (AMDGPU_IS_GFXHUB(vmhub)) {
>> +                     req = NORMALIZE_XCC_REG_OFFSET(req);
>> +                     ack = NORMALIZE_XCC_REG_OFFSET(ack);
>> +             }
>>
>>                amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
>>                                                 1 << vmid, inst);
>> @@ -979,6 +983,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>>        struct amdgpu_vmhub *hub = &adev->vmhub[ring->vm_hub];
>>        uint32_t req = gmc_v9_0_get_invalidate_req(vmid, 0);
>>        unsigned int eng = ring->vm_inv_eng;
>> +     u32 low_distance, high_distance, req_offset, ack;
>>
>>        /*
>>         * It may lose gpuvm invalidate acknowldege state across
>> power-gating @@ -986,7 +991,18 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>>         * release after invalidation to avoid entering power gated state
>>         * to WA the Issue
>>         */
>> +     low_distance = hub->ctx0_ptb_addr_lo32 + (hub->ctx_addr_distance * vmid);
>> +     high_distance = hub->ctx0_ptb_addr_hi32 + (hub->ctx_addr_distance * vmid);
>> +     req_offset = hub->vm_inv_eng0_req + hub->eng_distance * eng;
>> +     ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>>
>> +     /* Select lower 16 bits to write in local xcc */
>> +     if (AMDGPU_IS_GFXHUB(ring->vm_hub)) {
>> +             low_distance = NORMALIZE_XCC_REG_OFFSET(low_distance);
>> +             high_distance = NORMALIZE_XCC_REG_OFFSET(high_distance);
>> +             req_offset = NORMALIZE_XCC_REG_OFFSET(req_offset);
>> +             ack = NORMALIZE_XCC_REG_OFFSET(ack);
>> +     }
>>        /* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
>>        if (use_semaphore)
>>                /* a read return value of 1 means semaphore acuqire */ @@ -994,18
>> +1010,14 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>>                                          hub->vm_inv_eng0_sem +
>>                                          hub->eng_distance * eng, 0x1, 0x1);
>>
>> -     amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
>> -                           (hub->ctx_addr_distance * vmid),
>> +     amdgpu_ring_emit_wreg(ring, low_distance,
>>                              lower_32_bits(pd_addr));
>>
>> -     amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
>> -                           (hub->ctx_addr_distance * vmid),
>> +     amdgpu_ring_emit_wreg(ring, high_distance,
>>                              upper_32_bits(pd_addr));
>>
>> -     amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
>> -                                         hub->eng_distance * eng,
>> -                                         hub->vm_inv_eng0_ack +
>> -                                         hub->eng_distance * eng,
>> +     amdgpu_ring_emit_reg_write_reg_wait(ring, req_offset,
>> +                                         ack,
>>                                            req, 1 << vmid);
>>
>>        /* TODO: It needs to continue working on debugging with semaphore
>> for GFXHUB as well. */ diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> index 8d16dacdc172..3a1fa2797f02 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> @@ -78,6 +78,7 @@
>>    #include "mxgpu_ai.h"
>>    #include "amdgpu_ras.h"
>>    #include "amdgpu_xgmi.h"
>> +#include "aqua_vanjaram.h"
>>    #include <uapi/linux/kfd_ioctl.h>
>>
>>    #define mmMP0_MISC_CGTT_CTRL0                                                                   0x01b9
>> @@ -927,6 +928,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
>>        .query_video_codecs = &soc15_query_video_codecs,
>>        .encode_ext_smn_addressing = &aqua_vanjaram_encode_ext_smn_addressing,
>>        .get_reg_state = &aqua_vanjaram_get_reg_state,
>> +     .normalize_reg_offset = &aqua_vanjaram_normalize_reg_offset,
>>    };
>>
>>    static int soc15_common_early_init(void *handle) diff --git
>> a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
>> b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
>> index 242b24f73c17..01afd1a24e8b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
>> @@ -210,4 +210,7 @@
>>    #define WREG64_MCA(ext, mca_base, idx, val) \
>>        WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) +
>> mca_base + (idx * 8), val)
>>
>> -#endif
>> +#define NORMALIZE_XCC_REG_OFFSET(offset) \
>> +     ((amdgpu_sriov_vf(adev) && adev->asic_funcs->normalize_reg_offset) ? \
>> +     adev->asic_funcs->normalize_reg_offset(GC_HWIP, offset) : offset)
>> +#endif
>> \ No newline at end of file

