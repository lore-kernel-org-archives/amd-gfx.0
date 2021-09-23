Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101FDC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 08:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF6061152
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 08:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CCF6061152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FB436E0E7;
	Thu, 23 Sep 2021 08:50:28 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B74C26E0E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 08:50:27 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id w17so14868652wrv.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 01:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=N5Z7ncvRx/oFI2vw9KL/AIgChANeo8j+W7x0UNkj+FE=;
 b=pVlRmxf8laHmhRDNYn5wx8O0Ad3hL6uq5YMqXPDo3qQC/vAhf27OM0VX6Zjif83DJd
 kcwxc/FvBMkPGKB4Npcx2MPDYQmGAYFkGt9S03T8gQDrtImiH0/g9DfM5+WwUvXsizAE
 ZQesRebP9eAGNMn8yBYRURvhU21fZi1NGDElOTTFxoHjlFuio644v17+FtyxZya71Kqi
 RM/HWFZ/MSVvBVVR+sIo2wNuogr92F5ukuPHMQiTkavjkFE8IebOvL9EhvSDqz7P9oNu
 XbeXbFB0JlAWGkzfJMBUFY71yeFpVqZAU+ehk6DQqds9ey02U24ULBGJCeFR8saeSm4i
 zXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=N5Z7ncvRx/oFI2vw9KL/AIgChANeo8j+W7x0UNkj+FE=;
 b=33F1IG4cOCH3KAnVDbXYsOTZRwKpScBMxz2eL8bVxtngnA8rVoSb/nquKxCmidTlQc
 kWDGGXnQBHq6xp0yhsjKlTwBtRjOeUw7MZtkQQbGe62gkyosRD1Z1lhcK9OApyfZHMBS
 Ohayd9yxcgMORtyhLv6NukPPCIn69GDEHXsVgBUeQXiD/8wHPB0a7IYZ5nd3KSQ+ix8i
 yWYe1gOUHzbgUj2k9nCCxE9kQRfCwJAJE006biXlVOSqoUyU0+qWK7GQGCeWJwt1wKKw
 Lh6hy0hWJuUGprtmS2yw12p1jmP74WmqU2C1P/Q9UiWpjNEP+IGEjXdBVpnNYEFRPPp3
 PNSQ==
X-Gm-Message-State: AOAM533FMJLnfqfOm42+qXvDiS4To5bAYwFA4Q5wnTKWbGTGIiknGcsU
 4OnE4zLnUxS84Kt7V4nSiRU=
X-Google-Smtp-Source: ABdhPJztRVbzFbv2qADYXq8hBHE31lPqyLVbWwsGcZBN42HuVIz2y8q5J7udW8vhp0ho+nCzEULYOw==
X-Received: by 2002:a05:6000:1284:: with SMTP id
 f4mr3776361wrx.88.1632387026264; 
 Thu, 23 Sep 2021 01:50:26 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id j19sm4590328wra.92.2021.09.23.01.49.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Sep 2021 01:49:57 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix gart.bo pin_count leak
To: Leslie Shi <Yuliang.Shi@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com
Cc: guchun.chen@amd.com
References: <20210923081618.74243-1-Yuliang.Shi@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <84d319a1-4e15-5cb7-d5f9-b0010bfc17a2@gmail.com>
Date: Thu, 23 Sep 2021 10:49:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923081618.74243-1-Yuliang.Shi@amd.com>
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

Am 23.09.21 um 10:16 schrieb Leslie Shi:
> gmc_v{9,10}_0_gart_disable() isn't called matched with
> correspoding gart_enbale function in SRIOV case. This will
> lead to gart.bo pin_count leak on driver unload.
>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 41c3a0d70b7c..e47104a1f559 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1098,6 +1098,8 @@ static int gmc_v10_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	gmc_v10_0_gart_disable(adev);
> +
>   	if (amdgpu_sriov_vf(adev)) {
>   		/* full access mode, so don't touch any GMC register */
>   		DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
> @@ -1106,7 +1108,6 @@ static int gmc_v10_0_hw_fini(void *handle)
>   
>   	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
>   	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
> -	gmc_v10_0_gart_disable(adev);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index d90c16a6b2b8..5551359d5dfd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1794,6 +1794,8 @@ static int gmc_v9_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	gmc_v9_0_gart_disable(adev);
> +
>   	if (amdgpu_sriov_vf(adev)) {
>   		/* full access mode, so don't touch any GMC register */
>   		DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
> @@ -1802,7 +1804,6 @@ static int gmc_v9_0_hw_fini(void *handle)
>   
>   	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
>   	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
> -	gmc_v9_0_gart_disable(adev);
>   
>   	return 0;
>   }

