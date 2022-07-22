Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A52BC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17FC32B3E7;
	Fri, 22 Jul 2022 20:38:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D63C82B7B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:38:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMyUD09YVPc/dTl0ZkgKEE/6fsOIbyOOKnuZU7jupWGF/ggyv6dv/GUjuKXGoMD1yA5i27NNgh8TU/qNSnjzRN0abwWp2/O8ggMji1tYdXTn1dYb+9W4Q1RwakDRV8gh+p0SBhng3X/7taRxVAgDM0oK4Pmu/60318rhcXSkDm8PQwV7gFrgeoGU+6vUqtzPrhKVZWiK+1vp6K5MyVEG3jgWsoXyZ74wEGWjtWzwsP1WKqFgZbWdw1yfXdT8eejq+1bdS2WpOXv2RfKe5YtQ4gbmvYXsGozRlTIilBRmOCPNhL2KAqta8bP25kwwMe2aqq0ZFSdsbZypY2DWL5yJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcvKC+uMnw/HnchxcTfmaztIbiALeGInvey97yk6D9o=;
 b=W6hNrqR3Nts/QbUKvxu/0uM40aSStrHGL0xuWefwGIsbzEaHo5yT3JPAy89+dz/I8ROuNL5Miumf6yJmRaCmRT+xxVLwLY+MaNyC6NA9spcRRlq/UJqzzK+1xSWU+wVlesYFclXcp+9qQiDe4hn7yfn7/+47Q3qyethPJIWg0HTKZmGuWtvE0qoXyjUUNcSBi4M4pzJpoSiyJgSEnbTo4SG+k9d3mT2EyBYe7XnRFOKrc1b6o9FAMDHNDSkwFZaVs1yA0IoNHLrXPc4x63RZhWgBYTbuHuZyohn6MgbeSSRYdftTdlvjVEjWMVgSno1afhWcEvugR7xh87QoDoKfCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcvKC+uMnw/HnchxcTfmaztIbiALeGInvey97yk6D9o=;
 b=kgM+9R+QJ+heG778JEmW0+uy6EUOuH4s2akJTe6nlqFjpDtcIrRv5xbHDCy7Bj4qmBUYhIcO46aGhQyva8Ymuz6z1hXiVi6cdXNX4xAC8ngm/x1Yi+pkUDi9oJRpiomyP6PieqSlkHv9XT4mb49hi7tJj62qcYAgYeBSmftB1sA=
Received: from MW3PR06CA0008.namprd06.prod.outlook.com (2603:10b6:303:2a::13)
 by DM5PR1201MB0123.namprd12.prod.outlook.com (2603:10b6:4:50::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:38:07 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::21) by MW3PR06CA0008.outlook.office365.com
 (2603:10b6:303:2a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Fri, 22 Jul 2022 20:38:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:38:07 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:38:03 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/31] drm/amd/display: Fix OPTC function pointers for DCN314
Date: Fri, 22 Jul 2022 14:31:09 -0600
Message-ID: <20220722203137.4043516-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 095970c6-54b1-4713-68c1-08da6c2215dc
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0123:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KU9ws2/dLbDxzH1OKlTzjov9JfhPtr9sXOk1dTwURnlsYYdNDNrVTIcqgJzep7pUYaXBnVUQKwn0nZ/ko3hgjwg31srtGNbZrz92haMp4To9WuLerxelGkwYufiiz5itz7x2mXQFX9iaZTdtOXpFECTZqlwXLS2ctyi/PBG1GJBZbepKnrSWpqsHS0JzSRa1/H1DINj3oWp2tE8e/HZvKnF8EbwCMKvTcpRzKsat5aeBNuD3ms0CEDcDMu7WRiVbAgIJyAmvmKVhNTyUTl9WcxvrDXdhq3i+4Afa4HmRvUC6gxgNOxa+/43DL6cjyy485OdW6dXsbz2erc4LXV8mk3CKi1H2yibPIyvFSBFa0CUxF/xcC+jiPhBOOg1sotrkxS7O3upqxOYwW3cRM4lBwFKFn3BUNKhZ0kMpNScCoBVO2R8xxJPFul0SpI59W5lO9iBFwb5JVoQkG/Om4UYlkbOrBn3weY2RckAXeT1wi+nHc+Oc6wdOKOoV4FV87RlZPKOLyDRJz6RArN+XrBmBcb23Khcj9NEBgjv4R0FSO3Qtk6ukOfErX4+DQMMbzamjb5ZMYqQTf/1nmXRBlHPBqpHP+ye0z+nAfJKkmeurzWjm+/A/aKDQNpAD+lwC28EpZCliwH8Cpq/fz0ir9VCFgQXHvr9vys8MSNKn3+Ra57cBf6t7AtO7X9n/q/lgVSA30ISz7xd+/v3DWFVgmdFVbr5fvjLbEfsXIpTF69Id+kKdagVqGbu5mpPZ3Riem+3Pu1to4zJjq9kT4+FPOKlQEjZU0l6g+bvjSrCo/Tj5FFyDR1sz3Z/bsd1MusAJ1AnBXsqvsuWR5KHn1jdrZqEtOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(36840700001)(40470700004)(46966006)(26005)(356005)(81166007)(40460700003)(82740400003)(186003)(1076003)(47076005)(336012)(2616005)(36860700001)(16526019)(83380400001)(86362001)(426003)(8936002)(8676002)(70206006)(4326008)(70586007)(5660300002)(36756003)(2906002)(44832011)(82310400005)(478600001)(7696005)(41300700001)(6916009)(316002)(54906003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:38:07.5925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 095970c6-54b1-4713-68c1-08da6c2215dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Michael Strauss <Michael.Strauss@amd.com>,
 wayne.lin@amd.com, Alex Hung <alex.hung@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Access violation occurs when swapping between HDMI and FRL monitors
because we're missing the immediate_disable_crtc callback and it's
required for the DCN314 clk manager.

[How]
Update the table to match the DCN31 optc functions for ones that
should be the same:
- immediate_disable_crtc
- configure_crc

Reviewed-by: Michael Strauss <Michael.Strauss@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h   | 2 ++
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
index c4304f25ce95..2f7404a97479 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
@@ -141,7 +141,7 @@ static bool optc31_disable_crtc(struct timing_generator *optc)
 	return true;
 }
 
-static bool optc31_immediate_disable_crtc(struct timing_generator *optc)
+bool optc31_immediate_disable_crtc(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
index 3706e6f7880e..30b81a448ce2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
@@ -258,6 +258,8 @@
 
 void dcn31_timing_generator_init(struct optc *optc1);
 
+bool optc31_immediate_disable_crtc(struct timing_generator *optc);
+
 void optc31_set_drr(struct timing_generator *optc, const struct drr_params *params);
 
 void optc3_init_odm(struct timing_generator *optc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
index 436c3545a983..3011f9e2f35c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
@@ -170,6 +170,7 @@ static struct timing_generator_funcs dcn314_tg_funcs = {
 		.program_global_sync = optc1_program_global_sync,
 		.enable_crtc = optc314_enable_crtc,
 		.disable_crtc = optc314_disable_crtc,
+		.immediate_disable_crtc = optc31_immediate_disable_crtc,
 		.phantom_crtc_post_enable = optc314_phantom_crtc_post_enable,
 		/* used by enable_timing_synchronization. Not need for FPGA */
 		.is_counter_moving = optc1_is_counter_moving,
@@ -204,7 +205,7 @@ static struct timing_generator_funcs dcn314_tg_funcs = {
 		.clear_optc_underflow = optc1_clear_optc_underflow,
 		.setup_global_swap_lock = NULL,
 		.get_crc = optc1_get_crc,
-		.configure_crc = optc1_configure_crc,
+		.configure_crc = optc2_configure_crc,
 		.set_dsc_config = optc3_set_dsc_config,
 		.get_dsc_status = optc2_get_dsc_status,
 		.set_dwb_source = NULL,
-- 
2.37.1

