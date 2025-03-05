Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E858C282D9
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F14B10E11F;
	Wed,  5 Mar 2025 05:14:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tMO+KUGW";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0743910E11F
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAo0rVzdrOpc6pSqjhT6VeNuj4S3EtUbqV44PrBmTkxgQ63c6xQAAsb9ZMzzqrhfumHrmdtgNAirORANDa9X/dFPemGAbhLrHqL95vLJrNYkF4MBVI8QQzAi+qL0sH8T2dB108pOTZWaYx3ggNfqZlSM0OmUQUi/nycDwP/+QOXKF/tqbDnQp7Fa9bZ6k1U5njtEdVT6WyYY508Oy6cAzDWPagg39m/UCmTZQhV1gvCLlPvOVLkY2LQVq2N7bqUtwE4Qkiw5VWN5hOFiJ8sHJ0JNwONA8clbQ37GF1GWgjDgxIS2mdhr5/EkKbSxSUSg+/21pNcz0VYUSAomToh3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6W8h1LHpVmtXJEqmn7YhdDqH60pkx+G96W813DqxR8M=;
 b=gDyA5Hf5ytGc+DFbk7maj89Vmj1pQlcJv/0VdD3aCouhD2UfWrS69/au3szptaQW+YeYgbeIUhJSPz8IeYP7NPdFYE7ci8wRsP8x/D4xOisoQJpIrPUQeLCj6wonUeyZhijNKBfT7t+9vWd+meDVmRRUJabCmZLaW/Tk+rRhLYR95uiyYg6rWloBL/4jIkKp+h6DjFYdoV46QzS1MYM0cjzTIu5UIpFTpQ0VQDCiz6sC5RPq6shBsyRxDPIYVztAc35wCtmOoglT6xotZMGioyKKoHug8xkUNRQ3L2hWu+DhUmy2F/qkDq8kXjBr8M3bzilmN75qyvGtW0l1eJHMbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6W8h1LHpVmtXJEqmn7YhdDqH60pkx+G96W813DqxR8M=;
 b=tMO+KUGWGQ/qr+3yByWvy3GI4CcLkdkCwAlcn8pkL44p3dp9WNMGqq/jzueF+xBeJO4hFsKufZLFzd0AvGn+s7nAHYntV7bKTEEC7zwSm7EiyOutXWybjVLlNMbY3rIL4aJUuJ9LgvFDvIXd5cgYfn0UarGoTIvgC1L8tt9vZLI=
Received: from BN9PR03CA0060.namprd03.prod.outlook.com (2603:10b6:408:fb::35)
 by SA0PR12MB7092.namprd12.prod.outlook.com (2603:10b6:806:2d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 05:14:48 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:408:fb:cafe::9b) by BN9PR03CA0060.outlook.office365.com
 (2603:10b6:408:fb::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Wed,
 5 Mar 2025 05:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:14:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:14:47 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:14:43 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 03/22] drm/amd/display: Add more debug data to dmub_srv
Date: Wed, 5 Mar 2025 13:13:43 +0800
Message-ID: <20250305051402.1550046-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|SA0PR12MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3d8b50-d2a1-4e59-4d14-08dd5ba4a66f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mo6k1E6t6NiqlgQ2KTOuQ6vK58vd5IZM6LjqU0qBL6J6xSjm2iL+zHJdYwRS?=
 =?us-ascii?Q?BkofaB2Fj1jCFtZrQk72wIbbRhd/M650RWatCQ0JTvW+ZwTIzoGUCDl+lH+I?=
 =?us-ascii?Q?vUPpqdiQL8ubAwlg0Hkxdxae1yXrg99+nNymD+eF9V1JdZj0lWvS+vq+L/tv?=
 =?us-ascii?Q?0ImxXqUdVHxv5kHc/eZNa5XEkEPoLKsuU2APE97D4u8tkeI1cKBCX1rAqDmU?=
 =?us-ascii?Q?uCR28B2ZqHcaHE0AhRtQYlcegm6Lt6A4Dbdibf76/VNxYvWiCKKlj64kSqzA?=
 =?us-ascii?Q?abJHhMKx5v6y/dLeQrEmRVX6yMAszpohpCVEpZ117BNHCIgq6xwiE8+/EJD3?=
 =?us-ascii?Q?B/kbRk74M9ApLOG6XWHape9mzFOckJgMdcuTGSWlpoP9gUZcF6QgKndpJFYD?=
 =?us-ascii?Q?jSHHKxvd8rvDFDKczP2NvcODD00QH2I8iKUcVbKJaBkS0BemwkRZ95WkEkWy?=
 =?us-ascii?Q?9ZzpuliyPUVr52P25DuZ/WTT0hUwLR1kX4g0z7+IjS0RujjyQTjEjiSkh5OM?=
 =?us-ascii?Q?zSobfjUNDrRNfrdpNQm6g0LiY+UtgPSMiENo9U/VJtVMQwiUVuyGDTWrGufV?=
 =?us-ascii?Q?tyZq5vvH5RIbOZLwG2/u6Dyuv1VqaoBJ3Zdwi7Yo4vD7W0mN5zaWYSx/xMyd?=
 =?us-ascii?Q?Hd6GE0/aRQYcrqqsQ0eFG9IRPWqLgiyaNJ02DBXgKNLr3Rm2lO08I6GlIvtm?=
 =?us-ascii?Q?ut1usLunsFAtNZHQdossm5tPxFu3dhL4Ys2Hd8ktqwkG6RSIhUMpcTdTIaga?=
 =?us-ascii?Q?GBbhyJQuhMUFxn8PaWXlLX27oHZu+ccURaGs+2tE1IiGxyuRtGCs3BeWMdlN?=
 =?us-ascii?Q?U22g8ybtiAmbz9vnPalwamnyVkkcZ4VdMdG74Bma4CGuOXUJenTh4GOzq/Ls?=
 =?us-ascii?Q?oJOPAmyiOlCpdxwPI9gdXXkTQQZYmRWmCoImpMWx3jBeHTbgMaAadZEC3MuE?=
 =?us-ascii?Q?TIyxtxwDJKdvbulV77i22mHAJNM6PDTa5P7iThsbgMyBqjF+5U8mKUVZiJ76?=
 =?us-ascii?Q?34ECBVKN3bZNL9FVcR2HchNAaJiIi34gviSAhLvqI3jAQupcCmhBjq6CFAud?=
 =?us-ascii?Q?MrIMfcNqrXaUT9TNKX+X9vBa0q8I13G7nttgLGiSnhm/qFPOaLcJsX9hbMI6?=
 =?us-ascii?Q?lsxExXvqo563NJd2v7IyHM8nobdRvw9ZQBW4U2+D2iWVhhUrz++kaoaQZInq?=
 =?us-ascii?Q?oL7ZovyJku1kiwWlzxZuz9YHSZu8pzwvZjz22v1S2Rn2wOhGwLYjyrCrrZ0q?=
 =?us-ascii?Q?W7g7V0ak2IecPofLpT5KaSSY8JgSpfI8mRudF0qnUQLYcKs6fDijmYvNasoj?=
 =?us-ascii?Q?g9xRShn4oB3yppsVDNMO4D48/eluSKVLljKeM7piwzy3iOQj1r+OIspYKnj3?=
 =?us-ascii?Q?t4DmSPKki8XsFtBuSdGyV8uQelzpTqzvfYKmiPCkqi1IkjKiV3cJ7prA66j/?=
 =?us-ascii?Q?ckfUod8vTTGkOvHj2pH0768lYRna/B5/Xib+FGkgKa8KvD7F3LT7vDbePHUT?=
 =?us-ascii?Q?obmosGYfjTfA/oA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:14:48.1085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3d8b50-d2a1-4e59-4d14-08dd5ba4a66f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7092
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
When analyzing some crash dumps, not all of the expected DMUB info was
available, so we want to add in-object storage for this data.

[How]
 - dmub_srv_debug (renamed to dmub_timeout_info) is already a member of
dmub_diagnostic_data, therefore keep a dmub_diagnostic_data directly in
dmub_srv
 - use dmub_srv->debug when collecting diagnostic info instead of stack
object to allow for easy inspection in crash dumps

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 89 +++++++++--------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 10 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 85 ++++++++--------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |  2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 93 +++++++++---------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |  2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c | 98 ++++++++++---------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.h |  2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c | 93 +++++++++---------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.h |  2 +-
 .../drm/amd/display/dmub/src/dmub_dcn401.c    | 97 +++++++++---------
 .../drm/amd/display/dmub/src/dmub_dcn401.h    |  2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  6 +-
 14 files changed, 298 insertions(+), 285 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 87b4c2793df3..614e03bfd598 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -200,10 +200,10 @@ bool dc_dmub_srv_wait_for_idle(struct dc_dmub_srv *dc_dmub_srv,
 
 		if (status != DMUB_STATUS_OK) {
 			DC_LOG_DEBUG("No reply for DMUB command: status=%d\n", status);
-			if (!dmub->debug.timeout_occured) {
-				dmub->debug.timeout_occured = true;
-				dmub->debug.timeout_cmd = *cmd_list;
-				dmub->debug.timestamp = dm_get_timestamp(dc_dmub_srv->ctx);
+			if (!dmub->debug.timeout_info.timeout_occured) {
+				dmub->debug.timeout_info.timeout_occured = true;
+				dmub->debug.timeout_info.timeout_cmd = *cmd_list;
+				dmub->debug.timeout_info.timestamp = dm_get_timestamp(dc_dmub_srv->ctx);
 			}
 			dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
 			return false;
@@ -927,16 +927,15 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
 	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
 
-bool dc_dmub_srv_get_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv, struct dmub_diagnostic_data *diag_data)
+bool dc_dmub_srv_get_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
 {
-	if (!dc_dmub_srv || !dc_dmub_srv->dmub || !diag_data)
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
 		return false;
-	return dmub_srv_get_diagnostic_data(dc_dmub_srv->dmub, diag_data);
+	return dmub_srv_get_diagnostic_data(dc_dmub_srv->dmub);
 }
 
 void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
 {
-	struct dmub_diagnostic_data diag_data = {0};
 	uint32_t i;
 
 	if (!dc_dmub_srv || !dc_dmub_srv->dmub) {
@@ -946,49 +945,49 @@ void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
 
 	DC_LOG_ERROR("%s: DMCUB error - collecting diagnostic data\n", __func__);
 
-	if (!dc_dmub_srv_get_diagnostic_data(dc_dmub_srv, &diag_data)) {
+	if (!dc_dmub_srv_get_diagnostic_data(dc_dmub_srv)) {
 		DC_LOG_ERROR("%s: dc_dmub_srv_get_diagnostic_data failed.", __func__);
 		return;
 	}
 
 	DC_LOG_DEBUG("DMCUB STATE:");
-	DC_LOG_DEBUG("    dmcub_version      : %08x", diag_data.dmcub_version);
-	DC_LOG_DEBUG("    scratch  [0]       : %08x", diag_data.scratch[0]);
-	DC_LOG_DEBUG("    scratch  [1]       : %08x", diag_data.scratch[1]);
-	DC_LOG_DEBUG("    scratch  [2]       : %08x", diag_data.scratch[2]);
-	DC_LOG_DEBUG("    scratch  [3]       : %08x", diag_data.scratch[3]);
-	DC_LOG_DEBUG("    scratch  [4]       : %08x", diag_data.scratch[4]);
-	DC_LOG_DEBUG("    scratch  [5]       : %08x", diag_data.scratch[5]);
-	DC_LOG_DEBUG("    scratch  [6]       : %08x", diag_data.scratch[6]);
-	DC_LOG_DEBUG("    scratch  [7]       : %08x", diag_data.scratch[7]);
-	DC_LOG_DEBUG("    scratch  [8]       : %08x", diag_data.scratch[8]);
-	DC_LOG_DEBUG("    scratch  [9]       : %08x", diag_data.scratch[9]);
-	DC_LOG_DEBUG("    scratch [10]       : %08x", diag_data.scratch[10]);
-	DC_LOG_DEBUG("    scratch [11]       : %08x", diag_data.scratch[11]);
-	DC_LOG_DEBUG("    scratch [12]       : %08x", diag_data.scratch[12]);
-	DC_LOG_DEBUG("    scratch [13]       : %08x", diag_data.scratch[13]);
-	DC_LOG_DEBUG("    scratch [14]       : %08x", diag_data.scratch[14]);
-	DC_LOG_DEBUG("    scratch [15]       : %08x", diag_data.scratch[15]);
+	DC_LOG_DEBUG("    dmcub_version      : %08x", dc_dmub_srv->dmub->debug.dmcub_version);
+	DC_LOG_DEBUG("    scratch  [0]       : %08x", dc_dmub_srv->dmub->debug.scratch[0]);
+	DC_LOG_DEBUG("    scratch  [1]       : %08x", dc_dmub_srv->dmub->debug.scratch[1]);
+	DC_LOG_DEBUG("    scratch  [2]       : %08x", dc_dmub_srv->dmub->debug.scratch[2]);
+	DC_LOG_DEBUG("    scratch  [3]       : %08x", dc_dmub_srv->dmub->debug.scratch[3]);
+	DC_LOG_DEBUG("    scratch  [4]       : %08x", dc_dmub_srv->dmub->debug.scratch[4]);
+	DC_LOG_DEBUG("    scratch  [5]       : %08x", dc_dmub_srv->dmub->debug.scratch[5]);
+	DC_LOG_DEBUG("    scratch  [6]       : %08x", dc_dmub_srv->dmub->debug.scratch[6]);
+	DC_LOG_DEBUG("    scratch  [7]       : %08x", dc_dmub_srv->dmub->debug.scratch[7]);
+	DC_LOG_DEBUG("    scratch  [8]       : %08x", dc_dmub_srv->dmub->debug.scratch[8]);
+	DC_LOG_DEBUG("    scratch  [9]       : %08x", dc_dmub_srv->dmub->debug.scratch[9]);
+	DC_LOG_DEBUG("    scratch [10]       : %08x", dc_dmub_srv->dmub->debug.scratch[10]);
+	DC_LOG_DEBUG("    scratch [11]       : %08x", dc_dmub_srv->dmub->debug.scratch[11]);
+	DC_LOG_DEBUG("    scratch [12]       : %08x", dc_dmub_srv->dmub->debug.scratch[12]);
+	DC_LOG_DEBUG("    scratch [13]       : %08x", dc_dmub_srv->dmub->debug.scratch[13]);
+	DC_LOG_DEBUG("    scratch [14]       : %08x", dc_dmub_srv->dmub->debug.scratch[14]);
+	DC_LOG_DEBUG("    scratch [15]       : %08x", dc_dmub_srv->dmub->debug.scratch[15]);
 	for (i = 0; i < DMUB_PC_SNAPSHOT_COUNT; i++)
-		DC_LOG_DEBUG("    pc[%d]             : %08x", i, diag_data.pc[i]);
-	DC_LOG_DEBUG("    unk_fault_addr     : %08x", diag_data.undefined_address_fault_addr);
-	DC_LOG_DEBUG("    inst_fault_addr    : %08x", diag_data.inst_fetch_fault_addr);
-	DC_LOG_DEBUG("    data_fault_addr    : %08x", diag_data.data_write_fault_addr);
-	DC_LOG_DEBUG("    inbox1_rptr        : %08x", diag_data.inbox1_rptr);
-	DC_LOG_DEBUG("    inbox1_wptr        : %08x", diag_data.inbox1_wptr);
-	DC_LOG_DEBUG("    inbox1_size        : %08x", diag_data.inbox1_size);
-	DC_LOG_DEBUG("    inbox0_rptr        : %08x", diag_data.inbox0_rptr);
-	DC_LOG_DEBUG("    inbox0_wptr        : %08x", diag_data.inbox0_wptr);
-	DC_LOG_DEBUG("    inbox0_size        : %08x", diag_data.inbox0_size);
-	DC_LOG_DEBUG("    outbox1_rptr       : %08x", diag_data.outbox1_rptr);
-	DC_LOG_DEBUG("    outbox1_wptr       : %08x", diag_data.outbox1_wptr);
-	DC_LOG_DEBUG("    outbox1_size       : %08x", diag_data.outbox1_size);
-	DC_LOG_DEBUG("    is_enabled         : %d", diag_data.is_dmcub_enabled);
-	DC_LOG_DEBUG("    is_soft_reset      : %d", diag_data.is_dmcub_soft_reset);
-	DC_LOG_DEBUG("    is_secure_reset    : %d", diag_data.is_dmcub_secure_reset);
-	DC_LOG_DEBUG("    is_traceport_en    : %d", diag_data.is_traceport_en);
-	DC_LOG_DEBUG("    is_cw0_en          : %d", diag_data.is_cw0_enabled);
-	DC_LOG_DEBUG("    is_cw6_en          : %d", diag_data.is_cw6_enabled);
+		DC_LOG_DEBUG("    pc[%d]             : %08x", i, dc_dmub_srv->dmub->debug.pc[i]);
+	DC_LOG_DEBUG("    unk_fault_addr     : %08x", dc_dmub_srv->dmub->debug.undefined_address_fault_addr);
+	DC_LOG_DEBUG("    inst_fault_addr    : %08x", dc_dmub_srv->dmub->debug.inst_fetch_fault_addr);
+	DC_LOG_DEBUG("    data_fault_addr    : %08x", dc_dmub_srv->dmub->debug.data_write_fault_addr);
+	DC_LOG_DEBUG("    inbox1_rptr        : %08x", dc_dmub_srv->dmub->debug.inbox1_rptr);
+	DC_LOG_DEBUG("    inbox1_wptr        : %08x", dc_dmub_srv->dmub->debug.inbox1_wptr);
+	DC_LOG_DEBUG("    inbox1_size        : %08x", dc_dmub_srv->dmub->debug.inbox1_size);
+	DC_LOG_DEBUG("    inbox0_rptr        : %08x", dc_dmub_srv->dmub->debug.inbox0_rptr);
+	DC_LOG_DEBUG("    inbox0_wptr        : %08x", dc_dmub_srv->dmub->debug.inbox0_wptr);
+	DC_LOG_DEBUG("    inbox0_size        : %08x", dc_dmub_srv->dmub->debug.inbox0_size);
+	DC_LOG_DEBUG("    outbox1_rptr       : %08x", dc_dmub_srv->dmub->debug.outbox1_rptr);
+	DC_LOG_DEBUG("    outbox1_wptr       : %08x", dc_dmub_srv->dmub->debug.outbox1_wptr);
+	DC_LOG_DEBUG("    outbox1_size       : %08x", dc_dmub_srv->dmub->debug.outbox1_size);
+	DC_LOG_DEBUG("    is_enabled         : %d", dc_dmub_srv->dmub->debug.is_dmcub_enabled);
+	DC_LOG_DEBUG("    is_soft_reset      : %d", dc_dmub_srv->dmub->debug.is_dmcub_soft_reset);
+	DC_LOG_DEBUG("    is_secure_reset    : %d", dc_dmub_srv->dmub->debug.is_dmcub_secure_reset);
+	DC_LOG_DEBUG("    is_traceport_en    : %d", dc_dmub_srv->dmub->debug.is_traceport_en);
+	DC_LOG_DEBUG("    is_cw0_en          : %d", dc_dmub_srv->dmub->debug.is_cw0_enabled);
+	DC_LOG_DEBUG("    is_cw6_en          : %d", dc_dmub_srv->dmub->debug.is_cw6_enabled);
 }
 
 static bool dc_dmub_should_update_cursor_data(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 10b48198b7a6..a636f4c3f01d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -94,7 +94,7 @@ void dc_dmub_srv_clear_inbox0_ack(struct dc_dmub_srv *dmub_srv);
 void dc_dmub_srv_wait_for_inbox0_ack(struct dc_dmub_srv *dmub_srv);
 void dc_dmub_srv_send_inbox0_cmd(struct dc_dmub_srv *dmub_srv, union dmub_inbox0_data_register data);
 
-bool dc_dmub_srv_get_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv, struct dmub_diagnostic_data *dmub_oca);
+bool dc_dmub_srv_get_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv);
 
 void dc_dmub_setup_subvp_dmub_command(struct dc *dc, struct dc_state *context, bool enable);
 void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv);
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 0787cc3904d6..8ebeb34021e5 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -313,7 +313,7 @@ struct dmub_srv_hw_params {
  * @timeout_occured: Indicates a timeout occured on any message from driver to dmub
  * @timeout_cmd: first cmd sent from driver that timed out - subsequent timeouts are not stored
  */
-struct dmub_srv_debug {
+struct dmub_timeout_info {
 	bool timeout_occured;
 	union dmub_rb_cmd timeout_cmd;
 	unsigned long long timestamp;
@@ -340,7 +340,7 @@ struct dmub_diagnostic_data {
 	uint32_t outbox1_wptr;
 	uint32_t outbox1_size;
 	uint32_t gpint_datain0;
-	struct dmub_srv_debug timeout_info;
+	struct dmub_timeout_info timeout_info;
 	uint8_t is_dmcub_enabled : 1;
 	uint8_t is_dmcub_soft_reset : 1;
 	uint8_t is_dmcub_secure_reset : 1;
@@ -456,7 +456,7 @@ struct dmub_srv_hw_funcs {
 	void (*send_inbox0_cmd)(struct dmub_srv *dmub, union dmub_inbox0_data_register data);
 	uint32_t (*get_current_time)(struct dmub_srv *dmub);
 
-	void (*get_diagnostic_data)(struct dmub_srv *dmub, struct dmub_diagnostic_data *dmub_oca);
+	void (*get_diagnostic_data)(struct dmub_srv *dmub);
 
 	bool (*should_detect)(struct dmub_srv *dmub);
 	void (*init_reg_offsets)(struct dmub_srv *dmub, struct dc_context *ctx);
@@ -545,7 +545,7 @@ struct dmub_srv {
 	struct dmub_visual_confirm_color visual_confirm_color;
 
 	enum dmub_srv_power_state_type power_state;
-	struct dmub_srv_debug debug;
+	struct dmub_diagnostic_data debug;
 };
 
 /**
@@ -901,7 +901,7 @@ enum dmub_status dmub_srv_set_skip_panel_power_sequence(struct dmub_srv *dmub,
 
 bool dmub_srv_get_outbox0_msg(struct dmub_srv *dmub, struct dmcub_trace_buf_entry *entry);
 
-bool dmub_srv_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data);
+bool dmub_srv_get_diagnostic_data(struct dmub_srv *dmub);
 
 bool dmub_srv_should_detect(struct dmub_srv *dmub);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index e500ca9ae09c..73888c1bea93 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -414,63 +414,66 @@ uint32_t dmub_dcn20_get_current_time(struct dmub_srv *dmub)
 	return REG_READ(DMCUB_TIMER_CURRENT);
 }
 
-void dmub_dcn20_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data)
+void dmub_dcn20_get_diagnostic_data(struct dmub_srv *dmub)
 {
 	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset;
 	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
+	struct dmub_timeout_info timeout = {0};
 
-	if (!dmub || !diag_data)
+	if (!dmub)
 		return;
 
-	memset(diag_data, 0, sizeof(*diag_data));
-
-	diag_data->dmcub_version = dmub->fw_version;
-
-	diag_data->scratch[0] = REG_READ(DMCUB_SCRATCH0);
-	diag_data->scratch[1] = REG_READ(DMCUB_SCRATCH1);
-	diag_data->scratch[2] = REG_READ(DMCUB_SCRATCH2);
-	diag_data->scratch[3] = REG_READ(DMCUB_SCRATCH3);
-	diag_data->scratch[4] = REG_READ(DMCUB_SCRATCH4);
-	diag_data->scratch[5] = REG_READ(DMCUB_SCRATCH5);
-	diag_data->scratch[6] = REG_READ(DMCUB_SCRATCH6);
-	diag_data->scratch[7] = REG_READ(DMCUB_SCRATCH7);
-	diag_data->scratch[8] = REG_READ(DMCUB_SCRATCH8);
-	diag_data->scratch[9] = REG_READ(DMCUB_SCRATCH9);
-	diag_data->scratch[10] = REG_READ(DMCUB_SCRATCH10);
-	diag_data->scratch[11] = REG_READ(DMCUB_SCRATCH11);
-	diag_data->scratch[12] = REG_READ(DMCUB_SCRATCH12);
-	diag_data->scratch[13] = REG_READ(DMCUB_SCRATCH13);
-	diag_data->scratch[14] = REG_READ(DMCUB_SCRATCH14);
-	diag_data->scratch[15] = REG_READ(DMCUB_SCRATCH15);
-
-	diag_data->undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
-	diag_data->inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
-	diag_data->data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
-
-	diag_data->inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
-	diag_data->inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
-	diag_data->inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
-
-	diag_data->inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
-	diag_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
-	diag_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
+	/* timeout data filled externally, cache before resetting memory */
+	timeout = dmub->debug.timeout_info;
+	memset(&dmub->debug, 0, sizeof(dmub->debug));
+	dmub->debug.timeout_info = timeout;
+
+	dmub->debug.dmcub_version = dmub->fw_version;
+
+	dmub->debug.scratch[0] = REG_READ(DMCUB_SCRATCH0);
+	dmub->debug.scratch[1] = REG_READ(DMCUB_SCRATCH1);
+	dmub->debug.scratch[2] = REG_READ(DMCUB_SCRATCH2);
+	dmub->debug.scratch[3] = REG_READ(DMCUB_SCRATCH3);
+	dmub->debug.scratch[4] = REG_READ(DMCUB_SCRATCH4);
+	dmub->debug.scratch[5] = REG_READ(DMCUB_SCRATCH5);
+	dmub->debug.scratch[6] = REG_READ(DMCUB_SCRATCH6);
+	dmub->debug.scratch[7] = REG_READ(DMCUB_SCRATCH7);
+	dmub->debug.scratch[8] = REG_READ(DMCUB_SCRATCH8);
+	dmub->debug.scratch[9] = REG_READ(DMCUB_SCRATCH9);
+	dmub->debug.scratch[10] = REG_READ(DMCUB_SCRATCH10);
+	dmub->debug.scratch[11] = REG_READ(DMCUB_SCRATCH11);
+	dmub->debug.scratch[12] = REG_READ(DMCUB_SCRATCH12);
+	dmub->debug.scratch[13] = REG_READ(DMCUB_SCRATCH13);
+	dmub->debug.scratch[14] = REG_READ(DMCUB_SCRATCH14);
+	dmub->debug.scratch[15] = REG_READ(DMCUB_SCRATCH15);
+
+	dmub->debug.undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
+	dmub->debug.inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
+	dmub->debug.data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
+
+	dmub->debug.inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
+	dmub->debug.inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
+	dmub->debug.inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
+
+	dmub->debug.inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
+	dmub->debug.inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
+	dmub->debug.inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
-	diag_data->is_dmcub_enabled = is_dmub_enabled;
+	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_SOFT_RESET, &is_soft_reset);
-	diag_data->is_dmcub_soft_reset = is_soft_reset;
+	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
 
 	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
-	diag_data->is_dmcub_secure_reset = is_sec_reset;
+	dmub->debug.is_dmcub_secure_reset = is_sec_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
-	diag_data->is_traceport_en  = is_traceport_enabled;
+	dmub->debug.is_traceport_en  = is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
-	diag_data->is_cw0_enabled = is_cw0_enabled;
+	dmub->debug.is_cw0_enabled = is_cw0_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
-	diag_data->is_cw6_enabled = is_cw6_enabled;
-	diag_data->timeout_info = dmub->debug;
+	dmub->debug.is_cw6_enabled = is_cw6_enabled;
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
index de287b101848..42c1fb4bc73f 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
@@ -247,6 +247,6 @@ bool dmub_dcn20_use_cached_trace_buffer(struct dmub_srv *dmub);
 
 uint32_t dmub_dcn20_get_current_time(struct dmub_srv *dmub);
 
-void dmub_dcn20_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *dmub_oca);
+void dmub_dcn20_get_diagnostic_data(struct dmub_srv *dmub);
 
 #endif /* _DMUB_DCN20_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 9796077885c9..a308bd604677 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -414,69 +414,72 @@ uint32_t dmub_dcn31_get_current_time(struct dmub_srv *dmub)
 	return REG_READ(DMCUB_TIMER_CURRENT);
 }
 
-void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data)
+void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub)
 {
 	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset;
 	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
+	struct dmub_timeout_info timeout = {0};
 
-	if (!dmub || !diag_data)
+	if (!dmub)
 		return;
 
-	memset(diag_data, 0, sizeof(*diag_data));
-
-	diag_data->dmcub_version = dmub->fw_version;
-
-	diag_data->scratch[0] = REG_READ(DMCUB_SCRATCH0);
-	diag_data->scratch[1] = REG_READ(DMCUB_SCRATCH1);
-	diag_data->scratch[2] = REG_READ(DMCUB_SCRATCH2);
-	diag_data->scratch[3] = REG_READ(DMCUB_SCRATCH3);
-	diag_data->scratch[4] = REG_READ(DMCUB_SCRATCH4);
-	diag_data->scratch[5] = REG_READ(DMCUB_SCRATCH5);
-	diag_data->scratch[6] = REG_READ(DMCUB_SCRATCH6);
-	diag_data->scratch[7] = REG_READ(DMCUB_SCRATCH7);
-	diag_data->scratch[8] = REG_READ(DMCUB_SCRATCH8);
-	diag_data->scratch[9] = REG_READ(DMCUB_SCRATCH9);
-	diag_data->scratch[10] = REG_READ(DMCUB_SCRATCH10);
-	diag_data->scratch[11] = REG_READ(DMCUB_SCRATCH11);
-	diag_data->scratch[12] = REG_READ(DMCUB_SCRATCH12);
-	diag_data->scratch[13] = REG_READ(DMCUB_SCRATCH13);
-	diag_data->scratch[14] = REG_READ(DMCUB_SCRATCH14);
-	diag_data->scratch[15] = REG_READ(DMCUB_SCRATCH15);
-
-	diag_data->undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
-	diag_data->inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
-	diag_data->data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
-
-	diag_data->inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
-	diag_data->inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
-	diag_data->inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
-
-	diag_data->inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
-	diag_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
-	diag_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
-
-	diag_data->outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
-	diag_data->outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
-	diag_data->outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
+	/* timeout data filled externally, cache before resetting memory */
+	timeout = dmub->debug.timeout_info;
+	memset(&dmub->debug, 0, sizeof(dmub->debug));
+	dmub->debug.timeout_info = timeout;
+
+	dmub->debug.dmcub_version = dmub->fw_version;
+
+	dmub->debug.scratch[0] = REG_READ(DMCUB_SCRATCH0);
+	dmub->debug.scratch[1] = REG_READ(DMCUB_SCRATCH1);
+	dmub->debug.scratch[2] = REG_READ(DMCUB_SCRATCH2);
+	dmub->debug.scratch[3] = REG_READ(DMCUB_SCRATCH3);
+	dmub->debug.scratch[4] = REG_READ(DMCUB_SCRATCH4);
+	dmub->debug.scratch[5] = REG_READ(DMCUB_SCRATCH5);
+	dmub->debug.scratch[6] = REG_READ(DMCUB_SCRATCH6);
+	dmub->debug.scratch[7] = REG_READ(DMCUB_SCRATCH7);
+	dmub->debug.scratch[8] = REG_READ(DMCUB_SCRATCH8);
+	dmub->debug.scratch[9] = REG_READ(DMCUB_SCRATCH9);
+	dmub->debug.scratch[10] = REG_READ(DMCUB_SCRATCH10);
+	dmub->debug.scratch[11] = REG_READ(DMCUB_SCRATCH11);
+	dmub->debug.scratch[12] = REG_READ(DMCUB_SCRATCH12);
+	dmub->debug.scratch[13] = REG_READ(DMCUB_SCRATCH13);
+	dmub->debug.scratch[14] = REG_READ(DMCUB_SCRATCH14);
+	dmub->debug.scratch[15] = REG_READ(DMCUB_SCRATCH15);
+
+	dmub->debug.undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
+	dmub->debug.inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
+	dmub->debug.data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
+
+	dmub->debug.inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
+	dmub->debug.inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
+	dmub->debug.inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
+
+	dmub->debug.inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
+	dmub->debug.inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
+	dmub->debug.inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
+
+	dmub->debug.outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
+	dmub->debug.outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
+	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
-	diag_data->is_dmcub_enabled = is_dmub_enabled;
+	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
-	diag_data->is_dmcub_soft_reset = is_soft_reset;
+	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
 
 	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
-	diag_data->is_dmcub_secure_reset = is_sec_reset;
+	dmub->debug.is_dmcub_secure_reset = is_sec_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
-	diag_data->is_traceport_en  = is_traceport_enabled;
+	dmub->debug.is_traceport_en  = is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
-	diag_data->is_cw0_enabled = is_cw0_enabled;
+	dmub->debug.is_cw0_enabled = is_cw0_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
-	diag_data->is_cw6_enabled = is_cw6_enabled;
-	diag_data->timeout_info = dmub->debug;
+	dmub->debug.is_cw6_enabled = is_cw6_enabled;
 }
 
 bool dmub_dcn31_should_detect(struct dmub_srv *dmub)
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
index eccdab4986ce..1c43ef2bca66 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
@@ -251,7 +251,7 @@ void dmub_dcn31_set_outbox0_rptr(struct dmub_srv *dmub, uint32_t rptr_offset);
 
 uint32_t dmub_dcn31_get_current_time(struct dmub_srv *dmub);
 
-void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data);
+void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub);
 
 bool dmub_dcn31_should_detect(struct dmub_srv *dmub);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index 9600b7f858b0..e7056205b050 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -417,73 +417,75 @@ uint32_t dmub_dcn32_get_current_time(struct dmub_srv *dmub)
 	return REG_READ(DMCUB_TIMER_CURRENT);
 }
 
-void dmub_dcn32_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data)
+void dmub_dcn32_get_diagnostic_data(struct dmub_srv *dmub)
 {
 	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset;
 	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
+	struct dmub_timeout_info timeout = {0};
 
-	if (!dmub || !diag_data)
+	if (!dmub)
 		return;
 
-	memset(diag_data, 0, sizeof(*diag_data));
-
-	diag_data->dmcub_version = dmub->fw_version;
-
-	diag_data->scratch[0] = REG_READ(DMCUB_SCRATCH0);
-	diag_data->scratch[1] = REG_READ(DMCUB_SCRATCH1);
-	diag_data->scratch[2] = REG_READ(DMCUB_SCRATCH2);
-	diag_data->scratch[3] = REG_READ(DMCUB_SCRATCH3);
-	diag_data->scratch[4] = REG_READ(DMCUB_SCRATCH4);
-	diag_data->scratch[5] = REG_READ(DMCUB_SCRATCH5);
-	diag_data->scratch[6] = REG_READ(DMCUB_SCRATCH6);
-	diag_data->scratch[7] = REG_READ(DMCUB_SCRATCH7);
-	diag_data->scratch[8] = REG_READ(DMCUB_SCRATCH8);
-	diag_data->scratch[9] = REG_READ(DMCUB_SCRATCH9);
-	diag_data->scratch[10] = REG_READ(DMCUB_SCRATCH10);
-	diag_data->scratch[11] = REG_READ(DMCUB_SCRATCH11);
-	diag_data->scratch[12] = REG_READ(DMCUB_SCRATCH12);
-	diag_data->scratch[13] = REG_READ(DMCUB_SCRATCH13);
-	diag_data->scratch[14] = REG_READ(DMCUB_SCRATCH14);
-	diag_data->scratch[15] = REG_READ(DMCUB_SCRATCH15);
-	diag_data->scratch[16] = REG_READ(DMCUB_SCRATCH16);
-
-	diag_data->undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
-	diag_data->inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
-	diag_data->data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
-
-	diag_data->inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
-	diag_data->inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
-	diag_data->inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
-
-	diag_data->inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
-	diag_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
-	diag_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
-
-	diag_data->outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
-	diag_data->outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
-	diag_data->outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
+	/* timeout data filled externally, cache before resetting memory */
+	timeout = dmub->debug.timeout_info;
+	memset(&dmub->debug, 0, sizeof(dmub->debug));
+	dmub->debug.timeout_info = timeout;
+
+	dmub->debug.dmcub_version = dmub->fw_version;
+
+	dmub->debug.scratch[0] = REG_READ(DMCUB_SCRATCH0);
+	dmub->debug.scratch[1] = REG_READ(DMCUB_SCRATCH1);
+	dmub->debug.scratch[2] = REG_READ(DMCUB_SCRATCH2);
+	dmub->debug.scratch[3] = REG_READ(DMCUB_SCRATCH3);
+	dmub->debug.scratch[4] = REG_READ(DMCUB_SCRATCH4);
+	dmub->debug.scratch[5] = REG_READ(DMCUB_SCRATCH5);
+	dmub->debug.scratch[6] = REG_READ(DMCUB_SCRATCH6);
+	dmub->debug.scratch[7] = REG_READ(DMCUB_SCRATCH7);
+	dmub->debug.scratch[8] = REG_READ(DMCUB_SCRATCH8);
+	dmub->debug.scratch[9] = REG_READ(DMCUB_SCRATCH9);
+	dmub->debug.scratch[10] = REG_READ(DMCUB_SCRATCH10);
+	dmub->debug.scratch[11] = REG_READ(DMCUB_SCRATCH11);
+	dmub->debug.scratch[12] = REG_READ(DMCUB_SCRATCH12);
+	dmub->debug.scratch[13] = REG_READ(DMCUB_SCRATCH13);
+	dmub->debug.scratch[14] = REG_READ(DMCUB_SCRATCH14);
+	dmub->debug.scratch[15] = REG_READ(DMCUB_SCRATCH15);
+	dmub->debug.scratch[16] = REG_READ(DMCUB_SCRATCH16);
+
+	dmub->debug.undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
+	dmub->debug.inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
+	dmub->debug.data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
+
+	dmub->debug.inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
+	dmub->debug.inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
+	dmub->debug.inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
+
+	dmub->debug.inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
+	dmub->debug.inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
+	dmub->debug.inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
+
+	dmub->debug.outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
+	dmub->debug.outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
+	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
-	diag_data->is_dmcub_enabled = is_dmub_enabled;
+	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
-	diag_data->is_dmcub_soft_reset = is_soft_reset;
+	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
 
 	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
-	diag_data->is_dmcub_secure_reset = is_sec_reset;
+	dmub->debug.is_dmcub_secure_reset = is_sec_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
-	diag_data->is_traceport_en  = is_traceport_enabled;
+	dmub->debug.is_traceport_en  = is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
-	diag_data->is_cw0_enabled = is_cw0_enabled;
+	dmub->debug.is_cw0_enabled = is_cw0_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
-	diag_data->is_cw6_enabled = is_cw6_enabled;
+	dmub->debug.is_cw6_enabled = is_cw6_enabled;
 
-	diag_data->gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
-
-	diag_data->timeout_info = dmub->debug;
+	dmub->debug.gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
 }
 void dmub_dcn32_configure_dmub_in_system_memory(struct dmub_srv *dmub)
 {
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
index 29c1132951af..1a229450c53d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
@@ -254,7 +254,7 @@ void dmub_dcn32_set_outbox0_rptr(struct dmub_srv *dmub, uint32_t rptr_offset);
 
 uint32_t dmub_dcn32_get_current_time(struct dmub_srv *dmub);
 
-void dmub_dcn32_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data);
+void dmub_dcn32_get_diagnostic_data(struct dmub_srv *dmub);
 
 void dmub_dcn32_configure_dmub_in_system_memory(struct dmub_srv *dmub);
 void dmub_dcn32_send_inbox0_cmd(struct dmub_srv *dmub, union dmub_inbox0_data_register data);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 01d013a12b94..72a0f078cd1a 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -462,66 +462,69 @@ uint32_t dmub_dcn35_get_current_time(struct dmub_srv *dmub)
 	return REG_READ(DMCUB_TIMER_CURRENT);
 }
 
-void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data)
+void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub)
 {
 	uint32_t is_dmub_enabled, is_soft_reset;
 	uint32_t is_traceport_enabled, is_cw6_enabled;
+	struct dmub_timeout_info timeout = {0};
 
-	if (!dmub || !diag_data)
+	if (!dmub)
 		return;
 
-	memset(diag_data, 0, sizeof(*diag_data));
-
-	diag_data->dmcub_version = dmub->fw_version;
-
-	diag_data->scratch[0] = REG_READ(DMCUB_SCRATCH0);
-	diag_data->scratch[1] = REG_READ(DMCUB_SCRATCH1);
-	diag_data->scratch[2] = REG_READ(DMCUB_SCRATCH2);
-	diag_data->scratch[3] = REG_READ(DMCUB_SCRATCH3);
-	diag_data->scratch[4] = REG_READ(DMCUB_SCRATCH4);
-	diag_data->scratch[5] = REG_READ(DMCUB_SCRATCH5);
-	diag_data->scratch[6] = REG_READ(DMCUB_SCRATCH6);
-	diag_data->scratch[7] = REG_READ(DMCUB_SCRATCH7);
-	diag_data->scratch[8] = REG_READ(DMCUB_SCRATCH8);
-	diag_data->scratch[9] = REG_READ(DMCUB_SCRATCH9);
-	diag_data->scratch[10] = REG_READ(DMCUB_SCRATCH10);
-	diag_data->scratch[11] = REG_READ(DMCUB_SCRATCH11);
-	diag_data->scratch[12] = REG_READ(DMCUB_SCRATCH12);
-	diag_data->scratch[13] = REG_READ(DMCUB_SCRATCH13);
-	diag_data->scratch[14] = REG_READ(DMCUB_SCRATCH14);
-	diag_data->scratch[15] = REG_READ(DMCUB_SCRATCH15);
-	diag_data->scratch[16] = REG_READ(DMCUB_SCRATCH16);
-
-	diag_data->undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
-	diag_data->inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
-	diag_data->data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
-
-	diag_data->inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
-	diag_data->inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
-	diag_data->inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
-
-	diag_data->inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
-	diag_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
-	diag_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
-
-	diag_data->outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
-	diag_data->outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
-	diag_data->outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
+	/* timeout data filled externally, cache before resetting memory */
+	timeout = dmub->debug.timeout_info;
+	memset(&dmub->debug, 0, sizeof(dmub->debug));
+	dmub->debug.timeout_info = timeout;
+
+	dmub->debug.dmcub_version = dmub->fw_version;
+
+	dmub->debug.scratch[0] = REG_READ(DMCUB_SCRATCH0);
+	dmub->debug.scratch[1] = REG_READ(DMCUB_SCRATCH1);
+	dmub->debug.scratch[2] = REG_READ(DMCUB_SCRATCH2);
+	dmub->debug.scratch[3] = REG_READ(DMCUB_SCRATCH3);
+	dmub->debug.scratch[4] = REG_READ(DMCUB_SCRATCH4);
+	dmub->debug.scratch[5] = REG_READ(DMCUB_SCRATCH5);
+	dmub->debug.scratch[6] = REG_READ(DMCUB_SCRATCH6);
+	dmub->debug.scratch[7] = REG_READ(DMCUB_SCRATCH7);
+	dmub->debug.scratch[8] = REG_READ(DMCUB_SCRATCH8);
+	dmub->debug.scratch[9] = REG_READ(DMCUB_SCRATCH9);
+	dmub->debug.scratch[10] = REG_READ(DMCUB_SCRATCH10);
+	dmub->debug.scratch[11] = REG_READ(DMCUB_SCRATCH11);
+	dmub->debug.scratch[12] = REG_READ(DMCUB_SCRATCH12);
+	dmub->debug.scratch[13] = REG_READ(DMCUB_SCRATCH13);
+	dmub->debug.scratch[14] = REG_READ(DMCUB_SCRATCH14);
+	dmub->debug.scratch[15] = REG_READ(DMCUB_SCRATCH15);
+	dmub->debug.scratch[16] = REG_READ(DMCUB_SCRATCH16);
+
+	dmub->debug.undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
+	dmub->debug.inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
+	dmub->debug.data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
+
+	dmub->debug.inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
+	dmub->debug.inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
+	dmub->debug.inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
+
+	dmub->debug.inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
+	dmub->debug.inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
+	dmub->debug.inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
+
+	dmub->debug.outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
+	dmub->debug.outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
+	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
-	diag_data->is_dmcub_enabled = is_dmub_enabled;
+	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
-	diag_data->is_dmcub_soft_reset = is_soft_reset;
+	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
-	diag_data->is_traceport_en  = is_traceport_enabled;
+	dmub->debug.is_traceport_en  = is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
-	diag_data->is_cw6_enabled = is_cw6_enabled;
+	dmub->debug.is_cw6_enabled = is_cw6_enabled;
 
-	diag_data->gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
-	diag_data->timeout_info = dmub->debug;
+	dmub->debug.gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
 }
 void dmub_dcn35_configure_dmub_in_system_memory(struct dmub_srv *dmub)
 {
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h
index 686e97c00ccc..39fcb7275da5 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h
@@ -269,7 +269,7 @@ void dmub_dcn35_set_outbox0_rptr(struct dmub_srv *dmub, uint32_t rptr_offset);
 
 uint32_t dmub_dcn35_get_current_time(struct dmub_srv *dmub);
 
-void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data);
+void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub);
 
 void dmub_dcn35_configure_dmub_in_system_memory(struct dmub_srv *dmub);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
index e1c4fe1c6e3e..e67f7c4784eb 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
@@ -415,72 +415,75 @@ uint32_t dmub_dcn401_get_current_time(struct dmub_srv *dmub)
 	return REG_READ(DMCUB_TIMER_CURRENT);
 }
 
-void dmub_dcn401_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data)
+void dmub_dcn401_get_diagnostic_data(struct dmub_srv *dmub)
 {
 	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset;
 	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
+	struct dmub_timeout_info timeout = {0};
 
-	if (!dmub || !diag_data)
+	if (!dmub)
 		return;
 
-	memset(diag_data, 0, sizeof(*diag_data));
-
-	diag_data->dmcub_version = dmub->fw_version;
-
-	diag_data->scratch[0] = REG_READ(DMCUB_SCRATCH0);
-	diag_data->scratch[1] = REG_READ(DMCUB_SCRATCH1);
-	diag_data->scratch[2] = REG_READ(DMCUB_SCRATCH2);
-	diag_data->scratch[3] = REG_READ(DMCUB_SCRATCH3);
-	diag_data->scratch[4] = REG_READ(DMCUB_SCRATCH4);
-	diag_data->scratch[5] = REG_READ(DMCUB_SCRATCH5);
-	diag_data->scratch[6] = REG_READ(DMCUB_SCRATCH6);
-	diag_data->scratch[7] = REG_READ(DMCUB_SCRATCH7);
-	diag_data->scratch[8] = REG_READ(DMCUB_SCRATCH8);
-	diag_data->scratch[9] = REG_READ(DMCUB_SCRATCH9);
-	diag_data->scratch[10] = REG_READ(DMCUB_SCRATCH10);
-	diag_data->scratch[11] = REG_READ(DMCUB_SCRATCH11);
-	diag_data->scratch[12] = REG_READ(DMCUB_SCRATCH12);
-	diag_data->scratch[13] = REG_READ(DMCUB_SCRATCH13);
-	diag_data->scratch[14] = REG_READ(DMCUB_SCRATCH14);
-	diag_data->scratch[15] = REG_READ(DMCUB_SCRATCH15);
-	diag_data->scratch[16] = REG_READ(DMCUB_SCRATCH16);
-
-	diag_data->undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
-	diag_data->inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
-	diag_data->data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
-
-	diag_data->inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
-	diag_data->inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
-	diag_data->inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
-
-	diag_data->inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
-	diag_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
-	diag_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
-
-	diag_data->outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
-	diag_data->outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
-	diag_data->outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
+	/* timeout data filled externally, cache before resetting memory */
+	timeout = dmub->debug.timeout_info;
+	memset(&dmub->debug, 0, sizeof(dmub->debug));
+	dmub->debug.timeout_info = timeout;
+
+	dmub->debug.dmcub_version = dmub->fw_version;
+
+	dmub->debug.scratch[0] = REG_READ(DMCUB_SCRATCH0);
+	dmub->debug.scratch[1] = REG_READ(DMCUB_SCRATCH1);
+	dmub->debug.scratch[2] = REG_READ(DMCUB_SCRATCH2);
+	dmub->debug.scratch[3] = REG_READ(DMCUB_SCRATCH3);
+	dmub->debug.scratch[4] = REG_READ(DMCUB_SCRATCH4);
+	dmub->debug.scratch[5] = REG_READ(DMCUB_SCRATCH5);
+	dmub->debug.scratch[6] = REG_READ(DMCUB_SCRATCH6);
+	dmub->debug.scratch[7] = REG_READ(DMCUB_SCRATCH7);
+	dmub->debug.scratch[8] = REG_READ(DMCUB_SCRATCH8);
+	dmub->debug.scratch[9] = REG_READ(DMCUB_SCRATCH9);
+	dmub->debug.scratch[10] = REG_READ(DMCUB_SCRATCH10);
+	dmub->debug.scratch[11] = REG_READ(DMCUB_SCRATCH11);
+	dmub->debug.scratch[12] = REG_READ(DMCUB_SCRATCH12);
+	dmub->debug.scratch[13] = REG_READ(DMCUB_SCRATCH13);
+	dmub->debug.scratch[14] = REG_READ(DMCUB_SCRATCH14);
+	dmub->debug.scratch[15] = REG_READ(DMCUB_SCRATCH15);
+	dmub->debug.scratch[16] = REG_READ(DMCUB_SCRATCH16);
+
+	dmub->debug.undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
+	dmub->debug.inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
+	dmub->debug.data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
+
+	dmub->debug.inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
+	dmub->debug.inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
+	dmub->debug.inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
+
+	dmub->debug.inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
+	dmub->debug.inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
+	dmub->debug.inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
+
+	dmub->debug.outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
+	dmub->debug.outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
+	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
-	diag_data->is_dmcub_enabled = is_dmub_enabled;
+	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
-	diag_data->is_dmcub_soft_reset = is_soft_reset;
+	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
 
 	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
-	diag_data->is_dmcub_secure_reset = is_sec_reset;
+	dmub->debug.is_dmcub_secure_reset = is_sec_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
-	diag_data->is_traceport_en  = is_traceport_enabled;
+	dmub->debug.is_traceport_en  = is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
-	diag_data->is_cw0_enabled = is_cw0_enabled;
+	dmub->debug.is_cw0_enabled = is_cw0_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
-	diag_data->is_cw6_enabled = is_cw6_enabled;
+	dmub->debug.is_cw6_enabled = is_cw6_enabled;
 
-	diag_data->gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
-	diag_data->timeout_info = dmub->debug;
+	dmub->debug.gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
 }
 void dmub_dcn401_configure_dmub_in_system_memory(struct dmub_srv *dmub)
 {
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h
index 31f95b27e227..c35be52676f6 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h
@@ -264,7 +264,7 @@ void dmub_dcn401_set_outbox0_rptr(struct dmub_srv *dmub, uint32_t rptr_offset);
 
 uint32_t dmub_dcn401_get_current_time(struct dmub_srv *dmub);
 
-void dmub_dcn401_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data);
+void dmub_dcn401_get_diagnostic_data(struct dmub_srv *dmub);
 
 void dmub_dcn401_configure_dmub_in_system_memory(struct dmub_srv *dmub);
 void dmub_dcn401_send_inbox0_cmd(struct dmub_srv *dmub, union dmub_inbox0_data_register data);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 6133d25da301..0a2285540daf 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -1099,11 +1099,11 @@ bool dmub_srv_get_outbox0_msg(struct dmub_srv *dmub, struct dmcub_trace_buf_entr
 	return dmub_rb_out_trace_buffer_front(&dmub->outbox0_rb, (void *)entry);
 }
 
-bool dmub_srv_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data)
+bool dmub_srv_get_diagnostic_data(struct dmub_srv *dmub)
 {
-	if (!dmub || !dmub->hw_funcs.get_diagnostic_data || !diag_data)
+	if (!dmub || !dmub->hw_funcs.get_diagnostic_data)
 		return false;
-	dmub->hw_funcs.get_diagnostic_data(dmub, diag_data);
+	dmub->hw_funcs.get_diagnostic_data(dmub);
 	return true;
 }
 
-- 
2.34.1

