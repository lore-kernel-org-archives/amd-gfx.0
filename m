Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40393D2B925
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 13:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E761B10E412;
	Tue,  5 Nov 2024 13:42:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Re2nbhOe";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D884210E412
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 13:42:52 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4315baec69eso48381195e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Nov 2024 05:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730814171; x=1731418971; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X0LbOpMZOfJ1mTtJjscfxvbSnIthvppCCAm3mmuCY90=;
 b=Re2nbhOe+333V+qS+vOoXWxKEZCSTqWhmuFtwQ48NkMLqKUt6hpUgUy5eK8+mqtYQc
 5u9MYIzjxHEdxf/Ncctwaoz+hpMFppjQo9GPiCwK6yZqsDh8gIuXC2VZB0dcrzt1FFdE
 A5yLAfyaUeaGbTYiNTrKQ9/9gN4zzZ7R46yuo+8fKz8ISgqvqApm7Y1cQQrhWI0TBNLG
 ck9SSAmhpLlFtbb3+KQ6mNjrIQKFGHiC+YjiyvV4ehzgkksLJFI+XzojzU285vQ0zQOo
 ffKTXzYmPPOuncF3VZJw9/Hgk0Wpel5+8YQqZRh0brOkxnf49+Ukr43UY5k5mIYw98v9
 w/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730814171; x=1731418971;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X0LbOpMZOfJ1mTtJjscfxvbSnIthvppCCAm3mmuCY90=;
 b=scl2VB9TUbLTUS8wOcP1aN2es7okMpXF4FUMC+8nD874wuMvr14vF9Ak6ftB5BN97/
 ueGXSb9ZRW0YooZbdbMIBM+PYpFtOmPAbvFOX+j9QRRBJSOUqNJdDeDUaR1s9d4CBxGu
 KoCRgSZDi7XLmsX3w/vJ97K6FMxAr8c/I6nz/KfkzkpkYHZjC4tiHGmAmn7LR8fZqXZb
 FPgefqMvkXZzBRsGx6sfdTp3KqX8ZNuI1oaKmp/2EFafU8QKDR+SyXneWW2Hh8ACyNg2
 TZYgTz+kkt7Wdz+JoBfQgbOf20FZEQWmfbEZfayfpsGdRQFqTNk91c1fWswb93kuGRjx
 UjMQ==
X-Gm-Message-State: AOJu0YzjDYF4c4wLhtOo63SltdcJKlnXllb/fO3yr/HnNbjnXiu9nH54
 4d/P/QPG8hs6FFX18cJXpXsfEEkoNlUyRS3XjOIJ+ZemJ+KK4QLv
X-Google-Smtp-Source: AGHT+IGSRpiVtLmnl2SvsyIOgr8V4SogtNxBWIzlwsHXFZC77En47v/x605qfDqc+TKFF3urgB6Drw==
X-Received: by 2002:a05:6000:21c8:b0:381:c7b7:706d with SMTP id
 ffacd0b85a97d-381c7b770a1mr10846876f8f.27.1730814170864; 
 Tue, 05 Nov 2024 05:42:50 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e725dsm16275267f8f.56.2024.11.05.05.42.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 05:42:50 -0800 (PST)
Message-ID: <e6dd8f17-2322-4fd7-bdcd-861e77fcfc8a@gmail.com>
Date: Tue, 5 Nov 2024 14:42:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Bypass resizing bars for PVH dom0
To: Jiqian Chen <Jiqian.Chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Huang Rui <Ray.Huang@amd.com>
References: <20241105060531.3503788-1-Jiqian.Chen@amd.com>
 <20241105060531.3503788-3-Jiqian.Chen@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241105060531.3503788-3-Jiqian.Chen@amd.com>
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

Am 05.11.24 um 07:05 schrieb Jiqian Chen:
> VPCI of Xen doesn't support resizable bar. When discrete GPU is used on
> PVH dom0 which using the VPCI, amdgpu fails to probe, so we need to
> disable this capability for PVH dom0.

What do you mean VPCI doesn't support resizeable BAR?

This is mandatory to be supported or otherwise general PCI resource 
assignment won't work either.

In other words you can't hotplug something if that here doesn't work either.

Regards,
Christian.

>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> Reviewed-by: Huang Rui <Ray.Huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b3fb92bbd9e2..012feb3790dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1619,6 +1619,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   	if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
>   		return 0;
>   
> +	/* Bypass for PVH dom0 which doesn't support resizable bar */
> +	if (xen_initial_domain() && xen_pvh_domain())
> +		return 0;
> +
>   	/* Bypass for VF */
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;

