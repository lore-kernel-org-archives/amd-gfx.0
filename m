Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462DBCDB47F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC8AB10F1A5;
	Thu, 25 Jun 2026 08:21:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B9yKxCcA";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011035.outbound.protection.outlook.com
 [40.93.194.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E77E10F1A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPGy5uTXt343FEdAzvsBODV56s2nJbNG4tJ9sLbVgIJWyD+EhUlnNml9yPLJVo0fF409V5+3tOv+uxtCIDrcp7VTseeNei1fbJtZXdGCJZ/8pbk2A5hjOwivjfis6u4ajbxhJer6R2mBHmaHGsoetSzMb0oY9qTLqYAtowvuCnFv3M/+2ShzKk2yFeLjkPM10od45HNPxFpJvy+xcCSk/lAca4+ybDz13sGLcSuocRgIKbF7yxH/jKeQUhySSWlffAA37JFBKF9BMCxDMrI2JPRvu4dVmJSV1LDEx7zypCTGIY26nneGmuwcfOEo0c+wHBAI7f0d5+J7bL4uPGPVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y38DLTY51/DnTWr+JGPD+KS/J9vq4lF2kJMi7LmKRxI=;
 b=at0Gqlerj1oGiPSSyGNRek6edL3QQ9ERS6gMzhtrcrVsPDi0iPH1+zs8NBp2Aj9bIKjKOa1kk6yBSB4pq2tV+CBmu3fJ3Ah1JykcRAxMQ+nv3kdPUyZThH1jpdLhfFMvDR1T4EUbnXtpxsMWbksEJYgRJpBLSsGCjaHjd82v+zkt0Bw3l1J3iBlqPJDhJ3rbhmcxtDsJcHEiAFrecEgp8zjgSvJXOzVODIgoKJpDZEIf1SMqIimsKZgPqSZCb4rvU734g4Qt0775xtLioEuob4YzADTmZH6giUYvQQHOVJe+MwX3wgeqTzgEyv944Fenm0ykv7W/WzCsJ7Jac25EIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y38DLTY51/DnTWr+JGPD+KS/J9vq4lF2kJMi7LmKRxI=;
 b=B9yKxCcAKS9TOXKi3V9l0Yl3q7Deqxjky+6RBWJvdfu7VIiZ4VZYzR9GmALUojZK85WDPUgOFth/pnRltiySZJGBZ1B4TQ7uQwaK5aKT4JY9E1vumDBbVNr/zMJgDvBvhXmW/dyN8R561O2lpX6jatfKQWbz1D9OmC8Lr1NRdMs=
Received: from CYXPR03CA0056.namprd03.prod.outlook.com (2603:10b6:930:d1::29)
 by SN7PR12MB8790.namprd12.prod.outlook.com (2603:10b6:806:34b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 08:21:35 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::46) by CYXPR03CA0056.outlook.office365.com
 (2603:10b6:930:d1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 08:21:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:21:35 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:21:33 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 42/44] drm/amdgpu: retire legacy get_retire_flip_bits for
 UMC
Date: Thu, 25 Jun 2026 16:19:35 +0800
Message-ID: <73effa371b1e981d9bc493721c1e66ef6c1b2def.1782373702.git.cesun102@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|SN7PR12MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c04823-481a-43f6-db95-08ded292c5b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: VM+3S0ZZ9i3h4/sTy8qdds5iAzy7rfCl7msXzAKVV2Hxx4j9vFi6OV3fLlV4LGoup+S0kGJp7XUZHhQ3rDhJgoDw/yJ/qBnphRgDQkWVlkr4Hk3biO8CiK/BdFyhAAuTBtYPD/BAJlB12887xsq0Ou9P7wbAAChUk8pA7wazpsxoMg0np4/6UNqTeuvWvBbejlpTmamhxF4mm8cmh5JRF1X3Z1SgZhbLwU6S8z5EdYJc2YuWK/7p0Ke2/SQwi40a2jfOToqdX8rMURu7ajFzEDwIJXIkXaqYyZcMaEWnOxifqkVZW7vBMYEvvT8ciMtLbLRaR7D/5bc/3gYZVy5wwq/1pop/Bpbqv/V/AxuSVGN2bjXdU41bQha3GGW95ukbcWUxFx/I4u1ajSkXDdDEfy/HD6A3wbanOOh51hpSm43/fsb9+bMd5cGCxgPr0dzcPDAo0BcxAfwosrhpykS4s4bZmyIFh4kr5CytQ5/oH8jHuLqHU2G7vTPKV8pQETXf6/v4Siph9p6YgutcRoi665G18rfqaRUVCnqJmQOqazCP3CXwTKnv6q/UvkOjiDmW0r7Jo7kEaKSzE2aW9/qAeonyE2G5pSdZ+OZpUtHqhVbKM5DZaYIGlbRAjszQMJI2FxyMPWgEcFYOPN28u/2ctMEDIiAfXji2DeL7kx5sCyKJw2rvUSWGKB7F5t0r9sNPFLTxx0VAt6oCU44Rt9APrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ixpZs/zQDzf3FsFKrWCBHBSV5sQgqY+k+nUZEANvkRbpV6clnKI1ZreBXc7cq2QG9ihgVK9YcO52zAkpsPHQZGimXIBp+vF5Hkdvh1GLpqI3xaJI8Tpev1zc4J/eNgV5L/qGEU6A37zvIZB4td6QyXEODcJr5k3D/7iNNdA7IUKG5sDP297Odp9BBzSM1TR6fR9uknUzyibZ5VdgmhUXazs+GYICyYB1GyhwSGNR1WptOWthQ4nFqOGC+05iMfFWjsCSqVhWc0s4jCGUlhcOKngWAHBG8mveoBovXvi3EkKVAWfCgcsA/A1EgFFXSTmKelnZTDlwO8AaRdzGuVEBB9u3hupLk6nIAwtfmh3vY3PwuPDMfQ9GgD0v2JZXnHd/LYXwqiZeZmVOWu27mH+QXSLgdp/oJa87IMG4FRwNjTPloHp+ArAoh+1eJbULiCsi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:21:35.6272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c04823-481a-43f6-db95-08ded292c5b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8790
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

Remove the legacy get_retire_flip_bits implementation for UMC v12

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 106 -------------------------
 1 file changed, 106 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index d62712324940..d3eeaead7ca2 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -73,115 +73,9 @@ bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_umc_
 		!(umc_v12_0_is_uncorrectable_error(adev, mc_umc_status)))));
 }
 
-static void umc_v12_0_get_retire_flip_bits(struct amdgpu_device *adev)
-{
-	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
-	uint32_t vram_type = adev->gmc.vram_type;
-	struct amdgpu_umc_flip_bits *flip_bits = &(adev->umc.flip_bits);
-
-	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
-		nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
-
-	if (adev->gmc.num_umc == 16) {
-		/* default setting */
-		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_C2_BIT;
-		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C3_BIT;
-		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_C4_BIT;
-		flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R13_BIT;
-		flip_bits->flip_row_bit = 13;
-		flip_bits->bit_num = 4;
-		flip_bits->r13_in_pa = UMC_V12_0_PA_R13_BIT;
-
-		if (nps == AMDGPU_NPS2_PARTITION_MODE) {
-			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH5_BIT;
-			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C2_BIT;
-			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B1_BIT;
-			flip_bits->r13_in_pa = UMC_V12_0_PA_R12_BIT;
-		} else if (nps == AMDGPU_NPS4_PARTITION_MODE) {
-			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
-			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
-			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
-			flip_bits->r13_in_pa = UMC_V12_0_PA_R11_BIT;
-		}
-
-		switch (vram_type) {
-		case AMDGPU_VRAM_TYPE_HBM:
-			/* other nps modes are taken as nps1 */
-			if (nps == AMDGPU_NPS2_PARTITION_MODE)
-				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
-			else if (nps == AMDGPU_NPS4_PARTITION_MODE)
-				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
-
-			break;
-		case AMDGPU_VRAM_TYPE_HBM3E:
-			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
-			flip_bits->flip_row_bit = 12;
-
-			if (nps == AMDGPU_NPS2_PARTITION_MODE)
-				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
-			else if (nps == AMDGPU_NPS4_PARTITION_MODE)
-				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R10_BIT;
-
-			break;
-		default:
-			dev_warn(adev->dev,
-				"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
-			break;
-		}
-	} else if (adev->gmc.num_umc == 8) {
-		/* default setting */
-		flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH5_BIT;
-		flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_C2_BIT;
-		flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B1_BIT;
-		flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
-		flip_bits->flip_row_bit = 12;
-		flip_bits->bit_num = 4;
-		flip_bits->r13_in_pa = UMC_V12_0_PA_R12_BIT;
-
-		if (nps == AMDGPU_NPS2_PARTITION_MODE) {
-			flip_bits->flip_bits_in_pa[0] = UMC_V12_0_PA_CH4_BIT;
-			flip_bits->flip_bits_in_pa[1] = UMC_V12_0_PA_CH5_BIT;
-			flip_bits->flip_bits_in_pa[2] = UMC_V12_0_PA_B0_BIT;
-			flip_bits->r13_in_pa = UMC_V12_0_PA_R11_BIT;
-		}
-
-		switch (vram_type) {
-		case AMDGPU_VRAM_TYPE_HBM:
-			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R12_BIT;
-
-			/* other nps modes are taken as nps1 */
-			if (nps == AMDGPU_NPS2_PARTITION_MODE)
-				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
-
-			break;
-		case AMDGPU_VRAM_TYPE_HBM3E:
-			flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R11_BIT;
-			flip_bits->flip_row_bit = 12;
-
-			if (nps == AMDGPU_NPS2_PARTITION_MODE)
-				flip_bits->flip_bits_in_pa[3] = UMC_V12_0_PA_R10_BIT;
-
-			break;
-		default:
-			dev_warn(adev->dev,
-				"Unknown HBM type, set RAS retire flip bits to the value in NPS1 mode.\n");
-			break;
-		}
-	} else {
-		dev_warn(adev->dev,
-			"Unsupported UMC number(%d), failed to set RAS flip bits.\n",
-			adev->gmc.num_umc);
-
-		return;
-	}
-
-	adev->umc.retire_unit = 0x1 << flip_bits->bit_num;
-}
-
 struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ras_block = {
 		.hw_ops = NULL,
 	},
-	.get_retire_flip_bits = umc_v12_0_get_retire_flip_bits,
 };
 
-- 
2.34.1

