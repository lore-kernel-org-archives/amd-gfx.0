Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E3DC47077
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 14:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 746C210E1BF;
	Tue,  2 Jan 2024 14:17:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C04510E1B9
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 14:17:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqSMA5RgvtRVoI9b8VGOzPA/80cGu/zfnEqjAeMq/JA52R9QqkA2udO5uTW0At0+pbGbrQNWakS7Q3dRZSh/BnS1bJAkru1IcRjvX/SQVmhsj/raJAj3WBGBtSzhtAVWnbcu1hkXGCMDpipBHbySOQr0wjl5zMX+L5FBMGb7BiZC6zqQcT9m4qb3TO2AHRiQJdy+tg1nUmFgk1ObvOLzhuOpibJe8NJdoqOvgTV1GVcKNmFqFkcTVYQklap7cjI15iI7incUwsTP0KSmn0qwBGYqIU1oVt5TCsDoMJyOo6RL8rsVH1370wb8Rj8NNqy29Exxq0RBnbbBTJw1UjC2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqhX3pRacFa2ufHpj+j9hePhoM2yPaWXVBCxDgB21ZI=;
 b=iBrCeGzEmBUXxy2QWVucVbfjQx6iRDxJcbMtNTAcKGphi6G3AzVcwfmrYqN0oQ01GA4k64eherNMkcQi44DCXVGL4wQnPs8/20Boxp/kU3DkVEUpdaWLOS84eTD6pqGBMKdtxgahnkSqirdjrolIVRU2tlr7ZJiAhdHgpm58N2w6aEh+SW5jCUZqsafdNiKr9TX9HqI/l07eNn+uPEjVZ0HU6PAGOAJOvbDkxHdbZ1Mezs1OlbSYsX1tX1aIObyhhzQesmo5C+rNghnE9/E5Yw7zPEC1gW4r3M0IbJLP+HtJn2xQ5fbVWGpAcIUpxKW27aDDepKJcdNYh1mL9qQIOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqhX3pRacFa2ufHpj+j9hePhoM2yPaWXVBCxDgB21ZI=;
 b=Cj9j0rXrM+dW0gif+7PCoz6+ArIS/fTIuHP4XgYtmmtppOI3+ghjwNmK0VBdLy0GRA6lsFqM1k8dtA0iOYpqpAeHH15SV31FTohwXKIn4emkUghdF6N1WhAKzshweLX0YIYeo8Gz4yDsXN6o5W4XNkblYbMvUhAnoLE2jXOLmyw=
Received: from CY5PR15CA0005.namprd15.prod.outlook.com (2603:10b6:930:14::18)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 14:16:58 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:14:cafe::22) by CY5PR15CA0005.outlook.office365.com
 (2603:10b6:930:14::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 14:16:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 14:16:58 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 08:16:57 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 2 Jan
 2024 06:16:37 -0800
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Tue, 2 Jan 2024 08:16:34 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Centralize ras cap query to
 amdgpu_ras_check_supported
Date: Tue, 2 Jan 2024 22:16:18 +0800
Message-ID: <20240102141621.29700-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240102141621.29700-1-Hawking.Zhang@amd.com>
References: <20240102141621.29700-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b12ff90-5a9f-4a59-ec65-08dc0b9d7b06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5uWYFyMGrRlW7vehOMUBcLn6iqzhUJCUyy8HLnKueYvnHRLZegQIeQVY/vdYR2DKJl2GJXHvDmrzOmtbBK6UD9AdF5tIPwQvgolAtsmnnWj+V6Sgc6HPONFp61VqgfmJx/4wKW5yrkaJrgswlaU2+g/aYbPe01RXmNVlpiv8jrK1scE3HpwAa7xKIzzt7M4XpDqkXv86u3QG7y56+zyqr3179DaDCi7PKmsTOAgybaagYDROt7zZ5euZg7JudG2cD0qmI8eW3DmnqeT648MgMru7HwMAOKDxN/UCUDMShJIxyryOHQYa+j1VqM7ldN+7cUsYkxPnKjLb4YbttdokRJDdLJVT06GQGuVClXIjDcVaXLZ+GiYm2csv+A21YyUHxVWl29ZEP39+IJp+C3mhYnYTTKXJR+KQdsULtco5uUfSL3YoAM2C/Qp6odHTvW2JHGLgNUiR9vZLYDOEuM3D+2Tyo20+NlMhFRgPg29pw640g3tE37RohA3pOFTDkXDnpvYhQUqj/xrDUG3SvbeheUOvYq1Kprrd1nDMGIiavqKRZOVLU8qK53SFiinY/YEpNHgREMxz1x+Ut5fyXYX0L+5Rflm8DK0obf6EWfD9KSg3zljLdvUyX8OUlOlD54pR3g1DZk52n7Mi/7WRxcYnyB7jdjEUW5dPyqtVlnnFT3e0t6oWhffen+4kfo49SaY1EQcDRtVZMUaQYVlFspZQHTopubNtGQqXqAROmyhbIBs+0tM7BpPd2YGp/6bJeK+bdod+d2KpuhjfEbpkd9xpFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(36860700001)(478600001)(40460700003)(41300700001)(82740400003)(6636002)(356005)(36756003)(4326008)(81166007)(54906003)(316002)(110136005)(70586007)(70206006)(86362001)(6666004)(47076005)(7696005)(426003)(26005)(336012)(1076003)(40480700001)(83380400001)(8936002)(8676002)(2616005)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 14:16:58.0652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b12ff90-5a9f-4a59-ec65-08dc0b9d7b06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move ras capablity check to amdgpu_ras_check_supported.
Driver will query ras capablity through psp interace, or
vbios interface, or specific ip callbacks.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 170 +++++++++++++-----------
 1 file changed, 93 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a901b00d4949..2ee82baaf7d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -39,6 +39,7 @@
 #include "nbio_v7_9.h"
 #include "atom.h"
 #include "amdgpu_reset.h"
+#include "amdgpu_psp.h"
 
 #ifdef CONFIG_X86_MCE_AMD
 #include <asm/mce.h>
@@ -2680,6 +2681,87 @@ static void amdgpu_ras_get_quirks(struct amdgpu_device *adev)
 		adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__GFX);
 }
 
+/* Query ras capablity via atomfirmware interface */
+static void amdgpu_ras_query_ras_capablity_from_vbios(struct amdgpu_device *adev)
+{
+	/* mem_ecc cap */
+	if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
+		dev_info(adev->dev, "MEM ECC is active.\n");
+		adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__UMC |
+					 1 << AMDGPU_RAS_BLOCK__DF);
+	} else {
+		dev_info(adev->dev, "MEM ECC is not presented.\n");
+	}
+
+	/* sram_ecc cap */
+	if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
+		dev_info(adev->dev, "SRAM ECC is active.\n");
+		if (!amdgpu_sriov_vf(adev))
+			adev->ras_hw_enabled |= ~(1 << AMDGPU_RAS_BLOCK__UMC |
+						  1 << AMDGPU_RAS_BLOCK__DF);
+		else
+			adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__PCIE_BIF |
+						 1 << AMDGPU_RAS_BLOCK__SDMA |
+						 1 << AMDGPU_RAS_BLOCK__GFX);
+
+		/*
+		 * VCN/JPEG RAS can be supported on both bare metal and
+		 * SRIOV environment
+		 */
+		if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(2, 6, 0) ||
+		    amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 0) ||
+		    amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 3))
+			adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__VCN |
+						 1 << AMDGPU_RAS_BLOCK__JPEG);
+		else
+			adev->ras_hw_enabled &= ~(1 << AMDGPU_RAS_BLOCK__VCN |
+						  1 << AMDGPU_RAS_BLOCK__JPEG);
+
+		/*
+		 * XGMI RAS is not supported if xgmi num physical nodes
+		 * is zero
+		 */
+		if (!adev->gmc.xgmi.num_physical_nodes)
+			adev->ras_hw_enabled &= ~(1 << AMDGPU_RAS_BLOCK__XGMI_WAFL);
+	} else {
+		dev_info(adev->dev, "SRAM ECC is not presented.\n");
+	}
+}
+
+/* Query poison mode from umc/df IP callbacks */
+static void amdgpu_ras_query_poison_mode(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	bool df_poison, umc_poison;
+
+	/* poison setting is useless on SRIOV guest */
+	if (amdgpu_sriov_vf(adev) || !con)
+		return;
+
+	/* Init poison supported flag, the default value is false */
+	if (adev->gmc.xgmi.connected_to_cpu ||
+	    adev->gmc.is_app_apu) {
+		/* enabled by default when GPU is connected to CPU */
+		con->poison_supported = true;
+	} else if (adev->df.funcs &&
+	    adev->df.funcs->query_ras_poison_mode &&
+	    adev->umc.ras &&
+	    adev->umc.ras->query_ras_poison_mode) {
+		df_poison =
+			adev->df.funcs->query_ras_poison_mode(adev);
+		umc_poison =
+			adev->umc.ras->query_ras_poison_mode(adev);
+
+		/* Only poison is set in both DF and UMC, we can support it */
+		if (df_poison && umc_poison)
+			con->poison_supported = true;
+		else if (df_poison != umc_poison)
+			dev_warn(adev->dev,
+				"Poison setting is inconsistent in DF/UMC(%d:%d)!\n",
+				df_poison, umc_poison);
+	}
+}
+
 /*
  * check hardware's ras ability which will be saved in hw_supported.
  * if hardware does not support ras, we can skip some ras initializtion and
@@ -2696,49 +2778,13 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 	if (!amdgpu_ras_asic_supported(adev))
 		return;
 
-	if (!adev->gmc.xgmi.connected_to_cpu &&	!adev->gmc.is_app_apu) {
-		if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
-			dev_info(adev->dev, "MEM ECC is active.\n");
-			adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__UMC |
-						   1 << AMDGPU_RAS_BLOCK__DF);
-		} else {
-			dev_info(adev->dev, "MEM ECC is not presented.\n");
-		}
-
-		if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
-			dev_info(adev->dev, "SRAM ECC is active.\n");
-			if (!amdgpu_sriov_vf(adev))
-				adev->ras_hw_enabled |= ~(1 << AMDGPU_RAS_BLOCK__UMC |
-							    1 << AMDGPU_RAS_BLOCK__DF);
-			else
-				adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__PCIE_BIF |
-								1 << AMDGPU_RAS_BLOCK__SDMA |
-								1 << AMDGPU_RAS_BLOCK__GFX);
-
-			/* VCN/JPEG RAS can be supported on both bare metal and
-			 * SRIOV environment
-			 */
-			if (amdgpu_ip_version(adev, VCN_HWIP, 0) ==
-				    IP_VERSION(2, 6, 0) ||
-			    amdgpu_ip_version(adev, VCN_HWIP, 0) ==
-				    IP_VERSION(4, 0, 0) ||
-			    amdgpu_ip_version(adev, VCN_HWIP, 0) ==
-				    IP_VERSION(4, 0, 3))
-				adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__VCN |
-							1 << AMDGPU_RAS_BLOCK__JPEG);
-			else
-				adev->ras_hw_enabled &= ~(1 << AMDGPU_RAS_BLOCK__VCN |
-							1 << AMDGPU_RAS_BLOCK__JPEG);
+	/* query ras capability from psp */
+	if (amdgpu_psp_get_ras_capability(&adev->psp))
+		goto init_ras_enabled_flag;
 
-			/*
-			 * XGMI RAS is not supported if xgmi num physical nodes
-			 * is zero
-			 */
-			if (!adev->gmc.xgmi.num_physical_nodes)
-				adev->ras_hw_enabled &= ~(1 << AMDGPU_RAS_BLOCK__XGMI_WAFL);
-		} else {
-			dev_info(adev->dev, "SRAM ECC is not presented.\n");
-		}
+	/* query ras capablity from bios */
+	if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
+		amdgpu_ras_query_ras_capablity_from_vbios(adev);
 	} else {
 		/* driver only manages a few IP blocks RAS feature
 		 * when GPU is connected cpu through XGMI */
@@ -2747,8 +2793,13 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 					   1 << AMDGPU_RAS_BLOCK__MMHUB);
 	}
 
+	/* apply asic specific settings (vega20 only for now) */
 	amdgpu_ras_get_quirks(adev);
 
+	/* query poison mode from umc/df ip callback */
+	amdgpu_ras_query_poison_mode(adev);
+
+init_ras_enabled_flag:
 	/* hw_supported needs to be aligned with RAS block mask. */
 	adev->ras_hw_enabled &= AMDGPU_RAS_BLOCK_MASK;
 
@@ -2781,39 +2832,6 @@ static void amdgpu_ras_counte_dw(struct work_struct *work)
 	pm_runtime_put_autosuspend(dev->dev);
 }
 
-static void amdgpu_ras_query_poison_mode(struct amdgpu_device *adev)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	bool df_poison, umc_poison;
-
-	/* poison setting is useless on SRIOV guest */
-	if (amdgpu_sriov_vf(adev) || !con)
-		return;
-
-	/* Init poison supported flag, the default value is false */
-	if (adev->gmc.xgmi.connected_to_cpu ||
-	    adev->gmc.is_app_apu) {
-		/* enabled by default when GPU is connected to CPU */
-		con->poison_supported = true;
-	} else if (adev->df.funcs &&
-	    adev->df.funcs->query_ras_poison_mode &&
-	    adev->umc.ras &&
-	    adev->umc.ras->query_ras_poison_mode) {
-		df_poison =
-			adev->df.funcs->query_ras_poison_mode(adev);
-		umc_poison =
-			adev->umc.ras->query_ras_poison_mode(adev);
-
-		/* Only poison is set in both DF and UMC, we can support it */
-		if (df_poison && umc_poison)
-			con->poison_supported = true;
-		else if (df_poison != umc_poison)
-			dev_warn(adev->dev,
-				"Poison setting is inconsistent in DF/UMC(%d:%d)!\n",
-				df_poison, umc_poison);
-	}
-}
-
 static int amdgpu_get_ras_schema(struct amdgpu_device *adev)
 {
 	return  amdgpu_ras_is_poison_mode_supported(adev) ? AMDGPU_RAS_ERROR__POISON : 0 |
@@ -2918,8 +2936,6 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			goto release_con;
 	}
 
-	amdgpu_ras_query_poison_mode(adev);
-
 	/* Get RAS schema for particular SOC */
 	con->schema = amdgpu_get_ras_schema(adev);
 
-- 
2.17.1

