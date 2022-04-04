Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC952C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Apr 2022 19:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 671B010E063;
	Mon,  4 Apr 2022 19:03:40 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F81B10E063
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Apr 2022 19:03:39 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id z12so19063802lfu.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Apr 2022 12:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=HRJ5W149hMRsABP9TfIolDp7s5DbqNwbuWUr/B1NB0Q=;
 b=DriORmwPTVLWtmCftHSp+vuqvGv9aAjdXl/xf8NzjpKe6y0Fr6TaAhoJx4w+xUoMuA
 kyum5wFJm1nwFZNeSTsYFCZYWkOeOcBf0xXAr2RaMwLW89IjdrEmzvK8/P7oA6gb8fdG
 cM5c0aV1ALZVHzjrTIuNJ4OEBtZUCPM+qpgPGidcP9Z9PSDwkYpT55r7r21TvmMx+5Ls
 Q9sROCqTLrZyO2nNG/xEMZZpQe51daQWZ/3+gG80ep1YaKohw4rqofh7bEDgQM7Da+ry
 JoJvCMPoMurFzAYxsv7mGKR/KJLuEwkbGST3f5omTAwi+wM4rsRAUV+LyA5bOrNUExBS
 5gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=HRJ5W149hMRsABP9TfIolDp7s5DbqNwbuWUr/B1NB0Q=;
 b=lljjHMuSF/L3FEwj09eg7DK0BmMHSqfMS8O99SYgbCyUPXSmGbAEZMNReqL7mvX/tU
 Mbp4yG5S8F0SrpiONFXn1eAO8GTYEE593SBNfILFQWj47i45By0O1Kle4qJvC2NvB4gi
 wwPEQdYIthIDh/BLatUWknubVhF31gAMJQNYAOXmXmKClE2gTe2j0l429P2Ec6NBeOTQ
 Dp2JpenpSrqsr48VFMQ/Cnt3zb5v0IYTP2eZc7fFzS18zz/zlGFyqTvViJV3u97Mk/Ij
 /ZHREVchCCcp7Lgx+3H7MUZVfaengQDqiBzqieth2etBFAOZqnOpv19t5oNpHTCWckSI
 /VaQ==
X-Gm-Message-State: AOAM530uVKQKG90KE6S0FDX7qdKJ8czbkI+e+UjPzu/r6sXs5yUoIrfD
 zXh0vsO3qADWy17ShpbDncU=
X-Google-Smtp-Source: ABdhPJxc1/KNufCG0ecOjleXf014e5aYrhXf6icO9/BtpDyiTmgqSuq466i+m3Bdiu4196U8pq7nzg==
X-Received: by 2002:a05:6512:104a:b0:44a:5bae:d80d with SMTP id
 c10-20020a056512104a00b0044a5baed80dmr625596lfb.390.1649099017203; 
 Mon, 04 Apr 2022 12:03:37 -0700 (PDT)
Received: from [172.16.41.128] (078088109026.wroclaw.vectranet.pl.
 [78.88.109.26]) by smtp.gmail.com with ESMTPSA id
 e3-20020a196743000000b0044311216c42sm1231285lfj.307.2022.04.04.12.03.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Apr 2022 12:03:36 -0700 (PDT)
Message-ID: <3fce21b7-f1a0-28db-5322-6eb89a10fe8d@gmail.com>
Date: Mon, 4 Apr 2022 21:03:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] drm/amdgpu: Flush TLB after mapping for VG20+XGMI
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220401195726.21436-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Tomasz_Mo=c5=84?= <desowin@gmail.com>
In-Reply-To: <20220401195726.21436-1-Philip.Yang@amd.com>
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
Cc: felix.kuehling@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 4/1/22 21:57, Philip Yang wrote:
> For VG20 + XGMI bridge, all mappings PTEs cache in TC, this may have
> stall invalid PTEs in TC because one cache line has 8 pages. Need always
> flush_tlb after updating mapping.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index f0aec04111a3..687c9a140645 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -837,6 +837,12 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		goto error_unlock;
>   	}
>   
> +	/* Vega20+XGMI where PTEs get inadvertently cached in L2 texture cache,
> +	 * heavy-weight flush TLB unconditionally.
> +	 */
> +	flush_tlb |= (adev->gmc.xgmi.num_physical_nodes &&
> +		      adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0));
> +
>   	memset(&params, 0, sizeof(params));
>   	params.adev = adev;
>   	params.vm = vm;

On top of what commit does this work?

It does not apply at top of v5.18-rc1.

It does apply, but fails to compile, on top of "drm/amdkfd: Create file 
descriptor after client is added to smi_clients list" that is commit:
   * cbe879c87245ce6272afe6456dbc8ce2c8f38d64 in amd-staging-drm-next
   * e45422695c196dbc665a95526c85ff4b8752aff2 in drm-next
fetched from https://gitlab.freedesktop.org/agd5f/linux.git

The compile error is due to flush_tlb being undeclared.

Best Regards,
Tomasz Mon
