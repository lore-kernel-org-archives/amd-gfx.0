Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0395FC77B61
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 12:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F67310E3D3;
	Fri, 28 Apr 2023 12:24:02 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13C0910E3D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 12:24:01 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-50a145a0957so16650664a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 05:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682684639; x=1685276639;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U/wAxk8YwE6LzO4TReZzghNrZ2AnjwO+PGllHj2fClw=;
 b=dSiEVaP4Fpippk1nsRsKyrXPIZX8BkYti0ShEHzGbW2wBlXbSIuQDo49XfUN38KcUo
 CLi//sMXZ1WN9m4tqih3DJs0R7MoQZCCbQ+3TRBj+5KGM41wV0aoKmaJDRw1U1Bk/xg3
 ZJ0HBjDbO1Mv4z20Y5CfbfRPU+yBuzzZw1HnRa8VfL1JGRy60erfBHr1enjQ+i2YBs0g
 qHPFkeP9YgR+y8Q2HH+vMAtYnSaSKy0VEN8rZciV2Ws7aLZO8DXc8nyb279ZbikDk81t
 hxGYTVxc8lApSiIWexyrT83rAeGvuHBh7uQD03qQwP9v35WobnaO3f/3P+t0kLRr5Yhs
 dnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682684639; x=1685276639;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U/wAxk8YwE6LzO4TReZzghNrZ2AnjwO+PGllHj2fClw=;
 b=jFoa6wda3kULCrN23+ITFhcr7K3T/5abVME9pdcumoDQkw4qjyKHLorzv8BuvfGRUF
 P/TzlzChHA5D5zpOjoocw+uT4zI9JSrIBN1twGYnlJIrZxZ+w7VY77EFCVFT30FtqGNM
 9k9Sj6OMjsFWajmSFW+76vBs2Xjp4oYo9euNWENk1+cn2IqVR1BChJOjgN6hYKANyJZL
 wNiYmLNrYTNaTwIk9finap4GgFAVI4rJIo0cnz8m9PstzqOOb1thUN8AVys5j6OcNGHt
 u5dCH7Pd4P5nGD2MC/EjSUXVnBf6hnUZQjN+AbLzQRAC/M+eNXjgwfDm1qNHCtw3OUt6
 zc0Q==
X-Gm-Message-State: AC+VfDxyWwItHBQgDxMrYiYlYiaxqxL9Ufi4QpKT1ibiURl0RkTrnbEA
 /qho5Ur4AH6h+xwokDR4iKA9Js7S48Q=
X-Google-Smtp-Source: ACHHUZ6oMOHWzAm5OzYcHaLuAOSlJB41p5xnKBXHuYPIXOHMaE/aUn4uoH7csf196DgoaHqJDqCukA==
X-Received: by 2002:a05:6402:110b:b0:506:bc26:d6a3 with SMTP id
 u11-20020a056402110b00b00506bc26d6a3mr4987342edv.1.1682684638759; 
 Fri, 28 Apr 2023 05:23:58 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:beb6:5db0:ea7:9b07?
 ([2a02:908:1256:79a0:beb6:5db0:ea7:9b07])
 by smtp.gmail.com with ESMTPSA id
 k12-20020aa7c04c000000b00509dfb39b52sm5851565edo.37.2023.04.28.05.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Apr 2023 05:23:58 -0700 (PDT)
Message-ID: <28843a82-17fa-6201-ede3-324f9972b531@gmail.com>
Date: Fri, 28 Apr 2023 14:23:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amd/amdgpu: Fix style problems in amdgpu_psp.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230428120628.177429-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230428120628.177429-1-srinivasan.shanmugam@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 28.04.23 um 14:06 schrieb Srinivasan Shanmugam:
> Fix the following checkpatch warnings & error in amdgpu_psp.c
>
> WARNING: Comparisons should place the constant on the right side of the test
> WARNING: braces {} are not necessary for single statement blocks
> WARNING: please, no space before tabs
> WARNING: braces {} are not necessary for single statement blocks
> ERROR: that open brace { should be on the previous line
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 55 +++++++++++--------------
>   1 file changed, 24 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index c58654a8b6c5..996448892651 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -411,7 +411,7 @@ static int psp_sw_init(void *handle)
>   	if ((psp_get_runtime_db_entry(adev,
>   				PSP_RUNTIME_ENTRY_TYPE_PPTABLE_ERR_STATUS,
>   				&scpm_entry)) &&
> -	    (SCPM_DISABLE != scpm_entry.scpm_status)) {
> +	    (scpm_entry.scpm_status != SCPM_DISABLE)) {
>   		adev->scpm_enabled = true;
>   		adev->scpm_status = scpm_entry.scpm_status;
>   	} else {
> @@ -458,10 +458,9 @@ static int psp_sw_init(void *handle)
>   
>   	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 0) ||
>   	    adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 7)) {
> -		ret= psp_sysfs_init(adev);
> -		if (ret) {
> +		ret = psp_sysfs_init(adev);
> +		if (ret)
>   			return ret;
> -		}
>   	}
>   
>   	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
> @@ -645,7 +644,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
>   	skip_unsupport = (psp->cmd_buf_mem->resp.status == TEE_ERROR_NOT_SUPPORTED ||
>   		psp->cmd_buf_mem->resp.status == PSP_ERR_UNKNOWN_COMMAND) && amdgpu_sriov_vf(psp->adev);
>   
> -	memcpy((void*)&cmd->resp, (void*)&psp->cmd_buf_mem->resp, sizeof(struct psp_gfx_resp));
> +	memcpy((void *)&cmd->resp, (void *)&psp->cmd_buf_mem->resp, sizeof(struct psp_gfx_resp));

The casts to "void *" are completely superfluous in the first place.

I suggest to just remove that completely.

Christian.

>   
>   	/* In some cases, psp response status is not 0 even there is no
>   	 * problem while the command is submitted. Some version of PSP FW
> @@ -830,7 +829,7 @@ static int psp_tmr_load(struct psp_context *psp)
>   }
>   
>   static void psp_prep_tmr_unload_cmd_buf(struct psp_context *psp,
> -				        struct psp_gfx_cmd_resp *cmd)
> +					struct psp_gfx_cmd_resp *cmd)
>   {
>   	if (amdgpu_sriov_vf(psp->adev))
>   		cmd->cmd_id = GFX_CMD_ID_DESTROY_VMR;
> @@ -1067,7 +1066,7 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
>   				     struct ta_context *context)
>   {
>   	cmd->cmd_id				= context->ta_load_type;
> -	cmd->cmd.cmd_load_ta.app_phy_addr_lo 	= lower_32_bits(ta_bin_mc);
> +	cmd->cmd.cmd_load_ta.app_phy_addr_lo	= lower_32_bits(ta_bin_mc);
>   	cmd->cmd.cmd_load_ta.app_phy_addr_hi	= upper_32_bits(ta_bin_mc);
>   	cmd->cmd.cmd_load_ta.app_len		= context->bin_desc.size_bytes;
>   
> @@ -1138,9 +1137,8 @@ int psp_ta_load(struct psp_context *psp, struct ta_context *context)
>   
>   	context->resp_status = cmd->resp.status;
>   
> -	if (!ret) {
> +	if (!ret)
>   		context->session_id = cmd->resp.session_id;
> -	}
>   
>   	release_psp_cmd_buf(psp);
>   
> @@ -1467,8 +1465,7 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
>   	if (amdgpu_ras_intr_triggered())
>   		return ret;
>   
> -	if (ras_cmd->if_version > RAS_TA_HOST_IF_VER)
> -	{
> +	if (ras_cmd->if_version > RAS_TA_HOST_IF_VER) {
>   		DRM_WARN("RAS: Unsupported Interface");
>   		return -EINVAL;
>   	}
> @@ -1478,8 +1475,7 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
>   			dev_warn(psp->adev->dev, "ECC switch disabled\n");
>   
>   			ras_cmd->ras_status = TA_RAS_STATUS__ERROR_RAS_NOT_AVAILABLE;
> -		}
> -		else if (ras_cmd->ras_out_message.flags.reg_access_failure_flag)
> +		} else if (ras_cmd->ras_out_message.flags.reg_access_failure_flag)
>   			dev_warn(psp->adev->dev,
>   				 "RAS internal register access blocked\n");
>   
> @@ -1575,11 +1571,10 @@ int psp_ras_initialize(struct psp_context *psp)
>   				if (ret)
>   					dev_warn(adev->dev, "PSP set boot config failed\n");
>   				else
> -					dev_warn(adev->dev, "GECC will be disabled in next boot cycle "
> -						 "if set amdgpu_ras_enable and/or amdgpu_ras_mask to 0x0\n");
> +					dev_warn(adev->dev, "GECC will be disabled in next boot cycle if set amdgpu_ras_enable and/or amdgpu_ras_mask to 0x0\n");
>   			}
>   		} else {
> -			if (1 == boot_cfg) {
> +			if (boot_cfg == 1) {
>   				dev_info(adev->dev, "GECC is enabled\n");
>   			} else {
>   				/* enable GECC in next boot cycle if it is disabled
> @@ -2365,7 +2360,7 @@ static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *ucode,
>   }
>   
>   static int psp_execute_non_psp_fw_load(struct psp_context *psp,
> -			          struct amdgpu_firmware_info *ucode)
> +				  struct amdgpu_firmware_info *ucode)
>   {
>   	int ret = 0;
>   	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
> @@ -2404,9 +2399,8 @@ static int psp_load_smu_fw(struct psp_context *psp)
>   	     (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 4) ||
>   	      adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 2)))) {
>   		ret = amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_UNLOAD);
> -		if (ret) {
> +		if (ret)
>   			DRM_WARN("Failed to set MP1 state prepare for reload\n");
> -		}
>   	}
>   
>   	ret = psp_execute_non_psp_fw_load(psp, ucode);
> @@ -2716,9 +2710,8 @@ static int psp_suspend(void *handle)
>   	}
>   
>   	ret = psp_ring_stop(psp, PSP_RING_TYPE__KM);
> -	if (ret) {
> +	if (ret)
>   		DRM_ERROR("PSP ring stop failed\n");
> -	}
>   
>   out:
>   	return ret;
> @@ -2967,7 +2960,7 @@ static int parse_sos_bin_descriptor(struct psp_context *psp,
>   		psp->sos.fw_version        = le32_to_cpu(desc->fw_version);
>   		psp->sos.feature_version   = le32_to_cpu(desc->fw_version);
>   		psp->sos.size_bytes        = le32_to_cpu(desc->size_bytes);
> -		psp->sos.start_addr 	   = ucode_start_addr;
> +		psp->sos.start_addr	   = ucode_start_addr;
>   		break;
>   	case PSP_FW_TYPE_PSP_SYS_DRV:
>   		psp->sys.fw_version        = le32_to_cpu(desc->fw_version);
> @@ -3491,7 +3484,7 @@ void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size
>   	drm_dev_exit(idx);
>   }
>   
> -static DEVICE_ATTR(usbc_pd_fw, S_IRUGO | S_IWUSR,
> +static DEVICE_ATTR(usbc_pd_fw, 0644,
>   		   psp_usbc_pd_fw_sysfs_read,
>   		   psp_usbc_pd_fw_sysfs_write);
>   
> @@ -3674,8 +3667,7 @@ static void psp_sysfs_fini(struct amdgpu_device *adev)
>   	device_remove_file(adev->dev, &dev_attr_usbc_pd_fw);
>   }
>   
> -const struct amdgpu_ip_block_version psp_v3_1_ip_block =
> -{
> +const struct amdgpu_ip_block_version psp_v3_1_ip_block = {
>   	.type = AMD_IP_BLOCK_TYPE_PSP,
>   	.major = 3,
>   	.minor = 1,
> @@ -3683,8 +3674,7 @@ const struct amdgpu_ip_block_version psp_v3_1_ip_block =
>   	.funcs = &psp_ip_funcs,
>   };
>   
> -const struct amdgpu_ip_block_version psp_v10_0_ip_block =
> -{
> +const struct amdgpu_ip_block_version psp_v10_0_ip_block = {
>   	.type = AMD_IP_BLOCK_TYPE_PSP,
>   	.major = 10,
>   	.minor = 0,
> @@ -3692,8 +3681,7 @@ const struct amdgpu_ip_block_version psp_v10_0_ip_block =
>   	.funcs = &psp_ip_funcs,
>   };
>   
> -const struct amdgpu_ip_block_version psp_v11_0_ip_block =
> -{
> +const struct amdgpu_ip_block_version psp_v11_0_ip_block = {
>   	.type = AMD_IP_BLOCK_TYPE_PSP,
>   	.major = 11,
>   	.minor = 0,
> @@ -3709,8 +3696,7 @@ const struct amdgpu_ip_block_version psp_v11_0_8_ip_block = {
>   	.funcs = &psp_ip_funcs,
>   };
>   
> -const struct amdgpu_ip_block_version psp_v12_0_ip_block =
> -{
> +const struct amdgpu_ip_block_version psp_v12_0_ip_block = {
>   	.type = AMD_IP_BLOCK_TYPE_PSP,
>   	.major = 12,
>   	.minor = 0,

