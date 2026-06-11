Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15123CD98C6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 03:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A202610EC8D;
	Thu, 11 Jun 2026 03:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="clPhahjx";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CE2410EC8D
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 03:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrAwNzKECokoAU2fn0GS+Y0PjSYitNBDzpJVjS8DxjqAruIArQCQmvMvgTOIetquqEZ09i9j8BrJ7tc4qpgvh4VzDivYXtxFxVSuRm90iXei9s0lZ3SkTa7fc7WkRgcIzKqPNve3qmvuSVz/YRvmfJ9l66jR6CBDw5eoykZHT2X+9HHFjOAEW5jXQ+i5FGt2+95UM9eSQxjcjjVCQLfI2VFjJbyYydG3iYuzCSgJF9XVvEa4/Xzmqvwc0YRNh6vpZ2sNWcPm8PQmAhHGiF8Jt/oEDa8TYsv0AWw1H7VuMUY5ba/U+PzMnh9vJwuc1ev0SjZHASz1SvRYXyB6A44/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3rIWFq7brMagc0xRcBQVkkCuA3NhvlEbSW03CoMzhc=;
 b=AVhV/TquJT77oJKNy/JQowXSVeXqZsKFSxNFHARr8PIl2kYEY/EJbZYlZwkTNe/E1U+yFY+BvfAxhmFDnTQ0og+fw/M6fta0PzZ9vA8TShn92Pvyo3p92JsHUZI4kxC4f6siS1qwK2MLft/ivEHY0rSiPH1ZKR8PZzym9U48vROOD4lb0G9id/OcJ87cvIoNVesX0e0jqLgY2eBEl2LgYvqMB07mRbDUPpEBXt28My1s/USwnHLPEKbsiAEVNU9MPxR6Vcq/hU1TdmxW4MmhaHm429n4zBMnkW6mzcQPuCAp3vQhIvQ7TS/GsFH3rnAZzwm6JdXjmeAsdWM+Dl60KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3rIWFq7brMagc0xRcBQVkkCuA3NhvlEbSW03CoMzhc=;
 b=clPhahjxyMhaN8vVBz3TGh2zDmIlcldtxGowIntC2d2pZVmjn3WdxhgYBo9TrKYzPVWtBiUs7Ja6Hhu2NPn+vw7nSY+0kiCE2YCkxcSlHXH8Du4x2qet0vS5+SXBCCwgz3fu1wtxNaDqfV4hWgkS8VwGzAbd4LDg+6h2xVCp6NI=
Received: from MN2PR16CA0051.namprd16.prod.outlook.com (2603:10b6:208:234::20)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 03:58:02 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::56) by MN2PR16CA0051.outlook.office365.com
 (2603:10b6:208:234::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Thu,
 11 Jun 2026 03:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 03:58:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 22:58:01 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 22:57:55 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 2/7] drm/amdgpu/gfx11: handle error interrupts for userqs
Date: Thu, 11 Jun 2026 11:57:29 +0800
Message-ID: <20260611035747.548780-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260611035747.548780-1-Jesse.Zhang@amd.com>
References: <20260611035747.548780-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: ac039317-0783-43fe-4b14-08dec76da252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xJl4xnzWCkSrr9Ex6/aTx+GP0PKFpXQA8hG2KnXZsGb3krWuZjfRgCohUabDKEZyZslcVzbnaFlcQUk6HNZJRlV7PLpNoLxFoD+auYvuqvThjuy4aIWNwzbkbzgaRLEtFx8xlQzFy+xUPzXiyWbKgii9ApFGh1ogkg791XWkzaYE0R80Q7D+hKtY922ZDNUzBH7Vahj9WuDh8Ek/0fqbq1v5GYlnzXJeemIokHHU74v0Opv6c1aUCLjFrC9PbJWMaVoTElRwIGGzr9DEZ5q4maQoR2RgIs9xvEyDrA56aHgz6M4aSVQdXGi6Ynbdi8iB3ha5QWzfSEChBIpmHGXcjSL5FARqQnTfjxvM3+qf+x7k9Z1FG6ZikTrGCXSGq5c+s1iNwiu+XlSrhwC0rsafNbacWK18CcG+bINhRhGboGXDGeWZjDpQeJlVaqtzRdoWwtWF+zAgBYYxsgYgn8lu04Eabi8qIqa6ybzl8s11kqXhbOaVLlgZrbTbFPkVJ1EIOvO0TA51j3o//JMo08WGoqcxwG5o5IABGgc6EpF7bBexHviNt01pzoDsrpBQfE3wU5wUEN1Em+bYweMLOAY1ecBwkSDw8g8jljBs/jPbzfCbFFisnKjs5vvBKMjiuygAJZUOJSWuhtQHdJnfbl5q3/EhElrL/2sOb1RbQZpH2wlLdSvr5dx0vryy7Dx6bekRkjkZA/4znYNYmG3ipTBvHsioO8rKCAkpiFRKRIkJzP4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zN4SNBOAfN0mD7Zv7Z1aSdtSndL5yqV0CnoP4qTwW8gIlvLdEUbPo/L5cI098CLTuFxPGPPaLr7quMMJzM0KjGCkQJ8vx4o0hIMkKbO0eqby+0S0uTOl/QE+aORTyTgTYBXSDit9qoOPeIKtOKFeClFgtraW0h405H4R5timqfIWVuEMQiyOp1Efxa4U9sFhonuxcH9D/6O1BWk49ugP7cEug8MzUwB3k5XPbOf0/k91/8duQ1dfcAoA64tQO17uEXbCcRugk7PDjDOoGFMN7TpCYCz60OQ7viVuLJp/0ikMUrbo8iKrkOaESphpg8qz81jbNrTARE+WC8u8mIET+4e/xgWDcrLvMypKCgWRkQBoksI3ClJXcATt6K0MGJLvMOmbXtsJxJloTOjqaW7HW2DBRp5kVGm6djGspCKgbDMXmQ9rnb6v60iCRD7T95Wr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 03:58:02.1410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac039317-0783-43fe-4b14-08dec76da252
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941
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

From: Alex Deucher <alexander.deucher@amd.com>

Call the new userq reset helper, and dispatch KQs first by ring_id
before falling back to the user-queue lookup.

v2: squash in fixes

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Co-developed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 32 ++++++++++++++++++--------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0bd9d8a21f5e..c49a31a3789c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6681,22 +6681,29 @@ static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 					struct amdgpu_iv_entry *entry)
 {
-	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
-
-	me_id = (entry->ring_id & 0x0c) >> 2;
-	pipe_id = (entry->ring_id & 0x03) >> 0;
-	queue_id = (entry->ring_id & 0x70) >> 4;
+	u32 doorbell_offset = entry->src_data[0] & AMDGPU_CTXID0_DOORBELL_ID_MASK;
 
+	/*
+	 * Try KQ first by ring_id (HW slot is authoritative). The
+	 * KMD compute_hqd_mask contract guarantees KCQ and user queues
+	 * never share a HW slot.
+	 */
 	if (!adev->gfx.disable_kq) {
+		u8 me_id = (entry->ring_id & 0x0c) >> 2;
+		u8 pipe_id = (entry->ring_id & 0x03) >> 0;
+		u8 queue_id = (entry->ring_id & 0x70) >> 4;
+		struct amdgpu_ring *ring;
+		int i;
+
 		switch (me_id) {
 		case 0:
 			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 				ring = &adev->gfx.gfx_ring[i];
 				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id)
+				    ring->queue == queue_id) {
 					drm_sched_fault(&ring->sched);
+					return;
+				}
 			}
 			break;
 		case 1:
@@ -6704,8 +6711,10 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 				ring = &adev->gfx.compute_ring[i];
 				if (ring->me == me_id && ring->pipe == pipe_id &&
-				    ring->queue == queue_id)
+				    ring->queue == queue_id) {
 					drm_sched_fault(&ring->sched);
+					return;
+				}
 			}
 			break;
 		default:
@@ -6713,6 +6722,11 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 			break;
 		}
 	}
+
+	/* No KQ matched: HW slot is a MES-scheduled user queue. */
+	if (adev->enable_mes && doorbell_offset)
+		amdgpu_userq_process_reset_irq(adev, entry->pasid,
+					       doorbell_offset);
 }
 
 static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
-- 
2.49.0

