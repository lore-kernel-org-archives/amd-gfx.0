Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C6ACA0EF5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 09:01:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE4A510E554;
	Tue, 19 Aug 2025 09:01:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O4gZVnCw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E9E210E554
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 09:01:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZK7CF1SUCsvXeUXi2oXDXhMsabX3IFql2NMpydu+6y/fl8nYL9YlZMZzpCbgzkAxPCoRY2Xysoh20yoId2+aaKtGCFhRTutoQ7TqH4MkCxWqzIt7QtmJECDKO3n8flpXtcWEQJTkn1kKXlkIJDlMA+6IeFQrpSO6O1qWLUoNuHbrUxXDkRB3D+LhUhfGEcXNiDrGE8z+M1ApfCeazXGkf6JF20Aqy8ElUE43nXUKV3QwavvxPruuLUYf9NeCOg5izFnSLNFSQW+O9oygT3d/KhcYVOUXSaN/oRQCavC/4taeG+oqUSPMlYZhxM8EpOragGNgQv99UjsVI+3MyROtPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsa0xw2R5Uc0whIwdoBzFP10dHj9SgA3YXm67lR1g64=;
 b=qyXdWMhisIfYe+MW/JxG927CkRh65eiBNuZm/7nlGGZuNr2h5HfRdKgvtWPVr165eciYoxZcfAYWlZ4Gi4/BSGDBBkXXWZnWw3tGy8O5NZGRJkG+jDyHmmuizOTL8anJV0AyvveLXDPNFOZ2P61E0n3OWtQ8/KUp8h28sa21UYcj9+7DplyxzMp9isFKnRMsLQaiSfSOAJ2+jMDFT1u8nmaVQozBak1wfDLACTysMAEokhCt7YtpLbAhNqhX3bq+ZjMl0h9F9iHdnSxLoh6ma4mygbFoawjZzYYOolcTmdCWIAqg8h93nMeb5bgZ3iN4pBNPG63yQKklZSV2NJvroQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsa0xw2R5Uc0whIwdoBzFP10dHj9SgA3YXm67lR1g64=;
 b=O4gZVnCweNt6y9SSSoZtqEEOWOyK8VOJhyBNQ3L6llRTr7rswfgMcIJkrzGoVc0G7ihWfPOkHJ8QOsFGgEQ7Z11H2MvYMFBoz8i+ohJTqoWeCVrVU2/wxklaSIsj9mFpbSgqbWDRi2nHCZk852VU8abVLJClODGmjApsIOXY9jY=
Received: from BY5PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:1d0::31)
 by DS0PR12MB9397.namprd12.prod.outlook.com (2603:10b6:8:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 09:01:00 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::8e) by BY5PR04CA0021.outlook.office365.com
 (2603:10b6:a03:1d0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.25 via Frontend Transport; Tue,
 19 Aug 2025 09:01:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 09:01:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 04:00:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 04:00:59 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 19 Aug 2025 04:00:57 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: Add VCN reset message support for SMU v13.0.12
Date: Tue, 19 Aug 2025 17:00:27 +0800
Message-ID: <20250819090056.444457-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|DS0PR12MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 7412614c-8f2e-413c-048a-08dddefeeb06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KdIvFmnqgsD71cYffJEqs616MFtMR0kfEsiJY/cKBiMLG79ygMSfwT93Vy6U?=
 =?us-ascii?Q?cntUqsOP1QL2tmHgeTXn4+bHpKmmvhvk9xUFWVFFlV2MGM2BDxSyj9maBA59?=
 =?us-ascii?Q?Eg0tQb2IkI9yqtBQhxfUVjPTl4ORWTcfXa9FxqRiPB5NQq9zxiGwBZVfQMQM?=
 =?us-ascii?Q?6DgtKmC+At20zBnoj0mawuu3mgxLwkODYZDnsToyeeYekomrgmeULv1rHeSk?=
 =?us-ascii?Q?pI6W8jsYFJ/inYPXSNqCl4eSFF8N5HGaTkEc7snWDnS6HOrzIuM6/oUS6O0y?=
 =?us-ascii?Q?225HHkGuxF5VkH4vhckKIxdJhEy2jjaiyFRKLj5lpYN95LmrHQB98s4mLVBj?=
 =?us-ascii?Q?VK4ekTdCy/+E5x1eHc4VD7VSopKooVU0DkzCTPfo2UwCW9ydjWE+QOzFWqtp?=
 =?us-ascii?Q?LaxlptS/hGiLppA4EGxUudD5YlWNe+QiR/Cg0OSgkipeEhbYkgzJdXup9JiU?=
 =?us-ascii?Q?kld9a2+domI/2/ZW9t6KdsipcQVkj8QPQxSAOqUnv19yJ3KMaiAg5JyJ5iCf?=
 =?us-ascii?Q?ihH8m6AfEOQ4C6dc1UGUxjBkf4qjl5OYA4peFhWEU/H162vNPZA4aGWAKeEo?=
 =?us-ascii?Q?zzptCQ0FffrUwxgj4qvOVNcqecc8aFmD8bedvH3EWI2pazCfSgszDNGfnOdq?=
 =?us-ascii?Q?urEoBtzk/agDe1nVx1LXxcFzHWDt9/2k1IxP3E+ZorxMduOUZUg39emnXHBN?=
 =?us-ascii?Q?rfS8CJxhMYbyLFGbJWv/i9oUkWukR3OQ5suLEfH/EZyVcr6fkuFUZaGdVfXD?=
 =?us-ascii?Q?oY6zOqarkyXFnbFcBF9kMW72Ijp7Ply7iJHDgD7Z/CJ7Vpe3r9FPfB5CBIg9?=
 =?us-ascii?Q?SsrRRMAODVMC5ybOxuHfPaY6T08SC8xnXl8B2yElRoiJd5PKWNY/xvHE9yz8?=
 =?us-ascii?Q?CsACqRBr4Ssjrv+UqweOOS79YgCjpXEq0stTbE6qxwAMiqur+pbleQi7L0cZ?=
 =?us-ascii?Q?7v4vmy0St/2mesU6/WROdMrzJTt2+Vv638OWZr9In77/tsgemnK/w8ZKWc0n?=
 =?us-ascii?Q?eMuJeXYxHOoxirwfIEKjx40L4EEohsfeZ9dD68vmIgo87YRUAeRDcmxJEDpu?=
 =?us-ascii?Q?nwQWQmME6crBixmD+2lZfoD+emvWClg8DSyPqnthekgpkrHJzaEHEXscKr5n?=
 =?us-ascii?Q?fGsOsxfoMGt2FgnsI2UDBnr65++bDd/I6taCZi/V/bQLj5vEkgB41G/EG0kn?=
 =?us-ascii?Q?gIaWc2/ZITlySb4d/lHTU/WOp9mBEN5IaSdhrjbJBNd3IvKkod9+aq+EYPqr?=
 =?us-ascii?Q?IzfdqqXLfHywJbKB/FsY4gI8M23cGtHTY2YqrEA3rdT3YI3Nz+8vluSQ3Ha4?=
 =?us-ascii?Q?AH8tKDa3xkevp7lJvhmTJu/1qcZu9AOxJnRyxMjK1qeRZXZjQo3g6gQRXJ0X?=
 =?us-ascii?Q?V8O/41gegngoSioYSAWKrg9k1FXX+6cWargT3DVhW45dnhv+k9kJ+G55uVwd?=
 =?us-ascii?Q?vJi07LZaeYOcRAa710ACjzMN0pXmZla468ax4HuVTGM1424SwhC1iYRrr4Ia?=
 =?us-ascii?Q?NEB53DCRFPWTNCQDwOQbusnkQswkxQWvCnUQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:01:00.0243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7412614c-8f2e-413c-048a-08dddefeeb06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397
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
   - PPSMC_MSG_CPPipeReset (0x5F)
   - Updates PPSMC_Message_Count to 0x60 to account for new messages

2. Adding message mapping for ResetVCN in smu_v13_0_12_ppt.c:
   - Maps SMU_MSG_ResetVCN to PPSMC_MSG_ResetVCN

These changes enable proper VCN reset handling through the SMU firmware
interface for compatible AMD GPUs.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c         | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
index aff2776a8b6f..037529eb70bb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
@@ -120,7 +120,9 @@
 #define PPSMC_MSG_GetBadPageSeverity                0x5B
 #define PPSMC_MSG_GetSystemMetricsTable             0x5C
 #define PPSMC_MSG_GetSystemMetricsVersion           0x5D
-#define PPSMC_Message_Count                         0x5E
+#define PPSMC_MSG_ResetVCN                          0x5E
+#define PPSMC_MSG_CPPipeReset                       0x5F
+#define PPSMC_Message_Count                         0x60
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 32fd0be05cff..a3eb19f702d0 100644
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
-- 
2.49.0

