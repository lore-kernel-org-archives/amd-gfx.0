Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEF460A262D
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xQjuywBI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A7CC10ED87;
	Mon,  2 Nov 2026 12:22:23 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B2F510ED87
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 12:22:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3/9iTGdBQmNApCFopiXA771y69z2636HnTUZLOdtorvM+C8M0dpZJymPMb0P/LcGBxqcXXtMW55l9CQIDSkDnvUD3Ag5QLBRH+cEDYEbv0p8Q84HZGdcwWP5xzBr8nNuZf0LaSYNvJ2Is/1FKpB88tM/MlOskQ4geS6mK3lhnv9u1dlBH3TjoF3w4rqrLGBbr8SCes9M/Qd0cYrSqDX5J8IZs344ZmNT2BOg2wnnQ68rabDnbCr9lpQeSLna5X6lACTqaLwY6QjFGSHK2iDooZXrboXgxghl7WjdJSFr/oZk80krFq3kwjg9H6ZXRQtN4eP9NqZ+PVqBXtSAtUqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KztHL8i6VmXmD/0si9ycv0us8zprWDST95e6ICp734U=;
 b=WAcZCzKAzRvm4jyqcpiqpPiMgUFwtM/w5WOQSnA5bTyzfSr4xjMBTq73HLaRDM2sqmUWv6xGF4EVlzx16GPTp+5qSOGI1j7adWBQtYxmfJMcFib9zy6KFWNcnr6+n84RQVpKaNguYvWC4DZt9Uu0gYeVODhKVK5X0q1/ebhTBjg7hLO/TTy1FV3n9aCCmWZjqEbKjMICfX5PcfNDHF6rm6N8acg2zA33+4vxGpY2gg0JFxuqKo+9uPsPLIBkbw73/S6G6O4vs8gDNE1Lmh6p4N7UG1d7K08JPJJzHP0cPWAOfanj5D/gqeKz1NBYVYljyY2moBaPEbur0njzm2SX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KztHL8i6VmXmD/0si9ycv0us8zprWDST95e6ICp734U=;
 b=xQjuywBIpewGmjwtA9Ozh6Rfti4QYoAtKQ43ryXfSSVRolQ2yF8UmqmsU4dxotuwqCpsJJB5of4AHGYynHRG0w32kDO+mW1F7p7/8uFey/ZWCqBJ8Ma3EbUjxPzt/qO29Ft/DP+NmTQ2SzVMXU8OcZ+y+qViOsdMqQ8jPocSyUQ=
Received: from PH8P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::17)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:21:47 +0000
Received: from BY1PEPF00026967.namprd05.prod.outlook.com
 (2603:10b6:510:346:cafe::2b) by PH8P221CA0040.outlook.office365.com
 (2603:10b6:510:346::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.24 via Frontend Transport; Mon, 2
 Nov 2026 12:21:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026967.mail.protection.outlook.com (10.167.244.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 12:21:46 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 06:21:44 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <Kevin.Wang@amd.com>,
 <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: time SMU metrics caches with ktime
Date: Mon, 2 Nov 2026 20:21:28 +0800
Message-ID: <20261102122128.961804-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026967:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e3cac4-cf1a-45ce-22fa-08df38dbdd1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|261009223027099003|261028144727099003|261021123027099003|261021121427099003|261026121527099003|261022105027099003|261026140227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: XQLCyDFIjdkBcaJ0sg3RuPvYFX1UeUGujFw2NZPGNPoeyBTKmfX433riUugSAY2aAq+pEU/Mff7lwZxZ8l5pHN1mL0mLlWLBV8DJFi+lhq7fk1dvv1+Ud4KPFGFpocx3eBdvMX5rdgqcM8Bh0R4pkq99OYY23hhY0G7k5c7P15llixdAg1tXcZSWniaoMgZoq1NBFJcxBWxQI8gRORLcxMeex8gRSw3BB43Lj5mj3Vnb+fwWNewjrvpjCiZF0zfh33S265PXefHZJtW2SDSQ2U8AjSM0X1/U29h+anWQ1nSNi1FNt8F9ueY+kLrjhgE+e5T9vt0AeC/Hz8efCVMXHQ+6sV9DHZp1QSVZLOc13/pLpikr2j5xEE2ZoTEh9Dd//puKmb1o8DjFRUyVZRWRjobcyCLSraUMvB1J+ScZMXiAsM5x8DEo8wRWJVx3a0zmiy13uIQPCpPIqqqCmRDe8tpVdMF17tE+jtvyumSnTIGBO2ml3pCPX91hvrtFE2WGMDiBhQZE+SOu/kv24F78RDaPeoYnSDMxdfe/1xU//65X66XKTR/RxYvTRKuEuqnJi6LbobYVIP9SWA2flZCWUOnqV7o/fIK6J2qBi4XDGG9FjFpjscGhawQJ4lePzwbjvE7Mc0TP8DNwm5XJoSz3qdCMOpfwKQplHeIMW3bKzNZfh3rZtnX714T9LLZwHPMpOqLqMNYhZMh1psQ7qU07Qw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261022105027099003)(261026140227099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DSrVlvG3LKzxCT96rutVk7ZtpLKL1XNUXOSSmO845KOcSLm4u58Qy0bP1+ib25lVH3g+BX5MeBLzph0HCfJyBw457+Uv42GLZ5EaqSFj+x9ICkN0+ZekPKZzSGTJlJalOR4a6OgD8RdG/JjSEvhwa4+EgcRsevagda3tB89iJ3zGFbFKzr05UpfPB5z9I1LSVqF2/c0GhHmh7CyT9wbbLN4+IHjHi67Az99ZNuBWMGt9GGJiE5CIVALx8JcyqKqUnDh0nbj/HVabSyGPX2AjXltOqrfNAZQG0us/vXS5BkobUfX/f2ecqrAmG1stTuCxz43RRdcY2zSe59E8nX+rxExrxfV4S3ibLrBgTcOZWqnIHR81jUhy/z0JJDupaJDoFny6ePdVHYt5AfcUfCj0YyHYR9MAzasDh3OkU7EFxqpr5JAvYPS2XuSDprkbndTd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:21:46.7428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e3cac4-cf1a-45ce-22fa-08df38dbdd1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026967.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The metrics caches store their interval in milliseconds but test it
with jiffies. On a HZ=250 kernel msecs_to_jiffies(5) is 2 ticks, and
time_after() keeps the cache valid through the end of that tick, so a
5 ms GPU metrics cache holds for about 8 ms to 12 ms. The same rounding
turns the 1 ms raw metrics-table cache into up to about 8 ms.

Stamp and compare these caches with ktime_get_boottime() so the
configured interval is the real interval.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 38 ++++++++++---------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  6 +--
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  |  5 +--
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  |  7 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  5 +--
 6 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 9d47d2ab1b49..5ad50a304168 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -31,6 +31,7 @@
 #include "dm_pp_smu.h"
 #include "smu_types.h"
 #include "linux/firmware.h"
+#include <linux/ktime.h>
 
 #define SMU_THERMAL_MINIMUM_ALERT_TEMP		0
 #define SMU_THERMAL_MAXIMUM_ALERT_TEMP		255
@@ -275,7 +276,7 @@ struct smu_table_cache {
 	size_t size;
 	/* interval in ms*/
 	uint32_t interval;
-	unsigned long last_cache_time;
+	ktime_t last_cache_time;
 };
 
 struct smu_table {
@@ -403,7 +404,7 @@ struct smu_table_context {
 	void				*power_play_table;
 	uint32_t			power_play_table_size;
 	void				*hardcode_pptable;
-	unsigned long			metrics_time;
+	ktime_t				metrics_time;
 	void				*metrics_table;
 	void				*clocks_table;
 	void				*watermarks_table;
@@ -1815,22 +1816,26 @@ smu_metrics_get_temp_table_id(enum smu_temp_metric_type type)
 	return SMU_DRIVER_TABLE_COUNT;
 }
 
-static inline void smu_table_cache_update_time(struct smu_table *table,
-					       unsigned long time)
+static inline bool smu_ms_cache_expired(ktime_t last, uint32_t interval_ms)
 {
-	table->cache.last_cache_time = time;
+	if (!last || !interval_ms)
+		return true;
+
+	return ktime_after(ktime_get_boottime(), ktime_add_ms(last, interval_ms));
+}
+
+static inline void smu_table_cache_update_time(struct smu_table *table)
+{
+	table->cache.last_cache_time = ktime_get_boottime();
 }
 
 static inline bool smu_table_cache_is_valid(struct smu_table *table)
 {
-	if (!table->cache.buffer || !table->cache.last_cache_time ||
-	    !table->cache.interval || !table->cache.size ||
-	    time_after(jiffies,
-		       table->cache.last_cache_time +
-			       msecs_to_jiffies(table->cache.interval)))
+	if (!table->cache.buffer || !table->cache.size)
 		return false;
 
-	return true;
+	return !smu_ms_cache_expired(table->cache.last_cache_time,
+				     table->cache.interval);
 }
 
 static inline int smu_table_cache_init(struct smu_context *smu,
@@ -1906,14 +1911,11 @@ static inline void smu_driver_table_fini(struct smu_context *smu,
 
 static inline bool smu_driver_table_is_valid(struct smu_driver_table *table)
 {
-	if (!table->cache.buffer || !table->cache.last_cache_time ||
-	    !table->cache.interval || !table->cache.size ||
-	    time_after(jiffies,
-		       table->cache.last_cache_time +
-			       msecs_to_jiffies(table->cache.interval)))
+	if (!table->cache.buffer || !table->cache.size)
 		return false;
 
-	return true;
+	return !smu_ms_cache_expired(table->cache.last_cache_time,
+				     table->cache.interval);
 }
 
 static inline void *smu_driver_table_ptr(struct smu_context *smu,
@@ -1938,7 +1940,7 @@ smu_driver_table_update_cache_time(struct smu_context *smu,
 	if (table_id >= SMU_DRIVER_TABLE_COUNT)
 		return;
 
-	driver_tables[table_id].cache.last_cache_time = jiffies;
+	driver_tables[table_id].cache.last_cache_time = ktime_get_boottime();
 }
 
 #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 1691a0be4f7d..7d1594a24431 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -485,7 +485,7 @@ static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	smu_table_cache_update_time(sys_table, jiffies);
+	smu_table_cache_update_time(sys_table);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 95e288327e45..01110afe8502 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -750,9 +750,7 @@ int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_table,
 	struct smu_table *table = &smu_table->driver_table;
 	int ret;
 
-	if (bypass_cache || !smu_table->metrics_time ||
-	    time_after(jiffies,
-		       smu_table->metrics_time + msecs_to_jiffies(1))) {
+	if (bypass_cache || smu_ms_cache_expired(smu_table->metrics_time, 1)) {
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetMetricsTable, NULL);
 		if (ret) {
 			dev_info(smu->adev->dev,
@@ -770,7 +768,7 @@ int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_table,
 				min(16, table_size)))
 			return -EHWPOISON;
 
-		smu_table->metrics_time = jiffies;
+		smu_table->metrics_time = ktime_get_boottime();
 	}
 
 	if (metrics_table)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 1004c5d59728..5e6fdbeb2f41 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -361,8 +361,7 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 	size_t table_size = metrics_info->table_size;
 	int ret;
 
-	if (smu_table->metrics_time &&
-	    !time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1)))
+	if (!smu_ms_cache_expired(smu_table->metrics_time, 1))
 		return 1;
 
 	if (!cpu_addr)
@@ -386,7 +385,7 @@ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
 			      cpu_addr, sizeof(MetricsTable_t));
 
 	metrics_info->active_idx = !metrics_info->active_idx;
-	smu_table->metrics_time = jiffies;
+	smu_table->metrics_time = ktime_get_boottime();
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index c778091a4272..c2a956a78b5f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -358,8 +358,7 @@ static int smu_v15_0_8_get_metrics_table_internal(struct smu_context *smu, uint3
 
 	mutex_lock(&smu_table->metrics_lock);
 
-	if (!tmo || !smu_table->metrics_time ||
-	    time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(tmo))) {
+	if (smu_ms_cache_expired(smu_table->metrics_time, tmo)) {
 		int ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetMetricsTable, NULL);
 		if (ret) {
 			dev_info(adev->dev,
@@ -376,7 +375,7 @@ static int smu_v15_0_8_get_metrics_table_internal(struct smu_context *smu, uint3
 			return ret;
 		}
 
-		smu_table->metrics_time = jiffies;
+		smu_table->metrics_time = ktime_get_boottime();
 	}
 
 	if (data)
@@ -586,7 +585,7 @@ static int smu_v15_0_8_get_system_metrics_table(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	smu_table_cache_update_time(sys_table, jiffies);
+	smu_table_cache_update_time(sys_table);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index b0abc2f504c3..417e988c361d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1230,8 +1230,7 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
 	int ret = 0;
 
 	if (bypass_cache ||
-	    !smu_table->metrics_time ||
-	    time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
+	    smu_ms_cache_expired(smu_table->metrics_time, 1)) {
 		ret = smu_cmn_update_table(smu,
 				       SMU_TABLE_SMU_METRICS,
 				       0,
@@ -1241,7 +1240,7 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
 			dev_info(smu->adev->dev, "Failed to export SMU metrics table!\n");
 			return ret;
 		}
-		smu_table->metrics_time = jiffies;
+		smu_table->metrics_time = ktime_get_boottime();
 	}
 
 	if (metrics_table)
-- 
2.46.0

