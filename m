Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0877F506D6
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 13:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E1810E538;
	Mon, 16 Mar 2026 13:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=jwollrath@web.de header.b="sfwjkarw";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Mon, 16 Mar 2026 08:47:38 UTC
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D5F410E372
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 08:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1773650856; x=1774255656; i=jwollrath@web.de;
 bh=LhqPWYagluaCWahxepeT5ot6opw2OOG/3aX9urKl008=;
 h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=sfwjkarwoRmbDAJNpC6MJ1D2QxJLEEDj3sydf0G0ABX9uGiroTguqEXPGVkt3w1p
 QBVrmOiwg+7iIZeFPXFWVNBb+z6B3tCnbVltjoonLQYteR0bocfl+yMeijUtI3h9O
 CmIQSewCZnSHLEcc/35+z6dGvmmpxrp9WJVNBXUe4fJhkbPB3K9DswpRi+IktCO/v
 9cWyXOjmob3QvlxftqhlmIy05FcAcKZibAmWAwCGaRdbkJyGd6hdNdqfZwYrqK1O7
 U6mDtZ3vYpVHIb3+LTpQ4DoCjHiIyeTmFivjshmLNis/2S+/mCQhmd3Rxsy4bs6Ej
 4NTAfFa10HhUUGX59g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECGX-1vrvB61A4D-0064IV for
 <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 09:42:33 +0100
Date: Mon, 16 Mar 2026 09:42:32 +0100
From: Julian Wollrath <jwollrath@web.de>
To: amd-gfx@lists.freedesktop.org
Subject: 7.0-rc4 dcn31_program_compbuf_size trace
Message-ID: <20260316094232.6bb6f0bf@schienar>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yjdgw0bTccXuSITL5NgHugA9ZakCBKaP31S0o1v8xZnnVrSa+Jf
 qUDVRVE2Yof80nr7J3QR3FQoMQCUTmokQ6hqeuV8FCdsdDzxtFADWSSrxhOj9DGUlEBZ7jd
 eStqi/ADq1dWw4sWwGpAKr6Phq4i54B/JA/J4a8NGpvmxLuLuc5pK1s6r4evWvkPsE03BmM
 1HfY3MQMclF+HCt6S89vQ==
UI-OutboundReport: notjunk:1;M01:P0:vBUcM08RNBs=;htEo2NgmoRxoeS0HQ53tMGqkhjO
 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
 /0EIckow=
X-Mailman-Approved-At: Mon, 16 Mar 2026 13:28:00 +0000
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

Dear maintainers,

when turning the display of via 'xset dpms force off' I observe the
following warning and trace under 7.0-rc4 with a AMD Ryzen 7 PRO 8840U
w/ Radeon 780M Graphics card. This I did not observe under 6.19.7.

kernel: amdgpu 0000:c4:00.0: [drm] REG_WAIT timeout 1us * 100 tries - dcn31=
_program_compbuf_size line:142
kernel: ------------[ cut here ]------------
kernel: WARNING: drivers/gpu/drm/amd/amdgpu/../display/dc/hubbub/dcn31/dcn3=
1_hubbub.c:151 at dcn31_program_compbuf_size+0xd2/0x230 [amdgpu], CPU#2: Xo=
rg/1207
kernel: Modules linked in: r8153_ecm hid_apple apple_mfi_fastcharge usbhid =
r8152 rfcomm snd_seq_dummy snd_hrtimer snd_seq snd_seq_device michael_mic 8=
021q garp stp mrp llc uhid algif_hash algif_skcipher af_alg qrtr_mhi bnep b=
infmt_misc nls_iso8859_1 nls_cp437 vfat fat edac_mce_amd edac_core ext4 mbc=
ache jbd2 ucsi_acpi typec_ucsi roles amd_atl typec spd5118 kvm_amd snd_soc_=
ps_mach snd_soc_dmic snd_ps_pdm_dma regmap_i2c qrtr uvcvideo videobuf2_vmal=
loc kvm videobuf2_memops ath11k_pci uvc mhi irqbypass videobuf2_v4l2 ghash_=
clmulni_intel think_lmi snd_ctl_led snd_sof_amd_acp63 ath11k rapl cdc_mbim =
btusb snd_hda_codec_alc269 snd_sof_amd_acp qmi_helpers videodev cdc_wdm bti=
ntel snd_sof_xtensa_dsp snd_hda_scodec_component amdgpu snd_sof_pci firmwar=
e_attributes_class wmi_bmof cdc_ncm videobuf2_common snd_hda_codec_realtek_=
lib bluetooth mc cdc_ether mac80211 snd_hda_codec_generic snd_sof usbnet mi=
i snd_sof_utils i2c_algo_bit libarc4 drm_ttm_helper snd_pci_ps snd_hda_code=
c_atihdmi k10temp ttm snd_soc_acpi_amd_match
kernel:  snd_hda_codec_hdmi agpgart snd_acp_config cfg80211 drm_exec snd_am=
d_sdw_acpi thunderbolt r8169 drm_suballoc_helper soundwire_amd mfd_core ac =
soundwire_generic_allocation drm_buddy snd_soc_acpi snd_hda_intel drm_panel=
_backlight_quirks snd_intel_dspcfg soundwire_bus amd_pmf gpu_sched snd_hda_=
codec amdtee amdxcp sp5100_tco snd_soc_core snd_hda_core amd_sfh watchdog d=
rm_display_helper snd_compress snd_hwdep tpm_crb tee button cec snd_pcm crc=
16 i2c_piix4 mousedev snd_timer amd_pmc i2c_smbus nft_ct nf_conntrack nf_de=
frag_ipv6 nf_defrag_ipv4 nft_limit sch_fq_codel parport_pc msr parport nf_t=
ables fuse efi_pstore configfs nfnetlink efivarfs tpm libaescfb ecdh_generi=
c autofs4 xfs dm_crypt dm_mod hid_multitouch hid_generic i2c_hid_acpi i2c_h=
id thinkpad_acpi input_leds nvme psmouse xhci_pci nvram sparse_keymap atkbd=
 nvme_core xhci_hcd i2c_designware_platform platform_profile vivaldi_fmap e=
vdev aesni_intel serio_raw snd nvme_keyring usbcore soundcore battery usb_c=
ommon rfkill nvme_auth ccp hkdf rng_core fan thermal
kernel:  i2c_designware_core simpledrm drm_client_lib drm_shmem_helper drm_=
sysfb_helper drm_kms_helper drm
kernel: CPU: 2 UID: 0 PID: 1207 Comm: Xorg Not tainted 7.0.0-rc4 #1 PREEMPT
kernel: Hardware name: LENOVO 21MCS03F00/21MCS03F00, BIOS R2LET37W (1.18 ) =
11/25/2025
kernel: RIP: 0010:dcn31_program_compbuf_size+0xd2/0x230 [amdgpu]
kernel: Code: 00 48 8b 43 28 8b 88 d8 01 00 00 48 8b 43 20 0f b6 50 76 48 8=
b 43 18 8b b0 14 01 00 00 e8 b6 d3 0b 00 85 c0 0f 85 32 01 00 00 <0f> 0b 48=
 8b 44 24 08 65 48 2b 05 6f 34 9f ce 0f 85 35 01 00 00 48
kernel: RSP: 0018:ffffd27ac33376e8 EFLAGS: 00010202
kernel: RAX: 0000000000000001 RBX: ffff8f3fa057c800 RCX: 0000000080041619
kernel: RDX: ffffd27ac510e5e8 RSI: 000000000000397a RDI: ffff8f3eda180000
kernel: RBP: 0000000000000004 R08: 0000000080041619 R09: 000000000000397a
kernel: R10: 0000000000000064 R11: ffffd27ac33373f8 R12: ffff8f3ec5c00000
kernel: R13: ffff8f3f61800000 R14: ffff8f3fa057c800 R15: 0000000000000004
kernel: FS:  00007f505be98b80(0000) GS:ffff8f466e70c000(0000) knlGS:0000000=
000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 00007faaf46f5f40 CR3: 0000000106478000 CR4: 0000000000750ef0
kernel: PKRU: 55555554
kernel: Call Trace:
kernel:  <TASK>
kernel:  dcn20_optimize_bandwidth+0xe6/0x220 [amdgpu]
kernel:  dc_commit_state_no_check+0xc1e/0xe90 [amdgpu]
kernel:  dc_commit_streams+0x2f9/0x4f0 [amdgpu]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? dm_read_reg_func+0x5c/0x100 [amdgpu]
kernel:  amdgpu_dm_atomic_commit_tail+0x51f/0x34c0 [amdgpu]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? dcn30_internal_validate_bw+0x890/0x960 [amdgpu]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? dcn314_validate_bandwidth+0xf7/0x2e0 [amdgpu]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? dma_resv_get_fences+0xb2/0x290
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? dma_resv_get_singleton+0x43/0x130
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? wait_for_completion_timeout+0xf7/0x130
kernel:  commit_tail+0x9d/0x130 [drm_kms_helper]
kernel:  drm_atomic_helper_commit+0x13c/0x180 [drm_kms_helper]
kernel:  drm_atomic_commit+0xb1/0xe0 [drm]
kernel:  ? drm_plane_create_color_pipeline_property.cold+0x29/0x29 [drm]
kernel:  drm_atomic_connector_commit_dpms+0xfa/0x110 [drm]
kernel:  drm_mode_obj_set_property_ioctl+0x1b4/0x3b0 [drm]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? drm_connector_set_obj_prop+0xa0/0xa0 [drm]
kernel:  drm_connector_property_set_ioctl+0x3c/0x60 [drm]
kernel:  drm_ioctl_kernel+0xae/0x100 [drm]
kernel:  drm_ioctl+0x29b/0x540 [drm]
kernel:  ? drm_connector_set_obj_prop+0xa0/0xa0 [drm]
kernel:  amdgpu_drm_ioctl+0x4a/0x80 [amdgpu]
kernel:  __x64_sys_ioctl+0x86/0xd0
kernel:  do_syscall_64+0xec/0x940
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? common_interrupt+0x3f/0xa0
kernel:  entry_SYSCALL_64_after_hwframe+0x55/0x5d
kernel: RIP: 0033:0x7f505c21dd3b
kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 4=
8 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d=
 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
kernel: RSP: 002b:00007ffda60126e0 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
010
kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f505c21dd3b
kernel: RDX: 00007ffda6012770 RSI: 00000000c01064ab RDI: 000000000000000f
kernel: RBP: 00007ffda6012770 R08: 0000000000154eb5 R09: 7fffffffffffffff
kernel: R10: 00007f505bab9cb0 R11: 0000000000000246 R12: 00000000c01064ab
kernel: R13: 000000000000000f R14: 000055ba642c5c60 R15: 0000000000000000
kernel:  </TASK>
kernel: ---[ end trace 0000000000000000 ]---



Best regards,
Julian

--=20
 ()  ascii ribbon campaign - against html e-mail=20
 /\                        - against proprietary attachments
