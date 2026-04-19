Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A858F588C3
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 13:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D2EB10E5B7;
	Mon, 20 Apr 2026 13:02:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=cachyos.org header.i=@cachyos.org header.b="b0+5SpLV";
	dkim-atps=neutral
X-Greylist: delayed 534 seconds by postgrey-1.36 at gabe;
 Sun, 19 Apr 2026 11:33:22 UTC
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7594310E06D
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Apr 2026 11:33:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ED6CD285DB7; Sun, 19 Apr 2026 13:24:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
 t=1776597865; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=GENHOMCXf0w5u/POMUUD3Yx7lYEQlqPPi9Wo8eZS1VA=;
 b=b0+5SpLV2aHHHSq4XJefCJfoTfv090pQLEf9AW3dqipqaDcAXT+FFvWrvJiNz0TXQ44GFg
 lcFU+17imvHrM88iWQLse07/VhakPIL8bzRjzBjbqCY10rymiOE3ZwBC/v1TVj5H4MSrAV
 ZQk+Famr/T1jonJiOmmi8N/6hWXLA2pYlPFj4dBgPM8FCX5zfmYukHIsoUjKYwYETFsJUC
 PHjmCVXG7R7Wjv8PNYB+eMKxU+saXSnTsFwk3PZaAHC4PPlZP9UfuQS90sOge4fMGUAt6C
 EHuS+OKOHns1Hrcj6XAxl7Hxr3xa0A33eGJc6UuUrmpVIFokOSYluZ17E3uLtQ==
Message-ID: <dea28da4-b49c-400a-9f1f-4a7e806d8b0d@cachyos.org>
Date: Sun, 19 Apr 2026 11:24:00 +0000
MIME-Version: 1.0
From: Eric Naim <dnaim@cachyos.org>
Subject: Re: 7.0-rc4 dcn31_program_compbuf_size trace
To: Julian Wollrath <jwollrath@web.de>, amd-gfx@lists.freedesktop.org
Cc: Martin Leung <martin.leung@amd.com>,
 Bhuvanachandra Pinninti <bpinnint@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20260316094232.6bb6f0bf@schienar>
In-Reply-To: <20260316094232.6bb6f0bf@schienar>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Mon, 20 Apr 2026 13:02:49 +0000
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

On 3/16/26 4:42 PM, Julian Wollrath wrote:
> Dear maintainers,
>=20
> when turning the display of via 'xset dpms force off' I observe the
> following warning and trace under 7.0-rc4 with a AMD Ryzen 7 PRO 8840U
> w/ Radeon 780M Graphics card. This I did not observe under 6.19.7.
>=20
> kernel: amdgpu 0000:c4:00.0: [drm] REG_WAIT timeout 1us * 100 tries - d=
cn31_program_compbuf_size line:142
> kernel: ------------[ cut here ]------------
> kernel: WARNING: drivers/gpu/drm/amd/amdgpu/../display/dc/hubbub/dcn31/=
dcn31_hubbub.c:151 at dcn31_program_compbuf_size+0xd2/0x230 [amdgpu], CPU=
#2: Xorg/1207
> kernel: Modules linked in: r8153_ecm hid_apple apple_mfi_fastcharge usb=
hid r8152 rfcomm snd_seq_dummy snd_hrtimer snd_seq snd_seq_device michael=
_mic 8021q garp stp mrp llc uhid algif_hash algif_skcipher af_alg qrtr_mh=
i bnep binfmt_misc nls_iso8859_1 nls_cp437 vfat fat edac_mce_amd edac_cor=
e ext4 mbcache jbd2 ucsi_acpi typec_ucsi roles amd_atl typec spd5118 kvm_=
amd snd_soc_ps_mach snd_soc_dmic snd_ps_pdm_dma regmap_i2c qrtr uvcvideo =
videobuf2_vmalloc kvm videobuf2_memops ath11k_pci uvc mhi irqbypass video=
buf2_v4l2 ghash_clmulni_intel think_lmi snd_ctl_led snd_sof_amd_acp63 ath=
11k rapl cdc_mbim btusb snd_hda_codec_alc269 snd_sof_amd_acp qmi_helpers =
videodev cdc_wdm btintel snd_sof_xtensa_dsp snd_hda_scodec_component amdg=
pu snd_sof_pci firmware_attributes_class wmi_bmof cdc_ncm videobuf2_commo=
n snd_hda_codec_realtek_lib bluetooth mc cdc_ether mac80211 snd_hda_codec=
_generic snd_sof usbnet mii snd_sof_utils i2c_algo_bit libarc4 drm_ttm_he=
lper snd_pci_ps snd_hda_codec_atihdmi k10temp ttm snd_soc_acpi_amd_match
> kernel:  snd_hda_codec_hdmi agpgart snd_acp_config cfg80211 drm_exec sn=
d_amd_sdw_acpi thunderbolt r8169 drm_suballoc_helper soundwire_amd mfd_co=
re ac soundwire_generic_allocation drm_buddy snd_soc_acpi snd_hda_intel d=
rm_panel_backlight_quirks snd_intel_dspcfg soundwire_bus amd_pmf gpu_sche=
d snd_hda_codec amdtee amdxcp sp5100_tco snd_soc_core snd_hda_core amd_sf=
h watchdog drm_display_helper snd_compress snd_hwdep tpm_crb tee button c=
ec snd_pcm crc16 i2c_piix4 mousedev snd_timer amd_pmc i2c_smbus nft_ct nf=
_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_limit sch_fq_codel parport_p=
c msr parport nf_tables fuse efi_pstore configfs nfnetlink efivarfs tpm l=
ibaescfb ecdh_generic autofs4 xfs dm_crypt dm_mod hid_multitouch hid_gene=
ric i2c_hid_acpi i2c_hid thinkpad_acpi input_leds nvme psmouse xhci_pci n=
vram sparse_keymap atkbd nvme_core xhci_hcd i2c_designware_platform platf=
orm_profile vivaldi_fmap evdev aesni_intel serio_raw snd nvme_keyring usb=
core soundcore battery usb_common rfkill nvme_auth ccp hkdf rng_core fan =
thermal
> kernel:  i2c_designware_core simpledrm drm_client_lib drm_shmem_helper =
drm_sysfb_helper drm_kms_helper drm
> kernel: CPU: 2 UID: 0 PID: 1207 Comm: Xorg Not tainted 7.0.0-rc4 #1 PRE=
EMPT
> kernel: Hardware name: LENOVO 21MCS03F00/21MCS03F00, BIOS R2LET37W (1.1=
8 ) 11/25/2025
> kernel: RIP: 0010:dcn31_program_compbuf_size+0xd2/0x230 [amdgpu]
> kernel: Code: 00 48 8b 43 28 8b 88 d8 01 00 00 48 8b 43 20 0f b6 50 76 =
48 8b 43 18 8b b0 14 01 00 00 e8 b6 d3 0b 00 85 c0 0f 85 32 01 00 00 <0f>=
 0b 48 8b 44 24 08 65 48 2b 05 6f 34 9f ce 0f 85 35 01 00 00 48
> kernel: RSP: 0018:ffffd27ac33376e8 EFLAGS: 00010202
> kernel: RAX: 0000000000000001 RBX: ffff8f3fa057c800 RCX: 00000000800416=
19
> kernel: RDX: ffffd27ac510e5e8 RSI: 000000000000397a RDI: ffff8f3eda1800=
00
> kernel: RBP: 0000000000000004 R08: 0000000080041619 R09: 00000000000039=
7a
> kernel: R10: 0000000000000064 R11: ffffd27ac33373f8 R12: ffff8f3ec5c000=
00
> kernel: R13: ffff8f3f61800000 R14: ffff8f3fa057c800 R15: 00000000000000=
04
> kernel: FS:  00007f505be98b80(0000) GS:ffff8f466e70c000(0000) knlGS:000=
0000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 00007faaf46f5f40 CR3: 0000000106478000 CR4: 0000000000750e=
f0
> kernel: PKRU: 55555554
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  dcn20_optimize_bandwidth+0xe6/0x220 [amdgpu]
> kernel:  dc_commit_state_no_check+0xc1e/0xe90 [amdgpu]
> kernel:  dc_commit_streams+0x2f9/0x4f0 [amdgpu]
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? dm_read_reg_func+0x5c/0x100 [amdgpu]
> kernel:  amdgpu_dm_atomic_commit_tail+0x51f/0x34c0 [amdgpu]
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? dcn30_internal_validate_bw+0x890/0x960 [amdgpu]
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? dcn314_validate_bandwidth+0xf7/0x2e0 [amdgpu]
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? dma_resv_get_fences+0xb2/0x290
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? dma_resv_get_singleton+0x43/0x130
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? wait_for_completion_timeout+0xf7/0x130
> kernel:  commit_tail+0x9d/0x130 [drm_kms_helper]
> kernel:  drm_atomic_helper_commit+0x13c/0x180 [drm_kms_helper]
> kernel:  drm_atomic_commit+0xb1/0xe0 [drm]
> kernel:  ? drm_plane_create_color_pipeline_property.cold+0x29/0x29 [drm=
]
> kernel:  drm_atomic_connector_commit_dpms+0xfa/0x110 [drm]
> kernel:  drm_mode_obj_set_property_ioctl+0x1b4/0x3b0 [drm]
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? drm_connector_set_obj_prop+0xa0/0xa0 [drm]
> kernel:  drm_connector_property_set_ioctl+0x3c/0x60 [drm]
> kernel:  drm_ioctl_kernel+0xae/0x100 [drm]
> kernel:  drm_ioctl+0x29b/0x540 [drm]
> kernel:  ? drm_connector_set_obj_prop+0xa0/0xa0 [drm]
> kernel:  amdgpu_drm_ioctl+0x4a/0x80 [amdgpu]
> kernel:  __x64_sys_ioctl+0x86/0xd0
> kernel:  do_syscall_64+0xec/0x940
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? common_interrupt+0x3f/0xa0
> kernel:  entry_SYSCALL_64_after_hwframe+0x55/0x5d
> kernel: RIP: 0033:0x7f505c21dd3b
> kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 =
00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89>=
 c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> kernel: RSP: 002b:00007ffda60126e0 EFLAGS: 00000246 ORIG_RAX: 000000000=
0000010
> kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f505c21dd=
3b
> kernel: RDX: 00007ffda6012770 RSI: 00000000c01064ab RDI: 00000000000000=
0f
> kernel: RBP: 00007ffda6012770 R08: 0000000000154eb5 R09: 7fffffffffffff=
ff
> kernel: R10: 00007f505bab9cb0 R11: 0000000000000246 R12: 00000000c01064=
ab
> kernel: R13: 000000000000000f R14: 000055ba642c5c60 R15: 00000000000000=
00
> kernel:  </TASK>
> kernel: ---[ end trace 0000000000000000 ]---
>=20
>=20
>=20
> Best regards,
> Julian
>=20

Hi maintainers,

Per [1], this seems to be caused by 592c5b80110d5e9e50873b5364818cb6f401e=
26d.

[1] https://github.com/CachyOS/linux-cachyos/issues/810#issuecomment-4275=
280460


--=20
Regards,
  Eric
