Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BA3C02182
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 07:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BFFD10E4E5;
	Tue, 21 Jan 2025 07:42:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xsgqg+MC";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2997110E4E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 07:42:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfSgYCfr9kyGTJGgNH59DePZnQiHrmPhQQF/1wlB2H8Ovu/AhWAOxzFyPQIzG1AJRTXRnpuFhHJUdRxSEvuBjkXjYaZPudUv7memJV9Up0Rc8PmHqZML7Ai6zjmBaXcJDMb+4UMl6TCMyFinXx/4Z8oIHHefPc6BWbQLJ9AROpZ9DLI711J9HXpdRiLvJJBz8vZia9S6U8h/nI/hixq4iQAlv+uBYvfcv3hfiaouoQRnePQQNH24VAtXbwJFXH5o2wLsqX8F2RF9ys2HFmETKSTyM6kthpzmwPjLGXpdbVxNew+E942I6vCluvkzv3uBgrnFjpSo3v1IkWRp+tLj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6twY2Zt36GDDlK1htoJXOIx64obzkrDxLiNw3lSlaw=;
 b=mriapLj4mW5+Z3dNF00L4Jl9WzsGoY4OU/Pxbu1clCcfAYhrd4nwzN3vyuCtjV9xaBtsTd/+29Fxiv7YjcElktxCx9BC1Vi0DW7daXVz0H9w1z0dOE4tEELAQH/cosnwyLdEHj9NnN3FgFCA4nkCeNfSbV+LLHjd5Wygrw4MusZtt8vh31kK1bol+A/C7UwchjvtK2QnGQirhqoh2nlryudGw0Jx1urEJka5xV3jJ9PIZsap9a8em1sASMSLkfC6+FJjuD1NHSPS7aMqsnf6LS5xwpp06yGxRwZ4EMTS/B3WXTEV1oU6GaH58og3p+/vhbCGL4zPJg0jZBDFz5dnCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6twY2Zt36GDDlK1htoJXOIx64obzkrDxLiNw3lSlaw=;
 b=xsgqg+MC1JjIQXPjV3V+XNBDzNsvBKyqof5iMVVBZZE1QTY+REbEkXZDgnvCyGzS+7iCj0eDKAlWJAWg5OjsEmN46WM0CnOrabrH2t4nHxiv8D/hZx5OkK1GAfm/m14THxwC9c01bQSt9A2mwAl0szqFI4kqlr1pNngEYu0W/cc=
Received: from SJ0PR13CA0103.namprd13.prod.outlook.com (2603:10b6:a03:2c5::18)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 07:42:28 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::e3) by SJ0PR13CA0103.outlook.office365.com
 (2603:10b6:a03:2c5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.13 via Frontend Transport; Tue,
 21 Jan 2025 07:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 07:42:27 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 01:42:24 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v4] drm/amd/pm: Fix smu v13.0.6 caps initialization
Date: Tue, 21 Jan 2025 13:12:08 +0530
Message-ID: <20250121074208.1559798-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c73cdac-bd34-4458-a9f2-08dd39ef2740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8v3y9Acqm0F6OJ/KBzJNsWvBDPusvBD8tUYtbiXj6LoYoO/+217egFEApeOM?=
 =?us-ascii?Q?fuurbNDIotFJttFjv94m4M4PNqPWDpirl6BBImG8IJZP6xX+HAcxqWlcDgLN?=
 =?us-ascii?Q?P4scDO2COduFFi0u100TEwq+RtsuftJIjYqZmVSp2si3Me+6gQ3RJFd5vUav?=
 =?us-ascii?Q?24QiydalOF2OoMr3qABGKtVvEZnO57Cx/uabb3FeC5FlU+TMTrcLa7muct3e?=
 =?us-ascii?Q?byhhDz8MOKYRVsYQZKCh3Oqrz8+5c8fsNhEsdr1NLgpTXp5skA/CDv178UyJ?=
 =?us-ascii?Q?S/OWPUwL2n34H0pIuZj0/bXWmcLHgANzIKYn4Y/cu5RrNKanropFt4Oa8ckG?=
 =?us-ascii?Q?439Dz79JcK75Y05PvDY1gKleJ+SsEh0km/1z/IDIh6ZvGK6d8OCurwM/Og3U?=
 =?us-ascii?Q?qrA1GeZDos9o84/gM+432OuEvuXFlCMcLUVEnO1wmFW4JWRfv6/hYmJAIQbW?=
 =?us-ascii?Q?tHFmo4wcKv9j/zEGCvbt9Y83+317y4OHWNkpQSYThSFfp7VEF7gtkGPfKeXX?=
 =?us-ascii?Q?UMebPAFUFMcpdeK4FD+HfaqBAmLwR/97ttECwZdkoTm4mkOoFjNzk9C9Ggtb?=
 =?us-ascii?Q?Q5L6yqoV/SC1lWN9ufKaEo9oYKjtIvf1BrEyBJeyJLDeISbMHbmnLLyDwGnA?=
 =?us-ascii?Q?pl76V1iKC8VynsoChX7wXckq/BhTCkPkKqQ+74hLfXClG9hmrTYw3ktdbpMe?=
 =?us-ascii?Q?Az5/nC+Qcn+6vJXqq5KMyxyyruqEN1I/heug0ECuJmCcsxf4G0/qrrEYxj3j?=
 =?us-ascii?Q?+UIGJ5dc+YG8HF2PqHdNDTPBw8TFDOjGzYp0iaJIO2JtglBoYVEIocMgUSrA?=
 =?us-ascii?Q?7xmGlicfB//deqNcJPd/7WFwq4fnJj89BD9zMjLvsgkJaH1/6WVfS6ITpoeS?=
 =?us-ascii?Q?QMjFkUL65gtNKvfjcTyBoj8CxnVZalK08Tx/N/JZt/Qoa3ymxqqmlLffReDv?=
 =?us-ascii?Q?wuPFyqL043j7gPexRH6C3k9x54N/OueopjzLKP16HaT9aDNRv+IN9q02gWRg?=
 =?us-ascii?Q?IB8nM5YMixOOJeFBNEIxhAoz0FuP3cq6lqeCXuesrBn6URtOp6yGD7EcQt0X?=
 =?us-ascii?Q?9xiG91lplrlxBCe0sxL2+rtPNbU46WqiUKp+yrUM5T0JxR/sx9H0wwD475IU?=
 =?us-ascii?Q?DMmpQphBD3zujUZtD+sSRqksjBT3F8xlGNhGNPFoneMYcA40SecVgt66+wm2?=
 =?us-ascii?Q?9WDwQAH3FUyr7CTA8nSjguqpb3Tm3vggsZItJLbZ234E+szfDPNmVbiZyBbn?=
 =?us-ascii?Q?yrZTELfb2YmVaW/bQ7nIaTQO5Lci5VFbbFZFwTtvIsQCvG66abwb6XdaWlHY?=
 =?us-ascii?Q?HQRxcTXyVPsBskL2UErNRA9FujMfa3d+RDI/cHv/3JcRLGWwpT5MZRnF1YAq?=
 =?us-ascii?Q?F3kPlVhdYW3XvTbZA5lYKljxgEIncDY1r3HNUXrV8/fIg2nXkCon/9XnJJZd?=
 =?us-ascii?Q?Qq9CEwVCvLsS0g0swHM0xHi8FGu1TVNOrsJl7OEeVFANBE16SeWUux/B8hA9?=
 =?us-ascii?Q?QqRffZ08DR6C9oA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 07:42:27.3432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c73cdac-bd34-4458-a9f2-08dd39ef2740
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803
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
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Fixes: 9bb53d2ce109 ("drm/amd/pm: Add capability flags for SMU v13.0.6")
---
v1: ("drm/amd/pm: Use correct macros for smu caps")
v2:
        Use caps_set/clear instead of macros (Alex). Commit message changed.
        Use BIT_ULL (Kevin)
        Fix SET_UCLK_MAX capability on APUs
v3:
	Rename to cap to indicate operations on single capability (Alex)
	Use SMU_CAP in enum value definition also for consistency
v4:
	Rebase on top of the new checks for SDMA RESET cap.
	Add SMU v13.0.12 initial caps values.
	Keep CTF_LIMIT cap check common for SMU v13.0.6 (Asad)

 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 239 ++++++++++--------
 1 file changed, 134 insertions(+), 105 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index f8821783a099..fa11e30bff24 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -101,26 +101,25 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_14.bin");
 #define MCA_BANK_IPID(_ip, _hwid, _type) \
 	[AMDGPU_MCA_IP_##_ip] = { .hwid = _hwid, .mcatype = _type, }
 
+#define SMU_CAP(x) SMU_13_0_6_CAPS_##x
+
 enum smu_v13_0_6_caps {
-	SMU_13_0_6_CAPS_DPM,
-	SMU_13_0_6_CAPS_UNI_METRICS,
-	SMU_13_0_6_CAPS_DPM_POLICY,
-	SMU_13_0_6_CAPS_OTHER_END_METRICS,
-	SMU_13_0_6_CAPS_SET_UCLK_MAX,
-	SMU_13_0_6_CAPS_PCIE_METRICS,
-	SMU_13_0_6_CAPS_HST_LIMIT_METRICS,
-	SMU_13_0_6_CAPS_MCA_DEBUG_MODE,
-	SMU_13_0_6_CAPS_PER_INST_METRICS,
-	SMU_13_0_6_CAPS_CTF_LIMIT,
-	SMU_13_0_6_CAPS_RMA_MSG,
-	SMU_13_0_6_CAPS_ACA_SYND,
-	SMU_13_0_6_CAPS_SDMA_RESET,
-	SMU_13_0_6_CAPS_ALL,
+	SMU_CAP(DPM),
+	SMU_CAP(UNI_METRICS),
+	SMU_CAP(DPM_POLICY),
+	SMU_CAP(OTHER_END_METRICS),
+	SMU_CAP(SET_UCLK_MAX),
+	SMU_CAP(PCIE_METRICS),
+	SMU_CAP(HST_LIMIT_METRICS),
+	SMU_CAP(MCA_DEBUG_MODE),
+	SMU_CAP(PER_INST_METRICS),
+	SMU_CAP(CTF_LIMIT),
+	SMU_CAP(RMA_MSG),
+	SMU_CAP(ACA_SYND),
+	SMU_CAP(SDMA_RESET),
+	SMU_CAP(ALL),
 };
 
-#define SMU_CAPS_MASK(x) (ULL(1) << x)
-#define SMU_CAPS(x) SMU_CAPS_MASK(SMU_13_0_6_CAPS_##x)
-
 struct mca_bank_ipid {
 	enum amdgpu_mca_ip ip;
 	uint16_t hwid;
@@ -283,100 +282,143 @@ struct smu_v13_0_6_dpm_map {
 	uint32_t *freq_table;
 };
 
-static void smu_v13_0_14_init_caps(struct smu_context *smu)
+static inline void smu_v13_0_6_cap_set(struct smu_context *smu,
+				       enum smu_v13_0_6_caps cap)
+{
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+
+	dpm_context->caps |= BIT_ULL(cap);
+}
+
+static inline void smu_v13_0_6_cap_clear(struct smu_context *smu,
+					 enum smu_v13_0_6_caps cap)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	uint64_t caps = SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
-			SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
-			SMU_CAPS(PCIE_METRICS) | SMU_CAPS(CTF_LIMIT) |
-			SMU_CAPS(MCA_DEBUG_MODE) | SMU_CAPS(RMA_MSG) |
-			SMU_CAPS(ACA_SYND);
+
+	dpm_context->caps &= ~BIT_ULL(cap);
+}
+
+static inline bool smu_v13_0_6_cap_supported(struct smu_context *smu,
+					     enum smu_v13_0_6_caps cap)
+{
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+
+	return !!(dpm_context->caps & BIT_ULL(cap));
+}
+
+static void smu_v13_0_14_init_caps(struct smu_context *smu)
+{
+	enum smu_v13_0_6_caps default_cap_list[] = { SMU_CAP(DPM),
+						     SMU_CAP(UNI_METRICS),
+						     SMU_CAP(SET_UCLK_MAX),
+						     SMU_CAP(DPM_POLICY),
+						     SMU_CAP(PCIE_METRICS),
+						     SMU_CAP(CTF_LIMIT),
+						     SMU_CAP(MCA_DEBUG_MODE),
+						     SMU_CAP(RMA_MSG),
+						     SMU_CAP(ACA_SYND) };
 	uint32_t fw_ver = smu->smc_fw_version;
 
+	for (int i = 0; i < ARRAY_SIZE(default_cap_list); i++)
+		smu_v13_0_6_cap_set(smu, default_cap_list[i]);
+
 	if (fw_ver >= 0x05550E00)
-		caps |= SMU_CAPS(OTHER_END_METRICS);
+		smu_v13_0_6_cap_set(smu, SMU_CAP(OTHER_END_METRICS));
 	if (fw_ver >= 0x05551000)
-		caps |= SMU_CAPS(HST_LIMIT_METRICS);
+		smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
 	if (fw_ver >= 0x05550B00)
-		caps |= SMU_CAPS(PER_INST_METRICS);
-	if (fw_ver > 0x05550f00)
-		caps |= SMU_CAPS(SDMA_RESET);
+		smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS));
+	if (fw_ver >= 0x5551200)
+		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
+}
+
+static void smu_v13_0_12_init_caps(struct smu_context *smu)
+{
+	enum smu_v13_0_6_caps default_cap_list[] = { SMU_CAP(DPM),
+						     SMU_CAP(UNI_METRICS),
+						     SMU_CAP(PCIE_METRICS),
+						     SMU_CAP(CTF_LIMIT),
+						     SMU_CAP(MCA_DEBUG_MODE),
+						     SMU_CAP(RMA_MSG),
+						     SMU_CAP(ACA_SYND) };
+	uint32_t fw_ver = smu->smc_fw_version;
+
+	for (int i = 0; i < ARRAY_SIZE(default_cap_list); i++)
+		smu_v13_0_6_cap_set(smu, default_cap_list[i]);
 
-	dpm_context->caps = caps;
+	if (fw_ver < 0x00561900)
+		smu_v13_0_6_cap_clear(smu, SMU_CAP(DPM));
+
+	if (fw_ver >= 0x00561700)
+		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
 }
 
 static void smu_v13_0_6_init_caps(struct smu_context *smu)
 {
-	uint64_t caps = SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
-			SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
-			SMU_CAPS(PCIE_METRICS) | SMU_CAPS(MCA_DEBUG_MODE) |
-			SMU_CAPS(CTF_LIMIT) | SMU_CAPS(RMA_MSG) |
-			SMU_CAPS(ACA_SYND);
-	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	enum smu_v13_0_6_caps default_cap_list[] = { SMU_CAP(DPM),
+						     SMU_CAP(UNI_METRICS),
+						     SMU_CAP(SET_UCLK_MAX),
+						     SMU_CAP(DPM_POLICY),
+						     SMU_CAP(PCIE_METRICS),
+						     SMU_CAP(CTF_LIMIT),
+						     SMU_CAP(MCA_DEBUG_MODE),
+						     SMU_CAP(RMA_MSG),
+						     SMU_CAP(ACA_SYND) };
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t fw_ver = smu->smc_fw_version;
 	uint32_t pgm = (fw_ver >> 24) & 0xFF;
 
+	for (int i = 0; i < ARRAY_SIZE(default_cap_list); i++)
+		smu_v13_0_6_cap_set(smu, default_cap_list[i]);
+
 	if (fw_ver < 0x552F00)
-		caps &= ~SMU_CAPS(DPM);
+		smu_v13_0_6_cap_clear(smu, SMU_CAP(DPM));
+	if (fw_ver < 0x554500)
+		smu_v13_0_6_cap_clear(smu, SMU_CAP(CTF_LIMIT));
 
 	if (adev->flags & AMD_IS_APU) {
-		caps &= ~SMU_CAPS(PCIE_METRICS);
-		caps &= ~SMU_CAPS(SET_UCLK_MAX);
-		caps &= ~SMU_CAPS(DPM_POLICY);
-		caps &= ~SMU_CAPS(RMA_MSG);
-		caps &= ~SMU_CAPS(ACA_SYND);
+		smu_v13_0_6_cap_clear(smu, SMU_CAP(PCIE_METRICS));
+		smu_v13_0_6_cap_clear(smu, SMU_CAP(DPM_POLICY));
+		smu_v13_0_6_cap_clear(smu, SMU_CAP(RMA_MSG));
+		smu_v13_0_6_cap_clear(smu, SMU_CAP(ACA_SYND));
 
 		if (fw_ver <= 0x4556900)
-			caps &= ~SMU_CAPS(UNI_METRICS);
-
+			smu_v13_0_6_cap_clear(smu, SMU_CAP(UNI_METRICS));
 		if (fw_ver >= 0x04556F00)
-			caps |= SMU_CAPS(HST_LIMIT_METRICS);
+			smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
 		if (fw_ver >= 0x04556A00)
-			caps |= SMU_CAPS(PER_INST_METRICS);
-		if (fw_ver < 0x554500)
-			caps &= ~SMU_CAPS(CTF_LIMIT);
+			smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS));
 	} else {
 		if (fw_ver >= 0x557600)
-			caps |= SMU_CAPS(OTHER_END_METRICS);
+			smu_v13_0_6_cap_set(smu, SMU_CAP(OTHER_END_METRICS));
 		if (fw_ver < 0x00556000)
-			caps &= ~SMU_CAPS(DPM_POLICY);
+			smu_v13_0_6_cap_clear(smu, SMU_CAP(DPM_POLICY));
 		if (amdgpu_sriov_vf(adev) && (fw_ver < 0x556600))
-			caps &= ~SMU_CAPS(SET_UCLK_MAX);
+			smu_v13_0_6_cap_clear(smu, SMU_CAP(SET_UCLK_MAX));
 		if (fw_ver < 0x556300)
-			caps &= ~SMU_CAPS(PCIE_METRICS);
+			smu_v13_0_6_cap_clear(smu, SMU_CAP(PCIE_METRICS));
 		if (fw_ver < 0x554800)
-			caps &= ~SMU_CAPS(MCA_DEBUG_MODE);
+			smu_v13_0_6_cap_clear(smu, SMU_CAP(MCA_DEBUG_MODE));
 		if (fw_ver >= 0x556F00)
-			caps |= SMU_CAPS(PER_INST_METRICS);
-		if (fw_ver < 0x554500)
-			caps &= ~SMU_CAPS(CTF_LIMIT);
+			smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS));
 		if (fw_ver < 0x00555a00)
-			caps &= ~SMU_CAPS(RMA_MSG);
+			smu_v13_0_6_cap_clear(smu, SMU_CAP(RMA_MSG));
 		if (fw_ver < 0x00555600)
-			caps &= ~SMU_CAPS(ACA_SYND);
+			smu_v13_0_6_cap_clear(smu, SMU_CAP(ACA_SYND));
 		if (pgm == 0 && fw_ver >= 0x557900)
-			caps |= SMU_CAPS(HST_LIMIT_METRICS);
+			smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
 	}
-	if (((pgm == 7) && (fw_ver > 0x07550700)) ||
-	    ((pgm == 0) && (fw_ver > 0x00557700)) ||
-	    ((pgm == 4) && (fw_ver > 0x4556e6c)))
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
+	if (((pgm == 7) && (fw_ver >= 0x7550700)) ||
+	    ((pgm == 0) && (fw_ver >= 0x00557900)) ||
+	    ((pgm == 4) && (fw_ver >= 0x4557000)))
+		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
 }
 
 static void smu_v13_0_x_init_caps(struct smu_context *smu)
 {
 	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
+	case IP_VERSION(13, 0, 12):
+		return smu_v13_0_12_init_caps(smu);
 	case IP_VERSION(13, 0, 14):
 		return smu_v13_0_14_init_caps(smu);
 	default:
@@ -715,7 +757,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 	MetricsTableA_t *metrics_a = (MetricsTableA_t *)smu_table->metrics_table;
 	struct PPTable_t *pptable =
 		(struct PPTable_t *)smu_table->driver_pptable;
-	bool flag = !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRICS));
+	bool flag = !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS));
 	int ret, i, retry = 100;
 	uint32_t table_version;
 
@@ -911,7 +953,7 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
 	smu_v13_0_6_setup_driver_pptable(smu);
 
 	/* DPM policy not supported in older firmwares */
-	if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(DPM_POLICY))) {
+	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(DPM_POLICY))) {
 		struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 
 		smu_dpm->dpm_policies->policy_mask &=
@@ -1088,7 +1130,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	struct smu_table_context *smu_table = &smu->smu_table;
 	MetricsTableX_t *metrics_x = (MetricsTableX_t *)smu_table->metrics_table;
 	MetricsTableA_t *metrics_a = (MetricsTableA_t *)smu_table->metrics_table;
-	bool flag = !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRICS));
+	bool flag = !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS));
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 	int xcc_id;
@@ -1101,7 +1143,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
 	case METRICS_AVERAGE_GFXCLK:
-		if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(DPM))) {
+		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(DPM))) {
 			xcc_id = GET_INST(GC, 0);
 			*value = SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency, flag)[xcc_id]);
 		} else {
@@ -1788,7 +1830,7 @@ static int smu_v13_0_6_notify_unload(struct smu_context *smu)
 static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool enable)
 {
 	/* NOTE: this ClearMcaOnRead message is only supported for smu version 85.72.0 or higher */
-	if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(MCA_DEBUG_MODE)))
+	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(MCA_DEBUG_MODE)))
 		return 0;
 
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,
@@ -1933,8 +1975,8 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
 			if (max == pstate_table->uclk_pstate.curr.max)
 				return 0;
 			/* For VF, only allowed in FW versions 85.102 or greater */
-			if (!smu_v13_0_6_caps_supported(smu,
-							SMU_CAPS(SET_UCLK_MAX)))
+			if (!smu_v13_0_6_cap_supported(smu,
+						       SMU_CAP(SET_UCLK_MAX)))
 				return -EOPNOTSUPP;
 			/* Only max clock limiting is allowed for UCLK */
 			ret = smu_v13_0_set_soft_freq_limited_range(
@@ -2138,7 +2180,7 @@ static int smu_v13_0_6_get_enabled_mask(struct smu_context *smu,
 
 	ret = smu_cmn_get_enabled_mask(smu, feature_mask);
 
-	if (ret == -EIO && !smu_v13_0_6_caps_supported(smu, SMU_CAPS(DPM))) {
+	if (ret == -EIO && !smu_v13_0_6_cap_supported(smu, SMU_CAP(DPM))) {
 		*feature_mask = 0;
 		ret = 0;
 	}
@@ -2434,7 +2476,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_7 *gpu_metrics =
 		(struct gpu_metrics_v1_7 *)smu_table->gpu_metrics_table;
-	bool flag = !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRICS));
+	bool flag = !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS));
 	int ret = 0, xcc_id, inst, i, j, k, idx;
 	struct amdgpu_device *adev = smu->adev;
 	MetricsTableX_t *metrics_x;
@@ -2516,7 +2558,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 		 * table for both pf & one vf for smu version 85.99.0 or higher else report only
 		 * for pf from registers
 		 */
-		if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(PCIE_METRICS))) {
+		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(PCIE_METRICS))) {
 			gpu_metrics->pcie_link_width = metrics_x->PCIeLinkWidth;
 			gpu_metrics->pcie_link_speed =
 				pcie_gen_to_speed(metrics_x->PCIeLinkSpeed);
@@ -2545,8 +2587,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 				metrics_x->PCIeNAKSentCountAcc;
 		gpu_metrics->pcie_nak_rcvd_count_acc =
 				metrics_x->PCIeNAKReceivedCountAcc;
-		if (smu_v13_0_6_caps_supported(smu,
-					       SMU_CAPS(OTHER_END_METRICS)))
+		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(OTHER_END_METRICS)))
 			gpu_metrics->pcie_lc_perf_other_end_recovery =
 				metrics_x->PCIeOtherEndRecoveryAcc;
 
@@ -2571,7 +2612,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	gpu_metrics->num_partition = adev->xcp_mgr->num_xcps;
 
-	per_inst = smu_v13_0_6_caps_supported(smu, SMU_CAPS(PER_INST_METRICS));
+	per_inst = smu_v13_0_6_cap_supported(smu, SMU_CAP(PER_INST_METRICS));
 
 	for_each_xcp(adev->xcp_mgr, xcp, i) {
 		amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
@@ -2602,8 +2643,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 				gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
 					SMUQ10_ROUND(metrics_x->GfxBusyAcc[inst]);
 
-				if (smu_v13_0_6_caps_supported(
-					    smu, SMU_CAPS(HST_LIMIT_METRICS)))
+				if (smu_v13_0_6_cap_supported(
+					    smu, SMU_CAP(HST_LIMIT_METRICS)))
 					gpu_metrics->xcp_stats[i].gfx_below_host_limit_acc[idx] =
 						SMUQ10_ROUND(metrics_x->GfxclkBelowHostLimitAcc
 								[inst]);
@@ -2711,7 +2752,7 @@ static int smu_v13_0_6_get_thermal_temperature_range(struct smu_context *smu,
 		return -EINVAL;
 
 	/*Check smu version, GetCtfLimit message only supported for smu version 85.69 or higher */
-	if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(CTF_LIMIT)))
+	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(CTF_LIMIT)))
 		return 0;
 
 	/* Get SOC Max operating temperature */
@@ -2816,7 +2857,7 @@ static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
 	int ret;
 
 	/* NOTE: the message is only valid on dGPU with pmfw 85.90.0 and above */
-	if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(RMA_MSG)))
+	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(RMA_MSG)))
 		return 0;
 
 	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_RmaDueToBadPageThreshold, NULL);
@@ -2830,25 +2871,13 @@ static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
 
 static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 {
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
-	uint32_t smu_program;
-
-	smu_program = (smu->smc_fw_version >> 24) & 0xff;
-	/* the message is only valid on SMU 13.0.6/12/14 with these pmfw and above */
-	if (((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12)) &&
-		(smu->smc_fw_version < 0x00561700)) ||
-		((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 14)) &&
-		(smu->smc_fw_version < 0x5551200)) ||
-		((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 6)) &&
-		(((smu_program == 0) && (smu->smc_fw_version < 0x00557900)) ||
-		((smu_program == 4) && (smu->smc_fw_version < 0x4557000)) ||
-		((smu_program == 7) && (smu->smc_fw_version < 0x7550700)))))
+
+	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(SDMA_RESET)))
 		return -EOPNOTSUPP;
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 						SMU_MSG_ResetSDMA, inst_mask, NULL);
-
 	if (ret)
 		dev_err(smu->adev->dev,
 			"failed to send ResetSDMA event with mask 0x%x\n",
@@ -3167,7 +3196,7 @@ static bool mca_smu_bank_is_valid(const struct mca_ras_info *mca_ras, struct amd
 	if (instlo != 0x03b30400)
 		return false;
 
-	if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(ACA_SYND))) {
+	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(ACA_SYND))) {
 		errcode = MCA_REG__SYND__ERRORINFORMATION(entry->regs[MCA_REG_IDX_SYND]);
 		errcode &= 0xff;
 	} else {
@@ -3456,7 +3485,7 @@ static int aca_smu_parse_error_code(struct amdgpu_device *adev, struct aca_bank
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int error_code;
 
-	if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(ACA_SYND)))
+	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(ACA_SYND)))
 		error_code = ACA_REG__SYND__ERRORINFORMATION(bank->regs[ACA_REG_IDX_SYND]);
 	else
 		error_code = ACA_REG__STATUS__ERRORCODE(bank->regs[ACA_REG_IDX_STATUS]);
-- 
2.25.1

