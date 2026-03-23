Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88A8D58CBF
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 23:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BFC710E461;
	Mon, 23 Mar 2026 23:12:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HhJFPgaw";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012033.outbound.protection.outlook.com
 [40.93.195.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DACD10E375
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 23:12:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3kIftutXKGIGUpTZjsb+BbYgitQEe1b3KUTDsXbvYBRa5mEjZcL6QHPFfLCYWbKXzfSycoXAMOOVLFctXsQhociHDpvn5CnkyZq5VAqmdHb9YVd0HfA/WBgKtB91uxKex8hr56kgYB0dq6EbElJw44YWCR2VAppBso7ss8QU+//eIUAcDFvsYtBiZIA5HcBcrRvyKedBn8FG+kyvZSwfUw5dvPSxuxwLMEA5XVHreDiOlB5d8NgTBlIVy8u+ZCmsl5N9w9/8ihKOYyIH5txybsGmdo8V8CIx7/voKGIpxGZ4eMBYyYa3CJHt4eH0kD7xDrcDmsHO05KEWNeEEllAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+LFnlLnvT6YX8+sR7trQ3GNj6jrSpG3AgXANNIG7Pg=;
 b=f9pvs7dMz3wqZJTfGd6o/a9Wrig8ftP/tbdqD4DxJuHM5sAlRWXBtnoeFC+syxAORp1ez7uDeD7auej2Tt4sdqNCpl7i3WdLdyf5mYgHEN3YMxO1j4MACGIW/FCk29iKe0XvJjlNXFTpi7sI1AF/XjXRCJTKg7WbNeivohX6wG0OEf91sU6vwp5NePQGqJMjXLPQb39vR08UH6/nMnehWA/DL0ZgTIHutAd8RDEKIcm4uU8eVtZhtYsBbomXmv/ZilElv112ynAl6uiuNT0T1SnLUI1ddof1mCs+1jcnQp2b8WhCTzk+NUgqj039slep0XoSGT0YYorvVACwXMa43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+LFnlLnvT6YX8+sR7trQ3GNj6jrSpG3AgXANNIG7Pg=;
 b=HhJFPgawJltMAqPRjDdVd3ii14N1TbNcH1DqkYS6AyKEJawzj8W6oZxWnAu7g4upVk5Fs6UPg/VeVPJ/mDeKRTHUfxA7U+obrpwBM6LtysOXnucyPo5cA7fH48Vd+m0pVNvM90dYiHZmz+iCyaGw1Jw4K4qwvtvg0yQBW6+7ius=
Received: from SJ0PR03CA0229.namprd03.prod.outlook.com (2603:10b6:a03:39f::24)
 by DS0PR12MB6488.namprd12.prod.outlook.com (2603:10b6:8:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 23:12:27 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::dd) by SJ0PR03CA0229.outlook.office365.com
 (2603:10b6:a03:39f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 23:12:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 23:12:27 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 18:12:21 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 3/4] drm/amd/pm: replace legacy
 smu_cmn_send_smc_msg_with_param() with smu_cmn_send_msg()
Date: Mon, 23 Mar 2026 19:12:05 -0400
Message-ID: <20260323231206.722067-3-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS0PR12MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: aca8f475-5fae-4a27-bdba-08de8931a66c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QbrhDUkCwu3Rtn41SLdeTL69hn4RXeucGiNh62n8NSoF856FZVzzqrduYjB0Fc0g4ftf8iE6+MdN3G5VKAAbHP+3ZuZvtxpQwRtep4/L4sipw/qpTiA0gvFD7aycNi1Ajkx+RjKecabzjFpiALx7c0netloxh5ZqGF/ZeXLsKic1L7Ez3uV68Do15c7jhz5+mSU4yacm5xNtXUO0dQ04LsrE80WJfvVL0Mv9wGBUY98qBk2lvLG72lRFvt8FZcCXyBCd2v7nxodbC7e0gL5Y9YkMFfJE+YTZAzaZ0d3tYC/SYp7cCSz/Dp1eoz0cvSU09CsoUi0vfQBkQD7uGQVwT2B838iHF9LrlfmgmTiyE1DSZbrVVQ/lEU5jqkBzQ8ypEcgBeiHp0vHEKeTZzINiRnfcDKSU8iyu2XkHM8EGBg0Epr3sP4Wpn/BpVVCahfqV8JoX+E9dz/3Icm7sLNkSVL2CgS9uProL0KOcvXlFYUCk3ujIQez70cQkMSnK840OHhBX7TFgpgFzm1/XjIfKI3Ljvo9Y9HgseNQXjsaEdfYiQitBD80UxMtLPRnEb9cd+hhvHEaukcrDMddpYhI3M8AAw336t2LUaclxYnxwek6tXOgsTuW08d0E0Th30t5lm/574AWvNqgHgq1dByXGmN0XGD9lQG55ZfETurdu4U62srCwNrEvsfu8kx3Xq2PQ2o/j61cDk+u1XOw7COU7dfiXWBk1BUVm8DULG2Mbf2DzAq24/dTS4pCqxIFjckPfB33ncvRLyH1gpOwV9nKpVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eMuSMR+UjicoZnbDlD386sfABcyawIGrziMWgfHvsrnvidYQyI/4PL4feXty/bYGGDrjhU0iYMWoFFE84KEuh1/DS/KDnjECBI2wWcElABaKLgg6YXPae5bpDF9DTSTFuu3s854BP0xcjaz/D46cNcCtwozcek3oDtOjszq66sdc+vF0iZNtHxCuvSO94odNZC3bXN9MF5IItAVamS8moKfrxfH4zhvIENYwoJE7AQ5wbAhZwIy1er/OKxE6kVUYADG+uswnVSsHHkWIwcPbbeU74r/eMGSPsquSgbGGjzx6oUQTf1YlVmRs/b+TrnHkm7kb/T8o3iIq1Vwo6QhCh0Dg/ohQQLVlf6v5WS8Xy4EafomiIfsExfE6lmVwu59703/JNn5lmbr7ZMve48WrlDK8n+RouhiQECHl1NDfWwD7m0TnIpItlEgRgJsfTxy6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 23:12:27.0935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aca8f475-5fae-4a27-bdba-08de8931a66c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488
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

Retire the legacy smu_cmn_send_smc_msg_with_param() API and replace it with the unified smu_cmn_send_msg().
This patch streamlines the change to the following sed command and standardizes code formatting:
sed -i 's/smu_cmn_send_smc_msg_with_param/smu_cmn_send_msg/g'

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  22 +-
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  60 +++---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  86 ++++----
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 170 +++++++--------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  96 ++++-----
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 140 ++++++------
 .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    |  41 ++--
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  48 ++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 198 ++++++++---------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  56 ++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  36 ++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  26 +--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  36 ++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 112 +++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  36 ++--
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  40 ++--
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 200 +++++++++---------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  54 ++---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  26 +--
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 142 ++++++-------
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  |  21 +-
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  |  12 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 102 ++-------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   5 -
 25 files changed, 848 insertions(+), 923 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 220027596937..e28a2c9bf430 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -293,11 +293,9 @@ static int arcturus_select_plpd_policy(struct smu_context *smu, int level)
 	}
 
 	if (level == XGMI_PLPD_DEFAULT)
-		return smu_cmn_send_smc_msg_with_param(
-			smu, SMU_MSG_GmiPwrDnControl, 1, NULL);
+		return smu_cmn_send_msg(smu, SMU_MSG_GmiPwrDnControl, 1, NULL);
 	else if (level == XGMI_PLPD_DISALLOW)
-		return smu_cmn_send_smc_msg_with_param(
-			smu, SMU_MSG_GmiPwrDnControl, 0, NULL);
+		return smu_cmn_send_msg(smu, SMU_MSG_GmiPwrDnControl, 0, NULL);
 	else
 		return -EINVAL;
 }
@@ -893,7 +891,7 @@ static int arcturus_upload_dpm_level(struct smu_context *smu,
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
 	    (feature_mask & FEATURE_DPM_GFXCLK_MASK)) {
 		freq = dpm_context->dpm_tables.gfx_table.dpm_levels[level].value;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 			(max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
 			(PPCLK_GFXCLK << 16) | (freq & 0xffff),
 			NULL);
@@ -907,7 +905,7 @@ static int arcturus_upload_dpm_level(struct smu_context *smu,
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
 	    (feature_mask & FEATURE_DPM_UCLK_MASK)) {
 		freq = dpm_context->dpm_tables.uclk_table.dpm_levels[level].value;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 			(max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
 			(PPCLK_UCLK << 16) | (freq & 0xffff),
 			NULL);
@@ -921,7 +919,7 @@ static int arcturus_upload_dpm_level(struct smu_context *smu,
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT) &&
 	    (feature_mask & FEATURE_DPM_SOCCLK_MASK)) {
 		freq = dpm_context->dpm_tables.soc_table.dpm_levels[level].value;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 			(max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
 			(PPCLK_SOCCLK << 16) | (freq & 0xffff),
 			NULL);
@@ -1485,10 +1483,10 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 		memset(smu->custom_profile_params, 0, ARCTURUS_CUSTOM_PARAMS_SIZE);
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_SetWorkloadMask,
-					      backend_workload_mask,
-					      NULL);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_SetWorkloadMask,
+			       backend_workload_mask,
+			       NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
 			workload_mask);
@@ -1741,7 +1739,7 @@ static int arcturus_set_df_cstate(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DFCstateControl, state, NULL);
+	return smu_cmn_send_msg(smu, SMU_MSG_DFCstateControl, state, NULL);
 }
 
 static const struct throttling_logging_label {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index e37e2388a231..3ab3491c7a39 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -504,8 +504,8 @@ static int cyan_skillfish_od_edit_dpm_table(struct smu_context *smu,
 			return -EINVAL;
 		}
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RequestGfxclk,
-					cyan_skillfish_user_settings.sclk, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_RequestGfxclk,
+				       cyan_skillfish_user_settings.sclk, NULL);
 		if (ret) {
 			dev_err(smu->adev->dev, "Set sclk failed!\n");
 			return ret;
@@ -523,7 +523,7 @@ static int cyan_skillfish_od_edit_dpm_table(struct smu_context *smu,
 			 * vid = (uint32_t)((1.55 - voltage) * 160.0 + 0.00001)
 			 */
 			vid = (1550 - cyan_skillfish_user_settings.vddc) * 160 / 1000;
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ForceGfxVid, vid, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_ForceGfxVid, vid, NULL);
 			if (ret) {
 				dev_err(smu->adev->dev, "Force vddc failed!\n");
 				return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 1b95fa7e1a46..29d1e235c13c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1132,7 +1132,7 @@ static int navi10_dpm_set_vcn_enable(struct smu_context *smu,
 	if (enable) {
 		/* vcn dpm on is a prerequisite for vcn power gate messages */
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 1, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_PowerUpVcn, 1, NULL);
 			if (ret)
 				return ret;
 		}
@@ -1585,7 +1585,7 @@ static int navi10_pre_display_config_changed(struct smu_context *smu)
 	int ret = 0;
 	uint32_t max_freq = 0;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, 0, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_NumOfDisplays, 0, NULL);
 	if (ret)
 		return ret;
 
@@ -1608,7 +1608,7 @@ static int navi10_display_config_changed(struct smu_context *smu)
 	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
 	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
 	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays,
+		ret = smu_cmn_send_msg(smu, SMU_MSG_NumOfDisplays,
 						  smu->display_config->num_display,
 						  NULL);
 		if (ret)
@@ -1861,8 +1861,8 @@ static int navi10_set_power_profile_mode(struct smu_context *smu,
 		memset(smu->custom_profile_params, 0, NAVI10_CUSTOM_PARAMS_SIZE);
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-					      backend_workload_mask, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetWorkloadMask,
+			       backend_workload_mask, NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
 			workload_mask);
@@ -1891,7 +1891,7 @@ static int navi10_notify_smc_display_config(struct smu_context *smu)
 		ret = smu_v11_0_display_clock_voltage_request(smu, &clock_req);
 		if (!ret) {
 			if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
-				ret = smu_cmn_send_smc_msg_with_param(smu,
+				ret = smu_cmn_send_msg(smu,
 								  SMU_MSG_SetMinDeepSleepDcefclk,
 								  min_clocks.dcef_clock_in_sr/100,
 								  NULL);
@@ -2214,10 +2214,10 @@ static int navi10_update_pcie_parameters(struct smu_context *smu,
 		smu_pcie_arg = i << 16;
 		smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_gen[i] << 8;
 		smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_lane[i];
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_OverridePcieParameters,
-						      smu_pcie_arg,
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_OverridePcieParameters,
+				       smu_pcie_arg,
+				       NULL);
 		if (ret)
 			return ret;
 	}
@@ -2260,10 +2260,10 @@ static int navi10_overdrive_get_gfx_clk_base_voltage(struct smu_context *smu,
 	uint32_t value = 0;
 	int ret;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					  SMU_MSG_GetVoltageByDpm,
-					  param,
-					  &value);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_GetVoltageByDpm,
+			       param,
+			       &value);
 	if (ret) {
 		dev_err(smu->adev->dev, "[GetBaseVoltage] failed to get GFXCLK AVFS voltage from SMU!");
 		return ret;
@@ -2638,17 +2638,17 @@ static int navi10_set_dummy_pstates_table_location(struct smu_context *smu)
 
 	amdgpu_hdp_flush(smu->adev, NULL);
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_SET_DRIVER_DUMMY_TABLE_DRAM_ADDR_HIGH,
-					      upper_32_bits(dummy_read_table->mc_address),
-					      NULL);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_SET_DRIVER_DUMMY_TABLE_DRAM_ADDR_HIGH,
+			       upper_32_bits(dummy_read_table->mc_address),
+			       NULL);
 	if (ret)
 		return ret;
 
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SET_DRIVER_DUMMY_TABLE_DRAM_ADDR_LOW,
-					       lower_32_bits(dummy_read_table->mc_address),
-					       NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_SET_DRIVER_DUMMY_TABLE_DRAM_ADDR_LOW,
+				lower_32_bits(dummy_read_table->mc_address),
+				NULL);
 }
 
 static int navi10_run_umc_cdr_workaround(struct smu_context *smu)
@@ -2673,10 +2673,10 @@ static int navi10_run_umc_cdr_workaround(struct smu_context *smu)
 	     (smu->smc_fw_version >= 0x2a3500)) ||
 	    ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 5)) &&
 	     (smu->smc_fw_version >= 0x351D00))) {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_GET_UMC_FW_WA,
-						      0,
-						      &param);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_GET_UMC_FW_WA,
+				       0,
+				       &param);
 		if (ret)
 			return ret;
 
@@ -3204,10 +3204,10 @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
 	    adev->pdev->revision == 0)
 		param = 0xD188;
 
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetMGpuFanBoostLimitRpm,
-					       param,
-					       NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_SetMGpuFanBoostLimitRpm,
+				param,
+				NULL);
 }
 
 static int navi10_post_smu_init(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 39000c053203..7e8e0c22570f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1162,9 +1162,9 @@ static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu,
 		return ret;
 	/* vcn dpm on is a prerequisite for vcn power gate messages */
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-						      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
-						      0x10000 * inst, NULL);
+		ret = smu_cmn_send_msg(smu, enable ?
+				       SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+				       0x10000 * inst, NULL);
 	}
 
 	return ret;
@@ -1176,13 +1176,13 @@ static int sienna_cichlid_dpm_set_jpeg_enable(struct smu_context *smu, bool enab
 
 	if (enable) {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
 			if (ret)
 				return ret;
 		}
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
 			if (ret)
 				return ret;
 		}
@@ -1192,8 +1192,8 @@ static int sienna_cichlid_dpm_set_jpeg_enable(struct smu_context *smu, bool enab
 }
 
 static int sienna_cichlid_get_current_clk_freq_by_table(struct smu_context *smu,
-				       enum smu_clk_type clk_type,
-				       uint32_t *value)
+							enum smu_clk_type clk_type,
+							uint32_t *value)
 {
 	MetricsMember_t member_type;
 	int clk_id = 0;
@@ -1497,7 +1497,7 @@ static int sienna_cichlid_pre_display_config_changed(struct smu_context *smu)
 	/* Sienna_Cichlid do not support to change display num currently */
 	return 0;
 #if 0
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, 0, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_NumOfDisplays, 0, NULL);
 	if (ret)
 		return ret;
 #endif
@@ -1522,9 +1522,9 @@ static int sienna_cichlid_display_config_changed(struct smu_context *smu)
 	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
 	    smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 #if 0
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays,
-						  smu->display_config->num_display,
-						  NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_NumOfDisplays,
+				       smu->display_config->num_display,
+				       NULL);
 #endif
 		if (ret)
 			return ret;
@@ -1776,8 +1776,8 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu,
 		memset(smu->custom_profile_params, 0, SIENNA_CICHLID_CUSTOM_PARAMS_SIZE);
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-					      backend_workload_mask, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetWorkloadMask,
+			       backend_workload_mask, NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
 			workload_mask);
@@ -1806,10 +1806,10 @@ static int sienna_cichlid_notify_smc_display_config(struct smu_context *smu)
 		ret = smu_v11_0_display_clock_voltage_request(smu, &clock_req);
 		if (!ret) {
 			if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
-				ret = smu_cmn_send_smc_msg_with_param(smu,
-								  SMU_MSG_SetMinDeepSleepDcefclk,
-								  min_clocks.dcef_clock_in_sr/100,
-								  NULL);
+				ret = smu_cmn_send_msg(smu,
+						       SMU_MSG_SetMinDeepSleepDcefclk,
+						       min_clocks.dcef_clock_in_sr/100,
+						       NULL);
 				if (ret) {
 					dev_err(smu->adev->dev, "Attempt to set divider for DCEFCLK Failed!");
 					return ret;
@@ -2138,7 +2138,7 @@ static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 				pcie_table->pcie_gen[i] << 8 |
 				pcie_table->pcie_lane[i]);
 
-			ret = smu_cmn_send_smc_msg_with_param(smu,
+			ret = smu_cmn_send_msg(smu,
 						SMU_MSG_OverridePcieParameters,
 						smu_pcie_arg,
 						NULL);
@@ -2851,10 +2851,10 @@ static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)
 	if (*mgpu_fan_boost_limit_rpm == 0)
 		return 0;
 
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetMGpuFanBoostLimitRpm,
-					       0,
-					       NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_SetMGpuFanBoostLimitRpm,
+				0,
+				NULL);
 }
 
 static int sienna_cichlid_gpo_control(struct smu_context *smu,
@@ -2867,27 +2867,27 @@ static int sienna_cichlid_gpo_control(struct smu_context *smu,
 
 		if (enablement) {
 			if (smu->smc_fw_version < 0x003a2500) {
-				ret = smu_cmn_send_smc_msg_with_param(smu,
-								      SMU_MSG_SetGpoFeaturePMask,
-								      GFX_GPO_PACE_MASK | GFX_GPO_DEM_MASK,
-								      NULL);
+				ret = smu_cmn_send_msg(smu,
+						       SMU_MSG_SetGpoFeaturePMask,
+						       GFX_GPO_PACE_MASK | GFX_GPO_DEM_MASK,
+						       NULL);
 			} else {
-				ret = smu_cmn_send_smc_msg_with_param(smu,
-								      SMU_MSG_DisallowGpo,
-								      0,
-								      NULL);
+				ret = smu_cmn_send_msg(smu,
+						       SMU_MSG_DisallowGpo,
+						       0,
+						       NULL);
 			}
 		} else {
 			if (smu->smc_fw_version < 0x003a2500) {
-				ret = smu_cmn_send_smc_msg_with_param(smu,
-								      SMU_MSG_SetGpoFeaturePMask,
-								      0,
-								      NULL);
+				ret = smu_cmn_send_msg(smu,
+						       SMU_MSG_SetGpoFeaturePMask,
+						       0,
+						       NULL);
 			} else {
-				ret = smu_cmn_send_smc_msg_with_param(smu,
-								      SMU_MSG_DisallowGpo,
-								      1,
-								      NULL);
+				ret = smu_cmn_send_msg(smu,
+						       SMU_MSG_DisallowGpo,
+						       1,
+						       NULL);
 			}
 		}
 	}
@@ -2904,11 +2904,11 @@ static int sienna_cichlid_notify_2nd_usb20_port(struct smu_context *smu)
 	if (smu->smc_fw_version < 0x003A2D00)
 		return 0;
 
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_Enable2ndUSB20Port,
-					       smu->smu_table.boot_values.firmware_caps & ATOM_FIRMWARE_CAP_ENABLE_2ND_USB20PORT ?
-					       1 : 0,
-					       NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_Enable2ndUSB20Port,
+				smu->smu_table.boot_values.firmware_caps & ATOM_FIRMWARE_CAP_ENABLE_2ND_USB20PORT ?
+				1 : 0,
+				NULL);
 }
 
 static int sienna_cichlid_system_features_control(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 210134ee1437..1e9857f5c9c2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -637,16 +637,16 @@ int smu_v11_0_notify_memory_pool_location(struct smu_context *smu)
 	address_high = (uint32_t)upper_32_bits(address);
 	address_low  = (uint32_t)lower_32_bits(address);
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					  SMU_MSG_SetSystemVirtualDramAddrHigh,
-					  address_high,
-					  NULL);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_SetSystemVirtualDramAddrHigh,
+			       address_high,
+			       NULL);
 	if (ret)
 		return ret;
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					  SMU_MSG_SetSystemVirtualDramAddrLow,
-					  address_low,
-					  NULL);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_SetSystemVirtualDramAddrLow,
+			       address_low,
+			       NULL);
 	if (ret)
 		return ret;
 
@@ -654,16 +654,16 @@ int smu_v11_0_notify_memory_pool_location(struct smu_context *smu)
 	address_high = (uint32_t)upper_32_bits(address);
 	address_low  = (uint32_t)lower_32_bits(address);
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramAddrHigh,
-					  address_high, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_DramLogSetDramAddrHigh,
+			       address_high, NULL);
 	if (ret)
 		return ret;
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramAddrLow,
-					  address_low, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_DramLogSetDramAddrLow,
+			       address_low, NULL);
 	if (ret)
 		return ret;
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramSize,
-					  (uint32_t)memory_pool->size, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_DramLogSetDramSize,
+			       (uint32_t)memory_pool->size, NULL);
 	if (ret)
 		return ret;
 
@@ -674,8 +674,8 @@ int smu_v11_0_set_min_deep_sleep_dcefclk(struct smu_context *smu, uint32_t clk)
 {
 	int ret;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					  SMU_MSG_SetMinDeepSleepDcefclk, clk, NULL);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_SetMinDeepSleepDcefclk, clk, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "SMU11 attempt to set divider for DCEFCLK Failed!");
 
@@ -688,15 +688,15 @@ int smu_v11_0_set_driver_table_location(struct smu_context *smu)
 	int ret = 0;
 
 	if (driver_table->mc_address) {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-				SMU_MSG_SetDriverDramAddrHigh,
-				upper_32_bits(driver_table->mc_address),
-				NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_SetDriverDramAddrHigh,
+				       upper_32_bits(driver_table->mc_address),
+				       NULL);
 		if (!ret)
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-				SMU_MSG_SetDriverDramAddrLow,
-				lower_32_bits(driver_table->mc_address),
-				NULL);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_SetDriverDramAddrLow,
+					       lower_32_bits(driver_table->mc_address),
+					       NULL);
 	}
 
 	return ret;
@@ -708,15 +708,15 @@ int smu_v11_0_set_tool_table_location(struct smu_context *smu)
 	struct smu_table *tool_table = &smu->smu_table.tables[SMU_TABLE_PMSTATUSLOG];
 
 	if (tool_table->mc_address) {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-				SMU_MSG_SetToolsDramAddrHigh,
-				upper_32_bits(tool_table->mc_address),
-				NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_SetToolsDramAddrHigh,
+				       upper_32_bits(tool_table->mc_address),
+				       NULL);
 		if (!ret)
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-				SMU_MSG_SetToolsDramAddrLow,
-				lower_32_bits(tool_table->mc_address),
-				NULL);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_SetToolsDramAddrLow,
+					       lower_32_bits(tool_table->mc_address),
+					       NULL);
 	}
 
 	return ret;
@@ -736,10 +736,10 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
 	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 13))
 		return 0;
 
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_NumOfDisplays,
-					       count,
-					       NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_NumOfDisplays,
+				count,
+				NULL);
 }
 
 
@@ -757,13 +757,13 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 
 	smu_feature_list_to_arr32(smu, SMU_FEATURE_LIST_ALLOWED, feature_mask);
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
-					  feature_mask[1], NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
+			       feature_mask[1], NULL);
 	if (ret)
 		goto failed;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskLow,
-					  feature_mask[0], NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetAllowedFeaturesMaskLow,
+			       feature_mask[0], NULL);
 	if (ret)
 		goto failed;
 
@@ -775,7 +775,7 @@ int smu_v11_0_system_features_control(struct smu_context *smu,
 					     bool en)
 {
 	return smu_cmn_send_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
-					  SMU_MSG_DisableAllSmuFeatures));
+				      SMU_MSG_DisableAllSmuFeatures));
 }
 
 int smu_v11_0_notify_display_change(struct smu_context *smu)
@@ -784,7 +784,7 @@ int smu_v11_0_notify_display_change(struct smu_context *smu)
 
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
 	    smu->adev->gmc.vram_type == AMDGPU_VRAM_TYPE_HBM)
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL);
 
 	return ret;
 }
@@ -806,8 +806,8 @@ smu_v11_0_get_max_sustainable_clock(struct smu_context *smu, uint32_t *clock,
 	if (clk_id < 0)
 		return -EINVAL;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetDcModeMaxDpmFreq,
-					  clk_id << 16, clock);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GetDcModeMaxDpmFreq,
+			       clk_id << 16, clock);
 	if (ret) {
 		dev_err(smu->adev->dev, "[GetMaxSustainableClock] Failed to get max DC clock from SMC!");
 		return ret;
@@ -817,8 +817,8 @@ smu_v11_0_get_max_sustainable_clock(struct smu_context *smu, uint32_t *clock,
 		return 0;
 
 	/* if DC limit is zero, return AC limit */
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetMaxDpmFreq,
-					  clk_id << 16, clock);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GetMaxDpmFreq,
+			       clk_id << 16, clock);
 	if (ret) {
 		dev_err(smu->adev->dev, "[GetMaxSustainableClock] failed to get max AC clock from SMC!");
 		return ret;
@@ -925,10 +925,10 @@ int smu_v11_0_get_current_power_limit(struct smu_context *smu,
 	 * BIT 24-31: ControllerId (only PPT0 is supported for now)
 	 * BIT 16-23: PowerSource
 	 */
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					  SMU_MSG_GetPptLimit,
-					  (0 << 24) | (power_src << 16),
-					  power_limit);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_GetPptLimit,
+			       (0 << 24) | (power_src << 16),
+			       power_limit);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] get PPT limit failed!", __func__);
 
@@ -967,7 +967,7 @@ int smu_v11_0_set_power_limit(struct smu_context *smu,
 	limit_param  = (limit & 0xFFFF);
 	limit_param |= 0 << 24;
 	limit_param |= (power_src) << 16;
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, limit_param, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetPptLimit, limit_param, NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "[%s] Set power limit Failed!\n", __func__);
 		return ret;
@@ -1324,10 +1324,10 @@ smu_v11_0_set_fan_control_mode(struct smu_context *smu,
 int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
 				     uint32_t pstate)
 {
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetXgmiMode,
-					       pstate ? XGMI_MODE_PSTATE_D0 : XGMI_MODE_PSTATE_D3,
-					  NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_SetXgmiMode,
+				pstate ? XGMI_MODE_PSTATE_D0 : XGMI_MODE_PSTATE_D3,
+				NULL);
 }
 
 static int smu_v11_0_set_irq_state(struct amdgpu_device *adev,
@@ -1558,7 +1558,7 @@ int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu)
 int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu,
 				      enum smu_baco_seq baco_seq)
 {
-	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ArmD3, baco_seq, NULL);
+	return smu_cmn_send_msg(smu, SMU_MSG_ArmD3, baco_seq, NULL);
 }
 
 int smu_v11_0_get_bamaco_support(struct smu_context *smu)
@@ -1612,15 +1612,15 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 		case IP_VERSION(11, 0, 12):
 		case IP_VERSION(11, 0, 13):
 			if (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO)
-				ret = smu_cmn_send_smc_msg_with_param(smu,
-								      SMU_MSG_EnterBaco,
-								      D3HOT_BAMACO_SEQUENCE,
-								      NULL);
+				ret = smu_cmn_send_msg(smu,
+						       SMU_MSG_EnterBaco,
+						       D3HOT_BAMACO_SEQUENCE,
+						       NULL);
 			else
-				ret = smu_cmn_send_smc_msg_with_param(smu,
-								      SMU_MSG_EnterBaco,
-								      D3HOT_BACO_SEQUENCE,
-								      NULL);
+				ret = smu_cmn_send_msg(smu,
+						       SMU_MSG_EnterBaco,
+						       D3HOT_BACO_SEQUENCE,
+						       NULL);
 			break;
 		default:
 			if (!ras || !adev->ras_enabled ||
@@ -1637,9 +1637,9 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 					WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
 				}
 
-				ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 0, NULL);
+				ret = smu_cmn_send_msg(smu, SMU_MSG_EnterBaco, 0, NULL);
 			} else {
-				ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 1, NULL);
+				ret = smu_cmn_send_msg(smu, SMU_MSG_EnterBaco, 1, NULL);
 			}
 			break;
 		}
@@ -1704,7 +1704,7 @@ int smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool enable)
 {
 	int ret = 0;
 
-	ret =  smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_LightSBR, enable ? 1 : 0, NULL);
+	ret =  smu_cmn_send_msg(smu, SMU_MSG_LightSBR, enable ? 1 : 0, NULL);
 
 	return ret;
 }
@@ -1754,13 +1754,13 @@ int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 	param = (clk_id & 0xffff) << 16;
 
 	if (max) {
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetMaxDpmFreq, param, max);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_GetMaxDpmFreq, param, max);
 		if (ret)
 			goto failed;
 	}
 
 	if (min) {
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetMinDpmFreq, param, min);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_GetMinDpmFreq, param, min);
 		if (ret)
 			goto failed;
 	}
@@ -1792,8 +1792,8 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 			param = (uint32_t)((clk_id << 16) | 0xffff);
 		else
 			param = (uint32_t)((clk_id << 16) | (max & 0xffff));
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
-						  param, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxByFreq,
+				       param, NULL);
 		if (ret)
 			goto out;
 	}
@@ -1803,8 +1803,8 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
 			param = (uint32_t)((clk_id << 16) | 0);
 		else
 			param = (uint32_t)((clk_id << 16) | (min & 0xffff));
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinByFreq,
-						  param, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMinByFreq,
+				       param, NULL);
 		if (ret)
 			goto out;
 	}
@@ -1835,16 +1835,16 @@ int smu_v11_0_set_hard_freq_limited_range(struct smu_context *smu,
 
 	if (max > 0) {
 		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMaxByFreq,
-						  param, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMaxByFreq,
+				       param, NULL);
 		if (ret)
 			return ret;
 	}
 
 	if (min > 0) {
 		param = (uint32_t)((clk_id << 16) | (min & 0xffff));
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinByFreq,
-						  param, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMinByFreq,
+				       param, NULL);
 		if (ret)
 			return ret;
 	}
@@ -1967,10 +1967,10 @@ int smu_v11_0_set_power_source(struct smu_context *smu,
 	if (pwr_source < 0)
 		return -EINVAL;
 
-	return smu_cmn_send_smc_msg_with_param(smu,
-					SMU_MSG_NotifyPowerSource,
-					pwr_source,
-					NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_NotifyPowerSource,
+				pwr_source,
+				NULL);
 }
 
 int smu_v11_0_get_dpm_freq_by_index(struct smu_context *smu,
@@ -1995,10 +1995,10 @@ int smu_v11_0_get_dpm_freq_by_index(struct smu_context *smu,
 
 	param = (uint32_t)(((clk_id & 0xffff) << 16) | (level & 0xffff));
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					  SMU_MSG_GetDpmFreqByIndex,
-					  param,
-					  value);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_GetDpmFreqByIndex,
+			       param,
+			       value);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index d67104f52496..5e59ee2954e1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -473,11 +473,11 @@ static int vangogh_dpm_set_vcn_enable(struct smu_context *smu,
 
 	if (enable) {
 		/* vcn dpm on is a prerequisite for vcn power gate messages */
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_PowerUpVcn, 0, NULL);
 		if (ret)
 			return ret;
 	} else {
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn, 0, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_PowerDownVcn, 0, NULL);
 		if (ret)
 			return ret;
 	}
@@ -490,11 +490,11 @@ static int vangogh_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 	int ret = 0;
 
 	if (enable) {
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
 		if (ret)
 			return ret;
 	} else {
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
 		if (ret)
 			return ret;
 	}
@@ -628,7 +628,7 @@ static int vangogh_emit_legacy_clk_levels(struct smu_context *smu,
 		break;
 	case SMU_FCLK:
 		count = clk_table->NumDfPstatesEnabled;
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetFclkFrequency, 0, &cur_value);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_GetFclkFrequency, 0, &cur_value);
 		if (ret)
 			return ret;
 		break;
@@ -725,13 +725,13 @@ static int vangogh_emit_clk_levels(struct smu_context *smu,
 		break;
 	case SMU_FCLK:
 		count = clk_table->NumDfPstatesEnabled;
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetFclkFrequency, 0, &cur_value);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_GetFclkFrequency, 0, &cur_value);
 		if (ret)
 			return ret;
 		break;
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetGfxclkFrequency, 0, &cur_value);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_GetGfxclkFrequency, 0, &cur_value);
 		if (ret) {
 			return ret;
 		}
@@ -1068,7 +1068,7 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu,
 	smu_cmn_get_backend_workload_mask(smu, workload_mask,
 					  &backend_workload_mask);
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
+	ret = smu_cmn_send_msg(smu, SMU_MSG_ActiveProcessNotify,
 					      backend_workload_mask,
 					      NULL);
 	if (ret) {
@@ -1094,63 +1094,63 @@ static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 							SMU_MSG_SetHardMinGfxClk,
 							min, NULL);
 		if (ret)
 			return ret;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 							SMU_MSG_SetSoftMaxGfxClk,
 							max, NULL);
 		if (ret)
 			return ret;
 		break;
 	case SMU_FCLK:
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 							SMU_MSG_SetHardMinFclkByFreq,
 							min, NULL);
 		if (ret)
 			return ret;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 							SMU_MSG_SetSoftMaxFclkByFreq,
 							max, NULL);
 		if (ret)
 			return ret;
 		break;
 	case SMU_SOCCLK:
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 							SMU_MSG_SetHardMinSocclkByFreq,
 							min, NULL);
 		if (ret)
 			return ret;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 							SMU_MSG_SetSoftMaxSocclkByFreq,
 							max, NULL);
 		if (ret)
 			return ret;
 		break;
 	case SMU_VCLK:
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 							SMU_MSG_SetHardMinVcn,
 							min << 16, NULL);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 							SMU_MSG_SetSoftMaxVcn,
 							max << 16, NULL);
 		if (ret)
 			return ret;
 		break;
 	case SMU_DCLK:
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 							SMU_MSG_SetHardMinVcn,
 							min, NULL);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 							SMU_MSG_SetSoftMaxVcn,
 							max, NULL);
 		if (ret)
@@ -1183,12 +1183,12 @@ static int vangogh_force_clk_levels(struct smu_context *smu,
 						soft_max_level, &max_freq);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 								SMU_MSG_SetSoftMaxSocclkByFreq,
 								max_freq, NULL);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 								SMU_MSG_SetHardMinSocclkByFreq,
 								min_freq, NULL);
 		if (ret)
@@ -1203,12 +1203,12 @@ static int vangogh_force_clk_levels(struct smu_context *smu,
 							clk_type, soft_max_level, &max_freq);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 								SMU_MSG_SetSoftMaxFclkByFreq,
 								max_freq, NULL);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 								SMU_MSG_SetHardMinFclkByFreq,
 								min_freq, NULL);
 		if (ret)
@@ -1226,13 +1226,13 @@ static int vangogh_force_clk_levels(struct smu_context *smu,
 			return ret;
 
 
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 								SMU_MSG_SetHardMinVcn,
 								min_freq << 16, NULL);
 		if (ret)
 			return ret;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 								SMU_MSG_SetSoftMaxVcn,
 								max_freq << 16, NULL);
 		if (ret)
@@ -1250,13 +1250,13 @@ static int vangogh_force_clk_levels(struct smu_context *smu,
 		if (ret)
 			return ret;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 							SMU_MSG_SetHardMinVcn,
 							min_freq, NULL);
 		if (ret)
 			return ret;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+		ret = smu_cmn_send_msg(smu,
 							SMU_MSG_SetSoftMaxVcn,
 							max_freq, NULL);
 		if (ret)
@@ -1463,26 +1463,26 @@ static int vangogh_set_performance_level(struct smu_context *smu,
 		return 0;
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMinGfxClk,
 					      smu->gfx_actual_hard_min_freq, NULL);
 	if (ret)
 		return ret;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxGfxClk,
 					      smu->gfx_actual_soft_max_freq, NULL);
 	if (ret)
 		return ret;
 
 	if (smu->adev->pm.fw_version >= 0x43f1b00) {
 		for (i = 0; i < smu->cpu_core_num; i++) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinCclk,
+			ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMinCclk,
 							      ((i << 20)
 							       | smu->cpu_actual_soft_min_freq),
 							      NULL);
 			if (ret)
 				return ret;
 
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxCclk,
+			ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxCclk,
 							      ((i << 20)
 							       | smu->cpu_actual_soft_max_freq),
 							      NULL);
@@ -1582,14 +1582,14 @@ static int vangogh_read_sensor(struct smu_context *smu,
 
 static int vangogh_get_apu_thermal_limit(struct smu_context *smu, uint32_t *limit)
 {
-	return smu_cmn_send_smc_msg_with_param(smu,
+	return smu_cmn_send_msg(smu,
 					      SMU_MSG_GetThermalLimit,
 					      0, limit);
 }
 
 static int vangogh_set_apu_thermal_limit(struct smu_context *smu, uint32_t limit)
 {
-	return smu_cmn_send_smc_msg_with_param(smu,
+	return smu_cmn_send_msg(smu,
 					      SMU_MSG_SetReducedThermalLimit,
 					      limit, NULL);
 }
@@ -2117,14 +2117,14 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 				return -EINVAL;
 			}
 
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
+			ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMinGfxClk,
 									smu->gfx_actual_hard_min_freq, NULL);
 			if (ret) {
 				dev_err(smu->adev->dev, "Set hard min sclk failed!");
 				return ret;
 			}
 
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
+			ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxGfxClk,
 									smu->gfx_actual_soft_max_freq, NULL);
 			if (ret) {
 				dev_err(smu->adev->dev, "Set soft max sclk failed!");
@@ -2136,7 +2136,7 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 				break;
 			}
 
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinCclk,
+			ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMinCclk,
 							      ((smu->cpu_core_id_select << 20)
 							       | smu->cpu_actual_soft_min_freq),
 							      NULL);
@@ -2145,7 +2145,7 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 				return ret;
 			}
 
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxCclk,
+			ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxCclk,
 							      ((smu->cpu_core_id_select << 20)
 							       | smu->cpu_actual_soft_max_freq),
 							      NULL);
@@ -2218,7 +2218,7 @@ static int vangogh_notify_rlc_state(struct smu_context *smu, bool en)
 	int ret = 0;
 
 	if (adev->pm.fw_version >= 0x43f1700 && !en)
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify,
+		ret = smu_cmn_send_msg(smu, SMU_MSG_RlcPowerNotify,
 						      RLC_STATUS_OFF, NULL);
 
 	return ret;
@@ -2269,7 +2269,7 @@ static int vangogh_post_smu_init(struct smu_context *smu)
 		dev_info(adev->dev, "Number of always on WGPs greater than active WGPs: WGP power save not requested.\n");
 		return 0;
 	} else {
-		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RequestActiveWgp, req_active_wgps, NULL);
+		return smu_cmn_send_msg(smu, SMU_MSG_RequestActiveWgp, req_active_wgps, NULL);
 	}
 }
 
@@ -2402,10 +2402,10 @@ static int vangogh_set_power_limit(struct smu_context *smu,
 
 	switch (limit_type) {
 	case SMU_DEFAULT_PPT_LIMIT:
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-				SMU_MSG_SetSlowPPTLimit,
-				ppt_limit * 1000, /* convert from watt to milliwatt */
-				NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_SetSlowPPTLimit,
+				       ppt_limit * 1000, /* convert from watt to milliwatt */
+				       NULL);
 		if (ret)
 			return ret;
 
@@ -2419,10 +2419,10 @@ static int vangogh_set_power_limit(struct smu_context *smu,
 			return ret;
 		}
 
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-				SMU_MSG_SetFastPPTLimit,
-				ppt_limit * 1000, /* convert from watt to milliwatt */
-				NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_SetFastPPTLimit,
+				       ppt_limit * 1000, /* convert from watt to milliwatt */
+				       NULL);
 		if (ret)
 			return ret;
 
@@ -2455,8 +2455,8 @@ static u32 vangogh_set_gfxoff_residency(struct smu_context *smu, bool start)
 	if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 		return 0;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_LogGfxOffResidency,
-					      start, &residency);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_LogGfxOffResidency,
+			       start, &residency);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index f46269075ee2..b2aa27dc00ae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -434,19 +434,19 @@ static int renoir_od_edit_dpm_table(struct smu_context *smu,
 				return -EINVAL;
 			}
 
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-								SMU_MSG_SetHardMinGfxClk,
-								smu->gfx_actual_hard_min_freq,
-								NULL);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_SetHardMinGfxClk,
+					       smu->gfx_actual_hard_min_freq,
+					       NULL);
 			if (ret) {
 				dev_err(smu->adev->dev, "Set hard min sclk failed!");
 				return ret;
 			}
 
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-								SMU_MSG_SetSoftMaxGfxClk,
-								smu->gfx_actual_soft_max_freq,
-								NULL);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_SetSoftMaxGfxClk,
+					       smu->gfx_actual_soft_max_freq,
+					       NULL);
 			if (ret) {
 				dev_err(smu->adev->dev, "Set soft max sclk failed!");
 				return ret;
@@ -465,14 +465,14 @@ static int renoir_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 	uint32_t min = 0, max = 0;
 	int ret = 0;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-								SMU_MSG_GetMinGfxclkFrequency,
-								0, &min);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_GetMinGfxclkFrequency,
+			       0, &min);
 	if (ret)
 		return ret;
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-								SMU_MSG_GetMaxGfxclkFrequency,
-								0, &max);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_GetMaxGfxclkFrequency,
+			       0, &max);
 	if (ret)
 		return ret;
 
@@ -501,14 +501,14 @@ static int renoir_emit_clk_levels(struct smu_context *smu,
 
 	switch (clk_type) {
 	case SMU_OD_RANGE:
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-					SMU_MSG_GetMinGfxclkFrequency,
-					0, &min);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_GetMinGfxclkFrequency,
+				       0, &min);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-					SMU_MSG_GetMaxGfxclkFrequency,
-					0, &max);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_GetMaxGfxclkFrequency,
+				       0, &max);
 		if (ret)
 			return ret;
 		size += sysfs_emit_at(buf, size, "OD_RANGE\nSCLK: %10uMhz %10uMhz\n", min, max);
@@ -643,7 +643,7 @@ static int renoir_dpm_set_vcn_enable(struct smu_context *smu,
 	if (enable) {
 		/* vcn dpm on is a prerequisite for vcn power gate messages */
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_PowerUpVcn, 0, NULL);
 			if (ret)
 				return ret;
 		}
@@ -664,13 +664,13 @@ static int renoir_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 
 	if (enable) {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
 			if (ret)
 				return ret;
 		}
 	} else {
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_JPEG_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
 			if (ret)
 				return ret;
 		}
@@ -804,16 +804,16 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 		ret = renoir_get_dpm_ultimate_freq(smu, SMU_GFXCLK, &min_freq, &max_freq);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
-					soft_max_level == 0 ? min_freq :
-					soft_max_level == 1 ? RENOIR_UMD_PSTATE_GFXCLK : max_freq,
-					NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxGfxClk,
+				       soft_max_level == 0 ? min_freq :
+				       soft_max_level == 1 ? RENOIR_UMD_PSTATE_GFXCLK : max_freq,
+				       NULL);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
-					soft_min_level == 2 ? max_freq :
-					soft_min_level == 1 ? RENOIR_UMD_PSTATE_GFXCLK : min_freq,
-					NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMinGfxClk,
+				       soft_min_level == 2 ? max_freq :
+				       soft_min_level == 1 ? RENOIR_UMD_PSTATE_GFXCLK : min_freq,
+				       NULL);
 		if (ret)
 			return ret;
 		break;
@@ -824,10 +824,10 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 		ret = renoir_get_dpm_clk_limited(smu, clk_type, soft_max_level, &max_freq);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxSocclkByFreq, max_freq, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxSocclkByFreq, max_freq, NULL);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinSocclkByFreq, min_freq, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMinSocclkByFreq, min_freq, NULL);
 		if (ret)
 			return ret;
 		break;
@@ -839,10 +839,10 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 		ret = renoir_get_dpm_clk_limited(smu, clk_type, soft_max_level, &max_freq);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxFclkByFreq, max_freq, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxFclkByFreq, max_freq, NULL);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinFclkByFreq, min_freq, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMinFclkByFreq, min_freq, NULL);
 		if (ret)
 			return ret;
 		break;
@@ -864,9 +864,9 @@ static int renoir_set_power_profile_mode(struct smu_context *smu,
 	smu_cmn_get_backend_workload_mask(smu, workload_mask,
 					  &backend_workload_mask);
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-					      backend_workload_mask,
-					      NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_ActiveProcessNotify,
+			       backend_workload_mask,
+			       NULL);
 	if (ret) {
 		dev_err_once(smu->adev->dev, "Failed to set workload mask 0x08%x\n",
 			     workload_mask);
@@ -974,53 +974,53 @@ static int renoir_set_performance_level(struct smu_context *smu,
 		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
 		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_SetHardMinGfxClk,
-						      RENOIR_UMD_PSTATE_GFXCLK,
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_SetHardMinGfxClk,
+				       RENOIR_UMD_PSTATE_GFXCLK,
+				       NULL);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_SetHardMinFclkByFreq,
-						      RENOIR_UMD_PSTATE_FCLK,
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_SetHardMinFclkByFreq,
+				       RENOIR_UMD_PSTATE_FCLK,
+				       NULL);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_SetHardMinSocclkByFreq,
-						      RENOIR_UMD_PSTATE_SOCCLK,
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_SetHardMinSocclkByFreq,
+				       RENOIR_UMD_PSTATE_SOCCLK,
+				       NULL);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_SetHardMinVcn,
-						      RENOIR_UMD_PSTATE_VCNCLK,
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_SetHardMinVcn,
+				       RENOIR_UMD_PSTATE_VCNCLK,
+				       NULL);
 		if (ret)
 			return ret;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_SetSoftMaxGfxClk,
-						      RENOIR_UMD_PSTATE_GFXCLK,
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_SetSoftMaxGfxClk,
+				       RENOIR_UMD_PSTATE_GFXCLK,
+				       NULL);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_SetSoftMaxFclkByFreq,
-						      RENOIR_UMD_PSTATE_FCLK,
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_SetSoftMaxFclkByFreq,
+				       RENOIR_UMD_PSTATE_FCLK,
+				       NULL);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_SetSoftMaxSocclkByFreq,
-						      RENOIR_UMD_PSTATE_SOCCLK,
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_SetSoftMaxSocclkByFreq,
+				       RENOIR_UMD_PSTATE_SOCCLK,
+				       NULL);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_SetSoftMaxVcn,
-						      RENOIR_UMD_PSTATE_VCNCLK,
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_SetSoftMaxVcn,
+				       RENOIR_UMD_PSTATE_VCNCLK,
+				       NULL);
 		if (ret)
 			return ret;
 		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index 0bd36b465cae..be338ad2ba2f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -123,10 +123,9 @@ int smu_v12_0_set_gfx_cgpg(struct smu_context *smu, bool enable)
 	if (!(smu->adev->pg_flags & AMD_PG_SUPPORT_GFX_PG) || smu->adev->in_s0ix)
 		return 0;
 
-	return smu_cmn_send_smc_msg_with_param(smu,
-		SMU_MSG_SetGfxCGPG,
-		enable ? 1 : 0,
-		NULL);
+	return smu_cmn_send_msg(smu, SMU_MSG_SetGfxCGPG,
+				enable ? 1 : 0,
+				NULL);
 }
 
 /**
@@ -205,7 +204,7 @@ int smu_v12_0_set_default_dpm_tables(struct smu_context *smu)
 
 int smu_v12_0_mode2_reset(struct smu_context *smu)
 {
-	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_2, NULL);
+	return smu_cmn_send_msg(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_2, NULL);
 }
 
 int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_type clk_type,
@@ -219,40 +218,40 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk, min, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMinGfxClk, min, NULL);
 		if (ret)
 			return ret;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk, max, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxGfxClk, max, NULL);
 		if (ret)
 			return ret;
 	break;
 	case SMU_FCLK:
 	case SMU_MCLK:
 	case SMU_UCLK:
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinFclkByFreq, min, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMinFclkByFreq, min, NULL);
 		if (ret)
 			return ret;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxFclkByFreq, max, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxFclkByFreq, max, NULL);
 		if (ret)
 			return ret;
 	break;
 	case SMU_SOCCLK:
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinSocclkByFreq, min, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMinSocclkByFreq, min, NULL);
 		if (ret)
 			return ret;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxSocclkByFreq, max, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxSocclkByFreq, max, NULL);
 		if (ret)
 			return ret;
 	break;
 	case SMU_VCLK:
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinVcn, min, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMinVcn, min, NULL);
 		if (ret)
 			return ret;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxVcn, max, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxVcn, max, NULL);
 		if (ret)
 			return ret;
 	break;
@@ -269,15 +268,15 @@ int smu_v12_0_set_driver_table_location(struct smu_context *smu)
 	int ret = 0;
 
 	if (driver_table->mc_address) {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-				SMU_MSG_SetDriverDramAddrHigh,
-				upper_32_bits(driver_table->mc_address),
-				NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_SetDriverDramAddrHigh,
+				       upper_32_bits(driver_table->mc_address),
+				       NULL);
 		if (!ret)
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-				SMU_MSG_SetDriverDramAddrLow,
-				lower_32_bits(driver_table->mc_address),
-				NULL);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_SetDriverDramAddrLow,
+					       lower_32_bits(driver_table->mc_address),
+					       NULL);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 5ffd4ca69499..629dd61434bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -280,11 +280,9 @@ static int aldebaran_select_plpd_policy(struct smu_context *smu, int level)
 		return 0;
 
 	if (level == XGMI_PLPD_DEFAULT)
-		return smu_cmn_send_smc_msg_with_param(
-			smu, SMU_MSG_GmiPwrDnControl, 0, NULL);
+		return smu_cmn_send_msg(smu, SMU_MSG_GmiPwrDnControl, 0, NULL);
 	else if (level == XGMI_PLPD_DISALLOW)
-		return smu_cmn_send_smc_msg_with_param(
-			smu, SMU_MSG_GmiPwrDnControl, 1, NULL);
+		return smu_cmn_send_msg(smu, SMU_MSG_GmiPwrDnControl, 1, NULL);
 	else
 		return -EINVAL;
 }
@@ -868,10 +866,10 @@ static int aldebaran_upload_dpm_level(struct smu_context *smu,
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
 	    (feature_mask & FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT))) {
 		freq = dpm_context->dpm_tables.gfx_table.dpm_levels[level].value;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      (max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
-						      (PPCLK_GFXCLK << 16) | (freq & 0xffff),
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       (max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
+				       (PPCLK_GFXCLK << 16) | (freq & 0xffff),
+				       NULL);
 		if (ret) {
 			dev_err(smu->adev->dev, "Failed to set soft %s gfxclk !\n",
 				max ? "max" : "min");
@@ -882,10 +880,10 @@ static int aldebaran_upload_dpm_level(struct smu_context *smu,
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
 	    (feature_mask & FEATURE_MASK(FEATURE_DPM_UCLK_BIT))) {
 		freq = dpm_context->dpm_tables.uclk_table.dpm_levels[level].value;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      (max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
-						      (PPCLK_UCLK << 16) | (freq & 0xffff),
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       (max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
+				       (PPCLK_UCLK << 16) | (freq & 0xffff),
+				       NULL);
 		if (ret) {
 			dev_err(smu->adev->dev, "Failed to set soft %s memclk !\n",
 				max ? "max" : "min");
@@ -896,10 +894,10 @@ static int aldebaran_upload_dpm_level(struct smu_context *smu,
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT) &&
 	    (feature_mask & FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT))) {
 		freq = dpm_context->dpm_tables.soc_table.dpm_levels[level].value;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      (max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
-						      (PPCLK_SOCCLK << 16) | (freq & 0xffff),
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       (max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
+				       (PPCLK_SOCCLK << 16) | (freq & 0xffff),
+				       NULL);
 		if (ret) {
 			dev_err(smu->adev->dev, "Failed to set soft %s socclk !\n",
 				max ? "max" : "min");
@@ -1284,9 +1282,9 @@ static int aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
 		ret = smu_v13_0_set_soft_freq_limited_range(smu, SMU_GFXCLK, min_clk, max_clk, false);
 		if (!ret) {
 			usleep_range(500, 1000);
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-					SMU_MSG_EnableDeterminism,
-					max, NULL);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_EnableDeterminism,
+					       max, NULL);
 			if (ret) {
 				dev_err(adev->dev,
 						"Failed to enable determinism at GFX clock %d MHz\n", max);
@@ -1574,7 +1572,7 @@ static int aldebaran_set_df_cstate(struct smu_context *smu,
 	if (amdgpu_in_reset(adev) || adev->in_suspend)
 		return 0;
 
-	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DFCstateControl, state, NULL);
+	return smu_cmn_send_msg(smu, SMU_MSG_DFCstateControl, state, NULL);
 }
 
 static const struct throttling_logging_label {
@@ -1815,8 +1813,8 @@ static int aldebaran_mode1_reset(struct smu_context *smu)
 			fatal_err = 1;
 
 		param |= (fatal_err << 16);
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-					SMU_MSG_GfxDeviceDriverReset, param, NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_GfxDeviceDriverReset, param, NULL);
 	}
 
 	if (!ret)
@@ -1879,7 +1877,7 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
 static int aldebaran_smu_handle_passthrough_sbr(struct smu_context *smu, bool enable)
 {
 	int ret = 0;
-	ret =  smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_HeavySBR, enable ? 1 : 0, NULL);
+	ret =  smu_cmn_send_msg(smu, SMU_MSG_HeavySBR, enable ? 1 : 0, NULL);
 
 	return ret;
 }
@@ -1930,7 +1928,7 @@ static int aldebaran_smu_send_hbm_bad_page_num(struct smu_context *smu,
 	int ret = 0;
 
 	/* message SMU to update the bad page number on SMUBUS */
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetNumBadHbmPagesRetired, size, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetNumBadHbmPagesRetired, size, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] failed to message SMU to update HBM bad pages number\n",
 				__func__);
@@ -1956,7 +1954,7 @@ static int aldebaran_send_hbm_bad_channel_flag(struct smu_context *smu,
 		return ret;
 
 	/* message SMU to update the bad channel info on SMUBUS */
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetBadHBMPagesRetiredFlagsPerChannel, size, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetBadHBMPagesRetiredFlagsPerChannel, size, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] failed to message SMU to update HBM bad channel info\n",
 				__func__);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 4cce12f3d783..b2a8105b9636 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -657,16 +657,16 @@ int smu_v13_0_notify_memory_pool_location(struct smu_context *smu)
 	address_high = (uint32_t)upper_32_bits(address);
 	address_low  = (uint32_t)lower_32_bits(address);
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramAddrHigh,
-					      address_high, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_DramLogSetDramAddrHigh,
+			       address_high, NULL);
 	if (ret)
 		return ret;
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramAddrLow,
-					      address_low, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_DramLogSetDramAddrLow,
+			       address_low, NULL);
 	if (ret)
 		return ret;
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramSize,
-					      (uint32_t)memory_pool->size, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_DramLogSetDramSize,
+			       (uint32_t)memory_pool->size, NULL);
 	if (ret)
 		return ret;
 
@@ -679,15 +679,15 @@ int smu_v13_0_set_driver_table_location(struct smu_context *smu)
 	int ret = 0;
 
 	if (driver_table->mc_address) {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_SetDriverDramAddrHigh,
-						      upper_32_bits(driver_table->mc_address),
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_SetDriverDramAddrHigh,
+				       upper_32_bits(driver_table->mc_address),
+				       NULL);
 		if (!ret)
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-							      SMU_MSG_SetDriverDramAddrLow,
-							      lower_32_bits(driver_table->mc_address),
-							      NULL);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_SetDriverDramAddrLow,
+					       lower_32_bits(driver_table->mc_address),
+					       NULL);
 	}
 
 	return ret;
@@ -699,15 +699,15 @@ int smu_v13_0_set_tool_table_location(struct smu_context *smu)
 	struct smu_table *tool_table = &smu->smu_table.tables[SMU_TABLE_PMSTATUSLOG];
 
 	if (tool_table->mc_address) {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_SetToolsDramAddrHigh,
-						      upper_32_bits(tool_table->mc_address),
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_SetToolsDramAddrHigh,
+				       upper_32_bits(tool_table->mc_address),
+				       NULL);
 		if (!ret)
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-							      SMU_MSG_SetToolsDramAddrLow,
-							      lower_32_bits(tool_table->mc_address),
-							      NULL);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_SetToolsDramAddrLow,
+					       lower_32_bits(tool_table->mc_address),
+					       NULL);
 	}
 
 	return ret;
@@ -725,15 +725,15 @@ int smu_v13_0_set_allowed_mask(struct smu_context *smu)
 
 	smu_feature_list_to_arr32(smu, SMU_FEATURE_LIST_ALLOWED, feature_mask);
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
-					      feature_mask[1], NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
+			       feature_mask[1], NULL);
 	if (ret)
 		return ret;
 
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetAllowedFeaturesMaskLow,
-					       feature_mask[0],
-					       NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_SetAllowedFeaturesMaskLow,
+				feature_mask[0],
+				NULL);
 }
 
 int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
@@ -799,8 +799,8 @@ smu_v13_0_get_max_sustainable_clock(struct smu_context *smu, uint32_t *clock,
 	if (clk_id < 0)
 		return -EINVAL;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetDcModeMaxDpmFreq,
-					      clk_id << 16, clock);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GetDcModeMaxDpmFreq,
+			       clk_id << 16, clock);
 	if (ret) {
 		dev_err(smu->adev->dev, "[GetMaxSustainableClock] Failed to get max DC clock from SMC!");
 		return ret;
@@ -810,8 +810,8 @@ smu_v13_0_get_max_sustainable_clock(struct smu_context *smu, uint32_t *clock,
 		return 0;
 
 	/* if DC limit is zero, return AC limit */
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetMaxDpmFreq,
-					      clk_id << 16, clock);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GetMaxDpmFreq,
+			       clk_id << 16, clock);
 	if (ret) {
 		dev_err(smu->adev->dev, "[GetMaxSustainableClock] failed to get max AC clock from SMC!");
 		return ret;
@@ -914,10 +914,10 @@ int smu_v13_0_get_current_power_limit(struct smu_context *smu,
 	if (power_src < 0)
 		return -EINVAL;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_GetPptLimit,
-					      power_src << 16,
-					      power_limit);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_GetPptLimit,
+			       power_src << 16,
+			       power_limit);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] get PPT limit failed!", __func__);
 
@@ -938,7 +938,7 @@ int smu_v13_0_set_power_limit(struct smu_context *smu,
 		return -EOPNOTSUPP;
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, limit, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetPptLimit, limit, NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "[%s] Set power limit Failed!\n", __func__);
 		return ret;
@@ -1134,10 +1134,10 @@ int smu_v13_0_set_xgmi_pstate(struct smu_context *smu,
 			      uint32_t pstate)
 {
 	int ret = 0;
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_SetXgmiMode,
-					      pstate ? XGMI_MODE_PSTATE_D0 : XGMI_MODE_PSTATE_D3,
-					      NULL);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_SetXgmiMode,
+			       pstate ? XGMI_MODE_PSTATE_D0 : XGMI_MODE_PSTATE_D3,
+			       NULL);
 	return ret;
 }
 
@@ -1466,21 +1466,21 @@ int smu_v13_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 
 	if (max) {
 		if (smu->adev->pm.ac_power)
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-							      SMU_MSG_GetMaxDpmFreq,
-							      param,
-							      max);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_GetMaxDpmFreq,
+					       param,
+					       max);
 		else
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-							      SMU_MSG_GetDcModeMaxDpmFreq,
-							      param,
-							      max);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_GetDcModeMaxDpmFreq,
+					       param,
+					       max);
 		if (ret)
 			goto failed;
 	}
 
 	if (min) {
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetMinDpmFreq, param, min);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_GetMinDpmFreq, param, min);
 		if (ret)
 			goto failed;
 	}
@@ -1513,8 +1513,8 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
 			param = (uint32_t)((clk_id << 16) | 0xffff);
 		else
 			param = (uint32_t)((clk_id << 16) | (max & 0xffff));
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
-						      param, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxByFreq,
+				       param, NULL);
 		if (ret)
 			goto out;
 	}
@@ -1524,8 +1524,8 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
 			param = (uint32_t)((clk_id << 16) | 0);
 		else
 			param = (uint32_t)((clk_id << 16) | (min & 0xffff));
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinByFreq,
-						      param, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMinByFreq,
+				       param, NULL);
 		if (ret)
 			goto out;
 	}
@@ -1730,10 +1730,10 @@ int smu_v13_0_set_power_source(struct smu_context *smu,
 	if (pwr_source < 0)
 		return -EINVAL;
 
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_NotifyPowerSource,
-					       pwr_source,
-					       NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_NotifyPowerSource,
+				pwr_source,
+				NULL);
 }
 
 int smu_v13_0_get_boot_freq_by_index(struct smu_context *smu,
@@ -1791,10 +1791,10 @@ int smu_v13_0_get_dpm_freq_by_index(struct smu_context *smu,
 
 	param = (uint32_t)(((clk_id & 0xffff) << 16) | (level & 0xffff));
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_GetDpmFreqByIndex,
-					      param,
-					      value);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_GetDpmFreqByIndex,
+			       param,
+			       value);
 	if (ret)
 		return ret;
 
@@ -1839,10 +1839,10 @@ static int smu_v13_0_get_fine_grained_status(struct smu_context *smu,
 
 	param = (uint32_t)(((clk_id & 0xffff) << 16) | 0xff);
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_GetDpmFreqByIndex,
-					      param,
-					      &value);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_GetDpmFreqByIndex,
+			       param,
+			       &value);
 	if (ret)
 		return ret;
 
@@ -1950,9 +1950,9 @@ int smu_v13_0_set_vcn_enable(struct smu_context *smu,
 	if (adev->vcn.harvest_config & (1 << inst))
 		return ret;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-					      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
-					      inst << 16U, NULL);
+	ret = smu_cmn_send_msg(smu, enable ?
+			       SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+			       inst << 16U, NULL);
 
 	return ret;
 }
@@ -1960,9 +1960,9 @@ int smu_v13_0_set_vcn_enable(struct smu_context *smu,
 int smu_v13_0_set_jpeg_enable(struct smu_context *smu,
 			      bool enable)
 {
-	return smu_cmn_send_smc_msg_with_param(smu, enable ?
-					       SMU_MSG_PowerUpJpeg : SMU_MSG_PowerDownJpeg,
-					       0, NULL);
+	return smu_cmn_send_msg(smu, enable ?
+				SMU_MSG_PowerUpJpeg : SMU_MSG_PowerDownJpeg,
+				0, NULL);
 }
 
 int smu_v13_0_run_btc(struct smu_context *smu)
@@ -1981,7 +1981,7 @@ int smu_v13_0_gpo_control(struct smu_context *smu,
 {
 	int res;
 
-	res = smu_cmn_send_smc_msg_with_param(smu,
+	res = smu_cmn_send_msg(smu,
 					      SMU_MSG_AllowGpo,
 					      enablement ? 1 : 0,
 					      NULL);
@@ -2081,10 +2081,10 @@ static int smu_v13_0_baco_set_armd3_sequence(struct smu_context *smu,
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
 	int ret;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_ArmD3,
-					      baco_seq,
-					      NULL);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_ArmD3,
+			       baco_seq,
+			       NULL);
 	if (ret)
 		return ret;
 
@@ -2115,11 +2115,11 @@ static int smu_v13_0_baco_set_state(struct smu_context *smu,
 		return 0;
 
 	if (state == SMU_BACO_STATE_ENTER) {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_EnterBaco,
-						      (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
-						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_EnterBaco,
+				       (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
+				       BACO_SEQ_BAMACO : BACO_SEQ_BACO,
+				       NULL);
 	} else {
 		ret = smu_cmn_send_msg(smu, SMU_MSG_ExitBaco);
 		if (ret)
@@ -2202,8 +2202,8 @@ int smu_v13_0_set_gfx_power_up_by_imu(struct smu_context *smu)
 	int ret;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableGfxImu,
-						       ENABLE_IMU_ARG_GFXOFF_ENABLE, NULL);
+		return smu_cmn_send_msg(smu, SMU_MSG_EnableGfxImu,
+					ENABLE_IMU_ARG_GFXOFF_ENABLE, NULL);
 	}
 
 	mutex_lock(&ctl->lock);
@@ -2273,17 +2273,17 @@ int smu_v13_0_od_edit_dpm_table(struct smu_context *smu,
 			return -EINVAL;
 		}
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
-						      smu->gfx_actual_hard_min_freq,
-						      NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMinGfxClk,
+				       smu->gfx_actual_hard_min_freq,
+				       NULL);
 		if (ret) {
 			dev_err(smu->adev->dev, "Set hard min sclk failed!");
 			return ret;
 		}
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
-						      smu->gfx_actual_soft_max_freq,
-						      NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxGfxClk,
+				       smu->gfx_actual_soft_max_freq,
+				       NULL);
 		if (ret) {
 			dev_err(smu->adev->dev, "Set soft max sclk failed!");
 			return ret;
@@ -2362,10 +2362,10 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 			smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
 			smu_pcie_arg |= pcie_table->pcie_lane[i];
 
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-								SMU_MSG_OverridePcieParameters,
-								smu_pcie_arg,
-								NULL);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_OverridePcieParameters,
+					       smu_pcie_arg,
+					       NULL);
 			if (ret)
 				break;
 		}
@@ -2379,10 +2379,10 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 				smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
 				smu_pcie_arg |= pcie_table->pcie_lane[i];
 
-				ret = smu_cmn_send_smc_msg_with_param(smu,
-									SMU_MSG_OverridePcieParameters,
-									smu_pcie_arg,
-									NULL);
+				ret = smu_cmn_send_msg(smu,
+						       SMU_MSG_OverridePcieParameters,
+						       smu_pcie_arg,
+						       NULL);
 				if (ret)
 					break;
 			}
@@ -2407,7 +2407,7 @@ int smu_v13_0_disable_pmfw_state(struct smu_context *smu)
 
 int smu_v13_0_enable_uclk_shadow(struct smu_context *smu, bool enable)
 {
-	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableUCLKShadow, enable, NULL);
+	return smu_cmn_send_msg(smu, SMU_MSG_EnableUCLKShadow, enable, NULL);
 }
 
 int smu_v13_0_set_wbrf_exclusion_ranges(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index e8f8917654eb..9be7a2af560d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2384,10 +2384,10 @@ static int smu_v13_0_0_enable_mgpu_fan_boost(struct smu_context *smu)
 	if (skutable->MGpuAcousticLimitRpmThreshold == 0)
 		return 0;
 
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetMGpuFanBoostLimitRpm,
-					       0,
-					       NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_SetMGpuFanBoostLimitRpm,
+				0,
+				NULL);
 }
 
 static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
@@ -2635,10 +2635,10 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 		memset(smu->custom_profile_params, 0, SMU_13_0_0_CUSTOM_PARAMS_SIZE);
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_SetWorkloadMask,
-					      backend_workload_mask,
-					      NULL);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_SetWorkloadMask,
+			       backend_workload_mask,
+			       NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
 			workload_mask);
@@ -2819,10 +2819,10 @@ static int smu_v13_0_0_set_mp1_state(struct smu_context *smu,
 static int smu_v13_0_0_set_df_cstate(struct smu_context *smu,
 				     enum pp_df_cstate state)
 {
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_DFCstateControl,
-					       state,
-					       NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_DFCstateControl,
+				state,
+				NULL);
 }
 
 static void smu_v13_0_0_set_mode1_reset_param(struct smu_context *smu,
@@ -2897,8 +2897,8 @@ static int smu_v13_0_0_enable_gfx_features(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 
 	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10))
-		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableAllSmuFeatures,
-										   FEATURE_PWR_GFX, NULL);
+		return smu_cmn_send_msg(smu, SMU_MSG_EnableAllSmuFeatures,
+					FEATURE_PWR_GFX, NULL);
 	else
 		return -EOPNOTSUPP;
 }
@@ -2923,9 +2923,9 @@ static int smu_v13_0_0_smu_send_bad_mem_page_num(struct smu_context *smu,
 	int ret = 0;
 
 	/* message SMU to update the bad page number on SMUBUS */
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					  SMU_MSG_SetNumBadMemoryPagesRetired,
-					  size, NULL);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_SetNumBadMemoryPagesRetired,
+			       size, NULL);
 	if (ret)
 		dev_err(smu->adev->dev,
 			  "[%s] failed to message SMU to update bad memory pages number\n",
@@ -2940,9 +2940,9 @@ static int smu_v13_0_0_send_bad_mem_channel_flag(struct smu_context *smu,
 	int ret = 0;
 
 	/* message SMU to update the bad channel info on SMUBUS */
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-				  SMU_MSG_SetBadMemoryPagesRetiredFlagsPerChannel,
-				  size, NULL);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_SetBadMemoryPagesRetiredFlagsPerChannel,
+			       size, NULL);
 	if (ret)
 		dev_err(smu->adev->dev,
 			  "[%s] failed to message SMU to update bad memory pages channel info\n",
@@ -3118,10 +3118,10 @@ static int smu_v13_0_0_update_pcie_parameters(struct smu_context *smu,
 			smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
 			smu_pcie_arg |= pcie_table->pcie_lane[i];
 
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-								SMU_MSG_OverridePcieParameters,
-								smu_pcie_arg,
-								NULL);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_OverridePcieParameters,
+					       smu_pcie_arg,
+					       NULL);
 			if (ret)
 				break;
 		}
@@ -3137,10 +3137,10 @@ static int smu_v13_0_0_update_pcie_parameters(struct smu_context *smu,
 				smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
 				smu_pcie_arg |= pcie_table->pcie_lane[i];
 
-				ret = smu_cmn_send_smc_msg_with_param(smu,
-									SMU_MSG_OverridePcieParameters,
-									smu_pcie_arg,
-									NULL);
+				ret = smu_cmn_send_msg(smu,
+						       SMU_MSG_OverridePcieParameters,
+						       smu_pcie_arg,
+						       NULL);
 				if (ret)
 					break;
 			}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 834e7ef8079f..650aa7b15c84 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -1018,8 +1018,8 @@ static int smu_v13_0_12_get_ras_table_version(struct amdgpu_device *adev,
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
-	return smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_GetRASTableVersion, 0, table_version);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_GetRASTableVersion, 0, table_version);
 }
 
 static int smu_v13_0_12_get_badpage_count(struct amdgpu_device *adev, uint32_t *count,
@@ -1032,8 +1032,8 @@ static int smu_v13_0_12_get_badpage_count(struct amdgpu_device *adev, uint32_t *
 	now = (uint64_t)ktime_to_ms(ktime_get());
 	end = now + timeout;
 	do {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_GetBadPageCount, 0, count);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_GetBadPageCount, 0, count);
 		/* eeprom is not ready */
 		if (ret != -EBUSY)
 			return ret;
@@ -1050,8 +1050,8 @@ static int smu_v13_0_12_set_timestamp(struct amdgpu_device *adev, uint64_t times
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
-	return smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_SetTimestamp, (uint32_t)timestamp, 0);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_SetTimestamp, (uint32_t)timestamp, 0);
 }
 
 static int smu_v13_0_12_get_timestamp(struct amdgpu_device *adev,
@@ -1061,8 +1061,8 @@ static int smu_v13_0_12_get_timestamp(struct amdgpu_device *adev,
 	uint32_t temp;
 	int ret;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_GetTimestamp, index, &temp);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_GetTimestamp, index, &temp);
 	if (!ret)
 		*timestamp = temp;
 
@@ -1077,14 +1077,14 @@ static int smu_v13_0_12_get_badpage_ipid(struct amdgpu_device *adev,
 	int ret;
 
 	temp_arg = index | (1 << 16);
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_GetBadPageIpid, temp_arg, &temp_ipid_lo);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_GetBadPageIpid, temp_arg, &temp_ipid_lo);
 	if (ret)
 		return ret;
 
 	temp_arg = index | (2 << 16);
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_GetBadPageIpid, temp_arg, &temp_ipid_high);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_GetBadPageIpid, temp_arg, &temp_ipid_high);
 	if (!ret)
 		*ipid = (uint64_t)temp_ipid_high << 32 | temp_ipid_lo;
 	return ret;
@@ -1095,8 +1095,8 @@ static int smu_v13_0_12_erase_ras_table(struct amdgpu_device *adev,
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
 
-	return smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_EraseRasTable, 0, result);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_EraseRasTable, 0, result);
 }
 
 static int smu_v13_0_12_get_badpage_mca_addr(struct amdgpu_device *adev,
@@ -1107,14 +1107,14 @@ static int smu_v13_0_12_get_badpage_mca_addr(struct amdgpu_device *adev,
 	int ret;
 
 	temp_arg = index | (1 << 16);
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_GetBadPageMcaAddr, temp_arg, &temp_addr_lo);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_GetBadPageMcaAddr, temp_arg, &temp_addr_lo);
 	if (ret)
 		return ret;
 
 	temp_arg = index | (2 << 16);
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-			SMU_MSG_GetBadPageMcaAddr, temp_arg, &temp_addr_high);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_GetBadPageMcaAddr, temp_arg, &temp_addr_high);
 	if (!ret)
 		*mca_addr = (uint64_t)temp_addr_high << 32 | temp_addr_lo;
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 85e34c890672..07a0a624b631 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -235,8 +235,8 @@ static int smu_v13_0_4_system_features_control(struct smu_context *smu, bool en)
 			 * MP1_UNLOAD message to prevent GC/RLC/PMFW from entering
 			 * an invalid state.
 			 */
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
-							      SMU_RESET_MODE_2, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_GfxDeviceDriverReset,
+					       SMU_RESET_MODE_2, NULL);
 			if (ret)
 				return ret;
 		}
@@ -410,14 +410,14 @@ static int smu_v13_0_4_get_current_clk_freq(struct smu_context *smu,
 		member_type = METRICS_AVERAGE_UCLK;
 		break;
 	case SMU_FCLK:
-		return smu_cmn_send_smc_msg_with_param(smu,
-						       SMU_MSG_GetFclkFrequency,
-						       0, value);
+		return smu_cmn_send_msg(smu,
+					SMU_MSG_GetFclkFrequency,
+					0, value);
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-		return smu_cmn_send_smc_msg_with_param(smu,
-						       SMU_MSG_GetGfxclkFrequency,
-						       0, value);
+		return smu_cmn_send_msg(smu,
+					SMU_MSG_GetGfxclkFrequency,
+					0, value);
 		break;
 	default:
 		return -EINVAL;
@@ -881,12 +881,12 @@ static int smu_v13_0_4_set_soft_freq_limited_range(struct smu_context *smu,
 		max_clk = max << SMU_13_VCLK_SHIFT;
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min_clk, NULL);
+	ret = smu_cmn_send_msg(smu, msg_set_min, min_clk, NULL);
 	if (ret)
 		return ret;
 
-	return smu_cmn_send_smc_msg_with_param(smu, msg_set_max,
-					       max_clk, NULL);
+	return smu_cmn_send_msg(smu, msg_set_max,
+				max_clk, NULL);
 }
 
 static int smu_v13_0_4_force_clk_levels(struct smu_context *smu,
@@ -1080,8 +1080,8 @@ static int smu_v13_0_4_set_performance_level(struct smu_context *smu,
 
 static int smu_v13_0_4_mode2_reset(struct smu_context *smu)
 {
-	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
-					       SMU_RESET_MODE_2, NULL);
+	return smu_cmn_send_msg(smu, SMU_MSG_GfxDeviceDriverReset,
+				SMU_RESET_MODE_2, NULL);
 }
 
 static int smu_v13_0_4_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index ed6fa13f3119..2b9136dcf10c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -204,11 +204,11 @@ static int smu_v13_0_5_dpm_set_vcn_enable(struct smu_context *smu,
 
 	/* vcn dpm on is a prerequisite for vcn power gate messages */
 	if (enable)
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn,
-						      0, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_PowerUpVcn,
+				       0, NULL);
 	else
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn,
-						      0, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_PowerDownVcn,
+				       0, NULL);
 
 	return ret;
 }
@@ -218,12 +218,12 @@ static int smu_v13_0_5_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 	int ret = 0;
 
 	if (enable)
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg,
-						      0, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_PowerUpJpeg,
+				       0, NULL);
 	else
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_PowerDownJpeg, 0,
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_PowerDownJpeg, 0,
+				       NULL);
 
 	return ret;
 }
@@ -247,7 +247,7 @@ static int smu_v13_0_5_mode_reset(struct smu_context *smu, int type)
 {
 	int ret = 0;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, type, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GfxDeviceDriverReset, type, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "Failed to mode reset!\n");
 
@@ -575,15 +575,15 @@ static int smu_v13_0_5_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM
 				return -EINVAL;
 			}
 
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
-									smu->gfx_actual_hard_min_freq, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMinGfxClk,
+					       smu->gfx_actual_hard_min_freq, NULL);
 			if (ret) {
 				dev_err(smu->adev->dev, "Set hard min sclk failed!");
 				return ret;
 			}
 
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
-									smu->gfx_actual_soft_max_freq, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxGfxClk,
+					       smu->gfx_actual_soft_max_freq, NULL);
 			if (ret) {
 				dev_err(smu->adev->dev, "Set soft max sclk failed!");
 				return ret;
@@ -618,8 +618,8 @@ static int smu_v13_0_5_get_current_clk_freq(struct smu_context *smu,
 		break;
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-		return smu_cmn_send_smc_msg_with_param(smu,
-				SMU_MSG_GetGfxclkFrequency, 0, value);
+		return smu_cmn_send_msg(smu,
+					SMU_MSG_GetGfxclkFrequency, 0, value);
 		break;
 	default:
 		return -EINVAL;
@@ -852,11 +852,11 @@ static int smu_v13_0_5_set_soft_freq_limited_range(struct smu_context *smu,
 		max_clk = max << SMU_13_VCLK_SHIFT;
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min_clk, NULL);
+	ret = smu_cmn_send_msg(smu, msg_set_min, min_clk, NULL);
 	if (ret)
 		goto out;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max_clk, NULL);
+	ret = smu_cmn_send_msg(smu, msg_set_max, max_clk, NULL);
 	if (ret)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 1266867108e5..5f2269bb53e8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -642,8 +642,8 @@ static int smu_v13_0_6_select_policy_soc_pstate(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetThrottlingPolicy,
-					      param, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetThrottlingPolicy,
+			       param, NULL);
 
 	if (ret)
 		dev_err(adev->dev, "select soc pstate policy %d failed",
@@ -672,12 +672,10 @@ static int smu_v13_0_6_select_plpd_policy(struct smu_context *smu, int level)
 	}
 
 	if (level == XGMI_PLPD_DISALLOW)
-		ret = smu_cmn_send_smc_msg_with_param(
-			smu, SMU_MSG_GmiPwrDnControl, param, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_GmiPwrDnControl, param, NULL);
 	else
 		/* change xgmi per-link power down policy */
-		ret = smu_cmn_send_smc_msg_with_param(
-			smu, SMU_MSG_SelectPLPDMode, param, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SelectPLPDMode, param, NULL);
 
 	if (ret)
 		dev_err(adev->dev,
@@ -1043,8 +1041,8 @@ static int smu_v13_0_6_get_dpm_ultimate_freq(struct smu_context *smu,
 			ret = smu_cmn_send_msg(smu,
 					       SMU_MSG_GetMaxGfxclkFrequency, max);
 		else
-			ret = smu_cmn_send_smc_msg_with_param(
-				smu, SMU_MSG_GetMaxDpmFreq, param, max);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_GetMaxDpmFreq, param, max);
 		if (ret)
 			goto failed;
 	}
@@ -1054,8 +1052,8 @@ static int smu_v13_0_6_get_dpm_ultimate_freq(struct smu_context *smu,
 			ret = smu_cmn_send_msg(smu,
 					       SMU_MSG_GetMinGfxclkFrequency, min);
 		else
-			ret = smu_cmn_send_smc_msg_with_param(
-				smu, SMU_MSG_GetMinDpmFreq, param, min);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_GetMinDpmFreq, param, min);
 	}
 
 failed:
@@ -1468,11 +1466,10 @@ static int smu_v13_0_6_upload_dpm_level(struct smu_context *smu, bool max,
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
 	    (feature_mask & FEATURE_MASK(FEATURE_DPM_GFXCLK))) {
 		freq = dpm_context->dpm_tables.gfx_table.dpm_levels[level].value;
-		ret = smu_cmn_send_smc_msg_with_param(
-			smu,
-			(max ? SMU_MSG_SetSoftMaxGfxClk :
-			       SMU_MSG_SetSoftMinGfxclk),
-			freq & 0xffff, NULL);
+		ret = smu_cmn_send_msg(smu,
+				       (max ? SMU_MSG_SetSoftMaxGfxClk :
+					SMU_MSG_SetSoftMinGfxclk),
+				       freq & 0xffff, NULL);
 		if (ret) {
 			dev_err(smu->adev->dev,
 				"Failed to set soft %s gfxclk !\n",
@@ -1485,11 +1482,10 @@ static int smu_v13_0_6_upload_dpm_level(struct smu_context *smu, bool max,
 	    (feature_mask & FEATURE_MASK(FEATURE_DPM_UCLK))) {
 		freq = dpm_context->dpm_tables.uclk_table.dpm_levels[level]
 			       .value;
-		ret = smu_cmn_send_smc_msg_with_param(
-			smu,
-			(max ? SMU_MSG_SetSoftMaxByFreq :
-			       SMU_MSG_SetSoftMinByFreq),
-			(PPCLK_UCLK << 16) | (freq & 0xffff), NULL);
+		ret = smu_cmn_send_msg(smu,
+				       (max ? SMU_MSG_SetSoftMaxByFreq :
+					SMU_MSG_SetSoftMinByFreq),
+				       (PPCLK_UCLK << 16) | (freq & 0xffff), NULL);
 		if (ret) {
 			dev_err(smu->adev->dev,
 				"Failed to set soft %s memclk !\n",
@@ -1501,11 +1497,10 @@ static int smu_v13_0_6_upload_dpm_level(struct smu_context *smu, bool max,
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT) &&
 	    (feature_mask & FEATURE_MASK(FEATURE_DPM_SOCCLK))) {
 		freq = dpm_context->dpm_tables.soc_table.dpm_levels[level].value;
-		ret = smu_cmn_send_smc_msg_with_param(
-			smu,
-			(max ? SMU_MSG_SetSoftMaxByFreq :
-			       SMU_MSG_SetSoftMinByFreq),
-			(PPCLK_SOCCLK << 16) | (freq & 0xffff), NULL);
+		ret = smu_cmn_send_msg(smu,
+				       (max ? SMU_MSG_SetSoftMaxByFreq :
+					SMU_MSG_SetSoftMinByFreq),
+				       (PPCLK_SOCCLK << 16) | (freq & 0xffff), NULL);
 		if (ret) {
 			dev_err(smu->adev->dev,
 				"Failed to set soft %s socclk !\n",
@@ -1761,8 +1756,8 @@ static int smu_v13_0_6_set_power_limit(struct smu_context *smu,
 				limit, pptable->PPT1Min, pptable->PPT1Max);
 			return -EINVAL;
 		}
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetFastPptLimit,
-						      limit, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetFastPptLimit,
+				       limit, NULL);
 		if (ret)
 			dev_err(smu->adev->dev, "Set fast PPT limit failed!\n");
 		return ret;
@@ -1940,7 +1935,7 @@ static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool enable)
 	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(MCA_DEBUG_MODE)))
 		return 0;
 
-	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,
+	return smu_cmn_send_msg(smu, SMU_MSG_ClearMcaOnRead,
 					       enable ? 0 : ClearMcaOnRead_UE_FLAG_MASK | ClearMcaOnRead_CE_POLL_MASK,
 					       NULL);
 }
@@ -1971,13 +1966,13 @@ static int smu_v13_0_6_set_gfx_soft_freq_limited_range(struct smu_context *smu,
 {
 	int ret;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
-					      max & 0xffff, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxGfxClk,
+			       max & 0xffff, NULL);
 	if (ret)
 		return ret;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinGfxclk,
-					      min & 0xffff, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMinGfxclk,
+			       min & 0xffff, NULL);
 
 	return ret;
 }
@@ -2127,8 +2122,7 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
 								  max_clk);
 		if (!ret) {
 			usleep_range(500, 1000);
-			ret = smu_cmn_send_smc_msg_with_param(
-				smu, SMU_MSG_EnableDeterminism, max, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_EnableDeterminism, max, NULL);
 			if (ret) {
 				dev_err(adev->dev,
 					"Failed to enable determinism at GFX clock %d MHz\n",
@@ -3061,44 +3055,44 @@ static int smu_v13_0_6_get_thermal_temperature_range(struct smu_context *smu,
 		return 0;
 
 	/* Get SOC Max operating temperature */
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
-					      PPSMC_AID_THM_TYPE, &aid_temp);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GetCTFLimit,
+			       PPSMC_AID_THM_TYPE, &aid_temp);
 	if (ret)
 		goto failed;
 	if (adev->flags & AMD_IS_APU) {
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
-						      PPSMC_CCD_THM_TYPE, &ccd_temp);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_GetCTFLimit,
+				       PPSMC_CCD_THM_TYPE, &ccd_temp);
 		if (ret)
 			goto failed;
 	}
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
-					      PPSMC_XCD_THM_TYPE, &xcd_temp);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GetCTFLimit,
+			       PPSMC_XCD_THM_TYPE, &xcd_temp);
 	if (ret)
 		goto failed;
 	range->hotspot_emergency_max = max3(aid_temp, xcd_temp, ccd_temp) *
 				       SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 
 	/* Get HBM Max operating temperature */
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetCTFLimit,
-					      PPSMC_HBM_THM_TYPE, &max_temp);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GetCTFLimit,
+			       PPSMC_HBM_THM_TYPE, &max_temp);
 	if (ret)
 		goto failed;
 	range->mem_emergency_max =
 		max_temp * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 
 	/* Get SOC thermal throttle limit */
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetThermalLimit,
-					      PPSMC_THROTTLING_LIMIT_TYPE_SOCKET,
-					      &max_temp);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GetThermalLimit,
+			       PPSMC_THROTTLING_LIMIT_TYPE_SOCKET,
+			       &max_temp);
 	if (ret)
 		goto failed;
 	range->hotspot_crit_max =
 		max_temp * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 
 	/* Get HBM thermal throttle limit */
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetThermalLimit,
-					      PPSMC_THROTTLING_LIMIT_TYPE_HBM,
-					      &max_temp);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GetThermalLimit,
+			       PPSMC_THROTTLING_LIMIT_TYPE_HBM,
+			       &max_temp);
 	if (ret)
 		goto failed;
 
@@ -3122,8 +3116,8 @@ static int smu_v13_0_6_mode1_reset(struct smu_context *smu)
 		fatal_err = 1;
 
 	param |= (fatal_err << 16);
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
-					      param, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GfxDeviceDriverReset,
+			       param, NULL);
 
 	if (!ret)
 		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
@@ -3135,8 +3129,8 @@ static int smu_v13_0_6_link_reset(struct smu_context *smu)
 {
 	int ret = 0;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
-					      SMU_RESET_MODE_4, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GfxDeviceDriverReset,
+			       SMU_RESET_MODE_4, NULL);
 	return ret;
 }
 
@@ -3162,8 +3156,7 @@ static int smu_v13_0_6_smu_send_hbm_bad_page_num(struct smu_context *smu,
 	int ret = 0;
 
 	/* message SMU to update the bad page number on SMUBUS */
-	ret = smu_cmn_send_smc_msg_with_param(
-		smu, SMU_MSG_SetNumBadHbmPagesRetired, size, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetNumBadHbmPagesRetired, size, NULL);
 	if (ret)
 		dev_err(smu->adev->dev,
 			"[%s] failed to message SMU to update HBM bad pages number\n",
@@ -3216,8 +3209,7 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 	if (!smu_v13_0_6_reset_sdma_is_supported(smu))
 		return -EOPNOTSUPP;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-						SMU_MSG_ResetSDMA, inst_mask, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_ResetSDMA, inst_mask, NULL);
 	if (ret)
 		dev_err(smu->adev->dev,
 			"failed to send ResetSDMA event with mask 0x%x\n",
@@ -3235,7 +3227,7 @@ static int smu_v13_0_6_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
 {
 	int ret = 0;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ResetVCN, inst_mask, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_ResetVCN, inst_mask, NULL);
 	if (ret)
 		dev_err(smu->adev->dev,
 			"failed to send ResetVCN event with mask 0x%x\n",
@@ -3264,7 +3256,7 @@ static int smu_v13_0_6_ras_send_msg(struct smu_context *smu, enum smu_message_ty
 	case SMU_MSG_GetTimestamp:
 	case SMU_MSG_GetBadPageIpid:
 	case SMU_MSG_EraseRasTable:
-		ret = smu_cmn_send_smc_msg_with_param(smu, msg, param, read_arg);
+		ret = smu_cmn_send_msg(smu, msg, param, read_arg);
 		break;
 	default:
 		ret = -EPERM;
@@ -3340,7 +3332,7 @@ static int __smu_v13_0_6_mca_dump_bank(struct smu_context *smu, enum amdgpu_mca_
 
 	param = ((idx & 0xffff) << 16) | (offset & 0xfffc);
 
-	return smu_cmn_send_smc_msg_with_param(smu, msg, param, val);
+	return smu_cmn_send_msg(smu, msg, param, val);
 }
 
 static int smu_v13_0_6_mca_dump_bank(struct smu_context *smu, enum amdgpu_mca_error_type type,
@@ -3824,7 +3816,7 @@ static int __smu_v13_0_6_aca_bank_dump(struct smu_context *smu, enum aca_smu_typ
 
 	param = ((idx & 0xffff) << 16) | (offset & 0xfffc);
 
-	return smu_cmn_send_smc_msg_with_param(smu, msg, param, (uint32_t *)val);
+	return smu_cmn_send_msg(smu, msg, param, (uint32_t *)val);
 }
 
 static int smu_v13_0_6_aca_bank_dump(struct smu_context *smu, enum aca_smu_type type,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 3ad756e14174..5cc15545da6e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2366,10 +2366,10 @@ static int smu_v13_0_7_enable_mgpu_fan_boost(struct smu_context *smu)
 	if (skutable->MGpuAcousticLimitRpmThreshold == 0)
 		return 0;
 
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetMGpuFanBoostLimitRpm,
-					       0,
-					       NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_SetMGpuFanBoostLimitRpm,
+				0,
+				NULL);
 }
 
 static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
@@ -2591,8 +2591,8 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
 		memset(smu->custom_profile_params, 0, SMU_13_0_7_CUSTOM_PARAMS_SIZE);
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-					      backend_workload_mask, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetWorkloadMask,
+			       backend_workload_mask, NULL);
 
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
@@ -2636,10 +2636,10 @@ static bool smu_v13_0_7_is_mode1_reset_supported(struct smu_context *smu)
 static int smu_v13_0_7_set_df_cstate(struct smu_context *smu,
 				     enum pp_df_cstate state)
 {
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_DFCstateControl,
-					       state,
-					       NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_DFCstateControl,
+				state,
+				NULL);
 }
 
 static bool smu_v13_0_7_wbrf_support_check(struct smu_context *smu)
@@ -2746,10 +2746,10 @@ static int smu_v13_0_7_update_pcie_parameters(struct smu_context *smu,
 			smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
 			smu_pcie_arg |= pcie_table->pcie_lane[i];
 
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-								SMU_MSG_OverridePcieParameters,
-								smu_pcie_arg,
-								NULL);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_OverridePcieParameters,
+					       smu_pcie_arg,
+					       NULL);
 			if (ret)
 				break;
 		}
@@ -2765,10 +2765,10 @@ static int smu_v13_0_7_update_pcie_parameters(struct smu_context *smu,
 				smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
 				smu_pcie_arg |= pcie_table->pcie_lane[i];
 
-				ret = smu_cmn_send_smc_msg_with_param(smu,
-									SMU_MSG_OverridePcieParameters,
-									smu_pcie_arg,
-									NULL);
+				ret = smu_cmn_send_msg(smu,
+						       SMU_MSG_OverridePcieParameters,
+						       smu_pcie_arg,
+						       NULL);
 				if (ret)
 					break;
 			}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index bcf472e5b415..7fbf2b111d38 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -231,11 +231,11 @@ static int yellow_carp_dpm_set_vcn_enable(struct smu_context *smu,
 
 	/* vcn dpm on is a prerequisite for vcn power gate messages */
 	if (enable)
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn,
-						      0, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_PowerUpVcn,
+				       0, NULL);
 	else
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn,
-						      0, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_PowerDownVcn,
+				       0, NULL);
 
 	return ret;
 }
@@ -245,12 +245,12 @@ static int yellow_carp_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
 	int ret = 0;
 
 	if (enable)
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg,
-						      0, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_PowerUpJpeg,
+				       0, NULL);
 	else
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_PowerDownJpeg, 0,
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_PowerDownJpeg, 0,
+				       NULL);
 
 	return ret;
 }
@@ -286,7 +286,7 @@ static int yellow_carp_mode_reset(struct smu_context *smu, int type)
 {
 	int ret = 0;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, type, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GfxDeviceDriverReset, type, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "Failed to mode reset!\n");
 
@@ -706,15 +706,15 @@ static int yellow_carp_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM
 				return -EINVAL;
 			}
 
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
-									smu->gfx_actual_hard_min_freq, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMinGfxClk,
+					       smu->gfx_actual_hard_min_freq, NULL);
 			if (ret) {
 				dev_err(smu->adev->dev, "Set hard min sclk failed!");
 				return ret;
 			}
 
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
-									smu->gfx_actual_soft_max_freq, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxGfxClk,
+					       smu->gfx_actual_soft_max_freq, NULL);
 			if (ret) {
 				dev_err(smu->adev->dev, "Set soft max sclk failed!");
 				return ret;
@@ -748,12 +748,12 @@ static int yellow_carp_get_current_clk_freq(struct smu_context *smu,
 		member_type = METRICS_AVERAGE_UCLK;
 		break;
 	case SMU_FCLK:
-		return smu_cmn_send_smc_msg_with_param(smu,
-				SMU_MSG_GetFclkFrequency, 0, value);
+		return smu_cmn_send_msg(smu,
+					SMU_MSG_GetFclkFrequency, 0, value);
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-		return smu_cmn_send_smc_msg_with_param(smu,
-				SMU_MSG_GetGfxclkFrequency, 0, value);
+		return smu_cmn_send_msg(smu,
+					SMU_MSG_GetGfxclkFrequency, 0, value);
 		break;
 	default:
 		return -EINVAL;
@@ -995,12 +995,12 @@ static int yellow_carp_set_soft_freq_limited_range(struct smu_context *smu,
 		max_clk = max << SMU_13_VCLK_SHIFT;
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min_clk, NULL);
+	ret = smu_cmn_send_msg(smu, msg_set_min, min_clk, NULL);
 
 	if (ret)
 		goto out;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max_clk, NULL);
+	ret = smu_cmn_send_msg(smu, msg_set_max, max_clk, NULL);
 	if (ret)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 395626e4732c..7002b52ac9bc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -683,16 +683,16 @@ int smu_v14_0_notify_memory_pool_location(struct smu_context *smu)
 	address_high = (uint32_t)upper_32_bits(address);
 	address_low  = (uint32_t)lower_32_bits(address);
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramAddrHigh,
-					      address_high, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_DramLogSetDramAddrHigh,
+			       address_high, NULL);
 	if (ret)
 		return ret;
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramAddrLow,
-					      address_low, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_DramLogSetDramAddrLow,
+			       address_low, NULL);
 	if (ret)
 		return ret;
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DramLogSetDramSize,
-					      (uint32_t)memory_pool->size, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_DramLogSetDramSize,
+			       (uint32_t)memory_pool->size, NULL);
 	if (ret)
 		return ret;
 
@@ -705,15 +705,15 @@ int smu_v14_0_set_driver_table_location(struct smu_context *smu)
 	int ret = 0;
 
 	if (driver_table->mc_address) {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_SetDriverDramAddrHigh,
-						      upper_32_bits(driver_table->mc_address),
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_SetDriverDramAddrHigh,
+				       upper_32_bits(driver_table->mc_address),
+				       NULL);
 		if (!ret)
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-							      SMU_MSG_SetDriverDramAddrLow,
-							      lower_32_bits(driver_table->mc_address),
-							      NULL);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_SetDriverDramAddrLow,
+					       lower_32_bits(driver_table->mc_address),
+					       NULL);
 	}
 
 	return ret;
@@ -725,15 +725,15 @@ int smu_v14_0_set_tool_table_location(struct smu_context *smu)
 	struct smu_table *tool_table = &smu->smu_table.tables[SMU_TABLE_PMSTATUSLOG];
 
 	if (tool_table->mc_address) {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_SetToolsDramAddrHigh,
-						      upper_32_bits(tool_table->mc_address),
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_SetToolsDramAddrHigh,
+				       upper_32_bits(tool_table->mc_address),
+				       NULL);
 		if (!ret)
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-							      SMU_MSG_SetToolsDramAddrLow,
-							      lower_32_bits(tool_table->mc_address),
-							      NULL);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_SetToolsDramAddrLow,
+					       lower_32_bits(tool_table->mc_address),
+					       NULL);
 	}
 
 	return ret;
@@ -751,15 +751,15 @@ int smu_v14_0_set_allowed_mask(struct smu_context *smu)
 
 	smu_feature_list_to_arr32(smu, SMU_FEATURE_LIST_ALLOWED, feature_mask);
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
-					      feature_mask[1], NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
+			       feature_mask[1], NULL);
 	if (ret)
 		return ret;
 
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetAllowedFeaturesMaskLow,
-					       feature_mask[0],
-					       NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_SetAllowedFeaturesMaskLow,
+				feature_mask[0],
+				NULL);
 }
 
 int smu_v14_0_gfx_off_control(struct smu_context *smu, bool enable)
@@ -792,7 +792,7 @@ int smu_v14_0_system_features_control(struct smu_context *smu,
 				      bool en)
 {
 	return smu_cmn_send_msg(smu, (en ? SMU_MSG_EnableAllSmuFeatures :
-					  SMU_MSG_DisableAllSmuFeatures));
+				      SMU_MSG_DisableAllSmuFeatures));
 }
 
 int smu_v14_0_notify_display_change(struct smu_context *smu)
@@ -804,7 +804,7 @@ int smu_v14_0_notify_display_change(struct smu_context *smu)
 
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
 	    smu->adev->gmc.vram_type == AMDGPU_VRAM_TYPE_HBM)
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL);
 
 	return ret;
 }
@@ -826,10 +826,10 @@ int smu_v14_0_get_current_power_limit(struct smu_context *smu,
 	if (power_src < 0)
 		return -EINVAL;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_GetPptLimit,
-					      power_src << 16,
-					      power_limit);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_GetPptLimit,
+			       power_src << 16,
+			       power_limit);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] get PPT limit failed!", __func__);
 
@@ -850,7 +850,7 @@ int smu_v14_0_set_power_limit(struct smu_context *smu,
 		return -EOPNOTSUPP;
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, limit, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetPptLimit, limit, NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "[%s] Set power limit Failed!\n", __func__);
 		return ret;
@@ -1134,21 +1134,21 @@ int smu_v14_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 
 	if (max) {
 		if (smu->adev->pm.ac_power)
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-							      SMU_MSG_GetMaxDpmFreq,
-							      param,
-							      max);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_GetMaxDpmFreq,
+					       param,
+					       max);
 		else
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-							      SMU_MSG_GetDcModeMaxDpmFreq,
-							      param,
-							      max);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_GetDcModeMaxDpmFreq,
+					       param,
+					       max);
 		if (ret)
 			goto failed;
 	}
 
 	if (min) {
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetMinDpmFreq, param, min);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_GetMinDpmFreq, param, min);
 		if (ret)
 			goto failed;
 	}
@@ -1181,8 +1181,8 @@ int smu_v14_0_set_soft_freq_limited_range(struct smu_context *smu,
 			param = (uint32_t)((clk_id << 16) | 0xffff);
 		else
 			param = (uint32_t)((clk_id << 16) | (max & 0xffff));
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
-						      param, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxByFreq,
+				       param, NULL);
 		if (ret)
 			goto out;
 	}
@@ -1192,8 +1192,8 @@ int smu_v14_0_set_soft_freq_limited_range(struct smu_context *smu,
 			param = (uint32_t)((clk_id << 16) | 0);
 		else
 			param = (uint32_t)((clk_id << 16) | (min & 0xffff));
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinByFreq,
-						      param, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMinByFreq,
+				       param, NULL);
 		if (ret)
 			goto out;
 	}
@@ -1224,16 +1224,16 @@ int smu_v14_0_set_hard_freq_limited_range(struct smu_context *smu,
 
 	if (max > 0) {
 		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMaxByFreq,
-						      param, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMaxByFreq,
+				       param, NULL);
 		if (ret)
 			return ret;
 	}
 
 	if (min > 0) {
 		param = (uint32_t)((clk_id << 16) | (min & 0xffff));
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinByFreq,
-						      param, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMinByFreq,
+				       param, NULL);
 		if (ret)
 			return ret;
 	}
@@ -1424,10 +1424,10 @@ int smu_v14_0_set_power_source(struct smu_context *smu,
 	if (pwr_source < 0)
 		return -EINVAL;
 
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_NotifyPowerSource,
-					       pwr_source,
-					       NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_NotifyPowerSource,
+				pwr_source,
+				NULL);
 }
 
 static int smu_v14_0_get_dpm_freq_by_index(struct smu_context *smu,
@@ -1452,10 +1452,10 @@ static int smu_v14_0_get_dpm_freq_by_index(struct smu_context *smu,
 
 	param = (uint32_t)(((clk_id & 0xffff) << 16) | (level & 0xffff));
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_GetDpmFreqByIndex,
-					      param,
-					      value);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_GetDpmFreqByIndex,
+			       param,
+			       value);
 	if (ret)
 		return ret;
 
@@ -1497,10 +1497,10 @@ static int smu_v14_0_get_fine_grained_status(struct smu_context *smu,
 
 	param = (uint32_t)(((clk_id & 0xffff) << 16) | 0xff);
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_GetDpmFreqByIndex,
-					      param,
-					      &value);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_GetDpmFreqByIndex,
+			       param,
+			       &value);
 	if (ret)
 		return ret;
 
@@ -1568,17 +1568,17 @@ int smu_v14_0_set_vcn_enable(struct smu_context *smu,
 
 	if (smu->is_apu) {
 		if (inst == 0)
-			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-							      SMU_MSG_PowerUpVcn0 : SMU_MSG_PowerDownVcn0,
-							      inst << 16U, NULL);
+			ret = smu_cmn_send_msg(smu, enable ?
+					       SMU_MSG_PowerUpVcn0 : SMU_MSG_PowerDownVcn0,
+					       inst << 16U, NULL);
 		else if (inst == 1)
-			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-							      SMU_MSG_PowerUpVcn1 : SMU_MSG_PowerDownVcn1,
-							      inst << 16U, NULL);
+			ret = smu_cmn_send_msg(smu, enable ?
+					       SMU_MSG_PowerUpVcn1 : SMU_MSG_PowerDownVcn1,
+					       inst << 16U, NULL);
 	} else {
-		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-						      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
-						      inst << 16U, NULL);
+		ret = smu_cmn_send_msg(smu, enable ?
+				       SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+				       inst << 16U, NULL);
 	}
 
 	return ret;
@@ -1596,17 +1596,17 @@ int smu_v14_0_set_jpeg_enable(struct smu_context *smu,
 
 		if (smu->is_apu) {
 			if (i == 0)
-				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-								      SMU_MSG_PowerUpJpeg0 : SMU_MSG_PowerDownJpeg0,
-								      i << 16U, NULL);
+				ret = smu_cmn_send_msg(smu, enable ?
+						       SMU_MSG_PowerUpJpeg0 : SMU_MSG_PowerDownJpeg0,
+						       i << 16U, NULL);
 			else if (i == 1 && amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
-				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-								      SMU_MSG_PowerUpJpeg1 : SMU_MSG_PowerDownJpeg1,
-								      i << 16U, NULL);
+				ret = smu_cmn_send_msg(smu, enable ?
+						       SMU_MSG_PowerUpJpeg1 : SMU_MSG_PowerDownJpeg1,
+						       i << 16U, NULL);
 		} else {
-			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-							      SMU_MSG_PowerUpJpeg : SMU_MSG_PowerDownJpeg,
-							      i << 16U, NULL);
+			ret = smu_cmn_send_msg(smu, enable ?
+					       SMU_MSG_PowerUpJpeg : SMU_MSG_PowerDownJpeg,
+					       i << 16U, NULL);
 		}
 
 		if (ret)
@@ -1632,7 +1632,7 @@ int smu_v14_0_gpo_control(struct smu_context *smu,
 {
 	int res;
 
-	res = smu_cmn_send_smc_msg_with_param(smu,
+	res = smu_cmn_send_msg(smu,
 					      SMU_MSG_AllowGpo,
 					      enablement ? 1 : 0,
 					      NULL);
@@ -1732,10 +1732,10 @@ int smu_v14_0_baco_set_armd3_sequence(struct smu_context *smu,
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
 	int ret;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_ArmD3,
-					      baco_seq,
-					      NULL);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_ArmD3,
+			       baco_seq,
+			       NULL);
 	if (ret)
 		return ret;
 
@@ -1789,11 +1789,11 @@ int smu_v14_0_baco_set_state(struct smu_context *smu,
 		return 0;
 
 	if (state == SMU_BACO_STATE_ENTER) {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_EnterBaco,
-						      (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
-						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
-						      NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_EnterBaco,
+				       (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
+				       BACO_SEQ_BAMACO : BACO_SEQ_BACO,
+				       NULL);
 	} else {
 		ret = smu_cmn_send_msg(smu, SMU_MSG_ExitBaco);
 		if (ret)
@@ -1837,8 +1837,8 @@ int smu_v14_0_set_gfx_power_up_by_imu(struct smu_context *smu)
 	int ret;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableGfxImu,
-						       ENABLE_IMU_ARG_GFXOFF_ENABLE, NULL);
+		return smu_cmn_send_msg(smu, SMU_MSG_EnableGfxImu,
+					ENABLE_IMU_ARG_GFXOFF_ENABLE, NULL);
 	}
 
 	mutex_lock(&ctl->lock);
@@ -1916,17 +1916,17 @@ int smu_v14_0_od_edit_dpm_table(struct smu_context *smu,
 			return -EINVAL;
 		}
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
-						      smu->gfx_actual_hard_min_freq,
-						      NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMinGfxClk,
+				       smu->gfx_actual_hard_min_freq,
+				       NULL);
 		if (ret) {
 			dev_err(smu->adev->dev, "Set hard min sclk failed!");
 			return ret;
 		}
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
-						      smu->gfx_actual_soft_max_freq,
-						      NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxGfxClk,
+				       smu->gfx_actual_soft_max_freq,
+				       NULL);
 		if (ret) {
 			dev_err(smu->adev->dev, "Set soft max sclk failed!");
 			return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 0be0b11be79a..e58d52963735 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -624,8 +624,8 @@ static int smu_v14_0_0_mode2_reset(struct smu_context *smu)
 {
 	int ret;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
-					       SMU_RESET_MODE_2, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GfxDeviceDriverReset,
+			       SMU_RESET_MODE_2, NULL);
 
 	if (ret)
 		dev_err(smu->adev->dev, "Failed to mode2 reset!\n");
@@ -1260,10 +1260,10 @@ static int smu_v14_0_0_set_soft_freq_limited_range(struct smu_context *smu,
 	}
 
 	if (min && msg_set_min != SMU_MSG_MAX_COUNT)
-		ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min, NULL);
+		ret = smu_cmn_send_msg(smu, msg_set_min, min, NULL);
 
 	if (max && msg_set_max != SMU_MSG_MAX_COUNT)
-		ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_max, max, NULL);
+		ret = smu_cmn_send_msg(smu, msg_set_max, max, NULL);
 
 	return ret;
 }
@@ -1554,25 +1554,25 @@ static int smu_v14_0_common_set_fine_grain_gfx_freq_parameters(struct smu_contex
 static int smu_v14_0_0_set_vpe_enable(struct smu_context *smu,
 				      bool enable)
 {
-	return smu_cmn_send_smc_msg_with_param(smu, enable ?
-					       SMU_MSG_PowerUpVpe : SMU_MSG_PowerDownVpe,
-					       0, NULL);
+	return smu_cmn_send_msg(smu, enable ?
+				SMU_MSG_PowerUpVpe : SMU_MSG_PowerDownVpe,
+				0, NULL);
 }
 
 static int smu_v14_0_0_set_isp_enable(struct smu_context *smu,
 				      bool enable)
 {
-	return smu_cmn_send_smc_msg_with_param(smu, enable ?
-				      SMU_MSG_PowerUpIspByTile : SMU_MSG_PowerDownIspByTile,
-				      ISP_ALL_TILES_MASK, NULL);
+	return smu_cmn_send_msg(smu, enable ?
+				SMU_MSG_PowerUpIspByTile : SMU_MSG_PowerDownIspByTile,
+				ISP_ALL_TILES_MASK, NULL);
 }
 
 static int smu_v14_0_0_set_umsch_mm_enable(struct smu_context *smu,
 			      bool enable)
 {
-	return smu_cmn_send_smc_msg_with_param(smu, enable ?
-					       SMU_MSG_PowerUpUmsch : SMU_MSG_PowerDownUmsch,
-					       0, NULL);
+	return smu_cmn_send_msg(smu, enable ?
+				SMU_MSG_PowerUpUmsch : SMU_MSG_PowerDownUmsch,
+				0, NULL);
 }
 
 static int smu_14_0_1_get_dpm_table(struct smu_context *smu, struct dpm_clocks *clock_table)
@@ -1629,30 +1629,30 @@ static int smu_v14_0_1_init_mall_power_gating(struct smu_context *smu, enum smu_
 	int ret = 0;
 
 	if (pg_config == SMU_MALL_PG_CONFIG_PMFW_CONTROL) {
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_MALLPowerController,
-								SMU_MALL_PMFW_CONTROL, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_MALLPowerController,
+				       SMU_MALL_PMFW_CONTROL, NULL);
 		if (ret) {
 			dev_err(adev->dev, "Init MALL PMFW CONTROL Failure\n");
 			return ret;
 		}
 	} else {
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_MALLPowerController,
-								SMU_MALL_DRIVER_CONTROL, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_MALLPowerController,
+				       SMU_MALL_DRIVER_CONTROL, NULL);
 		if (ret) {
 			dev_err(adev->dev, "Init MALL Driver CONTROL Failure\n");
 			return ret;
 		}
 
 		if (pg_config == SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_MALLPowerState,
-									SMU_MALL_EXIT_PG, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_MALLPowerState,
+					       SMU_MALL_EXIT_PG, NULL);
 			if (ret) {
 				dev_err(adev->dev, "EXIT MALL PG Failure\n");
 				return ret;
 			}
 		} else if (pg_config == SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_OFF) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_MALLPowerState,
-									SMU_MALL_ENTER_PG, NULL);
+			ret = smu_cmn_send_msg(smu, SMU_MSG_MALLPowerState,
+					       SMU_MALL_ENTER_PG, NULL);
 			if (ret) {
 				dev_err(adev->dev, "Enter MALL PG Failure\n");
 				return ret;
@@ -1678,17 +1678,17 @@ static int smu_v14_0_0_restore_user_od_settings(struct smu_context *smu)
 {
 	int ret;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
-					      smu->gfx_actual_hard_min_freq,
-					      NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMinGfxClk,
+			       smu->gfx_actual_hard_min_freq,
+			       NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to restore hard min sclk!\n");
 		return ret;
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
-					      smu->gfx_actual_soft_max_freq,
-					      NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxGfxClk,
+			       smu->gfx_actual_soft_max_freq,
+			       NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to restore soft max sclk!\n");
 		return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index baf6866477e7..28c1b084fe62 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1431,10 +1431,10 @@ static int smu_v14_0_2_update_pcie_parameters(struct smu_context *smu,
 			smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
 			smu_pcie_arg |= pcie_table->pcie_lane[i];
 
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_OverridePcieParameters,
-						      smu_pcie_arg,
-						      NULL);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_OverridePcieParameters,
+					       smu_pcie_arg,
+					       NULL);
 			if (ret)
 				break;
 		}
@@ -1450,7 +1450,7 @@ static int smu_v14_0_2_update_pcie_parameters(struct smu_context *smu,
 				smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
 				smu_pcie_arg |= pcie_table->pcie_lane[i];
 
-				ret = smu_cmn_send_smc_msg_with_param(smu,
+				ret = smu_cmn_send_msg(smu,
 						      SMU_MSG_OverridePcieParameters,
 						      smu_pcie_arg,
 						      NULL);
@@ -1847,8 +1847,8 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 		memset(smu->custom_profile_params, 0, SMU_14_0_2_CUSTOM_PARAMS_SIZE);
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-					      backend_workload_mask, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetWorkloadMask,
+			       backend_workload_mask, NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to set workload mask 0x%08x\n",
 			workload_mask);
@@ -2050,10 +2050,10 @@ static int smu_v14_0_2_set_mp1_state(struct smu_context *smu,
 static int smu_v14_0_2_set_df_cstate(struct smu_context *smu,
 				     enum pp_df_cstate state)
 {
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_DFCstateControl,
-					       state,
-					       NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_DFCstateControl,
+				state,
+				NULL);
 }
 
 static int smu_v14_0_2_mode1_reset(struct smu_context *smu)
@@ -2090,8 +2090,8 @@ static int smu_v14_0_2_enable_gfx_features(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 
 	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 2))
-		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableAllSmuFeatures,
-										   FEATURE_PWR_GFX, NULL);
+		return smu_cmn_send_msg(smu, SMU_MSG_EnableAllSmuFeatures,
+					FEATURE_PWR_GFX, NULL);
 	else
 		return -EOPNOTSUPP;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 878dc26927f4..8e95a62e186c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -650,15 +650,15 @@ int smu_v15_0_set_allowed_mask(struct smu_context *smu)
 
 	smu_feature_list_to_arr32(smu, SMU_FEATURE_LIST_ALLOWED, feature_mask);
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
-					      feature_mask[1], NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetAllowedFeaturesMaskHigh,
+			       feature_mask[1], NULL);
 	if (ret)
 		return ret;
 
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_SetAllowedFeaturesMaskLow,
-					       feature_mask[0],
-					       NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_SetAllowedFeaturesMaskLow,
+				feature_mask[0],
+				NULL);
 }
 
 int smu_v15_0_gfx_off_control(struct smu_context *smu, bool enable)
@@ -697,7 +697,7 @@ int smu_v15_0_notify_display_change(struct smu_context *smu)
 
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
 	    smu->adev->gmc.vram_type == AMDGPU_VRAM_TYPE_HBM)
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL);
 
 	return ret;
 }
@@ -719,10 +719,10 @@ int smu_v15_0_get_current_power_limit(struct smu_context *smu,
 	if (power_src < 0)
 		return -EINVAL;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_GetPptLimit,
-					      power_src << 16,
-					      power_limit);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_GetPptLimit,
+			       power_src << 16,
+			       power_limit);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] get PPT limit failed!", __func__);
 
@@ -743,7 +743,7 @@ int smu_v15_0_set_power_limit(struct smu_context *smu,
 		return -EOPNOTSUPP;
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, limit, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetPptLimit, limit, NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "[%s] Set power limit Failed!\n", __func__);
 		return ret;
@@ -948,21 +948,21 @@ int smu_v15_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
 
 	if (max) {
 		if (smu->adev->pm.ac_power)
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-							      SMU_MSG_GetMaxDpmFreq,
-							      param,
-							      max);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_GetMaxDpmFreq,
+					       param,
+					       max);
 		else
-			ret = smu_cmn_send_smc_msg_with_param(smu,
-							      SMU_MSG_GetDcModeMaxDpmFreq,
-							      param,
-							      max);
+			ret = smu_cmn_send_msg(smu,
+					       SMU_MSG_GetDcModeMaxDpmFreq,
+					       param,
+					       max);
 		if (ret)
 			goto failed;
 	}
 
 	if (min) {
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetMinDpmFreq, param, min);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_GetMinDpmFreq, param, min);
 		if (ret)
 			goto failed;
 	}
@@ -994,8 +994,8 @@ int smu_v15_0_set_soft_freq_limited_range(struct smu_context *smu,
 			param = (uint32_t)((clk_id << 16) | 0xffff);
 		else
 			param = (uint32_t)((clk_id << 16) | (max & 0xffff));
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
-						      param, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxByFreq,
+				       param, NULL);
 		if (ret)
 			goto out;
 	}
@@ -1005,8 +1005,8 @@ int smu_v15_0_set_soft_freq_limited_range(struct smu_context *smu,
 			param = (uint32_t)((clk_id << 16) | 0);
 		else
 			param = (uint32_t)((clk_id << 16) | (min & 0xffff));
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinByFreq,
-						      param, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMinByFreq,
+				       param, NULL);
 		if (ret)
 			goto out;
 	}
@@ -1037,16 +1037,16 @@ int smu_v15_0_set_hard_freq_limited_range(struct smu_context *smu,
 
 	if (max > 0) {
 		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMaxByFreq,
-						      param, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMaxByFreq,
+				       param, NULL);
 		if (ret)
 			return ret;
 	}
 
 	if (min > 0) {
 		param = (uint32_t)((clk_id << 16) | (min & 0xffff));
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinByFreq,
-						      param, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMinByFreq,
+				       param, NULL);
 		if (ret)
 			return ret;
 	}
@@ -1237,10 +1237,10 @@ int smu_v15_0_set_power_source(struct smu_context *smu,
 	if (pwr_source < 0)
 		return -EINVAL;
 
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_NotifyPowerSource,
-					       pwr_source,
-					       NULL);
+	return smu_cmn_send_msg(smu,
+				SMU_MSG_NotifyPowerSource,
+				pwr_source,
+				NULL);
 }
 
 static int smu_v15_0_get_dpm_freq_by_index(struct smu_context *smu,
@@ -1265,10 +1265,10 @@ static int smu_v15_0_get_dpm_freq_by_index(struct smu_context *smu,
 
 	param = (uint32_t)(((clk_id & 0xffff) << 16) | (level & 0xffff));
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_GetDpmFreqByIndex,
-					      param,
-					      value);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_GetDpmFreqByIndex,
+			       param,
+			       value);
 	if (ret)
 		return ret;
 
@@ -1310,10 +1310,10 @@ static int smu_v15_0_get_fine_grained_status(struct smu_context *smu,
 
 	param = (uint32_t)(((clk_id & 0xffff) << 16) | 0xff);
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_GetDpmFreqByIndex,
-					      param,
-					      &value);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_GetDpmFreqByIndex,
+			       param,
+			       &value);
 	if (ret)
 		return ret;
 
@@ -1382,9 +1382,9 @@ int smu_v15_0_set_vcn_enable(struct smu_context *smu,
 		return ret;
 
 	if (smu->is_apu) {
-		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-						      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
-						      inst << 16U, NULL);
+		ret = smu_cmn_send_msg(smu, enable ?
+				       SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+				       inst << 16U, NULL);
 	}
 
 	return ret;
@@ -1401,9 +1401,9 @@ int smu_v15_0_set_jpeg_enable(struct smu_context *smu,
 			continue;
 
 		if (smu->is_apu) {
-				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-								      SMU_MSG_PowerUpJpeg : SMU_MSG_PowerDownJpeg,
-								      i << 16U, NULL);
+			ret = smu_cmn_send_msg(smu, enable ?
+					       SMU_MSG_PowerUpJpeg : SMU_MSG_PowerDownJpeg,
+					       i << 16U, NULL);
 		}
 
 		if (ret)
@@ -1429,10 +1429,10 @@ int smu_v15_0_gpo_control(struct smu_context *smu,
 {
 	int res;
 
-	res = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_AllowGpo,
-					      enablement ? 1 : 0,
-					      NULL);
+	res = smu_cmn_send_msg(smu,
+			       SMU_MSG_AllowGpo,
+			       enablement ? 1 : 0,
+			       NULL);
 	if (res)
 		dev_err(smu->adev->dev, "SetGpoAllow %d failed!\n", enablement);
 
@@ -1529,10 +1529,10 @@ int smu_v15_0_baco_set_armd3_sequence(struct smu_context *smu,
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
 	int ret;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					      SMU_MSG_ArmD3,
-					      baco_seq,
-					      NULL);
+	ret = smu_cmn_send_msg(smu,
+			       SMU_MSG_ArmD3,
+			       baco_seq,
+			       NULL);
 	if (ret)
 		return ret;
 
@@ -1586,15 +1586,15 @@ int smu_v15_0_baco_set_state(struct smu_context *smu,
 		return 0;
 
 	if (state == SMU_BACO_STATE_ENTER) {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_EnterBaco,
-						      (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
-						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_EnterBaco,
+				       (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
+				       BACO_SEQ_BAMACO : BACO_SEQ_BACO,
 						      NULL);
 	} else {
 		ret = smu_cmn_send_msg(smu,
-					   SMU_MSG_ExitBaco,
-					   NULL);
+				       SMU_MSG_ExitBaco,
+				       NULL);
 		if (ret)
 			return ret;
 
@@ -1636,8 +1636,8 @@ int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu)
 	int ret;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableGfxImu,
-						       ENABLE_IMU_ARG_GFXOFF_ENABLE, NULL);
+		return smu_cmn_send_msg(smu, SMU_MSG_EnableGfxImu,
+					ENABLE_IMU_ARG_GFXOFF_ENABLE, NULL);
 	}
 
 	mutex_lock(&ctl->lock);
@@ -1707,17 +1707,17 @@ int smu_v15_0_od_edit_dpm_table(struct smu_context *smu,
 			return -EINVAL;
 		}
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
-						      smu->gfx_actual_hard_min_freq,
-						      NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetHardMinGfxClk,
+				       smu->gfx_actual_hard_min_freq,
+				       NULL);
 		if (ret) {
 			dev_err(smu->adev->dev, "Set hard min sclk failed!");
 			return ret;
 		}
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
-						      smu->gfx_actual_soft_max_freq,
-						      NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxGfxClk,
+				       smu->gfx_actual_soft_max_freq,
+				       NULL);
 		if (ret) {
 			dev_err(smu->adev->dev, "Set soft max sclk failed!");
 			return ret;
@@ -1733,8 +1733,8 @@ int smu_v15_0_od_edit_dpm_table(struct smu_context *smu,
 static int smu_v15_0_allow_ih_interrupt(struct smu_context *smu)
 {
 	return smu_cmn_send_msg(smu,
-				    SMU_MSG_AllowIHHostInterrupt,
-				    NULL);
+				SMU_MSG_AllowIHHostInterrupt,
+				NULL);
 }
 
 int smu_v15_0_enable_thermal_alert(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 80ba197664f1..ec517abedb9a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -702,8 +702,8 @@ static int smu_v15_0_0_mode2_reset(struct smu_context *smu)
 {
 	int ret;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
-					       SMU_RESET_MODE_2, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_GfxDeviceDriverReset,
+			       SMU_RESET_MODE_2, NULL);
 
 	if (ret)
 		dev_err(smu->adev->dev, "Failed to mode2 reset!\n");
@@ -1112,12 +1112,11 @@ static int smu_v15_0_0_set_soft_freq_limited_range(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, msg_set_min, min, NULL);
+	ret = smu_cmn_send_msg(smu, msg_set_min, min, NULL);
 	if (ret)
 		return ret;
 
-	return smu_cmn_send_smc_msg_with_param(smu, msg_set_max,
-					       max, NULL);
+	return smu_cmn_send_msg(smu, msg_set_max, max, NULL);
 }
 
 static int smu_v15_0_0_force_clk_levels(struct smu_context *smu,
@@ -1375,17 +1374,17 @@ static int smu_v15_0_common_set_fine_grain_gfx_freq_parameters(struct smu_contex
 static int smu_v15_0_0_set_vpe_enable(struct smu_context *smu,
 				      bool enable)
 {
-	return smu_cmn_send_smc_msg_with_param(smu, enable ?
-					       SMU_MSG_PowerUpVpe : SMU_MSG_PowerDownVpe,
-					       0, NULL);
+	return smu_cmn_send_msg(smu, enable ?
+				SMU_MSG_PowerUpVpe : SMU_MSG_PowerDownVpe,
+				0, NULL);
 }
 
 static int smu_v15_0_0_set_umsch_mm_enable(struct smu_context *smu,
 			      bool enable)
 {
-	return smu_cmn_send_smc_msg_with_param(smu, enable ?
-					       SMU_MSG_PowerUpUmsch : SMU_MSG_PowerDownUmsch,
-					       0, NULL);
+	return smu_cmn_send_msg(smu, enable ?
+				SMU_MSG_PowerUpUmsch : SMU_MSG_PowerDownUmsch,
+				0, NULL);
 }
 
 static int smu_v15_0_0_get_dpm_table(struct smu_context *smu, struct dpm_clocks *clock_table)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 672f243ea0fe..89a44b456e8a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1807,13 +1807,13 @@ static int smu_v15_0_8_set_gfx_soft_freq_limited_range(struct smu_context *smu,
 {
 	int ret;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
-					      max & 0xffff, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMaxGfxClk,
+			       max & 0xffff, NULL);
 	if (ret)
 		return ret;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinGfxclk,
-					      min & 0xffff, NULL);
+	ret = smu_cmn_send_msg(smu, SMU_MSG_SetSoftMinGfxclk,
+			       min & 0xffff, NULL);
 
 	return ret;
 }
@@ -2144,8 +2144,8 @@ static int smu_v15_0_8_set_power_limit(struct smu_context *smu,
 			return -EINVAL;
 		}
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetFastPptLimit,
-						      limit, NULL);
+		ret = smu_cmn_send_msg(smu, SMU_MSG_SetFastPptLimit,
+				       limit, NULL);
 		if (ret)
 			dev_err(smu->adev->dev, "Set fast PPT limit failed!\n");
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 0c95d904b5f1..41a7f438033c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -127,62 +127,6 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
 	return smu_msg_wait_response(&smu->msg_ctl, 0);
 }
 
-/**
- * smu_cmn_send_smc_msg_with_param -- send a message with parameter
- * @smu: pointer to an SMU context
- * @msg: message to send
- * @param: parameter to send to the SMU
- * @read_arg: pointer to u32 to return a value from the SMU back
- *            to the caller
- *
- * Send the message @msg with parameter @param to the SMU, wait for
- * completion of the command, and return back a value from the SMU in
- * @read_arg pointer.
- *
- * Return 0 on success, -errno when a problem is encountered sending
- * message or receiving reply. If there is a PCI bus recovery or
- * the destination is a virtual GPU which does not allow this message
- * type, the message is simply dropped and success is also returned.
- * See smu_msg_v1_decode_response() for details of the -errno.
- *
- * If we weren't able to send the message to the SMU, we also print
- * the error to the standard log.
- *
- * Command completion status is printed only if the -errno is
- * -EREMOTEIO, indicating that the SMU returned back an
- * undefined/unknown/unspecified result. All other cases are
- * well-defined, not printed, but instead given back to the client to
- * decide what further to do.
- *
- * The return value, @read_arg is read back regardless, to give back
- * more information to the client, which on error would most likely be
- * @param, but we can't assume that. This also eliminates more
- * conditionals.
- */
-int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
-				    enum smu_message_type msg,
-				    uint32_t param,
-				    uint32_t *read_arg)
-{
-	struct smu_msg_ctl *ctl = &smu->msg_ctl;
-	struct smu_msg_args args = {
-		.msg = msg,
-		.args[0] = param,
-		.num_args = 1,
-		.num_out_args = read_arg ? 1 : 0,
-		.flags = 0,
-		.timeout = 0,
-	};
-	int ret;
-
-	ret = ctl->ops->send_msg(ctl, &args);
-
-	if (read_arg)
-		*read_arg = args.out_args[0];
-
-	return ret;
-}
-
 static inline int smu_cmn_send_msg_internal(struct smu_context *smu, enum smu_message_type msg,
 					    int num_in_args, u32 *in_args,
 					    int num_out_args, u32 *out_args)
@@ -845,12 +789,12 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 						CMN2ASIC_MAPPING_MSG,
 						SMU_MSG_GetEnabledSmuFeatures);
 	if (index > 0) {
-		ret = smu_cmn_send_smc_msg_with_param(
+		ret = smu_cmn_send_msg(
 			smu, SMU_MSG_GetEnabledSmuFeatures, 0, &features[0]);
 		if (ret)
 			return ret;
 
-		ret = smu_cmn_send_smc_msg_with_param(
+		ret = smu_cmn_send_msg(
 			smu, SMU_MSG_GetEnabledSmuFeatures, 1, &features[1]);
 	} else {
 		ret = smu_cmn_send_msg(
@@ -889,27 +833,27 @@ int smu_cmn_feature_update_enable_state(struct smu_context *smu,
 	int ret = 0;
 
 	if (enabled) {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						  SMU_MSG_EnableSmuFeaturesLow,
-						  lower_32_bits(feature_mask),
-						  NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_EnableSmuFeaturesLow,
+				       lower_32_bits(feature_mask),
+				       NULL);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						  SMU_MSG_EnableSmuFeaturesHigh,
-						  upper_32_bits(feature_mask),
-						  NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_EnableSmuFeaturesHigh,
+				       upper_32_bits(feature_mask),
+				       NULL);
 	} else {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						  SMU_MSG_DisableSmuFeaturesLow,
-						  lower_32_bits(feature_mask),
-						  NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_DisableSmuFeaturesLow,
+				       lower_32_bits(feature_mask),
+				       NULL);
 		if (ret)
 			return ret;
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						  SMU_MSG_DisableSmuFeaturesHigh,
-						  upper_32_bits(feature_mask),
-						  NULL);
+		ret = smu_cmn_send_msg(smu,
+				       SMU_MSG_DisableSmuFeaturesHigh,
+				       upper_32_bits(feature_mask),
+				       NULL);
 	}
 
 	return ret;
@@ -1157,11 +1101,11 @@ int smu_cmn_update_table(struct smu_context *smu,
 		amdgpu_hdp_flush(adev, NULL);
 	}
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, drv2smu ?
-					  SMU_MSG_TransferTableDram2Smu :
-					  SMU_MSG_TransferTableSmu2Dram,
-					  table_id | ((argument & 0xFFFF) << 16),
-					  NULL);
+	ret = smu_cmn_send_msg(smu, drv2smu ?
+			       SMU_MSG_TransferTableDram2Smu :
+			       SMU_MSG_TransferTableSmu2Dram,
+			       table_id | ((argument & 0xFFFF) << 16),
+			       NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index ee3f53a6a0c8..ed9196ba3c7a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -110,11 +110,6 @@ static inline int pcie_gen_to_speed(uint32_t gen)
 	return ((gen == 0) ? link_speed[0] : link_speed[gen - 1]);
 }
 
-int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
-				    enum smu_message_type msg,
-				    uint32_t param,
-				    uint32_t *read_arg);
-
 int smu_cmn_send_debug_smc_msg(struct smu_context *smu,
 			 uint32_t msg);
 
-- 
2.47.3

