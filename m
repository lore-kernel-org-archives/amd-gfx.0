Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50764C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Dec 2021 14:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D4589C53;
	Sat, 18 Dec 2021 14:36:31 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 199D4113E4E
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Dec 2021 14:36:30 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id s1so9799732wrg.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Dec 2021 06:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=FUFKW3Vn+YYxidNuTUWVb+i8kDuTGIgdDGfMbwZYcXA=;
 b=FmxdRiVG9t5C+4QxuxRcljqlGpDVlGG21sGMkJAXuEpnSr26VNrdK9lTIt2aRU3ha5
 Ae4N3KOr4zlgNHl/hn0YroVvy84KDC5Yz8su9nmtlcMP42AxDMtVRlmr4WmT+gc+wgPb
 w+xPO5Rpj+bMrASkr5baMwcwMcF79pqM19RvJ8kk5ZfV8/i0u49heEuhrwoTPf6YEAnd
 ocn1+QFOm3upjiKhKiXRqAr5lk7r1XC1LCppaNVmN6c0Gy0Is20Xp2BNKnOQuC1oK7tu
 eZLYmTLB6mLB1x+7HIeJQBD5uCjwDBjsGRkaHoeY8t9NGBkeA5DVbQZnOlKdUirw4JiA
 WTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=FUFKW3Vn+YYxidNuTUWVb+i8kDuTGIgdDGfMbwZYcXA=;
 b=4hIFbacV/QcULV3p+gDBlNHNFNvMuWxJyefCNKJnisMHcYwnx3njbNIBqJiYLMXBLo
 25QRWDfEX85uIpKQOqbOE+8ejXDtTRCqc6wSbLUBcLOhS7WVp2LpHlxd+/yGqQQ0D9Xh
 mhsNmq0mglwfKBh9xZNcVC74PkBmRpbJbRzHj60u4+GbQjDPVD7u7MqUcjH0q+EqNH2B
 kgzUWQ3empJAfjlvmynDyvOfN5eylRhuZHyuNapNvf4sucPfCsZOELxyxl6JqjelU+nT
 DQ78oxFT6Erl6cFuvtn6R7uRsIK/d2/5UjYU1zb6tBcx/jLTwIZ+W1eRV92A5jdTfDhD
 qPnQ==
X-Gm-Message-State: AOAM530sm/T26/HZvryU6rnr6p1cUWWxFmsRVUnoLdtaV98HrPOq5Eez
 oU9XimpIne/t6KcAiPV6ySSXI7GC4dw=
X-Google-Smtp-Source: ABdhPJwdAXezHf58B0okIySF9Ko5wcD22ZI9HebIDmPaqvI623rZC4rUErXb+gU6i2gq7ypY4OqLJQ==
X-Received: by 2002:adf:db8d:: with SMTP id u13mr6254154wri.583.1639838188598; 
 Sat, 18 Dec 2021 06:36:28 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:65ec:13e2:fbf4:846c?
 ([2a02:908:1252:fb60:65ec:13e2:fbf4:846c])
 by smtp.gmail.com with ESMTPSA id q123sm13239872wma.30.2021.12.18.06.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Dec 2021 06:36:28 -0800 (PST)
Subject: Re: [PATCH 1/4] drm/amdgpu: Increase potential product_name to 64
 characters
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211217153131.321226-1-kent.russell@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <850d619c-046b-de2b-0f5c-722a2ddcd5c3@gmail.com>
Date: Sat, 18 Dec 2021 15:36:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211217153131.321226-1-kent.russell@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 17.12.21 um 16:31 schrieb Kent Russell:
> Having seen at least 1 42-character product_name, bump the number up to
> 64, and put that definition into amdgpu.h to make future adjustments
> simpler.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h            |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 12 +++++-------
>   2 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e701dedce344..4e6737e4c36c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -813,6 +813,7 @@ struct amd_powerplay {
>   
>   #define AMDGPU_RESET_MAGIC_NUM 64
>   #define AMDGPU_MAX_DF_PERFMONS 4
> +#define PRODUCT_NAME_LEN 64

Please prefix all defines with AMDGPU_, apart from that looks good to me.

Regards,
Christian.

>   struct amdgpu_device {
>   	struct device			*dev;
>   	struct pci_dev			*pdev;
> @@ -1083,7 +1084,7 @@ struct amdgpu_device {
>   
>   	/* Chip product information */
>   	char				product_number[16];
> -	char				product_name[32];
> +	char				product_name[PRODUCT_NAME_LEN];
>   	char				serial[20];
>   
>   	atomic_t			throttling_logging_enabled;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index 7709caeb233d..5ed24701f9cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -88,7 +88,7 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
>   
>   int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>   {
> -	unsigned char buff[34];
> +	unsigned char buff[PRODUCT_NAME_LEN+2];
>   	u32 addrptr;
>   	int size, len;
>   
> @@ -131,12 +131,10 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>   	}
>   
>   	len = size;
> -	/* Product name should only be 32 characters. Any more,
> -	 * and something could be wrong. Cap it at 32 to be safe
> -	 */
> -	if (len >= sizeof(adev->product_name)) {
> -		DRM_WARN("FRU Product Number is larger than 32 characters. This is likely a mistake");
> -		len = sizeof(adev->product_name) - 1;
> +	if (len >= PRODUCT_NAME_LEN) {
> +		DRM_WARN("FRU Product Name is larger than %d characters. This is likely a mistake",
> +				PRODUCT_NAME_LEN);
> +		len = PRODUCT_NAME_LEN - 1;
>   	}
>   	/* Start at 2 due to buff using fields 0 and 1 for the address */
>   	memcpy(adev->product_name, &buff[2], len);

