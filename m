Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126EDC77B72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EBB710EDC0;
	Fri, 14 Apr 2023 15:54:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 970EF10EDB8
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INq71HWlM/M2ovs73vOSt/Tkv8KGEpb4B1SlAm2TilwQ9J4p4dBS++F06Yw6vmeIpPz+9AXBE2K6gI3Rv6XBq2QbjNqF00Jn27LauHiwEQK30JgXykYkz14L3QIZbNIvqB7eyqGRqzDEp0EDxbRo7bCZyoyu5ZmV0l4rQOGKlgWhPbJnqekrarcjGA+cU4G7TlxKe7vcD5vZsdSuSjdlLyLWKhEV327MaU1RLp/HhIMBHlOhScA+McoBXZXacyBgCMiMXpf2VQniVsMK98lvdlidz+vVzhHSd3OPU/d5fyoC0IsaxAVrCtvmaY2EKWghpao+sMkOClts9reO0Yg2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7pxOn9I2tT5oQ+HgBOvb7BlFYIGkQyb88i4UN/TX8o=;
 b=VCA/7LUbersuphAeRXkyHmqw3gR9+9OFTm7kMHFJEbrD2JElDLpdzwMpU4okcEoRrhvSD1JsSPCm8xL0wTavcB9XoFMWkxSYO+BE2ft5lbyScOkkR9zPSx17AuifjIHFUhpSKIEWYl7bU04e8y4N2z8CZGrDCyDIpflQnnubmIgfyMfWIPiN+tRch6yICfqvVI/YIAYgjHLWCB11EY0E8P2qpYdKEnNBaDjtADpMhB0Be97fn/PHsRM7+C33ctfiKRnTCLHqPMKGBi0YmYEyCx1ZXge28+mi+fDWusNSTy5tml5XwCBBaDsCzewN9v8jD0/mgnBjHi0JZ/TXYqT5VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7pxOn9I2tT5oQ+HgBOvb7BlFYIGkQyb88i4UN/TX8o=;
 b=g2623/7mUVYKbHaDv7KPH+7+GLlewN3GhCRNT5JAgXLoLoVlPk+Da6hugGN/uh+h6ZdWgcOMhCGzJP5bRodhVZp1/82xiv+BGRtv0yj9arQloNwDjOdMNAP1hPS5Pxyw0vyl8Sc6LuFvKaHvRINtop56yRy5CWFABxQ0gK1nLnE=
Received: from DS7PR03CA0117.namprd03.prod.outlook.com (2603:10b6:5:3b7::32)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:03 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::e5) by DS7PR03CA0117.outlook.office365.com
 (2603:10b6:5:3b7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.32 via Frontend Transport; Fri, 14 Apr 2023 15:54:03 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:01 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/66] drm/amd/display: Block optimize on consecutive FAMS
 enables
Date: Fri, 14 Apr 2023 11:52:35 -0400
Message-ID: <20230414155330.5215-12-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: a9df3da1-b9d0-4916-7551-08db3d00789e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wri+Y4k3gsGy8S5Lp3NlTYB8C/W40cGlb34L08xOyyyJcvfcWZb5inbXxBKue6C5A+uVXwe756ZJJRKOVJLgmXeuwUqsFkW6A3Kz98G4H8m0VPrRSR0vSXZ9v8J9aR6dK32N632xO6RB2TEjJvMTsvZ/pt8cSUepJMn7jWMvJulwI1GG8z4vlQkfFCG8nGShUw0C+IebvOIT/30R1glGxYhb57sjRRfwqUqqyLfj+aH7slBh2qK+QrsJZeBeOFnY8/OvNYecXKal1Mjdggr1V62+9tgzyFLYvsH5XUg6n9b8gr6mF2OiEIv7m+Q3n6qO215XIo+38pSSDhzdgQG+GJbyFcsbFqdDmVE4KRGBkP1UbioB8KG5aUtfOWRWE7ntUBXD06nSxBw/ufJcUW3ZnrVFkxauMMzgelzhiSuavV/W3wJTQFMi6mTA5HrtW4TYQtJkrmWaWHEY0GCHr5SQJhXfQplJ8SDoj0Pb7Vk+L/GvT8hVS/WXbEoz+UG4OLVDByHBc93hIYt4+uHpyjcvo7oBO/2bStvagFeR8VkUU3etC6kcIg4OFS+jJhXbC01Kz3JF+dqbvm0ODXtowygdebhz3WB17SN0gou8afNFJr+NxKkfUFt4rDgAoA86HGiiMwAHAbOycs1URsjUSWkmYu61h5oYiFFQmQWrlc3aPcTv/ugANMeYRss7ZhIk12Ag8r1RKiEeEip5lO282jSMyTn/OJGIe37U3l//698D6t0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(186003)(26005)(16526019)(1076003)(54906003)(40480700001)(478600001)(81166007)(356005)(2906002)(8676002)(8936002)(36860700001)(83380400001)(41300700001)(426003)(5660300002)(47076005)(2616005)(336012)(82310400005)(6916009)(4326008)(316002)(70206006)(70586007)(82740400003)(86362001)(6666004)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:03.5220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9df3da1-b9d0-4916-7551-08db3d00789e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556
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
Cc: stylon.wang@amd.com, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
It is possible to commit state multiple times in rapid succession with
FAMS enabled; if each of these commits were to set optimized_required,
then the user may see latency.

[HOW]
fw_based_mclk_switching is currently not used in dc->clk_mgr; use it
to track whether the current state has FAMS enabled;
if it has, then do not disable FAMS in prepare_bandwidth, and do not set
optimized_required.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  3 +++
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 22 ++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 6ce10fd4bb1a..422fbf79da64 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2117,6 +2117,9 @@ void dcn20_optimize_bandwidth(
 		dc_dmub_srv_p_state_delegate(dc,
 			true, context);
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+		dc->clk_mgr->clks.fw_based_mclk_switching = true;
+	} else {
+		dc->clk_mgr->clks.fw_based_mclk_switching = false;
 	}
 
 	dc->clk_mgr->funcs->update_clocks(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 0411867654dd..8263a07f265f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -983,9 +983,13 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 }
 
 void dcn30_prepare_bandwidth(struct dc *dc,
- 	struct dc_state *context)
+	struct dc_state *context)
 {
-	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+	bool p_state_change_support = context->bw_ctx.bw.dcn.clk.p_state_change_support;
+	/* Any transition into an FPO config should disable MCLK switching first to avoid
+	 * driver and FW P-State synchronization issues.
+	 */
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dc->clk_mgr->clks.fw_based_mclk_switching) {
 		dc->optimized_required = true;
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
 	}
@@ -996,7 +1000,19 @@ void dcn30_prepare_bandwidth(struct dc *dc,
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
 
 	dcn20_prepare_bandwidth(dc, context);
+	/*
+	 * enabled -> enabled: do not disable
+	 * enabled -> disabled: disable
+	 * disabled -> enabled: don't care
+	 * disabled -> disabled: don't care
+	 */
+	if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching)
+		dc_dmub_srv_p_state_delegate(dc, false, context);
 
-	dc_dmub_srv_p_state_delegate(dc, false, context);
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dc->clk_mgr->clks.fw_based_mclk_switching) {
+		/* After disabling P-State, restore the original value to ensure we get the correct P-State
+		 * on the next optimize. */
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = p_state_change_support;
+	}
 }
 
-- 
2.34.1

