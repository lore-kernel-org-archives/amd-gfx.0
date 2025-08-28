Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F35CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD2A010E956;
	Thu, 28 Aug 2025 09:17:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BVFnpgVt";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4DBE10E94D
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqEIpPhO/L4miO1f1V8DdoQE+JYeOizU304tPaWEZBxtSRo6i4Vg3k7FDjy8pgpxQJ5SmqXj7Lixv4IIG74S7g6RbGe5foRab/I9yMmio588URC4Gok08at4Tznzrs56QlTPmrj5XAOtln5WAFkF7he1Ddv1OoDSDhVRdCstUKfpSmef+CBzt3wd6g1J/vkZUUu9jl/b3yyBKti2gyoUoIOdfRdc6dlzGQEV6bKf8dbFr9QW5jMBflCCCJnjSIqna6lGz5rxmFaBQzg2k+6sj17rNPkgDEBeZcGABO+3atdawjvudAscwwcJ0ob3vaVKTwMjo700hbBcqKu4otFtcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMrYPrxEB+QFbSs183EO/yOJethtzolfTwEwPZnihl4=;
 b=S1u4e/nbZOqzxE/eMR3RRrVVf/kepnRPTBa0hC1Ys4z/WE9xtNatThkjVnbX+GO+iN+CLTw0/klaChgPZ+ubJzhpzXBvbwdIo9YKcrWRNMFObbDOBnOgdn1t9jhY9ouWMscg9FsygDdT3ZFuw13ON78hipoQUPpbauU1w4wYfSoMdFPkZ0Fl0D5r45VijI9sO8UXXrNjw/vDxxDWRfOg5KVia/HuXVrE2BAtQ+j4DBwI1UQtFRPYNGpSHZHGk6LpUtkA/lSVjxW55x70PICOVlcEHnvWvsL1D3NTUAkRVK2gv0Ub/EzLzJ/d8ohJeLjihGTrjP5OrUTn3qO9F4TJPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMrYPrxEB+QFbSs183EO/yOJethtzolfTwEwPZnihl4=;
 b=BVFnpgVtMUJUim3fYARUmQxDONpuADwHpHHTR0nakgSsCH7d+DNWPZFgnq59b3kxfFly2u0LU9GDaiXV0JQa6vty/PExkPgeVOMp6AxLEL0UrUr+zKie6o+GRYpcV/qLgdfzdPGspT+Gmlz9vc7FywVw5uRn0T0FRYMBL5t4RNI=
Received: from CH5P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::27)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Thu, 28 Aug
 2025 09:17:36 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::40) by CH5P221CA0002.outlook.office365.com
 (2603:10b6:610:1f2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.18 via Frontend Transport; Thu,
 28 Aug 2025 09:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:17:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 03:45:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 28 Aug
 2025 01:45:51 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Aug 2025 03:45:45 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v12 08/11] drm/amdgpu/userq: add force completion helpers
Date: Thu, 28 Aug 2025 16:42:14 +0800
Message-ID: <20250828084457.1999535-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
References: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SA0PR12MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: 490fa75b-90a4-4431-49dd-08dde613ba13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bngrdDZkL3hjd3hCM1ZSbFNCakhnR0VGeU8zcTdWbDFjOWk5K0ZFUDZOcm5h?=
 =?utf-8?B?REZpUUdIYWplL1VwUGFtVFV1bjROdGxWclBmQ09qTHRsa0hKQndyQUIvQzRX?=
 =?utf-8?B?cGo4N214bENZKzZsRVR3akJMNmhDaWRqKzl5UUF0dXFZRnloTUdXODRDRTFq?=
 =?utf-8?B?UTBXWWJlOWQ4OE1iSCs2ZFRoVWFKMEFrUktRZUEyaVlkajVQU2lON3JkZzkw?=
 =?utf-8?B?b09QMlU1a1lUUTM2bUhIQ3dDcDZFZjRncWtMVjhWTmFWeExUSVhleVZpckpO?=
 =?utf-8?B?N0tjaXMrbVprQnZDOTJDQjc3Ujh5NC9jV05HcUJJNFdwOVVrdEJjenlnTnFr?=
 =?utf-8?B?bklTZ28rZ1MxRGF5RzRqdDVzUXdKTDNReVlCR1hpRzdaQUtPRUtSZkVnYndr?=
 =?utf-8?B?U2llTjJsNVFxQlRNdG5kK2xEZ3NPRjFZVW93S2w4cmVHT1V1RHhZT1ptM1M2?=
 =?utf-8?B?czJCWDVPKzQ5RUR2N0hTcE9mMlBLNEVkbER0cjBlVTk3YldZdnJIOGh1MmxT?=
 =?utf-8?B?WWNENDRFMEZqOWhEUFQxajNRa2lycFRKZEQxQkFBTHd4OGYwa3R3YXluQjR6?=
 =?utf-8?B?ekNXeEZvYVFQU0NyaVVpYzR6YnMzZ0xIOWpGeWhpT0JtZUZoVW5ZbExFSXA3?=
 =?utf-8?B?ekpoVC9jNENkbFdiQnF6Ri9pNTl3My9EYmVBZ0tYN1JTQi94OGxLWmtOLzVh?=
 =?utf-8?B?SFNLb3FMOEkzY2hYdEVvb3lnSVdHWVRaa1ZPQ3ZmVkNwWTJ2RWc5ZGtQTFEz?=
 =?utf-8?B?dERHQ3NlRktlVE5IYzB5MWtWTDQ5NE5LUkJYZEhzTVdMaHg5TUZnRWZsVTZD?=
 =?utf-8?B?bFpTcFQzN0VUeHEvOVB3WUoyY1lWMEhma3RnNEl4VEEwSTlyTVorcVByYUVy?=
 =?utf-8?B?TmlGU0NXRTlQZVAxQW9aWlIvWENKNHBrTjBobi8xUFRaejhwUlRYaUUvVkFZ?=
 =?utf-8?B?dERBd0FnOGYxMHJ6cDJRU3M4aUFmN1U5anhMRVl4WEJhNWdXamlwb0tOQUJt?=
 =?utf-8?B?YUIwS1dUTmpSL2V1ekIvU3VhMUtxVzRLWEpYcW8zdWQ0N3pYWG9HR29tanU1?=
 =?utf-8?B?eXpQS0IwNVJQbEl0NjFGU2xpZk1HdWMvOVljL2NXK1JLTTZHaDhxeEdhTUJv?=
 =?utf-8?B?bVp0RENQZHhYTTB5WU9MZlRLN3JZQ3hXa1IwMW5VSGE1NXpNRVVWZmN6NDhx?=
 =?utf-8?B?SVptTTRJYUF0bWxxZm4vd0JMK2NVS0hZRyt0ME1tKzBzYjY5M1hLWmlzNHdr?=
 =?utf-8?B?RFoxUy9GNi9XZzFEV0J2S2tWaTFWLzJGTzBNZzlvU3pqRzNoRFloM0t5YlJE?=
 =?utf-8?B?SklnU1RpWE5veWVVN3lXYzZpTEZNNWRNa05rcitZdUsrWWVJQmkzQzdSSkgz?=
 =?utf-8?B?UXQzTmFXY2h4RmZHZnNXbzYxQ1RrTDVzZ1liSDI4ejhqVmxYdUNJaHVqODdQ?=
 =?utf-8?B?aVhhalBsRjFyeVR2MU1uZHcrTWxFYjRzcXp2MTZiTSttdENBQUJJbVVNajZz?=
 =?utf-8?B?T1R2ankvZC9xM3dwMFZFRkFVcUQ2SWZkc0wvWHFOL0J0RlVZcStuanlYdnQ3?=
 =?utf-8?B?cE9sTlAzS2lPa1hoRW9TRnJIajh0VHRCOXNqYXRmeldqNmFrOStmYWt0ZVNa?=
 =?utf-8?B?T2REb1RFV1dSZ3c5clhUV3Q3YkIxTE91YmxRZ2RGZUtLeWU1cHFmc04rV1Ny?=
 =?utf-8?B?Y2lqRmE0ZnFMcElBaEF3SWM3UVhDaVRESlZCVkpyWEVFS0lGZHg3aDk5TVhR?=
 =?utf-8?B?VjcxOGVZOG10UStTaWJxbDFrTVlPbkx3R200WWN4OFczUk1HOFFoMkhiRTdD?=
 =?utf-8?B?cW14T2J6TVpOenZNM0pMcEozRFBRbWh5UW9VelBndDZQclUrVmZoQlI5aHVT?=
 =?utf-8?B?OGtka3loU2VlbkVYRmM3K3BkTURHbXpaeXB6blFiT2hzdjIrd2QvWDhXQmVn?=
 =?utf-8?B?Z0s5K25nZ0lCWW1mdlFPem1KR2VHVDVNTGxzWUZuVFk1UFhKWEJtQkM0eUVU?=
 =?utf-8?B?cDVCc1o5LzhrSFp4SUFkUVc2UVI5ME8wZmswRFdnMU1GeEJwNWRBQW5jazZL?=
 =?utf-8?Q?TCE2n6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:17:35.6539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 490fa75b-90a4-4431-49dd-08dde613ba13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
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

From: Alex Deucher <alexander.deucher@amd.com>

Add support for forcing completion of userq fences.
This is needed for userq resets and asic resets so that we
can set the error on the fence and force completion.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 42 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a86616c6deef..01688bbf3f56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -67,6 +67,14 @@ static u64 amdgpu_userq_fence_read(struct amdgpu_userq_fence_driver *fence_drv)
 	return le64_to_cpu(*fence_drv->cpu_addr);
 }
 
+static void
+amdgpu_userq_fence_write(struct amdgpu_userq_fence_driver *fence_drv,
+			 u64 seq)
+{
+	if (fence_drv->cpu_addr)
+		*fence_drv->cpu_addr = cpu_to_le64(seq);
+}
+
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq)
 {
@@ -409,6 +417,40 @@ static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
 	dma_fence_put(fence);
 }
 
+static void
+amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
+				    int error)
+{
+	struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+	unsigned long flags;
+	struct dma_fence *f;
+
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+
+	f = rcu_dereference_protected(&fence->base,
+				      lockdep_is_held(&fence_drv->fence_list_lock));
+	if (f && !dma_fence_is_signaled_locked(f))
+		dma_fence_set_error(f, error);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
+}
+
+void
+amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
+{
+	struct dma_fence *f = userq->last_fence;
+
+	if (f) {
+		struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
+		struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+		u64 wptr = fence->base.seqno;
+
+		amdgpu_userq_fence_driver_set_error(fence, -ECANCELED);
+		amdgpu_userq_fence_write(fence_drv, wptr);
+		amdgpu_userq_fence_driver_process(fence_drv);
+
+	}
+}
+
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 97a125ab8a78..d76add2afc77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -67,6 +67,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
+void amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp);
-- 
2.49.0

