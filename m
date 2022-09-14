Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADA4ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B8910E7EC;
	Wed, 14 Sep 2022 03:28:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2A7310E7EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KM8CrEA3aakHOU5bAuuG98ChjEnh9Tcf/x+bEdoQydSOekmIrMPcAP0iOUCRGS1OB7dHvCztlngRg9kQFilL3EAwXWFJ2VwmqeDmO4ircSIdYbMvMDKoq6ieEX1Bz5A6kJFgL08NszbkB9OEBpakollOddG6Kg/fqPs4vPxoaSscx1rv8kmhEOoB8kprZgcsE6eOZ9yuX+yQ4ZgVlbj6BF/OfOaLqAetxyxDU4hGbGIdLhM9wGPjeDqIZkl8K0ICtYArAIeZwttSRDlyNBZzbu5qCrCZAIcoF7dnnTnpidazo5jC88I1obbJTOeUTOYwAtXM6BZATaKROO8StKE2tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmXm5/YVAZjUOadgy1foXJdTEttdZXhCeXPyZV8ZI2k=;
 b=LJeAZ9sU+0Xlv+Xr7myjIHRyrtQFM3bJoH3jTb/kdhq425in2J+kKBqaVJHXLLHUOoWHeQaTDZaOaCtoR8qWsGui8NoNeFB2mxIrVrfibZfjohELIFKJya7KLuhXZVJ6FBoabA7vzvAw2Rp7mg8cFl/Mw0bLHDMUP3K+8GMAnoAFGQ5qO3VJeK+4PfbWWMmndFH5OgqaOluDNvpGbhWQ5j3alMALS3Dz0YXcsa7/AA5M+dYaMjPPbopT043ofPqD6wmpaXIYIr7HOk4khRuE3IwYxVy5jKqoJcTWKZn41PVly6eJOiQEhXFn0hfkPW9IetY/uoCx9nh6WQU8t6/8Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmXm5/YVAZjUOadgy1foXJdTEttdZXhCeXPyZV8ZI2k=;
 b=NZtSQAyGURrjkX1vLouhxRGA1yAPacdHll1vCYJp5rVW/rSwwwI5UTcoeSRrYZfubB8cZ0S16mXch0q5ipm9Q7hoTA6enqmmp10Qcn8j1ESezT1UMjcoU2o67EaH9YiCYiygrKVQBH2tcQtCW5BBvNri/026jS6t87ydLqhds5w=
Received: from DM6PR02CA0132.namprd02.prod.outlook.com (2603:10b6:5:1b4::34)
 by BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Wed, 14 Sep
 2022 03:27:57 +0000
Received: from DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::5a) by DM6PR02CA0132.outlook.office365.com
 (2603:10b6:5:1b4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT072.mail.protection.outlook.com (10.13.173.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:27:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:27:56 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:27:51 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/47] drm/amd/display: support proper mst payload removal
 when link is not in mst mode in dc
Date: Wed, 14 Sep 2022 11:24:05 +0800
Message-ID: <20220914032441.1075031-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT072:EE_|BL1PR12MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f33539-3c8c-477c-af54-08da96011e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2tBtncNs7D5VPZkEFxbIW2h5SajN7FDGvToLbjCtPgUCN4VLSeH7saXn7i8eQGeHxcRfoAGK8JhUr/E9KwCeSs4OzUI6XACFIkxjOxHE66Se5/c4HqpPsjJJRqEOc3cUTTRoOAGvUe4Oc5JAgT4DWjjuuJgG5BMwvANmnKS/vkv9SEcDAAX8oKuulRgkZMt5h6fo2W0Wq/tDjPMnaT4+sEGEc5qTqr4cgEnNAiDS1vhQNVTDdgcbV12Ep/6mUo6ubrIVX1CTFzAPXZk8JWVJB2pQTsaBOh4dOoVLnQAYRzViYvE6BjVIV1yKIQX5THNS6POmgLv+PXvZBULIMrwq+gmdCk9fgNaurdFs5CZK2URp4r64Yavy8ORQvLX67FBqlieJSd3eUA0HZ6NwdKsDt6MdaY9AAjox76nyHNPUDlFsmdKZqW5CYtT7Z0jWq7YS5NEs51Xs12qX+pMGmpa64ccgw2hvDznb9X7OQIcVdx1lXOYsSTnfALxMt8xeqqIwAiMeXMp2dLn57W/8e9SBtNppKgyrV5jX2aZHiBSsOQtqD38LPgAvUqa95Dn38e19pESaEVZU+B1lkf+7MO6O/zuSFhyKZfIOk1LZViauEXGhpppVsEgp89r2rTuJzpz/PLmuhzpIxEX5vcFu6DjHxFHr/3rXpTvWVKUqmCyS9VquRD1RsUza7vxeg+wlPwdWBMm3XbMJl9ychjtlkIIapsU/wmHpbORZ6B+rlN4/NtWInxBkPI5RNr5pRNTc9AphRabzyxLnRY2V5yrg4wryghufKPYDv/BzoAJKvnlShvr4uHtmDxQFHrajUMcXvJzW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(7696005)(26005)(40480700001)(41300700001)(81166007)(316002)(82310400005)(54906003)(36860700001)(70586007)(82740400003)(6666004)(36756003)(86362001)(6916009)(356005)(8676002)(336012)(478600001)(2616005)(8936002)(40460700003)(1076003)(186003)(426003)(83380400001)(4326008)(2906002)(70206006)(5660300002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:27:56.8297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f33539-3c8c-477c-af54-08da96011e06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048
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
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
When user unplugs mst hubs, the current code will forcefully zero
entire mst payload allocation table structure stored in link before we
deallocate actual payload when disabling stream.

During the first disable stream sequence, we will use current mst
payload allocation table to determine if link should be turned off.
Because we zero out it before we are disabling stream, the payload
allocation table stored in link doesn't represent the actual allocation status,
so we turn off link at the first disable stream without waiting until all
streams' payloads have been deallocated. This avoilates the designed
deallocation sequence and caused system hang in DP2 scenario.

[how]
Remove payload during deallocation and never zero payload allocation structure
without actually deallocating payload.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 70 +++++++++++++------
 1 file changed, 49 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 7a9f7b4bd666..4fb57d4041a0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -848,20 +848,13 @@ static bool discover_dp_mst_topology(struct dc_link *link, enum dc_detect_reason
 
 bool reset_cur_dp_mst_topology(struct dc_link *link)
 {
-	bool result = false;
 	DC_LOGGER_INIT(link->ctx->logger);
 
 	LINK_INFO("link=%d, mst branch is now Disconnected\n",
 		  link->link_index);
 
 	revert_dpia_mst_dsc_always_on_wa(link);
-	result = dm_helpers_dp_mst_stop_top_mgr(link->ctx, link);
-
-	link->mst_stream_alloc_table.stream_count = 0;
-	memset(link->mst_stream_alloc_table.stream_allocations,
-			0,
-			sizeof(link->mst_stream_alloc_table.stream_allocations));
-	return result;
+	return dm_helpers_dp_mst_stop_top_mgr(link->ctx, link);
 }
 
 static bool should_prepare_phy_clocks_for_link_verification(const struct dc *dc,
@@ -3570,6 +3563,35 @@ static void update_mst_stream_alloc_table(
 				work_table[i];
 }
 
+static void remove_stream_from_alloc_table(
+		struct dc_link *link,
+		struct stream_encoder *dio_stream_enc,
+		struct hpo_dp_stream_encoder *hpo_dp_stream_enc)
+{
+	int i = 0;
+	struct link_mst_stream_allocation_table *table =
+			&link->mst_stream_alloc_table;
+
+	if (hpo_dp_stream_enc) {
+		for (; i < table->stream_count; i++)
+			if (hpo_dp_stream_enc == table->stream_allocations[i].hpo_dp_stream_enc)
+				break;
+	} else {
+		for (; i < table->stream_count; i++)
+			if (dio_stream_enc == table->stream_allocations[i].stream_enc)
+				break;
+	}
+
+	if (i < table->stream_count) {
+		i++;
+		for (; i < table->stream_count; i++)
+			table->stream_allocations[i-1] = table->stream_allocations[i];
+		memset(&table->stream_allocations[table->stream_count-1], 0,
+				sizeof(struct link_mst_stream_allocation));
+		table->stream_count--;
+	}
+}
+
 static void dc_log_vcp_x_y(const struct dc_link *link, struct fixed31_32 avg_time_slots_per_mtp)
 {
 	const uint32_t VCP_Y_PRECISION = 1000;
@@ -3987,26 +4009,32 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 				&empty_link_settings,
 				avg_time_slots_per_mtp);
 
-	/* TODO: which component is responsible for remove payload table? */
 	if (mst_mode) {
+		/* when link is in mst mode, reply on mst manager to remove
+		 * payload
+		 */
 		if (dm_helpers_dp_mst_write_payload_allocation_table(
 				stream->ctx,
 				stream,
 				&proposed_table,
-				false)) {
+				false))
 
 			update_mst_stream_alloc_table(
-						link,
-						pipe_ctx->stream_res.stream_enc,
-						pipe_ctx->stream_res.hpo_dp_stream_enc,
-						&proposed_table);
-		}
-		else {
-				DC_LOG_WARNING("Failed to update"
-						"MST allocation table for"
-						"pipe idx:%d\n",
-						pipe_ctx->pipe_idx);
-		}
+					link,
+					pipe_ctx->stream_res.stream_enc,
+					pipe_ctx->stream_res.hpo_dp_stream_enc,
+					&proposed_table);
+		else
+			DC_LOG_WARNING("Failed to update"
+					"MST allocation table for"
+					"pipe idx:%d\n",
+					pipe_ctx->pipe_idx);
+	} else {
+		/* when link is no longer in mst mode (mst hub unplugged),
+		 * remove payload with default dc logic
+		 */
+		remove_stream_from_alloc_table(link, pipe_ctx->stream_res.stream_enc,
+				pipe_ctx->stream_res.hpo_dp_stream_enc);
 	}
 
 	DC_LOG_MST("%s"
-- 
2.37.3

