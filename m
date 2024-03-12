Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4A1C54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BDE7112D3F;
	Tue, 12 Mar 2024 09:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2GYXPCkA";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4CBE112D41
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:24:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djkiRhTsj8LVl7gxf0iYRIM0J3brMcCFjAGhY0ugrpd/RWsYRQPNh4UjjwOSR/OW2AFNElLEwW+YMBgSg3oNzbvq1wDnhY1IL7rP8tmZCNUwzS2AUmmWBY85U37vQs+QFcCVedUcegjppRPwGTaECulKS5NuFiVoKwVeKrcWO26vSEoPdJ5rJkC1KeSx+QIULWocosGcHspT3OE5GHa4Dx4RR0a+sB+njivYeZShWqEEbLiAtlNdksR0LV/MdKe4FZU/IfBnTJCdSr69xWOlvCBStdUfKkER0NlxC50NSuGZEPUSIk7e28VgxezVnR2xOkS7dHoDFg2k0uqF92WWig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGBWjAipxnPWOtuhBmi+2+OY95r/e1L0c9S7H8x83Jc=;
 b=m9DGNV+Knb3BYOArV/uVQidFhsAJ7k5II5mbtGq3ErL4CkRDkEVPVgB7+yfR4j87f2DD12cR/RdFjmzOFfZ6O/p+tRLkWKHgNd+kA4H8/oZ3xwVWSswlyLtG6HXP6DMh3swB751oozaQ9pqEhhOcVmhSP201EOsg2R/Aihmy8ibLFif3YgxFxcEtp3D6Ro3ASe3XhwGXoPSR1MZYmPyDf5g5qg5lmyu5rVGdqk0ULSt/8SeBeYu1VUJA115/XngVJJaYEAraFK4x87+4Vwl9EuPUT7Obefrv/2gyZnjOynClxZlwY00dz44CG07l7roVs5EGM4882vRYMQuDLdni7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGBWjAipxnPWOtuhBmi+2+OY95r/e1L0c9S7H8x83Jc=;
 b=2GYXPCkAZfPfUH8nlH1fCHjIlCMge49wZY79iM5MIaBQVQjiAcjffVnZPOdF2GAMO/rfrCyIuUW9wZXo/bchkNs+BwF7yBthp0Kb3L6TsfgslckINjYXKgb30DA8ODkoR5dXLpDzPdPzo9BWZ4YNmQpiPKsL/9BVZddAMFl+aIA=
Received: from CY8PR10CA0008.namprd10.prod.outlook.com (2603:10b6:930:4f::17)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.35; Tue, 12 Mar 2024 09:24:26 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:4f:cafe::86) by CY8PR10CA0008.outlook.office365.com
 (2603:10b6:930:4f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 09:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:24:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:24:24 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:24:20 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Xi Liu <xi.liu@amd.com>, "Swapnil
 Patel" <swapnil.patel@amd.com>
Subject: [PATCH 34/43] drm/amd/display: increase bb clock for DCN351
Date: Tue, 12 Mar 2024 17:20:27 +0800
Message-ID: <20240312092036.3283319-35-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: c7abd567-2771-46bd-cc31-08dc427635f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tEDX2eAxvSFxv+UBUB1ziDVOoh4GDGLllY5dvjqaPQqebGqAdQGkYJNsINvbEo6J+LvfbAm5PvnTVOwoIH+fG1tBB2EquuuZRLUFHyhRZJuLfhO618dqBiuw3D7UiO0gzQe9in2NeWErYWJafqMQpd7URfqDPFcK122kAeKRtds1j5EXmpDNEjrnS1hBEyWRjWLe05j5oxeWM995tiV4DdaPyDUsbsXNY4fckCog9vHyKwW0dHmOoSglCj2N+Gi56FP+vL10idYoaxXSL0fM17AcYqJNCrkDfU29zIKMHnGGf/9le0LrQIkzs7lDq1LgELpTORvuGv1R8dPzAhfxQCscG4tQYLf8Kmm+IPAUEuvvoWFNV15YrowZ8UNmtsTIblYlP6mWuPSvMD6sDOpeVmUTtO2t8Y2LIvCbCLKjyeUCURqEopoT20JSMlUTh7woaAQe8rd6GtMHSv1cSZZZp0uUtBEALdX0k1xR6UR0SWBtovuYfDbqvBNfzEdkU4QBBJK7BpblCJ0a7WYMWFh5CGwPcuLsTr06hxkDzplL7sZAAp1l621awW2c4XW5EUO5vQ+KFGYQ1KLpr5zc7MkEDKncQxWU8ntzJsgBC2osEm9AYF920z7EW5nbM6BXHl7RbyRirmxxQ59W7ESeSB/7Htv1k2ro4a57kODvdUj+0cSV8onMeM4jXWa163vh7ErYNxjy7cJ4/Q9mqdDzddInrQiXBimp9JHaOgPsU799ypt5NTEV75ukcfXbghrVus5N
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:24:25.7352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7abd567-2771-46bd-cc31-08dc427635f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485
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

From: Xi Liu <xi.liu@amd.com>

[Why and how]

Bounding box clocks for DCN351 should be increased as per request

Reviewed-by: Swapnil Patel <swapnil.patel@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Xi Liu <xi.liu@amd.com>
---
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    | 90 ++++++++++++++++---
 1 file changed, 76 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
index 7bd67f6b1595..b6246406a042 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
@@ -98,51 +98,110 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_51_soc = {
 	.clock_limits = {
 		{
 			.state = 0,
-			.dispclk_mhz = 1200.0,
-			.dppclk_mhz = 1200.0,
+			.dcfclk_mhz = 400.0,
+			.fabricclk_mhz = 400.0,
+			.socclk_mhz = 600.0,
+			.dram_speed_mts = 3200.0,
+			.dispclk_mhz = 600.0,
+			.dppclk_mhz = 600.0,
 			.phyclk_mhz = 600.0,
 			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 186.0,
+			.dscclk_mhz = 200.0,
 			.dtbclk_mhz = 600.0,
 		},
 		{
 			.state = 1,
-			.dispclk_mhz = 1200.0,
-			.dppclk_mhz = 1200.0,
+			.dcfclk_mhz = 600.0,
+			.fabricclk_mhz = 1000.0,
+			.socclk_mhz = 733.0,
+			.dram_speed_mts = 6400.0,
+			.dispclk_mhz = 800.0,
+			.dppclk_mhz = 800.0,
 			.phyclk_mhz = 810.0,
 			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 209.0,
+			.dscclk_mhz = 266.7,
 			.dtbclk_mhz = 600.0,
 		},
 		{
 			.state = 2,
-			.dispclk_mhz = 1200.0,
-			.dppclk_mhz = 1200.0,
+			.dcfclk_mhz = 738.0,
+			.fabricclk_mhz = 1200.0,
+			.socclk_mhz = 880.0,
+			.dram_speed_mts = 7500.0,
+			.dispclk_mhz = 800.0,
+			.dppclk_mhz = 800.0,
 			.phyclk_mhz = 810.0,
 			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 209.0,
+			.dscclk_mhz = 266.7,
 			.dtbclk_mhz = 600.0,
 		},
 		{
 			.state = 3,
-			.dispclk_mhz = 1200.0,
-			.dppclk_mhz = 1200.0,
+			.dcfclk_mhz = 800.0,
+			.fabricclk_mhz = 1400.0,
+			.socclk_mhz = 978.0,
+			.dram_speed_mts = 7500.0,
+			.dispclk_mhz = 960.0,
+			.dppclk_mhz = 960.0,
 			.phyclk_mhz = 810.0,
 			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 371.0,
+			.dscclk_mhz = 320.0,
 			.dtbclk_mhz = 600.0,
 		},
 		{
 			.state = 4,
+			.dcfclk_mhz = 873.0,
+			.fabricclk_mhz = 1600.0,
+			.socclk_mhz = 1100.0,
+			.dram_speed_mts = 8533.0,
+			.dispclk_mhz = 1066.7,
+			.dppclk_mhz = 1066.7,
+			.phyclk_mhz = 810.0,
+			.phyclk_d18_mhz = 667.0,
+			.dscclk_mhz = 355.6,
+			.dtbclk_mhz = 600.0,
+		},
+		{
+			.state = 5,
+			.dcfclk_mhz = 960.0,
+			.fabricclk_mhz = 1700.0,
+			.socclk_mhz = 1257.0,
+			.dram_speed_mts = 8533.0,
 			.dispclk_mhz = 1200.0,
 			.dppclk_mhz = 1200.0,
 			.phyclk_mhz = 810.0,
 			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 417.0,
+			.dscclk_mhz = 400.0,
+			.dtbclk_mhz = 600.0,
+		},
+		{
+			.state = 6,
+			.dcfclk_mhz = 1067.0,
+			.fabricclk_mhz = 1850.0,
+			.socclk_mhz = 1257.0,
+			.dram_speed_mts = 8533.0,
+			.dispclk_mhz = 1371.4,
+			.dppclk_mhz = 1371.4,
+			.phyclk_mhz = 810.0,
+			.phyclk_d18_mhz = 667.0,
+			.dscclk_mhz = 457.1,
+			.dtbclk_mhz = 600.0,
+		},
+		{
+			.state = 7,
+			.dcfclk_mhz = 1200.0,
+			.fabricclk_mhz = 2000.0,
+			.socclk_mhz = 1467.0,
+			.dram_speed_mts = 8533.0,
+			.dispclk_mhz = 1600.0,
+			.dppclk_mhz = 1600.0,
+			.phyclk_mhz = 810.0,
+			.phyclk_d18_mhz = 667.0,
+			.dscclk_mhz = 533.3,
 			.dtbclk_mhz = 600.0,
 		},
 	},
-	.num_states = 5,
+	.num_states = 8,
 	.sr_exit_time_us = 28.0,
 	.sr_enter_plus_exit_time_us = 30.0,
 	.sr_exit_z8_time_us = 250.0,
@@ -177,6 +236,9 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_51_soc = {
 	.do_urgent_latency_adjustment = 0,
 	.urgent_latency_adjustment_fabric_clock_component_us = 0,
 	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
+	.num_chans = 4,
+	.dram_clock_change_latency_us = 11.72,
+	.dispclk_dppclk_vco_speed_mhz = 2400.0,
 };
 
 /*
-- 
2.37.3

