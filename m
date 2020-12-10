Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819DEC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 10:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1AB23609
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 10:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1AB23609
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74B916EA65;
	Thu, 10 Dec 2020 10:17:13 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01A606EA65
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 10:17:11 +0000 (UTC)
Received: by mail-ed1-x541.google.com with SMTP id b2so4901153edm.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 02:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Lu0jQEXuMvHJM5PTDoOVIrcSn3AhBRF9iL3frSASQSU=;
 b=WJabAS5PVEmwjZKOIzWbbAzyGtJ3FmhbTsivBpjG5ax0CnYPPdd2qXdxN6j0WwYysi
 Vip4MtoDkiyMyLFsCzNdyEUBUwClBe1Z1a4P+Q2nxqLL1LemgDGDgQCpViQmL+NklbSi
 +CsoyFkZCE0/AuLwsWppZOim7iPEDJC8goqeGC6sHtf/tBTGwYtrTUmrtNScCuZOFdyQ
 P44GiqOpYViRrRl9Azon9kipBjarsZXNVz8DXCSkVKw8Lugxncxg6fXdVvn+6nLNGhlU
 iUwqmhzkxEjzofLTW7URveLcbKdiNPbJV8Byrjseh+J2KOVeKM2L/S3GpFLG9KdAIfCg
 tqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Lu0jQEXuMvHJM5PTDoOVIrcSn3AhBRF9iL3frSASQSU=;
 b=haqJ+tZeoxJObzUWvxywJ/YoYjp//THOh4POnnIllEYMh1J0EJOTDKG0KSlFkcZs2V
 HRukOOsAXwShBYXPxvCfD06bWH+GbvM1xrK0TMnJ9YIGOit1rZ97UZbnF9vNyfF0VzrV
 9+7x/NBaqVOuSLZlV9oUxSCXFVifb/EUyQOjBSE6CiMbZTEnw6h34C90FD2QS1n5yhPk
 scZZF28roMtyjdMVAtTbpdXPUDorIIT13ijuQUgQgIo3OtlN0+wfPgV1EQ3qyvJvJ/sk
 SqYMLF07geoelC1xbrS6TcHYdw/xpAIzDaxtei9XVpKDH+mp7xy/Dn0w8xKRAFVsf3FC
 zDvA==
X-Gm-Message-State: AOAM530dTvZkSzIHeh9UbklbJo5JLQfwPew+1l7FB7SmMYjLxS7fHrIt
 KTmR+BdYhfs97MmMGrubTF3fTstv3h0=
X-Google-Smtp-Source: ABdhPJxs9BY/q738za3Qy/9HmD5Kw4FUV4IXWmL7sCjhg52Y575IopD0xyccbWGlx95kF3Pee9t4Hw==
X-Received: by 2002:a05:6402:b9a:: with SMTP id
 cf26mr5908971edb.372.1607595430432; 
 Thu, 10 Dec 2020 02:17:10 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id v9sm4126526ejk.48.2020.12.10.02.17.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Dec 2020 02:17:09 -0800 (PST)
Subject: Re: [PATCH] amdgpu: resize BAR0 to the maximum available size, even
 if it doesn't cover VRAM
To: Darren Salt <devspam@moreofthesa.me.uk>, amd-gfx@lists.freedesktop.org
References: <20201210005744.5877-1-devspam@moreofthesa.me.uk>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <621ae252-ab39-383e-61a9-746fb47c6e01@gmail.com>
Date: Thu, 10 Dec 2020 11:17:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201210005744.5877-1-devspam@moreofthesa.me.uk>
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.12.20 um 01:57 schrieb Darren Salt:
> This allows BAR0 resizing to be done for cards which don't advertise support
> for a size large enough to cover the VRAM but which do advertise at least
> one size larger than the default. For example, my RX 5600 XT, which
> advertises 256MB, 512MB and 1GB.

I've never seen such a configuration except for engineering samples. Can 
you send me a dump of the relevant PCI configuration space?

In general we could do this, but instead of just blindly trying 
different values we should just pick a supported one in the first place.

Regards,
Christian.

>
> Signed-off-by: Darren Salt <devspam@moreofthesa.me.uk>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 44 +++++++++++++++++-----
>   1 file changed, 35 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 355fa0057c26..ec3610b4110b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1078,6 +1078,11 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
>   		__clear_bit(wb, adev->wb.used);
>   }
>   
> +static inline u32 bytes_to_size_pci(u64 bytes)
> +{
> +	return order_base_2(((bytes >> 20) | 1)) - 1;
> +}
> +
>   /**
>    * amdgpu_device_resize_fb_bar - try to resize FB BAR
>    *
> @@ -1090,20 +1095,25 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
>   int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   {
>   	u64 space_needed = roundup_pow_of_two(adev->gmc.real_vram_size);
> -	u32 rbar_size = order_base_2(((space_needed >> 20) | 1)) - 1;
> +	u32 rbar_size = bytes_to_size_pci(space_needed);
>   	struct pci_bus *root;
>   	struct resource *res;
> +	u64 current_bytes;
> +	u32 current_size;
>   	unsigned i;
>   	u16 cmd;
>   	int r;
> +	bool nospc = false;
>   
>   	/* Bypass for VF */
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
>   
> -	/* skip if the bios has already enabled large BAR */
> -	if (adev->gmc.real_vram_size &&
> -	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
> +	current_bytes = pci_resource_len(adev->pdev, 0);
> +	current_size = bytes_to_size_pci(current_bytes);
> +
> +	/* Skip if the BIOS has already enabled large BAR, covering the VRAM */
> +	if (current_size >= rbar_size)
>   		return 0;
>   
>   	/* Check if the root BUS has 64bit memory resources */
> @@ -1121,6 +1131,9 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   	if (!res)
>   		return 0;
>   
> +	dev_dbg(adev->dev, "BIOS-allocated BAR0 was %lluMB; trying to get %lluMB",
> +	        current_bytes >> 20, space_needed >> 20);
> +
>   	/* Disable memory decoding while we change the BAR addresses and size */
>   	pci_read_config_word(adev->pdev, PCI_COMMAND, &cmd);
>   	pci_write_config_word(adev->pdev, PCI_COMMAND,
> @@ -1133,11 +1146,24 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   
>   	pci_release_resource(adev->pdev, 0);
>   
> -	r = pci_resize_resource(adev->pdev, 0, rbar_size);
> -	if (r == -ENOSPC)
> -		DRM_INFO("Not enough PCI address space for a large BAR.");
> -	else if (r && r != -ENOTSUPP)
> -		DRM_ERROR("Problem resizing BAR0 (%d).", r);
> +	while (rbar_size > current_size) {
> +		r = pci_resize_resource(adev->pdev, 0, rbar_size);
> +		if (r == 0 || r == -ENOTSUPP) {
> +			break;
> +		} else if (r == -ENOSPC) {
> +			if (!nospc) {
> +				/* Warn only the first time */
> +				dev_info(adev->dev, "Not enough PCI address space for a large BAR.");
> +				nospc = true;
> +			}
> +			--rbar_size;
> +		} else if (r == -EINVAL) {
> +			--rbar_size;
> +		} else {
> +			dev_err(adev->dev, "Problem resizing BAR0 (%d).", r);
> +			break;
> +		}
> +	}
>   
>   	pci_assign_unassigned_bus_resources(adev->pdev->bus);
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
