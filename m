Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17903E7717D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2024 22:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B86CA10E2C5;
	Mon,  9 Dec 2024 22:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="AoOPdDvy";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24AA310E2C5
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2024 22:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733784932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lg30x2scEWzC/7ZFChp9UVu6AA+m1WvSSLKVNfDsPbw=;
 b=AoOPdDvySm7zpqS6Ab+cktddwceLfhpg614tvYfgAZ0VttmXUDOYwJEsFufNxy+P46fqpL
 7Jil6i/KrsXR85RZMYZJ9wbJkjNqoUycF8b7votK9QK+6Y6L1VrW0hC6T1l8fp3OiTyUC9
 FsgxpaNt/fsEpfOZWtVSWruzlz22ITM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-beYlfscBPFSVqYvPrkprbA-1; Mon, 09 Dec 2024 17:55:30 -0500
X-MC-Unique: beYlfscBPFSVqYvPrkprbA-1
X-Mimecast-MFC-AGG-ID: beYlfscBPFSVqYvPrkprbA
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385ded5e92aso1900104f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Dec 2024 14:55:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733784930; x=1734389730;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lg30x2scEWzC/7ZFChp9UVu6AA+m1WvSSLKVNfDsPbw=;
 b=FTM4bfY3Wf3CxM7Hk018KLcyfdQpZJkFhTBI/MT/krb6Gw4X/svDqF3HtTI1pbSfa4
 /IPc6N8/iTl4RoDMUOSQxDvHlY+hEmkFt8vrCLePSYeevP0bLHfq4AAVjsW0NfghjOfL
 iaLL+Crf8lIKhWqrIqbsGrO1aU78vP3Fj+CS/KLQ2Vaq/siIpq6NYGHgf9HBirgvrBDA
 2l9LvPTp6bnVZZUVVwX0Jf4EF2O+43muA0pkikAmN0MHKXfxX4e7zSz8zYKaYidqvjOx
 +E0uhL1OGk6e7+AtbGvnGM0zOLEckL7tWWbHY8u6slrOjUGYzl/a1eHDz21rQGsXLhY7
 TXAw==
X-Gm-Message-State: AOJu0YzAVJlYArGAAOVsDzp2276lMr7axEb7HRRLTtO15ZHPtYFgtTTQ
 d3LIoPOEhUacXNSoT6c5AOsf+teNg09QzZ1KjK4sNzR2KoDuie4Q6hIi+NYF79v3NTXB3TtHyRZ
 PVloGiwQGzRgvalmhcYrO0g9OV0TwhstJiGNXTvnztZoB2slWg2SNuopCSviBuPQ=
X-Gm-Gg: ASbGnctQ+iab/WC2n5Mh0xd3+W3w/t0YkrEYveYs95lJ0blZ98BUmicr/KbJcYbYqFH
 Yc4gEU8U1Z0q4GrL+zFBE7EjwRAm66EeTv8/6OcL/YBuan4vAxWNs/XgQMYv2Jw++AilJsoQqBm
 NUlKnPjZsLxdE6UyOJdrlb6RJOa3P3zuod33uiIPpj5J/6gk0OB7Zv9Na1d23Vmagl2v4OcrQKO
 f9cqHmGYaMh42BgF+1wHS4oz7SWpalNFcTFCZe5jhSutMHi5EB9qG+cGMT7XFg2iBSoEAh7jb8z
 QlOJKlvK6xA1dzQ6WQ==
X-Received: by 2002:a05:6000:1f8c:b0:385:f16d:48aa with SMTP id
 ffacd0b85a97d-386453d4da3mr1800517f8f.15.1733784929678; 
 Mon, 09 Dec 2024 14:55:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFknf0nIotQl+8rNgGGCCG1kTPUUtUurYsQoW8mDcXeB1rZf0mi78x3PLIFks9sdYcMBLhQRw==
X-Received: by 2002:a05:6000:1f8c:b0:385:f16d:48aa with SMTP id
 ffacd0b85a97d-386453d4da3mr1800512f8f.15.1733784929313; 
 Mon, 09 Dec 2024 14:55:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722?
 ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38621fbbdd8sm14297425f8f.95.2024.12.09.14.55.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 14:55:28 -0800 (PST)
Message-ID: <4c8f35f4-b3a1-4dfe-b1fb-1cc0e271a55a@redhat.com>
Date: Mon, 9 Dec 2024 23:55:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/6] Add panic support for all DCE/DCN
To: Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, yaolu@kylinos.cn
References: <20241112213716.49355-1-alexander.deucher@amd.com>
 <CADnq5_OLnCs6snWFiTwuHwHJL44WC8NjVxz7WSA1wu8CRiOLjA@mail.gmail.com>
 <39fc4143-9649-4c47-8359-95c831e8439b@amd.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <39fc4143-9649-4c47-8359-95c831e8439b@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fGGA-gIApkZ7ElUMUS-vs96Lu8u3OKQZlTk_Fbk7k28_1733784930
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
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

On 09/12/2024 22:51, Harry Wentland wrote:
> Looks good now.
> 
> Series is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> Haven't followed the whole panic support closely. Is there a
> way to trigger a panic for testing, or is there any other
> recommended way to test this?

The easiest way is to trigger a kernel panic with:
echo c > /proc/sysrq-trigger

You can also enable CONFIG_DRM_PANIC_DEBUG and echo 1 > 
/sys/kernel/debug/dri/0/drm_panic_plane_0

But as it overwrite ones of the two framebuffer, it causes flickers, and 
a few graphic artefacts, but make it somewhat easier to test, as it 
doesn't crash the machine.

Best regards,

-- 

Jocelyn




> 
> Harry
> 
> On 2024-12-09 12:00, Alex Deucher wrote:
>> + Harry
>>
>> Ping on this series.
>>
>> On Tue, Nov 12, 2024 at 4:37 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>>
>>> This builds on the patches from Lu and Jocelyn to fill in
>>> panic support for all DCE/DCN variants and code pathes.
>>>
>>> v2: refactor to provide cleaner history and share more
>>> code to provide a more consistent experience across
>>> DC and non-DC.
>>>
>>> v3: resend with the missing first patch
>>>
>>> v4: move hubp and mi code into a dc helper function
>>>
>>> Alex Deucher (5):
>>>    drm/amdgpu: add generic display panic helper code
>>>    drm/amd/display: add clear_tiling hubp callbacks
>>>    drm/amd/display: add clear_tiling mi callbacks
>>>    drm/amd/display/dc: add helper for panic updates
>>>    drm/amd/display: add non-DC drm_panic support
>>>
>>> Jocelyn Falempe (1):
>>>    drm/amd/display: add DC drm_panic support
>>>
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 80 +++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.h   |  5 ++
>>>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        | 27 +++++++
>>>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        | 27 +++++++
>>>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 27 +++++++
>>>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         | 26 ++++++
>>>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 30 ++++++-
>>>   .../gpu/drm/amd/display/dc/core/dc_surface.c  | 46 +++++++++++
>>>   drivers/gpu/drm/amd/display/dc/dc_plane.h     |  3 +
>>>   .../drm/amd/display/dc/dce/dce_mem_input.c    | 34 ++++++--
>>>   .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    | 15 ++++
>>>   .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |  2 +
>>>   .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    | 15 ++++
>>>   .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |  2 +
>>>   .../amd/display/dc/hubp/dcn201/dcn201_hubp.c  |  1 +
>>>   .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |  1 +
>>>   .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    | 17 ++++
>>>   .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |  2 +
>>>   .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |  1 +
>>>   .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |  3 +-
>>>   .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |  1 +
>>>   .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 15 +++-
>>>   .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  2 +
>>>   drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  1 +
>>>   .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |  2 +
>>>   25 files changed, 377 insertions(+), 8 deletions(-)
>>>
>>> --
>>> 2.47.0
>>>
> 

