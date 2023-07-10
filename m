Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76F3EB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 10:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 637E010E26A;
	Mon, 10 Jul 2023 10:54:55 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76A7610E26A
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 10:54:52 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc54cab6fso43964045e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 03:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688986489; x=1691578489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0QlSWQOPU4xuLQX9RH2AAQA4aP/k46qwYHiKIel9oRE=;
 b=dADYrtl2jCWRZof5iA0hUpPI5vl93L3ONHo/v0c3A2/rzkrMqrKdtIVC0YvcBjY32i
 Sfx3lZGf9wWRl3g4T86aFemOgmyVXz6abjyM8Z7RQ4XTVPF5NXeq4ZiaY0GFv2E2iJXO
 tEvAuAIf86UlR2CZHTzZfHPcuTztqLUzUpfcufNkiK27XQjKIfdk+Yy0pbinCAqXmP0R
 M46qiME6Rr8uSVJ98btj9Ohan5BCAVECYdo+PUKidgXGyVLGB+5QcVla/PIdgacwzp9u
 h9pmBiZDlGYnNtfrO8N3bEBCbVIdcHw0W+FGh6CQn9F4b+M4XEG+cGLf9T+Os0yYHPV6
 LBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688986489; x=1691578489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0QlSWQOPU4xuLQX9RH2AAQA4aP/k46qwYHiKIel9oRE=;
 b=b3nixih3Z5YtFyJVI9MRv5Sv02v/XkSe6rzV2Uu4E1aH3BMoHqpyPuUcS61GLsqg+E
 YjgU6Z6JIXanXtjecaY3PEqrBVondCCdCJ6IpUkBtrmnps+1bXfj1JocbrGeDYW/OS7y
 zd26e2h3wO5d4Lmp2Xdz4EdgH9kklA0tgNfZ1dF6xDYZrKD0v8D2xMzDjbiMNnkkdE+M
 yXGCNyJMrwAXb5dhwWhu75in3kUuwa7FDqdrnI5eJfqKtuI/RWfAU/frKwPgfyebEWF9
 OG+20Rx3PiVe//+kU+xReJdmd4cRCtz7j0uxClkmYK2+5sEewgasyuZJGgRW5Bz7jblo
 pWeg==
X-Gm-Message-State: ABy/qLbUdxrWhGJeb4BbM9AGzEz6pZctokNsY07oSL3is3aQwGwsm0Yu
 dMiUW1zSapXNDBmEWmZ+YlI=
X-Google-Smtp-Source: APBJJlH8lRn5AaxlZiDO4lEPiX71zO6RKPkF6axws5fATT5/YA9pAZ8+10X5cPnMPFa1a1bKKCqDdQ==
X-Received: by 2002:a1c:730b:0:b0:3fb:e573:4171 with SMTP id
 d11-20020a1c730b000000b003fbe5734171mr10310427wmb.40.1688986488803; 
 Mon, 10 Jul 2023 03:54:48 -0700 (PDT)
Received: from ?IPV6:2a00:e180:1547:3f00:8e7:36ed:d042:e823?
 ([2a00:e180:1547:3f00:8e7:36ed:d042:e823])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm10106012wmj.0.2023.07.10.03.54.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 03:54:48 -0700 (PDT)
Message-ID: <6ca6ce34-df6a-884a-0ab7-8fe9e3033f3a@gmail.com>
Date: Mon, 10 Jul 2023 12:54:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdgpu: Increase soft IH ring size
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230707154901.29568-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230707154901.29568-1-Philip.Yang@amd.com>
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
Cc: mukul.joshi@amd.com, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.07.23 um 17:49 schrieb Philip Yang:
> Retry faults are delegated to soft IH ring and then processed by
> deferred worker. Current soft IH ring size PAGE_SIZE can store 128
> entries, which may overflow and drop retry faults, causes HW stucks
> because the retry fault is not recovered.
>
> Increase soft IH ring size to 8KB, enough to store 256 CAM entries
> because we clear the CAM entry after handling the retry fault from soft
> ring.
>
> Define macro IH_RING_SIZE and IH_SW_RING_SIZE to remove duplicate
> constant.
>
> Show warning message if soft IH ring overflows because this should not
> happen.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 8 ++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 7 +++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c    | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c  | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c  | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 4 ++--
>   7 files changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index fceb3b384955..51a0dbd2358a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -138,6 +138,7 @@ void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>   /**
>    * amdgpu_ih_ring_write - write IV to the ring buffer
>    *
> + * @adev: amdgpu_device pointer
>    * @ih: ih ring to write to
>    * @iv: the iv to write
>    * @num_dw: size of the iv in dw
> @@ -145,8 +146,8 @@ void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>    * Writes an IV to the ring buffer using the CPU and increment the wptr.
>    * Used for testing and delegating IVs to a software ring.
>    */
> -void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
> -			  unsigned int num_dw)
> +void amdgpu_ih_ring_write(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
> +			  const uint32_t *iv, unsigned int num_dw)
>   {
>   	uint32_t wptr = le32_to_cpu(*ih->wptr_cpu) >> 2;
>   	unsigned int i;
> @@ -161,6 +162,9 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>   	if (wptr != READ_ONCE(ih->rptr)) {
>   		wmb();
>   		WRITE_ONCE(*ih->wptr_cpu, cpu_to_le32(wptr));
> +	} else {
> +		dev_warn(adev->dev, "IH soft ring buffer overflow 0x%X, 0x%X\n",
> +			 wptr, ih->rptr);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index dd1c2eded6b9..6c6184f0dbc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -27,6 +27,9 @@
>   /* Maximum number of IVs processed at once */
>   #define AMDGPU_IH_MAX_NUM_IVS	32
>   
> +#define IH_RING_SIZE	(256 * 1024)
> +#define IH_SW_RING_SIZE	(8 * 1024)	/* enough for 256 CAM entries */
> +

Please add an AMDGPU_ prefix to the macro name and don't put comments on 
the same line as the macro.

Apart from that looks good to me,
Christian.

>   struct amdgpu_device;
>   struct amdgpu_iv_entry;
>   
> @@ -97,8 +100,8 @@ struct amdgpu_ih_funcs {
>   int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>   			unsigned ring_size, bool use_bus_addr);
>   void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
> -void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
> -			  unsigned int num_dw);
> +void amdgpu_ih_ring_write(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
> +			  const uint32_t *iv, unsigned int num_dw);
>   int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
>   					    struct amdgpu_ih_ring *ih);
>   int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 5273decc5753..fa6d0adcec20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -493,7 +493,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
>   			 struct amdgpu_iv_entry *entry,
>   			 unsigned int num_dw)
>   {
> -	amdgpu_ih_ring_write(&adev->irq.ih_soft, entry->iv_entry, num_dw);
> +	amdgpu_ih_ring_write(adev, &adev->irq.ih_soft, entry->iv_entry, num_dw);
>   	schedule_work(&adev->irq.ih_soft_work);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> index b02e1cef78a7..980b24120080 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -535,7 +535,7 @@ static int ih_v6_0_sw_init(void *handle)
>   	 * use bus address for ih ring by psp bl */
>   	use_bus_addr =
>   		(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) ? false : true;
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
>   	if (r)
>   		return r;
>   
> @@ -548,7 +548,7 @@ static int ih_v6_0_sw_init(void *handle)
>   	/* initialize ih control register offset */
>   	ih_v6_0_init_register_offset(adev);
>   
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index eec13cb5bf75..b6a8478dabf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -565,7 +565,7 @@ static int navi10_ih_sw_init(void *handle)
>   		use_bus_addr = false;
>   	else
>   		use_bus_addr = true;
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
>   	if (r)
>   		return r;
>   
> @@ -578,7 +578,7 @@ static int navi10_ih_sw_init(void *handle)
>   	/* initialize ih control registers offset */
>   	navi10_ih_init_register_offset(adev);
>   
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index 1e83db0c5438..d364c6dd152c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -485,7 +485,7 @@ static int vega10_ih_sw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, true);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, true);
>   	if (r)
>   		return r;
>   
> @@ -510,7 +510,7 @@ static int vega10_ih_sw_init(void *handle)
>   	/* initialize ih control registers offset */
>   	vega10_ih_init_register_offset(adev);
>   
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index 4d719df376a7..544ee55a22da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -539,7 +539,7 @@ static int vega20_ih_sw_init(void *handle)
>   	    (adev->ip_versions[OSSSYS_HWIP][0] == IP_VERSION(4, 4, 2)))
>   		use_bus_addr = false;
>   
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
>   	if (r)
>   		return r;
>   
> @@ -565,7 +565,7 @@ static int vega20_ih_sw_init(void *handle)
>   	/* initialize ih control registers offset */
>   	vega20_ih_init_register_offset(adev);
>   
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, use_bus_addr);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, use_bus_addr);
>   	if (r)
>   		return r;
>   

