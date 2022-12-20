Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFD2C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 09:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F376C10E369;
	Tue, 20 Dec 2022 09:44:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 103D510E36E
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 09:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671529495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
 b=IZZrmHibyrYGzbc/bU10800R+I6pK/iRTyKA0MpxvinXsS58o+UrLK8m9SphxKR12AU6oq
 Xs2h2vpLfx5YJQv7VkdEtOxqLT3u3pr3Tyx34RQcOxUPpikXQY6PR9K36uYgA3sL5N/j5Z
 a32sjiOiakbDQc13cPGbd7iCSusdX94=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-ok-B8hZBN1ykurkOZ0MFRA-1; Tue, 20 Dec 2022 04:44:54 -0500
X-MC-Unique: ok-B8hZBN1ykurkOZ0MFRA-1
Received: by mail-wm1-f71.google.com with SMTP id
 n8-20020a05600c294800b003d1cc68889dso2406485wmd.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 01:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
 b=iw7knId0TD15ZGNN+Wnn5aZfmdG/3M7EjhE7pBmprDjFS0HE+MJEXa48dzdOa+o0iz
 MzWGrZWOqz9hoNLmZKOPAIH+rJfbXcYfenX5a/df5qZbUkFAZNwpbZdz+G4WzQEEjUY7
 HTSRsUI+KSPlRSiuLDtSMl1WBbGtwRg6CGW3J3cImYBgaUoCr/kjElc5GNO9g2eFNvxW
 dAsBJerSenfn1ZL1CtxA1aXIZ3WJFOZpNAKwBu5PSjhfmXg/KosSeooTGioxG4+iF717
 rZuyojZExzP8eS0stF6HqqxJIWctW5rv73y7dejLakT/g4q+lXs7druPUCzIUWkV8Kzq
 4S1g==
X-Gm-Message-State: ANoB5pkjXy3iYf4YXkya/km5AO4ZJ0++H9iHNtJeGhdwHsTUVz2sS7oR
 2DfQnp45FzTReAZZYycgNO/jxfNcvzhCC6s2jkm/AA68sUjkE3cdzoEjAnKsp5w9IxWThA9xNp7
 mDBoV6Wl2nYtsySlzelGmpmNqZw==
X-Received: by 2002:a05:600c:3508:b0:3cf:b73f:bf8f with SMTP id
 h8-20020a05600c350800b003cfb73fbf8fmr34866243wmq.7.1671529492811; 
 Tue, 20 Dec 2022 01:44:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf74M8Sm1ZUMeD1MRSt8ye6pyF2JALOeT/hhACXzocPTXyP3LI6efvyoi2Xa1weHvEDgcZ0pkQ==
X-Received: by 2002:a05:600c:3508:b0:3cf:b73f:bf8f with SMTP id
 h8-20020a05600c350800b003cfb73fbf8fmr34866233wmq.7.1671529492648; 
 Tue, 20 Dec 2022 01:44:52 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 t16-20020a1c7710000000b003c6f3f6675bsm21680659wmi.26.2022.12.20.01.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Dec 2022 01:44:52 -0800 (PST)
Message-ID: <cb8af91b-4d5a-6d0a-6604-d99fc4a0f0e9@redhat.com>
Date: Tue, 20 Dec 2022 10:44:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 17/18] fbdev/vga16fb: Do not use struct fb_info.apertures
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-18-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-18-tzimmermann@suse.de>
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
> Acquire ownership of the firmware scanout buffer by calling Linux'
> aperture helpers. Remove the use of struct fb_info.apertures and do
> not set FBINFO_MISC_FIRMWARE; both of which previously configured
> buffer ownership.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

