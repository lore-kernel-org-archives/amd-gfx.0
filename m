Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900ADE6FE3B
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 17:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD3C10E133;
	Fri,  6 Sep 2024 17:47:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DHXCp0Yh";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A3BF10EAB5
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 17:47:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/+ZKouzpTe1wsDfnWXtjmsNGFTGpuMuSkOBcDXqJMA3ob61qXxyso1rApzMIJtYO8/LamXU8y5XJI/NZ6RTmba49bfbOWPaJxnDAXi6L8HNiMIBQD70WJUVrvGGStllFJc2TV5nC08QECt9QJoZ+haI7CZokHeNSgUrQF+Dp+Zs/n0cKgNZn+6qanrVxVTbzkz1SHDEoSmOeyA0i7MjN9wGxnl/iNvy66u3F843SuxX0b5l+ON0WTsb/JYACMQSRggFekFuCUyxkcGWS6Kn1A5MvajMx2yzho4tKdrOoc/U20o5I+KLhB9YiM0icfW+JSen6i+4Sbj/TuUuS3S5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVS3p2EN5yHh3uRBLlLiusT9iCUsEyRgDvBAusW7OY8=;
 b=TAKKuecTzddQIT5tthQKtPf0x0HJn5P35ULOQXsGRGvet8XcNShIubozjavYua6nLas9VNRXSSnkGW2b+C7yiRTqMq2xtjC3Y9eTj4eFpfcjpA+CCu4Kc1YpHAr75kwvU3zTzO+MzNve2xPIUHGLnkvNxj+Z+TkgSaaiLgGaqPBJMnzd+2iT3a9rQttbGUNAB/tElbEHYeg2+WsRRJoksa8i1GNVr8w/Iaas9j5ivkygxOEYP7shj3MYj2D4q4iJIlElJyG2yHm9ANePBAIq5n7Fkr0AS94NcdIWeZippppcs9x2WP0ir6eHDQO2XGTKSjR7JtcVXmPxZChtPI4plQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVS3p2EN5yHh3uRBLlLiusT9iCUsEyRgDvBAusW7OY8=;
 b=DHXCp0YhSOvhggL1bc8kmLb6dXlq3ej1AENrCMAqsxi7uPDxFWsqYvwRbtasTb61lP9cUOnJqg6Gntm5iOc5yudvCKbcdhBodjKAR3GBclUWV6dBAJjpRsl+urC+R9GjJbek8bLqwyDd1aF8m95zB8MFNoK4BkXnaXZ14DrlyJc=
Received: from SJ0PR05CA0092.namprd05.prod.outlook.com (2603:10b6:a03:334::7)
 by CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 17:47:23 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::96) by SJ0PR05CA0092.outlook.office365.com
 (2603:10b6:a03:334::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Fri, 6 Sep 2024 17:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 17:47:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 12:47:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: Add flags to distinguish vf/pf/pt mode"
Date: Fri, 6 Sep 2024 13:47:06 -0400
Message-ID: <20240906174706.2551531-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: a07623d2-e271-4e06-c37b-08dcce9bf679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?faYDogpB4g6LkKmuCFLuo0sRDnfrvVXqKYCehZItLqV3BrqEKdVe02tHcsoX?=
 =?us-ascii?Q?6uU8KOAXOuwleyu+f4sd/FVkJHakOr6yT8kLAkkhh6QDa3qjBsunJ23b4Htp?=
 =?us-ascii?Q?BKWoP/7C/JyIYRu3hJcG8UiaLFTcRvvqBxqbLYnfkAJUhkcjrHiOJF+si64b?=
 =?us-ascii?Q?KqfAdGo5z2IX527nDcL7sEY4SqN5Zr3GJejYMwPYEsbgun1fKjWIK+EO99hb?=
 =?us-ascii?Q?RC3fO0JjUsvSGc0vhw1jQEXUR85UJRxb7tdsWMn22/rxXOoBnG6cT8P3wn2V?=
 =?us-ascii?Q?zJFZD2kN6FYvV1VVbWTVTA8f7iMGvwq2HYc+VzqHm7Bw5ruKkwOLTRFsJ1ms?=
 =?us-ascii?Q?DBzqSF+G8IIBLsJpOBzSvB8/vreDKVbaLSQTew3f45jzlfkow7cTmnty2ZZG?=
 =?us-ascii?Q?25keObWmhJJqcAHuLSuy1zB+AHTCNdHqpjOn8TWy6rQ6nlyyw2woxkWerfho?=
 =?us-ascii?Q?lWm3lmoXeIFs4il2xmnhh6s814zyu13aqpAzWLAUaCJxjCRLqYRf4nzRge3J?=
 =?us-ascii?Q?bzbSMjc1op4ImGIIsCKaQG88xWwr/cGD48FVByp9HGH86CGIzgSw0eYma2Fh?=
 =?us-ascii?Q?++pHiuXCaXje9m0Cdq47wGV1P4EhaUH8meAYi865gvcgBphrsYh/+6n/w9oI?=
 =?us-ascii?Q?TUI1r/sCQHIWbGMRuegcJzGP1VWFMumDYGdN+r0cNRU9t1PDxu8IVUc69dFk?=
 =?us-ascii?Q?8OjdyD/ajWa/dz3vXooA0jyA886sh9fF2ykfxdTBzdH6vvyfRjbWGCxsRsug?=
 =?us-ascii?Q?HVmpbc1iRm37sw4bwkW7lufPWH7JSHHoMfIYMn8ayqamnxGF3U36VJfstsVj?=
 =?us-ascii?Q?YTtw+fL2qtIdOPK/mhRYMWd2mgzk2Jb3K8mQpZhc7sIcPf5rKhRiUuSNA6BK?=
 =?us-ascii?Q?HaNdx5Cwyv8LJ9z7s5QpSFPsmIrtzy2ZSjmFZKvjShuzV9pM2VQEMXBoJCSx?=
 =?us-ascii?Q?MfCJZ8IZfcr6144WDQ1f8gTpqfj5+TIq0xDrJypjv9nYDxHfOg68VkZE797+?=
 =?us-ascii?Q?9FViS17jYV+600gvTs4Vn9gedswmGtQcAdYZghh2Q5HuWBvGwoN3OaoajetB?=
 =?us-ascii?Q?5Ly/eV4ANVspdTOgEWnP9lY+ttkb+kVR9oNGSnbM2VnAhHX+tYwSY0Xtku0D?=
 =?us-ascii?Q?0AyKFJuRDWcs48lUYIn0YVi2jrRHPXSS4lo5C8CG2xTMjR9GPsnHLSsHNWgN?=
 =?us-ascii?Q?2itMtZH9ng7I++1SSScb82Q4tz2QPjz7jKjKX/xULoeSau8HRBnA6qY5/eSL?=
 =?us-ascii?Q?vyKfQjefEtvuGsIfxVFljNcjVMrsLX5PiGWLSP879QMetag8A2HYa7QV0XKS?=
 =?us-ascii?Q?3nt8EjRAZtzqx6tFpVd75zqDDY/OUWmMQsOJiLqx6LcvfrqkDUzC/eJgSeiq?=
 =?us-ascii?Q?uCeeEsmhex5eQ2BB4J5rVl6xgzMN++Nh4MIOGakmhAgn5bzLLONex18Y/0Lu?=
 =?us-ascii?Q?apqckt7VbZD5rjLzUfHiEA7Lt4B8PRKo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 17:47:22.8320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a07623d2-e271-4e06-c37b-08dcce9bf679
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188
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

This reverts commit f03b874313cc9b5859596fe9c5b368387b6da771.

This is unused so far and has not gone upstream yet, so remove
it until the userspace side is ready.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  9 ---------
 include/uapi/drm/amdgpu_drm.h           | 10 ----------
 3 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f7ed1e356d96..d90473aec942 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -117,10 +117,9 @@
  * - 3.56.0 - Update IB start address and size alignment for decode and encode
  * - 3.57.0 - Compute tunneling on GFX10+
  * - 3.58.0 - Add GFX12 DCC support
- * - 3.59.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & AMDGPU_IDS_FLAGS_MODE_PT
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	59
+#define KMS_DRIVER_MINOR	58
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d9fde38f6ee2..96af9ff1acb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -888,15 +888,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		if (adev->gfx.config.ta_cntl2_truncate_coord_mode)
 			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD;
 
-		if (amdgpu_passthrough(adev))
-			dev_info->ids_flags |= (AMDGPU_IDS_FLAGS_MODE_PT <<
-						AMDGPU_IDS_FLAGS_MODE_SHIFT) &
-						AMDGPU_IDS_FLAGS_MODE_MASK;
-		else if (amdgpu_sriov_vf(adev))
-			dev_info->ids_flags |= (AMDGPU_IDS_FLAGS_MODE_VF <<
-						AMDGPU_IDS_FLAGS_MODE_SHIFT) &
-						AMDGPU_IDS_FLAGS_MODE_MASK;
-
 		vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
 		vm_size -= AMDGPU_VA_RESERVED_TOP;
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 3e488b0119eb..e44362e74fa1 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -756,16 +756,6 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_IDS_FLAGS_TMZ            0x4
 #define AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD 0x8
 
-/*
- *  Query h/w info: Flag identifying VF/PF/PT mode
- *
- */
-#define AMDGPU_IDS_FLAGS_MODE_MASK      0x300
-#define AMDGPU_IDS_FLAGS_MODE_SHIFT     0x8
-#define AMDGPU_IDS_FLAGS_MODE_PF        0x0
-#define AMDGPU_IDS_FLAGS_MODE_VF        0x1
-#define AMDGPU_IDS_FLAGS_MODE_PT        0x2
-
 /* indicate if acceleration can be working */
 #define AMDGPU_INFO_ACCEL_WORKING		0x00
 /* get the crtc_id from the mode object id? */
-- 
2.46.0

