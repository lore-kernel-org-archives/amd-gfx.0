Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F3DC6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 08:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C458310FB38;
	Tue,  2 Apr 2024 08:21:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zl+qNMg6";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2327310FB38
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 08:21:35 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-56c197d042fso5787003a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Apr 2024 01:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712046093; x=1712650893; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vm3hgS2/P+905jc4sfL/O/Y/r+6ej/0YE7xWbltpNxs=;
 b=Zl+qNMg6Qo6EmMl+9zL5W0swz/PTrVI16NuX/jyXikEJ8rHW6ZJnpjaJV2IRqHwQJ6
 AMqeh2kP6Ejrmbj1du8ENMD7Z/Ongzuq5Hct4LI5YYwj+DzzdPge1DuH8RhiOfNwNVHO
 HPJJK5yA/49m/iTRFN0nlk3rcJmnfFctqTABPhhb5hGGP3CW36LZjoOUZ1HJaMv3t6iR
 66O1wpmwiXVLa94zEJp3XQtvPVPyVM1P9a7EQSjbdfnoFCPz4wUsF2GCMnrDzb8X2hcZ
 osadEcZLR2CqdfT1oDW8qnUdavjj8/8MQlHJlbQ0ydK5JBumRGewS0rqTNXKcp5pQETB
 aJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712046093; x=1712650893;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vm3hgS2/P+905jc4sfL/O/Y/r+6ej/0YE7xWbltpNxs=;
 b=O2WwLZKwSI61PLf4Dm1Ml5jSlmsTWIQMiGUZcmZzKrU3Yd6K0Yu3L191h8Ndu476yj
 o9jD9U6vY+A5crkO1oXiU1X8ikIOpuCIzugz/9uDExegKis6XcZhQbwZ6ElCCsxT3kRz
 /UuxrTeywq8ugkg6MHd7wJvI9JH3AqaY4eqCLY0r0gJagw7ia6Cl/USWIiWkBqXF28b1
 vWO7MKwQMTqKLwgyAmNr6soLOGMqGiioBSz/AB22xGIRVeq+nDPJkZsJHA+amrbeznBP
 m23FLofJteNobRIngBSeElx7h4cRSn7WZq6CwHeU8o0A96o+hsSjiXfb8RQGvn83zXn4
 RVOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgtyUrlK4hD0PRSZluTokScrFiwRiquXpoBTI4QlF92vU8EB+0JWx0E0gXXe04UQiB+iEn/O0ncA9mF0Qj8CuzNLh2w+jWYwZ3LtNgYg==
X-Gm-Message-State: AOJu0YxmofOSL19z67MjZPAsYIyrVArYTFt8w7oRi5z+vPw1zI3zsYye
 /PvjViiTs1NCeUUv6qFP8+nNXHIMB5mar48Rp39qy73FYln56kou
X-Google-Smtp-Source: AGHT+IGjY8pIK3fHd5bDgDPZJ0yExIHx7e5uPI6hNy24lHG4Hp+OEd3RRxbu/QWgfB0q0YtwaNUYWw==
X-Received: by 2002:a17:906:6b0b:b0:a47:3378:48f4 with SMTP id
 q11-20020a1709066b0b00b00a47337848f4mr7018844ejr.35.1712046093061; 
 Tue, 02 Apr 2024 01:21:33 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 k4-20020a05600c1c8400b00414807ef8dfsm17248992wms.5.2024.04.02.01.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 01:21:32 -0700 (PDT)
Message-ID: <4350c468-1eee-4b2a-96c1-ecf8c8c38060@gmail.com>
Date: Tue, 2 Apr 2024 10:21:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: always force full reset for SOC21
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240324005220.2649840-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240324005220.2649840-1-alexander.deucher@amd.com>
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

Am 24.03.24 um 01:52 schrieb Alex Deucher:
> There are cases where soft reset seems to succeed, but
> does not, so always use mode1/2 for now.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

IIRC I've requested some changes to how soft reset is done for SOC21 but 
never found the time to actually go over the new specification.

We should probably just need to adjust the soft recovery code for those 
new hardware generations.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/soc21.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 581a3bd11481..8526282f4da1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -457,10 +457,8 @@ static bool soc21_need_full_reset(struct amdgpu_device *adev)
>   {
>   	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>   	case IP_VERSION(11, 0, 0):
> -		return amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC);
>   	case IP_VERSION(11, 0, 2):
>   	case IP_VERSION(11, 0, 3):
> -		return false;
>   	default:
>   		return true;
>   	}

