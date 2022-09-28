Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479A2C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD9F10E9D4;
	Wed, 28 Sep 2022 19:42:39 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC7BC10E9B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cy1hTbzTC8RQU5BrHQ28yS8QbzUrsr5w44HGUaoau+xR8CTZTVFcwObfyDEUKD/L17SkEunKsUEqECq5l2jjpPzAKD6WESzWMINy3kvn5q3EkCKGagRXvp7n0bmTRyr0VoFa6b0bXXgsOpjCsNXFGqP5/xE9gp5fqdlpeNta/cgRsl9+Ef8/F36jaa7G6XRqDvyOqtunXdOfUhLSWpUDx+BdsTeWjzynRpxENR0w1vYCOpiCn1NVR57p4ICAWvtP8yD8WkcL01PzL3JrqhJIIfXKjHr/apXgNye1kP+2NbnJDD0fit3dNCSXsT0ZSo6o6gxtBdZ271Ghj+Boy2K3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rwx0kkwv94KISVpnnHJzdcgabOjTC4BPKqXoIv6s/jQ=;
 b=hdbsCwIMZB3TGmjDMaVGUo8sj1BCSDg3MYsQjLfrs0PsxOW+NEXt27waKsOjgxAzU1chscJ0w8fWZuq7PInpDTqXh9D5BWj5wp5I5wurkLmESB+GHR9/WpA5Q/NkIp8/AlPBH9HY72E3684VXfPZO+tRkcNOalPnJNlc3EsoBaBpS4QNTK7GBFvulps0bRlb/f5BCjfcOtMlt6NNeeAArYLNRzQfICcyQd8yIvIQLWwx2uMqDbWBAIAO63Z54VHwdT/ENvqSkqF11KMvwzU9m8A8YXbdhWE4BRZUynDNYDqV9ibccbpeqbvyQ+vLK65A/TOZ2Ta4AXCJAdjsNN9+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rwx0kkwv94KISVpnnHJzdcgabOjTC4BPKqXoIv6s/jQ=;
 b=nY57pVqVl/a+p73fSQbJ06mb/S/lSDBdWExIlZx4tOz8NN8b+o9enwAuITX7a2m2yKdkioy/eO8ectnLLOR4Fk1xMzs+WyreO+pgdh9bEFEn+3KOj26f3EscTuYATLHAD0V0ehua7+nqyJxhzKdQu+JJo1kDD56jH395k0lPhec=
Received: from BN9PR03CA0192.namprd03.prod.outlook.com (2603:10b6:408:f9::17)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 19:41:19 +0000
Received: from BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::21) by BN9PR03CA0192.outlook.office365.com
 (2603:10b6:408:f9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT092.mail.protection.outlook.com (10.13.176.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:19 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:17 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/36] drm/amd/display: Fix vupdate and vline position
 calculation
Date: Wed, 28 Sep 2022 15:40:11 -0400
Message-ID: <20220928194028.144879-20-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT092:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b706c0-b235-4525-c261-08daa1896a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SKX6FfEyT+zavkQgKwpaFtjJj/4voq2C0MsQZp7HyIOkqeiTOEz3Q2mR1hjf2sSY05OcvKC6ydtEkpI5/OOGp2w47co6qKMelcHLCaV86ckLrQYtxEQOl6a9GzYquS7VEfJPL7BhxP2sTa9qf/z+BheIu1urbJkguwF80nXVEv+czT+ksAUTZ7d7t3H7qeG0XJAJh9BZINACep7/V37qxVHIutVte4ynwadAoLfZ3Ab8oQzmKdd57kQ4jd7d9OFgY/uzR3tO5PA378THUKu+lD3j+y2vvUt8/OHryODXHLbLEQsHSSQeNKiBHktYPvY8+yhTYsEEIavmndbI7DtTtMxv76/GVHoKwdhFgq8FjNoV4fODEYIW2+f/LRP2nOmZ8sjJW4hw96Bxv0mq4FN9tdlvniPAqSHN+VkibxXb+JCSHtMmNBYAi9mgJG0Jq4VLFDq434Ny4/CZ12v0oZpdRcsWQJyWPgi9v38e0bSCGU08mmdRbTmdPzChvx/utfltM3Vtdx1NJR7jOXUvc5W+A8AZOMM3MWWw+IgADp2/YqbElrEDoGl7MPVHiPXAHkKdaGrSTre3vTJXlkFPvLzlNPG9gOuJ+2+vfJa/DnLWtw1nXUMPiuf+k5khMuAfS6iBarjzgi0iEVazi1Qw+3SuKOQ8Awd6NoZcj1N8u1hPUaTlCSfv2xdqhWdJvKtnS7Igb4DHezIFFF1NpA1mcocbFMsLtdle0emwhBX7VZgQcvsmVfuc1k+tBwWJVL1v0ljKjVucV2AbtVAoPtH6FqEMC/LA+y/yzVcKTk5VAVslRrM+/ElOKtutJCk90n/iyZ89kj2FdaXfkx8e9EcZNOWWmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(81166007)(356005)(83380400001)(186003)(16526019)(336012)(4326008)(426003)(2616005)(82740400003)(36860700001)(1076003)(44832011)(26005)(478600001)(6666004)(41300700001)(7696005)(47076005)(8936002)(70586007)(5660300002)(40460700003)(36756003)(8676002)(82310400005)(70206006)(316002)(6916009)(40480700001)(86362001)(54906003)(2906002)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:19.5111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b706c0-b235-4525-c261-08daa1896a82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[how]
Large deltas for periodic interrupts could result in the interrupt not
being programmed properly and thus not firing.

[why]
Add proper wrap-around support for calculating VUPDATE and VLINE
positions.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 60 ++++++++-----------
 1 file changed, 25 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 72521749c01d..f5427a979b5d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3810,28 +3810,14 @@ void dcn10_calc_vupdate_position(
 		uint32_t *start_line,
 		uint32_t *end_line)
 {
-	const struct dc_crtc_timing *dc_crtc_timing = &pipe_ctx->stream->timing;
-	int vline_int_offset_from_vupdate =
-			pipe_ctx->stream->periodic_interrupt.lines_offset;
-	int vupdate_offset_from_vsync = dc->hwss.get_vupdate_offset_from_vsync(pipe_ctx);
-	int start_position;
-
-	if (vline_int_offset_from_vupdate > 0)
-		vline_int_offset_from_vupdate--;
-	else if (vline_int_offset_from_vupdate < 0)
-		vline_int_offset_from_vupdate++;
+	const struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
+	int vupdate_pos = dc->hwss.get_vupdate_offset_from_vsync(pipe_ctx);
 
-	start_position = vline_int_offset_from_vupdate + vupdate_offset_from_vsync;
-
-	if (start_position >= 0)
-		*start_line = start_position;
+	if (vupdate_pos >= 0)
+		*start_line = vupdate_pos - ((vupdate_pos / timing->v_total) * timing->v_total);
 	else
-		*start_line = dc_crtc_timing->v_total + start_position - 1;
-
-	*end_line = *start_line + 2;
-
-	if (*end_line >= dc_crtc_timing->v_total)
-		*end_line = 2;
+		*start_line = vupdate_pos + ((-vupdate_pos / timing->v_total) + 1) * timing->v_total - 1;
+	*end_line = (*start_line + 2) % timing->v_total;
 }
 
 static void dcn10_cal_vline_position(
@@ -3840,23 +3826,27 @@ static void dcn10_cal_vline_position(
 		uint32_t *start_line,
 		uint32_t *end_line)
 {
-	switch (pipe_ctx->stream->periodic_interrupt.ref_point) {
-	case START_V_UPDATE:
-		dcn10_calc_vupdate_position(
-				dc,
-				pipe_ctx,
-				start_line,
-				end_line);
-		break;
-	case START_V_SYNC:
+	const struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
+	int vline_pos = pipe_ctx->stream->periodic_interrupt.lines_offset;
+
+	if (pipe_ctx->stream->periodic_interrupt.ref_point == START_V_UPDATE) {
+		if (vline_pos > 0)
+			vline_pos--;
+		else if (vline_pos < 0)
+			vline_pos++;
+
+		vline_pos += dc->hwss.get_vupdate_offset_from_vsync(pipe_ctx);
+		if (vline_pos >= 0)
+			*start_line = vline_pos - ((vline_pos / timing->v_total) * timing->v_total);
+		else
+			*start_line = vline_pos + ((-vline_pos / timing->v_total) + 1) * timing->v_total - 1;
+		*end_line = (*start_line + 2) % timing->v_total;
+	} else if (pipe_ctx->stream->periodic_interrupt.ref_point == START_V_SYNC) {
 		// vsync is line 0 so start_line is just the requested line offset
-		*start_line = pipe_ctx->stream->periodic_interrupt.lines_offset;
-		*end_line = *start_line + 2;
-		break;
-	default:
+		*start_line = vline_pos;
+		*end_line = (*start_line + 2) % timing->v_total;
+	} else
 		ASSERT(0);
-		break;
-	}
 }
 
 void dcn10_setup_periodic_interrupt(
-- 
2.37.2

