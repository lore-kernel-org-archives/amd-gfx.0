Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E7AC61DA4
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Mar 2023 16:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82AEC10E0E9;
	Sat, 11 Mar 2023 16:01:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A253710E0A3
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Mar 2023 10:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678531203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMVyit9KoTVwnZdvsgo8VYbd90GtcYARP5wwOTF3/G4=;
 b=PNPhVHzUSDwZnDJDKr7PCt2dan4TyTRsepKtXI3+BAtT8bBkmVIHXiRCIvzg1X6vNU3Jz7
 sRcQ1f29mqJiZqN/RsmJPK3gI/y7MQ3/ySucw1/kDERr9GEm4npjNIJ6tb8s/yVsblbLya
 LnCEBo6OgzkRKe+NQ8q+nOJBE0J5pOs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-sdSLEE-RO9Srhnvjxdh76g-1; Sat, 11 Mar 2023 05:40:00 -0500
X-MC-Unique: sdSLEE-RO9Srhnvjxdh76g-1
Received: by mail-ed1-f70.google.com with SMTP id
 q13-20020a5085cd000000b004af50de0bcfso11051823edh.15
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Mar 2023 02:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678531199;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nMVyit9KoTVwnZdvsgo8VYbd90GtcYARP5wwOTF3/G4=;
 b=tEdltgCOi9c+7SG4cJCcSCLQJGs1Hb11aJBsWJ/TZ5t6BVZ3Tth0owdVcNx4kZNaq1
 /kgxD4FfszfKxQAyG5CDTFLAVpMKvEhXiU8or8D73Bk1DRaGbwyd2HaVOhkTBIsNmCMo
 LsvJgSFBx3XwSWyc6ToLTyu3JILKsZZVcA5Xf5cfZHbNidatma0A0X9b5GhkZ5xwbxee
 yXn1Je61yajvqiN9fcbpuCOD52MvnGa+CGeqGHToyCyHTS5fqcPXm8KAVbezMG/HgLhR
 k3iQWwGt+C6YrlW5BklBa0cKx+dPjVuby0hKDkP9p0aJqEHuBgeuXIT87c5wTfdUINM4
 ZOvw==
X-Gm-Message-State: AO0yUKXT5Gn1Xry97TIZgQBLumWpx0tIGzbwrrjtfOLd87l6wf7PL4aq
 nydEwKfYiJDkGrpzezBBTXRKTnzza0B092yWwFM07XTS1Hly7LSUw8Dy7/YNfoSQU1GMSFB0Nij
 btTzkk0P/uNm2HcqNzEPL2RRQ5w==
X-Received: by 2002:a17:906:1481:b0:8b1:7ae8:ba6f with SMTP id
 x1-20020a170906148100b008b17ae8ba6fmr27001882ejc.16.1678531199075; 
 Sat, 11 Mar 2023 02:39:59 -0800 (PST)
X-Google-Smtp-Source: AK7set910RS+EXo716Ddx3LyA/RnltmgjANkhTbuK3TVY0iwKhD3ubwTYgFFgCFRquhY4jeR2NJZZw==
X-Received: by 2002:a17:906:1481:b0:8b1:7ae8:ba6f with SMTP id
 x1-20020a170906148100b008b17ae8ba6fmr27001869ejc.16.1678531198815; 
 Sat, 11 Mar 2023 02:39:58 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a17090674ca00b008c327bef167sm980894ejl.7.2023.03.11.02.39.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Mar 2023 02:39:58 -0800 (PST)
Message-ID: <95d4a9f4-9389-f1ee-44e7-44fd6571cb2c@redhat.com>
Date: Sat, 11 Mar 2023 11:39:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC v2 0/6] drm/amd/display: Pass proper parent for DM backlight
 device v2
To: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
References: <20230308215831.782266-1-hdegoede@redhat.com>
 <6fd35bd4-4edf-575c-8875-1cb256f414d5@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <6fd35bd4-4edf-575c-8875-1cb256f414d5@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Mar 2023 16:01:46 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Rodrigo,

On 3/10/23 23:12, Rodrigo Siqueira Jordao wrote:
> Hi Hans,
> 
> Which AMD device do you have available for testing this series?

As mentioned in a reply to the cover-letter (should have been
in the cover-letter itself but I forgot, sorry. I don't have
any hw to test this which is why this was marked as a RFC.

In the mean time 2 reporters of:

https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/issues/730

who have affected hw hitting the changed code paths have
confirmed that this series works and that the correct
parent now gets set.

So as I also already mentioned in a reply to the cover-letter (1):

this series no longer is RFC, but is ready for merging (from my pov) now.

> P.s.: If you have a new version of this series, could you also Cc me?

Sure, although atm I see no need to do a new version, please consider
this a non RFC submission now and review it. If the review leads to
changes being requested then I'll prepare a new version and Cc you.

Regards,

Hans



1) Next time mayvw read the entire thread before replying ?








> On 3/8/23 14:58, Hans de Goede wrote:
>> Hi All,
>>
>> Here is version 2 of my patch series to pass the proper parent device
>> to backlight_device_register().
>>
>> New in version 2 is delaying the registering of the backlight_dev till
>> after the drm_connector is registered by doing it from
>> drm_connector_funcs.late_register.
>>
>> This involves first reworking the code a bit to allow delaying
>> the registering, so this has turned from a single patch into
>> a 6 patch set.
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
>>    drm/amd/display: Pass proper parent for DM backlight device
>>      registration v2
>>
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 99 ++++++++-----------
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
>>   2 files changed, 44 insertions(+), 56 deletions(-)
>>
> 

