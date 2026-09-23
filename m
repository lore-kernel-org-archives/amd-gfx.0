Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CE0C98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 16:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 386ED10E5DA;
	Wed, 23 Sep 2026 16:07:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AXla20CJ";
	dkim-atps=neutral
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com
 [74.125.228.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7093B10E5DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 16:07:32 +0000 (UTC)
Received: by mail-ej2-f43.google.com with SMTP id
 a640c23a62f3a-c2a8b9acbc6so183353566b.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 09:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790179651; x=1790784451; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=p5jcS04GHIJRKuzdHI5fQPxE/Gjcri6O1kLmUfhhrCc=;
 b=AXla20CJTLpZJgCRxDPMVRAJcu/dxWMVHWJGgZfvToEchSZyFCE8L/bKzYXiFrXXkQ
 mQbZJLXNHKmzAioYxdQfbKuwamdNnVyDqhrvOni+KBS4s3cYCE656IRUvdBECAHi7akO
 SjBN+MkLq2DpWEisl0qH0USw6qtLHFyGKMP9SOJrzo1gEMLDcD8I7VAc9Y1hLEFcnSUA
 NfP34Q0TwyqIVPLnlXBBy5Wbrm/ZFl4e/joAdXJn7MoStbZaENvAy0+DeTixReuZIeJ/
 vLspkgkpHhezdzNr5s0nSmR/JNSot2E9RNSal0EafWAYMS241lZRYTUxUR8sHNkARoAP
 P0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790179651; x=1790784451;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p5jcS04GHIJRKuzdHI5fQPxE/Gjcri6O1kLmUfhhrCc=;
 b=fJJLpR4oOh5L8oveJ5bdtVswR5+4u42CXXBDcMhNJnzkJ5sZIeVMlh6CHie8ZfiM+f
 mHdjaoujmull16eErTS1m27La23f838RyatTtfTNT43jcQE7O4t8ZQiV8Hi0dwBCs8Us
 RyaU7mrFesZrAiFpo//omajcrTAG4WNapwTBkQPRrUaUmCWhsMX09gnq6HP3UVfvyHAo
 3Ipv7sPwJ4nJsyaszCSR690TJ13LoH8hSv7qfqNsAljrN04QXj1Q6QOiPhsrZYdkTbjL
 ZqzRbLCPc1ggGY8dtTkrdjovzmppM/9g0adW7AyWHtgZ7uQnDHV/Z9aoSTTQlBd71nQ3
 Kamg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcBoaEcVUHg8lrGpQQKdRFDlchi6H+w8HZw8pqHXN2ALsJ2a1AdhZauQtYuAOOT03eO+UcuK4j@lists.freedesktop.org
X-Gm-Message-State: AFuF++lgFRne5gEOnp3EFNPnjYtNYF4AQ3dECIopFsdrFozLLjGteiQp
 BiWfAjzcEkzd/pCmhJocVZE8idChteyya0umxCcYi+lU8IsPj+u6ictJ
X-Gm-Gg: AYBFou1tdSRd51DuA/mXFsUlHhrBFOLc4bew6lA4quYG0dncAjOxrKF7pZk0wAra1fS
 1nhUQ13sApfit5ekpsyZKn5orlJcWr5ixitSFw7VoU9WQmRUd9MFHQWK3Hc333/+z3fgfPrniBr
 4vYAT78n9/bguwglShsogURjBJwaig9M2IE7l669x01AhOCO3netWxyRgc/PcnmjsiQZ7hQsGG8
 QqBS5hRncfFAF2mYv9quRRUrSaiSBAMu99VzmRbYlCcvu+MTayPXJf+qVHbHEQJxzIyt5ogAiZ2
 oSOw7gcax5aO1RpC215zO/hC7EEbWE8QkUV3HtYqWx3gi3gWJ3DyDwkAn/+GH/5Bpj6Yatemte9
 5ZMP6cryrJYNS6wQrpnbw+BDBJ6KqXaYFA5oDhzNvlnkY9hspK5eAeqxUBZSbY25rJmz9ECAfo6
 gELGKhLdwlbHqsTo4veFwRwdA3alg2UapPsvzbm+dNQuqWieV3WGOQO/y80Z5WPVSTUUTed5yNK
 qV+7KM=
X-Received: by 2002:a17:907:3f82:b0:c2a:ad55:b3fa with SMTP id
 a640c23a62f3a-c2aadeb4b50mr259256666b.7.1790179650477; 
 Wed, 23 Sep 2026 09:07:30 -0700 (PDT)
Received: from [10.194.248.89] ([137.122.66.156])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae60e4c8sm152921166b.26.2026.09.23.09.07.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 09:07:29 -0700 (PDT)
Message-ID: <696580d8-cf2e-47aa-8616-7d930c2f5b82@gmail.com>
Date: Wed, 23 Sep 2026 12:07:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DRM] amdgpu: HDMI FreeSync not exposed on Samsung S22C31x
 despite AMD VSDB
To: =?UTF-8?B?QXRhIMSwbGhhbiBLw7ZrdMO8cms=?= <atailhan2006@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260923002718.5915-1-atailhan2006@gmail.com>
Content-Language: en-US
From: teapot <huangalex409@gmail.com>
In-Reply-To: <20260923002718.5915-1-atailhan2006@gmail.com>
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



On 2026-09-22 20:27, Ata İlhan Köktürk wrote:
> Hi,
> 
> I am investigating an issue where HDMI FreeSync
> is not exposed for a Samsung S22C31x monitor on
> an AMD Picasso/Raven 2 GPU, although the monitor
> advertises an AMD FreeSync range in its EDID and
> VRR works under Windows.
> 
> Hardware/software:
> 
> * GPU: 03:00.0 VGA compatible controller [0300]:
> Advanced Micro Devices, Inc. [AMD/ATI] Picasso/Raven 2
> [Radeon Vega Series / Radeon Vega Mobile Series]
> [1002:15d8] (rev c2)
> * Kernel: 7.2.5-200.fc44
> * Compositor: Sway (Wayland)
> * Monitor: Samsung S22C31x
> * Connector: HDMI-A-1
> * EDID serial: H9DX100210
> * Kernel command line includes: amdgpu.freesync_video=1
> 
> Observed:
> 
> * swaymsg -t get_outputs reports "Adaptive sync: disabled" for HDMI-A-1.
> * Adaptive sync remains disabled at both 1920x1080@60 Hz and 1920x1080@75 Hz.
> * The same monitor exposes and enables FreeSync under Windows.
> 
> The EDID contains the following AMD Vendor-Specific Data Block:
> 
> Vendor-Specific Data Block (AMD), OUI 00-00-1A:
>      Version: 1
>      Feature Caps: 0x01
>      Minimum Refresh Rate: 48 Hz
>      Maximum Refresh Rate: 75 Hz
>      Flags 1.x: 0x00>
> The HDMI VSDB therefore appears to advertise a 48-75 Hz FreeSync range.
> 
> There is also this message in dmesg:
> 
> amdgpu 0000:03:00.0: [drm] Failed to setup vendor infoframe on connector HDMI-A-1: -22
> 
> I believe this is the -EINVAL path from
> drm_hdmi_vendor_infoframe_from_display_mode() for this timing and
> is probably unrelated to the FreeSync issue.
> 
> The part I am currently investigating is amdgpu_dm_update_freesync_caps().
> 
> For HDMI, the driver calls parse_hdmi_amd_vsdb(), which
> on this DCN configuration goes through the DMUB path:
> 
> parse_hdmi_amd_vsdb()
>    -> parse_edid_cea()
>       -> parse_edid_cea_dmub()
>          -> dm_edid_parser_send_cea()
>             -> output->amd_vsdb.freesync_supported
> 
> If the DMUB parser returns freesync_supported == 0,
> the driver does not expose the connector as VRR capable.
> 
> What makes this interesting is that the DRM EDID parser also
> contains the corresponding AMD VSDB information in
> connector->display_info.amd_vsdb, while the DMUB result
> does not result in FreeSync being exposed.
> 
> I am wondering about the following:
> 
> 1. Is the AMD VSDB layout above expected to be accepted by
> the DMUB EDID parser, particularly with
> Feature Caps 0x01, Flags 1.x == 0x00, and no MCCS VCP code byte?
AFAIK the driver will consider HDMI FreeSync unavailable if MCCS VCP 
code is 0x0. HDMI FreeSync needs this VCP code.>
> 2. If the DMUB parser rejects this form of AMD VSDB, should amdgpu_dm
> fall back to the software-parsed connector->display_info.amd_vsdb
> when determining FreeSync capability?
The amd_vsdb struct is currently only for the V2+ luminosity fields, and 
don't affect FreeSync detection. I had added FreeSync fields support and 
those changes are in drm-next, but haven't made it up to the Torvalds 
tree yet.
> 
> I have a working kernel tree and can run diagnostic tests
> or test a small patch. I can also provide drm.debug
> output or DMUB-related traces if useful.
I think this might be a case where the Windows FreeSync detection has 
diverged from the Linux detection, maybe Harry would be able to provide 
more insight on this?

The monitor's EDID would probably be useful too, I'm not quite sure how 
to make sense of the edid-decode output since there's a few guessed 
fields in the AMD VSDB block and hasn't been updated since 2024.>
> Thanks,
> Ata İlhan Köktürk

Best,
Alex

