Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57105EB7EA2
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 08:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D961910E972;
	Wed,  4 Mar 2026 08:19:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w6YXC/9M";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012011.outbound.protection.outlook.com
 [40.93.195.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1276410E978
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 08:19:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgiZkie4nLuNaWrNHgpalSfkbuk3+Vww/DJY+GKnP6U2TIeFwg7aUOMB8V5zCkC24phEFYLIhpFHwe+VITTSRa8iLjSVYRC75bMO1BhdSFb9mPJtuUe+JUyCUdqn2LZddak5/CDbQ1IDvLminVSkzlu6YguX5jLgbK8FOgxJ0lov/C+BBBvh9B9i+ZlhIxZ8OdhmYhWKKuEuddZdwVrB0FE9xq3ut2yiBbWpk3H0ssD1HkDmm1KMOH+hh0mXtI2VrcoIPN6cFfNPPwYKSm6hNK6B70jtX6UuQ6fRTXVoHpZvVdwSmfKwE6O2AZz0zwpr26aFR6xNoZe7ZfSbnEXx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1cPkXxVTZVO0YKUoBHkKalMJAi8u0CSU2C6IsTKVmA=;
 b=GZvSObL0/BPL69WB4lCa3STzoqyAzBBCwb8b1tSDhXkPCvxRnjBPP0kTvBQyGRc7jUgfHQPRGyLikhfI2U19Hqnkuj1O4+YLqyBZSTu0RvjoOR0jre5cnE3riiJzFkZTzOcnYNedA0CctxkhZE5Av1qboMln3QBihspUmNbSuUmuCfUXLoBcMocreb/sXL9TtwLRVjsH6HeWuN/Qcwp8NtdVEEGmgZ1MaA/3+mF6rTlHFQk/vB07y/h/ZQ+hW0Gf+khB8PkSvLQZ4PzyL5koXerim++BxE/bU+Dp3kNgU+jUj5wXnFF++RIMg3UxVk6Ktay96oA7hlj8KS81uWKuLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1cPkXxVTZVO0YKUoBHkKalMJAi8u0CSU2C6IsTKVmA=;
 b=w6YXC/9McNUed95kN228MNIZ9oHLqip99/V3k/oSgBkn+xIYFr4ziXklSsZc1lkH3lSC51g7tV6Pb5Y/3GpQ89etRCAppSeqA7Kf2Mou6VyNfowXwMDbM0o9/1T9Jr+ezqzK1kZJMdNJhG+AqTcH5jmatH7jJ58QmpL9PmUphWM=
Received: from SJ0PR13CA0208.namprd13.prod.outlook.com (2603:10b6:a03:2c3::33)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 08:19:19 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::33) by SJ0PR13CA0208.outlook.office365.com
 (2603:10b6:a03:2c3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Wed,
 4 Mar 2026 08:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 08:19:19 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 02:19:16 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: Add aid/xcd/hbm temperatures
Date: Wed, 4 Mar 2026 16:19:03 +0800
Message-ID: <20260304081904.3132877-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: dc342adb-59d8-4857-14fd-08de79c6bbc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: lVWOZq9uIljES3ATFddvWE9pO4GMOu7+Gtm1O/EMBf/voXVbc/nMg0oZqA6gMGctwyyVGT/gKAsVAxoR8PdipdkFrG6K45Pw1SUIj0vjgH/0xWwVAFA+ymS4F8LYZyoi74Md2MiJcqdhWqp5TnnMiowOzegwT49iD//VMyIy0fD3hUFYshpGL6GCAZhH0zx+ZsXlrz1uT5AXs6pNReigptaC17uUnwjBPkRJuzUr62Z1HTCW+w6UwG1DAbVpyNp/b3QqrxvDAsQdIxMcQnlk1Lzt1vLgswlFn8/6pwdxfcZLTJ0RUTRWKHizFgKZKyy2Uk2QRWpSO+4tEtUEwV69uv0TLV0N7oGfBdqAhEIjeAPLyPxzHAhxftv7SAVWYyzgnMeayqivpYL7bglohU65+QJEOPzLlzf5f/Op0zcUfhocmlNL4bfAB7ueN16PMwxUq5QKRpS4UFGE9Nsr02qLjwgSvKOhU6rN5IGYnwcV4MBErjfxiSDZXQ3TnuiQbO262qpS5M0zTU4sylf7ePHUHUQPC5ocbVJs70KsYNPFRHqVogSybQp4EHiTsoXJHMzHEdbw5L5l9IdfBw8tQQHVym49ds4AcrQGdRLVBguHU55isGuxuzEP03XrYlRHyEZAr1+UJhqd6tMfca4i672Eqw7oJ4DR74j+uqomBsFR8P6UKXmMwiXDjjaNachcH0pEg6Q1ANNGBFUJzyFvukAQeC7Wj9KhkluG0fFXI6myfiq0gY0dvvHenzxwsNq4wGKuHRbA/lhU/y4xH6q4k60X5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hUi9qLS1k/9/uiWVroFd+o1iPKKpfuiODBYysqQOIoRxM+x64aLwpcVnf3k2QX7Qa9dF5MH97nXohaKeT5ywFq9HDEDc4WJ04uI2NSwe2I2BRJ1C1N++lW+2Vy1rkB539gGw9Kgsew6ZJNsLJ9eIdUHN6NbMw6vAkzZ8y6NCQxlChJN/Ht+TVZwhGu+FbvvXdpkHBI4W8PegI4EYMcMBS0TYdneI7PmaE4NZ7BUfaEd22Bk4KXgAwW3m3fto32tzfviX0ayl5NS3c6FVwzdmmeFFORzoDUHGh+gFpFc6K738V1I9cckAsuDz0K/TUEuCZ7nWNwWJqsVOnjHJaZFV0CV4Zp+w3L+s3pxYmBoTr96yvwoscSxdBpBwO0M42+NJ4KSWA/nWCTe72vuxYegK2NhjOOPUmRTK0qfLIJYHsctCHNJgSV5KlHKg7fyD4aNU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 08:19:19.2716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc342adb-59d8-4857-14fd-08de79c6bbc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786
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

Add aid, xcd & hbm temperatures to gpu metrics for smu_v13_0_12

v2: Use correct umc control per stack (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  3 ++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 37 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 13 ++++++-
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index bdf8e6ff556c..a9b73f4fd466 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -584,6 +584,9 @@ enum amdgpu_metrics_attr_id {
 	AMDGPU_METRICS_ATTR_ID_GFX_BELOW_HOST_LIMIT_THM_ACC,
 	AMDGPU_METRICS_ATTR_ID_GFX_LOW_UTILIZATION_ACC,
 	AMDGPU_METRICS_ATTR_ID_GFX_BELOW_HOST_LIMIT_TOTAL_ACC,
+	AMDGPU_METRICS_ATTR_ID_TEMPERATURE_HBM,
+	AMDGPU_METRICS_ATTR_ID_TEMPERATURE_AID,
+	AMDGPU_METRICS_ATTR_ID_TEMPERATURE_XCD,
 	AMDGPU_METRICS_ATTR_ID_MAX,
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index f2a6ecb64c03..96a58d43db53 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -49,6 +49,13 @@
 #undef pr_info
 #undef pr_debug
 
+#define hbm_stack_mask_valid(umc_mask) \
+	(((umc_mask) & 0x3) == 0x3)
+
+#define for_each_hbm_stack(stack_idx, umc_mask) \
+	for ((stack_idx) = 0; (umc_mask); \
+	     (umc_mask) >>= 2, (stack_idx)++) \
+
 #define SMU_13_0_12_FEA_MAP(smu_feature, smu_13_0_12_feature)                    \
 	[smu_feature] = { 1, (smu_13_0_12_feature) }
 
@@ -834,7 +841,7 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
 				  struct smu_v13_0_6_gpu_metrics *gpu_metrics)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int ret = 0, xcc_id, inst, i, j;
+	int ret = 0, xcc_id, inst, i, j, idx;
 	u8 num_jpeg_rings_gpu_metrics;
 	MetricsTable_t *metrics;
 
@@ -849,6 +856,31 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
 	gpu_metrics->temperature_vrsoc =
 		SMUQ10_ROUND(metrics->MaxVrTemperature);
 
+	if (smu_v13_0_6_cap_supported(smu,
+				      SMU_CAP(TEMP_AID_XCD_HBM))) {
+		if (adev->umc.active_mask) {
+			u64 mask = adev->umc.active_mask;
+			int out_idx = 0;
+			int stack_idx;
+
+			if (unlikely(hweight64(mask) / 2 > SMU_13_0_6_MAX_HBM_STACKS)) {
+				dev_warn(adev->dev, "Invalid umc mask %lld\n", mask);
+			} else  {
+				for_each_hbm_stack(stack_idx, mask) {
+					if (!hbm_stack_mask_valid(mask))
+						continue;
+					gpu_metrics->temperature_hbm[out_idx++] =
+						metrics->HbmTemperature[stack_idx];
+				}
+			}
+		}
+		idx = 0;
+		for_each_inst(i, adev->aid_mask) {
+			gpu_metrics->temperature_aid[idx] = metrics->AidTemperature[i];
+			idx++;
+		}
+	}
+
 	gpu_metrics->average_gfx_activity =
 		SMUQ10_ROUND(metrics->SocketGfxBusy);
 	gpu_metrics->average_umc_activity =
@@ -964,6 +996,9 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
 				[i] = SMUQ10_ROUND(
 				metrics->GfxclkBelowHostLimitTotalAcc[inst]);
 		}
+		if (smu_v13_0_6_cap_supported(smu,
+					      SMU_CAP(TEMP_AID_XCD_HBM)))
+			gpu_metrics->temperature_xcd[i] = metrics->XcdTemperature[inst];
 	}
 
 	gpu_metrics->xgmi_link_width = metrics->XgmiWidth;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index ffb06564f830..a150fc88902c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -78,6 +78,7 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(RAS_EEPROM),
 	SMU_CAP(FAST_PPT),
 	SMU_CAP(SYSTEM_POWER_METRICS),
+	SMU_CAP(TEMP_AID_XCD_HBM),
 	SMU_CAP(ALL),
 };
 
@@ -87,6 +88,8 @@ enum smu_v13_0_6_caps {
 #define SMU_13_0_6_MAX_XCC 8
 #define SMU_13_0_6_MAX_VCN 4
 #define SMU_13_0_6_MAX_JPEG 40
+#define SMU_13_0_6_MAX_AID 4
+#define SMU_13_0_6_MAX_HBM_STACKS 8
 
 extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
 bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_0_6_caps cap);
@@ -222,7 +225,15 @@ extern const struct ras_smu_drv smu_v13_0_12_ras_smu_drv;
 		  SMU_13_0_6_MAX_XCC);                                         \
 	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_TOTAL_ACC), SMU_MUNIT(NONE),  \
 		  SMU_MTYPE(U64), gfx_below_host_limit_total_acc,              \
-		  SMU_13_0_6_MAX_XCC);
+		  SMU_13_0_6_MAX_XCC);					       \
+	SMU_ARRAY(SMU_MATTR(TEMPERATURE_HBM), SMU_MUNIT(TEMP_1),               \
+		  SMU_MTYPE(U16), temperature_hbm,                             \
+		  SMU_13_0_6_MAX_HBM_STACKS);                                  \
+	SMU_ARRAY(SMU_MATTR(TEMPERATURE_AID), SMU_MUNIT(TEMP_1),               \
+		  SMU_MTYPE(U16), temperature_aid, SMU_13_0_6_MAX_AID);        \
+	SMU_ARRAY(SMU_MATTR(TEMPERATURE_XCD), SMU_MUNIT(TEMP_1),               \
+		  SMU_MTYPE(U16), temperature_xcd, SMU_13_0_6_MAX_XCC);        \
+
 
 DECLARE_SMU_METRICS_CLASS(smu_v13_0_6_gpu_metrics, SMU_13_0_6_METRICS_FIELDS);
 void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
-- 
2.46.0

