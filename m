Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A8DC46CA0
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A3D110E886;
	Fri,  1 Dec 2023 13:28:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20CA810E89B
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feQxMow5dWci4YEQJ63ZpEoUCt8X/fAKq7UFKMmxCaDzblSNnHhQj5Gdkm8O6bbHhmENUZC9nA6Nqvt5+9iJabL5fr9Nfv7SiPapAzYB01JOpH6gg78w2w9JikB1hl5uvJIFT5VRUUGeiaP53ul2BXp/qD0iyykCDQjqxGKE4KESuTu9Y3WXKwitJ7N9zGFVX7slIjKn1f3L/RlsEZa7+2w9HeZfsrrUxF/83wvCRPWJc7gjOSRnrmys+TimqI7mo7WMGiJTpYkxfrKj1GtlJ/B/PpduFsGAjrKXpB0x3d7W8HcKnOeZnX/1oTZKarV5pVKMRrrthvTYJx8u0A1j9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XM7seATlji3tuZhUU8KfBCXR95Sy/udgI7q5gIq6InQ=;
 b=Ce2tKHBfmbv40NGgF6h4bag/w6uWuJ8Ne4ZEprr0h9Vyh8AlVa3itT5hrpvlCC5ksZp5HMk2eg8XuvdVtObys2jjP/J9Wb042KeXfdvT9GhaH8jm6qdMF6hXZZEpdAnyvKCLRRhDZO6o6FpwU0j7JWy/b8lHrdi/xrHRg4znl8/M//MxqmyuRoskJ1mGQqyl8FI/WYFUrORueOL4lp4sPGmApnoLPJNIJVS2zVjB+n8WSjUVtftxKbtjJYHmcZwn2WwNA2YWnN/RxAM4BgyFrbFEM42CPcPZ+XPMkbidy82t8hF1F+qMe6rhtPAt2f75HlEDbvvS9h2vC1+FZU0Gwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM7seATlji3tuZhUU8KfBCXR95Sy/udgI7q5gIq6InQ=;
 b=S1gHkjFi7KdBHP+p0SJDAbNVRY6dXfUfW5v5e4OUqzbnTL2pNEFYVxHAQtSbRCK90J+iHSGsgb/lijCLWrCMUWcNBKPJChmCmfbrFBn5sE6m9gV8oiiHI3IxjAD6WZFZWmA/v3Swip2riLqm8z/iKinda0P18GOAZsx1bBnQrzM=
Received: from CH0P221CA0039.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::21)
 by SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:28:22 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::64) by CH0P221CA0039.outlook.office365.com
 (2603:10b6:610:11d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:22 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:19 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/47] drm/amd/display: Skip DPIA-specific DP LL automation
 flag for non-DPIA links
Date: Fri, 1 Dec 2023 06:25:09 -0700
Message-ID: <20231201132731.2354141-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7124dd-8306-47c6-02b6-08dbf271640c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUesf3pAhk1eYmr4rlfXJQmssNhIKdp4tDKdndo82xpyupW5hoXa8g0ceseSU/1tzvLAAW4VhYoqYfJpGU+fchUo9JxBS8mxrs0WshYUsNAhLK+YPt0I6Dd5Ztm7qO/aLk5nRmtQ3QQwHc2zmOPCeYk/2R23qa5ImjK6xn9iQwFsh9jY8tCc8zUnVCOTD1DYcoFP+L7zMuMkBwO2KTdaryrdl99koMu/elnnbm2D7lRNqxlmW2TKveuHzmbmFZvq3NE2AQGDwMhBFdvRb/0soehS2dGvP87OyoEj1O0RWcfXp5aWZut2l7RC8EqaJxiHe3uCheKb8cqO3T3J/Cow4sKISCiUvQL7oL3YPOsNJGCb/ry6PGq/YUUWDHGFJP4cWoq/BsTqcsUSY0eUz9ayWirBOmfS5lC0UehyTo16Y8i5ZoG5Ko1clxA4nCnauo0TCDnoOQR7fzUlWUTdLmxt9ljRxYQ899ud0upTBHIkjetQJLnKwVOZQ39XJLZEqaw0GKZ1Szq0magk8fmbvZz5L6LEHcaGEOsMLqYhuOdk1lFZmSZJOkPavu4U4XepEZtsHx+CaBqnCCi5wzRWs2NE1NwyQvsFhiEYZnu20ZMOZPJhaaRmygn4tgg41JmtEwECGB/U1QqcQiLBzYUu/Mq96v19rnU6yeRjKedm0rViektPVREQqIkvnKZwXOL1WXGdtidDXIE/bEolORxDQQL1XdrnM4plXrk21uYaZ7sqvSTp5j1ZjbWoFD40ke3U/jEaSb9CuYiKe9zJm6aeCVjclg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(316002)(6916009)(54906003)(70206006)(70586007)(478600001)(40460700003)(6666004)(5660300002)(41300700001)(36756003)(2906002)(8676002)(8936002)(86362001)(336012)(426003)(2616005)(16526019)(26005)(4326008)(1076003)(40480700001)(356005)(47076005)(81166007)(36860700001)(83380400001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:22.6010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7124dd-8306-47c6-02b6-08dbf271640c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
The is_automated flag logic only applies to USB4 DPIA links during DP LL
compliance test automation. The flag should not be set for non-DPIA
cases.

[How]
Add check for DPIA link endpoint type before setting the flag. Also,
rename is_automated to skip_fallback_on_link_loss for clarity.

Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                       | 8 +++++++-
 .../amd/display/dc/link/protocols/link_dp_irq_handler.c   | 6 ++++--
 .../amd/display/dc/link/protocols/link_dp_training_dpia.c | 4 ++--
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index cf7f88b80390..35a654fa97ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1541,7 +1541,13 @@ struct dc_link {
 	bool is_dig_mapping_flexible;
 	bool hpd_status; /* HPD status of link without physical HPD pin. */
 	bool is_hpd_pending; /* Indicates a new received hpd */
-	bool is_automated; /* Indicates automated testing */
+
+	/* USB4 DPIA links skip verifying link cap, instead performing the fallback method
+	 * for every link training. This is incompatible with DP LL compliance automation,
+	 * which expects the same link settings to be used every retry on a link loss.
+	 * This flag is used to skip the fallback when link loss occurs during automation.
+	 */
+	bool skip_fallback_on_link_loss;
 
 	bool edp_sink_present;
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 0c00e94e90b1..ae271c830c9a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -265,7 +265,7 @@ void dp_handle_link_loss(struct dc_link *link)
 
 	for (i = count - 1; i >= 0; i--) {
 		// Always use max settings here for DP 1.4a LL Compliance CTS
-		if (link->is_automated) {
+		if (link->skip_fallback_on_link_loss) {
 			pipes[i]->link_config.dp_link_settings.lane_count =
 					link->verified_link_cap.lane_count;
 			pipes[i]->link_config.dp_link_settings.link_rate =
@@ -404,7 +404,9 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 
 	if (hpd_irq_dpcd_data.bytes.device_service_irq.bits.AUTOMATED_TEST) {
 		// Workaround for DP 1.4a LL Compliance CTS as USB4 has to share encoders unlike DP and USBC
-		link->is_automated = true;
+		if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+			link->skip_fallback_on_link_loss = true;
+
 		device_service_clear.bits.AUTOMATED_TEST = 1;
 		core_link_write_dpcd(
 			link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
index 4f4e899e5c46..e8dda44b23cb 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
@@ -811,7 +811,7 @@ static enum link_training_result dpia_training_eq_transparent(
 			/* Take into consideration corner case for DP 1.4a LL Compliance CTS as USB4
 			 * has to share encoders unlike DP and USBC
 			 */
-			if (dp_is_interlane_aligned(dpcd_lane_status_updated) || (link->is_automated && retries_eq)) {
+			if (dp_is_interlane_aligned(dpcd_lane_status_updated) || (link->skip_fallback_on_link_loss && retries_eq)) {
 				result =  LINK_TRAINING_SUCCESS;
 				break;
 			}
@@ -1037,7 +1037,7 @@ enum link_training_result dpia_perform_link_training(
 	 */
 	if (result == LINK_TRAINING_SUCCESS) {
 		fsleep(5000);
-		if (!link->is_automated)
+		if (!link->skip_fallback_on_link_loss)
 			result = dp_check_link_loss_status(link, &lt_settings);
 	} else if (result == LINK_TRAINING_ABORT)
 		dpia_training_abort(link, &lt_settings, repeater_id);
-- 
2.42.0

