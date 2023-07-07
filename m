Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79560C0015E
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 19:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0134710E5DD;
	Fri,  7 Jul 2023 19:32:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF9110E5DD
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 19:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azNjNZMRjpznmYmWLQ0gwaEnHiHEhShsMHCelVv7c9omHBD3ldgk1WeKSPv3jb3McnehnkarmeUEPnWUeokHsbVR3GT7fr2nQnrg5py6Hqs7haqTSzlnAt2iESkqamE4vLa2c2ciYfSRbJDWMwoIoxKB7a8sveoSP/W7+D74S5fRxWNtO2jBCCAD+gIJI8FErjS6EBw4zVHmFmZqakXYVlZVSzZcThk60dXrNWSFw9HRyUGqI7vZgJ1evwp/omzB858MQ2/vB6lfaymUm+bLHLStgGOlUvhn8mFJ9fZOFLC4P7JDSND0D8cef2lOPWsqNKbsTHVYAKF9vya5ah4jsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpIbf9F+E9e8rayGs+aAbv3LIiPR9H+hUn3CFo0qJBc=;
 b=hzDqdQ5W+7ruOfpLj4b6gO4GoFyyxZ8nq07hSWnFu5bW5zICT/S7866BtKvKdGrIy0Gn59OG3FY8PXxCC3IcrqciFAEx+3IJJ3V8Gcy7O6Pdbm6HeNZH6JpHjG0I2uZojKO+9N9E4z/6phLeheqQ9M7N+F1XOzPiNA+9T0InUZvO7+ADJBpKpVOylDdv/VynZLfW5/07FmkZdle77bd570CbamKd6JvOZoK7tCbw2WK3g/I/avsMye/869J5khD3mlSO7uiTXPP13P7Ss2G2kUP7rv9r5HZr7xuwrT+JeyLgc9SUAfsxobMFOzIsjjT+WVCVkvaFey8eyDrp26+nsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpIbf9F+E9e8rayGs+aAbv3LIiPR9H+hUn3CFo0qJBc=;
 b=1gFjcTVSlv+FyOKTKv6uMMjYASgrU9p85O7Q1+s0grKfnXAM8jwfOy2UsMWUl9MAgpuoH4vO4mmdHKlJNclfmnJ5p/xskOm/qjbrOWm2hoE5FAxSlqP9+mERJwE5H0wTjtN0oKLzn+64OqpQ7bCh2DTQ1NBMXoHB8l83yTAeFW8=
Received: from DS7P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::16) by
 BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 19:32:00 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::be) by DS7P222CA0020.outlook.office365.com
 (2603:10b6:8:2e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 19:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Fri, 7 Jul 2023 19:32:00 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 14:31:57 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: share the code around SMU13 pcie parameters
 update
Date: Fri, 7 Jul 2023 14:31:34 -0500
Message-ID: <20230707193135.16716-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230707193135.16716-1-mario.limonciello@amd.com>
References: <20230707193135.16716-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|BL1PR12MB5378:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e83879c-262e-4118-a99c-08db7f20d582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5qDncmHVk0vXlvGfrknOxF2qZFwjTJODa4zYA3MiDqVxBmvhwJ9fpNIunmgCSdG6BTfYOiblxuA7SL4i2lTi7j7l4PshsknHVJtQZhW9PonHx2XquTDwYB37kBFtF2KrWmnC/Pd6HELHr/K67pAO7F9pkTVHlSjGU+hf9EUxyoBif1GZctGlGkzpF3FPhmYZykz7ldm72aS6O2AsNmvEiOP2hisYjCedC45253ZJCSv1P6fMqp4VIH4OtwwTWCiUgef69f2CW0ZON5/l+CSDomfhcAhejo1dwIqcTk7qm5aFZ7xWsNYg4Hi+Ddq1gX7HNeZy82lj8YxecMWfREdZrLIhkdbDCt20YHQH1+omhPSQ9dj6yuzRK7SpMFmAvXoZWdNTBDPffv+PmbZ/VO1vo3qg3FwH3DqQ+iXj8OmuBjhGLM+1xsvVVbIuglS6rLXtB/PhTeuutd+V5NwiAwuvGHckc1/nUN/osqLWjkdUi0oFnl3Zb3S/XCqiWo2eBzjoSzgQlzaLs1Q4batjeCUrIcfJUzDwBrM3HemQUr6EzfijEDITLcZZtuplXXMNcZ4pQ6C0i4JXcLYajqJJaHkrzQLbXfdLjdmpuAG+vpdPJ8LULT1SERMXRa9w5H6v/RSB5KdLyy+u+Xpg557o6iY3CxWa26nWmWMAy0SuVbl5jbkSsXSEu9cRFIZoPbRdUOh6Xf/9zoApx0kVH9SHNlTWchBwmww38ruSLOizyb/q/CayiPhJJemSxaCLVuGbyyzaeNhdprtRzqDcabZZ6MjZjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(81166007)(356005)(82740400003)(86362001)(82310400005)(36756003)(40460700003)(40480700001)(41300700001)(8936002)(26005)(5660300002)(1076003)(186003)(44832011)(2616005)(16526019)(2906002)(36860700001)(83380400001)(8676002)(426003)(15650500001)(336012)(47076005)(6666004)(316002)(7696005)(70586007)(478600001)(54906003)(70206006)(4326008)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 19:32:00.0067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e83879c-262e-4118-a99c-08db7f20d582
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
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
Cc: Evan Quan <evan.quan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

So that SMU13.0.0 and SMU13.0.7 do not need to have one copy each.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  4 +++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 31 +++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 33 +------------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 33 +------------------
 4 files changed, 37 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 6a0ac0bbaace9..355c156d871af 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -295,5 +295,9 @@ int smu_v13_0_get_pptable_from_firmware(struct smu_context *smu,
 					uint32_t *size,
 					uint32_t pptable_id);
 
+int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
+				     uint32_t pcie_gen_cap,
+				     uint32_t pcie_width_cap);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 3856da6c3f3d2..2ef877c2cb590 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2424,3 +2424,34 @@ int smu_v13_0_mode1_reset(struct smu_context *smu)
 
 	return ret;
 }
+
+int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
+				     uint32_t pcie_gen_cap,
+				     uint32_t pcie_width_cap)
+{
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	struct smu_13_0_pcie_table *pcie_table =
+				&dpm_context->dpm_tables.pcie_table;
+	uint32_t smu_pcie_arg;
+	int ret, i;
+
+	for (i = 0; i < pcie_table->num_of_link_levels; i++) {
+		if (pcie_table->pcie_gen[i] > pcie_gen_cap)
+			pcie_table->pcie_gen[i] = pcie_gen_cap;
+		if (pcie_table->pcie_lane[i] > pcie_width_cap)
+			pcie_table->pcie_lane[i] = pcie_width_cap;
+
+		smu_pcie_arg = i << 16;
+		smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
+		smu_pcie_arg |= pcie_table->pcie_lane[i];
+
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_OverridePcieParameters,
+						      smu_pcie_arg,
+						      NULL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 1d995f53aaaba..b9bde5fa8f8f5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1645,37 +1645,6 @@ static int smu_v13_0_0_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_v13_0_0_update_pcie_parameters(struct smu_context *smu,
-					      uint32_t pcie_gen_cap,
-					      uint32_t pcie_width_cap)
-{
-	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	struct smu_13_0_pcie_table *pcie_table =
-				&dpm_context->dpm_tables.pcie_table;
-	uint32_t smu_pcie_arg;
-	int ret, i;
-
-	for (i = 0; i < pcie_table->num_of_link_levels; i++) {
-		if (pcie_table->pcie_gen[i] > pcie_gen_cap)
-			pcie_table->pcie_gen[i] = pcie_gen_cap;
-		if (pcie_table->pcie_lane[i] > pcie_width_cap)
-			pcie_table->pcie_lane[i] = pcie_width_cap;
-
-		smu_pcie_arg = i << 16;
-		smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
-		smu_pcie_arg |= pcie_table->pcie_lane[i];
-
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_OverridePcieParameters,
-						      smu_pcie_arg,
-						      NULL);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static const struct smu_temperature_range smu13_thermal_policy[] = {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
 	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000},
@@ -2654,7 +2623,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.print_clk_levels = smu_v13_0_0_print_clk_levels,
 	.force_clk_levels = smu_v13_0_0_force_clk_levels,
-	.update_pcie_parameters = smu_v13_0_0_update_pcie_parameters,
+	.update_pcie_parameters = smu_v13_0_update_pcie_parameters,
 	.get_thermal_temperature_range = smu_v13_0_0_get_thermal_temperature_range,
 	.register_irq_handler = smu_v13_0_register_irq_handler,
 	.enable_thermal_alert = smu_v13_0_enable_thermal_alert,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index cda4e818aab7e..3ba02131e682b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1635,37 +1635,6 @@ static int smu_v13_0_7_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_v13_0_7_update_pcie_parameters(struct smu_context *smu,
-					      uint32_t pcie_gen_cap,
-					      uint32_t pcie_width_cap)
-{
-	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	struct smu_13_0_pcie_table *pcie_table =
-				&dpm_context->dpm_tables.pcie_table;
-	uint32_t smu_pcie_arg;
-	int ret, i;
-
-	for (i = 0; i < pcie_table->num_of_link_levels; i++) {
-		if (pcie_table->pcie_gen[i] > pcie_gen_cap)
-			pcie_table->pcie_gen[i] = pcie_gen_cap;
-		if (pcie_table->pcie_lane[i] > pcie_width_cap)
-			pcie_table->pcie_lane[i] = pcie_width_cap;
-
-		smu_pcie_arg = i << 16;
-		smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
-		smu_pcie_arg |= pcie_table->pcie_lane[i];
-
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_OverridePcieParameters,
-						      smu_pcie_arg,
-						      NULL);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static const struct smu_temperature_range smu13_thermal_policy[] =
 {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
@@ -2234,7 +2203,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.print_clk_levels = smu_v13_0_7_print_clk_levels,
 	.force_clk_levels = smu_v13_0_7_force_clk_levels,
-	.update_pcie_parameters = smu_v13_0_7_update_pcie_parameters,
+	.update_pcie_parameters = smu_v13_0_update_pcie_parameters,
 	.get_thermal_temperature_range = smu_v13_0_7_get_thermal_temperature_range,
 	.register_irq_handler = smu_v13_0_register_irq_handler,
 	.enable_thermal_alert = smu_v13_0_enable_thermal_alert,
-- 
2.25.1

