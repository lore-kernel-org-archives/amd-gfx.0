Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB219CCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 16:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD6E10E95C;
	Thu,  6 Nov 2025 16:55:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rRtrEweR";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012022.outbound.protection.outlook.com
 [40.93.195.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3622610E95C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 16:55:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGmtT+mlYxFn8mTS42CzO+QkUiwPS4hP1yk0/3TXwnacmsvTsk4WRM1xiXvvIsqtCCNlOsk2yLFC+gJYJFaTMQasRTmC0Ade/iudn3ImJh3MbVSWDsL3WZoaGqCrMtEwjeRBZxPyR8+900yNZav8lpiwNmMibLu79Z64hDio6zzaJRdddMvPUII/ljj1N9C2wo83a7Ph7P81fjPWYVDdumLd3jJ4sJ2QNMnj3tWMTe1JTQyptzY1j/e/R11fiokuAIBxsAUfOMZxRSoCplCknBml/5xjFWiVQzgYzTaFWvuFfyHZ89L2LCpOmnf8vi587y9wL2eUD6bXMlfVpqQVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kz9aBBXdTXb1WwGPe7Zp87TCERpSMpRM3LTGHtjV80=;
 b=erEumlvTXPNeJEK1r+zZMFFwqZ8AefnXSNfp8SwAld6t85XWKAe72LpJkL2awz2YBnruOAS8hAPK9KaeA7HA6ybMV+heuPcBkq5IQUEhCDfQaE/A+UB/P5cj4tErBUvHdAmPiijKOWotBFJCDQRVhl8bmX1jMk7vC/ZeQyjosHPRQ8XGXNL4lkP8zQo85vN9vQOpOt752K5dtQzmVJQSRVXdN4cDPlWSqjazvbQ5SIHAK1gAFQo1rvLt4z0bDUd6D9OjZbJY1Ox7BMPots2kG7i5iuI5COaUOoWIBxzTDg3NqlOKXCKHNFNcw6GxECSNJTXciDJoe4bm+yuRJWHAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kz9aBBXdTXb1WwGPe7Zp87TCERpSMpRM3LTGHtjV80=;
 b=rRtrEweRXgXcew0utDZRV/Liqwllb0mwHtJuMgviNYseK70dtRP5qrMm9UG/1gs6SckAVz9kiulpkD3AJEfZE34RlVwk+jc2JTCr+YlN0AnDN0MuBPKAd2VzeaWasaqzarnM/TvB4w6FBI16Ys9RrKwQKhf8jAPdvjFp4H2K5rs=
Received: from SJ0PR03CA0253.namprd03.prod.outlook.com (2603:10b6:a03:3a0::18)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 16:55:28 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::58) by SJ0PR03CA0253.outlook.office365.com
 (2603:10b6:a03:3a0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 16:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 16:55:28 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 08:55:24 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH v4 2/4] drm/amd/pm: Add ppt1 support for smu_v13_0_12
Date: Fri, 7 Nov 2025 00:55:06 +0800
Message-ID: <20251106165508.3785924-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251106165508.3785924-1-asad.kamal@amd.com>
References: <20251106165508.3785924-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|SJ0PR12MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c1c27b-d1fe-40a5-1279-08de1d554a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RSiObLtHcEuAg1Z7hxScF61YZZoiP2cT8V18U1b4Zlz9vpseWDWijTKfo51h?=
 =?us-ascii?Q?qrlCWEJ+CT3+NlC4uHFMb99MsPtovLBWO7StW1Nje/+69agqeWlzhusuI/vE?=
 =?us-ascii?Q?f+q5R3ctV7HIzPHAMLQyKMZZeMwuANV62x4Q/xdk+KWCS6WhUyY4loyEE2Ci?=
 =?us-ascii?Q?HHUuAWWa+NmU3I2tnK2R7XOR7b2uZ/r8OwefUFHZGTZBh9IuUIrQU41ASHtJ?=
 =?us-ascii?Q?aPNvdcF2yAhZd3caM8ms3QHyp0b8WSu1aEQmjOVo9PluGxWzwX6T+9Pg53pm?=
 =?us-ascii?Q?TGaDI4lP107Dv42f92EGK8Nzrx5TjdBGuQY7oI/UWMbrXGOx20UtZahvDVTq?=
 =?us-ascii?Q?rqweVpO4VnoHX7ULWOq5vF6BdP5yNMhIgptXUdmB48pWR3wk9jmyHEb9AS0f?=
 =?us-ascii?Q?EpSOtD5hFbx1LdIHHaMYcWRsIpV05O/lVa6bUwGyDuF7QsMzuHdPKNCNTxXa?=
 =?us-ascii?Q?T23A4O4loectTPalYLm7AC61dj2ORVuaHOpImUiKftsQ5czhD3OFgphaCY+j?=
 =?us-ascii?Q?lXj6QaZkvIKEqwohhkWAOd1O4IJ2y7y8krOd7FqnfXIvWUQG6AeuslZ73OBq?=
 =?us-ascii?Q?R3nTWJGoFmxs1Qqq/ljs/Ag6zRdBJOI9Os0UfV5YN5ivlhIbpAZKoV/vEgVw?=
 =?us-ascii?Q?0lv4Jj0WDf5nxkgz4HX123GlEU2rNTGODPoFY7RHPMQ/RLz8YuQcSP6jCjrR?=
 =?us-ascii?Q?kCJhPJfXqDcSHRJbnLT4Kz86rt+vSQendGDAE+IPPsQN+6TMb2Awa0El+lz+?=
 =?us-ascii?Q?o11h8Qpnma0/juP0NlCCJN5Jkuh7hRfNoa7CjPnqp/iiKVJMF7kgJkKYXkud?=
 =?us-ascii?Q?TXupV0xusBUqc5HyuRy8YXS0eu4q6pJoXavGWcYc1ljDTd1QlhzCpXI9Utya?=
 =?us-ascii?Q?tCwWYua79JBieA0SJdPXzsZvFDsTg8JelXoO4/VbdSIgw32C0AMgSBAKPLuU?=
 =?us-ascii?Q?SWJqcY+AnfYa+HylcgNFPO6BdV+3aU3agiFa4zzIKVwZeq+Qy7OYZKvFfAEZ?=
 =?us-ascii?Q?1RduPKj8Qm/UBbmGJkhy6faWBPQe0dm1pN0YubrOVS7cx6pmK+lK7Wk9+9Kz?=
 =?us-ascii?Q?xR6ZLskjKA6Ek6W7Sq1l95fKYUsWTtDKkLFjghbnQUSiCuVro+YjarKGHsap?=
 =?us-ascii?Q?C2r/ajPPqqam0KxEyA5lQcr0cW64Yta8Hv23CbJs8mz+LSyL0bgJOreRlW8T?=
 =?us-ascii?Q?kFYkd2xnIYLwoV0zADC67DWB5eSmcBXxGh5rptO6hueL1CBgBuaZUs0dXYos?=
 =?us-ascii?Q?gUUU6343z2NRDViAIEnsMJzn9sRAFu1lcl50W6gr2rALFjF2PYlckuTaGHjP?=
 =?us-ascii?Q?N2LE29HYp3AOOOGsp9E4tryyUFLttCk6BvnzZXtqszxWkz1N+9PkGS7+rSRP?=
 =?us-ascii?Q?7Tw2YZHfXfF4Zi3B4s40uFGiu1L8Lj2IXPBsqUkngdOQuNNAYNn8vIbiNIk0?=
 =?us-ascii?Q?ikZUTwbYmFA34k/HjwDQcW+ZsR6PsQcRUzc5QIxGyP8Ptxpxy/6fxq3+mMaF?=
 =?us-ascii?Q?/Gqa3vdB7dLi0EaAhr77W9CmoRxide0ckv7ZgdANHjRcIv7LO0GHjETCI2yo?=
 =?us-ascii?Q?cd0TqHThF3+nKs5m/gA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:55:28.3958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c1c27b-d1fe-40a5-1279-08de1d554a0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005
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
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
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

