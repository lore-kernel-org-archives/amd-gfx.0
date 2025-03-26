Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9665DC36010
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 08:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A38F10E661;
	Wed, 26 Mar 2025 08:14:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W/curXi3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA87A10E65C
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 08:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cu01OJ7oKBOpKnmZfDV83gcbbUwhdo3wQZ9rcTWDmTfI7j6q4GJCDQfF3ALllVat+qWsafxa33NQUNWH7hjvxS+rEW5mK2WjLOQNg+YCI8o1kaOYAIC+9gbcPjabYdVyR5jowKyvjE+KvPYZ5t6Eb2XoQqIW3X4341z18zgKdF7oobFyVYNKtamFuGXa0OcB8g99Xfqy7yXXTOGpP7j0mN2v2eszWf5pJCtf1pF4FjCBw3hNez8TJs+K+sYsSkIX+nSofMw+xADgaLpUc5CKtMvyQ0R6KJlMm4fDpNR0VRh2/RxUXD1rLHXerNRGfpktATO+jT9Jk42v1P0GLTqq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlVry9q6K2XJwQldKr/wMR1CDeEb3FofRizry+K4uhk=;
 b=rQoLSxDpFUesPTUKzdaSU40XIaygWoPEgVirlRyeu0MOg29hrptgHYUnxPVd95KfzSnOMNauxVApSZDjcswTXeH/TRsOFt8REDw4WTNLk66ub2Wfr5EHaGtqC/QKsJ+tO7nfnPuCMaGGU5qMxHBN9wY1vwSbwb8X3TG3s8Dsjvj+bN/1gPDwYZsrZhGq1Qfz53SbdoP3STbYVs21eqgvdJHgHXTICO0B140iMlefsvvMPOrv8c1ZlQ07RFfzaFsSwXxIrKdJNzvkHJ4iq/4ebAtqNxU/FTjUYHKcPY7/0n4M40PktAqCL2qfmnNRz4yi9jChQejIih5PpuHofZY81Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlVry9q6K2XJwQldKr/wMR1CDeEb3FofRizry+K4uhk=;
 b=W/curXi3KNZugwEJu+X/pPdEtLfJKX6Lyqy3UIB/JYazPYIli6RbkW3UtvOPGQRe0UzYuldx1WwUqSbG0ghnusA+QHp2fXwkcBNipiJT6mM6MflSL0aWWce5fWkCitXiUOUtCxdq73So1W90zbQn379va4PEppcy/UzUudXoIEY=
Received: from CYXPR03CA0039.namprd03.prod.outlook.com (2603:10b6:930:d2::24)
 by SJ0PR12MB6944.namprd12.prod.outlook.com (2603:10b6:a03:47b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 08:14:23 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:d2:cafe::1f) by CYXPR03CA0039.outlook.office365.com
 (2603:10b6:930:d2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.40 via Frontend Transport; Wed,
 26 Mar 2025 08:14:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 08:14:22 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 03:14:20 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amd/pm: Expose smu_v13_0_6 caps
Date: Wed, 26 Mar 2025 16:13:58 +0800
Message-ID: <20250326081400.1305136-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250326081400.1305136-1-asad.kamal@amd.com>
References: <20250326081400.1305136-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|SJ0PR12MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d10c55-a018-4ed0-8869-08dd6c3e376f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fLje/XQLM6X1wXa6VvCIbeBhUW45RiOTgzPQzFP0sMsNGt0KKww+oexuOb4R?=
 =?us-ascii?Q?e+v89lr4iN1O1u6AqNKmHtRbDD7iZymHoMG2R2f4y5Ga0T7YwO5gOg5KqMSJ?=
 =?us-ascii?Q?sCm/8MTVB9Hf903mi2PRj42mZthcpdeT351JrdfLghR2c1FjMJOlEcb+tIPN?=
 =?us-ascii?Q?qon03Yf615oP8mTh4uXodBQubwsLUH6NIMyinv1f0Rw8LhmJYZsmlVf4ieZi?=
 =?us-ascii?Q?NRIcW0JigtV/pih0dLEPU4PCyFr6ERFmIG2B/7990oOWPwbo4l1VTO6RwtHe?=
 =?us-ascii?Q?BwpNMk0KdHCk69C5HC0TPk9BQhAESRKOgU8qesfR6iYMBGbk5omk0ZkQK+ht?=
 =?us-ascii?Q?K1OUOBQAj5DvLzhRv6YrdldNJMaso2++gRYFxtww40zNFfRJT14yg4p6h2Rd?=
 =?us-ascii?Q?G5lP9qLZ23+XgyW7SzPnTPwghUKtxFsh03wyG8uMUpr2DHS1JIMj6Egb/v27?=
 =?us-ascii?Q?kvKQ4/Ldq4om7Cdis//BWZZN2hes/cpOcwiHQSLTY5zo8826UrU2zHu1y3Wt?=
 =?us-ascii?Q?IsgXKpdN8ZYDMXhrcUQLgMiYOX9/hL+9w+Cw4ReLNo288ugLzpRs0WFgUVuk?=
 =?us-ascii?Q?ZMhxsIVCMNs+Ok5/5iODssdFtN0nwIbanV9XtLI6RuyYO+paT9PGuMC5SLv+?=
 =?us-ascii?Q?IOPX/SabrutVN993FNByjJs+ml6+/HzcQRZsznHftLWYZ6vDeifHkEpAPjD5?=
 =?us-ascii?Q?CBLWu1GID/4l78MsreQUx90zHT6+34rDFAEz8bGTdTrsen1Bl6zgefMGhxPh?=
 =?us-ascii?Q?WRhyKSk8+t9WjOzML8noDQvzF/+VOikZoJ7Tr4f3Pr8lnRxSDzOnp14lN1zi?=
 =?us-ascii?Q?eJHmvHZMTWyIpN+2eV8dknGe3qPctXryfzin0UzIrpYhOceJa3Eg+Y11lhXX?=
 =?us-ascii?Q?1pJjkmug8KbNrxYegfiCKIsCsAFJnuppkl8SmAVrcx8lJNZma5ulMv7ncYdV?=
 =?us-ascii?Q?ZuZqlheRjRg+Jr2siOTgQqPCXGRfi7HcLDt5IZXqX/G/YIGMJAeozWE9zI/+?=
 =?us-ascii?Q?6RlIOdtCNPfpcubDqkLlROZQ0Q2jUzEX6LhTDcyi5RYmEF120AJSXU9LT3Bn?=
 =?us-ascii?Q?A3jxFu/Dfe6xElJGSPKnqq8QOFM4KxHjG9PYdA1fT/2xIUvBQdsr8U69pseI?=
 =?us-ascii?Q?Cn/7vHFHdyD1Wech+RDI2dHjaIPgYlFc4nPer+O8qdo3EcJt+XQVPI7WBjub?=
 =?us-ascii?Q?2OQ+yIC2N8F5SWq2vWtFLNNaQb7A66NPvXTwXCLrGZw1VJdJJ0rqz+7SfAx0?=
 =?us-ascii?Q?2fsK7BjYZ+vWfRXloZwrwt/Ty8ChV6kdmhls0kg8ce6QiHnOU/0wRJuDx7pP?=
 =?us-ascii?Q?DmdfUZXHIj9zXPYJByt6eZLOl67YxGyjFNqqDeg7JwMM7srVQ/Pudt8uh0Oo?=
 =?us-ascii?Q?NWD1oRuazBteoW+aepgYWxiOmjvtZfLhcmnEWitY4E6EW0TabyrEjpFQkDSX?=
 =?us-ascii?Q?upFdmjY63Crbnlp6oUYusJJ8FEg4OvbC3g6oBLGWEj62cZ5+puS0Mn3nXutJ?=
 =?us-ascii?Q?U+Ttnpv7Wj6hLLU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 08:14:22.8744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d10c55-a018-4ed0-8869-08dd6c3e376f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6944
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

Expose smu_v13_0_6 caps by moving it to common header

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 22 ++-----------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 18 +++++++++++++++
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9264dc33ee7e..f8489ebbd2ad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -101,24 +101,6 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_14.bin");
 #define MCA_BANK_IPID(_ip, _hwid, _type) \
 	[AMDGPU_MCA_IP_##_ip] = { .hwid = _hwid, .mcatype = _type, }
 
-#define SMU_CAP(x) SMU_13_0_6_CAPS_##x
-
-enum smu_v13_0_6_caps {
-	SMU_CAP(DPM),
-	SMU_CAP(DPM_POLICY),
-	SMU_CAP(OTHER_END_METRICS),
-	SMU_CAP(SET_UCLK_MAX),
-	SMU_CAP(PCIE_METRICS),
-	SMU_CAP(MCA_DEBUG_MODE),
-	SMU_CAP(PER_INST_METRICS),
-	SMU_CAP(CTF_LIMIT),
-	SMU_CAP(RMA_MSG),
-	SMU_CAP(ACA_SYND),
-	SMU_CAP(SDMA_RESET),
-	SMU_CAP(STATIC_METRICS),
-	SMU_CAP(ALL),
-};
-
 struct mca_bank_ipid {
 	enum amdgpu_mca_ip ip;
 	uint16_t hwid;
@@ -299,8 +281,8 @@ static inline void smu_v13_0_6_cap_clear(struct smu_context *smu,
 	dpm_context->caps &= ~BIT_ULL(cap);
 }
 
-static inline bool smu_v13_0_6_cap_supported(struct smu_context *smu,
-					     enum smu_v13_0_6_caps cap)
+bool smu_v13_0_6_cap_supported(struct smu_context *smu,
+			       enum smu_v13_0_6_caps cap)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 83745909e564..f28b1401fc76 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -26,6 +26,7 @@
 #define SMU_13_0_6_UMD_PSTATE_GFXCLK_LEVEL 0x2
 #define SMU_13_0_6_UMD_PSTATE_SOCCLK_LEVEL 0x4
 #define SMU_13_0_6_UMD_PSTATE_MCLK_LEVEL 0x2
+#define SMU_CAP(x) SMU_13_0_6_CAPS_##x
 
 typedef enum {
 /*0*/   METRICS_VERSION_V0                  = 0,
@@ -51,6 +52,23 @@ struct PPTable_t {
 	bool Init;
 };
 
+enum smu_v13_0_6_caps {
+	SMU_CAP(DPM),
+	SMU_CAP(DPM_POLICY),
+	SMU_CAP(OTHER_END_METRICS),
+	SMU_CAP(SET_UCLK_MAX),
+	SMU_CAP(PCIE_METRICS),
+	SMU_CAP(MCA_DEBUG_MODE),
+	SMU_CAP(PER_INST_METRICS),
+	SMU_CAP(CTF_LIMIT),
+	SMU_CAP(RMA_MSG),
+	SMU_CAP(ACA_SYND),
+	SMU_CAP(SDMA_RESET),
+	SMU_CAP(STATIC_METRICS),
+	SMU_CAP(ALL),
+};
+
 extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
+bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_0_6_caps cap);
 
 #endif
-- 
2.46.0

