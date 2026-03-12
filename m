Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E49103E301
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 10:28:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B5F510E9DC;
	Thu, 12 Mar 2026 10:28:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cg8QtO3w";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013030.outbound.protection.outlook.com
 [40.93.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 368AA10E9DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 10:28:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKfBpQ0xD5pXrFptZAQfsIdl29jZ1ELk5bTvmsIpnAvzqu1oKnXWEUlkLyrNvelvAtC6mAkdL+X6cq+fpp0bN4GjmJ/sxTYADCboDE6zfvLUGbjr6zG6zchoDTlclLbdXohmbE0FBqIre57CKgUFKcf7IakiThiStqe/qnXsSwT6WOItbmoL8c3JFPix6NouCAv9ncIT8IFQuTjkHShX6JOa9QqK2GP7DDEnsZ4qeqVmeZZtoVSU4n71OG3zcU/CY1YGpcrMQSxyjeOWhzP4P2+90UXR7gcWigfL05y5aF+97cBcIEAuV4fL0BQixjehmz3w86cDGy2YN5CRYY0EdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vco8RdAYNngs4v5odGddwQCV82SWOksXaanpAa81lUg=;
 b=QVzKZ6l5RNqvmeMUce/MT5Tfv41ZHwhJMFtGu2hTuEvPoU1s8odCM1iQ+RMCVRukAyQxP6Cj6KCmG3b2Fz6w43g84MbQM9olMN92TZGtkaF2KNKy9s0rx+FE0CzUCpCC31TfN9mlg1V5sLPYcAAoSNvLFwrHZuFQ5/IMmwLQxhYodX++VAcstjEHVsvm4cqzna4k8rY+e9pfZwrFo7P8wBRUbB4/znQOAX5hCbahKnWbUYRLk60flxKh2l93KeIH6WD65pQL4U66m/yNVmNy83T+mzBltk8ZtZFM8/uA6D5+JjLtccE6wb0Xdfp35uvpLkJoc67bPW3Lzl13FrKYqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vco8RdAYNngs4v5odGddwQCV82SWOksXaanpAa81lUg=;
 b=Cg8QtO3wM9JlXYWVpi/74818eHjUEaCm6Zi2GXI28j/soGlY0wWQByMuzhjNiXm28WGYGRw8RxpvIrmtFUhfAkFWkQ9Zl8gvmKvPIr2VH9VbwCnSUo3o3M6SMe2x3PA4bmlOniQ77KAbMs8+yy1n0bKJwrryfoyuNVnoZ55fztE=
Received: from DM6PR03CA0102.namprd03.prod.outlook.com (2603:10b6:5:333::35)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 10:28:01 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::dd) by DM6PR03CA0102.outlook.office365.com
 (2603:10b6:5:333::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 10:27:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 10:28:00 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 05:27:58 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH v2 3/3] drm/amd/pm: Use common smu fw check function for smu15
Date: Thu, 12 Mar 2026 18:27:35 +0800
Message-ID: <20260312102735.609454-3-asad.kamal@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: f7762b36-f2bc-44ae-59da-08de8022094e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: R1CG05GDoppuoTC7zGDvg0+ri90LVwImM8zppdc6a3/uugU2SjjiPAd3uWBU2Tbp6UUfzEdZkJcEyMf9sOuXVQdext0PCpVTFj+AACMKadmP5MERzBnXUpaW4YlktHUJReri2ico7VNQEkHb6yi3T3+HsOvPEmQGxjRw91s6glx6My4ifCBqmpTsswcDLk3JSK48qC30g9vxQcpWkFRFWh+jcR9yuEKS40G0XePtzGg9abl6fkUKecLRoCGbBggjWjT76IYvoZm/0JcrW56wPgZXS0GxFf4ArIaY/+VEAnzx50+sfuJTh5pxkhPUw99xGhhZJzgJA8daqY2DiiCHAOiuB2/8PcbrbsxPtlK0SVv+NZVbp/mjPqicHLzexDCSNXS1HSBUwewyDkf8S0VLrJz14xa4kzeXCDMU1LkAdHx9qzDoyBuLHyc5Nd/c17low8b8X6Ss7wJZBgrF6HVLRg5wiJfMrtMkVAsF7uJYgCD3WeW0k2H9OzJaaLTkvT8+jj4+B3Ly0MDHCKiV6g1l9WNKw2Q3AWmVKPvyddDI59YZZ4vOiX8v1fOJCdZvin2KtK0lT3YdV21Ilm9pJrgpssaGzg2pPXKZEgjcZ8Rqj9ott0luJki2qIX/GRpYW/AY13bKBMxYTYLd9oaTLhwZFYX60dQcz6s6HKzU2MY0W8npLlj4F/PMnsizNAC1DisuyVKULWoOkKn8O1HJiTj/0tIceG+ckAoTKQO//FlO1+KjI++pYlx9jTlnB9DzxvTQWxBze9yn8xouUu6QfaeOSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H7tfdupshjPj/fZkmirlwNY/9KMqA+gl+mftkI6Kmb3Hohy64OaM7IrAZGxbJ15zp28dfwt37Zrq7HzHJUVMVwflSR03Wf53idmquieGahPK02pAPNj/zoL4lgpKSH/3Dp2QlGiiOwtjd/f8dvwOOYVmjO/SimBwYd0Q+YdYhRotEgwn4q4QRtyIgyetb49DJbSHeRvmRPRWKERBy+uJANlyOY7cOaPHP1mtGgObnaeTwzULcvliah+StfXnP0OSYwGllSa3ie354D4xcAfXoKMgzqimZrVagVr8a5j8UjZLUNLR+Ps5efM09DYxuQF9h+L4gFFqk4ttuvZ8ZNe5nmTHUriyKarUfu571fGRh+x7rFZpckZNUc+Q+TUVgo9XWvR0uN+iowF6gg2ub1pQdRtyypoAtO2OAxbfd4nQdBplqmukDtApvfMv/IbWbl/m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:28:00.5772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7762b36-f2bc-44ae-59da-08de8022094e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953
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

Use common smu fw check function for smu15 and remove dedicated ones

v2: Remove dedicated functions and directly use common one

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |  2 -
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 52 -------------------
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  |  3 +-
 3 files changed, 2 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
index ab4a64f54e79..09743ccd0d15 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
@@ -142,8 +142,6 @@ int smu_v15_0_setup_pptable(struct smu_context *smu);
 
 int smu_v15_0_get_vbios_bootup_values(struct smu_context *smu);
 
-int smu_v15_0_check_fw_version(struct smu_context *smu);
-
 int smu_v15_0_set_driver_table_location(struct smu_context *smu);
 
 int smu_v15_0_set_tool_table_location(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index a2f446d38be8..478ee87af51f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -207,58 +207,6 @@ int smu_v15_0_check_fw_status(struct smu_context *smu)
 	return -EIO;
 }
 
-int smu_v15_0_check_fw_version(struct smu_context *smu)
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
-	if (smu->is_apu)
-		adev->pm.fw_version = smu_version;
-
-	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
-	case IP_VERSION(15, 0, 0):
-		smu->smc_driver_if_version = SMU15_DRIVER_IF_VERSION_SMU_V15_0;
-		break;
-	default:
-		dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
-			amdgpu_ip_version(adev, MP1_HWIP, 0));
-		smu->smc_driver_if_version = SMU15_DRIVER_IF_VERSION_INV;
-		break;
-	}
-
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
-	if (if_version != smu->smc_driver_if_version) {
-		dev_info(adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
-			 "smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
-			 smu->smc_driver_if_version, if_version,
-			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
-		dev_info(adev->dev, "SMU driver if version not matched\n");
-	}
-
-	return ret;
-}
-
 static int smu_v15_0_set_pptable_v2_0(struct smu_context *smu, void **table, uint32_t *size)
 {
 	struct amdgpu_device *adev = smu->adev;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 660335d7bda9..9a4a5f482e75 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -1416,7 +1416,7 @@ static int smu_v15_0_common_get_dpm_table(struct smu_context *smu, struct dpm_cl
 
 static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
 	.check_fw_status = smu_v15_0_check_fw_status,
-	.check_fw_version = smu_v15_0_check_fw_version,
+	.check_fw_version = smu_cmn_check_fw_version,
 	.init_smc_tables = smu_v15_0_0_init_smc_tables,
 	.fini_smc_tables = smu_v15_0_0_fini_smc_tables,
 	.get_vbios_bootup_values = smu_v15_0_get_vbios_bootup_values,
@@ -1468,6 +1468,7 @@ void smu_v15_0_0_set_ppt_funcs(struct smu_context *smu)
 	smu->feature_map = smu_v15_0_0_feature_mask_map;
 	smu->table_map = smu_v15_0_0_table_map;
 	smu->is_apu = true;
+	smu->smc_driver_if_version = SMU15_DRIVER_IF_VERSION_SMU_V15_0;
 
 	smu_v15_0_0_init_msg_ctl(smu);
 }
-- 
2.46.0

