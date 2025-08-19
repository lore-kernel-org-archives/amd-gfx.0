Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742CBCA0EF8
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 09:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F73910E572;
	Tue, 19 Aug 2025 09:18:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hqmu5FIN";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C491410E27B
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 09:18:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNwfPclllbynhD1hWxAkjQfVn+B3DcibSXTQr+BzMIfhx6Ah21GERrGq/PcPTKtk/w2v4YPm3PE5FmjAzLLW3gkLhcMF/NOdKb8TSOj42jRF1n+C+jip1kL7ukolqgj0VSLTHVhjNS8JkwVT1d18sgvQERxDNXFqtLePagUYX8tKpSgMrvKFtI3tmaa09j9Rv0g+bkN8ZGdAongKf59FfS1E1f7RYyfkfsEqia9n/KnNIurbLOlUarCm/HyBO4++gVvZ3dUfwMtbkBQRHKtan0NUvbYnLbXciG6qAhtQbjImCS2maIGheKJZiFyp0nv1pfGMqDvacdGYuqL5qnfvIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsa0xw2R5Uc0whIwdoBzFP10dHj9SgA3YXm67lR1g64=;
 b=sv86+m02Q6oRijTdslkiMI6KvanNfM7FRVQl4LIn0Vj9rMD0kvfG+TNXLIG4UJw275HgAPsAeD/Mf1OyP4PYzn/JUik+UnxEMlVw9nqdaa4GMmtsUDbGKZeeT0TBw0GvwNYcoUH/GT9Qb4p22+PytIlnD5HsJsgZQEeHgfSG8I4gnqiGyc1blzsuWIheMjv7WM+y+LjYMjoLURTg5qG+78V3F12NTRnqcdyvArqw1I8Vjwj/EQLO10u8xv29VRGrnTWISbqm/TeSM0Es5y/r37SVclG1NnyBTUp3SwBN3OiTl9YxfMoAQRTtZoJBT0gepcCI1HP8hS2yZ7ba6Vew9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsa0xw2R5Uc0whIwdoBzFP10dHj9SgA3YXm67lR1g64=;
 b=Hqmu5FINs5LB47sIVdyCkApjbxHlIKBum7hdz9Eh5GfU5/ugg2JgVpSTYtSfxBWOi5GoOPOTSjtKNhAti2bCY+BExOAtXPmh9suXRPWhyEAV4acX2hdiDa32SyXTwk+RANqllXv+c2KRZJJyqe19D7qi2ASEVIKASuAo0cwDgww=
Received: from SN7P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::17)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 09:18:15 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::33) by SN7P222CA0007.outlook.office365.com
 (2603:10b6:806:124::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.25 via Frontend Transport; Tue,
 19 Aug 2025 09:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 09:18:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 04:18:14 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 04:18:13 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 19 Aug 2025 04:18:12 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>
Subject: [v2 5/5] drm/amd/pm: Add VCN reset message support for SMU v13.0.12
Date: Tue, 19 Aug 2025 17:17:09 +0800
Message-ID: <20250819091802.445099-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250819091802.445099-1-Jesse.Zhang@amd.com>
References: <20250819091802.445099-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|MN2PR12MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ada49a-3803-45ed-1f41-08dddf015389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MUyagnEArg4jjc+5VT+qtpsGygD/++TKQ8nkB/+JRtDIRAgsCnFMnlrNka3B?=
 =?us-ascii?Q?do51GxHbHdtDiborxK6sn0uWNZhqLFEYnPFGmXU8pt7QEHnfou86XOvyDqmw?=
 =?us-ascii?Q?7gGEfjyv+JNOLyHV26mZaTMffVy0Yrgc1VqKs04cwPVVclcaqg6T1+NdcSDy?=
 =?us-ascii?Q?WRma2cRAODZocofB6Vuy9gtOmLmvlZBkGPfRYy7Us1rBTvr8ajXWpIk+qZoL?=
 =?us-ascii?Q?vMK4NriDblH87Xu2s3VKH+7R8b+wUqVVEBGqDrn8OKjEN6GxkV47oTRiQzpR?=
 =?us-ascii?Q?OGJg028sletrcb9rms2uLio8lqZG+RDBqM/+hmXlO5ZueifK2GLKvyQ4zGio?=
 =?us-ascii?Q?x23NyVqsfsSX2XnjmDFSkVtH0qVvEY7VJJReqIGTt/P2aX3KouRXfaSQVPGm?=
 =?us-ascii?Q?Al6cSZR7wQhV4KErZ7zUgEVY9VvECsZqzbfel86/Eji61EOR8w/4+1cBePsW?=
 =?us-ascii?Q?+o2+PIrtaUtglK4ufxUhoG+BZCOJ6BLsZU11IYmLuN7t0VPbLaQ7aWOdixyQ?=
 =?us-ascii?Q?NvTjnfs362cA233eaKg7G7xo85NYKD5IxjLu1tKicxKNdx1yqXVYQfWBDhv4?=
 =?us-ascii?Q?bKWFeNxtnFTSEPBgGaJq61FBMRNnITWAE+k6ZX/60pj8tfHiRAQ5Rifgxom0?=
 =?us-ascii?Q?pgBbAMSyQjLs06ddE53TxjV95yV050yMEqG+1XOd/7MJkodvlUU+pO7yiabS?=
 =?us-ascii?Q?qScDgbKu7fqALziEwH+3NJdUjG4C2KqxyA45D2XL2VUsKYlFrK2Oda7HFXMN?=
 =?us-ascii?Q?GwPBKPCBflGYORQZziDEqtzByluGgI6uV0VGWDzDQhVmX4bSRuERe4eUcggE?=
 =?us-ascii?Q?nq4XlEEPLjm5kUPg7mVUUeUOm1/ldy5owfCGfRS9mvTz1C3JIF9Qh4ay8QDN?=
 =?us-ascii?Q?dJCrzN1u5TR39P7emwOLGMOgMpof0VP+LR2fcvNH4BWLQNNVbjVEwHk+4bpa?=
 =?us-ascii?Q?LYMO8wjDggDyHTDkhb381g8EYhEh/hzAQ3TjT2s7h9RucTyJORgWF5Aqc7af?=
 =?us-ascii?Q?oJm+PAqgtxfosiC4zMiYJyTXBdvoncfGFiB5MJDDM03/8UEX4/41lDdEjzlQ?=
 =?us-ascii?Q?4rCSbdq7LacammXlEeqcWbcAFbJipKfoKZOzxmWfo9eDIBgp5zs2Bkwv6+C+?=
 =?us-ascii?Q?Mosu3RrWFwr4hDdRNFQHYk4x59uDhT05hgb2iV6MRNhl/uFqV0qMZHasVgmO?=
 =?us-ascii?Q?WlMaDlIppQNa1SXPjNCqJ0MuSZzQHyQaZm1+P8bpaFJTr2Ej9cJKGNShSQMa?=
 =?us-ascii?Q?lZAmje7FbbowhKDEePegDyekwiv8aWNNJEJyvSbKIdfu1PmeYd2K+omw1/Yg?=
 =?us-ascii?Q?7qq4ITsdwpc7IRbSY7BWdw9Y7GAr+8JZsrpoIn7V5wlHuWtU7+K5UeTuHIea?=
 =?us-ascii?Q?Ha6Li+1Jxc9WnaJ3zXXU00AN61NM60u0aoVf0CP7GPCwPjVr6mKjhnXrXxkp?=
 =?us-ascii?Q?qeEQT/sdU5mRQ39N9mENcH04r3goeLknEBKzzIBbdm34qkMhxvcgTPC5+Z6E?=
 =?us-ascii?Q?D8NM1lE5OE4cHTXrZNV/MHq+S82/ZoM2NKvD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:18:14.5286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ada49a-3803-45ed-1f41-08dddf015389
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144
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

