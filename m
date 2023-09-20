Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C161CE79A8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFF1610E42A;
	Wed, 20 Sep 2023 03:19:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D6A410E42C
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:19:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgqHFrQzv2tc19F51369A1Kigh4y9nTLfZWMu9i6ToYE6cAmUIJo9PT63bfw6UkauroIxU5c1fHsFpL+QtoRwL7BlP7Id2RzL0u9umW04lJekXc22T7nYi34oiWh2eL8WbV2Gsh1xyxuaete1kVX2dj6bSq5JeOXv/g8fkUd7r8dEkupGFGIO3Rw23cvx21sGvbwlTrkIJKwlBjy1QcAS/ndJh+fSinRXst6fs5xPoQKo3jxzoWq/FuVDItNO3+Scg6L/oEyTPNuDI32wRCst68WHul/72XlVprXbuWO0GtbQzbUhCEq96EZz4kGR6inw4UN1aKethTDKKHbxaOFig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mquo/HDVXZkl6c1ZRDOjrwZ+hZl6umZ8JeO8NF5gSTE=;
 b=OF08QxA9GTiaAzS2vmz+v5m1WduGaNMbz9A9mwTQHqHHyDKVNxY6qseKj3edbywnBkOtk9A6Og+vaggmZ+wtqme0iuS/zwZP/e+mnteX9DOcKT0IjntZDUTR4NW6jXILj+F3hWinkdW6Z3s6LIDS6oecJL8iB0450QtTnNd/XwxHDlU2/J9xpK3INYEzPkb9/VG70HR/hDWX71yy9BA4S3FqEAyBxgF4i4ulCAZKr9ZXCSGwTGMqA5/V4+UDZrVRNm0DxjoN7oVPV8Gxq9iGcZ4jep6miWV3CFlQIzl8gJ/syGSYnVuPZTRa7riFxMa8XbmVLN37xFHT4ZalOsWO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mquo/HDVXZkl6c1ZRDOjrwZ+hZl6umZ8JeO8NF5gSTE=;
 b=akppz2IzF7HytKZcdTfuE4oxO6qtLIyfzRtXG4zrAc9rGA5vRnD9VQD2Az/reB4xQIxUc53PUwTsmPqKkHOTKDZpO26BxBWZtB/5FogFnQ0hm7z8wVyZhYHAEO2r/sm9SZBllP089ZUMH6GPgMczxGvq/SEHKR7Wz5bdzGnkXIQ=
Received: from BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::8)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 03:19:44 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::ab) by BL1P222CA0003.outlook.office365.com
 (2603:10b6:208:2c7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 03:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:19:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:19:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:19:42 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:19:37 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/19] drm/amd/display: block MPO if it prevents pstate support
Date: Wed, 20 Sep 2023 11:16:13 +0800
Message-ID: <20230920031624.3129206-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920031624.3129206-1-Wayne.Lin@amd.com>
References: <20230920031624.3129206-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 16228d9c-1a44-4ce9-283b-08dbb9886f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iniJcgVQrttTgzuviOsQxnKmQLqU8h6uaGGeKjkcbIqtrDdc+LAQkizimQ3Uxwzcs0kvPqwjp2fLShc8bGwWBelPWYlAOnD0piuhjXixx6rIU9nUI45rTSDMXG/8QRtPGjWIe1kWJ4QTvRsWIguz0Pq22jD8SOuNecLD212JPovLkoAvAOz6uAg8Lhmi/D4FsesipdxSc62tk+0c81BXXI7f8Q9M356h7Je//9WhPVZgnjEVpj8oSrfCT9AOqFCnmOPzYA4Q5jxlj12e2X3Pd4or7+/meKAFWTX42qd/e7ZTrBi6zIU2Z5jQ3V22kuDZnJsigVvZF9/gv3D64kdXu/1FGlhNp1xQnQAu1VFJJAug/mzGcvp6kPFZqi9Vt85v4VTXRMgmu1cLSPMDZhD6kCuoBd6Vgq4pDlBn6jE82pVOaZgFKq97VG026l9nmvm5NhmSDC86EJn7ztvtMbO/wnuC5vgN/wiyUzlZrxCTYVQmBsicCTTzUN1UIzUXYa9yBSe/kRvo4PVF8DbeytfjNakbC63rI/clEa6ry+GI1T3Iubp2nDKhr1dY8bvdhIN7mReUtRV0FvkfSuiQm4LnDVZpvwDwsgUeb9N9mR9sFMW8tabbA0PCqDpQOH8x/PSEaCn+lvAWs1gWh91iLEjSaSaGl6+X6JEqfM9gcD2iMtlzAEvuhfDALlISY8Uf9gPuG/sRldYZtcPEtozIZGz4+xzwByWnUsJGwXLmoaYmcSEdwNUyp+Imj+8YjNJQdgsNlXfToD8lbu/YEhJU35TViw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(40470700004)(36756003)(40460700003)(40480700001)(4326008)(5660300002)(83380400001)(36860700001)(86362001)(8936002)(8676002)(41300700001)(82740400003)(356005)(6666004)(26005)(426003)(1076003)(336012)(2616005)(7696005)(47076005)(70586007)(81166007)(70206006)(478600001)(2906002)(6916009)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:19:43.9384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16228d9c-1a44-4ce9-283b-08dbb9886f75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>,
 Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

This change adds a method to block mpo when it would cause us to
exit pstate support. We should block mpo by default where MPO
causes issues by preventing pstate change.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c        | 17 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h             |  6 ++++++
 .../drm/amd/display/dc/dcn315/dcn315_resource.c |  4 ++--
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a2360dfdc83b..293489c41086 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5420,3 +5420,20 @@ void dc_set_edp_power(const struct dc *dc, struct dc_link *edp_link,
 	edp_link->dc->link_srv->edp_set_panel_power(edp_link, powerOn);
 }
 
+/*
+ *****************************************************************************
+ * dc_get_power_profile_for_dc_state() - extracts power profile from dc state
+ *
+ * Called when DM wants to make power policy decisions based on dc_state
+ *
+ *****************************************************************************
+ */
+struct dc_power_profile dc_get_power_profile_for_dc_state(const struct dc_state *context)
+{
+	struct dc_power_profile profile = { 0 };
+
+	profile.power_level += !context->bw_ctx.bw.dcn.clk.p_state_change_support;
+
+	return profile;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ed9b72ac369f..faf897ac75d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2407,6 +2407,12 @@ void dc_print_dmub_diagnostic_data(const struct dc *dc);
 
 void dc_query_current_properties(struct dc *dc, struct dc_current_properties *properties);
 
+struct dc_power_profile {
+	int power_level; /* Lower is better */
+};
+
+struct dc_power_profile dc_get_power_profile_for_dc_state(const struct dc_state *context);
+
 /* DSC Interfaces */
 #include "dc_dsc.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 8e3acb92385b..ed804439fb7e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -137,8 +137,8 @@
 #define DCN3_15_MAX_DET_SIZE 384
 #define DCN3_15_CRB_SEGMENT_SIZE_KB 64
 #define DCN3_15_MAX_DET_SEGS (DCN3_15_MAX_DET_SIZE / DCN3_15_CRB_SEGMENT_SIZE_KB)
-/* Minimum 2 extra segments need to be in compbuf and claimable to guarantee seamless mpo transitions */
-#define MIN_RESERVED_DET_SEGS 2
+/* Minimum 3 extra segments need to be in compbuf and claimable to guarantee seamless mpo transitions */
+#define MIN_RESERVED_DET_SEGS 3
 
 enum dcn31_clk_src_array_id {
 	DCN31_CLK_SRC_PLL0,
-- 
2.37.3

