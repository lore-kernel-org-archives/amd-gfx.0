Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FB2C02181
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 09:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0C0710E6A4;
	Wed, 22 Jan 2025 09:56:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PjXrYuk4";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8234710E38B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 09:56:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaXX3nMFMapoG1XPST0cel/PwJao9bDdjaIrTD7j1wL6+cskXVOUNTd0BF+gVoedonnS65XvML2YxYFApIa+JMWvcaL4/JVVV3OiAQ9dq442pZjuDKnvslC5JlFEMZs4uDCzmASxcJmvgWYj0CgFQnhT6mWk3LzV3wZHp2WotH+RVlJbnMrS3gqqjsp7mQA8eHEdlKONtcuwUJ6ojOFg4bBlz5p6pp6ELWRx6qriGVIijVft0QXQ/sARDyTVx67bXiZ0P+iEvTriJATQhefiqfU4yJ8Cs32h4UlCdH+TQBx+cxWOseaqAQQXNOmwKBgfhjbtWtjoAB/IHc3h/PUoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDAeqnZJrG5OBUeyAihmv7EsN/WAOGZLZQ2TCVnWgX8=;
 b=xAs+EgRZzxpvKlNP7oqf+8Xq8Bvy49IRHS2qvFqze3SZ6rTgLD8+TGUKR/zJg41wav1geA82Hc7+TXo55E9z1bGOciv8AqMYzSwbpYoXxCf8lv0JWigNaJLrlwNutzPuVzfwsJQ3WtOJMClV4kgmV+zDQVmPD4lmJ40LEliw/zm7zBy80ALDKDX5le4Lw43Z+lIgzG7jBWw9q3ukhQcABWOhhGFJkGfdMvIJ4AXGloybi4ggJztXTq3CWDUdW98sAlNwW75gY8JdInlnK6EWqw/VTbVfBrHqX0XvI7tUKulrqwR2hOY1MX5P2tsA1sb/2aCXfkCdrZWinxB91l3X8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDAeqnZJrG5OBUeyAihmv7EsN/WAOGZLZQ2TCVnWgX8=;
 b=PjXrYuk4CKdHuZVHWHwKnKrtOFo1xum0kVQs26iJ8O+QgDFvOmg9bBnM3+pVb5XLRc/3/1emnfjX2kQvg86fQ5afLCkSr3HlZinyn18Pt0FPQri8W2BSbzmwn1LwHKQA6yf/TEkWDBwEhVQfs9gSSaIXsQjz2m8XwkMa62Rbi8I=
Received: from DS7PR06CA0013.namprd06.prod.outlook.com (2603:10b6:8:2a::13) by
 PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Wed, 22 Jan
 2025 09:56:14 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::d6) by DS7PR06CA0013.outlook.office365.com
 (2603:10b6:8:2a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Wed,
 22 Jan 2025 09:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 09:56:13 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Jan
 2025 03:56:11 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v2 1/6] drm/amd/pm: Update metrics tbl struct for smu_v_13.0.6
Date: Wed, 22 Jan 2025 17:55:38 +0800
Message-ID: <20250122095543.148993-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d75ac2-ac17-4110-904c-08dd3acb01e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JILZiNaD2SoGNDaLUdNeUF/bzr7yr5zgztpwvOhbqf58rdg3M0wHHa/rinoj?=
 =?us-ascii?Q?L1KmrubqnYwquoMgvpLY85gKG5HFCrJMy8UXXYKRHqI6AVPjobrv4dSM0lFo?=
 =?us-ascii?Q?P7KzssUbbR4RwU4JYz8iihWATqY8X3fR0KFA54j905n6VLFKq7Ve5143HC5B?=
 =?us-ascii?Q?Rhe1+QVnsrP3AbEBWvfKG0mfXZYaoBS70MXrUAwary6TiOOqHSdgg4USjVbH?=
 =?us-ascii?Q?1XYHIi/hKViiF4IF8pbsrAeNEO6vdwHPMElIGKPwWXipMfBIpmfWHTb22+VB?=
 =?us-ascii?Q?ndpTw5SlROGKNgr971rODn64mUQvaNGnssCtsE4r7oguB4D56ynEMF5HAZyi?=
 =?us-ascii?Q?w7vap153/OtCwRyqiw7Us6arI4ca7EeZ+e9F2Y2f/aCMekbCfTNhEz28CnPS?=
 =?us-ascii?Q?ND5DCx+MIfX54cP+YehzwnypXOvScBTqKTdPwHBdoBG60Yqf3gnSFGy8ALnG?=
 =?us-ascii?Q?MAOF7D0ozwLOrh/VvNrwKhBIM78xIQAbGKfqA0HlnuAUvZTAQzkllxLw6HER?=
 =?us-ascii?Q?pHamSbORCkLJTHqeDtguZ2GcrSQtbV8PXlMHx/xVab7pbvpNaiJlNWKf08IJ?=
 =?us-ascii?Q?Or1z6nkIMd53b2Iks264bmCqIB4j7EqvRauwJkTcuup1qGDqjWCLNSgQDoUQ?=
 =?us-ascii?Q?8OanfhtNpiO4kvCcv6EFJES78uie/RJf91bvQEf5KAzYeyG0LAq0+VYTlVhi?=
 =?us-ascii?Q?kb0jJXt4HYTUspZEpIhQ1T5ejhq3CDs1iiY34gcdxh0W+eCtlhhD/CEu6kwJ?=
 =?us-ascii?Q?7Y7EhAt6YoQ+x6qGQHmMxmHhPySFT//vKGegzVCPnDSXSAzz3bXqca8j1wLM?=
 =?us-ascii?Q?C/kwwTA0fHqHrUPthiDh6/4TCFQ5pHp97OApVKRYB+mBCd312EVyRMdIr2oc?=
 =?us-ascii?Q?NbmcXIqpMsff4g4upSdxk2BLOvLCDshpS85ftbbW9Sg6b+3JEVOSxOBszTlA?=
 =?us-ascii?Q?V9p/vctZGj94opNzhIaliBVj55qrCrei7MBEzj/jVJeiI6VC1G1657cRm8hk?=
 =?us-ascii?Q?whLGoW6OXs2GVZPwXrYo4Xku7uiZpxKzfkdEJeUbBIGDonZZ9hhAY9SgzPG3?=
 =?us-ascii?Q?cGTMh49+WmEguD2ZRHyvdsuMTu7oHCwF5s0EevoeBZhrHnh3qb4EzxGvKThh?=
 =?us-ascii?Q?sEPcE9q4dY7Eq+1a5dtEvPcE/xjkhXwxs+hvCm1VqRwdgXasI1Ob+lIo5KPN?=
 =?us-ascii?Q?mtivErqsS5tXID9S6NXwgLLsO+uNravHpS/xWteF1fSSaZEJ3DxzBhrIhYAt?=
 =?us-ascii?Q?99E3ArA25JlCl9j3Ct0vmFwQOL7f0/eiYRCzGlo6y1GfbNIsfi+9zlTCU7uG?=
 =?us-ascii?Q?YL0vY2goupZPeG0j+GXkV7Huil/ri9wXFV0QYvraoMabkqSuOn59NasrEO7B?=
 =?us-ascii?Q?Q2LKF5TQFA0wq5EdE6YIwEk7GvFT6Xxl93lu4nSlcyvfJsOybHuKwGJ4vALw?=
 =?us-ascii?Q?iRZQaivfKyPXTpfO3mCK8u42/umNmXwit57q7AtQuZy2Aehw+0HbWh8ho3NP?=
 =?us-ascii?Q?W/zaF0VyremW5dc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 09:56:13.9716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d75ac2-ac17-4110-904c-08dd3acb01e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655
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

Update metrics table struct name for smu_v_13.0.6 and keep
it as version

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h   |  6 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 56 +++++++++----------
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index 274b3e1cc4fb..ff9f7d4e11df 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -129,6 +129,7 @@ typedef enum {
 
 #define SMU_METRICS_TABLE_VERSION 0xF
 
+// Unified metrics table for smu_v13_0_6
 typedef struct __attribute__((packed, aligned(4))) {
   uint32_t AccumulationCounter;
 
@@ -241,8 +242,9 @@ typedef struct __attribute__((packed, aligned(4))) {
 
   //Total App Clock Counter
   uint64_t GfxclkBelowHostLimitAcc[8];
-} MetricsTableX_t;
+} MetricsTableV0_t;
 
+// Metrics table for smu_v13_0_6 APUS
 typedef struct __attribute__((packed, aligned(4))) {
   uint32_t AccumulationCounter;
 
@@ -333,7 +335,7 @@ typedef struct __attribute__((packed, aligned(4))) {
   // VCN/JPEG ACTIVITY
   uint32_t VcnBusy[4];
   uint32_t JpegBusy[32];
-} MetricsTableA_t;
+} MetricsTableV1_t;
 
 #define SMU_VF_METRICS_TABLE_VERSION 0x5
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index fa11e30bff24..dbfab5d503b5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -273,7 +273,7 @@ struct PPTable_t {
 #define SMUQ10_FRAC(x) ((x) & 0x3ff)
 #define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >= 0x200))
 #define GET_METRIC_FIELD(field, flag) ((flag) ?\
-		(metrics_a->field) : (metrics_x->field))
+		(metrics_v1->field) : (metrics_v0->field))
 
 struct smu_v13_0_6_dpm_map {
 	enum smu_clk_type clk_type;
@@ -514,7 +514,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 			       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS,
-		       max(sizeof(MetricsTableX_t), sizeof(MetricsTableA_t)),
+		       max(sizeof(MetricsTableV0_t), sizeof(MetricsTableV1_t)),
 		       PAGE_SIZE,
 		       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
 
@@ -522,8 +522,8 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 		       PAGE_SIZE,
 		       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
 
-	smu_table->metrics_table = kzalloc(max(sizeof(MetricsTableX_t),
-		       sizeof(MetricsTableA_t)), GFP_KERNEL);
+	smu_table->metrics_table = kzalloc(max(sizeof(MetricsTableV0_t),
+					       sizeof(MetricsTableV1_t)), GFP_KERNEL);
 	if (!smu_table->metrics_table)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
@@ -753,8 +753,8 @@ static ssize_t smu_v13_0_6_get_pm_metrics(struct smu_context *smu,
 static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	MetricsTableX_t *metrics_x = (MetricsTableX_t *)smu_table->metrics_table;
-	MetricsTableA_t *metrics_a = (MetricsTableA_t *)smu_table->metrics_table;
+	MetricsTableV0_t *metrics_v0 = (MetricsTableV0_t *)smu_table->metrics_table;
+	MetricsTableV1_t *metrics_v1 = (MetricsTableV1_t *)smu_table->metrics_table;
 	struct PPTable_t *pptable =
 		(struct PPTable_t *)smu_table->driver_pptable;
 	bool flag = !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS));
@@ -1128,8 +1128,8 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 					    uint32_t *value)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	MetricsTableX_t *metrics_x = (MetricsTableX_t *)smu_table->metrics_table;
-	MetricsTableA_t *metrics_a = (MetricsTableA_t *)smu_table->metrics_table;
+	MetricsTableV0_t *metrics_v0 = (MetricsTableV0_t *)smu_table->metrics_table;
+	MetricsTableV1_t *metrics_v1 = (MetricsTableV1_t *)smu_table->metrics_table;
 	bool flag = !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS));
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
@@ -2479,21 +2479,21 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	bool flag = !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS));
 	int ret = 0, xcc_id, inst, i, j, k, idx;
 	struct amdgpu_device *adev = smu->adev;
-	MetricsTableX_t *metrics_x;
-	MetricsTableA_t *metrics_a;
+	MetricsTableV0_t *metrics_v0;
+	MetricsTableV1_t *metrics_v1;
 	struct amdgpu_xcp *xcp;
 	u16 link_width_level;
 	u32 inst_mask;
 	bool per_inst;
 
-	metrics_x = kzalloc(max(sizeof(MetricsTableX_t), sizeof(MetricsTableA_t)), GFP_KERNEL);
-	ret = smu_v13_0_6_get_metrics_table(smu, metrics_x, true);
+	metrics_v0 = kzalloc(max(sizeof(MetricsTableV0_t), sizeof(MetricsTableV1_t)), GFP_KERNEL);
+	ret = smu_v13_0_6_get_metrics_table(smu, metrics_v0, true);
 	if (ret) {
-		kfree(metrics_x);
+		kfree(metrics_v0);
 		return ret;
 	}
 
-	metrics_a = (MetricsTableA_t *)metrics_x;
+	metrics_v1 = (MetricsTableV1_t *)metrics_v0;
 
 	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 7);
 
@@ -2559,9 +2559,9 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 		 * for pf from registers
 		 */
 		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(PCIE_METRICS))) {
-			gpu_metrics->pcie_link_width = metrics_x->PCIeLinkWidth;
+			gpu_metrics->pcie_link_width = metrics_v0->PCIeLinkWidth;
 			gpu_metrics->pcie_link_speed =
-				pcie_gen_to_speed(metrics_x->PCIeLinkSpeed);
+				pcie_gen_to_speed(metrics_v0->PCIeLinkSpeed);
 		} else if (!amdgpu_sriov_vf(adev)) {
 			link_width_level = smu_v13_0_6_get_current_pcie_link_width_level(smu);
 			if (link_width_level > MAX_LINK_WIDTH)
@@ -2574,22 +2574,22 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 		}
 
 		gpu_metrics->pcie_bandwidth_acc =
-				SMUQ10_ROUND(metrics_x->PcieBandwidthAcc[0]);
+				SMUQ10_ROUND(metrics_v0->PcieBandwidthAcc[0]);
 		gpu_metrics->pcie_bandwidth_inst =
-				SMUQ10_ROUND(metrics_x->PcieBandwidth[0]);
+				SMUQ10_ROUND(metrics_v0->PcieBandwidth[0]);
 		gpu_metrics->pcie_l0_to_recov_count_acc =
-				metrics_x->PCIeL0ToRecoveryCountAcc;
+				metrics_v0->PCIeL0ToRecoveryCountAcc;
 		gpu_metrics->pcie_replay_count_acc =
-				metrics_x->PCIenReplayAAcc;
+				metrics_v0->PCIenReplayAAcc;
 		gpu_metrics->pcie_replay_rover_count_acc =
-				metrics_x->PCIenReplayARolloverCountAcc;
+				metrics_v0->PCIenReplayARolloverCountAcc;
 		gpu_metrics->pcie_nak_sent_count_acc =
-				metrics_x->PCIeNAKSentCountAcc;
+				metrics_v0->PCIeNAKSentCountAcc;
 		gpu_metrics->pcie_nak_rcvd_count_acc =
-				metrics_x->PCIeNAKReceivedCountAcc;
+				metrics_v0->PCIeNAKReceivedCountAcc;
 		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(OTHER_END_METRICS)))
 			gpu_metrics->pcie_lc_perf_other_end_recovery =
-				metrics_x->PCIeOtherEndRecoveryAcc;
+				metrics_v0->PCIeOtherEndRecoveryAcc;
 
 	}
 
@@ -2639,14 +2639,14 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 			for_each_inst(k, inst_mask) {
 				inst = GET_INST(GC, k);
 				gpu_metrics->xcp_stats[i].gfx_busy_inst[idx] =
-					SMUQ10_ROUND(metrics_x->GfxBusy[inst]);
+					SMUQ10_ROUND(metrics_v0->GfxBusy[inst]);
 				gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
-					SMUQ10_ROUND(metrics_x->GfxBusyAcc[inst]);
+					SMUQ10_ROUND(metrics_v0->GfxBusyAcc[inst]);
 
 				if (smu_v13_0_6_cap_supported(
 					    smu, SMU_CAP(HST_LIMIT_METRICS)))
 					gpu_metrics->xcp_stats[i].gfx_below_host_limit_acc[idx] =
-						SMUQ10_ROUND(metrics_x->GfxclkBelowHostLimitAcc
+						SMUQ10_ROUND(metrics_v0->GfxclkBelowHostLimitAcc
 								[inst]);
 				idx++;
 			}
@@ -2659,7 +2659,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	gpu_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp, flag);
 
 	*table = (void *)gpu_metrics;
-	kfree(metrics_x);
+	kfree(metrics_v0);
 
 	return sizeof(*gpu_metrics);
 }
-- 
2.46.0

