Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0D606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=meav2C6b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E237410F8D2;
	Wed, 11 Nov 2026 01:42:39 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013069.outbound.protection.outlook.com
 [40.93.196.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E1E10F8D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:42:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfGMJS7ApQENKR0ywh6F3FqSowP9Capu+NEpZiOos5EZUlAr1hhpcRnuWWTkl+K09yCVB9AyUMLviynyOIDEH0JwKBEXa58T+Wb0lhfhizvdjbMkrhawf15fVYeUDVUWqVUZPUKAoohVDJLNLBicRmSCMG76GVJwDi1gphDfYtrlJbxodE5gllxumr+uvHcmVSLy67l9Pn7jrJNRhZDvBjQCu+TzariWYmYtDcOGKFiOIjl2aWRhy5s+TRWFsNqil1+3ugBtwSEu5UbACnb3Q/zW2cXGJpu7i3daUMSS9D4SZcCFu3JiuCZCKUsnNYEZ0GjS21VA31+RUWk5u4n2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BB6tZB8CCZNvA0LIzx8VFxeRuVQy+eQ3xhZa2eZGJDw=;
 b=c8sNam9vEpW4e6nIFsDgv4n6U7Gy0sMhiYXAtVnwAJ0O6eKWoJ4Scgj4qOKE1mI6MxAZ7e99WH9cE8ZtZnjsAn9+Xq/IDU3foW2B8qED8YKRd6gAfpJWkMCc0ZL4n0ALW7+QWJBWBGb4nF7LObQ8+SuOi8FCM41RRE3l6c+8N8LousuklZNH0U/+a0TUPO/77cRsxMmRWjJbeG4QyzOtTvu9RAX2VEQGLSNLwziVua153qjUCEP/g0NLfPFbWdBgpzNmHtARJ9lk9FcHp+8FsOgZHfPODzfwkioCoFACpMuD2UXQ8Jd7nk52gsOrFOVYti2aFq/BbkJhAVAgMUNczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BB6tZB8CCZNvA0LIzx8VFxeRuVQy+eQ3xhZa2eZGJDw=;
 b=meav2C6b6kXIlN0jmh3jzH1qrdhRA31lRWgQd8dRGm96BUXk66q8tTWKXnpSqrqAC5rSO6OZdn70axgeOuPkZUwNH0bzzBpL1Jjksm4DelLVavDj7Knt3GxbIOKEGeCi5LFrndMc5jSxt9/Mw0VTNatfhoTlrmKIAePAWsoLlfg=
Received: from BY3PR05CA0035.namprd05.prod.outlook.com (2603:10b6:a03:39b::10)
 by BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:42:27 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::a7) by BY3PR05CA0035.outlook.office365.com
 (2603:10b6:a03:39b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:42:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:42:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:25 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:42:21 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Gabe Teeger
 <gabe.teeger@amd.com>
Subject: [PATCH 32/74] drm/amd/display: update dcn42b based on dcn42
Date: Wed, 11 Nov 2026 09:28:38 +0800
Message-ID: <20261111014100.3596072-33-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|BY5PR12MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: 50fd0954-7c52-4b93-e926-08df3f950a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|18002099003|22082099003|6133799003|3023799007|56012099006|261026140227099003|261028144727099003|261022105027099003|261102123227099003|261021121427099003|261021123027099003|11063799006|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: t8vlskJjpcqYJsXFApzgeiZCIMHyuubv9QtbPIIkPC/k+1WIsUmGQrA7rj238aOsckX4f0FPE1vWF9rjmH3605GhLwkYeom02N1X5bJzzBjLAUZANTOC6PCzICYXkTV/NBf9iR0O4lUJixuMMFzw8L/Q77TMNAhJyqONCu1wYQPI251gX+HFbyxBaiJ9cLaK7cWy1djvqxBkD0pRSuADJIzX2cw4drTYBR6iCvRRQeXYQ4hmrCtM634UMDSkc+RcfXs4YHSa5LuNh92U50uEeeBvODkYZ38833TYmAuw5+w0oIys01oDpQnMySg7JXTz7GCUG8DuE8VRGXOlfAgX8krgF9qNhVrSQiwUg9n7oQq25zrP7JKwM41/+5B+Ez39oYULqaLT3i1CNSjK/mq7mm18apUL1H5ubkaQFl4vpenEdDrNpsfZWCW6stt4WW/7TxrQOM7DwjHnz7Lp0kn0zyaVFH8t/0NanlQUkEWZs1ZtiJj/nxhVpcue48hslOPJZJWUa+nlt7W7YxKm2TVUySFKyX608K6H57QV4TQMKtD6Ca7H5rUMBKmPbZGfQBlpZ1tlSNV0MS+muP2aiofy1IC/W9pjP1W1ktvHYvDHR9ColucFvx4mU1VmKA26Kc0mP1tdKY22HX1tYD63V9FKs2rQEonf28BcD9NHu/wRsceo+ZC7NYzzA4jybeTNltHwT+DUl+Ib/mKHYZWIlLKV7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261102123227099003)(261021121427099003)(261021123027099003)(11063799006)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k27SZxV2pubD9hSZDFPEryfkc6/YkbvmnXEWuQrAsOZZkYP+3Fbl64kF8RPEFyZat/UyEiFOB3j93IbktAqdYYSLgqRTWOO7kMc/JHNiZaBdNciVIO8r4ZLhAfErsN59k3eym5VM1LiuuAgls0jlkm9CCgRsIN/ACph3xmt8WQx2KEBSKP2NM2YhjBqSzwEtQABJxiCF5Z56JfheTjI/MHR8NjXoYmTYJl7KlIGooSk93iyKxX9x86f3KASLv6Wpg0ZgjgTqJAvlq2ZBQqCzEawUTIdFlW8GnrbUJ7IYoMkfgWYg2v/6qEqaqWnU5bI5xvmUZp65Slkhr/dG1LcIgJeFTY+N2L5fPCqrKRhqjdRQ3m7mSEnDvo1P8oQIoNXigge8tAM1clWF77/SOlUmlYDrLx/LwNvg1u/s3AOG9iSB6gLafPM4FmP4VwPmGtJI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:42:26.4575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fd0954-7c52-4b93-e926-08df3f950a53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Charlene Liu <Charlene.Liu@amd.com>

Align DCN42B clocks and power gating with DCN42:
1. On DCN42, re-read DTBCLK while it is already enabled and turn it
   back on when the measured frequency drops below 590 MHz.
2. Align DCN42B HUBP/DPP power gating with DCN42 by disabling both.
3. Remove the unused DCN42B 300 MHz AC DCFCLK macro and the comment
   that described a wall-power floor. The function still only clamps
   a user force-min override to 200-600 MHz.

Cc: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  | 24 +++++++++----------
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        | 11 +++------
 .../dc/resource/dcn42b/dcn42b_resource.c      |  4 ++--
 3 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index 405145889ba2..d125ea196cb2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -258,21 +258,21 @@ void dcn42_update_clocks(struct clk_mgr *clk_mgr_base,
 			dcn42_smu_set_zstate_support(clk_mgr, DCN_ZSTATE_SUPPORT_DISALLOW);
 			clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
 		}
-		/* Only attempt to enable dtbclk if currently disabled AND new state requests it.
-		 * For dcn42b (no dtbclk hardware), init_clk_states sets dtbclk_en=false and
-		 * new_clocks->dtbclk_en should always be false, so this block never executes.
+		/* PMFW may stop dtbclk on idle, so re-read the actual frequency even when
+		 * clks.dtbclk_en is already set, and re-enable it if it has dropped.
 		 */
-		actual_dtbclk = dcn42_get_clock_freq_from_clkip(clk_mgr_base, clock_type_dtbclk);
-
-		if (new_clocks->dtbclk_en && actual_dtbclk < 590000) {
-
-			dcn42_update_clocks_update_dtb_dto(clk_mgr, context, new_clocks->ref_dtbclk_khz);
-			dcn42_smu_set_dtbclk(clk_mgr, true);
+		if (new_clocks->dtbclk_en) {
 			actual_dtbclk = dcn42_get_clock_freq_from_clkip(clk_mgr_base, clock_type_dtbclk);
 
-			if (actual_dtbclk > 590000) {
-				clk_mgr_base->clks.ref_dtbclk_khz = new_clocks->ref_dtbclk_khz;
-				clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
+			if (actual_dtbclk < 590000) {
+				dcn42_update_clocks_update_dtb_dto(clk_mgr, context, new_clocks->ref_dtbclk_khz);
+				dcn42_smu_set_dtbclk(clk_mgr, true);
+				actual_dtbclk = dcn42_get_clock_freq_from_clkip(clk_mgr_base, clock_type_dtbclk);
+
+				if (actual_dtbclk > 590000) {
+					clk_mgr_base->clks.ref_dtbclk_khz = new_clocks->ref_dtbclk_khz;
+					clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
+				}
 			}
 		}
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
index 33f0099075c0..e18d705103ba 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
@@ -393,18 +393,13 @@ uint32_t dcn42b_get_clock_freq_from_clkip(struct clk_mgr *clk_mgr_base, enum clo
 
 #define DCN42B_MIN_DCFCLK_MHZ 200
 #define DCN42B_MAX_DCFCLK_MHZ 600
-#define DCN42B_AC_MIN_DCFCLK_MHZ 300
 
 /*
  * dcn42b_update_clocks - DCN42B wrapper around dcn42_update_clocks.
  *
- * Establishes the DCN42B force-min-DCFCLK floor consumed by the shared
- * dcn42_update_clocks(), which applies it to new_clocks->dcfclk_khz:
- *   - a user override (dc->debug.force_min_dcfclk_mhz)
- *     wins, sanitized to the [200, 600] MHz supported range;
- *   - otherwise DCFCLK is floored at 300 MHz on wall power, and left
- *     unconstrained on battery.
- * dc->debug is restored afterwards so the override survives AC/DC transitions.
+ * Sanitizes the user force-min-DCFCLK override (dc->debug.force_min_dcfclk_mhz)
+ * to the [200, 600] MHz range supported by DCN42B before the shared
+ * dcn42_update_clocks() applies it to new_clocks->dcfclk_khz.
  */
 static void dcn42b_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index 784cce09b89b..338c506588d9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -803,8 +803,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.clock_trace = true,
 	.disable_pplib_clock_request = false,
 	.ignore_pg = false,
-	.disable_dpp_power_gate = false,
-	.disable_hubp_power_gate = false,
+	.disable_dpp_power_gate = true,
+	.disable_hubp_power_gate = true,
 	.disable_optc_power_gate = true,
 	.disable_dsc_power_gate = false,
 	.disable_dio_power_gate = true,
-- 
2.43.0

