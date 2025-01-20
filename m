Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25FAC02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 11:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A5710E3BA;
	Mon, 20 Jan 2025 11:10:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5i4UygBn";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC43A10E3BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 11:10:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxcZIJ4+PF8K+Mjhnf3AEblnX06olBbz//bbnAFHdvZZ7OWpqSZxa/yJzxVYAl8pJJ3IiQ9EZg0KTpz/yr7ZqX0TLKYpi1nKA9Bt1ON0hQrDV0l0Q1qHPD5pEXymp2TmXiJG4eapwA02biMwOaVkRd1ngXWsoHNEHqqLX8iRwgEJtazBkmKO42QNit2yB47+l1lMk3yYSDlXxOxfzwXrWmJvrEa8NmbR7PKUQIfrMREfKoD0YWH/e1/feqD8GfrxuBIcY6mALfZ2BE4+tKaQImALvfKdZUFQmgAYvZ+XfqQmvhZ3FJmanzOf/QJL+zAZ/EbicxJzgcsardFxKcGX/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53I5DqRd7MR7o9bTvZD6tSgywtAGeexzVJwwbRZmuJA=;
 b=DW1lvU32zrs7IFLJClV6YGklg0PILNNbTI4vmvAEZ+dTwCWbzHaUAqiHKZuwFnpIX8XO/yKU7eDF9Dby4atiEFH+/3tYrL/B5oAwEuoMlxvMbwDAsj0SpxvQiUj9VL2bQm0ptlAyhxIwcz+ofovknwoPQiJYkCS2RTqkPHeutePTJOdwsXsXbyQhuR/URcvlNYnCjLyLieyKGmV7Y+wpBpeOF5SwXc1gEYWC+hsqiVQ+eSJF4Wrn5Bt7TL3LU99EOnidFB+qMZWrUtoR2yGm7844ehPI65dZSw1qm07UOQEWTh7i76RBQbHmEsdFAAfXCmruUBdA0Q7UsMNqrCN1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53I5DqRd7MR7o9bTvZD6tSgywtAGeexzVJwwbRZmuJA=;
 b=5i4UygBnMBNDKpiDVCE0MB8gJ03X2/7SncgaxQ4r5n5RiFXQ8OFal/f27DmynGMGqgCeVMsGIrVF0ATSdeJEoWOCDceb3hUkl+cs4IG5Ut3wbsp0DybbUVa4JZZTYFBBpqfMXZdNkhqnoFDsEsYkvaTU/Qv7rWuLdmeVECIUZ3o=
Received: from DM6PR02CA0165.namprd02.prod.outlook.com (2603:10b6:5:332::32)
 by DS0PR12MB9424.namprd12.prod.outlook.com (2603:10b6:8:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 11:10:51 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:332:cafe::6a) by DM6PR02CA0165.outlook.office365.com
 (2603:10b6:5:332::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Mon,
 20 Jan 2025 11:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 11:10:51 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 05:10:48 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2] drm/amd/pm: Fix smu v13.0.6 caps initialization
Date: Mon, 20 Jan 2025 16:40:27 +0530
Message-ID: <20250120111027.1525667-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|DS0PR12MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: 30326506-1e81-4281-d07b-08dd394319a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jl3A+fb/aX/mElww6H21tGVudvWkRUDpTbVoPDkDBillezZHJkhAEJsbnBZ/?=
 =?us-ascii?Q?Kq0itDIxG1gRl9h/tR37lMSL17N3gchx25O5c5dOCM+xoboxtUsDSoU1r8fg?=
 =?us-ascii?Q?ZhZ1LF5hLHb7I3QsBh+URwCuWkxROo83FHHAw6UZ8yUmjHp3RzxEqRBhTXhq?=
 =?us-ascii?Q?cmh3XnKcgNEmWOJwBDgXvlWkWUQiuEqtC9Ypp5qkc++0VnC3tNfejE3l6cJN?=
 =?us-ascii?Q?mX7mW7jUOHoGgtR74PkMgJqge0IB2Bz6NrKROdMkQGhAwYy90I/Zcxtu7UrP?=
 =?us-ascii?Q?Lu5ksxfbC7Gbt+gVhlhnF5fONcmibaPOGlFWYqE83e63BcYeRzQCxE3OvgJX?=
 =?us-ascii?Q?oALr8POlkCX+aCNqRgukJMEynvPad+QU8gAULMiR0NeeOCt7RSgkzgvJ5tjN?=
 =?us-ascii?Q?YGEPNx5EB/KDmxo7X3leKaDPCoBCQqc3ZwmNhcIzuI6TlxYG6yomh5Cvqjmb?=
 =?us-ascii?Q?AZvXa6Ky3CTDAfAjODqUdrjJup7Ih6IL6H5cDka2tPbVpVYLQBF+iTGRzGBb?=
 =?us-ascii?Q?ppaigGpgFMnVjGV5sKXUM8ufIZTC/C+jDcnY/Kk2Mrs5QuiSynVW1MwvA+LT?=
 =?us-ascii?Q?3wyNGGn7vwMnRWMmVPScpcrWnExSzrO33wiBNf/7DNt+RVHLlcQXnSJ85TVb?=
 =?us-ascii?Q?cm4h0yHEx15Vc2SS/tZlMNG76cQMiFXaA5G9EtZaItNJLLgS9S9KFFs7Ppae?=
 =?us-ascii?Q?LONieYP+GYAbyaU7tV+PKAiwtT2kefRhwX0luR6TfD6IOmVas8PiqWICLWIz?=
 =?us-ascii?Q?RlpG3rj6VRTielYGBTbpTQWqowkDM6rVlJtT7w/BeitY1vkE1O8SSq+OFLwu?=
 =?us-ascii?Q?6vfsPrxFDvsPzIPizAZePPzEC2hb7dD04b+TnUtHyfXjAmvbFUcC/jJ4fWL8?=
 =?us-ascii?Q?aB4Mm9sYjF2pEq4iviOx4x399m38Zj3Jihj2bXY6vERqup+Oax3b8ryWozAu?=
 =?us-ascii?Q?5CigcwE1PMg+nexjWAn1uFqrjag3ZPE9Rjfd3bRSV0wnQ1oURY2UUojtlbfW?=
 =?us-ascii?Q?tRAbh2vFK4901xj6+dayhJtljVRlhhw33pxWq60kxOXz7huaKg69ADxYQK16?=
 =?us-ascii?Q?/f2HAR9AOV0gzwqRqEUKOxzQLd9YP0MA39w1TN1gra3k0wJ0Yzl6/9gAQXBB?=
 =?us-ascii?Q?ZnRTM9wU351PYHp2wKg8e6q7cKikDIRd9OqgBrDo26BvFj+Le4K8Hb54ewNq?=
 =?us-ascii?Q?fYm6PZOnrBOuOcNFsbY6IwrUZKVfwoOQzKtuZtfHGKGDJVsgIkKXbIzuMh0R?=
 =?us-ascii?Q?Gn58Q4kv7DKgWaEYBSP0szn+XlmSdtY+6TaluaDG9CMthtpkXVNTkIrS0u++?=
 =?us-ascii?Q?XUIzGpa/Aq8AjWOFBddsv4hIFzDSL4UyGt/tw0OYLAHYQASVHWK9gSKbOkTE?=
 =?us-ascii?Q?XOKA73PKG/72H25gB7FvTn9/aykJhKM4nCEw+qNhQAP4ZyTUyk42eK0w6g3x?=
 =?us-ascii?Q?3sCQgwUkOz3WKJanFCY3DCI+YEJr8OAFD967LNdeJFxZu0OGIlCjY+EY5afn?=
 =?us-ascii?Q?8AaQE/4LC83ypUE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 11:10:51.1692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30326506-1e81-4281-d07b-08dd394319a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9424
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

Fix the initialization and usage of SMU v13.0.6 capability values. Use
caps_set/clear functions to set/clear capability.

Also, fix SET_UCLK_MAX capability on APUs, it is supported on APUs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Fixes: 9bb53d2ce109 ("drm/amd/pm: Add capability flags for SMU v13.0.6")
---
v1: ("drm/amd/pm: Use correct macros for smu caps")
v2:
	Use caps_set/clear instead of macros (Alex). Commit message changed.
	Use BIT_ULL (Kevin)
	Fix SET_UCLK_MAX capability on APUs

 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 124 ++++++++++--------
 1 file changed, 72 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 56e26fcd3066..9e64392d23a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -118,8 +118,7 @@ enum smu_v13_0_6_caps {
 	SMU_13_0_6_CAPS_ALL,
 };
 
-#define SMU_CAPS_MASK(x) (ULL(1) << x)
-#define SMU_CAPS(x) SMU_CAPS_MASK(SMU_13_0_6_CAPS_##x)
+#define SMU_CAPS(x) SMU_13_0_6_CAPS_##x
 
 struct mca_bank_ipid {
 	enum amdgpu_mca_ip ip;
@@ -284,95 +283,116 @@ struct smu_v13_0_6_dpm_map {
 	uint32_t *freq_table;
 };
 
-static void smu_v13_0_14_init_caps(struct smu_context *smu)
+static inline void smu_v13_0_6_caps_set(struct smu_context *smu,
+					enum smu_v13_0_6_caps caps)
+{
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+
+	dpm_context->caps |= BIT_ULL(caps);
+}
+
+static inline void smu_v13_0_6_caps_clear(struct smu_context *smu,
+					  enum smu_v13_0_6_caps caps)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	uint64_t caps = SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
-			SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
-			SMU_CAPS(PCIE_METRICS) | SMU_CAPS(CTF_LIMIT) |
-			SMU_CAPS(MCA_DEBUG_MODE) | SMU_CAPS(RMA_MSG) |
-			SMU_CAPS(ACA_SYND);
+
+	dpm_context->caps &= ~BIT_ULL(caps);
+}
+
+static inline bool smu_v13_0_6_caps_supported(struct smu_context *smu,
+					      enum smu_v13_0_6_caps caps)
+{
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+
+	return !!(dpm_context->caps & BIT_ULL(caps));
+}
+
+static void smu_v13_0_14_init_caps(struct smu_context *smu)
+{
+	enum smu_v13_0_6_caps default_caps_list[] = { SMU_CAPS(DPM),
+						      SMU_CAPS(UNI_METRICS),
+						      SMU_CAPS(SET_UCLK_MAX),
+						      SMU_CAPS(DPM_POLICY),
+						      SMU_CAPS(PCIE_METRICS),
+						      SMU_CAPS(CTF_LIMIT),
+						      SMU_CAPS(MCA_DEBUG_MODE),
+						      SMU_CAPS(RMA_MSG),
+						      SMU_CAPS(ACA_SYND) };
 	uint32_t fw_ver = smu->smc_fw_version;
 
+	for (int i = 0; i < ARRAY_SIZE(default_caps_list); i++)
+		smu_v13_0_6_caps_set(smu, default_caps_list[i]);
+
 	if (fw_ver >= 0x05550E00)
-		caps |= SMU_CAPS(OTHER_END_METRICS);
+		smu_v13_0_6_caps_set(smu, SMU_CAPS(OTHER_END_METRICS));
 	if (fw_ver >= 0x05551000)
-		caps |= SMU_CAPS(HST_LIMIT_METRICS);
+		smu_v13_0_6_caps_set(smu, SMU_CAPS(HST_LIMIT_METRICS));
 	if (fw_ver >= 0x05550B00)
-		caps |= SMU_CAPS(PER_INST_METRICS);
+		smu_v13_0_6_caps_set(smu, SMU_CAPS(PER_INST_METRICS));
 	if (fw_ver > 0x05550f00)
-		caps |= SMU_CAPS(SDMA_RESET);
-
-	dpm_context->caps = caps;
+		smu_v13_0_6_caps_set(smu, SMU_CAPS(SDMA_RESET));
 }
 
 static void smu_v13_0_6_init_caps(struct smu_context *smu)
 {
-	uint64_t caps = SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
-			SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
-			SMU_CAPS(PCIE_METRICS) | SMU_CAPS(MCA_DEBUG_MODE) |
-			SMU_CAPS(CTF_LIMIT) | SMU_CAPS(RMA_MSG) |
-			SMU_CAPS(ACA_SYND);
-	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	enum smu_v13_0_6_caps default_caps_list[] = { SMU_CAPS(DPM),
+						      SMU_CAPS(UNI_METRICS),
+						      SMU_CAPS(SET_UCLK_MAX),
+						      SMU_CAPS(DPM_POLICY),
+						      SMU_CAPS(PCIE_METRICS),
+						      SMU_CAPS(CTF_LIMIT),
+						      SMU_CAPS(MCA_DEBUG_MODE),
+						      SMU_CAPS(RMA_MSG),
+						      SMU_CAPS(ACA_SYND) };
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t fw_ver = smu->smc_fw_version;
 	uint32_t pgm = (fw_ver >> 24) & 0xFF;
 
+	for (int i = 0; i < ARRAY_SIZE(default_caps_list); i++)
+		smu_v13_0_6_caps_set(smu, default_caps_list[i]);
 	if (fw_ver < 0x552F00)
-		caps &= ~SMU_CAPS(DPM);
+		smu_v13_0_6_caps_clear(smu, SMU_CAPS(DPM));
 
 	if (adev->flags & AMD_IS_APU) {
-		caps &= ~SMU_CAPS(PCIE_METRICS);
-		caps &= ~SMU_CAPS(SET_UCLK_MAX);
-		caps &= ~SMU_CAPS(DPM_POLICY);
-		caps &= ~SMU_CAPS(RMA_MSG);
-		caps &= ~SMU_CAPS(ACA_SYND);
+		smu_v13_0_6_caps_clear(smu, SMU_CAPS(PCIE_METRICS));
+		smu_v13_0_6_caps_clear(smu, SMU_CAPS(DPM_POLICY));
+		smu_v13_0_6_caps_clear(smu, SMU_CAPS(RMA_MSG));
+		smu_v13_0_6_caps_clear(smu, SMU_CAPS(ACA_SYND));
 
 		if (fw_ver <= 0x4556900)
-			caps &= ~SMU_CAPS(UNI_METRICS);
-
+			smu_v13_0_6_caps_clear(smu, SMU_CAPS(UNI_METRICS));
 		if (fw_ver >= 0x04556F00)
-			caps |= SMU_CAPS(HST_LIMIT_METRICS);
+			smu_v13_0_6_caps_set(smu, SMU_CAPS(HST_LIMIT_METRICS));
 		if (fw_ver >= 0x04556A00)
-			caps |= SMU_CAPS(PER_INST_METRICS);
+			smu_v13_0_6_caps_set(smu, SMU_CAPS(PER_INST_METRICS));
 		if (fw_ver < 0x554500)
-			caps &= ~SMU_CAPS(CTF_LIMIT);
+			smu_v13_0_6_caps_clear(smu, SMU_CAPS(CTF_LIMIT));
 	} else {
 		if (fw_ver >= 0x557600)
-			caps |= SMU_CAPS(OTHER_END_METRICS);
+			smu_v13_0_6_caps_set(smu, SMU_CAPS(OTHER_END_METRICS));
 		if (fw_ver < 0x00556000)
-			caps &= ~SMU_CAPS(DPM_POLICY);
+			smu_v13_0_6_caps_clear(smu, SMU_CAPS(DPM_POLICY));
 		if (amdgpu_sriov_vf(adev) && (fw_ver < 0x556600))
-			caps &= ~SMU_CAPS(SET_UCLK_MAX);
+			smu_v13_0_6_caps_clear(smu, SMU_CAPS(SET_UCLK_MAX));
 		if (fw_ver < 0x556300)
-			caps &= ~SMU_CAPS(PCIE_METRICS);
+			smu_v13_0_6_caps_clear(smu, SMU_CAPS(PCIE_METRICS));
 		if (fw_ver < 0x554800)
-			caps &= ~SMU_CAPS(MCA_DEBUG_MODE);
+			smu_v13_0_6_caps_clear(smu, SMU_CAPS(MCA_DEBUG_MODE));
 		if (fw_ver >= 0x556F00)
-			caps |= SMU_CAPS(PER_INST_METRICS);
+			smu_v13_0_6_caps_set(smu, SMU_CAPS(PER_INST_METRICS));
 		if (fw_ver < 0x554500)
-			caps &= ~SMU_CAPS(CTF_LIMIT);
+			smu_v13_0_6_caps_clear(smu, SMU_CAPS(CTF_LIMIT));
 		if (fw_ver < 0x00555a00)
-			caps &= ~SMU_CAPS(RMA_MSG);
+			smu_v13_0_6_caps_clear(smu, SMU_CAPS(RMA_MSG));
 		if (fw_ver < 0x00555600)
-			caps &= ~SMU_CAPS(ACA_SYND);
+			smu_v13_0_6_caps_clear(smu, SMU_CAPS(ACA_SYND));
 		if (pgm == 0 && fw_ver >= 0x557900)
-			caps |= SMU_CAPS(HST_LIMIT_METRICS);
+			smu_v13_0_6_caps_set(smu, SMU_CAPS(HST_LIMIT_METRICS));
 	}
 	if (((pgm == 7) && (fw_ver > 0x07550700)) ||
 	    ((pgm == 0) && (fw_ver > 0x00557700)) ||
 	    ((pgm == 4) && (fw_ver > 0x4556e6c)))
-		caps |= SMU_CAPS(SDMA_RESET);
-
-	dpm_context->caps = caps;
-}
-
-static inline bool smu_v13_0_6_caps_supported(struct smu_context *smu,
-					      enum smu_v13_0_6_caps caps)
-{
-	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-
-	return (dpm_context->caps & SMU_CAPS_MASK(caps)) == SMU_CAPS_MASK(caps);
+		smu_v13_0_6_caps_set(smu, SMU_CAPS(SDMA_RESET));
 }
 
 static void smu_v13_0_x_init_caps(struct smu_context *smu)
-- 
2.25.1

