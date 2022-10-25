Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9A3FA373E
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 20:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 360D010E2C1;
	Tue, 25 Oct 2022 20:36:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0280310E31A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 20:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666729562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9XonFPheAhtCegE797S1mcjxSh0z0UskbUv2fBkcMxo=;
 b=FRopRUwrzlYZq3do1uVrwzsdOWphehJ4Pp+LxdIWfTX/LKqzLrZBuhtg2GydYTZrau7x+w
 kYZrEm8svu/1X1RHXvrrHfiRHWO0zaDV9V75ASejtdUArkagVYLY4hYNF27Am54RxMHC9U
 7vuy4r7EoGL+djI0LiJzKnClMbEgF58=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-550-z6S8zFjgMYW-vyUcxJM2vA-1; Tue, 25 Oct 2022 16:25:36 -0400
X-MC-Unique: z6S8zFjgMYW-vyUcxJM2vA-1
Received: by mail-ej1-f71.google.com with SMTP id
 hp41-20020a1709073e2900b0078e07dbf280so3344992ejc.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 13:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9XonFPheAhtCegE797S1mcjxSh0z0UskbUv2fBkcMxo=;
 b=JrmAGC20Pd5Cmu69ZFCZbFKGOQ0so089KNNlunzdl3dadvVvcLODOIm5GkdVuWY75c
 r1RC8OSSgHH1ZlPqFTLigWssiHeGVsdZ4RDR65BMc2mXevSg5rKqMTRb29AwYJGI43pg
 EIOeVVY8Xrkp279zfs55V4Uvd3FSYzV/8939ROiqfIrjVHi2MQQpDQUKH+91p2Q5Lzl3
 vwPIwbt0UdcnpREB/PCMfHPliLUfGObAT5NHSD84vntvPzo0xjaco+p7aeJVdbUhuMN9
 cKAnaa17t5t/LH9yOzacvMB29BkgVxPzn987ydob7/xrDZjFz5sRUrthLZoFA5oqz8zG
 dFbg==
X-Gm-Message-State: ACrzQf1sobViyjCT6QUW5DhsZm8Diu4v2jlb4swU7aq4EEEYZYsTxwLQ
 iqTQwFaMX/xTQhhQkEfYE7kFTu5pO5zYAWf1DE2szKdMBTOwVByY92s/l42d2TdfDLoLJiDw31b
 wb70d7AoN5d/VMMLgiTQ5wl4r0Q==
X-Received: by 2002:a05:6402:1906:b0:45d:db20:7709 with SMTP id
 e6-20020a056402190600b0045ddb207709mr36471740edz.406.1666729535537; 
 Tue, 25 Oct 2022 13:25:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4AvLy3/xx91WJDsytfb8il98Gi/jdDsRHk8yLwQ8ZaFqjnH6cleAwDsF1BomERvdjpliBAIA==
X-Received: by 2002:a05:6402:1906:b0:45d:db20:7709 with SMTP id
 e6-20020a056402190600b0045ddb207709mr36471704edz.406.1666729535300; 
 Tue, 25 Oct 2022 13:25:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81?
 (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
 by smtp.gmail.com with ESMTPSA id
 27-20020a508e1b000000b00456c6b4b777sm2150898edw.69.2022.10.25.13.25.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Oct 2022 13:25:34 -0700 (PDT)
Message-ID: <144cd47e-42dc-2b84-1a90-ea5e080e08a3@redhat.com>
Date: Tue, 25 Oct 2022 22:25:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v5 02/31] drm/i915: Don't register backlight when another
 backlight should be used (v2)
To: Matthew Garrett <mjg59@srcf.ucam.org>
References: <20220825143726.269890-1-hdegoede@redhat.com>
 <20220825143726.269890-3-hdegoede@redhat.com>
 <f914ceb3-94bd-743c-f8b6-0334086e731a@gmail.com>
 <42a5f2c9-a1dc-8fc0-7334-fe6c390ecfbb@redhat.com>
 <20221024203057.GA28675@srcf.ucam.org>
 <8f53b8b6-ead2-22f5-16f7-65b31f7cc05c@redhat.com>
 <20221025193248.GA21457@srcf.ucam.org>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221025193248.GA21457@srcf.ucam.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 25 Oct 2022 20:36:25 +0000
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
Cc: Pan@freedesktop.org, Karol Herbst <kherbst@redhat.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, nouveau@lists.freedesktop.org,
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

Hi Matthew,

On 10/25/22 21:32, Matthew Garrett wrote:
> On Tue, Oct 25, 2022 at 08:50:54PM +0200, Hans de Goede wrote:
> 
>> That is a valid point, but keep in mind that this is only used on ACPI
>> platforms and then only on devices with a builtin LCD panel and then
>> only by GPU drivers which actually call acpi_video_get_backlight_type(),
>> so e.g. not by all the ARM specific display drivers.
>>
>> So I believe that Chromebooks quite likely are the only devices with
>> this issue.
> 
> My laptop is, uh, weird, but it falls into this category.
>  
>>> I think for this to work correctly you need to have 
>>> the infrastructure be aware of whether or not a vendor interface exists, 
>>> which means having to handle cleanup if a vendor-specific module gets 
>>> loaded later.
>>
>> Getting rid of the whole ping-ponging of which backlight drivers
>> get loaded during boot was actually one of the goals of the rework
>> which landed in 6.1 this actually allowed us to remove some quirks
>> because some hw/firmware did not like us changing our mind and
>> switching backlight interfaces after first poking another one.
>> So we definitely don't want to go back to the ping-pong thing.
> 
> Defaulting to native but then having a vendor driver be able to disable 
> native drivers seems easiest? It shouldn't be a regression over the 
> previous state of affairs since both drivers were being loaded already.

Part of the reason for the ACPI backlight detect refactor is
because of a planned new backlight uAPI where the brightness
control becomes a property on the drm connector object, for a
RFC including the rationale behind this planned uAPI change see:
https://lore.kernel.org/dri-devel/b61d3eeb-6213-afac-2e70-7b9791c86d2e@redhat.com/

These plans require that there is only 1 backlight device
registered (per panel).

Having the native driver come and then go and be replaced
with the vendor driver would also be quite inconvenient
for these planned changes.

As such I would rather find a solution for your "weird"
laptop so that acpi_video_get_backlight_type() just always
returns vendor there.

Note that drivers/acpi/video_detect.c already has a DMI
quirk tables for models where the heuristics from
acpi_video_get_backlight_type() don't work. In general
we (mostly me) try to make it so that the heuristics
work on most models, to avoid needing to add every model
under the sun to the DMI quirk table, but if your laptop
is somehow special then adding a DMI quirk for it should
be fine ?

Can you perhaps explain a bit in what way your laptop
is weird ?

Note that technically if the native backlight does not work,
then the GPU driver really should not even try to register
it. But sometimes the video-bios-tables claim the backlight
pwm input is attached to the GPU while it is not and things
have evolved in such a way that the DMI quirks for that
live in acpi/video_detect.c rather then in the GPU driver.

Regards,

Hans

