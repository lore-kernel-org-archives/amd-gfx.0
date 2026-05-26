Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DF8CD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 09:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C9310E489;
	Tue, 26 May 2026 09:32:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u24Le0uV";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51FB610E489
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 09:32:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVAfNGe/EDBPk4Gpc5nKHQPMvVrzdzB0gJ4a+QXZ29tOJQUfhEfNUptPuJDlIyT/t7x2bEWsDpIOKlIjBBFdp4gjhvIFJSnmPlhSf8Yv9bT+X1kvGMw1yYt78XuAKzQI6+R3pL9fjB+Zh/QyoT7IoOwE+CeoQ4gr2A76+fjcfxjw3nw1OKpnf5tG8s3u1Q8xnn5S2GyjmE4fdR3nXhbFgLTKCCKHNsFpzyw9vHPr+pfgqQoBsDC7U7RVxxrvuyJ8ZclEkcS19oVMKB/IB69JVFVW0mByE0RE2RD1yUMAA9DsDZ+ZGSN65pVzP/mPcp8yl8u8igESHR4zgNcOJYh1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UhEVclqzYFNIOr7VShFDolGX5M3qc38qaxqQT2YsYI=;
 b=cT/cSkIc9wdKv3sjyStgAkTG7tCrQ8mBwwHH6l6HQOOZLjt1qyCn9iZAntUWi2HnEwXxSq11qSkxCBBwK0HZXU1yLM49/n2KpxZ1kEEpkqu/p11QZFCESQG9PXhsUTiZwMSSKIMjhEOZ+uCVkbe5P0v82ZSb6ncd2wfpw9tEuVXdDJOhl8hck7aDnIB7ccXBYG0iAJaw0OBLMSITcH0hbfbkaHVzBHdMz8VDtdyGXehuEZbUV68clULZtigwrHzsryiXthtwVcbWd8+Sx2D9XJOuRdw7ldfaLnHRKbxJUyedRuWdBb9lv+dagDJYWYuLZHXN9nsgrlLfhCbOVsHwEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UhEVclqzYFNIOr7VShFDolGX5M3qc38qaxqQT2YsYI=;
 b=u24Le0uVNbRxd7XpkFW3Lh1J1+5ikfU0/ltQ7O9pyPHCPPXMNOC2mRDQ4AqIatdwGAIaUREM1VDyzal14eJXo007EKOqpALtyZ971rWAHo4b6F5q10sgptqdHwjAHAhTQyeTgpmO7TOpEB3kXK64dSoyWbtVtyw6kyy6kCYZdz4=
Received: from DS1PR05CA0008.namprd05.prod.outlook.com (2603:10b6:8:457::19)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 09:32:20 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:8:457:cafe::18) by DS1PR05CA0008.outlook.office365.com
 (2603:10b6:8:457::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 09:32:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 09:32:20 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 04:32:18 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: avoid extracting fence_drv_array for empty
 wait fences
Date: Tue, 26 May 2026 17:32:08 +0800
Message-ID: <20260526093210.55565-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DS7PR12MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8fbea7-dfa0-4045-9e20-08debb09af2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: QkxlgIqoEJcNN527dFB7pds4ADitFU9wHBYvKjuPyQ55Ogue4PKcndXt8ggXcwxHrY7Q7zpQCM42b6kc2rBHWu5vUGJh4D+llIiACJY62dsNErgjEiJVyZyqeS9F8v2k/5FQ0J+amAEvRz71glvFKziUePT5rWxFZUTbDbaqnnG+x1U2Pi7pcbqEMpoePKfCmmOaAAR7226fSmuvgsnCPvJw2MUzN7f6z7uG7mYk7pwyYaDpR296Gvq2SofsU5Mk6eX68G2fJHUZZRbGQY8/mayt1mmSjYTyl04zu7yCT3sJ3khNUEIsDoJtbnRz4xQXzuNB97IjOQjYtis/1GH6Cx74BnLyhG9LDluS2QapikMKSgDHDJHVsq98bZ/EnmV2pwsKQT3ZMMqFDK6JdCF9J3C5mJeInOXfifvV0X4rQpCVUATZSYpGppt/hzBlom8fsSTCprG+4TcnP1tETXnyLANBEgwm15YyLpjk2tlrpuKhfuGv5M3Q9jchaxZE/x/c/7hKgr3MIRdngDbYu5WNCmK2wIIOQKAUYRWV1JSW9NdgJ6V2cMYgmaar5YQHfzTVgH9dFTSiTyoSLiaxslgCWrajcB/RtR7lkDcsjG77VqqXQJQpKRSM1zkg362er7XU3LyGW/TDkD+6ejrsCVT86ADQ+vJbJrtfNGO2V5vC8ykxLPNt2M+EK7N4JHxY2xdSiKwL26nHaRL0/1d67NOq+SRawvcgT9w7kRCJYykpMHg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z8S4rZuDetNJUuZqS9WZlxzrjZXMobvT3kW0VXzKmy4EqHHDzOQgii1XnIh0G4vxa1uIq/pPrZb3AjCJf8f7M7zEwhqqQAkx6U2Ua1LqEUi0kJnk8/PHgnJMUXVIHSwrJk7oDaw0HMrN+madlu4ergd8Xf9wWVsalXavAyPfTdYmn/YF3kO18ZV5vmpGenbcy/1VUjTF7z+6j/9Os5Oyk0HlO8gyF0S9jXdY+cnqQW6AUS39dzkX5IbvYrUVgHrICtbFlwFLkB+DxdNKBEtPoAd+ar3x9wztY+vzjXfKfbieUJxcJj6jBQkrZojmZdXpHUHKDoiKYf1bdH4GBX4NhzY1FvI/Zs1zoM3GsOBK50wHHpYHut5W2QzMzcU82Bv0CIIl1KHCZNt3B2Hq3mYv6i202gD+E1d0KRytohA8rs0SplToBo/VaX0KwMKIziLG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 09:32:20.0690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8fbea7-dfa0-4045-9e20-08debb09af2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719
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

Avoid xarray extraction and temporary array allocation in
amdgpu_userq_fence_alloc() when there are no pending wait-side fence
driver references. This keeps the common fence emit path cheaper and
efficient.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 008330a0d852..2a2bf13a513d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -226,7 +226,7 @@ static int amdgpu_userq_fence_alloc(struct amdgpu_usermode_queue *userq,
 	struct amdgpu_userq_fence *userq_fence;
 	void *entry;
 
-	userq_fence = kmalloc(sizeof(*userq_fence), GFP_KERNEL);
+	userq_fence = kzalloc(sizeof(*userq_fence), GFP_KERNEL);
 	if (!userq_fence)
 		return -ENOMEM;
 
@@ -235,6 +235,8 @@ static int amdgpu_userq_fence_alloc(struct amdgpu_usermode_queue *userq,
 	 * used as size to allocate the array.
 	 */
 	mutex_lock(&userq->fence_drv_lock);
+	if (xa_empty(&userq->fence_drv_xa))
+		goto unlock;
 	XA_STATE(xas, &userq->fence_drv_xa, 0);
 
 	rcu_read_lock();
@@ -256,7 +258,7 @@ static int amdgpu_userq_fence_alloc(struct amdgpu_usermode_queue *userq,
 	xa_extract(&userq->fence_drv_xa, (void **)userq_fence->fence_drv_array,
 		   0, ULONG_MAX, xas.xa_index, XA_PRESENT);
 	xa_destroy(&userq->fence_drv_xa);
-
+unlock:
 	mutex_unlock(&userq->fence_drv_lock);
 
 	amdgpu_userq_fence_driver_get(fence_drv);
-- 
2.34.1

