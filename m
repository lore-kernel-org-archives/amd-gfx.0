Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC834ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 13:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F4B010E218;
	Wed, 21 Sep 2022 13:02:54 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F2A810E218
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 13:02:50 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so13386688ejb.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 06:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=GTDnlvHR4ZeEUXFNSLVvm7wpLy6RkZ7L3GzXMxX61fI=;
 b=UTagcC99FlqiwhyhTW+Ez8FxyLKZYUvkauGbnVNVCFdt46nLsm9MvzMfx+o/25oB6i
 xBaL+NPDgOaZk324z03qJ7/SAUwQOqf6n6oRRzJV4H9Z7rvuOVMpyD1mOjs694rb98sq
 bJiKx/lhi+Bs0oWRpw/mKhQX2Tgys8Fd/Px9aIo4HIkQUj5G6t+bApSodoMAtoDroUhK
 w6+s8gOlPnj+zYjunIjRPHhwDX9zWG9GIexkUMUw+7mWDFccWXQnBFY2/JxI8vhbrV9+
 vRb9x6uERfKXNZ4kPIJcVuyCmNXP8jncjZoBWDIuEN4fN36ZTeSzO1Ov5W19LTRVs2UU
 VdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=GTDnlvHR4ZeEUXFNSLVvm7wpLy6RkZ7L3GzXMxX61fI=;
 b=4fhKgHhNJ1LpDVbJr+hiKfBtbRNI/mqj5nr6aPR+mbh/CjsU3HnETwLfkh+EH73g2E
 c5+zY8NmxcbewCvCsgvKnHDg5m4yNJ0zvqOJlrDrfhSDdoL2sKXslfcNa3oar/SNYTya
 RfeLEA8xy+a2Gw2J+Sil80Py/463OP746OAVkYpvAKxpGTdWthK3lH4UtPPE91R0oQX7
 zI15P21DijUmBltW93jH6vWCdkv+dRzY1a5tcn2b+J8d3YTi2jybAfd7d4EJ/Got8OCv
 IdvQtn4tnx2RIw9vDT5wIVTpeyPeZj1fWeb9LS2J/C+H3iqS4rgNbJrl8eDcqfFLOghV
 FoLA==
X-Gm-Message-State: ACrzQf2is0N7jl5VCz+vF8m4QN0Inm+wNQEBsGudQ5TWtlIMVh5uj0Sh
 pozu3DS3bvxngdvbnfCWohYec4NFxJ0=
X-Google-Smtp-Source: AMsMyM5RCSQn/XQ3q6NnpwsP6SOMRsReVB5/tGyQyB7U3+YrTzN8Td/Uv3Z56y1cF7zX6wqFottamw==
X-Received: by 2002:a17:907:7da3:b0:776:a0ae:5147 with SMTP id
 oz35-20020a1709077da300b00776a0ae5147mr20422028ejc.662.1663765368633; 
 Wed, 21 Sep 2022 06:02:48 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:75a1:d004:7ffb:260d?
 ([2a02:908:1256:79a0:75a1:d004:7ffb:260d])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a056402004500b0044f1e64e9f4sm1731694edu.17.2022.09.21.06.02.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Sep 2022 06:02:48 -0700 (PDT)
Message-ID: <aba43bcc-ff6b-69c1-8385-6fc52a4605dc@gmail.com>
Date: Wed, 21 Sep 2022 15:02:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/5] drm/amdgpu: Correct the position in patch_cond_exec
 for gfx9
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220921094117.1071106-1-jiadong.zhu@amd.com>
 <20220921094117.1071106-5-jiadong.zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220921094117.1071106-5-jiadong.zhu@amd.com>
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

Am 21.09.22 um 11:41 schrieb jiadong.zhu@amd.com:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>
> The current position calulated in gfx_v9_0_ring_emit_patch_cond_exec
> underflows when the wptr is divisible by ring->buf_mask + 1.

Good catch, looks like a completely independent bug fix to me. So please 
push separately.

> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index c568a4f5b81e..65f8c8d4f4ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5754,7 +5754,7 @@ static void gfx_v9_0_ring_emit_patch_cond_exec(struct amdgpu_ring *ring, unsigne
>   	BUG_ON(offset > ring->buf_mask);
>   	BUG_ON(ring->ring[offset] != 0x55aa55aa);
>   
> -	cur = (ring->wptr & ring->buf_mask) - 1;
> +	cur = (ring->wptr - 1) & ring->buf_mask;
>   	if (likely(cur > offset))
>   		ring->ring[offset] = cur - offset;
>   	else

