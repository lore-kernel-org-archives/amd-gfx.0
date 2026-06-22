Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AB1CDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDBEF10E583;
	Mon, 22 Jun 2026 08:46:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c1q0KRSb";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012071.outbound.protection.outlook.com
 [40.93.195.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92E4310E575
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:46:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5Am4p9HHyCbjK8kxwYxv9uaFrWjDnELcYGRoBAukOsXHLtRmjy10mxzAnDg3P5jH43Y6GemtL3038mgKMpvRApGFQM7CJe3avSxcMVaof0LwU994Fv+W+Wig6PJ1i7lu5LHEmHfsTSbI4AGXAde3uRjk4pRi8eUoiMgCzUgp6CcW+bNNsB8OXyQCIMwAPlLHqEUQrjAe9emAnVM3zdGicTBMSBEE0vLjxiNpvY8FLrXKhD8pSp24c4trTqNowkAhwSd3LT31NAzwFAW9+P3wlvKgy0gvaj5DuZlWIcSwfdKPji+FGSqnuavwjcTdg5Q3CrekB+zgsypBKseCfrGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMcdubtyTaEkg8cVhuPnyFKmX+XDwaLtKWMexUc86tc=;
 b=Rahnetv7FgdRxQ6IvakkEM18Bb/yatmgDpU4nmT9Cx2pl2+S7dG8n47uuVQZ7Bh9igJJx7ifNZNAl3moEqWz6Me6Uyetg5m5SdOhFpqZXXkCLcVEQDAnCYAt4RUqnkOm9ZBhLpq1yJsUc9MOzgyTK/yekf98QgJEZQeMzFH4hQLN4K8jszqt6RCtDd2kbVUtiPK4rj3ZEz2Grm8pNXjI5/oeJrUXYIUZgZi8cVi6JxxMP0pifRn+612t6s3m+wHFd4xXvht8nBZ2Uu262y457mQ2N6FECrVb4MHkkRGAxdTYGzDxJAFUXZ4UTNszmYJa6PoVnfK/s3cgoa49hsKvRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMcdubtyTaEkg8cVhuPnyFKmX+XDwaLtKWMexUc86tc=;
 b=c1q0KRSbZNQnC8SfKfWZtzglRZrkkjRZK2wp1AR6YukG4By5aU2S599apgJ+fmjDiI7uutfFkSC468ZgzVeO3JK0X9LsYPPAIRlKdaPLEETR/IQiFlRTF9eGNp2iagmc2NlKXm1HZC2bR5XJ2K3S7tGtwHR9UHVPxOaae3gpI6Y=
Received: from PH8P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::6)
 by DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 08:46:13 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::33) by PH8P223CA0009.outlook.office365.com
 (2603:10b6:510:2db::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 08:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:46:13 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:46:10 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 32/48] drm/amdgpu: retire legacy PMFW RAS eeprom write skip
Date: Mon, 22 Jun 2026 16:44:34 +0800
Message-ID: <8efdda727814f808c37a576f58d6032d8423e7db.1782117608.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
References: <594f7cbae0387b60f8af49505b57c1a5a604db2f.1782117608.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS0PR12MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ecca319-d875-41eb-adc0-08ded03ab748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: aj+uHOK2niEbFs1tXfxFz/naNEYXgZXMiQvXZy20WDxguhacY6n4DJDxloAag4iu70gj2P3tas3e9oR58ZumbdFREuRdN7I2DtyclZ4fjAlzj31mSpkYTG/cu/Qz9SarmspHyMUkUs1Sr+xoFFiIC0xpSMBXQz/TdzvoGnZq6NBCkEG3853Ye8U4qbSPGIFKs+wjv00fkYabvo6Xe1DCWai1hX/sl31mmFsxzrO/AEYLzvFVrrZ1p9v3oOO71aShzuf2BBx50Rf+lXI/ONH9HcsVwGzWhZ1x9WqG5JwSdJh4Kg+mJPtWPTu+R0N++J1vF42dejZnjzUnWPSqtVbjD46JPVrtYJPAROZ6JDS1f/DB4QdqSLdtpF/ouYz7XdKh9sRuYKuQ8ksAZ+A9/z6T/3bMVp42JcLZ1rhEZsNiLQtOZCsTteKL0JgNSUn6AcU/h64oLIBZda+Bq8VMxXmstBAaZmq18Fxskl9uXs2RE90ZiRYh5R7K8lgq/jpJBGBccIYUI6NhxbOl5bmFdw5BJ84mWhTpBmOYdnSVzKMgw6f3dVJ+kyzZ/kJ/Bi13Z2/enmx2E5mqmzgfESCHJaKy6nsrUHMFO3G3o7H6uTGJNYyALEJxMoBNrdVN3S1IW/9j4VNpmOEF5oqGbXZ3MIxhoIJ2oupMgBm7rOSrFPENTL1yeuZ87DPwhx+lw1R+TqKuk9kVFlnI0yrcGkRmoIzZzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jHfY6vqHJomNoplatC6qU+qNhUEplaMXE44nPcO0BZavDh7QE3scFlquMlmy4sNJWHDYPDUZhKeG+WHgfX+hURLXqi9Ex+S6a8u7iVq2o6Q7Qqp0z+/gA7R8CwL5Ze+J87YQG3jVimRjwG2xO8guiRuqZ9dRq5k/m6CwFmrUKW8nI7FEIGj+wTg8HE0GW4+rfZkZS47s7oMnBIuf5qP+/ZBEE891XG5lvMIYijIpMfnanFPaRng0JD61QZ2G8+ilBRwNK4OyW5v/9efKsvVRmZxHyIt9B2G2v/ZWr2X5RegEaKtXPyMtcGfrLhizV/RBa2ZeDX2faJIU1RoBqCxXPN/tvpl19srTZrpj7TYUwysNBIxKJyw8yz7x4fgHg0ioU7OEvo2GRHEfX4pzRhOZ4URKYH+2mKmh9C6qSxmHBpkTlJb/Nz2luwWcPXFgHrBh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:46:13.3997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecca319-d875-41eb-adc0-08ded03ab748
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536
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

