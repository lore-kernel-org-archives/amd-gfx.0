Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88210C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 18:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1026E10E3DF;
	Thu, 20 Jan 2022 18:15:33 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EA0610E3DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 18:15:31 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id p18so13839861wmg.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 10:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=/1niYLAEuaijbIFq33MZTPkGdWDJYXePP52dnn6Zn2c=;
 b=OS85OKzSApXoK1N0lrYEapqDayLiPZaUMX6p36RKbAypCLreEmIzbdi+3FzcQhEEju
 pOXPhD32zDG6ckDdCep14g/AECZaHHzvvPAcaw4IazVjQHsXYP2gAVXdRJtpl/qjiduU
 m53NLmPsFNlpKQhbBRc6p8DiVk5T4E9Y6sY9EDd4szj351KzB2EueHYwG3ETAne1yuMs
 43BLxannePzd2+aAW9CuGY51pbPl3w1tP3Pb1v37MlSBAhUPHrKG8OjExCQYCGchMkTG
 qagVF58nvCMuvQDcG5gD1MAnAsL1LWCsHpbEzF7e7XiZgVcbgOlyeWoJ0YGK3frQFzTk
 zwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=/1niYLAEuaijbIFq33MZTPkGdWDJYXePP52dnn6Zn2c=;
 b=yrfFCUvuqBiT/aHfqPg74vpPTNJeRXh6z0j2yko2Ikg0EL2qipJk7OZWdwn2fc86jo
 t5MW9nQxp/K3YhnPltEmhxheZsS1nmNqmQccPeTzq7WImRsWQIvVnoR47Aq3X0QuOUzQ
 FggrN9M/CDUPd+B+voMcDKalBFfPS24GWUlgWsGEy2YBU7xWmuWJIhGE4sYx4BuOrhp3
 y+rQQilEJmpDf2oCjl5jFUMJsOBiRi/Ex4FoofIQfzjfNdtYlZm2UZw57ojTvR6k5377
 mStOgPkZAZP5XO1VLqjsdc5yr0dje0WBeSTAK0s9+q06WGoILOfbFC8bgwFBD+iBaBu3
 35ew==
X-Gm-Message-State: AOAM531T8QUnj6/ytis3U6S7bgf67jZfaag409mhRBwSBpZrg3zWclGT
 KfMdvq2fWuHdE8b7dB/cTGZK3esTAqU=
X-Google-Smtp-Source: ABdhPJzein75xPLgdQoPMvOYmnwMd52uTS9nzIw+PmDSbQY8kWYQYEUJ0bke4X+wu33qMKLZxezxMg==
X-Received: by 2002:adf:d1e7:: with SMTP id g7mr255608wrd.642.1642702529965;
 Thu, 20 Jan 2022 10:15:29 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:49c6:94a6:8972:baf0?
 ([2a02:908:1252:fb60:49c6:94a6:8972:baf0])
 by smtp.gmail.com with ESMTPSA id bh26sm2849903wmb.40.2022.01.20.10.15.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jan 2022 10:15:29 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: filter out radeon secondary ids as well
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220120174858.597208-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0bf21d1c-b648-4b12-c131-7154efc5ebc6@gmail.com>
Date: Thu, 20 Jan 2022 19:15:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220120174858.597208-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Am 20.01.22 um 18:48 schrieb Alex Deucher:
> Older radeon boards (r2xx-r5xx) had secondary PCI functions
> which we solely there for supporting multi-head on OSs with
> special requirements.  Add them to the unsupported list
> as well so we don't attempt to bind to them.  The driver
> would fail to bind to them anyway, but this does so
> in a cleaner way that should not confuse the user.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 81 +++++++++++++++++++++++++
>   1 file changed, 81 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1527decd7e30..75ceb43392b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1499,6 +1499,87 @@ static const u16 amdgpu_unsupported_pciidlist[] = {
>   	0x99A0,
>   	0x99A2,
>   	0x99A4,
> +	/* radeon secondary ids */
> +	0x3171,
> +	0x3e70,
> +	0x4164,
> +	0x4165,
> +	0x4166,
> +	0x4168,
> +	0x4170,
> +	0x4171,
> +	0x4172,
> +	0x4173,
> +	0x496e,
> +	0x4a69,
> +	0x4a6a,
> +	0x4a6b,
> +	0x4a70,
> +	0x4a74,
> +	0x4b69,
> +	0x4b6b,
> +	0x4b6c,
> +	0x4c6e,
> +	0x4e64,
> +	0x4e65,
> +	0x4e66,
> +	0x4e67,
> +	0x4e68,
> +	0x4e69,
> +	0x4e6a,
> +	0x4e71,
> +	0x4f73,
> +	0x5569,
> +	0x556b,
> +	0x556d,
> +	0x556f,
> +	0x5571,
> +	0x5854,
> +	0x5874,
> +	0x5940,
> +	0x5941,
> +	0x5b72,
> +	0x5b73,
> +	0x5b74,
> +	0x5b75,
> +	0x5d44,
> +	0x5d45,
> +	0x5d6d,
> +	0x5d6f,
> +	0x5d72,
> +	0x5d77,
> +	0x5e6b,
> +	0x5e6d,
> +	0x7120,
> +	0x7124,
> +	0x7129,
> +	0x712e,
> +	0x712f,
> +	0x7162,
> +	0x7163,
> +	0x7166,
> +	0x7167,
> +	0x7172,
> +	0x7173,
> +	0x71a0,
> +	0x71a1,
> +	0x71a3,
> +	0x71a7,
> +	0x71bb,
> +	0x71e0,
> +	0x71e1,
> +	0x71e2,
> +	0x71e6,
> +	0x71e7,
> +	0x71f2,
> +	0x7269,
> +	0x726b,
> +	0x726e,
> +	0x72a0,
> +	0x72a8,
> +	0x72b1,
> +	0x72b3,
> +	0x793f,
>   };
>   
>   static const struct pci_device_id pciidlist[] = {

