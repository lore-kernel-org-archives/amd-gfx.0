Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAA2C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE20600D4
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CDE20600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C9B6E106;
	Sun, 24 Oct 2021 13:32:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04A616E106
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNb5wrySW7I/7/F5nz29AO6LU4d2e7Ws8cy/ONPTGV2vK13g/8TlXT3ofdCFi0ruATWpaWQW5XrYZZsJRrmTynClM9NqevYZ7meAn0ssQapShTgRpRd2bymwQwy70ccDNSykKaD9xBpfb/351n89neD7w6q/miJrzqwCQoCx4VIHxnZx03GUh4rJ+rEb0N1okFSaw7KuIlLZYXKUgD1U6zh9CZAWiAuGP0UoWo/Nwh6gEkgjKTlDSh0Ugpay7shTLSfugbo9ALgtyzxNxWTJVQ19MJR88+7ykTef6eHUNbrS/7ljigkjUEv2/w4d2eIzTfynuM1t/5AP2m2AKefTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQVfjHQOPq058qVENanUuEl97uv2wVExoHgncFl7eHY=;
 b=E2NrvH2eQsFf6WPzfSHYa4qBoW9trF4fu8CrRCK3OM+o8Ix0pkQ26wk4pfBlCNgpA2G4PgQbD166C8jDlDMgIcQORbeMCudgQK+noaeqrqUiukwN69oVu1aIY3mRZkYPu2PDniISui7wMPMPOLZKAjSK2JIyXc/u12Kpni66+lP8ddpVdKJeYrzlj3PhbGXHX7elwGZtJdaaHnm5EceJxD/VUaPfGeP2CzrWVGcTXYJos/JKGBvYa6sovY1+JsIskZmgVBPoYuw43gDY5xb2SnuHaCyDhbs5JkJ2eITaAFee8LRXgVwtHPD7AQmJtYF0kqbrmByL29vHCv9axZZMmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQVfjHQOPq058qVENanUuEl97uv2wVExoHgncFl7eHY=;
 b=11dHMGrOa77/Jn8ytjg2SgNAAF2mQJTpELeF7nUPV0VTcfsHWfIuz8zK1Fg0fDr8I0EKmDoHZv4rzKFjmYOlUpV5bRK00RFnfI6kwL7X8e6k4YEbBc4HQ2SxYRj4viuyAOHWz/GKN/JRJ6rcnUBKYo9h3hFfzlFKAI3kvbNxGYg=
Received: from MW4PR04CA0066.namprd04.prod.outlook.com (2603:10b6:303:6b::11)
 by BN6PR12MB1811.namprd12.prod.outlook.com (2603:10b6:404:fe::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Sun, 24 Oct
 2021 13:32:28 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::ab) by MW4PR04CA0066.outlook.office365.com
 (2603:10b6:303:6b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:27 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:21 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, George Shen <george.shen@amd.com>, Wenjing Liu
 <Wenjing.Liu@amd.com>
Subject: [PATCH 12/33] drm/amd/display: Implement fixed DP drive settings
Date: Sun, 24 Oct 2021 09:31:20 -0400
Message-ID: <20211024133141.239861-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7493e976-6634-472a-a786-08d996f2b8e4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1811:
X-Microsoft-Antispam-PRVS: <BN6PR12MB181145462B4BBFEBB62B009D98829@BN6PR12MB1811.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NzigCB7Kk9J9HeiprFJcZn3oWI9yMngW2KmaWqUo9uExwigtxkGFD4wDeSQv2uCbmbmw2wrZHohWiEr5T/ta5l2jikeYD089XYYtP18wGnjtqU2X24wu3Rd4S4N+Mhti8Hgr5b+c8UNM3juXx8WgQy5vJTd1YUVqbwKJSQE5k9Pub7vRg2Nczf8MZtReFpV5jC5/+uS0Xs+qaXif5Q1ai4TvTpWH8SkwDpx06t2G64QGD5YzvJTl2E4XCser5gKuHWXsNAJI8Z3NTFXwIm5hl5OK+79Lsca49bEECu9nHlMgx7KEjen77Go9p5QitPCSIbEbU62J/FycLV6ME6GXj+IbmRj1KU3Corz+g1fF0FYH7QoSpxVpdhGiSqZn3rl45Mlok2zhTOOnShuctoU72CRyTMMknPiUHCqL1jkJhZdBBMQ+mf01gPk+W7z8Qo/xYpxdZx4R67WaVAkLiKO5MK1am95HBKh9HUs2NE/2JJxBvpUqGS7bh8TbRkPl4gfWAir6bgl1i1qdvQ5lLZ9hAxuXAPIKEfEt7icgohucCqW1r8fwU1yD4OAT1+5B8TRt9cpZUV+oDlBCzmzsTTAVqYc8qBwJjNTUZ2EQZs+n1BcZL44LZVEG1iwuhp9hNb1Ud8YBhX1IrlBV1abvWME1mzmabX+bmyEef1karVg/AXu1hlEVhRa1vDXNbfEIzm/oo4+2zxW7FZ+SLZHIIIkpjrUrf6WchP2iOAts0YWFbhU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(8936002)(8676002)(82310400003)(1076003)(70586007)(508600001)(2906002)(83380400001)(5660300002)(316002)(54906003)(81166007)(356005)(26005)(36756003)(186003)(16526019)(4326008)(426003)(336012)(6916009)(36860700001)(47076005)(2616005)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:27.6331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7493e976-6634-472a-a786-08d996f2b8e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1811
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

From: George Shen <george.shen@amd.com>

[Why]
Currently there are use cases that require DP link to maintain fixed VS
and PE in HW regardless of what the sink requests. BIOS integrated info
table will specify whether we need to use the fixed drive settings, and
the drive settings to use.

[How]
Implement changes to parse the integrated info table and set the fixed
drive settings accordingly.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c        | 2 ++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c             | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c          | 8 +++++++-
 drivers/gpu/drm/amd/display/dc/dc_link.h                  | 3 +++
 .../gpu/drm/amd/display/include/grph_object_ctrl_defs.h   | 1 +
 drivers/gpu/drm/amd/display/include/link_service_types.h  | 6 ++++++
 6 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index c17732fba039..a4bef4364afd 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2321,6 +2321,8 @@ static enum bp_result get_integrated_info_v2_2(
 
 	info->ext_disp_conn_info.checksum =
 		info_v2_2->extdispconninfo.checksum;
+	info->ext_disp_conn_info.fixdpvoltageswing =
+		info_v2_2->extdispconninfo.fixdpvoltageswing;
 
 	info->edp1_info.edp_backlight_pwm_hz =
 	le16_to_cpu(info_v2_2->edp1_info.edp_backlight_pwm_hz);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index c278d134c44b..b36678669283 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1660,6 +1660,14 @@ static bool dc_link_construct_legacy(struct dc_link *link,
 				DC_LOG_DC("BIOS object table - ddi_channel_mapping: 0x%04X", link->ddi_channel_mapping.raw);
 				DC_LOG_DC("BIOS object table - chip_caps: %d", link->chip_caps);
 			}
+
+			if (link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) {
+				link->bios_forced_drive_settings.VOLTAGE_SWING =
+						(info->ext_disp_conn_info.fixdpvoltageswing & 0x3);
+				link->bios_forced_drive_settings.PRE_EMPHASIS =
+						((info->ext_disp_conn_info.fixdpvoltageswing >> 2) & 0x3);
+			}
+
 			break;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 3819eb58a9e5..ec269b7e91c3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1661,7 +1661,13 @@ static void override_training_settings(
 	if (overrides->ffe_preset != NULL)
 		lt_settings->ffe_preset = overrides->ffe_preset;
 #endif
-
+	/* Override HW lane settings with BIOS forced values if present */
+	if (link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN &&
+			link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
+		lt_settings->voltage_swing = &link->bios_forced_drive_settings.VOLTAGE_SWING;
+		lt_settings->pre_emphasis = &link->bios_forced_drive_settings.PRE_EMPHASIS;
+		lt_settings->always_match_dpcd_with_hw_lane_settings = false;
+	}
 	for (lane = 0; lane < LANE_COUNT_DP_MAX; lane++) {
 		lt_settings->lane_settings[lane].VOLTAGE_SWING =
 			lt_settings->voltage_swing != NULL ?
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index eaff496690af..16c6dc5c3bfb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -178,6 +178,9 @@ struct dc_link {
 
 	struct psr_settings psr_settings;
 
+	/* Drive settings read from integrated info table */
+	struct dc_lane_settings bios_forced_drive_settings;
+
 	/* MST record stream using this link */
 	struct link_flags {
 		bool dp_keep_receiver_powered;
diff --git a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
index 792652236c61..dd974c428d23 100644
--- a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
+++ b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
@@ -328,6 +328,7 @@ struct integrated_info {
 
 		uint8_t gu_id[NUMBER_OF_UCHAR_FOR_GUID];
 		uint8_t checksum;
+		uint8_t fixdpvoltageswing;
 	} ext_disp_conn_info; /* exiting long long time */
 
 	struct available_s_clk_list {
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 9ffea7b40545..9a16fc855254 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -117,6 +117,12 @@ struct link_training_settings {
 	bool enhanced_framing;
 	bool allow_invalid_msa_timing_param;
 	enum lttpr_mode lttpr_mode;
+
+	/* disallow different lanes to have different lane settings */
+	bool disallow_per_lane_settings;
+	/* dpcd lane settings will always use the same hw lane settings
+	 * even if it doesn't match requested lane adjust */
+	bool always_match_dpcd_with_hw_lane_settings;
 };
 
 /*TODO: Move this enum test harness*/
-- 
2.25.1

