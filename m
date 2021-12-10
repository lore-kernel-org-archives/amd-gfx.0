Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA0BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 15:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDAF910E75A;
	Fri, 10 Dec 2021 15:54:45 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F3310E74D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 15:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JE9F6gilKJqVSpaitx5k3VsSOjqarvdMwW2V0wgY4gQDr0Ba3Y8wbXZPKKAjrtAUwcwVtW+XO2OiFTwYMjnYn51FOx6ci0f9tAakHuIH2QYYIEjw4I1P6qNn6pFl1LWNqOGad0v0LT8d+4a0BjLhylYUPejYCNAx8cUjkFPiQPme+SRAw/9d8rn16edi78QgY5AiO1HAZ+xAC0AZgKwoB7uEuTxuP1eunEZr0FCdWZT0GSUSJIU5TLhHpolbNaHTg+7HPP5pYgQ432lKrDYFfJD1im3a3YRWMnwS1g7xRHGmWdVHR7SxLNsLt4Q/0qGSIRDS7UwFPtIEa1HdbUSoDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1Gkf9wGe4RUi6B3k25dA+kcVu4wPWavMNiF/mZ5bnQ=;
 b=DAsoUpV8aNt+7lgjTTOpRgV53Kva18xy6fb0Ygb2tcjsomLpl+7sW7S8ZUDyjjCNqPI6kvGQ5gYZl38p9u3SjDCm326oUD9E0esZtCzyBlPSnZkJBlGa5pm968RpeYYmZ1flRopbFOsuHaybW45pDoeiLWf+no7+be3Tbb7h/Q6/Xpby9m4F9c5d5ALUZVW9YBOqfhf31HAIPDinjX02xCowOgGQE4WL1WPGaL9kSekwlimPRUO4z4nWT3aff7deJbyMpb1E1617lCPbmBYmdz/0e2p/NUXqtiaNNOi3YKfGRrQPEkLIyOtqrc7MfcgZvA6Zv0jj4OHWt1CtB7YTpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1Gkf9wGe4RUi6B3k25dA+kcVu4wPWavMNiF/mZ5bnQ=;
 b=3+KjWg7RlT6YEA2VI7Xe+hDgbjbuSjru7uEj3Q3kdI1WCMSycebTrcMVTUZy5b6ZWqxOQGAFc3FSdhAbEw49/wid4ftXV1fesrW1EgCLmlefk0NkyGqKHMXeom9WJY4kylrnfMcbls5PQGH3Jq0cS+xOyHNLhWqv6SLhUjI92vY=
Received: from DM6PR18CA0032.namprd18.prod.outlook.com (2603:10b6:5:15b::45)
 by BL1PR12MB5240.namprd12.prod.outlook.com (2603:10b6:208:319::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 10 Dec
 2021 15:54:40 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::3f) by DM6PR18CA0032.outlook.office365.com
 (2603:10b6:5:15b::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Fri, 10 Dec 2021 15:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:54:40 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:54:39 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd: add some extra checks that is_dig_enabled is
 defined
Date: Fri, 10 Dec 2021 09:54:14 -0600
Message-ID: <20211210155415.11867-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4be8629f-ca96-4a70-afd0-08d9bbf56059
X-MS-TrafficTypeDiagnostic: BL1PR12MB5240:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB524059448CE34A8D43B8BA0BE2719@BL1PR12MB5240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HaZ2ANAsIRvaMXyR0aav9IpyZfBCrNmmTWi+MpxSmNAzH5eAH63m2P+u0kE0ovN1lVFXOwbkXsvTQMf4HFRiB1ShZjXatmF0cKAv6FONWbJEj63hV2JfXdvkeFU5Gu59UXVKVEhc/XZA0qA77hmyzHQLznW7vqQ0HlRK8iWDnhRjJQ/84KHwx0ax5yAbWKO3JcMsvMBwTh/9w9/A0rtlhq8gCbw2MT8oiTar3A0ZSZEFBOsZvegbdOv7YgQ5v20ffTJfIJBkCi2xoXq+s1O+9H365FhPhLqSQ6+RGD71o5lLbIhxaXU+Ok+3pwoYkkOBDcb6lmkqgZSf2KPEuTn3TYiN8urcQVoN0MXXp8xy9/2jjbITrIqaDu2NW2PXG8DwhDkOuO3GbyH4iaV+dNvWNT9eNjD/dd2USquE4S3fUg/3gV4rdRIdcv9qtV9mAJ6nW1y2UaJ+lsDwPtIw7p+QQ0b91i6nTrBk1vxurHZnInJR7jsBPBlYpCRvfkBM6nDdlN3qmhbM/xL0y/qFcJoJ5H3IDqtt0ZD/CqvisB6DeO268zUZubDteXDLRguZfuyjYdbjDJFZm+fTxGlV4ip/uXaxVzSJIK37jLkm335wx3Cq1119Rm6CE+TcAELS6NdgJqq1E2+ooJTo2xW0HfgNsgRazXXNQw31SJDgXsQQMPRoMwF7qJsZMgN4L5eBsoCWjV/FmAbQkPWRT0NO5SNFD4ReQfmgFz4IJrfku8076txYhat5DJ+9IvYgtzGccbutS3aiHttMQqMw5V8SN2D4upoKsrzRWWWF7rpxBrFCctY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(2616005)(44832011)(426003)(81166007)(70586007)(83380400001)(8936002)(8676002)(36860700001)(508600001)(47076005)(70206006)(186003)(336012)(16526019)(2906002)(5660300002)(356005)(1076003)(6666004)(82310400004)(86362001)(36756003)(316002)(6916009)(26005)(7696005)(4326008)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:54:40.6726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be8629f-ca96-4a70-afd0-08d9bbf56059
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5240
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are a few places that this isn't checked that could potentially
be a NULL pointer access.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  3 ++-
 .../display/dc/dce110/dce110_hw_sequencer.c   | 21 +++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index ac2d4c4f04e4..8653b4b8bcfc 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -77,7 +77,8 @@ int rn_get_active_display_cnt_wa(
 		const struct dc_link *link = dc->links[i];
 
 		/* abusing the fact that the dig and phy are coupled to see if the phy is enabled */
-		if (link->link_enc->funcs->is_dig_enabled(link->link_enc))
+		if (link->link_enc->funcs->is_dig_enabled &&
+		    link->link_enc->funcs->is_dig_enabled(link->link_enc))
 			display_count++;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index abef132fa016..0d6dc329dddb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1827,17 +1827,16 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 			if (edp_link != edp_streams[0]->link)
 				continue;
 			// enable fastboot if backend is enabled on eDP
-			if (edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc)) {
-				/* Set optimization flag on eDP stream*/
-				if (edp_link->link_status.link_active) {
-					edp_stream = edp_streams[0];
-					can_apply_edp_fast_boot = !is_edp_ilr_optimization_required(edp_stream->link, &edp_stream->timing);
-					edp_stream->apply_edp_fast_boot_optimization = can_apply_edp_fast_boot;
-					if (can_apply_edp_fast_boot)
-						DC_LOG_EVENT_LINK_TRAINING("eDP fast boot disabled to optimize link rate\n");
-
-					break;
-				}
+			if (edp_link->link_enc->funcs->is_dig_enabled &&
+			    edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
+			    edp_link->link_status.link_active) {
+				edp_stream = edp_streams[0];
+				can_apply_edp_fast_boot = !is_edp_ilr_optimization_required(edp_stream->link, &edp_stream->timing);
+				edp_stream->apply_edp_fast_boot_optimization = can_apply_edp_fast_boot;
+				if (can_apply_edp_fast_boot)
+					DC_LOG_EVENT_LINK_TRAINING("eDP fast boot disabled to optimize link rate\n");
+
+				break;
 			}
 		}
 		// We are trying to enable eDP, don't power down VDD
-- 
2.25.1

