Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50B6CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 15:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0C810E92E;
	Thu,  6 Nov 2025 15:34:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O+C9OW6+";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC04910E931
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 15:34:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSzqhZCTjjcKpOxuYq3Ssovn1R44C6OAODb6rpnpzFGsf9UQBxOpbZQyArYTOZP1HgxIt4Tz5RvzKQN19tMBn2oP43W26jiB6DiZ41paqsTAMCQjYvuiC1X8GmV6A/P5SpRDzBQ3FrSFxL34frstcVoJItY7WQe0E0xqqFgFqWlRvxoW1A4gyKw3X2jI0lepnX8By1kdcfoDGMt4PjgXWnTkdp24jTCtyjFC2COKKkJev55kM1Q+zQTyJ33y/3yGOlZs3SoNPc7H0NpWJzuQoZslbyX5Ybh5IHpuyXxagrdEOe9/mWdQOyNalEn3IzlrpJp3qRrT6Fgnns10bBlHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4muTxuhcGOast6nz3T+vU747wIRCGRaCrT/U+7OVC4w=;
 b=Xufi/fxZ3Jxu6zM07Ddrg5uuY3L6X96APW4G0AuBIRYfz1pbUeoRMc88ycDN/nf48BPf4fA0mHtkwC8FcWiOXK0PBDcyawadFqrdMyCsgPptaIhWRqkGT6mmXIiU/dWgfW/qk4Jbttjywi5F3ySFHk386678nauJKZlenFAGzrNAUpX4cxK4Z8VgCmlNNTnNGuBcQLF6Y/P3fh99tv4ybR28bujZJZEMrbAicRBnXb0ghmgI74NaUSVpudrF0+CV/aT/jhym/twaIzxr2bmswJN1qbDF07X8AHGF+Rlt8VLGMoAm9stZPFC+BrQMIWsakvdfzO0iabEO1Cph9sZopA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4muTxuhcGOast6nz3T+vU747wIRCGRaCrT/U+7OVC4w=;
 b=O+C9OW6+nJoFxF0QxE4KzD3PgI/si2ucTd9XTNx0GDOFkLk4IU1un8IHSx9Ud51LXmIoEOYp6R3v2vUpTlFXdmISPhWDaawkP7xSV3V/mf7XWnxitPZxvZiAmpZCk6pyQgQJW1lP3gVBXHYjgVhjaj0UGqy4X9En/aBNiB4E0UY=
Received: from PH7P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::24)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 15:34:06 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::6f) by PH7P221CA0040.outlook.office365.com
 (2603:10b6:510:33c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 15:34:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 15:34:05 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 07:34:03 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH v3 2/4] drm/amd/pm: Add ppt1 support for smu_v13_0_12
Date: Thu, 6 Nov 2025 23:33:26 +0800
Message-ID: <20251106153328.3783505-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251106153328.3783505-1-asad.kamal@amd.com>
References: <20251106153328.3783505-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|BY5PR12MB4114:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f537566-a49c-4962-494f-08de1d49ebd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IMyx4d5MA/RToYl8G4gmHhJjHxYZmn5qvWxnK/Ks+liZZlcAERDT05GWzmSR?=
 =?us-ascii?Q?cveBta8JT2JlKWA/KbV3IRKfGAeligSOf3ZWHqIedQjcLUJKwuLgybbMyxLb?=
 =?us-ascii?Q?VCX4NmNND+KmyztCKA/w2tGaQANVuSkfdsTVaqrmwtpCD8WMTZAFyLY74GAs?=
 =?us-ascii?Q?tA0K51nYAKwQOG9wCJ0hQC663vmLgJia9xO2kxhN13IXwMkV21UwlH8eqqUU?=
 =?us-ascii?Q?+g/cJopOUlawNVHjAJmhEwPJi6Rgl/q5Bg3npIGx2CQYe04HklH+F/GJpptQ?=
 =?us-ascii?Q?/CYhiGQwzD/QHD3tN3bscpeSLgmGVkkgzDafw48mx5itQtpwi5ovqO+QzZ8b?=
 =?us-ascii?Q?35WtvAGWP0kqEdHg5Ksfec630SAuFbXVbosafXun5eMIm0rnpcU948VHMi+S?=
 =?us-ascii?Q?PI6Zlzy3FP5Jas1UQDSkuqiZc6loR4Xt8YlilJTQu3Frrbxt/5Vq9JK3eRXU?=
 =?us-ascii?Q?5usASaB8wNVcjgaGr7gcD1k5era1wb2J+kwebVI1M/i1Ch7KbwEq9tXWYGTZ?=
 =?us-ascii?Q?lhPIaTn+3n5jihiNBjs4cDz9wpovfhNoWmcfSGriPdJvKDX3IXe6X/qT2nxT?=
 =?us-ascii?Q?Mp0wyTFDv5mkHP298UL3R5bL0DmN6X5dNBJK8YsQXoJJhqsfUlgYIewGlMOE?=
 =?us-ascii?Q?1vnizh5n63DhMFqDksWw00pfyl6uONWjEw1F1M3AWoX18KJC6kx0bMFYl1LP?=
 =?us-ascii?Q?8IQXyzAHa5FlRgp61Sa1FQFbb6qM5s63dyEaev/eGlI1vmljDvtEoG99Brd8?=
 =?us-ascii?Q?nCx0lrFeu3N7O/lR4UcZtPRHkM8/awqhdqSeTvu6po5akhrvNIyVJUve+g7P?=
 =?us-ascii?Q?+tHxhJEZwsTWGSh1Tm8Xc79GVV9VHtnpp66RTkO162DoZ88t1w/D7kgUCuyQ?=
 =?us-ascii?Q?B2j6dt8oTZZfgpgQbsvI6HWhEBQYqvwYeMmh7UB46giV2uSWqIZxybO11Wk2?=
 =?us-ascii?Q?PihAYAoISzw70oVIZv7MPPTxH8BHAUOoY+6mlZ+hapCywKjpMSRWPDuMCmCp?=
 =?us-ascii?Q?cPPiwx/45m7BbISD2cDSxTp6GxWg+cCeML0e5JUqLTiHvMcTsWeQovT7/Web?=
 =?us-ascii?Q?JcGEc6Wa8/jRKrvgiGEz4yGnisGrls4+OZuqZdEK16sOZAJ0QKjri24Icxbb?=
 =?us-ascii?Q?PrMILgoIuO0NVPuDL90Rh2IOzPDH3kF1nwHwA2UtccfGOHw0g0xHYgd7i5dk?=
 =?us-ascii?Q?5Ltq9XMCzuKIrL1nBG2kb4mnOT0lmzELMoQkcwe1RgbfXTzLc8D5zVb7IekJ?=
 =?us-ascii?Q?1aioV/AfXN/OnpfSOPkRtTXchXyDu3KWVzXdUIUE081upTFpYNd+s/JEhD8X?=
 =?us-ascii?Q?r6fgHkK6CkpXyz28UibD2FYD7vQSwkcZHGx/zn2BzW44u+nqEfae+TryJWuU?=
 =?us-ascii?Q?YhPQJccqQIeqAtLfI7o63+X1ekMiZRCNSd7zcfrSqOFPuEBL2K5Yp7F3C3qS?=
 =?us-ascii?Q?VcH955OaD26IhndITeBljNWI3HkIUUcicbqXvuqLkiyuKmiIg4jxRMZbRVVH?=
 =?us-ascii?Q?AINLcAyjqRlAsNyG4GswSfH5NTQWwNKXk12XoG05aleK7PLohCLKK6PAnkK+?=
 =?us-ascii?Q?Ra6zHzzHYAnadRMa8Fw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 15:34:05.8665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f537566-a49c-4962-494f-08de1d49ebd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
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

Add support to configure and retrieve ppt1 limit for smu_v13_0_12

v2: Add update_caps function and update ppt1 cap based on max ppt1
value, optimize the return values (Lijo)

v3: Add Null ptr check, return not supported in case of invalid
level/type (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  4 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  8 ++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 80 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |  4 +
 4 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 3a3930ef7ed9..9b71a8afdd35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -286,7 +286,9 @@
 	__SMU_DUMMY_MAP(SetTimestamp), \
 	__SMU_DUMMY_MAP(GetTimestamp), \
 	__SMU_DUMMY_MAP(GetBadPageIpid), \
-	__SMU_DUMMY_MAP(EraseRasTable),
+	__SMU_DUMMY_MAP(EraseRasTable),  \
+	__SMU_DUMMY_MAP(SetFastPptLimit), \
+	__SMU_DUMMY_MAP(GetFastPptLimit),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 0ce8cff27bf9..c513cbeb361f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -148,6 +148,8 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(GetTimestamp,                        PPSMC_MSG_GetTimestamp,                    0),
 	MSG_MAP(GetBadPageIpid,                      PPSMC_MSG_GetBadPageIpIdLoHi,              0),
 	MSG_MAP(EraseRasTable,                       PPSMC_MSG_EraseRasTable,                   0),
+	MSG_MAP(SetFastPptLimit,		     PPSMC_MSG_SetFastPptLimit,			1),
+	MSG_MAP(GetFastPptLimit,		     PPSMC_MSG_GetFastPptLimit,			1),
 };
 
 int smu_v13_0_12_tables_init(struct smu_context *smu)
@@ -354,6 +356,12 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(NPM_METRICS)))
 			pptable->MaxNodePowerLimit =
 				SMUQ10_ROUND(static_metrics->MaxNodePowerLimit);
+		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(FAST_PPT)) &&
+		    static_metrics->PPT1Max) {
+			pptable->PPT1Max = static_metrics->PPT1Max;
+			pptable->PPT1Min = static_metrics->PPT1Min;
+			pptable->PPT1Default = static_metrics->PPT1Default;
+		}
 		smu_v13_0_12_init_xgmi_data(smu, static_metrics);
 		pptable->Init = true;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index dd8c7b98ce7e..f9e04df7e472 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -856,6 +856,17 @@ int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
 	return 0;
 }
 
+static void smu_v13_0_6_update_caps(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct PPTable_t *pptable =
+		(struct PPTable_t *)smu_table->driver_pptable;
+
+	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(FAST_PPT)) &&
+	    !pptable->PPT1Max)
+		smu_v13_0_6_cap_clear(smu, SMU_CAP(FAST_PPT));
+}
+
 static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -872,8 +883,12 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 	uint8_t max_width;
 
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12) &&
-	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
-		return smu_v13_0_12_setup_driver_pptable(smu);
+	    smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS))) {
+		ret = smu_v13_0_12_setup_driver_pptable(smu);
+		if (ret)
+			return ret;
+		goto out;
+	}
 
 	/* Store one-time values in driver PPTable */
 	if (!pptable->Init) {
@@ -953,7 +968,8 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 			smu_v13_0_6_fill_static_metrics_table(smu, static_metrics);
 		}
 	}
-
+out:
+	smu_v13_0_6_update_caps(smu);
 	return 0;
 }
 
@@ -1887,9 +1903,66 @@ static int smu_v13_0_6_set_power_limit(struct smu_context *smu,
 				       enum smu_ppt_limit_type limit_type,
 				       uint32_t limit)
 {
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct PPTable_t *pptable =
+		(struct PPTable_t *)smu_table->driver_pptable;
+	int ret;
+
+	if (limit_type == SMU_FAST_PPT_LIMIT) {
+		if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(FAST_PPT)))
+			return -EOPNOTSUPP;
+		if (limit > pptable->PPT1Max || limit < pptable->PPT1Min) {
+			dev_err(smu->adev->dev,
+				"New power limit (%d) should be between min %d max %d\n",
+				limit, pptable->PPT1Min, pptable->PPT1Max);
+			return -EINVAL;
+		}
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetFastPptLimit,
+						      limit, NULL);
+		if (ret)
+			dev_err(smu->adev->dev, "Set fast PPT limit failed!\n");
+		return ret;
+	}
+
 	return smu_v13_0_set_power_limit(smu, limit_type, limit);
 }
 
+static int smu_v13_0_6_get_ppt_limit(struct smu_context *smu,
+				     uint32_t *ppt_limit,
+				     enum smu_ppt_limit_type type,
+				     enum smu_ppt_limit_level level)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct PPTable_t *pptable =
+		(struct PPTable_t *)smu_table->driver_pptable;
+	int ret = 0;
+
+	if (type == SMU_FAST_PPT_LIMIT) {
+		if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(FAST_PPT)))
+			return -EOPNOTSUPP;
+		switch (level) {
+		case SMU_PPT_LIMIT_MAX:
+			*ppt_limit = pptable->PPT1Max;
+			break;
+		case SMU_PPT_LIMIT_CURRENT:
+			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPptLimit, ppt_limit);
+			if (ret)
+				dev_err(smu->adev->dev, "Get fast PPT limit failed!\n");
+			break;
+		case SMU_PPT_LIMIT_DEFAULT:
+			*ppt_limit = pptable->PPT1Default;
+			break;
+		case SMU_PPT_LIMIT_MIN:
+			*ppt_limit = pptable->PPT1Min;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		return ret;
+	}
+	return -EOPNOTSUPP;
+}
+
 static int smu_v13_0_6_irq_process(struct amdgpu_device *adev,
 				   struct amdgpu_irq_src *source,
 				   struct amdgpu_iv_entry *entry)
@@ -3959,6 +4032,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.get_enabled_mask = smu_v13_0_6_get_enabled_mask,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.set_power_limit = smu_v13_0_6_set_power_limit,
+	.get_ppt_limit = smu_v13_0_6_get_ppt_limit,
 	.set_xgmi_pstate = smu_v13_0_set_xgmi_pstate,
 	.register_irq_handler = smu_v13_0_6_register_irq_handler,
 	.enable_thermal_alert = smu_v13_0_enable_thermal_alert,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 367102cdbf09..6cbdd7c5ded9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -50,6 +50,9 @@ struct PPTable_t {
 	uint32_t MinLclkDpmRange;
 	uint64_t PublicSerialNumber_AID;
 	uint32_t MaxNodePowerLimit;
+	uint32_t PPT1Max;
+	uint32_t PPT1Min;
+	uint32_t PPT1Default;
 	bool Init;
 };
 
@@ -73,6 +76,7 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(TEMP_METRICS),
 	SMU_CAP(NPM_METRICS),
 	SMU_CAP(RAS_EEPROM),
+	SMU_CAP(FAST_PPT),
 	SMU_CAP(ALL),
 };
 
-- 
2.46.0

