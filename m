Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE284C4829E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 20:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F0889207;
	Thu, 15 Feb 2024 20:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vylpdzfi";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AB9C89207
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 20:33:39 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-1d72f71f222so10864985ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 12:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708029219; x=1708634019; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6E1M26bah9Kiti5cjslDhkadRIP96QC9BsUNUPWDPE8=;
 b=VylpdzfiwgPFxKhijK6oFe1C3iXDD2B7uYrYDo96mHnhfJ7eb6NkYPNXmPFrVpnUVN
 Hly2iysCRKVkuSuZokzIwTFUHP3yhpIqKg8AtBWwavUzhrbhqVyJ91oaBzix9vTupktL
 VyeCEWQzaCJyzCqyhVBssEgi9K2FS341RJrs3uC0KhRUt8VoTO63/zM9ZhwvY3LNCMnd
 HjuA6usUOnzoLmy9QMTBWrZYkUg2w4JDMiQn3L3a5gUKpqhl5MCTzHykXkdCncjbrN7l
 v2U4vNtToyOXCFuDlI2bRrk4sEryM48CZxqnHMQnZWo0COt+R0Ul+RbgwnHiClrkR7qT
 bvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708029219; x=1708634019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6E1M26bah9Kiti5cjslDhkadRIP96QC9BsUNUPWDPE8=;
 b=c8BOQTHw07SQeZSxKuHefGfVH5VhjkNM3e3tAUWDyRO2EGeaniz2cb+2HNLP/cfeyj
 XKbEGDyI1zCaJ19vkeaeF0P+OeMTrfxQLGpLjhL/zHI8EhlLmyvsrUwBu0Fx8uffgclW
 8KOBZYuRRST/w998ajVMTwGM+xqNETMVyU7DWPpo9iAJhWqrCUbxpXaX1X/KirqSMhVo
 iFCC6w9YnHmUbQaXh3byNub20q5Nj/06V1vPD61U1T2m87wPRl1CbpzUqbVXGq7GK+PU
 dh5OzCCoIj+r7VjwGo5hLTWGxA1Ds8O5YSswfgIQxGyASHJRKm8aQ8wL0Agb5uUZCWbC
 sRtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeq7MJYY+04N7R9xHOT2w867kNlYbEgIzNlDRdSXQK/B5l0FK/OpHWQkiuBnJhtMgDhQpdbn8MaELslpsy9iPlsSF/U8IE5drgk5j2yw==
X-Gm-Message-State: AOJu0YxAU6bq1T9hGtpISlOaIM2EZNCcPJRAPvDS1nNjcFf9enEWJFm2
 dF8HVnwlHVdaQ70ib4oBG7H6+pvYPXsq5JLU24ZQWYma6PzaWolPk2bwL9ap7PaFFZ6zMcg8/sE
 e4SCpWopXWBeCyHUkpK3xHPS3+Aw=
X-Google-Smtp-Source: AGHT+IHeUsARHbPd8sJRlBKCcuGCMZTIJ4R0MJ6OtvdWCoDrEyPNNMfXfWOmF6udp0Jn1pr2uArqYUiEbqebBvprWKg=
X-Received: by 2002:a17:903:11c8:b0:1da:2a50:cbf8 with SMTP id
 q8-20020a17090311c800b001da2a50cbf8mr3318222plh.43.1708029218819; Thu, 15 Feb
 2024 12:33:38 -0800 (PST)
MIME-Version: 1.0
References: <20240215173509.152760-1-mwen@igalia.com>
In-Reply-To: <20240215173509.152760-1-mwen@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Feb 2024 15:33:26 -0500
Message-ID: <CADnq5_M=pXCWRid6FdJwt7Y7pJ8QZLKSVfo3DoqDLQLNks09uA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix null-pointer dereference on edid
 reading
To: Melissa Wen <mwen@igalia.com>
Cc: Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 sunpeng.li@amd.com, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 christian.koenig@amd.com, 
 Xinhui.Pan@amd.com, alex.hung@amd.com, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
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

On Thu, Feb 15, 2024 at 12:35=E2=80=AFPM Melissa Wen <mwen@igalia.com> wrot=
e:
>
> Use i2c adapter when there isn't aux_mode in dc_link to fix a
> null-pointer derefence that happens when running
> igt@kms_force_connector_basic in a system with DCN2.1 and HDMI connector
> detected as below:
>
> [  +0.178146] BUG: kernel NULL pointer dereference, address: 000000000000=
04c0
> [  +0.000010] #PF: supervisor read access in kernel mode
> [  +0.000005] #PF: error_code(0x0000) - not-present page
> [  +0.000004] PGD 0 P4D 0
> [  +0.000006] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  +0.000006] CPU: 15 PID: 2368 Comm: kms_force_conne Not tainted 6.5.0-a=
sdn+ #152
> [  +0.000005] Hardware name: HP HP ENVY x360 Convertible 13-ay1xxx/8929, =
BIOS F.01 07/14/2021
> [  +0.000004] RIP: 0010:i2c_transfer+0xd/0x100
> [  +0.000011] Code: ea fc ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90=
 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 41 54 55 53 <4=
8> 8b 47 10 48 89 fb 48 83 38 00 0f 84 b3 00 00 00 83 3d 2f 80 16
> [  +0.000004] RSP: 0018:ffff9c4f89c0fad0 EFLAGS: 00010246
> [  +0.000005] RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000=
000080
> [  +0.000003] RDX: 0000000000000002 RSI: ffff9c4f89c0fb20 RDI: 0000000000=
0004b0
> [  +0.000003] RBP: ffff9c4f89c0fb80 R08: 0000000000000080 R09: ffff8d8e0b=
15b980
> [  +0.000003] R10: 00000000000380e0 R11: 0000000000000000 R12: 0000000000=
000080
> [  +0.000002] R13: 0000000000000002 R14: ffff9c4f89c0fb0e R15: ffff9c4f89=
c0fb0f
> [  +0.000004] FS:  00007f9ad2176c40(0000) GS:ffff8d90fe9c0000(0000) knlGS=
:0000000000000000
> [  +0.000003] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000004] CR2: 00000000000004c0 CR3: 0000000121bc4000 CR4: 0000000000=
750ee0
> [  +0.000003] PKRU: 55555554
> [  +0.000003] Call Trace:
> [  +0.000006]  <TASK>
> [  +0.000006]  ? __die+0x23/0x70
> [  +0.000011]  ? page_fault_oops+0x17d/0x4c0
> [  +0.000008]  ? preempt_count_add+0x6e/0xa0
> [  +0.000008]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000011]  ? exc_page_fault+0x7f/0x180
> [  +0.000009]  ? asm_exc_page_fault+0x26/0x30
> [  +0.000013]  ? i2c_transfer+0xd/0x100
> [  +0.000010]  drm_do_probe_ddc_edid+0xc2/0x140 [drm]
> [  +0.000067]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000006]  ? _drm_do_get_edid+0x97/0x3c0 [drm]
> [  +0.000043]  ? __pfx_drm_do_probe_ddc_edid+0x10/0x10 [drm]
> [  +0.000042]  edid_block_read+0x3b/0xd0 [drm]
> [  +0.000043]  _drm_do_get_edid+0xb6/0x3c0 [drm]
> [  +0.000041]  ? __pfx_drm_do_probe_ddc_edid+0x10/0x10 [drm]
> [  +0.000043]  drm_edid_read_custom+0x37/0xd0 [drm]
> [  +0.000044]  amdgpu_dm_connector_mode_valid+0x129/0x1d0 [amdgpu]
> [  +0.000153]  drm_connector_mode_valid+0x3b/0x60 [drm_kms_helper]
> [  +0.000000]  __drm_helper_update_and_validate+0xfe/0x3c0 [drm_kms_helpe=
r]
> [  +0.000000]  ? amdgpu_dm_connector_get_modes+0xb6/0x520 [amdgpu]
> [  +0.000000]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000000]  drm_helper_probe_single_connector_modes+0x2ab/0x540 [drm_k=
ms_helper]
> [  +0.000000]  status_store+0xb2/0x1f0 [drm]
> [  +0.000000]  kernfs_fop_write_iter+0x136/0x1d0
> [  +0.000000]  vfs_write+0x24d/0x440
> [  +0.000000]  ksys_write+0x6f/0xf0
> [  +0.000000]  do_syscall_64+0x60/0xc0
> [  +0.000000]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000000]  ? syscall_exit_to_user_mode+0x2b/0x40
> [  +0.000000]  ? srso_alias_return_thunk+0x5/0x7f
> [  +0.000000]  ? do_syscall_64+0x6c/0xc0
> [  +0.000000]  ? do_syscall_64+0x6c/0xc0
> [  +0.000000]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  +0.000000] RIP: 0033:0x7f9ad46b4b00
> [  +0.000000] Code: 40 00 48 8b 15 19 b3 0d 00 f7 d8 64 89 02 48 c7 c0 ff=
 ff ff ff eb b7 0f 1f 00 80 3d e1 3a 0e 00 00 74 17 b8 01 00 00 00 0f 05 <4=
8> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> [  +0.000000] RSP: 002b:00007ffcbd3bd6d8 EFLAGS: 00000202 ORIG_RAX: 00000=
00000000001
> [  +0.000000] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9ad4=
6b4b00
> [  +0.000000] RDX: 0000000000000002 RSI: 00007f9ad48a7417 RDI: 0000000000=
000009
> [  +0.000000] RBP: 0000000000000002 R08: 0000000000000064 R09: 0000000000=
000000
> [  +0.000000] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f9ad4=
8a7417
> [  +0.000000] R13: 0000000000000009 R14: 00007ffcbd3bd760 R15: 0000000000=
000001
> [  +0.000000]  </TASK>
> [  +0.000000] Modules linked in: ctr ccm rfcomm snd_seq_dummy snd_hrtimer=
 snd_seq snd_seq_device cmac algif_hash algif_skcipher af_alg bnep btusb bt=
rtl btbcm btintel btmtk bluetooth uvcvideo videobuf2_vmalloc sha3_generic v=
ideobuf2_memops uvc jitterentropy_rng videobuf2_v4l2 videodev drbg videobuf=
2_common ansi_cprng mc ecdh_generic ecc qrtr binfmt_misc hid_sensor_accel_3=
d hid_sensor_magn_3d hid_sensor_gyro_3d hid_sensor_trigger industrialio_tri=
ggered_buffer kfifo_buf industrialio snd_ctl_led joydev hid_sensor_iio_comm=
on rtw89_8852ae rtw89_8852a rtw89_pci snd_hda_codec_realtek rtw89_core snd_=
hda_codec_generic intel_rapl_msr ledtrig_audio intel_rapl_common snd_hda_co=
dec_hdmi mac80211 snd_hda_intel snd_intel_dspcfg kvm_amd snd_hda_codec snd_=
soc_dmic snd_acp3x_rn snd_acp3x_pdm_dma libarc4 snd_hwdep snd_soc_core kvm =
snd_hda_core cfg80211 snd_pci_acp6x snd_pcm nls_ascii snd_timer hp_wmi snd_=
pci_acp5x nls_cp437 snd_rn_pci_acp3x ucsi_acpi sparse_keymap ccp snd platfo=
rm_profile snd_acp_config typec_ucsi irqbypass vfat sp5100_tco
> [  +0.000000]  snd_soc_acpi fat rapl pcspkr wmi_bmof roles rfkill rng_cor=
e snd_pci_acp3x soundcore k10temp watchdog typec battery ac amd_pmc acpi_ta=
d button hid_sensor_hub hid_multitouch evdev serio_raw msr parport_pc ppdev=
 lp parport fuse loop efi_pstore configfs ip_tables x_tables autofs4 ext4 c=
rc16 mbcache jbd2 btrfs blake2b_generic dm_crypt dm_mod efivarfs raid10 rai=
d456 async_raid6_recov async_memcpy async_pq async_xor async_tx libcrc32c c=
rc32c_generic xor raid6_pq raid1 raid0 multipath linear md_mod amdgpu amdxc=
p i2c_algo_bit drm_ttm_helper ttm crc32_pclmul crc32c_intel drm_exec gpu_sc=
hed drm_suballoc_helper nvme ghash_clmulni_intel drm_buddy drm_display_help=
er sha512_ssse3 nvme_core ahci xhci_pci sha512_generic hid_generic xhci_hcd=
 libahci rtsx_pci_sdmmc t10_pi i2c_hid_acpi drm_kms_helper i2c_hid mmc_core=
 libata aesni_intel crc64_rocksoft_generic crypto_simd amd_sfh crc64_rockso=
ft scsi_mod usbcore cryptd crc_t10dif cec drm crct10dif_generic hid rtsx_pc=
i crct10dif_pclmul scsi_common rc_core crc64 i2c_piix4
> [  +0.000000]  usb_common crct10dif_common video wmi
> [  +0.000000] CR2: 00000000000004c0
> [  +0.000000] ---[ end trace 0000000000000000 ]---
>
> Fixes: e54ed41620f ("drm/amd/display: Remove unwanted drm edid references=
")
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>
> Hi,
>
> I'm still working on the migration from edid to drm_edid, but I found a
> way to fix the issue using the current approach, so we don't need to
> delay this bug fix.
>
> BR,
>
> Melissa
>
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b9ac3d2f8029..9f67d9030c36 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6654,6 +6654,12 @@ static void amdgpu_dm_connector_funcs_force(struct=
 drm_connector *connector)
>         struct dc_link *dc_link =3D aconnector->dc_link;
>         struct dc_sink *dc_em_sink =3D aconnector->dc_em_sink;
>         struct edid *edid;
> +       struct i2c_adapter *ddc;
> +
> +       if (dc_link->aux_mode)
> +               ddc =3D &aconnector->dm_dp_aux.aux.ddc;
> +       else
> +               ddc =3D &aconnector->i2c->base;
>
>         /*
>          * Note: drm_get_edid gets edid in the following order:
> @@ -6661,7 +6667,7 @@ static void amdgpu_dm_connector_funcs_force(struct =
drm_connector *connector)
>          * 2) firmware EDID if set via edid_firmware module parameter
>          * 3) regular DDC read.
>          */
> -       edid =3D drm_get_edid(connector, &amdgpu_connector->ddc_bus->aux.=
ddc);
> +       edid =3D drm_get_edid(connector, ddc);
>         if (!edid) {
>                 DRM_ERROR("No EDID found on connector: %s.\n", connector-=
>name);
>                 return;
> @@ -6703,11 +6709,18 @@ static void create_eml_sink(struct amdgpu_dm_conn=
ector *aconnector)
>  {
>         struct drm_connector *connector =3D &aconnector->base;
>         struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_connector=
(&aconnector->base);

According to our CI, this is no longer used and leads to an unused
variable warning.

Alex

> +       struct dc_link *dc_link =3D aconnector->dc_link;
>         struct dc_sink_init_data init_params =3D {
>                         .link =3D aconnector->dc_link,
>                         .sink_signal =3D SIGNAL_TYPE_VIRTUAL
>         };
>         struct edid *edid;
> +       struct i2c_adapter *ddc;
> +
> +       if (dc_link->aux_mode)
> +               ddc =3D &aconnector->dm_dp_aux.aux.ddc;
> +       else
> +               ddc =3D &aconnector->i2c->base;
>
>         /*
>          * Note: drm_get_edid gets edid in the following order:
> @@ -6715,7 +6728,7 @@ static void create_eml_sink(struct amdgpu_dm_connec=
tor *aconnector)
>          * 2) firmware EDID if set via edid_firmware module parameter
>          * 3) regular DDC read.
>          */
> -       edid =3D drm_get_edid(connector, &amdgpu_connector->ddc_bus->aux.=
ddc);
> +       edid =3D drm_get_edid(connector, ddc);
>         if (!edid) {
>                 DRM_ERROR("No EDID found on connector: %s.\n", connector-=
>name);
>                 return;
> --
> 2.43.0
>
