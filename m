Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FE2D4335C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 02:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C904210E009;
	Fri,  8 Nov 2024 02:24:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="03CIbJUB";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D64E10E009
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 02:24:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbJ1NmgwCIHgB5Xai3WtS3trqOssMjb2wvXg9Z4DQTwTKMc2akMaSEN9GwlGMo8drpDypQpC58yH9EEPQnD+jFzSXogiHCENw08YlogwWkR+In6+KXtXZ91WNcASKQLTgcA5zVOsK3gjtpTXqZdIgFyXLX/ZBwVUVNDkM4kvT9q/5D5yXn4MNhe6ed+tFBK9d8nHAM4e+2VasqHXwBj2AKfF0laNVvZZZMTJ7E59eMOhXjm9JRz57i/ga8l4QSXy0o8d6D0WBLUvt+tMvY/T7JY4zrf5AkNFFVOrVz8CXUMZY7sGC1MeT9StOOuBYWgXSF3dzing0zTIHdBb3gig/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEQ2rijwldLL1JoG5RqsvbaS/h3EmeREJFRlR/EOB4E=;
 b=DGGX23fOAJvyG/10fRdIeoJt2jj0VWXzShJ6oUR5/lQc5//tmM2FTPVVHUAcj5bjemmBWFXSu5AWDRKbLYpTAwgM7lozrhxCG8MJ5+pEe9wq0/4COXo18LTBFGasU7xSORlKlNO/dD94dHAjeu4bExjhl2BbBjOMn5oyu2V1aiX/EOb5PXjEK+J8/yJftwhSfEMhPyHsOoB+Azu3JBzrzSmD18Zk7TvsXaerXSjugVU7D8zA8FKE4i8PyASNz6lHaV+63qi/OF1Zbfk/wgCmlZxO/4aPazOWIQ5IraYVQywoj8YahT6IyrJHap9xHNCEoZJjPb1js/eFz7IH+WaSAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEQ2rijwldLL1JoG5RqsvbaS/h3EmeREJFRlR/EOB4E=;
 b=03CIbJUBFu2Bx3+O2O7obrJyuTb4RxGaj+ZcuzYFYDL/PH3bIsIl3qwkIQJUmBh8YhHJ38/Q7bIqJGFuPAm/fJdUFSswDfLsdqIGozKgRfB1PIj0ixrBxALnQSDIsTUt73+JZn/sRSao7ab+RWfzgAr52WBAiaRR+9sm7rw26gA=
Received: from MN0P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::7)
 by SN7PR12MB7179.namprd12.prod.outlook.com (2603:10b6:806:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Fri, 8 Nov
 2024 02:24:18 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:52a:cafe::ed) by MN0P221CA0001.outlook.office365.com
 (2603:10b6:208:52a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Fri, 8 Nov 2024 02:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 02:24:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 20:22:23 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 20:21:55 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 7 Nov 2024 20:21:48 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <vitaly.prosyak@amd.com>, <Tim.Huang@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix warning when removing sysfs
Date: Fri, 8 Nov 2024 10:21:48 +0800
Message-ID: <20241108022148.588761-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SN7PR12MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc6983e-6cfd-4dff-ec74-08dcff9c727f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UQrqTQdAFQTMaHcqSvpF2yTEaAfAuH3EiPwPLWRqLylu36G7Wkefi8mONlx1?=
 =?us-ascii?Q?ztGXThxaCFyA03JA2KY9TIkkC9Axr0iin6L3Iv3sTC5Y+KRHXId5PIlFVN/w?=
 =?us-ascii?Q?MJ6bZJ6IptiGoVYFan10uPXCVv+AHU0qjCXTS7mK2WVh2W/TvtrLUZq2MNGr?=
 =?us-ascii?Q?hZESH3qlRBvZx7bnNJ5M41ocY0rkP+gvrqMH5G4f5+FbHUuVjFVRtn7bHJu/?=
 =?us-ascii?Q?fAb24NF13XWUp7d3iD3P1kxlVq5BZgkKzMvT6vMf2lvF9UfoHOyxLI2e094F?=
 =?us-ascii?Q?6D6a6mp6izcLKxVA2ZVRTGkvfgDMDWrcSRXJTOfY5rz29pnmJiuSqYhiLcfX?=
 =?us-ascii?Q?Euo+SEpq32kPidiqh9dc67OI31FMh8L81L7B9J5GucgHdm9MLfxotikKbLCX?=
 =?us-ascii?Q?O1/7B9fao4be+aevU+d8iIiIh8c5MzFKt+O+2CKEdrAI+yZchNGwgXP2Qf3l?=
 =?us-ascii?Q?eWPvdCZlUUuWl5sO1vuLAcFTCxR2DLckN27MvExjIuY04HirbxlkmAZnoJow?=
 =?us-ascii?Q?yYh4aeGT6OnKxnY3SGnQdgnqSkh/veTMPVISvhWSHHLumdpSBnDOy8aCSyPa?=
 =?us-ascii?Q?xi3yuOT4tcM9QdQBHJ/CPjpS6sl86qY+StCgJWgvLH9yoRe54F7j4OXeRv5A?=
 =?us-ascii?Q?eIXikOUT6IzwhubVy9D9kDJ/bTyxD18CMWfnbZ7ZBPUg/ivbCcQ9raiH2/mY?=
 =?us-ascii?Q?udKlyoRhkAsnpYlDSpbH2SLJ6q0OcO4ntc37uaLFLnn/3G9svCj+/BTg5x7d?=
 =?us-ascii?Q?8uAcnfbwERJVwuNNiXCpVfwWsQGyeybI156JNp+JzWuBdkK/shrMI88JMx1c?=
 =?us-ascii?Q?lSINySpnE95MuiE3Yl6udXMpPbyLXnEKgRVWg56wiyUEoLLJy1zeTlGy1cYO?=
 =?us-ascii?Q?6YlXf9b6O/jZZ+KqKZVz4NWvEDwIBCEqSPNviAE/UK8xfNp27I0lK9H9Tmj5?=
 =?us-ascii?Q?7JKxQIoqgT0L+qxTu9tbQhxSxnDZ5+u9Z2KLOcA2tna8mYvkmRBqSqBvOFQo?=
 =?us-ascii?Q?XWDiN73dXf6rqARTHYyTFRkcGPKQ1CAEp7bPZ/WufKLcROfekVrlxFux/7t+?=
 =?us-ascii?Q?xgFeHUlOA3O34cTXM0u8g+BBuLGfIGpYz7HRwJcFnLnEJWeVXPwtJTMviVRQ?=
 =?us-ascii?Q?wqIQ21kmIMCgzsVPC5bi4RqhmbEB07rquJoyt0oTGZwBSNSSmJqyPKWLkjii?=
 =?us-ascii?Q?OvKVIZk8AcHv1bdA2cJ+JcPnFsy39OYwoooWoFBip9ykH3YxiyfFtDrHF+AZ?=
 =?us-ascii?Q?0K3Eq6tSTbF/yZg+c1/fUdpADHvW1CheBPcLbJXYstNfBb7XzBNhgy0++UfT?=
 =?us-ascii?Q?E78L+mOBE5rLL2+Mx3BUEX/nseo8AwZqFk/jBOb3lMe/txzLqK1DKvn0Kbre?=
 =?us-ascii?Q?aApMR4ksFuaPbKZqXesNaXLTb3bDadpjUIBisrezjZ/Sr61VpQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 02:24:17.8703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc6983e-6cfd-4dff-ec74-08dcff9c727f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7179
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

Fix similar warning when running IGT:

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

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c        | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c        | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c         | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c         | 3 +++
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c            | 2 ++
 7 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index f7bf5e43f16e..a9f40b28e030 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1773,6 +1773,9 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
 {
+	if (!adev || !adev->dev->kobj.sd)
+		return
+
 	amdgpu_gfx_sysfs_xcp_fini(adev);
 	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
 	amdgpu_gfx_sysfs_reset_mask_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 642b8c848141..257f4b712f00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -447,6 +447,9 @@ int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
+	if (!adev || !adev->dev->kobj.sd)
+		return;
+
 	if (adev->jpeg.num_jpeg_inst)
 		device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
index e8adfd0a570a..34b5e22b44e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
@@ -137,7 +137,8 @@ void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
 	if (ret)
 		return;
 
-	device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
+	if (adev->dev->kobj.sd)
+		device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
 
 	ttm_resource_manager_cleanup(man);
 	ttm_set_driver_manager(&adev->mman.bdev, AMDGPU_PL_PREEMPT, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 8c89b69edc20..5a595baebb50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -451,6 +451,9 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 	if (!amdgpu_gpu_recovery)
 		return;
 
+	if (!adev || !adev->dev->kobj.sd)
+		return;
+
 	if (adev->sdma.num_instances)
 		device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 67264f0be491..2b21b4e5c19c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1320,6 +1320,9 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
+	if (!adev || !adev->dev->kobj.sd)
+		return;
+
 	if (adev->vcn.num_vcn_inst)
 		device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 02bda187f982..2cd642761a3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -904,6 +904,9 @@ int amdgpu_vpe_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
+	if (!adev || !adev->dev->kobj.sd)
+		return;
+
 	if (adev->vpe.num_instances)
 		device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 483a441b46aa..bc7d380f4b0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -254,6 +254,8 @@ static void df_v3_6_sw_init(struct amdgpu_device *adev)
 
 static void df_v3_6_sw_fini(struct amdgpu_device *adev)
 {
+	if (!adev || !adev->dev->kobj.sd)
+		return;
 
 	device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
 
-- 
2.25.1

