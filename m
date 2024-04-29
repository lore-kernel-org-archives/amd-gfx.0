Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95196C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E0BA10FF27;
	Mon, 29 Apr 2024 14:58:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qbvh5TZR";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8558C10FF23
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cv0XOyRED2++L0VuBmOgP8XH4UB2mfz5HEkyHZz9xhCjCve3xW2D0++EsImylxpmfoP8tDRn76UcztLg4e2E/9LpxEsdNmCiEDjVbdNUb7v2mlyLzodwsJZKQR23I5uYS1HPqfkX0jLJsu7KUsyLExUH33gARwwwI2WTnKq6+A4Ct4uacwEf1iGbguuZEqD1STnzJ3SUqxd64/BaZEIY0ZAUQF34jTbuYsGUtkNBzVJz1dr1VmL/ua3C0AnruYbPOqu0k0Wbzcq31Kf+Y5QbPD25Jry4rK9OzhThqQ9hZisy3H6u3SaGfeSSeJHn+K6VazYh91K/eM6Us8R1jwEFhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRvM6y8whh6X/XRNoe4PrbZMU8gzU2aPfq2d+68r/JA=;
 b=dGFt3Lf9ZqzceEelhAyWQPz4SdP3asAG3LkrTvyqLYUBJE9LIK1886NnELstWsKVsQ9IcSpx8H8cFfsG8x2XqvR3uR0amE61drPf/0k8ZWg14Z2ucmGmY+OxtgpLM+6Dc8meHeBq3ffCxBqD3k6i493izccAiyyKvic/ybLLYsiZ2ICnHgG7VrojjGCXNGdNHpDLbxgfSHDrMKGxcrCsc5NU5KRN9Nvm85AYGI4VY7vKtX6bUSUMiP9meQZkCTNUyszxWcURiGV5M6fg2AU4VtoEpqasz6dnzFX0vlzFh1BaMy5PQM60ZNubfGdWGlqtV5oIol6z7h0P8BULOcJz3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRvM6y8whh6X/XRNoe4PrbZMU8gzU2aPfq2d+68r/JA=;
 b=qbvh5TZRhOo1p/qhFT5t42/z4OGSV+pKDLrvM2lECSzyl/5qqe8mRWhqcXuYfPPMa9CPpPq4knCx6Dhsnxd9yUNG+NVm30kCRlUpLo9iK/5G4FY6Q0hP3hLP6+Bw/zZv7XaZmkxFL9FnndWfjbvFutZlahTMHwqbVSAMvlX+lzs=
Received: from BY5PR13CA0006.namprd13.prod.outlook.com (2603:10b6:a03:180::19)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:57:57 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::b9) by BY5PR13CA0006.outlook.office365.com
 (2603:10b6:a03:180::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Mon, 29 Apr 2024 14:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:57:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:57:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jonathan Kim <jonathan.kim@amd.com>, Lancelot Six <lancelot.six@amd.com>, 
 Eric Huang <jinhuieric.huang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 10/14] drm/amdkfd: enable single alu ops for gfx12
Date: Mon, 29 Apr 2024 10:57:22 -0400
Message-ID: <20240429145726.3459450-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429145726.3459450-1-alexander.deucher@amd.com>
References: <20240429145726.3459450-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|PH0PR12MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1b437c-3091-4dc8-d74b-08dc685cc034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?33aHQaylqHWd3eSx3dv3NRu9t0bvsSdnGFeVbtsu5GMUpSShF0QaxR1mfAzg?=
 =?us-ascii?Q?1OBHmJTw9Xzv5e54sZUA24GDBkggcxlwMAlZh8cNg3Kc56zTCG1PbOw63lhp?=
 =?us-ascii?Q?v5q4mfZ43QUSkDrpWIk9EE9jgLEaHZZHIDGgeYINqwKoPGcIvo/jybfXFg/T?=
 =?us-ascii?Q?9lo9GzvFTpojiNKx9rmDc0p8C5pLxdzV0hLz7xkCxez14krOcYRGXiSkBVD6?=
 =?us-ascii?Q?SfOffq2beFaMtQvhkzpuKsWwUhFC9hDcM6HJ90EZcOhFhzFTRZJkjNgD4IDo?=
 =?us-ascii?Q?794pEPRi+LJdbNUXoagTnjY6QQFSBo2nJ6zteNAQ8oTdili/M2HLArqnsPTx?=
 =?us-ascii?Q?9RC6qdUj04Norqs1tZtaWZ6/8CHvVe5G6BQ2dhHHYffUnxx86Ef4DhZmTWK7?=
 =?us-ascii?Q?09YTAFOto2ICZQIzKnTa1qalx1hSj5EusWV9whyQq7vtZnZtOM7L5jX9VQit?=
 =?us-ascii?Q?VNOP1nvAN4yz/f5F3g7+8X7Pi/tR8771afr5ZJiZiyY6Mk0FqTKScKjTv4k9?=
 =?us-ascii?Q?TZEh0xxNSaLT+wUTOM3mtB8d6ankfqLKmcFIksTrFJ2BhdL8p5qczSYI5v+n?=
 =?us-ascii?Q?VmcVVEg4io8EFABYy41h7Rzv+tcTCqQ+4Q48mD/pHf8umm9Ec25g4D00ttYN?=
 =?us-ascii?Q?o4mOfyBVZQWnoFfzRtHeKtEs2WHevIC0jXksRf/pzrGvttmlM9eBpRMKS4f7?=
 =?us-ascii?Q?XVrGz9rP7Ze7ob5TlkwDgHCY/h6c8RCx+soH/Cr8ERA2Q/i43Ut9pYNjkdXi?=
 =?us-ascii?Q?CcGBnDi5AKDP8Wbf8nKVqPmQJKM+DGyxaTV+y1VzWMMTC1J7LDlAI2Tk15P7?=
 =?us-ascii?Q?psgIzSRNmzdIUybFqkzNKLKn8Oc40lxiVKML+wevVLu7FeeQ1oioCTj8yJrS?=
 =?us-ascii?Q?cqRo7Djz7nZQ/7aGAqSwnGG4e/+HNWEVXNWk9k8u5vcbOsMOrtpwupEofJ1p?=
 =?us-ascii?Q?59P/vKArBd2KH5RtaNCK7PFh4QuxYPLiQ+4MOgFte9HuH7W0wiEB+8JCHfjG?=
 =?us-ascii?Q?89yd7n/extHPRf4gfcAYpAOEBrqmysgUYjpseRAw1vSkcfzcLYvpJgcOail4?=
 =?us-ascii?Q?ANUv+/BgCyXxUvup7/SLUZfByJC31z6H27LUiFXgnUb8n/mJdNlCFZoh8o03?=
 =?us-ascii?Q?rDaBLE+Fy9Pc0WUWa+6KucHfjOi6IafSbVv5DjuGeeIKFcGoVPYDKV1Yi9ML?=
 =?us-ascii?Q?qyRhzM76a9Y/J6N7JEIs53LnWMJEmzjQ1K0Qtw/dduYPp1iR1cI69EubSNer?=
 =?us-ascii?Q?kyuqAj115HMXu7lGm0O++JDsdzFWUW3czZ+aueEhcVNKuS8q5X+VWl1ke/DI?=
 =?us-ascii?Q?L5LCKN2JYTo/XgRjY9BRIJ8V8OW3Np/EGQhmR+RpEKfZMPWtB+NqxmtYAHP6?=
 =?us-ascii?Q?GnGvKMsn/9NH4mZ8YwW9SWvN4MSa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:57:54.8392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1b437c-3091-4dc8-d74b-08dc685cc034
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125
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

From: Jonathan Kim <jonathan.kim@amd.com>

GFX12 debugging requires setting up precise ALU operation for catching
ALU exceptions.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Tested-by: Lancelot Six <lancelot.six@amd.com>
Reviewed-by: Eric Huang <jinhuieric.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c    | 15 +++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  4 ++++
 include/uapi/linux/kfd_ioctl.h            |  1 +
 include/uapi/linux/kfd_sysfs.h            | 19 ++++++++++---------
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index d889e3545120a..45b1975b149a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -25,6 +25,7 @@
 #include "kfd_topology.h"
 #include <linux/file.h>
 #include <uapi/linux/kfd_ioctl.h>
+#include <uapi/linux/kfd_sysfs.h>
 
 #define MAX_WATCH_ADDRESSES	4
 
@@ -497,14 +498,24 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 	int i, r = 0, rewind_count = 0;
 
 	for (i = 0; i < target->n_pdds; i++) {
-		if (!kfd_dbg_is_per_vmid_supported(target->pdds[i]->dev) &&
+		struct kfd_topology_device *topo_dev =
+				kfd_topology_device_by_id(target->pdds[i]->dev->id);
+		uint32_t caps = topo_dev->node_props.capability;
+
+		if (!(caps | HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
 			(*flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) {
 			*flags = prev_flags;
 			return -EACCES;
 		}
+
+		if (!(caps | HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED) &&
+		    (*flags & KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP)) {
+			*flags = prev_flags;
+			return -EACCES;
+		}
 	}
 
-	target->dbg_flags = *flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP;
+	target->dbg_flags = *flags;
 	*flags = prev_flags;
 	for (i = 0; i < target->n_pdds; i++) {
 		struct kfd_process_device *pdd = target->pdds[i];
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index c51f131eaa2fb..11857869afb9e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1927,6 +1927,10 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(11, 0, 0))
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
+
+		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 0, 0))
+			dev->node_props.capability |=
+				HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED;
 	}
 
 	kfd_topology_set_dbg_firmware_support(dev);
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index d09c4a18e5713..43fb0f4c42262 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -853,6 +853,7 @@ enum kfd_dbg_trap_address_watch_mode {
 /* Additional wave settings */
 enum kfd_dbg_trap_flags {
 	KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP = 1,
+	KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP = 2,
 };
 
 /* Trap exceptions */
diff --git a/include/uapi/linux/kfd_sysfs.h b/include/uapi/linux/kfd_sysfs.h
index a51b7331e0b4b..5e8d28617efad 100644
--- a/include/uapi/linux/kfd_sysfs.h
+++ b/include/uapi/linux/kfd_sysfs.h
@@ -51,15 +51,16 @@
 /* Old buggy user mode depends on this being 0 */
 #define HSA_CAP_RESERVED_WAS_SRAM_EDCSUPPORTED	0x00080000
 
-#define HSA_CAP_MEM_EDCSUPPORTED		0x00100000
-#define HSA_CAP_RASEVENTNOTIFY			0x00200000
-#define HSA_CAP_ASIC_REVISION_MASK		0x03c00000
-#define HSA_CAP_ASIC_REVISION_SHIFT		22
-#define HSA_CAP_SRAM_EDCSUPPORTED		0x04000000
-#define HSA_CAP_SVMAPI_SUPPORTED		0x08000000
-#define HSA_CAP_FLAGS_COHERENTHOSTACCESS	0x10000000
-#define HSA_CAP_TRAP_DEBUG_FIRMWARE_SUPPORTED   0x20000000
-#define HSA_CAP_RESERVED			0xe00f8000
+#define HSA_CAP_MEM_EDCSUPPORTED				0x00100000
+#define HSA_CAP_RASEVENTNOTIFY					0x00200000
+#define HSA_CAP_ASIC_REVISION_MASK				0x03c00000
+#define HSA_CAP_ASIC_REVISION_SHIFT				22
+#define HSA_CAP_SRAM_EDCSUPPORTED				0x04000000
+#define HSA_CAP_SVMAPI_SUPPORTED				0x08000000
+#define HSA_CAP_FLAGS_COHERENTHOSTACCESS			0x10000000
+#define HSA_CAP_TRAP_DEBUG_FIRMWARE_SUPPORTED			0x20000000
+#define HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED	0x40000000
+#define HSA_CAP_RESERVED					0x800f8000
 
 /* debug_prop bits in node properties */
 #define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_MASK     0x0000000f
-- 
2.44.0

