Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4A7C6FD19
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 22:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 246CA10E746;
	Wed,  8 Mar 2023 22:22:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4103C10E732
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 22:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678313462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tS1S9aVmOjnSIgqLViqUgc8frkOLegPaG1y9hoCBPWk=;
 b=SE+CPo5kD+WP5YIxgDVvGs8ukyl2CgKtkIy1xsDpr7bksGE18rRdSDq+qDpp8X56xbglrH
 9+B2oJT9dLictp91N98hHS5qCJuV8X23TQBV+J6ci5B3byTPq1HDsHYZ68ga6ieB5s+cnt
 98ObicdNsBu+eR09Haoyr5newK1T0wQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-cvEMRrs0OfC_YdDz3DLmJw-1; Wed, 08 Mar 2023 17:11:00 -0500
X-MC-Unique: cvEMRrs0OfC_YdDz3DLmJw-1
Received: by mail-ed1-f72.google.com with SMTP id
 d35-20020a056402402300b004e37aed9832so16395913eda.18
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Mar 2023 14:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678313459;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tS1S9aVmOjnSIgqLViqUgc8frkOLegPaG1y9hoCBPWk=;
 b=6csvu1DZkZYQfjIaPNmTE/Ib8yxhu7hlyRbCs5ONxvjduTtGdZWBJbMaOULCQORcGX
 4YAwJgUIQrWz8+VzZaNjL/UdJl4H/sKsAbwq6rKMWrrfWd5E1uOwQWMIzvIKRvj+yPgZ
 OUxi8MxzofrViABlVOltfrsdMK9bdG1do86JT70r0DQ4fjMsKBQzIyRIyXQUzXiMqqXy
 kuP5ph2TZsfNUoYeSkFQkI8xLk4GuT1eV1VR7qLPzHmLAPtg8MlgKgPFerAoZkdkWp7I
 rdFqvhYUWOTyuhyUehf21zTGKPPW45FxGzV+QEK/JcIjW+caZgE3jnq4ajrzw+9kBXRN
 KuJw==
X-Gm-Message-State: AO0yUKXrVl/3C1bVBBBOBYpGUaFeHTHpxUCje5mc5GHAV4gQqSKJL9I+
 ryRyYi7rV2D3YSopGHDUN68e6gG2Ai+EE4tP/bP9Yu+kKQBQKGVwgQtgzS6YaeC2pwf2mQEwv4q
 2sS/QH2zmC8jiCDS2LVfDS6bN0w==
X-Received: by 2002:a17:907:d8f:b0:8b1:7ead:7d43 with SMTP id
 go15-20020a1709070d8f00b008b17ead7d43mr24491857ejc.50.1678313459596; 
 Wed, 08 Mar 2023 14:10:59 -0800 (PST)
X-Google-Smtp-Source: AK7set+/QxZfpdhXc5OLGQ8VvX9XYJNdPShUW/pAhAP3zrh4n7u0BdIxwkzgiVpdivXgSKe8KjOfSg==
X-Received: by 2002:a17:907:d8f:b0:8b1:7ead:7d43 with SMTP id
 go15-20020a1709070d8f00b008b17ead7d43mr24491836ejc.50.1678313459252; 
 Wed, 08 Mar 2023 14:10:59 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a17090665cf00b008de729c8a03sm8003494ejn.38.2023.03.08.14.10.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Mar 2023 14:10:58 -0800 (PST)
Message-ID: <08364719-3ae7-7213-2e90-a0aa1c5fee48@redhat.com>
Date: Wed, 8 Mar 2023 23:10:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC v2 0/6] drm/amd/display: Pass proper parent for DM backlight
 device v2
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230308215831.782266-1-hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230308215831.782266-1-hdegoede@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 08 Mar 2023 22:22:14 +0000
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

Hi,

On 3/8/23 22:58, Hans de Goede wrote:
> Hi All,
> 
> Here is version 2 of my patch series to pass the proper parent device
> to backlight_device_register().
> 
> New in version 2 is delaying the registering of the backlight_dev till
> after the drm_connector is registered by doing it from
> drm_connector_funcs.late_register.
> 
> This involves first reworking the code a bit to allow delaying
> the registering, so this has turned from a single patch into
> a 6 patch set.
> 
> Regards,
> 
> Hans

p.s.

Like last time this series is marked as RFC because I don't have hw
to test the fix myself. The previous version was tested by 2 reporters
of: https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/issues/730

I hope to get test results from them for this new version soon.


> 
> 
> Hans de Goede (6):
>   drm/amd/display/amdgpu_dm: Fix backlight_device_register() error
>     handling
>   drm/amd/display/amdgpu_dm: Refactor register_backlight_device()
>   drm/amd/display/amdgpu_dm: Add a bl_idx to amdgpu_dm_connector
>   drm/amd/display/amdgpu_dm: Move most backlight setup into
>     setup_backlight_device()
>   drm/amd/display/amdgpu_dm: Make amdgpu_dm_register_backlight_device()
>     take an amdgpu_dm_connector
>   drm/amd/display: Pass proper parent for DM backlight device
>     registration v2
> 
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 99 ++++++++-----------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
>  2 files changed, 44 insertions(+), 56 deletions(-)
> 

