Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0646BE7716D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 08:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9BE010EC4F;
	Wed,  4 Dec 2024 08:32:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sMXa5cmQ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BFD610EC4F
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 08:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVasy5ZvQnUbmbCcrIVP+hYacjVncdeyaM9mclYWyO4gaBRQWSokM60+kf6eHOLT8JDc089fzepukiiAIFPwOILQrhAiNm954YUu5zanVRBNEGd/2oqc9nPrC1z+UPe6tPv01/I5hnvYpSPpaChg40YJ6IyGW5RDid/L5/2nacYz71ddr46M6M1+kq9oWJyWgUveBu5EQUyPg+PchrK9nwT8sX95IiINZLFpwiamJgA4IflsTdYWCaVdaXlZRDb28VfD6DWTnWSvGKIheUlDKEsMjNBTkoCeQxFKB7Yicr/7hbkrDJaKwN5BfVFdVhlTbrfy5dTwvp2BvCdsPuzXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyOqSCVOxluvSRzCgClJmdu4FtIAP4bWpPdnGmhC9MM=;
 b=NFhB89XTk35DPq88hw9/FfF3GzR7gdga59cj9yrJGorEPhDXSPt/SNWokpR7KsiPk/abHs1e2DfwBXcTwsGMBMzgKQxd7OuKS4Rjp6dO+HAqbwc8jeuCulDBdCYFpBtGUz3vopSu81feMbMv2NtRvi5HXzo9hSM6dAy2+dqqZPXC+p3kD9qX2+W/2SwhFSUeEgUd/PfPSYLUNEnXj38T38aM6dnXqh+OWHguNAxqEs7JZ5SO1Y5QtdS+aMWx+Z6eMK4ZPuvPtm0usZwSmCYhJUhbLJpTat/CBwz+IHlecLul+vEqvXFd476Nhm8H4wzRVtk09YB2MgNnR5vhEJlj2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyOqSCVOxluvSRzCgClJmdu4FtIAP4bWpPdnGmhC9MM=;
 b=sMXa5cmQXvx/nPlduW0AKRPyWAiiYE2aTd1afY5ukeyvUBivMaiZtIxD9HFYVLcUvKW1FlR3z9Xf2ZSfYviSoCv0zdXDlFpCckGOCkXkRpexZjvlN5FrpkABnCznslwQ8duZFJi3LyBg4N9Z9o6522e+toD4y93bvEsA+0k7rD0=
Received: from BY5PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:1e0::31)
 by SA1PR12MB9515.namprd12.prod.outlook.com (2603:10b6:806:45a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 08:32:06 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::23) by BY5PR03CA0021.outlook.office365.com
 (2603:10b6:a03:1e0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Wed,
 4 Dec 2024 08:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 08:32:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 02:32:01 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 02:32:01 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 4 Dec 2024 02:32:00 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH] drm/amd/pm: Initialize power profile mode
Date: Wed, 4 Dec 2024 16:31:57 +0800
Message-ID: <20241204083158.1312554-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SA1PR12MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: fef3de62-372c-4ca7-1ea4-08dd143e22b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kSmM2HoHZ1IaEAf0PwLkBSLlZoHi4h5BaI7GLj7t8LHYiB4KkQartYjI9TYw?=
 =?us-ascii?Q?5YHsyXy2em62DmpPoXq6CCt/Op6HNI0gmTU1OtOHOK8J4bny2fopBR7jSkVt?=
 =?us-ascii?Q?z54RlPaj97G+xFP8sN/TkZktSwKJmUbQIO1ZYXNWJtFp9CgzLAIsHHjiz7pM?=
 =?us-ascii?Q?E8aj7ftNAqueiNdSGiej6AT70r3tQ4fGOPmN+1FriYDn8UpD1mr1BvIzpeu+?=
 =?us-ascii?Q?Jn9ZqjRKUy7+de4AoDBqhW18w78ZLvx7bURU3RYOspMhFLALQ8q3fytjyAUL?=
 =?us-ascii?Q?MwMfRk+ecFGlFDc2oscR2mnV2iDYCrgMpOoCG6zB19bm4aJEC9LNNvqor78P?=
 =?us-ascii?Q?9qlu360BoiLORiIReYY5wa6TW/q093Lcy/m5yXgn1znOw8v6s9hbqtj0YQ17?=
 =?us-ascii?Q?H57eyey6J9nmwCO1w+SHNJd/r+SviFXqllhhOK9SCs+XdDeJQxORRYRY5DPF?=
 =?us-ascii?Q?EvnQHAN7ITcU/3wtq0yvbYmxjmwHvirnwUbLk46FRo2OcR2Ht5jCD96s5D+l?=
 =?us-ascii?Q?f8OGfN8P1dVByA3iNbEHttCjn3IeJHtrGRPUy4ohGaLUsjte/p4/xdPWhEWx?=
 =?us-ascii?Q?t4MWqzP8YzgKkk6TBj7t7aFCSnDlKrF23SnNIPKKHFQmqci17o3YMGp/wwY/?=
 =?us-ascii?Q?48/s+tqgoJ/NALRPlra+oF7+2hot1c25l708Ppfj34kYz953qDOUm8EP3Dm+?=
 =?us-ascii?Q?54eMX1HjmcXSRpVOVo8y6GWa7Y8auzHahflLRbxJx+ajlGRR8QGFJCUAqxs/?=
 =?us-ascii?Q?NosAgWhze5C8X3jxmfJ8kjICAg68Gb0wBIu6MUWlll4d0u28X8ONq1JL/V+P?=
 =?us-ascii?Q?DcIIiuTF5lB5R1L8A+6cX4+QKe9SQ6whLPFBk+VaP6yatzdN2NvkLGf9lszp?=
 =?us-ascii?Q?rcoG+PSxPAwlNz/vm1BUJvllD8ww0mJDoeSf5rNrokdaUx4xiwcgXWz6V28L?=
 =?us-ascii?Q?H7zFrm0SSm2nEiEmZ5KLnYJrhAoUoZ9vIHJXEdm3J4PFYNQgbeoKx6RedOia?=
 =?us-ascii?Q?idA4MPB/KybvEMrPRoiPDmejtNVKKsZ3xovWWWTq/Rl2g7XAUpM7IhYa3cNJ?=
 =?us-ascii?Q?PX0sMM4cEgW3gduwKlykCM88OsSi9sd1fQu7ZlZX97twvXd4C5/6fCglUsQ/?=
 =?us-ascii?Q?gb1B9W/aVWOkXoum+6Yyd5BmF5SXWxWcx7OPdVJmadXcAEK72zLs3/9V4gn+?=
 =?us-ascii?Q?uh72uSeuaYtl6oinAfQfJ1bf9Ampik0mylWzgIV8KW06lZcOj8jHfjDaNMHX?=
 =?us-ascii?Q?8ZfMU/UXUkAwoO7P31rE4vVtwhoPNnY414MNe04rjhw29XHFl4swdBbwdZdR?=
 =?us-ascii?Q?mUbCp8eSODDDb3p83aWyixxow9GpwO3E8flokLVhAQ6MgEefJjCN10XQ2Dip?=
 =?us-ascii?Q?it3NWIJ4a59OaF+D2/ASbQezk9kQSOUJAcJHpvHWmKfwxPttbG92Joz0+tRu?=
 =?us-ascii?Q?GQYXpq52OfLJPqKr2wO07KVUEOhTSK6M?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 08:32:05.7935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef3de62-372c-4ca7-1ea4-08dd143e22b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9515
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

From: Lijo Lazar <lijo.lazar@amd.com>

Refactor such that individual SMU IP versions can choose the startup
power profile mode. If no preference, then use the generic default power
profile selection logic.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 24 +++++++++++++------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 75dfbf14755c..9189dcb65188 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -164,6 +164,7 @@ enum amd_pp_task {
 };
 
 enum PP_SMC_POWER_PROFILE {
+	PP_SMC_POWER_PROFILE_UNKNOWN = -1,
 	PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT = 0x0,
 	PP_SMC_POWER_PROFILE_FULLSCREEN3D = 0x1,
 	PP_SMC_POWER_PROFILE_POWERSAVING  = 0x2,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d1bab508ade2..bd1a847960e3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -767,6 +767,7 @@ static int smu_early_init(struct amdgpu_ip_block *ip_block)
 	smu->smu_baco.platform_support = false;
 	smu->smu_baco.maco_support = false;
 	smu->user_dpm_profile.fan_mode = -1;
+	smu->power_profile_mode = PP_SMC_POWER_PROFILE_UNKNOWN;
 
 	mutex_init(&smu->message_lock);
 
@@ -1257,6 +1258,21 @@ static bool smu_is_workload_profile_available(struct smu_context *smu,
 	return smu->workload_map && smu->workload_map[profile].valid_mapping;
 }
 
+static void smu_init_power_profile(struct smu_context *smu)
+{
+	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_UNKNOWN) {
+		if (smu->is_apu ||
+		    !smu_is_workload_profile_available(
+			    smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
+			smu->power_profile_mode =
+				PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+		else
+			smu->power_profile_mode =
+				PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+	}
+	smu_power_profile_mode_get(smu, smu->power_profile_mode);
+}
+
 static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1279,13 +1295,7 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
 
-	if (smu->is_apu ||
-	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
-		smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-	else
-		smu->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-	smu_power_profile_mode_get(smu, smu->power_profile_mode);
-
+	smu_init_power_profile(smu);
 	smu->display_config = &adev->pm.pm_display_cfg;
 
 	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
-- 
2.34.1

