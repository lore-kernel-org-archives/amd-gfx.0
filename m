Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D600C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 20:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED5C1112422;
	Fri,  3 Jun 2022 20:12:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E459112426
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 20:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0mFWNWjlecYvNkkuuFc3oHk9XQdhkx0p5wbFQWWK+j9yxveBHfFkmdCFg360OsY3QmRzsxofosE3+AZ673MZN8w2a3FVfzfTDbl0bQ0UCMpQXwuuYDmx9WhydRB15yEDOHnRQHOoE1pGFdnivbZOmCwQ15sDiuDwseJQHGD/D6LxHGdrgjUAKHZJz8bk+8G53Aurx0YIWkcCPbU1N3HaTeJZq4LJhttOAP0HnSBweWC9oAzr3jjec2sKUFiun1cJsFaDWYzEUTjoZksnBY3PzioXpQmo5tQ9MSoHMr+YaY1/Alq9W+3Te+JYDzXUkjdH3Z3XRm/PjDpeq7vUrVlWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jtt3spyr7n3PA7iKuQn2e+XbUBB8n5XH4kyuRETLXZg=;
 b=fT9eagAsQx9ajTQA9/lF5M1ATbUAT1WfkHC83yL7M+cnGb8gvBtojDXfxYydodOuRAUoug0WD94BYHI/chgati1EORBlZVZybaudEhovh2BtSyPxpQnzf8azg6LmOaC376UNkezmRMPPw0VGFxs8SiGdDyKL9mZHhAg8+Od4WDxn8Jz8KrwUC3HYpSIrUqCcPfKljYA/QRiKuhsCG0aj4sguRWSJSgYpjcVdOsK3un9Shn3bK2r6KwKwKAGVdXbXFOaOZVzw7BXds/vJc/n/cGPLdfbkxIl5pr2KdawH1G6coc6dwgqWRizwSA0vvmAYB55aO4X22fdQeqmM3CSxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jtt3spyr7n3PA7iKuQn2e+XbUBB8n5XH4kyuRETLXZg=;
 b=g0J3lbXsH6pUf3ldvlNP74JnH4clk7AY3xt9YHJytuwGru6Dr0x/GbkflhEMicGa/Np/tgOgby8+RlzTxhoo1IsREKMna+l4br7ij0aN72zC8ckznTRfk6a7xcXwhQwgpAivA8rnffg96Nh+qA792uqft0bkL7/Y3G0sZxNUIC4=
Received: from DM5PR07CA0033.namprd07.prod.outlook.com (2603:10b6:3:16::19) by
 BN6PR1201MB2531.namprd12.prod.outlook.com (2603:10b6:404:b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Fri, 3 Jun
 2022 20:12:46 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::9f) by DM5PR07CA0033.outlook.office365.com
 (2603:10b6:3:16::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Fri, 3 Jun 2022 20:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 20:12:46 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 15:12:44 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/16] drm/amd/display: Avoid reading LTTPR caps in non-LTTPR
 mode.
Date: Fri, 3 Jun 2022 16:11:44 -0400
Message-ID: <20220603201147.121817-14-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603201147.121817-1-hamza.mahfooz@amd.com>
References: <20220603201147.121817-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32bb5f68-4199-481d-8e14-08da459d6cdf
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2531:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2531D37394D0CE572B9EAD36F4A19@BN6PR1201MB2531.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4XkXTlWotpim5GsH7dtvX/dMc9XAhjXh2Ry2+J16JXfY9hY90T3DcGR6bRRm9tk4hl81QsGWtKCNA8jWBAFWlaUQFTe5GO6UQc+7anxeaNJSJJH/IvvCs1p3qeOYg6scBKIux8Phzvy/MkNIsjOlJQF7TC0jBKkzFs84lJY6Ie+fo9bhXPztM4iPcgM3dMpEJNlystwaXAdwh1Xitgn7sXBZsGQe88gTRmBF4xaDqZHNB/uneHnE8vtko8qxnHvVA9UTgzGwrBVNkAThOczgwar6TIGa/EAJIxvYiT4tTHJ2nEMT73zfo6NKifOr5jLItikbFYPyt07NDq10vdjI/9vC8ZWJPup9i2yTJVZUjSM2u1zaeYpOsaQSTrYYmFHvGlB35Q5LHCzn4OuODbgMMFeDOKcXU6MiPhUN3Rw6dV54/lwAx5qww7kWu1k2lkVOyrO8MjWM/u4Uch//XlmEScUrW6bxnAveIarW21T/bnZTwEsifE92e9WhQY/k7hETuTJfR2RqKWzwzCHNE5GtYfG0oH2kV52nJJSmvaFYkUTcgUXgetHoCsf9AwBsn7c3h/7oPoxfbAuWozehT6ziwoL2v/zWw3Fe5bY1xa+GIxdjRhf4/8/Coq+SazuaajekU/we86cgcWM0+wTefedNckpGyJj/11RF2Vud2fU5OTXyVMIUgS7IMMz+e6iajfBb5grSCZ56simBxbhRtiqmOO0jAF8lPN30ydPyqYbINK4huOFM26Y22UyvkKah/H6K
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(186003)(70206006)(1076003)(316002)(4326008)(16526019)(54906003)(86362001)(8676002)(6916009)(8936002)(356005)(2616005)(26005)(81166007)(70586007)(44832011)(508600001)(82310400005)(40460700003)(426003)(36860700001)(47076005)(83380400001)(5660300002)(336012)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 20:12:46.4181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bb5f68-4199-481d-8e14-08da459d6cdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2531
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
Cc: stylon.wang@amd.com, Mustapha
 Ghaddar <Mustapha.Ghaddar@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Jimmy Kizito <Jimmy.Kizito@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
LTTPR capable devices on the DisplayPort path may assume that
extended LTTPR AUX timeouts will be used after LTTPR capabilities
are read.

When DPTX operates in non-LTTPR mode, AUX timeouts are not
extended and this can result in AUX transactions timing out.

[How]
Use shared helper function to determine LTTPR mode and do not
read LTTPR capabilities in non-LTTPR mode.

Reviewed-by: Mustapha Ghaddar <Mustapha.Ghaddar@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 44 +++++++++++++------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 9b20f340c21f..b5b16340fd39 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5134,16 +5134,13 @@ static bool dpcd_read_sink_ext_caps(struct dc_link *link)
 	return true;
 }
 
-bool dp_retrieve_lttpr_cap(struct dc_link *link)
+/* Logic to determine LTTPR mode */
+static void determine_lttpr_mode(struct dc_link *link)
 {
-	uint8_t lttpr_dpcd_data[8];
 	bool allow_lttpr_non_transparent_mode = 0;
 	bool vbios_lttpr_enable = link->dc->caps.vbios_lttpr_enable;
 	bool vbios_lttpr_interop = link->dc->caps.vbios_lttpr_aware;
-	enum dc_status status = DC_ERROR_UNEXPECTED;
-	bool is_lttpr_present = false;
 
-	memset(lttpr_dpcd_data, '\0', sizeof(lttpr_dpcd_data));
 
 	if ((link->dc->config.allow_lttpr_non_transparent_mode.bits.DP2_0 &&
 			link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED)) {
@@ -5153,9 +5150,6 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 		allow_lttpr_non_transparent_mode = 1;
 	}
 
-	/*
-	 * Logic to determine LTTPR mode
-	 */
 	link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
 	if (vbios_lttpr_enable && vbios_lttpr_interop)
 		link->lttpr_mode = LTTPR_MODE_NON_TRANSPARENT;
@@ -5177,6 +5171,18 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
 	    link->dc->debug.dpia_debug.bits.force_non_lttpr)
 		link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
 #endif
+}
+
+bool dp_retrieve_lttpr_cap(struct dc_link *link)
+{
+	uint8_t lttpr_dpcd_data[8];
+	enum dc_status status = DC_ERROR_UNEXPECTED;
+	bool is_lttpr_present = false;
+
+	memset(lttpr_dpcd_data, '\0', sizeof(lttpr_dpcd_data));
+
+	/* Logic to determine LTTPR mode*/
+	determine_lttpr_mode(link);
 
 	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT || link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
 		/* By reading LTTPR capability, RX assumes that we will enable
@@ -5292,11 +5298,23 @@ static enum dc_status wa_try_to_wake_dprx(struct dc_link *link, uint64_t timeout
 	uint64_t time_taken_ms = 0;
 	enum dc_connection_type type = dc_connection_none;
 
-	status = core_link_read_dpcd(
-			link,
-			DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV,
-			&dpcd_data,
-			sizeof(dpcd_data));
+	determine_lttpr_mode(link);
+
+	/* Issue an AUX read to test DPRX responsiveness. If LTTPR is supported the first read is expected to
+	 * be to determine LTTPR capabilities. Otherwise trying to read power state should be an innocuous AUX read.
+	 */
+	if (link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT || link->lttpr_mode == LTTPR_MODE_TRANSPARENT)
+		status = core_link_read_dpcd(
+				link,
+				DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV,
+				&dpcd_data,
+				sizeof(dpcd_data));
+	else
+		status = core_link_read_dpcd(
+				link,
+				DP_SET_POWER,
+				&dpcd_data,
+				sizeof(dpcd_data));
 
 	if (status != DC_OK) {
 		DC_LOG_WARNING("%s: Read DPCD LTTPR_CAP failed - try to toggle DPCD SET_POWER for %lld ms.",
-- 
2.36.1

