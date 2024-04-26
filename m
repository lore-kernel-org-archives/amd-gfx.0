Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7791C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 07:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11AEC112239;
	Fri, 26 Apr 2024 07:24:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YmRlHEnE";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B9210FEA8
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 07:24:32 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-41ba1ba5591so534885e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 00:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714116271; x=1714721071; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n6IOOVZSKTG6ILPQPoqZiF6FNzBPba77ZflJzj8Ov3I=;
 b=YmRlHEnEWvG69RGwn5177snPtSSz3emEO2sv6ZHDW20WMzSCw9npBI/XWVjJEeDCyU
 8C+7Y0wBkV3C29A8AU0z1Bs5sxD2XGm2G19Gnk7+0lkLiXsAPiegifQ0WJ5A/flBnWyi
 3JtlBdHbkgneq9zbssA6AaFl7TA1Qo7NgfVnyS/r9qRVWDDc9nE3d9nf5G+VESnsGS+h
 0+c2ywxVIud8VZ7XiDQgBnQHvjsg3fTWrv7+sOTmeI7LfOUMpuprdbUclrxx37/l3slq
 ZVe/w1Z/8ixMeZIH4yEAog7IxOK6fSFciGTq4ofSq6qtd+N5e99SkNeeUWdWo1hLK53w
 aexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714116271; x=1714721071;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n6IOOVZSKTG6ILPQPoqZiF6FNzBPba77ZflJzj8Ov3I=;
 b=akHeirBqdTjnLASppQvPQd76QZEb9mntbpfu1OnZpR3Dx6Ot61RGuAMPOZ5DIAWnZA
 ZGA3ZKqaIn3tK2SHiEMEeua3tLZaJVaeq6EAG1SkFjw0H6U8MZ98C2oNRsHNdmbsVjfr
 uTcrW+vBT42VPIdL3rq2S43/Rh82T5xrqW+YEMOCvbMpZo7DacHYscB4IH+SXLQoFKVF
 N/4n7nb7heCN7oAopf1ao4dJNDGfWlebWdQmFxCOMUKVNtUC5az+Zfx/NUqbvcLaX89Q
 RvVeRkQYV+xRAv+H3a4hoC84ZbAN/JPKcMklkUt9XQkFzstrh3KQK7aLdoR+VQqofqw3
 CbIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwU9glN8sf8dhcj2YL+bWJKOSvMh43BNe4vDmQ2JlHjGbWtLqrqvZiW1lEB24FeEQZndd8e3QgXM5PIyGxxLNtKb9VGHH3XH/OO0m2Uw==
X-Gm-Message-State: AOJu0YzOBIvq2oV6mRoUcyUVS0N8JdNzixpk0Nl4U2bdRz64BwXva2Jq
 kBsWLDuuIHMJnW+N2aUh+JbhOXHNjCc/8vPwtAI5vJxv/bii/keshacwdVEv
X-Google-Smtp-Source: AGHT+IE0nE+ZwONiuDodSdhNuoEbAyXEA1nInaPCBNMRZ3YQ3MJzRzJX/X3Fy9i3cJhSEX0KQl91og==
X-Received: by 2002:a05:600c:1546:b0:41b:935:24a9 with SMTP id
 f6-20020a05600c154600b0041b093524a9mr1179356wmg.24.1714116270692; 
 Fri, 26 Apr 2024 00:24:30 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 l23-20020a05600c1d1700b00418f99170f2sm27679882wms.32.2024.04.26.00.24.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 00:24:30 -0700 (PDT)
Message-ID: <03d6b335-83a2-4cd2-88ec-8c4a4975ebaa@gmail.com>
Date: Fri, 26 Apr 2024 09:24:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix overflowed array index read warning
To: Tim Huang <Tim.Huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
References: <20240426002719.1329953-1-Tim.Huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240426002719.1329953-1-Tim.Huang@amd.com>
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

Am 26.04.24 um 02:27 schrieb Tim Huang:
> Clear overflowed array index read warning by cast operation.
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 06f0a6534a94..15c240656470 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -473,8 +473,9 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
>   					size_t size, loff_t *pos)
>   {
>   	struct amdgpu_ring *ring = file_inode(f)->i_private;
> -	int r, i;
>   	uint32_t value, result, early[3];
> +	loff_t i;
> +	int r;
>   
>   	if (*pos & 3 || size & 3)
>   		return -EINVAL;

