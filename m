Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205E5C02182
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 05:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 361BC10E4C1;
	Tue, 21 Jan 2025 05:39:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jAytZPkE";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8858010E4C1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 05:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilVdBxVWiLpyXvqTOOaqG8j6Xh8FdvwNjv4a6xVRZNXuhvE4vOaAs/tQM5DYU6AGgT5+2XHcRJW7DsxiwSeKf8BJV9obj27eArxIV0/aOe9OXvt1EyLm9W5Xor46tU2KpyYn53ZGSd5CanhzmkqENK/ZZpv2Shk5ChhPYa2QD3teNyVBCUm2c2B42DCL8U0J79TLqWmxqA2MQaxlysj56t8RMyRYN58Wf0iEQIH8zpbLGlly++MJrqfReu31l5nJ7IkkLfqG19lWqX//Y+Ylwh3p3VIdDIuuhwk+gCMRFoqyfcPv7YQGfkO0lgDqeQ+A5mF5u3SF3diYMm+/o86kzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfNeY+tq1FQYPXFZfTRtXDrg1TkvwQIwkSCe3tOCB7s=;
 b=Aq3LRGG+vDz3ERVsE/Zd9HSNnBIYouifNXcwubAWk6HU7bwAAFHfQNEKqsF8AYckqbURypMJIzDamX6tNQybDbuRso9uRWp/cjku4FATKEiW5QhgWnWiauVJSC2y8PpF/w22aL60tiujK0HelPEB3cd2B3TSA78bn14hJTwqgkrUcofiBmB8tLm2Jc1bR4MgRCXwPcQy0tEqlQipwYq99LKYi2rjxce8uCIMtG+Aonq3MYT4bdFZVXJ+b5E6JegP/JbaeosmU0lnJYNOIO9J9TIcc/ltgfRi6eNuwnA/VESo9IW/uvRUo594KjZYom92p8qF/XACO82L7XBgSQVl3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfNeY+tq1FQYPXFZfTRtXDrg1TkvwQIwkSCe3tOCB7s=;
 b=jAytZPkEsmjedxbgbPqvPFJkBR+iAU95QjY8UVEqZ2ODkL7S2EjaeitsWgGVWNYVOJydLVnlfXRwMqIksmWe06vHzFsvt/MmGFpGTD4FO8lmClS/zV9WWlH0PTtD2UpDXOldIVbvGU3jcoMhmuvVf5zI0nUgMWD55KL6vr4ZOzY=
Received: from CH2PR12CA0006.namprd12.prod.outlook.com (2603:10b6:610:57::16)
 by MW6PR12MB8914.namprd12.prod.outlook.com (2603:10b6:303:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 05:39:48 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::cf) by CH2PR12CA0006.outlook.office365.com
 (2603:10b6:610:57::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Tue,
 21 Jan 2025 05:39:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 05:39:47 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 23:39:44 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v3] drm/amd/pm: Fix smu v13.0.6 caps initialization
Date: Tue, 21 Jan 2025 11:09:29 +0530
Message-ID: <20250121053929.1538914-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|MW6PR12MB8914:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7009f5-6901-4f44-3ad9-08dd39de0483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xr4iqa/ds4hua24eh8qvFJB6KXHTpEews+ySrlsmT2EGx7CpQe/bLSiaF3sH?=
 =?us-ascii?Q?PgCmktY4JMcvLegpCh35WbYyo/KW9cs3on+wJO90kpFocn2C7BF7qoWLkG2w?=
 =?us-ascii?Q?ioL4G43h/MjVhpH6otDtrhqJWECk3q8r1n4qxHZvcK0GhxMs+UykCsKSllxh?=
 =?us-ascii?Q?PIZOT1DgDKpIAQfSJrTFJy9YrcazD8wMmvGYwI/uxphZy6PDj1pLhuVb1y83?=
 =?us-ascii?Q?BApTIdTizeRiUtI2x8wbiCcgwv/wwCXmEyS7BAilDbv3EZyUHJFTkGtGEY5U?=
 =?us-ascii?Q?pQ3h0ri3o5yC0O4b77+4x3iZ3i03z10NCvm+SuKdVo4dJbX0uCx7HzYGlmsj?=
 =?us-ascii?Q?nsMyuOnim6af8HtMdviGzgYd9IkbdPQHJOKrsfZDiNLdiTIWB4Xi/Z9IGgx9?=
 =?us-ascii?Q?+65VKiguBc/6onE+2iO7UWXk6fa+DMGr5CHYuexOYFxqQHGQDS9MmDunXUJH?=
 =?us-ascii?Q?1HA6NC/QoeHePoOfiMWkdlhHEjujoBw6TLR9fU8cTLpvgxH1JxiYbv3RzHpc?=
 =?us-ascii?Q?HxVHB16DeobSouXxc1GgvPRmaqtfKwlYV7OYc3+M6EMpQMAU2Jab355YzJ8W?=
 =?us-ascii?Q?vltjK45t8CCjrX2utj/3ilJFaGVF3H/R5fKDJUh0j8F1c8lC4dPG2rU6bZD1?=
 =?us-ascii?Q?YW/2w1xjIt6on/yTC/3BUfzszhQKYfJ3W0F+CDIWB4fy13IFN0bK1N34+Ci/?=
 =?us-ascii?Q?wlqRPThnOzTD+RFpCOd52RlchzzOkVHNf8yuZ53YdFf365N4NB3ivIUwJ0o0?=
 =?us-ascii?Q?Qbkd5gyk7UghIgqwIZ04hv61NSqFvov5d1qDKRdxxQcrvqO7dpgyYzjQEDLJ?=
 =?us-ascii?Q?nw9eflAzueETyPdZnGC/mLQmhMGU28SRZ8QKtdtt/gHBRMMRbS08nVTPBzrt?=
 =?us-ascii?Q?flJ1P7dlH2BIW1rbL1lVxIzfU0J47vIo216oorrxjfFy94Zn3BRy+FNkEiFG?=
 =?us-ascii?Q?UQwKla9hEZNPdUv6vA2HMSada9uSqA6bUFgxBLAbPzl3eL68s9hqKORHnr3A?=
 =?us-ascii?Q?7UbKXXww+81piXqIFDemOENrxHNPUXk1xT0YwJp8s8yxvl/UB8KIiF/5UOkA?=
 =?us-ascii?Q?ItHHRvNWnRj3ESmgpkfHye9GVd/gSv8NNbQu9RYdTgJazURJSerYZbesug9D?=
 =?us-ascii?Q?syHmREzW2etPAgKc8JZBsWhso/rp7ZCi34CdCaDi6E0nLvV9lBr4Vo1aGqUH?=
 =?us-ascii?Q?vBAOCwJo1grsSzlB1q6oRFSEyCAyqiuxjfPtoiiSYMfBrVwcZz6n+aobCWsl?=
 =?us-ascii?Q?nn6Gr7ijOqeTmEokl4nqQtJCI1SPfm2gwweAlrnXmiKCkDcLh8RIyuYf6clY?=
 =?us-ascii?Q?lMo9YDpQytG7ZWi98k/k0rn/vlLO2PIUhNaOxR7TwrZGAVTGRP9bQvum15og?=
 =?us-ascii?Q?QsLylz28zm6bJ6lD8MA5ykMh2nXzzJIcatM/mDbXNZvklGgXpcVjZfLz1iN7?=
 =?us-ascii?Q?IShgVrhoX+uCvb786mdZehtWQri86zl1TVnDzsCR8JEi7Nfh7CiEsr/vg/8w?=
 =?us-ascii?Q?FJg3FI602qFKatg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 05:39:47.6616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7009f5-6901-4f44-3ad9-08dd39de0483
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8914
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

 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 197 ++++++++++--------
 1 file changed, 108 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 56e26fcd3066..d991a5df3796 100644
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
@@ -284,95 +283,116 @@ struct smu_v13_0_6_dpm_map {
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
+		smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS));
 	if (fw_ver > 0x05550f00)
-		caps |= SMU_CAPS(SDMA_RESET);
-
-	dpm_context->caps = caps;
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
 	if (fw_ver < 0x552F00)
-		caps &= ~SMU_CAPS(DPM);
+		smu_v13_0_6_cap_clear(smu, SMU_CAP(DPM));
 
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
+			smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS));
 		if (fw_ver < 0x554500)
-			caps &= ~SMU_CAPS(CTF_LIMIT);
+			smu_v13_0_6_cap_clear(smu, SMU_CAP(CTF_LIMIT));
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
+			smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS));
 		if (fw_ver < 0x554500)
-			caps &= ~SMU_CAPS(CTF_LIMIT);
+			smu_v13_0_6_cap_clear(smu, SMU_CAP(CTF_LIMIT));
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
+		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
 }
 
 static void smu_v13_0_x_init_caps(struct smu_context *smu)
@@ -716,7 +736,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 	MetricsTableA_t *metrics_a = (MetricsTableA_t *)smu_table->metrics_table;
 	struct PPTable_t *pptable =
 		(struct PPTable_t *)smu_table->driver_pptable;
-	bool flag = !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRICS));
+	bool flag = !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS));
 	int ret, i, retry = 100;
 	uint32_t table_version;
 
@@ -912,7 +932,7 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
 	smu_v13_0_6_setup_driver_pptable(smu);
 
 	/* DPM policy not supported in older firmwares */
-	if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(DPM_POLICY))) {
+	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(DPM_POLICY))) {
 		struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 
 		smu_dpm->dpm_policies->policy_mask &=
@@ -1089,7 +1109,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	struct smu_table_context *smu_table = &smu->smu_table;
 	MetricsTableX_t *metrics_x = (MetricsTableX_t *)smu_table->metrics_table;
 	MetricsTableA_t *metrics_a = (MetricsTableA_t *)smu_table->metrics_table;
-	bool flag = !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRICS));
+	bool flag = !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS));
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 	int xcc_id;
@@ -1102,7 +1122,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
 	case METRICS_AVERAGE_GFXCLK:
-		if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(DPM))) {
+		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(DPM))) {
 			xcc_id = GET_INST(GC, 0);
 			*value = SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency, flag)[xcc_id]);
 		} else {
@@ -1791,7 +1811,7 @@ static int smu_v13_0_6_notify_unload(struct smu_context *smu)
 static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool enable)
 {
 	/* NOTE: this ClearMcaOnRead message is only supported for smu version 85.72.0 or higher */
-	if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(MCA_DEBUG_MODE)))
+	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(MCA_DEBUG_MODE)))
 		return 0;
 
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,
@@ -1936,8 +1956,8 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
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
@@ -2141,7 +2161,7 @@ static int smu_v13_0_6_get_enabled_mask(struct smu_context *smu,
 
 	ret = smu_cmn_get_enabled_mask(smu, feature_mask);
 
-	if (ret == -EIO && !smu_v13_0_6_caps_supported(smu, SMU_CAPS(DPM))) {
+	if (ret == -EIO && !smu_v13_0_6_cap_supported(smu, SMU_CAP(DPM))) {
 		*feature_mask = 0;
 		ret = 0;
 	}
@@ -2437,7 +2457,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_7 *gpu_metrics =
 		(struct gpu_metrics_v1_7 *)smu_table->gpu_metrics_table;
-	bool flag = !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRICS));
+	bool flag = !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS));
 	int ret = 0, xcc_id, inst, i, j, k, idx;
 	struct amdgpu_device *adev = smu->adev;
 	MetricsTableX_t *metrics_x;
@@ -2519,7 +2539,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 		 * table for both pf & one vf for smu version 85.99.0 or higher else report only
 		 * for pf from registers
 		 */
-		if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(PCIE_METRICS))) {
+		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(PCIE_METRICS))) {
 			gpu_metrics->pcie_link_width = metrics_x->PCIeLinkWidth;
 			gpu_metrics->pcie_link_speed =
 				pcie_gen_to_speed(metrics_x->PCIeLinkSpeed);
@@ -2548,8 +2568,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 				metrics_x->PCIeNAKSentCountAcc;
 		gpu_metrics->pcie_nak_rcvd_count_acc =
 				metrics_x->PCIeNAKReceivedCountAcc;
-		if (smu_v13_0_6_caps_supported(smu,
-					       SMU_CAPS(OTHER_END_METRICS)))
+		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(OTHER_END_METRICS)))
 			gpu_metrics->pcie_lc_perf_other_end_recovery =
 				metrics_x->PCIeOtherEndRecoveryAcc;
 
@@ -2574,7 +2593,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	gpu_metrics->num_partition = adev->xcp_mgr->num_xcps;
 
-	per_inst = smu_v13_0_6_caps_supported(smu, SMU_CAPS(PER_INST_METRICS));
+	per_inst = smu_v13_0_6_cap_supported(smu, SMU_CAP(PER_INST_METRICS));
 
 	for_each_xcp(adev->xcp_mgr, xcp, i) {
 		amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
@@ -2605,8 +2624,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 				gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
 					SMUQ10_ROUND(metrics_x->GfxBusyAcc[inst]);
 
-				if (smu_v13_0_6_caps_supported(
-					    smu, SMU_CAPS(HST_LIMIT_METRICS)))
+				if (smu_v13_0_6_cap_supported(
+					    smu, SMU_CAP(HST_LIMIT_METRICS)))
 					gpu_metrics->xcp_stats[i].gfx_below_host_limit_acc[idx] =
 						SMUQ10_ROUND(metrics_x->GfxclkBelowHostLimitAcc
 								[inst]);
@@ -2714,7 +2733,7 @@ static int smu_v13_0_6_get_thermal_temperature_range(struct smu_context *smu,
 		return -EINVAL;
 
 	/*Check smu version, GetCtfLimit message only supported for smu version 85.69 or higher */
-	if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(CTF_LIMIT)))
+	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(CTF_LIMIT)))
 		return 0;
 
 	/* Get SOC Max operating temperature */
@@ -2819,7 +2838,7 @@ static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
 	int ret;
 
 	/* NOTE: the message is only valid on dGPU with pmfw 85.90.0 and above */
-	if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(RMA_MSG)))
+	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(RMA_MSG)))
 		return 0;
 
 	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_RmaDueToBadPageThreshold, NULL);
@@ -2840,16 +2859,16 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
 	case IP_VERSION(13, 0, 6):
 		if ((smu_program == 7 || smu_program == 0) &&
-		    smu_v13_0_6_caps_supported(smu, SMU_CAPS(SDMA_RESET)))
+		    smu_v13_0_6_cap_supported(smu, SMU_CAP(SDMA_RESET)))
 			ret = smu_cmn_send_smc_msg_with_param(smu,
 				SMU_MSG_ResetSDMA, inst_mask, NULL);
 		else if ((smu_program == 4) &&
-			 smu_v13_0_6_caps_supported(smu, SMU_CAPS(SDMA_RESET)))
+			 smu_v13_0_6_cap_supported(smu, SMU_CAP(SDMA_RESET)))
 			ret = smu_cmn_send_smc_msg_with_param(smu,
 				      SMU_MSG_ResetSDMA2, inst_mask, NULL);
 		break;
 	case IP_VERSION(13, 0, 14):
-		if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(SDMA_RESET)))
+		if (smu_v13_0_6_cap_supported(smu, SMU_CAP(SDMA_RESET)))
 			ret = smu_cmn_send_smc_msg_with_param(smu,
 				      SMU_MSG_ResetSDMA2, inst_mask, NULL);
 		break;
@@ -3175,7 +3194,7 @@ static bool mca_smu_bank_is_valid(const struct mca_ras_info *mca_ras, struct amd
 	if (instlo != 0x03b30400)
 		return false;
 
-	if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(ACA_SYND))) {
+	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(ACA_SYND))) {
 		errcode = MCA_REG__SYND__ERRORINFORMATION(entry->regs[MCA_REG_IDX_SYND]);
 		errcode &= 0xff;
 	} else {
@@ -3464,7 +3483,7 @@ static int aca_smu_parse_error_code(struct amdgpu_device *adev, struct aca_bank
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int error_code;
 
-	if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(ACA_SYND)))
+	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(ACA_SYND)))
 		error_code = ACA_REG__SYND__ERRORINFORMATION(bank->regs[ACA_REG_IDX_SYND]);
 	else
 		error_code = ACA_REG__STATUS__ERRORCODE(bank->regs[ACA_REG_IDX_STATUS]);
-- 
2.25.1

