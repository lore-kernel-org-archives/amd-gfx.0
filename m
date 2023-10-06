Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0406E81E02
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 14:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5017710E511;
	Fri,  6 Oct 2023 14:42:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF81210E50B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 14:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4Z8ohpN5X3HekC9mI4dc/XOiKz5+ko3iH56EeWMgkmEwHTrd148oC/4SHBwYUe+b6WYLIMSLxvbCxRlbr2/j7ahGMI2Xr9852+zkH3ZB9Yyf85vzzLUIwRf6Gwqfd0g3jl08morC8ISzEWpgRE6GamA0ztHZDtOcfuHJf1HePvVbEe1WF0f4G4c9xbC++6U5CCQHlAPaivR9eKcLlwx0PZ5VLvE3tNzSzAOgTWA5WgpEbTwJ/I3W59gUijyGDgONYLC296i66aMUvkFjzwgGyyYydtNvsiWoASmaMuMJMEGLuc7Xmws00MGnlETOx3GrSTrZ+QxPHoVK8MUWbyshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LjSW1mPadkX3qeqWNonrD15eaQmLPpWna+VVhp9Yok=;
 b=UJN4QKH/LDAeju2OQWT0mUpYEBVZV8pSykZLC58mo0+7y1J6Q87L6iTlF1FpS9J36pgT/R4kKZr6t5wSPGqsVQRNxV9QEsU4cz8YFtBuThcKjMCrpXmbr0DsY1SUBLzde5mq+XYF7+ICC5qvXKMXXAjGgROq9jvYzZ77UdmRtXGrzmMK0ve/8LGFfSgVtTYcnwvtC7nd7J3oIKCxIw2K+spiwC8XTXNw+EyX5w1ywBzLej1XgFF7UCbOiN2wthneppFtCx4CkIPtmJPEiFIka63EQ5wDMrMUv5Oyuv/rKfLNzFBZ9vx5sutkYwxzGXRpZ7aiPFDdvn8KHcnW5fT99w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LjSW1mPadkX3qeqWNonrD15eaQmLPpWna+VVhp9Yok=;
 b=aWeZjGEeWnJdKaOH77jD9dFXLlLzjYL1mo9zk6IXsLosPZszQ3DhyBPpl+4s3jOTfD7QoiFnNxUdO/zBUioULnL7ca9GFG6AzZsLG2rqh0TB/9GhXUoGFabafi2nrSu/d4pEDwfVA/ucREEN8Z43uSyp4qGS32fMWIGAeUav9fI=
Received: from MW4PR04CA0196.namprd04.prod.outlook.com (2603:10b6:303:86::21)
 by BN9PR12MB5289.namprd12.prod.outlook.com (2603:10b6:408:102::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Fri, 6 Oct
 2023 14:42:36 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::ed) by MW4PR04CA0196.outlook.office365.com
 (2603:10b6:303:86::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.31 via Frontend
 Transport; Fri, 6 Oct 2023 14:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 14:42:35 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 09:42:33 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amd/pm: Use gpu_metrics_v1_4 for SMUv13.0.6
Date: Fri, 6 Oct 2023 22:41:40 +0800
Message-ID: <20231006144140.566546-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231006144140.566546-1-asad.kamal@amd.com>
References: <20231006144140.566546-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|BN9PR12MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: 65148b65-73fe-4519-3537-08dbc67a7b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACeJO+F7i2iSivTxjFH9kiynKxfN0Jhwz/rrqURwlnKUhdCgHBtqDOaf/Goha1X9Zx/L352a06ot1cGGRHLGtanZxrhQ7EJlye0JHgfEtr+IH5WkDQpcgru3wKr+fkgcUV6dTRDDep7GFKqbKDHzpnfr29/+pA16qR5Ufi6CJRIt1iRo/Fk6PxwQxdMEVrsyXmcpW4/inwJpgn/3TVct3AkSrITn0da+w1xnxjECXGUllN8Ps3M8IrvWmEg5QyoQhAI+LiWeU15va+rEF3Z9qp0sEhrReMx9YtOtVtXYLVFdoR58L9165bKe/swd7yBDvWiyj5CRPA2kXOnv4MGDMvQKE37hBAX0GZvgUAvfIvJGwqOBHwnDkg3yc+HnJ5XZ7xCcfdqsCPbYn1XVNaH+jnCHv8BfTl3BmWck+kCBJwMyTNh82QmpHXDckPmBQ+Zy/pIy+0mc6PpdQRAb1MJtLjYpI7OpsQgsZQxKfGo+DwXIOi1OVHbMx156K9+M9XvitIiS6ABOAov7Uj3yobFZtq/D5fJtz/Pzu71SU/hX18MgNeWREL1IoVRU8YLYY/3KLIVTx/kwC4EloJ9WpQMyiW9LXHhGUq1LIsGSkvFm4ooMIs2JAW2FICfDlHVxYGGnSDwdrWwcQhxIBKWl0AoPFfIfTauFlNPJZGRbnbqCM+69yve5XhcF1HsWuR9cVPQr3f+4kKWfNhVBo2lwwGBo3qWfTIP9mm8ucadMHFEMXbJwB09SGMnV33JDmQIuysiivl2ZH5h9YArMH/h9+c6OtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(47076005)(2906002)(83380400001)(40460700003)(86362001)(356005)(36756003)(82740400003)(81166007)(40480700001)(36860700001)(54906003)(316002)(70206006)(70586007)(7696005)(336012)(1076003)(2616005)(44832011)(41300700001)(6916009)(478600001)(6666004)(8676002)(4326008)(426003)(8936002)(5660300002)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 14:42:35.6258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65148b65-73fe-4519-3537-08dbc67a7b29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5289
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
Cc: le.ma@amd.com, Lijo.Lazar@amd.com, asad.kamal@amd.com, shiwu.zhang@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use gpu_metrics_v1_4 for SMUv13.0.6 to fill
gpu metric info

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 67 ++++++++++++-------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ce971a93d28b..3a07f1c95e45 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -279,7 +279,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_4);
 	smu_table->gpu_metrics_table =
 		kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
@@ -1969,22 +1969,19 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
 static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_3 *gpu_metrics =
-		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_4 *gpu_metrics =
+		(struct gpu_metrics_v1_4 *)smu_table->gpu_metrics_table;
 	struct amdgpu_device *adev = smu->adev;
-	int ret = 0, inst0, xcc0;
+	int ret = 0, xcc_id, inst, i;
 	MetricsTable_t *metrics;
 	u16 link_width_level;
 
-	inst0 = adev->sdma.instance[0].aid_id;
-	xcc0 = GET_INST(GC, 0);
-
 	metrics = kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
 	ret = smu_v13_0_6_get_metrics_table(smu, metrics, true);
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 4);
 
 	gpu_metrics->temperature_hotspot =
 		SMUQ10_ROUND(metrics->MaxSocketTemperature);
@@ -2000,30 +1997,38 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	gpu_metrics->average_umc_activity =
 		SMUQ10_ROUND(metrics->DramBandwidthUtilization);
 
-	gpu_metrics->average_socket_power =
+	gpu_metrics->curr_socket_power =
 		SMUQ10_ROUND(metrics->SocketPower);
 	/* Energy counter reported in 15.259uJ (2^-16) units */
 	gpu_metrics->energy_accumulator = metrics->SocketEnergyAcc;
 
-	gpu_metrics->current_gfxclk =
-		SMUQ10_ROUND(metrics->GfxclkFrequency[xcc0]);
-	gpu_metrics->current_socclk =
-		SMUQ10_ROUND(metrics->SocclkFrequency[inst0]);
-	gpu_metrics->current_uclk = SMUQ10_ROUND(metrics->UclkFrequency);
-	gpu_metrics->current_vclk0 =
-		SMUQ10_ROUND(metrics->VclkFrequency[inst0]);
-	gpu_metrics->current_dclk0 =
-		SMUQ10_ROUND(metrics->DclkFrequency[inst0]);
+	for (i = 0; i < MAX_GFX_CLKS; i++) {
+		xcc_id = GET_INST(GC, i);
+		if (xcc_id >= 0)
+			gpu_metrics->current_gfxclk[i] =
+				SMUQ10_ROUND(metrics->GfxclkFrequency[xcc_id]);
+
+		if (i < MAX_CLKS) {
+			gpu_metrics->current_socclk[i] =
+				SMUQ10_ROUND(metrics->SocclkFrequency[i]);
+			inst = GET_INST(VCN, i);
+			if (inst >= 0) {
+				gpu_metrics->current_vclk0[i] =
+					SMUQ10_ROUND(metrics->VclkFrequency[inst]);
+				gpu_metrics->current_dclk0[i] =
+					SMUQ10_ROUND(metrics->DclkFrequency[inst]);
+			}
+		}
+	}
 
-	gpu_metrics->average_gfxclk_frequency = gpu_metrics->current_gfxclk;
-	gpu_metrics->average_socclk_frequency = gpu_metrics->current_socclk;
-	gpu_metrics->average_uclk_frequency = gpu_metrics->current_uclk;
-	gpu_metrics->average_vclk0_frequency = gpu_metrics->current_vclk0;
-	gpu_metrics->average_dclk0_frequency = gpu_metrics->current_dclk0;
+	gpu_metrics->current_uclk = SMUQ10_ROUND(metrics->UclkFrequency);
 
 	/* Throttle status is not reported through metrics now */
 	gpu_metrics->throttle_status = 0;
 
+	/* Clock Lock Status. Each bit corresponds to each GFXCLK instance */
+	gpu_metrics->gfxclk_lock_status = metrics->GfxLockXCDMak >> GET_INST(GC, 0);
+
 	if (!(adev->flags & AMD_IS_APU)) {
 		link_width_level = smu_v13_0_6_get_current_pcie_link_width_level(smu);
 		if (link_width_level > MAX_LINK_WIDTH)
@@ -2033,6 +2038,10 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 			DECODE_LANE_WIDTH(link_width_level);
 		gpu_metrics->pcie_link_speed =
 			smu_v13_0_6_get_current_pcie_link_speed(smu);
+		gpu_metrics->pcie_bandwidth_acc =
+				SMUQ10_ROUND(metrics->PcieBandwidthAcc[0]);
+		gpu_metrics->pcie_bandwidth_inst =
+				SMUQ10_ROUND(metrics->PcieBandwidth[0]);
 	}
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
@@ -2042,12 +2051,22 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	gpu_metrics->mem_activity_acc =
 		SMUQ10_ROUND(metrics->DramBandwidthUtilizationAcc);
 
+	for (i = 0; i < NUM_XGMI_LINKS; i++) {
+		gpu_metrics->xgmi_read_data_acc[i] =
+			SMUQ10_ROUND(metrics->XgmiReadDataSizeAcc[i]);
+		gpu_metrics->xgmi_write_data_acc[i] =
+			SMUQ10_ROUND(metrics->XgmiWriteDataSizeAcc[i]);
+	}
+
+	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(metrics->XgmiWidth);
+	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(metrics->XgmiBitrate);
+
 	gpu_metrics->firmware_timestamp = metrics->Timestamp;
 
 	*table = (void *)gpu_metrics;
 	kfree(metrics);
 
-	return sizeof(struct gpu_metrics_v1_3);
+	return sizeof(*gpu_metrics);
 }
 
 static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
-- 
2.42.0

