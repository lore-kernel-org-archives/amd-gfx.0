Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E477C7EE2A
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 04:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95EBF10E614;
	Fri,  2 Jun 2023 04:00:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB7C10E613
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 04:00:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXoVzVe9Wo4lk5XCoZ0p51YRMG3l/iCYH1nLOKHapRO2O5xXmljCrw9t1bCkv4NZhg2dYAw63BO1j5f9EUqBL2BQ37ez2nR9FQDGrpMZGxl37Aj7uE2u2D3rcZCN7bL5GATy3aA+js9rc9wxblMfTdCsRTOiT9wvTMBhGOxwveuPBMfRbkUyQIzYnC5J9p+QnxqThsL7AIflSUoLK6r/yAjN9SYf4aapCghC3tsbCx5WSJ4QiggA6pVAfxAiQPhnMMKvC9uH8UzIsd0rGPsbQyZlUE3UYGJRIucuQm3VW+XChqWddA/nRt5BSkDZVnEdc6UJUJiFgAtfvHGcai1d+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rBlJuyk6QkO0yMh7KCoyrO1RzDH56NgOLK2WgzEsXI=;
 b=PGdAEXR70QLgi5rB8JJTHuYGpE2uPp9s+jqUiWVmIHYgdWhrLJXkedj5Oz8IkIK56exD8G8kDCBWRxO7n7ZdUWNRVPgzMHbFWcke4wwK445peKLeNcZJGeAzYs1nSrPH/RdXIqKJIr4RuhFdTSvy5Ck8HuQ3MapI1DD3DrtBj8df8zpRPUe49t1rhILCYL/j5nj68zg43/ukJCHo4DKTZduv6OpiI/SOsXS81tJSPnaoy3cEpS8bQfL1l/DJ4D1/CgGFEd/pij+0pSvNgUWI63BDhJHKZ+H+7G8Jv5Y4pHYsi7hB4w9qLJmxP6WUCL9hV/sm3ZucN7chJeK1ox4b8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rBlJuyk6QkO0yMh7KCoyrO1RzDH56NgOLK2WgzEsXI=;
 b=bMgN0FKOGFOFgBEUAy7oBuylkLYcH+ZtMGtVTPd0dXXMr6Uj2rFZRg36aUdvQxtId04ux/emwtKXUyszM5vwnO0bSqd2ezDyzvBQoLCzMSipZBeX7Mgt7clwCAb2qwzRnyL7r9B0Buy8BP//M1DLKZAJZ7ItFPXoXI99zjf8Kfw=
Received: from MW4P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::31)
 by DM4PR12MB5341.namprd12.prod.outlook.com (2603:10b6:5:39e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 04:00:48 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::2c) by MW4P223CA0026.outlook.office365.com
 (2603:10b6:303:80::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Fri, 2 Jun 2023 04:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Fri, 2 Jun 2023 04:00:47 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 23:00:46 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Fill metrics data for SMUv13.0.6
Date: Fri, 2 Jun 2023 09:30:25 +0530
Message-ID: <20230602040025.655957-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT019:EE_|DM4PR12MB5341:EE_
X-MS-Office365-Filtering-Correlation-Id: adbfc600-d34b-47bb-75a0-08db631df299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afmWxN2f8KEpsYFVgQ6Qu0bpTnt96Li/d0+Et+7s66c2fBKFxZO/q1frSrkD/4KrqXEnhjACym0DYW0OH1SfTugip6dhQodGPJFNFjUW0DM7/s8ByZJNscxhwx0xUVjNmAfYOKX4e9XqbkHu6xl3OqmkcAJ41TsHmSfgoIp4NuAhaA/L8R2Ts69Tw79TrjywV3OiO0dY4YQ5Knh4Zs389I06glFjU5iK8IVS83sEaUUtTBMYlD75k5ME+Ws7UFGnyLuz3Nj/aA2tF5IyEA1gOjwK7IOx1+T8wQxxifUs8hikLHRHhj3AGcSZcSda401naS6ewKn1f6jLmppG3Wt52uVOiKR0ESkTbKob8qgRWEHWKb+NynGfBrgapbilPZmHXhIyToZm6a4NEtka5UZqIvujwB71cK0s/WkWL5QsG0E4pCJX/kjul6OXlOgWGPXQ3ffLaR/Lo6u+Cpgc+QCWxwgAagn+wHO0EeHEGIF/bA7sSKN8TpTRXs0gUZ0wqR7IvFG7Fi2syrZfXLkdUIUubXQWiisWhXFu2AyyGKMk+74aZ05ju/tnv/ZGRNS+koJ155FrLPC9XaxVjlQ+HuoVnnysj7nfrv6YWGPR1jB2VytcxdwLhtI4jpNGfRNfwUo+PBFanrZ93EV/z/jrxsJluPzCCk0TeDO36PuyrW+F5cfdq5H9QduUZb+dSYRYe6P7z1W1tCFCH2f21ogm3n8vlkDpdqnabkIZQ83/hWmB0+UwWFN7RZAolNhdjr/v3dOBKDWdqccrylZyQlz7IPjFrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(41300700001)(316002)(54906003)(86362001)(5660300002)(6916009)(4326008)(44832011)(70586007)(70206006)(82310400005)(1076003)(2906002)(8936002)(478600001)(8676002)(81166007)(356005)(26005)(82740400003)(7696005)(6666004)(40460700003)(2616005)(36860700001)(16526019)(40480700001)(186003)(36756003)(47076005)(83380400001)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 04:00:47.6839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adbfc600-d34b-47bb-75a0-08db631df299
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5341
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

Populate metrics data table for SMU v13.0.6. Add PCIe link speed/width
information also.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 108 +++++++++++-------
 1 file changed, 67 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 75255e0baf91..4ff5a66d446a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -80,7 +80,10 @@
 /* possible frequency drift (1Mhz) */
 #define EPSILON 1
 
-#define smnPCIE_ESM_CTRL 0x111003D0
+#define smnPCIE_ESM_CTRL 0x193D0
+#define smnPCIE_LC_LINK_WIDTH_CNTL 0x1ab40288
+#define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK 0x00000070L
+#define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT 0x4
 
 static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
@@ -197,6 +200,7 @@ struct PPTable_t {
 };
 
 #define SMUQ10_TO_UINT(x) ((x) >> 10)
+#define SMUQ16_TO_UINT(x) ((x) >> 16)
 
 struct smu_v13_0_6_dpm_map {
 	enum smu_clk_type clk_type;
@@ -1935,6 +1939,16 @@ static void smu_v13_0_6_log_thermal_throttling_event(struct smu_context *smu)
 						   smu_v13_0_6_throttler_map));
 }
 
+static int
+smu_v13_0_6_get_current_pcie_link_width_level(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	return (RREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL) &
+		PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK) >>
+	       PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
+}
+
 static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1953,8 +1967,12 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_3 *gpu_metrics =
 		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0, inst0, xcc0;
 	MetricsTable_t *metrics;
-	int i, ret = 0;
+
+	inst0 = adev->sdma.instance[0].aid_id;
+	xcc0 = GET_INST(GC, 0);
 
 	metrics = kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
 	ret = smu_v13_0_6_get_metrics_table(smu, metrics, true);
@@ -1963,51 +1981,59 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
-	/* TODO: Decide on how to fill in zero value fields */
-	gpu_metrics->temperature_edge = 0;
-	gpu_metrics->temperature_hotspot = 0;
-	gpu_metrics->temperature_mem = 0;
-	gpu_metrics->temperature_vrgfx = 0;
-	gpu_metrics->temperature_vrsoc = 0;
-	gpu_metrics->temperature_vrmem = 0;
-
-	gpu_metrics->average_gfx_activity = 0;
-	gpu_metrics->average_umc_activity = 0;
-	gpu_metrics->average_mm_activity = 0;
-
-	gpu_metrics->average_socket_power = 0;
-	gpu_metrics->energy_accumulator = 0;
-
-	gpu_metrics->average_gfxclk_frequency = 0;
-	gpu_metrics->average_socclk_frequency = 0;
-	gpu_metrics->average_uclk_frequency = 0;
-	gpu_metrics->average_vclk0_frequency = 0;
-	gpu_metrics->average_dclk0_frequency = 0;
-
-	gpu_metrics->current_gfxclk = 0;
-	gpu_metrics->current_socclk = 0;
-	gpu_metrics->current_uclk = 0;
-	gpu_metrics->current_vclk0 = 0;
-	gpu_metrics->current_dclk0 = 0;
-
+	gpu_metrics->temperature_hotspot =
+		SMUQ10_TO_UINT(metrics->MaxSocketTemperature);
+	/* Individual HBM stack temperature is not reported */
+	gpu_metrics->temperature_mem =
+		SMUQ10_TO_UINT(metrics->MaxHbmTemperature);
+	/* Reports max temperature of all voltage rails */
+	gpu_metrics->temperature_vrsoc =
+		SMUQ10_TO_UINT(metrics->MaxVrTemperature);
+
+	gpu_metrics->average_gfx_activity =
+		SMUQ10_TO_UINT(metrics->SocketGfxBusy);
+	gpu_metrics->average_umc_activity =
+		SMUQ10_TO_UINT(metrics->DramBandwidthUtilization);
+
+	gpu_metrics->average_socket_power =
+		SMUQ10_TO_UINT(metrics->SocketPower);
+	gpu_metrics->energy_accumulator =
+		SMUQ16_TO_UINT(metrics->SocketEnergyAcc);
+
+	gpu_metrics->current_gfxclk =
+		SMUQ10_TO_UINT(metrics->GfxclkFrequency[xcc0]);
+	gpu_metrics->current_socclk =
+		SMUQ10_TO_UINT(metrics->SocclkFrequency[inst0]);
+	gpu_metrics->current_uclk = SMUQ10_TO_UINT(metrics->UclkFrequency);
+	gpu_metrics->current_vclk0 =
+		SMUQ10_TO_UINT(metrics->VclkFrequency[inst0]);
+	gpu_metrics->current_dclk0 =
+		SMUQ10_TO_UINT(metrics->DclkFrequency[inst0]);
+
+	gpu_metrics->average_gfxclk_frequency = gpu_metrics->current_gfxclk;
+	gpu_metrics->average_socclk_frequency = gpu_metrics->current_socclk;
+	gpu_metrics->average_uclk_frequency = gpu_metrics->current_uclk;
+	gpu_metrics->average_vclk0_frequency = gpu_metrics->current_vclk0;
+	gpu_metrics->average_dclk0_frequency = gpu_metrics->current_dclk0;
+
+	/* Throttle status is not reported through metrics now */
 	gpu_metrics->throttle_status = 0;
-	gpu_metrics->indep_throttle_status = smu_cmn_get_indep_throttler_status(
-		gpu_metrics->throttle_status, smu_v13_0_6_throttler_map);
-
-	gpu_metrics->current_fan_speed = 0;
 
-	gpu_metrics->pcie_link_width = 0;
-	gpu_metrics->pcie_link_speed = smu_v13_0_6_get_current_pcie_link_speed(smu);
+	if (!(adev->flags & AMD_IS_APU)) {
+		gpu_metrics->pcie_link_width =
+			smu_v13_0_6_get_current_pcie_link_width_level(smu);
+		gpu_metrics->pcie_link_speed =
+			smu_v13_0_6_get_current_pcie_link_speed(smu);
+	}
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
-	gpu_metrics->gfx_activity_acc = 0;
-	gpu_metrics->mem_activity_acc = 0;
-
-	for (i = 0; i < NUM_HBM_INSTANCES; i++)
-		gpu_metrics->temperature_hbm[i] = 0;
+	gpu_metrics->gfx_activity_acc =
+		SMUQ10_TO_UINT(metrics->SocketGfxBusyAcc);
+	gpu_metrics->mem_activity_acc =
+		SMUQ10_TO_UINT(metrics->DramBandwidthUtilizationAcc);
 
-	gpu_metrics->firmware_timestamp = 0;
+	gpu_metrics->firmware_timestamp = metrics->Timestamp;
 
 	*table = (void *)gpu_metrics;
 	kfree(metrics);
-- 
2.25.1

