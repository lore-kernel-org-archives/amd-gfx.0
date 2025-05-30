Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E46C5B552
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 09:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 766BF10E827;
	Fri, 30 May 2025 09:03:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qzd+lQpj";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF23310E806
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 09:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j91+IwqBPf3kDoDrRzXzi55GyQJyF91+3yt49h+1oAsoNGQKe4QQi4+jlKTT8YqQF6jO9UgoTpOQhpYaqFoDdlJjMSHvOzliej8QufVm8qoGjWe6QPXTsHreEjEEGvlI1SLaN7MTkn9+BKX22M1MCqP2k6cQRjyvFjGG59QO+o78ifLyLHB9SoN1VI1VyadEBhUC58orAVPv6la65ALAWnOUeyIxqgJ9Zg54qLTMxDWukXzVEGU5olIBc7gYirPlH/GdG3EO3NCahS6O8wuQ2Ol2dXBeeda5RXloce8kWF0OEZ3f8KeppFmhQ8tiaUcvaaKJPl0q5q+1Mgqw2rdT2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJuJQ8d7DfPtqJJqMt0fnPxdG4QXArM3Xqi9XYnSO4A=;
 b=Iv8feUEp6JQqU3qR4iTSuO7sAhH3P1VOFWnTfORtUVHrpRn4FCGQSmNNFWoIF2C/DQU8dMGj22LXXeEk/cEUszI/tjeOpAS2jUP8kNsSPPO6YLRovKTuYRcvuMtvvMZurJK2SZ40suZQ6DevJagC0IJHrh1JYgsddgMVEBz5gzpR7gswp2yxa2jh6xykdndLE3W2cTCDSq9qkvOm1G2MUuRvvm+c2LdOPS7aDO0WWGg7Du1cNERFLRvfEmYP786ASoXLUPTUzZymJw8nirz9CvdFsrXz0gTHkPYU22L/OENurjeUMrZpu3W8p6M4emV+tvSN4o2ngNMAeI3wsq5RCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJuJQ8d7DfPtqJJqMt0fnPxdG4QXArM3Xqi9XYnSO4A=;
 b=Qzd+lQpjKIl7nZGZXMiY/QWaYgPcUXtULi/cvyzXbIcZPkO9ANZ89txVWsRUGmVuYJIRpwP6rjoXse8SY7LfSHCmFvih4OkZfP9Uo3O7EUJZh0I1nenftRAvKbQE8QBmpmIQzCzacf8u1JqFyrvBsJcT2Vc7tLP742LVLzRIiPE=
Received: from BLAPR03CA0126.namprd03.prod.outlook.com (2603:10b6:208:32e::11)
 by PH0PR12MB8174.namprd12.prod.outlook.com (2603:10b6:510:298::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 09:03:51 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::47) by BLAPR03CA0126.outlook.office365.com
 (2603:10b6:208:32e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Fri,
 30 May 2025 09:03:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 09:03:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:03:50 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 30 May 2025 04:03:43 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 04/14] drm/amdgpu/userq: add force completion helpers
Date: Fri, 30 May 2025 17:00:05 +0800
Message-ID: <20250530090322.3589364-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
References: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|PH0PR12MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 28fc802e-f825-454c-0b43-08dd9f58e52e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlYxYnRZTHZHaTRmR2VKTlFpMDk0YTlVQUw4cmV3alUxYksyTUE3QXlZYkRK?=
 =?utf-8?B?UGxjb1F0SmdaUGZiRTJuTGx3V0xJaEQ2RDB5WDZnK3dBRm16cjdSQm52L0Zw?=
 =?utf-8?B?aXM2eHdxT2dRYTFHclRDMTVGN2Z5QVRkajNTUTFvSHFSc2ZkaWY2SXdsUFBO?=
 =?utf-8?B?RC9jQnNPVitFbkVEbDU1Z3BKeGg3Sks3WkdaNlpwdzJqdjEwUTFpVno4V256?=
 =?utf-8?B?Q3JtMDFJTHllUEZBSzd1d1BzRmdZMGNSVjVuK2JCRnh2eE0wK2htU1BqT0Zz?=
 =?utf-8?B?Sk5rTEVtR2VqbkYyeE5oNVdzWTIzNEJ0azFSRnRYN1I4UnlBcmE2eW8wRHNj?=
 =?utf-8?B?T3JLaVhwQllhRWxHVWtHckhYQXpRSk9XSUhjZjA0UmRDdGdQc2VoNW9NcHpw?=
 =?utf-8?B?SndTb0s5TEpXTzVyMEg4eXdYeTJDd3dVWkE2YVMvNXRGc25teXZSd2VSOCtF?=
 =?utf-8?B?SFFaR0Y3dUNhZVpEamVrTUNNWlE3a2pCdEpTNTJGNWUwd0tjRWo3Vkp3cjVF?=
 =?utf-8?B?VG1EcXpBRVR1YUxvWTBzbWlRTWNvNUFVT0FBYTZFL21UWm9HV2s4MURmeEhj?=
 =?utf-8?B?YVVxbGJnUDREYTJHMWhFajFJc2tNUFVrWkRSYkkwbjkyN3ExK0VSVm1IalJP?=
 =?utf-8?B?MDR0M0p3akp4L1JWUFVRNUpKY1Z4STY5UE9sRENlMHJObjczMHF2cG5TVVNX?=
 =?utf-8?B?dXhpU1JySHNxYWRaUGNPMjdPYXBLcVhNTGQxdWRJSkZrdnJxeEtWc0pQT29J?=
 =?utf-8?B?VVJYOHh5N0hrOE9sZzZiTk5TVU1OMm8wNVdEdnlDTS9aVzJIbVBTMWFqdHlr?=
 =?utf-8?B?Y2FqaDZmOFIzMzh6dzBLaFlST3QwYldEdGxFL3o5a21QQkUvZm1Eek14Mzli?=
 =?utf-8?B?eE5abG9icFhvOFgweDhyaEk1WnRzVzZmUEtBWGlMdFhHdVBOaXBua1h4cWxM?=
 =?utf-8?B?NE5tR1diU2pBcGpWZUNwUnN0b28ybnJ5VE5aUGZjZHU3VXJvTmZlVmxFaEs0?=
 =?utf-8?B?cHZYWjczZWQzSGVRWDRqSGxrWTluekQzSEFYK0RRZUR3OHl3T3hpSW9EeExm?=
 =?utf-8?B?MDAyTlpHWUgvL3Rwd1pnYmhnbCtNMWI3dEFucFRUY3NoR3ZNcWkvUytGOVpa?=
 =?utf-8?B?UWVRZUIrNGVhM0FSQnRvSFJVcHRWWGkrN1BSN0hTOWFkRWhhZlpCb216c29s?=
 =?utf-8?B?NFJlaFdGd0hGMHJ2b0ZRTUhmdGVpTTgzNTQzMWJYRGZKVk5PZUF1Y1d6UUdQ?=
 =?utf-8?B?OEVySGNHdW1rV2pjM2tiV09nNzYyam9sZ1B0WlA4YjV4Y1hZbHRPRHAvSmxJ?=
 =?utf-8?B?djA0RUdKOFFLR2hWbGNvM1BINmxZcU5SMGlPUmdZekRGOXBUdXYvZjhWdVF2?=
 =?utf-8?B?UEdpVXpBY0xPWnI2Mm9zTkg0NS90a1RvalJ6Wm5VNDc4TjdDU1E4dEczcFox?=
 =?utf-8?B?Rm1VSkhFaHVpYnlsNXNIMDk1clFYOEtIZ1N1ZXQxYTNVUXFkTWl6L2FyalBG?=
 =?utf-8?B?VEhleHNNb2NqaXR6bnB2ekJEZmxHWFpTbWNtN3Z4NzI3bzhLQ0VhRTU2U3dP?=
 =?utf-8?B?WHVHYjZETEZZZnMway84V092SlBCWXNaNlZzdmkwL1lmVEp0WHdmR3lSRVNW?=
 =?utf-8?B?ZGcwQlhRSEJvaGR6TStCcG9UbE51YUlWa24ybEIyU28va1FCVTVUSXUxdVo2?=
 =?utf-8?B?VERFNWovaXFkS1pGWWdXakNBQjU1Vmo5dG43WlV0dlZmcDdDZkVSVUtaOG1H?=
 =?utf-8?B?TElyc2RvMy8ralU4dTNhTmZvMGhLczNkdVd0THRPcmplWTFyYnV3RE0rZ1Yw?=
 =?utf-8?B?d0ZPSnVTMmVCc2tSSzlLV21rTTA1VU5iTzErREhkdmNNVjQzY1RJZHl2eWor?=
 =?utf-8?B?RUl0WGlCdHRFMUhvZlBUU1JuaXNQYzc2SnFuWjhBc2paTk1icWVENUxzc2wv?=
 =?utf-8?B?NTNTWC9tTXN4U0c1VHNGYjhyWFJoMWhLY01WL0RwcEZscHBUZFYrU3hJcUxY?=
 =?utf-8?B?V25ydlZrM1ZJTGtsZmxxK1VMQjVPeUpIWUVrKzBrK3MyK01hYXM3dVhBaEpy?=
 =?utf-8?Q?ng5V+3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:03:50.6987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fc802e-f825-454c-0b43-08dd9f58e52e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8174
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
This is needed for userq resets and asic resets so that we can set the error on the fence and force completion.

v2: drop rcu_dereference_protected (Christian)

Cc: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 40 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
 2 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index fc4d0d42e223..e21a82a3b0a8 100644
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

