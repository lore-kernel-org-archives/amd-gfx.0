Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F360FEC01A1
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 08:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8433810E0B4;
	Mon, 23 Mar 2026 08:18:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P6lckGHc";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C0F10E0B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 08:18:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgkHcLV/7YdiKjJfWPsNigcqVIdhnLVVQMv8ZYrS2EijBeS46XsLAwVMccT+7LcGoaV+FAEpmwpWU6+QpRtzT9cTJA7Yk7BRo8UXxXwKmbbRL9tDSHxp+Bvmt8xy9iTWpwYV4sUC8POU2Ho6+US0w+PmqYRouk5tltGJzJg2mzXAThefKzgSvAaWLZ9C4AYMjVTj0W5wHa424+VIlwjz0qeAfgVi7omA6DxmqVqXv3/uh010zsA4TUfYpePhluR+RVz54jAdz9GAgmCI7kaoUn8FNJz+ujT9ZOKRzzZinJBWEmcGxKUjcE3ZV4PEP3n9zXtSgTG4h9/lcIyGk0oAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaivA72y2WAYNSTzWLJJSav66EQS7PrH4KAkYQCXcII=;
 b=vTx3B6BJE+DZ8aJ5MJ/ferAitNyU3zZh9nHmcg4DIx56Rl11YyDP0kl2vPMWKBZ4z9qy/9l8FlrMArxpfkPCWbiqOc8ioXMtttnUWAIAGDROidkSBb7ADQ45EF4Sz1AL3K5Zj5ML52/spYXGwAp/2zSyQT5bBhkZ5figu+tz6dF/RmfMBBq77AexkZw3jGP61uQBHwC3gL7FLvuKIiWVEEWTNNX76RV7SsPr9+jeNffELXoAPCcs1s4LkRUUesQJnzFxzFcE1g1Az8HEGGa8ciYaChEcGnzYyysv1l+D2qcX48qoBppaWsCYo6ssi8/WFNY3pX+CQH2UruqvDQdTmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaivA72y2WAYNSTzWLJJSav66EQS7PrH4KAkYQCXcII=;
 b=P6lckGHcsLnUdLg9RU+le7hOhSYidwG9vdEopcvF0ssBMO60Uf6KO8SCSlxuBVtsJZEfgHBBLQFCsdndrHYk3itcwRwUrPq5kStIMnrngZsByL0/JN9iaRls0FPRXoe357+zdPW0OeyIBsU6Lr+2l+yD1XKt08xyx1ORTvd6CdM=
Received: from BN9PR03CA0653.namprd03.prod.outlook.com (2603:10b6:408:13b::28)
 by LV8PR12MB9665.namprd12.prod.outlook.com (2603:10b6:408:297::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 08:18:25 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::b3) by BN9PR03CA0653.outlook.office365.com
 (2603:10b6:408:13b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 08:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 08:18:25 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 03:18:22 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "Dan
 Carpenter" <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amdgpu: Fix fence put before wait in
 amdgpu_amdkfd_submit_ib
Date: Mon, 23 Mar 2026 13:48:08 +0530
Message-ID: <20260323081808.2046632-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|LV8PR12MB9665:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ff27aa-5d41-4190-cef9-08de88b4c141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: PE7oqjX3UyxkRKPZVkAzq5EFJa1LyYufylrnOq1gZTd/+Nk/MA4MTVzyX5u2TR7HleUcF8DvD9+wHuzqkL3UtHCK1VSxRlQdZlO3pdHVk2CmbilMD6LhR4waNr7w4eFcldRzpFI7oh58ejWBkn4Ldc4tF7KQBq3CNvNjqDgUD2kYJdbqJyuej8wqgzHWYOJtnSHgU2DcmJd4R2fZZHnp08PONEPQi41jyAC/hGgTQ745nXbishvB+Ea9mhLpNmVkB6ZW93nGCckqBGOf0aBztrp0yqxQmaeR8K5pLZXTy4CgSeOiOaHU42cKmJoJvB626hl5ZKcuzX3EB6TdJx3tWTx8bOTtbooYBlVegTkWpWcA7Sjk36bbIaxa/d2wl2BAj6KHrfqf27g7MfqEITuqq42/e8ofWe0K5JJK74Ptk/Qg8efUI+mDLEn3K2ooS6jvcdTCh5R+mAPAPt3pWF+yiNyUmT3vRUOWMHvqdtYrrI9w3I/+9xUTKab6XpvxouYAOkOf13rnKrNjI1jUDoiItwmoQ/iaP1En4KL+LvYn/CecVK9ZfTbNyez6tDvGq7jsV5dHo0EHE0SVMjwWkr5U5mzpR25dkmqS8hYN77i3pLDbHcTYqhidLlN+0PIv9gVRrN3hQRFCoELfj86GSeSwHNZI8d7rCCMC237+96zI9eDDRLZ4UEz0anTVUK/191QDUuXMwuUuPiE6WO/PQvbleSYEd5+jfV+zEXCPAfPkHEQR3hGAsTTAx3lEoK87piGPWz51DHg09kuHIs9vUkTKDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VUb/10QRDyjFpm58wZmNECl1ofnyBw4fkMDTwLwNFDZvcbGS7LE401MxZ0rsGjtlxP6QSxw4VGoPwyyh2fFPiPRvnR45hDSScIJbJ3EKzqfOmeSyOmnhJWD4a7LOLRoFS47lY3iTp6NHiXDJHZeimkB88T5+2eTTTnlAbP2tKZIvr/Iz5YbVKbPtw6PaZXN6mRrcUvFBuZG9LLOLOx1IXwxcQ0lB9ICDWPk71duFC0vNs2/J6pqIpHMDJ+aIbVhjIdAN15V5AEmlkdOE7FR4KZAdZjLSKNHaksjqgu6OktoI1vn9MbqATRl0wSVpUJZoO3ma03VmJqsgTvkifgVA9yhSjfywegiLx7Oj6+QSsXlmP71LP6qFNVEpQ/4Gt+Et7ILISXAniJnwjfxzWvWtO6YAE2wTzIHnm7F9NNBji9AwA+8r2M0SxVnxTq8o9NqW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 08:18:25.0567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ff27aa-5d41-4190-cef9-08de88b4c141
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9665
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

amdgpu_amdkfd_submit_ib() submits a GPU job and gets a fence
from amdgpu_ib_schedule(). This fence is used to wait for job
completion.

Currently, the code drops the fence reference using dma_fence_put()
before calling dma_fence_wait().

If dma_fence_put() releases the last reference, the fence may be
freed before dma_fence_wait() is called. This can lead to a
use-after-free.

Fix this by waiting on the fence first and releasing the reference
only after dma_fence_wait() completes.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c:697 amdgpu_amdkfd_submit_ib() warn: passing freed memory 'f' (line 696)

Fixes: 9ae55f030dc52 ("drm/amdgpu: Follow up change to previous drm scheduler change.")
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 3bfd79c89df3..cf6b8581c969 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -692,9 +692,9 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 		goto err_ib_sched;
 	}
 
-	/* Drop the initial kref_init count (see drm_sched_main as example) */
-	dma_fence_put(f);
 	ret = dma_fence_wait(f, false);
+	/* Drop the returned fence reference after the wait completes */
+	dma_fence_put(f);
 
 err_ib_sched:
 	amdgpu_job_free(job);
-- 
2.34.1

