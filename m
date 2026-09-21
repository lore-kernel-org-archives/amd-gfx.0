Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5625DC982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB37110E63D;
	Mon, 21 Sep 2026 20:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="04iW7hOE";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013048.outbound.protection.outlook.com
 [40.93.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC8910EA8D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:10:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYNC36OAzPRNCeNxjUOhxfkhwXX2NynvP3gwvkzDl+8yydrBeamB6eEU5+PuDiBMapD5/k4BFhvt5ZdZPtP0z+BXKsuNZ71L2q9IiF9yENxQpeiZmhoyoE8qV7faCRd2NpiSxr/se6+r1Cq0V85a1Rc8hJN5OJM5EcYqUMeIMjsr5kjN/2R7rv7T+FmT5nljWj8KRkfPhfwSd3wEvFnmEa1ql10FFT3ywJgU3hH4pwERJ1cTbFahVXDlo2y2Cbabfc5yMpvUlocZPq+Wfex+Hd3L86uFu52QKR+dYeE3IyqtCycPhgqDzZHmFRvJn2AcjO2exOWdA8wXRMpOiSkKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qe6DNHDzq9yVmT1OoA7GcnnrRBbv2aE6o0TwQUfkd+c=;
 b=cUXQDXqBDfJfsUG0K4GeuO2GpHvqj+VPzdQJMddTsgzakADerzd5OqqxGT/l33dx6mq4KVHP6+msRpX/wI8fFKc13TDH32SBMD2BwD5powfvH6dpBvUh08GJ9TV/B2CcpV+gJswANuDSZfmCxXG20bP2x9SmGIMQanHs3xJy4/CSN4u+bU8S5c0RLGdld28QaZSQg5mg2A5IXXoBcVXoDLCubEP4UkjubKuncccB/yhilYTGKZvNiGEAHTETkVAjdSa5Yq3avI37bH0tsBZBlHAmB1B2UeQNiNlkSbUZ1R0SDTuJxH17RafegeQlJltCIECOqYOj/7Zhzm7ds5zgGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qe6DNHDzq9yVmT1OoA7GcnnrRBbv2aE6o0TwQUfkd+c=;
 b=04iW7hOExv9xQp7MbtkyiEPNLOGxAyR6ArdMxBwlbo3qhevvroCfqan5vj/e8IoZ5udX1RMb8OE2qLlSiQUhj5JtP22QflLKlg4SLJk1t5kvXdcDxydIHBKNzBJKmH7N5tINVD6UnA3dB/7tUA7Sin+zuz2Jt2/bww6DW2hcb3Y=
Received: from SA9P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::11)
 by DS4PR12MB9561.namprd12.prod.outlook.com (2603:10b6:8:282::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:10:46 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::61) by SA9P223CA0006.outlook.office365.com
 (2603:10b6:806:26::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 20:10:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:10:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:10:40 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 15:10:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Frank Min <Frank.Min@amd.com>, Likun Gao <Likun.Gao@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: update FIRMWARE ID for soc24
Date: Mon, 21 Sep 2026 16:10:22 -0400
Message-ID: <20260921201026.2019083-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921201026.2019083-1-alexander.deucher@amd.com>
References: <20260921201026.2019083-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|DS4PR12MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: fba11f8c-a313-42f8-45eb-08df181c6bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kjiya8riXUL/QcPcr6fC8Z4155lXGaWW8snEDyY6wIHzu6b84cNjdfD29CGVNd6QsaBo3o8JrL1qEcmAZwwsahF1lqlHIIEmvz6S8mWChc2fyUgDpuH3iO5iLGXtGxTsZhKkbqb/AeJLXhmkDq0LpicatZac+wwgQeU+Nfhi232syoB3TmwSfDI+cusUFR8hnjh534G3+3OPSNVfpq2JDkdj2hcodPPQAFNukNehX/SCwd7DyzALRZntXuM/d29QZxxYQ0zIaRc/JZxAKiqsa1pIJHDGswTqSM1TQiT8z/A+t6omBD9dlYiArJtc3A1AjY/n49JFjdAjnOmA/1tbIRau2Xar3ofL2xdiLY53uoyZyyzzLZ5GNck4FKBgjGEECzzCMEMCJmlRUJrmCZiipN6leGpnkcn5GqyeFAz4wou7sVraFcC2ZkFSVG0kWQwoEnNMX4VvZdSPtRp5WYaRxAW3mixh+QPmD4Z4JxhnzQuMOZckC/5geTxuM/XzKL4KHeRsOuEgJtSE0N1MgWeAYMjjpkIp2ZwxtSWSipwl+nnRtOje7cIaePyaLS02RG8Rv/NLR7Bn+Z9JOlb3aw/WtuJlN2bOgC+gjnalQ7iSRkNbrGtx4SxVcICCPiiesMzF2qTX71hQfpmNMjkkFfwqWkNFpxe91XLQgG+Pp3K4oeMiyWd36wXthfrjipYmIFX++PXTeV+aujGP/e+1O6KNtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NrHaaUHCd6sYTjiGOaVchc2HDZkL4kdf50GGEuwSWYJHtc68ROpSzB3SqqdxbRKI0isFKFqXEjN6lJXLcFEw0wkvH/RAVyPw6Cz1zV7FHO6anaLFzDTAjzu3CpRO9kqnaJYNeFI3SIDwfDJjLfV1NXfj1OSxRTgf443rrtR4uS3jblbXdVFrVRwIUKpsSB1ec4T0A6n7acjM/BrUw/ktY5eMNAZZpuh9dOiHBmRyq/5K0jYS+/odRUwndUwiZqWzXzvajGwzGuwDS0aBUvOw/tQt+27Ebdd5GMZswOC264/W5/4fszyxs82pH92t56b3V2HkrLGIXbKvw2U0brdJBJmxj+DCEa6MTo7cwjsJPjaxEEItf07q2VamRTICdtCkXEOpM6UYBbdYv9uRaM80ascc4mCxk3Er5fCZFlhxbGSTNTfkpmxo2FgyxJw2yosx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:10:45.5544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fba11f8c-a313-42f8-45eb-08df181c6bc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9561
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

From: Frank Min <Frank.Min@amd.com>

Update firmware ID for SOC24 to support more firmware.

Signed-off-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h | 36 ++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 959d60c90dcd2..2ae2c1d0f702b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -156,7 +156,41 @@ typedef enum _SOC24_FIRMWARE_ID_ {
     SOC24_FIRMWARE_ID_SRIOV_CSA_SDMA              = 40,
     SOC24_FIRMWARE_ID_SRIOV_CSA_CP                = 41,
     SOC24_FIRMWARE_ID_UMF_ZONE_PAD                = 42,
-    SOC24_FIRMWARE_ID_MAX                         = 43
+    SOC24_FIRMWARE_ID_SE_F32_IRAM                 = 43,
+    SOC24_FIRMWARE_ID_SE_XT_IRAM                  = 44,
+    SOC24_FIRMWARE_ID_SE_XT_DRAM                  = 45,
+    SOC24_FIRMWARE_ID_RS64_MEC_P4_STACK           = 46,
+    SOC24_FIRMWARE_ID_RS64_MEC_P5_STACK           = 47,
+    SOC24_FIRMWARE_ID_RS64_MEC_P6_STACK           = 48,
+    SOC24_FIRMWARE_ID_RS64_MEC_P7_STACK           = 49,
+    SOC24_FIRMWARE_ID_CP_F32_PFP_G0_A             = 50,
+    SOC24_FIRMWARE_ID_CP_F32_PFP_G1_A             = 51,
+    SOC24_FIRMWARE_ID_CP_F32_PFP_G2               = 52,
+    SOC24_FIRMWARE_ID_CP_F32_ME_G0_A              = 53,
+    SOC24_FIRMWARE_ID_CP_F32_ME_G1_A              = 54,
+    SOC24_FIRMWARE_ID_CP_F32_ME_G2                = 55,
+    SOC24_FIRMWARE_ID_CP_F32_CE_G0_A              = 56,
+    SOC24_FIRMWARE_ID_CP_F32_CE_G1_A              = 57,
+    SOC24_FIRMWARE_ID_CP_F32_CE_G2                = 58,
+    SOC24_FIRMWARE_ID_CP_F32_MEC2_G0              = 59,
+    SOC24_FIRMWARE_ID_CP_F32_MEC2_G1              = 60,
+    SOC24_FIRMWARE_ID_CP_F32_MEC2_G2              = 61,
+    SOC24_FIRMWARE_ID_GFXOFF_CSA_SDMA0            = 62,
+    SOC24_FIRMWARE_ID_GFXOFF_CSA_SDMA1            = 63,
+    SOC24_FIRMWARE_ID_GFXOFF_CSA_SDMA2            = 64,
+    SOC24_FIRMWARE_ID_GFXOFF_CSA_SDMA3            = 65,
+    SOC24_FIRMWARE_ID_RLX6_SCRATCH_SR             = 66,
+    SOC24_FIRMWARE_ID_RLX6_SCRATCH_SR_CORE1       = 67,
+    SOC24_FIRMWARE_ID_CP_F32_PFP_G0_B             = 68,
+    SOC24_FIRMWARE_ID_CP_F32_PFP_G1_B             = 69,
+    SOC24_FIRMWARE_ID_CP_F32_ME_G0_B              = 70,
+    SOC24_FIRMWARE_ID_CP_F32_ME_G1_B              = 71,
+    SOC24_FIRMWARE_ID_CP_F32_CE_G0_B              = 72,
+    SOC24_FIRMWARE_ID_CP_F32_CE_G1_B              = 73,
+    SOC24_FIRMWARE_ID_CP_F32_MEC2_JT_G0           = 74,
+    SOC24_FIRMWARE_ID_CP_F32_MEC2_JT_G1           = 75,
+    SOC24_FIRMWARE_ID_CP_F32_MEC2_JT_G2           = 76,
+    SOC24_FIRMWARE_ID_MAX                         = 77
 } SOC24_FIRMWARE_ID;
 
 typedef struct _RLC_TABLE_OF_CONTENT {
-- 
2.55.0

