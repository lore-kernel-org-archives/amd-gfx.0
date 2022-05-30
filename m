Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927EAC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 07:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EA6410E730;
	Mon, 30 May 2022 07:12:26 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A58F010E730
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 07:12:24 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id rs12so18901704ejb.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 00:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=i7o3cVcuo/DlwI7DFcH05t7orkf60O6tOFFCXPu1cIE=;
 b=fsSmK7/zMX9vbnBSb6VD5TL771D6Fe+nv3xgHaud2hfWtOSLSVt2ha4dgypWLdxAFs
 8jZOIncMNLw0FoFlo8B9m1exC6HG6j5atbum1h13OyE8PIzslU8FkYwN9xCCKp5ojIzn
 pkCUb1f+wKotLdFiCUDpSa4+Gl5FCnLzDDN2ski7yNbAvkdN0KXnryLwRWNsw0HrQJ6c
 FTydflMUiAILmWra2883JL/MWdwuTHkrfh4a4HU94Yr3hZEwkmK1/n1ttsJMh+PTF67k
 cQvWpo5VK3au3E28RiXb3ZHVvFZ5xX1D6Utj1YXHe3FqckK57Hb0TEFABkhuNnr2I8+i
 yj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=i7o3cVcuo/DlwI7DFcH05t7orkf60O6tOFFCXPu1cIE=;
 b=pDTeKi6WUwBoratpkDMIHW6aFyXXaMsQCegDGgE4cZaCnZQp1o3BdOFfMYN1Ga23/5
 HF94FUi/5tf9V/5NNuOu40gEH4arryj/dKkd/sgMa/FGcQLVSkp6R3KbzWqyi4ThWDW0
 U/7/9uqLqQcZZv/sRFHl9RJMRT7GAI0CwG//WQfGOW8NMJFfF9JNxPOkbQiBBQxsqLs3
 WBupAOAQNF9JwuP9HxAxdq+HvjSAm9lkP5XaM9S73FjYcTmuGTubnueuigfm4Wueg/Af
 OxbvgGnioh2hoZ6VuXYHJuD5XA0bkGo+cTFiobu4JbIKNOYjJwvDOIG6xqVV5mFmX/5Y
 tvpA==
X-Gm-Message-State: AOAM531XHxrNzk4Tb1x9SxGQMeiezbFdVGAK/iBL6ucmEpmXWYJUhSOs
 9n39EEDgWNfyxGWY8YwfYI0=
X-Google-Smtp-Source: ABdhPJznc1KZrDjT1o+Z7SNx9QlKG2GEB5moLeMc28SH1ukUK6V7KQ1niiYexGH4M4jK9ZCklVtHkg==
X-Received: by 2002:a17:906:9c82:b0:6e1:2c94:1616 with SMTP id
 fj2-20020a1709069c8200b006e12c941616mr47496440ejc.64.1653894742980; 
 Mon, 30 May 2022 00:12:22 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea17a.dip0.t-ipconnect.de.
 [91.14.161.122]) by smtp.gmail.com with ESMTPSA id
 k30-20020a508ade000000b0042dd3454512sm992263edk.63.2022.05.30.00.12.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 May 2022 00:12:22 -0700 (PDT)
Message-ID: <c1c58cbd-e8c5-1e0b-1de9-389b2bbc10be@gmail.com>
Date: Mon, 30 May 2022 09:12:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: suppress the compile warning about 64 bit type
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220530070657.678863-1-evan.quan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220530070657.678863-1-evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 30.05.22 um 09:06 schrieb Evan Quan:
> Suppress the compile warning below:
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:1292
> gfx_v11_0_rlc_backdoor_autoload_copy_ucode() warn: should '1 << id' be a 64 bit type?
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> Change-Id: If5f83daeb4039d87c5b47c221f9c963c941400e1
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index cb581cfc7464..9039021361a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1316,7 +1316,7 @@ static void gfx_v11_0_rlc_backdoor_autoload_copy_ucode(struct amdgpu_device *ade
>   		memset(ptr + toc_offset + fw_size, 0, toc_fw_size - fw_size);
>   
>   	if ((id != SOC21_FIRMWARE_ID_RS64_PFP) && (id != SOC21_FIRMWARE_ID_RS64_ME))
> -		*(uint64_t *)fw_autoload_mask |= 1 << id;
> +		*(uint64_t *)fw_autoload_mask |= 1ULL << id;
>   }
>   
>   static void gfx_v11_0_rlc_backdoor_autoload_copy_toc_ucode(struct amdgpu_device *adev,

