Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11B5C00140
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Aug 2022 16:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C08668ECA1;
	Wed, 10 Aug 2022 16:22:17 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBE1C93591
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 16:22:04 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id c185so18278048oia.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 09:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=Vri+vqXXIjhtSuvkJU2tesD0pFAkOgIY/FIBad5Tr0c=;
 b=pDKEXyVxTpSH7I5ME1AUXhvqN3LLA9/LBL8Jr3niQsuAPUrNMrt+UY3BdITSVHzneB
 IaBNxR/tcW8OyOEuocHRGmhzo7YaEDgRST3g2j049YVhR2St9Shjg7s6peqrvx7Nd4c7
 w4tpJ11Os090e8ij0/ufwGb5y9VIwG2zqKeYth0WgvcA95b7Vmd3YaYDPmr61OKNZGiH
 v0nv0dvU3t4JjYwu5+5DfZkcwwZv0UjgWBK0tOBPleuC2FpjieiorHFVhF7pdnd1WYzP
 FDByJVA5AD2MwOpSm+yh57g3usW+C1lxaewjUMS1jDgLkN8qwOjieu/W8Y+RmSGhFGiM
 uwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=Vri+vqXXIjhtSuvkJU2tesD0pFAkOgIY/FIBad5Tr0c=;
 b=FqBTMCcRML8Be9AWdFOW8p6rRmXW/CsdJ2ySFJcoIF973xUZ916c9i9jDYn3B3flif
 hve20+dmRXnv4mk0SlEhXRTJoWWWZ4lx+oDdvvq8nQ6FWnbeHH/4dUMqUNh+8W8Jkx7t
 xjdA4ZycdlQCNvy/Wodp1WTdMmLkSWuB5B1+JvhKONUC+dKuymjqub8nA4W16qd8TrHi
 C32CHJA+cyP/A4Brb4Dpmr4maq8ty0uV4SnuuHlhCrOfXKJuMVXkfY5ATez2fwcyWbOT
 NoUpoG8BVE5XQ9Ayb4kiG8PmP5XlpMumxBaML/UzyXyZBsi3CTJygetTxuiucO50j/nC
 McVA==
X-Gm-Message-State: ACgBeo1VI8KivCPh0PiUU9jiZ8FbpSxTcGDEXOTWpF9qj5P3JDEcPA4D
 xv9iq0OsuC2Le9vTOKcsc/LjQaB3DSNGqSI880U=
X-Google-Smtp-Source: AA6agR5WciyojStiYS14Fvm3Yv5JCto7JLk2dlsTCUJWY8d9FmIWBJ+HzvqwwyCbXBsxrjQOJNx+w0T1wQOAF1qILvo=
X-Received: by 2002:a05:6808:ecb:b0:33a:3b54:37f9 with SMTP id
 q11-20020a0568080ecb00b0033a3b5437f9mr1687267oiv.33.1660148523957; Wed, 10
 Aug 2022 09:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220804161349.3561177-1-mwen@igalia.com>
In-Reply-To: <20220804161349.3561177-1-mwen@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Aug 2022 12:21:52 -0400
Message-ID: <CADnq5_NSWpsg75gmmGM6y9rnf=TX=VFKVPx=ZnnJD9JRm-7F=A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: set panel orientation before
 drm_dev_register
To: Melissa Wen <mwen@igalia.com>
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
Cc: Leo Li <sunpeng.li@amd.com>, Xinhui.Pan@amd.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 nikola.cornij@amd.com, kernel-dev@igalia.com,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, christian.koenig@amd.com,
 sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Aug 4, 2022 at 12:14 PM Melissa Wen <mwen@igalia.com> wrote:
>
> To set the panel orientation property with quirk, we need the mode size
> provided by EDID. This info is available after EDID is read by dc_link_de=
tect()
> and updated by amdgpu_dm_update_connector_after_detect(). The detection
> happens at driver load in amdgpu_dm_initialize_drm_device() and,
> therefore, we can get modes and set panel orientation before
> drm_dev_register() to avoid DRM warns on creating the connector property
> after device registration:
>
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
>
> --
>
> v2:
> - call amdgpu_dm_connector_get_modes() instead of ddc_get_modes() (Harry)
>
> Fixes: d77de7880e0e0 ("amd/display: enable panel orientation quirks")
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0d54c1486739..2de37b976c23 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4133,6 +4133,7 @@ static void register_backlight_device(struct amdgpu=
_display_manager *dm,
>         }
>  }
>
> +static void amdgpu_set_panel_orientation(struct drm_connector *connector=
);
>
>  /*
>   * In this architecture, the association
> @@ -4324,6 +4325,7 @@ static int amdgpu_dm_initialize_drm_device(struct a=
mdgpu_device *adev)
>                                         adev_to_drm(adev)->vblank_disable=
_immediate =3D false;
>                         }
>                 }
> +               amdgpu_set_panel_orientation(&aconnector->base);
>         }
>
>         /* Software is initialized. Now we can register interrupt handler=
s. */
> @@ -6682,6 +6684,10 @@ static void amdgpu_set_panel_orientation(struct dr=
m_connector *connector)
>             connector->connector_type !=3D DRM_MODE_CONNECTOR_LVDS)
>                 return;
>
> +       mutex_lock(&connector->dev->mode_config.mutex);
> +       amdgpu_dm_connector_get_modes(connector);
> +       mutex_unlock(&connector->dev->mode_config.mutex);
> +
>         encoder =3D amdgpu_dm_connector_to_encoder(connector);
>         if (!encoder)
>                 return;
> @@ -6726,8 +6732,6 @@ static void amdgpu_dm_connector_ddc_get_modes(struc=
t drm_connector *connector,
>                  * restored here.
>                  */
>                 amdgpu_dm_update_freesync_caps(connector, edid);
> -
> -               amdgpu_set_panel_orientation(connector);
>         } else {
>                 amdgpu_dm_connector->num_modes =3D 0;
>         }
> --
> 2.35.1
>
