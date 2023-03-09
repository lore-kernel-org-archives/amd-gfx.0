Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827BFC64EC4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Mar 2023 09:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F103510E7CB;
	Thu,  9 Mar 2023 09:52:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C84BD10E7CB
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Mar 2023 09:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8jsSoXGAZZO2e6LE0Yo6MMQ27UjAtcpGh5fXtjTqrq/Af+bNQwQfDCFiiLAEYP+B8iVUxcVeQp+CxzSpRapq66TilZbzxNrOc07x/r4USq9+jv6prjCr4byVrAmGk1VgNJ+/aFaYGmGVLRJ2mTpWkAVtkSDxSKI4pxI1jlFu7YqKh4n+I86sUnI7Mak/W86Fm/YgQhwR1FrDO+KSi1/IFQIwSQ/yfcJJugoq+vqv5HR6ijTeIkjWQiMh+ugwIaD6n07jY4NRs6o/m26KO4gIfJdHxecI/ByHAXXqZn216a8WlTtj64Cwzh+UE0qxXwb6Pw1znW8qXwtnVQCjuLDhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTrBBXvC/6iRNV5d3H1BOQWy+0XtcF9XXpMWtT/xExg=;
 b=KEd73ayag6hvXnXhpa1VquYmSBNquF5jMU7RhS8DstKif8rqeh/VUwNGEqPntIL8MJScEGYbVp9nzno/bWokqRF9dmf7pX3jHZqj/K6Hdi/iNbCRQDzGFf+/Liy/P18SGUaGMgu8i9+0g6apvqgYgNSyLmqs8v/RX8vuVuL0DwtbrHSGY+5+T244RTM3vHmXKr7Fu2LOU0Mr7cPwZvb4+BhDSR0t5xeuLZ5uTMi1vVVzRy2yGSg0xlcXB09/XIgJF5+J0ooYPoYh+JK3r4mjnKVkLlqkyw3oyFPEcjPuFgfu9aeI/kX7YGbWWDbx6KM7o70SqA6XXQ0PXQh/glLOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTrBBXvC/6iRNV5d3H1BOQWy+0XtcF9XXpMWtT/xExg=;
 b=fpGzsgwlLu92BkyeztHOSk4pZhI01ayiu6+47koqvCVOyBP4eG+TwbIid35UxlhK9D+WkoCGri3TuVmZh7StRFbznNeaVxmjUuN8REx2f3H0XCVQY9porj6VybhhcQ/gBKkMai8AP/GSEiJ2gKoxHn6hthz5gmTqGGhLJKya9pM=
Received: from DM6PR03CA0025.namprd03.prod.outlook.com (2603:10b6:5:40::38) by
 MN2PR12MB4567.namprd12.prod.outlook.com (2603:10b6:208:263::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 09:52:11 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::d0) by DM6PR03CA0025.outlook.office365.com
 (2603:10b6:5:40::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 09:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.19 via Frontend Transport; Thu, 9 Mar 2023 09:52:11 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Mar
 2023 03:52:08 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Remove unavailable temperature params
Date: Thu, 9 Mar 2023 15:21:53 +0530
Message-ID: <20230309095153.2304598-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|MN2PR12MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: 7372a31b-d8f6-4f64-a32e-08db2083f43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKWwrjm58qxo/8Clqxhy5dmpF0J+BpKO50TD2xJdwfHnWEcZZ6Cbp2skvDCNs8GqR5DyV2bcaZTH5fNp4TRKWxVbqnoCBQXCib8DkvewSRzjMSYD3mpcJSckE9eG9gkLFvLFMqZp+eib+VbwbZ7Y6ns+Cgakd1O78Cs5D4JErMYbf/9fEZ2aU4d2fv5i52x0lZA4kdQ4VTNRGvZTVHNJ1EvOj/QGFXsEPq9KJkkrsBhZD3+XtCOZ6lClIN6TDj+sx5FNbhhyy1ssqTzt3VZ8LD605mhxv0m+GAC3F6rRTuMpsyZmNyGFs9+uuq/dfJNpgd+aPCp4wH4l1Ae+W/9kVEKaamFs+vXj5WXoGzIokE8VAz6WnXT/jRU+KbKYALXZ6SOvECS/WuThFCRL9DXBm+cpqSDzQAWkgiLA2PgxLCWJOs/QXothFEe5Vb5Xo7C3PK5wTx6hifCR6UotIWXOoe2BB3lN0Zs+h1CwztOv7T24Bt2PkLp3qC7HM653WAhi2HOtJx/wDJ9uHtwhRcxLedTPfUUcHDc+H3hLJgQ+9BkHjPZI2V6GWbgN+rtJJHaxsPDhtCS659F1OD/GZtTrzBXawWGORHBqTWmH3k/ikYuMx+SXcgomr3RtvgsZTAw8N9x0NaUcn6ffVL+wak/MB3iK1OyYPlp/CzYVAYDfMRfh42EN/ux2w30U0VG4yH6VKRI8Ixel3OqKPsRMiENa9yItrVinNqFmqqNGuJFEZRyo+t09J7R3U0akMDQQvkhgDMJIMhsF2q+6e3T6RdzMMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199018)(36840700001)(40470700004)(46966006)(36860700001)(36756003)(82740400003)(83380400001)(47076005)(26005)(41300700001)(16526019)(186003)(1076003)(356005)(7696005)(40460700003)(478600001)(2616005)(6666004)(8676002)(86362001)(2906002)(6916009)(70206006)(4326008)(70586007)(8936002)(5660300002)(44832011)(40480700001)(81166007)(316002)(54906003)(426003)(336012)(82310400005)(131093003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 09:52:11.2045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7372a31b-d8f6-4f64-a32e-08db2083f43e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4567
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Temperature limits are not available for SMU v13.0.6. Also, edge
temperature is not tracked. Remove logic associated with those.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 43 -------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 862859bfb9e1..54d36df1306f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -82,12 +82,6 @@
 
 #define smnPCIE_ESM_CTRL 0x111003D0
 
-static const struct smu_temperature_range smu_v13_0_6_thermal_policy[] = {
-	{ -273150, 99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000 },
-	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000,
-	  120000 },
-};
-
 static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
 	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
@@ -701,9 +695,6 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_AVERAGE_SOCKETPOWER:
 		*value = SMUQ10_TO_UINT(metrics->SocketPower) << 8;
 		break;
-	case METRICS_TEMPERATURE_EDGE:
-		*value = 0;
-		break;
 	case METRICS_TEMPERATURE_HOTSPOT:
 		*value = SMUQ10_TO_UINT(metrics->MaxSocketTemperature);
 		break;
@@ -1127,33 +1118,6 @@ static int smu_v13_0_6_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
-static int
-smu_v13_0_6_get_thermal_temperature_range(struct smu_context *smu,
-					  struct smu_temperature_range *range)
-{
-	uint8_t software_shutdown_temp;
-	uint8_t hotspotlimit;
-	uint8_t memlimit;
-
-	if (!range)
-		return -EINVAL;
-
-	/* TODO: Find a way to get temperature limits */
-	memcpy(range, &smu_v13_0_6_thermal_policy[0],
-	       sizeof(struct smu_temperature_range));
-
-	range->hotspot_crit_max =
-		hotspotlimit * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-	range->hotspot_emergency_max = (hotspotlimit + CTF_OFFSET_HOTSPOT) *
-				       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-	range->mem_crit_max = memlimit * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-	range->mem_emergency_max = (memlimit + CTF_OFFSET_MEM) *
-				   SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-	range->software_shutdown_temp = software_shutdown_temp;
-
-	return 0;
-}
-
 static int smu_v13_0_6_get_current_activity_percent(struct smu_context *smu,
 						    enum amd_pp_sensors sensor,
 						    uint32_t *value)
@@ -1204,10 +1168,6 @@ static int smu_v13_0_6_thermal_get_temperature(struct smu_context *smu,
 		ret = smu_v13_0_6_get_smu_metrics_data(
 			smu, METRICS_TEMPERATURE_HOTSPOT, value);
 		break;
-	case AMDGPU_PP_SENSOR_EDGE_TEMP:
-		ret = smu_v13_0_6_get_smu_metrics_data(
-			smu, METRICS_TEMPERATURE_EDGE, value);
-		break;
 	case AMDGPU_PP_SENSOR_MEM_TEMP:
 		ret = smu_v13_0_6_get_smu_metrics_data(
 			smu, METRICS_TEMPERATURE_MEM, value);
@@ -1244,7 +1204,6 @@ static int smu_v13_0_6_read_sensor(struct smu_context *smu,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
-	case AMDGPU_PP_SENSOR_EDGE_TEMP:
 	case AMDGPU_PP_SENSOR_MEM_TEMP:
 		ret = smu_v13_0_6_thermal_get_temperature(smu, sensor,
 							  (uint32_t *)data);
@@ -2048,8 +2007,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	/* dpm/clk tables */
 	.set_default_dpm_table = smu_v13_0_6_set_default_dpm_table,
 	.populate_umd_state_clk = smu_v13_0_6_populate_umd_state_clk,
-	.get_thermal_temperature_range =
-		smu_v13_0_6_get_thermal_temperature_range,
 	.print_clk_levels = smu_v13_0_6_print_clk_levels,
 	.force_clk_levels = smu_v13_0_6_force_clk_levels,
 	.read_sensor = smu_v13_0_6_read_sensor,
-- 
2.25.1

