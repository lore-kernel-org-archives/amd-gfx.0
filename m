Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363BFC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 07:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D505A10E85B;
	Mon, 28 Mar 2022 07:52:10 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BC5410E85B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 07:52:09 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5aef5a.dynamic.kabel-deutschland.de
 [95.90.239.90])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 471FD61EA1927;
 Mon, 28 Mar 2022 09:52:07 +0200 (CEST)
Message-ID: <3c80e4e5-97fc-9222-d9a3-f676125b0f5c@molgen.mpg.de>
Date: Mon, 28 Mar 2022 09:52:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 5/6] drm/amdgpu/vcn: VCN ras error query support
Content-Language: en-US
To: Tao Zhou <Tao.Zhou1@amd.com>,
 Mohammad Zafar Ziya <Mohammadzafar.Ziya@amd.com>
References: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
 <20220328062453.4156191-6-Mohammadzafar.ziya@amd.com>
 <DM5PR12MB17706851354758760795883DB01D9@DM5PR12MB1770.namprd12.prod.outlook.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <DM5PR12MB17706851354758760795883DB01D9@DM5PR12MB1770.namprd12.prod.outlook.com>
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
Cc: Lijo Lazar <Lijo.Lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Mohammad, dear Tao,


Tao, it’s hard to find your reply in the quote, as the message is not 
quoted correctly (> prepended). Is it possible to use a different email 
client?


Am 28.03.22 um 09:43 schrieb Zhou1, Tao:
> -----Original Message-----
> From: Ziya, Mohammad zafar <Mohammadzafar.Ziya@amd.com>
> Sent: Monday, March 28, 2022 2:25 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Ziya, Mohammad zafar <Mohammadzafar.Ziya@amd.com>
> Subject: [PATCH v4 5/6] drm/amdgpu/vcn: VCN ras error query support
> 
> RAS error query support addition for VCN 2.6
> 
> V2: removed unused option and corrected comment format Moved the register definition under header file

Please wrap lines after 75 characters. (`scripts/checkpatch.pl` should 
have warned you about that).

> V3: poison query status check added.
> Removed error query interface
> 
> V4: MMSCH poison check option removed, return true/false refactored.
> 
> Signed-off-by: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 71 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h   |  6 +++
>   3 files changed, 78 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 1e1a3b736859..606df8869b89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -508,6 +508,7 @@ struct amdgpu_ras_block_hw_ops {
>   	void (*query_ras_error_address)(struct amdgpu_device *adev, void *ras_error_status);
>   	void (*reset_ras_error_count)(struct amdgpu_device *adev);
>   	void (*reset_ras_error_status)(struct amdgpu_device *adev);
> +	bool (*query_poison_status)(struct amdgpu_device *adev);
>   };
>   
>   /* work flow
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 1869bae4104b..3988fc647741 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -31,6 +31,7 @@
>   #include "soc15d.h"
>   #include "vcn_v2_0.h"
>   #include "mmsch_v1_0.h"
> +#include "vcn_v2_5.h"
>   
>   #include "vcn/vcn_2_5_offset.h"
>   #include "vcn/vcn_2_5_sh_mask.h"
> @@ -59,6 +60,7 @@ static int vcn_v2_5_set_powergating_state(void *handle,  static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
>   				int inst_idx, struct dpg_pause_state *new_state);  static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
> +static void vcn_v2_5_set_ras_funcs(struct amdgpu_device *adev);
>   
>   static int amdgpu_ih_clientid_vcns[] = {
>   	SOC15_IH_CLIENTID_VCN,
> @@ -100,6 +102,7 @@ static int vcn_v2_5_early_init(void *handle)
>   	vcn_v2_5_set_dec_ring_funcs(adev);
>   	vcn_v2_5_set_enc_ring_funcs(adev);
>   	vcn_v2_5_set_irq_funcs(adev);
> +	vcn_v2_5_set_ras_funcs(adev);
>   
>   	return 0;
>   }
> @@ -1930,3 +1933,71 @@ const struct amdgpu_ip_block_version vcn_v2_6_ip_block =
>   		.rev = 0,
>   		.funcs = &vcn_v2_6_ip_funcs,
>   };
> +
> +static uint32_t vcn_v2_6_query_poison_by_instance(struct amdgpu_device *adev,
> +			uint32_t instance, uint32_t sub_block) {
> +	uint32_t poison_stat = 0, reg_value = 0;
> +
> +	switch (sub_block) {
> +	case AMDGPU_VCN_V2_6_VCPU_VCODEC:
> +		reg_value = RREG32_SOC15(VCN, instance, mmUVD_RAS_VCPU_VCODEC_STATUS);
> +		poison_stat = REG_GET_FIELD(reg_value, UVD_RAS_VCPU_VCODEC_STATUS, POISONED_PF);
> +		break;
> +	default:
> +		break;
> +	};
> +
> +	if (poison_stat)
> +		dev_info(adev->dev, "Poison detected in VCN%d, sub_block%d\n",
> +			instance, sub_block);

What should a user do with that information? Faulty hardware, …?

> +
> +	return poison_stat;
> +}
> +
> +static bool vcn_v2_6_query_poison_status(struct amdgpu_device *adev) {
> +	uint32_t inst, sub;
> +	uint32_t poison_stat = 0;
> +
> +	for (inst = 0; inst < adev->vcn.num_vcn_inst; inst++)
> +		for (sub = 0; sub < AMDGPU_VCN_V2_6_MAX_SUB_BLOCK; sub++)
> +			poison_stat +=
> +			vcn_v2_6_query_poison_by_instance(adev, inst, sub);
> +
> +	return poison_stat ? true : false;
> 
> [Tao] just want to confirm the logic, if the POISONED_PF of one instance is 1 and another is 0, the poison_stat is true, correct?
> Can we add a print message for this case? Same question to JPEG.

Is the `dev_info` message in `vcn_v2_6_query_poison_by_instance()` doing 
what you want?

Also, instead of `poison_stat ? true : false;` a common pattern is 
`!!poison_stat` I believe.


Kind regards,

Paul


> +}
> +
> +const struct amdgpu_ras_block_hw_ops vcn_v2_6_ras_hw_ops = {
> +	.query_poison_status = vcn_v2_6_query_poison_status, };
> +
> +static struct amdgpu_vcn_ras vcn_v2_6_ras = {
> +	.ras_block = {
> +		.hw_ops = &vcn_v2_6_ras_hw_ops,
> +	},
> +};
> +
> +static void vcn_v2_5_set_ras_funcs(struct amdgpu_device *adev) {
> +	switch (adev->ip_versions[VCN_HWIP][0]) {
> +	case IP_VERSION(2, 6, 0):
> +		adev->vcn.ras = &vcn_v2_6_ras;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (adev->vcn.ras) {
> +		amdgpu_ras_register_ras_block(adev, &adev->vcn.ras->ras_block);
> +
> +		strcpy(adev->vcn.ras->ras_block.ras_comm.name, "vcn");
> +		adev->vcn.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__VCN;
> +		adev->vcn.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
> +		adev->vcn.ras_if = &adev->vcn.ras->ras_block.ras_comm;
> +
> +		/* If don't define special ras_late_init function, use default ras_late_init */
> +		if (!adev->vcn.ras->ras_block.ras_late_init)
> +			adev->vcn.ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h
> index e72f799ed0fd..1c19af74e4fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h
> @@ -24,6 +24,12 @@
>   #ifndef __VCN_V2_5_H__
>   #define __VCN_V2_5_H__
>   
> +enum amdgpu_vcn_v2_6_sub_block {
> +	AMDGPU_VCN_V2_6_VCPU_VCODEC = 0,
> +
> +	AMDGPU_VCN_V2_6_MAX_SUB_BLOCK,
> +};
> +
>   extern const struct amdgpu_ip_block_version vcn_v2_5_ip_block;  extern const struct amdgpu_ip_block_version vcn_v2_6_ip_block;
>   
> --
> 2.25.1
