Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E940CC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 13:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6A0611AE
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 13:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D6A0611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 915826E5B2;
	Fri,  5 Nov 2021 13:48:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E686C6E10B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 09:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636106341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PAYCTLIu4BclXd+cEViyuoXMMG/fW8iPDkQUaON6iK4=;
 b=G3u+TK+LPXSkwKEF+Pb4QZVkzMMb7v4Gct3YcN1jEAr9e3VfmzaQ/rD5BV0PHsgnsb9gla
 SJZ05WGvyTQepU6mH8lfaqKLFpBfU+CVAQoosU+09ccrbBcxO73dc+sPUnTWdVWKjDN3cx
 Tbs6rYUynzy+Rlrg1Ms8yL+amz57NSw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-qjQ8fEGnOECrWugc7_XsBQ-1; Fri, 05 Nov 2021 05:58:58 -0400
X-MC-Unique: qjQ8fEGnOECrWugc7_XsBQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 n189-20020a1c27c6000000b00322f2e380f2so5465877wmn.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Nov 2021 02:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=PAYCTLIu4BclXd+cEViyuoXMMG/fW8iPDkQUaON6iK4=;
 b=sKk/+3c2zW7bHgm3wS/31jN26uUeUlF88VnPbyuxoMSFKwH83JeSOaAtE22cm75HzA
 zgP4uEkz8k62Y/R2u+D6xKNudr0TO7Uee2yhYcYyCf07nuMB2n0ir2GCF3fjMUM7mbwq
 kKBqmyFHnd3nXM4unKyqsHY3JG+jGD46imUsMyXNNTIOjQqV13bdwjSArC9mlm0k9eAJ
 6S6+tJuWFwBF6lfyr2JbR+OisHKjuDH/KjVbkTcV8a/qo9Yt4QsG1kweuIa/IiBz7i0Z
 7uvcCBCXtLD5wBXMMBfEEba/s3r1JPSw01Mqh0JtSmgBaCEeo6AmVsXLku4sRlnwVUm1
 6Low==
X-Gm-Message-State: AOAM531SfB5VmtnjtybuqWGTzibrqWELWcYIKaafYQg7y3dLD6tHZeAR
 YY/ZPKAYPB+ThDUpf08RqsiOq9/QReup4PEuX7juGCpzwOe8JYa4lwpBDxH1OHJLqWjF1zvUauJ
 8r2kE+QkMatQnOzUUXhFa2G1ALg==
X-Received: by 2002:adf:ec90:: with SMTP id z16mr46047453wrn.247.1636106336899; 
 Fri, 05 Nov 2021 02:58:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVMn64qcflGLedLN5EhsNM7GWU6o/3vwDL3aOoAYuCZV9//84CDnDeN1gsW9919fwpqQaOmg==
X-Received: by 2002:adf:ec90:: with SMTP id z16mr46047414wrn.247.1636106336738; 
 Fri, 05 Nov 2021 02:58:56 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
 by smtp.gmail.com with ESMTPSA id c17sm7678095wmk.23.2021.11.05.02.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Nov 2021 02:58:56 -0700 (PDT)
Message-ID: <87a6bb4a-01ef-4979-f5c2-c0bb0d0a29f9@redhat.com>
Date: Fri, 5 Nov 2021 10:58:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/2] drm: Move nomodeset kernel parameter to the DRM
 subsystem
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Jani Nikula <jani.nikula@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20211104160707.1407052-1-javierm@redhat.com>
 <20211104160707.1407052-3-javierm@redhat.com>
 <f2c40b22-04bf-e8f2-9839-36d6d26189a1@suse.de> <87cznf9cty.fsf@intel.com>
 <2698c680-6d05-f58d-d7c2-ea76aeb0bb47@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <2698c680-6d05-f58d-d7c2-ea76aeb0bb47@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 05 Nov 2021 13:48:53 +0000
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
 Peter Robinson <pbrobinson@gmail.com>, nouveau@lists.freedesktop.org,
 Dave Airlie <airlied@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
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

On 11/5/21 10:39, Thomas Zimmermann wrote:

[snip]

>>>>    
>>>> +obj-$(CONFIG_VGA_CONSOLE) += drm_nomodeset.o
>>>> +
>>>
>>> This now depends on the VGA textmode console. Even if you have no VGA
>>> console, you'd want drm_nomodeset.o. Simpledrm might be built-in and can
>>> provide graphics. Non-PC systems don't even have a VGA device.
>>
>> This was discussed in an earlier version, which had this builtin but the
>> header still had a stub for CONFIG_VGA_CONSOLE=n.
>>
>>> I think we really want a separate boolean config option that gets
>>> selected by CONFIG_DRM.
>>
>> Perhaps that should be a separate change on top.
> 
> Sure, make it a separate patch.
>

Agreed. I was planning to do it as a follow-up as well and drop the
#ifdef CONFIG_VGA_CONSOLE guard in the header.
 
> We want to make this work on ARM systems. I even have a request to 
> replace offb on Power architecture by simpledrm. So the final config has 
> to be system agnostic.
>

Same, since we want to drop the fbdev drivers in Fedora, for all arches.
 
> Best regards
> Thomas
> 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

