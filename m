Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1390CC3ABBC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 02:43:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6BB910E737;
	Wed,  7 May 2025 02:43:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1vQJlHoS";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E70B10E737
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 02:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uP4E4ey4Sd3LR2fW8qQ4k+rxiGciXXmxGibZSMZUR2Tfgly//TnvFZhl2LbMKsr3kb05jA2xRW2xO4cGZkkxZNKVwMi/1EUbMa9EkrRD0asP2ggE4r+rtOdLKlS7iVB69EYW9hqmwDj+pkr4sedmZb2wkLNtQ7wZnl8C2zlP7Xt8Qkb8UOjZMqEaWMsl/jeFxliFHVOKW7LO+bLMQa5a5r5SjO/0CwJmOqtOMJWMQt7ulJtMhN2exKcBLmwxNxS8oBYtbv98JO5JGuogMNcGRfdLU7w/uYBFNyIVLLfuB3XYewHqUPDDC8n3Yi6X1R6NBg+amNMLHdQs8E+9+2xh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kIX/ekoEfgJxYI4SWLhQS/fh6St6GqdaLadEn0OtvU=;
 b=L2JWkLyJpmLrZx+YzMVtJa1gOFqmIp77ZMMvub7gXBJICX+e370ZPevNMIBNWldzo5ERdqoV9UZP/OiIWni68HYq3BU512Rr5TgCyHimeG7ONsmS943yZ1k26n1Zh1Kj8Q0Np/copXFcGoPiEM5G9fptg8OyVSSv6o0m3XlfDH5dUtsKtYkzKj+w+v3I7bEMD5gtZiizp2TywUVDyRrDxpUo01TWKyjkaNypbHnsVuVSlt6Or7LVSW3EeZsLOp51+2jX5aR963wha40MTKJJyxWL4oObrhW1sYSQ5DGh4LEQ7G57jAEe4CbGUuoreJ3qEZIRUhh2b8Qqo93r5pyoDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kIX/ekoEfgJxYI4SWLhQS/fh6St6GqdaLadEn0OtvU=;
 b=1vQJlHoSvnXRcFjxe5s7vgTDjGjGl8zZ380Gf2uBWxMrZCuMK7LIXljVE4EPDAUCNzsKSFERLDQv+hZsJ710p+ePsZ9LZTo4C1vHwaBtfFwO9PZWOoK8ZwcS6yPiP2BAlA5Gy60H4DFDFL0Pn2roivohUWr+OF8pXVwesIG6X1E=
Received: from SJ0PR05CA0128.namprd05.prod.outlook.com (2603:10b6:a03:33d::13)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 7 May
 2025 02:43:28 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::de) by SJ0PR05CA0128.outlook.office365.com
 (2603:10b6:a03:33d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Wed,
 7 May 2025 02:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 02:43:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:43:24 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 21:43:21 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 03/14] drm/amd/display: Fix race in dmub_srv_wait_for_pending
Date: Wed, 7 May 2025 10:34:47 +0800
Message-ID: <20250507024242.1928299-4-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507024242.1928299-1-ray.wu@amd.com>
References: <20250507024242.1928299-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3ae256-bc71-4a80-0aed-08dd8d10f200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6PlOmJVLg5jK8ogNx4mMEHex7YDy85qQxhliFm3p7tM1NLibr6iu0bNSyKx4?=
 =?us-ascii?Q?OWPMzMA6EKzSOaC3rmRllIePnSCpX8U97TDxF4P96es2ZVxZLlmP4zZ7+Uwc?=
 =?us-ascii?Q?CGhAXl8r9r3CYb1vDt09xmOxhC6kvY6WjdDrhJZOsUaF5XwzcAkAir3ey8dT?=
 =?us-ascii?Q?1OkqZ1ThZaBGw7lwvdx/xnHH2gzNvhz53BIgQUH3gp9Mn76gKUE01f2rIMUO?=
 =?us-ascii?Q?M0a16H/xSg1TubX2QcZr1FeyQOsb7OYyz+nz/nxvYPzXezg82d5Q/4I6NIwS?=
 =?us-ascii?Q?GV9lzarlbfcube6X2wAdw3zKSHDiL+qJtclAD5/spQhM3A27tslj3IZFluMc?=
 =?us-ascii?Q?g1uS9pX2NWjozHxLdYer7AKQpuEA04Oo40VNAz/a4xYym4T2LL/Hbjxmpf/o?=
 =?us-ascii?Q?TK7nBbcidJen6Tiu7jtSwFNjAY4OSBZlaQo2mFiIenZ8pDqZInICkl8xkGj0?=
 =?us-ascii?Q?0ADzQmE26w6bCLKZdG49Fhqqz6cegLcCBVnr0sxg0J1UAwLhkvWl+4uCgE/s?=
 =?us-ascii?Q?GfyM6wAIGrtion26W7l54Q4TKSVl/telwITLI4V1ZQlFDpIXtAw2qTx1y3P6?=
 =?us-ascii?Q?xS9hz1rgbWgYWIIvqGvPTq11xs8E6C8i/t5PTWaaa1eXAKI2BupyeGFOpLJC?=
 =?us-ascii?Q?LuxGM12CE2p3nDjywi9+PfEdG0+c3MkDm5P6r8tggM1HmuU5ckFupZoa/2Fi?=
 =?us-ascii?Q?+CRuXdAYyplZG40kOCAOaFmCSFfvcE+KnMaumVpWdfnPqNCeMNkFhCepcHIN?=
 =?us-ascii?Q?Q361tpnXsVYXiVT7sbtC3Xmk5HQLMiHyRyeVpe19aHobDWZqo17js1OBET65?=
 =?us-ascii?Q?8tYj8XAWliWD5zxg8+yFC1uLPbwwxILwYHAMal+/mb0QIZrMIf9dmznlifKR?=
 =?us-ascii?Q?za6634uIvitNiW44szCQmG1d1Ej3OS3YwO5TUO963qQl6ij6PH9Q7l4f8vER?=
 =?us-ascii?Q?dhMgLNRrG1jVIYCEjW1hdYfZ4gRrO/ODM+6ZQebgTxdc94f+Xgmo2w2hI1zh?=
 =?us-ascii?Q?SPF2KUufEvTBt2vIk13zYKwy8Ib02SAMbX2maFsG+6Y2Av4JFUKi0oC+uKry?=
 =?us-ascii?Q?nVJrnmmNGGwkA5cncMU4k6fRrzUyR1N+ahm3/XHAvGHaAf5arCf6mMLj+/+D?=
 =?us-ascii?Q?pJKvk6r6Q4jKo0nj9AhKLjjJ2XINxhmfGU7B4iL94AWP/Z1J/cAvKNWjwDIx?=
 =?us-ascii?Q?XNCwy+VqvXkPftPwu99Hty6iOba1+/EFhQaOh5zRLeb0ZuRx/7ZWChf1aezX?=
 =?us-ascii?Q?pSrrtJFiWl/1Fh1uudAaa9la2jay61smPDZdlEgiOvSvKprXGZU+qIJAPRXm?=
 =?us-ascii?Q?qkwlDf1vTMvtjmA6xYSfRlmFM17AvHQzFnm98CqzwKrP59TSZJRIwU+FNP+Q?=
 =?us-ascii?Q?FUlRuFOfbaSAENe5uBlQWaSBWF++QFQFVJXpVW4Z5krouCQksFe1BME+39Rx?=
 =?us-ascii?Q?SJAzZbsUKIMijrRmzlsGlWmBeoMRv+UpYK7hCHXVXMdUYurdH9lDysHCbk9Y?=
 =?us-ascii?Q?BdonRIG20VqRIGP246Z3JJRXRiCO9OIVsR5z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:43:27.3754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3ae256-bc71-4a80-0aed-08dd8d10f200
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994
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

[WHY]
If commands are being submitted to DMCUB while concurrently waiting for
pending commands to complete, rptr and wptr may never match again, and
reported command count will not update.

[HOW]
Modify dmub_srv_wait_for_pending to constantly check wptr and rptr
match, and update inbox status whenever a message is sent to avoid the
race and determine message completion or idle as quickly as possible.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  5 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 14 +++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 58 ++++++++++---------
 3 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 6115b5364394..1c6e71eaea3c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -207,7 +207,7 @@ static bool dc_dmub_srv_fb_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_sr
 				return false;
 
 			do {
-				status = dmub_srv_wait_for_inbox_free(dmub, 100000, count - i);
+					status = dmub_srv_wait_for_inbox_free(dmub, 100000, count - i);
 			} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
 
 			/* Requeue the command. */
@@ -247,6 +247,9 @@ bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
 		} else {
 			res = dc_dmub_srv_fb_cmd_list_queue_execute(dc_dmub_srv, count, cmd_list);
 		}
+
+		if (res)
+			res = dmub_srv_update_inbox_status(dc_dmub_srv->dmub) == DMUB_STATUS_OK;
 	}
 
 	return res;
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index e759ce6ca700..3f3fa1b6a69e 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -445,6 +445,8 @@ struct dmub_srv_hw_funcs {
 
 	uint32_t (*emul_get_inbox1_rptr)(struct dmub_srv *dmub);
 
+	uint32_t (*emul_get_inbox1_wptr)(struct dmub_srv *dmub);
+
 	void (*emul_set_inbox1_wptr)(struct dmub_srv *dmub, uint32_t wptr_offset);
 
 	bool (*is_supported)(struct dmub_srv *dmub);
@@ -1053,4 +1055,16 @@ enum dmub_status dmub_srv_wait_for_inbox_free(struct dmub_srv *dmub,
 		uint32_t timeout_us,
 		uint32_t num_free_required);
 
+/**
+ * dmub_srv_update_inbox_status() - Updates pending status for inbox & reg inbox0
+ * @dmub: the dmub service
+ *
+ * Return:
+ *   DMUB_STATUS_OK - success
+ *   DMUB_STATUS_TIMEOUT - wait for buffer to flush timed out
+ *   DMUB_STATUS_HW_FAILURE - issue with HW programming
+ *   DMUB_STATUS_INVALID - unspecified error
+ */
+enum dmub_status dmub_srv_update_inbox_status(struct dmub_srv *dmub);
+
 #endif /* _DMUB_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index c917a70b3c19..acca7943a8c8 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -952,10 +952,8 @@ enum dmub_status dmub_srv_wait_for_pending(struct dmub_srv *dmub,
 			!dmub->hw_funcs.get_inbox1_wptr)
 		return DMUB_STATUS_INVALID;
 
-	/* take a snapshot of the required mailbox state */
-	scratch_inbox1.rb.wrpt = dmub->hw_funcs.get_inbox1_wptr(dmub);
-
 	for (i = 0; i <= timeout_us; i += polling_interval_us) {
+			scratch_inbox1.rb.wrpt = dmub->hw_funcs.get_inbox1_wptr(dmub);
 			scratch_inbox1.rb.rptr = dmub->hw_funcs.get_inbox1_rptr(dmub);
 
 		scratch_reg_inbox0.is_pending = scratch_reg_inbox0.is_pending &&
@@ -978,30 +976,6 @@ enum dmub_status dmub_srv_wait_for_pending(struct dmub_srv *dmub,
 	return DMUB_STATUS_TIMEOUT;
 }
 
-static enum dmub_status dmub_srv_update_inbox_status(struct dmub_srv *dmub)
-{
-	uint32_t rptr;
-
-	/* update inbox1 state */
-		rptr = dmub->hw_funcs.get_inbox1_rptr(dmub);
-
-	if (rptr > dmub->inbox1.rb.capacity)
-		return DMUB_STATUS_HW_FAILURE;
-
-	if (dmub->inbox1.rb.rptr > rptr) {
-		/* rb wrapped */
-		dmub->inbox1.num_reported += (rptr + dmub->inbox1.rb.capacity - dmub->inbox1.rb.rptr) / DMUB_RB_CMD_SIZE;
-	} else {
-		dmub->inbox1.num_reported += (rptr - dmub->inbox1.rb.rptr) / DMUB_RB_CMD_SIZE;
-	}
-	dmub->inbox1.rb.rptr = rptr;
-
-	/* update reg_inbox0 */
-	dmub_srv_update_reg_inbox0_status(dmub);
-
-	return DMUB_STATUS_OK;
-}
-
 enum dmub_status dmub_srv_wait_for_idle(struct dmub_srv *dmub,
 					uint32_t timeout_us)
 {
@@ -1353,3 +1327,33 @@ enum dmub_status dmub_srv_wait_for_inbox_free(struct dmub_srv *dmub,
 
 	return DMUB_STATUS_TIMEOUT;
 }
+
+enum dmub_status dmub_srv_update_inbox_status(struct dmub_srv *dmub)
+{
+	uint32_t rptr;
+
+	if (!dmub->hw_init)
+		return DMUB_STATUS_INVALID;
+
+	if (dmub->power_state != DMUB_POWER_STATE_D0)
+		return DMUB_STATUS_POWER_STATE_D3;
+
+	/* update inbox1 state */
+	rptr = dmub->hw_funcs.get_inbox1_rptr(dmub);
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
-- 
2.43.0

