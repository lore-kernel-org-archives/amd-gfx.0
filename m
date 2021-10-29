Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA12C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4837661165
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 15:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4837661165
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBE446E14C;
	Fri, 29 Oct 2021 15:15:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9DC26E14D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 15:15:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niORMThzfB/wuJcfaGUptI5a49HcxwDcTN1E28w3Us6NlOoNKqzUwEbFjZmf5gQnOfR5PgsM5A1G6+eoRFtEthKeM8XiQj/7Wb+weHfslz9M6JemUQOCJzOiB17zMD8WZCPJ7UK46xb19oWv01vr7Hd8g7Mh11HBncjaAZWTVozWja3jshJy/EzAEBlQVl8ZL0xY9gSdvV+nX53dunTGm06dizmaIMV0K/PII0Nyd4U8dN5/eneSnWe0IZQyU5BBcPvsdGAByHx51MUynq0hpPr+5qjOUQIJyPWbjupJnQRaX2RKlpNIysPEccc042117PW9lRMUmxqp+wSC5U0xsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIpmp8zjxs+hMfr6ls4PnZp/wxNunrQmU87VAEsvbWg=;
 b=Egbk6Mq3eFwgpkrmUF5wGyr3EKh94T19AWw4xKjlZEAChfmpv7RO7faiuVX9L2fziXJUJTALixr5lFVHS2Zh06ANV1Z+l6IbIXtHm6KGvEG98BSly8NyeYvaqefQ9ASTuKb0Zl5k9BBNP0qf8fua54AMHOXjdjLTt0W8K11SZosTPdz7ce7EuYinm5QEc8rIwAKhW7jalRIF8auYAgX++/PaGxcc6lKILCntZora7ZyVxlS4xZZMYtk7j50Y3dTKZDIW5atEyfK/R/2f1o0TViB1riVANuV5bGtz+vGrGzyDsSz8ZcT4u2BUsT3Ald799sl92AuS1ZpXPLmyMb32wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIpmp8zjxs+hMfr6ls4PnZp/wxNunrQmU87VAEsvbWg=;
 b=Teje5jCzvoHJqlVVJuyeJDiHPdEvKEIk7P8vxpymDmhPfIewzx1Sp3p6UFX/oq48rd1SlJQESX+G7mYyNDpd4URmRoe/2+5vABizFWCRrTyARUqGMsil/cc9Ad+FaxiRM1diK9tmCVLM2ZyAihFpV4YygE2EwO74ZxPAR0Pbd4A=
Received: from BN6PR13CA0065.namprd13.prod.outlook.com (2603:10b6:404:11::27)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 15:15:20 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::8e) by BN6PR13CA0065.outlook.office365.com
 (2603:10b6:404:11::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend
 Transport; Fri, 29 Oct 2021 15:15:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 15:15:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 10:15:17 -0500
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Fri, 29 Oct 2021 10:15:16 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, George Shen
 <george.shen@amd.com>
Subject: [PATCH 08/14] drm/amd/display: fix register write sequence for
 LINK_SQUARE_PATTERN
Date: Fri, 29 Oct 2021 11:14:50 -0400
Message-ID: <20211029151456.955294-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029151456.955294-1-aurabindo.pillai@amd.com>
References: <20211029151456.955294-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df8d5d0a-6fe7-4b7f-60f9-08d99aeeebda
X-MS-TrafficTypeDiagnostic: DM6PR12MB4372:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4372D760564E5D908DD69A368B879@DM6PR12MB4372.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/TVq4MvtkXNXuTSzG5E9pbG0bukKsnytyLzmeQj+5vr7wVnyORH9MbgixdcPjAeKHJCLY3jJvv1sJNlKcP+5L/g1QeD8Ih2s8zSLo2cX7qE+GSBs6wvKaMeOjUIJaiebZAPMrLZX9/sy8gfT8OMcqd3yJDT2LXDFujSq58584xh24yywAal5cHZIc70h8hxOdA9rMd91RwRQsWEI1VQDMKDfdHvFDDrRvyorG7nuA1RfjwoNWzDJ8Cw7foscQHDsEhWBwU51rszvzrM1MZmag36wHAyzJpjsCCyF/ZX1pcbowOb+4pWHaRDH1vFB7yq5RUvsUznfcVBm5IHSuRhJXPSqXROmNe5bfO1bHq5fezGJpEj7p8TQaMnCWw8nMdmt69niBuh1Q/7iSUg8BV7yFxh5KUtvzMtHmvUVvQ0Ha+Rg6dIQvqWtOIjblyAa/UArZhYPNMs7ZRB2qGJdfYP3UN+qjJ0dRwrA9uUPIQ0fwTFGC49dRVODcd5o0cML1vNAnISYImCZ1swI1mgDOhjstPmczOe2rAUZ126FYdp6TEd5/GfOQiBnieo170idD5gOJzYNdZJzB4A0Mby7QMX49dJ3u+Gql/YTTh0bAb5yXa05b1y6xo9KI/5TFF0fkJxpS04b8hkC5uh2KeIw7bOzeVvWPPxyYP7tlWVF88O+nSCHl/qUzduve75wiM+GSiXaT9QXbA0coe4ec+tGaYfVnMgRBAq+llp9S+2UnGyg4r/IPagB//rRKSm5SVNXJBxECcW93m6id/6YCVDW39rDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(6666004)(54906003)(5660300002)(26005)(6916009)(508600001)(186003)(36756003)(47076005)(8676002)(82310400003)(36860700001)(86362001)(336012)(316002)(4326008)(44832011)(426003)(2616005)(1076003)(70206006)(2906002)(81166007)(70586007)(356005)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 15:15:19.9047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df8d5d0a-6fe7-4b7f-60f9-08d99aeeebda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why&how]
write LINK_SQUARE_PATTERN_num + 1 for square pulse pattern.
Specs requirement to write this register prior to write LINK_QUAL_LANEX_SET.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h     | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index cc25ba0ec7db..cb7bf9148904 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5329,6 +5329,14 @@ bool dc_link_dp_set_test_pattern(
 			return false;
 
 		if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_12) {
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+			if (test_pattern == DP_TEST_PATTERN_SQUARE_PULSE)
+				core_link_write_dpcd(link,
+						DP_LINK_SQUARE_PATTERN,
+						p_custom_pattern,
+						1);
+
+#endif
 			/* tell receiver that we are sending qualification
 			 * pattern DP 1.2 or later - DP receiver's link quality
 			 * pattern is set using DPCD LINK_QUAL_LANEx_SET
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index bc87ea0adf94..e68e9a86a4d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -898,6 +898,9 @@ struct dpcd_usb4_dp_tunneling_info {
 #ifndef DP_DFP_CAPABILITY_EXTENSION_SUPPORT
 #define DP_DFP_CAPABILITY_EXTENSION_SUPPORT		0x0A3
 #endif
+#ifndef DP_LINK_SQUARE_PATTERN
+#define DP_LINK_SQUARE_PATTERN				0x10F
+#endif
 #ifndef DP_DSC_CONFIGURATION
 #define DP_DSC_CONFIGURATION				0x161
 #endif
-- 
2.30.2

