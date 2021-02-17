Return-Path: <SRS0=lywG=HT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0949BC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 14:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE8E464E28
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 14:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8E464E28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65D9589E3B;
	Wed, 17 Feb 2021 14:58:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83886E138
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 14:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613573788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=o7zvrbSskz7r1syg8KTn+q44XDne6J+xEUV/rheI0VA=;
 b=VElIdi92T1jcjAwkL8uWTo1XNXFXfNc3zLUCtJtG9t+8LfYh3XIHsjPe02b+NDWMII2OiQ
 AZTKnxWjX2imF+SJpKVp7Eb8fTprK22G4nMOCfeNgjSRz+FvIlXBweLZVXhvkdy8fqNJm2
 eQSml3fm4bfyHuUbzH3uK5FzqAoWSmE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-gkMYXaWQNJiMk-5CRiC5ww-1; Wed, 17 Feb 2021 09:56:24 -0500
X-MC-Unique: gkMYXaWQNJiMk-5CRiC5ww-1
Received: by mail-ej1-f71.google.com with SMTP id p15so8384648ejq.22
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 06:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=o7zvrbSskz7r1syg8KTn+q44XDne6J+xEUV/rheI0VA=;
 b=atzVXUeCPT+e0c+fbkKwUUL5caLFBeqQqqex7bYeCbdDi4iBpAWoLRFaqYRZeseF+A
 5LBIVL0ZKPeANnwR1AKkMgeyGfNv3p3dHertPu/h9voTCku5I0xJeq0kkC0xrnIr37sX
 9ei+ai9TAfXQNaM1Hw9lOo55sCCC7MB/+LTJu6VBsOsHLhWnVDU/0shfloQgow/B+BoU
 biNxzYqA4w8wr82YH5KronH8g32PyVlu3ZOWVNARdwdSV0vpJg7upGxoNp9ZMabuZI0Q
 4sFR+Tsb0/bv0YdUVUMrFZ8yHIZzmg2LLYZycV5oeqiO/KMVbEROYL/w9jhs4mGb+ZIE
 g0ug==
X-Gm-Message-State: AOAM532jAHaU86sIXnMbD009ApjXdpqxBNTIuZub0DbMoLORdkG7260C
 uCjFbH4UZPgfgxht+BjI73521+qwN9AUbf8078geqKkNqIXjDMDD0rmybsAiKrRhCL0p9+jYKda
 lSHjj0imTtqNwpZx0fjTuMLnGlDFMms5hKyMe/cl0ynsxp2EOvJ1WqvN2PYzrUU7z0HH1gad6le
 5uqw==
X-Received: by 2002:a17:907:7295:: with SMTP id
 dt21mr26559516ejc.518.1613573782190; 
 Wed, 17 Feb 2021 06:56:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+m3bn7QlL2D+/D+D4joRx68fCYaCsTKlySyjJWUcyPbWL0VTUsXRx8JspTnrvhhJs8e042w==
X-Received: by 2002:a17:907:7295:: with SMTP id
 dt21mr26559499ejc.518.1613573781950; 
 Wed, 17 Feb 2021 06:56:21 -0800 (PST)
Received: from x1.localdomain
 (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
 by smtp.gmail.com with ESMTPSA id i6sm1095334ejd.110.2021.02.17.06.56.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Feb 2021 06:56:21 -0800 (PST)
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <mdaenzer@redhat.com>,
 Alex Deucher <alexdeucher@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Subject: lots of bugreports about a kernel-backtrace starting with
 amdgpu_dm_backlight_update_status
Message-ID: <248f32a0-f26b-0fcc-5321-148002373ef4@redhat.com>
Date: Wed, 17 Feb 2021 15:56:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Mailman-Approved-At: Wed, 17 Feb 2021 14:57:59 +0000
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi All,

Fedora has a (opt-in) system to automatically collect backtraces from software
crashing on users systems.

This includes collecting kernel backtraces (including once triggered by
WARN macros) while looking a the top 10 of the most reported backtrace during the
last 2 weeks report from ABRT: https://retrace.fedoraproject.org/faf/problems/

I noticed the following backtrace:
https://retrace.fedoraproject.org/faf/problems/13904/

which has been reported 160000 times by Fedora users who have opted-in during the
last 14 days.

The ABRT symbol resolution points to amdgpu_dm_backlight_update_status:

1 	
amdgpu_dm_backlight_update_status
	amdgpu 		0xb4
2 	
amdgpu_dm_backlight_update_status
	amdgpu 		0xb4
3 	
amdgpu_dm_backlight_update_status
	amdgpu 		0xb4
4 	
amdgpu_dm_backlight_update_status
	amdgpu 		0xb4
5 	
? amdgpu_dm_backlight_update_status
	amdgpu 		0xb4
6 	
amdgpu_dm_backlight_update_status
	amdgpu 		0xb4
7 	
amdgpu_dm_backlight_update_status
	amdgpu 		0xb4
8 	
drm_sched_job_timedout
	gpu_sched 	drivers/gpu/drm/scheduler/sched_main.c 	289


But the backtrace from dmesg points to something else:

RIP: 0010:dcn10_get_dig_frontend+0x76/0xb0 [amdgpu]
Code: 39 44 89 c0 48 83 c4 08 c3 41 b8 05 00 00 00 83 f8 20 74 ed 41 b8 06 00 00 00 83 f8 40 74 e2 41 b8 04 00 00 00 83 f8 10 74 d7 <0f> 0b 41 b8 ff ff ff ff 48 83 c4 08 44 89 c0 c3 45 31 c0 83 f8 01
RSP: 0018:ffffa376c2dffca8 EFLAGS: 00210297
RAX: 0000000000000000 RBX: ffff8ecf6b760000 RCX: 0000000000000008
RDX: 0000000000000000 RSI: 000000000000596f RDI: ffff8ecf6db20000
RBP: ffff8ecf6a187000 R08: 0000000000000000 R09: ffff8ecf6f88fc00
R10: 0000000000000001 R11: 0000000000000006 R12: ffff8ecf727ec200
R13: 0000000000000006 R14: ffff8ecf6f982800 R15: ffff8ecf6e749200
FS:  0000000000000000(0000) GS:ffff8ecf7e9c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb5fb4a8000 CR3: 0000000356446000 CR4: 00000000003506e0
Call Trace:
 dcn10_init_hw+0x6ed/0x930 [amdgpu]
 dc_set_power_state+0xf5/0x140 [amdgpu]
 dm_resume+0x328/0x500 [amdgpu]
 amdgpu_device_ip_resume_phase2+0x52/0xb0 [amdgpu]
 ? amdgpu_device_fw_loading+0x9f/0x110 [amdgpu]
 amdgpu_device_gpu_recover.cold+0x8c1/0xf62 [amdgpu]
 amdgpu_job_timedout+0x11c/0x140 [amdgpu]
 drm_sched_job_timedout+0x72/0xf0 [gpu_sched]
 process_one_work+0x1b4/0x370


There also is this bugzilla about this:
https://bugzilla.redhat.com/show_bug.cgi?id=1929746
from today

And a whole bunch of others:
https://bugzilla.redhat.com/buglist.cgi?quicksearch=amdgpu_dm_backlight_update_status

Any help with resolving this would be much appreciated.

Regards,

Hans

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
