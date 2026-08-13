Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0136C5B572
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 10:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24EC010F289;
	Thu, 13 Aug 2026 10:03:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.b="PCDCPXDX";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bg7ZmbxH";
	dkim-atps=neutral
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [85.215.255.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BA3A10F1FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 09:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786612229; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=FeucsKac0nFrgxKHDLLxpr5u6C7R/X/LPSwZTgYwh+/+li/yQlsF7f71z4I3lInQ/A
 Pr6h98v5biRdPUCpuGVyE6JMbf6WyiBIyX3aUeqxjjm5wHHJEytqycMP+tN2vUWPTESt
 QUmy1t2w0hc7Xa9eNVJ+wz5kE9FOcW6luXoLD7GbdNnnPTBKgGrp0CuCxoz7OevU+Bbt
 f/PuKVSIb7Rw6WcfDYrmou0MX1mQBqPNHMumcYkCtMeONJQ4FuelWgoMVzotpxIuZLf9
 tWt4264Vc6qcx9bIrT6xBEJAqxoPaHFmdQFIqlunBB3wGs52MRIKE78I98Mz4/pqiwLB
 bz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786612229;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:References:To:From:Subject:Date:Message-ID:Cc:Date:From:
 Subject:Sender;
 bh=U089r74j2tALkda6EjULVZmiw0e8gxNlGAvuBjA7160=;
 b=LfZ1gSx6MBlpB2avpt4KVmDUanZVHSv8n37WBE0/2d4oedUt8WUTa2FFiM4QhJiVs9
 UMAFtVC/4Pu5h3KdDEdlo0Fnz2O7dFyu4PyoxStn6c4b/a45rJma4N8Ty3TZrw3yjah4
 lnFIfwSaNDzhwMHBckC7fWcqek5P1egkuvt9+NwJQb9othc5w31LOmybppjjRdOrajbB
 goiX1knbGIPyeEpc+n4HqjDwF03KzlhI/Mt7wW5f1sBkY3MFRh0RO9wbQuXP4fU5U/33
 s0J62ePjgugBFydiXNArUPJ8Po41P+zgne5l3IyTAiWXNGaw1lzMigJaYNcWzrfeuv1F
 tztw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786612229;
 s=strato-dkim-0002; d=hartkopp.net;
 h=In-Reply-To:References:To:From:Subject:Date:Message-ID:Cc:Date:From:
 Subject:Sender;
 bh=U089r74j2tALkda6EjULVZmiw0e8gxNlGAvuBjA7160=;
 b=PCDCPXDXcWJ/tIsujiXfWbZ9S67zMuV9y3ppB3/HqOar+Sveyr9F7kC4LXkxl+NUFo
 k3z2hR/WpvrsobU9FCIMhOzB4R8VSr89Gr/Mwmq9Lk90IcP65809B0IjjTtGJEraUqzv
 JAERgzBymFSyKDEo5O67XUHmLhryMAr+dyKLTHL6oM9eMjoxbCtoKMJJBpfgcN27ILjr
 J6boAPQvoK+PG8rm/GwL3VndCm6yBgSuQl3Bw0E56xN32KRwi8qBhvKARwfzVVlxksaB
 4YLY+z2Q9bEGP61/u+a/ISpS2BmgWMaSceoaxQjsaKuWljTEOB/5IiQ8e/8BM/RdkHJ6
 CH8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786612229;
 s=strato-dkim-0003; d=hartkopp.net;
 h=In-Reply-To:References:To:From:Subject:Date:Message-ID:Cc:Date:From:
 Subject:Sender;
 bh=U089r74j2tALkda6EjULVZmiw0e8gxNlGAvuBjA7160=;
 b=bg7ZmbxH0gRhYe+SWod+UyiiPTDA+UwVt6zXxDWGus2sbZJM0/nIqK3OabwP75fnaH
 aItJ6oYpiXVUDIGdGADA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
 by smtp.strato.de (RZmta 55.5.6 AUTH) with ESMTPSA id K5281927D9ATi9g
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 13 Aug 2026 11:10:29 +0200 (CEST)
Message-ID: <086078ae-5824-4f63-9b63-95cb02ccaced@hartkopp.net>
Date: Thu, 13 Aug 2026 11:10:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING 7.2.0-rc7: [drm] REG_WAIT timeout 1us * 100 tries -
 dcn31_program_compbuf_size line:142
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, amd-gfx@lists.freedesktop.org
References: <f582f2c2-b097-42cf-a0a3-2a4bb28adf54@hartkopp.net>
Content-Language: en-US
In-Reply-To: <f582f2c2-b097-42cf-a0a3-2a4bb28adf54@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 10:03:25 +0000
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

I can now reproduce the warning.

Only in connection with an USB-C docking station which drives a second 
monitor (Philips 345B, 2440x1440 px) over DisplayPort together with the 
internal panel (1920x1200 px) of my ASUS Vivobook 18.

The used Lenovo dock:
https://www.lenovo.com/de/de/p/accessories-and-software/docking/docking-usb-docks/40ay0090eu

The warning shows up, when the displays are going back due to inactivity 
of the user.

I'm not subscribed on the amd-gfx ML - please put me in CC for replies.

Best regards,
Oliver

On 12.08.26 11:01, Oliver Hartkopp wrote:
> Hi all,
> 
> I got this warning at 2249.712413 and 4436.000606 this morning.
> Kernel 7.2.0-rc7 Debian forky/sid (laptop hw description below).
> 
> Any idea?
> 
> Best regards,
> Oliver
> 
> [ 2249.712413] amdgpu 0000:03:00.0: [drm] REG_WAIT timeout 1us * 100 
> tries - dcn31_program_compbuf_size line:142
> [ 2249.712493] ------------[ cut here ]------------
> [ 2249.712496] WARNING: drivers/gpu/drm/amd/amdgpu/../display/dc/hubbub/ 
> dcn31/dcn31_hubbub.c:151 at dcn31_program_compbuf_size+0xd2/0x230 
> [amdgpu], CPU#15: Xorg/981
> [ 2249.712833] Modules linked in: uhid ccm rfcomm algif_hash 
> algif_skcipher af_alg bnep dm_mod vcan can_dev nls_ascii nls_cp437 vfat 
> fat binfmt_misc mt7921e mt7921_common mt792x_lib mt76_connac_lib mt76 
> mac80211 btusb btintel btmtk snd_sof_amd_rembrandt bluetooth 
> snd_sof_amd_acp snd_sof_xtensa_dsp snd_sof_pci snd_sof uvcvideo amd_atl 
> videobuf2_vmalloc snd_hda_codec_alc269 videobuf2_memops snd_sof_utils 
> snd_hda_scodec_component intel_rapl_msr uvc snd_hda_codec_realtek_lib 
> snd_hda_codec_atihdmi intel_rapl_common videobuf2_v4l2 libarc4 
> snd_hda_codec_generic snd_hda_codec_hdmi ecdh_generic snd_soc_core 
> videodev cfg80211 snd_hda_intel amdxdna snd_compress snd_intel_dspcfg 
> videobuf2_common snd_hda_codec snd_acp_pci edac_mce_amd asus_nb_wmi 
> snd_acp_config mc aesni_intel asus_wmi snd_hwdep snd_amd_acpi_mach 
> gf128mul sparse_keymap snd_hda_core amd_pmf wmi_bmof 
> snd_acp_legacy_common pcspkr snd_soc_acpi spd5118 amdtee snd_pcm 
> drm_shmem_helper rfkill snd_timer amd_sfh ac snd ccp joydev tee button 
> soundcore k10temp evdev fuse
> [ 2249.712927]  efi_pstore autofs4 raid10 raid456 async_raid6_recov 
> async_memcpy async_pq async_xor xor async_tx raid6_pq raid1 raid0 md_mod 
> r8153_ecm cdc_ether usbnet mii usbhid amdgpu drm_client_lib i2c_algo_bit 
> drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper 
> drm_panel_backlight_quirks gpu_sched ucsi_acpi amdxcp xhci_pci 
> typec_ucsi hid_multitouch drm_display_helper roles hid_generic xhci_hcd 
> cec typec i2c_hid_acpi thunderbolt i2c_hid usbcore drm_kms_helper hid 
> sp5100_tco watchdog serio_raw usb_common battery configfs drm fan 
> i2c_piix4 i2c_smbus efivarfs
> [ 2249.712997] CPU: 15 UID: 0 PID: 981 Comm: Xorg Not tainted 7.2.0-rc7- 
> dirty #79 PREEMPT(full)
> [ 2249.713001] Hardware name: ASUSTeK COMPUTER INC. ASUS Vivobook 18 
> M1807HA_M1807HA/M1807HA, BIOS M1807HA.323 03/27/2026
> [ 2249.713005] RIP: 0010:dcn31_program_compbuf_size+0xd2/0x230 [amdgpu]
> [ 2249.713156] Code: 00 48 8b 43 28 8b 88 d8 01 00 00 48 8b 43 20 0f b6 
> 50 76 48 8b 43 18 8b b0 14 01 00 00 e8 36 9d 14 00 85 c0 0f 85 32 01 00 
> 00 <0f> 0b 48 8b 44 24 08 65 48 2b 05 cf 37 49 f3 0f 85 35 01 00 00 48
> [ 2249.713159] RSP: 0018:ffffd380c57a72b8 EFLAGS: 00010202
> [ 2249.713163] RAX: 0000000000000001 RBX: ffff8ae167ba5400 RCX: 
> 0000000000000001
> [ 2249.713166] RDX: ffffd380c2a8e5e8 RSI: 000000000000397a RDI: 
> ffff8ae0d3500000
> [ 2249.713168] RBP: ffff8ae146f04338 R08: 0000000080041619 R09: 
> 000000000000397a
> [ 2249.713170] R10: ffffd380c57a7238 R11: 0000000000000001 R12: 
> ffff8ae146f00000
> [ 2249.713172] R13: ffff8ae167ba5400 R14: ffff8ae18c800000 R15: 
> 0000000000000001
> [ 2249.713174] FS:  00007f4c5c84cb80(0000) GS:ffff8ae82a14d000(0000) 
> knlGS:0000000000000000
> [ 2249.713177] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2249.713179] CR2: 00007fc8bdbd1000 CR3: 00000001875bb000 CR4: 
> 0000000000f50ef0
> [ 2249.713181] PKRU: 55555554
> [ 2249.713183] Call Trace:
> [ 2249.713188]  <TASK>
> [ 2249.713193]  dcn20_optimize_bandwidth+0xfc/0x270 [amdgpu]
> [ 2249.713390]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.713397]  dc_commit_state_no_check+0xf9d/0x1950 [amdgpu]
> [ 2249.713575]  dc_commit_streams+0x315/0x690 [amdgpu]
> [ 2249.713726]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.713730]  ? dmub_srv_update_inbox_status.part.0+0x15/0xd0 [amdgpu]
> [ 2249.713936]  amdgpu_dm_atomic_commit_tail+0x63e/0x4160 [amdgpu]
> [ 2249.714161]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.714166]  ? dcn30_internal_validate_bw+0x9f2/0xdc0 [amdgpu]
> [ 2249.714377]  ? dc_fpu_end+0x97/0xc0 [amdgpu]
> [ 2249.714580]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.714584]  ? dcn314_validate_bandwidth+0xf7/0x2f0 [amdgpu]
> [ 2249.714793]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.714797]  ? dma_resv_get_fences+0xb2/0x290
> [ 2249.714805]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.714808]  ? dma_resv_get_singleton+0x43/0x130
> [ 2249.714812]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.714815]  ? wait_for_completion_timeout+0x118/0x150
> [ 2249.714822]  ? __wait_for_common+0x161/0x190
> [ 2249.714825]  ? hrtimer_nanosleep_restart+0x80/0x80
> [ 2249.714829]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.714834]  ? ttm_resource_move_to_lru_tail+0xd7/0x210 [ttm]
> [ 2249.714847]  commit_tail+0xae/0x150 [drm_kms_helper]
> [ 2249.714865]  drm_atomic_helper_commit+0x13c/0x180 [drm_kms_helper]
> [ 2249.714878]  drm_atomic_commit+0xb1/0xe0 [drm]
> [ 2249.714911]  ? 
> drm_plane_create_color_pipeline_property.cold+0x1e/0x1e [drm]
> [ 2249.714936]  drm_atomic_connector_commit_dpms+0xfa/0x110 [drm]
> [ 2249.714960]  drm_mode_obj_set_property_ioctl+0x1c4/0x410 [drm]
> [ 2249.714989]  ? drm_connector_set_obj_prop+0xa0/0xa0 [drm]
> [ 2249.715014]  drm_connector_property_set_ioctl+0x3c/0x60 [drm]
> [ 2249.715036]  drm_ioctl_kernel+0xae/0x100 [drm]
> [ 2249.715061]  drm_ioctl+0x2af/0x540 [drm]
> [ 2249.715085]  ? drm_connector_set_obj_prop+0xa0/0xa0 [drm]
> [ 2249.715109]  amdgpu_drm_ioctl+0x4a/0x80 [amdgpu]
> [ 2249.715227]  __x64_sys_ioctl+0x86/0xd0
> [ 2249.715234]  do_syscall_64+0xdd/0xfb0
> [ 2249.715240]  ? amdgpu_drm_ioctl+0x6a/0x80 [amdgpu]
> [ 2249.715360]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.715363]  ? __x64_sys_ioctl+0xa2/0xd0
> [ 2249.715366]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.715368]  ? do_syscall_64+0x5e3/0xfb0
> [ 2249.715372]  ? drm_connector_set_obj_prop+0xa0/0xa0 [drm]
> [ 2249.715387]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.715390]  ? drm_connector_property_set_ioctl+0x3c/0x60 [drm]
> [ 2249.715404]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.715406]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.715409]  ? __check_object_size+0x44/0x220
> [ 2249.715414]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.715417]  ? drm_ioctl+0x2e4/0x540 [drm]
> [ 2249.715432]  ? drm_connector_set_obj_prop+0xa0/0xa0 [drm]
> [ 2249.715448]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.715451]  ? amdgpu_drm_ioctl+0x6a/0x80 [amdgpu]
> [ 2249.715551]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.715554]  ? __x64_sys_ioctl+0xa2/0xd0
> [ 2249.715557]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.715559]  ? do_syscall_64+0x5e3/0xfb0
> [ 2249.715563]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.715565]  ? count_memcg_events+0xd9/0x210
> [ 2249.715572]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.715575]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.715577]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.715580]  ? irqentry_exit+0x3b7/0x790
> [ 2249.715583]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2249.715585]  ? do_syscall_64+0x94/0xfb0
> [ 2249.715588]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
> [ 2249.715592] RIP: 0033:0x7f4c5cbd0c3b
> [ 2249.715595] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 
> 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 
> 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [ 2249.715598] RSP: 002b:00007ffd6456a300 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000010
> [ 2249.715601] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
> 00007f4c5cbd0c3b
> [ 2249.715603] RDX: 00007ffd6456a390 RSI: 00000000c01064ab RDI: 
> 000000000000000e
> [ 2249.715605] RBP: 00007ffd6456a390 R08: 00007ffd6456a270 R09: 
> 00007f4c5d195000
> [ 2249.715606] R10: 00007f4c5c473cb0 R11: 0000000000000246 R12: 
> 00000000c01064ab
> [ 2249.715608] R13: 000000000000000e R14: 000055983db98c60 R15: 
> 0000000000000000
> [ 2249.715612]  </TASK>
> [ 2249.715614] ---[ end trace 0000000000000000 ]---
> [ 4436.000606] amdgpu 0000:03:00.0: [drm] REG_WAIT timeout 1us * 100 
> tries - dcn31_program_compbuf_size line:142
> 
> $ dmesg | grep amdgpu
> 
> 
> [    2.409005] amdgpu: Virtual CRAT table created for CPU
> [    2.409249] amdgpu: Topology: Add CPU node
> [    2.409585] amdgpu 0000:03:00.0: enabling device (0006 -> 0007)
> [    2.409825] amdgpu 0000:03:00.0: initializing kernel modesetting (IP 
> DISCOVERY 0x1002:0x1900 0x1043:0x3C68 0xB6).
> [    2.410161] amdgpu 0000:03:00.0: register mmio base: 0xFC900000
> [    2.410367] amdgpu 0000:03:00.0: register mmio size: 524288
> [    2.414020] amdgpu 0000:03:00.0: detected ip block number 0 
> <common_v1_0_0> (soc21_common)
> [    2.414239] amdgpu 0000:03:00.0: detected ip block number 1 
> <gmc_v11_0_0> (gmc_v11_0)
> [    2.414241] amdgpu 0000:03:00.0: detected ip block number 2 
> <ih_v6_0_0> (ih_v6_0)
> [    2.415168] amdgpu 0000:03:00.0: detected ip block number 3 
> <psp_v13_0_4> (psp)
> [    2.415416] amdgpu 0000:03:00.0: detected ip block number 4 
> <smu_v13_0_0> (smu)
> [    2.415662] amdgpu 0000:03:00.0: detected ip block number 5 
> <dce_v1_0_0> (dm)
> [    2.415902] amdgpu 0000:03:00.0: detected ip block number 6 
> <gfx_v11_0_0> (gfx_v11_0)
> [    2.416138] amdgpu 0000:03:00.0: detected ip block number 7 
> <sdma_v6_0_0> (sdma_v6_0)
> [    2.416376] amdgpu 0000:03:00.0: detected ip block number 8 
> <vcn_v4_0_0> (vcn_v4_0)
> [    2.416612] amdgpu 0000:03:00.0: detected ip block number 9 
> <jpeg_v4_0_0> (jpeg_v4_0)
> [    2.416852] amdgpu 0000:03:00.0: detected ip block number 10 
> <mes_v11_0_0> (mes_v11_0)
> [    2.417101] amdgpu 0000:03:00.0: Fetched VBIOS from VFCT
> [    2.417337] amdgpu 0000:03:00.0: [drm] ATOM BIOS: 113-PHXGENERIC-001, 
> build: 00159851, ver: 022.012.000.029.000001, 2025/08/05
> [    2.419984] amdgpu 0000:03:00.0: vgaarb: deactivate vga console
> [    2.419988] amdgpu 0000:03:00.0: Trusted Memory Zone (TMZ) feature 
> enabled
> [    2.420064] amdgpu 0000:03:00.0: vm size is 262144 GB, 4 levels, 
> block size is 9-bit, fragment size is 9-bit
> [    2.420091] amdgpu 0000:03:00.0: VRAM: 512M 0x0000008000000000 - 
> 0x000000801FFFFFFF (512M used)
> [    2.420095] amdgpu 0000:03:00.0: GART: 512M 0x00007FFF00000000 - 
> 0x00007FFF1FFFFFFF
> [    2.420107] amdgpu 0000:03:00.0: [drm] Detected VRAM RAM=512M, BAR=512M
> [    2.420111] amdgpu 0000:03:00.0: [drm] RAM width 128bits DDR5
> [    2.421125] amdgpu 0000:03:00.0:  512M of VRAM memory ready
> [    2.421129] amdgpu 0000:03:00.0:  15680M of GTT memory ready.
> [    2.421150] amdgpu 0000:03:00.0: [drm] GART: num cpu pages 131072, 
> num gpu pages 131072
> [    2.421526] amdgpu 0000:03:00.0: [drm] PCIE GART of 512M enabled 
> (table at 0x0000008000900000).
> [    2.422192] amdgpu 0000:03:00.0: [drm] Loading DMUB firmware via PSP: 
> version=0x08005D00
> [    2.422466] amdgpu 0000:03:00.0: [VCN instance 0] Found VCN firmware 
> Version ENC: 1.24 DEC: 9 VEP: 0 Revision: 34
> [    2.422572] amdgpu 0000:03:00.0: MES: vmid_mask_mmhub 0x0000ff00, 
> vmid_mask_gfxhub 0x0000ff00
> [    2.422576] amdgpu 0000:03:00.0: MES: gfx_hqd_mask 0x00000002, 
> compute_hqd_mask 0x0000000c, sdma_hqd_mask 0x000000fc
> [    2.447744] amdgpu 0000:03:00.0: reserve 0x4000000 from 0x8018000000 
> for PSP TMR
> [    3.006559] amdgpu 0000:03:00.0: RAS: optional ras ta ucode is not 
> available
> [    3.014774] amdgpu 0000:03:00.0: RAP: optional rap ta ucode is not 
> available
> [    3.014783] amdgpu 0000:03:00.0: SECUREDISPLAY: optional 
> securedisplay ta ucode is not available
> [    3.014935] amdgpu 0000:03:00.0: smu driver if version = 0x00000008, 
> smu fw if version = 0x00000008, smu fw program = 0, smu fw version = 
> 0x004c6500 (76.101.0)
> [    3.047178] amdgpu 0000:03:00.0: SMU is initialized successfully!
> [    3.047914] amdgpu 0000:03:00.0: [drm] Display Core v3.2.384 
> initialized on DCN 3.1.4
> [    3.047920] amdgpu 0000:03:00.0: [drm] DP-HDMI FRL PCON supported
> [    3.050319] amdgpu 0000:03:00.0: [drm] DMUB hardware initialized: 
> version=0x08005D00
> [    3.225181] amdgpu: Virtual CRAT table created for GPU
> [    3.225378] amdgpu: Topology: Add GPU node [0x1002:0x1900]
> [    3.225399] amdgpu 0000:03:00.0: SE 1, SH per SE 2, CU per SH 6, 
> active_cu_number 12
> [    3.225409] amdgpu 0000:03:00.0: ring gfx_0.0.0 uses VM inv eng 0 on 
> hub 0
> [    3.225416] amdgpu 0000:03:00.0: ring comp_1.0.0 uses VM inv eng 1 on 
> hub 0
> [    3.225421] amdgpu 0000:03:00.0: ring comp_1.1.0 uses VM inv eng 4 on 
> hub 0
> [    3.225426] amdgpu 0000:03:00.0: ring comp_1.2.0 uses VM inv eng 6 on 
> hub 0
> [    3.225431] amdgpu 0000:03:00.0: ring comp_1.3.0 uses VM inv eng 7 on 
> hub 0
> [    3.225436] amdgpu 0000:03:00.0: ring comp_1.0.1 uses VM inv eng 8 on 
> hub 0
> [    3.225441] amdgpu 0000:03:00.0: ring comp_1.1.1 uses VM inv eng 9 on 
> hub 0
> [    3.225445] amdgpu 0000:03:00.0: ring comp_1.2.1 uses VM inv eng 10 
> on hub 0
> [    3.225450] amdgpu 0000:03:00.0: ring comp_1.3.1 uses VM inv eng 11 
> on hub 0
> [    3.225455] amdgpu 0000:03:00.0: ring sdma0 uses VM inv eng 12 on hub 0
> [    3.225460] amdgpu 0000:03:00.0: ring vcn_unified_0 uses VM inv eng 0 
> on hub 8
> [    3.225465] amdgpu 0000:03:00.0: ring jpeg_dec uses VM inv eng 1 on 
> hub 8
> [    3.225470] amdgpu 0000:03:00.0: ring mes_kiq_3.1.0 uses VM inv eng 
> 13 on hub 0
> [    3.229168] amdgpu 0000:03:00.0: Runtime PM not available
> [    3.229461] amdgpu 0000:03:00.0: [drm] Using custom brightness curve
> [    3.230641] amdgpu 0000:03:00.0: [drm] Registered 4 planes with drm 
> panic
> [    3.244850] [drm] Initialized amdgpu 3.64.0 for 0000:03:00.0 on minor 0
> [    3.251516] fbcon: amdgpudrmfb (fb0) is primary device
> [    3.290174] amdgpu 0000:03:00.0: [drm] fb0: amdgpudrmfb frame buffer 
> device
> [    5.988394] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops 
> amdgpu_dm_audio_component_bind_ops [amdgpu])
> 

