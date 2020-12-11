Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F711C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 16:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0326F23D3C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 16:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0326F23D3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5402289E08;
	Fri, 11 Dec 2020 16:42:37 +0000 (UTC)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F4E89E08
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 16:42:36 +0000 (UTC)
Received: by mail-ej1-x641.google.com with SMTP id x16so13207006ejj.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 08:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Da+56IjmHq+zvAp0xo/vgZ0fMw9t8rwCRLUDqd86sAw=;
 b=qKrXZzPl89VG5Sl9ZdWLOG1n0+yyc8lXzbCSEllIT+2+YuOybf/y9sp+NRb92ZyF1I
 g4ij8Npma//HVH/IXU+yT5KffH+zGzZ5RT70zw8B7UjRmNu3vo3Pdbhj8uF6ZRpjVlo+
 qe/E9SjAjLCDwR1sdogfpq63ROnauSSLaxurFZ6itkcK0uv9bHhzs1HKHeWkM3jLg/f4
 n/dyjy1PkayPiL3WJDxxQEPUDiaeIHTtYf8svH/qrLjCq+AR/NuvhRn/wqHEPwpRCavQ
 8lc7djMxNuBfNKaewhAkXOT2IpopJo9Zsx9KUObed+eiZ+Qe2yOuctvlvx5ypdFd75lG
 Pldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Da+56IjmHq+zvAp0xo/vgZ0fMw9t8rwCRLUDqd86sAw=;
 b=e3Ep8F5VwJ00fH+hXT0W2j5gCQDMjf8xCBafbcBc1x4eA3wwALAYqDT7bIEdKUzm1I
 qFbdR/OT+6qBgfyRVQbDEKnhgSZlKqycVuUYkbLb5S9IFzi1ky89V0xiAukCYSj/AgPh
 +XDwazICNJ3moHCNDL+41XgKMbzHAXqo1wC7avTR8+DSDSdj9QfCFJdG/n5FPBoGVT/0
 D3EBoU6/1UPGdnkGSNn3NUEnzIHX+KN203hi/XRiBWnDwl/UTPlUCFije47xdLfj4ysr
 xWy5Ek91GKTpyCK8T0jl3xDPeynbFI9SM4h2u9ND0CpGvnC66NRtwifbRxWOmblxIj60
 dR1A==
X-Gm-Message-State: AOAM5329bzOqayblaWTtvr8FuQs4hhdyYw4HBJrNN0BgYiK7+oflaG5s
 v4UEsuB8LpTqMvxa9cHhO0pqcA8wqYo=
X-Google-Smtp-Source: ABdhPJwyf5uIX9h7pKsZu0i42v8Kp+gBYpilsn40KzEjnyD/JMLWujI9AU+fwpX6gmAt3+txjnXWWQ==
X-Received: by 2002:a17:906:d146:: with SMTP id
 br6mr11613278ejb.331.1607704954659; 
 Fri, 11 Dec 2020 08:42:34 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u23sm7114820ejc.46.2020.12.11.08.42.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Dec 2020 08:42:34 -0800 (PST)
Subject: Re: [PATCH 3/7] amdgpu: resize BAR0 to the maximum available size,
 even if it doesn't cover VRAM (v2)
To: Darren Salt <devspam@moreofthesa.me.uk>, amd-gfx@lists.freedesktop.org
References: <20201211005506.4554-1-devspam@moreofthesa.me.uk>
 <20201211005506.4554-4-devspam@moreofthesa.me.uk>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <67019c3e-13cb-0196-73f1-2e71b0a5b6f9@gmail.com>
Date: Fri, 11 Dec 2020 17:42:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211005506.4554-4-devspam@moreofthesa.me.uk>
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

Am 11.12.20 um 01:55 schrieb Darren Salt:
> This allows BAR0 resizing to be done for cards which don't advertise support
> for a size large enough to cover the VRAM but which do advertise at least
> one size larger than the default. For example, my RX 5600 XT, which
> advertises 256MB, 512MB and 1GB.
>
> [v2] rewritten to use PCI helper functions; some extra log text.
>
> Signed-off-by: Darren Salt <devspam@moreofthesa.me.uk>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 53 ++++++++++++++++++----
>   1 file changed, 43 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6637b84aeb85..1e99ca62a4d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1106,21 +1106,24 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
>    */
>   int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   {
> -	u64 space_needed = roundup_pow_of_two(adev->gmc.real_vram_size);
> -	u32 rbar_size = order_base_2(((space_needed >> 20) | 1)) - 1;
> +	int rbar_size, current_size;
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
> +	rbar_size = pci_rebar_bytes_to_size(adev->gmc.real_vram_size);
> +	current_size = pci_rebar_get_current_size(adev->pdev, 0);
> +
> +	/* Skip if the BIOS has already enabled large BAR, covering the VRAM */
> +	if (current_size >= rbar_size)

You should probably keep the comparison as it is and check the resource 
length against the VRAM size instead.

>   		return 0;
>   
>   	/* Check if the root BUS has 64bit memory resources */
> @@ -1138,6 +1141,14 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   	if (!res)
>   		return 0;
>   
> +	available_sizes = pci_rebar_get_possible_sizes(adev->pdev, 0);
> +	if (available_sizes == 0)
> +		return 0;
> +
> +	dev_dbg(adev->dev, "BIOS-allocated BAR0 was %lluMB; trying to get %lluMB",
> +	        current_size < 0 ? 0 : (pci_rebar_size_to_bytes(current_size) >> 20),
> +	        pci_rebar_size_to_bytes(rbar_size) >> 20);

Please no extra debugging output, we spam syslog that enough with the 
existing resize.

> +
>   	/* Disable memory decoding while we change the BAR addresses and size */
>   	pci_read_config_word(adev->pdev, PCI_COMMAND, &cmd);
>   	pci_write_config_word(adev->pdev, PCI_COMMAND,
> @@ -1150,11 +1161,33 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   
>   	pci_release_resource(adev->pdev, 0);
>   
> -	r = pci_resize_resource(adev->pdev, 0, rbar_size);
> -	if (r == -ENOSPC)
> -		DRM_INFO("Not enough PCI address space for a large BAR.");
> -	else if (r && r != -ENOTSUPP)
> -		DRM_ERROR("Problem resizing BAR0 (%d).", r);
> +	r = 0;
> +	for (; rbar_size >= 0 && rbar_size > current_size; --rbar_size) {

Well exactly that try and error is a rather big NAK.

What you need to do instead is to look at the return value from 
pci_rebar_get_possible_sizes() and determine the size closed to the 
desired one.

E.g. when need a size of 13 is needed you first check if any bit >= 13 
are set. You can use the ffs() for this.

If that isn't the case use fls() to get the highest set bit < 13.

Regards,
Christian.

> +		/* Skip this size if it isn't advertised.
> +		 * This avoids pci_resize_resources returning -EINVAL for that reason.
> +		 */
> +		if (!(available_sizes & BIT(rbar_size)))
> +			continue;
> +
> +		r = pci_resize_resource(adev->pdev, 0, rbar_size);
> +		if (r == 0) {
> +			dev_dbg(adev->dev, "Succeeded in resizing to %lluMB.",
> +			        pci_rebar_size_to_bytes(rbar_size) >> 20);
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
