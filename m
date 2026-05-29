Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1C3CD6E45
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 09:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E87D10FC0B;
	Fri, 29 May 2026 09:44:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UV26ZlPY";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6062710FC0B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 09:44:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEpsH0FdZPo/guu9GAFWDtQg0M0/ObszZlpfa9RN/n/DeiydbdFKIokt7rKdggQGJEAMwqdgijaF69/VG8WLdVXIrsZcq01LRJOWnaA4/pDPgB9KJI3wO6Zr0XF3EqrsL+a74N7AotRikjI3KeQIDl8rmzw+V5P1rqSgAmPwU5idyTYtd7uSB4e18BxZ3egre4bedrnNGOkFVeZeYePHcvsTFNBTQ2rooNYhsBI0JYU43EK2BDuf2T4F9Mqm6MoCPGZa439gCn/gFHac2b9A1ssenLLnEtGlLDpF3y7izdQmfYvCIS+XiIGrfgibkGmzUyuvzKDniqvFPV1ECqGYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xD+aB0ZfbdmsFl05mjhuf4O8BIkzgUuEYhsyTxTDvmI=;
 b=we0Dd5fY+HbDy6ALZOl0TAfusti90WGdLbqP0KO6WPdRRhHT2Z05gKhQ5fm62qQqk7Lg7D2OSGtvnqaRJvpIVkk5fFGrrB5k+W13DFKmAgGOucyYExLWD4s0Z60OFn4qFwA6ZGkMQm0EizSqqnTpK3gdOsvDQZMwJCbUjjKCcSo7IZFpU6sifXmuh/xIhA5HS1z2uUzaU6x7IfIgKJVioouG0fkAxFARqo5igzQvxos5Syiyph5uETDjw7ftR+RgTNT3sp/wnFfUn+3E8BQEhmbsl8t3+KQXBfNWwY5GHkfW1z4ES36xdDBHbjX99N0T2DxHNKuwrnrvlQwnq5V38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xD+aB0ZfbdmsFl05mjhuf4O8BIkzgUuEYhsyTxTDvmI=;
 b=UV26ZlPY1uaqxpU4zLzDoE359kCAZaXJouCTEFDkThFPS1tGdl+I+snFAGnimi4PW19EwE6ct7Nrcc/FpMaM+QKc94ZnGu28SF5llr+tYA+K3EPQxKBjbAvcycrJ8oUQtjB8bjHA4OD51m8Y9jX84b2j+XmSonm/Sfx2hoXDiDs=
Received: from BL1P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::31)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Fri, 29 May
 2026 09:44:35 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::a4) by BL1P223CA0026.outlook.office365.com
 (2603:10b6:208:2c4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 09:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 09:44:35 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 04:44:33 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Validate custom profile parameters
Date: Fri, 29 May 2026 15:14:16 +0530
Message-ID: <20260529094416.1135533-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: e81c2f24-6f6e-4ef9-4690-08debd66e484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: umwP2nviYBsQqQrCc3ettZ+f9Je92lm6YFU0knD1lqhCgtnezBDQjz3AuNxh0HFBp4MTfQmkhtQoFokwkdTgCQQonDIm908n+FegR0dBYiuKBhane24DIDFOLHdz+K3zWt60ACdBSHKBCm3mbgaQW5gcyhMVriyIFemTbPGodnNqWCY9XiDYbjv9PaVF1iR6Rgny0chdiHLYGeQdqZEbn+0Dh+LF10R5lP8sc6ztCr+Zm/612lZu0+6XyqfHhAwTx3/XpDV1dZ5u4yY3fjtWzmIrHTacvJqf4E+KSOTQuxxMZGCWz3+PeOBDmc3dXRE7tDvmwRQskHw9eVquD5BK3EktiJdKrr2Gyc00K2iXDd3DZNI4vdL1pofOSYQ3pUBw7n42JE/HLoWW5xT7RT3/YZLZ2Kry0R7LXSMgFNwzvrJteegKobXUQOIxZYnDJqAS2lxUZJqOKRDV9/H1X3Nd8jX9Rn4nqkZOfYIxQvA+Nd+cqlGxbZN4JxNKQcIEDq8Yn2srJJv2aGlL2PtpadIVC6lQh01l7DlRPGs+TvUOvdVE1ZKn/WA0FS3g2HQXk5EzRQL5NP7LEtetH2KZ9kP7YJE/iQOG/zxTvDzqNSxoihiReauIA5Q0rWOHUt7cE/pN2W/DQ5WFZqm1Ns7B5Dv7W6RQFogvpzool7MUCMbm4HYUBtY4Igp9ii24QEIvz1jNrsLwdKcJ9FOOeLEt/iWU745APxzuy0c7EPqpCP4VIkQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WbNeKSeWapJA//HQ7cU6hGI2Z4v3bv7AYx5x9cct981m/YrOn/iyacMkC0DK5Czt0AeIFscvINkolk8WDYKfT4+gFs7beAlmZAp/p9Bi6A+MgzRTi/hFhpFzF64ZlDHqyzYKh33+BBtvgsSLk8WrtrWHOyReszJnItTiGeFcQe/wwzb4VUckeOJ4GgcafpSOZTpVsuaH/pKhsPmy0Eyq+nQ3EdORq1dkn+aLXi8U+ONQkMrmZruCk5yR9xPn8wlkhg+f5apkmEwvn8BdAusC2Y0JACAhOGTgecJqMdRo4hldcCwNmx3MJGnxU0nfsljY8uKVga0Ibi2Ko4ch616olBH7atnKTfp/kq0+EQnIHaOtJhqWAw1aDGG6IiDoNMwc6LvjqOs6aR69qydJHFHzR9cw6lgsTxO9JSnnyyhBQjkdEs598aZ84MSleyRdu4GJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 09:44:35.0940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e81c2f24-6f6e-4ef9-4690-08debd66e484
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108
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

Add helpers to validate custom profile params against
negative/out-of-range values. Use the helpers to validate user passed
params.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Assisted-by: Claude Sonnet (Cursor AI)
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c      |  7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c        |  7 ++++---
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h                 | 10 ++++++++++
 7 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index d73c3c191e9c..051a0008aa10 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1467,9 +1467,10 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 				return -ENOMEM;
 		}
 		if (custom_params && custom_params_max_idx) {
-			if (custom_params_max_idx != ARCTURUS_CUSTOM_PARAMS_COUNT)
-				return -EINVAL;
-			if (custom_params[0] >= ARCTURUS_CUSTOM_PARAMS_CLOCK_COUNT)
+			if (!smu_cmn_custom_params_count_valid(custom_params_max_idx,
+							       ARCTURUS_CUSTOM_PARAMS_COUNT) ||
+			    !smu_cmn_custom_params_clock_valid(custom_params[0],
+							       ARCTURUS_CUSTOM_PARAMS_CLOCK_COUNT))
 				return -EINVAL;
 			idx = custom_params[0] * ARCTURUS_CUSTOM_PARAMS_COUNT;
 			smu->custom_profile_params[idx] = 1;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f2ce8de58cb9..2f2a5953dbbc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1845,9 +1845,10 @@ static int navi10_set_power_profile_mode(struct smu_context *smu,
 				return -ENOMEM;
 		}
 		if (custom_params && custom_params_max_idx) {
-			if (custom_params_max_idx != NAVI10_CUSTOM_PARAMS_COUNT)
-				return -EINVAL;
-			if (custom_params[0] >= NAVI10_CUSTOM_PARAMS_CLOCKS_COUNT)
+			if (!smu_cmn_custom_params_count_valid(custom_params_max_idx,
+							       NAVI10_CUSTOM_PARAMS_COUNT) ||
+			    !smu_cmn_custom_params_clock_valid(custom_params[0],
+							       NAVI10_CUSTOM_PARAMS_CLOCKS_COUNT))
 				return -EINVAL;
 			idx = custom_params[0] * NAVI10_CUSTOM_PARAMS_COUNT;
 			smu->custom_profile_params[idx] = 1;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 68255cfcb04d..70897c70db32 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1756,9 +1756,10 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu,
 				return -ENOMEM;
 		}
 		if (custom_params && custom_params_max_idx) {
-			if (custom_params_max_idx != SIENNA_CICHLID_CUSTOM_PARAMS_COUNT)
-				return -EINVAL;
-			if (custom_params[0] >= SIENNA_CICHLID_CUSTOM_PARAMS_CLOCK_COUNT)
+			if (!smu_cmn_custom_params_count_valid(custom_params_max_idx,
+							       SIENNA_CICHLID_CUSTOM_PARAMS_COUNT) ||
+			    !smu_cmn_custom_params_clock_valid(custom_params[0],
+							       SIENNA_CICHLID_CUSTOM_PARAMS_CLOCK_COUNT))
 				return -EINVAL;
 			idx = custom_params[0] * SIENNA_CICHLID_CUSTOM_PARAMS_COUNT;
 			smu->custom_profile_params[idx] = 1;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index fa91837f7024..d7792616e4b9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2734,9 +2734,10 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 				return -ENOMEM;
 		}
 		if (custom_params && custom_params_max_idx) {
-			if (custom_params_max_idx != SMU_13_0_0_CUSTOM_PARAMS_COUNT)
-				return -EINVAL;
-			if (custom_params[0] >= SMU_13_0_0_CUSTOM_PARAMS_CLOCK_COUNT)
+			if (!smu_cmn_custom_params_count_valid(custom_params_max_idx,
+							       SMU_13_0_0_CUSTOM_PARAMS_COUNT) ||
+			    !smu_cmn_custom_params_clock_valid(custom_params[0],
+							       SMU_13_0_0_CUSTOM_PARAMS_CLOCK_COUNT))
 				return -EINVAL;
 			idx = custom_params[0] * SMU_13_0_0_CUSTOM_PARAMS_COUNT;
 			smu->custom_profile_params[idx] = 1;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 25f977a42a1c..ce83e299a66a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2690,9 +2690,10 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
 				return -ENOMEM;
 		}
 		if (custom_params && custom_params_max_idx) {
-			if (custom_params_max_idx != SMU_13_0_7_CUSTOM_PARAMS_COUNT)
-				return -EINVAL;
-			if (custom_params[0] >= SMU_13_0_7_CUSTOM_PARAMS_CLOCK_COUNT)
+			if (!smu_cmn_custom_params_count_valid(custom_params_max_idx,
+							       SMU_13_0_7_CUSTOM_PARAMS_COUNT) ||
+			    !smu_cmn_custom_params_clock_valid(custom_params[0],
+							       SMU_13_0_7_CUSTOM_PARAMS_CLOCK_COUNT))
 				return -EINVAL;
 			idx = custom_params[0] * SMU_13_0_7_CUSTOM_PARAMS_COUNT;
 			smu->custom_profile_params[idx] = 1;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 6b5aa4e514fd..933873de7850 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1829,9 +1829,10 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 				return -ENOMEM;
 		}
 		if (custom_params && custom_params_max_idx) {
-			if (custom_params_max_idx != SMU_14_0_2_CUSTOM_PARAMS_COUNT)
-				return -EINVAL;
-			if (custom_params[0] >= SMU_14_0_2_CUSTOM_PARAMS_CLOCK_COUNT)
+			if (!smu_cmn_custom_params_count_valid(custom_params_max_idx,
+							       SMU_14_0_2_CUSTOM_PARAMS_COUNT) ||
+			    !smu_cmn_custom_params_clock_valid(custom_params[0],
+							       SMU_14_0_2_CUSTOM_PARAMS_CLOCK_COUNT))
 				return -EINVAL;
 			idx = custom_params[0] * SMU_14_0_2_CUSTOM_PARAMS_COUNT;
 			smu->custom_profile_params[idx] = 1;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 0e119965ce13..5b7f64b94179 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -113,6 +113,16 @@ static inline int pcie_gen_to_speed(uint32_t gen)
 	return ((gen == 0) ? link_speed[0] : link_speed[gen - 1]);
 }
 
+static inline bool smu_cmn_custom_params_count_valid(u32 max_idx, u32 params_count)
+{
+	return max_idx == params_count;
+}
+
+static inline bool smu_cmn_custom_params_clock_valid(long clock_idx, long clock_count)
+{
+	return clock_idx >= 0 && clock_idx < clock_count;
+}
+
 int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    enum smu_message_type msg,
 				    uint32_t param,
-- 
2.49.0

