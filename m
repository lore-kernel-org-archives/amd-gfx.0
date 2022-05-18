Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1137C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 17:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DEB610E878;
	Wed, 18 May 2022 17:05:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76FF810E79D
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 17:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652893525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TRLEjcaMw89+h7bBWjlXiLnoDwDJpSdbFcWF9EAQdJc=;
 b=NSlUEXmqll1zNGHkpZdxabs3t4gqiGDYCVJPYUdrLh7Z26ajpo1GxUFVtnAXLmnad7rOvA
 c3Rn+E3sMC5I0k6tK3srKt+zvQRHtLOX12R4gekqu7RJlrXT8D32mav49fE/Rel+1yUYKF
 qMDfk5bDsd2fKZkycPZZT3iSAYoj8nU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-d8kAY8pfPYGIEXfx6Nra-A-1; Wed, 18 May 2022 13:05:22 -0400
X-MC-Unique: d8kAY8pfPYGIEXfx6Nra-A-1
Received: by mail-qt1-f200.google.com with SMTP id
 d4-20020a05622a15c400b002f3bd4b80f7so2139216qty.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 10:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=TRLEjcaMw89+h7bBWjlXiLnoDwDJpSdbFcWF9EAQdJc=;
 b=BWBeiuQw2ldkWGy0mt40nMEAFjPdOo9paPoFHtxmh4+oifhnwE2WZhVj2iWpaMuwBo
 isUxHLQMkc8cIIBx8jc4/rt+d7OnErmeyZuCZvam1wnVlS62kbU9PpbUNvsiV8sR6N9p
 xyQh/5ldGsUboyRVM2UiKuUCzNDpczG8c6SnQZNld5tnWEJjHP8umtii5Sa/jtMgfBaZ
 rC9N30QVDiH51G9q1Z93t/jH7O2jcKxXx1mLevTTTe/qA5OoWpNuI71xywznOR8yPL/C
 eK3ruJLo5ssphpGzwnLHPgvTEPMLTB7/1GMHv0GWSN2g+F3oJZ/lkAx/SNjD3F+aFjea
 4NPg==
X-Gm-Message-State: AOAM533bNhFw2qs3fQpLaqsa7GHWgRXLfNwx82rO+dzrP3QWBn3eHb5A
 ZN0j8yuWRN90ZLVuQhNBDOS6hC2N2hHTdeGeAnF92rwPjWONICYrfewYzweO94BNAVR26sFSn/5
 xCX2Hwz9hsuiFw2OIEeYKjO6KIg==
X-Received: by 2002:a05:622a:13d2:b0:2f3:d2aa:7c5a with SMTP id
 p18-20020a05622a13d200b002f3d2aa7c5amr688815qtk.155.1652893522086; 
 Wed, 18 May 2022 10:05:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWXT+ucokDAqDDNsvHx45rk/kOMhw7MyDKCGHWLD4jc69TnlXtDtdyumDrgdXUe4O3YCGvOQ==
X-Received: by 2002:a05:622a:13d2:b0:2f3:d2aa:7c5a with SMTP id
 p18-20020a05622a13d200b002f3d2aa7c5amr688757qtk.155.1652893521745; 
 Wed, 18 May 2022 10:05:21 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net.
 [71.184.137.158]) by smtp.gmail.com with ESMTPSA id
 u24-20020a05622a199800b002f3ce9c0601sm1719763qtc.3.2022.05.18.10.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 May 2022 10:05:21 -0700 (PDT)
Message-ID: <e67e2a183d40181420a3536b0a400161357aaee6.camel@redhat.com>
Subject: Re: [PATCH 05/14] drm/nouveau: Don't register backlight when
 another backlight should be used
From: Lyude Paul <lyude@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, 
 Karol Herbst <kherbst@redhat.com>, Daniel Dadap <ddadap@nvidia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, Xinhui
 <Xinhui.Pan@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Mark Gross
 <markgross@kernel.org>, Andy Shevchenko <andy@kernel.org>
Date: Wed, 18 May 2022 13:05:19 -0400
In-Reply-To: <20220517152331.16217-6-hdegoede@redhat.com>
References: <20220517152331.16217-1-hdegoede@redhat.com>
 <20220517152331.16217-6-hdegoede@redhat.com>
Organization: Red Hat Inc.
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
 intel-gfx <intel-gfx@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Len Brown <lenb@kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Lyude Paul <lyude@redhat.com>

Also, ack on this being pushed to drm-misc, along with any other patches I r-b

On Tue, 2022-05-17 at 17:23 +0200, Hans de Goede wrote:
> Before this commit when we want userspace to use the acpi_video backlight
> device we register both the GPU's native backlight device and acpi_video's
> firmware acpi_video# backlight device. This relies on userspace preferring
> firmware type backlight devices over native ones.
> 
> Registering 2 backlight devices for a single display really is
> undesirable, don't register the GPU's native backlight device when
> another backlight device should be used.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_backlight.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> index daf9f87477ba..f56ff797c78c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> @@ -34,6 +34,8 @@
>  #include <linux/backlight.h>
>  #include <linux/idr.h>
>  
> +#include <acpi/video.h>
> +
>  #include "nouveau_drv.h"
>  #include "nouveau_reg.h"
>  #include "nouveau_encoder.h"
> @@ -404,6 +406,11 @@ nouveau_backlight_init(struct drm_connector *connector)
>                 goto fail_alloc;
>         }
>  
> +       if (acpi_video_get_backlight_type(true) != acpi_backlight_native) {
> +               NV_INFO(drm, "Skipping nv_backlight registration\n");
> +               goto fail_alloc;
> +       }
> +
>         if (!nouveau_get_backlight_name(backlight_name, bl)) {
>                 NV_ERROR(drm, "Failed to retrieve a unique name for the
> backlight interface\n");
>                 goto fail_alloc;

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

