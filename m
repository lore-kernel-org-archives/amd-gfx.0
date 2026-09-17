Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B4CC982D0
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 19:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5AD610F0C0;
	Thu, 17 Sep 2026 19:58:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZLB3Af+/";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012009.outbound.protection.outlook.com
 [40.93.195.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0295B10F09F
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 19:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=md5Z0QvigNRbtHvDNs/snxn/mrvZTrlhNinlD3WJYdUBVcdGjibjwStBj1VCgQP63Gln0+Os8XYsULpPZs8o3jujdDJa498ktTl/vF8kd469gUI/UzD1LMUS2tuHrVwwAM88hjG9Q3vGUusmjYoTT1NLbV4mDGXCgmCaPIJZ+O8bAgyHQ1CGQ/VIbhRaiz3A9UbV0haaFexjS5uHoH8/wCbSoGtikoDI/2fz8a77SIL4QAlfpEKDCDa4qrlZ5QrAiBYVN+0yPxMAEocp5axb0jDYy/KioUezx4Hhep88YoNKDhBUeEydyC6s17kxiwbLtvgu83GlTtljUYhXn7nlEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+P1SOAvgLY0+4NwCmMjTLTU6Z6w8ot8D8aFLB7BfcI=;
 b=OcV6ZNEyzW0RQ6nDkgHLE3XDpccbzZ0axh6AMVrYO9HZI/VFdIEnhQxblnc2WXEaj9969Arg+zpUZD7YypXbim9f5J0omB6AffWYusu5wwt5qgddISmDYcHe2vAbcRn4nxEwjkWT2Lwuf1h5QQyq0yRCsmkFTRg8T4omdDa4xd7bvLdKUhAqxRcFf8DZ4GOIey7wqMKNAu4hK+J5r7isYTxdz90M8lHN5P9HfrxhdjVcf09We5tsC3oyQ/0+47pkerKk5OvWHh2PPSDx47OSr88idACZSEjHRbuuNjpoSAlJmE4sELqxUiY/CGUBHR2hccWjek7NbSWDjI9tVjXi0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+P1SOAvgLY0+4NwCmMjTLTU6Z6w8ot8D8aFLB7BfcI=;
 b=ZLB3Af+/ryIcrn3vNImf65TUmFdw9kz5eMJ66FbNxO1vwsVfGK8AY7+1VDDhHJtCDef84yixqx2JUuaCnOO36lD0fIFSi+UDfS46SFOZcekg6EQoQYfYVkN9kedJErvHNwFXyMHbuA9jtU0RsykX2SXrq0y/F4GI4eEwj+I8L+g=
Received: from MN0PR04CA0028.namprd04.prod.outlook.com (2603:10b6:208:52d::27)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 19:58:30 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::1c) by MN0PR04CA0028.outlook.office365.com
 (2603:10b6:208:52d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 19:58:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 19:58:29 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 14:58:24 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v2 5/8] drm/amdgpu: handle runtime pm in
 amdgpu_gem_userptr_ioctl
Date: Thu, 17 Sep 2026 15:58:06 -0400
Message-ID: <20260917195812.72917-6-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917195812.72917-1-shahyan.soltani@amd.com>
References: <20260917195812.72917-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: b586bc9d-758a-4f8a-982c-08df14f60bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: luVbDTCULeTCubx15VLhP2d84eHsyt108sSCPvqrw4Zp5vU1aWRuIU8OfciCu/gmG/BlfSeqgRDPolj3gGUaQmgIEOHAv3D1BapmpeudFErDwF+Ng276XlnyCUVHI+uEMvekwgKuVqglMdLVAS4XSYQmS+RlO5J/d4d++WOgEdfBAoHh2iBiBSgOAxlvkYSLctfnnu21WS5q1ZuEqOAkx5/To1FNrzBiZpxmWUsTs8VAgzSjE9/hKTcCAwUuel/9ppoZRcNd2xlAYqZcXzS38eKnNyy0/bItBLx8aPHyKyXoE+y5Qwz5zvovkeoL0bUzmOf1q/DtrQfqwaBM1UxHqyyt2pzhxyE2oqtxxf8UZBKlEL/ssHJzjVMlyTrKMxTHrvzCqcXznwVfnvHDshkJFL6J+OX9/Hnuku2QC6zdrwMC3F4hUb632kcLJnE6KrHFGI2WfjJmNsemyiB6ThESH+46B4JEZDrsHsmKleG/vk9xkLsLq4eFTLHkec1dDP0X5pma7Mg41cJBm6daUMZvRkWazoQt130xIxZxl1FrCiRDnzh75bkwWkgvtxt2AbN90cl/9BCTHOm5TOspxU7aSyY6uhYp7a85WXVXPOB1W79Q509XlqBD/0vhmtCi0lMvm/j2jwFwwMjBPumpPFdFOkQUOs9DYqzEvwFFFyXuyuNOasx/BmVTvbULRNg0UbX4dMMzUOmYJGnii2Nw8HczLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TA4fZGkz0AOuluI9saqIRpReGMCSW2sRwZ2ubkiqfQ8ZV3/ZkkZs5Gax8K/Dbs3pVXqoEr3+Nbte4JH7oVRp0gs+gbd71deZrIzqUP4lZJP9iJZGy+EMhIIdHWACPkPs+hCzBEBkisMo7Z2jIDk7mNRLatQZRwS4cCiViGSmddyPqH1cmsneFc+bD7uKg79ju92pnGaAak20wb0dX6GFZ39FVelIgF8li+Q4CcH0fzdwsd6o5LLx+OdA/PDRVpL3yB+Mq947dYufjZWfJ/rcbcwXSSsGKZSZ94Q6PR0j4TLiGLrMxCkKf1tIZV+neZgD+Btpl7KBj03rgrCbK/BMzPZcCElng0rvPfKlG6nN1v3VzNsZTDHd9CvuC1upRVey6Gx5jNGwUpAmZaVSyRkO5FCdyhgn/gjeCwwrKynHeqZaytiJXtD7BBZxdkb4bpfb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 19:58:29.9994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b586bc9d-758a-4f8a-982c-08df14f60bbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395
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

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Wake up the GPU while setting up user pages and validating the buffer.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
v2 (Shahyan): Added commit description
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 6edd03647c2d..e54d30f75b2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -594,11 +594,18 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 		if (r)
 			goto user_pages_done;
 
+		r = pm_runtime_resume_and_get(adev->dev);
+		if (r < 0)
+			goto user_pages_done;
+
 		amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, range);
 
 		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
 		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 		amdgpu_bo_unreserve(bo);
+
+		pm_runtime_put_autosuspend(adev->dev);
+
 		if (r)
 			goto user_pages_done;
 	}
-- 
2.55.0

