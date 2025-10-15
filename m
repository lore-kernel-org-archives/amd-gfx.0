Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E82CCD190
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 07:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 958B110E278;
	Wed, 15 Oct 2025 07:52:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="KU1ZYWOy";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E21C10E324
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 07:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760514765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MHykXUHzy3P15VrWtRxCqfqVXwzZ2Ylga+RWIrK7dZE=;
 b=KU1ZYWOyDIwp4S0YN5O9G5v4PiTcyS4tN2OQ/zFd0tL87xUu7N5utJO4rRX6rfjM5Tep26
 Bu+ls5UIsYWtXP0m1ccwoy7RBnvhQu42i7X6UWwHXKRfzSKKL01F0/My/kbWlUsQI+uqgl
 mdqwvQiqrlRTGWgul8yBE/ZqBjORHc8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-VJjUer9INv2H2PJYUieH3A-1; Wed, 15 Oct 2025 03:52:44 -0400
X-MC-Unique: VJjUer9INv2H2PJYUieH3A-1
X-Mimecast-MFC-AGG-ID: VJjUer9INv2H2PJYUieH3A_1760514763
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e36686ca1so56133815e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 00:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760514763; x=1761119563;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MHykXUHzy3P15VrWtRxCqfqVXwzZ2Ylga+RWIrK7dZE=;
 b=qgQ+f+sl9gUSokkE33g69KEpjcI/BAvst02gn1lJqW2EVWpigpdW3xW1Jeo+9t8QQm
 vhtt3gMQGrqAsw14UvIMZvi6Z+NdZAsUv98BD1y4FmetaiyDAc3bj93X4vzW3e+XClgr
 hvatxNUYACdX+96jfEAiDSkvqOgSi77gBz7nREYhJUrPHtufZFFpIuaOVD/uDAk0Zn3V
 zrTKcCkWfTaPZYKNv6lhfce/0gT95vFGxaVb4Zxf/rT2C9XwwOG5AlVOQsaC8z8tWG59
 xoJQHFzYM8Fz9zrBVKWrD987e/7iuUrjajQnfvZbRJElT/HkCN0zeRxjaZhtCGmUPIvy
 dIRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjojCqUFUxLMDAKpGpfrHC6g7Y8WLql6W8dPVilJ/gav8sEnvbZ+dyAiZ6/HYdhTccFl4UotZU@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHaN6IkNDh1Hk/PeFfV+ctg6g/mok875xHxwJzFZFht0INDRrY
 bwqbK4u3Lvi3k2+S3oKZ5jt9sPuMsS/Mr4AwXfu3qgTdSOT1WRUjW22PMRtH+VNO0EnlRafJbOq
 5ZWJms6vnBhGXn7LR/ikneu66wenB1Hm36Nki3762mNlJLHHmbX+GInQM2e4gAALhvk0=
X-Gm-Gg: ASbGncvS6sFB09Jt+WKWAuE16WJz9tXmTf1fugcEwePjTXjDEmdkfoqVH7L9Fst0rnr
 7Mth1ucWnVsXSzZxVw5Ar+CR+kB3yef3qdZSiJqYC5T9HOOt8ePpQhdN8tzpE6IvDYNWihs/vzr
 mF0W5F01bOZ+OuYbd9xP7fxc5hsJbXMpRcvnpN1tkij2LLWrKKyO6g++BY+fVEo9ea0BgqAfIQX
 7p8gkWAjcmXxV9tg1xhkxaTCHnfmeWc3vY86Vln8oeuB6MG1RhEBn1I+ySRQh3PJKYU0qRiNIuS
 H8B5ByBKC+NCfVjFt1boPtrvc1u3kkQBVDZpjVJ64ZQ0z69v+eUf0IfFx/NglpYd6JXvMk9xYU6
 zlvm2
X-Received: by 2002:a05:600c:34cc:b0:46e:59dd:1b4d with SMTP id
 5b1f17b1804b1-46fa9aa2076mr211303455e9.16.1760514763143; 
 Wed, 15 Oct 2025 00:52:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW2ZDBPJxUfYCX0H6nLEKOLye2i61674dJQY/ZLYYwFVcv5Uohdp1HeQRReQYkGVWqF+Eh1g==
X-Received: by 2002:a05:600c:34cc:b0:46e:59dd:1b4d with SMTP id
 5b1f17b1804b1-46fa9aa2076mr211303305e9.16.1760514762767; 
 Wed, 15 Oct 2025 00:52:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47106fc97adsm2155395e9.9.2025.10.15.00.52.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 00:52:42 -0700 (PDT)
Message-ID: <3d07c6ba-02d6-4d3f-8684-65a41b128539@redhat.com>
Date: Wed, 15 Oct 2025 09:52:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/log: Do not hold lock across drm_client_release()
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-tegra@vger.kernel.org
References: <20251009132006.45834-1-tzimmermann@suse.de>
 <20251009132006.45834-3-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20251009132006.45834-3-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xaEvwPUXVEdXfNMG9m0-6I10sbj7qiS02CK9QUpjslA_1760514763
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
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

On 09/10/2025 15:16, Thomas Zimmermann wrote:
> When calling drm_client_release(), the client is already quiescent.
> Internal locks should therefore be dropped before the caller releases
> the client.
> 
> In the case of the DRM log, concurrency originates from the console or
> from client events. The console has been unregistered in the previous
> line. The caller of the unregister callback, drm_log_client_unregister(),
> holds clientlist_mutex from struct drm_device to protect against concurrent
> client events. It is therefore safe to release the client without holding
> locks.

Thanks, I agree, it should be safe to move drm_client_release() after 
the lock.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/clients/drm_log.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
> index d239f1e3c456..116e0ef9ae5d 100644
> --- a/drivers/gpu/drm/clients/drm_log.c
> +++ b/drivers/gpu/drm/clients/drm_log.c
> @@ -302,8 +302,8 @@ static void drm_log_client_unregister(struct drm_client_dev *client)
>   
>   	mutex_lock(&dlog->lock);
>   	drm_log_free_scanout(client);
> -	drm_client_release(client);
>   	mutex_unlock(&dlog->lock);
> +	drm_client_release(client);
>   	kfree(dlog);
>   	drm_dbg(dev, "Unregistered with drm log\n");
>   }

