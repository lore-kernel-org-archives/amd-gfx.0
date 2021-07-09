Return-Path: <SRS0=keof=MB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18B6C07E99
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jul 2021 06:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0BA4613B4
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jul 2021 06:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BA4613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5625C6E99B;
	Fri,  9 Jul 2021 06:38:52 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32AD36E99B;
 Fri,  9 Jul 2021 06:38:51 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id g10so5627154wmh.2;
 Thu, 08 Jul 2021 23:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=6oJNU0xb5DUgaaUndN/9RTu/2E6ORIX8Y40THs1iUoA=;
 b=jCptGc79RC4BBR3t+Wp556DxYa+1lmiE50SFzgA5e/LygTSRfOzuXugSQXUk8atzRH
 Tg+vOg4A+sgctFXWWv7lOg5EV1/CVl4+58Tqgmz00KHxE4LUjbN18kunpH7tX10LIUOv
 OYVQrdsfW6wHIehduCQ3HMI2rjrXM269BJZdpyLGrCFhRBuoHJvuFL2Hn9kXMi4t12WI
 a5bIAuhPpKmXVrq5EN4IpNkCnlnhv36rueWAmu8D8kYof8Mx4rPXdHyjQgmXQUzax0PE
 GLXAKO4dYMZmjjimDpKfaA0XrVM6P7DvddlONKz8YpM1UTSmyGDYe+MdGy/H+WeGDS3h
 r9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=6oJNU0xb5DUgaaUndN/9RTu/2E6ORIX8Y40THs1iUoA=;
 b=AupjnV9e5ug52ze3XnhGnYC2kMtMjpRZ7DYrEwFkJw0NlJ3dyAtFkJmSsUPQrpqeqb
 qPW3HdiDRqqjVM41+SZ5rDrmDYr8eRmxcbUMATb1rj/Pg5yL9zFvkGaSvo7acwsrZ8Oc
 KBQAv3hJ4rGyLPDrbIILXVn8n5wZMgYJF8xd8KtDBbwkgJ4mEhAEw6hz2eGoBAHA7IQ5
 OYBOT4Lg0R04Wc2V24h9MD4qxO5CY6aQfWOsiIKjx3lDm+x/SBJPt/r0SmG3URl+bWhM
 ZK0rKotpQNVXICiN9hP++/c6DZyXddy9s+UxXYuWwLeAarkDq9+kmXKQimPfZk2pOH0z
 7Irg==
X-Gm-Message-State: AOAM530uu6Z8XgVftcxyuct247qYJBJuZnff/CeW+fQ+TI56xjOI4RrY
 ZKRwMUESYU2Z1qTUTCK2bto=
X-Google-Smtp-Source: ABdhPJyEXohFVOVJuGo7CS0CyZ0gP9Lyzv2JvtjhCvQxdtxSOQYd9ndzeKxoknAdPp2LLylVMgC88g==
X-Received: by 2002:a05:600c:4109:: with SMTP id
 j9mr37640671wmi.180.1625812729785; 
 Thu, 08 Jul 2021 23:38:49 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:3da0:55de:64af:96f9?
 ([2a02:908:1252:fb60:3da0:55de:64af:96f9])
 by smtp.gmail.com with ESMTPSA id j17sm10878159wmi.41.2021.07.08.23.38.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jul 2021 23:38:49 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/ttm: Fix COW check
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20210708193621.2198733-1-alexander.deucher@amd.com>
 <20210708193621.2198733-2-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a25f93e7-8c03-542c-f594-64a7c1fba292@gmail.com>
Date: Fri, 9 Jul 2021 08:38:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210708193621.2198733-2-alexander.deucher@amd.com>
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 08.07.21 um 21:36 schrieb Alex Deucher:
> From: Felix Kuehling <Felix.Kuehling@amd.com>
>
> KFD Thunk maps invisible VRAM BOs with PROT_NONE, MAP_PRIVATE.
> is_cow_mapping returns true for these mappings. Add a check for
> vm_flags & VM_WRITE to avoid mmap failures on private read-only or
> PROT_NONE mappings.

I'm pretty sure that this is not working as expected.

>
> Fixes: f91142c62161 ("drm/ttm: nuke VM_MIXEDMAP on BO mappings v3")
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
> drivers/gpu/drm/ttm/ttm_bo_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index f56be5bc0861..a75e90c7d4aa 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -552,7 +552,7 @@ static const struct vm_operations_struct ttm_bo_vm_ops = {
>   int ttm_bo_mmap_obj(struct vm_area_struct *vma, struct ttm_buffer_object *bo)
>   {
>   	/* Enforce no COW since would have really strange behavior with it. */
> -	if (is_cow_mapping(vma->vm_flags))
> +	if (is_cow_mapping(vma->vm_flags) && (vma->vm_flags & VM_WRITE))

is_cow_mapping() already checks for VM_MAYWRITE, so this here shouldn't 
be necessary.

Christian.

>   		return -EINVAL;
>   
>   	ttm_bo_get(bo);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
