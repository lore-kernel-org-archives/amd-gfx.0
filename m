Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6164CCDB46F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 09:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D202E10EA33;
	Tue, 23 Jun 2026 09:19:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uvYUa8Q6";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9CAA10EA33
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 09:19:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGrnk0jAct2AScfe3TiY1x/XPYUX+3mX4VuveBh4RUC04yfOrVFZvIh/fIfTSj6uDUO9uNqAbLVvV0Bs4G4SgEJR4/kn/jcq/iRNvqjDqGyp0O2LZ6oUYFGTiy3Fxl/Ijz3x1DxH9X44ur5vI6kG05G16XeE69t8stCnR88G2ZD+TdAi6Rs5PyKO8ccsLOiD1K1Xh00XD/4wuX1sQsdxvUmZxNkdanotHn+Fek0WDy1aFGg9xvMed8jjgLXLshPeJMNA5zZMh1Ebg/1Zp74aD4bWrtc9uWd5t40jCA23zPUqQexJXTliEMdafzpcphiPaJAIIsrHZplV1lRnvom4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMvmJqT1rHtE6Ow5yMrfP4DZHYkRtQ6aAA17/2LZwwA=;
 b=HNNtnupF7OZCzYLkyAps1eWB8mSULEcId47bBCm15JNw3nRDHP0X7BrveWaK17CkVmpKUye1dbzMw44mGK+hjLexcNjRJil/5+QaBv6DSyivF/FAFeNk/f8oOZAIHMLuTrAfk2W1LdHpXcN3BwzzX+FUB0YJrGBatQbwRA2XIHFdMeyYCjE2JTng/zH5ABmDwX1v/xvTxQzqfTrp6tFr9c1g7qg2+BnN3JR8+0FXrJ67q/hg0zoItNEMwSAyc/2WlziP2dm42jxfKqw8zt/6+GATy4zjbSF+8JZ5P60l7LcBaF8Wv6CuUXt8iFxgn7/kz9JXth+9O0YAGiav3HGs3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMvmJqT1rHtE6Ow5yMrfP4DZHYkRtQ6aAA17/2LZwwA=;
 b=uvYUa8Q6k2Fy1tZKZfb5th2wNIJ6A6qsJuIJNHlc038qDG0M3VTUEAdDQNN6A6yEGWXH77iY/fQ8lCBpG88jiLMT1M6iUbNdzCjbP9/5iR2mIl870MFOol1UR+gK/tomg4XJiM6E1b85rMY+G6MFpTFniRSO1tyr7xL+/CEObaY=
Received: from CH0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::18)
 by LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 09:18:53 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::41) by CH0P220CA0012.outlook.office365.com
 (2603:10b6:610:ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 09:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 09:18:52 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 04:18:51 -0500
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <HaiJun.Chang@amd.com>, chong li <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: improve the amdgpu device init progress in sriov
 mode
Date: Tue, 23 Jun 2026 17:18:37 +0800
Message-ID: <20260623091837.1476820-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|LV3PR12MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: e712bc59-2a4f-4dee-4d6b-08ded1087181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: u2/rqaUHBzrKfwnedgk6xW6D53Q2bUCe+V9McDsXm1ZCLan5qRxtzqff2DqmLnDwYw0BmsyxcVCKmJ6ajyaZ631bbb+ZxSmn0p6mX5St60P1uemBcdzAnRg3Te9X/u9XST5Muf3iyaSbbJ5jgzYp2zhZ0mnfsWxAnMOl7OrfuOTpJCWHGLT14ysWiCr54pp1ce4Niq2aiUSYKaQgPdHZY9fePaCiJFzLUs1/g3MUEbbH5hSFsBeggdBa4Cwyc/kyi2yMv4+EQb7phWrmrRzmq4NSJdiSSbH3T/bJ5ScsZ/8uuHhvfItyn3CjKIKCVjZuMjQ6HuxegvJFzXNvbcejJ/4u8Ikl7JC3EOn3AVw+iPPCE9m+osOvOaEKXTve0rRko/nH/VXjUEPINXChP6I1wWzijPGyUweeU2KahE8siHU5CAE/nfrPPy8+I5xRRqA9d6zJLuLLS6SpS5fvtgTWRvPgKdBrF8FR+C+Em4jTvZ3PL2bRgjcrGMyXueT/EtUyGWy2bJ/lwfSoaRTSv5dxL5LvLcthvCdL4ndz9Gt5LE+Bs84BandAKWHKQOV1Hj1Ksc6eswZiVLpgQ4eB/LM80vccPcW/K4evL1rD6Z9D/Do1F9ZVz5uGhjRBgbNWuGDhyhnvwBapg+uCjY8jdKlzjNag8aqbjmvNJ1Wxhy3zJVsTnvp+mhaEiND8qIoQT/04
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MS2QFrjxd//XcgXx4WbkZzAecCGQ7PX71SnU25qE1ClgFF42RVMrB+FIxlnsGo4r9pn5NBtJR2S675JOyRq8qP1yYuSF8DdgESEWtmzjDmlbnl2fdoeJLQjLGhYnwTSHih+oy3nUF7YFkhFpDcsP8qRI2DXaUP7mHqAawG0JqhA8VScM2FCeAX44M+LNDo+lkORRCKUDMqwNgui0ijLFMHwtl6SpKHcipnjprU6271XQXpy8bD9bn/LAbBQ2YodSiLzaS4bcftkLtKS4C28qRj41xZWi++yDzZ2WVxtOyGpHak9WEM5XisGiN2aAkDubKygt9U5GU8WlSk/CKzyoBB22ic9MzomhH/oh+fOs62i1zfN3jrYux0uV7v2wHcd56hXTgby67HJjGmnohkLmGTJOyOOzoJkOjmTCAN6za0qcm1DzxuuKHowHGsLK8SYI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:18:52.7040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e712bc59-2a4f-4dee-4d6b-08ded1087181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259
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

Move the initialization of non-GPU resources out of
the full GPU access region during AMDGPU device initialization

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 82 ++++++++++++++++------
 1 file changed, 59 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5442a1fc1c37..63d81936bd7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1932,6 +1932,51 @@ static struct pci_dev *amdgpu_device_find_parent(struct amdgpu_device *adev)
 	return parent;
 }
 
+static bool amdgpu_device_early_init_ip_block(struct amdgpu_device *adev, int i)
+{
+	struct amdgpu_ip_block *ip_block = &adev->ip_blocks[i];
+	int r;
+
+	if ((amdgpu_ip_block_mask & (1 << i)) == 0) {
+		dev_warn(adev->dev, "disabled ip block: %d <%s>\n", i,
+			adev->ip_blocks[i].version->funcs->name);
+		adev->ip_blocks[i].status.valid = false;
+	} else if (ip_block->version->funcs->early_init) {
+		r = ip_block->version->funcs->early_init(ip_block);
+		if (r == -ENOENT) {
+			adev->ip_blocks[i].status.valid = false;
+		} else if (r) {
+			dev_err(adev->dev,
+				"early_init of IP block <%s> failed %d\n",
+				adev->ip_blocks[i].version->funcs->name,
+				r);
+			return false;
+		} else {
+			adev->ip_blocks[i].status.valid = true;
+		}
+	} else {
+		adev->ip_blocks[i].status.valid = true;
+	}
+
+	return true;
+}
+
+static bool amdgpu_init_non_gpu_resources(struct amdgpu_device *adev)
+{
+	int i;
+	bool total = true;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
+			continue;
+		}
+
+		if (!amdgpu_device_early_init_ip_block(adev, i))
+			total = false;
+	}
+	return total;
+}
+
 /**
  * amdgpu_device_ip_early_init - run early init for hardware IPs
  *
@@ -2051,32 +2096,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 			amdgpu_ip_version((adev), GC_HWIP, 0) == IP_VERSION(9, 4, 4);
 	}
 
-	total = true;
 	for (i = 0; i < adev->num_ip_blocks; i++) {
-		ip_block = &adev->ip_blocks[i];
-
-		if ((amdgpu_ip_block_mask & (1 << i)) == 0) {
-			dev_warn(adev->dev, "disabled ip block: %d <%s>\n", i,
-				 adev->ip_blocks[i].version->funcs->name);
-			adev->ip_blocks[i].status.valid = false;
-		} else if (ip_block->version->funcs->early_init) {
-			r = ip_block->version->funcs->early_init(ip_block);
-			if (r == -ENOENT) {
-				adev->ip_blocks[i].status.valid = false;
-			} else if (r) {
-				dev_err(adev->dev,
-					"early_init of IP block <%s> failed %d\n",
-					adev->ip_blocks[i].version->funcs->name,
-					r);
-				total = false;
-			} else {
-				adev->ip_blocks[i].status.valid = true;
-			}
-		} else {
-			adev->ip_blocks[i].status.valid = true;
-		}
 		/* get the vbios after the asic_funcs are set up */
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
+			total = amdgpu_device_early_init_ip_block(adev, i);
 			r = amdgpu_device_parse_gpu_info_fw(adev);
 			if (r)
 				return r;
@@ -2115,6 +2138,19 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 
 		}
 	}
+
+	if (amdgpu_sriov_vf(adev)) {
+		amdgpu_virt_release_full_gpu(adev, true);
+	}
+
+	total = total & amdgpu_init_non_gpu_resources(adev);
+
+	if (amdgpu_sriov_vf(adev)) {
+		r = amdgpu_virt_request_full_gpu(adev, true);
+		if (r)
+			return r;
+	}
+
 	if (!total)
 		return -ENODEV;
 
-- 
2.48.1

