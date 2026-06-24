Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D063BCDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 03:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E5BC10E051;
	Wed, 24 Jun 2026 03:41:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Aehd7XS";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013021.outbound.protection.outlook.com
 [40.93.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED8F10E051
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 03:41:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAMF4XW1PYHqqSaQ7GCmVC6YcwHbNMR8kJcA0IfNE1BFuW3zq0xacrpwDINZAgqsQDkecGUPupua7swEQ0KYCj03l/A5PWGBiYr7SIpODEw2Xkj/+MEmHvp/oGGveJ3MDPGR5EYmaVwG44COQtwPKOIkPRqN66f03zTchrLJfBoNgfUjJgssAoS/HbEcRs2E9825dgT8EV6d6ofuw092XQn2lGUWsFv2cy4MgSpM9J6EC7GZ3wYUXz3zqsb3NU/b7C+6l+EPXn3kp+CZrE8e1wjVFMky/kwrStVidQAPM/C3LlGOATe15qwEI+Ahz7iZNzqGgSHSNYmY8Dj++StTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7KfVyakA/LclrB+7u/C3s+gSCxiHhsx6bP7MGv3L24=;
 b=L2gecUAohc7Eg67Myj3Ko+UZsorbAOfEh9IVeQPImRjn/h2lDaiLiaugOTacw2Cz63WE9GWL/tacZIrOcR5Wa0HUJC2S+5/piQt7r9t1f+Rog7+fDG+Myga1c6LO7tp+yXEwYg3xPI/JYWU6dvzRqb/a3qQfBYn+pwbmgqvjBqfCJDme6XSWHqE7ER25YtGpP0D30XdmJsh3MRe6PD/3xnFseEHan5FTgfx87zeZM2xcX9otQFV9DajkxTy+5LlzctE/9DqXKWMmvx86MjBiBu4o9Y0AhcopF0v5UNfH/XB7H6ggl8CX3uD4iC0Igwy3IUQSRl3pq+N88SSIsL0o8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7KfVyakA/LclrB+7u/C3s+gSCxiHhsx6bP7MGv3L24=;
 b=2Aehd7XSwdkCW1FBzDne/EdW22vKgz79T+zR8fGQr6661QrtvgBYbnRdGEyw/P8h411uP0TlZ+l/5iK01p48LM/lEQZTzyLDN7nzJJyM0UfOOeWKwt8NdEflJluU4Gr8OrYJZDVLOvuxUZBG9+8dVnTZ60CicpLQUIC5+mPf5kE=
Received: from DS1PR02CA0005.namprd02.prod.outlook.com (2603:10b6:8:452::6) by
 DS0PR12MB9348.namprd12.prod.outlook.com (2603:10b6:8:1a0::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Wed, 24 Jun 2026 03:40:59 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:8:452:cafe::f) by DS1PR02CA0005.outlook.office365.com
 (2603:10b6:8:452::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 03:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 03:40:59 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 22:40:56 -0500
From: Amber Lin <amber.lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Jesse.zhang@amd.com>
CC: Amber Lin <amber.lin@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Add gfx12.0 queue reset support to topology
Date: Tue, 23 Jun 2026 23:40:41 -0400
Message-ID: <20260624034041.78450-2-amber.lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624034041.78450-1-amber.lin@amd.com>
References: <20260624034041.78450-1-amber.lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS0PR12MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: bb89ff91-b97e-405d-27ad-08ded1a2680e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 8vGQyPHTt5jcYyx8NIIfV3uBOQ2TCQ/4QzfddnSXSm/i0rUuwRKxQJFqq3ZpI+1GA2PQtqTS5T6J2qPsqNSB1YMyeHbF+/coa8mBTXrOCT6zxzpokxuxnVymXMjwWgLakV7Nj+ZuRbMQnbKqyzUFW9YZH7OfbUdndmAMjd79GFuYRFk2rOFtSzDF5XSzJwnFItAnkFIG4jBMGdnL0uVXRSPWF3cRh5LRVHhXxePtiEXqU1kd7mUaHz5Itl229Jl5Bc6BjCjoD2V7P01P9ANh13LloeGzY/ZxbyFRgtP5PT0BVjaQfYE/jCpTcleaFZ3DpPofRg/S2dxx3CkiqZiYLJWXy2AeKZCV9bpi1ZfShpCh/iiMQQuAOO76GSsLNWiMUh50J6s6/zQYo9MdMSx4qzcEBNkakFGIPwVlY8WCQVZ+bGQa5dN3i/1sNxljxGCmj/SM/ny51TnA7Y9M03GHUyVlvDmjI7Boiu794LY/f+4lSuhJX0rjvzfCQKoeWK8hsBx86MUUOv4DodWxfW+ODzvVc4D53vTIC/lDpzBgmoA8zbbWYef4mppfC1+/FZElaqENZIUWwecWCCz7EYOr3MvvQ2708wO7z+R9aCUdAvOFKtihAd2BaiEx5CZy3UjPNtGz8nympNQ7mKe4fObgnsUlk1ByR6w0ZSJuxnIaCZTmTt+Y5otCSGd4xXANFBfCHLA6NJjwWiguaHeyuSwjuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Nqzltbv4pDsRuYSPrhcDzadIPov2D7UNDz8vakgLrWX7TiwVzZ0koqZgDfBxGoUB9YRQgFRTnzS+pkbVISuWFwDjjHMQsYBfJxmk8hWwREExm2yuvP8CPCaKz3SajazOnJDlkNZmTV3yMrI2nOTCPR6LA6AldMtj7FBgPVM7vk6ASA0/Uljz8FFe5ZQC7ZnmhEIndEnO6A4Ux4H1WVx+BAclNoHnWw4GstS8/mKL7Fm+OSUuN2Yk1bdOvXzYGUJckJs1DLlOwMNJedJNBclXHEfV2taPDL7FDoLNZymdP6Cv2XAmth/GcTmiWEn6hl1OroYWX8ou8hwsGHyC/7ogezhBIpygInitrYtojKUdDZHrnla366KnpqHjEl7Sf7VyphilRd276dSy7OFeuntYsQQzhzrw0wQCME8VFLNo67Ks+U1bbX4+4HoNjrVbvmI4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 03:40:59.2967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb89ff91-b97e-405d-27ad-08ded1a2680e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9348
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

This adds queue reset support in KFD topology for gfx12.0.0 and
gfx12.0.1 on non-sriov mode.

Signed-off-by: Amber Lin <amber.lin@amd.com>
Reviewed-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 1bf67b6e9aac..9997ed4e5613 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2020,10 +2020,12 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 	} else {
 		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
 					HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
-		/* gfx11 dGPU */
+		/* gfx11 dGPU and gfx12.0 */
 		if ((KFD_GC_VERSION(dev->gpu) == IP_VERSION(11, 0, 0) ||
 		     KFD_GC_VERSION(dev->gpu) == IP_VERSION(11, 0, 2) ||
-		     KFD_GC_VERSION(dev->gpu) == IP_VERSION(11, 0, 3)) &&
+		     KFD_GC_VERSION(dev->gpu) == IP_VERSION(11, 0, 3) ||
+		     KFD_GC_VERSION(dev->gpu) == IP_VERSION(12, 0, 0) ||
+		     KFD_GC_VERSION(dev->gpu) == IP_VERSION(12, 0, 1)) &&
 		     !amdgpu_sriov_vf(dev->gpu->adev))
 			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 
-- 
2.43.0

