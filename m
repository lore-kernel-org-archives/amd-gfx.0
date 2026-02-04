Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB16AEC1EBE
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 14:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45AA410E8BB;
	Thu,  5 Feb 2026 14:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GAsN5Yn4";
	dkim-atps=neutral
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE1710E0B7
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 14:29:55 +0000 (UTC)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-649c5d70420so549842d50.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Feb 2026 06:29:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770215395; cv=none;
 d=google.com; s=arc-20240605;
 b=fIGv+TYHo1yxkB8FWXLTLX7mka9g8kdQc4AvZrOLIcvAC8Kmewez7qMMW/1icdvmn7
 mxX+JGQdThdhnS95CYchkxy93BbPUCQ/PKQ2iANj2aCDvcUBxn3V4prxfVBdtJ9Eh/wW
 vguJtrsFMys1+dldc3IJOpRiu7d4RRTgL4IhSvadGk/swFVW+0FF+/rbSiX8DyqXdMF8
 skZGaXOwfPo59VJto7m2+tyRfsi2KlubT4WsJErD9IfTg/ORsQYKyTmhVv2DQYgigeSi
 OqXiTWrRLgjL294QmYwQARLRQo85wQ6F4zXm+rHo6eIQZvij26z5I9770DNqoX8IUeIi
 cO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=kk06aM7UjN6dVRnILtCzL/DY6gf0Tj55O1fQn/iOlAQ=;
 fh=WQL8IN3PgLIv0LUd+ORQyTi2mcbu0lSc0fA956UhpQI=;
 b=Ob0j3aRixuCjmIAIhFlCKFk7YUV0VFji3Zh7roC4d3abpkvVMFEjS06NUgshbeVfAq
 8KMmcBucqSUhuysatGFXtUWNRi/6TNzA82gYdjY+y8xkeWg8f1GAg6w8nZTjQW1hMnnM
 3mpxbZLgWtn+U+76h1gc1SW+2FIVBOnpsnMwY8x8W+xi60wdA/InNdVZY+F9tQJ9tW6Z
 i99IHXD6NxiiRFrgB/VxZdBh8Uc1mBiekgCEYWJS2/CX+ywRJ1HGBO8uq6cFxmykjSnX
 u07eV0VztrUcynOeyUqQ8QJu0GzFTk7MFyfyFPW0tbHLqArCC5nCO1iFeXm0+q8klDky
 2ZZg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770215395; x=1770820195; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kk06aM7UjN6dVRnILtCzL/DY6gf0Tj55O1fQn/iOlAQ=;
 b=GAsN5Yn4wox5Oa/AY2ZRHviWfbEX+ObXwRFwiUqCULm84ZYCrudLcNX3akeenyNMEm
 aDoOUD3GBnA/irBHMmTmKuuBlWIQ4vf1W+1Hr+xAec7YYaRoGxgyoXHB1/trlp+ONxAm
 wY6oNj7frTI6cD0UcjH9gcw9/0HAIb6hanJsNoFXH7MypwNyryMw8CRvlRrFy1bvJ6jm
 GsO/GJ20J6w2SgrW5QaSEEUWp/JBkjpM7z23AeC/XG6/9lNjJ7IPnqLdoOSS7h279mTg
 F3aoctzR9Bd9B2RYe01kmvS4XmJp6p4DvzYoYZGOY/CsG/vqAKm4ryMTOCfHvekaBzsA
 KdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770215395; x=1770820195;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kk06aM7UjN6dVRnILtCzL/DY6gf0Tj55O1fQn/iOlAQ=;
 b=USYmFayXyPQ3FO+0CLDG5slMm6VfE6tv9wgQzbSWdwHeO/JJAewotepf8aAIi8fnEZ
 iuoW9kq9CMWFo4WhWhEYmvHC2oJjb/VRfkn3/tVGoyOP0sCIS38BAUOp1wmq75wiIbcf
 hF0vp7uXr08aERP/uKfvLqzbU2vSXBa0a1uXCCbmkCFER4bYVaMKBC9rFUzNW4mGusOi
 BCgcTLvBBq1X5RA9vvc7EAw3aRJaoUB422fgibm/h0oeEEwM73PoaxkTHsmTNBl2rmsq
 1CkeRBveVqV70gJ7lq8cVVipfO3VZkbU+Ujae1cd335v0UO7KW9E5bukS+2vqRXb3k3K
 hnhA==
X-Gm-Message-State: AOJu0Yw2UwODc7H9lppMHV3Qr92xO+B7x5uW5KmS1Uyf8xvNS5Qqi6US
 Y0MOt+UO2upUctD6stEjITMijmSDIbu8n5oTssH206e5M+h/JAKpPK+/7E/whSr0EuypTRybFu1
 Fcq0O7SkxTOT91oup2sQjToxKDKGv2Hq9YFlytvc=
X-Gm-Gg: AZuq6aLYMUr+GKX+EX3Yqh2Fu3MflKQQdR+pG6DHoAMTm0n5bl+B1xQmVX//5yYrrkF
 NX0DDUeJNf+fD/e0ofNfplVp3vbyO4vYpqlapHrh85BeWW2E/Ys0QWSbSogmJJwcAOYAxnkC/0p
 wwMqX4v+PTaI1T4We/KAtlZy44uQTl8pegwUDV9wJDmmOBf+BZXaBmyKos8nvFIA508NeZ0KDnJ
 Cbrc87gyBHGvf2UqAbn/EtImwBNZLzKVcrdpJkBHm8/MQRveppHshtRKD8z37wCdJLMQljfJ4aU
 iVazbH4vTeQ/262PG/cdlSduoYY=
X-Received: by 2002:a05:690e:b8b:b0:649:b31e:8f5a with SMTP id
 956f58d0204a3-649db4bd38amr2284166d50.8.1770215393721; Wed, 04 Feb 2026
 06:29:53 -0800 (PST)
MIME-Version: 1.0
From: Tom Psyborg <pozega.tomislav@gmail.com>
Date: Wed, 4 Feb 2026 15:29:38 +0100
X-Gm-Features: AZwV_QjRcl1V67_vclHO4IZ73C_R3MlCzWoHyy6z1UiAfMtUh2MY5nrlgscgPaE
Message-ID: <CAKR_QV+0isyXPqeLateywZE970=UG_vnqXOfGn+Z9dPwv-hhPQ@mail.gmail.com>
Subject: UVD not responding, kiq_0.2.1.0 test failed on suspend
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="000000000000b80359064a006329"
X-Mailman-Approved-At: Thu, 05 Feb 2026 14:01:18 +0000
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

--000000000000b80359064a006329
Content-Type: text/plain; charset="UTF-8"

Hi

I try live boot of ubuntu 26.04 snapshot 3 (6.18.0-9) on dell inspiron 5576
with RX460 dGPU, everything seems ok, until i try to put system to sleep:
(sleep/suspend worked fine on ubuntu 22.04 last time i checked and it works
fine in windows)

[  593.187045] PM: suspend entry (deep)
[  593.187143] Filesystems sync: 0.000 seconds
[  593.191490] Freezing user space processes
[  593.193435] Freezing user space processes completed (elapsed 0.001
seconds)
[  593.193446] OOM killer disabled.
[  593.193447] Freezing remaining freezable tasks
[  593.194764] Freezing remaining freezable tasks completed (elapsed 0.001
seconds)
[  593.194816] printk: Suspending console(s) (use no_console_suspend to
debug)
[  593.323573] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[  593.423009] ata1.00: Entering standby power mode
[  593.553102] [drm] PCIE GART of 256M enabled (table at
0x000000F4FFF80000).
[  593.623444] psmouse serio1: Failed to disable mouse on isa0060/serio1
[  594.733234] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  595.754613] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  596.775980] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  597.797336] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  598.818700] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  599.840060] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  600.861418] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  601.882800] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  602.904165] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  603.925523] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
trying to reset the VCPU!!!
[  603.946463] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding,
giving up!!!
[  603.947393] amdgpu 0000:03:00.0: amdgpu: set_powergating_state of IP
block <uvd_v6_0> failed -1
[  604.217843] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]]
*ERROR* ring uvd test failed (-110)
[  604.218768] amdgpu 0000:03:00.0: amdgpu: resume of IP block <uvd_v6_0>
failed -110
[  604.218773] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed
(-110).
[  604.219420] ------------[ cut here ]------------
[  604.219425] WARNING: CPU: 0 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.220350] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.220426]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.220462] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
      O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.220467] Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE
[  604.220468] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.220470] Workqueue: async async_run_entry_fn
[  604.220476] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.221397] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.221400] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[  604.221403] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX:
0000000000000000
[  604.221404] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.221405] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09:
0000000000000000
[  604.221406] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.221407] R13: 0000000000000000 R14: 0000000000000002 R15:
0000000000000000
[  604.221409] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000)
knlGS:0000000000000000
[  604.221410] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.221411] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.221413] Call Trace:
[  604.221415]  <TASK>
[  604.221420]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[  604.222316]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[  604.223208]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[  604.224094]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.224979]  pci_pm_suspend+0x85/0x1b0
[  604.224986]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.224989]  dpm_run_callback+0x5f/0x160
[  604.224993]  device_suspend+0x1e4/0x4e0
[  604.224996]  async_suspend+0x21/0x40
[  604.224998]  async_run_entry_fn+0x33/0x130
[  604.225001]  process_one_work+0x18e/0x370
[  604.225005]  worker_thread+0x317/0x450
[  604.225007]  ? __pfx_worker_thread+0x10/0x10
[  604.225009]  kthread+0x10b/0x220
[  604.225012]  ? recalc_sigpending+0x76/0xb0
[  604.225014]  ? __pfx_kthread+0x10/0x10
[  604.225017]  ret_from_fork+0x134/0x150
[  604.225019]  ? __pfx_kthread+0x10/0x10
[  604.225022]  ret_from_fork_asm+0x1a/0x30
[  604.225026]  </TASK>
[  604.225027] ---[ end trace 0000000000000000 ]---
[  604.225086] ------------[ cut here ]------------
[  604.225087] WARNING: CPU: 0 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.226002] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.226061]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.226094] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.226098] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.226099] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.226101] Workqueue: async async_run_entry_fn
[  604.226106] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.227029] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.227031] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[  604.227034] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX:
0000000000000000
[  604.227035] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.227036] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09:
0000000000000000
[  604.227037] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.227038] R13: 0000000000000002 R14: 0000000000000002 R15:
0000000000000000
[  604.227039] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000)
knlGS:0000000000000000
[  604.227041] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.227042] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.227043] Call Trace:
[  604.227044]  <TASK>
[  604.227048]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[  604.227939]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[  604.228843]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[  604.229731]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.230619]  pci_pm_suspend+0x85/0x1b0
[  604.230624]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.230627]  dpm_run_callback+0x5f/0x160
[  604.230631]  device_suspend+0x1e4/0x4e0
[  604.230634]  async_suspend+0x21/0x40
[  604.230636]  async_run_entry_fn+0x33/0x130
[  604.230639]  process_one_work+0x18e/0x370
[  604.230642]  worker_thread+0x317/0x450
[  604.230644]  ? __pfx_worker_thread+0x10/0x10
[  604.230646]  kthread+0x10b/0x220
[  604.230649]  ? recalc_sigpending+0x76/0xb0
[  604.230651]  ? __pfx_kthread+0x10/0x10
[  604.230654]  ret_from_fork+0x134/0x150
[  604.230656]  ? __pfx_kthread+0x10/0x10
[  604.230658]  ret_from_fork_asm+0x1a/0x30
[  604.230662]  </TASK>
[  604.230663] ---[ end trace 0000000000000000 ]---
[  604.230720] ------------[ cut here ]------------
[  604.230721] WARNING: CPU: 0 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.231654] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.231714]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.231746] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.231751] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.231752] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.231753] Workqueue: async async_run_entry_fn
[  604.231759] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.232678] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.232681] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[  604.232685] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX:
0000000000000000
[  604.232686] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.232687] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09:
0000000000000000
[  604.232689] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.232690] R13: 0000000000000002 R14: 0000000000000002 R15:
0000000000000000
[  604.232691] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000)
knlGS:0000000000000000
[  604.232693] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.232695] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.232696] Call Trace:
[  604.232698]  <TASK>
[  604.232702]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[  604.233601]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[  604.234506]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[  604.235404]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.236275]  pci_pm_suspend+0x85/0x1b0
[  604.236281]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.236283]  dpm_run_callback+0x5f/0x160
[  604.236287]  device_suspend+0x1e4/0x4e0
[  604.236290]  async_suspend+0x21/0x40
[  604.236292]  async_run_entry_fn+0x33/0x130
[  604.236295]  process_one_work+0x18e/0x370
[  604.236299]  worker_thread+0x317/0x450
[  604.236301]  ? __pfx_worker_thread+0x10/0x10
[  604.236302]  kthread+0x10b/0x220
[  604.236305]  ? recalc_sigpending+0x76/0xb0
[  604.236307]  ? __pfx_kthread+0x10/0x10
[  604.236310]  ret_from_fork+0x134/0x150
[  604.236312]  ? __pfx_kthread+0x10/0x10
[  604.236315]  ret_from_fork_asm+0x1a/0x30
[  604.236319]  </TASK>
[  604.236320] ---[ end trace 0000000000000000 ]---
[  604.236389] ------------[ cut here ]------------
[  604.236391] WARNING: CPU: 0 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.237301] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.237370]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.237404] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.237408] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.237409] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.237410] Workqueue: async async_run_entry_fn
[  604.237416] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.238328] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.238330] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[  604.238332] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX:
0000000000000000
[  604.238333] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.238334] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09:
0000000000000000
[  604.238335] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.238336] R13: 0000000000000002 R14: 0000000000000002 R15:
0000000000000000
[  604.238338] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000)
knlGS:0000000000000000
[  604.238339] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.238340] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.238342] Call Trace:
[  604.238343]  <TASK>
[  604.238347]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[  604.239247]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[  604.240137]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[  604.241032]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.241934]  pci_pm_suspend+0x85/0x1b0
[  604.241940]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.241942]  dpm_run_callback+0x5f/0x160
[  604.241946]  device_suspend+0x1e4/0x4e0
[  604.241949]  async_suspend+0x21/0x40
[  604.241951]  async_run_entry_fn+0x33/0x130
[  604.241954]  process_one_work+0x18e/0x370
[  604.241958]  worker_thread+0x317/0x450
[  604.241960]  ? __pfx_worker_thread+0x10/0x10
[  604.241961]  kthread+0x10b/0x220
[  604.241964]  ? recalc_sigpending+0x76/0xb0
[  604.241966]  ? __pfx_kthread+0x10/0x10
[  604.241969]  ret_from_fork+0x134/0x150
[  604.241972]  ? __pfx_kthread+0x10/0x10
[  604.241974]  ret_from_fork_asm+0x1a/0x30
[  604.241978]  </TASK>
[  604.241979] ---[ end trace 0000000000000000 ]---
[  604.242037] ------------[ cut here ]------------
[  604.242038] WARNING: CPU: 0 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.242954] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.243013]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.243046] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.243050] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.243051] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.243052] Workqueue: async async_run_entry_fn
[  604.243058] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.243986] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.243988] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[  604.243990] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX:
0000000000000000
[  604.243992] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.243993] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09:
0000000000000000
[  604.243994] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.243995] R13: 0000000000000002 R14: 0000000000000002 R15:
0000000000000000
[  604.243996] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000)
knlGS:0000000000000000
[  604.243997] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.243998] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.244000] Call Trace:
[  604.244001]  <TASK>
[  604.244005]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[  604.244899]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[  604.245788]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[  604.246685]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.247577]  pci_pm_suspend+0x85/0x1b0
[  604.247582]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.247585]  dpm_run_callback+0x5f/0x160
[  604.247589]  device_suspend+0x1e4/0x4e0
[  604.247592]  async_suspend+0x21/0x40
[  604.247594]  async_run_entry_fn+0x33/0x130
[  604.247598]  process_one_work+0x18e/0x370
[  604.247601]  worker_thread+0x317/0x450
[  604.247603]  ? __pfx_worker_thread+0x10/0x10
[  604.247604]  kthread+0x10b/0x220
[  604.247607]  ? recalc_sigpending+0x76/0xb0
[  604.247610]  ? __pfx_kthread+0x10/0x10
[  604.247612]  ret_from_fork+0x134/0x150
[  604.247615]  ? __pfx_kthread+0x10/0x10
[  604.247617]  ret_from_fork_asm+0x1a/0x30
[  604.247621]  </TASK>
[  604.247622] ---[ end trace 0000000000000000 ]---
[  604.247680] ------------[ cut here ]------------
[  604.247681] WARNING: CPU: 0 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.248598] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.248658]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.248691] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.248695] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.248696] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.248697] Workqueue: async async_run_entry_fn
[  604.248702] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.249627] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.249629] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[  604.249632] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX:
0000000000000000
[  604.249633] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.249634] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09:
0000000000000000
[  604.249635] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.249636] R13: 0000000000000002 R14: 0000000000000002 R15:
0000000000000000
[  604.249638] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000)
knlGS:0000000000000000
[  604.249639] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.249640] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.249642] Call Trace:
[  604.249643]  <TASK>
[  604.249647]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[  604.250538]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[  604.251444]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[  604.252318]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.253208]  pci_pm_suspend+0x85/0x1b0
[  604.253215]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.253218]  dpm_run_callback+0x5f/0x160
[  604.253222]  device_suspend+0x1e4/0x4e0
[  604.253224]  async_suspend+0x21/0x40
[  604.253227]  async_run_entry_fn+0x33/0x130
[  604.253230]  process_one_work+0x18e/0x370
[  604.253233]  worker_thread+0x317/0x450
[  604.253235]  ? __pfx_worker_thread+0x10/0x10
[  604.253237]  kthread+0x10b/0x220
[  604.253240]  ? recalc_sigpending+0x76/0xb0
[  604.253242]  ? __pfx_kthread+0x10/0x10
[  604.253245]  ret_from_fork+0x134/0x150
[  604.253248]  ? __pfx_kthread+0x10/0x10
[  604.253250]  ret_from_fork_asm+0x1a/0x30
[  604.253254]  </TASK>
[  604.253255] ---[ end trace 0000000000000000 ]---
[  604.253313] ------------[ cut here ]------------
[  604.253313] WARNING: CPU: 0 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.254240] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.254299]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.254332] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.254336] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.254337] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.254339] Workqueue: async async_run_entry_fn
[  604.254344] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.255268] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.255271] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[  604.255274] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX:
0000000000000000
[  604.255275] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.255276] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09:
0000000000000000
[  604.255278] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.255279] R13: 0000000000000002 R14: 0000000000000002 R15:
0000000000000000
[  604.255280] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000)
knlGS:0000000000000000
[  604.255281] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.255282] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.255284] Call Trace:
[  604.255285]  <TASK>
[  604.255289]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[  604.256183]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[  604.257090]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[  604.257988]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.258877]  pci_pm_suspend+0x85/0x1b0
[  604.258884]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.258887]  dpm_run_callback+0x5f/0x160
[  604.258891]  device_suspend+0x1e4/0x4e0
[  604.258893]  async_suspend+0x21/0x40
[  604.258895]  async_run_entry_fn+0x33/0x130
[  604.258899]  process_one_work+0x18e/0x370
[  604.258902]  worker_thread+0x317/0x450
[  604.258904]  ? __pfx_worker_thread+0x10/0x10
[  604.258906]  kthread+0x10b/0x220
[  604.258908]  ? recalc_sigpending+0x76/0xb0
[  604.258911]  ? __pfx_kthread+0x10/0x10
[  604.258913]  ret_from_fork+0x134/0x150
[  604.258916]  ? __pfx_kthread+0x10/0x10
[  604.258918]  ret_from_fork_asm+0x1a/0x30
[  604.258922]  </TASK>
[  604.258923] ---[ end trace 0000000000000000 ]---
[  604.258981] ------------[ cut here ]------------
[  604.258982] WARNING: CPU: 0 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.259903] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.259962]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.259995] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.259999] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.259999] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.260001] Workqueue: async async_run_entry_fn
[  604.260006] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.260922] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.260925] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[  604.260928] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX:
0000000000000000
[  604.260929] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.260930] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09:
0000000000000000
[  604.260931] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.260932] R13: 0000000000000002 R14: 0000000000000002 R15:
0000000000000000
[  604.260934] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000)
knlGS:0000000000000000
[  604.260935] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.260936] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.260938] Call Trace:
[  604.260939]  <TASK>
[  604.260943]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[  604.261840]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[  604.262729]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[  604.263628]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.264519]  pci_pm_suspend+0x85/0x1b0
[  604.264525]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.264528]  dpm_run_callback+0x5f/0x160
[  604.264532]  device_suspend+0x1e4/0x4e0
[  604.264535]  async_suspend+0x21/0x40
[  604.264537]  async_run_entry_fn+0x33/0x130
[  604.264541]  process_one_work+0x18e/0x370
[  604.264544]  worker_thread+0x317/0x450
[  604.264546]  ? __pfx_worker_thread+0x10/0x10
[  604.264548]  kthread+0x10b/0x220
[  604.264551]  ? recalc_sigpending+0x76/0xb0
[  604.264553]  ? __pfx_kthread+0x10/0x10
[  604.264556]  ret_from_fork+0x134/0x150
[  604.264558]  ? __pfx_kthread+0x10/0x10
[  604.264561]  ret_from_fork_asm+0x1a/0x30
[  604.264565]  </TASK>
[  604.264566] ---[ end trace 0000000000000000 ]---
[  604.264618] ------------[ cut here ]------------
[  604.264619] WARNING: CPU: 0 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.265538] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.265598]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.265631] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.265635] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.265636] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.265638] Workqueue: async async_run_entry_fn
[  604.265643] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.266566] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.266569] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[  604.266571] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX:
0000000000000000
[  604.266573] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.266574] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09:
0000000000000000
[  604.266575] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.266576] R13: 0000000000000002 R14: 0000000000000002 R15:
0000000000000000
[  604.266577] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000)
knlGS:0000000000000000
[  604.266578] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.266580] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.266581] Call Trace:
[  604.266583]  <TASK>
[  604.266586]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[  604.267483]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[  604.268375]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[  604.269253]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.270146]  pci_pm_suspend+0x85/0x1b0
[  604.270152]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.270155]  dpm_run_callback+0x5f/0x160
[  604.270159]  device_suspend+0x1e4/0x4e0
[  604.270161]  async_suspend+0x21/0x40
[  604.270163]  async_run_entry_fn+0x33/0x130
[  604.270167]  process_one_work+0x18e/0x370
[  604.270170]  worker_thread+0x317/0x450
[  604.270172]  ? __pfx_worker_thread+0x10/0x10
[  604.270173]  kthread+0x10b/0x220
[  604.270176]  ? recalc_sigpending+0x76/0xb0
[  604.270179]  ? __pfx_kthread+0x10/0x10
[  604.270181]  ret_from_fork+0x134/0x150
[  604.270184]  ? __pfx_kthread+0x10/0x10
[  604.270186]  ret_from_fork_asm+0x1a/0x30
[  604.270191]  </TASK>
[  604.270192] ---[ end trace 0000000000000000 ]---
[  604.270242] ------------[ cut here ]------------
[  604.270243] WARNING: CPU: 0 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.271162] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.271222]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.271255] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.271260] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.271260] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.271262] Workqueue: async async_run_entry_fn
[  604.271267] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.272177] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.272180] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[  604.272182] RAX: 0000000000000000 RBX: ffff8edc1d6ad440 RCX:
0000000000000000
[  604.272184] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.272185] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09:
0000000000000000
[  604.272186] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.272187] R13: 0000000000000000 R14: 0000000000000002 R15:
0000000000000000
[  604.272188] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000)
knlGS:0000000000000000
[  604.272189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.272190] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.272192] Call Trace:
[  604.272193]  <TASK>
[  604.272197]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[  604.273091]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[  604.273992]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[  604.274885]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.275774]  pci_pm_suspend+0x85/0x1b0
[  604.275780]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.275782]  dpm_run_callback+0x5f/0x160
[  604.275786]  device_suspend+0x1e4/0x4e0
[  604.275789]  async_suspend+0x21/0x40
[  604.275791]  async_run_entry_fn+0x33/0x130
[  604.275794]  process_one_work+0x18e/0x370
[  604.275798]  worker_thread+0x317/0x450
[  604.275799]  ? __pfx_worker_thread+0x10/0x10
[  604.275801]  kthread+0x10b/0x220
[  604.275804]  ? recalc_sigpending+0x76/0xb0
[  604.275807]  ? __pfx_kthread+0x10/0x10
[  604.275809]  ret_from_fork+0x134/0x150
[  604.275812]  ? __pfx_kthread+0x10/0x10
[  604.275814]  ret_from_fork_asm+0x1a/0x30
[  604.275818]  </TASK>
[  604.275819] ---[ end trace 0000000000000000 ]---
[  604.275870] ------------[ cut here ]------------
[  604.275871] WARNING: CPU: 0 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.276783] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.276844]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.276877] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.276881] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.276882] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.276883] Workqueue: async async_run_entry_fn
[  604.276889] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.277807] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.277810] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[  604.277812] RAX: 0000000000000000 RBX: ffff8edc1d6ad440 RCX:
0000000000000000
[  604.277814] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.277815] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09:
0000000000000000
[  604.277816] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.277817] R13: 0000000000000001 R14: 0000000000000002 R15:
0000000000000000
[  604.277818] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000)
knlGS:0000000000000000
[  604.277819] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.277820] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.277822] Call Trace:
[  604.277823]  <TASK>
[  604.277827]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[  604.278729]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[  604.279624]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[  604.280518]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.281407]  pci_pm_suspend+0x85/0x1b0
[  604.281412]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.281415]  dpm_run_callback+0x5f/0x160
[  604.281419]  device_suspend+0x1e4/0x4e0
[  604.281421]  async_suspend+0x21/0x40
[  604.281423]  async_run_entry_fn+0x33/0x130
[  604.281427]  process_one_work+0x18e/0x370
[  604.281430]  worker_thread+0x317/0x450
[  604.281432]  ? __pfx_worker_thread+0x10/0x10
[  604.281434]  kthread+0x10b/0x220
[  604.281437]  ? recalc_sigpending+0x76/0xb0
[  604.281439]  ? __pfx_kthread+0x10/0x10
[  604.281442]  ret_from_fork+0x134/0x150
[  604.281444]  ? __pfx_kthread+0x10/0x10
[  604.281446]  ret_from_fork_asm+0x1a/0x30
[  604.281451]  </TASK>
[  604.281452] ---[ end trace 0000000000000000 ]---
[  604.281510] ------------[ cut here ]------------
[  604.281511] WARNING: CPU: 0 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.282435] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.282494]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.282527] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.282532] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.282533] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.282534] Workqueue: async async_run_entry_fn
[  604.282540] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.283454] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.283456] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[  604.283459] RAX: 0000000000000000 RBX: ffff8edc1d6adf08 RCX:
0000000000000000
[  604.283460] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.283461] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09:
0000000000000000
[  604.283462] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.283463] R13: 0000000000000000 R14: 0000000000000002 R15:
0000000000000000
[  604.283464] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000)
knlGS:0000000000000000
[  604.283465] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.283467] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.283468] Call Trace:
[  604.283469]  <TASK>
[  604.283473]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[  604.284377]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[  604.285266]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[  604.286158]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.287044]  pci_pm_suspend+0x85/0x1b0
[  604.287051]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.287054]  dpm_run_callback+0x5f/0x160
[  604.287058]  device_suspend+0x1e4/0x4e0
[  604.287061]  async_suspend+0x21/0x40
[  604.287063]  async_run_entry_fn+0x33/0x130
[  604.287066]  process_one_work+0x18e/0x370
[  604.287070]  worker_thread+0x317/0x450
[  604.287071]  ? __pfx_worker_thread+0x10/0x10
[  604.287073]  kthread+0x10b/0x220
[  604.287076]  ? recalc_sigpending+0x76/0xb0
[  604.287079]  ? __pfx_kthread+0x10/0x10
[  604.287081]  ret_from_fork+0x134/0x150
[  604.287084]  ? __pfx_kthread+0x10/0x10
[  604.287086]  ret_from_fork_asm+0x1a/0x30
[  604.287090]  </TASK>
[  604.287091] ---[ end trace 0000000000000000 ]---
[  604.287150] ------------[ cut here ]------------
[  604.287151] WARNING: CPU: 0 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.288065] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.288124]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.288157] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.288161] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.288162] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.288163] Workqueue: async async_run_entry_fn
[  604.288168] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.289092] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.289095] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[  604.289097] RAX: 0000000000000000 RBX: ffff8edc1d6adf08 RCX:
0000000000000000
[  604.289099] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.289100] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09:
0000000000000000
[  604.289101] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.289102] R13: 0000000000000000 R14: 0000000000000002 R15:
0000000000000000
[  604.289104] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000)
knlGS:0000000000000000
[  604.289105] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.289106] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.289108] Call Trace:
[  604.289109]  <TASK>
[  604.289113]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[  604.290008]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[  604.290898]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[  604.291804]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.292693]  pci_pm_suspend+0x85/0x1b0
[  604.292700]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.292703]  dpm_run_callback+0x5f/0x160
[  604.292707]  device_suspend+0x1e4/0x4e0
[  604.292710]  async_suspend+0x21/0x40
[  604.292712]  async_run_entry_fn+0x33/0x130
[  604.292715]  process_one_work+0x18e/0x370
[  604.292718]  worker_thread+0x317/0x450
[  604.292720]  ? __pfx_worker_thread+0x10/0x10
[  604.292722]  kthread+0x10b/0x220
[  604.292725]  ? recalc_sigpending+0x76/0xb0
[  604.292727]  ? __pfx_kthread+0x10/0x10
[  604.292730]  ret_from_fork+0x134/0x150
[  604.292732]  ? __pfx_kthread+0x10/0x10
[  604.292735]  ret_from_fork_asm+0x1a/0x30
[  604.292739]  </TASK>
[  604.292740] ---[ end trace 0000000000000000 ]---
[  604.292797] ------------[ cut here ]------------
[  604.292798] WARNING: CPU: 0 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.293717] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.293776]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.293809] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.293813] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.293814] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.293816] Workqueue: async async_run_entry_fn
[  604.293821] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.294743] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.294746] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[  604.294749] RAX: 0000000000000000 RBX: ffff8edc1d6adf08 RCX:
0000000000000000
[  604.294750] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.294751] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09:
0000000000000000
[  604.294752] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.294753] R13: 0000000000000000 R14: 0000000000000002 R15:
0000000000000000
[  604.294754] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000)
knlGS:0000000000000000
[  604.294756] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.294757] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.294758] Call Trace:
[  604.294759]  <TASK>
[  604.294763]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[  604.295655]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[  604.296554]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[  604.297444]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.298317]  pci_pm_suspend+0x85/0x1b0
[  604.298321]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.298324]  dpm_run_callback+0x5f/0x160
[  604.298328]  device_suspend+0x1e4/0x4e0
[  604.298331]  async_suspend+0x21/0x40
[  604.298333]  async_run_entry_fn+0x33/0x130
[  604.298336]  process_one_work+0x18e/0x370
[  604.298339]  worker_thread+0x317/0x450
[  604.298341]  ? __pfx_worker_thread+0x10/0x10
[  604.298343]  kthread+0x10b/0x220
[  604.298346]  ? recalc_sigpending+0x76/0xb0
[  604.298349]  ? __pfx_kthread+0x10/0x10
[  604.298351]  ret_from_fork+0x134/0x150
[  604.298353]  ? __pfx_kthread+0x10/0x10
[  604.298366]  ret_from_fork_asm+0x1a/0x30
[  604.298372]  </TASK>
[  604.298373] ---[ end trace 0000000000000000 ]---
[  604.298431] ------------[ cut here ]------------
[  604.298432] WARNING: CPU: 0 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.299345] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.299415]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.299448] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.299452] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.299453] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.299454] Workqueue: async async_run_entry_fn
[  604.299459] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.300382] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.300385] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[  604.300388] RAX: 0000000000000000 RBX: ffff8edc1d6af6f8 RCX:
0000000000000000
[  604.300389] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.300390] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09:
0000000000000000
[  604.300392] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.300393] R13: 0000000000000000 R14: 0000000000000002 R15:
0000000000000000
[  604.300394] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000)
knlGS:0000000000000000
[  604.300395] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.300396] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.300398] Call Trace:
[  604.300399]  <TASK>
[  604.300403]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[  604.301294]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[  604.302194]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[  604.303113]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.304092]  pci_pm_suspend+0x85/0x1b0
[  604.304098]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.304100]  dpm_run_callback+0x5f/0x160
[  604.304104]  device_suspend+0x1e4/0x4e0
[  604.304107]  async_suspend+0x21/0x40
[  604.304109]  async_run_entry_fn+0x33/0x130
[  604.304112]  process_one_work+0x18e/0x370
[  604.304116]  worker_thread+0x317/0x450
[  604.304117]  ? __pfx_worker_thread+0x10/0x10
[  604.304119]  kthread+0x10b/0x220
[  604.304122]  ? recalc_sigpending+0x76/0xb0
[  604.304125]  ? __pfx_kthread+0x10/0x10
[  604.304127]  ret_from_fork+0x134/0x150
[  604.304130]  ? __pfx_kthread+0x10/0x10
[  604.304132]  ret_from_fork_asm+0x1a/0x30
[  604.304137]  </TASK>
[  604.304138] ---[ end trace 0000000000000000 ]---
[  604.304195] ------------[ cut here ]------------
[  604.304196] WARNING: CPU: 0 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.305131] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.305192]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.305227] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.305231] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.305232] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.305233] Workqueue: async async_run_entry_fn
[  604.305239] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.306233] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.306236] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[  604.306238] RAX: 0000000000000000 RBX: ffff8edc1d6af6f8 RCX:
0000000000000000
[  604.306240] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.306241] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09:
0000000000000000
[  604.306242] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.306243] R13: 0000000000000000 R14: 0000000000000002 R15:
0000000000000000
[  604.306244] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000)
knlGS:0000000000000000
[  604.306245] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.306246] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.306248] Call Trace:
[  604.306249]  <TASK>
[  604.306253]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[  604.307150]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[  604.308044]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[  604.308934]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.309814]  pci_pm_suspend+0x85/0x1b0
[  604.309819]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.309822]  dpm_run_callback+0x5f/0x160
[  604.309826]  device_suspend+0x1e4/0x4e0
[  604.309828]  async_suspend+0x21/0x40
[  604.309830]  async_run_entry_fn+0x33/0x130
[  604.309834]  process_one_work+0x18e/0x370
[  604.309837]  worker_thread+0x317/0x450
[  604.309839]  ? __pfx_worker_thread+0x10/0x10
[  604.309841]  kthread+0x10b/0x220
[  604.309844]  ? recalc_sigpending+0x76/0xb0
[  604.309846]  ? __pfx_kthread+0x10/0x10
[  604.309848]  ret_from_fork+0x134/0x150
[  604.309851]  ? __pfx_kthread+0x10/0x10
[  604.309853]  ret_from_fork_asm+0x1a/0x30
[  604.309858]  </TASK>
[  604.309859] ---[ end trace 0000000000000000 ]---
[  604.309916] ------------[ cut here ]------------
[  604.309917] WARNING: CPU: 0 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.310833] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.310893]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.310926] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.310930] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.310931] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.310932] Workqueue: async async_run_entry_fn
[  604.310937] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.311850] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.311853] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[  604.311855] RAX: 0000000000000000 RBX: ffff8edc1d6af6f8 RCX:
0000000000000000
[  604.311856] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.311857] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09:
0000000000000000
[  604.311858] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.311859] R13: 0000000000000000 R14: 0000000000000002 R15:
0000000000000000
[  604.311860] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000)
knlGS:0000000000000000
[  604.311862] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.311863] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.311864] Call Trace:
[  604.311866]  <TASK>
[  604.311869]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[  604.312766]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[  604.313662]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[  604.314562]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.315452]  pci_pm_suspend+0x85/0x1b0
[  604.315457]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.315460]  dpm_run_callback+0x5f/0x160
[  604.315464]  device_suspend+0x1e4/0x4e0
[  604.315466]  async_suspend+0x21/0x40
[  604.315468]  async_run_entry_fn+0x33/0x130
[  604.315472]  process_one_work+0x18e/0x370
[  604.315475]  worker_thread+0x317/0x450
[  604.315477]  ? __pfx_worker_thread+0x10/0x10
[  604.315478]  kthread+0x10b/0x220
[  604.315481]  ? recalc_sigpending+0x76/0xb0
[  604.315483]  ? __pfx_kthread+0x10/0x10
[  604.315486]  ret_from_fork+0x134/0x150
[  604.315489]  ? __pfx_kthread+0x10/0x10
[  604.315491]  ret_from_fork_asm+0x1a/0x30
[  604.315495]  </TASK>
[  604.315497] ---[ end trace 0000000000000000 ]---
[  604.330697] ------------[ cut here ]------------
[  604.330700] WARNING: CPU: 1 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.331627] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.331689]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.331725] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.331730] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.331730] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.331732] Workqueue: async async_run_entry_fn
[  604.331739] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.332660] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.332662] RSP: 0018:ffffd4e34aa37c30 EFLAGS: 00010246
[  604.332665] RAX: 0000000000000000 RBX: ffff8edc1d6a5a38 RCX:
0000000000000000
[  604.332666] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.332667] RBP: ffffd4e34aa37c50 R08: 0000000000000000 R09:
0000000000000000
[  604.332668] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.332669] R13: 0000000000000000 R14: ffff8edc1d6d0d88 R15:
ffff8edc1d680000
[  604.332671] FS:  0000000000000000(0000) GS:ffff8edf196f0000(0000)
knlGS:0000000000000000
[  604.332672] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.332673] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.332675] Call Trace:
[  604.332676]  <TASK>
[  604.332681]  gfx_v8_0_hw_fini+0x2a/0x3a0 [amdgpu]
[  604.333595]  gfx_v8_0_suspend+0xe/0x20 [amdgpu]
[  604.334511]  amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]
[  604.335403]  amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdgpu]
[  604.336277]  amdgpu_device_suspend+0x113/0x170 [amdgpu]
[  604.337160]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.338049]  pci_pm_suspend+0x85/0x1b0
[  604.338054]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.338056]  dpm_run_callback+0x5f/0x160
[  604.338060]  device_suspend+0x1e4/0x4e0
[  604.338063]  async_suspend+0x21/0x40
[  604.338065]  async_run_entry_fn+0x33/0x130
[  604.338069]  process_one_work+0x18e/0x370
[  604.338072]  worker_thread+0x317/0x450
[  604.338074]  ? __pfx_worker_thread+0x10/0x10
[  604.338075]  kthread+0x10b/0x220
[  604.338078]  ? recalc_sigpending+0x76/0xb0
[  604.338081]  ? __pfx_kthread+0x10/0x10
[  604.338083]  ret_from_fork+0x134/0x150
[  604.338086]  ? __pfx_kthread+0x10/0x10
[  604.338088]  ret_from_fork_asm+0x1a/0x30
[  604.338092]  </TASK>
[  604.338093] ---[ end trace 0000000000000000 ]---
[  604.338150] ------------[ cut here ]------------
[  604.338151] WARNING: CPU: 1 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.339074] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.339132]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.339165] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.339169] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.339170] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.339171] Workqueue: async async_run_entry_fn
[  604.339176] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.340096] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.340098] RSP: 0018:ffffd4e34aa37c30 EFLAGS: 00010246
[  604.340101] RAX: 0000000000000000 RBX: ffff8edc1d6a5a50 RCX:
0000000000000000
[  604.340102] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.340103] RBP: ffffd4e34aa37c50 R08: 0000000000000000 R09:
0000000000000000
[  604.340104] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.340105] R13: 0000000000000000 R14: ffff8edc1d6d0d88 R15:
ffff8edc1d680000
[  604.340106] FS:  0000000000000000(0000) GS:ffff8edf196f0000(0000)
knlGS:0000000000000000
[  604.340108] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.340109] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.340111] Call Trace:
[  604.340112]  <TASK>
[  604.340115]  gfx_v8_0_hw_fini+0x3b/0x3a0 [amdgpu]
[  604.341033]  gfx_v8_0_suspend+0xe/0x20 [amdgpu]
[  604.341948]  amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]
[  604.342836]  amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdgpu]
[  604.343723]  amdgpu_device_suspend+0x113/0x170 [amdgpu]
[  604.344619]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.345520]  pci_pm_suspend+0x85/0x1b0
[  604.345526]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.345529]  dpm_run_callback+0x5f/0x160
[  604.345533]  device_suspend+0x1e4/0x4e0
[  604.345535]  async_suspend+0x21/0x40
[  604.345538]  async_run_entry_fn+0x33/0x130
[  604.345541]  process_one_work+0x18e/0x370
[  604.345545]  worker_thread+0x317/0x450
[  604.345546]  ? __pfx_worker_thread+0x10/0x10
[  604.345548]  kthread+0x10b/0x220
[  604.345551]  ? recalc_sigpending+0x76/0xb0
[  604.345553]  ? __pfx_kthread+0x10/0x10
[  604.345556]  ret_from_fork+0x134/0x150
[  604.345558]  ? __pfx_kthread+0x10/0x10
[  604.345561]  ret_from_fork_asm+0x1a/0x30
[  604.345565]  </TASK>
[  604.345566] ---[ end trace 0000000000000000 ]---
[  604.345618] ------------[ cut here ]------------
[  604.345619] WARNING: CPU: 1 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.346540] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.346598]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.346631] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.346636] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.346636] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.346638] Workqueue: async async_run_entry_fn
[  604.346643] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.347566] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.347568] RSP: 0018:ffffd4e34aa37c30 EFLAGS: 00010246
[  604.347571] RAX: 0000000000000000 RBX: ffff8edc1d6a5a80 RCX:
0000000000000000
[  604.347572] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.347573] RBP: ffffd4e34aa37c50 R08: 0000000000000000 R09:
0000000000000000
[  604.347574] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.347575] R13: 0000000000000000 R14: ffff8edc1d6d0d88 R15:
ffff8edc1d680000
[  604.347577] FS:  0000000000000000(0000) GS:ffff8edf196f0000(0000)
knlGS:0000000000000000
[  604.347578] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.347579] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.347581] Call Trace:
[  604.347582]  <TASK>
[  604.347586]  gfx_v8_0_hw_fini+0x4c/0x3a0 [amdgpu]
[  604.348508]  gfx_v8_0_suspend+0xe/0x20 [amdgpu]
[  604.349417]  amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]
[  604.350300]  amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdgpu]
[  604.351188]  amdgpu_device_suspend+0x113/0x170 [amdgpu]
[  604.352081]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.352969]  pci_pm_suspend+0x85/0x1b0
[  604.352975]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.352977]  dpm_run_callback+0x5f/0x160
[  604.352981]  device_suspend+0x1e4/0x4e0
[  604.352984]  async_suspend+0x21/0x40
[  604.352986]  async_run_entry_fn+0x33/0x130
[  604.352989]  process_one_work+0x18e/0x370
[  604.352993]  worker_thread+0x317/0x450
[  604.352994]  ? __pfx_worker_thread+0x10/0x10
[  604.352996]  kthread+0x10b/0x220
[  604.352999]  ? recalc_sigpending+0x76/0xb0
[  604.353002]  ? __pfx_kthread+0x10/0x10
[  604.353004]  ret_from_fork+0x134/0x150
[  604.353007]  ? __pfx_kthread+0x10/0x10
[  604.353009]  ret_from_fork_asm+0x1a/0x30
[  604.353013]  </TASK>
[  604.353014] ---[ end trace 0000000000000000 ]---
[  604.353064] ------------[ cut here ]------------
[  604.353064] WARNING: CPU: 1 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  604.353984] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  604.354042]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  604.354074] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  604.354078] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  604.354079] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  604.354081] Workqueue: async async_run_entry_fn
[  604.354086] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  604.355008] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  604.355010] RSP: 0018:ffffd4e34aa37c30 EFLAGS: 00010246
[  604.355013] RAX: 0000000000000000 RBX: ffff8edc1d6a5a98 RCX:
0000000000000000
[  604.355014] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  604.355015] RBP: ffffd4e34aa37c50 R08: 0000000000000000 R09:
0000000000000000
[  604.355016] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  604.355017] R13: 0000000000000000 R14: ffff8edc1d6d0d88 R15:
ffff8edc1d680000
[  604.355018] FS:  0000000000000000(0000) GS:ffff8edf196f0000(0000)
knlGS:0000000000000000
[  604.355019] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  604.355021] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  604.355022] Call Trace:
[  604.355023]  <TASK>
[  604.355027]  gfx_v8_0_hw_fini+0x5d/0x3a0 [amdgpu]
[  604.355934]  gfx_v8_0_suspend+0xe/0x20 [amdgpu]
[  604.356852]  amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]
[  604.357726]  amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdgpu]
[  604.358609]  amdgpu_device_suspend+0x113/0x170 [amdgpu]
[  604.359499]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  604.360391]  pci_pm_suspend+0x85/0x1b0
[  604.360396]  ? __pfx_pci_pm_suspend+0x10/0x10
[  604.360399]  dpm_run_callback+0x5f/0x160
[  604.360403]  device_suspend+0x1e4/0x4e0
[  604.360405]  async_suspend+0x21/0x40
[  604.360408]  async_run_entry_fn+0x33/0x130
[  604.360411]  process_one_work+0x18e/0x370
[  604.360415]  worker_thread+0x317/0x450
[  604.360416]  ? __pfx_worker_thread+0x10/0x10
[  604.360418]  kthread+0x10b/0x220
[  604.360421]  ? recalc_sigpending+0x76/0xb0
[  604.360424]  ? __pfx_kthread+0x10/0x10
[  604.360426]  ret_from_fork+0x134/0x150
[  604.360429]  ? __pfx_kthread+0x10/0x10
[  604.360431]  ret_from_fork_asm+0x1a/0x30
[  604.360435]  </TASK>
[  604.360436] ---[ end trace 0000000000000000 ]---
[  604.600867] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]]
*ERROR* ring kiq_0.2.1.0 test failed (-110)
[  604.601775] [drm:gfx_v8_0_hw_fini [amdgpu]] *ERROR* KCQ disable failed
[  604.837747] amdgpu: cp is busy, skip halt cp
[  605.072838] amdgpu: rlc is busy, skip halt rlc
[  605.073900] ------------[ cut here ]------------
[  605.073901] WARNING: CPU: 1 PID: 6585 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0
[amdgpu]
[  605.074834] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O)
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg
snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi
kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath
irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched
drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore
bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon
sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor
fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[  605.074894]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr
parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch
hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi
realtek ahci libahci uas usb_storage aesni_intel
[  605.074929] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P
   W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
[  605.074934] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN, [O]=OOT_MODULE
[  605.074935] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7
01/29/2018
[  605.074936] Workqueue: async async_run_entry_fn
[  605.074942] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[  605.075902] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1
fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4
<0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[  605.075904] RSP: 0018:ffffd4e34aa37c50 EFLAGS: 00010246
[  605.075907] RAX: 0000000000000000 RBX: ffff8edc1d680c70 RCX:
0000000000000000
[  605.075908] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  605.075909] RBP: ffffd4e34aa37c70 R08: 0000000000000000 R09:
0000000000000000
[  605.075910] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff8edc1d680000
[  605.075911] R13: 0000000000000000 R14: ffff8edc1d6d0d58 R15:
ffff8edc1d680000
[  605.075913] FS:  0000000000000000(0000) GS:ffff8edf196f0000(0000)
knlGS:0000000000000000
[  605.075914] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  605.075915] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4:
00000000001506f0
[  605.075917] Call Trace:
[  605.075918]  <TASK>
[  605.075919]  ? delay_halt.part.0+0x3e/0x70
[  605.075927]  gmc_v8_0_hw_fini+0x1f/0xb0 [amdgpu]
[  605.076856]  gmc_v8_0_suspend+0xe/0x20 [amdgpu]
[  605.077781]  amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]
[  605.078676]  amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdgpu]
[  605.079560]  amdgpu_device_suspend+0x113/0x170 [amdgpu]
[  605.080438]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[  605.081318]  pci_pm_suspend+0x85/0x1b0
[  605.081323]  ? __pfx_pci_pm_suspend+0x10/0x10
[  605.081326]  dpm_run_callback+0x5f/0x160
[  605.081330]  device_suspend+0x1e4/0x4e0
[  605.081332]  async_suspend+0x21/0x40
[  605.081335]  async_run_entry_fn+0x33/0x130
[  605.081339]  process_one_work+0x18e/0x370
[  605.081342]  worker_thread+0x317/0x450
[  605.081344]  ? __pfx_worker_thread+0x10/0x10
[  605.081345]  kthread+0x10b/0x220
[  605.081348]  ? recalc_sigpending+0x76/0xb0
[  605.081351]  ? __pfx_kthread+0x10/0x10
[  605.081353]  ret_from_fork+0x134/0x150
[  605.081368]  ? __pfx_kthread+0x10/0x10
[  605.081371]  ret_from_fork_asm+0x1a/0x30
[  605.081375]  </TASK>
[  605.081376] ---[ end trace 0000000000000000 ]---
[  605.083479] amdgpu 0000:03:00.0: amdgpu: PCI CONFIG reset
[  605.083699] ACPI: EC: interrupt blocked
[  605.109649] ACPI: PM: Preparing to enter system sleep state S3
[  605.435280] ACPI Warning: Time parameter 120 us > 100 us violating ACPI
spec, please fix the firmware. (20250807/exsystem-142)
[  605.436113] ACPI: EC: event blocked
[  605.436114] ACPI: EC: EC stopped
[  605.436115] ACPI: PM: Saving platform NVS memory
[  605.436214] Disabling non-boot CPUs ...
[  605.438631] smpboot: CPU 3 is now offline
[  605.442252] smpboot: CPU 2 is now offline
[  605.445111] smpboot: CPU 1 is now offline
[  605.447033] ACPI: PM: Low-level resume complete
[  605.447067] ACPI: EC: EC started
[  605.447069] ACPI: PM: Restoring platform NVS memory
[  605.447227] AMD-Vi: Virtual APIC enabled
[  605.447251] AMD-Vi: Virtual APIC enabled
[  605.447254] LVT offset 0 assigned for vector 0x400
[  605.447757] Enabling non-boot CPUs ...
[  605.447830] smpboot: Booting Node 0 Processor 1 APIC 0x11
[  605.451533] CPU1 is up
[  605.451598] smpboot: Booting Node 0 Processor 2 APIC 0x12
[  605.455447] CPU2 is up
[  605.455507] smpboot: Booting Node 0 Processor 3 APIC 0x13
[  605.459382] CPU3 is up
[  605.460791] ACPI: PM: Waking up from system sleep state S3
[  605.512016] ACPI: EC: interrupt unblocked
[  605.518861] [drm] PCIE GART of 1024M enabled (table at
0x000000F400A00000).
[  605.518874] ACPI: EC: event unblocked
[  605.518899] amdgpu: smu version 27.17.00
[  605.536571] [drm] PCIE GART of 256M enabled (table at
0x000000F4FFF80000).
[  605.551074] [drm] UVD initialized successfully.
[  605.718769] [drm] UVD and UVD ENC initialized successfully.
[  605.752031] [drm] VCE initialized successfully.
[  605.763611] usb 1-2: reset high-speed USB device number 2 using xhci_hcd
[  605.773339] usb 2-1.4: reset high-speed USB device number 4 using
ehci-pci
[  605.819760] [drm] VCE initialized successfully.
[  605.939506] usb 2-1.2: reset full-speed USB device number 3 using
ehci-pci
[  605.984372] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  605.986837] sd 1:0:0:0: [sda] Starting disk
[  605.990324] ata1.00: configured for UDMA/133
[  606.034393] OOM killer enabled.
[  606.034400] Restarting tasks: Starting
[  606.036871] Restarting tasks: Done
[  606.036937] random: crng reseeded on system resumption
[  606.037313] Bluetooth: hci0: using rampatch file:
qca/rampatch_usb_00000302.bin
[  606.037348] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware
rome 0x302 build 0x111
[  606.049086] PM: suspend exit
[  606.325705] Generic FE-GE Realtek PHY r8169-0-200:00: attached PHY
driver (mii_bus:phy_addr=r8169-0-200:00, irq=MAC)
[  606.403987] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
[  606.426895] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection
command is advertised, but not supported.
[  606.481379] r8169 0000:02:00.0 enp2s0: Link is Down
[  606.673801] Bluetooth: MGMT ver 1.23
[  606.684146] kauditd_printk_skb: 6 callbacks suppressed
[  606.684153] audit: type=1400 audit(1770175422.234:141):
apparmor="ALLOWED" operation="getattr" class="posix_mqueue"
profile="snap.ubuntu-desktop-bootstrap.subiquity-server" name="/" pid=6784
comm="pvscan" requested="getattr" denied="getattr" class="posix_mqueue"
fsuid=0 ouid=0 olabel="unconfined"
[  606.684159] audit: type=1400 audit(1770175422.234:142):
apparmor="ALLOWED" operation="getattr" class="posix_mqueue"
profile="snap.ubuntu-desktop-bootstrap.subiquity-server" name="/" pid=6784
comm="pvscan" requested="getattr" denied="getattr" class="posix_mqueue"
fsuid=0 ouid=0 olabel="unconfined"
[  606.684162] audit: type=1400 audit(1770175422.234:143):
apparmor="ALLOWED" operation="getattr" class="posix_mqueue"
profile="snap.ubuntu-desktop-bootstrap.subiquity-server" name="/" pid=6784
comm="pvscan" requested="getattr" denied="getattr" class="posix_mqueue"
fsuid=0 ouid=0 olabel="unconfined"
[  606.684165] audit: type=1400 audit(1770175422.234:144):
apparmor="ALLOWED" operation="getattr" class="posix_mqueue"
profile="snap.ubuntu-desktop-bootstrap.subiquity-server" name="/" pid=6784
comm="pvscan" requested="getattr" denied="getattr" class="posix_mqueue"
fsuid=0 ouid=0 olabel="unconfined"
[  606.763476] audit: type=1400 audit(1770175422.314:145):
apparmor="ALLOWED" operation="getattr" class="posix_mqueue"
profile="snap.ubuntu-desktop-bootstrap.subiquity-server" name="/" pid=6789
comm="vgscan" requested="getattr" denied="getattr" class="posix_mqueue"
fsuid=0 ouid=0 olabel="unconfined"
[  606.763489] audit: type=1400 audit(1770175422.314:146):
apparmor="ALLOWED" operation="getattr" class="posix_mqueue"
profile="snap.ubuntu-desktop-bootstrap.subiquity-server" name="/" pid=6789
comm="vgscan" requested="getattr" denied="getattr" class="posix_mqueue"
fsuid=0 ouid=0 olabel="unconfined"
[  606.763492] audit: type=1400 audit(1770175422.314:147):
apparmor="ALLOWED" operation="getattr" class="posix_mqueue"
profile="snap.ubuntu-desktop-bootstrap.subiquity-server" name="/" pid=6789
comm="vgscan" requested="getattr" denied="getattr" class="posix_mqueue"
fsuid=0 ouid=0 olabel="unconfined"
[  606.763494] audit: type=1400 audit(1770175422.314:148):
apparmor="ALLOWED" operation="getattr" class="posix_mqueue"
profile="snap.ubuntu-desktop-bootstrap.subiquity-server" name="/" pid=6789
comm="vgscan" requested="getattr" denied="getattr" class="posix_mqueue"
fsuid=0 ouid=0 olabel="unconfined"
[  606.857207] audit: type=1400 audit(1770175422.407:149):
apparmor="ALLOWED" operation="getattr" class="posix_mqueue"
profile="snap.ubuntu-desktop-bootstrap.subiquity-server" name="/" pid=6790
comm="vgchange" requested="getattr" denied="getattr" class="posix_mqueue"
fsuid=0 ouid=0 olabel="unconfined"
[  606.857221] audit: type=1400 audit(1770175422.407:150):
apparmor="ALLOWED" operation="getattr" class="posix_mqueue"
profile="snap.ubuntu-desktop-bootstrap.subiquity-server" name="/" pid=6790
comm="vgchange" requested="getattr" denied="getattr" class="posix_mqueue"
fsuid=0 ouid=0 olabel="unconfined"
ubuntu@ubuntu:~$

--000000000000b80359064a006329
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>I try live boot of ubuntu 26.04 snap=
shot 3 (6.18.0-9) on dell inspiron 5576 with RX460 dGPU, everything seems o=
k, until i try to put system to sleep:</div><div>(sleep/suspend worked fine=
 on ubuntu 22.04 last time i checked and it works fine in windows)</div><di=
v><br></div><div>[ =C2=A0593.187045] PM: suspend entry (deep)<br>[ =C2=A059=
3.187143] Filesystems sync: 0.000 seconds<br>[ =C2=A0593.191490] Freezing u=
ser space processes<br>[ =C2=A0593.193435] Freezing user space processes co=
mpleted (elapsed 0.001 seconds)<br>[ =C2=A0593.193446] OOM killer disabled.=
<br>[ =C2=A0593.193447] Freezing remaining freezable tasks<br>[ =C2=A0593.1=
94764] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)=
<br>[ =C2=A0593.194816] printk: Suspending console(s) (use no_console_suspe=
nd to debug)<br>[ =C2=A0593.323573] sd 1:0:0:0: [sda] Synchronizing SCSI ca=
che<br>[ =C2=A0593.423009] ata1.00: Entering standby power mode<br>[ =C2=A0=
593.553102] [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF80000).<=
br>[ =C2=A0593.623444] psmouse serio1: Failed to disable mouse on isa0060/s=
erio1<br>[ =C2=A0594.733234] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not =
responding, trying to reset the VCPU!!!<br>[ =C2=A0595.754613] [drm:uvd_v6_=
0_start [amdgpu]] *ERROR* UVD not responding, trying to reset the VCPU!!!<b=
r>[ =C2=A0596.775980] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not respond=
ing, trying to reset the VCPU!!!<br>[ =C2=A0597.797336] [drm:uvd_v6_0_start=
 [amdgpu]] *ERROR* UVD not responding, trying to reset the VCPU!!!<br>[ =C2=
=A0598.818700] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!<br>[ =C2=A0599.840060] [drm:uvd_v6_0_start [amdgp=
u]] *ERROR* UVD not responding, trying to reset the VCPU!!!<br>[ =C2=A0600.=
861418] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, trying to=
 reset the VCPU!!!<br>[ =C2=A0601.882800] [drm:uvd_v6_0_start [amdgpu]] *ER=
ROR* UVD not responding, trying to reset the VCPU!!!<br>[ =C2=A0602.904165]=
 [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, trying to reset =
the VCPU!!!<br>[ =C2=A0603.925523] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UV=
D not responding, trying to reset the VCPU!!!<br>[ =C2=A0603.946463] [drm:u=
vd_v6_0_start [amdgpu]] *ERROR* UVD not responding, giving up!!!<br>[ =C2=
=A0603.947393] amdgpu 0000:03:00.0: amdgpu: set_powergating_state of IP blo=
ck &lt;uvd_v6_0&gt; failed -1<br>[ =C2=A0604.217843] amdgpu 0000:03:00.0: [=
drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring uvd test failed (-110)<b=
r>[ =C2=A0604.218768] amdgpu 0000:03:00.0: amdgpu: resume of IP block &lt;u=
vd_v6_0&gt; failed -110<br>[ =C2=A0604.218773] amdgpu 0000:03:00.0: amdgpu:=
 amdgpu_device_ip_resume failed (-110).<br>[ =C2=A0604.219420] ------------=
[ cut here ]------------<br>[ =C2=A0604.219425] WARNING: CPU: 0 PID: 6585 a=
t drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amd=
gpu]<br>[ =C2=A0604.220350] Modules linked in: btrfs blake2b_generic ufs qn=
x4 hfsplus hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_=
hrtimer qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO)=
 spl(O) amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_co=
mponent snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic =
snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acp=
i snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_m=
idi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq =
amdxcp mac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_help=
er ttm drm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_=
device snd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel =
libarc4 platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004=
 memstick dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas=
 k10temp dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn<br>=
[ =C2=A0604.220426] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel<br>[ =C2=A0604.220462] CPU: 0 UID: 0 PID: 6585 Co=
mm: kworker/u16:21 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 O =C2=A0 =
=C2=A0 =C2=A0 =C2=A06.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br>[ =C2=
=A0604.220467] Tainted: [P]=3DPROPRIETARY_MODULE, [O]=3DOOT_MODULE<br>[ =C2=
=A0604.220468] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01=
/29/2018<br>[ =C2=A0604.220470] Workqueue: async async_run_entry_fn<br>[ =
=C2=A0604.220476] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A060=
4.221397] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff=
 ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&g=
t; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ =C2=
=A0604.221400] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246<br>[ =C2=A0604.2=
21403] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 0000000000000000<br=
>[ =C2=A0604.221404] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000=
00000000000<br>[ =C2=A0604.221405] RBP: ffffd4e34aa37ca8 R08: 0000000000000=
000 R09: 0000000000000000<br>[ =C2=A0604.221406] R10: 0000000000000000 R11:=
 0000000000000000 R12: ffff8edc1d680000<br>[ =C2=A0604.221407] R13: 0000000=
000000000 R14: 0000000000000002 R15: 0000000000000000<br>[ =C2=A0604.221409=
] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(0000) knlGS:00000000=
00000000<br>[ =C2=A0604.221410] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 00000=
00080050033<br>[ =C2=A0604.221411] CR2: 000064d8a61373c0 CR3: 0000000123a6b=
000 CR4: 00000000001506f0<br>[ =C2=A0604.221413] Call Trace:<br>[ =C2=A0604=
.221415] =C2=A0&lt;TASK&gt;<br>[ =C2=A0604.221420] =C2=A0amdgpu_fence_drive=
r_hw_fini+0x11d/0x160 [amdgpu]<br>[ =C2=A0604.222316] =C2=A0? amdgpu_ttm_ev=
ict_resources+0x39/0x70 [amdgpu]<br>[ =C2=A0604.223208] =C2=A0amdgpu_device=
_suspend+0x10a/0x170 [amdgpu]<br>[ =C2=A0604.224094] =C2=A0amdgpu_pmops_sus=
pend+0x3d/0xe0 [amdgpu]<br>[ =C2=A0604.224979] =C2=A0pci_pm_suspend+0x85/0x=
1b0<br>[ =C2=A0604.224986] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=
=A0604.224989] =C2=A0dpm_run_callback+0x5f/0x160<br>[ =C2=A0604.224993] =C2=
=A0device_suspend+0x1e4/0x4e0<br>[ =C2=A0604.224996] =C2=A0async_suspend+0x=
21/0x40<br>[ =C2=A0604.224998] =C2=A0async_run_entry_fn+0x33/0x130<br>[ =C2=
=A0604.225001] =C2=A0process_one_work+0x18e/0x370<br>[ =C2=A0604.225005] =
=C2=A0worker_thread+0x317/0x450<br>[ =C2=A0604.225007] =C2=A0? __pfx_worker=
_thread+0x10/0x10<br>[ =C2=A0604.225009] =C2=A0kthread+0x10b/0x220<br>[ =C2=
=A0604.225012] =C2=A0? recalc_sigpending+0x76/0xb0<br>[ =C2=A0604.225014] =
=C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.225017] =C2=A0ret_from_fork+=
0x134/0x150<br>[ =C2=A0604.225019] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=
=A0604.225022] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0604.225026] =C2=
=A0&lt;/TASK&gt;<br>[ =C2=A0604.225027] ---[ end trace 0000000000000000 ]--=
-<br>[ =C2=A0604.225086] ------------[ cut here ]------------<br>[ =C2=A060=
4.225087] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_ir=
q.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.226002] Modules li=
nked in: btrfs blake2b_generic ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs=
2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac algif_hash algif_skc=
ipher af_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_hda_codec_alc269 sn=
d_hda_codec_atihdmi snd_hda_scodec_component snd_hda_codec_realtek_lib snd_=
hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_co=
re snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_m=
ce_amd snd_seq_midi kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci k=
vm ath10k_core ath irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_qu=
irks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper dr=
m_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb cf=
g80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore blu=
etooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon spar=
se_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor fam15h_po=
wer i2c_piix4 i2c_smbus dell_rbtn<br>[ =C2=A0604.226061] =C2=A0joydev input=
_leds mac_hid sch_fq_codel ppdev lp msr parport_pc parport efi_pstore nfnet=
link dmi_sysfs autofs4 overlay nls_iso8859_1 raid10 raid456 async_raid6_rec=
ov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 linear=
 hid_multitouch hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi=
 polyval_clmulni vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vga=
state hid wmi realtek ahci libahci uas usb_storage aesni_intel<br>[ =C2=A06=
04.226094] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P =C2=A0 =
=C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-generic #=
9-Ubuntu PREEMPT(voluntary)<br>[ =C2=A0604.226098] Tainted: [P]=3DPROPRIETA=
RY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ =C2=A0604.226099] Hardware nam=
e: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0604.226=
101] Workqueue: async async_run_entry_fn<br>[ =C2=A0604.226106] RIP: 0010:a=
mdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.227029] Code: ff 84 c0 75 8=
5 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5=
d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8=
 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ =C2=A0604.227031] RSP: 0018:ffffd=
4e34aa37c88 EFLAGS: 00010246<br>[ =C2=A0604.227034] RAX: 0000000000000000 R=
BX: ffff8edc1d6a5a20 RCX: 0000000000000000<br>[ =C2=A0604.227035] RDX: 0000=
000000000000 RSI: 0000000000000000 RDI: 0000000000000000<br>[ =C2=A0604.227=
036] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 0000000000000000<br>[=
 =C2=A0604.227037] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8ed=
c1d680000<br>[ =C2=A0604.227038] R13: 0000000000000002 R14: 000000000000000=
2 R15: 0000000000000000<br>[ =C2=A0604.227039] FS: =C2=A00000000000000000(0=
000) GS:ffff8edf19670000(0000) knlGS:0000000000000000<br>[ =C2=A0604.227041=
] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =C2=A0604.227=
042] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 00000000001506f0<br>[=
 =C2=A0604.227043] Call Trace:<br>[ =C2=A0604.227044] =C2=A0&lt;TASK&gt;<br=
>[ =C2=A0604.227048] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]=
<br>[ =C2=A0604.227939] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgp=
u]<br>[ =C2=A0604.228843] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]<=
br>[ =C2=A0604.229731] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ =
=C2=A0604.230619] =C2=A0pci_pm_suspend+0x85/0x1b0<br>[ =C2=A0604.230624] =
=C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0604.230627] =C2=A0dpm_run=
_callback+0x5f/0x160<br>[ =C2=A0604.230631] =C2=A0device_suspend+0x1e4/0x4e=
0<br>[ =C2=A0604.230634] =C2=A0async_suspend+0x21/0x40<br>[ =C2=A0604.23063=
6] =C2=A0async_run_entry_fn+0x33/0x130<br>[ =C2=A0604.230639] =C2=A0process=
_one_work+0x18e/0x370<br>[ =C2=A0604.230642] =C2=A0worker_thread+0x317/0x45=
0<br>[ =C2=A0604.230644] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A06=
04.230646] =C2=A0kthread+0x10b/0x220<br>[ =C2=A0604.230649] =C2=A0? recalc_=
sigpending+0x76/0xb0<br>[ =C2=A0604.230651] =C2=A0? __pfx_kthread+0x10/0x10=
<br>[ =C2=A0604.230654] =C2=A0ret_from_fork+0x134/0x150<br>[ =C2=A0604.2306=
56] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.230658] =C2=A0ret_from_f=
ork_asm+0x1a/0x30<br>[ =C2=A0604.230662] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0604=
.230663] ---[ end trace 0000000000000000 ]---<br>[ =C2=A0604.230720] ------=
------[ cut here ]------------<br>[ =C2=A0604.230721] WARNING: CPU: 0 PID: =
6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe=
0 [amdgpu]<br>[ =C2=A0604.231654] Modules linked in: btrfs blake2b_generic =
ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dumm=
y snd_hrtimer qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc z=
fs(PO) spl(O) amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_sco=
dec_component snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_ge=
neric snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_s=
dw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd=
_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass sn=
d_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_tt=
m_helper ttm drm_exec drm_suballoc_helper drm_display_helper cec rc_core sn=
d_seq_device snd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm bt=
intel libarc4 platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop =
ee1004 memstick dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios =
dcdbas k10temp dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rb=
tn<br>[ =C2=A0604.231714] =C2=A0joydev input_leds mac_hid sch_fq_codel ppde=
v lp msr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay =
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_=
xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rts=
x_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_u=
sb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci liba=
hci uas usb_storage aesni_intel<br>[ =C2=A0604.231746] CPU: 0 UID: 0 PID: 6=
585 Comm: kworker/u16:21 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =
=C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br=
>[ =C2=A0604.231751] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DO=
OT_MODULE<br>[ =C2=A0604.231752] Hardware name: Dell Inc. Inspiron 5576/0JW=
8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0604.231753] Workqueue: async async_ru=
n_entry_fn<br>[ =C2=A0604.231759] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgp=
u]<br>[ =C2=A0604.232678] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 8=
9 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec c=
d 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d=
 00 0f<br>[ =C2=A0604.232681] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246<b=
r>[ =C2=A0604.232685] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 0000=
000000000000<br>[ =C2=A0604.232686] RDX: 0000000000000000 RSI: 000000000000=
0000 RDI: 0000000000000000<br>[ =C2=A0604.232687] RBP: ffffd4e34aa37ca8 R08=
: 0000000000000000 R09: 0000000000000000<br>[ =C2=A0604.232689] R10: 000000=
0000000000 R11: 0000000000000000 R12: ffff8edc1d680000<br>[ =C2=A0604.23269=
0] R13: 0000000000000002 R14: 0000000000000002 R15: 0000000000000000<br>[ =
=C2=A0604.232691] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(0000=
) knlGS:0000000000000000<br>[ =C2=A0604.232693] CS: =C2=A00010 DS: 0000 ES:=
 0000 CR0: 0000000080050033<br>[ =C2=A0604.232695] CR2: 000064d8a61373c0 CR=
3: 0000000123a6b000 CR4: 00000000001506f0<br>[ =C2=A0604.232696] Call Trace=
:<br>[ =C2=A0604.232698] =C2=A0&lt;TASK&gt;<br>[ =C2=A0604.232702] =C2=A0am=
dgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]<br>[ =C2=A0604.233601] =C2=
=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]<br>[ =C2=A0604.234506] =
=C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]<br>[ =C2=A0604.235404] =C2=
=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ =C2=A0604.236275] =C2=A0pci=
_pm_suspend+0x85/0x1b0<br>[ =C2=A0604.236281] =C2=A0? __pfx_pci_pm_suspend+=
0x10/0x10<br>[ =C2=A0604.236283] =C2=A0dpm_run_callback+0x5f/0x160<br>[ =C2=
=A0604.236287] =C2=A0device_suspend+0x1e4/0x4e0<br>[ =C2=A0604.236290] =C2=
=A0async_suspend+0x21/0x40<br>[ =C2=A0604.236292] =C2=A0async_run_entry_fn+=
0x33/0x130<br>[ =C2=A0604.236295] =C2=A0process_one_work+0x18e/0x370<br>[ =
=C2=A0604.236299] =C2=A0worker_thread+0x317/0x450<br>[ =C2=A0604.236301] =
=C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A0604.236302] =C2=A0kthread+=
0x10b/0x220<br>[ =C2=A0604.236305] =C2=A0? recalc_sigpending+0x76/0xb0<br>[=
 =C2=A0604.236307] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.236310] =
=C2=A0ret_from_fork+0x134/0x150<br>[ =C2=A0604.236312] =C2=A0? __pfx_kthrea=
d+0x10/0x10<br>[ =C2=A0604.236315] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =
=C2=A0604.236319] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0604.236320] ---[ end trace=
 0000000000000000 ]---<br>[ =C2=A0604.236389] ------------[ cut here ]-----=
-------<br>[ =C2=A0604.236391] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm=
/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A06=
04.237301] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus hfs mi=
nix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac=
 algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu sn=
d_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd_hda_c=
odec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd=
_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_p=
cm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event ccp snd=
_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac80211 d=
rm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec d=
rm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_timer =
i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_=
profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wm=
i dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi=
_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn<br>[ =C2=A0604.23737=
0] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp msr parport_pc par=
port efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 raid10 ra=
id456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_=
pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc psmouse vid=
eo r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmulni_intel =
serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_storage aes=
ni_intel<br>[ =C2=A0604.237404] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:2=
1 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=
=A06.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br>[ =C2=A0604.237408] Tai=
nted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ =C2=A0604=
.237409] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/20=
18<br>[ =C2=A0604.237410] Workqueue: async async_run_entry_fn<br>[ =C2=A060=
4.237416] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.238328=
] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 8=
3 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8=
 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ =C2=A0604.23=
8330] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246<br>[ =C2=A0604.238332] RA=
X: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 0000000000000000<br>[ =C2=A0=
604.238333] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000=
00<br>[ =C2=A0604.238334] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: =
0000000000000000<br>[ =C2=A0604.238335] R10: 0000000000000000 R11: 00000000=
00000000 R12: ffff8edc1d680000<br>[ =C2=A0604.238336] R13: 0000000000000002=
 R14: 0000000000000002 R15: 0000000000000000<br>[ =C2=A0604.238338] FS: =C2=
=A00000000000000000(0000) GS:ffff8edf19670000(0000) knlGS:0000000000000000<=
br>[ =C2=A0604.238339] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 00000000800500=
33<br>[ =C2=A0604.238340] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: =
00000000001506f0<br>[ =C2=A0604.238342] Call Trace:<br>[ =C2=A0604.238343] =
=C2=A0&lt;TASK&gt;<br>[ =C2=A0604.238347] =C2=A0amdgpu_fence_driver_hw_fini=
+0x11d/0x160 [amdgpu]<br>[ =C2=A0604.239247] =C2=A0? amdgpu_ttm_evict_resou=
rces+0x39/0x70 [amdgpu]<br>[ =C2=A0604.240137] =C2=A0amdgpu_device_suspend+=
0x10a/0x170 [amdgpu]<br>[ =C2=A0604.241032] =C2=A0amdgpu_pmops_suspend+0x3d=
/0xe0 [amdgpu]<br>[ =C2=A0604.241934] =C2=A0pci_pm_suspend+0x85/0x1b0<br>[ =
=C2=A0604.241940] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0604.241=
942] =C2=A0dpm_run_callback+0x5f/0x160<br>[ =C2=A0604.241946] =C2=A0device_=
suspend+0x1e4/0x4e0<br>[ =C2=A0604.241949] =C2=A0async_suspend+0x21/0x40<br=
>[ =C2=A0604.241951] =C2=A0async_run_entry_fn+0x33/0x130<br>[ =C2=A0604.241=
954] =C2=A0process_one_work+0x18e/0x370<br>[ =C2=A0604.241958] =C2=A0worker=
_thread+0x317/0x450<br>[ =C2=A0604.241960] =C2=A0? __pfx_worker_thread+0x10=
/0x10<br>[ =C2=A0604.241961] =C2=A0kthread+0x10b/0x220<br>[ =C2=A0604.24196=
4] =C2=A0? recalc_sigpending+0x76/0xb0<br>[ =C2=A0604.241966] =C2=A0? __pfx=
_kthread+0x10/0x10<br>[ =C2=A0604.241969] =C2=A0ret_from_fork+0x134/0x150<b=
r>[ =C2=A0604.241972] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.241974=
] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0604.241978] =C2=A0&lt;/TASK&=
gt;<br>[ =C2=A0604.241979] ---[ end trace 0000000000000000 ]---<br>[ =C2=A0=
604.242037] ------------[ cut here ]------------<br>[ =C2=A0604.242038] WAR=
NING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgp=
u_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.242954] Modules linked in: btrf=
s blake2b_generic ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs2_utils xfs r=
fcomm snd_seq_dummy snd_hrtimer qrtr cmac algif_hash algif_skcipher af_alg =
bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_hda_codec_alc269 snd_hda_codec_a=
tihdmi snd_hda_scodec_component snd_hda_codec_realtek_lib snd_hda_codec_hdm=
i snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_intel_=
dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_se=
q_midi kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_cor=
e ath irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sche=
d drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper drm_display_hel=
per cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb cfg80211 snd bt=
mtk btrtl btbcm btintel libarc4 platform_profile soundcore bluetooth rtsx_u=
sb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon sparse_keymap wmi=
_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor fam15h_power i2c_piix4=
 i2c_smbus dell_rbtn<br>[ =C2=A0604.243013] =C2=A0joydev input_leds mac_hid=
 sch_fq_codel ppdev lp msr parport_pc parport efi_pstore nfnetlink dmi_sysf=
s autofs4 overlay nls_iso8859_1 raid10 raid456 async_raid6_recov async_memc=
py async_pq async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitou=
ch hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmu=
lni vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi=
 realtek ahci libahci uas usb_storage aesni_intel<br>[ =C2=A0604.243046] CP=
U: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P =C2=A0 =C2=A0 =C2=A0 =
=C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-generic #9-Ubuntu PREEM=
PT(voluntary)<br>[ =C2=A0604.243050] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=
=3DWARN, [O]=3DOOT_MODULE<br>[ =C2=A0604.243051] Hardware name: Dell Inc. I=
nspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0604.243052] Workqueue=
: async async_run_entry_fn<br>[ =C2=A0604.243058] RIP: 0010:amdgpu_irq_put+=
0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.243986] Code: ff 84 c0 75 85 eb 25 44 89 =
ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 =
f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff e=
b a4 e9 8d 14 8d 00 0f<br>[ =C2=A0604.243988] RSP: 0018:ffffd4e34aa37c88 EF=
LAGS: 00010246<br>[ =C2=A0604.243990] RAX: 0000000000000000 RBX: ffff8edc1d=
6a5a20 RCX: 0000000000000000<br>[ =C2=A0604.243992] RDX: 0000000000000000 R=
SI: 0000000000000000 RDI: 0000000000000000<br>[ =C2=A0604.243993] RBP: ffff=
d4e34aa37ca8 R08: 0000000000000000 R09: 0000000000000000<br>[ =C2=A0604.243=
994] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1d680000<br>[=
 =C2=A0604.243995] R13: 0000000000000002 R14: 0000000000000002 R15: 0000000=
000000000<br>[ =C2=A0604.243996] FS: =C2=A00000000000000000(0000) GS:ffff8e=
df19670000(0000) knlGS:0000000000000000<br>[ =C2=A0604.243997] CS: =C2=A000=
10 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =C2=A0604.243998] CR2: 0000=
64d8a61373c0 CR3: 0000000123a6b000 CR4: 00000000001506f0<br>[ =C2=A0604.244=
000] Call Trace:<br>[ =C2=A0604.244001] =C2=A0&lt;TASK&gt;<br>[ =C2=A0604.2=
44005] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]<br>[ =C2=A060=
4.244899] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]<br>[ =C2=A0=
604.245788] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]<br>[ =C2=A0604=
.246685] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ =C2=A0604.24757=
7] =C2=A0pci_pm_suspend+0x85/0x1b0<br>[ =C2=A0604.247582] =C2=A0? __pfx_pci=
_pm_suspend+0x10/0x10<br>[ =C2=A0604.247585] =C2=A0dpm_run_callback+0x5f/0x=
160<br>[ =C2=A0604.247589] =C2=A0device_suspend+0x1e4/0x4e0<br>[ =C2=A0604.=
247592] =C2=A0async_suspend+0x21/0x40<br>[ =C2=A0604.247594] =C2=A0async_ru=
n_entry_fn+0x33/0x130<br>[ =C2=A0604.247598] =C2=A0process_one_work+0x18e/0=
x370<br>[ =C2=A0604.247601] =C2=A0worker_thread+0x317/0x450<br>[ =C2=A0604.=
247603] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A0604.247604] =C2=A0=
kthread+0x10b/0x220<br>[ =C2=A0604.247607] =C2=A0? recalc_sigpending+0x76/0=
xb0<br>[ =C2=A0604.247610] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.2=
47612] =C2=A0ret_from_fork+0x134/0x150<br>[ =C2=A0604.247615] =C2=A0? __pfx=
_kthread+0x10/0x10<br>[ =C2=A0604.247617] =C2=A0ret_from_fork_asm+0x1a/0x30=
<br>[ =C2=A0604.247621] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0604.247622] ---[ end=
 trace 0000000000000000 ]---<br>[ =C2=A0604.247680] ------------[ cut here =
]------------<br>[ =C2=A0604.247681] WARNING: CPU: 0 PID: 6585 at drivers/g=
pu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =
=C2=A0604.248598] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus=
 hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qr=
tr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) am=
dgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component sn=
d_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_in=
tel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwde=
p snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event =
ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac=
80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm=
_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd=
_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pl=
atform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick =
dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp d=
ell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn<br>[ =C2=A060=
4.248658] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp msr parport=
_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 ra=
id10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor=
 raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc psmo=
use video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmulni=
_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_stor=
age aesni_intel<br>[ =C2=A0604.248691] CPU: 0 UID: 0 PID: 6585 Comm: kworke=
r/u16:21 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=
=A0 =C2=A06.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br>[ =C2=A0604.2486=
95] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ =
=C2=A0604.248696] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7=
 01/29/2018<br>[ =C2=A0604.248697] Workqueue: async async_run_entry_fn<br>[=
 =C2=A0604.248702] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A06=
04.249627] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc f=
f ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&=
gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ =C2=
=A0604.249629] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246<br>[ =C2=A0604.2=
49632] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 0000000000000000<br=
>[ =C2=A0604.249633] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000=
00000000000<br>[ =C2=A0604.249634] RBP: ffffd4e34aa37ca8 R08: 0000000000000=
000 R09: 0000000000000000<br>[ =C2=A0604.249635] R10: 0000000000000000 R11:=
 0000000000000000 R12: ffff8edc1d680000<br>[ =C2=A0604.249636] R13: 0000000=
000000002 R14: 0000000000000002 R15: 0000000000000000<br>[ =C2=A0604.249638=
] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(0000) knlGS:00000000=
00000000<br>[ =C2=A0604.249639] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 00000=
00080050033<br>[ =C2=A0604.249640] CR2: 000064d8a61373c0 CR3: 0000000123a6b=
000 CR4: 00000000001506f0<br>[ =C2=A0604.249642] Call Trace:<br>[ =C2=A0604=
.249643] =C2=A0&lt;TASK&gt;<br>[ =C2=A0604.249647] =C2=A0amdgpu_fence_drive=
r_hw_fini+0x11d/0x160 [amdgpu]<br>[ =C2=A0604.250538] =C2=A0? amdgpu_ttm_ev=
ict_resources+0x39/0x70 [amdgpu]<br>[ =C2=A0604.251444] =C2=A0amdgpu_device=
_suspend+0x10a/0x170 [amdgpu]<br>[ =C2=A0604.252318] =C2=A0amdgpu_pmops_sus=
pend+0x3d/0xe0 [amdgpu]<br>[ =C2=A0604.253208] =C2=A0pci_pm_suspend+0x85/0x=
1b0<br>[ =C2=A0604.253215] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=
=A0604.253218] =C2=A0dpm_run_callback+0x5f/0x160<br>[ =C2=A0604.253222] =C2=
=A0device_suspend+0x1e4/0x4e0<br>[ =C2=A0604.253224] =C2=A0async_suspend+0x=
21/0x40<br>[ =C2=A0604.253227] =C2=A0async_run_entry_fn+0x33/0x130<br>[ =C2=
=A0604.253230] =C2=A0process_one_work+0x18e/0x370<br>[ =C2=A0604.253233] =
=C2=A0worker_thread+0x317/0x450<br>[ =C2=A0604.253235] =C2=A0? __pfx_worker=
_thread+0x10/0x10<br>[ =C2=A0604.253237] =C2=A0kthread+0x10b/0x220<br>[ =C2=
=A0604.253240] =C2=A0? recalc_sigpending+0x76/0xb0<br>[ =C2=A0604.253242] =
=C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.253245] =C2=A0ret_from_fork+=
0x134/0x150<br>[ =C2=A0604.253248] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=
=A0604.253250] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0604.253254] =C2=
=A0&lt;/TASK&gt;<br>[ =C2=A0604.253255] ---[ end trace 0000000000000000 ]--=
-<br>[ =C2=A0604.253313] ------------[ cut here ]------------<br>[ =C2=A060=
4.253313] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_ir=
q.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.254240] Modules li=
nked in: btrfs blake2b_generic ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs=
2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac algif_hash algif_skc=
ipher af_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_hda_codec_alc269 sn=
d_hda_codec_atihdmi snd_hda_scodec_component snd_hda_codec_realtek_lib snd_=
hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_co=
re snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_m=
ce_amd snd_seq_midi kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci k=
vm ath10k_core ath irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_qu=
irks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper dr=
m_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb cf=
g80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore blu=
etooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon spar=
se_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor fam15h_po=
wer i2c_piix4 i2c_smbus dell_rbtn<br>[ =C2=A0604.254299] =C2=A0joydev input=
_leds mac_hid sch_fq_codel ppdev lp msr parport_pc parport efi_pstore nfnet=
link dmi_sysfs autofs4 overlay nls_iso8859_1 raid10 raid456 async_raid6_rec=
ov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 linear=
 hid_multitouch hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi=
 polyval_clmulni vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vga=
state hid wmi realtek ahci libahci uas usb_storage aesni_intel<br>[ =C2=A06=
04.254332] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P =C2=A0 =
=C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-generic #=
9-Ubuntu PREEMPT(voluntary)<br>[ =C2=A0604.254336] Tainted: [P]=3DPROPRIETA=
RY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ =C2=A0604.254337] Hardware nam=
e: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0604.254=
339] Workqueue: async async_run_entry_fn<br>[ =C2=A0604.254344] RIP: 0010:a=
mdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.255268] Code: ff 84 c0 75 8=
5 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5=
d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8=
 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ =C2=A0604.255271] RSP: 0018:ffffd=
4e34aa37c88 EFLAGS: 00010246<br>[ =C2=A0604.255274] RAX: 0000000000000000 R=
BX: ffff8edc1d6a5a20 RCX: 0000000000000000<br>[ =C2=A0604.255275] RDX: 0000=
000000000000 RSI: 0000000000000000 RDI: 0000000000000000<br>[ =C2=A0604.255=
276] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 0000000000000000<br>[=
 =C2=A0604.255278] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8ed=
c1d680000<br>[ =C2=A0604.255279] R13: 0000000000000002 R14: 000000000000000=
2 R15: 0000000000000000<br>[ =C2=A0604.255280] FS: =C2=A00000000000000000(0=
000) GS:ffff8edf19670000(0000) knlGS:0000000000000000<br>[ =C2=A0604.255281=
] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =C2=A0604.255=
282] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 00000000001506f0<br>[=
 =C2=A0604.255284] Call Trace:<br>[ =C2=A0604.255285] =C2=A0&lt;TASK&gt;<br=
>[ =C2=A0604.255289] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]=
<br>[ =C2=A0604.256183] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgp=
u]<br>[ =C2=A0604.257090] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]<=
br>[ =C2=A0604.257988] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ =
=C2=A0604.258877] =C2=A0pci_pm_suspend+0x85/0x1b0<br>[ =C2=A0604.258884] =
=C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0604.258887] =C2=A0dpm_run=
_callback+0x5f/0x160<br>[ =C2=A0604.258891] =C2=A0device_suspend+0x1e4/0x4e=
0<br>[ =C2=A0604.258893] =C2=A0async_suspend+0x21/0x40<br>[ =C2=A0604.25889=
5] =C2=A0async_run_entry_fn+0x33/0x130<br>[ =C2=A0604.258899] =C2=A0process=
_one_work+0x18e/0x370<br>[ =C2=A0604.258902] =C2=A0worker_thread+0x317/0x45=
0<br>[ =C2=A0604.258904] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A06=
04.258906] =C2=A0kthread+0x10b/0x220<br>[ =C2=A0604.258908] =C2=A0? recalc_=
sigpending+0x76/0xb0<br>[ =C2=A0604.258911] =C2=A0? __pfx_kthread+0x10/0x10=
<br>[ =C2=A0604.258913] =C2=A0ret_from_fork+0x134/0x150<br>[ =C2=A0604.2589=
16] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.258918] =C2=A0ret_from_f=
ork_asm+0x1a/0x30<br>[ =C2=A0604.258922] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0604=
.258923] ---[ end trace 0000000000000000 ]---<br>[ =C2=A0604.258981] ------=
------[ cut here ]------------<br>[ =C2=A0604.258982] WARNING: CPU: 0 PID: =
6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe=
0 [amdgpu]<br>[ =C2=A0604.259903] Modules linked in: btrfs blake2b_generic =
ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dumm=
y snd_hrtimer qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc z=
fs(PO) spl(O) amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_sco=
dec_component snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_ge=
neric snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_s=
dw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd=
_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass sn=
d_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_tt=
m_helper ttm drm_exec drm_suballoc_helper drm_display_helper cec rc_core sn=
d_seq_device snd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm bt=
intel libarc4 platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop =
ee1004 memstick dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios =
dcdbas k10temp dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rb=
tn<br>[ =C2=A0604.259962] =C2=A0joydev input_leds mac_hid sch_fq_codel ppde=
v lp msr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay =
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_=
xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rts=
x_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_u=
sb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci liba=
hci uas usb_storage aesni_intel<br>[ =C2=A0604.259995] CPU: 0 UID: 0 PID: 6=
585 Comm: kworker/u16:21 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =
=C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br=
>[ =C2=A0604.259999] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DO=
OT_MODULE<br>[ =C2=A0604.259999] Hardware name: Dell Inc. Inspiron 5576/0JW=
8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0604.260001] Workqueue: async async_ru=
n_entry_fn<br>[ =C2=A0604.260006] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgp=
u]<br>[ =C2=A0604.260922] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 8=
9 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec c=
d 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d=
 00 0f<br>[ =C2=A0604.260925] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246<b=
r>[ =C2=A0604.260928] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 0000=
000000000000<br>[ =C2=A0604.260929] RDX: 0000000000000000 RSI: 000000000000=
0000 RDI: 0000000000000000<br>[ =C2=A0604.260930] RBP: ffffd4e34aa37ca8 R08=
: 0000000000000000 R09: 0000000000000000<br>[ =C2=A0604.260931] R10: 000000=
0000000000 R11: 0000000000000000 R12: ffff8edc1d680000<br>[ =C2=A0604.26093=
2] R13: 0000000000000002 R14: 0000000000000002 R15: 0000000000000000<br>[ =
=C2=A0604.260934] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(0000=
) knlGS:0000000000000000<br>[ =C2=A0604.260935] CS: =C2=A00010 DS: 0000 ES:=
 0000 CR0: 0000000080050033<br>[ =C2=A0604.260936] CR2: 000064d8a61373c0 CR=
3: 0000000123a6b000 CR4: 00000000001506f0<br>[ =C2=A0604.260938] Call Trace=
:<br>[ =C2=A0604.260939] =C2=A0&lt;TASK&gt;<br>[ =C2=A0604.260943] =C2=A0am=
dgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]<br>[ =C2=A0604.261840] =C2=
=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]<br>[ =C2=A0604.262729] =
=C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]<br>[ =C2=A0604.263628] =C2=
=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ =C2=A0604.264519] =C2=A0pci=
_pm_suspend+0x85/0x1b0<br>[ =C2=A0604.264525] =C2=A0? __pfx_pci_pm_suspend+=
0x10/0x10<br>[ =C2=A0604.264528] =C2=A0dpm_run_callback+0x5f/0x160<br>[ =C2=
=A0604.264532] =C2=A0device_suspend+0x1e4/0x4e0<br>[ =C2=A0604.264535] =C2=
=A0async_suspend+0x21/0x40<br>[ =C2=A0604.264537] =C2=A0async_run_entry_fn+=
0x33/0x130<br>[ =C2=A0604.264541] =C2=A0process_one_work+0x18e/0x370<br>[ =
=C2=A0604.264544] =C2=A0worker_thread+0x317/0x450<br>[ =C2=A0604.264546] =
=C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A0604.264548] =C2=A0kthread+=
0x10b/0x220<br>[ =C2=A0604.264551] =C2=A0? recalc_sigpending+0x76/0xb0<br>[=
 =C2=A0604.264553] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.264556] =
=C2=A0ret_from_fork+0x134/0x150<br>[ =C2=A0604.264558] =C2=A0? __pfx_kthrea=
d+0x10/0x10<br>[ =C2=A0604.264561] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =
=C2=A0604.264565] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0604.264566] ---[ end trace=
 0000000000000000 ]---<br>[ =C2=A0604.264618] ------------[ cut here ]-----=
-------<br>[ =C2=A0604.264619] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm=
/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A06=
04.265538] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus hfs mi=
nix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac=
 algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu sn=
d_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd_hda_c=
odec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd=
_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_p=
cm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event ccp snd=
_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac80211 d=
rm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec d=
rm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_timer =
i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_=
profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wm=
i dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi=
_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn<br>[ =C2=A0604.26559=
8] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp msr parport_pc par=
port efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 raid10 ra=
id456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_=
pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc psmouse vid=
eo r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmulni_intel =
serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_storage aes=
ni_intel<br>[ =C2=A0604.265631] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:2=
1 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=
=A06.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br>[ =C2=A0604.265635] Tai=
nted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ =C2=A0604=
.265636] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/20=
18<br>[ =C2=A0604.265638] Workqueue: async async_run_entry_fn<br>[ =C2=A060=
4.265643] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.266566=
] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 8=
3 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8=
 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ =C2=A0604.26=
6569] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246<br>[ =C2=A0604.266571] RA=
X: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 0000000000000000<br>[ =C2=A0=
604.266573] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000=
00<br>[ =C2=A0604.266574] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: =
0000000000000000<br>[ =C2=A0604.266575] R10: 0000000000000000 R11: 00000000=
00000000 R12: ffff8edc1d680000<br>[ =C2=A0604.266576] R13: 0000000000000002=
 R14: 0000000000000002 R15: 0000000000000000<br>[ =C2=A0604.266577] FS: =C2=
=A00000000000000000(0000) GS:ffff8edf19670000(0000) knlGS:0000000000000000<=
br>[ =C2=A0604.266578] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 00000000800500=
33<br>[ =C2=A0604.266580] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: =
00000000001506f0<br>[ =C2=A0604.266581] Call Trace:<br>[ =C2=A0604.266583] =
=C2=A0&lt;TASK&gt;<br>[ =C2=A0604.266586] =C2=A0amdgpu_fence_driver_hw_fini=
+0x11d/0x160 [amdgpu]<br>[ =C2=A0604.267483] =C2=A0? amdgpu_ttm_evict_resou=
rces+0x39/0x70 [amdgpu]<br>[ =C2=A0604.268375] =C2=A0amdgpu_device_suspend+=
0x10a/0x170 [amdgpu]<br>[ =C2=A0604.269253] =C2=A0amdgpu_pmops_suspend+0x3d=
/0xe0 [amdgpu]<br>[ =C2=A0604.270146] =C2=A0pci_pm_suspend+0x85/0x1b0<br>[ =
=C2=A0604.270152] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0604.270=
155] =C2=A0dpm_run_callback+0x5f/0x160<br>[ =C2=A0604.270159] =C2=A0device_=
suspend+0x1e4/0x4e0<br>[ =C2=A0604.270161] =C2=A0async_suspend+0x21/0x40<br=
>[ =C2=A0604.270163] =C2=A0async_run_entry_fn+0x33/0x130<br>[ =C2=A0604.270=
167] =C2=A0process_one_work+0x18e/0x370<br>[ =C2=A0604.270170] =C2=A0worker=
_thread+0x317/0x450<br>[ =C2=A0604.270172] =C2=A0? __pfx_worker_thread+0x10=
/0x10<br>[ =C2=A0604.270173] =C2=A0kthread+0x10b/0x220<br>[ =C2=A0604.27017=
6] =C2=A0? recalc_sigpending+0x76/0xb0<br>[ =C2=A0604.270179] =C2=A0? __pfx=
_kthread+0x10/0x10<br>[ =C2=A0604.270181] =C2=A0ret_from_fork+0x134/0x150<b=
r>[ =C2=A0604.270184] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.270186=
] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0604.270191] =C2=A0&lt;/TASK&=
gt;<br>[ =C2=A0604.270192] ---[ end trace 0000000000000000 ]---<br>[ =C2=A0=
604.270242] ------------[ cut here ]------------<br>[ =C2=A0604.270243] WAR=
NING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgp=
u_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.271162] Modules linked in: btrf=
s blake2b_generic ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs2_utils xfs r=
fcomm snd_seq_dummy snd_hrtimer qrtr cmac algif_hash algif_skcipher af_alg =
bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_hda_codec_alc269 snd_hda_codec_a=
tihdmi snd_hda_scodec_component snd_hda_codec_realtek_lib snd_hda_codec_hdm=
i snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_intel_=
dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_se=
q_midi kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_cor=
e ath irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sche=
d drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper drm_display_hel=
per cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb cfg80211 snd bt=
mtk btrtl btbcm btintel libarc4 platform_profile soundcore bluetooth rtsx_u=
sb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon sparse_keymap wmi=
_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor fam15h_power i2c_piix4=
 i2c_smbus dell_rbtn<br>[ =C2=A0604.271222] =C2=A0joydev input_leds mac_hid=
 sch_fq_codel ppdev lp msr parport_pc parport efi_pstore nfnetlink dmi_sysf=
s autofs4 overlay nls_iso8859_1 raid10 raid456 async_raid6_recov async_memc=
py async_pq async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitou=
ch hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmu=
lni vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi=
 realtek ahci libahci uas usb_storage aesni_intel<br>[ =C2=A0604.271255] CP=
U: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P =C2=A0 =C2=A0 =C2=A0 =
=C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-generic #9-Ubuntu PREEM=
PT(voluntary)<br>[ =C2=A0604.271260] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=
=3DWARN, [O]=3DOOT_MODULE<br>[ =C2=A0604.271260] Hardware name: Dell Inc. I=
nspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0604.271262] Workqueue=
: async async_run_entry_fn<br>[ =C2=A0604.271267] RIP: 0010:amdgpu_irq_put+=
0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.272177] Code: ff 84 c0 75 85 eb 25 44 89 =
ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 =
f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff e=
b a4 e9 8d 14 8d 00 0f<br>[ =C2=A0604.272180] RSP: 0018:ffffd4e34aa37c88 EF=
LAGS: 00010246<br>[ =C2=A0604.272182] RAX: 0000000000000000 RBX: ffff8edc1d=
6ad440 RCX: 0000000000000000<br>[ =C2=A0604.272184] RDX: 0000000000000000 R=
SI: 0000000000000000 RDI: 0000000000000000<br>[ =C2=A0604.272185] RBP: ffff=
d4e34aa37ca8 R08: 0000000000000000 R09: 0000000000000000<br>[ =C2=A0604.272=
186] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1d680000<br>[=
 =C2=A0604.272187] R13: 0000000000000000 R14: 0000000000000002 R15: 0000000=
000000000<br>[ =C2=A0604.272188] FS: =C2=A00000000000000000(0000) GS:ffff8e=
df19670000(0000) knlGS:0000000000000000<br>[ =C2=A0604.272189] CS: =C2=A000=
10 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =C2=A0604.272190] CR2: 0000=
64d8a61373c0 CR3: 0000000123a6b000 CR4: 00000000001506f0<br>[ =C2=A0604.272=
192] Call Trace:<br>[ =C2=A0604.272193] =C2=A0&lt;TASK&gt;<br>[ =C2=A0604.2=
72197] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]<br>[ =C2=A060=
4.273091] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]<br>[ =C2=A0=
604.273992] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]<br>[ =C2=A0604=
.274885] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ =C2=A0604.27577=
4] =C2=A0pci_pm_suspend+0x85/0x1b0<br>[ =C2=A0604.275780] =C2=A0? __pfx_pci=
_pm_suspend+0x10/0x10<br>[ =C2=A0604.275782] =C2=A0dpm_run_callback+0x5f/0x=
160<br>[ =C2=A0604.275786] =C2=A0device_suspend+0x1e4/0x4e0<br>[ =C2=A0604.=
275789] =C2=A0async_suspend+0x21/0x40<br>[ =C2=A0604.275791] =C2=A0async_ru=
n_entry_fn+0x33/0x130<br>[ =C2=A0604.275794] =C2=A0process_one_work+0x18e/0=
x370<br>[ =C2=A0604.275798] =C2=A0worker_thread+0x317/0x450<br>[ =C2=A0604.=
275799] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A0604.275801] =C2=A0=
kthread+0x10b/0x220<br>[ =C2=A0604.275804] =C2=A0? recalc_sigpending+0x76/0=
xb0<br>[ =C2=A0604.275807] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.2=
75809] =C2=A0ret_from_fork+0x134/0x150<br>[ =C2=A0604.275812] =C2=A0? __pfx=
_kthread+0x10/0x10<br>[ =C2=A0604.275814] =C2=A0ret_from_fork_asm+0x1a/0x30=
<br>[ =C2=A0604.275818] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0604.275819] ---[ end=
 trace 0000000000000000 ]---<br>[ =C2=A0604.275870] ------------[ cut here =
]------------<br>[ =C2=A0604.275871] WARNING: CPU: 0 PID: 6585 at drivers/g=
pu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =
=C2=A0604.276783] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus=
 hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qr=
tr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) am=
dgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component sn=
d_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_in=
tel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwde=
p snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event =
ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac=
80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm=
_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd=
_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pl=
atform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick =
dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp d=
ell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn<br>[ =C2=A060=
4.276844] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp msr parport=
_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 ra=
id10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor=
 raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc psmo=
use video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmulni=
_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_stor=
age aesni_intel<br>[ =C2=A0604.276877] CPU: 0 UID: 0 PID: 6585 Comm: kworke=
r/u16:21 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=
=A0 =C2=A06.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br>[ =C2=A0604.2768=
81] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ =
=C2=A0604.276882] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7=
 01/29/2018<br>[ =C2=A0604.276883] Workqueue: async async_run_entry_fn<br>[=
 =C2=A0604.276889] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A06=
04.277807] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc f=
f ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&=
gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ =C2=
=A0604.277810] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246<br>[ =C2=A0604.2=
77812] RAX: 0000000000000000 RBX: ffff8edc1d6ad440 RCX: 0000000000000000<br=
>[ =C2=A0604.277814] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000=
00000000000<br>[ =C2=A0604.277815] RBP: ffffd4e34aa37ca8 R08: 0000000000000=
000 R09: 0000000000000000<br>[ =C2=A0604.277816] R10: 0000000000000000 R11:=
 0000000000000000 R12: ffff8edc1d680000<br>[ =C2=A0604.277817] R13: 0000000=
000000001 R14: 0000000000000002 R15: 0000000000000000<br>[ =C2=A0604.277818=
] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(0000) knlGS:00000000=
00000000<br>[ =C2=A0604.277819] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 00000=
00080050033<br>[ =C2=A0604.277820] CR2: 000064d8a61373c0 CR3: 0000000123a6b=
000 CR4: 00000000001506f0<br>[ =C2=A0604.277822] Call Trace:<br>[ =C2=A0604=
.277823] =C2=A0&lt;TASK&gt;<br>[ =C2=A0604.277827] =C2=A0amdgpu_fence_drive=
r_hw_fini+0x11d/0x160 [amdgpu]<br>[ =C2=A0604.278729] =C2=A0? amdgpu_ttm_ev=
ict_resources+0x39/0x70 [amdgpu]<br>[ =C2=A0604.279624] =C2=A0amdgpu_device=
_suspend+0x10a/0x170 [amdgpu]<br>[ =C2=A0604.280518] =C2=A0amdgpu_pmops_sus=
pend+0x3d/0xe0 [amdgpu]<br>[ =C2=A0604.281407] =C2=A0pci_pm_suspend+0x85/0x=
1b0<br>[ =C2=A0604.281412] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=
=A0604.281415] =C2=A0dpm_run_callback+0x5f/0x160<br>[ =C2=A0604.281419] =C2=
=A0device_suspend+0x1e4/0x4e0<br>[ =C2=A0604.281421] =C2=A0async_suspend+0x=
21/0x40<br>[ =C2=A0604.281423] =C2=A0async_run_entry_fn+0x33/0x130<br>[ =C2=
=A0604.281427] =C2=A0process_one_work+0x18e/0x370<br>[ =C2=A0604.281430] =
=C2=A0worker_thread+0x317/0x450<br>[ =C2=A0604.281432] =C2=A0? __pfx_worker=
_thread+0x10/0x10<br>[ =C2=A0604.281434] =C2=A0kthread+0x10b/0x220<br>[ =C2=
=A0604.281437] =C2=A0? recalc_sigpending+0x76/0xb0<br>[ =C2=A0604.281439] =
=C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.281442] =C2=A0ret_from_fork+=
0x134/0x150<br>[ =C2=A0604.281444] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=
=A0604.281446] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0604.281451] =C2=
=A0&lt;/TASK&gt;<br>[ =C2=A0604.281452] ---[ end trace 0000000000000000 ]--=
-<br>[ =C2=A0604.281510] ------------[ cut here ]------------<br>[ =C2=A060=
4.281511] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_ir=
q.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.282435] Modules li=
nked in: btrfs blake2b_generic ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs=
2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac algif_hash algif_skc=
ipher af_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_hda_codec_alc269 sn=
d_hda_codec_atihdmi snd_hda_scodec_component snd_hda_codec_realtek_lib snd_=
hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_co=
re snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_m=
ce_amd snd_seq_midi kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci k=
vm ath10k_core ath irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_qu=
irks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper dr=
m_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb cf=
g80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore blu=
etooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon spar=
se_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor fam15h_po=
wer i2c_piix4 i2c_smbus dell_rbtn<br>[ =C2=A0604.282494] =C2=A0joydev input=
_leds mac_hid sch_fq_codel ppdev lp msr parport_pc parport efi_pstore nfnet=
link dmi_sysfs autofs4 overlay nls_iso8859_1 raid10 raid456 async_raid6_rec=
ov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 linear=
 hid_multitouch hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi=
 polyval_clmulni vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vga=
state hid wmi realtek ahci libahci uas usb_storage aesni_intel<br>[ =C2=A06=
04.282527] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P =C2=A0 =
=C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-generic #=
9-Ubuntu PREEMPT(voluntary)<br>[ =C2=A0604.282532] Tainted: [P]=3DPROPRIETA=
RY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ =C2=A0604.282533] Hardware nam=
e: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0604.282=
534] Workqueue: async async_run_entry_fn<br>[ =C2=A0604.282540] RIP: 0010:a=
mdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.283454] Code: ff 84 c0 75 8=
5 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5=
d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8=
 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ =C2=A0604.283456] RSP: 0018:ffffd=
4e34aa37c88 EFLAGS: 00010246<br>[ =C2=A0604.283459] RAX: 0000000000000000 R=
BX: ffff8edc1d6adf08 RCX: 0000000000000000<br>[ =C2=A0604.283460] RDX: 0000=
000000000000 RSI: 0000000000000000 RDI: 0000000000000000<br>[ =C2=A0604.283=
461] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 0000000000000000<br>[=
 =C2=A0604.283462] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8ed=
c1d680000<br>[ =C2=A0604.283463] R13: 0000000000000000 R14: 000000000000000=
2 R15: 0000000000000000<br>[ =C2=A0604.283464] FS: =C2=A00000000000000000(0=
000) GS:ffff8edf19670000(0000) knlGS:0000000000000000<br>[ =C2=A0604.283465=
] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =C2=A0604.283=
467] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 00000000001506f0<br>[=
 =C2=A0604.283468] Call Trace:<br>[ =C2=A0604.283469] =C2=A0&lt;TASK&gt;<br=
>[ =C2=A0604.283473] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]=
<br>[ =C2=A0604.284377] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgp=
u]<br>[ =C2=A0604.285266] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]<=
br>[ =C2=A0604.286158] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ =
=C2=A0604.287044] =C2=A0pci_pm_suspend+0x85/0x1b0<br>[ =C2=A0604.287051] =
=C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0604.287054] =C2=A0dpm_run=
_callback+0x5f/0x160<br>[ =C2=A0604.287058] =C2=A0device_suspend+0x1e4/0x4e=
0<br>[ =C2=A0604.287061] =C2=A0async_suspend+0x21/0x40<br>[ =C2=A0604.28706=
3] =C2=A0async_run_entry_fn+0x33/0x130<br>[ =C2=A0604.287066] =C2=A0process=
_one_work+0x18e/0x370<br>[ =C2=A0604.287070] =C2=A0worker_thread+0x317/0x45=
0<br>[ =C2=A0604.287071] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A06=
04.287073] =C2=A0kthread+0x10b/0x220<br>[ =C2=A0604.287076] =C2=A0? recalc_=
sigpending+0x76/0xb0<br>[ =C2=A0604.287079] =C2=A0? __pfx_kthread+0x10/0x10=
<br>[ =C2=A0604.287081] =C2=A0ret_from_fork+0x134/0x150<br>[ =C2=A0604.2870=
84] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.287086] =C2=A0ret_from_f=
ork_asm+0x1a/0x30<br>[ =C2=A0604.287090] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0604=
.287091] ---[ end trace 0000000000000000 ]---<br>[ =C2=A0604.287150] ------=
------[ cut here ]------------<br>[ =C2=A0604.287151] WARNING: CPU: 0 PID: =
6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe=
0 [amdgpu]<br>[ =C2=A0604.288065] Modules linked in: btrfs blake2b_generic =
ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dumm=
y snd_hrtimer qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc z=
fs(PO) spl(O) amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_sco=
dec_component snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_ge=
neric snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_s=
dw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd=
_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass sn=
d_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_tt=
m_helper ttm drm_exec drm_suballoc_helper drm_display_helper cec rc_core sn=
d_seq_device snd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm bt=
intel libarc4 platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop =
ee1004 memstick dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios =
dcdbas k10temp dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rb=
tn<br>[ =C2=A0604.288124] =C2=A0joydev input_leds mac_hid sch_fq_codel ppde=
v lp msr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay =
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_=
xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rts=
x_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_u=
sb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci liba=
hci uas usb_storage aesni_intel<br>[ =C2=A0604.288157] CPU: 0 UID: 0 PID: 6=
585 Comm: kworker/u16:21 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =
=C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br=
>[ =C2=A0604.288161] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DO=
OT_MODULE<br>[ =C2=A0604.288162] Hardware name: Dell Inc. Inspiron 5576/0JW=
8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0604.288163] Workqueue: async async_ru=
n_entry_fn<br>[ =C2=A0604.288168] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgp=
u]<br>[ =C2=A0604.289092] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 8=
9 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec c=
d 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d=
 00 0f<br>[ =C2=A0604.289095] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246<b=
r>[ =C2=A0604.289097] RAX: 0000000000000000 RBX: ffff8edc1d6adf08 RCX: 0000=
000000000000<br>[ =C2=A0604.289099] RDX: 0000000000000000 RSI: 000000000000=
0000 RDI: 0000000000000000<br>[ =C2=A0604.289100] RBP: ffffd4e34aa37ca8 R08=
: 0000000000000000 R09: 0000000000000000<br>[ =C2=A0604.289101] R10: 000000=
0000000000 R11: 0000000000000000 R12: ffff8edc1d680000<br>[ =C2=A0604.28910=
2] R13: 0000000000000000 R14: 0000000000000002 R15: 0000000000000000<br>[ =
=C2=A0604.289104] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(0000=
) knlGS:0000000000000000<br>[ =C2=A0604.289105] CS: =C2=A00010 DS: 0000 ES:=
 0000 CR0: 0000000080050033<br>[ =C2=A0604.289106] CR2: 000064d8a61373c0 CR=
3: 0000000123a6b000 CR4: 00000000001506f0<br>[ =C2=A0604.289108] Call Trace=
:<br>[ =C2=A0604.289109] =C2=A0&lt;TASK&gt;<br>[ =C2=A0604.289113] =C2=A0am=
dgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]<br>[ =C2=A0604.290008] =C2=
=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]<br>[ =C2=A0604.290898] =
=C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]<br>[ =C2=A0604.291804] =C2=
=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ =C2=A0604.292693] =C2=A0pci=
_pm_suspend+0x85/0x1b0<br>[ =C2=A0604.292700] =C2=A0? __pfx_pci_pm_suspend+=
0x10/0x10<br>[ =C2=A0604.292703] =C2=A0dpm_run_callback+0x5f/0x160<br>[ =C2=
=A0604.292707] =C2=A0device_suspend+0x1e4/0x4e0<br>[ =C2=A0604.292710] =C2=
=A0async_suspend+0x21/0x40<br>[ =C2=A0604.292712] =C2=A0async_run_entry_fn+=
0x33/0x130<br>[ =C2=A0604.292715] =C2=A0process_one_work+0x18e/0x370<br>[ =
=C2=A0604.292718] =C2=A0worker_thread+0x317/0x450<br>[ =C2=A0604.292720] =
=C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A0604.292722] =C2=A0kthread+=
0x10b/0x220<br>[ =C2=A0604.292725] =C2=A0? recalc_sigpending+0x76/0xb0<br>[=
 =C2=A0604.292727] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.292730] =
=C2=A0ret_from_fork+0x134/0x150<br>[ =C2=A0604.292732] =C2=A0? __pfx_kthrea=
d+0x10/0x10<br>[ =C2=A0604.292735] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =
=C2=A0604.292739] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0604.292740] ---[ end trace=
 0000000000000000 ]---<br>[ =C2=A0604.292797] ------------[ cut here ]-----=
-------<br>[ =C2=A0604.292798] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm=
/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A06=
04.293717] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus hfs mi=
nix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac=
 algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu sn=
d_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd_hda_c=
odec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd=
_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_p=
cm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event ccp snd=
_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac80211 d=
rm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec d=
rm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_timer =
i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_=
profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wm=
i dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi=
_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn<br>[ =C2=A0604.29377=
6] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp msr parport_pc par=
port efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 raid10 ra=
id456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_=
pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc psmouse vid=
eo r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmulni_intel =
serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_storage aes=
ni_intel<br>[ =C2=A0604.293809] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:2=
1 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=
=A06.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br>[ =C2=A0604.293813] Tai=
nted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ =C2=A0604=
.293814] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/20=
18<br>[ =C2=A0604.293816] Workqueue: async async_run_entry_fn<br>[ =C2=A060=
4.293821] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.294743=
] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 8=
3 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8=
 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ =C2=A0604.29=
4746] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246<br>[ =C2=A0604.294749] RA=
X: 0000000000000000 RBX: ffff8edc1d6adf08 RCX: 0000000000000000<br>[ =C2=A0=
604.294750] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000=
00<br>[ =C2=A0604.294751] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: =
0000000000000000<br>[ =C2=A0604.294752] R10: 0000000000000000 R11: 00000000=
00000000 R12: ffff8edc1d680000<br>[ =C2=A0604.294753] R13: 0000000000000000=
 R14: 0000000000000002 R15: 0000000000000000<br>[ =C2=A0604.294754] FS: =C2=
=A00000000000000000(0000) GS:ffff8edf19670000(0000) knlGS:0000000000000000<=
br>[ =C2=A0604.294756] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 00000000800500=
33<br>[ =C2=A0604.294757] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: =
00000000001506f0<br>[ =C2=A0604.294758] Call Trace:<br>[ =C2=A0604.294759] =
=C2=A0&lt;TASK&gt;<br>[ =C2=A0604.294763] =C2=A0amdgpu_fence_driver_hw_fini=
+0x11d/0x160 [amdgpu]<br>[ =C2=A0604.295655] =C2=A0? amdgpu_ttm_evict_resou=
rces+0x39/0x70 [amdgpu]<br>[ =C2=A0604.296554] =C2=A0amdgpu_device_suspend+=
0x10a/0x170 [amdgpu]<br>[ =C2=A0604.297444] =C2=A0amdgpu_pmops_suspend+0x3d=
/0xe0 [amdgpu]<br>[ =C2=A0604.298317] =C2=A0pci_pm_suspend+0x85/0x1b0<br>[ =
=C2=A0604.298321] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0604.298=
324] =C2=A0dpm_run_callback+0x5f/0x160<br>[ =C2=A0604.298328] =C2=A0device_=
suspend+0x1e4/0x4e0<br>[ =C2=A0604.298331] =C2=A0async_suspend+0x21/0x40<br=
>[ =C2=A0604.298333] =C2=A0async_run_entry_fn+0x33/0x130<br>[ =C2=A0604.298=
336] =C2=A0process_one_work+0x18e/0x370<br>[ =C2=A0604.298339] =C2=A0worker=
_thread+0x317/0x450<br>[ =C2=A0604.298341] =C2=A0? __pfx_worker_thread+0x10=
/0x10<br>[ =C2=A0604.298343] =C2=A0kthread+0x10b/0x220<br>[ =C2=A0604.29834=
6] =C2=A0? recalc_sigpending+0x76/0xb0<br>[ =C2=A0604.298349] =C2=A0? __pfx=
_kthread+0x10/0x10<br>[ =C2=A0604.298351] =C2=A0ret_from_fork+0x134/0x150<b=
r>[ =C2=A0604.298353] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.298366=
] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0604.298372] =C2=A0&lt;/TASK&=
gt;<br>[ =C2=A0604.298373] ---[ end trace 0000000000000000 ]---<br>[ =C2=A0=
604.298431] ------------[ cut here ]------------<br>[ =C2=A0604.298432] WAR=
NING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgp=
u_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.299345] Modules linked in: btrf=
s blake2b_generic ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs2_utils xfs r=
fcomm snd_seq_dummy snd_hrtimer qrtr cmac algif_hash algif_skcipher af_alg =
bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_hda_codec_alc269 snd_hda_codec_a=
tihdmi snd_hda_scodec_component snd_hda_codec_realtek_lib snd_hda_codec_hdm=
i snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_intel_=
dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_se=
q_midi kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_cor=
e ath irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sche=
d drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper drm_display_hel=
per cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb cfg80211 snd bt=
mtk btrtl btbcm btintel libarc4 platform_profile soundcore bluetooth rtsx_u=
sb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon sparse_keymap wmi=
_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor fam15h_power i2c_piix4=
 i2c_smbus dell_rbtn<br>[ =C2=A0604.299415] =C2=A0joydev input_leds mac_hid=
 sch_fq_codel ppdev lp msr parport_pc parport efi_pstore nfnetlink dmi_sysf=
s autofs4 overlay nls_iso8859_1 raid10 raid456 async_raid6_recov async_memc=
py async_pq async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitou=
ch hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmu=
lni vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi=
 realtek ahci libahci uas usb_storage aesni_intel<br>[ =C2=A0604.299448] CP=
U: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P =C2=A0 =C2=A0 =C2=A0 =
=C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-generic #9-Ubuntu PREEM=
PT(voluntary)<br>[ =C2=A0604.299452] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=
=3DWARN, [O]=3DOOT_MODULE<br>[ =C2=A0604.299453] Hardware name: Dell Inc. I=
nspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0604.299454] Workqueue=
: async async_run_entry_fn<br>[ =C2=A0604.299459] RIP: 0010:amdgpu_irq_put+=
0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.300382] Code: ff 84 c0 75 85 eb 25 44 89 =
ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 =
f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff e=
b a4 e9 8d 14 8d 00 0f<br>[ =C2=A0604.300385] RSP: 0018:ffffd4e34aa37c88 EF=
LAGS: 00010246<br>[ =C2=A0604.300388] RAX: 0000000000000000 RBX: ffff8edc1d=
6af6f8 RCX: 0000000000000000<br>[ =C2=A0604.300389] RDX: 0000000000000000 R=
SI: 0000000000000000 RDI: 0000000000000000<br>[ =C2=A0604.300390] RBP: ffff=
d4e34aa37ca8 R08: 0000000000000000 R09: 0000000000000000<br>[ =C2=A0604.300=
392] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1d680000<br>[=
 =C2=A0604.300393] R13: 0000000000000000 R14: 0000000000000002 R15: 0000000=
000000000<br>[ =C2=A0604.300394] FS: =C2=A00000000000000000(0000) GS:ffff8e=
df19670000(0000) knlGS:0000000000000000<br>[ =C2=A0604.300395] CS: =C2=A000=
10 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =C2=A0604.300396] CR2: 0000=
64d8a61373c0 CR3: 0000000123a6b000 CR4: 00000000001506f0<br>[ =C2=A0604.300=
398] Call Trace:<br>[ =C2=A0604.300399] =C2=A0&lt;TASK&gt;<br>[ =C2=A0604.3=
00403] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]<br>[ =C2=A060=
4.301294] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]<br>[ =C2=A0=
604.302194] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]<br>[ =C2=A0604=
.303113] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ =C2=A0604.30409=
2] =C2=A0pci_pm_suspend+0x85/0x1b0<br>[ =C2=A0604.304098] =C2=A0? __pfx_pci=
_pm_suspend+0x10/0x10<br>[ =C2=A0604.304100] =C2=A0dpm_run_callback+0x5f/0x=
160<br>[ =C2=A0604.304104] =C2=A0device_suspend+0x1e4/0x4e0<br>[ =C2=A0604.=
304107] =C2=A0async_suspend+0x21/0x40<br>[ =C2=A0604.304109] =C2=A0async_ru=
n_entry_fn+0x33/0x130<br>[ =C2=A0604.304112] =C2=A0process_one_work+0x18e/0=
x370<br>[ =C2=A0604.304116] =C2=A0worker_thread+0x317/0x450<br>[ =C2=A0604.=
304117] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A0604.304119] =C2=A0=
kthread+0x10b/0x220<br>[ =C2=A0604.304122] =C2=A0? recalc_sigpending+0x76/0=
xb0<br>[ =C2=A0604.304125] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.3=
04127] =C2=A0ret_from_fork+0x134/0x150<br>[ =C2=A0604.304130] =C2=A0? __pfx=
_kthread+0x10/0x10<br>[ =C2=A0604.304132] =C2=A0ret_from_fork_asm+0x1a/0x30=
<br>[ =C2=A0604.304137] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0604.304138] ---[ end=
 trace 0000000000000000 ]---<br>[ =C2=A0604.304195] ------------[ cut here =
]------------<br>[ =C2=A0604.304196] WARNING: CPU: 0 PID: 6585 at drivers/g=
pu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =
=C2=A0604.305131] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus=
 hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qr=
tr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) am=
dgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component sn=
d_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_in=
tel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwde=
p snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event =
ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac=
80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm=
_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd=
_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pl=
atform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick =
dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp d=
ell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn<br>[ =C2=A060=
4.305192] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp msr parport=
_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 ra=
id10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor=
 raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc psmo=
use video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmulni=
_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_stor=
age aesni_intel<br>[ =C2=A0604.305227] CPU: 0 UID: 0 PID: 6585 Comm: kworke=
r/u16:21 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=
=A0 =C2=A06.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br>[ =C2=A0604.3052=
31] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ =
=C2=A0604.305232] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7=
 01/29/2018<br>[ =C2=A0604.305233] Workqueue: async async_run_entry_fn<br>[=
 =C2=A0604.305239] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A06=
04.306233] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc f=
f ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&=
gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ =C2=
=A0604.306236] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246<br>[ =C2=A0604.3=
06238] RAX: 0000000000000000 RBX: ffff8edc1d6af6f8 RCX: 0000000000000000<br=
>[ =C2=A0604.306240] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000=
00000000000<br>[ =C2=A0604.306241] RBP: ffffd4e34aa37ca8 R08: 0000000000000=
000 R09: 0000000000000000<br>[ =C2=A0604.306242] R10: 0000000000000000 R11:=
 0000000000000000 R12: ffff8edc1d680000<br>[ =C2=A0604.306243] R13: 0000000=
000000000 R14: 0000000000000002 R15: 0000000000000000<br>[ =C2=A0604.306244=
] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(0000) knlGS:00000000=
00000000<br>[ =C2=A0604.306245] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 00000=
00080050033<br>[ =C2=A0604.306246] CR2: 000064d8a61373c0 CR3: 0000000123a6b=
000 CR4: 00000000001506f0<br>[ =C2=A0604.306248] Call Trace:<br>[ =C2=A0604=
.306249] =C2=A0&lt;TASK&gt;<br>[ =C2=A0604.306253] =C2=A0amdgpu_fence_drive=
r_hw_fini+0x11d/0x160 [amdgpu]<br>[ =C2=A0604.307150] =C2=A0? amdgpu_ttm_ev=
ict_resources+0x39/0x70 [amdgpu]<br>[ =C2=A0604.308044] =C2=A0amdgpu_device=
_suspend+0x10a/0x170 [amdgpu]<br>[ =C2=A0604.308934] =C2=A0amdgpu_pmops_sus=
pend+0x3d/0xe0 [amdgpu]<br>[ =C2=A0604.309814] =C2=A0pci_pm_suspend+0x85/0x=
1b0<br>[ =C2=A0604.309819] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=
=A0604.309822] =C2=A0dpm_run_callback+0x5f/0x160<br>[ =C2=A0604.309826] =C2=
=A0device_suspend+0x1e4/0x4e0<br>[ =C2=A0604.309828] =C2=A0async_suspend+0x=
21/0x40<br>[ =C2=A0604.309830] =C2=A0async_run_entry_fn+0x33/0x130<br>[ =C2=
=A0604.309834] =C2=A0process_one_work+0x18e/0x370<br>[ =C2=A0604.309837] =
=C2=A0worker_thread+0x317/0x450<br>[ =C2=A0604.309839] =C2=A0? __pfx_worker=
_thread+0x10/0x10<br>[ =C2=A0604.309841] =C2=A0kthread+0x10b/0x220<br>[ =C2=
=A0604.309844] =C2=A0? recalc_sigpending+0x76/0xb0<br>[ =C2=A0604.309846] =
=C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.309848] =C2=A0ret_from_fork+=
0x134/0x150<br>[ =C2=A0604.309851] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=
=A0604.309853] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0604.309858] =C2=
=A0&lt;/TASK&gt;<br>[ =C2=A0604.309859] ---[ end trace 0000000000000000 ]--=
-<br>[ =C2=A0604.309916] ------------[ cut here ]------------<br>[ =C2=A060=
4.309917] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_ir=
q.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.310833] Modules li=
nked in: btrfs blake2b_generic ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs=
2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac algif_hash algif_skc=
ipher af_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_hda_codec_alc269 sn=
d_hda_codec_atihdmi snd_hda_scodec_component snd_hda_codec_realtek_lib snd_=
hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_co=
re snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_m=
ce_amd snd_seq_midi kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci k=
vm ath10k_core ath irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_qu=
irks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper dr=
m_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb cf=
g80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore blu=
etooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon spar=
se_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor fam15h_po=
wer i2c_piix4 i2c_smbus dell_rbtn<br>[ =C2=A0604.310893] =C2=A0joydev input=
_leds mac_hid sch_fq_codel ppdev lp msr parport_pc parport efi_pstore nfnet=
link dmi_sysfs autofs4 overlay nls_iso8859_1 raid10 raid456 async_raid6_rec=
ov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 linear=
 hid_multitouch hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi=
 polyval_clmulni vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vga=
state hid wmi realtek ahci libahci uas usb_storage aesni_intel<br>[ =C2=A06=
04.310926] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P =C2=A0 =
=C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-generic #=
9-Ubuntu PREEMPT(voluntary)<br>[ =C2=A0604.310930] Tainted: [P]=3DPROPRIETA=
RY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ =C2=A0604.310931] Hardware nam=
e: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0604.310=
932] Workqueue: async async_run_entry_fn<br>[ =C2=A0604.310937] RIP: 0010:a=
mdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.311850] Code: ff 84 c0 75 8=
5 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5=
d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8=
 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ =C2=A0604.311853] RSP: 0018:ffffd=
4e34aa37c88 EFLAGS: 00010246<br>[ =C2=A0604.311855] RAX: 0000000000000000 R=
BX: ffff8edc1d6af6f8 RCX: 0000000000000000<br>[ =C2=A0604.311856] RDX: 0000=
000000000000 RSI: 0000000000000000 RDI: 0000000000000000<br>[ =C2=A0604.311=
857] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 0000000000000000<br>[=
 =C2=A0604.311858] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8ed=
c1d680000<br>[ =C2=A0604.311859] R13: 0000000000000000 R14: 000000000000000=
2 R15: 0000000000000000<br>[ =C2=A0604.311860] FS: =C2=A00000000000000000(0=
000) GS:ffff8edf19670000(0000) knlGS:0000000000000000<br>[ =C2=A0604.311862=
] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =C2=A0604.311=
863] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 00000000001506f0<br>[=
 =C2=A0604.311864] Call Trace:<br>[ =C2=A0604.311866] =C2=A0&lt;TASK&gt;<br=
>[ =C2=A0604.311869] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]=
<br>[ =C2=A0604.312766] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgp=
u]<br>[ =C2=A0604.313662] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]<=
br>[ =C2=A0604.314562] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ =
=C2=A0604.315452] =C2=A0pci_pm_suspend+0x85/0x1b0<br>[ =C2=A0604.315457] =
=C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0604.315460] =C2=A0dpm_run=
_callback+0x5f/0x160<br>[ =C2=A0604.315464] =C2=A0device_suspend+0x1e4/0x4e=
0<br>[ =C2=A0604.315466] =C2=A0async_suspend+0x21/0x40<br>[ =C2=A0604.31546=
8] =C2=A0async_run_entry_fn+0x33/0x130<br>[ =C2=A0604.315472] =C2=A0process=
_one_work+0x18e/0x370<br>[ =C2=A0604.315475] =C2=A0worker_thread+0x317/0x45=
0<br>[ =C2=A0604.315477] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A06=
04.315478] =C2=A0kthread+0x10b/0x220<br>[ =C2=A0604.315481] =C2=A0? recalc_=
sigpending+0x76/0xb0<br>[ =C2=A0604.315483] =C2=A0? __pfx_kthread+0x10/0x10=
<br>[ =C2=A0604.315486] =C2=A0ret_from_fork+0x134/0x150<br>[ =C2=A0604.3154=
89] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.315491] =C2=A0ret_from_f=
ork_asm+0x1a/0x30<br>[ =C2=A0604.315495] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0604=
.315497] ---[ end trace 0000000000000000 ]---<br>[ =C2=A0604.330697] ------=
------[ cut here ]------------<br>[ =C2=A0604.330700] WARNING: CPU: 1 PID: =
6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe=
0 [amdgpu]<br>[ =C2=A0604.331627] Modules linked in: btrfs blake2b_generic =
ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dumm=
y snd_hrtimer qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc z=
fs(PO) spl(O) amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_sco=
dec_component snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_ge=
neric snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_s=
dw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd=
_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass sn=
d_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_tt=
m_helper ttm drm_exec drm_suballoc_helper drm_display_helper cec rc_core sn=
d_seq_device snd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm bt=
intel libarc4 platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop =
ee1004 memstick dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios =
dcdbas k10temp dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rb=
tn<br>[ =C2=A0604.331689] =C2=A0joydev input_leds mac_hid sch_fq_codel ppde=
v lp msr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay =
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_=
xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rts=
x_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_u=
sb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci liba=
hci uas usb_storage aesni_intel<br>[ =C2=A0604.331725] CPU: 1 UID: 0 PID: 6=
585 Comm: kworker/u16:21 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =
=C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br=
>[ =C2=A0604.331730] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DO=
OT_MODULE<br>[ =C2=A0604.331730] Hardware name: Dell Inc. Inspiron 5576/0JW=
8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0604.331732] Workqueue: async async_ru=
n_entry_fn<br>[ =C2=A0604.331739] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgp=
u]<br>[ =C2=A0604.332660] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 8=
9 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec c=
d 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d=
 00 0f<br>[ =C2=A0604.332662] RSP: 0018:ffffd4e34aa37c30 EFLAGS: 00010246<b=
r>[ =C2=A0604.332665] RAX: 0000000000000000 RBX: ffff8edc1d6a5a38 RCX: 0000=
000000000000<br>[ =C2=A0604.332666] RDX: 0000000000000000 RSI: 000000000000=
0000 RDI: 0000000000000000<br>[ =C2=A0604.332667] RBP: ffffd4e34aa37c50 R08=
: 0000000000000000 R09: 0000000000000000<br>[ =C2=A0604.332668] R10: 000000=
0000000000 R11: 0000000000000000 R12: ffff8edc1d680000<br>[ =C2=A0604.33266=
9] R13: 0000000000000000 R14: ffff8edc1d6d0d88 R15: ffff8edc1d680000<br>[ =
=C2=A0604.332671] FS: =C2=A00000000000000000(0000) GS:ffff8edf196f0000(0000=
) knlGS:0000000000000000<br>[ =C2=A0604.332672] CS: =C2=A00010 DS: 0000 ES:=
 0000 CR0: 0000000080050033<br>[ =C2=A0604.332673] CR2: 00005f77b6a8f7d0 CR=
3: 0000000123a6b000 CR4: 00000000001506f0<br>[ =C2=A0604.332675] Call Trace=
:<br>[ =C2=A0604.332676] =C2=A0&lt;TASK&gt;<br>[ =C2=A0604.332681] =C2=A0gf=
x_v8_0_hw_fini+0x2a/0x3a0 [amdgpu]<br>[ =C2=A0604.333595] =C2=A0gfx_v8_0_su=
spend+0xe/0x20 [amdgpu]<br>[ =C2=A0604.334511] =C2=A0amdgpu_ip_block_suspen=
d+0x27/0x60 [amdgpu]<br>[ =C2=A0604.335403] =C2=A0amdgpu_device_ip_suspend_=
phase2+0x1bc/0x3c0 [amdgpu]<br>[ =C2=A0604.336277] =C2=A0amdgpu_device_susp=
end+0x113/0x170 [amdgpu]<br>[ =C2=A0604.337160] =C2=A0amdgpu_pmops_suspend+=
0x3d/0xe0 [amdgpu]<br>[ =C2=A0604.338049] =C2=A0pci_pm_suspend+0x85/0x1b0<b=
r>[ =C2=A0604.338054] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0604=
.338056] =C2=A0dpm_run_callback+0x5f/0x160<br>[ =C2=A0604.338060] =C2=A0dev=
ice_suspend+0x1e4/0x4e0<br>[ =C2=A0604.338063] =C2=A0async_suspend+0x21/0x4=
0<br>[ =C2=A0604.338065] =C2=A0async_run_entry_fn+0x33/0x130<br>[ =C2=A0604=
.338069] =C2=A0process_one_work+0x18e/0x370<br>[ =C2=A0604.338072] =C2=A0wo=
rker_thread+0x317/0x450<br>[ =C2=A0604.338074] =C2=A0? __pfx_worker_thread+=
0x10/0x10<br>[ =C2=A0604.338075] =C2=A0kthread+0x10b/0x220<br>[ =C2=A0604.3=
38078] =C2=A0? recalc_sigpending+0x76/0xb0<br>[ =C2=A0604.338081] =C2=A0? _=
_pfx_kthread+0x10/0x10<br>[ =C2=A0604.338083] =C2=A0ret_from_fork+0x134/0x1=
50<br>[ =C2=A0604.338086] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.33=
8088] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0604.338092] =C2=A0&lt;/T=
ASK&gt;<br>[ =C2=A0604.338093] ---[ end trace 0000000000000000 ]---<br>[ =
=C2=A0604.338150] ------------[ cut here ]------------<br>[ =C2=A0604.33815=
1] WARNING: CPU: 1 PID: 6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639=
 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.339074] Modules linked in=
: btrfs blake2b_generic ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs2_utils=
 xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac algif_hash algif_skcipher a=
f_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_hda_codec_alc269 snd_hda_c=
odec_atihdmi snd_hda_scodec_component snd_hda_codec_realtek_lib snd_hda_cod=
ec_hdmi snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_=
intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd =
snd_seq_midi kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath1=
0k_core ath irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gp=
u_sched drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper drm_displ=
ay_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb cfg80211 =
snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore bluetooth =
rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon sparse_keym=
ap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor fam15h_power i2c=
_piix4 i2c_smbus dell_rbtn<br>[ =C2=A0604.339132] =C2=A0joydev input_leds m=
ac_hid sch_fq_codel ppdev lp msr parport_pc parport efi_pstore nfnetlink dm=
i_sysfs autofs4 overlay nls_iso8859_1 raid10 raid456 async_raid6_recov asyn=
c_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 linear hid_mu=
ltitouch hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyva=
l_clmulni vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate h=
id wmi realtek ahci libahci uas usb_storage aesni_intel<br>[ =C2=A0604.3391=
65] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P =C2=A0 =C2=A0 =
=C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-generic #9-Ubunt=
u PREEMPT(voluntary)<br>[ =C2=A0604.339169] Tainted: [P]=3DPROPRIETARY_MODU=
LE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ =C2=A0604.339170] Hardware name: Dell=
 Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0604.339171] Wo=
rkqueue: async async_run_entry_fn<br>[ =C2=A0604.339176] RIP: 0010:amdgpu_i=
rq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.340096] Code: ff 84 c0 75 85 eb 25=
 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31=
 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe ff =
ff ff eb a4 e9 8d 14 8d 00 0f<br>[ =C2=A0604.340098] RSP: 0018:ffffd4e34aa3=
7c30 EFLAGS: 00010246<br>[ =C2=A0604.340101] RAX: 0000000000000000 RBX: fff=
f8edc1d6a5a50 RCX: 0000000000000000<br>[ =C2=A0604.340102] RDX: 00000000000=
00000 RSI: 0000000000000000 RDI: 0000000000000000<br>[ =C2=A0604.340103] RB=
P: ffffd4e34aa37c50 R08: 0000000000000000 R09: 0000000000000000<br>[ =C2=A0=
604.340104] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1d6800=
00<br>[ =C2=A0604.340105] R13: 0000000000000000 R14: ffff8edc1d6d0d88 R15: =
ffff8edc1d680000<br>[ =C2=A0604.340106] FS: =C2=A00000000000000000(0000) GS=
:ffff8edf196f0000(0000) knlGS:0000000000000000<br>[ =C2=A0604.340108] CS: =
=C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =C2=A0604.340109] C=
R2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4: 00000000001506f0<br>[ =C2=
=A0604.340111] Call Trace:<br>[ =C2=A0604.340112] =C2=A0&lt;TASK&gt;<br>[ =
=C2=A0604.340115] =C2=A0gfx_v8_0_hw_fini+0x3b/0x3a0 [amdgpu]<br>[ =C2=A0604=
.341033] =C2=A0gfx_v8_0_suspend+0xe/0x20 [amdgpu]<br>[ =C2=A0604.341948] =
=C2=A0amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]<br>[ =C2=A0604.342836] =C2=
=A0amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdgpu]<br>[ =C2=A0604.3437=
23] =C2=A0amdgpu_device_suspend+0x113/0x170 [amdgpu]<br>[ =C2=A0604.344619]=
 =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ =C2=A0604.345520] =C2=
=A0pci_pm_suspend+0x85/0x1b0<br>[ =C2=A0604.345526] =C2=A0? __pfx_pci_pm_su=
spend+0x10/0x10<br>[ =C2=A0604.345529] =C2=A0dpm_run_callback+0x5f/0x160<br=
>[ =C2=A0604.345533] =C2=A0device_suspend+0x1e4/0x4e0<br>[ =C2=A0604.345535=
] =C2=A0async_suspend+0x21/0x40<br>[ =C2=A0604.345538] =C2=A0async_run_entr=
y_fn+0x33/0x130<br>[ =C2=A0604.345541] =C2=A0process_one_work+0x18e/0x370<b=
r>[ =C2=A0604.345545] =C2=A0worker_thread+0x317/0x450<br>[ =C2=A0604.345546=
] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A0604.345548] =C2=A0kthrea=
d+0x10b/0x220<br>[ =C2=A0604.345551] =C2=A0? recalc_sigpending+0x76/0xb0<br=
>[ =C2=A0604.345553] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.345556]=
 =C2=A0ret_from_fork+0x134/0x150<br>[ =C2=A0604.345558] =C2=A0? __pfx_kthre=
ad+0x10/0x10<br>[ =C2=A0604.345561] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =
=C2=A0604.345565] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0604.345566] ---[ end trace=
 0000000000000000 ]---<br>[ =C2=A0604.345618] ------------[ cut here ]-----=
-------<br>[ =C2=A0604.345619] WARNING: CPU: 1 PID: 6585 at drivers/gpu/drm=
/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A06=
04.346540] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus hfs mi=
nix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac=
 algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu sn=
d_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd_hda_c=
odec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd=
_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_p=
cm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event ccp snd=
_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac80211 d=
rm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec d=
rm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_timer =
i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_=
profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wm=
i dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi=
_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn<br>[ =C2=A0604.34659=
8] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp msr parport_pc par=
port efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 raid10 ra=
id456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_=
pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc psmouse vid=
eo r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmulni_intel =
serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_storage aes=
ni_intel<br>[ =C2=A0604.346631] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:2=
1 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=
=A06.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br>[ =C2=A0604.346636] Tai=
nted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ =C2=A0604=
.346636] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/20=
18<br>[ =C2=A0604.346638] Workqueue: async async_run_entry_fn<br>[ =C2=A060=
4.346643] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A0604.347566=
] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 8=
3 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8=
 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ =C2=A0604.34=
7568] RSP: 0018:ffffd4e34aa37c30 EFLAGS: 00010246<br>[ =C2=A0604.347571] RA=
X: 0000000000000000 RBX: ffff8edc1d6a5a80 RCX: 0000000000000000<br>[ =C2=A0=
604.347572] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000=
00<br>[ =C2=A0604.347573] RBP: ffffd4e34aa37c50 R08: 0000000000000000 R09: =
0000000000000000<br>[ =C2=A0604.347574] R10: 0000000000000000 R11: 00000000=
00000000 R12: ffff8edc1d680000<br>[ =C2=A0604.347575] R13: 0000000000000000=
 R14: ffff8edc1d6d0d88 R15: ffff8edc1d680000<br>[ =C2=A0604.347577] FS: =C2=
=A00000000000000000(0000) GS:ffff8edf196f0000(0000) knlGS:0000000000000000<=
br>[ =C2=A0604.347578] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 00000000800500=
33<br>[ =C2=A0604.347579] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4: =
00000000001506f0<br>[ =C2=A0604.347581] Call Trace:<br>[ =C2=A0604.347582] =
=C2=A0&lt;TASK&gt;<br>[ =C2=A0604.347586] =C2=A0gfx_v8_0_hw_fini+0x4c/0x3a0=
 [amdgpu]<br>[ =C2=A0604.348508] =C2=A0gfx_v8_0_suspend+0xe/0x20 [amdgpu]<b=
r>[ =C2=A0604.349417] =C2=A0amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]<br>[=
 =C2=A0604.350300] =C2=A0amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdgp=
u]<br>[ =C2=A0604.351188] =C2=A0amdgpu_device_suspend+0x113/0x170 [amdgpu]<=
br>[ =C2=A0604.352081] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ =
=C2=A0604.352969] =C2=A0pci_pm_suspend+0x85/0x1b0<br>[ =C2=A0604.352975] =
=C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0604.352977] =C2=A0dpm_run=
_callback+0x5f/0x160<br>[ =C2=A0604.352981] =C2=A0device_suspend+0x1e4/0x4e=
0<br>[ =C2=A0604.352984] =C2=A0async_suspend+0x21/0x40<br>[ =C2=A0604.35298=
6] =C2=A0async_run_entry_fn+0x33/0x130<br>[ =C2=A0604.352989] =C2=A0process=
_one_work+0x18e/0x370<br>[ =C2=A0604.352993] =C2=A0worker_thread+0x317/0x45=
0<br>[ =C2=A0604.352994] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A06=
04.352996] =C2=A0kthread+0x10b/0x220<br>[ =C2=A0604.352999] =C2=A0? recalc_=
sigpending+0x76/0xb0<br>[ =C2=A0604.353002] =C2=A0? __pfx_kthread+0x10/0x10=
<br>[ =C2=A0604.353004] =C2=A0ret_from_fork+0x134/0x150<br>[ =C2=A0604.3530=
07] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.353009] =C2=A0ret_from_f=
ork_asm+0x1a/0x30<br>[ =C2=A0604.353013] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0604=
.353014] ---[ end trace 0000000000000000 ]---<br>[ =C2=A0604.353064] ------=
------[ cut here ]------------<br>[ =C2=A0604.353064] WARNING: CPU: 1 PID: =
6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe=
0 [amdgpu]<br>[ =C2=A0604.353984] Modules linked in: btrfs blake2b_generic =
ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dumm=
y snd_hrtimer qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc z=
fs(PO) spl(O) amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_sco=
dec_component snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_ge=
neric snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_s=
dw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd=
_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass sn=
d_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_tt=
m_helper ttm drm_exec drm_suballoc_helper drm_display_helper cec rc_core sn=
d_seq_device snd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm bt=
intel libarc4 platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop =
ee1004 memstick dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios =
dcdbas k10temp dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rb=
tn<br>[ =C2=A0604.354042] =C2=A0joydev input_leds mac_hid sch_fq_codel ppde=
v lp msr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay =
nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_=
xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rts=
x_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_u=
sb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci liba=
hci uas usb_storage aesni_intel<br>[ =C2=A0604.354074] CPU: 1 UID: 0 PID: 6=
585 Comm: kworker/u16:21 Tainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =
=C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br=
>[ =C2=A0604.354078] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DO=
OT_MODULE<br>[ =C2=A0604.354079] Hardware name: Dell Inc. Inspiron 5576/0JW=
8XC, BIOS 1.0.7 01/29/2018<br>[ =C2=A0604.354081] Workqueue: async async_ru=
n_entry_fn<br>[ =C2=A0604.354086] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgp=
u]<br>[ =C2=A0604.355008] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 8=
9 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec c=
d 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d=
 00 0f<br>[ =C2=A0604.355010] RSP: 0018:ffffd4e34aa37c30 EFLAGS: 00010246<b=
r>[ =C2=A0604.355013] RAX: 0000000000000000 RBX: ffff8edc1d6a5a98 RCX: 0000=
000000000000<br>[ =C2=A0604.355014] RDX: 0000000000000000 RSI: 000000000000=
0000 RDI: 0000000000000000<br>[ =C2=A0604.355015] RBP: ffffd4e34aa37c50 R08=
: 0000000000000000 R09: 0000000000000000<br>[ =C2=A0604.355016] R10: 000000=
0000000000 R11: 0000000000000000 R12: ffff8edc1d680000<br>[ =C2=A0604.35501=
7] R13: 0000000000000000 R14: ffff8edc1d6d0d88 R15: ffff8edc1d680000<br>[ =
=C2=A0604.355018] FS: =C2=A00000000000000000(0000) GS:ffff8edf196f0000(0000=
) knlGS:0000000000000000<br>[ =C2=A0604.355019] CS: =C2=A00010 DS: 0000 ES:=
 0000 CR0: 0000000080050033<br>[ =C2=A0604.355021] CR2: 00005f77b6a8f7d0 CR=
3: 0000000123a6b000 CR4: 00000000001506f0<br>[ =C2=A0604.355022] Call Trace=
:<br>[ =C2=A0604.355023] =C2=A0&lt;TASK&gt;<br>[ =C2=A0604.355027] =C2=A0gf=
x_v8_0_hw_fini+0x5d/0x3a0 [amdgpu]<br>[ =C2=A0604.355934] =C2=A0gfx_v8_0_su=
spend+0xe/0x20 [amdgpu]<br>[ =C2=A0604.356852] =C2=A0amdgpu_ip_block_suspen=
d+0x27/0x60 [amdgpu]<br>[ =C2=A0604.357726] =C2=A0amdgpu_device_ip_suspend_=
phase2+0x1bc/0x3c0 [amdgpu]<br>[ =C2=A0604.358609] =C2=A0amdgpu_device_susp=
end+0x113/0x170 [amdgpu]<br>[ =C2=A0604.359499] =C2=A0amdgpu_pmops_suspend+=
0x3d/0xe0 [amdgpu]<br>[ =C2=A0604.360391] =C2=A0pci_pm_suspend+0x85/0x1b0<b=
r>[ =C2=A0604.360396] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10<br>[ =C2=A0604=
.360399] =C2=A0dpm_run_callback+0x5f/0x160<br>[ =C2=A0604.360403] =C2=A0dev=
ice_suspend+0x1e4/0x4e0<br>[ =C2=A0604.360405] =C2=A0async_suspend+0x21/0x4=
0<br>[ =C2=A0604.360408] =C2=A0async_run_entry_fn+0x33/0x130<br>[ =C2=A0604=
.360411] =C2=A0process_one_work+0x18e/0x370<br>[ =C2=A0604.360415] =C2=A0wo=
rker_thread+0x317/0x450<br>[ =C2=A0604.360416] =C2=A0? __pfx_worker_thread+=
0x10/0x10<br>[ =C2=A0604.360418] =C2=A0kthread+0x10b/0x220<br>[ =C2=A0604.3=
60421] =C2=A0? recalc_sigpending+0x76/0xb0<br>[ =C2=A0604.360424] =C2=A0? _=
_pfx_kthread+0x10/0x10<br>[ =C2=A0604.360426] =C2=A0ret_from_fork+0x134/0x1=
50<br>[ =C2=A0604.360429] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0604.36=
0431] =C2=A0ret_from_fork_asm+0x1a/0x30<br>[ =C2=A0604.360435] =C2=A0&lt;/T=
ASK&gt;<br>[ =C2=A0604.360436] ---[ end trace 0000000000000000 ]---<br>[ =
=C2=A0604.600867] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu=
]] *ERROR* ring kiq_0.2.1.0 test failed (-110)<br>[ =C2=A0604.601775] [drm:=
gfx_v8_0_hw_fini [amdgpu]] *ERROR* KCQ disable failed<br>[ =C2=A0604.837747=
] amdgpu: cp is busy, skip halt cp<br>[ =C2=A0605.072838] amdgpu: rlc is bu=
sy, skip halt rlc<br>[ =C2=A0605.073900] ------------[ cut here ]----------=
--<br>[ =C2=A0605.073901] WARNING: CPU: 1 PID: 6585 at drivers/gpu/drm/amd/=
amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A0605.07=
4834] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus hfs minix m=
sdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac algi=
f_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_hda=
_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd_hda_codec_=
realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_hda_=
codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm sn=
d_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event ccp snd_rawm=
idi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac80211 drm_pa=
nel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec drm_su=
balloc_helper drm_display_helper cec rc_core snd_seq_device snd_timer i2c_a=
lgo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profi=
le soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi del=
l_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_desc=
riptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn<br>[ =C2=A0605.074894] =
=C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp msr parport_pc parpor=
t efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 raid10 raid4=
56 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc psmouse video =
r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmulni_intel ser=
io_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_storage aesni_=
intel<br>[ =C2=A0605.074929] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:21 T=
ainted: P =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06=
.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br>[ =C2=A0605.074934] Tainted=
: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ =C2=A0605.074=
935] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<b=
r>[ =C2=A0605.074936] Workqueue: async async_run_entry_fn<br>[ =C2=A0605.07=
4942] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ =C2=A0605.075902] Co=
de: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4=
 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea =
ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ =C2=A0605.075904=
] RSP: 0018:ffffd4e34aa37c50 EFLAGS: 00010246<br>[ =C2=A0605.075907] RAX: 0=
000000000000000 RBX: ffff8edc1d680c70 RCX: 0000000000000000<br>[ =C2=A0605.=
075908] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000<b=
r>[ =C2=A0605.075909] RBP: ffffd4e34aa37c70 R08: 0000000000000000 R09: 0000=
000000000000<br>[ =C2=A0605.075910] R10: 0000000000000000 R11: 000000000000=
0000 R12: ffff8edc1d680000<br>[ =C2=A0605.075911] R13: 0000000000000000 R14=
: ffff8edc1d6d0d58 R15: ffff8edc1d680000<br>[ =C2=A0605.075913] FS: =C2=A00=
000000000000000(0000) GS:ffff8edf196f0000(0000) knlGS:0000000000000000<br>[=
 =C2=A0605.075914] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033<b=
r>[ =C2=A0605.075915] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4: 0000=
0000001506f0<br>[ =C2=A0605.075917] Call Trace:<br>[ =C2=A0605.075918] =C2=
=A0&lt;TASK&gt;<br>[ =C2=A0605.075919] =C2=A0? delay_halt.part.0+0x3e/0x70<=
br>[ =C2=A0605.075927] =C2=A0gmc_v8_0_hw_fini+0x1f/0xb0 [amdgpu]<br>[ =C2=
=A0605.076856] =C2=A0gmc_v8_0_suspend+0xe/0x20 [amdgpu]<br>[ =C2=A0605.0777=
81] =C2=A0amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]<br>[ =C2=A0605.078676]=
 =C2=A0amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdgpu]<br>[ =C2=A0605.=
079560] =C2=A0amdgpu_device_suspend+0x113/0x170 [amdgpu]<br>[ =C2=A0605.080=
438] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ =C2=A0605.081318] =
=C2=A0pci_pm_suspend+0x85/0x1b0<br>[ =C2=A0605.081323] =C2=A0? __pfx_pci_pm=
_suspend+0x10/0x10<br>[ =C2=A0605.081326] =C2=A0dpm_run_callback+0x5f/0x160=
<br>[ =C2=A0605.081330] =C2=A0device_suspend+0x1e4/0x4e0<br>[ =C2=A0605.081=
332] =C2=A0async_suspend+0x21/0x40<br>[ =C2=A0605.081335] =C2=A0async_run_e=
ntry_fn+0x33/0x130<br>[ =C2=A0605.081339] =C2=A0process_one_work+0x18e/0x37=
0<br>[ =C2=A0605.081342] =C2=A0worker_thread+0x317/0x450<br>[ =C2=A0605.081=
344] =C2=A0? __pfx_worker_thread+0x10/0x10<br>[ =C2=A0605.081345] =C2=A0kth=
read+0x10b/0x220<br>[ =C2=A0605.081348] =C2=A0? recalc_sigpending+0x76/0xb0=
<br>[ =C2=A0605.081351] =C2=A0? __pfx_kthread+0x10/0x10<br>[ =C2=A0605.0813=
53] =C2=A0ret_from_fork+0x134/0x150<br>[ =C2=A0605.081368] =C2=A0? __pfx_kt=
hread+0x10/0x10<br>[ =C2=A0605.081371] =C2=A0ret_from_fork_asm+0x1a/0x30<br=
>[ =C2=A0605.081375] =C2=A0&lt;/TASK&gt;<br>[ =C2=A0605.081376] ---[ end tr=
ace 0000000000000000 ]---<br>[ =C2=A0605.083479] amdgpu 0000:03:00.0: amdgp=
u: PCI CONFIG reset<br>[ =C2=A0605.083699] ACPI: EC: interrupt blocked<br>[=
 =C2=A0605.109649] ACPI: PM: Preparing to enter system sleep state S3<br>[ =
=C2=A0605.435280] ACPI Warning: Time parameter 120 us &gt; 100 us violating=
 ACPI spec, please fix the firmware. (20250807/exsystem-142)<br>[ =C2=A0605=
.436113] ACPI: EC: event blocked<br>[ =C2=A0605.436114] ACPI: EC: EC stoppe=
d<br>[ =C2=A0605.436115] ACPI: PM: Saving platform NVS memory<br>[ =C2=A060=
5.436214] Disabling non-boot CPUs ...<br>[ =C2=A0605.438631] smpboot: CPU 3=
 is now offline<br>[ =C2=A0605.442252] smpboot: CPU 2 is now offline<br>[ =
=C2=A0605.445111] smpboot: CPU 1 is now offline<br>[ =C2=A0605.447033] ACPI=
: PM: Low-level resume complete<br>[ =C2=A0605.447067] ACPI: EC: EC started=
<br>[ =C2=A0605.447069] ACPI: PM: Restoring platform NVS memory<br>[ =C2=A0=
605.447227] AMD-Vi: Virtual APIC enabled<br>[ =C2=A0605.447251] AMD-Vi: Vir=
tual APIC enabled<br>[ =C2=A0605.447254] LVT offset 0 assigned for vector 0=
x400<br>[ =C2=A0605.447757] Enabling non-boot CPUs ...<br>[ =C2=A0605.44783=
0] smpboot: Booting Node 0 Processor 1 APIC 0x11<br>[ =C2=A0605.451533] CPU=
1 is up<br>[ =C2=A0605.451598] smpboot: Booting Node 0 Processor 2 APIC 0x1=
2<br>[ =C2=A0605.455447] CPU2 is up<br>[ =C2=A0605.455507] smpboot: Booting=
 Node 0 Processor 3 APIC 0x13<br>[ =C2=A0605.459382] CPU3 is up<br>[ =C2=A0=
605.460791] ACPI: PM: Waking up from system sleep state S3<br>[ =C2=A0605.5=
12016] ACPI: EC: interrupt unblocked<br>[ =C2=A0605.518861] [drm] PCIE GART=
 of 1024M enabled (table at 0x000000F400A00000).<br>[ =C2=A0605.518874] ACP=
I: EC: event unblocked<br>[ =C2=A0605.518899] amdgpu: smu version 27.17.00<=
br>[ =C2=A0605.536571] [drm] PCIE GART of 256M enabled (table at 0x000000F4=
FFF80000).<br>[ =C2=A0605.551074] [drm] UVD initialized successfully.<br>[ =
=C2=A0605.718769] [drm] UVD and UVD ENC initialized successfully.<br>[ =C2=
=A0605.752031] [drm] VCE initialized successfully.<br>[ =C2=A0605.763611] u=
sb 1-2: reset high-speed USB device number 2 using xhci_hcd<br>[ =C2=A0605.=
773339] usb 2-1.4: reset high-speed USB device number 4 using ehci-pci<br>[=
 =C2=A0605.819760] [drm] VCE initialized successfully.<br>[ =C2=A0605.93950=
6] usb 2-1.2: reset full-speed USB device number 3 using ehci-pci<br>[ =C2=
=A0605.984372] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)<br>[ =
=C2=A0605.986837] sd 1:0:0:0: [sda] Starting disk<br>[ =C2=A0605.990324] at=
a1.00: configured for UDMA/133<br>[ =C2=A0606.034393] OOM killer enabled.<b=
r>[ =C2=A0606.034400] Restarting tasks: Starting<br>[ =C2=A0606.036871] Res=
tarting tasks: Done<br>[ =C2=A0606.036937] random: crng reseeded on system =
resumption<br>[ =C2=A0606.037313] Bluetooth: hci0: using rampatch file: qca=
/rampatch_usb_00000302.bin<br>[ =C2=A0606.037348] Bluetooth: hci0: QCA: pat=
ch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111<br>[ =C2=A0606.0=
49086] PM: suspend exit<br>[ =C2=A0606.325705] Generic FE-GE Realtek PHY r8=
169-0-200:00: attached PHY driver (mii_bus:phy_addr=3Dr8169-0-200:00, irq=
=3DMAC)<br>[ =C2=A0606.403987] Bluetooth: hci0: using NVM file: qca/nvm_usb=
_00000302.bin<br>[ =C2=A0606.426895] Bluetooth: hci0: HCI Enhanced Setup Sy=
nchronous Connection command is advertised, but not supported.<br>[ =C2=A06=
06.481379] r8169 0000:02:00.0 enp2s0: Link is Down<br>[ =C2=A0606.673801] B=
luetooth: MGMT ver 1.23<br>[ =C2=A0606.684146] kauditd_printk_skb: 6 callba=
cks suppressed<br>[ =C2=A0606.684153] audit: type=3D1400 audit(1770175422.2=
34:141): apparmor=3D&quot;ALLOWED&quot; operation=3D&quot;getattr&quot; cla=
ss=3D&quot;posix_mqueue&quot; profile=3D&quot;snap.ubuntu-desktop-bootstrap=
.subiquity-server&quot; name=3D&quot;/&quot; pid=3D6784 comm=3D&quot;pvscan=
&quot; requested=3D&quot;getattr&quot; denied=3D&quot;getattr&quot; class=
=3D&quot;posix_mqueue&quot; fsuid=3D0 ouid=3D0 olabel=3D&quot;unconfined&qu=
ot;<br>[ =C2=A0606.684159] audit: type=3D1400 audit(1770175422.234:142): ap=
parmor=3D&quot;ALLOWED&quot; operation=3D&quot;getattr&quot; class=3D&quot;=
posix_mqueue&quot; profile=3D&quot;snap.ubuntu-desktop-bootstrap.subiquity-=
server&quot; name=3D&quot;/&quot; pid=3D6784 comm=3D&quot;pvscan&quot; requ=
ested=3D&quot;getattr&quot; denied=3D&quot;getattr&quot; class=3D&quot;posi=
x_mqueue&quot; fsuid=3D0 ouid=3D0 olabel=3D&quot;unconfined&quot;<br>[ =C2=
=A0606.684162] audit: type=3D1400 audit(1770175422.234:143): apparmor=3D&qu=
ot;ALLOWED&quot; operation=3D&quot;getattr&quot; class=3D&quot;posix_mqueue=
&quot; profile=3D&quot;snap.ubuntu-desktop-bootstrap.subiquity-server&quot;=
 name=3D&quot;/&quot; pid=3D6784 comm=3D&quot;pvscan&quot; requested=3D&quo=
t;getattr&quot; denied=3D&quot;getattr&quot; class=3D&quot;posix_mqueue&quo=
t; fsuid=3D0 ouid=3D0 olabel=3D&quot;unconfined&quot;<br>[ =C2=A0606.684165=
] audit: type=3D1400 audit(1770175422.234:144): apparmor=3D&quot;ALLOWED&qu=
ot; operation=3D&quot;getattr&quot; class=3D&quot;posix_mqueue&quot; profil=
e=3D&quot;snap.ubuntu-desktop-bootstrap.subiquity-server&quot; name=3D&quot=
;/&quot; pid=3D6784 comm=3D&quot;pvscan&quot; requested=3D&quot;getattr&quo=
t; denied=3D&quot;getattr&quot; class=3D&quot;posix_mqueue&quot; fsuid=3D0 =
ouid=3D0 olabel=3D&quot;unconfined&quot;<br>[ =C2=A0606.763476] audit: type=
=3D1400 audit(1770175422.314:145): apparmor=3D&quot;ALLOWED&quot; operation=
=3D&quot;getattr&quot; class=3D&quot;posix_mqueue&quot; profile=3D&quot;sna=
p.ubuntu-desktop-bootstrap.subiquity-server&quot; name=3D&quot;/&quot; pid=
=3D6789 comm=3D&quot;vgscan&quot; requested=3D&quot;getattr&quot; denied=3D=
&quot;getattr&quot; class=3D&quot;posix_mqueue&quot; fsuid=3D0 ouid=3D0 ola=
bel=3D&quot;unconfined&quot;<br>[ =C2=A0606.763489] audit: type=3D1400 audi=
t(1770175422.314:146): apparmor=3D&quot;ALLOWED&quot; operation=3D&quot;get=
attr&quot; class=3D&quot;posix_mqueue&quot; profile=3D&quot;snap.ubuntu-des=
ktop-bootstrap.subiquity-server&quot; name=3D&quot;/&quot; pid=3D6789 comm=
=3D&quot;vgscan&quot; requested=3D&quot;getattr&quot; denied=3D&quot;getatt=
r&quot; class=3D&quot;posix_mqueue&quot; fsuid=3D0 ouid=3D0 olabel=3D&quot;=
unconfined&quot;<br>[ =C2=A0606.763492] audit: type=3D1400 audit(1770175422=
.314:147): apparmor=3D&quot;ALLOWED&quot; operation=3D&quot;getattr&quot; c=
lass=3D&quot;posix_mqueue&quot; profile=3D&quot;snap.ubuntu-desktop-bootstr=
ap.subiquity-server&quot; name=3D&quot;/&quot; pid=3D6789 comm=3D&quot;vgsc=
an&quot; requested=3D&quot;getattr&quot; denied=3D&quot;getattr&quot; class=
=3D&quot;posix_mqueue&quot; fsuid=3D0 ouid=3D0 olabel=3D&quot;unconfined&qu=
ot;<br>[ =C2=A0606.763494] audit: type=3D1400 audit(1770175422.314:148): ap=
parmor=3D&quot;ALLOWED&quot; operation=3D&quot;getattr&quot; class=3D&quot;=
posix_mqueue&quot; profile=3D&quot;snap.ubuntu-desktop-bootstrap.subiquity-=
server&quot; name=3D&quot;/&quot; pid=3D6789 comm=3D&quot;vgscan&quot; requ=
ested=3D&quot;getattr&quot; denied=3D&quot;getattr&quot; class=3D&quot;posi=
x_mqueue&quot; fsuid=3D0 ouid=3D0 olabel=3D&quot;unconfined&quot;<br>[ =C2=
=A0606.857207] audit: type=3D1400 audit(1770175422.407:149): apparmor=3D&qu=
ot;ALLOWED&quot; operation=3D&quot;getattr&quot; class=3D&quot;posix_mqueue=
&quot; profile=3D&quot;snap.ubuntu-desktop-bootstrap.subiquity-server&quot;=
 name=3D&quot;/&quot; pid=3D6790 comm=3D&quot;vgchange&quot; requested=3D&q=
uot;getattr&quot; denied=3D&quot;getattr&quot; class=3D&quot;posix_mqueue&q=
uot; fsuid=3D0 ouid=3D0 olabel=3D&quot;unconfined&quot;<br>[ =C2=A0606.8572=
21] audit: type=3D1400 audit(1770175422.407:150): apparmor=3D&quot;ALLOWED&=
quot; operation=3D&quot;getattr&quot; class=3D&quot;posix_mqueue&quot; prof=
ile=3D&quot;snap.ubuntu-desktop-bootstrap.subiquity-server&quot; name=3D&qu=
ot;/&quot; pid=3D6790 comm=3D&quot;vgchange&quot; requested=3D&quot;getattr=
&quot; denied=3D&quot;getattr&quot; class=3D&quot;posix_mqueue&quot; fsuid=
=3D0 ouid=3D0 olabel=3D&quot;unconfined&quot;<br>ubuntu@ubuntu:~$</div></di=
v>

--000000000000b80359064a006329--
