Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F2BCEACEF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 10:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA9BF10E33A;
	Mon, 17 Nov 2025 10:19:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="F8d9Z8eN";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D06DB10E340
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 10:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763374784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Sj1yzB+yodW9emJVWyrm3VZBnBWrcQvlOUnMxJLYhU=;
 b=F8d9Z8eNtsXXt+aH06QSLZJBjfNYAr3S0nI+6M9kfZbnxql9ho1cc6zyRYrn7vJL0LwC4J
 DbWwPODziEgyo0lMgVuNxM23hv/RJ3VfPTwHxAbp3UvH7GB4UyLzFAV1aX9JENl9VMjRbA
 5TZIhEho/TzyO84ipci5sil9QemLd8M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-CikVu2Q9ML-2mj1QMOVNIQ-1; Mon, 17 Nov 2025 05:19:42 -0500
X-MC-Unique: CikVu2Q9ML-2mj1QMOVNIQ-1
X-Mimecast-MFC-AGG-ID: CikVu2Q9ML-2mj1QMOVNIQ_1763374781
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b3ed2c3e3so2938587f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 02:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763374781; x=1763979581;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Sj1yzB+yodW9emJVWyrm3VZBnBWrcQvlOUnMxJLYhU=;
 b=AaTUMVz1q0KLkbNV6R+LLdF9eSbeHCZMGAGmO3BJ5CmjeCHG8/XdL2pxqq4fkOrV9+
 Ladtomz5KkkbjLuaNSDCj5koy6l04df+2eZID1CEcYHI0FOVBfEs7SUVmpIv/KtUp2r5
 1bhM6LxH8cZFzPA80wC2EQpfccXH54iDNbsLLgSuOXoQBtipyltfXphp6HRVdW54VoI0
 pYQunG6HThQordYGTG/XQJir6T+vJkS2uGUxpbf9AWQCgJb95TZqxVna76xOh0B3OcrM
 UJh/GePUKv2RTvLsu78wftGghoMdqfmbFRn13lKliYq7Ip1E3vTRakJdBtBuTflyUhd7
 geeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVieqPRDO19381WBIN+7HfCEtLI9KGMeLkXHVxSpOkmdVz9drexCjX1vgkHMfqa4yKoWc1Htja5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzO5KLdVrws64G5f6+fBw/+Ama2uYbgi8KFdzbnlci7Owh/U9P4
 dTdpgTp10wZ0gMVjHBtGHd1EhRM25P+1U2EprnORAJOuF8QwAt8JjD4emp8Ng1c9hv43AVsq548
 SSMNoC7QsGAvnywdX8n9dNU/Qllddq8EQRG549tF50paZ8Hedmit6o5naxtuVzZ5TWWk=
X-Gm-Gg: ASbGncuw4wFVuTmlLdBhrQgVhPamkzP8Hxop3pX1GIIp013eYGkiLgs28zJboTi0U27
 eXT5IENgWGjsittC4JJ/W1l46u0n2bwOeSnZ7JpwBOPxSZ/zLaTC9w+h4HLWpLop1ojsvg+KsvS
 aWlemsRrLdapT/7i56QGW69rbt8y32KQh/ZjJzWThEijZPn1doINbdshWn+0qTeHFFzc/diZ67H
 taJZSeN8l/7OWSfk78P8KlVkq5nzVxKu2uxEqbgAH/ZhBsQSu/BJ19Uwlwu5dt9CYRCtdUOPbJ4
 K04aw15n5pXkjSPNyb2jtbZem59mPzz8sfP1IJPmY4idk3g2JQphViMndoK6KgDe7R3NI2oN9Xi
 SDUZkc/jbX21AtetVdtqMqFfGsduUUj4Po2DoE10v
X-Received: by 2002:a5d:5f47:0:b0:427:9e6:3a64 with SMTP id
 ffacd0b85a97d-42b593847f2mr10779158f8f.47.1763374780931; 
 Mon, 17 Nov 2025 02:19:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuLJzRkeZwRTSmYiDMNFB5b9Y04M5/X3K0AsCLwjmRlR2lS/HTXuIsn1n38y2t71o3SspdXw==
X-Received: by 2002:a5d:5f47:0:b0:427:9e6:3a64 with SMTP id
 ffacd0b85a97d-42b593847f2mr10779119f8f.47.1763374780429; 
 Mon, 17 Nov 2025 02:19:40 -0800 (PST)
Received: from localhost ([195.166.127.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f0b8d6sm26377484f8f.28.2025.11.17.02.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 02:19:39 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@gmail.com,
 simona@ffwll.ch, linux@armlinux.org.uk, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, inki.dae@samsung.com, sw0312.kim@samsung.com,
 kyungmin.park@samsung.com, patrik.r.jakobsson@gmail.com,
 jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 sean@poorly.run, marijn.suijten@somainline.org,
 tomi.valkeinen@ideasonboard.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, thierry.reding@gmail.com, mperttunen@nvidia.com,
 jonathanh@nvidia.com
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2] drm/fb-helper: Allocate and release fb_info in
 single place
In-Reply-To: <20251027081245.80262-1-tzimmermann@suse.de>
References: <20251027081245.80262-1-tzimmermann@suse.de>
Date: Mon, 17 Nov 2025 11:19:38 +0100
Message-ID: <87ikf9kll1.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B8SqdaX3ow3G8XLXnanA-jIJlENhhX9Ec8A6v4EQXAM_1763374781
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

> Move the calls to drm_fb_helper_alloc_info() from drivers into a
> single place in fbdev helpers. Allocates struct fb_info for a new
> framebuffer device. Then call drm_fb_helper_single_fb_probe() to
> create an fbdev screen buffer. Also release the instance on errors
> by calling drm_fb_helper_release_info().
>
> Simplifies the code and fixes the error cleanup for some of the
> drivers.
>
> Regular release of the struct fb_info instance still happens in
> drm_fb_helper_fini() as before.
>
> v2:
> - remove error rollback in driver implementations (kernel test robot)
> - initialize info in TTM implementation (kernel test robot)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

It simplifies the drivers' code indeed.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

