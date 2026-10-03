Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB04CA5FE3
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2026 11:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58B4210E882;
	Sat,  3 Oct 2026 11:03:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="NO8XbQ0F";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60ED510E882
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2026 11:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791025399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7CGE6fSevJn03ZxUp3hLxD+nUmt71trIKNdG07R2pFc=;
 b=NO8XbQ0FPtlUS2D2PvySdXnS5KBQdd5RbXbq56RbhVx3Sy5UlUVTlVhUWH+hJh42kwzDYm
 6V3DCkDBBdGqVPz+QEdzdFcopKZSlO0orpCII9FHqNMCjTE3+6OBBW2PGJlcBBUUCCDURH
 UGcauTOSpUsr4ZM+fXCBW5izqbBFqJ8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-v1v2aPxSNF-SpqZyxj89XQ-1; Sat, 03 Oct 2026 07:03:16 -0400
X-MC-Unique: v1v2aPxSNF-SpqZyxj89XQ-1
X-Mimecast-MFC-AGG-ID: v1v2aPxSNF-SpqZyxj89XQ_1791025395
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-486e8fb7d75so138450f8f.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 03 Oct 2026 04:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791025395; x=1791630195;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7CGE6fSevJn03ZxUp3hLxD+nUmt71trIKNdG07R2pFc=;
 b=BL8zbeXD0yd91XYc1/P/QloLRDQkDco9hcjO8QCDMbQ++jJuAiPAFD8fPWGIS/ShME
 QSHw96ZiHN64JvW1scWSC8K80shJ3c+Fj28/No9Jw7ZCD+uvFrEg+d6l7w5kE6oopW94
 /6sMN5e8tE7P5YIaQwGRvT8sB54yZfxEZQ9oUPQEBWxCEsrLElnY2LQD28AZJPy/cgIX
 vlqUxNM7wTKSEisqfVgmrVrd70n7lnoa/MkVLarPn1y+st8dibTB66rEfbS484S/GABz
 BdsNVR5pdgIVDPZihWqIOcwTjYYgcOa/p7kshaOUI4xQGYE/M0d3OapKTIbZhhlFjTPB
 xL9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwt/Nh+TJFnV6eCTgJaZ3Piypxb+CfvOjnK+9m1xQ0upAxFf40u80Q2NK3XTaERfKgM7ADi3+GN@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK6hPjL8k6wZbT6gRHyrUGcKUKz/VKtkWEoIpl9XZZ7WzTrdwz8
 GtvneHJBYhSl5CUsTgzpZ3ItiknDve5Vj/qPrcGAD3uf+DZrM9HSDJN4WX7mVK0gnaU5ATtz+We
 04qPLYcDLTZkQRQFsVQdYOjIwobJGIoFw7RiYiIIi9SKOq6tAgI4GK7v7/ZHlOnuhhOU=
X-Gm-Gg: AYBFou0w2dxfxDSu/IAIAJgSH9zFb3NTfQWUY/7pSNBupXx7Db/a3261f5H8ZIjNLe5
 9MQN+N70DRbMarGiaeV5gjGcDerYJ4P6GvvB6QcZFQ/0zqz6MeK0AdZw+ifOzfS476/9oW7Ot3Y
 Zi8iEjx9kB0FQeHcRoTjVWxRWWyS8ncAMTC2thZRtATdM7fxgawJYkNKwZic7fh7lJJOc8smBdk
 fN4gYmhbok7CKzlPj1rFr7Fgv2w18v308lJ2x35nVY41IwMbl1puepOvDBTGdwBMzlnd5B3BBVZ
 uwiqfiayIpTf+V5AlcIt/Z+at6y1ix3lY5xpJ/gLR0SWG5Clt4JKU4bR3eyDcdeHdqAfSjXIx/U
 ZJ/k9qYiOSqfOTvewxWodatt+Xh/2fCqtUvJWTlPdUUpLLI5mUCFuVklwh/pqO4t/zg==
X-Received: by 2002:a5d:6f01:0:b0:48a:fdde:5241 with SMTP id
 ffacd0b85a97d-48c47fdf4c3mr3224373f8f.31.1791025394946; 
 Sat, 03 Oct 2026 04:03:14 -0700 (PDT)
X-Received: by 2002:a5d:6f01:0:b0:48a:fdde:5241 with SMTP id
 ffacd0b85a97d-48c47fdf4c3mr3224335f8f.31.1791025394453; 
 Sat, 03 Oct 2026 04:03:14 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b82253dc9sm11935413f8f.3.2026.10.03.04.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 04:03:12 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: Re: [PATCH v9 08/21] drm/mipi-dbi: add connector luminance helpers
In-Reply-To: <20261002190030.211356-9-mario.limonciello@amd.com>
References: <20261002190030.211356-1-mario.limonciello@amd.com>
 <20261002190030.211356-9-mario.limonciello@amd.com>
Date: Sat, 03 Oct 2026 13:03:11 +0200
Message-ID: <xlv1ld8fgi6o.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 97C0eUczn-dCwJSQZTgnMeF9tB36aa4_kDs6nEyJymo_1791025395
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mario Limonciello <mario.limonciello@amd.com> writes:

> Add common helpers for MIPI DBI drivers to attach the connector LUMINANCE
> property and forward updates to their backlight backend when
> CONFIG_DRM_LUMINANCE is enabled.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

[...]

> +int drm_mipi_dbi_connector_attach_luminance_property(struct drm_connector *connector)
> +{
> +	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(connector->dev);
> +	struct backlight_device *backlight = dbidev->backlight;
> +
> +	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE) || !backlight)
> +		return 0;
> +
> +	return drm_connector_attach_luminance_property(connector, 0,
> +					backlight->props.max_brightness,
> +					backlight->props.brightness);
> +}
> +EXPORT_SYMBOL(drm_mipi_dbi_connector_attach_luminance_property);
> +

Drivers that call drm_connector_attach_luminance_property(), make it
conditional with if IS_ENABLED(CONFIG_DRM_LUMINANCE). I wonder if
should be the same for drivers calling this helper.

That is, instead of bailing out due !IS_ENABLED(CONFIG_DRM_LUMINANCE),
to make drivers do:

        if (!IS_ENABLED(CONFIG_DRM_LUMINANCE) {
               ret = drm_mipi_dbi_connector_attach_luminance_property(connector);
        ...
        }

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

