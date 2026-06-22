Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D912CDB477
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EBB710E581;
	Mon, 22 Jun 2026 08:45:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oD0X4EAf";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EA5C10E570
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:45:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9TYbMJbJQNPv7T4dYzWr2Bq6ZyIFaEX6OAQetYrmjrd9LPb1z4S5NUUQfvdzO/LzKTzvii2n09Aoco3UNF+ZFmaWyd/d/8p9kicDuitLgEyuiGa8zur+2fN4fcswxRhRsURhYo5ul4FRWk1r/koKOYIMtwTRBY7x99wlyytXUCq1XkZ0MqFszFnB4X5iOjFWmEKx3/Aun+BeEY91tVptapNET1lW9DGf6QjGBE3Y+a6/khW63fNg7szDTW3oWXAjVejKpkHWkVz6GrXGnCV8Dd2fhYgtrkyTnfVTvUaJrKWn9AJ4RbxB3vuFi1jkq151CtCC++sKrqZkYtTH1yk2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6H5VrX0uG4PsWfRCNB8VBW8ujW0nmiTJCrL7pO4QPRQ=;
 b=gbauu27GbQFnrZJuNGKVv/wE7r7jq+JaKyxp6gRPHn33XDiJhlVuf03EeAUBPkhGXDP8QveTA2iR2U0djdxdyPxOzs7YjCFQoebMTTP1C0eA9rhENa8z06RJtsIQi3kXDhrXfhjnjaLSvWhRtF9RcgqH7R187Q4p3ANjHynSswI9DMZ94tIlvUKCOECzMIZUTFyHkxzLUtB7OhPT2gjsC99/6N/UMmZ8E8iHb3YluCuWGJ4i/N4ylzi0KT4CMq3wF4lsNnDA97R5JjD67Dr3vKCMeJjD9o/fp+vMMDYQnhVdR9FuSb3CUweT7yDi2IIoVL0/harHtzGlGevLR7l+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6H5VrX0uG4PsWfRCNB8VBW8ujW0nmiTJCrL7pO4QPRQ=;
 b=oD0X4EAfIvSeDzm/RPasObw60ZUxzVsN2Zl0wWS8oEygOfELEM4RnIBT8/48RNw5hyHH9DfyZwvFkOFD/Sx2jBrpfmpJSce1E3XuimHSF2j9T4njLLiFOLeQRrt28qDCo6DXz+/V7qVxZb4+9s1n4LxqRfPnT3krvtzYyKh/4Lo=
Received: from DS7PR06CA0035.namprd06.prod.outlook.com (2603:10b6:8:54::9) by
 DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.18; Mon, 22 Jun 2026 08:45:52 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::a6) by DS7PR06CA0035.outlook.office365.com
 (2603:10b6:8:54::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 08:45:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:45:52 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 03:45:50 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v2 22/48] drm/amdgpu: retire legacy RAS reset/query operations
 for jpeg v4.0.3
Date: Mon, 22 Jun 2026 16:44:24 +0800
Message-ID: <29e5f5eca018c7611a61bf745e74f50b1a50a001.1782117608.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DS0PR12MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 500a7eab-5c68-423f-6186-08ded03aaae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: NRBYat+cNR/M4ckRLIC5MP7T83kxcRjvECMcrE6pWZZ33ARMDH9kXoR14o/xhlJmDcvR1/9avCOx16LjZaohD/mBrXzDCiNrAvbMciE5iG/ZFCLPcO2fkKo2i6lq4idb7rmu0jK8C92xJbxBmyL/QoLKY2k3H8m8JVy9/qoEQdvGr1c7EmKeVtuj3X2JIY8ZhaD5OF+oZ44WwwtkMEvZ88UQdxb6WzFW5tQAjQH9DZZ8A3SoFzp+rugHB0/WvCFwIxvYtyvhOIMYyyNBrg9dRPQwLgaxSt1r/B6jWsO85jp5T8P/lZCJm3U2AtVr91PzkLmhcSnw0jTnAk3up2wftVNYc+MU/VUYTBJZ43mZwZXvwBPHdqQ4Sx+6tFPgOmWYM9rAa1WASizStqsxvPSFX4vECE0rANuAB5m9OkiKiuyA1lY9VFY9FNAXghJvMl5ZLm7C+fPAbGkuqZHC0qqH7Az0CXtf7LXcPJiCJPn7zu9uNFN2rYK8Jgpj8Bc2ZR16/U/K0AYnqL9FGOfvkrXsMHVa+pqYS4d/Dv/gtTlU7W1184/ZnYSyJeaLJoy40XMmPMWyufgRc+WAZul7Nm+0AU9DucNPQv1vVhiXPQOTwHPcx6Sezwtod2c49D6XouLC7fJ1GIoOB1AVVvv8j5HGmbjahVNK3iK909m+2zUeO+BKaF8HRIvnPD26k5LFiQ/X3T3pB1xBfzUi64PgsrshEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cxBcgI40lLDysCoRG6yFuMHOfSHvN8kP6JE050sX/ufzGxgOHu4TgCSx3HSVwpvok+4bh+CPLVAPT4cT1uh4ZNeetTzFQqC1+ctN/5kuFkV2y7Sc1KlEMxByJi9LM7v4uEeJuMaZCLGPDAVp7RdDu5corq3ggUoro4DbEjj+j+KVQA7U4x1AXPvES5ePTZ9aSbVInBW0CtSXlK78uC8n0HVYiuFnwjh3mz5rAbdFe5JPOzP0+OXgmuOLf4kGSBp5fN3tksEH+rwcbKHo2M6E12LHAmukoJM1UTj7/+e6Ks3e4626nJ6t6XmuIM+W457WVVb5/71cHmlvXxctSP598AdO6fLvmUG5gK29dyi4JuDw0MhILDqUj0wGeJlvXmYrD8JEtT58L/DL+/HAbupmhuuZw6yVfmhZplBnjR0K/M5IMMzWv9D6lXlOoiudp4lC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:45:52.6216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 500a7eab-5c68-423f-6186-08ded03aaae6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814
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

retire legacy RAS reset/query operations for jpeg v4.0.3

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 88 ------------------------
 1 file changed, 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 8438e13d96a4..9993aee8b63a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1313,92 +1313,6 @@ const struct amdgpu_ip_block_version jpeg_v4_0_3_ip_block = {
 	.funcs = &jpeg_v4_0_3_ip_funcs,
 };
 
-static const struct amdgpu_ras_err_status_reg_entry jpeg_v4_0_3_ue_reg_list[] = {
-	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG0S, regVCN_UE_ERR_STATUS_HI_JPEG0S),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG0S"},
-	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG0D, regVCN_UE_ERR_STATUS_HI_JPEG0D),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG0D"},
-	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG1S, regVCN_UE_ERR_STATUS_HI_JPEG1S),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG1S"},
-	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG1D, regVCN_UE_ERR_STATUS_HI_JPEG1D),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG1D"},
-	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG2S, regVCN_UE_ERR_STATUS_HI_JPEG2S),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG2S"},
-	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG2D, regVCN_UE_ERR_STATUS_HI_JPEG2D),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG2D"},
-	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG3S, regVCN_UE_ERR_STATUS_HI_JPEG3S),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG3S"},
-	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG3D, regVCN_UE_ERR_STATUS_HI_JPEG3D),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG3D"},
-	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG4S, regVCN_UE_ERR_STATUS_HI_JPEG4S),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG4S"},
-	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG4D, regVCN_UE_ERR_STATUS_HI_JPEG4D),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG4D"},
-	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG5S, regVCN_UE_ERR_STATUS_HI_JPEG5S),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG5S"},
-	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG5D, regVCN_UE_ERR_STATUS_HI_JPEG5D),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG5D"},
-	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG6S, regVCN_UE_ERR_STATUS_HI_JPEG6S),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG6S"},
-	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG6D, regVCN_UE_ERR_STATUS_HI_JPEG6D),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG6D"},
-	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG7S, regVCN_UE_ERR_STATUS_HI_JPEG7S),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG7S"},
-	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG7D, regVCN_UE_ERR_STATUS_HI_JPEG7D),
-	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG7D"},
-};
-
-static void jpeg_v4_0_3_inst_query_ras_error_count(struct amdgpu_device *adev,
-						   uint32_t jpeg_inst,
-						   void *ras_err_status)
-{
-	struct ras_err_data *err_data = (struct ras_err_data *)ras_err_status;
-
-	/* jpeg v4_0_3 only support uncorrectable errors */
-	amdgpu_ras_inst_query_ras_error_count(adev,
-			jpeg_v4_0_3_ue_reg_list,
-			ARRAY_SIZE(jpeg_v4_0_3_ue_reg_list),
-			NULL, 0, GET_INST(VCN, jpeg_inst),
-			AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
-			&err_data->ue_count);
-}
-
-static void jpeg_v4_0_3_query_ras_error_count(struct amdgpu_device *adev,
-					      void *ras_err_status)
-{
-	uint32_t i;
-
-	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG)) {
-		dev_warn(adev->dev, "JPEG RAS is not supported\n");
-		return;
-	}
-
-	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++)
-		jpeg_v4_0_3_inst_query_ras_error_count(adev, i, ras_err_status);
-}
-
-static void jpeg_v4_0_3_inst_reset_ras_error_count(struct amdgpu_device *adev,
-						   uint32_t jpeg_inst)
-{
-	amdgpu_ras_inst_reset_ras_error_count(adev,
-			jpeg_v4_0_3_ue_reg_list,
-			ARRAY_SIZE(jpeg_v4_0_3_ue_reg_list),
-			GET_INST(VCN, jpeg_inst));
-}
-
-static void jpeg_v4_0_3_reset_ras_error_count(struct amdgpu_device *adev)
-{
-	uint32_t i;
-
-	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG)) {
-		dev_warn(adev->dev, "JPEG RAS is not supported\n");
-		return;
-	}
-
-	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++)
-		jpeg_v4_0_3_inst_reset_ras_error_count(adev, i);
-}
-
 static uint32_t jpeg_v4_0_3_query_poison_by_instance(struct amdgpu_device *adev,
 		uint32_t instance, uint32_t sub_block)
 {
@@ -1437,8 +1351,6 @@ static bool jpeg_v4_0_3_query_ras_poison_status(struct amdgpu_device *adev)
 }
 
 static const struct amdgpu_ras_block_hw_ops jpeg_v4_0_3_ras_hw_ops = {
-	.query_ras_error_count = jpeg_v4_0_3_query_ras_error_count,
-	.reset_ras_error_count = jpeg_v4_0_3_reset_ras_error_count,
 	.query_poison_status = jpeg_v4_0_3_query_ras_poison_status,
 };
 
-- 
2.34.1

