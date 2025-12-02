Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8D0D116F6
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 11:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59F6D10E05D;
	Tue,  2 Dec 2025 11:44:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vZwirXYG";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F5F210E624
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 11:44:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEgSQehpX9qWMXb2NEEvqluNKaprlG+J0sbsE09F7TiJKDEKVWuZXa6RIVPUpzLB5b7qzZAeI+LAb9jeVq2OgLo8BsSQbFTtDB48n7FO0Qs2FnFK4pW+Ve41hNNbb17+yrx7PGeAwCJaSF41QAFMIZK3foqbCeROypPQiUAqvo4F3TEWnCW/ALEDH9/0Ji6Bzan/aQ9FHukwoLA5TvzhVxMqEgREvK9VxurKTSpM9t2+6G3wtB/s72mZGPGBadJYFO2MUx+GwCNi1HaYxkEwJ0oRI58CS08KAcjqgyBvELtG0qrKoLQuggMdOCzONxHpqCpJtRZqAg9aLv4t8UXGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmL2XG3hYjTZv1FiND0QwkL657ZxzvmkUwZxuC6EXkk=;
 b=YMVPpfwwdT8dSR+E6rVBh3ozEEeiaYKIAJ0t6txhGRRWYn917rgmuBSx4KqE1dyraNX/sDY4CHIT+jzg6hRNYoaDgMyROHD6cmr0Pd6Kx3iPRAI7muUFxN7IjEyeM4jikWpxYMmHEsPON0/218+ilpo/aKopX9doT9SG477pVdXF4UQ3MCT1F3ICOOgim/kkHhMFVFKTwDMEyYJySvPtq0zFIutrfnNGYeL4YZOCDfAf1x4r6r9pRokvZV+0DH2VCNuUs2Z+RG1IVbzaXza/xNczdyHRj6vGTzFF+i9igN7EKEDiWPngMhvH+FczACRfQFIg14k6XPVKIND4KExHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmL2XG3hYjTZv1FiND0QwkL657ZxzvmkUwZxuC6EXkk=;
 b=vZwirXYGPT6PUGNntvymPFRzRnAiguwhJsrW1qM1fUCxKJWwHV93U8JoQaYgEujYbCDYhtvB0jZOLkRY/tdOKN2SV7HhpnJi1NhtlAPCHKiRfmfJHjJ+QVSpVFdo+6FNAvYOKUPSKLtxRS7tR4nAw2jnrgt3yoXhbT8yjH/kx/s=
Received: from PH8P221CA0038.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::9)
 by CH1PPF84B7B0C96.namprd12.prod.outlook.com (2603:10b6:61f:fc00::618) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 11:44:25 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:346:cafe::3a) by PH8P221CA0038.outlook.office365.com
 (2603:10b6:510:346::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Tue, 2
 Dec 2025 11:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Tue, 2 Dec 2025 11:44:24 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 05:44:22 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 1/7] drm/amd/pm: Add smu driver table structure
Date: Tue, 2 Dec 2025 17:09:08 +0530
Message-ID: <20251202114358.512048-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251202114358.512048-1-lijo.lazar@amd.com>
References: <20251202114358.512048-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|CH1PPF84B7B0C96:EE_
X-MS-Office365-Filtering-Correlation-Id: c034c6cf-6bc3-402a-a08d-08de31982473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s8ub3GAnIgH4AY7LbjGr0Tk/dNDPoLc6L7CYkYY06BeZ9eugpvv25Sg1lBYm?=
 =?us-ascii?Q?LPk8ai8kDlqdji2A5Nlek6giQAmixVYqMfw6T6B2hscCi8Vuv0L+sCjQ6NKh?=
 =?us-ascii?Q?H7zN+1NBeSa+Zi8QDaLvMf0PJhprIQYlA6LeCjEc8DDUPG5QTqD2ISjg4twv?=
 =?us-ascii?Q?xSUBO7LkgDgakaDr8o1Vd5aliLM0LHrEGYI1E7Fq/I61HD7RA2jvD35o9mzn?=
 =?us-ascii?Q?GtrZ3oOIERjbiiUrAaYDxxU6aP9Cmu4fARpbe5kvvUb442N2izTs66f9Qpt1?=
 =?us-ascii?Q?yNdFdaJZBkNKdyeHE7yy4Cf4e+w8zOrXmXrx1dCDUgydIWj/5+LnW4jUfX9m?=
 =?us-ascii?Q?x3TqvBbYsksEL8t9MGAwynHThG4gQPpvSS79zCfB6UW/dpO/k06gKliyrDt/?=
 =?us-ascii?Q?SAIyxQpF8+YAVlFD533ELB+E7rVyt086XMTk3MFPmDCvNhPpf0j0Pc+HuSlF?=
 =?us-ascii?Q?HlObLmh5WrccpCAZMshaz6g78MWI9wPP8799ySsTjOnuefthfp3xjcjsYV9w?=
 =?us-ascii?Q?yPZTerts9VP8R0Xjba2urDCgb3ndmMDLrHs8Dj5jqZeaYNTMaNmGtsNwCGif?=
 =?us-ascii?Q?OnE/FxVSS91WBjrHxtBXE1xzHKfBOcEOE6/ZIfH69NDEaZ0xAmHuU3kMApBT?=
 =?us-ascii?Q?DlJDIsAbuZ17RMcMpYedSd7+bSqemjbTqgnJituAacmimV+mOvX8SZwXFYVC?=
 =?us-ascii?Q?Yh9lP1G2wd9ONj4k/smQ3cdfI5g2XWDJ7F5pT0BOL3TKnvSEgnWkNvqCYnqp?=
 =?us-ascii?Q?U/MdgJvpTh0UPPn+JgqPB9/8Wy4lZcYdtZq6T47YfjJwWN9L1WN4q9vGmnAv?=
 =?us-ascii?Q?oCvi/T3pK8KyuPo1Rvjjs6nG2tCreg+1bPv1kRQfCpn2ZCqaCI0/DBrhVmiE?=
 =?us-ascii?Q?XNIz78Xp9G96nFkrQd7pF+3J2TitXA+caP4sJx1ON9urxEMr9qx7JdVSRSYS?=
 =?us-ascii?Q?jdVeAksAQGnVMaEwDqcmzHFEKcciu4mSahwn8eIxcZ1CvMz18+2u9vClDAJC?=
 =?us-ascii?Q?rQPC2N7hpMIlgGxG+0AIZ9fU6lEOuymqfRE8RKL08WIDeKY1GHYzFdIfp39z?=
 =?us-ascii?Q?RmhTinSDnWCNIs8b7iJEjoNyqs3XjJe9hRS6DxUmShmfEc7qc56Ds8y/E5i3?=
 =?us-ascii?Q?TqX4HhgdmqPsi8XvHMzcg2UxXJsDDs7h9pzov2HZWr49UgLzeCRacYE4+uyf?=
 =?us-ascii?Q?s5XaCufEVlHkl0yGhbRlFHLzhZB+pnKkpOGQjKu8/VrmDK7j92GRfR9TwUEo?=
 =?us-ascii?Q?PFvutBPbU+sD6hFMnbS43o/UxWosdiA9WLRYXVpizRkxIwBmP89YXScCzTpq?=
 =?us-ascii?Q?tC+0w5++R10Mw9otyCB8KlymjvKIs0BzUnPVd3YZSL0WpWgyq92zsq+fJtye?=
 =?us-ascii?Q?k9YsQTK9ui3bGkMQgIVI/Sq3VnMQzWkrUlXcv0M00wzL1snx4WBA47STXkpg?=
 =?us-ascii?Q?MD1q/yMFJB6UGKhzXo9A8J90CYdyf4gCJ5kXyKHCZxoaYu3modbuY7/QNVkI?=
 =?us-ascii?Q?S+DG7bjDkV22dAxoMNk5UGBwQ7iW1B2FEdsDciHZLzs5q69gv8VJPLHLM4Zv?=
 =?us-ascii?Q?+xsoHXnFIesVJABBZPU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 11:44:24.8432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c034c6cf-6bc3-402a-a08d-08de31982473
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF84B7B0C96
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

For interfaces like gpu metrics, driver returns a formatted structure
based on IP version. Add a separate data structure for such tables which
also tracks the cache intervals.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 8815fc70b63b..23ab75b705b6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -269,6 +269,16 @@ struct smu_table {
 	struct smu_table_cache cache;
 };
 
+enum smu_driver_table_id {
+	SMU_DRIVER_TABLE_GPU_METRICS = 0,
+	SMU_DRIVER_TABLE_COUNT,
+};
+
+struct smu_driver_table {
+	enum smu_driver_table_id id;
+	struct smu_table_cache cache;
+};
+
 enum smu_perf_level_designation {
 	PERF_LEVEL_ACTIVITY,
 	PERF_LEVEL_POWER_CONTAINMENT,
@@ -373,6 +383,8 @@ struct smu_table_context {
 
 	uint32_t			gpu_metrics_table_size;
 	void				*gpu_metrics_table;
+
+	struct smu_driver_table driver_tables[SMU_DRIVER_TABLE_COUNT];
 };
 
 struct smu_context;
@@ -1745,6 +1757,82 @@ static inline void smu_table_cache_fini(struct smu_context *smu,
 	}
 }
 
+static inline int smu_driver_table_init(struct smu_context *smu,
+					enum smu_driver_table_id table_id,
+					size_t size, uint32_t cache_interval)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_driver_table *driver_tables = smu_table->driver_tables;
+
+	if (table_id >= SMU_DRIVER_TABLE_COUNT)
+		return -EINVAL;
+
+	driver_tables[table_id].id = table_id;
+	driver_tables[table_id].cache.buffer = kzalloc(size, GFP_KERNEL);
+	if (!driver_tables[table_id].cache.buffer)
+		return -ENOMEM;
+
+	driver_tables[table_id].cache.last_cache_time = 0;
+	driver_tables[table_id].cache.interval = cache_interval;
+	driver_tables[table_id].cache.size = size;
+
+	return 0;
+}
+
+static inline void smu_driver_table_fini(struct smu_context *smu,
+					 enum smu_driver_table_id table_id)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_driver_table *driver_tables = smu_table->driver_tables;
+
+	if (table_id >= SMU_DRIVER_TABLE_COUNT)
+		return;
+
+	if (driver_tables[table_id].cache.buffer) {
+		kfree(driver_tables[table_id].cache.buffer);
+		driver_tables[table_id].cache.buffer = NULL;
+		driver_tables[table_id].cache.last_cache_time = 0;
+		driver_tables[table_id].cache.interval = 0;
+	}
+}
+
+static inline bool smu_driver_table_is_valid(struct smu_driver_table *table)
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
+static inline void *smu_driver_table_ptr(struct smu_context *smu,
+					 enum smu_driver_table_id table_id)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_driver_table *driver_tables = smu_table->driver_tables;
+
+	if (table_id >= SMU_DRIVER_TABLE_COUNT)
+		return NULL;
+
+	return driver_tables[table_id].cache.buffer;
+}
+
+static inline void
+smu_driver_table_update_cache_time(struct smu_context *smu,
+				   enum smu_driver_table_id table_id)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_driver_table *driver_tables = smu_table->driver_tables;
+
+	if (table_id >= SMU_DRIVER_TABLE_COUNT)
+		return;
+
+	driver_tables[table_id].cache.last_cache_time = jiffies;
+}
+
 #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
 int smu_get_power_limit(void *handle,
 			uint32_t *limit,
-- 
2.49.0

