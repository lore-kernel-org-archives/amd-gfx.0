Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF00C5DF72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D4D10F6FF;
	Fri, 14 Aug 2026 21:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P79SZsZ0";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D5ED10F6FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMB4hKih+IAZh/C0JJPIkO9LlVFiJLqU/RILujPRoEwmk+CihjCT9Hc7rArRF2auKJd21OVBvkMPlJxSuJjq602aK5r3gZ0XadNS78fdutP8nRO0veVhXjtdj0Hr/8VjDgZw2Zbck2wLukaoYfizCabNQ3HYXmpYrRmdZHDxeZhULK9KkX8rL3yD1ZzmlaoiiY00Fp0J6AjZYzs4eMxQ10lZ3pIn3Ck2yi3QSJdm1+AgDIWKdCriBmpTIHS42ue1/XwZ0aDoBPio24NgSLKGBGAxH8m1OuK7R9yjqwV2XupOvnEpcNVW0JVa5D7UEvrKWuuMzWDl7T3rXxSdR6s/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvJXrRPGVtRyxecpxHtcrPM6E/7SwnTwUN6wTSU6owM=;
 b=Qr2TqK9shISAF0pgX1d1cA/q/t2z4CUv4OOhw/BfGRjOPTBLxdxJiqy+hEAbrsrB0+In0MtLg2ugFNUJTRE1yMLX9w14hVK9pogeqRPWl10bN7DPvLw6oFJIoTjk3xx8EMx1YvMJAvxfHI7UEb1f9NqwlGWCTsYX4Lgedkperi63agAgerjjvrHCt44FSS3F5o37eA0iVGdATw4XMmyRG5004bCcy7XyyALux70svro6LFTPWnbeG0mDttpnbmnVDQHkBEYYoDyTMicCkoszV4EGWYbH1/6gj2EX/QVuCnTda+MNKYl8EDU1COa64bdD8GEbri6+YipqkDRER8xj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvJXrRPGVtRyxecpxHtcrPM6E/7SwnTwUN6wTSU6owM=;
 b=P79SZsZ0gn8UitZ8uca3+c49BOVdiwPzGocLwGFaLOPnqwk764ffKeRObG2zIluVKlIf6z5O3Wp9lqqf03NXvUVbRD30ljiv/Jr5pyd1URy8cp4W/UDB7KakzP3ADGB8KuxO8+LJumyRKOuj1UIgoRQlSZVrdS8piXsbqNdDll8=
Received: from CH2PR10CA0013.namprd10.prod.outlook.com (2603:10b6:610:4c::23)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 21:03:31 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::3e) by CH2PR10CA0013.outlook.office365.com
 (2603:10b6:610:4c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Fri,
 14 Aug 2026 21:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:24 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 044/109] drm/amd/ras: switch to use new eeprom management
 interfaces
Date: Fri, 14 Aug 2026 17:01:41 -0400
Message-ID: <20260814210246.3067612-45-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f6fddb-673f-4870-3c74-08defa477eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FFCAeWqeZUjOCnhj+f+zhR5q0DLkE2Bzd1KbHyASKaic4APActq7NhBVZjHEq5woJ8EgYvEEHTAV98BTkUZPjanB9fNmUF0xZbamnlUlenoFbElO9qnA+2FcHpOF15z78WV3Cm/CSiuCFQMf4I8dTVG/wJnR1N55vW5nHPq5MBIcCCHGCOnccwVnWKevPF1q10xQEMSpw0QVfPF9mkMITKqmo1zagD0dAsdtaPoyKNo9C4F7MJ/MVdAgqHZOt8Lnz8w0nHvsgbCxcWGqYj2/gkqhAoBZ5cus1KC7YtXW0X45rNQs+Ruu2Th8WHb+KQ9AyVtOzC8Z2b/3upyWrWatO/oDKPyrofAKIPKXwGF81fWTA12ueSzNxHD/yo4JhEgZRPcjp1d+8BSMtnn48q0w7MtU1DaaeeoF1DyQcjrvO2N1XuPoKHgHyogzdYk/l9uMynRTgPaK8TZ4+heSDuWvr74b5UW1ydf9IIBr7hNELJHDf2Sbsa6Hrsee9Qgbzf+MyyUOw0PAvo7y8u6jMtU+gH7hgo9yfEOamnKThdh0B6mpRLGVY4TAmn8eVHisRH3kFEGh38UeCM//eaXVNxN3tWhqBRpKnhH17gXq8QcWTR++AshOnXUGQYhkhfAYaSkxcZnNYfI289aEYELvGB9MEpkEmPWECwjTMU6/pX6WZ4U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HXvdcqkvk2Dlk0iP6WyuxSdGi9Q+5ZTPOTYgRg8S3eMweaCqI14hXco3kOLxW9a8onmAJ+sXzsmhr9AP5SjNzBVf8TVZ/Ar6Jjx2ef2BYXUbIB5aTQ1JK4ZWLxV7D7itdf0YAExDezQJC8soB1aEe9Vz+Ng9hSAWg+jzu6M1Oa38xvzoxytN9Qg4Vexc1tIGo+F4vfAfwIhyRD3H+NSM9fsxWHdyJKgXyCCpeJFZF6Tbd7YxCmpooWgu477QZYrIZIV9b7BT8JC8bqaZKKjN3y9xnlLeZX21zNxvfRbeD2nKZ8p6UGWfVwOoLKh/SVj9NLfuaL/4zEiC0lqDklQ/YoZvif0sw5URcA71w2EkMazvU8ipY2SCB3rnb8xAIBYGC82snZOKbIuBYHlhwFMN/TW8iA9no8g/Mg34w6JeffiCGPJSmeXe5UgVUm9vEDAG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:31.1905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f6fddb-673f-4870-3c74-08defa477eec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Switch to use new eeprom management interfaces.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |   8 +-
 drivers/gpu/drm/amd/ras/core/Makefile         |   1 +
 drivers/gpu/drm/amd/ras/core/aca.c            |  34 ++--
 drivers/gpu/drm/amd/ras/core/cmd.c            |   9 +-
 drivers/gpu/drm/amd/ras/core/core.c           |  46 +----
 drivers/gpu/drm/amd/ras/core/eeprom.c         | 162 ++++++++----------
 drivers/gpu/drm/amd/ras/core/eeprom.h         |  19 +-
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h |   1 +
 drivers/gpu/drm/amd/ras/core/ras_umc.c        |  42 ++---
 drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c  |   2 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |   5 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  |   3 +-
 12 files changed, 122 insertions(+), 210 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 95468b9463fb8..f078e6ebfa505 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1279,11 +1279,11 @@ amdgpu_ras_debugfs_table_read_uniras(struct amdgpu_device *adev,
 		return 0;
 
 	/* pmfw manages eeprom data by itself */
-	if (ras_fw_eeprom_supported(ras_core))
+	if (ras_eeprom_mgr_fw_record_enabled(ras_core))
 		return 0;
 
-	control = &ras_core->ras_eeprom;
-	num_recs = ras_eeprom_get_record_count(ras_core);
+	control = ras_core->eeprom_mgr.ras_eeprom;
+	num_recs = ras_eeprom_mgr_get_record_count(ras_core);
 
 	bufsz = strlen(tbl_hdr_str) + tbl_hdr_fmt_size +
 		strlen(rec_hdr_str) + (size_t)rec_hdr_fmt_size * num_recs + 1;
@@ -1299,7 +1299,7 @@ amdgpu_ras_debugfs_table_read_uniras(struct amdgpu_device *adev,
 			goto out;
 		}
 
-		res = ras_eeprom_read(ras_core, records, num_recs);
+		res = ras_eeprom_mgr_get_records(ras_core, 0, records, num_recs);
 		if (res)
 			goto out;
 	}
diff --git a/drivers/gpu/drm/amd/ras/core/Makefile b/drivers/gpu/drm/amd/ras/core/Makefile
index 1f4d6d642a73a..980ae48b1ab8e 100644
--- a/drivers/gpu/drm/amd/ras/core/Makefile
+++ b/drivers/gpu/drm/amd/ras/core/Makefile
@@ -26,6 +26,7 @@ RAS_CORE_FILES = core.o \
 			aca.o  \
 			aca_v1_0.o \
 			ras_aca_v5_0.o \
+			ras_eeprom_mgr.o \
 			eeprom.o \
 			ras_umc.o \
 			ras_umc_v12_0.o \
diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index 6d7cfef543622..07a9cc030ca14 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -251,29 +251,17 @@ static int aca_log_bad_bank(struct ras_core_context *ras_core,
 	    bank_ecc->de_count) {
 		struct ras_bank_ecc  ras_ecc = {0};
 
-		if (ras_fw_eeprom_supported(ras_core)) {
-			ret = ras_fw_eeprom_update_record(ras_core, &ras_ecc);
-			if (!ret) {
-				ras_ecc.nps = ras_core_get_curr_nps_mode(ras_core);
-				ras_ecc.status = bank_ecc->bank_info.status;
-				ras_ecc.seq_no = bank->seq_no;
-				ras_ecc.timestamp = bank->timestamp;
-			}
-		} else {
-			ras_ecc.nps = ras_core_get_curr_nps_mode(ras_core);
-			ras_ecc.addr = bank_ecc->bank_info.addr;
-			ras_ecc.ipid = bank_ecc->bank_info.ipid;
-			ras_ecc.status = bank_ecc->bank_info.status;
-			ras_ecc.seq_no = bank->seq_no;
-			ras_ecc.timestamp = bank->timestamp;
-		}
-
-		if (!ret) {
-			if (ras_core_gpu_in_reset(ras_core))
-				ras_umc_log_bad_bank_pending(ras_core, &ras_ecc);
-			else
-				ras_umc_log_bad_bank(ras_core, &ras_ecc);
-		}
+		ras_ecc.nps = ras_core_get_curr_nps_mode(ras_core);
+		ras_ecc.addr = bank_ecc->bank_info.addr;
+		ras_ecc.ipid = bank_ecc->bank_info.ipid;
+		ras_ecc.status = bank_ecc->bank_info.status;
+		ras_ecc.seq_no = bank->seq_no;
+		ras_ecc.timestamp = bank->timestamp;
+
+		if (ras_core_gpu_in_reset(ras_core))
+			ras_umc_log_bad_bank_pending(ras_core, &ras_ecc);
+		else
+			ras_umc_log_bad_bank(ras_core, &ras_ecc);
 	}
 
 	aca_report_ecc_info(ras_core,
diff --git a/drivers/gpu/drm/amd/ras/core/cmd.c b/drivers/gpu/drm/amd/ras/core/cmd.c
index ecd9da6199831..0c5ca4bad5840 100644
--- a/drivers/gpu/drm/amd/ras/core/cmd.c
+++ b/drivers/gpu/drm/amd/ras/core/cmd.c
@@ -143,13 +143,8 @@ static int ras_cmd_clear_bad_page_info(struct ras_core_context *ras_core,
 	if (cmd->input_size != sizeof(struct ras_cmd_dev_handle))
 		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
 
-	if (ras_fw_eeprom_supported(ras_core)) {
-		if (ras_fw_eeprom_reset_table(ras_core))
-			return RAS_CMD__ERROR_GENERIC;
-	} else {
-		if (ras_eeprom_reset_table(ras_core))
-			return RAS_CMD__ERROR_GENERIC;
-	}
+	if (ras_eeprom_mgr_reset_table(ras_core))
+		return RAS_CMD__ERROR_GENERIC;
 
 	if (ras_umc_clean_badpage_data(ras_core))
 		return RAS_CMD__ERROR_GENERIC;
diff --git a/drivers/gpu/drm/amd/ras/core/core.c b/drivers/gpu/drm/amd/ras/core/core.c
index 0815dea06f384..fc399192713ec 100644
--- a/drivers/gpu/drm/amd/ras/core/core.c
+++ b/drivers/gpu/drm/amd/ras/core/core.c
@@ -273,10 +273,7 @@ static int ras_core_eeprom_recovery(struct ras_core_context *ras_core)
 	int count;
 	int ret;
 
-	if (ras_fw_eeprom_supported(ras_core))
-		count = ras_fw_eeprom_get_record_count(ras_core);
-	else
-		count = ras_eeprom_get_record_count(ras_core);
+	count = ras_eeprom_mgr_get_record_count(ras_core);
 	if (!count)
 		return 0;
 
@@ -290,11 +287,6 @@ static int ras_core_eeprom_recovery(struct ras_core_context *ras_core)
 		return ret;
 	}
 
-	if (ras_fw_eeprom_supported(ras_core))
-		ras_fw_eeprom_sync_info(ras_core);
-	else
-		ras_eeprom_sync_info(ras_core);
-
 	return ret;
 }
 
@@ -430,12 +422,7 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 	if (ret)
 		goto init_err5;
 
-	ras_fw_init_feature_flags(ras_core);
-
-	if (ras_fw_eeprom_supported(ras_core))
-		ret = ras_fw_eeprom_hw_init(ras_core);
-	else
-		ret = ras_eeprom_hw_init(ras_core);
+	ret = ras_eeprom_mgr_hw_init(ras_core);
 	if (ret)
 		goto init_err6;
 
@@ -443,16 +430,9 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 	if (ret) {
 		RAS_DEV_ERR(ras_core->dev,
 			"Failed to recovery ras core, ret:%d\n", ret);
-		goto init_err6;
+		goto init_err7;
 	}
 
-	if (ras_fw_eeprom_supported(ras_core))
-		ret = ras_fw_eeprom_check_storage_status(ras_core);
-	else
-		ret = ras_eeprom_check_storage_status(ras_core);
-	if (ret)
-		goto init_err6;
-
 	ret = ras_process_init(ras_core);
 	if (ret)
 		goto init_err7;
@@ -462,10 +442,7 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 	return 0;
 
 init_err7:
-	if (ras_fw_eeprom_supported(ras_core))
-		ras_fw_eeprom_hw_fini(ras_core);
-	else
-		ras_eeprom_hw_fini(ras_core);
+	ras_eeprom_mgr_hw_fini(ras_core);
 init_err6:
 	ras_gfx_hw_fini(ras_core);
 init_err5:
@@ -486,10 +463,7 @@ int ras_core_hw_fini(struct ras_core_context *ras_core)
 	ras_core->is_initialized = false;
 
 	ras_process_fini(ras_core);
-	if (ras_fw_eeprom_supported(ras_core))
-		ras_fw_eeprom_hw_fini(ras_core);
-	else
-		ras_eeprom_hw_fini(ras_core);
+	ras_eeprom_mgr_hw_fini(ras_core);
 	ras_gfx_hw_fini(ras_core);
 	ras_nbio_hw_fini(ras_core);
 	ras_umc_hw_fini(ras_core);
@@ -667,10 +641,7 @@ bool ras_core_is_ready(struct ras_core_context *ras_core)
 
 bool ras_core_check_safety_watermark(struct ras_core_context *ras_core)
 {
-	if (ras_fw_eeprom_supported(ras_core))
-		return ras_fw_eeprom_check_safety_watermark(ras_core);
-
-	return ras_eeprom_check_safety_watermark(ras_core);
+	return ras_eeprom_mgr_check_safety_watermark(ras_core);
 }
 
 int ras_core_down_trylock_gpu_reset_lock(struct ras_core_context *ras_core)
@@ -775,8 +746,7 @@ int ras_core_get_ip_version(struct ras_core_context *ras_core,
 		*version = ras_core->ras_aca.aca_ip_version;
 		return 0;
 	case RAS_UNIT_ID_EEPROM:
-		*version = ras_core->ras_eeprom.tbl_hdr.version;
-		return 0;
+		return ras_eeprom_mgr_get_version(ras_core, version);
 	default:
 		break;
 	}
@@ -787,7 +757,7 @@ int ras_core_get_ip_version(struct ras_core_context *ras_core,
 int ras_core_get_eeprom_version(struct ras_core_context *ras_core,
 	uint32_t *version)
 {
-	return ras_eeprom_get_version(ras_core, version);
+	return ras_eeprom_mgr_get_version(ras_core, version);
 }
 
 uint64_t ras_core_get_ras_caps(struct ras_core_context *ras_core)
diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.c b/drivers/gpu/drm/amd/ras/core/eeprom.c
index 39aae3248ea77..b261f11799f6c 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom.c
+++ b/drivers/gpu/drm/amd/ras/core/eeprom.c
@@ -151,7 +151,7 @@
 	 (((_tbl_hdr)->tbl_size - RAS_TABLE_HEADER_SIZE - \
 	   RAS_TABLE_V2_1_INFO_SIZE) / RAS_TABLE_RECORD_SIZE))
 
-#define to_ras_core_context(x) (container_of(x, struct ras_core_context, ras_eeprom))
+#define to_ras_core_context(x) (container_of(x, struct ras_core_context, eeprom_mgr))
 
 static bool __is_ras_eeprom_supported(struct ras_core_context *ras_core)
 {
@@ -172,7 +172,7 @@ static bool __get_eeprom_i2c_addr(struct ras_core_context *ras_core,
 static int __ras_eeprom_xfer(struct ras_core_context *ras_core, u32 eeprom_addr,
 				u8 *eeprom_buf, u32 buf_size, bool read)
 {
-	struct ras_eeprom_control *control = &ras_core->ras_eeprom;
+	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
 	int ret;
 
 	if (control->sys_func && control->sys_func->eeprom_i2c_xfer) {
@@ -201,15 +201,12 @@ static int __ras_eeprom_xfer(struct ras_core_context *ras_core, u32 eeprom_addr,
 static int __eeprom_xfer(struct ras_core_context *ras_core, u32 eeprom_addr,
 			      u8 *eeprom_buf, u32 buf_size, bool read)
 {
+	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
 	u16 limit;
 	u16 ps; /* Partial size */
 	int res = 0, r;
 
-	if (read)
-		limit = ras_core->ras_eeprom.max_read_len;
-	else
-		limit = ras_core->ras_eeprom.max_write_len;
-
+	limit = read ? control->max_read_len : control->max_write_len;
 	if (limit && (limit <= EEPROM_OFFSET_SIZE)) {
 		RAS_DEV_ERR(ras_core->dev,
 				"maddr:0x%04X size:0x%02X:quirk max_%s_len must be > %d",
@@ -290,7 +287,7 @@ __decode_table_header_from_buf(struct ras_eeprom_table_header *hdr,
 static int __write_table_header(struct ras_eeprom_control *control)
 {
 	u8 buf[RAS_TABLE_HEADER_SIZE];
-	struct ras_core_context *ras_core = to_ras_core_context(control);
+	struct ras_core_context *ras_core = to_ras_core_context(control->mgr);
 	int res;
 
 	memset(buf, 0, sizeof(buf));
@@ -344,7 +341,7 @@ __decode_table_ras_info_from_buf(struct ras_eeprom_table_ras_info *rai,
 
 static int __write_table_ras_info(struct ras_eeprom_control *control)
 {
-	struct ras_core_context *ras_core = to_ras_core_context(control);
+	struct ras_core_context *ras_core = to_ras_core_context(control->mgr);
 	u8 *buf;
 	int res;
 
@@ -444,7 +441,7 @@ static void ras_set_eeprom_table_version(struct ras_eeprom_control *control)
 
 int ras_eeprom_reset_table(struct ras_core_context *ras_core)
 {
-	struct ras_eeprom_control *control = &ras_core->ras_eeprom;
+	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
 	struct ras_eeprom_table_header *hdr = &control->tbl_hdr;
 	struct ras_eeprom_table_ras_info *rai = &control->tbl_rai;
 	u8 csum;
@@ -554,7 +551,7 @@ __decode_table_record_from_buf(struct ras_eeprom_control *control,
 
 bool ras_eeprom_check_safety_watermark(struct ras_core_context *ras_core)
 {
-	struct ras_eeprom_control *control = &ras_core->ras_eeprom;
+	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
 	bool ret = false;
 	int bad_page_count;
 
@@ -597,7 +594,7 @@ bool ras_eeprom_check_safety_watermark(struct ras_core_context *ras_core)
 static int __ras_eeprom_write(struct ras_eeprom_control *control,
 			      u8 *buf, const u32 fri, const u32 num)
 {
-	struct ras_core_context *ras_core = to_ras_core_context(control);
+	struct ras_core_context *ras_core = to_ras_core_context(control->mgr);
 	u32 buf_size;
 	int res;
 
@@ -734,7 +731,7 @@ static int ras_eeprom_append_table(struct ras_eeprom_control *control,
 
 static int ras_eeprom_update_header(struct ras_eeprom_control *control)
 {
-	struct ras_core_context *ras_core = to_ras_core_context(control);
+	struct ras_core_context *ras_core = to_ras_core_context(control->mgr);
 	int threshold_config = control->record_threshold_config;
 	u8 *buf, *pp, csum;
 	u32 buf_size;
@@ -843,14 +840,14 @@ static int ras_eeprom_update_header(struct ras_eeprom_control *control)
  *
  * Return 0 on success or if EEPROM is not supported, -errno on error.
  */
-int ras_eeprom_append(struct ras_core_context *ras_core,
+static int ras_eeprom_append(struct ras_core_context *ras_core,
 			   struct eeprom_umc_record *record, const u32 num)
 {
-	struct ras_eeprom_control *control = &ras_core->ras_eeprom;
+	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
 	int res;
 
-	if (!__is_ras_eeprom_supported(ras_core))
-		return 0;
+	if (!control)
+		return -EINVAL;
 
 	if (num == 0) {
 		RAS_DEV_ERR(ras_core->dev, "will not append 0 records\n");
@@ -885,7 +882,7 @@ int ras_eeprom_append(struct ras_core_context *ras_core,
 static int __ras_eeprom_read(struct ras_eeprom_control *control,
 			     u8 *buf, const u32 fri, const u32 num)
 {
-	struct ras_core_context *ras_core = to_ras_core_context(control);
+	struct ras_core_context *ras_core = to_ras_core_context(control->mgr);
 	u32 buf_size;
 	int res;
 
@@ -912,16 +909,16 @@ static int __ras_eeprom_read(struct ras_eeprom_control *control,
 	return res;
 }
 
-int ras_eeprom_read(struct ras_core_context *ras_core,
-			 struct eeprom_umc_record *record, const u32 num)
+static int ras_eeprom_read(struct ras_core_context *ras_core,
+			struct eeprom_umc_record *record, u32 num)
 {
-	struct ras_eeprom_control *control = &ras_core->ras_eeprom;
+	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
 	int i, res;
 	u8 *buf, *pp;
 	u32 g0, g1;
 
-	if (!__is_ras_eeprom_supported(ras_core))
-		return 0;
+	if (!control)
+		return -EINVAL;
 
 	if (num == 0) {
 		RAS_DEV_ERR(ras_core->dev, "will not read 0 records\n");
@@ -1000,19 +997,6 @@ int ras_eeprom_read(struct ras_core_context *ras_core,
 	return res;
 }
 
-uint32_t ras_eeprom_max_record_count(struct ras_core_context *ras_core)
-{
-	struct ras_eeprom_control *control = &ras_core->ras_eeprom;
-
-	/* get available eeprom table version first before eeprom table init */
-	ras_set_eeprom_table_version(control);
-
-	if (control->tbl_hdr.version >= RAS_TABLE_VER_V2_1)
-		return RAS_MAX_RECORD_COUNT_V2_1;
-	else
-		return RAS_MAX_RECORD_COUNT;
-}
-
 /**
  * __verify_ras_table_checksum -- verify the RAS EEPROM table checksum
  * @control: pointer to control structure
@@ -1025,7 +1009,7 @@ uint32_t ras_eeprom_max_record_count(struct ras_core_context *ras_core)
  */
 static int __verify_ras_table_checksum(struct ras_eeprom_control *control)
 {
-	struct ras_core_context *ras_core = to_ras_core_context(control);
+	struct ras_core_context *ras_core = to_ras_core_context(control->mgr);
 	int buf_size, res;
 	u8  csum, *buf, *pp;
 
@@ -1069,7 +1053,7 @@ static int __verify_ras_table_checksum(struct ras_eeprom_control *control)
 static int __read_table_ras_info(struct ras_eeprom_control *control)
 {
 	struct ras_eeprom_table_ras_info *rai = &control->tbl_rai;
-	struct ras_core_context *ras_core = to_ras_core_context(control);
+	struct ras_core_context *ras_core = to_ras_core_context(control->mgr);
 	unsigned char *buf;
 	int res;
 
@@ -1103,19 +1087,19 @@ static int __read_table_ras_info(struct ras_eeprom_control *control)
 
 static int __check_ras_table_status(struct ras_core_context *ras_core)
 {
-	struct ras_eeprom_control *control = &ras_core->ras_eeprom;
+	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
 	unsigned char buf[RAS_TABLE_HEADER_SIZE] = { 0 };
 	struct ras_eeprom_table_header *hdr;
 	int res;
 
-	hdr = &control->tbl_hdr;
-
-	if (!__is_ras_eeprom_supported(ras_core))
-		return 0;
+	if (!control)
+		return -EINVAL;
 
 	if (!__get_eeprom_i2c_addr(ras_core, control))
 		return -EINVAL;
 
+	hdr = &control->tbl_hdr;
+
 	control->ras_header_offset = RAS_HDR_START;
 	control->ras_info_offset = RAS_TABLE_V2_1_INFO_START;
 	mutex_init(&control->ras_tbl_mutex);
@@ -1191,7 +1175,7 @@ static int __check_ras_table_status(struct ras_core_context *ras_core)
 
 int ras_eeprom_check_storage_status(struct ras_core_context *ras_core)
 {
-	struct ras_eeprom_control *control = &ras_core->ras_eeprom;
+	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
 	struct ras_eeprom_table_header *hdr;
 	int bad_page_count;
 	int res = 0;
@@ -1278,77 +1262,73 @@ int ras_eeprom_check_storage_status(struct ras_core_context *ras_core)
 	return res < 0 ? res : 0;
 }
 
-int ras_eeprom_hw_init(struct ras_core_context *ras_core)
+static int ras_eeprom_sw_init(struct ras_core_context *ras_core,
+		struct ras_eeprom_param *param)
 {
+	struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
 	struct ras_eeprom_control *control;
-	struct ras_eeprom_config *eeprom_cfg;
-	struct ras_eeprom_param_config  param_config = {0};
-	int ret;
 
-	if (!ras_core)
+	if (!param)
 		return -EINVAL;
 
-	ras_core->is_rma = false;
-
-	control = &ras_core->ras_eeprom;
+	control = kzalloc(sizeof(*control), GFP_KERNEL);
+	if (!control)
+		return -ENOMEM;
 
+	mgr->ras_eeprom = control;
 	memset(control, 0, sizeof(*control));
 
-	eeprom_cfg = &ras_core->config->eeprom_cfg;
-	if (!eeprom_cfg || !eeprom_cfg->eeprom_sys_fn ||
-		!eeprom_cfg->eeprom_sys_fn->get_eeprom_config) {
-		RAS_DEV_ERR(ras_core->dev, "Ras eeprom not configured!\n");
-		return -EINVAL;
-	}
+	control->mgr = mgr;
+	control->max_read_len = param->max_i2c_read_len;
+	control->max_write_len = param->max_i2c_write_len;
+	control->i2c_adapter = param->eeprom_i2c_adapter;
+	control->i2c_port = param->eeprom_i2c_port;
+	control->i2c_address = param->eeprom_i2c_addr;
 
-	control->sys_func = eeprom_cfg->eeprom_sys_fn;
+	control->update_channel_flag = false;
 
-	ret = eeprom_cfg->eeprom_sys_fn->get_eeprom_config(ras_core,
-				&param_config);
-	if (ret) {
-		RAS_DEV_ERR(ras_core->dev, "Failed to get ras eeprom config!\n");
-		return -EPERM;
-	}
+	return 0;
+}
 
-	control->record_threshold_config =
-		param_config.eeprom_record_threshold_config;
+static int ras_eeprom_sw_fini(struct ras_core_context *ras_core)
+{
+	if (!ras_core)
+		return -EINVAL;
 
-	control->record_threshold_count = ras_eeprom_max_record_count(ras_core);
-	if (param_config.eeprom_record_threshold_count <
-		control->record_threshold_count)
-		control->record_threshold_count =
-			param_config.eeprom_record_threshold_count;
+	kfree(ras_core->eeprom_mgr.ras_eeprom);
+	ras_core->eeprom_mgr.ras_eeprom = NULL;
 
-	control->max_read_len = param_config.max_i2c_read_len;
-	control->max_write_len = param_config.max_i2c_write_len;
-	control->i2c_adapter = param_config.eeprom_i2c_adapter;
-	control->i2c_port = param_config.eeprom_i2c_port;
-	control->i2c_address = param_config.eeprom_i2c_addr;
+	return 0;
+}
 
-	control->update_channel_flag = false;
+static int ras_eeprom_hw_init(struct ras_core_context *ras_core,
+		struct ras_eeprom_param *param)
+{
+	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
+
+	if (!control)
+		return -EINVAL;
 
 	return __check_ras_table_status(ras_core);
 }
 
-int ras_eeprom_hw_fini(struct ras_core_context *ras_core)
+static int ras_eeprom_hw_fini(struct ras_core_context *ras_core)
 {
-	struct ras_eeprom_control *control;
-
-	if (!ras_core)
-		return -EINVAL;
+	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
 
-	control = &ras_core->ras_eeprom;
 	mutex_destroy(&control->ras_tbl_mutex);
 
 	return 0;
 }
 
-uint32_t ras_eeprom_get_record_count(struct ras_core_context *ras_core)
+static uint32_t ras_eeprom_get_record_count(struct ras_core_context *ras_core)
 {
-	if (!ras_core)
+	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
+
+	if (!control)
 		return 0;
 
-	return ras_core->ras_eeprom.ras_num_recs;
+	return control->ras_num_recs;
 }
 
 void ras_eeprom_sync_info(struct ras_core_context *ras_core)
@@ -1358,7 +1338,7 @@ void ras_eeprom_sync_info(struct ras_core_context *ras_core)
 	if (!ras_core)
 		return;
 
-	control = &ras_core->ras_eeprom;
+	control = ras_core->eeprom_mgr.ras_eeprom;
 	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM,
 		&control->ras_num_recs);
 	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_CHANNEL_BITMAP,
@@ -1368,7 +1348,7 @@ void ras_eeprom_sync_info(struct ras_core_context *ras_core)
 enum ras_gpu_health_status
 	ras_eeprom_check_gpu_status(struct ras_core_context *ras_core)
 {
-	struct ras_eeprom_control *control = &ras_core->ras_eeprom;
+	struct ras_eeprom_control *control = ras_core->eeprom_mgr.ras_eeprom;
 	struct ras_eeprom_table_ras_info *rai = &control->tbl_rai;
 
 	if (!__is_ras_eeprom_supported(ras_core) ||
@@ -1470,6 +1450,10 @@ static int ras_eeprom_unlock(struct ras_core_context *ras_core)
 }
 
 struct ras_eeprom_ops ras_drv_eeprom_ops = {
+	.sw_init = ras_eeprom_sw_init,
+	.sw_fini = ras_eeprom_sw_fini,
+	.hw_init = ras_eeprom_hw_init,
+	.hw_fini = ras_eeprom_hw_fini,
 	.reset_table = ras_eeprom_reset_table,
 	.get_records = ras_eeprom_get_records,
 	.append_records = ras_eeprom_append,
diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.h b/drivers/gpu/drm/amd/ras/core/eeprom.h
index 7eff0e5435d01..7c0466e9b90ed 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom.h
+++ b/drivers/gpu/drm/amd/ras/core/eeprom.h
@@ -25,6 +25,7 @@
 #ifndef __EEPROM_H__
 #define __EEPROM_H__
 #include "ras_sys.h"
+#include "ras_eeprom_mgr.h"
 
 #define RAS_TABLE_VER_V1           0x00010000
 #define RAS_TABLE_VER_V2_1         0x00021000
@@ -80,6 +81,7 @@ struct ras_eeprom_table_ras_info {
 } __packed;
 
 struct ras_eeprom_control {
+	void *mgr;
 	struct ras_eeprom_table_header tbl_hdr;
 	struct ras_eeprom_table_ras_info tbl_rai;
 
@@ -168,27 +170,16 @@ struct eeprom_umc_record {
 };
 
 struct ras_core_context;
-int ras_eeprom_hw_init(struct ras_core_context *ras_core);
-int ras_eeprom_hw_fini(struct ras_core_context *ras_core);
 
 int ras_eeprom_reset_table(struct ras_core_context *ras_core);
 
 bool ras_eeprom_check_safety_watermark(struct ras_core_context *ras_core);
 
-int ras_eeprom_read(struct ras_core_context *ras_core,
-			 struct eeprom_umc_record *records, const u32 num);
-
-int ras_eeprom_append(struct ras_core_context *ras_core,
-			   struct eeprom_umc_record *records, const u32 num);
-
-uint32_t ras_eeprom_max_record_count(struct ras_core_context *ras_core);
-uint32_t ras_eeprom_get_record_count(struct ras_core_context *ras_core);
-void ras_eeprom_sync_info(struct ras_core_context *ras_core);
-
 int ras_eeprom_check_storage_status(struct ras_core_context *ras_core);
 enum ras_gpu_health_status
 	ras_eeprom_check_gpu_status(struct ras_core_context *ras_core);
+void ras_eeprom_sync_info(struct ras_core_context *ras_core);
+int ras_eeprom_get_version(struct ras_core_context *ras_core, uint32_t *version);
 
-int ras_eeprom_get_version(struct ras_core_context *ras_core,
-	uint32_t *version);
+extern struct ras_eeprom_ops ras_drv_eeprom_ops;
 #endif
diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h
index 5f249ede0d40b..873c96b287845 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.h
@@ -24,6 +24,7 @@
 
 #ifndef __RAS_EEPROM_MGR_H__
 #define __RAS_EEPROM_MGR_H__
+#include "ras_sys.h"
 
 enum ras_gpu_op_status {
 	RAS_GPU_OP_STATUS_UNKNOWN = 0,
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index 2403daa75f69e..1be677ca316e1 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -644,6 +644,9 @@ static int ras_umc_add_bad_pages(struct ras_core_context *ras_core,
 		if (ret)
 			goto out;
 	}
+
+	ras_eeprom_mgr_check_and_report_status(ras_core, true);
+
 out:
 	mutex_unlock(&ras_umc->umc_lock);
 
@@ -660,29 +663,18 @@ int ras_umc_load_bad_pages(struct ras_core_context *ras_core)
 	uint32_t ras_num_recs;
 	int ret;
 
-	if (ras_fw_eeprom_supported(ras_core)) {
-		ras_num_recs = ras_fw_eeprom_get_record_count(ras_core);
-		/* no bad page record, skip eeprom access */
-		if (!ras_num_recs ||
-		    ras_core->ras_fw_eeprom.record_threshold_config == DISABLE_RETIRE_PAGE)
-			return 0;
-	} else {
-		ras_num_recs = ras_eeprom_get_record_count(ras_core);
-		if (!ras_num_recs ||
-		    ras_core->ras_eeprom.record_threshold_config == DISABLE_RETIRE_PAGE)
-			return 0;
-	}
+	ras_num_recs = ras_eeprom_mgr_get_record_count(ras_core);
+	if (!ras_num_recs)
+		return 0;
 
 	bps = kzalloc_objs(*bps, ras_num_recs);
 	if (!bps)
 		return -ENOMEM;
 
-	if (ras_fw_eeprom_supported(ras_core))
-		ret = ras_fw_eeprom_read_idx(ras_core, bps, 0, 0, ras_num_recs);
-	else
-		ret = ras_eeprom_read(ras_core, bps, ras_num_recs);
+	ret = ras_eeprom_mgr_get_records(ras_core, 0, bps, ras_num_recs);
 	if (ret) {
-		RAS_DEV_ERR(ras_core->dev, "Failed to load EEPROM table records!");
+		RAS_DEV_ERR(ras_core->dev,
+			"Failed to load EEPROM table records! ret:%d\n", ret);
 	} else {
 		ras_core->ras_umc.umc_err_data.last_retired_pfn = UMC_INV_MEM_PFN;
 		ret = ras_umc_add_bad_pages(ras_core, bps, ras_num_recs, true);
@@ -710,23 +702,17 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 	if (!data->bps)
 		return 0;
 
-	if (ras_fw_eeprom_supported(ras_core))
-		eeprom_record_num = ras_fw_eeprom_get_record_count(ras_core);
-	else
-		eeprom_record_num = ras_eeprom_get_record_count(ras_core);
+	eeprom_record_num = ras_eeprom_mgr_get_record_count(ras_core);
 	mutex_lock(&ras_umc->umc_lock);
 	save_count = data->count - eeprom_record_num;
 	logical_count = ram_data->bad_page_num - ram_data->bad_page_num_old;
 	/* only new entries are saved */
 	if (save_count > 0) {
-		if (ras_fw_eeprom_supported(ras_core))
-			ret = ras_fw_eeprom_append(ras_core, &data->bps[eeprom_record_num],
-					save_count);
-		else
-			ret = ras_eeprom_append(ras_core, &data->bps[eeprom_record_num],
-					save_count);
+		ret = ras_eeprom_mgr_append_records(ras_core,
+				&data->bps[eeprom_record_num], save_count);
 		if (ret) {
-			RAS_DEV_ERR(ras_core->dev, "Failed to save EEPROM table data!");
+			RAS_DEV_ERR(ras_core->dev,
+				"Failed to save EEPROM table data! ret:%d\n", ret);
 			ret = -EIO;
 			goto exit;
 		}
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
index 63f4e0cf9a415..438270adcfcbb 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc_v12_0.c
@@ -393,7 +393,7 @@ static int umc_v12_0_bank_to_eeprom_record(struct ras_core_context *ras_core,
 		ACA_ADDR_2_ERR_ADDR(bank->addr), ACA_IPID_2_UMC_INST(bank->ipid),
 		&nps_addr, bank->nps, record);
 
-	if (ras_fw_eeprom_supported(ras_core) && bank->ts)
+	if (bank->ts)
 		record->ts = bank->ts;
 
 	/* If the bank being converted already has a timestamp,
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 348b0412e5d90..d84cf9162e588 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -598,10 +598,7 @@ bool amdgpu_ras_mgr_check_eeprom_safety_watermark(struct amdgpu_device *adev)
 	if (!amdgpu_ras_mgr_is_ready(adev))
 		return false;
 
-	if (ras_fw_eeprom_supported(ras_mgr->ras_core))
-		return ras_fw_eeprom_check_safety_watermark(ras_mgr->ras_core);
-
-	return ras_eeprom_check_safety_watermark(ras_mgr->ras_core);
+	return ras_core_check_safety_watermark(ras_mgr->ras_core);
 }
 
 int amdgpu_ras_mgr_get_curr_nps_mode(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index 17703ed0c7f6d..4744a7991757b 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -137,8 +137,7 @@ static int amdgpu_ras_sys_event_notifier(struct ras_core_context *ras_core,
 		break;
 	case RAS_EVENT_ID__DEVICE_RMA:
 		ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_RMA, NULL, 0, NULL);
-		if (!ras_fw_eeprom_supported(ras_core))
-			ret = amdgpu_dpm_send_rma_reason(ras_core->dev);
+		ret = amdgpu_dpm_send_rma_reason(ras_core->dev);
 		break;
 	case RAS_EVENT_ID__RESET_GPU:
 		ret = amdgpu_ras_mgr_reset_gpu(ras_core->dev, *(uint32_t *)data);
-- 
2.55.0

