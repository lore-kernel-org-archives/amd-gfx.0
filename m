Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF6BC6FA83
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 12:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D9910E446;
	Mon, 12 Sep 2022 12:42:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6168210E446
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 12:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOXRMgZOnBFRE0BwZl7D72giNBg8eNgNCz6Wu/JKDwLC4Kv00dcXUS6vlehQmDsfVVKmWoaWBFLMdoYdTkeqIE3Srm7jS48CPN3WgmUhgNPab0Ki6GIoK+bICe326v3qm0FXTVESnz2UxpKjxWhFcRSaLJczCbCIdeXH3dqAoH9GkVpUBtZJfy1D0S03siqNx8JvaEFFV73Mh8KvoEvFg8YQR1qs7yQCAdRMwWVG+Jid1d5xFpb7Vkk36yYj9u9rjHS/tEyfePSLwF8pN+10nYgVMbZJAWsH5gdaEzYjZcaOLfQ30zgf8D74kwNFjBkZszB15qDIpvboNAjd4pCXtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j7kqBCRiuaRbA5+ngE+OSqRiXC7g+Q6DWtBB55hA4w=;
 b=n44dfM3mO7Bdr8x/En7HWvum6z0L4UDCSSBpFPQ9Ns6u7jE14MQsfchgie7/lF4elyJ1NbCh/hGcNZLUH0Vi9truIZtryxPnFSSzPq6t/k/Ja7/1ePnqlSf5gSAFMZPUZQ0VLRY5t6HaO7sNe1Xb1JGQYc25flRfh+PPJTHLMFK37C8ZqHgdb7LqgUyyuxHS0MenldWcjKLMWFdjevuGw1lEDQNHa2RKcCCxaMk1ich5XLkf7AAA9JuAB7Ha/2lWKIzyyKf3YNE53teX3hFWG1bUx30zTeeyL0QWUiKVJ6wMeycGRH5bggg+4tOIIj0pPfjBhHEgjtnb5wC4vXwUXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j7kqBCRiuaRbA5+ngE+OSqRiXC7g+Q6DWtBB55hA4w=;
 b=hdDkzP0zMlDNBo3/ZDPuvDh9iyEMhbxJKS7h8L5dHcPvRdGkIPHiuGPGdDiPnXEOPvM5qh8zWDyAm6Uy1qQscLw2pNxQhVNlCfQV6SeKP1LD/Rin3MjqyZ9r7WiIR8nqg/A/TrljfrO0tBtrkgjbMv76/d88ZaRo3Nt8lkVn6vw=
Received: from MW4PR04CA0143.namprd04.prod.outlook.com (2603:10b6:303:84::28)
 by CH0PR12MB5251.namprd12.prod.outlook.com (2603:10b6:610:d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 12:42:42 +0000
Received: from CO1PEPF00001A61.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::78) by MW4PR04CA0143.outlook.office365.com
 (2603:10b6:303:84::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Mon, 12 Sep 2022 12:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A61.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.11 via Frontend Transport; Mon, 12 Sep 2022 12:42:41 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 07:42:38 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4] drm/amd/pm:add new gpu_metrics_v2_3 to acquire average
 temperature info
Date: Mon, 12 Sep 2022 20:41:13 +0800
Message-ID: <20220912124113.182309-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A61:EE_|CH0PR12MB5251:EE_
X-MS-Office365-Filtering-Correlation-Id: 37515f6a-a230-434d-730b-08da94bc4842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1X98YbnH1ILdJg0OOrRTsG5a6ZCsWVCzaOQOkJ6owVQpsclS7RGzvaMeHJBjjCYJhjCPx4ymDKcPLwfN662wD5L9jlwkCh9HkbpBcZBHx2L5MiH1j6USpTbRUWM4RvlfgD4t55usKHG3vY524gnDuPYy4u4h1Nj+pzaEKKkk6WwrMT8bDo7JZ85ZsvuwwFpr382vJvbOd6tdwq8VQ8w7XYCj0L8CCuZtu5nBkbbF4iZ0o7dNZcTftGjx9TEp4M80Xm/mUeafm2xR8So3KserVrYgRNdmH4U0IM7bwMbQSu3hZGxncdAM/Xz0ac5ibmjzNGH/2MbEktN2huqbWNTnYnjqZgw7w4cNJYTnQiZy+xAY5uo3kEwte5Ue2nkZ5PGDTC4sknkC9hwdsQsFcXk+RxMoeL6gpEstBiNPrfcGPiKP1Eyj5YdJwxNXjObxExIEzd0ShfJeqP9WNiPJ7ha5uxkpY/0V0WQHjfqkfw8uRv7eZO5DrI3W2okU0XRP1L7qT/I5/nxvPKjeX9r929NBouN5j4iwkG5ZJZ+FhdDUgSsFZwmoWfvuyw9Xq1Iej3noet0dq84uoW8umqQnNRws8hk72n3gLFIK/d8/TJ+n/Kh3ym9k2z09QMmVcrRUMiw8RssbbV3oOJnWpDKV9gJnnrSWbHdRhcRKDpxBUIYwngGHy69rm7282Nh+KjOuNDZSeKHH6XmhQg+L3wJZ1SweLnVbqavPynDsn0Q5PGUTwYKGhBALmrxOjvtajwOqSi/e+v9yYkyuTow4gHOf6kBEeiOk/jNbhfn7sk5n6e90/p0dt5MikfM7VQ2anf7ZFkNt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(36840700001)(46966006)(40470700004)(426003)(16526019)(186003)(47076005)(1076003)(2616005)(2906002)(30864003)(70206006)(5660300002)(8936002)(4326008)(8676002)(44832011)(70586007)(7696005)(82310400005)(336012)(86362001)(36756003)(83380400001)(40480700001)(41300700001)(26005)(478600001)(6666004)(54906003)(356005)(81166007)(40460700003)(36860700001)(6916009)(82740400003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 12:42:41.1704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37515f6a-a230-434d-730b-08da94bc4842
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5251
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
Cc: jinzhou.su@amd.com, yifan1.zhang@amd.com, xiaojian.du@amd.com,
 perry.yuan@amd.com, "Ma, Li" <li.ma@amd.com>, Alexander.Deucher@amd.com,
 Evan.Quan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Ma,Li" <li.ma@amd.com>

Add new gpu_metrics_v2_3 to acquire average temperature info from SMU metrics. To acquire average temp info from gpu_metrics interface, but gpu_metrics_v2_2 only has members to show current temp info.
---
v1:
	Only add average_temperature_gfx in gpu_metrics_v2_3.
v2:
	Add average temp members for soc, core and l3 in gpu_metrics_v2_3 and put these new members at the end of gpu_metrics_v2_3. Add operation to read average temp info from metrics table.
v3:
	Merge v1 and v2 and rename the patch.
v4:
	Merge v3. Add firmware version judgment in vangogh_common_get_gpu_metrics to maintain backward compatibility and rename the patch. "return ret" on error scenario in smu_cmn_get_smc_version.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  58 +++++++
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 161 ++++++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   3 +
 3 files changed, 210 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 7e3231c2191c..a40ead44778a 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -824,4 +824,62 @@ struct gpu_metrics_v2_2 {
 	uint64_t			indep_throttle_status;
 };
 
+struct gpu_metrics_v2_3 {
+	struct metrics_table_header	common_header;
+
+	/* Temperature */
+	uint16_t			temperature_gfx; // gfx temperature on APUs
+	uint16_t			temperature_soc; // soc temperature on APUs
+	uint16_t			temperature_core[8]; // CPU core temperature on APUs
+	uint16_t			temperature_l3[2];
+
+	/* Utilization */
+	uint16_t			average_gfx_activity;
+	uint16_t			average_mm_activity; // UVD or VCN
+
+	/* Driver attached timestamp (in ns) */
+	uint64_t			system_clock_counter;
+
+	/* Power/Energy */
+	uint16_t			average_socket_power; // dGPU + APU power on A + A platform
+	uint16_t			average_cpu_power;
+	uint16_t			average_soc_power;
+	uint16_t			average_gfx_power;
+	uint16_t			average_core_power[8]; // CPU core power on APUs
+
+	/* Average clocks */
+	uint16_t			average_gfxclk_frequency;
+	uint16_t			average_socclk_frequency;
+	uint16_t			average_uclk_frequency;
+	uint16_t			average_fclk_frequency;
+	uint16_t			average_vclk_frequency;
+	uint16_t			average_dclk_frequency;
+
+	/* Current clocks */
+	uint16_t			current_gfxclk;
+	uint16_t			current_socclk;
+	uint16_t			current_uclk;
+	uint16_t			current_fclk;
+	uint16_t			current_vclk;
+	uint16_t			current_dclk;
+	uint16_t			current_coreclk[8]; // CPU core clocks
+	uint16_t			current_l3clk[2];
+
+	/* Throttle status (ASIC dependent) */
+	uint32_t			throttle_status;
+
+	/* Fans */
+	uint16_t			fan_pwm;
+
+	uint16_t			padding[3];
+
+	/* Throttle status (ASIC independent) */
+	uint64_t			indep_throttle_status;
+
+	/* Average Temperature */
+	uint16_t			average_temperature_gfx; // average gfx temperature on APUs
+	uint16_t			average_temperature_soc; // average soc temperature on APUs
+	uint16_t			average_temperature_core[8]; // average CPU core temperature on APUs
+	uint16_t			average_temperature_l3[2];
+};
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 847990145dcd..64235f123405 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -223,14 +223,13 @@ static int vangogh_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
-	struct amdgpu_device *adev = smu->adev;
 	uint32_t if_version;
+	uint32_t smu_version;
 	uint32_t ret = 0;
 
-	ret = smu_cmn_get_smc_version(smu, &if_version, NULL);
+	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
 	if (ret) {
-		dev_err(adev->dev, "Failed to get smu if version!\n");
-		goto err0_out;
+		return ret;
 	}
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
@@ -255,7 +254,10 @@ static int vangogh_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
+	if(smu_version >= 0x043F3E00)
+		smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_3);
+	else
+		smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
@@ -1648,6 +1650,63 @@ static int vangogh_set_watermarks_table(struct smu_context *smu,
 	return 0;
 }
 
+static ssize_t vangogh_get_legacy_gpu_metrics_v2_3(struct smu_context *smu,
+				      void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct gpu_metrics_v2_3 *gpu_metrics =
+		(struct gpu_metrics_v2_3 *)smu_table->gpu_metrics_table;
+	SmuMetrics_legacy_t metrics;
+	int ret = 0;
+
+	ret = smu_cmn_get_metrics_table(smu, &metrics, true);
+	if (ret)
+		return ret;
+
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 3);
+
+	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
+	gpu_metrics->temperature_soc = metrics.SocTemperature;
+	memcpy(&gpu_metrics->temperature_core[0],
+		&metrics.CoreTemperature[0],
+		sizeof(uint16_t) * 4);
+	gpu_metrics->temperature_l3[0] = metrics.L3Temperature[0];
+
+	gpu_metrics->average_gfx_activity = metrics.GfxActivity;
+	gpu_metrics->average_mm_activity = metrics.UvdActivity;
+
+	gpu_metrics->average_socket_power = metrics.CurrentSocketPower;
+	gpu_metrics->average_cpu_power = metrics.Power[0];
+	gpu_metrics->average_soc_power = metrics.Power[1];
+	gpu_metrics->average_gfx_power = metrics.Power[2];
+	memcpy(&gpu_metrics->average_core_power[0],
+		&metrics.CorePower[0],
+		sizeof(uint16_t) * 4);
+
+	gpu_metrics->average_gfxclk_frequency = metrics.GfxclkFrequency;
+	gpu_metrics->average_socclk_frequency = metrics.SocclkFrequency;
+	gpu_metrics->average_uclk_frequency = metrics.MemclkFrequency;
+	gpu_metrics->average_fclk_frequency = metrics.MemclkFrequency;
+	gpu_metrics->average_vclk_frequency = metrics.VclkFrequency;
+	gpu_metrics->average_dclk_frequency = metrics.DclkFrequency;
+
+	memcpy(&gpu_metrics->current_coreclk[0],
+		&metrics.CoreFrequency[0],
+		sizeof(uint16_t) * 4);
+	gpu_metrics->current_l3clk[0] = metrics.L3Frequency[0];
+
+	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			smu_cmn_get_indep_throttler_status(metrics.ThrottlerStatus,
+							   vangogh_throttler_map);
+
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+
+	*table = (void *)gpu_metrics;
+
+	return sizeof(struct gpu_metrics_v2_3);
+}
+
 static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
@@ -1705,6 +1764,77 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v2_2);
 }
 
+static ssize_t vangogh_get_gpu_metrics_v2_3(struct smu_context *smu,
+				      void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct gpu_metrics_v2_3 *gpu_metrics =
+		(struct gpu_metrics_v2_3 *)smu_table->gpu_metrics_table;
+	SmuMetrics_t metrics;
+	int ret = 0;
+
+	ret = smu_cmn_get_metrics_table(smu, &metrics, true);
+	if (ret)
+		return ret;
+
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 3);
+
+	gpu_metrics->temperature_gfx = metrics.Current.GfxTemperature;
+	gpu_metrics->temperature_soc = metrics.Current.SocTemperature;
+	memcpy(&gpu_metrics->temperature_core[0],
+		&metrics.Current.CoreTemperature[0],
+		sizeof(uint16_t) * 4);
+	gpu_metrics->temperature_l3[0] = metrics.Current.L3Temperature[0];
+
+	gpu_metrics->average_temperature_gfx = metrics.Average.GfxTemperature;
+	gpu_metrics->average_temperature_soc = metrics.Average.SocTemperature;
+	memcpy(&gpu_metrics->average_temperature_core[0],
+		&metrics.Average.CoreTemperature[0],
+		sizeof(uint16_t) * 4);
+	gpu_metrics->average_temperature_l3[0] = metrics.Average.L3Temperature[0];
+
+	gpu_metrics->average_gfx_activity = metrics.Current.GfxActivity;
+	gpu_metrics->average_mm_activity = metrics.Current.UvdActivity;
+
+	gpu_metrics->average_socket_power = metrics.Current.CurrentSocketPower;
+	gpu_metrics->average_cpu_power = metrics.Current.Power[0];
+	gpu_metrics->average_soc_power = metrics.Current.Power[1];
+	gpu_metrics->average_gfx_power = metrics.Current.Power[2];
+	memcpy(&gpu_metrics->average_core_power[0],
+		&metrics.Average.CorePower[0],
+		sizeof(uint16_t) * 4);
+
+	gpu_metrics->average_gfxclk_frequency = metrics.Average.GfxclkFrequency;
+	gpu_metrics->average_socclk_frequency = metrics.Average.SocclkFrequency;
+	gpu_metrics->average_uclk_frequency = metrics.Average.MemclkFrequency;
+	gpu_metrics->average_fclk_frequency = metrics.Average.MemclkFrequency;
+	gpu_metrics->average_vclk_frequency = metrics.Average.VclkFrequency;
+	gpu_metrics->average_dclk_frequency = metrics.Average.DclkFrequency;
+
+	gpu_metrics->current_gfxclk = metrics.Current.GfxclkFrequency;
+	gpu_metrics->current_socclk = metrics.Current.SocclkFrequency;
+	gpu_metrics->current_uclk = metrics.Current.MemclkFrequency;
+	gpu_metrics->current_fclk = metrics.Current.MemclkFrequency;
+	gpu_metrics->current_vclk = metrics.Current.VclkFrequency;
+	gpu_metrics->current_dclk = metrics.Current.DclkFrequency;
+
+	memcpy(&gpu_metrics->current_coreclk[0],
+		&metrics.Current.CoreFrequency[0],
+		sizeof(uint16_t) * 4);
+	gpu_metrics->current_l3clk[0] = metrics.Current.L3Frequency[0];
+
+	gpu_metrics->throttle_status = metrics.Current.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			smu_cmn_get_indep_throttler_status(metrics.Current.ThrottlerStatus,
+							   vangogh_throttler_map);
+
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+
+	*table = (void *)gpu_metrics;
+
+	return sizeof(struct gpu_metrics_v2_3);
+}
+
 static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
@@ -1772,20 +1902,27 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 static ssize_t vangogh_common_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
-	struct amdgpu_device *adev = smu->adev;
 	uint32_t if_version;
+	uint32_t smu_version;
 	int ret = 0;
 
-	ret = smu_cmn_get_smc_version(smu, &if_version, NULL);
+	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
 	if (ret) {
-		dev_err(adev->dev, "Failed to get smu if version!\n");
 		return ret;
 	}
 
-	if (if_version < 0x3)
-		ret = vangogh_get_legacy_gpu_metrics(smu, table);
-	else
-		ret = vangogh_get_gpu_metrics(smu, table);
+	if(smu_version >= 0x043F3E00){
+		if (if_version < 0x3)
+			ret = vangogh_get_legacy_gpu_metrics_v2_3(smu, table);
+		else
+			ret = vangogh_get_gpu_metrics_v2_3(smu, table);
+	}
+	else{
+		if (if_version < 0x3)
+			ret = vangogh_get_legacy_gpu_metrics(smu, table);
+		else
+			ret = vangogh_get_gpu_metrics(smu, table);
+	}	
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 15e4298c7cc8..e4f8f90ac5aa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -969,6 +969,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(2, 2):
 		structure_size = sizeof(struct gpu_metrics_v2_2);
 		break;
+	case METRICS_VERSION(2, 3):
+		structure_size = sizeof(struct gpu_metrics_v2_3);
+		break;
 	default:
 		return;
 	}
-- 
2.25.1

