Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A2EC2BD09
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 00:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D267B10E662;
	Wed, 10 Jul 2024 00:32:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="se+UXuY6";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96BBB10E662
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 00:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRKIlTXFr2AclFtIMzVuOz3/nZT7BpdVlRkthWcrW3qCtJNDZ79lgs1Oi2xlPaZa4vs0m3ZOprcw/0uaiXcEEtmog2t5RAyeVI+uJmSXsApx2lKUOQDcDJ81Yvmty6N9YOs6TVmH26SdCpidvCjbrjyCOeYlCoQyub2Xv0VEq3avM4hDwBTu123rKnYew2bGBD6dLNbRfVQnOi/ge/IjbEDLfQGxzZB7qM1X9suu2jyI2hnWZ/QNfOwn+uCdcYMANHn63fxDOXavrPTRAx45K2ECZSkorErhO3CF7o3qIYcEVlYMMaPKmFbdcvmAdXwyNoMr8Pvmh885CohdWHefEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xf4evZjiBuPYMR6nnMHLvg6U5MhxQ0CpNvuU5iAuFrY=;
 b=ch4lJ0k8ziVrTjXRxzT538ZUUd0dT7f3UhN25Fwlp47PhEreJogk325JiUdiia/vrggcJCFSHzw/nlQZMvmDS4wISILGu2tv4hh8P8vKDi0oheZ4R7qBR/T0a/SUMugafBaHBBBqSOv4MCmi5GYwreu1RhPFoIgmE/H0fTNZNKMglOqRU6AWTvd+vPy48q06/0Zf0epDFDkAmxHSi0GAHeoeMJIfDz8JKIYDvXsT5N/klEBwrx3TMnyL26iAYgoojevio0IHVTDH8lwdHJjO7cWYVwWHwsP1XcFaYG3xFpazekz5F9XdqP+LdW4ClgbGSEudt9orK3SHgFvAX6ZWbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xf4evZjiBuPYMR6nnMHLvg6U5MhxQ0CpNvuU5iAuFrY=;
 b=se+UXuY6al05uxXkCwFcFOxZva2v59w7QH1aGb61RTnGBP95j1qyTTMUpWVDLR1IjL36yZ6LwpciqCBz5iumS21xC5dqZA+hd8fCLvxJvNlOx+iyLTLJIVpPRLVAZZ4QzK7IGwuK+TbMLzxyoRSTh9msUW6TRd2o2waX5HfY2Y0=
Received: from SN7PR04CA0163.namprd04.prod.outlook.com (2603:10b6:806:125::18)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 00:31:58 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:125:cafe::ae) by SN7PR04CA0163.outlook.office365.com
 (2603:10b6:806:125::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 00:31:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 00:31:57 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 19:31:21 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH v2] drm/amdgpu: set start timestamp of fence in the right place
Date: Wed, 10 Jul 2024 08:31:01 +0800
Message-ID: <20240710003101.1645322-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: dc452728-bdd7-4d28-4a7c-08dca077b4f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nZ3hzbPUkPgb8/e17Lfjd1hyzrmDOK7zjePXDUKbJ+lHQuIcK73uJJYmOsxo?=
 =?us-ascii?Q?F5tIxWwOPiijaSPUJ6MjD1byr+yAuw2W9KDwI1C/g3VbQHsFh2KyPt6AknZb?=
 =?us-ascii?Q?kxe5VQbQv4Yybi/uCkK6QA8OOeP4tzHAVyWzUSq4LgUgnPXuDy7FOCaxZick?=
 =?us-ascii?Q?+5oEtsdElkEqnEEV8G+Wz6e1VIH801K0Z4vzXS0znhFrN0kZI/aE6oL346zg?=
 =?us-ascii?Q?tcbjq9o5hwp1RYWEZisUaFlq3MCm/M1uw7igXi9fVANcR8TeeumWO2QQDU5e?=
 =?us-ascii?Q?W0SIrL+FC5duusXwqR7cM9fflhjW3hR1DpM2B2uLG42kEt/vwZ+9OaSlHDJ7?=
 =?us-ascii?Q?N8ddog5hY6i1lfAM7Q1MZdB2mfcpjX7k2IcqbKF3PE4PYvddZCXfxFYyU+uE?=
 =?us-ascii?Q?ILUNyzf5qPr4zhxscZQQ1A2IoP7Iu97DlYdAEj+1jOpZBSwunVutsu4lJ65E?=
 =?us-ascii?Q?2L6ZXb4SXNVRNV+Vm8x3nAID+8J7JC5ifHL/L6iFy7oaMJs2O6GGu92mWetA?=
 =?us-ascii?Q?79OOoEv3ozJs4HxUPOr6yihbnqPL/0hhhzXVk18GLr11PW0vASAljwa8v1Pn?=
 =?us-ascii?Q?jK0EWLzcNYsZNuhzi0jdinfuAxHshHtZQ9QfiYXE5ZeoWZrOxsoLx0bHtNum?=
 =?us-ascii?Q?LaykwJUQKc5AbQubIEKI3d07+vAfQx5ijeoRRbW+uEe+KfPzhJ0hURC/Y3d3?=
 =?us-ascii?Q?F62zjrE94Ixxdgu6oj3sMXt815ou+tSKBrRRq7D+H9zTpKTIPaPTDLT6cHl2?=
 =?us-ascii?Q?+KsOoK2ijc+gBYix2Qco0IqyOBKhJdRTocEnBmh3jK2LctC7o0Gv6Q2CyxR2?=
 =?us-ascii?Q?7CbeoNCjTiRuEVQ6SWDU+C++llMrmx7NQcURIPah0rWX2l3V5raGmvBbzRn7?=
 =?us-ascii?Q?KT2V4HfOLa/NJ89V64aadEoUOnBk2TcshIei7w14YfPRGcjLlqPWayQjCmqx?=
 =?us-ascii?Q?tCLiqSLBoVgTaHaSJIi4sOtLq8IW7pCGxk7C/h+n+yww04JZvDXOSbvnqFwv?=
 =?us-ascii?Q?w1XcrAhHAk6YSqJTm9W7OQluSV6/LHRKjx50Bq++PVztVwN6TBLdZQprht+1?=
 =?us-ascii?Q?huCTocUn91owe0qxkdO9QYMJiTDWLw5FFYZsOJgz6TcA44TVGZ25Lv7R2pPg?=
 =?us-ascii?Q?1ZriBGmslyPt4hD+1FBmXanRAo5uvBBtLdBy3Fc2PMnZDyACcRH6r7+adOJ1?=
 =?us-ascii?Q?Jn3Fv5YRx/5lfr0Epi1kgDen/8J7UtOEbEQ/Y56t3j2mCGvwipSvoKBqYOHq?=
 =?us-ascii?Q?F2VQaNeAGZ/PW0qf3YH0MqF+2RHYPaSh5GEU+znJtNoA1s9L5tdaedpjdtPs?=
 =?us-ascii?Q?6/Ay5Ex0exu+5ursLp9NiaXAoiqv+Fals787cOiu2kwolGUZuY6FOcv1yP1j?=
 =?us-ascii?Q?NUjfGaOXtria1fB9HkKYenAmvKc4fJ9vEkzfyR1+FGajC+qB5JRLZYWTWBk2?=
 =?us-ascii?Q?+0srGLc9DdFwQMeWLj3/ZTYdbgj6eKC2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 00:31:57.4859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc452728-bdd7-4d28-4a7c-08dca077b4f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683
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

The job's embedded fence is dma_fence which shall not be conversed
to amdgpu_fence. The start timestamp shall be saved on job for
hw_fence.

v2: optimize get_fence_start_time.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 31 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |  3 +++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2f24a6aa13bf..72bb007e48c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -88,6 +88,31 @@ static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
 	return NULL;
 }
 
+static inline void set_fence_start_time(struct dma_fence *f, ktime_t start_timestamp)
+{
+	if (f->ops == &amdgpu_fence_ops) {
+		struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
+
+		__f->start_timestamp = start_timestamp;
+	} else if (f->ops == &amdgpu_job_fence_ops) {
+		struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
+
+		job->start_timestamp = start_timestamp;
+	}
+}
+
+static inline ktime_t get_fence_start_time(struct dma_fence *f)
+{
+	if (unlikely(f->ops == &amdgpu_fence_ops)) {
+		struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
+
+		return __f->start_timestamp;
+	}
+	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
+
+	return job->start_timestamp;
+}
+
 /**
  * amdgpu_fence_write - write a fence value
  *
@@ -197,7 +222,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
 		}
 	}
 
-	to_amdgpu_fence(fence)->start_timestamp = ktime_get();
+	set_fence_start_time(fence, ktime_get());
 
 	/* This function can't be called concurrently anyway, otherwise
 	 * emitting the fence would mess up the hardware ring buffer.
@@ -428,7 +453,7 @@ u64 amdgpu_fence_last_unsignaled_time_us(struct amdgpu_ring *ring)
 		return 0;
 
 	return ktime_us_delta(ktime_get(),
-		to_amdgpu_fence(fence)->start_timestamp);
+		get_fence_start_time(fence));
 }
 
 /**
@@ -451,7 +476,7 @@ void amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring, uint32_t seq,
 	if (!fence)
 		return;
 
-	to_amdgpu_fence(fence)->start_timestamp = timestamp;
+	set_fence_start_time(fence, timestamp);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index a963a25ddd62..3a73fe11a1ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -73,6 +73,9 @@ struct amdgpu_job {
 	uint64_t		gds_va;
 	bool			init_shadow;
 
+	/* start timestamp for hw_fence*/
+	ktime_t			start_timestamp;
+
 	/* job_run_counter >= 1 means a resubmit job */
 	uint32_t		job_run_counter;
 
-- 
2.25.1

