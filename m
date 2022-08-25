Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E0DC28D13
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 13:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9000F10E1F9;
	Thu, 25 Aug 2022 13:05:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7778F11B54E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 08:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661417684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7OWfNCpLdSo1viH5XGsi5IJxCkX8SeFaK11y2Vq0C60=;
 b=JjG106Rd4syvV61SMdTaGFUnpvDBnlWKn4u/qPh/3QxN0/4s+Gc3BuRyt0GTPncMmjvFUi
 6vHKXTNgeBNv8EZzT7OwHXh6I2mnzre4ZeURK2rOPXsw0fEuDTUGOiPY1wH8HBB8Gz/EN/
 NWmhPe1W6daQTok8Wvc/gUIh+SJnxeE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-347-e0M6Roy8NTO9CObGVJH9SA-1; Thu, 25 Aug 2022 04:54:41 -0400
X-MC-Unique: e0M6Roy8NTO9CObGVJH9SA-1
Received: by mail-ed1-f69.google.com with SMTP id
 x3-20020a05640226c300b00446ad76aeb5so7664473edd.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 01:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=7OWfNCpLdSo1viH5XGsi5IJxCkX8SeFaK11y2Vq0C60=;
 b=4s/QJYOVMQfeZQja8yh8LdKggK6raszeM6lXfeYEFDbVIW4JmjquYOionUUuSL7OSu
 22JUGgDhN3vUh5mXFPtjdnkFze77zJ7DmS2Z9yrjyqqD/OFLfMhFedUwTvGO5eGG3uVr
 u6n6h0aE/jkDArzCg3P2y2EM2hQSyfP2PpUqS1PuQG/8Q/WoH0//IfpNCvWBIkW2patz
 5e44da96bjOOF7cKW4fnvMXf2BckMmNfCdRAMp0Yx4dYQOL4XpJpYgGSr/S0KKlR+R/b
 dI3dzNWb/D1bwFOI71HIVQG0DUHWiqgyd/g+pecq9OvwNybeThw37bI8ZAOEREBo49R3
 qx4Q==
X-Gm-Message-State: ACgBeo1LxRBDHWQpb8tZIXcF5VavW+1JgHX5ZipMjAlIKAoWuTXbpxks
 JZyrbIJWxLT8QlCx5vZJzukMGqbQdDrdcR9IG5ubTG0rTdkeNeq52YiABcC144nZECpcPidd5gC
 R/BaE1FqfOxYpbufx5upT2t1PnA==
X-Received: by 2002:a17:907:728d:b0:731:8396:ea86 with SMTP id
 dt13-20020a170907728d00b007318396ea86mr1742627ejc.361.1661417679930; 
 Thu, 25 Aug 2022 01:54:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4iRqqUbLSIQozsEoevWSbUBOoNa7wZuPHEqVSEVtqoqW7Rc5PQi4B3ygUaYiDI2xHU+dtygQ==
X-Received: by 2002:a17:907:728d:b0:731:8396:ea86 with SMTP id
 dt13-20020a170907728d00b007318396ea86mr1742616ejc.361.1661417679691; 
 Thu, 25 Aug 2022 01:54:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81?
 (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
 by smtp.gmail.com with ESMTPSA id
 q23-20020a17090676d700b0073d74e1a467sm997841ejn.167.2022.08.25.01.54.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Aug 2022 01:54:39 -0700 (PDT)
Message-ID: <914dec00-65f4-f49c-9ace-39321b88e8b6@redhat.com>
Date: Thu, 25 Aug 2022 10:54:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 02/31] drm/i915: Don't register backlight when another
 backlight should be used
To: Jani Nikula <jani.nikula@linux.intel.com>, Ben Skeggs
 <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
 Lyude <lyude@redhat.com>, Daniel Dadap <ddadap@nvidia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>, Mark Gross <markgross@kernel.org>,
 Andy Shevchenko <andy@kernel.org>
References: <20220824121523.1291269-1-hdegoede@redhat.com>
 <20220824121523.1291269-3-hdegoede@redhat.com> <87v8qhiz4f.fsf@intel.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <87v8qhiz4f.fsf@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 25 Aug 2022 13:05:48 +0000
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
Cc: nouveau@lists.freedesktop.org, intel-gfx <intel-gfx@lists.freedesktop.org>,
 amd-gfx@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Len Brown <lenb@kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi All,

On 8/24/22 14:50, Jani Nikula wrote:
> On Wed, 24 Aug 2022, Hans de Goede <hdegoede@redhat.com> wrote:
>> Before this commit when we want userspace to use the acpi_video backlight
>> device we register both the GPU's native backlight device and acpi_video's
>> firmware acpi_video# backlight device. This relies on userspace preferring
>> firmware type backlight devices over native ones.
>>
>> Registering 2 backlight devices for a single display really is
>> undesirable, don't register the GPU's native backlight device when
>> another backlight device should be used.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/gpu/drm/i915/display/intel_backlight.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
>> index 681ebcda97ad..a4dd7924e0c1 100644
>> --- a/drivers/gpu/drm/i915/display/intel_backlight.c
>> +++ b/drivers/gpu/drm/i915/display/intel_backlight.c
>> @@ -8,6 +8,8 @@
>>  #include <linux/pwm.h>
>>  #include <linux/string_helpers.h>
>>  
>> +#include <acpi/video.h>
>> +
>>  #include "intel_backlight.h"
>>  #include "intel_backlight_regs.h"
>>  #include "intel_connector.h"
>> @@ -952,6 +954,11 @@ int intel_backlight_device_register(struct intel_connector *connector)
>>  
>>  	WARN_ON(panel->backlight.max == 0);
>>  
>> +	if (!acpi_video_backlight_use_native()) {
>> +		DRM_INFO("Skipping intel_backlight registration\n");
> 
> Could use drm_info with drm_device.

Ack, fixed for v5.

> Either way,
> 
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Thank you.

> and ack for merging via whichever tree suits you best.

My plan is to create a branch with the series on top
of 6.0-rc1 and then send a pull-req to all involved trees.

So far there are no conflicts between this branch and drm-tip...

Regards,

Hans



>> +		return 0;
>> +	}
>> +
>>  	memset(&props, 0, sizeof(props));
>>  	props.type = BACKLIGHT_RAW;
> 

