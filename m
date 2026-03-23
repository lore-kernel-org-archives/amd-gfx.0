Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B11FC72C5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 23:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C8310E375;
	Mon, 23 Mar 2026 23:12:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P4S+etrR";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012003.outbound.protection.outlook.com
 [40.93.195.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49F210E375
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 23:12:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8BAn9SKbK/1nFfo1/X1cenKkFATSdLbyvYGiE6opGcL2ujHxJnHFDu/5C9/55ReC5daTuqmvPYmg/bFKQJE9NprFqgVDjU63YNLUxuObt3E8ANOh71Wn8kcuYsqgGp0VSYguklxCUac42NhtRdlNkPLu0sZuH6YGZK9zO1F5JyWSkrZqNM9y6/poddtdMtRFBmzHDOP5AxixUWyhmG23DS1GQ31ahF74V8BYWVGxnEgyiz88yo9NxpG2b4+bk0YjTV5UIeGwUZgHjooZ4K+GP2aiOxqR5vZDHwn+LdACB9hdZEr6xFl4CEX+/xywj9wlZTkyIvCf7o0ZDWCxCwtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0etNn20LFad2oL20qrRqMlZGxcMHs9+NdskSa8P9tw=;
 b=W1VMYteqQBVdlB0s8R5TdMPWv7SS+JQnIsftgovXizU6vtrGCPUuvAMLTinuZE72+P6PxZsIzuw+oZ/qQ0t2MtolI+VC5PlcHyxmbnrQvDTY4W22/zJmMH9mJEMMJFo/YqNlOJNqIE6l3MX1xlGVZpVyN5LBQIq5yIzMC9ITYuLWg+/y6PYw9niJLvpF8cIOwVYPNMwGxn+mceg7Z8nWPgJ9jCVO46cO6Ria2YKMo2mzGq3hDK7/OMTb1hjVqXtw2A1dUM7p5QO8Q3mhH4VnEybG+e7Lc2OqNAYUWZsxkG8sUfEmyQbLDFnQFLHeizxVV3KB4pCraUSNCMEEACNbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0etNn20LFad2oL20qrRqMlZGxcMHs9+NdskSa8P9tw=;
 b=P4S+etrRsSvybaNmhDGpjCAE2DHiboNErcNcdTVn2Wyix7v5Pm1d3vpxtwXdbGsBdZ3ahQkK2x3EWQprly8uFXP3La8mM4qSCvCPeyfTpA+/k1mfmAD9FXZs9wvrFBkF3AABb/YZwYKFH79p80w+R0ZXoa9k5a2ufz5h7YsP0OQ=
Received: from SJ0PR03CA0225.namprd03.prod.outlook.com (2603:10b6:a03:39f::20)
 by CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 23:12:23 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::81) by SJ0PR03CA0225.outlook.office365.com
 (2603:10b6:a03:39f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 23:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 23:12:22 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 18:12:19 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 2/4] drm/amd/pm: replace legacy smu_cmn_send_smc_msg() with
 smu_cmn_send_msg()
Date: Mon, 23 Mar 2026 19:12:04 -0400
Message-ID: <20260323231206.722067-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323231206.722067-1-kevinyang.wang@amd.com>
References: <20260323231206.722067-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: a21901a9-43a0-4dc9-8aa8-08de8931a3e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2y/k4M5TNzy4nD2Nem0O3QGfEmQugWLldhaG59iBkV9lyceS/jkerXEoe1IiptZMPvRNXHU98f6woEq5XILV7f5ljXXxjpsI67uQSeerhPYTBc2jOxmVR3uJwvG9Xkkgf7wsAwd5SyoS+r0FcP4BcPqoRAp/wdxF6rJAuVL0f9YbVaGU7R0gQ7ITZ4E9otwFy3UNlVo14RAyp+99d1pgqdvqtQriY0Ccpg6FbO+nLx+iF+KmnIVgMG4Bv+K1ifKG4T1oO5Rkx9mHF9AoEEmLZ/tRa5gdHb/BXCMWTaaO4BStRGSG/9o6Y3oY8Ic9Ibi8z30sfQP+WFIq30iMrtf2SjEQa+QHpYpdxRU0VrFjJiCq1+0qZXQ1evuKkAt9xtwbu8OaBU/bVlRFk0AlqSUGTfYwbH5X50DJdl5i3M+Sis2BdOIOdQOpaaW4Kc+UsadAFDMPOx7/zXdTjmbU3WqvXuSD9VVk7vWyJXrMN+nm7h0fZ8F3j70Hoqxa1QFYWtZyl5yGH02tFuJUn2MC9aQr3FhywU3hc30mhJRCk0grx232/j/b3HhRwwjEddR4MHvlxld1MjbEhbmhYTPu7I+J8i2HYOJqVoD67cBxAQd433h073Rj4m8SconUzL2QNUbDKlXRLV+3yePuyXVyd+Soa8ehFsFWfA5jpsVCyptwwBmV1ZtZ5yaKY5O61KTNAOiefddM4f4AsoNkXAIUo17OMOhL7soKZbSWT/hk5xGsGhV9Ve72Qup33j5UGh6KWp3mQcOCmhK3hm9mmuL7nlkysA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4sDJS+AT7ohZoh/n2QUfkkv6q3cuQClP2o/k6NGGdEraIJoX6EUroTmf8NH3UFdOBonLQzch/tUb8t0gW70Wbx3o+rB42BaAW/YEZ0CSRqcFtJJrb1gul+58C2E0lywTWiksjr9DVvFBMAHuuTFA6hhcRz+rzeI/FsKcrTxw6zJZ1juKKGKbRmI+kdKmJlsNixym7Ea41iib/AUGGBj0ekQdwya1QiT0jRQnfUpICxtCzN2F8mPjmmx/P8//A12SrkjuTkrVGSwzZBG5PrIThnXwR2D1zAgos1caEC0MLSSGonk+KDBWzYzK/hxfcbGcz715u3Wt042+hq+811cBRco3N2FiNP3YKikfZdXxV9GvU4wyhiwOj2G3QHnvHeBza2ZSAQFsycxVp1dMCtqOPnildA5dylFV4aBseI4Yt3jdCp3dHHwYpcWaPhizEzFZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 23:12:22.8649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a21901a9-43a0-4dc9-8aa8-08de8931a3e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129
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
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 18 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 20 +++--------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  4 ---
 23 files changed, 105 insertions(+), 131 deletions(-)

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
index 1eec1a88e05f..210134ee1437 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -774,8 +774,8 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 int smu_v11_0_system_features_control(struct smu_context *smu,
 					     bool en)
 {
-	return smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
-					  SMU_MSG_DisableAllSmuFeatures), NULL);
+	return smu_cmn_send_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
+					  SMU_MSG_DisableAllSmuFeatures));
 }
 
 int smu_v11_0_notify_display_change(struct smu_context *smu)
@@ -980,9 +980,8 @@ int smu_v11_0_set_power_limit(struct smu_context *smu,
 
 static int smu_v11_0_ack_ac_dc_interrupt(struct smu_context *smu)
 {
-	return smu_cmn_send_smc_msg(smu,
-				SMU_MSG_ReenableAcDcInterrupt,
-				NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_ReenableAcDcInterrupt);
 }
 
 static int smu_v11_0_process_pending_interrupt(struct smu_context *smu)
@@ -1121,9 +1120,9 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
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
@@ -1553,7 +1552,7 @@ int smu_v11_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 
 int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu)
 {
-	return smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
+	return smu_cmn_send_msg(smu, SMU_MSG_BacoAudioD3PME);
 }
 
 int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu,
@@ -1646,7 +1645,7 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 		}
 
 	} else {
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_ExitBaco, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_ExitBaco);
 		if (ret)
 			return ret;
 
@@ -1694,7 +1693,7 @@ int smu_v11_0_mode1_reset(struct smu_context *smu)
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
index ac5e44dff6c9..0bd36b465cae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -112,9 +112,9 @@ int smu_v12_0_powergate_sdma(struct smu_context *smu, bool gate)
 		return 0;
 
 	if (gate)
-		return smu_cmn_send_smc_msg(smu, SMU_MSG_PowerDownSdma, NULL);
+		return smu_cmn_send_msg(smu, SMU_MSG_PowerDownSdma);
 	else
-		return smu_cmn_send_smc_msg(smu, SMU_MSG_PowerUpSdma, NULL);
+		return smu_cmn_send_msg(smu, SMU_MSG_PowerUpSdma);
 }
 
 int smu_v12_0_set_gfx_cgpg(struct smu_context *smu, bool enable)
@@ -159,10 +159,10 @@ int smu_v12_0_gfx_off_control(struct smu_context *smu, bool enable)
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
index d8a1c402a624..4cce12f3d783 100644
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
index ab81582e46aa..e8f8917654eb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2864,7 +2864,7 @@ static int smu_v13_0_0_mode1_reset(struct smu_context *smu)
 		break;
 
 	default:
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_Mode1Reset);
 		break;
 	}
 
@@ -2885,7 +2885,7 @@ static int smu_v13_0_0_mode2_reset(struct smu_context *smu)
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
index f76665c85bc3..1266867108e5 100644
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
@@ -1722,7 +1722,7 @@ static int smu_v13_0_6_get_power_limit(struct smu_context *smu,
 	uint32_t power_limit = 0;
 	int ret;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetPptLimit, &power_limit);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GetPptLimit, &power_limit);
 
 	if (ret) {
 		dev_err(smu->adev->dev, "Couldn't get PPT limit");
@@ -1789,7 +1789,7 @@ static int smu_v13_0_6_get_ppt_limit(struct smu_context *smu,
 			*ppt_limit = pptable->PPT1Max;
 			break;
 		case SMU_PPT_LIMIT_CURRENT:
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPptLimit, ppt_limit);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_GetFastPptLimit, ppt_limit);
 			if (ret)
 				dev_err(smu->adev->dev, "Get fast PPT limit failed!\n");
 			break;
@@ -1929,7 +1929,7 @@ static int smu_v13_0_6_notify_unload(struct smu_context *smu)
 
 	dev_dbg(smu->adev->dev, "Notify PMFW about driver unload");
 	/* Ignore return, just intimate FW that driver is not going to be there */
-	smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
+	smu_cmn_send_msg(smu, SMU_MSG_PrepareMp1ForUnload);
 
 	return 0;
 }
@@ -1995,7 +1995,7 @@ static int smu_v13_0_6_set_performance_level(struct smu_context *smu,
 	/* Disable determinism if switching to another mode */
 	if ((smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) &&
 	    (level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)) {
-		smu_cmn_send_smc_msg(smu, SMU_MSG_DisableDeterminism, NULL);
+		smu_cmn_send_msg(smu, SMU_MSG_DisableDeterminism);
 		pstate_table->gfxclk_pstate.curr.max =
 			SMU_DPM_TABLE_MAX(gfx_table);
 	}
@@ -2406,8 +2406,7 @@ static int smu_v13_0_6_request_i2c_xfer(struct smu_context *smu,
 	memcpy(table->cpu_addr, table_data, table_size);
 	/* Flush hdp cache */
 	amdgpu_hdp_flush(adev, NULL);
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_RequestI2cTransaction,
-					  NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_RequestI2cTransaction);
 
 	return ret;
 }
@@ -3181,7 +3180,7 @@ static int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
 	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(RMA_MSG)))
 		return 0;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_RmaDueToBadPageThreshold, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_RmaDueToBadPageThreshold);
 	if (ret)
 		dev_err(smu->adev->dev,
 			"[%s] failed to send BadPageThreshold event to SMU\n",
@@ -3314,7 +3313,7 @@ static int smu_v13_0_6_get_valid_mca_count(struct smu_context *smu, enum amdgpu_
 		return -EINVAL;
 	}
 
-	ret = smu_cmn_send_smc_msg(smu, msg, count);
+	ret = smu_cmn_send_msg(smu, msg, count);
 	if (ret) {
 		*count = 0;
 		return ret;
@@ -3779,7 +3778,7 @@ static int smu_v13_0_6_get_valid_aca_count(struct smu_context *smu, enum aca_smu
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
index 9f01bed3970e..395626e4732c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -777,9 +777,9 @@ int smu_v14_0_gfx_off_control(struct smu_context *smu, bool enable)
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
@@ -791,8 +791,8 @@ int smu_v14_0_gfx_off_control(struct smu_context *smu, bool enable)
 int smu_v14_0_system_features_control(struct smu_context *smu,
 				      bool en)
 {
-	return smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
-					  SMU_MSG_DisableAllSmuFeatures), NULL);
+	return smu_cmn_send_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
+					  SMU_MSG_DisableAllSmuFeatures));
 }
 
 int smu_v14_0_notify_display_change(struct smu_context *smu)
@@ -1068,7 +1068,7 @@ static int smu_v14_0_wait_for_reset_complete(struct smu_context *smu,
 	int ret = 0;
 
 	dev_dbg(smu->adev->dev, "waiting for smu reset complete\n");
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GfxDriverResetRecovery, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GfxDriverResetRecovery);
 
 	return ret;
 }
@@ -1620,7 +1620,7 @@ int smu_v14_0_run_btc(struct smu_context *smu)
 {
 	int res;
 
-	res = smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
+	res = smu_cmn_send_msg(smu, SMU_MSG_RunDcBtc);
 	if (res)
 		dev_err(smu->adev->dev, "RunDcBtc failed!\n");
 
@@ -1795,9 +1795,7 @@ int smu_v14_0_baco_set_state(struct smu_context *smu,
 						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
 						      NULL);
 	} else {
-		ret = smu_cmn_send_smc_msg(smu,
-					   SMU_MSG_ExitBaco,
-					   NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_ExitBaco);
 		if (ret)
 			return ret;
 
@@ -1948,9 +1946,7 @@ int smu_v14_0_od_edit_dpm_table(struct smu_context *smu,
 
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
index 5649f2e71ac6..878dc26927f4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -671,9 +671,9 @@ int smu_v15_0_gfx_off_control(struct smu_context *smu, bool enable)
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
@@ -684,7 +684,7 @@ int smu_v15_0_gfx_off_control(struct smu_context *smu, bool enable)
 
 int smu_v15_0_system_features_control(struct smu_context *smu, bool en)
 {
-	return smu_cmn_send_smc_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
+	return smu_cmn_send_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
 					  SMU_MSG_DisableAllSmuFeatures), NULL);
 }
 
@@ -881,7 +881,7 @@ static int smu_v15_0_wait_for_reset_complete(struct smu_context *smu,
 	int ret = 0;
 
 	dev_dbg(smu->adev->dev, "waiting for smu reset complete\n");
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GfxDriverResetRecovery, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GfxDriverResetRecovery, NULL);
 
 	return ret;
 }
@@ -1417,7 +1417,7 @@ int smu_v15_0_run_btc(struct smu_context *smu)
 {
 	int res;
 
-	res = smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
+	res = smu_cmn_send_msg(smu, SMU_MSG_RunDcBtc);
 	if (res)
 		dev_err(smu->adev->dev, "RunDcBtc failed!\n");
 
@@ -1592,7 +1592,7 @@ int smu_v15_0_baco_set_state(struct smu_context *smu,
 						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
 						      NULL);
 	} else {
-		ret = smu_cmn_send_smc_msg(smu,
+		ret = smu_cmn_send_msg(smu,
 					   SMU_MSG_ExitBaco,
 					   NULL);
 		if (ret)
@@ -1732,7 +1732,7 @@ int smu_v15_0_od_edit_dpm_table(struct smu_context *smu,
 
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
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index cc2babc6a341..672f243ea0fe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -335,7 +335,7 @@ static int smu_v15_0_8_get_metrics_table_internal(struct smu_context *smu, uint3
 
 	if (!tmo || !smu_table->metrics_time ||
 	    time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(tmo))) {
-		int ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetMetricsTable, NULL);
+		int ret = smu_cmn_send_msg(smu, SMU_MSG_GetMetricsTable);
 		if (ret) {
 			dev_info(adev->dev,
 				 "Failed to export SMU metrics table!\n");
@@ -543,7 +543,7 @@ static int smu_v15_0_8_get_system_metrics_table(struct smu_context *smu)
 	if (smu_table_cache_is_valid(sys_table))
 		return 0;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetricsTable, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GetSystemMetricsTable);
 	if (ret) {
 		dev_info(smu->adev->dev,
 			 "Failed to export system metrics table!\n");
@@ -980,7 +980,7 @@ static int smu_v15_0_8_get_static_metrics_table(struct smu_context *smu)
 	struct smu_table *table = &smu_table->driver_table;
 	int ret;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetStaticMetricsTable, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GetStaticMetricsTable);
 	if (ret) {
 		dev_err(smu->adev->dev,
 			 "Failed to export static metrics table!\n");
@@ -1045,8 +1045,8 @@ static int smu_v15_0_8_set_driver_pptable(struct smu_context *smu)
 		if (ret)
 			return ret;
 
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetMetricsVersion,
-					   &table_version);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_GetMetricsVersion,
+				       &table_version);
 		if (ret)
 			return ret;
 		smu_table->tables[SMU_TABLE_SMU_METRICS].version =
@@ -1266,7 +1266,7 @@ static int smu_v15_0_8_notify_unload(struct smu_context *smu)
 
 	dev_dbg(smu->adev->dev, "Notify PMFW about driver unload");
 	/* Ignore return, just intimate FW that driver is not going to be there */
-	smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
+	smu_cmn_send_msg(smu, SMU_MSG_PrepareMp1ForUnload);
 
 	return 0;
 }
@@ -1765,7 +1765,7 @@ static int smu_v15_0_8_get_power_limit(struct smu_context *smu,
 	uint32_t power_limit = 0;
 	int ret;
 
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetPptLimit, &power_limit);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GetPptLimit, &power_limit);
 	if (ret) {
 		dev_err(smu->adev->dev, "Couldn't get PPT limit");
 		return -EINVAL;
@@ -2176,8 +2176,8 @@ static int smu_v15_0_8_get_ppt_limit(struct smu_context *smu,
 			*ppt_limit = pptable->PPT1Max;
 			break;
 		case SMU_PPT_LIMIT_CURRENT:
-			ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPptLimit,
-						   ppt_limit);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_GetFastPptLimit,
+					       ppt_limit);
 			if (ret)
 				dev_err(smu->adev->dev,
 					"Get fast PPT limit failed!\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 480d91d88957..0c95d904b5f1 100644
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
 
@@ -1270,7 +1260,7 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,
 		return 0;
 	}
 
-	ret = smu_cmn_send_smc_msg(smu, msg, NULL);
+	ret = smu_cmn_send_msg(smu, msg);
 	if (ret)
 		dev_err(smu->adev->dev, "[PrepareMp1] Failed!\n");
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 5c14ed9ed9b4..ee3f53a6a0c8 100644
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

