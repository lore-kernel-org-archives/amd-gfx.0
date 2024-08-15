Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F7AC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 00:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58ED410E383;
	Thu, 15 Aug 2024 00:05:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2lr46YYJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FB8A10E33F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 00:05:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSDCQ6MrFRo/FxMzeTbYv9YlQKfhK3LPE3BpOnv87ziGH6MOLm6kZWnHOoTg09NPcSRudM/c3zAMhuB3+w6T8cm3Q76muXk0RzgX/DcsBJ6aToSPKvSvpWsxdtLyD7/fQdkx9CvW+x9Qk3N6Tcfrqm0gktZx8ga2r9reGSTzvrIVFoQKICePCCPeqdd4/TajIXM6tJ1UHszgYF0OkT7U1LXQI7kfxy6i+5gAWnIQt00UBYNx6nUP9EhJhzLThdAAeKcUGSPAf2IVhF1aEgbjuXkA0SOFZnhYOLTLHFMi50pdCaTo5GsX9MQoBq6H672puENGGKm6E935Pdshhkv5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2p5OPzl08RkaiyqAh2rjWhaUPXdkmf+xy/VOcKf7DnA=;
 b=UbraXyamxB7v8JLKLTz6ne+Wl0TSMlqkBSUVFu1y98Fdt5dvgyZ/wymTBRaiIcrKlKyS75mi6Fcoa2UqNdFRmzahpNg/aziU4xgAeAgtARFknIs0XkAfTIalCtyj33DN0vYbg9cP5Pu0MNnHo2vwJz9xwy1jHkCegr1u2+LmMDXo8Ha2sSrQdYNgeD4WZ1kR/aQhJAsrxTbALzFwkxKY2xfuSmjddGYs5/hRJoBAROBBnUfNIQ9Ay+7UMlCq4iUptvcJOr3DzBzOOQnzRXsRn8QjZMhOCvhI2qZOHiKnr/lr6j49RMsJhgWOQ4qGKOOBOXQCJj1iT+Qdlogm69wqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2p5OPzl08RkaiyqAh2rjWhaUPXdkmf+xy/VOcKf7DnA=;
 b=2lr46YYJVBd4ugwHQKMRWy4dyveMqHQZXVDsa+X3HJpId4902UYeszld9EyKv8sD3aGAHkM+jBt0kg3tiVCngWrTeEIpUTMtXbSB5VaI29s/0o4eFryMQBqKkiOJ6uM/BS7q9972iFwnkltBtlupHg5CWeE+4DkCkQ4hckAx9BY=
Received: from MN2PR04CA0009.namprd04.prod.outlook.com (2603:10b6:208:d4::22)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 00:05:29 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::90) by MN2PR04CA0009.outlook.office365.com
 (2603:10b6:208:d4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 00:05:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 00:05:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 19:05:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 14/17] drm/amdgpu: Implement Enforce Isolation Handler for
 KGD/KFD serialization
Date: Wed, 14 Aug 2024 20:04:58 -0400
Message-ID: <20240815000501.1845226-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815000501.1845226-1-alexander.deucher@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: a45194af-6976-4cea-0c21-08dcbcbdf8a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2E3OFAyS3pDVjJqekhtMEdvUUFsTU5xTFhDQU5TVnR2emRpY3J0NkFQcmcv?=
 =?utf-8?B?YjA5VktYbit2ZHhrdURxbDU0K01hUFRDcEVncXlZQkV5V3pkVHZvR21mS3ZH?=
 =?utf-8?B?dEhBckx1YmJQa1pCUGt3cFQ0cnd4NWRneld3N1JTSkcxa21TZVpLcWJOVUU5?=
 =?utf-8?B?K1VRaVZUNGNpbklSU3lTRDVGWmJDdEgvQ2xpclMySVR5MjZqbWFqNzhaRW1q?=
 =?utf-8?B?bnAySUhYVUlTbVhKQWZQWnJhL3pZYmpBVGJmaXJ0RHJTY1M4OXNrVEREVTVQ?=
 =?utf-8?B?RTN3d1NQbUgyV3hscmRjNWxXRmpabVdrK2ZLY2VRSEF3Qng4ejFTWjk1blVo?=
 =?utf-8?B?ek5pUGRsOHdtUmhhRUN6MWZ5NUNhanpvZ21rTk5RaFB1ZEYxTGVwVndvaXY2?=
 =?utf-8?B?dmV1dGlmZzRRRnd1Q045dXVDMTdaejUralNROHFlWnBwY0N1ZHUxN282YVlX?=
 =?utf-8?B?amgwUzRNN25YTjJLTFZrYnFWTFFnVzRGaWVsVGVtNnZIeUhIVHZpN1RkSFBq?=
 =?utf-8?B?akt6TGhDdS91NnhNZkhaK0hHa3hTclVERklEM09yTkhGWVF6OFNaK0J3SFBB?=
 =?utf-8?B?RlljUkZZdjZCeTlLUEV4NDFjWDFzMEI0NDZSUHdkNk5NemQ3WlN0cjFHWERZ?=
 =?utf-8?B?UnkrSTNmS2xBTWloaEtmT01DN1lXV2F1Y3VlOTFzYUFyOWhRNExjUytuSkln?=
 =?utf-8?B?RUhEei9SaVZTLzdORC9BL0ZqSXo2OHh6M2pnRjlqekRQYkdQcHFEb0tjKzUw?=
 =?utf-8?B?R1l3bzdOeWptMDRBa3l0SVJ1dDVxeStBd1FTRitsWFVSK3ZObmdLMno3dHhM?=
 =?utf-8?B?Y0pmVTFnKzJQTmc2NGFBN0srdEtTNU53SlhuSjZXcVNyYS9iODJEWmhQSjcv?=
 =?utf-8?B?M2hHcm5BcnZkL2tlRHY4anh6L1dCUTNWenZMSHNmOW0rd2RhQVRuN0NBMDdt?=
 =?utf-8?B?blkyaGhka1c0U05tR0k1V1VFM3Vvb3JiQ2lnZmR2WURRU0l5b1dYcWRqMlYz?=
 =?utf-8?B?aGVXUXpSTUpiZVhBOFlZekZKeDd2OUcwL0EvY1Z3cEc3eHBScTdvMWhMRHpr?=
 =?utf-8?B?cnlTRzBvSjU0Um9oSXlMZ3Q1QVh6L1NNVXZGWlVqaVpyTzRyMUs0SmRqYlpz?=
 =?utf-8?B?cTVnOGZTalVkODBnekRyNlAvQUlIVzJDbmVXNHdYSGNLc2lybWIzV2p5Ymd5?=
 =?utf-8?B?VkxIYi9rblBBTC9CN1FwUC9TbzNlQmswalVIYlJBUkN5bENZbUgybDZnc2s1?=
 =?utf-8?B?VnBzK1dscVNMaDZ6VWFlNFcxWTJSeHdxNldmQUIvUW9XZHhucFNsMFAvR2FI?=
 =?utf-8?B?MVNrNXVWVW0va09yYjRVN294UmtQVjQ3NEozODY3ZkRaMUM2ZjdzdEpRZVc0?=
 =?utf-8?B?VVhwR0txcThYcTJqS3hSYk93Mm9ZVmJqUUdRcVFMYXV2WGY3YndFZmFEUmhD?=
 =?utf-8?B?enp0ektQTlhxZHVOZXdoUzJHVTRhWHQzNFVJRTZyMzBqU3B5SS9vS1dYaVVV?=
 =?utf-8?B?UEw5cXB5b3lCVXFxYXAxdklpb2gwdFBoK29WL0Y2YndtWGxqb1NhUDZ1clA3?=
 =?utf-8?B?NDQvMFFwVkdscjFJcGpmNEVodlhRNk1LczJ1c1RiS01EQ0xxVERNUnJETUM5?=
 =?utf-8?B?UGM1eTNTTDFhUC9zNEtLWi9NOTM4UEZuRkJKcXNUa29PMXQvekNqajZvdExL?=
 =?utf-8?B?Tmc3RmxjcE5yWDhCUy9LaXovMGxLNVErVGxCclByVkNWREZXYU5VZU1IRzRW?=
 =?utf-8?B?cVk1VlRhQXQzR3MyNkQycHgrZ2NuNGZPMTNLOEYwVTI0RlRXeTRhYk9SWGlI?=
 =?utf-8?B?MElaeC9lU1kvY3MxR3lMdEpubnp3aU85bTJINitlenVYcEh3aUl1ejE1eE5N?=
 =?utf-8?B?RHJYelgvVTJBanYzUUJLYWtETWNPZElLMHBER3VPTGQ1b1pTcGpsYWdDVDZ1?=
 =?utf-8?Q?Ktkcny34G+OqHyQocL4JWY2lz8dqxHLs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:05:28.5484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a45194af-6976-4cea-0c21-08dcbcbdf8a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

This commit introduces the Enforce Isolation Handler designed to enforce
shader isolation on AMD GPUs, which helps to prevent data leakage
between different processes.

The handler counts the number of emitted fences for each GFX and compute
ring. If there are any fences, it schedules the `enforce_isolation_work`
to be run after a delay of `GFX_SLICE_PERIOD`. If there are no fences,
it signals the Kernel Fusion Driver (KFD) to resume the runqueue.

The function is synchronized using the `enforce_isolation_mutex`.

This commit also introduces a reference count mechanism
(kfd_sch_req_count) to keep track of the number of requests to enable
the KFD scheduler. When a request to enable the KFD scheduler is made,
the reference count is decremented. When the reference count reaches
zero, a delayed work is scheduled to enforce isolation after a delay of
GFX_SLICE_PERIOD.

When a request to disable the KFD scheduler is made, the function first
checks if the reference count is zero. If it is, it cancels the delayed
work for enforcing isolation and checks if the KFD scheduler is active.
If the KFD scheduler is active, it sends a request to stop the KFD
scheduler and sets the KFD scheduler state to inactive. Then, it
increments the reference count.

The function is synchronized using the kfd_sch_mutex to ensure that the
KFD scheduler state and reference count are updated atomically.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  16 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 167 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  15 ++
 4 files changed, 200 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index fac632986866..a5ef0407bce7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -118,6 +118,8 @@
 
 #define MAX_GPU_INSTANCE		64
 
+#define GFX_SLICE_PERIOD		msecs_to_jiffies(250)
+
 struct amdgpu_gpu_instance {
 	struct amdgpu_device		*adev;
 	int				mgpu_fan_enabled;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a6e714d1fe4d..c47122a54dcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4066,6 +4066,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->benchmark_mutex);
 	/* Initialize the mutex for cleaner shader isolation between GFX and compute processes */
 	mutex_init(&adev->enforce_isolation_mutex);
+	mutex_init(&adev->gfx.kfd_sch_mutex);
 
 	amdgpu_device_init_apu_flags(adev);
 
@@ -4097,6 +4098,21 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 			  amdgpu_device_delayed_init_work_handler);
 	INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,
 			  amdgpu_device_delay_enable_gfx_off);
+	/*
+	 * Initialize the enforce_isolation work structures for each XCP
+	 * partition.  This work handler is responsible for enforcing shader
+	 * isolation on AMD GPUs.  It counts the number of emitted fences for
+	 * each GFX and compute ring.  If there are any fences, it schedules
+	 * the `enforce_isolation_work` to be run after a delay.  If there are
+	 * no fences, it signals the Kernel Fusion Driver (KFD) to resume the
+	 * runqueue.
+	 */
+	for (i = 0; i < MAX_XCP; i++) {
+		INIT_DELAYED_WORK(&adev->gfx.enforce_isolation[i].work,
+				  amdgpu_gfx_enforce_isolation_handler);
+		adev->gfx.enforce_isolation[i].adev = adev;
+		adev->gfx.enforce_isolation[i].xcp_id = i;
+	}
 
 	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 76f77cf562af..b4efeef848de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1686,3 +1686,170 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
 		memcpy_toio(adev->gfx.cleaner_shader_cpu_ptr, cleaner_shader_ptr,
 			    cleaner_shader_size);
 }
+
+/**
+ * amdgpu_gfx_kfd_sch_ctrl - Control the KFD scheduler from the KGD (Graphics Driver)
+ * @adev: amdgpu_device pointer
+ * @idx: Index of the scheduler to control
+ * @enable: Whether to enable or disable the KFD scheduler
+ *
+ * This function is used to control the KFD (Kernel Fusion Driver) scheduler
+ * from the KGD. It is part of the cleaner shader feature. This function plays
+ * a key role in enforcing process isolation on the GPU.
+ *
+ * The function uses a reference count mechanism (kfd_sch_req_count) to keep
+ * track of the number of requests to enable the KFD scheduler. When a request
+ * to enable the KFD scheduler is made, the reference count is decremented.
+ * When the reference count reaches zero, a delayed work is scheduled to
+ * enforce isolation after a delay of GFX_SLICE_PERIOD.
+ *
+ * When a request to disable the KFD scheduler is made, the function first
+ * checks if the reference count is zero. If it is, it cancels the delayed work
+ * for enforcing isolation and checks if the KFD scheduler is active. If the
+ * KFD scheduler is active, it sends a request to stop the KFD scheduler and
+ * sets the KFD scheduler state to inactive. Then, it increments the reference
+ * count.
+ *
+ * The function is synchronized using the kfd_sch_mutex to ensure that the KFD
+ * scheduler state and reference count are updated atomically.
+ *
+ * Note: If the reference count is already zero when a request to enable the
+ * KFD scheduler is made, it means there's an imbalance bug somewhere. The
+ * function triggers a warning in this case.
+ */
+static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_device *adev, u32 idx,
+				    bool enable)
+{
+	mutex_lock(&adev->gfx.kfd_sch_mutex);
+
+	if (enable) {
+		/* If the count is already 0, it means there's an imbalance bug somewhere.
+		 * Note that the bug may be in a different caller than the one which triggers the
+		 * WARN_ON_ONCE.
+		 */
+		if (WARN_ON_ONCE(adev->gfx.kfd_sch_req_count[idx] == 0)) {
+			dev_err(adev->dev, "Attempted to enable KFD scheduler when reference count is already zero\n");
+			goto unlock;
+		}
+
+		adev->gfx.kfd_sch_req_count[idx]--;
+
+		if (adev->gfx.kfd_sch_req_count[idx] == 0 &&
+		    adev->gfx.kfd_sch_inactive[idx]) {
+			schedule_delayed_work(&adev->gfx.enforce_isolation[idx].work,
+					      GFX_SLICE_PERIOD);
+		}
+	} else {
+		if (adev->gfx.kfd_sch_req_count[idx] == 0) {
+			cancel_delayed_work_sync(&adev->gfx.enforce_isolation[idx].work);
+			if (!adev->gfx.kfd_sch_inactive[idx]) {
+				amdgpu_amdkfd_stop_sched(adev, idx);
+				adev->gfx.kfd_sch_inactive[idx] = true;
+			}
+		}
+
+		adev->gfx.kfd_sch_req_count[idx]++;
+	}
+
+unlock:
+	mutex_unlock(&adev->gfx.kfd_sch_mutex);
+}
+
+/**
+ * amdgpu_gfx_enforce_isolation_handler - work handler for enforcing shader isolation
+ *
+ * @work: work_struct.
+ *
+ * This function is the work handler for enforcing shader isolation on AMD GPUs.
+ * It counts the number of emitted fences for each GFX and compute ring. If there
+ * are any fences, it schedules the `enforce_isolation_work` to be run after a
+ * delay of `GFX_SLICE_PERIOD`. If there are no fences, it signals the Kernel Fusion
+ * Driver (KFD) to resume the runqueue. The function is synchronized using the
+ * `enforce_isolation_mutex`.
+ */
+void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
+{
+	struct amdgpu_isolation_work *isolation_work =
+		container_of(work, struct amdgpu_isolation_work, work.work);
+	struct amdgpu_device *adev = isolation_work->adev;
+	u32 i, idx, fences = 0;
+
+	if (isolation_work->xcp_id == AMDGPU_XCP_NO_PARTITION)
+		idx = 0;
+	else
+		idx = isolation_work->xcp_id;
+
+	if (idx >= MAX_XCP)
+		return;
+
+	mutex_lock(&adev->enforce_isolation_mutex);
+	for (i = 0; i < AMDGPU_MAX_GFX_RINGS; ++i) {
+		if (isolation_work->xcp_id == adev->gfx.gfx_ring[i].xcp_id)
+			fences += amdgpu_fence_count_emitted(&adev->gfx.gfx_ring[i]);
+	}
+	for (i = 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES); ++i) {
+		if (isolation_work->xcp_id == adev->gfx.compute_ring[i].xcp_id)
+			fences += amdgpu_fence_count_emitted(&adev->gfx.compute_ring[i]);
+	}
+	if (fences) {
+		schedule_delayed_work(&adev->gfx.enforce_isolation[idx].work,
+				      GFX_SLICE_PERIOD);
+	} else {
+		/* Tell KFD to resume the runqueue */
+		if (adev->kfd.init_complete) {
+			WARN_ON_ONCE(!adev->gfx.kfd_sch_inactive[idx]);
+			WARN_ON_ONCE(adev->gfx.kfd_sch_req_count[idx]);
+				amdgpu_amdkfd_start_sched(adev, idx);
+				adev->gfx.kfd_sch_inactive[idx] = false;
+		}
+	}
+	mutex_unlock(&adev->enforce_isolation_mutex);
+}
+
+void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	u32 idx;
+
+	if (!adev->gfx.enable_cleaner_shader)
+		return;
+
+	if (ring->xcp_id == AMDGPU_XCP_NO_PARTITION)
+		idx = 0;
+	else
+		idx = ring->xcp_id;
+
+	if (idx >= MAX_XCP)
+		return;
+
+	mutex_lock(&adev->enforce_isolation_mutex);
+	if (adev->enforce_isolation[idx]) {
+		if (adev->kfd.init_complete)
+			amdgpu_gfx_kfd_sch_ctrl(adev, idx, false);
+	}
+	mutex_unlock(&adev->enforce_isolation_mutex);
+}
+
+void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	u32 idx;
+
+	if (!adev->gfx.enable_cleaner_shader)
+		return;
+
+	if (ring->xcp_id == AMDGPU_XCP_NO_PARTITION)
+		idx = 0;
+	else
+		idx = ring->xcp_id;
+
+	if (idx >= MAX_XCP)
+		return;
+
+	mutex_lock(&adev->enforce_isolation_mutex);
+	if (adev->enforce_isolation[idx]) {
+		if (adev->kfd.init_complete)
+			amdgpu_gfx_kfd_sch_ctrl(adev, idx, true);
+	}
+	mutex_unlock(&adev->enforce_isolation_mutex);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index cb83b66aba89..eb556dee5a43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -34,6 +34,7 @@
 #include "soc15.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_ring_mux.h"
+#include "amdgpu_xcp.h"
 
 /* GFX current status */
 #define AMDGPU_GFX_NORMAL_MODE			0x00000000L
@@ -343,6 +344,12 @@ struct amdgpu_me {
 	DECLARE_BITMAP(queue_bitmap, AMDGPU_MAX_GFX_QUEUES);
 };
 
+struct amdgpu_isolation_work {
+	struct amdgpu_device		*adev;
+	u32				xcp_id;
+	struct delayed_work		work;
+};
+
 struct amdgpu_gfx {
 	struct mutex			gpu_clock_mutex;
 	struct amdgpu_gfx_config	config;
@@ -452,6 +459,11 @@ struct amdgpu_gfx {
 	void				*cleaner_shader_cpu_ptr;
 	const void			*cleaner_shader_ptr;
 	bool				enable_cleaner_shader;
+	struct amdgpu_isolation_work	enforce_isolation[MAX_XCP];
+	/* Mutex for synchronizing KFD scheduler operations */
+	struct mutex                    kfd_sch_mutex;
+	u64				kfd_sch_req_count[MAX_XCP];
+	bool				kfd_sch_inactive[MAX_XCP];
 };
 
 struct amdgpu_gfx_ras_reg_entry {
@@ -561,6 +573,9 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
 				    const void *cleaner_shader_ptr);
 int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev);
 void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
+void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
+void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
+void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
 
 static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 {
-- 
2.46.0

