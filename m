Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17721D29C37
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 15:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFC9010E483;
	Mon, 19 Jan 2026 15:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kj9YkNaX";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013060.outbound.protection.outlook.com
 [40.93.196.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A7110E4A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 15:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTjmbdihJBVMpo6JeMnT6zw6hCQGCbh7WVk08vnvaiKb3h46vut1/sBkn0xMpj5grgWqLcBJaz+RGjIL5GGn6qeVL1i5GBQlPoSDW4N55b9dJhpKuXOrVvuKFlUTu7hzcpaYaCPkEu9Gr5FSK2Atw8P6mwurWMA7apz4GrVVyyauNZDN9L2fCJQR+Q1DbeY7iJHkmySfpOKVL0Pj1pCSUOhImwmkSXnP/l6BH2hMxhUbirD16vupv1Y1h9LyUXjXDStjEzW8GXWxbOF/FPb7jYSxplGTeCCMPGhoSXfjN9QTrHF1uqbgS8v3EPOdwh0rNOrwBWDLpzFOKDhCibCSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLIdjFTlIeEE0jwuCJBGMqaRuw8UdSBQ71K7x1sjlbI=;
 b=KpLI3sCMAdMFRMVy1WENyFCk5wxefZVxRA4/CRJmnDujUrBn2RPL1xAT8R1ugCJkPA7Hwa3/RJ3VQ30oedqkGiT4snCc9kDqEm1FaVCfwW3cwco6XEHdCUt0fCfR2wtxGFgMZhe9sCmIsNoSR/bnoPQAUFNyjkfR11i+s2cq5JpDAWzJczKcsEWQhOlrhx7dLjcen4xypZPWqrlT6yf9TvyEYp5HHiQ48d8uMQ4+WGYwNHCTyyh8+16aN4MjbN8R1hijX5EDS9RJu3CWNSPuRyJET7m9egQ2NkAA+2x+bce5ChK73fctr3/iC6tpbh1yEmgx32G3D4MZsqsyXJtHBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLIdjFTlIeEE0jwuCJBGMqaRuw8UdSBQ71K7x1sjlbI=;
 b=kj9YkNaX/VkWy7ZbUO33sOFGX6hGFxagBX5SHMqyajxoxgtK3yIqE9fptWXMZUyQn2lyk+APHtbHRexbrI0t6Q1QIEYeovVqEQigBDQK02eUKQo4hZjCBXpfOTyeo7Otyog8YNnjAsSmk1r3wgOxCRK9qifwMza85US39AkBKec=
Received: from BL1PR13CA0189.namprd13.prod.outlook.com (2603:10b6:208:2be::14)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 15:33:45 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::e1) by BL1PR13CA0189.outlook.office365.com
 (2603:10b6:208:2be::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Mon,
 19 Jan 2026 15:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 15:33:45 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 09:33:43 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 5/7] drm/amd/pm: Use feature bits data structure
Date: Mon, 19 Jan 2026 20:58:22 +0530
Message-ID: <20260119153309.1234663-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260119153309.1234663-1-lijo.lazar@amd.com>
References: <20260119153309.1234663-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f5cd8b-1df4-412c-7cae-08de57702206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KKc2mT46On2a60pTD817Mj1QR2kNdZHQbun6CrqFedXPdSTu20Gf+JMVFfrd?=
 =?us-ascii?Q?5Oy1Qw8HVqocHJAhyiZKZ8PHie3Uw8+zmZukTkguH7EdCHiCQAxsxW38PEv9?=
 =?us-ascii?Q?EflXpLcv8g+OpyJJ5esGVpY4J9anOPEU/ESMjDzMdgmZ4XIZk2sdTRFGJ8vT?=
 =?us-ascii?Q?M/R/aL1QeYfLYaXSpuMp6MX8PdGpkNc/fyJMu/Kn/1WtfHQ8I04zRon/PE++?=
 =?us-ascii?Q?nVSQPk72HfMB+gvLtGygLkmIkM5DDlw526oBex89LYIoUC2OWMjuriQydb0k?=
 =?us-ascii?Q?MOaWMr3e+FFf/WpNpKUvcbV3x89dfIqmQOTHYcAyf+FjzU6glAwieOn9oZEv?=
 =?us-ascii?Q?xNY1leMiIqLi9va+nNwp+foaj+NWdESPvJ7RnUIKrabFiybk8F9udDHoIYL9?=
 =?us-ascii?Q?fcYaSei37WxgO5l9ohjpv2pfJ4UGuMps+rQFREqRtO3nQkEupPN000ryuI0E?=
 =?us-ascii?Q?LNU7KnySsAM7khSGGmHr1M6TT7Len8+IABXSjBPJPUG6gOTfR2CPg7zmrsTh?=
 =?us-ascii?Q?onp8i91MMKNBgeL046SO0oOF7heZZZ8Ooc3tNftRJdXA5imLtEEfXOgfBO46?=
 =?us-ascii?Q?++3/AatXb+o1403DjECs3oOLIv/wNgh+j/DE0Nl6pGfOGr/HPgXksGhu0S5a?=
 =?us-ascii?Q?nPn76TUYMNZOF2TD+Xqlt+oFwIL+c2GaiFKn098SeVNf7frGfxrod3sxG1Ea?=
 =?us-ascii?Q?zYH+EQlqzgxET54RapvNWxxBUdNTjUC/Fhu4VggMuK9qI076uCp8NLTAcVYA?=
 =?us-ascii?Q?wcEYkxrVPLX4peOlfix05IR4vkWGkFzz/H/PjywDpKIVipJ+CVLIXG0Rwbwz?=
 =?us-ascii?Q?r4CQNViq/ZIFEydqzgtfdrHqlbj5WDu5qn9NfSatJRS3Z2d+BNKAxh0YzdQo?=
 =?us-ascii?Q?oZMEIj1ilZw95oIzTM4MXYcYFg2i9RLfGH5/fmFItWIAe1v9Nm5e464yoWVT?=
 =?us-ascii?Q?jcCHDz+rVLqhAW9ZGTqfpRjxTk6PWQBNVzXUz8u5Wje3kaRx0eaYZTSjMRYR?=
 =?us-ascii?Q?ebQlQSc2MEg7gfdHw73HusOtqrAYZa6n83ByH58evguBqLuQvAj+oO6lfpNQ?=
 =?us-ascii?Q?d0v7xdiHpYLbAKRtsrkJoi7/+xEgQqFzgRJes3EjTISA+Xl5PdSDf2pTDzyq?=
 =?us-ascii?Q?kJ1+Xvw3hF2HvgG4eSdOoDe7C9YRA9+Xp8hY+7e3fJkuwz1vEq+V0QagHtQT?=
 =?us-ascii?Q?u8XmrOBvFMsOgELtHKtlxn7jzOMC3TsfLHlPJvFbu8Agb82LCb7NOYTaRF0T?=
 =?us-ascii?Q?6REv8jx0iSK93fOvna40LnTWgOaUHQP1Kb0QIYABlZP3oG6g1jOF8kA4lIFk?=
 =?us-ascii?Q?dSg2FGdSeuusEKNm+IMuQTxrm68ULFobAKtUMAuNzB6VDxv8YPdQ7EgJLO90?=
 =?us-ascii?Q?7S2qYAwfdNwZS7i48ZP3cpwSnFskf194KNW2uuFrhXQIfHo+Evk70c49giLq?=
 =?us-ascii?Q?gEhhlfUaYOYknkW2eyBRWnXV9a9bbKVB/uM4jPD/jzngde0vxRu9RhypzqBe?=
 =?us-ascii?Q?nqNfIWfSvBIqxkdlZyvfJO1U1eVHnTz8++Yu5oK6WWQrj3yVTG2beuQOM/ry?=
 =?us-ascii?Q?OFRft5Fqsed00vVYxg2zm+o1kCTFsiWis9bnmjmNGu0JPEbVVollV/Ya4Qzn?=
 =?us-ascii?Q?1oC4xJ6uA+wrRL4EvD6pE5odIkmEV+VEXIO9D+96QAxCVmLIZPN5AzJaf0R/?=
 =?us-ascii?Q?u0UEpQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 15:33:45.1559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f5cd8b-1df4-412c-7cae-08de57702206
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700
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

