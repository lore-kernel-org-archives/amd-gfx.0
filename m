Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD8AC43602
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 14:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F9B510EDA7;
	Tue,  7 Jul 2026 14:34:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kxufMI5J";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012049.outbound.protection.outlook.com
 [40.107.200.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388B910EDA7
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 14:34:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1i4pUayjvEh1nrh7rmGswNzAz8ga23XgKkPP7tbncGvyFtFX9lyRRa43020n2/PGku6vkDoNHkPZwZYkZztv36TOF/PkujMAFTh5HBKWQro9zTn0tezUjPlntkSCAkgUJsmEhzoYa4XOSx2vQt4Vi7KrLbnIDlcUPPCBwLHe/9fcV7DwH/jpaWv/50ZbAMzhq4NnOeEAWWelBPSjUlF8kehn1lRJ0vicGEr+r479KKu/SLCdIqo/u1o4Ov7Rb1sSmSHOyV6cpVbKSEMD2OSXhDhWbSJsZconjZp7xH2/5EfWJaDcijjOCW8SUwZFnjZ/3Kp7nhMfRndlsdde8lz8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVjYvbRiQ4+2cASyd5HNURuhFJbKfl8/T4Sm26jty/8=;
 b=T3I+SNKcR/1JIeltDcHL87L7ukIVULfRHGNYKA4L0C4W8JQqAwLCrPxzkL0dpy6BYjLrYQOOHlxjg4V8TENRCqG0Xnk4NH2Md1BgS0rvFsmFoz3QNLwBGhPJNq3FlHSTBCIgGbGyeN23+oC2CSjELoFxF+ytfKqnCn661WLIz7ZMErWfBW5AcKEBN2PZLxOmEjQyzC14wY9oF2w9ixFcvo+fGkuOgkJ1l3w1rYOtWJeJiqtnsqYrAiAQFrHIghAWUXLauH22KoAumCvSYAh1MGcGoXpM81fKJEz+caXjNg62tMUlFmDRYQMOIARfRLvj4o1gQxT5IBMkePrDUymAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVjYvbRiQ4+2cASyd5HNURuhFJbKfl8/T4Sm26jty/8=;
 b=kxufMI5JTxTe8/vVPRjfKdTA0bSbkOu2pzaDZ9+tcuVBEaO1tGvHcuQ09uWl/4BYpmuxPWlOTk2ZEJPJivKhA22+nUW6G8s+hqU4o2HWSZ6Ax+egwHy9IuoYW9t+7wra9N6c0rb75gCzzJfJ4tmgb6aWBAmHO7XsJpMyYM1KNB8=
Received: from BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::7)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 14:34:34 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::2b) by BY1P220CA0020.outlook.office365.com
 (2603:10b6:a03:5c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 14:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 14:34:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 09:34:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 09:34:31 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 09:34:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: disallow gfxoff around gfx/compute/sdma KQ
 reset
Date: Tue, 7 Jul 2026 10:34:18 -0400
Message-ID: <20260707143420.2104857-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707143420.2104857-1-alexander.deucher@amd.com>
References: <20260707143420.2104857-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SA0PR12MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: ae97f146-bcf9-405c-e507-08dedc34dbdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: EC/n6Sr9KwjZsOWMn8l3S4vIgejBtTJ6YG86GQ1vwL2QnxRJ6S1zNIRvIvzcecNozhaeFkh6qP4Ok4cbXl1KkCqPowjdV+hrsyz/Iez73mE4z4Vc7hVJH67DlYy57wXB4zltL1+sIdrenUnkTdM3roTTkZ+GMC49XxR+q1rurPVlghgntYYGLZ2WvlFsHfqfHq8WR0bURmk4fphkIgnyRfKUQ8ewNdj/GFM5AQD56hNP4UXYC2trjL7g8CMP74eMaRdnGLXkyy0lrRikLsxLjN437wMOo1JSKOAwpWVV7RxWMc0J0cZcZKhEBK/N1ecPbNYHkFocYIfnayvptd+KXCm7oMnUCnJ//SmHJoV07v4ed004K/s9ouNB8cejbsI21BF1g9Pp8xKptkCBk2SqU56VcvPN0O/buNpc3uAgdPqzAy8xTvIVUFErzIV9GRrLaP5feeklCBb9MP1UZKAWuZKntFTWwe92szHXotOlJHOp4XKey+b5gSEx8HhbpvH1i6kgic/Ycv4Q6ODJR10p9AnL52DaLXyvoRz5J9DvPjByarZD75xg/7SuEc/FH2rBtB3JW7RPelgfZZSCE1tVN6S9x6h/aleLXPQ447imOMbJ08ZeEfdniz/CzIeHc3C03hvickeYxq8dtSUhT7W1t3RZUyZGnhmQn0QP39Ws83EGBQwDZx1m0cKM+wjSTW3MxiibN4J83oLbZhKaYjRGQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YLQY6daT68MqmLEAB1ZtJaYscuFE2Tu3kRSwNV1e8PFMMJ+MXf77eGq6i/QOlGMDIoJUt4QwIcZs3MNp2YP+LjzX3a4nAITazVTIJXoXkhC00hFPOCrFyB/87K9CFeznb9dstY4mUu+frb9bIcWDIRqLVoDaZQf9Q46JcKWefZ5fhNwZ1DimA+BMXyqVYzwlkN78Uh9GRo/Gbg7B67X4NOBH5YR3EVRmwaJ+7at5zKJXjmySTNn9QctE+NywO5FO1tAsrS5eM5kc2dsF2g4lUuMW1sCJFpI+R8zTY1EMNfQpCXVOeXeHrz5llpyTLUlAIrrr9ShJafPVAvaiEGHHn77AO7h/CFYhzjk4R5duOR6Pp8JaOD3cvZnZ3WREhIsyQVfUTIHNM4ru9C77f90A4RzpPSFKXPTv4HowMvcNWashL8saCjkms4h/4ZLudhgt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 14:34:31.6997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae97f146-bcf9-405c-e507-08dedc34dbdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
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

If the engine is hung, we shouldn't need this since it won't be
powered down, but we could potentially have a case where
a queue can be preempted, but due to logic errors in the commands,
the fence never signals.  The engine could potentially go into
the off state.  Protect against that.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index b5c2d1d4d8839..c8a1aa88a9de0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -137,7 +137,15 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 			s_job->sched->name);
 		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
 		drm_sched_wqueue_stop(&ring->sched);
+		if (ring->funcs->type == AMDGPU_RING_TYPE_GFX ||
+		    ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+		    ring->funcs->type == AMDGPU_RING_TYPE_SDMA)
+			amdgpu_gfx_off_ctrl(adev, false);
 		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
+		if (ring->funcs->type == AMDGPU_RING_TYPE_GFX ||
+		    ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+		    ring->funcs->type == AMDGPU_RING_TYPE_SDMA)
+			amdgpu_gfx_off_ctrl(adev, true);
 		if (!r) {
 			/* Start the scheduler again */
 			drm_sched_wqueue_start(&ring->sched);
-- 
2.55.0

