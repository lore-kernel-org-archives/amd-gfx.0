Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04045C05027
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jan 2023 14:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DE3810E4A5;
	Mon, 23 Jan 2023 14:13:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63C7910E352
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 12:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674475212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KTdX5L7SCSJ8Yt+IUXZCiIGtG+D1oXvdNfeq9PoFhVk=;
 b=W8lR+JloAU9VWI8OneyXGJjaH43rAPHANKggkLf2q2bnrbm5Z2BHTFDHaKYDOmF+4QsuE4
 Hnhb4vI+OfbJ5L6jPExyPGMffZ+9nemCzfjq0QhlEIqpq+3fpvwNFOxbCLRw9ez2BYj5+B
 bOXalJmD/Z+V9C6asImEyZTsQAivozc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-55-pUjWQdX0MjSMh-2nMa74Kw-1; Mon, 23 Jan 2023 07:00:11 -0500
X-MC-Unique: pUjWQdX0MjSMh-2nMa74Kw-1
Received: by mail-ej1-f70.google.com with SMTP id
 fx8-20020a170906b74800b00877a89f965aso3998857ejb.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 04:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KTdX5L7SCSJ8Yt+IUXZCiIGtG+D1oXvdNfeq9PoFhVk=;
 b=yfmVu+JtiXI3UvsxVfUd6I7w/JWXHHqSFIgPy/mTx3cemwT979rvd87+b8PSzoe15h
 HMPbafKfzCT792/eHNi/GTHixznykCL+A3TszWmG3GyOjWuKK3mUVRh2+hM2CEYgNqPI
 Gtvy7Uz+XL9C0kRzeLe3s/4A7OD0S0aWdKyDbHCckJy5ZBpluWmumd4N2H8kzS9bLsFu
 B6+f7o929IeCF25daHdRCftMoYb4Uj0fUUQ2Hk6hGSur6vZMM1kRBoeMbV3jLdxhxV4G
 dB+VALEyG+pSKXcjUF/ZEL6lpm3C3pH0fk2AHnzqbq1YB+9b2GSIctlpN+V10LTeBSof
 Mq7Q==
X-Gm-Message-State: AFqh2kr9R0HfW6z90C12a0m7TvoX25YKUPKydtt2IeT2/nlrA9y5Dn5O
 dPltCD0+jH+EUy3iypN5UNgnF3pe03uX9DUceCLx6xdrbousK0nHf/sY4xsuimbvJ294qwJ4I5N
 qVjremjqYz6jYHOiX1Slk65c2Mw==
X-Received: by 2002:a17:907:80cf:b0:7c1:962e:cf24 with SMTP id
 io15-20020a17090780cf00b007c1962ecf24mr27151197ejc.50.1674475209086; 
 Mon, 23 Jan 2023 04:00:09 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvBy64B3ScwsCDNhNdRelAHLTJMK5GubjgHicbLyUhBUYjUeFK65EOLZrLgrW7H/zgy1ORf6w==
X-Received: by 2002:a17:907:80cf:b0:7c1:962e:cf24 with SMTP id
 io15-20020a17090780cf00b007c1962ecf24mr27151166ejc.50.1674475208717; 
 Mon, 23 Jan 2023 04:00:08 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
 by smtp.gmail.com with ESMTPSA id
 k14-20020a17090632ce00b00871ac327db6sm10602091ejk.45.2023.01.23.04.00.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jan 2023 04:00:08 -0800 (PST)
Message-ID: <48052128-521b-87ca-295c-788200c83e4e@redhat.com>
Date: Mon, 23 Jan 2023 13:00:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
Subject: New? amdgpu drm_modeset_drop_locks oops/warning with 6.2-rc#
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 23 Jan 2023 14:12:54 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

Since I'm dogfooding 6.2-rc# I'm regularly (not always directly after boot) seeing
the following warning / oops in my logs.

This is on an AMD Ryzen 7 5700G on a B550M PRO-VDH WIFI with 2 1920x1080 monitors
connected (one over DVI and over HDMI IIRC).

[    4.896028] [drm] amdgpu kernel modesetting enabled.
[    4.907400] amdgpu: Virtual CRAT table created for CPU
[    4.907499] amdgpu: Topology: Add CPU node
[    4.907664] amdgpu 0000:30:00.0: enabling device drm_modeset_drop_locks(0006 -> 0007)
[    4.907730] [drm] initializing kernel modesetting (RENOIR 0x1002:0x1638 0x1002:0x1636 0xC8).
[    4.907744] [drm] register mmio base: 0xFCB00000
[    4.907745] [drm] register mmio size: 524288
[    4.909911] [drm] add ip block number 0 <soc15_common>
[    4.909913] [drm] add ip block number 1 <gmc_v9_0>
[    4.909915] [drm] add ip block number 2 <vega10_ih>
[    4.909916] [drm] add ip block number 3 <psp>
[    4.909917] [drm] add ip block number 4 <smu>
[    4.909918] [drm] add ip block number 5 <dm>
[    4.909919] [drm] add ip block number 6 <gfx_v9_0>
[    4.909920] [drm] add ip block number 7 <sdma_v4_0>
[    4.909921] [drm] add ip block number 8 <vcn_v2_0>
[    4.909923] [drm] add ip block number 9 <jpeg_v2_0>
[    4.909932] amdgpu 0000:30:00.0: amdgpu: Fetched VBIOS from VFCT
[    4.909935] amdgpu: ATOM BIOS: 13-CEZANNE-019
[    4.911735] [drm] VCN decode is enabled in VM mode
[    4.911737] [drm] VCN encode is enabled in VM mode
[    4.911739] [drm] JPEG decode is enabled in VM mode
[    4.929838] amdgpu 0000:30:00.0: vgaarb: deactivate vga console
[    4.929842] amdgpu 0000:30:00.0: amdgpu: Trusted Memory Zone (TMZ) feature enabled
[    4.929845] amdgpu 0000:30:00.0: amdgpu: PCIE atomic ops is not supported
[    4.929853] amdgpu 0000:30:00.0: amdgpu: MODE2 reset
[    4.930075] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[    4.930083] amdgpu 0000:30:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
[    4.930085] amdgpu 0000:30:00.0: amdgpu: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
[    4.930087] amdgpu 0000:30:00.0: amdgpu: AGP: 267419648M 0x000000F800000000 - 0x0000FFFFFFFFFFFF
[    4.930094] [drm] Detected VRAM RAM=2048M, BAR=2048M
[    4.930095] [drm] RAM width 128bits DDR4
[    4.930461] [drm] amdgpu: 2048M of VRAM memory ready
[    4.930463] [drm] amdgpu: 6783M of GTT memory ready.
[    4.930518] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    4.930719] [drm] PCIE GART of 1024M enabled.
[    4.930721] [drm] PTB located at 0x000000F47FC00000
[    4.935904] amdgpu 0000:30:00.0: amdgpu: PSP runtime database doesn't exist
[    4.935907] amdgpu 0000:30:00.0: amdgpu: PSP runtime database doesn't exist
[    4.940478] [drm] Loading DMUB firmware via PSP: version=0x01010024
[    4.966086] [drm] Found VCN firmware Version ENC: 1.19 DEC: 5 VEP: 0 Revision: 0
[    4.966103] amdgpu 0000:30:00.0: amdgpu: Will use PSP to load VCN firmware
[    5.694615] [drm] reserve 0x400000 from 0xf47f800000 for PSP TMR
[    5.779476] amdgpu 0000:30:00.0: amdgpu: RAS: optional ras ta ucode is not available
[    5.790135] amdgpu 0000:30:00.0: amdgpu: RAP: optional rap ta ucode is not available
[    5.790137] amdgpu 0000:30:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
[    5.790656] amdgpu 0000:30:00.0: amdgpu: SMU is initialized successfully!
[    5.791598] [drm] Display Core initialized with v3.2.215!
[    5.792138] [drm] DMUB hardware initialized: version=0x01010024
[    5.873355] [drm] kiq ring mec 2 pipe 1 q 0
[    5.878565] [drm] VCN decode and encode initialized successfully(under DPG Mode).
[    5.878612] [drm] JPEG decode initialized successfully.
[    5.880995] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    5.881100] amdgpu: sdma_bitmap: 3
[    5.897760] memmap_init_zone_device initialised 524288 pages in 2ms
[    5.897763] amdgpu: HMM registered 2048MB device memory
[    5.897882] amdgpu: SRAT table not found
[    5.897886] amdgpu: Virtual CRAT table created for GPU
[    5.898794] amdgpu: Topology: Add dGPU node [0x1638:0x1002]
[    5.898798] kfd kfd: amdgpu: added device 1002:1638
[    5.898875] amdgpu 0000:30:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 8, active_cu_number 8
[    5.899077] amdgpu 0000:30:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
[    5.899079] amdgpu 0000:30:00.0: amdgpu: ring gfx_low uses VM inv eng 1 on hub 0
[    5.899080] amdgpu 0000:30:00.0: amdgpu: ring gfx_high uses VM inv eng 4 on hub 0
[    5.899081] amdgpu 0000:30:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 5 on hub 0
[    5.899082] amdgpu 0000:30:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 6 on hub 0
[    5.899083] amdgpu 0000:30:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 7 on hub 0
[    5.899084] amdgpu 0000:30:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 8 on hub 0
[    5.899085] amdgpu 0000:30:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 9 on hub 0
[    5.899086] amdgpu 0000:30:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 10 on hub 0
[    5.899087] amdgpu 0000:30:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 11 on hub 0
[    5.899088] amdgpu 0000:30:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 12 on hub 0
[    5.899089] amdgpu 0000:30:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 13 on hub 0
[    5.899090] amdgpu 0000:30:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
[    5.899091] amdgpu 0000:30:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
[    5.899092] amdgpu 0000:30:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
[    5.899093] amdgpu 0000:30:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
[    5.899095] amdgpu 0000:30:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
[    5.902508] [drm] Initialized amdgpu 3.49.0 20150101 for 0000:30:00.0 on minor 1


[  101.993821] ------------[ cut here ]------------
[  101.993827] WARNING: CPU: 8 PID: 2371 at drivers/gpu/drm/drm_modeset_lock.c:276 drm_modeset_drop_locks+0x63/0x70
[  101.993836] Modules linked in: rfcomm snd_seq_dummy snd_hrtimer qrtr bnep binfmt_misc intel_rapl_msr iwlmvm intel_rapl_common snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi ledtrig_audio edac_mce_amd mac80211 snd_usb_audio snd_hda_intel kvm_amd snd_intel_dspcfg snd_intel_sdw_acpi libarc4 snd_usbmidi_lib snd_hda_codec snd_hda_core kvm snd_hwdep iwlwifi snd_rawmidi btusb mc btrtl vfat btbcm irqbypass btintel fat snd_seq btmtk rapl bluetooth snd_seq_device joydev snd_pcm cfg80211 snd_timer ecdh_generic snd pcspkr k10temp wmi_bmof rfkill r8169 soundcore i2c_piix4 gpio_amdpt acpi_cpufreq gpio_generic zram dm_crypt uas hid_logitech_hidpp usb_storage amdgpu drm_ttm_helper ttm crct10dif_pclmul crc32_pclmul iommu_v2 crc32c_intel drm_buddy ghash_clmulni_intel sha512_ssse3 gpu_sched hid_lg_g15 nvme sp5100_tco drm_display_helper ccp nvme_core cec video wmi hid_logitech_dj ip6_tables ip_tables fuse i2c_dev
[  101.993956] CPU: 8 PID: 2371 Comm: gnome-shell Not tainted 6.2.0-rc4+ #95
[  101.993959] Hardware name: Micro-Star International Co., Ltd. MS-7C95/B550M PRO-VDH WIFI (MS-7C95), BIOS 2.C0 08/05/2022
[  101.993962] RIP: 0010:drm_modeset_drop_locks+0x63/0x70
[  101.993967] Code: 42 08 48 89 10 48 89 1b 48 8d bb 60 ff ff ff 48 89 5b 08 e8 6f 31 5b 00 48 8b 45 70 49 39 c4 75 c6 5b 5d 41 5c c3 cc cc cc cc <0f> 0b eb ac 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90
[  101.993969] RSP: 0018:ffffa1f812a57bf8 EFLAGS: 00010282
[  101.993973] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000002
[  101.993975] RDX: 00000000000002c7 RSI: ffffffffad95fad1 RDI: ffffa1f812a57c78
[  101.993978] RBP: ffffa1f812a57c78 R08: 0000000000000001 R09: 0000000000000001
[  101.993980] R10: 0000000000000000 R11: 0000000000000008 R12: ffff8ccee3b05e00
[  101.993982] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  101.993984] FS:  00007f36aabde5c0(0000) GS:ffff8cd14dc00000(0000) knlGS:0000000000000000
[  101.993986] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  101.993988] CR2: 00007f368c16d000 CR3: 0000000132f06000 CR4: 0000000000750ee0
[  101.993991] PKRU: 55555554
[  101.993993] Call Trace:
[  101.993995]  <TASK>
[  101.994001]  drm_mode_atomic_ioctl+0x39e/0xb00
[  101.994055]  ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
[  101.994061]  drm_ioctl_kernel+0xa4/0x150
[  101.994070]  drm_ioctl+0x1de/0x460
[  101.994076]  ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
[  101.994084]  ? _raw_spin_unlock_irqrestore+0x30/0x60
[  101.994088]  ? _raw_spin_unlock_irqrestore+0x30/0x60
[  101.994091]  ? lockdep_hardirqs_on+0x7d/0x100
[  101.994096]  ? _raw_spin_unlock_irqrestore+0x40/0x60
[  101.994102]  amdgpu_drm_ioctl+0x4a/0x80 [amdgpu]
[  101.994327]  __x64_sys_ioctl+0x90/0xd0
[  101.994334]  do_syscall_64+0x5b/0x80
[  101.994340]  ? do_syscall_64+0x67/0x80
[  101.994343]  ? do_syscall_64+0x67/0x80
[  101.994347]  ? do_syscall_64+0x67/0x80
[  101.994350]  ? lockdep_hardirqs_on+0x7d/0x100
[  101.994354]  ? do_syscall_64+0x67/0x80
[  101.994357]  ? lockdep_hardirqs_on+0x7d/0x100
[  101.994361]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  101.994367] RIP: 0033:0x7f36ae523baf
[  101.994370] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[  101.994373] RSP: 002b:00007ffdfcf63250 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  101.994377] RAX: ffffffffffffffda RBX: 0000561a0222de90 RCX: 00007f36ae523baf
[  101.994379] RDX: 00007ffdfcf632f0 RSI: 00000000c03864bc RDI: 000000000000000a
[  101.994381] RBP: 00007ffdfcf632f0 R08: 0000000000000000 R09: 0000000000000000
[  101.994383] R10: 0000561a007b0010 R11: 0000000000000246 R12: 00000000c03864bc
[  101.994385] R13: 000000000000000a R14: 0000561a00b89b30 R15: 0000561a013ed7d0
[  101.994398]  </TASK>
[  101.994400] irq event stamp: 23511939
[  101.994402] hardirqs last  enabled at (23511945): [<ffffffffac19fb3e>] __up_console_sem+0x5e/0x70
[  101.994407] hardirqs last disabled at (23511950): [<ffffffffac19fb23>] __up_console_sem+0x43/0x70
[  101.994411] softirqs last  enabled at (23511770): [<ffffffffac10bd3d>] __irq_exit_rcu+0xed/0x160
[  101.994416] softirqs last disabled at (23511765): [<ffffffffac10bd3d>] __irq_exit_rcu+0xed/0x160
[  101.994420] ---[ end trace 0000000000000000 ]---


[ 1607.177570] ------------[ cut here ]------------
[ 1607.177577] WARNING: CPU: 5 PID: 2371 at drivers/gpu/drm/drm_modeset_lock.c:276 drm_modeset_drop_locks+0x63/0x70
[ 1607.177587] Modules linked in: rfcomm snd_seq_dummy snd_hrtimer qrtr bnep binfmt_misc intel_rapl_msr iwlmvm intel_rapl_common snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi ledtrig_audio edac_mce_amd mac80211 snd_usb_audio snd_hda_intel kvm_amd snd_intel_dspcfg snd_intel_sdw_acpi libarc4 snd_usbmidi_lib snd_hda_codec snd_hda_core kvm snd_hwdep iwlwifi snd_rawmidi btusb mc btrtl vfat btbcm irqbypass btintel fat snd_seq btmtk rapl bluetooth snd_seq_device joydev snd_pcm cfg80211 snd_timer ecdh_generic snd pcspkr k10temp wmi_bmof rfkill r8169 soundcore i2c_piix4 gpio_amdpt acpi_cpufreq gpio_generic zram dm_crypt uas hid_logitech_hidpp usb_storage amdgpu drm_ttm_helper ttm crct10dif_pclmul crc32_pclmul iommu_v2 crc32c_intel drm_buddy ghash_clmulni_intel sha512_ssse3 gpu_sched hid_lg_g15 nvme sp5100_tco drm_display_helper ccp nvme_core cec video wmi hid_logitech_dj ip6_tables ip_tables fuse i2c_dev
[ 1607.177674] CPU: 5 PID: 2371 Comm: gnome-shell Tainted: G        W          6.2.0-rc4+ #95
[ 1607.177676] Hardware name: Micro-Star International Co., Ltd. MS-7C95/B550M PRO-VDH WIFI (MS-7C95), BIOS 2.C0 08/05/2022
[ 1607.177678] RIP: 0010:drm_modeset_drop_locks+0x63/0x70
[ 1607.177681] Code: 42 08 48 89 10 48 89 1b 48 8d bb 60 ff ff ff 48 89 5b 08 e8 6f 31 5b 00 48 8b 45 70 49 39 c4 75 c6 5b 5d 41 5c c3 cc cc cc cc <0f> 0b eb ac 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90
[ 1607.177683] RSP: 0018:ffffa1f812a57c50 EFLAGS: 00010282
[ 1607.177686] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000002
[ 1607.177687] RDX: 00000000000002c7 RSI: ffffffffad95fad1 RDI: ffffa1f812a57cd0
[ 1607.177688] RBP: ffffa1f812a57cd0 R08: 0000000000000001 R09: 0000000000000001
[ 1607.177690] R10: 0000000000000000 R11: 0000000000000008 R12: ffff8ccf3beca240
[ 1607.177691] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 1607.177693] FS:  00007f36aabde5c0(0000) GS:ffff8cd14db40000(0000) knlGS:0000000000000000
[ 1607.177694] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1607.177696] CR2: 00007f1ad0230000 CR3: 0000000132f06000 CR4: 0000000000750ee0
[ 1607.177697] PKRU: 55555554
[ 1607.177699] Call Trace:
[ 1607.177701]  <TASK>
[ 1607.177705]  drm_mode_atomic_ioctl+0x39e/0xb00
[ 1607.177720]  ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
[ 1607.177723]  drm_ioctl_kernel+0xa4/0x150
[ 1607.177729]  drm_ioctl+0x1de/0x460
[ 1607.177733]  ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
[ 1607.177739]  ? _raw_spin_unlock_irqrestore+0x30/0x60
[ 1607.177742]  ? _raw_spin_unlock_irqrestore+0x30/0x60
[ 1607.177744]  ? lockdep_hardirqs_on+0x7d/0x100
[ 1607.177748]  ? _raw_spin_unlock_irqrestore+0x40/0x60
[ 1607.177752]  amdgpu_drm_ioctl+0x4a/0x80 [amdgpu]
[ 1607.177907]  __x64_sys_ioctl+0x90/0xd0
[ 1607.177912]  do_syscall_64+0x5b/0x80
[ 1607.177915]  ? do_syscall_64+0x67/0x80
[ 1607.177917]  ? do_syscall_64+0x67/0x80
[ 1607.177919]  ? lockdep_hardirqs_on+0x7d/0x100
[ 1607.177923]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 1607.177930] RIP: 0033:0x7f36ae523baf
[ 1607.177934] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[ 1607.177936] RSP: 002b:00007ffdfcf63250 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1607.177939] RAX: ffffffffffffffda RBX: 0000561a018ff0e0 RCX: 00007f36ae523baf
[ 1607.177940] RDX: 00007ffdfcf632f0 RSI: 00000000c03864bc RDI: 000000000000000a
[ 1607.177942] RBP: 00007ffdfcf632f0 R08: 0000000000000000 R09: 0000000000000000
[ 1607.177943] R10: 0000561a007b0010 R11: 0000000000000246 R12: 00000000c03864bc
[ 1607.177944] R13: 000000000000000a R14: 0000561a00fe7520 R15: 0000561a01863220
[ 1607.177953]  </TASK>
[ 1607.177954] irq event stamp: 370530815
[ 1607.177956] hardirqs last  enabled at (370530821): [<ffffffffac19fb3e>] __up_console_sem+0x5e/0x70
[ 1607.177960] hardirqs last disabled at (370530826): [<ffffffffac19fb23>] __up_console_sem+0x43/0x70
[ 1607.177962] softirqs last  enabled at (370527948): [<ffffffffac10bd3d>] __irq_exit_rcu+0xed/0x160
[ 1607.177966] softirqs last disabled at (370527943): [<ffffffffac10bd3d>] __irq_exit_rcu+0xed/0x160
[ 1607.177968] ---[ end trace 0000000000000000 ]---

<and more similar oopses>


I am afraid that I'm not entirely sure when exactly these warnings are triggering ...


I'm more then happy to build a kernel with some extra patches for debugging, enable some
existing extra debugging, etc.  Please let me know what you need to debug this.

Regards,

Hans


