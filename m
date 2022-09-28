Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AB8C04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3428D10E9C5;
	Wed, 28 Sep 2022 19:41:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A752410E9B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq6n44FlPpe4GDKrF3pgHGWBN7bVadeuHDsIh/Qq+c6o0t3skWi7NZPLzBVZXu9IT5dzj66rwcoYblPwXDwOSXonGmxptCyib2wfsHvbhq7rRAUIM4bghAxQFhfAx54E3vtuqUdJ74u2XQ6QtDOTTg7O4I7P4QuaQMp/lxExXFp3cY37+13YGwnv7Bm7kCMQi55RKCrZZYEvePx9iHqjdWw35F4Wcnml3CbblCXxniKbnlP8Bmc/s7XQRajbSQsg1ejKg5omuDWGgc9wVrXSt7WZevrS3wFj0XXhvslP71v2485FfnAU8h5A6YGCDgWUZ9X3KJGV23Ai6MeJbpcmMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DT4MK8AKlKT2mjHHmCoGhF3ghtI987+vguDBOeCZ3Cg=;
 b=aLV/1Q1GGEsq05GTtIT0z7yb8zKr9QbPQZyRldX3Jk3M9UGITBavZc1U2pXUQN3nrMbN1FXnoQE0tviLH2DEoKByg+HRZdN3J4hmGZpOdH1gL08/1sNnESH1OFNnoOZdzJWQh+gHFQv8/nw6YB2l9isrd+Xhuujd+CMZZndYTpqVgqCrgbCjvv7hsUXMo/QnZYdXEvja0ZArsoViuCFiZ85S36F+o3vRKSduZ1DeOPZAkwGQgbcKNkYfR7hhcGppqH/nIkOYCcwrtNXUe33XCOJoW2wWqFA6Q5VH2yHzS4/rlVEgxFvX7ln4AZofbpD1HlQ4aJFzVbnbcYwPRqFZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DT4MK8AKlKT2mjHHmCoGhF3ghtI987+vguDBOeCZ3Cg=;
 b=aVyv2+JvZLIZSaKJXWinXVsIpkvVpqMfX5ZwtW/pZZu5ooTJc3iV6ZR376eR0DNv7vw8vF4hHc5mA3+Y6+fi0B3ugjk5vvMykQUHv70P9xZLMYteWS0vAQlOiu9LIcz4WskJf4D7M1XAlgXQpAVwi/rlQeNGrKbXS2g9iYPCRn0=
Received: from BN9PR03CA0671.namprd03.prod.outlook.com (2603:10b6:408:10e::16)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 19:41:07 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::3d) by BN9PR03CA0671.outlook.office365.com
 (2603:10b6:408:10e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.29 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:07 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:05 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/36] drm/amd/display: Add log for LTTPR
Date: Wed, 28 Sep 2022 15:40:05 -0400
Message-ID: <20220928194028.144879-14-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: a79fe8a2-1fd1-4768-4df9-08daa1896329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eDXtZsEefTXZ47O8lQXNDU5v2piIt/9g1Oi4szDa6B1jQ8KEs27jT/u8EWc56lbG1ppZExqSRQSrDQlSzGDsgJce+f9Y56yDiJ0DG5MLswIXVhAGXLO3vXIx+H2ukGJQx/iTw+GOhSwu8oUTHa+03XFgS3s7/1sHc7I3NypAiYNU2KDArOnfyQ7Zzland3Omazl1kZvej8+Nmt0kY/l0dnosTLxNg+t30gqBHVivRF8pWo6vL4YGJez95OT2ksO3kJhEiFXWtph2UTxpkDKqswP6ieyIMbyQvqqVcDE+39aXkQKRjEMxNV6Y9EEmC5LwaNG4Rx0LbGnDvUBC9Lh3HALtW0YwzvN7ZL7FI8g+NrXbGp6x49PYkQfP8qCcaVB0cLShX8W/A4UnrOpmB7KdWw5nSaITN+BK9Q7mrlZrf52jrPUYy6tjoQ5LHvqxeN+N144scPP6tltk9EHm22PceOpyGqj2kAyiCu5y8EOq4H7F8lkBaXCa6GFdATtlDk5GlzocHssUTyjiolL5IIvDT2UYd6yMK/56diW9QNx0lGjJ2/AlVZhldBvHGy9Kvj/fwHyJk1bzU7Fm0X9ZQ3lBO/bKoR+Ov5AtboS67fmAJLL71N3nj5DOEwD8r6MqRJunVfzTvkoWOHRoKIoqDfQ19dUBW3QkGdzuPwQYgFBe+urKHfHIcaxHNxwx3rMr1BF6W1r3wxN7nMMZRI587HpcuUT/s9musMDyjlEMWPXKsSEVFwHGadZEdz2LVJwMQHAPxDO8Jez/fmW/k9dX2AY4EpZvqtplLEZT9fTR8zl9V8nkI9xyljAnLuIPRXIMUX0pYoMKkdq6YChhIiYMhNFjOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(40470700004)(46966006)(36840700001)(2906002)(36860700001)(426003)(70206006)(7696005)(82310400005)(41300700001)(83380400001)(70586007)(8936002)(478600001)(5660300002)(1076003)(54906003)(36756003)(44832011)(26005)(40480700001)(356005)(336012)(186003)(16526019)(6916009)(86362001)(81166007)(8676002)(2616005)(4326008)(82740400003)(316002)(47076005)(40460700003)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:07.1026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a79fe8a2-1fd1-4768-4df9-08daa1896329
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, Leo Chen <sancchen@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Chen <sancchen@amd.com>

[Why & How]
Adding log for LTTPR to facilitate debugging.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 29 +++++++++++++++----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 2093120867eb..4ea8acb16161 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5090,6 +5090,7 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 			(dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) == 0)) {
 		ASSERT(0);
 		link->dpcd_caps.lttpr_caps.phy_repeater_cnt = 0x80;
+		DC_LOG_DC("lttpr_caps forced phy_repeater_cnt = %d\n", link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
 	}
 
 	/* Attempt to train in LTTPR transparent mode if repeater count exceeds 8. */
@@ -5098,6 +5099,7 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 	if (is_lttpr_present)
 		CONN_DATA_DETECT(link, lttpr_dpcd_data, sizeof(lttpr_dpcd_data), "LTTPR Caps: ");
 
+	DC_LOG_DC("is_lttpr_present = %d\n", is_lttpr_present);
 	return is_lttpr_present;
 }
 
@@ -5134,6 +5136,7 @@ void dp_get_lttpr_mode_override(struct dc_link *link, enum lttpr_mode *override)
 	} else if (link->dc->debug.lttpr_mode_override == LTTPR_MODE_NON_LTTPR) {
 		*override = LTTPR_MODE_NON_LTTPR;
 	}
+	DC_LOG_DC("lttpr_mode_override chose LTTPR_MODE = %d\n", (uint8_t)(*override));
 }
 
 enum lttpr_mode dp_decide_8b_10b_lttpr_mode(struct dc_link *link)
@@ -5146,22 +5149,34 @@ enum lttpr_mode dp_decide_8b_10b_lttpr_mode(struct dc_link *link)
 		return LTTPR_MODE_NON_LTTPR;
 
 	if (vbios_lttpr_aware) {
-		if (vbios_lttpr_force_non_transparent)
+		if (vbios_lttpr_force_non_transparent) {
+			DC_LOG_DC("chose LTTPR_MODE_NON_TRANSPARENT due to VBIOS DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE set to 1.\n");
 			return LTTPR_MODE_NON_TRANSPARENT;
-		else
+		} else {
+			DC_LOG_DC("chose LTTPR_MODE_NON_TRANSPARENT by default due to VBIOS not set DCE_INFO_CAPS_LTTPR_SUPPORT_ENABLE set to 1.\n");
 			return LTTPR_MODE_TRANSPARENT;
+		}
 	}
 
 	if (link->dc->config.allow_lttpr_non_transparent_mode.bits.DP1_4A &&
-			link->dc->caps.extended_aux_timeout_support)
+			link->dc->caps.extended_aux_timeout_support) {
+		DC_LOG_DC("chose LTTPR_MODE_NON_TRANSPARENT by default and dc->config.allow_lttpr_non_transparent_mode.bits.DP1_4A set to 1.\n");
 		return LTTPR_MODE_NON_TRANSPARENT;
+	}
 
+	DC_LOG_DC("chose LTTPR_MODE_NON_LTTPR.\n");
 	return LTTPR_MODE_NON_LTTPR;
 }
 
 enum lttpr_mode dp_decide_128b_132b_lttpr_mode(struct dc_link *link)
 {
-	return dp_is_lttpr_present(link) ? LTTPR_MODE_NON_TRANSPARENT : LTTPR_MODE_NON_LTTPR;
+	enum lttpr_mode mode = LTTPR_MODE_NON_LTTPR;
+
+	if (dp_is_lttpr_present(link))
+		mode = LTTPR_MODE_NON_TRANSPARENT;
+
+	DC_LOG_DC("128b_132b chose LTTPR_MODE %d.\n", mode);
+	return mode;
 }
 
 static bool get_usbc_cable_id(struct dc_link *link, union dp_cable_id *cable_id)
@@ -5179,9 +5194,10 @@ static bool get_usbc_cable_id(struct dc_link *link, union dp_cable_id *cable_id)
 	cmd.cable_id.data.input.phy_inst = resource_transmitter_to_phy_idx(
 			link->dc, link->link_enc->transmitter);
 	if (dc_dmub_srv_cmd_with_reply_data(link->ctx->dmub_srv, &cmd) &&
-			cmd.cable_id.header.ret_status == 1)
+			cmd.cable_id.header.ret_status == 1) {
 		cable_id->raw = cmd.cable_id.data.output_raw;
-
+		DC_LOG_DC("usbc_cable_id = %d.\n", cable_id->raw);
+	}
 	return cmd.cable_id.header.ret_status == 1;
 }
 
@@ -5228,6 +5244,7 @@ static enum dc_status wa_try_to_wake_dprx(struct dc_link *link, uint64_t timeout
 
 	lttpr_present = dp_is_lttpr_present(link) ||
 			(!vbios_lttpr_interop || !link->dc->caps.extended_aux_timeout_support);
+	DC_LOG_DC("lttpr_present = %d.\n", lttpr_present ? 1 : 0);
 
 	/* Issue an AUX read to test DPRX responsiveness. If LTTPR is supported the first read is expected to
 	 * be to determine LTTPR capabilities. Otherwise trying to read power state should be an innocuous AUX read.
-- 
2.37.2

