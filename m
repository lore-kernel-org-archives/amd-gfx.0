Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFBACA1009
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 18:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0CE610E168;
	Wed,  3 Sep 2025 18:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wCkgsK/S";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA10110E168
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 18:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybMjjj+w5Cwcgpfv1+0xhYv6yPSt44Dp4QbOFsZobCCIqLT7pjMCJSWLQGifd8FzZQ9bcL+yz669j8/cVjIGwWxVJyzVto84NU+ewZ+rJKZjVftsileO++brwCjJgEP6bm4KwHec5Okdylq8aOK7ROnux6DlSvj3C6r7NOD4+ud/JPi9gd9eedZ1knoF1jrWd515B2O/QTlQK+IUf90KIB6iayGEmCRC35afylHLpp55ubBiVf434OMrwVCMyCRVz8mCiMgszuFeH3yaGNYVzJPfLvE2MNU0mZdV/uvxxGiHbpq6K68u6uaAv6ozSzg2vkwYTuUgWytlGVn/MUjMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWC2E9aytZkgRIyhqR9THcB1WbRJY56zwO1XpB1lmN4=;
 b=O8yIuZTL1WAOc/ZhMHdrR5uXyo2JqnJxTQO/9rMxuCZDamjnI6s4xAb+azBhXFp3LqQrnMvzw18WiTlnC5dJ3oDG+UX1AhV0bdQTY4Jt7eOwqCTzVtSQegQnyqDOYYhnjd5qhA8HF7VNOmDhYQ18BLQOPYA+1POFuNqQfVlTThcPjPhhQM1+2wOC92C8YSgEPlLiW44uklWHR8i1+W9o0VOcwL4uu2fwjmLatcqWxqgpUnzoFV8b6c5iIysKFYQSn9/XpzrOKvgwgcgT5JXKd2L4yBhywj8iPyMSbQc0Tn2EGfpJ+c5Kw0lQUGeXCph3Am7iq74XhH+W6k2thVZFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWC2E9aytZkgRIyhqR9THcB1WbRJY56zwO1XpB1lmN4=;
 b=wCkgsK/SPBtopqfmfnYqWkofPToshwpMQAP88pgP151e/dkltXNWwzczzQKwox32ozag/67B5RyCyQviMxyd/15V0WgwvyHsBVcWMnmcOx49gyndkybOMHczJeS3ez+8Lj+AQGLrIx6ILEe5AseOv0JkzKGZflU1JEBkiwKe9fI=
Received: from DM6PR07CA0042.namprd07.prod.outlook.com (2603:10b6:5:74::19) by
 SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Wed, 3 Sep 2025 18:33:57 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:74:cafe::8d) by DM6PR07CA0042.outlook.office365.com
 (2603:10b6:5:74::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Wed,
 3 Sep 2025 18:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 3 Sep 2025 18:33:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 13:33:55 -0500
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 3 Sep 2025 11:33:55 -0700
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <mlimonci@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, <phil.jawich@amd.com>,
 Pratap Nirujogi
 <pratap.nirujogi@amd.com>, Alexey Zagorodnikov <xglooom@gmail.com>
Subject: [PATCH] drm/amd/amdgpu: Declare isp firmware binary file
Date: Wed, 3 Sep 2025 14:33:03 -0400
Message-ID: <20250903183333.529150-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 005b2dd4-41b5-4e19-6ebf-08ddeb1870f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cFf418VydLkvGhiDE81sRd1wjsy4nC16rgBsVmDaXe4D+S3f5s8BVOYC3tSz?=
 =?us-ascii?Q?gtRoVxKqfDJsu5zqyzMLXmCTzOB0Qlr3oYQ422l6FdYGikjNWpJBmjKpBu30?=
 =?us-ascii?Q?1zg1jyqPkZHuRGHCzLPnfoj8m4oRdcBJq9JT6WeuArBOIPNpPp0SULjD7vXV?=
 =?us-ascii?Q?2GaVAKsSJth2sHhfeo8ciEQ6Ni4crwdQTiwu8NACPl2unZxtZwVWNku07lwr?=
 =?us-ascii?Q?F2XAK+rkrugGcPg+KY7IzsVWbdZHhVQAIsxkV5Na1LuaVs3pTorN9fa1BxcQ?=
 =?us-ascii?Q?vzttCnYZrPVfZc2MFJuM3u/1pCk9NUCjhg8Xcc0ENSR9qzV6aKqhYnfj+NN0?=
 =?us-ascii?Q?3aboUTcgNDRhZxVoyiPcZgmoDV7pQVPuRMw2mY0PDQhJOt3nZQBJAL6ZDwXS?=
 =?us-ascii?Q?ER0lezu/YOPwIWxulqSXHU1ynOxC+X4x5jPlYwpbcla5WxaFY1lJVmQnjb9f?=
 =?us-ascii?Q?GYVUkjCRCytTgUsaJdCE3SkKM534xwRVrsZ25WLSGTGKAIX4ODyEHe3rpkm0?=
 =?us-ascii?Q?EgeUQVZqOc+iGXo5/9uo6PW2A9HDgUZFcm9xy71kwKkgzw9GVeMszshmFZBL?=
 =?us-ascii?Q?MnU3ALajanDYUVL31MrecsLFedtlRxSu2BKuUQpbuO/VVByp8wOMPxx6p6t1?=
 =?us-ascii?Q?9qN830OGF1AiLvSMeRQynjIeT8KembKsy9S3a9UOC8J1xIYBpXNMKM/AOzJz?=
 =?us-ascii?Q?Px3dbjT6cCnf1VeDdhBwhWqFe1E9ujxMxiuAa4fpJT5B8AWwC5KJ/peZ49hL?=
 =?us-ascii?Q?iSXOyBlMHZiFfto70VzOehEWrVKRpBSjuAU71mjquxzvFfhUZZuQMvjE+YwR?=
 =?us-ascii?Q?6FvX2AyfS8TwBc1dloFlypnHnYPn/tbYatAwfh8HxPzkUCbkPGOB0376erBS?=
 =?us-ascii?Q?CTPldqEEm70WRxWGfMtc+GNBy2JHIGc+ZhigO8lMmBlfhLX2A0JJioMLA4VN?=
 =?us-ascii?Q?N9df1xfP2oOqCaOnmmjQtP3bIyv3bPmyx9rA0BHiCjYTnTb05WVwC4lGkfAM?=
 =?us-ascii?Q?to94/XrFHpA+yJUyorA2+1NvBmvv0bQYRQpZsecpWG6zxdCkL/XeLeE5XV9z?=
 =?us-ascii?Q?lKoMs0MfybyLgf0QcWn7MNNbRwyz9v04DsV6GXte+ldZ/LZhLnUp9X1RxC8x?=
 =?us-ascii?Q?Ii2QjxFU57K4WiT9KLxllolhKqbjfefeRP4kSMDDCj1ml6AuwBMQwUxR7wWw?=
 =?us-ascii?Q?zlDOf3dM0u0FO6lXlasc8a1Ezcd/Us+wetgyRvaVxb+tEBUBozNM7U9nhht6?=
 =?us-ascii?Q?oh8o74Xm3u34C67z78pyVJe0ODjQWosjMlpo5wYfarCPevreCMAjmWXWi6VL?=
 =?us-ascii?Q?/WnjgdodZu7lbIcMIvJRqmH0Byc2iUbTHRbOL2fCdFi160/hZcGWWlQkWd9u?=
 =?us-ascii?Q?h29xaqe8zqurXbsFVQp2NE5dTNeJkyFBmEwOTkF3b0SkMXpEWKFWZYNkprfS?=
 =?us-ascii?Q?CCbSLDIxK20OZZXYVKVyK7FmENyDvVFComStOW/Zo1Qv9SAw+H8sJhEaSrF6?=
 =?us-ascii?Q?aD2LTWAuarfM4oS1SD8TMzkk41xrrgKMTkMA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 18:33:56.2270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 005b2dd4-41b5-4e19-6ebf-08ddeb1870f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221
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

Declare isp firmware file isp_4_1_1.bin required by isp4.1.1 device.

Suggested-by: Alexey Zagorodnikov <xglooom@gmail.com>
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 22 +++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c | 12 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 14 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h |  2 +-
 6 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index 9cddbf50442a..90af35ee8f6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -68,7 +68,7 @@ static int isp_hw_fini(struct amdgpu_ip_block *ip_block)
 	return -ENODEV;
 }
 
-static int isp_load_fw_by_psp(struct amdgpu_device *adev)
+int isp_load_fw_by_psp(struct amdgpu_device *adev)
 {
 	const struct common_firmware_header *hdr;
 	char ucode_prefix[10];
@@ -80,7 +80,7 @@ static int isp_load_fw_by_psp(struct amdgpu_device *adev)
 
 	/* read isp fw */
 	r = amdgpu_ucode_request(adev, &adev->isp.fw, AMDGPU_UCODE_OPTIONAL,
-				"amdgpu/%s.bin", ucode_prefix);
+				 "amdgpu/%s.bin", ucode_prefix);
 	if (r) {
 		amdgpu_ucode_release(&adev->isp.fw);
 		return r;
@@ -103,27 +103,23 @@ static int isp_early_init(struct amdgpu_ip_block *ip_block)
 
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_isp *isp = &adev->isp;
+	int r;
+
+	isp->adev = adev;
+	isp->parent = adev->dev;
 
 	switch (amdgpu_ip_version(adev, ISP_HWIP, 0)) {
 	case IP_VERSION(4, 1, 0):
-		isp_v4_1_0_set_isp_funcs(isp);
+		r = isp_v4_1_0_set_isp_funcs(isp);
 		break;
 	case IP_VERSION(4, 1, 1):
-		isp_v4_1_1_set_isp_funcs(isp);
+		r = isp_v4_1_1_set_isp_funcs(isp);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	isp->adev = adev;
-	isp->parent = adev->dev;
-
-	if (isp_load_fw_by_psp(adev)) {
-		DRM_DEBUG_DRIVER("%s: isp fw load failed\n", __func__);
-		return -ENOENT;
-	}
-
-	return 0;
+	return r;
 }
 
 static bool isp_is_idle(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
index d6f4ffa4c97c..36750123ed46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
@@ -57,4 +57,6 @@ struct amdgpu_isp {
 extern const struct amdgpu_ip_block_version isp_v4_1_0_ip_block;
 extern const struct amdgpu_ip_block_version isp_v4_1_1_ip_block;
 
+int isp_load_fw_by_psp(struct amdgpu_device *adev);
+
 #endif /* __AMDGPU_ISP_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
index 0027a639c7e6..926947a612a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
@@ -185,7 +185,17 @@ static const struct isp_funcs isp_v4_1_0_funcs = {
 	.hw_fini = isp_v4_1_0_hw_fini,
 };
 
-void isp_v4_1_0_set_isp_funcs(struct amdgpu_isp *isp)
+int isp_v4_1_0_set_isp_funcs(struct amdgpu_isp *isp)
 {
+	struct amdgpu_device *adev = isp->adev;
+
 	isp->funcs = &isp_v4_1_0_funcs;
+
+	/* load isp firmware */
+	if (isp_load_fw_by_psp(adev)) {
+		drm_err(&adev->ddev, "isp fw load failed\n");
+		return -ENOENT;
+	}
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
index 4d239198edd0..5e43ba064708 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
@@ -45,6 +45,6 @@
 #define ISP410_GPIO_SENSOR_OFFSET 0x6613C
 #define ISP410_GPIO_SENSOR_SIZE 0x54
 
-void isp_v4_1_0_set_isp_funcs(struct amdgpu_isp *isp);
+int isp_v4_1_0_set_isp_funcs(struct amdgpu_isp *isp);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index a887df520414..1e48d94e8706 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -29,6 +29,8 @@
 #include "amdgpu.h"
 #include "isp_v4_1_1.h"
 
+MODULE_FIRMWARE("amdgpu/isp_4_1_1.bin");
+
 #define ISP_PERFORMANCE_STATE_LOW 0
 #define ISP_PERFORMANCE_STATE_HIGH 1
 
@@ -369,7 +371,17 @@ static const struct isp_funcs isp_v4_1_1_funcs = {
 	.hw_fini = isp_v4_1_1_hw_fini,
 };
 
-void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp)
+int isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp)
 {
+	struct amdgpu_device *adev = isp->adev;
+
 	isp->funcs = &isp_v4_1_1_funcs;
+
+	/* load isp firmware */
+	if (isp_load_fw_by_psp(adev)) {
+		drm_err(&adev->ddev, "isp fw load failed\n");
+		return -ENOENT;
+	}
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
index fe45d70d87f1..b221d8b81983 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
@@ -44,6 +44,6 @@
 #define ISP411_GPIO_SENSOR_OFFSET 0x6613C
 #define ISP411_GPIO_SENSOR_SIZE 0x54
 
-void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp);
+int isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp);
 
 #endif
-- 
2.43.0

