Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19EBC6FD1F
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Mar 2023 15:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72FA910E148;
	Thu, 16 Mar 2023 15:44:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E2310E0BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Mar 2023 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678978973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jY8tzGQNjdwb5AV1ogYiu/Q7DYs826VwBy6MyVJ9bVQ=;
 b=R8FOlTxoeVKSkWPMAbNH0o9CVJf7tAFaMsHO6p3Bs+ZQbmxfVo9IJakc5rWqKwE9xZZFSg
 HEgXXBXiXVoJYX2kxsmVG7xqw4Ixo8voPOpIjuy97YsF+7ANHNhesgYgrTLP0R0CnfTSVy
 BtRcMWABiWE2PumEPaaSVHjDJCexkRI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-FfBWjV8HO9uuo87Fu3RFAg-1; Thu, 16 Mar 2023 11:02:52 -0400
X-MC-Unique: FfBWjV8HO9uuo87Fu3RFAg-1
Received: by mail-ed1-f72.google.com with SMTP id
 r19-20020a50aad3000000b005002e950cd3so3503944edc.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Mar 2023 08:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678978971;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jY8tzGQNjdwb5AV1ogYiu/Q7DYs826VwBy6MyVJ9bVQ=;
 b=CqJ6fubHqQ9HlZKCGpbKpUz/OLVibbifU3/hyv3awIxtXjxjT0XFNZjdCel1K95hlB
 6OV74kFg+CjqRCKSjjUaGvm3Nm50yPuuyu2aRdRvgvEL3MEhrqir1c3quE3K7ZpFuFJj
 B093AvLjDsH3nu/yuziuuT5GSUOJ51mlWBLVvIMnpDneLPJwyUYg0Zs20/TuxWBrjraF
 LCv5dEZb9u2DZAbsmqsgTTjJHE/dnJ48cfYLEq/LqJVMXP+3s0qyMlc3ftuA/fIhV3aq
 fB5duLj8rzUWll7SeKnZdEN34DkPr4TMoXsaz/gsvbg8kzYVvB1t7bwiZz5imZUskj5Z
 VUUw==
X-Gm-Message-State: AO0yUKUPDAGbP9LVV58o0PmE4KeJ+7CzXYPHtCSPs3vldup/rHe+n4jH
 R3L/GonuF/9FhWWSb+YBDOLOqfALuQn3Rh2+nG/C1rJ/GZgC3mjq701s8GWBatu+B/NKstZGPHd
 C7CZmKOixGzfZ1ZTgarHi2P6uqw==
X-Received: by 2002:a05:6402:1650:b0:4ac:d34b:c2a9 with SMTP id
 s16-20020a056402165000b004acd34bc2a9mr6897123edx.14.1678978970816; 
 Thu, 16 Mar 2023 08:02:50 -0700 (PDT)
X-Google-Smtp-Source: AK7set8YIksd4HCeq7ROKhIXx9rVRRqIRT5xMR2tx6p6M225OXzzg0V8axX03pMoite5dmf9wPYmkA==
X-Received: by 2002:a05:6402:1650:b0:4ac:d34b:c2a9 with SMTP id
 s16-20020a056402165000b004acd34bc2a9mr6897101edx.14.1678978970573; 
 Thu, 16 Mar 2023 08:02:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a509b42000000b004e48f8df7e2sm3914730edj.72.2023.03.16.08.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Mar 2023 08:02:50 -0700 (PDT)
Message-ID: <2251e54e-5524-ba99-690a-9e8324cf112b@redhat.com>
Date: Thu, 16 Mar 2023 16:02:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 0/6] drm/amd/display: Pass proper parent for DM
 backlight device v3
To: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
References: <20230312191751.183450-1-hdegoede@redhat.com>
 <9e79184f-8894-8773-3a30-d35d0cf36b13@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <9e79184f-8894-8773-3a30-d35d0cf36b13@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Mar 2023 15:44:28 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 3/16/23 15:57, Rodrigo Siqueira Jordao wrote:
> 
> 
> On 3/12/23 13:17, Hans de Goede wrote:
>> Hi All,
>>
>> Here is version 3 of my patch series to pass the proper parent device
>> to backlight_device_register().
>>
>> Changes in v3:
>> - Make amdgpu_dm_register_backlight_device() check bl_idx != 1 before
>>    registering the backlight since amdgpu_dm_connector_late_register()
>>    now calls it for _all_ connectors.
>>
>> Changes in v2:
>> - Patches 1 - 5 are new, reworking the code a bit to allow delaying
>>    the registering, so this has turned from a single patch into
>>    a 6 patch set.
>> - Patch 6 now delays the registering of the backlight_dev till
>>    after the drm_connector is registered by doing it from
>>    drm_connector_funcs.late_register.
>>
>> Note this no longer is RFC since this has been successfully
>> tested on 3 laptops which hit the affected code path.
>>
>> Version 3 has also been tested on my personal AMD Ryzen 7 5700G APU
>> desktop machine and now no longer tries to register a backlight
>> device for each connector there.
>>
>> Regards,
>>
>> Hans
>>
>>
>> Hans de Goede (6):
>>    drm/amd/display/amdgpu_dm: Fix backlight_device_register() error
>>      handling
>>    drm/amd/display/amdgpu_dm: Refactor register_backlight_device()
>>    drm/amd/display/amdgpu_dm: Add a bl_idx to amdgpu_dm_connector
>>    drm/amd/display/amdgpu_dm: Move most backlight setup into
>>      setup_backlight_device()
>>    drm/amd/display/amdgpu_dm: Make amdgpu_dm_register_backlight_device()
>>      take an amdgpu_dm_connector
>>    drm/amd/display/amdgpu_dm: Pass proper parent for backlight device
>>      registration v3
>>
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 100 ++++++++----------
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
>>   2 files changed, 46 insertions(+), 55 deletions(-)
>>
> 
> Hi,
> 
> First of all, thanks a lot for this patchset.
> 
> I run your series in our CI (IGT-based), and I also conducted some manual tests in my ASICs. Everything looks fine.
> 
> I also reviewed this series, and it LGTM:
> 
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> 
> Finally, I pushed it to amd-staging-drm-next.

Great, thank you.

Regards,

Hans


