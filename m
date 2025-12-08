Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E973BD3B7E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D46F10E4B0;
	Mon,  8 Dec 2025 17:18:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QvKCCveH";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52A2A10E4B1
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:18:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrESHmWXdQu3Hk9rNhSdv6BLEXmAHChzBFIK90bcGL/pmpTqGSuTPEqNBPJE/M4CWED4cbXsMkU/yG/9DAxyqmNatL/djq/jBvUYNTlOhBcv11XoRZQSeHJMXD/+9eW6cInQuRDfA5nfh+QAnJikeXS/DaAn+0oCCGOUzrUHeL+HU4T/yZ7xHtGJKHBzJ+c+I0uaQOJ6cBiXhevcznMXlTGsO1XNl79hYImFKVF2vs08ewt4ZTZPFDy+NSnyuXQbqbLaUq47zTWED1JQ6xIf5N4Yi6qvQ30rXu3XhXH0v18GorUh98n8Pl8zeVCE3Sa9VbZPhLmTCNOOYXjadDdMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuHoN8QjK8OIaGh8OJG4SpCVVPAVhZ1vy0XqDW5msew=;
 b=QGlWLvns/irovQ90rcXAExIsN2NUBD5Eq+iM1La9EtLqWsjW9+JrV76AKBKJ5ciZ5LEjxP0PpgYWCYRWSVd+NzFNwJMMGIzPgYj7vPyiXV6HLRJM4OSuen1vfe6t0n1P/bTdH8dxurnOvjPqSeGFQDhmTAH8reoG5f2/+2a9HkqJBXi3XayKRQPCemTFRrxLkZfF1BYOSdks3J6wm3kiDzhXfQfYHvUWVVJ1J2QWcll8yyM6m0L7FxTavmRRNuPmx/yIb34PvK0pYuMGWzS92jrQTXR5NH/QNCOQ8HvvU++itSyKXx4bS8T/54Kueip4SEzZqvGjJqnRHhkrMVLEcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuHoN8QjK8OIaGh8OJG4SpCVVPAVhZ1vy0XqDW5msew=;
 b=QvKCCveHkXeVibos+4+YIy4Bwp30evT5SlEZ1NQCE7jzP61WmiKYJm+WSu4BB1Che/Ma2yGxdOgL6awgv8skNHr2HBJLlp3sSFgWMIrJLlBrl87pxN2CwyJo1rLcMGjrG36uXIym+J96sbFeA6sh8cfzzBYmApD1Up86Rm6rwUE=
Received: from SJ0PR03CA0219.namprd03.prod.outlook.com (2603:10b6:a03:39f::14)
 by PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:18:05 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::86) by SJ0PR03CA0219.outlook.office365.com
 (2603:10b6:a03:39f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 17:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:18:05 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:51 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jonathan Kim <jonathan.kim@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: allow debug subscription to lds violations on gfx
 1250
Date: Mon, 8 Dec 2025 12:17:20 -0500
Message-ID: <20251208171720.153355-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208171720.153355-1-alexander.deucher@amd.com>
References: <20251208171720.153355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|PH7PR12MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: 6936ffad-149e-49db-0791-08de367dbff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VqmWCI+DJwzo6o6c9RTA38906QwC5GpSZm5obFRLvheR5zKuB6B68fsDw2SN?=
 =?us-ascii?Q?9nM4WjZJnTUjIcdEcjoN3buOvH7ilrR07nEDaIHMF13HXZr0ok062W1u2co9?=
 =?us-ascii?Q?gHNilTXqUlhgbdAtc777byoFpTtH/VzBOuvLFQAQLVdBMwut+eUJDq6rYBiW?=
 =?us-ascii?Q?iT/AYY9V7qbs1K6Nid3Kdh20igYD2VRi9oy+0Vqikr7UEUGmzeUcuobKeb1q?=
 =?us-ascii?Q?yH0n3pIq684YTLybMxgQR7OiZwY0QXjBzGbEk+ahyNPiGaoYWc5kSOnUhSLv?=
 =?us-ascii?Q?uk4hkkKxXOVSufE+E2reetnDsd3Gu8TpJZ5FTElHSIwIqNbkinBStnGaan4L?=
 =?us-ascii?Q?sFdcIfKqP6tooem3OhDJskDvkYDweHC+iDzZ+72QcyisoTT21711jqQe/Tl2?=
 =?us-ascii?Q?sFI+/2gFq33N1jGdRmpoeBvMLzrq42WsfZjbNStojLWstTM6rzu4CwLTyKff?=
 =?us-ascii?Q?KliDkuIUd2Ay8kq2EgdjSJJGgVikWhXyOUIUB684trtON6M7IvSmrgfXXJEq?=
 =?us-ascii?Q?zhXarPlXrolBjKgyOfzN/FKi8ZkWQ72dUsV8TzqH6keCpC2/6xYREDWzAAcj?=
 =?us-ascii?Q?uyWvGLcmW6BJkOwJd2SYXgeqvqrImARsztFJBxgUC3J49JQVZ9aBJKeSxtrF?=
 =?us-ascii?Q?JzP0ZinPqZd1y21AstQ+eKUcvQZLVPZN1mah6fxsCefjZMWWtNp4DmBC2LvB?=
 =?us-ascii?Q?4if1v7nAguFg8DT2DXtdVZT7dTAtvrxxvo+ZjjC8gsfUutx1DjDhDy8L3Wci?=
 =?us-ascii?Q?PE2RgxR5WKctqEmydwo/7dGQsuvOX9hhHfMSa7zaDofqlREVxDHZGtfrc0w5?=
 =?us-ascii?Q?YvN8NFcVc5aZMyrwZ/oVJ4APyEeL5YRfERKzNt/BZk5maaFIqIBE934F++uw?=
 =?us-ascii?Q?quPvGklKLeT1cYcnhqJItWOJczvhWd8qtJ3Q0InHpM/0fcmt1rdNOfJL9UWw?=
 =?us-ascii?Q?u4G0KExTjdVKUMzkF/PAzxsBPmfvj2GfV0U4hlsLqYrP9yXkYyXW6yXdv9kd?=
 =?us-ascii?Q?mL2gvP1j5Hf/drG3K4qqunHKU+TNgoi25T5jA4T2Cto7fnTOUIep76Pl8TwE?=
 =?us-ascii?Q?eGJDLOyahdv/b/IzItml31F/Wjfq+svrQqL0MDlkZ1TGzqjDneNXBHqL9o+f?=
 =?us-ascii?Q?Jo6rWmNEPhxV5NIABj2XZlcKcdiQVQWDfQsjBbFBD+4Oz++yvPFCoEWhsUIx?=
 =?us-ascii?Q?5dkCZ1fN6QayUAbeyOAqH6RkGoWjnwAVSUNnE//1NJMY5bMyun6f/hQTeF+p?=
 =?us-ascii?Q?QH0Hof6k9P40HsL/g35qITOExKzfFeh4O2gALNSCgts/BG3u8mdIVPnRfN6O?=
 =?us-ascii?Q?LipSwaUl4HavDCBvL2UvSobLmSmqHFJrh4Wr45NG2Hv4wOBHKNep5Jtaw0Ey?=
 =?us-ascii?Q?XT/4v4F351rM98IYTdGJ6iNq6hnZ6LmQ0meiCy9xVGb2PzplRSZq356227sY?=
 =?us-ascii?Q?PgtfwKYAG7Fk1m22CGoL9u0upRe0+nHRe+7LtDwreHejb/MXXTCAh0QFtnAp?=
 =?us-ascii?Q?z9+tctEPtkVBIV+DYpQwYTd5UJh/j+UwrMpo2dtp4ySeXFkdkI5zXNOJUTd7?=
 =?us-ascii?Q?MsWrK8oaFEs3HeYrwyw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:18:05.1184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6936ffad-149e-49db-0791-08de367dbff5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8593
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

GFX 1250 allows the debugger to subcribe to LDS out-of-range read/write
memory violations.
Bump IOCTL minor version and flag KFD capabilities for enablement
hint.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c    | 7 +++++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 ++++
 include/uapi/linux/kfd_ioctl.h            | 4 +++-
 include/uapi/linux/kfd_sysfs.h            | 3 ++-
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index ba9a09b6589a6..f83e1238c1b3d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -519,6 +519,7 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 		struct kfd_topology_device *topo_dev =
 				kfd_topology_device_by_id(target->pdds[i]->dev->id);
 		uint32_t caps = topo_dev->node_props.capability;
+		uint32_t caps2 = topo_dev->node_props.capability2;
 
 		if (!(caps & HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
 			(*flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) {
@@ -531,6 +532,12 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 			*flags = prev_flags;
 			return -EACCES;
 		}
+
+		if (!(caps2 & HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED) &&
+		    (*flags & KFD_DBG_TRAP_FLAG_LDS_OUT_OF_ADDR_RANGE)) {
+			*flags = prev_flags;
+			return -EACCES;
+		}
 	}
 
 	target->dbg_flags = *flags;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index a0990dd2378c1..7a402c9c1b6e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2028,6 +2028,10 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 0, 0))
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED;
+
+		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 1, 0))
+			dev->node_props.capability2 |=
+				HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED;
 	}
 
 	kfd_topology_set_dbg_firmware_support(dev);
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 4d0c1a53f9d51..6e91875c10baa 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -46,9 +46,10 @@
  * - 1.18 - Rename pad in set_memory_policy_args to misc_process_flag
  * - 1.19 - Add a new ioctl to craete secondary kfd processes
  * - 1.20 - Trap handler support for expert scheduling mode available
+ * - 1.21 - Debugger support to subscribe to LDS out-of-address exceptions
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 20
+#define KFD_IOCTL_MINOR_VERSION 21
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
@@ -947,6 +948,7 @@ enum kfd_dbg_trap_address_watch_mode {
 enum kfd_dbg_trap_flags {
 	KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP = 1,
 	KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP = 2,
+	KFD_DBG_TRAP_FLAG_LDS_OUT_OF_ADDR_RANGE = 4
 };
 
 /* Trap exceptions */
diff --git a/include/uapi/linux/kfd_sysfs.h b/include/uapi/linux/kfd_sysfs.h
index 1125fe47959fa..0b6ce2f3c8871 100644
--- a/include/uapi/linux/kfd_sysfs.h
+++ b/include/uapi/linux/kfd_sysfs.h
@@ -64,7 +64,8 @@
 #define HSA_CAP_RESERVED					0x000f8000
 
 #define HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED			0x00000001
-#define HSA_CAP2_RESERVED					0xfffffffe
+#define HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED	0x00000002
+#define HSA_CAP2_RESERVED					0xfffffffc
 
 /* debug_prop bits in node properties */
 #define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_MASK     0x0000000f
-- 
2.51.1

