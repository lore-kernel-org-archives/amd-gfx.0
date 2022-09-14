Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8054ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96BD210E830;
	Wed, 14 Sep 2022 05:13:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD6710E82F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjhW3vvbXavJNjx8a2hgUMuNY1viLtu+fPX/waXpfuKS1LwHmNiJqru83LKl6OW6nIuK8EyHK+rZWkQ74gJwWv5iGbmEPz+C0ozq/u0dnASu5fS0zdwInOa+PphUHq8G4acORqlRbkWWj4cDeMjroS3FFKA/Ub/ewm5y3dOM8l3/vpcpBEfJ3O2j6JtMu/3vEQGELCfEB0A2SilvrBapc0vSsdimjtQ0KSOMcC16ssxPU68E2YEmYTDsxxVfE1Oy/PENk29luG0mrJu5BAJ3JALQf4SWDHSKbS3x1CayxHyzMHQhBtegz0I3gdBOs8XaUS8v+5Bh0DMhDa+RsHVlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmXm5/YVAZjUOadgy1foXJdTEttdZXhCeXPyZV8ZI2k=;
 b=aTdtA7XyH1Ehe3YzBwluuI0BamGwNkq03neGyV/A13YfdArEDS+sH0ouBj1HCkmhlDuckRzU4EDQ64ozYV6TeC29dVjgLb4DEJCEfHhnAB5B7Gro6WsWZlzoPC9zi37PmQt/1JZGLBoNCpl3rBNx5wKq6jOc7Uiih50C/Qn7U7zET0Mf7fqVd7vAFXclmctgj70anSLdeLQ0M/J9jtiDQYyZ+uMBo4fcKWEO+T3q3NwBnfS5iUq9cIf0cbrf87PvD3FkPjyCC+hYVfxBTbj8+bp+D6z3gRcOV94FjKZk+gkpYrovb97PxA/ORmLPRNY7JRVevXQR7e7a+LhntQJSLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmXm5/YVAZjUOadgy1foXJdTEttdZXhCeXPyZV8ZI2k=;
 b=rFP3pXmT9GoMRtl+U+OutGDqzYZFehV9s8DDxqKR8EeKXiJnMEbeFbTmVCSFENyp4Gvz0XCVtqlD6GJfxs4XFjqiKJ1oLTffPf1ws0wunc11qvI6SpMAgYubDDNElSbzrh6jgHTskc7Zaldhd4m7Z1cwimpViY2UCQxCZDSNnMU=
Received: from MW4PR03CA0326.namprd03.prod.outlook.com (2603:10b6:303:dd::31)
 by BN9PR12MB5067.namprd12.prod.outlook.com (2603:10b6:408:134::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 05:13:37 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::dd) by MW4PR03CA0326.outlook.office365.com
 (2603:10b6:303:dd::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:13:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:13:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:13:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:13:22 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:13:17 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 11/47] drm/amd/display: support proper mst payload removal
 when link is not in mst mode in dc
Date: Wed, 14 Sep 2022 13:10:10 +0800
Message-ID: <20220914051046.1131186-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|BN9PR12MB5067:EE_
X-MS-Office365-Filtering-Correlation-Id: 3782b929-97fd-4434-5528-08da960fe11f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wpKXALAFfrAS9i1Pp/AvkeAJ8V1kOReF3IRmpTW/L0+msiupuI5TmOvII/9XpeEJsZbat1hOzb/mFnqh2yk235/yWh1fihIfYZRWuJ+c2B/IDwDtPhsuZG7KFYZEEEa4POUYZJelI5r/WXqDkf5/aDVvCKN/XQIJ0NcOxSWddgwbGdtC4ggAc2PTObhhDE1sCQypbSA+zqewBl0eFLqUqyzIqntTe4HJXeA9NbUos8EuVaDFjqqmWGB7HIUZxz3cykLDhfoleQ4QqULziYEMDm4ON+7PXRItSN+DDdJYo5qnzolH/JYHAoMn3w7NXghQJc9FSSWB2yV+uFSeT5kWl+gZbOvL80HRr0jbr9bMWTTz0M6r3Y9c92kpVcIyv2qVlSJE/Ui9L6DNuqNNdDEhGDnRp/3Wx8XpH0eOjQyCoS1aKvGB9xNJ6PUNxmQHz6/GPmEWKiXlc6IeYwegk6DDcqU4uIA8J9qyN9i4x33xdWpV7UEzZkmJ4rKU7TxHorVX38aRGNW37R7O0guSgM2pTessm5LLX035gl0F0IGSDC/klh026pMTZx1JwIwV/FaZj2k/CKK9O5bWcVerjz9nod7Wxs5RkwHjoiAEnISAuUh3T4XADUo/iQjnuezpwur9pvZ6YAfKEUkJRLiOtvz9Y7YGZXa8sD1kSpyg+6LuxiW8q224fm7wdVAo/U4MQHwKbvNh3ylGdKF9DBcWdav+unb3y5PRL2v57xVl5pPWCNpjVHVo+zAnKg1aHCTT8fD+fUBxnFKT2OaB6HDXsAgG5JL6vCp7ByZ/Ff49ys/RKPRcFIO5Wh6Z5jWHcLEkuY7H
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(83380400001)(47076005)(356005)(186003)(2616005)(1076003)(8676002)(6916009)(54906003)(5660300002)(4326008)(70586007)(336012)(6666004)(86362001)(40480700001)(7696005)(40460700003)(81166007)(316002)(8936002)(36860700001)(478600001)(2906002)(82740400003)(36756003)(426003)(41300700001)(82310400005)(26005)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:13:37.0074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3782b929-97fd-4434-5528-08da960fe11f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5067
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

