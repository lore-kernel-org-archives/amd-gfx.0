Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07FEC35FFF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Sep 2024 12:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49F6410E283;
	Tue, 17 Sep 2024 12:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gv+8wDzD";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C730210E283
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Sep 2024 12:25:17 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4280ca0791bso54737255e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Sep 2024 05:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726575916; x=1727180716; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TwdG92Nhr+r4kJsElq3FSXPi7WSlQxICvsnwMriePX4=;
 b=Gv+8wDzDNqPElBqf2Kci2KizIK+4KZNGAKdTWQswpGL3t3OCNc/husA8tHLv5cqfVS
 MZXF6BvN8pCtrTy0+20eGGLC+gdIIEHtPbxXZt7lxFxSdXyhdhOAjcAP9ndg3BdLSB6X
 61/h6eZPegFVX2qHaHMpN1RteYiMdlqnlGOj8jBtuBOInRW0znE7+JyVu4tev8qaGX7d
 BtiqPmrb6w8TcTKuNjsak+2F14RuXQ5ABF1UwbPpkP+nvEg0SyHdO36knUHAF1IY/hNA
 6KGqkUZt6tJc8xOe0/1ADSYK4qiPxBytDA0yMk2/inquEvMVZggQ3lzvMsi/khvZy8EW
 TfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726575916; x=1727180716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TwdG92Nhr+r4kJsElq3FSXPi7WSlQxICvsnwMriePX4=;
 b=ZK97F6aQJXZewYp2VjWPvnyc+b9RW8jH6Ee4kPtfA8jtnqo3RfpbhZYeptUjiIVUTv
 lI+LxUWfOLNZ/vOqCm5gfuPt4cOLHWP+0b2PpkqTcruUW65JfeyQ96SCx3sPlecUq9A9
 AvyPUtokbuV79uXJWGMVo24DiDMDqMBtjLqIQD3ELJCo39QbRdw4SmnpbFXj9t+YhRqm
 pHVtNnPeLZaapjUj9ISbDWracfPcaK7Qkpo85PS2P2Pxa03wuW18W+JmA0Br1EreAZT7
 JoqnigYf2iayWGCwQAggBaC/WVMlR3QI+KtfNKtUv7JbOkfIiMuMoz7e7dnzS6I5uSwD
 xABA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQs3oUnhn+EN48J3/oVLG0qbV7RljT5SyYPTEATKzcYe73c/E4COB7A60Dh4IMb3tCgNKykLWy@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwlCaWvuOwYRaswTeh06Z4eM2rhCls364+HSLpnQO39Ocak6bx2
 QYk3UHvchwmR1NKe1SBRJfwTrXr54kY7sclERiYsfH1ke2Odlb6tpsEnojWs
X-Google-Smtp-Source: AGHT+IGAYTAZ1Z2afyGxjEcZ/w/yDiOQ+fIf7BCLuBIIpwz1IYRypMZFsQN8ESvB+FMALe66tVOJ8A==
X-Received: by 2002:a05:600c:1e1d:b0:426:5fbc:f319 with SMTP id
 5b1f17b1804b1-42cdb5783d9mr130745485e9.33.1726575916083; 
 Tue, 17 Sep 2024 05:25:16 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42da22b8b70sm101298185e9.9.2024.09.17.05.25.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2024 05:25:15 -0700 (PDT)
Message-ID: <38a3e3a5-cd4c-45df-b8ed-da6a5579a0bb@gmail.com>
Date: Tue, 17 Sep 2024 14:25:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 28/28] Revert "drm/amdgpu: don't allow userspace to
 create a doorbell BO"
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Arvind Yadav <Arvind.Yadav@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
 <20240909200614.481-24-shashank.sharma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240909200614.481-24-shashank.sharma@amd.com>
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

Am 09.09.24 um 22:06 schrieb Shashank Sharma:
> From: Arvind Yadav <Arvind.Yadav@amd.com>
>
> This reverts commit 6be2ad4f0073c541146caa66c5ae936c955a8224.

Signed-off-by line missing, apart from that Reviewed-by: Christian König 
<christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 7823faa3dbaa..2e3c974a3340 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -365,10 +365,6 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   	uint32_t handle, initial_domain;
>   	int r;
>   
> -	/* reject DOORBELLs until userspace code to use it is available */
> -	if (args->in.domains & AMDGPU_GEM_DOMAIN_DOORBELL)
> -		return -EINVAL;
> -
>   	/* reject invalid gem flags */
>   	if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>   		      AMDGPU_GEM_CREATE_NO_CPU_ACCESS |

