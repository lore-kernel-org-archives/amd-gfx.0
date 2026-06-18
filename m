Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA87CD98F9
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 04:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39EF110EBF2;
	Thu, 18 Jun 2026 04:44:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hs0/KY/R";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CEA10EBF2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 04:44:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEIxmRQXgwM6hPoOJHQ/mWFOz0ZvULfkMzNu5G9KHhOo7W5FVFZ7ky/S2M53iOsyeTcK+TI7lWlfERKs48dC+AtV5QSTh41eoUavHozTgeWfVrS5ru8ViQvxVAj+qB0Ro50ETrbD24wSvdAYL10MFQMYeVXvYtUXcW+BrGI3fG6WdL/wEC9cJBCzyNOmWIfFNwqmqo0HeEUJ94QRhuMJbIAh7ykz9OkgCx3G5jPpLUrZmA3qXZ03NQ7N3GSXjSbJ3FO+AikcFkmV8dANcZM7veBkYXYwVvKdT3pekeJ5lTjEGZ9uxAivwFsCZMqacyde8IYl3TJNTwy85l60Ijd71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUC7bx+4yS62mdfJQPWGOyq050WDTMXScrl95LRO44I=;
 b=FIgfVBrMva2VkiSy433ZxvLseze83D6xw6fW03YWDSzPVO0eJg0YWYrddDdTcV5d9+LXiWT2R5tP2rboEz+2C1UkSkxHdJ2YwGqNUO/2QUDEAD4VvDzk92HSjI2GDeGBIlXekzr6jspI87QIX+LiN2P4Xv+POVub940baAppSsRNU3P3ZJtUZ3XfD492VWAHsr74jU916pNwQbt/fEpIvV4asvibvj7Cb/r3kDoaaMKeJjPfW91KBW4o7ioeXqxudf5N3zNV5mCcOjc1kA6IxobtWYH0I9PxU5fm/Zn/WRHv5fqjO9fMcRRwz/K3l+bYH4j0zFB0M9TSCRHnmnJJCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUC7bx+4yS62mdfJQPWGOyq050WDTMXScrl95LRO44I=;
 b=hs0/KY/RlrcUeRQKQc2FNXy5TXdwWliVcM4hxXEfv/6nCcEpJgHdJkTjbuzNDYXzJPhwO3wanptvM9ax0thMNKY53+v+gBwSXHlV9CGf4uo7u2vGHqZgB27heXHj2Kt0w/LS0ukRadJQGAHE2mrSO0lpSE90jrWAcEy+8dRUWss=
Received: from BN9PR03CA0484.namprd03.prod.outlook.com (2603:10b6:408:130::9)
 by DS7PR12MB9551.namprd12.prod.outlook.com (2603:10b6:8:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 04:44:31 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:130:cafe::35) by BN9PR03CA0484.outlook.office365.com
 (2603:10b6:408:130::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Thu,
 18 Jun 2026 04:44:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 04:44:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 23:44:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 21:44:30 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 23:44:18 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 2/5] drm/amdgpu/gfx11: handle error interrupts for userqs
Date: Thu, 18 Jun 2026 12:43:37 +0800
Message-ID: <20260618044405.1724370-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260618044405.1724370-1-Jesse.Zhang@amd.com>
References: <20260618044405.1724370-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|DS7PR12MB9551:EE_
X-MS-Office365-Filtering-Correlation-Id: 724ca75e-8bf6-4fc7-b3b6-08deccf4493b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: kPKXypiNuC1s5XY5lFj/kZYvuoOkwplBsRCR7cIEsSL1gt8V8/NvmydsIA1ArpGUYd6Kr0KTQZ6+24A9RWhd4XbHDmbV6CLfAOUz0G659GmQdJMZ0ePH23mIW01vXDL/MUsoYEvCW4OgWjTKMinTzNmku1A22RrotKONee5nSfLXmk6JEScDQCVkZ33dl2RAwxJWqAgaUr9zFaxuMx6To9DjeJamjWPTJVdNBlDhQ1BdKkV55/P9wngp02TXYFBfuDIkfjvudvAemte1tFgmNgOtuk5LIet3kdO7TQyvxrTESMW2WGQPuX3hIh97tLXgb6RgjoSwrta1L3Z+OYRVVWO28pC7BMjP1bda1LNbjxXWqgB6pGr7ofzdHVzBhaLkfuUG42tcDYXLnDkj51RCwmAf9pUkCwqerUUDmMb0IcpkgkSnuy+7NAN1+65qfsOjktUOO/KwoNUkEgwWNyMiG2lz9wHojptknaXhAwgVVzus4LiHXrIYTWJf9DYrO3VinoR8B5b4LbV3PZCOZLRyIJtW3lPiF7k/E8QGKUojbgoK4g2Vf9g4hC1Bw+h/5knaaQE/ZPXYiUkEvRLFl5ayhdhAO4Mw57kuzwhG78PmeWjHOomyv2w2BrBxWMHPjyvJB5Gzbr180Zc6gNjTzpTXfnHqYC5lfEMrX6qWceyDVfZMoNRsbT4TrdwYsztmvkaXDX8nppkJJKms8WcOGaRi9NbhA0u9cpUb6u8qDN7adNA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pFgAWeZ7UdLKtH0vJk/dC60M8fIj9BzucovCPQFrT5d+zbZ4yAFpdRJVpAQMlSjDhFPn2BuLWNQYgGjCBvlRe+AoJkIjU1UQUfmq4MBfWEUeZXN8jHq6tIpySsEdJpv0YyblevzMTs0dDkcT+0VQ5vajiOnBD0GxUr2KlWORu0u3p+oYLjYfBqB0PYPQokhWkdavd1vnviB61tZ61EzcC13QnF9NPi50dr4Smdz2GMoGcs4NY5V1Bf+b0lSgFVv0B6wcOCoEIqLhgMIN7y6tMAitvvdhwjeKi20xexSGp9s0EY9Kfgr/hGqLTyLYAaCTA/T//ZKFPQn6afzQ51k+g1+U2qbcFQl1DiuvirlYGCpwcbB4KP5RJvP8a8MfvRS7wX30DO5ZPQdF7WhKFAYkiywZmoePcUpiHzblsMrq35Z8Y1WSJ5faW/tPkg6i6ers
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 04:44:30.5524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 724ca75e-8bf6-4fc7-b3b6-08deccf4493b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9551
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

Call the new userq reset helper, and dispatch KQs first by ring_id
before falling back to the user-queue lookup.

v2: squash in fixes

Co-developed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 32 ++++++++++++++++++--------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 6346f16c4e61..7c86beeb058c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6683,22 +6683,29 @@ static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
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
@@ -6706,8 +6713,10 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
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
@@ -6715,6 +6724,11 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
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

