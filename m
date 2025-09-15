Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44092CAC587
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 02:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B86CC10E29A;
	Mon, 15 Sep 2025 02:09:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="erYenJG/";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0F3510E29A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 02:09:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKIhJbyAw3Wpso192gxldwKB8LU2Gts8e4zYls6oxV8B5l6M1T+HEln/AHPpLgWy02YWZe+jLx1yLpLY2Fv2XXFKnBc5hHiG98Vhd7mWmCkIGa8XfnE80NTt311X7WvvQwAxGtEKWgEmRf0W742nFXQ7zboC1NzTvAidCxoDW1z0Fc+Y3XCTD4MOB2/rTS6bw+Inaf3lEAnDvIVo+XKk3JiPZISS4DwOrOBW4MtCBb8pzcZ89w5+U1i4VeV2GsldnPCopsdR4RPeAk9PDmijx5G+Sghfkp4rWT7AjCsLQkX/leiNF0XgRbfquYsn87HyLWgKANz//5bY+xt6zhdbaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tkl0qpucx4YCsLW6MWrB3VI9G1txSS78vaMq5dVje7M=;
 b=Y6OGEO/7il5OmSl56sAQSDIYdcj/5hokq9hEkFuBB8zXRBZLNqsd49C3FOjY/RoqKJOBJUsHv/CbBTbyg/HISChxAHrcLoKoMRweFCx3/KzF6ciXoOR/NLBX4NHGtoXgqrBXif1DnxSiP8Bw4NfyF8aVETQIySld3gPPFeoybBY99svHuc8PF/7U/ZRiCVzpr54S/BGx7taimOWnFdZcztnBoMh2xSRfBgJgZwZWwYKB0Q0F4c6urD26RduvP0WhBQ4ya76Cam/CN+jzpmmAe9CzeW5vTPMs4xROLC+L/EUL0WIx3Yx/DvMWjPq1X0wudIx+02A59BpgqSCfj9xrVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tkl0qpucx4YCsLW6MWrB3VI9G1txSS78vaMq5dVje7M=;
 b=erYenJG/ysZphDfLm7DfdnDQQBGRqmry3vFIeSwuAhzNAOK2KwHzfhHxNNjkr9A+mWDwCxahAaCLv0aCeXIyEG6b2XvAyA5orNn9s8uaBB/HA+Qchrppq6Em1hPun0f7kU3K11ktdX/3t+eWg/IFTbi4wlPBluftSYvN59mUUdg=
Received: from BN9PR03CA0204.namprd03.prod.outlook.com (2603:10b6:408:f9::29)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 02:09:39 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:f9:cafe::de) by BN9PR03CA0204.outlook.office365.com
 (2603:10b6:408:f9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.19 via Frontend Transport; Mon,
 15 Sep 2025 02:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.0 via Frontend Transport; Mon, 15 Sep 2025 02:09:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 14 Sep
 2025 19:09:39 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 14 Sep
 2025 19:09:38 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Sun, 14 Sep 2025 19:09:31 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Subject: [v5 4/4] drm/amd/pm: Add VCN reset message support for SMU v13.0.12
Date: Mon, 15 Sep 2025 10:08:46 +0800
Message-ID: <20250915020924.137122-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250915020924.137122-1-Jesse.Zhang@amd.com>
References: <20250915020924.137122-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 521c7ae9-dec1-4fbd-3b02-08ddf3fced3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zTB8u2TP+KS6vZqhj7L8CI88oddq7CUB03+LHWJDAtwh5tgvfy0FyoC/2jju?=
 =?us-ascii?Q?gDkZ76KVevaPn45rerMiYSnSNqCbmMYznum8Ujl3lYAc/ksglkNOF8y6na9Y?=
 =?us-ascii?Q?AaO357AiPm5ZcgxYpSL1fmNa8U6p4+QD5gU0KJnf5/WpPOB3/LT3Ea3lI++t?=
 =?us-ascii?Q?g73ncJfdM80Cqf0ckKcMNHCtEgBr1L92OffQQBxg+g2Ua7btbJcUuWB+vm57?=
 =?us-ascii?Q?hr8tWbKLQXQFnuxMCXuBANDQBqkDcVwV6eNncXWnX4d394oVCOg9tTwpUCJX?=
 =?us-ascii?Q?aaVFmCo91YRU7QYjG/TI6/cQ/Q4t1+DI1JSJa0pWZ8cRlNw58xVIRkY4a1wv?=
 =?us-ascii?Q?DvR0NVMjxOcI46dk68usniu3Voi8BvvLBrDKVEmjBOO2oJ6Y/Hv0lWUeRKI4?=
 =?us-ascii?Q?LvvAOQXFtU+NE11dHrOi7dx4ekm2H/Q8CdsyNuYar/evyFvN9p9ddkleirm3?=
 =?us-ascii?Q?xO1dzdnNKuwK3FbYdvDVHhpqTA1j/TBGSCQLxzxFjAWWM2Ghmn4IFx2cGuN6?=
 =?us-ascii?Q?TYjrMZ0v2sEew8KUyT9UofFfYuBNpvTpQSnpR4xS8Mr7EMihfdsbbHk+7Wqh?=
 =?us-ascii?Q?c6JSciDHker04SaulMYbPckwtA3rYkTCOfDj2fJvNieqBb+UixPTIlMtn56M?=
 =?us-ascii?Q?9mGHT5Wb3UkmVryYqnpUQvVPhW6K6dyR0IyFnzTXpZIpMPX2xI/buYzAr0QG?=
 =?us-ascii?Q?/Vc2TGWquRBPoLq3Pst3QwQdyBQNMrAhDgyPpIF1XmLSfLZ47KKEQcy/nHAi?=
 =?us-ascii?Q?1qQy6CNJ1gYDMSH+mBpJDzipG4IY9g81YNomHT3JiU3GcMrDvDR9Qsm19wVC?=
 =?us-ascii?Q?swgaLyJYe/0mas1+NompRm4lcU7mWnb62g+edCuYj4GLv/tbiyqsG492PO5e?=
 =?us-ascii?Q?bnkwk8+rvj8nQETwHAfX8TTj57QlfGCBwrRUqbYYFx6RpoZXnuD83QxRlHRx?=
 =?us-ascii?Q?qMz775Y+w5R3hp7crrRnIPGesCakeLVvRVH0qLH5PqJ4LotZmuHWyIKGLWx4?=
 =?us-ascii?Q?2pzSv0Z6JpqiaxJqqHq6dlgPj9q5DuEh2pF30rqqLPLjaReRo8ietpXmyBvO?=
 =?us-ascii?Q?AlJvyE6dvQVQPPIkV6l8+/vDLfXJ00xUgInk6KB9OqCLXllF3KQW2hKsZ00e?=
 =?us-ascii?Q?griHID3fpkguFjwrFgk5GUu9BVSreRkUGQ37KFZJ0ZCf0BTWv9EXUv4I4gXR?=
 =?us-ascii?Q?I4ksNF3f4XmLKHJO/Kjk9EUoVAFDTHI6Xy2hl9/pbbD9/81M+LvUujVcM54V?=
 =?us-ascii?Q?fLvCdhyZRjk/vliK8Hl+KBmTuqCCL5riBVsTondOs+hieippAUA7s3KBV4tZ?=
 =?us-ascii?Q?gJNN5UoTSqzBs1G3HEr/fe/Col++hmO5tdoaCgJC9ASB81kw44bljeiunaQn?=
 =?us-ascii?Q?Bk1HzCJMphhOsQ4Timdj/KQ2fc0prif+Hfxvfm5Myd/WdAfeQE4mlr5ITAjU?=
 =?us-ascii?Q?CCwPAtwBRLlFefeZcpmf8a0pwruhy+pxI4IqQ1Q2j+A7PVcHnI22HAMk67F7?=
 =?us-ascii?Q?z5Wzt1VLhj746fJ7Du/RVo/j7GzKj0/ihPLZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 02:09:39.3513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 521c7ae9-dec1-4fbd-3b02-08ddf3fced3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731
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

This commit adds support for VCN reset functionality in SMU v13.0.12 by:

1. Adding two new PPSMC messages in smu_v13_0_12_ppsmc.h:
   - PPSMC_MSG_ResetVCN (0x5E)
   - Updates PPSMC_Message_Count to 0x5F to account for new messages

2. Adding message mapping for ResetVCN in smu_v13_0_12_ppt.c:
   - Maps SMU_MSG_ResetVCN to PPSMC_MSG_ResetVCN

These changes enable proper VCN reset handling through the SMU firmware
interface for compatible AMD GPUs.

v2: Added fw version check to support vcn queue reset.

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c         | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c          | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
index aff2776a8b6f..4b066c42e0ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
@@ -120,7 +120,8 @@
 #define PPSMC_MSG_GetBadPageSeverity                0x5B
 #define PPSMC_MSG_GetSystemMetricsTable             0x5C
 #define PPSMC_MSG_GetSystemMetricsVersion           0x5D
-#define PPSMC_Message_Count                         0x5E
+#define PPSMC_MSG_ResetVCN                          0x5E
+#define PPSMC_Message_Count                         0x5F
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 0bec12b348ce..274844b64781 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -136,6 +136,7 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadPageThreshold,        0),
 	MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottlingPolicy,             0),
 	MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,                       0),
+	MSG_MAP(ResetVCN,                            PPSMC_MSG_ResetVCN,                        0),
 	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           1),
 	MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMetricsTable,           0),
 };
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index bcd6525ca5e9..4b5ec025463f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -353,6 +353,9 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
 		smu_v13_0_6_cap_set(smu, SMU_CAP(PLDM_VERSION));
 	}
 
+	if (fw_ver > 0x04560900)
+		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
+
 	if (fw_ver >= 0x04560700) {
 		if (!amdgpu_sriov_vf(smu->adev))
 			smu_v13_0_6_cap_set(smu, SMU_CAP(TEMP_METRICS));
-- 
2.49.0

