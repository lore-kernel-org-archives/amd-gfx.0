Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3562C47071
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 19:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 765F610E688;
	Thu, 16 Nov 2023 19:22:26 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 452A710E688
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 19:22:25 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6ce344fa7e4so708926a34.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 11:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700162544; x=1700767344; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f0NEBnxT0zH1fyqhPMvfZhKfXi3QJ09/jFO0DQHIcT0=;
 b=GclbYPUAziHEqos53pkWH388E1BS9V8HrflWivwjeU6TMd7nbxr8vvUeHCO2g6fs0w
 g467XpAp3K2hi7+KDCPMSpvrvRUHwHOQ94vrGB4TLORnnISiu/BPUr0QtiXHukPx3vYW
 qpBVo9y2rld4WflovJIc+fz/+rmJozqcUNWk0uhFQl6xdYEMAIL7ODfWAFZ0NR3loWJS
 ViUfmSqq3fY+mzNEqOf5yPik16nwDvOeeq3ZBs2FiLqg/bS3g2lInedPnPP6RujLd9oZ
 9wt4fVkZ2LRpcKK4zvHHeBHMhd6IKg9Ni6xpeH/wwp3nvDnGSuHA9zxEfeCx6oKFkFN2
 Wwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700162544; x=1700767344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f0NEBnxT0zH1fyqhPMvfZhKfXi3QJ09/jFO0DQHIcT0=;
 b=JpQDBggH5ZmqlrDRriZ3ZX8Gtc/h9TuTnj7sfYoz8IXxQl8wirpwTeMulp12wXIGLp
 w0Mnk6oMHTqs6s3W6SDLjVLLXU6T4b6KDyxQWKmZ62X0hfaAF/OJqaK2vRt/oqWbz/hY
 kKymJQJmOMhBqtjOuZ1Cz5d/9CM/gpDA/CpxrLXGR/7lnGR9USBGH0StFYoc8z66WNGm
 WdP3MuF3OCLLetefCbo+rRFDpkqKNUNjaTJoplI5L6uJNE87HsS1GyKtJGaEqpa3DWtM
 14TOFCA9aIDqhycwPwJzrtf1IILKnwGSr24m976rdV705w2lCzSVBovCE5rGUd0s+sV/
 7q2g==
X-Gm-Message-State: AOJu0Yz1G2FdsMm+5oGHYYOWPPGXwcINNbU0LyORMIaSmOcz0bMlcdMe
 vxlSl8uGId/b8Vwh2jMV1CkYrmM8ybOwzPuBWMQ2VN2T
X-Google-Smtp-Source: AGHT+IHcHlH3hIBllLw22iddjpaDT+pHeqpIL8lx026dQxbHFyh041f3QjHX0mblKHSBtxFMuS7xAedx6IET0sJK8BY=
X-Received: by 2002:a05:6870:6c07:b0:1ba:bb13:d007 with SMTP id
 na7-20020a0568706c0700b001babb13d007mr20806442oab.5.1700162544314; Thu, 16
 Nov 2023 11:22:24 -0800 (PST)
MIME-Version: 1.0
References: <20231115214029.960838-1-ivlipski@amd.com>
 <CADnq5_MU3qcH_wMxkL257+cWmWB25qgXGuH8jX7GgWUXRa2m-g@mail.gmail.com>
 <12f135d1-3924-4053-8c22-3e68ffdfc08b@amd.com>
In-Reply-To: <12f135d1-3924-4053-8c22-3e68ffdfc08b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Nov 2023 14:22:13 -0500
Message-ID: <CADnq5_MK8uApCwvpPmqBK2oKDqYv8Oeh3=38GDv9izqgqT9=MA@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: fix AGP init order"
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: ivlipski@amd.com, kenny.ho@amd.com, rodrigo.siqueira@amd.com,
 amd-gfx@lists.freedesktop.org, aurabindo.pillai@amd.com, nicholas.choi@amd.com,
 hamza.mahfooz@amd.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 16, 2023 at 2:02=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 11/16/2023 09:00, Alex Deucher wrote:
> > This will break other things.  The proper fix is either:
> > https://patchwork.freedesktop.org/patch/567101/

Drop this patch.

Alex

> > and/or:
> > https://patchwork.freedesktop.org/series/126220/
> >
>
> I applied the both of these series on 6.7-rc1
>
> e5e258131973 (HEAD) drm/amdgpu/gmc9: disable AGP aperture
> 88c7088cb01e drm/amdgpu/gmc10: disable AGP aperture
> 873787b04834 drm/amdgpu/gmc11: disable AGP aperture
> 9a33a54eb5dd drm/amdgpu: add a module parameter to control the AGP apertu=
re
> fdc3daa185e5 drm/amdgpu/gmc11: fix logic typo in AGP check
> 8a51f3ea4ed3 drm/amdgpu: fix AGP addressing when GART is not at 0
> b85ea95d0864 (tag: v6.7-rc1, origin/master, origin/HEAD, master) Linux
> 6.7-rc1
>
> But I end up with a NULL pointer dereference on a Phoenix system during
> bootup:
>
> [   28.980823] [drm] GART: num cpu pages 131072, num gpu pages 131072
> [   28.980846] BUG: kernel NULL pointer dereference, address:
> 000000000000000c
> [   28.981424] #PF: supervisor read access in kernel mode
> [   28.981849] #PF: error_code(0x0000) - not-present page
> [   28.982259] PGD 0 P4D 0
> [   28.982469] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   28.982817] CPU: 10 PID: 547 Comm: (udev-worker) Not tainted
> 6.7.0-rc1-00006-ge5e258131973 #175
> [   28.984060] RIP: 0010:amdgpu_gmc_agp_addr+0x16/0x60 [amdgpu]
> [   28.984828] Code: 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90
> 90 90 90 0f 1f 44 00 00 48 8b 87 88 01 00 00 49 b8 ff ff ff ff ff ff ff
> 7f <83> 78 0c 01 75 2e 83 78 28 02 74 28 48 8b 40 18 48 8b 97 60 01 00
> [   28.984829] RSP: 0018:ffffc90000ff7998 EFLAGS: 00010282
> [   28.984831] RAX: 0000000000000000 RBX: ffff888103f83800 RCX:
> 0000000000000000
> [   28.984832] RDX: 7fffffffffffffff RSI: ffff888103f83858 RDI:
> ffff888103f83858
> [   28.984832] RBP: ffff888102f0f020 R08: 7fffffffffffffff R09:
> 0000000000000000
> [   28.984833] R10: 0000000000001000 R11: 0000000000001000 R12:
> ffff888103f83800
> [   28.984834] R13: ffff888102f0fdf8 R14: ffff888102f0fe00 R15:
> 0000000000000000
> [   28.984835] FS:  00007fe6aa26a8c0(0000) GS:ffff88844e880000(0000)
> knlGS:0000000000000000
> [   28.984836] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   28.984837] CR2: 000000000000000c CR3: 000000011556e000 CR4:
> 0000000000750ef0
> [   28.984838] PKRU: 55555554
> [   28.984839] Call Trace:
> [   28.984842]  <TASK>
> [   28.984845]  ? __die+0x20/0x70
> [   28.984850]  ? page_fault_oops+0x151/0x4b0
> [   28.984854]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   28.992663]  ? do_user_addr_fault+0x65/0x6b0
> [   28.992672]  ? exc_page_fault+0x74/0x170
> [   28.992676]  ? asm_exc_page_fault+0x22/0x30
> [   28.993714]  ? amdgpu_gmc_agp_addr+0x16/0x60 [amdgpu]
> [   28.994455]  amdgpu_bo_gpu_offset_no_check+0x1a/0x70 [amdgpu]
> [   28.995110]  amdgpu_bo_create_reserved.part.0+0x109/0x290 [amdgpu]
> [   28.995786]  ? __pfx_amdgpu_bo_destroy+0x10/0x10 [amdgpu]
> [   28.996400]  amdgpu_bo_create_kernel+0x3f/0xa0 [amdgpu]
> [   28.996992]  amdgpu_device_init+0x15fa/0x2b60 [amdgpu]
> [   28.997591]  ? pci_bus_read_config_word+0x46/0x80
> [   28.997598]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   28.998385]  ? do_pci_enable_device+0xd4/0x100
> [   28.998390]  amdgpu_driver_load_kms+0x15/0x190 [amdgpu]
> [   28.999194]  amdgpu_pci_probe+0x180/0x570 [amdgpu]
> [   28.999781]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   29.000232]  local_pci_probe+0x43/0xa0
> [   29.000552]  pci_device_probe+0xc5/0x270
> [   29.000883]  really_probe+0x1b4/0x420
> [   29.001194]  __driver_probe_device+0x84/0x170
> [   29.001558]  driver_probe_device+0x1e/0xb0
> [   29.001901]  __driver_attach+0xe5/0x1f0
> [   29.002224]  ? __pfx___driver_attach+0x10/0x10
> [   29.002594]  bus_for_each_dev+0x75/0xd0
> [   29.002919]  bus_add_driver+0x112/0x220
> [   29.003243]  driver_register+0x5c/0x120
> [   29.003569]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
> [   29.004148]  do_one_initcall+0x41/0x300
> [   29.004471]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   29.004876]  ? kmalloc_trace+0x25/0x90
> [   29.005197]  do_init_module+0x64/0x250
> [   29.005201]  init_module_from_file+0x8b/0xd0
> [   29.005207]  idempotent_init_module+0x181/0x240
> [   29.006235]  __x64_sys_finit_module+0x5a/0xb0
> [   29.006238]  do_syscall_64+0x5c/0xe0
> [   29.006868]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   29.006870]  ? syscall_exit_to_user_mode+0x27/0x40
> [   29.006872]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   29.008000]  ? do_syscall_64+0x6b/0xe0
> [   29.008004]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [   29.008703] RIP: 0033:0x7fe6aa125c7d
> [   29.008991] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa
> 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b 81 0d 00 f7 d8 64 89 01 48
> [   29.008993] RSP: 002b:00007ffe22be7618 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000139
> [   29.010434] RAX: ffffffffffffffda RBX: 000055b2f8dee0f0 RCX:
> 00007fe6aa125c7d
> [   29.010435] RDX: 0000000000000000 RSI: 00007fe6aa33544a RDI:
> 0000000000000017
> [   29.010436] RBP: 00007fe6aa33544a R08: 0000000000000040 R09:
> fffffffffffffde0
> [   29.010438] R10: fffffffffffffe18 R11: 0000000000000246 R12:
> 0000000000020000
> [   29.010439] R13: 000055b2f8f12ba0 R14: 0000000000000000 R15:
> 000055b2f8f49ef0
> [   29.010443]  </TASK>
> [   29.010444] Modules linked in: binfmt_misc squashfs vfat fat
> snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common amdgpu(+)
> snd_soc_dmic snd_ps_pdm_dma snd_soc_ps_mach snd_hda_intel
> snd_intel_dspcfg snd_soc_core snd_hda_codec snd_compress ac97_bus
> snd_pcm_dmaengine snd_hda_core snd_seq_dummy uvcvideo snd_hwdep uvc
> hid_sensor_magn_3d hid_sensor_gyro_3d snd_seq_oss videobuf2_vmalloc
> snd_pci_ps hid_sensor_trigger videobuf2_memops hid_sensor_iio_common
> snd_seq_midi snd_rpl_pci_acp6x snd_seq_midi_event
> industrialio_triggered_buffer kfifo_buf videobuf2_v4l2 snd_acp_pci
> edac_mce_amd industrialio crct10dif_pclmul videobuf2_common snd_rawmidi
> snd_acp_legacy_common polyval_clmulni amdxcp gpu_sched polyval_generic
> snd_pci_acp6x joydev i2c_algo_bit videodev drm_suballoc_helper
> drm_ttm_helper snd_seq snd_pcm ghash_clmulni_intel ttm sha512_ssse3
> snd_seq_device drm_exec sha256_ssse3 mc snd_timer snd_pci_acp5x
> drm_display_helper sha1_ssse3 snd_rn_pci_acp3x snd_acp_config wmi_bmof
> snd rapl cec snd_soc_acpi drm_buddy soundcore i2c_piix4
> [   29.014048]  snd_pci_acp3x k10temp amd_pmf platform_profile
> hid_sensor_hub amd_pmc hid_multitouch serio_raw kvm_amd ccp kvm
> irqbypass iptable_filter ip6table_filter ip6_tables br_netfilter bridge
> stp llc arp_tables parport_pc ppdev lp parport loop fuse ip_tables
> rtsx_pci_sdmmc mmc_core video nvme crc32_pclmul crc32c_intel thunderbolt
> nvme_core amd_sfh r8169 rtsx_pci wmi i2c_hid_acpi i2c_hid
> [   29.023590] CR2: 000000000000000c
> [   29.023856] ---[ end trace 0000000000000000 ]---
> [   29.024220] RIP: 0010:amdgpu_gmc_agp_addr+0x16/0x60 [amdgpu]
> [   29.024886] Code: 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90
> 90 90 90 0f 1f 44 00 00 48 8b 87 88 01 00 00 49 b8 ff ff ff ff ff ff ff
> 7f <83> 78 0c 01 75 2e 83 78 28 02 74 28 48 8b 40 18 48 8b 97 60 01 00
> [   29.026324] RSP: 0018:ffffc90000ff7998 EFLAGS: 00010282
> [   29.026737] RAX: 0000000000000000 RBX: ffff888103f83800 RCX:
> 0000000000000000
> [   29.027290] RDX: 7fffffffffffffff RSI: ffff888103f83858 RDI:
> ffff888103f83858
> [   29.027848] RBP: ffff888102f0f020 R08: 7fffffffffffffff R09:
> 0000000000000000
> [   29.028401] R10: 0000000000001000 R11: 0000000000001000 R12:
> ffff888103f83800
> [   29.028960] R13: ffff888102f0fdf8 R14: ffff888102f0fe00 R15:
> 0000000000000000
> [   29.029521] FS:  00007fe6aa26a8c0(0000) GS:ffff88844e880000(0000)
> knlGS:0000000000000000
> [   29.030147] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   29.030600] CR2: 000000000000000c CR3: 000000011556e000 CR4:
> 0000000000750ef0
>
> > Alex
> >
> > On Thu, Nov 16, 2023 at 7:27=E2=80=AFAM <ivlipski@amd.com> wrote:
> >>
> >> From: Ivan Lipski <ivlipski@amd.com>
> >>
> >> This commit caused a page fault issue on RX7000 series GPU.
> >> It would occur when running different IGT tests, including
> >> kms_properties*
> >> kms_cursor_legacy*
> >> kms_prop_blob@blob*
> >>
> >> It would also occur on desttop after some time of idling.
> >>
> >> The easiest fix for it seems to revert it.
> >>
> >> This reverts commit b93ed51c32caad2b96cbc8e4754802078ede87ab.
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 +++
> >>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 1 -
> >>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 1 -
> >>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      | 1 -
> >>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 1 -
> >>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 1 -
> >>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 2 --
> >>   7 files changed, 3 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_object.c
> >> index cef920a93924..0dcb6c36b02c 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >> @@ -1062,6 +1062,9 @@ static const char * const amdgpu_vram_names[] =
=3D {
> >>    */
> >>   int amdgpu_bo_init(struct amdgpu_device *adev)
> >>   {
> >> +       /* set the default AGP aperture state */
> >> +       amdgpu_gmc_set_agp_default(adev, &adev->gmc);
> >> +
> >>          /* On A+A platform, VRAM can be mapped as WB */
> >>          if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu=
) {
> >>                  /* reserve PAT memory space to WC for VRAM */
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/=
amd/amdgpu/gmc_v10_0.c
> >> index 0ec7b061d7c2..a43d1aa42e11 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> >> @@ -672,7 +672,6 @@ static void gmc_v10_0_vram_gtt_location(struct amd=
gpu_device *adev,
> >>          /* add the xgmi offset of the physical node */
> >>          base +=3D adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.no=
de_segment_size;
> >>
> >> -       amdgpu_gmc_set_agp_default(adev, mc);
> >>          amdgpu_gmc_vram_location(adev, &adev->gmc, base);
> >>          amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST=
_FIT);
> >>          if (!amdgpu_sriov_vf(adev))
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/=
amd/amdgpu/gmc_v11_0.c
> >> index ba4c82f5e617..ee7f3f8c1b4a 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> >> @@ -637,7 +637,6 @@ static void gmc_v11_0_vram_gtt_location(struct amd=
gpu_device *adev,
> >>
> >>          base =3D adev->mmhub.funcs->get_fb_location(adev);
> >>
> >> -       amdgpu_gmc_set_agp_default(adev, mc);
> >>          amdgpu_gmc_vram_location(adev, &adev->gmc, base);
> >>          amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_HIGH=
);
> >>          if (!amdgpu_sriov_vf(adev) &&
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v6_0.c
> >> index 42e103d7077d..7f66954fd302 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> >> @@ -211,7 +211,6 @@ static void gmc_v6_0_vram_gtt_location(struct amdg=
pu_device *adev,
> >>
> >>          base <<=3D 24;
> >>
> >> -       amdgpu_gmc_set_agp_default(adev, mc);
> >>          amdgpu_gmc_vram_location(adev, mc, base);
> >>          amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST=
_FIT);
> >>   }
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v7_0.c
> >> index efc16e580f1e..61ca1a82b651 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> >> @@ -239,7 +239,6 @@ static void gmc_v7_0_vram_gtt_location(struct amdg=
pu_device *adev,
> >>
> >>          base <<=3D 24;
> >>
> >> -       amdgpu_gmc_set_agp_default(adev, mc);
> >>          amdgpu_gmc_vram_location(adev, mc, base);
> >>          amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST=
_FIT);
> >>   }
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v8_0.c
> >> index ff4ae73d27ec..fa59749c2aef 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> >> @@ -413,7 +413,6 @@ static void gmc_v8_0_vram_gtt_location(struct amdg=
pu_device *adev,
> >>                  base =3D RREG32(mmMC_VM_FB_LOCATION) & 0xFFFF;
> >>          base <<=3D 24;
> >>
> >> -       amdgpu_gmc_set_agp_default(adev, mc);
> >>          amdgpu_gmc_vram_location(adev, mc, base);
> >>          amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST=
_FIT);
> >>   }
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v9_0.c
> >> index c1f2f166f064..83733156ee53 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> >> @@ -1621,8 +1621,6 @@ static void gmc_v9_0_vram_gtt_location(struct am=
dgpu_device *adev,
> >>   {
> >>          u64 base =3D adev->mmhub.funcs->get_fb_location(adev);
> >>
> >> -       amdgpu_gmc_set_agp_default(adev, mc);
> >> -
> >>          /* add the xgmi offset of the physical node */
> >>          base +=3D adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.no=
de_segment_size;
> >>          if (adev->gmc.xgmi.connected_to_cpu) {
> >> --
> >> 2.34.1
> >>
> >
>
