Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BBBC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 10:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5324110E477;
	Tue, 31 Oct 2023 10:21:47 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB8310E464
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 10:21:45 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c5210a1515so79479301fa.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 03:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698747704; x=1699352504; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xe5GwjZa1w2lGRZgmZjtLv/3J12+t4WzxIJJT09TcAQ=;
 b=UH9gyNxG/r3oM9H+qwSdH28QZ/admFkVyln9jO8aQbq2T8B4EFoed2qp+C/4BFak2A
 q/WNgf1a8yixwo/+XeVQRsvcP6jFkzbNtGfG2G28j2he4SZMEkI6GN7qwrCpg372Vnfu
 gt2Xbwt4nhNBFPrPzqMjxs4/GEE/ilW51kj+NTgjyC124LgbSOdn9QtVVVxe70iqppKq
 EgI4W9dy+ufTT7I2bhJo38mwlvoaZD+kTnb9jALD36h8c5VooatMpoEr1QPhBLby+cOL
 sXsjsk4ZjIs7/Q1+0nZE1j+GlW/SphC8xXWaPEvQBjBz0AA/7nvF+Q+tjq2YvAZrKizJ
 h78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698747704; x=1699352504;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xe5GwjZa1w2lGRZgmZjtLv/3J12+t4WzxIJJT09TcAQ=;
 b=nXc7ZABuozuyRpuTwsQofQwj6QvqxcU69HpSZGRrXAI5h04tUIHA0VEVsDS+ZEZBm/
 IbJEdalNiwEa30MZlrtJ/iOpqtyFC0ocRpwQq0wB/J8uuRUt/tPgDMRqVKYM0Iye8FoS
 csKzrQwxXeheGuYIgTnN+uJSEUR7aHDlpBTpE8VK76o/uiCQ0xsjY9ZEnhSBNFGRR39W
 aIeffP+w0nP6ZR5q904wPvYSslvubgsFO8g6OkYYgmiX72EU7jE5FbDLwLBAk3BjMAXW
 G8Z2JXdUgi8D8sxIDGpdWYuyoECWCIE0+4gDV7nhkCOL1JV7G3Vk8R8MEFpdLPoVmu7L
 55wg==
X-Gm-Message-State: AOJu0Yy2lSCXtR6EUK3aKRHMN/ew7WCRS551UPz8urDhGorLstLF+ghm
 165/3+VZqu7mtZwbYFR8umtYGv2nP52WtA==
X-Google-Smtp-Source: AGHT+IGKK0naZ18zkD3XI2G2HLKHTk7Ko9seVl4d69k36GbiUONoSL/BhmCzMFONWoG27zMGFxSIXg==
X-Received: by 2002:a05:651c:86:b0:2c5:2fa8:716a with SMTP id
 6-20020a05651c008600b002c52fa8716amr10663800ljq.9.1698747703682; 
 Tue, 31 Oct 2023 03:21:43 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a05600c34c800b0040644e699a0sm1319929wmq.45.2023.10.31.03.21.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 03:21:43 -0700 (PDT)
Message-ID: <6f2fb11c-0000-41b5-8205-8d86be4b8285@gmail.com>
Date: Tue, 31 Oct 2023 11:21:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] /drm/amdgpu: correct chunk_ptr to a pointer to chunk.
Content-Language: en-US
To: YuanShang <YuanShang.Mao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231031025546.574051-1-YuanShang.Mao@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231031025546.574051-1-YuanShang.Mao@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 31.10.23 um 03:55 schrieb YuanShang:
> The variable "chunk_ptr" should be a pointer pointing
> to a struct drm_amdgpu_cs_chunk instead of to a pointer
> of that.
> Signed-off-by: YuanShang <YuanShang.Mao@amd.com>

Good catch, Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 74769afaa33d..551b9466a441 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -208,7 +208,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>   	}
>   
>   	for (i = 0; i < p->nchunks; i++) {
> -		struct drm_amdgpu_cs_chunk __user **chunk_ptr = NULL;
> +		struct drm_amdgpu_cs_chunk __user *chunk_ptr = NULL;
>   		struct drm_amdgpu_cs_chunk user_chunk;
>   		uint32_t __user *cdata;
>   

