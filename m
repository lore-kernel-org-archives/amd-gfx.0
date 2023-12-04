Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B8AC4167B
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Dec 2023 09:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C34A10E03B;
	Mon,  4 Dec 2023 09:42:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC42E10E03B
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Dec 2023 09:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701682927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VaGns7gznEtfoHG5/ry6CysbEWdXBIzB19dd6KHGP/0=;
 b=JMuUwN17bgNa8uEO1pN8D825Ltylh7Yo0/qLXGgRwhfKN1TU8pqX+OhSOXKuJjy0PdbiPw
 uFA3dPK0HMUjs+x+xnsPZRC6IzkLl2pK6qHPnjeVnF4AajbnKpsXxqSs4omFSWlwTedqS4
 A2CAYyfpgNiG2V3/RATjmOVEYAhjSIQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-7cZea_4sOSaRQ3OUog5TtA-1; Mon, 04 Dec 2023 04:42:03 -0500
X-MC-Unique: 7cZea_4sOSaRQ3OUog5TtA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3334e56554bso363195f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Dec 2023 01:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701682922; x=1702287722;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VaGns7gznEtfoHG5/ry6CysbEWdXBIzB19dd6KHGP/0=;
 b=jkf/6EpKxnvzkc6LuPjJ8Ey8BMzs1c/Z1qrYJrSzp/O1tT1Xyhto4lOkzIFzIhriym
 rXEbV9oB0wJwkSxkRpPecXP3EcFy9s4lZJ6ovbRQA6/JFKrNK91fmsLxDNqk5FdKseWR
 9MasapQIL7unMd61fKhlIPOZrOJ6dJ8wYzIQENH6EXMzgO00jrvkpTn2VTTZhuAxBFof
 toMjuZtUC8yr4G72iE9xMvVHfYhjqFDx74drFwhPLrWpgLDw7iwTYzGdCyheHZym+EgK
 1IrHxa+PjxdKscUYFaLpX3eMgjtY86TCtX1nWaNgPspjq2ZLYPmaAZo+EDGLrM/xoDsW
 TTiw==
X-Gm-Message-State: AOJu0YyLfWUjilW7L6uCLKA8zyGlInMmXFGwnb+yHhLNDUstDPKQY7ar
 HnCIYDDHeDcxAORULX3CKe6oQnmkLlnJ8Jlbmy1KYrqqtliSkgPODTDLxW3bc/W79jaPctI8SeF
 cQJbinobOSqY+79LZHCx4Du1o3A==
X-Received: by 2002:a05:600c:230c:b0:40b:5e21:bde1 with SMTP id
 12-20020a05600c230c00b0040b5e21bde1mr1992496wmo.112.1701682922727; 
 Mon, 04 Dec 2023 01:42:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKbDMlcSZRmYxfwIMqNYsq1c9B1PO0Imfj1CH1zWIpq+H+b1PJuusoLSRaiunDJaNEcQNA8g==
X-Received: by 2002:a05:600c:230c:b0:40b:5e21:bde1 with SMTP id
 12-20020a05600c230c00b0040b5e21bde1mr1992482wmo.112.1701682922357; 
 Mon, 04 Dec 2023 01:42:02 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 p23-20020a05600c1d9700b0040b3645a7c2sm18214724wms.40.2023.12.04.01.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 01:42:02 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, daniel@ffwll.ch, airlied@gmail.com,
 suijingfeng@loongson.cn
Subject: Re: [PATCH v2 7/8] drm/simpledrm: Do not include
 <drm/drm_plane_helper.h>
In-Reply-To: <20231204090852.1650-8-tzimmermann@suse.de>
References: <20231204090852.1650-1-tzimmermann@suse.de>
 <20231204090852.1650-8-tzimmermann@suse.de>
Date: Mon, 04 Dec 2023 10:42:01 +0100
Message-ID: <877cluxq1i.fsf@minerva.mail-host-address-is-not-set>
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

> Remove unnecessary include statements for <drm/drm_plane_helper.h>.
> The file contains helpers for non-atomic code and should not be
> required by most drivers. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

