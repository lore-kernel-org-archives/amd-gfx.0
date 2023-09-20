Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F33CCE79AC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 05:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08FCF10E0AD;
	Wed, 20 Sep 2023 05:57:33 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEBA910E0AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 05:57:30 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so815253566b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 22:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695189449; x=1695794249; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MowTRJp/dmEjs2LRf3CoqE08mnwg9UjVcmcr6oXbHiE=;
 b=HEGeuOkPV2ynZ51y+mT0sByB5VE5ePbWpEn/7nghkLlMpu+lLI0LPfAwGQaHZyGU7c
 fnUmj87Nkilkr0vlqE8IobCF/nvleI+2GqnziizXl/okgk6ZJE5ZY+X+W3xx4FyhqQux
 WF7w1l3KDUl8b0njlSFV6ntIal1ZCugIjwonqUBAjqy8X4ifhYixNVVAh7sSSlCty6zJ
 wNg/M8MafPHpGkZUaBootBALj9UDaeZ3hxgDB5HBqCyyFRHVxKu7O02sySZ0y4aHI36A
 lAV15oUvBy+wKkg4rUMcLozHISlzpNhFFrjrVozkdWqoZAF4EPXm0aM6BK0f06OLDsfA
 4BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695189449; x=1695794249;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MowTRJp/dmEjs2LRf3CoqE08mnwg9UjVcmcr6oXbHiE=;
 b=BsTsALU/RDukyzxwYMoKklg3X6hCb/IWWuI7h52LMryRf7KwoTH03kPhFQmlJ7wXPL
 qaJ+DESDyWULGxtcnjaKZ9z3SX6cFlq0uiV66XaqdoAtxI8pINuIrK8WHuRFzIFluc2y
 Qitf6mJ50Wocphzbexa/65nN8PEZ5ruE1E10FiXNP6/+18pcfnysVTab1+p9Kag+Vkj6
 HZFL+H0FXVM4jbT4Gk6uGqKxpdvmo2nS1c540N5nsoquP4nyKJAF9r3CHb76UtTf8Zpt
 PLUotDnEAKjNNxwJw4xJ9j7L82JKkB0ftCiEU8mSj4aste3hqzQxJiyaQHxz0uj5NK4d
 5d3A==
X-Gm-Message-State: AOJu0YyF02l4Oe92yxJE4LnzKL1Mst7W2TrSsWFjYUsArK5ayedxdrDo
 QT6LNbGmO21kv0KDBCYb8sc=
X-Google-Smtp-Source: AGHT+IHyjqQtqARSH5fZfkk7T6yc3HNhTvYv4/fYitOy5fN+fYDdFO23VPL/yR50CiKwuf64+Z4xAA==
X-Received: by 2002:a17:907:7847:b0:9ad:77ff:9722 with SMTP id
 lb7-20020a170907784700b009ad77ff9722mr1208875ejc.34.1695189448873; 
 Tue, 19 Sep 2023 22:57:28 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.99])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a1709060ad200b009887f4e0291sm8751833ejf.27.2023.09.19.22.57.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 22:57:28 -0700 (PDT)
Message-ID: <f3828d8d-41d2-1b23-9ba2-daa89bf0aa33@gmail.com>
Date: Wed, 20 Sep 2023 07:57:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] drm/amdgpu: Increase IH soft ring size for GFX v9.4.3
 dGPU
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230915193409.18822-1-Philip.Yang@amd.com>
 <20230919141702.12654-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230919141702.12654-1-Philip.Yang@amd.com>
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 19.09.23 um 16:17 schrieb Philip Yang:
> On GFX v9.4.3 dGPU, applications have random timeout failure when XNACK
> on, dmesg log has "amdgpu: IH soft ring buffer overflow 0x900, 0x900",
> because dGPU mode has 272 cam entries. After increasing IH soft ring
> to 512 entries, no more IH soft ring overflow message and application
> passed.
>
> Fixes: eb3220ab4793 ("drm/amdgpu: Increase soft IH ring size")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index 6c6184f0dbc1..508f02eb0cf8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -28,7 +28,7 @@
>   #define AMDGPU_IH_MAX_NUM_IVS	32
>   
>   #define IH_RING_SIZE	(256 * 1024)
> -#define IH_SW_RING_SIZE	(8 * 1024)	/* enough for 256 CAM entries */
> +#define IH_SW_RING_SIZE	(16 * 1024)	/* enough for 512 CAM entries */
>   
>   struct amdgpu_device;
>   struct amdgpu_iv_entry;

