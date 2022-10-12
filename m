Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B67C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Oct 2022 06:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A9B210E30D;
	Wed, 12 Oct 2022 06:21:57 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA12910E30D
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Oct 2022 06:21:50 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id m15so23050245edb.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 23:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tOpiP/17y3JAA4i1s5EepIHfiXGyfGUsVR5Bpq60d/o=;
 b=UE2h8LWvVc6Ec257BIKVxpWe/r99642bRkxp9ZVW/32Jc1inM/fSltLdptRyCwgyWU
 +ad4c9QkgAn8UKpBFhlyaXcYy7fgobEUjcqqTp8eWoNxdg7cA7zMqmURLr6NVcvyj6A4
 69NMAc2AWjMKiY9F1MDvbAgFC/XTm/NJfcZTgr3k0SjP4950yR3hOKVr/o55Onbp0DAD
 BylzkCkSFilMRbqz5uruFH3TSgF/oIh695hi0D1P1pFB4z6F59a1GZqT55/lV44AZdf4
 90U1IZUVRy0o2UhBfSMwsVr6v7AEfbiuigaUkh9eYQuMN0sZZzzotn98KPjx5WvRTdtS
 vxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tOpiP/17y3JAA4i1s5EepIHfiXGyfGUsVR5Bpq60d/o=;
 b=iLfqQIbJRvXUTbTs51ubRgxk8RuXPSNDuOowhq8liBsScwFLCh9hUb3X7rUWiU8Ow/
 s+VMk15YQUqBzVzAlCRwIMlGEpc8//CojX0sZVtuNdeFqZwLN5OXUWVYuUr/I19zb1tj
 b81v8m0+0bw3ymPJxixaJlQmTIJWTgfKD739uMjpFFijG2o+AjdozQYCtwt5WTCjzWdy
 IhNU9k3D1plCkwZKdntO/ijP/F8BvahTVhUb2Lp6TaYAhqt9KzXmtyz8sGFPACmtNUkx
 420man4JNnx+EdY43Q3OeLYMhOqkKiRZydSbUlha2r6hrGjuG+VMU63/jKvuBSnUpbwo
 5Jbw==
X-Gm-Message-State: ACrzQf1lxzd10XaRcUmc2t6ByTUnCpD6LAPymteuas1971KbYPNTKNpk
 +yioKiPcOUTqqxGF+KfJi50=
X-Google-Smtp-Source: AMsMyM58HGsCBnLaYqBeTSUQmd1puMSMQ+c6MCZ8rcp2oyFovbSPMJy3l6jmxx8IM9D+f8prPt3z3A==
X-Received: by 2002:a05:6402:5112:b0:45b:ed74:e13f with SMTP id
 m18-20020a056402511200b0045bed74e13fmr16480670edd.282.1665555709331; 
 Tue, 11 Oct 2022 23:21:49 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:d109:468b:fb13:8942?
 ([2a02:908:1256:79a0:d109:468b:fb13:8942])
 by smtp.gmail.com with ESMTPSA id
 n2-20020aa7db42000000b0044e7862ab3fsm10532981edt.7.2022.10.11.23.21.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Oct 2022 23:21:48 -0700 (PDT)
Message-ID: <3703e6c6-05bc-93da-0597-fd6494a15c94@gmail.com>
Date: Wed, 12 Oct 2022 08:21:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] drm/amdgpu: extend HWIP_MAX_INSTANCE to 28
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221011205606.2540082-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221011205606.2540082-1-alexander.deucher@amd.com>
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.10.22 um 22:56 schrieb Alex Deucher:
> From: Hawking Zhang <Hawking.Zhang@amd.com>
>
> more ip instances are available
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com> for the entire series.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ae9371b172e3..3ce91f660c3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -678,7 +678,7 @@ enum amd_hw_ip_block_type {
>   	MAX_HWIP
>   };
>   
> -#define HWIP_MAX_INSTANCE	11
> +#define HWIP_MAX_INSTANCE	28
>   
>   #define HW_ID_MAX		300
>   #define IP_VERSION(mj, mn, rv) (((mj) << 16) | ((mn) << 8) | (rv))

