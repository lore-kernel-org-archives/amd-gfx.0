Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C38E606D80F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iftOHngw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A07010F33B;
	Mon,  9 Nov 2026 14:09:37 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FEFF10E6E5
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 03:30:52 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso2253425e9.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 08 Nov 2026 19:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794195050; x=1794799850; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Cbxye5JecZHBie41NuQhf3Blu0dcrMpG3JLSckRterw=;
 b=iftOHngwIbu6C8erZ1MWIEriROwY2Cxq49Fd5p8C0rFTEguUOYLZ9wJ+nWMC+PMkak
 mnVGpZfhV7iP8UvKtr9jolgdZAJm69Zlg+220te8FQEHHdBGF2UPsmhZ285mnqBcwa8s
 v5MlFRRVNG/9YEZnOOywDAJPlKOebBPJGXNngWsC6iFK7MOWP6jgeFdoj67z7rIltk+D
 ZRIqruNmC6LZgg0zZfG1iFvkXwOXcEzEg7gENJgdtmbj2pZ1GBN5pSH7IP6vouASm33z
 PKmZst5kRJL46RHEKCxMUwywZ4JjQJCD6Zmr0rGe/pIERD9H7b4h7luKvA26gjzMnnDt
 D75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794195050; x=1794799850;
 h=content-transfer-encoding:content-type:subject:from:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cbxye5JecZHBie41NuQhf3Blu0dcrMpG3JLSckRterw=;
 b=WqAlTkX+kaTciHF4RuikNEdKivSsUv4iEsxSk+bRgcpG6hzcaN11O8issPIPRVOs8i
 5tAQ/KVSeHGp9HVHMWnujcM0OGB29klmKYH6oLI3f+NRXYnPzuElGTfuWIcc/vV85Pzs
 D8O2j+kvQmC+bfKEHIQh7iwzyqJ5nPvimlRV+c72/oINmz+jsrGzXPuvr0AHXJM8ivo5
 Cwc8uHZHqYZ8YK98ISMibe9TbXAWVyGOY/9438fSKYDdrdKZlma6X1xkCH1xUSy7nJOR
 fsm6TQGUmzMXxwyVEbbRswk38PbQdfRaOP88EGgseJ/lgEVgrzoSogSCxuv3Y6fst8TP
 rtmA==
X-Gm-Message-State: APuU4Z9kx6GAAR+12JI6Ma90F3WgJ8a/sWxwYmkciFOQ3+6/gyZ9cKPj
 KCXYckAHEOcXcK0/y0sfd3OQHD1PA/JH9y7z+8vtXY+lOldcTSjgzNi5a50bkcyX
X-Gm-Gg: AYBFou18ydmyOhBQFAPzKF+7bJbcmvhc5bZN1Y1oCbu7wemqL9QHHhsPY7TtY2iawmv
 Mvr59rNrz4iaK3UC+aWKzlbjEPUhdBzH0tLFQZ+ySC1s6r3iRnoPXJj5w4pw/uC3LMsXIkI6sPT
 nmXmb3Wn/oiRs8/yPw1RMev9LE4oFqf0nqMmlsAGP4vN/Axo8A/8//aT1cOM8ECrlU1mso7aOB/
 1TqY0XWJ/2cCS1NgLGGykK9M3VRUUM/+VpkvRMgquEc0rjdDzvO/1D5Sk7PuMUjZyJMYiGrLb0D
 te1qk7jWfioA3BpL4o+SxQRp3U8fW3bIWwHyUSD4hg06xlzcQTM99ZinqNQ5EPXumhGtYLghMDM
 6uveIk9J6wdwTmMveFQySAi1+ZtiXOVdEgeKSmGh54c6Ler9b2RpAOn/rDCDckyPEiBOHrwKuf2
 9+m8V5ZxCV8goxInRuOe3uhg497Arph1QPHsX0/rTMORMm1f/X7YMwrtK2WQPSW50mTCzYcvbEO
 4MPUFGyNxv6jo+z4QxeQLQHf2hAjU9MJOdG5zeViX5jO+gqTuga9z8lX7oSdaWojYiGBmfgExa2
 3qd0H56jusP4c7wy66NBCXLgkwBVbk47fBpmutgMP8N4XQWb3vr/vrpkT81Lvbx/k+AEZctFdpj
 WXp0=
X-Received: by 2002:a05:600c:4eca:b0:4a7:6425:c274 with SMTP id
 5b1f17b1804b1-4b94d7630d0mr50379315e9.2.1794195050313; 
 Sun, 08 Nov 2026 19:30:50 -0800 (PST)
Received: from ?IPV6:2a00:1d36:5f19:6e00:eb69:2262:593:ab12?
 ([2a00:1d36:5f19:6e00:eb69:2262:593:ab12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7efb0d7a7sm193859095e9.9.2026.11.08.19.30.48
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 19:30:49 -0800 (PST)
Message-ID: <a9fd74e7-6c18-46a1-a101-d4dcfd45c3ad@gmail.com>
Date: Mon, 9 Nov 2026 06:30:47 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
From: =?UTF-8?B?QXRhIMSwbGhhbiBLw7ZrdMO8cms=?= <atailhan2006@gmail.com>
Subject: [REGRESSION] amdgpu: Raven/Picasso MCLK stays at 1200 MHz after
 Chromium exits
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 14:09:35 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On a Picasso/Raven2 laptop, MCLK stays pinned at its highest level
(1200 MHz) after a Chromium-based browser (Brave) has used the GPU and
been closed. I could not find where the state is set or released from
the driver side, so I am asking whether this is known and what else I
should collect. I have the kernel tree and can test patches.

== System ==

Laptop:  Huawei MateBook D14 (NBLK-WAX9X), Ryzen 5 3500U,
          Picasso/Raven2 1002:15d8 rev c2
Distro:  Fedora 44, Sway 1.11 on Wayland
Kernel:  7.2.13-200.fc44.x86_64 (Fedora kernel, not tested on drm-next)
amdgpu 3.64.0, DCN 1.0, SMU10, VCN 1.0 (ENC 1.15 DEC 3 VEP 0 Rev 9)
Mesa 26.2.5, libva 2.23.0
Boot:    amdgpu.noretry=0 amdgpu.ppfeaturemask=0xffffffff
	 amdgpu.gpu_recovery=1 amdgpu.vcnfw_log=1
	 amdgpu.dcdebugmask=0x10
Userspace: no daemon or tool writes to amdgpu sysfs.

== Symptom ==

Idle: pp_dpm_mclk shows "0: 667Mhz *".

After WebGL (WebGL Aquarium, sometimes this doesn't trigger?) or
VA-API video (YouTube, VP9 1080p) in Brave, and closing the tab
or the whole browser, pp_dpm_mclk shows "3: 1200Mhz *" indefinitely,
with GPU load 0% and SCLK back at idle. amdgpu_pm_info reports
"VCN: Powered down". Battery drain is about 5 W higher, (which for
my machine it makes about 1.5 hour at my daily usage).

- Persists across tab close, browser kill -9, all fds closed, VT switch.
- power_dpm_force_performance_level stays "auto" and
   pp_power_profile_mode stays BOOTUP_DEFAULT throughout.
- While latched, writing "low" or manual MCLK levels does not move it.
   After it is cleared, MCLK follows low/manual requests normally.
- Cleared by: amdgpu_gpu_recover (debugfs), or by playing a video in
   Firefox (MCLK goes to 667 MHz -sometimes 933 MHz- during playback).
- Firefox itself does not trigger it.

== What triggers it ==

- WebGL alone in Brave latches it, with VCN powered down the whole
   time. So this is not specific to a VCN decode teardown path.
   A clean Brave without custom flags behaves the same.
- VA-API video decode in Brave latches it with VaapiVideoDecoder
   confirmed active in media-internals, in each of these variants:
   default flags, --use-angle=gl,
   --disable-features=UseMultiPlaneFormatForHardwareVideo,
   --disable-features=VaapiIgnoreDriverChecks, even I run with
   temp user directory with no flags, VA-API decoding ran and same issue
   continued.
- mpv --hwdec=vaapi on the same file: MCLK is 933 MHz during playback.

== Kernel-side ==

I attached bpftrace kprobes (with kstack) to smum_send_msg_to_smc and
smum_send_msg_to_smc_with_parameter and ran: Brave WebGL, Brave
YouTube, close (latched), Firefox WebGL, Firefox video (released),
then amdgpu_gpu_recover.

- Before the latch was first observed: 152 SMU messages, all either
   GFXOFF enable/disable (smu10_gfx_off_control) or two VCN power
   up/down pairs (smu10_powergate_vcn). No smu10_dpm_force_dpm_level,
   no hard-min, active-display-count or deep-sleep messages.
- Between the latched read and the released read (Firefox): again only
   GFXOFF toggles and two balanced VCN up/down pairs. Brave's video
   session produces the same two pairs and does not release.
- A kprobe on rv1_update_clocks never fires during any browser
   activity, only during gpu_recover.
- Each read of pp_dpm_sclk/pp_dpm_mclk issues an SMU query
   (smu10_emit_clock_levels), so the reported value is live.

So neither setting nor releasing the state is visible on the SMU
mailbox through these wrappers. This would not show direct register or
table writes. I cannot tell whether the state lives in SMU firmware,
in the display/data fabric p-state handshake, or elsewhere.

== Questions ==

1. Is this a known issue on Raven/Picasso?
2. On SMU10, what other path can hold FCLK/MCLK high that does not go
    through the mailbox (DCN hubbub watermarks, DF p-state, firmware
    internal state)?
3. What should I trace next? amdgpu_dm_dtn_log returns EPERM here even
    as root (probably lockdown); I can boot without Secure Boot if that
    output would help.

Full trace logs and brave://media-internals output are available; I can
attach them if asked.

Thanks,
Ata

