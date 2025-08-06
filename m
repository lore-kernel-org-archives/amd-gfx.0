Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466A6C87FD3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 11:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 955DC10E3DB;
	Wed,  6 Aug 2025 11:22:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cgVIzpkk";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48E5810E3DB
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 11:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rX0PBuAYDQgcgvNNekRmNk8JB7Ngam0Vi0AJA4WhDEHk6dvzgMV0AdNjH0G3zM2AH+3LoHiDWpk5rnuTHhiUnTUuWQOxydiGLHJ+7rEb1V5iBmAxmxopIDJRAFKKHonikxMtAUqXhDczgaHo7xT+yIY93EaM/81Kxv6AXLON+Kjb2tfMYVU++jftvo97XfovAXqnaXx7qpcatS0aLFXcz0qiR8jR3PnS+9XzZGv42+UlQDe+oQiqCBRZKphquOWwAdCXe0kUH9BLxB/usHH8oWjoyBn+U4U75YI7jhs8w3iFzX0xGvB5I31yHJB1TGq7Mq7fwxotOGtTZjrXOiFiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwMNijK6a2aspFP4m9msYZqxej0smlDXnT4o5rdpZlg=;
 b=y/jNmt54B9joFJp4kHCEFbuX1v/NTLxM14Vq9SHnm/w5Uw7bhJXfYVy0+7eQFaZ/bAnJM+SrOfAumMj2eIdVHJSYMzNmf51HIFL9Kesk13tE8ZA8Vg+F+dMUW+TWRN+1RKWjUT6pav//cZZ1B1bfoM6CTvfntKIcoYyd5sMl4MqL13GeFHNGiGhKUQ0i1GEK5H+WYNJ3VsMAaJhw9LAD9nKlQhj97Eb5GGsWe0mIhEgHMKasxwX/AvrRhLmpS+TZ7X1UH0AasGhcUHw8vyniUk0UipaszhdwwMVSHAIdfqfmnbRAEGQw5zsTY6RqM7AobKesb6VWa4ZOX/TjbRz8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwMNijK6a2aspFP4m9msYZqxej0smlDXnT4o5rdpZlg=;
 b=cgVIzpkkib/AUxZYWt0X3w7wVmDah0TyiFzkkKKSkH0cu/2bTLnPIggqHYe93LAavDXhDJ7l8eqq7f5V+bbmUMaAqaz/Ec0dQfW9l1pgg0wWviCe95G3jAI3r1C1GyVx89dqvEa0qU94eAYqta3r3yL4DIQPd+exlEYRayqfeyI=
Received: from CH0PR08CA0002.namprd08.prod.outlook.com (2603:10b6:610:33::7)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 11:22:37 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::bc) by CH0PR08CA0002.outlook.office365.com
 (2603:10b6:610:33::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 11:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 11:22:36 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Aug
 2025 06:22:34 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: Add caching to SMUv13.0.12 temp metric
Date: Wed, 6 Aug 2025 16:51:56 +0530
Message-ID: <20250806112214.1804907-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250806112214.1804907-1-lijo.lazar@amd.com>
References: <20250806112214.1804907-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: fba14069-e415-400c-75a9-08ddd4db8bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ynUC09QWG4Q51QvzwADqs8J3GgScG5t6/veVQdaT9QStSt5IaHrf/z/WxDzV?=
 =?us-ascii?Q?yEz3ChncuGINtYdpzeco5UxniZo5BOoHjtcIern4S/fd1ql6VzOBHBBMNVXw?=
 =?us-ascii?Q?KTzb/3TISPz9vscN45plO4faWldj+UmGUmZvi59o0DQSkIOfnqWi0B6n0S7G?=
 =?us-ascii?Q?QSdkC5p6pJ90p/erkEXe1Amq20U4Bbk7cKsdee5KN9GKyEA9zZSJ+k7JWgkr?=
 =?us-ascii?Q?mmK0VhR2m/YEwG9WV3eQgumiIvNzeq6rkAxvYLvN/r+QXMkHAxvfwpGBKh6M?=
 =?us-ascii?Q?8ho8qaGSmnavJgX9RSdbhPdjFVjmTvl3xAr+Sm0z0/PsKFgm2Mn/ydZGrkIX?=
 =?us-ascii?Q?cuPwrC2ihObKOumUx9sHi6uwVPN1KSa5/b2BY0McYn9i1a15ZQJP2RAGCaMH?=
 =?us-ascii?Q?y80HlYEwSmLMlH92JR+h+07kBQ+bIDfZ1kshle5njyUNsK+/Qzp5I5jBOjFH?=
 =?us-ascii?Q?nt3J6vgl7p70pAkkTLgjFGQINHxMraCRvVi6oOMdaV1TEqcM+oQxerRJ/tdL?=
 =?us-ascii?Q?LKDatesVWW66U4PhqJc1D9vThPQGhg9UwR2XBOuGMeE7Poj9u4LzskDyOYrr?=
 =?us-ascii?Q?wLTi6b4isNbhtp0rAHTfd9W7+fK+EVbqhfS4JGWR5okWlvbDMu3WCKAqWe2O?=
 =?us-ascii?Q?p5ucu0Z4jS56NB5mg+g1R3UCq2YiLPIqH3fWOMTQdguc67UdWXPmXYQHcHar?=
 =?us-ascii?Q?eB2+J0kmdHsEV0aArjhzD3EeDCTWtQzwMkwrKu/394vpb9mgAaIZ6O1N6Thx?=
 =?us-ascii?Q?Zb8XoOso6FKfv4PSlf/gqjaISMyVgZbHaeOJ3jjcMs3/GBWrNQ35d5IY0LD8?=
 =?us-ascii?Q?ngIa/0+Z9mXzZdy5Np9hRk6YBCNxDUBfVHIZpqYrbabMY3cM7LRWexGETLDy?=
 =?us-ascii?Q?kjjDUPYQfRA9AtHVmSFRZuLZWyw0u0jy3TUhMsou5VTSLo3VHdCtQVMWclvB?=
 =?us-ascii?Q?qfodQZ8WaPkKvTqNk98FdNrGYHZ0HJWE7DUqmdBfA/S75o973To8l55EVkr2?=
 =?us-ascii?Q?O10uJbyS/qFQf9/nn1NW9m4bgUWspc7uzOLlkoUenLWGERxtwHEC8PMFcUq8?=
 =?us-ascii?Q?AiHqjzc9KMqd7sZVDbn2T4d7npD9OGwHxXNar9fGLSXWywjHWsmjFvyJ9iSS?=
 =?us-ascii?Q?8nHY6dayLf7Kin3mFSxcvzWKZaKwuAXTnZFLZClfEvB/6RYnjVoLEMBXkhCQ?=
 =?us-ascii?Q?XiBbl338BlgOPcuCciGWDwh7gv0ioXP+j60U0W0UJegkoO0eIyDmMgogarAZ?=
 =?us-ascii?Q?YtnImobwBnJZY3NaS50I7Cs89H7YLiuh8M5ASM2zhaUZSEZ8Lqn9TWIqOe3a?=
 =?us-ascii?Q?T4Hsla8hT/9x5SOtCTE4qbzAhisKNqWUQOWwhPoq9Ki1zTgQqb1zjroWafGz?=
 =?us-ascii?Q?kqUHvsgNvGj3npffDjjGNk3ajXcnXe75fucLS6OfyaylV40m/9p5PIe6rjjZ?=
 =?us-ascii?Q?7CzTdLpMMznRZsU3aCc7zabobUThGuOPlqfdcpGpv1PHoC33j0p7zMPUekeQ?=
 =?us-ascii?Q?FX+kqvRicxTb8Aum9XaS6W4fOh1t0FselYWP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 11:22:36.5337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fba14069-e415-400c-75a9-08ddd4db8bdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593
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

Add table caching logic to temperature metrics tables in SMUv13.0.12

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 87 ++++++++++++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 14 ++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |  2 +
 3 files changed, 79 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index aa427fa8ddd2..fd06dcc2b81d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -140,6 +140,42 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMetricsTable,           0),
 };
 
+int smu_v13_0_12_tables_init(struct smu_context *smu)
+{
+	struct amdgpu_baseboard_temp_metrics_v1_0 *baseboard_temp_metrics;
+	struct amdgpu_gpuboard_temp_metrics_v1_0 *gpuboard_temp_metrics;
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
+	struct smu_table_cache *cache;
+	int ret;
+
+	ret = smu_table_cache_init(smu, SMU_TABLE_BASEBOARD_TEMP_METRICS,
+				   sizeof(*baseboard_temp_metrics), 50);
+	if (ret)
+		return ret;
+	/* Initialize base board temperature metrics */
+	cache = &(tables[SMU_TABLE_BASEBOARD_TEMP_METRICS].cache);
+	baseboard_temp_metrics =
+		(struct amdgpu_baseboard_temp_metrics_v1_0 *) cache->buffer;
+	smu_cmn_init_baseboard_temp_metrics(baseboard_temp_metrics, 1, 0);
+	/* Initialize GPU board temperature metrics */
+	ret = smu_table_cache_init(smu, SMU_TABLE_GPUBOARD_TEMP_METRICS,
+				   sizeof(*gpuboard_temp_metrics), 50);
+	if (ret)
+		return ret;
+	cache = &(tables[SMU_TABLE_GPUBOARD_TEMP_METRICS].cache);
+	gpuboard_temp_metrics = (struct amdgpu_gpuboard_temp_metrics_v1_0 *)cache->buffer;
+	smu_cmn_init_gpuboard_temp_metrics(gpuboard_temp_metrics, 1, 0);
+
+	return 0;
+}
+
+void smu_v13_0_12_tables_fini(struct smu_context *smu)
+{
+	smu_table_cache_fini(smu, SMU_TABLE_BASEBOARD_TEMP_METRICS);
+	smu_table_cache_fini(smu, SMU_TABLE_GPUBOARD_TEMP_METRICS);
+}
+
 static int smu_v13_0_12_get_enabled_mask(struct smu_context *smu,
 					 uint64_t *feature_mask)
 {
@@ -514,34 +550,40 @@ static bool smu_v13_0_12_is_temp_metrics_supported(struct smu_context *smu,
 static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
 					     enum smu_temp_metric_type type, void *table)
 {
-	struct amdgpu_gpuboard_temp_metrics_v1_0 *gpuboard_temp_metrics;
 	struct amdgpu_baseboard_temp_metrics_v1_0 *baseboard_temp_metrics;
-	SystemMetricsTable_t *metrics;
+	struct amdgpu_gpuboard_temp_metrics_v1_0 *gpuboard_temp_metrics;
+	struct smu_table_context *smu_table = &smu->smu_table;
+	SystemMetricsTable_t *metrics =
+		(SystemMetricsTable_t *)smu_table->metrics_table;
+
+	struct smu_table *data_table;
 	int ret, sensor_type;
 	u32 idx, sensors;
 	ssize_t size;
 
-	size = (type == SMU_TEMP_METRIC_GPUBOARD) ?
-		sizeof(*gpuboard_temp_metrics) : sizeof(*baseboard_temp_metrics);
-
-	if (!table)
-		goto out;
-	metrics = kzalloc(sizeof(SystemMetricsTable_t), GFP_KERNEL);
-	if (!metrics)
-		return -ENOMEM;
-	gpuboard_temp_metrics = (struct amdgpu_gpuboard_temp_metrics_v1_0 *)table;
-	baseboard_temp_metrics = (struct amdgpu_baseboard_temp_metrics_v1_0 *)table;
-	if (type  == SMU_TEMP_METRIC_GPUBOARD)
-		smu_cmn_init_gpuboard_temp_metrics(gpuboard_temp_metrics, 1, 0);
-	else if (type  == SMU_TEMP_METRIC_BASEBOARD)
-		smu_cmn_init_baseboard_temp_metrics(baseboard_temp_metrics, 1, 0);
-
-	ret = smu_v13_0_12_get_system_metrics_table(smu, metrics);
-	if (ret) {
-		kfree(metrics);
-		return ret;
+	if (type == SMU_TEMP_METRIC_BASEBOARD) {
+		/* Initialize base board temperature metrics */
+		data_table =
+			&smu->smu_table.tables[SMU_TABLE_BASEBOARD_TEMP_METRICS];
+		baseboard_temp_metrics =
+			(struct amdgpu_baseboard_temp_metrics_v1_0 *)
+				data_table->cache.buffer;
+		size = sizeof(*baseboard_temp_metrics);
+	} else {
+		data_table =
+			&smu->smu_table.tables[SMU_TABLE_GPUBOARD_TEMP_METRICS];
+		gpuboard_temp_metrics =
+			(struct amdgpu_gpuboard_temp_metrics_v1_0 *)
+				data_table->cache.buffer;
+		size = sizeof(*baseboard_temp_metrics);
 	}
 
+	ret = smu_v13_0_12_get_system_metrics_table(smu, NULL);
+	if (ret)
+		return ret;
+
+	smu_table_cache_update_time(data_table, jiffies);
+
 	if (type == SMU_TEMP_METRIC_GPUBOARD) {
 		gpuboard_temp_metrics->accumulation_counter = metrics->AccumulationCounter;
 		gpuboard_temp_metrics->label_version = metrics->LabelVersion;
@@ -586,9 +628,8 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
 		}
 	}
 
-	kfree(metrics);
+	memcpy(table, data_table->cache.buffer, size);
 
-out:
 	return size;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 90e66c8f2f82..b80c4d5931c3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -354,6 +354,8 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
 	if (fw_ver >= 0x04560700) {
 		if (!amdgpu_sriov_vf(smu->adev))
 			smu_v13_0_6_cap_set(smu, SMU_CAP(TEMP_METRICS));
+	} else {
+		smu_v13_0_12_tables_fini(smu);
 	}
 }
 
@@ -568,6 +570,9 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	}
 
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12))
+		return smu_v13_0_12_tables_init(smu);
+
 	return 0;
 }
 
@@ -696,6 +701,13 @@ static int smu_v13_0_6_init_smc_tables(struct smu_context *smu)
 	return ret;
 }
 
+static int smu_v13_0_6_fini_smc_tables(struct smu_context *smu)
+{
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12))
+		smu_v13_0_12_tables_fini(smu);
+	return smu_v13_0_fini_smc_tables(smu);
+}
+
 static int smu_v13_0_6_get_allowed_feature_mask(struct smu_context *smu,
 						uint32_t *feature_mask,
 						uint32_t num)
@@ -3816,7 +3828,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.init_microcode = smu_v13_0_6_init_microcode,
 	.fini_microcode = smu_v13_0_fini_microcode,
 	.init_smc_tables = smu_v13_0_6_init_smc_tables,
-	.fini_smc_tables = smu_v13_0_fini_smc_tables,
+	.fini_smc_tables = smu_v13_0_6_fini_smc_tables,
 	.init_power = smu_v13_0_init_power,
 	.fini_power = smu_v13_0_fini_power,
 	.check_fw_status = smu_v13_0_6_check_fw_status,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index ece04ad724fb..f39dbfdd7a2f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -88,6 +88,8 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table, void
 ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu,
 				     struct amdgpu_xcp *xcp, void *table,
 				     void *smu_metrics);
+int smu_v13_0_12_tables_init(struct smu_context *smu);
+void smu_v13_0_12_tables_fini(struct smu_context *smu);
 extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
 extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
 extern const struct smu_temp_funcs smu_v13_0_12_temp_funcs;
-- 
2.49.0

