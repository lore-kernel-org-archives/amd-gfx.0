Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E67BCCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 15:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3124B10E635;
	Tue, 14 Oct 2025 15:03:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="P+NgjKVv";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8AE410E638
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 15:03:57 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so2489107f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1760454236; x=1761059036;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KvLif0xXP5NnZk/gZt7mDLBmevCZybOrgLCvCymTSWA=;
 b=P+NgjKVv0jv5ACJpwXYkGD9jf0eMPj+XUtv476WSdJ1YMV60xrsMuGyuUagX2kLcKo
 1AyN0brZWj4tQMcJ1xev9TgNcTOp5XKys4v1HEaAEWVKdE8/WF7QAan42Y/tOXWU7PwG
 73pjDmotFY3JG1bJL+TbWOJQQ5DBBo7cc2BjZzr6f+LFlfXm6ZUB0kRCTLYrwGZfLxFw
 AXS63QF7hFh3vgSBOuJfBgRMAYZ66NdeaIIPq05Sx8pexMajQOaK+nZm7R/eOuaGezan
 xccb9w1jN/kUbWlYBQp2d5bd0zZyNS2CuKFJUUhb5aNVzPF6D5xBM0d8thdabIdcVjsH
 TG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760454236; x=1761059036;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KvLif0xXP5NnZk/gZt7mDLBmevCZybOrgLCvCymTSWA=;
 b=lELY0sBOD/YV2qcD81QxWM7rAIWpYAVE2M7McUhQBnKEKqd75ixI5IZdudQRuupysw
 xb/a7tD8zONAfSH281B2ZjVkGayzUMzzD7SXNjNvdYf1hR+Bq/151rV814TL6HDG1G2i
 Y4kYs/Ic8xHwgxqNCyUcizKOjSW1G5+W2dh1h/opjaUYx1k+F/SebMZ1Mln92gPIlfmB
 PRjRZUIiragzbwflqtGLKnkmeCENQSlGPu2wNic+uPMNVvdThYwfbiElPSJybX4mf6SZ
 aOci0nOL6CmkCtWmYyxqwAd+a8TqZiBtbWaBP9tXjz8ROEGkrTJP9Bni/+Tc16V+w51i
 7CTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeY+9mr+JYqNQvE3Xr+L6JS4SflojO3L9G7hcPk3dDAkxJ6CHcjVEM/1NsssTfa4ncGEdhujFN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNI3JNEugcoU4nge0snjRd7quXiw7Z7xcE9Fk82LEVRfOpnrYE
 MaiONpO3WKEADh4hajQR5oyCdN+EUlY+0/dQZspgKUBUK+ctmWI+ymbBEV2k7YyQVZA=
X-Gm-Gg: ASbGnctH3NJR8eR/A4dJUSGJ/4hJS898TnRO9KFr6ACMXHLExs/2jVJ0S8Gr4YBqExX
 ICFQcACEnzMmVEbJnCTQwcudL2cuOB6PQkcvAi6cGyl0O1ZAeG+l+IaepycrY2fpBH6z4GX4Pi7
 o5fFWF98nAcnkzzcTsdypu55Ez4iDWQDR66JK3UTouJ1d9D3wJO7T/1XelfG5Vs3wUXSP3l1D4r
 rzWbJ3v5V2D0BcOkzmE48S3NesLz8DlSly/jMeUHYrqGkl16wKnv9kEn17dHKEvwLwDT/fkSDDw
 noPvex1nPUVisoai2PF3pNi42mzDUfO2B42LHIiETuTCxMUbg3y0GyQk0vA4VLVqBzrWpg6xxhy
 AaWI6n7wxNnxplon1P6mJdiA9FsvYXAebKDaPzPw9LxKhyORTtxERT4oInNHXl+I18Ok=
X-Google-Smtp-Source: AGHT+IEbGgBHynNzMEpqQZCy22mrVyYPNVZNNhtZAJURBbvEYkVoKSFha08SyV1BB8PWrTBOC2JRpQ==
X-Received: by 2002:a05:6000:24ca:b0:3e5:47a9:1c7f with SMTP id
 ffacd0b85a97d-4266e7df708mr16101225f8f.47.1760454235744; 
 Tue, 14 Oct 2025 08:03:55 -0700 (PDT)
Received: from [192.168.0.101] ([90.242.12.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cf6b4sm24185121f8f.25.2025.10.14.08.03.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 08:03:55 -0700 (PDT)
Message-ID: <601678b2-8ebf-47f7-a1b9-077468dd8fc9@ursulin.net>
Date: Tue, 14 Oct 2025 16:03:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] dma-buf: rework stub fence initialisation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20251013143502.1655-1-christian.koenig@amd.com>
 <20251013143502.1655-3-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251013143502.1655-3-christian.koenig@amd.com>
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


On 13/10/2025 14:48, Christian König wrote:
> Instead of doing this on the first call of the function just initialize
> the stub fence during kernel load.
> 
> This has the clear advantage of lower overhead and also doesn't rely on
> the ops to not be NULL any more.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/dma-buf/dma-fence.c | 32 +++++++++++++++-----------------
>   1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index f0539c73ed57..51ee13d005bc 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -121,29 +121,27 @@ static const struct dma_fence_ops dma_fence_stub_ops = {
>   	.get_timeline_name = dma_fence_stub_get_name,
>   };
>   
> +static int __init dma_fence_init_stub(void)
> +{
> +	dma_fence_init(&dma_fence_stub, &dma_fence_stub_ops,
> +		       &dma_fence_stub_lock, 0, 0);
> +
> +	set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
> +		&dma_fence_stub.flags);
> +
> +	dma_fence_signal_locked(&dma_fence_stub);
> +	return 0;
> +}
> +subsys_initcall(dma_fence_init_stub);
> +
>   /**
>    * dma_fence_get_stub - return a signaled fence
>    *
> - * Return a stub fence which is already signaled. The fence's
> - * timestamp corresponds to the first time after boot this
> - * function is called.
> + * Return a stub fence which is already signaled. The fence's timestamp
> + * corresponds to the initialisation time of the linux kernel.

We sure hope it's Linux kernel and not some imposter! :D (Ie. you can 
drop linux if you want.)

>    */
>   struct dma_fence *dma_fence_get_stub(void)
>   {
> -	spin_lock(&dma_fence_stub_lock);
> -	if (!dma_fence_stub.ops) {
> -		dma_fence_init(&dma_fence_stub,
> -			       &dma_fence_stub_ops,
> -			       &dma_fence_stub_lock,
> -			       0, 0);
> -
> -		set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
> -			&dma_fence_stub.flags);
> -
> -		dma_fence_signal_locked(&dma_fence_stub);
> -	}
> -	spin_unlock(&dma_fence_stub_lock);
> -
>   	return dma_fence_get(&dma_fence_stub);
>   }
>   EXPORT_SYMBOL(dma_fence_get_stub);

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

