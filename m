Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40768C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 09:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B72B710E355;
	Tue, 20 Dec 2022 09:22:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9096E10E353
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 09:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671528147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kA4MxY/xt1b965fBBWiuXbuP8HCDa5veURhTEDS4ghc=;
 b=KNZuGWxKHtTSxNGs9V+tXJKgM5HgtGAZ3GwHkqLtI9j41EojzClak9qUSz7cyeRRicT9SB
 EsgvFOGqc9A8G8VQXnFZcgqJ96au0YZy8HoD+TAUe2eGvOYA8hboaaAbBU7cn8E5aYm2Tn
 BVdZCwFclKiV8hWIqmMls5nukAGBYfU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-SdG7KvT7Pv61fwkWXB84KQ-1; Tue, 20 Dec 2022 04:22:26 -0500
X-MC-Unique: SdG7KvT7Pv61fwkWXB84KQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 v188-20020a1cacc5000000b003cf76c4ae66so7778058wme.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 01:22:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kA4MxY/xt1b965fBBWiuXbuP8HCDa5veURhTEDS4ghc=;
 b=6tBNKqTsV0UIxJLnxw10qBieQc7sPdbme79joYwEumGbFtDvqxgUGaAcc1ferRbpkX
 O/Dq4WUGqfWx/ad7jbmwv3OdAFUit2L2LaYdWha6p/qFRQPEZ0segSuqvaWcQcwykhYW
 uZ3GU4dD0J26NcuPFr7f+OJpgTg61w7BN1Wg15htfNzzm+i21V+PDf1l4uOkDsgJs9sl
 /gA6t53RqxX/5M8QzOWI+fZGtpxvD2RGZHdNOsdhZOIYimv5J/BCYL7cpdpExcpejWbE
 /8I7PGMaWciy6c9LVHS/USwMq7FDOMR/6E7aGmARyYVAIRFftFfg1Vcrw5SJ3YniDqru
 lAzg==
X-Gm-Message-State: ANoB5pnBEC2s0JN2APqE3rOvWgHwKGRBoSwjMGgYJS5jlfRlbp4RcpRz
 fgudPA7jZvQTh9LTUyoceBIDbKHtiLHOyX59R3nhy/gWoIugpIuiAetad306tNqWBGUjYWVv1tj
 uP+BYPtLA9TCkxugcqZQTld6n+A==
X-Received: by 2002:a05:600c:4e14:b0:3d2:4234:e8fe with SMTP id
 b20-20020a05600c4e1400b003d24234e8femr16310098wmq.19.1671528145672; 
 Tue, 20 Dec 2022 01:22:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7D1EDbJcc4QdZIvJK/Fm89Zwd1JGt/mFkIkcyx0LysVtTks8a6AInaJGEHTgImFr5Ff5SiAA==
X-Received: by 2002:a05:600c:4e14:b0:3d2:4234:e8fe with SMTP id
 b20-20020a05600c4e1400b003d24234e8femr16310078wmq.19.1671528145416; 
 Tue, 20 Dec 2022 01:22:25 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 m1-20020a1c2601000000b003d1d5a83b2esm22817348wmm.35.2022.12.20.01.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Dec 2022 01:22:25 -0800 (PST)
Message-ID: <d3370b05-cf1f-c3b2-678b-30708c549acb@redhat.com>
Date: Tue, 20 Dec 2022 10:22:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 06/18] drm/fb-helper: Do not allocate unused apertures
 structure
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-7-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-7-tzimmermann@suse.de>
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
> The apertures field in struct fb_info is not used by DRM drivers. Do
> not allocate it.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

