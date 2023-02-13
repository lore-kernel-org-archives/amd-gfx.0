Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0ACC636D4
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Feb 2023 15:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BC9210E608;
	Mon, 13 Feb 2023 15:59:42 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 997C210E607
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Feb 2023 15:59:40 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id w3so6564402edc.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Feb 2023 07:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dZSRouyO+SY7BvXm4fN1RSJ8QGC1KtOeQco4s1LlpZk=;
 b=Qcp80AKAB5nOHmxQpG3UKQiVpZARLqQ6HA+aBhY74y0qyXERohEHFwG5LmKVoAd2H1
 Dz3lkl+j38Tr5oYjYWpLJKcLUadAEm1ACwAij8I60oZT6umH6Qqb2tkU6P7tzMbRG0Qp
 ciz2HHIAGoEEY/ns/upJ5c3spXm8d0kzZ/jYluKNrGtmIj2Kkgq+lRgzdjEq+UeB26Ir
 kRXeC5hCi3WMWtZHiR0qUZIy7OBtiWr+JjG9Os3qnsoxoQVXxvGMpkNhh03Z72FoajFl
 p+hqgzeKqrvzb3SybJhUiGi1USO0M3iKGH3Dworr4kGEw3v9HatWlEaffM+vqgSS+zxS
 yEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dZSRouyO+SY7BvXm4fN1RSJ8QGC1KtOeQco4s1LlpZk=;
 b=LbNiiLm3M2y8zAwHo4lSgmorXSmYVNZxmY0L3N6hvEv3ZoV9wtToXeL53ZsyW4TcyF
 jg6nqtupzj6Sbek+m1EENAhMUvlQ5AxeXLIVmS+gG+xva0/T3wvw0b+nRxt8/UbpzvCl
 d3iHb+lMSWF5ZDP1XXwzIvkpVG5PdVLapOVQcXUgJgvLVNQzWK0ImmEG7B6A2KA6Dowg
 lz10izPAqmQLCLTW+yqAdRBjkzGMFP2hz7TJpZgn3Ojijv86h4hNCd+BuynR3wSYJ0qv
 9keURqjScPl8kT7Y4CwyPmLvPtRVH9c2UiRWvzAFgQCYqXn9CR6KfnREGKLDllBMTGbY
 g9uA==
X-Gm-Message-State: AO0yUKUiZSMp6STERpCkSZ70HOJRc3MDbIy+mjxM1f7e7bx8SjP/xzUo
 Mn6EAQkPm7ZvT7FgadkzY8Q=
X-Google-Smtp-Source: AK7set+C+NK3eXJn2J3D3p3UugUjJ/qLBaPQVmIBNjrGlrl0qu5BxFSKGsEtRIOqt4FN9AAVXmGuFQ==
X-Received: by 2002:a50:8753:0:b0:4ab:1006:d3d3 with SMTP id
 19-20020a508753000000b004ab1006d3d3mr8592758edv.6.1676303979111; 
 Mon, 13 Feb 2023 07:59:39 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:4eda:88e9:8264:7fc7?
 ([2a02:908:1256:79a0:4eda:88e9:8264:7fc7])
 by smtp.gmail.com with ESMTPSA id
 b30-20020a50ccde000000b004acb890553fsm3801767edj.26.2023.02.13.07.59.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Feb 2023 07:59:38 -0800 (PST)
Message-ID: <ca637671-9472-fc70-6743-7e1cd990ef18@gmail.com>
Date: Mon, 13 Feb 2023 16:59:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amd/amdgpu: fix warining during suspend
Content-Language: en-US
To: Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230213105224.55662-1-Jack.Xiao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230213105224.55662-1-Jack.Xiao@amd.com>
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
Cc: jfalempe@redhat.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.02.23 um 11:52 schrieb Jack Xiao:
> Freeing memory was warned during suspend.
> Move the self test out of suspend.
>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2151825
> Cc: jfalempe@redhat.com
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     | 2 +-
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a10b627c8357..3842e7e62eda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4270,6 +4270,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>   	}
>   	adev->in_suspend = false;
>   
> +	if (adev->enable_mes)
> +		amdgpu_mes_self_test(adev);
> +
>   	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D0))
>   		DRM_WARN("smart shift update failed\n");
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 62cdd2113135..5826eac270d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1284,7 +1284,7 @@ static int mes_v11_0_late_init(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
>   	/* it's only intended for use in mes_self_test case, not for s0ix and reset */
> -	if (!amdgpu_in_reset(adev) && !adev->in_s0ix &&
> +	if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend &&
>   	    (adev->ip_versions[GC_HWIP][0] != IP_VERSION(11, 0, 3)))
>   		amdgpu_mes_self_test(adev);
>   

