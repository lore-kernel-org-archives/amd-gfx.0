Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C736AC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 09:37:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0058A10E35F;
	Tue, 20 Dec 2022 09:37:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B4CB10E35E
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 09:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671529057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bHxLfE6qRmbmJ9vfsWvWUlnwpkYhHXJKMmhBNnZCVw=;
 b=gqLwjS+0HFrY6dwz4cyw57xPjgD+5ztn3YeeOHMopE7Jp9cQ35lr1XSjNOsQQok4vhZa/z
 tw9FfdugHbB0JCfbh8J/EvzH1AKg2uJPauiiQYtMeYhIc++YdIw5vTGP9SSz1NlheEfj8m
 guESQCRgiYsG9jJYWnHHWCF9aX9LQvw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-56--Ld7Sy-1P3qH4DrF5rLX8g-1; Tue, 20 Dec 2022 04:37:36 -0500
X-MC-Unique: -Ld7Sy-1P3qH4DrF5rLX8g-1
Received: by mail-wm1-f71.google.com with SMTP id
 c1-20020a7bc001000000b003cfe40fca79so2403111wmb.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 01:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4bHxLfE6qRmbmJ9vfsWvWUlnwpkYhHXJKMmhBNnZCVw=;
 b=K2Dejntj5GpwvWzZchMM68pcm3gAfOTmKfErcg8/0u/fvQDSL9BkSkaRNGo2mcAx1l
 EOHGiAVlOShP6qdsPvhbg/kr+CB0UBp2ETfmtxzL70Ny5sqBODxIEv83owdrM0v/4v1p
 f+GgEdbXnnQATamO1VNTEhk7xJg5jM0lgpDELmnCdb7WwYtZGPNTJBwRVDtdJo7vKr7/
 rR36WlfXYPnDI+FoQTn72aKTd4LQ55Z0WylTXdLKmL1vzhS346b75pjVNbwdpb5YOQXh
 Xt+YtsAtM3xgZPG8KhNDaxyLVZkEzxuusp9/lTFijEPADwqjX/BZn7t2A3nqNhP3+0tV
 R1nQ==
X-Gm-Message-State: ANoB5pkkUy3VTAJ44rQFQdIxKhwLvCTAZgFzlcLBCESrpCWfk5VzFEyA
 ZEK31occVm8Crmw2ZogFqKzbMDDFiM3dihrpRkC5OjPo0ZiO6yQEhXuVoa69zeDIjgdZjbPl7Nd
 Erlb8zo+EsNi5Er6/kGhRpaNmNg==
X-Received: by 2002:a5d:6f11:0:b0:242:70f0:9196 with SMTP id
 ay17-20020a5d6f11000000b0024270f09196mr33065565wrb.45.1671529055089; 
 Tue, 20 Dec 2022 01:37:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5A94U6u6cGzamMmT1GgT+wuXQtFEvsTtiTSWk5LQnUafJiCwGKhccUzi3oD1XqGmcmR4z97A==
X-Received: by 2002:a5d:6f11:0:b0:242:70f0:9196 with SMTP id
 ay17-20020a5d6f11000000b0024270f09196mr33065558wrb.45.1671529054902; 
 Tue, 20 Dec 2022 01:37:34 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 az17-20020adfe191000000b00241bd7a7165sm12231930wrb.82.2022.12.20.01.37.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Dec 2022 01:37:34 -0800 (PST)
Message-ID: <6a6e3bfb-d320-8ccf-f047-55999552c8fc@redhat.com>
Date: Tue, 20 Dec 2022 10:37:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 12/18] fbdev/offb: Allocate struct offb_par with
 framebuffer_alloc()
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-13-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-13-tzimmermann@suse.de>
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
Cc: linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/19/22 17:05, Thomas Zimmermann wrote:
> Move the palette array into struct offb_par and allocate both via
> framebuffer_alloc(), as intended by fbdev. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

