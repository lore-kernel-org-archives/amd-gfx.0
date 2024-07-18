Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4738FC52CDA
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3F4710E904;
	Thu, 18 Jul 2024 14:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X3Jn+Vf3";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19A6A10E8C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohxUH0aZNm/iIzWm660n2TWCQay3xGuJb908X8MiZMVcmc3XKaQ6v7QmpNYHZ22EGP80ZZgpiEv2rK0vvCk2x0myUU7WTUEySdwjXIKbWrKdnPMOYBBLsydFLAewnx+iZ/jzA6ppNeDk8ZayOLnR/vqic56+23oqArtL75xxw6RQCq37MXb9bIciUg4PPtLI7LF/sQN9UMjNU2UTsbm+cqbVg0u3bFg6lGxWJucG1DhZ+quS8YA9UurBGEiJjPio6oOM6CL+r/Ct3rmuN/SG8sAo0rYniRbuTtL4muhtj7Y3ZuSgEqalk4I/38iPHRc8Exa5a85muoIa6uyOxo2Rkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ld7rzqxmV1HwbfNV+yh87HEMGBIf26BxtTSIIewXf3k=;
 b=KT7/sOc0F84YRAhz66sHA5AhZcmnWAOARQbd6Q+jBrEKMmsUFbt7mSQiMct2mZ2wflEjrD/5MN/rRuhxFAhk4HyZC8g5nPb8XgIkr2cv9E+S1QwhudOOXsvb/XF2mlgGBhR7gqxjVWaiTvqjgl6x407L0RO0zpWYas7vuMeH5CqV+GfiRkRJCyJvTMSAwFDdhvWVT4Ix507oIJyoU+fd7rjxA6f3eKLHkcIcA5hYxWcsiQ/wRdX7LFhMAg7mIaiCGmCDlpVAXuBbwtP7a/2RkcJNhk9ckSChHbLvclIhm9cAGvGVgtOb+pDug4edK253IFwN55Zhyzr1rCHLMwlJdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ld7rzqxmV1HwbfNV+yh87HEMGBIf26BxtTSIIewXf3k=;
 b=X3Jn+Vf3GrvDc8jTYVf8uyKPAArfENaQbBYinXptUf+GIZf12owQTqgBWK6Igj9tLB5rb0AcksjRl3lmzg1+qo7cKC0rHjwVQz/VyMGb7NmxLGJCTXcwx5Tv0usGatsTGL5CEyJANGnH7gZeGjS60Enhfsuc9f7vPkgX5rlaHJo=
Received: from BL0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:207:3c::27)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 18 Jul
 2024 14:08:05 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::e1) by BL0PR02CA0014.outlook.office365.com
 (2603:10b6:207:3c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:08:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/34] drm/amdgpu/gfx9: wait for reset done before remap
Date: Thu, 18 Jul 2024 10:07:19 -0400
Message-ID: <20240718140733.1731004-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8ea606-9b18-4fcf-7fa1-08dca7330b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8vWUixQz/Q5SbQ08G9Yb+RwG0ZKuZN3JN7r9mJs2nGRnCkeLbaINRqPus35I?=
 =?us-ascii?Q?KHW0WNeugCjlSuqfR5qxgARfJCiMSjWh4Tfg64UjS0lnEVCoQQ3+4tQYulWz?=
 =?us-ascii?Q?JTlSUqsvCpeBs+epXvrsm7WY/PSyf2enUxn81zkQpJ9XjharsCS2rQnTC47m?=
 =?us-ascii?Q?1rb4ZjKh7EI0uJr+Rsz7V8eOW6fX2LKfSUztEkPGg/6YfsuO+5UjNwm7lc8O?=
 =?us-ascii?Q?A12czJkSF9BEPi8UIP8Mx+yDfT/tlRrUDCCklYCPSATMm9dE7a6EzNtCfxgw?=
 =?us-ascii?Q?M0Yt4lQ2Rf6ALHl66TT5MRCv+TCHokCagReGDvOCm964e3cpyXaxwcR4Al4+?=
 =?us-ascii?Q?12Vr3xta+c+f0bLDezVAm8dEyYqFNM4XtIKIun0/q9mFZ33FwnIYdRaOA/Av?=
 =?us-ascii?Q?MdGohxsY2YjIlbFR+lANZIa2ckyhmjaolQYljfAcQCbWXmS9s8eSBlu46Lix?=
 =?us-ascii?Q?EIG8RkKZ2hVvMkKfU/Q2XPSUYdSSH9aRGHpoWaqEWCXeGw8/bwqSK1OZBZA+?=
 =?us-ascii?Q?c9c/oEIkYxQWBdj6yOuippyjyaKfqMWS5OIJCQZj60Xgo2HEX/3JWEUbl70t?=
 =?us-ascii?Q?yROXaJ0Vyzqkm2ikvjE0IHRpK7Fy2ccTPy9iuqsbGsIS6iJtMNIWk2AUn84u?=
 =?us-ascii?Q?PyD++Y0HDpc+GgQpLmHP38J+lBJdn8+SLs1EvIA3zEUs6vcmHtfYUZl4LT1c?=
 =?us-ascii?Q?ojROv4FrHH8s4zU94hFrWX0+Qc5EKQWGJxuZBPsbVV9Fknsz4xJKobOYMowT?=
 =?us-ascii?Q?3y4NObePJXr/hc+I10a3iJ47e6WmD9YHfqYIPrasSs6WP9Y4xa+hsmbRdJVv?=
 =?us-ascii?Q?LQgtCCK9IDJAQeTKmg/VpYBTLCCQNFgXZ58MbWCxlxHW94lVd3NwRo6uSX2q?=
 =?us-ascii?Q?KRjcdwU03gpNfQrKpDipsgH/W7b0jB0mqYoErSemUFSRCtBM/G+pruGPW0G8?=
 =?us-ascii?Q?Lguj0w8gxMedJSHIsedTIzR1h8U7YRK2ZkTdrWJ0OXN7pWTfuqMYO5UHvKu8?=
 =?us-ascii?Q?xgaQR16t4QVzy72GN7/QenTl/dsxTxa5RcY4hF8+/nvjdKH7r8XZQJ+4YOyB?=
 =?us-ascii?Q?ohYN/Vy+X46D5EIsYnbVFEn1wwfYftjPSu42i9BXC65oN0YLQMGkmYH9AjIY?=
 =?us-ascii?Q?LalMW10X+q1h4nz0rh4h3kyyxkb8hTa+JUP4iHh0wiXqgvW0mfmGatPUXq0D?=
 =?us-ascii?Q?7qZ255icKJqg1GQ1yPMWYa6GK09+Nd+zfLIiD3P2EMVRP+4ScdxboQVGsUj+?=
 =?us-ascii?Q?h6Da8/NpajiHEmeQC6yHUjWphNqsZfgUJUFGaCJlTt14dS3610q5PkKwAEdh?=
 =?us-ascii?Q?25eYdMfmXKrSp05bszNknFV1yVjQiHrycgLg4c6x0CfFMpbLCU+7EZRj8xgZ?=
 =?us-ascii?Q?FdHkJckvWOYIBj+n5RnCjPc7YYjg6FLUuFx/fN6+Mtdm2S6YnmJtMsbZGt3c?=
 =?us-ascii?Q?Ygv42gjDhPi994jhCYCwhk48Of1HkD2q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:05.3810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8ea606-9b18-4fcf-7fa1-08dca7330b4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

There is a racing condition that cp firmware modifies
MQD in reset sequence after driver updates it for
remapping. We have to wait till CP_HQD_ACTIVE becoming
false then remap the queue.

v2: fix KIQ locking (Alex)

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 35 +++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3a819c6923c6..fdc3fb636e02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7107,7 +7107,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
-	int r;
+	int i, r;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
@@ -7129,9 +7129,28 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
+	/* make sure dequeue is complete*/
+	gfx_v9_0_set_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, 0);
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1))
+			break;
+		udelay(1);
+	}
+	if (i >= adev->usec_timeout)
+		r = -ETIMEDOUT;
+	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v9_0_unset_safe_mode(adev, 0);
+	if (r) {
+		dev_err(adev->dev, "fail to wait on hqd deactive\n");
+		return r;
+	}
+
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
 	if (unlikely(r != 0)){
-		DRM_ERROR("fail to resv mqd_obj\n");
+		dev_err(adev->dev, "fail to resv mqd_obj\n");
 		return r;
 	}
 	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
@@ -7141,14 +7160,20 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 		ring->mqd_ptr = NULL;
 	}
 	amdgpu_bo_unreserve(ring->mqd_obj);
-	if (r){
-		DRM_ERROR("fail to unresv mqd_obj\n");
+	if (r) {
+		dev_err(adev->dev, "fail to unresv mqd_obj\n");
 		return r;
 	}
+	spin_lock_irqsave(&kiq->ring_lock, flags);
 	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size);
+	if (r) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	r = amdgpu_ring_test_ring(kiq_ring);
-	if (r){
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+	if (r) {
 		DRM_ERROR("fail to remap queue\n");
 		return r;
 	}
-- 
2.45.2

