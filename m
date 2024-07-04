Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FDEC30653
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jul 2024 07:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F33CE10EA12;
	Thu,  4 Jul 2024 07:47:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NGroItVJ";
	dkim-atps=neutral
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54D4C10EA12
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jul 2024 07:47:54 +0000 (UTC)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-2ec1ac1aed2so3335741fa.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jul 2024 00:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720079272; x=1720684072; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=75G+gDdaf15FjJaLjScUtvBNbaX6jCRsb+4X2/DS/Sk=;
 b=NGroItVJLqMt+3RkkgVz+Mq3kqM5L+vv8UJSJS1X1l8EvFtLGYSKuHQcGLeMD6kltI
 oOzxszVEy28dg0YtcHf7+aPLe/42Xzeb19zb6bzmiy01ubl84EqV0rICuOabbzAuAScF
 EeqCHRgxfLZ0OYo8tZ5A6uTk467v5LkMzeHeY4038LKAwcOrckL7iTmXZ/YsENvG+H0Z
 7g02jJDfYOrwZOzSZ5rt3D1V9W85cwDEhjg6C+xhQbEEZtC1JoAcDcdalS+de5gZmF5g
 SWfCWN0bGYcILzwNSEXa+Q7WuN77c6A0EcMF8coLuT1UGRFuj3ecnFlH5ZX5pgNrn8TG
 jAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720079272; x=1720684072;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=75G+gDdaf15FjJaLjScUtvBNbaX6jCRsb+4X2/DS/Sk=;
 b=xNDxZPoNmxgxq5V0KU+uwhvTbcOITltMj8WXM/aGNx5foqBjWHjEr3krOXqyysGz7U
 YpUwmeRB7Yg47mS8x0z8uPlAJRfJMjb2E4qAEd1suqz7PVijplqfh/X/U/WyehsRzYkL
 fi+BTbPTbdXfVvhzfUjS6nhiQUUyEuZQ3tdncK3YgWAKWLwap8tNJJ/bbkSgJz7BEFGx
 gvholc40UV++MYh3Jv9L0ar9zhnpZlbc+XArASeAs5Ni/xHPVdjeDVkSh4dN/FOU6Qlj
 f4Ib0DQMEY25Xnpg3bg9Aw1PFURXai2TBtAWvbiyo1Fq0eb7VMwPaEmirZ0enlKxYt5+
 zH4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfT3o9NaQQRePffqY3ynnY1HCscmlNPUGJSf/BHn+6hItFbwox1tyEbYbyXvBuk2Gy+AKLZS6xCKDu7k6Z7G0m+zjx74KszswWDyCDUA==
X-Gm-Message-State: AOJu0YwhXJMVZsYRW6Lx6fODdqlkk2IzWYvGQPFfnqplRhdDwe0YStH+
 fcw+imXGrhS8Yjkh/FiVIK+QDlm1afE/N0siX2n8KvwCFguszuH+
X-Google-Smtp-Source: AGHT+IH24MML1p0FZSSj+Wg7rS9IAFsSQHLj9SfkhPiEM1QaSQCRS7l6xzLxfjwl6QhH8CvLsexoxQ==
X-Received: by 2002:a2e:b3ce:0:b0:2ec:543a:b629 with SMTP id
 38308e7fff4ca-2ee8edc23c6mr5049531fa.34.1720079271968; 
 Thu, 04 Jul 2024 00:47:51 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d6435sm12891565e9.15.2024.07.04.00.47.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:47:51 -0700 (PDT)
Message-ID: <77a78e24-1e10-44f1-ad2e-5547b8fe8baa@gmail.com>
Date: Thu, 4 Jul 2024 09:47:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] MAINTAINERS: fix Xinhui's name
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Xinhui Pan <Xinhui.Pan@amd.com>
References: <20240703193611.2002463-1-alexander.deucher@amd.com>
 <20240703193611.2002463-2-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240703193611.2002463-2-alexander.deucher@amd.com>
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

Am 03.07.24 um 21:36 schrieb Alex Deucher:
> Switch to fist last for consistency.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Xinhui Pan <Xinhui.Pan@amd.com>

Ah, that's probably my fault. I copy&pasted that from a mail.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b7aac333d8e..5fd6fba07fa6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18648,7 +18648,7 @@ F:	drivers/net/wireless/quantenna
>   RADEON and AMDGPU DRM DRIVERS
>   M:	Alex Deucher <alexander.deucher@amd.com>
>   M:	Christian König <christian.koenig@amd.com>
> -M:	Pan, Xinhui <Xinhui.Pan@amd.com>
> +M:	Xinhui Pan <Xinhui.Pan@amd.com>
>   L:	amd-gfx@lists.freedesktop.org
>   S:	Supported
>   B:	https://gitlab.freedesktop.org/drm/amd/-/issues

