Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3C8C48260
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Feb 2024 12:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D8610E5DA;
	Fri, 16 Feb 2024 12:31:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="fV9cA/Ky";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93B3D10E5DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 12:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yfLbx22WrVWey2TqrKL7Cnoc5tZF3c9THLzxk4CMHV4=; b=fV9cA/Kyxjvo3qETChjEh0hq7/
 hhE0Zb9qG0Nf0ERc/rKTLrko3jfJJQzVWGpRyUkUpjHIjX7X5qmiq3QT06WvBZYE6EZPu4NtT4s3m
 K+MlxSqKEO464AIa7YB1NZVIKTek5j9R519PF7kdmVMkkA8QR9Vx5dpv2PHTZhVjCyrf274N1+F/+
 P4lzRaAq4HVXFJY/Q/77WY9XPw9WzMzN2ybyKuo6LfTqjeO2nhRxkhdc+FE9owWTw62EGcQW6H0Gk
 RPvtvjSxd1RNppS1M83j115h3t96wwzoFSNrLEjWbuujeQX8YLWZIjoMVOPEAHXtqgF4C8MfjST9H
 YGEXWm+A==;
Received: from [186.193.11.42] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1raxNi-000QSB-Lc; Fri, 16 Feb 2024 13:31:55 +0100
Date: Fri, 16 Feb 2024 09:29:28 -0300
From: Melissa Wen <mwen@igalia.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, sunpeng.li@amd.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 christian.koenig@amd.com, Xinhui.Pan@amd.com, alex.hung@amd.com, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH] drm/amd/display: fix null-pointer dereference on edid
 reading
Message-ID: <66nget644h35hvtdiispnrmfnskvi4j6t3g66wunoq25uk2mzi@xela7x6nhuhc>
References: <20240215173509.152760-1-mwen@igalia.com>
 <CADnq5_M=pXCWRid6FdJwt7Y7pJ8QZLKSVfo3DoqDLQLNks09uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CADnq5_M=pXCWRid6FdJwt7Y7pJ8QZLKSVfo3DoqDLQLNks09uA@mail.gmail.com>
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

On 02/15, Alex Deucher wrote:
> On Thu, Feb 15, 2024 at 12:35=E2=80=AFPM Melissa Wen <mwen@igalia.com> wr=
ote:
> >
> > Use i2c adapter when there isn't aux_mode in dc_link to fix a
> > null-pointer derefence that happens when running
> > igt@kms_force_connector_basic in a system with DCN2.1 and HDMI connector
> > detected as below:
> >
> > [  +0.178146] BUG: kernel NULL pointer dereference, address: 0000000000=
0004c0
> > [  +0.000010] #PF: supervisor read access in kernel mode
> > [  +0.000005] #PF: error_code(0x0000) - not-present page
> > [  +0.000004] PGD 0 P4D 0
> > [  +0.000006] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [  +0.000006] CPU: 15 PID: 2368 Comm: kms_force_conne Not tainted 6.5.0=
-asdn+ #152
> > [  +0.000005] Hardware name: HP HP ENVY x360 Convertible 13-ay1xxx/8929=
, BIOS F.01 07/14/2021
> > [  +0.000004] RIP: 0010:i2c_transfer+0xd/0x100
> > [  +0.000011] Code: ea fc ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 =
90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 54 55 53 =
<48> 8b 47 10 48 89 fb 48 83 38 00 0f 84 b3 00 00 00 83 3d 2f 80 16
> > [  +0.000004] RSP: 0018:ffff9c4f89c0fad0 EFLAGS: 00010246
> > [  +0.000005] RAX: 0000000000000000 RBX: 0000000000000005 RCX: 00000000=
00000080
> > [  +0.000003] RDX: 0000000000000002 RSI: ffff9c4f89c0fb20 RDI: 00000000=
000004b0
> > [  +0.000003] RBP: ffff9c4f89c0fb80 R08: 0000000000000080 R09: ffff8d8e=
0b15b980
> > [  +0.000003] R10: 00000000000380e0 R11: 0000000000000000 R12: 00000000=
00000080
> > [  +0.000002] R13: 0000000000000002 R14: ffff9c4f89c0fb0e R15: ffff9c4f=
89c0fb0f
> > [  +0.000004] FS:  00007f9ad2176c40(0000) GS:ffff8d90fe9c0000(0000) knl=
GS:0000000000000000
> > [  +0.000003] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  +0.000004] CR2: 00000000000004c0 CR3: 0000000121bc4000 CR4: 00000000=
00750ee0
> > [  +0.000003] PKRU: 55555554
> > [  +0.000003] Call Trace:
> > [  +0.000006]  <TASK>
> > [  +0.000006]  ? __die+0x23/0x70
> > [  +0.000011]  ? page_fault_oops+0x17d/0x4c0
> > [  +0.000008]  ? preempt_count_add+0x6e/0xa0
> > [  +0.000008]  ? srso_alias_return_thunk+0x5/0x7f
> > [  +0.000011]  ? exc_page_fault+0x7f/0x180
> > [  +0.000009]  ? asm_exc_page_fault+0x26/0x30
> > [  +0.000013]  ? i2c_transfer+0xd/0x100
> > [  +0.000010]  drm_do_probe_ddc_edid+0xc2/0x140 [drm]
> > [  +0.000067]  ? srso_alias_return_thunk+0x5/0x7f
> > [  +0.000006]  ? _drm_do_get_edid+0x97/0x3c0 [drm]
> > [  +0.000043]  ? __pfx_drm_do_probe_ddc_edid+0x10/0x10 [drm]
> > [  +0.000042]  edid_block_read+0x3b/0xd0 [drm]
> > [  +0.000043]  _drm_do_get_edid+0xb6/0x3c0 [drm]
> > [  +0.000041]  ? __pfx_drm_do_probe_ddc_edid+0x10/0x10 [drm]
> > [  +0.000043]  drm_edid_read_custom+0x37/0xd0 [drm]
> > [  +0.000044]  amdgpu_dm_connector_mode_valid+0x129/0x1d0 [amdgpu]
> > [  +0.000153]  drm_connector_mode_valid+0x3b/0x60 [drm_kms_helper]
> > [  +0.000000]  __drm_helper_update_and_validate+0xfe/0x3c0 [drm_kms_hel=
per]
> > [  +0.000000]  ? amdgpu_dm_connector_get_modes+0xb6/0x520 [amdgpu]
> > [  +0.000000]  ? srso_alias_return_thunk+0x5/0x7f
> > [  +0.000000]  drm_helper_probe_single_connector_modes+0x2ab/0x540 [drm=
_kms_helper]
> > [  +0.000000]  status_store+0xb2/0x1f0 [drm]
> > [  +0.000000]  kernfs_fop_write_iter+0x136/0x1d0
> > [  +0.000000]  vfs_write+0x24d/0x440
> > [  +0.000000]  ksys_write+0x6f/0xf0
> > [  +0.000000]  do_syscall_64+0x60/0xc0
> > [  +0.000000]  ? srso_alias_return_thunk+0x5/0x7f
> > [  +0.000000]  ? syscall_exit_to_user_mode+0x2b/0x40
> > [  +0.000000]  ? srso_alias_return_thunk+0x5/0x7f
> > [  +0.000000]  ? do_syscall_64+0x6c/0xc0
> > [  +0.000000]  ? do_syscall_64+0x6c/0xc0
> > [  +0.000000]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [  +0.000000] RIP: 0033:0x7f9ad46b4b00
> > [  +0.000000] Code: 40 00 48 8b 15 19 b3 0d 00 f7 d8 64 89 02 48 c7 c0 =
ff ff ff ff eb b7 0f 1f 00 80 3d e1 3a 0e 00 00 74 17 b8 01 00 00 00 0f 05 =
<48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> > [  +0.000000] RSP: 002b:00007ffcbd3bd6d8 EFLAGS: 00000202 ORIG_RAX: 000=
0000000000001
> > [  +0.000000] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9a=
d46b4b00
> > [  +0.000000] RDX: 0000000000000002 RSI: 00007f9ad48a7417 RDI: 00000000=
00000009
> > [  +0.000000] RBP: 0000000000000002 R08: 0000000000000064 R09: 00000000=
00000000
> > [  +0.000000] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f9a=
d48a7417
> > [  +0.000000] R13: 0000000000000009 R14: 00007ffcbd3bd760 R15: 00000000=
00000001
> > [  +0.000000]  </TASK>
> > [  +0.000000] Modules linked in: ctr ccm rfcomm snd_seq_dummy snd_hrtim=
er snd_seq snd_seq_device cmac algif_hash algif_skcipher af_alg bnep btusb =
btrtl btbcm btintel btmtk bluetooth uvcvideo videobuf2_vmalloc sha3_generic=
 videobuf2_memops uvc jitterentropy_rng videobuf2_v4l2 videodev drbg videob=
uf2_common ansi_cprng mc ecdh_generic ecc qrtr binfmt_misc hid_sensor_accel=
_3d hid_sensor_magn_3d hid_sensor_gyro_3d hid_sensor_trigger industrialio_t=
riggered_buffer kfifo_buf industrialio snd_ctl_led joydev hid_sensor_iio_co=
mmon rtw89_8852ae rtw89_8852a rtw89_pci snd_hda_codec_realtek rtw89_core sn=
d_hda_codec_generic intel_rapl_msr ledtrig_audio intel_rapl_common snd_hda_=
codec_hdmi mac80211 snd_hda_intel snd_intel_dspcfg kvm_amd snd_hda_codec sn=
d_soc_dmic snd_acp3x_rn snd_acp3x_pdm_dma libarc4 snd_hwdep snd_soc_core kv=
m snd_hda_core cfg80211 snd_pci_acp6x snd_pcm nls_ascii snd_timer hp_wmi sn=
d_pci_acp5x nls_cp437 snd_rn_pci_acp3x ucsi_acpi sparse_keymap ccp snd plat=
form_profile snd_acp_config typec_ucsi irqbypass vfat sp5100_tco
> > [  +0.000000]  snd_soc_acpi fat rapl pcspkr wmi_bmof roles rfkill rng_c=
ore snd_pci_acp3x soundcore k10temp watchdog typec battery ac amd_pmc acpi_=
tad button hid_sensor_hub hid_multitouch evdev serio_raw msr parport_pc ppd=
ev lp parport fuse loop efi_pstore configfs ip_tables x_tables autofs4 ext4=
 crc16 mbcache jbd2 btrfs blake2b_generic dm_crypt dm_mod efivarfs raid10 r=
aid456 async_raid6_recov async_memcpy async_pq async_xor async_tx libcrc32c=
 crc32c_generic xor raid6_pq raid1 raid0 multipath linear md_mod amdgpu amd=
xcp i2c_algo_bit drm_ttm_helper ttm crc32_pclmul crc32c_intel drm_exec gpu_=
sched drm_suballoc_helper nvme ghash_clmulni_intel drm_buddy drm_display_he=
lper sha512_ssse3 nvme_core ahci xhci_pci sha512_generic hid_generic xhci_h=
cd libahci rtsx_pci_sdmmc t10_pi i2c_hid_acpi drm_kms_helper i2c_hid mmc_co=
re libata aesni_intel crc64_rocksoft_generic crypto_simd amd_sfh crc64_rock=
soft scsi_mod usbcore cryptd crc_t10dif cec drm crct10dif_generic hid rtsx_=
pci crct10dif_pclmul scsi_common rc_core crc64 i2c_piix4
> > [  +0.000000]  usb_common crct10dif_common video wmi
> > [  +0.000000] CR2: 00000000000004c0
> > [  +0.000000] ---[ end trace 0000000000000000 ]---
> >
> > Fixes: e54ed41620f ("drm/amd/display: Remove unwanted drm edid referenc=
es")
> > Signed-off-by: Melissa Wen <mwen@igalia.com>
> > ---
> >
> > Hi,
> >
> > I'm still working on the migration from edid to drm_edid, but I found a
> > way to fix the issue using the current approach, so we don't need to
> > delay this bug fix.
> >
> > BR,
> >
> > Melissa
> >
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index b9ac3d2f8029..9f67d9030c36 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -6654,6 +6654,12 @@ static void amdgpu_dm_connector_funcs_force(stru=
ct drm_connector *connector)
> >         struct dc_link *dc_link =3D aconnector->dc_link;
> >         struct dc_sink *dc_em_sink =3D aconnector->dc_em_sink;
> >         struct edid *edid;
> > +       struct i2c_adapter *ddc;
> > +
> > +       if (dc_link->aux_mode)
> > +               ddc =3D &aconnector->dm_dp_aux.aux.ddc;
> > +       else
> > +               ddc =3D &aconnector->i2c->base;
> >
> >         /*
> >          * Note: drm_get_edid gets edid in the following order:
> > @@ -6661,7 +6667,7 @@ static void amdgpu_dm_connector_funcs_force(struc=
t drm_connector *connector)
> >          * 2) firmware EDID if set via edid_firmware module parameter
> >          * 3) regular DDC read.
> >          */
> > -       edid =3D drm_get_edid(connector, &amdgpu_connector->ddc_bus->au=
x.ddc);
> > +       edid =3D drm_get_edid(connector, ddc);
> >         if (!edid) {
> >                 DRM_ERROR("No EDID found on connector: %s.\n", connecto=
r->name);
> >                 return;
> > @@ -6703,11 +6709,18 @@ static void create_eml_sink(struct amdgpu_dm_co=
nnector *aconnector)
> >  {
> >         struct drm_connector *connector =3D &aconnector->base;
> >         struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_connect=
or(&aconnector->base);
>=20
> According to our CI, this is no longer used and leads to an unused
> variable warning.

Oops, sorry. Just sent a v2.

Thanks,

Melissa
>=20
> Alex
>=20
> > +       struct dc_link *dc_link =3D aconnector->dc_link;
> >         struct dc_sink_init_data init_params =3D {
> >                         .link =3D aconnector->dc_link,
> >                         .sink_signal =3D SIGNAL_TYPE_VIRTUAL
> >         };
> >         struct edid *edid;
> > +       struct i2c_adapter *ddc;
> > +
> > +       if (dc_link->aux_mode)
> > +               ddc =3D &aconnector->dm_dp_aux.aux.ddc;
> > +       else
> > +               ddc =3D &aconnector->i2c->base;
> >
> >         /*
> >          * Note: drm_get_edid gets edid in the following order:
> > @@ -6715,7 +6728,7 @@ static void create_eml_sink(struct amdgpu_dm_conn=
ector *aconnector)
> >          * 2) firmware EDID if set via edid_firmware module parameter
> >          * 3) regular DDC read.
> >          */
> > -       edid =3D drm_get_edid(connector, &amdgpu_connector->ddc_bus->au=
x.ddc);
> > +       edid =3D drm_get_edid(connector, ddc);
> >         if (!edid) {
> >                 DRM_ERROR("No EDID found on connector: %s.\n", connecto=
r->name);
> >                 return;
> > --
> > 2.43.0
> >
