Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59BFC47094
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA0E611B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA0E611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D99F6E4D4;
	Thu, 10 Jun 2021 16:29:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0A3F6E4D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cl+raHR7OihxM9AE9Zp/X9ouEkmgEX4IlkWHqDBXxNsVHVcvHKESSIcGSrTkLndciQwHhuGf8g7ISuk84zsCfpO1lgABhGkThJxHYiFd7mdrgqRE2YubYsnvVVGuhLfvRAPbkluyupdcndK8j0zE8DapZxrwYb49wWgeT4gktnJ9RE+nww0uB83N5CmNVZBEakvdoatEoADChos/SavE4eXoIIYxQUGiaf7AYAKchZkhKvwy36qaMy94PLh558GaD8Yroujo4RzQ9dpZkZM7JhAq6NHQ3jPfIy0Feucwn+gp3oo7bRad3YC7MBxj6fWUeHvUvxUEKhjCrsG8IpaZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lEe0KJmtw0fj2WSSHPoz6mx0f7TvHGj/oUNQrgM6Ic=;
 b=E/fkeup7epl1q3Zi3U+friIqPhsF0o4YMHWMoqTNvQNNwpVYNG1bM41tsOd4BmOP6DO02TXqeQmrzoZkWlLkZyMq1P8v8nSQU/md3ekkbtUccSsQUOd0fDkHWStlywLjDHtr7ltsK3oWLMxKbvYZIMiMWjAYzVPvAtRrNfiO9ynXL2FZfxvN5r2qx7D/gBLpjdEtVYKBhFcumNCm5JEpm0ID6Zq2j7dcS1i85i6esQO9mWQkX/haryZ6XwzjIHRQ0JjMu+sC7HO9UNqCYIkwIevwXAW+avDDiU3uG9bHUPO7Ivov4iBadvk6/aJouGFyjPCDotwiiFDgvedC+2wKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lEe0KJmtw0fj2WSSHPoz6mx0f7TvHGj/oUNQrgM6Ic=;
 b=drdQl0IitN3pPeW12xd5UCq8HomRAQQ9THXZsd5zOgEq1Bfi9x3huJZsjNboVn7Ba0wTWg1oV8KyBsOzM3IIj17IEZ/3LMqH3t38aWVz/R3pKwK9ccIFDGbcOjIuF3E7KLkM5OGAGk4WeTBr/61ApCEqv6okgObqeVPY34+sKzY=
Received: from CO1PR15CA0086.namprd15.prod.outlook.com (2603:10b6:101:20::30)
 by DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 16:29:10 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::24) by CO1PR15CA0086.outlook.office365.com
 (2603:10b6:101:20::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:08 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:07 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/24] drm/amd/display: add DMUB registers to crash dump
 diagnostic data.
Date: Thu, 10 Jun 2021 12:28:16 -0400
Message-ID: <20210610162838.287723-3-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74b934fc-6e36-42ca-feb2-08d92c2cdfed
X-MS-TrafficTypeDiagnostic: DM6PR12MB2954:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2954C56AD103DB7998D37BD3EB359@DM6PR12MB2954.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IvPIWSQoAOZGBuhfbZ5CHTdnhph8GUvBxeZnZJDlqvWBvbC7Jt7xL1LOyrUZ+RmYERElEbKkqmxxDEspTPsr3JQkYdOAmqu+j9PH5EidQg6t93rJDQx7sB8H4ihB/2PAow4y+Pvz4gZpBoIAL/wQ/uwJqpuLYEvu52pb3k1m/7tcIGue0uJQhaRnbHBxQBZM8OTKtZ3pVVlyWpD7c15amGDcjJETeDTQIk4LSmUh4j50Z/qquHp8+qo0p6FTOHIVJVCkn/zQgGDHi0Ow8G3ZmBiqASbzsIfV/e7/oPGYGt/ZnCBHSUzVqCAnla7DTzVvlhfChL4QwcJ1Ydg01Kmtr6DD0EbetHJsANiWEu22EHxZVbz6t/2Nxo43GL2L99AX30iXwFtol8s084mBccRsnPQzh83G57+UqzdC3jVqbUnyxrkvc7700cB/7zifhev38KARxgIisyd293zt4z7rKw+Yq7tno3F5v9gC7ElvGZ43jnDbYPQ9moWZx6dJNS/9bNYj4v9YJenbW/srcCB2i5eKyzx4Z+uV6enDiyMnukmqRbkUuoH4WNk3MphKEMU7SjSNQprIFdgTgBK6PVt39j8NCnEWhL3lBEBVLIrCpZcvtv/ggt4/mHAJfHnBPWN+QdY+eP3nmfGHPIBg6JIpOfRu57FXENWlNdJNVSC/nu8zVxLrTn3h5xiaB4QsJFbg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(46966006)(36840700001)(26005)(47076005)(82310400003)(426003)(186003)(336012)(2906002)(2616005)(356005)(70586007)(82740400003)(30864003)(70206006)(1076003)(6666004)(54906003)(4326008)(8676002)(478600001)(8936002)(6916009)(86362001)(81166007)(36756003)(316002)(83380400001)(7696005)(36860700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:09.5146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b934fc-6e36-42ca-feb2-08d92c2cdfed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2954
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
Cc: Ashley Thomas <Ashley.Thomas2@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ashley Thomas <Ashley.Thomas2@amd.com>

[WHY]
Ability to triage DMCUB is improved with availability of certain
dmub registers not currently captured in crash dump diagnostic data.

[HOW]
Add dmub registers to diagnostic data collection.

Thanks Nicholas Kazlauskas for awesome input on this!

Signed-off-by: Ashley Thomas <Ashley.Thomas2@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 100 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   4 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  29 +++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  65 +++++++++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |  14 ++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.c |   5 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c |   5 +-
 .../drm/amd/display/dmub/src/dmub_dcn301.c    |   5 +-
 .../drm/amd/display/dmub/src/dmub_dcn302.c    |   5 +-
 .../drm/amd/display/dmub/src/dmub_dcn303.c    |   5 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  10 ++
 11 files changed, 238 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 48ca23e1e599..36b6fbcc0441 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -86,6 +86,7 @@ void dc_dmub_srv_cmd_queue(struct dc_dmub_srv *dc_dmub_srv,
 
 error:
 	DC_ERROR("Error queuing DMUB command: status=%d\n", status);
+	dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
 }
 
 void dc_dmub_srv_cmd_execute(struct dc_dmub_srv *dc_dmub_srv)
@@ -95,8 +96,10 @@ void dc_dmub_srv_cmd_execute(struct dc_dmub_srv *dc_dmub_srv)
 	enum dmub_status status;
 
 	status = dmub_srv_cmd_execute(dmub);
-	if (status != DMUB_STATUS_OK)
+	if (status != DMUB_STATUS_OK) {
 		DC_ERROR("Error starting DMUB execution: status=%d\n", status);
+		dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+	}
 }
 
 void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv)
@@ -106,8 +109,10 @@ void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv)
 	enum dmub_status status;
 
 	status = dmub_srv_wait_for_idle(dmub, 100000);
-	if (status != DMUB_STATUS_OK)
+	if (status != DMUB_STATUS_OK) {
 		DC_ERROR("Error waiting for DMUB idle: status=%d\n", status);
+		dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+	}
 }
 
 void dc_dmub_srv_send_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
@@ -214,3 +219,94 @@ void dc_dmub_trace_event_control(struct dc *dc, bool enable)
 {
 	dm_helpers_dmub_outbox_interrupt_control(dc->ctx, enable);
 }
+
+bool dc_dmub_srv_get_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv, struct dmub_diagnostic_data *diag_data)
+{
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub || !diag_data)
+		return false;
+	return dmub_srv_get_diagnostic_data(dc_dmub_srv->dmub, diag_data);
+}
+
+void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
+{
+	struct dmub_diagnostic_data diag_data = {0};
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub) {
+		DC_LOG_ERROR("%s: invalid parameters.", __func__);
+		return;
+	}
+
+	if (!dc_dmub_srv_get_diagnostic_data(dc_dmub_srv, &diag_data)) {
+		DC_LOG_ERROR("%s: dc_dmub_srv_get_diagnostic_data failed.", __func__);
+		return;
+	}
+
+	DC_LOG_DEBUG(
+		"DMCUB STATE\n"
+		"    dmcub_version      : %08x\n"
+		"    scratch  [0]       : %08x\n"
+		"    scratch  [1]       : %08x\n"
+		"    scratch  [2]       : %08x\n"
+		"    scratch  [3]       : %08x\n"
+		"    scratch  [4]       : %08x\n"
+		"    scratch  [5]       : %08x\n"
+		"    scratch  [6]       : %08x\n"
+		"    scratch  [7]       : %08x\n"
+		"    scratch  [8]       : %08x\n"
+		"    scratch  [9]       : %08x\n"
+		"    scratch [10]       : %08x\n"
+		"    scratch [11]       : %08x\n"
+		"    scratch [12]       : %08x\n"
+		"    scratch [13]       : %08x\n"
+		"    scratch [14]       : %08x\n"
+		"    scratch [15]       : %08x\n"
+		"    pc                 : %08x\n"
+		"    unk_fault_addr     : %08x\n"
+		"    inst_fault_addr    : %08x\n"
+		"    data_fault_addr    : %08x\n"
+		"    inbox1_rptr        : %08x\n"
+		"    inbox1_wptr        : %08x\n"
+		"    inbox1_size        : %08x\n"
+		"    inbox0_rptr        : %08x\n"
+		"    inbox0_wptr        : %08x\n"
+		"    inbox0_size        : %08x\n"
+		"    is_enabled         : %d\n"
+		"    is_soft_reset      : %d\n"
+		"    is_secure_reset    : %d\n"
+		"    is_traceport_en    : %d\n"
+		"    is_cw0_en          : %d\n"
+		"    is_cw6_en          : %d\n",
+		diag_data.dmcub_version,
+		diag_data.scratch[0],
+		diag_data.scratch[1],
+		diag_data.scratch[2],
+		diag_data.scratch[3],
+		diag_data.scratch[4],
+		diag_data.scratch[5],
+		diag_data.scratch[6],
+		diag_data.scratch[7],
+		diag_data.scratch[8],
+		diag_data.scratch[9],
+		diag_data.scratch[10],
+		diag_data.scratch[11],
+		diag_data.scratch[12],
+		diag_data.scratch[13],
+		diag_data.scratch[14],
+		diag_data.scratch[15],
+		diag_data.pc,
+		diag_data.undefined_address_fault_addr,
+		diag_data.inst_fetch_fault_addr,
+		diag_data.data_write_fault_addr,
+		diag_data.inbox1_rptr,
+		diag_data.inbox1_wptr,
+		diag_data.inbox1_size,
+		diag_data.inbox0_rptr,
+		diag_data.inbox0_wptr,
+		diag_data.inbox0_size,
+		diag_data.is_dmcub_enabled,
+		diag_data.is_dmcub_soft_reset,
+		diag_data.is_dmcub_secure_reset,
+		diag_data.is_traceport_en,
+		diag_data.is_cw0_enabled,
+		diag_data.is_cw6_enabled);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index f5489c7aa770..0d5680198937 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -71,4 +71,8 @@ void dc_dmub_trace_event_control(struct dc *dc, bool enable);
 
 void dc_dmub_srv_send_inbox0_cmd(struct dc_dmub_srv *dmub_srv, union dmub_inbox0_data_register data);
 
+bool dc_dmub_srv_get_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv, struct dmub_diagnostic_data *dmub_oca);
+
+void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv);
+
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 7634e8d94543..2bf5e7207744 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -243,6 +243,31 @@ struct dmub_srv_hw_params {
 #endif
 };
 
+/**
+ * struct dmub_diagnostic_data - Diagnostic data retrieved from DMCUB for
+ * debugging purposes, including logging, crash analysis, etc.
+ */
+struct dmub_diagnostic_data {
+	uint32_t dmcub_version;
+	uint32_t scratch[16];
+	uint32_t pc;
+	uint32_t undefined_address_fault_addr;
+	uint32_t inst_fetch_fault_addr;
+	uint32_t data_write_fault_addr;
+	uint32_t inbox1_rptr;
+	uint32_t inbox1_wptr;
+	uint32_t inbox1_size;
+	uint32_t inbox0_rptr;
+	uint32_t inbox0_wptr;
+	uint32_t inbox0_size;
+	uint8_t is_dmcub_enabled : 1;
+	uint8_t is_dmcub_soft_reset : 1;
+	uint8_t is_dmcub_secure_reset : 1;
+	uint8_t is_traceport_en : 1;
+	uint8_t is_cw0_enabled : 1;
+	uint8_t is_cw6_enabled : 1;
+};
+
 /**
  * struct dmub_srv_base_funcs - Driver specific base callbacks
  */
@@ -335,6 +360,8 @@ struct dmub_srv_hw_funcs {
 
 	void (*send_inbox0_cmd)(struct dmub_srv *dmub, union dmub_inbox0_data_register data);
 	uint32_t (*get_current_time)(struct dmub_srv *dmub);
+
+	void (*get_diagnostic_data)(struct dmub_srv *dmub, struct dmub_diagnostic_data *dmub_oca);
 };
 
 /**
@@ -685,6 +712,8 @@ enum dmub_status dmub_srv_cmd_with_reply_data(struct dmub_srv *dmub,
 
 bool dmub_srv_get_outbox0_msg(struct dmub_srv *dmub, struct dmcub_trace_buf_entry *entry);
 
+bool dmub_srv_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data);
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 8cdc1c75394e..a6540e27044d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -40,7 +40,10 @@
 
 const struct dmub_srv_common_regs dmub_srv_dcn20_regs = {
 #define DMUB_SR(reg) REG_OFFSET(reg),
-	{ DMUB_COMMON_REGS() },
+	{
+		DMUB_COMMON_REGS()
+		DMCUB_INTERNAL_REGS()
+	},
 #undef DMUB_SR
 
 #define DMUB_SF(reg, field) FD_MASK(reg, field),
@@ -404,3 +407,63 @@ uint32_t dmub_dcn20_get_current_time(struct dmub_srv *dmub)
 {
 	return REG_READ(DMCUB_TIMER_CURRENT);
 }
+
+void dmub_dcn20_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data)
+{
+	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset;
+	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
+
+	if (!dmub || !diag_data)
+		return;
+
+	memset(diag_data, 0, sizeof(*diag_data));
+
+	diag_data->dmcub_version = dmub->fw_version;
+
+	diag_data->scratch[0] = REG_READ(DMCUB_SCRATCH0);
+	diag_data->scratch[1] = REG_READ(DMCUB_SCRATCH1);
+	diag_data->scratch[2] = REG_READ(DMCUB_SCRATCH2);
+	diag_data->scratch[3] = REG_READ(DMCUB_SCRATCH3);
+	diag_data->scratch[4] = REG_READ(DMCUB_SCRATCH4);
+	diag_data->scratch[5] = REG_READ(DMCUB_SCRATCH5);
+	diag_data->scratch[6] = REG_READ(DMCUB_SCRATCH6);
+	diag_data->scratch[7] = REG_READ(DMCUB_SCRATCH7);
+	diag_data->scratch[8] = REG_READ(DMCUB_SCRATCH8);
+	diag_data->scratch[9] = REG_READ(DMCUB_SCRATCH9);
+	diag_data->scratch[10] = REG_READ(DMCUB_SCRATCH10);
+	diag_data->scratch[11] = REG_READ(DMCUB_SCRATCH11);
+	diag_data->scratch[12] = REG_READ(DMCUB_SCRATCH12);
+	diag_data->scratch[13] = REG_READ(DMCUB_SCRATCH13);
+	diag_data->scratch[14] = REG_READ(DMCUB_SCRATCH14);
+	diag_data->scratch[15] = REG_READ(DMCUB_SCRATCH15);
+
+	diag_data->undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
+	diag_data->inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
+	diag_data->data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
+
+	diag_data->inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
+	diag_data->inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
+	diag_data->inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
+
+	diag_data->inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
+	diag_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
+	diag_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
+
+	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
+	diag_data->is_dmcub_enabled = is_dmub_enabled;
+
+	REG_GET(DMCUB_CNTL, DMCUB_SOFT_RESET, &is_soft_reset);
+	diag_data->is_dmcub_soft_reset = is_soft_reset;
+
+	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
+	diag_data->is_dmcub_secure_reset = is_sec_reset;
+
+	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
+	diag_data->is_traceport_en  = is_traceport_enabled;
+
+	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
+	diag_data->is_cw0_enabled = is_cw0_enabled;
+
+	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
+	diag_data->is_cw6_enabled = is_cw6_enabled;
+}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
index f772f8b348ea..c2e5831ac52c 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
@@ -36,6 +36,9 @@ struct dmub_srv;
 	DMUB_SR(DMCUB_CNTL) \
 	DMUB_SR(DMCUB_MEM_CNTL) \
 	DMUB_SR(DMCUB_SEC_CNTL) \
+	DMUB_SR(DMCUB_INBOX0_SIZE) \
+	DMUB_SR(DMCUB_INBOX0_RPTR) \
+	DMUB_SR(DMCUB_INBOX0_WPTR) \
 	DMUB_SR(DMCUB_INBOX1_BASE_ADDRESS) \
 	DMUB_SR(DMCUB_INBOX1_SIZE) \
 	DMUB_SR(DMCUB_INBOX1_RPTR) \
@@ -108,7 +111,12 @@ struct dmub_srv;
 	DMUB_SR(DCN_VM_FB_LOCATION_BASE) \
 	DMUB_SR(DCN_VM_FB_OFFSET) \
 	DMUB_SR(DMCUB_INTERRUPT_ACK) \
-	DMUB_SR(DMCUB_TIMER_CURRENT)
+	DMUB_SR(DMCUB_TIMER_CURRENT) \
+	DMUB_SR(DMCUB_INST_FETCH_FAULT_ADDR) \
+	DMUB_SR(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR) \
+	DMUB_SR(DMCUB_DATA_WRITE_FAULT_ADDR)
+
+#define DMCUB_INTERNAL_REGS()
 
 #define DMUB_COMMON_FIELDS() \
 	DMUB_SF(DMCUB_CNTL, DMCUB_ENABLE) \
@@ -118,6 +126,7 @@ struct dmub_srv;
 	DMUB_SF(DMCUB_MEM_CNTL, DMCUB_MEM_WRITE_SPACE) \
 	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_SEC_RESET) \
 	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_MEM_UNIT_ID) \
+	DMUB_SF(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS) \
 	DMUB_SF(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_TOP_ADDRESS) \
 	DMUB_SF(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE) \
 	DMUB_SF(DMCUB_REGION3_CW1_TOP_ADDRESS, DMCUB_REGION3_CW1_TOP_ADDRESS) \
@@ -147,6 +156,7 @@ struct dmub_srv;
 struct dmub_srv_common_reg_offset {
 #define DMUB_SR(reg) uint32_t reg;
 	DMUB_COMMON_REGS()
+	DMCUB_INTERNAL_REGS()
 #undef DMUB_SR
 };
 
@@ -234,4 +244,6 @@ bool dmub_dcn20_use_cached_trace_buffer(struct dmub_srv *dmub);
 
 uint32_t dmub_dcn20_get_current_time(struct dmub_srv *dmub);
 
+void dmub_dcn20_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *dmub_oca);
+
 #endif /* _DMUB_DCN20_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
index 1cf67b3e4771..51bb9bceb1b1 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
@@ -39,7 +39,10 @@
 
 const struct dmub_srv_common_regs dmub_srv_dcn21_regs = {
 #define DMUB_SR(reg) REG_OFFSET(reg),
-	{ DMUB_COMMON_REGS() },
+	{
+		DMUB_COMMON_REGS()
+		DMCUB_INTERNAL_REGS()
+	},
 #undef DMUB_SR
 
 #define DMUB_SF(reg, field) FD_MASK(reg, field),
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
index fb11c8d39208..81dae75e9ff8 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c
@@ -40,7 +40,10 @@
 
 const struct dmub_srv_common_regs dmub_srv_dcn30_regs = {
 #define DMUB_SR(reg) REG_OFFSET(reg),
-	{ DMUB_COMMON_REGS() },
+	{
+		DMUB_COMMON_REGS()
+		DMCUB_INTERNAL_REGS()
+	},
 #undef DMUB_SR
 
 #define DMUB_SF(reg, field) FD_MASK(reg, field),
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn301.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn301.c
index 197398257692..84c3ab3becc5 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn301.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn301.c
@@ -39,7 +39,10 @@
 
 const struct dmub_srv_common_regs dmub_srv_dcn301_regs = {
 #define DMUB_SR(reg) REG_OFFSET(reg),
-	{ DMUB_COMMON_REGS() },
+	{
+		DMUB_COMMON_REGS()
+		DMCUB_INTERNAL_REGS()
+	},
 #undef DMUB_SR
 
 #define DMUB_SF(reg, field) FD_MASK(reg, field),
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn302.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn302.c
index f5db4437a882..8c02575e168d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn302.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn302.c
@@ -39,7 +39,10 @@
 
 const struct dmub_srv_common_regs dmub_srv_dcn302_regs = {
 #define DMUB_SR(reg) REG_OFFSET(reg),
-	{ DMUB_COMMON_REGS() },
+	{
+		DMUB_COMMON_REGS()
+		DMCUB_INTERNAL_REGS()
+	},
 #undef DMUB_SR
 
 #define DMUB_SF(reg, field) FD_MASK(reg, field),
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.c
index 9331e1719901..b42369984473 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn303.c
@@ -21,7 +21,10 @@
 
 const struct dmub_srv_common_regs dmub_srv_dcn303_regs = {
 #define DMUB_SR(reg) REG_OFFSET(reg),
-	{ DMUB_COMMON_REGS() },
+	{
+		DMUB_COMMON_REGS()
+		DMCUB_INTERNAL_REGS()
+	},
 #undef DMUB_SR
 
 #define DMUB_SF(reg, field) FD_MASK(reg, field),
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 681500f42c91..a195734b4ddf 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -176,6 +176,8 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		funcs->get_outbox0_wptr = dmub_dcn20_get_outbox0_wptr;
 		funcs->set_outbox0_rptr = dmub_dcn20_set_outbox0_rptr;
 
+		funcs->get_diagnostic_data = dmub_dcn20_get_diagnostic_data;
+
 		if (asic == DMUB_ASIC_DCN21) {
 			dmub->regs = &dmub_srv_dcn21_regs;
 
@@ -794,3 +796,11 @@ bool dmub_srv_get_outbox0_msg(struct dmub_srv *dmub, struct dmcub_trace_buf_entr
 
 	return dmub_rb_out_trace_buffer_front(&dmub->outbox0_rb, (void *)entry);
 }
+
+bool dmub_srv_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data)
+{
+	if (!dmub || !dmub->hw_funcs.get_diagnostic_data || !diag_data)
+		return false;
+	dmub->hw_funcs.get_diagnostic_data(dmub, diag_data);
+	return true;
+}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
