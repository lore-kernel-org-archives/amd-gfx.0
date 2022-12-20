Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D39BC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 09:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEEEB10E34B;
	Tue, 20 Dec 2022 09:19:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B23710E34B
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 09:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671527976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABmxoLEyhLmWYUbBrwSAozB1mTvmA41c/n7InFI0eTk=;
 b=IpGRR+scpAWOD1UTq/DH8TWMe6kSXjEE+Apk0SOwgEDHE87x96Bko+8pVchwoz8dL1cGaq
 cxA+tXP1L5ADjy4sN1MRuAq9r+GPwFwbu5QOU82pVBAuHr4EJ5+gfSTAGpdWdynXmWjHg5
 ZtGM3Nc6cCNbrwmV7yXFO83kNOy3zB0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-584-IIQKG_WqM2G9E9aBGXbafw-1; Tue, 20 Dec 2022 04:19:35 -0500
X-MC-Unique: IIQKG_WqM2G9E9aBGXbafw-1
Received: by mail-wm1-f71.google.com with SMTP id
 r67-20020a1c4446000000b003d09b0fbf54so7774189wma.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 01:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ABmxoLEyhLmWYUbBrwSAozB1mTvmA41c/n7InFI0eTk=;
 b=ykcmOIT/GkgGtsvglyG5vkO9kpSuUVCr9e2ZuApctE8sRvqCoeB4YwZuCBIH0qq/KI
 o7QT0UNHUupYPnhyrCbWnfvg0aWpStK0S0CxdnqVl+0m6xbd+BQlsPx+3clRO0L8nQZN
 NR1Ufv+gwIq55P18DU4p721rY9uZAXDorMerJINiFBbA5gGZcmxUSr5JGK1dPk+R+vQc
 kqiV8EEoNr+wDFn+6x1fFLQFwfMuOJNwzv/Tvdo8dBUKXWp921VIAkc7fff5pLFyH2I/
 sjY6kVog470OhjswWH5U+521+iLZjVqZJ2dGG2YTEdK3Z+8CSp4X1Z7/trm1xAEh1nKn
 +BZw==
X-Gm-Message-State: AFqh2krjt8eopx+cMz9l2O6LVury/N2Dj1yepeI0dKNwy3VtT3ArOewt
 z9fu5xe8ual0VY9xRF7VKgH5C3foRht1T+8AHPGudUfhnZtRJPLoKnG/khFSi4kj6uPBh76KWrK
 UCQuR/Enp6d0p2dh65dEUK8Jb8w==
X-Received: by 2002:a5d:5752:0:b0:244:48b3:d13f with SMTP id
 q18-20020a5d5752000000b0024448b3d13fmr814490wrw.41.1671527974608; 
 Tue, 20 Dec 2022 01:19:34 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtLG6B6o+Iq76Uq1s7q/P5T3qehN9lnU31N4pqMHcN5FUQ5i4K5iNalaLBn7T7/AoIpv82Xvg==
X-Received: by 2002:a5d:5752:0:b0:244:48b3:d13f with SMTP id
 q18-20020a5d5752000000b0024448b3d13fmr814479wrw.41.1671527974427; 
 Tue, 20 Dec 2022 01:19:34 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 bj19-20020a0560001e1300b002238ea5750csm14570460wrb.72.2022.12.20.01.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Dec 2022 01:19:34 -0800 (PST)
Message-ID: <d9fa03ac-4e71-dcd4-2d79-698410c9c444@redhat.com>
Date: Tue, 20 Dec 2022 10:19:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 04/18] drm/i915: Do not set struct fb_info.apertures
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-5-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-5-tzimmermann@suse.de>
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
> not set the values in i915.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

