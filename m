Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819221088E64
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 02:09:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2071E10E7EE;
	Thu, 19 Mar 2026 02:09:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HHlw/8Pe";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013038.outbound.protection.outlook.com
 [40.93.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7974810E7EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 02:09:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaLxw1hzN/oz36d50fyLecvpLeBit/igoaWzvm+hZCC/FmCr83WdY/I8K9gcC1HVLikkAWPbtjc78iGu0QN9jL9ki2QGyxUDzJ4K67nb0hYry5YnpnjEjdEvDKB3gE+sBY3TJ7xKtnIdmq9q362sgq8Rmzscw4bP7Afgk52czzLu1Ma7CZAw94MSjoLXFmPUceXReBlKfu5WD4HAxP8b9Ldqxv0AFnt9rGYuC7lKOuxayjpKOBnxVyK0w0/pRkn6vcdvWZt/71X5SZqAqA69OJ1jPO1opa1gbNI/Y6OMA6z21ykF75+vFawxJ6wSXWLgsGaNEz3WD1btfe1ajlnLaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQBGtZkqn16k2J5Cjo9XSRtIiIx0qO8cc82aijDQUwA=;
 b=oASwDE/8YmtHbsPnk6M+5mc1KUzeyDRwjJoJhsjvjJaHpdsxZ0iobhoYrcw01Dne2jdpDv4zQC9RAPRG981Z2UU9a0TZziPObUm3YazC8CcRwB8kHt86M88TZODMY6Nnn9As/6oxub2WDyEJmLQK3FmuEKfCc6Si+bzpf6vP8X7Rgn9WpP9Mm8TIVAtSnc6B/RsVFr/h1wsFuADHUfgM5IBk6nMEsdI89X0+6Z9Y5Ho3L7DYc91H2aDp8fAOI1MAlZcSd/jBE07Kp+filYCzoOgBVm1zyqeg/BGLljm2mnynK96tTOzrbSGEBI6UkGcC4oSjvzcHRSaecSMY6GGNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQBGtZkqn16k2J5Cjo9XSRtIiIx0qO8cc82aijDQUwA=;
 b=HHlw/8PeuzlktITZJP5czDe9sAbZYNtZak3ptEfjQCXaMRrCIJEWpu84KCACPjaSrNqNmlJ5M2yxQgk3pShdgtaKowVOUQl1bGP001eDb6CiCEHebZ5WfVADa9KY9Uqm9BHbONe2MPrxAYjMVxkIxwZissgELB701qfbDYkEChs=
Received: from CH5P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::7)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Thu, 19 Mar
 2026 02:09:29 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::96) by CH5P220CA0001.outlook.office365.com
 (2603:10b6:610:1ef::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend
 Transport; Thu, 19 Mar 2026 02:09:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 02:09:29 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 21:09:27 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: replace legacy smu_cmn_send_smc_msg() with
 smu_cmn_send_msg()
Date: Wed, 18 Mar 2026 22:09:09 -0400
Message-ID: <20260319020910.2620721-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319020910.2620721-1-kevinyang.wang@amd.com>
References: <20260319020910.2620721-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 700d72cb-bf44-4512-7149-08de855c8db9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Y0f4LAr4wD2v4eNv6Zwu1OXoO82A0amXZVUlTJiKT4VTxaLqL4pKgmDr+rBr0mK+wbxw/yrx6+znjNpU6cR+QJHOyWuX+5Nw7oJHkoaC4UCuQ5jPo2hK1TW5PNj4/MeDOkcflCSHdj5x1o8zKbI5rO15oGYEnKTmB91oBbsoihSdp4pxTsrG6K5fEL487bX8tqtwEFF5FkxyQGXX8wsxEF/iFLHNUH0g0InUlUDul7yAeYCAPewLmpjKvmzrLiwu8ZbUHNAHPdMabuTy5vAKR+w5dcWvp0rmhj3R7qlO18A1WSjxG4RslFtc4z1m8t3F6puZjwNpl6J+rBp36ak6U+xcdk00+cZcaCVEpNPsE6LQXMmP+mB9u8zWYokDum3+iw0Od9kNXFV8v+JvNiME43CZ7S6DCHgj2IgJUW/oemkiq9I4PAEF67ISqzs0a8Jf//9XI5JdjTHdGOFC2ELCh81T2amwXMMBQh2gI/N/H4rAeBiLiYgohhPNb9MVBv1wNbiuWV6v4Gj4AxJ2dfTASHcF6gq8DdlwWBqFiGTiiwRJXXr5u6fL1yj9QIwEtV3Z2hfjUNsZ/5N3p/Fdb+b192kHR9QULzg2cfSJhiZ8kCUWRMp4br/gviE5iH0aHGS+rlJ4GUN07ovo8N2lxqABXscLDW1cQ6NeoZEkTWwJ+0GKPlfd9xG1TNsd5w06WDkmiELxs9gnMQ3NRU+mwUxCQrvDAwVipn7jAZwZkeIAUsXOn4AchkgV9+U8i5vDwEtmbbULFDgfhiWAs1sHe1U3Yw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 51XfvGz5IzJJdkm3tcC3NyHx+aLRLpdG4uzQ2vkRiocNhJiIFs86PMn+lQnr5tq+ySObWEHnCjAl3OzAjEYqRBOPN4gAYx9FDMeM4FisC5i3AxA2O8b3W9dukaYDJaCTZfitUvVQdI1iMMt4PbP3GXFBLcMR8sPQiGP5D7H7WC2ddY6dY5r2TWdGbM663vt04Iydm/4QH+eDWgisaHgRF4Bowt6pYS4+kcZEyVQ/TpqyL54gtsReb9fAQtx+kmX1UqCgpLyj29yK6LLbLkzCfg9AcTYHUhTePXYYdKUot3WELidJLRCT2v6tRRqTgnTDdsH/ioKZ/xewPuGz5bI8kGpe3YVflX4lPiOHawEo8b50uPkWBEW+pDnA3KWykIuawG6pS7wI4CWpvadhZuXlkWhr8ZceCpUG+5M/leJoWLAzf4tOQBqmYHg9Dn4mflo9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 02:09:29.4137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700d72cb-bf44-4512-7149-08de855c8db9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043
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

Retire the legacy smu_cmn_send_smc_msg() API and replace it with the unified smu_cmn_send_msg().
This patch streamlines the change to the following sed command and standardizes code formatting:
'sed -i 's/smu_cmn_send_smc_msg/smu_cmn_send_msg/g'

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  8 ++---
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 10 +++---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 19 +++++------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  8 ++---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  6 ++--
 .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    |  8 ++---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 12 +++----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 30 +++++++----------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  4 +--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  6 ++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 33 +++++++++----------
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  4 +--
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 20 +++++------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 14 ++++----
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 20 +++--------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  4 ---
 22 files changed, 96 insertions(+), 122 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 0c4afd1e1aab..220027596937 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -550,13 +550,13 @@ static int arcturus_run_btc(struct smu_context *smu)
 {
 	int ret = 0;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_RunAfllBtc, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_RunAfllBtc);
 	if (ret) {
 		dev_err(smu->adev->dev, "RunAfllBtc failed!\n");
 		return ret;
 	}
 
-	return smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
+	return smu_cmn_send_msg(smu, SMU_MSG_RunDcBtc);
 }
 
 static int arcturus_populate_umd_state_clk(struct smu_context *smu)
@@ -1716,8 +1716,8 @@ static void arcturus_get_unique_id(struct smu_context *smu)
 	}
 
 	/* Get the SN to turn into a Unique ID */
-	smu_cmn_send_smc_msg(smu, SMU_MSG_ReadSerialNumTop32, &top32);
-	smu_cmn_send_smc_msg(smu, SMU_MSG_ReadSerialNumBottom32, &bottom32);
+	smu_cmn_send_msg(smu, SMU_MSG_ReadSerialNumTop32, &top32);
+	smu_cmn_send_msg(smu, SMU_MSG_ReadSerialNumBottom32, &bottom32);
 
 	id = ((uint64_t)bottom32 << 32) | top32;
 	adev->unique_id = id;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 87953a4d0a43..e37e2388a231 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -512,7 +512,7 @@ static int cyan_skillfish_od_edit_dpm_table(struct smu_context *smu,
 		}
 
 		if (cyan_skillfish_user_settings.vddc == CYAN_SKILLFISH_VDDC_MAGIC) {
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_UnforceGfxVid, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_UnforceGfxVid);
 			if (ret) {
 				dev_err(smu->adev->dev, "Unforce vddc failed!\n");
 				return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 737bfdfb814c..1b95fa7e1a46 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1138,7 +1138,7 @@ static int navi10_dpm_set_vcn_enable(struct smu_context *smu,
 		}
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PowerDownVcn, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_PowerDownVcn);
 			if (ret)
 				return ret;
 		}
@@ -1153,13 +1153,13 @@ static int navi10_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 
 	if (enable) {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PowerUpJpeg, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_PowerUpJpeg);
 			if (ret)
 				return ret;
 		}
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PowerDownJpeg, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_PowerDownJpeg);
 			if (ret)
 				return ret;
 		}
@@ -2553,7 +2553,7 @@ static int navi10_run_btc(struct smu_context *smu)
 {
 	int ret = 0;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_RunBtc, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_RunBtc);
 	if (ret)
 		dev_err(smu->adev->dev, "RunBtc failed!\n");
 
@@ -2617,7 +2617,7 @@ static int navi10_umc_hybrid_cdr_workaround(struct smu_context *smu)
 	 * In this case, SMU already disabled dummy pstate during enablement
 	 * of UCLK DPM, we have to re-enabled it.
 	 */
-	return smu_cmn_send_smc_msg(smu, SMU_MSG_DAL_ENABLE_DUMMY_PSTATE_CHANGE, NULL);
+	return smu_cmn_send_msg(smu, SMU_MSG_DAL_ENABLE_DUMMY_PSTATE_CHANGE);
 }
 
 static int navi10_set_dummy_pstates_table_location(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 6268bc5ed3e6..39000c053203 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2436,7 +2436,7 @@ static int sienna_cichlid_run_btc(struct smu_context *smu)
 {
 	int res;
 
-	res = smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
+	res = smu_cmn_send_msg(smu, SMU_MSG_RunDcBtc);
 	if (res)
 		dev_err(smu->adev->dev, "RunDcBtc failed!\n");
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 56efcfa327df..fc09957e9b60 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -775,8 +775,8 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 int smu_v11_0_system_features_control(struct smu_context *smu,
 					     bool en)
 {
-	return smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
-					  SMU_MSG_DisableAllSmuFeatures), NULL);
+	return smu_cmn_send_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
+					  SMU_MSG_DisableAllSmuFeatures));
 }
 
 int smu_v11_0_notify_display_change(struct smu_context *smu)
@@ -981,9 +981,8 @@ int smu_v11_0_set_power_limit(struct smu_context *smu,
 
 static int smu_v11_0_ack_ac_dc_interrupt(struct smu_context *smu)
 {
-	return smu_cmn_send_smc_msg(smu,
-				SMU_MSG_ReenableAcDcInterrupt,
-				NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_ReenableAcDcInterrupt);
 }
 
 static int smu_v11_0_process_pending_interrupt(struct smu_context *smu)
@@ -1122,9 +1121,9 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_AllowGfxOff, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_AllowGfxOff);
 		else
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_DisallowGfxOff, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_DisallowGfxOff);
 		break;
 	default:
 		break;
@@ -1554,7 +1553,7 @@ int smu_v11_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 
 int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu)
 {
-	return smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
+	return smu_cmn_send_msg(smu, SMU_MSG_BacoAudioD3PME);
 }
 
 int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu,
@@ -1647,7 +1646,7 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 		}
 
 	} else {
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_ExitBaco, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_ExitBaco);
 		if (ret)
 			return ret;
 
@@ -1695,7 +1694,7 @@ int smu_v11_0_mode1_reset(struct smu_context *smu)
 {
 	int ret = 0;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_Mode1Reset);
 	if (!ret)
 		msleep(SMU11_MODE1_RESET_WAIT_TIME_IN_MS);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 08179840697e..d67104f52496 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2241,7 +2241,7 @@ static int vangogh_post_smu_init(struct smu_context *smu)
 	/* allow message will be sent after enable message on Vangogh*/
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
 			(adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOff, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_EnableGfxOff);
 		if (ret) {
 			dev_err(adev->dev, "Failed to Enable GfxOff!\n");
 			return ret;
@@ -2330,7 +2330,7 @@ static int vangogh_get_power_limit(struct smu_context *smu,
 	if (smu->adev->pm.fw_version < 0x43f1e00)
 		return ret;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSlowPPTLimit, &ppt_limit);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GetSlowPPTLimit, &ppt_limit);
 	if (ret) {
 		dev_err(smu->adev->dev, "Get slow PPT limit failed!\n");
 		return ret;
@@ -2345,7 +2345,7 @@ static int vangogh_get_power_limit(struct smu_context *smu,
 	if (min_power_limit)
 		*min_power_limit = 0;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPPTLimit, &ppt_limit);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GetFastPPTLimit, &ppt_limit);
 	if (ret) {
 		dev_err(smu->adev->dev, "Get fast PPT limit failed!\n");
 		return ret;
@@ -2503,7 +2503,7 @@ static u32 vangogh_get_gfxoff_entrycount(struct smu_context *smu, uint64_t *entr
 	if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 		return 0;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetGfxOffEntryCount, &value);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GetGfxOffEntryCount, &value);
 	*entrycount = value + adev->gfx.gfx_off_entrycount;
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 31e21ff8859a..f46269075ee2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -318,7 +318,7 @@ static int renoir_get_dpm_ultimate_freq(struct smu_context *smu,
 		switch (clk_type) {
 		case SMU_GFXCLK:
 		case SMU_SCLK:
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetMaxGfxclkFrequency, max);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_GetMaxGfxclkFrequency, max);
 			if (ret) {
 				dev_err(smu->adev->dev, "Attempt to get max GX frequency from SMC Failed !\n");
 				goto failed;
@@ -346,7 +346,7 @@ static int renoir_get_dpm_ultimate_freq(struct smu_context *smu,
 		switch (clk_type) {
 		case SMU_GFXCLK:
 		case SMU_SCLK:
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetMinGfxclkFrequency, min);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_GetMinGfxclkFrequency, min);
 			if (ret) {
 				dev_err(smu->adev->dev, "Attempt to get min GX frequency from SMC Failed !\n");
 				goto failed;
@@ -649,7 +649,7 @@ static int renoir_dpm_set_vcn_enable(struct smu_context *smu,
 		}
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PowerDownVcn, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_PowerDownVcn);
 			if (ret)
 				return ret;
 		}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index 2c20624caca4..173efa51809d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -113,9 +113,9 @@ int smu_v12_0_powergate_sdma(struct smu_context *smu, bool gate)
 		return 0;
 
 	if (gate)
-		return smu_cmn_send_smc_msg(smu, SMU_MSG_PowerDownSdma, NULL);
+		return smu_cmn_send_msg(smu, SMU_MSG_PowerDownSdma);
 	else
-		return smu_cmn_send_smc_msg(smu, SMU_MSG_PowerUpSdma, NULL);
+		return smu_cmn_send_msg(smu, SMU_MSG_PowerUpSdma);
 }
 
 int smu_v12_0_set_gfx_cgpg(struct smu_context *smu, bool enable)
@@ -160,10 +160,10 @@ int smu_v12_0_gfx_off_control(struct smu_context *smu, bool enable)
 	int ret = 0, timeout = 500;
 
 	if (enable) {
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_AllowGfxOff, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_AllowGfxOff);
 
 	} else {
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_DisallowGfxOff, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_DisallowGfxOff);
 
 		/* confirm gfx is back to "on" state, timeout is 0.5 second */
 		while (!(smu_v12_0_get_gfxoff_status(smu) == 2)) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 259e5a13c1bd..5ffd4ca69499 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -560,7 +560,7 @@ static int aldebaran_run_board_btc(struct smu_context *smu)
 	if (smu->smc_fw_version <= 0x00441d00)
 		return 0;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_BoardPowerCalibration, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_BoardPowerCalibration);
 	if (ret)
 		dev_err(smu->adev->dev, "Board power calibration failed!\n");
 
@@ -571,7 +571,7 @@ static int aldebaran_run_btc(struct smu_context *smu)
 {
 	int ret;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_RunDcBtc);
 	if (ret)
 		dev_err(smu->adev->dev, "RunDcBtc failed!\n");
 	else
@@ -1139,8 +1139,8 @@ static int aldebaran_get_power_limit(struct smu_context *smu,
 	 * For secondary die show the value as 0.
 	 */
 	if (aldebaran_is_primary(smu)) {
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetPptLimit,
-					   &power_limit);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_GetPptLimit,
+				       &power_limit);
 
 		if (ret) {
 			/* the last hope to figure out the ppt limit */
@@ -1203,7 +1203,7 @@ static int aldebaran_set_performance_level(struct smu_context *smu,
 	/* Disable determinism if switching to another mode */
 	if ((smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) &&
 	    (level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)) {
-		smu_cmn_send_smc_msg(smu, SMU_MSG_DisableDeterminism, NULL);
+		smu_cmn_send_msg(smu, SMU_MSG_DisableDeterminism);
 		pstate_table->gfxclk_pstate.curr.max =
 			SMU_DPM_TABLE_MAX(gfx_table);
 	}
@@ -1806,7 +1806,7 @@ static int aldebaran_mode1_reset(struct smu_context *smu)
 	* PM FW support SMU_MSG_GfxDeviceDriverReset from 68.07
 	*/
 	if (smu->smc_fw_version < 0x00440700) {
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_Mode1Reset);
 	} else {
 		/* fatal error triggered by ras, PMFW supports the flag
 		   from 68.44.0 */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index cf3781aba02a..406440b4949b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -754,9 +754,9 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_AllowGfxOff, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_AllowGfxOff);
 		else
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_DisallowGfxOff, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_DisallowGfxOff);
 		break;
 	default:
 		break;
@@ -768,8 +768,8 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
 int smu_v13_0_system_features_control(struct smu_context *smu,
 				      bool en)
 {
-	return smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
-					  SMU_MSG_DisableAllSmuFeatures), NULL);
+	return smu_cmn_send_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
+					  SMU_MSG_DisableAllSmuFeatures));
 }
 
 int smu_v13_0_notify_display_change(struct smu_context *smu)
@@ -777,7 +777,7 @@ int smu_v13_0_notify_display_change(struct smu_context *smu)
 	int ret = 0;
 
 	if (!amdgpu_device_has_dc_support(smu->adev))
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_DALNotPresent, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_DALNotPresent);
 
 	return ret;
 }
@@ -951,9 +951,7 @@ int smu_v13_0_set_power_limit(struct smu_context *smu,
 
 static int smu_v13_0_allow_ih_interrupt(struct smu_context *smu)
 {
-	return smu_cmn_send_smc_msg(smu,
-				    SMU_MSG_AllowIHHostInterrupt,
-				    NULL);
+	return smu_cmn_send_msg(smu, SMU_MSG_AllowIHHostInterrupt);
 }
 
 static int smu_v13_0_process_pending_interrupt(struct smu_context *smu)
@@ -1210,9 +1208,7 @@ static int smu_v13_0_set_irq_state(struct amdgpu_device *adev,
 
 void smu_v13_0_interrupt_work(struct smu_context *smu)
 {
-	smu_cmn_send_smc_msg(smu,
-			     SMU_MSG_ReenableAcDcInterrupt,
-			     NULL);
+	smu_cmn_send_msg(smu, SMU_MSG_ReenableAcDcInterrupt);
 }
 
 #define THM_11_0__SRCID__THM_DIG_THERM_L2H		0		/* ASIC_TEMP > CG_THERMAL_INT.DIG_THERM_INTH  */
@@ -1406,7 +1402,7 @@ int smu_v13_0_set_azalia_d3_pme(struct smu_context *smu)
 {
 	int ret = 0;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_BacoAudioD3PME);
 
 	return ret;
 }
@@ -1417,7 +1413,7 @@ static int smu_v13_0_wait_for_reset_complete(struct smu_context *smu,
 	int ret = 0;
 
 	dev_dbg(smu->adev->dev, "waiting for smu reset complete\n");
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GfxDriverResetRecovery, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GfxDriverResetRecovery);
 
 	return ret;
 }
@@ -1973,7 +1969,7 @@ int smu_v13_0_run_btc(struct smu_context *smu)
 {
 	int res;
 
-	res = smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
+	res = smu_cmn_send_msg(smu, SMU_MSG_RunDcBtc);
 	if (res)
 		dev_err(smu->adev->dev, "RunDcBtc failed!\n");
 
@@ -2125,9 +2121,7 @@ static int smu_v13_0_baco_set_state(struct smu_context *smu,
 						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
 						      NULL);
 	} else {
-		ret = smu_cmn_send_smc_msg(smu,
-					   SMU_MSG_ExitBaco,
-					   NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_ExitBaco);
 		if (ret)
 			return ret;
 
@@ -2332,7 +2326,7 @@ int smu_v13_0_mode1_reset(struct smu_context *smu)
 {
 	int ret = 0;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_Mode1Reset);
 	if (!ret)
 		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index f5940e77077a..4fa7f87b4de8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2833,7 +2833,7 @@ static int smu_v13_0_0_mode1_reset(struct smu_context *smu)
 		break;
 
 	default:
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_Mode1Reset);
 		break;
 	}
 
@@ -2854,7 +2854,7 @@ static int smu_v13_0_0_mode2_reset(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 
 	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10))
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode2Reset, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_Mode2Reset);
 	else
 		return -EOPNOTSUPP;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 67cd186bd263..834e7ef8079f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -301,8 +301,8 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 		if (ret)
 			return ret;
 
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetMetricsVersion,
-					   &table_version);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_GetMetricsVersion,
+				       &table_version);
 		if (ret)
 			return ret;
 		smu_table->tables[SMU_TABLE_SMU_METRICS].version =
@@ -471,7 +471,7 @@ static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu)
 	if (smu_table_cache_is_valid(sys_table))
 		return 0;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetricsTable, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GetSystemMetricsTable);
 	if (ret) {
 		dev_info(smu->adev->dev,
 			 "Failed to export system metrics table!\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 167b3499f7f1..85e34c890672 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -241,7 +241,7 @@ static int smu_v13_0_4_system_features_control(struct smu_context *smu, bool en)
 				return ret;
 		}
 
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_PrepareMp1ForUnload);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 141e778333c5..ed6fa13f3119 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -191,7 +191,7 @@ static int smu_v13_0_5_system_features_control(struct smu_context *smu, bool en)
 	int ret = 0;
 
 	if (!en && !adev->in_s0ix)
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_PrepareMp1ForUnload);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 5b9580034641..7c1fcbba11ff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -769,7 +769,7 @@ int smu_v13_0_6_get_metrics_table(struct smu_context *smu, void *metrics_table,
 	if (bypass_cache || !smu_table->metrics_time ||
 	    time_after(jiffies,
 		       smu_table->metrics_time + msecs_to_jiffies(1))) {
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetMetricsTable, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_GetMetricsTable);
 		if (ret) {
 			dev_info(smu->adev->dev,
 				 "Failed to export SMU metrics table!\n");
@@ -848,7 +848,7 @@ int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
 	struct smu_table *table = &smu_table->driver_table;
 	int ret;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetStaticMetricsTable, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GetStaticMetricsTable);
 	if (ret) {
 		dev_info(smu->adev->dev,
 				"Failed to export static metrics table!\n");
@@ -912,8 +912,8 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 		if (!retry)
 			return -ETIME;
 
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetMetricsVersion,
-					   &table_version);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_GetMetricsVersion,
+				       &table_version);
 		if (ret)
 			return ret;
 		smu_table->tables[SMU_TABLE_SMU_METRICS].version =
@@ -1040,8 +1040,8 @@ static int smu_v13_0_6_get_dpm_ultimate_freq(struct smu_context *smu,
 
 	if (max) {
 		if (clk_type == SMU_GFXCLK || clk_type == SMU_SCLK)
-			ret = smu_cmn_send_smc_msg(
-				smu, SMU_MSG_GetMaxGfxclkFrequency, max);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_GetMaxGfxclkFrequency, max);
 		else
 			ret = smu_cmn_send_smc_msg_with_param(
 				smu, SMU_MSG_GetMaxDpmFreq, param, max);
@@ -1051,8 +1051,8 @@ static int smu_v13_0_6_get_dpm_ultimate_freq(struct smu_context *smu,
 
 	if (min) {
 		if (clk_type == SMU_GFXCLK || clk_type == SMU_SCLK)
-			ret = smu_cmn_send_smc_msg(
-				smu, SMU_MSG_GetMinGfxclkFrequency, min);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_GetMinGfxclkFrequency, min);
 		else
 			ret = smu_cmn_send_smc_msg_with_param(
 				smu, SMU_MSG_GetMinDpmFreq, param, min);
@@ -1707,7 +1707,7 @@ static int smu_v13_0_6_get_power_limit(struct smu_context *smu,
 	uint32_t power_limit = 0;
 	int ret;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetPptLimit, &power_limit);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GetPptLimit, &power_limit);
 
 	if (ret) {
 		dev_err(smu->adev->dev, "Couldn't get PPT limit");
@@ -1774,7 +1774,7 @@ static int smu_v13_0_6_get_ppt_limit(struct smu_context *smu,
 			*ppt_limit = pptable->PPT1Max;
 			break;
 		case SMU_PPT_LIMIT_CURRENT:
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPptLimit, ppt_limit);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_GetFastPptLimit, ppt_limit);
 			if (ret)
 				dev_err(smu->adev->dev, "Get fast PPT limit failed!\n");
 			break;
@@ -1914,7 +1914,7 @@ static int smu_v13_0_6_notify_unload(struct smu_context *smu)
 
 	dev_dbg(smu->adev->dev, "Notify PMFW about driver unload");
 	/* Ignore return, just intimate FW that driver is not going to be there */
-	smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
+	smu_cmn_send_msg(smu, SMU_MSG_PrepareMp1ForUnload);
 
 	return 0;
 }
@@ -1980,7 +1980,7 @@ static int smu_v13_0_6_set_performance_level(struct smu_context *smu,
 	/* Disable determinism if switching to another mode */
 	if ((smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) &&
 	    (level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)) {
-		smu_cmn_send_smc_msg(smu, SMU_MSG_DisableDeterminism, NULL);
+		smu_cmn_send_msg(smu, SMU_MSG_DisableDeterminism);
 		pstate_table->gfxclk_pstate.curr.max =
 			SMU_DPM_TABLE_MAX(gfx_table);
 	}
@@ -2323,8 +2323,7 @@ static int smu_v13_0_6_request_i2c_xfer(struct smu_context *smu,
 	memcpy(table->cpu_addr, table_data, table_size);
 	/* Flush hdp cache */
 	amdgpu_hdp_flush(adev, NULL);
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_RequestI2cTransaction,
-					  NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_RequestI2cTransaction);
 
 	return ret;
 }
@@ -3098,7 +3097,7 @@ static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
 	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(RMA_MSG)))
 		return 0;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_RmaDueToBadPageThreshold, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_RmaDueToBadPageThreshold);
 	if (ret)
 		dev_err(smu->adev->dev,
 			"[%s] failed to send BadPageThreshold event to SMU\n",
@@ -3231,7 +3230,7 @@ static int smu_v13_0_6_get_valid_mca_count(struct smu_context *smu, enum amdgpu_
 		return -EINVAL;
 	}
 
-	ret = smu_cmn_send_smc_msg(smu, msg, count);
+	ret = smu_cmn_send_msg(smu, msg, count);
 	if (ret) {
 		*count = 0;
 		return ret;
@@ -3696,7 +3695,7 @@ static int smu_v13_0_6_get_valid_aca_count(struct smu_context *smu, enum aca_smu
 		return -EINVAL;
 	}
 
-	ret = smu_cmn_send_smc_msg(smu, msg, count);
+	ret = smu_cmn_send_msg(smu, msg, count);
 	if (ret) {
 		*count = 0;
 		return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 748b5b074fff..bcf472e5b415 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -218,7 +218,7 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
 	int ret = 0;
 
 	if (!en && !adev->in_s0ix)
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_PrepareMp1ForUnload);
 
 	return ret;
 }
@@ -276,7 +276,7 @@ static int yellow_carp_post_smu_init(struct smu_context *smu)
 	int ret = 0;
 
 	/* allow message will be sent after enable message on Yellow Carp*/
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOff, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_EnableGfxOff);
 	if (ret)
 		dev_err(adev->dev, "Failed to Enable GfxOff!\n");
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 7dc6687c3693..510a31945f1d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -778,9 +778,9 @@ int smu_v14_0_gfx_off_control(struct smu_context *smu, bool enable)
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_AllowGfxOff, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_AllowGfxOff);
 		else
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_DisallowGfxOff, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_DisallowGfxOff);
 		break;
 	default:
 		break;
@@ -792,8 +792,8 @@ int smu_v14_0_gfx_off_control(struct smu_context *smu, bool enable)
 int smu_v14_0_system_features_control(struct smu_context *smu,
 				      bool en)
 {
-	return smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
-					  SMU_MSG_DisableAllSmuFeatures), NULL);
+	return smu_cmn_send_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
+					  SMU_MSG_DisableAllSmuFeatures));
 }
 
 int smu_v14_0_notify_display_change(struct smu_context *smu)
@@ -1069,7 +1069,7 @@ static int smu_v14_0_wait_for_reset_complete(struct smu_context *smu,
 	int ret = 0;
 
 	dev_dbg(smu->adev->dev, "waiting for smu reset complete\n");
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GfxDriverResetRecovery, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GfxDriverResetRecovery);
 
 	return ret;
 }
@@ -1621,7 +1621,7 @@ int smu_v14_0_run_btc(struct smu_context *smu)
 {
 	int res;
 
-	res = smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
+	res = smu_cmn_send_msg(smu, SMU_MSG_RunDcBtc);
 	if (res)
 		dev_err(smu->adev->dev, "RunDcBtc failed!\n");
 
@@ -1796,9 +1796,7 @@ int smu_v14_0_baco_set_state(struct smu_context *smu,
 						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
 						      NULL);
 	} else {
-		ret = smu_cmn_send_smc_msg(smu,
-					   SMU_MSG_ExitBaco,
-					   NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_ExitBaco);
 		if (ret)
 			return ret;
 
@@ -1949,9 +1947,7 @@ int smu_v14_0_od_edit_dpm_table(struct smu_context *smu,
 
 static int smu_v14_0_allow_ih_interrupt(struct smu_context *smu)
 {
-	return smu_cmn_send_smc_msg(smu,
-				    SMU_MSG_AllowIHHostInterrupt,
-				    NULL);
+	return smu_cmn_send_msg(smu, SMU_MSG_AllowIHHostInterrupt);
 }
 
 int smu_v14_0_enable_thermal_alert(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index dbdf7653cc53..0be0b11be79a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -252,7 +252,7 @@ static int smu_v14_0_0_system_features_control(struct smu_context *smu, bool en)
 	int ret = 0;
 
 	if (!en && !adev->in_s0ix)
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_PrepareMp1ForUnload);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 478ee87af51f..69e9c4804461 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -690,9 +690,9 @@ int smu_v15_0_gfx_off_control(struct smu_context *smu, bool enable)
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_AllowGfxOff, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_AllowGfxOff);
 		else
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_DisallowGfxOff, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_DisallowGfxOff);
 		break;
 	default:
 		break;
@@ -704,7 +704,7 @@ int smu_v15_0_gfx_off_control(struct smu_context *smu, bool enable)
 int smu_v15_0_system_features_control(struct smu_context *smu,
 				      bool en)
 {
-	return smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
+	return smu_cmn_send_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
 					  SMU_MSG_DisableAllSmuFeatures), NULL);
 }
 
@@ -901,7 +901,7 @@ static int smu_v15_0_wait_for_reset_complete(struct smu_context *smu,
 	int ret = 0;
 
 	dev_dbg(smu->adev->dev, "waiting for smu reset complete\n");
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GfxDriverResetRecovery, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GfxDriverResetRecovery, NULL);
 
 	return ret;
 }
@@ -1443,7 +1443,7 @@ int smu_v15_0_run_btc(struct smu_context *smu)
 {
 	int res;
 
-	res = smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
+	res = smu_cmn_send_msg(smu, SMU_MSG_RunDcBtc);
 	if (res)
 		dev_err(smu->adev->dev, "RunDcBtc failed!\n");
 
@@ -1618,7 +1618,7 @@ int smu_v15_0_baco_set_state(struct smu_context *smu,
 						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
 						      NULL);
 	} else {
-		ret = smu_cmn_send_smc_msg(smu,
+		ret = smu_cmn_send_msg(smu,
 					   SMU_MSG_ExitBaco,
 					   NULL);
 		if (ret)
@@ -1758,7 +1758,7 @@ int smu_v15_0_od_edit_dpm_table(struct smu_context *smu,
 
 static int smu_v15_0_allow_ih_interrupt(struct smu_context *smu)
 {
-	return smu_cmn_send_smc_msg(smu,
+	return smu_cmn_send_msg(smu,
 				    SMU_MSG_AllowIHHostInterrupt,
 				    NULL);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 9a4a5f482e75..80ba197664f1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -228,7 +228,7 @@ static int smu_v15_0_0_system_features_control(struct smu_context *smu, bool en)
 	int ret = 0;
 
 	if (!en && !adev->in_s0ix)
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_PrepareMp1ForUnload);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index bc2ac5ae6a48..5438c4a16357 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -183,16 +183,6 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	return ret;
 }
 
-int smu_cmn_send_smc_msg(struct smu_context *smu,
-			 enum smu_message_type msg,
-			 uint32_t *read_arg)
-{
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       msg,
-					       0,
-					       read_arg);
-}
-
 static inline int smu_cmn_send_msg_internal(struct smu_context *smu, enum smu_message_type msg,
 					    int num_in_args, u32 *in_args,
 					    int num_out_args, u32 *out_args)
@@ -863,12 +853,12 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 		ret = smu_cmn_send_smc_msg_with_param(
 			smu, SMU_MSG_GetEnabledSmuFeatures, 1, &features[1]);
 	} else {
-		ret = smu_cmn_send_smc_msg(
+		ret = smu_cmn_send_msg(
 			smu, SMU_MSG_GetEnabledSmuFeaturesHigh, &features[1]);
 		if (ret)
 			return ret;
 
-		ret = smu_cmn_send_smc_msg(
+		ret = smu_cmn_send_msg(
 			smu, SMU_MSG_GetEnabledSmuFeaturesLow, &features[0]);
 	}
 
@@ -1096,7 +1086,7 @@ int smu_cmn_get_smc_version(struct smu_context *smu,
 	}
 
 	if (if_version) {
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetDriverIfVersion, if_version);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_GetDriverIfVersion, if_version);
 		if (ret)
 			return ret;
 
@@ -1104,7 +1094,7 @@ int smu_cmn_get_smc_version(struct smu_context *smu,
 	}
 
 	if (smu_version) {
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSmuVersion, smu_version);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_GetSmuVersion, smu_version);
 		if (ret)
 			return ret;
 
@@ -1274,7 +1264,7 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,
 		return 0;
 	}
 
-	ret = smu_cmn_send_smc_msg(smu, msg, NULL);
+	ret = smu_cmn_send_msg(smu, msg);
 	if (ret)
 		dev_err(smu->adev->dev, "[PrepareMp1] Failed!\n");
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index f48356c22dbb..eb1862df4860 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -115,10 +115,6 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    uint32_t param,
 				    uint32_t *read_arg);
 
-int smu_cmn_send_smc_msg(struct smu_context *smu,
-			 enum smu_message_type msg,
-			 uint32_t *read_arg);
-
 int smu_cmn_send_debug_smc_msg(struct smu_context *smu,
 			 uint32_t msg);
 
-- 
2.47.3

