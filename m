Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D8ECCD195
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 08:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B7910E735;
	Wed, 15 Oct 2025 08:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JOfLyAd5";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD4610E280
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 08:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760516449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HU62gMpjIaFZFXMtNGaeiDMNZ4Zv7CCqH8t0PFzlFoY=;
 b=JOfLyAd5BIsXGsx9Oz7hu9boXLH2G0GAoB0pGg+5hMITbciLUmHJ/pwTqK7nKg5VLJ8CVz
 GN2unXteq7eMZjrO5FgTys+huHsyPcDK8tBtP21nKcN5v33oRKZnVBZKTTZlET/6ooe6Y0
 9HL6RXykMK5POxtcNcfVVI8x6vvLa1c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-GgB1PlG4PZagzvUUK8uGcA-1; Wed, 15 Oct 2025 04:20:47 -0400
X-MC-Unique: GgB1PlG4PZagzvUUK8uGcA-1
X-Mimecast-MFC-AGG-ID: GgB1PlG4PZagzvUUK8uGcA_1760516447
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e509374dcso27314305e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 01:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760516446; x=1761121246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HU62gMpjIaFZFXMtNGaeiDMNZ4Zv7CCqH8t0PFzlFoY=;
 b=q56P7pBhM/YB90GftFirQ+g+jfu8rsFCcSfEjyJGDRd/qg3PqQgraVHtXE8ps/EHws
 V8uzEwtzPhatpAFisl7ikec+bOF8AXrIr3Y88fbeH7llbI/LsvC6xd6tlFcKPdNCN+4J
 +8jeHE/+l0tJS/p9WyF49MQxn2MdP/711nA4fosqL9/eteqFUukWNSW2IwXoiZkXLkKm
 XrH82KnhJwcolVp4bJkKQSmiAiJHWS7V5mLFxOGzLuVFm6+IOXbAymitr3Yh1evYZMpq
 te6EvICfhoQrKIoBItHCe2Hyjy1YqtEitBOG/BkXIMzpELPVxHYz9RhIfxIox52HVLet
 aG6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIvtwLX4nYwZHYcJ1BEsPiJi49eJQ/cWd2KMpiRsptTcalX2SeolGMQG7ddsoIi2VO5eYVU1w5@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7porK9WDpmPe+QRt7JhTsWb3PMkKhTYh4iwtnQzbgGillcuyj
 rq4dfCk6WdNrXZpPGUN/X5XhLtqNoMY34Vi/nRDeGmVCjTARXS+VbmltuTQ4v7KR2VdqzufBwOd
 QeDjbv8yKbXyvGDwVvUxLq7CsBsCSfwQBF3hMOKTgFdYQYPgWe/zREqkSfdGMstcYZkg=
X-Gm-Gg: ASbGncsBm6mJpXpyKKrNCVZUUkIk/b+1APNElasl++xO+dFjzzHOJpx3sUYLzWsZTGF
 s0PCjbdaah1kPi5fE2z4L4+pQxlISQJgXEydgf55rld7Zao5WjxFL5whfYVXJKjtLGgHmf7P3YG
 1pKL7Q3x5XZDznxxc1H7xFrGZBTrlOYT930uohYAGMIs3vbwcYBckIDfuTvM18uubA0i3KGEwBD
 O2KwPkzRiGwAZ9AWeWaggfNz2LfrIl55bQ4PsrznWqSLVFrsL4yU6AmGqRLfguMWPRMTTUbZB0u
 ZuwD+7zgcAScEvtWLuImqeCw0Sci59YoC96grzepGw4W3Lzniu2FgVqPSta79r1P84vz94v1Paj
 XBDXt
X-Received: by 2002:a05:600d:41c4:b0:471:7a:791a with SMTP id
 5b1f17b1804b1-471007a7a96mr9522815e9.7.1760516446521; 
 Wed, 15 Oct 2025 01:20:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKG0piBaN7As1r+PD/K5QtUV2Z28HHZlEUD35iBfCWvoyf69YaDGLCaS5NwDRxAhyjJ4bu3g==
X-Received: by 2002:a05:600d:41c4:b0:471:7a:791a with SMTP id
 5b1f17b1804b1-471007a7a96mr9522475e9.7.1760516446097; 
 Wed, 15 Oct 2025 01:20:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb482b9absm327503135e9.2.2025.10.15.01.20.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 01:20:45 -0700 (PDT)
Message-ID: <c85d528c-6787-4023-8883-3519b7498627@redhat.com>
Date: Wed, 15 Oct 2025 10:20:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/client: Do not free client memory by default
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-tegra@vger.kernel.org
References: <20251009132006.45834-1-tzimmermann@suse.de>
 <20251009132006.45834-5-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20251009132006.45834-5-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZrdSRJzJYjcXEiQkbWgLKt5LfEE68OThcA-L_ASLQis_1760516447
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
> Make no assumption on the allocation of the client's memory. For
> example, amdgpu stores a client within another data structures,
> where it cannot be freed by itself.
> 
> The correct place to free the client's memory is the client's free
> callback. All existing clients implement this.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>


> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/drm_client_event.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_client_event.c b/drivers/gpu/drm/drm_client_event.c
> index c83196ad8b59..f36fe0392ce6 100644
> --- a/drivers/gpu/drm/drm_client_event.c
> +++ b/drivers/gpu/drm/drm_client_event.c
> @@ -39,12 +39,13 @@ void drm_client_dev_unregister(struct drm_device *dev)
>   	mutex_lock(&dev->clientlist_mutex);
>   	list_for_each_entry_safe(client, tmp, &dev->clientlist, list) {
>   		list_del(&client->list);
> -		if (client->funcs && client->funcs->unregister) {
> +		/*
> +		 * Unregistering consumes and frees the client.
> +		 */
> +		if (client->funcs && client->funcs->unregister)
>   			client->funcs->unregister(client);
> -		} else {
> +		else
>   			drm_client_release(client);
> -			kfree(client);
> -		}
>   	}
>   	mutex_unlock(&dev->clientlist_mutex);
>   }

