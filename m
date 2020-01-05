Return-Path: <SRS0=TBsq=22=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0550C33C8C
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Jan 2020 20:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 713A420715
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Jan 2020 20:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713A420715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominik-schmitt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5721B89F85;
	Sun,  5 Jan 2020 20:01:28 +0000 (UTC)
X-Greylist: delayed 592 seconds by postgrey-1.36 at gabe;
 Sun, 05 Jan 2020 20:01:26 UTC
Received: from mxf932.netcup.net (mxf932.netcup.net [46.38.249.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D28F589F82
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Jan 2020 20:01:26 +0000 (UTC)
X-No-Relay: not in my network
Received: from [192.168.50.44] (p4FFC12C9.dip0.t-ipconnect.de [79.252.18.201])
 by mxf932.netcup.net (Postfix) with ESMTPSA id BD5922024F
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Jan 2020 20:51:32 +0100 (CET)
To: amd-gfx@lists.freedesktop.org
From: amd-gfx-freedesktop@dominik-schmitt.eu
Subject: Bug inside dc_helper.c
Message-ID: <65d0cc30-e4ca-c435-0827-66a24f3b5139@dominik-schmitt.eu>
Date: Sun, 5 Jan 2020 20:51:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
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
Content-Type: multipart/mixed; boundary="===============0178739219=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0178739219==
Content-Type: multipart/alternative;
 boundary="------------429564FB4E16460A5C9C7E34"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------429564FB4E16460A5C9C7E34
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Today I got several kernel messages. I do not know how to reproduce this 
messages.

I run an AMD Ryzen 5 2600X on a ASUS STRIX RX 5700XT

I added the 4 reports thrown below.

Have a nice day.

Kind regards,

Dominik/
/



1st report:

05.01.20 14:58        [drm] REG_WAIT timeout 1us * 100000 tries - 
mpc2_assert_idle_mpcc line:440
05.01.20 14:58        ------------[ cut here ]------------
05.01.20 14:58    WARNING    CPU: 1 PID: 896 at 
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:332 
generic_reg_wait.cold+0x25/0x2c [amdgpu]
05.01.20 14:58    Modules linked in    fuse md4 cmac nls_utf8 cifs 
libarc4 dns_resolver fscache libdes squashfs loop amdgpu 
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio 
snd_hda_codec_hdmi snd_hda_intel r8188eu(C) snd_intel_dspcfg 
snd_hda_codec snd_usb_audio edac_mce_amd lib80211 kvm_amd nls_iso8859_1 
snd_usbmidi_lib nls_cp437 snd_hda_core vfat fat gpu_sched eeepc_wmi ttm 
snd_rawmidi snd_seq_device mc kvm snd_hwdep asus_wmi irqbypass snd_pcm 
cfg80211 drm_kms_helper battery sparse_keymap snd_timer crct10dif_pclmul 
wmi_bmof mxm_wmi drm rfkill crc32_pclmul xpad ghash_clmulni_intel ccp 
snd ff_memless aesni_intel mousedev input_leds igb joydev crypto_simd 
agpgart sp5100_tco cryptd syscopyarea glue_helper sysfillrect pcspkr 
i2c_algo_bit i2c_piix4 sysimgblt k10temp fb_sys_fops rng_core soundcore 
dca wmi evdev pinctrl_amd mac_hid gpio_amdpt acpi_cpufreq uinput 
vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) crypto_user ip_tables x_tables 
ext4 crc32c_generic crc16 mbcache jbd2 sr_mod cdrom sd_mod uas
05.01.20 14:58        usb_storage hid_generic usbhid hid ahci libahci 
libata crc32c_intel xhci_pci xhci_hcd scsi_mod
05.01.20 14:58    CPU    1 PID: 896 Comm: Xorg Tainted: G C OE 
5.5.0-1-MANJARO #1
05.01.20 14:58    Hardware name    System manufacturer System Product 
Name/PRIME X470-PRO, BIOS 5406 11/13/2019
05.01.20 14:58    RIP    0010:generic_reg_wait.cold+0x25/0x2c [amdgpu]
05.01.20 14:58    Code    e9 b4 13 fe ff 44 8b 44 24 24 48 8b 4c 24 18 
44 89 fa 89 ee 48 c7 c7 98 18 85 c1 e8 28 51 59 f8 83 7b 20 01 0f 84 7a 
21 fe ff <0f> 0b e9 73 21 fe ff e8 24 9f e6 ff 48 c7 c7 00 20 91 c1 e8 88 13
05.01.20 14:58    RSP    0018:ffff9ce3c11b7638 EFLAGS: 00010297
05.01.20 14:58    RAX    000000000000004a RBX: ffff8eea36150980 RCX: 
0000000000000000
05.01.20 14:58    RDX    0000000000000000 RSI: ffff8eea3e859ac8 RDI: 
00000000ffffffff
05.01.20 14:58    RBP    0000000000000001 R08: 000000000000051b R09: 
0000000000000001
05.01.20 14:58    R10    0000000000000000 R11: 0000000000000001 R12: 
0000000000004790
05.01.20 14:58    R13    00000000000186a1 R14: 0000000000000001 R15: 
00000000000186a0
05.01.20 14:58    FS    00007fd6845b3dc0(0000) GS:ffff8eea3e840000(0000) 
knlGS:0000000000000000
05.01.20 14:58    CS    0010 DS: 0000 ES: 0000 CR0: 0000000080050033
05.01.20 14:58    CR2    000055fc86f26248 CR3: 00000007e4290000 CR4: 
00000000003406e0
05.01.20 14:58    Call Trace
05.01.20 14:58        mpc2_assert_idle_mpcc+0xb9/0xe0 [amdgpu]
05.01.20 14:58        dcn20_program_front_end_for_ctx+0x986/0xd50 [amdgpu]
05.01.20 14:58        dc_commit_state+0x258/0x5e0 [amdgpu]
05.01.20 14:58        amdgpu_dm_atomic_commit_tail+0xfa6/0x1fc0 [amdgpu]
05.01.20 14:58        commit_tail+0x94/0x130 [drm_kms_helper]
05.01.20 14:58        drm_atomic_helper_commit+0x113/0x140 [drm_kms_helper]
05.01.20 14:58        drm_atomic_helper_set_config+0x70/0xb0 
[drm_kms_helper]
05.01.20 14:58        drm_mode_setcrtc+0x1f0/0x730 [drm]
05.01.20 14:58        ? drm_mode_getcrtc+0x180/0x180 [drm]
05.01.20 14:58        drm_ioctl_kernel+0xb2/0x100 [drm]
05.01.20 14:58        drm_ioctl+0x209/0x360 [drm]
05.01.20 14:58        ? drm_mode_getcrtc+0x180/0x180 [drm]
05.01.20 14:58        amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
05.01.20 14:58        do_vfs_ioctl+0x4b7/0x730
05.01.20 14:58        ksys_ioctl+0x5e/0x90
05.01.20 14:58        __x64_sys_ioctl+0x16/0x20
05.01.20 14:58        do_syscall_64+0x4e/0x150
05.01.20 14:58        entry_SYSCALL_64_after_hwframe+0x44/0xa9
05.01.20 14:58    RIP    0033:0x7fd6853f925b
05.01.20 14:58    Code    0f 1e fa 48 8b 05 25 9c 0c 00 64 c7 00 26 00 
00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f5 9b 0c 00 f7 d8 64 89 01 48
05.01.20 14:58    RSP    002b:00007ffe8ce09888 EFLAGS: 00000246 
ORIG_RAX: 0000000000000010
05.01.20 14:58    RAX    ffffffffffffffda RBX: 00007ffe8ce098c0 RCX: 
00007fd6853f925b
05.01.20 14:58    RDX    00007ffe8ce098c0 RSI: 00000000c06864a2 RDI: 
000000000000000d
05.01.20 14:58    RBP    00000000c06864a2 R08: 0000000000000000 R09: 
000055fc86ad81a0
05.01.20 14:58    R10    0000000000000000 R11: 0000000000000246 R12: 
0000000000000000
05.01.20 14:58    R13    000000000000000d R14: 000055fc8638b990 R15: 
0000000000000000
05.01.20 14:58        ---[ end trace 56076c7a9bdc6a36 ]---


2nd report:

05.01.20 16:49        [drm] REG_WAIT timeout 1us * 100000 tries - 
mpc2_assert_idle_mpcc line:440
05.01.20 16:49        ------------[ cut here ]------------
05.01.20 16:49    WARNING    CPU: 0 PID: 896 at 
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:332 
generic_reg_wait.cold+0x25/0x2c [amdgpu]
05.01.20 16:49    Modules linked in    fuse md4 cmac nls_utf8 cifs 
libarc4 dns_resolver fscache libdes squashfs loop amdgpu 
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio 
snd_hda_codec_hdmi snd_hda_intel r8188eu(C) snd_intel_dspcfg 
snd_hda_codec snd_usb_audio edac_mce_amd lib80211 kvm_amd nls_iso8859_1 
snd_usbmidi_lib nls_cp437 snd_hda_core vfat fat gpu_sched eeepc_wmi ttm 
snd_rawmidi snd_seq_device mc kvm snd_hwdep asus_wmi irqbypass snd_pcm 
cfg80211 drm_kms_helper battery sparse_keymap snd_timer crct10dif_pclmul 
wmi_bmof mxm_wmi drm rfkill crc32_pclmul xpad ghash_clmulni_intel ccp 
snd ff_memless aesni_intel mousedev input_leds igb joydev crypto_simd 
agpgart sp5100_tco cryptd syscopyarea glue_helper sysfillrect pcspkr 
i2c_algo_bit i2c_piix4 sysimgblt k10temp fb_sys_fops rng_core soundcore 
dca wmi evdev pinctrl_amd mac_hid gpio_amdpt acpi_cpufreq uinput 
vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) crypto_user ip_tables x_tables 
ext4 crc32c_generic crc16 mbcache jbd2 sr_mod cdrom sd_mod uas
05.01.20 16:49        usb_storage hid_generic usbhid hid ahci libahci 
libata crc32c_intel xhci_pci xhci_hcd scsi_mod
05.01.20 16:49    CPU    0 PID: 896 Comm: Xorg Tainted: G WC OE 
5.5.0-1-MANJARO #1
05.01.20 16:49    Hardware name    System manufacturer System Product 
Name/PRIME X470-PRO, BIOS 5406 11/13/2019
05.01.20 16:49    RIP    0010:generic_reg_wait.cold+0x25/0x2c [amdgpu]
05.01.20 16:49    Code    e9 b4 13 fe ff 44 8b 44 24 24 48 8b 4c 24 18 
44 89 fa 89 ee 48 c7 c7 98 18 85 c1 e8 28 51 59 f8 83 7b 20 01 0f 84 7a 
21 fe ff <0f> 0b e9 73 21 fe ff e8 24 9f e6 ff 48 c7 c7 00 20 91 c1 e8 88 13
05.01.20 16:49    RSP    0018:ffff9ce3c11b7638 EFLAGS: 00010297
05.01.20 16:49    RAX    000000000000004a RBX: ffff8eea36150980 RCX: 
0000000000000000
05.01.20 16:49    RDX    0000000000000000 RSI: ffff8eea3e819ac8 RDI: 
00000000ffffffff
05.01.20 16:49    RBP    0000000000000001 R08: 0000000000000549 R09: 
0000000000000001
05.01.20 16:49    R10    0000000000000000 R11: 0000000000000001 R12: 
0000000000004790
05.01.20 16:49    R13    00000000000186a1 R14: 0000000000000001 R15: 
00000000000186a0
05.01.20 16:49    FS    00007fd6845b3dc0(0000) GS:ffff8eea3e800000(0000) 
knlGS:0000000000000000
05.01.20 16:49    CS    0010 DS: 0000 ES: 0000 CR0: 0000000080050033
05.01.20 16:49    CR2    00007f0aec00b128 CR3: 00000007e4290000 CR4: 
00000000003406f0
05.01.20 16:49    Call Trace
05.01.20 16:49        mpc2_assert_idle_mpcc+0xb9/0xe0 [amdgpu]
05.01.20 16:49        dcn20_program_front_end_for_ctx+0x986/0xd50 [amdgpu]
05.01.20 16:49        dc_commit_state+0x258/0x5e0 [amdgpu]
05.01.20 16:49        amdgpu_dm_atomic_commit_tail+0xfa6/0x1fc0 [amdgpu]
05.01.20 16:49        commit_tail+0x94/0x130 [drm_kms_helper]
05.01.20 16:49        drm_atomic_helper_commit+0x113/0x140 [drm_kms_helper]
05.01.20 16:49        drm_atomic_helper_set_config+0x70/0xb0 
[drm_kms_helper]
05.01.20 16:49        drm_mode_setcrtc+0x1f0/0x730 [drm]
05.01.20 16:49        ? drm_mode_getcrtc+0x180/0x180 [drm]
05.01.20 16:49        drm_ioctl_kernel+0xb2/0x100 [drm]
05.01.20 16:49        drm_ioctl+0x209/0x360 [drm]
05.01.20 16:49        ? drm_mode_getcrtc+0x180/0x180 [drm]
05.01.20 16:49        amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
05.01.20 16:49        do_vfs_ioctl+0x4b7/0x730
05.01.20 16:49        ksys_ioctl+0x5e/0x90
05.01.20 16:49        __x64_sys_ioctl+0x16/0x20
05.01.20 16:49        do_syscall_64+0x4e/0x150
05.01.20 16:49        entry_SYSCALL_64_after_hwframe+0x44/0xa9
05.01.20 16:49    RIP    0033:0x7fd6853f925b
05.01.20 16:49    Code    0f 1e fa 48 8b 05 25 9c 0c 00 64 c7 00 26 00 
00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f5 9b 0c 00 f7 d8 64 89 01 48
05.01.20 16:49    RSP    002b:00007ffe8ce09888 EFLAGS: 00000246 
ORIG_RAX: 0000000000000010
05.01.20 16:49    RAX    ffffffffffffffda RBX: 00007ffe8ce098c0 RCX: 
00007fd6853f925b
05.01.20 16:49    RDX    00007ffe8ce098c0 RSI: 00000000c06864a2 RDI: 
000000000000000d
05.01.20 16:49    RBP    00000000c06864a2 R08: 0000000000000000 R09: 
000055fc870bdab0
05.01.20 16:49    R10    0000000000000000 R11: 0000000000000246 R12: 
0000000000000000
05.01.20 16:49    R13    000000000000000d R14: 000055fc8638b990 R15: 
0000000000000000
05.01.20 16:49        ---[ end trace 56076c7a9bdc6a37 ]---


3rd report:

05.01.20 16:49        [drm] REG_WAIT timeout 1us * 200 tries - 
hubp2_set_blank line:928
05.01.20 16:49        ------------[ cut here ]------------
05.01.20 16:49    WARNING    CPU: 0 PID: 896 at 
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:332 
generic_reg_wait.cold+0x25/0x2c [amdgpu]
05.01.20 16:49    Modules linked in    fuse md4 cmac nls_utf8 cifs 
libarc4 dns_resolver fscache libdes squashfs loop amdgpu 
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio 
snd_hda_codec_hdmi snd_hda_intel r8188eu(C) snd_intel_dspcfg 
snd_hda_codec snd_usb_audio edac_mce_amd lib80211 kvm_amd nls_iso8859_1 
snd_usbmidi_lib nls_cp437 snd_hda_core vfat fat gpu_sched eeepc_wmi ttm 
snd_rawmidi snd_seq_device mc kvm snd_hwdep asus_wmi irqbypass snd_pcm 
cfg80211 drm_kms_helper battery sparse_keymap snd_timer crct10dif_pclmul 
wmi_bmof mxm_wmi drm rfkill crc32_pclmul xpad ghash_clmulni_intel ccp 
snd ff_memless aesni_intel mousedev input_leds igb joydev crypto_simd 
agpgart sp5100_tco cryptd syscopyarea glue_helper sysfillrect pcspkr 
i2c_algo_bit i2c_piix4 sysimgblt k10temp fb_sys_fops rng_core soundcore 
dca wmi evdev pinctrl_amd mac_hid gpio_amdpt acpi_cpufreq uinput 
vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) crypto_user ip_tables x_tables 
ext4 crc32c_generic crc16 mbcache jbd2 sr_mod cdrom sd_mod uas
05.01.20 16:49        usb_storage hid_generic usbhid hid ahci libahci 
libata crc32c_intel xhci_pci xhci_hcd scsi_mod
05.01.20 16:49    CPU    0 PID: 896 Comm: Xorg Tainted: G WC OE 
5.5.0-1-MANJARO #1
05.01.20 16:49    Hardware name    System manufacturer System Product 
Name/PRIME X470-PRO, BIOS 5406 11/13/2019
05.01.20 16:49    RIP    0010:generic_reg_wait.cold+0x25/0x2c [amdgpu]
05.01.20 16:49    Code    e9 b4 13 fe ff 44 8b 44 24 24 48 8b 4c 24 18 
44 89 fa 89 ee 48 c7 c7 98 18 85 c1 e8 28 51 59 f8 83 7b 20 01 0f 84 7a 
21 fe ff <0f> 0b e9 73 21 fe ff e8 24 9f e6 ff 48 c7 c7 00 20 91 c1 e8 88 13
05.01.20 16:49    RSP    0018:ffff9ce3c11b7628 EFLAGS: 00010297
05.01.20 16:49    RAX    0000000000000041 RBX: ffff8eea36150980 RCX: 
0000000000000000
05.01.20 16:49    RDX    0000000000000000 RSI: ffff8eea3e819ac8 RDI: 
00000000ffffffff
05.01.20 16:49    RBP    0000000000000001 R08: 0000000000000577 R09: 
0000000000000001
05.01.20 16:49    R10    0000000000000000 R11: 0000000000000001 R12: 
0000000000003d47
05.01.20 16:49    R13    00000000000000c9 R14: 0000000000000001 R15: 
00000000000000c8
05.01.20 16:49    FS    00007fd6845b3dc0(0000) GS:ffff8eea3e800000(0000) 
knlGS:0000000000000000
05.01.20 16:49    CS    0010 DS: 0000 ES: 0000 CR0: 0000000080050033
05.01.20 16:49    CR2    00007f809009bfe0 CR3: 00000007e4290000 CR4: 
00000000003406f0
05.01.20 16:49    Call Trace
05.01.20 16:49        hubp2_set_blank+0xc4/0xd0 [amdgpu]
05.01.20 16:49        dcn10_wait_for_mpcc_disconnect+0xc0/0x100 [amdgpu]
05.01.20 16:49        dcn20_plane_atomic_disable+0x35/0x150 [amdgpu]
05.01.20 16:49        dcn20_disable_plane+0x24/0x40 [amdgpu]
05.01.20 16:49        dcn20_program_front_end_for_ctx+0x3d5/0xd50 [amdgpu]
05.01.20 16:49        dc_commit_state+0x151/0x5e0 [amdgpu]
05.01.20 16:49        amdgpu_dm_atomic_commit_tail+0xfa6/0x1fc0 [amdgpu]
05.01.20 16:49        ? dm_read_reg_func+0x1f/0x90 [amdgpu]
05.01.20 16:49        ? dm_read_reg_func+0x1f/0x90 [amdgpu]
05.01.20 16:49        ? dm_read_reg_func+0x1f/0x90 [amdgpu]
05.01.20 16:49        ? dm_read_reg_func+0x1f/0x90 [amdgpu]
05.01.20 16:49        commit_tail+0x94/0x130 [drm_kms_helper]
05.01.20 16:49        drm_atomic_helper_commit+0x113/0x140 [drm_kms_helper]
05.01.20 16:49        drm_atomic_connector_commit_dpms+0xd7/0x100 [drm]
05.01.20 16:49        drm_mode_obj_set_property_ioctl+0x169/0x2e0 [drm]
05.01.20 16:49        ? drm_connector_set_obj_prop+0x90/0x90 [drm]
05.01.20 16:49        drm_connector_property_set_ioctl+0x41/0x60 [drm]
05.01.20 16:49        drm_ioctl_kernel+0xb2/0x100 [drm]
05.01.20 16:49        drm_ioctl+0x209/0x360 [drm]
05.01.20 16:49        ? drm_connector_set_obj_prop+0x90/0x90 [drm]
05.01.20 16:49        amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
05.01.20 16:49        do_vfs_ioctl+0x4b7/0x730
05.01.20 16:49        ? ep_item_poll.isra.0+0x3f/0xb0
05.01.20 16:49        ksys_ioctl+0x5e/0x90
05.01.20 16:49        __x64_sys_ioctl+0x16/0x20
05.01.20 16:49        do_syscall_64+0x4e/0x150
05.01.20 16:49        entry_SYSCALL_64_after_hwframe+0x44/0xa9
05.01.20 16:49    RIP    0033:0x7fd6853f925b
05.01.20 16:49    Code    0f 1e fa 48 8b 05 25 9c 0c 00 64 c7 00 26 00 
00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f5 9b 0c 00 f7 d8 64 89 01 48
05.01.20 16:49    RSP    002b:00007ffe8ce09cc8 EFLAGS: 00000246 
ORIG_RAX: 0000000000000010
05.01.20 16:49    RAX    ffffffffffffffda RBX: 00007ffe8ce09d00 RCX: 
00007fd6853f925b
05.01.20 16:49    RDX    00007ffe8ce09d00 RSI: 00000000c01064ab RDI: 
000000000000000d
05.01.20 16:49    RBP    00000000c01064ab R08: 0000000000000000 R09: 
000055fc86388510
05.01.20 16:49    R10    0000000000000000 R11: 0000000000000246 R12: 
000055fc86050c80
05.01.20 16:49    R13    000000000000000d R14: 000055fc87242480 R15: 
0000000000000000
05.01.20 16:49        ---[ end trace 56076c7a9bdc6a38 ]---


4th report

05.01.20 16:50        [drm] REG_WAIT timeout 1us * 100000 tries - 
mpc2_assert_idle_mpcc line:440
05.01.20 16:50        ------------[ cut here ]------------
05.01.20 16:50    WARNING    CPU: 7 PID: 896 at 
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:332 
generic_reg_wait.cold+0x25/0x2c [amdgpu]
05.01.20 16:50    Modules linked in    fuse md4 cmac nls_utf8 cifs 
libarc4 dns_resolver fscache libdes squashfs loop amdgpu 
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio 
snd_hda_codec_hdmi snd_hda_intel r8188eu(C) snd_intel_dspcfg 
snd_hda_codec snd_usb_audio edac_mce_amd lib80211 kvm_amd nls_iso8859_1 
snd_usbmidi_lib nls_cp437 snd_hda_core vfat fat gpu_sched eeepc_wmi ttm 
snd_rawmidi snd_seq_device mc kvm snd_hwdep asus_wmi irqbypass snd_pcm 
cfg80211 drm_kms_helper battery sparse_keymap snd_timer crct10dif_pclmul 
wmi_bmof mxm_wmi drm rfkill crc32_pclmul xpad ghash_clmulni_intel ccp 
snd ff_memless aesni_intel mousedev input_leds igb joydev crypto_simd 
agpgart sp5100_tco cryptd syscopyarea glue_helper sysfillrect pcspkr 
i2c_algo_bit i2c_piix4 sysimgblt k10temp fb_sys_fops rng_core soundcore 
dca wmi evdev pinctrl_amd mac_hid gpio_amdpt acpi_cpufreq uinput 
vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE) crypto_user ip_tables x_tables 
ext4 crc32c_generic crc16 mbcache jbd2 sr_mod cdrom sd_mod uas
05.01.20 16:50        usb_storage hid_generic usbhid hid ahci libahci 
libata crc32c_intel xhci_pci xhci_hcd scsi_mod
05.01.20 16:50    CPU    7 PID: 896 Comm: Xorg Tainted: G WC OE 
5.5.0-1-MANJARO #1
05.01.20 16:50    Hardware name    System manufacturer System Product 
Name/PRIME X470-PRO, BIOS 5406 11/13/2019
05.01.20 16:50    RIP    0010:generic_reg_wait.cold+0x25/0x2c [amdgpu]
05.01.20 16:50    Code    e9 b4 13 fe ff 44 8b 44 24 24 48 8b 4c 24 18 
44 89 fa 89 ee 48 c7 c7 98 18 85 c1 e8 28 51 59 f8 83 7b 20 01 0f 84 7a 
21 fe ff <0f> 0b e9 73 21 fe ff e8 24 9f e6 ff 48 c7 c7 00 20 91 c1 e8 88 13
05.01.20 16:50    RSP    0018:ffff9ce3c11b7638 EFLAGS: 00010297
05.01.20 16:50    RAX    000000000000004a RBX: ffff8eea36150980 RCX: 
0000000000000000
05.01.20 16:50    RDX    0000000000000000 RSI: ffff8eea3e9d9ac8 RDI: 
00000000ffffffff
05.01.20 16:50    RBP    0000000000000001 R08: 00000000000005ae R09: 
0000000000000001
05.01.20 16:50    R10    0000000000000000 R11: 0000000000000001 R12: 
0000000000004790
05.01.20 16:50    R13    00000000000186a1 R14: 0000000000000001 R15: 
00000000000186a0
05.01.20 16:50    FS    00007fd6845b3dc0(0000) GS:ffff8eea3e9c0000(0000) 
knlGS:0000000000000000
05.01.20 16:50    CS    0010 DS: 0000 ES: 0000 CR0: 0000000080050033
05.01.20 16:50    CR2    000055fc86f47000 CR3: 00000007e4290000 CR4: 
00000000003406e0
05.01.20 16:50    Call Trace
05.01.20 16:50        mpc2_assert_idle_mpcc+0xb9/0xe0 [amdgpu]
05.01.20 16:50        dcn20_program_front_end_for_ctx+0x986/0xd50 [amdgpu]
05.01.20 16:50        dc_commit_state+0x258/0x5e0 [amdgpu]
05.01.20 16:50        amdgpu_dm_atomic_commit_tail+0xfa6/0x1fc0 [amdgpu]
05.01.20 16:50        commit_tail+0x94/0x130 [drm_kms_helper]
05.01.20 16:50        drm_atomic_helper_commit+0x113/0x140 [drm_kms_helper]
05.01.20 16:50        drm_atomic_helper_set_config+0x70/0xb0 
[drm_kms_helper]
05.01.20 16:50        drm_mode_setcrtc+0x1f0/0x730 [drm]
05.01.20 16:50        ? drm_mode_getcrtc+0x180/0x180 [drm]
05.01.20 16:50        drm_ioctl_kernel+0xb2/0x100 [drm]
05.01.20 16:50        drm_ioctl+0x209/0x360 [drm]
05.01.20 16:50        ? drm_mode_getcrtc+0x180/0x180 [drm]
05.01.20 16:50        amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
05.01.20 16:50        do_vfs_ioctl+0x4b7/0x730
05.01.20 16:50        ksys_ioctl+0x5e/0x90
05.01.20 16:50        __x64_sys_ioctl+0x16/0x20
05.01.20 16:50        do_syscall_64+0x4e/0x150
05.01.20 16:50        entry_SYSCALL_64_after_hwframe+0x44/0xa9
05.01.20 16:50    RIP    0033:0x7fd6853f925b
05.01.20 16:50    Code    0f 1e fa 48 8b 05 25 9c 0c 00 64 c7 00 26 00 
00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f5 9b 0c 00 f7 d8 64 89 01 48
05.01.20 16:50    RSP    002b:00007ffe8ce09888 EFLAGS: 00000246 
ORIG_RAX: 0000000000000010
05.01.20 16:50    RAX    ffffffffffffffda RBX: 00007ffe8ce098c0 RCX: 
00007fd6853f925b
05.01.20 16:50    RDX    00007ffe8ce098c0 RSI: 00000000c06864a2 RDI: 
000000000000000d
05.01.20 16:50    RBP    00000000c06864a2 R08: 0000000000000000 R09: 
000055fc876aae00
05.01.20 16:50    R10    0000000000000000 R11: 0000000000000246 R12: 
0000000000000000
05.01.20 16:50    R13    000000000000000d R14: 000055fc8638b990 R15: 
0000000000000000
05.01.20 16:50        ---[ end trace 56076c7a9bdc6a39 ]---


--------------429564FB4E16460A5C9C7E34
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Today I got several kernel messages. I do not know how to
      reproduce this messages.</p>
    <p>I run an AMD Ryzen 5 2600X on a ASUS STRIX RX 5700XT</p>
    <p>I added the 4 reports thrown below.<br>
    </p>
    <p>Have a nice day.</p>
    <p>Kind regards,</p>
    <p>Dominik<i><br>
      </i></p>
    <p><br>
    </p>
    <p><br>
    </p>
    <p>1st report:</p>
    <p>05.01.20 14:58        [drm] REG_WAIT timeout 1us * 100000 tries -
      mpc2_assert_idle_mpcc line:440<br>
      05.01.20 14:58        ------------[ cut here ]------------<br>
      05.01.20 14:58    WARNING    CPU: 1 PID: 896 at
      drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:332
      generic_reg_wait.cold+0x25/0x2c [amdgpu]<br>
      05.01.20 14:58    Modules linked in    fuse md4 cmac nls_utf8 cifs
      libarc4 dns_resolver fscache libdes squashfs loop amdgpu
      snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
      snd_hda_codec_hdmi snd_hda_intel r8188eu(C) snd_intel_dspcfg
      snd_hda_codec snd_usb_audio edac_mce_amd lib80211 kvm_amd
      nls_iso8859_1 snd_usbmidi_lib nls_cp437 snd_hda_core vfat fat
      gpu_sched eeepc_wmi ttm snd_rawmidi snd_seq_device mc kvm
      snd_hwdep asus_wmi irqbypass snd_pcm cfg80211 drm_kms_helper
      battery sparse_keymap snd_timer crct10dif_pclmul wmi_bmof mxm_wmi
      drm rfkill crc32_pclmul xpad ghash_clmulni_intel ccp snd
      ff_memless aesni_intel mousedev input_leds igb joydev crypto_simd
      agpgart sp5100_tco cryptd syscopyarea glue_helper sysfillrect
      pcspkr i2c_algo_bit i2c_piix4 sysimgblt k10temp fb_sys_fops
      rng_core soundcore dca wmi evdev pinctrl_amd mac_hid gpio_amdpt
      acpi_cpufreq uinput vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE)
      crypto_user ip_tables x_tables ext4 crc32c_generic crc16 mbcache
      jbd2 sr_mod cdrom sd_mod uas<br>
      05.01.20 14:58        usb_storage hid_generic usbhid hid ahci
      libahci libata crc32c_intel xhci_pci xhci_hcd scsi_mod<br>
      05.01.20 14:58    CPU    1 PID: 896 Comm: Xorg Tainted: G C OE
      5.5.0-1-MANJARO #1<br>
      05.01.20 14:58    Hardware name    System manufacturer System
      Product Name/PRIME X470-PRO, BIOS 5406 11/13/2019<br>
      05.01.20 14:58    RIP    0010:generic_reg_wait.cold+0x25/0x2c
      [amdgpu]<br>
      05.01.20 14:58    Code    e9 b4 13 fe ff 44 8b 44 24 24 48 8b 4c
      24 18 44 89 fa 89 ee 48 c7 c7 98 18 85 c1 e8 28 51 59 f8 83 7b 20
      01 0f 84 7a 21 fe ff &lt;0f&gt; 0b e9 73 21 fe ff e8 24 9f e6 ff
      48 c7 c7 00 20 91 c1 e8 88 13<br>
      05.01.20 14:58    RSP    0018:ffff9ce3c11b7638 EFLAGS: 00010297<br>
      05.01.20 14:58    RAX    000000000000004a RBX: ffff8eea36150980
      RCX: 0000000000000000<br>
      05.01.20 14:58    RDX    0000000000000000 RSI: ffff8eea3e859ac8
      RDI: 00000000ffffffff<br>
      05.01.20 14:58    RBP    0000000000000001 R08: 000000000000051b
      R09: 0000000000000001<br>
      05.01.20 14:58    R10    0000000000000000 R11: 0000000000000001
      R12: 0000000000004790<br>
      05.01.20 14:58    R13    00000000000186a1 R14: 0000000000000001
      R15: 00000000000186a0<br>
      05.01.20 14:58    FS    00007fd6845b3dc0(0000)
      GS:ffff8eea3e840000(0000) knlGS:0000000000000000<br>
      05.01.20 14:58    CS    0010 DS: 0000 ES: 0000 CR0:
      0000000080050033<br>
      05.01.20 14:58    CR2    000055fc86f26248 CR3: 00000007e4290000
      CR4: 00000000003406e0<br>
      05.01.20 14:58    Call Trace    <br>
      05.01.20 14:58        mpc2_assert_idle_mpcc+0xb9/0xe0 [amdgpu]<br>
      05.01.20 14:58        dcn20_program_front_end_for_ctx+0x986/0xd50
      [amdgpu]<br>
      05.01.20 14:58        dc_commit_state+0x258/0x5e0 [amdgpu]<br>
      05.01.20 14:58        amdgpu_dm_atomic_commit_tail+0xfa6/0x1fc0
      [amdgpu]<br>
      05.01.20 14:58        commit_tail+0x94/0x130 [drm_kms_helper]<br>
      05.01.20 14:58        drm_atomic_helper_commit+0x113/0x140
      [drm_kms_helper]<br>
      05.01.20 14:58        drm_atomic_helper_set_config+0x70/0xb0
      [drm_kms_helper]<br>
      05.01.20 14:58        drm_mode_setcrtc+0x1f0/0x730 [drm]<br>
      05.01.20 14:58        ? drm_mode_getcrtc+0x180/0x180 [drm]<br>
      05.01.20 14:58        drm_ioctl_kernel+0xb2/0x100 [drm]<br>
      05.01.20 14:58        drm_ioctl+0x209/0x360 [drm]<br>
      05.01.20 14:58        ? drm_mode_getcrtc+0x180/0x180 [drm]<br>
      05.01.20 14:58        amdgpu_drm_ioctl+0x49/0x80 [amdgpu]<br>
      05.01.20 14:58        do_vfs_ioctl+0x4b7/0x730<br>
      05.01.20 14:58        ksys_ioctl+0x5e/0x90<br>
      05.01.20 14:58        __x64_sys_ioctl+0x16/0x20<br>
      05.01.20 14:58        do_syscall_64+0x4e/0x150<br>
      05.01.20 14:58        entry_SYSCALL_64_after_hwframe+0x44/0xa9<br>
      05.01.20 14:58    RIP    0033:0x7fd6853f925b<br>
      05.01.20 14:58    Code    0f 1e fa 48 8b 05 25 9c 0c 00 64 c7 00
      26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa
      b8 10 00 00 00 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 8b 0d
      f5 9b 0c 00 f7 d8 64 89 01 48<br>
      05.01.20 14:58    RSP    002b:00007ffe8ce09888 EFLAGS: 00000246
      ORIG_RAX: 0000000000000010<br>
      05.01.20 14:58    RAX    ffffffffffffffda RBX: 00007ffe8ce098c0
      RCX: 00007fd6853f925b<br>
      05.01.20 14:58    RDX    00007ffe8ce098c0 RSI: 00000000c06864a2
      RDI: 000000000000000d<br>
      05.01.20 14:58    RBP    00000000c06864a2 R08: 0000000000000000
      R09: 000055fc86ad81a0<br>
      05.01.20 14:58    R10    0000000000000000 R11: 0000000000000246
      R12: 0000000000000000<br>
      05.01.20 14:58    R13    000000000000000d R14: 000055fc8638b990
      R15: 0000000000000000<br>
      05.01.20 14:58        ---[ end trace 56076c7a9bdc6a36 ]---</p>
    <p><br>
    </p>
    <p>2nd report:<br>
    </p>
    <p>05.01.20 16:49        [drm] REG_WAIT timeout 1us * 100000 tries -
      mpc2_assert_idle_mpcc line:440<br>
      05.01.20 16:49        ------------[ cut here ]------------<br>
      05.01.20 16:49    WARNING    CPU: 0 PID: 896 at
      drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:332
      generic_reg_wait.cold+0x25/0x2c [amdgpu]<br>
      05.01.20 16:49    Modules linked in    fuse md4 cmac nls_utf8 cifs
      libarc4 dns_resolver fscache libdes squashfs loop amdgpu
      snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
      snd_hda_codec_hdmi snd_hda_intel r8188eu(C) snd_intel_dspcfg
      snd_hda_codec snd_usb_audio edac_mce_amd lib80211 kvm_amd
      nls_iso8859_1 snd_usbmidi_lib nls_cp437 snd_hda_core vfat fat
      gpu_sched eeepc_wmi ttm snd_rawmidi snd_seq_device mc kvm
      snd_hwdep asus_wmi irqbypass snd_pcm cfg80211 drm_kms_helper
      battery sparse_keymap snd_timer crct10dif_pclmul wmi_bmof mxm_wmi
      drm rfkill crc32_pclmul xpad ghash_clmulni_intel ccp snd
      ff_memless aesni_intel mousedev input_leds igb joydev crypto_simd
      agpgart sp5100_tco cryptd syscopyarea glue_helper sysfillrect
      pcspkr i2c_algo_bit i2c_piix4 sysimgblt k10temp fb_sys_fops
      rng_core soundcore dca wmi evdev pinctrl_amd mac_hid gpio_amdpt
      acpi_cpufreq uinput vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE)
      crypto_user ip_tables x_tables ext4 crc32c_generic crc16 mbcache
      jbd2 sr_mod cdrom sd_mod uas<br>
      05.01.20 16:49        usb_storage hid_generic usbhid hid ahci
      libahci libata crc32c_intel xhci_pci xhci_hcd scsi_mod<br>
      05.01.20 16:49    CPU    0 PID: 896 Comm: Xorg Tainted: G WC OE
      5.5.0-1-MANJARO #1<br>
      05.01.20 16:49    Hardware name    System manufacturer System
      Product Name/PRIME X470-PRO, BIOS 5406 11/13/2019<br>
      05.01.20 16:49    RIP    0010:generic_reg_wait.cold+0x25/0x2c
      [amdgpu]<br>
      05.01.20 16:49    Code    e9 b4 13 fe ff 44 8b 44 24 24 48 8b 4c
      24 18 44 89 fa 89 ee 48 c7 c7 98 18 85 c1 e8 28 51 59 f8 83 7b 20
      01 0f 84 7a 21 fe ff &lt;0f&gt; 0b e9 73 21 fe ff e8 24 9f e6 ff
      48 c7 c7 00 20 91 c1 e8 88 13<br>
      05.01.20 16:49    RSP    0018:ffff9ce3c11b7638 EFLAGS: 00010297<br>
      05.01.20 16:49    RAX    000000000000004a RBX: ffff8eea36150980
      RCX: 0000000000000000<br>
      05.01.20 16:49    RDX    0000000000000000 RSI: ffff8eea3e819ac8
      RDI: 00000000ffffffff<br>
      05.01.20 16:49    RBP    0000000000000001 R08: 0000000000000549
      R09: 0000000000000001<br>
      05.01.20 16:49    R10    0000000000000000 R11: 0000000000000001
      R12: 0000000000004790<br>
      05.01.20 16:49    R13    00000000000186a1 R14: 0000000000000001
      R15: 00000000000186a0<br>
      05.01.20 16:49    FS    00007fd6845b3dc0(0000)
      GS:ffff8eea3e800000(0000) knlGS:0000000000000000<br>
      05.01.20 16:49    CS    0010 DS: 0000 ES: 0000 CR0:
      0000000080050033<br>
      05.01.20 16:49    CR2    00007f0aec00b128 CR3: 00000007e4290000
      CR4: 00000000003406f0<br>
      05.01.20 16:49    Call Trace    <br>
      05.01.20 16:49        mpc2_assert_idle_mpcc+0xb9/0xe0 [amdgpu]<br>
      05.01.20 16:49        dcn20_program_front_end_for_ctx+0x986/0xd50
      [amdgpu]<br>
      05.01.20 16:49        dc_commit_state+0x258/0x5e0 [amdgpu]<br>
      05.01.20 16:49        amdgpu_dm_atomic_commit_tail+0xfa6/0x1fc0
      [amdgpu]<br>
      05.01.20 16:49        commit_tail+0x94/0x130 [drm_kms_helper]<br>
      05.01.20 16:49        drm_atomic_helper_commit+0x113/0x140
      [drm_kms_helper]<br>
      05.01.20 16:49        drm_atomic_helper_set_config+0x70/0xb0
      [drm_kms_helper]<br>
      05.01.20 16:49        drm_mode_setcrtc+0x1f0/0x730 [drm]<br>
      05.01.20 16:49        ? drm_mode_getcrtc+0x180/0x180 [drm]<br>
      05.01.20 16:49        drm_ioctl_kernel+0xb2/0x100 [drm]<br>
      05.01.20 16:49        drm_ioctl+0x209/0x360 [drm]<br>
      05.01.20 16:49        ? drm_mode_getcrtc+0x180/0x180 [drm]<br>
      05.01.20 16:49        amdgpu_drm_ioctl+0x49/0x80 [amdgpu]<br>
      05.01.20 16:49        do_vfs_ioctl+0x4b7/0x730<br>
      05.01.20 16:49        ksys_ioctl+0x5e/0x90<br>
      05.01.20 16:49        __x64_sys_ioctl+0x16/0x20<br>
      05.01.20 16:49        do_syscall_64+0x4e/0x150<br>
      05.01.20 16:49        entry_SYSCALL_64_after_hwframe+0x44/0xa9<br>
      05.01.20 16:49    RIP    0033:0x7fd6853f925b<br>
      05.01.20 16:49    Code    0f 1e fa 48 8b 05 25 9c 0c 00 64 c7 00
      26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa
      b8 10 00 00 00 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 8b 0d
      f5 9b 0c 00 f7 d8 64 89 01 48<br>
      05.01.20 16:49    RSP    002b:00007ffe8ce09888 EFLAGS: 00000246
      ORIG_RAX: 0000000000000010<br>
      05.01.20 16:49    RAX    ffffffffffffffda RBX: 00007ffe8ce098c0
      RCX: 00007fd6853f925b<br>
      05.01.20 16:49    RDX    00007ffe8ce098c0 RSI: 00000000c06864a2
      RDI: 000000000000000d<br>
      05.01.20 16:49    RBP    00000000c06864a2 R08: 0000000000000000
      R09: 000055fc870bdab0<br>
      05.01.20 16:49    R10    0000000000000000 R11: 0000000000000246
      R12: 0000000000000000<br>
      05.01.20 16:49    R13    000000000000000d R14: 000055fc8638b990
      R15: 0000000000000000<br>
      05.01.20 16:49        ---[ end trace 56076c7a9bdc6a37 ]---</p>
    <p><br>
    </p>
    <p>3rd report:<br>
    </p>
    <p>05.01.20 16:49        [drm] REG_WAIT timeout 1us * 200 tries -
      hubp2_set_blank line:928<br>
      05.01.20 16:49        ------------[ cut here ]------------<br>
      05.01.20 16:49    WARNING    CPU: 0 PID: 896 at
      drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:332
      generic_reg_wait.cold+0x25/0x2c [amdgpu]<br>
      05.01.20 16:49    Modules linked in    fuse md4 cmac nls_utf8 cifs
      libarc4 dns_resolver fscache libdes squashfs loop amdgpu
      snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
      snd_hda_codec_hdmi snd_hda_intel r8188eu(C) snd_intel_dspcfg
      snd_hda_codec snd_usb_audio edac_mce_amd lib80211 kvm_amd
      nls_iso8859_1 snd_usbmidi_lib nls_cp437 snd_hda_core vfat fat
      gpu_sched eeepc_wmi ttm snd_rawmidi snd_seq_device mc kvm
      snd_hwdep asus_wmi irqbypass snd_pcm cfg80211 drm_kms_helper
      battery sparse_keymap snd_timer crct10dif_pclmul wmi_bmof mxm_wmi
      drm rfkill crc32_pclmul xpad ghash_clmulni_intel ccp snd
      ff_memless aesni_intel mousedev input_leds igb joydev crypto_simd
      agpgart sp5100_tco cryptd syscopyarea glue_helper sysfillrect
      pcspkr i2c_algo_bit i2c_piix4 sysimgblt k10temp fb_sys_fops
      rng_core soundcore dca wmi evdev pinctrl_amd mac_hid gpio_amdpt
      acpi_cpufreq uinput vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE)
      crypto_user ip_tables x_tables ext4 crc32c_generic crc16 mbcache
      jbd2 sr_mod cdrom sd_mod uas<br>
      05.01.20 16:49        usb_storage hid_generic usbhid hid ahci
      libahci libata crc32c_intel xhci_pci xhci_hcd scsi_mod<br>
      05.01.20 16:49    CPU    0 PID: 896 Comm: Xorg Tainted: G WC OE
      5.5.0-1-MANJARO #1<br>
      05.01.20 16:49    Hardware name    System manufacturer System
      Product Name/PRIME X470-PRO, BIOS 5406 11/13/2019<br>
      05.01.20 16:49    RIP    0010:generic_reg_wait.cold+0x25/0x2c
      [amdgpu]<br>
      05.01.20 16:49    Code    e9 b4 13 fe ff 44 8b 44 24 24 48 8b 4c
      24 18 44 89 fa 89 ee 48 c7 c7 98 18 85 c1 e8 28 51 59 f8 83 7b 20
      01 0f 84 7a 21 fe ff &lt;0f&gt; 0b e9 73 21 fe ff e8 24 9f e6 ff
      48 c7 c7 00 20 91 c1 e8 88 13<br>
      05.01.20 16:49    RSP    0018:ffff9ce3c11b7628 EFLAGS: 00010297<br>
      05.01.20 16:49    RAX    0000000000000041 RBX: ffff8eea36150980
      RCX: 0000000000000000<br>
      05.01.20 16:49    RDX    0000000000000000 RSI: ffff8eea3e819ac8
      RDI: 00000000ffffffff<br>
      05.01.20 16:49    RBP    0000000000000001 R08: 0000000000000577
      R09: 0000000000000001<br>
      05.01.20 16:49    R10    0000000000000000 R11: 0000000000000001
      R12: 0000000000003d47<br>
      05.01.20 16:49    R13    00000000000000c9 R14: 0000000000000001
      R15: 00000000000000c8<br>
      05.01.20 16:49    FS    00007fd6845b3dc0(0000)
      GS:ffff8eea3e800000(0000) knlGS:0000000000000000<br>
      05.01.20 16:49    CS    0010 DS: 0000 ES: 0000 CR0:
      0000000080050033<br>
      05.01.20 16:49    CR2    00007f809009bfe0 CR3: 00000007e4290000
      CR4: 00000000003406f0<br>
      05.01.20 16:49    Call Trace    <br>
      05.01.20 16:49        hubp2_set_blank+0xc4/0xd0 [amdgpu]<br>
      05.01.20 16:49        dcn10_wait_for_mpcc_disconnect+0xc0/0x100
      [amdgpu]<br>
      05.01.20 16:49        dcn20_plane_atomic_disable+0x35/0x150
      [amdgpu]<br>
      05.01.20 16:49        dcn20_disable_plane+0x24/0x40 [amdgpu]<br>
      05.01.20 16:49        dcn20_program_front_end_for_ctx+0x3d5/0xd50
      [amdgpu]<br>
      05.01.20 16:49        dc_commit_state+0x151/0x5e0 [amdgpu]<br>
      05.01.20 16:49        amdgpu_dm_atomic_commit_tail+0xfa6/0x1fc0
      [amdgpu]<br>
      05.01.20 16:49        ? dm_read_reg_func+0x1f/0x90 [amdgpu]<br>
      05.01.20 16:49        ? dm_read_reg_func+0x1f/0x90 [amdgpu]<br>
      05.01.20 16:49        ? dm_read_reg_func+0x1f/0x90 [amdgpu]<br>
      05.01.20 16:49        ? dm_read_reg_func+0x1f/0x90 [amdgpu]<br>
      05.01.20 16:49        commit_tail+0x94/0x130 [drm_kms_helper]<br>
      05.01.20 16:49        drm_atomic_helper_commit+0x113/0x140
      [drm_kms_helper]<br>
      05.01.20 16:49        drm_atomic_connector_commit_dpms+0xd7/0x100
      [drm]<br>
      05.01.20 16:49        drm_mode_obj_set_property_ioctl+0x169/0x2e0
      [drm]<br>
      05.01.20 16:49        ? drm_connector_set_obj_prop+0x90/0x90 [drm]<br>
      05.01.20 16:49        drm_connector_property_set_ioctl+0x41/0x60
      [drm]<br>
      05.01.20 16:49        drm_ioctl_kernel+0xb2/0x100 [drm]<br>
      05.01.20 16:49        drm_ioctl+0x209/0x360 [drm]<br>
      05.01.20 16:49        ? drm_connector_set_obj_prop+0x90/0x90 [drm]<br>
      05.01.20 16:49        amdgpu_drm_ioctl+0x49/0x80 [amdgpu]<br>
      05.01.20 16:49        do_vfs_ioctl+0x4b7/0x730<br>
      05.01.20 16:49        ? ep_item_poll.isra.0+0x3f/0xb0<br>
      05.01.20 16:49        ksys_ioctl+0x5e/0x90<br>
      05.01.20 16:49        __x64_sys_ioctl+0x16/0x20<br>
      05.01.20 16:49        do_syscall_64+0x4e/0x150<br>
      05.01.20 16:49        entry_SYSCALL_64_after_hwframe+0x44/0xa9<br>
      05.01.20 16:49    RIP    0033:0x7fd6853f925b<br>
      05.01.20 16:49    Code    0f 1e fa 48 8b 05 25 9c 0c 00 64 c7 00
      26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa
      b8 10 00 00 00 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 8b 0d
      f5 9b 0c 00 f7 d8 64 89 01 48<br>
      05.01.20 16:49    RSP    002b:00007ffe8ce09cc8 EFLAGS: 00000246
      ORIG_RAX: 0000000000000010<br>
      05.01.20 16:49    RAX    ffffffffffffffda RBX: 00007ffe8ce09d00
      RCX: 00007fd6853f925b<br>
      05.01.20 16:49    RDX    00007ffe8ce09d00 RSI: 00000000c01064ab
      RDI: 000000000000000d<br>
      05.01.20 16:49    RBP    00000000c01064ab R08: 0000000000000000
      R09: 000055fc86388510<br>
      05.01.20 16:49    R10    0000000000000000 R11: 0000000000000246
      R12: 000055fc86050c80<br>
      05.01.20 16:49    R13    000000000000000d R14: 000055fc87242480
      R15: 0000000000000000<br>
      05.01.20 16:49        ---[ end trace 56076c7a9bdc6a38 ]---</p>
    <p><br>
    </p>
    <p>4th report<br>
    </p>
    <p>05.01.20 16:50        [drm] REG_WAIT timeout 1us * 100000 tries -
      mpc2_assert_idle_mpcc line:440<br>
      05.01.20 16:50        ------------[ cut here ]------------<br>
      05.01.20 16:50    WARNING    CPU: 7 PID: 896 at
      drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:332
      generic_reg_wait.cold+0x25/0x2c [amdgpu]<br>
      05.01.20 16:50    Modules linked in    fuse md4 cmac nls_utf8 cifs
      libarc4 dns_resolver fscache libdes squashfs loop amdgpu
      snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
      snd_hda_codec_hdmi snd_hda_intel r8188eu(C) snd_intel_dspcfg
      snd_hda_codec snd_usb_audio edac_mce_amd lib80211 kvm_amd
      nls_iso8859_1 snd_usbmidi_lib nls_cp437 snd_hda_core vfat fat
      gpu_sched eeepc_wmi ttm snd_rawmidi snd_seq_device mc kvm
      snd_hwdep asus_wmi irqbypass snd_pcm cfg80211 drm_kms_helper
      battery sparse_keymap snd_timer crct10dif_pclmul wmi_bmof mxm_wmi
      drm rfkill crc32_pclmul xpad ghash_clmulni_intel ccp snd
      ff_memless aesni_intel mousedev input_leds igb joydev crypto_simd
      agpgart sp5100_tco cryptd syscopyarea glue_helper sysfillrect
      pcspkr i2c_algo_bit i2c_piix4 sysimgblt k10temp fb_sys_fops
      rng_core soundcore dca wmi evdev pinctrl_amd mac_hid gpio_amdpt
      acpi_cpufreq uinput vboxnetflt(OE) vboxnetadp(OE) vboxdrv(OE)
      crypto_user ip_tables x_tables ext4 crc32c_generic crc16 mbcache
      jbd2 sr_mod cdrom sd_mod uas<br>
      05.01.20 16:50        usb_storage hid_generic usbhid hid ahci
      libahci libata crc32c_intel xhci_pci xhci_hcd scsi_mod<br>
      05.01.20 16:50    CPU    7 PID: 896 Comm: Xorg Tainted: G WC OE
      5.5.0-1-MANJARO #1<br>
      05.01.20 16:50    Hardware name    System manufacturer System
      Product Name/PRIME X470-PRO, BIOS 5406 11/13/2019<br>
      05.01.20 16:50    RIP    0010:generic_reg_wait.cold+0x25/0x2c
      [amdgpu]<br>
      05.01.20 16:50    Code    e9 b4 13 fe ff 44 8b 44 24 24 48 8b 4c
      24 18 44 89 fa 89 ee 48 c7 c7 98 18 85 c1 e8 28 51 59 f8 83 7b 20
      01 0f 84 7a 21 fe ff &lt;0f&gt; 0b e9 73 21 fe ff e8 24 9f e6 ff
      48 c7 c7 00 20 91 c1 e8 88 13<br>
      05.01.20 16:50    RSP    0018:ffff9ce3c11b7638 EFLAGS: 00010297<br>
      05.01.20 16:50    RAX    000000000000004a RBX: ffff8eea36150980
      RCX: 0000000000000000<br>
      05.01.20 16:50    RDX    0000000000000000 RSI: ffff8eea3e9d9ac8
      RDI: 00000000ffffffff<br>
      05.01.20 16:50    RBP    0000000000000001 R08: 00000000000005ae
      R09: 0000000000000001<br>
      05.01.20 16:50    R10    0000000000000000 R11: 0000000000000001
      R12: 0000000000004790<br>
      05.01.20 16:50    R13    00000000000186a1 R14: 0000000000000001
      R15: 00000000000186a0<br>
      05.01.20 16:50    FS    00007fd6845b3dc0(0000)
      GS:ffff8eea3e9c0000(0000) knlGS:0000000000000000<br>
      05.01.20 16:50    CS    0010 DS: 0000 ES: 0000 CR0:
      0000000080050033<br>
      05.01.20 16:50    CR2    000055fc86f47000 CR3: 00000007e4290000
      CR4: 00000000003406e0<br>
      05.01.20 16:50    Call Trace    <br>
      05.01.20 16:50        mpc2_assert_idle_mpcc+0xb9/0xe0 [amdgpu]<br>
      05.01.20 16:50        dcn20_program_front_end_for_ctx+0x986/0xd50
      [amdgpu]<br>
      05.01.20 16:50        dc_commit_state+0x258/0x5e0 [amdgpu]<br>
      05.01.20 16:50        amdgpu_dm_atomic_commit_tail+0xfa6/0x1fc0
      [amdgpu]<br>
      05.01.20 16:50        commit_tail+0x94/0x130 [drm_kms_helper]<br>
      05.01.20 16:50        drm_atomic_helper_commit+0x113/0x140
      [drm_kms_helper]<br>
      05.01.20 16:50        drm_atomic_helper_set_config+0x70/0xb0
      [drm_kms_helper]<br>
      05.01.20 16:50        drm_mode_setcrtc+0x1f0/0x730 [drm]<br>
      05.01.20 16:50        ? drm_mode_getcrtc+0x180/0x180 [drm]<br>
      05.01.20 16:50        drm_ioctl_kernel+0xb2/0x100 [drm]<br>
      05.01.20 16:50        drm_ioctl+0x209/0x360 [drm]<br>
      05.01.20 16:50        ? drm_mode_getcrtc+0x180/0x180 [drm]<br>
      05.01.20 16:50        amdgpu_drm_ioctl+0x49/0x80 [amdgpu]<br>
      05.01.20 16:50        do_vfs_ioctl+0x4b7/0x730<br>
      05.01.20 16:50        ksys_ioctl+0x5e/0x90<br>
      05.01.20 16:50        __x64_sys_ioctl+0x16/0x20<br>
      05.01.20 16:50        do_syscall_64+0x4e/0x150<br>
      05.01.20 16:50        entry_SYSCALL_64_after_hwframe+0x44/0xa9<br>
      05.01.20 16:50    RIP    0033:0x7fd6853f925b<br>
      05.01.20 16:50    Code    0f 1e fa 48 8b 05 25 9c 0c 00 64 c7 00
      26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa
      b8 10 00 00 00 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 8b 0d
      f5 9b 0c 00 f7 d8 64 89 01 48<br>
      05.01.20 16:50    RSP    002b:00007ffe8ce09888 EFLAGS: 00000246
      ORIG_RAX: 0000000000000010<br>
      05.01.20 16:50    RAX    ffffffffffffffda RBX: 00007ffe8ce098c0
      RCX: 00007fd6853f925b<br>
      05.01.20 16:50    RDX    00007ffe8ce098c0 RSI: 00000000c06864a2
      RDI: 000000000000000d<br>
      05.01.20 16:50    RBP    00000000c06864a2 R08: 0000000000000000
      R09: 000055fc876aae00<br>
      05.01.20 16:50    R10    0000000000000000 R11: 0000000000000246
      R12: 0000000000000000<br>
      05.01.20 16:50    R13    000000000000000d R14: 000055fc8638b990
      R15: 0000000000000000<br>
      05.01.20 16:50        ---[ end trace 56076c7a9bdc6a39 ]---<br>
      <br>
    </p>
  </body>
</html>

--------------429564FB4E16460A5C9C7E34--

--===============0178739219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0178739219==--
