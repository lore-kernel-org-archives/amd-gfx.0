Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC7D103E301
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 10:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FC1810E9D3;
	Thu, 12 Mar 2026 10:28:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WGPsEidJ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011031.outbound.protection.outlook.com [52.101.57.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE4AC10E9D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 10:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXkbA3H8xIkAVkxkPnhQEVsIZdHN4XlBYXhQCSCqkUc/1WUPt0iaiFo3k9WlFCM8D55RXvcyVCB8wHhSJyW8B1PnwOGqmXsOjKmTHDqGh5BPDYZ34LS3A0p2oku/Lsk/YrrMFDC77WEkik2COPB2zrBxwryNnL8h220lEcbSwZ+r8JnG/mJkwOJJh2ehskHon9u7hgxOHcI3ZmlYMsgLG3UQ7WeC+sSbawapv0CcEUgWeiSVNiYFQAGz9SeMfKc3fel0T0L3W3A8LEwv4IzvN4muSYY6vi+VTWujz79aM+3kwhDh6niaMURPnG+dgMAgnAQJ0dPu96O4QHnOI9bwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSUTqsPuhiaPQ/jXDaA//GXVmnI/jx/FMxucZ7YdkRg=;
 b=ubSepmjiBK4dnVexuPusXdx+Q2w2LsRnIC7EzJyJltnOQswICS+VnEgTm8CvghZA6GtKmU/YlVv0zjU8jGYJpdDhQR7kpDVO8tZ7dZuaxSJLNjQ/ZWenpZ3c7vrmqLv3lEXInBGF0y/bUDcH5MPvX8p4yZpFmNL1DHeasu827C4m0sb4uoH8QbGy+45w4Gz0umeyg+G+6qyq4GZULxjokgcT8Jwbe22Kacug5HKS8vbVBs+RksuYHTqrj5MsjpL9/EqoXCviwUSlOtkNgZNyRz8HPfI/7ZjfOlhtQogsWVRj1turgBAu7EEaPeb1vHv/FHHsXx3nrVYRc/UzF91ZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSUTqsPuhiaPQ/jXDaA//GXVmnI/jx/FMxucZ7YdkRg=;
 b=WGPsEidJrxwm3eKreBEOnOdjHSZLO3ZLlWTlMuOst74PkdOgyqu+5mQbgVFDTwGEU8fsHXo1xSB12ajnyw8IYGt1HfFYD5F2bMYc8+2TPJqevrfUDR+ao8WN2uytzZ4qMFobkJ5PBeGuNKRLeE727mFort1MjtTT3aAKIsnq5kc=
Received: from CH2PR18CA0013.namprd18.prod.outlook.com (2603:10b6:610:4f::23)
 by SA1PR12MB9547.namprd12.prod.outlook.com (2603:10b6:806:45a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 10:27:59 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::54) by CH2PR18CA0013.outlook.office365.com
 (2603:10b6:610:4f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend Transport; Thu,
 12 Mar 2026 10:28:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 10:27:59 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 05:27:55 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH v2 2/3] drm/amd/pm: Use common smu fw check function for smu13
Date: Thu, 12 Mar 2026 18:27:34 +0800
Message-ID: <20260312102735.609454-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260312102735.609454-1-asad.kamal@amd.com>
References: <20260312102735.609454-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|SA1PR12MB9547:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf50f38-b67d-4cef-2d00-08de8022086c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1vpIqFJ7ZflizMdwTzRsGOGU/MmwzfQlTDRAVMBRTsY5waYiBW4AQ4H+qKdYxq+MFVyclgqI4k3QlWxnFT6M95rQ4S/b6nkkggqfb+jnkhQNrNvwugE6UUPgr+8OzClgvMJaCGLRN0qeHtXAWmdBf/DOoRPWkju0SCtZn4ltOLi4lzzYMv6HiCXs5/xa5ZxDWCmALXmRV+o1feN3fl11kbhfWiTGh9rBADzFr3JxCqIMxt6rZBp39UdNfc2bxD3O1q/5vjTR1dzmGFdSqrxAyOC1DpypHXyYCcsyU3vyOampeRB5mcDDVB39zcdn1J9EnxZpC4RPiHES24ExJpy1jz0maAMLqv+wsb3nt8Qk4GItpbekk35yq22OTAb1BKCoXyIPXIYEOA13qODyP+BVXIIo+Xzd5tdjnHVFlvcaWw9M3Zhyp2zEf8u3QNXgoERbXRoHylXFi9pN7Cyx7yqVJXdluM2KfjKIjfRj2e+bcp0VJfd2y2OXA09p+U4UvkzoLDqdVySvVHTHRGUcNp9TEfdOo8OHeVVzeG0hU70roOa2f5epP3xP7t+oyckh9hGda1JZ6IBCGK8R0kT341fFdrn/cWHdR4FS6lSkfcsfSXu4ROsGvAzhATTU5iyzn2P8917LmZUs4Sz6WmK9h4a9kiSUZIIMiFRbuKN1Saf3vI/a8Az4vtx+OJwdabgYWLqpOS+iAcSjc6l7nYaL1sN/X/v5n/ly+YPlsBO07/KCbAus1pdkAm+JNWdYmejq8uqvXTkxNy4nDi3PcsHXy6YsmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Pq2VeeG4X4wcticnTEN1o0gpTm5AXPqG3gBYncZNcDmgWdJZN2Rd51LnSnq70Slt3r0AAAEbhktqqzVElZTtQ/+VdImkBoPRzpby/bi2y7bdkBtx9JB/r4BGmkuBuiKkmdPZ5MNqsEJZZFrYZl3fynBZSYEjaLJ8g2F/oJyyNwPo/w7/+5eFIN/pdN2rUJCRzL2aVoFmpf3aeZFsKBr/XH/lZ42OgkBpV60FaIf3hcfF61N1RyD9rytSCDkHwjMIFzUrJD3Axu1s+6fnQr7b2FDAi4Nx/oNBwqb80Vyq22buKxpa9SyaSlr9CPX4lMqcjDP6wTbK5whcQ0QMc2eGBB0AMqIpmGhFD1lTU1s02KOfo/CnOCgnVlA7GCM5OHt6omY8I/Jk3cJGrWEI4515crBZy8jawPyB2FRbz9dE5Qm/DcqNfB7k1wQP9hzY18s7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:27:59.0936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf50f38-b67d-4cef-2d00-08de8022086c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9547
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

Use common smu fw check function for smu13 and remove deicated ones

v2: Remove dedicated functions and directly use common one

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  2 -
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 43 -------------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  2 +-
 9 files changed, 7 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index b0d6b7b0946d..89bbda0670ef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -132,8 +132,6 @@ int smu_v13_0_setup_pptable(struct smu_context *smu);
 
 int smu_v13_0_get_vbios_bootup_values(struct smu_context *smu);
 
-int smu_v13_0_check_fw_version(struct smu_context *smu);
-
 int smu_v13_0_set_driver_table_location(struct smu_context *smu);
 
 int smu_v13_0_set_tool_table_location(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index ad23682217ee..259e5a13c1bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1989,7 +1989,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	/* pptable related */
 	.setup_pptable = aldebaran_setup_pptable,
 	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
-	.check_fw_version = smu_v13_0_check_fw_version,
+	.check_fw_version = smu_cmn_check_fw_version,
 	.write_pptable = smu_cmn_write_pptable,
 	.set_driver_table_location = smu_v13_0_set_driver_table_location,
 	.set_tool_table_location = smu_v13_0_set_tool_table_location,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 1cff37d7f60d..cf3781aba02a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -258,49 +258,6 @@ int smu_v13_0_check_fw_status(struct smu_context *smu)
 	return -EIO;
 }
 
-int smu_v13_0_check_fw_version(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t if_version = 0xff, smu_version = 0xff;
-	uint8_t smu_program, smu_major, smu_minor, smu_debug;
-	int ret = 0;
-
-	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
-	if (ret)
-		return ret;
-
-	smu_program = (smu_version >> 24) & 0xff;
-	smu_major = (smu_version >> 16) & 0xff;
-	smu_minor = (smu_version >> 8) & 0xff;
-	smu_debug = (smu_version >> 0) & 0xff;
-	adev->pm.fw_version = smu_version;
-
-	/* only for dGPU w/ SMU13*/
-	if (adev->pm.fw)
-		dev_dbg(smu->adev->dev, "smu fw reported program %d, version = 0x%08x (%d.%d.%d)\n",
-			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
-
-	/*
-	 * 1. if_version mismatch is not critical as our fw is designed
-	 * to be backward compatible.
-	 * 2. New fw usually brings some optimizations. But that's visible
-	 * only on the paired driver.
-	 * Considering above, we just leave user a verbal message instead
-	 * of halt driver loading.
-	 */
-	dev_info_once(adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
-			 "smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
-			 smu->smc_driver_if_version, if_version,
-			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
-
-	if (smu->smc_driver_if_version != SMU_IGNORE_IF_VERSION &&
-	    if_version != smu->smc_driver_if_version) {
-		dev_info(adev->dev, "SMU driver if version not matched\n");
-	}
-
-	return ret;
-}
-
 static int smu_v13_0_set_pptable_v2_0(struct smu_context *smu, void **table, uint32_t *size)
 {
 	struct amdgpu_device *adev = smu->adev;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 0a7307f5eb4c..f5940e77077a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -3134,7 +3134,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.fini_power = smu_v13_0_fini_power,
 	.check_fw_status = smu_v13_0_check_fw_status,
 	.setup_pptable = smu_v13_0_0_setup_pptable,
-	.check_fw_version = smu_v13_0_check_fw_version,
+	.check_fw_version = smu_cmn_check_fw_version,
 	.write_pptable = smu_cmn_write_pptable,
 	.set_driver_table_location = smu_v13_0_set_driver_table_location,
 	.system_features_control = smu_v13_0_0_system_features_control,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 75b90ac0c29c..167b3499f7f1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -1098,7 +1098,7 @@ static int smu_v13_0_4_set_fine_grain_gfx_freq_parameters(struct smu_context *sm
 
 static const struct pptable_funcs smu_v13_0_4_ppt_funcs = {
 	.check_fw_status = smu_v13_0_check_fw_status,
-	.check_fw_version = smu_v13_0_check_fw_version,
+	.check_fw_version = smu_cmn_check_fw_version,
 	.init_smc_tables = smu_v13_0_4_init_smc_tables,
 	.fini_smc_tables = smu_v13_0_4_fini_smc_tables,
 	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 8ee5002e3d6b..141e778333c5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -1102,7 +1102,7 @@ static int smu_v13_0_5_set_fine_grain_gfx_freq_parameters(struct smu_context *sm
 
 static const struct pptable_funcs smu_v13_0_5_ppt_funcs = {
 	.check_fw_status = smu_v13_0_check_fw_status,
-	.check_fw_version = smu_v13_0_check_fw_version,
+	.check_fw_version = smu_cmn_check_fw_version,
 	.init_smc_tables = smu_v13_0_5_init_smc_tables,
 	.fini_smc_tables = smu_v13_0_5_fini_smc_tables,
 	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 1bf3ebfe8656..5b9580034641 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -481,7 +481,7 @@ static int smu_v13_0_6_check_fw_version(struct smu_context *smu)
 {
 	int r;
 
-	r = smu_v13_0_check_fw_version(smu);
+	r = smu_cmn_check_fw_version(smu);
 	/* Initialize caps flags once fw version is fetched */
 	if (!r)
 		smu_v13_0_x_init_caps(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index fa23f3d4a3fd..35b2b8f5801a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2790,7 +2790,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.fini_power = smu_v13_0_fini_power,
 	.check_fw_status = smu_v13_0_7_check_fw_status,
 	.setup_pptable = smu_v13_0_7_setup_pptable,
-	.check_fw_version = smu_v13_0_check_fw_version,
+	.check_fw_version = smu_cmn_check_fw_version,
 	.write_pptable = smu_cmn_write_pptable,
 	.set_driver_table_location = smu_v13_0_set_driver_table_location,
 	.system_features_control = smu_v13_0_system_features_control,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index f9789b1fcbf8..748b5b074fff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -1331,7 +1331,7 @@ static int yellow_carp_set_fine_grain_gfx_freq_parameters(struct smu_context *sm
 
 static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.check_fw_status = smu_v13_0_check_fw_status,
-	.check_fw_version = smu_v13_0_check_fw_version,
+	.check_fw_version = smu_cmn_check_fw_version,
 	.init_smc_tables = yellow_carp_init_smc_tables,
 	.fini_smc_tables = yellow_carp_fini_smc_tables,
 	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
-- 
2.46.0

