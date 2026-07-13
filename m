Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4051C44501
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 10:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B84310E5B4;
	Mon, 13 Jul 2026 10:15:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="qvXOeFB1";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 135D810E5C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 10:15:17 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493e8d4f4dcso23285505e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 03:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1783937715; x=1784542515; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ezVvMXgVuxsjETkQm1N+Yw2QZyX2xds9AKCWJ1Q4YA0=;
 b=qvXOeFB1/rOe5Qhdof76knC7GztlCDQOCO5qShyxb1EF2nE+Z3//KdNz8/Nywijr3y
 L3ARPS8PhtBxZZGG9juRE0b7JOz7XTa+9lFNvzNuulYGVaJR5gQgr8SqTFXVeL5XZGTx
 WYYBrEz1QWtgF8XRfBp+QBgKEuNN4uHGctmL2WIzB8ITKKNNwry2Xvx81lmIvLfZIiqT
 FEwt/1X8SrKWg/aFHbKrhmLiBHBfV+QYtR28x9MR1alQpvN1cUV8+q8WydNbxZgPK4eP
 2DEbOxvEh+esnjW1eqIvYN2hXn9jYOuEfipWzNheIyf7BgwjDN3gez6sTacwgdLHbWSr
 ne+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783937715; x=1784542515;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ezVvMXgVuxsjETkQm1N+Yw2QZyX2xds9AKCWJ1Q4YA0=;
 b=E9AjckR4drLkgDbR+7m6nhYWegnJrdfky0GGvTQwFkyVxh3XRe4fLv+02K4f8w0wIX
 vH0ZonyaZXz7rTHOChbp/m0EqF8pghH9kChEhCf/wa53gY+xhO+DSlLPnY7sW2UMGeKt
 XDjr4bfLgh1F0qOOXyVZQM65UcBgk3EyiQj+uVbWwKe/pAPAiRsqI1pmT/BI6T9IaXid
 hbXY/X5w4I9DW68wSaMXYCn6pT/yjlxLoVV7+987tG6l+kVLouwyoy49xN7FLfuc/lKk
 FXkgHRmM2rTHDNCt3dt7VrRx+xf48PPNHw4cTghrjUoBWJnZUk+fMx5lY/VqdznnWOD+
 bngg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqgf6nyy11/PbRabPFKurzj36Fly3GhHOozYP2cQrnoBvnA150asYRbb/2UZIvMjIGmWA6O1oLS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzpvqE6FvQhskxcjCejGq5hLuHIg9Lk0iTAE69qoHYdYHIKAxV4
 Q2k7QVxK6IFp5txAYqw7YaFy/yHnmxPXjKS2FjI1dzfMOhbhl9ge1x9vTrkzZ2cOtiU=
X-Gm-Gg: AfdE7cmop/hhWNesgBaHQ44O91lWBDXqRK7uIW0kcsVkdjhDTzpq8FmDaQbh6T9nRaE
 FZrji86YX5oB5ANXRkjlnINuEc2fZpJlR0KPJ4z7TwaO2rKVm280HbayaHTEaw5DTOkUMLRFyZf
 D1xcdepd+n225GFi7CdlkIO4QjJgj4GVv9EcbBO5BQ/nV/yzMXWOwAO1UP7p0bHUqLZ1JJ62VNp
 N59axea73HihKcvTnYUhXx6qwZcnuq2o+GThqhYFI7BTapafZ3TQH9xAX3GQgYOk6Atur6bzefP
 ifch7DQgV1l+0kf3/CwIhhH9SWumRBKbDPGV31akisjMUwNMM+2CvAuVNitvTNDgLlUsaADST0C
 cfSpvRoAHiFhthsMQHVRlTeXvRVFn8DVEIw023nwPClTUZF2p08uPlz1NLuZgVJpfozvMToMNk8
 beguItxlXELa6J9QZ8Xvdi5xBelf+I1e2L+Q==
X-Received: by 2002:a05:600c:154a:b0:493:f73d:cc6d with SMTP id
 5b1f17b1804b1-493f8824ba6mr95320975e9.24.1783937714683; 
 Mon, 13 Jul 2026 03:15:14 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6e0e5asm353267425e9.9.2026.07.13.03.15.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 03:15:14 -0700 (PDT)
Message-ID: <c1d30a27-0fa2-442c-b2be-aac23137a08e@ursulin.net>
Date: Mon, 13 Jul 2026 11:15:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/display: Shorten name of FRL polling workqueue
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 mario.limonciello@amd.com, alex.hung@amd.com, harry.wentland@amd.com
References: <20260711113009.26512-1-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260711113009.26512-1-timur.kristof@gmail.com>
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



On 11/07/2026 12:30, Timur Kristóf wrote:
> The current name is too long and triggers a warning.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b97ceabe6173..6299f0e384f1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -829,9 +829,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	}
>   	if (adev->dm.dc->caps.max_links > 0) {
>   		adev->dm.hdmi_frl_status_polling_wq =
> -			create_singlethread_workqueue("hdmi_frl_status_polling_workqueue");
> +			create_singlethread_workqueue("hdmi_frl_status_polling_wq");
>   		if (!adev->dm.hdmi_frl_status_polling_wq)
> -			drm_err(adev_to_drm(adev), "failed to initialize hdmi_frl_status_polling_workqueue\n");
> +			drm_err(adev_to_drm(adev), "failed to initialize hdmi_frl_status_polling_wq\n");
>   	}
>   	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
>   		init_completion(&adev->dm.dmub_aux_transfer_done);

This one does not require display knowledge so I feel okay to review it:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Two nitpicks would be that the _wq suffix is even redundant since for 
the task name it will have the kworker/ prefix anyway. Second one is 
that while touching this it may make sense to replace the variable name 
from the error message with a human readable name like "failed to 
initialize HDMI FLR status polling". In fact, is this even an error or 
should be a warning given I do not see an immediate exit?

Regards,

Tvrtko

