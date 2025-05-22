Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E1BC54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 09:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95E4910EC1C;
	Thu, 22 May 2025 09:17:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="46zlnE1m";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C69710EC1C
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 09:17:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkrXFpvCva3x9ThDB8/++Q5XLw2fjCeskDSD+uEQ99rTMGnE4zQeL0Q8ze82HwpNWc41SehnMuBD7U9U1luu/3FAf/5wuZOxPClO3OKYCHYdlKa/gM6YmOyORL+yazFei0mjF6c7lkRD64Dr5W9E1FnQkmxEAdbWNXr41btp+FzHaqanMw/Z1yBc66yIH188AmpOzfqa3J8i8yAddyXUQvODRUjGigL88jylMCmQ0qTvAHksDCslTjWtLuMlY+Xet9HfFsNWoJE5lilxKFtG3P6hhXbvuz1788Ll83aTsbHasu9A4Whm8QFdW/hRF5RA64O5OFC3p34mB3qBn9o3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nR03KF4CBUf1o6ieRQmNpNluKTey+xojrDFvUHU8598=;
 b=vkTOU6qh6Ze/pVS10xIp3m/Wb0sNp4BgkgE939GBzKHlxJPac6nqt655BsjjJpW4ceLqSZU1d27UlqnXImzdqoBRwfI/hHoHkOiu6Dc3yvOmFmnh8GxVnh+/TLs5ZFU97kDzfgfS0C4mYgFWFvD5Os31QOJ9coKgEm0insgg6DF2nb3Sz8LvM35icEdIvjCeri8XHqIq3TbUlAoDwAKYrwIjuH04eS0H+ZepBIxdOMm5a34vzf2U2M9rx3D6Gva8M6Z01zF5I46oPQzXSbLWhLOLFmC8S8rzJj0s527QfpD6eMqMFrK/YpC4qbP6jan42/1G9Ti2mG7H9+RXF1esdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nR03KF4CBUf1o6ieRQmNpNluKTey+xojrDFvUHU8598=;
 b=46zlnE1mp1H+ijzW7ZfxD2yQcy3Uk3HJkiw7Lf/ntKagL5hbjmdqUJ6CgjnzH2/+KGl2UTuJZUFy2JckY3X+Voz7IlyX0EA0LDPhb1aCBR6AXZd5z/w9XXECXe+GuJtdTUr0gJr+46QaQmlcPmKqytiOWJOd6wOtsRFU/WkYDK8=
Received: from SJ0PR05CA0049.namprd05.prod.outlook.com (2603:10b6:a03:33f::24)
 by DS5PPFEC0C6BDA1.namprd12.prod.outlook.com (2603:10b6:f:fc00::668)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Thu, 22 May
 2025 09:17:02 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::aa) by SJ0PR05CA0049.outlook.office365.com
 (2603:10b6:a03:33f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 22 May 2025 09:17:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 09:17:02 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 04:16:59 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>
Subject: [PATCH v2] drm/amd/pm: Optimize get gpu metrics data function
Date: Thu, 22 May 2025 17:16:41 +0800
Message-ID: <20250522091641.716955-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DS5PPFEC0C6BDA1:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d3e127-c5ed-45a2-7c79-08dd99116998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xly2K04xgf2xn6d08OZ40PktNK4ewJSytRjTMxpWypzJnLumDkzjSzJHIEfR?=
 =?us-ascii?Q?24rd3Rg2DtsonS1T3CiifxmGben39NiMqgGtcVH0+aWo8WBgZmMIH0DMNEuO?=
 =?us-ascii?Q?kTqo9u56/+thgbLtcSU5KJ4ptQRy3De28UyAHgcrYhqglghCVEbfecWx2Sic?=
 =?us-ascii?Q?/M0iNDBkCVfNdyKLLwn29bfrBwU8X1ipXBzBIZgLX2qmvx0WBRo2aZZu9HC7?=
 =?us-ascii?Q?lDyjbb1Z4qpeXAkbJU5y1NLQbjPERbLKgJcVuvFCBhVCqHva1GakPphZvEU3?=
 =?us-ascii?Q?cKzEVxupJ0VYbSTQ8pcP5lPHWdC28rkFZGs64S2Y1/tCIEjxfJRwYoF80iTH?=
 =?us-ascii?Q?lKTlWCFqBK0dMcr2KMIk4ODVHrV/7QWYwiX8MsTbR01CYiezRTzDx0sHCgvm?=
 =?us-ascii?Q?eND4d+WUbuc7Xa5X+pWIlOf4lR5Cc3fE7I72mAUJnUl4VG/Ih2hVt41QYJ9e?=
 =?us-ascii?Q?cZD2wqDg2uwyEqy03eKh4Bb7rIoU82XD8sUzmKnTmoVVsEmASBcQomuR7cej?=
 =?us-ascii?Q?qk3Zb2SCA6YzNxTMjkClyJ7QdBB/ZneCvCTGi7OCzkW+IOflVK2ze8Uqn+Di?=
 =?us-ascii?Q?3J9DdPyeMvwpc+mKodpAUvJUPG42jtL7EaAoHriXb9hpvZo8rVmIF9Dg80AP?=
 =?us-ascii?Q?jRG+yZWzeuzg6CdFNtaozDaMNCnqpTsYkg2NPofDYv26W2OqGKVp700Y/4w9?=
 =?us-ascii?Q?MS5ZwECVaQa0o27LjIjL//WNRwXbK1BIu925qdOxBpvNipddzJ6kb7RQscCC?=
 =?us-ascii?Q?9VkutHS+mwu1PTej48/7k75O5inBQsCyTBTXGla9tElXmLvQu7e8wx7moszC?=
 =?us-ascii?Q?V1ef1K7+qSz2j2wU9O5Ts1Ij515kGcwT2ri7ETrP/qK90AHIQTummXKL8z16?=
 =?us-ascii?Q?c1tjlJgXlopsu7jsljxTF5aySmzEG0uSaIRV+hQ8FOJPOLO08O597oPkqliE?=
 =?us-ascii?Q?4sx+a7mGsaSx/Wigsxpu8vwm4PcRtKVrP658QkAB4x0Busm5jE0pUB+9IR7x?=
 =?us-ascii?Q?JMvQNb45oTvn9/IwkEZIb4KXWy2u3WIFmo0Xxbx6OI02Tkj3pJ0Jen6zHhP2?=
 =?us-ascii?Q?8XUa0/fmFBWbyt0X/CKMOp9Fz5PP3NwWIzbZjqDcrzsxk1XxQlRA9aDtfkId?=
 =?us-ascii?Q?n5H7VHIe7jhG0lzDzhUP8c/Ba8cHaWuzhiDNnP2PtwsYo4CVhtv2anjaffHt?=
 =?us-ascii?Q?pQAZ9HG//MMiSlI5M9nzkt+y3Y7QZmLXcjZ7zdDhVpPSlTwENe6j69hjwIzQ?=
 =?us-ascii?Q?JCEFXu4Px2b7+Tz5LBVJc2xKAevpzqt898SAMws7vO3yXSmqQkrhw/b1VkL5?=
 =?us-ascii?Q?03HyOJ4hJ+LmNIagi0Fu+UDJ10YMhVG4YJUK5jEpkoRlTOJ2oaD1cKFLmQdy?=
 =?us-ascii?Q?NuGTa6kVH/M9STB63OlZq5eBHSDijAbtZ+DCCXT1rCjMO84/Bzl01qAt2/Xo?=
 =?us-ascii?Q?cFeMRbMJBqVVPBh+PHZP04Or+U8MLADvT3nRTtuxAXTUmqhEEONihaEkxxZY?=
 =?us-ascii?Q?2cSqnXR4wVzvbp4T8T2WIQdxksrwhdSf830b?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 09:17:02.0315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d3e127-c5ed-45a2-7c79-08dd99116998
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEC0C6BDA1
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

Optimize get gpu metrics data function for smu_v13_0_12 to
allocate metrics structure only once

v2: Free and alloc moved to same function(Kevin)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 6 ++----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 8 ++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 5a8824cc1c63..411756a2e79f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -322,7 +322,7 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
 	return ret;
 }
 
-ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table)
+ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table, void *smu_metrics)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_8 *gpu_metrics =
@@ -334,8 +334,7 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table)
 	struct amdgpu_xcp *xcp;
 	u32 inst_mask;
 
-	metrics = kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
-	memcpy(metrics, smu_table->metrics_table, sizeof(MetricsTable_t));
+	metrics = (MetricsTable_t *)smu_metrics;
 
 	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 8);
 
@@ -477,7 +476,6 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table)
 	gpu_metrics->firmware_timestamp = metrics->Timestamp;
 
 	*table = (void *)gpu_metrics;
-	kfree(metrics);
 
 	return sizeof(*gpu_metrics);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 78d831c20768..22dd3cf5a28d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2660,6 +2660,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	MetricsTableV2_t *metrics_v2;
 	struct amdgpu_xcp *xcp;
 	u16 link_width_level;
+	ssize_t num_bytes;
 	u8 num_jpeg_rings;
 	u32 inst_mask;
 	bool per_inst;
@@ -2672,8 +2673,11 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	}
 
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12) &&
-	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
-		return smu_v13_0_12_get_gpu_metrics(smu, table);
+	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS))) {
+		num_bytes = smu_v13_0_12_get_gpu_metrics(smu, table, metrics_v0);
+		kfree(metrics_v0);
+		return num_bytes;
+	}
 
 	metrics_v1 = (MetricsTableV1_t *)metrics_v0;
 	metrics_v2 = (MetricsTableV2_t *)metrics_v0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 1ccc150882eb..253c1cf9f386 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -80,7 +80,7 @@ int smu_v13_0_12_get_max_metrics_size(void);
 int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu);
 int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
 				      MetricsMember_t member, uint32_t *value);
-ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table);
+ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table, void *smu_metrics);
 extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
 extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
 #endif
-- 
2.46.0

