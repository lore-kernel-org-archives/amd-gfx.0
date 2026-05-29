Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E21CD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 09:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E43E10FBF8;
	Fri, 29 May 2026 09:41:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XSMAPkpV";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013022.outbound.protection.outlook.com
 [40.107.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A8CB10FBEC
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 09:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHscFXOIUSHUHdYhLgTBQ5tzVd2wmNlsDPsTQyYH9Gyr3gt1BX1shqclWMP/tPbqJc4e5p+OuNP/ROx5Gu3Z+qnthrxlodywtV8gZYmiGPTi+SqP4g1fs4FL9PXhgoL2PpcwPJVH5OWt/Hvol3nlJuvIZNXz1ZHG93TnIaAgPO3WPo1wWXTJG4KNS804a9QS1Y9ie3nzfzH0NgBdqj+m9pPHEEjzkACfVfnDUoJ/6NwIyqqLWegXwKskUOP4LhsBRSl8uzKU+fF7xIImSYumo2ckGDJw7+3CxqJwjYLVC6bureY2DF2bMrwtNwxcBb4HNccGJGXxOeUIfB+y0/BrIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gd2Tx9wq3FDBatiUvgAGs/6+YnF5dnMO+lsi3N8EsU0=;
 b=OYnfXW78DHx5RCAx1axSU3B8ZPMRWZilkO41BXmdC5B5axxKk87q/RzjlbnQbakSSOl6MxyYsfhTtQYEPsL+Yj624dNwnlyVxK97eZZIPuNAsxlSb96lUkRo9YrvdPy3qwxipCMMCXkJ6pX9muRPlPY5PsA/IcHvJDbPUREPg9+mUiJ7BhNRJgUpF0NZEJ2D4XPrDK0b/GyEmL60VZtclb3AaVGIXbRS15e+B2O26w3FieqQrsjXa2mPJ2oTU8wQo+1D4XXnHmZe+BgRdEQ3L1UYVyKhvtq0QU/H5nXoNjgsylaI+jbzjL2+IwhKfM6TVncpetHK+w36oD/mJm0L1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gd2Tx9wq3FDBatiUvgAGs/6+YnF5dnMO+lsi3N8EsU0=;
 b=XSMAPkpV+OtAG9ao7pUq5tBNqPJyKnsjaDpzUgqQipLREVA/VCsMHqAt7+/BjloV0OW3NhEkapg6klWKDgQhEYeTHw1+ydRl1Dws+eeu7LDax52rHma+xM9WDwsQKBYScql9a3j+tTKFkLnC6lo/VHTNctdyjWnNGoZBSVX0wTA=
Received: from CYXP220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ee::10)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.14; Fri, 29 May 2026 09:41:42 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:930:ee:cafe::61) by CYXP220CA0006.outlook.office365.com
 (2603:10b6:930:ee::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 09:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Fri, 29 May 2026 09:41:41 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 04:41:39 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 3/5] drm/amd/pm: Use helper to get pptable in SMUv13
Date: Fri, 29 May 2026 15:11:17 +0530
Message-ID: <20260529094119.1134923-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260529094119.1134923-1-lijo.lazar@amd.com>
References: <20260529094119.1134923-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 10611a4e-0cc4-427c-e4cb-08debd667d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|3023799007|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eC2xn69X3JxnCLasPz3oCRtl+xyp+nYnEsHUU3ohUZ2Yxf9or1gDrzJsd7KVbifJwrQm2orjuAYE4NdWZOQF1qpGOi56mJcATYuA8Y75HXLzfNg2fk0nQAkOTijieocS7IX87CFw2lgBBC+L5J0wO6QdeJUed5KUj6VxpaDINKj3KnqatoAYBYwe+hjsO5hulvY6TvhZolrXfAfCba1I6m0LvQq5GGMKxajbkj1N5uQ4OHKGe3Ql55Pw2vKuR/TuGtk3gwd/Xi7fjfx2pLIHnVCzfb2heDBYNRWxHky59OHhxjr2otznpe2NPo82uTOEE8O9nJiU6JT2kpUVY43TTAjBI9Nsy3b+maFBNL8Q5j3L+lErkOk6MKlGNCWZlUPwvV9bzNdv0lLrqbvo6815qCEeCoz2a6mB6oTEwgHYSqpBAp5eKjsXcL0ASgDGPOrymA73AiH/ChUr3j2xa3HuAezaPz3EB92Td47NzvFX78Ckem18hW0j93Uiwq9n1yXw1z8YD1ZYzmkqjM5xVhPyndV4VqWj9Y20PwYx0fzzACGZcOWWRLibpR6BF4JOExKLNWaCr7SjA2xmxSErY9AIp4Q4G9sOfpTlZfDjTC48BYXDAGivZXYyBGqHukbFJTmlWPqIgTfLWm7GWF1RB6kfmWoFSSlFCyqoE3/2TdWQXAZ5rRv2PNAFyAqfM9cmnyyosOFh2UKQ/wNOw1Eg0630XU88clSTm2YcOOraXtmahR0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(3023799007)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F8+hqtU5/zk1vYJAifkQKEJ66pM09cW/K62IANGBqeg9jj//4R2HPwM+liWCbpmFAbsO+h7fmfcbBSGWerHWItptYWUP4+bMimyJDEso7up8mo+MwmR0pM6irkjzsIj2/aqPej02BrSjVuA7R+PMu9EZ6nup4mt/EvYfvX2uouRuN1BlzqcxI/bN6DKueT2Ag1jI8Kspk401jJO0QowjXhhaiapFxV/50ep5s99KHiqp0CQ10++MjBi/72Q6iHiIZX7rpqqkGzFfiGqq2bf1sFdH5a610oyW1He3Fx2MPamCwPTj/ePsn7rNecpH/Yr2q6RzfSsXLA5ttmc3HS9iSVNqOZ12bhns7jBD89IWf9/CKSXHRsHu59PJDUDSAaJywLngUrymDTnGkLUQIdMNjaeIMTv4VWeYN/0geut4G5HNCSFhlykXKLAT2Rt30cPB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 09:41:41.7723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10611a4e-0cc4-427c-e4cb-08debd667d36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769
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

Use common helper function to get pptable from firmware binary in
SMUv13.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Assisted-by: Claude Sonnet (Cursor AI)
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  4 -
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 85 +------------------
 2 files changed, 2 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 89bbda0670ef..68f4de5f800c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -255,10 +255,6 @@ void smu_v13_0_init_msg_ctl(struct smu_context *smu,
 
 int smu_v13_0_mode1_reset(struct smu_context *smu);
 
-int smu_v13_0_get_pptable_from_firmware(struct smu_context *smu,
-					void **table,
-					uint32_t *size,
-					uint32_t pptable_id);
 
 int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 				     uint8_t pcie_gen_cap,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index d8a1c402a624..d511f03354a6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -218,7 +218,7 @@ int smu_v13_0_init_pptable_microcode(struct smu_context *smu)
 	if (!pptable_id)
 		return 0;
 
-	ret = smu_v13_0_get_pptable_from_firmware(smu, &table, &size, pptable_id);
+	ret = smu_cmn_get_pptable_from_firmware(smu, &table, &size, pptable_id);
 	if (ret)
 		return ret;
 
@@ -258,48 +258,6 @@ int smu_v13_0_check_fw_status(struct smu_context *smu)
 	return -EIO;
 }
 
-static int smu_v13_0_set_pptable_v2_0(struct smu_context *smu, void **table, uint32_t *size)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t ppt_offset_bytes;
-	const struct smc_firmware_header_v2_0 *v2;
-
-	v2 = (const struct smc_firmware_header_v2_0 *) adev->pm.fw->data;
-
-	ppt_offset_bytes = le32_to_cpu(v2->ppt_offset_bytes);
-	*size = le32_to_cpu(v2->ppt_size_bytes);
-	*table = (uint8_t *)v2 + ppt_offset_bytes;
-
-	return 0;
-}
-
-static int smu_v13_0_set_pptable_v2_1(struct smu_context *smu, void **table,
-				      uint32_t *size, uint32_t pptable_id)
-{
-	struct amdgpu_device *adev = smu->adev;
-	const struct smc_firmware_header_v2_1 *v2_1;
-	struct smc_soft_pptable_entry *entries;
-	uint32_t pptable_count = 0;
-	int i = 0;
-
-	v2_1 = (const struct smc_firmware_header_v2_1 *) adev->pm.fw->data;
-	entries = (struct smc_soft_pptable_entry *)
-		((uint8_t *)v2_1 + le32_to_cpu(v2_1->pptable_entry_offset));
-	pptable_count = le32_to_cpu(v2_1->pptable_count);
-	for (i = 0; i < pptable_count; i++) {
-		if (le32_to_cpu(entries[i].id) == pptable_id) {
-			*table = ((uint8_t *)v2_1 + le32_to_cpu(entries[i].ppt_offset_bytes));
-			*size = le32_to_cpu(entries[i].ppt_size_bytes);
-			break;
-		}
-	}
-
-	if (i == pptable_count)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int smu_v13_0_get_pptable_from_vbios(struct smu_context *smu, void **table, uint32_t *size)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -322,45 +280,6 @@ static int smu_v13_0_get_pptable_from_vbios(struct smu_context *smu, void **tabl
 	return 0;
 }
 
-int smu_v13_0_get_pptable_from_firmware(struct smu_context *smu,
-					void **table,
-					uint32_t *size,
-					uint32_t pptable_id)
-{
-	const struct smc_firmware_header_v1_0 *hdr;
-	struct amdgpu_device *adev = smu->adev;
-	uint16_t version_major, version_minor;
-	int ret;
-
-	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
-	if (!hdr)
-		return -EINVAL;
-
-	dev_info(adev->dev, "use driver provided pptable %d\n", pptable_id);
-
-	version_major = le16_to_cpu(hdr->header.header_version_major);
-	version_minor = le16_to_cpu(hdr->header.header_version_minor);
-	if (version_major != 2) {
-		dev_err(adev->dev, "Unsupported smu firmware version %d.%d\n",
-			version_major, version_minor);
-		return -EINVAL;
-	}
-
-	switch (version_minor) {
-	case 0:
-		ret = smu_v13_0_set_pptable_v2_0(smu, table, size);
-		break;
-	case 1:
-		ret = smu_v13_0_set_pptable_v2_1(smu, table, size, pptable_id);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
 int smu_v13_0_setup_pptable(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -380,7 +299,7 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
 	if ((amdgpu_sriov_vf(adev) || !pptable_id) && (amdgpu_emu_mode != 1))
 		ret = smu_v13_0_get_pptable_from_vbios(smu, &table, &size);
 	else
-		ret = smu_v13_0_get_pptable_from_firmware(smu, &table, &size, pptable_id);
+		ret = smu_cmn_get_pptable_from_firmware(smu, &table, &size, pptable_id);
 
 	if (ret)
 		return ret;
-- 
2.49.0

