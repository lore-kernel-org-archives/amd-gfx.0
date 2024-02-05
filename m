Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAA7C4828D
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Feb 2024 11:29:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BC8A1124D8;
	Mon,  5 Feb 2024 11:28:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fUVmXrdm";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C0911124D8
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Feb 2024 11:28:56 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-51137c8088dso3991523e87.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Feb 2024 03:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707132534; x=1707737334; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TcnrZiFoKqoviNxRH/t3HUNFg1NWrZniLXis+Ehl3kQ=;
 b=fUVmXrdmMXHKrmAjCK4u/uBpsRi2bgA+AzKmehgnz9exvtvup3tfeLWeiZn2Q3aEhf
 3lYqvOAGdkDGTmZF863kKnT7fVSb3DfMrz8DOo2o3cxnjRchubNw9yEdEqHZScKvpiKv
 TvqaoT82tEOZK5UF2ZxpIMnNS3YsQsodbjW+dgyAQog5e8VBn+xJ+8RfU6yhQvWRNzh3
 N3Ruhfw7nOtvfrwvyVSVFkUj6yEyUlfq6CwwQetpoJW6WYzaXbHCGL0qR37SS8+KJcGk
 LvicTfXRF0h/ij5xnDgzA0qnv7mJhOjd8GBGPAA4ulCm3lYx2M6cJ67BLC4fbHYRfC1r
 8Ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707132534; x=1707737334;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TcnrZiFoKqoviNxRH/t3HUNFg1NWrZniLXis+Ehl3kQ=;
 b=dL//iOMFJR365Fjb1nwrl+DMEuKWHc+bgSLc6VMLjHrrUHvCIlWE95dNbMO2QhLC6O
 xa2g4JSUN9QLj1pdDRRy2cKATEgAtbRugFFAzJQ5cH6OOW1dkaz1beOyB/apiKCyPMuh
 ZAJUkCEtmvfC5HixdI5FqwmCDxIarVNd++vkuMsYgvGJU5G6V6TmNWKUb+hYv0tRYtsu
 icdVu7jgSLmDH61nuSd1FGQPQ+azjDRTEiQ9oyYb44QOPbS58PvGkbrqfiSWE3R+dr/h
 3zVK6UY+Dx/ExFAcrr2s0n69VaZ5+YGgrCed7UViiOvYKsWVox++e4mT1z0jgRfXLF1O
 vg4Q==
X-Gm-Message-State: AOJu0Yx9aan6dluYub7qGqjImXCje+fnG6brbnZ3IqWCjzQX/nnoKi9Z
 iDbKctvjdzeYWbgRLjEbgbE0HGcY4WbLlSkV0PAnn9xx9N8Vhhjx
X-Google-Smtp-Source: AGHT+IHduzacAbB+gmsJTfUXIU/uuqegqXDQipzDg06tYFlUORm6tm/gFiQIkB2iylDysb5O+TBzgg==
X-Received: by 2002:ac2:5238:0:b0:511:4943:6066 with SMTP id
 i24-20020ac25238000000b0051149436066mr3046237lfl.25.1707132534315; 
 Mon, 05 Feb 2024 03:28:54 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUGg9Ncywyi1UvMZFL0Fsb4Xpf05vHlc2PN+5pEVK5/JEIZ2r/ER06DGI0d4oAKnSSJ45cXkUZcLNmG4OHRHhzjmOu3MgfgRPE1+OHBijH+NXixyZwCaXaZq5XziX9zxSppM9UE1Oqy05yad4OsfJHrtfxYQzPlh4poVjjU96rLVdQ8SuPO2beI2AYW7SjCrau8wb1fF4tFNWNalcO5tPFBmHzLxFEf25RKtZepOYKGHPEheTibxZ7ldG5fzoXZuW2JgowWjYR3dwZfEu8=
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 bi7-20020a05600c3d8700b0040fdd18f6fasm1448578wmb.39.2024.02.05.03.28.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 03:28:53 -0800 (PST)
Message-ID: <db589d23-6e15-4b54-845f-fb719e59949d@gmail.com>
Date: Mon, 5 Feb 2024 12:28:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Add vf reset notification for pf
Content-Language: en-US
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org,
 bhelgaas@google.com, alex.williamson@redhat.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20240204061257.1408243-1-Emily.Deng@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240204061257.1408243-1-Emily.Deng@amd.com>
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

Am 04.02.24 um 07:12 schrieb Emily Deng:
> When a vf has been reset, the pf wants to get notification to remove the vf
> out of schedule.
>
> Solution:
> Add the callback function in pci_driver sriov_vf_reset_notification. When
> vf reset happens, then call this callback function.

Well that doesn't make much sense. As other already noted as well a VF 
should be an encapsulated representation of a physical devices 
functionality.

AMD implemented that a bit different with a hypervisor to control which 
PF functionality a VF exposes, but that doesn't mean that we can leak 
this AMD specific handling into the common Linux PCI subsystem.

Additional to that a technical blocker is that when a VF is passed into 
a VM you don't have access to the PF any more to make this reset 
notification.

Regards,
Christian.

>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>   drivers/pci/pci.c   | 8 ++++++++
>   include/linux/pci.h | 1 +
>   2 files changed, 9 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0..aca937b05531 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4780,6 +4780,14 @@ EXPORT_SYMBOL_GPL(pcie_flr);
>    */
>   int pcie_reset_flr(struct pci_dev *dev, bool probe)
>   {
> +	struct pci_dev *pf_dev;
> +
> +	if (dev->is_virtfn) {
> +		pf_dev = dev->physfn;
> +		if (pf_dev->driver->sriov_vf_reset_notification)
> +			pf_dev->driver->sriov_vf_reset_notification(pf_dev, dev);
> +	}
> +
>   	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
>   		return -ENOTTY;
>   
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c69a2cc1f412..4fa31d9b0aa7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -926,6 +926,7 @@ struct pci_driver {
>   	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
>   	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
>   	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
> +	void  (*sriov_vf_reset_notification)(struct pci_dev *pf, struct pci_dev *vf);
>   	const struct pci_error_handlers *err_handler;
>   	const struct attribute_group **groups;
>   	const struct attribute_group **dev_groups;

