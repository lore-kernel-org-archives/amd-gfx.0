Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB79C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 05:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0DEB61242
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 05:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D0DEB61242
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4312989D9A;
	Mon, 23 Aug 2021 05:03:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06E2689D9A
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 05:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKFJ4Gpo8dbmOpne63fAvQUW31dMxwUM92T5MGnI5si4d3xIeG+MbcQsaoWT4lqaFRsCupCPE2KcxF+izK5yG2KaJm6XPCFahFV5XjuO8Qumg/fSPXj842kUMCLFN0c2wZlX98SzpzoDgz2EKS5oT8qbRuz3SbBC21rfnbrvIJXOWK/gBvEsjYBKMT0efcngS6zTpf2qnB+rUmpmKNORjeeJWRcNRuRkia/hwjAhlCLDCic4RTB71UI90zfmlTGuPjDfg6qDkFDSCMBqcCnsOH3KP+gAaYwbHNWbv2o7gYUvxzXiaqYUNFUBi3aEfsVz3U2fcXYVG46HISYpGJ49xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mDBTu3WpgERBSEybJNHR8B2buY81h4wFIWlnGyHCh8=;
 b=ZY3CRqH6X9/CaY0xmy8slmTC0SFiyK3R2qJDaB6Qb7J/3KJYdadb2eampYkfSR3OqKUKVkxGQsKWLW42A4owUOAy+srDtDM6YlD9kw7mWtPWra4UOb7mrUkA6/3AH/AiYvuJY+CSckc+T87IGxcMoWKIGTTMUh1RzYQXNEvwJ1KhC0y17smkgGtJSkhU+Xt6+26QnfsTmxfsrdvlYRgZQKe52lHiVY38JI4XLTvMJ3serzAczgNb+Dhhr4Y9o2+vjlPhWyk4DMZzPC1teeYQn/xmsutIcwTC+qPkLkojQBGGZyStIKiLZkngQ5a/U8hkzXFiBsalJ3nzuBPbTYqQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mDBTu3WpgERBSEybJNHR8B2buY81h4wFIWlnGyHCh8=;
 b=FZOP4sZq5JTDejzLr4ncQxUNIrZrW7rMIqvYQAnVGoUZVNYKL5ZT4ofRS3UyzgtHX67G68A2NRc4ggZEQ0RAEWFSVMDW+c/1SH5RfkI7NLz/NBOS937JoH0UOxtPXH3FfMzPbwBCYInNvK7GGdSBA0CAK1iLtFuJ+MU9yxWY0VU=
Received: from MWHPR10CA0008.namprd10.prod.outlook.com (2603:10b6:301::18) by
 SN6PR12MB2622.namprd12.prod.outlook.com (2603:10b6:805:72::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Mon, 23 Aug 2021 05:03:27 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::90) by MWHPR10CA0008.outlook.office365.com
 (2603:10b6:301::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 05:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 05:03:27 +0000
Received: from pswarnak-Sharkstooth.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 23 Aug 2021 00:03:24 -0500
From: <Praful.Swarnakar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <harry.wentland@amd.com>,
 <sunpeng.li@amd.com>, Praful Swarnakar <Praful.Swarnakar@amd.com>, Hersen Wu
 <hersenwu@amd.com>
Subject: [PATCH] drm/amd/display: Add Logging for HDMI color depth information
Date: Mon, 23 Aug 2021 10:18:30 +0530
Message-ID: <20210823044830.2370292-1-Praful.Swarnakar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8609ce1-4115-436f-a74e-08d965f357c6
X-MS-TrafficTypeDiagnostic: SN6PR12MB2622:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2622E8042A08849747A06E128FC49@SN6PR12MB2622.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/0/ZjCQiQIuznP+KHUwGIMP1X8xkGPKALF922Pmbmq8rjKVwpmF45YQDZ5LT57uzsxeYaaFPTNLE+NrNgaECpyqqwSAE+vO4UBL+YnCNa7qaT1sI9PJtPcp+GNBKYbuiCcBiDe4QmJI4QttyGOBwS3CQJFUs6fZ4bkEW1fgoX6f9IuJbyS00dMWkX660DAFrDCWMbcEd95BpGxL/JsSZOE4Mm7MiD6mvGEeYXMxCjcSZHmHf+axoJeBxmNHj4ZSpJQrlrEQ0a7pL3Zd9drB3SOsw1UMPDg+QnsqX69MzX/Ex0uhWoptgaPXEEHhcuIxuCShDHURfxmy5CFUp48stmzOC+fi09qByeYRDeRQTQmcBD+0iY5X0YX2yj7M2DS9ZPzgG/l5irKli+I2h40gN6F+82U3i/gru4688xpa6ko8pkDftMdzjEk4JqP+GjfiPi26cJjpQdS5SAGtfNJMIjRO0nR4zA0aPqiBeRTupa68V+7Pgv3Ls3vnOi9cQfsGEvAFpDfxbOLxCUE2gAkiaxJfnJ5SarwW1q1riz3ZVzg9ydKLHQSYbqS23dZx3ziYEwlY/z+53HC/9LECLfZNj9Fm/SUD87kCdzFdK0caMBudm9bUOngex+2oIPMcH7nUq1cHndBL1L2aRoxxbxtxs+8JgeHXKKbBLaT5YdnznSljOyPtvTAKmeAkClVKbYatb2jNO4z2A3qqwJauv60n+nU+f25dsfnkKp+G07GtwtidNoPBc2MZPuH355h7pBhVy0AFds9YV+qAXoEELeIJWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(83380400001)(70206006)(70586007)(6666004)(6916009)(4326008)(81166007)(36860700001)(54906003)(1076003)(478600001)(47076005)(36756003)(8936002)(336012)(34020700004)(82310400003)(86362001)(7696005)(2906002)(426003)(8676002)(26005)(2876002)(356005)(186003)(316002)(2616005)(16526019)(82740400003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 05:03:27.2161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8609ce1-4115-436f-a74e-08d965f357c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2622
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

From: Praful Swarnakar <Praful.Swarnakar@amd.com>

[Why]
Recent HDMI2.0 HF1-1 V-Swing testing showed that logging deep color
status helps in validation of testcase.

[How]
Add logging based on various color depths and pixel encoding
formats.

Signed-off-by: Praful Swarnakar <Praful.Swarnakar@amd.com>
Reviewed-by: Hersen Wu <hersenwu@amd.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_stream_encoder.c   | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index f1a08a7736ac..cf364ae93138 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -522,16 +522,21 @@ void enc1_stream_encoder_hdmi_set_stream_attribute(
 	switch (crtc_timing->display_color_depth) {
 	case COLOR_DEPTH_888:
 		REG_UPDATE(HDMI_CONTROL, HDMI_DEEP_COLOR_DEPTH, 0);
+		DC_LOG_DEBUG("HDMI source set to 24BPP deep color depth\n");
 		break;
 	case COLOR_DEPTH_101010:
 		if (crtc_timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
 			REG_UPDATE_2(HDMI_CONTROL,
 					HDMI_DEEP_COLOR_DEPTH, 1,
 					HDMI_DEEP_COLOR_ENABLE, 0);
+			DC_LOG_DEBUG("HDMI source 30BPP deep color depth"  \
+				"disabled for YCBCR422 pixel encoding\n");
 		} else {
 			REG_UPDATE_2(HDMI_CONTROL,
 					HDMI_DEEP_COLOR_DEPTH, 1,
 					HDMI_DEEP_COLOR_ENABLE, 1);
+			DC_LOG_DEBUG("HDMI source 30BPP deep color depth"  \
+				"enabled for YCBCR422 non-pixel encoding\n");
 			}
 		break;
 	case COLOR_DEPTH_121212:
@@ -539,16 +544,22 @@ void enc1_stream_encoder_hdmi_set_stream_attribute(
 			REG_UPDATE_2(HDMI_CONTROL,
 					HDMI_DEEP_COLOR_DEPTH, 2,
 					HDMI_DEEP_COLOR_ENABLE, 0);
+			DC_LOG_DEBUG("HDMI source 36BPP deep color depth"  \
+				"disabled for YCBCR422 pixel encoding\n");
 		} else {
 			REG_UPDATE_2(HDMI_CONTROL,
 					HDMI_DEEP_COLOR_DEPTH, 2,
 					HDMI_DEEP_COLOR_ENABLE, 1);
+			DC_LOG_DEBUG("HDMI source 36BPP deep color depth"  \
+				"enabled for non-pixel YCBCR422 encoding\n");
 			}
 		break;
 	case COLOR_DEPTH_161616:
 		REG_UPDATE_2(HDMI_CONTROL,
 				HDMI_DEEP_COLOR_DEPTH, 3,
 				HDMI_DEEP_COLOR_ENABLE, 1);
+		DC_LOG_DEBUG("HDMI source deep color depth enabled in"  \
+				"reserved mode\n");
 		break;
 	default:
 		break;
-- 
2.25.1

