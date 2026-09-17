Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B95AC982D0
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 18:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA21310EC68;
	Thu, 17 Sep 2026 18:32:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bnWwPi4a";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A37C610EC68
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 18:32:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9PdxZqp7WGh/b4YH4UJRLthUNWWY6VFJNTTyL3z/SWAxbCQI9zBTaqIrDnJ8T4Af/1avdMPIOiC9kV3NcfoYEp7TYnBCGfE8B2A9Vs6aIdqKyFClz0+X4sna6c00Q9Kpk1+upSPSa+oGqQktPMsKSnvxm0VQ1zdIc+tUht7GkT7Uepo74IvaKWFa9AFZ4Cn7MM/IU/22VZN/LyJLZRzOKKfulZALWreLJ60jqsT8Q9OYbrPpIm8IsAd1tpdAfvbWeL2+khC3xwzQtZFX3er3xeP5Qu28Qvbn0SlXboqmr93sP9SnswPlnBvV+GDuty24vNvTl0LNkAgJNy9MTi+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTXg2erMOcWKS81+HOvZAo8WPDRsqSyi1fq1foFFBP4=;
 b=wmQ8oClJV6/1v5Zs2RvKyxrRNLKi8BHAPoaKzwd8tPiB37I2+WRrTLwFRx+9OGKZeOt3KapbGRJIZbUiY0hZux9xdokwe1pshI6Dg/6x+lP+/K1203wBptBQ7+9o3XWw/8C/Rx/XsVxc9VWODCoeoEQt+ifrqYVN/BhCG4OpSGmdi+NgqF1r3rHYlwAJ5WggQSupWR8+BJHGVvaJqeXN4I3hN44izIOVbf+bhf7CSsazOHLgYrJIKm7261FobV2lGYELsEAKMdBwb9Kisj1loTCzt5e6QkZkBzBjJeugZs2NPeI/qeLfw7zQS3LG1MjfYXENnfIVR5n1SirvfKkmMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTXg2erMOcWKS81+HOvZAo8WPDRsqSyi1fq1foFFBP4=;
 b=bnWwPi4aFH0djOmvvqwiHqFpFhLy/UdKggsudp5YDd5N1/lWJ8d1oDFbDOqLScB9FaRjpmy1m+/wOk5FbcgaRnGI9OHE69KCJJKEAVg9v4qL13LDF3pE4d1aqqxDX2rhjh6vSdSuwthPw101SK2oKeF36sqa9Rw/askCP4foGn8=
Received: from MN2PR15CA0042.namprd15.prod.outlook.com (2603:10b6:208:237::11)
 by DM4PR12MB5818.namprd12.prod.outlook.com (2603:10b6:8:62::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Thu, 17 Sep
 2026 18:32:42 +0000
Received: from BN3PEPF00022BCE.namprd03.prod.outlook.com
 (2603:10b6:208:237:cafe::9e) by MN2PR15CA0042.outlook.office365.com
 (2603:10b6:208:237::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 18:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BCE.mail.protection.outlook.com (10.167.248.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 18:32:42 +0000
Received: from khazad-dum.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 13:32:41 -0500
From: Lancelot SIX <lancelot.six@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lancelot SIX <lancelot.six@amd.com>
Subject: [PATCH] drm/amdgpu: Add pci_domain to struct kfd_dbg_device_info_entry
Date: Thu, 17 Sep 2026 19:32:20 +0100
Message-ID: <20260917183220.622058-1-lancelot.six@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCE:EE_|DM4PR12MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 0882c716-609d-423c-2cd8-08df14ea0f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: YLyRgdUqKUGU9VE2jAwuUgzgPMM0+cUC3sm6MVXYEuWqkfslkw6t2vAJmEcCJ3zBoDeFEd1Iuz3aluIBYoR7ggEFrxiuh9NMO2apXKoLmMbrTJCHb0hUFCjqXcnDGqLICjLFMPdiKO+TM2y1Uo7r1CAAJYPF5q8oqBO7fBDfMbFEskf1msCW1A8Q6WVoAIHIhqoZLuON+WgnI4QzFHj06L81di2Zo5HXesTArQ8SCUz2xdML5wNEvn6KKlUXMKgYUftt5wLSJbzcwrCEKR6C1EWgywM/XauRhWRUYciQungRm4GvjyAUekTeCywiViRM/IBT+zGQrvI+6HyiNmC2lk97NK1ZfLshvMCTgSur9lL0+1UWivtYmH0BBKqPYBJmmXbNI2EvOZeK07gDG7DfrIkp2MSZ7RlpDlihUiw2+To3MletAaawcdtX2BWTMfOeqGFU1WfoH7v4uD+vslqvCpnc6O6tMI52WNo4RvC8DIm1BbhsgD2LHu4i0nusjuEbGY/7L4WkifRCdJjLgeO5nWeB4H1fK9YR10Wex3adG+7GBnNnj7qUkQqMZhgCN+bQGR2GYcrFWqd00EKcIHx7a043EiWWYuo7lp2tDJbwVIfKREY9SeF2s9Kh6RECHXmOlvXnKFkHdkEFZhg0jgqF2ly4Yld1Xql8qwl7D2/tFdGl7pmIQ/8UKua+/bOyXbsCObEisRhaJi8oUCzObFOg5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ht7LbpUMLj0Wraax9ro6iwK/BUGkmk/GweusobkOUdeTcXpuMkTXvpsQ/gZlrk69DUKLOL3lhwGRTcIbbN9GGR3Z1bbtSa6b83NkyNtEm+O4kKflv91Q+/8nm6a77EbZI+2jnPfxH9865TvJ/FhGeokGBjDpBK/aW5hDUaNeBL8cvsAulS3mwueBgN9bgbxXWX681/44vBqq884FViRfit/fkY8pXwXlSBfOgMSQ+3CspRK5rGzCWZ174Kp4EVHwLgcx8MasJX950PSyp2ndwe9IkGDwO/w4bMtvB7pZjHXxUe0oOIR1Yjqm//KVCMC+ncQEZRV/am0jHSeHCxpf/wncXFJfI4Hb0p8WqIfS5tqyvHi9tSBYCg5OBKQS4rFy1NodJ0ZIY6nnmRivXKWGQwsYzOeDOdRZYboTN2MhgOyi/op39k3blmGHNUcoalfS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 18:32:42.3786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0882c716-609d-423c-2cd8-08df14ea0f76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BCE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5818
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

The device info structure returned to the debugger via the
KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT ioctl contain location of the
device on PCI (bus, device, function), but is missing the domain this
location belongs to.

This patch adds this information to the snapshot structure.  The overall
size of the kfd_dbg_device_info_entry structure structure, this new
field is placed in preexisting padding.

Tested using the ROCm debugger.

Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 1 +
 include/uapi/linux/kfd_ioctl.h         | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 0dd1fd448059b..2c14b03df0781 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -1129,6 +1129,7 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
 		device_info.capability = topo_dev->node_props.capability;
 		device_info.debug_prop = topo_dev->node_props.debug_prop;
 		device_info.capability2 = topo_dev->node_props.capability2;
+		device_info.pci_domain = topo_dev->node_props.domain;
 
 		if (exception_clear_mask)
 			pdd->exception_status &= ~exception_clear_mask;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 749d196e2114b..e7908a068d3d1 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -49,9 +49,10 @@
  * - 1.21 - Debugger support to subscribe to LDS out-of-address exceptions
  * - 1.22 - Add queue creation with metadata ring base address
  * - 1.23 - Add profiler control ioctl to enable/disable profiler on a process
+ * - 1.24 - Add  PCI domain in kfd_dbg_device_info_entry
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 23
+#define KFD_IOCTL_MINOR_VERSION 24
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
@@ -151,7 +152,7 @@ struct kfd_dbg_device_info_entry {
 	__u32 capability;
 	__u32 debug_prop;
 	__u32 capability2;
-	__u32 pad;
+	__u32 pci_domain;
 };
 
 /* For kfd_ioctl_set_memory_policy_args.default_policy and alternate_policy */

base-commit: cf48bd0a46279f4607956cb17c71bda96ee802e3
-- 
2.43.0

