Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989B2CCD1A7
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 16:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2567D10E613;
	Tue, 21 Oct 2025 16:15:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lnTMlelZ";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3FE010E613
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 16:15:29 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b40f11a1027so1136435666b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 09:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761063328; x=1761668128; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lGRJXUz3hudSYHQw9T4bLrJ7xB8qKWEGBHIyBuZuStg=;
 b=lnTMlelZUpu4r2In1n73T546hNQD59pxh39XgMQc0BGkVsm40m3VW/6DdtoSkkzPvg
 rH67rLRr9+ZYYKoDgCICTh7A2nFdBu4o4fp0RNUkCqlqMhuWiXWM/Z+AHUrJ+12RjF21
 l6GBcNgCzskcaroZoGu7qmvYS8+t0bHYtxXDTNaUjeRu3mL01/Q/dQUqL5Jh79Q5sPas
 xfks6VOGoffML7mpMzv/Ln1th1oNskS3863IWxnMqd5GMGwJHah651j9WDStlXW6rJWk
 4qEDp7rby3VhDXzM/c0nFHcbTq6ex4SJ+wNCcdaD1dZoIzqzMquHLUGHubiwIyab63dn
 C8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761063328; x=1761668128;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lGRJXUz3hudSYHQw9T4bLrJ7xB8qKWEGBHIyBuZuStg=;
 b=WRXzNSwtshzoLL4t7h36UUGNXoPHmqr+DBjShh8q4hk3Fhag7tgsKlGkzF4MXfp2uz
 HMKexAyiF/D3sdEAaV+/bG1ow3+NodjaTbdcbD8UznKoGiCD2gK284VDxBzG/lOtO99q
 NFByZwl75y+lPRv01qdWVZjXszQFhgFhWDTBki7N+ta+B/B4sAqATyEiCE12Fi+pKH8f
 nAab1joW2A+8qijXlqXcSaGrtczFgmYXzhQaoYud1rJIIdYf+SdKVrTybhoslNJw2vCV
 +K54KvsrWrEdKuK5d4TA3C45r8eTZYIqNq3KpkCeSaffIGl257btQR6ykotw5HqgZp+l
 ging==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWqWpQ2LdscEgIt9Y0MXojJCAwr7onAON7IUpX7A949pNEEFHtyQvZvpDsNc88JqVYTLSDuo9t@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRDlgCJDRY2XMHq5eKPqvqw7sxNJV5lXe8TqgAGWNa4NeStRZY
 rLjjy/yEJGmpdVFiH29azPCtyjwjBpQcbYP3JORGwdv0S8ka+TxriEXW
X-Gm-Gg: ASbGncvOzN60hj3G9W/iD2XG2ozcybncZhUuthKlYBBcW+UwHLkB1lLTrUsLCyZE9p3
 dojYaxQTE5i+KFFL0RzRxKDJziot2eMKU1v/8hyahhe7YHCTVmEqYMPQXz8ai7IPnveC6Qv0Cs4
 RNAv9vHfOa6hGtXuwO+knLSotfu7nqdyTS00deS4DSwJK7xyGXaFjvRLa6hDH4mouTQ+C27SEhP
 Jr3Ngg1m0GKjsM7EkUmOpfJ8dkmm9BMjfDThZO+lX1kYcFoLLTteyNWRCtEQp7/aW+Nzrx8ZScD
 T/Mjc8elHw7+ZdHS3v8l3ijMZzIkWBropjJQfOzTa6FSEy+NOhcbCr4ovgCSMCSHZaxIohE5xjL
 A3QDYMzTrFMHjFeLRaVnn7bq/7b0S48qbuaPR/R4x3rHUJMa1412HejGZw7ugMHMibsFE2rXKq4
 JfMXLw30qYeerELdWFk61se17asZMJE1sT0+vjUGXrJdiB0gSlg+XHSOZu1fNrBlCH8Bl+ZVSXb
 sIyPEj2RbFgfKQsUcrON50k4otKR0HvZ0sEnt2xetETV1BClHxy1DuEgtVc+RJ0hA==
X-Google-Smtp-Source: AGHT+IGB9P/mwrddQUGn37+vWRJ9E4AkjDQwa4I3/eQbjPwWdkU9W/mrBIDuC98yDQRtRtwkjBaI0Q==
X-Received: by 2002:a17:907:86ab:b0:b45:8370:ef08 with SMTP id
 a640c23a62f3a-b6473243f2dmr2149770166b.17.1761063327734; 
 Tue, 21 Oct 2025 09:15:27 -0700 (PDT)
Received: from ?IPV6:2001:4c4e:24da:f700:36af:90f4:d5fb:1eff?
 (20014C4E24DAF70036AF90F4D5FB1EFF.dsl.pool.telekom.hu.
 [2001:4c4e:24da:f700:36af:90f4:d5fb:1eff])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65eb036884sm1095779066b.40.2025.10.21.09.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 09:15:27 -0700 (PDT)
Message-ID: <1835c00c-780a-4530-9652-5ee4a3bb8622@gmail.com>
Date: Tue, 21 Oct 2025 18:15:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/23] Analog connector support in DC (v2)
To: Harry Wentland <harry.wentland@amd.com>,
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Hung, Alex" <Alex.Hung@amd.com>, "siqueira@igalia.com"
 <siqueira@igalia.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20250926180203.16690-1-timur.kristof@gmail.com>
 <0fb9b183-ba74-4837-86a1-499b3acf04d5@amd.com>
 <f7bb25e7-0a64-4057-b068-5fb63d5d287e@amd.com>
 <DS0PR12MB6534854A0932A7E3E0D05D939CEEA@DS0PR12MB6534.namprd12.prod.outlook.com>
 <f2672baf-1f02-480d-a8c3-54f7f7863695@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
In-Reply-To: <f2672baf-1f02-480d-a8c3-54f7f7863695@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Did you guys manage to include the series in last week's promotion?
Are there any issues?

I'd really like it to be included in Linux 6.18, are we still on time 
for that?

Thanks & best regards,
Timur

On 10/9/25 20:27, Harry Wentland wrote:
> 
> 
> On 2025-10-09 13:49, Wheeler, Daniel wrote:
>> [Public]
>>
>> Sure, we can add it to next week's promotion, I'm almost through this week's candidate. Tom is scheduled to prepare next week's candidate, so I'll tag him in.
>>
> 
> Great. Thanks.
> 
> Harry
> 
>> Thank you,
>>
>> Dan Wheeler
>> Sr. Technologist | AMD
>> SW Display
>> ------------------------------------------------------------------------------------------------------------------
>> 1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
>> amd.com
>>
>>
>> -----Original Message-----
>> From: Wentland, Harry <Harry.Wentland@amd.com>
>> Sent: Thursday, October 9, 2025 1:27 PM
>> To: Timur Kristóf <timur.kristof@gmail.com>; amd-gfx@lists.freedesktop.org; Wheeler, Daniel <Daniel.Wheeler@amd.com>
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Hung, Alex <Alex.Hung@amd.com>; siqueira@igalia.com; Koenig, Christian <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH 00/23] Analog connector support in DC (v2)
>>
>>
>>
>> On 2025-10-08 17:11, Harry Wentland wrote:
>>> On 2025-09-26 14:01, Timur Kristóf wrote:
>>>> This series adds support for analog connectors to DC for DCE6-10.
>>>> There are two reasons to add this support:
>>>>
>>>> 1. GPUs that already use DC by default and have analog connectors.
>>>> Some Tonga and Hawaii graphics cards in fact have DVI-I connectors,
>>>> and their analog part doesn't work with DC. This functionality
>>>> regressed when switching from the amdgpu legacy display code to DC.
>>>>
>>>> 2. GPUs that don't use amdgpu by default yet.
>>>> Currently, SI (GFX6) and CIK (GFX7) don't use amdgpu by default yet,
>>>> and missing analog connector support in DC is cited as one of the
>>>> main reasons why not.
>>>>
>>>> Before starting this work, I asked Harry and Alex about how best to
>>>> do it and we agreed that we'd like to use the VBIOS to set up the
>>>> DAC. So I used the amdgpu legacy display code as a reference.
>>>> The first few commits add some minor changes to DC to prepare for
>>>> supporting analog stream and link encoders, then analog link
>>>> detection is added along with polling, and finally DAC load detection
>>>> support, which is useful for old displays and adapters.
>>>>
>>>> With this analog support added to DC, we could already fully switch
>>>> CIK discrete GPUs to use DC and switch them to the amdgpu driver by
>>>> default. This series switches Bonaire to DC by default, we can do the
>>>> switch to amdgpu in a later series.
>>>>
>>>> For SI dGPUs, there are other pending patches to make DC work well,
>>>> afterwards we could switch to DC by default, but missing
>>>> VCE1 support is the blocker from using amdgpu by default.
>>>>
>>>> For GFX7 APUs, further work is needed before enabling DC by default,
>>>> specifically with regards to the TRAVIS and NUTMEG external encoders
>>>> which are not supported by DC at all.
>>>>
>>>> Changes in v2 of the series:
>>>> Fixed regression on RDNA2 and newer APUs.
>>>> Fixed flickering caused by polling analog connectors.
>>>> Fixed crash on Kaveri.
>>>> Fixed bug when HPD was high without a connected display.
>>>> Reduced code churn by reusing same link encoder.
>>>> Addressed other feedback from the review of v1.
>>>
>>> Thanks for the series.
>>>
>>> Patches 1-13 are
>>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>>>
>>> I'll hope to find time for the rest tomorrow or Friday.
>>>
>>
>> The rest looks good to me as well.
>>
>> The whole series is
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>>
>> Dan, can we give this a spin in our weekly promotion tests before I merge it?
>>
>> Harry
>>
>>> Harry
>>>
>>>>
>>>> Timur Kristóf (23):
>>>>    drm/amd/display: Determine DVI-I connector type (v2)
>>>>    drm/amd/display: Add analog bit to edid_caps (v2)
>>>>    drm/amd/display: Introduce MAX_LINK_ENCODERS (v2)
>>>>    drm/amd/display: Hook up DAC to bios_parser_encoder_control
>>>>    drm/amd/display: Add SelectCRTC_Source to BIOS parser
>>>>    drm/amd/display: Get maximum pixel clock from VBIOS
>>>>    drm/amd/display: Don't use stereo sync and audio on RGB signals (v2)
>>>>    drm/amd/display: Don't try to enable/disable HPD when unavailable
>>>>    drm/amd/display: Determine early if a link has supported encoders (v2)
>>>>    drm/amd/display: Add concept of analog encoders (v2)
>>>>    drm/amd/display: Implement DCE analog stream encoders
>>>>    drm/amd/display: Implement DCE analog link encoders (v2)
>>>>    drm/amd/display: Support DAC in dce110_hwseq
>>>>    drm/amd/display: Add analog link detection (v2)
>>>>    drm/amd/display: Refactor amdgpu_dm_connector_detect (v2)
>>>>    drm/amd/display: Poll analog connectors (v2)
>>>>    drm/amd/display: Add DCE BIOS_SCRATCH_0 register
>>>>    drm/amd/display: Make get_support_mask_for_device_id reusable
>>>>    drm/amd/display: Add DAC_LoadDetection to BIOS parser (v2)
>>>>    drm/amd/display: Use DAC load detection on analog connectors (v2)
>>>>    drm/amd/display: Add common modes to analog displays without EDID
>>>>    drm/amd/display: Don't add freesync modes to analog displays (v2)
>>>>    drm/amdgpu: Use DC by default for Bonaire
>>>>
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   1 -
>>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 173 ++++++++---
>>>>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   5 +-
>>>>   .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   1 +
>>>>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  20 ++
>>>> .../gpu/drm/amd/display/dc/bios/bios_parser.c |  95 +++++-
>>>>   .../drm/amd/display/dc/bios/command_table.c   | 286 ++++++++++++++++++
>>>>   .../drm/amd/display/dc/bios/command_table.h   |   6 +
>>>>   .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   4 +-
>>>>   .../gpu/drm/amd/display/dc/core/dc_resource.c |   8 +
>>>>   .../gpu/drm/amd/display/dc/dc_bios_types.h    |   9 +
>>>>   drivers/gpu/drm/amd/display/dc/dc_types.h     |   8 +-
>>>>   .../drm/amd/display/dc/dce/dce_link_encoder.c |  85 ++++++
>>>> .../drm/amd/display/dc/dce/dce_link_encoder.h |  16 +-
>>>>   .../amd/display/dc/dce/dce_stream_encoder.c   |  14 +
>>>>   .../amd/display/dc/dce/dce_stream_encoder.h   |   5 +
>>>>   .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  75 ++++-
>>>>   .../gpu/drm/amd/display/dc/inc/core_types.h   |   8 +-
>>>>   .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  24 ++
>>>>   .../drm/amd/display/dc/inc/hw/link_encoder.h  |   2 +
>>>>   drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
>>>>   .../amd/display/dc/link/hwss/link_hwss_dio.c  |  19 +-
>>>> .../drm/amd/display/dc/link/link_detection.c  | 147 ++++++++-
>>>>   .../gpu/drm/amd/display/dc/link/link_dpms.c   |   9 +-
>>>>   .../drm/amd/display/dc/link/link_factory.c    |  60 +++-
>>>>   .../dc/resource/dce100/dce100_resource.c      |  31 +-
>>>>   .../dc/resource/dce110/dce110_resource.c      |   2 +
>>>>   .../dc/resource/dce112/dce112_resource.c      |   2 +
>>>>   .../dc/resource/dce120/dce120_resource.c      |   1 +
>>>>   .../dc/resource/dce60/dce60_resource.c        |  29 +-
>>>>   .../dc/resource/dce80/dce80_resource.c        |  26 +-
>>>>   .../amd/display/include/bios_parser_types.h   |  11 +-
>>>>   .../display/include/grph_object_ctrl_defs.h   |   1 +
>>>>   .../drm/amd/display/include/grph_object_id.h  |   7 +
>>>>   .../drm/amd/display/include/signal_types.h    |  12 +
>>>>   35 files changed, 1117 insertions(+), 86 deletions(-)
>>>>
>>>
>>
> 

