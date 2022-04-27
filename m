Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12397C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 05:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54D8D10EE84;
	Wed, 27 Apr 2022 05:50:06 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53A2110EE84
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 05:50:05 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id i27so1200177ejd.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 22:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=mFlh/B0Fd1RU3rQZEg69mPVbo3QIEgZWgH2qILEo2Jw=;
 b=ofHhyHt+t0fehWtQbhlhkCwev8TawMtT3WMWAYPp7Hh1G2J09ThbfnRSlimK6DZEA1
 CxrBk5oVI77sOCN7OpG4P/ZuY0PXl2CJfYdC1jbXjZGUYHTrLf4Yk02s32BrEyK6KkIf
 i95C7rhy430JcvNDIdJCVE4ytVeGq1WmiVmAX8ZTAeetiBDdMQAJ5v84YyCN/el1dX/+
 SZJrr2P3A3qQNTI+xG5iqD6zrB9KcmbgIr3/pwpqtaQNKNm9scmvukgKDiXTRVZoOWpA
 60xxACYk/WibKOm1cP2TzE2UnknPA1f6TTYZ8vGXaAl58Ocq7LNk6B3gPNopUeYS4+K5
 3kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=mFlh/B0Fd1RU3rQZEg69mPVbo3QIEgZWgH2qILEo2Jw=;
 b=grmHgjWL+0HtiX3gKzUXXQBVGdotij/AO1uTT21shefBlp3UE3gVx4bznLY+bU4cLO
 3NlGHs177HnAkiKOYNuplE5Zr3I3FZvMPVPUPLkb77WmMl7IHwrP9fwSZzyqtqmMeRZC
 Y7EzNmoDCjIOG/k3ui/icSUQ3L1aA1F/qNlSmImppYyVhWRzDvWjBj1IFKJCG/KgrXPQ
 e6stLRd+n47qCoI4rrqq9rv9g3Xwk4XtEACUS8kWixPl5jRTNqsP9JY3FNu9p1xQ/7hP
 rHBgBJeco2D5ann1euSMe57nEX778WScQmN6lKDIFIoLIZ6fdTL19VQV2UvsmdeO+Nvy
 NTQw==
X-Gm-Message-State: AOAM530RNBgQEiGqNAHb6diGvJ6iWMewembhuEP6p1et3VhmFZYZ09jI
 RdMF1OevViNCmtpPPVYsWAE=
X-Google-Smtp-Source: ABdhPJyuJqlzC3JSB6MVgAovrZo6FwOQFXhcZ/+hdSAT7j27jVSgENtHnz5g3QHsZBBWQZ06FD79gg==
X-Received: by 2002:a17:907:3d91:b0:6df:a01c:f7cd with SMTP id
 he17-20020a1709073d9100b006dfa01cf7cdmr24862319ejc.255.1651038603746; 
 Tue, 26 Apr 2022 22:50:03 -0700 (PDT)
Received: from [192.168.178.21] (p57b0b9e1.dip0.t-ipconnect.de.
 [87.176.185.225]) by smtp.gmail.com with ESMTPSA id
 en13-20020a056402528d00b00423dd17c95asm7121833edb.95.2022.04.26.22.50.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Apr 2022 22:50:02 -0700 (PDT)
Message-ID: <229341c6-adf1-c0de-834e-c356c448072a@gmail.com>
Date: Wed, 27 Apr 2022 07:50:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: increase HWIP MAX INSTANCE
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220426182545.3006431-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220426182545.3006431-1-alexander.deucher@amd.com>
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.04.22 um 20:25 schrieb Alex Deucher:
> From: Likun Gao <Likun.Gao@amd.com>
>
> Extend HWIP MAX INSTANCE to 11.
>
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index dfc5b46c6a11..62e295fadc6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -666,7 +666,7 @@ enum amd_hw_ip_block_type {
>   	MAX_HWIP
>   };
>   
> -#define HWIP_MAX_INSTANCE	10
> +#define HWIP_MAX_INSTANCE	11
>   
>   #define HW_ID_MAX		300
>   #define IP_VERSION(mj, mn, rv) (((mj) << 16) | ((mn) << 8) | (rv))

