Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9A26082BFD
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FrnSNDup
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAA8710F32B;
	Mon,  9 Nov 2026 14:09:36 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3EC910E2C5
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Nov 2026 17:05:31 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so1145645e9.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 08 Nov 2026 09:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794157530; x=1794762330; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FFR0uDsZ0vcaqqudLRrM2lEhcImE1k0yTsEtJlz4Lw8=;
 b=FrnSNDupuLrg5K6qk761xaUn1JVzWJsz4pVpIKHxllkjy9OynTrnZp1QHbJ9xQwSa3
 63lJNAelgKoQ87jiKHKWA3MxzHALJ32fTa9SeSxlS/Zsrih3nxI54oi2Q2eUQqQGic+y
 NKePBDew7HotchqFpl7nlXXsxs2VUtSaSpXXJIKSn42etIdRbCZLSBiEjGFIrHcbqywd
 C35wmI+SDbtiopwtBumX4vcf669zBFONHYTJRv8FJdRTLFzm/6yn0CO30QxchRQKYgjb
 Mk8xtaJM9TcbyaIn7FCNbyzsze0/jrXhatz3SvpVt26TgccLpwbOW60GyjKK/EAEnnv+
 G70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794157530; x=1794762330;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FFR0uDsZ0vcaqqudLRrM2lEhcImE1k0yTsEtJlz4Lw8=;
 b=ThWScOMUEZVyz0NIdUaOEk34FTdCZGqw+UWuJmihb7ljBRzzmmBnvffC2GgOf87nev
 n8UwDVMOLoDRlgdoe9WcxIZgnZp4RaZf2oY5PTnkvf1ocu+137OZ+lOnmuW700gjwsgl
 lDuCarsw9Ofi7ifJr0RFLQyO4R/uWVXYv5oSavfkSWFrNt8JxiHwp1dbKHy/W0G9nf3s
 x2cEcyFC0HxDwRzvfLwvEhcg6iEesBR6ovb421D9Nv1JUb7b5TfXdccALlXe/JaoHA5K
 OHukF0sz7+6FLQMXe793iNQ2bg+8fmNkI7Kcj5MTHgSuL0gqbWvBsYGmnnCVJy1ACJaG
 Ps7w==
X-Gm-Message-State: APuU4Z8u/OoKi5FaUS7zY3XT7YVp28G2jZfgalxfY8rUtjDVPjUtYLM8
 9U00+M7QouyBIhGUmxwtVxjDht29ATZTYZ3GnOGdHHtRoGkLjTQJDt+QOzhXoVFd
X-Gm-Gg: AYBFou3f8+dNigHDbv3MrCEErrXuoEyzxaAi5f/ojzl0M8aMJbivEGwh2qhnBe79X79
 7d1W0i0h7NuTLWAtJ7Ul20+/UV0drULFvn6eWPECeJuFXsby4ha/L2HmfR4xjohIIO16kwnhRwp
 Hk6XMkWqUbFAIdGSjVnJbukyWofvvj5JJvTA+cTydZcUHO3RXG+2rhkySTLDvXe2j1oMtgaZOWS
 mC6v6oLJaiXPrdvqury02X8St7dSG8wfEoj8tRwNOeqd3uD9oc4v/fMNsFSTJhY+38UkABYqPH+
 ruRcKAdGz1ZMPCXsPc944+YOR1y1OEAIzH9vQCzduSXI6dbVQeHCh/K9J8n+CenxkjuZkzs0DV3
 NUWTSv3heriqvC5KadQ+I21VZft/eTyOkbmCsN8gDqlB6KYYpxpyHyKPP7vSNRZpVjLa1UxQbl3
 CAu2XC+3fM14xOX5A/gAv2Qe1y3NkNn81j/QdHhggOB65Sm45iYE4YSeunXS74k7pi3ibcp6xM3
 iDlUR1xgX5oujXq0flrOFF1vhcmWRVwemWcatuuXQDiq2nkhrr2ZS/PYbMZGkdEIzQ2hE3dV9q2
 18sfCpcr0J+ZYpZZxWkAzw7+pfrVKwunvB6xoSSoG1xhGMLO6Q5ycormzA==
X-Received: by 2002:a05:600c:350b:b0:4a3:5da2:38ae with SMTP id
 5b1f17b1804b1-4b963c758e6mr41413975e9.14.1794157530159; 
 Sun, 08 Nov 2026 09:05:30 -0800 (PST)
Received: from NBLK-WAX9X.tail75a68b.ts.net
 ([2a00:1d36:5f19:6e00:eb69:2262:593:ab12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b76cb76697sm99640985e9.0.2026.11.08.09.05.28
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 09:05:29 -0800 (PST)
From: =?UTF-8?q?Ata=20=C4=B0lhan=20K=C3=B6kt=C3=BCrk?= <atailhan2006@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [BUG] Raven/Picasso (SMU10): MCLK stays at 1200 MHz after a Chromium
 GPU workload exits; cleared only by gpu_recover or a Firefox video
Date: Sun,  8 Nov 2026 20:05:26 +0300
Message-ID: <20261108170526.28744-1-atailhan2006@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
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
Kernel:  7.2.13-200.fc44.x86_64 (Fedora kernel, at most 1-2 releases
         behind the current stable; not tested on drm-next)
amdgpu 3.64.0, DCN 1.0, SMU10, VCN 1.0 (ENC 1.15 DEC 3 VEP 0 Rev 9)
Mesa 26.2.5, libva 2.23.0
Boot:    amdgpu.noretry=0 amdgpu.ppfeaturemask=0xffffffff
	 amdgpu.gpu_recovery=1 amdgpu.vcnfw_log=1
	 amdgpu.dcdebugmask=0x10
Userspace: no daemon or tool writes to amdgpu sysfs.

== Symptom ==

Idle: pp_dpm_mclk shows "0: 667Mhz *".

After WebGL (WebGL Aquarium) or VA-API video (YouTube, VP9 1080p) in
Brave, and closing the tab or the whole browser, pp_dpm_mclk shows
"3: 1200Mhz *" indefinitely, with GPU load 0% and SCLK back at idle.
amdgpu_pm_info reports "VCN: Powered down". Battery drain is about
5 W higher, (which for my machine it makes about 1.5 hour at my daily usage).

- Persists across tab close, browser kill -9, all fds closed, VT switch.
- power_dpm_force_performance_level stays "auto" and
  pp_power_profile_mode stays BOOTUP_DEFAULT throughout.
- While latched, writing "low" or manual MCLK levels does not move it.
  After it is cleared, MCLK follows low/manual requests normally.
- Cleared by: amdgpu_gpu_recover (debugfs), or by playing a video in
  Firefox (MCLK goes to 933 MHz during playback).
- Firefox itself does not trigger it.

== What triggers it ==

- WebGL alone in Brave latches it, with VCN powered down the whole
  time. So this is not specific to a VCN decode teardown path.
  A clean Brave without custom flags behaves the same.
- VA-API video decode in Brave latches it with VaapiVideoDecoder
  confirmed active in media-internals, in each of these variants:
  default flags, --use-angle=gl,
  --disable-features=UseMultiPlaneFormatForHardwareVideo,
  --disable-features=VaapiIgnoreDriverChecks
- mpv --hwdec=vaapi on the same file: MCLK is 933 MHz during playback.

== Kernel-side evidence ==

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
