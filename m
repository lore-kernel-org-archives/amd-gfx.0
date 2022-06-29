Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C962C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 08:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 158ED10E45D;
	Wed, 29 Jun 2022 08:21:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C81D610E5A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 08:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656490859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPJV1uPaZV9JJhbBrJp826ArqFj4Q0dOTMcobO8NbR8=;
 b=bTfT4BwTUhHjKsnZYXSh5osiP15x8TrNok7Lze+/ZuYwAlgSSLHJmjayhxrdKjOUSTpYgx
 wyb8ukdtI3ZFh/7ZKejx6FPnUlrP4frbBNQIybJtsXGdNVz3f0cv2Y41/abyrDfgUZh0wm
 BQGw/Mxq8JJwCVusZFA5+Z50YKbX5As=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-uBmnsW83Py6smVVFOw4g-Q-1; Wed, 29 Jun 2022 04:20:58 -0400
X-MC-Unique: uBmnsW83Py6smVVFOw4g-Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 y18-20020adfdf12000000b0021b94ba4c37so2197216wrl.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 01:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=bPJV1uPaZV9JJhbBrJp826ArqFj4Q0dOTMcobO8NbR8=;
 b=OzVvzXo2Ppti1d4ZQDhqlAIGjZ1iQMenoF0if4X5KG3NKrbQabdVQ5hBU32ZFc33Yz
 AAlukBai/atWxhgRYFwIO6SiXEhSOuO5d4a3DCqORf9CPC4ByeKm9FWMJA0nQjsdTNn1
 pfcMbFF0Z8kK4Y5Ou7c/kkRmceKIoW2XojY0cJEmtMxozrCjDngKExIFEnohXK9Y2tY1
 EkszXcDEH5Yrove40T4UA+ELSttQH/5TJZ4jK+WnT7eewr19GXXRsVxLRqk5CJV8MCwT
 ljPwgrxjs8hap8+T9COVOhlaJDoj7RQ4k81bTaZYwhPqZjRniNq9FHetmFTcogVohMVm
 uZ2g==
X-Gm-Message-State: AJIora+yt7jBx7xx2O5407JAlspdQDttHsNQHWJWkhogWptuWJ7c1X0a
 tQuyYa5NB3W4FQ2ARN68blwgXjYi7rXL+2oxUsNTbW5qTB9Ffq4pBcamNBjp2D3DOplC61i3K2G
 KaUzHFd7etyPlRVJrqSe8LQh+gA==
X-Received: by 2002:a05:600c:5127:b0:397:4862:e474 with SMTP id
 o39-20020a05600c512700b003974862e474mr2361011wms.68.1656490857404; 
 Wed, 29 Jun 2022 01:20:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1shi4ix35sLHrGEKb1EVEpzZ6zezB9IEV96DzmuPKrPxyxIUpeHBq+yzab4VpxhCVtEA3DMUg==
X-Received: by 2002:a05:600c:5127:b0:397:4862:e474 with SMTP id
 o39-20020a05600c512700b003974862e474mr2360986wms.68.1656490857136; 
 Wed, 29 Jun 2022 01:20:57 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 b3-20020a5d6343000000b0021a36955493sm15495488wrw.74.2022.06.29.01.20.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jun 2022 01:20:56 -0700 (PDT)
Message-ID: <d21e22dd-baa4-44c7-348b-e21844215277@redhat.com>
Date: Wed, 29 Jun 2022 10:20:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Annoying AMDGPU boot-time warning due to simplefb / amdgpu
 resource clash
To: Jocelyn Falempe <jfalempe@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <CAHk-=wh42rU5mKU6=PCK5tdkYjh7r31dGNmYdHwqpFnRFvVudA@mail.gmail.com>
 <3920df43-37f5-618d-70ba-de34a886e8ab@redhat.com>
 <CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com>
 <561af3c0-c7cf-3580-ce35-320cb13a037c@suse.de>
 <98aab56e-b0a7-1a39-d715-9ad10d7705a0@redhat.com>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <98aab56e-b0a7-1a39-d715-9ad10d7705a0@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 6/28/22 14:41, Jocelyn Falempe wrote:
> On 28/06/2022 10:43, Thomas Zimmermann wrote:

[snip]

>>
>> Unfortunately, this currently only works if a driver is bound to the 
>> platform device. Without simpledrm or simplefb, amdgpu won't find the 
>> platform device to remove.
>>
>> I guess, what happens on your system is that sysfb create a device for 
>> the EFI framebuffer and then amdgpu comes and doesn't find it for 
>> removal. And later you see these warnings because BOOTFB is still around.
>>
>> Javier already provided patches for this scenario, which are in the DRM 
>> tree. From drm-next, please cherry-pick
>>
>>    0949ee75da6c ("firmware: sysfb: Make sysfb_create_simplefb() return a 
>> pdev pointer")
>>
>>    bc824922b264 ("firmware: sysfb: Add sysfb_disable() helper function")
>>
>>    873eb3b11860 ("fbdev: Disable sysfb device registration when removing 
>> conflicting FBs")
>>
>> for testing. With these patches, amdgpu will find the sysfb device and 
>> unregister it.
>>
>> The patches are queued up for the next merge window. If they resolve the 
>> issue, we'll already send with the next round of fixes.
> 
> I was able to reproduce the warning with kernel v5.19-rc4, a radeon GPU 
> and the following config:
>
> CONFIG_SYSFB=y
> CONFIG_SYSFB_SIMPLEFB=y
> # CONFIG_DRM_SIMPLEDRM is not set
> # CONFIG_FB_SIMPLE is not set
>

Yes, and this could happen even if both drivers (e.g: simplefb and amdgpu)
are enabled but built-in. For example, if amdgpu probes before simplefb.

> After applying the 3 patches you mentioned, the issue is resolved. (at 
> least on my setup).
>

Thanks for testing Jocelyn! I've pushed the patches to drm-misc-fixes now.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

