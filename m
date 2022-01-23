Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E799C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4576A10E42A;
	Sun, 23 Jan 2022 18:21:05 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7913A10E2AC
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAnrmLBGGOC9OMB2gVcPob8AB9tYWbVppvJZIbDOTq9NCXqJaj9CSLK4/cZLBfWcJk3qG6D2ZTwFeEACcwWC72R10rNTLmoA0pfZ0lgAY+/ME7pWWYnWepvZqwRAytDWPgJUgHbAL0+qXMmMQC/ta7vW3noz2Lm0A2NPF+c9vcrYR+ucfUjhsVb9Y0h5KimtvqzT1F10+pfA7rVF3bXUQPz/byjjYvu/xpZOfS48H86ousWgED0lDrFsceRlX/BFU29mx+Wh67Fc4z7n+A4y9ZFYUyntvdsc6tIgBFTFw1JbrdJHtBKX8mBM5X+h1maNO7/ZZWij3mU+heP0bgsTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEZmKYunfhujwal1xa8e/FyboarrH+wTF6QMS8Wf+Ms=;
 b=aC+g2qqXRw1pdvqBZe4MsR6dr3Ku+Kmby5PYg4yjUq7SM4/nxvEV5KGcf0rYBUg6buR2GJ7gjvXUpbtdKE4STQEC7bwVgkLA9OyhGRQhJ/GWmCGsjS3OHysYH8+73enAO6yTUNm4LJy/ivc2Ed7t9DffnfL12MGAwiVBef4hnZpJEd+t4R75iNxr5G0zsRQ8dvuQBtFtQwFbeLXzZSQvoVWx3guYU6IDnzMUm9k/a6ivQBrLmEy28J5CnKeLYIA7QnsG4WEUgUtXPcT4Z5YkG77wCYDTUnjBKTJBmRpQuQAAeRjcVkii+6hV31sQg3Cl15nZLkjKdP3CTjQev8l9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEZmKYunfhujwal1xa8e/FyboarrH+wTF6QMS8Wf+Ms=;
 b=Jii55eI0q3FJukd40KHtx1/Qxr+f/O2gAuMLF8AnxceH4hREVKOFcQ1UtFT1vgcqCJEKTusnW25FFlJF5YrrxVcEAffQpLWoADMPvb85TtQDWQe/v83DAFy9LJQh5bddYtx7z4CZFIzhYrXXx8C7ijoXkn0yoFfYIVFqq+ILp2I=
Received: from BN9PR03CA0723.namprd03.prod.outlook.com (2603:10b6:408:110::8)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Sun, 23 Jan
 2022 18:21:00 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::95) by BN9PR03CA0723.outlook.office365.com
 (2603:10b6:408:110::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Sun, 23 Jan 2022 18:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:21:00 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:20:58 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/24] drm/amd/display: Change return type of
 dm_helpers_dp_mst_stop_top_mgr
Date: Sun, 23 Jan 2022 13:20:03 -0500
Message-ID: <20220123182021.4154032-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92995cae-4a43-4877-7a05-08d9de9d1b76
X-MS-TrafficTypeDiagnostic: BY5PR12MB4146:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB41465B546378B1E78FDB22A0985D9@BY5PR12MB4146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eRPsIKon3t+Wj02Hf8XcWSzZiiTcVc90sfLRKmexjOwxPf+qAodjvlGuHRVikd/cJkA+E4Ikc8Tkg9hKbcUAsNxsTdecWcNVy9X9zuueVLNdNgfmsAxXqq3J6yJJBb5YtgAR89a/vPcnelVptrV0viasDG5SRih+ag5LuMTZBceZuvX0Bvzu4wynmw7zP3vbTb+TWxLO4bDbU7WW0zjOMezQd7vS2r/kFknC8QtnxReD/nfK5Nl6kaalPFR5j/Ge7TBdYilh12AzA+GCsSKLJ475kuJ02Eg11G1WMChoXNPFlRKtpC/s2XKZvbRWSd+BP9YSIW7LVQG+8bfbCy9eLsMX/IvXfZ5/LI28ThPOlzhgYxZGz4YcUud9gfK4fi3W8oAdv2VGh/sOWCDi6MwgFSCEPWa/sS97MCXnoj9SDPK3QPbStYdYplx8fYaByqoVxPU/tvLuh+rXSySFQ4a5EGCu7NuuLxeWTmwJvhHz7XlgKp42c3TqotMxzcTPbXKJ725fORXiAraw8XvSVLogbOshZEpOgJljS5WHUkfcDbv8kJEm6AH1LDheJamwimcsl49nFl9JczQQQI5al03WVSYA4hbVc0In0E8HVfltlaQpN9kcJvzofyQng4zSGWZVGvAsAEayJJtNScvffchAMPVT1NyXs20Jzaq8Mnjg78s04e3xfrnERdFrhxpSqccU9apCdwDh2rK6bjpxoha4mjrZOlMGMaGTSM7DvcHqv3gOlKJfmfen/g11hDenzahe/VGv8HbGvMdi522sLpSqq+QGkiURcopllURkoTlr8Z0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700004)(356005)(81166007)(47076005)(83380400001)(36860700001)(70586007)(40460700003)(86362001)(316002)(82310400004)(36756003)(70206006)(4326008)(5660300002)(2906002)(8676002)(2616005)(508600001)(426003)(1076003)(6916009)(336012)(8936002)(26005)(54906003)(186003)(16526019)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:21:00.1148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92995cae-4a43-4877-7a05-08d9de9d1b76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146
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
Cc: stylon.wang@amd.com, Ian Chen <ian.chen@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ian Chen <ian.chen@amd.com>

Prepare for future dm can have different implementation depends on the
return value.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 24 ++++---------------
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 14 ++++++-----
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  2 +-
 3 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 03a04b1e37f2..d757bdd9f0e2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -445,40 +445,24 @@ bool dm_helpers_dp_mst_start_top_mgr(
 	return (drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_mgr, true) == 0);
 }
 
-void dm_helpers_dp_mst_stop_top_mgr(
+bool dm_helpers_dp_mst_stop_top_mgr(
 		struct dc_context *ctx,
 		struct dc_link *link)
 {
 	struct amdgpu_dm_connector *aconnector = link->priv;
-	uint8_t i;
 
 	if (!aconnector) {
 		DRM_ERROR("Failed to find connector for link!");
-		return;
+		return false;
 	}
 
 	DRM_INFO("DM_MST: stopping TM on aconnector: %p [id: %d]\n",
 			aconnector, aconnector->base.base.id);
 
-	if (aconnector->mst_mgr.mst_state == true) {
+	if (aconnector->mst_mgr.mst_state == true)
 		drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_mgr, false);
 
-		for (i = 0; i < MAX_SINKS_PER_LINK; i++) {
-			if (link->remote_sinks[i] == NULL)
-				continue;
-
-			if (link->remote_sinks[i]->sink_signal ==
-			    SIGNAL_TYPE_DISPLAY_PORT_MST) {
-				dc_link_remove_remote_sink(link, link->remote_sinks[i]);
-
-				if (aconnector->dc_sink) {
-					dc_sink_release(aconnector->dc_sink);
-					aconnector->dc_sink = NULL;
-					aconnector->dc_link->cur_link_settings.lane_count = 0;
-				}
-			}
-		}
-	}
+	return false;
 }
 
 bool dm_helpers_dp_read_dpcd(
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index b94927eaba8d..b826ac9bd85d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -840,20 +840,22 @@ static bool discover_dp_mst_topology(struct dc_link *link, enum dc_detect_reason
 	return link->type == dc_connection_mst_branch;
 }
 
-static void reset_cur_dp_mst_topology(struct dc_link *link)
+static bool reset_cur_dp_mst_topology(struct dc_link *link)
 {
+	bool result = false;
 	DC_LOGGER_INIT(link->ctx->logger);
 
 	LINK_INFO("link=%d, mst branch is now Disconnected\n",
 		  link->link_index);
 
 	revert_dpia_mst_dsc_always_on_wa(link);
-	dm_helpers_dp_mst_stop_top_mgr(link->ctx, link);
+	result = dm_helpers_dp_mst_stop_top_mgr(link->ctx, link);
 
 	link->mst_stream_alloc_table.stream_count = 0;
 	memset(link->mst_stream_alloc_table.stream_allocations,
 			0,
 			sizeof(link->mst_stream_alloc_table.stream_allocations));
+	return result;
 }
 
 static bool should_prepare_phy_clocks_for_link_verification(const struct dc *dc,
@@ -1305,7 +1307,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 bool dc_link_detect(struct dc_link *link, enum dc_detect_reason reason)
 {
 	bool is_local_sink_detect_success;
-	bool is_remote_sink_detect_required = false;
+	bool is_delegated_to_mst_top_mgr = false;
 	enum dc_connection_type pre_link_type = link->type;
 
 	is_local_sink_detect_success = detect_link_and_local_sink(link, reason);
@@ -1316,14 +1318,14 @@ bool dc_link_detect(struct dc_link *link, enum dc_detect_reason reason)
 	if (is_local_sink_detect_success && link->local_sink &&
 			dc_is_dp_signal(link->local_sink->sink_signal) &&
 			link->dpcd_caps.is_mst_capable)
-		is_remote_sink_detect_required = discover_dp_mst_topology(link, reason);
+		is_delegated_to_mst_top_mgr = discover_dp_mst_topology(link, reason);
 
 	if (is_local_sink_detect_success &&
 			pre_link_type == dc_connection_mst_branch &&
 			link->type != dc_connection_mst_branch)
-		reset_cur_dp_mst_topology(link);
+		is_delegated_to_mst_top_mgr = reset_cur_dp_mst_topology(link);
 
-	return is_local_sink_detect_success && !is_remote_sink_detect_required;
+	return is_local_sink_detect_success && !is_delegated_to_mst_top_mgr;
 }
 
 bool dc_link_get_hpd_state(struct dc_link *dc_link)
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index a5497ba89f15..b71b5fb894e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -113,7 +113,7 @@ bool dm_helpers_dp_mst_start_top_mgr(
 		const struct dc_link *link,
 		bool boot);
 
-void dm_helpers_dp_mst_stop_top_mgr(
+bool dm_helpers_dp_mst_stop_top_mgr(
 		struct dc_context *ctx,
 		struct dc_link *link);
 /**
-- 
2.25.1

