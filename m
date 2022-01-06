Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A95DC433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 16:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BABA310E868;
	Thu,  6 Jan 2022 16:31:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A96110E868
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 16:31:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzrqSjXvSWCLThWZ/zaW5TfexsuwGy69Kws4L1OxoEtEoA6d4NAkK5f6wyGXah+x9DdHbHUjmhz5gUkBlAIsc635CCXHybuf/00UqW3sPLh5cbeLdpvTRPF1xHa0b280Ny9+pVN/q9J9zHDiPFR7g6iE64Hwq+5/eNI2ROjZFRDmepz+1Upl1FOOJ5ihQuj6LSEk/LgqyCVhyWV28ojUeBbuk2Kg/brIbOtQ/tQoGDKPFqA5uxgR5xfgiuquZ1H8ogjTTrTLZxTFLF2+7jLP4FNOKu84humWV5ay0sNJHYXHwwfjZaTgl3u99f+5Z+y1QAeonQTMbvZ9fur0uYPtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjiI/EfbvdWKabhyxwosJwicNylNwiuWQMjsIqPCBQ8=;
 b=PV1xoyoq8nj9DWkmDJ+WtQJcjQCD0+lUDfs4wmHuUilsb6zZw7JvuDiSe60+cCsVy6QxyWzKOuTiZ+YQrQM9jD8E1nYeF4IVRXFf9B2mYILKhuAdGfiMYQTjJmlunSE6b+PlpIjeRkV9fBRsXwUKLzmcKVgik6XqGbvJ1q+8CXS6YKwdYH6kMAu7xVnY5DRV7Q7w9Od3wozeJFHjgPyiR6NYX9Jf0r496btaI8TYFcvabWR0MugMwL2cxX7wpGbR+Xtf157jdatgg0LjTokSyi7QHFCwAuFR7n1feM7s06NLIK4Ejp8twmujotgfjHHB7RyG5qvpfByn6RKDnKG6DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjiI/EfbvdWKabhyxwosJwicNylNwiuWQMjsIqPCBQ8=;
 b=k3DOR3/EE9PGf147rb/DggA2ZJq5Mqq9o1eE2UMiV8ICRAjm5PYcARhWMxkObgOop0Y3XrPrWSscfGHGI4CbhVd59ojs3r6O+2V/gQaqysHKNgPstvciAVFNpKKdx7wN3KsF/LXm1LO1f4j2gNU40ji/ZnC/P+h4/ZuQ08THCUE=
Received: from MWHPR15CA0066.namprd15.prod.outlook.com (2603:10b6:301:4c::28)
 by MWHPR12MB1326.namprd12.prod.outlook.com (2603:10b6:300:10::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 16:30:58 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::1f) by MWHPR15CA0066.outlook.office365.com
 (2603:10b6:301:4c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Thu, 6 Jan 2022 16:30:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Thu, 6 Jan 2022 16:30:58 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 6 Jan
 2022 10:30:56 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 2/3] drm/amd/display: Split out checks for applying HPD WA
 into a separate function
Date: Thu, 6 Jan 2022 10:30:53 -0600
Message-ID: <20220106163054.13781-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106163054.13781-1-mario.limonciello@amd.com>
References: <20220106163054.13781-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd1ff2e8-25a3-4f6a-bef7-08d9d131eb74
X-MS-TrafficTypeDiagnostic: MWHPR12MB1326:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB13266EF2948C1F669D5C6EE0E24C9@MWHPR12MB1326.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PXyiuyObH62dbEdbNKR5PJi4xGACKUQpbqItaYWLl7sQNvMmwbs+cM0uNOKe5M4YjI8lhmsATHEI10w+EX4svJ+qIuxhJe3gwc7BGjscWU28yRctsJZ0+8AGWzWkvE4hO3sR5tekGB69nUAStUuP3bfLvmCImIqvfL66OvIdgVJIk5rcIvnEb7n6n+HPeC/HKn72FYWwx6lvgAqYBjRKUsIawVDhrily/coglhhkKLXyQtKRRXLQq/isiYiTYoTqRh0LaiGS4PMh7qVKRWMI5M85hUnh7z7kxq6rXtupZIc7AvIM+M3uDYtZ7Eh/oBO/C28OfD2EbtNbpK0m+HYvNl8uGKZvoOhlkRIRy6LN2/QhH2f7mjQfO+Zu46LkLgRP8hPV5qw6WfFX521pfOy7adR3SojNj1SkfOkiwlGmvKYAyMOyvBSOPk4KTBzszrjiy1QMVaf8huPh5AMcRUilQ3f1KsrX8LuPyxacg0N7rS/vfqlUYTkB9KTWouBJgHq3mJQxFuZ+9MZ/w/ZUScXjpSUzIVMqmA5Iriu4QuKIDzxMfTSghHJFg+/BMqNSltE32ktdwiFKqzm60sKee3fU/1DDv/Td2qkr30UnJgDqK/ys4jQ2EhZHGvZgLDblIW7ZSHVYRN/i8JjaFAkQYwQaX/kTUh9LGIdbzISCyltcxGMZxh/FoEBJI6G6G9woEazW46iuhqjqNePuh2RwJd4TZWOkKhluax0v2d7Hii8VZEagJuomDqLlkwSYOGYa2/wmBqlMpN2SwbjT+YJqh7guMY2Z/9D2x92bha0KRzrCyDs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(426003)(316002)(70586007)(82310400004)(26005)(36860700001)(44832011)(8676002)(16526019)(6666004)(1076003)(36756003)(4326008)(8936002)(186003)(2616005)(2906002)(40460700001)(6916009)(70206006)(336012)(7696005)(83380400001)(5660300002)(356005)(86362001)(47076005)(508600001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 16:30:58.1972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1ff2e8-25a3-4f6a-bef7-08d9d131eb74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1326
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will make it cleaner to read through the logic for an upcoming change.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from v3->v4:
 * New patch
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 30 +++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index fbda42313bfe..20974829f304 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -120,6 +120,23 @@ static void rn_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 	}
 }
 
+static bool check_really_safe_to_lower(struct dc *dc, struct dc_state *context)
+{
+	int display_count = rn_get_active_display_cnt_wa(dc, context);
+	uint32_t hpd_state;
+	int irq_src;
+
+	if (display_count > 0)
+		return false;
+
+	for (irq_src = DC_IRQ_SOURCE_HPD1; irq_src <= DC_IRQ_SOURCE_HPD5; irq_src++) {
+		hpd_state = dc_get_hpd_state_dcn21(dc->res_pool->irqs, irq_src);
+		if (hpd_state)
+			break;
+	}
+
+	return !hpd_state;
+}
 
 static void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
@@ -128,12 +145,9 @@ static void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	int display_count;
-	int irq_src;
 	bool update_dppclk = false;
 	bool update_dispclk = false;
 	bool dpp_clock_lowered = false;
-	uint32_t hpd_state;
 
 	struct dmcu *dmcu = clk_mgr_base->ctx->dc->res_pool->dmcu;
 
@@ -148,16 +162,8 @@ static void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 		/* check that we're not already in lower */
 		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_LOW_POWER) {
 
-			display_count = rn_get_active_display_cnt_wa(dc, context);
-
-			for (irq_src = DC_IRQ_SOURCE_HPD1; irq_src <= DC_IRQ_SOURCE_HPD5; irq_src++) {
-				hpd_state = dc_get_hpd_state_dcn21(dc->res_pool->irqs, irq_src);
-				if (hpd_state)
-					break;
-			}
-
 			/* if we can go lower, go lower */
-			if (display_count == 0 && !hpd_state) {
+			if (check_really_safe_to_lower(dc, context)) {
 				rn_vbios_smu_set_dcn_low_power_state(clk_mgr, DCN_PWR_STATE_LOW_POWER);
 				/* update power state */
 				clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
-- 
2.25.1

