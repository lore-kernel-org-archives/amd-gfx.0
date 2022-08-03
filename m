Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F65C3F6B0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Aug 2022 16:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A162C11AE51;
	Wed,  3 Aug 2022 16:30:22 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D981110F066
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Aug 2022 16:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d3lI/n0DQlC6/35HbAsTJhjn7Jimq1jxItGybqOfrvg=; b=Ss95/gziEzrojbiodshV96KYMc
 jb2H+W8sLvJnJqoZUdeWarKrYjHnR5E4ItglAPreAZEBL/xBqtvSKoXk8l/IPMheglXbEpQW6MtXI
 W190hujaSI2B33m691HXj6ZvjpptSseA5xCruyAKZcswj6p1yvgvx1qaXfpWIkDY1S/s6LUA2N7Tr
 otMFgFoFJ6LvxokQWx1UrZs6u9A+iSj0A1MirCkw2Az98sj8VrH0/cpkppWxbuKuHRez9yVu4UgrH
 JSgNBCKJhiYYY9vNltTLbDsjijx9uGOnW2Lsuj9gZmr9FNy4IKutsF4WQs7EOMRfjC3vUxON43Kxt
 CUh8tkKQ==;
Received: from [165.90.126.25] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1oJHG2-00Fd4c-C5; Wed, 03 Aug 2022 18:30:06 +0200
Date: Wed, 3 Aug 2022 15:29:52 -0100
From: Melissa Wen <mwen@igalia.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, sungjoon.kim@amd.com, nikola.cornij@amd.com
Subject: Re: [PATCH] drm/amd/display: set panel orientation before
 drm_dev_register
Message-ID: <20220803162952.odxi24tb6krgt42n@mail.igalia.com>
References: <20220803162402.3412968-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="se7qec4jvcwmn7c5"
Content-Disposition: inline
In-Reply-To: <20220803162402.3412968-1-mwen@igalia.com>
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
Cc: contact@emersion.fr, kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--se7qec4jvcwmn7c5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08/03, Melissa Wen wrote:
> To set the panel orientation property with quirk, we need the mode size
> provided by EDID. This info is available after EDID is read by dc_link_de=
tect()
> and updated by amdgpu_dm_update_connector_after_detect(). The detection
> happens at driver load in amdgpu_dm_initialize_drm_device() and,
> therefore, we can get modes and set panel orientation before
> drm_dev_register() to avoid DRM warns on creating the connector property
> after device registration:

+ cc'ing: Simon Ser

>=20
> [    2.563969] ------------[ cut here ]------------
> [    2.563971] WARNING: CPU: 6 PID: 325 at drivers/gpu/drm/drm_mode_objec=
t.c:45 drm_mode_object_add+0x72/0x80 [drm]
> [    2.563997] Modules linked in: btusb btrtl btbcm btintel btmtk bluetoo=
th rfkill ecdh_generic ecc usbhid crc16 amdgpu(+) drm_ttm_helper ttm agpgar=
t gpu_sched i2c_algo_bit drm_display_helper drm_kms_helper syscopyarea sysf=
illrect sysimgblt fb_sys_fops drm serio_raw sdhci_pci atkbd libps2 cqhci vi=
valdi_fmap ccp sdhci i8042 crct10dif_pclmul crc32_pclmul hid_multitouch gha=
sh_clmulni_intel aesni_intel crypto_simd cryptd wdat_wdt mmc_core cec xhci_=
pci sp5100_tco rng_core xhci_pci_renesas serio 8250_dw i2c_hid_acpi i2c_hid=
 btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel xor raid6_pq d=
m_mirror dm_region_hash dm_log dm_mod pkcs8_key_parser crypto_user
> [    2.564032] CPU: 6 PID: 325 Comm: systemd-udevd Not tainted 5.18.0-amd=
-staging-drm-next+ #67
> [    2.564034] Hardware name: Valve Jupiter/Jupiter, BIOS F7A0105 03/21/2=
022
> [    2.564036] RIP: 0010:drm_mode_object_add+0x72/0x80 [drm]
> [    2.564053] Code: f0 89 c3 85 c0 78 07 89 45 00 44 89 65 04 4c 89 ef e=
8 e2 99 04 f1 31 c0 85 db 0f 4e c3 5b 5d 41 5c 41 5d c3 80 7f 50 00 74 ac <=
0f> 0b eb a8 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 54 4c
> [    2.564055] RSP: 0018:ffffb2e880413860 EFLAGS: 00010202
> [    2.564056] RAX: ffffffffc0ba1440 RBX: ffff99508a860010 RCX: 000000000=
0000001
> [    2.564057] RDX: 00000000b0b0b0b0 RSI: ffff99508c050110 RDI: ffff99508=
a860010
> [    2.564058] RBP: ffff99508c050110 R08: 0000000000000020 R09: ffff99508=
c292c20
> [    2.564059] R10: 0000000000000000 R11: ffff99508c0507d8 R12: 00000000b=
0b0b0b0
> [    2.564060] R13: 0000000000000004 R14: ffffffffc068a4b6 R15: ffffffffc=
068a47f
> [    2.564061] FS:  00007fc69b5f1a40(0000) GS:ffff9953aff80000(0000) knlG=
S:0000000000000000
> [    2.564063] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.564063] CR2: 00007f9506804000 CR3: 0000000107f92000 CR4: 000000000=
0350ee0
> [    2.564065] Call Trace:
> [    2.564068]  <TASK>
> [    2.564070]  drm_property_create+0xc9/0x170 [drm]
> [    2.564088]  drm_property_create_enum+0x1f/0x70 [drm]
> [    2.564105]  drm_connector_set_panel_orientation_with_quirk+0x96/0xc0 =
[drm]
> [    2.564123]  get_modes+0x4fb/0x530 [amdgpu]
> [    2.564378]  drm_helper_probe_single_connector_modes+0x1ad/0x850 [drm_=
kms_helper]
> [    2.564390]  drm_client_modeset_probe+0x229/0x1400 [drm]
> [    2.564411]  ? xas_store+0x52/0x5e0
> [    2.564416]  ? kmem_cache_alloc_trace+0x177/0x2c0
> [    2.564420]  __drm_fb_helper_initial_config_and_unlock+0x44/0x4e0 [drm=
_kms_helper]
> [    2.564430]  drm_fbdev_client_hotplug+0x173/0x210 [drm_kms_helper]
> [    2.564438]  drm_fbdev_generic_setup+0xa5/0x166 [drm_kms_helper]
> [    2.564446]  amdgpu_pci_probe+0x35e/0x370 [amdgpu]
> [    2.564621]  local_pci_probe+0x45/0x80
> [    2.564625]  ? pci_match_device+0xd7/0x130
> [    2.564627]  pci_device_probe+0xbf/0x220
> [    2.564629]  ? sysfs_do_create_link_sd+0x69/0xd0
> [    2.564633]  really_probe+0x19c/0x380
> [    2.564637]  __driver_probe_device+0xfe/0x180
> [    2.564639]  driver_probe_device+0x1e/0x90
> [    2.564641]  __driver_attach+0xc0/0x1c0
> [    2.564643]  ? __device_attach_driver+0xe0/0xe0
> [    2.564644]  ? __device_attach_driver+0xe0/0xe0
> [    2.564646]  bus_for_each_dev+0x78/0xc0
> [    2.564648]  bus_add_driver+0x149/0x1e0
> [    2.564650]  driver_register+0x8f/0xe0
> [    2.564652]  ? 0xffffffffc1023000
> [    2.564654]  do_one_initcall+0x44/0x200
> [    2.564657]  ? kmem_cache_alloc_trace+0x177/0x2c0
> [    2.564659]  do_init_module+0x4c/0x250
> [    2.564663]  __do_sys_init_module+0x12e/0x1b0
> [    2.564666]  do_syscall_64+0x3b/0x90
> [    2.564670]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [    2.564673] RIP: 0033:0x7fc69bff232e
> [    2.564674] Code: 48 8b 0d 45 0b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 6=
6 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 12 0b 0c 00 f7 d8 64 89 01 48
> [    2.564676] RSP: 002b:00007ffe872ba3e8 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000000af
> [    2.564677] RAX: ffffffffffffffda RBX: 000055873f797820 RCX: 00007fc69=
bff232e
> [    2.564678] RDX: 000055873f7bf390 RSI: 0000000001155e81 RDI: 00007fc69=
9e4d010
> [    2.564679] RBP: 00007fc699e4d010 R08: 000055873f7bfe20 R09: 000000000=
1155e90
> [    2.564680] R10: 000000055873f7bf R11: 0000000000000246 R12: 000055873=
f7bf390
> [    2.564681] R13: 000000000000000d R14: 000055873f7c4cb0 R15: 000055873=
f797820
> [    2.564683]  </TASK>
> [    2.564683] ---[ end trace 0000000000000000 ]---
> [    2.564696] ------------[ cut here ]------------
> [    2.564696] WARNING: CPU: 6 PID: 325 at drivers/gpu/drm/drm_mode_objec=
t.c:242 drm_object_attach_property+0x52/0x80 [drm]
> [    2.564717] Modules linked in: btusb btrtl btbcm btintel btmtk bluetoo=
th rfkill ecdh_generic ecc usbhid crc16 amdgpu(+) drm_ttm_helper ttm agpgar=
t gpu_sched i2c_algo_bit drm_display_helper drm_kms_helper syscopyarea sysf=
illrect sysimgblt fb_sys_fops drm serio_raw sdhci_pci atkbd libps2 cqhci vi=
valdi_fmap ccp sdhci i8042 crct10dif_pclmul crc32_pclmul hid_multitouch gha=
sh_clmulni_intel aesni_intel crypto_simd cryptd wdat_wdt mmc_core cec xhci_=
pci sp5100_tco rng_core xhci_pci_renesas serio 8250_dw i2c_hid_acpi i2c_hid=
 btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel xor raid6_pq d=
m_mirror dm_region_hash dm_log dm_mod pkcs8_key_parser crypto_user
> [    2.564738] CPU: 6 PID: 325 Comm: systemd-udevd Tainted: G        W   =
      5.18.0-amd-staging-drm-next+ #67
> [    2.564740] Hardware name: Valve Jupiter/Jupiter, BIOS F7A0105 03/21/2=
022
> [    2.564741] RIP: 0010:drm_object_attach_property+0x52/0x80 [drm]
> [    2.564759] Code: 2d 83 f8 18 74 33 48 89 74 c1 08 48 8b 4f 08 48 89 9=
4 c1 c8 00 00 00 48 8b 47 08 83 00 01 c3 4d 85 d2 75 dd 83 7f 58 01 75 d7 <=
0f> 0b eb d3 41 80 78 50 00 74 cc 0f 0b eb c8 44 89 ce 48 c7 c7 28
> [    2.564760] RSP: 0018:ffffb2e8804138d8 EFLAGS: 00010246
> [    2.564761] RAX: 0000000000000010 RBX: ffff99508c1a2000 RCX: ffff99508=
c1a2180
> [    2.564762] RDX: 0000000000000003 RSI: ffff99508c050100 RDI: ffff99508=
c1a2040
> [    2.564763] RBP: 00000000ffffffff R08: ffff99508a860010 R09: 00000000c=
0c0c0c0
> [    2.564763] R10: 0000000000000000 R11: 0000000000000020 R12: ffff99508=
a860010
> [    2.564764] R13: ffff995088733008 R14: ffff99508c1a2000 R15: ffffffffc=
068a47f
> [    2.564765] FS:  00007fc69b5f1a40(0000) GS:ffff9953aff80000(0000) knlG=
S:0000000000000000
> [    2.564766] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.564767] CR2: 00007f9506804000 CR3: 0000000107f92000 CR4: 000000000=
0350ee0
> [    2.564768] Call Trace:
> [    2.564769]  <TASK>
> [    2.564770]  drm_connector_set_panel_orientation_with_quirk+0x4a/0xc0 =
[drm]
> [    2.564789]  get_modes+0x4fb/0x530 [amdgpu]
> [    2.565024]  drm_helper_probe_single_connector_modes+0x1ad/0x850 [drm_=
kms_helper]
> [    2.565036]  drm_client_modeset_probe+0x229/0x1400 [drm]
> [    2.565056]  ? xas_store+0x52/0x5e0
> [    2.565060]  ? kmem_cache_alloc_trace+0x177/0x2c0
> [    2.565062]  __drm_fb_helper_initial_config_and_unlock+0x44/0x4e0 [drm=
_kms_helper]
> [    2.565072]  drm_fbdev_client_hotplug+0x173/0x210 [drm_kms_helper]
> [    2.565080]  drm_fbdev_generic_setup+0xa5/0x166 [drm_kms_helper]
> [    2.565088]  amdgpu_pci_probe+0x35e/0x370 [amdgpu]
> [    2.565261]  local_pci_probe+0x45/0x80
> [    2.565263]  ? pci_match_device+0xd7/0x130
> [    2.565265]  pci_device_probe+0xbf/0x220
> [    2.565267]  ? sysfs_do_create_link_sd+0x69/0xd0
> [    2.565268]  really_probe+0x19c/0x380
> [    2.565270]  __driver_probe_device+0xfe/0x180
> [    2.565272]  driver_probe_device+0x1e/0x90
> [    2.565274]  __driver_attach+0xc0/0x1c0
> [    2.565276]  ? __device_attach_driver+0xe0/0xe0
> [    2.565278]  ? __device_attach_driver+0xe0/0xe0
> [    2.565279]  bus_for_each_dev+0x78/0xc0
> [    2.565281]  bus_add_driver+0x149/0x1e0
> [    2.565283]  driver_register+0x8f/0xe0
> [    2.565285]  ? 0xffffffffc1023000
> [    2.565286]  do_one_initcall+0x44/0x200
> [    2.565288]  ? kmem_cache_alloc_trace+0x177/0x2c0
> [    2.565290]  do_init_module+0x4c/0x250
> [    2.565291]  __do_sys_init_module+0x12e/0x1b0
> [    2.565294]  do_syscall_64+0x3b/0x90
> [    2.565296]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [    2.565297] RIP: 0033:0x7fc69bff232e
> [    2.565298] Code: 48 8b 0d 45 0b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 6=
6 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 12 0b 0c 00 f7 d8 64 89 01 48
> [    2.565299] RSP: 002b:00007ffe872ba3e8 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000000af
> [    2.565301] RAX: ffffffffffffffda RBX: 000055873f797820 RCX: 00007fc69=
bff232e
> [    2.565302] RDX: 000055873f7bf390 RSI: 0000000001155e81 RDI: 00007fc69=
9e4d010
> [    2.565303] RBP: 00007fc699e4d010 R08: 000055873f7bfe20 R09: 000000000=
1155e90
> [    2.565303] R10: 000000055873f7bf R11: 0000000000000246 R12: 000055873=
f7bf390
> [    2.565304] R13: 000000000000000d R14: 000055873f7c4cb0 R15: 000055873=
f797820
> [    2.565306]  </TASK>
> [    2.565307] ---[ end trace 0000000000000000 ]---
>=20
> Fixes: d77de7880e0e0 ("amd/display: enable panel orientation quirks")
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0d54c1486739..c2806695589a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4133,6 +4133,7 @@ static void register_backlight_device(struct amdgpu=
_display_manager *dm,
>  	}
>  }
> =20
> +static void amdgpu_set_panel_orientation(struct amdgpu_dm_connector *aco=
nnector);
> =20
>  /*
>   * In this architecture, the association
> @@ -4324,6 +4325,7 @@ static int amdgpu_dm_initialize_drm_device(struct a=
mdgpu_device *adev)
>  					adev_to_drm(adev)->vblank_disable_immediate =3D false;
>  			}
>  		}
> +		amdgpu_set_panel_orientation(aconnector);
>  	}
> =20
>  	/* Software is initialized. Now we can register interrupt handlers. */
> @@ -6672,16 +6674,28 @@ static void amdgpu_dm_connector_add_common_modes(=
struct drm_encoder *encoder,
>  	}
>  }
> =20
> -static void amdgpu_set_panel_orientation(struct drm_connector *connector)
> +static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *conn=
ector,
> +					      struct edid *edid);
> +
> +static void amdgpu_set_panel_orientation(struct amdgpu_dm_connector *aco=
nnector)
>  {
>  	struct drm_encoder *encoder;
> +	struct drm_connector *connector =3D &aconnector->base;
>  	struct amdgpu_encoder *amdgpu_encoder;
>  	const struct drm_display_mode *native_mode;
> +	struct edid *edid =3D aconnector->edid;
> =20
>  	if (connector->connector_type !=3D DRM_MODE_CONNECTOR_eDP &&
>  	    connector->connector_type !=3D DRM_MODE_CONNECTOR_LVDS)
>  		return;
> =20
> +	if (!drm_edid_is_valid(edid))
> +		return;
> +
> +	mutex_lock(&connector->dev->mode_config.mutex);
> +	amdgpu_dm_connector_ddc_get_modes(connector, edid);
> +	mutex_unlock(&connector->dev->mode_config.mutex);
> +
>  	encoder =3D amdgpu_dm_connector_to_encoder(connector);
>  	if (!encoder)
>  		return;
> @@ -6726,8 +6740,6 @@ static void amdgpu_dm_connector_ddc_get_modes(struc=
t drm_connector *connector,
>  		 * restored here.
>  		 */
>  		amdgpu_dm_update_freesync_caps(connector, edid);
> -
> -		amdgpu_set_panel_orientation(connector);
>  	} else {
>  		amdgpu_dm_connector->num_modes =3D 0;
>  	}
> --=20
> 2.35.1
>=20

--se7qec4jvcwmn7c5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmLqonUACgkQwqF3j0dL
ehy8vxAAg6imursN9x0tqxP0X49Wq0sNtCJJqOoJQxHwgtKx39QxLuy2ZyAG74El
dtb8CWR1bwZ+r848lSmNMiOQ7pPjZf3gAyMjpkK05x6jarnX5wc3wuPGt/VSw5MS
KSzYC5aDih6UqKm/txaMYEKRXL48HMDozHkbKyJQdOAoFsS8IsNus2vhvgy/Pif2
FbhaPEkSv/kOtb7RL/4rj9A9kLUPndPrTJk895stu4Gnsw/lpUsnuXNhG4o+TwW2
tnlkxxEKqn+eM3b4RaRurZSu/T1NccyrSYhbNjgfZzGBuTKvZnFgn+yq9MF0QI2H
3jf8RtCyj8DOQjoXhIgICliZf3eKrI/IOuCsiLACy7C+SQwH5q7hishINKHmXhcf
651ClMdIuhGOSPN105rE5G3lYWofTGvOk+y4ON3YyqXwVCfPUVr4h0bfQCTJNGCO
XI3vvz+PlzBcYgO9EHB0IwA9c3/EMz2U5Al4kODk/5yW4js4OnxlMZW63hQGG7Gj
SiuEXGIrYWA+bKHs+ZcW9iKtDZi3dLb9uIbiReRQh0/zNVw2WKqoxZjr/OG+IybP
VDmZnS5EYLHetBfBiGDm2vswcdSkE27+8A3ndziCqDkmwZYFvg6OPcRP2DPYlMNY
4W83+xmk1lImMV8qxY1EkRt+gxG8x6uiDatmc3HtfiSr0REV/jM=
=iu7W
-----END PGP SIGNATURE-----

--se7qec4jvcwmn7c5--
