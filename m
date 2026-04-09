Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79326EA3C4A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 10:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E0910E791;
	Thu,  9 Apr 2026 10:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t79sRTX9";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013058.outbound.protection.outlook.com
 [40.93.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF04B10E788
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 10:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ho4BX6UdUEU4EDW6IsZpLq61C0Ep8XhzGtfPTjyDMWLpwbvsEb6es/uuc6JBM2NZHBtss6dCP6prSlxHcOyM4RwgikWYfKM6tJQ5XW1OhGJhi4pJ0WomdjdH8DTAl0L3gJfjo0LaiV7nk3498YEGsO/XE+7mo7NjPvcpl4Qoro0ew+vCSzf4b69O+Rm/K2Hl9i/NWrF9/VsRv03GCjagSjGWr9AdVNEuL/TVhijIkJ0byPEADmNSDf3KsLmoP1IrWaYQEb+OIQPFlukNbVOYX6470ukfZY7wnVnTfrvfaiaK9aHFkMzL7hN52cLyLjqDZPTytcPEGKWmsPt0NXWeyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4S2oI5t1x3x4HDhn4ZZJ+BxdkkS81wCDoIEz4LHXNI=;
 b=k4BK48VhZCVjp/B+GMIC7fI8VW64SunNhVYeWRe2ubm9TpQU+EGBuAESxfi6LhHLw9SJ5UQkTEGmwYO21t3I8i57zB0JfPjRzx/1JiERFl2SDarqArQGUIlrAr/X/2sxuvI2R6zVmizFWzHafNVYKjbfM62RPWc0nZiZrIE6P1bYdCNqlhhfo91VCbwBptY4HnpIo93GUxK8e+1q+QvUc7BJxhPV5WMK2UmpBhddZT2OZudx+lzmgixt/2XN2uuJb5x6q7J0xF/qlZc4qzMcrEo6lUFt6jPhzEEb/rIJRragxZtsVslsuoZF74YP2vbyR/9oA2YIwutJA1no36kniA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4S2oI5t1x3x4HDhn4ZZJ+BxdkkS81wCDoIEz4LHXNI=;
 b=t79sRTX9nIcV9s3+g5HJntjWRavHU0hpcipFYlHodJB1OYdpvZGibwLQjiTXvXFsjvdrkxXwrlxWdc1NaDzszYfd7tswO38CnTT++xnojJFYHolcZadb+N0McQhtfub65ndboh5DYxqVLG7IDLfCDtiv4V3yHzjNaJdHgy/NAT4=
Received: from BY3PR03CA0030.namprd03.prod.outlook.com (2603:10b6:a03:39a::35)
 by PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 10:41:24 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::c6) by BY3PR03CA0030.outlook.office365.com
 (2603:10b6:a03:39a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 10:41:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 10:41:24 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Apr 2026 05:41:22 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 3/7] drm/amdgpu: Wire userq manager to fpriv eventfd manager
Date: Thu, 9 Apr 2026 16:10:53 +0530
Message-ID: <20260409104057.2284155-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409104057.2284155-1-srinivasan.shanmugam@amd.com>
References: <20260409104057.2284155-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|PH0PR12MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f922cc2-a173-445f-b4f3-08de96248c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: K8FMeirWUcdZdhGDtXr4tEMjcsajQpmKKbYNHF/r0SNO6D0Z4SKNpCWFaXalW3XV0jDLkOQABH/iWFEyMmzUknMNUijiY2p80BsBvP7RPNO4VIx3ctsy7m62jvER5Y+9oVyXWlOrFAiHLtaffoDp/N5J0Whhk8dFb+FN0fzP9Z2/1U7r7ObX1uMHDBBaJr2VSJg4EH1kzX+eH9xs+oZSFnu4SSn1IIdgcJitrVwilbW1pN5K8VgoaDfYY9BCLGdQw8ab/axRSt3HGcJLeCSg0OiwI5SG+wN9WQWfMMQBy8OXm83vVvNIVeJ8Oj+z8+vRn8N2pIW/MUJfnsId7jIi5+mf+5pApmv8LhUinWhJWb23xHb0Yy0VqRR7sfMHzAVTU9alLpIE4J/jnseTjyinlXSZB1XSrbqmiy7ye5he8bLJg0t2vca4vXTDVItwBnKiA55tprOE1m1D5amKKVY/m1b2F6i7hkQ/yf+bcH9mBH2W0UD84pcVGjl10K9gIWz5CWlYnlANLuiZDvsbVHHqFhRPDJ+6mvzhomwPWnXO852xbioy7ydnA3pNcaCgSm8zmPuHqCffEIGd8fTnRgCOafl7lWYgbqt2ZIKwLeDNjMR3c2azZYpH/lbVzbGc3bZJDhBsNZLCBap3mjLV64rPll5SIWunn5XF0ftEhBsogt0mI5S9WFhPk7ow8fTaswXUpIUkM4k2s3aQzVyCShEF7K+8rqw5LhcOK059zhNdis8q70JdS5Rvuj53os9kB5Tfzh7hr/RGvP8+P567vXYvXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MEQpVfYJRTl1RU7sZRJzPQJhZI0QWH3D0QGrX/xkj69s+9hW8pd2QdVB/B/kOnPz7gLq7WFnjPhojmonbfXXBUIVtITK7HPLqsd+9O3h3fcJxoZOgQ4sOxJCxm1+IT94cpCwIlxZUCkh1hRSK7J3pMzqHKbuoGQvTPR2PXKPU5//qsD25C7mjASNxacUrdYG3NTIx5b00OvO3hApfCqt970jFQHvgx+ANZbxcUkkO4QVOQOSoq0UFoH1y1sTNd4htLGpPJYDuwu+owg63EjhnwoXLzogIKW1YO8fEocCwz/zmUyoDZW4aFhi1Z51ekACwR6s/kP66eFwiT0K88Nltl6mDAXlK+eVJ0FfPRnOMuR5x7bImPcAPVYSUU2WL01wO9HUpPMviv0u3RAxXcVOt3wpJAkuoAvNTHSW8etIIr2rP+W2zFCYGWl34+S+oEIH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 10:41:24.7027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f922cc2-a173-445f-b4f3-08de96248c33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632
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

Store a direct pointer from amdgpu_userq_mgr to the per-file eventfd
manager embedded in amdgpu_fpriv.

This lets IRQ-side paths signal the correct render-node eventfd manager
directly, without walking back through drm_file -> driver_priv.

The pointer is optional and may be NULL until the manager is initialized.

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3a6e7a569c78..319048558aad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1298,10 +1298,13 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
 			  struct amdgpu_device *adev)
 {
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+
 	mutex_init(&userq_mgr->userq_mutex);
 	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
 	userq_mgr->adev = adev;
 	userq_mgr->file = file_priv;
+	userq_mgr->eventfd_mgr = fpriv ? &fpriv->eventfd_mgr : NULL;
 
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 675fe6395ac8..8ce039eec2b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -105,6 +105,7 @@ struct amdgpu_userq_mgr {
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
+	struct amdgpu_eventfd_mgr	*eventfd_mgr;
 	atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX];
 };
 
-- 
2.34.1

