Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD06CD6E57
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED3011120C1;
	Wed,  3 Jun 2026 16:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aD+Kn1OD";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012039.outbound.protection.outlook.com
 [40.107.200.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 293F11120C1
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRT6zmIznulOnrxHMmU36oEOfofZdXeL9TFaw2ELMOQZMGAlNVjO6oz8zFFzr+u54MDVXPW/WWyHEvN77tJK3fHQ38f+QYWKQ7rFKSWOtbiAgQkFm2GsJzl25aiU80OfY0MTyGDVvfoNiwFQUou2MQn0FVpF089nde2fK9e6p5UyvowQjnUCgOW8R0wUSpgL1ppjx6IjmdY6exA/7YHPDGheIYBLZd/l2rdwZooQWd9cd8TIfROzt5R2RhvpWIQyo10NWAwITvHI85zqNYEl80hufR93y8oY5K38c83diQ5/PjgHfkRLJEIKnVZhMeQQIRSEYi9ZNmqnF6LlQ+oQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nfqy4tQgwf8DEhfQez6dCYm/KU+cJCnQalnqLYZgGOY=;
 b=nOtcxu7f9ZcCrmiHSwjADWFC0BL+UZOlzDWHUM6r5Lk5s8azKooDjFgzYhx7Ku5vfwNoAy+YCf5WGvGPXhigfaXWm036/AoYtzWVRidj43m6EFXjc2umwQHM/ZLav6EIxuJJvBhUANawVGsP+FiB4p2bEbKNy/R0blmIhE7A143Y7qZ/EWbQaZeoHX/8Xy6y7p7BThPuV/Ox3wvzD9OQIXUmRE4zfIlNOPzs6+C09RHst0+kM4dkdx9cR71Bva+CMwoqyvQbiLugyaqIEIh4RJ/n2SDGDBLb8Mnq680lBcxvfaH8l7ybN2VJl+c0rK7wj8NZUWa+pFiic3Es5IhAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nfqy4tQgwf8DEhfQez6dCYm/KU+cJCnQalnqLYZgGOY=;
 b=aD+Kn1ODBHR6wpAKasbfTgKOLBUpQ/9wFUUyeviDf0dliQ44i82BdvcusMYZr3vSjrRjZLvF9M50o2XTRzga3wWokX9iQ7O5hxGRMSz/mnk/Ue9C+Pcw72fXx4F0M3IOXkkpNCXylm4t3TUsfswEdFTvt9X0QqAwIKhPeVgMGLU=
Received: from BL1PR13CA0353.namprd13.prod.outlook.com (2603:10b6:208:2c6::28)
 by CH1PR12MB9648.namprd12.prod.outlook.com (2603:10b6:610:2b0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Wed, 3 Jun 2026
 16:34:12 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::65) by BL1PR13CA0353.outlook.office365.com
 (2603:10b6:208:2c6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:34:12 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:34:10 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v9 02/11] drm/amdgpu: Embed eventfd manager in amdgpu_fpriv
Date: Wed, 3 Jun 2026 22:03:41 +0530
Message-ID: <20260603163350.2678309-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
References: <20260603163350.2678309-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|CH1PR12MB9648:EE_
X-MS-Office365-Filtering-Correlation-Id: 34942b92-6cc3-4a21-a113-08dec18df1af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: JxUEHnTo9AA9N+GzIG4eL/qSNjZuYXYwgrkI3IusKJdhtEgDjfKIOj1fvmBVrMYekwK/MlwG1laxPCaxKe3rdbHZkyYhGiqOdlD3DPk9RJV/1UEMG/na4QMA+MMdbfZnbLKkZpASqurxDKbmAqySww0mt0UtXoaXAjm4bABThGRCWgRIfoXiVUyXj7a7x0WYX/w4bwD47MEmAr1wnLroDtHyGedjet9iddq+8B1cVo46qzR5Gwenszm751D/pHesEEFll5yhqeyejNQZeRghvCK29vnksYaZCSaMXkcXfW2suNU0+HN9BFR0CY8vKpz9IbGFgbv2fVwbvXqxLw032SXT7H0sRf30YqAUaT6jFwJmThpzWaxpYBcrjt4eniNDOnQmknllK54jgXvhUT7orSR/NpFyHYA0oMjagldb7bDbNnOMeelS641L7lP618C5xbANrA8M3G4CJGbKoWFu9qtf+Ogq+tX5dxwvE3AqAcY4prUcadzgyxMcyuk6PS7IOTAhCMqgKmYU0qrskSSu4xuCj/0GvcurG9D3rSh7fzts/ds3A8P7Crsswt51wobZjOA0UYA/vNrZbtoWqAWtDcon5pPTbVQgykH+I+KU6/RDD4Wk6q2WIQCqjKGLhhJ8HF95ulr0aPOdbN3WQnrlZ5hfKXlx452bRSoyS97mBnTp/P/wRaluPEEAom8hy8E96ybMy1qyJMUxgiWugvc436p7Y8if49q4trDk08IGMU8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A3fZxeiZEicFhrevfXud1hn8VDPuzimq+oJasnMIX9J4tStn2LCH0wATQD77ljNHgTZ6jtW9m+tt9g92RdqRQc5ufbxm/317Am+aMClVs5FLCD4NFdZzwAZe3ayb/5ZW0UE2ATPF/m0HnjNlpLFf7eb8wk8PquZ9UJ+RGRrwNluH3F0lw2DiTUjlXsMRZvlzcLOZqUD8XuH2DRZfHJODUq+agP9qC+avCfKuEBKVxN5zc61Dfs7rbEbW+h7ce2N0cCwQ1qphzhFPppbf9HIIdC1gzjmnS+59CLYyliulx4VzM0l/LruyONfiKE/1L2a6h1+IEaObc+YQumbS0NB5yi46lnEvqaTOs9XzWq7ZLbsZb7rLcI6W5hikJHI5y9yHUEaOYE9TYhBbVUdWEVdxh9IgZyUJCVhmHPFv3aZAYyX+qPdFtWCo5pUzcw/p8hG5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:34:12.2116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34942b92-6cc3-4a21-a113-08dec18df1af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9648
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

Tie the eventfd manager lifetime strictly to the drm_file (amdgpu_fpriv)
by embedding the manager instead of storing a pointer.

This removes the need for reference counting and avoids destroying the
manager from IRQ context

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5d7bfa59424a..a75c68195df9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -104,6 +104,7 @@
 #include "amdgpu_fdinfo.h"
 #include "amdgpu_mca.h"
 #include "amdgpu_aca.h"
+#include "amdgpu_eventfd.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_cper.h"
 #include "amdgpu_xcp.h"
@@ -455,6 +456,8 @@ struct amdgpu_fpriv {
 
 	/** GPU partition selection */
 	uint32_t		xcp_id;
+
+	struct amdgpu_eventfd_mgr	eventfd_mgr;
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 24526e92f9b8..f5719500527f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1460,6 +1460,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		goto out_suspend;
 	}
 
+	amdgpu_eventfd_mgr_init(&fpriv->eventfd_mgr);
+
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0) {
 		dev_warn(adev->dev, "No more PASIDs available!");
@@ -1556,6 +1558,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (!fpriv)
 		return;
 
+	/* Drop all subscriptions before fpriv goes away. */
+	amdgpu_eventfd_mgr_fini(&fpriv->eventfd_mgr);
+
 	pm_runtime_get_sync(dev->dev);
 
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
-- 
2.34.1

