Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A03CAC58E
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 08:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA0A410E336;
	Mon, 15 Sep 2025 08:02:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YKdSTFcC";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 141AD10E336
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 08:02:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEpM89/sq4gF9Ufcyhi7pc0InjAl4WW4SOSAfy6k6OpVpYVbfyfrkOYuPAnQlsvJGW21IJDfnHRHVSQWmcusk/Xs/TdFSppocV2/qCvVDO1XZOiJfFb0Ohr0q9GIw18zGxug5LyBxM84etDXm1wdV4TxuHy0e6jijyZMRUhxBzeu6x2LYYi+eiK3T1aUDJ/rrPlrbwf0i6MCxtoH1ol5YKS12tT7JiqdeeGnzyf5gTKY1ZMdcwFOFZG4UfSJt0Su49ZDIBiFlfKw3+Z7hYrQ0D90m2gV+xqxNKsfIRP7f8EMZbZR+WhSi85adl0VKgm6/kMhudX1/vYIBi5E6a4iQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvgKzr00emwLT80xcR8xKn9uOA5GBXNdUgsDwcoU/lg=;
 b=krUPMuEGWf0MzsJ6dlTqy8mmrsogXRThT371BZbaXhIELS6ZLaAzADFaAdW+rEyc2Us3zncRXDjfjPoRAq4l5XZgKd88IwVT5vnY+my7+FIHQW5UzaM3FXP7R9oOkF3t/Gq4SEOWHa+VTi+vcUNuthvUIdBkNRYV0/paOQ25YL2AS1zj0QlQW5VkuJrYQAv2I/tk9uUXyOYBX2d73EWNLUTRM83yIy1M0ebCA+peI/3y7JqkqCAbaR0vi9RUXgENMuiB3ld8LeJRYv+3+0hVyI4w+H+8wNDNxsjZ9ByUgpKWmP6NAnr3FzKcvLuqXp2l9fIDqnimQvv0B9ALvBZPfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvgKzr00emwLT80xcR8xKn9uOA5GBXNdUgsDwcoU/lg=;
 b=YKdSTFcC5YBowu73ersyeguvaGRokt98ofueZKM1bvD95s8FIpWvYb7turj0qRRV2S2jOs0xoVN0Sop3NwksW4vQK5grHfWvhS4Af91kIYwir/NdMHDCPzK+3/0REGeHppy6Z5RYpxag3cspUQs3hp4z3HuFuhpAMqVEnd4Biok=
Received: from BY3PR05CA0057.namprd05.prod.outlook.com (2603:10b6:a03:39b::32)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 08:02:18 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::a7) by BY3PR05CA0057.outlook.office365.com
 (2603:10b6:a03:39b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Mon,
 15 Sep 2025 08:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 15 Sep 2025 08:02:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 01:02:13 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v4 6/7] drm/amd/pm: Update SMUv13.0.6 partition metrics
Date: Mon, 15 Sep 2025 13:26:35 +0530
Message-ID: <20250915080123.3024297-7-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250915080123.3024297-1-lijo.lazar@amd.com>
References: <20250915080123.3024297-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 625df70f-06ea-4ce1-9276-08ddf42e3149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hgATsPkmhILD/yn3xNr3A26AO1lWBJMPYEzQlWRJTOsykEyqgZj/J/eZf1SQ?=
 =?us-ascii?Q?R/7uymwnvjmczzSndPawQ8yfNNGhuHZ/tkyduBS25k+DGbitEbtpKIIh3p/k?=
 =?us-ascii?Q?412f6CgRNzhw6rR7adyz9nxFW/BJt9f0kNo4Gvst4ZpqlOwEwXPoeoCfOW0l?=
 =?us-ascii?Q?SH715TCYhZQ5wIdqg/R1qU1np8lD+YCiHvB1cV9WWQ1+z79Hax3IM2B/UBip?=
 =?us-ascii?Q?Iw2rGS8HVmoypzO6/+a3rvxFxvetXIZzvU2H/Ym0L9/EV5KWbiO8usyJ+LpI?=
 =?us-ascii?Q?eI+KUQFaZUvsrQ4ED7zJ5RMuDm/OOsrbPEdvy3txy8RqpO6LdMv/WFJZPzw/?=
 =?us-ascii?Q?Nv4pSuT8Cf8FnpHbSq9YhnGtBF4aGXBPvGXhJ0TmE6tZ4cujxPd2uc/VeJUR?=
 =?us-ascii?Q?hQTE6/XZhWMDKS0NYIEpFNyQ3BS7a0j9LDesgpUEUvGx0wclgiHxLOVZqgJb?=
 =?us-ascii?Q?J5oklpFfiwLS/nXSGzsxqWGB7h0NKU3tqbpc90l/pfdgZS4lHVvdsMGWpp2u?=
 =?us-ascii?Q?cDmkUqjLS6OIsYq00KYtD2Mxy1G2Xcgi/ESPp5zGbLkUQ8+/MC27/u0FEFRd?=
 =?us-ascii?Q?IFi/yD26N5leTL8SdsAs84YjeZ/Jpnz+p8kbMQb6e6zCTbpHM/evVlTPCpSP?=
 =?us-ascii?Q?/C8EHEkHzMHsYp6u0b6WAX6LNFLIC39blPz1ZfRaK5HZmMLlj8504GVgr/Ge?=
 =?us-ascii?Q?JuhgKWGN5oQGrURPIgRrfGC8axO7Xpz7sRdClwutQPHGlPLvIb6D5ZceH7ab?=
 =?us-ascii?Q?6NNhKNFgk2Cafq8HgfNvGaHGwC4R7/H2vm8c6bKvukKCEuuzlorUCxObdKx9?=
 =?us-ascii?Q?vcaNcONpkAJ+DUX+SpxbpYpafkqBOYatps5cJc/3SdlbVeknGOsk/g5WTjBx?=
 =?us-ascii?Q?RPE9PWqdi4YX4eOKaWC0DNDstfAawMa6RpWG+qjz5n/sXMr2DiEq8VgulrgN?=
 =?us-ascii?Q?YAE8MWtaDbiExhGyGvcIDLAmTlSyuvdcgoKgJoT2ZHnwrwLZc5VBPob5o3cu?=
 =?us-ascii?Q?aan/6l9lK+1fC/+pEzdz1rmLeaArQ60ZrJlX8Nzy676oS9i6fHr5zDhFUubO?=
 =?us-ascii?Q?g89DNRS5+xbRNy13u50QuMXXHgIbBYLZdZWcUdyyWno69r5ephY/fby7F1Co?=
 =?us-ascii?Q?s8Q1ISWmRgTNTvhXgD8Mxh+70zrwwoJwmjBufbYVPEsq4OOzVDK2lygkeHlw?=
 =?us-ascii?Q?ru/2pCss+RLB3c3/0QMiUK91f5K8rJHzLKlx7YZWnfLT3R4G0QJmIXyS23Iw?=
 =?us-ascii?Q?lgZ3dYgyeXWNC/rFl2E0mKiitiDwX0QpD+CvUrNIlZ+GWzJ3eHJTaUqb8A0P?=
 =?us-ascii?Q?Yj9c4ZEPF+noQQQtvuBROLV7oCeCBp7xjA/RRPovaeCErhI1NfI808PXv56a?=
 =?us-ascii?Q?2HoOH5bjAFCOTphFuCPMW6gIq5riMp1/c4I/5Yk+2d3ME5K9/bknIQ+dzHXj?=
 =?us-ascii?Q?H1fxooG6DuOUrioo4dw3JA7mBA18/xTDbNesXimEidY5KkJdiVmW7GPmefKs?=
 =?us-ascii?Q?Z1oENKsZ8gWE7e9hPfQxc2xmrr+icWW+8Sq/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:02:18.7469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 625df70f-06ea-4ce1-9276-08ddf42e3149
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
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

For SMU v13.0.6 SOCs, move to partition metrics v1.1 schema

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  6 ++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 34 +++++++++++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 3edfdb0b2c00..527dd0c5c08f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2632,7 +2632,7 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
 {
 	const u8 num_jpeg_rings = AMDGPU_MAX_JPEG_RINGS_4_0_3;
 	int version = smu_v13_0_6_get_metrics_version(smu);
-	struct amdgpu_partition_metrics_v1_0 *xcp_metrics;
+	struct smu_v13_0_6_partition_metrics *xcp_metrics;
 	MetricsTableV0_t *metrics_v0 __free(kfree) = NULL;
 	struct amdgpu_device *adev = smu->adev;
 	int ret, inst, i, j, k, idx;
@@ -2652,8 +2652,8 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
 	if (i == adev->xcp_mgr->num_xcps)
 		return -EINVAL;
 
-	xcp_metrics = (struct amdgpu_partition_metrics_v1_0 *)table;
-	smu_cmn_init_partition_metrics(xcp_metrics, 1, 0);
+	xcp_metrics = (struct smu_v13_0_6_partition_metrics *)table;
+	smu_v13_0_6_partition_metrics_init(xcp_metrics, 1, 1);
 
 	metrics_v0 = kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
 	if (!metrics_v0)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 003672be005e..f7fb9b528a1c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -212,6 +212,40 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
 				  void *smu_metrics,
 				  struct smu_v13_0_6_gpu_metrics *gpu_metrics);
 
+#define SMU_13_0_6_PARTITION_METRICS_FIELDS(SMU_SCALAR, SMU_ARRAY)             \
+	SMU_ARRAY(SMU_MATTR(CURRENT_GFXCLK), SMU_MUNIT(CLOCK_1),               \
+		  SMU_MTYPE(U16), current_gfxclk, SMU_13_0_6_MAX_XCC)          \
+	SMU_ARRAY(SMU_MATTR(CURRENT_SOCCLK), SMU_MUNIT(CLOCK_1),               \
+		  SMU_MTYPE(U16), current_socclk, SMU_13_0_6_MAX_CLKS)         \
+	SMU_ARRAY(SMU_MATTR(CURRENT_VCLK0), SMU_MUNIT(CLOCK_1),                \
+		  SMU_MTYPE(U16), current_vclk0, SMU_13_0_6_MAX_CLKS)          \
+	SMU_ARRAY(SMU_MATTR(CURRENT_DCLK0), SMU_MUNIT(CLOCK_1),                \
+		  SMU_MTYPE(U16), current_dclk0, SMU_13_0_6_MAX_CLKS)          \
+	SMU_SCALAR(SMU_MATTR(CURRENT_UCLK), SMU_MUNIT(CLOCK_1),                \
+		   SMU_MTYPE(U16), current_uclk)                               \
+	SMU_ARRAY(SMU_MATTR(GFX_BUSY_INST), SMU_MUNIT(PERCENT),                \
+		  SMU_MTYPE(U32), gfx_busy_inst, SMU_13_0_6_MAX_XCC)           \
+	SMU_ARRAY(SMU_MATTR(JPEG_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U16),    \
+		  jpeg_busy, SMU_13_0_6_MAX_JPEG)                              \
+	SMU_ARRAY(SMU_MATTR(VCN_BUSY), SMU_MUNIT(PERCENT), SMU_MTYPE(U16),     \
+		  vcn_busy, SMU_13_0_6_MAX_VCN)                                \
+	SMU_ARRAY(SMU_MATTR(GFX_BUSY_ACC), SMU_MUNIT(PERCENT), SMU_MTYPE(U64), \
+		  gfx_busy_acc, SMU_13_0_6_MAX_XCC)                            \
+	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_PPT_ACC), SMU_MUNIT(NONE),    \
+		  SMU_MTYPE(U64), gfx_below_host_limit_ppt_acc,                \
+		  SMU_13_0_6_MAX_XCC)                                          \
+	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_THM_ACC), SMU_MUNIT(NONE),    \
+		  SMU_MTYPE(U64), gfx_below_host_limit_thm_acc,                \
+		  SMU_13_0_6_MAX_XCC)                                          \
+	SMU_ARRAY(SMU_MATTR(GFX_LOW_UTILIZATION_ACC), SMU_MUNIT(NONE),         \
+		  SMU_MTYPE(U64), gfx_low_utilization_acc, SMU_13_0_6_MAX_XCC) \
+	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_TOTAL_ACC), SMU_MUNIT(NONE),  \
+		  SMU_MTYPE(U64), gfx_below_host_limit_total_acc,              \
+		  SMU_13_0_6_MAX_XCC)
+
+DECLARE_SMU_METRICS_CLASS(smu_v13_0_6_partition_metrics,
+			  SMU_13_0_6_PARTITION_METRICS_FIELDS);
+
 #endif /* SWSMU_CODE_LAYER_L2 */
 
 #endif
-- 
2.49.0

