Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C33EC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 08:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7346410E81D;
	Fri,  1 Dec 2023 08:42:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA70110E81E
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 08:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701420157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r0SUTWfnIuMyMvbVNiUleFZUEEojlqZ62paYlpowE08=;
 b=fiY/ETUGDv5LhY72ycNJ7bVeEqg3gttLRSQSF6xiEb4DGxXfJYKibw+Q14Vak6v0TsJBN1
 Ugj1U7TxbcM4o6JXhbGU9hNgHd3wNjFaLm1BbIUGPhu+7A1FkYTftpgq65USUFrCNFUMzJ
 v1hzd9Dogr49C+kNs/yFJxMZFBHikUE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-BO3m_-LAMpq7PtVs1HdGJw-1; Fri, 01 Dec 2023 03:42:34 -0500
X-MC-Unique: BO3m_-LAMpq7PtVs1HdGJw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50bba79548fso2180560e87.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Dec 2023 00:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701420153; x=1702024953;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r0SUTWfnIuMyMvbVNiUleFZUEEojlqZ62paYlpowE08=;
 b=Zjw1AMm7EYIsp22imFuYZlrdt9SP3wlAgl4MpGf1PGG0kCFVx/KHa8u4gmS0GtWBtB
 vEXD8bdlK95cBLAdz9+bGclfEpX5uoP9WOHFb13PY5e2wwWwyn+1xHAj4jOnJ/x8f8tk
 wmU7+muo1uKjQHnFogty3SSux0dLMHgqNfazm1ciS111eB7yN9hNQ8GqN8iuIwlliPyA
 6DA3uf+24S4U477rSHBAtEWpduwOA7OKc8oFHB/nKQI7wWw9ZfBhzzmVBCHBtlgx/h7Z
 2ESv3WwmDLuBTzGEusgJhqXtgSaK69EMzcBC6M6K3UKSd/eZYJ6eY9eTdh6rEMGHt1Z0
 K4OA==
X-Gm-Message-State: AOJu0YxT0rOjkrsWMTJQ4gsZ6ibHLFBeVskC4wFqmnuq15/S8tYUlay+
 v4W2J5iDph/kSvBUk8nYGV8G8EVBQub2c206loob52SGB7wUMEDdM4wST+auix9RLhPZPp57MQD
 KKLOvE4AukYt/+Ha7wVpsIZHBbg==
X-Received: by 2002:a05:6512:2203:b0:50b:c34f:581e with SMTP id
 h3-20020a056512220300b0050bc34f581emr616123lfu.62.1701420153222; 
 Fri, 01 Dec 2023 00:42:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENDHPjLiQN61B6qKN5xDZ9Ku0d8jCKVggUUor5+9ZzH4L3f9+qxhGVMI7KzSvI9vjTuqAjlA==
X-Received: by 2002:a05:6512:2203:b0:50b:c34f:581e with SMTP id
 h3-20020a056512220300b0050bc34f581emr616117lfu.62.1701420152928; 
 Fri, 01 Dec 2023 00:42:32 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 b19-20020a05600c4e1300b0040648217f4fsm8339573wmq.39.2023.12.01.00.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 00:42:32 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, daniel@ffwll.ch, airlied@gmail.com,
 suijingfeng@loongson.cn
Subject: Re: [PATCH 5/8] drm/solomon: Do not include <drm/drm_plane_helper.h>
In-Reply-To: <20231128104723.20622-6-tzimmermann@suse.de>
References: <20231128104723.20622-1-tzimmermann@suse.de>
 <20231128104723.20622-6-tzimmermann@suse.de>
Date: Fri, 01 Dec 2023 09:42:31 +0100
Message-ID: <871qc6mhzc.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, laurent.pinchart@ideasonboard.com,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Remove unnecessary include statements for <drm/drm_plane_helper.h>.
> The file contains helpers for non-atomic code and should not be
> required by most drivers. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/solomon/ssd130x.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
> index acf7cedf0c1ab..075c5c3ee75ac 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.h
> +++ b/drivers/gpu/drm/solomon/ssd130x.h
> @@ -17,7 +17,6 @@
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_encoder.h>
> -#include <drm/drm_plane_helper.h>
>  
>  #include <linux/regmap.h>
>  
> -- 
> 2.43.0
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

