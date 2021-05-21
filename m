Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB117C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 08:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819E761363
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 08:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819E761363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 240CB6F5D4;
	Fri, 21 May 2021 08:41:26 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD1E6F5D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 08:41:24 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id i13so22430364edb.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 01:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=OrpmVGDvWVJ895miPxXsPjIl7OWIXlUdyzVeUweAUwQ=;
 b=Uir7w2PA6VdXKqXX24FCe/K82BrkNse5YGYaQ3lnpyKpb61G3DUfKbSd8N+cQGrwnJ
 lmdSJrf8drVNRhsg4G17rJxhNAUeYit4AgK6EAI1tjaCigUDr86Wp6ExEBOU+8stDs8a
 5UfM0DnRx/wOLEF1ymuQSAds2Qe/Ws/vtoSdUfZgR0/u9LqNuwkqD7N7VdqRcf0v7FF3
 546BAaeQh5FlWjxLx+jZ+Fk5F1ACtk6retmsmrj7tI0cdH+oF+3m8XpJglQih9RAOHIg
 1UcpO34u/A0d2kbUxORapEShW/MS1pmakvrE6lh1rkYsSFZsExOQxXJGeB7DwcPGq6gL
 DyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=OrpmVGDvWVJ895miPxXsPjIl7OWIXlUdyzVeUweAUwQ=;
 b=JIhWumFWE5IGuQXXohLD6+x+Z3dKAdPgctRJC+9x3s2gWseFE3GalivoHyjDRED5Mw
 ulq8vmQ1E8rfcSVAFbk0GNbbQrciv0TTIlAXmtxHfiCuNkAG9eBdc11jK07ghXnfZa/x
 qeTt/twQf5n+Ql/iFcofhjsfbvSyxqJlOb9VLVcA0y6R4RhJwY21VpMOGdgBgOKf0obe
 Z1BqbW2MwYOGxrMqkXox/gRyLlsZftaWbo1YvEzmS0/ltvX3rFt78fslrfPxrmY91uaC
 7kCFR87RQlyKXyWeHpZB9QSTZ2UiGFsb8hN13+4fs59bQvKRzoPfnI7Sn+FWbZ3Gm+Uy
 RW+A==
X-Gm-Message-State: AOAM532voRAAv6HjmRJE6LPe0E6SDRGE0/ggXHylKILdJ1A+WY1uMq+L
 7gkKY1oMCVeuzCCgStS6kGZJEmI2n4c=
X-Google-Smtp-Source: ABdhPJwcMRDlhHLRQ/u0LGAe0OaLuj6AEuAAm5Y8C/UFsDjVR9Cq3ujfQ5emhSQKAWgoGdZ6iuOZtw==
X-Received: by 2002:a05:6402:3585:: with SMTP id
 y5mr7639671edc.121.1621586483606; 
 Fri, 21 May 2021 01:41:23 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:b48f:ff97:fb4c:5b1d?
 ([2a02:908:1252:fb60:b48f:ff97:fb4c:5b1d])
 by smtp.gmail.com with ESMTPSA id dh21sm3512193edb.28.2021.05.21.01.41.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 May 2021 01:41:23 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] drm/amdgpu: Workaround IOMMU driver bug
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210521022256.14184-1-Felix.Kuehling@amd.com>
 <20210521022256.14184-3-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b8803012-3642-4817-1ae4-e546b5605a47@gmail.com>
Date: Fri, 21 May 2021 10:41:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210521022256.14184-3-Felix.Kuehling@amd.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.05.21 um 04:22 schrieb Felix Kuehling:
> The intel IOMMU driver causes kernel oopses or internal errors flooding
> kernel log when mapping larger SG tables. Limiting the size of userptr BOs
> to 6GB seems to avoid this.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>

CC whoever is the maintainer of the Intel IOMMU driver?

Would be nice to have that bug fixed instead.

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 2b8b89535198..3becf9d9f8fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1409,6 +1409,9 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   		domain = alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
>   		alloc_flags = 0;
>   	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
> +		/* workaround IOMMU driver bug */
> +		if (size >= (6ULL << 30))
> +			return -ENOMEM;
>   		domain = AMDGPU_GEM_DOMAIN_GTT;
>   		alloc_domain = AMDGPU_GEM_DOMAIN_CPU;
>   		alloc_flags = AMDGPU_GEM_CREATE_PREEMPTIBLE;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
