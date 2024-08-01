Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84633C52D71
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Aug 2024 07:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE36910E9A2;
	Fri,  2 Aug 2024 07:37:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="aZWGtoKe";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E481A10E8BE
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 08:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722502380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=23VtBrMdg+e86oIyAKkk0gIRsQUKPk9UYAypqYqSedk=;
 b=aZWGtoKel4L7aHOGN3f7Mli23mydx/7eLbW1Nbm3unmJ7cwXCsj/lgCgmxGSTjDopYBSh+
 3MWGZOT4pGSE4Vkclai54gybZHHCCrlGF11P5YAN0ajstmhjt4ViZyj4RR0dzspAU+1dIG
 SZe/lyD0nAwtPr/jzEqJiZes1OkpX3Y=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-Z583f4PfOiqD7FlnFbUkog-1; Thu, 01 Aug 2024 04:52:59 -0400
X-MC-Unique: Z583f4PfOiqD7FlnFbUkog-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ef233fb86bso75487211fa.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Aug 2024 01:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722502378; x=1723107178;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=23VtBrMdg+e86oIyAKkk0gIRsQUKPk9UYAypqYqSedk=;
 b=IKXdDgN1GG328Eodd+evfEnqQpaR3RxZV9BpAK45SMb3AdkC8tUXVqr6Sg0Cfl5BMC
 0q70IXPxcgBaN4cVmOLJV9QbrZf+2gD6ekT2DWEjl86HEMJJj+/uLw7X5h9EZA4eG/pH
 xtS7841yoAzcDmvp/2+MvU5fsVWoJSEmWyHJqP47k3QGCddXpNyy7Idvmby67H4/uG53
 kUMEdKxF6Nf80PzQ216D6f5PeZKc0svnoYfUPHN2RbopbSnbuX28+bM27VvIWPNO1Ti1
 AqhUgV98rlwDTvZP2XXcG/aLhiug4zqzFZSX4jTYx61nad3AGzZyZQFtUKn/PTmUOGur
 Sb3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHQE+szIXxstICLHKq7hLya10HoteyyKmrLSNFpVym4+pJqAc8Iz03muKrIzv9ItKY7b9FdDHIzyJ+idfzRe3v1MPE4V7ZWes7CS63CA==
X-Gm-Message-State: AOJu0YxAiz4rVEAYV9GV7O0mT3A4Pr/p4DdeRfmCSSZtJAguVoPoWhK+
 fAcybAmGxCMjsYPeQR8fv0aNI6pKByeFurICe0nG4RMiLd6KhEFi+rbqowMlwqqA0aRJr6DCCT8
 TlrXCr2KKdGbjofmgd3fq+Baa7UflcKF//nSvtCuBNl+4dNLhsrA/lwe0EFr2QnQ=
X-Received: by 2002:ac2:418b:0:b0:52f:cd03:a84a with SMTP id
 2adb3069b0e04-530b61fe66cmr1079614e87.39.1722502377726; 
 Thu, 01 Aug 2024 01:52:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+DWDFB+/d/kjlinqEN/i6kFpt+27w9S7EzOyAXbtiCJaTdardj0Qe5rVEEOq7V/Tw17rWNA==
X-Received: by 2002:ac2:418b:0:b0:52f:cd03:a84a with SMTP id
 2adb3069b0e04-530b61fe66cmr1079590e87.39.1722502377087; 
 Thu, 01 Aug 2024 01:52:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acadb8278sm861717666b.202.2024.08.01.01.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 01:52:56 -0700 (PDT)
Message-ID: <1b4bfb81-339d-4582-873c-c720c82c8ba7@redhat.com>
Date: Thu, 1 Aug 2024 10:52:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] drm: minimum backlight overrides and
 implementation for amdgpu
To: Jani Nikula <jani.nikula@linux.intel.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>,
 Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dustin Howett <dustin@howett.net>
References: <20240731-amdgpu-min-backlight-quirk-v3-0-46d40bb21a62@weissschuh.net>
 <87v80lwjcz.fsf@intel.com> <Zqqku_zS7CpPGbzW@phenom.ffwll.local>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Zqqku_zS7CpPGbzW@phenom.ffwll.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Aug 2024 07:37:20 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 7/31/24 10:55 PM, Daniel Vetter wrote:
> On Wed, Jul 31, 2024 at 08:40:12PM +0300, Jani Nikula wrote:
>> On Wed, 31 Jul 2024, Thomas Weißschuh <linux@weissschuh.net> wrote:
>>> The value of "min_input_signal" returned from ATIF on a Framework AMD 13
>>> is "12". This leads to a fairly bright minimum display backlight.
>>>
>>> Add a generic override helper for the user to override the settings
>>> provided by the firmware through the kernel cmdline.
>>> Also add amdgpu as a user of that helper.
>>>
>>> One solution would be a fixed firmware version, which was announced but
>>> has no timeline.
>>
>> The flip side is that if we add this now, it pretty much has a timeline:
>> We'll have to carry and support it forever.
>>
>> It's not a great prospect for something so specific. Not to mention that
>> the limits are generally there for electrical minimums that should not
>> be overridden. And before you know it, we'll have bug reports about
>> flickering screens...
> 
> Yeah I think for this specific case where a fixed firmware is already
> kinda promised, a quirk is the right fix. Otherwise we open up a can of
> worms here ... so personally I like v2 a lot more.
> -Sima

Ok, with both Jani and Sima preferring the quirk approach from v2,
I withdraw my objection against v2. So lets go with that version.

Thomas, sorry about this.

I see that other then a remark from Jeff Johnson about a missing
MODULE_DESCRIPTION() v2 does not have any reviews yet though.

So we will need to review that version now. Might be best for
visibility of the patches in people's review queue to repost
v2 as v4 with the MODULE_DESCRIPTION() fixed ?

Regards,

Hans



>>> This helper does conflict with the mode override via the cmdline.
>>> Only one can be specified.
>>> IMO the mode override can be extended to also handle "min-brightness"
>>> when that becomes necessary.
>>>
>>> ---
>>> Changes in v3:
>>> - Switch to cmdline override parameter
>>> - Link to v2: https://lore.kernel.org/r/20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net
>>>
>>> Changes in v2:
>>> - Introduce proper drm backlight quirk infrastructure
>>> - Quirk by EDID and DMI instead of only DMI
>>> - Limit quirk to only single Framework 13 matte panel
>>> - Link to v1: https://lore.kernel.org/r/20240610-amdgpu-min-backlight-quirk-v1-1-8459895a5b2a@weissschuh.net
>>>
>>> ---
>>> Thomas Weißschuh (2):
>>>       drm/connector: add drm_connector_get_cmdline_min_brightness_override()
>>>       drm/amd/display: implement minimum brightness override
>>>
>>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 ++++
>>>  drivers/gpu/drm/drm_connector.c                   | 34 +++++++++++++++++++++++
>>>  include/drm/drm_connector.h                       |  2 ++
>>>  3 files changed, 42 insertions(+)
>>> ---
>>> base-commit: 36821612eb3091a21f7f4a907b497064725080c3
>>> change-id: 20240610-amdgpu-min-backlight-quirk-8402fd8e736a
>>>
>>> Best regards,
>>
>> -- 
>> Jani Nikula, Intel
> 

