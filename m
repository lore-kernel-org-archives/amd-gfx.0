Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3839BC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 18:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0784A611EE
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 18:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0784A611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78A4D73242;
	Thu,  4 Nov 2021 18:01:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 341E473305
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 16:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636044254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GBeSNSo+VR936LBuXFto2HVzfx/uW1FgtYIk1y3q3ig=;
 b=KJObKROBvzmztauTW/iyO9QHW3+81Ci3lu/ZmIrPRgSRcLEFKYdQYYVqUTLTj8DUFJ7G0p
 WpVuJg7xy4oExSMZ5k+/uOGkLZ3QcumIN3hB+N8zXLRaaz2006R9HCU2wd8GkjQPHnn9/n
 dRj9zqJTmDqVac0Q3SYFNg9sqnNhVlA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-zQOx77DEMdeFdq-ZFwj9uA-1; Thu, 04 Nov 2021 12:44:12 -0400
X-MC-Unique: zQOx77DEMdeFdq-ZFwj9uA-1
Received: by mail-wr1-f69.google.com with SMTP id
 v18-20020a5d5912000000b001815910d2c0so1211279wrd.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Nov 2021 09:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=GBeSNSo+VR936LBuXFto2HVzfx/uW1FgtYIk1y3q3ig=;
 b=Uxx2iFbCTPa0Pxexas9/Uzb+BrTJihynF+cce+t3tiW72f2M4rPOfzilw1gH8hf5Yg
 7TF3x/8e2hLcnieGEUA8LggRkC7Zfi12M3+bQLg70inSE/omIsFxqadDHuRbppt4oFch
 3IKxY1Wxb6+PCdcoU/XaCHRefxiLXN62BD4leUYQRYOdvN2OS2NUfNnfGpcqrfeDN2Gg
 zX7J4vDEG7+qRVC73Y5Mb14sVzRo2aO2xrd33inQ2y1t5oEohqHiIMgTJF+QR//r/nYH
 ZcPf2KzLSyPinBNBABvUXQfxra8EtC8ComcNGzEiTt+sbL/H1uyl+UBGI13bIVnFXaRx
 DwtQ==
X-Gm-Message-State: AOAM532o1s/GuXthEyO4+iOpQTrjx+nhpOTju6ghatBTsBkmumyWg00P
 rw+GlVW3Pcyo1d7a7ddEuoMpnEuM1AG1S7VKhI+2oaXNhs3y+PxkwzO7MZSnNzcizeSZcziIPuq
 jZMYWAn6z3teKJ6FnxoB6TyN25Q==
X-Received: by 2002:a5d:4e52:: with SMTP id r18mr39525109wrt.224.1636044250774; 
 Thu, 04 Nov 2021 09:44:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnATpWRYfiqKo492+/czqTIzFCv7HIX437cz1EV9eI7R7UChO4l+utit2RLduHTmaqMKEFNQ==
X-Received: by 2002:a5d:4e52:: with SMTP id r18mr39525075wrt.224.1636044250590; 
 Thu, 04 Nov 2021 09:44:10 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
 by smtp.gmail.com with ESMTPSA id o4sm6636216wry.80.2021.11.04.09.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Nov 2021 09:44:10 -0700 (PDT)
Message-ID: <3ff9fe95-9bc7-a043-78c6-d52d0ff02e23@redhat.com>
Date: Thu, 4 Nov 2021 17:44:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] drm: Add a drm_drv_enabled() to check if drivers
 should be enabled
To: Jani Nikula <jani.nikula@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20211104160707.1407052-1-javierm@redhat.com>
 <20211104160707.1407052-2-javierm@redhat.com> <87zgqjanz2.fsf@intel.com>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <87zgqjanz2.fsf@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 04 Nov 2021 18:01:52 +0000
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
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>, amd-gfx@lists.freedesktop.org,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Peter Robinson <pbrobinson@gmail.com>, nouveau@lists.freedesktop.org,
 Dave Airlie <airlied@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
 Ben Skeggs <bskeggs@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 virtualization@lists.linux-foundation.org,
 Pekka Paalanen <pekka.paalanen@collabora.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, spice-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 intel-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Zack Rusin <zackr@vmware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/4/21 17:24, Jani Nikula wrote:

[snip]

>> index ab2295dd4500..45cb3e540eff 100644
>> --- a/drivers/gpu/drm/i915/i915_module.c
>> +++ b/drivers/gpu/drm/i915/i915_module.c
>> @@ -18,9 +18,12 @@
>>  #include "i915_selftest.h"
>>  #include "i915_vma.h"
>>  
>> +static const struct drm_driver driver;
>> +
> 
> No, this makes absolutely no sense, and will also oops on nomodeset.
>

Ups, sorry about that. For some reason I thought that it was defined in
the same compilation unit, but I noticed now that it is in i915_drv.c.
 
> BR,
> Jani.
> 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

