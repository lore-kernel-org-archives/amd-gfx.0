Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B8BC3ABA9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 15:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC99810E0C5;
	Wed, 30 Apr 2025 15:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W0O09/9c";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73F3A10E320
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 15:48:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFI1zt3Gd1uNLWAw14qlkRMl6fokkUrdW1tNtrOofUgWuMhHI7MTSwy6jA2ad8qSBSljV56zX6R1JsW9SBmAJUAsEA8GoI/F+F0t+MS/lQdMxJOllZfJoRXX0UeVizyChvT8xDedDlAKvCYyr+p5/9vNFX2S+qEMh18f5wbqR4bBOSPzgXsDdbuCI6QzbiOYiQRFE6fdxqmrHvX5T7cLygvLQZFb+8uI8qGxPAUf51/3ZHDTxjq1gko8w7n8M4vBs3kTw4cUi+kTCDh2nvbD6dtQxC/x9VmzxpdMv8WHAAH8mGh+2HyIn6N/UiSqUP/40lH5hsFjcp30XUVuBOq1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQ6GqIJu3IzE+ELkjdZ0woyIWCo0EuJpFWyCSyszb1E=;
 b=YpKRh6BcdX9t32IrxvrsD6rx69WOPufNfs61jSdCdEW2TQftfO/1T/g2/OB+Y3sL3b6qHWP9+cir+qqXgFOEyzQJHzETo8WynQF/xXsJ/K9cBRIS5f8Myd57crj5UH5Qir14ldp0qVNylLKQzY1PrhUH9XlJEGcrvCy9jUsxTJFdm3HrasfnZUKFgsl5TH7tCFg84nV8aGi7hIecERdGvcoDFQmC0o1jjSC4Xhi613w5T6Dmv1hvbirUOEgI8rVPYFc0+xlaYycgQuldNADpGrIlxUR0PLmM0h+VBn6i0gxX2ilsaUM9X9Uwaw0tvkucPVOd7SECicrAX2EEcPHAzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQ6GqIJu3IzE+ELkjdZ0woyIWCo0EuJpFWyCSyszb1E=;
 b=W0O09/9c8lM4iHo1TF1K0qskHw1TIOKiQnFJiVHSTvvalycm2muge40BMAJnCayX2aotze4OhC6SYV79iLPtwQulIF3HyXLdVlLWqrdi1ldmOuBbDmU7l0O6i+oRnZFxFFVcGFeckKCc6fD3H+rFz73VjfPmSIxHK6J3rMGHlW4=
Received: from MN2PR20CA0017.namprd20.prod.outlook.com (2603:10b6:208:e8::30)
 by DS0PR12MB6557.namprd12.prod.outlook.com (2603:10b6:8:d3::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.19; Wed, 30 Apr 2025 15:48:25 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::a6) by MN2PR20CA0017.outlook.office365.com
 (2603:10b6:208:e8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 30 Apr 2025 15:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 15:48:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 10:48:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 4/7] drm/amdgpu/userq: add force completion helpers
Date: Wed, 30 Apr 2025 11:48:06 -0400
Message-ID: <20250430154809.2665473-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430154809.2665473-1-alexander.deucher@amd.com>
References: <20250430154809.2665473-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|DS0PR12MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1cb842-191e-4163-a38a-08dd87fe71b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnhQS3h4eUJDdG9UWmVLaXNWZkZmL0VNQURycUV0WDgvc3A2MFNJbW91akor?=
 =?utf-8?B?V3JQdWRuamEyVVFDaEhCcFlDcTVWY0lGRmN3RUZ1KzFDcis5WjNVRzVPUnJW?=
 =?utf-8?B?Q3YvclFPU3laYm56TThBbVI5aUt3THF4NkN1MXNHaHlBWHRFa2h6QlF2ejZ0?=
 =?utf-8?B?TEUxSmJ2bTQ3cGVKZmJFTlVDeERmdjJlaWE3dDduazUrU0R0bkNtTmVsS3ZD?=
 =?utf-8?B?N3NNSTVMVFBkUUdzS3VSZEp6TzdlRUNyMnAzeEthUVppNGRKMmRxUlJIRVNB?=
 =?utf-8?B?amJiMnBSdjF5d2hhdTJ5c3N2TlRQRTN0eGIvRmJLNHEydktLN3UrcEdaOHls?=
 =?utf-8?B?VTlla1pUdW1kaHBFSHQwN09qWjRIZ0lGVGdROCtnUldnSEtkczRUWlArZWNW?=
 =?utf-8?B?UWsvVkVKT3NFY29wMVFXVzZuYytoZW5PV25ucnBGSVZTY1hlM3J3US8yMDZz?=
 =?utf-8?B?a2QzWS83WXZhbGZlUkt5bWhBRmVTY1Q2aHdQeHN3YUdud2x6anQ4ZFV3bHU4?=
 =?utf-8?B?amRuNUdvVU8xOFpKMXlla3ZRUTdaZk13cFNvc2VGcXo4TTgxVzREeXJJL0hj?=
 =?utf-8?B?UnFzME1RT3FvOHJscDZPQnZtNklldXRQWGNhVG9jZmJ5SURqZExMMDRicjJM?=
 =?utf-8?B?cnpVakZFd2U3dmhsalJ4WjkxeEZ6b3dVRVI4UmRoQmZadVU2ZWZnYjVjYy9k?=
 =?utf-8?B?NFJFT3hqb0UyUGtaZHd6VEpBU0RJMnMrUEptSWRqTFV6dHpXM0g3UHZDRVJn?=
 =?utf-8?B?OXFoMk56b1ZQU3g2U1doT05KeWlJeXpSMEE1RThhS254YmNpenNibXFXWUdq?=
 =?utf-8?B?V2hwRXg1Qi9ocVBkK1dpcWVUaWhiVGxDblpJcVNFZ0UrY3BwUnJlTmpOSWh1?=
 =?utf-8?B?M3RPYXMyWk5VZHlWakxER3RRWDVrU09XWVF2WW5PRlRvRVhRVS9HZzRna05a?=
 =?utf-8?B?eEVmWkxnUFovU2wrR2RyQmQzZ3pFY1JyZk9oVmxadC9GZVMvbzRnRWtTaWJV?=
 =?utf-8?B?czMvbUFKQndIWUJ5VXpFanMzTjZTb2lGWmMyMERLRTNuQzNkMk93NUhnb2tE?=
 =?utf-8?B?NnUzTzBNUWt2SUh2dXBZRm1tZ2k5SThzQUZibUhsZFZrM2gxMHRacHA2V04v?=
 =?utf-8?B?eVpvNWdKMFVxL2RvNXhaSnkwTXNBZ3hBbkZqL2VjL0dRMWlGTU40bGpuZ25D?=
 =?utf-8?B?OUl6SCtpWTdLdmR2SWVhMHJPVVFaY0JMRFQzVEw5NTJZSTRRUEo0Rk1EMm1z?=
 =?utf-8?B?dlhCUVlMNkYydUNMdmVhK29MazlROVluZHVjYWRWZ0xUdU9hOTFLWnVNdSts?=
 =?utf-8?B?V2FBbC8yeDJ5NXR4S1Jscjg1QStZTjI5ZSs4RlFSODNLajliZWQvamNWWWFX?=
 =?utf-8?B?Ri9NUlVRU2dTNitRRXYzdk9Za2hXZzJFWlJ1R2JkWng4S3lDM0hTVEJRQWFu?=
 =?utf-8?B?azNsbUh4c1ZJYmdyNTF2TStrdVB1VkJmVTExTmIxWEhDckR1Y0JIeXdBT1Rm?=
 =?utf-8?B?NDZyVE1jb2haM1djdXlBQnFsSXpkcXhtY1ZXTzZ3cG9JSXhQU1BEL3ZiN2t0?=
 =?utf-8?B?VVNqT2lid3RGTHN0MEQzdHJhQUZQR21LSSthdWs5d3cyR1BDd1RoM1YzZmpD?=
 =?utf-8?B?RlpDOXVod0NROWJyVkliRTh1ZlVYSEtoQytacmh1RzlmUFFXa1RReDNFTDlT?=
 =?utf-8?B?RVNMa3JLdHJONXlvWG9PSVg5Rzd0QTNCNWN5YW9JOVZ4b1k1TWRINzZMNmNL?=
 =?utf-8?B?TlBaMlR5dUtRM1ZmOHZzcFZRaEE4SjJXU04ycWU2WFhmTkFYbXFidWo4dUJJ?=
 =?utf-8?B?QUVMWWxGelBYNUsrc2JhZXh1eDVoOEZSbzROTXU0SlZkZkhpUTNsYnEybC90?=
 =?utf-8?B?QThDTkVLS0xiWHJ6QldPdFJ6ZGlZUkRUaVVYcFZoamdEa3lMSUsxSmRVSFBM?=
 =?utf-8?B?cFBHa2ZnbjZXNU5ESXJ6b0o4L1hVd0J3cjVJTlFQUFdwb3hhVVlnRzVwZWx2?=
 =?utf-8?B?L1NoQy9Bbm5mM1JtR0pab3N4MDRpb1Q3Q1VOUWVzSENXTkdNczhEbDNuOHZp?=
 =?utf-8?Q?RIGx9R?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 15:48:25.5013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1cb842-191e-4163-a38a-08dd87fe71b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6557
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

Cc: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 42 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3288c2ff692e7..3494ac9e9e9db 100644
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
@@ -408,6 +416,40 @@ static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
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

