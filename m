Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7682DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 22:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10A9510E20F;
	Fri, 25 Mar 2022 22:57:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A3710E20F
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 22:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noQHPAM3kav5tVPpj10CbnzHTLu6U2sN0TsCpEzfH3I8Zn9TN2iAZjKCXmIHtTVZPiaGfdLimA9mRaQa2WGWl+hmaE52XXJGFj6nFmtjufYam50stJX10o/omiGpb43S2IAEinusCuLYzsRGFmyGk3lp43YV3CaAZ0BwmyjZDFDzVnO71W+jHFL8nWDBm3xU7CE3fY9mDtm5usI8MynWFbp50m4/yxmnbz6Ua2MZNIBKWPprRSn1obattjaC8zY1lgFLQjFU0ElBr5AJQLqBtSB5hg1eVfKOGFkaqVx3x1bPxymYeTkPIW9qBcQGmiaR3GtNBdp0fQSAc6NX5qB2ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lI9CG/1vbkUd64c0aQVpPpA1CUs16UsQM1yDEug4VM=;
 b=ogi1Kk3+rw/HhJy7QgMNtWuNUo1rS9iCdI0UzXe7HN/Eo3qAnUJCfiDWZA6jV1r35sCSFN0l6ZZavkFI9nxIUu1iNZ9xfPGfwBNJJc3njL82QEPdbvnMF1UIAtCb7e9mrHRyexKpwBDd26E2UqPehykujsxzVEYYZwwDRYYb9bR047ADvn8jGipcbmX+yO/7WD7d6PY8nW0m6wat7VrPyVc51R4l0p8EUaUvpksZj9cOFkAsz1jGQtCmOiIFY/r95PRRUbxKWgTXHmAPtFpbO3X7aB3GzPLcKbQYr7csqs8AT7YeZwFyAfDp3ArhkKYkiz4KhUDKIV0mi+zkNkRNwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lI9CG/1vbkUd64c0aQVpPpA1CUs16UsQM1yDEug4VM=;
 b=yydyfswH1w727fv5NXrh9mlM62fIetki9u5weF9G7SxFvn5Bq2iuKpGz4aUTTAB1SB/V1dXKs10woJEu71RHErGw/q2t8bS+42AItYJlf75TCI+U2t73XCd/e5yvxyqv0u3k26VEwsyEts2YfXlqMZTRbCde8I3GitXjgHZJ53M=
Received: from MW4PR03CA0353.namprd03.prod.outlook.com (2603:10b6:303:dc::28)
 by BY5PR12MB4904.namprd12.prod.outlook.com (2603:10b6:a03:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 22:57:02 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::54) by MW4PR03CA0353.outlook.office365.com
 (2603:10b6:303:dc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 22:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 22:57:01 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 17:56:58 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/16] drm/amd/display: Add work around for AUX failure on
 wake.
Date: Fri, 25 Mar 2022 16:53:56 -0600
Message-ID: <20220325225402.469841-11-alex.hung@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3ecde31f-75fe-4812-95ca-08da0eb2c5df
X-MS-TrafficTypeDiagnostic: BY5PR12MB4904:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4904A681325CC33AE8362B60F71A9@BY5PR12MB4904.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g9MetyesEcWrkAwrmDEoWpaZ+Utl8rlXmMayIO1x65xp+nE5AOGJSYaDAnUwQYYIWzHymcto3OArA+Xy7Ae8DewfJqur3hKMS3Saih3NJIdCMQiMUV1jUdn0FkkkJ1zOh0v2RHOUMf6/ViNqD5nYObsG0PGQrtkHanyUFp8DCCDbNPVJn41Gm1a5idSmAdGfrl3kfmae6qv7CCh7QSymeYy7vy/Ti07MrLYkQMpRwYz6WBR+yEACowAgwYQOtKPQ83oR8LQUwKJB3jZv/Gn9gPbxKDd681eWM2KuNyAe2JGxTOhbKHSxEsSBHV2zsDdM76gonzS3ChU4cVj6ktZ+9vpR3Nwch5jXtonblsONUYV6F4FBC7Ug8ZOKsx9cAoGJd7Cm6mKHCt8u5Xg7VXr8cI/oCuOGvZ/PVzsdLp4yXsY300lnGwhAZIBSqIrDDW6GtMMDYjeE/9XAtoNP9r2rwJlNF1tsDg4RrtMoXxu1xihJ1nANVTDT94Uwtqm/5R8HVCQ2v90IaZQQ+1H9FlZlQjE8i21bR5LjzaUzXUn76gyNgELRhwMwJEbbjOzXxQfBpSEPWLhdH9G+2fXmp/y4m20zLy8GYc22H1lE9k1E3PdUPjtjAxPwgXRIn61m9di7HTxiAfJ+Mg+7nLRuwObIv+LrjzCuquEaDcTRUyOgZy5JCHP0+GfxtHozMYOeB7/663z7LPLusqgGEPi35AEzGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8676002)(70586007)(356005)(83380400001)(26005)(316002)(6916009)(54906003)(47076005)(508600001)(7696005)(36756003)(4326008)(81166007)(70206006)(82310400004)(86362001)(336012)(2906002)(186003)(40460700003)(5660300002)(36860700001)(1076003)(2616005)(426003)(16526019)(8936002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 22:57:01.1203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ecde31f-75fe-4812-95ca-08da0eb2c5df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4904
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
Cc: stylon.wang@amd.com, Mustapha Ghaddar <Mustapha.Ghaddar@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Jimmy Kizito <Jimmy.Kizito@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
When waking from low-power states, a DP sink may remain unresponsive to
AUX transactions.

[How]
Try to toggle DPCD SET_POWER register repeatedly (up to a maximum
timeout value) until DP sink becomes responsive.

Reviewed-by: Mustapha Ghaddar <Mustapha.Ghaddar@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 59 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  1 +
 2 files changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 351081f574cb..e4df81dc1dc2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5216,6 +5216,62 @@ static void retrieve_cable_id(struct dc_link *link)
 				&link->dpcd_caps.cable_id, &usbc_cable_id);
 }
 
+/* DPRX may take some time to respond to AUX messages after HPD asserted.
+ * If AUX read unsuccessful, try to wake unresponsive DPRX by toggling DPCD SET_POWER (0x600).
+ */
+static enum dc_status wa_try_to_wake_dprx(struct dc_link *link, uint64_t timeout_ms)
+{
+	enum dc_status status = DC_ERROR_UNEXPECTED;
+	uint8_t dpcd_data = 0;
+	uint64_t start_ts = 0;
+	uint64_t current_ts = 0;
+	uint64_t time_taken_ms = 0;
+	enum dc_connection_type type = dc_connection_none;
+
+	status = core_link_read_dpcd(
+			link,
+			DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV,
+			&dpcd_data,
+			sizeof(dpcd_data));
+
+	if (status != DC_OK) {
+		DC_LOG_WARNING("%s: Read DPCD LTTPR_CAP failed - try to toggle DPCD SET_POWER for %lld ms.",
+				__func__,
+				timeout_ms);
+		start_ts = dm_get_timestamp(link->ctx);
+
+		do {
+			if (!dc_link_detect_sink(link, &type) || type == dc_connection_none)
+				break;
+
+			dpcd_data = DP_SET_POWER_D3;
+			status = core_link_write_dpcd(
+					link,
+					DP_SET_POWER,
+					&dpcd_data,
+					sizeof(dpcd_data));
+
+			dpcd_data = DP_SET_POWER_D0;
+			status = core_link_write_dpcd(
+					link,
+					DP_SET_POWER,
+					&dpcd_data,
+					sizeof(dpcd_data));
+
+			current_ts = dm_get_timestamp(link->ctx);
+			time_taken_ms = div_u64(dm_get_elapse_time_in_ns(link->ctx, current_ts, start_ts), 1000000);
+		} while (status != DC_OK && time_taken_ms < timeout_ms);
+
+		DC_LOG_WARNING("%s: DPCD SET_POWER %s after %lld ms%s",
+				__func__,
+				(status == DC_OK) ? "succeeded" : "failed",
+				time_taken_ms,
+				(type == dc_connection_none) ? ". Unplugged." : ".");
+	}
+
+	return status;
+}
+
 static bool retrieve_link_cap(struct dc_link *link)
 {
 	/* DP_ADAPTER_CAP - DP_DPCD_REV + 1 == 16 and also DP_DSC_BITS_PER_PIXEL_INC - DP_DSC_SUPPORT + 1 == 16,
@@ -5251,6 +5307,9 @@ static bool retrieve_link_cap(struct dc_link *link)
 	dc_link_aux_try_to_configure_timeout(link->ddc,
 			LINK_AUX_DEFAULT_LTTPR_TIMEOUT_PERIOD);
 
+	/* Try to ensure AUX channel active before proceeding. */
+	status = wa_try_to_wake_dprx(link, LINK_AUX_WAKE_TIMEOUT_MS);
+
 	is_lttpr_present = dp_retrieve_lttpr_cap(link);
 	/* Read DP tunneling information. */
 	status = dpcd_get_tunneling_device_data(link);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index ab9939db8cea..44f167d2584f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -33,6 +33,7 @@
 #define MAX_MTP_SLOT_COUNT 64
 #define DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE 0x50
 #define TRAINING_AUX_RD_INTERVAL 100 //us
+#define LINK_AUX_WAKE_TIMEOUT_MS 1500 // Timeout when trying to wake unresponsive DPRX.
 
 struct dc_link;
 struct dc_stream_state;
-- 
2.35.1

