Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86E1CAC5A5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 05:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9E910E11D;
	Fri, 19 Sep 2025 05:45:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gn1Rrl01";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD18910E11D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 05:45:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SW314iyVObJWUNFZu6Equ2bGtmnVh3KhmykO6ijkpx/fOepB/NYowhlGMbvN3p8gvAv7APVToB1yGOvAtDWQ71MA28SMn0eJuxrLoMoOjso+PmeWPMkHuWmUYTabw7ipAACUsrMoUeUbK524fAf89vsBj4pLxbQzlh4eP1bsiIYG00sWJYFNoWwcoJUEqD91ejRk84RkJtZ2TRtBSclV1LLw+4wnNuaLFcOzdsIJ6AWB2Ww39kZdvooJ0r6/m3KV6hAyFXdlXTVNaUPtBGumg5U9gtfkcF0NNTZ+xKAR3HhmaaurhF4i3JdOEHUc97Mc/hqJW0aNUra/hXHdUu771w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEFoL8YBtFJHPM6Z1rtogaIqvpVf8LZoYHj6VslMAMo=;
 b=i6voLm2NdJnzgDoikSSrW8LgcSMag49ep7rHSUgvmtAkhK/rxxad4th2khIhpC1Ai+ndBz4jTOZQlcmQWL70qEcp4UBSalO9RcvMJvMvY2KKvn70DWqDJ11avfFoCcFVWtsi5xyF4B7g/mwXID6IZT/JBw67uSvAUnTFERugtmFhFta6KcEXDJSiaZpGricxdauZ/3lJe4foVCW7gZ23H/swBQ2c2Q0bGonkbBVwW5YAZF0sPUmLeAcThLUTlqTeFtIXb10BTxzjPv3ap0XRTz41lDZwnTrS8c2ZLK4Ilmvp9NIe6mCcNCA5dFator+mKcSxuV/Z7wnICL9Df1jfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEFoL8YBtFJHPM6Z1rtogaIqvpVf8LZoYHj6VslMAMo=;
 b=Gn1Rrl01O9k8yFmXucBh1JzfHFR+tqsUHrwKiu8uZEo3qKLiXB87fmOspVUNunig5imASyXAdBLfSeerZ009qy3keXJhYNRqXJvknyonKa7CjCce2PCjpyh/pKUVRvEFhiLwnp7u3U24clCHbVXHlTWTtUvM94AQ+6ZzMFIsdC4=
Received: from SN7PR04CA0036.namprd04.prod.outlook.com (2603:10b6:806:120::11)
 by IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 05:45:02 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:120:cafe::5d) by SN7PR04CA0036.outlook.office365.com
 (2603:10b6:806:120::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.15 via Frontend Transport; Fri,
 19 Sep 2025 05:45:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 05:45:01 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 22:44:59 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Avoid interface mismatch messaging
Date: Fri, 19 Sep 2025 11:14:39 +0530
Message-ID: <20250919054439.3115476-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|IA0PR12MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b736b1a-ab2e-4e9d-f7ed-08ddf73fad27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p8sboN317dFY7eeuq/VnM6CCT/almL8SdqT2hf+XbJVZWoBKsOcRoc6JnLpm?=
 =?us-ascii?Q?OGMLBTX/igKZvCjv5uLzTJwjA6tgu/l5KF3xa7Pn3y37Mbz4euedweAJdDDy?=
 =?us-ascii?Q?TKHp/zvlbV5hoO9CFZ9dEyaJ48nAtvKTA5SCmewUIWW31F1ZgdzJfNiu2+Yy?=
 =?us-ascii?Q?aIwHe52IYjkC6hVf9bctNHC2o22vNZkQg7nmU5+7QNyCkYkgd/4yBIOngUEO?=
 =?us-ascii?Q?9M2+NbtS1PetrpYaq1qo2S39or9mS+vg8LwjzeYKheEiboXBUx1KGFUXpMVq?=
 =?us-ascii?Q?sd2AofdFo/URD7lVf6ppy5Spq06K/uWrBoK435Ejsy350/qrOpAxw2SiYP6Z?=
 =?us-ascii?Q?8cCnGvO881Ub/d/zAHx9L/Zde51ZmKOq/aE5XL+NgTYCSkETbAorvf8hqG+p?=
 =?us-ascii?Q?/EKwn1X5KDrdVeIGOUQ9uqDG6fMZq5qnkNTFvJ3c5f7h+06/mLKuQ4fteBq+?=
 =?us-ascii?Q?sCjbaJxpOJ13Tyzmb4x6JhIFwoaJ29KQutji+VCIn2SajHJhuz+PZsa49ec8?=
 =?us-ascii?Q?y8Sh0JCNdrmIp3dNDiWyGsuNsOW8Y9YWbuV5FEb5QILJ3o9LA+GVwwuw2xPc?=
 =?us-ascii?Q?1J56iHl+ajyPbbFscl1jhXDBVsRMwvS4q6lwULjD0pmXaFN3prNzCp6bSo0p?=
 =?us-ascii?Q?FbLaOSWytzGsCemYozkXQh/Bcoy/yKbMRzbTWYuwDraw1gPViT+RJWiZUWSC?=
 =?us-ascii?Q?WRDMtA7P7zEwKcSfOErawpPiiEY0zdL2Az661hH0gnRxbLR6/FtW4mmJY7WC?=
 =?us-ascii?Q?k/Ja71jud9tFsBEpxbnzjUXPDZsDIMB1BCPPs/g/AvS66jyy4gx/m2/s/ZJb?=
 =?us-ascii?Q?XyqZIPBYWWyEMwDqOUzxJFsLCylLYDK8l02AHgcJLy08jxSeWISMx9ICtWex?=
 =?us-ascii?Q?9S/R6BetZRKejjtmLBxwBImptCO/WnZQa5fd9JfBaFKUonwR9jbZYU8tG/OD?=
 =?us-ascii?Q?0E1n4lFUFL9Mku2IGOv2wLws3gWvGKfJJx1gRyM8viKIvJCAf/MrYTVzYBY/?=
 =?us-ascii?Q?Ju50BDLey4x/vXOzF3wvTi78MJSnyRJncZnuEiqI/uNnDmiWzVDeyUp+oQr8?=
 =?us-ascii?Q?70WZO/79hdst0ljkheGCxcWOeMnhTWCqw8lQueO4B51ESaTrHFMuc+BDpLnz?=
 =?us-ascii?Q?QwmK8+MCy5WugDPKJWtaQMSGDb4uRQW2ElLlNfvCe2tK+kIVLZUlD8/9vwq4?=
 =?us-ascii?Q?g7MnRXsff/NPMyoFnlY0Ibm6tdTKaJ3faHwQSb5YSYhydSJKISdYLs99Moo0?=
 =?us-ascii?Q?lLmDXZQNp5D9TkvIpSUe0Px9UXZJ7X65i9bRoTkXEKwugzXWp7ck/uZrQAXq?=
 =?us-ascii?Q?rHfpzjdvecP+j08MBdFkdcpsAOlDJjMti0UunOu05BpR8Zk1b17YXmhV8GGB?=
 =?us-ascii?Q?zVbe2uowFjdDrKlTdfV58eh3Wuyl/pWolXvwN75AEnxbKGe+EPG8mGkKeib7?=
 =?us-ascii?Q?8wQLHwpsP2fXWU+mrN1pBL8eiC6f3CrrFwC8tN9y4jx7H1TPtm1Gz/jXa4HZ?=
 =?us-ascii?Q?A0W25iOCetoVAAkCT8Yv6jdrVsV6tHYGYIh/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 05:45:01.5861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b736b1a-ab2e-4e9d-f7ed-08ddf73fad27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556
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

PMFW interface version is not used by some IP implementations like SMU
v13.0.6/12, instead rely on PMFW version checks. Avoid the log if
interface version is not used.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h               | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 1a1f2a6b2e52..a89075e25717 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -288,7 +288,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	 * Considering above, we just leave user a verbal message instead
 	 * of halt driver loading.
 	 */
-	if (if_version != smu->smc_driver_if_version) {
+	if (smu->smc_driver_if_version != SMU_IGNORE_IF_VERSION &&
+	    if_version != smu->smc_driver_if_version) {
 		dev_info(adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
 			 "smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
 			 smu->smc_driver_if_version, if_version,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 349b6b8be010..062f92635215 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3930,7 +3930,7 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
 	smu->feature_map = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12)) ?
 		smu_v13_0_12_feature_mask_map : smu_v13_0_6_feature_mask_map;
 	smu->table_map = smu_v13_0_6_table_map;
-	smu->smc_driver_if_version = SMU13_0_6_DRIVER_IF_VERSION;
+	smu->smc_driver_if_version = SMU_IGNORE_IF_VERSION;
 	smu->smc_fw_caps |= SMU_FW_CAP_RAS_PRI;
 	smu_v13_0_set_smu_mailbox_registers(smu);
 	smu_v13_0_6_set_temp_funcs(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index d588f74b98de..0ae91c8b6d72 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -40,6 +40,8 @@
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
 
+#define SMU_IGNORE_IF_VERSION 0xFFFFFFFF
+
 #define smu_cmn_init_soft_gpu_metrics(ptr, frev, crev)                   \
 	do {                                                             \
 		typecheck(struct gpu_metrics_v##frev##_##crev *, (ptr)); \
-- 
2.49.0

