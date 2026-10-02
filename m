Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6224CA5FD4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 17:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3BCE10E00E;
	Fri,  2 Oct 2026 17:35:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ISI+A5SU";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012008.outbound.protection.outlook.com
 [40.107.200.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C74810E00E
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 17:35:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mG0+zoVvpHkvbPaHqFqWXt/iTZM662ftlWOjEEYUZqY5g+6uuX220uG2ss4zGa7olyZrmkg2uU1J2uOF6mpNqDahhiZgZnDxtqtkChsO+qivQA7+gLt97KBWjanm6XWbh7AZdOZhgaP8c+fIFMVTJC4hDDinuCSJnjMpPHRy3kJKivo1bazgv18ZSdV+A3NX3VgErtUaUUW8zFyJQIXATC6u6DulhxcRVSTN7MUMM4vK+yb8ZWosoZLR8bjI1ZIbUeKLRLCFnT/gZ4l4GTCxC2R8FtO8Yb1hylaUHJUFL3T7iKytiY02UEdhzBAOFnIULfoOCkuU1/Wvwg1nz+C4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UMMefeFhMELO5ZAkirQLpyglyrOeXTxALmMpx5Ipn8=;
 b=hyuJlWhagsV1vut5YN894IlHAAryw5OuAGPyjps2bReL3btf8hZzrQfHMD+iPtYHApW+V8syAFrWyuIUdLNdr8VZXArw/AeJt40VVJK1LfaYwXtx74xaLXZUGeS/bfAGbt2UteZeV5DK2W88+1/dC8ctoq+4ZUwcPRNRnsIv22vRrV5rhq8f+NrzCTP5ePc5NdutI2OkcDgSHs/Wbz3+baF9j2SKW4tSKB23RlrsGj/YZQXqdWS3kR3tC2G8Qdf7j3xBCFJhB94fadH6ozLhBI1uvTBlM9GCis6e7b7rkL/gRHOZGYLPPhdYIUGVEl01BacwIfpC4WbUIhcScSaMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UMMefeFhMELO5ZAkirQLpyglyrOeXTxALmMpx5Ipn8=;
 b=ISI+A5SU76z84ieryIS4CRdRmPY7nUgYXwCxhGP5fS08fuy5OyLQ6EUwJedT+YG4NLsm4M+lAGAcRwuKF+LxKXoin3QMi/GQsapHlNhIx9a1fRhQvI+iTtEZDCEr4maxr/5vW5juzEhoR06kgIH/nBhdX+X1mwa5SWHeL7uw1Tw=
Received: from BN0PR04CA0154.namprd04.prod.outlook.com (2603:10b6:408:eb::9)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Fri, 2 Oct
 2026 17:35:01 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::7f) by BN0PR04CA0154.outlook.office365.com
 (2603:10b6:408:eb::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 17:35:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 2 Oct 2026 17:35:00 +0000
Received: from banff-cyxtera-s72-2.ctr.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 12:34:59 -0500
From: Saleel Kudchadker <Saleel.Kudchadker@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v4] drm/amdkfd: align SDMA doorbell base for shader doorbell
 writes
Date: Fri, 2 Oct 2026 17:34:45 +0000
Message-ID: <20261002173445.1744755-1-Saleel.Kudchadker@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8daa4c-d609-4778-0023-08df20ab7c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|56012099006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: nkuMej5R8tn7icG+YEjEZagCOpJhV8TXP+gyDUPuFZWXqn171B11Qua09C/b6MfK7O7DUTPeWyYZbIHpjyQ5epxClyfkH+IFUVp/gt30HbArNaj++QTol8zVSXYUvK0KKUecXPbseyGUpxnyrSCAhqACKoKgt3npf+ImpqXaODqvGLKI8gty7keFuJ6cnuHcldLVTimzkf8zh/n9v0fLE5fAZOTpgxKmY63mmVJMMfZnwZ41Hnr4JM/HPNvC+Gw/56lLIlM6XazxdQ++ZKLhp/hFWT4Y6OBzmGZ0dpy3sn2eGuapGsNNmX1FtutsU1+v8kVG47p3IWOujnP2hJCotlzU3lfCWwogzXTRsxdmVSdXL3vBmMq5uRvfkGnWZyNanlsdfn5vz7QgmIMOUNP7UB3f6FxJATIh0moCP862OjEpIixAtXAXrsaRNflBL+N0G+L4Cjf4FrHu7ZAY6jkdZecqNYnYkTTxLFlqM8doBZhMKvxj1j+GdHhX7tDe1gINhmgr3zA5TETKxh5nPJ0kNNDj+x5yvGQsW8QTd/gXUiePmGIbZddc1hTDSgUVmLQU5fnL70vZTomhxmptudj8O3Ya8OjlTiIE4t+ANg2jmvv4tADj3XnTJFDq0mUtM2zyXVa/e4ZW38KIaE04pmTYu+/uRd84kUssnkN9tN1/sWiUvJEdZ9GDetQFSsLXGR1fqMJAqSreuYRUifXQx0eOmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jq2h5gLm1GU5DGrSh/djf/AQTSVCXCisVMFUpjIuFRKxIUSD2I1DarjtlxVCWss2arxhm6XJrFCatbL9hSZzDiG63FSUrEy+cOthUCtyClOtV4mc8+g5t0GJ/RAH6RkfoO1rV0Eu8Nv9rPj/DXZ5sNdjzG7qwQox4TiZKQAg2hu0xoKhS+R1hDESNnX1KGM0zkCJVY9tg/PkJa5lG3yhynXMZxsMdqjI3CN+/2uj3qQ9zPLRC829Lj1MDRTZte/okVqCim+DBKsL0M8sW8tQiiQ6ZYWa13N9D1VmqSPwvBjB/UhP1vtjgC5PCQYh5htoggCbboFSd5X3Ki9caetZ0s0sCFNk3BfhDeXOu1zhKD2Jd0pS+X25DDAmH2g5eLYduVwYg5Rk7sJHrgnCD2iQktcvnMWmrTkTeo8Q/o2bj7x1npGRaHXMx5dQxx9oeFu9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 17:35:00.7153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8daa4c-d609-4778-0023-08df20ab7c59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943
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

On GC 9.4.3, 9.4.4 and 9.5.0, doorbell writes issued from shaders are
routed to an SDMA engine at 32-byte (4 doorbell index) granularity.
SDMA engine doorbell ranges are 10 indices apart, so the range of every
odd engine starts 2 indices into a 4-index block that begins in the
previous engine's range. A shader ringing the doorbell of a queue on an
odd engine therefore rings the previous engine instead. The intended
queue never sees the doorbell, so its work stalls and the application
hangs.

Align the per-engine doorbell base up to a 4-index boundary on these
ASICs. Each engine only uses 4 of its 10 indices, so the aligned base
plus the queue offset stays within the engine's range. Even engines are
already aligned, so only the doorbell IDs of odd-engine queues change.

Only doorbells rung by the device itself are routed this way. Doorbell
writes from the host, including the kernel's own SDMA rings, are not
affected.

The doorbell ID of an SDMA queue is saved in CRIU checkpoints and
checked again on restore. A checkpoint taken before this change that
contains an SDMA queue on an odd engine will fail to restore with
-EINVAL. This is intentional: the restored process still holds the old
doorbell address, so accepting the stale ID would bring back the same
stall.

Tested on MI300X with a shader-rung SDMA doorbell test: queues on odd
engines hung before this change and complete with it.

v2: use u32 instead of uint32_t for the new locals (checkpatch)
v3: name the routing granularity, use dev->node_id, document the
    layout invariants, describe impact
v4: express the granularity in doorbell indices, drop unrelated
    cleanups, explain the CRIU restore behavior, add test note

Fixes: 6df442a03d1a ("drm/amdgpu: add new doorbell assignment table for aqua_vanjaram")
Cc: stable@vger.kernel.org
Signed-off-by: Saleel Kudchadker <Saleel.Kudchadker@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 32 +++++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 ++++
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 6d12f9dc7f04..5e57576fba21 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -599,12 +599,32 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
 		 * we need the physical sdma engine id in order to get the
 		 * correct doorbell offset.
 		 */
-		uint32_t valid_id = idx_offset[qpd->dqm->dev->node_id *
-					       get_num_all_sdma_engines(qpd->dqm) +
-					       q->properties.sdma_engine_id]
-						+ (q->properties.sdma_queue_id & 1)
-						* KFD_QUEUE_DOORBELL_MIRROR_OFFSET
-						+ (q->properties.sdma_queue_id >> 1);
+		u32 engine_base = idx_offset[dev->node_id *
+					     get_num_all_sdma_engines(qpd->dqm) +
+					     q->properties.sdma_engine_id];
+		u32 valid_id;
+
+		/*
+		 * With the aqua_vanjaram doorbell layout, a shader doorbell
+		 * write whose 32-byte block starts in the previous engine's
+		 * range rings that engine instead. Engine ranges are 10
+		 * indices apart (sdma_doorbell_range = 20 dwords, halved for
+		 * 8-byte doorbells, in aqua_vanjaram_doorbell_index_init()),
+		 * which puts odd engines 2 indices into a shared block.
+		 * Aligning costs at most 2 indices, and 8 queues per engine use
+		 * only 4 of the 10, so the aligned base stays in range. The
+		 * 512-index mirror offset keeps the alignment.
+		 */
+		if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 3) ||
+		    KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 4) ||
+		    KFD_GC_VERSION(dev) == IP_VERSION(9, 5, 0))
+			engine_base = ALIGN(engine_base,
+					    KFD_SDMA_SHADER_DOORBELL_GRANULARITY);
+
+		valid_id = engine_base +
+			   (q->properties.sdma_queue_id & 1) *
+			   KFD_QUEUE_DOORBELL_MIRROR_OFFSET +
+			   (q->properties.sdma_queue_id >> 1);
 
 		if (restore_id && *restore_id != valid_id)
 			return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 2847a5ec5ede..b9a31489b1c8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -133,6 +133,13 @@
  */
 #define KFD_QUEUE_DOORBELL_MIRROR_OFFSET 512
 
+/*
+ * On GC 9.4.3, 9.4.4 and 9.5.0, doorbell writes issued from shaders are
+ * routed to an SDMA engine at 32-byte granularity, i.e. 4 indices with the
+ * 8-byte SDMA doorbells used on SOC15.
+ */
+#define KFD_SDMA_SHADER_DOORBELL_GRANULARITY 4
+
 /**
  * enum kfd_ioctl_flags - KFD ioctl flags
  * Various flags that can be set in &amdkfd_ioctl_desc.flags to control how
-- 
2.34.1

