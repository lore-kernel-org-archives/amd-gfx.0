Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0178C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 22:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2554E10E1C7;
	Fri, 25 Mar 2022 22:55:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8902310E1C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 22:55:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv4g3cbnat4F43uSZR2hGHAQjDpo2PfspsEi8SNBjNndHbbQOgBYvl7Kwxn3SIReWgFu37zq74NZFxZBOoKvhQJv/eBS1RDo1cRXVary3L+quFfGVmPY0H9PQVcDepCAeA1eaFF8mcmFz9/DA8rB3uHjqWNOeiUfO8puAsGbJUGNDDUwFvKh6Xt9Woy16LvwHaDNkBfNwWMc6pHGbTnAQbe8BbfrxEF2BP/LxWZ6bGnrqSk58J6aLRGqJQe1lNUaQuV1xue5QmyaPLND/Nyby+67S6uNdvTXj0hSG0YR/7Y8PILYBRRVf2LC3o0qYuhDZYBhGEu6Rh3uREGdI92huw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nv27kFqdjJ9DVTIWNvIhXxilTEmp7SlDocSzHYs4k5k=;
 b=fijhbDBrJl9IyxJlqR6NZcif7wmcrP5GoscyOWKlMjBUbsmDBC2qw8DrYfU/5pw7/yfayeP54XjIFa+GujEKHX2ycaIs8nx/JKQwQRSSF5jdum2aaiYHVv40Lj02UT6Z4MOEvCKPViYfWjBqQonfK5ToYhlfq1q4KGVwucT7KpDN3eXDoEhR6D1ebxbXUK3A1TMQ+cawT3U1HyBvFvIvcJy7U3/QDlX23zMgdxzPIdr3u44yLZtNPscmGMn5nx/3bZEETuZd/Gnd37gNu9fl8LPHynhBzEPCbrIHPNQ25z3v4OsDtwDHSKvdI2p7JjjDM2KHEBkXqZ+RAq0fzNPxng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nv27kFqdjJ9DVTIWNvIhXxilTEmp7SlDocSzHYs4k5k=;
 b=k08i4a+iucSrDbcB/hDd5cdS2G1VNg+IC4hIPsI1Hnr69hA2GE8+U7YrfsxdyGARTVS/RZXZ3vd6aFFbfQPjZ3M09s6noWoRJ3EmFgvV8N69Al5VW34sPUPEpuNkgk0tGtVgxP/hw2ru/H8208BBr5b+YoYxDsoT3NhOrkRchVc=
Received: from MW4PR03CA0323.namprd03.prod.outlook.com (2603:10b6:303:dd::28)
 by BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 22:55:27 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::52) by MW4PR03CA0323.outlook.office365.com
 (2603:10b6:303:dd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 22:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 22:55:25 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 17:55:22 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/16] drm/amd/display: Set fec register init value
Date: Fri, 25 Mar 2022 16:53:49 -0600
Message-ID: <20220325225402.469841-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325225402.469841-1-alex.hung@amd.com>
References: <20220325225402.469841-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d30415b-89df-42ec-db4c-08da0eb28d2a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5145:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB51452FF8599FA787C84F5793F71A9@BN9PR12MB5145.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ecB1lXPF8WIvKCXADbeI1koAIA0A26Vb3wrIY9p6cSV6U4/RhrJKWXlWORSCjdYKcUXtdI4BeL4JjjEWK5SLQgA0nug4Iq1Ns+bXwOvgwFnvkWuuPNuQXbd4Np6fhon/hL0si/zwGSfnOfaQOqG+11cQ/CxBvzpHf3OOR1zIfpIt6d5+e38CPOBUfis1wgh/mTlGa23dKUplXF4CrfDhPBrwXUfYdONdT9EEH7Nt+JLkS8syNqValGZNNo4+qSEszZONtHLrMA/VDN/D2aVf7sfRIft16pvtasOm2NH0llIRY6pAl+kcF/zmI9izTYPhP8jQUZOXX4RrvEVARfqnoAi6Slg5hfPYh5gGDSgVg7T6IkkN1ZjxmIUmax9mTijXZp+OPFpWlUxa7l90T5l092dYucNVLKuWc69H/OFO0q60hyJLO9YBftXOe6QFYP234aPvZeCcLzp6JFNi9wpxNoIxhnQM6wqLIM6+O7UkiOYW1AKw4aSeuO+GiJ8mNajwkXDiC5jS2xAzfJZGJIOGUwJ8u7QOsZ6mAdkCFMnihovCJZZYhydbrO5DJrLT91ghXtX10pM8LnqZN0tl6IjORNyt9+Tnm/jWo/lmmIwZvVq0UgE8/dTtwUo3hlrHz2AVltlCoj1yJnEZXiXqvBFBgdHQ5v4n23zaWlkaIDEvB1fLiZiqRFYQlx06Niu7PBY84elMhtEZoLLGLcRCLo0csw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(54906003)(336012)(316002)(36756003)(6916009)(70206006)(16526019)(4326008)(8676002)(81166007)(356005)(426003)(186003)(26005)(86362001)(40460700003)(6666004)(7696005)(1076003)(2906002)(70586007)(2616005)(44832011)(82310400004)(508600001)(83380400001)(36860700001)(5660300002)(47076005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 22:55:25.9991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d30415b-89df-42ec-db4c-08da0eb28d2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5145
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
Cc: stylon.wang@amd.com, Jingwen Zhu <Jingwen.Zhu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jingwen Zhu <Jingwen.Zhu@amd.com>

[Why]
We don't include this eDP FEC init on fastboot.

[How]
Set the fec to init value when stopping driver &get the fec register value to check should enable FEC.

Co-authored-by: Jingwen Zhu <Jingwen.Zhu@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Jingwen Zhu <Jingwen.Zhu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 26 +++++++++----------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  6 ++++-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  6 ++++-
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index bbaa5abdf888..c7c4d9867c52 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4683,22 +4683,20 @@ bool dc_link_is_fec_supported(const struct dc_link *link)
 
 bool dc_link_should_enable_fec(const struct dc_link *link)
 {
-	bool is_fec_disable = false;
-	bool ret = false;
+	bool force_disable = false;
 
-	if ((link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT_MST &&
+	if (link->fec_state == dc_link_fec_enabled)
+		force_disable = false;
+	else if (link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT_MST &&
 			link->local_sink &&
-			link->local_sink->edid_caps.panel_patch.disable_fec) ||
-			(link->connector_signal == SIGNAL_TYPE_EDP
-				// enable FEC for EDP if DSC is supported
-				&& link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT == false
-				))
-		is_fec_disable = true;
-
-	if (dc_link_is_fec_supported(link) && !link->dc->debug.disable_fec && !is_fec_disable)
-		ret = true;
-
-	return ret;
+			link->local_sink->edid_caps.panel_patch.disable_fec)
+		force_disable = true;
+	else if (link->connector_signal == SIGNAL_TYPE_EDP
+			&& link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.
+			 dsc_support.DSC_SUPPORT == false)
+		force_disable = true;
+
+	return !force_disable && dc_link_is_fec_supported(link);
 }
 
 uint32_t dc_bandwidth_in_kbps_from_timing(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index ad757b59e00e..911c5d103c64 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1493,8 +1493,12 @@ void dcn10_init_hw(struct dc *dc)
 
 		/* Check for enabled DIG to identify enabled display */
 		if (link->link_enc->funcs->is_dig_enabled &&
-			link->link_enc->funcs->is_dig_enabled(link->link_enc))
+			link->link_enc->funcs->is_dig_enabled(link->link_enc)) {
 			link->link_status.link_active = true;
+			if (link->link_enc->funcs->fec_is_active &&
+					link->link_enc->funcs->fec_is_active(link->link_enc))
+				link->fec_state = dc_link_fec_enabled;
+		}
 	}
 
 	/* Power gate DSCs */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 4be228680909..b57f657c4e44 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -188,8 +188,12 @@ void dcn31_init_hw(struct dc *dc)
 
 		/* Check for enabled DIG to identify enabled display */
 		if (link->link_enc->funcs->is_dig_enabled &&
-			link->link_enc->funcs->is_dig_enabled(link->link_enc))
+			link->link_enc->funcs->is_dig_enabled(link->link_enc)) {
 			link->link_status.link_active = true;
+			if (link->link_enc->funcs->fec_is_active &&
+					link->link_enc->funcs->fec_is_active(link->link_enc))
+				link->fec_state = dc_link_fec_enabled;
+		}
 	}
 
 	/* Enables outbox notifications for usb4 dpia */
-- 
2.35.1

