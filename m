Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2B3CA0EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 05:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01E8710E1BB;
	Wed, 13 Aug 2025 05:21:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xSUqZdOC";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52C0310E1BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 05:21:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rX+G/LxWz4ByNVrvBBc9DFZZOTvS/JnPI0CwAl+pfzLUug6RyB4Q6iEnRHs7Ku+2w2xtRbPJmDEDPUkRHAtIm4iARFCUIyh7VVbdZEpzNAuxfbgIBeCWA7Yz1gNB4HLw0sPB9eHU0NkkgZKk0mlsZGs4dDrxxxDM81Irpm4zC/GIKXbGVpR3jCYGm13kK1/vHKDR177g4iwjGyLS8N96WI0RdtTat1U/qvTw2ZslwDeoUv+RZnG8C4CB/cT4cAdM7Lks5xIWKiYMkCXxhycgDRdQdD8bgZ0JXQa/ghZyw5jvoQStbj5P/NMLXiNSvOE219+3n0yAl3U44lQDMzJzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulUiPssFl0Xd67yuZd/hEZ8MyTDeGIpgo4zye3hIUaM=;
 b=VYmo6BJB64lDugnRRugmL1TNJW5ApxqylT7oSVmm4xkpH3S730kOeC2d5RmNOyRSyb3S5O974at44CFrwlNlCwAu/oYF0yGQF2OuJYppvnYqSSBacpIDoeyOjmc7iitQu/UIHJrnSJ9akcrj52DP09AJx9skzLk6NLBhG3VSsiWtaARMjpzSFMUtmP3FP5opwKd1NcIUaFgkswMSRpSxpsJ1VFf1NB6OHaoP+n/5WK1MYsT3uBHryjFu9SqyIkYPpsY89r+swBFeEUejW+vSrAHEL3DseBCHDinPZ6HDN9RICDFkr4SewURI9mZZD4C2rFNxw9O3bHIFs9oXV/C41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulUiPssFl0Xd67yuZd/hEZ8MyTDeGIpgo4zye3hIUaM=;
 b=xSUqZdOC3elPoCMjp/nNaF/Xt95LHxwqOaQBD1Zmj/GBejX1b8cPpq6XcSc304A9Upa30YLZ2kG5K3A0J9RCOk6JsyxNLYSyZXd1Aji6ls3YBVH+o0mkTx9PothxT/TyXb9ZK/q1RsSLLaOIfZLFKvEyTuOFDq62RwFsaMP6TY4=
Received: from SN6PR04CA0092.namprd04.prod.outlook.com (2603:10b6:805:f2::33)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 05:21:18 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:805:f2:cafe::7a) by SN6PR04CA0092.outlook.office365.com
 (2603:10b6:805:f2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 05:21:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 05:21:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 00:21:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 00:21:16 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 13 Aug 2025 00:21:10 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Ruili Ji <ruiliji2@amd.com>
Subject: [v5 2/3] drm/amd/pm: Add VCN reset support for SMU v13.0.6
Date: Wed, 13 Aug 2025 13:20:00 +0800
Message-ID: <20250813052102.3438895-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813052102.3438895-1-Jesse.Zhang@amd.com>
References: <20250813052102.3438895-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b1ab4a0-82c9-4cef-2b7b-08ddda293b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tK4gqoc0djS321eaM5QC/JYcO8f9diTBFPrFuJ+U2K3jVQQLH/b+J4hT5hGx?=
 =?us-ascii?Q?9zJeZHB7rFlDqX5+ELFldTEnRfg9t4vqXzH1eeMyvxkhyo7ZZ2+J1l6a2v4j?=
 =?us-ascii?Q?2CbXDe2V/tqCGV9OUbGKuGEuSAe4ufBRO53FHm1XbnivVw6wTn6iaAa9rkt4?=
 =?us-ascii?Q?BmXyHAj4Xk70cJpXLQWmqfMJT1Fdg0RTF8i+WpiJOKzgtQffr3gV5Lybqgdk?=
 =?us-ascii?Q?pYut0qyjtDggtoDfmROaYLbnSElEZB4flbyI2iS0Z2kpWJ4BPfwC/Hn5f7fL?=
 =?us-ascii?Q?VyvlKadqsa9W1p/Mo4NENiiltTQSyTeU8JhTkJKAe6VAp4Jm7eNvWwYjQgNn?=
 =?us-ascii?Q?elby4EB4wehXgbZSmlZvTrXb7WCngxwIx1HC4NB22y2K4lvN0FaTS7AACj1v?=
 =?us-ascii?Q?BMtXJZURMuXtaZSoQ+Ky4StP3Kaow6ZFh3LO5wKmeURwITaAx9Ne3D8fHMJ2?=
 =?us-ascii?Q?YEHA9rVtS9+AUPI5whFBqaVlm8qeplyntpsf21k7PTxG9AYUxnqjDM8D9mgD?=
 =?us-ascii?Q?LDPJ1B1y67vwq3jmd65mn8iliEVIf7339i9o9dMixGuG7gYpR8QZvH4ytGoK?=
 =?us-ascii?Q?BFlD7b4bFNCBT/O91xtWpRA9l7wQouBXz0fM+wDOw+MhbpEfcT1s+wWUmP9i?=
 =?us-ascii?Q?3IFDKHP66K9NKQOjGcVNCIg/8x1Vd5TG7in/j2FZLaOWl4AUUovA6D8nsG1w?=
 =?us-ascii?Q?RHwQTrVPW4hSvY7rhSPBn61EjDJnfwc9fry0gcIE96SD5SQqqandMEoQ1yVY?=
 =?us-ascii?Q?HqS+JIs44YdMdnlOq+LZKN28GK3t3xwnhAvywRSbWuIx4cmlzx8w2sVpjJdS?=
 =?us-ascii?Q?A2L0IqX4EOe1Md1cxGlDe08VOUNwuxxVK50k8pvo7MhlxD1aTSq0GsvYFOBJ?=
 =?us-ascii?Q?B7pe7cOpKYJEGRSaqmJEK/H3TEepBIDBidC127ZWLeSgLzj7TEjYxTqoRHhq?=
 =?us-ascii?Q?gyKJniQjJNXtOLWhRoEONezhGTKniaKu1OemITOp4BWkpwivkOBJLJSvCRY1?=
 =?us-ascii?Q?mUtiiQbOA/P4+KXZ3LfYk6NApyo7RgqvnGpkwlTRb8LjTwow4P3OD+vlHMlC?=
 =?us-ascii?Q?dgNqqCDUgTnOHASFHt+rj8zbj0UZtUtJes06ga26r4GZ2fhRW7vKVhz8NES7?=
 =?us-ascii?Q?8B9cAQkadilRmrF15QNacyintAIO001L/LOlDZ6wPEB1KXFD72JjKR+z9b2M?=
 =?us-ascii?Q?4cp+KfM9ZZWIl4Wzt+1TrunLErToWCt3na3SHpKQvxxZrDEgc8FQz1IIYSsa?=
 =?us-ascii?Q?Yf2zpubW/d9gO5sZINSNcGuhuyE96ElpJU2bWOeLnvfVuwtF0EJGt/68/9cL?=
 =?us-ascii?Q?t7KMHRhG3e3am4xAJoVHQHZyGh3NeAitEdkMNmtcCohe2S8LHYjC8XRytDgb?=
 =?us-ascii?Q?ONLfGrwzelohMCWV6q/AYYjr47x9lOWyc0P9IB7LsbrLEgauGLgASf6rnZTB?=
 =?us-ascii?Q?knYOLxSzPg+3JgFc0ipdu+guNp23NZnB6B+30wKdmi/ibiQyToq4Thhn6c7o?=
 =?us-ascii?Q?vtrmrBiisK5krXRHEyo+nOI9bn7VG8bgjWiw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 05:21:17.6645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1ab4a0-82c9-4cef-2b7b-08ddda293b25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991
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

This commit implements VCN reset capability for SMU v13.0.6 with the following changes:

1. Added new PPSMC message ID (0x5B) for VCN reset in SMU firmware interface
2. Extended SMU capabilities to include VCN_RESET support
3. Implemented VCN reset support check:
   - Added smu_v13_0_6_reset_vcn_is_supported() function
4. Updated SMU v13.0.6 PPT functions to include VCN reset operations

v2: clean up debug info (Alex)
v3: remove unsupported message and split smu v13.0.6 changes to a separate patch (Lijo)
v4: simply the function (smu_v13_0_6_reset_vcn_is_supported) (Lijo)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c     | 9 +++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h     | 1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 41f268313613..63a088ef7169 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -94,9 +94,9 @@
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
 #define PPSMC_MSG_SetThrottlingPolicy               0x44
 #define PPSMC_MSG_ResetSDMA                         0x4D
-#define PPSMC_MSG_ResetVCN                          0x4E
 #define PPSMC_MSG_GetStaticMetricsTable             0x59
-#define PPSMC_Message_Count                         0x5A
+#define PPSMC_MSG_ResetVCN                          0x5B
+#define PPSMC_Message_Count                         0x5C
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 3b4bd7a34d04..cc59d884025f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -436,6 +436,9 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 	    ((pgm == 0) && (fw_ver >= 0x00557900)) ||
 	    ((pgm == 4) && (fw_ver >= 0x4557000)))
 		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
+
+	if ((pgm == 4) && (fw_ver >= 0x04557100))
+		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
 }
 
 static void smu_v13_0_x_init_caps(struct smu_context *smu)
@@ -3200,6 +3203,11 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 	return ret;
 }
 
+static bool smu_v13_0_6_reset_vcn_is_supported(struct smu_context *smu)
+{
+	return smu_v13_0_6_cap_supported(smu, SMU_CAP(VCN_RESET));
+}
+
 static int smu_v13_0_6_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
 {
 	int ret = 0;
@@ -3888,6 +3896,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.reset_sdma = smu_v13_0_6_reset_sdma,
 	.reset_sdma_is_supported = smu_v13_0_6_reset_sdma_is_supported,
 	.dpm_reset_vcn = smu_v13_0_6_reset_vcn,
+	.reset_vcn_is_supported = smu_v13_0_6_reset_vcn_is_supported,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index f39dbfdd7a2f..bcb8246c0804 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -64,6 +64,7 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(RMA_MSG),
 	SMU_CAP(ACA_SYND),
 	SMU_CAP(SDMA_RESET),
+	SMU_CAP(VCN_RESET),
 	SMU_CAP(STATIC_METRICS),
 	SMU_CAP(HST_LIMIT_METRICS),
 	SMU_CAP(BOARD_VOLTAGE),
-- 
2.49.0

