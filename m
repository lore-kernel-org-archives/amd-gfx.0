Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2425CD37B0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Sep 2023 08:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1387010E20D;
	Mon, 18 Sep 2023 08:21:55 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E99C910E20D
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 08:21:52 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9adca291f99so343673866b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 01:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695025311; x=1695630111; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XjotZRTmXQAlKrR3OOYpmLlde104eHkf9pJTnNbgJ24=;
 b=f5EY7VT57x4CjNIDP3LSfrIdIg5DPS4BuaJUrDvEGKu1KggKTNapD7cmpoo6Yct11l
 P4kWzX3LMiHFVtU1BZ1THc5Yr6XWVBTmqW7uuwnOb4fCZ9hfw5vHicfQ5gooK8CeXh12
 s8cNn2LauFqTnyO66FcwBun/obV+6YLvKrTgu8sJgl3fXzIpQcGUOiViBLMoqpqe11HV
 dD/jAKk6i7LVYOq6vojFMke7awbEl6It3FTsIUi6PE+4aKbQAmtzAhMrghrf7tEVVKAu
 EV/kgcx5+hVusEL8MSRm4WnKHuRBm632fuepok+/EY1dfjDGZ/wEnx4jP0Udov8kjWVU
 +vKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695025311; x=1695630111;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XjotZRTmXQAlKrR3OOYpmLlde104eHkf9pJTnNbgJ24=;
 b=baZOaZ7oyDhVN/EulDrwBB9R39fjPAPCoObTWTiWZKWNjvLkG/CaXbUPRkIEYFKkR0
 cLTadCNSvpcnabyss6p+37Gsnk/IJjyO6udNBhVIxee6Hw7w7K7TZufx66C+LaChhEsj
 Key/7AURl8nJimKLKaPXfgEPlHwincK3i/AeJF1Igt4ULAVPTjgZAw2ip7uwY6sxqq+/
 +LY87QYr1lgW/qqREemLyouAyCMxa2Ie9xB4yRJiQAgDpwfiLaNZsa9lB8IagVluwDCI
 JS2fpq3KQsLOQa51oU4OEBOK0kl965DZkqBiDunBZAY56Q0P8ivvIHLAdiCyypHvxlB2
 RSgQ==
X-Gm-Message-State: AOJu0Ywjd8nxQoLKkh1NsydaghYk8K9CtnvRBydVWKEScccFJzgJy3rz
 mVaekhhOg7FaMPm3H2XDStg=
X-Google-Smtp-Source: AGHT+IEOnve26PUMJpcZMEBOj/RZRsxV7/1Za5lzGFu8D/mdyeCXfzYTuZAp5sgz624t75s6ntQyEQ==
X-Received: by 2002:a17:906:31c7:b0:9ad:be8a:a588 with SMTP id
 f7-20020a17090631c700b009adbe8aa588mr7349813ejf.1.1695025311097; 
 Mon, 18 Sep 2023 01:21:51 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.99])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a170906374600b009ad81554c1bsm6068934ejc.55.2023.09.18.01.21.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 01:21:50 -0700 (PDT)
Message-ID: <10c0952c-03fb-c6b2-35be-ad80425669cc@gmail.com>
Date: Mon, 18 Sep 2023 10:21:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdgpu: Increase IH soft ring size for GFX v9.4.3
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230915193409.18822-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230915193409.18822-1-Philip.Yang@amd.com>
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.09.23 um 21:34 schrieb Philip Yang:
> On GFX v9.4.3, application have random timeout failure when XNACK on,
> with dmesg log "amdgpu: IH soft ring buffer overflow 0x900, 0x900",
> means retry CAM has more than 256 entries. After increasing IH soft ring
> to 512 entries, the test passed repeatly, no IH soft ring overflow
> message.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

I suggest to have a new define for those cases or maybe even completely 
drop the define and fixed values and a comment.

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index ddfc6941f9d5..f9cde0d083fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -566,7 +566,7 @@ static int vega20_ih_sw_init(void *handle)
>   	/* initialize ih control registers offset */
>   	vega20_ih_init_register_offset(adev);
>   
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, use_bus_addr);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE * 2, use_bus_addr);
>   	if (r)
>   		return r;
>   

