Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B64CA5FA1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 18:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E3FA10EB3F;
	Mon, 28 Sep 2026 18:09:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="PJhbHkIR";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E17810EB3F
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790618969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WblzAY3JRV9CtwzNMKeAP2oGeUzXJbmdjxKWRmzPjT0=;
 b=PJhbHkIRBFID5cswJ92776vll2KD9fgt0nDXJiPT4OZ0f/SvgmDkX8UF87Anx6/UkrWjPP
 5fzw94ZOd6SAHBX8zdIdHM+amGsRhWyLrT6KKRv9c8ZVZev/4ilzX8ghONdSJyg4rG8uGk
 ohi3QePa1nJcfZw2sf5/pvMfBxfM0ZE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-NMAF5cgqMWur1HrvlrLfKA-1; Mon, 28 Sep 2026 14:09:28 -0400
X-MC-Unique: NMAF5cgqMWur1HrvlrLfKA-1
X-Mimecast-MFC-AGG-ID: NMAF5cgqMWur1HrvlrLfKA_1790618967
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49ffbad2c55so13242355e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 11:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790618967; x=1791223767;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WblzAY3JRV9CtwzNMKeAP2oGeUzXJbmdjxKWRmzPjT0=;
 b=gfoQ3hdGuDhLhDhbxYYSN3dV0cBaI/3XZKE1YNYdm2QCozk5xWjpNpBrwYwtpfk+VK
 iD015ca3zM25UJ0x1EZfAIMKj1oOggvAJDh+OzeaOPtGGYA8Hos/Vec+8d41+M4UyXfU
 AkbPLMWahhBPjCxcf8Yqfn+HVOcnBZ/aOjV6zvrnZxPqo0hF+lj5i1upy+URcjdcJfmH
 xxUFH4i4L4ytHAvhWEvLbX6zF7UFwtUE2qZgerA2BFzw6rU8kY4yxQBPBtIP1olkDwRP
 tRS5/hlUauHFkqJR6soVSpolREu3iSA5+I9M8LMeitHwWlhOIWurknZdly7EPxt8rv9k
 elRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4yNQIcwbnAhElDIzBSGOcZX8yOXacA01OvmSwGBDnSA1wgw8LGfZu2S2M3/JitiGOKGDyO1cB@lists.freedesktop.org
X-Gm-Message-State: AFuF++kAIOqbO6XGh5xlT9ysrhsZrPoIE/NLWW3ikrer3gUVQ4WyOE54
 4QHBrFi1RPBRKIUC50ea1fPSifjnjOB+703l0RuL4ljvZ6f8QRmOpaOCH6i23ObRJQ9/x2ldk3U
 6pP5EPQ6Hl2gEoGEqKFEAhYRMpP9LNQduhRcA2fqWkAP/G5FJ2ZBcvjdI6vrwcf1nsP0=
X-Gm-Gg: AYBFou0yIkVngcyMX5u+jBSykO071KVs8wzw/4mxnHu0EYf7U6XYKUzgA7EX5zBSuQN
 wxYXwAOo+DUcllopDH+vVSnpEAwRpT1be4ozCSZq+c2iwaWE/v/rQwaiGdhXfVFhEGihXYRbNB8
 j98fEX3Cq6cGBS2lyWVJcOHifTxRv6Gtwl29v/NbLx/LdX/I8eI2VAgeBeCzaH7ble1RADvIXvX
 kFxIcf5xooomJshcjfVkom1dDchR+/OwX0JVqMlDwM3FvMGOMXClFDkMJ9aDHA1lEgB+6liOVWU
 7LRQGHDeSJFGD+GulSPBQsBeCYHQSBX2DueQDdh2HVgw51F84g7kHXyuOqe2z/WOM1XntKK+lQV
 uRjwHeYdzxRx0qygAaAWAlzTRuR5859EmHokcBJ/UZrmsR2SBHgcTl0iQ9E46MQKDig==
X-Received: by 2002:a05:600c:1389:b0:49f:dcc8:c735 with SMTP id
 5b1f17b1804b1-49fe66f4c7dmr231739755e9.18.1790618966854; 
 Mon, 28 Sep 2026 11:09:26 -0700 (PDT)
X-Received: by 2002:a05:600c:1389:b0:49f:dcc8:c735 with SMTP id
 5b1f17b1804b1-49fe66f4c7dmr231739375e9.18.1790618966445; 
 Mon, 28 Sep 2026 11:09:26 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00d10cb7dsm3533065e9.0.2026.09.28.11.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 11:09:25 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, jfalempe@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, jani.nikula@linux.intel.com, Alexander.Deucher@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org, sashiko-reviews@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>, Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH v4 1/2] drm/fbdev: Move fbdev module parameters next to
 module init
In-Reply-To: <20260928080323.23909-2-tzimmermann@suse.de>
References: <20260928080323.23909-1-tzimmermann@suse.de>
 <20260928080323.23909-2-tzimmermann@suse.de>
Date: Mon, 28 Sep 2026 20:09:23 +0200
Message-ID: <xlv133utfdt8.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n9XgZnpIE3HrpvuJnTQz-jGiGQXhGgdZU6XZFkVMPP4_1790618967
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Define the parameters for fbdev emulation in the source file with the
> module-initialization and exit code of drm_kms_helper.ko. The parameters
> control some aspects of DRM's fbdev emulation. Common usage looks like
>
>   drm_kms_helper.drm_fbdev_overalloc=200
>
> on the kernel's command line. This has been possible for many years
> and changing it would likely upset users.
>
> The emulation code is supposed to be moved into the module for DRM
> clients. Keeping the parameters in drm_kms_helper.ko avoids breaking
> systems the use them in the way described above.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

