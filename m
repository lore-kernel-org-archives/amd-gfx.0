Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C362C369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2790510E57B;
	Mon, 28 Apr 2025 13:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DcuzDTmd";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 891A010E57B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFfLy9QIpiE2PtsAku9RuampR6l4JppUBNdB23Ee/ZmILFLS1i1Z5AaEd9RiB4OViGQEtKqhvWYTWncg6QHGV+O+uthGPyhM3gz9GaQ49wSWhGUY/DBwGTXnzEL1Bw4CDe/z0ySkmJNKqEZeCVdhKsLus3/Hp6xjEpbFpSIdrxweuVZ+J8XHmbiVikKXTUUZEpb/j49q6YCF7vfJvK0Z0e9TlaWOGJekQLfaJ53+E3vYsjxJcuBwTfqI26FYtEmN66edaqHEX2x9LcDnOOhjQfUDcMGcaBydmKzstaI0T9+/2+F1xXLRDvKB7otpoNsBPt5pzJ1h963Veb8nYPAWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZdEX0jGlwet3bMeBPfay2hSvwes9VGIUT8+w6NnAFA=;
 b=ErZWrcyxppteNuLlKeDy7oeEiR9o6rFifeE67WmMRuseyQnl2OybW75hMDjO7UX10YuXx94avWmJk7be5vt44vhRkfZQGT7hOMa6iZ1kVtjr1CjWQ9HDBfmJ3iYEp8VI8l/c2yCxU8ZaP+8OQ+T9tlfe0Xs+OKy6lIVMbuiH6pi3EVINM2k8GvsJAg/flVT8t4LubzNQpBiF21Q2yvF4VHpjdbtaXvZqkc8hFTjoYHi9/K/zEl2Dx+ivJ2D5XE+nNFiVAbj8lTCNCXDwkkYlra6tuKpSTRYf5OuwPEgE/bSRoRHFSNDDWiftC+J5Zwj5XLoDKChBmh8gfLhZXdH/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZdEX0jGlwet3bMeBPfay2hSvwes9VGIUT8+w6NnAFA=;
 b=DcuzDTmd9nlZtRZjMJ77mXW9batmQLFLahwrTWXGzXp3TZ4wMExSkwMf5IEDyAQxPNJ4ZvZ/GX471Rad8d1xltmigOtNuDbTnj30yPpIXhO+lQKLUTQx8Sz/7Y14gT4s+BsR6/bbiBydAELji/IfE4QfKqGSERMyEnXsOFiNf9w=
Received: from CH0PR04CA0066.namprd04.prod.outlook.com (2603:10b6:610:74::11)
 by DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 13:57:57 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::c8) by CH0PR04CA0066.outlook.office365.com
 (2603:10b6:610:74::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 13:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:57:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:57:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:57:55 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:57:52 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 28/28] drm/amd/display: Only wait for required free space in
 DMUB mailbox
Date: Mon, 28 Apr 2025 21:50:58 +0800
Message-ID: <20250428135514.20775-29-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|DS0PR12MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: 060c3cc7-55b5-4e7f-055c-08dd865cadf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pdGzwBb+h1nNBeH4w8yxaSY/o/Ih5ieQVoOlR/mZ9pepPGelZQctB8iR/qok?=
 =?us-ascii?Q?KhY/G9mcjGy3B4s0LeMBfZnvsvBkVvcFQW+b9T6Bu0kC08+s7ImU9QMBtQsS?=
 =?us-ascii?Q?WSxsgm6GHZipSGGRwC/2p4OIftsLVVXvnVV/VfVHigguWIZ7P0KHISOgFBkO?=
 =?us-ascii?Q?ev1YNz0YfNecEaBEMZ8duLNccO7oRola42dXkODun7Dv+wkvVN4s35zvvYFq?=
 =?us-ascii?Q?FMFS0YDxNMaJVpL31LvKmFaierdsnLBuDdyyBixSKzgsHjocW08P1wME/XrE?=
 =?us-ascii?Q?u0NLm8WR+7oz5nuTPl7bmQHFXJHyfmZOjK1vhgRGw91hUMm87NZQAHC95lgn?=
 =?us-ascii?Q?qiJNPR9MhExb+lDJFuaz8mdg10i1UENEd+mhb5/JJEVPgfTkEbrTCW+96ayT?=
 =?us-ascii?Q?LVmXIrdXAYcQJYVbZOvXmXPsPV9642sYSxokxpk6vkkIeiM3qtsFonPOBG+R?=
 =?us-ascii?Q?37IM7CCg8pN1a8kvntT44xy/Avg2DnaLTSfKvqu9f5VO/iaNrYQmqCCWwBeQ?=
 =?us-ascii?Q?2DUHCRDX2LUrQK5aSz061sHU2N3Ir3HmUQxfgJNbm/0kpBPVoATqPwIRjzqc?=
 =?us-ascii?Q?WInqrbSgxwDux9QCRr7IWYoWWaXxBXr6zZ9cbrQLdupw0BvTZyjcIzmBzV/W?=
 =?us-ascii?Q?ttJlk4YONKnxxpt3/90dl/gBAW+gHxVe/V5iCY/DXToeYPDRceytS4I+fPbQ?=
 =?us-ascii?Q?rWs7mAqtTni8qUbl7MvMDQjJ7EW6aypC29yU/FlBaB/8dqdnu2eV5J+j5+hz?=
 =?us-ascii?Q?UIjgUZBb6vuWjnzGGwMtPNcysXxaZXZecOjPU+Jd6ZUreE98pCXVDhet81Si?=
 =?us-ascii?Q?qqbj/NwrEWA1lspmlcUd1yobCY9dr037Dm5gwQqHLrD65TrBCxt9vgo74ayV?=
 =?us-ascii?Q?bFxJCSqo3hOXWTOiVmsv73Vzcw/tp4b2mP8WoUwIx4yGI7WS/Y3dcrUISUoS?=
 =?us-ascii?Q?gzjmFO8Bl2Drfd7rj+7rwUfZbC8p4AqpJL6gFNSUOGvf5zILbir8hPYd8n5T?=
 =?us-ascii?Q?j3LBWXYGqn5k4guVgrfKtAOyb7KIrReFal7ihug49PPJ9U9lS4Wq1N46KDOv?=
 =?us-ascii?Q?9CrmjVwdR7urb9kNR8oLmSR+QrNYsRqB1UzPDnEUlOJbiuSeacBRda2uSYIF?=
 =?us-ascii?Q?7o//6OrhObAr/8XfCv204CNXaKq3zulESWpt1jf2RdFA7pAQe6aLz5dFvcsi?=
 =?us-ascii?Q?4PzOTnxhezBmaJ1ifiDBUSD7UW6l+jsvW3k1Cqn63IvpnuKEAE1+5gFa7BSQ?=
 =?us-ascii?Q?KhZH0+DemPnHWNduh200sRvLpdijYxyYSuzw3yP/V/p/R+jHRpDTS23NFMbl?=
 =?us-ascii?Q?CAsC5CoGgU92Y+F9KGFiLdaIBcI0zqhl0MDEV0OY0Xs3uFlWqDxk5awyOxKx?=
 =?us-ascii?Q?FR3quDt1rHO3lEHKptTjcDavyPcHMqlcMWqhRMtCbEbliUG8W27X6rjK8nxU?=
 =?us-ascii?Q?Moz/nbTzjnwuBcuoHA3ZosrJ80969j2pAoMgDwCuIXdM0ggBLj8CcL3ci+or?=
 =?us-ascii?Q?84L7wfG+XEqtSyE/z+JOKQOpp6KoYQNlxnTZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:57:56.9327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 060c3cc7-55b5-4e7f-055c-08dd865cadf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9060
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
When command submission is blocked by a full mailbox, only wait for
enough space to free to submit the command, instead of waiting for idle.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 19 +++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 72 ++++++++++++++-----
 3 files changed, 76 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index a3fbb9f5b4a6..6115b5364394 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -207,7 +207,7 @@ static bool dc_dmub_srv_fb_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_sr
 				return false;
 
 			do {
-				status = dmub_srv_wait_for_idle(dmub, 100000);
+				status = dmub_srv_wait_for_inbox_free(dmub, 100000, count - i);
 			} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
 
 			/* Requeue the command. */
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 440a426b81c1..e759ce6ca700 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -1034,4 +1034,23 @@ void dmub_srv_cmd_get_response(struct dmub_srv *dmub,
  */
 enum dmub_status dmub_srv_sync_inboxes(struct dmub_srv *dmub);
 
+/**
+ * dmub_srv_wait_for_inbox_free() - Waits for space in the DMUB inbox to free up
+ * @dmub: the dmub service
+ * @timeout_us: the maximum number of microseconds to wait
+ * @num_free_required: number of free entries required
+ *
+ * Waits until the DMUB buffer is freed to the specified number.
+ *  The maximum wait time is given in microseconds to prevent spinning
+ * forever.
+ *
+ * Return:
+ *   DMUB_STATUS_OK - success
+ *   DMUB_STATUS_TIMEOUT - wait for buffer to flush timed out
+ *   DMUB_STATUS_INVALID - unspecified error
+ */
+enum dmub_status dmub_srv_wait_for_inbox_free(struct dmub_srv *dmub,
+		uint32_t timeout_us,
+		uint32_t num_free_required);
+
 #endif /* _DMUB_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 07bb1d4c4287..c917a70b3c19 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -978,32 +978,45 @@ enum dmub_status dmub_srv_wait_for_pending(struct dmub_srv *dmub,
 	return DMUB_STATUS_TIMEOUT;
 }
 
+static enum dmub_status dmub_srv_update_inbox_status(struct dmub_srv *dmub)
+{
+	uint32_t rptr;
+
+	/* update inbox1 state */
+		rptr = dmub->hw_funcs.get_inbox1_rptr(dmub);
+
+	if (rptr > dmub->inbox1.rb.capacity)
+		return DMUB_STATUS_HW_FAILURE;
+
+	if (dmub->inbox1.rb.rptr > rptr) {
+		/* rb wrapped */
+		dmub->inbox1.num_reported += (rptr + dmub->inbox1.rb.capacity - dmub->inbox1.rb.rptr) / DMUB_RB_CMD_SIZE;
+	} else {
+		dmub->inbox1.num_reported += (rptr - dmub->inbox1.rb.rptr) / DMUB_RB_CMD_SIZE;
+	}
+	dmub->inbox1.rb.rptr = rptr;
+
+	/* update reg_inbox0 */
+	dmub_srv_update_reg_inbox0_status(dmub);
+
+	return DMUB_STATUS_OK;
+}
+
 enum dmub_status dmub_srv_wait_for_idle(struct dmub_srv *dmub,
 					uint32_t timeout_us)
 {
-	uint32_t i, rptr;
+	enum dmub_status status;
+	uint32_t i;
 	const uint32_t polling_interval_us = 1;
 
 	if (!dmub->hw_init)
 		return DMUB_STATUS_INVALID;
 
 	for (i = 0; i < timeout_us; i += polling_interval_us) {
-		/* update inbox1 state */
-			rptr = dmub->hw_funcs.get_inbox1_rptr(dmub);
+		status = dmub_srv_update_inbox_status(dmub);
 
-		if (rptr > dmub->inbox1.rb.capacity)
-			return DMUB_STATUS_HW_FAILURE;
-
-		if (dmub->inbox1.rb.rptr > rptr) {
-			/* rb wrapped */
-			dmub->inbox1.num_reported += (rptr + dmub->inbox1.rb.capacity - dmub->inbox1.rb.rptr) / DMUB_RB_CMD_SIZE;
-		} else {
-			dmub->inbox1.num_reported += (rptr - dmub->inbox1.rb.rptr) / DMUB_RB_CMD_SIZE;
-		}
-		dmub->inbox1.rb.rptr = rptr;
-
-		/* update reg_inbox0 */
-		dmub_srv_update_reg_inbox0_status(dmub);
+		if (status != DMUB_STATUS_OK)
+			return status;
 
 		/* check for idle */
 		if (dmub_rb_empty(&dmub->inbox1.rb) && !dmub->reg_inbox0.is_pending)
@@ -1313,3 +1326,30 @@ enum dmub_status dmub_srv_sync_inboxes(struct dmub_srv *dmub)
 
 	return DMUB_STATUS_OK;
 }
+
+enum dmub_status dmub_srv_wait_for_inbox_free(struct dmub_srv *dmub,
+		uint32_t timeout_us,
+		uint32_t num_free_required)
+{
+	enum dmub_status status;
+	uint32_t i;
+	const uint32_t polling_interval_us = 1;
+
+	if (!dmub->hw_init)
+		return DMUB_STATUS_INVALID;
+
+	for (i = 0; i < timeout_us; i += polling_interval_us) {
+		status = dmub_srv_update_inbox_status(dmub);
+
+		if (status != DMUB_STATUS_OK)
+			return status;
+
+		/* check for space in inbox1 */
+		if (dmub_rb_num_free(&dmub->inbox1.rb) >= num_free_required)
+			return DMUB_STATUS_OK;
+
+		udelay(polling_interval_us);
+	}
+
+	return DMUB_STATUS_TIMEOUT;
+}
-- 
2.43.0

