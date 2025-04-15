Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0647C369AB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 14:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F2A310E7B0;
	Tue, 15 Apr 2025 14:35:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AANtxAv8";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EE1610E7A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epLY2saio0RuXU6XGPcComNm31pnBKf2SCjoTIimtfi7pkAtfuUXTPNSSNvDKJy8bsN1A6J13lRI+Yv/9HnJ9XbhF+Yz60rLZeGK4ZqP/wwygjcRTIoGik3q6UNCrwhJMbJyrAWLIPILeSl4P3zbCWVMaCK/GWN5VDXZLwudf2g05aY3cQU6pqcobDSgGm04iZLOopkNwS7zq4Obxt+MohnpBKudSjF6w4ttFcyKaDk6N5IwmtoFnIiJNz5k7uN0FbG8n27+as0+lBLhCAPgoX2xXhBAyZZJmeOh53V2fe5NdA+B6ENv4TieUeZOpv0XNk9PEuRQjg2duTuLnO6Svw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAOsWNGvlw+b0aaMjx7W6xFHByldyPi8hNmh5462IBw=;
 b=yhtX5bc6IG6Tc81gkygHHn6lVRO8SLPzHveZW3azNccs6ERaoyA26l7y23YeOR0bzpld3HjdQg7xySvQhfaqA+eiIp5XdV0vFxs0JHhyYsIpsWS2DpROm9DVcRqj+HJH4j2hKr5v2+4f1+EdzRcXe1RIhBg1vZzl5iV+YaPqeQtSZzel4n88Ep9TNej4/ab4xDWakmI/sZW8jRY12OhIvEB+71SWCPqrkqXY/7beObVWwhIZwa14T+s9WFwhfMQ5JRPPBtRu2LEXDsSK4U8ugiARSBQFK1zLit8Nw5XfzZqIScHgFYygAOY2uLN3s7+Y8JOKqwFVeV0nMjvQ2Aw7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAOsWNGvlw+b0aaMjx7W6xFHByldyPi8hNmh5462IBw=;
 b=AANtxAv8GctJrm/3NIMe6Qk32Xhc439AO7x7zWUZZuXckc/3p+VEju03NDKpt4QbfPTEnO+akJF1nquy3/db2WhSlk82tkCM+AWPktlFakh0IW9KUobSOY0+31qVRgMu/rlXNztEoxPLlFsTKC8U1MLopWrnPciea66MrgJiY4s=
Received: from SJ0PR13CA0019.namprd13.prod.outlook.com (2603:10b6:a03:2c0::24)
 by DM4PR12MB6208.namprd12.prod.outlook.com (2603:10b6:8:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 14:35:49 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::7c) by SJ0PR13CA0019.outlook.office365.com
 (2603:10b6:a03:2c0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12 via Frontend Transport; Tue,
 15 Apr 2025 14:35:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:35:49 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:35:45 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 3/7] drm/amd/pn: Fetch static metrics table
Date: Tue, 15 Apr 2025 22:35:17 +0800
Message-ID: <20250415143521.367895-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250415143521.367895-1-asad.kamal@amd.com>
References: <20250415143521.367895-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|DM4PR12MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: cedd658e-3bc2-4655-087e-08dd7c2ad0ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NNE7wQ+vVZZjI1+HcAUr0BweCixNXUJav7zOzOfZ/C0MUFEEREvB4Y2CyySy?=
 =?us-ascii?Q?3afytJFD/8GkWYjkm2YDydIgvHpjP5/AUUpqWpbTb9Xf6+WqDWMcmMeocGsP?=
 =?us-ascii?Q?mwKhWi0xvmaA3XoFV50p+QcVBTDRop9/qI7QpBpd/CqyCgpLhLbdjAg9Bp3P?=
 =?us-ascii?Q?zheCfe/DNp793RsobpSUGVi3l0CZfrvmz2XBr0BW6KfeYov3Zz5X4VyubF+e?=
 =?us-ascii?Q?/hFVQaB0bbTthyT2Er5996N5xQNXmEXBQuUEUAP7y+5zwmsq/Al5xEAcmFZ6?=
 =?us-ascii?Q?Wmt0NmC2PBcu9JCBjQGFn7jEe6eOvjAJB+9OmSFstAmTSRwwbjJGYBay3t6w?=
 =?us-ascii?Q?vEkRSespnNJhBWs10gbrruu9CoUmgbNjxnh4kqKCP8Gqw1b174ReiczP/fCA?=
 =?us-ascii?Q?p7lZlYtpLsA3gcMDk7wpRpOHvWykMhxr7H5zaeboV/qmlFXppNo+7fnfyvMC?=
 =?us-ascii?Q?j5gfZ52sXILjmwUzXHOm/+1gzjBmSO14ahKeloTvRq6OxtHbYsS6FvVD+fd5?=
 =?us-ascii?Q?nAp8JhfLToc6oxYjdeTde5gjgG+ORFFNV9orgmuA35ZM2mi12RiMRKz17ur9?=
 =?us-ascii?Q?i8y1zf/sg9Rb/BNbDjrtUqUONDFpwdWjAoDUBq21qcmE1fqFjXAoF5H+n0Hd?=
 =?us-ascii?Q?0fn0s6BvQS8yCaPV0bzxCDbuIOjIuG32ZBU5nk8dc05iAkU4UrDuDT3jUeEc?=
 =?us-ascii?Q?0ECq/OhdHL4QyniHUSrd3Jlh5HJXN9nnvmxW+NgblqpUx+kSURToFuMqmbMD?=
 =?us-ascii?Q?Eo2vgWB7L6k6kJiwsad6dJELpBXDboa1SclceUa/98EWZ7Bqc9kL8B75VxF6?=
 =?us-ascii?Q?Zq2n5QEWCjbWb6DEUfuWUgV2sj6pM9bad+GPvbBekAdpt0k2gvNpJTwx4JmP?=
 =?us-ascii?Q?heBspXLU04MEhA5zYyS12bYaCUcbFZUaBUpo8Ic9DDhaamrBs9f1LNh+wiEm?=
 =?us-ascii?Q?XGxls6aX6rqcvovtjt4+fZb5svoli8N+00RyPoUYVX9UDgEAlXV2Xt/KmBHJ?=
 =?us-ascii?Q?+sECosnEmhcsSUwgU+sD6Q28IwRdIuP8t48DsCO5efysM21OwJAiWgbFD7MA?=
 =?us-ascii?Q?3olI+arQNOVml9zhoAwWt4ula9B0aMVW85zmzw0Ay9gOn7voqYESsws2YpQ1?=
 =?us-ascii?Q?2FClfv3sUDet4mxy4y34zOAzppsHZXe7xY9yN714cqvmhP8BnYvwCgefFxah?=
 =?us-ascii?Q?qp+cake2XfdOZl1iN8OuBVBcKvOYAnA8bpVAAsKWY818R1O0V4Yqu7v4QkjC?=
 =?us-ascii?Q?NLlRsD6dpcWGUtqGStlmGlsxdGFdcChqDc09lKPCI3TrEiwcm/AlL/H1zABa?=
 =?us-ascii?Q?HdJjo9Ue+sZab995//2PvqPipPWNFjpaLcIPBgf6dVOf2d1n7bKEySGu+xbj?=
 =?us-ascii?Q?6fZTnrdskCSMVEu5AKcCaTGpTSH864AHUYYp7kvwlZKUHkmvIW1eG2SCpuXF?=
 =?us-ascii?Q?ovKu4UqnrBzZ/WGXHkbPp1CzHC8+jXCwSorQ7fgBfpdtwHG2RYZB4w8dZoci?=
 =?us-ascii?Q?YYzD25Yx3O06D9Sty6p+jmz9L40LIra7B3FJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:35:49.0868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cedd658e-3bc2-4655-087e-08dd7c2ad0ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6208
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

Fetch static metrics table for smu_v13_0_6

v2: Add static metrics caps check to fetch static metrics table

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 177c55f457f4..94fa31fc5eba 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -177,6 +177,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlingPolicy,             0),
 	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
 	MSG_MAP(ResetVCN,                            PPSMC_MSG_ResetVCN,                       0),
+	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           0),
 };
 
 // clang-format on
@@ -391,6 +392,8 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 		if ((pgm == 7 && fw_ver >= 0x7550E00) ||
 		    (pgm == 0 && fw_ver >= 0x00557E00))
 			smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
+		if (fw_ver >= 0x00557E00)
+			smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));
 	}
 	if (((pgm == 7) && (fw_ver >= 0x7550700)) ||
 	    ((pgm == 0) && (fw_ver >= 0x00557900)) ||
@@ -736,6 +739,26 @@ static ssize_t smu_v13_0_6_get_pm_metrics(struct smu_context *smu,
 	return pm_metrics->common_header.structure_size;
 }
 
+static int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
+	struct smu_table *table = &smu_table->driver_table;
+	int ret;
+
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetStaticMetricsTable, NULL);
+	if (ret) {
+		dev_info(smu->adev->dev,
+				"Failed to export static metrics table!\n");
+		return ret;
+	}
+
+	amdgpu_asic_invalidate_hdp(smu->adev, NULL);
+	memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
+
+	return 0;
+}
+
 static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -803,6 +826,11 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 			GET_METRIC_FIELD(PublicSerialNumber_AID, version)[0];
 
 		pptable->Init = true;
+		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS))) {
+			ret = smu_v13_0_6_get_static_metrics_table(smu);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return 0;
-- 
2.46.0

