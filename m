Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453AFC61DB2
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 09:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBEF310E92D;
	Fri, 13 Jun 2025 09:34:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bku2yVHI";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A71C10E920
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 09:34:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWQ2KgiSgxx7bvhUOIJeGoPgegmwdA+ZX/X24An3D4pEx8AQ14Uz/eudfAozCAbq1+S+ybilRPOsPB3TSEcsB/uGSX2hRy5x0Nb5lN/N/Cxxv+ABXT7fcoIxjoyNSEFQSrh2FrkNcCuyH5koTpa1ikOr/Yyf7snVGE6jIVT2iUsT6uyHGv6WemJ6KU+OOHQV6zFJZC/YU/oj8pj9Uejx+dT6s3ofx2mty3AFc2kB4YO77g0ll7pSErs55GrAAwhoY2Qdx5Fl6Mx9lsuKO6j7MfgiQ99py01yjcoyNa3p3ojr6bIC8l8VssjNIkg8aNrJ9WfMJauNNBLiNPc9eCjxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFBa2hAZdHmSuopZZJRjdpI9/Tpm0n9Bv8AKssT5I9A=;
 b=IuV1q1gvxw9k/S7j70Dgv0kni9syIx35Jfm1OTA3xRqkh+hXWQvRn1Nr0/aFGd91NM6m7Aa/zky08R6/qLCrGvG1mRDBMQGMFXEpfjooRSDruLonhSIFo1jDnwfuFHOgLhvmxkKlvnWKTC9IF5waaP+YqAT5ekitjiNFAcB3lvMoBk/S+ZcM/uXAXYJFq1TV8QI6Z+uO/oKtiz8WE9LWhk6S4VSkRntFlQ8DIhJGSRSbUXW9jjKmhavAtfE0K4D0mR72x52cPj2HoBPfSfcHPYs8Hl0LfsXu7H+Hz1dhUosYYQLDI1WYkQV3s7Spb0jaLnsW6xl0+hACPoNOHuveaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFBa2hAZdHmSuopZZJRjdpI9/Tpm0n9Bv8AKssT5I9A=;
 b=Bku2yVHIW/6DnXsgUbC9JHTV9nSOVFb8b8PcmI0HNFHFd2uIMeCkuUgPzyBmwAvCVSJRyZm36wmouaircXX3l/l5Onq4eWT1LDvzKbtq62CE95yiGZ4yRC7ROmlIbGdUybQlnGMNM6PFFmU6zqiU3yoL+Y62VSNxXrAfjkt0hV8=
Received: from MN2PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:160::19)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 09:34:01 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:208:160:cafe::5) by MN2PR13CA0006.outlook.office365.com
 (2603:10b6:208:160::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 09:34:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 09:34:00 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 04:33:58 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Update SMU v13.0.12 pmfw header
Date: Fri, 13 Jun 2025 15:03:40 +0530
Message-ID: <20250613093341.830218-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad0cedd-5098-4475-d32b-08ddaa5d6d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LnWSEKO/Utp+hTpwyra4UVqHdoCRZUGF5ZBC/yc2b+lep8fg8ooTqrOprGW4?=
 =?us-ascii?Q?7446JwXDsDMqUP1BrccrYLEtf3s0ccJ3lYhloQLmfgWAmvL78YFJbkr8KFae?=
 =?us-ascii?Q?Y+UwuLde9UBqW+ZvWjmbM+2csXcFyQmGydcpf0PqjX7CEjqYeFE2/lJbF1Z7?=
 =?us-ascii?Q?HiH/q2LSHwBnN5Fv0H9lpjjT9Ro4HfK7CiwlT2pMIPJOIRts8HrtxZb/Sgsh?=
 =?us-ascii?Q?xpSYQ6N19c4V40z1caEjg35KRy/YDYyq98/A0pdMyMsvKO/T5p59fWuQKPBn?=
 =?us-ascii?Q?fqKt6DOSg9YxiAQtEZhXHuJiR5lSJXFcZCWe4il5LC5J+OPc/pLLqBgbn/7d?=
 =?us-ascii?Q?aUBAi4kIQIAZUnC+5S9+Vlrd2YTo6IaS0rUx/CPckVa78mlmICtniWkUMhYA?=
 =?us-ascii?Q?UVVXcrYWjpkwnSrAcK3ZR76MoUeoIsbFSoYDe7d9oNiK3nCIx3Q7d8FGs3qV?=
 =?us-ascii?Q?G1Vbu+R4NdZdwsfXGhCbgAH7lwV0zSBWPpP7a79LMp+Bo59pC5d8YXpvs+FB?=
 =?us-ascii?Q?fmIIwlTeDiOkjrBcixFhroQ7oE/pJS/7lHz8vqye0H5yJt1cwN8K8U4GwKbi?=
 =?us-ascii?Q?Zd119pcUVobQASRcpKBZVFk1vOZyWSVs190dPU04s2Gs0rzQIYEwSwyKUcYy?=
 =?us-ascii?Q?19z+K49fWYYHpnvyx3KdKdy5e2Uh5iUgr7KwYzddAKAt+g1LoFE68vH6kN6+?=
 =?us-ascii?Q?YkYl7V9WaUrXQ7Ve58j/ZREOu34+WKj8QgaYaOfLBzFauPHeulI3HEphBW62?=
 =?us-ascii?Q?+lcaEJKyTScCPBk1pGzWIlA9GJfi9l3wgkUuS9I09DKEMoNgJh1fca6EVH0o?=
 =?us-ascii?Q?Lt4/TiD7dtaRIBCj8OccWGw5T7dDM0WQjP4sd9LtwiIpG1nuKVG6NchofzZq?=
 =?us-ascii?Q?paR754zVUJ/JTPGizKtkeDyWuFEv4YioVtrgYUMLKht4lmYAoWaQAOVwDvMf?=
 =?us-ascii?Q?g2tRKR5/yVeFL+6qAl0ekJvB/1wRQO3RxrNOofF7wpblHUmMX0HGUW2OJMCj?=
 =?us-ascii?Q?du0iHAWLg3n+BwNYW5k0zw5lDlUqvfQmROOGsI6tfqyCZqfpld6SOD/Y84Br?=
 =?us-ascii?Q?qWAVnRFF2xBzNMkhqiSgRkcXH8ezxEFIL9CoxOCfrsO5Oxj46OoZ0mw00tX3?=
 =?us-ascii?Q?gfSOFFN+DWvfHxn8Y8Qk+w+ScDKehGPccKf2t4F1U+ezjkS7mQ+K+3K/E4rA?=
 =?us-ascii?Q?E3fAVH6SkD1g6H9bcM5TvWU6OMeEJvxDXxniAZ9hR9L3+YPPk1BNo6csJSBR?=
 =?us-ascii?Q?0/faY79/vYel3WxXcbS7xFbYzk9NzLHwA/6bZYCCA2OgoPvZCa9eBgJK2Fae?=
 =?us-ascii?Q?Iala/C0V8/4kKWWXgYrN4pdi/FqpW8g17s0ryMRktHiopkYMSJpObytkc90t?=
 =?us-ascii?Q?CkS8zG0z8xhJuX/5dK9kOABeXCPTv59JCObK8Svp/J6gXymNLxR4VoXtxvg+?=
 =?us-ascii?Q?B7wBEeEKu3QSFPSNpHoMwUTOuVWPa0LsjTNRFDOw7sQ1X/1hl9nyFWBO4wIr?=
 =?us-ascii?Q?+JvxdfoAM6zML95t4tXbGfJQzK7OKgGUdzIh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 09:34:00.2741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad0cedd-5098-4475-d32b-08ddaa5d6d8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
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

