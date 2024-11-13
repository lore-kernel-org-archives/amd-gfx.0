Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10609D637CC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 21:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE94410E6C3;
	Wed, 13 Nov 2024 21:45:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gbes3DoO";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2642F10E70A
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 21:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RizJ0GjF2pGP9SAVHTt16G4KMaGWwCBaq5W/uVro0Hlyl0HdmgOIoA8BYa+GO4r2CjrIv55uPFEv3XI5Jq08poJAUPC5QSVzNg9SAx3yk6B9O7xYm3K/BXGeCif6EP73W/PiTtn36M0u03sctii1V/9qpdrxIiYjTMJ7mb/abtRQ6XVEfwsxQMONSkt/HdV9TznKT6RZox5Ef2UqXWiW5H/V6G9/SwcdsGxhYQA72IWaZz7+jpI2dY517R7XRm9fX4ifjmqQQyOpcTGGYiZckX8v6v/O6qtyCbWrW8AfbRSznPaANTCicnv3IBBcTmxOcoK8LblifjDXivNxl/Y6hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bagrpZaNFokNd26V9F4DLu65rdrzVNF5bDwIVkG7wKs=;
 b=UVtEJTBwF7rBk0Ib17oNXh4hPwMTM35X7/oChyhLCMXZwgOiH+U9uP3FbRvFJyu+PfKOeOnS37RYjG3KFvbA0lThapMAmyoDA00OWxVj37lnotRT72xCHtfqjQDgQsujvrYA9cACOlVc7y87kqlRaG1esl+HprHB6VXctK7dpb/kW6yk1ohpMYWQdBxcZvqqqt/HROqbMpQeR1hOTr5pVXG6TfTnxXE6ikQHM2j1woXbA7P1tXdOehCrBvAn/DJs5Pdhd2ROWH9qzgTthDCBAS27mAySK5V2mxUCwo7azBLRuKaxXHtVQ/JYJh6yHRbd95x06oiCw9b6eAbP13ilYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bagrpZaNFokNd26V9F4DLu65rdrzVNF5bDwIVkG7wKs=;
 b=Gbes3DoOYgLciCeFc2ApxhuLYta4WC6nH8hLyCgypCVWQpVcy6bdgAHdYnt1oJ21wcv5mWO6T8X+GkJ8EB4ek2B955QF/TG5JMEZTJnkFl2zklx8NFbqop9eUfxuSl4GPHqePPWd0eFNs6tRRns2qORHo9oOU3CPmXcXQV9O6XE=
Received: from SJ0PR05CA0174.namprd05.prod.outlook.com (2603:10b6:a03:339::29)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 21:45:14 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::d4) by SJ0PR05CA0174.outlook.office365.com
 (2603:10b6:a03:339::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 21:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:45:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:45:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jesse Zhang <jesse.zhang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Tim
 Huang" <tim.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/15] drm/amdgpu: fix warning when removing sysfs
Date: Wed, 13 Nov 2024 16:44:39 -0500
Message-ID: <20241113214453.17081-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113214453.17081-1-alexander.deucher@amd.com>
References: <20241113214453.17081-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: fef1aab0-0f36-4bc7-a9bf-08dd042c74a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDZKalF6Q3FPTkRqVEFYQkZqK0htd0p4anc3TXdPb2ZrcTh4TnczK3BNSDNn?=
 =?utf-8?B?TEZkWC8wYVpVb2xmbmZmaUQrVUpqbGZ1SFQ5SGY1NzRKcXB6U0RNTUZOYmNn?=
 =?utf-8?B?OUxyTkFtNzZXQ3dBWFdNUnJETEZVTjZwUGxaT2d5UzhJanNJRk9nNkhNd0M5?=
 =?utf-8?B?SGZRQ2NEMkwvaGdrSDlTRHdCYVV0SHdWanRSUENaYTYvWlV2bXFnM2xZSEFI?=
 =?utf-8?B?NlYyVG9zcXNGdnBNNiswNVJtM0k5dG11VUtyTTV3T20xc2xjc2hjZXFzT2dl?=
 =?utf-8?B?MXdyUE1pZXFLcjFLWWQ4T0tzbXZ5RXltTmRkY1Z3cHQ4R29jYU4waWhrVXdN?=
 =?utf-8?B?LzE3NmFsQjJIejFDV0R3Mmw3bllhd3dqWlhKMDkzTjdtZFNuMGJDWXVZQkFD?=
 =?utf-8?B?WHNsNk91UEdNUFROZjZkWjdjc0hjcWo5eFczVHB4ekRjajE1Yk5YUW1PSytU?=
 =?utf-8?B?UGNqbk9QYXZPRS9rcENIWmExU3Y5Rm41T1liSEU4U0F6bm5pSm1lZi9LVW5F?=
 =?utf-8?B?VE9kMlExWmJsZkVrU2VQOGI0RkFFY0VUYlNhTFB4RnNJaHJMQmc1QU5obGZZ?=
 =?utf-8?B?TWV6anprdEtyMzk4U1FHU3YrV3ZUOU1JNzdYd1c4YmVoZ05GRzl2bWRIN3NM?=
 =?utf-8?B?UzBXcDZ5V21Fdy9OS2M2emxsbVM1S2l5ZjNMb09GT0c3K0VUYVZ3MXQwaWJT?=
 =?utf-8?B?UEJqSTg4eFVmRHQ3Q2ZBTWswSXlUaHRlQlRaNHJXRnRyckF4MGZRemhadnQr?=
 =?utf-8?B?YXBPdUhFWk9qdlhMZU9mT3NnTnc2Z2lvTEx5enJ5SmsvcVl6NkJNQjlFN0FW?=
 =?utf-8?B?ZjVTTkVKQ09OMEhWeW43U0ptRXpZSHNCbVZLaHZvN01hQVppL1dYdVV3MWx2?=
 =?utf-8?B?d1NPa2JnakthWlo4SUFNTVAxQWhNOGVwVjJsckREeTVWMW12VWc0MHJnN3Bl?=
 =?utf-8?B?eEVDYWwxTTQzSlVaN2ZHTlVPbWJENWtQRUtTejJNekNsR2l3cXIxVHlkY2Na?=
 =?utf-8?B?TVN2RTFJNUR4TWtSZS9ha21ROXhRZnJUZFFYbDV2VHI0cEFvMmVLcGNxWjZh?=
 =?utf-8?B?NTYxQkx4MXRyVzkrY0wzejl5NDRSeE94cFFlTWkrMVhpdXNqcnRtampNS2xa?=
 =?utf-8?B?ZmFvc0h1VTFVOHFKSnFQZnV5QjJIUmlyY0tGSHBZb3k4WGFsQnhNUGRkQXB2?=
 =?utf-8?B?eWNJUiszZjQyZGEwVWxaOUJWVEhHL1daWTZvMWhMWlVScmh2M2xnZzVlQi9R?=
 =?utf-8?B?NkNMWnhxZXJjaGtKK1hSd084cDNFekVBcU1pTDVCYnZIaFhyNFMzNG9NWFh6?=
 =?utf-8?B?RVNaK0I5YmhDRTVDS2F6Rnl5dlc1ekhsd0M3UGtHQXcybWtackNtdTdROXlq?=
 =?utf-8?B?Q2FFaiswSXp3UXFtcDkvTFVYQnc2eXMwai9FbDZsay8remd6czE3ZGIxMnl5?=
 =?utf-8?B?TGVtY3NaY2tITFhRbVdvNTJpazlIOW5QZVkwTTlyYmpzdXozb3dSeVZ3OUQy?=
 =?utf-8?B?TDdkT0RiTkNIaVNIL0ErRnhMU2Vack9WM1h1N21KZE0xVkxPNVQzM2YrOG90?=
 =?utf-8?B?UHVPRCtkMldvQ1ArL0RzRzhPQVlMTktldkwwWXluQkdsVUxPdkk5b2VqanVO?=
 =?utf-8?B?WWk2dXhNc2s0aDc1NUc1bW16MTNyMThxdmFma1JwWXJTMlphRDJsdGhGdUtz?=
 =?utf-8?B?YWkyS0ZGVGU4Ri9TWk1jcTd0amhhbWJsRWErOEF6VzhLblRaWTBYSkxnM2pC?=
 =?utf-8?B?bFBOM3U5L3pxOGtveU9aTEFIRHd0N2xLLzdVZGRYTVJPekJXNzNwRmZYWHZK?=
 =?utf-8?B?SW1HZEg4eThXZ2g3dDA0bitkUUVmdERnOW1LcVNwWjgwZTV6UnlvU0pDMW1s?=
 =?utf-8?B?OEpFNVM5NUs1R2VpNkFrWUxOOEhoQVh3dVVPVklDMEc4OWc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:45:13.5973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef1aab0-0f36-4bc7-a9bf-08dd042c74a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830
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

From: Jesse Zhang <jesse.zhang@amd.com>

Fix the similar warning:

[  155.585721] kernfs: can not remove 'enforce_isolation', no directory
[  155.592201] WARNING: CPU: 3 PID: 6960 at fs/kernfs/dir.c:1683 kernfs_remove_by_name_ns+0xb9/0xc0
[  155.601145] Modules linked in: xt_MASQUERADE xt_comment nft_compat veth bridge stp llc overlay nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink qrtr intel_rapl_msr amd_atl intel_rapl_common amd64_edac edac_mce_amd amdgpu kvm_amd kvm ipmi_ssif amdxcp rapl drm_exec gpu_sched drm_buddy i2c_algo_bit drm_suballoc_helper drm_ttm_helper ttm pcspkr drm_display_helper acpi_cpufreq drm_kms_helper video wmi k10temp i2c_piix4 acpi_ipmi ipmi_si drm zram ip_tables loop squashfs dm_multipath crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 sp5100_tco ixgbe rfkill ccp dca sunrpc be2iscsi bnx2i cnic uio cxgb4i cxgb4 tls cxgb3i cxgb3 mdio libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ipmi_devintf ipmi_msghandler fuse
[  155.685224] systemd-journald[1354]: Compressed data object 957 -> 524 using ZSTD
[  155.685687] CPU: 3 PID: 6960 Comm: amd_pci_unplug Not tainted 6.10.0-1148853.1.zuul.164395107d6642bdb451071313e9378d #1
[  155.704149] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T, BIOS V1.03.B10 04/01/2019
[  155.712383] RIP: 0010:kernfs_remove_by_name_ns+0xb9/0xc0
[  155.717805] Code: a0 00 48 89 ef e8 37 96 c7 ff 5b b8 fe ff ff ff 5d 41 5c 41 5d e9 f7 96 a0 00 0f 0b eb ab 48 c7 c7 48 ba 7e 8f e8 f7 66 bf ff <0f> 0b eb dc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[  155.736766] RSP: 0018:ffffb1685d7a3e20 EFLAGS: 00010296
[  155.742108] RAX: 0000000000000038 RBX: ffff929e94c80000 RCX: 0000000000000000
[  155.749363] RDX: ffff928e1efaf200 RSI: ffff928e1efa18c0 RDI: ffff928e1efa18c0
[  155.756612] RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000003
[  155.763855] R10: ffffb1685d7a3cd8 R11: ffffffff8fb3e1c8 R12: ffffffffc1ef5341
[  155.771104] R13: ffff929e94cc5530 R14: 0000000000000000 R15: 0000000000000000
[  155.778357] FS:  00007fd9dd8d9c40(0000) GS:ffff928e1ef80000(0000) knlGS:0000000000000000
[  155.786594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  155.792450] CR2: 0000561245ceee38 CR3: 0000000113018000 CR4: 00000000003506f0
[  155.799702] Call Trace:
[  155.802254]  <TASK>
[  155.804460]  ? __warn+0x80/0x120
[  155.807798]  ? kernfs_remove_by_name_ns+0xb9/0xc0
[  155.812617]  ? report_bug+0x164/0x190
[  155.816393]  ? handle_bug+0x3c/0x80
[  155.819994]  ? exc_invalid_op+0x17/0x70
[  155.823939]  ? asm_exc_invalid_op+0x1a/0x20
[  155.828235]  ? kernfs_remove_by_name_ns+0xb9/0xc0
[  155.833058]  amdgpu_gfx_sysfs_fini+0x59/0xd0 [amdgpu]
[  155.838637]  gfx_v9_0_sw_fini+0x123/0x1c0 [amdgpu]
[  155.843887]  amdgpu_device_fini_sw+0xbc/0x3e0 [amdgpu]
[  155.849432]  amdgpu_driver_release_kms+0x16/0x30 [amdgpu]
[  155.855235]  drm_dev_put.part.0+0x3c/0x60 [drm]
[  155.859914]  drm_release+0x8b/0xc0 [drm]
[  155.863978]  __fput+0xf1/0x2c0
[  155.867141]  __x64_sys_close+0x3c/0x80
[  155.870998]  do_syscall_64+0x64/0x170

Check if the device is unplugged before deleting sysfs files.

v2: squash in mem_info_preempt_used fix

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c        | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c |  8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c        | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c         |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c         |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c            |  8 ++++++--
 7 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 3c89c74d67e0..c65feb97167d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -25,6 +25,7 @@
 
 #include <linux/firmware.h>
 #include <linux/pm_runtime.h>
+#include <drm/drm_drv.h>
 
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
@@ -1778,9 +1779,14 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
 {
-	amdgpu_gfx_sysfs_xcp_fini(adev);
-	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
-	amdgpu_gfx_sysfs_reset_mask_fini(adev);
+	int idx;
+
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		amdgpu_gfx_sysfs_xcp_fini(adev);
+		amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+		amdgpu_gfx_sysfs_reset_mask_fini(adev);
+		drm_dev_exit(idx);
+	}
 }
 
 int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 04eb51674596..29449d9f8e55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -24,6 +24,7 @@
  *
  */
 
+#include <drm/drm_drv.h>
 #include "amdgpu.h"
 #include "amdgpu_jpeg.h"
 #include "amdgpu_pm.h"
@@ -447,6 +448,11 @@ int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
-	if (adev->jpeg.num_jpeg_inst)
-		device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
+	int idx;
+
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		if (adev->jpeg.num_jpeg_inst)
+			device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
+		drm_dev_exit(idx);
+	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
index e8adfd0a570a..9a0346ed6ea4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
@@ -23,6 +23,7 @@
  * Authors: Christian König, Felix Kuehling
  */
 
+#include <drm/drm_drv.h>
 #include "amdgpu.h"
 
 /**
@@ -129,7 +130,7 @@ int amdgpu_preempt_mgr_init(struct amdgpu_device *adev)
 void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
 {
 	struct ttm_resource_manager *man = &adev->mman.preempt_mgr;
-	int ret;
+	int idx, ret;
 
 	ttm_resource_manager_set_used(man, false);
 
@@ -137,7 +138,10 @@ void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
 	if (ret)
 		return;
 
-	device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
+		drm_dev_exit(idx);
+	}
 
 	ttm_resource_manager_cleanup(man);
 	ttm_set_driver_manager(&adev->mman.bdev, AMDGPU_PL_PREEMPT, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 8c89b69edc20..24e9daacaabb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -21,6 +21,7 @@
  *
  */
 
+#include <drm/drm_drv.h>
 #include <linux/firmware.h>
 #include "amdgpu.h"
 #include "amdgpu_sdma.h"
@@ -448,9 +449,14 @@ int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
+	int idx;
+
 	if (!amdgpu_gpu_recovery)
 		return;
 
-	if (adev->sdma.num_instances)
-		device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		if (adev->sdma.num_instances)
+			device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
+		drm_dev_exit(idx);
+	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index c813dc94a7bc..b4a550795470 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1315,6 +1315,11 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
-	if (adev->vcn.num_vcn_inst)
-		device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
+	int idx;
+
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		if (adev->vcn.num_vcn_inst)
+			device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
+		drm_dev_exit(idx);
+	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 74e671c74142..fa0fd784dd13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -904,8 +904,13 @@ int amdgpu_vpe_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
-	if (adev->vpe.num_instances)
-		device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
+	int idx;
+
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		if (adev->vpe.num_instances)
+			device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
+		drm_dev_exit(idx);
+	}
 }
 
 static const struct amdgpu_ring_funcs vpe_ring_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 483a441b46aa..54c05af2eed2 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -20,6 +20,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
+#include <drm/drm_drv.h>
 #include "amdgpu.h"
 #include "df_v3_6.h"
 
@@ -254,9 +255,12 @@ static void df_v3_6_sw_init(struct amdgpu_device *adev)
 
 static void df_v3_6_sw_fini(struct amdgpu_device *adev)
 {
+	int idx;
 
-	device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
-
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
+		drm_dev_exit(idx);
+	}
 }
 
 static void df_v3_6_enable_broadcast_mode(struct amdgpu_device *adev,
-- 
2.47.0

