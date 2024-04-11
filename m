Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A42FCD1284
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 09:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 999E210EF7E;
	Thu, 11 Apr 2024 09:22:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Czm8JygS";
	dkim-atps=neutral
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9120F10EF7E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 09:22:16 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-2d476d7972aso98096021fa.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 02:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712827334; x=1713432134; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i1UcGE2zHHY5fq8H8f4xv7PDT76LvWP5graVISloSbI=;
 b=Czm8JygSoqDZoQz79R+sB3Shf4R+204BHSfdQCfaGh5OogbkKG4FhhA7E+vfS05+mh
 u7mitLDJ/J7et8TnrUIz5YNWCsrc3QkZmVO0iM3qFNHyAcNJnbo6JMs/LaQyQsG2vrTv
 fJE+cNUP/kb9EKn4La3UfG+u6vYNXVR7VGzPeR4BOy0ug6GhlBnsu9CwWwFbLqDKlHly
 0WgB+HBz7gGl7lyz1HaPt8IQzO1KLgzVQEtHUAGQOT3doiRhsgY0sQsQaVU++NBuNWDb
 ODO7lTLLH/sxd7g+0g7mzUz5HqhBD6VumPdodwT0nMT8h2ulANCn/Zbr2z5RqkkPqOJv
 LFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712827334; x=1713432134;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i1UcGE2zHHY5fq8H8f4xv7PDT76LvWP5graVISloSbI=;
 b=IYmMjlIsKMN327LqwhjnnAqElZ6nt8ioUgIzuyZXPB8+HiK7yYWWao+UgMAx4CxzvZ
 eG8YX4n6eS4oj17rug1+dpesnlAkMxGMdly++jPg5Dvzw3MuZwhTKOebZd3PGO1BQr8g
 UcSAL9Nf1ObUo1FWSZXLeQtrLq/n1t9BR6IxCB004wvkzf/i8nzy96/ws8BwRN0+cihX
 NqKUp1HPfo+Kx7tUWpjPK0dKuU8eNpYaBOeNJFEiNmEeZGuwlLRoAshC2InT4Kx1l8Ox
 WhJWvE2PZT5uF3lkdyBhBCxPXeQYiAZ6EADglIXinD1bb1dT6UiBME9b1aAlCz/K8x8m
 DDHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTHUXna+ycNCiYQ5K0ozvoi3DdaFHR8CxL9mCz++8QAzSwQ3alJzprDAAxzmZ12RfuCdRlKK2TO9ksLBvss1i5RoQjmKJuvRsZYOPWFg==
X-Gm-Message-State: AOJu0YxLbPYjIEjZ7TKS+9jllgDUH/9dsMmN1fiBbQ+EaN0RH9/dRfte
 LRTZJesFHVu+sK8Q77MjuJOsf+VmM9FdyQTymS4H04UAGu2hf2eT
X-Google-Smtp-Source: AGHT+IFvgU5c/qdpAraFAisluIQtK31PM63Vrq9bBLHbEmZrZrKA0FJYZB73BKYpph/FK7PI9Ny8qQ==
X-Received: by 2002:a2e:bb94:0:b0:2d8:81fb:fffe with SMTP id
 y20-20020a2ebb94000000b002d881fbfffemr3648354lje.39.1712827334103; 
 Thu, 11 Apr 2024 02:22:14 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a05600c4e4900b00416b92dceaesm1748277wmq.11.2024.04.11.02.22.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 02:22:13 -0700 (PDT)
Message-ID: <3e8e7d61-83c3-4321-a3ed-c72b188fba99@gmail.com>
Date: Thu, 11 Apr 2024 11:22:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: validate the parameters of
 amdgpu_vm_bo_clear_mappings
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Vlad Stolyarov <hexed@google.com>
References: <20240411032844.41839-1-xinhui.pan@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240411032844.41839-1-xinhui.pan@amd.com>
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

Am 11.04.24 um 05:28 schrieb xinhui pan:
> Ensure there is no address overlapping.
>
> Reported-by: Vlad Stolyarov <hexed@google.com>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 8af3f0fd3073..f1315a854192 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1852,6 +1852,12 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>   	LIST_HEAD(removed);
>   	uint64_t eaddr;
>   
> +	/* validate the parameters */
> +	if (saddr & ~PAGE_MASK || size & ~PAGE_MASK)
> +		return -EINVAL;
> +	if (saddr + size <= saddr)
> +		return -EINVAL;
> +

Why the heck should we do that? Looks invalid to me.

Regards,
Christian.

>   	eaddr = saddr + size - 1;
>   	saddr /= AMDGPU_GPU_PAGE_SIZE;
>   	eaddr /= AMDGPU_GPU_PAGE_SIZE;

