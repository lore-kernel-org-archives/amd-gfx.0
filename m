Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B87BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jun 2022 08:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6B8810FC90;
	Mon, 27 Jun 2022 08:02:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C530F10FC7F
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 08:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656316937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+BhcPB/fW8lkxE3byWUWF+Hldg5p1S7kgw+9StleA50=;
 b=OJDS7NjcP73vXSfVd1YuvB4/AZd8nLDlPV93uX5rHKDIYVfvEBDluVB4zhbMvv8+4aYH9x
 KY7RRCb2P3g67Na/ozXQCe1Ojya2FKOww2YOMTMzuu3VjQxFRK7S+rjzJq/9bn0u9RAc8+
 rKZdblIytiAANzLRwdM5AXDJKUxaOiA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-aJGsd4brMeywYxEYkqgIgg-1; Mon, 27 Jun 2022 04:02:16 -0400
X-MC-Unique: aJGsd4brMeywYxEYkqgIgg-1
Received: by mail-wm1-f69.google.com with SMTP id
 k16-20020a7bc310000000b0038e6cf00439so5264467wmj.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 01:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=+BhcPB/fW8lkxE3byWUWF+Hldg5p1S7kgw+9StleA50=;
 b=ldZH0fVJCICBDyHTxwUHyBUpX0VMWcMxAbjuckFf49Zm1v4PktBbyAyHRbf0ppzrko
 rFzgk5x3z6tl2lo9SRvoZdUymkY7FxIMPqmPkCTtJukktPB4K79NnUyN2K0XrQfgsaB6
 nietISIwvCqkSWOEbvYJfz18YOPOlze3xfzanznEzn5U0Q51MiG/1DroflFXYXp01LZX
 u7jpeuqwfjHDjUT+paXvYOr+plsiz8IlX4F+p2sB5AXdFhJTvSoKnJNGAwWrltrcIp8a
 3m6rhcHytDLEGYrPHus68SZk/HlKYiFcZhB+Y+RN6XFxKvqyTwgMrm4hgLtfGdZYE6yc
 EK8A==
X-Gm-Message-State: AJIora9IBrLBaLCQ9kI0BHuuOvFXh7pN7l1U7l7EvQRA63WZx6GaTyES
 5O/cRS9I3DKILT39PDD0AmeQreR6p6jPYHo0uxAmoFXH3N4GVB0L4IM2hrpQm6TF32GceL9Blv6
 fp1iI6N+8h2E91/R/9aeGMPfOAA==
X-Received: by 2002:a5d:4601:0:b0:21b:9035:d295 with SMTP id
 t1-20020a5d4601000000b0021b9035d295mr10995360wrq.63.1656316934841; 
 Mon, 27 Jun 2022 01:02:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uHyeQB3afsqr1Szx/j8rTPBkRM7cm7Ke1/JvUC6RPiOEuvpeYA002QEItGaB94DqzGnWdtog==
X-Received: by 2002:a5d:4601:0:b0:21b:9035:d295 with SMTP id
 t1-20020a5d4601000000b0021b9035d295mr10995332wrq.63.1656316934573; 
 Mon, 27 Jun 2022 01:02:14 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 y3-20020a05600c17c300b003a0231af43csm11589261wmo.48.2022.06.27.01.02.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jun 2022 01:02:14 -0700 (PDT)
Message-ID: <3920df43-37f5-618d-70ba-de34a886e8ab@redhat.com>
Date: Mon, 27 Jun 2022 10:02:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Annoying AMDGPU boot-time warning due to simplefb / amdgpu
 resource clash
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Zack Rusin <zackr@vmware.com>,
 Hans de Goede <hdegoede@redhat.com>
References: <CAHk-=wh42rU5mKU6=PCK5tdkYjh7r31dGNmYdHwqpFnRFvVudA@mail.gmail.com>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAHk-=wh42rU5mKU6=PCK5tdkYjh7r31dGNmYdHwqpFnRFvVudA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
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
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Linus,

On 6/26/22 20:54, Linus Torvalds wrote:
> So this has been going on for a while, and it's quite annoying.
> 
> At bootup, my main desktop (Threadripper 3970X with radeon graphics)
> now complains about
> 
>   resource sanity check: requesting [mem 0xd0000000-0xdfffffff], which
> spans more than BOOTFB [mem 0xd0000000-0xd02fffff]
> 
> and then gives me a nasty callchain that is basically the amdgpu probe
> sequence ending in amdgpu_bo_init() doing the
> arch_io_reserve_memtype_wc() which is then what complains.
> 
> That "BOOTFB" resource is from sysfb_simplefb.c, and I think what
> started triggering this is commit c96898342c38 ("drivers/firmware:
> Don't mark as busy the simple-framebuffer IO resource").
> 
> Because it turns out that that removed the IORESOURCE_BUSY, which in
> turn is what makes the resource conflict code complain about it now,
> because
> 
>                 /*
>                  * if a resource is "BUSY", it's not a hardware resource
>                  * but a driver mapping of such a resource; we don't want
>                  * to warn for those; some drivers legitimately map only
>                  * partial hardware resources. (example: vesafb)
>                  */
> 
> so the issue is that now the resource code - correctly - says "hey,
> you have *two* conflicting driver mappings".
> 
> And that commit claims it did it because "which can lead to drivers
> requesting the same memory resource to fail", but - once again - the
> link in the commit that might actually tell more is just one of those
> useless patch submission links again.
> 
> So who knows why that commit was actually done, but it's causing annoyance.
>

The flag was dropped because it was causing drivers that requested their
memory resource with pci_request_region() to fail with -EBUSY (e.g: the
vmwgfx driver):

https://www.spinics.net/lists/dri-devel/msg329672.html
 
> If simplefb is actually still using that frame buffer, it's a problem.
> If it isn't, then maybe that resource should have been released?
>

It's supposed to be released once amdgpu asks for conflicting framebuffers
to be removed calling drm_aperture_remove_conflicting_pci_framebuffers().

I'm not familiar with the amdgpu driver, but maybe that call has to be done
earlier before the arch_io_reserve_memtype_wc() ?
 
> I really think that commit c96898342c38 is buggy. It talks about "let
> drivers to request it as busy instead", but then it registers a
> resource that isn't actually a proper real resource. It's just a
> random incomplete chunk of the actual real thing, so it will still
> interfere with resource allocation, and in fact now interferes even
> with that "set memtype" because of this valid warning.
> 

That registered resource is what the firmware provides for drivers to use
the system framebuffer for scan-out. It's not the real thing, that's true
since a native driver would kick it out (leading to a resource release)
and register the real aperture.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

