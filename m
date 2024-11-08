Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB42ED5E14B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 10:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8192410E957;
	Fri,  8 Nov 2024 10:05:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yrPbTz/n";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F64B10E957
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 10:05:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fv0kjplNVguLDfHQckAjCeuwzGwvWDyjhlDcmKInsyqgmePvbAaUEg/4uhpch/mWF58gyb3I1HxqibmfRJ7sJVj+KKGHPg9tEhnax69IKuUMxHvkv/eJ+jw2vzG0BKrkyvB57X7KC4DlB2xLvWZ4qeNUO9awaVy0AdtJJvSQ09/oCueyWTl94N6p4ltt2UejTU2X8VgSDF0ozvrytUj9H5DKzcl9RwCuZapyzxDeZgRCbZqEa6Y6VAoWKiUhNq8F8xpXT3PjvRuqfabzVc5HV8nBOV/5NStbf/gQ9VCS+cnv+pap+csdJOSPRzz7QN31cYAY5D0s9llTaGiFv24Rrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfezss0TKV2xGP3z7KbV9+uUyoN00AiyaNq/EdYHwaI=;
 b=n9cOGsDMrS1DaUgEAykDX1hKTuD4TJTbPX2ERjQa8He3nn++uMolTU3POMyIdDyf0H3j+gAbf6RJV5rC+dkyTfunC/CCtyM3U/5bEE1YGwCKcgkuTo+UvtSnoHsrhEqeifg6/ib/dafICifIU42YPdVdVgu3dsvDQcPJXK7qcOg0imnRhvELI9LIwiJm8mi7/r1am0tsijywwG3EHS5dZtGyBmDizCpfCZhljAw9xvYYdXMkx2Mr4LEJViv9NiTkRu0buOJVcbBh599jzPM+QQLOS9QsoAm05+vd6l15D+ruRXosJtfGneaJpebJGOOsbW9807BOLM/ksypxuxgogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfezss0TKV2xGP3z7KbV9+uUyoN00AiyaNq/EdYHwaI=;
 b=yrPbTz/nNxI7WDFsNid3mCk9tHkJitv2ToekRxq2H3VfFZYOBotmte92hfo4hLzmnCh5uFK89cvai0HczGyPdtQpUjVPQbKAdWxmOtifdOCcd/sp1XX/dFy33NNIKOcc1BO/hf4Kg4u2rzBzLjWqRovEXu5fNlcjvQEh4Bg0lcU=
Received: from CH5P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::19)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 10:05:21 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::29) by CH5P221CA0006.outlook.office365.com
 (2603:10b6:610:1f2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Fri, 8 Nov 2024 10:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 10:05:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 04:05:20 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 04:05:20 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 8 Nov 2024 04:05:13 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <vitaly.prosyak@amd.com>, <Tim.Huang@amd.com>, <lijo.lazar@amd.com>,
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, Tim Huang <tim.huang@amd.com>
Subject: [PATCH V2] drm/amdgpu: fix warning when removing sysfs
Date: Fri, 8 Nov 2024 18:05:12 +0800
Message-ID: <20241108100512.1044795-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: 60716365-f38c-4de2-5995-08dcffdcdaf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g4DxBkvMFR4K3kxl7q98Vswe4U44+oIsmbvp1nssPOCcqTjN6NzuZVlpx/Ed?=
 =?us-ascii?Q?3HcCLHqwUPoPoWiWuwlLx+njrS253CGUsJAgC8Si+mMZXQncok8xMdsGSapF?=
 =?us-ascii?Q?t+FZmHmlfvG2odVG1D4JgLwOCK6MATkWdjLp0okC3EHWwTnOuhpJWE5ey5N4?=
 =?us-ascii?Q?ePdqLeIzudF0z1+VEXE2fFs1dntM9rKmS1bmvEGZzhucyQUlXVqWVJi+WtPK?=
 =?us-ascii?Q?GaXYyq1mJdu0aYR2CsW1borEy5BNirrCB9DQ9Qa8nt/rF7ptf4ZmGpDZDq/O?=
 =?us-ascii?Q?XubTu7gfcVcV61DVjHs9hC3GYKpPRC5gyjyszy4zv/3BdICgSdxWfb/zbZ59?=
 =?us-ascii?Q?BMMg9n0bLwimXReImVGfJlzYgZdyLY6gZ2/Tp8KiWTxUSxFen0M0MY1Eu/gp?=
 =?us-ascii?Q?Wc/2yuYx2MRXrXpvyRINGjt58M5ctJMQJVQI1r+TU1xsy6i0DMwON8OHiFB6?=
 =?us-ascii?Q?N3VcW1J7h2X/UeB8ZqfIoMLTpjv/CxYgw2GMEkChiHXsQ2OjHdG6QhKZS+gf?=
 =?us-ascii?Q?ATXOvOO3djaDuJpFhJ1bxOHFzOMlK4CNOALvr5Ty9JgsfaX1ikVjyn1MdyN9?=
 =?us-ascii?Q?ZHy5Fq0km6i1pZUFIyYzuJqLqTdr+L/qbrhy4lqXtCzqyCwgMnQg6d7T7P6A?=
 =?us-ascii?Q?wSy4/U9KX1g2uPIlMhEQPyVK3JnqSn17UQIiPdQeGVCvr890fTWxOMNCXyfJ?=
 =?us-ascii?Q?J9IQ1LI0CvRl35mil4KRbXcTudldndN45ZcfH4YdQjkjOlQIixql20SxaDVk?=
 =?us-ascii?Q?lrUobL4i3w6dRWyA8xWzM8wUfAo6loI/7wKSFMaYHDCd+JekD+oEk8JUc/uN?=
 =?us-ascii?Q?Yb1oxUDgg+03epTxbjPi1MXyE+KIZmMb2LNPt797w2HnRbG4jZ6Mmfg4XsuE?=
 =?us-ascii?Q?5ZwniU0zN3YkxNrlJenCoZ2mKDdfLopEOTLqatu0V8qU4FzXU3ppfuxYIGAi?=
 =?us-ascii?Q?hfy3kUk1rdzQOYctYOcuRu7eje4uhd2CgzUYh4YVjKPejsN/uQ14NMZX2hV+?=
 =?us-ascii?Q?uFez4rJjDX2gpmblF7Rb8P3xeKe2IeYcGWzYSS8n82+rDiIxO/jKXwK3TmMm?=
 =?us-ascii?Q?yaB9xSdtwlTa2KHiOazj3PNz/zo7yPb8ItbZs67B2vrCcsiR2meACmFbJ/MS?=
 =?us-ascii?Q?+iEDiyYsN7C5Z5CryaVYN9d+P3bN3whRjRFBbjrvt0zl8rJ006HTqJ4EBujZ?=
 =?us-ascii?Q?3bbkbAc4MN77NAGWh4tVPqBzc66ICqd2p//5Vsw2XttqV4/dSyTTA5qu8GpX?=
 =?us-ascii?Q?Ob0TmbM4TCvlsDa+CC1/bAfuMuqCP7Ej1jq4d6ZXCvLjmmYBYpb4CsNdO7ZW?=
 =?us-ascii?Q?LGNoqV4PCnPP8R9R7rdqLrAxAwWAgbHqpjgQx9IJr39pRSYmmmNC7GNDRSL5?=
 =?us-ascii?Q?YCtF4zN14b3u9MnauHdf/02uT+vq9B4eSgot7h1j/0opCDByHA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 10:05:21.0205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60716365-f38c-4de2-5995-08dcffdcdaf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610
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

Check if the sysfs directory entry exists before deleting the sysfs file.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Tim Huang <tim.huang@amd.com>
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
index f7bf5e43f16e..f552d7dfae96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -25,6 +25,7 @@
 
 #include <linux/firmware.h>
 #include <linux/pm_runtime.h>
+#include <drm/drm_drv.h>
 
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
@@ -1773,9 +1774,14 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 
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
index 642b8c848141..2a8d8e5cc7eb 100644
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
index e8adfd0a570a..33a714ddfbbc 100644
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
+	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
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
index 67264f0be491..1481c36ac663 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1320,6 +1320,11 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
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
index 02bda187f982..b5f5a1a81c29 100644
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
2.25.1

