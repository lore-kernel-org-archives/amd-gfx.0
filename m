Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B021AD29C37
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 15:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5850310E4A8;
	Mon, 19 Jan 2026 15:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HeXkF1P9";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00B1110E4A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 15:33:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDSVWB3dmuuWK84M8LECAb9+c11I5a4jXC3PiScEgTZxiEV1RSBjwCgNmdtWkP6uDDVwZ/3WYTw6gLkkHb6e0bQmUhYXrh8OhBTydkihKMYO66ECX4phFRmUswxT2sy+k2mpJxBaCas2kXh+tem6Cb/ND2ZkH4obTYNe7MV3joYnI5Xvb9c8rOj8j+00njT2SxEloK802wEU5r4Q7zbRjIH4UShZp0iuw9pu0UtHBm7nTWIsUE4xVcE+JtcEE+T66XrNgfMuKWizo+e709u9LYAWqaNgX4M5+NIbEcV6Y17145cJR0t0ILQ26k4mdey2jngQ4MjFLzyXUhpwua0E/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgzWEXEOWMZxIFjFdLMif+XtxzCc8jgZ4Vd9fX4OTCo=;
 b=qj57DXHjq/g+GWRWPsuYpxmPa2/VeX0hnYW2BoT+XtxwS1LXRq9+HHiwKbQS3QRN1x/UUX/PK6rRsYgYVWkmUAEqjGBnMArlbg0GpJCI3AgkCMZltlJ3khUmyY5D8Q4zzpB9YA7ed79bom7kBiPz/FOROkPv/LoGZJ/6uDrtPIn1+yGd5T0Yjn9MATwJxEq7FIYg+RIpwAcHre9b0A5tSqsRvdoFFJxFUURlt+783hTl6WET2GsGAECHo9SHfQbkPyAv5ZO/mhamMXdksuvx1WWin2HAr7ZI0jdrEh/qe2caEKuRPgKyVB7gf2dxMG3CLjMXyROqFGbzZ+bf/6j6Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgzWEXEOWMZxIFjFdLMif+XtxzCc8jgZ4Vd9fX4OTCo=;
 b=HeXkF1P9UCtjoFgZbe8F2D7SPbLL7okmLtfZOGcv02e/r4QKDfNri3aeTlWXS7n9knJZEVD1WUnpI37yIX8YBXau/GqUdW8SOksanTBQ+paLpX5zVX0nbGPV66JliHx9Nil568EF1guMLLbF4n/DVaiSbig1wpPz3NBaaUhP4Os=
Received: from MN2PR20CA0063.namprd20.prod.outlook.com (2603:10b6:208:235::32)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 15:33:40 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::c7) by MN2PR20CA0063.outlook.office365.com
 (2603:10b6:208:235::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 15:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 15:33:39 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 09:33:36 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 2/7] drm/amd/pm: Add smu feature interface functions
Date: Mon, 19 Jan 2026 20:58:19 +0530
Message-ID: <20260119153309.1234663-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260119153309.1234663-1-lijo.lazar@amd.com>
References: <20260119153309.1234663-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: febe0586-a889-458c-2405-08de57701ea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ej3DKdwj2c3ll/ElHAg2Ddi6Ih+pHWW5hwC7zUKGYNbCaG00Buv+i+UPyUP8?=
 =?us-ascii?Q?LqZ3UmD7E0KZUkcmmI2h3Bm0xDj722AQsqZILq7HMsuxaLTCeZIMnD70O++7?=
 =?us-ascii?Q?3keyU8cCtcecY68pKAb2xhS3c36JOBceM/tZUCnEAYXb2fijSbnb4FW3KTrl?=
 =?us-ascii?Q?iVL6E9vYR2/fnVscpygR87zwBhbd23gv4ziG1QTl20yrchsaj2O14zumrL5J?=
 =?us-ascii?Q?/iJW8xj1TnTTdgig5bfFj4UyogNXYaLHGnziD1901uENjCEbYoTaTRZbDGY7?=
 =?us-ascii?Q?0oQwkX83WOIPISlEhVc8/KpR+XiYPQet4f1c4u22x8R199M53Zl05/+d64rT?=
 =?us-ascii?Q?ZNc2tNPNL8vL/k5WUpE7knJN919IAeuA7K1+K4bbketVfEen6o1YR9qKwIin?=
 =?us-ascii?Q?WtWMJd0C9fJDvDCpQwa7Fnbq4rE3zkNduggvKE2NVjjJgS9JuR1dh1DNWhi5?=
 =?us-ascii?Q?28p/qdEVtmVg3RcSuU/6l4sSBoj3qnRA/3N4qGZ2jhBK3Q+kK7l8bCw78Yoo?=
 =?us-ascii?Q?Ff62LbRjJONokPuaqIYQxNa8J021SIl67/GkMVvcvBn5oSRWxmCB4k5r5vDz?=
 =?us-ascii?Q?0Kf5B0Qo1Tytl9R9UkVoPhcuFovitqaOn7OfY3+JmLAMD8fL4Cn/GzklWbFl?=
 =?us-ascii?Q?4/eIk0zRwcjem7fTsUI5vl383zPTIMbV2cWcvEfikK3hm0KLE0n/lqOoZsTw?=
 =?us-ascii?Q?TwBiCCIkp9IU92L1lVL1HsRsWgAuRIRh7mQccNYIWvR70nVflZ10p8LCOBIG?=
 =?us-ascii?Q?iiyL62kGk0CpjelT/aA/eh8td+lVTKtoPPZn16bvD7IRf3lPMEQAAKWs6Adx?=
 =?us-ascii?Q?RxHgffSET4M/ShDu7wz+Ci+aW6KpzMeZETfRtXzTSNYFtzFW00pYsqWxjKpo?=
 =?us-ascii?Q?I6z6BmcYQxakopr5DO6Ve6ltrZLCqQFF3Ae6aA0sY9Ll+/i8907s8/wPPSyO?=
 =?us-ascii?Q?d5cMvoOnqCeMYAdfLmntHzyTcw4+KPaNihdUGkF7K7f6pqnJtacEc88BtHzz?=
 =?us-ascii?Q?2RKDO9ipidQrdYoDqv0tz+pDIq/l0j+OCUNjV9s7cPbHgPniQK8I51V9qk9m?=
 =?us-ascii?Q?QhVmFIp3vpO/90Gt3uk0NXlKl75/lCzUYQbHNXtcoRNTrpEKlvpxMgK422aB?=
 =?us-ascii?Q?c+pNTJz71kB6ut11pZXQQl8srhVZtXChAL9JmaeJm/Pic1vouWEHTpNH7YSj?=
 =?us-ascii?Q?kGnQo+vpNvvO2yascdFALbt5W22jyfo+gbi+GSVHBFWNCfVRGlJ+fDgazJ/Y?=
 =?us-ascii?Q?omTSUx2tAAcjNysRlBgyMmNdr/s3m2DlJGp9B+G9TE7Beed+2hRo8sKJxwWh?=
 =?us-ascii?Q?FJj+NZi6hgW5vQj/ZwSsWlp06CXjJj8sZHdSYIkC3zIfYr9SrtR2L308OE/p?=
 =?us-ascii?Q?5fs1YSpaRRYKfOrouIzGsskRtkfp/UMXxKCCmxDhaJ6Zljww7uww0eb00Nkc?=
 =?us-ascii?Q?H/8T9lLEs8zw/R6kzFAwNZLjs6X4wJgA+bzfqut7lqxvfw+z4wlI2WNrzxZ3?=
 =?us-ascii?Q?8O7w9k66aeq1OreXPBqTelpMWjsS5bF/CmWhhlY63YjnDaWpFfUpJT5sB7RS?=
 =?us-ascii?Q?3mpfTzM2zDugJixvVeBniQEwHEwtEhBV8VtbAbHO3KJv8fGvsKMar10Y2SBT?=
 =?us-ascii?Q?QKJhPbCP6Nbe/Q0TIK7L4W3X2C1TgNOVUp9uwxrPac5noEkrvLonR3HnZPTa?=
 =?us-ascii?Q?IiWwOg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 15:33:39.4784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: febe0586-a889-458c-2405-08de57701ea4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
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

Instead of using bitmap operations, add wrapper interface functions to
operate on smu features.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  20 ++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 104 +++++++++++++++++-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   4 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |   4 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   6 +-
 7 files changed, 120 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6b6b05e8f736..ccb771dacde1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -690,7 +690,6 @@ static int smu_sys_set_pp_table(void *handle,
 
 static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
 {
-	struct smu_feature *feature = &smu->smu_feature;
 	uint32_t allowed_feature_mask[SMU_FEATURE_MAX/32];
 	int ret = 0;
 
@@ -702,20 +701,19 @@ static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
 	 * such scenario.
 	 */
 	if (smu->adev->scpm_enabled) {
-		bitmap_fill(feature->allowed, SMU_FEATURE_MAX);
+		smu_feature_list_set_all(smu, SMU_FEATURE_LIST_ALLOWED);
 		return 0;
 	}
 
-	bitmap_zero(feature->allowed, SMU_FEATURE_MAX);
+	smu_feature_list_clear_all(smu, SMU_FEATURE_LIST_ALLOWED);
 
 	ret = smu_get_allowed_feature_mask(smu, allowed_feature_mask,
 					     SMU_FEATURE_MAX/32);
 	if (ret)
 		return ret;
 
-	bitmap_or(feature->allowed, feature->allowed,
-		      (unsigned long *)allowed_feature_mask,
-		      feature->feature_num);
+	smu_feature_list_add_bits(smu, SMU_FEATURE_LIST_ALLOWED,
+				  (unsigned long *)allowed_feature_mask);
 
 	return ret;
 }
@@ -1365,9 +1363,7 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	int i, ret;
 
 	smu->pool_size = adev->pm.smu_prv_buffer_size;
-	smu->smu_feature.feature_num = SMU_FEATURE_MAX;
-	bitmap_zero(smu->smu_feature.supported, SMU_FEATURE_MAX);
-	bitmap_zero(smu->smu_feature.allowed, SMU_FEATURE_MAX);
+	smu_feature_init(smu, SMU_FEATURE_MAX);
 
 	INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_work_fn);
 	INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
@@ -1656,7 +1652,6 @@ static void smu_wbrf_fini(struct smu_context *smu)
 
 static int smu_smc_hw_setup(struct smu_context *smu)
 {
-	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
 	uint8_t pcie_gen = 0, pcie_width = 0;
 	uint64_t features_supported;
@@ -1819,9 +1814,8 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		dev_err(adev->dev, "Failed to retrieve supported dpm features!\n");
 		return ret;
 	}
-	bitmap_copy(feature->supported,
-		    (unsigned long *)&features_supported,
-		    feature->feature_num);
+	smu_feature_list_set_bits(smu, SMU_FEATURE_LIST_SUPPORTED,
+				  (unsigned long *)&features_supported);
 
 	if (!smu_is_dpm_running(smu))
 		dev_info(adev->dev, "dpm has been disabled\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 017df903a7bd..2290298579e1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -477,10 +477,15 @@ struct smu_feature_bits {
 	DECLARE_BITMAP(bits, SMU_FEATURE_MAX);
 };
 
+enum smu_feature_list {
+	SMU_FEATURE_LIST_SUPPORTED,
+	SMU_FEATURE_LIST_ALLOWED,
+	SMU_FEATURE_LIST_MAX,
+};
+
 struct smu_feature {
 	uint32_t feature_num;
-	DECLARE_BITMAP(supported, SMU_FEATURE_MAX);
-	DECLARE_BITMAP(allowed, SMU_FEATURE_MAX);
+	struct smu_feature_bits bits[SMU_FEATURE_LIST_MAX];
 };
 
 struct smu_clocks {
@@ -2055,4 +2060,99 @@ static inline void smu_feature_bits_or(struct smu_feature_bits *dst,
 	bitmap_or(dst->bits, src1->bits, src2, nbits);
 }
 
+static inline struct smu_feature_bits *
+__smu_feature_get_list(struct smu_context *smu, enum smu_feature_list list)
+{
+	if (unlikely(list >= SMU_FEATURE_LIST_MAX)) {
+		dev_warn(smu->adev->dev, "Invalid feature list: %d\n", list);
+		return &smu->smu_feature.bits[SMU_FEATURE_LIST_SUPPORTED];
+	}
+
+	return &smu->smu_feature.bits[list];
+}
+
+static inline bool smu_feature_list_is_set(struct smu_context *smu,
+					   enum smu_feature_list list,
+					   unsigned int bit)
+{
+	if (bit >= smu->smu_feature.feature_num)
+		return false;
+
+	return smu_feature_bits_is_set(__smu_feature_get_list(smu, list), bit);
+}
+
+static inline void smu_feature_list_set_bit(struct smu_context *smu,
+					    enum smu_feature_list list,
+					    unsigned int bit)
+{
+	if (bit >= smu->smu_feature.feature_num)
+		return;
+
+	smu_feature_bits_set_bit(__smu_feature_get_list(smu, list), bit);
+}
+
+static inline void smu_feature_list_clear_bit(struct smu_context *smu,
+					      enum smu_feature_list list,
+					      unsigned int bit)
+{
+	if (bit >= smu->smu_feature.feature_num)
+		return;
+
+	smu_feature_bits_clear_bit(__smu_feature_get_list(smu, list), bit);
+}
+
+static inline void smu_feature_list_set_all(struct smu_context *smu,
+					    enum smu_feature_list list)
+{
+	smu_feature_bits_fill(__smu_feature_get_list(smu, list));
+}
+
+static inline void smu_feature_list_clear_all(struct smu_context *smu,
+					      enum smu_feature_list list)
+{
+	smu_feature_bits_clearall(__smu_feature_get_list(smu, list));
+}
+
+static inline bool smu_feature_list_is_empty(struct smu_context *smu,
+					     enum smu_feature_list list)
+{
+	return smu_feature_bits_empty(__smu_feature_get_list(smu, list),
+				      smu->smu_feature.feature_num);
+}
+
+static inline void smu_feature_list_set_bits(struct smu_context *smu,
+					     enum smu_feature_list dst_list,
+					     const unsigned long *src)
+{
+	smu_feature_bits_copy(__smu_feature_get_list(smu, dst_list), src,
+			      smu->smu_feature.feature_num);
+}
+
+static inline void smu_feature_list_add_bits(struct smu_context *smu,
+					     enum smu_feature_list list,
+					     const unsigned long *src)
+{
+	struct smu_feature_bits *bits = __smu_feature_get_list(smu, list);
+
+	smu_feature_bits_or(bits, bits, src, smu->smu_feature.feature_num);
+}
+
+static inline void smu_feature_list_to_arr32(struct smu_context *smu,
+					     enum smu_feature_list list,
+					     uint32_t *arr)
+{
+	smu_feature_bits_to_arr32(__smu_feature_get_list(smu, list), arr,
+				  smu->smu_feature.feature_num);
+}
+
+static inline void smu_feature_init(struct smu_context *smu, int feature_num)
+{
+	if (!feature_num || smu->smu_feature.feature_num != 0)
+		return;
+
+	smu->smu_feature.feature_num = feature_num;
+	smu_feature_list_clear_all(smu, SMU_FEATURE_LIST_SUPPORTED);
+	smu_feature_list_clear_all(smu, SMU_FEATURE_LIST_ALLOWED);
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index eb1b9faf8e5c..1d0f9f8ddf9b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -750,12 +750,13 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 
-	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64) {
+	if (smu_feature_list_is_empty(smu, SMU_FEATURE_LIST_ALLOWED) ||
+	    feature->feature_num < 64) {
 		ret = -EINVAL;
 		goto failed;
 	}
 
-	bitmap_to_arr32(feature_mask, feature->allowed, 64);
+	smu_feature_list_to_arr32(smu, SMU_FEATURE_LIST_ALLOWED, feature_mask);
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
 					  feature_mask[1], NULL);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 51f96fdcec24..d9b1725c3afc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -761,11 +761,11 @@ int smu_v13_0_set_allowed_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 
-	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) ||
+	if (smu_feature_list_is_empty(smu, SMU_FEATURE_LIST_ALLOWED) ||
 	    feature->feature_num < 64)
 		return -EINVAL;
 
-	bitmap_to_arr32(feature_mask, feature->allowed, 64);
+	smu_feature_list_to_arr32(smu, SMU_FEATURE_LIST_ALLOWED, feature_mask);
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
 					      feature_mask[1], NULL);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index f85ba23f9d99..5c991e2e15ff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -746,11 +746,11 @@ int smu_v14_0_set_allowed_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 
-	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) ||
+	if (smu_feature_list_is_empty(smu, SMU_FEATURE_LIST_ALLOWED) ||
 	    feature->feature_num < 64)
 		return -EINVAL;
 
-	bitmap_to_arr32(feature_mask, feature->allowed, 64);
+	smu_feature_list_to_arr32(smu, SMU_FEATURE_LIST_ALLOWED, feature_mask);
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
 					      feature_mask[1], NULL);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 6557085a7c72..d77eaac556d9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -715,11 +715,11 @@ int smu_v15_0_set_allowed_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 
-	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) ||
+	if (smu_feature_list_is_empty(smu, SMU_FEATURE_LIST_ALLOWED) ||
 	    feature->feature_num < 64)
 		return -EINVAL;
 
-	bitmap_to_arr32(feature_mask, feature->allowed, 64);
+	smu_feature_list_to_arr32(smu, SMU_FEATURE_LIST_ALLOWED, feature_mask);
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
 					      feature_mask[1], NULL);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 24835600c1cd..9bb7e3760c0f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -677,7 +677,6 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 int smu_cmn_feature_is_supported(struct smu_context *smu,
 				 enum smu_feature_mask mask)
 {
-	struct smu_feature *feature = &smu->smu_feature;
 	int feature_id;
 
 	feature_id = smu_cmn_to_asic_specific_index(smu,
@@ -686,9 +685,8 @@ int smu_cmn_feature_is_supported(struct smu_context *smu,
 	if (feature_id < 0)
 		return 0;
 
-	WARN_ON(feature_id > feature->feature_num);
-
-	return test_bit(feature_id, feature->supported);
+	return smu_feature_list_is_set(smu, SMU_FEATURE_LIST_SUPPORTED,
+				       feature_id);
 }
 
 static int __smu_get_enabled_features(struct smu_context *smu,
-- 
2.49.0

