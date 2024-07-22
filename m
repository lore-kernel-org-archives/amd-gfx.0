Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9ABC3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 13:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D08010E15D;
	Mon, 22 Jul 2024 13:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DSphRXTF";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1088C10E15D
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 13:43:53 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-427d2cc1c4eso30481265e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721655831; x=1722260631; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K/zc26KEcn7+BoPxXYDUMaI1HLQd95gzDG3MNg85OX4=;
 b=DSphRXTFo9z8M6pSUbbkusjaDUmRXbHcGj3Cq1i3eO2PGY3qmqYd/dHB8Q292tSbWA
 JPYLNSrciDkurV2RVnHAN92WY9Si/1sFMA0OUly24nGx/1gTIAEsW5CM8rRWJjMSChVF
 M/nQp+E/PKtHParmWTmNYdQnlpoRG4zh0SWygwAGJIkeMX3qomQ0ZUbaP87A20bBEPxp
 GfRrQPSisdws/84EU09+5ySHNsVt6BMS9XH2NeteklB5e8CVvvp6z53PACgIIkCLCyRk
 6vW8u30sXbILphQvf6rOGElLBVuFEOhJOgJJF21Z4de+8Zhx7xIbUndBDsBbKBKLRjJV
 HgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721655831; x=1722260631;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K/zc26KEcn7+BoPxXYDUMaI1HLQd95gzDG3MNg85OX4=;
 b=ZjV2S/lIvFFj+0X7RcF0q5VtCVGyhNM641M5lAZqYyVvw0lWMMSWZhabG8p4MtENe3
 4KDPsZMOSxvJxtPpE1xhgJj2y+yVG0YjtrdNZxNmGHk5jGG32bwP/16wnpGCwPpfwLVd
 SnMHk/V96dibqfXU4wZknmXEjmGC922TnBH/KuhrE6flTsi2thPVo+5o63FisUmR52im
 uDp/tShPa3fiZjjobw7dNFNosZfp76RlEUaGf5/t/xHxBRzQ+Jq5sFHf59y8mVNLf9gc
 FvpiN2Jq2pVss/qpvHZScjlHvvOyp8/pRXT70YdYl0MeD7mwQMWa7hIMr3Iq0QDkYmsK
 gmIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEGvjUM0GEzYpBT7CzkCUzGagybXX0114wHlnRJfLqvGjfQJoN2eN9LCoIwv4C7JJFVpX5wbx0O23wD0S1Rv45n2OrFaFKgLDwTtiG9Q==
X-Gm-Message-State: AOJu0YyiuaUQEdo6lpnadrdYSochQSpy58GQr7LNP0rVIg9gU0WqdhOA
 58LKJF8EjB76eOGrHIvz45rLc+/+jFpVF5La/FCxI7jMqMUeuiIW
X-Google-Smtp-Source: AGHT+IEa79w2AquqtvbMqiD3XgMWJO7WCCDJdaUo/7QtoM2RUCxFSv0VXKThQ7YrCrlWbcfzwxA+qw==
X-Received: by 2002:a05:600c:1e19:b0:427:d8f2:550 with SMTP id
 5b1f17b1804b1-427dc52906fmr41102535e9.14.1721655830838; 
 Mon, 22 Jul 2024 06:43:50 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6901405sm127961655e9.16.2024.07.22.06.43.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 06:43:50 -0700 (PDT)
Message-ID: <dcc99c85-b0ac-4238-bd0e-9aebbe246cd1@gmail.com>
Date: Mon, 22 Jul 2024 15:43:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/amdgpu/gfx7: enable wave kill for compute queues
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240717203740.14059-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240717203740.14059-1-alexander.deucher@amd.com>
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

Am 17.07.24 um 22:37 schrieb Alex Deucher:
> It should work the same for compute as well as gfx.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the whole 
series.

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index d84589137df9..5fbdef04c9aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -5002,6 +5002,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring_funcs_compute = {
>   	.insert_nop = amdgpu_ring_insert_nop,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
>   	.emit_wreg = gfx_v7_0_ring_emit_wreg,
> +	.soft_recovery = gfx_v7_0_ring_soft_recovery,
>   	.emit_mem_sync = gfx_v7_0_emit_mem_sync_compute,
>   };
>   

