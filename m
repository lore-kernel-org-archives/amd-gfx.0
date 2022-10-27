Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A24FA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 12:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76C5810E39F;
	Thu, 27 Oct 2022 12:33:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39CEC10E38C
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 10:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666867075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KIrIm83XlmkQEHvLgMNI62dGgv/hpRuvnAfiEarWzlw=;
 b=P6dlp716aHLC49BdStNZsamg376bKzmSSfc54gI1gKBX91IgKRkYI9rk6TX8xNQp9rriZ0
 HLIf8VWcJlq0SezVT01kK0QMW4DNdH2YZHpahO5XNnuf6C52sG9Z+yLvLzOmC17OpBhr92
 vx4e2Rbt2tmGGb+b5NFu6yQofy76dhA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-310-iApXHsu_MfewbGrjsSnSDQ-1; Thu, 27 Oct 2022 06:37:52 -0400
X-MC-Unique: iApXHsu_MfewbGrjsSnSDQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 t4-20020a056402524400b004620845ba7bso829885edd.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 03:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KIrIm83XlmkQEHvLgMNI62dGgv/hpRuvnAfiEarWzlw=;
 b=nJ3wXRfhvSIOYQaoOyjYaoGbnwUscTel2aUVVKHO/YW6O3FuucG8vCSghI6lJ4+S3O
 0tXm/U3o386RnMCO96E61L5ELUt1FZsblgMyrUbnsMbtWwde3O/J+5NijAgKaU2kZwGg
 G5NZCfpBG6jSr5nEVx/Y+QvWYpbOE7enP1DdenX25ZBfobg0A/qT4M2N3wqYFaVvzT+S
 pFCDoHMtvrXFfMDu5D1euYG3HwOQ7iWPXnuDL9szJZc0Lt/qEJBs0ThEsHLepKVj4Pgr
 yENiZz04OcIB1+MJGEh1S4G/zKJuJ/07KB79KkxJX6lv3lFEhU6hVFVPuyo6TgW8HDyT
 AbSw==
X-Gm-Message-State: ACrzQf2h4O5AcxJ36rV1cp22nyfLk6X1BzKm6BUs5uhKNpuoS7tO4l5O
 oUIyK2XSYSsl9bRBiPA/sJ8WW+DzhQSfohYVJ7VVzKgtN/VaGLxq3vR9x/giPf40dBCs6bu9inO
 M1Y3f0NisRPjjdwHU8fvBa9cBag==
X-Received: by 2002:a17:906:9bd8:b0:78d:85f9:36ae with SMTP id
 de24-20020a1709069bd800b0078d85f936aemr42186648ejc.342.1666867071326; 
 Thu, 27 Oct 2022 03:37:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5SZMU3P4Zsb6VMxou+01MOar68Mbr9wEuDuf/meiI+Zmby9PhRAPjCmSxwGQr42Uzv+ipmOg==
X-Received: by 2002:a17:906:9bd8:b0:78d:85f9:36ae with SMTP id
 de24-20020a1709069bd800b0078d85f936aemr42186603ejc.342.1666867071054; 
 Thu, 27 Oct 2022 03:37:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81?
 (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a50c3ce000000b004587c2b5048sm739068edf.52.2022.10.27.03.37.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Oct 2022 03:37:50 -0700 (PDT)
Message-ID: <6df2016d-ed2d-57fa-dcad-48537732895f@redhat.com>
Date: Thu, 27 Oct 2022 12:37:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v5 02/31] drm/i915: Don't register backlight when another
 backlight should be used (v2)
To: Matthew Garrett <mjg59@srcf.ucam.org>
References: <20221025193248.GA21457@srcf.ucam.org>
 <144cd47e-42dc-2b84-1a90-ea5e080e08a3@redhat.com>
 <20221025204043.GA23306@srcf.ucam.org>
 <cb5add36-c13c-ccd5-1b4b-71b45163a170@redhat.com>
 <20221025234040.GA27673@srcf.ucam.org>
 <fa6cc1d9-6740-b495-2c72-cae18c429ca6@redhat.com>
 <20221026204920.GA15326@srcf.ucam.org>
 <099dee98-8aeb-af36-828c-110f5ac6e9a3@redhat.com>
 <20221027091123.GA28089@srcf.ucam.org>
 <933be908-0bc2-56cc-8d6f-38f2d208ef20@redhat.com>
 <20221027095249.GA28666@srcf.ucam.org>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221027095249.GA28666@srcf.ucam.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 27 Oct 2022 12:33:43 +0000
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
Cc: Karol Herbst <kherbst@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 nouveau@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, amd-gfx@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
 David Airlie <airlied@redhat.com>, Len Brown <lenb@kernel.org>,
 Daniel Dadap <ddadap@nvidia.com>, Jani Nikula <jani.nikula@intel.com>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Mark Gross <markgross@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Xinhui <Xinhui.Pan@amd.com>,
 Lukas Wunner <lukas@wunner.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 10/27/22 11:52, Matthew Garrett wrote:
> On Thu, Oct 27, 2022 at 11:39:38AM +0200, Hans de Goede wrote:
> 
>> The *only* behavior which actually is new in 6.1 is the native GPU
>> drivers now doing the equivalent of:
>>
>> 	if (acpi_video_get_backlight_type() != acpi_backlight_native)
>> 		return;
>>
>> In their backlight register paths (i), which is causing the native
>> backlight to disappear on your custom laptop setup and on Chromebooks
>> (with the Chromebooks case being already solved I hope.).
> 
> It's causing the backlight control to vanish on any machine that isn't 
> ((acpi_video || vendor interface) || !acpi). Most machines that fall 
> into that are either weird or Chromebooks or old, but there are machines 
> that fall into that.

I acknowledge that their are machines that fall into this category,
but I expect / hope there to be so few of them that we can just DMI
quirk our way out if this.

I believe the old group to be small because:

1. Generally speaking the "native" control method is usually not
present on the really old (pre ACPI video spec) mobile GPUs.

2. On most old laptops I would still expect there to be a vendor
interface too, and if both get registered standard desktop environments
will prefer the vendor one, so then we need a native DMI quirk to
disable the vendor interface anyways and we already have a bunch of
those, so some laptops in this group are already covered by DMI quirks.

And a fix for the Chromebook case is already in Linus' tree, which
just leaves the weird case, of which there will hopefully be only
a few.

I do share your worry that this might break some machines, but
the only way to really find out is to get this code out there
I'm afraid.

I have just written a blog post asking for people to check if
their laptop might be affected; and to report various details
to me of their laptop is affected:

https://hansdegoede.dreamwidth.org/26548.html

Lets wait and see how this goes. If I get (too) many reports then
I will send a revert of the addition of the:

 	if (acpi_video_get_backlight_type() != acpi_backlight_native)
 		return;

check to the i915 / radeon / amd / nouveau drivers.

(And if I only get a couple of reports I will probably just submit
DMI quirks for the affected models).

Regards,

Hans



