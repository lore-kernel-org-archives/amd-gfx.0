Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C161D10F37
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 05:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF20010E24B;
	Mon, 18 Nov 2024 05:31:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CKn5etUj";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAFBD10E24B
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 05:31:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAGPb1Qr0SdcG+M2t9ctOgasJtOl/aabspQ9Tnt62jLXuV/V1Ou1g3ARb8jiIaD9yACYpPjToCUYEhgRQBDvcoj0zqGGyPDoDbF0aWyItHyNBxtjjUcbYNmkOzeY+icLAjiKUco+MNCsoYuHBANqYad12aAf8KsPna5MrHiQDb26veEC9kZ4/LvO+H0SCgWkvmwdHXaUZpd4umHaQLlFZY3sOxIuX+q8PFCzRhZaiFldIybJI+8h79eatMUUk4WgAU/7NHdmpR/F0LCEGmwfboNtF72pR55DZCjhaLyKfzE/YiehOrxIYuN+Ysy0t/1RDvK3xIeOUf4M5XAJ3Nd/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYYfmlgBKARb7Fw/5TG7fJwLLIUKizlTa2ngW5PwJyw=;
 b=s3NTHAse6tPn4LUg0nflELwL+6yaq11BDK8EK3r0SM9ZLD4hJ1k3pJsI1euHaHIXPVPlDoSJK9hkYkCQ9hbgpqhO7hX/yg5Cn0H98EnokOes0VjbBT+NBNZjoVRggTtFeGrWsjOyu8FFcZtsbrLCVtSc1PSQ1cje18IVZSrsk/YvbLy6/3ye2m50GzXx7IAbqpQVGhSoFMEO21Wy6DwBsw3BaJhFQeHltHddgEhY1cUfjoxQwpl61jD8rzOj3JFAHnO8i4GJklx+S2qbtEqvmB4AreBMylCBTFDITaWG7neuQqysK7X8I+XK+QIUvJwBQm8VnWDGbf+Lqdsv1xRHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYYfmlgBKARb7Fw/5TG7fJwLLIUKizlTa2ngW5PwJyw=;
 b=CKn5etUjBJMaVGYdI/xpay76v9hGA2/eV0AxXw2fLJYd8LWSCrKr5HUj3qvyaGM4sNhajR3NS3j4covYGsd6ProlA5Jk4Q52jLZH2JqtBZW9NhL993TsFtvvigaaFasWigALeEwpl8VJpIk5l5LMY2IX2gAdufvr24nznQem8is=
Received: from MN2PR22CA0020.namprd22.prod.outlook.com (2603:10b6:208:238::25)
 by SN7PR12MB7298.namprd12.prod.outlook.com (2603:10b6:806:2ae::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 05:31:35 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::e0) by MN2PR22CA0020.outlook.office365.com
 (2603:10b6:208:238::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 05:31:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 05:31:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 23:31:01 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 23:31:01 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 17 Nov 2024 23:30:59 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <vitaly.prosyak@amd.com>, <Tim.Huang@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>, Andy Dong <andy.dong@amd.com>
Subject: [PATCH 3/3 V2] drm/amdgpu: Fix sysfs warning when hotplugging
Date: Mon, 18 Nov 2024 13:30:59 +0800
Message-ID: <20241118053059.3836648-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SN7PR12MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: 85069bae-5a81-4a3b-c7cb-08dd0792446c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tixve9LnNKHWMpIy+8k2xBb3bzyrgtob3VFAYe/vc0557xihnbEd8GAmEoHI?=
 =?us-ascii?Q?UumJQ+Y2tJiSqovBLyki7rat7CdgvRqZba+wmk46aXCaK5OslZjNpUOnMxar?=
 =?us-ascii?Q?Z+8bfcEPY8gagPZ6SB2qYp/IVBZDDQIYxxLBHSHrQK9Mlpfl7iibjEmPfnPD?=
 =?us-ascii?Q?IqYlmMnA6CZ39hgoWwz01Qs06VNq9Vr9fmpHfUd7LmKyru+YWLOzIa6Qu1tK?=
 =?us-ascii?Q?kyyQqP7XI/CFJVkBtWDuQXie/UdipK31jLWEXMEw379ZsoM+1izT1VAs+f4z?=
 =?us-ascii?Q?qIldD37/yXlUSxQcDGJo12skzVnzBhbaSlidOYIkCb0sv337yg+4I5vONle9?=
 =?us-ascii?Q?h9YZ+L7kUFp3azS4Z1CEdXpQFOLbnhv0nPz7G/9DAE/iDEMnNV+cdVSp86QU?=
 =?us-ascii?Q?7bCz3vjTJ0eOfNi9x+hEvwP6FFD53LKRUpHb97+5FbKgZ5FFie+yS/1b2sTB?=
 =?us-ascii?Q?mpnLZxi5uRILjmuZ9GBsJhE6SRtl0AFYc4BXGHvpprtV0fXhNFHcVnJGruV5?=
 =?us-ascii?Q?MrNfXVBx6/j6D71nJQ4xgNpQvDRbfpN2HKPghTFqbB67o7IyxZ1MumGd+t/U?=
 =?us-ascii?Q?DOzyXixmZJv6e1nwvWyVBvaEqNE05zOx4U5BEcM3Sfab5y6O4qX867/XieT+?=
 =?us-ascii?Q?YjAB/NazvnfveiCAmBRb8AyLjmCwBGuF9WvBKj1XVxY0wuO1tD4VmJFGZk4g?=
 =?us-ascii?Q?XPNYeGco7enS2Y5koiNXHmcbOPZypzia4gzzNI0RjVMYLAvS4h/HNfkBFKT0?=
 =?us-ascii?Q?jJdciiOkGGAUQXcYfk84op6b9ueexCnzXarxdaGOPBdixS6kyVdrMWZS7/pG?=
 =?us-ascii?Q?KG/r+TAyXx+Gsm0jhjmMWCaQaUWa5IJsyLQl+ev9CKYdAB3UOnO71h5dCEqw?=
 =?us-ascii?Q?fhpb5Usepfad3nh1SsrDVMMIYydvKYEvzYho2QBxwA8jWGTV+gsq9YyeVrQX?=
 =?us-ascii?Q?j7KSklx8rXdGumv4ut+lnX+o+kjr3hc1ElfOqW1u3RfE79ZkEEaS72Tn6wvN?=
 =?us-ascii?Q?yIHZj5SFpMRrKHxyLHNGf9HJXXfB0+daQ4XPirgDtA2T/eYndPFpaeMcQN7C?=
 =?us-ascii?Q?K8dt9/jY8Se/9PJQRt+jU5vHHHZAzzCDTpzWPwXAy/tKcHE63/kaWnWAf34i?=
 =?us-ascii?Q?RsBb09aRZIUEOyS0QGShP0/4Xl1EgFmg3xRiB0QVOfuitkJbDxYwcxMqHxY8?=
 =?us-ascii?Q?UF9pP5YDtowHuqKgJLKp8CHsncsy3VEaeOWb/7BVMYE9tCawPFtE4gX3bOcl?=
 =?us-ascii?Q?pNbcOzOD+sIPtKgNqOGC6jEKUYrShq+yf+aanqe+1q8wN7UgaMAgWz98xhAW?=
 =?us-ascii?Q?Wdoq1nh9nM6Om54mFk4vu3C9mOm56YZ3N5n3fOuDTu590psFWamcm243YvgQ?=
 =?us-ascii?Q?m4KvOWpC/x9hK525yKBZrTBkivzaJ6lgpJc/OcIMzZMhaqbv4w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 05:31:35.0452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85069bae-5a81-4a3b-c7cb-08dd0792446c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7298
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

Fix the similar warning when hotplugging:

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

V2: Add details in comments (Tim)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reported-by: Andy Dong <andy.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c        | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c        | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c         | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c         | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c            | 4 ++--
 7 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 3c89c74d67e0..e54f42e3797e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1778,9 +1778,11 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
 {
-	amdgpu_gfx_sysfs_xcp_fini(adev);
-	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
-	amdgpu_gfx_sysfs_reset_mask_fini(adev);
+	if (adev->dev->kobj.sd) {
+		amdgpu_gfx_sysfs_xcp_fini(adev);
+		amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+		amdgpu_gfx_sysfs_reset_mask_fini(adev);
+	}
 }
 
 int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 43ea76ebbad8..9a1a317d4fd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -447,6 +447,8 @@ int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
-	if (adev->jpeg.num_jpeg_inst)
-		device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
+	if (adev->dev->kobj.sd) {
+		if (adev->jpeg.num_jpeg_inst)
+			device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
+	}
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
index 8c89b69edc20..113f0d242618 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -451,6 +451,8 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 	if (!amdgpu_gpu_recovery)
 		return;
 
-	if (adev->sdma.num_instances)
-		device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
+	if (adev->dev->kobj.sd) {
+		if (adev->sdma.num_instances)
+			device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
+	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 60e19052a1e2..ed9c795e7b35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1310,6 +1310,8 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
-	if (adev->vcn.num_vcn_inst)
-		device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
+	if (adev->dev->kobj.sd) {
+		if (adev->vcn.num_vcn_inst)
+			device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
+	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 02bda187f982..dc96e81235df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -904,8 +904,10 @@ int amdgpu_vpe_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
-	if (adev->vpe.num_instances)
-		device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
+	if (adev->dev->kobj.sd) {
+		if (adev->vpe.num_instances)
+			device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
+	}
 }
 
 static const struct amdgpu_ring_funcs vpe_ring_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 483a441b46aa..621aeca53880 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -254,8 +254,8 @@ static void df_v3_6_sw_init(struct amdgpu_device *adev)
 
 static void df_v3_6_sw_fini(struct amdgpu_device *adev)
 {
-
-	device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
+	if (adev->dev->kobj.sd)
+		device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
 
 }
 
-- 
2.25.1

