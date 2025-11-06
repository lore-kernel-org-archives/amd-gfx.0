Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37525CCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 11:44:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF6510E8A3;
	Thu,  6 Nov 2025 11:44:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oGsCqpmW";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012005.outbound.protection.outlook.com
 [40.107.200.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0798410E722
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 11:44:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWiwE7bUz5VciO7RYGanb0nJMQ7bjRRgJzyk/0JTOlTP8jRnt7aDqlujHPMD0Ea4n3AUCZM5NUR89Uifbh30IB/r7sWYNe3CmgUvFIjwe5sotx1T8VdziepwQNl0BnzGPnnDk5Q8WnvgfLh7eZsNBVc4GBC5d7MVOOXL5Snr0fTwUPqljKxWpS2OcwA/xyzLb7eMKjWjcqzzRkp4vnpxq4jfmxBUhqLfoPQ8Ql/jbuyOYPGDqokPr5SUTxAQ/pNAeHdX0x/26c0C4w/l60lNbhneh/GeNxLu77Nat0BChAWfJxW+G1nf21aqbxQZKtPVZZKe/44KxnoMWVxfTDzrvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UMe1sBsHqQ1E/HLZ35FzlcxLb6djImwmMoYD/xHq/Q=;
 b=P6vveIbzv7h+hta9HpZAtAP/R9Wr0TeWzEIsTJ0xpE9QaZzJ6qgGW2w+pnzMoGXYGPhg3Q+UmMR2qBHwhoVdGdGNAwxQ/T4R3zd8Xglcli+lxCTlWTk50V/Tc3cvaZWaIe8k43GTkMEUeTDVZS5krAaPD6xZ9BOE0F92ci+AHTCCZiFgguVjXuiYJs0f1AUonQbhL4/sfqD2ft/DLHmqUkc1aXVVbmvWeXLohZ7nfqasHcmrjJtq5vWvlqpu5/EEwbWTbqhTs009OvyL3uRXkZ+tQtUpDNl6UG8SiibrmmTXEeRecvHddg+iNYXYMTtZ2it/MvGcKnQsuH8rNQqRgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UMe1sBsHqQ1E/HLZ35FzlcxLb6djImwmMoYD/xHq/Q=;
 b=oGsCqpmWZpZdzoYZDaUvOv3OfMELjFM+FXwwhj/ELDsrAYBzUaOjNXR9Jcw/f5AktepaLzOwdSnMDlujciorFrrat/QHn6dW7zXExTqpEjtAFSR/zQUBB3d3ulYBKbON8F7c1iV7t3GHdvCuWipfNKe+Utzb1uhb38B3mkfX2H4=
Received: from BL1PR13CA0287.namprd13.prod.outlook.com (2603:10b6:208:2bc::22)
 by DM4PR12MB5868.namprd12.prod.outlook.com (2603:10b6:8:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 6 Nov
 2025 11:44:38 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::41) by BL1PR13CA0287.outlook.office365.com
 (2603:10b6:208:2bc::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Thu, 6
 Nov 2025 11:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 11:44:38 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 03:44:35 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH v2 2/4] drm/amd/pm: Add ppt1 support for smu_v13_0_12
Date: Thu, 6 Nov 2025 19:44:19 +0800
Message-ID: <20251106114421.3770378-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251106114421.3770378-1-asad.kamal@amd.com>
References: <20251106114421.3770378-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|DM4PR12MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 656e60a2-d0a3-45a6-5f28-08de1d29ddc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6wdISY1PFHS278sd7v3BjOgQhHvgk4XO9rP5Kzz20jGNSeY7JEL/t7kfijv0?=
 =?us-ascii?Q?CiU7hwIrmm+gQxDSicJg+v2xDK1oCNJ1m3hGeiJsnO+hwXjnLT8CECJTb1d0?=
 =?us-ascii?Q?6qkpq6GBYKuYyXOFVCRW+ekSTTu8VnwAUHtt+nohBg5k4n4tx1k7qm6oyBQ9?=
 =?us-ascii?Q?CMSGrVtyj48gRcoD6FO6eDKCUCR4nQUS4Uu0B8vhYOUmcCaHLBNI1GeL/X6o?=
 =?us-ascii?Q?eUg+FEmO4picZW8w2LsC8LOBrEPiekXNHDiFzBJWce+Kg/wwZWcALtb52kWZ?=
 =?us-ascii?Q?eBEVubNu8+n6N1qDuiudZgm87yQBzs4W+kmMj3RlUyVQeAp0YJWvjORlQQhz?=
 =?us-ascii?Q?taPfrgWFabFkInIZg9ZgWBeuLr08+4pOjyTGK5Fx+NpYy4uLvmmSBzZx82LV?=
 =?us-ascii?Q?t1BAQgUEY2g0WSN9KpvMUnlTB8FTobtWRUVN3j66nlONVvP02517jb+1LKyN?=
 =?us-ascii?Q?uRdHLqQ3CfOegZ/y20Udu7uGCng9haq8q0xWsNnoTmWoHVzNzp662B5096hR?=
 =?us-ascii?Q?Cy+Un2ry+wmifDsYZgrCaghjSScpMq6GmzTBML7opgghojatp+nnTvOG8FR3?=
 =?us-ascii?Q?3zU7oFlkkjVyBFhnZzjMVIwM0k7F9OtT74X3QBe8C+eBDfPTnoCdgx9BVeDd?=
 =?us-ascii?Q?1zBR8dRT4QxJJebbiCMXLCacbPDZ6DlXYh0LFXqd5Kp1Xufc3dTmV+/4EowV?=
 =?us-ascii?Q?e1xQx4ldYMUtumjod8Uj3QGKG1CNdLxhsBmdnFRxFhAVtuAZIUbRtt5Y2ivz?=
 =?us-ascii?Q?+ThwJBM2XHLYNTCQ7XoQiSitZazxs/O2U/RSEzsKIVznvKKL8NNkt/x1h4/k?=
 =?us-ascii?Q?M65WIPhYjagbH8t9M8x81iTjiNe1d+YK4zPKDpnWi/DM6tadISsCsEPQzbqX?=
 =?us-ascii?Q?lOfp9YeN0bvVCF7cRzg4AMoJCLN7JeXi/rHNEWOQ4TDMTYUL+86kshJB7Q9X?=
 =?us-ascii?Q?cIrqkm6bnK0/T77Pfxyzm6V7eJuTbeC/7NNsobwj2zcjDK8s2jii6Oou25XQ?=
 =?us-ascii?Q?BVEpZ+oNG1pHRr38XqSF2nCdDQgQpjjl+iaAiROi44W7vob8J6e7uknvJG/W?=
 =?us-ascii?Q?q8rMXF+DCz/ZWijDhOFgMIcqh5AjtIRgaT/C0ajIHiMp6d/XSy6IZU7/RHWM?=
 =?us-ascii?Q?SvAIm8LRi2z/Fd3h2Mbf93D7YHELwpWrNLuftZ5zw5AyL+FLn7ytnaUwSzY6?=
 =?us-ascii?Q?hl1yNJPWK9aflNFpEFgYrdG7tyUCnSIkdMLeAec3sf7Y6VRSP21WN7aG6LLU?=
 =?us-ascii?Q?I34QA8k/AnKrrGJib1hSxEw6uTuco5NY0wv5I1tHuq0gvdLuP1VZU5kwN3Co?=
 =?us-ascii?Q?RrgC4qDZw1m+rr1wstCdEyBDbOXckbYwerkWd+dLdutpnh4guYpaaHxq6avb?=
 =?us-ascii?Q?b10ZLP21F2wuiV8RFwPd9X7uk9HDKH/arEMjTpcenX4H++iSJzmzPK2Hfh4t?=
 =?us-ascii?Q?H5C+gb0S4GUK98PG2D0Pk1atFLvhbKkynNaRKjqnDkAMEzgTj8+Tduq6QdLP?=
 =?us-ascii?Q?BcgJC69KXnZ/6Dvqt5Wp0qRPzEux+qxYGKekjwIfLvoGapZj6USk9zAJsmHj?=
 =?us-ascii?Q?jzebS5qp9WNnoQgfqyo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 11:44:38.3993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 656e60a2-d0a3-45a6-5f28-08de1d29ddc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5868
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

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  4 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  8 ++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 79 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |  4 +
 4 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 2256c77da636..5fb71d4398f4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -279,7 +279,9 @@
 	__SMU_DUMMY_MAP(ResetSDMA), \
 	__SMU_DUMMY_MAP(ResetVCN), \
 	__SMU_DUMMY_MAP(GetStaticMetricsTable), \
-	__SMU_DUMMY_MAP(GetSystemMetricsTable),
+	__SMU_DUMMY_MAP(GetSystemMetricsTable), \
+	__SMU_DUMMY_MAP(SetFastPptLimit), \
+	__SMU_DUMMY_MAP(GetFastPptLimit),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index a0c844bf852c..e2851b26593a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -139,6 +139,8 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(ResetVCN,                            PPSMC_MSG_ResetVCN,                        0),
 	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           1),
 	MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMetricsTable,           1),
+	MSG_MAP(SetFastPptLimit,		     PPSMC_MSG_SetFastPptLimit,			1),
+	MSG_MAP(GetFastPptLimit,		     PPSMC_MSG_GetFastPptLimit,			1),
 };
 
 int smu_v13_0_12_tables_init(struct smu_context *smu)
@@ -345,6 +347,12 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
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
index 197fd91e1fb4..282bd00a909c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -851,6 +851,17 @@ int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
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
@@ -867,8 +878,12 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
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
@@ -948,7 +963,8 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 			smu_v13_0_6_fill_static_metrics_table(smu, static_metrics);
 		}
 	}
-
+out:
+	smu_v13_0_6_update_caps(smu);
 	return 0;
 }
 
@@ -1882,9 +1898,65 @@ static int smu_v13_0_6_set_power_limit(struct smu_context *smu,
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
+			break;
+		}
+	}
+	return ret;
+}
+
 static int smu_v13_0_6_irq_process(struct amdgpu_device *adev,
 				   struct amdgpu_irq_src *source,
 				   struct amdgpu_iv_entry *entry)
@@ -3934,6 +4006,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.get_enabled_mask = smu_v13_0_6_get_enabled_mask,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.set_power_limit = smu_v13_0_6_set_power_limit,
+	.get_ppt_limit = smu_v13_0_6_get_ppt_limit,
 	.set_xgmi_pstate = smu_v13_0_set_xgmi_pstate,
 	.register_irq_handler = smu_v13_0_6_register_irq_handler,
 	.enable_thermal_alert = smu_v13_0_enable_thermal_alert,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 7ef5f3e66c27..4a47025b49e0 100644
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
 
@@ -72,6 +75,7 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(PLDM_VERSION),
 	SMU_CAP(TEMP_METRICS),
 	SMU_CAP(NPM_METRICS),
+	SMU_CAP(FAST_PPT),
 	SMU_CAP(ALL),
 };
 
-- 
2.46.0

