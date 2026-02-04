Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BCEE9D403
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 15:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4575810E6A2;
	Wed,  4 Feb 2026 15:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jh2suibt";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06BDF10E699
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 15:46:37 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2b703e04984so623342eec.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Feb 2026 07:46:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770219996; cv=none;
 d=google.com; s=arc-20240605;
 b=U7Nr0NVmI5nHuaEyc285Gf8k54f1P5uvMNG0hjjXuSAQdM1b3pLCXDxi7Mofh0a7Zs
 6hT8onSODpd0jHIEPsLGrVJYSMc/zQaez4VsVyC6ptO4MOZGoJG0zDcojObWHazfZBWn
 JuOpt1F4ChzBmghOmVS+D4jEtgwCCi7qe3kDN0VFFpcgVuoQx0Wx57F6nWWVVL+dgX72
 kuJTW0sx0QxJ+gZSMFN8BP22QjV7ud55XtIprxAPHVf8m8IDebX2phD9yfefzzFQKSpM
 xiNX7HkevHwHTXkyUDj0kYIp67WZz6/9Fq/KpzesIBxPpqgPwyB5jQg7Tn3rbMUlzDq9
 lWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DE1v8sSgDug5fUrpiJuctt6FpLPRyAekEQF9hlxLuoo=;
 fh=p6al3IUzqAJMqQZujs77cVhrzHA5XU+xdt7yLP0+irY=;
 b=I4ZgWUHlMZQGj9BYGo/3oSVOrtWRhKwBeMdCM18HOmaDsUtPwy+hcy+QxrQZP+mbsJ
 COC1trUxzcC5Oh7EXyDv0ArTDD4ygz8HlLNWxWaWZAb/9ef9XkLauPs3b2ZeOB43UaMU
 NAhF8CLGpx7noabXviVM3DA9ZJOUA/7cooSSwQptz3KUY8+KtyXonXl5sNXyridSy5Ne
 Aiez42qUE7iFzPPcpY/kYl992BP2RAPixW8nEeBO8sKH7qC/h4clk0YppQ+V41MILp4l
 CRaXJGUMKdS8icbcws/H3NxRSwOrqbLk7jeSWith1Cs2fA+hWYTVEvJy1l1GJ3m34evK
 lenQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770219996; x=1770824796; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DE1v8sSgDug5fUrpiJuctt6FpLPRyAekEQF9hlxLuoo=;
 b=jh2suibtvhr3gOEwr+dmrCbZ5Zu8BsTU5h1mcVVwNwy7vDB81HpSeayCiLa+5OfYre
 Dj6+T5pOQ/iHGLZAlLLyre+tw/XGlgzGINHG6hXUprpazwWIcAtFaypA/7P7DWjSfWh/
 hexRwtgGzukKaVDIxQKY4mT9K3qrD+zog6NzZEF3oklXjT7Fa9Ltu2sVmFjXJD9J4OC2
 rj1RwJHWBAnRTFtTNp9xDMftnsd3NdjRY3IBqNpHCKplSYGWEzZ7/psGpryns9XNTNE3
 j568AukOpLOmUoiP+Oj4ut/jXTdKs44J8bhdhjsDAZXv7fFCncEUk5C2vOGc5b3INxVi
 sgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770219996; x=1770824796;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DE1v8sSgDug5fUrpiJuctt6FpLPRyAekEQF9hlxLuoo=;
 b=CKhIL6SVLM+159kQoK1lu9tTitzpjwJsHuPUKFXXELIPVNWfqq5nkc2jM9DAx7rjIX
 mO/csSsfZXizSylDTQgri6/Lm7G6wG624dMRQXantno6U9XCAFxILSU+7ybZikdG6b//
 yeH189kDRDIQZlg9G22eTDLnfuldd3xVAHBFjRjwP2m9OLBCiBT5dDblD1xr55bqJPop
 FNxsnlFdjVF3yTpPy6OPqoFA+3phhhYPID7T19JhlkC9ZUx3iZ6tje3MTMptHZTZOOMJ
 oNAEKARZYHlcWMJt2N9Y7w9Nfma0Ln5/5cDIzvUDibfkAKKUrOKS/PJk8bIsYx4XEQk4
 rt8w==
X-Gm-Message-State: AOJu0YzGnUzHq2Dxnlk4M4Jysw67aHKw1DXyZOh2LM8TCrkMGDofTaCR
 fn6QVjaxicE1Wy7Jy/T4wAw7onxmAkoq/451Ae3cOdmUci5dyKPzssHO6i7D6C64dLssMnHHIjJ
 b9c9jzw6mvE1SpZtapu7/RozwTVUe0OxlcQ==
X-Gm-Gg: AZuq6aKhJSKoJ8Z6x7u8Tz6YlAUs3STeMnDMKAzJpD8sSc7Mnx4ftc1Jirq4qX7RiWJ
 vMaNgGEC2bOQLnc3yactfjAEBxtFvBCSvG0sI36fbG9RoCVbPqpBiqpQEkEIMqQnSvzGFgSbWyY
 i2tIWDMbyWg8ukCTicAqhWibrJbR1Z0IwmjkgwQ7q44D6yAXbcswpRviuooR0MDw12hBPyF7/lg
 OxNaiuCQZHnfD+2n3hlkbFjNE7OmInXly6YxmjKNhjc1ERM7q2HjaVIjdDesPRJS1wV0IWv
X-Received: by 2002:a05:7022:2386:b0:11e:332:1e01 with SMTP id
 a92af1059eb24-126f47c9c62mr660128c88.3.1770219995583; Wed, 04 Feb 2026
 07:46:35 -0800 (PST)
MIME-Version: 1.0
References: <CAKR_QVJBiwDrUiJh5BGS-1tU4n6B-DbpA1ebTa+DF=F5kAzaTA@mail.gmail.com>
In-Reply-To: <CAKR_QVJBiwDrUiJh5BGS-1tU4n6B-DbpA1ebTa+DF=F5kAzaTA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Feb 2026 10:46:23 -0500
X-Gm-Features: AZwV_QjBN2Sw_FoWcOsFUWol2N-DKxF4qJPPH4sIGSRi4qO2-WFbG5Kk0EvMyIA
Message-ID: <CADnq5_M4kkqsWnTQVuXVitqZR_UUzgmqZSqVPy+E8sgpbXHb8A@mail.gmail.com>
Subject: Re: UVD not responding, kiq_0.2.1.0 test failed on suspend
To: Tom Psyborg <pozega.tomislav@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Feb 4, 2026 at 3:10=E2=80=AFAM Tom Psyborg <pozega.tomislav@gmail.c=
om> wrote:
>
> Hi
>
> I try live boot of ubuntu 26.04 snapshot 3 (6.18.0-9) on dell inspiron 55=
76 with RX460 dGPU, everything seems ok, until i try to put system to sleep=
:
> (sleep/suspend worked fine on ubuntu 22.04 last time i checked and it wor=
ks fine in windows)

Can you bisect or at least narrow down when this broke?

Alex

>
> [  593.187045] PM: suspend entry (deep)
> [  593.187143] Filesystems sync: 0.000 seconds
> [  593.191490] Freezing user space processes
> [  593.193435] Freezing user space processes completed (elapsed 0.001 sec=
onds)
> [  593.193446] OOM killer disabled.
> [  593.193447] Freezing remaining freezable tasks
> [  593.194764] Freezing remaining freezable tasks completed (elapsed 0.00=
1 seconds)
> [  593.194816] printk: Suspending console(s) (use no_console_suspend to d=
ebug)
> [  593.323573] sd 1:0:0:0: [sda] Synchronizing SCSI cache
> [  593.423009] ata1.00: Entering standby power mode
> [  593.553102] [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF800=
00).
> [  593.623444] psmouse serio1: Failed to disable mouse on isa0060/serio1
> [  594.733234] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [  595.754613] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [  596.775980] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [  597.797336] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [  598.818700] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [  599.840060] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [  600.861418] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [  601.882800] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [  602.904165] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [  603.925523] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
trying to reset the VCPU!!!
> [  603.946463] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, =
giving up!!!
> [  603.947393] amdgpu 0000:03:00.0: amdgpu: set_powergating_state of IP b=
lock <uvd_v6_0> failed -1
> [  604.217843] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]=
] *ERROR* ring uvd test failed (-110)
> [  604.218768] amdgpu 0000:03:00.0: amdgpu: resume of IP block <uvd_v6_0>=
 failed -110
> [  604.218773] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume faile=
d (-110).
> [  604.219420] ------------[ cut here ]------------
> [  604.219425] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.220350] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.220426]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.220462] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
        O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.220467] Tainted: [P]=3DPROPRIETARY_MODULE, [O]=3DOOT_MODULE
> [  604.220468] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.220470] Workqueue: async async_run_entry_fn
> [  604.220476] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.221397] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.221400] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
> [  604.221403] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 000000000=
0000000
> [  604.221404] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.221405] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.221406] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.221407] R13: 0000000000000000 R14: 0000000000000002 R15: 000000000=
0000000
> [  604.221409] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000) knlG=
S:0000000000000000
> [  604.221410] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.221411] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.221413] Call Trace:
> [  604.221415]  <TASK>
> [  604.221420]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
> [  604.222316]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
> [  604.223208]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
> [  604.224094]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.224979]  pci_pm_suspend+0x85/0x1b0
> [  604.224986]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.224989]  dpm_run_callback+0x5f/0x160
> [  604.224993]  device_suspend+0x1e4/0x4e0
> [  604.224996]  async_suspend+0x21/0x40
> [  604.224998]  async_run_entry_fn+0x33/0x130
> [  604.225001]  process_one_work+0x18e/0x370
> [  604.225005]  worker_thread+0x317/0x450
> [  604.225007]  ? __pfx_worker_thread+0x10/0x10
> [  604.225009]  kthread+0x10b/0x220
> [  604.225012]  ? recalc_sigpending+0x76/0xb0
> [  604.225014]  ? __pfx_kthread+0x10/0x10
> [  604.225017]  ret_from_fork+0x134/0x150
> [  604.225019]  ? __pfx_kthread+0x10/0x10
> [  604.225022]  ret_from_fork_asm+0x1a/0x30
> [  604.225026]  </TASK>
> [  604.225027] ---[ end trace 0000000000000000 ]---
> [  604.225086] ------------[ cut here ]------------
> [  604.225087] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.226002] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.226061]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.226094] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.226098] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.226099] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.226101] Workqueue: async async_run_entry_fn
> [  604.226106] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.227029] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.227031] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
> [  604.227034] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 000000000=
0000000
> [  604.227035] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.227036] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.227037] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.227038] R13: 0000000000000002 R14: 0000000000000002 R15: 000000000=
0000000
> [  604.227039] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000) knlG=
S:0000000000000000
> [  604.227041] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.227042] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.227043] Call Trace:
> [  604.227044]  <TASK>
> [  604.227048]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
> [  604.227939]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
> [  604.228843]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
> [  604.229731]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.230619]  pci_pm_suspend+0x85/0x1b0
> [  604.230624]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.230627]  dpm_run_callback+0x5f/0x160
> [  604.230631]  device_suspend+0x1e4/0x4e0
> [  604.230634]  async_suspend+0x21/0x40
> [  604.230636]  async_run_entry_fn+0x33/0x130
> [  604.230639]  process_one_work+0x18e/0x370
> [  604.230642]  worker_thread+0x317/0x450
> [  604.230644]  ? __pfx_worker_thread+0x10/0x10
> [  604.230646]  kthread+0x10b/0x220
> [  604.230649]  ? recalc_sigpending+0x76/0xb0
> [  604.230651]  ? __pfx_kthread+0x10/0x10
> [  604.230654]  ret_from_fork+0x134/0x150
> [  604.230656]  ? __pfx_kthread+0x10/0x10
> [  604.230658]  ret_from_fork_asm+0x1a/0x30
> [  604.230662]  </TASK>
> [  604.230663] ---[ end trace 0000000000000000 ]---
> [  604.230720] ------------[ cut here ]------------
> [  604.230721] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.231654] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.231714]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.231746] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.231751] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.231752] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.231753] Workqueue: async async_run_entry_fn
> [  604.231759] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.232678] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.232681] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
> [  604.232685] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 000000000=
0000000
> [  604.232686] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.232687] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.232689] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.232690] R13: 0000000000000002 R14: 0000000000000002 R15: 000000000=
0000000
> [  604.232691] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000) knlG=
S:0000000000000000
> [  604.232693] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.232695] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.232696] Call Trace:
> [  604.232698]  <TASK>
> [  604.232702]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
> [  604.233601]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
> [  604.234506]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
> [  604.235404]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.236275]  pci_pm_suspend+0x85/0x1b0
> [  604.236281]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.236283]  dpm_run_callback+0x5f/0x160
> [  604.236287]  device_suspend+0x1e4/0x4e0
> [  604.236290]  async_suspend+0x21/0x40
> [  604.236292]  async_run_entry_fn+0x33/0x130
> [  604.236295]  process_one_work+0x18e/0x370
> [  604.236299]  worker_thread+0x317/0x450
> [  604.236301]  ? __pfx_worker_thread+0x10/0x10
> [  604.236302]  kthread+0x10b/0x220
> [  604.236305]  ? recalc_sigpending+0x76/0xb0
> [  604.236307]  ? __pfx_kthread+0x10/0x10
> [  604.236310]  ret_from_fork+0x134/0x150
> [  604.236312]  ? __pfx_kthread+0x10/0x10
> [  604.236315]  ret_from_fork_asm+0x1a/0x30
> [  604.236319]  </TASK>
> [  604.236320] ---[ end trace 0000000000000000 ]---
> [  604.236389] ------------[ cut here ]------------
> [  604.236391] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.237301] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.237370]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.237404] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.237408] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.237409] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.237410] Workqueue: async async_run_entry_fn
> [  604.237416] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.238328] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.238330] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
> [  604.238332] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 000000000=
0000000
> [  604.238333] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.238334] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.238335] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.238336] R13: 0000000000000002 R14: 0000000000000002 R15: 000000000=
0000000
> [  604.238338] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000) knlG=
S:0000000000000000
> [  604.238339] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.238340] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.238342] Call Trace:
> [  604.238343]  <TASK>
> [  604.238347]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
> [  604.239247]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
> [  604.240137]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
> [  604.241032]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.241934]  pci_pm_suspend+0x85/0x1b0
> [  604.241940]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.241942]  dpm_run_callback+0x5f/0x160
> [  604.241946]  device_suspend+0x1e4/0x4e0
> [  604.241949]  async_suspend+0x21/0x40
> [  604.241951]  async_run_entry_fn+0x33/0x130
> [  604.241954]  process_one_work+0x18e/0x370
> [  604.241958]  worker_thread+0x317/0x450
> [  604.241960]  ? __pfx_worker_thread+0x10/0x10
> [  604.241961]  kthread+0x10b/0x220
> [  604.241964]  ? recalc_sigpending+0x76/0xb0
> [  604.241966]  ? __pfx_kthread+0x10/0x10
> [  604.241969]  ret_from_fork+0x134/0x150
> [  604.241972]  ? __pfx_kthread+0x10/0x10
> [  604.241974]  ret_from_fork_asm+0x1a/0x30
> [  604.241978]  </TASK>
> [  604.241979] ---[ end trace 0000000000000000 ]---
> [  604.242037] ------------[ cut here ]------------
> [  604.242038] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.242954] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.243013]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.243046] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.243050] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.243051] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.243052] Workqueue: async async_run_entry_fn
> [  604.243058] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.243986] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.243988] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
> [  604.243990] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 000000000=
0000000
> [  604.243992] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.243993] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.243994] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.243995] R13: 0000000000000002 R14: 0000000000000002 R15: 000000000=
0000000
> [  604.243996] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000) knlG=
S:0000000000000000
> [  604.243997] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.243998] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.244000] Call Trace:
> [  604.244001]  <TASK>
> [  604.244005]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
> [  604.244899]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
> [  604.245788]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
> [  604.246685]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.247577]  pci_pm_suspend+0x85/0x1b0
> [  604.247582]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.247585]  dpm_run_callback+0x5f/0x160
> [  604.247589]  device_suspend+0x1e4/0x4e0
> [  604.247592]  async_suspend+0x21/0x40
> [  604.247594]  async_run_entry_fn+0x33/0x130
> [  604.247598]  process_one_work+0x18e/0x370
> [  604.247601]  worker_thread+0x317/0x450
> [  604.247603]  ? __pfx_worker_thread+0x10/0x10
> [  604.247604]  kthread+0x10b/0x220
> [  604.247607]  ? recalc_sigpending+0x76/0xb0
> [  604.247610]  ? __pfx_kthread+0x10/0x10
> [  604.247612]  ret_from_fork+0x134/0x150
> [  604.247615]  ? __pfx_kthread+0x10/0x10
> [  604.247617]  ret_from_fork_asm+0x1a/0x30
> [  604.247621]  </TASK>
> [  604.247622] ---[ end trace 0000000000000000 ]---
> [  604.247680] ------------[ cut here ]------------
> [  604.247681] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.248598] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.248658]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.248691] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.248695] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.248696] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.248697] Workqueue: async async_run_entry_fn
> [  604.248702] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.249627] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.249629] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
> [  604.249632] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 000000000=
0000000
> [  604.249633] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.249634] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.249635] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.249636] R13: 0000000000000002 R14: 0000000000000002 R15: 000000000=
0000000
> [  604.249638] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000) knlG=
S:0000000000000000
> [  604.249639] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.249640] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.249642] Call Trace:
> [  604.249643]  <TASK>
> [  604.249647]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
> [  604.250538]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
> [  604.251444]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
> [  604.252318]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.253208]  pci_pm_suspend+0x85/0x1b0
> [  604.253215]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.253218]  dpm_run_callback+0x5f/0x160
> [  604.253222]  device_suspend+0x1e4/0x4e0
> [  604.253224]  async_suspend+0x21/0x40
> [  604.253227]  async_run_entry_fn+0x33/0x130
> [  604.253230]  process_one_work+0x18e/0x370
> [  604.253233]  worker_thread+0x317/0x450
> [  604.253235]  ? __pfx_worker_thread+0x10/0x10
> [  604.253237]  kthread+0x10b/0x220
> [  604.253240]  ? recalc_sigpending+0x76/0xb0
> [  604.253242]  ? __pfx_kthread+0x10/0x10
> [  604.253245]  ret_from_fork+0x134/0x150
> [  604.253248]  ? __pfx_kthread+0x10/0x10
> [  604.253250]  ret_from_fork_asm+0x1a/0x30
> [  604.253254]  </TASK>
> [  604.253255] ---[ end trace 0000000000000000 ]---
> [  604.253313] ------------[ cut here ]------------
> [  604.253313] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.254240] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.254299]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.254332] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.254336] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.254337] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.254339] Workqueue: async async_run_entry_fn
> [  604.254344] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.255268] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.255271] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
> [  604.255274] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 000000000=
0000000
> [  604.255275] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.255276] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.255278] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.255279] R13: 0000000000000002 R14: 0000000000000002 R15: 000000000=
0000000
> [  604.255280] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000) knlG=
S:0000000000000000
> [  604.255281] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.255282] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.255284] Call Trace:
> [  604.255285]  <TASK>
> [  604.255289]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
> [  604.256183]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
> [  604.257090]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
> [  604.257988]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.258877]  pci_pm_suspend+0x85/0x1b0
> [  604.258884]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.258887]  dpm_run_callback+0x5f/0x160
> [  604.258891]  device_suspend+0x1e4/0x4e0
> [  604.258893]  async_suspend+0x21/0x40
> [  604.258895]  async_run_entry_fn+0x33/0x130
> [  604.258899]  process_one_work+0x18e/0x370
> [  604.258902]  worker_thread+0x317/0x450
> [  604.258904]  ? __pfx_worker_thread+0x10/0x10
> [  604.258906]  kthread+0x10b/0x220
> [  604.258908]  ? recalc_sigpending+0x76/0xb0
> [  604.258911]  ? __pfx_kthread+0x10/0x10
> [  604.258913]  ret_from_fork+0x134/0x150
> [  604.258916]  ? __pfx_kthread+0x10/0x10
> [  604.258918]  ret_from_fork_asm+0x1a/0x30
> [  604.258922]  </TASK>
> [  604.258923] ---[ end trace 0000000000000000 ]---
> [  604.258981] ------------[ cut here ]------------
> [  604.258982] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.259903] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.259962]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.259995] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.259999] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.259999] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.260001] Workqueue: async async_run_entry_fn
> [  604.260006] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.260922] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.260925] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
> [  604.260928] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 000000000=
0000000
> [  604.260929] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.260930] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.260931] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.260932] R13: 0000000000000002 R14: 0000000000000002 R15: 000000000=
0000000
> [  604.260934] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000) knlG=
S:0000000000000000
> [  604.260935] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.260936] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.260938] Call Trace:
> [  604.260939]  <TASK>
> [  604.260943]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
> [  604.261840]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
> [  604.262729]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
> [  604.263628]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.264519]  pci_pm_suspend+0x85/0x1b0
> [  604.264525]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.264528]  dpm_run_callback+0x5f/0x160
> [  604.264532]  device_suspend+0x1e4/0x4e0
> [  604.264535]  async_suspend+0x21/0x40
> [  604.264537]  async_run_entry_fn+0x33/0x130
> [  604.264541]  process_one_work+0x18e/0x370
> [  604.264544]  worker_thread+0x317/0x450
> [  604.264546]  ? __pfx_worker_thread+0x10/0x10
> [  604.264548]  kthread+0x10b/0x220
> [  604.264551]  ? recalc_sigpending+0x76/0xb0
> [  604.264553]  ? __pfx_kthread+0x10/0x10
> [  604.264556]  ret_from_fork+0x134/0x150
> [  604.264558]  ? __pfx_kthread+0x10/0x10
> [  604.264561]  ret_from_fork_asm+0x1a/0x30
> [  604.264565]  </TASK>
> [  604.264566] ---[ end trace 0000000000000000 ]---
> [  604.264618] ------------[ cut here ]------------
> [  604.264619] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.265538] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.265598]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.265631] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.265635] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.265636] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.265638] Workqueue: async async_run_entry_fn
> [  604.265643] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.266566] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.266569] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
> [  604.266571] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 000000000=
0000000
> [  604.266573] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.266574] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.266575] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.266576] R13: 0000000000000002 R14: 0000000000000002 R15: 000000000=
0000000
> [  604.266577] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000) knlG=
S:0000000000000000
> [  604.266578] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.266580] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.266581] Call Trace:
> [  604.266583]  <TASK>
> [  604.266586]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
> [  604.267483]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
> [  604.268375]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
> [  604.269253]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.270146]  pci_pm_suspend+0x85/0x1b0
> [  604.270152]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.270155]  dpm_run_callback+0x5f/0x160
> [  604.270159]  device_suspend+0x1e4/0x4e0
> [  604.270161]  async_suspend+0x21/0x40
> [  604.270163]  async_run_entry_fn+0x33/0x130
> [  604.270167]  process_one_work+0x18e/0x370
> [  604.270170]  worker_thread+0x317/0x450
> [  604.270172]  ? __pfx_worker_thread+0x10/0x10
> [  604.270173]  kthread+0x10b/0x220
> [  604.270176]  ? recalc_sigpending+0x76/0xb0
> [  604.270179]  ? __pfx_kthread+0x10/0x10
> [  604.270181]  ret_from_fork+0x134/0x150
> [  604.270184]  ? __pfx_kthread+0x10/0x10
> [  604.270186]  ret_from_fork_asm+0x1a/0x30
> [  604.270191]  </TASK>
> [  604.270192] ---[ end trace 0000000000000000 ]---
> [  604.270242] ------------[ cut here ]------------
> [  604.270243] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.271162] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.271222]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.271255] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.271260] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.271260] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.271262] Workqueue: async async_run_entry_fn
> [  604.271267] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.272177] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.272180] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
> [  604.272182] RAX: 0000000000000000 RBX: ffff8edc1d6ad440 RCX: 000000000=
0000000
> [  604.272184] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.272185] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.272186] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.272187] R13: 0000000000000000 R14: 0000000000000002 R15: 000000000=
0000000
> [  604.272188] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000) knlG=
S:0000000000000000
> [  604.272189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.272190] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.272192] Call Trace:
> [  604.272193]  <TASK>
> [  604.272197]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
> [  604.273091]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
> [  604.273992]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
> [  604.274885]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.275774]  pci_pm_suspend+0x85/0x1b0
> [  604.275780]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.275782]  dpm_run_callback+0x5f/0x160
> [  604.275786]  device_suspend+0x1e4/0x4e0
> [  604.275789]  async_suspend+0x21/0x40
> [  604.275791]  async_run_entry_fn+0x33/0x130
> [  604.275794]  process_one_work+0x18e/0x370
> [  604.275798]  worker_thread+0x317/0x450
> [  604.275799]  ? __pfx_worker_thread+0x10/0x10
> [  604.275801]  kthread+0x10b/0x220
> [  604.275804]  ? recalc_sigpending+0x76/0xb0
> [  604.275807]  ? __pfx_kthread+0x10/0x10
> [  604.275809]  ret_from_fork+0x134/0x150
> [  604.275812]  ? __pfx_kthread+0x10/0x10
> [  604.275814]  ret_from_fork_asm+0x1a/0x30
> [  604.275818]  </TASK>
> [  604.275819] ---[ end trace 0000000000000000 ]---
> [  604.275870] ------------[ cut here ]------------
> [  604.275871] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.276783] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.276844]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.276877] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.276881] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.276882] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.276883] Workqueue: async async_run_entry_fn
> [  604.276889] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.277807] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.277810] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
> [  604.277812] RAX: 0000000000000000 RBX: ffff8edc1d6ad440 RCX: 000000000=
0000000
> [  604.277814] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.277815] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.277816] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.277817] R13: 0000000000000001 R14: 0000000000000002 R15: 000000000=
0000000
> [  604.277818] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000) knlG=
S:0000000000000000
> [  604.277819] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.277820] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.277822] Call Trace:
> [  604.277823]  <TASK>
> [  604.277827]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
> [  604.278729]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
> [  604.279624]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
> [  604.280518]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.281407]  pci_pm_suspend+0x85/0x1b0
> [  604.281412]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.281415]  dpm_run_callback+0x5f/0x160
> [  604.281419]  device_suspend+0x1e4/0x4e0
> [  604.281421]  async_suspend+0x21/0x40
> [  604.281423]  async_run_entry_fn+0x33/0x130
> [  604.281427]  process_one_work+0x18e/0x370
> [  604.281430]  worker_thread+0x317/0x450
> [  604.281432]  ? __pfx_worker_thread+0x10/0x10
> [  604.281434]  kthread+0x10b/0x220
> [  604.281437]  ? recalc_sigpending+0x76/0xb0
> [  604.281439]  ? __pfx_kthread+0x10/0x10
> [  604.281442]  ret_from_fork+0x134/0x150
> [  604.281444]  ? __pfx_kthread+0x10/0x10
> [  604.281446]  ret_from_fork_asm+0x1a/0x30
> [  604.281451]  </TASK>
> [  604.281452] ---[ end trace 0000000000000000 ]---
> [  604.281510] ------------[ cut here ]------------
> [  604.281511] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.282435] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.282494]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.282527] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.282532] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.282533] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.282534] Workqueue: async async_run_entry_fn
> [  604.282540] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.283454] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.283456] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
> [  604.283459] RAX: 0000000000000000 RBX: ffff8edc1d6adf08 RCX: 000000000=
0000000
> [  604.283460] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.283461] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.283462] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.283463] R13: 0000000000000000 R14: 0000000000000002 R15: 000000000=
0000000
> [  604.283464] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000) knlG=
S:0000000000000000
> [  604.283465] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.283467] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.283468] Call Trace:
> [  604.283469]  <TASK>
> [  604.283473]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
> [  604.284377]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
> [  604.285266]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
> [  604.286158]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.287044]  pci_pm_suspend+0x85/0x1b0
> [  604.287051]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.287054]  dpm_run_callback+0x5f/0x160
> [  604.287058]  device_suspend+0x1e4/0x4e0
> [  604.287061]  async_suspend+0x21/0x40
> [  604.287063]  async_run_entry_fn+0x33/0x130
> [  604.287066]  process_one_work+0x18e/0x370
> [  604.287070]  worker_thread+0x317/0x450
> [  604.287071]  ? __pfx_worker_thread+0x10/0x10
> [  604.287073]  kthread+0x10b/0x220
> [  604.287076]  ? recalc_sigpending+0x76/0xb0
> [  604.287079]  ? __pfx_kthread+0x10/0x10
> [  604.287081]  ret_from_fork+0x134/0x150
> [  604.287084]  ? __pfx_kthread+0x10/0x10
> [  604.287086]  ret_from_fork_asm+0x1a/0x30
> [  604.287090]  </TASK>
> [  604.287091] ---[ end trace 0000000000000000 ]---
> [  604.287150] ------------[ cut here ]------------
> [  604.287151] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.288065] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.288124]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.288157] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.288161] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.288162] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.288163] Workqueue: async async_run_entry_fn
> [  604.288168] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.289092] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.289095] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
> [  604.289097] RAX: 0000000000000000 RBX: ffff8edc1d6adf08 RCX: 000000000=
0000000
> [  604.289099] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.289100] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.289101] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.289102] R13: 0000000000000000 R14: 0000000000000002 R15: 000000000=
0000000
> [  604.289104] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000) knlG=
S:0000000000000000
> [  604.289105] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.289106] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.289108] Call Trace:
> [  604.289109]  <TASK>
> [  604.289113]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
> [  604.290008]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
> [  604.290898]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
> [  604.291804]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.292693]  pci_pm_suspend+0x85/0x1b0
> [  604.292700]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.292703]  dpm_run_callback+0x5f/0x160
> [  604.292707]  device_suspend+0x1e4/0x4e0
> [  604.292710]  async_suspend+0x21/0x40
> [  604.292712]  async_run_entry_fn+0x33/0x130
> [  604.292715]  process_one_work+0x18e/0x370
> [  604.292718]  worker_thread+0x317/0x450
> [  604.292720]  ? __pfx_worker_thread+0x10/0x10
> [  604.292722]  kthread+0x10b/0x220
> [  604.292725]  ? recalc_sigpending+0x76/0xb0
> [  604.292727]  ? __pfx_kthread+0x10/0x10
> [  604.292730]  ret_from_fork+0x134/0x150
> [  604.292732]  ? __pfx_kthread+0x10/0x10
> [  604.292735]  ret_from_fork_asm+0x1a/0x30
> [  604.292739]  </TASK>
> [  604.292740] ---[ end trace 0000000000000000 ]---
> [  604.292797] ------------[ cut here ]------------
> [  604.292798] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.293717] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.293776]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.293809] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.293813] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.293814] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.293816] Workqueue: async async_run_entry_fn
> [  604.293821] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.294743] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.294746] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
> [  604.294749] RAX: 0000000000000000 RBX: ffff8edc1d6adf08 RCX: 000000000=
0000000
> [  604.294750] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.294751] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.294752] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.294753] R13: 0000000000000000 R14: 0000000000000002 R15: 000000000=
0000000
> [  604.294754] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000) knlG=
S:0000000000000000
> [  604.294756] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.294757] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.294758] Call Trace:
> [  604.294759]  <TASK>
> [  604.294763]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
> [  604.295655]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
> [  604.296554]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
> [  604.297444]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.298317]  pci_pm_suspend+0x85/0x1b0
> [  604.298321]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.298324]  dpm_run_callback+0x5f/0x160
> [  604.298328]  device_suspend+0x1e4/0x4e0
> [  604.298331]  async_suspend+0x21/0x40
> [  604.298333]  async_run_entry_fn+0x33/0x130
> [  604.298336]  process_one_work+0x18e/0x370
> [  604.298339]  worker_thread+0x317/0x450
> [  604.298341]  ? __pfx_worker_thread+0x10/0x10
> [  604.298343]  kthread+0x10b/0x220
> [  604.298346]  ? recalc_sigpending+0x76/0xb0
> [  604.298349]  ? __pfx_kthread+0x10/0x10
> [  604.298351]  ret_from_fork+0x134/0x150
> [  604.298353]  ? __pfx_kthread+0x10/0x10
> [  604.298366]  ret_from_fork_asm+0x1a/0x30
> [  604.298372]  </TASK>
> [  604.298373] ---[ end trace 0000000000000000 ]---
> [  604.298431] ------------[ cut here ]------------
> [  604.298432] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.299345] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.299415]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.299448] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.299452] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.299453] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.299454] Workqueue: async async_run_entry_fn
> [  604.299459] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.300382] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.300385] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
> [  604.300388] RAX: 0000000000000000 RBX: ffff8edc1d6af6f8 RCX: 000000000=
0000000
> [  604.300389] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.300390] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.300392] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.300393] R13: 0000000000000000 R14: 0000000000000002 R15: 000000000=
0000000
> [  604.300394] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000) knlG=
S:0000000000000000
> [  604.300395] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.300396] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.300398] Call Trace:
> [  604.300399]  <TASK>
> [  604.300403]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
> [  604.301294]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
> [  604.302194]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
> [  604.303113]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.304092]  pci_pm_suspend+0x85/0x1b0
> [  604.304098]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.304100]  dpm_run_callback+0x5f/0x160
> [  604.304104]  device_suspend+0x1e4/0x4e0
> [  604.304107]  async_suspend+0x21/0x40
> [  604.304109]  async_run_entry_fn+0x33/0x130
> [  604.304112]  process_one_work+0x18e/0x370
> [  604.304116]  worker_thread+0x317/0x450
> [  604.304117]  ? __pfx_worker_thread+0x10/0x10
> [  604.304119]  kthread+0x10b/0x220
> [  604.304122]  ? recalc_sigpending+0x76/0xb0
> [  604.304125]  ? __pfx_kthread+0x10/0x10
> [  604.304127]  ret_from_fork+0x134/0x150
> [  604.304130]  ? __pfx_kthread+0x10/0x10
> [  604.304132]  ret_from_fork_asm+0x1a/0x30
> [  604.304137]  </TASK>
> [  604.304138] ---[ end trace 0000000000000000 ]---
> [  604.304195] ------------[ cut here ]------------
> [  604.304196] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.305131] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.305192]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.305227] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.305231] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.305232] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.305233] Workqueue: async async_run_entry_fn
> [  604.305239] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.306233] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.306236] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
> [  604.306238] RAX: 0000000000000000 RBX: ffff8edc1d6af6f8 RCX: 000000000=
0000000
> [  604.306240] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.306241] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.306242] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.306243] R13: 0000000000000000 R14: 0000000000000002 R15: 000000000=
0000000
> [  604.306244] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000) knlG=
S:0000000000000000
> [  604.306245] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.306246] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.306248] Call Trace:
> [  604.306249]  <TASK>
> [  604.306253]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
> [  604.307150]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
> [  604.308044]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
> [  604.308934]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.309814]  pci_pm_suspend+0x85/0x1b0
> [  604.309819]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.309822]  dpm_run_callback+0x5f/0x160
> [  604.309826]  device_suspend+0x1e4/0x4e0
> [  604.309828]  async_suspend+0x21/0x40
> [  604.309830]  async_run_entry_fn+0x33/0x130
> [  604.309834]  process_one_work+0x18e/0x370
> [  604.309837]  worker_thread+0x317/0x450
> [  604.309839]  ? __pfx_worker_thread+0x10/0x10
> [  604.309841]  kthread+0x10b/0x220
> [  604.309844]  ? recalc_sigpending+0x76/0xb0
> [  604.309846]  ? __pfx_kthread+0x10/0x10
> [  604.309848]  ret_from_fork+0x134/0x150
> [  604.309851]  ? __pfx_kthread+0x10/0x10
> [  604.309853]  ret_from_fork_asm+0x1a/0x30
> [  604.309858]  </TASK>
> [  604.309859] ---[ end trace 0000000000000000 ]---
> [  604.309916] ------------[ cut here ]------------
> [  604.309917] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.310833] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.310893]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.310926] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.310930] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.310931] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.310932] Workqueue: async async_run_entry_fn
> [  604.310937] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.311850] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.311853] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
> [  604.311855] RAX: 0000000000000000 RBX: ffff8edc1d6af6f8 RCX: 000000000=
0000000
> [  604.311856] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.311857] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.311858] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.311859] R13: 0000000000000000 R14: 0000000000000002 R15: 000000000=
0000000
> [  604.311860] FS:  0000000000000000(0000) GS:ffff8edf19670000(0000) knlG=
S:0000000000000000
> [  604.311862] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.311863] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.311864] Call Trace:
> [  604.311866]  <TASK>
> [  604.311869]  amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
> [  604.312766]  ? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
> [  604.313662]  amdgpu_device_suspend+0x10a/0x170 [amdgpu]
> [  604.314562]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.315452]  pci_pm_suspend+0x85/0x1b0
> [  604.315457]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.315460]  dpm_run_callback+0x5f/0x160
> [  604.315464]  device_suspend+0x1e4/0x4e0
> [  604.315466]  async_suspend+0x21/0x40
> [  604.315468]  async_run_entry_fn+0x33/0x130
> [  604.315472]  process_one_work+0x18e/0x370
> [  604.315475]  worker_thread+0x317/0x450
> [  604.315477]  ? __pfx_worker_thread+0x10/0x10
> [  604.315478]  kthread+0x10b/0x220
> [  604.315481]  ? recalc_sigpending+0x76/0xb0
> [  604.315483]  ? __pfx_kthread+0x10/0x10
> [  604.315486]  ret_from_fork+0x134/0x150
> [  604.315489]  ? __pfx_kthread+0x10/0x10
> [  604.315491]  ret_from_fork_asm+0x1a/0x30
> [  604.315495]  </TASK>
> [  604.315497] ---[ end trace 0000000000000000 ]---
> [  604.330697] ------------[ cut here ]------------
> [  604.330700] WARNING: CPU: 1 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.331627] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.331689]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.331725] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.331730] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.331730] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.331732] Workqueue: async async_run_entry_fn
> [  604.331739] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.332660] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.332662] RSP: 0018:ffffd4e34aa37c30 EFLAGS: 00010246
> [  604.332665] RAX: 0000000000000000 RBX: ffff8edc1d6a5a38 RCX: 000000000=
0000000
> [  604.332666] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.332667] RBP: ffffd4e34aa37c50 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.332668] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.332669] R13: 0000000000000000 R14: ffff8edc1d6d0d88 R15: ffff8edc1=
d680000
> [  604.332671] FS:  0000000000000000(0000) GS:ffff8edf196f0000(0000) knlG=
S:0000000000000000
> [  604.332672] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.332673] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.332675] Call Trace:
> [  604.332676]  <TASK>
> [  604.332681]  gfx_v8_0_hw_fini+0x2a/0x3a0 [amdgpu]
> [  604.333595]  gfx_v8_0_suspend+0xe/0x20 [amdgpu]
> [  604.334511]  amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]
> [  604.335403]  amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdgpu]
> [  604.336277]  amdgpu_device_suspend+0x113/0x170 [amdgpu]
> [  604.337160]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.338049]  pci_pm_suspend+0x85/0x1b0
> [  604.338054]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.338056]  dpm_run_callback+0x5f/0x160
> [  604.338060]  device_suspend+0x1e4/0x4e0
> [  604.338063]  async_suspend+0x21/0x40
> [  604.338065]  async_run_entry_fn+0x33/0x130
> [  604.338069]  process_one_work+0x18e/0x370
> [  604.338072]  worker_thread+0x317/0x450
> [  604.338074]  ? __pfx_worker_thread+0x10/0x10
> [  604.338075]  kthread+0x10b/0x220
> [  604.338078]  ? recalc_sigpending+0x76/0xb0
> [  604.338081]  ? __pfx_kthread+0x10/0x10
> [  604.338083]  ret_from_fork+0x134/0x150
> [  604.338086]  ? __pfx_kthread+0x10/0x10
> [  604.338088]  ret_from_fork_asm+0x1a/0x30
> [  604.338092]  </TASK>
> [  604.338093] ---[ end trace 0000000000000000 ]---
> [  604.338150] ------------[ cut here ]------------
> [  604.338151] WARNING: CPU: 1 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.339074] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.339132]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.339165] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.339169] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.339170] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.339171] Workqueue: async async_run_entry_fn
> [  604.339176] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.340096] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.340098] RSP: 0018:ffffd4e34aa37c30 EFLAGS: 00010246
> [  604.340101] RAX: 0000000000000000 RBX: ffff8edc1d6a5a50 RCX: 000000000=
0000000
> [  604.340102] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.340103] RBP: ffffd4e34aa37c50 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.340104] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.340105] R13: 0000000000000000 R14: ffff8edc1d6d0d88 R15: ffff8edc1=
d680000
> [  604.340106] FS:  0000000000000000(0000) GS:ffff8edf196f0000(0000) knlG=
S:0000000000000000
> [  604.340108] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.340109] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.340111] Call Trace:
> [  604.340112]  <TASK>
> [  604.340115]  gfx_v8_0_hw_fini+0x3b/0x3a0 [amdgpu]
> [  604.341033]  gfx_v8_0_suspend+0xe/0x20 [amdgpu]
> [  604.341948]  amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]
> [  604.342836]  amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdgpu]
> [  604.343723]  amdgpu_device_suspend+0x113/0x170 [amdgpu]
> [  604.344619]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.345520]  pci_pm_suspend+0x85/0x1b0
> [  604.345526]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.345529]  dpm_run_callback+0x5f/0x160
> [  604.345533]  device_suspend+0x1e4/0x4e0
> [  604.345535]  async_suspend+0x21/0x40
> [  604.345538]  async_run_entry_fn+0x33/0x130
> [  604.345541]  process_one_work+0x18e/0x370
> [  604.345545]  worker_thread+0x317/0x450
> [  604.345546]  ? __pfx_worker_thread+0x10/0x10
> [  604.345548]  kthread+0x10b/0x220
> [  604.345551]  ? recalc_sigpending+0x76/0xb0
> [  604.345553]  ? __pfx_kthread+0x10/0x10
> [  604.345556]  ret_from_fork+0x134/0x150
> [  604.345558]  ? __pfx_kthread+0x10/0x10
> [  604.345561]  ret_from_fork_asm+0x1a/0x30
> [  604.345565]  </TASK>
> [  604.345566] ---[ end trace 0000000000000000 ]---
> [  604.345618] ------------[ cut here ]------------
> [  604.345619] WARNING: CPU: 1 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.346540] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.346598]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.346631] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.346636] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.346636] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.346638] Workqueue: async async_run_entry_fn
> [  604.346643] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.347566] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.347568] RSP: 0018:ffffd4e34aa37c30 EFLAGS: 00010246
> [  604.347571] RAX: 0000000000000000 RBX: ffff8edc1d6a5a80 RCX: 000000000=
0000000
> [  604.347572] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.347573] RBP: ffffd4e34aa37c50 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.347574] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.347575] R13: 0000000000000000 R14: ffff8edc1d6d0d88 R15: ffff8edc1=
d680000
> [  604.347577] FS:  0000000000000000(0000) GS:ffff8edf196f0000(0000) knlG=
S:0000000000000000
> [  604.347578] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.347579] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.347581] Call Trace:
> [  604.347582]  <TASK>
> [  604.347586]  gfx_v8_0_hw_fini+0x4c/0x3a0 [amdgpu]
> [  604.348508]  gfx_v8_0_suspend+0xe/0x20 [amdgpu]
> [  604.349417]  amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]
> [  604.350300]  amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdgpu]
> [  604.351188]  amdgpu_device_suspend+0x113/0x170 [amdgpu]
> [  604.352081]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.352969]  pci_pm_suspend+0x85/0x1b0
> [  604.352975]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.352977]  dpm_run_callback+0x5f/0x160
> [  604.352981]  device_suspend+0x1e4/0x4e0
> [  604.352984]  async_suspend+0x21/0x40
> [  604.352986]  async_run_entry_fn+0x33/0x130
> [  604.352989]  process_one_work+0x18e/0x370
> [  604.352993]  worker_thread+0x317/0x450
> [  604.352994]  ? __pfx_worker_thread+0x10/0x10
> [  604.352996]  kthread+0x10b/0x220
> [  604.352999]  ? recalc_sigpending+0x76/0xb0
> [  604.353002]  ? __pfx_kthread+0x10/0x10
> [  604.353004]  ret_from_fork+0x134/0x150
> [  604.353007]  ? __pfx_kthread+0x10/0x10
> [  604.353009]  ret_from_fork_asm+0x1a/0x30
> [  604.353013]  </TASK>
> [  604.353014] ---[ end trace 0000000000000000 ]---
> [  604.353064] ------------[ cut here ]------------
> [  604.353064] WARNING: CPU: 1 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.353984] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  604.354042]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  604.354074] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  604.354078] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  604.354079] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  604.354081] Workqueue: async async_run_entry_fn
> [  604.354086] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  604.355008] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  604.355010] RSP: 0018:ffffd4e34aa37c30 EFLAGS: 00010246
> [  604.355013] RAX: 0000000000000000 RBX: ffff8edc1d6a5a98 RCX: 000000000=
0000000
> [  604.355014] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  604.355015] RBP: ffffd4e34aa37c50 R08: 0000000000000000 R09: 000000000=
0000000
> [  604.355016] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  604.355017] R13: 0000000000000000 R14: ffff8edc1d6d0d88 R15: ffff8edc1=
d680000
> [  604.355018] FS:  0000000000000000(0000) GS:ffff8edf196f0000(0000) knlG=
S:0000000000000000
> [  604.355019] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  604.355021] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  604.355022] Call Trace:
> [  604.355023]  <TASK>
> [  604.355027]  gfx_v8_0_hw_fini+0x5d/0x3a0 [amdgpu]
> [  604.355934]  gfx_v8_0_suspend+0xe/0x20 [amdgpu]
> [  604.356852]  amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]
> [  604.357726]  amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdgpu]
> [  604.358609]  amdgpu_device_suspend+0x113/0x170 [amdgpu]
> [  604.359499]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  604.360391]  pci_pm_suspend+0x85/0x1b0
> [  604.360396]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  604.360399]  dpm_run_callback+0x5f/0x160
> [  604.360403]  device_suspend+0x1e4/0x4e0
> [  604.360405]  async_suspend+0x21/0x40
> [  604.360408]  async_run_entry_fn+0x33/0x130
> [  604.360411]  process_one_work+0x18e/0x370
> [  604.360415]  worker_thread+0x317/0x450
> [  604.360416]  ? __pfx_worker_thread+0x10/0x10
> [  604.360418]  kthread+0x10b/0x220
> [  604.360421]  ? recalc_sigpending+0x76/0xb0
> [  604.360424]  ? __pfx_kthread+0x10/0x10
> [  604.360426]  ret_from_fork+0x134/0x150
> [  604.360429]  ? __pfx_kthread+0x10/0x10
> [  604.360431]  ret_from_fork_asm+0x1a/0x30
> [  604.360435]  </TASK>
> [  604.360436] ---[ end trace 0000000000000000 ]---
> [  604.600867] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]=
] *ERROR* ring kiq_0.2.1.0 test failed (-110)
> [  604.601775] [drm:gfx_v8_0_hw_fini [amdgpu]] *ERROR* KCQ disable failed
> [  604.837747] amdgpu: cp is busy, skip halt cp
> [  605.072838] amdgpu: rlc is busy, skip halt rlc
> [  605.073900] ------------[ cut here ]------------
> [  605.073901] WARNING: CPU: 1 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  605.074834] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
> [  605.074894]  joydev input_leds mac_hid sch_fq_codel ppdev lp msr parpo=
rt_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 =
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx x=
or raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc ps=
mouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmul=
ni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_st=
orage aesni_intel
> [  605.074929] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P   =
     W  O        6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)
> [  605.074934] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE
> [  605.074935] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 =
01/29/2018
> [  605.074936] Workqueue: async async_run_entry_fn
> [  605.074942] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
> [  605.075902] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 <=
0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
> [  605.075904] RSP: 0018:ffffd4e34aa37c50 EFLAGS: 00010246
> [  605.075907] RAX: 0000000000000000 RBX: ffff8edc1d680c70 RCX: 000000000=
0000000
> [  605.075908] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [  605.075909] RBP: ffffd4e34aa37c70 R08: 0000000000000000 R09: 000000000=
0000000
> [  605.075910] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1=
d680000
> [  605.075911] R13: 0000000000000000 R14: ffff8edc1d6d0d58 R15: ffff8edc1=
d680000
> [  605.075913] FS:  0000000000000000(0000) GS:ffff8edf196f0000(0000) knlG=
S:0000000000000000
> [  605.075914] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  605.075915] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0
> [  605.075917] Call Trace:
> [  605.075918]  <TASK>
> [  605.075919]  ? delay_halt.part.0+0x3e/0x70
> [  605.075927]  gmc_v8_0_hw_fini+0x1f/0xb0 [amdgpu]
> [  605.076856]  gmc_v8_0_suspend+0xe/0x20 [amdgpu]
> [  605.077781]  amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]
> [  605.078676]  amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdgpu]
> [  605.079560]  amdgpu_device_suspend+0x113/0x170 [amdgpu]
> [  605.080438]  amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
> [  605.081318]  pci_pm_suspend+0x85/0x1b0
> [  605.081323]  ? __pfx_pci_pm_suspend+0x10/0x10
> [  605.081326]  dpm_run_callback+0x5f/0x160
> [  605.081330]  device_suspend+0x1e4/0x4e0
> [  605.081332]  async_suspend+0x21/0x40
> [  605.081335]  async_run_entry_fn+0x33/0x130
> [  605.081339]  process_one_work+0x18e/0x370
> [  605.081342]  worker_thread+0x317/0x450
> [  605.081344]  ? __pfx_worker_thread+0x10/0x10
> [  605.081345]  kthread+0x10b/0x220
> [  605.081348]  ? recalc_sigpending+0x76/0xb0
> [  605.081351]  ? __pfx_kthread+0x10/0x10
> [  605.081353]  ret_from_fork+0x134/0x150
> [  605.081368]  ? __pfx_kthread+0x10/0x10
> [  605.081371]  ret_from_fork_asm+0x1a/0x30
> [  605.081375]  </TASK>
> [  605.081376] ---[ end trace 0000000000000000 ]---
> [  605.083479] amdgpu 0000:03:00.0: amdgpu: PCI CONFIG reset
> [  605.083699] ACPI: EC: interrupt blocked
> [  605.109649] ACPI: PM: Preparing to enter system sleep state S3
> [  605.435280] ACPI Warning: Time parameter 120 us > 100 us violating ACP=
I spec, please fix the firmware. (20250807/exsystem-142)
> [  605.436113] ACPI: EC: event blocked
> [  605.436114] ACPI: EC: EC stopped
> [  605.436115] ACPI: PM: Saving platform NVS memory
> [  605.436214] Disabling non-boot CPUs ...
> [  605.438631] smpboot: CPU 3 is now offline
> [  605.442252] smpboot: CPU 2 is now offline
> [  605.445111] smpboot: CPU 1 is now offline
> [  605.447033] ACPI: PM: Low-level resume complete
> [  605.447067] ACPI: EC: EC started
> [  605.447069] ACPI: PM: Restoring platform NVS memory
> [  605.447227] AMD-Vi: Virtual APIC enabled
> [  605.447251] AMD-Vi: Virtual APIC enabled
> [  605.447254] LVT offset 0 assigned for vector 0x400
> [  605.447757] Enabling non-boot CPUs ...
> [  605.447830] smpboot: Booting Node 0 Processor 1 APIC 0x11
> [  605.451533] CPU1 is up
> [  605.451598] smpboot: Booting Node 0 Processor 2 APIC 0x12
> [  605.455447] CPU2 is up
> [  605.455507] smpboot: Booting Node 0 Processor 3 APIC 0x13
> [  605.459382] CPU3 is up
> [  605.460791] ACPI: PM: Waking up from system sleep state S3
> [  605.512016] ACPI: EC: interrupt unblocked
> [  605.518861] [drm] PCIE GART of 1024M enabled (table at 0x000000F400A00=
000).
> [  605.518874] ACPI: EC: event unblocked
> [  605.518899] amdgpu: smu version 27.17.00
> [  605.536571] [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF800=
00).
> [  605.551074] [drm] UVD initialized successfully.
> [  605.718769] [drm] UVD and UVD ENC initialized successfully.
> [  605.752031] [drm] VCE initialized successfully.
> [  605.763611] usb 1-2: reset high-speed USB device number 2 using xhci_h=
cd
> [  605.773339] usb 2-1.4: reset high-speed USB device number 4 using ehci=
-pci
> [  605.819760] [drm] VCE initialized successfully.
> [  605.939506] usb 2-1.2: reset full-speed USB device number 3 using ehci=
-pci
> [  605.984372] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [  605.986837] sd 1:0:0:0: [sda] Starting disk
> [  605.990324] ata1.00: configured for UDMA/133
> [  606.034393] OOM killer enabled.
> [  606.034400] Restarting tasks: Starting
> [  606.036871] Restarting tasks: Done
> [  606.036937] random: crng reseeded on system resumption
> [  606.037313] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_000=
00302.bin
> [  606.037348] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmwa=
re rome 0x302 build 0x111
> [  606.049086] PM: suspend exit
> [  606.325705] Generic FE-GE Realtek PHY r8169-0-200:00: attached PHY dri=
ver (mii_bus:phy_addr=3Dr8169-0-200:00, irq=3DMAC)
> [  606.403987] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [  606.426895] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection=
 command is advertised, but not supported.
> [  606.481379] r8169 0000:02:00.0 enp2s0: Link is Down
> [  606.673801] Bluetooth: MGMT ver 1.23
> [  606.684146] kauditd_printk_skb: 6 callbacks suppressed
> [  606.684153] audit: type=3D1400 audit(1770175422.234:141): apparmor=3D"=
ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.ubunt=
u-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6784 comm=3D"pvscan"=
 requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=3D0 =
ouid=3D0 olabel=3D"unconfined"
> [  606.684159] audit: type=3D1400 audit(1770175422.234:142): apparmor=3D"=
ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.ubunt=
u-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6784 comm=3D"pvscan"=
 requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=3D0 =
ouid=3D0 olabel=3D"unconfined"
> [  606.684162] audit: type=3D1400 audit(1770175422.234:143): apparmor=3D"=
ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.ubunt=
u-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6784 comm=3D"pvscan"=
 requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=3D0 =
ouid=3D0 olabel=3D"unconfined"
> [  606.684165] audit: type=3D1400 audit(1770175422.234:144): apparmor=3D"=
ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.ubunt=
u-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6784 comm=3D"pvscan"=
 requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=3D0 =
ouid=3D0 olabel=3D"unconfined"
> [  606.763476] audit: type=3D1400 audit(1770175422.314:145): apparmor=3D"=
ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.ubunt=
u-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6789 comm=3D"vgscan"=
 requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=3D0 =
ouid=3D0 olabel=3D"unconfined"
> [  606.763489] audit: type=3D1400 audit(1770175422.314:146): apparmor=3D"=
ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.ubunt=
u-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6789 comm=3D"vgscan"=
 requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=3D0 =
ouid=3D0 olabel=3D"unconfined"
> [  606.763492] audit: type=3D1400 audit(1770175422.314:147): apparmor=3D"=
ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.ubunt=
u-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6789 comm=3D"vgscan"=
 requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=3D0 =
ouid=3D0 olabel=3D"unconfined"
> [  606.763494] audit: type=3D1400 audit(1770175422.314:148): apparmor=3D"=
ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.ubunt=
u-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6789 comm=3D"vgscan"=
 requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=3D0 =
ouid=3D0 olabel=3D"unconfined"
> [  606.857207] audit: type=3D1400 audit(1770175422.407:149): apparmor=3D"=
ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.ubunt=
u-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6790 comm=3D"vgchang=
e" requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=3D=
0 ouid=3D0 olabel=3D"unconfined"
> [  606.857221] audit: type=3D1400 audit(1770175422.407:150): apparmor=3D"=
ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.ubunt=
u-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6790 comm=3D"vgchang=
e" requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=3D=
0 ouid=3D0 olabel=3D"unconfined"
> ubuntu@ubuntu:~$
>
>
