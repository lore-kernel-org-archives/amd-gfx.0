Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E28CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 07:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E161F10E43A;
	Thu,  5 May 2022 07:15:14 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09BF010E43A
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 07:15:14 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id t5so4135703edw.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 May 2022 00:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=qVtTl4kbvqMcBHCEHoRg72JCBufRW3uKKnPGG1+vceE=;
 b=Q0L2EiXPNlnohLyQG9CCgWYrdoKQJt6Ic2YHCBbX7sdHpffwo1VODwHUpJAvy5KjNi
 PAF7VrpyiFQvyFJFohBrWd/y/0EcXSa/CYl1dj/ikwPXaeRLTGiS1wIPNXxZsqFiK/5N
 E6gdb/4YbY/8WnO/+2EriOe6BEzNDBy5Ns8IFUjuzkKrZ30Gyuq5thw0zGW4qDj31y91
 wUU2USmDmjQGGr76zTST0DXRVbDIgVcskUoCHpdO6A9tiezxG/WnCyTqjWv4NNVWuh/N
 XuRDBTJn8GENu8c0KMsATTMdkxSj/GU0O4hEDr08N4neD7QUnVsYBZuhtnKDMJkRTjiS
 f3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=qVtTl4kbvqMcBHCEHoRg72JCBufRW3uKKnPGG1+vceE=;
 b=Bhp6AeraAWq7RBH0qaCl8ifKNOPp9FcYjXoasHrov58UbC6aqaWXUmOUzk+h2O77Bo
 SdnPMkahpSD/0GggQovLnFEbb4FjemiMtd51gHPe3OFn/HnzHZ+ez+gDgvtiFTNB5uu/
 15e4QqzL5iu9q3uRlfW4H8aua896W9fV+SFK5B5AwVXYcIZkx0wQJx/tU24y0rEnjgNz
 gcYDVJAmJd5zSRA67bLAQqSinBby/X6XnsKpxZm2gwa6XbOG6rYb29SIMzl+nQ8Y7ITi
 Z1bAozeID0gWQdlm51i45C7EUMmrnccOyqAHdh9o5hLZzU09twuc23NAWCiBs8XAVosG
 0Rsw==
X-Gm-Message-State: AOAM532KbFhRnHxOGXpYZsMdbsEX/b+sNlx6tc0l7MPo9yolUryuOkMz
 y+/mpcgsWOUmOOziHXp2kXw=
X-Google-Smtp-Source: ABdhPJyDDV6VpWjRhjIKR8UY0xNViSVqKWuHos0fTiDe3hfZTC3vvyTk4uQrjE/bCv7dxB01vo9HRQ==
X-Received: by 2002:a05:6402:50a:b0:426:16c3:4283 with SMTP id
 m10-20020a056402050a00b0042616c34283mr28236430edv.371.1651734912463; 
 Thu, 05 May 2022 00:15:12 -0700 (PDT)
Received: from [192.168.178.21] (p57b0b7c9.dip0.t-ipconnect.de.
 [87.176.183.201]) by smtp.gmail.com with ESMTPSA id
 u17-20020a170906781100b006f3ef214dacsm436630ejm.18.2022.05.05.00.15.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 May 2022 00:15:11 -0700 (PDT)
Message-ID: <b2a7e552-2032-8e16-a88e-0eda9bab167a@gmail.com>
Date: Thu, 5 May 2022 09:15:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: simplify nv and soc21 read_register functions
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220505025831.403497-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220505025831.403497-1-alexander.deucher@amd.com>
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

Am 05.05.22 um 04:58 schrieb Alex Deucher:
> Check of the base offset for the IP exists rather than
> explicitly checking for how many instances of a particular
> IP there are.  This is what soc15.c already does.  Expand
> this to nv.c and soc21.c.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

I still think the higher level code should not read registers which 
aren't present in the first place. Could we add a WARN_ONCE() here maybe?

On the other hand I totally see why it is a good idea to not try to 
access something which isn't present. So Acked-by: Christian König 
<christian.koenig@amd.com> for now.

> ---
>   drivers/gpu/drm/amd/amdgpu/nv.c    | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/soc21.c | 5 +++--
>   2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 8ecfd66c4cee..d016e3c3e221 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -392,9 +392,9 @@ static int nv_read_register(struct amdgpu_device *adev, u32 se_num,
>   	*value = 0;
>   	for (i = 0; i < ARRAY_SIZE(nv_allowed_read_registers); i++) {
>   		en = &nv_allowed_read_registers[i];
> -		if ((i == 7 && (adev->sdma.num_instances == 1)) || /* some asics don't have SDMA1 */
> -		    reg_offset !=
> -		    (adev->reg_offset[en->hwip][en->inst][en->seg] + en->reg_offset))
> +		if (adev->reg_offset[en->hwip][en->inst] &&
> +		    reg_offset != (adev->reg_offset[en->hwip][en->inst][en->seg]
> +				   + en->reg_offset))
>   			continue;
>   
>   		*value = nv_get_register_value(adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 9e689a1f2ea4..2f23cb8cd6e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -252,8 +252,9 @@ static int soc21_read_register(struct amdgpu_device *adev, u32 se_num,
>   	*value = 0;
>   	for (i = 0; i < ARRAY_SIZE(soc21_allowed_read_registers); i++) {
>   		en = &soc21_allowed_read_registers[i];
> -		if (reg_offset !=
> -		    (adev->reg_offset[en->hwip][en->inst][en->seg] + en->reg_offset))
> +		if (adev->reg_offset[en->hwip][en->inst] &&
> +		    reg_offset != (adev->reg_offset[en->hwip][en->inst][en->seg]
> +				   + en->reg_offset))
>   			continue;
>   
>   		*value = soc21_get_register_value(adev,

