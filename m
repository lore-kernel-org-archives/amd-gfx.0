Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE73C02190
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 09:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A09D810E8FF;
	Thu, 30 Jan 2025 09:20:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sfAt49Ob";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8697010E8FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 09:20:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTvWkieJ27c+3aqy3Ug59cUu00uH1ffNng1vhiw9LMCAyIKJr5Ey5mZ+UOPjTI5ic54Ni+P8PVKY6mUuOPX2OFZ721VhO5sUcxGwqF0SSnRgMUKE/olKQkjuw95lAE658vToz7k7YQ6XQXZvqQk8H+KaFIOoyGg3D08imrXiCSIVG/Ex9Jck9CDmOT+rRQ7ZC2hrbZJF24Pr5MnPcdxb+9h9mtL2cAR/BV4ksWjg/uRiwGsrtExfHsKlryFrBJeVMGc2xBseNl/j4VbNXQlFtjA79pAqbVzQx0GZv1T44fOpHwN7rqIUvgxVq22kgXYtt1aJ58J+OhqiY4447MX5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF8/wj2yg0CfZKg75P310WVGHyHa6IH4D4ThQTOnofc=;
 b=uj4Xu3NtfIbt9fkipbIQ6n6yEYgbOs4trF+xQ+Xt7Ut8VYmM4W5HJMSvaAQMX1WKiqhqut6yCnCXIoGiRb0MQW7VV3xK6TKhgp+Ur9AGqXOJxCuuE2SwwPh5QvQibaapopyfrM6loqXjlrOmGlDsujZzU1VCLc1mBIimZjRksHBAw/8Ay3uzllfXMoYBVxdRPdcwLV7jpCRXQzOFXL9EGvKQ3pto2muBBUIl6T5s72NcXfLw5au+dQ4KuXK1PwvwH3fi9IrLIKarXihoicJuF7L+WzSU9KDxZJjTOeeSyohKjqH8e9qg00GIQm2AHY7h1iqyr8Ozs2pVNE34Qy/TpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF8/wj2yg0CfZKg75P310WVGHyHa6IH4D4ThQTOnofc=;
 b=sfAt49ObWVcwi7XjJ8OAomBohqu5Qm6amnSEO8L57w3QulTlLwsEdMxHPEbtXLFsJPPGw9M5vywMkSWb3jH9BrSTqE+Xl67T5xuUpbh8eFaoUs3pg/D88TJTsu6tjFsDQLtLT/N+rwbFWuOya+7auCaxqfM3hugeyjx1rH37lFQ=
Received: from CY5PR15CA0226.namprd15.prod.outlook.com (2603:10b6:930:88::15)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 09:20:17 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:88:cafe::c2) by CY5PR15CA0226.outlook.office365.com
 (2603:10b6:930:88::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Thu,
 30 Jan 2025 09:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 09:20:17 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 03:20:15 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Use one level table if dpm not enabled
Date: Thu, 30 Jan 2025 14:50:00 +0530
Message-ID: <20250130092000.1759194-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f35fc08-5a85-44c9-dfea-08dd410f4fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WuHslWTjeFDmLQofk68md1hqbTyoCN3PLds+V2VWsyiWuUjwx9LfPwpo2Yic?=
 =?us-ascii?Q?otEtha8ewLwtAc2fIfnrhFJX5sKyruXEU+50k1Pn/MRD832lloekH1piB18z?=
 =?us-ascii?Q?73AJuVYTi+XN5GJg37Gs62bKjEA5ztVoSS/NiErKyvFMzpBnXbAlUd4mFmsI?=
 =?us-ascii?Q?nmGSwYl4wWTpULFTum+zRBYTshnyeQJsvmh2x21gCejDPnp9/ojt5w1osS82?=
 =?us-ascii?Q?wce66xaW1b7D4pNOaB4rS/TIPSKl3luu/5JLN9g+HwsqkirUe84jHo/iI3sU?=
 =?us-ascii?Q?sS70WqdgGtp+WffDStNmElhEEQJy0Vx3BXQ9ExNxNEKCiCLgAqiawi/5AnvC?=
 =?us-ascii?Q?u1LUI0cr5sCGitAuX3ZU7IRPDH8QeCY7mo074ADKpIqGQLAiDM4TtwYHNO/W?=
 =?us-ascii?Q?96/vFD0PftcgIvagExAGa7coLa3ycqqdv/JHQS11WFrdbrh6DuL+Mq4loisy?=
 =?us-ascii?Q?kK3e1J7cmgGXD9uZJ2YCsHj12PTTAcm9K1rJAtUuaC/HA0KrZXK5wzyZnGlD?=
 =?us-ascii?Q?Z1QsC5gOT0HnOhVoauGpDZTkZIRiTW6BI0m3nyNpn+TZmGISBFkV/6vbq5hQ?=
 =?us-ascii?Q?nFJ8t07SZhfoboADvlZ1CuDkiKdTZz/wXDJng9tdyz5VqyN9rZ33L8oWwhJd?=
 =?us-ascii?Q?pzBXtRtoVnb3wpm7CMzynHeaZP+3RWnjJL68sXpSClO2Nw0xq4XUhMGnMP3I?=
 =?us-ascii?Q?BjRW3j++HAaXZXP0EsCRZVXPmSSGEGofFAdIlNwE7TpJjhn1fvR+5QsIlKov?=
 =?us-ascii?Q?6R6jhoYHrmbovZf4LEPpSjtoDYtzlCwC0A6zCfS4HWctPZXOBrOlBPDY8p2B?=
 =?us-ascii?Q?dO5NkR4X99Um0aGWBQJobpVPb2v9PhV9JVIyxG6LobqBTU/mq3gwpM4wmI8Z?=
 =?us-ascii?Q?AzNQ+84SBNPTomuFoPS01Fovi+MJ/mt6Fx6yjnWkJBf6wePJT4KTqNZ0ukC6?=
 =?us-ascii?Q?GbLzHk0M9gBgw7UkipokXF8jbzkkuesCqj+sf+dSAlFLZJv/9coi2C/QLEcU?=
 =?us-ascii?Q?+TnPAZe1VFKKTMq7BBzrJ/X4KCqEaikBuOM+y9ks5SphzlW2isbd3Efp2XRa?=
 =?us-ascii?Q?qwmA1UbrA8FD3W5qLScRGpET9/Eqq6jc0UkSA8h3QLdYc/gR3Wq/AyGZUanY?=
 =?us-ascii?Q?zpDwxgPXuXKZrE6MZJLB/0NJuUf3voLgBcIIt4zPO8Gvykth82XmtMu+fneh?=
 =?us-ascii?Q?KxMM5m0+M2w+OVIT8L89NRV901n5xTZoMo3KpBiJEQT2+FFa9cffJVV3ZBgf?=
 =?us-ascii?Q?cB5SIivqQEDBB4orEbhrXurrgmuW/V8Q05AF/dmJPxutHk+Gr/tW5q0NkiWm?=
 =?us-ascii?Q?JggyAerIjDeDevUpaH9Jg5yJWdbtaoG6U182aALMp0v5GGDs4k2lEPgPv/vX?=
 =?us-ascii?Q?T55I/+/J+T/lSaz05eKMFD7/rScq/4xZD1LL4P1GtO+V2InhzlE0zz44y0h3?=
 =?us-ascii?Q?RUlVRgmknhvEGlFG3Aje+ZEd7K4o1vHB5XpC+eWeL2ggZ3hPYVGlUPWfeakC?=
 =?us-ascii?Q?ImMiVlI8wlZdBYw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:20:17.4778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f35fc08-5a85-44c9-dfea-08dd410f4fd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949
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

For SMU v13.0.6 variants, if dpm is disabled for a clock, fill current
frequency as the only level in frequency table. Also, drop Lclk table as
it is not used.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 33 +++++++++++--------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index de533076e157..7f0b4cc1141b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -279,6 +279,20 @@ struct PPTable_t {
 				   sizeof(MetricsTableV1_t),\
 				   sizeof(MetricsTableV2_t)))
 
+#define METRICS_CURR_FREQ_F0(clk) \
+	SMUQ10_ROUND(GET_METRIC_FIELD(clk##Frequency, version))
+#define METRICS_CURR_FREQ_F1(clk) \
+	SMUQ10_ROUND(GET_METRIC_FIELD(clk##Frequency, version)[0])
+
+#define INIT_FREQ_TABLE(type, clk, levels, f)                           \
+	if (!smu_cmn_clk_dpm_is_enabled(smu, type))                     \
+		pptable->clk##FrequencyTable[0] = f(clk);               \
+	else                                                            \
+		for (i = 0; i < levels; i++)                            \
+			pptable->clk##FrequencyTable[i] = SMUQ10_ROUND( \
+				GET_METRIC_FIELD(clk##FrequencyTable,   \
+						 version)[i]);
+
 struct smu_v13_0_6_dpm_map {
 	enum smu_clk_type clk_type;
 	uint32_t feature_num;
@@ -806,20 +820,11 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 		pptable->MinGfxclkFrequency =
 			SMUQ10_ROUND(GET_METRIC_FIELD(MinGfxclkFrequency, version));
 
-		for (i = 0; i < 4; ++i) {
-			pptable->FclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequencyTable, version)[i]);
-			pptable->UclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequencyTable, version)[i]);
-			pptable->SocclkFrequencyTable[i] = SMUQ10_ROUND(
-				GET_METRIC_FIELD(SocclkFrequencyTable, version)[i]);
-			pptable->VclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequencyTable, version)[i]);
-			pptable->DclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequencyTable, version)[i]);
-			pptable->LclkFrequencyTable[i] =
-				SMUQ10_ROUND(GET_METRIC_FIELD(LclkFrequencyTable, version)[i]);
-		}
+		INIT_FREQ_TABLE(SMU_FCLK, Fclk, 4, METRICS_CURR_FREQ_F0);
+		INIT_FREQ_TABLE(SMU_UCLK, Uclk, 4, METRICS_CURR_FREQ_F0);
+		INIT_FREQ_TABLE(SMU_SOCCLK, Socclk, 4, METRICS_CURR_FREQ_F1);
+		INIT_FREQ_TABLE(SMU_VCLK, Vclk, 4, METRICS_CURR_FREQ_F1);
+		INIT_FREQ_TABLE(SMU_DCLK, Dclk, 4, METRICS_CURR_FREQ_F1);
 
 		/* use AID0 serial number by default */
 		pptable->PublicSerialNumber_AID =
-- 
2.25.1

