Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2337AC48BF6
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Feb 2024 09:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63EF310EFA2;
	Mon, 26 Feb 2024 09:04:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="W70rxCb5";
	dkim-atps=neutral
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1056410EDB7
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Feb 2024 12:58:57 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-2d24a727f78so31802041fa.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Feb 2024 04:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1708865935; x=1709470735;
 darn=lists.freedesktop.org; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MMpM/uNHum/nPYM8vfM0fUZNpKz1YgzlBOlFe+0rDqI=;
 b=W70rxCb5qSGxiltolRP5efrHWlakK3lpK/rpIaO8D2vkLzXDEv/tb5uGVX52gQEHwk
 DhTGZkVux/iit6cPOoOEQkC4hilffwO2YQyNX2GdRXh4L5WWKFIt3we2JqzyWCUfpI9O
 6+3SFo4HWxq0uktsYR6gqn3BTnjN+fOMLURt0nlBMGa471MdqIHODxNcE67gnr44xOhJ
 SRByT81jC284r/wwGwHrWVT3VQivKlcOTDerBgV2JhplN2l/4Q6SLddPH+Uq0RIMiF9s
 vmA6DdLWmlviCFvZOAKy+/OU+VKKuWNt0xk6IvrSenBk4PMQd338UktIKSkB7LczCsRz
 KDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708865935; x=1709470735;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MMpM/uNHum/nPYM8vfM0fUZNpKz1YgzlBOlFe+0rDqI=;
 b=UQcvv64cTRqFFhdcizipv/hlZWHHC0we9sSIgAaZOdyAPAw4fHqjapY10F+34Wl2jO
 hTTCZtwF21s4C28wwQeQzBFkzci2dV74yWrtDIEH8VuAbxU3Y3fQ+lPWqF5gN5tW2yPP
 o3PdgkItrkwsfxGEkHr52H2gWEJLFNmFwCsT61oLqRK/9EqphVpgswiSvuAAIS13xfSt
 kLN0dV6f7kbhi49YT6FU+QTP0dIWS7s44I8k7iybLcJzSxiIWSkHQdN9AZIQMlCQU0z1
 +QGGoicZo005mF7CH0Hx+E3OamnJYQArnPHJzn9Opp1IfApcnFvxeB2moTSHg5wH0i/i
 baHw==
X-Gm-Message-State: AOJu0YwCqE4RxDU/QnjVE5cmG7jN33CuAM3DeZ2LZz4CbdJieY2S/POs
 RYoAtUVuAt1YpDgGXlm3SjC4ozqkEw9whCGrR3wwpl7y3br3Gh0bb5DDeX4iYMmUv1TSAsL0ntE
 3CgcEAMfO11pgXQSXP66t6xoHrl0i/SIGUXo=
X-Google-Smtp-Source: AGHT+IGsee7mOczQvbC+nMiZJoo8WG+ePi/ILtwsx3v81s1B9RkMg+wCdXG+UqGt5TbJdY3lzse+ns/S5rJAvxJoVwI=
X-Received: by 2002:a2e:a265:0:b0:2d2:74ee:bec1 with SMTP id
 k5-20020a2ea265000000b002d274eebec1mr2809171ljm.48.1708865934703; Sun, 25 Feb
 2024 04:58:54 -0800 (PST)
MIME-Version: 1.0
From: Karsten Wiese <fzuuzf@googlemail.com>
Date: Sun, 25 Feb 2024 13:58:42 +0100
Message-ID: <CAM=nh0R12-jy8yxCKcY0qqsL=NAzPfFgXdbyjRRtT+sWgvcJ2g@mail.gmail.com>
Subject: WARNING: in amdgpu_dm_atomic_commit_tail
To: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 26 Feb 2024 09:04:42 +0000
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

Hello,

this warning and drm error keep appearing here past wakeup from suspend:

[  247.716103] Freezing remaining freezable tasks
[  247.717379] Freezing remaining freezable tasks completed (elapsed
0.001 seconds)
[  247.717387] printk: Suspending console(s) (use no_console_suspend to debug)
[  247.871602] ACPI: EC: interrupt blocked
[  247.949021] ACPI: EC: interrupt unblocked
[  248.538831] [drm] PCIE GART of 512M enabled (table at 0x000000803FD00000).
[  248.538861] amdgpu 0000:65:00.0: amdgpu: SMU is resuming...
[  248.541794] amdgpu 0000:65:00.0: amdgpu: SMU is resumed successfully!
[  248.541832] amdgpu 0000:65:00.0: [drm] *ERROR* Error queueing DMUB
command: status=4
[  248.548469] nvme nvme0: Shutdown timeout set to 8 seconds
[  248.573859] nvme nvme1: 15/0/0 default/read/poll queues
[  248.592079] ------------[ cut here ]------------
[  248.592081] WARNING: CPU: 3 PID: 2146 at
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8059
amdgpu_dm_atomic_commit_tail+0x35b9/0x3fe0 [amdgpu]
[  248.592528] Modules linked in: ccm hid_logitech_hidpp uhid
xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4
xt_tcpudp nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 nf_tables libcrc32c nfnetlink bridge stp llc cachefiles
fscache netfs nvme_fabrics cmac algif_hash algif_skcipher af_alg bnep
cdc_ncm cdc_ether usbnet snd_ctl_led snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_soc_dmic
snd_soc_ps_mach snd_ps_pdm_dma snd_hda_intel snd_sof_amd_acp63
edac_mce_amd snd_sof_amd_acp snd_intel_dspcfg snd_sof_xtensa_dsp
snd_hda_codec snd_sof_pci snd_sof snd_hwdep snd_sof_utils mt7921e
snd_hda_core kvm_amd mt7921_common snd_soc_core mt792x_lib
mt76_connac_lib snd_compress snd_seq_midi kvm snd_seq_midi_event
ac97_bus mt76 sunrpc crct10dif_pclmul binfmt_misc irqbypass
snd_rawmidi snd_pci_ps uvcvideo crc32_pclmul videobuf2_vmalloc
mac80211 polyval_clmulni snd_pcm uvc snd_seq btusb polyval_generic
videobuf2_memops ghash_clmulni_intel videobuf2_v4l2 btrtl
[  248.592575]  sha256_ssse3 btintel sha1_ssse3 btbcm snd_seq_device
aesni_intel btmtk snd_acp_pci snd_timer videodev snd_acp_config
crypto_simd cfg80211 snd bluetooth r8152 rtsx_pci_sdmmc
videobuf2_common snd_soc_acpi hid_multitouch cryptd ucsi_acpi
think_lmi nls_iso8859_1 rapl ecdh_generic ecc
firmware_attributes_class ideapad_laptop mc typec_ucsi wmi_bmof mii
thunderbolt sparse_keymap i2c_piix4 snd_acp_legacy_common soundcore
ccp libarc4 rtsx_pci typec platform_profile i2c_hid_acpi i2c_hid
sch_fq_codel msr efi_pstore ip_tables x_tables autofs4 joydev amdgpu
i2c_algo_bit drm_ttm_helper ttm drm_exec drm_suballoc_helper
input_leds amdxcp mfd_core drm_buddy serio_raw gpu_sched nvme
drm_display_helper cec nvme_core t10_pi video wmi
[  248.592615] CPU: 3 PID: 2146 Comm: kworker/u32:18 Tainted: G
W          6.7.6 #1
[  248.592618] Hardware name: LENOVO 83AR/LNVNB161216, BIOS MDCN30WW 09/17/2023
[  248.592620] Workqueue: events_unbound async_run_entry_fn
[  248.592628] RIP: 0010:amdgpu_dm_atomic_commit_tail+0x35b9/0x3fe0 [amdgpu]
[  248.592804] Code: 4c 89 e9 48 c7 c6 c0 26 3c c1 e8 d2 aa 9d de 49
8b 56 08 e9 2c d1 ff ff 0f 0b 49 8b 3f e8 7f bf 9b de 85 c0 0f 84 ad
d5 ff ff <0f> 0b e9 a6 d5 ff ff 0f 0b e9 90 d4 ff ff 48 8b 85 90 fe ff
ff 31
[  248.592806] RSP: 0018:ffffa85c8aaff880 EFLAGS: 00010282
[  248.592808] RAX: 00000000ffffffea RBX: 0000000000000000 RCX: 0000000000000000
[  248.592809] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  248.592810] RBP: ffffa85c8aaffac0 R08: 0000000000000000 R09: 0000000000000000
[  248.592811] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8b0c0e8b9000
[  248.592811] R13: ffff8b0c0d7f6000 R14: ffff8b0c2176a080 R15: ffff8b0e2526dc00
[  248.592812] FS:  0000000000000000(0000) GS:ffff8b133ecc0000(0000)
knlGS:0000000000000000
[  248.592813] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  248.592814] CR2: 00007f104b3985a0 CR3: 00000005f3a1d000 CR4: 0000000000750ef0
[  248.592816] PKRU: 55555554
[  248.592816] Call Trace:
[  248.592818]  <TASK>
[  248.592822]  ? show_regs+0x6e/0x80
[  248.592828]  ? amdgpu_dm_atomic_commit_tail+0x35b9/0x3fe0 [amdgpu]
[  248.592971]  ? __warn+0x8d/0x160
[  248.592975]  ? amdgpu_dm_atomic_commit_tail+0x35b9/0x3fe0 [amdgpu]
[  248.593109]  ? report_bug+0x1b3/0x1c0
[  248.593116]  ? handle_bug+0x46/0x80
[  248.593121]  ? exc_invalid_op+0x19/0x80
[  248.593122]  ? asm_exc_invalid_op+0x1b/0x20
[  248.593128]  ? amdgpu_dm_atomic_commit_tail+0x35b9/0x3fe0 [amdgpu]
[  248.593266]  ? kfree+0x79/0x120
[  248.593271]  ? dcn314_validate_bandwidth+0x2be/0x4a0 [amdgpu]
[  248.593454]  ? amdgpu_bo_gpu_offset_no_check+0x3b/0x90 [amdgpu]
[  248.593564]  commit_tail+0xc2/0x190
[  248.593570]  ? drm_atomic_helper_swap_state+0x246/0x380
[  248.593571]  drm_atomic_helper_commit+0x12f/0x160
[  248.593573]  drm_atomic_commit+0x93/0xd0
[  248.593578]  ? __drm_printfn_seq_file+0x30/0x30
[  248.593581]  drm_atomic_helper_commit_duplicated_state+0xcd/0xf0
[  248.593583]  drm_atomic_helper_resume+0x94/0x150
[  248.593585]  dm_resume+0x39c/0xb20 [amdgpu]
[  248.593741]  ? __dev_printk+0x39/0xa0
[  248.593743]  ? _dev_info+0x6c/0xa0
[  248.593746]  amdgpu_device_ip_resume_phase2+0xc8/0x200 [amdgpu]
[  248.593849]  amdgpu_device_resume+0xc3/0x360 [amdgpu]
[  248.593953]  amdgpu_pmops_resume+0x67/0xc0 [amdgpu]
[  248.594055]  pci_pm_resume+0x74/0x110
[  248.594060]  ? pci_legacy_resume+0x80/0x80
[  248.594062]  dpm_run_callback+0x51/0x190
[  248.594067]  __device_resume+0xce/0x310
[  248.594069]  async_resume+0x1e/0x40
[  248.594071]  async_run_entry_fn+0x2d/0x120
[  248.594073]  process_one_work+0x175/0x350
[  248.594077]  worker_thread+0x303/0x430
[  248.594078]  ? rescuer_thread+0x430/0x430
[  248.594079]  kthread+0xf4/0x130
[  248.594082]  ? kthread_complete_and_exit+0x20/0x20
[  248.594085]  ret_from_fork+0x3f/0x70
[  248.594088]  ? kthread_complete_and_exit+0x20/0x20
[  248.594091]  ret_from_fork_asm+0x11/0x20
[  248.594098]  </TASK>
[  248.594099] ---[ end trace 0000000000000000 ]---

Laptop screen and external monitor via USB-C are connected.
Mostly I have to switch the external monitor on and off and on to make
it reconnect after waking up from suspend.

Thanks,
Karsten
