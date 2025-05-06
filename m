Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59C9C3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 15:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD1B10E6F5;
	Tue,  6 May 2025 15:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kZUCKCOm";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A063110E6F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 15:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzIp7YPa/FBalz2JFQLyachVr3D+JBBVau56QWfP2m9jVEvNq0cQgrmf5N+NPbp2W6EhMxp9RsFvryrpBhISFTi6nXJMQ75QtlJ9Nym/o2i3aWHGfZ3dBo1wBTiuIpWrQ1om4CgAjUwuwpCQ086PdRy36v3ZCjAMynp2grOg12IpM7Lr41ChlaOLsOp4pMK19xeQ6e2ecQKkAX4IJCEF1o+DKMHWSS18KWtvx7Ou0KSbfUeH7tLMtuBjJNVV4ulrAkEdVtC307HEQ1AC/Y1sC0AvTlwNXjOYwyJyysJjfMpcQd0Q4356l0xV/BLIPqlF6aJp6AS9923f82Ut8Y/xjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtQSdAvWXk0qHLlDIVWU62BJi+VrreTsph3o8Jn4MbY=;
 b=Pc2AObMWWaYVoFEoyS49jsBO4Q0SzcR0n3CBJq90YZVtZEk/nJN7SE3W6uRuif1DFg5v06MstRwsUObiY1MpdQmHpp0uGhWOTjE4DpFinWYDtN1YpJUUlkAutqRwjGXRlY493RhYng46XP/1UTZp6MGyVRPPv1fGlo33M3hNp/8/i+vIzl5y7Dm/7fJSi8NbV16Vgc+0LYA6XbQIHhCeI24U+rlrEyi8jurs/HHTJS1ze7Y8u6womVxacTFy0XsqYBl2VNTK9icBovMqtda2pWhs+RM38VSiV7uqdEvVaR6AbrrSmkbpo2h33sr7dQCasV3Gbj0wUZga+3pCe+KCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtQSdAvWXk0qHLlDIVWU62BJi+VrreTsph3o8Jn4MbY=;
 b=kZUCKCOmbv6rCEFg8hrZOf8ThtbB2AzifROJUJWmRmWjbr5dDnJHUtPJt+YT5BO/KS5JWrETFNHVHJfp5ZDYZ2AfilnhsRH3TJ9d6fZH/rttHpT2RRAv6KqsngtoAg3tUsxHW62C9DYFnKeN1/+4nxJEw9cPQByS1M3EoaqHpRU=
Received: from BN9PR03CA0216.namprd03.prod.outlook.com (2603:10b6:408:f8::11)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 15:59:17 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::52) by BN9PR03CA0216.outlook.office365.com
 (2603:10b6:408:f8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Tue,
 6 May 2025 15:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 15:59:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 10:59:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 4/7] drm/amdgpu/userq: add force completion helpers
Date: Tue, 6 May 2025 11:58:56 -0400
Message-ID: <20250506155900.3866874-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506155900.3866874-1-alexander.deucher@amd.com>
References: <20250506155900.3866874-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da9a70d-6c2a-49b9-7159-08dd8cb6f4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3o0UlBBUUJWZmZqNHFMS2YzU01TRi9OaTczMXdxL2o1OEtYNk01b0plbDZL?=
 =?utf-8?B?dkdadkpWVjZNZWxSZVdESGFnOWZ5U0xDenZtKzRQcWh1ZTIvYjFYYUJteUU4?=
 =?utf-8?B?QkJQL1NXSHNaT0dOellaZ0RFYVJpU3BUV01pRjlHdjB6RW9ja2NWV2crcHRM?=
 =?utf-8?B?U0NRbVlHdkZCWkE3U3Z2eGFPUFhsMUc2U1c1cEdwZWNvYk9mRSswMzRQVXov?=
 =?utf-8?B?NVVOZGFaWm0vRUNmTUh4QWpLY3NCa09ucDJkVHREbjh3bzBxMXFGM2RUSHdU?=
 =?utf-8?B?OXFPY3B3eVM5S3BZYTN2QUNuM0JPc2daTUtnVUtyc0lZZTVXSjhaWnZOaUcx?=
 =?utf-8?B?RDc3OFQvTE5mblpXOGRSNHkwQTk1dHl3a2pvczE3alk0eGlTa0RBdTI5SytX?=
 =?utf-8?B?SEE1SjRDMmxRK3o0ZUVjWmNEQTBIVnIzV0dQQWY3UTJXRDFmaXMyalQ4V2Vt?=
 =?utf-8?B?QTFQUGtIQUE4SEZ5dEhqdkRLbkJZdFhWdWxkZEFpNzV1THVUeFIxZzBWVnhi?=
 =?utf-8?B?bEJReXYxczlORHRGQlZ4ZjhLQkV2cDBiOVNEVjRBMWpuSDl5dXA3b0ZsZ0dP?=
 =?utf-8?B?N0hBR0Z0NjJ2S3VLV2Q1UDM2d1MzcGFBeitnWUJDUDFDell2aE5aOTBxSnlX?=
 =?utf-8?B?VDZWK0ZiMW5QbEk0dlRPRFFySmhzYXFOM3Jjb3ZoSHpva3p6Y1BKejNJcFRa?=
 =?utf-8?B?dHp5WHFUTC91ZTB0bVZMVmsxTFpKcmlUSkNjVnREMFNJeTBSeWsrY1Y5ejNk?=
 =?utf-8?B?RCtkZjAvcW5BNUE3c0VEMktwQlJlSVUycmtXWHNGTDZPQWlTZXV4aDBCQkti?=
 =?utf-8?B?NndBd2dQS2ZjQmR5c3JOWTN4NWVIdGxqQTJ2OEpGbzJYZERRM2VLY0ozOW9O?=
 =?utf-8?B?Vk9wcGRPRDdLM0VBVkhXMGNCTlB0dWF4VWNWWUN1YnRxRGtRUXJVa205bHd0?=
 =?utf-8?B?TU43V0JJU3hrNStUazlLV0liYlVCaW9sNHlaUndCYmlEbU9mbXdIWmxxTmw2?=
 =?utf-8?B?Nmd6aWJnU2RRemVDbXFtNkd1QjMvbXluUy90WjArYnhzMFU3WkROUURnWkVx?=
 =?utf-8?B?NUIzTDlpZXlrRm9wcUR2Q0p1NmRqL0pRMnRWcERtM0c4MVByWm9zWTdXYks2?=
 =?utf-8?B?N0Y3SDVHUzdiNDJ2aHM1QmRHWHdSZmhYQnNGNUU1R0ovaU1qNjhsaGNoc1g4?=
 =?utf-8?B?WXdLeGYrSjZLWTVxSUU1VUYvQm5zKzNRUUhxNE83QXAzZFllb2NUcHVaek5H?=
 =?utf-8?B?V2srZmk5UklWckdkdXF0VXRQRTh2UW1pbHpRbGZHUzUvcWNtTXEwazNBZjFW?=
 =?utf-8?B?RHloMi90aStNRWtmOVhwSXB3aktmTDhIbk94bGNKYUtzMG0vMGRnSnhZZTJP?=
 =?utf-8?B?NC9XZ3JGL3pUQzJLU1BYWHFaaUhEejFoS28yY25NVnpRa05XUEVXckNodXRP?=
 =?utf-8?B?SEhBTEFBQVFqT0NkZ2pSQ2d4SUhMRFFaRjFKeEdocHJQeVVpVitabWtMWElG?=
 =?utf-8?B?ejVIZ1ZKVmMvY0hCcVRqM0Y1S292ZWh2ang4M0hYZlI2eEFONUwvaWhMN0F3?=
 =?utf-8?B?OEs2M0xaK2tkeitsdVk5NTMrMmwyODgzUVJmL1hzS1FjMTlWN0Nidk5LdTY5?=
 =?utf-8?B?L3dNM2J3V1l0ejA3dXpzdEg0RThGQmxhUlRpWURJNGUwSENnMndyc1FnN244?=
 =?utf-8?B?M3htMk9QRm9PckF4T2ZJNDlLTXNKY1YveHlSdG5aS3RwQlRNcXU0OGVwQXJt?=
 =?utf-8?B?c0JUMVlOajJGWTNaYXU3cEVFbFBzaVYvb2NqS3NNbXRneXozOXlSOHMwRXZ0?=
 =?utf-8?B?MnRFVGtjUlRnTE13Vld6MHZkTHEzclY1UU80T2pJUG10dkttd1hoSDZKZzNu?=
 =?utf-8?B?QlN6cG5OK0Z0dVg4MVpTL1B4cExkWVoyOEl6TkRDM3BkTUtKRUZyaEhtSWN1?=
 =?utf-8?B?R1h2LzBVTGc0MEVsbFFUUUptWHAyWHpUazBkMm84Q29aUENFTzBOL2hJMjlK?=
 =?utf-8?B?S1BLRTR3NG1sNXE5cFdwWVpSWTVqKytVeFpBR20wVitLeFZvaFZiWVFCSlND?=
 =?utf-8?Q?YLJo0M?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 15:59:17.5059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da9a70d-6c2a-49b9-7159-08dd8cb6f4cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247
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

Add support for forcing completion of userq fences.
This is needed for userq resets and asic resets so that we
can set the error on the fence and force completion.

v2: drop rcu_dereference_protected (Christian)

Cc: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 40 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
 2 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 029cb24c28b38..ce0d06a8c4997 100644
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
@@ -409,6 +417,38 @@ static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
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
+	f = &fence->base;
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
index 97a125ab8a786..d76add2afc774 100644
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

