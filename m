Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE15EB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 09:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B63410E225;
	Mon, 10 Jul 2023 09:52:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 448B210E24E
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 09:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688982737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hthXbFsoXlX0+QosB5hy4EUQeYIx9zOSABWvROS8008=;
 b=T9pvKr/6p1jXxnNSH/P4dKxZAe2B8HZjj0whtGLhJcDyf2UlZFtNv147MaOpg8yBjEJK4a
 tRemgrBrzF4m04mHcBwO87g+mx2ehhA1Xm15Fgyo6K1bGcGgRfZ2uHDFi64Lns0JMAFW4e
 rsOsyn71VhoW2rR0EzKnthCnx47eiMk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-BGHWGSnFNpqW_SaWxE97pg-1; Mon, 10 Jul 2023 05:52:16 -0400
X-MC-Unique: BGHWGSnFNpqW_SaWxE97pg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3144bf68a03so2251464f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 02:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688982735; x=1691574735;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XyjO7rBhUclhrrRCvtGKtbyfJKZVHucBecdHP85gxs0=;
 b=fa/HttoFvK+nOwVIP51TEuWlUisNAi7pGYrKnoqJJJv4SUSqU9U+wR0T3HfjonHOmJ
 piloxwFIJsjtB/DU1EOxeqXGyEGN5apJD7CeVMMnmlhEmZy2UGnt2vIEmDTGkaEMu1TM
 50Q8dNV9y4HEVwuWyopZuD62O89BKDF1Ey1ia4lleEkumPgx8ysz1a4WrCo0ZUiahsfL
 JvMoApzVhUSQ1tSZZg//AJeaBtcbuw047Kb0LCWQ742Chu8hAnczhNNYMGPy7yjNG0Zz
 zqE+NWLbX9IbUi/lcSh3FB9ezyGgC1S1nEtiLd0tVVGklvjqghY6fmSvq1/HMAn+9mHh
 pbNg==
X-Gm-Message-State: ABy/qLbHb2rSfcpsm3phYE3e9peS1o/aj9IdQILPsRcg9lT50cMhy4E0
 aaf0KuL4rVF+2h4aEiDkg2MfYmIeGajj6QVKPFxr45uzuT1ID3JV5jxb4fzAnKDCzo3p4Pop2oC
 c2O03r02z8VFyZHqBwIQ+CUSvvw==
X-Received: by 2002:a05:6000:124a:b0:314:2b0a:dabe with SMTP id
 j10-20020a056000124a00b003142b0adabemr10426003wrx.30.1688982735484; 
 Mon, 10 Jul 2023 02:52:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHaQ/+IdPxGPjymocfW9cv9tWGipFqf6RaAd0AZG/bTyXsaB00iseKuCq4q/hOVcXPiHegqow==
X-Received: by 2002:a05:6000:124a:b0:314:2b0a:dabe with SMTP id
 j10-20020a056000124a00b003142b0adabemr10425963wrx.30.1688982734861; 
 Mon, 10 Jul 2023 02:52:14 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 z13-20020a5d4d0d000000b002fb60c7995esm11286630wrt.8.2023.07.10.02.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 02:52:14 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, noralf@tronnes.org
Subject: Re: [PATCH] drm/client: Send hotplug event after registering a client
In-Reply-To: <20230710091029.27503-1-tzimmermann@suse.de>
References: <20230710091029.27503-1-tzimmermann@suse.de>
Date: Mon, 10 Jul 2023 11:52:13 +0200
Message-ID: <87edlghz5e.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Rob Clark <robdclark@gmail.com>,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 linux-samsung-soc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Paul Schyska <pschyska@gmail.com>,
 Torsten Krah <krah.tm@gmail.com>, linux-arm-msm@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Maxime Ripard <mripard@kernel.org>,
 Inki Dae <inki.dae@samsung.com>, Alex Deucher <alexander.deucher@amd.com>,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 freedreno@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Moritz Duge <MoritzDuge@kolahilft.de>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Generate a hotplug event after registering a client to allow the
> client to configure its display. Remove the hotplug calls from the
> existing clients for fbdev emulation. This change fixes a concurrency
> bug between registering a client and receiving events from the DRM
> core. The bug is present in the fbdev emulation of all drivers.
>
> The fbdev emulation currently generates a hotplug event before
> registering the client to the device. For each new output, the DRM
> core sends an additional hotplug event to each registered client.
>
> If the DRM core detects first output between sending the artificial
> hotplug and registering the device, the output's hotplug event gets
> lost. If this is the first output, the fbdev console display remains
> dark. This has been observed with amdgpu and fbdev-generic.
>
> Fix this by adding hotplug generation directly to the client's
> register helper drm_client_register(). Registering the client and
> receiving events are serialized by struct drm_device.clientlist_mutex.
> So an output is either configured by the initial hotplug event, or
> the client has already been registered.
>
> The bug was originally added in commit 6e3f17ee73f7 ("drm/fb-helper:
> generic: Call drm_client_add() after setup is done"), in which adding
> a client and receiving a hotplug event switched order. It was hidden,
> as most hardware and drivers have at least on static output configured.
> Other drivers didn't use the internal DRM client or still had struct
> drm_mode_config_funcs.output_poll_changed set. That callback handled
> hotplug events as well. After not setting the callback in amdgpu in
> commit 0e3172bac3f4 ("drm/amdgpu: Don't set struct
> drm_driver.output_poll_changed"), amdgpu did not show a framebuffer
> console if output events got lost. The bug got copy-pasted from
> fbdev-generic into the other fbdev emulation.
>
> Reported-by: Moritz Duge <MoritzDuge@kolahilft.de>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2649

Aren't you missing a Fixes: for 0e3172bac3f4 too? Since that's the commit
that unmasked the bug for amdgpu, IMO that is the most important to list.

> Fixes: 6e3f17ee73f7 ("drm/fb-helper: generic: Call drm_client_add() after=
 setup is done")
> Fixes: 8ab59da26bc0 ("drm/fb-helper: Move generic fbdev emulation into se=
parate source file")
> Fixes: b79fe9abd58b ("drm/fbdev-dma: Implement fbdev emulation for GEM DM=
A helpers")
> Fixes: 63c381552f69 ("drm/armada: Implement fbdev emulation as in-kernel =
client")
> Fixes: 49953b70e7d3 ("drm/exynos: Implement fbdev emulation as in-kernel =
client")
> Fixes: 8f1aaccb04b7 ("drm/gma500: Implement client-based fbdev emulation"=
)
> Fixes: 940b869c2f2f ("drm/msm: Implement fbdev emulation as in-kernel cli=
ent")
> Fixes: 9e69bcd88e45 ("drm/omapdrm: Implement fbdev emulation as in-kernel=
 client")
> Fixes: e317a69fe891 ("drm/radeon: Implement client-based fbdev emulation"=
)
> Fixes: 71ec16f45ef8 ("drm/tegra: Implement fbdev emulation as in-kernel c=
lient")
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Tested-by: Moritz Duge <MoritzDuge@kolahilft.de>
> Tested-by: Torsten Krah <krah.tm@gmail.com>
> Tested-by: Paul Schyska <pschyska@gmail.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Mikko Perttunen <mperttunen@nvidia.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: freedreno@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: linux-tegra@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.2+

While it's true that the but was introduced by commit 6e3f17ee73f7 and that
landed in v5.2, I wonder if this patch could even be applied to such olders
Linux versions. Probably in practice it would be at most backported to
v6.2, which is the release that exposed the bug for the amdgpu driver.

Your explanation makes sense to me and the patch looks good.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

