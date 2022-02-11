Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D15C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 09:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 231A510EA36;
	Fri, 11 Feb 2022 09:11:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F28B10EA1F
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 08:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644569161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NIGJSGdDR+e/0lqDusmjI7J0UIItqFB5EseqZJ+/itg=;
 b=JWBBVROHNDyDfUEi5eAEEopZINg2s1HncjBe0675uzx9nZdArY2kqmyW+TUBaiSSRo+lLU
 FE0P/ZBJ32V9N7pjdgeOhXhGED0I/Du1iLPKMyxGebFqbNY6kWxqOBMJgweOdGfI10InBj
 JPFP51oRizc8wLb7tvSxBU4beQ+ebVY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-NPrl7Li9OIC4n74ndC1Zrw-1; Fri, 11 Feb 2022 03:46:00 -0500
X-MC-Unique: NPrl7Li9OIC4n74ndC1Zrw-1
Received: by mail-ej1-f70.google.com with SMTP id
 hp37-20020a1709073e2500b006cd86fa20ffso2838762ejc.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 00:46:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=NIGJSGdDR+e/0lqDusmjI7J0UIItqFB5EseqZJ+/itg=;
 b=KLpECcyVZZFso+nWHjm6YCtDQEYOU1gGvhTTWSvqhIN3XS5u8CBgq1h6mgGszqrK+A
 TfFROE5KbxlkPxpIltFTmpkU0d9D+25peV5bMWNKIo+e77EikxRpuTf9XwDyqDu4fUWc
 7ZxGXJLZcuEBo8g1cjmh7dQH5vMzyrcBROQZv1LbXzrRjdhWBXTa9u58Sln6jIU30nXn
 dH5qbX4i2yhi70kYT3nH9s51Dnl7C/xw32lj40h/utLMzt51eZpo9UIrM5lo77mwTFlP
 U5CFW8tDKvtXnW76mDPzcfBI2itfoeal8ItxqS4wMX6joziRGDTmWnn5lPBD/DZ+UK0v
 +9pA==
X-Gm-Message-State: AOAM533vwofaLTFftBNpQB0GPSHiLYTejtSSU4xF7lkTAd9eqcovSGVm
 o8RZUlfZ0IjPbeh1J60AEiRD/LQ1HAcL1AI3t1aUCXOnlEnbfaBmhwLLQ+rZVd53PCTgQLpGn9j
 7DI2GDZOMcw0mLBV1sC54p+m8MQ==
X-Received: by 2002:a17:907:168a:: with SMTP id
 hc10mr466710ejc.283.1644569159070; 
 Fri, 11 Feb 2022 00:45:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQtGaHy5U9JGMvxdUhyHS51vk9smJiabHDR4QMkXJw//KX0Gh6ttUq7C+QmDdzvWmB7pzNDQ==
X-Received: by 2002:a17:907:168a:: with SMTP id
 hc10mr466695ejc.283.1644569158862; 
 Fri, 11 Feb 2022 00:45:58 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1?
 (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
 by smtp.gmail.com with ESMTPSA id v5sm10859303edb.15.2022.02.11.00.45.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Feb 2022 00:45:58 -0800 (PST)
Message-ID: <d8c31b9a-49fd-e10b-34ef-751fe1262513@redhat.com>
Date: Fri, 11 Feb 2022 09:45:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 8/9] platform/x86: amd-gmux: drop the use of
 `pci_is_thunderbolt_attached`
To: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS"
 <nouveau@lists.freedesktop.org>,
 "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>
References: <20220210224329.2793-1-mario.limonciello@amd.com>
 <20220210224329.2793-9-mario.limonciello@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220210224329.2793-9-mario.limonciello@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 11 Feb 2022 09:11:37 +0000
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
Cc: Michael Jamet <michael.jamet@intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>, Alexander.Deucher@amd.com,
 Lukas Wunner <lukas@wunner.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 2/10/22 23:43, Mario Limonciello wrote:
> Currently `pci_is_thunderbolt_attached` is used to indicate a device
> is connected externally.
> 
> The PCI core now marks such devices as removable and downstream drivers
> can use this instead.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, this looks good to me. I assume that this whole series
will be merged in one go through another tree (e.g. the PCI tree),
so here is my ack for merging this patch through another tree:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/platform/x86/apple-gmux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index 04232fbc7d56..ffac15b9befd 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -596,7 +596,7 @@ static int gmux_resume(struct device *dev)
>  
>  static int is_thunderbolt(struct device *dev, void *data)
>  {
> -	return pci_is_thunderbolt_attached(to_pci_dev(dev));
> +	return dev_is_removable(dev);
>  }
>  
>  static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
> 

