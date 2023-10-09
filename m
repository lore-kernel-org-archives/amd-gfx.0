Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B08E95A8E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 14:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB8710E279;
	Mon,  9 Oct 2023 14:53:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46CF110E136
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 14:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XF+E+3MWi4f1ITgZ79V0KkHLrtUfuiZQjGG2NZu3UDAknSo1Vs0B+qAgsZUarelqFkTPzu2WvlW9IXldhdNf90BI9GdDl/U14Qs8hdOhyM4jjKdFVFjKB+7WVVx4pqW7pNsqC+v2/vRWPUq7u3cfExHqbgtWI/Mz49BW4I4yp0tsFAtDsnMomHeAtnqc4gRK1YG7+FD0kgnb4swQiOhIH82eYC90jtwX30ZplfScKHJ3XRztPWbIP5OvkLiP/2dt9TqkxoE/2eh1LWBGIAow49efHWsjIcYS42rV1qJq4JT0Bxe8ISl55B/r9JYPvyI8sLL4OjO6wdoDzACV33U06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6WlbxlLgJbozZWa8GW4hL5JYsRQkRg9hI0z2S50kHQ=;
 b=EQm0PGgS/yEebRorSpg+bzwgMo4EXMJ/5mF7/YCpxFbzFrsl4mBXwavSnmwUqzcNwjHec4k/jJaloz8+ttk2PjoGqCSIuPD7Kcx0VzT7/PCVvFMmbBCw4qp//czpmXIsPrV9bRPsmovVP3g+MFwlzJaVPedcxzu0jScDKJhWKm3MOAXFO9+KWcW97+hOuQkb4jfO2ppoqi5hhW1XgELU2Vt/Ztvw9wd1WeQOeelUGvnRS/UF623Ww3AcBHy2GHE0MAVMDLRRmWWLhAfsbqE+eKcMAF+1Uj+7o0FrYrFjVGu8UEK+a6yDkntQ/yXy9bS31Nte8SabFUDzKUowdvHgLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6WlbxlLgJbozZWa8GW4hL5JYsRQkRg9hI0z2S50kHQ=;
 b=D6vERWEJICsYiw8m+DpVFlPuuuTpF24xJk/8MESdiOO1o7DudCGt0CTYa3uFiSfXhm5IsiZeAHRCowSaPo5wA7kWgyes4VCjgknZQKM6l/XAcNx69a8F2ATR4R/oi39xlldbzDYoE5MSFfPgm6Zq3/BBKyJ0/6VMCZNO7Q2DWvs=
Received: from BL1PR13CA0410.namprd13.prod.outlook.com (2603:10b6:208:2c2::25)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Mon, 9 Oct
 2023 14:53:34 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::22) by BL1PR13CA0410.outlook.office365.com
 (2603:10b6:208:2c2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.20 via Frontend
 Transport; Mon, 9 Oct 2023 14:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 14:53:34 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 09:53:32 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/3] drm/amd/pm: Use gpu_metrics_v1_4 for SMUv13.0.6
Date: Mon, 9 Oct 2023 22:53:15 +0800
Message-ID: <20231009145315.597629-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009145315.597629-1-asad.kamal@amd.com>
References: <20231009145315.597629-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|MW6PR12MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 82fe3b69-62d6-4ee7-f39c-08dbc8d7832b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUKU3ogNmHlilJwUF+FP5uZytweiNQ7yKECAstAnN+HRoPfN7zzW78oXtFDuLKYp8KIoMEunTLqrkH6wJQK8ewdJO5Q2ucIWL1YVw5N7bJBe6x/vjxWUjw2bPaqf9uwFFpWAMCMcQgcbXcIelKOUd7G4gUuokWPEoE35Urf1ImhR+xN+SGDUTT30qKtwbIUavVMbECOAC+Rno1x83cGBRFosQHgw6KkV6xuhT5hyQVHkZOkPb1RSORWD9hfuMI/jjY52ATNLFJS4p5CTaA6wiGRy2Xdbj/HByqabE+G+SwgWo/3s1yGpOrCbDhHMSpUcaJNAVwTCRSK+eHdP46WzHkcmcBRK5ZkMLoTqqtW4PvgqXnlHX2WUH1wUGQZ6ERQsuN+z4z17aS0cSNwPHS8CgrUy/Pb4ZJUMDFyOs91JswTFXwi2a9OgRbjr12beYi7xrTtouFoud4P4wzgz0aJYSmi7QdmK/VKbf1Yh52YT3RRcOk3db1eHft6s4Tjn0nuUaZ3WDeHeh2c/Wc/9M+7pnYWw4csVPrcuq+aaFFEAgDDXGwcSxscxWo4lHEDwmW4BLreV7HfdmWUhXJl9TZxJf/ZwdzIWofezYwd8NFDdJ82Ir6m5Yf+6IKGgCH350lz7nJi5nz4VoAwyZLG0tEm55FNtJ987tVPwqgPPhoELF1FcEtGJOVixUr8+qYxYKRjLHyH32iKWZ472W0KTcWJKsSfnPw4Q5/NWEqfeUhAEnxNHGx6vv5+lerBCv+IjLSleqzKdwbkewJi48xfDKXb91A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(82310400011)(1800799009)(64100799003)(186009)(451199024)(40470700004)(36840700001)(46966006)(6666004)(1076003)(40480700001)(86362001)(356005)(36756003)(81166007)(82740400003)(26005)(40460700003)(36860700001)(336012)(16526019)(47076005)(83380400001)(2906002)(426003)(7696005)(478600001)(8676002)(2616005)(70206006)(4326008)(8936002)(41300700001)(6916009)(70586007)(316002)(5660300002)(54906003)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:53:34.6964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fe3b69-62d6-4ee7-f39c-08dbc8d7832b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835
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

v3: Removed filling gpu metric instantaneous
pcie bw

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 65 ++++++++++++-------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ce971a93d28b..7ab73112e4f3 100644
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
@@ -2033,6 +2038,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 			DECODE_LANE_WIDTH(link_width_level);
 		gpu_metrics->pcie_link_speed =
 			smu_v13_0_6_get_current_pcie_link_speed(smu);
+		gpu_metrics->pcie_bandwidth_acc =
+				SMUQ10_ROUND(metrics->PcieBandwidthAcc[0]);
 	}
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
@@ -2042,12 +2049,22 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
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

