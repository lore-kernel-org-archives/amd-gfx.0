Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B20CF9C6B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 06:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83B6210E4D2;
	Tue, 24 Sep 2024 06:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MJ9h3Wtv";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FF6910E4D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 06:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRVxVD0Bcl66LgAuD9sULnan9CwONS+8ZoTotaXz9hGmSfI/ZgztpqYuN9O5J666HFFUdVQr22jgVpY4Oy1/E/1XkpMw5zMyqWCWgTrQo2Xe+enooGJ5M0+t+XuDo0xzKqma4YrqEmPbOMo0RdZJX5Ud7emVwfsWnw6B6leBTsnLqgv+UJwkB0QhcHj1WSd4vQO21H/V7AOVUKz88tLdqJ2jOW1RKuL8Ggy+FK/1jd52juaRkAIU8xHZtiI4ljSZbGh7qGwXQMB2iKmZnIBG/J2q4b/7BvmMlwA+chUa0Yum+uqa5cglVLh7QOxeeY7PdZVoz+AXhwjcsC+Zg5x91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syjV07dJ3JuLtnQBfiN5ZKchxHT1qq6XrVdhlvv0Ck4=;
 b=ZrkTsYeqnRYlCrVVY9sNX4siK7iD3d+7JWQzYRvbdasCcevngJjmw6IWdsqELxVINRgd01/dArle3oFlDUQBvDnBRMVH+VMiqfS6b+5Xr2VP4xT1WMvIHMB9bywNfVMC5em+7waZrvKKkcZDrmq6Zrjovcy6DbF0VFNqyMEJcBYhF1uIcJxe9v6NNEbwQqo+/euuj8zW6Rz/2bWvekzuMJsv0E5zv0ywrI5BGRtwieZY7G2xLAWBXTcTQ9SO12vGF4IdxvyHLhEtYsMU4N/O/rxCSd/2WgJ4Rqexz2S4VSWo2HQJN4x+xQai8ZEggbfnrjbkPoGvUt0igu7JawmZpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syjV07dJ3JuLtnQBfiN5ZKchxHT1qq6XrVdhlvv0Ck4=;
 b=MJ9h3WtvGVxLy4SxJf1EfPaJ3y+fvUZqu8792R0PqkiM4RNqrzX9eeJfi8RY7GqTlro7iMlHkSXvKZKzO6z4Kgk/3FIrL5xTHuU0UjPuLswp+Sb4YdApHCtXdrF0RjA5GQnptcDf3jtgG+zYphc8AkThuTTDKit/Q1jXjCuVg38=
Received: from BN9PR03CA0770.namprd03.prod.outlook.com (2603:10b6:408:13a::25)
 by IA1PR12MB6114.namprd12.prod.outlook.com (2603:10b6:208:3ea::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 06:03:11 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::10) by BN9PR03CA0770.outlook.office365.com
 (2603:10b6:408:13a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25 via Frontend
 Transport; Tue, 24 Sep 2024 06:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 06:03:11 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 01:03:07 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Vignesh.Chander@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Fetch NPS mode for GCv9.4.3 VFs
Date: Tue, 24 Sep 2024 11:32:49 +0530
Message-ID: <20240924060250.2678600-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|IA1PR12MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 794c7879-cccc-491a-e0fe-08dcdc5e9216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3pN9eBC9nrDkOlNqD9pL6wI/IFEl/zhmrnZBVHD+fgSwf+i9O3FPnjKVH7yM?=
 =?us-ascii?Q?evPRoKuihpocWdSDkxKwiF41n/6DSNCg8Ic+75zyDbZrTChEggLLszMB4qr6?=
 =?us-ascii?Q?DZkAsx2LSQemT8VA80RW2prAWPHiX8UGYZ0J2TON3yEU03ihfSdk0+yJ3M4J?=
 =?us-ascii?Q?X6IWS6zTl50ut9T1SaFh4ChNv226ZuNjSHbZiBfFmmiSs9dF7m9mneVtMSkX?=
 =?us-ascii?Q?XPTrDk3dfhEmRrEbzhJvd2pCif6dU9n8qw1N+nBxqUkjoeYdLBu5KfIoX3/4?=
 =?us-ascii?Q?r13E0JkKRsAuhelgd/7UrcXZgo6a6NWZHDrF551JCxfbitM0TwxsxO/szvbZ?=
 =?us-ascii?Q?dX7Lpk15GAS5q2rnKyidxrvbda1l0qy8d1l2DcGQYtM2rmSqseCko2OuMoiD?=
 =?us-ascii?Q?40gW5GFV1YS/1tMmhYA2iwtw3ev2IeAcuVqbmgg270MFSdLDZS5X0SVPRH21?=
 =?us-ascii?Q?V+p9H2XHl1EldSqca3TShoqt7UKX/J/L2z3Le6NVwdUEAPzp+sds6Y7AnphB?=
 =?us-ascii?Q?DgkBSGCmIIemcsxJMTE6+kmnXZzcx7kHI5CnvSxtCq2p95Dgr+VX+dMh8J33?=
 =?us-ascii?Q?3PkFHp47xDKoz/bvrZ5lDEUqlBFS5ajZk4lsUsXD5gukwrVSMRI/hCLzaYCc?=
 =?us-ascii?Q?vON2hTIA0yuzdwy/gRQsOGX86i++oD1f+AG8u8NcJkIJOJ5K2MWeP06Jg0yI?=
 =?us-ascii?Q?RJrUochwNA3GutZjhX10YflKRDIg46Dv12eP2s5WRF/tO20Zc+gtelqkm8S2?=
 =?us-ascii?Q?+DcBfl1nT5vMJj3fT2yGgLvELyYJi0l7YrtRFbvFPWEwuzYONwDVjVA7+Qsc?=
 =?us-ascii?Q?bQf1dwC24jUcn4MrmB2F7ee0zxMCB0P24TQwZevMhDEJJJKyW/qZzqtqREv0?=
 =?us-ascii?Q?VjNHcPXADyMSN3elcKASScHQuEE2kDCHlQBvTqcxvEtD8ONH8lMaJxEjr/Kc?=
 =?us-ascii?Q?3CQ7+KcbsvV9cBbe1JFfJHq354/WjXecYPAe2/Zzagwp8euIMmNB2lUpDcPd?=
 =?us-ascii?Q?4ZyPV6zJoBdrZ2B9VoKnCC/lmLWSYhEFhy3lkjox5o49rijxesIL1O2lrfPj?=
 =?us-ascii?Q?Je5Ey0XcZ0IAgipeFlmMjqdR3gBpRAcM0lU1byIlhaNcacJwCWbs4UZaF1rX?=
 =?us-ascii?Q?3xZVYzvPDybw+1CKtbQ0nn8KZPskBb1qSlFx+fSsLQMXjR3wFEOLVSyzOihg?=
 =?us-ascii?Q?Xw09+Ef9/H5XavpoBzo2GM4miWDPwB7etUE0iUMH5dOnsLINtI8g/x+Yd6gM?=
 =?us-ascii?Q?GYpWMunWh00Q7IHN1Y0g21yW8Myg+JT4YswFyEc51t8DKPPdlY297SSgsFnJ?=
 =?us-ascii?Q?SLLp7NUY8DtfU7pmyxwtLDwrldnF0EK8JuzGq9NrwqWU3/LPKUC5eFNyHt02?=
 =?us-ascii?Q?ICemu9VK4S4ZSKdMc1YU6fS/5Bvetv5OVK9kS7x/ttRqTA3rszknZXTFeQPz?=
 =?us-ascii?Q?ChfQBnrJG9UHVn5O5pe7KoXhMM75PZzZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:03:11.4527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 794c7879-cccc-491a-e0fe-08dcdc5e9216
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6114
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

Use the memory ranges published in discovery table to deduce NPS mode
of GC v9.4.3 VFs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 30 +++++++++++++++++++++++--
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 011fe3a847d0..4d8d229ca457 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1256,14 +1256,14 @@ void amdgpu_gmc_sysfs_fini(struct amdgpu_device *adev)
 
 int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 				 struct amdgpu_mem_partition_info *mem_ranges,
-				 int exp_ranges)
+				 uint8_t *exp_ranges)
 {
 	struct amdgpu_gmc_memrange *ranges;
 	int range_cnt, ret, i, j;
 	uint32_t nps_type;
 	bool refresh;
 
-	if (!mem_ranges)
+	if (!mem_ranges || !exp_ranges)
 		return -EINVAL;
 
 	refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
@@ -1277,16 +1277,16 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 	/* TODO: For now, expect ranges and partition count to be the same.
 	 * Adjust if there are holes expected in any NPS domain.
 	 */
-	if (range_cnt != exp_ranges) {
+	if (*exp_ranges && (range_cnt != *exp_ranges)) {
 		dev_warn(
 			adev->dev,
 			"NPS config mismatch - expected ranges: %d discovery - nps mode: %d, nps ranges: %d",
-			exp_ranges, nps_type, range_cnt);
+			*exp_ranges, nps_type, range_cnt);
 		ret = -EINVAL;
 		goto err;
 	}
 
-	for (i = 0; i < exp_ranges; ++i) {
+	for (i = 0; i < range_cnt; ++i) {
 		if (ranges[i].base_address >= ranges[i].limit_address) {
 			dev_warn(
 				adev->dev,
@@ -1327,6 +1327,8 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 			ranges[i].limit_address - ranges[i].base_address + 1;
 	}
 
+	if (!*exp_ranges)
+		*exp_ranges = range_cnt;
 err:
 	kfree(ranges);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index d4cd247fe574..94cb4f94f43d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -467,7 +467,7 @@ void amdgpu_gmc_sysfs_fini(struct amdgpu_device *adev);
 
 int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 				 struct amdgpu_mem_partition_info *mem_ranges,
-				 int exp_ranges);
+				 uint8_t *exp_ranges);
 
 int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
 					int nps_mode);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 6a95402985ef..eb82d78c4512 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1386,11 +1386,30 @@ gmc_v9_0_get_memory_partition(struct amdgpu_device *adev, u32 *supp_modes)
 	return mode;
 }
 
+static enum amdgpu_memory_partition
+gmc_v9_0_query_vf_memory_partition(struct amdgpu_device *adev)
+{
+	switch (adev->gmc.num_mem_partitions) {
+	case 0:
+		return UNKNOWN_MEMORY_PARTITION_MODE;
+	case 1:
+		return AMDGPU_NPS1_PARTITION_MODE;
+	case 2:
+		return AMDGPU_NPS2_PARTITION_MODE;
+	case 4:
+		return AMDGPU_NPS4_PARTITION_MODE;
+	default:
+		return AMDGPU_NPS1_PARTITION_MODE;
+	}
+
+	return AMDGPU_NPS1_PARTITION_MODE;
+}
+
 static enum amdgpu_memory_partition
 gmc_v9_0_query_memory_partition(struct amdgpu_device *adev)
 {
 	if (amdgpu_sriov_vf(adev))
-		return AMDGPU_NPS1_PARTITION_MODE;
+		return gmc_v9_0_query_vf_memory_partition(adev);
 
 	return gmc_v9_0_get_memory_partition(adev, NULL);
 }
@@ -1935,6 +1954,8 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *adev,
 
 	switch (mode) {
 	case UNKNOWN_MEMORY_PARTITION_MODE:
+		adev->gmc.num_mem_partitions = 0;
+		break;
 	case AMDGPU_NPS1_PARTITION_MODE:
 		adev->gmc.num_mem_partitions = 1;
 		break;
@@ -1954,7 +1975,7 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *adev,
 
 	/* Use NPS range info, if populated */
 	r = amdgpu_gmc_get_nps_memranges(adev, mem_ranges,
-					 adev->gmc.num_mem_partitions);
+					 &adev->gmc.num_mem_partitions);
 	if (!r) {
 		l = 0;
 		for (i = 1; i < adev->gmc.num_mem_partitions; ++i) {
@@ -1964,6 +1985,11 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *adev,
 		}
 
 	} else {
+		if (!adev->gmc.num_mem_partitions) {
+			dev_err(adev->dev,
+				"Not able to detect NPS mode, fall back to NPS1");
+			adev->gmc.num_mem_partitions = 1;
+		}
 		/* Fallback to sw based calculation */
 		size = (adev->gmc.real_vram_size + SZ_16M) >> AMDGPU_GPU_PAGE_SHIFT;
 		size /= adev->gmc.num_mem_partitions;
-- 
2.25.1

