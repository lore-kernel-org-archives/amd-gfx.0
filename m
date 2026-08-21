Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D53C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3AAD10F34D;
	Fri, 21 Aug 2026 16:06:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RSQVIxRA";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B436C10F34D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:05:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ns1dLrvcJzVwYeQgmg5hMgyLTky5OY/QGhXU1aRsfKv980h/tLxYx5ol2PhVI3Y6yyDSrJ10xWL9QfWJHIjtE/TG4Ps3PR2G+Q5oiYS6J4dteFpUgHnt0LgG5DhAi+q92IyHuBagaqH0iXG5QD/+f7/79RN71AHYCBo82hkIFC7Ii40E96NiyvzjkiZAAwrWJRt8UA6csGBwWc5foM8ygU/QUbRwnVxrOrxIxxjXpJhsFBq78O3jPubHT9XYM7WvNgbHqEjto1U4AuYM2PZXk2I7ui18idQSM5isRitaKFfWJgjy0nBymmvq64QefOrOIyRgz07t/8VbowBTHChVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZsuLIGAbw4mddrreD89M7pbVUaQwNlkI9Map+wdefQ=;
 b=ieHKNmGD+KGbwbRz9O0dma8kNbrv3S5rgxq8njemsa80JQanPyMBrcA0Le+F0UAtSk0imrlhxSPyMnXVzipw1R2jHzJRVVWigK8ZDy+yfusPjpmIG4HpoEgKDw8K4MHWgcH4Ws/ZUg7lvkTehrryZY3D6nxQexd2Gpu54G3mE9DVgwdYk/pKMVHzgMPjVgSPQR3A2mFbwULc5CXEsvhSFpr58nFZSZTqj1KarIPdUXrEFJ43aTMqd9Gfu5EbLIkmjxEauw/SjL5G6Pm0X9svMAcKy9SnPW7CX+yMPkNB7lgdK3Va/kUZ8d/3F8/l+YPGYqofVXzfbkuokSkpv1nEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZsuLIGAbw4mddrreD89M7pbVUaQwNlkI9Map+wdefQ=;
 b=RSQVIxRACj1IZmnpA8Cqrdn+myHE02RIA7aRDzPKDZcZb4XeLb9HG90M7IFopLSgV5vX2JavScrsZ4FayGwSmsxiCr4NPEdq5G9JJd3nK+2KkIt6N0gW1YRUYhstB9fbPjpgNv8O3TDvPzqkebwrwGMW8rmI9JyfJGeyk9FcpB0=
Received: from MW4PR04CA0129.namprd04.prod.outlook.com (2603:10b6:303:84::14)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Fri, 21 Aug
 2026 16:05:51 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::43) by MW4PR04CA0129.outlook.office365.com
 (2603:10b6:303:84::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:05:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:05:50 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:05:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: skip xgmi operations for non-xgmi multi-node
 configs
Date: Fri, 21 Aug 2026 12:05:40 -0400
Message-ID: <20260821160541.752029-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160541.752029-1-alexander.deucher@amd.com>
References: <20260821160541.752029-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c63b834-4b6a-48b7-a2f7-08deff9e1258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Q2RpFWuYz7VEr19QcfGBqIvH8/OeFqr48OjYV2X/cvHFfRVfITFrado65BYLqgnPEZXNsZCvsGFX1jVvywQWx7AKSej9N0oJCKGIis3zfihQrtzWm/5SGn9jj5SKd35Ogy+XtbJRjkFCTdxfSLpAbinjUotHsOXwipYqtNwhT/pMbeTy/hH0Cv1LNDvEkB09wiD9bLlJwAnvfUD5O0zDCGtT9x2NolbGAdhll5kHiJUEcr5KrGdHQ9B5pudaYkr4hM8PSECp+1Aa9Qvsetsqq8dx/h56qAKCJDTZ/0QWXQG/X627qv0GUwc5sbeaJcRkWLbBQ1qFP6T/5v2wd9gxYCzisVwgzj8FG8Umi9l6WSig6Jkp+MxJTdFRXT3QVAgoEqgeOwNAhYvWmHfhtUFWWfuvlgXqorZYrQ1ZwXpM0RfNP4KbZuY5jhy0cF85JNP4WV2y/SqtPBvPJTJwUmHIDMSBjWVTMwrtKOBl6h8lUXU4EynztUC0eSdhi8CkxC20e9GSmjXhGNHz+IKd9LUzK5GJv9xL0tm79CQ/4fZwuI5lSxiGeqOA39f14pKKDFcySmD2dvbbg3cESFRTzKj/i4o4XxmWBb50RP7dIOurMfZGJXdb5oGSksZYn7+PyMxLZ2qZE8toCRwC/bksinhgZK/VUh5tKkSnLeGxsE+UGY8wl24CmXWbW3gcdBkS7ILuFXqgp2w7Uz455b7oq3Da6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DGO1gFmLr6r062ZJ7cYlRNaxtCZQVY91eAu6cjH/P5xM9+QsjLAT4s+Jox7FjUBj5EOwNwRuyzVXtZOhalDJ5tYYz0bgUPMF/Ns4ccuBgh3MeLlQ0VnP5dGtTLTTpprzD/UcnAiqmQPYJ7Op4FbxX4fOsQ1VXg/Oe4v9rV/uNrwDK41gqkPeYXNU7IDS2WrYpPguylSSKTxe2UR2cJiO/nLT1gbFPtuC6XBE/swIcI0BXWmQxIrzxksftQC49cLBrBe+RKPCIHemeaSrMCmICivMWDMR11AixpVrlnTcunquAvZZJMleq0yviEhd+hRY6rGMmNu95mvmlaUeRyrj4DxDUD7+drj7WvYlZvt5cW31hsUIRbraR+BcxbW3ZHAYa0/2XhlrAiYETFZJShTCoVrIuqxPT6oGiI3JDimoYTkhDBkeYVIyIsZMdTn+yKKd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:05:50.9765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c63b834-4b6a-48b7-a2f7-08deff9e1258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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

From: Le Ma <le.ma@amd.com>

On multi-node configurations without XGMI interconnect (e.g. A+A),
num_physical_nodes can be greater than 1 even though XGMI is not supported.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1503bbf473c49..36cc11ff3dd4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2500,7 +2500,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	/**
 	 * In case of XGMI grab extra reference for reset domain for this device
 	 */
-	if (adev->gmc.xgmi.num_physical_nodes > 1) {
+	if (adev->gmc.xgmi.num_physical_nodes > 1 &&
+	    adev->gmc.xgmi.supported) {
 		if (amdgpu_xgmi_add_device(adev) == 0) {
 			if (!amdgpu_sriov_vf(adev)) {
 				struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
@@ -2783,7 +2784,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 	     adev->asic_type == CHIP_ALDEBARAN))
 		amdgpu_dpm_handle_passthrough_sbr(adev, true);
 
-	if (adev->gmc.xgmi.num_physical_nodes > 1) {
+	if (adev->gmc.xgmi.num_physical_nodes > 1 && adev->gmc.xgmi.supported) {
 		mutex_lock(&mgpu_info.mutex);
 
 		/*
@@ -2946,7 +2947,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
 		amdgpu_virt_release_ras_err_handler_data(adev);
 
-	if (adev->gmc.xgmi.num_physical_nodes > 1)
+	if (adev->gmc.xgmi.num_physical_nodes > 1 && adev->gmc.xgmi.supported)
 		amdgpu_xgmi_remove_device(adev);
 
 	amdgpu_amdkfd_device_fini_sw(adev);
-- 
2.55.0

