Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51494C982EE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6AFD10EAAF;
	Mon, 21 Sep 2026 20:10:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Alo//az";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012031.outbound.protection.outlook.com
 [40.107.200.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2742B10E63D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:10:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oI0uGZv/r/juLEpu2i0qdb1IxJ3w8/ozE6ghH6NqnEebqTwq2l3Oiy5J8kuc4US9037FCAfztSZX2NTRiGkmhGkC/vFQE7ReC4tn3OLZ6aVSwif8peVfmiy/+sJ51iQX8fP/6Zc2/WINuT3NhfvSmN/B3AFNRFq0Cb4OjdMPEhszRYIsvo9E9TxcK+TmCFw+kSIABwm0GsuptitDou+qhes9Bfkxcq8toWjgQIjjzyNmQReVFoaXN9WsHjIgZyvHELONVln1e+Us5XubE6p8Cdw2R9UARgpZykmFcxA3/KKieUdG6/vNLb148Dz5bCpHxi198pUmcBghgZptpBfaRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWESd5la73uIkMdvvtVqqbFusZjtn32fgzu2zNfcyoM=;
 b=hmoBKmNYoSMDpaJzky+DRwPqKFULsXh4kXqMa83vqk6CqavGureCNe82AHEi34o2aAm5ZOw2CAVLEiqiWbaeklvMYreR78MxHNa8tIec/gemWdltCJwIcfnIpBLiptbw8dOECkFxE2SNbWQmUbrUoLFOx5hl5AttcK88oYc8AxVfrPD3Wntj+/duKKQ3IUS1P9MERpyDtKN9TYha+K6v1AbNd0M/AWWbgfHb4Vpwd7I8Y0OifkvrmWtL2nBRWIUbPcpLvIBupHrklHR3giBZYGSSSyPsqT/gaoXTscOZV/IM6Nvjpwyym/2QCWnCHadhqOSLi7o0vj+hoTaBV0E4cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWESd5la73uIkMdvvtVqqbFusZjtn32fgzu2zNfcyoM=;
 b=3Alo//azljZWU5Snorb2DpZxf0WiNFUAsdbtK4qa4KfA1Y5XpnkRyyPvyKKXBOlFovisFK6LoNhyCCe+qoAUAmpS81Spx+dHIflFZBvLrIXVL/87NYV/fnu0mu6DRg83XFAyXfEZpxRNR4aBfBo1fMzmnAOaF86Cm/DxGfXsuLA=
Received: from BN0PR07CA0023.namprd07.prod.outlook.com (2603:10b6:408:141::6)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:10:49 +0000
Received: from BN3PEPF00022BD6.namprd03.prod.outlook.com
 (2603:10b6:408:141:cafe::4a) by BN0PR07CA0023.outlook.office365.com
 (2603:10b6:408:141::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:10:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD6.mail.protection.outlook.com (10.167.248.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 20:10:49 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:10:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:10:39 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 15:10:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Frank Min <Frank.Min@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add debug info for psp ip key mgr ucode
Date: Mon, 21 Sep 2026 16:10:21 -0400
Message-ID: <20260921201026.2019083-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921201026.2019083-1-alexander.deucher@amd.com>
References: <20260921201026.2019083-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD6:EE_|DM6PR12MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6a8bb7-ac52-4916-2871-08df181c6e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6nWLw57HK/b4zJBz3fKbjPghAVBCcv0yZzOhb3bHDA455XbBS5ojs41aECZw9BjisPoXzAk9yxa3A52vf8JfRSiSXIcNgKhonszWLoHW5Gc3TIiV5WLgWft5ORbClyO7REoJOZVQdbJrfCXjaG8AkYfEIHr6NrMHAlWVqV3x0biPreYkO96rxE7iGPuuX7maS/OAGZ1eu8sW2kOKeWx4S+m8vBNM6MkdqcQpT9MCU8Z38+5oheUFsUF3oFfIvv8s+DPcvETpxmS0yAznxhp++BPfr1RV9lvXGrXzJghr2K8Wdf7NR/mKKGc62UdJmcMVre+QVEbovoGEbG6hVFXv5rn3te2vWQmGp0V4/abOiHMGHdy8iNmZA+sW491uDqq97wVkRGRc4E3fwo2N//c2AguG+0EMQJp6BKHG4XNoLXycmMYUQcIX+VD7fp2EgJlYxcEbldsX1syukR4pPw7aKNPO0iAAuLQOiGYv9vbSOrYIwlOzPKPcDi6xEgDQePb0UQFXn1KlWaBUnR66dQXsKOgRS/1t22gamniOfwVlMXakaGrvKkSaakiG5ISNLVBEwSxkppSx4o39b9esC9oODrGyX67HHU4iWolspKui3xsajfIJH7NvYvYXwv03qdvcQLyyW4eUJIdY865NdgchvahT8hkGOanaFSAyLAlF8f2qNAK/rcXmxV3RO3uptRgOdm3p3ih1midg7IpbhWMYHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a+DBlvSM76zJDY3x66ZtBtFLu1wVeOkTlQXq7pCy7NeNix5jgmzhH0kHjnYfNC+bZLTh7qrIsW0KEz4gowGnWn+tH9WGzHqo0dKupBx2Xpg7C8Fwqr45/VsogG3HAhtL69ovABmfJg+qQM3WcJp8CZr4iPibi2Nb35VSIBX11/UrM36O700FbrYFm31YLQrl2Szox0SUTg/aAsrITsg9NnHz+NES6INMd/QbOSB18IFIRyZfLWmeL+QsL8W1D0ft9bcswwZSCeyVPw4QYiDI1Oz9hZoBaykKBxu3ULUmZ2euW1Y2TCJ9bArMiZqsWB9vsxc+naalXuNpgRK18bQA0Z8SuNsqrfP8swBD8bmp2WNfptrxZZwqsfoyU2ZW+BLisPxWgshcA+WaELtqpxVWmsuke0/zexp3cFSQsgwABU2PvS7DVAbekBxFYXvUZAvI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:10:49.3434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6a8bb7-ac52-4916-2871-08df181c6e05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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

From: Frank Min <Frank.Min@amd.com>

Add debug info for psp ip key mgr ucode.

Signed-off-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 4f1c711df5bd7..c07f6d8d36bbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -500,6 +500,12 @@ void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr)
 				DRM_DEBUG("psp_ras_drv_size_bytes: %u\n",
 					  le32_to_cpu(desc->size_bytes));
 				break;
+			case PSP_FW_TYPE_PSP_IPKEYMGR_DRV:
+				DRM_DEBUG("psp_ipkeymgr_drv_version: %u\n",
+					  le32_to_cpu(desc->fw_version));
+				DRM_DEBUG("psp_ipkeymgr_drv_size_bytes: %u\n",
+					  le32_to_cpu(desc->size_bytes));
+				break;
 			default:
 				DRM_DEBUG("Unsupported PSP fw type: %d\n", desc->fw_type);
 				break;
-- 
2.55.0

