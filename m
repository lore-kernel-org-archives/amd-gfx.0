Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D397C79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9D0010EB5D;
	Tue,  8 Sep 2026 11:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cEU/QT0I";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3AA510EB5D
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdQ0Kv0oAkVf+HHZoNPhVpjVWj9hMeHA1JDIfO2xMJ/bMjYrFbiZDSEnCb9eaRqp6224PaWZztt2N/91XZcF2LQujR/QecKofTBpmvhH9gTzXq8A5SxOUCSv5rIBAFkzKStnZ4G46KjlHTu4WjOw+8WGWN6SsIxB4zhF4nt2XCjQNtAA2a8cce9lBkXWybtKcSFwLOzYWCmIvqZ16LWzKFhCRfn25WUKiJKJwKfBC4ThD2Ocevv/wSXWRX91C93FirGnzIblVjt4JVqCdQOhvw0ps1gj9p+1J6AdjPcNvB/HiBJnw6FnA45YGnSdJTu05AIfCI9TUfbgdMOzwl1VQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZa4zgffptAH0/aZsu64Zp10q7dnBWcIKjORRTKbEj4=;
 b=loH5bu1qElHxGU5yz3Mx0916Vw8atdsRt2jsx8A0/lF1D+PySOYvN8MnWPDFLIjIDQ+4TRPK+MRRrx02Qxcgb8uubfXhIYVOtHuzbPQ5sH4Nnc1ypViXalpJJ8hO+wTjyOEzUsvrDd70wf/RwtHujbVmsADuTRjLjrwPr8oj9W1M6i4f64bwoiDWhq6pnyM6P9eaNqpWeXqXxTMhRfRgLT12OZZqVsw9ccae9QDXnew5JQRjdKY0zaX+I6d4gJtXtfi9SeTP7aSn4fDNqLMGd78YMPYxhnAy09Ds4fGyBoQiCAGINcnuYYWF5VBMqzKYFAdiGTZ8eh2LnsBb75PuGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZa4zgffptAH0/aZsu64Zp10q7dnBWcIKjORRTKbEj4=;
 b=cEU/QT0IzRHKonSQaOA3GcuBOW9yCWgO+SwxBNav1jLGvgMLvxpGzwo/6UCWnEDZ6WGNVjF7S1r3DXSCChEJSwgieYMt1fr1kYY85RaiNPTHMa86DmlIEDFrOSi5jMOVXripO+dg5MqT+S0PDLr9NHIiYsvAbjjJZazMbpP4NjA=
Received: from SJ0PR03CA0283.namprd03.prod.outlook.com (2603:10b6:a03:39e::18)
 by MW5PR12MB5649.namprd12.prod.outlook.com (2603:10b6:303:19d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 11:39:55 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::7) by SJ0PR03CA0283.outlook.office365.com
 (2603:10b6:a03:39e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:39:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:39:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:39:52 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:39:43 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Aric Cyr
 <aric.cyr@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 41/66] drm/amd/display: Cleanup DMUB command submission
 interfaces
Date: Tue, 8 Sep 2026 19:31:34 +0800
Message-ID: <20260908113338.2433445-42-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|MW5PR12MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7b1ad6-9923-47d6-9d96-08df0d9de738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hEcihQ3UZNDvzYShxcVUs0taFmLBUd/CCabEUiHPLajqAdchkGKFzd2jOdg2nkobHq3yVmsQG9y/dPTSvkE0LYU3J+zpXhHio8vFnst6zBGeaHil3G8EcJbmpKiOmWEmIJKTj0cvZNmpnN0O4h+8/7dpoJeUfHT3vVXItuS0QBc+HwpdMU2TvIXkci/VQw7A57K4jV56zSfFLGpkVJaGmB3ycs3zKHxYZaoN59ATzXb+xICXSModRxZEL+PsHkErAMJrPY9bDhQbd+mRArEPslu7d+5O4qeLysk45+5xA3tNx62XdHRjRNxRnmdV8BGEzz8xxzn7mUIzrQxewcl0r1rmpQ73+9Wy1k+PvhjEJWMuHavkj4wAjLBLDiUJU5i/2MoDp2tfIhhZ4ME0nHoKGD9WNNQ9ETKKa3v4Hyutig7ov74OqcoOm/Nkcwiz8Q1+x6ALEygNEcIASfCn+FGu5bSlN5+MSpratqK4Hi0q6TcSAh5SPrtXqLEQsNjc9i42jCL0sUyU8kdiz+0EjokaLxPjHSppJB+ZtNQH2Tdxowtmyg5sr4opM/ciKQoTMNB4R0mYGoQg4yVpbCkSMEHqqtQ8E3awDszGzq8AJjFAQRj+XTuYKl3DxpodKqE+aj6bns7FiGmtRJ28sTgsYgi/BY8mcRGuMl0NA5seqXNySCOR1/XpyPgQUCUkeb03bkPRDvkAIUXMcSqVvo8E07rBzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iYK71JrbRooG/bojSPkSImqBKdzAb8VzOFOujWMapJJn1hlea2Y72mKTram6NOpLK/QnQN5UV6PcchWvaUalZhRj/PQYkB1XJO94PkqHYJKtEhfEjeWbdLtAcB+fsCHXk86l9q6Al+tkei1mV1bz4c47Hpgg1B+W2uLnQEM+deLQs1LsZghZOD94hNVnddwma3Iv4HPcnikHvYL04TpJGqpTpO+i2vX1E7GqKq1dyTUjeTxiU3gp462ds5G3KbeqSFjTXkzcltrEP2952CRIBANomMO/lwNA0fDrkoPSeryrklJQvVIjGRcmmzEibgLcN4YpCzThiIBoJ56/tD+84kuFznU//Fshh+F2w/k8tht0jYhFY3JmwVzdSz5vRInu/j81ZFuXImGI8eGJRVbRFMt6hPQWRvxC88DrAaOGjfVOI/XvXi17zPtxwM36j7Ql
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:39:54.8908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7b1ad6-9923-47d6-9d96-08df0d9de738
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5649
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Allow for custom timeout passing where needed, and make inputs
const where applicable.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 41 +++++++++++--------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  | 12 +++++-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  7 +++-
 4 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index d08dd372179c..e23137034130 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -41,8 +41,6 @@
 #define DC_LOGGER CTX->logger
 #define GPINT_RETRY_NUM 20
 
-#define MAX_WAIT_US 500000
-
 static void dc_dmub_srv_construct(struct dc_dmub_srv *dc_srv, struct dc *dc,
 				  struct dmub_srv *dmub)
 {
@@ -93,7 +91,7 @@ bool dc_dmub_srv_wait_for_pending(struct dc_dmub_srv *dc_dmub_srv)
 	dmub = dc_dmub_srv->dmub;
 
 	do {
-		status = dmub_srv_wait_for_pending(dmub, MAX_WAIT_US);
+		status = dmub_srv_wait_for_pending(dmub, DMUB_CMD_DEFAULT_MAX_WAIT_US);
 	} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
 
 	if (status != DMUB_STATUS_OK) {
@@ -123,7 +121,7 @@ void dc_dmub_srv_wait_for_inbox0_ack(struct dc_dmub_srv *dc_dmub_srv)
 	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
 	enum dmub_status status = DMUB_STATUS_OK;
 
-	status = dmub_srv_wait_for_inbox0_ack(dmub, MAX_WAIT_US);
+	status = dmub_srv_wait_for_inbox0_ack(dmub, DMUB_CMD_DEFAULT_MAX_WAIT_US);
 	if (status != DMUB_STATUS_OK) {
 		DC_ERROR("Error waiting for INBOX0 HW Lock Ack\n");
 		dc_dmub_srv_handle_failure(dc_dmub_srv);
@@ -146,7 +144,8 @@ void dc_dmub_srv_send_inbox0_cmd(struct dc_dmub_srv *dc_dmub_srv,
 
 static bool dc_dmub_srv_reg_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
 		unsigned int count,
-		union dmub_rb_cmd *cmd_list)
+		const union dmub_rb_cmd *cmd_list,
+		unsigned int timeout_us)
 {
 	struct dc_context *dc_ctx;
 	struct dmub_srv *dmub;
@@ -162,7 +161,7 @@ static bool dc_dmub_srv_reg_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_s
 	for (i = 0 ; i < count; i++) {
 		/* confirm no messages pending */
 		do {
-			status = dmub_srv_wait_for_idle(dmub, MAX_WAIT_US);
+			status = dmub_srv_wait_for_idle(dmub, timeout_us);
 		} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
 
 		/* queue command */
@@ -188,7 +187,8 @@ static bool dc_dmub_srv_reg_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_s
 
 static bool dc_dmub_srv_fb_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
 		unsigned int count,
-		union dmub_rb_cmd *cmd_list)
+		const union dmub_rb_cmd *cmd_list,
+		unsigned int timeout_us)
 {
 	struct dc_context *dc_ctx;
 	struct dmub_srv *dmub;
@@ -217,7 +217,7 @@ static bool dc_dmub_srv_fb_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_sr
 				return false;
 
 			do {
-					status = dmub_srv_wait_for_inbox_free(dmub, MAX_WAIT_US, count - i);
+					status = dmub_srv_wait_for_inbox_free(dmub, timeout_us, count - i);
 			} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
 
 			/* Requeue the command. */
@@ -245,17 +245,18 @@ static bool dc_dmub_srv_fb_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_sr
 	return true;
 }
 
-bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
+bool dc_dmub_srv_cmd_list_queue_execute_timeout(struct dc_dmub_srv *dc_dmub_srv,
 		unsigned int count,
-		union dmub_rb_cmd *cmd_list)
+		const union dmub_rb_cmd *cmd_list,
+		unsigned int timeout_us)
 {
 	bool res = false;
 
 	if (dc_dmub_srv && dc_dmub_srv->dmub) {
 		if (dc_dmub_srv->dmub->inbox_type == DMUB_CMD_INTERFACE_REG) {
-			res = dc_dmub_srv_reg_cmd_list_queue_execute(dc_dmub_srv, count, cmd_list);
+			res = dc_dmub_srv_reg_cmd_list_queue_execute(dc_dmub_srv, count, cmd_list, timeout_us);
 		} else {
-			res = dc_dmub_srv_fb_cmd_list_queue_execute(dc_dmub_srv, count, cmd_list);
+			res = dc_dmub_srv_fb_cmd_list_queue_execute(dc_dmub_srv, count, cmd_list, timeout_us);
 		}
 
 		if (res)
@@ -265,9 +266,17 @@ bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
 	return res;
 }
 
+bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
+		unsigned int count,
+		const union dmub_rb_cmd *cmd_list)
+{
+	return dc_dmub_srv_cmd_list_queue_execute_timeout(dc_dmub_srv, count, cmd_list, DMUB_CMD_DEFAULT_MAX_WAIT_US);
+}
+
 bool dc_dmub_srv_wait_for_idle(struct dc_dmub_srv *dc_dmub_srv,
 		enum dm_dmub_wait_type wait_type,
-		union dmub_rb_cmd *cmd_list)
+		union dmub_rb_cmd *cmd_list,
+		unsigned int timeout_us)
 {
 	struct dmub_srv *dmub;
 	enum dmub_status status;
@@ -280,7 +289,7 @@ bool dc_dmub_srv_wait_for_idle(struct dc_dmub_srv *dc_dmub_srv,
 	// Wait for DMUB to process command
 	if (wait_type != DM_DMUB_WAIT_TYPE_NO_WAIT) {
 		do {
-			status = dmub_srv_wait_for_idle(dmub, MAX_WAIT_US);
+			status = dmub_srv_wait_for_idle(dmub, timeout_us);
 		} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
 
 		if (status != DMUB_STATUS_OK) {
@@ -314,7 +323,7 @@ bool dc_dmub_srv_cmd_run_list(struct dc_dmub_srv *dc_dmub_srv, unsigned int coun
 	if (!dc_dmub_srv_cmd_list_queue_execute(dc_dmub_srv, count, cmd_list))
 		return false;
 
-	return dc_dmub_srv_wait_for_idle(dc_dmub_srv, wait_type, cmd_list);
+	return dc_dmub_srv_wait_for_idle(dc_dmub_srv, wait_type, cmd_list, DMUB_CMD_DEFAULT_MAX_WAIT_US);
 }
 
 bool dc_dmub_srv_optimized_init_done(struct dc_dmub_srv *dc_dmub_srv)
@@ -1370,7 +1379,7 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 			ips_fw->signals.bits.ips1_commit,
 			ips_fw->signals.bits.ips2_commit);
 
-		dc_dmub_srv_wait_for_idle(dc->ctx->dmub_srv, DM_DMUB_WAIT_TYPE_WAIT, NULL);
+		dc_dmub_srv_wait_for_idle(dc->ctx->dmub_srv, DM_DMUB_WAIT_TYPE_WAIT, NULL, DMUB_CMD_DEFAULT_MAX_WAIT_US);
 
 		memset(&new_signals, 0, sizeof(new_signals));
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 5737c78853fc..8056824d90e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -29,6 +29,8 @@
 #include "dm_services_types.h"
 #include "dmub/dmub_srv.h"
 
+#define DMUB_CMD_DEFAULT_MAX_WAIT_US 500000
+
 struct dmub_srv;
 struct dc;
 struct dc_context;
@@ -59,11 +61,17 @@ bool dc_dmub_srv_optimized_init_done(struct dc_dmub_srv *dc_dmub_srv);
 
 bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
 		unsigned int count,
-		union dmub_rb_cmd *cmd_list);
+		const union dmub_rb_cmd *cmd_list);
+
+bool dc_dmub_srv_cmd_list_queue_execute_timeout(struct dc_dmub_srv *dc_dmub_srv,
+		unsigned int count,
+		const union dmub_rb_cmd *cmd_list,
+		unsigned int timeout_us);
 
 bool dc_dmub_srv_wait_for_idle(struct dc_dmub_srv *dc_dmub_srv,
 		enum dm_dmub_wait_type wait_type,
-		union dmub_rb_cmd *cmd_list);
+		union dmub_rb_cmd *cmd_list,
+		unsigned int timeout_us);
 
 bool dc_dmub_srv_cmd_run(struct dc_dmub_srv *dc_dmub_srv, union dmub_rb_cmd *cmd, enum dm_dmub_wait_type wait_type);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index d8a18cd97811..a5222ffc8ab6 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -1073,7 +1073,7 @@ void dmub_srv_set_power_state(struct dmub_srv *dmub, enum dmub_srv_power_state_t
  *   DMUB_STATUS_OK - success
  *   DMUB_STATUS_INVALID - unspecified error
  */
-enum dmub_status dmub_srv_reg_cmd_execute(struct dmub_srv *dmub, union dmub_rb_cmd *cmd);
+enum dmub_status dmub_srv_reg_cmd_execute(struct dmub_srv *dmub, const union dmub_rb_cmd *cmd);
 
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 587d26c742cd..dd868e38e0b0 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -1385,7 +1385,7 @@ void dmub_srv_set_power_state(struct dmub_srv *dmub, enum dmub_srv_power_state_t
 	dmub->power_state = dmub_srv_power_state;
 }
 
-enum dmub_status dmub_srv_reg_cmd_execute(struct dmub_srv *dmub, union dmub_rb_cmd *cmd)
+enum dmub_status dmub_srv_reg_cmd_execute(struct dmub_srv *dmub, const union dmub_rb_cmd *cmd)
 {
 	uint64_t num_pending = 0;
 
@@ -1411,7 +1411,10 @@ enum dmub_status dmub_srv_reg_cmd_execute(struct dmub_srv *dmub, union dmub_rb_c
 
 	/* clear last rsp ack and send message */
 	dmub->hw_funcs.clear_reg_inbox0_rsp_int_ack(dmub);
-	dmub->hw_funcs.send_reg_inbox0_cmd_msg(dmub, cmd);
+	/* hw_funcs signature is not const as some ASIC variants may reuse the
+	 * buffer; send_reg_inbox0_cmd_msg implementations only read from cmd.
+	 */
+	dmub->hw_funcs.send_reg_inbox0_cmd_msg(dmub, (union dmub_rb_cmd *)cmd);
 
 	dmub->reg_inbox0.num_submitted++;
 	dmub->reg_inbox0.is_pending = true;
-- 
2.43.0

