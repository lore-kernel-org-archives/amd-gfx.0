Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9621BC4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 13:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A526112A6E;
	Fri,  3 May 2024 13:10:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="VhjJtDYN";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81BDD10E827
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 08:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
 MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mUdkx62z/hqUyluOBOD4FYu4hcLinPR98gyQEFw9Si8=; b=VhjJtDYNwtrYfgYuUbGElmgZfk
 NcIyqqDJtVNeBxIBA1JtAAmnKz6wK4LLqqlft43ofHt4KP3bcVRkxi5irVMZtCgPk7LSzUzs0sTLU
 OcFCWPtFGMf6aTYFMJc/HmyFK1Ctypans2dHmwBeM5TYfPs8fW6xoAtLxcZnl3YsWo+B7kIIMyNuV
 N10F+cj5SDhqbht1FGewfJja2kSN9450N2Ognb+XLFdW3eEyJHQ4558vxI5QTSvp5ftymx2vj/vwF
 5UmWtO6AfeIOt/KXYAU/QcWyx0q4UrNuNYYgqGzKd8nEgPIuX1v/zDkemS8vlQO3uei/QK2QvwD8Z
 cCdkOPHQ==;
Received: from [84.65.0.132] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1s2oas-00037A-AX
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 May 2024 10:48:38 +0200
Message-ID: <168605a4-fcb9-4bc5-9404-c285964fc6ac@igalia.com>
Date: Fri, 3 May 2024 09:48:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: Splat during driver probe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 03 May 2024 13:10:22 +0000
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


Hi,

I tried asking on #radeon yesterday but no takers. I was wondering if 
the below splat is already known or not.

Appears to happen due amdgpu_bo_release_notify genuniely running before 
amdgpu_ttm_set_buffer_funcs_status set the buffer funcs to enabled 
during device probe.

I couldn't easily figure out what changed.

Regards,

Tvrtko

[   11.802030] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear 
memory with ring turned off.
[   11.802519] ------------[ cut here ]------------
[   11.802530] WARNING: CPU: 5 PID: 435 at 
drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1378 
amdgpu_bo_release_notify+0x20c/0x230 [amdgpu]
[   11.802916] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
amdgpu(E+) nft_chain_nat nf_tables ip6table_nat ip6table_mangle 
ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw 
iptable_security nfnetlink ip6table_filter ip6_tables iptable_filter 
cmac algif_hash ramoops algif_skcipher reed_solomon af_alg bnep qrtr 
mousedev intel_rapl_msr ath11k_pci(+) intel_rapl_common mhi 
snd_acp_sof_mach snd_acp_mach snd_sof_probes ath11k snd_soc_dmic kvm_amd 
cdc_mbim qmi_helpers joydev hid_multitouch cdc_wdm snd_sof_amd_vangogh 
snd_sof_pci kvm mac80211 snd_hda_codec_hdmi hci_uart crct10dif_pclmul 
amdxcp i2c_algo_bit snd_sof_amd_acp btqca drm_ttm_helper libarc4 
crc32_pclmul btrtl snd_hda_intel snd_sof_xtensa_dsp btbcm ttm 
snd_intel_dspcfg btintel polyval_clmulni snd_sof drm_exec 
polyval_generic snd_hda_codec snd_sof_utils gpu_sched cfg80211 bluetooth 
snd_pci_acp5x gf128mul cdc_ncm
[   11.803070]  sp5100_tco snd_hwdep ghash_clmulni_intel snd_soc_nau8821 
snd_soc_max98388 drm_suballoc_helper sha512_ssse3 cdc_ether 
snd_acp_config drm_buddy atkbd snd_soc_core aesni_intel snd_hda_core 
video ecdh_generic crypto_simd libps2 usbnet cryptd rapl mii wdat_wdt 
vivaldi_fmap pcspkr snd_compress i2c_piix4 snd_pcm drm_display_helper 
ccp snd_soc_acpi cdc_acm rfkill wmi ltrf216a 8250_dw i2c_hid_acpi 
snd_timer snd i2c_hid industrialio soundcore hid_steam pkcs8_key_parser 
crypto_user loop fuse dm_mod ip_tables x_tables overlay ext4 crc16 
mbcache jbd2 usbhid vfat fat btrfs blake2b_generic libcrc32c 
crc32c_generic xor raid6_pq sdhci_pci cqhci nvme serio_raw sdhci 
xhci_pci xhci_pci_renesas crc32c_intel mmc_core nvme_core i8042 serio 
spi_amd
[   11.803448] CPU: 5 PID: 435 Comm: (udev-worker) Tainted: G        W 
E      6.9.0-rc6 #3 dd3fb65c639fd86ff89731c604b1e804996e8989
[   11.803471] Hardware name: Valve Galileo/Galileo, BIOS F7G0107 12/01/2023
[   11.803486] RIP: 0010:amdgpu_bo_release_notify+0x20c/0x230 [amdgpu]
[   11.803857] Code: 0b e9 a4 fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31 
f6 4c 89 e7 e8 44 e5 33 e6 eb 8d e8 dd dd 33 e6 eb a7 0f 0b e9 4d fe ff 
ff <0f> 0b eb 9c be 03 00 00 00 e8 f6 04 00 e6 eb 90 e8 8f 64 79 e6 66
[   11.803890] RSP: 0018:ffffa77bc1537568 EFLAGS: 00010282
[   11.803904] RAX: 00000000ffffffea RBX: ffff8e1f0da89048 RCX: 
0000000000000000
[   11.803919] RDX: 0000000000000000 RSI: 0000000000000027 RDI: 
00000000ffffffff
[   11.803934] RBP: ffff8e1f6ec0ffb0 R08: 0000000000000000 R09: 
0000000000000003
[   11.803948] R10: ffffa77bc15372f0 R11: ffff8e223ef7ffe8 R12: 
ffff8e1f0da89000
[   11.803963] R13: ffff8e1f0da89180 R14: ffff8e1f6ec0ffb0 R15: 
ffff8e1f6ec00000
[   11.803977] FS:  00007fa2b600b200(0000) GS:ffff8e222ee80000(0000) 
knlGS:0000000000000000
[   11.803994] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.804007] CR2: 000055cac2aa7080 CR3: 000000010f818000 CR4: 
0000000000350ef0
[   11.804021] Call Trace:
[   11.804031]  <TASK>
[   11.804042]  ? __warn+0x8c/0x180
[   11.804057]  ? amdgpu_bo_release_notify+0x20c/0x230 [amdgpu 
03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
[   11.804456]  ? report_bug+0x191/0x1c0
[   11.804473]  ? handle_bug+0x3a/0x70
[   11.804485]  ? exc_invalid_op+0x17/0x70
[   11.804497]  ? asm_exc_invalid_op+0x1a/0x20
[   11.804517]  ? amdgpu_bo_release_notify+0x20c/0x230 [amdgpu 
03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
[   11.804894]  ? amdgpu_bo_release_notify+0x14a/0x230 [amdgpu 
03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
[   11.805277]  ttm_bo_release+0x115/0x330 [ttm 
39c917822ce73b2a754d4183af7a0990991c66be]
[   11.805303]  ? srso_return_thunk+0x5/0x5f
[   11.805315]  ? __mutex_unlock_slowpath+0x3a/0x290
[   11.805332]  amdgpu_bo_free_kernel+0xd6/0x130 [amdgpu 
03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
[   11.805709]  dm_helpers_free_gpu_mem+0x41/0x80 [amdgpu 
03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
[   11.806172]  vg_clk_mgr_construct+0x2c4/0x490 [amdgpu 
03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
[   11.806645]  dc_clk_mgr_create+0x390/0x580 [amdgpu 
03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
[   11.807112]  dc_create+0x28a/0x640 [amdgpu 
03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
[   11.807567]  amdgpu_dm_init.isra.0+0x2e1/0x1fe0 [amdgpu 
03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
[   11.808025]  ? srso_return_thunk+0x5/0x5f
[   11.808037]  ? __irq_work_queue_local+0x44/0x130
[   11.808051]  ? srso_return_thunk+0x5/0x5f
[   11.808064]  ? __wake_up_klogd.part.0+0x56/0x80
[   11.808077]  ? srso_return_thunk+0x5/0x5f
[   11.808088]  ? vprintk_emit+0x18c/0x380
[   11.808100]  ? srso_return_thunk+0x5/0x5f
[   11.808114]  ? srso_return_thunk+0x5/0x5f
[   11.808125]  ? dev_printk_emit+0xa5/0xd0
[   11.808138]  ? rcu_is_watching+0x11/0x50
[   11.808172]  dm_hw_init+0x12/0x30 [amdgpu 
03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
[   11.808623]  amdgpu_device_init+0x20b3/0x2870 [amdgpu 
03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
[   11.808998]  ? srso_return_thunk+0x5/0x5f
[   11.809016]  amdgpu_driver_load_kms+0x19/0xb0 [amdgpu 
03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
[   11.809390]  amdgpu_pci_probe+0x15d/0x490 [amdgpu 
03b1dca7e09918e3f45efb1acdfc90682f73e4c1]
