Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA9AC072A2
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 19:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93BAC10E768;
	Fri, 17 Nov 2023 19:24:55 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D23A10E768
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 19:24:53 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6cd09f51fe0so1430761a34.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 11:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700249092; x=1700853892; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/gotRRsyTJJKuqwX+KArYPHEOjC2QqFfMvoEk9DoD8=;
 b=lZW/tcRwohHxmR82AhPKRfW8LGMUwROcDAJ6Pa/ujSxQCVE7NPy1wTK+n8VdCy1ahc
 bal93WSsCyWU2/rPJNZ0cUSE1eMV82YZtmW5z8RdVavhqbB2l2Uz8m7gFYefvYDQ2+wT
 LUL22h09JlFhcTV91TQZmzOvElD0XZcWl9+OE3S4jFN5jauKqTcnZrw91Naoa2Bam99c
 QSUxI2BnKK5mHBwkkMJtCKCUBklMBS/PAuGJGR9idZqt/pgqY0crwrPyJJ45wE2sHDKE
 fyiwCTv0Ikul6fN5mUf8pA0YD/n1ONbEw8LErOYMCLEVemwNsxI+DUC28zfrljiYXFq6
 Iusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700249092; x=1700853892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/gotRRsyTJJKuqwX+KArYPHEOjC2QqFfMvoEk9DoD8=;
 b=MFkTHe07UvrZ62u+dKvxTd96Og9HauHxg/BJPbyAuNcmqKkUeEXvpuQP5l1LdyZZFn
 p+EDlDZahuOHrDe0k8W/Kr+0sQubZiDVafyiNT1kHD2lXj/JeI/txgBwDG3Kv6UWLGVa
 gg+1FjJF00UjwTIwkih0/+Hf4olRvJqlzzWIJF2TXLopmAiQ5M0QaGfGN1MIpi2yXItQ
 NLR8J+OYR7RXqKsg1XAbNYmPXA837lDMry6+f9REEamNZtJFbIFoPDvFfao0NXI89K93
 JVPmnngJCu0OWpUDRNdO3RKhzXfAe26BqIu09RKT074yhv4nsliuOmdjRr2W8U6O92eN
 PQSQ==
X-Gm-Message-State: AOJu0Yy/OI2p3XCkUoW3BJNLZrC2HdBUAUEfK5J/jU6AO4N3+VRjOWoV
 YgYakvIdtEZTUJDpRWVYoyv+oy0fWl9KaaoKyBLEix/pvwY=
X-Google-Smtp-Source: AGHT+IHtX8s7pMsq0hRuUVXwNw75rYlhufNfoduAeGQE30mqdN2IF/Po2ctOCYnsboUryCRhD6ulHxvclDoJN5Enucs=
X-Received: by 2002:a05:6870:e2d0:b0:1d6:5b09:1584 with SMTP id
 w16-20020a056870e2d000b001d65b091584mr175766oad.5.1700249092070; Fri, 17 Nov
 2023 11:24:52 -0800 (PST)
MIME-Version: 1.0
References: <20231110150206.1900871-1-alexander.deucher@amd.com>
 <95b9b67e-1a85-4de2-8c93-226075401c48@amd.com>
In-Reply-To: <95b9b67e-1a85-4de2-8c93-226075401c48@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Nov 2023 14:24:41 -0500
Message-ID: <CADnq5_P7EcNx=pZF6DGZ+_vtTOmXiXqe5VeUQRE5ytXYu5r3PA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix AGP addressing when GART is not at 0
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Nov 10, 2023 at 10:22=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 10.11.23 um 16:02 schrieb Alex Deucher:
> > This worked by luck if the GART aperture ended up at 0.  When
> > we ended up moving GART on some chips, the GART aperture ended
> > up offsetting the the AGP address since the resource->start is
> > a GART offset, not an MC address.  Fix this by moving the AGP
> > address setup into amdgpu_bo_gpu_offset_no_check().
> >
> > v2: check mem_type before checking agp
> >
> > Fixes: 67318cb84341 ("drm/amdgpu/gmc11: set gart placement GC11")
> > Reported-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > Reported-by: Yifan Zhang <yifan1.zhang@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: christian.koenig@amd.com
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Mario is getting a segfault with this patch on PHX.  Any ideas?  I
don't see how this could happen off hand.

[   28.980823] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   28.980846] BUG: kernel NULL pointer dereference, address:
000000000000000c
[   28.981424] #PF: supervisor read access in kernel mode
[   28.981849] #PF: error_code(0x0000) - not-present page
[   28.982259] PGD 0 P4D 0
[   28.982469] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   28.982817] CPU: 10 PID: 547 Comm: (udev-worker) Not tainted
6.7.0-rc1-00006-ge5e258131973 #175
[   28.984060] RIP: 0010:amdgpu_gmc_agp_addr+0x16/
0x60 [amdgpu]
[   28.984828] Code: 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90
90 90 90 0f 1f 44 00 00 48 8b 87 88 01 00 00 49 b8 ff ff ff ff ff ff ff
7f <83> 78 0c 01 75 2e 83 78 28 02 74 28 48 8b 40 18 48 8b 97 60 01 00
[   28.984829] RSP: 0018:ffffc90000ff7998 EFLAGS: 00010282
[   28.984831] RAX: 0000000000000000 RBX: ffff888103f83800 RCX:
0000000000000000
[   28.984832] RDX: 7fffffffffffffff RSI: ffff888103f83858 RDI:
ffff888103f83858
[   28.984832] RBP: ffff888102f0f020 R08: 7fffffffffffffff R09:
0000000000000000
[   28.984833] R10: 0000000000001000 R11: 0000000000001000 R12:
ffff888103f83800
[   28.984834] R13: ffff888102f0fdf8 R14: ffff888102f0fe00 R15:
0000000000000000
[   28.984835] FS:  00007fe6aa26a8c0(0000) GS:ffff88844e880000(0000)
knlGS:0000000000000000
[   28.984836] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.984837] CR2: 000000000000000c CR3: 000000011556e000 CR4:
0000000000750ef0
[   28.984838] PKRU: 55555554
[   28.984839] Call Trace:
[   28.984842]  <TASK>
[   28.984845]  ? __die+0x20/0x70
[   28.984850]  ? page_fault_oops+0x151/0x4b0
[   28.984854]  ? srso_alias_return_thunk+0x5/0xfbef5
[   28.992663]  ? do_user_addr_fault+0x65/0x6b0
[   28.992672]  ? exc_page_fault+0x74/0x170
[   28.992676]  ? asm_exc_page_fault+0x22/0x30
[   28.993714]  ? amdgpu_gmc_agp_addr+0x16/0x60 [amdgpu]
[   28.994455]  amdgpu_bo_gpu_offset_no_check+0x1a/0x70 [amdgpu]
[   28.995110]  amdgpu_bo_create_reserved.part.0+0x109/0x290 [amdgpu]
[   28.995786]  ? __pfx_amdgpu_bo_destroy+0x10/0x10 [amdgpu]
[   28.996400]  amdgpu_bo_create_kernel+0x3f/0xa0 [amdgpu]
[   28.996992]  amdgpu_device_init+0x15fa/0x2b60 [amdgpu]
[   28.997591]  ? pci_bus_read_config_word+0x46/0x80
[   28.997598]  ? srso_alias_return_thunk+0x5/0xfbef5
[   28.998385]  ? do_pci_enable_device+0xd4/0x100
[   28.998390]  amdgpu_driver_load_kms+0x15/0x190 [amdgpu]
[   28.999194]  amdgpu_pci_probe+0x180/0x570 [amdgpu]
[   28.999781]  ? srso_alias_return_thunk+0x5/0xfbef5
[   29.000232]  local_pci_probe+0x43/0xa0
[   29.000552]  pci_device_probe+0xc5/0x270
[   29.000883]  really_probe+0x1b4/0x420
[   29.001194]  __driver_probe_device+0x84/0x170
[   29.001558]  driver_probe_device+0x1e/0xb0
[   29.001901]  __driver_attach+0xe5/0x1f0
[   29.002224]  ? __pfx___driver_attach+0x10/0x10
[   29.002594]  bus_for_each_dev+0x75/0xd0
[   29.002919]  bus_add_driver+0x112/0x220
[   29.003243]  driver_register+0x5c/0x120
[   29.003569]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   29.004148]  do_one_initcall+0x41/0x300
[   29.004471]  ? srso_alias_return_thunk+0x5/0xfbef5
[   29.004876]  ? kmalloc_trace+0x25/0x90
[   29.005197]  do_init_module+0x64/0x250
[   29.005201]  init_module_from_file+0x8b/0xd0
[   29.005207]  idempotent_init_module+0x181/0x240
[   29.006235]  __x64_sys_finit_module+0x5a/0xb0
[   29.006238]  do_syscall_64+0x5c/0xe0
[   29.006868]  ? srso_alias_return_thunk+0x5/0xfbef5
[   29.006870]  ? syscall_exit_to_user_mode+0x27/0x40
[   29.006872]  ? srso_alias_return_thunk+0x5/0xfbef5
[   29.008000]  ? do_syscall_64+0x6b/0xe0
[   29.008004]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[   29.008703] RIP: 0033:0x7fe6aa125c7d
[   29.008991] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b 81 0d 00 f7 d8 64 89 01 48
[   29.008993] RSP: 002b:00007ffe22be7618 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[   29.010434] RAX: ffffffffffffffda RBX: 000055b2f8dee0f0 RCX:
00007fe6aa125c7d
[   29.010435] RDX: 0000000000000000 RSI: 00007fe6aa33544a RDI:
0000000000000017
[   29.010436] RBP: 00007fe6aa33544a R08: 0000000000000040 R09:
fffffffffffffde0
[   29.010438] R10: fffffffffffffe18 R11: 0000000000000246 R12:
0000000000020000
[   29.010439] R13: 000055b2f8f12ba0 R14: 0000000000000000 R15:
000055b2f8f49ef0
[   29.010443]  </TASK>
[   29.010444] Modules linked in: binfmt_misc squashfs vfat fat
snd_hda_codec_hdmi intel_rapl_msr intel_rapl_common amdgpu(+)
snd_soc_dmic snd_ps_pdm_dma snd_soc_ps_mach snd_hda_intel
snd_intel_dspcfg snd_soc_core snd_hda_codec snd_compress ac97_bus
snd_pcm_dmaengine snd_hda_core snd_seq_dummy uvcvideo snd_hwdep uvc
hid_sensor_magn_3d hid_sensor_gyro_3d snd_seq_oss videobuf2_vmalloc
snd_pci_ps hid_sensor_trigger videobuf2_memops hid_sensor_iio_common
snd_seq_midi snd_rpl_pci_acp6x snd_seq_midi_event
industrialio_triggered_buffer kfifo_buf videobuf2_v4l2 snd_acp_pci
edac_mce_amd industrialio crct10dif_pclmul videobuf2_common snd_rawmidi
snd_acp_legacy_common polyval_clmulni amdxcp gpu_sched polyval_generic
snd_pci_acp6x joydev i2c_algo_bit videodev drm_suballoc_helper
drm_ttm_helper snd_seq snd_pcm ghash_clmulni_intel ttm sha512_ssse3
snd_seq_device drm_exec sha256_ssse3 mc snd_timer snd_pci_acp5x
drm_display_helper sha1_ssse3 snd_rn_pci_acp3x snd_acp_config wmi_bmof
snd rapl cec snd_soc_acpi drm_buddy soundcore i2c_piix4
[   29.014048]  snd_pci_acp3x k10temp amd_pmf platform_profile
hid_sensor_hub amd_pmc hid_multitouch serio_raw kvm_amd ccp kvm
irqbypass iptable_filter ip6table_filter ip6_tables br_netfilter bridge
stp llc arp_tables parport_pc ppdev lp parport loop fuse ip_tables
rtsx_pci_sdmmc mmc_core video nvme crc32_pclmul crc32c_intel thunderbolt
nvme_core amd_sfh r8169 rtsx_pci wmi i2c_hid_acpi i2c_hid
[   29.023590] CR2: 000000000000000c
[   29.023856] ---[ end trace 0000000000000000 ]---
[   29.024220] RIP: 0010:amdgpu_gmc_agp_addr+0x16/0x60 [amdgpu]
[   29.024886] Code: 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90
90 90 90 0f 1f 44 00 00 48 8b 87 88 01 00 00 49 b8 ff ff ff ff ff ff ff
7f <83> 78 0c 01 75 2e 83 78 28 02 74 28 48 8b 40 18 48 8b 97 60 01 00
[   29.026324] RSP: 0018:ffffc90000ff7998 EFLAGS: 00010282
[   29.026737] RAX: 0000000000000000 RBX: ffff888103f83800 RCX:
0000000000000000
[   29.027290] RDX: 7fffffffffffffff RSI: ffff888103f83858 RDI:
ffff888103f83858
[   29.027848] RBP: ffff888102f0f020 R08: 7fffffffffffffff R09:
0000000000000000
[   29.028401] R10: 0000000000001000 R11: 0000000000001000 R12:
ffff888103f83800
[   29.028960] R13: ffff888102f0fdf8 R14: ffff888102f0fe00 R15:
0000000000000000
[   29.029521] FS:  00007fe6aa26a8c0(0000) GS:ffff88844e880000(0000)
knlGS:0000000000000000
[   29.030147] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.030600] CR2: 000000000000000c CR3: 000000011556e000 CR4:
0000000000750ef0

>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++++---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  4 +---
> >   2 files changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.c
> > index cef920a93924..d79b4ca1ecfc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -1527,10 +1527,14 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
> >   u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
> >   {
> >       struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> > -     uint64_t offset;
> > +     uint64_t offset =3D AMDGPU_BO_INVALID_OFFSET;
> >
> > -     offset =3D (bo->tbo.resource->start << PAGE_SHIFT) +
> > -              amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type=
);
> > +     if (bo->tbo.resource->mem_type =3D=3D TTM_PL_TT)
> > +             offset =3D amdgpu_gmc_agp_addr(&bo->tbo);
> > +
> > +     if (offset =3D=3D AMDGPU_BO_INVALID_OFFSET)
> > +             offset =3D (bo->tbo.resource->start << PAGE_SHIFT) +
> > +                     amdgpu_ttm_domain_start(adev, bo->tbo.resource->m=
em_type);
> >
> >       return amdgpu_gmc_sign_extend(offset);
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index 05991c5c8ddb..ab4a762aed5b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -959,10 +959,8 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object=
 *bo)
> >               return 0;
> >
> >       addr =3D amdgpu_gmc_agp_addr(bo);
> > -     if (addr !=3D AMDGPU_BO_INVALID_OFFSET) {
> > -             bo->resource->start =3D addr >> PAGE_SHIFT;
> > +     if (addr !=3D AMDGPU_BO_INVALID_OFFSET)
> >               return 0;
> > -     }
> >
> >       /* allocate GART space */
> >       placement.num_placement =3D 1;
>
