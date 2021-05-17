Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73914C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 06:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A9261185
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 06:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A9261185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C077E6E8CE;
	Mon, 17 May 2021 06:52:47 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 076346E8CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 06:52:46 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id lz27so7466951ejb.11
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 May 2021 23:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=r/lSaC6VQRv/Regecm46Y7z1bKoSfGHs+TtmCcnXyJU=;
 b=V1/0AyQJiyvQRkFa4F6b6xRmynv7Dx4QbKO0cmc8nzGfeWQ2wBZo82MnzWac/sFTSW
 JS9IBDBwCrsflZvhSRvJ71V8XX3oVa7jgmwkqlR9bkWmKJ8rvchPw5pFZsIwj55gESb4
 6UUdDA0QEEh5dfV7a/GApBHcHk5w1dYGBclbC4rrjjAxf5jje3fI9dE0tBQ4LEDTiemU
 Wdsi5u+iaPgVBwRto2CJXXwxJ+8nITyHMLqNFfZFGjzIPda/MBkmKro+Q7mL7bDYsLOi
 AyT67eLCC9hW12I0IPk1ULfPnjlTGrrj0qF3A8titRHH2HUcZ2GUO/DojbD76j96gsOq
 TN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=r/lSaC6VQRv/Regecm46Y7z1bKoSfGHs+TtmCcnXyJU=;
 b=hsofg4D04+eg3PSW6qmZ43rMK3fWQdruFZnM7pinRG+c95M5719eeYt7OeQEohvgU1
 VWHJXqupHwVgkws2qdQ3tPjP+cFHM3vxMTYqFH1NSE9Yp1U78OUIsjXxVKooJF2EvXdq
 Jvf3/2t4zNhldW95eHpTBkUzNqVMUClwwnw5zqy/h5lir7NKdC8fIrdyZAijTn1i/xHP
 JAAulN1pqBZmxOqFGXFlx3l7l6jBARbV//yFlet47T/glxIfGTz6bMMh3KFaBWWEuR6x
 +LBbnJJZogsltxkLioRvsrIhrhzTfaahwEmoig5FqPTVI+MyKziawt5MvW980whCVXMM
 B3cQ==
X-Gm-Message-State: AOAM530hDofV8afVzAKL/C2Z4bb8pBwf0/QV5cmfQmKx92jfZyfDu0ce
 4M5dG4U1fQVF2c3oIDde3POMR6LiseA=
X-Google-Smtp-Source: ABdhPJyGNWiX6nzbGnUjAgyCxw+3I5lDGTq0kR326NaDmhG3dlD7/gax2+ma0ll9uDwAwp0t0HgOww==
X-Received: by 2002:a17:906:1984:: with SMTP id
 g4mr59220282ejd.525.1621234365474; 
 Sun, 16 May 2021 23:52:45 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:6bbe:b48c:2de1:422d?
 ([2a02:908:1252:fb60:6bbe:b48c:2de1:422d])
 by smtp.gmail.com with ESMTPSA id cw12sm1918608ejc.17.2021.05.16.23.52.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 May 2021 23:52:44 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Expose rfc4122 compliant UUID
To: Jiawei Gu <Jiawei.Gu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210517055413.28417-1-Jiawei.Gu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4d02568a-0a84-1e68-23d5-23b0cb3865bf@gmail.com>
Date: Mon, 17 May 2021 08:52:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210517055413.28417-1-Jiawei.Gu@amd.com>
Content-Language: en-US
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
Cc: emily.deng@amd.com, david.nieto@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.05.21 um 07:54 schrieb Jiawei Gu:
> Introduce an RFC 4122 compliant UUID for the GPUs derived
> from the unique GPU serial number (from Vega10) on gpus.
> Where this serial number is not available, use a compliant
> random UUID.
>
> For virtualization, the unique ID is passed by the host driver
> in the PF2VF structure.

The question is why this is useful.

>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 36 ++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 96 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  4 +
>   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  4 +-
>   drivers/gpu/drm/amd/amdgpu/nv.c             |  5 ++
>   drivers/gpu/drm/amd/amdgpu/nv.h             |  3 +
>   6 files changed, 146 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3147c1c935c8..ad6d4b55be6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -802,6 +802,40 @@ struct amd_powerplay {
>   					  (rid == 0x01) || \
>   					  (rid == 0x10))))
>   
> +union amdgpu_uuid_info {
> +	struct {
> +		union {
> +			struct {
> +				uint32_t did	: 16;
> +				uint32_t fcn	: 8;
> +				uint32_t asic_7 : 8;
> +			};

Bitfields are not allowed in structures used for communication with 
hardware or uAPI.

Regards,
Christian.

> +			uint32_t time_low;
> +		};
> +
> +		struct {
> +			uint32_t time_mid  : 16;
> +			uint32_t time_high : 12;
> +			uint32_t version   : 4;
> +		};
> +
> +		struct {
> +			struct {
> +				uint8_t clk_seq_hi : 6;
> +				uint8_t variant    : 2;
> +			};
> +			union {
> +				uint8_t clk_seq_low;
> +				uint8_t asic_6;
> +			};
> +			uint16_t asic_4;
> +		};
> +
> +		uint32_t asic_0;
> +	};
> +	char as_char[16];
> +};
> +
>   #define AMDGPU_RESET_MAGIC_NUM 64
>   #define AMDGPU_MAX_DF_PERFMONS 4
>   struct amdgpu_device {
> @@ -1074,6 +1108,8 @@ struct amdgpu_device {
>   	char				product_name[32];
>   	char				serial[20];
>   
> +	union amdgpu_uuid_info uuid_info;
> +
>   	struct amdgpu_autodump		autodump;
>   
>   	atomic_t			throttling_logging_enabled;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7c6c435e5d02..079841e1cb52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -37,6 +37,7 @@
>   #include <linux/vgaarb.h>
>   #include <linux/vga_switcheroo.h>
>   #include <linux/efi.h>
> +#include <linux/uuid.h>
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
>   #include "amdgpu_i2c.h"
> @@ -3239,11 +3240,104 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>   	return ret;
>   }
>   
> +static bool amdgpu_is_uuid_info_empty(union amdgpu_uuid_info *uuid_info)
> +{
> +	return (uuid_info->time_low    == 0 &&
> +			uuid_info->time_mid    == 0 &&
> +			uuid_info->time_high   == 0 &&
> +			uuid_info->version     == 0 &&
> +			uuid_info->clk_seq_hi  == 0 &&
> +			uuid_info->variant     == 0 &&
> +			uuid_info->clk_seq_low == 0 &&
> +			uuid_info->asic_4      == 0 &&
> +			uuid_info->asic_0      == 0);
> +}
> +
> +static void amdgpu_gen_uuid_info(union amdgpu_uuid_info *uuid_info,
> +				uint64_t serial, uint16_t did, uint8_t idx)
> +{
> +	uint16_t clk_seq = 0;
> +
> +	/* Step1: insert clk_seq */
> +	uuid_info->clk_seq_low = (uint8_t)clk_seq;
> +	uuid_info->clk_seq_hi  = (uint8_t)(clk_seq >> 8) & 0x3F;
> +
> +	/* Step2: insert did */
> +	uuid_info->did = did;
> +
> +	/* Step3: insert vf idx */
> +	uuid_info->fcn = idx;
> +
> +	/* Step4: insert serial */
> +	uuid_info->asic_0 = (uint32_t)serial;
> +	uuid_info->asic_4 = (uint16_t)(serial >> 4 * 8) & 0xFFFF;
> +	uuid_info->asic_6 = (uint8_t)(serial >> 6 * 8) & 0xFF;
> +	uuid_info->asic_7 = (uint8_t)(serial >> 7 * 8) & 0xFF;
> +
> +	/* Step5: insert version */
> +	uuid_info->version = 1;
> +	/* Step6: insert variant */
> +	uuid_info->variant = 2;
> +}
> +
> +/* byte reverse random uuid */
> +static void amdgpu_gen_uuid_random(union amdgpu_uuid_info *uuid_info)
> +{
> +	char b0, b1;
> +	int i;
> +
> +	generate_random_uuid(uuid_info->as_char);
> +	for (i = 0; i < 8; i++) {
> +		b0 = uuid_info->as_char[i];
> +		b1 = uuid_info->as_char[16-i];
> +		uuid_info->as_char[16-i] = b0;
> +		uuid_info->as_char[i] = b1;
> +	}
> +}
> +
> +/**
> + *
> + * The amdgpu driver provides a sysfs API for providing uuid data.
> + * The file uuid_info is used for this, and returns string of amdgpu uuid.
> + */
> +static ssize_t amdgpu_get_uuid_info(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);//ddev->dev_private;
> +	union amdgpu_uuid_info *uuid = &adev->uuid_info;
> +
> +	return sysfs_emit(buf,
> +					"%08x-%04x-%x%03x-%02x%02x-%04x%08x\n",
> +					uuid->time_low,
> +					uuid->time_mid,
> +					uuid->version,
> +					uuid->time_high,
> +					uuid->clk_seq_hi |
> +					uuid->variant << 6,
> +					uuid->clk_seq_low,
> +					uuid->asic_4,
> +					uuid->asic_0);
> +}
> +static DEVICE_ATTR(uuid_info, S_IRUGO, amdgpu_get_uuid_info, NULL);
> +
> +static void amdgpu_uuid_init(struct amdgpu_device *adev)
> +{
> +	if (amdgpu_is_uuid_info_empty(&adev->uuid_info)) {
> +		if (adev->unique_id)
> +			amdgpu_gen_uuid_info(&adev->uuid_info, adev->unique_id, adev->pdev->device, 31);
> +		else
> +			amdgpu_gen_uuid_random(&adev->uuid_info);
> +	}
> +}
> +
>   static const struct attribute *amdgpu_dev_attributes[] = {
>   	&dev_attr_product_name.attr,
>   	&dev_attr_product_number.attr,
>   	&dev_attr_serial_number.attr,
>   	&dev_attr_pcie_replay_count.attr,
> +	&dev_attr_uuid_info.attr,
>   	NULL
>   };
>   
> @@ -3551,6 +3645,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   
>   	amdgpu_fbdev_init(adev);
>   
> +	amdgpu_uuid_init(adev);
> +
>   	r = amdgpu_pm_sysfs_init(adev);
>   	if (r) {
>   		adev->pm_sysfs_en = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index b71dd1deeb2d..2dfebfe38079 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -429,6 +429,7 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
>   static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
>   {
>   	struct amd_sriov_msg_pf2vf_info_header *pf2vf_info = adev->virt.fw_reserve.p_pf2vf;
> +	union amdgpu_uuid_info *uuid = &adev->uuid_info;
>   	uint32_t checksum;
>   	uint32_t checkval;
>   
> @@ -498,6 +499,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
>   
>   		adev->unique_id =
>   			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
> +
> +		memcpy(uuid, &((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid_info_reserved,
> +			sizeof(union amdgpu_uuid_info));
>   		break;
>   	default:
>   		DRM_ERROR("invalid pf2vf version\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index a434c71fde8e..0d1d36e82aeb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -203,9 +203,9 @@ struct amd_sriov_msg_pf2vf_info {
>   		uint32_t encode_max_frame_pixels;
>   	} mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
>   	/* UUID info */
> -	struct amd_sriov_msg_uuid_info uuid_info;
> +	uint32_t uuid_info_reserved[4];
>   	/* reserved */
> -	uint32_t reserved[256 - 47];
> +	uint32_t reserved[256-47];
>   };
>   
>   struct amd_sriov_msg_vf2pf_info_header {
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 32c34470404c..16d4a480f4c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1167,6 +1167,11 @@ static int nv_common_early_init(void *handle)
>   		if (amdgpu_sriov_vf(adev))
>   			adev->rev_id = 0;
>   		adev->external_rev_id = adev->rev_id + 0xa;
> +		if (!amdgpu_sriov_vf(adev)) {
> +			adev->unique_id = RREG32(mmFUSE_DATA_730);
> +			adev->unique_id <<= 32;
> +			adev->unique_id |= RREG32(mmFUSE_DATA_729);
> +		}
>   		break;
>   	case CHIP_SIENNA_CICHLID:
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h
> index 515d67bf249f..520ac2b98744 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.h
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.h
> @@ -26,6 +26,9 @@
>   
>   #include "nbio_v2_3.h"
>   
> +#define mmFUSE_DATA_729 (0x176D9)
> +#define mmFUSE_DATA_730 (0x176DA)
> +
>   void nv_grbm_select(struct amdgpu_device *adev,
>   		    u32 me, u32 pipe, u32 queue, u32 vmid);
>   void nv_set_virt_ops(struct amdgpu_device *adev);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
