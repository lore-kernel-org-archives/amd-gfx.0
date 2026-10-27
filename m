Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FA5606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xAA0BcM9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7107D10F8A0;
	Tue, 27 Oct 2026 23:23:58 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013057.outbound.protection.outlook.com
 [40.93.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6157610E3F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1NwYeTkOxQITxFvY/rdfJabg4n+7pM1UDhZWkl6Zz4poRdkEmUWWLRMWeAfnEK4qWcT+fLh8FsCuDTlnfJxx2KybvXRkfnR12mq6yETC8TO+jJNHK9Y3WjbMZmcQ9PDmtlcSU5AfjsLKWsy53Jg2lr/sUImpaDSlcetbog1Ps+jbT2Qqm++Xt2cPj/KRfzDu7xL1vtLeOEbHOo/FTcDx5IBsFe8dS4bK53tpp5vjV2xv0wlS3k8NyJ/aMDxCmy1Z4BzAGngcFqm+zBJuudWHWXYmmCJ1rRMD/Cc6D0le1oZh0d/t3nV7fvJzTp4Q5usjV4XoxiKrADFRYA5ajxsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZPXiF2CArzqgTokYwvqRYebXyadjuf8modgOFFSrhM=;
 b=Z4gmlAua5/Mu8eIZp7jCfy4gLrP3YQKBoJNt/7qd/82NPJ6vMNj9TWWzXAwu89SBEtK0TnIRBtkieGBUiSpKNx4Egjn4JkLcRzoT3qFu6lo/Xa0G61QbtZxkRt+tFertB7RP5LGr5iW/iWyKCTMautpoLuS0tw9ZwWSKLls7R+KBXZjG/FzORvPUewgSQxiVxw4+qHFn5B86v30S9Aifcg1YQJEVj7B8vZQLe1xnoKf2Y4bsU3+bF0fyA2U4LnuxongUGcms/UKlMi9MAl0YJfwNFD65KGcmZMtfk0z5vdr9ovj8KKLYOzolvPGFNROa7tXaHzVFXRbR0ITtTF5anw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZPXiF2CArzqgTokYwvqRYebXyadjuf8modgOFFSrhM=;
 b=xAA0BcM9XElAED8VbJPnDnFqYAPnNWoXrtDlj2cek4etiGjskA1RJLOi2n634cYjQlKAMYYM7R6+v1Vj1KDzjdrXYZbKUKkH9df9+Eh+k0FyJcbwN+cC592Syh81DK6G6f3tIVPPS0aE6l6lE4TrZ38BuKDgjcTsqy3Qvyz+tgs=
Received: from CH3P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::29)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:23:47 +0000
Received: from CH01EPF000BE946.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::3a) by CH3P221CA0005.outlook.office365.com
 (2603:10b6:610:1e7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Tue,
 27 Oct 2026 23:23:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE946.mail.protection.outlook.com (10.167.244.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:23:46 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:23:43 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Rafal Ostrowski <Rafal.Ostrowski@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Rafal Ostrowski <rafal.ostrowski@amd.com>
Subject: [PATCH 15/28] drm/amd/display: Decouple FAMS2 config update from
 dc/dc_state and add BLS opcode
Date: Tue, 27 Oct 2026 17:17:11 -0600
Message-ID: <20261027232005.2879750-16-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE946:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: 3acf895b-8d22-4c98-bc70-08df34815962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|18002099003|22082099003|6133799003|20052099010|3023799007|5023799004|11063799006|56012099006|261026135527099003|10067099003|261021133027099003|261026140227099003|261021130227099003|261009221227099003|261021121427099003|261026121527099003|261022113327099003|261009220027099003|261009223027099003|261009221727099003|261009223327099003|261021135927099003|261022075727099003|261022105027099003|261022115727099003|261026130827099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 5nhTaEJikFkjM/ZNVB9GYpSjuu7+o8TaygoH1o1ORw0Y7k/lFelUoemTH/cscQ4qPWjypt9dIPqAnDkBh82bAMk4mBbQQtwizvACTof8CrJ4bkNZt2odVfDmOeocpQaxhCKzAVaIZaY4etFO4XAwLIwzFLyU0EpmDWZL33Bd+JFMEWaEpMFodkPNk40mXuvayizV/pD10UivxKdOeHnQKfknAJJaUNWrE3tJxRCRT8n3apmNik2I5f0FKMgWKWnYc0Tw+8tGlKt/6RCYDz6GaXvt88heflJD99MNZHpnZY9fd8npK5vimCYYKVIPXoHZpkG8DiXNtLgwxIWJShWzeKTbUN8zHw4xdVmTuYD1UDd9kmkA7Z6TQODANmLCuVdFz3SWNz+SUx3dyUK7Raiyc8FM6HWC8FJ9GP1EyDcY8Ey59gLD387AzmITnQMMvzACLhKqtx7PLlxvnQ1rER9JolxF7mNN8w3Qnc3ssfnOVTy049o2gW4O4n+Gu0ZYiGjKHTv7nBfROrI+ZM+SymhMkIh8l5k6vG9eDI6WLrU9/CcqDFkYjpJD2D1qX1MBTylGklHIFj6MhIzMJw9MKJeo5FBpGK9AiOt1XKa9BaA0IA6taQMPdYK/6jrVMof1yny643NiGHm4pZkzjI8s728byErbilG69kt0vT7oqlchZNb9OzYoWZePzggDXTgRLs4nMuxAyZpGkTvRv+1Xbv7a8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(20052099010)(3023799007)(5023799004)(11063799006)(56012099006)(261026135527099003)(10067099003)(261021133027099003)(261026140227099003)(261021130227099003)(261009221227099003)(261021121427099003)(261026121527099003)(261022113327099003)(261009220027099003)(261009223027099003)(261009221727099003)(261009223327099003)(261021135927099003)(261022075727099003)(261022105027099003)(261022115727099003)(261026130827099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SCyCBKtDK/snMKTR2H9mLu02kvJTjoPglUoRDDKZaMRIe0UKW+obhFo9NBo9WdH8NyVKQjSgQP6fUUXT1ud2xBKb59095UMdArqwj0O2cqzL9ZA1bxQbS0soO0/mo58NZl7DIXmAbQqwTx07eE0vw/WjLrrRdow5MndHwa0SdyayFyPWryLj8RP7uJBayNin98VWkrRJMPdCQUAzRiJmiz4CdjYH+7dSSjbKs5SsqnlUYROgofdnA3GdWpiB7ZjdmAfJeJQ7hR+0tk2Pb03Rz07MgCKm0H4G6s5HDazFukBSU2XaNPAVqVKRZ5GYC4nmNVPXi6MargKm9ewYVM16MX4v95IMbFKoGss3Rx3w8zKdXZXYxn9cLLx0bZQnUFbfjGuQXb6PbBwXpgrLUMpZgsxhibjO4dWL+vtpYnqMlF8y4wHgkobfPrs0U2Lgdg75
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:23:46.4432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acf895b-8d22-4c98-bc70-08df34815962
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE946.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Rafal Ostrowski <Rafal.Ostrowski@amd.com>

[WHY]
The FAMS2 config path (dcn401_fams2_update_config down to
dc_dmub_srv_cmd_list_queue_execute) took dc and dc_state, so it could
not be turned into a BLS opcode whose executor must not touch dc or
dc_state.

[HOW]
- Add struct dc_dmub_fams2_config_data and make
  dc_dmub_srv_fams2_update_config() take (dc_dmub_srv, data); the RB and
  IB senders no longer read dc or dc_state. The per-stream arrays are
  pointers into dc_state to keep union block_sequence_params small.
- Snapshot disable_timeout and enable_dmu_recovery into struct
  dc_dmub_srv so queue_execute, wait_for_idle and handle_failure no
  longer read ctx->dc->debug.
- Split the DCN4.01 hwseq code: dcn401_fams2_build_update_config() fills
  the data from dc/dc_state and replaces hwss.fams2_update_config for
  DCN4.01/4.2/6.0. Direct callers (prepare/optimize_bandwidth and
  hardware_release) build the data and send it with
  dc_dmub_srv_fams2_update_config().
- Add the DMUB_FAMS2_UPDATE_CONFIG block sequence opcode:
  hwss_add_dmub_fams2_update_config() builds the data and
  hwss_dmub_fams2_update_config() sends it. Use it, bracketed by
  hwss_add_dmub_hw_control_lock_fast(), in
  dcn401_prepare_bandwidth_sequence() (disable) and
  dcn401_optimize_bandwidth_sequence() (enable).

Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  30 +++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 113 +++++++++---------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  27 ++++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  64 ++++++----
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   4 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   2 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   2 +-
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |   2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  17 ++-
 9 files changed, 177 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 3c5ffa7073f5..88262cf86598 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -88,6 +88,33 @@ void hwss_dmub_hw_control_lock_fast(union block_sequence_params *params)
 		dmub_hw_lock_mgr_inbox0_cmd(p->dmub_srv, p->command);
 }
 
+void hwss_add_dmub_fams2_update_config(struct block_sequence_state *seq_state,
+		struct dc *dc, struct dc_state *context, bool enable)
+{
+	struct dmub_fams2_update_config_params *params;
+
+	if (!seq_state || !seq_state->steps || !seq_state->num_steps || !dc || !dc->ctx ||
+			!dc->hwss.fams2_build_update_config ||
+			*seq_state->num_steps >= MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		ASSERT(!seq_state || !seq_state->num_steps || *seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE);
+		return;
+	}
+
+	params = &seq_state->steps[*seq_state->num_steps].params.dmub_fams2_update_config_params;
+	if (!dc->hwss.fams2_build_update_config(dc, context, enable, &params->data))
+		return;
+
+	params->dmub_srv = dc->ctx->dmub_srv;
+	seq_state->steps[(*seq_state->num_steps)++].func = DMUB_FAMS2_UPDATE_CONFIG;
+}
+
+void hwss_dmub_fams2_update_config(union block_sequence_params *params)
+{
+	struct dmub_fams2_update_config_params *p = &params->dmub_fams2_update_config_params;
+
+	dc_dmub_srv_fams2_update_config(p->dmub_srv, &p->data);
+}
+
 #define MAX_NUM_MCACHE 8
 
 /* used as index in array of black_color_format */
@@ -2198,6 +2225,9 @@ void hwss_execute_sequence(struct dc *dc,
 		case HUBBUB_PROGRAM_COMPBUF_SEGMENTS:
 			hwss_hubbub_program_compbuf_segments(params);
 			break;
+		case DMUB_FAMS2_UPDATE_CONFIG:
+			hwss_dmub_fams2_update_config(params);
+			break;
 		default:
 			ASSERT(false);
 			break;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index f1a0225bbf84..323e8bec23dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -46,12 +46,14 @@ static void dc_dmub_srv_construct(struct dc_dmub_srv *dc_srv, struct dc *dc,
 {
 	dc_srv->dmub = dmub;
 	dc_srv->ctx = dc->ctx;
+	dc_srv->disable_timeout = dc->debug.disable_timeout;
+	dc_srv->enable_dmu_recovery = dc->debug.enable_dmu_recovery;
 }
 
 static void dc_dmub_srv_handle_failure(struct dc_dmub_srv *dc_dmub_srv)
 {
 	dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
-	if (dc_dmub_srv->ctx->dc->debug.enable_dmu_recovery)
+	if (dc_dmub_srv->enable_dmu_recovery)
 		dm_helpers_dmu_timeout(dc_dmub_srv->ctx);
 }
 
@@ -92,7 +94,7 @@ bool dc_dmub_srv_wait_for_pending(struct dc_dmub_srv *dc_dmub_srv)
 
 	do {
 		status = dmub_srv_wait_for_pending(dmub, DMUB_CMD_DEFAULT_MAX_WAIT_US);
-	} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
+	} while (dc_dmub_srv->disable_timeout && status != DMUB_STATUS_OK);
 
 	if (status != DMUB_STATUS_OK) {
 		DC_ERROR("Error waiting for DMUB idle: status=%d\n", status);
@@ -162,7 +164,7 @@ static bool dc_dmub_srv_reg_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_s
 		/* confirm no messages pending */
 		do {
 			status = dmub_srv_wait_for_idle(dmub, timeout_us);
-		} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
+		} while (dc_dmub_srv->disable_timeout && status != DMUB_STATUS_OK);
 
 		/* queue command */
 		if (status == DMUB_STATUS_OK)
@@ -218,7 +220,7 @@ static bool dc_dmub_srv_fb_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_sr
 
 			do {
 					status = dmub_srv_wait_for_inbox_free(dmub, timeout_us, count - i);
-			} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
+			} while (dc_dmub_srv->disable_timeout && status != DMUB_STATUS_OK);
 
 			/* Requeue the command. */
 			status = dmub_srv_fb_cmd_queue(dmub, &cmd_list[i]);
@@ -333,7 +335,7 @@ bool dc_dmub_srv_wait_for_idle(struct dc_dmub_srv *dc_dmub_srv,
 	if (wait_type != DM_DMUB_WAIT_TYPE_NO_WAIT) {
 		do {
 			status = dmub_srv_wait_for_idle(dmub, timeout_us);
-		} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
+		} while (dc_dmub_srv->disable_timeout && status != DMUB_STATUS_OK);
 
 		if (status != DMUB_STATUS_OK) {
 			DC_LOG_DEBUG("No reply for DMUB command: status=%d\n", status);
@@ -1359,7 +1361,7 @@ bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait)
 	dc_ctx = dc_dmub_srv->ctx;
 
 	if (wait) {
-		if (dc_dmub_srv->ctx->dc->debug.disable_timeout) {
+		if (dc_dmub_srv->disable_timeout) {
 			do {
 				status = dmub_srv_wait_for_hw_pwr_up(dc_dmub_srv->dmub, 500000);
 			} while (status != DMUB_STATUS_OK);
@@ -1853,11 +1855,10 @@ bool dc_wake_and_execute_gpint(const struct dc_context *ctx, enum dmub_gpint_com
 	return result;
 }
 
-static void dc_dmub_srv_rb_based_fams2_update_config(struct dc *dc,
-		struct dc_state *context,
-		bool enable)
+static void dc_dmub_srv_rb_based_fams2_update_config(struct dc_dmub_srv *dc_dmub_srv,
+		const struct dc_dmub_fams2_config_data *data)
 {
-	uint32_t num_cmds = 1;
+	uint32_t cmd_count = 1;
 	uint32_t i;
 	union dmub_rb_cmd cmd[2 * MAX_STREAMS + 1];
 	struct dmub_rb_cmd_fams2 *global_cmd = &cmd[0].fams2_config;
@@ -1869,19 +1870,21 @@ static void dc_dmub_srv_rb_based_fams2_update_config(struct dc *dc,
 	global_cmd->header.payload_bytes =
 			sizeof(struct dmub_rb_cmd_fams2) - sizeof(struct dmub_cmd_header);
 
-	if (enable) {
+	if (data->enable) {
 		/* send global configuration parameters */
-		memcpy(&global_cmd->config.global, &context->bw_ctx.bw.dcn.fams2_global_config, sizeof(struct dmub_cmd_fams2_global_config));
+		memcpy(&global_cmd->config.global, &data->global, sizeof(struct dmub_cmd_fams2_global_config));
 
 		/* copy static feature configuration overrides */
-		global_cmd->config.global.features.bits.enable_stall_recovery = dc->debug.fams2_config.bits.enable_stall_recovery;
-		global_cmd->config.global.features.bits.enable_debug = dc->debug.fams2_config.bits.enable_debug;
-		global_cmd->config.global.features.bits.enable_offload_flip = dc->debug.fams2_config.bits.enable_offload_flip;
+		global_cmd->config.global.features.bits.enable_stall_recovery =
+				data->features.bits.enable_stall_recovery;
+		global_cmd->config.global.features.bits.enable_debug = data->features.bits.enable_debug;
+		global_cmd->config.global.features.bits.enable_offload_flip = data->features.bits.enable_offload_flip;
 
 		/* construct per-stream configs */
-		for (i = 0; i < context->bw_ctx.bw.dcn.fams2_global_config.num_streams; i++) {
+		for (i = 0; i < data->global.num_streams; i++) {
 			struct dmub_rb_cmd_fams2 *stream_base_cmd = &cmd[i+1].fams2_config;
-			struct dmub_rb_cmd_fams2 *stream_sub_state_cmd = &cmd[i+1+context->bw_ctx.bw.dcn.fams2_global_config.num_streams].fams2_config;
+			struct dmub_rb_cmd_fams2 *stream_sub_state_cmd =
+					&cmd[i+1+data->global.num_streams].fams2_config;
 
 			/* configure command header */
 			stream_base_cmd->header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
@@ -1896,38 +1899,37 @@ static void dc_dmub_srv_rb_based_fams2_update_config(struct dc *dc,
 			stream_sub_state_cmd->header.multi_cmd_pending = 1;
 			/* copy stream static base state */
 			memcpy(&stream_base_cmd->config,
-					&context->bw_ctx.bw.dcn.fams2_stream_base_params[i],
+					&data->stream_base[i],
 					sizeof(union dmub_cmd_fams2_config));
 			/* copy stream static sub state */
 			memcpy(&stream_sub_state_cmd->config,
-					&context->bw_ctx.bw.dcn.fams2_stream_sub_params[i],
+					&data->stream_sub[i],
 					sizeof(union dmub_cmd_fams2_config));
 
 			/* temp override */
-			stream_base_cmd->config.stream_v1.base.config.bits.imm_restore_drr = dc->debug.fams2_imm_restore_drr;
+			stream_base_cmd->config.stream_v1.base.config.bits.imm_restore_drr = data->imm_restore_drr;
 		}
 	}
 
 	/* apply feature configuration based on current driver state */
-	global_cmd->config.global.features.bits.enable_visual_confirm = dc->debug.visual_confirm == VISUAL_CONFIRM_FAMS2;
-	global_cmd->config.global.features.bits.enable = enable && context->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable;
-	global_cmd->config.global.features.bits.enable_ppt_check = dc->debug.fams2_config.bits.enable_ppt_check;
+	global_cmd->config.global.features.bits.enable_visual_confirm = data->visual_confirm;
+	global_cmd->config.global.features.bits.enable = data->enable && data->global.features.bits.enable;
+	global_cmd->config.global.features.bits.enable_ppt_check = data->features.bits.enable_ppt_check;
 
-	if (enable) {
+	if (data->enable) {
 		/* set multi pending for global, and unset for last stream cmd */
 		global_cmd->header.multi_cmd_pending = 1;
-		cmd[2 * context->bw_ctx.bw.dcn.fams2_global_config.num_streams].fams2_config.header.multi_cmd_pending = 0;
-		num_cmds += 2 * context->bw_ctx.bw.dcn.fams2_global_config.num_streams;
+		cmd[2 * data->global.num_streams].fams2_config.header.multi_cmd_pending = 0;
+		cmd_count += 2 * data->global.num_streams;
 	}
 
-	dm_execute_dmub_cmd_list(dc->ctx, num_cmds, cmd, DM_DMUB_WAIT_TYPE_WAIT);
+	dm_execute_dmub_cmd_list(dc_dmub_srv->ctx, cmd_count, cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
-static void dc_dmub_srv_ib_based_fams2_update_config(struct dc *dc,
-		struct dc_state *context,
-		bool enable)
+static void dc_dmub_srv_ib_based_fams2_update_config(struct dc_dmub_srv *dc_dmub_srv,
+		const struct dc_dmub_fams2_config_data *data)
 {
-	struct dmub_fams2_config_v2 *config = (struct dmub_fams2_config_v2 *)dc->ctx->dmub_srv->dmub->ib_mem_gart.cpu_addr;
+	struct dmub_fams2_config_v2 *config = (struct dmub_fams2_config_v2 *)dc_dmub_srv->dmub->ib_mem_gart.cpu_addr;
 	union dmub_rb_cmd cmd;
 	uint32_t i;
 
@@ -1937,51 +1939,54 @@ static void dc_dmub_srv_ib_based_fams2_update_config(struct dc *dc,
 	cmd.ib_fams2_config.header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
 	cmd.ib_fams2_config.header.sub_type = DMUB_CMD__FAMS2_IB_CONFIG;
 
-	cmd.ib_fams2_config.ib_data.src.quad_part = dc->ctx->dmub_srv->dmub->ib_mem_gart.gpu_addr;
+	cmd.ib_fams2_config.ib_data.src.quad_part = dc_dmub_srv->dmub->ib_mem_gart.gpu_addr;
 	cmd.ib_fams2_config.ib_data.size = sizeof(*config);
 
-	if (enable) {
+	if (data->enable) {
 		/* send global configuration parameters */
-		memcpy(&config->global, &context->bw_ctx.bw.dcn.fams2_global_config,
+		memcpy(&config->global, &data->global,
 			sizeof(struct dmub_cmd_fams2_global_config));
 
 		/* copy static feature configuration overrides */
-		config->global.features.bits.enable_stall_recovery = dc->debug.fams2_config.bits.enable_stall_recovery;
-		config->global.features.bits.enable_offload_flip = dc->debug.fams2_config.bits.enable_offload_flip;
-		config->global.features.bits.enable_debug = dc->debug.fams2_config.bits.enable_debug;
-		config->global.features.bits.alternate_channel_workaround = dc->debug.fams2_config.bits.alternate_channel_workaround;
+		config->global.features.bits.enable_stall_recovery = data->features.bits.enable_stall_recovery;
+		config->global.features.bits.enable_offload_flip = data->features.bits.enable_offload_flip;
+		config->global.features.bits.enable_debug = data->features.bits.enable_debug;
+		config->global.features.bits.alternate_channel_workaround =
+				data->features.bits.alternate_channel_workaround;
 
 		/* construct per-stream configs */
-		for (i = 0; i < context->bw_ctx.bw.dcn.fams2_global_config.num_streams; i++) {
+		for (i = 0; i < data->global.num_streams; i++) {
 			/* copy stream static base state */
 			memcpy(&config->stream_v1[i].base,
-				&context->bw_ctx.bw.dcn.fams2_stream_base_params[i],
+				&data->stream_base[i],
 				sizeof(config->stream_v1[i].base));
 
 			/* copy stream static sub-state */
 			memcpy(&config->stream_v1[i].sub_state,
-				&context->bw_ctx.bw.dcn.fams2_stream_sub_params_v2[i],
+				&data->stream_sub_v2[i],
 				sizeof(config->stream_v1[i].sub_state));
 		}
 	}
 
-	config->global.features.bits.enable_visual_confirm = dc->debug.visual_confirm == VISUAL_CONFIRM_FAMS2;
-	config->global.features.bits.enable = enable && context->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable;
-	config->global.features.bits.enable_ppt_check = dc->debug.fams2_config.bits.enable_ppt_check;
+	config->global.features.bits.enable_visual_confirm = data->visual_confirm;
+	config->global.features.bits.enable = data->enable && data->global.features.bits.enable;
+	config->global.features.bits.enable_ppt_check = data->features.bits.enable_ppt_check;
 
-	dmub_srv_flush_buffer_mem(dc->ctx->dmub_srv->dmub, &dc->ctx->dmub_srv->dmub->ib_mem_gart);
+	dmub_srv_flush_buffer_mem(dc_dmub_srv->dmub, &dc_dmub_srv->dmub->ib_mem_gart);
 
-	dm_execute_dmub_cmd_list(dc->ctx, 1, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+	dm_execute_dmub_cmd_list(dc_dmub_srv->ctx, 1, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
-void dc_dmub_srv_fams2_update_config(struct dc *dc,
-		struct dc_state *context,
-		bool enable)
+void dc_dmub_srv_fams2_update_config(struct dc_dmub_srv *dc_dmub_srv,
+		const struct dc_dmub_fams2_config_data *data)
 {
-	if (dc->debug.fams_version.major == 2)
-		dc_dmub_srv_rb_based_fams2_update_config(dc, context, enable);
-	if (dc->debug.fams_version.major == 3)
-		dc_dmub_srv_ib_based_fams2_update_config(dc, context, enable);
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return;
+
+	if (data->fams_version_major == 2)
+		dc_dmub_srv_rb_based_fams2_update_config(dc_dmub_srv, data);
+	if (data->fams_version_major == 3)
+		dc_dmub_srv_ib_based_fams2_update_config(dc_dmub_srv, data);
 }
 
 void dc_dmub_srv_fams2_drr_update(struct dc *dc,
@@ -2023,7 +2028,7 @@ void dc_dmub_srv_fams2_passthrough_flip(
 	int num_cmds = 0;
 	struct dc_stream_status *stream_status = dc_stream_get_status(stream);
 
-	if (surface_count <= 0 || stream_status == NULL)
+	if (surface_count <= 0 || stream_status == NULL || !dc->ctx->dmub_srv)
 		return;
 
 	memset(cmds, 0, sizeof(union dmub_rb_cmd) * MAX_PLANES);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 684b66dc9771..b3d6279cbc15 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -53,6 +53,8 @@ struct dc_dmub_srv {
 	bool idle_allowed;
 	bool needs_idle_wake;
 	bool cursor_offload_enabled;
+	bool disable_timeout;
+	bool enable_dmu_recovery;
 };
 
 bool dc_dmub_srv_wait_for_pending(struct dc_dmub_srv *dc_dmub_srv);
@@ -198,9 +200,28 @@ bool dc_wake_and_execute_dmub_cmd_list(const struct dc_context *ctx, unsigned in
 bool dc_wake_and_execute_gpint(const struct dc_context *ctx, enum dmub_gpint_command command_code,
 			       uint16_t param, uint32_t *response, enum dm_dmub_wait_type wait_type);
 
-void dc_dmub_srv_fams2_update_config(struct dc *dc,
-		struct dc_state *context,
-		bool enable);
+/**
+ * struct dc_dmub_fams2_config_data - Inputs of the FAMS2 config command.
+ *
+ * Filled by the caller from dc and dc_state, so that
+ * dc_dmub_srv_fams2_update_config() needs neither of them.
+ * Note: The stream arrays point into dc_state to keep union block_sequence_params
+ * small; dc_state must outlive the command.
+ */
+struct dc_dmub_fams2_config_data {
+	unsigned int fams_version_major;
+	union dmub_fams2_global_feature_config features;
+	bool imm_restore_drr;
+	bool visual_confirm;
+	bool enable;
+	struct dmub_cmd_fams2_global_config global;
+	const union dmub_cmd_fams2_config *stream_base;
+	const union dmub_cmd_fams2_config *stream_sub;
+	const union dmub_fams2_stream_static_sub_state_v2 *stream_sub_v2;
+};
+
+void dc_dmub_srv_fams2_update_config(struct dc_dmub_srv *dc_dmub_srv,
+		const struct dc_dmub_fams2_config_data *data);
 void dc_dmub_srv_fams2_drr_update(struct dc *dc,
 		uint32_t tg_inst,
 		uint32_t vtotal_min,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 09692fc817f9..508749496826 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1464,8 +1464,11 @@ void dcn401_prepare_bandwidth(struct dc *dc,
 	}
 
 	if (dc->debug.fams2_config.bits.enable) {
+		struct dc_dmub_fams2_config_data fams2_data;
+
 		dcn401_dmub_hw_control_lock(dc, context, true);
-		dcn401_fams2_update_config(dc, context, false);
+		if (dcn401_fams2_build_update_config(dc, context, false, &fams2_data))
+			dc_dmub_srv_fams2_update_config(dc->ctx->dmub_srv, &fams2_data);
 		dcn401_dmub_hw_control_lock(dc, context, false);
 	}
 
@@ -1518,9 +1521,9 @@ void dcn401_prepare_bandwidth_sequence(struct dc *dc,
 	}
 
 	if (dc->debug.fams2_config.bits.enable) {
-		dcn401_dmub_hw_control_lock(dc, context, true);
-		dcn401_fams2_update_config(dc, context, false);
-		dcn401_dmub_hw_control_lock(dc, context, false);
+		hwss_add_dmub_hw_control_lock_fast(seq_state, dc, true);
+		hwss_add_dmub_fams2_update_config(seq_state, dc, context, false);
+		hwss_add_dmub_hw_control_lock_fast(seq_state, dc, false);
 	}
 
 	if (p_state_change_support != context->bw_ctx.bw.dcn.clk.p_state_change_support)
@@ -1536,8 +1539,11 @@ void dcn401_optimize_bandwidth(
 
 	/* enable fams2 if needed */
 	if (dc->debug.fams2_config.bits.enable) {
+		struct dc_dmub_fams2_config_data fams2_data;
+
 		dcn401_dmub_hw_control_lock(dc, context, true);
-		dcn401_fams2_update_config(dc, context, true);
+		if (dcn401_fams2_build_update_config(dc, context, true, &fams2_data))
+			dc_dmub_srv_fams2_update_config(dc->ctx->dmub_srv, &fams2_data);
 		dcn401_dmub_hw_control_lock(dc, context, false);
 	}
 
@@ -1594,9 +1600,9 @@ void dcn401_optimize_bandwidth_sequence(struct dc *dc,
 
 	/* enable fams2 if needed */
 	if (dc->debug.fams2_config.bits.enable) {
-		dcn401_dmub_hw_control_lock(dc, context, true);
-		dcn401_fams2_update_config(dc, context, true);
-		dcn401_dmub_hw_control_lock(dc, context, false);
+		hwss_add_dmub_hw_control_lock_fast(seq_state, dc, true);
+		hwss_add_dmub_fams2_update_config(seq_state, dc, context, true);
+		hwss_add_dmub_hw_control_lock_fast(seq_state, dc, false);
 	}
 
 	hwss_add_hubbub_program_watermarks(seq_state, dc, hubbub,
@@ -1653,20 +1659,34 @@ bool dcn401_is_dmub_hw_lock_supported(const struct dc *dc)
 	return dc && dc->ctx && dc->ctx->dmub_srv && dc->ctx->dmub_srv->dmub;
 }
 
-void dcn401_fams2_update_config(struct dc *dc, struct dc_state *context, bool enable)
+/* Returns false when there is nothing to send. */
+bool dcn401_fams2_build_update_config(struct dc *dc, struct dc_state *context, bool enable,
+		struct dc_dmub_fams2_config_data *data)
 {
-	bool fams2_info_required;
-	bool fams2_enabled;
-	bool fams2_legacy_no_fams2;
+	memset(data, 0, sizeof(*data));
 
 	if (!dc->ctx || !dc->ctx->dmub_srv || !dc->debug.fams2_config.bits.enable)
-		return;
+		return false;
+
+	data->fams_version_major = dc->debug.fams_version.major;
+	data->features = dc->debug.fams2_config;
+	data->imm_restore_drr = dc->debug.fams2_imm_restore_drr;
+	data->visual_confirm = dc->debug.visual_confirm == VISUAL_CONFIRM_FAMS2;
+
+	if (context) {
+		const struct dmub_cmd_fams2_global_config *global =
+			&context->bw_ctx.bw.dcn.fams2_global_config;
+		bool fams2_info_required = global->features.bits.enable != 0u ||
+				global->features.bits.legacy_method_no_fams2 != 0u;
 
-	fams2_enabled = context->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable != 0u;
-	fams2_legacy_no_fams2 = context->bw_ctx.bw.dcn.fams2_global_config.features.bits.legacy_method_no_fams2 != 0u;
-	fams2_info_required = fams2_enabled || fams2_legacy_no_fams2;
+		data->global = *global;
+		data->stream_base = context->bw_ctx.bw.dcn.fams2_stream_base_params;
+		data->stream_sub = context->bw_ctx.bw.dcn.fams2_stream_sub_params;
+		data->stream_sub_v2 = context->bw_ctx.bw.dcn.fams2_stream_sub_params_v2;
+		data->enable = enable && fams2_info_required;
+	}
 
-	dc_dmub_srv_fams2_update_config(dc, context, enable && fams2_info_required);
+	return true;
 }
 
 static void update_dsc_for_odm_change(struct dc *dc, struct dc_state *context,
@@ -1915,9 +1935,11 @@ void dcn401_unblank_stream(struct pipe_ctx *pipe_ctx,
 
 void dcn401_hardware_release(struct dc *dc)
 {
+	struct dc_dmub_fams2_config_data fams2_data;
+
 	if (!dc->debug.disable_force_pstate_allow_on_hw_release) {
-		if (dc->ctx->dmub_srv && dc->debug.fams2_config.bits.enable)
-			dc_dmub_srv_fams2_update_config(dc, dc->current_state, false);
+		if (dcn401_fams2_build_update_config(dc, dc->current_state, false, &fams2_data))
+			dc_dmub_srv_fams2_update_config(dc->ctx->dmub_srv, &fams2_data);
 
 		/* If pstate unsupported, or still supported
 		* by firmware, force it supported by dcn
@@ -1938,8 +1960,8 @@ void dcn401_hardware_release(struct dc *dc)
 			dc->clk_mgr->funcs->update_clocks(dc->clk_mgr, dc->current_state, true);
 		}
 
-		if (dc->ctx->dmub_srv && dc->debug.fams2_config.bits.enable)
-			dc_dmub_srv_fams2_update_config(dc, dc->current_state, false);
+		if (dcn401_fams2_build_update_config(dc, dc->current_state, false, &fams2_data))
+			dc_dmub_srv_fams2_update_config(dc->ctx->dmub_srv, &fams2_data);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index d5853cd01a93..fef0dd59a81f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -13,6 +13,7 @@
 #include "dcn401/dcn401_dccg.h"
 
 struct dc;
+struct dc_dmub_fams2_config_data;
 
 enum ips_ono_state {
 	ONO_ON = 0,
@@ -89,7 +90,8 @@ void dcn401_optimize_bandwidth_sequence(struct dc *dc,
 bool dcn401_dmub_hw_control_lock(struct dc *dc,
 		struct dc_state *context,
 		bool lock);
-void dcn401_fams2_update_config(struct dc *dc, struct dc_state *context, bool enable);
+bool dcn401_fams2_build_update_config(struct dc *dc, struct dc_state *context, bool enable,
+		struct dc_dmub_fams2_config_data *data);
 bool dcn401_is_dmub_hw_lock_supported(const struct dc *dc);
 void dcn401_unblank_stream(struct pipe_ctx *pipe_ctx, struct dc_link_settings *link_settings);
 void dcn401_hardware_release(struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index dbeda44ebc8e..1e79b4945801 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -110,7 +110,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.wait_for_dcc_meta_propagation = dcn401_wait_for_dcc_meta_propagation,
 	.is_pipe_topology_transition_seamless = dcn32_is_pipe_topology_transition_seamless,
 	.dmub_hw_control_lock = dcn401_dmub_hw_control_lock,
-	.fams2_update_config = dcn401_fams2_update_config,
+	.fams2_build_update_config = dcn401_fams2_build_update_config,
 	.is_dmub_hw_lock_supported = dcn401_is_dmub_hw_lock_supported,
 	.program_outstanding_updates = dcn401_program_outstanding_updates,
 	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
index 6711283afcd7..00fcb2559247 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
@@ -110,7 +110,7 @@ static const struct hw_sequencer_funcs dcn42_funcs = {
 	.wait_for_dcc_meta_propagation = dcn401_wait_for_dcc_meta_propagation,
 	.is_pipe_topology_transition_seamless = dcn32_is_pipe_topology_transition_seamless,
 	.dmub_hw_control_lock = dcn42_dmub_hw_control_lock,
-	.fams2_update_config = dcn401_fams2_update_config,
+	.fams2_build_update_config = dcn401_fams2_build_update_config,
 	.is_dmub_hw_lock_supported = dcn42_is_dmub_hw_lock_supported,
 	.program_outstanding_updates = dcn401_program_outstanding_updates,
 	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
index 80125c3596ce..9fde7d1be3e5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
@@ -112,7 +112,7 @@ static const struct hw_sequencer_funcs dcn60_funcs = {
 	.wait_for_dcc_meta_propagation = dcn401_wait_for_dcc_meta_propagation,
 	.is_pipe_topology_transition_seamless = dcn32_is_pipe_topology_transition_seamless,
 	.dmub_hw_control_lock = dcn401_dmub_hw_control_lock,
-	.fams2_update_config = dcn401_fams2_update_config,
+	.fams2_build_update_config = dcn401_fams2_build_update_config,
 	.is_dmub_hw_lock_supported = dcn401_is_dmub_hw_lock_supported,
 	.program_outstanding_updates = dcn401_program_outstanding_updates,
 	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index e8ffae05add8..6580d13d9041 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -36,6 +36,7 @@
 #include "dsc/dsc.h"
 #include "link_service_types.h"
 #include "dmub/inc/dmub_cmd.h"
+#include "dc_dmub_srv.h"
 
 struct pipe_ctx;
 struct dc_state;
@@ -359,6 +360,11 @@ struct dmub_hw_control_lock_fast_params {
 	union dmub_inbox0_cmd_lock_hw command;
 };
 
+struct dmub_fams2_update_config_params {
+	struct dc_dmub_srv *dmub_srv;
+	struct dc_dmub_fams2_config_data data;
+};
+
 struct program_surface_config_params {
 	struct hubp *hubp;
 	enum surface_pixel_format format;
@@ -1214,6 +1220,7 @@ union block_sequence_params {
 	struct subvp_save_surf_addr subvp_save_surf_addr;
 	struct wait_for_dcc_meta_propagation_params wait_for_dcc_meta_propagation_params;
 	struct dmub_hw_control_lock_fast_params dmub_hw_control_lock_fast_params;
+	struct dmub_fams2_update_config_params dmub_fams2_update_config_params;
 	struct program_surface_config_params program_surface_config_params;
 	struct program_mcache_id_and_split_coordinate program_mcache_id_and_split_coordinate;
 	struct control_cm_hist_params control_cm_hist_params;
@@ -1596,6 +1603,7 @@ enum block_sequence_func {
 	HUBBUB_INIT_CRB,
 	HUBBUB_SET_REQUEST_LIMIT,
 	BIOS_IS_ACCELERATED_MODE,
+	DMUB_FAMS2_UPDATE_CONFIG,
 	/* This must be the last value in this enum, add new ones above */
 	HWSS_BLOCK_SEQUENCE_FUNC_COUNT
 };
@@ -1907,9 +1915,10 @@ struct hw_sequencer_funcs {
 	bool (*dmub_hw_control_lock)(struct dc *dc,
 			struct dc_state *context,
 			bool lock);
-	void (*fams2_update_config)(struct dc *dc,
+	bool (*fams2_build_update_config)(struct dc *dc,
 			struct dc_state *context,
-			bool enable);
+			bool enable,
+			struct dc_dmub_fams2_config_data *data);
 	bool (*is_dmub_hw_lock_supported)(const struct dc *dc);
 	void (*set_long_vtotal)(struct pipe_ctx **pipe_ctx, int num_pipes, uint32_t v_total_min, uint32_t v_total_max);
 	void (*program_outstanding_updates)(struct dc *dc,
@@ -3025,4 +3034,8 @@ void hwss_dmub_hw_control_lock_fast(union block_sequence_params *params);
 void hwss_add_dmub_hw_control_lock_fast(struct block_sequence_state *seq_state,
 		struct dc *dc, bool lock);
 
+void hwss_dmub_fams2_update_config(union block_sequence_params *params);
+void hwss_add_dmub_fams2_update_config(struct block_sequence_state *seq_state,
+		struct dc *dc, struct dc_state *context, bool enable);
+
 #endif /* __DC_HW_SEQUENCER_H__ */
-- 
2.53.0

