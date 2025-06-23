Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39979C7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 09:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D3A10E1D8;
	Mon, 23 Jun 2025 09:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JUv4W6yc";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B987F10E1D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 09:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwsKSLYmHIguDyLIXJMZaahI5PLCjVBuoTv0HAXaKeC3q5F6uOy0jpiZrx76pRIZ0R9UPL6RKrfL055Pev648XB51moC0SfziTHZtj17F/RvaYxIQz17R2ft5X+Z76GYeAUlVdNFJle7tdkIylBMfF4kPiy5UEVTw4JGKlx8vTOG9C4xDtAopc/apdQWXyRJxWs4YGboVFCTjeBdamtOj8TTe+nux37gRf+opyGoNDQ2I+BZ8jUlkxOB7Cmaghgb3I+9KmNHBZzPntWJibX8ryNE4qmJI3dPGjPFdQtCkAqob4CcSYI/9SjlRry/VfRcVBgm0uycIpKKHagLP6Js3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyr1wwsyP3RMr/BTCOnP4mBNcZuqNA7WOZWeBEj7lts=;
 b=Lpc28x/hd+d50eOKNW5qDOoUPdGAakQdY/QCxnTHreuDMFhiDSFCFbxtcGxyC+Pu1apuYVsI3QZDx8xe4yzpBBlWYof9KXkn5PrfQrvZ9Nc2lAFhLGYU3q8Gpns1l0YWRjFH4j7qJCifXEyJBl69gd8Tj+OY4oUKKhtJ9bJ0BeYxGa4l+UToddkp5crd64+jsNEwXYYYmTvylzV21wCFpHXLQ3AsIk4fAxc2mlWXn2SvTs2jc5+x/siJfa4yUrzFJhkIl0rfinIwU3mGmIPooMPftemitm60RpFxL8flXvsJKnSmTADoSGrJeaQ2nBJQGBGMiV6VDhDMNK/53Z4csQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyr1wwsyP3RMr/BTCOnP4mBNcZuqNA7WOZWeBEj7lts=;
 b=JUv4W6ycuymO4v1McSbungaXItR4HWDdyOrYGQf1u7+fngPqI7j/EQPRlgZ4Cgywt2ZxouvXzLMewgFaRdVpK31RstGE2/BV2Q9yuWuMUV744+5d9pJW7ZOVMTRkCy6nQvC7h7n6DSltWVP4Aad4ryNclC0qdRtE7ldqloYtPLc=
Received: from SJ0PR13CA0035.namprd13.prod.outlook.com (2603:10b6:a03:2c2::10)
 by IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.24; Mon, 23 Jun
 2025 09:04:55 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::90) by SJ0PR13CA0035.outlook.office365.com
 (2603:10b6:a03:2c2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.15 via Frontend Transport; Mon,
 23 Jun 2025 09:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.1 via Frontend Transport; Mon, 23 Jun 2025 09:04:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 04:04:51 -0500
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 23 Jun 2025 04:04:45 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add user queue instance count reporting for
 gfx12
Date: Mon, 23 Jun 2025 17:04:38 +0800
Message-ID: <20250623090439.3811614-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|IA1PR12MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d391133-83f6-433d-612d-08ddb2350567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0hyXRfTS0FVOJ90ZxKLNpU4Xdx1sdC98ROiLj7lc/gIWkX66l9tTFnitLtpJ?=
 =?us-ascii?Q?ft9YO6jd15Iv9xGx8AxyaKfSiDB2g15gEVT3W/nTmgT+qGeBxa0DIUsLDdfA?=
 =?us-ascii?Q?Mvwxf959z0sUulNLz4F0A+oUxMukjlvGTU5J4Uj7TiZTsXKXl5l5KxEjNPKg?=
 =?us-ascii?Q?JEWfjwJNLjkH4FRBJxhJ/jUMN24ry8jXutZF34Xlg1/URizJyYtTbHG3tQ5+?=
 =?us-ascii?Q?I8YO9oqCDice9RllAyJW6a3oiFWJhUSQOaQ8+gnrbUuN98q6JojQPr/Z0Wal?=
 =?us-ascii?Q?W2RY9z9e86iJZQTtgySHCT0ZRR5Gx89jfXPsc5YaMtczGliZPljkcI84rHyt?=
 =?us-ascii?Q?81DI5FYC9yo/eUOU0HTwEK1f/+tODl4no/mK8tZzJnGzJYoSpK4kt5QOAW+5?=
 =?us-ascii?Q?n3n9TJQ4AMAzwVA1DDo4SxPtmIn8MbHVrT7crtOnTJgA45eOh2+NT8Eiv5ir?=
 =?us-ascii?Q?zY4/qs0iaXC1gqn/TPXyQHBcZ9PH4R/P0BTs4hp5l5MhATszImo77dlAvcAR?=
 =?us-ascii?Q?boX7RwLHsLKAvGuWS9058uQIxJhyczSHbncLfZJWDJoFnXN/A++gMrahyWZC?=
 =?us-ascii?Q?lugh0ZdmDAqjxFaYvUT6y8ItRvNQuBrtCSICf92b3nkbL4mPpcDEkLEtTsS/?=
 =?us-ascii?Q?EJIvIih5noRxYiXbn21Oxr6ofLJdWI4WhRNeHdgd3y3OrzCF09WedUo43c+L?=
 =?us-ascii?Q?iswGftG4qXKL9zghQ+QdHkTTP++WDirjnTL6YjPDw0+uF7LAsbjhiBrJnvfo?=
 =?us-ascii?Q?p4xZF5NiTUgJXkbQ9nLoMm2C0J5ItUOzm6RJPEFa01XfCeTfE8Hk3l/Y7auz?=
 =?us-ascii?Q?L02l2Kvwyb4vZEm4kNhsDljJxhsXyh6RJQZxfHDLeolAXTampqvy0aPawoZD?=
 =?us-ascii?Q?wIIPHosfaeRDS6u8WfGr5yqUf1MZDFw0AGW8j3OSW5gtXd792RzAEgo4hxSE?=
 =?us-ascii?Q?15aEeZ2yZx9eUVb2dMAszvU1Z24xid/f/eEDuehycPCRB5Ytmm7KaZkUp49F?=
 =?us-ascii?Q?8wOntniFpU6Bpxp4Yww/NfLdzrZDV0aU7Ecsy5aSEikUtMasfOO0y4L2W7TK?=
 =?us-ascii?Q?n0iz7xva0e5zoxAa7UbSKhlmzX8gSaDwDhjeMg0NPPL3YkmY1QYxfY49BhvM?=
 =?us-ascii?Q?jGDfL+RHFUNuOXqReCLNYofbhGsUDpB6teox+QHNb1hiXVge9FfEwfLdvucY?=
 =?us-ascii?Q?LEmlIFKuirRaPPVeHYQwWEnycCNuapltCTN9uipmYt73nJ4iQ/oKEzcH201U?=
 =?us-ascii?Q?T43UWEZD/6aYCTHleD1PWNHaYYVarriSQ18P8iy/2rLR3q+obC9rJCZecf1a?=
 =?us-ascii?Q?QNwjwBtTkJfQttMNPH6AfU/inGUS4nbEUudRcAlMbFApzeTnB9eu1Nu0ph3a?=
 =?us-ascii?Q?gTiVRyDmN0V+wVvE7iO45crgUKkX8HyzL4iIXoewKf/fVLQJRHzQit9mYzsq?=
 =?us-ascii?Q?dql+xEKv4NFKCf6DKxJU0tUMU7uSKxHc1fUZ7a6Q1JkLbKzT91o+DG0v8XZY?=
 =?us-ascii?Q?YC2/aRoEti2tFU4EgyEJqC0ODcXqm7KqJKml?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:04:54.8797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d391133-83f6-433d-612d-08ddb2350567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524
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

This change exposes the number of available user queue instances
through the HW IP info query interface. The information helps
user mode drivers properly allocate and manage queue resources.

Key changes:
1. Added userq_gfx_instances and userq_compute_instances fields
   to amdgpu_gfx structure
2. Initialized the values during GFX IP early init for v12
   (only when user queues are not disabled via disable_uq)
3. Exposed the values through drm_amdgpu_info_hw_ip structure
   via amdgpu_hw_ip_info()

The values represent:
- userq_gfx_instances: Number of GFX ring instances available
- userq_compute_instances: Number of compute ring instances available

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 5 +++++
 include/uapi/drm/amdgpu_drm.h           | 2 ++
 4 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 08f268dab8f5..63a7f0e0db5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -452,6 +452,8 @@ struct amdgpu_gfx {
 	unsigned			num_gfx_rings;
 	struct amdgpu_ring		compute_ring[AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES];
 	unsigned			num_compute_rings;
+	unsigned			userq_gfx_instances;
+	unsigned			userq_compute_instances;
 	struct amdgpu_irq_src		eop_irq;
 	struct amdgpu_irq_src		priv_reg_irq;
 	struct amdgpu_irq_src		priv_inst_irq;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 195ed81d39ff..ff05c82a3dff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -411,6 +411,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->gfx.gfx_ring[i].sched.ready &&
 			    !adev->gfx.gfx_ring[i].no_user_submission)
 				++num_rings;
+
+		result->userq_num_instance = adev->gfx.userq_gfx_instances;
 		ib_start_alignment = 32;
 		ib_size_alignment = 32;
 		break;
@@ -420,6 +422,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->gfx.compute_ring[i].sched.ready &&
 			    !adev->gfx.compute_ring[i].no_user_submission)
 				++num_rings;
+
+		result->userq_num_instance = adev->gfx.userq_compute_instances;
 		ib_start_alignment = 32;
 		ib_size_alignment = 32;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 1234c8d64e20..482490783a0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3852,6 +3852,11 @@ static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 						  AMDGPU_MAX_COMPUTE_RINGS);
 	}
 
+	if (!adev->gfx.disable_uq) {
+		adev->gfx.userq_gfx_instances = GFX12_NUM_GFX_RINGS;
+		adev->gfx.userq_compute_instances = AMDGPU_MAX_COMPUTE_RINGS;
+	}
+
 	gfx_v12_0_set_kiq_pm4_funcs(adev);
 	gfx_v12_0_set_ring_funcs(adev);
 	gfx_v12_0_set_irq_funcs(adev);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 45c4fa13499c..8082270a7ceb 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1493,6 +1493,8 @@ struct drm_amdgpu_info_hw_ip {
 	__u32  available_rings;
 	/** version info: bits 23:16 major, 15:8 minor, 7:0 revision */
 	__u32  ip_discovery_version;
+	/* Userq available instance */
+	__u32  userq_num_instance;
 };
 
 /* GFX metadata BO sizes and alignment info (in bytes) */
-- 
2.34.1

