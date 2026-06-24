Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D5BCD4F26
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 03:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C52B110E01F;
	Wed, 24 Jun 2026 03:26:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BWs2+tI7";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B6E10E01F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 03:26:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lyx29zCxA+RP3TDf6hyxexC35wPYHp4tKpOuk4eN9wxVHg1o1tpFItfub/i4joo0mPQtrjwJBSThwhIoZXqKY5PME6ouh49mgnfMfaSXtDM6+Sc5J8isxQFVyfzXwgpepd9prLIgqVD0occS07cNYXP79c6ZbD4vpxB/yhAA+8rS2tqjAz4TS+pX0y8zgiFTFq2JXnHqiWn3UuIfQnB9PGUKi+k8ABV/wyTAEOHb9ZMIlH62SFxxGmiH1xJroEqpopHtG75qaubNFFyTTnRzBUmMEYWbn0TH91ANDx7TG7fZAuGwiaUieKabiK0TXxsR6HUMGNtNNrUdWsF+nI/x8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHiMqASq6ubjZXbhY0GAJoovFPRfAuQE0KOA2RiL/tQ=;
 b=l53rvCh9cQysbeQAVcX6bQ1G7aNCHBia/fEoTbUhTdjD6P8DNcQFj244KU3TunoX0vdwMrdtQH+su7hGIKu+7QWD31+nc1Q+roWn34iO146Y73raGK2CCT0hb+fwQhbAPsOL1EqLjdH2kGP8fVw2l1p3DIWHXdc8rNSUlTdd5KGPCiAhAeHNnIFRNcDeKjk0PriAz9Pe9IedEcsCqQBL5cSsiRXY+0VD9bUWsiI9iCpJmV4jkykuDmVqlyYWCmpjcRqjMwRkT3J8b/rBKAg/VMB4OZeLkVg4jqRSF6lD5iwfox50DGsxFI4eBAsLUn7Tg86bNYN/X6KGCOKEheG+5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHiMqASq6ubjZXbhY0GAJoovFPRfAuQE0KOA2RiL/tQ=;
 b=BWs2+tI7lpJqtqLkLnh8lCYimOx+zTc3aSrMCu5iVLJM3IZXBnHT+cw0D4u/DIbazJeXW7hQsNutvCothNsP/jxDUUidCvsRnYT11sfRXx6u1sOV3ABFKktcf7IOXkpCBH9gXvswv6dYG+kMKKnEUPokklkm5SKJ3dZ+cWh+OwQ=
Received: from SA1PR04CA0006.namprd04.prod.outlook.com (2603:10b6:806:2ce::6)
 by PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 03:26:29 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::ab) by SA1PR04CA0006.outlook.office365.com
 (2603:10b6:806:2ce::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 03:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 03:26:28 +0000
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 22:26:24 -0500
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>, "Geoffrey
 McRae" <geoffrey.mcrae@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: use amdgpu ring types for MES queue
Date: Wed, 24 Jun 2026 13:26:08 +1000
Message-ID: <20260624032608.1135223-3-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624032608.1135223-1-geoffrey.mcrae@amd.com>
References: <20260624032608.1135223-1-geoffrey.mcrae@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: ff49a63b-e7ae-48ab-814d-08ded1a06127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: RwNH7ftNfDK11tvZMHk2UP/PAcv7tmb7UYLqxG5A2z22QC58/RJvHDoZFTdYMn9G9gBwS1S7Otwhys/Lu1qYIouikbjfRMs8GoVka5SgjQaWTxPqdAAjtVjoovC/VaIA3EG9o3HPSlIaZ//PFuFf367/c400ktksZYm8hQuFPOwC9Pz5v4FEiKWt5uXTv7OyiWg4ImejtW67BS+wyx22ozaUF5wmP4FFlLsy0YZUzQopMSFItbXJR+mqoALlUpx3sckrDuldFndMZHl+Z6cOdlFpOnthllyBcIsfIKuqGervK+U3uk08jHw3lPPOrHZ5aV9IiHxtEJBEZV91phFxrKg1P2Y3ccmcNtN4ovy2fD0hkAglYDo90UmHNBuY1SfcvxG2o3B9T3utTAv5/8scHSSIxnkr2VEX+P4pR9am/i2PbdE81empZ+nkTELkl38S3bZNOEngyVQUImLq3pIn72685j2xQGXeUwZHMVBlZIJJyaIRDRLaLKMJRg/MfcIPR4N6ZKrPLFZtNQ3TcLtQHYRuprQzpzW+f+JpajbC8Et/7g4xqzehUYvTMa3RyhAFejSoI1ouAInWTsDCqVVOL1EEjm8M6GeDT33yyQSfZ0SBWM77lIH3ps/Jb5Ftz48IiZYDHq/o8ZIhQ00kdcdlg4Rl8oue46FAPvDuEcJkNM2epHw+Un/ApcDMxt+GTu5ztKKwtPto2DgYM1NUsAxlPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AEWnPbSsdEzIwU0VNmVF90Sh9ucVSsFmZ+PnywIyByWbCCa1smmtVi1wb7hn8j9W5mDBp0L7F2BpNqyi0rLjROUrWG7L5YFhPNR1IFV7s5IT++dBnYa9XhtXpeAFllzvD5FfiXdxtRzJXzWt1c1ur3729hDPvCSUPXbkzlbJyggJS36x1t3yD/XM3Wugz6jCQbAV+z13Sdk0qS01gfHvzOyak+mV35OEEV9E9oEnssGw3v/XNLobGvRNZYTAfHD5PKaURjd3r4KW3S2kUWiBnqRlN5c7y3jsJCgUe8prmF5PRBkL5z2hewycisrGBvfZ6/rMZdFkLwMV56Occ8NtiTJ6YAwhJ8dENM9ladG2agIYxBDRpGupssaLKMUtJ6x1R0aWzlL1KkXBo8yYwu/X0gtOG93igP7W/P/OxMpVcDBRSKXwpqmMNoXGYoh0QWmN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 03:26:28.7487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff49a63b-e7ae-48ab-814d-08ded1a06127
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769
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

The MES interface takes queue types as enum amdgpu_ring_type values.
The MES backend is responsible for converting those values to
firmware-facing MES_QUEUE_TYPE values when building MES packets.

The KFD queue manager was converting KFD queue types directly to
MES_QUEUE_TYPE values before filling the MES input structures. That is
the wrong abstraction level for the generic MES interface.

Change the KFD helper to return AMDGPU_RING_TYPE_* values and rename it
to make the expected type explicit. Use the helper for the add, remove,
and reset MES paths.

Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 74cdaa8636c9..f6a749fbdd8e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -37,7 +37,8 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_sdma.h"
-#include "mes_v11_api_def.h"
+#include "amdgpu_ring.h"
+#include "amdgpu_mes.h"
 #include "kfd_debug.h"
 
 /* Size of the per-pipe EOP queue */
@@ -183,24 +184,24 @@ static void kfd_hws_hang(struct device_queue_manager *dqm)
 	amdgpu_amdkfd_gpu_reset(dqm->dev->adev);
 }
 
-static int convert_to_mes_queue_type(int queue_type)
+static int convert_to_amdgpu_ring_type(int queue_type)
 {
-	int mes_queue_type;
+	int amdgpu_ring_type;
 
 	switch (queue_type) {
 	case KFD_QUEUE_TYPE_COMPUTE:
-		mes_queue_type = MES_QUEUE_TYPE_COMPUTE;
+		amdgpu_ring_type = AMDGPU_RING_TYPE_COMPUTE;
 		break;
 	case KFD_QUEUE_TYPE_SDMA:
-		mes_queue_type = MES_QUEUE_TYPE_SDMA;
+		amdgpu_ring_type = AMDGPU_RING_TYPE_SDMA;
 		break;
 	default:
 		WARN(1, "Invalid queue type %d", queue_type);
-		mes_queue_type = -EINVAL;
+		amdgpu_ring_type = -EINVAL;
 		break;
 	}
 
-	return mes_queue_type;
+	return amdgpu_ring_type;
 }
 
 static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
@@ -250,7 +251,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 						(qpd->pqm->process->debug_trap_enabled ||
 						 kfd_dbg_has_ttmps_always_setup(q->device));
 
-	queue_type = convert_to_mes_queue_type(q->properties.type);
+	queue_type = convert_to_amdgpu_ring_type(q->properties.type);
 	if (queue_type < 0) {
 		dev_err(adev->dev, "Queue type not supported with MES, queue:%d\n",
 			q->properties.type);
@@ -299,7 +300,7 @@ static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
 	queue_input.doorbell_offset = q->properties.doorbell_off;
 	queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
-	queue_input.queue_type = convert_to_mes_queue_type(q->properties.type);
+	queue_input.queue_type = convert_to_amdgpu_ring_type(q->properties.type);
 	queue_input.remove_queue_after_reset = flush_mes_queue;
 	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
 
@@ -468,7 +469,7 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
 	queue_input.doorbell_offset = q->properties.doorbell_off;
 	queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
-	queue_input.queue_type = convert_to_mes_queue_type(q->properties.type);
+	queue_input.queue_type = convert_to_amdgpu_ring_type(q->properties.type);
 	queue_input.remove_queue_after_reset = false;
 	queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
 	/* pass the known bad queue info to the reset function */
-- 
2.43.0

