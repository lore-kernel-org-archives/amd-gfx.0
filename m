Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E583FCA1002
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Sep 2025 03:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 986BD10E43D;
	Thu,  4 Sep 2025 03:13:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RGNkb8Ac";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D560710E400
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Sep 2025 03:13:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sANF5uIa7FpRXDZ8apgpW1UqX0h6LOXyVYbvQkezbcjUZRltMzzSBJDwbSVbFXSwhU9HnVlAoO54MtfY/F7jQbCAniH9YGynHdAgcemRd/ihEudqVug8WVoQtfWUb90MhhqabtFc0RYuwMbUhgiGO/wnc7+eDiWbd/7to2VxIKMGFaoO/VWAEbnERSW1jH/TNwmQ/L5kyNOemq6cnh85RZVogGeXRmrwC+oI10LSD4YGKVG9qqnYsFz8OT/b/0kw7txqsKIT0kPAo16c/9Ijjzk49q8mLQ/qOmV2vn1hEBavecZg2JWN3OYNBzY5jw13e55BXPGYVCxEXoMh3SNQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBAePXXCBMDAInywyx6AtYbQmFrJjQBLgKmQHqnSgG8=;
 b=QIRltq5s96hPFCFy9GXireSehQ1qaerHvtP57AdmnDjemjNIEOJCiI5I0FWLUVWfOA/aLnNQ6jmbzKWrONMVVY4E9EL+EnowO207f4EZXPZ0DozLZU2mJMlWXxeB75VZm1BK052JrC+rdyFQvVQpTFCLENc0iA4i/swOHYPKKjg1RpuNHeM5EHodLMWNT2b8sY3DcE/z4qU61369KMRjidGH65SI/+QoExL7VrtYlC8+Qk8FoxvmaGs8Ak5GM7ZbjD+06XDX/oP2jzdUsTllbkzOCXLScFv8hyJLeigpN+0nVlbBi1OD4yAVMYU5Db3cQS7RVhj7LeictYcay+S5Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBAePXXCBMDAInywyx6AtYbQmFrJjQBLgKmQHqnSgG8=;
 b=RGNkb8AcbGib817cYKQqYEMFEW02wZ759xBOAbdUgs3266VGTlV3Z2TBMSQAipfAQIv3MDIJzDNWl00oO4wKPEzJeTcwPfrH1Dzehx94AVMEHIlj2z3ibWVCBwwCKwha33jjD1gXJCe5cP+R9N2IzB5SmIvm9OZ9yNnOoUMcut0=
Received: from BYAPR03CA0011.namprd03.prod.outlook.com (2603:10b6:a02:a8::24)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Thu, 4 Sep
 2025 03:13:30 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::b3) by BYAPR03CA0011.outlook.office365.com
 (2603:10b6:a02:a8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 03:13:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 03:13:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 22:13:29 -0500
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 20:13:27 -0700
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH 3/5] drm/amd/pm: unified smu feature cap for link reset
Date: Thu, 4 Sep 2025 11:13:07 +0800
Message-ID: <20250904031309.2035678-3-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904031309.2035678-1-kevinyang.wang@amd.com>
References: <20250904031309.2035678-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be43151-116b-4d6e-6508-08ddeb6105a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2yO2womeUZeXTB8JG4oRI68XxHZnGaQlkFWVL1ZaKlaqYpX1+LYupgPFT3+t?=
 =?us-ascii?Q?ZVsDYsaqcorotO+4ASPJGhRJRZtHMTa3V4vQk5AVa1y++Q03Et83mAd0pNwS?=
 =?us-ascii?Q?VwJAnum3TY9er9bJPlYC5WsMk0jZWwa0NlO1bS7wIjEhZZaO3pwIoMDjuITd?=
 =?us-ascii?Q?gyjhpqet2Wg7fntl7zRW8YYD/hOhEOa6kjdJi6tAI9Pm7RP+dM0wlYjUc2fe?=
 =?us-ascii?Q?zgyq9obz1AkhfZvt6qtSa9mv3MHK1eKbhFlljreZsYZ3VTVlYgd0wvtwG/lF?=
 =?us-ascii?Q?rebRZflc9URPplKcKZcm0Agw/qxxmFDR6tT1tx8GTcOEXS3/pVvj0+zjQEuq?=
 =?us-ascii?Q?ICIkRq4AQNdsFtBSQILUT0zaIQYV+XlBXavzkVKfNtSYAGfrx3YcABi2cW9s?=
 =?us-ascii?Q?i90+1d2xvCpeiJV0HlE0df4EzpjOhSG8GOZNmqzIT3777BNqhcY/TZukw677?=
 =?us-ascii?Q?ndmLh+n0p/NKqbKita41b2kjs8jI3hiP/0JH0COYqBjhaIQtdjG38CW8NtS8?=
 =?us-ascii?Q?eQ8JCWr26Bqa2xxGS0MMkC9qavgw1+S8BpOskbbSo9TMPe1fIdLtfZQsEkyh?=
 =?us-ascii?Q?iJAgUt1lcQDAzxjexet2vKeNMSru5RESnbabFJh8ycqptrh2PoU2lEYl+8xG?=
 =?us-ascii?Q?vhjP/cgMUT3NvHX+dL111YuCYWe3rl9tXiAWcdXB5Jwq+Sp9b1DDhfZwDmt4?=
 =?us-ascii?Q?3XboG5JJPZ1itppV1LKj9H2/WAf33yiChyTiM0Nm2bxSJSzGgTjpWlkAatTZ?=
 =?us-ascii?Q?yKBev3FX+kw7eCrAvk7/r8+yBXA6ZS0akueM9J6rM3QqvR2u46oNq3x7130R?=
 =?us-ascii?Q?CyhzXQt28Ws/EvvN0UWOqa0wTTiQOPXuR834HaP4RJK2uW2T+PdcIkxbZOWp?=
 =?us-ascii?Q?3N/ii5HfkYMajK9OEsm4UA3b+oO5JflFTa8HF7MEZ/mVbINMKSE3is82h2e5?=
 =?us-ascii?Q?1ZRV0r34QoExx2Q3hUSyrBlXhp9pQ2tjyFIuJDS78/t8jsAn1ql/KvA3zHtH?=
 =?us-ascii?Q?siZwRuEy7O0Pec/EMI3FpijPJ9SMhHWC21ymmoy8VOZ4J/MgzQz8cdAJtiN2?=
 =?us-ascii?Q?oQ9S5XWG/yRd3pAFFEmFdylDEgA3QSP6ZsuBzkiv6mz8CKk7GhPkuvHSP+Do?=
 =?us-ascii?Q?/MMwgn9wLip/eEGawG1Vi51rIOm4OjzezhJ8yfIJst4vIHPePUvJNPhrTtYS?=
 =?us-ascii?Q?QGfbRud2pCKiPBQYv2E2dtWyGip7KjFVwNSKGE8yBP0HB4KXouON3axmsg/D?=
 =?us-ascii?Q?7RnKId4/RxVbb/6ht+C5cV+kFcg4snqutHKk+XxXACyHjx1yZrpJThgTG9Dy?=
 =?us-ascii?Q?5CnndQsqVkJLrtsSy2sbRDY1gkphXCp7l/sJ/ccdI9AT/00NkAE0aj67deZq?=
 =?us-ascii?Q?2Z/JeOikAUdUjwy74nDy5mOTI8slbcg+3FA4B8TllsM5E55/Un4/iQPyRy6K?=
 =?us-ascii?Q?NeUl7XXL5R56SDlBcXvyDOy5IjD4oxPIml8eE0hjv5m2Mbyhvj+QNWYrmuzK?=
 =?us-ascii?Q?LU7WvR77vlpq6lPR5MvNFTAqGLrVVg9V9LQd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 03:13:29.5135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be43151-116b-4d6e-6508-08ddeb6105a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
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

unified link reset smu feature cap

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 7 +------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h        | 6 +-----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 41d568b91f6b..58ba21ad635e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3532,15 +3532,10 @@ bool smu_mode1_reset_is_support(struct smu_context *smu)
 
 bool smu_link_reset_is_support(struct smu_context *smu)
 {
-	bool ret = false;
-
 	if (!smu->pm_enabled)
 		return false;
 
-	if (smu->ppt_funcs && smu->ppt_funcs->link_reset_is_support)
-		ret = smu->ppt_funcs->link_reset_is_support(smu);
-
-	return ret;
+	return smu_feature_cap_test(smu, SMU_FEATURE_CAP_ID__LINK_RESET);
 }
 
 int smu_mode1_reset(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 90ebe158940e..fb3e0ad41e35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -529,6 +529,7 @@ enum smu_fw_status {
 
 enum smu_feature_cap_id {
 	SMU_FEATURE_CAP_ID__MODE1_RESET = 0,
+	SMU_FEATURE_CAP_ID__LINK_RESET,
 	SMU_FEATURE_CAP_ID__COUNT,
 };
 
@@ -1276,11 +1277,6 @@ struct pptable_funcs {
 	 */
 	int (*baco_exit)(struct smu_context *smu);
 
-	/**
-	 * @link_reset_is_support: Check if GPU supports link reset.
-	 */
-	bool (*link_reset_is_support)(struct smu_context *smu);
-
 	/**
 	 * @mode1_reset: Perform mode1 reset.
 	 *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 5b3341c3f82f..c12268ad6289 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3218,6 +3218,9 @@ static int smu_v13_0_6_post_init(struct smu_context *smu)
 {
 	smu_feature_cap_set(smu, SMU_FEATURE_CAP_ID__MODE1_RESET);
 
+	if (smu_v13_0_6_is_link_reset_supported(smu))
+		smu_feature_cap_set(smu, SMU_FEATURE_CAP_ID__LINK_RESET);
+
 	return 0;
 }
 
@@ -3883,7 +3886,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.get_pm_metrics = smu_v13_0_6_get_pm_metrics,
 	.get_xcp_metrics = smu_v13_0_6_get_xcp_metrics,
 	.get_thermal_temperature_range = smu_v13_0_6_get_thermal_temperature_range,
-	.link_reset_is_support = smu_v13_0_6_is_link_reset_supported,
 	.mode1_reset = smu_v13_0_6_mode1_reset,
 	.mode2_reset = smu_v13_0_6_mode2_reset,
 	.link_reset = smu_v13_0_6_link_reset,
-- 
2.34.1

