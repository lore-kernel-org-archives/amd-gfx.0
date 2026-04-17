Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA291F433D6
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 08:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3085810E98D;
	Fri, 17 Apr 2026 08:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jJDc16tE";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 897B610E98C
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 08:07:23 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5a283c44478so628986e87.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 01:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776413242; x=1777018042; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=73DvTUanUf+DxHEMr5c+MvwLPGlfwujIV3/EPFJqrm0=;
 b=jJDc16tE49utYLPQBWIHpWnGy00tvVMd7QL5QxcBrMt4zmmSq6Sc4lus9f4vxQjuJT
 +S1H+Rf1eQWFZ631b6Ys2IaqDEDCAA5t0hwATILjJi7nb8nwmUXPYUCNUhyw/93mVHHh
 gzrxeX5MwLm/kD8DjGy0D4UOe5TnEvaf+FmV/UC5XsFlkj0ra+CIXtiO9E7K8WIhKh0D
 tdMesSLiGBM5OSSoRsKvJEXLD+w7h0mrGYX74zHxAc/Ln1Zn0pdg6nWAVHc7pJbnMP7M
 R+rO6HQY442FNxxPS+ehVCAZ6Ma5XGUcwyTwWDA/g4olo1W9ah3OwJ9EdhfRrIjsg8yc
 yPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776413242; x=1777018042;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=73DvTUanUf+DxHEMr5c+MvwLPGlfwujIV3/EPFJqrm0=;
 b=LPL+9SORZAn4PUnQ74FkebkLPp262s/EanBfRQ46A1tfmtx6Gq0gnSf/b9/xkWmh94
 bKrlb4TF0kkqQn4itWjo6FYI8u7Lj8ThF74TIYlghwIxuVPSHqO00QYSpdY2OBhb+bqY
 3eB3sD9LSdFZq+ph6jFQJolF4T03P8/cgxc5bjbqmUHqzz3jr72K4GYBPgrqvHMXEwvQ
 5t9EcpzE2jX9+2zFhZFQPDGz8ZTai4TzVQkVS3Jr5jg2UYO2+nKaKjZdyEn/nfPuZr2t
 NYjF4m/rYi29WI/eMr6l0bhiPHhNvBGl2zSmVMQ8YCFr7euKf/29u0v+IakJ110x7SlW
 edtg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UO/e93DlbzMWVxLjZ8zINrr04UokSppSD1b/5iDU2b52/6Zw2Yh9A++GZ1jcm1Suf3F+mfSAQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzqY+7icvz80REEynE3irgS4kqunV8pFkl2TZhH87WdVPsXcLcK
 5ALd13cjR5vhkcRLoSClnouKl35FbkJojECgRd8HvCFg2GqchATvR00P
X-Gm-Gg: AeBDietblywt72h00o52AxEtTR86tD1RWLpsEI+fATw43VTuq63bFHdm6/4M7uIkFJl
 wXxa6ix4I57jpgiStPzw9CL72+uXYMh1IanqcFMylCXffADgXX5E5rDqfxq6cLhxpHEC/GZFr1a
 DocZ5HpM3d07JmFhtA45VOUC70uC4hDXdIHzDTfKENmlY+bnRpO4JAvHmI8f4MvyMKYVeLtH5eb
 TjF6FMbeBKLuTty2TfnfKeO+PQ9BBf7GKznptAuw71ZuD5FfpKUEQ2HUo84yJaNDN32zEV68moN
 j88jKhn8ODLE5w+tkTLYyYc+5Rqfb0ptPkQZPcx4zLrIkxM4mf5lD4lrE7qA7iG8emcewS9oQC3
 khzVQciOTXH3NpxVu1EsSBjvpO/O8d7jOPKHrUMAANHTOp0EeYANzFB1KijLYZnIO1wRxsao41O
 gMl+RJKe+/PXKHZEGorFp1GLQkxEwnTtGw3QYn55haSYIL/+5Zxz8SyQ==
X-Received: by 2002:a05:6512:ad1:b0:5a4:1133:c305 with SMTP id
 2adb3069b0e04-5a4172daa96mr515983e87.26.1776413241290; 
 Fri, 17 Apr 2026 01:07:21 -0700 (PDT)
Received: from primary-ws.local ([188.234.148.119])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad2f4sm197797e87.17.2026.04.17.01.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 01:07:19 -0700 (PDT)
Message-ID: <a59292d686e3d5c17fe36e20b55996208d36a6fb.camel@gmail.com>
Subject: Re: [PATCH 10/19] drm/amd/display: Fix fpu guard warning
From: "mikhail.v.gavrilov@gmail.com" <mikhail.v.gavrilov@gmail.com>
To: Chenyu Chen <chen-yu.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung	 <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler	 <daniel.wheeler@amd.com>, Ray
 Wu <Ray.Wu@amd.com>, Ivan Lipski	 <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng	 <Chuanyu.Tseng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Rafal Ostrowski	 <rafal.ostrowski@amd.com>
Date: Fri, 17 Apr 2026 13:07:12 +0500
In-Reply-To: <20260415074223.34848-11-chen-yu.chen@amd.com>
References: <20260415074223.34848-1-chen-yu.chen@amd.com>
 <20260415074223.34848-11-chen-yu.chen@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc45) 
MIME-Version: 1.0
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

On Wed, 2026-04-15 at 15:39 +0800, Chenyu Chen wrote:
> From: Wayne Lin <Wayne.Lin@amd.com>
>=20
> [Why]
> Due to improper fpu guarding, we encounter this warning during boot
> up:
>=20
> [=C2=A0=C2=A0 10.027021] WARNING:
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:58 at
> dc_assert_fp_enabled+0x12/0x20 [amdgpu], CPU#8: (udev-worker)/469
> [=C2=A0=C2=A0 10.027644] Modules linked in: binfmt_misc snd_ctl_led
> nls_iso8859_1 intel_rapl_msr amd_atl intel_rapl_common amdgpu(+)
> snd_acp_legacy_mach snd_acp_mach snd_soc_nau8821 snd_acp3x_pdm_dma
> snd_acp3x_rn snd_soc_dmic snd_sof_amd_acp63 snd_sof_amd_vangogh
> snd_sof_amd_rembrandt snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci
> snd_hda_codec_alc269 snd_sof_xtensa_dsp snd_hda_scodec_component
> snd_hda_codec_realtek_lib snd_sof snd_hda_codec_generic snd_sof_utils
> snd_pci_ps snd_soc_acpi_amd_match snd_amd_sdw_acpi soundwire_amd
> snd_hda_codec_atihdmi soundwire_generic_allocation snd_hda_codec_hdmi
> soundwire_bus snd_soc_sdca edac_mce_amd snd_hda_intel snd_soc_core
> snd_hda_codec kvm_amd snd_compress snd_hda_core ac97_bus ee1004
> amdxcp snd_pcm_dmaengine snd_intel_dspcfg snd_intel_sdw_acpi kvm
> drm_panel_backlight_quirks snd_rpl_pci_acp6x gpu_sched snd_hwdep
> snd_acp_pci irqbypass snd_amd_acpi_mach drm_buddy
> snd_acp_legacy_common snd_seq_midi ghash_clmulni_intel drm_ttm_helper
> aesni_intel snd_seq_midi_event snd_pci_acp6x joydev rapl
> [=C2=A0=C2=A0 10.027750]=C2=A0 snd_pcm snd_rawmidi ttm snd_seq snd_pci_ac=
p5x
> drm_exec drm_suballoc_helper snd_seq_device wmi_bmof snd_rn_pci_acp3x
> drm_display_helper snd_timer snd_acp_config cec snd_soc_acpi snd
> rc_core i2c_piix4 ccp snd_pci_acp3x i2c_smbus soundcore k10temp
> i2c_algo_bit spi_amd cdc_mbim input_leds cdc_wdm mac_hid sch_fq_codel
> msr parport_pc ppdev lp parport efi_pstore nfnetlink dmi_sysfs
> autofs4 cdc_ncm cdc_ether usbnet mii hid_logitech_hidpp
> hid_logitech_dj hid_generic nvme nvme_core ahci serio_raw
> nvme_keyring usbhid ucsi_acpi amd_xgbe nvme_auth libahci hkdf
> typec_ucsi video typec wmi i2c_hid_acpi i2c_hid hid
> [=C2=A0=C2=A0 10.027853] CPU: 8 UID: 0 PID: 469 Comm: (udev-worker) Not t=
ainted
> 6.19.0asdn-260408-asdn #1 PREEMPT(voluntary)
> [=C2=A0=C2=A0 10.027858] Hardware name: AMD Crater-RN/Crater-RN, BIOS TCR=
1004A
> 03/12/2024
> [=C2=A0=C2=A0 10.027861] RIP: 0010:dc_assert_fp_enabled+0x12/0x20 [amdgpu=
]
> [=C2=A0=C2=A0 10.028416] Code: 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 =
90 90
> 90 90 90 90 90 90 90 90 65 8b 05 39 79 cc c4 85 c0 7e 07 31 c0 e9 9e
> 75 2a c3 <0f> 0b 31 c0 e9 95 75 2a c3 0f 1f 44 00 00 90 90 90 90 90
> 90 90 90
> [=C2=A0=C2=A0 10.028420] RSP: 0018:ffffcca10188b348 EFLAGS: 00010246
> [=C2=A0=C2=A0 10.028425] RAX: 0000000000000000 RBX: ffff88c6077f8000 RCX:
> 0000000000000000
> [=C2=A0=C2=A0 10.028428] RDX: ffff88c607d0e400 RSI: ffffffffc204d860 RDI:
> ffff88c624c00000
> [=C2=A0=C2=A0 10.028430] RBP: ffffcca10188b3e8 R08: ffff88c624c35c88 R09:
> 0000000000000000
> [=C2=A0=C2=A0 10.028433] R10: 0000000000000000 R11: 0000000000000000 R12:
> ffffcca10188b548
> [=C2=A0=C2=A0 10.028435] R13: ffff88c60be5bd00 R14: ffffffffc204d860 R15:
> ffff88c624c00000
> [=C2=A0=C2=A0 10.028438] FS:=C2=A0 00007c80c2432980(0000) GS:ffff88cdc746=
4000(0000)
> knlGS:0000000000000000
> [=C2=A0=C2=A0 10.028441] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
> [=C2=A0=C2=A0 10.028443] CR2: 00007866ae013da8 CR3: 000000010a511000 CR4:
> 0000000000350ef0
> [=C2=A0=C2=A0 10.028446] Call Trace:
> [=C2=A0=C2=A0 10.028449]=C2=A0 <TASK>
> [=C2=A0=C2=A0 10.028452]=C2=A0 ? dcn21_update_bw_bounding_box+0x38/0xb30 =
[amdgpu]
> [=C2=A0=C2=A0 10.028991]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 10.029001]=C2=A0 dc_create+0x37c/0x730 [amdgpu]
> [=C2=A0=C2=A0 10.029505]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 10.029512]=C2=A0 amdgpu_dm_init+0x374/0x2ff0 [amdgpu]
> [=C2=A0=C2=A0 10.030053]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 10.030057]=C2=A0 ? __irq_work_queue_local+0x61/0xe0
> [=C2=A0=C2=A0 10.030063]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 10.030067]=C2=A0 ? irq_work_queue+0x2f/0x70
> [=C2=A0=C2=A0 10.030071]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 10.030075]=C2=A0 ? __wake_up_klogd+0x75/0xa0
> [=C2=A0=C2=A0 10.030081]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 10.030085]=C2=A0 ? vprintk_emit+0x35b/0x3f0
> [=C2=A0=C2=A0 10.030102]=C2=A0 dm_hw_init+0x1c/0x110 [amdgpu]
> [=C2=A0=C2=A0 10.030625]=C2=A0 amdgpu_device_init+0x23e8/0x3210 [amdgpu]
> [=C2=A0=C2=A0 10.031041]=C2=A0 ? pci_read+0x55/0x90
> [=C2=A0=C2=A0 10.031047]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 10.031051]=C2=A0 ? pci_read_config_word+0x27/0x50
> [=C2=A0=C2=A0 10.031057]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 10.031061]=C2=A0 ? do_pci_enable_device+0x155/0x180
> [=C2=A0=C2=A0 10.031068]=C2=A0 amdgpu_driver_load_kms+0x1a/0xd0 [amdgpu]
> [=C2=A0=C2=A0 10.031486]=C2=A0 amdgpu_pci_probe+0x28c/0x6f0 [amdgpu]
> [=C2=A0=C2=A0 10.031902]=C2=A0 local_pci_probe+0x47/0xb0
> [=C2=A0=C2=A0 10.031908]=C2=A0 pci_device_probe+0xf3/0x270
> [=C2=A0=C2=A0 10.031914]=C2=A0 really_probe+0xf1/0x410
> [=C2=A0=C2=A0 10.031920]=C2=A0 __driver_probe_device+0x8c/0x190
> [=C2=A0=C2=A0 10.031924]=C2=A0 driver_probe_device+0x24/0xd0
> [=C2=A0=C2=A0 10.031928]=C2=A0 __driver_attach+0x10b/0x240
> [=C2=A0=C2=A0 10.031932]=C2=A0 ? __pfx___driver_attach+0x10/0x10
> [=C2=A0=C2=A0 10.031936]=C2=A0 bus_for_each_dev+0x8c/0xf0
> [=C2=A0=C2=A0 10.031942]=C2=A0 driver_attach+0x1e/0x30
> [=C2=A0=C2=A0 10.031947]=C2=A0 bus_add_driver+0x160/0x2a0
> [=C2=A0=C2=A0 10.031952]=C2=A0 driver_register+0x5e/0x130
> [=C2=A0=C2=A0 10.031957]=C2=A0 ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
> [=C2=A0=C2=A0 10.032361]=C2=A0 __pci_register_driver+0x5e/0x70
> [=C2=A0=C2=A0 10.032366]=C2=A0 amdgpu_init+0x5d/0xff0 [amdgpu]
> [=C2=A0=C2=A0 10.032768]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 10.032773]=C2=A0 do_one_initcall+0x5d/0x340
> [=C2=A0=C2=A0 10.032783]=C2=A0 do_init_module+0x97/0x2c0
> [=C2=A0=C2=A0 10.032788]=C2=A0 load_module+0x2b49/0x2c30
> [=C2=A0=C2=A0 10.032800]=C2=A0 init_module_from_file+0xf4/0x120
> [=C2=A0=C2=A0 10.032804]=C2=A0 ? init_module_from_file+0xf4/0x120
> [=C2=A0=C2=A0 10.032813]=C2=A0 idempotent_init_module+0x10f/0x300
> [=C2=A0=C2=A0 10.032820]=C2=A0 __x64_sys_finit_module+0x73/0xf0
> [=C2=A0=C2=A0 10.032824]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 10.032829]=C2=A0 x64_sys_call+0x1d68/0x26b0
> [=C2=A0=C2=A0 10.032834]=C2=A0 do_syscall_64+0x81/0x500
> [=C2=A0=C2=A0 10.032839]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 10.032843]=C2=A0 ? do_syscall_64+0x2e5/0x500
> [=C2=A0=C2=A0 10.032848]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 10.032852]=C2=A0 ? native_flush_tlb_global+0x95/0xb0
> [=C2=A0=C2=A0 10.032860]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 10.032864]=C2=A0 ? __flush_tlb_all+0x13/0x60
> [=C2=A0=C2=A0 10.032870]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 10.032874]=C2=A0 ? do_flush_tlb_all+0xe/0x20
> [=C2=A0=C2=A0 10.032879]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 10.032882]=C2=A0 ? __flush_smp_call_function_queue+0x9c/0x4=
30
> [=C2=A0=C2=A0 10.032888]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 10.032897]=C2=A0 ? irqentry_exit+0xb2/0x740
> [=C2=A0=C2=A0 10.032901]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 10.032906]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0=C2=A0 10.032911]=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [=C2=A0=C2=A0 10.032915] RIP: 0033:0x7c80c1d3490d
> [=C2=A0=C2=A0 10.032920] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 =
0f 1e
> fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
> 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 f4 0f 00 f7 d8 64
> 89 01 48
> [=C2=A0=C2=A0 10.032923] RSP: 002b:00007fff3a12fe28 EFLAGS: 00000246 ORIG=
_RAX:
> 0000000000000139
> [=C2=A0=C2=A0 10.032928] RAX: ffffffffffffffda RBX: 00005c44096804f0 RCX:
> 00007c80c1d3490d
> [=C2=A0=C2=A0 10.032930] RDX: 0000000000000000 RSI: 00005c4409681690 RDI:
> 000000000000002b
> [=C2=A0=C2=A0 10.032933] RBP: 00007fff3a12fec0 R08: 0000000000000000 R09:
> 00005c4409681790
> [=C2=A0=C2=A0 10.032935] R10: 0000000000000000 R11: 0000000000000246 R12:
> 00005c4409681690
> [=C2=A0=C2=A0 10.032937] R13: 0000000000020000 R14: 00005c44094ff7f0 R15:
> 00005c4409681690
> [=C2=A0=C2=A0 10.032945]=C2=A0 </TASK>
> [=C2=A0=C2=A0 10.032948] ---[ end trace 0000000000000000 ]---
>=20
> [How]
> Add wrapper function to guard fpu properly for
> dcn21/dcn31/dcn315/dcn316.
>=20
> Fixes: 1489d86d9ac9 ("drm/amd/display: Move FPU Guards From DML To DC
> - Part 1")
>=20
> Reviewed-by: Dillon Varone <dillon.varone@amd.com>
> Reviewed-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
> ---
> =C2=A0drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 6 +++--
> -
> =C2=A0drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 6 +++--
> -
> =C2=A0.../gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c | 7
> +++++++
> =C2=A0.../gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c | 7
> +++++++
> =C2=A0.../drm/amd/display/dc/resource/dcn315/dcn315_resource.c=C2=A0=C2=
=A0 | 7
> +++++++
> =C2=A0.../drm/amd/display/dc/resource/dcn316/dcn316_resource.c=C2=A0=C2=
=A0 | 7
> +++++++
> =C2=A08 files changed, 36 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> index ed9dd2148d86..82f50847cbac 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> @@ -2400,7 +2400,7 @@ static struct _vcs_dpi_voltage_scaling_st
> construct_low_pstate_lvl(struct clk_li
> =C2=A0	return low_pstate_lvl;
> =C2=A0}
> =C2=A0
> -void dcn21_update_bw_bounding_box(struct dc *dc, struct
> clk_bw_params *bw_params)
> +void dcn21_update_bw_bounding_box_fpu(struct dc *dc, struct
> clk_bw_params *bw_params)
> =C2=A0{
> =C2=A0	struct _vcs_dpi_voltage_scaling_st *s =3D dc-
> >scratch.update_bw_bounding_box.clock_limits;
> =C2=A0	struct dcn21_resource_pool *pool =3D TO_DCN21_RES_POOL(dc-
> >res_pool);
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
> b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
> index aed00039ca62..8b2226c5bbbf 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
> @@ -78,7 +78,7 @@ int dcn21_populate_dml_pipes_from_context(struct dc
> *dc,
> =C2=A0					=C2=A0 enum dc_validate_mode
> validate_mode);
> =C2=A0bool dcn21_validate_bandwidth_fp(struct dc *dc, struct dc_state
> *context, enum
> =C2=A0				 dc_validate_mode,
> display_e2e_pipe_params_st *pipes);
> -void dcn21_update_bw_bounding_box(struct dc *dc, struct
> clk_bw_params *bw_params);
> +void dcn21_update_bw_bounding_box_fpu(struct dc *dc, struct
> clk_bw_params *bw_params);
> =C2=A0
> =C2=A0void dcn21_clk_mgr_set_bw_params_wm_table(struct clk_bw_params
> *bw_params);
> =C2=A0
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
> b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
> index 1a28061bb9ff..ad23215da9f8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
> @@ -587,7 +587,7 @@ void dcn31_calculate_wm_and_dlg_fp(
> =C2=A0	context->bw_ctx.bw.dcn.compbuf_size_kb =3D context-
> >bw_ctx.dml.ip.config_return_buffer_size_in_kbytes - total_det;
> =C2=A0}
> =C2=A0
> -void dcn31_update_bw_bounding_box(struct dc *dc, struct
> clk_bw_params *bw_params)
> +void dcn31_update_bw_bounding_box_fpu(struct dc *dc, struct
> clk_bw_params *bw_params)
> =C2=A0{
> =C2=A0	struct _vcs_dpi_voltage_scaling_st *s =3D dc-
> >scratch.update_bw_bounding_box.clock_limits;
> =C2=A0	struct clk_limit_table *clk_table =3D &bw_params->clk_table;
> @@ -665,7 +665,7 @@ void dcn31_update_bw_bounding_box(struct dc *dc,
> struct clk_bw_params *bw_params
> =C2=A0	dml_init_instance(&dc->dml, &dcn3_1_soc, &dcn3_1_ip,
> DML_PROJECT_DCN31);
> =C2=A0}
> =C2=A0
> -void dcn315_update_bw_bounding_box(struct dc *dc, struct
> clk_bw_params *bw_params)
> +void dcn315_update_bw_bounding_box_fpu(struct dc *dc, struct
> clk_bw_params *bw_params)
> =C2=A0{
> =C2=A0	struct clk_limit_table *clk_table =3D &bw_params->clk_table;
> =C2=A0	int i, max_dispclk_mhz =3D 0, max_dppclk_mhz =3D 0;
> @@ -726,7 +726,7 @@ void dcn315_update_bw_bounding_box(struct dc *dc,
> struct clk_bw_params *bw_param
> =C2=A0	dml_init_instance(&dc->dml, &dcn3_15_soc, &dcn3_15_ip,
> DML_PROJECT_DCN315);
> =C2=A0}
> =C2=A0
> -void dcn316_update_bw_bounding_box(struct dc *dc, struct
> clk_bw_params *bw_params)
> +void dcn316_update_bw_bounding_box_fpu(struct dc *dc, struct
> clk_bw_params *bw_params)
> =C2=A0{
> =C2=A0	struct _vcs_dpi_voltage_scaling_st *s =3D dc-
> >scratch.update_bw_bounding_box.clock_limits;
> =C2=A0	struct clk_limit_table *clk_table =3D &bw_params->clk_table;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
> b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
> index dfcc5d50071e..0b7fcbbfd17b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
> @@ -44,9 +44,9 @@ void dcn31_calculate_wm_and_dlg_fp(
> =C2=A0		int pipe_cnt,
> =C2=A0		int vlevel);
> =C2=A0
> -void dcn31_update_bw_bounding_box(struct dc *dc, struct
> clk_bw_params *bw_params);
> -void dcn315_update_bw_bounding_box(struct dc *dc, struct
> clk_bw_params *bw_params);
> -void dcn316_update_bw_bounding_box(struct dc *dc, struct
> clk_bw_params *bw_params);
> +void dcn31_update_bw_bounding_box_fpu(struct dc *dc, struct
> clk_bw_params *bw_params);
> +void dcn315_update_bw_bounding_box_fpu(struct dc *dc, struct
> clk_bw_params *bw_params);
> +void dcn316_update_bw_bounding_box_fpu(struct dc *dc, struct
> clk_bw_params *bw_params);
> =C2=A0int dcn_get_max_non_odm_pix_rate_100hz(struct
> _vcs_dpi_soc_bounding_box_st *soc);
> =C2=A0int dcn_get_approx_det_segs_required_for_pstate(
> =C2=A0		struct _vcs_dpi_soc_bounding_box_st *soc,
> diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
> index 89a1931b8d23..775cfa901f08 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
> @@ -1395,6 +1395,13 @@ static enum dc_status
> dcn21_patch_unknown_plane_state(struct dc_plane_state *pla
> =C2=A0	return dcn20_patch_unknown_plane_state(plane_state);
> =C2=A0}
> =C2=A0
> +static void dcn21_update_bw_bounding_box(struct dc *dc, struct
> clk_bw_params *bw_params)
> +{
> +	DC_FP_START();
> +	dcn21_update_bw_bounding_box_fpu(dc, bw_params);
> +	DC_FP_END();
> +}
> +
> =C2=A0static const struct resource_funcs dcn21_res_pool_funcs =3D {
> =C2=A0	.destroy =3D dcn21_destroy_resource_pool,
> =C2=A0	.link_enc_create =3D dcn21_link_encoder_create,
> diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
> index 649b5e7c0373..200be0f46ab0 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
> @@ -1858,6 +1858,13 @@ static struct dc_cap_funcs cap_funcs =3D {
> =C2=A0	.get_dcc_compression_cap =3D dcn20_get_dcc_compression_cap
> =C2=A0};
> =C2=A0
> +static void dcn31_update_bw_bounding_box(struct dc *dc, struct
> clk_bw_params *bw_params)
> +{
> +	DC_FP_START();
> +	dcn31_update_bw_bounding_box_fpu(dc, bw_params);
> +	DC_FP_END();
> +}
> +
> =C2=A0static struct resource_funcs dcn31_res_pool_funcs =3D {
> =C2=A0	.destroy =3D dcn31_destroy_resource_pool,
> =C2=A0	.link_enc_create =3D dcn31_link_encoder_create,
> diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> index 1e86a5e4d113..76b112426f33 100644
> ---
> a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> +++
> b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> @@ -1853,6 +1853,13 @@ static struct dc_cap_funcs cap_funcs =3D {
> =C2=A0	.get_dcc_compression_cap =3D dcn20_get_dcc_compression_cap
> =C2=A0};
> =C2=A0
> +static void dcn315_update_bw_bounding_box(struct dc *dc, struct
> clk_bw_params *bw_params)
> +{
> +	DC_FP_START();
> +	dcn315_update_bw_bounding_box_fpu(dc, bw_params);
> +	DC_FP_END();
> +}
> +
> =C2=A0static struct resource_funcs dcn315_res_pool_funcs =3D {
> =C2=A0	.destroy =3D dcn315_destroy_resource_pool,
> =C2=A0	.link_enc_create =3D dcn31_link_encoder_create,
> diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> index 6369fc90f84b..2d34db42dd83 100644
> ---
> a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> +++
> b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> @@ -1729,6 +1729,13 @@ static struct dc_cap_funcs cap_funcs =3D {
> =C2=A0	.get_dcc_compression_cap =3D dcn20_get_dcc_compression_cap
> =C2=A0};
> =C2=A0
> +static void dcn316_update_bw_bounding_box(struct dc *dc, struct
> clk_bw_params *bw_params)
> +{
> +	DC_FP_START();
> +	dcn316_update_bw_bounding_box_fpu(dc, bw_params);
> +	DC_FP_END();
> +}
> +
> =C2=A0static struct resource_funcs dcn316_res_pool_funcs =3D {
> =C2=A0	.destroy =3D dcn316_destroy_resource_pool,
> =C2=A0	.link_enc_create =3D dcn31_link_encoder_create,


Confirmed this fixes the dc_assert_fp_enabled warning on Ryzen 7000
(Raphael) iGPU (dcn315). Independently arrived at the same fix for
the dcn31 family before noticing this series =E2=80=94 dropping my duplicat=
e
submission [1].

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

[1]
https://lore.kernel.org/all/20260417001503.26147-1-mikhail.v.gavrilov@gmail=
.com
