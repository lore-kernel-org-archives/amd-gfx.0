Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC62C47073
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 08:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1017A10E3C0;
	Thu,  4 Jan 2024 08:08:22 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57EC710E3C0
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 08:08:20 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40d5b89e2bfso2269185e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jan 2024 00:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704355699; x=1704960499; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hDBP1S6d5pgJK5neCLPtBU8F47+E7qFXXTv8cTcrABY=;
 b=g+n3BZKHA7TY5E9XjeiYbp4xf1DDlDGyF5zUXUo6xQxP6ZZgXJgA8H5IOOmHVzV+FL
 on9qY8KK/xGJ5wWrD+EiTrwocXu2JdBEcXnoD7zvzoe/ztAS7nkOqvjrL95LKCK1v8nA
 x7cKNBgpehGE4V/LHxkecfBDSQFvMTb3abSP+nHgB5y8q2tlXmhOI5S7IodxwXT3GaTx
 5Gjo+5PUCcMdFfHTB4ZPIBBkfmfziVM6eS6wgibXglv3re1+BABkjeziSb6rXkt8RmSX
 SGLSKgkNAZMPJvo+0VTgbaFXnN87DGNY6BNMe5KDeKPZ5sif+L+JfO6goEBawJXoLlv5
 9wzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704355699; x=1704960499;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hDBP1S6d5pgJK5neCLPtBU8F47+E7qFXXTv8cTcrABY=;
 b=gZ+yGWnjuar+LbsmCL3lZSIVexGCcZQZJb4nngdaWLHJSJw9NFdYOg0wKw5Mp1/L2j
 05jjlzC96ZkEwypPvHRQXR0ZyGOKQY/grrryNEuWKfrPhtdCWMyOGesVYfOJBCavwxZS
 axdpop7rM6qtKOwXO7PH+7SsBo/d3uAiJV9ZDt9vYH0HpScI31VOiz1IVLCMhPZfIQ4w
 edJOmL/qx9jKl0fW9RBCECng3nKtVtTloucLWdFOvC5SMW8PVhLT0KCBT3PLqTIY22y7
 x6+qrWDDo9UYkO/jPBp/2sjB1zDtiBTqY74J4D2HqWAEMwrPfsrZChz5q99Oj983WXLI
 oYAg==
X-Gm-Message-State: AOJu0YyMjjPiIcr0KF6QbRQg4fbDnYBilvB7uhs6UlbiwEzBWsejVxys
 XzAhw+1l7EbsCDB0tPRacFM=
X-Google-Smtp-Source: AGHT+IHSidpGgn4n/HpHtpnAoQUvPe0eJVjIuHrSDTYpfQAY+wtLmmhsaX0J9AbwZh9D0bSoL7aBBQ==
X-Received: by 2002:a05:600c:5107:b0:40d:8fcf:d822 with SMTP id
 o7-20020a05600c510700b0040d8fcfd822mr114150wms.172.1704355698526; 
 Thu, 04 Jan 2024 00:08:18 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a5d4c8e000000b003374555d88esm6479801wrs.56.2024.01.04.00.08.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 00:08:18 -0800 (PST)
Message-ID: <4847a2d1-967a-404d-bc6b-17cd4d24b116@gmail.com>
Date: Thu, 4 Jan 2024 09:08:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix '*fw' from request_firmware() not
 released in 'amdgpu_ucode_request()'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20240104032358.2240226-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240104032358.2240226-1-srinivasan.shanmugam@amd.com>
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
Cc: Lijo Lazar <lijo.lazar@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 04.01.24 um 04:23 schrieb Srinivasan Shanmugam:
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:1404 amdgpu_ucode_request() warn: '*fw' from request_firmware() not released on lines: 1404.
>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index b14127429f30..b8d000105816 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1401,6 +1401,9 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
>   	if (err)
>   		dev_dbg(adev->dev, "\"%s\" failed to validate\n", fw_name);
>   
> +	release_firmware(*fw);
> +	*fw = NULL;
> +

That doesn't looks even remotely correct. This code path is also taken 
when the validation succeeds.

Christian.

>   	return err;
>   }
>   

