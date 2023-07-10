Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB7CEB64DA
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 19:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E63D10E2C6;
	Mon, 10 Jul 2023 19:27:55 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF25310E2C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 19:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJARrfJglr5M0bCEJJBl94CBkMQ4n41LvZdyiBNsT1MiGKwCkBf4TGe/TlSuzt1sYDSW9p9auPtbM0pNowFNxYTW9/EzgdboflVshnTeAJgjG3IgotdQgLvGcKqhLBv0xdcc6TPBg46MJcw9ITiU8biIHcL08yx26OS5Oi7piSqkHSzFAwzIjn8dbII1J7WYxazGtnFZn9iUnCkLglGqjfuNdr14WA3cS7GxkDH4T/t/mehLh3bWgP4ToVQZkvz2YTUlQJgIZuHMOpet5MWpCZfK3Y2VOayYsRgFedhjGgORRsg8I7misy7sszvI3n+EAR8+12YE2l0yR2uJx8eeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ti1Nll/53fcInDkOHOnYwm9uLP7pdkhcjXUN39SM3s=;
 b=Zry02JhZkAubNKqX/pJSOHD/bb8Ser/uT8hp3FzrNHxibNr6kmu8Q0nfCRPKFSrfny/ba8R4ipxpsx0Jo6g8Groy8nrLbPciPpcvQhvjNF3W3qCYk+VaEZI0wmavZdWfj7oKEpLqZ9SMsLJ4+5Dk3+yU73YVWekE0Gv8IcM2bPtZMCsK/wFhW+s27UDVt7p1x07FiCbgV9I4+pcEKQUTur3XO+4IY7YIRo2shTqeiA2R2/4vVEFexusVrGkWvnnEDIUADKx+A8sSHvc80YykjrUQ6v02gCbOxA1aWVsykdFYp6pr9uWwEr7KOjuTbwai/Iak+2n77Uty7S0T/SQYPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ti1Nll/53fcInDkOHOnYwm9uLP7pdkhcjXUN39SM3s=;
 b=1jOKpuJWwRgkDjBSTSGSR3IQ2cLnBaVqj294JC32zEtKumMEQZYPtVrehH2mUm0hzTcadcplnzraW7ZYYcG7okXye20oyQQl7drgfXCfXCGKzrwA8jU7Ay5Y4FdU3k7LeQMC3nXj4MH/URqqcMLKTI6DqAmuMbE4YAQCVnj8X2U=
Received: from BN9PR03CA0418.namprd03.prod.outlook.com (2603:10b6:408:111::33)
 by SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 19:27:41 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::3a) by BN9PR03CA0418.outlook.office365.com
 (2603:10b6:408:111::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 19:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 19:27:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 14:27:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 14:27:40 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 10 Jul 2023 14:27:40 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 09/10] drm/amd/display: Handle Replay related hpd irq
Date: Mon, 10 Jul 2023 15:27:32 -0400
Message-ID: <20230710192733.1344403-10-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
 <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1a1176-7e49-4c76-f673-08db817bba87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kz5U/ar7jGTECzwK9N9bgN7pyUh0uvrPDrGFDDmT+1jzi5J01Egov56oiUR9g27dWYK17/IjSFqWGBgScGIJIc+DTN3wUrB280KItO5XroSsTGeAJURS0drKAWMRfCw23i73keJ5TGCeHyWppa8vY2A3uHnYeOw2pU2yWsUk3VZ6CsK36ONno4SCVzXZaa/ESySqqplbMAZZQMhyo81LisXFonJ1q8uy7w7QfBRKmEjM/1SV+QsoZB7dh1qQey8cTp2dNCJhyUE7wLhCSsyrp9VNyOuZFrrpeyeuT5wY9+kDTOIg5EC8E1HHrJ4xX616G1/+H+QYXo2wKeQ29qk8cYdSveGclj8J8UV+zzVqAGjsyhFv6avKZJp6w4kC1EYoeBJR1YCGnktxslktdsSHXQ8xe548rs16lTM9J6pBghv9GM8xKEaV0eJ7sodjXVGsHUaC8nrJWTZKlfdnucta0ibDjwoU8m88iFfBWBJc+K5f0Yc/CLoHNAGmlHuaBGhWmRoDRfGuSx8jiBmyAioTtWktvNs7cS2tsC0OBFV8Ytm0Kw+N5s4Ngyl2sTO3VgB0f836e2BQ8h7oC/2HehGM/gOWXHZrHr/ODLKP4qOnpUTA+yfxZqc2LjFTtFGdBZd6dK324xLms1OxRoN4k974MOn78mPY3BEdH2s6P4PGicjzPNRC78m6VqdlKDybqPc+w8UsiyVP4cq9yB1DSq0tn5DlvwIF2uqtvBF3U8roNr6xBdV3UBs81L/qFstB3KJzKKF4vfy+BdQGMuF84mFrxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(6666004)(7696005)(478600001)(110136005)(26005)(186003)(1076003)(336012)(70206006)(2906002)(82310400005)(41300700001)(316002)(4326008)(5660300002)(6636002)(70586007)(8676002)(81166007)(82740400003)(8936002)(356005)(86362001)(40460700003)(36756003)(47076005)(36860700001)(2616005)(83380400001)(426003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 19:27:41.3021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1a1176-7e49-4c76-f673-08db817bba87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Handle replay related hpd irqs

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../dc/link/protocols/link_dp_irq_handler.c   | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index ba95facc4ee8..a5605cf4449e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -175,6 +175,68 @@ static bool handle_hpd_irq_psr_sink(struct dc_link *link)
 	return false;
 }
 
+static bool handle_hpd_irq_replay_sink(struct dc_link *link)
+{
+	union dpcd_replay_configuration replay_configuration;
+	/*AMD Replay version reuse DP_PSR_ERROR_STATUS for REPLAY_ERROR status.*/
+	union psr_error_status replay_error_status;
+
+	if (!link->replay_settings.replay_feature_enabled)
+		return false;
+
+	dm_helpers_dp_read_dpcd(
+		link->ctx,
+		link,
+		DP_SINK_PR_REPLAY_STATUS,
+		&replay_configuration.raw,
+		sizeof(replay_configuration.raw));
+
+	dm_helpers_dp_read_dpcd(
+		link->ctx,
+		link,
+		DP_PSR_ERROR_STATUS,
+		&replay_error_status.raw,
+		sizeof(replay_error_status.raw));
+
+	link->replay_settings.config.replay_error_status.bits.LINK_CRC_ERROR =
+		replay_error_status.bits.LINK_CRC_ERROR;
+	link->replay_settings.config.replay_error_status.bits.DESYNC_ERROR =
+		replay_configuration.bits.DESYNC_ERROR_STATUS;
+	link->replay_settings.config.replay_error_status.bits.STATE_TRANSITION_ERROR =
+		replay_configuration.bits.STATE_TRANSITION_ERROR_STATUS;
+
+	if (link->replay_settings.config.replay_error_status.bits.LINK_CRC_ERROR ||
+		link->replay_settings.config.replay_error_status.bits.DESYNC_ERROR ||
+		link->replay_settings.config.replay_error_status.bits.STATE_TRANSITION_ERROR) {
+		bool allow_active;
+
+		/* Acknowledge and clear configuration bits */
+		dm_helpers_dp_write_dpcd(
+			link->ctx,
+			link,
+			DP_SINK_PR_REPLAY_STATUS,
+			&replay_configuration.raw,
+			sizeof(replay_configuration.raw));
+
+		/* Acknowledge and clear error bits */
+		dm_helpers_dp_write_dpcd(
+			link->ctx,
+			link,
+			DP_PSR_ERROR_STATUS,/*DpcdAddress_REPLAY_Error_Status*/
+			&replay_error_status.raw,
+			sizeof(replay_error_status.raw));
+
+		/* Replay error, disable and re-enable Replay */
+		if (link->replay_settings.replay_allow_active) {
+			allow_active = false;
+			edp_set_replay_allow_active(link, &allow_active, true, false, NULL);
+			allow_active = true;
+			edp_set_replay_allow_active(link, &allow_active, true, false, NULL);
+		}
+	}
+	return true;
+}
+
 void dp_handle_link_loss(struct dc_link *link)
 {
 	struct pipe_ctx *pipes[MAX_PIPES];
@@ -327,6 +389,10 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 		/* PSR-related error was detected and handled */
 		return true;
 
+	if (handle_hpd_irq_replay_sink(link))
+		/* Replay-related error was detected and handled */
+		return true;
+
 	/* If PSR-related error handled, Main link may be off,
 	 * so do not handle as a normal sink status change interrupt.
 	 */
-- 
2.25.1

