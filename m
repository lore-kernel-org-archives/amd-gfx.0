Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0E8C71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 05:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D3ED10E288;
	Mon, 16 Jun 2025 05:39:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H9HkwFtd";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA74E10E288
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 05:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ovl5u47W0pf+av5v61bCkbTsUkfbRNVxhrtkPVFOWCtLvzgDuTFrU9rxJYyDInJkvp9RrQdySRbNYGhqb5WHmYarg3dxKpjgV2ouVzlTcPBHtD+Uo+ilJgVZe/QFZyd0hifM6Oxv5sVLUhSD1LTvJo3FkCdoejvPvwrI80jTvB2SefcLJ5mdHskCFC33ilElBitjmWzgOHl25QNGjg3gZ16ibQN/378xe60ImOQ/RiyVPWz8BvnFKtlop4FpOZ5yKLlZvN7nZgkbr/4X/9sfwKlPiUt66cR8SkYEbLybGoIlBz2IqVQfZ4ot1hJ0fmWALVnbYz9pFh7XUivvtQaMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFBa2hAZdHmSuopZZJRjdpI9/Tpm0n9Bv8AKssT5I9A=;
 b=DskfN5TiC/aq4EXlYJx0Yjc+uZT0g1D8zwKJx0TcDyA8T9PH89lh1qXfEijQVGxHfd4/8B3EPHJDd+c3Ypxe9FpHTA7w7C7RrcDHDcn9WJiy7vvHN7EQZNiPhHqPFYGl/LaYRGpOWRt1hc5pbnFMtbB6Ael5ImydvXFnQP0Ti5kHeLZR9lHTk1cnqeNFsBrBtE90XWFXWv1zAxVS3AO/3vcNG7x5Oz29e3XscUk9Ucx44FG1t9MHqtOHVIsFIJPOOteAG8NnQoCCTs3YjoQ3nI3bF8DjPKnZlFrHnMwwurRPPvQqqIhvd7iS5YvRYPmjo1zKW/mwA6nSLXMENxRoyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFBa2hAZdHmSuopZZJRjdpI9/Tpm0n9Bv8AKssT5I9A=;
 b=H9HkwFtdxrMYd0GxrFv3DxdOpQIDrz8B9nRAkpvrazVQl9EbiUl40qfoAaZhq4s7KdbTdZ35kEJCvsfQbYd5cvmJ3nd0irEAbO9O1zsfTeH+JMoEnr7EmC0Th+2ia1/9yDJwba36b9aDfTQFH3FCo1MbtAUFReOt6m+cLc5gwu4=
Received: from BN9PR03CA0708.namprd03.prod.outlook.com (2603:10b6:408:ef::23)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 05:39:09 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:ef:cafe::bb) by BN9PR03CA0708.outlook.office365.com
 (2603:10b6:408:ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 05:39:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 05:39:09 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 00:39:06 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: Update SMU v13.0.12 pmfw header
Date: Mon, 16 Jun 2025 11:08:50 +0530
Message-ID: <20250616053851.868243-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|DM6PR12MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb22363-c5ff-43e7-330d-08ddac981dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+8hPBErYgnASkO2FaOv0m1lHCKi7gc6bQV4UfL78fj7y8e5S/qN7ikZwhK5a?=
 =?us-ascii?Q?G13s/tXJ99B2f4ERDwfCpTBlDZL63O5dmuS2bz1Q7Yn4z+IcXhNbtt0+k4Z+?=
 =?us-ascii?Q?1/UB0MGej4FXd/WDyZGdnbj7/WWbDHCncMnqSi0FlI+PWqRNQlunjyfWK8sN?=
 =?us-ascii?Q?C31M4JMgIwlupXz65Wv24VckzgM0AmPAHpB1holQJE2w1ggdQVy/5bOJ7r/T?=
 =?us-ascii?Q?1FXG3i2X0xTuSWO9CRT9Ys9n29L4djcEbgyD8DwcEhf+3Srrwe4vpuBDP68W?=
 =?us-ascii?Q?kQO/PVdTJWiryJMB3MhAgqlZFgbYm0H46K4R31hR6/QW13YNidGlGuenMjrZ?=
 =?us-ascii?Q?Ray/JEAsrP9w4yz10sSmHPE5geWz0tDpP0Eq9iPwwzgAEVLa0d0R2YRQ3jat?=
 =?us-ascii?Q?QMXkchGBFEuojSTJvki/syrLvN5XsRP1i7wyAza8XPoNAjfpivXA/z7Qt9+j?=
 =?us-ascii?Q?1UFq57jEsDzblawEEBwXsfZSbBqzW4NqIgIc+ZSZObV1zYxCF2I4QLMbjZAw?=
 =?us-ascii?Q?H9s8k3d3RlSmc2ZBA/Hxqgd6M3ZtgLt2N+k6clsVGmYokzVHjohBGFN9EaXB?=
 =?us-ascii?Q?mqv0TJ0mIs70n/pogqP0zE9OBQv5wB3RG/VsbV2E6+/kcV+I0Qkussh+yfjr?=
 =?us-ascii?Q?rz5bW+7Je5g5FZ3aofkDPSRxLk1f7XQX0T6HTOhW7r772IlQJ41BPqBM+pTv?=
 =?us-ascii?Q?hhJoGzpvekcBm/hFmnDyTRqqSgGIC59EP2aDjOaADP77CHOc/AzSnVoq7CyD?=
 =?us-ascii?Q?CSJ2FkdZcYkJNu77flAR982f6vGnVuRmOkjzUhsKPHpnDxLUxGr5ScyGSlmI?=
 =?us-ascii?Q?hc3PES3+ZhA2YrtpYDTBnjVggdX5ffM3bHUZx+1TjQfFVJtAj6bab4/sgGZ+?=
 =?us-ascii?Q?cjucEt1cmRBbCaWepEQkdsMrx7mm72cIShBiBGk0vr9A/lypPu7zEJEOAt1I?=
 =?us-ascii?Q?0MnmUiV1S4WhO/pa2/7J0KZwEI+qHVSu4Fuh70QATYenGRvNyJ/U7jbAJA+N?=
 =?us-ascii?Q?qiMXZmIR+a7G7ScRlbsMoKl9CeUgF3U0xgtPDVRgYkKZh2RJIX1fKJBpiQlH?=
 =?us-ascii?Q?mEIc/4uFbkRWyYbKxuQTY3rOLRgGWviUVBnUi3gJJsHMImYcOTG+VNB7HRTa?=
 =?us-ascii?Q?ag85VMpVb0dx0yGDpmRuzjmT93pnd2ATHHBtctnCVn4eyV7ng7KBLHMGssVU?=
 =?us-ascii?Q?pivq+8cWftRoeMF0zCYMDhOh6eGw58GzBtc1T78nTyRtS4qHFiFAQtPMu1DE?=
 =?us-ascii?Q?xne72ke8Iwn10vwA2zxqW7KUsTJr898q2orQQCpoSN+wtUOvyx9P2U2jHUIU?=
 =?us-ascii?Q?5ZNm+InU8Y7C45zyg4ropQ3tRhsUUSZuliSkWvQqt9bL0JkbwXGOzqnx+L1W?=
 =?us-ascii?Q?a/KN+ctXUhCSzucbIeVNl5UDvCAwbb4Ym+cbZANKAw/o+krQl0dILxRu8ede?=
 =?us-ascii?Q?GpN2DkztriJkeRANAYiVDW/3rmOQDL0fqhEjub9cfU3pangr6RHYVQQramKt?=
 =?us-ascii?Q?CzDTOtcm8gu7VOoun/yRZQ6qO1MvcXQ1e+z8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 05:39:09.2144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb22363-c5ff-43e7-330d-08ddac981dde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
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

Update PMFW metrics table definition to version 0x13

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
index d7505cfc433a..0a2ca544f4e3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
@@ -86,8 +86,10 @@ typedef enum {
 /*36*/  FEATURE_PIT                         = 36,
 /*37*/  FEATURE_DVO                         = 37,
 /*38*/  FEATURE_XVMINORPSM_CLKSTOP_DS       = 38,
+/*39*/  FEATURE_GLOBAL_DPM                  = 39,
+/*40*/  FEATURE_NODE_POWER_MANAGER          = 40,
 
-/*39*/  NUM_FEATURES                        = 39
+/*41*/  NUM_FEATURES                        = 41
 } FEATURE_LIST_e;
 
 //enum for MPIO PCIe gen speed msgs
@@ -133,7 +135,7 @@ typedef enum {
   GFX_DVM_MARGIN_COUNT
 } GFX_DVM_MARGIN_e;
 
-#define SMU_METRICS_TABLE_VERSION 0x12
+#define SMU_METRICS_TABLE_VERSION 0x13
 
 typedef struct __attribute__((packed, aligned(4))) {
   uint64_t AccumulationCounter;
@@ -275,6 +277,16 @@ typedef struct {
   //PSNs
   uint64_t PublicSerialNumber_AID[4];
   uint64_t PublicSerialNumber_XCD[8];
+
+  //XGMI
+  uint32_t MaxXgmiWidth;
+  uint32_t MaxXgmiBitrate;
+
+  // Telemetry
+  uint32_t InputTelemetryVoltageInmV;
+
+  // General info
+  uint32_t pldmVersion[2];
 } StaticMetricsTable_t;
 #pragma pack(pop)
 
-- 
2.25.1

