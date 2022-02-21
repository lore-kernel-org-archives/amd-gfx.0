Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A95C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 11:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5255710E5F3;
	Mon, 21 Feb 2022 11:01:39 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D6D410E5F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 11:01:38 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id qx21so32151505ejb.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 03:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=C/CLNl4+iRuvmq+JJPxd7+n179pvdHrRPYeRoqFWhmI=;
 b=JrWBaXC2roero/8Cur2F57VGNVGBNdjnMqYTCWu1CQ0Vr5jFUPxquJYxRUGzqlbonV
 G6cdmkZT9yRY3hK7n22NQRQcpE0Hv74gLTcldn0h8eJ1RFhKkNCB9dBz9t0oy3LDMGVE
 Rkb67WKU+YCZCwZq9cVGD8bno/UcHIFW+Woqdse1djZ0lPUr7wWs9bWnGoyHvL+e+dB/
 g0cG34dmzZHKf07lhzgpXUPt9GLKwtf1VeklTuUNTlLtfLfF59cR93tIkIRgIfwReL6M
 rKWqts/Je/v+4Chbrnul6N1TIk+nR4XMTxett+Aym4GZgVAeO7E7fsB7CnsYBQVbBuWg
 jm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=C/CLNl4+iRuvmq+JJPxd7+n179pvdHrRPYeRoqFWhmI=;
 b=HA1DrvHDsl2rBdCoBLqlNdaIRU5WiR+tPV1TYmVHF3vN94eDcF4dfwuWztIhOIIodk
 UIHU+MFf89nyGjIo4bfdumLO3X7k1n9T3L6MjdkwAtL66f7HEOf4exhnmqFnf9L2JcVN
 lXEjfQ+9xr280hugzxrD6ZxFtHgDyBby6PLJUbfGlnTVpKev8Khhkk1uvtKgsz9xVCNe
 A5NtActTzkTwBLgq/U/vqh/NODnyQpOZHyrZgAZAAHvsUU13fME5py/QCLubNMndJqNf
 qEermKnB2D2730HIynW1aaSlCPA2VIjnFKGfACivFrIKF8aMhWsjo+0pu6r2u+r7Cj5f
 PhWw==
X-Gm-Message-State: AOAM531IVI/wi7KXh94maimrAWo9dXshqcIzzOex4TB+kWfBde85IzY+
 2906v4SGOiqDILzHy+TCHXSGUE/MCcI=
X-Google-Smtp-Source: ABdhPJzlv+CBk5IYshgvHwRg2biTn9NODrRhYYT1Uhi6SJy1N4e6WlQnn+nqoQDMOkbUKVP4KMzVng==
X-Received: by 2002:a17:906:5a94:b0:6c5:5aa4:da87 with SMTP id
 l20-20020a1709065a9400b006c55aa4da87mr15923431ejq.381.1645441296876; 
 Mon, 21 Feb 2022 03:01:36 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id hs25sm5053025ejc.172.2022.02.21.03.01.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Feb 2022 03:01:36 -0800 (PST)
Message-ID: <28606dfa-bb93-d78c-df28-51fe79c9b2e8@gmail.com>
Date: Mon, 21 Feb 2022 12:01:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] drm/amdkfd: Use real device for messages
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220219005745.1559114-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220219005745.1559114-1-Felix.Kuehling@amd.com>
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
Cc: kent.russell@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 19.02.22 um 01:57 schrieb Felix Kuehling:
> kfd_chardev() doesn't provide much useful information in dev_... messages
> on multi-GPU systems because there is only one KFD device, which doesn't
> correspond to any particular GPU. Use the actual GPU device to indicate
> the GPU that caused a message.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>

Ah, yes somebody noted that to me as well a while ago. Good to see that 
changed.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 5 -----
>   drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 8 ++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      | 1 -
>   3 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 7affec907fd1..ceeb0d5e9060 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -104,11 +104,6 @@ void kfd_chardev_exit(void)
>   	kfd_device = NULL;
>   }
>   
> -struct device *kfd_chardev(void)
> -{
> -	return kfd_device;
> -}
> -
>   
>   static int kfd_open(struct inode *inode, struct file *filep)
>   {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> index 7041a6714baa..9178cfe34f20 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> @@ -58,14 +58,14 @@ int kfd_interrupt_init(struct kfd_dev *kfd)
>   		KFD_IH_NUM_ENTRIES * kfd->device_info.ih_ring_entry_size,
>   		GFP_KERNEL);
>   	if (r) {
> -		dev_err(kfd_chardev(), "Failed to allocate IH fifo\n");
> +		dev_err(kfd->adev->dev, "Failed to allocate IH fifo\n");
>   		return r;
>   	}
>   
>   	kfd->ih_wq = alloc_workqueue("KFD IH", WQ_HIGHPRI, 1);
>   	if (unlikely(!kfd->ih_wq)) {
>   		kfifo_free(&kfd->ih_fifo);
> -		dev_err(kfd_chardev(), "Failed to allocate KFD IH workqueue\n");
> +		dev_err(kfd->adev->dev, "Failed to allocate KFD IH workqueue\n");
>   		return -ENOMEM;
>   	}
>   	spin_lock_init(&kfd->interrupt_lock);
> @@ -117,7 +117,7 @@ bool enqueue_ih_ring_entry(struct kfd_dev *kfd,	const void *ih_ring_entry)
>   	count = kfifo_in(&kfd->ih_fifo, ih_ring_entry,
>   				kfd->device_info.ih_ring_entry_size);
>   	if (count != kfd->device_info.ih_ring_entry_size) {
> -		dev_dbg_ratelimited(kfd_chardev(),
> +		dev_dbg_ratelimited(kfd->adev->dev,
>   			"Interrupt ring overflow, dropping interrupt %d\n",
>   			count);
>   		return false;
> @@ -148,7 +148,7 @@ static void interrupt_wq(struct work_struct *work)
>   	uint32_t ih_ring_entry[KFD_MAX_RING_ENTRY_SIZE];
>   
>   	if (dev->device_info.ih_ring_entry_size > sizeof(ih_ring_entry)) {
> -		dev_err_once(kfd_chardev(), "Ring entry too small\n");
> +		dev_err_once(dev->adev->dev, "Ring entry too small\n");
>   		return;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 783d53a3dd9e..f36062be9ca8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -355,7 +355,6 @@ enum kfd_mempool {
>   /* Character device interface */
>   int kfd_chardev_init(void);
>   void kfd_chardev_exit(void);
> -struct device *kfd_chardev(void);
>   
>   /**
>    * enum kfd_unmap_queues_filter - Enum for queue filters.

