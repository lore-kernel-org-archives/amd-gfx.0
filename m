Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D61C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9E7E10E858;
	Wed, 25 May 2022 16:20:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA5210E677
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEythOPVXyABbCERDgzQhmDkppb/1PHa3Sc7ozU1+eBMyb0YFIaluxmGIHDAikHL1pwpCgVviERlVn3GCoAV4XgCNPfz8uVQ3imLeyNFgIllXnchmxrX9cVAkUxOSWteZ3G4UH9sNIjRV2lHO6PFAhuk+jINW4RyCohHWKdmEGauNDbfQaGttjagZ+jC6OeIBYibdING7mayrDZL0qxchzFGRIM/efnMyAVjagQ1+qjFNVQ4SHxYUy+JGuvrhCYnI8ylL/Bzf1PxjjMZoK+I1ZCNNQ+et+aJTmI0fYeE5Oe2cH5pA6LkuBrbBxxX/mf/Fxy0PEE3j41Jdjl3LVGGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DA4/r7+8nL6+vtB/ayIdBkB5EbtGIK095UK9anJqQFQ=;
 b=bSfFrI1TUEBdCeKWQh5ZYM3I3bT/8tHOnKPqiRuLWXghG8N8/SgFz4aPdR5uxe3YJIFLkHxB5q55tZoJkplTWi/qr45piTYCZTUGtwTy94WUvhdeKQfuj0cnDAqC8FYqo+8HOkqtKy4RlflvirscojwxC3fOeBmt/8y2M4JDeesN9jD2KOZv26XggTgQwYLtNaTpzs31zCeSVyxZKUdSynNrKlCh7qNBnbd4UV0qSgn9LP7IIc8G50TQBEl1Q4RPV/vzA00fDEum15266Y4XCj6eQx3iylSPy71cXPQeUAT0RgzbfqUnOOGaXUn74OKJmYD6r+pLRWnf/4NjK5mbVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DA4/r7+8nL6+vtB/ayIdBkB5EbtGIK095UK9anJqQFQ=;
 b=pSNObhC1r7JXUxjBILD1ve8RBG6A/K2QdpGVNazweC/d5jlbHXZAKmfHppfE4j5lwS1JaPMEr+xTeeheNjZXwD/OXuFg+kFhOBkl+AzObrA4CrwnMpP90a3iNlKaynibsN3I/sWgWwqXqt4myMAvoSSnEZ02zn394KbbeUrwfHc=
Received: from DM5PR05CA0008.namprd05.prod.outlook.com (2603:10b6:3:d4::18) by
 DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.17; Wed, 25 May 2022 16:20:14 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::5b) by DM5PR05CA0008.outlook.office365.com
 (2603:10b6:3:d4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/43] drm/amd/display: Use DTBCLK for valid pixel clock
Date: Wed, 25 May 2022 12:19:15 -0400
Message-ID: <20220525161941.2544055-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb8855a1-4a13-4c65-b3f4-08da3e6a72d5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB482770AA0E219B89A4E9F1E5F7D69@DM6PR12MB4827.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /AlhIJbMR9MjN/Th1MEv172x1R4bWAK6KUEPEnVOhtZ0yvNS9klxzifb1H/0TdvIa+w8Oa3XYCz48pDodR6jWJEfllMY0XtmlG/hsOIb/JfGrU9MvubmgzAHzZVom8PwJJAtLSTrF7nliTeuRKKI/WGGa3kXJFGCmOXvA0ZRhh5qxvfn0J2vhWWvFkAMhhNfrhd4Yyr47d7r9eFPE5fbLUs9OThtdzhzQEnvLG/y6JOCffLFmD0Qk7k4qYni5MWtZ8NtwFkUxEDO/RsCJcR2SVPgFEwXde4ZT85koRqBdbEYjU/pp3f0j7wyYibXsYvSh3QQrjkNy3JE+7bVc1PH53jE1W5Vdr68Txq+1jRHL4tADxx2rC6rpOo4S58+hhtkJeaB8iDgFRn9Xy21FfFMrp6sjpFxxlP6MD6agwD0TTExaDa6h4Fofm7RnvM9Xtzpveplel+RDdE0cLb4tyxoK2xMDFF7Pi6X+vwSVcsGkcQqAsOfRJzT12LU+bISGdLALRqOGPssDUdVHskrRnzEXLyVhkOfpjBZl4eAD78HJ0glaY3c7o7upkg3kL8/Q7EuiXHAJH/QRR83ZDJS2spN3u+EtUtOa14z7wN+judHQybUNJ9oc8/F8S774nCUv240lvMildsmbsIOVnRUjKHpe3a3WxFhas15b1JoPvxbvFuhsUEQHVzhX0Fnxb+qpVU+mbHB1p7aeg1aySN1MsMuxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(83380400001)(81166007)(26005)(70586007)(40460700003)(426003)(47076005)(336012)(36860700001)(86362001)(16526019)(186003)(1076003)(2616005)(8676002)(70206006)(316002)(4326008)(36756003)(8936002)(82310400005)(5660300002)(6666004)(6916009)(54906003)(2906002)(7696005)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:13.9316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8855a1-4a13-4c65-b3f4-08da3e6a72d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4827
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jerry Zuo <jerry.zuo@amd.com>,
 Eric Bernstein <eric.bernstein@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

Use DTBCLK for valid pixel clock generation

Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
Acked-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c   | 15 +++++++++------
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h    | 17 +++++++++++++++++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index 12633561be3f..a3e0b95fdc84 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -42,12 +42,6 @@
 #define DC_LOGGER \
 	dccg->ctx->logger
 
-enum pixel_rate_div {
-	PIXEL_RATE_DIV_BY_1 = 0,
-	PIXEL_RATE_DIV_BY_2 = 1,
-	PIXEL_RATE_DIV_BY_4 = 3
-};
-
 static void dccg32_set_pixel_rate_div(
 		struct dccg *dccg,
 		uint32_t otg_inst,
@@ -190,6 +184,14 @@ void dccg32_set_dtbclk_dto(
 	}
 }
 
+void dccg32_set_valid_pixel_rate(
+		struct dccg *dccg,
+		int otg_inst,
+		int pixclk_khz)
+{
+	dccg32_set_dtbclk_dto(dccg, otg_inst, pixclk_khz, 0, NULL);
+}
+
 static void dccg32_get_dccg_ref_freq(struct dccg *dccg,
 		unsigned int xtalin_freq_inKhz,
 		unsigned int *dccg_ref_freq_inKhz)
@@ -267,6 +269,7 @@ static const struct dccg_funcs dccg32_funcs = {
 	.disable_symclk32_le = dccg31_disable_symclk32_le,
 	.set_physymclk = dccg31_set_physymclk,
 	.set_dtbclk_dto = dccg32_set_dtbclk_dto,
+	.set_valid_pixel_rate = dccg32_set_valid_pixel_rate,
 	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
 	.set_audio_dtbclk_dto = dccg31_set_audio_dtbclk_dto,
 	.otg_add_pixel = dccg32_otg_add_pixel,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 5cc6d1fb887d..2fbd65d88b61 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -56,6 +56,12 @@ enum dentist_dispclk_change_mode {
 	DISPCLK_CHANGE_MODE_RAMPING,
 };
 
+enum pixel_rate_div {
+   PIXEL_RATE_DIV_BY_1 = 0,
+   PIXEL_RATE_DIV_BY_2 = 1,
+   PIXEL_RATE_DIV_BY_4 = 3
+};
+
 struct dccg {
 	struct dc_context *ctx;
 	const struct dccg_funcs *funcs;
@@ -133,6 +139,17 @@ struct dccg_funcs {
 		struct dccg *dccg,
 		int inst);
 
+void (*set_pixel_rate_div)(
+        struct dccg *dccg,
+        uint32_t otg_inst,
+        enum pixel_rate_div k1,
+        enum pixel_rate_div k2);
+
+void (*set_valid_pixel_rate)(
+        struct dccg *dccg,
+        int otg_inst,
+        int pixclk_khz);
+
 };
 
 #endif //__DAL_DCCG_H__
-- 
2.35.3

