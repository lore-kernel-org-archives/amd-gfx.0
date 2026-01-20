Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31926D2ECF7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 06:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C35D810E557;
	Tue, 20 Jan 2026 06:14:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eddE2+O1";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013009.outbound.protection.outlook.com
 [40.107.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25E4810E558
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 06:14:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzhsmYKgC2vOkAKISK5VoP8ET3YW2UT7bAOjsywbQo+AcSDrY6e0YQiubiYE9VT4u5txQyXszCQub8QFuLRkFq51WDhh1JGUwBf5vFlUMXh+gLs1up2NGL7dGLa8/aC2d9RYt1jAUbHSIMID7CvtRS12CE0dYkB9q80BmkdrS68pMpke37hwZnZYr3YRoQPODs7jHE6Yugzdyu8tphTmn9voG0cNY0lXpJ8HJCkDLAeQeXOFfiPkID3eES9sOLZWTfE9SK6AX6pDSgJHzov6b64jIZsD0S1Mg9i15x4s8yO2gI+EmMQT9pQeHHihtkbKNvuMMeZrSMVG991YfBoBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLIdjFTlIeEE0jwuCJBGMqaRuw8UdSBQ71K7x1sjlbI=;
 b=AFzqsLxKANU0EXzU9myhCM8H8FOhdVQCUgtzdLSJqawPfSefy9vdDrSRSPpTiIG/2KQoYxqedQG06UEE7EZHXZ759/uWkDFo+0rT+1cJPxaiTr1J+ya1DW9u9+pbUQeW5AoO7D5V3kT2yT+rh43NAdq/BpfcJq7fw/5IIcY9v+3xF7gOuVAdEnfz9nWy2gwfRzFmG2Hoo/JPypC61lA15x3gqz66tmGzNmgXpXwGnJhHCPk8Navv/3r9hfcIN+2oun58ESwuP9YBm69qFdX6GK7bwjyIBglMQz71DM0cai4QXjrR1PfLVOW5Q1XVPDUrJ7yk8gOl3oMRo0lstT+Amw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLIdjFTlIeEE0jwuCJBGMqaRuw8UdSBQ71K7x1sjlbI=;
 b=eddE2+O1awCMDyfSL7jBPOd7thUkAoDBkuM/zeuDSPc5Nhz4fqz+6IguocX/fG2x3ufUjILCV8pe8Dv/M0Nqln0gXqAlBIO1m0lYCmCJv0HdZCyEIRBEL5U6f8AlyytpeRvSJ3BuPIgpZXMjUe+Kvj4OpDl/J8fv4vYxdmExmnI=
Received: from PH0PR07CA0020.namprd07.prod.outlook.com (2603:10b6:510:5::25)
 by PH8PR12MB6913.namprd12.prod.outlook.com (2603:10b6:510:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Tue, 20 Jan
 2026 06:14:36 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::b0) by PH0PR07CA0020.outlook.office365.com
 (2603:10b6:510:5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 06:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 06:14:35 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 00:14:32 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 5/7] drm/amd/pm: Use feature bits data structure
Date: Tue, 20 Jan 2026 11:42:22 +0530
Message-ID: <20260120061402.1287680-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260120061402.1287680-1-lijo.lazar@amd.com>
References: <20260120061402.1287680-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|PH8PR12MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: e91ae6f9-f846-4a13-9a27-08de57eb2f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2xKiwUeVGYJtUCtWzcT3jOJBXLYlHM6BBCeffbXm3TyHibVnr7CFA86z4oq+?=
 =?us-ascii?Q?xyFNsnkL17rgJNxfBtlBJBNSsEvwr2rQV2rhKpNW5vu4QUphsBUoJGE1J5Uw?=
 =?us-ascii?Q?cc8LRDq1BRD10/9UNq+fQNYo2nIv0AT1CXAF071OnovBo9UI9ab3CQqFztjK?=
 =?us-ascii?Q?Fbx3zKk3R33qIE4v4VfEihBhMsHHh0H4v1NlOZtoteJAAe1tjUVA0j4xrYsX?=
 =?us-ascii?Q?632DDhvlptW/n00i+POqaepzjfyHQVPvYiI7mpUYqE06GFgHyQx9SfxA71Ss?=
 =?us-ascii?Q?HW5QmHeAOwPkxSWl9WiJs7sAOMP9Z5/NJWHk020HR1Z3mZAT4sozR+BjWH1k?=
 =?us-ascii?Q?/Jf4dDzBaaJgb8+If+DQHio8aCeNfwtMVTq0mv3Dcw2z5hQ/Qg8+o2fhxA1i?=
 =?us-ascii?Q?mU5fmCcLsqX+L1DPBwdrZqz0yQLPI4PprPmfW5QFeDlbeRTwEPrvZBqYegMO?=
 =?us-ascii?Q?EQqvBU43vAGQ6hp8KrPogBkr/jxayXGe88P+u/d5OvfgIjbmg0UVTdsZXOsf?=
 =?us-ascii?Q?FY076sxSBKx6XzIwD42JY3H+Rd02Os8RMc4NTYtIf5gSNmzzv7q9SK08tdNL?=
 =?us-ascii?Q?3jwCS7HJRkk7fuNXF3WDxWRxna3nML2Q3QhSuaUyhYkdZ9muOrZPfjnoVrLy?=
 =?us-ascii?Q?bSxFqzcHKlDXHJR8tzs37Gk0Mdqz4e5f78udJWFgsdRGHM+k1paMYPO1Vz6A?=
 =?us-ascii?Q?JlN/Ex4tjq5F/z3fpkykK6ErON2exyuTrAglm7VTOjo55ZE9iWOu6JBqf9Dv?=
 =?us-ascii?Q?+Gj0yIxnYp5/QS983sc2J1C9PfHSzntZlym3U6oBkVqh5eOaozXAFQCjXw7h?=
 =?us-ascii?Q?Kr6zWStfKMGZfrc9ApeFTGpCWLCc3V+H9GYlpEl2wSVhvjQHcPfav5EI9iWM?=
 =?us-ascii?Q?f6TuHVidYHKahMDLutcEMt9ZhjqabrffXZ9kYSfgg+eXx6+ZRXnQFTvQRx6W?=
 =?us-ascii?Q?EvWt9zzuf37JK//L/cEfoMpIsajUPuYW6E+h2RF99GQbHH4SOS9EDa/WftLZ?=
 =?us-ascii?Q?XT0OmD14Q1/y447BltQ6eQJ47DkfQ2d59VtHawv3O7mtXM+hjjoc5fCtacwI?=
 =?us-ascii?Q?JYQyc0LIfA63XQ1qXnzujBEYzOWM7Jop/8OOkj9bA9xcJ68zU5Dy2Blc2Jqn?=
 =?us-ascii?Q?LTZfysbsZ1ASK5yi6jojQrLeBiyav/xKpVNyCajRE9NZCnkHoMTasOe9cHHE?=
 =?us-ascii?Q?NkUigIq7bs9PW8Pf2SgltAcxsmgMnaqRcs4sSy+cLkc3pw7bX2UOfOFiFEnU?=
 =?us-ascii?Q?UMBM4sORwCojZPsvi/GMU62+RwsZYxTCYy9tYfdUyXpuqqPPx36yjU9aaG4z?=
 =?us-ascii?Q?stlqTBiDzPf3x+Hcd1UP7Miywtsb95WpX8xoCwXnANfjpivvJ14YlnZeFkjK?=
 =?us-ascii?Q?z4NzMrb8l+UBm4zTBnjQfipteIxa7UxBW+CzF7QkV+2ta6ekI+zxeUzcOsEP?=
 =?us-ascii?Q?xNeixuo92pwn6RjWFizDdWw7rDK4Z33qBY3qnkEID3eN1OBgfU8BZoVrLe05?=
 =?us-ascii?Q?sNh/YK+NgeTaTQwQ/lO+ehCeVrDwaThFWR+5Xsp1uAR3bGL6BgeK1ofDb98/?=
 =?us-ascii?Q?EfVkhD8BBfJp43dpfTAnx/4q9u+VmR32wLe+zdGuUR95N74Wn6WIvD9LcRJZ?=
 =?us-ascii?Q?QK1Pc+RoCPatzmnfV3sqlNIZc4aaN23po+6rBEeGi4N7KaGPX9EzIoivwc6o?=
 =?us-ascii?Q?MruZsA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 06:14:35.3626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e91ae6f9-f846-4a13-9a27-08de57eb2f3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6913
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

Feature bits are not necessarily restricted to 64-bits. Use
smu_feature_bits data structure to represent feature mask for checking
DPM status.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 17 ++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 21 +++++++-----
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   | 16 +++++----
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 26 ++++++++-------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 26 ++++++++-------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 28 +++++++++-------
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 25 ++++++++------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 22 ++++++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  | 33 ++++++++++---------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  | 28 +++++++++-------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 22 +++++++++----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 22 ++++++++-----
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 28 +++++++++-------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 32 ++++++++++--------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 18 +++++-----
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 32 ++++++++++--------
 16 files changed, 237 insertions(+), 159 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 7c63c631f6d4..c58290686f0d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -477,6 +477,23 @@ struct smu_feature_bits {
 	DECLARE_BITMAP(bits, SMU_FEATURE_MAX);
 };
 
+/*
+ * Helpers for initializing smu_feature_bits statically.
+ * Use SMU_FEATURE_BIT_INIT() which automatically handles array indexing:
+ *   static const struct smu_feature_bits example = {
+ *       .bits = {
+ *           SMU_FEATURE_BIT_INIT(5),
+ *           SMU_FEATURE_BIT_INIT(10),
+ *           SMU_FEATURE_BIT_INIT(65),
+ *           SMU_FEATURE_BIT_INIT(100)
+ *       }
+ *   };
+ */
+#define SMU_FEATURE_BITS_ELEM(bit) ((bit) / BITS_PER_LONG)
+#define SMU_FEATURE_BITS_POS(bit) ((bit) % BITS_PER_LONG)
+#define SMU_FEATURE_BIT_INIT(bit) \
+	[SMU_FEATURE_BITS_ELEM(bit)] = (1UL << SMU_FEATURE_BITS_POS(bit))
+
 enum smu_feature_list {
 	SMU_FEATURE_LIST_SUPPORTED,
 	SMU_FEATURE_LIST_ALLOWED,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index b22a0e91826d..814f24b7ccc4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -65,14 +65,15 @@
 #define SMU_FEATURES_HIGH_MASK       0xFFFFFFFF00000000
 #define SMU_FEATURES_HIGH_SHIFT      32
 
-#define SMC_DPM_FEATURE ( \
-	FEATURE_DPM_PREFETCHER_MASK | \
-	FEATURE_DPM_GFXCLK_MASK | \
-	FEATURE_DPM_UCLK_MASK | \
-	FEATURE_DPM_SOCCLK_MASK | \
-	FEATURE_DPM_MP0CLK_MASK | \
-	FEATURE_DPM_FCLK_MASK | \
-	FEATURE_DPM_XGMI_MASK)
+static const struct smu_feature_bits arcturus_dpm_features = {
+	.bits = { SMU_FEATURE_BIT_INIT(FEATURE_DPM_PREFETCHER_BIT),
+		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
+		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK_BIT),
+		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_SOCCLK_BIT),
+		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_MP0CLK_BIT),
+		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_FCLK_BIT),
+		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_XGMI_BIT) }
+};
 
 #define smnPCIE_ESM_CTRL			0x111003D0
 
@@ -1527,12 +1528,14 @@ static bool arcturus_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	uint64_t feature_enabled;
+	uint32_t feature_mask[2];
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	return !!(feature_enabled & SMC_DPM_FEATURE);
+	smu_feature_bits_to_arr32(&arcturus_dpm_features, feature_mask, 64);
+	return !!(feature_enabled & *(uint64_t *)feature_mask);
 }
 
 static int arcturus_dpm_set_vcn_enable(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 4a5dcc893665..406acfbbbc63 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -60,11 +60,13 @@ static struct gfx_user_settings {
 
 static uint32_t cyan_skillfish_sclk_default;
 
-#define FEATURE_MASK(feature) (1ULL << feature)
-#define SMC_DPM_FEATURE ( \
-	FEATURE_MASK(FEATURE_FCLK_DPM_BIT)	|	\
-	FEATURE_MASK(FEATURE_SOC_DPM_BIT)	|	\
-	FEATURE_MASK(FEATURE_GFX_DPM_BIT))
+static const struct smu_feature_bits cyan_skillfish_dpm_features = {
+	.bits = {
+		SMU_FEATURE_BIT_INIT(FEATURE_FCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_SOC_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_GFX_DPM_BIT)
+	}
+};
 
 static struct cmn2asic_msg_mapping cyan_skillfish_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			0),
@@ -362,6 +364,7 @@ static bool cyan_skillfish_is_dpm_running(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 	uint64_t feature_enabled;
+	uint32_t feature_mask[2];
 
 	/* we need to re-init after suspend so return false */
 	if (adev->in_suspend)
@@ -378,7 +381,8 @@ static bool cyan_skillfish_is_dpm_running(struct smu_context *smu)
 		cyan_skillfish_get_smu_metrics_data(smu, METRICS_CURR_GFXCLK,
 			&cyan_skillfish_sclk_default);
 
-	return !!(feature_enabled & SMC_DPM_FEATURE);
+	smu_feature_bits_to_arr32(&cyan_skillfish_dpm_features, feature_mask, 64);
+	return !!(feature_enabled & *(uint64_t *)feature_mask);
 }
 
 static ssize_t cyan_skillfish_get_gpu_metrics(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f14eed052526..f5be64395108 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -58,16 +58,18 @@
 #undef pr_info
 #undef pr_debug
 
-#define FEATURE_MASK(feature) (1ULL << feature)
-#define SMC_DPM_FEATURE ( \
-	FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT) | \
-	FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT)	 | \
-	FEATURE_MASK(FEATURE_DPM_GFX_PACE_BIT)	 | \
-	FEATURE_MASK(FEATURE_DPM_UCLK_BIT)	 | \
-	FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT)	 | \
-	FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT)	 | \
-	FEATURE_MASK(FEATURE_DPM_LINK_BIT)	 | \
-	FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT))
+static const struct smu_feature_bits navi10_dpm_features = {
+	.bits = {
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_PREFETCHER_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFX_PACE_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_SOCCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_MP0CLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_LINK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_DCEFCLK_BIT)
+	}
+};
 
 #define SMU_11_0_GFX_BUSY_THRESHOLD 15
 
@@ -1620,12 +1622,14 @@ static bool navi10_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	uint64_t feature_enabled;
+	uint32_t feature_mask[2];
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	return !!(feature_enabled & SMC_DPM_FEATURE);
+	smu_feature_bits_to_arr32(&navi10_dpm_features, feature_mask, 64);
+	return !!(feature_enabled & *(uint64_t *)feature_mask);
 }
 
 static int navi10_get_fan_speed_rpm(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 98a02fc08214..7d23b6c8c538 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -60,16 +60,18 @@
 #undef pr_info
 #undef pr_debug
 
-#define FEATURE_MASK(feature) (1ULL << feature)
-#define SMC_DPM_FEATURE ( \
-	FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT) | \
-	FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT)     | \
-	FEATURE_MASK(FEATURE_DPM_UCLK_BIT)	 | \
-	FEATURE_MASK(FEATURE_DPM_LINK_BIT)       | \
-	FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT)     | \
-	FEATURE_MASK(FEATURE_DPM_FCLK_BIT)	 | \
-	FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT)	 | \
-	FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT))
+static const struct smu_feature_bits sienna_cichlid_dpm_features = {
+	.bits = {
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_PREFETCHER_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_LINK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_SOCCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_FCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_DCEFCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_MP0CLK_BIT)
+	}
+};
 
 #define SMU_11_0_7_GFX_BUSY_THRESHOLD 15
 
@@ -1535,12 +1537,14 @@ static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	uint64_t feature_enabled;
+	uint32_t feature_mask[2];
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	return !!(feature_enabled & SMC_DPM_FEATURE);
+	smu_feature_bits_to_arr32(&sienna_cichlid_dpm_features, feature_mask, 64);
+	return !!(feature_enabled & *(uint64_t *)feature_mask);
 }
 
 static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 4de1778ea6b3..f8b76577d008 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -58,17 +58,19 @@
 #define SMUIO_GFX_MISC_CNTL__SMU_GFX_cold_vs_gfxoff_MASK	0x00000001L
 #define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK		0x00000006L
 
-#define FEATURE_MASK(feature) (1ULL << feature)
-#define SMC_DPM_FEATURE ( \
-	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
-	FEATURE_MASK(FEATURE_VCN_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_FCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_SOCCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_MP0CLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_LCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_SHUBCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_DCFCLK_DPM_BIT)| \
-	FEATURE_MASK(FEATURE_GFX_DPM_BIT))
+static const struct smu_feature_bits vangogh_dpm_features = {
+	.bits = {
+		SMU_FEATURE_BIT_INIT(FEATURE_CCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_VCN_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_FCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_SOCCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_MP0CLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_LCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_SHUBCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DCFCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_GFX_DPM_BIT)
+	}
+};
 
 static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			0),
@@ -505,6 +507,7 @@ static bool vangogh_is_dpm_running(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 	uint64_t feature_enabled;
+	uint32_t feature_mask[2];
 
 	/* we need to re-init after suspend so return false */
 	if (adev->in_suspend)
@@ -515,7 +518,8 @@ static bool vangogh_is_dpm_running(struct smu_context *smu)
 	if (ret)
 		return false;
 
-	return !!(feature_enabled & SMC_DPM_FEATURE);
+	smu_feature_bits_to_arr32(&vangogh_dpm_features, feature_mask, 64);
+	return !!(feature_enabled & *(uint64_t *)feature_mask);
 }
 
 static int vangogh_get_dpm_clk_limited(struct smu_context *smu, enum smu_clk_type clk_type,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 3b6a34644a92..4185c7282a11 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -61,15 +61,18 @@
 	[smu_feature] = {1, (aldebaran_feature)}
 
 #define FEATURE_MASK(feature) (1ULL << feature)
-#define SMC_DPM_FEATURE ( \
-			  FEATURE_MASK(FEATURE_DATA_CALCULATIONS) | \
-			  FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT)	| \
-			  FEATURE_MASK(FEATURE_DPM_UCLK_BIT)	| \
-			  FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT)	| \
-			  FEATURE_MASK(FEATURE_DPM_FCLK_BIT)	| \
-			  FEATURE_MASK(FEATURE_DPM_LCLK_BIT)	| \
-			  FEATURE_MASK(FEATURE_DPM_XGMI_BIT)	| \
-			  FEATURE_MASK(FEATURE_DPM_VCN_BIT))
+static const struct smu_feature_bits aldebaran_dpm_features = {
+	.bits = {
+		SMU_FEATURE_BIT_INIT(FEATURE_DATA_CALCULATIONS),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_SOCCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_FCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_LCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_XGMI_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_VCN_BIT)
+	}
+};
 
 #define smnPCIE_ESM_CTRL			0x111003D0
 
@@ -1396,11 +1399,13 @@ static bool aldebaran_is_dpm_running(struct smu_context *smu)
 {
 	int ret;
 	uint64_t feature_enabled;
+	uint32_t feature_mask[2];
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
-	return !!(feature_enabled & SMC_DPM_FEATURE);
+	smu_feature_bits_to_arr32(&aldebaran_dpm_features, feature_mask, 64);
+	return !!(feature_enabled & *(uint64_t *)feature_mask);
 }
 
 static int aldebaran_i2c_xfer(struct i2c_adapter *i2c_adap,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 9c4298736b28..0856c1c34d7a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -59,14 +59,16 @@
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
-#define FEATURE_MASK(feature) (1ULL << feature)
-#define SMC_DPM_FEATURE ( \
-	FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT)     | \
-	FEATURE_MASK(FEATURE_DPM_UCLK_BIT)	 | \
-	FEATURE_MASK(FEATURE_DPM_LINK_BIT)       | \
-	FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT)     | \
-	FEATURE_MASK(FEATURE_DPM_FCLK_BIT)	 | \
-	FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT))
+static const struct smu_feature_bits smu_v13_0_0_dpm_features = {
+	.bits = {
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_LINK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_SOCCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_FCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_MP0CLK_BIT)
+	}
+};
 
 #define MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE	0x4000
 
@@ -690,12 +692,14 @@ static bool smu_v13_0_0_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	uint64_t feature_enabled;
+	uint32_t feature_mask[2];
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	return !!(feature_enabled & SMC_DPM_FEATURE);
+	smu_feature_bits_to_arr32(&smu_v13_0_0_dpm_features, feature_mask, 64);
+	return !!(feature_enabled & *(uint64_t *)feature_mask);
 }
 
 static int smu_v13_0_0_system_features_control(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 41c61362f7fc..741762f4bd2c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -52,24 +52,25 @@
 #define mmMP1_SMN_C2PMSG_90			0x029a
 #define mmMP1_SMN_C2PMSG_90_BASE_IDX		1
 
-#define FEATURE_MASK(feature) (1ULL << feature)
-
 #define SMU_13_0_4_UMD_PSTATE_GFXCLK			938
 #define SMU_13_0_4_UMD_PSTATE_SOCCLK			938
 #define SMU_13_0_4_UMD_PSTATE_FCLK			1875
 
-#define SMC_DPM_FEATURE ( \
-	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
-	FEATURE_MASK(FEATURE_VCN_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_FCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_SOCCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_MP0CLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_LCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_SHUBCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_DCFCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_ISP_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_IPU_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_GFX_DPM_BIT))
+static const struct smu_feature_bits smu_v13_0_4_dpm_features = {
+	.bits = {
+		SMU_FEATURE_BIT_INIT(FEATURE_CCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_VCN_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_FCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_SOCCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_MP0CLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_LCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_SHUBCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DCFCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_ISP_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_IPU_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_GFX_DPM_BIT)
+	}
+};
 
 static struct cmn2asic_msg_mapping smu_v13_0_4_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			1),
@@ -213,13 +214,15 @@ static bool smu_v13_0_4_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	uint64_t feature_enabled;
+	uint32_t feature_mask[2];
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
 
-	return !!(feature_enabled & SMC_DPM_FEATURE);
+	smu_feature_bits_to_arr32(&smu_v13_0_4_dpm_features, feature_mask, 64);
+	return !!(feature_enabled & *(uint64_t *)feature_mask);
 }
 
 static int smu_v13_0_4_system_features_control(struct smu_context *smu, bool en)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index e4be727789c0..7311162e50f0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -51,17 +51,19 @@
 #define mmMP1_C2PMSG_33                                                                                (0xbee261 + 0xb00000 / 4)
 #define mmMP1_C2PMSG_33_BASE_IDX                                                                   0
 
-#define FEATURE_MASK(feature) (1ULL << feature)
-#define SMC_DPM_FEATURE ( \
-	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
-	FEATURE_MASK(FEATURE_FCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_LCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_GFX_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_VCN_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_DCFCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_SOCCLK_DPM_BIT)| \
-	FEATURE_MASK(FEATURE_MP0CLK_DPM_BIT)| \
-	FEATURE_MASK(FEATURE_SHUBCLK_DPM_BIT))
+static const struct smu_feature_bits smu_v13_0_5_dpm_features = {
+	.bits = {
+		SMU_FEATURE_BIT_INIT(FEATURE_CCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_FCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_LCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_GFX_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_VCN_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DCFCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_SOCCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_MP0CLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_SHUBCLK_DPM_BIT)
+	}
+};
 
 static struct cmn2asic_msg_mapping smu_v13_0_5_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			1),
@@ -231,13 +233,15 @@ static bool smu_v13_0_5_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	uint64_t feature_enabled;
+	uint32_t feature_mask[2];
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
 
-	return !!(feature_enabled & SMC_DPM_FEATURE);
+	smu_feature_bits_to_arr32(&smu_v13_0_5_dpm_features, feature_mask, 64);
+	return !!(feature_enabled & *(uint64_t *)feature_mask);
 }
 
 static int smu_v13_0_5_mode_reset(struct smu_context *smu, int type)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index bd893e95515f..97866e570192 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -76,12 +76,18 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_14.bin");
 	[smu_feature] = { 1, (smu_13_0_6_feature) }
 
 #define FEATURE_MASK(feature) (1ULL << feature)
-#define SMC_DPM_FEATURE                                                        \
-	(FEATURE_MASK(FEATURE_DATA_CALCULATION) |                              \
-	 FEATURE_MASK(FEATURE_DPM_GFXCLK) | FEATURE_MASK(FEATURE_DPM_UCLK) |   \
-	 FEATURE_MASK(FEATURE_DPM_SOCCLK) | FEATURE_MASK(FEATURE_DPM_FCLK) |   \
-	 FEATURE_MASK(FEATURE_DPM_LCLK) | FEATURE_MASK(FEATURE_DPM_XGMI) |     \
-	 FEATURE_MASK(FEATURE_DPM_VCN))
+static const struct smu_feature_bits smu_v13_0_6_dpm_features = {
+	.bits = {
+		SMU_FEATURE_BIT_INIT(FEATURE_DATA_CALCULATION),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_SOCCLK),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_FCLK),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_LCLK),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_XGMI),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_VCN)
+	}
+};
 
 #define smnPCIE_ESM_CTRL 0x93D0
 #define smnPCIE_LC_LINK_WIDTH_CNTL 0x1a340288
@@ -2284,6 +2290,7 @@ static bool smu_v13_0_6_is_dpm_running(struct smu_context *smu)
 {
 	int ret;
 	uint64_t feature_enabled;
+	uint32_t feature_mask[2];
 
 	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12))
 		return smu_v13_0_12_is_dpm_running(smu);
@@ -2293,7 +2300,8 @@ static bool smu_v13_0_6_is_dpm_running(struct smu_context *smu)
 	if (ret)
 		return false;
 
-	return !!(feature_enabled & SMC_DPM_FEATURE);
+	smu_feature_bits_to_arr32(&smu_v13_0_6_dpm_features, feature_mask, 64);
+	return !!(feature_enabled & *(uint64_t *)feature_mask);
 }
 
 static int smu_v13_0_6_request_i2c_xfer(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 415766dbfe6c..eeff6c874635 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -59,14 +59,16 @@
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
-#define FEATURE_MASK(feature) (1ULL << feature)
-#define SMC_DPM_FEATURE ( \
-	FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT)     | \
-	FEATURE_MASK(FEATURE_DPM_UCLK_BIT)	 | \
-	FEATURE_MASK(FEATURE_DPM_LINK_BIT)       | \
-	FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT)     | \
-	FEATURE_MASK(FEATURE_DPM_FCLK_BIT)	 | \
-	FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT))
+static const struct smu_feature_bits smu_v13_0_7_dpm_features = {
+	.bits = {
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_LINK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_SOCCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_FCLK_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DPM_MP0CLK_BIT)
+	}
+};
 
 #define smnMP1_FIRMWARE_FLAGS_SMU_13_0_7   0x3b10028
 
@@ -698,12 +700,14 @@ static bool smu_v13_0_7_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	uint64_t feature_enabled;
+	uint32_t feature_mask[2];
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	return !!(feature_enabled & SMC_DPM_FEATURE);
+	smu_feature_bits_to_arr32(&smu_v13_0_7_dpm_features, feature_mask, 64);
+	return !!(feature_enabled & *(uint64_t *)feature_mask);
 }
 
 static uint32_t smu_v13_0_7_get_throttler_status(SmuMetrics_t *metrics)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 7f70f79c3b2f..2331dbb9181a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -55,17 +55,19 @@
 #define SMU_13_0_1_UMD_PSTATE_SOCCLK		              678
 #define SMU_13_0_1_UMD_PSTATE_FCLK			          1800
 
-#define FEATURE_MASK(feature) (1ULL << feature)
-#define SMC_DPM_FEATURE ( \
-	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
-	FEATURE_MASK(FEATURE_VCN_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_FCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_SOCCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_MP0CLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_LCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_SHUBCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_DCFCLK_DPM_BIT)| \
-	FEATURE_MASK(FEATURE_GFX_DPM_BIT))
+static const struct smu_feature_bits yellow_carp_dpm_features = {
+	.bits = {
+		SMU_FEATURE_BIT_INIT(FEATURE_CCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_VCN_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_FCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_SOCCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_MP0CLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_LCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_SHUBCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DCFCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_GFX_DPM_BIT)
+	}
+};
 
 static struct cmn2asic_msg_mapping yellow_carp_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			1),
@@ -258,13 +260,15 @@ static bool yellow_carp_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	uint64_t feature_enabled;
+	uint32_t feature_mask[2];
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
 
-	return !!(feature_enabled & SMC_DPM_FEATURE);
+	smu_feature_bits_to_arr32(&yellow_carp_dpm_features, feature_mask, 64);
+	return !!(feature_enabled & *(uint64_t *)feature_mask);
 }
 
 static int yellow_carp_post_smu_init(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index a4e376e8328c..019e43fdecd6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -72,19 +72,21 @@
 #define SMU_14_0_4_UMD_PSTATE_GFXCLK			938
 #define SMU_14_0_4_UMD_PSTATE_SOCCLK			938
 
-#define FEATURE_MASK(feature) (1ULL << feature)
-#define SMC_DPM_FEATURE ( \
-	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
-	FEATURE_MASK(FEATURE_VCN_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_FCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_SOCCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_LCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_SHUBCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_DCFCLK_DPM_BIT)| \
-	FEATURE_MASK(FEATURE_ISP_DPM_BIT)| \
-	FEATURE_MASK(FEATURE_IPU_DPM_BIT)	| \
-	FEATURE_MASK(FEATURE_GFX_DPM_BIT)	| \
-	FEATURE_MASK(FEATURE_VPE_DPM_BIT))
+static const struct smu_feature_bits smu_v14_0_0_dpm_features = {
+	.bits = {
+		SMU_FEATURE_BIT_INIT(FEATURE_CCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_VCN_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_FCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_SOCCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_LCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_SHUBCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DCFCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_ISP_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_IPU_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_GFX_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_VPE_DPM_BIT)
+	}
+};
 
 enum smu_mall_pg_config {
 	SMU_MALL_PG_CONFIG_PMFW_CONTROL = 0,
@@ -471,13 +473,15 @@ static bool smu_v14_0_0_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	uint64_t feature_enabled;
+	uint32_t feature_mask[2];
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
 
-	return !!(feature_enabled & SMC_DPM_FEATURE);
+	smu_feature_bits_to_arr32(&smu_v14_0_0_dpm_features, feature_mask, 64);
+	return !!(feature_enabled & *(uint64_t *)feature_mask);
 }
 
 static int smu_v14_0_0_set_watermarks_table(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 3c351ee41e68..eb8bad2de1cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -56,13 +56,13 @@
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
-#define FEATURE_MASK(feature) (1ULL << feature)
-#define SMC_DPM_FEATURE ( \
-	FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT)     | \
-	FEATURE_MASK(FEATURE_DPM_UCLK_BIT)	 | \
-	FEATURE_MASK(FEATURE_DPM_LINK_BIT)       | \
-	FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT)     | \
-	FEATURE_MASK(FEATURE_DPM_FCLK_BIT))
+static const struct smu_feature_bits smu_v14_0_2_dpm_features = {
+	.bits = { SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
+		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK_BIT),
+		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_LINK_BIT),
+		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_SOCCLK_BIT),
+		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_FCLK_BIT) }
+};
 
 #define MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE	0x4000
 #define DEBUGSMC_MSG_Mode1Reset        2
@@ -590,12 +590,14 @@ static bool smu_v14_0_2_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	uint64_t feature_enabled;
+	uint32_t feature_mask[2];
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 	if (ret)
 		return false;
 
-	return !!(feature_enabled & SMC_DPM_FEATURE);
+	smu_feature_bits_to_arr32(&smu_v14_0_2_dpm_features, feature_mask, 64);
+	return !!(feature_enabled & *(uint64_t *)feature_mask);
 }
 
 static uint32_t smu_v14_0_2_get_throttler_status(SmuMetrics_t *metrics)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index b48444706c1e..d66e9a1a0ef8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -70,19 +70,21 @@
 #define SMU_15_0_UMD_PSTATE_FCLK 1800
 
 
-#define FEATURE_MASK(feature) (1ULL << feature)
-#define SMC_DPM_FEATURE ( \
-	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
-	FEATURE_MASK(FEATURE_VCN_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_FCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_SOCCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_LCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_SHUBCLK_DPM_BIT)	 | \
-	FEATURE_MASK(FEATURE_DCFCLK_DPM_BIT)| \
-	FEATURE_MASK(FEATURE_ISP_DPM_BIT)| \
-	FEATURE_MASK(FEATURE_NPU_DPM_BIT)	| \
-	FEATURE_MASK(FEATURE_GFX_DPM_BIT)	| \
-	FEATURE_MASK(FEATURE_VPE_DPM_BIT))
+static const struct smu_feature_bits smu_v15_0_0_dpm_features = {
+	.bits = {
+		SMU_FEATURE_BIT_INIT(FEATURE_CCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_VCN_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_FCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_SOCCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_LCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_SHUBCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_DCFCLK_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_ISP_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_NPU_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_GFX_DPM_BIT),
+		SMU_FEATURE_BIT_INIT(FEATURE_VPE_DPM_BIT)
+	}
+};
 
 enum smu_mall_pg_config {
 	SMU_MALL_PG_CONFIG_PMFW_CONTROL = 0,
@@ -445,13 +447,15 @@ static bool smu_v15_0_0_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	uint64_t feature_enabled;
+	uint32_t feature_mask[2];
 
 	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
 
-	return !!(feature_enabled & SMC_DPM_FEATURE);
+	smu_feature_bits_to_arr32(&smu_v15_0_0_dpm_features, feature_mask, 64);
+	return !!(feature_enabled & *(uint64_t *)feature_mask);
 }
 
 static int smu_v15_0_0_set_watermarks_table(struct smu_context *smu,
-- 
2.49.0

