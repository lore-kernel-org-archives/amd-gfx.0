Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C002C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 16:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71FA110F651;
	Wed,  4 May 2022 16:46:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B167C10F784
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651682761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t24tg6/LveWdhoRmGGn+/iiJbZYvngbtfY/IYKt0y+w=;
 b=VL29w52OtSvR7zUBOgYEdRHnY24v12XXXUW3MpL2+vASV1uPWOnpFk+qp1DGeDWJmbu/Lu
 9xObUnHo2YQfNYUkPfuAnUrsdCMmJGoRC4wZPbkkEAMY6ppCNb+VdlZOZB6ZJrs4y0AqHs
 85ssDlUUIouFw2PNTqdC9yYU08cPeFE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-QxismwhiMYS6nC5-9cYoOw-1; Wed, 04 May 2022 12:46:00 -0400
X-MC-Unique: QxismwhiMYS6nC5-9cYoOw-1
Received: by mail-wm1-f69.google.com with SMTP id
 n186-20020a1c27c3000000b00392ae974ca1so1771109wmn.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 May 2022 09:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=t24tg6/LveWdhoRmGGn+/iiJbZYvngbtfY/IYKt0y+w=;
 b=on8laPGlqdAHXaL6AIB5N2SMPLXMjYvSuHoaO5daCtrOawnK6qIJyr1ee9c5MyHPOj
 7vmOH8vpTUpZea3XBQhh3TwQ4Vm5Vzf6QJw5rpvT7eR7/VUC4qAJM7xjh/ipFex7dF7c
 iSWEl1p2yUww6eqzd7N2hxbzJ+vEGMi70ykCclh3HNUhDGn8mtD3WrjsOrLEmbNTWsus
 8SwyxdL/8j6IL3ng/3uDCMhrT2M5MVeS6wUQ+ntILsz+0Mm33QCfDVAJvjsGis7GE3jf
 YS22Ki0g2N9Ay4Gi7EFQF4xj7fT4rhjEWAZZcwvRkRbqhyu1f8iz/R+gQIjMK8+InURB
 d+bw==
X-Gm-Message-State: AOAM530kcbYraX3jutTfAIvSMQSk7gO5D+uK0pMk+9frbQ42Q4LTjbkp
 AKofxVmiOzM4gxAU+7MVpzUBuwfxbS0hEAfXQZnOy6qh/4Nc6/JpIMRA1aYVzHflBo9GUHdLVOb
 OY3ZFKkfgDC5qgdP0vCignr8naw==
X-Received: by 2002:a5d:5707:0:b0:20a:c768:bc8 with SMTP id
 a7-20020a5d5707000000b0020ac7680bc8mr17217016wrv.565.1651682759557; 
 Wed, 04 May 2022 09:45:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoBEhaKvAsH6E5U+GUSakxLdWaK4c4jZF2naFOjXjnwL8n8hWZp8qeW7Mx6pNpMgWwSO5Z0Q==
X-Received: by 2002:a5d:5707:0:b0:20a:c768:bc8 with SMTP id
 a7-20020a5d5707000000b0020ac7680bc8mr17217006wrv.565.1651682759336; 
 Wed, 04 May 2022 09:45:59 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 l1-20020a1ced01000000b003942a244f4fsm4143450wmh.40.2022.05.04.09.45.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 May 2022 09:45:59 -0700 (PDT)
Message-ID: <f48a0482-7be9-29d5-b179-e572dfac11fa@redhat.com>
Date: Wed, 4 May 2022 18:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] Revert "drm/amdgpu: disable runpm if we are the
 primary adapter"
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220504134833.1672728-1-alexander.deucher@amd.com>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220504134833.1672728-1-alexander.deucher@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

Hello Alex,

On 5/4/22 15:48, Alex Deucher wrote:
> This reverts commit b95dc06af3e683d6b7ddbbae178b2b2a21ee8b2b.
> 
> This workaround is no longer necessary.  We have a better workaround
> in commit f95af4a9236695 ("drm/amdgpu: don't runtime suspend if there are displays attached (v3)").
>

I would write this line instead as:

in commit f95af4a9236695 ("drm/amdgpu: don't runtime suspend if there are
displays attached (v3)").
 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---

The patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

