Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CDBC87FCB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 15:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D57210E042;
	Tue,  5 Aug 2025 15:51:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tBaUaGQJ";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A43410E042
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 15:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJ+Ujlhu1pHoBMR0wDEI+E3itUEfTvdHpJhIoeIdtrW1PvQvYnteV7fzFgcQ+wXNZMnTbUi+jHy66D+bxobxuK+mesKO77MHqiTTNEt/X+rnw1vXasUVNmWqZlI4KwqCRvXFUxmOP3Qk9FZUke69WOKw4RrHJwQuDV3Wu76zbhiJacJbzyXrJX6R8NweOnsSDwY5sHLkqWH04KQo/IpHGsJnbLvicb2lX48YSiDyheYauFr6UsmQzSODh4DEwZ+cHv3fh3NZnVpkFpXzrrsION3eoTzSccl1nrT0mSNUZKS7KAnV2ZfzBN9/MgPkdyzhvRamOc5G2VcqRRTbhlsz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHRE9skR8HzRoYq1bpBKbxtep5BvXTPR7W/EOnDzj2c=;
 b=I0uv7qHm6KpRIfcqzL8rF/8cb4YSOEmUnejJpcE3JxkR9xl3mHXXTKMbEfj2sD7PFEaaMUrX+qapcuJC2nCwumaaVM1jU0+uAbzMnsXL+AVZuRTfB3fdwjF4c+gBWKdZkSLBwBG/7dObmwFRBaC5/S8g1JWzI5wnz86PpG3/gZGlYVG9UGSdvFP36JiucJebQJ4NhWE1SNIIYqzaQ6utOMrTtutimOoMNjdCcVnS5PtulH915YcTcUSKBiiOzKtaKZ48VfwTHJd7fgN4jFPi2Geu6G+vQN6yydcKxZBeWw+4YAw+sD+CGApPptEXUFfQAYBzWkQL2pt6nIDqy9FylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHRE9skR8HzRoYq1bpBKbxtep5BvXTPR7W/EOnDzj2c=;
 b=tBaUaGQJRE2WjqDj/Q0Qk1tSalSYllNGLXk9S9NSsvm/vfnZ5FydjeXJvuWNCOxmIBRMBRpLHZawcEuOsnaX6L566Zd8E83wYZTm0yowWmbtz3rxj3j/3FDKh3x0MwoEDo2+UNFedWdycBbDRCbuzj7erYtdmD2+vT6s4WBR0D8=
Received: from BN9PR03CA0154.namprd03.prod.outlook.com (2603:10b6:408:f4::9)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 15:51:14 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::d0) by BN9PR03CA0154.outlook.office365.com
 (2603:10b6:408:f4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.13 via Frontend Transport; Tue,
 5 Aug 2025 15:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 15:51:13 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 10:51:11 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <alexander.deucher@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH v2] drm/amd/pm: Increase cache interval time
Date: Tue, 5 Aug 2025 23:50:58 +0800
Message-ID: <20250805155058.669805-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e0c6fee-88ca-4df0-c505-08ddd437e7ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rBesjgwEUVaUzgsYGam/pSMny97tdP2wEmGfEmBmFVzyySimS2nKcZyq5pAm?=
 =?us-ascii?Q?IaAQqkvVbMzhg9U/SFYgPHG/B2PzkdkuXckJdxaGc8d3j1rq453V8v6206B8?=
 =?us-ascii?Q?PxrrUkWjs8VtKkkhM4Jd0ddVbKoypeXhGFSFGw25ha9U503uxjHTsuczo/kl?=
 =?us-ascii?Q?IOyKkd8zbO7N3BIcnUrsb9djXGyVCwGKYrzEyDYlueucRbp7opEcZazEBubT?=
 =?us-ascii?Q?eigEltldClq0g4eLriaShuxg+ZNX4/yxMI1iMC1vlVub3rJUEnK347YAmiR4?=
 =?us-ascii?Q?XQDvttfOVt6aZTah17nDYZhHEu9TNruPLTG6AIQz4PVzxvZHVGEF6EfbldGQ?=
 =?us-ascii?Q?Y//FvogbKZFV7Q1AysMS0n2aLSU/vRHpb1/X6KK0uoedwzplDXOEYpO8UMbS?=
 =?us-ascii?Q?YKopKRiOQgoV+bJyhABGjl55eSSZ7razi65i7NmCOyUs9VTmAq64t6FfwRP1?=
 =?us-ascii?Q?uh37Qo4Qz8ndwySmDGJ92FZ+DC0biX5up56js1oFUhxagLAt7ojqIUtcs7Di?=
 =?us-ascii?Q?o/9sffBJO77WhHq+WLinsRCXaUZuf/ZLxel3oiVwOBNcXsYoDIbESPdY5p0z?=
 =?us-ascii?Q?c5/2i5/VAqRj/ioizqaGiSMryHR00gG9pR0OPAakPgDWQctHXBufBrdyRvBa?=
 =?us-ascii?Q?Dk6ERCrYJtA9T+reFGBgvmbEfn3UId9gWrIMpYGVcSLsxKBicBtb280A1l38?=
 =?us-ascii?Q?XMlVQ8g3LaJoQ4Q7vZk0JRM/5c75SsDI6KxITckg+kha8PV2QSRNN++n9KRj?=
 =?us-ascii?Q?mWoD+DfPxgMd7VkZoAPz4oPEso5F7IP1s8U0+15B8IVGM3sQuG34LOgwMvY0?=
 =?us-ascii?Q?NVWXly3WxbUlpwqhuabC/cRcteFxe0Dn70FYlTrREbi9uuDgJ9dOu4KrtRhW?=
 =?us-ascii?Q?37gdfllNGLomgdQci/wD/FqYBuvoSXwmcXrHcsqsXHy9hHTDvhjCm7AK1MZb?=
 =?us-ascii?Q?szqQzD5Yxdv+yuLS09cukqqDQPLJ6r0+9yr3KUPlQDL9RcKLPdBL2lZKsxzC?=
 =?us-ascii?Q?Rsm26ctlLsvJQoBxXxELe66Fz0t0ilhxt1FhhLHClP+zb7gitVUztlikafZK?=
 =?us-ascii?Q?m2ofX0mdO0NqRl5DtpzsOJ4AigTJFZm36rSrdvgZK/AdGgb+IJqSfK3Y/HlG?=
 =?us-ascii?Q?pgqUDclRonnWp2aXOuGb1dm7pT1YqS1doXBVmDmBGviEICBIYsS1MBD3j99U?=
 =?us-ascii?Q?VKNIgAncfjw5iYpnJCPR6G+eupUlQE6qbjhOmkMaIHxDIYHkh/jn9L7qvKrR?=
 =?us-ascii?Q?forPyXPku06iTmWL99iI24r1OFoBRPVbluvzdAl0ArlUm2O8btMRy96ane4B?=
 =?us-ascii?Q?i7PAJzzqahgtBijYC5HF4kUx8JpvSEsd7ZARQRfW7V3IwpYvNumywI5jSTVV?=
 =?us-ascii?Q?yJRDRfU+QDjXuC7vZWmsJQMH64LCSQpJJz9DyvPfI7In2ZW+zLIVyiITbPey?=
 =?us-ascii?Q?sE1uXRqqeI79hJPv8vCW3Jf1l/2TzrASYPYUf1roGn521vLsT2V6xQb3mwt4?=
 =?us-ascii?Q?OiueyYjBYtR3V97CCq9rrgIwDXJYPl56mZOB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 15:51:13.5462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0c6fee-88ca-4df0-c505-08ddd437e7ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
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

Increase cache interval time to 50 ms while fetching system
metrics table for smu_v13_0_12 since polling interval is less frequent for
this data.

v2: Make caching interval soc independent, however customization can be
done in soc specific callbacks(Alex/Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c             | 4 ++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h         | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 9 ++++-----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index dc48a1dd8be4..c62d68d7410f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1162,8 +1162,12 @@ static void smu_free_dummy_read_table(struct smu_context *smu)
 
 static int smu_smc_table_sw_init(struct smu_context *smu)
 {
+	struct smu_table_context *smu_table = &smu->smu_table;
 	int ret;
 
+	smu_table->tables[SMU_TABLE_TEMP_METRICS].cache_interval =
+		AMDGPU_TEMP_METRICS_CACHE_INTERVAL;
+
 	/**
 	 * Create smu_table structure, and init smc tables such as
 	 * TABLE_PPTABLE, TABLE_WATERMARKS, TABLE_SMU_METRICS, and etc.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 611b381b9147..7a52c00c700e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -32,6 +32,8 @@
 #include "smu_types.h"
 #include "linux/firmware.h"
 
+#define AMDGPU_TEMP_METRICS_CACHE_INTERVAL	50
+
 #define SMU_THERMAL_MINIMUM_ALERT_TEMP		0
 #define SMU_THERMAL_MAXIMUM_ALERT_TEMP		255
 #define SMU_TEMPERATURE_UNITS_PER_CENTIGRADES	1000
@@ -258,6 +260,7 @@ struct smu_table {
 	struct amdgpu_bo *bo;
 	uint32_t version;
 	unsigned long  metrics_time;
+	uint32_t cache_interval;
 };
 
 enum smu_perf_level_designation {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index fca50f6a8ef6..5ead66375d38 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -361,18 +361,17 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
 	return 0;
 }
 
-static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu, void *metrics_table,
-						 bool bypass_cache)
+static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu, void *metrics_table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
 	struct smu_table *table = &smu_table->driver_table;
 	int ret;
 
-	if (bypass_cache || !smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time ||
+	if (!smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time ||
 	    time_after(jiffies,
 		       smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time +
-		       msecs_to_jiffies(1))) {
+		       msecs_to_jiffies(smu_table->tables[SMU_TABLE_TEMP_METRICS].cache_interval))) {
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetricsTable, NULL);
 		if (ret) {
 			dev_info(smu->adev->dev,
@@ -544,7 +543,7 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
 	else if (type  == SMU_TEMP_METRIC_BASEBOARD)
 		smu_cmn_init_baseboard_temp_metrics(baseboard_temp_metrics, 1, 0);
 
-	ret = smu_v13_0_12_get_system_metrics_table(smu, metrics, false);
+	ret = smu_v13_0_12_get_system_metrics_table(smu, metrics);
 	if (ret) {
 		kfree(metrics);
 		return ret;
-- 
2.46.0

