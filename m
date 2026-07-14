Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41B2C44507
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 08:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD1F310EC43;
	Tue, 14 Jul 2026 08:02:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="TOb0j1Sn";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A858F10EC43
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 08:02:58 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4759b4f0897so363866f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 01:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1784016177; x=1784620977; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZQs/lndaQfLqx30aI5NP0RL8O4A11HHgmOQfnkQqBC8=;
 b=TOb0j1SnnMhq1NsW8GUSWBsojvFqH1xMDaGACyt63+G2+1/0UjisMiF4GpdWxfJy+D
 9EJCyWlX5PQqlLe+W4b9uQiJHCKQhrUKAEyYQYWCH2/juPG1YGSCJi4sGPx7K07CG/aW
 SMXbyNjxAYEpErRet1TKFKb8+eYxAYmxQFdxGfPd8KrconLfp/d4wkb9l+xl0rHuvicc
 kCcJGOp6uVIzImo7ZQJPteHP+7BqLcneRoa+AXnL1vdHjM/IFvSK6xrN80zf8Ou0lo/o
 Xvyksa8EGIU3uAH2bjVOggQuq6oD4Pxz1GssfZxWqMf3UnTyWgQ5Kz4hGiKudUhx2gp5
 soYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784016177; x=1784620977;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZQs/lndaQfLqx30aI5NP0RL8O4A11HHgmOQfnkQqBC8=;
 b=NKeZWGX9FSj2SzttDf9BT4QAZPTyk9CR9BZP/G5frb4Pb+oLu2rCGJhYpGPK64n4FO
 WqjgAGCEBw834NKHBaM6p/rgQqVc+1k/+3YDKqid+1bOQjCak45RDiHGHRMmYulkOog1
 A7DZ87HRv28/mHLg9FC6zNw9Pb34oDoQUMFXNsU4Pgdm6v3XBw7WzshTNzr+p9WsV/Kg
 XmQEj4FxqaJCH06SyPs0VtbYRvBaCFPrpTQPzQ35wSwIeSshJSX4zaLkCzBBpjK+I+lI
 Bq5bwQYkKmKSUGynpIqF7ZSSMkFhqnLQr9ZWmtgi7Oti7aiy6Hfek6omqzfeiHosd5BL
 P/iw==
X-Gm-Message-State: AOJu0YziTL2Z00CFQZHtw1lX8zMH8uB/dxvCVGpmJNUpeY4V2vSa9fom
 JUabAQ1Mkr6FQvAO1xG5azLOSuUck5FmHfHFPSf+ZfZc/JEVhYdpI0AS8Oj+sJ1zB1s=
X-Gm-Gg: AfdE7cmD3Bj1bQUjfVS5NyR+RvGp999v1pRrkmf27OjWHF0+RvPBh+RBn+h+dSo1J0Y
 bAzV+l6LvtV3V2TkLC4Gv//jR9yRvLVgF3dq1UnNJU3ZjZGs7thHbYS5AsEOeBUZVfNBiihp1/3
 pCk1ETFunnm/QIP8UZAkS5BVTQlX5TrLUv8SDgA9QNPlXCRjYmoegEmCDiB6TP6yzirzeelR7HU
 1PDCotqG5DZiYo+LVVXZ9kipYumUVTj/Z8q8jsEJjbJknqo2EZoEMXhq85RFVZ2nqmqJM6QsjyH
 2YE2rScIE7Tc9NwelSSWVDFH327kluExb8fzNM1WKU3DxpFc9v/0974SCYNoUn0VhIYgsh9sVAx
 nwX4142PtWm/NlbJALU1ha63wZOpjneXLE5qUSUK843mZYI17V0g+cijiusqHMye6V9PVYtOnmG
 Mo3ITRWGYCPEYSpJr4Uzpk96Ciu1tAAWPWEeiC7lJVan9l
X-Received: by 2002:a05:6000:2004:b0:45e:73eb:5119 with SMTP id
 ffacd0b85a97d-47f2dc9bf61mr13935562f8f.22.1784016176473; 
 Tue, 14 Jul 2026 01:02:56 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c25b2sm6460345f8f.30.2026.07.14.01.02.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 01:02:56 -0700 (PDT)
Message-ID: <3e109b17-539d-49be-a096-bcd669fed5ae@ursulin.net>
Date: Tue, 14 Jul 2026 09:02:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Remove unneeded semicolon
To: Chen Ni <nichen@iscas.ac.cn>, alexander.deucher@amd.com,
 christian.koenig@amd.com, tvrtko.ursulin@igalia.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260714073903.3646544-1-nichen@iscas.ac.cn>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260714073903.3646544-1-nichen@iscas.ac.cn>
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


On 14/07/2026 08:39, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index ce1d08f112a8..c5cde42333d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -211,7 +211,7 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>   
>   	default:
>   		return -EINVAL;
> -	};
> +	}
>   
>   	switch (args->in.operation) {
>   	case AMDGPU_BO_LIST_OP_CREATE:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

