Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDCDCD4F24
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 14:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A527D10E24F;
	Tue, 12 May 2026 14:58:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qd2Yjbvl";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 025F110EB38
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 14:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ID3bYtEXsVlwSkotyuG4aEQPW2Mmg7PtA1ku9Fm8i2oNQjjhGRkmpRYI/VzD1tj+1hHluTD6fPcKn6gCRc4tCnWAM2h3vWkSULaJojDQyusmzE6CE9k8EyHPO0lf83r/Hw6GCy9DausJizkSAFI5c+5+J8gNenMsbm+IhNB06/pCpvr8hDGBQhc8J53BGaVvlkQTv0XngHuW9WphlcyOdRG9aytqGvyxvL530v+lf/6XNc0VPfWm+8jpDxtdc6kJdt3maL/TxGLIxb5bP6eE6z7gB27k0AaviafSU4xBY8Ucfll2OCdLTaBKNiJMC9Xct7sqcMIeLE0UTFxT6RYPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arTRwojIClowP7rH3Q3Ifjl9D+nP7qBxXfkKVFS5UKE=;
 b=ThcPRHhKH3R96/weCPztZ+8UcQCyNoVzOoe6srfgczTHToc4dfuklrTTBIm6iKtA4I3765B8H/67xknKfB5IBRa32+DsuBWkUP9RfpwS+aI2nGE+uNOO9rvnP6d+yHWe1BbJP44PAq02lwFJ5aWaaW8BjaUFxPoP8/cVVdracHx23UuDBfyJhBzv/oZ/OjUYsOOsYk+1MbxkkRG1+tF0B4dsSE4uihDTeQCe73SNOlY238ujinR7KgIA/6CnxWOvIexlXtyefg8nEM//rFplPzQOK7jot1qc/W64GTnMO6A0HFUqgVii/g3lQ1pJv21xXwbXdsM94bcAHGrklwtBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arTRwojIClowP7rH3Q3Ifjl9D+nP7qBxXfkKVFS5UKE=;
 b=qd2YjbvlTu+Yog6RTbNZQrVDDyHQ1RnUw6NpChCqBoMugG3E0JLR2gvhJXkRwSJGRskky9CEB2O0TKO8UkMZM25U9HgDvF0XBa+fcUwO4BwqSbIBzdIRAGcFnK4WPG6IrxhzFlSimbuXBtut2em02Q1Nrk3orAg13fONqhf+siM=
Received: from BYAPR05CA0058.namprd05.prod.outlook.com (2603:10b6:a03:74::35)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 14:57:57 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::33) by BYAPR05CA0058.outlook.office365.com
 (2603:10b6:a03:74::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Tue, 12
 May 2026 14:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 14:57:56 +0000
Received: from SATLEXMB03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 09:57:51 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <alexander.deucher@amd.com>, Boyuan Zhang
 <boyuan.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix division by zero with invalid uvd dimensions
Date: Tue, 12 May 2026 10:57:35 -0400
Message-ID: <20260512145735.450047-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: c5fcc7fa-ecb1-4741-58b6-08deb036da54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: OjUPuB/hfdT5oXBHlOAOVIGNEi8/XRQzdjSWiCK/PeG5p2MlFCHAqbv2SbnlFAhLF1pQliW3SsxSOrPQmhiB+6yGNpQe2kIr6o6P4R7RNr13vUNjkIcd8aVecPrBuMYClV3mqwy1lHoPzqFzXVIc2pqj3SvulyeaWse3NY6wH+dKG+t3VbOBR57NGuO1ABQCPzdkDSQjmm0i+pzB4s0WnkAc88AGfrepfqgczmaAEaK+gI410hyDhsBWmoNiCeAbsbyxXjP+xAnD5k2hwRp2NtlY0rwSanBqzb3TW9vmABrZ4Wu4y96r93ixl/7ts8Cu+QnTEXDOk29EpPlOiL1wbOnK1/t7N6IIAJ9PzmlRAyXmb6jqN4TB2ZBtgrHT16lTdeKY/gjLNei8VuNgNJpJ19Nra51Zk3Pugn6ENyGEA4w9wjc/oG86504Fj79/SpShYOkVnmE7yaudwBLGNAiCF2LbJwTTancSGpj4chmdJWUaPa3k/h3eGoIVX7c5plmiHVfBh7kwMOf2IrqWFz7awSwEebPp6GBaz6tWmNV4yxUDJg1tXAooPVJY66Wg44o8FsrYgos7IApiWY4lpTOJ93ZwimUEFCdrDMQT9CyanUS2viXJpqK7GW2riIEzehlyLwvPGQuaI655CvtSPxpI8omsgkVBo0mk4i41Qqj4gxX3SelgBA79sf535deOtnKaGO4hKwi7uP2JUPhFc0zzjqK0U0m/oxAOnDYFkbR9TCw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VbBngj3Sxe03Hs+MweXLf012l19D1otlagjByujvCsxLBOKwK2wK0jy4B9BNGzalD4GHkXHrJ/iK9o9kXzkyDQtlgJk0Nf2habQTBQahT4F5yHZijQ91tr8+1AdTgjvYKjYJtxUMx65KG7/2Ai2CTIXvMxXVZzFaoyOYCZZhMcK3NWMzpyJwDS+zpGGe9n1A8XqBygaXMG4FVHIQFimfHx8D1P3GfeKr7quxhs1KJ2kti4iYxFn6jH+x1VG7Ce55MXTG7nKAlseb3qJWTE61YjFUw578EF0nuKRIq2mRVAurzWi5OzO+ibFAE5jKf+pLo9sZt8R4H/UK3e8xx8UjphcNeyf7cBY2Tg2Q2z6RrZ47KZ6EvjQePPayhqjWR6rOh4/MTqDr63/1EyYu9/+0EFJJKKFtN4VGtPzFVHMgtypbnUTat2GYr9PDmkhjxvvT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 14:57:56.9471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fcc7fa-ecb1-4741-58b6-08deb036da54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

When width or height is less than 16, width_in_mb or height_in_mb
becomes 0, leading to fs_in_mb being 0. This causes a division by
zero when calculating num_dpb_buffer in H264 and H264 Perf decode
paths.

Add validation to reject frames with width < 16 or height < 16
before performing any calculations that depend on these values.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 3a3bc0d370fa..0cf0f53e5066 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -628,13 +628,20 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 	unsigned int pitch = msg[28];
 	unsigned int level = msg[57];
 
+	unsigned int image_size, tmp, min_dpb_size, num_dpb_buffer;
+	unsigned int min_ctx_size = ~0;
+
+	/* Reject invalid dimensions to prevent division by zero */
+	if (width < 16 || height < 16) {
+		DRM_ERROR("Invalid UVD decoding dimensions (%dx%d)!\n",
+			  width, height);
+		return -EINVAL;
+	}
+
 	unsigned int width_in_mb = width / 16;
 	unsigned int height_in_mb = ALIGN(height / 16, 2);
 	unsigned int fs_in_mb = width_in_mb * height_in_mb;
 
-	unsigned int image_size, tmp, min_dpb_size, num_dpb_buffer;
-	unsigned int min_ctx_size = ~0;
-
 	image_size = width * height;
 	image_size += image_size / 2;
 	image_size = ALIGN(image_size, 1024);
-- 
2.43.0

