Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3890EC54FD2
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 09:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9379410EE6C;
	Thu, 30 Jul 2026 09:40:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aZW6j/E+";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5895110EE72
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 09:40:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5gAFzk6jndB+k5w6gnbRRGeMMvy6KMCuFVFmjMmy1QrwhaxFdDR7wNP6XYBqAgP8i+3MpuSYkNBirzvYbekadbBiNTeSVU1Aih/bn0GJ1OudsTHJMCUXprItwsTH4G+5u1fnGT4ZjO25DQU+sJLxym9QScgzPxqBgZKfI9VMZ+SPoZSUXKpNb9/+QIkbXnlkXkS8ZfSeLyPIwVQTRcGyfVHeIf/psQFE1R6mxd56S7XaYr6Qbm7A0U01s97iW+7Vy7IkvNId7j1+68418pRA73R7WbnsIvXPlblKtsoUeMwXR7d6mzOHQ1jsah5TmU+qCoi+i5u9YjViRbJEUDr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GllgPBfY1+zwQEoOXT08rExAEaY49NyU4eaIrHROMzE=;
 b=x5wF/+Ut5L4g/SGLLm9JB6sA/wl8FYNXari8GKj6Gd2KSqRIvli+26LySSSwv3lEkj4DpcUdULTKgBaWvTDjYBxV58YOShkBlt2EeRlN237nj0MtC4VELG/BJ3d8Zznz2AsX1aCHhgYm9nbnwmbGY2aeghz1yeFwkHsQK1z9VEC3b0kFTTclXAnM6s11cYQxpPn1tQb0qP+kbj/IwfJmdLBHNw01Z8b+JaaYeXF4AjVIeI296PX0+rhfEjemW6B6i4fYnlAscYdfn0vFYGOoxLtDZjEO0LZpsp/fTXXRMwQJ6K9R+i0G4t+NqsW898TzuejgDQahD5zAC9bkwQs6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GllgPBfY1+zwQEoOXT08rExAEaY49NyU4eaIrHROMzE=;
 b=aZW6j/E+Un7Zz8+lRLyAOCMuI64JuFH8af8k/QGcpsIvT636YOXTv+nWKKMPghp/ytL3DYGxyRigV8zkVd4u0r+Vp+CBzgrhI7K44r2fpJl6MgdLlBJWmrQ+iYswf215sDcYLkben/D3x3r9tmDAIcbxNt42TgJunfgmhedg3Es=
Received: from MN2PR15CA0057.namprd15.prod.outlook.com (2603:10b6:208:237::26)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 09:38:51 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::92) by MN2PR15CA0057.outlook.office365.com
 (2603:10b6:208:237::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 09:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 09:38:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 04:38:50 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 04:38:49 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 30 Jul 2026 04:38:48 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Chris.Freehill@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/mes12: use basic+ unmapped-doorbell handling for
 concurrent AQL queues
Date: Thu, 30 Jul 2026 17:37:30 +0800
Message-ID: <20260730093847.2250791-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e7c8d7-7408-49a2-2bab-08deee1e5cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: PJnD5L/V9uD4Xwqrc1KJGe3EGPkBjOCLWCCTcj4wyrM7ndn0OWbvTxo5brmKx9C8oIV+2IAUp5XX4dAQrgO6EjTwnkHCc0w0MV2sMLXqGbxL9lAFgnDHZy8GKjdQ7RhSIfvUEdkSZ+0oLVt2VdcHGizVHoGDShH3RnodkKFNmOK/cY5N+6hpu3fTHng/Ph7fW3sHZKvuXD+MRyiZ4qHw8Tp4SqgeUWOvTiH0p85qL8w9lL7Fon3CCpXr/XzsaTzEGOYuClINrkAprYKbBTdUd66LWgMXjazDidVzkUn0q5R8dndL4dDq/A+DOuLs/7mUjWL+QWbfo33T8HSzMOmHKe4kOLfxp/tAk4nR9U6Gk/yl1WPx9PdrbV+oCCdQrwkNLPiM9kfMcDKqKokCoXcQPk5yUhVTFuZAsrPCcTqpPcejtkjvyZdx72WsPueS9C10kkhTnsuoWo6Vwb5d8sUj0ES4mLOg0X54PAJfqQQ/g4qJQIdn1Uak9f/4mMUYKn6Yi5xc8UAC+isPA8mDyt9I8zRncHJOoqrrJiEd8+u7OVAr4zDlhWJL4V0q9RQVCFYL3dLvLiPRDykWxlBqIvMCKXKARq1ITqmEnZIoRJ3JCh5Mu3+SPmfPiXTUk98Pmsj2qEfzWBsJ43EX9zBSupVbKEGWWmu4B4ouoggA1eCK5jw7okZ1v3+KPejH18JItCv9dm9x8oCbu5Q2Tyn6Baqh9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a6yuvL+VmmNb3Mi1BwW26dorVjoPHrChLlLWT49f7RDLqmlVaBZo3giirJPPeQtIyRjUCMfVQ1PafEPFXWyX880+0Qwq4TMg+tQuo/VAHAgMlE4NPo2o6u6rvUwR1ce6dd4hpcD7+MVk4zOOafOMqdsutbsYc5ZuXRo4XCNhwcI1s+vHodURrg52afJAyHnb+uSiUwc6sMzEJmNI/pRNJ3EFyow793tPUSXewhCXihnWqZHijCkiUn0hqZdjnyexi5znxGOeJiVAlAZ01WyS2mnhSq4uLciMn6g2TdUSJoiWl/Ytn1nM0d9r61Y9Z6PRP6TQW2rfNA18gSsTYcIsS41ODfk5t+Thft4CUXsUZxlSQNsNed/KuOPyt9VITQ3iNXz2d6Hlo6EiaTtTYCrH89f4aYvDZp9RYxH5cKWKBWchC+kLoe/fwZZW7Ca0iFKF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 09:38:50.4586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e7c8d7-7408-49a2-2bab-08deee1e5cb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633
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

On gfx12, concurrent dispatch from multiple AQL compute user queues in one
process can intermittently stall one queue's first dispatch: its completion
never signals, while queue creation succeeds and no obvious dmesg error is
reported.

With unmapped-doorbell mode 1 (basic), a doorbell hit only sets a coarse
level-wide hasReadyQueues flag. Queue-level selection can still be filtered by
work_done/is_queue_ready, so under concurrency the ringing queue may be
skipped and its new dispatch not fetched in time.

Switch mes12 to mode 2 (basic+). In this mode, MES consumes per-queue
CP_UNMAPPED_QUEUE bitmaps, identifies the ringing queue, and clears that
queue's work_done in the unmapped-doorbell path so it is reconsidered
promptly by scheduling.

Tested on the amd-unified-interface branch on gfx1201: multiple
concurrent AQL compute queues now pass repeatedly.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 04465804c254..5f9e28f8f007 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -990,10 +990,21 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 	/*
 	 * Keep oversubscribe timer for sdma . When we have unmapped doorbell
 	 * handling support, other queue will not use the oversubscribe timer.
-	 * handling  mode - 0: disabled; 1: basic version; 2: basic+ version
+	 * handling  mode - 0: disabled; 1: basic; 2: basic+; 3: basic++
+	 *
+	 * Use basic+ (2): on an unmapped-queue doorbell ring MES reads the
+	 * per-queue CP_UNMAPPED_QUEUE bitmap to identify exactly which queue(s)
+	 * rang and clears their work_done so the scheduler re-maps them. The
+	 * basic (1) mode only sets a coarse level-wide "ready" flag without
+	 * clearing the ringing queue's work_done, so a concurrent AQL compute
+	 * queue whose doorbell rings after work_done was set gets skipped by the
+	 * scheduler and its dispatch is silently lost (intermittent hang with
+	 * multiple concurrent queues). basic++ (3) additionally map_gang()s in
+	 * the interrupt handler for lower latency, but basic+ is sufficient and
+	 * touches less state.
 	 */
 	mes_set_hw_res_pkt.oversubscription_timer = mes_rev < 0x8b ? 0 : 50;
-	mes_set_hw_res_pkt.unmapped_doorbell_handling = 1;
+	mes_set_hw_res_pkt.unmapped_doorbell_handling = 2;
 
 	if (amdgpu_mes_log_enable) {
 		mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
-- 
2.49.0

