Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB763CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 01:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E4010E84A;
	Thu, 21 Aug 2025 01:42:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iUqF6LO9";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D01CE10E849
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 01:42:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7enOA1XPydQEboY9n3xbWdK82W7q6oZnpYojy4XXiF9b8cJaLPjMI0oGnyCHlgFKT9Nh0mspgzztW/U2ylEri2CaRFD6bSOzlKG7ABtSRuvxHVZi3gO+5ylzCqa+/2PvBF79dduekMayJwUoOcnYTBUKHWEyifEJb7/yHB9gF2O1DkAhGmBBW0GckQD2jxHZV44Q9HZo2snK5f2I1YUf/Go4gsqm8VaPWAVJG22R8MSe2tLyLWFQR/8diNynRLw5ETHHwVtEHMpjb7wtkH5dGbcmQPwl/47kAA98Ve7ISucek9Cl/wdutZnYCUa0Wfb5U+BDD1M03YvNDPTGhaaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMrYPrxEB+QFbSs183EO/yOJethtzolfTwEwPZnihl4=;
 b=WJxf6RKNJicrRwsuyvLjZN9XVDjeh/MB1nG6UsvdekyASltfxrzzr8ELq6tE68I0XZAIW1kdyf7Jxvmur9DuFKbX3mbe5bkSshn/TDB4BqDxJBeQoT0/i12VrGBgZikUkIV71Qylc4y44srhLR3UFLM78oZWL+uVvENQ113WZh3XVgdx6lDDLU8oFWxoo9h2gcSgRwA5Oz2eBicEHhHrcYHSoF9uQOU7ocunBoDdO5q3H+zvRnGk4RkI81t3/Fti5ct0YDYPyPxEmKS4JYMGncNzpDFgwE6ZSZheoD74QSqI6xrV+11xbaap5VIa0HNSF+aQg2Pda57dNgutfp92rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMrYPrxEB+QFbSs183EO/yOJethtzolfTwEwPZnihl4=;
 b=iUqF6LO9LVQg9EmeOErjNKcngDbGQudM11IM2n11fI3gYSTSuJvQrE/3dyz00VLHdf8P8jIzZJczfN4wp7rNUhfUi+rsMQ8t/C0OWwN8HE9dBkQmTJl2AVUhWWU/40L+vtNyt9aNrMQVU6YOmPJovs0VeaDTrxaz9fHoD7BNy20=
Received: from BN8PR04CA0007.namprd04.prod.outlook.com (2603:10b6:408:70::20)
 by LV8PR12MB9618.namprd12.prod.outlook.com (2603:10b6:408:2a0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 01:42:19 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:70:cafe::50) by BN8PR04CA0007.outlook.office365.com
 (2603:10b6:408:70::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 01:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 01:42:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 20:42:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 18:42:14 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 20:42:08 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v9 08/11] drm/amdgpu/userq: add force completion helpers
Date: Thu, 21 Aug 2025 09:36:10 +0800
Message-ID: <20250821014115.566598-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250821014115.566598-1-Jesse.Zhang@amd.com>
References: <20250821014115.566598-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|LV8PR12MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: bba66419-c85a-4a60-dcde-08dde053f6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aklubENUT3lXc2NMSzFEYnRaSmVLd0FIT3U3M3lUMGE1NWh4QnpkK2w0UFJa?=
 =?utf-8?B?MG5KdWw4V1U0Y3NBM01odGc2R3FuSHQ2TjdKTkxwT21rbGM3OVY1dlZza1FH?=
 =?utf-8?B?REpWR09MZHh2dGdnN29HRm4yY0orRDBmcEh3WTlCczl3OWowQ01BcXlRMVhV?=
 =?utf-8?B?NmZqMy84QUdrMXdmSDZHUXZKWngwQWFXcXc0L2o1TWM4b29qOE5ub0QwNTJp?=
 =?utf-8?B?N2I0YktTaGRRSm9mZCtUWjdBVmlNRzJ6RmpmRDZ5aFVrL2Jldmp5UG16SHo1?=
 =?utf-8?B?Q3d0Vm5sQkpaL1hDN2s5SEtkdjhsZzRUcFFRVXo4YjVrSWtDSi96emxMbGZx?=
 =?utf-8?B?SGpWazRuYWI1VGVFYzlTenJ0Y1lCMnQ4cUREOTBFR1hucHZYSG5zTlFzMHp5?=
 =?utf-8?B?OE9CWEFLMk9zSUpwck9FeUpKU3UzVnZqclA5K1JrSWtyV0EwSTRRZENiTG1x?=
 =?utf-8?B?aTZtaGp4L1ZTTm1tQm40T3FseVB2Y0JrT3lZbjJBSnJURGxQcTBDdm1hWFhK?=
 =?utf-8?B?NkJ6N3lDMXMvenJuMnVjcVE3NFZCNXhZZWNJd2xvamZ1Qm8xNng1UmRKZ2Vi?=
 =?utf-8?B?Ynk4WCtLNVhKYzYrR1NHaWowbG0vUGZjdVk3TS9jRFQydld4YVFLKzNlcmVO?=
 =?utf-8?B?d2lzZDVKSTRveWtVUUNHS3ZnL2VZVVJKMkJiMXF2UWJGdXJ1ZjZwREc2RGFz?=
 =?utf-8?B?MDFOcnZ5QWdHTkNSRDRxY292N0Q2L0ZLV0JGb3NSZkVuU0ZHdXlYZWJOK05r?=
 =?utf-8?B?Z0p3RVB2dG5jcWZuemxCNUV6UXUwZE1KeGYzd1hxblRZbGdXQ0pSV2hLSTJh?=
 =?utf-8?B?YTdoZlRYTkZjb3NJSDlnYUZDM1UxZVd1ZEJtQStUOTVUbkthRXdpYTFocE1W?=
 =?utf-8?B?eXJEbGE3aVJPUlRVelcrY0hETzY2MDZtZXlRcDNDMjFZOUZyL1EwRzdvU2Rm?=
 =?utf-8?B?OGZoV0FqdFhEVE9hWjFOWFUzMUF1UityWmFjY0JCOTNyRkdGYnZuTHgwVXlJ?=
 =?utf-8?B?WVlDeTcvSTRXTmFLVFRTcnFwSEo0c0IvWTljcjlhR0s3d09IWWQ2VHFidDRE?=
 =?utf-8?B?Wm8vcEN3UDdxNnJuVStydGRmdDN3c09FVEQrclFheVlpRldkZDBTcVFFWkZI?=
 =?utf-8?B?TG01MXkvRnF4Y0pFYmVzYTdCdnVFWHdxNFg5ejZid3RtZ2gwUkFmK1lzYmM0?=
 =?utf-8?B?eWVZc0xwV1A0M3d6ZWtxdlJJS2FiYmh6aHI2UHJLQ1JMdjBoY0tXWWFzYXhn?=
 =?utf-8?B?ZDNkVnNiRmxzVXZzc081M3AxQ082akNIdEtLQXcrRzdWbVlZVVh2cTNVaU9y?=
 =?utf-8?B?Q2lycUkrQ0VlNHVRZHdMZE1ab2MrYnVOcnIyTUFnZ1QvbU5Tck5rYWVkd3ZH?=
 =?utf-8?B?aE1kdmxaenluSjNRNS96Q0dmaGthTjluYVB3c1lRR3l1OHdxcmFGQW9hbWxV?=
 =?utf-8?B?UEQ5elNHcXRHalFHY3hJVGxJMXFwNmZtTTAwbUtkNVB2Wkp6aHJRcDBteUpn?=
 =?utf-8?B?czNpcGcvcEVmMjh2TDAxM3NBVXFieEY0UUpUcnVxMVd4bnQ3K2xlOXBVbWQy?=
 =?utf-8?B?QllFUGQvNXJMYldHc1d4bzNTQldadDB5Y3JlTXA4QVRBUUlwNEltek10TkNL?=
 =?utf-8?B?aUJNRHBVVE84eS8wTS9ZenJnbWlwQVl5Wk10YlhKVUV0ck83MG5IaHJCOTlv?=
 =?utf-8?B?VGc3R3dWYzZ5amppK0w0ZW5ncG1kTWthSzVXTzRpT0RjR3lCeFNiTHhDM1Uw?=
 =?utf-8?B?bGZRZ0VPYVRNR3BvaG1MUk1Ib1FsQVlFT3JxM1cwMEphTlQ0Mkk3Y0xISGJr?=
 =?utf-8?B?aFQ4Yi83Z0FFQ0k0Q0pydEJqYThvNjZwVXIrWERUcUhNNE5SUENFbkhzUE5O?=
 =?utf-8?B?QVBiNjl3bWVneDloKzZiZjFBSjZIcnRWZDhFVFZtbTIwYTNHWnlDekRBZTV2?=
 =?utf-8?B?Wmw4UVp6ME55djlPYmxaYm1UYmI4V2xtb0daaEs2aUZGaXRFRXE4UWR2S3pJ?=
 =?utf-8?B?VmlZYjQxY25rZHIwSXRGaXNkVHloVVFpWVZpeWQ3ZGlaUnhFVi9HSVo1Wnkx?=
 =?utf-8?Q?mC1XQV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 01:42:18.6203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bba66419-c85a-4a60-dcde-08dde053f6f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9618
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

