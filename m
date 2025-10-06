Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F83CCA470
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 16:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CC8B10E41D;
	Mon,  6 Oct 2025 16:32:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1jZzMqIY";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01DE510E413
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 16:32:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+iyt0BHIC1ei4WCn35jzfostQ++6AjQ2DVVIUfoS6wpRtTPqQQO5n6OSMi6Mtd4fuARIgrmnYmV1r5WUVXEix4kwJ+OBrGF6bwNe/DmTaJvydGqJYx5ORC4O1VlTksFf3nLisnn6PGrKIAEgVivKIkqwV7icN11LIpWC1rK3Q6AO5hfaOwctQeI+FFpe3UZNbDdaW7W4QbpzC/khL5InYMS+58rV+vakvcIbVr9mSl3+9EMDYNfc/6hu9tyS6XQgbgx/MTQVRx2vLlQnWe84ZTQSHAinLZ3krfDITjSxf/WXgo/cxHfOTEBcox6qJXtJerwnWgWzhfqEao3BdH+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQ97Uh7glKs4fgelBrX5r9GwzeEJj8t5NUwLbYrE5Rg=;
 b=IUNZ8pQ7VKgXV/bdMsYPVr6WdUioEsVoIn6IXQxvGyRPTyhTuCs+5Nw8oC3jADRzH2DvoTlAMJuu5YA482OR/4KfdF/qm23k66UYagcrusS72f5PboCsDF/P7Ut+EWwBuKgXZSMKHxKr40fgXjVkTGPfEKKFoykjlgmu001F7JDHzCf4ikO171p+/6PZqyfgor3znwo1HIt7KDWv8SHGieYKw6YoQMAeJXKw+NWI+0do5DcfVKGpNWgQwkTUBb3lnBrMX3vvi0AcwUOh1WKW3jwcehMXfAcPwsNGn2dbs3GXyO4VT5l56PfU7/QzhDQEncsK0HQkP3mjPJeNos3O0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQ97Uh7glKs4fgelBrX5r9GwzeEJj8t5NUwLbYrE5Rg=;
 b=1jZzMqIYOHvKcLWEYl0JnOZ0SClMUEou+wjddwuMe+n3t3i+nh3K/QnH+N8FC1QV4UVKJ5lfD8Tix7uOb0wnxiZ+R96kpxx5yh00KuPdh3R4ju3IpeMsilRRhMQv4M9FRLccIyzcOSHKGlHtl1vF2O7Fojy/C3XUxN7n7kBhrmU=
Received: from PH7PR03CA0004.namprd03.prod.outlook.com (2603:10b6:510:339::30)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 16:31:56 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::e2) by PH7PR03CA0004.outlook.office365.com
 (2603:10b6:510:339::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 16:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 16:31:55 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Oct 2025 09:31:54 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/5] drm/amd: Save and restore all limit types
Date: Mon, 6 Oct 2025 11:31:36 -0500
Message-ID: <20251006163138.17489-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006163138.17489-1-mario.limonciello@amd.com>
References: <20251006163138.17489-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: 61af6af9-e97a-418f-f1a4-08de04f5dcd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E6uVHwXXjk6488SILZGc6OLZy7jE47XCFuqhr5pCM4GKnOdJEaTxf28SUYAb?=
 =?us-ascii?Q?J07b1fg6Y8khVqcEA/VhTK4kNLn+V3yxyDg1vq5oxjWUrJDE7hCxPdKVwljJ?=
 =?us-ascii?Q?Yc20bHuUZAW5akaSZzgFSKEMrH51mouf6g63oFWisEmFn7GX1suf1nXlIkRX?=
 =?us-ascii?Q?SMD98HnBgsi2PbFdPZ/uYn+y9rhAd2fOZS+ZW99rqtthDLJ1NTSfDBXpfCwC?=
 =?us-ascii?Q?r5uvBN1rKjaAFH1tOAAwaiAmkmudQedCyxbmVnfTgHMmr4z3/LHEkfoSB/eU?=
 =?us-ascii?Q?alTFrDDN/r6UZJ66CHm2+/eovU7OwQGsU2HwqRXw9YYPkYqkZbbshrYpVKJh?=
 =?us-ascii?Q?Scw5qBXNwUb0oWSC25UVUxau/y65D2kkqdu0ZqOmXdiQ4U3U1FA61i/nbzTo?=
 =?us-ascii?Q?ebqQ5HGTQRS2u4eJ8ZuEqitLtnJzMxFay+53ZXZVAo0BWbZBtJfnbRNpJ6z8?=
 =?us-ascii?Q?XRM1lI2nPO2fdIxQtf1oSKv91n4sYIFMrc//r+1dNJJLf3XGQXD4roMzZLsm?=
 =?us-ascii?Q?iW/mpz7mwlGypUGuviD0J3S1GzbzAQHcYiyBTJn9C0sCXSAkOXVxB9BOJ/V4?=
 =?us-ascii?Q?N+UqyhfNXc/ixXGDKNCclT55HNl1z+5z13dXDdNXbM0HnTGiI/OLyjgBCQiE?=
 =?us-ascii?Q?ZjRJB7WQv4lV/DNMrhfMg10LvIgyIqIHlIcyqttKyIAK9CziuXjxxfQwEsxy?=
 =?us-ascii?Q?9gH8e8kpsxPIevMcdyAv03+vOaNEc/uPSOGhbp1LsjsqK/Ja7yMoSleGbe97?=
 =?us-ascii?Q?bprSJYbxGfELvaeSFZiPToR9wSC6W690ix0qWpCbp09UEEw8gQX1H6yZ4oSl?=
 =?us-ascii?Q?uwxHpVtqZPuwY13wPIN5Uxt99QH2XnTmld0s4baC72mUGmtFOO6L8Py/jctW?=
 =?us-ascii?Q?dXnZ6WkzROgNJrAvUPe76kU8e4GdFIqTd3gA8qvaDMj0F9fBp4jTx/khPByE?=
 =?us-ascii?Q?J6GY3aK45noPhtml0l7lntv6m/TVAHkKaGkxmw0s9P+kdJbqdurGEsuxghXu?=
 =?us-ascii?Q?usP3ciDCOXX53SIFoGJVsHAa+nawzKSGAyodUQxR2O436365ZM4zdq/1MAsA?=
 =?us-ascii?Q?ySnDwys2h1BsyJU+6JqFaOsaLrunciJAyhRO7ef7Ta6fs7L9YgjSDzK4SJ2j?=
 =?us-ascii?Q?brf+7KMKyMNoQ4lEegKWDwJ8PIO+tgh0EL16jPRxnk6uZ3woMFBVnc5EfdID?=
 =?us-ascii?Q?dNW0cLkVRI109hKgsKicobNO2fDvplEmrqVlo/SohBKHFLNO9U6QEM7avrGM?=
 =?us-ascii?Q?gndTmHgOJAzZHGIF+YLJQokL1iyRdBknS+UVwZiVJTOYrvMVXqE7ZQiJ44jr?=
 =?us-ascii?Q?DEbjrLgscQ5CeCa+BKnpEIuiqvFufgInxl//DAJjY2KsJ8PiJ26T5d9KdcrW?=
 =?us-ascii?Q?ggkeHZ4X60sOyHEI+Ltaj0ZoVPv4ouNERyMufAJJiPL/bKF6g7gqond7hShp?=
 =?us-ascii?Q?hIowbzT+NbtsWQMhkEXFjaJJI8vpsAD4awBpTY1jTrK+QDpok3hx24lulrRj?=
 =?us-ascii?Q?1RIusR+Bz8jN38ogNUqcBhnOEzmh4Bw9YpaFdY/vqgbtInNBLmztTVWHnEsb?=
 =?us-ascii?Q?9EkpJeifB6Jh4xodVb8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 16:31:55.0493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61af6af9-e97a-418f-f1a4-08de04f5dcd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
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

Vangogh has separate limits for default PPT and fast PPT. Add infrastructure
to save both of these limits and restore both of them.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * split from previous patch
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 23 ++++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 ++-
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c4459dc553f0..e87e729b230b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -508,11 +508,16 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 	/* Enable restore flag */
 	smu->user_dpm_profile.flags |= SMU_DPM_USER_PROFILE_RESTORE;
 
-	/* set the user dpm power limit */
-	if (smu->user_dpm_profile.power_limit) {
-		ret = smu_set_power_limit(smu, smu->user_dpm_profile.power_limit);
+	/* set the user dpm power limits */
+	for (int limit_type = SMU_DEFAULT_PPT_LIMIT; limit_type < SMU_LIMIT_TYPE_COUNT; limit_type++) {
+		if (!smu->user_dpm_profile.power_limits[limit_type])
+			continue;
+		ret = smu_set_power_limit(smu, limit_type,
+					  smu->user_dpm_profile.power_limits[limit_type]);
 		if (ret)
-			dev_err(smu->adev->dev, "Failed to set power limit value\n");
+			dev_err(smu->adev->dev, "Failed to set %d power limit value\n",
+				limit_type);
+
 	}
 
 	/* set the user dpm clock configurations */
@@ -2258,7 +2263,7 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 	adev->pm.dpm_enabled = true;
 
 	if (smu->current_power_limit) {
-		ret = smu_set_power_limit(smu, smu->current_power_limit);
+		ret = smu_set_power_limit(smu, SMU_DEFAULT_PPT_LIMIT, smu->current_power_limit);
 		if (ret && ret != -EOPNOTSUPP)
 			return ret;
 	}
@@ -2982,11 +2987,13 @@ static int smu_set_power_limit(void *handle, uint32_t limit_type, uint32_t limit
 
 	if (smu->ppt_funcs->set_power_limit) {
 		ret = smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
-		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
-			smu->user_dpm_profile.power_limit = limit;
+		if (ret)
+			return ret;
+		if (!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
+			smu->user_dpm_profile.power_limits[limit_type] = limit;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int smu_print_smuclk_levels(struct smu_context *smu, enum smu_clk_type clk_type, char *buf)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 582c186d8b62..32387e8c138b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -212,6 +212,7 @@ enum smu_power_src_type {
 enum smu_ppt_limit_type {
 	SMU_DEFAULT_PPT_LIMIT = 0,
 	SMU_FAST_PPT_LIMIT,
+	SMU_LIMIT_TYPE_COUNT,
 };
 
 enum smu_ppt_limit_level {
@@ -231,7 +232,7 @@ enum smu_memory_pool_size {
 
 struct smu_user_dpm_profile {
 	uint32_t fan_mode;
-	uint32_t power_limit;
+	uint32_t power_limits[SMU_LIMIT_TYPE_COUNT];
 	uint32_t fan_speed_pwm;
 	uint32_t fan_speed_rpm;
 	uint32_t flags;
-- 
2.51.0

