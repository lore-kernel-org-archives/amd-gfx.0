Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96947CCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 15:34:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A25B10E92F;
	Thu,  6 Nov 2025 15:34:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5jSej/aO";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B122E10E92E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 15:34:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8T0OkeImUN7074gnZY6bo0nrjtXO+KrChW1ykSiDp5IqwZu8HYWtdPiI6yPaFAeBLJZDrlnOhSB0v9AJ6/mLAqvBlngkrFmKvKYam7I3puHq7u/Db5JYBzvPvjWbylNCmbocqIwjy87DP3a6OAONDtryO9mZ74MVv5fAzebOLTfoiLcAEEE2BYkfdqq1UDRw4Nh6zMNIcSgaJZrn0p5sy6REkYNCuPEKbY72rH0QATtfJSyjcljqliUAZF+OI05Y6jBrnQPg0yV8T6Av80xijqowUIOtgOtvOrx5yspZeshTpn8euPZoaTIC1A2bEwbu3DvVZ9SNhVGKkZugdx7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTz6+tZxUeu3IbDuQrivOpH1UNj9Xpxw3SruwNAzoN8=;
 b=x6u9pJQwewwoi9QoEF+h10wWPog21zDzNhNFwy1qQGQ9FeP9FkEDALpqwgfmgRLEhfyZaw9ZOLKXtLGfVtTnN3oHn/q7d1skh9YpWkkJCL2yzjIWTPY97iSCDRLhoj7wzOFlZxJu2No7k+6J8OqA2LQ61jkOpwEGfi4f6Ca3loq37vn8go78sGlzqvHffAp9aMrapVOChWky9FNhHXEEzqqKEQa07xXDF+jYzPugEe9oEk8HadiHj3u5Q0kr7/HI75QLjikm3IRDDZ7vC3uVUhIijpazISiiajCIWVNz+w78KTvSSTsvzBSrpPXOphPECBkeijnr9uRIGGJRZXUGUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTz6+tZxUeu3IbDuQrivOpH1UNj9Xpxw3SruwNAzoN8=;
 b=5jSej/aOB0G5YagNzm8X8BNt0lcIosZ7mpRZ1f+Opwovit9RI2CCfFRmT7OwVJQxHroSbs1bl2PRUCeRAa+Ijj5OpYSixlkj9CgUNFnwm4jMsCwcoCwQlyK7jrDmSu0TNkZxRzQJve6h8CkrzKzJqUk3aedSam6Hi0VCnXbo0NM=
Received: from SN1PR12CA0055.namprd12.prod.outlook.com (2603:10b6:802:20::26)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 15:34:04 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:802:20:cafe::b0) by SN1PR12CA0055.outlook.office365.com
 (2603:10b6:802:20::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Thu, 6
 Nov 2025 15:34:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 15:34:03 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 07:34:01 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH v3 1/4] drm/amd/pm: Update pmfw headers for smuv_13_0_12
Date: Thu, 6 Nov 2025 23:33:25 +0800
Message-ID: <20251106153328.3783505-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2b85cb-5a54-4b35-264f-08de1d49ea5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?01QnRZEqbYiXRolkMVpRzZRrZzwc65mJnQlbcMkJ7fya6Ef5YniVCJ+EVI93?=
 =?us-ascii?Q?addqGBCLMTYLHet5qcZSd6CN9A5p2/UdG852L6iT/egcq4c4xbPoAZkVO66V?=
 =?us-ascii?Q?Kzssjp0RogYczTE0znrtr1oYJs4wfbEra16PgdMWj79XYskOyFKohPZLomwC?=
 =?us-ascii?Q?5feXSJaTv6YLyiThk3ixXyJy5qRKpragIwno65tjJkFw2iUvN8ezwcGkudDt?=
 =?us-ascii?Q?LjGg7ouF+PpYxwahhb/eVCfIhe5YJwfdl16bsWqUeAbk3eev2pZtb8EjQPce?=
 =?us-ascii?Q?2Ty48eRP6iIcFeYgyY70S+gGTZP1JQo0D2C9sHzRsw2xhkVfL4u8SotBh0Bp?=
 =?us-ascii?Q?iFR5Nx6/v9XYGded/xYaJw+l2eE6KyPN2wtPpAeMRY390s0ZBalLiuKaPrds?=
 =?us-ascii?Q?ioKBYHxx1scmX3zHkhfenYEBELnjqg9yKd27kJexYa88DHRn0opFIaDkJlum?=
 =?us-ascii?Q?3ZOwsmsTT0f5w7o+8wY6PSgmPkuvAnVaQMNmluibkF8gIdnwIFOgcuzkGlCk?=
 =?us-ascii?Q?3BOz/rFGKT2R7sLkY1Rz6JrmAW+dYadkKHGfArXZ9/ZAL8B9l6IDRSV+vazy?=
 =?us-ascii?Q?0aMnQVKhV7Fk+bG8pEn0HoPtjUarq/FpQVF9IcjDkDjzCQYENZTn61S9Itbd?=
 =?us-ascii?Q?R6NEUpLxnW45Nm6nDl/Snv81bbiiGpCyFpg34RFCrIEBPjkZmNRKTYzeI6Ug?=
 =?us-ascii?Q?qPG72eA2eZTYYPlzFfIuGnMhlVTMNB6rc3soaS3f4AYc6HSFpYLXsgUaFZxL?=
 =?us-ascii?Q?MUyMz1zjRmP/kJ/WpM4RWosJURw9dI4z4QonndAnMsxBy1fsaw/CQ0ATLRQc?=
 =?us-ascii?Q?526dz9SrtwjyhO3FPByXUPTTt5EW/lzYAtew1XNZ/SOjaRY08oKYbwP1cl4U?=
 =?us-ascii?Q?pW1POm7Uuyl1RImT4bktLqwYIymIUkJhdDRm6QVzvsAQIqviYbLWJw6tGAW8?=
 =?us-ascii?Q?Nh5F26WTsTSSrNAtjYkL/3Lsr3ycRIirx2WbK6yf9pNZo2x6GsTHSGfa7CzO?=
 =?us-ascii?Q?2Pz9b2ISSaapzjvCy4GBHsouzQd7yKaqUA6qU56WvRcigXOojyKLFatRCax2?=
 =?us-ascii?Q?Wn4tSE0wK3y7H+/xyQJ452Ece8QSbWp83Z+rzJWXBArayXSWNCV0Sk/zDjPn?=
 =?us-ascii?Q?gH+eN8tp+tZOd7soJj8ZAdV9jjG4edLo502RepN5q6lZ3MZbKACKhkMqavdA?=
 =?us-ascii?Q?m50EpU36L0ztlPhttXGK/WXF7TthNXXzMXbF6xGoGRBRZMsfC7hSqosK29xU?=
 =?us-ascii?Q?W6XVTtyqtFJiSocYrH5qX43tcr7cTNY23E7GO4lJ0xHzAdHA9SJf4KVGPce4?=
 =?us-ascii?Q?O+JX2BQAS0aPVFvOTYVaboQ+uLXyPa2Ctpqjt8hF2yrXqx/Er4P5Do+EEQUn?=
 =?us-ascii?Q?8aihG6hsqgMGvRa8/GDqoFtlovjGDXCV5B1E3igADAh5U70P4Ep0Mmxis5k6?=
 =?us-ascii?Q?PHsLZT5ZU+PcOj3G96DgAVQfVUJiDpxV5+Rzz/bAX44X0OAfMdBmgDNslyn5?=
 =?us-ascii?Q?fuir5HM5lvchIL/8kLWxjexGoxcwJM4NVpnMEArg8ODCeyx2ZVInE/VZB43D?=
 =?us-ascii?Q?NKmS/6+/AfAxK5T4IwM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 15:34:03.4305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2b85cb-5a54-4b35-264f-08de1d49ea5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
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

Update pmfw headers for smmu_v13_0_12 to include ppt1 messages and
static parameters

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h   | 7 ++++++-
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h  | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
index fa43d2e229a0..dd30d96e1ca2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
@@ -189,7 +189,7 @@ typedef enum {
   SVI_MAX_TEMP_ENTRIES,   // 13
 } SVI_TEMP_e;
 
-#define SMU_METRICS_TABLE_VERSION 0x14
+#define SMU_METRICS_TABLE_VERSION 0x15
 
 #define SMU_SYSTEM_METRICS_TABLE_VERSION 0x1
 
@@ -367,6 +367,11 @@ typedef struct {
 
   //Node Power Limit
   uint32_t MaxNodePowerLimit;
+
+  // PPT1 Configuration
+  uint32_t PPT1Max;
+  uint32_t PPT1Min;
+  uint32_t PPT1Default;
 } StaticMetricsTable_t;
 #pragma pack(pop)
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
index fe1b3ac50a75..d09b6ae9827e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
@@ -117,7 +117,9 @@
 #define PPSMC_MSG_GetSystemMetricsTable             0x5C
 #define PPSMC_MSG_GetSystemMetricsVersion           0x5D
 #define PPSMC_MSG_ResetVCN                          0x5E
-#define PPSMC_Message_Count                         0x5F
+#define PPSMC_MSG_SetFastPptLimit                   0x5F
+#define PPSMC_MSG_GetFastPptLimit                   0x60
+#define PPSMC_Message_Count                         0x61
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
-- 
2.46.0

