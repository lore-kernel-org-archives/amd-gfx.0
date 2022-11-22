Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C69C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 07:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D6C10E021;
	Tue, 22 Nov 2022 07:35:06 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2719B10E021
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 07:35:02 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id l11so19415047edb.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 23:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cr2e9hCHe0sYJZF0mfSX1K31JRXYhZs4Ar283/6vmlI=;
 b=evFX0LKBi9j7npewvGiuWrNq/RKmYBnGc8vkFIH2iUwg39uwdp4uKfPeH0j4UmgsVT
 tfuy1lzBBdhzCL8vD7+UysLEggGFNQmCZJOsMD4cCB1Dvf7GWsCqh6ELKXGjK9TTF/6l
 QN2oYS/apI/bzhYkpcA4SPCLsI6cD9lIF3Ar+XdchwTx2qd+Ga9f0QW4lGfRWBvxMq7C
 Omtu2ONFXQHiNjUdGfwyYFeLinc0OA4jfUTEcUEWQKUQqvN/Gl6+zoo85QE3RaZT0V1g
 2ut26WNbNV+FSGnS8ttegN46qufww6BXad2hWYx3elnLTXkEm8atAawnTjZGu5f4TgtF
 UfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cr2e9hCHe0sYJZF0mfSX1K31JRXYhZs4Ar283/6vmlI=;
 b=4P2sCopQZ4KvJbnS+vc1cx2KjgLJfU5YPoQvHqtRqkKtaK2G6MMMPFZpZV8zaka8d8
 csJzkoGGf96+MhHN+AAXCd8KAwCGmmnWTx2YQjgpEMQF46m6/X36pov/s5zYwd5ze6NN
 6s60m40jYj4YGSsldXfWOkIQ7iNjgXUiP8bpS/JM+0Kh9FkRKPVmjAgR55kUF8bMmnVp
 yfOFd74ysPnXs6yBqeJ2i0QIjExH2fS1jEghp+ZZ9P+YvrRT4GpB7kVsIT6cFXtZLI0/
 rPBE9oursoCdBHL1vC9Uo9SPII6oYdnlzSw1K8ugh+ysnY9p3VhUKFmU5bHsH3qYCofY
 ItmQ==
X-Gm-Message-State: ANoB5plN7TW8Zv124GcipnNd3FqNZ/6pmTDw6BFGClzMbbLcDsVHif7V
 XmO8AlqrPjl8VTwEweJBg48=
X-Google-Smtp-Source: AA0mqf525f2FUBILH7knXk9lH3XWWh4AvlO4AaNz9Zf8GFuVK7pDe2fPKxod94HGqtsyS//uKFYNjQ==
X-Received: by 2002:a05:6402:1381:b0:468:5b78:6381 with SMTP id
 b1-20020a056402138100b004685b786381mr7308704edv.373.1669102500538; 
 Mon, 21 Nov 2022 23:35:00 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a05640207c300b004587c2b5048sm6137598edy.52.2022.11.21.23.34.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Nov 2022 23:35:00 -0800 (PST)
Message-ID: <c8879c5d-0a90-3290-9e0b-6b02c08440a3@gmail.com>
Date: Tue, 22 Nov 2022 08:34:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: add missing license to some files
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221121172058.694436-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221121172058.694436-1-alexander.deucher@amd.com>
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

Am 21.11.22 um 18:20 schrieb Alex Deucher:
> The driver is MIT, so add the licenses.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2265
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   .../gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h | 1 +
>   .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h | 1 +
>   drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h      | 1 +
>   drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h     | 1 +
>   drivers/gpu/drm/amd/include/yellow_carp_offset.h                 | 1 +
>   5 files changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h
> index 8ea8ee57b39f..61bb1d86182e 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: MIT
>   // This is a stripped-down version of the smu11_driver_if.h file for the relevant DAL interfaces.
>   
>   #define SMU11_DRIVER_IF_VERSION 0x40
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h
> index d30fbbdd1792..d3d5a8caccf8 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: MIT
>   // This is a stripped-down version of the smu13_driver_if.h file for the relevant DAL interfaces.
>   
>   #define SMU13_DRIVER_IF_VERSION  0x18
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
> index 483769fb1736..537aee0536d3 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: MIT
>   #ifndef _dcn_3_0_0_OFFSET_HEADER
>   #define _dcn_3_0_0_OFFSET_HEADER
>   
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
> index b79be3a25a80..f9d90b098519 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: MIT
>   #ifndef _dcn_3_0_0_SH_MASK_HEADER
>   #define _dcn_3_0_0_SH_MASK_HEADER
>   
> diff --git a/drivers/gpu/drm/amd/include/yellow_carp_offset.h b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
> index 28a56b56bcaf..0fea6a746611 100644
> --- a/drivers/gpu/drm/amd/include/yellow_carp_offset.h
> +++ b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: MIT
>   #ifndef YELLOW_CARP_OFFSET_H
>   #define YELLOW_CARP_OFFSET_H
>   

