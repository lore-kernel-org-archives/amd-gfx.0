Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545A2106FD9F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E19410EB24;
	Fri, 13 Mar 2026 08:25:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="EnrDENXX";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CC7B10EB24
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 08:25:11 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4853fd7b59aso11758315e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 01:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1773390310; x=1773995110; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BJUMCG4fpNCoIIG5/bZYmCQOy6xMcQVKtg4qMy6XBHM=;
 b=EnrDENXXUODlH8jaRzIaZ0diDUkMa0r8ozphhonJisuPW1zpomSodjR/TalfQ/TX2N
 jOREqZjREtbMIUIY04UJ2og+ACEZawLjliRnZLpOa3sArWcs3HnygqSR2tGI3thoozam
 VPhhuptL6iI1+dj1B+CE1eUYJ9OmSJW0XGD7kFm9F4FX3p5dIFDxgElxSCvLA7czgqbe
 kbkjDbSL+x7EaC2HwbFB5WcmMaj2JfI5z3l2cGja61PrLLRioCZJpOvQEM58VclztLGk
 azYHDJWQ4nVixDaNjzMVnT0Jh/7CRQhp7Ad5Q+zQvL5wA/mmGv/dLIe8zD4jHuDlOn3H
 Ar+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773390310; x=1773995110;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BJUMCG4fpNCoIIG5/bZYmCQOy6xMcQVKtg4qMy6XBHM=;
 b=X/5iajwPHLqMXIhkFKOagjM8Yf5laftcOK65qjCekIurjWdrBbuUjwCGzZ5MxXELLs
 ah8BMSZ2JUr2ufui8HpmsBz0+LJ04hmQGxEK2j4T8XPz0s1iegHQFhvw69c3Phl2twWz
 UcaaUjJcihGfP7+NEqxSjndyJfqOllXIJLuKQCiHvAY0ZA6hpsZwTba5+VOjPFNFo1Td
 1C1pEs4rWA4aGZvIwvf04oT5z3phsKNPDWzZwHDVuigeBKTlOKBOsmrVZ8ZQTfYn3ZDA
 8ePYOHtUG3If2iMmfQ0RmF5fWx7d7/oy7iVjsIxsvF9iTH/FYV3qJGfozpo8gR2ZpcWP
 J4kg==
X-Gm-Message-State: AOJu0YzC+2Dl6KM2bkY9sztaph73vbNSj8Bh3Mff3QM8O30QfEEkwjqg
 ls4w3XaoGJwxB43dwBSmrRNCmvhErx8o+o9pqr1rmpb0SYa4yEHDM28hVoiWTK3JakQ=
X-Gm-Gg: ATEYQzwQFXMafcjR96JXnZmL1H3bPcjZtqm+CN0K1oY8mBG9rhrA8Tf/w+vNP7xnuTE
 Bw/PcJB0wg533Q/lN0ZnW67KJ+s+lb+p0I9zQt9cSgk1kIxYfsuv8Ld1oDMpp75l8YIIgEjeaQl
 4OjLIABae19rQvN7ThTgyfAWU4ehEgfkH3doGlWRb+EY4eaHzp1CopLuDqvmgGe0q+XgzVLzIkS
 B4Lim2SqIzV0JchZDf0aagMO5N5P3LpMQBiCh1oEotAzlnYwGaPhYM1BJZUdSrv1nROSFjYxBUr
 Qz7MNt6ZMFVvLLtTvJRNiwDTV0POjqKmSpzETf18WUlHdEROvhPQQxzXr7u0ZogD6oqwR654DPV
 sJknrrBj4cxGkKHrCLHZ9FXb9b966cTIfH/7w6bZr7SzcalqQNQiHS2krYp9uLpyYzzMBwsBDUX
 NFhCwYarVWgJk/vRTNzCFYQm4NouG7G3cxmazNI95agtYa
X-Received: by 2002:a05:600c:3b98:b0:477:6d96:b3c8 with SMTP id
 5b1f17b1804b1-48556707127mr35852305e9.23.1773390309661; 
 Fri, 13 Mar 2026 01:25:09 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aac28bsm274812015e9.1.2026.03.13.01.25.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 01:25:09 -0700 (PDT)
Message-ID: <a798c30e-68e2-4242-8d93-65bfff9b15d1@ursulin.net>
Date: Fri, 13 Mar 2026 08:25:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] drm/amdgpu/userq: Use kvfree instead of kfree in
 amdgpu_userq_signal_ioctl
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260313072140.3327678-1-sunil.khatri@amd.com>
 <20260313072140.3327678-2-sunil.khatri@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260313072140.3327678-2-sunil.khatri@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 13/03/2026 07:21, Sunil Khatri wrote:
> In function amdgpu_userq_signal_ioctl, drm_gem_objects_lookup allocates
> memory via kvmalloc and hence when that memory is freed the memory
> via kvfree.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index fad595401a77..146ca6d7f4f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -598,11 +598,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   put_gobj_write:
>   	for (i = 0; i < num_write_bo_handles; i++)
>   		drm_gem_object_put(gobj_write[i]);
> -	kfree(gobj_write);
> +	kvfree(gobj_write);
>   put_gobj_read:
>   	for (i = 0; i < num_read_bo_handles; i++)
>   		drm_gem_object_put(gobj_read[i]);
> -	kfree(gobj_read);
> +	kvfree(gobj_read);
>   free_syncobj:
>   	while (entry-- > 0)
>   		if (syncobj[entry])

Oops, my bad.

Fixes: 4ca06f6fb45d ("drm/amdgpu/userq: Use drm_gem_objects_lookup in 
amdgpu_userq_signal_ioctl")
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

