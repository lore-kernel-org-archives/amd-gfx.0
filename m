Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8B7C54EBD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 11:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85E2A10E9EF;
	Fri, 13 Jan 2023 11:47:47 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E01E410E9EF
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 11:47:45 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id v10so29613606edi.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 03:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tmjVNRu0Uv624NAYwK4qMkCkisFs5Y4/7x0DBpnezbY=;
 b=ehSySWe7HObzgfZYc07oJDMVoNij5ZFa/crnC90SfcgCzrhBlDcvBOM3cwCU+kE3zJ
 gFFBKuPxGpZqiCaR+wvoaGRupJnwpaHdP+OVnZ8FXulMwLcjZqK4tLKyI00UX6XxDmD6
 8TdnC6ea9Oz477EUJpn/UTrcf8KcxW50XwTFxFa9z+pKVjJNSoJAkhsi832EP2v0G/ET
 f7UM81wwDq7HVfSMxU2EL3IB2trPu0F7rf1LTO8CAAOYn2udLOR+wrDjDjRmzGTAS2c2
 P4UN+Ir3FXVDXXPtFD2uqcsVl1bMfk6ETmuawGk14bKJsxgjcvTG8/0CbVkLOu8tw5zE
 HxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tmjVNRu0Uv624NAYwK4qMkCkisFs5Y4/7x0DBpnezbY=;
 b=Ast9LwiIrp6bs184DNee+Q0mI0dBeQg9sVljv3J+FQSZAhFB3K4/ACQvJDq8Pf+Zyx
 OBZYX1bUd7xhgkTDc4eloEwz7w1jDuRz0sIfkEu8lMtO6lgcAZGSlTkhhsePQLvdNwaO
 6aBba9BQ8Vn5N8VuBS2yZs/buZQ/AwhQLPufavxIoGYKE5X0yRcq/yRTd2l602nfcPPT
 x6wAPTl907UrAE5vkzTPZuhJrdKSWgnMM/kJST0mYmvIPULteZmj/HLiodeEUbYDWdOh
 KJqfs+gddmY5V9TMRqSYclZxK6ffoflNGyRQy33ZYUzHZzq+ABFHHdIooSS/eHG6BNGe
 Gf8Q==
X-Gm-Message-State: AFqh2kpOClib9B9KugU/rpJ1pXVTu1QLWb0eVJTInKoeb+7mU6NFBL8d
 u/oduHsE2uuVN2LdbleGJ2M=
X-Google-Smtp-Source: AMrXdXtEd4v4Zt4hgrkVSiDGTzJyUpb0w2Pgql3RcHE+PiggE6kzcj5y+Hxn7FpEkF6KQ1s+IsaJWQ==
X-Received: by 2002:a05:6402:448f:b0:498:1f8:5378 with SMTP id
 er15-20020a056402448f00b0049801f85378mr21715011edb.16.1673610464390; 
 Fri, 13 Jan 2023 03:47:44 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:a701:87ca:cb14:526e?
 ([2a02:908:1256:79a0:a701:87ca:cb14:526e])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a170906078600b0084d381d0528sm7238767ejc.180.2023.01.13.03.47.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Jan 2023 03:47:43 -0800 (PST)
Message-ID: <fde7c277-1b1f-83f4-d7c8-dd53a994ff2d@gmail.com>
Date: Fri, 13 Jan 2023 12:47:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: print bo inode number instead of ptr
Content-Language: en-US
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230112165938.55022-1-pierre-eric.pelloux-prayer@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230112165938.55022-1-pierre-eric.pelloux-prayer@amd.com>
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

Am 12.01.23 um 17:59 schrieb Pierre-Eric Pelloux-Prayer:
> This allows to correlate the infos printed by
> /sys/kernel/debug/dri/n/amdgpu_gem_info to the ones found
> in /proc/.../fdinfo and /sys/kernel/debug/dma_buf/bufinfo.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 90eb07106609..2b076ed46e78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1572,9 +1572,9 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
>   	attachment = READ_ONCE(bo->tbo.base.import_attach);
>   
>   	if (attachment)
> -		seq_printf(m, " imported from %p", dma_buf);
> +		seq_printf(m, " imported from ino:%lu", file_inode(dma_buf->file)->i_ino);
>   	else if (dma_buf)
> -		seq_printf(m, " exported as %p", dma_buf);
> +		seq_printf(m, " exported as ino:%lu", file_inode(dma_buf->file)->i_ino);
>   
>   	amdgpu_bo_print_flag(m, bo, CPU_ACCESS_REQUIRED);
>   	amdgpu_bo_print_flag(m, bo, NO_CPU_ACCESS);

