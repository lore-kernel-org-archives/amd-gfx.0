Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0E3C6FA90
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 350D010EA06;
	Thu, 22 Sep 2022 00:19:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFC9B10E9FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuJqMo6keVe1jOqlssmdVJ/AXgscNNI8d3pmF0rz62P3cOJApI9KyGtyXKxYM00Dkvk9ChHbAMMBxe8nBDrZgeW5ME4nZQJdL9aimhU8TSAjBAKW0ye/Dt3mzyr5hbH7fLAjzJ9SOtZyfNQoZ0VI/QiooWefBw5oU2swsjrFUvxE6zjBzxoQ6EMc4N/jlNAycP1uZm9MbAKPcDQAeQEdOWw7g90Kq/w9GqoHu8KDoxwzNm24Ftf/QEPAp7cZAzmtPBDNcE4TcpBIROjZPJv2tDfKULvKB2VudTmxYLx8GKgSo0KcVzGO2AsLRYG0Nu/ceKXQLgaotlXcyXDAe3wi5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhl6XvCRczw4aubn+qnTeJtctXiK7yGGsjmgB3bGl2M=;
 b=QOjQQsSGSYf8nq+QYzJOqwbXqnaGiJLCbwPbhK3ibWafICN3nfMAG1IA7X22tCM+bal0ciiKQwgPWC34QrG/BcmdyNDyrNjDTAeMAz+pRLxN5Ova8r6Ai9rOTJ/46mYP2xkIOQBgw1aEDi4gbo5lkyC5L0Tnr3AGqzGLZZw7GlvbCG1b6Fze7kdefanB8Z7kepwLDO73muvDFs68AkDP4WBPoN8BiMGZBB91dwk+zoj92pzTCnmpQmtugCY+eDhBvArNRkiDskfzCdXq7b6SoKYOcu5jpNddDWRYmocWFJEcK2ENEwiCQzdqucCmC+/X1M/KKPKkxYEAQpZ8iAa6mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhl6XvCRczw4aubn+qnTeJtctXiK7yGGsjmgB3bGl2M=;
 b=Amne4byRm+VvmwCNvoCo40uUpnpPi7rQ8hZEE+FDB/GtdMoYDkfygmDPqJ/CqANRKTDvxbe5ztVCKm7nF72nhxF/M+rYBqqF8D7bvp6x5szXx1OnGv+mfvl21xxroUVEFw7h5aSAxQW4wRcf3xBc3I4cX9QKGK5x7FGcEefxzLM=
Received: from BN9PR03CA0891.namprd03.prod.outlook.com (2603:10b6:408:13c::26)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Thu, 22 Sep
 2022 00:19:21 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::fa) by BN9PR03CA0891.outlook.office365.com
 (2603:10b6:408:13c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:21 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:19:18 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/31] drm/amd/display: Avoid unnecessary pixel rate divider
 programming
Date: Wed, 21 Sep 2022 20:18:12 -0400
Message-ID: <20220922001821.320255-23-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d5f33d-3415-41c9-c5c8-08da9c30189e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EofGJhGCv2ulfXVwiQ0Irli0+CK4sD56eJ1jvxQhVVRB22l80IB6f927kCXHarav0tY7O/QIc8ZqQV97B5KTqJEKVqtMNdNmm9EvpJ7moipjUMErRF4lVF0tiUDVTmJyAqwXTJnWd2ijX6sa+7cXHxVE3mWoVKAGJBDKCPlVVVQupaZIZh6biczKVdRnGE48Y712K0qdKAblqaXZ18aeVLGXV/r50EMuIbVl7+chxyhtlLtU3vrkFBwJuqtlWndPLg6dz2TJ0P4DiB/WsFRzRCOBU9VScwZJmq8/BILRbZg7Ny3gb12bMF9USK4U4toXkzgVbKi0Fu9Ibj75yEjpbogt06n8f2+56P5DswcDkjp9LBe6TEcGybv3iVVMRsJvtRyyn4f2jNJAD+ffpLDX6etHKRWmm8qQRmucJtESkbAVGZwa9Su8RlQIbUzTzUhNrZMfzw8vyTyeOS0MIdCfIfUbSpa0MUquWyHmCDH6PWqN5VWNvkcGDQXpT8QgCTSU1H8fZ7Ip0Fw9K+ivVsEdzr/OqQgppDl4zVRo5rfiJnyk20RdlTERJDBbWAq+hH+Wpl3sMZCRQHLDAQKgwkYWNbqly8Um6TGSSZ7wzuS515bLtyVC+COx+gvMB23DAiMRtw0fMzAYnzqT6hX/TSViz6tiDMbXhTN+GhzyclP4FGgWZ8zPzyrcNxUD+A4A9KgZ3FCANOUcTkm87Vg9V8Tt9ebWV937PCb2h4KN0rq035ljpR08dl+nGi4hbZLhvXNgZ0S7++hJv464EbYExgh8q2EZWUZv7HOz6reoDtWpieQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(478600001)(36756003)(40460700003)(82740400003)(356005)(81166007)(2906002)(5660300002)(336012)(36860700001)(186003)(70206006)(4326008)(8676002)(54906003)(6916009)(316002)(8936002)(70586007)(41300700001)(1076003)(426003)(83380400001)(16526019)(6666004)(40480700001)(47076005)(2616005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:21.1143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d5f33d-3415-41c9-c5c8-08da9c30189e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Taimur Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why]
Programming pixel rate divider when FIFO is enabled can cause FIFO error.

[How]
Skip divider programming when divider values are the same to prevent FIFO
error.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index 26eb04ea472c..e4daed44ef5f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -42,6 +42,48 @@
 #define DC_LOGGER \
 	dccg->ctx->logger
 
+static void dccg32_get_pixel_rate_div(
+		struct dccg *dccg,
+		uint32_t otg_inst,
+		enum pixel_rate_div *k1,
+		enum pixel_rate_div *k2)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	uint32_t val_k1 = PIXEL_RATE_DIV_NA, val_k2 = PIXEL_RATE_DIV_NA;
+
+	*k1 = PIXEL_RATE_DIV_NA;
+	*k2 = PIXEL_RATE_DIV_NA;
+
+	switch (otg_inst) {
+	case 0:
+		REG_GET_2(OTG_PIXEL_RATE_DIV,
+			OTG0_PIXEL_RATE_DIVK1, &val_k1,
+			OTG0_PIXEL_RATE_DIVK2, &val_k2);
+		break;
+	case 1:
+		REG_GET_2(OTG_PIXEL_RATE_DIV,
+			OTG1_PIXEL_RATE_DIVK1, &val_k1,
+			OTG1_PIXEL_RATE_DIVK2, &val_k2);
+		break;
+	case 2:
+		REG_GET_2(OTG_PIXEL_RATE_DIV,
+			OTG2_PIXEL_RATE_DIVK1, &val_k1,
+			OTG2_PIXEL_RATE_DIVK2, &val_k2);
+		break;
+	case 3:
+		REG_GET_2(OTG_PIXEL_RATE_DIV,
+			OTG3_PIXEL_RATE_DIVK1, &val_k1,
+			OTG3_PIXEL_RATE_DIVK2, &val_k2);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+
+	*k1 = (enum pixel_rate_div)val_k1;
+	*k2 = (enum pixel_rate_div)val_k2;
+}
+
 static void dccg32_set_pixel_rate_div(
 		struct dccg *dccg,
 		uint32_t otg_inst,
@@ -50,6 +92,17 @@ static void dccg32_set_pixel_rate_div(
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
+	enum pixel_rate_div cur_k1 = PIXEL_RATE_DIV_NA, cur_k2 = PIXEL_RATE_DIV_NA;
+
+	// Don't program 0xF into the register field. Not valid since
+	// K1 / K2 field is only 1 / 2 bits wide
+	if (k1 == PIXEL_RATE_DIV_NA || k2 == PIXEL_RATE_DIV_NA)
+		return;
+
+	dccg32_get_pixel_rate_div(dccg, otg_inst, &cur_k1, &cur_k2);
+	if (k1 == cur_k1 && k2 == cur_k2)
+		return;
+
 	switch (otg_inst) {
 	case 0:
 		REG_UPDATE_2(OTG_PIXEL_RATE_DIV,
-- 
2.25.1

