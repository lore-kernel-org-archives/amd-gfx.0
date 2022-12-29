Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CFBC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Dec 2022 14:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 106EF89F31;
	Thu, 29 Dec 2022 14:35:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3043E8989E
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Dec 2022 14:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672324517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KePM8LGAehS8PxVf3em7bkMvOyCCyGkD1QJPFzoXjoY=;
 b=CIRadfUdkEOIDqd1qQcLdqhj+Lfaxkn4yKhueuPRnaHWwLn6Ww4zIUp8/VTGfTu+LtEqGK
 1PCI54y1IE6ky7ZxGxp+fU/jT+BajAyRP5jbhUsc5Pa4zJi3jIHBpBZdL5hve2NS3uD+P/
 qqpjzzeNAiUc7BcSi4bIhRinX2h0K5w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-498-ojiHMd-8PBiR2NbGPgSb3g-1; Thu, 29 Dec 2022 09:35:15 -0500
X-MC-Unique: ojiHMd-8PBiR2NbGPgSb3g-1
Received: by mail-wm1-f70.google.com with SMTP id
 fm25-20020a05600c0c1900b003d9702a11e5so8168416wmb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Dec 2022 06:35:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KePM8LGAehS8PxVf3em7bkMvOyCCyGkD1QJPFzoXjoY=;
 b=H0GI78BZRRpDCWwn2dDhtyNYpNWRB3/14CxJoUGeWmWY8yX4Rg8PasIxaXQ+hSObH9
 vgajinapI6EH4F5V06G6gyk8XlzGw9z6MZkOAHPNUe3xtPlWYZaRi3R0CnH8nvye/s29
 r3y+0X4siORgekSvasl1vZBDROXhMM/xHkaKjY5f9M2Hk3rSs5geToupjgGoxzoTODZv
 FSJbUglUNnlyk42jMU17qwo3huaFtvyTib0OLuA+9qtvRd2ECQW0I9oF4v3fs3Pd/zUA
 xhNoJTHjGc3GIiWHI0KgfGlryLNXpGyvKtJhcvB+O5ZGd+W1PHrv7lQVeBxZWJBdGAnN
 hPnw==
X-Gm-Message-State: AFqh2kpi7cAaW8K6wGukqTvFBNKWKwovUlWvXa1F8cIZ8uY40vxwhAcV
 pR6gX7rPSI8g5fRIW1cB/A4xCRMzH/1R4y4g2irABwnhvD2ENrHpUPm+mz5dtn1xYeP8YRyVMyI
 35HuM1LBSBCue/fKR7Lb5+9poKg==
X-Received: by 2002:a5d:460d:0:b0:242:69f4:cb6a with SMTP id
 t13-20020a5d460d000000b0024269f4cb6amr16459188wrq.9.1672324514804; 
 Thu, 29 Dec 2022 06:35:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuhgKP5nEJxUo1DwVlnSvFu/L2yowvsm+jGS3h9joQUDWOjQmxTMQckkrXQ+uhe+DCqYeOJDQ==
X-Received: by 2002:a5d:460d:0:b0:242:69f4:cb6a with SMTP id
 t13-20020a5d460d000000b0024269f4cb6amr16459171wrq.9.1672324514569; 
 Thu, 29 Dec 2022 06:35:14 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 p13-20020a05600c358d00b003d1f2c3e571sm32813393wmq.33.2022.12.29.06.35.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Dec 2022 06:35:14 -0800 (PST)
Message-ID: <21fe5a6c-06f9-a902-6621-19c4a2a451ad@redhat.com>
Date: Thu, 29 Dec 2022 15:35:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 01/11] drm/amd: Delay removal of the firmware
 framebuffer
To: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org
References: <20221228163102.468-1-mario.limonciello@amd.com>
 <20221228163102.468-2-mario.limonciello@amd.com>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221228163102.468-2-mario.limonciello@amd.com>
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
Cc: Alex Deucher <alex.deucher@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Carlos Soriano Sanchez <csoriano@redhat.com>,
 stable@vger.kernel.org, David Airlie <airlied@gmail.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Mario,

On 12/28/22 17:30, Mario Limonciello wrote:
> Removing the firmware framebuffer from the driver means that even
> if the driver doesn't support the IP blocks in a GPU it will no
> longer be functional after the driver fails to initialize.
> 
> This change will ensure that unsupported IP blocks at least cause
> the driver to work with the EFI framebuffer.
>
> Cc: stable@vger.kernel.org
> Suggested-by: Alex Deucher <alex.deucher@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

As mentioned, I'm not familiar with this driver but the change looks
good to me. Delaying the firmware-provided framebuffer removal is the
correct thing to do IMO.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

