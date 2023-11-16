Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA17C2BB3F
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 02:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1A1110E24D;
	Thu, 16 Nov 2023 02:47:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 900C910E242
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 02:47:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiJincKXJTXeNc3U7YNxBVAeo4elAxlcyvM5UH7TOy4xlrgaEcPo17t1+C08w7crbqSBcNdK/uU6lzLM5fiVkA/vuNep+goIX8zcjzNhIo/+yVhI5eU9j2JVzYspYBuUAtD2QabadE5SHmW2V1qIY51dYpAoygtxKtXYOStMul+NHzJlD/gWjWsCroRwRkL4eM8nB1LmisV9Gb6bUIy0WxqNjiT/4d3SoAjHhJ5sQ65Z8zZTp/WOPU8O+x4Sz4B/2ecAp6DltKqTMi40fH64pDLwoDYo2yGVoMRHtO/oY8524v5I0rO0AiVELAEALfwaHCGt3rWKNpH47yagiAPg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gb6eOy+uukS6RoNWN+t3b/dOKdHC2acnBInWs8IUlwk=;
 b=l3ezMvWbOsHKX3Uy00PYflYw/tWxV7Az5QNIBreEymL01R9kczqJ5DjCfB5XS9Zed5NvQAUUZZjEOEowILUBEvpcel7Yd8Ed+JnUmlbgCafH+TSvhPSeg2GOWExbc3LGtFo5HhdkhVE7SK6co6UG8+29JdMSNyXNOg8du6aFwPzK5vvRb5E0jHKNeNi/jYgp69AQqn8wTuns+APpmDYhXPtzDUmW6bO330R06T3it+vs4AiAwh28YueBp7XFQ8M3tY8PODcixBWsyGYWghZXXOwDFZJf5oB3NuXUyLz/31OfTU+f5xuJaNClq6dJZz1jFv981iiYGWE4CXIYKE5f7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gb6eOy+uukS6RoNWN+t3b/dOKdHC2acnBInWs8IUlwk=;
 b=ShWAUcz3VR8jiu+5e76BrtbkhVLnV7VRYsUSLS3ZNWFKF8gYnkSIxpZCBT4qmhmek978YPfgasQxzB7nsHEl/8LnTGKmc5zdqOBL6rnVoF/DqP/OM6om/K+zrLy0BpcaGLYsLe94IH8uO+VVLR2ltBaSxXRMCGLYPVoeU+fcp3U=
Received: from CY5PR14CA0008.namprd14.prod.outlook.com (2603:10b6:930:2::15)
 by CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 02:47:42 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:2:cafe::a8) by CY5PR14CA0008.outlook.office365.com
 (2603:10b6:930:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Thu, 16 Nov 2023 02:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 02:47:42 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 20:47:25 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] drm/amdgpu: add lsdma hw ip definition
Date: Thu, 16 Nov 2023 10:46:58 +0800
Message-ID: <20231116024703.2838690-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231116024703.2838690-1-yifan1.zhang@amd.com>
References: <20231116024703.2838690-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|CO6PR12MB5427:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb93c37-878c-4a9c-8bf0-08dbe64e679f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+YMD21sCrmi8pZ+VFK0Z/ttX8Cvk+3qUTc5cU5AtOHDQxuhNZhuDktwJAX9tVwj8wFhfjmzt9UXHVX7JPBhmWT6Jq+cTfeBX1iRquGNIezNS79A2Ml3U00IDCOTLcbjJfWjbOg4s7k+oRemsfeo74eKkNqrPEBTicQ1oazX/UCTk3+2me1bvEH0JGA6X0zAjDd8bu6jXpTB0HI6ypTrOxpbflSyNNX0WglO4zZMn7oXO05+DxsqUrbu1Ul4pjYEMni0mUjnXBu9v2dhDXK3g9tehDGOauOFHE58Z0l94nZgYuAQ4LZtURctPgzsNrPwhgU3Jhu80z6CV8UGSW5br8b22Mr3ox6iuwJR/+VzsFWGC2P9zBIjDtrdGzrY8RnhfRtFnwKT4cgwP4Z4n0lvjSTQ/Nrw6+TPgstqhxdb+s5MJtuv8O8eLT+XbSZj+HHK9+8zAlfjpBH+6lk3b1cIWwGoT7EJL1az2Cwxnym/K2je0SQMeL+1GOXjSe3j9hCRYEoiUDADke5iZumrDpJcs2/6sPI1tncFLZTrCbwX/x5gRAkllhKGP9W+BWagtiPnygzzENkHJZxsvqKCsgM1b2myprIR8rK6nmAxVcExJPDugtLPEIhuGdWec6CX+/s5CKsT3OIm22beJFatzwIG3Qe/tjY7HimR5Xp45x2bQbSjxDZGqXRer6nJdAX9cHVcFDHgfolhHNNMo0VC6T8vZDSMczfAAiLSWwoIXk9Fu7A4G/aDksAZErdAwJQAJBgVuP3RWBaW2c9YTfyW2+AIRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(26005)(40460700003)(1076003)(86362001)(6666004)(336012)(16526019)(8676002)(5660300002)(7696005)(47076005)(426003)(2616005)(36860700001)(83380400001)(8936002)(4326008)(2906002)(41300700001)(316002)(70206006)(70586007)(54906003)(6916009)(478600001)(36756003)(82740400003)(356005)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 02:47:42.2154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb93c37-878c-4a9c-8bf0-08dbe64e679f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
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
Cc: Tim.Huang@amd.com, Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Alexander.Deucher@amd.com, Lang.Yu@amd.com, christian.koenig@amd.com
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
index 1fc73bb4ec73..afb573b2e266 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3414,6 +3414,7 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
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

