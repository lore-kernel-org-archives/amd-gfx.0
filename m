Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA79C53219
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 18:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E2CA10E366;
	Tue, 28 Jul 2026 18:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BDf2dGX8";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 583CA10E9AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 18:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c54uoxW1SHimcF5n6FfnwacAPx6svlM4EUZryJrB8PW2/ubePKYhvas/y9d8ud3OPHitdoX282780CWOK/krGUsxKQrvyXyGIOt/KIFif1ZgUQPu8NaKVm8jP01nLeGnSOayuF76BLPeEvFwfcM8lGkq61Lz8HSASWP5OYG4HREkItY6Q9pZ7lekNUtSMySXE6R20zXyf85f0idkE7p/8AKkVG28AXGH3m8Ge1JiqJ7zUrmqOVNAqG4iCc2CB0anlIQa34mELZMnV6oyLgK5FcTEzoWRvg0t8pVFWRAqyen1MytDtrODoMCp46YamCTloznWvwuI4qTJ6s880KsodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut/ORMjYNNOTid15NHbf4FyIneFlbVpQ+QbaEF0V5Ko=;
 b=GRUgAePjiPzmGSe5pBDLr2QeARcGdSKtoWydrdaMOC60wj7sz+vibniguzyQXJs+MjTzPv2yeykTRPIKvDkttd55AASUyE4Fzj+B1TUpTI4x6WjwsYCYQ4Jm+1ehE4QJK4eVClFyQZ08z9NL/xGgs3nlq4PiJTs9iSsc9WtHGHObEJ46R3TU98Bw6sIvhSg2mC/Enc0Jb57BenoZtxmeupXB+rQli+mw4l/ZklodhBtzOkAWCnHB3gzAG4t7c+YE4NuAOzuAv+LgGismGS1lXh7arO1E8EiQWRO3MJRdhYt0wTl6W50jj+kICUk3od3R5W5Cfcqa8/7A2C0JdEXfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut/ORMjYNNOTid15NHbf4FyIneFlbVpQ+QbaEF0V5Ko=;
 b=BDf2dGX8uhlMoTSmBnbgadikG6xbu7gN5PS2je7XDWiLu8clr17YYIiBkvVd5/xitdQLqK94w9biv/k/ysP5OJwwzzKNIIryh7oi/HQzy/iGDiFHkSTIWarF8z2yIc/oms4o6AScRN3drnkFHv3p16gug3zmVvxt7Sl9MZJLatU=
Received: from CH0P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::21)
 by MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 18:16:23 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::42) by CH0P221CA0020.outlook.office365.com
 (2603:10b6:610:11c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 18:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 18:16:22 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 28 Jul 2026 13:16:22 -0500
From: Andrew Martin <andrew.martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Andrew Martin <andmarti@amd.com>
Subject: [PATCH] drm/amdkfd: zero SDMA mid-command save state before restoring
 user queues
Date: Tue, 28 Jul 2026 14:16:08 -0400
Message-ID: <20260728181608.10541-1-andrew.martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MW6PR12MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: 7010e587-f3a8-4735-d9b8-08deecd4547a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|6133799003|18002099003|11063799006|10067099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: imT9k4ezn7PqhfodreycskH4WTA9XCmrL8q6Cp1D0cHO1PEKUsAH4sexZp9yUChQrkjMUfNCMG3Mla2vDGG71L+sQkwsXkJWGJfzlN8GUXZInZiWYM4pyIQ/RSJQPL0VCrf+giJRPjLeG3k/SiTL2+yXLRvynfECV+6wcH04IhwU8rG4GJfR0ebHdsQdPZrkHbe/301QC7C0dKDIARTLG/i4iuS1FZA4EVOoycpB4oJO1PEa7XZf/gIYN8CW7OTJz0d9mjyc2FMSJHab24N9iyIaQ6C4ZiWXTjDug+EEkASkeDGgXVAWBcayso7ufRIP55zxsNAAsg+OnIHDl3DL2faewYe380T+tIvPcDisngLVTf4V5UzHpw1j18n4fgvdSKbkbeoF8dcGpbzDbHE6dSNVzotbFauaOwE46kWbZybB8XVrpJsURfxmPagbkrLcnK4JWHtAvixXozJY03fqu3FpX1lOoydhda5QYKCNJvbbLSNoB7BDOGTon+7w6bRUapXiwR3/qAdsmK5P3HNj5MZwCnnMwC0tO9KvvISk+W/1Scid/Pg4HQ2TixvKij2G7ebOxhBdGQA/4QODtINsN9HF7UUfZbpObGRWqjWtrkPBGkV6Gvim3DFctbhr8pK76JgPA0KxVwUFwGioT/gq/oyUMq96zuubngL+pY7Yp7d9bkCCoFimI6pNb48mhWv0Fh36CNiHgwTUAXYnFHNQyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(6133799003)(18002099003)(11063799006)(10067099003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AYTN/11Eyb/pCbt9jFa5rPNf0w1qa1gTdH2Ov/ZdgA7EQ7p+X1K/r659mUYVDH/23jottdLAXNtaNTp71UrSkTFYF+MewvUNWFx52WA86OtDKyOJyjSDpLFLLDOw3rwuAB4cMjRYxWXwe3Cq7aTYkkjSGjuj11sJwbuSAzK3nMmps5DT7bPdQ5KkOLBvsGGFQjpUNbn22aazbnmiqeBVG17XBKUn+7pCf6fHl4Mg1Nyx5YicND5NFLTSVm6DDGcZ1cXgRKw2sa6TW17kbLY2n/UpH7DCWv1aEqmQyQC3mzG8maSxnbCMOut1Ei8XInLVARNCpVhwKugjjeE3DJWudU4Vv0NsjNop7AmdznODHyrlfuWwGd44AYrx7d4LsOQlD1XDf/BZfw3MCiFbL+Abu8Qn6uN2ykUwIF1zsGaQmGYmXTCXkN2wrvUK8WI6grwM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 18:16:22.6959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7010e587-f3a8-4735-d9b8-08deecd4547a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8898
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

From: Andrew Martin <andmarti@amd.com>

Applies to gfx10 (RDNA2) and gfx11 (RDNA3).

The SDMA firmware's saved mid-command state for a preempted COPY_LINEAR
(sdmax_rlcx_midcmd_data0 = source byte offset) has been observed to
overshoot the packet's byte count on gfx10.3 (Navi21, XNACK off) after
rapid quiesce/resume cycles driven by userptr/SVM eviction. On
MAP_QUEUES the engine resumes the copy at src+offset past the buffer:
an unmapped VA turns into a UTCL2 'Page not present' fault, a mapped
one into silent data corruption.

The silent corruption variant produces no dmesg output and is only
detectable through application-level data integrity checks (checksums,
validation). This makes diagnosis extremely difficult as there is no
kernel-level indication of the failure.

Zero the mid-command save area before remapping so the pending packet
re-executes from its packet boundary (idempotent for COPY/GCR/FENCE).
Workaround for field crashes of ROCm workloads on RDNA2/RDNA3.

Signed-off-by: Andrew Martin <andmarti@amd.com>
Assisted-by: Claude:Sonnet 4-5
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 51ee9c39104b..1507d371f741 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -40,6 +40,8 @@
 #include "amdgpu_ring.h"
 #include "amdgpu_mes.h"
 #include "kfd_debug.h"
+#include "v10_structs.h"
+#include "v11_structs.h"
 
 /* Size of the per-pipe EOP queue */
 #define CIK_HPD_EOP_BYTES_LOG2 11
@@ -1447,6 +1449,37 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 	return ret;
 }
 
+/*
+ * Zero SDMA mid-command state before MAP_QUEUES. Firmware bug: preempted
+ * COPY_LINEAR can resume at corrupted offset past buffer (silent corruption
+ * or VM fault). Re-executing from packet start is idempotent and safe.
+ */
+static void clamp_sdma_midcmd_state(struct device_queue_manager *dqm,
+				    struct qcm_process_device *qpd)
+{
+	struct queue *q;
+	uint32_t gc_ver = KFD_GC_VERSION(dqm->dev);
+
+	if (gc_ver < IP_VERSION(10, 1, 1) || gc_ver >= IP_VERSION(12, 0, 0))
+		return;
+
+	list_for_each_entry(q, &qpd->queues_list, list) {
+		if ((q->properties.type != KFD_QUEUE_TYPE_SDMA &&
+		     q->properties.type != KFD_QUEUE_TYPE_SDMA_XGMI) || !q->mqd)
+			continue;
+
+		if (gc_ver < IP_VERSION(11, 0, 0)) {
+			struct v10_sdma_mqd *m = q->mqd;
+
+			memset(&m->sdmax_rlcx_midcmd_data0, 0, 10 * sizeof(uint32_t));
+		} else {
+			struct v11_sdma_mqd *m = q->mqd;
+
+			memset(&m->sdmax_rlcx_midcmd_data0, 0, 12 * sizeof(uint32_t));
+		}
+	}
+}
+
 static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 					struct qcm_process_device *qpd)
 {
@@ -1498,9 +1531,11 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 			}
 		}
 	}
-	if (!dqm->dev->kfd->shared_resources.enable_mes)
+	if (!dqm->dev->kfd->shared_resources.enable_mes) {
+		clamp_sdma_midcmd_state(dqm, qpd);
 		retval = execute_queues_cpsch(dqm,
 					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
+	}
 	eviction_duration = get_jiffies_64() - pdd->last_evict_timestamp;
 	atomic64_add(eviction_duration, &pdd->evict_duration_counter);
 vm_not_acquired:
-- 
2.43.0

