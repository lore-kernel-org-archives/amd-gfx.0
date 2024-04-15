Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8E6C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 19:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E9B10E664;
	Mon, 15 Apr 2024 19:49:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4TapLajR";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD9110E664
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 19:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXf77srJj//KA+g7gq6nM1m3ecJpiJ8ka5sJNkJ3mrnwFiZojGk+PstjccgjbTD11HyWitW0WbP1wfDFP3v68BBxMKvSy7tHBX0izSVCE3OBVmHFH+aSBwjL38Ys3KvOdK/iP4Vc+5nhWL46jo1cjnO6OuxxK837E/MFYZBdoMDKEpJ0FvNUJIx+6WOECnbwO1RlDoXgPW7hO/iVLC3m1z+CcY8a2ts2Ffob/WBPfo0L4GDTgxLYRL1YmSzB9BuBNqDkLQBxkLdo9bNhR8k+d8H9miIQZaFHit+2CN5mfNYCkRhEhi4iVz6SzaW1aXokYVWANjVr496aotfb03cf9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZxO9f8oqyBoaShvCOUs9N13/aicGaeTagdoSGMQp+4=;
 b=Sryp6yFRx0SVJTOuAckwvL/dAMD5OawjIIopXEXDy61pi06seFg6JOswwL6mtPK2IQOJ9mH6uR2J+VVRd7B33UywgWZZ1ZIp6C1Ri4J6yDdChTEHqw+3e5AgnvHsBDXTOTd7bB0R0CUMyUMhCfS+RrTJfQJjMGrHCJmGsFraQFXQZSKXdq18BFRzvN0GdXxPWRAh+bh4Mm+RomStlXnFcbcppx68R/83DUEJFU0GOweR+TuXtpeclRcGyeNHDo6RiX8Xgdqh7YhDQPImy8vAfww0QhKonuxwxgJgA/ohnbNQsDsHTXB/3eM9xJ8xzgkxYLzTNEUMI1p1IW7UMS8KWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZxO9f8oqyBoaShvCOUs9N13/aicGaeTagdoSGMQp+4=;
 b=4TapLajRPzKMV9i29fVWRKLi1xRV1giZCwlbXyuc10RMa9mK6r19Yli+ba9Wm5EY/hd5RIn2KhDJAzv5okX8B1wbXWnKV2GKfe3PpxX7i6PyfxujQQAY1l6uYT4ZYIy+d8ZINbT5WV9ZsAWX2CJNH7Kz1ZPkKgBTznzAiLUgKcA=
Received: from SJ0PR13CA0049.namprd13.prod.outlook.com (2603:10b6:a03:2c2::24)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 19:49:48 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::89) by SJ0PR13CA0049.outlook.office365.com
 (2603:10b6:a03:2c2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.19 via Frontend
 Transport; Mon, 15 Apr 2024 19:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 19:49:46 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 14:49:44 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] rock-dgb_defconfig: Update for Linux 6.7 with UBSAN
Date: Mon, 15 Apr 2024 15:49:24 -0400
Message-ID: <20240415194924.2181989-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: a2708da5-49dc-4a05-ec0f-08dc5d85345b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3io3iZTI0T/zAaRlvMAq5m18ZSSp9xw2m7OHqS955B6EK1vQcT3N+2jhx8yyfXEe7f/EKbUgMjTbduNQHyVPC/6OEuGOdr160K/MEqCnpfX1RdxWeuZeL2NO5Dl2u1ok/ZRZCsYg+KQMK+dlgGJaLQUUZsDioTl/qRuUdXwRFb0fX4Bt3eS+fy9S/L846PfZiR0lXphXSAdspMShxvdzw2y1UzcgNZh61VNRn8aHfX8c12u7rgiY+/o8NG2u4GK/4kU6uUVbEHLRIdgVhXknnzLPjVZhKtTi2GqSX+L0SaOeVgLN8VQfgpzHtrm6QCp0l8xnhQr1d2p4688np7/Ukt82wK6kU3vl08W5Ebeehtfsw7ARm9dycTZYSS6RBNBC47jEJgIBzDw6zEIFsjp7iFlgNda8phLqFlh1CdPKH94tZ9SGM2QW/6UWs74EsPN+yAfijjAtwc0Fw8wz8c/qya4NvOD784SRWcWkQAaoRZ5X4uEKDck8KuoyYy4fkhNkrxdUA8CXZzG+5wnrkPoMr/zJmZSmT2yPrzfwGoc4AXhhK2RHIVvreOcZVSzgFfbg/QsH0MYC18Gr88d1pVh7Bw6mCRxNqDGurtp0FhqADqgBqNQe7jM+1D72E4oPBorBaCyh+aBaCGcu/mLRxJGyCmj1mMd9qjdTUD3c6HCZUdgt1SJcs3tIoNapmkfxULRMWj4NwQmzYOwPlRQVG2y82ntODn3gkZdXoPBOvKBCNq1j8b5WbBmlu6gd1ONY11wA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:49:46.8834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2708da5-49dc-4a05-ec0f-08dc5d85345b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018
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

make rock-dbg_defconfig
make savedefconfig
cp defconfig arch/x86/config/rock-dbg_defconfig

This also enables UBSAN, which can help catch some types of bugs at
compile time.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 arch/x86/configs/rock-dbg_defconfig | 46 +++++++++--------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/arch/x86/configs/rock-dbg_defconfig b/arch/x86/configs/rock-dbg_defconfig
index 0ad80a8c8eab..80129ca354b4 100644
--- a/arch/x86/configs/rock-dbg_defconfig
+++ b/arch/x86/configs/rock-dbg_defconfig
@@ -34,11 +34,12 @@ CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-CONFIG_USERFAULTFD=y
-# CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
+CONFIG_KEXEC=y
+CONFIG_KEXEC_FILE=y
+CONFIG_KEXEC_JUMP=y
+CONFIG_CRASH_DUMP=y
 CONFIG_SMP=y
-# CONFIG_RETPOLINE is not set
 CONFIG_X86_INTEL_LPSS=y
 CONFIG_IOSF_MBI_DEBUG=y
 CONFIG_HYPERVISOR_GUEST=y
@@ -48,9 +49,6 @@ CONFIG_PROCESSOR_SELECT=y
 CONFIG_GART_IOMMU=y
 CONFIG_NR_CPUS=256
 CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
-CONFIG_I8K=m
-CONFIG_MICROCODE_AMD=y
-CONFIG_MICROCODE_OLD_INTERFACE=y
 CONFIG_X86_MSR=m
 CONFIG_X86_CPUID=m
 # CONFIG_X86_5LEVEL is not set
@@ -61,12 +59,8 @@ CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
 CONFIG_EFI=y
 CONFIG_EFI_STUB=y
 CONFIG_EFI_MIXED=y
-CONFIG_KEXEC=y
-CONFIG_KEXEC_FILE=y
-CONFIG_CRASH_DUMP=y
-CONFIG_KEXEC_JUMP=y
 CONFIG_PHYSICAL_ALIGN=0x1000000
-CONFIG_LEGACY_VSYSCALL_EMULATE=y
+# CONFIG_RETPOLINE is not set
 CONFIG_HIBERNATION=y
 CONFIG_PM_WAKELOCKS=y
 CONFIG_PM_DEBUG=y
@@ -74,7 +68,6 @@ CONFIG_PM_ADVANCED_DEBUG=y
 CONFIG_PM_TRACE_RTC=y
 CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
 CONFIG_ACPI_EC_DEBUGFS=m
-CONFIG_ACPI_VIDEO=m
 CONFIG_ACPI_DOCK=y
 CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
 CONFIG_ACPI_PCI_SLOT=y
@@ -108,6 +101,8 @@ CONFIG_BLK_DEV_INTEGRITY=y
 CONFIG_BLK_DEV_THROTTLING=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_BINFMT_MISC=y
+CONFIG_ZSWAP=y
+# CONFIG_COMPAT_BRK is not set
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
@@ -115,15 +110,12 @@ CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
 CONFIG_MEMORY_FAILURE=y
 CONFIG_HWPOISON_INJECT=m
 CONFIG_TRANSPARENT_HUGEPAGE=y
-CONFIG_CLEANCACHE=y
-CONFIG_FRONTSWAP=y
 CONFIG_CMA=y
 CONFIG_CMA_AREAS=7
 CONFIG_MEM_SOFT_DIRTY=y
-CONFIG_ZSWAP=y
-CONFIG_ZSMALLOC=y
 CONFIG_ZONE_DEVICE=y
 CONFIG_DEVICE_PRIVATE=y
+CONFIG_USERFAULTFD=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_PACKET_DIAG=y
@@ -167,7 +159,6 @@ CONFIG_BRIDGE_NETFILTER=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_ZONES=y
-# CONFIG_NF_CONNTRACK_PROCFS is not set
 CONFIG_NF_CONNTRACK_EVENTS=y
 CONFIG_NF_CONNTRACK_TIMEOUT=y
 CONFIG_NF_CONNTRACK_TIMESTAMP=y
@@ -178,7 +169,6 @@ CONFIG_NETFILTER_NETLINK_GLUE_CT=y
 CONFIG_NF_TABLES=m
 CONFIG_NF_TABLES_NETDEV=y
 CONFIG_NFT_CT=m
-CONFIG_NFT_COUNTER=m
 CONFIG_NFT_CONNLIMIT=m
 CONFIG_NFT_LOG=m
 CONFIG_NFT_LIMIT=m
@@ -270,7 +260,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
@@ -312,7 +301,6 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
-CONFIG_EFI_VARS=y
 CONFIG_PARPORT=y
 CONFIG_PARPORT_PC=y
 CONFIG_PARPORT_SERIAL=y
@@ -363,7 +351,6 @@ CONFIG_E1000=y
 CONFIG_E1000E=y
 CONFIG_IGB=y
 CONFIG_IGBVF=y
-CONFIG_IXGB=y
 CONFIG_IXGBE=y
 CONFIG_I40E=y
 CONFIG_SKY2=y
@@ -401,14 +388,14 @@ CONFIG_SENSORS_K10TEMP=m
 CONFIG_WATCHDOG=y
 CONFIG_RC_CORE=y
 CONFIG_RC_DECODERS=y
+CONFIG_IR_JVC_DECODER=y
+CONFIG_IR_MCE_KBD_DECODER=y
 CONFIG_IR_NEC_DECODER=y
 CONFIG_IR_RC5_DECODER=y
 CONFIG_IR_RC6_DECODER=y
-CONFIG_IR_JVC_DECODER=y
-CONFIG_IR_SONY_DECODER=y
 CONFIG_IR_SANYO_DECODER=y
 CONFIG_IR_SHARP_DECODER=y
-CONFIG_IR_MCE_KBD_DECODER=y
+CONFIG_IR_SONY_DECODER=y
 CONFIG_IR_XMP_DECODER=y
 CONFIG_AGP=y
 CONFIG_AGP_AMD64=y
@@ -422,7 +409,6 @@ CONFIG_HSA_AMD_P2P=y
 CONFIG_DRM_AST=m
 CONFIG_FB=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 CONFIG_HID_BATTERY_STRENGTH=y
 CONFIG_HIDRAW=y
@@ -456,7 +442,6 @@ CONFIG_RTC_CLASS=y
 # CONFIG_RTC_HCTOSYS is not set
 CONFIG_DMADEVICES=y
 CONFIG_DMABUF_MOVE_NOTIFY=y
-# CONFIG_X86_PLATFORM_DEVICES is not set
 CONFIG_AMD_IOMMU=y
 CONFIG_INTEL_IOMMU=y
 # CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
@@ -473,9 +458,7 @@ CONFIG_XFS_WARN=y
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_QFMT_V2=y
-CONFIG_AUTOFS4_FS=y
 CONFIG_FUSE_FS=m
 CONFIG_CUSE=m
 CONFIG_OVERLAY_FS=y
@@ -509,22 +492,21 @@ CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
-CONFIG_SECURITY_SELINUX_DISABLE=y
-CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
 CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
 CONFIG_CRYPTO_AUTHENC=y
+CONFIG_CRYPTO_DES=y
+CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_SEQIV=y
 CONFIG_CRYPTO_ECHAINIV=y
-CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_MD4=y
 CONFIG_CRYPTO_SHA1=y
-CONFIG_CRYPTO_DES=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
 CONFIG_KGDB=y
 CONFIG_KGDB_LOW_LEVEL_TRAP=y
 CONFIG_KGDB_KDB=y
 CONFIG_KDB_KEYBOARD=y
+CONFIG_UBSAN=y
 CONFIG_DEBUG_RODATA_TEST=y
 CONFIG_DEBUG_KMEMLEAK=y
 CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
-- 
2.34.1

