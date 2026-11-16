Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E07606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O1AnTKFW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D67C10EDF6;
	Mon, 16 Nov 2026 09:39:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC86510EDCB
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 09:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794821949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vfDtkcqPvV+2k9dyjsvEmJCR0/Gq1KXbglEhzSUqmq4=;
 b=O1AnTKFWUVRJ7V8m/Mc5V1a+Hw3vl4fUuCA9btUbSLYSZDLksZbzCGh2XXI2tVkMC/nZ1M
 qbNvh4LKNAqOcpY+uBXXyDNyyMMDY/A4Haf99gA+NbupV67A1bT9RNgmiW7cVZzSpCsMq8
 mOM5IX831/fv8jxOTZDUptIAovJQvFk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-x0tURa00Pf6M1kwzKfoMVw-1; Mon, 16 Nov 2026 04:39:07 -0500
X-MC-Unique: x0tURa00Pf6M1kwzKfoMVw-1
X-Mimecast-MFC-AGG-ID: x0tURa00Pf6M1kwzKfoMVw_1794821946
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4916d47eeb5so3140495f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 01:39:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794821946; x=1795426746;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vfDtkcqPvV+2k9dyjsvEmJCR0/Gq1KXbglEhzSUqmq4=;
 b=kk+TeqpjJcTM9cV0kcciQN7nBz0mLa8PVfRc+N2EZeIOCDnwcplHO6XbiEB5nn0dBy
 WVJ8x4yMVauvZ20/IAMzT0xj7wW3xKD+iHF2KAjftUIIimUHTVXcqQhrmfV8f7uYQRQO
 HiAupLYt+XUyzqgYB4Qy1at6ANFquw0mwhi1ok0QqPw2eaDfKxspjPyy3A7Lq4/ySPGe
 d3OIkq6EVgOGiQZCwLKE7beGI1sMtaCkAiH/6WAJAGmdNAF4/8SmveMygU2vWUafQzWh
 c/HTC4+gTqnwl35/DlTFxfQ8RQWLC9u4nwklkn90rMQL937WBpIQwnq+3IdZ30LHOUYp
 1Vhg==
X-Forwarded-Encrypted: i=1;
 AL+hErHx2jluJdz4xokXdAoOHOBW2gU7SZajYlRPNIBgoFVa5XC9rxkY9GHxiO5CQrTMuSawXJL1JfzF@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+zUiH94ycnzCRTh4DCthpVUJC+g7WxU0XmSIPp6loDonk+VHv1
 mo+pGOYpEoGJ6wFS9ncqyfIT8IK/30tduofozGolfP/bd2HMgtGPNsSkzzds37aFdxAA9VJhxBV
 hABluXM+joD+7rvt7JibepQPoxQf8tzPw64k1c6p9misXQoj4J7ICSC89GR8atyA1zQg=
X-Gm-Gg: AZFdTZeVPtgF7E8cFmohInzONEZPibPQlPmyEp22aNksKKGRc433e2a6Nfj7jZEPEGO
 XO3+OU5fpsuG5XjHJaiZtu4Wx+YO+2my+BQknFR4uYO2Roy/jiBN0YWwztPJy5ccpLC0d64pfPq
 /hxw0hdt3m+xCJ/9zIYSdaYI8Tpky6nju4kpehxmWIxht5jxok36nVfVw/Y+CFO0iGYlHS6XVdx
 vAr6n8KLm+evSWa8r2qdJyjkyGDjNkrTWzOt+GUkqN00wJxdKbgAYOgVVA/7wdCR4n5qJwXxmll
 9F2B+GknQJDfSHVsnY8uJAbbh2CTorokKnFxzP4ad7qhLC0I2IsQOhNbUBmRAsvWmrPdsLqP6hr
 QEhpRMoyPSlMme+SHhOuj7P+K14LMrdWBLvTIAFdHAVEsYrdVJnwXBiQoxpC+Rx6cd1K8FjCPn+
 z4jmHc2nHVsSqc9sPYMQuA9OGWb+wKzur2CyjyWa8=
X-Received: by 2002:a05:6000:25c1:b0:4a1:486b:4eb9 with SMTP id
 ffacd0b85a97d-4a1486b53eemr6359111f8f.40.1794821945600; 
 Mon, 16 Nov 2026 01:39:05 -0800 (PST)
X-Received: by 2002:a05:6000:25c1:b0:4a1:486b:4eb9 with SMTP id
 ffacd0b85a97d-4a1486b53eemr6359053f8f.40.1794821945065; 
 Mon, 16 Nov 2026 01:39:05 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c7da37b19sm21564920f8f.5.2026.11.16.01.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 01:39:04 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Jani
 Nikula <jani.nikula@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, Leo Li
 <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
Cc: Mario Limonciello <superm1@kernel.org>, Xaver Hugl
 <xaver.hugl@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: Re: [PATCH v11 12/12] drm/solomon: add SSD130x connector luminance
 support
In-Reply-To: <20261103-superm1-backlight-property-v11-12-00cce7b2ba22@kernel.org>
References: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
 <20261103-superm1-backlight-property-v11-12-00cce7b2ba22@kernel.org>
Date: Mon, 16 Nov 2026 10:39:03 +0100
Message-ID: <xlv1ik1xru88.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C5Pe9iSw_hrPQq8pKRgUzvNLdiMAMqf6rXH8_f_sXA8_1794821946
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Mario Limonciello (AMD)" <superm1@kernel.org> writes:

Hello Mario,

> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Expose SSD130x contrast through the connector LUMINANCE property when
> DRM_LUMINANCE is enabled. Program contrast directly and register the
> backlight class device only when DRM_LUMINANCE is disabled, so contrast
> has a single owner.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v11:
>  * Keep selecting BACKLIGHT_CLASS_DEVICE and drop the guards (Sashiko)
>  * Register the backlight device only without DRM_LUMINANCE (Sashiko)
>  * Initialise the controller with the committed luminance and don't
>    clobber the saved contrast on disable (Sashiko)
>  * Skip contrast writes while the controller is powered down (Sashiko)
>  * Unify contrast dispatch and backlight ops (Sashiko)
>  * Drop Reviewed-by due to the rework
> v10:
>  * Guard the backlight operations and registration with
>    BACKLIGHT_CLASS_DEVICE
>  * Fix Kconfig recursive issue
>  * Add the Reviewed-by tag
> ---
>  drivers/gpu/drm/solomon/ssd130x.c | 149 ++++++++++++++++++++++++--------------
>  drivers/gpu/drm/solomon/ssd130x.h |   2 +
>  2 files changed, 98 insertions(+), 53 deletions(-)

[...]

> +static void ssd130x_connector_set_luminance(const struct drm_connector_state *conn_state)
> +{
> +	struct ssd130x_device *ssd130x = drm_to_ssd130x(conn_state->connector->dev);
> +
> +	/*
> +	 * The encoder enable already initialized the controller with the
> +	 * committed luminance. Skip if it failed to power up the controller.
> +	 */
> +	if (!ssd130x->enabled || ssd130x->contrast == conn_state->luminance)
> +		return;
> +

Is not clear to me why you need this enabled field? I would prefer to not
keep that state if possible.

The changes look good to me though:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

