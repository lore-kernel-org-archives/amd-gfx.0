Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4973FE77185
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C55DA10E9FE;
	Tue, 10 Dec 2024 22:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iZq83dpq";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A94EC10E9D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1ltZgVwaKbC3waZ46Kjgiu2Ouxme011DfgJMdIy79nyWu+g6TteTucvLynBts/7ai3Q2OgAsGAdFcEE9KdcMTCGOPOVKnqTz5fsoUP7RzrLna5jvDUYm62QhpCrz0BcVElgwCCQTClZL3e2qgYzffwIpx6gsMyoFk03R1Yzsi3T+K2BdFNJ/Vyo8Xpv6M7SzXWIB/5kTL5rWyhSlN12wMwqh3Gv0aidkhf4YeC7+bE7rTxuguX31W3R8pjV1sLdDdszMl+nGovsW/kH6E3B+Y0UyCILpKAZKrUxzPKEezALNqMmo8vsbY+/TzhMMDinFiWndAkZoMT7tyTkSryQHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPB3D+hwrB9K7wJUo9bqHED10EHlkg3WddegSmoXXxQ=;
 b=y+QjznwYNxrAsqcS3OGzz9rE0PVOJU7SRAdrTC/ZfNAKZwCsTJSaYCm3Tk326TBPHZ+6WzozWz9PCkxNSsUy64a01irjnbW41nNHI4e5okA92NHq02yuxOB3+1ZGB41j/ymjmY7b8TfJTssA+oshxSx8QuSBFMK93jmoUBk0HZnwYGxDe9Jlw2w614abkulD7uEDDZkrrKJApeDURmEi7WtC5vWTDDITXs4Unav2q8CqseGJkJWpIc0FAHhgrequEG9eXLOGGt3eWRgtQ6V9gLI2kFL6uF0hj3kY8cGngRbs3qj/WLJSAbpUWz5IaWmoBG9BJRBeZLvoz1miAYUVGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPB3D+hwrB9K7wJUo9bqHED10EHlkg3WddegSmoXXxQ=;
 b=iZq83dpqdYM12yK8gHgPJOWqy+GkVQPyV2QaQ2vGpSRGLLL5plMu4YK9tYRViLXyFyZ4VGXBiSfNYBo/IFBCwu4DbRT6DVN7AA2aR93pgxB8QU+slrjn5qA4ZAjWDmksHtj0B34Uv9883MFfBev9DUxro5Vj7bPEHK55NOzz6yg=
Received: from MN2PR01CA0004.prod.exchangelabs.com (2603:10b6:208:10c::17) by
 SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 22:54:20 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::22) by MN2PR01CA0004.outlook.office365.com
 (2603:10b6:208:10c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 10 Dec 2024 22:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:16 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 47/48] drm/amdgpu: use new helper to get num instances for JPEG
Date: Tue, 10 Dec 2024 17:53:36 -0500
Message-ID: <20241210225337.75394-48-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|SJ2PR12MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa0c4e8-f288-4a25-a861-08dd196d9513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fU3JY5kXN6YtSuG/i90c65rbZ5wlGGnppiVNKyqFddkpHzbWAxINIGe7ds/h?=
 =?us-ascii?Q?GnomZ34u4GeD10tS9aOH33N5EWJvjkQXVJHFDZCaLSfFyy9JYm22bCIJ29Hi?=
 =?us-ascii?Q?Q6TkRzTyXW7bPk2PYwyy/Y36AsxK0nOP3MPbfuOoLMtPkV8Sqz3gY9r0QifS?=
 =?us-ascii?Q?F1ITNExzVobvSx/+8QU1Xo5Nyil55kprsnuoP37+hLJXn9EbsVgXYqCg9ZNz?=
 =?us-ascii?Q?Q38kioYB/D/orMuk8ZZiQAMqtzSTmXPrK9DNpqfXz4X6gwuND54oClBlWxkh?=
 =?us-ascii?Q?u/V+ScvptQhxm+ZvGRj/sAh9xf0taLv4cMJGfUA3n0yo3H9+dBOd9y18cgVo?=
 =?us-ascii?Q?DOvU6bcBAPAjXWbmw9SwaenZ8xEsfhj3FVjIcKTq4rlSqcubjK3biOef4HoU?=
 =?us-ascii?Q?ILi+uxAjSXkVy2fZjwfDuCXFwTn/F87uUzTfR5f2O6OmhrTM3rZ0HlYnQnLY?=
 =?us-ascii?Q?AfKjBPErP84/XPK0d9ADpv7dXZOn7cqtjVmluQkD+lQUjRjySjIX+5z3yfXQ?=
 =?us-ascii?Q?xmOUuTPZPQfI5S1lz8AKJbJxzro6qM0uCfOG8+BHOpzf2+6Y6NvzP0bFUpZz?=
 =?us-ascii?Q?a+ZEGebly1pSfS7Nv3raTWZkt4F7A7eRDYXN0aJWkL4PCrwbXhriOOhR25SN?=
 =?us-ascii?Q?t+e9CPvzsd9GsSJVX0nNiZj+1KBvQouWT0xP/ZXtNejZEfrRodIxx5sM5Qxk?=
 =?us-ascii?Q?FSSkoZSJoyPeJFs2WX95EVhFnkeIt5A9+IkqJYyttlmjp9IkGY0dSbtVrb0x?=
 =?us-ascii?Q?gAM4vrqO5lMA7kN3dE8gOblgSrUaP4dLOH/iUWOptlC6+3x8i3hsi88vKPDe?=
 =?us-ascii?Q?pPNtSwZghC4F6rH/qFbk6motC12xsEjQhuhZKJxHe/fT1R0cYooOlUGm1sOL?=
 =?us-ascii?Q?Js1F9nnA8NrXUiWc2z4b43epWN9Qa+y+QXTifSX8UGzYdxIJdiHEyJtTftRi?=
 =?us-ascii?Q?LwuOQUfiQsLusS3dO6M9x7kKM1l1zAi+Udb31Xy2fs73//tkTSyn7ZGRtIWK?=
 =?us-ascii?Q?jpfYIlAs2Y1B+DNZGAieW8KJFm9DHwHvp6Q6/9RqBkXaGvb5SI37pvBoRLbr?=
 =?us-ascii?Q?kQsmouTP3vQ1LsbEtOeYy7bXxK3+P8BqjiQffD2jgw6ROghnTMBvZEXUPGRB?=
 =?us-ascii?Q?L05IMqO9WhbdeeXWAOJvkmSIJ8NBSgAvLVw6bQnfieWOQXPtYlHBxPVD2mZ9?=
 =?us-ascii?Q?Y2lZumiAPy4n99OzEepKz0xDXeLA4y4QQFzXy5+oXhsZ1EMV5+xxys37CZ7l?=
 =?us-ascii?Q?nkePyL2nuNFGzIksattk4r7y1Bwtifnvw2GlqJNpKiugWnOjmjBXqj8HuVPf?=
 =?us-ascii?Q?8IHYg1CdPneuNT8fgJd7mxAwPxMHRoSwp/q0sbeduMp6xy5CTbuKTLgVp7ox?=
 =?us-ascii?Q?VicVJzE8Ee7d1jBZ7viNCFWvPAq0gUtAnnKeE0f5E9gvu1r35A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:19.9076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa0c4e8-f288-4a25-a861-08dd196d9513
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8739
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

Use the helper for all non-JPEG code which queries the number
of SDMA instances.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c        | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c     | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 4 +++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 4f6f617066955..330f5cfb79218 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -495,8 +495,9 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	case AMDGPU_HW_IP_VCN_JPEG:
 		type = (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_JPEG)) ?
 			AMD_IP_BLOCK_TYPE_JPEG : AMD_IP_BLOCK_TYPE_VCN;
+		num_inst = amdgpu_device_ip_get_num_inst(adev, type);
 
-		for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
+		for (i = 0; i < num_inst; i++) {
 			if (adev->jpeg.harvest_config & (1 << i))
 				continue;
 
@@ -688,7 +689,8 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			count = adev->sdma.num_instances;
 			break;
 		case AMD_IP_BLOCK_TYPE_JPEG:
-			count = adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings;
+			count = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_JPEG) *
+				adev->jpeg.num_jpeg_rings;
 			break;
 		case AMD_IP_BLOCK_TYPE_VCN:
 			count = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index ab7a2ba59a1bd..6d020e81ff945 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -465,7 +465,7 @@ static int aqua_vanjaram_get_xcp_res_info(struct amdgpu_xcp_mgr *xcp_mgr,
 	max_res[AMDGPU_XCP_RES_XCC] = NUM_XCC(adev->gfx.xcc_mask);
 	max_res[AMDGPU_XCP_RES_DMA] = adev->sdma.num_instances;
 	max_res[AMDGPU_XCP_RES_DEC] = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
-	max_res[AMDGPU_XCP_RES_JPEG] = adev->jpeg.num_jpeg_inst;
+	max_res[AMDGPU_XCP_RES_JPEG] = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_JPEG);
 
 	switch (mode) {
 	case AMDGPU_SPX_PARTITION_MODE:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index e660f4a663781..921cad5ef5f4a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1541,8 +1541,10 @@ int smu_v14_0_set_jpeg_enable(struct smu_context *smu,
 {
 	struct amdgpu_device *adev = smu->adev;
 	int i, ret = 0;
+	int num_jpeg_inst = amdgpu_device_ip_get_num_inst(adev,
+							  AMD_IP_BLOCK_TYPE_JPEG);
 
-	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
+	for (i = 0; i < num_jpeg_inst; i++) {
 		if (adev->jpeg.harvest_config & (1 << i))
 			continue;
 
-- 
2.47.1

