Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708A9C61D97
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 15:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 091B110E65A;
	Wed, 22 Nov 2023 15:11:42 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B0C310E65A
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 15:11:40 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40b2979a74eso14478735e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 07:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700665898; x=1701270698; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TnkAUI6tyMrGbaSyTNTqw1sM0D2avYCMZvR4okKJDbA=;
 b=MQltGFidn3NDVtuTqvbWSaOqszPcjOkiA7xB/+6RpDo/bp5qnVt0vAiAu3l6k3elL5
 kweCUYQyXOwPofNuUr3aLl546DPZ2mYneq1RSTf6bGPfJfQfuk8Q1mnoCpKxUCAH6bNI
 L3W3YVftp0jacEqYY+ymkjEJqNtTk/Eg6KEpicAn2tLsdPelmAGTSJlJ2dWwTdd3rqEC
 YzNVlf88Qgn7GI70qSHJWyTSEWDixjBA4/AE2UlcMcBH3xjr+nlohAYiq4PLSDuYJ+Lz
 WCUWVZYSRtenq9NRZHsyzfHwNAKjEOL9bOv7dKcxEznlELvdqmukDOrLowT2ML1uRs3b
 d70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700665898; x=1701270698;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TnkAUI6tyMrGbaSyTNTqw1sM0D2avYCMZvR4okKJDbA=;
 b=bssVBggRhz2XpM4eaPJONg699tCBn6lNZz9T6HbgLLRI+wm2puvwPFxs9u3QqlPOsc
 2CealIB7Rji/Hzu8QI1KDTvBIn8u1pVBtX1vreV/ndGZgE2zLZvzZR6dMMg2pRdSkg0T
 jHsFJn+2Nfa2BZuhciSgOg7FWrVHC2VSxRGkHk8eYxpU+Y02zgX/MiHCUvb7i7v0qU7W
 qdJMvAqpHYYsm6PX62gmuTp0ubtklU/x1Mk+77oSsk4CzygSOIiAdtbXHktL3cBWmmzz
 njwU5DOYWrWSOUuo/rXka06bEi5+bWQsuY2b+zlpyRmOPr9uRZBDyuHvHvJzp+VgLyWg
 SuZg==
X-Gm-Message-State: AOJu0Ywi1NK9ylcRnrnn/ouMeE1IfkfhSHar+NzaSdIzrDxe06XYr/No
 ZWk5NPgGp8wdIJMXl9H2HiU=
X-Google-Smtp-Source: AGHT+IFkA1DXqXPXMtQ1dVvQ6lHz3Ek7Os0WiW576SddNnh6b8XNxOHKzQ5xQSYqz5869htfEhs7fw==
X-Received: by 2002:a05:600c:314c:b0:401:b53e:6c3b with SMTP id
 h12-20020a05600c314c00b00401b53e6c3bmr1966177wmo.6.1700665898314; 
 Wed, 22 Nov 2023 07:11:38 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a05600c314c00b004097881d5f0sm2503446wmo.29.2023.11.22.07.11.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 07:11:37 -0800 (PST)
Message-ID: <419cbbcb-a064-4b89-b5f2-4f916c84ac08@gmail.com>
Date: Wed, 22 Nov 2023 16:11:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: Correct the documentation of name and exp_name
 symbols
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231121181152.33213-1-Ramesh.Errabolu@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231121181152.33213-1-Ramesh.Errabolu@amd.com>
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

Am 21.11.23 um 19:11 schrieb Ramesh Errabolu:
> Fix the documentation of struct dma_buf members name and exp_name
> as to how these members are to be used and accessed.
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>

Looks good to me, but you need to send this to dri-devel and a bunch of 
other lists as well.

Try to use the get_maintainer script to find all recipients.

Christian.

> ---
>   include/linux/dma-buf.h | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index 3f31baa3293f..8ff4add71f88 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -343,16 +343,19 @@ struct dma_buf {
>   	/**
>   	 * @exp_name:
>   	 *
> -	 * Name of the exporter; useful for debugging. See the
> -	 * DMA_BUF_SET_NAME IOCTL.
> +	 * Name of the exporter; useful for debugging. Must not be NULL
>   	 */
>   	const char *exp_name;
>   
>   	/**
>   	 * @name:
>   	 *
> -	 * Userspace-provided name; useful for accounting and debugging,
> -	 * protected by dma_resv_lock() on @resv and @name_lock for read access.
> +	 * Userspace-provided name. Default value is NULL. If not NULL,
> +	 * length cannot be longer than DMA_BUF_NAME_LEN, including NIL
> +	 * char. Useful for accounting and debugging. Read/Write accesses
> +	 * are protected by @name_lock
> +	 *
> +	 * See the IOCTLs DMA_BUF_SET_NAME or DMA_BUF_SET_NAME_A/B
>   	 */
>   	const char *name;
>   

