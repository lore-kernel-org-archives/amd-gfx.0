Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E66C4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 08:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF7F207A5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 08:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF7F207A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB85C6E064;
	Mon, 14 Dec 2020 08:15:46 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF0466E064
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 08:15:45 +0000 (UTC)
Received: by mail-ed1-x544.google.com with SMTP id dk8so16225159edb.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 00:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Fq0mqSfrfUupbqrDxnjA6nTQWiErGaymd7GxzDO7sv0=;
 b=qOUbNwvO06O18WOSmZyiCrM42lMm8hWCbGe8vgEwl+FgHzr3+RpYQ+8Wh5rnoJpHWO
 ZGCpCxkiFeFyzyycN8M+swSZMQxqLWdsE3aqsaV7rBUi87uxEyKB/Y/NPKZHMSALUO/M
 hUZCVsPRVVLToYX9lu9W57Louu3T0NaA0t/BR+LPM3L1h9mpMYj1J+9su2b5JxQ0p2hy
 kSWcilq3KSUtv0UAh4OmCvzxBbG36KYxjzqHoFwsuJt2+y4YU7R8MBfJyMeh2Eqv7A2r
 nYPyNnLTH6sxEtIu9f/z8vQf1zJVBljf2vfsrhA+aLR+we8dPHKCQrnOP3uL/+yCuNVQ
 QoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Fq0mqSfrfUupbqrDxnjA6nTQWiErGaymd7GxzDO7sv0=;
 b=OaBFdHQHKZoVCx4/wkAov+Aytxc+A7zDZFBWSchNVlPN0hgd1VF+nGosPbmEJkXuNa
 4tf4m0MnO28eT3v0ZcjVVc3bsnrLN5PDKhRimUZB6524eto5df8ARbkurCkhFd8g98nb
 qubf3fBuNC1Kr45S0F9IS5OqEdWVOP7jwtNOAd4cbwQI92YG1HYcZMDR3ddbCUeg7/Ql
 KAF8rSKXzcWdKo7um/ij4umM6fFlRxEOtD07CTfCpB3CELyIKZkqt5c2p4tnMt6guN8l
 y4MnlFcx/jnRUYeFAHKijNvCRSa+mftafeh1Az8gCijini0Lcham5LYFGluU9Qcws6LZ
 NgrQ==
X-Gm-Message-State: AOAM531XBuhxYcePpluvRQvJ7F3ZnL6ewV4Byt/CyO2ooFNf/ZrHLHxr
 12f/6cs1J22fPH+x9Z1J2qWVS1zC4ZM=
X-Google-Smtp-Source: ABdhPJz5oIT6UVhJTuQeaqeeDqsnpsOiaHRjrSdeFDkrDkrmPp0bIijQU95llptXOTVR2a2tcL/Aog==
X-Received: by 2002:a05:6402:1516:: with SMTP id
 f22mr23317156edw.382.1607933744174; 
 Mon, 14 Dec 2020 00:15:44 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u15sm15839657edt.24.2020.12.14.00.15.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Dec 2020 00:15:43 -0800 (PST)
Subject: Re: [PATCH 3/8] amdgpu: resize BAR0 to the maximum available size,
 even if it doesn't cover VRAM (v4)
To: Darren Salt <devspam@moreofthesa.me.uk>, amd-gfx@lists.freedesktop.org
References: <20201213225323.6752-1-devspam@moreofthesa.me.uk>
 <20201213225323.6752-4-devspam@moreofthesa.me.uk>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e3c7ede1-0ca0-8c5a-c71f-fc448a6d85b6@gmail.com>
Date: Mon, 14 Dec 2020 09:15:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201213225323.6752-4-devspam@moreofthesa.me.uk>
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

Am 13.12.20 um 23:53 schrieb Darren Salt:
> This allows BAR0 resizing to be done for cards which don't advertise support
> for a size large enough to cover the VRAM but which do advertise at least
> one size larger than the default. For example, my RX 5600 XT, which
> advertises 256MB, 512MB and 1GB.
>
> [v4] use bit ops to find sizes to try
>
> [v3] don't use pci_rebar_get_current_size()
>
> [v2] rewritten to use PCI helper functions; some extra log text.
>
> Signed-off-by: Darren Salt <devspam@moreofthesa.me.uk>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 54 ++++++++++++++++++----
>   1 file changed, 44 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1595b124c145..b0f8ad603147 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -908,23 +908,29 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
>    */
>   int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   {
> -	u64 space_needed = roundup_pow_of_two(adev->gmc.real_vram_size);
> -	u32 rbar_size = order_base_2(((space_needed >> 20) | 1)) - 1;
> +	int rbar_size, current_size;
> +	u64 current_bytes;
> +	u32 available_sizes;
>   	struct pci_bus *root;
>   	struct resource *res;
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
> +
> +	/* Skip if the BIOS has already enabled large BAR, covering the VRAM */
> +	if (current_bytes >= adev->gmc.real_vram_size)
>   		return 0;
>   
> +	current_size = current_bytes ? pci_rebar_bytes_to_size(current_bytes) : -1;
> +	rbar_size = pci_rebar_bytes_to_size(adev->gmc.real_vram_size);
> +
>   	/* Check if the root BUS has 64bit memory resources */
>   	root = adev->pdev->bus;
>   	while (root->parent)
> @@ -940,6 +946,18 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   	if (!res)
>   		return 0;
>   
> +	available_sizes = pci_rebar_get_possible_sizes(adev->pdev, 0);
> +	if (available_sizes == 0)
> +		return 0;
> +
> +	/* Find the bit pos representing the smallest size covering the VRAM.
> +	 * Otherwise find the bit pos representing the largest available size.
> +	 * rbar_size may be smaller but should be unchanged.
> +	 */
> +	rbar_size = (ffs(available_sizes & (-1 << rbar_size)) ? : fls(available_sizes)) - 1;
> +	if (rbar_size < 0)
> +		return 0; /* can't happen */
> +
>   	/* Disable memory decoding while we change the BAR addresses and size */
>   	pci_read_config_word(adev->pdev, PCI_COMMAND, &cmd);
>   	pci_write_config_word(adev->pdev, PCI_COMMAND,
> @@ -952,11 +970,27 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   
>   	pci_release_resource(adev->pdev, 0);
>   
> -	r = pci_resize_resource(adev->pdev, 0, rbar_size);
> -	if (r == -ENOSPC)
> -		DRM_INFO("Not enough PCI address space for a large BAR.");
> -	else if (r && r != -ENOTSUPP)
> -		DRM_ERROR("Problem resizing BAR0 (%d).", r);
> +	for (;
> +	     rbar_size >= 0 && rbar_size > current_size;
> +	     rbar_size = fls(available_sizes & ~(-1 << rbar_size)) - 1
> +	    ) {

Please completely remove the loop here. We should never try more than 
one size.

Regards,
Christian.

> +		r = pci_resize_resource(adev->pdev, 0, rbar_size);
> +		if (r == 0) {
> +			break;
> +		} else if (r == -ENOTSUPP) {
> +			dev_info(adev->dev, "BAR resizing not supported.");
> +			break;
> +		} else if (r == -ENOSPC) {
> +			if (!nospc) {
> +				/* Warn only the first time */
> +				dev_info(adev->dev, "Not enough PCI address space for a large BAR.");
> +				nospc = true;
> +			}
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
