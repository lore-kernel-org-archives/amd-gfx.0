Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CA3C3ABA1
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 11:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E351210E70D;
	Thu, 24 Apr 2025 11:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NjA/iNX6";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF4E310E70D
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 11:39:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lmm4yrsdZXZBIeDcT4Zuecx3D5FGx8oG9CCq6lfUSPOrjqsrbBa2xoofe9ujdluzDtwxzZyc87/jbO7hcsqwVWrKNG9IIcce+1DW8U+ZVoed6AKiLRkkLC33dIYxsq76ACpQxqS5skKFt20fNywH0TvIYAFluIFCrydV4YJ+tf5jxbfj1S6Uv/5M6i0sBHYVsHhXlVABGr247YpOmcNBcbjqYLr2kdbJzoPo+CTpZvJh05n8YVpoJpIKyC3D6NnnsLlLToX0jf0XSTQsN6hxm3NPhMf2D0A1V++/EfpIFDl1JwRByda9GqCNcaxpuKTLiZV1HTGX3zxkKTJD3vbLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIBnNGKmxyf/yK3yOFaMHyR7lgVyd+M2uXmVQxgjUN8=;
 b=rUvigZiPMBhh6VY9wrNrhuUpk/ujpl6H92JoBsssg5/sYWdB9yUkLqVNA1N1AjAoeiYFNi1LXqWuh9psOxNsc+V3x5gG251BPOh74Rq586E/8D4PiqulAfKsIV3qcCNqmuwJm8r0uldmXcXEo8dHznizcq7ptginuOUYG74uwmDHlatEKl4EK9nEvzzegOy9Y7bkA0OvnPtgJE3tRXlr70pOyZ0bTE8qvjSMxIfTprkWjQjHBDR1yAKetka4X8P46L+YM1W6t1xdsgIofTs+bBlw7PY1tT8knx3Y71IBhO9e2hTEeR4PqAznY0u7ukTe5oXJPqQKVRnXOp5lKNGt7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIBnNGKmxyf/yK3yOFaMHyR7lgVyd+M2uXmVQxgjUN8=;
 b=NjA/iNX6V+9LyJWQHWFIIgsRGg+XKjT7sVTo9JNnKs3x+VUgFJZEcFHQy4gesIkOXwN+hVidkAvdDiexKbBdeUtumMg3SwAnH9cNsHdYACb/lJCSiQhgW6TrDBohib/H9oUPRjjzPo1iPRFRLSzGw/JOE0X/LCwa3ZZEQ+B2Xzk=
Received: from MN2PR15CA0053.namprd15.prod.outlook.com (2603:10b6:208:237::22)
 by DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 11:39:55 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::d) by MN2PR15CA0053.outlook.office365.com
 (2603:10b6:208:237::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Thu,
 24 Apr 2025 11:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 11:39:55 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 06:39:52 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.co>
Subject: [PATCH v3 4/7] drm/amd/pm: Use common function to fetch static
 metrics table
Date: Thu, 24 Apr 2025 19:39:27 +0800
Message-ID: <20250424113930.464303-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250424113930.464303-1-asad.kamal@amd.com>
References: <20250424113930.464303-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ee40d0-69fe-447b-1574-08dd8324bc4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mx0TrSTqXGFkdBOmSGZTmDYhkELULDWQQ7vXBJG1q0SxHYISMDU8QVYb7Gji?=
 =?us-ascii?Q?x3eA86vJq1Xa3haFC0OQfZ4i6him2HDHcLrTvjdZRHJ7NlLMf2+OTLXI4/Sv?=
 =?us-ascii?Q?nZdLFyT1hED84/2yAZbzqqmN3iaAjJ8pFn913AhJmcTaixvMcqz3sWBdJkMp?=
 =?us-ascii?Q?QQTKnXdziRZM0yQzFsEzxGrr9dKtvhVxbMyY7tB0Wjwac7TDIjeDgeFCJ+aT?=
 =?us-ascii?Q?CnVqsYlScb+z3mOk3q9aeDZU+3nSX4OgOdcQAEkHye8uCabNW5tFQgjjTbqt?=
 =?us-ascii?Q?1Us0CdIXgeheswqIZcbDRtGGFJb+jo5bvEDpdEYs48PRS4N/ry1vTpr38LWt?=
 =?us-ascii?Q?47iZcXYgly6fIG5zL9IbxGjO5npK2OohTrYcWeSnRwPl5hNQlHl1HRTV5kO1?=
 =?us-ascii?Q?+ZWQmW8Evz1PkTfkgjyluWESTGhggSEyFv8eQTgfCulBxbL9vmRMrrElclyZ?=
 =?us-ascii?Q?mr+hufTxV8pPTP8052esEXVv0DoEFIz/Dl6So45/BT5yoaAK+pynUBOm0dYE?=
 =?us-ascii?Q?TuxDe4yNfDuojQUJnL3O2R8o+kdU3TLpmW38T9O7QltuMaQ+Wty7S477eyrR?=
 =?us-ascii?Q?iRS3lL453q7ZTOh1BcLkAVUfg1u4++4yTUukatz9DyPq11L9W5w0JjSn6Zxl?=
 =?us-ascii?Q?F65ipxevUUeOrMBVxlbM1+yt5Vu0qQG3FCfs6lgPPQjwcjMElh40+bTFQ1S6?=
 =?us-ascii?Q?1WIahmCLZRD7B9GewAGBzxYt9pMv2av3ejadJX9a6EVbXDItu/TY2GDzGXZa?=
 =?us-ascii?Q?eostbwxOWkxQkLNNqYyIMbeSzQg7p9NVm916bWfpXzctUi7Fhce80Wwu651j?=
 =?us-ascii?Q?MMRhwLDP+v2HshPbhlHhZDlWMrnQrCYuLC02PcBh2ZzQOI22obHVy/spbjQN?=
 =?us-ascii?Q?CvGSp7+GG20LUACnY+ZE6NQElJfDirT0KYeuFzoOm9iXBPUZvpfdGZiBWJhA?=
 =?us-ascii?Q?VogDBF9WpDo9K1OQe3ljlae7aHCoQUCGtM3ToJg/UMoi2+6Gaz3MiPtKr171?=
 =?us-ascii?Q?/WgFT9GKoMW5kFMQY3AURI2qoN5bsJHrL+5Aw+hCUqT8TJMuWutXD/wb6ESO?=
 =?us-ascii?Q?z7FEKAkx959I96TcfIVjCj0KDETzoXM6chiYy+nZNYxX2qUzZYdbz/qa2Hi1?=
 =?us-ascii?Q?esI7ONUoYN9WfOXAEKqPOwgze+NT4Lkp1qTjGixveeyP9WAzl6v7JH+fP9m0?=
 =?us-ascii?Q?ArRPhPvhOeo+4z1EFwOwJ+vYriJNQLuiCxwm37rZ8ahoKdE9IG7t/1SgSmyZ?=
 =?us-ascii?Q?L2uIXsrivP3Y87WGEMMuyCk8BHfntBoBv8SUHqAw14TLOWrXLtWxjL6yXh4W?=
 =?us-ascii?Q?oXUYWwcKqqPjarx449Vc4w1XsB7JgeH5vjYOoS+DFrCO0IF9MJba/Ot+r8yx?=
 =?us-ascii?Q?vTHY1Sp+eucPWxHTZ6OdOU6i3TVRiNCrz3K44pz7lgBwzJ8LZq/2pVrsA00i?=
 =?us-ascii?Q?g+XoV5hx8gyYo5kwPQvmrU9oA5i0QiGGseTxCvmyxF4N5auyYuEr5SmbbpC0?=
 =?us-ascii?Q?5I3jZ8tOTtShtBqDz12lBq4oFUf8F1Xkq2ju?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 11:39:55.7382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ee40d0-69fe-447b-1574-08dd8324bc4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559
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

Use common function to fetch static metrics table for smu_v13_0_12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 22 +------------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |  1 +
 3 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 5d4437e413cc..533d58e57d05 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -187,26 +187,6 @@ int smu_v13_0_12_get_max_metrics_size(void)
 	return max(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t));
 }
 
-static int smu_v13_0_12_get_static_metrics_table(struct smu_context *smu)
-{
-	struct smu_table_context *smu_table = &smu->smu_table;
-	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
-	struct smu_table *table = &smu_table->driver_table;
-	int ret;
-
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetStaticMetricsTable, NULL);
-	if (ret) {
-		dev_info(smu->adev->dev,
-			 "Failed to export static metrics table!\n");
-		return ret;
-	}
-
-	amdgpu_asic_invalidate_hdp(smu->adev, NULL);
-	memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
-
-	return 0;
-}
-
 int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -217,7 +197,7 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 	int ret, i;
 
 	if (!pptable->Init) {
-		ret = smu_v13_0_12_get_static_metrics_table(smu);
+		ret = smu_v13_0_6_get_static_metrics_table(smu);
 		if (ret)
 			return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 1a16b92c97c1..b4bea0881ac9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -739,7 +739,7 @@ static ssize_t smu_v13_0_6_get_pm_metrics(struct smu_context *smu,
 	return pm_metrics->common_header.structure_size;
 }
 
-static int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
+int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 2a8f42dbd9f5..c7a07aa5ef14 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -71,5 +71,6 @@ enum smu_v13_0_6_caps {
 
 extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
 bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_0_6_caps cap);
+int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu);
 
 #endif
-- 
2.46.0

