Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67324ECAAD5
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 582F210EB43;
	Sat, 27 Aug 2022 02:27:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D6B410EB3F
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:26:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTl1Q66spPvkbLUpjYzCvf1QkaUakHs8ZY2oE6egddyA0QENy/KJiaE9j43VXkY6R5JOd1FcXyjEDSNTnAa5YtIvZV+vUqwVwvCKxNKJzOZpfmAtlhMrDMGDRd8rR1iwgkxePJrI3WTXwd6DkeywojGqHheHUrfac7XCK+0V2F8VGP4CJSVY+ZUbyY0/eSaacMcptRjKhocJW2qJS/M76hfWOveU86yz6LnLFTR+1ehSUzz0jVMtJ0y5xlH/N1jKzXUEVb5gyxEbNaITWQ6oy9i8wn73H7WRPAJfQEGaPU0E8TD3PoFFNJp8ovLnHSf9A6GJbcJs5uK5IsKuknugLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwAng8S55ibPeUX46k3V9AP6tF1ZOZHfLluagGuwovs=;
 b=jIRKdaDWsUYNRFIOvEeswethGh88A3peTviFYV9HmRNPLcZyXiWG9tCf+sRQPaIa9iemOd6vqCPNK6UBxn/7SdwVOzUTLJbMJdS33Hdc3Q9MlzCqI4ABaV2mJZvy+Xgi8nAt1j93PctDoAqx3kGaq5IfzFL7ZnG5UZSxjv2UCxojhJ3Qz2Y3ZkVh+ZPnE0v5Yq4OpMXEKrYak6so2RtRhimnJi2/vvbtthVMjIufRQBcbFZYveMqJLJZ6vswt+G2wMjEm5JCfP+tixnoihfucPCgkIUH1hXYUwJ4ztlcNf8oYxQPc+fB1n+dvhzlVhnGbd3fmTg0AnXzqYmp5KD/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwAng8S55ibPeUX46k3V9AP6tF1ZOZHfLluagGuwovs=;
 b=1A3UI3VYH6EQZ8WlPbZOMuKdYprKEXQB/3fjpOiEOVfs8A53SIVBwwF8owDvS6YL+ubPdggk9ISJiISlQ3IsnNYFsCX0W7Krflvvg0iUN8+40U/w2E/NEhoCfjKCpxH4pw16n4FciZgPwR4DjTmnzrHMAZnuOHAa0mDFF8nu/uU=
Received: from MW4PR04CA0261.namprd04.prod.outlook.com (2603:10b6:303:88::26)
 by PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 02:26:54 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::95) by MW4PR04CA0261.outlook.office365.com
 (2603:10b6:303:88::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 02:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:26:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:26:53 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:26:49
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/33] drm/amd/display: Refine aux transaction before retrieve
 caps
Date: Sat, 27 Aug 2022 06:26:53 +0800
Message-ID: <20220826222722.1428063-5-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826222722.1428063-1-Brian.Chang@amd.com>
References: <20220826222722.1428063-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30ccb89d-9189-4095-969d-08da87d39b9c
X-MS-TrafficTypeDiagnostic: PH8PR12MB6868:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hdmNlPxk/Q5Wq9JKT2YahfWr2paBv0xn39Cxnfu+H+wu4WrWE3MdL3KxnytxTzFicOF5ZmTl3gwHcIn5ZFDO/ABuAn0joRPQSOXSv8Yl0+VPBmgz662J0zx205xExMOBNhd/Zl+gWr/tbtqkSIaaWpC8lyeWY8NCXt44NoVgCyKcmVrBk8ksG7RmsqJ6pLLPrPXB3uDWhYneDfYB2BSbfOv+6j24Pqj/xVUzow39D32ck31R2SeP+oRxH+PHN2aWztWc8E2jF4OSeAjoWch0nBYUlYG71q4u0BD8LxcXX8MtAsLlzy+SRQxkbnX653E+uvjAkeGZv1Sx0DA6kuJa0Ia904YYE+/Y3r8c14EWtesMN2BsEJ3hWoWmAssCCTRoKV5V7mUTWDGI9a5zrInOyM+2O4xsJu0dyqPc0i6F1o1fQh8BGX4OnUtpNDu1veewvvVwmKNJJ/Yp5t7hXjtCLw9IqhFmqyFZKthU1ZECUQBtql08PscpWxlRleqBZCR1sguysO00qjYUxelU4wGJ328nsLeGphSdSUanT/vjJdtCDCaTiKyvH28eGKBbOntKpYzm1miWVHKAAUDeAxs9zW770iRzwh6u6l/CzW9ECFk6ZZKDw2kyd2ZTIT6yrok48Xx2MkqWnQ3TGpc4WQDa9NXBb7NLQVJVEhRm6w4BKyaiQ+6NJeacsYADVO/s1qbELEbnKiII/GQAyrwyp1B4A849PS+aSRBv8vN9uvqlAcqz4/CbmHfMlOEytaR9NuNzaj+bDWJji4D9f+RI5H+fp+WXWgHXdZwum69C4rb4Rlr98WtunSfNme2RW/C+pL0ETeBKPc+dkYd55xyKlFAldg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(36840700001)(46966006)(40470700004)(36860700001)(40460700003)(81166007)(82740400003)(356005)(54906003)(82310400005)(86362001)(8936002)(2906002)(1076003)(70586007)(4326008)(83380400001)(2616005)(36756003)(316002)(186003)(70206006)(336012)(40480700001)(26005)(6666004)(478600001)(8676002)(41300700001)(5660300002)(7696005)(426003)(6916009)(47076005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:26:54.3207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ccb89d-9189-4095-969d-08da87d39b9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868
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
Cc: stylon.wang@amd.com, Lewis Huang <Lewis.Huang@amd.com>,
 Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jimmy Kizito <Jimmy.Kizito@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <Lewis.Huang@amd.com>

[Why]
LTTPR caps will read fail if aux channel is not active.

[How]
1.Perform 600 read upto 10 retry with 1ms delay in between.
2.If fail, return false and trigger another retry detection.
3.If pass, read LTTPR caps in retrieve link caps.

Reviewed-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 45 ++++++++++++++-----
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 2b7bb3a796e8..8617de559174 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5275,6 +5275,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 	union dp_downstream_port_present ds_port = { 0 };
 	enum dc_status status = DC_ERROR_UNEXPECTED;
 	uint32_t read_dpcd_retry_cnt = 3;
+	uint32_t aux_channel_retry_cnt = 0;
 	int i;
 	struct dp_sink_hw_fw_revision dp_hw_fw_revision;
 	const uint32_t post_oui_delay = 30; // 30ms
@@ -5302,21 +5303,43 @@ static bool retrieve_link_cap(struct dc_link *link)
 		status = wa_try_to_wake_dprx(link, timeout_ms);
 	}
 
+	while (status != DC_OK && aux_channel_retry_cnt < 10) {
+		status = core_link_read_dpcd(link, DP_SET_POWER,
+				&dpcd_power_state, sizeof(dpcd_power_state));
+
+		/* Delay 1 ms if AUX CH is in power down state. Based on spec
+		 * section 2.3.1.2, if AUX CH may be powered down due to
+		 * write to DPCD 600h = 2. Sink AUX CH is monitoring differential
+		 * signal and may need up to 1 ms before being able to reply.
+		 */
+		if (status != DC_OK || dpcd_power_state == DP_SET_POWER_D3) {
+			udelay(1000);
+			aux_channel_retry_cnt++;
+		}
+	}
+
+	/* If aux channel is not active, return false and trigger another detect*/
+	if (status != DC_OK) {
+		dpcd_power_state = DP_SET_POWER_D0;
+		status = core_link_write_dpcd(
+				link,
+				DP_SET_POWER,
+				&dpcd_power_state,
+				sizeof(dpcd_power_state));
+
+		dpcd_power_state = DP_SET_POWER_D3;
+		status = core_link_write_dpcd(
+				link,
+				DP_SET_POWER,
+				&dpcd_power_state,
+				sizeof(dpcd_power_state));
+		return false;
+	}
+
 	is_lttpr_present = dp_retrieve_lttpr_cap(link);
 	/* Read DP tunneling information. */
 	status = dpcd_get_tunneling_device_data(link);
 
-	status = core_link_read_dpcd(link, DP_SET_POWER,
-			&dpcd_power_state, sizeof(dpcd_power_state));
-
-	/* Delay 1 ms if AUX CH is in power down state. Based on spec
-	 * section 2.3.1.2, if AUX CH may be powered down due to
-	 * write to DPCD 600h = 2. Sink AUX CH is monitoring differential
-	 * signal and may need up to 1 ms before being able to reply.
-	 */
-	if (status != DC_OK || dpcd_power_state == DP_SET_POWER_D3)
-		udelay(1000);
-
 	dpcd_set_source_specific_data(link);
 	/* Sink may need to configure internals based on vendor, so allow some
 	 * time before proceeding with possibly vendor specific transactions
-- 
2.25.1

