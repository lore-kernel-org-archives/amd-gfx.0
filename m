Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904D0C87FCB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 11:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F5CF10E3CE;
	Wed,  6 Aug 2025 11:22:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n2MighI5";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB1810E3CE
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 11:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiK0qMacWPBBohIR1DvQjfxhmOiL42z3Hbl9Fd6vKUWL4aTaxe2vh8iaHSLcGqZIgJpe4ASls/d9FY+uGXbKxXyjrLsd7oyjMeTbrQhX+1b49rfc5IqYbY1q81dhgW1RvIRWlbp5M1R7lOddIFcYxUxNEPFdgxxAmK7GyWwAOCj3/2H8coOz2yut1T8tToJjrRnRle6uMyRoNNQjgq2D9XMuMvk5+dbQlND46hT4jYez14eDBDkoH0wTR3AUcxHsLtLkrJ49d69LAk6iFqUX2Q2+WA00pMjkDae2eKnmf8H4/z+sxniK4A2c29QFiPbi7pVpKudhMnfF0zLR32mP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JK2YrngN2JCnDf/mEvJX6K2/t/7LzYOSj2V7bmIV4X4=;
 b=cWdRQzq3rioIeEmt89fNPFpxdIS803Ba4nw/8xNmNrhdpV955fSL29poUUz9tCXUNTXble6jZbqvoq9nHHie31nWCN5UlwwyfKyCScgMJSKSMVmn42orwaJ5WQHrg3qivdLvZpZcrtunGFeTfW0dY+fSOu30YOs0sI21I76XIFM671gXYlaxMniu1THPGmL+cWENOzMuDemK2rT7s9vIBr883WAneUdBXmkEPtp5Fl5G+s0JAzrEV/NDL+mJy/lu0vaS4ySruCyLr2W1h/ygwOI1x2zN8E91d2w0N4nkZ2CSP50NRfQYEZrJNCooeNEZ5bhMpjfI9jK1uQF4IGqq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JK2YrngN2JCnDf/mEvJX6K2/t/7LzYOSj2V7bmIV4X4=;
 b=n2MighI5ilAgk8j7c0x5+m9QmOTmLukK7rg/orjJWmi0YNIcDCgQCfEt4UCFwLGL+8ttfvnGUwjzNVetoFm0WhPkJIehunbjmfSpsnDYEvIN5fxClNCqUYw4ecbmNG6JJsqfHt/L4s+FMEQIHGTClz+Ns9IImGZhKfrPcONoXxA=
Received: from CH2PR15CA0018.namprd15.prod.outlook.com (2603:10b6:610:51::28)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Wed, 6 Aug
 2025 11:22:35 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::b7) by CH2PR15CA0018.outlook.office365.com
 (2603:10b6:610:51::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.14 via Frontend Transport; Wed,
 6 Aug 2025 11:22:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 11:22:34 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Aug
 2025 06:22:32 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: Add cache logic for temperature metric
Date: Wed, 6 Aug 2025 16:51:55 +0530
Message-ID: <20250806112214.1804907-2-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca2f305-e785-4cc0-6609-08ddd4db8ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mfskalqJvDQuskw7P46RP8B+/7epFyJul9iBvRCydAX3hYlYtUD7jmH2fENu?=
 =?us-ascii?Q?TGFmnXOvDk47tW8+xCnDAY4JS2q0ReQc+swhIGaSLIi/MpGggBRf793ioPpM?=
 =?us-ascii?Q?6zgA3ouWr0J3tA4ZQpERJtOnlAzelgpDr/QFe7zOu8fSN3G66oOO2k1Gq8KC?=
 =?us-ascii?Q?wBcj5fE8i4RBE6wDqnBZxe/djPn0ByMOqEiftSeKuZ3PNtOWRXsnwsU2nsa6?=
 =?us-ascii?Q?x5TgSc9AuGnvQYdZ+sk83uVJHAzXQMjwn9+dlYPklbnniDNMe9lefnQ3WgoN?=
 =?us-ascii?Q?x5q8gtnGtf/SXYEVuZCSd9ukr/J8wcTS9bpe+BvSl4QM2+L1iIsWaoZiLldh?=
 =?us-ascii?Q?CFZ3oHZaLgaomOB2V8BszZxjuiwq55Qx0L9gobxtvjOjH0rNY6tbXryHZJXv?=
 =?us-ascii?Q?L6XZSdfFrQNkVjcGc6v118482bmJjHoDuLKgBuJY3EMSu2cP43QH3iL0rWdB?=
 =?us-ascii?Q?RPCVX8PoAy/TK98nDKOtKGdJKWj70clsfjoGmdeDPjTEr8mHHuZ+FbF9FvVy?=
 =?us-ascii?Q?nAQE+tb9psjAdoOPK0ngLPXGS7hcoTXp4dPAz3EpPLrFZGY6XTG7KyAeWqvu?=
 =?us-ascii?Q?fwv+3PRoOiYYcpf2nZ+r9DEUQXCLPZyb83oSTkIr735fcEeH5EMuZwjm/jB1?=
 =?us-ascii?Q?uR1JK954O+UFEVusNi0FbBTcddkNoK761M54AHZv+hPAI9eOXqihfvJtakAo?=
 =?us-ascii?Q?JQh9/4FMGu8WIE6NRY9bS96KnwIqKO08JIU6NHl8i2QWWBQqz9yVHVRglMPE?=
 =?us-ascii?Q?Gx6KandxaOAgphjLK/JxtjLOxN2nXXPIBMXHc9bdi8LAOfpuLwOoWyPAAF2j?=
 =?us-ascii?Q?hAjQom8ZcdvvYnMiRJeYbpzvsp6xspCAKFv6My6GTxqBOv5tb98lLjiQeHuB?=
 =?us-ascii?Q?jELSKs9o3VWt8bIGUqc9Ly/HefmZK1PlVojgpqyM/M8PtB1aOy4cpgK5MuJS?=
 =?us-ascii?Q?nBI3p4ytf/dvKviMMcnTJeciA95Mq2lKC8L1iHVqSf0XtNbEQ7bBGQ62/NYg?=
 =?us-ascii?Q?neQ0ErWqlhSxa1QPgFFTOBa0goWEXEjcXcDQ4VM8hmpfZwX9Tg9Vl77PaD5N?=
 =?us-ascii?Q?T5s31IR3l3PIXvO5Gt8SSQJsyd9nB04LGBdnJigN9OhGjsCCjgfbM+iaxVGZ?=
 =?us-ascii?Q?4FaR4ek8uWdf5lFU+6alWDMyDQmwFhtqVKstupMQ0l6PTvEGyEozzEWefWXr?=
 =?us-ascii?Q?fM5Mlr7pGhosOzzoaBJpjK+juwpPgGpz9b4TfXuGtYibK0RE8gJs1G6Orr0J?=
 =?us-ascii?Q?uq1rjrYf9vZQ7QTMNV89B+M4mq6MvNQJDADFSfoJzAExu3ZFiGBmEFp7gpXe?=
 =?us-ascii?Q?sxw7qvfg9TkWAQLfPaKZe/eo7ZSiubpPtYy8snCh6H1gdsFBecDppOMbXaFo?=
 =?us-ascii?Q?stX685WYNL/YnV1sCHKweH4UQMo9I4PPo2gMsCxUv9LlzObzCTRjT7PoomQH?=
 =?us-ascii?Q?VEBuAHuTlM/2z64+eWy7HiAzv+DcZFzhNWwEdENcattIvSTtpYNTid6jwSaQ?=
 =?us-ascii?Q?lqQptI1nshI71+U1/w99EG1bxtXjnaa0nCb/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 11:22:34.7119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca2f305-e785-4cc0-6609-08ddd4db8ac6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
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

Add caching logic for baseboard and gpuboard temperature metrics tables.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 18 +++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 78 ++++++++++++++++++-
 2 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index dc48a1dd8be4..0a40ab817634 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3835,6 +3835,9 @@ int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 static ssize_t smu_sys_get_temp_metrics(void *handle, enum smu_temp_metric_type type, void *table)
 {
 	struct smu_context *smu = handle;
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
+	enum smu_table_id table_id;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -3842,6 +3845,21 @@ static ssize_t smu_sys_get_temp_metrics(void *handle, enum smu_temp_metric_type
 	if (!smu->smu_temp.temp_funcs || !smu->smu_temp.temp_funcs->get_temp_metrics)
 		return -EOPNOTSUPP;
 
+	table_id = smu_metrics_get_temp_table_id(type);
+
+	if (table_id == SMU_TABLE_COUNT)
+		return -EINVAL;
+
+	/* If the request is to get size alone, return the cached table size */
+	if (!table && tables[table_id].cache.size)
+		return tables[table_id].cache.size;
+
+	if (smu_table_cache_is_valid(&tables[table_id])) {
+		memcpy(table, tables[table_id].cache.buffer,
+		       tables[table_id].cache.size);
+		return tables[table_id].cache.size;
+	}
+
 	return smu->smu_temp.temp_funcs->get_temp_metrics(smu, type, table);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 611b381b9147..2edd867f203e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -249,6 +249,14 @@ struct smu_user_dpm_profile {
 		tables[table_id].domain = d;		\
 	} while (0)
 
+struct smu_table_cache {
+	void *buffer;
+	size_t size;
+	/* interval in ms*/
+	uint32_t interval;
+	unsigned long last_cache_time;
+};
+
 struct smu_table {
 	uint64_t size;
 	uint32_t align;
@@ -257,7 +265,7 @@ struct smu_table {
 	void *cpu_addr;
 	struct amdgpu_bo *bo;
 	uint32_t version;
-	unsigned long  metrics_time;
+	struct smu_table_cache cache;
 };
 
 enum smu_perf_level_designation {
@@ -323,7 +331,8 @@ enum smu_table_id {
 	SMU_TABLE_ECCINFO,
 	SMU_TABLE_COMBO_PPTABLE,
 	SMU_TABLE_WIFIBAND,
-	SMU_TABLE_TEMP_METRICS,
+	SMU_TABLE_GPUBOARD_TEMP_METRICS,
+	SMU_TABLE_BASEBOARD_TEMP_METRICS,
 	SMU_TABLE_COUNT,
 };
 
@@ -1651,6 +1660,71 @@ typedef struct {
 struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
 					 enum pp_pm_policy p_type);
 
+static inline enum smu_table_id
+smu_metrics_get_temp_table_id(enum smu_temp_metric_type type)
+{
+	switch (type) {
+	case SMU_TEMP_METRIC_BASEBOARD:
+		return SMU_TABLE_BASEBOARD_TEMP_METRICS;
+	case SMU_TEMP_METRIC_GPUBOARD:
+		return SMU_TABLE_GPUBOARD_TEMP_METRICS;
+	default:
+		return SMU_TABLE_COUNT;
+	}
+
+	return SMU_TABLE_COUNT;
+}
+
+static inline void smu_table_cache_update_time(struct smu_table *table,
+					       unsigned long time)
+{
+	table->cache.last_cache_time = time;
+}
+
+static inline bool smu_table_cache_is_valid(struct smu_table *table)
+{
+	if (!table->cache.buffer || !table->cache.last_cache_time ||
+	    !table->cache.interval || !table->cache.size ||
+	    time_after(jiffies,
+		       table->cache.last_cache_time +
+			       msecs_to_jiffies(table->cache.interval)))
+		return false;
+
+	return true;
+}
+
+static inline int smu_table_cache_init(struct smu_context *smu,
+				       enum smu_table_id table_id, size_t size,
+				       uint32_t cache_interval)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
+
+	tables[table_id].cache.buffer = kzalloc(size, GFP_KERNEL);
+	if (!tables[table_id].cache.buffer)
+		return -ENOMEM;
+
+	tables[table_id].cache.last_cache_time = 0;
+	tables[table_id].cache.interval = cache_interval;
+	tables[table_id].cache.size = size;
+
+	return 0;
+}
+
+static inline void smu_table_cache_fini(struct smu_context *smu,
+					enum smu_table_id table_id)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
+
+	if (tables[table_id].cache.buffer) {
+		kfree(tables[table_id].cache.buffer);
+		tables[table_id].cache.buffer = NULL;
+		tables[table_id].cache.last_cache_time = 0;
+		tables[table_id].cache.interval = 0;
+	}
+}
+
 #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
 int smu_get_power_limit(void *handle,
 			uint32_t *limit,
-- 
2.49.0

