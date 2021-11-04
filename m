Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1373C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF0061106
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9DF0061106
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2094673872;
	Thu,  4 Nov 2021 20:53:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1909737F2
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLB538r+S6TChIEZ7rMMsq9mvlzcFUfV7Z+KCgJHtPfZdJtc4rmeKThqI3nl5bCilZ212RYc8xRZptrrj/D1QhMBO2HO23PG575t87uvwfl+42WuIeN/ntqfHJwQIRsCqn8TSCQ08QTmFnVVkFMFTzxRqwAV7R/tsJ/0608VLWJR3M1j7cPIsSIIm3OG5RQsjkhWzVISG5E5nszKlL4xek/kJP1SXERwJZtPk/lcjBWOnhzndhph3AY1fuQ6jjpiCX2Ud7vUIdXybj/6QYiDguYgtKvBYTHJrsyc1G83sqxbQB07/ZASjhxRkCsN/Q6FwQ2TC6mUXPn62MNtAX68/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+l/NTYf95ZPCyjAYI+Dj0XYsfBxM1GUn+NFcBpKp90I=;
 b=Hp47ESSV50+uzlln8ylbmZBlqlKck3MEYDX0i46XC6f/kULJyEnQOiBtLy3Cpgs1BhCLpVY6wWaXbwfahPyi3kTVSeevbj/UJE9b+qWzbOc1PWtHQKYMEpcSo1hOEcnau4uRr+y37J1t2LZLXpIR8SF90Q8xTgoeYXPROCDbP8wyFs9bJfdrkZBpheiafJvFJ1sQG6VOvv3RS8ECGqu73zCiRaCGy+G6lAwxOg3+s8jnYscMHcyaGBAabcnEmwHJaj+fZwucgT8+BqpexGNn3u4cQ8WbTLBvcAiHBfAV2QK0UHMi/oES1SB3bogyO7j8WWD2BTNtQGCom6LRfY8Ibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+l/NTYf95ZPCyjAYI+Dj0XYsfBxM1GUn+NFcBpKp90I=;
 b=Dk7x7A3m6oqwHhwOoYKJeqSrWoYbOkp9kbQjFLKWgaPr36G9YELa7Tu6Ip21tpDzEjzOlKmKWVNByjHZscXoYzmwMIGHasxS2/JN9y0KWzOx1Vmt0YN2pD4adK5A0a3MTSCiTaTVOQmtuxKtm8lG0GBdY9qynwe4wCHSGqTJNDY=
Received: from DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7) by
 CY4PR12MB1653.namprd12.prod.outlook.com (2603:10b6:910:f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.19; Thu, 4 Nov 2021 20:52:58 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::7e) by DS7PR06CA0006.outlook.office365.com
 (2603:10b6:8:2a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:56 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:55 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/22] drm/amd/display: Wait for ACK for INBOX0 HW Lock
Date: Thu, 4 Nov 2021 16:52:15 -0400
Message-ID: <20211104205215.1125899-23-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aaa35d9f-68c4-4246-5aa6-08d99fd514bb
X-MS-TrafficTypeDiagnostic: CY4PR12MB1653:
X-Microsoft-Antispam-PRVS: <CY4PR12MB16532F9A086C3DBD72830BA1EB8D9@CY4PR12MB1653.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3XjE/k99P58K8MR7rpiTiJS6dJSG9wk5j4pdZVgUhJE5IDAR68FclmLEA5CgobSnjBqVz9hC+lH5M3Q3NG9g3DFTcBmE3TQMlhJ7jNnffcR2WYEsGdaRNQnyFg0C/WmL+AjWQxtV5ZmzR7IG3LrEfPd6QBfqYltLmLrQ3tjiKVWDn3uxyApG7uaqLyOiqcvMbBY0nfIQoTWwKv0mGLG88NMaZHnRP3le+NeVZLFhVdtdKTJ07PVfwPvq6IsmlxUjL8ov7DF+8SkNWUf6ntQbIcOvi1WOsqf8hODWhpzL3w7uedUmuK7ISYX2Nuu6YDoZ5fsW4W/tSSBCV4hTYuo6s/e+/6FglmtL0n3StM6tmAPkT8dr7E8eyrUWONu25a5Nwk+TH1oQDm2BV3sBe4Nhu6kyH+ZBc3ps/5U4S0hxtpPES1wlt9cvBf9QwE3CXmUahywEGCk5LgkoyeWjrBcw3HKz8CUXVs0QS6tcebANAoR/QnW9WlE4QwxUM0E49a37qZCay5cC+WjksRgtoSuAWp8F0sEngwA0aMkFRs4sO3s5EZ+AMg0YBkjgB+x/goHfXYoCF7ZkKelxkZUDZCKnBYbSpUjjTdxJQIvOXvxhy0aSdJc5xtUjeaW2ACBvZsMtS+Ga4zgvPL077xREe04MNyfQCoaclhJn/NvzyvNtljPp1MgK0HZ5OLiNDg+U/2fPQrvJbDTdQnSwrTodo6PAjKUazY9xX9q3kLmp0yQ3y4Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(83380400001)(336012)(47076005)(70206006)(426003)(8676002)(1076003)(26005)(6666004)(7696005)(508600001)(356005)(86362001)(36756003)(54906003)(6916009)(2906002)(4326008)(70586007)(82310400003)(316002)(8936002)(2616005)(36860700001)(5660300002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:57.3439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa35d9f-68c4-4246-5aa6-08d99fd514bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1653
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas
 Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why]
In DC we want to wait for the INBOX0 HW Lock
command to ACK before continuing. This is to
ensure that the lock has been successfully acquired
before programming HW in DC.

[How]
Add interfaces to send messages on INBOX0,
poll for their completation and clear the ack.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 37 +++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  2 +
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  3 ++
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 41 +++++++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 35 ++++++++++++++++
 5 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 360f3199ea6f..541376fabbef 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -115,13 +115,44 @@ void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv)
 	}
 }
 
+void dc_dmub_srv_clear_inbox0_ack(struct dc_dmub_srv *dmub_srv)
+{
+	struct dmub_srv *dmub = dmub_srv->dmub;
+	struct dc_context *dc_ctx = dmub_srv->ctx;
+	enum dmub_status status = DMUB_STATUS_OK;
+
+	status = dmub_srv_clear_inbox0_ack(dmub);
+	if (status != DMUB_STATUS_OK) {
+		DC_ERROR("Error clearing INBOX0 ack: status=%d\n", status);
+		dc_dmub_srv_log_diagnostic_data(dmub_srv);
+	}
+}
+
+void dc_dmub_srv_wait_for_inbox0_ack(struct dc_dmub_srv *dmub_srv)
+{
+	struct dmub_srv *dmub = dmub_srv->dmub;
+	struct dc_context *dc_ctx = dmub_srv->ctx;
+	enum dmub_status status = DMUB_STATUS_OK;
+
+	status = dmub_srv_wait_for_inbox0_ack(dmub, 100000);
+	if (status != DMUB_STATUS_OK) {
+		DC_ERROR("Error waiting for INBOX0 HW Lock Ack\n");
+		dc_dmub_srv_log_diagnostic_data(dmub_srv);
+	}
+}
+
 void dc_dmub_srv_send_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
 		union dmub_inbox0_data_register data)
 {
 	struct dmub_srv *dmub = dmub_srv->dmub;
-	if (dmub->hw_funcs.send_inbox0_cmd)
-		dmub->hw_funcs.send_inbox0_cmd(dmub, data);
-	// TODO: Add wait command -- poll register for ACK
+	struct dc_context *dc_ctx = dmub_srv->ctx;
+	enum dmub_status status = DMUB_STATUS_OK;
+
+	status = dmub_srv_send_inbox0_cmd(dmub, data);
+	if (status != DMUB_STATUS_OK) {
+		DC_ERROR("Error sending INBOX0 cmd\n");
+		dc_dmub_srv_log_diagnostic_data(dmub_srv);
+	}
 }
 
 bool dc_dmub_srv_cmd_with_reply_data(struct dc_dmub_srv *dc_dmub_srv, union dmub_rb_cmd *cmd)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 3e35eee7188c..7e4e2ec5915d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -68,6 +68,8 @@ bool dc_dmub_srv_get_dmub_outbox0_msg(const struct dc *dc, struct dmcub_trace_bu
 
 void dc_dmub_trace_event_control(struct dc *dc, bool enable);
 
+void dc_dmub_srv_clear_inbox0_ack(struct dc_dmub_srv *dmub_srv);
+void dc_dmub_srv_wait_for_inbox0_ack(struct dc_dmub_srv *dmub_srv);
 void dc_dmub_srv_send_inbox0_cmd(struct dc_dmub_srv *dmub_srv, union dmub_inbox0_data_register data);
 
 bool dc_dmub_srv_get_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv, struct dmub_diagnostic_data *dmub_oca);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index 9baf8ca0a920..b1b2e3c6f379 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -56,8 +56,11 @@ void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
 		union dmub_inbox0_cmd_lock_hw hw_lock_cmd)
 {
 	union dmub_inbox0_data_register data = { 0 };
+
 	data.inbox0_cmd_lock_hw = hw_lock_cmd;
+	dc_dmub_srv_clear_inbox0_ack(dmub_srv);
 	dc_dmub_srv_send_inbox0_cmd(dmub_srv, data);
+	dc_dmub_srv_wait_for_inbox0_ack(dmub_srv);
 }
 
 bool should_use_dmub_lock(struct dc_link *link)
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index cd204eef073b..90065a09e76a 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -360,6 +360,8 @@ struct dmub_srv_hw_funcs {
 
 	uint32_t (*get_gpint_dataout)(struct dmub_srv *dmub);
 
+	void (*clear_inbox0_ack_register)(struct dmub_srv *dmub);
+	uint32_t (*read_inbox0_ack_register)(struct dmub_srv *dmub);
 	void (*send_inbox0_cmd)(struct dmub_srv *dmub, union dmub_inbox0_data_register data);
 	uint32_t (*get_current_time)(struct dmub_srv *dmub);
 
@@ -735,6 +737,45 @@ bool dmub_srv_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_
 
 bool dmub_srv_should_detect(struct dmub_srv *dmub);
 
+/**
+ * dmub_srv_send_inbox0_cmd() - Send command to DMUB using INBOX0
+ * @dmub: the dmub service
+ * @data: the data to be sent in the INBOX0 command
+ *
+ * Send command by writing directly to INBOX0 WPTR
+ *
+ * Return:
+ *   DMUB_STATUS_OK - success
+ *   DMUB_STATUS_INVALID - hw_init false or hw function does not exist
+ */
+enum dmub_status dmub_srv_send_inbox0_cmd(struct dmub_srv *dmub, union dmub_inbox0_data_register data);
+
+/**
+ * dmub_srv_wait_for_inbox0_ack() - wait for DMUB to ACK INBOX0 command
+ * @dmub: the dmub service
+ * @timeout_us: the maximum number of microseconds to wait
+ *
+ * Wait for DMUB to ACK the INBOX0 message
+ *
+ * Return:
+ *   DMUB_STATUS_OK - success
+ *   DMUB_STATUS_INVALID - hw_init false or hw function does not exist
+ *   DMUB_STATUS_TIMEOUT - wait for ack timed out
+ */
+enum dmub_status dmub_srv_wait_for_inbox0_ack(struct dmub_srv *dmub, uint32_t timeout_us);
+
+/**
+ * dmub_srv_wait_for_inbox0_ack() - clear ACK register for INBOX0
+ * @dmub: the dmub service
+ *
+ * Clear ACK register for INBOX0
+ *
+ * Return:
+ *   DMUB_STATUS_OK - success
+ *   DMUB_STATUS_INVALID - hw_init false or hw function does not exist
+ */
+enum dmub_status dmub_srv_clear_inbox0_ack(struct dmub_srv *dmub);
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 4a2cb0cdb0ba..56a03328e8e6 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -842,3 +842,38 @@ bool dmub_srv_should_detect(struct dmub_srv *dmub)
 
 	return dmub->hw_funcs.should_detect(dmub);
 }
+
+enum dmub_status dmub_srv_clear_inbox0_ack(struct dmub_srv *dmub)
+{
+	if (!dmub->hw_init || dmub->hw_funcs.clear_inbox0_ack_register)
+		return DMUB_STATUS_INVALID;
+
+	dmub->hw_funcs.clear_inbox0_ack_register(dmub);
+	return DMUB_STATUS_OK;
+}
+
+enum dmub_status dmub_srv_wait_for_inbox0_ack(struct dmub_srv *dmub, uint32_t timeout_us)
+{
+	uint32_t i = 0;
+	uint32_t ack = 0;
+
+	if (!dmub->hw_init || !dmub->hw_funcs.read_inbox0_ack_register)
+		return DMUB_STATUS_INVALID;
+
+	for (i = 0; i <= timeout_us; i++) {
+		ack = dmub->hw_funcs.read_inbox0_ack_register(dmub);
+		if (ack)
+			return DMUB_STATUS_OK;
+	}
+	return DMUB_STATUS_TIMEOUT;
+}
+
+enum dmub_status dmub_srv_send_inbox0_cmd(struct dmub_srv *dmub,
+		union dmub_inbox0_data_register data)
+{
+	if (!dmub->hw_init || dmub->hw_funcs.send_inbox0_cmd)
+		return DMUB_STATUS_INVALID;
+
+	dmub->hw_funcs.send_inbox0_cmd(dmub, data);
+	return DMUB_STATUS_OK;
+}
-- 
2.25.1

