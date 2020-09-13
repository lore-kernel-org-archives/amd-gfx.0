Return-Path: <SRS0=JGsP=CW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DA0C43461
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Sep 2020 23:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33EA21D80
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Sep 2020 23:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL4MI1yH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33EA21D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D77FE89FC8;
	Sun, 13 Sep 2020 23:29:33 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E458F89FC8
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Sep 2020 23:29:32 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id z22so20599289ejl.7
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Sep 2020 16:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=H3EoWEjhBpl4HfZAgPccU/yvfkGch4aFgiErvDh5NoI=;
 b=iL4MI1yHh1YEBSMM1gp9LqjRBrv1Km3hTB0U2HwyvQe9xRSV5rsOoxrljjlAgWoMeF
 MwDudJRllPw3OIL91OdyuB0J1VlAf5uWq65/WyugOx3qLkxTDVKmfRNq7v889dQpp1yd
 4esdHiTiGlQxBbJv3yinow0sWluWMs9QjI6ss38xx5Jra2ExRaEt6oo0yD8YRZdAau4E
 2fLyqamyiNOaff5fCocVzWAulouNfeGHeZpFUHIa9jsF8H4U2R4efAau9LcARTBHtqMW
 hVmnx/LTni/9tsyNq4Fmj+5e5FeKLU3TyTHryZVUSHhKKwFPEiTl26s6zFNKUEOLp3W+
 9PqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=H3EoWEjhBpl4HfZAgPccU/yvfkGch4aFgiErvDh5NoI=;
 b=RQxvJOXR0CHDRfSHjWiySr1hgqGFEE4qvxVvF0W+/T5+gPtFONCyMDggIB09TqpDlN
 biEnzYNkkqwM3VqRaWnLIQ+0fQcHSKJo+6TauV6ymcFNHm0UQVHJkxbxJ4Au8by4OHKE
 4ntO0I0B2GmQwZ5wA3DzgBsvAwk1s6lHSzhNSGya7WViWHyIZpsqr+xR017FsaWGHXzl
 DB2I2Y+666gIHtK891Zd9UjvS+0itbgXZbxoZBmZFnw+J/jQdHmw/ihziR3U3SDL/hn1
 KqtBPeuWz8lQ460E5PhvHdrfmgV36W1+m2sY5xZjcnttkPMidFV4++Ooc+X/JJIJgpxb
 Akbg==
X-Gm-Message-State: AOAM530PrLu9o9RLVVztfbfwQjaLJWnv8UYU+UrxUCImyfwamhoWxAbS
 NpjT64Ex0PQmaZPlM+pjW/UlHeOymLPi7P0c/Vs0rmWWrAcTnQ==
X-Google-Smtp-Source: ABdhPJx+eDtln/DW/Nh1lXxtlmAyjoXKgnhIOWkKkyo4LIqYlXdnmJF8/TTJfOnYygZKRHN2/XhcvT+irmjA0Po0Pik=
X-Received: by 2002:a17:906:9443:: with SMTP id
 z3mr12507020ejx.156.1600039770870; 
 Sun, 13 Sep 2020 16:29:30 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Mon, 14 Sep 2020 01:29:20 +0200
Message-ID: <CAD=4a=V2tsuhF9_Om-Y_pz=SfpZ-PWQQbKaFLtG0gG8fQA4+MA@mail.gmail.com>
Subject: kernel NULL pointer dereference with dce_aux_transfer_raw
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
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
Content-Type: multipart/mixed; boundary="===============1776428976=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1776428976==
Content-Type: multipart/alternative; boundary="0000000000002b556005af3a4aaa"

--0000000000002b556005af3a4aaa
Content-Type: text/plain; charset="UTF-8"

Hi,

first I had some enabling link 2 failed: 15 after DPMS, but then I got a
NULL pointer dereference later.

I'm running 5.8.8 + "Require primary plane to be enabled whenever the CRTC
is"
2x 4K DisplayPort monitors. Gnome Wayland desktop, Ubuntu 20.10.

sep 14 00:22:01 mammut kernel: ------------[ cut here ]------------
sep 14 00:22:01 mammut kernel: WARNING: CPU: 3 PID: 2113 at
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:2419
decide_link_settings+0x22e/0x250 [amdgpu]
sep 14 00:22:01 mammut kernel: Modules linked in: input_leds joydev overlay
snd_hda_codec_realtek snd_hda_codec_generic binfmt_misc ledtrig_audio
snd_hda_codec_hdmi edac_mce_amd amdgpu snd_hda_intel snd_intel_dspcfg
kvm_amd snd_hda_codec nls_iso8859_1 snd_usb_audio snd_hda_core
snd_usbmidi_lib kvm snd_hwdep snd_pcm snd_seq_midi crct10dif_pclmul
snd_seq_midi_event ghash_cl>
sep 14 00:22:01 mammut kernel: CPU: 3 PID: 2113 Comm: gnome-shell Tainted:
G        W  OE     5.8.8+ #16
sep 14 00:22:01 mammut kernel: Hardware name: System manufacturer System
Product Name/PRIME X370-PRO, BIOS 5603 07/28/2020
sep 14 00:22:01 mammut kernel: RIP: 0010:decide_link_settings+0x22e/0x250
[amdgpu]
sep 14 00:22:01 mammut kernel: Code: 8b 54 24 18 49 89 06 49 89 56 08 e9 05
ff ff ff 48 8b 83 88 00 00 00 48 8b 93 90 00 00 00 49 89 06 49 89 56 08 e9
eb fe ff ff <0f> 0b e9 d5 fe ff ff 8b 4b 5c e9 c3 fe ff ff e8 4e 09 b0 eb
66 66
sep 14 00:22:01 mammut kernel: RSP: 0018:ffff9e508205f5d0 EFLAGS: 00010246
sep 14 00:22:01 mammut kernel: RAX: 0000000000000000 RBX: ffff8f2b30e84400
RCX: 0000000000000000
sep 14 00:22:01 mammut kernel: RDX: 0000000000000001 RSI: ffff9e508205f628
RDI: ffff8f2b32fa7030
sep 14 00:22:01 mammut kernel: RBP: ffff9e508205f618 R08: ffff8f2b32fa7000
R09: ffff9e508205f5c0
sep 14 00:22:01 mammut kernel: R10: 0000000000000001 R11: 0000000000000003
R12: 0000000000c34830
sep 14 00:22:01 mammut kernel: R13: ffff8f2b32fa7000 R14: ffff9e508205f628
R15: ffff9e508205f628
sep 14 00:22:01 mammut kernel: FS:  00007f16aa242d80(0000)
GS:ffff8f2b3e8c0000(0000) knlGS:0000000000000000
sep 14 00:22:01 mammut kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
sep 14 00:22:01 mammut kernel: CR2: 0000558c697954e0 CR3: 00000007d304e000
CR4: 00000000003406e0
sep 14 00:22:01 mammut kernel: Call Trace:
sep 14 00:22:01 mammut kernel:  enable_link_dp+0x14c/0x210 [amdgpu]
sep 14 00:22:01 mammut kernel:  core_link_enable_stream+0x65b/0x7f0 [amdgpu]
sep 14 00:22:01 mammut kernel:  dce110_apply_ctx_to_hw+0x590/0x5d0 [amdgpu]
sep 14 00:22:01 mammut kernel:  dc_commit_state+0x339/0xa10 [amdgpu]
sep 14 00:22:01 mammut kernel:  ? kfree+0xb8/0x250
sep 14 00:22:01 mammut kernel:  ?
drm_calc_timestamping_constants+0x10b/0x150 [drm]
sep 14 00:22:01 mammut kernel:  amdgpu_dm_atomic_commit_tail+0x33e/0x2250
[amdgpu]
sep 14 00:22:01 mammut kernel:  ? update_load_avg+0x643/0x670
sep 14 00:22:01 mammut kernel:  ? __cgroup_account_cputime+0x2f/0x50
sep 14 00:22:01 mammut kernel:  ? update_curr+0x78/0x210
sep 14 00:22:01 mammut kernel:  ? update_cfs_group+0x9c/0xb0
sep 14 00:22:01 mammut kernel:  ? dequeue_entity+0xb6/0x440
sep 14 00:22:01 mammut kernel:  ? newidle_balance+0xe8/0x410
sep 14 00:22:01 mammut kernel:  ? __switch_to+0x157/0x470
sep 14 00:22:01 mammut kernel:  ? finish_task_switch+0x75/0x260
sep 14 00:22:01 mammut kernel:  ? ttm_bo_mem_compat+0x28/0x60 [ttm]
sep 14 00:22:01 mammut kernel:  ? ttm_bo_validate+0x54/0x180 [ttm]
sep 14 00:22:01 mammut kernel:  ? amdgpu_bo_pin_restricted+0x64/0x2c0
[amdgpu]
sep 14 00:22:01 mammut kernel:  ? ttm_bo_move_to_lru_tail+0x26/0xd0 [ttm]
sep 14 00:22:01 mammut kernel:  ? ttm_eu_backoff_reservation+0x5d/0x70 [ttm]
sep 14 00:22:01 mammut kernel:  ? amdgpu_bo_gpu_offset+0x23/0xa0 [amdgpu]
sep 14 00:22:01 mammut kernel:  ? dm_plane_helper_prepare_fb+0x136/0x2a0
[amdgpu]
sep 14 00:22:01 mammut kernel:  ? wait_for_completion_timeout+0xc0/0xf0
sep 14 00:22:01 mammut kernel:  commit_tail+0x99/0x130 [drm_kms_helper]
sep 14 00:22:01 mammut kernel:  drm_atomic_helper_commit+0x123/0x150
[drm_kms_helper]
sep 14 00:22:01 mammut kernel:  amdgpu_dm_atomic_commit+0xbd/0xd0 [amdgpu]
sep 14 00:22:01 mammut kernel:  drm_atomic_commit+0x4a/0x50 [drm]
sep 14 00:22:01 mammut kernel:  drm_atomic_helper_set_config+0x7c/0xc0
[drm_kms_helper]
sep 14 00:22:01 mammut kernel:  drm_mode_setcrtc+0x20b/0x7d0 [drm]
sep 14 00:22:01 mammut kernel:  ? drm_mode_getcrtc+0x190/0x190 [drm]
sep 14 00:22:01 mammut kernel:  drm_ioctl_kernel+0xae/0xf0 [drm]
sep 14 00:22:01 mammut kernel:  drm_ioctl+0x238/0x3d0 [drm]
sep 14 00:22:01 mammut kernel:  ? drm_mode_getcrtc+0x190/0x190 [drm]
sep 14 00:22:01 mammut kernel:  amdgpu_drm_ioctl+0x4e/0x80 [amdgpu]
sep 14 00:22:01 mammut kernel:  ksys_ioctl+0x8e/0xc0
sep 14 00:22:01 mammut kernel:  __x64_sys_ioctl+0x1a/0x20
sep 14 00:22:01 mammut kernel:  do_syscall_64+0x52/0xc0
sep 14 00:22:01 mammut kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
sep 14 00:22:01 mammut kernel: RIP: 0033:0x7f16af88f31b
sep 14 00:22:01 mammut kernel: Code: 89 d8 49 8d 3c 1c 48 f7 d8 49 39 c4 72
b5 e8 1c ff ff ff 85 c0 78 ba 4c 89 e0 5b 5d 41 5c c3 f3 0f 1e fa b8 10 00
00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1d 3b 0d 00 f7 d8 64 89
01 48
sep 14 00:22:01 mammut kernel: RSP: 002b:00007ffdb4dc6cf8 EFLAGS: 00000246
ORIG_RAX: 0000000000000010
sep 14 00:22:01 mammut kernel: RAX: ffffffffffffffda RBX: 00007ffdb4dc6d30
RCX: 00007f16af88f31b
sep 14 00:22:01 mammut kernel: RDX: 00007ffdb4dc6d30 RSI: 00000000c06864a2
RDI: 0000000000000009
sep 14 00:22:01 mammut kernel: RBP: 00000000c06864a2 R08: 0000000000000000
R09: 0000558c67768bc0
sep 14 00:22:01 mammut kernel:  ? drm_mode_getcrtc+0x190/0x190 [drm]
sep 14 00:22:01 mammut kernel:  amdgpu_drm_ioctl+0x4e/0x80 [amdgpu]
sep 14 00:22:01 mammut kernel:  ksys_ioctl+0x8e/0xc0
sep 14 00:22:01 mammut kernel:  __x64_sys_ioctl+0x1a/0x20
sep 14 00:22:01 mammut kernel:  do_syscall_64+0x52/0xc0
sep 14 00:22:01 mammut kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
sep 14 00:22:01 mammut kernel: RIP: 0033:0x7f16af88f31b
sep 14 00:22:01 mammut kernel: Code: 89 d8 49 8d 3c 1c 48 f7 d8 49 39 c4 72
b5 e8 1c ff ff ff 85 c0 78 ba 4c 89 e0 5b 5d 41 5c c3 f3 0f 1e fa b8 10 00
00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1d 3b 0d 00 f7 d8 64 89
01 48
sep 14 00:22:01 mammut kernel: RSP: 002b:00007ffdb4dc6cf8 EFLAGS: 00000246
ORIG_RAX: 0000000000000010
sep 14 00:22:01 mammut kernel: RAX: ffffffffffffffda RBX: 00007ffdb4dc6d30
RCX: 00007f16af88f31b
sep 14 00:22:01 mammut kernel: RDX: 00007ffdb4dc6d30 RSI: 00000000c06864a2
RDI: 0000000000000009
sep 14 00:22:01 mammut kernel: RBP: 00000000c06864a2 R08: 0000000000000000
R09: 0000558c67768bc0
sep 14 00:22:01 mammut kernel: R10: 0000000000000000 R11: 0000000000000246
R12: 0000558c683058a0
sep 14 00:22:01 mammut kernel: R13: 0000000000000009 R14: 0000558c67768bc0
R15: 0000558c66f81550
sep 14 00:22:01 mammut kernel: ---[ end trace 5558c8a39b5251e4 ]---
sep 14 00:22:02 mammut kernel: [drm] enabling link 2 failed: 15
sep 14 00:22:02 mammut kernel: [drm] enabling link 2 failed: 15
sep 14 00:22:04 mammut kernel: [drm] enabling link 2 failed: 15
sep 14 00:22:05 mammut kernel: [drm] enabling link 2 failed: 15
sep 14 00:22:28 mammut kernel: [drm] enabling link 2 failed: 15
sep 14 00:22:29 mammut kernel: IPv6: MLD: clamping QRV from 1 to 2!
sep 14 00:22:45 mammut kernel: [drm] enabling link 2 failed: 15
sep 14 00:24:34 mammut kernel: IPv6: MLD: clamping QRV from 1 to 2!
sep 14 00:26:39 mammut kernel: IPv6: MLD: clamping QRV from 1 to 2!
sep 14 00:28:44 mammut kernel: IPv6: MLD: clamping QRV from 1 to 2!
sep 14 00:30:49 mammut kernel: IPv6: MLD: clamping QRV from 1 to 2!
sep 14 00:32:54 mammut kernel: IPv6: MLD: clamping QRV from 1 to 2!
sep 14 00:34:59 mammut kernel: IPv6: MLD: clamping QRV from 1 to 2!
sep 14 00:37:04 mammut kernel: IPv6: MLD: clamping QRV from 1 to 2!
sep 14 00:39:09 mammut kernel: IPv6: MLD: clamping QRV from 1 to 2!
sep 14 00:41:14 mammut kernel: IPv6: MLD: clamping QRV from 1 to 2!
sep 14 00:42:39 mammut kernel: [drm] enabling link 2 failed: 15
sep 14 00:43:19 mammut kernel: IPv6: MLD: clamping QRV from 1 to 2!
sep 14 00:44:16 mammut kernel: BUG: kernel NULL pointer dereference,
address: 0000000000000010
sep 14 00:44:16 mammut kernel: #PF: supervisor write access in kernel mode
sep 14 00:44:16 mammut kernel: #PF: error_code(0x0002) - not-present page
sep 14 00:44:16 mammut kernel: PGD 0 P4D 0
sep 14 00:44:16 mammut kernel: Oops: 0002 [#1] PREEMPT SMP NOPTI
sep 14 00:44:16 mammut kernel: CPU: 10 PID: 15018 Comm: more Tainted: G
   W  OE     5.8.8+ #16
sep 14 00:44:16 mammut kernel: Hardware name: System manufacturer System
Product Name/PRIME X370-PRO, BIOS 5603 07/28/2020
sep 14 00:44:16 mammut kernel: RIP: 0010:dce_aux_transfer_raw+0x57e/0xa80
[amdgpu]
sep 14 00:44:16 mammut kernel: Code: 38 48 8b 7b 10 4c 8d 45 9c 8b 48 28 48
8b 43 40 0f b6 50 0a 48 8b 43 30 8b 70 08 e8 9c 83 0c 00 8b 55 9c 44 89 e0
41 83 c4 01 <41> 88 54 05 00 44 3b 65 94 72 c8 45 0f be f6 48 8b 7b 08 e8
aa 47
sep 14 00:44:16 mammut kernel: RSP: 0018:ffff9e5082867c80 EFLAGS: 00010202
sep 14 00:44:16 mammut kernel: RAX: 0000000000000000 RBX: ffff8f2b38958e00
RCX: 0000000000000008
sep 14 00:44:16 mammut kernel: RDX: 0000000000000012 RSI: 00000000000170f8
RDI: ffff8f2b372a0000
sep 14 00:44:16 mammut kernel: RBP: ffff9e5082867d10 R08: ffff9e5082867cac
R09: ffff9e5082867bf0
sep 14 00:44:16 mammut kernel: R10: 0000000000000001 R11: 0000000000000000
R12: 0000000000000001
sep 14 00:44:16 mammut kernel: R13: 0000000000000010 R14: 0000000000000001
R15: ffff9e5082867d8d
sep 14 00:44:16 mammut kernel: FS:  00007f2f1876e740(0000)
GS:ffff8f2b3ea80000(0000) knlGS:0000000000000000
sep 14 00:44:16 mammut kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
sep 14 00:44:16 mammut kernel: CR2: 0000000000000010 CR3: 00000003e5442000
CR4: 00000000003406e0
sep 14 00:44:16 mammut kernel: Call Trace:
sep 14 00:44:16 mammut kernel:  dc_link_aux_transfer_raw+0xe/0x10 [amdgpu]
sep 14 00:44:16 mammut kernel:  dm_dp_aux_transfer+0x85/0xe0 [amdgpu]
sep 14 00:44:16 mammut kernel:  drm_dp_dpcd_access+0x72/0x110
[drm_kms_helper]
sep 14 00:44:16 mammut kernel:  drm_dp_dpcd_read+0xb7/0xf0 [drm_kms_helper]
sep 14 00:44:16 mammut kernel:  dm_helpers_dp_read_dpcd+0x29/0x50 [amdgpu]
sep 14 00:44:16 mammut kernel:  dp_dpcd_data_read+0x85/0xd0 [amdgpu]
sep 14 00:44:16 mammut kernel:  full_proxy_read+0x5c/0x80
sep 14 00:44:16 mammut kernel:  vfs_read+0xaa/0x190
sep 14 00:44:16 mammut kernel:  ksys_read+0x67/0xe0
sep 14 00:44:16 mammut kernel:  __x64_sys_read+0x1a/0x20
sep 14 00:44:16 mammut kernel:  do_syscall_64+0x52/0xc0
sep 14 00:44:16 mammut kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
sep 14 00:44:16 mammut kernel: RIP: 0033:0x7f2f18879cb2
sep 14 00:44:16 mammut kernel: Code: c0 e9 b2 fe ff ff 50 48 8d 3d ba be 0a
00 e8 d5 0a 02 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0
75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89
54 24
sep 14 00:44:16 mammut kernel: RSP: 002b:00007ffe51e0b4c8 EFLAGS: 00000246
ORIG_RAX: 0000000000000000
sep 14 00:44:16 mammut kernel: RAX: ffffffffffffffda RBX: 00005559a68a09d0
RCX: 00007f2f18879cb2
sep 14 00:44:16 mammut kernel: RDX: 0000000000001000 RSI: 00005559a68a6000
RDI: 0000000000000004
sep 14 00:44:16 mammut kernel: RBP: 00007f2f189564c0 R08: 0000000000000004
R09: 00005559a68a6000
sep 14 00:44:16 mammut kernel: R10: 00005559a68a7000 R11: 0000000000000246
R12: 0000000000000002
sep 14 00:44:16 mammut kernel: R13: 00007f2f189558c0 R14: 0000000000000d68
R15: 0000000000000d68
sep 14 00:44:16 mammut kernel: Modules linked in: input_leds joydev overlay
snd_hda_codec_realtek snd_hda_codec_generic binfmt_misc ledtrig_audio
snd_hda_codec_hdmi edac_mce_amd amdgpu snd_hda_intel snd_intel_dspcfg
kvm_amd snd_hda_codec nls_iso8859_1 snd_usb_audio snd_hda_core
snd_usbmidi_lib kvm snd_hwdep snd_pcm snd_seq_midi crct10dif_pclmul
snd_seq_midi_event ghash_cl>
sep 14 00:44:16 mammut kernel: CR2: 0000000000000010
sep 14 00:44:16 mammut kernel: ---[ end trace 5558c8a39b5251e5 ]---
sep 14 00:44:16 mammut kernel: RIP: 0010:dce_aux_transfer_raw+0x57e/0xa80
[amdgpu]
sep 14 00:44:16 mammut kernel: Code: 38 48 8b 7b 10 4c 8d 45 9c 8b 48 28 48
8b 43 40 0f b6 50 0a 48 8b 43 30 8b 70 08 e8 9c 83 0c 00 8b 55 9c 44 89 e0
41 83 c4 01 <41> 88 54 05 00 44 3b 65 94 72 c8 45 0f be f6 48 8b 7b 08 e8
aa 47
sep 14 00:44:16 mammut kernel: RSP: 0018:ffff9e5082867c80 EFLAGS: 00010202
sep 14 00:44:16 mammut kernel: RAX: 0000000000000000 RBX: ffff8f2b38958e00
RCX: 0000000000000008
sep 14 00:44:16 mammut kernel: RDX: 0000000000000012 RSI: 00000000000170f8
RDI: ffff8f2b372a0000
sep 14 00:44:16 mammut kernel: RBP: ffff9e5082867d10 R08: ffff9e5082867cac
R09: ffff9e5082867bf0
sep 14 00:44:16 mammut kernel: R10: 0000000000000001 R11: 0000000000000000
R12: 0000000000000001
sep 14 00:44:16 mammut kernel: R13: 0000000000000010 R14: 0000000000000001
R15: ffff9e5082867d8d
sep 14 00:44:16 mammut kernel: FS:  00007f2f1876e740(0000)
GS:ffff8f2b3ea80000(0000) knlGS:0000000000000000
sep 14 00:44:16 mammut kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
sep 14 00:44:16 mammut kernel: CR2: 0000000000000010 CR3: 00000003e5442000
CR4: 00000000003406e0

--0000000000002b556005af3a4aaa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Hi,</div><div class=3D"gmail_default" style=3D"font-fam=
ily:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_default" styl=
e=3D"font-family:arial,helvetica,sans-serif">first I had some enabling link=
 2 failed: 15 after DPMS, but then I got a NULL pointer dereference later.<=
/div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans=
-serif"><br></div><div class=3D"gmail_default" style=3D"font-family:arial,h=
elvetica,sans-serif">I&#39;m running 5.8.8 + &quot;Require primary plane to=
 be enabled whenever the CRTC is&quot;</div><div class=3D"gmail_default" st=
yle=3D"font-family:arial,helvetica,sans-serif">2x 4K DisplayPort monitors. =
Gnome Wayland desktop, Ubuntu 20.10.<br></div><div class=3D"gmail_default" =
style=3D"font-family:arial,helvetica,sans-serif"><br></div><div class=3D"gm=
ail_default" style=3D"font-family:arial,helvetica,sans-serif">sep 14 00:22:=
01 mammut kernel: ------------[ cut here ]------------<br>sep 14 00:22:01 m=
ammut kernel: WARNING: CPU: 3 PID: 2113 at drivers/gpu/drm/amd/amdgpu/../di=
splay/dc/core/dc_link_dp.c:2419 decide_link_settings+0x22e/0x250 [amdgpu]<b=
r>sep 14 00:22:01 mammut kernel: Modules linked in: input_leds joydev overl=
ay snd_hda_codec_realtek snd_hda_codec_generic binfmt_misc ledtrig_audio sn=
d_hda_codec_hdmi edac_mce_amd amdgpu snd_hda_intel snd_intel_dspcfg kvm_amd=
 snd_hda_codec nls_iso8859_1 snd_usb_audio snd_hda_core snd_usbmidi_lib kvm=
 snd_hwdep snd_pcm snd_seq_midi crct10dif_pclmul snd_seq_midi_event ghash_c=
l&gt;<br>sep 14 00:22:01 mammut kernel: CPU: 3 PID: 2113 Comm: gnome-shell =
Tainted: G =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0OE =C2=A0 =C2=A0 5.8.8+ #16<b=
r>sep 14 00:22:01 mammut kernel: Hardware name: System manufacturer System =
Product Name/PRIME X370-PRO, BIOS 5603 07/28/2020<br>sep 14 00:22:01 mammut=
 kernel: RIP: 0010:decide_link_settings+0x22e/0x250 [amdgpu]<br>sep 14 00:2=
2:01 mammut kernel: Code: 8b 54 24 18 49 89 06 49 89 56 08 e9 05 ff ff ff 4=
8 8b 83 88 00 00 00 48 8b 93 90 00 00 00 49 89 06 49 89 56 08 e9 eb fe ff f=
f &lt;0f&gt; 0b e9 d5 fe ff ff 8b 4b 5c e9 c3 fe ff ff e8 4e 09 b0 eb 66 66=
<br>sep 14 00:22:01 mammut kernel: RSP: 0018:ffff9e508205f5d0 EFLAGS: 00010=
246<br>sep 14 00:22:01 mammut kernel: RAX: 0000000000000000 RBX: ffff8f2b30=
e84400 RCX: 0000000000000000<br>sep 14 00:22:01 mammut kernel: RDX: 0000000=
000000001 RSI: ffff9e508205f628 RDI: ffff8f2b32fa7030<br>sep 14 00:22:01 ma=
mmut kernel: RBP: ffff9e508205f618 R08: ffff8f2b32fa7000 R09: ffff9e508205f=
5c0<br>sep 14 00:22:01 mammut kernel: R10: 0000000000000001 R11: 0000000000=
000003 R12: 0000000000c34830<br>sep 14 00:22:01 mammut kernel: R13: ffff8f2=
b32fa7000 R14: ffff9e508205f628 R15: ffff9e508205f628<br>sep 14 00:22:01 ma=
mmut kernel: FS: =C2=A000007f16aa242d80(0000) GS:ffff8f2b3e8c0000(0000) knl=
GS:0000000000000000<br>sep 14 00:22:01 mammut kernel: CS: =C2=A00010 DS: 00=
00 ES: 0000 CR0: 0000000080050033<br>sep 14 00:22:01 mammut kernel: CR2: 00=
00558c697954e0 CR3: 00000007d304e000 CR4: 00000000003406e0<br>sep 14 00:22:=
01 mammut kernel: Call Trace:<br>sep 14 00:22:01 mammut kernel: =C2=A0enabl=
e_link_dp+0x14c/0x210 [amdgpu]<br>sep 14 00:22:01 mammut kernel: =C2=A0core=
_link_enable_stream+0x65b/0x7f0 [amdgpu]<br>sep 14 00:22:01 mammut kernel: =
=C2=A0dce110_apply_ctx_to_hw+0x590/0x5d0 [amdgpu]<br>sep 14 00:22:01 mammut=
 kernel: =C2=A0dc_commit_state+0x339/0xa10 [amdgpu]<br>sep 14 00:22:01 mamm=
ut kernel: =C2=A0? kfree+0xb8/0x250<br>sep 14 00:22:01 mammut kernel: =C2=
=A0? drm_calc_timestamping_constants+0x10b/0x150 [drm]<br>sep 14 00:22:01 m=
ammut kernel: =C2=A0amdgpu_dm_atomic_commit_tail+0x33e/0x2250 [amdgpu]<br>s=
ep 14 00:22:01 mammut kernel: =C2=A0? update_load_avg+0x643/0x670<br>sep 14=
 00:22:01 mammut kernel: =C2=A0? __cgroup_account_cputime+0x2f/0x50<br>sep =
14 00:22:01 mammut kernel: =C2=A0? update_curr+0x78/0x210<br>sep 14 00:22:0=
1 mammut kernel: =C2=A0? update_cfs_group+0x9c/0xb0<br>sep 14 00:22:01 mamm=
ut kernel: =C2=A0? dequeue_entity+0xb6/0x440<br>sep 14 00:22:01 mammut kern=
el: =C2=A0? newidle_balance+0xe8/0x410<br>sep 14 00:22:01 mammut kernel: =
=C2=A0? __switch_to+0x157/0x470<br>sep 14 00:22:01 mammut kernel: =C2=A0? f=
inish_task_switch+0x75/0x260<br>sep 14 00:22:01 mammut kernel: =C2=A0? ttm_=
bo_mem_compat+0x28/0x60 [ttm]<br>sep 14 00:22:01 mammut kernel: =C2=A0? ttm=
_bo_validate+0x54/0x180 [ttm]<br>sep 14 00:22:01 mammut kernel: =C2=A0? amd=
gpu_bo_pin_restricted+0x64/0x2c0 [amdgpu]<br>sep 14 00:22:01 mammut kernel:=
 =C2=A0? ttm_bo_move_to_lru_tail+0x26/0xd0 [ttm]<br>sep 14 00:22:01 mammut =
kernel: =C2=A0? ttm_eu_backoff_reservation+0x5d/0x70 [ttm]<br>sep 14 00:22:=
01 mammut kernel: =C2=A0? amdgpu_bo_gpu_offset+0x23/0xa0 [amdgpu]<br>sep 14=
 00:22:01 mammut kernel: =C2=A0? dm_plane_helper_prepare_fb+0x136/0x2a0 [am=
dgpu]<br>sep 14 00:22:01 mammut kernel: =C2=A0? wait_for_completion_timeout=
+0xc0/0xf0<br>sep 14 00:22:01 mammut kernel: =C2=A0commit_tail+0x99/0x130 [=
drm_kms_helper]<br>sep 14 00:22:01 mammut kernel: =C2=A0drm_atomic_helper_c=
ommit+0x123/0x150 [drm_kms_helper]<br>sep 14 00:22:01 mammut kernel: =C2=A0=
amdgpu_dm_atomic_commit+0xbd/0xd0 [amdgpu]<br>sep 14 00:22:01 mammut kernel=
: =C2=A0drm_atomic_commit+0x4a/0x50 [drm]<br>sep 14 00:22:01 mammut kernel:=
 =C2=A0drm_atomic_helper_set_config+0x7c/0xc0 [drm_kms_helper]<br>sep 14 00=
:22:01 mammut kernel: =C2=A0drm_mode_setcrtc+0x20b/0x7d0 [drm]<br>sep 14 00=
:22:01 mammut kernel: =C2=A0? drm_mode_getcrtc+0x190/0x190 [drm]<br>sep 14 =
00:22:01 mammut kernel: =C2=A0drm_ioctl_kernel+0xae/0xf0 [drm]<br>sep 14 00=
:22:01 mammut kernel: =C2=A0drm_ioctl+0x238/0x3d0 [drm]<br>sep 14 00:22:01 =
mammut kernel: =C2=A0? drm_mode_getcrtc+0x190/0x190 [drm]<br>sep 14 00:22:0=
1 mammut kernel: =C2=A0amdgpu_drm_ioctl+0x4e/0x80 [amdgpu]<br>sep 14 00:22:=
01 mammut kernel: =C2=A0ksys_ioctl+0x8e/0xc0<br>sep 14 00:22:01 mammut kern=
el: =C2=A0__x64_sys_ioctl+0x1a/0x20<br>sep 14 00:22:01 mammut kernel: =C2=
=A0do_syscall_64+0x52/0xc0<br>sep 14 00:22:01 mammut kernel: =C2=A0entry_SY=
SCALL_64_after_hwframe+0x44/0xa9<br>sep 14 00:22:01 mammut kernel: RIP: 003=
3:0x7f16af88f31b<br>sep 14 00:22:01 mammut kernel: Code: 89 d8 49 8d 3c 1c =
48 f7 d8 49 39 c4 72 b5 e8 1c ff ff ff 85 c0 78 ba 4c 89 e0 5b 5d 41 5c c3 =
f3 0f 1e fa b8 10 00 00 00 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 8b 0=
d 1d 3b 0d 00 f7 d8 64 89 01 48<br>sep 14 00:22:01 mammut kernel: RSP: 002b=
:00007ffdb4dc6cf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010<br>sep 14 00:=
22:01 mammut kernel: RAX: ffffffffffffffda RBX: 00007ffdb4dc6d30 RCX: 00007=
f16af88f31b<br>sep 14 00:22:01 mammut kernel: RDX: 00007ffdb4dc6d30 RSI: 00=
000000c06864a2 RDI: 0000000000000009<br>sep 14 00:22:01 mammut kernel: RBP:=
 00000000c06864a2 R08: 0000000000000000 R09: 0000558c67768bc0<br>sep 14 00:=
22:01 mammut kernel: =C2=A0? drm_mode_getcrtc+0x190/0x190 [drm]<br>sep 14 0=
0:22:01 mammut kernel: =C2=A0amdgpu_drm_ioctl+0x4e/0x80 [amdgpu]<br>sep 14 =
00:22:01 mammut kernel: =C2=A0ksys_ioctl+0x8e/0xc0<br>sep 14 00:22:01 mammu=
t kernel: =C2=A0__x64_sys_ioctl+0x1a/0x20<br>sep 14 00:22:01 mammut kernel:=
 =C2=A0do_syscall_64+0x52/0xc0<br>sep 14 00:22:01 mammut kernel: =C2=A0entr=
y_SYSCALL_64_after_hwframe+0x44/0xa9<br>sep 14 00:22:01 mammut kernel: RIP:=
 0033:0x7f16af88f31b<br>sep 14 00:22:01 mammut kernel: Code: 89 d8 49 8d 3c=
 1c 48 f7 d8 49 39 c4 72 b5 e8 1c ff ff ff 85 c0 78 ba 4c 89 e0 5b 5d 41 5c=
 c3 f3 0f 1e fa b8 10 00 00 00 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 =
8b 0d 1d 3b 0d 00 f7 d8 64 89 01 48<br>sep 14 00:22:01 mammut kernel: RSP: =
002b:00007ffdb4dc6cf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010<br>sep 14=
 00:22:01 mammut kernel: RAX: ffffffffffffffda RBX: 00007ffdb4dc6d30 RCX: 0=
0007f16af88f31b<br>sep 14 00:22:01 mammut kernel: RDX: 00007ffdb4dc6d30 RSI=
: 00000000c06864a2 RDI: 0000000000000009<br>sep 14 00:22:01 mammut kernel: =
RBP: 00000000c06864a2 R08: 0000000000000000 R09: 0000558c67768bc0<br>sep 14=
 00:22:01 mammut kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 0=
000558c683058a0<br>sep 14 00:22:01 mammut kernel: R13: 0000000000000009 R14=
: 0000558c67768bc0 R15: 0000558c66f81550<br>sep 14 00:22:01 mammut kernel: =
---[ end trace 5558c8a39b5251e4 ]---<br>sep 14 00:22:02 mammut kernel: [drm=
] enabling link 2 failed: 15<br>sep 14 00:22:02 mammut kernel: [drm] enabli=
ng link 2 failed: 15<br>sep 14 00:22:04 mammut kernel: [drm] enabling link =
2 failed: 15<br>sep 14 00:22:05 mammut kernel: [drm] enabling link 2 failed=
: 15<br>sep 14 00:22:28 mammut kernel: [drm] enabling link 2 failed: 15<br>=
sep 14 00:22:29 mammut kernel: IPv6: MLD: clamping QRV from 1 to 2!<br>sep =
14 00:22:45 mammut kernel: [drm] enabling link 2 failed: 15<br>sep 14 00:24=
:34 mammut kernel: IPv6: MLD: clamping QRV from 1 to 2!<br>sep 14 00:26:39 =
mammut kernel: IPv6: MLD: clamping QRV from 1 to 2!<br>sep 14 00:28:44 mamm=
ut kernel: IPv6: MLD: clamping QRV from 1 to 2!<br>sep 14 00:30:49 mammut k=
ernel: IPv6: MLD: clamping QRV from 1 to 2!<br>sep 14 00:32:54 mammut kerne=
l: IPv6: MLD: clamping QRV from 1 to 2!<br>sep 14 00:34:59 mammut kernel: I=
Pv6: MLD: clamping QRV from 1 to 2!<br>sep 14 00:37:04 mammut kernel: IPv6:=
 MLD: clamping QRV from 1 to 2!<br>sep 14 00:39:09 mammut kernel: IPv6: MLD=
: clamping QRV from 1 to 2!<br>sep 14 00:41:14 mammut kernel: IPv6: MLD: cl=
amping QRV from 1 to 2!<br>sep 14 00:42:39 mammut kernel: [drm] enabling li=
nk 2 failed: 15<br>sep 14 00:43:19 mammut kernel: IPv6: MLD: clamping QRV f=
rom 1 to 2!<br>sep 14 00:44:16 mammut kernel: BUG: kernel NULL pointer dere=
ference, address: 0000000000000010<br>sep 14 00:44:16 mammut kernel: #PF: s=
upervisor write access in kernel mode<br>sep 14 00:44:16 mammut kernel: #PF=
: error_code(0x0002) - not-present page<br>sep 14 00:44:16 mammut kernel: P=
GD 0 P4D 0 <br>sep 14 00:44:16 mammut kernel: Oops: 0002 [#1] PREEMPT SMP N=
OPTI<br>sep 14 00:44:16 mammut kernel: CPU: 10 PID: 15018 Comm: more Tainte=
d: G =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0OE =C2=A0 =C2=A0 5.8.8+ #16<br>sep =
14 00:44:16 mammut kernel: Hardware name: System manufacturer System Produc=
t Name/PRIME X370-PRO, BIOS 5603 07/28/2020<br>sep 14 00:44:16 mammut kerne=
l: RIP: 0010:dce_aux_transfer_raw+0x57e/0xa80 [amdgpu]<br>sep 14 00:44:16 m=
ammut kernel: Code: 38 48 8b 7b 10 4c 8d 45 9c 8b 48 28 48 8b 43 40 0f b6 5=
0 0a 48 8b 43 30 8b 70 08 e8 9c 83 0c 00 8b 55 9c 44 89 e0 41 83 c4 01 &lt;=
41&gt; 88 54 05 00 44 3b 65 94 72 c8 45 0f be f6 48 8b 7b 08 e8 aa 47<br>se=
p 14 00:44:16 mammut kernel: RSP: 0018:ffff9e5082867c80 EFLAGS: 00010202<br=
>sep 14 00:44:16 mammut kernel: RAX: 0000000000000000 RBX: ffff8f2b38958e00=
 RCX: 0000000000000008<br>sep 14 00:44:16 mammut kernel: RDX: 0000000000000=
012 RSI: 00000000000170f8 RDI: ffff8f2b372a0000<br>sep 14 00:44:16 mammut k=
ernel: RBP: ffff9e5082867d10 R08: ffff9e5082867cac R09: ffff9e5082867bf0<br=
>sep 14 00:44:16 mammut kernel: R10: 0000000000000001 R11: 0000000000000000=
 R12: 0000000000000001<br>sep 14 00:44:16 mammut kernel: R13: 0000000000000=
010 R14: 0000000000000001 R15: ffff9e5082867d8d<br>sep 14 00:44:16 mammut k=
ernel: FS: =C2=A000007f2f1876e740(0000) GS:ffff8f2b3ea80000(0000) knlGS:000=
0000000000000<br>sep 14 00:44:16 mammut kernel: CS: =C2=A00010 DS: 0000 ES:=
 0000 CR0: 0000000080050033<br>sep 14 00:44:16 mammut kernel: CR2: 00000000=
00000010 CR3: 00000003e5442000 CR4: 00000000003406e0<br>sep 14 00:44:16 mam=
mut kernel: Call Trace:<br>sep 14 00:44:16 mammut kernel: =C2=A0dc_link_aux=
_transfer_raw+0xe/0x10 [amdgpu]<br>sep 14 00:44:16 mammut kernel: =C2=A0dm_=
dp_aux_transfer+0x85/0xe0 [amdgpu]<br>sep 14 00:44:16 mammut kernel: =C2=A0=
drm_dp_dpcd_access+0x72/0x110 [drm_kms_helper]<br>sep 14 00:44:16 mammut ke=
rnel: =C2=A0drm_dp_dpcd_read+0xb7/0xf0 [drm_kms_helper]<br>sep 14 00:44:16 =
mammut kernel: =C2=A0dm_helpers_dp_read_dpcd+0x29/0x50 [amdgpu]<br>sep 14 0=
0:44:16 mammut kernel: =C2=A0dp_dpcd_data_read+0x85/0xd0 [amdgpu]<br>sep 14=
 00:44:16 mammut kernel: =C2=A0full_proxy_read+0x5c/0x80<br>sep 14 00:44:16=
 mammut kernel: =C2=A0vfs_read+0xaa/0x190<br>sep 14 00:44:16 mammut kernel:=
 =C2=A0ksys_read+0x67/0xe0<br>sep 14 00:44:16 mammut kernel: =C2=A0__x64_sy=
s_read+0x1a/0x20<br>sep 14 00:44:16 mammut kernel: =C2=A0do_syscall_64+0x52=
/0xc0<br>sep 14 00:44:16 mammut kernel: =C2=A0entry_SYSCALL_64_after_hwfram=
e+0x44/0xa9<br>sep 14 00:44:16 mammut kernel: RIP: 0033:0x7f2f18879cb2<br>s=
ep 14 00:44:16 mammut kernel: Code: c0 e9 b2 fe ff ff 50 48 8d 3d ba be 0a =
00 e8 d5 0a 02 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 =
75 10 0f 05 &lt;48&gt; 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 4=
8 89 54 24<br>sep 14 00:44:16 mammut kernel: RSP: 002b:00007ffe51e0b4c8 EFL=
AGS: 00000246 ORIG_RAX: 0000000000000000<br>sep 14 00:44:16 mammut kernel: =
RAX: ffffffffffffffda RBX: 00005559a68a09d0 RCX: 00007f2f18879cb2<br>sep 14=
 00:44:16 mammut kernel: RDX: 0000000000001000 RSI: 00005559a68a6000 RDI: 0=
000000000000004<br>sep 14 00:44:16 mammut kernel: RBP: 00007f2f189564c0 R08=
: 0000000000000004 R09: 00005559a68a6000<br>sep 14 00:44:16 mammut kernel: =
R10: 00005559a68a7000 R11: 0000000000000246 R12: 0000000000000002<br>sep 14=
 00:44:16 mammut kernel: R13: 00007f2f189558c0 R14: 0000000000000d68 R15: 0=
000000000000d68<br>sep 14 00:44:16 mammut kernel: Modules linked in: input_=
leds joydev overlay snd_hda_codec_realtek snd_hda_codec_generic binfmt_misc=
 ledtrig_audio snd_hda_codec_hdmi edac_mce_amd amdgpu snd_hda_intel snd_int=
el_dspcfg kvm_amd snd_hda_codec nls_iso8859_1 snd_usb_audio snd_hda_core sn=
d_usbmidi_lib kvm snd_hwdep snd_pcm snd_seq_midi crct10dif_pclmul snd_seq_m=
idi_event ghash_cl&gt;<br>sep 14 00:44:16 mammut kernel: CR2: 0000000000000=
010<br>sep 14 00:44:16 mammut kernel: ---[ end trace 5558c8a39b5251e5 ]---<=
br>sep 14 00:44:16 mammut kernel: RIP: 0010:dce_aux_transfer_raw+0x57e/0xa8=
0 [amdgpu]<br>sep 14 00:44:16 mammut kernel: Code: 38 48 8b 7b 10 4c 8d 45 =
9c 8b 48 28 48 8b 43 40 0f b6 50 0a 48 8b 43 30 8b 70 08 e8 9c 83 0c 00 8b =
55 9c 44 89 e0 41 83 c4 01 &lt;41&gt; 88 54 05 00 44 3b 65 94 72 c8 45 0f b=
e f6 48 8b 7b 08 e8 aa 47<br>sep 14 00:44:16 mammut kernel: RSP: 0018:ffff9=
e5082867c80 EFLAGS: 00010202<br>sep 14 00:44:16 mammut kernel: RAX: 0000000=
000000000 RBX: ffff8f2b38958e00 RCX: 0000000000000008<br>sep 14 00:44:16 ma=
mmut kernel: RDX: 0000000000000012 RSI: 00000000000170f8 RDI: ffff8f2b372a0=
000<br>sep 14 00:44:16 mammut kernel: RBP: ffff9e5082867d10 R08: ffff9e5082=
867cac R09: ffff9e5082867bf0<br>sep 14 00:44:16 mammut kernel: R10: 0000000=
000000001 R11: 0000000000000000 R12: 0000000000000001<br>sep 14 00:44:16 ma=
mmut kernel: R13: 0000000000000010 R14: 0000000000000001 R15: ffff9e5082867=
d8d<br>sep 14 00:44:16 mammut kernel: FS: =C2=A000007f2f1876e740(0000) GS:f=
fff8f2b3ea80000(0000) knlGS:0000000000000000<br>sep 14 00:44:16 mammut kern=
el: CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>sep 14 00:44:=
16 mammut kernel: CR2: 0000000000000010 CR3: 00000003e5442000 CR4: 00000000=
003406e0<br></div></div>

--0000000000002b556005af3a4aaa--

--===============1776428976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1776428976==--
