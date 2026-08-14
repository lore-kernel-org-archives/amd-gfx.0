Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87F9C5DF79
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE3CB10F721;
	Fri, 14 Aug 2026 21:03:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mhbtG6ev";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 295CD10F711
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VR2dAyl8BA5Oq4bRcU46svMUisMBWM1xP94Jj8I2gkXjbH++HP6jBxM602sHnVSzdgHwDtc6bqZxgsnYWZvDEaMqu9BgbUgzxyw74pBF49jH0aSIfCK/G7stBamkBbeYoavXnwma/8TPlXFzS8z8gnW+oOFo+Dh0uYhgySlarVTPx3sE9ZQtL7tH1BmNzIP3fviWDCAazGnAYkgdUfTyANMKvd1uX5ZbsBEQd4dc3IO6BJOO6sDXvddAlFYkYMTeN92uqrt8uWIQZIw77aBGi8xC71wYlrFUAogpbpBdDgsIRSz+Sk/kpV5HGggn38PrCjbNeWRD++CGpGE4p1CTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJrzvzET7IXITC5lalNdPMZhlwRmKv7U+7ufOHO34jE=;
 b=ZY5GtPoF4iJfBOMVONAjYtQ+c5oumIumMaWiOQ7pef9uklX9gqXfaw+MY/Fh979ZAZI0SZOY7TrDA1usD/L6Yrlg8zijLFMR8wcoZswBpgRwB0rPVdvLOBhT4a1I92aNXr6N6cdqoYVvVmKSMromfDTiMyrlyMW6xZy390i8Tsb9YrByak5MzoKuYRR/zgRGZFXIZeuphV4ePZc2MVjeDUYgT3hjjZ5SYV0hInxM73hHi08a/Z6ufMmFr0peiL0H1PNpG5GsZHMvb/56d5Sgh1sbH5ejqQYcV+2mFQZ9fUWg3E4EJ7W/BOX+RJA1K9uBIw9IYI7zGpUB8RZO96yLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJrzvzET7IXITC5lalNdPMZhlwRmKv7U+7ufOHO34jE=;
 b=mhbtG6evko67hxZaqwSmimNlfqGQ2Gz8DIqjKm4SsG3C4nPmGseyWPJzju12Ah+9tGtavskrdGAdo217hBfUvKNEsi60Er5oDTDyI92JGg3iFRdvj3Ex/7maGRtWwOr6C1HeSoA4B1t01FDgwCUHzSDxrD6HU+FO2xqNuLvnjlk=
Received: from CH2PR10CA0005.namprd10.prod.outlook.com (2603:10b6:610:4c::15)
 by CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:39 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::9c) by CH2PR10CA0005.outlook.office365.com
 (2603:10b6:610:4c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Fri,
 14 Aug 2026 21:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:37 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 065/109] drm/amd/ras: support multi-parameter communication
 with mp1 in ras_mp1_v15_0
Date: Fri, 14 Aug 2026 17:02:02 -0400
Message-ID: <20260814210246.3067612-66-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 6334cc6d-0227-4ea5-0a8d-08defa4783f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099006|3023799007|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 1hhOf8XzcsgpR5X+WzPfbAS9NKr+fYM989NElyKpzOjUkZMKyR96dHevDsEHYdsggS0wcEfEojooVbNMjsxRdaLKMUW6N77SK8So0804Hjw7wOnB/4xb8jAmYR4gcWYNWN4mTT9fj2ZPDlrb6UPaJEpVEeR2Hj+OWL9ISSPrw7asuzXNe5foXxex6ZXDIAD9AI48RvvjIf6/aH8cLAQNepBQ6qqDvSvY2SZ25pKQbLTCH72bjzqqKDNrYKinQkJhLHPtDw986yI8/ll9G/3SFtLAHZVw73RzXtaJvs7VPO0Eytm7Ym28Ld9k0dZ0WL0udDxgahanSuWVogtEOEunXL/ulOFD5NwjGwsx/Wxqx6gsAOyrTI7zKA836UH6N0OGYNMLSh/nfCwuv/axqUzrKrzKqqgo+FWNz7dpzUTOnwpmTx6TmTR4SDD5VlFWBaVg5fwQCrOs7SFfDSXX6W379t/HolN22nX36zZdw0XSCvlH2w2vdhWTjjZGTDp+h1abrvHBOtGKv4FD7egSgCBY7qEWaw54UbWTdYSp3khV5Z3L9zG53QlTclkxDW/Te6GNO6XVEl8OJoyfFZ7JlelwsBpsndDfTwhYyj5T+Iv6c3Ril2Z1eJUW2bjIH9E7dvfB3qr1AwWTm5HizqB4sIIjgS03COhAvX4Tymco5fFBS3M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(3023799007)(5023799004)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZJG8YSROtOQgy56KgLMrY4qkOJP2dI1RqDJezngpUhI+tq2x4zHeU+Ae4jJ6fTmvgXMtVhSfWqwhCOkgobq03ntgrqimpCYNTuB6qhmM8pz/y6noK1t/3E3jXFiM7Lw8fL7XPp0o0HBj6Ua/vvJLEu9m2pFWiNerJtNk4YCmHLOQzgTzR7sUixb33IVvwZFTuZpGnRMjeOCxo30/A3V6vEMo04lbvfdRDRnz+GJY8m9Tb1ZzNqKWh3LjnAQUrMM0QzVHq9Nf1B7iqlIAJulIQTh3Lgu5mPT8amtlxm4s1DbrgilKTcRr/2F7e52QUuzQDbPXCj48PaPRxxYOHUZf+YIPzBQU+W8KTIOegc+OxWoi072lSMrK1g54Nc1P7bwDV9GOux6a9IA7Afu4fyxRGdN8VHEO4Y0Ev5JCqhGg8x3JqmoSUiSTwnCFLl+v123z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:39.6061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6334cc6d-0227-4ea5-0a8d-08defa4783f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588
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

support multi-parameter communication with mp1 in ras_mp1_v15_0.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   7 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   2 -
 drivers/gpu/drm/amd/ras/core/ras.h            |   2 +
 drivers/gpu/drm/amd/ras/core/ras_mp1.c        |   2 +-
 drivers/gpu/drm/amd/ras/core/ras_mp1.h        |  24 +---
 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c  | 121 +++++++++++++-----
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c  |  10 +-
 7 files changed, 99 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 649fdc4471487..4e8950a143e98 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -667,13 +667,6 @@ int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type ms
 	return ret;
 }
 
-int amdgpu_smu_ras_send_msg_legacy(struct amdgpu_device *adev,
-		enum smu_message_type msg, uint32_t param, uint32_t *read_arg)
-{
-	return amdgpu_smu_ras_send_msg(adev, msg, &param, 1,
-			read_arg, read_arg ? 1 : 0);
-}
-
 int amdgpu_smu_ras_feature_is_enabled(struct amdgpu_device *adev,
 						enum smu_feature_mask mask)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index b77723f04268d..f1f61efb968ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1993,8 +1993,6 @@ ssize_t smu_get_pm_policy_info(struct smu_context *smu,
 int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type msg,
 			const uint32_t *params, size_t num_params,
 			uint32_t *read_args, size_t num_read_args);
-int amdgpu_smu_ras_send_msg_legacy(struct amdgpu_device *adev,
-		enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
 int amdgpu_smu_ras_feature_is_enabled(struct amdgpu_device *adev,
 						enum smu_feature_mask mask);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 2311d988b3e52..38ab1aa9be0f9 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -213,6 +213,8 @@ struct ras_mp1_sys_func {
 	int (*mp1_get_ras_enabled_mask)(struct ras_core_context *ras_core,
 			uint64_t *enabled_mask);
 	int (*mp1_set_debug_mode)(struct ras_core_context *ras_core, bool enable);
+	int (*mp1_send_ras_msg)(struct ras_core_context *ras_core, u32 msg_id,
+		u32 *params, u32 num_params, u32 *read_args, u32 num_read_args);
 };
 
 struct ras_eeprom_param_config {
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.c b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
index 7ba872732efd2..34578806ef3c0 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
@@ -111,7 +111,7 @@ bool ras_mp1_rma_detected(struct ras_core_context *ras_core)
 }
 
 int ras_mp1_set_timestamp(struct ras_core_context *ras_core,
-		u32 timestamp)
+		u64 timestamp)
 {
 	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
 	int ret;
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.h b/drivers/gpu/drm/amd/ras/core/ras_mp1.h
index 6eac9488843e1..d70070645cede 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.h
@@ -40,23 +40,9 @@ enum ras_mp1_msg_id {
 };
 
 struct eeprom_err_record {
-	u32 timestamp;
-
-	union {
-		struct {
-			u32 mca_addr_low;
-			u32 mca_addr_high;
-		};
-		u64 mca_addr;
-	};
-
-	union {
-		struct {
-			u32 ipid_low;
-			u32 ipid_high;
-		};
-		u64 ipid;
-	};
+	u64 timestamp;
+	u64 mca_addr;
+	u64 ipid;
 };
 
 enum ras_err_type;
@@ -72,7 +58,7 @@ struct ras_mp1_ip_func {
 			u32 *table_version);
 	bool (*rma_detected)(struct ras_core_context *ras_core);
 	int (*set_timestamp)(struct ras_core_context *ras_core,
-			u32 timestamp);
+			u64 timestamp);
 	int (*reset_ras_table)(struct ras_core_context *ras_core,
 			u32 *result);
 	int (*get_record_count)(struct ras_core_context *ras_core,
@@ -102,7 +88,7 @@ int ras_mp1_get_table_version(struct ras_core_context *ras_core,
 		u32 *table_version);
 bool ras_mp1_rma_detected(struct ras_core_context *ras_core);
 int ras_mp1_set_timestamp(struct ras_core_context *ras_core,
-		u32 timestamp);
+		u64 timestamp);
 int ras_mp1_reset_ras_table(struct ras_core_context *ras_core,
 		u32 *result);
 int ras_mp1_get_record_count(struct ras_core_context *ras_core, u32 *count);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c b/drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c
index fc977396d9cb0..9b3c6651bb852 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c
@@ -26,9 +26,6 @@
 #include "core_status.h"
 #include "ras_mp1_v13_0.h"
 
-#define MSG_DATA_LOW32(idx)   (idx | (0x1 << 16))
-#define MSG_DATA_HIGH32(idx)  (idx | (0x2 << 16))
-
 #define regMP1_SMN_C2PMSG_40                              0x0068
 #define regMP1_SMN_C2PMSG_40_BASE_IDX                     2
 #define regMP1_SMN_C2PMSG_41                              0x0069
@@ -58,19 +55,33 @@ static u32 ras_mp1_msg_codes[RAS_MP1_MSG_MAX] = {
 };
 
 static int __direct_send_mp1_msg(struct ras_core_context *ras_core,
-		enum ras_mp1_msg_id msg_id, u32 input, u32 *output)
+		enum ras_mp1_msg_id msg_id, u32 *inputs, u32 num_inputs,
+		u32 *outputs, u32 num_outputs)
 {
 	u32 msg_code = 0;
 	int timeout = 100000;  //100 ms
 	u32 reg = 0;
 
+	if (num_inputs > 2 || num_outputs > 2)
+		return -EINVAL;
+
 	msg_code = ras_mp1_msg_codes[msg_id];
 	if (!msg_code)
 		return -EOPNOTSUPP;
 
 	/* Send message and parameter to fw */
 	RAS_DEV_WREG32_SOC15(ras_core->dev, MP1, 0, regMP1_SMN_C2PMSG_41, 0);
-	RAS_DEV_WREG32_SOC15(ras_core->dev, MP1, 0, regMP1_SMN_C2PMSG_42, input);
+	if (num_inputs == 1) {
+		/* Input u32 parameter */
+		RAS_DEV_WREG32_SOC15(ras_core->dev,
+			MP1, 0, regMP1_SMN_C2PMSG_42, inputs[0]);
+	} else if (num_inputs == 2) {
+		/* Input u64 parameter */
+		RAS_DEV_WREG32_SOC15(ras_core->dev,
+			MP1, 0, regMP1_SMN_C2PMSG_42, inputs[0]);
+		RAS_DEV_WREG32_SOC15(ras_core->dev,
+			MP1, 0, regMP1_SMN_C2PMSG_43, inputs[1]);
+	}
 	RAS_DEV_WREG32_SOC15(ras_core->dev, MP1, 0, regMP1_SMN_C2PMSG_40, msg_code);
 
 	/* Poll MP1 response */
@@ -83,35 +94,85 @@ static int __direct_send_mp1_msg(struct ras_core_context *ras_core,
 	};
 
 	if (reg != MP1_RESP_OK) {
-		RAS_DEV_ERR(ras_core->dev, "MP1 fail to ack 0x%x for msg: 0x%x, 0x%x, %p\n",
-			reg, msg_code, input, output);
+		RAS_DEV_ERR(ras_core->dev, "MP1 fail to ack 0x%x for msg: 0x%x\n",
+			reg, msg_code);
 		return -EIO;
 	}
 
 	/* Read output data */
-	if (output)
-		*output = RAS_DEV_RREG32_SOC15(ras_core->dev, MP1, 0, regMP1_SMN_C2PMSG_42);
+	if (outputs && num_outputs) {
+		if (num_outputs == 1) {
+			/* Output u32 parameter */
+			outputs[0] = RAS_DEV_RREG32_SOC15(ras_core->dev,
+						MP1, 0, regMP1_SMN_C2PMSG_42);
+		} else if (num_outputs == 2) {
+			/* Output u64 parameter */
+			outputs[0] = RAS_DEV_RREG32_SOC15(ras_core->dev,
+						MP1, 0, regMP1_SMN_C2PMSG_42);
+			outputs[1] = RAS_DEV_RREG32_SOC15(ras_core->dev,
+						MP1, 0, regMP1_SMN_C2PMSG_43);
+		}
+	}
 
 	return 0;
 }
 
+static int __sys_send_mp1_msg(struct ras_core_context *ras_core,
+		enum ras_mp1_msg_id msg_id, u32 *inputs, u32 num_inputs,
+		u32 *outputs, u32 num_outputs)
+{
+	if (!ras_core->ras_mp1.sys_func ||
+	    !ras_core->ras_mp1.sys_func->mp1_send_ras_msg)
+		return -EOPNOTSUPP;
+
+	return ras_core->ras_mp1.sys_func->mp1_send_ras_msg(ras_core,
+				msg_id, inputs, num_inputs, outputs, num_outputs);
+}
+
 static int __send_mp1_msg(struct ras_core_context *ras_core,
-		enum ras_mp1_msg_id msg_id, u32 input, u32 *output)
+		enum ras_mp1_msg_id msg_id, u32 *inputs, u32 num_inputs,
+		u32 *outputs, u32 num_outputs)
 {
 	if (msg_id >= RAS_MP1_MSG_MAX)
 		return -EINVAL;
 
 	if (ras_core_in_early_init(ras_core))
-		return __direct_send_mp1_msg(ras_core, msg_id, input, output);
+		return __direct_send_mp1_msg(ras_core, msg_id,
+				inputs, num_inputs, outputs, num_outputs);
 	else
-		return ras_core->ras_mp1.sys_func->mp1_send_eeprom_msg(ras_core,
-				msg_id, input, output);
+		return __sys_send_mp1_msg(ras_core, msg_id,
+				inputs, num_inputs, outputs, num_outputs);
+}
+
+static int __send_mp1_msg32(struct ras_core_context *ras_core,
+		enum ras_mp1_msg_id msg_id, u32 input, u32 *output)
+{
+	return __send_mp1_msg(ras_core, msg_id,
+			&input, 1, output, output ? 1 : 0);
+}
+
+static int __send_mp1_msg64(struct ras_core_context *ras_core,
+		enum ras_mp1_msg_id msg_id, u64 input, u64 *output)
+{
+	u32 in[2] = {lower_32_bits(input), upper_32_bits(input)};
+	u32 out[2] = {0};
+	int ret;
+
+	ret = __send_mp1_msg(ras_core, msg_id,
+			in, 2, output ? out : NULL, output ? 2 : 0);
+	if (!ret && output)
+		*output = ((u64)out[1] << 32) | out[0];
+
+	return ret;
 }
 
 static int ras_mp1_v15_get_table_version(struct ras_core_context *ras_core,
 				     u32 *table_ver)
 {
-	return __send_mp1_msg(ras_core, RAS_MP1_MSG_GetRasTableVersion,
+	if (!table_ver)
+		return -EINVAL;
+
+	return __send_mp1_msg32(ras_core, RAS_MP1_MSG_GetRasTableVersion,
 			0, table_ver);
 }
 
@@ -119,19 +180,19 @@ static bool ras_mp1_v15_rma_detected(struct ras_core_context *ras_core)
 {
 	u32 rma = 0;
 
-	if (__send_mp1_msg(ras_core, RAS_MP1_MSG_GetRmaStatus, 0, &rma))
+	if (__send_mp1_msg32(ras_core, RAS_MP1_MSG_GetRmaStatus, 0, &rma))
 		return false;
 
 	return rma;
 }
 
 static int ras_mp1_v15_set_timestamp(struct ras_core_context *ras_core,
-			u32 timestamp)
+			u64 timestamp)
 {
 	if (!timestamp)
 		return -EINVAL;
 
-	return __send_mp1_msg(ras_core, RAS_MP1_MSG_SetTimestamp, timestamp, NULL);
+	return __send_mp1_msg64(ras_core, RAS_MP1_MSG_SetTimestamp, timestamp, NULL);
 }
 
 static int ras_mp1_v15_reset_ras_table(struct ras_core_context *ras_core,
@@ -140,7 +201,7 @@ static int ras_mp1_v15_reset_ras_table(struct ras_core_context *ras_core,
 	if (!result)
 		return -EINVAL;
 
-	return __send_mp1_msg(ras_core, RAS_MP1_MSG_EraseRasTable, 0, result);
+	return __send_mp1_msg32(ras_core, RAS_MP1_MSG_EraseRasTable, 0, result);
 }
 
 static int ras_mp1_v15_get_record_count(struct ras_core_context *ras_core,
@@ -151,7 +212,7 @@ static int ras_mp1_v15_get_record_count(struct ras_core_context *ras_core,
 
 	*count = 0;
 
-	return __send_mp1_msg(ras_core, RAS_MP1_MSG_GetBadPageCount, 0, count);
+	return __send_mp1_msg32(ras_core, RAS_MP1_MSG_GetBadPageCount, 0, count);
 }
 
 static int ras_mp1_v15_get_record(struct ras_core_context *ras_core,
@@ -160,30 +221,20 @@ static int ras_mp1_v15_get_record(struct ras_core_context *ras_core,
 	int ret;
 
 	if (!rec)
-		return 0;
+		return -EINVAL;
 
-	ret = __send_mp1_msg(ras_core, RAS_MP1_MSG_GetTimestamp,
+	ret = __send_mp1_msg64(ras_core, RAS_MP1_MSG_GetTimestamp,
 			idx, &rec->timestamp);
 	if (ret)
 		return ret;
 
-	ret = __send_mp1_msg(ras_core, RAS_MP1_MSG_GetBadPageMcaAddr,
-			MSG_DATA_LOW32(idx), &rec->mca_addr_low);
-	if (ret)
-		return ret;
-
-	ret = __send_mp1_msg(ras_core, RAS_MP1_MSG_GetBadPageMcaAddr,
-			MSG_DATA_HIGH32(idx), &rec->mca_addr_high);
-	if (ret)
-		return ret;
-
-	ret = __send_mp1_msg(ras_core, RAS_MP1_MSG_GetBadPageIpId,
-			MSG_DATA_LOW32(idx), &rec->ipid_low);
+	ret = __send_mp1_msg64(ras_core, RAS_MP1_MSG_GetBadPageMcaAddr,
+			idx, &rec->mca_addr);
 	if (ret)
 		return ret;
 
-	ret = __send_mp1_msg(ras_core, RAS_MP1_MSG_GetBadPageIpId,
-			MSG_DATA_HIGH32(idx), &rec->ipid_high);
+	ret = __send_mp1_msg64(ras_core, RAS_MP1_MSG_GetBadPageIpId,
+			idx, &rec->ipid);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
index 698a373005092..baf5f156fc6fb 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
@@ -44,8 +44,8 @@ static enum smu_message_type
 	return ras_smu_msg_maps[msg_id];
 }
 
-static int amdgpu_ras_send_mp1_msg(struct ras_core_context *ras_core,
-			u32 msg_id, uint32_t param, uint32_t *read_arg)
+static int amdgpu_ras_send_mp1_msg(struct ras_core_context *ras_core, u32 msg_id,
+		u32 *params, u32 num_params, u32 *read_args, u32 num_read_args)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
 	enum smu_message_type smu_msg;
@@ -56,8 +56,8 @@ static int amdgpu_ras_send_mp1_msg(struct ras_core_context *ras_core,
 		return -EOPNOTSUPP;
 
 	if (down_read_trylock(&adev->reset_domain->sem)) {
-		ret = amdgpu_smu_ras_send_msg_legacy(adev, smu_msg,
-				param, read_arg);
+		ret = amdgpu_smu_ras_send_msg(adev, smu_msg,
+				params, num_params, read_args, num_read_args);
 		up_read(&adev->reset_domain->sem);
 	} else {
 		ret = -RAS_CORE_GPU_IN_MODE1_RESET;
@@ -67,5 +67,5 @@ static int amdgpu_ras_send_mp1_msg(struct ras_core_context *ras_core,
 }
 
 const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func = {
-	.mp1_send_eeprom_msg = amdgpu_ras_send_mp1_msg,
+	.mp1_send_ras_msg = amdgpu_ras_send_mp1_msg,
 };
-- 
2.55.0

