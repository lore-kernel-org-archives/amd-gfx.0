Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA58C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D72EC10E69E;
	Wed, 28 Feb 2024 18:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y7luqC8t";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA5810E69E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9aSOoF3zJVC4puCrjrndX3RbSUTWQcxFxx0Z82CNsnj/RegmE2QYEGaRGeW84BURPNxb2YmlyXXoQghmp02IdGFdZHce8whdTw0cFI/w44nkcEArr2BiKbRRHpzCiYVnFqxGalW9IOZUiZmEwO2Hv1iOXBIFpAbQ1zEdrHFSibgtQaAlIBYmNR60BF+rOcw1IYulmO6drGHGtYcSWnpIO94h/8Vamcq3NBVaCwdHfFWXoQT0PsmtbduRFBIwe/ydZ2Q/SzK3W+DcOKpeS+otYr7wan/rvp5DUBOPgArIY15myhbnjHA5q9wvY2S0dd5OAdqHhbGHL8+fi9+eJMvLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d8mcepLpetEtgICKoQdhCSPBC3G/lOko34r8B00jXo=;
 b=KhUCB/f46vI2PAWfWjeZEcr8OUEesmRsmMxJiQrvFC+95KRd+95Iivz3mhikHbmtV7x/tNd1kH2Jj47G3Y8EECChdogAcgWlUxLXYpzM9kKAB/w4pR2VbfYS+XeFMjCsapUoQFVPUn9bkNIiWzPBsZ3AaFrcMbc7PKKseO7Acov8R1AIRrOCBcdNdtCfOMXfKDo2QRRq30TYSg1rCpX3SvZPG7E9UMZ+WIqUcUrS37Xqw9jmlnq+FXo93HHa/0UUaTXp7Srd6BHJzKUlcPRFfWjvJUDvFc9ix1M3wrrx37/xX/PFCvHkCYyTnIfz2MToZQCVcj3VG+d78B0TMx8Xdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d8mcepLpetEtgICKoQdhCSPBC3G/lOko34r8B00jXo=;
 b=Y7luqC8tkqdjY/acysK2Wf+P12T69BmKw9q7zw8SSOkE0RzBKagxj3FjjjnAztQA432bTayTSpttlKp5GNBX1ot0iqNpw4HawdZ6wgfNOPUofpSBjslAoa+yMOO/ojqdyPMd9RejJSHzoLYnSZlkE8PfqflUznOiEJpFdelGoso=
Received: from SA9PR10CA0030.namprd10.prod.outlook.com (2603:10b6:806:a7::35)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 18:47:47 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:a7:cafe::6f) by SA9PR10CA0030.outlook.office365.com
 (2603:10b6:806:a7::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Wed, 28 Feb 2024 18:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:47:46 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:47:44 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Anthony Koo
 <anthony.koo@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 31/34] drm/amd/display: Update DMUB flags and definitions
Date: Wed, 28 Feb 2024 11:39:37 -0700
Message-ID: <20240228183940.1883742-32-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: d3424a3a-8642-4134-fc32-08dc388dc1a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++YnbCUzqs0xYqCujpjTriltjedBJOS7TkVNNUJYj3HbVXh2NTLXF7dcb20KAWJH2avmlqlMBfGfEP+/1If/NF/YQ+kdHTKq2C0qWEvCKiz+jFhT97fEBF7p7qutz7U6gPZy9oUkuyVrti5mPN6xyFuFP8J5ficVqX8ELyuPhGlF1E5CBStEruW5sJsH+V/bKpjiW3/Y6XFqxFaLDgNKp1p11tY3SrWlgc8ME1kS6HdqDUTSapTrOIANu5HATl2odLEZo1Zl+o5RfH2CPdElycSYr4gHUSPw3d5S1uBCCPQimDnuFzEzxgnDJ3yb2wkThu89XHUJUOC+4dZQu2upA/KnJ2K9HRkCj7v69NBtMeZFFax7R0OFS/gSZS4T+30ZMbVGJZWLz8PA/H7kRLjzb8SlcpV7+J6rZpurXmBJ1zJ31HRRuFslpLI1r9b2yLb9BuC8dDmB8jblHZEkghSv2YR76tLIgWvYHNo9kggGAjWUNV5c64iCUIg02ZCFXnpOVxkWHvhfU3s6+w5XO6PEq/QUaVXa/MUEPOsBXWKrtN9WjSZnDyVFeHYutWus5HF7KrW5gwwVfCp/zskqQcxmpvcbVGDCtdYTh9hEoDRVzEWC6GWT/FuPAu13oa7r2h/lVi7V06697VkSb1kAwbB6nK0LhSJP8pvZF3bbudrJtaE7bmEh1jpPzZAZ6eKEdLpD+FIhR1YKtkDn2FyYAU1JzwtniYY3Wq23EwZzemQ4TocFO6SJCw6Oqd1DR/U3ujam
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:47:46.9478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3424a3a-8642-4134-fc32-08dc388dc1a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
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

From: Anthony Koo <anthony.koo@amd.com>

[WHAT]
- Update replay residency tracing design to support more types
  including tracking PHY and ALPM residency types
- Add commands for Replay frame update count profiling
- Enhance HWFQ with additional flags to allow for more
  optimized IPS low power state residencies
- Add new flag to indicate if a new frame update needed for
  ABM to ramp up into steady state

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 40 +++++++++++++++++--
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index b010814706fe..4f559a025cf0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -244,7 +244,7 @@ static void dmub_replay_residency(struct dmub_replay *dmub, uint8_t panel_inst,
 	uint16_t param = (uint16_t)(panel_inst << 8);
 
 	if (is_alpm)
-		param |= REPLAY_RESIDENCY_MODE_ALPM;
+		param |= REPLAY_RESIDENCY_FIELD_MODE_ALPM;
 
 	if (is_start)
 		param |= REPLAY_RESIDENCY_ENABLE;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 4a650ac571d7..b81cd2649db3 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -194,6 +194,11 @@ union abm_flags {
 		 * of user backlight level.
 		 */
 		unsigned int abm_gradual_bl_change : 1;
+
+		/**
+		 * @abm_new_frame: Indicates if a new frame update needed for ABM to ramp up into steady
+		 */
+		unsigned int abm_new_frame : 1;
 	} bitfields;
 
 	unsigned int u32All;
@@ -2937,18 +2942,47 @@ struct dmub_rb_cmd_psr_set_power_opt {
 	struct dmub_cmd_psr_set_power_opt_data psr_set_power_opt_data;
 };
 
+/**
+ * Definition of Replay Residency GPINT command.
+ * Bit[0] - Residency mode for Revision 0
+ * Bit[1] - Enable/Disable state
+ * Bit[2-3] - Revision number
+ * Bit[4-7] - Residency mode for Revision 1
+ * Bit[8] - Panel instance
+ * Bit[9-15] - Reserved
+ */
+
+enum pr_residency_mode {
+	PR_RESIDENCY_MODE_PHY = 0x0,
+	PR_RESIDENCY_MODE_ALPM,
+	PR_RESIDENCY_MODE_IPS2,
+	PR_RESIDENCY_MODE_FRAME_CNT,
+};
+
 #define REPLAY_RESIDENCY_MODE_SHIFT            (0)
 #define REPLAY_RESIDENCY_ENABLE_SHIFT          (1)
+#define REPLAY_RESIDENCY_REVISION_SHIFT        (2)
+#define REPLAY_RESIDENCY_MODE2_SHIFT           (4)
 
 #define REPLAY_RESIDENCY_MODE_MASK             (0x1 << REPLAY_RESIDENCY_MODE_SHIFT)
-# define REPLAY_RESIDENCY_MODE_PHY             (0x0 << REPLAY_RESIDENCY_MODE_SHIFT)
-# define REPLAY_RESIDENCY_MODE_ALPM            (0x1 << REPLAY_RESIDENCY_MODE_SHIFT)
-# define REPLAY_RESIDENCY_MODE_IPS             0x10
+# define REPLAY_RESIDENCY_FIELD_MODE_PHY       (0x0 << REPLAY_RESIDENCY_MODE_SHIFT)
+# define REPLAY_RESIDENCY_FIELD_MODE_ALPM      (0x1 << REPLAY_RESIDENCY_MODE_SHIFT)
+
+#define REPLAY_RESIDENCY_MODE2_MASK            (0xF << REPLAY_RESIDENCY_MODE2_SHIFT)
+# define REPLAY_RESIDENCY_FIELD_MODE2_IPS      (0x1 << REPLAY_RESIDENCY_MODE2_SHIFT)
+# define REPLAY_RESIDENCY_FIELD_MODE2_FRAME_CNT    (0x2 << REPLAY_RESIDENCY_MODE2_SHIFT)
 
 #define REPLAY_RESIDENCY_ENABLE_MASK           (0x1 << REPLAY_RESIDENCY_ENABLE_SHIFT)
 # define REPLAY_RESIDENCY_DISABLE              (0x0 << REPLAY_RESIDENCY_ENABLE_SHIFT)
 # define REPLAY_RESIDENCY_ENABLE               (0x1 << REPLAY_RESIDENCY_ENABLE_SHIFT)
 
+#define REPLAY_RESIDENCY_REVISION_MASK         (0x3 << REPLAY_RESIDENCY_REVISION_SHIFT)
+# define REPLAY_RESIDENCY_REVISION_0           (0x0 << REPLAY_RESIDENCY_REVISION_SHIFT)
+# define REPLAY_RESIDENCY_REVISION_1           (0x1 << REPLAY_RESIDENCY_REVISION_SHIFT)
+
+/**
+ * Definition of a replay_state.
+ */
 enum replay_state {
 	REPLAY_STATE_0			= 0x0,
 	REPLAY_STATE_1			= 0x10,
-- 
2.34.1

