Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0FFC87FCB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 07:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62F5610E03B;
	Tue, 12 Aug 2025 07:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MgJh8dTl";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F299410E03B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 07:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wx9z6NnIQjUfV+fGmeZH/GN5bLI/ARFyg6YUNiLIBL6wKErxlLSlnsdUOrW3qPK9iB7+6jrzO115yxa28HNTB5GhRbAjVdnXt5U12sHriJDTfPktW+cleuo8vSaut4F5IX+juDtiqaMRa0cH279hQ+dIeS1FMY4YVVP4VkK1UrpvUq7b5N+cqgMF5SRmKZRftuigGVNpptBzD1C9mKKUspB0z8wYW+ptoE0GA+jlYewzBUCgnbwQu1B7HcKacdcouBJ0NGBS48JqCqVHkNX2q0vdlCVTFFzTyvm5S/Q/zIeMrRZZaLwbKHnNvbXlDqEM5QUPCiepb3TOF8S3mqIBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XODbrI+edbGSCmBZgd/tqhF0b2+k0hiGKnqwQtR5TFo=;
 b=rtzHnD7l6Ee3zHba2tPxK5Zi/XweINglCepMA8i6LbtYgg0eDYL6CygAcv5aWnzezWZfwEQPWgF2JdFcmzH8ghlXz4nHqyPQINkEzNJUVC8wR6FkWlqB4UMpPz8DJ4kOCp5HD/zgeNfnV2cuULveAJs1Iy7lsj6IFRdk5z7ouoQ0pT1VXErPCy2QLQHWe9Sj+XKKbZNpkVuplbw7aQI2p5rFSYcWb/wsmEIyP8zJsSyO1cOVwqzniotq+Di+UQX0rXEDdd4LC3qoIIddDDXpc/yVQzgYbIgOinqyG2p/eiiXb49CyDb4rMgJfKJbtlNIT9+yiJlpdMuJWzieK/ZkFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XODbrI+edbGSCmBZgd/tqhF0b2+k0hiGKnqwQtR5TFo=;
 b=MgJh8dTl2WT7kzY5IrnwpjYSe1wG6gu0XYeLujiP65BgkDR5xZlNQKmRBUFXwueh0kpe3ggSy/FPPxUaYnHimJyvbOujTxk14fvDsY6qaGR0ERqz/pEI4P10y+vm1FrsDzNGHUDZO3wpBCRNTHklp3niYeh2N+rRSomxf4uqqHA=
Received: from BYAPR08CA0058.namprd08.prod.outlook.com (2603:10b6:a03:117::35)
 by IA4PR12MB9762.namprd12.prod.outlook.com (2603:10b6:208:5d3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 07:59:35 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::c6) by BYAPR08CA0058.outlook.office365.com
 (2603:10b6:a03:117::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Tue,
 12 Aug 2025 07:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 07:59:34 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 02:59:31 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Free SMUv13.0.6 resources on failure
Date: Tue, 12 Aug 2025 13:29:15 +0530
Message-ID: <20250812075915.1893393-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|IA4PR12MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: 228bd5b7-320f-4929-b4a2-08ddd9762d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TPjePBRhxUlYe51vgsBzxpgBs69IBfFk0ui6mq9LjKGsKMfq1QjVOgmbJjS1?=
 =?us-ascii?Q?J223JY0pSoNpm2oqYBZvBtb5SgnFOctgLgA5PiIt1+AF0+4FqC2KsfNl2Lny?=
 =?us-ascii?Q?tpCXcwkanKaSbrXuOetRQzBE6wdVkd5tjXRZ986/8GWYc0TaDFy0U1HV+K9Q?=
 =?us-ascii?Q?zjvI91yy6HIbLzV/+20Hf+vglcmlm4gh70IRlOqAvC4wse+RpSOu4YByknQv?=
 =?us-ascii?Q?PceIXJDfM9I6F9nucZhpgBvcVGofAyXGPOPZmnM6VuNkvdSEdgPPwaI/5uw/?=
 =?us-ascii?Q?hiOyqlVOXw/FHtmMbOd7YaqEQcyeQmzIUMRbhNl429VT5oeAhhh0nQvgzj6T?=
 =?us-ascii?Q?galeRzwM8OSm/uD9GfnRKmyYQNJkK725CrP7ciAoqu5o6CCZHEnpcHA7gIpf?=
 =?us-ascii?Q?ifF0/IjXaYsDIJtYCVDE4jjXb921vyBpcG61EK6O4ktxberdPN2VI+2w/Kjg?=
 =?us-ascii?Q?MAHApbahu4FYUMAe0VgJlbDXz60/AbFbpy4P6xNG+c69L+F19pWjxsq2j/EG?=
 =?us-ascii?Q?m8CdTQ1+m+mzo9J243tlB5PzkuOV7jBL2CQ026TJkdRwiXMAgKmDk+Mlizet?=
 =?us-ascii?Q?HWoyeiGyn0Kj5BX7xH4zxRo26R4D2afS0x5oIvoOBrzzFIHrm571euOch+OS?=
 =?us-ascii?Q?zB8CEUScKrfQXgX3QrJeK6y8aarbbuSgAyL+1xLoQkuDN6BKDSXyf+aAsspH?=
 =?us-ascii?Q?mTpmITYT2YWqX6D6Vu10zSLajXOZRnSUaDRzxZrn3BbMdtxL76vcLp97vyXm?=
 =?us-ascii?Q?EEngA81XUgd5qEsx78xjzDYYnvosW1Yt8L46fZYw1OPKrcNFeOzLVTxBFsVb?=
 =?us-ascii?Q?pVUHXYbZONY6X9nZfgnxNoGWFM3iPNcKSsMKt+lyreWddsqyWG2Agmsg+XGb?=
 =?us-ascii?Q?b6kD4eTq83AG5XbK0ohnO77K5hEUKilIIYcPZHHl/MRvYLfiNexlxWpoHwRv?=
 =?us-ascii?Q?cswbH5v1xbyA7B0rFQJ2vc6UfxYTojDeIM74lxcIN7YTIIOyfvFVRO1/TaMA?=
 =?us-ascii?Q?InL6g/HuRZyOqgQ5n/fNPmD0Ka+EsPjOyQSvgjP24pswvS6zRrJTJ5fhrfKa?=
 =?us-ascii?Q?dUc8KenN4rx+qcy3L8GxoxpySZPQAwscCWIVi4Ha0y6B5k2JyE69JmZImamZ?=
 =?us-ascii?Q?zjfjD/Kzh5jUI+rcKEz4Gen1FCMRkgNbrdpf1ymJxVg4m+w65f/AzUmHY5qw?=
 =?us-ascii?Q?1GgqM9en+XX5bjHjqM8S+ccCH5AmtE0cHOCkF7fomj0Bpy74W0nI7KAGwbB6?=
 =?us-ascii?Q?s5nc0dY5gszIM6moDio4im99FFWn2j1q3PE/v7dCceqZssgcC8vqMhmuoisr?=
 =?us-ascii?Q?M53gaLHE0gGOpTAMD0QhLYY/uge+qrf6r4cvMgfKcensi9lmfD2UHZrF7X4t?=
 =?us-ascii?Q?Z3UoZx/DSDAbOkQmVGGUrtQtgk0J0+iKT8PvLwQlONM4WMUxUJZwUcuBSOOT?=
 =?us-ascii?Q?D5/iLsnOpPt/dEsGNj4PM9YVgnM8hYjGfw5GZCL7k3Wsw8V2QmyeJypnkoaI?=
 =?us-ascii?Q?ZF3J3qzb094okO/EQr397UhuMIKrV510XWtC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 07:59:34.2354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 228bd5b7-320f-4929-b4a2-08ddd9762d24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9762
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

Free the resources allocated if smu_v13_0_12_tables_init fails.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Fixes: 22ef8851997f ("drm/amd/pm: Add caching to SMUv13.0.12 temp metric")
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c    |  4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 12 ++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index ea2682f9d579..32fd0be05cff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -161,8 +161,10 @@ int smu_v13_0_12_tables_init(struct smu_context *smu)
 	/* Initialize GPU board temperature metrics */
 	ret = smu_table_cache_init(smu, SMU_TABLE_GPUBOARD_TEMP_METRICS,
 				   sizeof(*gpuboard_temp_metrics), 50);
-	if (ret)
+	if (ret) {
+		smu_table_cache_fini(smu, SMU_TABLE_BASEBOARD_TEMP_METRICS);
 		return ret;
+	}
 	cache = &(tables[SMU_TABLE_GPUBOARD_TEMP_METRICS].cache);
 	gpuboard_temp_metrics = (struct amdgpu_gpuboard_temp_metrics_v1_0 *)cache->buffer;
 	smu_cmn_init_gpuboard_temp_metrics(gpuboard_temp_metrics, 1, 0);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 3b4bd7a34d04..bb242ac60758 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -534,6 +534,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 	struct smu_table *tables = smu_table->tables;
 	struct amdgpu_device *adev = smu->adev;
 	int gpu_metrcs_size = METRICS_TABLE_SIZE;
+	int ret;
 
 	if (!(adev->flags & AMD_IS_APU))
 		SMU_TABLE_INIT(tables, SMU_TABLE_PMSTATUSLOG, SMU13_TOOL_SIZE,
@@ -570,8 +571,15 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	}
 
-	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12))
-		return smu_v13_0_12_tables_init(smu);
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) ==
+	    IP_VERSION(13, 0, 12)) {
+		ret = smu_v13_0_12_tables_init(smu);
+		if (ret) {
+			kfree(smu_table->metrics_table);
+			kfree(smu_table->gpu_metrics_table);
+			return ret;
+		}
+	}
 
 	return 0;
 }
-- 
2.49.0

