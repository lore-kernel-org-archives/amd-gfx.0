Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CADC54E94
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jan 2023 09:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11AD10E103;
	Wed, 25 Jan 2023 09:51:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED6CE10E103
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 09:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674640258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K/d1Iir0okyO1PXRE824II8zkHLTH6xPW+FwgTmuVIo=;
 b=i43tSzhaGlT3iP7kNF+8LzN0an29YTFMeBi1U+PA1dMET2VHr0oh5yow8+VryWBuQlNUYU
 UJ/bk/mDQxuPSIz4nni1fb8stQBsjkOHiYQ22fQgfuQhrE0DCs1QyUeP6aqiltjHPb2kDH
 fUjnLuOLzQWr4MzUGt9NdZqw9yl/okQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-180-3T7yQi7iMTKoacSpux21RQ-1; Wed, 25 Jan 2023 04:50:56 -0500
X-MC-Unique: 3T7yQi7iMTKoacSpux21RQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 12-20020a05600c228c00b003db09699216so347372wmf.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 01:50:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K/d1Iir0okyO1PXRE824II8zkHLTH6xPW+FwgTmuVIo=;
 b=eM7CsLYzDQzK1wVWvNx7t1ZAungC0UpI7XRDh02w/jhE0eJF/T5EXJp8IDVb07PKTF
 SyKkTV+kSXxY3yHdCLvBBUMxqhLFsV6xMsvKYDp5V7XDc5NrZmPWeR+fhSvGHqD6b4VG
 bNZUPy5yrTq+c7gCEdXqeY5YICkmHRSetPDc1Q+nlFt6o14W+DN4Jzn+fVimUoGuAcqI
 YPbZzkKIAjK7EuUhr9X3MihEl1JajR7Pc5KIMqW6TETxujNAQHEbYdTTwvnpG7Vctrkl
 WpJjPPGe/Aw9u7sBQcX9dUzGpCcEDv5HyNUUtGh6+uLBnD+SvSO9o5TdqE9haxq6V1SV
 Eyew==
X-Gm-Message-State: AFqh2kqso8A5i96avRIIduFCusehLzYnF4XFF67jruNKKY3LTtNIB+PK
 oxqZIewGpCjU8dkr2wgD0Sf5tpSodI3de3qKYVhg9wzBtShE4zDdmeTZDlNxTc+qmz7dKv60R68
 lqS9Tgg+TrHhFV4evJv9Z168/gQ==
X-Received: by 2002:a05:600c:3ac8:b0:3da:270b:ba6b with SMTP id
 d8-20020a05600c3ac800b003da270bba6bmr32346401wms.41.1674640255700; 
 Wed, 25 Jan 2023 01:50:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuwfL0Z6VaIwodqmubvV+5fPQ6Vvv5kGgzDLr7Nlz5OAeVqgi6a3bBFtOpmTalnPP5+47xPuw==
X-Received: by 2002:a05:600c:3ac8:b0:3da:270b:ba6b with SMTP id
 d8-20020a05600c3ac800b003da270bba6bmr32346388wms.41.1674640255501; 
 Wed, 25 Jan 2023 01:50:55 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 e18-20020a5d65d2000000b00294176c2c01sm3929576wrw.86.2023.01.25.01.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jan 2023 01:50:54 -0800 (PST)
Message-ID: <498c2aa7-185f-d1cd-6e41-004880913870@redhat.com>
Date: Wed, 25 Jan 2023 10:50:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 08/10] drm/fbdev-generic: Minimize client unregistering
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org
References: <20230124134010.30263-1-tzimmermann@suse.de>
 <20230124134010.30263-9-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230124134010.30263-9-tzimmermann@suse.de>
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
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/24/23 14:40, Thomas Zimmermann wrote:
> For uninitialized framebuffers, only release the DRM client and
> free the fbdev memory. Do not attempt to clean up the framebuffer.
> 
> DRM fbdev clients have a two-step initialization: first create
> the DRM client; then create the framebuffer device on the first
> successful hotplug event. In cases where the client never creates
> the framebuffer, only the client state needs to be released. We
> can detect which case it is, full or client-only cleanup, be

s/be/by

> looking at the presence of fb_helper's info field.
> 
> v2:
> 	* remove test for (fbi != NULL) in drm_fbdev_cleanup() (Sam)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

