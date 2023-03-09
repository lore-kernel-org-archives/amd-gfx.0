Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AF8C64EC4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Mar 2023 09:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B7110E7C8;
	Thu,  9 Mar 2023 09:33:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E565410E167
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Mar 2023 08:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678351908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iz+YxaxbQLLfNssBhmL+3wl9ODU3eDTosuVxq/5D9Ek=;
 b=cP+Jul2qJ0jU9RQ8F9e+YvU1N38SsLHbYSZPUGy+hYsCpvoNERzr2qEQP3XsgD5ieRiJwS
 wlb3YhDZgxxbj/oqy9KwHgyoe2PAJ9E7YC8FS9zLYyY37lQBKhXwVDZXI9FUjI5ZDbQWEl
 jKq8fJ13X6mXlmqODkUXGc+4fBW2mdI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-Hpz8UUxiN_K1ASvnaiv3bQ-1; Thu, 09 Mar 2023 03:51:47 -0500
X-MC-Unique: Hpz8UUxiN_K1ASvnaiv3bQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 w7-20020a056402268700b004bbcdf3751bso1951858edd.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Mar 2023 00:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678351906;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Iz+YxaxbQLLfNssBhmL+3wl9ODU3eDTosuVxq/5D9Ek=;
 b=HEfs21utI7KX1jDBVf51DLCcnx+hDGtFzDoISQKYgi+GoCT6WN4F4FnQ29v1iUbs1j
 vIrFrGdbs5sdKD5jiptBHqStn6Fva14bK9HuFN1hmWrooJRMivR0Hw+eJAp0axH5OMHd
 ZNULTW68TiP3oYCotbwPQquAhnsxbLwoh03JyVN0D1Tcuo0W48V6ly9rLovR0FqgKFSy
 cfAC9AMB7iBXAUbvbY0kZycH5T5OOLifW7/5o+BxEF3CGEAVtvKJXHrd56bHK9Zmwp73
 l2x2muLJpsxvyqDftod1sLWweWRYrKhuCSSe4HEg6UHftTfebPx0ngjMhb6oaU4blc6s
 TuIQ==
X-Gm-Message-State: AO0yUKUnYA+XYI7u3htWFMO9O3VonG3Vg7jmMG4KwniVc/SlasqiAeTH
 KY1af4i5rVtDNLxbin0prc8BjLcdszP0+2qogw6/jY2KKOgoDEzKcTWJxfgpcxXOPwLzxngAWGn
 FQ+D/d6m06fhZsBC+dSJxus9TzQ==
X-Received: by 2002:a17:907:3f18:b0:8f6:5a70:cccc with SMTP id
 hq24-20020a1709073f1800b008f65a70ccccmr27296546ejc.66.1678351906375; 
 Thu, 09 Mar 2023 00:51:46 -0800 (PST)
X-Google-Smtp-Source: AK7set8ZJlKmr7LwwY7HzE4thVVJydV0N08hZGQJFDfZIGiK/yyptwohH0nXi/zVnjrQOmaW2x/LmQ==
X-Received: by 2002:a17:907:3f18:b0:8f6:5a70:cccc with SMTP id
 hq24-20020a1709073f1800b008f65a70ccccmr27296534ejc.66.1678351906128; 
 Thu, 09 Mar 2023 00:51:46 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a1709063c4900b008d427df3245sm8596552ejg.58.2023.03.09.00.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Mar 2023 00:51:45 -0800 (PST)
Message-ID: <40b30b48-9d5c-f223-c31c-b3e094b224b3@redhat.com>
Date: Thu, 9 Mar 2023 09:51:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC v2 0/6] drm/amd/display: Pass proper parent for DM backlight
 device v2
From: Hans de Goede <hdegoede@redhat.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230308215831.782266-1-hdegoede@redhat.com>
 <08364719-3ae7-7213-2e90-a0aa1c5fee48@redhat.com>
In-Reply-To: <08364719-3ae7-7213-2e90-a0aa1c5fee48@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 09 Mar 2023 09:33:28 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi all,

On 3/8/23 23:10, Hans de Goede wrote:
> Hi,
> 
> On 3/8/23 22:58, Hans de Goede wrote:
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
> 
> p.s.
> 
> Like last time this series is marked as RFC because I don't have hw
> to test the fix myself. The previous version was tested by 2 reporters
> of: https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/issues/730
> 
> I hope to get test results from them for this new version soon.

I just heard back from one of the reporters that this fixes gnome-settings-daemon
picking the wrong backlight device on a hybrid gfx laptop where both GPU-s
register a native backlight control.

So this series no longer is RFC, but is ready for merging (from my pov) now.

Regards,

Hans





>> Hans de Goede (6):
>>   drm/amd/display/amdgpu_dm: Fix backlight_device_register() error
>>     handling
>>   drm/amd/display/amdgpu_dm: Refactor register_backlight_device()
>>   drm/amd/display/amdgpu_dm: Add a bl_idx to amdgpu_dm_connector
>>   drm/amd/display/amdgpu_dm: Move most backlight setup into
>>     setup_backlight_device()
>>   drm/amd/display/amdgpu_dm: Make amdgpu_dm_register_backlight_device()
>>     take an amdgpu_dm_connector
>>   drm/amd/display: Pass proper parent for DM backlight device
>>     registration v2
>>
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 99 ++++++++-----------
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
>>  2 files changed, 44 insertions(+), 56 deletions(-)
>>
> 

