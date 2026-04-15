Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD63FA0C3D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 07:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DB9A10E697;
	Wed, 15 Apr 2026 07:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GV340CFb";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4023710E69A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 07:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONbcg9b5nkjqYjEiGEjbJtAnf2nREE0wSOwVL2fY4NX6QZWsQmqwxUH0wAgH5quMmhvOaI9hgvfbKOmO3ZjQgZh/weTBrbjkNtaNJixJhzL4jeuTKQkUdfmgjq8Mee72CvCUmxKiwNE8Gs+aXnapMpLvxCLZF+nUjyhKa1LEC0w6d2BDhCXx/N2SKuY8IZFkQiPTj/+8995mEC+z9aQNE1Qq5p9J+hqNE3tKCenKACaBj2u/1dkuw+0VWf4KEFfwhqsa9pkYE2AMUdAbobh7bDRc8BgpRnW0JlABp9lKB7rSCf9XRhS+rwi6l0VNNgV3XxKFzijyrmBbLaDSwNTVog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YoslKDdrcBxrBm1zWl4Aa9cJ/5IB++hnVQmrB0M9Oc=;
 b=V4nVZzNBbDWE3xiM40h7ZwR9viCxYYnuHh9GHJwT7U75JVsFyn3yZdMOUapg2P6ozqH0QLCLKD9pRN1I1UUZEImfD0WcGLVLXZ8qqMsaPBI+6LY9Ty7htGWGvWpH0/4PZTvs5Zf3AcI0YttGwx1rlaNTZxMmJr+TS6Nbz1lYvBGnR7dsqBwSSar+ROJ13O8UeCkmRXA0Av7nLyW2GLe0W0KskZaJSniQ1KP2GY4GZ+7h5NZ+0JyZQ+dBG87tvPos4BD54kibTg9RYyjOS4/osFxQ6pcDxa1XCFi0ipNxmpruzfiGFok59j8y+o3QedXYDlEW+scoOi3aLGaDgZ1zpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YoslKDdrcBxrBm1zWl4Aa9cJ/5IB++hnVQmrB0M9Oc=;
 b=GV340CFbkdy+TmW17G1+UbU4ZMjZ+IruHk4q8Kje0jtSuu1Iq6dAmGDzFlgAEugr8wx/HsjxVKR7MJuO+Tr9orYacbtfe8BstLbaVEF3pFJLmLUJg/MpeTYStWg+AHV+lU0Mn3S9W1Pr2SHxCf0PDjwqFTvLKLe3Go0U3P0Hu8E=
Received: from BL0PR02CA0069.namprd02.prod.outlook.com (2603:10b6:207:3d::46)
 by SA5PPF590085732.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 07:43:48 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::e0) by BL0PR02CA0069.outlook.office365.com
 (2603:10b6:207:3d::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.50 via Frontend Transport; Wed,
 15 Apr 2026 07:43:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 07:43:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 15 Apr
 2026 02:43:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 15 Apr
 2026 02:43:47 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 02:43:39 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, Dillon Varone <dillon.varone@amd.com>, Rafal Ostrowski
 <rafal.ostrowski@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 10/19] drm/amd/display: Fix fpu guard warning
Date: Wed, 15 Apr 2026 15:39:49 +0800
Message-ID: <20260415074223.34848-11-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415074223.34848-1-chen-yu.chen@amd.com>
References: <20260415074223.34848-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chen-yu.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|SA5PPF590085732:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f399dd-7437-47cf-8df8-08de9ac2bb04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: qZKDc2RBvBd9ox6cqg5CYPfxWuuLiq51aDFRoa518mEEBYr0+GeNkj4R0QVo5moUChuWzjzglse4vozHC2Wu0l+em+Bmj8awyksQVFDbydksAeExM50Mi8VeICCr4IbC4k4Yg57lL2zsFQJtbvmr7QWkUFoM7MCkthv5lHGm2pFugnen4trSY5/Zz8nGxWBHrJMTfhmESnClya8LAnS7ITPXlbnrgh+PT81Ndsqz5vyZ4gwrJCF0Z28Bt6w2bfpEWc59UcfoqWAQq9ILivTnHIzEnw5gN8x7M9lRl9Pa3/oVb9cx8pRNuJmuaf0m2brNkqhh6nuxbCthQ10UQN/4lFlVmQS26W5ZmQEjS7XV39hXoiXZHk/BsphE7SvelHREqa8T/zmTeT/snxpnSceRsoslQmUuGZ2gUfe9pHHGGS0GCi7wjY2qsYqLv4VQSkHhdSilXLBM5/kQtUbXGhXkNObPTVMnmIKhC/dJjfBYPZie5rlb2bES/+fJzZlU6HUHkqc0fG3D34XAFIYmLeM/tdBHZhlJLOCOL2VAYUymD4b3doNt+bgy+xX8BJCeQdXqYJvdK7m9/jQu/iorhYxwMMAgmMTYA5WRLpff6di41c5MWpdt8jvk1pP/61sHAN/2135g4KzHt0WPhDhfvwWO+IHczDi9XT0NgfC9X+hDWDAKUf5W+A4TvS+3P9suoY+l6cWlNtr3HuhQmSLOhGOD3LGKzG/FIesZhRm7JxYHoOp+OXSTn+ZhkD4hYuXf4mDVX/VZxzrtsJLtdUpCaD9gEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AomnS3FNRZy86SN2m94aHcRbMgCIOWjyxLQnCFHvy7l5pU1LYmiKCVxrQF+DVu/K7qdTdoT4j9ig3+KFkavInQ60KY4Abqi0/1FuqeAZt/wCFTXWSAq+YeznrLkcpyxbXcVTrNnHNgd7MZVqkaL/JEYg6L+Onk0iouSigQIRcZc+pxDe/C/DJ7HG4QcV/vcCFZ8eF8xV6f02ZR7N5vlmxNgHOwWKGeaoL8pve4frYNtDKvTLI+fb2qhM6kn6KQNbP0Y3HNXtilqEwFJMYKIsc1gjkeVX8AoGwy9TlDQgwknLYTMQdNRAAfwglBtXRprW+qaNemrxc0kkXwyXOuxWqumbiddEl41M7Kr6UCBBmXdUb+/n3B0O3nq/lMiUWTNCHPLvaCrCj+UzRwz8tQriS9NIonDCIsewJ48iKP0tP0ZXQ45CfaDR0vgiPpY8Th2Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 07:43:48.4719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f399dd-7437-47cf-8df8-08de9ac2bb04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF590085732
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Due to improper fpu guarding, we encounter this warning during boot up:

[   10.027021] WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_=
fpu.c:58 at dc_assert_fp_enabled+0x12/0x20 [amdgpu], CPU#8: (udev-worker)/4=
69
[   10.027644] Modules linked in: binfmt_misc snd_ctl_led nls_iso8859_1 int=
el_rapl_msr amd_atl intel_rapl_common amdgpu(+) snd_acp_legacy_mach snd_acp=
_mach snd_soc_nau8821 snd_acp3x_pdm_dma snd_acp3x_rn snd_soc_dmic snd_sof_a=
md_acp63 snd_sof_amd_vangogh snd_sof_amd_rembrandt snd_sof_amd_renoir snd_s=
of_amd_acp snd_sof_pci snd_hda_codec_alc269 snd_sof_xtensa_dsp snd_hda_scod=
ec_component snd_hda_codec_realtek_lib snd_sof snd_hda_codec_generic snd_so=
f_utils snd_pci_ps snd_soc_acpi_amd_match snd_amd_sdw_acpi soundwire_amd sn=
d_hda_codec_atihdmi soundwire_generic_allocation snd_hda_codec_hdmi soundwi=
re_bus snd_soc_sdca edac_mce_amd snd_hda_intel snd_soc_core snd_hda_codec k=
vm_amd snd_compress snd_hda_core ac97_bus ee1004 amdxcp snd_pcm_dmaengine s=
nd_intel_dspcfg snd_intel_sdw_acpi kvm drm_panel_backlight_quirks snd_rpl_p=
ci_acp6x gpu_sched snd_hwdep snd_acp_pci irqbypass snd_amd_acpi_mach drm_bu=
ddy snd_acp_legacy_common snd_seq_midi ghash_clmulni_intel drm_ttm_helper a=
esni_intel snd_seq_midi_event snd_pci_acp6x joydev rapl
[   10.027750]  snd_pcm snd_rawmidi ttm snd_seq snd_pci_acp5x drm_exec drm_=
suballoc_helper snd_seq_device wmi_bmof snd_rn_pci_acp3x drm_display_helper=
 snd_timer snd_acp_config cec snd_soc_acpi snd rc_core i2c_piix4 ccp snd_pc=
i_acp3x i2c_smbus soundcore k10temp i2c_algo_bit spi_amd cdc_mbim input_led=
s cdc_wdm mac_hid sch_fq_codel msr parport_pc ppdev lp parport efi_pstore n=
fnetlink dmi_sysfs autofs4 cdc_ncm cdc_ether usbnet mii hid_logitech_hidpp =
hid_logitech_dj hid_generic nvme nvme_core ahci serio_raw nvme_keyring usbh=
id ucsi_acpi amd_xgbe nvme_auth libahci hkdf typec_ucsi video typec wmi i2c=
_hid_acpi i2c_hid hid
[   10.027853] CPU: 8 UID: 0 PID: 469 Comm: (udev-worker) Not tainted 6.19.=
0asdn-260408-asdn #1 PREEMPT(voluntary)
[   10.027858] Hardware name: AMD Crater-RN/Crater-RN, BIOS TCR1004A 03/12/=
2024
[   10.027861] RIP: 0010:dc_assert_fp_enabled+0x12/0x20 [amdgpu]
[   10.028416] Code: 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 65 8b 05 39 79 cc c4 85 c0 7e 07 31 c0 e9 9e 75 2a c3 <0f=
> 0b 31 c0 e9 95 75 2a c3 0f 1f 44 00 00 90 90 90 90 90 90 90 90
[   10.028420] RSP: 0018:ffffcca10188b348 EFLAGS: 00010246
[   10.028425] RAX: 0000000000000000 RBX: ffff88c6077f8000 RCX: 00000000000=
00000
[   10.028428] RDX: ffff88c607d0e400 RSI: ffffffffc204d860 RDI: ffff88c624c=
00000
[   10.028430] RBP: ffffcca10188b3e8 R08: ffff88c624c35c88 R09: 00000000000=
00000
[   10.028433] R10: 0000000000000000 R11: 0000000000000000 R12: ffffcca1018=
8b548
[   10.028435] R13: ffff88c60be5bd00 R14: ffffffffc204d860 R15: ffff88c624c=
00000
[   10.028438] FS:  00007c80c2432980(0000) GS:ffff88cdc7464000(0000) knlGS:=
0000000000000000
[   10.028441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.028443] CR2: 00007866ae013da8 CR3: 000000010a511000 CR4: 00000000003=
50ef0
[   10.028446] Call Trace:
[   10.028449]  <TASK>
[   10.028452]  ? dcn21_update_bw_bounding_box+0x38/0xb30 [amdgpu]
[   10.028991]  ? srso_return_thunk+0x5/0x5f
[   10.029001]  dc_create+0x37c/0x730 [amdgpu]
[   10.029505]  ? srso_return_thunk+0x5/0x5f
[   10.029512]  amdgpu_dm_init+0x374/0x2ff0 [amdgpu]
[   10.030053]  ? srso_return_thunk+0x5/0x5f
[   10.030057]  ? __irq_work_queue_local+0x61/0xe0
[   10.030063]  ? srso_return_thunk+0x5/0x5f
[   10.030067]  ? irq_work_queue+0x2f/0x70
[   10.030071]  ? srso_return_thunk+0x5/0x5f
[   10.030075]  ? __wake_up_klogd+0x75/0xa0
[   10.030081]  ? srso_return_thunk+0x5/0x5f
[   10.030085]  ? vprintk_emit+0x35b/0x3f0
[   10.030102]  dm_hw_init+0x1c/0x110 [amdgpu]
[   10.030625]  amdgpu_device_init+0x23e8/0x3210 [amdgpu]
[   10.031041]  ? pci_read+0x55/0x90
[   10.031047]  ? srso_return_thunk+0x5/0x5f
[   10.031051]  ? pci_read_config_word+0x27/0x50
[   10.031057]  ? srso_return_thunk+0x5/0x5f
[   10.031061]  ? do_pci_enable_device+0x155/0x180
[   10.031068]  amdgpu_driver_load_kms+0x1a/0xd0 [amdgpu]
[   10.031486]  amdgpu_pci_probe+0x28c/0x6f0 [amdgpu]
[   10.031902]  local_pci_probe+0x47/0xb0
[   10.031908]  pci_device_probe+0xf3/0x270
[   10.031914]  really_probe+0xf1/0x410
[   10.031920]  __driver_probe_device+0x8c/0x190
[   10.031924]  driver_probe_device+0x24/0xd0
[   10.031928]  __driver_attach+0x10b/0x240
[   10.031932]  ? __pfx___driver_attach+0x10/0x10
[   10.031936]  bus_for_each_dev+0x8c/0xf0
[   10.031942]  driver_attach+0x1e/0x30
[   10.031947]  bus_add_driver+0x160/0x2a0
[   10.031952]  driver_register+0x5e/0x130
[   10.031957]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   10.032361]  __pci_register_driver+0x5e/0x70
[   10.032366]  amdgpu_init+0x5d/0xff0 [amdgpu]
[   10.032768]  ? srso_return_thunk+0x5/0x5f
[   10.032773]  do_one_initcall+0x5d/0x340
[   10.032783]  do_init_module+0x97/0x2c0
[   10.032788]  load_module+0x2b49/0x2c30
[   10.032800]  init_module_from_file+0xf4/0x120
[   10.032804]  ? init_module_from_file+0xf4/0x120
[   10.032813]  idempotent_init_module+0x10f/0x300
[   10.032820]  __x64_sys_finit_module+0x73/0xf0
[   10.032824]  ? srso_return_thunk+0x5/0x5f
[   10.032829]  x64_sys_call+0x1d68/0x26b0
[   10.032834]  do_syscall_64+0x81/0x500
[   10.032839]  ? srso_return_thunk+0x5/0x5f
[   10.032843]  ? do_syscall_64+0x2e5/0x500
[   10.032848]  ? srso_return_thunk+0x5/0x5f
[   10.032852]  ? native_flush_tlb_global+0x95/0xb0
[   10.032860]  ? srso_return_thunk+0x5/0x5f
[   10.032864]  ? __flush_tlb_all+0x13/0x60
[   10.032870]  ? srso_return_thunk+0x5/0x5f
[   10.032874]  ? do_flush_tlb_all+0xe/0x20
[   10.032879]  ? srso_return_thunk+0x5/0x5f
[   10.032882]  ? __flush_smp_call_function_queue+0x9c/0x430
[   10.032888]  ? srso_return_thunk+0x5/0x5f
[   10.032897]  ? irqentry_exit+0xb2/0x740
[   10.032901]  ? srso_return_thunk+0x5/0x5f
[   10.032906]  ? srso_return_thunk+0x5/0x5f
[   10.032911]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   10.032915] RIP: 0033:0x7c80c1d3490d
[   10.032920] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 f4 0f 00 f7 d8 64 89 01 48
[   10.032923] RSP: 002b:00007fff3a12fe28 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   10.032928] RAX: ffffffffffffffda RBX: 00005c44096804f0 RCX: 00007c80c1d=
3490d
[   10.032930] RDX: 0000000000000000 RSI: 00005c4409681690 RDI: 00000000000=
0002b
[   10.032933] RBP: 00007fff3a12fec0 R08: 0000000000000000 R09: 00005c44096=
81790
[   10.032935] R10: 0000000000000000 R11: 0000000000000246 R12: 00005c44096=
81690
[   10.032937] R13: 0000000000020000 R14: 00005c44094ff7f0 R15: 00005c44096=
81690
[   10.032945]  </TASK>
[   10.032948] ---[ end trace 0000000000000000 ]---

[How]
Add wrapper function to guard fpu properly for dcn21/dcn31/dcn315/dcn316.

Fixes: 1489d86d9ac9 ("drm/amd/display: Move FPU Guards From DML To DC - Par=
t 1")

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c       | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h       | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c       | 6 +++---
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h       | 6 +++---
 .../gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c | 7 +++++++
 .../gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c | 7 +++++++
 .../drm/amd/display/dc/resource/dcn315/dcn315_resource.c   | 7 +++++++
 .../drm/amd/display/dc/resource/dcn316/dcn316_resource.c   | 7 +++++++
 8 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers=
/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index ed9dd2148d86..82f50847cbac 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -2400,7 +2400,7 @@ static struct _vcs_dpi_voltage_scaling_st construct_l=
ow_pstate_lvl(struct clk_li
 	return low_pstate_lvl;
 }
=20
-void dcn21_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_=
params)
+void dcn21_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params =
*bw_params)
 {
 	struct _vcs_dpi_voltage_scaling_st *s =3D dc->scratch.update_bw_bounding_=
box.clock_limits;
 	struct dcn21_resource_pool *pool =3D TO_DCN21_RES_POOL(dc->res_pool);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h b/drivers=
/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
index aed00039ca62..8b2226c5bbbf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
@@ -78,7 +78,7 @@ int dcn21_populate_dml_pipes_from_context(struct dc *dc,
 					  enum dc_validate_mode validate_mode);
 bool dcn21_validate_bandwidth_fp(struct dc *dc, struct dc_state *context, =
enum
 				 dc_validate_mode, display_e2e_pipe_params_st *pipes);
-void dcn21_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_=
params);
+void dcn21_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params =
*bw_params);
=20
 void dcn21_clk_mgr_set_bw_params_wm_table(struct clk_bw_params *bw_params);
=20
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers=
/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 1a28061bb9ff..ad23215da9f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -587,7 +587,7 @@ void dcn31_calculate_wm_and_dlg_fp(
 	context->bw_ctx.bw.dcn.compbuf_size_kb =3D context->bw_ctx.dml.ip.config_=
return_buffer_size_in_kbytes - total_det;
 }
=20
-void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_=
params)
+void dcn31_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params =
*bw_params)
 {
 	struct _vcs_dpi_voltage_scaling_st *s =3D dc->scratch.update_bw_bounding_=
box.clock_limits;
 	struct clk_limit_table *clk_table =3D &bw_params->clk_table;
@@ -665,7 +665,7 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct=
 clk_bw_params *bw_params
 	dml_init_instance(&dc->dml, &dcn3_1_soc, &dcn3_1_ip, DML_PROJECT_DCN31);
 }
=20
-void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw=
_params)
+void dcn315_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params=
 *bw_params)
 {
 	struct clk_limit_table *clk_table =3D &bw_params->clk_table;
 	int i, max_dispclk_mhz =3D 0, max_dppclk_mhz =3D 0;
@@ -726,7 +726,7 @@ void dcn315_update_bw_bounding_box(struct dc *dc, struc=
t clk_bw_params *bw_param
 	dml_init_instance(&dc->dml, &dcn3_15_soc, &dcn3_15_ip, DML_PROJECT_DCN315=
);
 }
=20
-void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw=
_params)
+void dcn316_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params=
 *bw_params)
 {
 	struct _vcs_dpi_voltage_scaling_st *s =3D dc->scratch.update_bw_bounding_=
box.clock_limits;
 	struct clk_limit_table *clk_table =3D &bw_params->clk_table;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h b/drivers=
/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
index dfcc5d50071e..0b7fcbbfd17b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
@@ -44,9 +44,9 @@ void dcn31_calculate_wm_and_dlg_fp(
 		int pipe_cnt,
 		int vlevel);
=20
-void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_=
params);
-void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw=
_params);
-void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw=
_params);
+void dcn31_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params =
*bw_params);
+void dcn315_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params=
 *bw_params);
+void dcn316_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params=
 *bw_params);
 int dcn_get_max_non_odm_pix_rate_100hz(struct _vcs_dpi_soc_bounding_box_st=
 *soc);
 int dcn_get_approx_det_segs_required_for_pstate(
 		struct _vcs_dpi_soc_bounding_box_st *soc,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c=
 b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 89a1931b8d23..775cfa901f08 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -1395,6 +1395,13 @@ static enum dc_status dcn21_patch_unknown_plane_stat=
e(struct dc_plane_state *pla
 	return dcn20_patch_unknown_plane_state(plane_state);
 }
=20
+static void dcn21_update_bw_bounding_box(struct dc *dc, struct clk_bw_para=
ms *bw_params)
+{
+	DC_FP_START();
+	dcn21_update_bw_bounding_box_fpu(dc, bw_params);
+	DC_FP_END();
+}
+
 static const struct resource_funcs dcn21_res_pool_funcs =3D {
 	.destroy =3D dcn21_destroy_resource_pool,
 	.link_enc_create =3D dcn21_link_encoder_create,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c=
 b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 649b5e7c0373..200be0f46ab0 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1858,6 +1858,13 @@ static struct dc_cap_funcs cap_funcs =3D {
 	.get_dcc_compression_cap =3D dcn20_get_dcc_compression_cap
 };
=20
+static void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_para=
ms *bw_params)
+{
+	DC_FP_START();
+	dcn31_update_bw_bounding_box_fpu(dc, bw_params);
+	DC_FP_END();
+}
+
 static struct resource_funcs dcn31_res_pool_funcs =3D {
 	.destroy =3D dcn31_destroy_resource_pool,
 	.link_enc_create =3D dcn31_link_encoder_create,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 1e86a5e4d113..76b112426f33 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1853,6 +1853,13 @@ static struct dc_cap_funcs cap_funcs =3D {
 	.get_dcc_compression_cap =3D dcn20_get_dcc_compression_cap
 };
=20
+static void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_par=
ams *bw_params)
+{
+	DC_FP_START();
+	dcn315_update_bw_bounding_box_fpu(dc, bw_params);
+	DC_FP_END();
+}
+
 static struct resource_funcs dcn315_res_pool_funcs =3D {
 	.destroy =3D dcn315_destroy_resource_pool,
 	.link_enc_create =3D dcn31_link_encoder_create,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 6369fc90f84b..2d34db42dd83 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1729,6 +1729,13 @@ static struct dc_cap_funcs cap_funcs =3D {
 	.get_dcc_compression_cap =3D dcn20_get_dcc_compression_cap
 };
=20
+static void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_par=
ams *bw_params)
+{
+	DC_FP_START();
+	dcn316_update_bw_bounding_box_fpu(dc, bw_params);
+	DC_FP_END();
+}
+
 static struct resource_funcs dcn316_res_pool_funcs =3D {
 	.destroy =3D dcn316_destroy_resource_pool,
 	.link_enc_create =3D dcn31_link_encoder_create,
--=20
2.43.0

