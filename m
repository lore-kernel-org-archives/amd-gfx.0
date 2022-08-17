Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055A2C25B08
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Aug 2022 13:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8426093321;
	Wed, 17 Aug 2022 13:36:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E0CC91B95
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Aug 2022 13:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660741556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Bb7dToDVYNe7JAROkpJKR5S/ALfzfxwMNw63SU+PbA=;
 b=RfEXLVpNPJzukI07gkHr6bJKuRovi0cXaqrth4OcVrIrjXSY97c2voG+ppLYo+Sdh6CLFu
 IRDAy5WaizWArD7vNktAELNfceWiq+uFdWfqJM89A2YgXmd5MCXRXyMfkEzf0q1rZz5zX1
 Owv9CaEvx6YVoyMo+BlMBWUR7D8dN2Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-390-z06IJkrDNE-cDNRP9vVf7g-1; Wed, 17 Aug 2022 09:05:54 -0400
X-MC-Unique: z06IJkrDNE-cDNRP9vVf7g-1
Received: by mail-ed1-f71.google.com with SMTP id
 o2-20020a056402438200b0043d552deb2aso8673097edc.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Aug 2022 06:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=5Bb7dToDVYNe7JAROkpJKR5S/ALfzfxwMNw63SU+PbA=;
 b=VykYfVT5z+klFVZ+57+IySKwxR01IvgO4+UwQAKzxZ570IU3BKyGVDF1zj5HkLY89C
 sqtyYOpMhkgX7ZAa4Kr9a8Y+77z/GJ/caoiVe0ta9TvCORaecM8FTm4CRLwIFQ/B+5na
 R7rXH+cNuZmZGowqJ4kxCl++q0xv9nTIwouK/Dzy5pKjEAnOmFD2mYszftqd6Vp5KE3e
 P6Ihh694/MW2o6nbRQ0WORGupe0zTPdsub5MiM/boIdGRebZ3sOWUK7emOBxXfmoJAHO
 N4SnmpzcQ2wktBw1hQL3OoR6QcN3Oc7IL37Z+2iBIEJI4s83DJl2Li3PiLoTEvDM9I6a
 Xmfw==
X-Gm-Message-State: ACgBeo27rg/ufgx/7y9vAa+kjgkT2ZiALayaGoXaww30hN0bSfHSjLxs
 IxbbCP4ZiOhEYzU1zieAUYJFrh3ZduzGhzGzTSVvvr94BybTjjYR1ofoDTwVS/Hm48Ul/h4C+mP
 XY53zj8Iuqj20hTH1dNYOWntB5g==
X-Received: by 2002:a05:6402:438d:b0:43d:b383:660f with SMTP id
 o13-20020a056402438d00b0043db383660fmr22910431edc.283.1660741553758; 
 Wed, 17 Aug 2022 06:05:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4s4Ny0f0Ire0xndhK1NrT/mXOvYYx89AxmZwcwm0z10Nafkp7oHY0nXhWi10Hz10jrx9IRwA==
X-Received: by 2002:a05:6402:438d:b0:43d:b383:660f with SMTP id
 o13-20020a056402438d00b0043db383660fmr22910393edc.283.1660741553531; 
 Wed, 17 Aug 2022 06:05:53 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81?
 (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
 by smtp.gmail.com with ESMTPSA id
 e20-20020a50ec94000000b0043c83ac66e3sm10606845edr.92.2022.08.17.06.05.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Aug 2022 06:05:52 -0700 (PDT)
Message-ID: <13f55d75-ce98-5ee7-9d7c-5205dfcf1582@redhat.com>
Date: Wed, 17 Aug 2022 15:05:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 03/29] drm/amdgpu: Don't register backlight when
 another backlight should be used
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220712193910.439171-1-hdegoede@redhat.com>
 <20220712193910.439171-4-hdegoede@redhat.com>
 <CADnq5_PcpwtgdBrn7_1B4Fq5CNGbkSO94c5Qzf8NfbnpwBqHAw@mail.gmail.com>
 <CADnq5_PBMtshPza9yRAZCEtwVSiHAs6AY8B8CttHF8ZyLuiX6w@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CADnq5_PBMtshPza9yRAZCEtwVSiHAs6AY8B8CttHF8ZyLuiX6w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 17 Aug 2022 13:35:56 +0000
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
 "Rafael J . Wysocki" <rafael@kernel.org>, David Airlie <airlied@linux.ie>,
 nouveau@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 Ben Skeggs <bskeggs@redhat.com>, Len Brown <lenb@kernel.org>,
 Daniel Dadap <ddadap@nvidia.com>, intel-gfx <intel-gfx@lists.freedesktop.org>,
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

On 7/20/22 18:46, Alex Deucher wrote:
> On Wed, Jul 20, 2022 at 12:44 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> On Tue, Jul 12, 2022 at 3:39 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Before this commit when we want userspace to use the acpi_video backlight
>>> device we register both the GPU's native backlight device and acpi_video's
>>> firmware acpi_video# backlight device. This relies on userspace preferring
>>> firmware type backlight devices over native ones.
>>>
>>> Registering 2 backlight devices for a single display really is
>>> undesirable, don't register the GPU's native backlight device when
>>> another backlight device should be used.
>>>
>>> Changes in v2:
>>> - To avoid linker errors when amdgpu is builtin and video_detect.c is in
>>>   a module, select ACPI_VIDEO and its deps if ACPI && X86 are enabled.
>>>   When these are not set, ACPI_VIDEO is disabled, ensuring the stubs
>>>   from acpi/video.h will be used.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Actually, can you use dev_info for the messages below rather than
> DRM_INFO?  That makes it easier to tell which GPU is affected in a
> multi-GPU system.  With that changed,
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Thank you for the ack. I've changed the DRM_INFO(...) calls with
drm_info(drm_dev, ...) calls for the version 3 of this series
which I'm preparing.

Regards,

Hans


> 
>>
>>> ---
>>>  drivers/gpu/drm/Kconfig                           | 6 ++++++
>>>  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c    | 7 +++++++
>>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
>>>  3 files changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>>> index aaa7ad1f0614..d65119860760 100644
>>> --- a/drivers/gpu/drm/Kconfig
>>> +++ b/drivers/gpu/drm/Kconfig
>>> @@ -258,6 +258,12 @@ config DRM_AMDGPU
>>>         select HWMON
>>>         select BACKLIGHT_CLASS_DEVICE
>>>         select INTERVAL_TREE
>>> +       # amdgpu depends on ACPI_VIDEO when X86 and ACPI are both enabled
>>> +       # for select to work, ACPI_VIDEO's dependencies must also be selected
>>> +       select INPUT if ACPI && X86
>>> +       select X86_PLATFORM_DEVICES if ACPI && X86
>>> +       select ACPI_WMI if ACPI && X86
>>> +       select ACPI_VIDEO if ACPI && X86
>>>         help
>>>           Choose this option if you have a recent AMD Radeon graphics card.
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
>>> index fa7421afb9a6..abf209e36fca 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
>>> @@ -26,6 +26,8 @@
>>>
>>>  #include <linux/pci.h>
>>>
>>> +#include <acpi/video.h>
>>> +
>>>  #include <drm/drm_crtc_helper.h>
>>>  #include <drm/amdgpu_drm.h>
>>>  #include "amdgpu.h"
>>> @@ -184,6 +186,11 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
>>>         if (!(adev->mode_info.firmware_flags & ATOM_BIOS_INFO_BL_CONTROLLED_BY_GPU))
>>>                 return;
>>>
>>> +       if (!acpi_video_backlight_use_native()) {
>>> +               DRM_INFO("Skipping amdgpu atom DIG backlight registration\n");
>>> +               return;
>>> +       }
>>> +
>>>         pdata = kmalloc(sizeof(struct amdgpu_backlight_privdata), GFP_KERNEL);
>>>         if (!pdata) {
>>>                 DRM_ERROR("Memory allocation failed\n");
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 5eb111d35793..3b03a95e59a8 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -86,6 +86,8 @@
>>>  #include <drm/drm_audio_component.h>
>>>  #include <drm/drm_gem_atomic_helper.h>
>>>
>>> +#include <acpi/video.h>
>>> +
>>>  #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
>>>
>>>  #include "dcn/dcn_1_0_offset.h"
>>> @@ -4050,6 +4052,11 @@ amdgpu_dm_register_backlight_device(struct amdgpu_display_manager *dm)
>>>         amdgpu_dm_update_backlight_caps(dm, dm->num_of_edps);
>>>         dm->brightness[dm->num_of_edps] = AMDGPU_MAX_BL_LEVEL;
>>>
>>> +       if (!acpi_video_backlight_use_native()) {
>>> +               DRM_INFO("Skipping amdgpu DM backlight registration\n");
>>> +               return;
>>> +       }
>>> +
>>>         props.max_brightness = AMDGPU_MAX_BL_LEVEL;
>>>         props.brightness = AMDGPU_MAX_BL_LEVEL;
>>>         props.type = BACKLIGHT_RAW;
>>> --
>>> 2.36.0
>>>
> 

