Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FA3C433EF
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Apr 2022 15:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31AAC10EDA6;
	Sun,  3 Apr 2022 15:26:24 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDF9E10EDA5
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Apr 2022 15:26:23 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id i27so8056977ejd.9
 for <amd-gfx@lists.freedesktop.org>; Sun, 03 Apr 2022 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=kKwjfEUde3iLucQD1GKq1QvBRHt4LfRgS3gKzv+YR0c=;
 b=iXWMj4Hm/9zCPWw8p8PIxeh6WzajYv+NIuh+nceBELTxxqqwzA4+Rpnf6vy00ij2s1
 1QHpbo5WWym491f02Q6Q0FD7viSwjtkDM8ZnjUEP1LNJC2TEtlkDSf5+Zw0k/D5HMNKp
 /+qU6rgy/BLdbAl+qpH7eArxEFp/ah29C1Gq1PVU2hFELxlt23qqMmWSzN7DojhBNeHp
 GbeRfOHeaRcfSwQP5/SOmE0EfezoSsiXzH4YoF7u73SuNwUY/9shoLrS9jbb460p96yr
 bW1ET4Bu3ZJlz0uQLu5hNCIskSZ7JN+Vr6GLLB3DH3xbHpjsTJgnOK/1haT1ve/hVQHo
 NNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=kKwjfEUde3iLucQD1GKq1QvBRHt4LfRgS3gKzv+YR0c=;
 b=htm/7LgdsV4w+XpgHNtD6Ip5ye7hfRnyYW5hH0HnpSKpT4nOjGAjUXG9SUjw2DTt0r
 ntxVKuGiyhOUMtNBGvVTsl1dmnI9vYqDqCIqUP7XFjNq67TkxITGjzpf1vwqwmAMDV5D
 QA3iBew40Z1TSbngyWX7z03thd3NDK92mBKz95A9Lgeid/S//u+elcVgWR38RA1u4fcc
 OHLSMv1aNYJ9VdSpAxt0bPKE5e8pecAqz13l+GS++yT4AW89j6eUEZbo1hc6nuOM6Xz6
 puJ9OvpZVlwn88hEEk/myTi3CbqI/HGVUp4ahEaZvGA/fQu1hP6a+d9OU8PPFCUJyA1F
 3sjQ==
X-Gm-Message-State: AOAM531jSrXyiS47ZdOOcAe7b2dTBTNGJgd8cmj3H3+7rMR4UKqGYg9I
 dIbyRL7FNrlxawNVPbIDN+4=
X-Google-Smtp-Source: ABdhPJxTFgdmaIg+4ghVBnJt4IiJMtTNQlsNBHVTk6KoAiIzAyKNoVVROaWWf1R8HuK3HhCQD20gYg==
X-Received: by 2002:a17:906:5d0e:b0:6e0:2cd5:a87c with SMTP id
 g14-20020a1709065d0e00b006e02cd5a87cmr7452394ejt.708.1648999581351; 
 Sun, 03 Apr 2022 08:26:21 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:98c:f6c6:4bdf:b9bc?
 ([2a02:908:1252:fb60:98c:f6c6:4bdf:b9bc])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a170906d18500b006ce371f09d4sm3299832ejz.57.2022.04.03.08.26.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Apr 2022 08:26:20 -0700 (PDT)
Message-ID: <40b0f54b-6b1b-41f1-b2ce-84bea8c87e02@gmail.com>
Date: Sun, 3 Apr 2022 17:26:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] drm/amdgpu: Flush TLB after mapping for VG20+XGMI
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220401195726.21436-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220401195726.21436-1-Philip.Yang@amd.com>
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
Cc: felix.kuehling@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.04.22 um 21:57 schrieb Philip Yang:
> For VG20 + XGMI bridge, all mappings PTEs cache in TC, this may have
> stall invalid PTEs in TC because one cache line has 8 pages. Need always
> flush_tlb after updating mapping.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

You could drop the extra (), but either way Reviewed-by: Christian König 
<christian.koenig@amd.com>.

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

