Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE917ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D9E10E803;
	Wed, 14 Sep 2022 03:50:46 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F56610E803
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWDW2xcUHoIMyETvKVXhxl60k/V63yu3uoINDYdFVLaiDczu6y5nc5JeToLaVI/ra5+/kjNO+IJzaad9Ygp33yF9JNr1XUgU4MQdXmXOZ/3vlYz1S1Ye5VKq6WRiOMg8RcaO6Ogmozo6YrUAp/O+S8iLNSdo7vQVHEcmzRUDYUD+0Idhc7jolqNnqXHTBfMsKudIA68x1DZH8D1FUfqV2dfFRz98xG0jICC6I/1d5HCMJnDsmBzaWj3cdg1Y0DdDhL0R0xcGccZzWrG4HdTwlMs5DgGHNcVLy04PALr6PAOo+KbzN++CC8p6BnXjuRdjxqpI+EWWJFcK5USFzfOpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmXm5/YVAZjUOadgy1foXJdTEttdZXhCeXPyZV8ZI2k=;
 b=F0uVIyHdvfUSoa9vA13tFX22vL+opoq9bhV7k+2j+VDDHrrQbMT/HfQcpwfo65RWnRUMcJQ8caGw438iEQiwGSNVpBEjIpKnmTt79OQ5RK0wMAA/1hsLvSU4KtsGYWGODQDrgqK/Gb/gpKOneW/m2PMnLWLbY/iBZ7jMAXCTKcOuiHwmNoPD431hMtb0aiqz7bdaiknaEFBwyCsAU00v2K6neSYKgZQsv1ME51i9K6okKYUTLsm0EMMDVi/dVT+fnNRSsmQlbTSS+P9XfjdshbZ5joVL90PK1VeLMhG6jEWxwBycQ9nSBtvF6c8QZho/xIlm/AK4T9miDlb4g4d2lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmXm5/YVAZjUOadgy1foXJdTEttdZXhCeXPyZV8ZI2k=;
 b=kFsK7la1IanCR8mOg+sN9v7RK7wo7skGjjQ9q3hkhZF74a7vDj7j6MVQZNjNVSRmnarH+wZeJLo6Kr34VbZxjVU5UwUI3pwDFWP34pwB06RhD/OYV5NPQy/eYoO+OAEy1TuQZqlMBdvDTUKc9QOFrKGsoMztdd3D4zDMckkfOUA=
Received: from DM6PR04CA0015.namprd04.prod.outlook.com (2603:10b6:5:334::20)
 by MN2PR12MB4536.namprd12.prod.outlook.com (2603:10b6:208:263::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 03:50:37 +0000
Received: from DS1PEPF0000B076.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::a5) by DM6PR04CA0015.outlook.office365.com
 (2603:10b6:5:334::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:50:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000B076.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.10 via Frontend Transport; Wed, 14 Sep 2022 03:50:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:50:35 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:50:31 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 11/47] drm/amd/display: support proper mst payload removal
 when link is not in mst mode in dc
Date: Wed, 14 Sep 2022 11:47:32 +0800
Message-ID: <20220914034808.1093521-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B076:EE_|MN2PR12MB4536:EE_
X-MS-Office365-Filtering-Correlation-Id: bbdf3e24-8114-47e8-fd4b-08da96044890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Q6vsSYkSgLh6mmzQaK330QyqJvOveJgASZxBcE23H6sFX+4ebRKEPX+YAF9Tezs3U/FSFh+g88PJ8uBnc/E2NIMobdrVly1KaPAzRdI+uuwnfd7yjUbAZY7YM0VpX7wVUKi9VkG9uNRpUj7d5gg6OfXQtsQSpvX+JQYZwsVlAHszLaHw4L43cJbg6mg5soAO/8V2t/4hMhpLRanH8UPatcfNg4wYlA6F/L9WvJ4qr03zJzRWJVi6PwzS0a+cMRgd/0T0+ksw6GQrnlRRNLZsXK/3U13vsdLevTxNGpq5211jSEmDCFSrEnD8TCfOqmLVVHAaWBfUAUMJarHkYMPs4laRabi7SrhC3jijSeH57BppWWCG4UAa/vkdtGMr7GQ51Qb3KxhsdOxZpbQU8DftY/Jmo+H37wpy344gmidAYqyLeHTD9hj08I0nrBQzltawvwok67DPRxr/9rtsxnqUgah4qBxJQjjYD61KY4ljYxT4vowArZZTSuWzEzX0zbgW6RinlKUGZshJ02J6d3rUV59py8bi321dCQfcdLsvFek1+GTXe+eDvMFwm93qdWdgpF2HotFKCggjCR1YQQoSadCKbUffg/xxwJb+XKbYBFADwlseV96jAwhV5yXhAWDFTEaJuadHPML9sLTCrtkUgksXGr9S0pY5FlfEwzKwIk+tbqA08yxP8f/sD8Aiq4tZecBKNBEg00AXE4pnDHjiaIIQGdbxO9rGucFmOptz4GhBEp+55WVnpjfJkOwvdKqA0MiZY7KLGCya7KWrSB7Tf/9EY2g0X3v1i4X+Jec973zloX0AY4ziNIJgNOXLaYi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(478600001)(40460700003)(4326008)(426003)(8936002)(2906002)(186003)(70206006)(2616005)(7696005)(36756003)(40480700001)(336012)(1076003)(47076005)(26005)(36860700001)(83380400001)(8676002)(81166007)(356005)(5660300002)(82740400003)(86362001)(316002)(82310400005)(41300700001)(54906003)(6916009)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:50:36.6593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdf3e24-8114-47e8-fd4b-08da96044890
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B076.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4536
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

