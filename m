Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016CECDB476
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8584B10E473;
	Mon, 22 Jun 2026 04:42:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="puqxFYZU";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5882B10E477
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSD073kBG8hle6f3q9hZB6LQCjQSN7OWH9oqjCln+GxPCEl3YWYEywQB4IIdzVHHyPBhAbTR3cChYnPrR1tdlFFINtTg/M5j3EC7LDoIrexrbBlAWeayGUsTTgj8M/l1Ag001WUlcUJ5npGaJlc2cF6d8hRh2CmInW2ITi/0rB8eDg7ZwGGf/2W0mor5YEVQYUgets17wRb3EK6w05Tt7wMxfctgfNu9cPXBgIM1axFUrFcg8C4zB086TeCFD4TTtMwzjVF49fa7sQfnqhES6l2kYDYqmoLEy/6/6wWGzILqn9G2IaD/TMFNyfbDeM7WcEhIoiQthoq/deU3M4/S2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6H5VrX0uG4PsWfRCNB8VBW8ujW0nmiTJCrL7pO4QPRQ=;
 b=PdnL5yVZICeW+STQwkfl/PbhC/jdPl3UDOjGZVMywId4eR7ZM7o0xG3Q5XYd0ePW9+INsj6ScyDTyHYrBbwxX94fxxYYHqyp66dbmUDJm5cMLF1GKcaP72++G5V9YdUmLdrgGEylj5uQ1pLCg37glOYkuKRzt1c9xkLsscP0h5kshCkzszocReEyj3XqC1WIURPEjy+IiB5/GA84BpiWKKPoYWi++jau3DfchhaPkjydjLDh6mb1n5GG79/E2dqZyXPrBsNXlYrHqS/9ZfrBqqNg2kUU/r2RizTyORVYV0WsDP3QK8e1RxDTNrXc0liKr+vVRdSo8AqWtVDaTSWZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6H5VrX0uG4PsWfRCNB8VBW8ujW0nmiTJCrL7pO4QPRQ=;
 b=puqxFYZUpnwiyOIWUAeNxoKQsEWcZKLTiXZkKJerPby52dGOQikFHfUUQi0pkHHHJbgD+9hGc7SoPtjaC08usdcPVYfjMu+ppwCq1J6d+0cxYwJZAr0Qn3jKw6DKqsaRyZmr0YS0f2xQFNcRhx07q9eTbTCUZKswYHzrbIvqs6Y=
Received: from MN2PR06CA0016.namprd06.prod.outlook.com (2603:10b6:208:23d::21)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 04:42:44 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::7f) by MN2PR06CA0016.outlook.office365.com
 (2603:10b6:208:23d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 04:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:44 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:42 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 22/48] drm/amdgpu: retire legacy RAS reset/query operations
 for jpeg v4.0.3
Date: Mon, 22 Jun 2026 12:40:11 +0800
Message-ID: <248eeeebc44a7d1920fadb46386ef8327f6b54c4.1782103074.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b1b5c1-fa2b-4961-1a32-08ded018b36d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: zhk/mip9tBNsSg5Z1BHSBO0VVgg4xYFOAAwwt56aGg+ehdHYbrvTGisUDLGBIBJUB6cJpKwbjkWI2RxL6m4DIUZiOedQtP1VsV6paUvCuC8TPlxxbhaNa1GRbA1fBW7UWXbNveev2dOuHiQsCtw0iXt6gGmu3KvOP8ZZM7JvhVf+OzVCjYGmYvOSb835D7xym5i1Q26Ii++Cyrf69k4JlUHoyEu8c3bLzmiT1LXZxa/mhbId98e77pq5Qz2HRBUoTLguVU/p5e1tJ7a8aJMSBnZAejHA8OzjXvQoo1w/hSiKVHG1Nn/VzXhva0B1smpwionkBnJPM2UKDfMxb49YxRASDKIATUT58RE3U6Vl0ADmBk6O3D2+3E0B3sZ70HGEJ2Jx1p0/wI4UH98M79x5uTCXhZrCtz1o3qIVHO51mjPMfPKKMo15uwfs/Czr1tE7AUXJiPS9J1eTcCSxCMvNFYP13T2gXZ/WgbmjDM6gMQUfqX8iJGRpHNRGBq3dPGdpvJpmcfSHjdNeaNuuszyqCHW/kNBPKxuDiGTiNnFAbW4goPoL5dMtqUubK05G0Gtt77syq8Ug/CT2SDIJjT6PjJzgjS0vVqk29Sb1b54c6rATv17wfg4UNHSgsbY8N8d8QrnhijgTBKtMRReS754f67WLQ+FlvB1oIgDGdDdRAdHpssmsnFmsdCtagPNfvDls88Bt0/3SFV4NNuE70YE43w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UkW/HxJye5Ddf1mKVfX64tV6Vrxp7KtNLNI3QglABKrI/PvDDenMyna6GvUh3RB43yQuqkrC5s50mpDQPXoKa/pRUNyMKe+1aCfrPLiXut8DVBEwt5xQ8PLb7qIojrYWXsF/3VitgWrOu9gCS+rmm220/nge44OPdEWeHMqRjjHRVIyFwxB6SDhXERp0teq3y/oMaQuZxyVW54AuI7PRQtJVEz6vsxXbnv6Lh7QzkSqHgRubAFk2AGptPdtcxnEH0Koc8QvCWAuNbFR3vjdbCmL1Qm3ayXIJH6ULw10o4YFcTghkS/9agsmePaBIIxw0JvxivVX18+TdD3JgmjUpwUx1XzjBqts1c4YKNFhMrFlr2fuPuPivIzBYo70n2q+zj0Ov2C6kHl5Rq+lEMfNp/1hO7pjTt0kFOgqtp8u1eu9cZojiZAB/FFg5E5LdCsXE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:44.0814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b1b5c1-fa2b-4961-1a32-08ded018b36d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
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

