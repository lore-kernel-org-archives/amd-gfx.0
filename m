Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A627FD5F8F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 07:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4EE10E552;
	Wed,  8 Apr 2026 07:45:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pW31Bowe";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011037.outbound.protection.outlook.com
 [40.93.194.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8933B10E552
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 07:45:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7VmdQX3wVFz9DvYiuHOoRU+68CUfqJN3fPKCM3MJnI0Dz0k5bsuIo90myE0UbNMcfLp67PTE3VEP4w8yFQbh0kFu1IJsi0pzJSz4Q6nyK0l/9NHKLXRHsK07y8mrKLvyrmyYmuI/RT//6Qx5DVDNM14CD4N9HOjx6N2/25l1slMmnWh7+jHsufvLXlNjRS0xhiG0ZI9kM8ZjZaxGUYjYwIPJFC8jv3OYan2sKtn2SG98q5tYHBBvMj+lnTv0o3mkv/QTHKUa5uTkcs5tl/xqr8GLXocSivquLnjf4ShVQDbzc/hRaWM5qS9sX0y3Poo3A4l1GwKK4bJVJ6ENG2cLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EFoiqWsNt3dgk3ZfXRGZ7FiBNjVRGILLAiN3gb80Wk=;
 b=qFsJfhWu8UrFguohqq8GIK8NvjcboC9OZp5icvD4aEAfqMgPPFrr/rO5d73/0A6345br22bL0KcRQL0M7EmaTj6594xuvDtTZLRCyk7GJAdnWxIbl7Iva9pMy1x71DhN10iLTfwpgo9hqfIgWvhjGy+PFamCtP7q2mkRbP2m/23HX/0LX80FBNdxCu2SeB54XStiGPzTZGlVnELtWbG7sWM9Fp70KVrTWUHpH48P8kK/b61tVtTMZcgf1NciT2Q5/Ce8JtldZMZb/xiDi8O9oCUhpb6jiV0VUfCAeD3mOE3xLJj3e3fQ8ExwYs9eUzqe8/yx4xk5h2D3UtClx4NhzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EFoiqWsNt3dgk3ZfXRGZ7FiBNjVRGILLAiN3gb80Wk=;
 b=pW31BowetE5/F9L9b5G/MHfC0cHKtBscwJofATqCEFrCi1wIsoSwV/Ie4oSy7icYUmBdm7RpKY8v4L1UeuIF9h0qSxjs3mhvEuZu0YrJnj71nwcg04EOz4q7M3OQElRG2vYISGtpyvfUlZhTTN17LLwdtOOYhob2licY3xAMvyo=
Received: from CH5PR05CA0010.namprd05.prod.outlook.com (2603:10b6:610:1f0::22)
 by MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 07:45:49 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::4c) by CH5PR05CA0010.outlook.office365.com
 (2603:10b6:610:1f0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 07:45:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 07:45:48 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 02:45:46 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: drop userq fence driver refs on fence release
Date: Wed, 8 Apr 2026 15:45:37 +0800
Message-ID: <20260408074537.3439191-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|MN0PR12MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 485ce049-96db-43a1-5127-08de9542d9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: j0Zq8iZ7+UguWCIk+rfsTpwN2JP7HvjwqelH5nfdbzbWkjWJhmCEo3uusqPP68DrmaoT7lSWgLfULKq2VVYkzPRIlNWyUa7A4Ej9XaKABU2T/t+P6SQ6L6/T3U9yWLitAozrgDb36rqEONAd+pXs7IGdW2uWplI3qgj4szV3MKDMl/iVnpegvHTd6/5S/wD/RZO2fE4fgrKQMw2vehOFlwtnNOpToYFM/0CvruLG55wv3SNFKVcKb0JxiqQ7o3GRBNzNmUajjyoOvHV/flLZ9uoqPBh8JcYizGOspdUtgLkmhev0xoYcaAplm/Aw7LhdfCehwD+itylKf3UXTw4Ht6rOlmu7MAfYaVr8vcmYSVXJ+O1FbRWoxJx2ETDTzGBoNmX+2kI4bHrESO5OxnmdL3PNODHUlB0yfi0+k4nzzX03PboTTkiCN7cZFVZhDvlS/XW3fkSr1rMY/s5m8MEbirWom2eYJvMwC/VDlyu1YsHQXGeutV+j9D2VQKHfdEa2i86v6xeDiCW1rcODc6NKZtq0LOg9o4LtYhDySZsmuqN1E2Z+54mE/5C6rX4X3jI9zQXeUxIyDnSFj+y3qUYWBmZW/DqLkoGzFG51DoUuxDQcqAz6NL9f48ZCT9SWqdfyvz/cqFCX0kXSIzs01JGI/EznWQrTx/nKK+6abMHzaUQZKIFrZXUQqjddVV3ya7qFbeAHZmp+mesgwygL2dV6OOEw0j8HvsNumUd9rCqy/YdTsBt2NahecCgHE0AH0hT2Iicm0/XS8dqYPiAwwTXkEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /YZF7Rzii0ZKGBvs12TvP++QggkXN0A4yxjBrhUr6BTMm42Njd2L//T56sVfM0PK+ZOtemABCXSlIaQdMiYHSGlJmFAFpn2/RX11hSzcL70Oes5f1HPpLrpyv7+msWcaDalO/29HP3/9XESb3O6/v/pQG3ZXxewhocjlrhGpsv2gJZ7azhzqsvsBVMXXnHmMa9pirbPRojALrWLqwJpt0a1Q+qYyVwoCzZleftVm2orvXcW1BvgkDXc4j/MvRPBCsjdofPFfGXaHM4ndVroq4A4Y0ZAPZr6njK7jAnmAkAAAovTg+APItDpoeaba0feQwBSD9GGRcgDvmXBzfb0V1Ob0lRJdLD1DUan+I76I97GB3vZ8Lhd/pCIWuy592rVvAelr6m4zEBnFNePMUwtri/taJ4ow3h+aoPHDIvODLcMkWtDA5DR/0QTlnVzvTu22
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 07:45:48.7810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 485ce049-96db-43a1-5127-08de9542d9d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6004
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

amdgpu_userq_wait_ioctl() takes extra references on waited-on fence
drivers and stores them in waitq->fence_drv_xa. When a new userq fence is
created, those references are transferred into userq_fence->fence_drv_array
so they can be released when the fence completes.

However, those inherited references are currently only dropped from
amdgpu_userq_fence_driver_process(). If a fence never reaches that path,
such as it is already signaled when created or it is dropped through
an error/cleanup path, amdgpu_userq_fence_free() frees fence_drv_array
without putting the referenced fence drivers.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3be80a82788a..bd196599d3d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -145,13 +145,21 @@ amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
 	amdgpu_userq_fence_driver_put(userq->fence_drv);
 }
 
+static void
+amdgpu_userq_fence_put_fence_drv_array(struct amdgpu_userq_fence *userq_fence)
+{
+	unsigned long i;
+	for (i = 0; i < userq_fence->fence_drv_array_count; i++)
+		amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
+	userq_fence->fence_drv_array_count = 0;
+}
+
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
 {
 	struct amdgpu_userq_fence *userq_fence, *tmp;
 	struct dma_fence *fence;
 	unsigned long flags;
 	u64 rptr;
-	int i;
 
 	if (!fence_drv)
 		return;
@@ -166,10 +174,7 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 			break;
 
 		dma_fence_signal(fence);
-
-		for (i = 0; i < userq_fence->fence_drv_array_count; i++)
-			amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
-
+		amdgpu_userq_fence_put_fence_drv_array(userq_fence);
 		list_del(&userq_fence->link);
 		dma_fence_put(fence);
 	}
@@ -320,9 +325,9 @@ static void amdgpu_userq_fence_free(struct rcu_head *rcu)
 	struct amdgpu_userq_fence *userq_fence = to_amdgpu_userq_fence(fence);
 	struct amdgpu_userq_fence_driver *fence_drv = userq_fence->fence_drv;
 
+	amdgpu_userq_fence_put_fence_drv_array(userq_fence);
 	/* Release the fence driver reference */
 	amdgpu_userq_fence_driver_put(fence_drv);
-
 	kvfree(userq_fence->fence_drv_array);
 	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
 }
-- 
2.34.1

