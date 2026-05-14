Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAACCD4F25
	for <amd-gfx@archiver.kernel.org>; Thu, 14 May 2026 15:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C75510E5F0;
	Thu, 14 May 2026 15:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UyQNoBfl";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 342D510F292
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 May 2026 15:55:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlBX+LjR64z6bCtW9LmHgMglOlZIFPzeO/V0Bj5+baA2Ip+zL9tHJBUzRaTFRqspl9Esf9p+jOGp0FSZlR/y+FnCm+BFL1S1C8BfdqXGS0qjqPQNOY9Zn38DhQx9dCGpHdWc3h4O/tFasxsc1QNroHSDBcq3SprQwqd0LE2z/ZVeXi6ZdkEkIDsGpSgft6bjvCZr3dN6v5dTwEQu4fYyZsTlXF81l4b+Lt2WFKsPppRNtuQ2au9txCSCdxm+nWCVD2XlsZKv1utWhi5rNtzulIkjVuKTAWAm1N8qoJT12VNIgXSjguSBXx/5d3dnt8dc4hJhmgl+1ZMnpeSwbwj1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqQEr5HpfsJ15mjaGlFoIlptQw2nEhy0x52rb4TfJJM=;
 b=IxwQ9r9QIKQNdT4zgeRq44p6hu9crT0p542Yl3fcNXRfVQ3kZovYvIrgm/MTuGBFl/93TSApU5oIekosGnKtPaynGQlidomtBXe4io/Xgv23Ww6x5r2XQrgWOkdeBfZs3orgPgNqy1BggAwdJ3jsY+f1KnEEK1OIazWa8aTiHuCh2kY+jS2MnsTUWlNy9VyGtSUqCrjEsIGHgxrNMZixpcKPYkDvkWZ/A4cnLMshGdAEUJK+NFIsomXqritOF5W6huW8IuLaG9bmTAkMSMIqC32J5zy7R5B8Fz11PRkvYEuXMnrC+JmIYUaCz4gJMKkdjD/ycf+zE/fG/GjYxOL/Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqQEr5HpfsJ15mjaGlFoIlptQw2nEhy0x52rb4TfJJM=;
 b=UyQNoBflFGgSHpQH2WLh/mY2um6SNhmKRVxn5HvO/DyaxgHT5o/Uwdh0AVW+Utzg3zMA7TDBebr4WJiM0vguNwrRmf/wnWcaZGBy/SyPEbAjK3vaw5bmlxbXchDf50RDHTxQROm9EEO7OGq4co0q4EHAQuR2njKhZgD2W5PLGzE=
Received: from PH7P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::25)
 by CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 15:54:55 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:326:cafe::a8) by PH7P220CA0003.outlook.office365.com
 (2603:10b6:510:326::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.19 via Frontend Transport; Thu, 14
 May 2026 15:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 15:54:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 10:54:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 10:54:53 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 14 May 2026 10:54:53 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Max Chernoff <git@maxchernoff.ca>
Subject: [PATCH v2] drm/amd/display: Write REFCLK to 48MHz on DCN21
Date: Thu, 14 May 2026 11:53:50 -0400
Message-ID: <20260514155348.2114429-3-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: c224b264-0b58-4c98-0015-08deb1d12413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: mZ//5l7iWoxAF51EHYg49k6htTrVldi/kd8fh/B9tcnFxnAID3IXDD/Aj3Mt6cPx6MMGFDCmx4g7biDuQPXbd0Wf984zBnXXaaGd6O3aE/RZxO7/T2CeKOvE30+15LSglG8ICI1q5M7/SyXPhnGRIaVJ3gGAsxW+u4geF054gffXTKdVgPjX2RdSuLp3/AAbLGRMeYfcxcip7voHfxCIF+4usoz1T19/zWoDzuks+Z9ZZaqSa7Tcs4YihplyvGeOe//1DgeTRYjSpXSZtqj8uUvJpzE46cXBzyejf+3qvSp/0+KeBDUKUTzXbj8kp90DcKdIVdDdDNT9NR0COiT7HbEDwn8LKP+HcxSInGRTN1n+9FNZICEavUjszjkk1utdt3/loOMb1Ukj5WNGzUckpE3uZrW+/Q507/xH5Z+ZY5oGW5HT+sDq3W5r8U1tn+IEFMlEEtO+pWCYe7ygCeF/V3GWyuR4Bp2GwLVtycTFQ98zciqcYZwnxRjpuY5DIi1NbA8aCBkclPA2xGBYzpn7pifQB0xWhwmUsDxmHTmODeYRY1J78qAG597PREvfFsDKJpsiEWkar2ooMed3uQbJtTnI2EJntugobd7dSRQIjCKiS3ovzFAX16F98ICXpDriE7L7epPLbIYCi7DSUOyGCpsbh1lfiumwiZpSl0O+B5xZqsKfeg8iXWrEnLYAOYkeo9Fdo7YviZDT69G/L50xmQmM+7l+FRPC3htDP8euY5w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3ATbK1aleoGZ5Uf1zOuu/nREGbzsA3xLXmVxAnAoKE4G07R/G01TuWIuwON/Zkwls+8oMg+q9n/z/GYnS2vHTiRIduylFvhC/G0fXYwfJGS7gbKKDrrDdpoKa/NKiBRTL33vGLXkxXd+Fk4tJGN0SzO1BIS5Y9Zep8k/xIP099I9C2ybrhyouuip62Lh7lr5S3WJ8W7Q10N/3lzTCquo/sVm/r8E5kzLK4F8YvhQf9baRDCC03iPtKJpE8zQRGtcwKS5n64JeneRykqpzpgJB4j+joXrFK0vNtgFb56HGSJLVDasCy9AWLzsEukb1toMj+1Gz4mYkM8Ifs8P2hkPGOVfcRW0JM3NO1HOue32IAnf99/wDfkit2LIVCFr+HmJn+rdDaXZ3UuT+CZd5xvrKa4r24MkO7bS9C+07fZcgsuItSamadbCPxC3P77aKpLY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 15:54:54.3771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c224b264-0b58-4c98-0015-08deb1d12413
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
dccg21_init() calls dccg2_init() which hardcodes 100MHz refclk values
for MICROSECOND_TIME_BASE_DIV and MILLISECOND_TIME_BASE_DIV. DCN21
uses 48MHz refclk, so the wrong values corrupt DCCG timing and cause eDP
link training failure on cold boot.

Write the correct 48MHz values directly instead of calling dccg2_init().

Fixes: b7dfeea1e168 ("drm/amd/display: Add missing DCCG register entries for DCN20-DCN316")

v2:
Fixed typo

Reported-by: Max Chernoff <git@maxchernoff.ca>
Tested-by: Max Chernoff <git@maxchernoff.ca>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c    | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
index bdc3ce5d4f47..be167bbd42b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
@@ -105,15 +105,26 @@ static void dccg21_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppcl
  * dccg2_init() unconditionally overwrites MICROSECOND_TIME_BASE_DIV to
  * 0x00120264, destroying the marker before it can be read.
  *
- * Guard the call: if the S0i3 marker is present, skip dccg2_init() so the
+ * Guard the call: if the S0i3 marker is present, skip init so the
  * WA can function correctly. bios_golden_init() will handle init in that case.
+ *
+ * DCN21 uses 48MHz refclk, not 100MHz, so we must explicitly set the correct
+ * values (48MHz is taken from rn_clk_mgr_construct()).
  */
 static void dccg21_init(struct dccg *dccg)
 {
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
 	if (dccg2_is_s0i3_golden_init_wa_done(dccg))
 		return;
 
-	dccg2_init(dccg);
+	/* 48MHz refclk from rn_clk_mgr_construct() */
+	REG_WRITE(MICROSECOND_TIME_BASE_DIV, 0x00120230);
+	REG_WRITE(MILLISECOND_TIME_BASE_DIV, 0x0010bb80);
+	REG_WRITE(DISPCLK_FREQ_CHANGE_CNTL, 0x0e01003c);
+
+	if (REG(REFCLK_CNTL))
+		REG_WRITE(REFCLK_CNTL, 0);
 }
 
 static const struct dccg_funcs dccg21_funcs = {
-- 
2.43.0

