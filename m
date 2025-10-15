Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690B2CCD195
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 07:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0555E10E733;
	Wed, 15 Oct 2025 07:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="YK/ErJOe";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9C0810E755
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 07:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760514802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+HZgDzRdpaVTxvZqJl2rTn2R8LelhY8vbHUCgBN35M=;
 b=YK/ErJOe4ySVCbEZDx7t4Rrs+YpkmUaM7i5Nz8Y2h+86ClpnfCycAlli2dCvg0nT/gT/JJ
 JBDBMlxp2hivbyqDWvU/75CgrhsccnHK+b3Xj3G3Jc+4XlwhYzO99y2bT356rpLEV9g9et
 FVX3f1NwA3XVu1jQxknmOcCO4r1UFG8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-1rm2fp6FPJiiYxl2H0gJ7g-1; Wed, 15 Oct 2025 03:53:20 -0400
X-MC-Unique: 1rm2fp6FPJiiYxl2H0gJ7g-1
X-Mimecast-MFC-AGG-ID: 1rm2fp6FPJiiYxl2H0gJ7g_1760514799
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47106a388cfso689445e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 00:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760514799; x=1761119599;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t+HZgDzRdpaVTxvZqJl2rTn2R8LelhY8vbHUCgBN35M=;
 b=DFP68F9Ii6i+3qVnz0n1xeYbtNClfTvGoU4Q3DgpEaw7czWegnP69cpu0PTutsDmig
 Q5C1TPnksskvA5sIx/BX8FSxIJptupOIrGyCCdWrygVJ23nnNdBMTjo4XtG9PHYuB/t+
 d6Ad9/ZFEq86+WcCWPO9xjq04mIfb7GGK4uYj5ocYBldcD7GXbzO82yKiKaaoKr8xNs5
 4E61GXI6ptjW1A288p7UK7PGbiAUdhgpOWGiYpP/ubsRy2zc8dk37g5bLC/Aq1GmX7tI
 73KkSWJh525eGcCY7x+/jm8pnQXZjQGJheq/OX7gz5BEFVFObD95TIdmy0ZDxZ9Dhdin
 olew==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/NN3UXoYVtmfNqBZAj21iGJpEzhzdFkfSIuOTBOUmkBGj4nrc/1sQw5YdC3tZnqoBCHcrrUe7@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyckgQEINh0u+FPoaWaLZxCoBI4/niK2CuhSWSNWN1xws4kMZa5
 +5cnGBn5SIovlW13vI1ivdMyj/Otvo198hZR68LBq0pBj2tZgFCMhTaAXtlnOpCCsJtFIrjGPjm
 nUNwM5zS+omryy43RrPPU/JIHUWK5qEXaMdP5kR2yp7Ek+JxMbdUdULqcVuc1Ub4OrLs=
X-Gm-Gg: ASbGncvtsI81KXkH+/GTcN213xG6TTo1S4zvaChmAn9t24rV751+JGvQda2+neCD20P
 lHNLPilLJuvC3oH4EVSngSOrQve2+T5s7eLI23Ca4Z3aL1d8uPWRHGT126tjMZ6llWD9tHkhRuE
 /Kw0INMuMNgBLrE7M37KBqKCXCqeKRDZtYde/5jQyZeWTOUABxzemFTFXt/h+ImgCY012+1ONo+
 ka2I+Bci05dNUiKFUwius6JrjOPjVnkuM5z+B1jaCfmkGlF/tX/NlMykbbBwvGJ7kb4w8nekgjg
 rZvH2VF6Iks6dl2QJNslVwJt00URKLruQTLhZk5rVpcmi/p8IQm0n70Zut3zumqHsezJP30zArP
 3tely
X-Received: by 2002:a05:600c:1e28:b0:45b:47e1:ef6d with SMTP id
 5b1f17b1804b1-46fa9b11746mr202661425e9.36.1760514799493; 
 Wed, 15 Oct 2025 00:53:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZf7d9TK63edfjPsh4LrX74Y6wRlhtOgKLsjlyk6mKGtY9U4BbM1bQ2mcLbjosAJUslcGWjg==
X-Received: by 2002:a05:600c:1e28:b0:45b:47e1:ef6d with SMTP id
 5b1f17b1804b1-46fa9b11746mr202661265e9.36.1760514799084; 
 Wed, 15 Oct 2025 00:53:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47101c21805sm14875785e9.10.2025.10.15.00.53.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 00:53:18 -0700 (PDT)
Message-ID: <c256b8d9-ec9e-4841-9136-1198ad2d590a@redhat.com>
Date: Wed, 15 Oct 2025 09:53:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/log: Add free callback
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-tegra@vger.kernel.org
References: <20251009132006.45834-1-tzimmermann@suse.de>
 <20251009132006.45834-4-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20251009132006.45834-4-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m8d9ODuxhcINToecqUDJfHTCCzdCGCf8Hhnu-YmI50A_1760514799
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
> Free the client memory in the client free callback. Also move the
> debugging output into the free callback: drm_client_release() puts
> the reference on the DRM device, so pointers to the device should
> be considered dangling afterwards.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/clients/drm_log.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
> index 116e0ef9ae5d..470df4148e96 100644
> --- a/drivers/gpu/drm/clients/drm_log.c
> +++ b/drivers/gpu/drm/clients/drm_log.c
> @@ -293,19 +293,26 @@ static void drm_log_free_scanout(struct drm_client_dev *client)
>   	}
>   }
>   
> -static void drm_log_client_unregister(struct drm_client_dev *client)
> +static void drm_log_client_free(struct drm_client_dev *client)
>   {
>   	struct drm_log *dlog = client_to_drm_log(client);
>   	struct drm_device *dev = client->dev;
>   
> +	kfree(dlog);
> +
> +	drm_dbg(dev, "Unregistered with drm log\n");
> +}
> +
> +static void drm_log_client_unregister(struct drm_client_dev *client)
> +{
> +	struct drm_log *dlog = client_to_drm_log(client);
> +
>   	unregister_console(&dlog->con);
>   
>   	mutex_lock(&dlog->lock);
>   	drm_log_free_scanout(client);
>   	mutex_unlock(&dlog->lock);
>   	drm_client_release(client);
> -	kfree(dlog);
> -	drm_dbg(dev, "Unregistered with drm log\n");
>   }
>   
>   static int drm_log_client_hotplug(struct drm_client_dev *client)
> @@ -339,6 +346,7 @@ static int drm_log_client_resume(struct drm_client_dev *client, bool _console_lo
>   
>   static const struct drm_client_funcs drm_log_client_funcs = {
>   	.owner		= THIS_MODULE,
> +	.free		= drm_log_client_free,
>   	.unregister	= drm_log_client_unregister,
>   	.hotplug	= drm_log_client_hotplug,
>   	.suspend	= drm_log_client_suspend,

