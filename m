Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713A0C5ACB3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Nov 2023 07:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E80510E24D;
	Tue, 21 Nov 2023 07:32:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E07B710E24D
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 07:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVh2bmXtpyvXfdRni6geBZKU9Pp22qoK7Uuf2wv5j41SADZuLbdQy5zuukXWvC+azFRX7NTMlvkm6y6aeuLZE2t5RETyCHB+2gkhgBaxIzjq4rjstA00V1M4kGZcaPKJE3o3110o86lBh8KN8XCA0mJwv81zYUY7sPVdo56qmlWyn38K8fu+GZ3DdncRd7I8cRtwaCmPwu6f/ccmDa6Ygd5zwADsfrntCp97RJDGrILzPhQWBC4boaqB8vuEGjkVr/3UU5LjXTdvet4inwiII02ELIl2/W4Nu//VRJyoujNfY1jVW7FDFc6wJ5/GUG2tiWkmb8i/iv/WKyibq5Jqow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2xFUqLYrayibtUwYcFMyI+M4KuXceXcDs/DDCYTpXs=;
 b=cxh6BbizpAS5gji61R93hDqu8D1pQ72+4R71ZsifQNt5GZDp0cAN9o82dcL0ifz+qm01gao5vOy/kS04+XOl05tLZ+B3iq20E8mYxsEcwBJhkVcamwtKi+Sy1AKXEDZZouLqpnSvHQLhdTswPXPl7s3MueQhJMwq8zqcTiXuk5vmIzLyYhYPMntibqW9tWCROUiE+0eGTuaUVI8oU4JEoe79u1UBeF4o+i3rH6CIrwInv+ulTyAnihWQrtf2K504LarBrWgibS8CAhcKlrASQ29QHRg1DG57Oa37sEqpxnpLmyMJDjgwD4hAFzYOr1473ktSAswE2yb8XG3LFjUY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2xFUqLYrayibtUwYcFMyI+M4KuXceXcDs/DDCYTpXs=;
 b=El4kV3kcm/QB7tl2qZiJ6Vn0DL+GFgneM4DVGCkkjDTpfpJ+EcTYhzcwWRn8bhw4ulIZWgMVb9AnNwijDfM/jHtMnIiB92DSZIYuRgQMDdoNha9qs11rcKbgZmJFM4G4IsnL70ULjiHFeyNvtJFMPc+YxN/H2Eax9nMk1liA2I0=
Received: from MN2PR22CA0019.namprd22.prod.outlook.com (2603:10b6:208:238::24)
 by MW4PR12MB6999.namprd12.prod.outlook.com (2603:10b6:303:20a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 07:32:07 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::87) by MN2PR22CA0019.outlook.office365.com
 (2603:10b6:208:238::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Tue, 21 Nov 2023 07:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 07:32:06 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 01:32:02 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/6] drm/amdgpu: add lsdma hw ip definition
Date: Tue, 21 Nov 2023 15:30:09 +0800
Message-ID: <20231121073014.2984557-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231121073014.2984557-1-yifan1.zhang@amd.com>
References: <20231121073014.2984557-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|MW4PR12MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 308a6361-394b-4e43-6fa7-08dbea63f6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elLG97agLOZ8EApPZqleHYTapfBdCbnRNUjh7bxNvqncMVjXRw9yOv3k3bzaKkxItKripQkbiTHa+lYAejYvkAVQgX5CF9Mk628Dicf2YGo49/zsn8GJFPWkmMJ50LMmSZ7SoHSXbWImMUxRn8dtkua8yM/NzfMtJ4GR/JVizcruQ+RchnT7HnwbkB1LDSykCzewn/6puYMp1BPZxTKMLm/DWGqaBLmtmYFBeLnXeRnsEE7wTZzU42pde9tLMtOoC57Q+xa/kiIPSkJmnAYk/bvblJ6fCKBNsEkfzwkmP/vURjlLhdTjfW52dwPznj/5zB7oEJw4/Gliww6CotaVU3hkpKWCR9pX2lxaQawayWiTJbt9UlTRiZ99nfep3Hx2SMcWhQ4SA9ZY5P/pPU+DK2IAJ1hevnddGXBQV4DbXCYwM63mqAzQnxQhUmRrtExB5UILXCtSVLbTDSyfoq5fpst/aaeIxOjUaqXq0UQJxpeW6OI8PKP+qIUfr3WIqRbDYVWs16ugLytbj2Fn6f/3pz1btD+Dbk0FAW0mva5hjCukNo9+AdY8ms8GyH9GPcrxg1tQ1txhRffaox8pVF1aCcAYQETShQh/R9IIsBk1PsoiSyCc1UWFmpw4aSZ/PVjgakqVLS2l6htD8xx3mevwB3xL7ZI8J8PceYtvKA80fDfvN9/LHlMoFqIcUF/CNvMIBQQnAb2kIFHuBuZSm2KHMIr/8qQZlDZUhPM8B8UhS088MwtdhnCiGzV6VMcl7ruXnWpV55c62K1bOzR5efQfng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(36840700001)(40470700004)(46966006)(2616005)(82740400003)(86362001)(40480700001)(356005)(40460700003)(7696005)(6916009)(70206006)(70586007)(316002)(54906003)(36756003)(81166007)(16526019)(26005)(83380400001)(336012)(426003)(1076003)(2906002)(5660300002)(478600001)(36860700001)(41300700001)(47076005)(8936002)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 07:32:06.3877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 308a6361-394b-4e43-6fa7-08dbea63f6ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6999
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
 Alexander.Deucher@amd.com, Lang Yu <lang.yu@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to add lsdma hw ip definition.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 15 +++++++++++++++
 drivers/gpu/drm/amd/include/amd_shared.h   |  2 ++
 include/uapi/drm/amdgpu_drm.h              |  3 ++-
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 656bc966d476..e05e8f8cf9a8 100644
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
index 579977f6ad52..86a6851db236 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -76,6 +76,7 @@ enum amd_apu_flags {
 * @AMD_IP_BLOCK_TYPE_PSP: Platform Security Processor
 * @AMD_IP_BLOCK_TYPE_DCE: Display and Compositing Engine
 * @AMD_IP_BLOCK_TYPE_GFX: Graphics and Compute Engine
+* @AMD_IP_BLOCK_TYPE_LSDMA: Light System DMA Engine
 * @AMD_IP_BLOCK_TYPE_SDMA: System DMA Engine
 * @AMD_IP_BLOCK_TYPE_UVD: Unified Video Decoder
 * @AMD_IP_BLOCK_TYPE_VCE: Video Compression Engine
@@ -95,6 +96,7 @@ enum amd_ip_block_type {
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

