Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8223D39013
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 20:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C28310E689;
	Wed, 14 Jan 2026 20:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zPUWe2xE";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E13410E685
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 20:24:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4eHDR32HVyeh2wfXxPLbx15QUoCv3/aiucDViywbOc+K6ixZVvICA8qObSsDnRpaTNCdys4Ne/EM1E9GRhq8iYy/t/UqykFqdpXNveOuAxcD4vKxv0La5eeazGEcZVjgatpn8/uHiErUV+Xi2jma3wHzpHIB0CcReJeIeETGEe28r/kVLbqGpr8xW88RrnGftCYsEQNkTNIpRq+3WUUFEu1sIbJk4WJaTcpjL4xpuAVxoL85yspRGLOGw92UnPv/JLHu9ovZJFDp4Y/sk2v0GGFEURfXpKQbXGA94i2rm9zVofFzMiqTawrKKYOLO8Dvr1v6uZ7/uuYa5v2cl2l3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzs1xewhrSTe7Qui4WqGFIPa2BFdLdsEdvidWoHeOHQ=;
 b=e63AtPM+t6Cwyl30lRQaGkTEUxCICSZdlf9f29GPYcIDhQDD7NeSi6t8xktnFkJwbAenGuYgF+zx4DtBUDpcUI1CaYACILlpNXT/gNGi3GhmSs1TDs4m+3Fq5+s7gTb40Q+h2eVvj6ku286Buwq5C101U+KXnJlwCSERsrx+O1KYnwckuimarbCGUUxFkRfjlzX7FoKknXGDk5fS5u32A4FvcQWzDrVUE65Sc5xtyiRau9gsXGsbFun9sq6H9EVajomN+/L6RlFyOH5nSQK44UV5q004YbHoOM09ozEvpH47MglprJcZGKr6rlAOGpsEaoDhZxeskN1KzcJ/gWTP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzs1xewhrSTe7Qui4WqGFIPa2BFdLdsEdvidWoHeOHQ=;
 b=zPUWe2xEgh2L4NF3r93UduHxuegKTydk9gBt4zM81nEkMy7nlNaIgemNwovzkOjYogRrN0onWtirAgDTZLD2oeIRHUB/9kXcuL55iImV5kfQKix04KeWYt9hZRYNu6zg352rdCFr+nXn/yICVSA2FfapNUL7+9PZE50xAGABOgU=
Received: from SJ0PR13CA0225.namprd13.prod.outlook.com (2603:10b6:a03:2c1::20)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 20:24:18 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::71) by SJ0PR13CA0225.outlook.office365.com
 (2603:10b6:a03:2c1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.2 via Frontend Transport; Wed,
 14 Jan 2026 20:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 20:24:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 14 Jan
 2026 14:24:14 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Jan
 2026 14:24:13 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 14:24:13 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>
Subject: [PATCH 12/14] drm/amd/display: Add DMU crash recovery callback to DM
Date: Wed, 14 Jan 2026 15:21:53 -0500
Message-ID: <20260114202421.3654137-13-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
References: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Matthew.Stewart2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f504c4-8927-40ab-1cb5-08de53aae4bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I8tVXY4OaYKzvoQkFNw0IxsaKOjYredLUkGmM9TzNNTVuCBCga95YbJZIRq9?=
 =?us-ascii?Q?CK9wRc83cGqA55KrLKXYOyjyWmBIzooeyZCfuQO1LopBiq2DAcNEvgMQoqM8?=
 =?us-ascii?Q?a0PRa7EukrXeDUSQXeUiNE3ZeZMbIzhoutsuKsg6j19x5D1E3qU+OkGaNiqw?=
 =?us-ascii?Q?No5SHkVxt6JgRQPHm6pSj+WsvQ9/G+YMf5xpBHPQNK5ZvSRN40nTGA88vhHU?=
 =?us-ascii?Q?NePxKkegp6nGEtm/b7H0p5QSUG12I0hT7v44yauJO03qhopn/2sfliRmtKbu?=
 =?us-ascii?Q?9hbbkGab7CbUZBUVY24Pg2toR2pV7hdxPMrFQmbnrPDATXKDf3f8wxX2GqOL?=
 =?us-ascii?Q?tzq5QB57DuEtF0xfredPe73tq9lte1wSA4eQIf0LtxyDtcgIiiE9xlag/GiP?=
 =?us-ascii?Q?UHq9DERpwQz22zzs4YF1P2/i4USJopuu2vP8qWj21YMt393S3GBbksSJTsbK?=
 =?us-ascii?Q?BmESjq8PVcZEq6bmZyXpVKO6kpBWWU5fSTq+iuHT2XHydz2ZSpGTZq3MpGxg?=
 =?us-ascii?Q?IJCQXZ/k8QkLK8LrobX0NsK8Tnzc3repBHQj1dKukOtHHGSY9stZfPlDYlCa?=
 =?us-ascii?Q?BE6uDhyWPmKp5wk8zNtzBRNEHOLeMyKJESvLfXYzaPQEtv4jOLCV61gMVdH9?=
 =?us-ascii?Q?O9sZdie/40GIpY0NxhnJWSShBOCbHiACq3IrLuQwjPGWTl2eBsFLEdOj5JCU?=
 =?us-ascii?Q?yOZ+QxWKgggb14Tr8f9v0Zzs7LSPyhAfDBdJOHr2djjZPwT2FH2lmlqIttB2?=
 =?us-ascii?Q?cNuDDl7l7yc3MIailPc+x83f3xJE1T4MoBQ6uqI6VgSGIT4HA0oVU3UyOSn6?=
 =?us-ascii?Q?Aml/QTX0VuEz6XPJ08zFJOPTDWdGB8Y4m0oUc7rkpEPcWDkwJQSUeu0TV48+?=
 =?us-ascii?Q?3SiQApQEIaGWmLLwkerAAF/7ODjGlmdXI8hnrhphbUpoZvL8OostLO72TOsp?=
 =?us-ascii?Q?+8zh/cdkKZ8KcOCmuvsjIOyt6dq1DE6Tm2YSg9PoDIQlvHxxBGLdE+Ta40Dl?=
 =?us-ascii?Q?I1RB7g416DBCwzB0FyTifwhWw1WYXeSZinLAvDPxIAiKuou4cPu1+fmh8sEZ?=
 =?us-ascii?Q?4mVmHi1T5AeHS+UZ2uWKHaAkMb//9ainJ0bvaAxmLY0VJuGf873u5NSwdTDz?=
 =?us-ascii?Q?uJJj9Nc9zPJ5Esd53tsZyAX8e5EL4CmHMtMXCHhx3xSdo6XMwQLOcCVcWfSk?=
 =?us-ascii?Q?jpcAZMl2edI0Nfu1SvwvQJFxB16OjYFVypvKOaGZklG6tBfS4RVYMLBC9r+Z?=
 =?us-ascii?Q?/SvT40pHtbu+22ruxMiM3PAEizBhbWrtOdjpvHoEZyWGx3RotEfdaoKzksLn?=
 =?us-ascii?Q?GdaoQ/hfF4eQY0iZwiHPOEDNRPicjFHIBdaTCMNgIHZeMpMr7+/O28HYPZJe?=
 =?us-ascii?Q?AewVTGovhaMvVLxvnlBg5i9axNVfsGAGQ5RtCUG7XkXRMPb6Dki2FN8eiQoX?=
 =?us-ascii?Q?39a4KqyNCKF9aw2OUllaKK1FizmZgQcokwBRlWegz5WrC13sCBz73zygRisQ?=
 =?us-ascii?Q?g/08fio9pcO//6gNB+c901IETnUrddB+QeB/YHOd0A4h5eB7mKyZd9n+5AwZ?=
 =?us-ascii?Q?vEg5TW6o++KeMZJlOBa2prcNuQHD/Ncn+qeD5ZBDCoEB2zgff50i/XcKhL0d?=
 =?us-ascii?Q?37KoZ/ej682JGnelrkctbNrrlRhg8MN3h/Xbk+koABoqgEPWclVOaXJk1iIL?=
 =?us-ascii?Q?r48KKA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 20:24:17.9458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f504c4-8927-40ab-1cb5-08de53aae4bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
To improve reliability of the system in the case of infrequent or
potentially recoverable hangs when the DMU times out.

[How]
Attempt to recover the ASIC when DMU hangs by triggering a crash
recovery callback for the DM to forward to the base driver.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  6 ++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 35 ++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  1 +
 4 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index e5e993d3ef74..1f41d6540b83 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1121,6 +1121,12 @@ void dm_set_dcn_clocks(struct dc_context *ctx, struct dc_clocks *clks)
 	/* TODO: something */
 }
 
+void dm_helpers_dmu_timeout(struct dc_context *ctx)
+{
+	// TODO:
+	//amdgpu_device_gpu_recover(dc_context->driver-context, NULL);
+}
+
 void dm_helpers_smu_timeout(struct dc_context *ctx, unsigned int msg_id, unsigned int param, unsigned int timeout_us)
 {
 	// TODO:
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 94f62cf2cd30..15b90fac723a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1209,6 +1209,7 @@ struct dc_debug_options {
 	uint32_t custom_psp_footer_size;
 	bool disable_deferred_minimal_transitions;
 	unsigned int num_fast_flips_to_steady_state_override;
+	bool enable_dmu_recovery;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 2dc6ae6b5bea..dc1b3f6c22c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -41,6 +41,8 @@
 #define DC_LOGGER CTX->logger
 #define GPINT_RETRY_NUM 20
 
+#define MAX_WAIT_US 100000
+
 static void dc_dmub_srv_construct(struct dc_dmub_srv *dc_srv, struct dc *dc,
 				  struct dmub_srv *dmub)
 {
@@ -48,6 +50,13 @@ static void dc_dmub_srv_construct(struct dc_dmub_srv *dc_srv, struct dc *dc,
 	dc_srv->ctx = dc->ctx;
 }
 
+static void dc_dmub_srv_handle_failure(struct dc_dmub_srv *dc_dmub_srv)
+{
+	dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+	if (dc_dmub_srv->ctx->dc->debug.enable_dmu_recovery)
+		dm_helpers_dmu_timeout(dc_dmub_srv->ctx);
+}
+
 struct dc_dmub_srv *dc_dmub_srv_create(struct dc *dc, struct dmub_srv *dmub)
 {
 	struct dc_dmub_srv *dc_srv =
@@ -84,12 +93,12 @@ bool dc_dmub_srv_wait_for_pending(struct dc_dmub_srv *dc_dmub_srv)
 	dmub = dc_dmub_srv->dmub;
 
 	do {
-		status = dmub_srv_wait_for_pending(dmub, 100000);
+		status = dmub_srv_wait_for_pending(dmub, MAX_WAIT_US);
 	} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
 
 	if (status != DMUB_STATUS_OK) {
 		DC_ERROR("Error waiting for DMUB idle: status=%d\n", status);
-		dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+		dc_dmub_srv_handle_failure(dc_dmub_srv);
 	}
 
 	return status == DMUB_STATUS_OK;
@@ -104,7 +113,7 @@ void dc_dmub_srv_clear_inbox0_ack(struct dc_dmub_srv *dc_dmub_srv)
 	status = dmub_srv_clear_inbox0_ack(dmub);
 	if (status != DMUB_STATUS_OK) {
 		DC_ERROR("Error clearing INBOX0 ack: status=%d\n", status);
-		dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+		dc_dmub_srv_handle_failure(dc_dmub_srv);
 	}
 }
 
@@ -114,10 +123,10 @@ void dc_dmub_srv_wait_for_inbox0_ack(struct dc_dmub_srv *dc_dmub_srv)
 	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
 	enum dmub_status status = DMUB_STATUS_OK;
 
-	status = dmub_srv_wait_for_inbox0_ack(dmub, 100000);
+	status = dmub_srv_wait_for_inbox0_ack(dmub, MAX_WAIT_US);
 	if (status != DMUB_STATUS_OK) {
 		DC_ERROR("Error waiting for INBOX0 HW Lock Ack\n");
-		dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+		dc_dmub_srv_handle_failure(dc_dmub_srv);
 	}
 }
 
@@ -131,7 +140,7 @@ void dc_dmub_srv_send_inbox0_cmd(struct dc_dmub_srv *dc_dmub_srv,
 	status = dmub_srv_send_inbox0_cmd(dmub, data);
 	if (status != DMUB_STATUS_OK) {
 		DC_ERROR("Error sending INBOX0 cmd\n");
-		dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+		dc_dmub_srv_handle_failure(dc_dmub_srv);
 	}
 }
 
@@ -153,7 +162,7 @@ static bool dc_dmub_srv_reg_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_s
 	for (i = 0 ; i < count; i++) {
 		/* confirm no messages pending */
 		do {
-			status = dmub_srv_wait_for_idle(dmub, 100000);
+			status = dmub_srv_wait_for_idle(dmub, MAX_WAIT_US);
 		} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
 
 		/* queue command */
@@ -169,7 +178,7 @@ static bool dc_dmub_srv_reg_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_s
 	if (status != DMUB_STATUS_OK) {
 		if (status != DMUB_STATUS_POWER_STATE_D3) {
 			DC_ERROR("Error starting DMUB execution: status=%d\n", status);
-			dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+			dc_dmub_srv_handle_failure(dc_dmub_srv);
 		}
 		return false;
 	}
@@ -208,7 +217,7 @@ static bool dc_dmub_srv_fb_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_sr
 				return false;
 
 			do {
-					status = dmub_srv_wait_for_inbox_free(dmub, 100000, count - i);
+					status = dmub_srv_wait_for_inbox_free(dmub, MAX_WAIT_US, count - i);
 			} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
 
 			/* Requeue the command. */
@@ -218,7 +227,7 @@ static bool dc_dmub_srv_fb_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_sr
 		if (status != DMUB_STATUS_OK) {
 			if (status != DMUB_STATUS_POWER_STATE_D3) {
 				DC_ERROR("Error queueing DMUB command: status=%d\n", status);
-				dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+				dc_dmub_srv_handle_failure(dc_dmub_srv);
 			}
 			return false;
 		}
@@ -228,7 +237,7 @@ static bool dc_dmub_srv_fb_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_sr
 	if (status != DMUB_STATUS_OK) {
 		if (status != DMUB_STATUS_POWER_STATE_D3) {
 			DC_ERROR("Error starting DMUB execution: status=%d\n", status);
-			dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+			dc_dmub_srv_handle_failure(dc_dmub_srv);
 		}
 		return false;
 	}
@@ -271,7 +280,7 @@ bool dc_dmub_srv_wait_for_idle(struct dc_dmub_srv *dc_dmub_srv,
 	// Wait for DMUB to process command
 	if (wait_type != DM_DMUB_WAIT_TYPE_NO_WAIT) {
 		do {
-			status = dmub_srv_wait_for_idle(dmub, 100000);
+			status = dmub_srv_wait_for_idle(dmub, MAX_WAIT_US);
 		} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
 
 		if (status != DMUB_STATUS_OK) {
@@ -282,7 +291,7 @@ bool dc_dmub_srv_wait_for_idle(struct dc_dmub_srv *dc_dmub_srv,
 					dmub->debug.timeout_info.timeout_cmd = *cmd_list;
 				dmub->debug.timeout_info.timestamp = dm_get_timestamp(dc_dmub_srv->ctx);
 			}
-			dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+			dc_dmub_srv_handle_failure(dc_dmub_srv);
 			return false;
 		}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 9d160b39e8c5..7014b8c2c956 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -197,6 +197,7 @@ void dm_set_phyd32clk(struct dc_context *ctx, int freq_khz);
 
 bool dm_helpers_dmub_outbox_interrupt_control(struct dc_context *ctx, bool enable);
 
+void dm_helpers_dmu_timeout(struct dc_context *ctx);
 void dm_helpers_smu_timeout(struct dc_context *ctx, unsigned int msg_id, unsigned int param, unsigned int timeout_us);
 
 // 0x1 = Result_OK, 0xFE = Result_UnkmownCmd, 0x0 = Status_Busy
-- 
2.52.0

