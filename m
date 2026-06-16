Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6C3CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 12:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C62210EB76;
	Tue, 16 Jun 2026 12:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="ZmAEK2vP";
	dkim-atps=neutral
Received: from master.debian.org (master.debian.org [82.195.75.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB00C10E95C
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.master;
 h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description;
 bh=Tl7dQs0L9BVlbzqjoQCUna35R5rrWZJuqmp2DbGhXdE=; b=ZmAEK2vP8wvwKk8YpBUtHnaJ0d
 cGwzDRA5RmT2m3Y7LXuFYyVAR+1LFSJ5VXazvF37pH9bINh+SLcq4/0SZLAflWCEFa6HZSEK1nuuR
 OKoXFjWyOdR3yJf20BZhkohQY06VXLfMfK72YBjXqEIPGcTHY4lpjac2j8QBpW6YEcjj6K2AwLCng
 PtyaiIcs0QPIGIE7hbaTJmhwBgGjgQVygrkZdgR9n5npvKKPRgp/cV2sNizUE6uAME5we8OQLVSQ1
 6X0q2s4AapbZSfw8WLfr1V4TuNtVigwe/hZij2cXIcCIrEAMi5k3pkM2fRcUtMDgU31Ia45WkWtEh
 GDduYklQ==;
Received: from ukleinek by master.debian.org with local (Exim 4.96)
 (envelope-from <ukleinek@master.debian.org>) id 1wZPqq-006mzx-2C;
 Tue, 16 Jun 2026 09:12:56 +0000
Date: Tue, 16 Jun 2026 11:12:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: Olaf Flebbe <of@oflebbe.de>, Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: 1139599@bugs.debian.org, amd-gfx@lists.freedesktop.org
Subject: list_del corruption in amdgpu (Was: Bug#1139599:
 linux-base-7.0.10+deb14-amd64: amdgpu (ttm?) two Oops, locking the computer)
Message-ID: <ajEQr3IXQ8byLFvC@monoceros>
References: <178107486943.12919.15197186152368989316.reportbug@frame>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="joo4pr4gfijdzfcq"
Content-Disposition: inline
In-Reply-To: <178107486943.12919.15197186152368989316.reportbug@frame>
X-Mailman-Approved-At: Tue, 16 Jun 2026 12:49:33 +0000
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


--joo4pr4gfijdzfcq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: list_del corruption in amdgpu (Was: Bug#1139599:
 linux-base-7.0.10+deb14-amd64: amdgpu (ttm?) two Oops, locking the computer)
MIME-Version: 1.0

Control: forwarded -1 https://lore.kernel.org/amd-gfx/ajEQr3IXQ8byLFvC@mono=
ceros

Hello,

a Debian user reported an issue while using the amdgpu user. The full
details are available at https://bugs.debian.org/1139599. The relvant (I
hope) parts are also in this mail, but you can find more logs there if
you want to take a look.

On Wed, Jun 10, 2026 at 09:01:09AM +0200, Olaf Flebbe wrote:
>    * What led up to the situation?
>            Heavy use of LM-Studio with local GPU accellerated models.
>            HW: AMD Ryzen=E2=84=A2 7 7840U w/ Radeon=E2=84=A2 780M Graphic=
s =C3=97 16 (Framework 13 Laptop)
>=20
>    * What exactly did you do (or not do) that was effective (or
>      ineffective)?
>=20
>    Normal use (use gnome-calc for instance) while LM-Studio was active.
>=20
>    * What was the outcome of this action?
>         Moved the mouse: Computer totally locked, hat to power off.
>=20
>    * What outcome did you expect instead?
>         Mouse movement :)
>=20
>    Happend two times with Kernel reports both mentioning "ttm something" =
and "amdgpu_bo_move"

@Olaf: If you still have both issues in your logs, providing both might
help to identify the issue. Also it would be great to know, how reliably
you can reproduce the issue, in case we have to resort to bisecting or
testing a fix. Is this a regression, i.e. did the same workflow work
fine before, with an older kernel version? If so, which one?

> Jun 09 23:00:08 frame kernel:  slab kmalloc-96 start ffff8ca660fea420 poi=
nter offset 64 size 96
> Jun 09 23:00:08 frame kernel: list_del corruption. next->prev should be f=
fff8ca661e9ed60, but was ffff8ca623eb9180. (next=3Dffff8ca660fea460)
> Jun 09 23:00:08 frame kernel: ------------[ cut here ]------------
> Jun 09 23:00:08 frame kernel: kernel BUG at lib/list_debug.c:65!
> Jun 09 23:00:08 frame kernel: Oops: invalid opcode: 0000 [#1] SMP NOPTI
> Jun 09 23:00:08 frame kernel: CPU: 2 UID: 1000 PID: 34294 Comm: ptyxis No=
t tainted 7.0.10+deb14-amd64 #1 PREEMPT(lazy)  Debian 7.0.10-1=20
> Jun 09 23:00:08 frame kernel: Hardware name: Framework Laptop 13 (AMD Ryz=
en 7040Series)/FRANMDCP07, BIOS 03.19 05/21/2026
> Jun 09 23:00:08 frame kernel: RIP: 0010:__list_del_entry_valid_or_report+=
0x10a/0x120
> Jun 09 23:00:08 frame kernel: Code: 89 d7 48 89 14 24 e8 55 36 be ff 48 8=
b 14 24 48 8b 74 24 08 48 c7 c7 48 9f be 9f 48 8b 42 08 48 89 d1 48 89 c2 e=
8 f6 35 77 ff <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00=
 00 00
> Jun 09 23:00:08 frame kernel: RSP: 0018:ffffd434c67a36c0 EFLAGS: 00010246
> Jun 09 23:00:08 frame kernel: RAX: 000000000000006d RBX: ffff8ca661e9ed20=
 RCX: 0000000000000027
> Jun 09 23:00:08 frame kernel: RDX: 0000000000000000 RSI: 0000000000000001=
 RDI: ffff8cad5e69d2c0
> Jun 09 23:00:08 frame kernel: RBP: ffff8ca60ed8f688 R08: 0000000000000000=
 R09: ffffd434c67a3568
> Jun 09 23:00:08 frame kernel: R10: ffffffffa04f25b0 R11: 00000000ffffefff=
 R12: ffff8ca60ed8ee38
> Jun 09 23:00:08 frame kernel: R13: ffff8ca661e9ed60 R14: ffff8ca60ed80000=
 R15: 0000000000000001
> Jun 09 23:00:08 frame kernel: FS:  00007fc2854a4580(0000) GS:ffff8cadbd5f=
c000(0000) knlGS:0000000000000000
> Jun 09 23:00:08 frame kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
> Jun 09 23:00:08 frame kernel: CR2: 00007fe855d9fff0 CR3: 0000000194167000=
 CR4: 0000000000f50ef0
> Jun 09 23:00:08 frame kernel: PKRU: 55555554
> Jun 09 23:00:08 frame kernel: Call Trace:
> Jun 09 23:00:08 frame kernel:  <TASK>
> Jun 09 23:00:08 frame kernel:  ttm_resource_fini+0x34/0x70 [ttm]
> Jun 09 23:00:08 frame kernel:  ttm_sys_man_free+0x12/0x20 [ttm]
> Jun 09 23:00:08 frame kernel:  ttm_resource_free+0x9a/0xf0 [ttm]
> Jun 09 23:00:08 frame kernel:  amdgpu_bo_move+0xba/0x810 [amdgpu]
> Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jun 09 23:00:08 frame kernel:  ? unmap_mapping_range+0x80/0x130
> Jun 09 23:00:08 frame kernel:  ttm_bo_handle_move_mem+0xd0/0x1a0 [ttm]
> Jun 09 23:00:08 frame kernel:  ttm_bo_validate+0xd8/0x180 [ttm]
> Jun 09 23:00:08 frame kernel:  ? __pfx_amdgpu_cs_bo_validate+0x10/0x10 [a=
mdgpu]
> Jun 09 23:00:08 frame kernel:  amdgpu_cs_bo_validate+0x9a/0x1a0 [amdgpu]
> Jun 09 23:00:08 frame kernel:  ? __pfx_amdgpu_cs_bo_validate+0x10/0x10 [a=
mdgpu]
> Jun 09 23:00:08 frame kernel:  amdgpu_vm_validate+0x31b/0x4c0 [amdgpu]
> Jun 09 23:00:08 frame kernel:  ? __pfx_amdgpu_cs_bo_validate+0x10/0x10 [a=
mdgpu]
> Jun 09 23:00:08 frame kernel:  amdgpu_cs_parser_bos.isra.0+0x5f8/0x960 [a=
mdgpu]
> Jun 09 23:00:08 frame kernel:  amdgpu_cs_ioctl+0x10a0/0x2140 [amdgpu]
> Jun 09 23:00:08 frame kernel:  ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu]
> Jun 09 23:00:08 frame kernel:  drm_ioctl_kernel+0xae/0x100 [drm]
> Jun 09 23:00:08 frame kernel:  drm_ioctl+0x2a8/0x550 [drm]
> Jun 09 23:00:08 frame kernel:  ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu]
> Jun 09 23:00:08 frame kernel:  amdgpu_drm_ioctl+0x4a/0x80 [amdgpu]
> Jun 09 23:00:08 frame kernel:  __x64_sys_ioctl+0x97/0xe0
> Jun 09 23:00:08 frame kernel:  do_syscall_64+0xcd/0x15f0
> Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jun 09 23:00:08 frame kernel:  ? count_memcg_events+0xeb/0x220
> Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jun 09 23:00:08 frame kernel:  ? handle_mm_fault+0x1d6/0x2d0
> Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jun 09 23:00:08 frame kernel:  ? do_user_addr_fault+0x2b4/0x7b0
> Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jun 09 23:00:08 frame kernel:  ? irqentry_exit+0x78/0x680
> Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jun 09 23:00:08 frame kernel:  ? exc_page_fault+0x82/0x1d0
> Jun 09 23:00:08 frame kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jun 09 23:00:08 frame kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Jun 09 23:00:08 frame kernel: RIP: 0033:0x7fc28abb3d3b
> Jun 09 23:00:08 frame kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 6=
0 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 0=
0 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28=
 00 00
> Jun 09 23:00:08 frame kernel: RSP: 002b:00007ffde5ca84a0 EFLAGS: 00000246=
 ORIG_RAX: 0000000000000010
> Jun 09 23:00:08 frame kernel: RAX: ffffffffffffffda RBX: 00007ffde5ca86b8=
 RCX: 00007fc28abb3d3b
> Jun 09 23:00:08 frame kernel: RDX: 00007ffde5ca8540 RSI: 00000000c0186444=
 RDI: 0000000000000013
> Jun 09 23:00:08 frame kernel: RBP: 00007ffde5ca8580 R08: 00005638df61a860=
 R09: 00007ffde5ca8500
> Jun 09 23:00:08 frame kernel: R10: 0000000000000000 R11: 0000000000000246=
 R12: 00005638df61a800
> Jun 09 23:00:08 frame kernel: R13: 0000000000000013 R14: 0000086559c3e8fb=
 R15: 00005638df832620
> Jun 09 23:00:08 frame kernel:  </TASK>
> Jun 09 23:00:08 frame kernel: Modules linked in: overlay sd_mod scsi_mod =
scsi_common rfcomm snd_seq_dummy snd_hrtimer snd_seq xt_CHECKSUM xt_MASQUER=
ADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat x_tables nf=
t_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables bri=
dge stp llc ccm uhid cmac algif_hash algif_skcipher af_alg qrtr bnep nls_as=
cii nls_cp437 vfat fat amd_atl intel_rapl_msr intel_rapl_common edac_mce_am=
d snd_sof_amd_rembrandt kvm_amd snd_sof_amd_acp snd_sof_pci snd_sof_xtensa_=
dsp snd_sof kvm snd_sof_utils snd_pci_ps snd_soc_acpi_amd_match uvcvideo hi=
d_sensor_als snd_soc_acpi_amd_sdca_quirks hid_sensor_trigger snd_amd_sdw_ac=
pi videobuf2_vmalloc soundwire_amd irqbypass hid_sensor_iio_common iwlmvm s=
oundwire_generic_allocation uvc kfifo_buf btusb rapl soundwire_bus industri=
alio videobuf2_memops btmtk videobuf2_v4l2 leds_cros_ec snd_soc_sdca snd_hd=
a_codec_alc269 btrtl wmi_bmof cros_ec_hwmon led_class_multicolor snd_hda_co=
dec_realtek_lib videodev snd_hda_codec_atihdmi btbcm mac80211 snd_soc_core
> Jun 09 23:00:08 frame kernel:  snd_hda_codec_hdmi btintel snd_hda_scodec_=
component pcspkr videobuf2_common snd_compress snd_hda_codec_generic blueto=
oth libarc4 snd_pcm_dmaengine snd_usb_audio k10temp snd_rpl_pci_acp6x spd51=
18 snd_hda_intel snd_usbmidi_lib ecdh_generic snd_acp_pci snd_hda_codec snd=
_amd_acpi_mach snd_hda_core snd_rawmidi snd_intel_dspcfg snd_acp_legacy_com=
mon snd_seq_device snd_intel_sdw_acpi snd_pci_acp6x mc snd_hwdep iwlwifi am=
dxdna snd_pcm snd_pci_acp5x snd_timer amd_pmf snd_rn_pci_acp3x drm_shmem_he=
lper snd_acp_config cfg80211 amdtee snd snd_soc_acpi snd_pci_acp3x soundcor=
e rfkill ccp ac amd_sfh joydev tee platform_profile amd_pmc evdev binfmt_mi=
sc lp parport_pc ppdev parport msr i2c_dev configfs efi_pstore nfnetlink ef=
ivarfs autofs4 ext4 mbcache jbd2 crc32c_cryptoapi r8153_ecm cdc_ether usbne=
t r8152 mii dm_crypt dm_mod amdgpu usbhid amdxcp drm_panel_backlight_quirks=
 gpu_sched drm_buddy drm_ttm_helper ttm drm_exec i2c_algo_bit drm_suballoc_=
helper ucsi_acpi drm_display_helper typec_ucsi hid_multitouch typec
> Jun 09 23:00:08 frame kernel:  hid_sensor_hub cec hid_generic roles rc_co=
re i2c_hid_acpi drm_client_lib i2c_hid cros_ec_debugfs hid cros_ec_chardev =
cros_charge_control cros_ec_sysfs drm_kms_helper cros_kbd_led_backlight nvm=
e xhci_pci ghash_clmulni_intel cros_ec_dev xhci_hcd nvme_core aesni_intel s=
erio_raw drm sp5100_tco nvme_keyring battery watchdog thunderbolt usbcore n=
vme_auth cros_ec_lpcs video crc16 hkdf cros_ec i2c_piix4 cros_ec_proto wmi =
button i2c_smbus usb_common
> Jun 09 23:00:08 frame kernel: ---[ end trace 0000000000000000 ]---

I didn't find a similar report on lore.kernel.org. Does this ring a bell
for you anyhow?

There are a few amdgpu changes in 7.0.11 (since 7.0.10 which is the
kernel that showed the issue), but they don't look (to me that is) as if
they would resolve the problem.

Best regards
Uwe

--joo4pr4gfijdzfcq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoxE4oACgkQj4D7WH0S
/k7GPAf+JY1cIdZGbcXueuvVlTl9A3nwPw9TSh2xLybtDAzVi3LiIM7aFWiBNuv2
aUeUVDJs7mJPSbisYRrUFjcZKiCBx0JyaMYWG49pxGgOVdklmLXEFrp0y7yYbZoY
QgvdMSI6IEJT/Go3+dHrfvQDiEnkxqOsVjAqkFZ1OoJCY7VjLya41rkjL8H3sx7p
Hh5lXfGh4dOatgasWPSA0wrP2nH+CHfNNamgcMQ2gnKaK5fem6LnQgZ55zw1hovQ
UDHrrJ6pwbeBObDnFBePtWZtBCwj+1xRKoO3jft9USkcWxA/ooS9aaSt1ir2NvFY
XHiT+S+2+Eox/hXstorMJiWKVofI0w==
=8/oq
-----END PGP SIGNATURE-----

--joo4pr4gfijdzfcq--
