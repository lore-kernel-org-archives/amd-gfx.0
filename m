Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFEBC87FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6FC110E2B7;
	Mon,  4 Aug 2025 11:06:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rPvtSt1l";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75F3510E1AE
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:06:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmrMvuJbB5ETVASLqIjFEvNv9wk+kjc4IOjbPsCe5l85r9RAVvbJdnhhYrcsoR/6P/vVDSrMOjwwhyfkbs7jf7QkidjG79de7JAG99XmdltldHBzo09alN8KV9K9wJQINpmHN+Zcii1Q9AQx/d6h+LeAcB0G4Fxhm0sm70rtLz9dMSXKbo4sRSmsNpeiU6wPkgxQqFZhGWxYi1OOgha2HKYzK+YLySkZsA6QBYSLdfxHDHa57ulP6pLVxY4mQP2OM0QMEP18UWgxJBcUh4gXkauiQ0e8WMXgbfmZEYDcMdf97wddbGn1uFVXRtDuvHs/gpsuPMqs2o+Vx36nZ4WtfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+GGX/rn5RHZVNO6wpaLM2ytlHtRkTaw2c9sHopzWdg=;
 b=jQnu3u3kXlfXiArgHTGEYBZJbHTy8jNa+50dcGfoXpFyAyaQc8YZy23d5U6nSWUj6UkDK7BzZfPffhxgW6h9WLVepr820DSdN0HvyZCqjEIDIafAXNlg6glS/6QFCBOWx5w9HPzIToHAXs/ID9Bs5tE7ead8exuIbMK5Q38Cx6R6W3/b7zYRZq1Db/TNxLvLcE6Kv7i1t2d1viNJtx6QPRvgmRi2NwVlyUN6RzWlb/4cu0lRIM/2+Hgvncs4n5NPQloCj8TpcQZ9xYwKKzj/OBNGDHxVEG45arcCa5kRaj0Et2Su5SJjkLeT6UinV65CqnVvEvHbQUZ8ZA+N36Cz7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+GGX/rn5RHZVNO6wpaLM2ytlHtRkTaw2c9sHopzWdg=;
 b=rPvtSt1lWkViEYtedqOs00dbs1D2NOyYOBIDTiLZhrQRLNldmHJv3NqI2tCqtLDaZl+ZhwkT28TdLvLPb/h2aLhRwFCC8HSCii44iLwsEYhL3MRkzBpJCmubNuhrf3rJu0H3e6cvAaQmxMH73+8FT/5b9U/i5+cpC3A/xsfw7wA=
Received: from BL1P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::7)
 by CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 11:06:03 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::55) by BL1P221CA0020.outlook.office365.com
 (2603:10b6:208:2c5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 11:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:06:02 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 06:05:59 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <alexander.deucher@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH v2 4/6] drm/amd/pm: Fetch and fill temperature metrics
Date: Mon, 4 Aug 2025 19:05:37 +0800
Message-ID: <20250804110539.637463-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250804110539.637463-1-asad.kamal@amd.com>
References: <20250804110539.637463-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CY5PR12MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbc19cd-7252-4244-0499-08ddd346e6b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qx3BvZIDOy5hKmA9u3ZlUAsPUkOsy8b/ag0HE/NAhW3I67nIAIbKgJiGF7es?=
 =?us-ascii?Q?AkwdPySK2Bg7qCVWdwH40tnVp32P5lVs8qxtlCqXaYWQ7AbqDHYomEoo3Mpu?=
 =?us-ascii?Q?eWZvtf/OzOWIyC0ly84bLX8IARJUoUY8eAsh4T050CiPpHePuNw/XwxnC66a?=
 =?us-ascii?Q?DGFGIMet+daI/TI0T4TPPcuxBjN4d5AwXlov+4zJHlS5jVA/Cyz5yaLtBZJh?=
 =?us-ascii?Q?suGYBuUpAt3Tj5uANSblj3IEUVRaYb4SAMA+aiBkg6KE4OZKRhyc9cuGO14k?=
 =?us-ascii?Q?Aa0UEZFjfFoNudajRqsIkvx6ySTvl897hIJFj+WADekhEoYCA1WDDrRO0bfu?=
 =?us-ascii?Q?kTes+wrFkOWp7p0h4IIOTsc+H9f/5MUuS41887F+2nt+hJiSxwBeOjAG34VV?=
 =?us-ascii?Q?6LDnEJxw0MeQtmN55CLZDERNKMaWOWenWdBxRw0+HlhPXFOKLkj605CREpnT?=
 =?us-ascii?Q?ilgjBdCMQ0mcpPtYye87uX/ZOSoMOzY3AE7KnuhqG/xF/RFO8KfmfvcvXbqv?=
 =?us-ascii?Q?NgDjbGIxwSmi5SPahzBqxnEZTPSWBQLjuXewkfaKszd9/YK4OilrkXrFhhLA?=
 =?us-ascii?Q?KR0RzOOhhdUyxj7wO/8KRrXsX1A2pjq0Z3R5EG1pL5v0gnAHHMlVokGi7B7t?=
 =?us-ascii?Q?qbcESgwZ327If7scnyUz3wrWbXk6MWEiTsDbTa4fNh7FQ6YkcP/08zNUT8Co?=
 =?us-ascii?Q?wpAXLnYoJyJBTtfsyUN7m2SvNnW68Lbb54gJVdWyRSN1GntqjtLkVdptAj7Y?=
 =?us-ascii?Q?3Y3Qg1r8tD6ir1NIyOCEsNEr+i3U67pOGEHdGi0oS8mUA8v/5Iq+xy70P5kH?=
 =?us-ascii?Q?7lD6zZBTIQmGGP9AxQbctPw7tHTDkVfBny6FJjVyyrcZr+az5aV7sIk6/Uk7?=
 =?us-ascii?Q?2o4ovgXxE5dA0mh75qHxCaGWWvzMLoTJxcj5i8i8cIfLzX5P2HO8FRYU0cmV?=
 =?us-ascii?Q?pjCFI15p7B1gdnvzMKO3WAVfaWXLeTrYD8DMtSlaV0RZUnvWgj4X0muXk1JN?=
 =?us-ascii?Q?KPqt9LmJjxbLGR5tb1axFcVTh3qrD6z/fjN/FLu0ir96Tx6KmzQmlcgF3/fu?=
 =?us-ascii?Q?SngCwScj6ECec9CVOU1RYUzqylKae8rFes+3QTNGUOwW23YOPhCTzczdXDTO?=
 =?us-ascii?Q?0rdwgqV8Bz8PHvhsEe8iVPJnImGad3tElVUfeMHB3ExT8Xyv9HcDbah++KpH?=
 =?us-ascii?Q?dZKZTGLXYdRsBK68mzwDLgW35+c7zxZMwW/GpFf/Mm88gwu/oQw5mdPtiNBi?=
 =?us-ascii?Q?UsZ8wvFgnemgNOMQCh7mxHH9xeDbIQ8yt6h9q40iyGci2PRqi7Q9c9Ic7jKM?=
 =?us-ascii?Q?NH+txoSGONlv85b4t2bm9czkmJnNF3f9KpCGj7P5A4OsX7kkWVheD4DEoRYp?=
 =?us-ascii?Q?qv9h/kX9itVjeszoovfOGm07NFKewkhth7N99SRaf3bF/qFv5+CbPwXkajLc?=
 =?us-ascii?Q?ShMF2BFA2MQgTap5/kBQBhCuliVyD4xTXv4NKNZ2I2wTCWjTmJ9zIpS+dSjH?=
 =?us-ascii?Q?8JCNkR2++/TIq5lhrwJ4NkbfXZ6DnjqWmQ87?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:06:02.7287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbc19cd-7252-4244-0499-08ddd346e6b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6201
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

Fetch system metrics table to fill gpuboard/baseboard temperature
metrics data for smu_v13_0_12

v2: Remove unnecessary checks, used separate metrics time for
temperature metrics table(Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   2 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 248 +++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |   6 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |   3 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  26 ++
 7 files changed, 287 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8b015107f761..dc48a1dd8be4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -766,6 +766,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 14):
 	case IP_VERSION(13, 0, 12):
 		smu_v13_0_6_set_ppt_funcs(smu);
+		smu_v13_0_6_set_temp_funcs(smu);
 		/* Enable pp_od_clk_voltage node */
 		smu->od_enabled = true;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index b490c39e313e..611b381b9147 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -257,6 +257,7 @@ struct smu_table {
 	void *cpu_addr;
 	struct amdgpu_bo *bo;
 	uint32_t version;
+	unsigned long  metrics_time;
 };
 
 enum smu_perf_level_designation {
@@ -322,6 +323,7 @@ enum smu_table_id {
 	SMU_TABLE_ECCINFO,
 	SMU_TABLE_COMBO_PPTABLE,
 	SMU_TABLE_WIFIBAND,
+	SMU_TABLE_TEMP_METRICS,
 	SMU_TABLE_COUNT,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index d7a9e41820fa..458c4ac2dfbc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -278,7 +278,8 @@
 	__SMU_DUMMY_MAP(MALLPowerState), \
 	__SMU_DUMMY_MAP(ResetSDMA), \
 	__SMU_DUMMY_MAP(ResetVCN), \
-	__SMU_DUMMY_MAP(GetStaticMetricsTable),
+	__SMU_DUMMY_MAP(GetStaticMetricsTable), \
+	__SMU_DUMMY_MAP(GetSystemMetricsTable),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 02a455a31c25..d0dd84670361 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -138,6 +138,7 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlingPolicy,             0),
 	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
 	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           1),
+	MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMetricsTable,           0),
 };
 
 static int smu_v13_0_12_get_enabled_mask(struct smu_context *smu,
@@ -184,7 +185,8 @@ static int smu_v13_0_12_fru_get_product_info(struct smu_context *smu,
 
 int smu_v13_0_12_get_max_metrics_size(void)
 {
-	return max(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t));
+	return max3(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t),
+		   sizeof(SystemMetricsTable_t));
 }
 
 static void smu_v13_0_12_init_xgmi_data(struct smu_context *smu,
@@ -359,6 +361,245 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
 	return 0;
 }
 
+static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu, void *metrics_table,
+						 bool bypass_cache)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
+	struct smu_table *table = &smu_table->driver_table;
+	int ret;
+
+	if (bypass_cache || !smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time ||
+	    time_after(jiffies,
+		       smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time +
+		       msecs_to_jiffies(1))) {
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetricsTable, NULL);
+		if (ret) {
+			dev_info(smu->adev->dev,
+				 "Failed to export system metrics table!\n");
+			return ret;
+		}
+
+		amdgpu_asic_invalidate_hdp(smu->adev, NULL);
+		memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
+
+		smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time = jiffies;
+	}
+
+	if (metrics_table)
+		memcpy(metrics_table, smu_table->metrics_table, sizeof(SystemMetricsTable_t));
+
+	return 0;
+}
+
+static enum amdgpu_node_temp smu_v13_0_12_get_node_sensor_type(NODE_TEMP_e type)
+{
+	switch (type) {
+	case NODE_TEMP_RETIMER:
+		return AMDGPU_RETIMER_X_TEMP;
+	case NODE_TEMP_IBC_TEMP:
+		return AMDGPU_OAM_X_IBC_TEMP;
+	case NODE_TEMP_IBC_2_TEMP:
+		return AMDGPU_OAM_X_IBC_2_TEMP;
+	case NODE_TEMP_VDD18_VR_TEMP:
+		return AMDGPU_OAM_X_VDD18_VR_TEMP;
+	case NODE_TEMP_04_HBM_B_VR_TEMP:
+		return AMDGPU_OAM_X_04_HBM_B_VR_TEMP;
+	case NODE_TEMP_04_HBM_D_VR_TEMP:
+		return AMDGPU_OAM_X_04_HBM_D_VR_TEMP;
+	default:
+		return -EINVAL;
+	}
+}
+
+static enum amdgpu_vr_temp smu_v13_0_12_get_vr_sensor_type(SVI_TEMP_e type)
+{
+	switch (type) {
+	case SVI_VDDCR_VDD0_TEMP:
+		return AMDGPU_VDDCR_VDD0_TEMP;
+	case SVI_VDDCR_VDD1_TEMP:
+		return AMDGPU_VDDCR_VDD1_TEMP;
+	case SVI_VDDCR_VDD2_TEMP:
+		return AMDGPU_VDDCR_VDD2_TEMP;
+	case SVI_VDDCR_VDD3_TEMP:
+		return AMDGPU_VDDCR_VDD3_TEMP;
+	case SVI_VDDCR_SOC_A_TEMP:
+		return AMDGPU_VDDCR_SOC_A_TEMP;
+	case SVI_VDDCR_SOC_C_TEMP:
+		return AMDGPU_VDDCR_SOC_C_TEMP;
+	case SVI_VDDCR_SOCIO_A_TEMP:
+		return AMDGPU_VDDCR_SOCIO_A_TEMP;
+	case SVI_VDDCR_SOCIO_C_TEMP:
+		return AMDGPU_VDDCR_SOCIO_C_TEMP;
+	case SVI_VDD_085_HBM_TEMP:
+		return AMDGPU_VDD_085_HBM_TEMP;
+	case SVI_VDDCR_11_HBM_B_TEMP:
+		return AMDGPU_VDDCR_11_HBM_B_TEMP;
+	case SVI_VDDCR_11_HBM_D_TEMP:
+		return AMDGPU_VDDCR_11_HBM_D_TEMP;
+	case SVI_VDD_USR_TEMP:
+		return AMDGPU_VDD_USR_TEMP;
+	case SVI_VDDIO_11_E32_TEMP:
+		return AMDGPU_VDDIO_11_E32_TEMP;
+	default:
+		return -EINVAL;
+	}
+}
+
+static enum amdgpu_system_temp smu_v13_0_12_get_system_sensor_type(SYSTEM_TEMP_e type)
+{
+	switch (type) {
+	case SYSTEM_TEMP_UBB_FPGA:
+		return AMDGPU_UBB_FPGA_TEMP;
+	case SYSTEM_TEMP_UBB_FRONT:
+		return AMDGPU_UBB_FRONT_TEMP;
+	case SYSTEM_TEMP_UBB_BACK:
+		return AMDGPU_UBB_BACK_TEMP;
+	case SYSTEM_TEMP_UBB_OAM7:
+		return AMDGPU_UBB_OAM7_TEMP;
+	case SYSTEM_TEMP_UBB_IBC:
+		return AMDGPU_UBB_IBC_TEMP;
+	case SYSTEM_TEMP_UBB_UFPGA:
+		return AMDGPU_UBB_UFPGA_TEMP;
+	case SYSTEM_TEMP_UBB_OAM1:
+		return AMDGPU_UBB_OAM1_TEMP;
+	case SYSTEM_TEMP_OAM_0_1_HSC:
+		return AMDGPU_OAM_0_1_HSC_TEMP;
+	case SYSTEM_TEMP_OAM_2_3_HSC:
+		return AMDGPU_OAM_2_3_HSC_TEMP;
+	case SYSTEM_TEMP_OAM_4_5_HSC:
+		return AMDGPU_OAM_4_5_HSC_TEMP;
+	case SYSTEM_TEMP_OAM_6_7_HSC:
+		return AMDGPU_OAM_6_7_HSC_TEMP;
+	case SYSTEM_TEMP_UBB_FPGA_0V72_VR:
+		return AMDGPU_UBB_FPGA_0V72_VR_TEMP;
+	case SYSTEM_TEMP_UBB_FPGA_3V3_VR:
+		return AMDGPU_UBB_FPGA_3V3_VR_TEMP;
+	case SYSTEM_TEMP_RETIMER_0_1_2_3_1V2_VR:
+		return AMDGPU_RETIMER_0_1_2_3_1V2_VR_TEMP;
+	case SYSTEM_TEMP_RETIMER_4_5_6_7_1V2_VR:
+		return AMDGPU_RETIMER_4_5_6_7_1V2_VR_TEMP;
+	case SYSTEM_TEMP_RETIMER_0_1_0V9_VR:
+		return AMDGPU_RETIMER_0_1_0V9_VR_TEMP;
+	case SYSTEM_TEMP_RETIMER_4_5_0V9_VR:
+		return AMDGPU_RETIMER_4_5_0V9_VR_TEMP;
+	case SYSTEM_TEMP_RETIMER_2_3_0V9_VR:
+		return AMDGPU_RETIMER_2_3_0V9_VR_TEMP;
+	case SYSTEM_TEMP_RETIMER_6_7_0V9_VR:
+		return AMDGPU_RETIMER_6_7_0V9_VR_TEMP;
+	case SYSTEM_TEMP_OAM_0_1_2_3_3V3_VR:
+		return AMDGPU_OAM_0_1_2_3_3V3_VR_TEMP;
+	case SYSTEM_TEMP_OAM_4_5_6_7_3V3_VR:
+		return AMDGPU_OAM_4_5_6_7_3V3_VR_TEMP;
+	case SYSTEM_TEMP_IBC_HSC:
+		return AMDGPU_IBC_HSC_TEMP;
+	case SYSTEM_TEMP_IBC:
+		return AMDGPU_IBC_TEMP;
+	default:
+		return -EINVAL;
+	}
+}
+
+static bool smu_v13_0_12_is_temp_metrics_supported(struct smu_context *smu,
+						   enum smu_temp_metric_type type)
+{
+	switch (type) {
+	case SMU_TEMP_METRIC_BASEBOARD:
+		if (smu->adev->gmc.xgmi.physical_node_id == 0 &&
+		    smu->adev->gmc.xgmi.num_physical_nodes > 1 &&
+		    smu_v13_0_6_cap_supported(smu, SMU_CAP(TEMP_METRICS)))
+			return true;
+		break;
+	case SMU_TEMP_METRIC_GPUBOARD:
+		return smu_v13_0_6_cap_supported(smu, SMU_CAP(TEMP_METRICS));
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
+					     enum smu_temp_metric_type type, void *table)
+{
+	struct amdgpu_gpuboard_temp_metrics_v1_0 *gpuboard_temp_metrics;
+	struct amdgpu_baseboard_temp_metrics_v1_0 *baseboard_temp_metrics;
+	SystemMetricsTable_t *metrics;
+	u32 idx, sensors;
+	int ret, sensor_type;
+	ssize_t size = 0;
+
+	size = (type == SMU_TEMP_METRIC_GPUBOARD) ?
+		sizeof(*gpuboard_temp_metrics) : sizeof(*baseboard_temp_metrics);
+
+	if (!table)
+		goto out;
+	metrics = kzalloc(sizeof(SystemMetricsTable_t), GFP_KERNEL);
+	if (!metrics)
+		return -ENOMEM;
+	gpuboard_temp_metrics = (struct amdgpu_gpuboard_temp_metrics_v1_0 *)table;
+	baseboard_temp_metrics = (struct amdgpu_baseboard_temp_metrics_v1_0 *)table;
+	if (type  == SMU_TEMP_METRIC_GPUBOARD)
+		smu_cmn_init_gpuboard_temp_metrics(gpuboard_temp_metrics, 1, 0);
+	else if (type  == SMU_TEMP_METRIC_BASEBOARD)
+		smu_cmn_init_baseboard_temp_metrics(baseboard_temp_metrics, 1, 0);
+
+	ret = smu_v13_0_12_get_system_metrics_table(smu, metrics, true);
+	if (ret) {
+		kfree(metrics);
+		return ret;
+	}
+
+	if (type == SMU_TEMP_METRIC_GPUBOARD) {
+		gpuboard_temp_metrics->accumulation_counter = metrics->AccumulationCounter;
+		gpuboard_temp_metrics->label_version = metrics->LabelVersion;
+		gpuboard_temp_metrics->node_id = metrics->NodeIdentifier;
+
+		idx = 0;
+		for (sensors = 0; sensors < NODE_TEMP_MAX_TEMP_ENTRIES; sensors++) {
+			if (metrics->NodeTemperatures[sensors] != -1) {
+				sensor_type = smu_v13_0_12_get_node_sensor_type(sensors);
+				gpuboard_temp_metrics->node_temp[idx] =
+					((int)metrics->NodeTemperatures[sensors])  & 0xFFFFFF;
+				gpuboard_temp_metrics->node_temp[idx] |= (sensor_type << 24);
+				idx++;
+			}
+		}
+
+		idx = 0;
+
+		for (sensors = 0; sensors < SVI_MAX_TEMP_ENTRIES; sensors++) {
+			if (metrics->VrTemperatures[sensors] != -1) {
+				sensor_type = smu_v13_0_12_get_vr_sensor_type(sensors);
+				gpuboard_temp_metrics->vr_temp[idx] =
+					((int)metrics->VrTemperatures[sensors])  & 0xFFFFFF;
+				gpuboard_temp_metrics->vr_temp[idx] |= (sensor_type << 24);
+				idx++;
+			}
+		}
+	} else if (type == SMU_TEMP_METRIC_BASEBOARD) {
+		baseboard_temp_metrics->accumulation_counter = metrics->AccumulationCounter;
+		baseboard_temp_metrics->label_version = metrics->LabelVersion;
+		baseboard_temp_metrics->node_id = metrics->NodeIdentifier;
+
+		idx = 0;
+		for (sensors = 0; sensors < SYSTEM_TEMP_MAX_ENTRIES; sensors++) {
+			if (metrics->SystemTemperatures[sensors] != -1) {
+				sensor_type = smu_v13_0_12_get_system_sensor_type(sensors);
+				baseboard_temp_metrics->system_temp[idx] =
+					((int)metrics->SystemTemperatures[sensors])  & 0xFFFFFF;
+				baseboard_temp_metrics->system_temp[idx] |= (sensor_type << 24);
+				idx++;
+			}
+		}
+	}
+
+	kfree(metrics);
+
+out:
+	return size;
+}
+
 ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu, struct amdgpu_xcp *xcp, void *table, void *smu_metrics)
 {
 	const u8 num_jpeg_rings = NUM_JPEG_RINGS_FW;
@@ -572,3 +813,8 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table, void
 
 	return sizeof(*gpu_metrics);
 }
+
+const struct smu_temp_funcs smu_v13_0_12_temp_funcs = {
+	.temp_metrics_is_supported = smu_v13_0_12_is_temp_metrics_supported,
+	.get_temp_metrics = smu_v13_0_12_get_temp_metrics,
+};
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9cc294f4708b..c777c0e4ea11 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3857,3 +3857,9 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
 	amdgpu_mca_smu_init_funcs(smu->adev, &smu_v13_0_6_mca_smu_funcs);
 	amdgpu_aca_set_smu_funcs(smu->adev, &smu_v13_0_6_aca_smu_funcs);
 }
+
+void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)
+{
+	smu->smu_temp.temp_funcs = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
+			== IP_VERSION(13, 0, 12)) ? &smu_v13_0_12_temp_funcs : NULL;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 67b30674fd31..ece04ad724fb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -68,10 +68,12 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(HST_LIMIT_METRICS),
 	SMU_CAP(BOARD_VOLTAGE),
 	SMU_CAP(PLDM_VERSION),
+	SMU_CAP(TEMP_METRICS),
 	SMU_CAP(ALL),
 };
 
 extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
+extern void smu_v13_0_6_set_temp_funcs(struct smu_context *smu);
 bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_0_6_caps cap);
 int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu);
 int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_table,
@@ -88,4 +90,5 @@ ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu,
 				     void *smu_metrics);
 extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
 extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
+extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index a608cdbdada4..d588f74b98de 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -65,6 +65,32 @@
 		header->structure_size = sizeof(*tmp);                     \
 	} while (0)
 
+#define smu_cmn_init_baseboard_temp_metrics(ptr, fr, cr)                        \
+	do {                                                                    \
+		typecheck(struct amdgpu_baseboard_temp_metrics_v##fr##_##cr *,  \
+			  (ptr));                                               \
+		struct amdgpu_baseboard_temp_metrics_v##fr##_##cr *tmp = (ptr); \
+		struct metrics_table_header *header =                           \
+			(struct metrics_table_header *)tmp;                     \
+		memset(header, 0xFF, sizeof(*tmp));                             \
+		header->format_revision = fr;                                   \
+		header->content_revision = cr;                                  \
+		header->structure_size = sizeof(*tmp);                          \
+	} while (0)
+
+#define smu_cmn_init_gpuboard_temp_metrics(ptr, fr, cr)                         \
+	do {                                                                    \
+		typecheck(struct amdgpu_gpuboard_temp_metrics_v##fr##_##cr *,   \
+			  (ptr));                                               \
+		struct amdgpu_gpuboard_temp_metrics_v##fr##_##cr *tmp = (ptr);  \
+		struct metrics_table_header *header =                           \
+			(struct metrics_table_header *)tmp;                     \
+		memset(header, 0xFF, sizeof(*tmp));                             \
+		header->format_revision = fr;                                   \
+		header->content_revision = cr;                                  \
+		header->structure_size = sizeof(*tmp);                          \
+	} while (0)
+
 extern const int link_speed[];
 
 /* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */
-- 
2.46.0

