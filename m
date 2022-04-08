Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FABC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 08:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CE9A10F10C;
	Fri,  8 Apr 2022 08:48:06 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F3D610F10C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 08:48:05 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id l26so15959723ejx.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Apr 2022 01:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=lOT6c7NS8PLGQ1EPPxj4v4NHqvy3jzZpe1D/BWrPGhY=;
 b=UbuMSuM9JHTho8uG6+zri7viZJHMR3TFVCPBLwOfNa4A75dEdDfK5/s1pppb5ipmo9
 mwRXkCADN6JSKatLLtKUW/GZfj6/jixLx9DK/pJRyW/1MvQDP39Yb1SzZXNU+wzXaI5d
 fQZb1aWCgRiQ1chs5+6IkEZ0DziAbOOOay6kP0TEbK/1CfYe/NRGw/v7rhfZzfPUf8ax
 RCkjasOj0s/s22uNQSvqHhs1aRQOg1lANV4AXiQBUWofawgmuO6Bv5I70hvFI2VaVI+x
 RAR04OeU3r2SEdJgHd8GsNm8yE33YgXyQR+yEhFJi5CQtz6WiECNIH9VSXlvbrWCrhVQ
 prGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=lOT6c7NS8PLGQ1EPPxj4v4NHqvy3jzZpe1D/BWrPGhY=;
 b=iN9JmApbA4Du7YAOE+EmGtK1NYRLfiwVI+KTG3cXgCypalsChKPVvN7bfMaAh5bN+L
 kxbwdWCIrE6qiQJhj/AlRCnFBS0GZ+gZGYby7QZ5edlf0lg0Z3DMtMB5vikkvevmfSBG
 cdStZ6hFihGeJNcXyyWx4B09TT40TIHwwCYaf1ygrS/KwySIBvPR2l//0lBOJQh+sL3D
 o8ErxLN/4pZwNF0xfEZLqZCOckp25jWIh0XVdgkN7Kuf9zxow76HdJweeclqvaUSXjyu
 djiMs/BKICk0ObZ3WbavTpyITzbjBDoMidsv+ZEC2EntRCsSGogEoeAI7HgZ+Zxlvlzx
 qLTw==
X-Gm-Message-State: AOAM531Alb8OcoiEEzXza7pBku/iGY5/oQ8/nuyWyJ4rMwcpkDfqm/rD
 4OgACeUSuXPnoDJ4DZzDgcU=
X-Google-Smtp-Source: ABdhPJwApJtvq49cKI+FS7LfiWy87uHMiNDhoXAjpH7L5kW0ZHCg1s5vvKZfS7zDjZ5kZ/g/9nlQPg==
X-Received: by 2002:a17:907:6095:b0:6e7:cc3f:c33d with SMTP id
 ht21-20020a170907609500b006e7cc3fc33dmr10836887ejc.570.1649407683752; 
 Fri, 08 Apr 2022 01:48:03 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:114:5e2d:4d2d:2c8b?
 ([2a02:908:1252:fb60:114:5e2d:4d2d:2c8b])
 by smtp.gmail.com with ESMTPSA id
 i3-20020a1709067a4300b006dd879b4680sm8623996ejo.112.2022.04.08.01.48.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Apr 2022 01:48:03 -0700 (PDT)
Message-ID: <738c142c-2344-44f9-2e69-ca843f184377@gmail.com>
Date: Fri, 8 Apr 2022 10:48:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: Use flexible array member
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220408040224.125878-1-lijo.lazar@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220408040224.125878-1-lijo.lazar@amd.com>
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 08.04.22 um 06:02 schrieb Lijo Lazar:
> Use flexible array member in ip discovery struct as recommended[1].
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
>   drivers/gpu/drm/amd/include/discovery.h       | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 5a182288391b..b577fa1d7ecc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -430,7 +430,7 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
>                                   }
>                           }
>   next_ip:
> -			ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
> +			ip_offset += sizeof(*ip) + sizeof(uint32_t) * (ip->num_base_address);

Please use the struct_size() macro for this, apart from that looks good 
to me.

Thanks,
Christian.

>   		}
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
> index a486769b66c6..b25026c3ec96 100644
> --- a/drivers/gpu/drm/amd/include/discovery.h
> +++ b/drivers/gpu/drm/amd/include/discovery.h
> @@ -93,7 +93,7 @@ typedef struct ip
>   	uint8_t harvest : 4;      /* Harvest */
>   	uint8_t reserved : 4;     /* Placeholder field */
>   #endif
> -	uint32_t base_address[1]; /* variable number of Addresses */
> +	uint32_t base_address[]; /* variable number of Addresses */
>   } ip;
>   
>   typedef struct die_header

