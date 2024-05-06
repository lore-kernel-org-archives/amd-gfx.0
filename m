Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D779C25B5F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 13:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAA4210E9CF;
	Mon,  6 May 2024 13:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AmEP1TO8";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18E6510E9CF
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 13:49:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byQ0PLV+eq8v+3R1EUXdBriBzHKngCLJt3G01PkgPq+vBudvjqYrsgToPvZqN9qN+XNOdKu90p1JzpVk4CL/Ef2bz2/XU63mE4nugFCkttKXUXs0oNMna7q+7puOBvawitzZzjhyaj6qjhxVHFSKpz38AoVbtG3W+C8rTw+VH4PL2xJb//wR3AwwySQwKyPpDlfvSldfrBgP/kWGUR7QRkhVIOzChfdbM4Mz8DVqHlLyb6H5xWPWmzQsMnK/xDvJhEm7As1uLYgKb7VUYG8E+6bxTsNieUpqbo8Xwcjfh6gqWRmfsp//zRPrl3o3fXqC5s4HakAl9PbYdUjtiW0Pvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wf18AUqlDVCWH5r5+7EY4euSPgo3kP8hdWnFnRUjgqs=;
 b=WOUCTMWKNPTDfNDs2vGNYWbj+LY8fxgiNrtrOXkFcPgI07DMe4YcYdTQMNwiyStwOVa2eyQfCwbQRIta5QwI1B40OuBl1cLgGuesDKWZeSxS50xVZI0nNSXsJXHCN3Jfn57ouSlpjdOtZth+kHlO1t0R+1jL4H6c75n24eT7hy7bpPsdOwRJN3graSMQXQRaB/M6SulMOkMVXUk0wjFxRvcMJlIFODOIH1zeqNmzf1tQr/e68YTbth0gh0NDHTABXwh66YBVeVPrbXvfY/KUO/+DvMxX2RXtexG79VqJ+ah060+/h32DC+tLM2doKjSdrwpMNb9KcHwNc35d3DupUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wf18AUqlDVCWH5r5+7EY4euSPgo3kP8hdWnFnRUjgqs=;
 b=AmEP1TO8VkobcpqwoscPHbkk0ZPEEONqEIKGnymAL+CK7pDMkdRemuVpo2jFtOgK2oYDf30gvxvMRJEFUjRU45c5or79CnEWdkc9w1/uvGjxfHUaOYuPNkZCs73pkjtop81INR2KOzYnp2+OT310oqLkOEvViTkPUolHACN9lkI=
Received: from CH0PR07CA0028.namprd07.prod.outlook.com (2603:10b6:610:32::33)
 by MW4PR12MB6851.namprd12.prod.outlook.com (2603:10b6:303:20b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Mon, 6 May
 2024 13:49:08 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::8a) by CH0PR07CA0028.outlook.office365.com
 (2603:10b6:610:32::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 13:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 6 May 2024 13:49:07 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 08:49:05 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <tvrtko.ursulin@igalia.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the BO release clear memory warning
Date: Mon, 6 May 2024 19:18:42 +0530
Message-ID: <20240506134842.4688-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|MW4PR12MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 5388180c-c1a6-436c-8e12-08dc6dd34cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eWJwuF+WmKgffqaY8egnf6u9oxoBrp9YU1K8aOsGtosZPx1IDieWFMdhkXRg?=
 =?us-ascii?Q?w0DIzJlvHPpPlVUoWWEriOyCGajc75cyo+JfqKSoaKle1pJWT9YMAPEnWl/P?=
 =?us-ascii?Q?qT/lYdFLGJ5fqUMIQEBIHxEiSdzWvpTo4VUBmeE46BjYmAmATQfZahVf2FCO?=
 =?us-ascii?Q?p2S1HvcpaH6AMTuORWNrrZUxv8kBfJosxOxZU0xoo+30IkV1amkPRLlXMBvn?=
 =?us-ascii?Q?hgvAdjJykTq+lAhwXq6YPDKuxR5Jq5N6l+G3W9N4fT+EDA3M+me7r58DPXhC?=
 =?us-ascii?Q?KWzvPiZdBlTMEmEz68sPWRyC8e73xZoHBorrFejzwumqtbpL6tC+JhtaI+1t?=
 =?us-ascii?Q?yK4m8ZaEiIPtDQ0rAz4NTMT5urYKAHIwZXZwDfOXMvHDu7I1taZWg3bQcpxr?=
 =?us-ascii?Q?S+vFIZJCmFSEpFp/AyvAJYCORWEFlEALXE6pgalJZiB6ghekQDFq7dZnqdJw?=
 =?us-ascii?Q?8yl8JwNLNEMZEZA42JdGgyGpBKp9P/5U5xVBobpkxvJJ+02zMNgmDM4LZ3s7?=
 =?us-ascii?Q?mqQ4O0S2CJdUtJyYiMmWE0VyBQ3NqJ3wwrKdYdn4DBtY9fZ8MHcHOiQNV/GB?=
 =?us-ascii?Q?8wKbQQlwdIST59jle4uoHKpYGEs1itYF234ah9wdYDtV+s3pqH7ZiHvd9DtA?=
 =?us-ascii?Q?RPygJ+uCavH6olAx5Dohk66HVrzmrlpxcSZ1++bXc26CAlYV/8f4x0WOQrC4?=
 =?us-ascii?Q?XbqkrdlXYm7iIUnjzC3Sn8btM0JPWtN2wQh2yAtMmM0/E0/SvgRa4CAOKne0?=
 =?us-ascii?Q?YG6dpE9Gw51bJeVQJ5i0ufyVRtuP3YwAzcxgSxNP/lgEUsMr6g8KV8jKeHlU?=
 =?us-ascii?Q?nA8Cy5Ux2GDAUYwAW+ajlTc2CwBrGtU+RSQiSULEa8MRuh1l0nG3xRo/o6ng?=
 =?us-ascii?Q?pw9Lj7tONmjDBs1tc7TZyUvF1rVVN2ojIwTRXs0K33qYtrsDv+DVBhyh7u/C?=
 =?us-ascii?Q?mvUopTWuHIFieTxRoMw0DB9n/3axGiH9t6nW02hQUF5YnwH45MI2yG35cSte?=
 =?us-ascii?Q?bfUwJjbEMfCp+cYXPoxfbylcB5E2jvrPaOFw4JD2TNOWI6c1eYk7SeOt1Ygk?=
 =?us-ascii?Q?24T2aqdaBV0OhuWbnnb5TqM4dnevHg/zQTB2ilQg0Cbs0VQmIy7B1LT1Uint?=
 =?us-ascii?Q?Wu5oyC24h4V3sj+oBCXQgShayM4ZnkEZW0XtmToUfrc1FHs3HmEjcwG81CsJ?=
 =?us-ascii?Q?bYkukM9tpru349PSpd+YMNuSDEJOl83tq5kRozWzz2RqqbkmTqsuqyUgBHCp?=
 =?us-ascii?Q?WpnAOlXZKFoL4+2uYQ36rF/0BavupSZoiSgR8sNkhr4iIRXkNW5GNgKJZ11v?=
 =?us-ascii?Q?5tF6X52DQykVslRJMyGX5BeLgjKr6P7JdTuiKjKIW7VqFyA2XDlFz/5gGC8D?=
 =?us-ascii?Q?vyvotnW3/2VLQliLbR8XuJtbMnMX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 13:49:07.5921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5388180c-c1a6-436c-8e12-08dc6dd34cf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6851
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

This happens when the amdgpu_bo_release_notify running
before amdgpu_ttm_set_buffer_funcs_status set the buffer
funcs to enabled.

check the buffer funcs enablement before calling the fill
buffer memory.

Log snip:
[    6.036477] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.
[    6.036667] ------------[ cut here ]------------
[    6.036668] WARNING: CPU: 3 PID: 370 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1355 amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
[    6.036767] Modules linked in: hid_generic amdgpu(+) amdxcp drm_exec gpu_sched drm_buddy i2c_algo_bit usbhid drm_suballoc_helper drm_display_helper hid sd_mod cec rc_core drm_ttm_helper ahci ttm nvme libahci drm_kms_helper nvme_core r8169 xhci_pci libata t10_pi xhci_hcd realtek crc32_pclmul crc64_rocksoft mdio_devres crc64 drm crc32c_intel scsi_mod usbcore thunderbolt crc_t10dif i2c_piix4 libphy crct10dif_generic crct10dif_pclmul crct10dif_common scsi_common usb_common video wmi gpio_amdpt gpio_generic button
[    6.036793] CPU: 3 PID: 370 Comm: (udev-worker) Not tainted 6.8.7-dirty #1
[    6.036795] Hardware name: ASRock X670E Taichi/X670E Taichi, BIOS 2.10 03/26/2024
[    6.036796] RIP: 0010:amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
[    6.036891] Code: 0b e9 af fe ff ff 48 ba ff ff ff ff ff ff ff 7f 31 f6 4c 89 e7 e8 7f 2f 7a d8 eb 98 e8 18 28 7a d8 eb b2 0f 0b e9 58 fe ff ff <0f> 0b eb a7 be 03 00 00 00 e8 e1 89 4e d8 eb 9b e8 aa 4d ad d8 66
[    6.036892] RSP: 0018:ffffbbe140d1f638 EFLAGS: 00010282
[    6.036894] RAX: 00000000ffffffea RBX: ffff90cba9e4e858 RCX: ffff90dabde38c28
[    6.036895] RDX: 0000000000000000 RSI: 00000000ffffdfff RDI: 0000000000000001
[    6.036896] RBP: ffff90cba980ef40 R08: 0000000000000000 R09: ffffbbe140d1f3c0
[    6.036896] R10: ffffbbe140d1f3b8 R11: 0000000000000003 R12: ffff90cba9e4e800
[    6.036897] R13: ffff90cba9e4e958 R14: ffff90cba980ef40 R15: 0000000000000258
[    6.036898] FS:  00007f2bd1679d00(0000) GS:ffff90da7e2c0000(0000) knlGS:0000000000000000
[    6.036899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.036900] CR2: 000055a9b0f7299d CR3: 000000011bb6e000 CR4: 0000000000750ef0
[    6.036901] PKRU: 55555554
[    6.036901] Call Trace:
[    6.036903]  <TASK>
[    6.036904]  ? amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
[    6.036998]  ? __warn+0x81/0x130
[    6.037002]  ? amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
[    6.037095]  ? report_bug+0x171/0x1a0
[    6.037099]  ? handle_bug+0x3c/0x80
[    6.037101]  ? exc_invalid_op+0x17/0x70
[    6.037103]  ? asm_exc_invalid_op+0x1a/0x20
[    6.037107]  ? amdgpu_bo_release_notify+0x201/0x220 [amdgpu]
[    6.037199]  ? amdgpu_bo_release_notify+0x14a/0x220 [amdgpu]
[    6.037292]  ttm_bo_release+0xff/0x2e0 [ttm]
[    6.037297]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.037299]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.037301]  ? ttm_resource_move_to_lru_tail+0x140/0x1e0 [ttm]
[    6.037306]  amdgpu_bo_free_kernel+0xcb/0x120 [amdgpu]
[    6.037399]  dm_helpers_free_gpu_mem+0x41/0x80 [amdgpu]
[    6.037544]  dcn315_clk_mgr_construct+0x198/0x7e0 [amdgpu]
[    6.037692]  dc_clk_mgr_create+0x16e/0x5f0 [amdgpu]
[    6.037826]  dc_create+0x28a/0x650 [amdgpu]
[    6.037958]  amdgpu_dm_init.isra.0+0x2d5/0x1ec0 [amdgpu]
[    6.038085]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038087]  ? prb_read_valid+0x1b/0x30
[    6.038089]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038090]  ? console_unlock+0x78/0x120
[    6.038092]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038094]  ? vprintk_emit+0x175/0x2c0
[    6.038095]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038097]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038098]  ? dev_printk_emit+0xa5/0xd0
[    6.038104]  dm_hw_init+0x12/0x30 [amdgpu]
[    6.038209]  amdgpu_device_init+0x1e50/0x2500 [amdgpu]
[    6.038308]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038310]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038313]  amdgpu_driver_load_kms+0x19/0x190 [amdgpu]
[    6.038409]  amdgpu_pci_probe+0x18b/0x510 [amdgpu]
[    6.038505]  local_pci_probe+0x42/0xa0
[    6.038508]  pci_device_probe+0xc7/0x240
[    6.038510]  really_probe+0x19b/0x3e0
[    6.038513]  ? __pfx___driver_attach+0x10/0x10
[    6.038514]  __driver_probe_device+0x78/0x160
[    6.038516]  driver_probe_device+0x1f/0x90
[    6.038517]  __driver_attach+0xd2/0x1c0
[    6.038519]  bus_for_each_dev+0x85/0xd0
[    6.038521]  bus_add_driver+0x116/0x220
[    6.038523]  driver_register+0x59/0x100
[    6.038525]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[    6.038618]  do_one_initcall+0x58/0x320
[    6.038621]  do_init_module+0x60/0x230
[    6.038624]  init_module_from_file+0x89/0xe0
[    6.038628]  idempotent_init_module+0x120/0x2b0
[    6.038630]  __x64_sys_finit_module+0x5e/0xb0
[    6.038632]  do_syscall_64+0x84/0x1a0
[    6.038634]  ? do_syscall_64+0x90/0x1a0
[    6.038635]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038637]  ? do_syscall_64+0x90/0x1a0
[    6.038638]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038639]  ? do_syscall_64+0x90/0x1a0
[    6.038640]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038642]  ? srso_alias_return_thunk+0x5/0xfbef5
[    6.038644]  entry_SYSCALL_64_after_hwframe+0x78/0x80
[    6.038645] RIP: 0033:0x7f2bd1e9d059
[    6.038647] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
[    6.038648] RSP: 002b:00007fffaf804878 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    6.038650] RAX: ffffffffffffffda RBX: 000055a9b2328d60 RCX: 00007f2bd1e9d059
[    6.038650] RDX: 0000000000000000 RSI: 00007f2bd1fd0509 RDI: 0000000000000024
[    6.038651] RBP: 0000000000000000 R08: 0000000000000040 R09: 000055a9b23000a0
[    6.038652] R10: 0000000000000038 R11: 0000000000000246 R12: 00007f2bd1fd0509
[    6.038652] R13: 0000000000020000 R14: 000055a9b2326f90 R15: 0000000000000000
[    6.038655]  </TASK>
[    6.038656] ---[ end trace 0000000000000000 ]---

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index b2a83c802bbd..ecd0cf6cdd2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1371,6 +1371,9 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 	    adev->in_suspend || drm_dev_is_unplugged(adev_to_drm(adev)))
 		return;
 
+	if (!adev->mman.buffer_funcs_enabled)
+		return;
+
 	if (WARN_ON_ONCE(!dma_resv_trylock(bo->base.resv)))
 		return;
 
-- 
2.25.1

