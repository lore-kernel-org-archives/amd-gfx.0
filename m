Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B683CCDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E8C10E471;
	Mon, 22 Jun 2026 04:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OlhKPgd8";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D51E10E473
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:42:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojR0FNFT5g7w2xaTrb7alZQ0ftbkAOUsA9RQxGT0jwFori6KTfGExS5GvGnqPKbOxLs+HEtblJu5Su+8D4Wcmd5e7kzmMT4DuY2LbbSz3seHWqiZWcSUOpLI4R/xbNKMMPOJCPMt7lsphpyDcD05436cq9jLeaLdngFRC9cLyb8SE1rv7/JZWWpwT6fPXyUflxCGmkS+WTzfxCeCw6Qu9kaube+ozFKrcIx66kEUVIOz3i2Zm8r/VsgJfumXwLmsyFRoVr5CJlVqThs+F5jV760g97ChTOB9B0wu5bvE6yFcC+ST6fQo2sDaPimnvM/KFvuEgLMQApScTk8aLcxChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBurd0NrK9AYA2Egh8T0nK+J1XhBAV5bN94F0bYqiTo=;
 b=HcOJQz44h/0ofusQMHw/ue0cxzYUbIuHEm5QuPTOesLz8gP6zf02DE7iO7yjJeLZ7pKbi2sAssLBvKNW1Tb2NJg+YN7dgDEmrQKWCAD1Pwm1Ab11YMe1oJ7973MW5H2XMM4KQz0d0AMxew2i/26JmlBkmbdpdo9z1F7Skn+sZueoWKMY+UtpL6esVa9jJheHk4Y+auYSRxl+nbYNMjt8PqBmaiX22OJraFlWvMyzysjwil4K/DOdf8Q5L7JDsKd/6eH+xX5WERUu4QcOKbk8+hQPXMB8UNtXGHSjuBgZEhBfPasMMDa6repwc6gtqRWM2+SuJXLQHkUwp9xqk9EQBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBurd0NrK9AYA2Egh8T0nK+J1XhBAV5bN94F0bYqiTo=;
 b=OlhKPgd8H+PQ8IET1FLL+aX1tXpRafdQVrQ86qjzvzqqjrLL8Za7Qozz2vypEiNHs3TALKOcjdPgQkwh1lwFrma2mLPEx18l479iZn+5X+hCsdvOvKdf6R+JfUbzTR3RGu1sdd/2qXtbAWmFMWpCRHEeUX69svEJ3hOqKcFABR8=
Received: from IA4P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::11)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 04:42:38 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:558:cafe::7c) by IA4P220CA0011.outlook.office365.com
 (2603:10b6:208:558::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 04:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:38 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:37 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 19/48] drm/amdgpu: retire legacy RAS reset/query operations
 for XGMI v6_4
Date: Mon, 22 Jun 2026 12:40:08 +0800
Message-ID: <0851c30eaff12803ccdff0eb6d9ff1c903a24643.1782103073.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|DS7PR12MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: c005c43b-9a3c-42e7-3607-08ded018b044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: k8Gzp77X2mvsfEdxX7jZGQasioYz//TdQD+IahmHMD42J+FzCgCNVGmo16tOJBptVtq5U8/6heoqLb8SH30T0Fv1Gx8IHa+9PGETIvo84hoSCzihjzBE9j/9X6aHIvrMWVkA4UPm22m4Zvxvaoept2VfkY9zGO5mgpkK8gHk4neilxvOBpw7gsxk/cBiKtmOi16MAhL7fI7iylCyyKrbIDY0sLR7uB8IN4rz21bCQGF3zLWfjz6PddykymQiu/xXnmWHRP8guGSF01+sTuLwYfkAJsoQl6XSM8l76BQ9FtPHYl6lCGlbdyxX5k5jSRB1cDsnZNEnEKBgqNws035pJd3AH8imQufOPF3luSMdNgAtycDXeFi+xXDg3T5KtCZ4EgKtPyn2SqsBuqJyJ4RsnMMSUuFv/B2zWbux9ylbvksM4j/7T9OXohan+/pI18nli0/yTys3nAhoPiXt9BxfOUV1hNI5RJ2bOoITbLkv6SSnFL9KgxYWBMJjQgKPuMMfP4vM3517wpL4J6DuHr2g+Gr5LLqIWggEAftI9lRZ0coak4iDSSofNdVRDUoG8Cw9qrzK6Mmv/V7l1iOc813+xG1y1ufAkY20UgEOL1jNZ+B/vIiMfs/JZq6RWc4Vpve5St7mh3/6B1T4ogugQvxhMDxx+ZREXlDhcfskTSs7bzvJWMjITq6eKzhgFyCEdLiVjbNErgrWElG2zxSBA+kHcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KqU6LMBhIbCQZcQZc66L+Z2geQkQHAzZ4XrjB7Cs+bf4XK8O6ydE7WVqB8q7Esl/11HXZ3eVlx0WzXBzoRX3LncyRNFccRffrBzqAwrj71qnPHtVn0i+XGWE0HEAwVwlGnLOtxohv9TQEgq0l0AG8e3c7v6lGVVvqjNswrAlPbvNkYblgke630k+zREyAv6qpkKyBdpsQSBSmtUwrTfvxAal5ueI9G9ZRwoL0yiFEtU9eN818oWBatmLFH4R41SmjL39R3YpckDSj0ccwdjnBd0uEFPlU79EHW4uilAODlt+Rc15YsxD3kyziUrkblVKMETPDoKnQ3a5jbQk8a9aVhAIxsmjDFA3yyGc8ZcBayg58E2GDfmhyARQGFNYkSAOK49hcBs59eL+YUvFFW5mwFQnhMN/5DPiGrbYNnD9GHE0K6hOL/W5PCtYaBr+FRmu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:38.7692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c005c43b-9a3c-42e7-3607-08ded018b044
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863
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

retire legacy RAS reset/query operations for XGMI v6_4

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 49 +-----------------------
 1 file changed, 2 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 5fa706915d49..59c76fe3c56b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -106,16 +106,6 @@ static const int walf_pcs_err_noncorrectable_mask_reg_aldebaran[] = {
 	smnPCS_GOPX1_PCS_ERROR_NONCORRECTABLE_MASK + 0x100000
 };
 
-static const int xgmi3x16_pcs_err_status_reg_v6_4[] = {
-	smnPCS_XGMI3X16_PCS_ERROR_STATUS,
-	smnPCS_XGMI3X16_PCS_ERROR_STATUS + 0x100000
-};
-
-static const int xgmi3x16_pcs_err_noncorrectable_mask_reg_v6_4[] = {
-	smnPCS_XGMI3X16_PCS_ERROR_NONCORRECTABLE_MASK,
-	smnPCS_XGMI3X16_PCS_ERROR_NONCORRECTABLE_MASK + 0x100000
-};
-
 static const struct amdgpu_pcs_ras_field xgmi_pcs_ras_fields[] = {
 	{"XGMI PCS DataLossErr",
 	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, DataLossErr)},
@@ -1165,17 +1155,6 @@ static void amdgpu_xgmi_reset_ras_error_count(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-
-	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
-	case IP_VERSION(6, 4, 0):
-	case IP_VERSION(6, 4, 1):
-		for (i = 0; i < ARRAY_SIZE(xgmi3x16_pcs_err_status_reg_v6_4); i++)
-			pcs_clear_status(adev,
-					xgmi3x16_pcs_err_status_reg_v6_4[i]);
-		break;
-	default:
-		break;
-	}
 }
 
 static int amdgpu_xgmi_query_pcs_error_status(struct amdgpu_device *adev,
@@ -1193,11 +1172,7 @@ static int amdgpu_xgmi_query_pcs_error_status(struct amdgpu_device *adev,
 
 	if (is_xgmi_pcs) {
 		if (amdgpu_ip_version(adev, XGMI_HWIP, 0) ==
-		    IP_VERSION(6, 1, 0) ||
-		    amdgpu_ip_version(adev, XGMI_HWIP, 0) ==
-		    IP_VERSION(6, 4, 0) ||
-		    amdgpu_ip_version(adev, XGMI_HWIP, 0) ==
-		    IP_VERSION(6, 4, 1)) {
+		    IP_VERSION(6, 1, 0)) {
 			pcs_ras_fields = &xgmi3x16_pcs_ras_fields[0];
 			field_array_size = ARRAY_SIZE(xgmi3x16_pcs_ras_fields);
 		} else {
@@ -1235,7 +1210,7 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 						     void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
-	int i, supported = 1;
+	int i;
 	uint32_t data, mask_data = 0;
 	uint32_t ue_cnt = 0, ce_cnt = 0;
 
@@ -1299,26 +1274,6 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 		}
 		break;
 	default:
-		supported = 0;
-		break;
-	}
-
-	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
-	case IP_VERSION(6, 4, 0):
-	case IP_VERSION(6, 4, 1):
-		/* check xgmi3x16 pcs error */
-		for (i = 0; i < ARRAY_SIZE(xgmi3x16_pcs_err_status_reg_v6_4); i++) {
-			data = RREG32_PCIE(xgmi3x16_pcs_err_status_reg_v6_4[i]);
-			mask_data =
-				RREG32_PCIE(xgmi3x16_pcs_err_noncorrectable_mask_reg_v6_4[i]);
-			if (data)
-				amdgpu_xgmi_query_pcs_error_status(adev, data,
-						mask_data, &ue_cnt, &ce_cnt, true, true);
-		}
-		break;
-	default:
-		if (!supported)
-			dev_warn(adev->dev, "XGMI RAS error query not supported");
 		break;
 	}
 
-- 
2.34.1

