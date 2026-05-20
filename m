Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295A2CD4F5B
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 01:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75D7110E5F3;
	Wed, 20 May 2026 01:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YqYeBXNK";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011048.outbound.protection.outlook.com [52.101.57.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47CE610E5F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 01:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPiLsiSR5U67DxGmCzTuhldx++8cSG5nsaNy53br9tnJMxnVFOvfmtYN2+ZeuHEy1UupB7ZVg7C/Iy+PnKr0fmW/+y4jRGuvqvEEmzAgv3qrx87Tsh012peJnk7Ne88JqEm2FWjG0bG1IRCMOD2uVi2+Y6aFTCiYNShf/LQhUpasXbqmnBIBuhPljd0cTPaPU42uZbrgtyMPeJGKqZRRc17Svjgsg9mvPIAGt/uMXbwMflFO4QfG9rTtispRVf7XKhcGfgqueE6nr4XBqR0wyy/jczYvds7VvEXUQ88n1GTshYs+9NWI5s8ei8IIyBtgcUHs2IYiNbFUFbCRCZinrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRDyt7iIMmLQe+N+blG3C5ClGf94eB+c7X1lHzfja1I=;
 b=MLL1a0BkUKM7Xv8b8tnrE6R1jMrpYkAxYUzMZMWVSfHaYIIX52FMhQ5deNNCLrmQTgavSxBRKGyYUmRRSLj2zxniDdKQovrcjbsFDGQcQAMO/tvR+zEQQwsafwi53VSk+rXYyXuq0BE6EgD1Baf5tkzit98W3P1b3u3DAWuxeYBjwPXZrGgaQf69z7WqINXXUWNsp6qvqlU0QDZJ3bpbfQTfWtmTFl8HnIjClBMeCBTkDYvQQ/zn5Wo5WflOBAqcnCg/AHmSe2b7R/Yv6QqpSsyLjlX4J0F0oq29L3HLLssBA9JgJSwD/E+Vc9D3PnjqWnREyHX68rZYZhWVKlKPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRDyt7iIMmLQe+N+blG3C5ClGf94eB+c7X1lHzfja1I=;
 b=YqYeBXNK7PKJeJVnlXvjZnZxHCYWJ3E+Npn0tIJ94CGwVW3u7/3w49cV3i4qWebx2/lmKx1uLzUvVgaJTVf8N7QtM7dr7BDmvewPVLYhGJ5heKgT4mFD75zrn27J9E0LGXBIPYMmPHgq0X5oH2VTZWoAtVQv4Rg7h9VlSDyqe94=
Received: from BLAPR03CA0064.namprd03.prod.outlook.com (2603:10b6:208:329::9)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Wed, 20 May
 2026 01:03:02 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::70) by BLAPR03CA0064.outlook.office365.com
 (2603:10b6:208:329::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Wed, 20
 May 2026 01:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 01:03:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 20:03:01 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 20:03:00 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: wait for HW fences before VM teardown on fd
 close
Date: Tue, 19 May 2026 21:01:45 -0400
Message-ID: <20260520010257.115740-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: d358ee4e-4050-4968-20f4-08deb60b8a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 9qpyJCYYSgDa6dKsuDRWYDDcssivKM/AuV4ZnzKB5/ZtdDp4myN9kHKYP0LCbsPRxyq844IYXFyDA5WMzEGvv8cRO0GjyFx+bytBA6ezbpVPXVHALTsrEdURwl0LRRifVjY4sR3rRzWm9c/9oHeCFlYUX6wXSWTVb9kOQiBgWw9lPCyGMS6UTdgQ+w+3oWFz1QoyQI6tqY7tzo4NpMyn4PqMmyH5p4wLbo7q34Tnie5Vlp1LhbA4pWVIGBKd+KiB1icicesoIjjx0sB+/8MD6pBFrtUh+Rn901uCestS1XNn0lkEkw0gPFXwxRZkcmxzP9Mojl9OXznm0pCnP6YeX4ww8g1GkvEKcyMcSYoaZLnhxWLlKSzr8FG7EqbJSDx12U6BBUdss53ABBuTbDwzffgumrpotXdvU0m2OgxHp9s3r8hqhH67dBVuoPHeIyxT0xYLPfrsfVUJWszg91adKCO4YH5G6E4DKRbroZbMnM/SSBTocMps7zy6sIETO4xZNNLBU0ikgJcwgYgTc2e42GNYFhMX4PsS8K15J7LQalXpEEfouV1BffR0QQkLCl+N1WwylFKwT9MdPO1BAVq+OnRsry9PRv1dqwOLw4owL22yBmSmeSkcQps+Ak1zzaRxuKKK6CZ5xHGVV/6vmD9Wlwj9pgtNqpKgUIKTdHWrddKbir7/wr7xCRsgov+pmwBJZTUX6emGdPMXCJabb+zqnREUlst48CGro+Xgqqq1o7E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q//Tm/oBnSR8VIX+0h/l7jKp26YThlwqth4LOz7mP1Ksv6t2KrmPVcXd1sGN9hK+2b/OUqAxLkIbev0NiNtG68AdiyDfNYX94f9CUNU3aENbADwWVJtUKOejRAHMn5bd6asw43Vbw17qnWbdmDxtBVeYOJ+5/bww76nYoCOAomt9AcjsmT2Ke8JRW44EnYykc67ir9SKFHAK7XX/W71lAMuS8iwfAil0mtqPmRwJQ1dddU69zEg+x9+/L/ZPaeA169fee/TWyCjqg641q2zfNPfz88ko0fqinDcL9BTEzog+GZsSz9ipwi7r617G6CBBwQPbWmka7NucFZ6BamTiODDJl9y2FLq2KsZDZ+euEWuDRLS6GbEWV53yM+z4yXlilV9ei3Q5C9g7VHrzPTMqpLVBED6HiCdUoIN3rWq5fWnYsS6vErGLeXH9yrJcBE1K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 01:03:01.2874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d358ee4e-4050-4968-20f4-08deb60b8a3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

Add amdgpu_ctx_mgr_wait_idle() which waits for all outstanding HW
fences to signal before proceeding with VM page table destruction.

This fixes a race condition reproduced by the IGT test amd_close_race
(subtests: close-race-low, close-race-medium, close-race-high). The
test spawns multiple threads that submit GPU work and immediately
close the fd, stressing the window between job dispatch and file
teardown.

Without this fix, close(fd) tears down VM page tables via
amdgpu_vm_fini() while the GPU is still fetching indirect buffers
from those pages. The existing amdgpu_flush() path only waits for
scheduler entities to drain (drm_sched_entity_flush), but this does
not guarantee hardware completion. Jobs that have already been
dispatched to HW rings continue executing against freed page tables,
causing:
- Illegal opcode interrupts (reading garbage from freed memory)

The fix inserts amdgpu_ctx_mgr_wait_idle() in amdgpu_drm_release(),
before drm_release() tears down GEM objects and page tables. It
iterates all contexts and waits on the last submitted fence per
entity, ensuring hardware has completed all accesses to VM page
tables before they are freed.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Change-Id: I33fea5eddaddf1a246d21293d784cc6b7f544541
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 44 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  5 +++
 3 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index c273557fb1ae..7fc14b7b4374 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -957,6 +957,50 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
 	}
 }
 
+/**
+ * amdgpu_ctx_mgr_wait_idle - wait for all HW fences to complete
+ *
+ * @mgr: context manager
+ *
+ * Wait for the hardware to finish processing all outstanding submissions
+ * across every context and entity. This must be called before VM teardown
+ * to prevent the GPU from accessing freed page tables.
+ */
+void amdgpu_ctx_mgr_wait_idle(struct amdgpu_ctx_mgr *mgr)
+{
+	struct amdgpu_ctx *ctx;
+	uint32_t id, i, j;
+
+	mutex_lock(&mgr->lock);
+	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
+		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
+				struct amdgpu_ctx_entity *centity;
+				struct dma_fence *fence;
+
+				centity = ctx->entities[i][j];
+				if (!centity)
+					continue;
+
+				spin_lock(&ctx->ring_lock);
+				if (centity->sequence == 0) {
+					spin_unlock(&ctx->ring_lock);
+					continue;
+				}
+				fence = dma_fence_get(centity->fences[(centity->sequence - 1) &
+								     (amdgpu_sched_jobs - 1)]);
+				spin_unlock(&ctx->ring_lock);
+
+				if (fence) {
+					dma_fence_wait(fence, false);
+					dma_fence_put(fence);
+				}
+			}
+		}
+	}
+	mutex_unlock(&mgr->lock);
+}
+
 void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
 {
 	amdgpu_ctx_mgr_entity_fini(mgr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index cf8d700a22fe..0ea86235d0df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -92,6 +92,7 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
 void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
 			 struct amdgpu_device *adev);
 long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout);
+void amdgpu_ctx_mgr_wait_idle(struct amdgpu_ctx_mgr *mgr);
 void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
 void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
 			  ktime_t usage[AMDGPU_HW_IP_NUM]);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4d4d21babc61..6089bc30c915 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2972,6 +2972,11 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 		drm_dev_exit(idx);
 	}
 
+
+	/* Wait for all HW fences before drm_release tears down GEM/page tables */
+	if (fpriv)
+		amdgpu_ctx_mgr_wait_idle(&fpriv->ctx_mgr);
+
 	return drm_release(inode, filp);
 }
 
-- 
2.54.0

