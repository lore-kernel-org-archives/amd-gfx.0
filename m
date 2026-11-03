Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF460A5BCD
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nJXpSCU4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1334E10F4C5;
	Tue,  3 Nov 2026 10:28:48 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013071.outbound.protection.outlook.com
 [40.107.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D974710F4C5
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 10:28:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjlXjVkSwQzWHDaXKIqs+JRKLktBnNK5sweaviTcMMV8sCrvrf2KhE2QT5gEpot0HF+V7MWohdqR1p5nQza9KLZkv/L7+FhytDhYmRJiVkitCyx2OJbcUogLABrEHyNcedtFvreQRs9oe7nBBMmJ6fA1xQgbZ4Uc4Q4sgVRBTNiwc+mlitgy5si3ROe65C9dTUGVhutAwJ5n5YBVYCANBQnI/qeggGOGbUVRgI3Z5tJgziCfkTqJIOaveLQf/pVoGzZK+o3MpIvP4PfmQolzR/eEfpL3gQ9kPMv+eWKqvI7F0IA2/xwXlZtkf3Syy/bBnCNZtELeHP1+RqjM7m6kvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzzhDE18cy20ZcyVW/fakRZRtKfQOMY5Ub+ak+HhLxg=;
 b=ij5tn6NlXLe9Ka4dalf1J4pyG6gG5e/le+UZYPrLAxn7aiCeIOwfbPbhhpkCa9foM7mcKAceUDSTyTWs6RIGANp/4GWN02F6ro/aNhHc8chc8DTlMzsXqZZ6Op4dUECk7DkZRdjjcsfV8i4XcebOjxzEJfsgAYjWtOjz3lIETsZ/YCs8IDWKUUtIapCvyGFBiKED7Q9MYCEYjKOutIcJpmcTvKHFeFEy2Di7RicHFgQWKY/31j+qM8e5zwNvo9py5G+hZdFHBra8ZchP5RcPg3CYs8O8R8LjBCR2V8CotsiRNl8teeEVvEwkfNqqchOrki48D3gl16fM2mGg2YizxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzzhDE18cy20ZcyVW/fakRZRtKfQOMY5Ub+ak+HhLxg=;
 b=nJXpSCU4+LV4Yw6ktQiN7N4HznT0qRw5eKqgw/JG/kel3YPthjNunALyyd7Ao2ZYoYix/NzK3eFdOp7fXwK+KKX7Yxavbib0UEEO43TqOUMNWA69b398prVn0fh89SxXKGBEWf5otjKmJpyOidRbHNYbmT3T8b0PUpyZSWPbCrs=
Received: from CY5PR15CA0147.namprd15.prod.outlook.com (2603:10b6:930:67::16)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 10:28:37 +0000
Received: from PH3PEPF00059619.namprd05.prod.outlook.com
 (2603:10b6:930:67:cafe::3d) by CY5PR15CA0147.outlook.office365.com
 (2603:10b6:930:67::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 10:28:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH3PEPF00059619.mail.protection.outlook.com (10.167.243.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 10:28:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 04:28:35 -0600
Received: from stxhmapple1.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 04:28:32 -0600
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Lijo.Lazar@amd.com>, <Kevin.Wang@amd.com>, <Christian.Koenig@amd.com>,
 <Felix.Kuehling@amd.com>
CC: <Priya.Hosur@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v3 1/1] drm/amd/pm: restore the forced performance level after
 a reset
Date: Tue, 3 Nov 2026 15:58:29 +0530
Message-ID: <f370dc0e7025b9b39cac723b1b60ccbd339d233f.1793689935.git.Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793689935.git.Priya.Hosur@amd.com>
References: <cover.1793689935.git.Priya.Hosur@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059619:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a8a67c-fff2-47db-f91d-08df3995383e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|261026140227099003|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261022105027099003|261021123027099003|261026121527099003|261022075727099003|261009221227099003|10067099003|18002099003|22082099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: I/DBTV6X5iqFd3ZJ+CNB7Rn8HanxE30q+vnwYkZ9VexYyVqb/PdIMtE7ZKvIxdkizE2l9zi81pduhMJzpHdW6KgaW7Q3K1QdlNU+9ucZpcFh0DHiub8R+etZrwfV+fWugKcKGtIdNYkAFEg27iirFLQLIoTr74s+3aFfztDFcyzpsMSgNNsQ4KKHOJCcukSwcnhfeZlJ/u+C3wRPLWZ3jIboA3s4AurDpoxwF8mfXqDyQ58HqN9efFx6+xuPRne/zGxtB7UIS/G/VoPLR+H+sRZqdECeMXyt2px54tWSZE5FsmrZu21jN2kN/geUkWS3W7vNARvblqIb1a9sAdqudt6Fl9AHF6y6cqHML0Vk1ayl6zNPxAzta2J8VwllzcCQpH6qPuVLUc8hcjFZk9qMxDFtgjn4zyt26PHjpSIzYBF+KY/87e2uw8NRmAP9IK9cJSE7NGWe9HclVuDXgxTeE5c/uPF2Bab8AsLtFPboq9UHLxGV3S5by5/gH8PIMF5Xqx1Zpb8D+s3KnDpbZYsIu0Q4toLhS7ieYgkVuh4LZjpF0kiXA3VxjI5zZfPVyC+KwEHcfa49UoVfYeYnDz1bLV/zXPWQG48Bgk0xpTCQZSSzQhb3DymImOQXmEaw8O5TTZzU60/TDfV8iqQsP/YpKc1UJmoBR8gf++t2TzBk8mkqGjljparFONlneFtlAzleeZ5t2GYXb/Vc7364Z+Biew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(261026140227099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261022105027099003)(261021123027099003)(261026121527099003)(261022075727099003)(261009221227099003)(10067099003)(18002099003)(22082099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oMIz2Fgva5NA3I+LTnN21ajobHbwk4DZBCQQEnyFhdq3YPyePAwmPx7Fj1qofVR2hr7NBbjgbx8f9btkypyFXk7QkFgDaReoMVU3igJ4jQ8LNydAehwBL0c6U2/PeosneznbdOWrmWpLa5cR5OHD8XZpRkKYw+lZywmuuQKTFw65z746hK5GF+T7k3YWQ/eVgIFggUn9srXLDwlEkzAno+AYy4jFmntSPX/FPNGoxebbihrlthfF1IbSklmSJBtDcmC6sOojDCc/VT3TFJhTroT0w01ksBw6Ds1RIUep9R34SH5FTKDCwPb5p6Ks5agGjuSCUzfZ1+SVig+4bo1X8eL79Ag4hn00AZVO8norElyGcu/hAXUcAF6WDsnqbb07muSfZ7hp+Sd3r7B8swzpZNR/EYhEIeLXbBnkGPnXQQLaHT+CiqXcN7tKpKwMi2e3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 10:28:36.5343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a8a67c-fff2-47db-f91d-08df3995383e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059619.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

smu_late_init() re-applies the DPM level with

  smu_handle_task(smu, smu->smu_dpm.dpm_level, AMD_PP_TASK_COMPLETE_INIT);

but smu_adjust_power_state_dynamic() only programs the hardware when

  if (force_performance_level || smu_dpm_ctx->dpm_level != level)

AMD_PP_TASK_COMPLETE_INIT passes force_performance_level = false and
smu_dpm_ctx is &smu->smu_dpm, so the level is compared against itself and
smu_asic_set_performance_level() is never called.

PMFW is reinitialised by a reset and comes back on its default curve, while
smu_dpm.dpm_level still holds the level the user forced. The device then
runs at the default level while sysfs keeps reporting the forced one. On an
SMU 14.0.1 APU gfxclk drops from 2.8GHz to 600MHz while sysfs still reports
high. Writing the same level again does not help either, as
amdgpu_dpm_force_performance_level() returns early when the requested level
matches the cached one.

amdgpu_dpm_reapply_umd_profile() restores the PROFILE_* levels after
recovery, but returns early for any other level, so high, low and manual
are left on the PMFW default.

Force the level to be programmed for AMD_PP_TASK_COMPLETE_INIT during reset
recovery. The cached level is left untouched, so if programming fails the
level the user asked for is still retained and the failure is logged.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a901f8535598..654ff6824fdd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2553,7 +2553,12 @@ static int smu_handle_task(struct smu_context *smu,
 		ret = smu_adjust_power_state_dynamic(smu, level, false, false);
 		break;
 	case AMD_PP_TASK_COMPLETE_INIT:
-		ret = smu_adjust_power_state_dynamic(smu, level, true, false);
+		/*
+		 * PMFW is reinitialised by a reset, so program the retained
+		 * level again even though it matches the cached one.
+		 */
+		ret = smu_adjust_power_state_dynamic(smu, level, true,
+						     amdgpu_reset_in_recovery(smu->adev));
 		break;
 	case AMD_PP_TASK_READJUST_POWER_STATE:
 		ret = smu_adjust_power_state_dynamic(smu, level, true, false);
-- 
2.43.0

