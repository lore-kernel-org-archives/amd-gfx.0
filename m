Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEBCC02183
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 15:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 893B810E2AA;
	Fri, 17 Jan 2025 15:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IbAvNOFP";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D4510EB18
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 15:14:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D83YmAKMc/eTw68JORao7zlsParz8dELX+79Rz6cNpzt+l0YZLqL0Twv6w3kIamWZRcCXoG36ZY9CsdAKXswojo1fEWothbsTCViot3S7iQvx97DcFHoeQBVfkuAirm61g3CsAlY8uw+o0LrsxZxm1lQpBoxCo7mCJ2gZBC5zMo3KLi4PgmqVQmiDdfZEaTUXTCTGBBEsPFlr8tS8SygBjElIdGqAB9YTW5mNe33WNLam6W1rj3rYaTqD7nptfMVCTticWoXzaLP1EXzlhmITF7Gqu1NxiUGrBCR1HoMlYidRABjf2KMs/qfHlPjcL/m/kcPo2dyTatYafaL5hfG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvWgW3ijyNATuShJUxagFxQrzAhSaSQUsrbSVFRjQUA=;
 b=XbWxwGPvlKyYh2IF6i4CFTy1eGj0LFDL5ujG46Psw9zr6Tk8A4t8X7wm2FPe5DpFGUfcshurEUj6Z61IKkgYZlpkcI4Ar0xjpeDAG3hmv5WUJ/zTATGij8O2Wwjn6YGAoDm3yG26pDfoOjF6cO1jm7mOSuSc9CtdRRHoaepVJSu1E3fcBg9HXBpvcaK5eXEwn8Nk9jYGIuCPuHli1rhwxgi8PHTXkSG+2N6fHN6jgzFuALRPzxsB6gIaXLTf+nsBaeMXZFfuBWEcmeX6OA4lboGvU4u27D+FoxtfrSc13VQe9PEoMWccc0NCO1K5uPQPAVnWdfahrfEr89D0vlLk/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvWgW3ijyNATuShJUxagFxQrzAhSaSQUsrbSVFRjQUA=;
 b=IbAvNOFPPdYDUFwReIAvdofD/Qpf77yMh3rwuV16WmeaqhCMn4jGvLy9J2FKsoI8NsfFn2mFrpBd4JDqkSFNZ+1I0mrRCv7bVe5RrOrtJCFdZw9lvZLs5awFcJGeF2eav1YD8hP9CBd1RYOusqty1J/NEt5kvZbJJNWv8GaXkPI=
Received: from CH0P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::30)
 by SJ2PR12MB8928.namprd12.prod.outlook.com (2603:10b6:a03:53e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 15:14:15 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::9d) by CH0P220CA0018.outlook.office365.com
 (2603:10b6:610:ef::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Fri,
 17 Jan 2025 15:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 15:14:15 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 09:14:13 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Use correct macros for smu caps
Date: Fri, 17 Jan 2025 20:43:57 +0530
Message-ID: <20250117151357.1480352-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|SJ2PR12MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bbdfca5-b188-4bcc-f401-08dd37099b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XVe5ywQKG85imyMgmzh4OU0v6BNk/FOTnm8FthoGNnL97pASHHyUJNuzM/8G?=
 =?us-ascii?Q?ldeSs0IgVc/REz6uN6C3ICnpldNHZdRLGjC0Aauybppvx730l32VQ42hVpRU?=
 =?us-ascii?Q?P50NvlIyPPoikBczluZHnwM+Ml0valgmYhUFAQAWlYjEvYEXaY0MlM2n6c4d?=
 =?us-ascii?Q?svnQDaEP60jembE4UcXyu3EPd2EzMdqQHMdi44adQBILj1SeKF8mB6QfXJo1?=
 =?us-ascii?Q?GDubKimu/2L7+GH+wsH52FDKAYly1r7y9q35iokuIFmGLzDFQzfUqspqWU/d?=
 =?us-ascii?Q?uG4WAX53dfZ4c62ytSAIlVxUP3FhX8qRsVUapCr1aRwhBB0MDQ/7GPS6n0i3?=
 =?us-ascii?Q?2kpoRNzMARplwj64Sfn8d+4WnntTdD2iOz0hLM4a5JttS/n/kJsiFwuGID6o?=
 =?us-ascii?Q?088NLwPF4oVD4Qiqqh3vwvgrtZR25itCBC+fGm/Qc+SQiMQhFaVnkHzB20GC?=
 =?us-ascii?Q?sVvm8K+Dq5KJXGCPNFrPL133w7UZ7U+VQ0VbyWi4wprVb0fsAEFSZWUJ+Cgf?=
 =?us-ascii?Q?znyVzP5c7jL5NPrS4jKURKR+4bK6JnW8fH3/zL+CR5vkY+EocURToJZh4/9J?=
 =?us-ascii?Q?/x4SiTvOxisRXFOPCDGizyRsnXDXM8dj2iuoTFICkuatPtZ70YqjYvRVfaMe?=
 =?us-ascii?Q?Po06gN7tXyDk2Dgh8J4S2N34nE0llKfgTuXGxZujJi/M2mdluNyDIShGU2Uy?=
 =?us-ascii?Q?oHow2oUva/vQJSnU8JMM9WsQ6E7ZtCq7tFrsNfonQRABooyhmS8wN0p1CqAw?=
 =?us-ascii?Q?OJl41kXJ6LvlmDGi/9/RnAzE61GkObdjFwkwif2a0LW59UE9fUh/vTLC4j4y?=
 =?us-ascii?Q?xv5z1z99ctK252sx9bLjN/kbu8JH0rKwdQV7B+AhiMitPdKLwNVtRc5ICyPr?=
 =?us-ascii?Q?XRTEC13HRPeUxplqpiye2PchoRSJ0Sw++0VxkMViD1j+lt/esYhthiST/+DN?=
 =?us-ascii?Q?0s7M3hfpoAEFUHz9Iz88IaZndS2b2VoQKBFCr1gMt0Sebm9hnSt08KeTYgeO?=
 =?us-ascii?Q?Tlo08yf7Q57TpWXCEQ4QNO1lyJRWUfFVTSqqEG3i20JTZ5tgCxDWyrseof5i?=
 =?us-ascii?Q?++86sDqaDyZfaULW37CeovZTh2WwXIhduJmRpsSUych3znA9HAKpA4Nief4F?=
 =?us-ascii?Q?gYY3SZT1meTCN6p2FjSgJeZno3rUuM83ORAZ7aLbKJ9ZI0Rj4jGhQBDFPhYQ?=
 =?us-ascii?Q?ecXjqe7fubeEeZAb90jlck8Tq1C/Z3QMW/bWDFkrorgs4dYNtxpKiebdKH26?=
 =?us-ascii?Q?X1DTsAhlcnzax42z7t3ObiKLKabafzLw9+ziAjgFwYOxF2CCUIqCy+69Mn7I?=
 =?us-ascii?Q?WkN8CNuiuxm4TLHNhURmrpJy4ktt5wEGZFX3Nk7hy4KuntCzpM18HDG68kLS?=
 =?us-ascii?Q?LQCzssIR2j2Qt8hqcNPvcIvCrm538fyNBFegyWotD4l9tqnl26VSOwoMCYCs?=
 =?us-ascii?Q?l/eJ4GwawTfWM9dr3AQ4J46hXjRCzyGdMido810GlR4qfhZGP9WMyjsb2Ozu?=
 =?us-ascii?Q?3Gs/7hXFa2D7Aq8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 15:14:15.5810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbdfca5-b188-4bcc-f401-08dd37099b54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8928
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

Fix the initialization and usage of capability values and mask.
SMU_CAPS_MASK indicates mask value, and SMU_CAPS represent the
capability value.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Fixes: 9bb53d2ce109 ("drm/amd/pm: Add capability flags for SMU v13.0.6")
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 80 ++++++++++---------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 56e26fcd3066..52fd8355eee1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -118,8 +118,9 @@ enum smu_v13_0_6_caps {
 	SMU_13_0_6_CAPS_ALL,
 };
 
-#define SMU_CAPS_MASK(x) (ULL(1) << x)
-#define SMU_CAPS(x) SMU_CAPS_MASK(SMU_13_0_6_CAPS_##x)
+#define SMU_CAPS_TO_MASK(x) (ULL(1) << x)
+#define SMU_CAPS(x) SMU_13_0_6_CAPS_##x
+#define SMU_CAPS_MASK(x) SMU_CAPS_TO_MASK(SMU_CAPS(x))
 
 struct mca_bank_ipid {
 	enum amdgpu_mca_ip ip;
@@ -287,82 +288,84 @@ struct smu_v13_0_6_dpm_map {
 static void smu_v13_0_14_init_caps(struct smu_context *smu)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	uint64_t caps = SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
-			SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
-			SMU_CAPS(PCIE_METRICS) | SMU_CAPS(CTF_LIMIT) |
-			SMU_CAPS(MCA_DEBUG_MODE) | SMU_CAPS(RMA_MSG) |
-			SMU_CAPS(ACA_SYND);
+	uint64_t caps = SMU_CAPS_MASK(DPM) | SMU_CAPS_MASK(UNI_METRICS) |
+			SMU_CAPS_MASK(SET_UCLK_MAX) |
+			SMU_CAPS_MASK(DPM_POLICY) |
+			SMU_CAPS_MASK(PCIE_METRICS) | SMU_CAPS_MASK(CTF_LIMIT) |
+			SMU_CAPS_MASK(MCA_DEBUG_MODE) | SMU_CAPS_MASK(RMA_MSG) |
+			SMU_CAPS_MASK(ACA_SYND);
 	uint32_t fw_ver = smu->smc_fw_version;
 
 	if (fw_ver >= 0x05550E00)
-		caps |= SMU_CAPS(OTHER_END_METRICS);
+		caps |= SMU_CAPS_MASK(OTHER_END_METRICS);
 	if (fw_ver >= 0x05551000)
-		caps |= SMU_CAPS(HST_LIMIT_METRICS);
+		caps |= SMU_CAPS_MASK(HST_LIMIT_METRICS);
 	if (fw_ver >= 0x05550B00)
-		caps |= SMU_CAPS(PER_INST_METRICS);
+		caps |= SMU_CAPS_MASK(PER_INST_METRICS);
 	if (fw_ver > 0x05550f00)
-		caps |= SMU_CAPS(SDMA_RESET);
+		caps |= SMU_CAPS_MASK(SDMA_RESET);
 
 	dpm_context->caps = caps;
 }
 
 static void smu_v13_0_6_init_caps(struct smu_context *smu)
 {
-	uint64_t caps = SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
-			SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
-			SMU_CAPS(PCIE_METRICS) | SMU_CAPS(MCA_DEBUG_MODE) |
-			SMU_CAPS(CTF_LIMIT) | SMU_CAPS(RMA_MSG) |
-			SMU_CAPS(ACA_SYND);
+	uint64_t caps =
+		SMU_CAPS_MASK(DPM) | SMU_CAPS_MASK(UNI_METRICS) |
+		SMU_CAPS_MASK(SET_UCLK_MAX) | SMU_CAPS_MASK(DPM_POLICY) |
+		SMU_CAPS_MASK(PCIE_METRICS) | SMU_CAPS_MASK(MCA_DEBUG_MODE) |
+		SMU_CAPS_MASK(CTF_LIMIT) | SMU_CAPS_MASK(RMA_MSG) |
+		SMU_CAPS_MASK(ACA_SYND);
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t fw_ver = smu->smc_fw_version;
 	uint32_t pgm = (fw_ver >> 24) & 0xFF;
 
 	if (fw_ver < 0x552F00)
-		caps &= ~SMU_CAPS(DPM);
+		caps &= ~SMU_CAPS_MASK(DPM);
 
 	if (adev->flags & AMD_IS_APU) {
-		caps &= ~SMU_CAPS(PCIE_METRICS);
-		caps &= ~SMU_CAPS(SET_UCLK_MAX);
-		caps &= ~SMU_CAPS(DPM_POLICY);
-		caps &= ~SMU_CAPS(RMA_MSG);
-		caps &= ~SMU_CAPS(ACA_SYND);
+		caps &= ~SMU_CAPS_MASK(PCIE_METRICS);
+		caps &= ~SMU_CAPS_MASK(SET_UCLK_MAX);
+		caps &= ~SMU_CAPS_MASK(DPM_POLICY);
+		caps &= ~SMU_CAPS_MASK(RMA_MSG);
+		caps &= ~SMU_CAPS_MASK(ACA_SYND);
 
 		if (fw_ver <= 0x4556900)
-			caps &= ~SMU_CAPS(UNI_METRICS);
+			caps &= ~SMU_CAPS_MASK(UNI_METRICS);
 
 		if (fw_ver >= 0x04556F00)
-			caps |= SMU_CAPS(HST_LIMIT_METRICS);
+			caps |= SMU_CAPS_MASK(HST_LIMIT_METRICS);
 		if (fw_ver >= 0x04556A00)
-			caps |= SMU_CAPS(PER_INST_METRICS);
+			caps |= SMU_CAPS_MASK(PER_INST_METRICS);
 		if (fw_ver < 0x554500)
-			caps &= ~SMU_CAPS(CTF_LIMIT);
+			caps &= ~SMU_CAPS_MASK(CTF_LIMIT);
 	} else {
 		if (fw_ver >= 0x557600)
-			caps |= SMU_CAPS(OTHER_END_METRICS);
+			caps |= SMU_CAPS_MASK(OTHER_END_METRICS);
 		if (fw_ver < 0x00556000)
-			caps &= ~SMU_CAPS(DPM_POLICY);
+			caps &= ~SMU_CAPS_MASK(DPM_POLICY);
 		if (amdgpu_sriov_vf(adev) && (fw_ver < 0x556600))
-			caps &= ~SMU_CAPS(SET_UCLK_MAX);
+			caps &= ~SMU_CAPS_MASK(SET_UCLK_MAX);
 		if (fw_ver < 0x556300)
-			caps &= ~SMU_CAPS(PCIE_METRICS);
+			caps &= ~SMU_CAPS_MASK(PCIE_METRICS);
 		if (fw_ver < 0x554800)
-			caps &= ~SMU_CAPS(MCA_DEBUG_MODE);
+			caps &= ~SMU_CAPS_MASK(MCA_DEBUG_MODE);
 		if (fw_ver >= 0x556F00)
-			caps |= SMU_CAPS(PER_INST_METRICS);
+			caps |= SMU_CAPS_MASK(PER_INST_METRICS);
 		if (fw_ver < 0x554500)
-			caps &= ~SMU_CAPS(CTF_LIMIT);
+			caps &= ~SMU_CAPS_MASK(CTF_LIMIT);
 		if (fw_ver < 0x00555a00)
-			caps &= ~SMU_CAPS(RMA_MSG);
+			caps &= ~SMU_CAPS_MASK(RMA_MSG);
 		if (fw_ver < 0x00555600)
-			caps &= ~SMU_CAPS(ACA_SYND);
+			caps &= ~SMU_CAPS_MASK(ACA_SYND);
 		if (pgm == 0 && fw_ver >= 0x557900)
-			caps |= SMU_CAPS(HST_LIMIT_METRICS);
+			caps |= SMU_CAPS_MASK(HST_LIMIT_METRICS);
 	}
 	if (((pgm == 7) && (fw_ver > 0x07550700)) ||
 	    ((pgm == 0) && (fw_ver > 0x00557700)) ||
 	    ((pgm == 4) && (fw_ver > 0x4556e6c)))
-		caps |= SMU_CAPS(SDMA_RESET);
+		caps |= SMU_CAPS_MASK(SDMA_RESET);
 
 	dpm_context->caps = caps;
 }
@@ -372,7 +375,8 @@ static inline bool smu_v13_0_6_caps_supported(struct smu_context *smu,
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 
-	return (dpm_context->caps & SMU_CAPS_MASK(caps)) == SMU_CAPS_MASK(caps);
+	return (dpm_context->caps & SMU_CAPS_TO_MASK(caps)) ==
+	       SMU_CAPS_TO_MASK(caps);
 }
 
 static void smu_v13_0_x_init_caps(struct smu_context *smu)
-- 
2.25.1

