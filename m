Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8566ACA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 18:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 258CC10E9BA;
	Wed, 10 Sep 2025 18:41:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rTOZLl/F";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622E610E9BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 18:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f86tNiIXjfQGDJ1sk1M9y/0iQQricNrEPoLQWDA2OkhsUBSL74nIcS8gVkesQQn7x0gZCw8nXIitEuTgVV4LrfAngcpkBd+GIWQYGv/Wq+FUq4L26CwrXYFvHTQAC2FJGVi9joeEVSEGliqhvLxY6O6utbqJGHX9Qs3rIaYRrZWNPEQr6Qas/+8jSeAiTrAL9Kqplf5WptRGnmp/1Q89gmXpeoG48RAEMHtF7/NP66AMx7ziprA8u72ljrpNlI1PY+3/k6hdFj4AajDSzMUf0F35NN8oS4tTU/W+ligwcjEqg8+Crwx7QiKkDGgcqrUHwb9YZqzCgETASFA5ifoxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzc+4I10SuAutuYPKmDtMi6Z2SZKWjIPbaQUbAk3CxU=;
 b=eQ0HhCwb+Gr6CMel6JFCSpnbhT5B6UCISP3DtDy1tTG3+SBw1/0278UG5xXAqdvx/1z87siYIBoqy0bbzXI96q8HyRLvmgEoNQbzs5H8rN85o+bOGH4c6TPHRuQAbGq8EdTWBjI0WDwaJwxNDN8b57NFBSRR2ul5Gbp7NOCVSLEBUrOCR0BTLp6RiBVneENIpaqWUAOmYUorHyKQPCtAa3g4dfSiPhEISgS63wbXPs7AMIPvnO8Hdd9UO3nABRH6X/AtL3x6F1c4kNHiCGjKmHxOfh2cFySL3zXWKn7vYlQnF3cBPErm8AWt+66No7Vs8czTAauXYS+j0+hJrX/zcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzc+4I10SuAutuYPKmDtMi6Z2SZKWjIPbaQUbAk3CxU=;
 b=rTOZLl/FN13D7tvtbGvSwQ37NLYiq8EpVK3sxG9kCmnN9tEAZe9Nk3slXqrF3uvlY8fPwy28vGpqgQd8tKMPaT+xtwsykDuBxdPLNOPsob/H/9O0eECnPOrUmqMw/jK9VsEdZIBTGLine17Si65d8YH00M4uhLEVKGr9oemctwk=
Received: from SJ0PR13CA0164.namprd13.prod.outlook.com (2603:10b6:a03:2c7::19)
 by LV3PR12MB9266.namprd12.prod.outlook.com (2603:10b6:408:21b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 18:41:03 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::6) by SJ0PR13CA0164.outlook.office365.com
 (2603:10b6:a03:2c7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.6 via Frontend Transport; Wed,
 10 Sep 2025 18:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 18:41:02 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 11:40:59 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Duplicate DC_FEATURE_MASK and DC_DEBUG_MASK enum
 values into kdoc
Date: Wed, 10 Sep 2025 13:40:30 -0500
Message-ID: <20250910184030.3773845-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|LV3PR12MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8657e8-b204-40b9-aaf8-08ddf09997ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IT5qAA3T8FtVQ+3Va1A5BAm7FQ+RIcM/hHXe77owPwR1hnf/fDcK1o+rTagU?=
 =?us-ascii?Q?Kl51aYz29FsdnD4L9kgDUYgOM8CgmbIVeWM8EfopFDO2TpR+U7Gi3FQ35y7b?=
 =?us-ascii?Q?ohhEfyIR91eWV3Uoacza2Zo94GGWz6Zi2/zpHZalYC2GgOuziHIzfgyLL1Gm?=
 =?us-ascii?Q?7yzcswLGRajo/K8ZBxWGHzQz1cpWd9AfqXyADFPYDSHQxEQ2dYRka1CTeoC/?=
 =?us-ascii?Q?PZo0Fz8kylB1RF2OyCBe7NMAeFnk70m3Mrc6Qc4uONimnEt9GH6Yj1AnIoSI?=
 =?us-ascii?Q?T/Um5TI8ExbFvpQ2GAMgTknemZi/GUenBxgc7iRNskEctiY+c/C0LLf/GF3a?=
 =?us-ascii?Q?VHOziW+64TEJ5u20343u+5muL0TJp08/XsuRA1Aa/sZOWCHGyD/VlG3j3NqX?=
 =?us-ascii?Q?To7ThEhA8AvKdwasxiWMAed1FQHe7HfMRKvsKUAlu+b+RmP7i5jwMhegVQnG?=
 =?us-ascii?Q?mvqzc3yOm6fmNlwfiaDCkfO3aBUezfnKOEMChSuXrErFPR6/QA2hL0CeNpRG?=
 =?us-ascii?Q?ta560RcjlzUTdMYPj2IgyEz74UFDn2iS7vGVVF2hUW2rQULNaHfXjQ1N79K8?=
 =?us-ascii?Q?dAI5tGN8cZKewn5W8SmKXkHZcsPb1TkKRgEkWu/2xwRBDJgfk4qXZa9G4ZjL?=
 =?us-ascii?Q?AdI5Ra3tZX2vdY5uatNOe993pUT2qXEljaFIABW9jg0+jLMojEI4QUsZnfdb?=
 =?us-ascii?Q?COel9uUYTSN3x8tzwaC4S24dCBOeUjVHIxYU5DCX70SMAs+nLU9ldok7M70q?=
 =?us-ascii?Q?Hx4zvs0EEqr4UfddWnheFGSiPPYAyvqBGgD4QF+4WOKq7kF9iEZ9fdqd8Np8?=
 =?us-ascii?Q?3H2CoOVKcN/HN4zLS1kVSyLqPC0ULZkZOjHmDNnhBT8VfNunsgkVOYG5umiU?=
 =?us-ascii?Q?el04HBLlkcCbxFLj8MJXjEXhcK/JL9zhiQoKxNAMcySUZzlNO1ntyWb72eH7?=
 =?us-ascii?Q?jB+C+murJS1dkUGh/YOmviRLQFmI18lolOeu9E/qTfR6tIQehVowhk7kRWwM?=
 =?us-ascii?Q?WWygFag21az3C/4jL1fgNos8F63bgZ9fTbFl1TIINICuDU85cAQClAdsyvKh?=
 =?us-ascii?Q?BqV+CSg/Wlml3y4fQQjp2d0FJmRTrgr/L/S4pwhiWCzla1laIOLiC89A+p79?=
 =?us-ascii?Q?gFgpojNa/4XsJqVJJGFc4HxJjukRWF/9+TV//EzIJvlumlMePKaMCKFou/c4?=
 =?us-ascii?Q?8L5BpsL7uuQMZyeMea11IAsPZZdMFCRVwRytVLR/hbATd5AiwOnY6DxCSEwF?=
 =?us-ascii?Q?JWUyXoiRTVg4Y6EFyNyR4lssaQIeGy9c2URHvaEzdOSLvhzRF54ApmASm2Ql?=
 =?us-ascii?Q?Ab36nyHM43L5cWiu04JCtw2IhevFvNgtDBR0hHha/z64Lg9z7TJnoHieML+A?=
 =?us-ascii?Q?/HZIdrmWQRM9wVzLkxKjUKhJRThZPSG5QPI/KCWZl/k7eCwXnQknc551mL/w?=
 =?us-ascii?Q?GynNNDiT7FA7aDB1mExsjcE4jV5HusSSsAxD+YmY9T2Qj6K6dY1oiggdaLTl?=
 =?us-ascii?Q?X+mhVfIh2V6li1YiC3IcBG2nBP8ig31bUOj4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 18:41:02.0623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8657e8-b204-40b9-aaf8-08ddf09997ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9266
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

[Why]
When kernel documentation is generated the enum values themselves don't
end up in the documentation.  This makes browsing them in HTML a lot
less useful.

[How]
Copy DC_DEBUG_MASK and DC_FEATURE_MASK enum values into matching kdoc
comments.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/driver-core.rst |  2 +-
 drivers/gpu/drm/amd/include/amd_shared.h | 98 ++++++++++++++++--------
 2 files changed, 67 insertions(+), 33 deletions(-)

diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu/amdgpu/driver-core.rst
index bd4be32f2725..3ce276272171 100644
--- a/Documentation/gpu/amdgpu/driver-core.rst
+++ b/Documentation/gpu/amdgpu/driver-core.rst
@@ -210,4 +210,4 @@ IP Blocks
    :doc: IP Blocks
 
 .. kernel-doc:: drivers/gpu/drm/amd/include/amd_shared.h
-   :identifiers: amd_ip_block_type amd_ip_funcs DC_DEBUG_MASK
+   :identifiers: amd_ip_block_type amd_ip_funcs DC_FEATURE_MASK DC_DEBUG_MASK
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index bfb446736ca8..75efda2969cf 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -239,18 +239,51 @@ enum amd_harvest_ip_mask {
     AMD_HARVEST_IP_DMU_MASK = 0x4,
 };
 
+/**
+ * enum DC_FEATURE_MASK - Bits that control DC feature defaults
+ */
 enum DC_FEATURE_MASK {
 	//Default value can be found at "uint amdgpu_dc_feature_mask"
-	DC_FBC_MASK = (1 << 0), //0x1, disabled by default
-	DC_MULTI_MON_PP_MCLK_SWITCH_MASK = (1 << 1), //0x2, enabled by default
-	DC_DISABLE_FRACTIONAL_PWM_MASK = (1 << 2), //0x4, disabled by default
-	DC_PSR_MASK = (1 << 3), //0x8, disabled by default for dcn < 3.1
-	DC_EDP_NO_POWER_SEQUENCING = (1 << 4), //0x10, disabled by default
-	DC_DISABLE_LTTPR_DP1_4A = (1 << 5), //0x20, disabled by default
-	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
-	DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
-	DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by default
-	DC_REPLAY_MASK = (1 << 9), //0x200, disabled by default for dcn < 3.1.4
+	/**
+	 * @DC_FBC_MASK: (0x1) disabled by default
+	 */
+	DC_FBC_MASK = (1 << 0),
+	/**
+	 * @DC_MULTI_MON_PP_MCLK_SWITCH_MASK: (0x2) enabled by default
+	 */
+	DC_MULTI_MON_PP_MCLK_SWITCH_MASK = (1 << 1),
+	/**
+	 * @DC_DISABLE_FRACTIONAL_PWM_MASK: (0x4) disabled by default
+	 */
+	DC_DISABLE_FRACTIONAL_PWM_MASK = (1 << 2),
+	/**
+	 * @DC_PSR_MASK: (0x8) disabled by default for DCN < 3.1
+	 */
+	DC_PSR_MASK = (1 << 3),
+	/**
+	 * @DC_EDP_NO_POWER_SEQUENCING: (0x10) disabled by default
+	 */
+	DC_EDP_NO_POWER_SEQUENCING = (1 << 4),
+	/**
+	 * @DC_DISABLE_LTTPR_DP1_4A: (0x20) disabled by default
+	 */
+	DC_DISABLE_LTTPR_DP1_4A = (1 << 5),
+	/**
+	 * @DC_DISABLE_LTTPR_DP2_0: (0x40) disabled by default
+	 */
+	DC_DISABLE_LTTPR_DP2_0 = (1 << 6),
+	/**
+	 * @DC_PSR_ALLOW_SMU_OPT: (0x80) disabled by default
+	 */
+	DC_PSR_ALLOW_SMU_OPT = (1 << 7),
+	/**
+	 * @DC_PSR_ALLOW_MULTI_DISP_OPT: (0x100) disabled by default
+	 */
+	DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8),
+	/**
+	 * @DC_REPLAY_MASK: (0x200) disabled by default for DCN < 3.1.4
+	 */
+	DC_REPLAY_MASK = (1 << 9),
 };
 
 /**
@@ -258,64 +291,64 @@ enum DC_FEATURE_MASK {
  */
 enum DC_DEBUG_MASK {
 	/**
-	 * @DC_DISABLE_PIPE_SPLIT: If set, disable pipe-splitting
+	 * @DC_DISABLE_PIPE_SPLIT: (0x1) If set, disable pipe-splitting
 	 */
 	DC_DISABLE_PIPE_SPLIT = 0x1,
 
 	/**
-	 * @DC_DISABLE_STUTTER: If set, disable memory stutter mode
+	 * @DC_DISABLE_STUTTER: (0x2) If set, disable memory stutter mode
 	 */
 	DC_DISABLE_STUTTER = 0x2,
 
 	/**
-	 * @DC_DISABLE_DSC: If set, disable display stream compression
+	 * @DC_DISABLE_DSC: (0x4) If set, disable display stream compression
 	 */
 	DC_DISABLE_DSC = 0x4,
 
 	/**
-	 * @DC_DISABLE_CLOCK_GATING: If set, disable clock gating optimizations
+	 * @DC_DISABLE_CLOCK_GATING: (0x8) If set, disable clock gating optimizations
 	 */
 	DC_DISABLE_CLOCK_GATING = 0x8,
 
 	/**
-	 * @DC_DISABLE_PSR: If set, disable Panel self refresh v1 and PSR-SU
+	 * @DC_DISABLE_PSR: (0x10) If set, disable Panel self refresh v1 and PSR-SU
 	 */
 	DC_DISABLE_PSR = 0x10,
 
 	/**
-	 * @DC_FORCE_SUBVP_MCLK_SWITCH: If set, force mclk switch in subvp, even
+	 * @DC_FORCE_SUBVP_MCLK_SWITCH: (0x20) If set, force mclk switch in subvp, even
 	 * if mclk switch in vblank is possible
 	 */
 	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
 
 	/**
-	 * @DC_DISABLE_MPO: If set, disable multi-plane offloading
+	 * @DC_DISABLE_MPO: (0x40) If set, disable multi-plane offloading
 	 */
 	DC_DISABLE_MPO = 0x40,
 
 	/**
-	 * @DC_ENABLE_DPIA_TRACE: If set, enable trace logging for DPIA
+	 * @DC_ENABLE_DPIA_TRACE: (0x80) If set, enable trace logging for DPIA
 	 */
 	DC_ENABLE_DPIA_TRACE = 0x80,
 
 	/**
-	 * @DC_ENABLE_DML2: If set, force usage of DML2, even if the DCN version
+	 * @DC_ENABLE_DML2: (0x100) If set, force usage of DML2, even if the DCN version
 	 * does not default to it.
 	 */
 	DC_ENABLE_DML2 = 0x100,
 
 	/**
-	 * @DC_DISABLE_PSR_SU: If set, disable PSR SU
+	 * @DC_DISABLE_PSR_SU: (0x200) If set, disable PSR SU
 	 */
 	DC_DISABLE_PSR_SU = 0x200,
 
 	/**
-	 * @DC_DISABLE_REPLAY: If set, disable Panel Replay
+	 * @DC_DISABLE_REPLAY: (0x400) If set, disable Panel Replay
 	 */
 	DC_DISABLE_REPLAY = 0x400,
 
 	/**
-	 * @DC_DISABLE_IPS: If set, disable all Idle Power States, all the time.
+	 * @DC_DISABLE_IPS: (0x800) If set, disable all Idle Power States, all the time.
 	 * If more than one IPS debug bit is set, the lowest bit takes
 	 * precedence. For example, if DC_FORCE_IPS_ENABLE and
 	 * DC_DISABLE_IPS_DYNAMIC are set, then DC_DISABLE_IPS_DYNAMIC takes
@@ -324,56 +357,57 @@ enum DC_DEBUG_MASK {
 	DC_DISABLE_IPS = 0x800,
 
 	/**
-	 * @DC_DISABLE_IPS_DYNAMIC: If set, disable all IPS, all the time,
+	 * @DC_DISABLE_IPS_DYNAMIC: (0x1000) If set, disable all IPS, all the time,
 	 * *except* when driver goes into suspend.
 	 */
 	DC_DISABLE_IPS_DYNAMIC = 0x1000,
 
 	/**
-	 * @DC_DISABLE_IPS2_DYNAMIC: If set, disable IPS2 (IPS1 allowed) if
+	 * @DC_DISABLE_IPS2_DYNAMIC: (0x2000) If set, disable IPS2 (IPS1 allowed) if
 	 * there is an enabled display. Otherwise, enable all IPS.
 	 */
 	DC_DISABLE_IPS2_DYNAMIC = 0x2000,
 
 	/**
-	 * @DC_FORCE_IPS_ENABLE: If set, force enable all IPS, all the time.
+	 * @DC_FORCE_IPS_ENABLE: (0x4000) If set, force enable all IPS, all the time.
 	 */
 	DC_FORCE_IPS_ENABLE = 0x4000,
 	/**
-	 * @DC_DISABLE_ACPI_EDID: If set, don't attempt to fetch EDID for
+	 * @DC_DISABLE_ACPI_EDID: (0x8000) If set, don't attempt to fetch EDID for
 	 * eDP display from ACPI _DDC method.
 	 */
 	DC_DISABLE_ACPI_EDID = 0x8000,
 
 	/**
-	 * @DC_DISABLE_HDMI_CEC: If set, disable HDMI-CEC feature in amdgpu driver.
+	 * @DC_DISABLE_HDMI_CEC: (0x10000) If set, disable HDMI-CEC feature in amdgpu driver.
 	 */
 	DC_DISABLE_HDMI_CEC = 0x10000,
 
 	/**
-	 * @DC_DISABLE_SUBVP_FAMS: If set, disable DCN Sub-Viewport & Firmware Assisted
+	 * @DC_DISABLE_SUBVP_FAMS: (0x20000) If set, disable DCN Sub-Viewport & Firmware Assisted
 	 * Memory Clock Switching (FAMS) feature in amdgpu driver.
 	 */
 	DC_DISABLE_SUBVP_FAMS = 0x20000,
 	/**
-	 * @DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE: If set, disable support for custom brightness curves
+	 * @DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE: (0x40000) If set, disable support for custom
+	 * brightness curves
 	 */
 	DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE = 0x40000,
 
 	/**
-	 * @DC_HDCP_LC_FORCE_FW_ENABLE: If set, use HDCP Locality Check FW
+	 * @DC_HDCP_LC_FORCE_FW_ENABLE: (0x80000) If set, use HDCP Locality Check FW
 	 * path regardless of reported HW capabilities.
 	 */
 	DC_HDCP_LC_FORCE_FW_ENABLE = 0x80000,
 
 	/**
-	 * @DC_HDCP_LC_ENABLE_SW_FALLBACK: If set, upon HDCP Locality Check FW
+	 * @DC_HDCP_LC_ENABLE_SW_FALLBACK: (0x100000) If set, upon HDCP Locality Check FW
 	 * path failure, retry using legacy SW path.
 	 */
 	DC_HDCP_LC_ENABLE_SW_FALLBACK = 0x100000,
 
 	/**
-	 * @DC_SKIP_DETECTION_LT: If set, skip detection link training
+	 * @DC_SKIP_DETECTION_LT: (0x200000) If set, skip detection link training
 	 */
 	DC_SKIP_DETECTION_LT = 0x200000,
 };
-- 
2.50.1

