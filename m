Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26DBC54FCB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 12:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F8320736
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 12:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F8320736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38E226E471;
	Fri, 24 Apr 2020 12:33:22 +0000 (UTC)
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1ADD6E471
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 12:33:20 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id u6so9740781ljl.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 05:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:openpgp:autocrypt:message-id
 :date:user-agent:mime-version:content-language
 :content-transfer-encoding;
 bh=4XYOTmJ9j/XFZuhvARIT1HWonS+HKw8rBXFHit8sZzg=;
 b=YoF1ioFph3cNqdqJX7C3vynIF84Hre2xzePkoqtUtEN/lYwTGg9WRHbQF88I4mM0hL
 5xhESImoJiCWG7fV0oWMk0HNKxS/AVovw8oZh20shVHkJaWz0XD8LXLA/Y+Yq3SupsNs
 KIS65L7kOsUDB+MI5I5954+QzyqzS3wH5laEv+klbd5ZyeEODGfT6CVKWmY/oNmk+ope
 lPEeqIYNHyw8CfeRaf/4Pji7HgTbBwGyh24gng8Jl2OcDNLiRw2WmsPVTWlnK6BeN/7L
 C6F4wktBuaJsuOM1Sh/affk5ar4xQBjYmh3zNnsIU0sRijO/WUpz4wZzgAw4GJVS0C5y
 3R7g==
X-Gm-Message-State: AGi0PuYCF1BsuW0wsRy6nitfqhyuqwrtiJm5KObbCL8CStVw3nIwwC9u
 dCYGZfsjutJ+2pjskCNiiwz4VZO5fAs=
X-Google-Smtp-Source: APiQypJE4TDtjjTqpUqJrNLXTY7cC0wSsjKijzgBAW+6X5eSONCZkdc0Sles4u06a8W/mzyZs1OXmQ==
X-Received: by 2002:a2e:164b:: with SMTP id 11mr5708795ljw.23.1587731598828;
 Fri, 24 Apr 2020 05:33:18 -0700 (PDT)
Received: from [192.168.0.88] (east.meadow.volia.net. [93.72.151.96])
 by smtp.googlemail.com with ESMTPSA id l18sm4172654lje.19.2020.04.24.05.33.17
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2020 05:33:17 -0700 (PDT)
To: amd-gfx@lists.freedesktop.org
From: Andriy Gapon <avg@FreeBSD.org>
Subject: FreeBSD / amdgpu / Vega 3, need help
Openpgp: preference=signencrypt
Autocrypt: addr=avg@FreeBSD.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6b75f089-7ac3-4444-4f88-b68c542ca0e5@FreeBSD.org>
Date: Fri, 24 Apr 2020 15:33:16 +0300
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Language: en-US
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


First, I understand that my platform is not directly supported and probably not
very interesting, but I still hope to get some tips or pointers.

I am trying to get amdgpu/FreeBSD going on Motile M141 laptop with Ryzen 3 3200U
CPU that has Vega 3 graphics integrated.  When amdgpu starts loading the screen
goes black and never lights up again.  I am not sure whether there is no signal
at all or whether the backlight is turned off, but the screen is completely
dark.  I can blindly interact with the system, so it's not crashed or hung.
From system logs I can see that the driver attaches successfully.  It recognizes
the hardware, loads its firmware, detects the eDP screen and so on.

The FreeBSD's amdgpu port that I am trying is based on code circa 5.0.
There is no newer version ported.
I tried a couple of Linux distros with 5.3.x kernels and they worked without any
problems. So that gives me some hope.

I compared driver messages (with drm_debug set to 0xfff) between Linux and
FreeBSD and they look quite similar.  Except for one thing.
In the FreeBSD case there are these error messages that are not seen with Linux:

[drm] pstate TEST_DEBUG_DATA: 0x0
WARNING !(0) failed at
/usr/home/avg/devel/kms-drm/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c:868
#0 0xffffffff83451633 at linux_dump_stack+0x23
#1 0xffffffff8325a9ee at dcn10_verify_allow_pstate_change_high+0x4e
#2 0xffffffff8325e925 at dcn10_wait_for_mpcc_disconnect+0x25
#3 0xffffffff8325de53 at dcn10_disable_plane+0x53
#4 0xffffffff8325c9f5 at dcn10_init_hw+0x755
#5 0xffffffff83295ca8 at dc_create+0x538
#6 0xffffffff8327a8da at dm_hw_init+0x1ea
#7 0xffffffff831701d1 at amdgpu_device_init+0x1b11
#8 0xffffffff83185177 at amdgpu_driver_load_kms+0xd7
#9 0xffffffff833f138e at drm_dev_register+0x17e
#10 0xffffffff83178dea at amdgpu_pci_probe+0x18a
#11 0xffffffff83456f40 at linux_pci_attach+0x560
#12 0xffffffff80bf68ea at device_attach+0x3ca
#13 0xffffffff80bf6490 at device_probe_and_attach+0x70
#14 0xffffffff80bf8358 at bus_generic_driver_added+0x58
#15 0xffffffff80bf4289 at devclass_driver_added+0x39
#16 0xffffffff80bf41c7 at devclass_add_driver+0x147
#17 0xffffffff83455ae9 at _linux_pci_register_driver+0xc9

That warning plus stack trace is actually BREAK_TO_DEBUGGER() in the original
Linux code.
So, that makes me think that the problem is pretty serious.
I tried searching for "TEST_DEBUG_DATA: 0x0" and I could not find a single
result with "0x0" in it.  Usually there is some non-zero value.
To me this looks like maybe some hardware component is not turned on...
Perhaps this is something relatively obvious for people that hack on the driver
and the hardware.
I hope to receive some hint about what to look for.
I can cherry-pick commits from Linux, apply patches, add additional debugging
logs, etc.

FreeBSD amdgpu dmesg: https://people.freebsd.org/~avg/amdgpu.dmesg.txt
Full Linux dmesg: https://people.freebsd.org/~avg/linux-5.3.0-28.dmesg.out

And with with drm_debug=0xfff.
FreeBSD: https://people.freebsd.org/~avg/fbsd-dmesg.txt
Linux: https://people.freebsd.org/~avg/linux-5.3.9-dmesg.txt

I see that both Linux and FreeBSD have similar messages about failing to load
some microcode components, but I guess that it must be okay since Linux works:
[    4.487381] [drm] reserve 0x400000 from 0xf400c00000 for PSP TMR
[    4.564893] [drm] failed to load ucode id (12)
[    4.564894] [drm] psp command failed and response status is (-53233)
[    4.567891] [drm] failed to load ucode id (13)
[    4.567892] [drm] psp command failed and response status is (-65521)
[    4.570891] [drm] failed to load ucode id (14)
[    4.570892] [drm] psp command failed and response status is (-65521)

Thank you!

-- 
Andriy Gapon
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
