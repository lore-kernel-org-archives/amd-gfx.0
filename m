Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA8CC636D7
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD02B10E37B;
	Sun, 12 Feb 2023 17:00:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B1510E2F2
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGhLj/woXJaO3W1HM1TioRwY7rdNi+M0Su/yBl8ffb380GmiARfMztAw5eTfDuJ1Orbu4S5tkBr1YhvXWxzz7YwJ+8KTF1sUSp73u8WC5btsoGXNbV0T8Ha7t0ncEak7SZp7QmpQbQAGDc2uwqHE7v/1YBhQfwdATC4XswMgLYvVUwlsfSaWdFAVmNLoqhOnrMWktNGuoTKK63THEUGUh+f4fXuX49bPDJTbNQ9/mm3ypUf4OljkOAjc5L0fwOWhaqWgKYlcI2XA5uni+FnU2nnpa1KAnm+Ls1VPyxdOMjsaENY27X4a5b2K5pouma0azQOyZ77ls4kGIvjRMvzk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsXMa4YcAqjV764PPqUhptdFVH6W5slofY4P3Eat6CA=;
 b=e3/SibYZe5AHjDzFWjTGKuE6usY7mFBaZCcY/y2BhDZ4ZuiOIBI8UIYlOPhIUCNgpCe5EHykn1eOjplUHe0b5Rxp6NyNAHJAK718Q2yAbPMW6va1OQHWrzyvWBdzLAti1Q4Mas3cGmIR5AgH/K6UvEsCg6aQqjOLsr2wHKwpcu2eChF4fsLjIwoGCwK3qCVF3Y+BOS8aodIryucVXb0Ct1/ir7ge/fMCtpZL/tWLR5lnoDbym4xOW9xMCdsa6fN/QMEyaU6/4l6Sap2Fh6OgCvONjDec7ykxDRE3zdRkMHIP/CET8mlLNulM5lklCAjcwTNqyUYubzR6JTtjRfZtVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsXMa4YcAqjV764PPqUhptdFVH6W5slofY4P3Eat6CA=;
 b=hxcrK1VJGwbxprGBSwKcUYxvROLBABTmW6Cjke/Ls02GdgNagGmVvnq72lcTryhFcW00rb5DurJvEM9QRp2l6rwnb7oZ1MTAfOUyxuhJTU2r3LBe7G6Gp5nf0Mv4uI9IEruUx1eZ41Pa8Kc4hMPczUMvaDzAqwDYS7IKeHvBfEo=
Received: from DM6PR02CA0082.namprd02.prod.outlook.com (2603:10b6:5:1f4::23)
 by IA0PR12MB8303.namprd12.prod.outlook.com (2603:10b6:208:3de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Sun, 12 Feb
 2023 17:00:40 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::4b) by DM6PR02CA0082.outlook.office365.com
 (2603:10b6:5:1f4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:40 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:38 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/22] drm/amd/display: Extract temp drm mst deallocation wa
 into its own function
Date: Sun, 12 Feb 2023 11:59:42 -0500
Message-ID: <20230212165955.1993601-10-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|IA0PR12MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3668ad-c325-4bc0-b97e-08db0d1aabc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dZqorM38VkBKgQum5sx1tVGyYAZEHxr7WIFpYny+LzU7ktiES2tSIcGxW7AD8mxxcga3NIHfFKlsWWSP8m9ZhLae1qYI5HcTOp7xXh0pm/ERIbp7QlhfA+Pju9lQ2fiM/8iNVi2ARjCAEPk5v3/0QyaJPc2DFYPTs6DkG+vNrBbvvQ3YQxn3knXxMgwrdnpJvQVLnQBsJ7eLn6PJJ82+TbwKj9qWaNrjR3a1Jm3S05uHxTfLq7I23nJiB7Nzd1anmgxkaGW4RcnB/j3KaBUOeU0DOUDOAI5E5UbCZTBtZ2GqoA2iRhEM73vsEj14J8NmaAGD0AnpJ2yoawRVrBJl6PJPak4EmOGMBGU6DPfd4AvG9zZvjCZqG2KvTRLlcqjd61ttG5Sux2NvnerECJPPm3GcNNK4TsB1/Kx8QqFlKPYBLsXPgZZP5R9kAsChVFnkkNAmdMcUbi/Lgb3tTzcGzyffWMrMN5zMijGKueEnMF4H2ScX0zDWj/1rWlHCsCY4ahoWbP8WI0Vty24ZCbPAGAjGWlLe3gXGHk3fl5ZegNJV4BpZBoQMVqjO1WteRBa6UwPHjMA46KVcEHBKLkqplMyLCDU9s2I7XGaWYfrb2ANcK6J3cmaqMb4CnbIbhNZCAniZerR1cj0g8HMk0Bh9d10fl9KZf+Ydc0w3zYPEFbEvfGni3aegLmYdSMGmjSOL7b0W072ZfIJDAksL8gxDyEiCJawocfvxoEr53RL9Zs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(6666004)(2616005)(41300700001)(356005)(6916009)(70586007)(70206006)(8676002)(4326008)(82740400003)(81166007)(44832011)(5660300002)(2906002)(8936002)(36860700001)(40480700001)(478600001)(82310400005)(316002)(86362001)(83380400001)(54906003)(36756003)(336012)(426003)(47076005)(66899018)(16526019)(26005)(186003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:40.4554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3668ad-c325-4bc0-b97e-08db0d1aabc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8303
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Jerry Zuo <Jerry.Zuo@amd.com>, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
A recent change was made to implement temporary workaround due DRM
update in MST interfaces. The workaround is added into our generic
deallocation MST sequence.

This ticket is to extract this temporary workaround into its own function so
it is differentiated from our generic sequence.

Reviewed-by: Jerry Zuo <Jerry.Zuo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 17 ++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 95 ++++++++++++++++---
 3 files changed, 102 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c10982f841f9..833d7137c4f4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1652,6 +1652,23 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	/* TODO: Remove after DP2 receiver gets proper support of Cable ID feature */
 	adev->dm.dc->debug.ignore_cable_id = true;
 
+	/* TODO: There is a new drm mst change where the freedom of
+	 * vc_next_start_slot update is revoked/moved into drm, instead of in
+	 * driver. This forces us to make sure to get vc_next_start_slot updated
+	 * in drm function each time without considering if mst_state is active
+	 * or not. Otherwise, next time hotplug will give wrong start_slot
+	 * number. We are implementing a temporary solution to even notify drm
+	 * mst deallocation when link is no longer of MST type when uncommitting
+	 * the stream so we will have more time to work on a proper solution.
+	 * Ideally when dm_helpers_dp_mst_stop_top_mgr message is triggered, we
+	 * should notify drm to do a complete "reset" of its states and stop
+	 * calling further drm mst functions when link is no longer of an MST
+	 * type. This could happen when we unplug an MST hubs/displays. When
+	 * uncommit stream comes later after unplug, we should just reset
+	 * hardware states only.
+	 */
+	adev->dm.dc->debug.temp_mst_deallocation_sequence = true;
+
 	if (adev->dm.dc->caps.dp_hdmi21_pcon_support)
 		DRM_INFO("DP-HDMI FRL PCON supported\n");
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index cec3154009c4..6e1c4b11150a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -874,6 +874,7 @@ struct dc_debug_options {
 	unsigned int min_prefetch_in_strobe_ns;
 	bool disable_unbounded_requesting;
 	bool dig_fifo_off_in_blank;
+	bool temp_mst_deallocation_sequence;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 22538b4f529b..47a9adb680a9 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1186,7 +1186,8 @@ static void remove_stream_from_alloc_table(
 	}
 }
 
-static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
+static enum dc_status deallocate_mst_payload_with_temp_drm_wa(
+		struct pipe_ctx *pipe_ctx)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
@@ -1195,11 +1196,90 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	int i;
 	bool mst_mode = (link->type == dc_connection_mst_branch);
 	/* adjust for drm changes*/
-	bool update_drm_mst_state = true;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 	const struct dc_link_settings empty_link_settings = {0};
 	DC_LOGGER_INIT(link->ctx->logger);
 
+	if (link_hwss->ext.set_throttled_vcp_size)
+		link_hwss->ext.set_throttled_vcp_size(pipe_ctx, avg_time_slots_per_mtp);
+	if (link_hwss->ext.set_hblank_min_symbol_width)
+		link_hwss->ext.set_hblank_min_symbol_width(pipe_ctx,
+				&empty_link_settings,
+				avg_time_slots_per_mtp);
+
+	if (dm_helpers_dp_mst_write_payload_allocation_table(
+			stream->ctx,
+			stream,
+			&proposed_table,
+			false))
+		update_mst_stream_alloc_table(
+				link,
+				pipe_ctx->stream_res.stream_enc,
+				pipe_ctx->stream_res.hpo_dp_stream_enc,
+				&proposed_table);
+	else
+		DC_LOG_WARNING("Failed to update"
+				"MST allocation table for"
+				"pipe idx:%d\n",
+				pipe_ctx->pipe_idx);
+
+	DC_LOG_MST("%s"
+			"stream_count: %d: ",
+			__func__,
+			link->mst_stream_alloc_table.stream_count);
+
+	for (i = 0; i < MAX_CONTROLLER_NUM; i++) {
+		DC_LOG_MST("stream_enc[%d]: %p      "
+		"stream[%d].hpo_dp_stream_enc: %p      "
+		"stream[%d].vcp_id: %d      "
+		"stream[%d].slot_count: %d\n",
+		i,
+		(void *) link->mst_stream_alloc_table.stream_allocations[i].stream_enc,
+		i,
+		(void *) link->mst_stream_alloc_table.stream_allocations[i].hpo_dp_stream_enc,
+		i,
+		link->mst_stream_alloc_table.stream_allocations[i].vcp_id,
+		i,
+		link->mst_stream_alloc_table.stream_allocations[i].slot_count);
+	}
+
+	if (link_hwss->ext.update_stream_allocation_table == NULL ||
+			link_dp_get_encoding_format(&link->cur_link_settings) == DP_UNKNOWN_ENCODING) {
+		DC_LOG_DEBUG("Unknown encoding format\n");
+		return DC_ERROR_UNEXPECTED;
+	}
+
+	link_hwss->ext.update_stream_allocation_table(link, &pipe_ctx->link_res,
+			&link->mst_stream_alloc_table);
+
+	if (mst_mode) {
+		dm_helpers_dp_mst_poll_for_allocation_change_trigger(
+			stream->ctx,
+			stream);
+	}
+
+	dm_helpers_dp_mst_send_payload_allocation(
+			stream->ctx,
+			stream,
+			false);
+
+	return DC_OK;
+}
+
+static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
+{
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dc_link *link = stream->link;
+	struct dc_dp_mst_stream_allocation_table proposed_table = {0};
+	struct fixed31_32 avg_time_slots_per_mtp = dc_fixpt_from_int(0);
+	int i;
+	bool mst_mode = (link->type == dc_connection_mst_branch);
+	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
+	const struct dc_link_settings empty_link_settings = {0};
+	DC_LOGGER_INIT(link->ctx->logger);
+
+	if (link->dc->debug.temp_mst_deallocation_sequence)
+		return deallocate_mst_payload_with_temp_drm_wa(pipe_ctx);
 
 	/* deallocate_mst_payload is called before disable link. When mode or
 	 * disable/enable monitor, new stream is created which is not in link
@@ -1216,7 +1296,7 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 				&empty_link_settings,
 				avg_time_slots_per_mtp);
 
-	if (mst_mode || update_drm_mst_state) {
+	if (mst_mode) {
 		/* when link is in mst mode, reply on mst manager to remove
 		 * payload
 		 */
@@ -1278,19 +1358,12 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 			stream->ctx,
 			stream);
 
-		if (!update_drm_mst_state)
-			dm_helpers_dp_mst_send_payload_allocation(
+		dm_helpers_dp_mst_send_payload_allocation(
 				stream->ctx,
 				stream,
 				false);
 	}
 
-	if (update_drm_mst_state)
-		dm_helpers_dp_mst_send_payload_allocation(
-			stream->ctx,
-			stream,
-			false);
-
 	return DC_OK;
 }
 
-- 
2.25.1

