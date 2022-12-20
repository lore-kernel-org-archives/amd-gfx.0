Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F581C10F1E
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 09:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A8B10E34C;
	Tue, 20 Dec 2022 09:18:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B67210E34C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 09:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671527905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CYPgbcL3YuPfVJ8jSVJcJdgIz73ia329cUV03P7B6jw=;
 b=bOUsTSXOlMEW133RLX9MsRAB4811MCey9OTVJnaZ3eEA571/b9gwHV5B6WNXf7edkud6xs
 liub5ALFpBwL4WsnGXAk11X1xIusxqBUe/EhDYsNZng3mc4Vtk8L9wkFIzNvPr8S7+wvi8
 YSK7xkp65bgbPBvFto8A5VDC6mv4peo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-65-6aNIqoJXNwmhw0CyVTOd4Q-1; Tue, 20 Dec 2022 04:18:24 -0500
X-MC-Unique: 6aNIqoJXNwmhw0CyVTOd4Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 i13-20020adfa50d000000b0025f5084b95dso1145074wrb.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 01:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CYPgbcL3YuPfVJ8jSVJcJdgIz73ia329cUV03P7B6jw=;
 b=ppHRm0x29nRITIMFqgihf96wyTODGJ+yXh3XwerpXoJi190mT1FB4vhs+TBgqJnSgP
 R01zdrJRoIgakklTILfrWn5e7glMxqBfhuZ2hSgFyd0gUAnOQFsGZXy3WIhoRb/6I90L
 kJXi083X7xbO873pNYzuHtFY7C2Fln+vMkJ3UZQxKcaUMb+MNwJv7YQE1nP0mFCcNByJ
 P9ZydWp5rCWamywa7/qXlxd7CBfo/lqpNe9V6Kms0iu8hcqnhxfD0emVrXuT8AU6I/QD
 psk+e2IYwILiJuE7GtkqsCkPfjn/Sv7cSeIeFy+Vz7i7KuI1hqShgOcJytk1+JeQVdao
 48OQ==
X-Gm-Message-State: ANoB5pma9mhxgMqkIHE10Vnnl3SXN0fusUF4QtcZuhmYTKaCKxt019yG
 hFgOO3sJQ4fJ4Cz0OGewhEJiqPejpKSZS7/C7Xhs3Ud5XeSpy1hp4fY7VvqmbvT+yGHtu2EQcno
 f2z+yYGnH4z2migs3buFQu5aTlg==
X-Received: by 2002:a05:600c:4688:b0:3d0:480b:ac53 with SMTP id
 p8-20020a05600c468800b003d0480bac53mr34783510wmo.12.1671527903074; 
 Tue, 20 Dec 2022 01:18:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7a6jFw63UWWlEAcRGouWqv0+PyfmsRgEqFDZ0lDKi9NgqR6nR2LVLem8I8AFhmP6J9qXEYGA==
X-Received: by 2002:a05:600c:4688:b0:3d0:480b:ac53 with SMTP id
 p8-20020a05600c468800b003d0480bac53mr34783491wmo.12.1671527902879; 
 Tue, 20 Dec 2022 01:18:22 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 f24-20020a1c6a18000000b003b95ed78275sm14622837wmc.20.2022.12.20.01.18.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Dec 2022 01:18:22 -0800 (PST)
Message-ID: <3593e206-7c89-5cfe-1aca-d805ca76135e@redhat.com>
Date: Tue, 20 Dec 2022 10:18:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 03/18] drm/gma500: Do not set struct fb_info.apertures
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-4-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-4-tzimmermann@suse.de>
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
> Generic fbdev drivers use the apertures field in struct fb_info to
> control ownership of the framebuffer memory and graphics device. Do
> not set the values in gma500.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

