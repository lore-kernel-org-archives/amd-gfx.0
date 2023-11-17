Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33662C197A0
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 02:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A41B310E712;
	Fri, 17 Nov 2023 02:10:55 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A021A10E70E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 02:10:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frrOapFmiPrF5h5SHzczKGhjjoDqNAWAj36fjoMsLLYAespNv5oKvPKmItMq6Ue5OPAbw3v69RFxOXnDgP4kDFj+M+Gm0Xh+Euk4kRaDAcQCtL8KzorzPZR8CnOuKe19UlToMNpqEA69j+fz44P8bQHr04UkQ/rPLLVOqJvxV7lImcBdrSQiBs4SRygsl5N7EicOtyyWXvmHvW03IPHw7WblhfNagivUA7i7TKXa7NBCGhj8H7Z6NrCzdG6zrbW2PvHFFhFL64iDeusELrBCRWAhN5kcbljMro9R4laOt96oRm+5WvHTHkUAlXJP9BTeK8h/LqOITuvrWxHteSjxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsfagCGM2U4egmQy8yMABuYC8hL6ofThdHCxgUQExAM=;
 b=dY6Bz959NTxF2w1TOr9262LwcNPwLWrDUVrfwTza+h4HSnqMEBuMb7aZlJu556BOsRRwDPs5M7gieeWn12cMcqEsM5+xStSnBE6WtmcebYLJb6M/nI5oaEFUtwCvlJSqaP5sJ43LAXr4EY4Q2EbI2R0cUb5PRibpagg1kCbHNp6O1IxZQMZjel6o15jwscf4iL+q4gMFT5ZPqaHJuN8urvhPP2DjQ/ehJNJtdVz1r2f6JK2kKRpHxrjkr4bj/kx2TckcdRvNSxx76QiIuYuaWObJJ0+YBX/KAknDAwZ7JO+0XSaDbWeuo5DOMXIxny5b/SEfmZYhYUroCBEcRhqtzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsfagCGM2U4egmQy8yMABuYC8hL6ofThdHCxgUQExAM=;
 b=XNmCP65nPCqTpekHX2ulAAhUU6tYbFCphB5yXNwRI8ALKEav8NKDAoJ3rVBG3AjMUuI1JfoNoCATMlSm1qQMlWKi1Y9WGfk8CrecVgfHZnhjlSa6daD2riUQb8UknG9mCNOpm3LqZ2oeYOftELwvS6i+xNthKnkW0UhkartQhjY=
Received: from CY5PR19CA0034.namprd19.prod.outlook.com (2603:10b6:930:1a::13)
 by SJ0PR12MB5471.namprd12.prod.outlook.com (2603:10b6:a03:300::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 02:10:50 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:1a:cafe::c2) by CY5PR19CA0034.outlook.office365.com
 (2603:10b6:930:1a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Fri, 17 Nov 2023 02:10:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.19 via Frontend Transport; Fri, 17 Nov 2023 02:10:49 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 20:10:41 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/6] drm/amdgpu: add lsdma hw ip definition
Date: Fri, 17 Nov 2023 10:09:41 +0800
Message-ID: <20231117020946.2912865-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231117020946.2912865-1-yifan1.zhang@amd.com>
References: <20231117020946.2912865-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|SJ0PR12MB5471:EE_
X-MS-Office365-Filtering-Correlation-Id: d16c5743-9ade-4a3b-d004-08dbe7126b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzXlyBP5UN+ucWcXKrafWm+w/Qs0SzqkbARnBxVlX+4/6WU9Bjfw5hWKLsnM0ImgwV5L4v4U1qXrAhnQ4oAD2IfNfKuXCo3vO6u/k8LpH8pUhtzvU746PsuGHqgkO27FuJ6bxuXSiTYeoWxVZNnN+5z2Ni8DcgQQqCAFJXRgVGs85yiocgEBDliJLbL+YjKF9gA3xH25vO79ymi55f9QgW1sud0YAMoAQp7Eu+dOiiUbpo1GHfB12j1HhOtuHd/oI0Oi1VjWWUlfIJNml6hkd5G5hZR9PCb1uqIap4+Yrt8puAV/LozPGtpSiL9u6nuvv3SYTGcGVUoKGGrVJxombkOAoRCo9KV45egSP6bKG9n1eedhmTcO/1mxyddGZTDZpLG3qzIOGMy94oqrvcIm0RuG9fQkMcmLNjc2tdrXPJPXA4zYzGg1EweJewb4aE1Ja9t6wvTTD4kF8GyuM4sLfXGQnYr3dVJpXozExdjkJEq/WZNX/5+jKZsnX+cmc4nLB1L6aJxg1BT2gYJ2ZD+tbEw24uN4ZR16xFjznh5Jw1L/De/MZ+I8gl5H86cbzYILzAlDTN0vwOn+ZN9pMlI/xBKew9c+JrqQ4rv3jWTJciLHA/kVmzqgMcHGHhKem6Zthcxc5Iwp7eu/FgDo9Bd4FAmiys9bG/TGgXB/pj7cgHvJY69+mVHAjPDrRioVfnwHw/nPeX8upU3Uj2s/6Gf9Lon8WMotIrO21fBgx9re2sXCxjqgHwvBiDgkMGtBW1moDWe65y7Dxg7BOf9wD+TLNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(186009)(82310400011)(451199024)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(82740400003)(356005)(81166007)(5660300002)(2906002)(47076005)(40480700001)(86362001)(8676002)(4326008)(8936002)(36860700001)(41300700001)(316002)(6916009)(2616005)(40460700003)(54906003)(70206006)(70586007)(336012)(426003)(1076003)(478600001)(83380400001)(16526019)(26005)(36756003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 02:10:49.9553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d16c5743-9ade-4a3b-d004-08dbe7126b6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5471
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Lang.Yu@amd.com,
 christian.koenig@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to add lsdma hw ip definition.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 15 +++++++++++++++
 drivers/gpu/drm/amd/include/amd_shared.h   |  1 +
 include/uapi/drm/amdgpu_drm.h              |  3 ++-
 5 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b49ad7690a8c..bba9e8da2384 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3418,6 +3418,7 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
 		AMD_IP_BLOCK_TYPE_DCE,
 		AMD_IP_BLOCK_TYPE_GFX,
 		AMD_IP_BLOCK_TYPE_SDMA,
+		AMD_IP_BLOCK_TYPE_LSDMA,
 		AMD_IP_BLOCK_TYPE_MES,
 		AMD_IP_BLOCK_TYPE_UVD,
 		AMD_IP_BLOCK_TYPE_VCE,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index b3630ceaff4c..20519ca90fb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -52,6 +52,7 @@ static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
 	[AMDGPU_HW_IP_VCN_ENC]	=	"enc",
 	[AMDGPU_HW_IP_VCN_JPEG]	=	"jpeg",
 	[AMDGPU_HW_IP_VPE]	=	"vpe",
+	[AMDGPU_HW_IP_LSDMA]	=	"lsdma",
 };
 
 void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b5ebafd4a3ad..91ec481377fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -215,6 +215,9 @@ static enum amd_ip_block_type
 	case AMDGPU_HW_IP_DMA:
 		type = AMD_IP_BLOCK_TYPE_SDMA;
 		break;
+	case AMDGPU_HW_IP_LSDMA:
+		type = AMD_IP_BLOCK_TYPE_LSDMA;
+		break;
 	case AMDGPU_HW_IP_UVD:
 	case AMDGPU_HW_IP_UVD_ENC:
 		type = AMD_IP_BLOCK_TYPE_UVD;
@@ -438,6 +441,13 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
 		break;
+	case AMDGPU_HW_IP_LSDMA:
+		type = AMD_IP_BLOCK_TYPE_LSDMA;
+		if (adev->lsdma.ring.sched.ready)
+			++num_rings;
+		ib_start_alignment = 256;
+		ib_size_alignment = 4;
+		break;
 	case AMDGPU_HW_IP_UVD:
 		type = AMD_IP_BLOCK_TYPE_UVD;
 		for (i = 0; i < adev->uvd.num_uvd_inst; i++) {
@@ -546,6 +556,10 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			result->ip_discovery_version =
 				IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(adev, SDMA0_HWIP, 0));
 			break;
+		case AMD_IP_BLOCK_TYPE_LSDMA:
+			result->ip_discovery_version =
+				IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(adev, LSDMA_HWIP, 0));
+			break;
 		case AMD_IP_BLOCK_TYPE_UVD:
 		case AMD_IP_BLOCK_TYPE_VCN:
 		case AMD_IP_BLOCK_TYPE_JPEG:
@@ -679,6 +693,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		switch (type) {
 		case AMD_IP_BLOCK_TYPE_GFX:
 		case AMD_IP_BLOCK_TYPE_VCE:
+		case AMD_IP_BLOCK_TYPE_LSDMA:
 			count = 1;
 			break;
 		case AMD_IP_BLOCK_TYPE_SDMA:
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 579977f6ad52..8c03afd4d472 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -95,6 +95,7 @@ enum amd_ip_block_type {
 	AMD_IP_BLOCK_TYPE_PSP,
 	AMD_IP_BLOCK_TYPE_DCE,
 	AMD_IP_BLOCK_TYPE_GFX,
+	AMD_IP_BLOCK_TYPE_LSDMA,
 	AMD_IP_BLOCK_TYPE_SDMA,
 	AMD_IP_BLOCK_TYPE_UVD,
 	AMD_IP_BLOCK_TYPE_VCE,
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index ad21c613fec8..8edae0f56bdd 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -595,7 +595,8 @@ struct drm_amdgpu_gem_va {
 #define AMDGPU_HW_IP_VCN_ENC      7
 #define AMDGPU_HW_IP_VCN_JPEG     8
 #define AMDGPU_HW_IP_VPE          9
-#define AMDGPU_HW_IP_NUM          10
+#define AMDGPU_HW_IP_LSDMA        10
+#define AMDGPU_HW_IP_NUM          11
 
 #define AMDGPU_HW_IP_INSTANCE_MAX_COUNT 1
 
-- 
2.37.3

