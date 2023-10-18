Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97115CDB482
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 19:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E958A10E455;
	Wed, 18 Oct 2023 19:44:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 046FB10E454
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 19:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697656100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DbHVcLfAbll6mrcfBWXl4iis7+24sALhp3ul/LsYEr0=;
 b=J0ZB1uhu87pZ11/aRXHyaj7tyJUntSQqSx9ki7j5yh1gHYSv/+KNlv/V1lObECDO48dSdl
 49Ym4ehy9D+lSAs1In6egDRQgIbRxhfH63zl+7RABwYdelwtSVNypQVF/mlt0cta/OQ4et
 ia4+N7qEUnRwoL+Nd/f+eTrWvqcZWro=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-31eDbpo-OrSO63H9PcCYxw-1; Wed, 18 Oct 2023 15:08:18 -0400
X-MC-Unique: 31eDbpo-OrSO63H9PcCYxw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5218b9647a8so5396264a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 12:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697656097; x=1698260897;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DbHVcLfAbll6mrcfBWXl4iis7+24sALhp3ul/LsYEr0=;
 b=ZsDLYqUD8HcLAUwHwtknnXUWdKGTWP8PH5QVQ7LG7l75kDoqzciir9woYhtMDD0Ozk
 kGgO5FCHEodnG0eVZI7NftcPddFJkfqrDvB2pfpKfJmOA94MuqL2nqToQNv/C25+cXVH
 M4No5ZT7Hn2936Io7E1g2qZdVtWUDJ3NYrGEmCHpSUojH6z8PAq89k3KE/bn9PyIKxIk
 8l/9DTbr3EeIaDA1MtEa6DDLCWYK9dhZE7WI0phGj1WCuCSEfzGmCslVzdjTVtRkH2fy
 22x9dJHV0zQoblpZAMSxY4/nI8GX7FCdDaTP1UQkqX10zcLoTKPv2VXCArQM3JhTN//X
 IxBg==
X-Gm-Message-State: AOJu0YyjVbcEqBLd1dYbEoTJ2MnoIwtGzogdgV4OtXGBvSTDbn1eDI0P
 FmCE3fHZD84d4DUzwAFrMV1TnjlLmSlYDLxDXzYUseYsjHV8IcAvfpL38Hofhp0lcDTd6hsb+8a
 uqilnSDU/mw07s+Z+4wHlupR3ng==
X-Received: by 2002:a50:ab5d:0:b0:533:c55f:5830 with SMTP id
 t29-20020a50ab5d000000b00533c55f5830mr4239391edc.28.1697656097152; 
 Wed, 18 Oct 2023 12:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgCEzPFiGzOVlfxm8KBiyEhgH99a614kciOPwziYd2W/4GtdvNokWo3YOfqj5GA+Y8qMizbw==
X-Received: by 2002:a50:ab5d:0:b0:533:c55f:5830 with SMTP id
 t29-20020a50ab5d000000b00533c55f5830mr4239371edc.28.1697656096807; 
 Wed, 18 Oct 2023 12:08:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 i23-20020a508717000000b0053db1ca293asm3286587edb.19.2023.10.18.12.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 12:08:16 -0700 (PDT)
Message-ID: <e143bbe2-212c-cfc8-131f-8ec9c0bff56d@redhat.com>
Date: Wed, 18 Oct 2023 21:08:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 13/17] platform/x86/amd/pmf: Add PMF-AMDGPU get
 interface
To: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20231018070241.2041529-1-Shyam-sundar.S-k@amd.com>
 <20231018070241.2041529-14-Shyam-sundar.S-k@amd.com>
 <9e6c4a42-fbce-c5ea-15ce-5eb22fc3767a@linux.intel.com>
 <84af64f2-42bd-4e09-a1c9-bde2a935c8f2@amd.com>
 <92bba3b3-a3f9-4fab-86c7-4d0ef4c23fcb@amd.com>
 <238f915f-b95f-4d85-ad67-66781f53e75d@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <238f915f-b95f-4d85-ad67-66781f53e75d@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Oct 2023 19:44:46 +0000
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
Cc: Xinhui.Pan@amd.com, Patil.Reddy@amd.com, basavaraj.natikar@amd.com,
 jikos@kernel.org, amd-gfx@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, markgross@kernel.org,
 benjamin.tissoires@redhat.com, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, linux-input@vger.kernel.org, alexander.deucher@amd.com,
 airlied@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

I was not following this at first, so my apologies for
jumping in in the middle of the thread:


<snip>

>>>>> +static int amd_pmf_gpu_get_cur_state(struct thermal_cooling_device *cooling_dev,
>>>>> +                     unsigned long *state)
>>>>> +{
>>>>> +    struct backlight_device *bd;
>>>>> +
>>>>> +    if (!acpi_video_backlight_use_native())
>>>>> +        return -ENODEV;
>>>>> +
>>>>> +    bd = backlight_device_get_by_type(BACKLIGHT_RAW);
>>>>> +    if (!bd)
>>>>> +        return -ENODEV;
>>>>> +
>>>>> +    *state = backlight_get_brightness(bd);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int amd_pmf_gpu_get_max_state(struct thermal_cooling_device *cooling_dev,
>>>>> +                     unsigned long *state)
>>>>> +{
>>>>> +    struct backlight_device *bd;
>>>>> +
>>>>> +    if (!acpi_video_backlight_use_native())
>>>>> +        return -ENODEV;
>>>>> +
>>>>> +    bd = backlight_device_get_by_type(BACKLIGHT_RAW);
>>>>> +    if (!bd)
>>>>> +        return -ENODEV;
>>>>> +
>>>>> +    if (backlight_is_blank(bd))
>>>>> +        *state = 0;
>>>>> +    else
>>>>> +        *state = bd->props.max_brightness;
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static const struct thermal_cooling_device_ops bd_cooling_ops = {
>>>>> +    .get_max_state = amd_pmf_gpu_get_max_state,
>>>>> +    .get_cur_state = amd_pmf_gpu_get_cur_state,
>>>>> +};

So first of all, good to see that this is using the
thermal_cooling_device APIs now, that is great thank you.

But the whole idea behind using the thermal_cooling_device APIs
is that amdgpu exports the cooling_device itself, rather then have
the AMD PMF code export it. Now the AMD PMF code is still poking
at the backlight_device itself, while the idea was to delegate
this to the GPU driver.

Actually seeing all the acpi_video_backlight_use_native()
checks here, I wonder why only have this work with native backlight
control. One step better would be to add thermal_cooling_device
support to the backlight core in:
drivers/video/backlight/backlight.c

Then it will work with any backlight control provider!



Last but not least this code MUST not call
acpi_video_backlight_use_native()

No code other then native GPU drivers must ever call
acpi_video_backlight_use_native(). This special function
not only checks if the native backlight control is the
one which the detection code in drivers/acpi/video_detect.c
has selected, it also signals to video_detect.c that
native GPU backlight control is available.

So by calling this in the AMD PMF code you are now
telling video_detect.c that native GPU backlight control
is available on all systems where AMD PMF runs.

As I already said I really believe the whole cooling
device should be registered somewhere else. But if you
do end up sticking with this then you MUST replace
the acpi_video_backlight_use_native() calls with:

	if (acpi_video_get_backlight_type() == acpi_backlight_native) {...}

Regards,

Hans



