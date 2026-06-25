Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F0ACDB466
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22B2410F198;
	Thu, 25 Jun 2026 08:21:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CWJyJqRy";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E1B610F195
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhxDc8ea7pG4E9Y065NmBEc7VsSHHY51jZVLU4O5K1WKzZRkCSVZWm0lAWlnvARb9xqO4IQs2meAnqfPbCREXyPP9oLU8c/WnPvPm6J8cJTOKdvRTa2DxIyhGNPYlDnuT4H4Ufx9QhHKRkemtYw77mG8lpB2qwJq250tDp7AQ4JeW2Db7VdcLi9TvlwUyyiqep7LswfRFs0F3W7mhdV4cx53pBrgoKPRl31rVH2Oplmv+V1Dz6vY9vWl/cz0lIN6tg8iTi8bz4HJKsmvafL/ODQARzMq3mXrof2hd9itK+49RjasDWrgnxHrnoGtQhIwmZ3qmEUQgaMbbW/jmAB+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMcdubtyTaEkg8cVhuPnyFKmX+XDwaLtKWMexUc86tc=;
 b=wxKBmMqBxnksi69u4lI8LsK6cNUMRy9vYMISyttT45NxUTqnxKgERXZFp6vK2Ujgpo2REDyifTr4Z8MuXRqwyo3gDTSIZgwkEUlrp0cFiEow/5s4TbmiNfu4RvPsnx3XqO+A4orypt6FTnchYh4xnLzxfvjaKT6w8RDEqJSiYSC1o7UvBf3kyE+z1m0prvx3e2bEXk5CA3ZAn3P2CTdWxypmTV1Pba5qk0ayZc4mqpwyQQ0OBfaJfoY00rwTOqogWVOvJi1xw0sYXpBlFHm2oeuIO3YCjuAEYLCGDjbmUZgV9pcBMinwzwVDifIml/nrtExvrUOojk/1sumC6j5AAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMcdubtyTaEkg8cVhuPnyFKmX+XDwaLtKWMexUc86tc=;
 b=CWJyJqRyZdoE703AvQvEhZJraN6KsIjpEDo6w47zHSu+HJBmT37XvlXARc4IZRtkFS8zmzOIB7QEozp0nheTBgEWZuXmSnnmk+ARZTCqZIGToUpuP/KQB1Mmc+Py1z7WCGL8vIi8dfRMyeiLOrdF1d+0xA2JlX7uTMUnajD2m/w=
Received: from PH8PR07CA0035.namprd07.prod.outlook.com (2603:10b6:510:2cf::22)
 by DS7PR12MB9549.namprd12.prod.outlook.com (2603:10b6:8:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 08:21:13 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::29) by PH8PR07CA0035.outlook.office365.com
 (2603:10b6:510:2cf::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:21:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:21:12 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:21:08 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 30/44] drm/amdgpu: retire legacy PMFW RAS eeprom write skip
Date: Thu, 25 Jun 2026 16:19:23 +0800
Message-ID: <38113704208d280cd7719a827ee0ddcc98b4e892.1782373702.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|DS7PR12MB9549:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b85baf-2a1d-4cc6-101b-08ded292b7ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ld2Ll9nOIyE8PthGB9vyN/zYOZaoIrzAEB1yKaRBrC/84cOUxPeKQAVfSl8s5f0gQ/grlcszPuStcgFJLGpkYCQlDKPIa3qH1QUR4ghtpCmb7yKrrgmjJmHBGL584CgM3EK/pHXmDA24bkgoYsbc5boNfL9YlNRQH/oRnYGik4z+7wqgfMgEC/mihO1v1TJVD03IvYIkc/2BW3lv2Q2Yg1tibaZaRvuVBxdY1jZtvkcvIhTNdh1f7LmyCDhQ0r8T84dH/gxkLYJ2zx6bcZkdH2hYQvWbnl5vrWirFGc6zFLbucadrW4QIR5//sjInwfYGKynDTJs29gfs8QBF/G1pcVHQzcgQRXdd9jO/VdCSlaWnPzNk0RW00c8ngWzU6CQXyCcLCxbJJZJjpBE8XjmjVbaX/I5RMuSDo/1yhVL1EGFlaXQmp6jNqYD0sJ+dUiZ9lhCez86Q8wQXsHJrKMWD0kMGZYfkz7Isere0kQbMDYVVRkTneSXsK5y1pJrbcyB2jfbDj/G9QD4VLp5PgTbeotoOugQ7vMTdx9D1Hxm7pWaLdc1vHCllrnUB8gMxew79HyEIB6pig0O+sF4c97DUuNwTb71/mgdk8WRGIiKQkD9q1mtXxBj3Hdmi8NG4sjahuRL1H80Vylh0VM7+8pJBq4l51PufkhJ413paik4VMX+gZNXs18ZZQIKZyGZeA/7UD7AQdF3pr2fnkPS3NlXCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +3hq/qFdKfbjSvKLCeXc6ILITY9XJO0NFF2aZg82r08x16eb6H4cq14+kf/n4qnD86hmzraolSj6GSLFKA/11v/fqT1tGwnwzebiUnrEEv26uohBrn34evdkDQE8NTHJywPeZHRWK9fuikm3Ag2Hg+j8MN8Br3ktbmZ3++zPlxXtb8DkGgallsD5fxYeYefyVi4PIOTv1RfR6INb1ZLaFEOEZlAzuwrtlBmHfpKxrEjZfE+ycLANrbNO2VyCIgcRgYTVH6ZnIsVgfrlmpGcoJHyRHwo3WHlQU9kdZqTqbdK29jxdCE8naBx6eogBYPkauCusrjB2E31ubm1nCA9zYFIAZ2hKTAOWKgA4+w4b1GeHxCUfMJWBltDjJe/G5uF/rL2+VLoLc6VWOdnJ797Lz48iUPrJ/cGZRj8PXcO9XVwTDMRm1GCqlw/zY5tjKI/M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:21:12.5141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b85baf-2a1d-4cc6-101b-08ded292b7ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9549
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

Remove the legacy logic that skips eeprom writes for PMFW-managed RAS data

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 43 +------------------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  3 --
 2 files changed, 1 insertion(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index d28e8958b0ff..80de2459c76a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -124,8 +124,6 @@
 					RAS_TABLE_V2_1_INFO_SIZE) \
 					/ RAS_TABLE_RECORD_SIZE)
 
-#define RAS_SMU_MESSAGE_TIMEOUT_MS 1000 /* 1s */
-
 /* Given a zero-based index of an EEPROM RAS record, yields the EEPROM
  * offset off of RAS_TABLE_START.  That is, this is something you can
  * add to control->i2c_address, and then tell I2C layer to read
@@ -878,44 +876,6 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 	return res;
 }
 
-int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *control)
-{
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-	int ret, retry = 20;
-
-	if (!amdgpu_ras_smu_eeprom_supported(adev))
-		return 0;
-
-	control->ras_num_recs_old = control->ras_num_recs;
-
-	do {
-		/* 1000ms timeout is long enough, smu_get_badpage_count won't
-		 * return -EBUSY before timeout.
-		 */
-		ret = amdgpu_ras_smu_get_badpage_count(adev,
-			&(control->ras_num_recs), RAS_SMU_MESSAGE_TIMEOUT_MS);
-		if (!ret &&
-		    (control->ras_num_recs_old == control->ras_num_recs)) {
-			/* record number update in PMFW needs some time,
-			 * smu_get_badpage_count may return immediately without
-			 * count update, sleep for a while and retry again.
-			 */
-			msleep(50);
-			retry--;
-		} else {
-			break;
-		}
-	} while (retry);
-
-	/* no update of record number is not a real failure,
-	 * don't print warning here
-	 */
-	if (!ret && (control->ras_num_recs_old == control->ras_num_recs))
-		ret = -EINVAL;
-
-	return ret;
-}
-
 /**
  * amdgpu_ras_eeprom_append -- append records to the EEPROM RAS table
  * @control: pointer to control structure
@@ -934,11 +894,10 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 			     const u32 num)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int res, i;
 	uint64_t nps = AMDGPU_NPS1_PARTITION_MODE;
 
-	if (!__is_ras_eeprom_supported(adev) || !con)
+	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
 	if (num == 0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index a62114800a92..3c7fcce5fe8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -82,7 +82,6 @@ struct amdgpu_ras_eeprom_control {
 	/* Number of records in the table.
 	 */
 	u32 ras_num_recs;
-	u32 ras_num_recs_old;
 
 	/* the bad page number is ras_num_recs or
 	 * ras_num_recs * umc.retire_unit
@@ -191,8 +190,6 @@ int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
 			struct eeprom_table_record *record, u32 rec_idx,
 			const u32 num);
 
-int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *control);
-
 void amdgpu_ras_check_bad_page_status(struct amdgpu_device *adev);
 
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
-- 
2.34.1

