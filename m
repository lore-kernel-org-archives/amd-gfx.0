Return-Path: <SRS0=mrdw=6P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AA8C4724C
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2020 14:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2212220708
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2020 14:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1ZW5CyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2212220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C96FD6ECBC;
	Fri,  1 May 2020 14:30:01 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAFDA6ECBC
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2020 14:30:00 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id r26so6504514wmh.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 May 2020 07:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=fC4GrKIPCnJOw/0tjE7KglKxJ+lYU4/PCTC47yKzQ04=;
 b=m1ZW5CyG+W2t3IVyJmff8X45OOE/7r8MYjaloyOxHBeTP9AABN5pYuein9Zz3TD7Ak
 v6p9qrgcryUSdELLHUGnzd1K6knpOQkonfml+/MOmJsug1ycC+zml6c3qkCJJvWKBrwj
 xTZ7DoV/wX0AVJ2yg6BJzUJo0DzX3xhvsNFrOPm3ZzGim1LuRqawxuSqKOFJT2f47jNd
 AKBenHdECoKt+/ll/Pxn2t+3DUWIbsEZj60b45tpoW4S2CCwm7T3BXFsCdIJsollfCs6
 dy4tzSVIunFV4Dy6uF+siLlWLrr6l59M0fQVSHRIZlUuPE5m9ZnHfjBCqXtE5hr2KNA1
 dQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=fC4GrKIPCnJOw/0tjE7KglKxJ+lYU4/PCTC47yKzQ04=;
 b=PiAdAtmThm5Hoqet88yUMWef39gOFyeEPG97jP7E/V4oy4mOvqbHytM6cLT8LsxyNG
 s2ElzOOzFg44GonJz1EQhm6npSlF7zYVsrKE7OhIXMmayR8NzeLO2QGAOgvLB7fiXq9O
 Fp0OUhWIRR3uKhAfw5CFRQrITL8SgXJ3q38LwfmEw3QyMmmVsrJYVt6lT5W5NdnS2Xnt
 DLeJLqMHFjL8eLGqzVuV8V+xBr5lRc7y1vkfU8Wq1FdH0AdrDloJxXvxkJx4D1nBuRwg
 9w38L5ueCWJZ7Ez2cdZ8m5a09YgRlj6c+mVUfsvrfw1CZo51C038cavIkxmU+qWpnpIV
 yNrg==
X-Gm-Message-State: AGi0PuYBjy6jDTGDHOWn1P74k/ZPiCEQWsSTix351Ds9ykuAhTYxAnkb
 5TPDcM9HV0Xw/zXUtB2f0iI=
X-Google-Smtp-Source: APiQypJecJnz1Q6BeAlXVAG+Rdt9tDu7sxLXqDooGbgnjcCaFFBNsKhunF4sQmMXWh8AFG7qasnVdA==
X-Received: by 2002:a1c:ded4:: with SMTP id v203mr4288183wmg.106.1588343399436; 
 Fri, 01 May 2020 07:29:59 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 138sm4457546wmb.14.2020.05.01.07.29.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 May 2020 07:29:59 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: Take a reference to an exported BO
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200501142127.14202-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <70e5d202-34ed-532f-e6b6-c195a3effad3@gmail.com>
Date: Fri, 1 May 2020 16:29:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200501142127.14202-1-Felix.Kuehling@amd.com>
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
Reply-To: christian.koenig@amd.com
Cc: Felix Kuehling <felix.kuehling@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.05.20 um 16:21 schrieb Felix Kuehling:
> From: Felix Kuehling <felix.kuehling@gmail.com>
>
> That reference gets dropped when the the dma-buf is freed. Not incrementing
> the refcount can lead to use-after-free errors.
>
> Signed-off-by: Felix Kuehling <felix.kuehling@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index ffeb20f11c07..a0f9b3ef4aad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -398,8 +398,15 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
>   		return ERR_PTR(-EPERM);
>   
>   	buf = drm_gem_prime_export(gobj, flags);
> -	if (!IS_ERR(buf))
> +	if (!IS_ERR(buf)) {
>   		buf->ops = &amdgpu_dmabuf_ops;
> +		/* GEM needs a reference to the underlying object
> +		 * that gets dropped when the dma-buf is released,
> +		 * through the amdgpu_gem_object_free callback
> +		 * from drm_gem_object_put_unlocked.
> +		 */
> +		amdgpu_bo_ref(bo);
> +	}

Of hand that doesn't sounds correct to me. Why should the exported bo be 
closed through amdgpu_gem_object_free()?

Regards,
Christian.

>   
>   	return buf;
>   }

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
