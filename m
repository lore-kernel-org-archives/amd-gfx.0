Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CA1109E542
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C10E710E931;
	Thu, 26 Mar 2026 03:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VxSnjlZS";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF85110E919
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:00:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSXJ+ZBtTx6vUbj0pcFVHrb6Ux7TzToGy+ZGPRoPoxEJ13oR3qfspnpSlsq3aVBclyADFpv9rl2DW1m8XnnkI/K767Qxfn4nqBAhqQAxiH1jsurBZg4xaeavm9ospGgriEvHQKtrTzlLhHB5yI3K4prinRnj/A/8bHEvCuO4deIKlJFNKftjz4/draDoIrczyzACkSCXDfhURnNeM/pQg0RIsjVFx+cponIwfyIYUB0Dy3HN4TLEk+qhxPSfUvvD3p8oFP3NYYlGlr5Icn445CqlWYKfkr535nF4fFGyDkbV87dhxUQa/hdrhu254Wds5MGX2VQkB37nuscT3gMq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnO9/sRL6yg4D6JjiBzLTr48LlDUHDZIqM9s+7XX0XE=;
 b=klyl9SfeQqRdUM3lAtT1+JvO4G37ZB+hzy4JnQUVa7jxgN1wjEzs5j40zVg5YwiEs1THUnkGUw0Z2f9VAa6bh2UffYGjCzl6cKbR0BP68QIz/6FAGeyXelYV/BHWdHgPr1U+WuCw+YyR+hnlTa2xteyOTdBZB1Olv/qXSMw/IoAMrJKX9tj57GZLpA56jS9k8S0jDX5hmny2hsIn7aLIAIILB51ONO70fn5kD/FGGidzXpVesjAfD898Lhs70IwNJknpzdYdKi1FSrIxd2XD1x3yELRE090HVg8vPz5nrqQ+sdBzd6zg7BxcdZQST5VaFZOyI5C/Yw+MVsSytxVnZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnO9/sRL6yg4D6JjiBzLTr48LlDUHDZIqM9s+7XX0XE=;
 b=VxSnjlZSI/kc4qUUpGKn007Kklr0oNbNPH1l6bXG3eHZrtub3BanrcsMC+Dy6uzX0UtJ0/nYQ+GZcVgreXZq4zJp2o6IWrZrutQ2VER/CUE3RVLYn/J6XQlQGXLpjEF+Q/LKPHm1Zc+92uxZIAPrYvR4409mxpl1/03ja6O1uFo=
Received: from BL0PR0102CA0024.prod.exchangelabs.com (2603:10b6:207:18::37) by
 LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 03:00:48 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::43) by BL0PR0102CA0024.outlook.office365.com
 (2603:10b6:207:18::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 03:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:00:48 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:00:44 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 06/30] drm/amd/display: Fix bounds checking in dml2_0 clock
 table array
Date: Thu, 26 Mar 2026 10:56:57 +0800
Message-ID: <20260326030153.406612-7-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|LV3PR12MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: c7cbf1d3-1f72-40b3-c33a-08de8ae3e1d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: l5prKryskmzYj0uXm7vheMQ9GksPwuZzC8kAPDN4KFOEy4i1Bw0VhQA1xvXZ2vNAnR40fbWQupsWvGDD1QSHJlNKeIwFWJXTeU7U0FpFYYqQ1GAxMDByv+WuE7O1Bpqw66aEY6wtXlI3wa9V93jrOh1APmmSUQTFVEXCZxUeyYb7XqvYyIIDibP5hKa/qunL9oTYak7VyDccx8UIAhuISm/Cjv8E/YqvqNEDeiKp81cTr3etDoU6YI4JnyWoTDHV1Tuyk9FK23Fe7eThXR/M53o1QK7msfgFj7HDYnuCxX+CEZ4B0p/fxjCbJkTPWn3uwAq+LUyCoVqEqi0Ncxzbe1aTFzM/xPRZLP0PQrVHtGgsCFk4kJg3Rbl5dlfUxJM57sp2CjOTXZh2HhspJorwd3XbCG+YVBTAYK+95oPOjbMk5RGjyBnC98p85AuNo0oKFrXme67t53gxzUECoAmX+TqH/cv0ildgRwOcqPZdZZ8LL4eQ1iHq3nAYrzJ50s2lxbeqC92KsSfeWMIWG/TylfGt39jnxOJQDPhXC29VLsfyjIErcJwsF4k4KMELZnUtNR+wmGinKnzk1xY8/is1LdxDI32Y49JOlSmLKrkVHaZYfqWj++/CqH4Up8X6WvERXheElyW7boD9QnzIYQw8VbQ8nPOhVekNARBBvOw+s/MSckAiwzoMwPr/barctW9X7JFiHGlt7QmTDqhdLTm4qPDT7Ue/esoRkudjrdxkY2ggsTSmHPp8Ry6min4bUHV7H2fbcacycragni6nuIc7mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +SBXCd9WinNJXNxv40Xn48MHEBu337zw34Luvj+S4SKm9V3jhzkPqMwf2XjXWN07UUcU4yYT6Z0rmbxww3KvyOLIP8dW6mFYQRDP8DffjU4GMiQQQ7jmFKKYejRRqlPsRNhJUQVmGie7/NrxMK7CBdrEgPyI/9t5g75C+RdFGSqmdk0WZbv3gXurxekFzznwvI72++y8KjseyuTdMYUGJHzT1/5vRDOUsT2JPb80PCAg69WpFgBXOKgqFwybWofL0ekk9dyaiFD7BrOcvrxAGHRLfDiFNNRA7xj2G06yClmffTDehM7jc6r3xlkppAYxkCU+H9yBljs3IMccpXbAKem53mCDA1yhUJeRtN6xRtPCiCXaRNYFrByz8RAfnZfuAX9208cCtY6foovACMFmd0J38ZvK0+DhUamHBw9yhlTxvYUe6so1yOnXGV5Cb5co
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:00:48.3959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cbf1d3-1f72-40b3-c33a-08de8ae3e1d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214
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

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
Multiple locations in dml2_0 used num_clk_values-1 as array index
without checking if num_clk_values > 0. When num_clk_values is 0,
this results in accessing array index -1, which wraps to 255 for
unsigned types, causing out-of-bounds memory access and potential
crashes.

[How]
Add proper bounds checking using ternary operators to guard all
num_clk_values-1 array accesses. When num_clk_values is 0, return 0
as fallback value instead of accessing invalid memory. This prevents
buffer overflows while maintaining backward compatibility and provides
sensible default behavior for empty clock tables.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      | 20 +++++++++++++++++++
 .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.c |  9 ++++++---
 .../dml21/src/dml2_mcg/dml2_mcg_dcn42.c       |  9 ++++++---
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
index d17e59d684fd..ab0b4a4b5d65 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
@@ -279,6 +279,26 @@ static bool round_up_and_copy_to_next_dpm(unsigned long min_value, unsigned long
 	bool result = false;
 	int index = 0;
 
+	/* Guard against empty clock tables (e.g. DTBCLK on DCN42B where the
+	 * clock is tied off and num_clk_values == 0).  Without this check the
+	 * else-if branch below would evaluate
+	 * clk_values_khz[num_clk_values - 1] with num_clk_values == 0, which
+	 * wraps the unsigned char index to 255 — a 235-element out-of-bounds
+	 * read on an array of DML_MAX_CLK_TABLE_SIZE (20) entries.
+	 *
+	 * Semantic: if the clock doesn't exist on this ASIC but no frequency
+	 * is required (min_value == 0), the request is trivially satisfied.
+	 * If a non-zero frequency is required but the clock is absent, the
+	 * configuration is unsupportable.
+	 */
+	if (clock_table->num_clk_values == 0) {
+		if (min_value == 0) {
+			*rounded_value = 0;
+			return true;
+		}
+		return false;
+	}
+
 	if (clock_table->num_clk_values > 2) {
 		while (index < clock_table->num_clk_values && clock_table->clk_values_khz[index] < min_value)
 			index++;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.c
index a265f254152c..eab13e1c96fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.c
@@ -178,9 +178,12 @@ static bool build_min_clock_table(const struct dml2_soc_bb *soc_bb, struct dml2_
 
 	min_table->max_clocks_khz.dispclk = soc_bb->clk_table.dispclk.clk_values_khz[soc_bb->clk_table.dispclk.num_clk_values - 1];
 	min_table->max_clocks_khz.dppclk = soc_bb->clk_table.dppclk.clk_values_khz[soc_bb->clk_table.dppclk.num_clk_values - 1];
-	min_table->max_clocks_khz.dscclk = soc_bb->clk_table.dscclk.clk_values_khz[soc_bb->clk_table.dscclk.num_clk_values - 1];
-	min_table->max_clocks_khz.dtbclk = soc_bb->clk_table.dtbclk.clk_values_khz[soc_bb->clk_table.dtbclk.num_clk_values - 1];
-	min_table->max_clocks_khz.phyclk = soc_bb->clk_table.phyclk.clk_values_khz[soc_bb->clk_table.phyclk.num_clk_values - 1];
+	min_table->max_clocks_khz.dscclk = (soc_bb->clk_table.dscclk.num_clk_values > 0) ?
+		soc_bb->clk_table.dscclk.clk_values_khz[soc_bb->clk_table.dscclk.num_clk_values - 1] : 0;
+	min_table->max_clocks_khz.dtbclk = (soc_bb->clk_table.dtbclk.num_clk_values > 0) ?
+		soc_bb->clk_table.dtbclk.clk_values_khz[soc_bb->clk_table.dtbclk.num_clk_values - 1] : 0;
+	min_table->max_clocks_khz.phyclk = (soc_bb->clk_table.phyclk.num_clk_values > 0) ?
+		soc_bb->clk_table.phyclk.clk_values_khz[soc_bb->clk_table.phyclk.num_clk_values - 1] : 0;
 
 	min_table->max_ss_clocks_khz.dispclk = (unsigned int)((double)min_table->max_clocks_khz.dispclk / (1.0 + soc_bb->dcn_downspread_percent / 100.0));
 	min_table->max_ss_clocks_khz.dppclk = (unsigned int)((double)min_table->max_clocks_khz.dppclk / (1.0 + soc_bb->dcn_downspread_percent / 100.0));
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c
index 1f67cbc2c236..3eaeff39ee79 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c
@@ -54,9 +54,12 @@ static bool build_min_clock_table(const struct dml2_soc_bb *soc_bb, struct dml2_
 
 	min_table->max_clocks_khz.dispclk = soc_bb->clk_table.dispclk.clk_values_khz[soc_bb->clk_table.dispclk.num_clk_values - 1];
 	min_table->max_clocks_khz.dppclk = soc_bb->clk_table.dppclk.clk_values_khz[soc_bb->clk_table.dppclk.num_clk_values - 1];
-	min_table->max_clocks_khz.dscclk = soc_bb->clk_table.dscclk.clk_values_khz[soc_bb->clk_table.dscclk.num_clk_values - 1];
-	min_table->max_clocks_khz.dtbclk = soc_bb->clk_table.dtbclk.clk_values_khz[soc_bb->clk_table.dtbclk.num_clk_values - 1];
-	min_table->max_clocks_khz.phyclk = soc_bb->clk_table.phyclk.clk_values_khz[soc_bb->clk_table.phyclk.num_clk_values - 1];
+	min_table->max_clocks_khz.dscclk = (soc_bb->clk_table.dscclk.num_clk_values > 0) ?
+		soc_bb->clk_table.dscclk.clk_values_khz[soc_bb->clk_table.dscclk.num_clk_values - 1] : 0;
+	min_table->max_clocks_khz.dtbclk = (soc_bb->clk_table.dtbclk.num_clk_values > 0) ?
+		soc_bb->clk_table.dtbclk.clk_values_khz[soc_bb->clk_table.dtbclk.num_clk_values - 1] : 0;
+	min_table->max_clocks_khz.phyclk = (soc_bb->clk_table.phyclk.num_clk_values > 0) ?
+		soc_bb->clk_table.phyclk.clk_values_khz[soc_bb->clk_table.phyclk.num_clk_values - 1] : 0;
 
 	min_table->max_ss_clocks_khz.dispclk = (unsigned int)((double)min_table->max_clocks_khz.dispclk / (1.0 + soc_bb->dcn_downspread_percent / 100.0));
 	min_table->max_ss_clocks_khz.dppclk = (unsigned int)((double)min_table->max_clocks_khz.dppclk / (1.0 + soc_bb->dcn_downspread_percent / 100.0));
-- 
2.43.0

