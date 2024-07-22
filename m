Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC7BC3DA59
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 12:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1C1D10E505;
	Mon, 22 Jul 2024 12:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="cP6O5bWY";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9DBA10E114
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 11:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721649203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+uxYEy71BTLlKxVksIrikvEA78NJ0VV65h60HjI7v0=;
 b=cP6O5bWY7tewxjLMcV1C4/9fozsNSTymVJf4JMyWrYE7ZoJLLvh78U4H6Dt/k9BK4Ow9XH
 OrgVF0hN5bRty2Q8HIEkCauF0P0h1Czw8esfZaCEagIDiTEzyUBVsRN9EKgyVwTndTfdbN
 Nby7l0LZLjzfUPAveR1+E9smFNWBieI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-5Xy0F1SzPqCczB39xBcxcg-1; Mon, 22 Jul 2024 07:53:21 -0400
X-MC-Unique: 5Xy0F1SzPqCczB39xBcxcg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5a113d5cd1eso1754845a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 04:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721649200; x=1722254000;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O+uxYEy71BTLlKxVksIrikvEA78NJ0VV65h60HjI7v0=;
 b=V2rO/nuoVpwUsSkrrvYu/NTWxYfvIW1F95J3wm2sg6RIT9ZgpaBA79kMH/JdQu5A3N
 f8CC0jX/+11OEy1JTUrjKrZ1GCxZzxRj16L2t/dFOhY+1KDCiGc45AaqzgNoS7iIWi5P
 pkk2uNUEvNHEzNftlj5835LICRjfqyWSFgMBPp6YOIMTcQ6p3B5t3PC58RmAqKd4ngm4
 Kr0uqDAp158EXbkCfb4VLXPz4J3YAge1Pziar1aH6aWEv97CL9O8xGPJ9ONjYAz2pYgg
 f9COjnRd8PwznLO1stjrWlBPGVFmq0NxJa9RhselndoFoxuCEANzPIozllfUXkbOjRWT
 bAXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPU1XOZ+tAhwGfGl2thNRk4IISGPubj8yjUTJ4M0c5L4q4KaOyolonJgopzYJuxM4LBU6tf658pffTmqJgWgJcWlVpDeYFygq+Qon04g==
X-Gm-Message-State: AOJu0YzzVFOvLjyEKg8UX/zNrxCd1dE6f2mqkbTIk7xczBjNc+7FeD7m
 Z2T2vfRBsMzbyuVwVAl2YJiIk7HrFEfb2NxoFubI1BocJpN1h3lX3iBr3XcscIumXdpclhkFC0J
 aKnuCCJLpfDWdZklF82K5JEwcfiqdjbDiFKYeo87mC5or0EiKl/85nehRoKVIuRM=
X-Received: by 2002:a50:8751:0:b0:5a1:a08a:e08 with SMTP id
 4fb4d7f45d1cf-5a478f6b6cdmr5059210a12.11.1721649200527; 
 Mon, 22 Jul 2024 04:53:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWLFS9risa/qC+0rtPi8Ua2sKubIVvp+XpXJo0PB3iyqeJXiq2MRmWL7gMq+Z4dZvNFf+BCw==
X-Received: by 2002:a50:8751:0:b0:5a1:a08a:e08 with SMTP id
 4fb4d7f45d1cf-5a478f6b6cdmr5059183a12.11.1721649200087; 
 Mon, 22 Jul 2024 04:53:20 -0700 (PDT)
Received: from [192.168.2.168] (business-90-187-152-45.pool2.vodafone-ip.de.
 [90.187.152.45]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30c2f87d1sm6059698a12.70.2024.07.22.04.53.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 04:53:19 -0700 (PDT)
Message-ID: <d1d57a98-dcba-43d0-aa90-016c4f85a32f@redhat.com>
Date: Mon, 22 Jul 2024 13:53:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] drm: backlight quirk infrastructure and lower
 minimum for Framework AMD 13
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>
References: <20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net>
 <e61010e4-cb49-44d6-8f0d-044a193d29b2@redhat.com>
 <51f68b3b-dd21-44ef-8ec8-05bea5db6e55@t-8ch.de>
 <6db5abf9-cbdd-4ec0-b669-5df23de6c2ad@redhat.com>
 <a050aad4-d195-42e6-8a84-02170a4f9835@t-8ch.de>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <a050aad4-d195-42e6-8a84-02170a4f9835@t-8ch.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Jul 2024 12:53:59 +0000
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

Hi Thomas,

On 7/20/24 9:31 AM, Thomas Weißschuh wrote:
> Hi Hans,
> 
> On 2024-07-18 10:25:18+0000, Hans de Goede wrote:
>> On 6/24/24 6:15 PM, Thomas Weißschuh wrote:
>>> On 2024-06-24 11:11:40+0000, Hans de Goede wrote:
>>>> On 6/23/24 10:51 AM, Thomas Weißschuh wrote:
>>>>> The value of "min_input_signal" returned from ATIF on a Framework AMD 13
>>>>> is "12". This leads to a fairly bright minimum display backlight.
>>>>>
>>>>> Add a generic quirk infrastructure for backlight configuration to
>>>>> override the settings provided by the firmware.
>>>>> Also add amdgpu as a user of that infrastructure and a quirk for the
>>>>> Framework 13 matte panel.
>>>>> Most likely this will also work for the glossy panel, but I can't test
>>>>> that.
>>>>>
>>>>> One solution would be a fixed firmware version, but given that the
>>>>> problem exists since the release of the hardware, it has been known for
>>>>> a month that the hardware can go lower and there was no acknowledgment
>>>>> from Framework in any way, I'd like to explore this alternative
>>>>> way forward.
>>>>
>>>> There are many panels where the brightness can go lower then the advertised
>>>> minimum brightness by the firmware (e.g. VBT for i915). For most users
>>>> the minimum brightness is fine, especially since going lower often may lead
>>>> to an unreadable screen when indoors (not in the full sun) during daylight
>>>> hours. And some users get confused by the unreadable screen and find it
>>>> hard to recover things from this state.
>>>
>>> There are a fair amount of complaints on the Framework forums about this.
>>> And that specific panel is actually readable even at 0% PWM.
>>
>> If a lot of Framework users are complaining about this, then maybe Framework
>> should fix their VBT in a BIOS update ?  That seems like a better solution
>> then quirking this in the kernel.
> 
> Framework has now stated that they will update the VBT for their 13' device. [0]
> It won't happen for the 16' one as its out of spec there, although it
> has been reported to work.
> 
> <snip>
> 
>>> From my experience with ThinkPads, the default brightness range there
>>> was fine for me. But on the Framework 13 AMD it is not.
>>>
>>>> So rather then quirking this, with the above mentioned disadvantages I believe
>>>> that it would be better to extend the existing video=eDP-1:.... kernel
>>>> commandline parsing to allow overriding the minimum brightness in a driver
>>>> agnostic way.
>>>
>>> I'm not a fan. It seems much too complicated for most users.
>>
>> Wanting lower minimum brightness really is mostly a power-user thing
>> and what is the right value is somewhat subjective and this is an often
>> heard complained. I really believe that the kernel should NOT get in
>> the business of adding quirks for this. OTOH given that this is an often
>> heard complaint having some generic mechanism to override the VBT value
>> would be good to have.
>>
>> As for this being too complicated, I fully agree that ideally things
>> should just work 100% OOTB, which is why I believe that a firmware fix
>> from Framework would be good. But when things do not work 100% adding
>> a kernel cmdline option is something which is regularly asked from users /
>> found in support questions on fora so I don't think this is overly
>> complicated. I agree it is not ideal but IMHO it is workable.
>>
>> E.g. on Fedora it would simply be a question of users having to run:
>>
>> sudo grubby --update-kernel=ALL --args="video=eDP-1:min-brightness=1"
>>
>> will add the passed in argument to all currently installed (and
>> future) kernels.
> 
> Thanks for taking the time for your explanations.
> I came around to agree with your proposal for a cmdline override.
> 
> What to you think about:
> 
> void drm_connector_get_cmdline_backlight_overrides(struct drm_connector *connector,
> 						   struct drm_backlight_override *overrides);
> 
> struct drm_backlight_override would look like
> struct drm_panel_backlight_quirk from this patch.

I'm not entirely convinced that we need the struct drm_backlight_override
abstraction right away. Maybe we can start with just a
drm_connector_get_cmdline_min_brightness_override() which just returns an int?

If you prefer to keep the struct drm_backlight_override that is fine too,
we can see what others think when you submit a new version for review.


>>> Some more background to the Framework 13 AMD case:
>>> The same panel on the Intel variant already goes darker.
>>> The last responses we got from Framework didn't indicate that the high
>>> minimum brightness was intentional [0], [1].
>>> Coincidentally the "12" returned from ATIF matches
>>> AMDGPU_DM_DEFAULT_MIN_BACKLIGHT, so maybe the firmware is just not set
>>> up completely.
>>
>> Right, so I think this should be investigated closer and then get
>> framework to issue a BIOS fix, not add a quirk mechanism to the kernel.
>>
>> IIRC the amdgpu driver will use AMDGPU_DM_DEFAULT_MIN_BACKLIGHT when
>> that setting is 0 in the VBT.
> 
> This is not my reading of the code.
> To me it seems "0" will be accepted, which is also why the second "fix"
> from [1] works.

I have not looked at that code i quite a while, so you're probably right.

Regards,

Hans

