Return-Path: <SRS0=5wqy=PW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C6EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 15:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485DA60FC4
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 15:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 485DA60FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDEF373632;
	Wed,  3 Nov 2021 15:04:18 +0000 (UTC)
X-Greylist: delayed 9139 seconds by postgrey-1.36 at gabe;
 Wed, 03 Nov 2021 15:00:53 UTC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 298F473613
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Nov 2021 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635951652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uwI0Y59Q5jmF4PHv+uLDkwhNmEWKp2IZoCsuOpcoatA=;
 b=V8hupRDi7JW+MC8owgkOu+/x5Qo5KaggJE3sSIstfNGwbQoL9+gRulz1GWQFi/8GxGc41a
 enkqUtLyhFFkpJTFmMNpm+gZLs/uvyOcF+btSBtMsx0ql6i57D9Ot9z146O6p1kWLNpk7M
 zPe2NrI7r68797d6wlshTQaNDptLT/A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-bZs6Rl8OO0iuPVddyK0XnQ-1; Wed, 03 Nov 2021 11:00:51 -0400
X-MC-Unique: bZs6Rl8OO0iuPVddyK0XnQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 v18-20020a7bcb52000000b00322fea1d5b7so1192512wmj.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Nov 2021 08:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=uwI0Y59Q5jmF4PHv+uLDkwhNmEWKp2IZoCsuOpcoatA=;
 b=uJmJkY4E9jlT/XFLwoo4+RJS3aRa/7FkJLA5IifyTSZOjWCHX+C/uN5e7tix3SHkNO
 p7Zp2xehnXMP8fEtGle4Vycq5Pr+94Jhq1VzNcP95Ue5H5C3uzyDnYUdYavsq6IU6oW+
 yNB31XKgaKGwPhEVHtXcQwClSWM92PmzILN4wiYAZf47Iq3jseTGLkp7YYZcPjrnFo2P
 k0VYlIjGvafabK+qFCdiuw3BKnMlRHRsjqnMPNWgSro3Hle0vnBupa7/EgDnCfUQOMdL
 8jn6nJ2nSMCABKWt3/v9MLPegb56caOEnqd1s7W3hRlZWclSRzQMs2Q8vPP8mQ2R8Kk+
 d3qw==
X-Gm-Message-State: AOAM530D3jJolUTISy14nz4R7kAc+ufAA1azaM2vA9idCKeU+h8wIK8J
 cf5RltS1atIEQofic2qbLYkYzdiTgyYMBRT8vTY3YIi+pGEkNU6KuFhDvZQeAQLrVKkq10eFhA3
 k/AyvdUEQSc/wxwqC8Zu3mVFZNA==
X-Received: by 2002:a1c:740e:: with SMTP id p14mr15702627wmc.109.1635951650005; 
 Wed, 03 Nov 2021 08:00:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlHYGSvfJmLDivVAOaT4xxbH7zmwqgCefExXH/bfigpAgkjWjbQ8meeoW65MqFlJvktgySGg==
X-Received: by 2002:a1c:740e:: with SMTP id p14mr15702572wmc.109.1635951649817; 
 Wed, 03 Nov 2021 08:00:49 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
 by smtp.gmail.com with ESMTPSA id q1sm2089857wmj.20.2021.11.03.08.00.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Nov 2021 08:00:49 -0700 (PDT)
Message-ID: <dbdbaf95-8625-aec9-4446-d39db77b23f2@redhat.com>
Date: Wed, 3 Nov 2021 16:00:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RESEND PATCH 0/5] Cleanups for the nomodeset kernel command line
 parameter logic
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
References: <20211103122809.1040754-1-javierm@redhat.com>
 <e02d23be-1a1c-570d-e76f-dbea76b6dd55@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <e02d23be-1a1c-570d-e76f-dbea76b6dd55@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 03 Nov 2021 15:04:17 +0000
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
Cc: linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>, amd-gfx@lists.freedesktop.org,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Peter Robinson <pbrobinson@gmail.com>, Neal Gompa <ngompa13@gmail.com>,
 Dave Airlie <airlied@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, nouveau@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, spice-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 intel-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Zack Rusin <zackr@vmware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Thomas,

On 11/3/21 14:01, Thomas Zimmermann wrote:

[snip]

>>
>>
>> Javier Martinez Canillas (5):
>>    drm/i915: Fix comment about modeset parameters
>>    drm: Move nomodeset kernel parameter handler to the DRM subsystem
>>    drm: Rename vgacon_text_force() function to drm_modeset_disabled()
>>    drm: Add a drm_drv_enabled() helper function
>>    drm: Use drm_drv_enabled() instead of drm_modeset_disabled()
> 
> There's too much churn here IMHO. Please merge patches 2+3 and 4+5. And 
> I'd put patch (4+5) first, so you have the drivers out of the way. After 
> that patch (2+3) should only modify drm_drv_enabled().
>

Sure, I'm happy with less patches.

Thanks for your feedback.
 
> Best regards
> Thomas
> 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

