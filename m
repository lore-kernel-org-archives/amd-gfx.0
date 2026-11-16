Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4BC606A323
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EQi6iuTn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C43D510EEA1;
	Mon, 16 Nov 2026 09:28:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C567710EE8E
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 09:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794821295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6O5L7vNOw9tqxoH8eLe9M+49Omq2w8inLzq+ECt/NxU=;
 b=EQi6iuTnvi29ZDWFp6z8eqBLsFMcNU/OC0jKSK/t+Q+kayyQzWMTexx9YzmAI/KNX6qik9
 xkWN1dmcKdVGShs36VrocPjDhTQ4O9TmiIUl/Z0WCTpYmcSHFla++MVDr5WNUO0ajom4Lq
 nmhwVeZ35obYIaa03o1wUeUBOEMhFR4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-FDsC7xSkMamhCXYMncUA0A-1; Mon, 16 Nov 2026 04:28:11 -0500
X-MC-Unique: FDsC7xSkMamhCXYMncUA0A-1
X-Mimecast-MFC-AGG-ID: FDsC7xSkMamhCXYMncUA0A_1794821290
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a1fdde384cso14122105e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 01:28:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794821290; x=1795426090;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6O5L7vNOw9tqxoH8eLe9M+49Omq2w8inLzq+ECt/NxU=;
 b=ajhLU0436TZhCnJ7idXTeL+GWaU+t0HErjQVEhm3gT4gc435fz/D/BFx+mgRUN6t6v
 ksZpLzpue4BeMcmQKRGH/8ZMPeN+YQqNJVD2SRBwfOMq8Ozj2pMqCeJGjxE1GlWZfHb0
 HzPLgW2lTKSFkNLopuOvURnvJVAGxKh38EeUCUJFwznTGXrcRR/90RUTTr5pBcYSckE1
 GV/TO8YsnH2wa6AiAGXeaTFIx71mXEPAQBkaEDSmIwO76ICvp3Newcmaqqq+/XJAZjr+
 LK/KxJnKnP/93entYCL3FE/Jrb7ehsyPwWpnroRrLenLDNn8xLFczJ9ZdtoiF1iekWnd
 ZY0A==
X-Forwarded-Encrypted: i=1;
 AL+hErE018q4KoFUVhn3qWKmVjp+VYU8VViVnlaek/weESmowDLHEyyg35yM9KQ3wx8k2lTaFr0mpGGZ@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8VA189JlAM+Q8mCgiqSWQWKM15bvoeTf4Pwfnqt//fQaIjarke
 ymp/5lce+FRBt0VkA8rvn2TH9CvOm0+fmHZ5r9h4JuRbDpRRdYqkceWELA65cShw2ZhMVD6/gHH
 VhWe5zWFbOFfZ8/dQIE7wM49QscC+77EOXvD8sO+B01/10IOcx7TqlRO/K2D2nlIHnMM=
X-Gm-Gg: AYBFou0WCec3XvoJEy0YSzxj/WmCWzosggLut8x/tZ31fFngKL2z0qVuEsNAP18OXU8
 g2Hx2tvuzDoNGInEYkrMBgEewPWMepkBgKRCecTw7RK5p38BfJAnzSnuJwzvFQz+BeJojqgJMzo
 9d4PxPMpiC6hkeLKgqqN7FynMQKtq7YcGQ9EK2oGvw0xnRt7bG0anwC6T3K6qoTNCN8+gBcnURG
 XSluaDGM//qwhsAdLVFdXeH1uMCjNZtZQOnASSwN5dzzRL7fq7Mc/wAU3QKIg6SfSvuMJ+TnWlh
 NBYBEPEA2OpGLCm5qB7Nj7KjexpdJ8jB1j7YgK4vegIWb5CdwhNMZn9/ToCZlGkT/yJXSpY3SiJ
 Z4C/tZwn+o8+4Jv85qy77TdtRZgjdirDwZo74BkTLEV6ZniyIQBvc7gorLK/tdKeQIeAUm8E737
 BUQhKN3zp4yi6nTVsAAX/Ac3bdAP8qxwJnndxcarc=
X-Received: by 2002:a05:600c:1993:b0:4bb:659c:b8db with SMTP id
 5b1f17b1804b1-4bb659cb9e8mr125482045e9.12.1794821289832; 
 Mon, 16 Nov 2026 01:28:09 -0800 (PST)
X-Received: by 2002:a05:600c:1993:b0:4bb:659c:b8db with SMTP id
 5b1f17b1804b1-4bb659cb9e8mr125481505e9.12.1794821289312; 
 Mon, 16 Nov 2026 01:28:09 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5720f6basm139362015e9.4.2026.11.16.01.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 01:28:08 -0800 (PST)
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
Subject: Re: [PATCH v11 08/12] drm/bridge_connector: add luminance support
In-Reply-To: <20261103-superm1-backlight-property-v11-8-00cce7b2ba22@kernel.org>
References: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
 <20261103-superm1-backlight-property-v11-8-00cce7b2ba22@kernel.org>
Date: Mon, 16 Nov 2026 10:28:07 +0100
Message-ID: <xlv1o6bpruqg.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x1Tw1MudzZOVs9kxyzEGuCgiA_aQt-pM2fteFEkEifs_1794821290
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Mario Limonciello (AMD)" <superm1@kernel.org> writes:

> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Discover the last bridge in a chain that owns brightness control, attach
> its relative luminance range to the connector, and forward atomic
> luminance updates to it.
>
> Do not infer panel luminance support from a terminal panel bridge. Panels
> still have direct consumers, so their connector integration must remain
> explicit.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

