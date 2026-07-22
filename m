Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0F1C44539
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 15:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8096310E44B;
	Wed, 22 Jul 2026 15:12:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F3+zVyTS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B91E410E418
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 15:12:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CFDD6600B0;
 Wed, 22 Jul 2026 15:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47961F000E9;
 Wed, 22 Jul 2026 15:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784733143;
 bh=f4ChfY6jnlzkp7LQ/e19z/W8YngKsAp/w9/niRf5ydU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=F3+zVyTSftGo4cRlPBgrw77vPBYEkwGcJT2c+BcCnLW8kz+o5bP6MHp2eupA9B0Bd
 h4zluUiE6nCp2ws1iFEDs2Ix5JV5l82hxM49tCmJYuytFMCMpmI0mZ0IJzGR6hC6K0
 8JbQLFeKLBCdYi7Y80EUWSPDxXe3nPb83+bg4SO24YvANxRjHdO65RLlNxPSi8WTB4
 Si2FZXMmgkWfVhPj8WZfpdUsrOWr8ghSe/bXRuFpKCjl4ZoHoXqRI2NAIKf5sJSUro
 kCf7vQNVQzHOx5UfPXRpu34HhoA8oravG2i6iOAPA6UBCeFwCBnMoEFqRD0cJyGNpd
 xeFL8aQTlCHkA==
Message-ID: <b9903553-a977-4721-bab8-a1882359341b@kernel.org>
Date: Wed, 22 Jul 2026 10:12:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable support for PSP 15_0_5
Content-Language: en-US
To: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Sunil.Khatri@amd.com,
 Arunpravin.PaneerSelvam@amd.com
Cc: Veerabadhran.Gopalakrishnan@amd.com, Pratik.Vishwakarma@amd.com
References: <20260722081727.1691277-1-Shubhankar.MilindSardeshpande@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260722081727.1691277-1-Shubhankar.MilindSardeshpande@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 7/22/26 03:17, Shubhankar Milind Sardeshpande wrote:
> Add PSP 15.0.5 related offsets for GFX to KMD interface
> and enable support for it.
> 
> Co-developed-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>

A few minor comments below.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  5 +-
>   drivers/gpu/drm/amd/amdgpu/psp_v15_0.c        | 93 ++++++++++++++++---
>   3 files changed, 83 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 44e7d2e3e6df..f9f3e5ddcbe7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2530,6 +2530,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
>   		break;
>   	case IP_VERSION(15, 0, 0):
>   	case IP_VERSION(15, 0, 9):
> +	case IP_VERSION(15, 0, 5):

I would put 15.0.5 between 15.0.0 and 15.0.9.

>   		amdgpu_device_ip_block_add(adev, &psp_v15_0_ip_block);
>   		break;
>   	case IP_VERSION(15, 0, 8):
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index fdcba94ec0d1..3e49af8414ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -276,6 +276,7 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
>   		break;
>   	case IP_VERSION(15, 0, 0):
>   	case IP_VERSION(15, 0, 9):
> +	case IP_VERSION(15, 0, 5):

Similarly here I would put 15.0.5 between 15.0.0 and 15.0.9.

>   		psp_v15_0_0_set_psp_funcs(psp);
>   		psp->boot_time_tmr = false;
>   		break;
> @@ -3509,7 +3510,9 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
>   		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
>   			     IP_VERSION(15, 0, 8) ||
>   		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
> -			     IP_VERSION(15, 0, 9)) &&
> +			     IP_VERSION(15, 0, 9) ||
> +			amdgpu_ip_version(adev, MP0_HWIP, 0) ==
> +			     IP_VERSION(15, 0, 5)) &&

Similarly here I would put 15.0.5 between 15.0.0 and 15.0.9.

>   		    (ucode->ucode_id == AMDGPU_UCODE_ID_SDMA1 ||
>   		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA2 ||
>   		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA3))
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> index 2a4d91368ac6..f4ace98171bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> @@ -31,8 +31,21 @@
>   #include "mp/mp_15_0_0_offset.h"
>   #include "mp/mp_15_0_0_sh_mask.h"
>   
> +#define regMPASP_PCRU0_MPASP_C2PMSG_64                                         0x4280
> +#define regMPASP_PCRU0_MPASP_C2PMSG_64_BASE_IDX                                2
> +#define regMPASP_PCRU0_MPASP_C2PMSG_67                                         0x4283
> +#define regMPASP_PCRU0_MPASP_C2PMSG_67_BASE_IDX                                2
> +#define regMPASP_PCRU0_MPASP_C2PMSG_69                                         0x4285
> +#define regMPASP_PCRU0_MPASP_C2PMSG_69_BASE_IDX                                2
> +#define regMPASP_PCRU0_MPASP_C2PMSG_70                                         0x4286
> +#define regMPASP_PCRU0_MPASP_C2PMSG_70_BASE_IDX                                2
> +#define regMPASP_PCRU0_MPASP_C2PMSG_71                                         0x4287
> +#define regMPASP_PCRU0_MPASP_C2PMSG_71_BASE_IDX                                2
> +
>   MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_5_toc.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_5_ta.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta.bin");
>   
> @@ -71,14 +84,25 @@ static int psp_v15_0_0_ring_stop(struct psp_context *psp,
>   		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
>   				   0x80000000, 0x80000000, false);
>   	} else {
> -		/* Write the ring destroy command*/
> -		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64,
> -			     GFX_CTRL_CMD_ID_DESTROY_RINGS);
> -		/* there might be handshake issue with hardware which needs delay */
> -		mdelay(20);
> -		/* Wait for response flag (bit 31) */
> -		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64),
> -				   0x80000000, 0x80000000, false);
> +		if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(15, 0, 5)) {
> +				/* Write the ring destroy command*/
> +			WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_64,
> +					GFX_CTRL_CMD_ID_DESTROY_RINGS);
> +			/* there might be handshake issue with hardware which needs delay */
> +			mdelay(20);
> +			/* Wait for response flag (bit 31) */
> +			ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_64),
> +					0x80000000, 0x80000000, false);
> +			} else {
> +				/* Write the ring destroy command*/
> +				WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64,
> +						GFX_CTRL_CMD_ID_DESTROY_RINGS);
> +				/* there might be handshake issue with hardware which needs delay */
> +				mdelay(20);
> +				/* Wait for response flag (bit 31) */
> +				ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64),
> +						0x80000000, 0x80000000, false);
> +		}
>   	}
>   
>   	return ret;
> @@ -118,14 +142,44 @@ static int psp_v15_0_0_ring_create(struct psp_context *psp,
>   				   0x80000000, 0x8000FFFF, false);
>   
>   	} else {
> -		/* Wait for sOS ready for ring creation */
> -		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64),
> -				   0x80000000, 0x80000000, false);
> +		if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(15, 0, 5)) {
> +			/* Wait for sOS ready for ring creation */
> +			ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_64),
> +					0x80000000, 0x80000000, false);
>   		if (ret) {
>   			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
>   			return ret;
>   		}
>   
> +		/* Write low address of the ring to C2PMSG_69 */
> +		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
> +		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_69, psp_ring_reg);
> +		/* Write high address of the ring to C2PMSG_70 */
> +		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
> +		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_70, psp_ring_reg);
> +		/* Write size of ring to C2PMSG_71 */
> +		psp_ring_reg = ring->ring_size;
> +		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_71, psp_ring_reg);
> +		/* Write the ring initialization command to C2PMSG_64 */
> +		psp_ring_reg = ring_type;
> +		psp_ring_reg = psp_ring_reg << 16;
> +		WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_64, psp_ring_reg);
> +
> +		/* there might be handshake issue with hardware which needs delay */
> +		mdelay(20);
> +
> +		/* Wait for response flag (bit 31) in C2PMSG_64 */
> +		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_64),
> +				   0x80000000, 0x8000FFFF, false);
> +		} else {
> +			/* Wait for sOS ready for ring creation */
> +			ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64),
> +					   0x80000000, 0x80000000, false);
> +			if (ret) {
> +				DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
> +				return ret;
> +			}
> +
>   		/* Write low address of the ring to C2PMSG_69 */
>   		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
>   		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_69, psp_ring_reg);
> @@ -146,6 +200,7 @@ static int psp_v15_0_0_ring_create(struct psp_context *psp,
>   		/* Wait for response flag (bit 31) in C2PMSG_64 */
>   		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_64),
>   				   0x80000000, 0x8000FFFF, false);
> +		}
>   	}
>   
>   	return ret;
> @@ -176,8 +231,12 @@ static uint32_t psp_v15_0_0_ring_get_wptr(struct psp_context *psp)
>   
>   	if (amdgpu_sriov_vf(adev))
>   		data = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102);
> -	else
> -		data = RREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_67);
> +	else {
> +		if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(15, 0, 5))
> +			data = RREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_67);
> +		else
> +			data = RREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_67);
> +		}
>   
>   	return data;
>   }
> @@ -190,8 +249,12 @@ static void psp_v15_0_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
>   		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102, value);
>   		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101,
>   			     GFX_CTRL_CMD_ID_CONSUME_CMD);
> -	} else
> -		WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_67, value);
> +	} else {
> +		if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(15, 0, 5))
> +			WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_67, value);
> +		else
> +			WREG32_SOC15(MP0, 0, regMPASP_PCRU1_MPASP_C2PMSG_67, value);
> +	}
>   }
>   
>   static const struct psp_funcs psp_v15_0_0_funcs = {

