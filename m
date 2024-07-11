Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147BCC3271E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jul 2024 05:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1D7E10E322;
	Thu, 11 Jul 2024 05:37:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nXqcqcTQ";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE43410E322
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 05:37:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOi8xObV0Br8eSV1+kDskU6gF5Rylsxl3bQpo+pCWnvZcTiYbbksK0qNVHBL/CGxAqfgH+WhIxvjP2WY16pSItsdbEJveULCGLMULYq7YHUt2bQuIITCkHzR+40rfPociX/aXBx/M9nt1QFvhL6LmwtIFogj0C3YjJN44LSHJdQ1F43Um2Ajkb6KVZ9/LA5bM84Lo8Tf39QT1LhWTDq6O4aM3VhwbyibYinzgNLGkxz9zlj6bG3wXvgjeW5QFu8nPmEPDKnyBLIsQk30YMbT5ffepOwhmfg76mj9Tt2TeaMNRRvpoV2ELq3FZkj4FZwgx9LPke+3qYCP2p2WbbBMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aC+wjcMRh1vqlWZk1FISJy82WXYXIfgqS3CDpN3NxT4=;
 b=G++pbQDu9YD0Q1IMJG/S4y0vTc3gC246LfYo9VCRoHXKphpC6Hae7NUMg16Gbp/V7+XMtHARw+OREN3zxLmqjFSNqO4gWOroYcyCnsaWhyYMMt285CVM8Y2zXxDzNd9p7HA6sJTd1T4ri+1+p+j4k0paNQvt5BcJ1TvafsvjTCCiIT7stPSZU8ZpzglCYZlxQ74R+pZMJqHpwfdb9BGKRX8OqXuF7JM5QkEyvaVb8rglt1+idVxTPq3N5jMqV/wVWXRAynq8Avm8hixM9WY4fW0i0TNAmGL4VDdxQFW9bFdsfIv2aW0LWdA7v08e1n58S/4XrV8ssfHh3ddUy3lAIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC+wjcMRh1vqlWZk1FISJy82WXYXIfgqS3CDpN3NxT4=;
 b=nXqcqcTQSaMt6vgob22iBsBH0R4JG6YjnL5g+ni0DUcNvZohPWAWkrm0Eqqv8G2eYLAUxoom8vvLqHj+2BIw+ula3jqZM56sc1gvGDAQLCd6d3+Y1b9Dm3KW1Wxd7eojnqhmh1lsvHHQ17rPv++hd5Wx/5MMsPIfMra+WWDS90w=
Received: from MN2PR08CA0023.namprd08.prod.outlook.com (2603:10b6:208:239::28)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 05:37:53 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:239:cafe::cd) by MN2PR08CA0023.outlook.office365.com
 (2603:10b6:208:239::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21 via Frontend
 Transport; Thu, 11 Jul 2024 05:37:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Thu, 11 Jul 2024 05:37:52 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 00:37:50 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH v3] drm/amdgpu: set start timestamp of fence in the right place
Date: Thu, 11 Jul 2024 13:37:34 +0800
Message-ID: <20240711053734.1656977-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4a6eec-dbf8-41fd-42b4-08dca16b9bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?84A2lmQNux9us2Uck4QXbmgw3h4oZaGJ8ItXnoGgAecT78FdmPMKJnLWemyb?=
 =?us-ascii?Q?ADDi1FNvKACi3G9PUtqjeHdPSI3qnC/SqnW4+KfbBFNdX8ivV6OiQKwtOMs7?=
 =?us-ascii?Q?bR4/Z+YGBxuzyTvy0JjKmddlHoY5v8ScgKFV7rTKzOJ5gOqTVwsTY2OUt9wm?=
 =?us-ascii?Q?w3GPr6xtY1UEF7et3IQ+s8lYvCA1HzAgv9p2awulIWgf8/DmJdr3vMrGodsG?=
 =?us-ascii?Q?yNwvx1sInYJVmy14flnIoEuLMiqg4f/b6M6lhjOWg5yNrcPOkxE3UomVNIUU?=
 =?us-ascii?Q?REkh62y3WfeNmRMmtoYQAF+TpXpn/OF/dk/Xl0fkCE7pDPi0/mYFcFSudDKq?=
 =?us-ascii?Q?fQRPcmos0eDIDMIATRYoeNBwVg4Hy4JLLSbc4LU8LSxVhK7L6C7CrNNDVXX1?=
 =?us-ascii?Q?YAPBWO5Yb7gRp+JUloYcN4m3DOajYuUHEzx0ZXVzQNw2RYdvnPKcwUL+Ha8l?=
 =?us-ascii?Q?A+xgX1taF4ZE2uOfBFHdkZCj2luO/D8y+0SI6o5tPD00H25x2M/WiwcProqS?=
 =?us-ascii?Q?f1hVUq0MPvLf1AoAbga0UK4nDoBsFpIvrWMRhVONPSHl5ll8QOa1sq1U1ZJZ?=
 =?us-ascii?Q?wsH3wdlM01lDCyoK7J7CL/dGxU4W60tKJXvPI0SuYHphiLTHbIWWlUO0E51+?=
 =?us-ascii?Q?CXVtaRXcuAHZLnL1o7hKdsf9kDFmjX7fBNH91cvj0WHepEQhDdTEqh+bsT/1?=
 =?us-ascii?Q?B5aADnHkiWAF3XVZLWPCV9QTrwAtuKJgXBxBs7WIKDqBqxTmSOjY8zsdLH5t?=
 =?us-ascii?Q?aRL54u+TnV7XyTFijUHgiRuljRB6G4GXdy0dskQ2tMZDmKNDdUlGvnHzyPFK?=
 =?us-ascii?Q?oguhxlqqBSIxGvSiFy31Fb4NXiu1K1uoOk1s9oBzkX0dcSxP2242DZ6oe0Vg?=
 =?us-ascii?Q?4HcGk+3M6TVutIz9e+bNLK1uRSA4S7QL6NOibnrlfwO3iACwY7TxQEoHWeHv?=
 =?us-ascii?Q?dEecJhIZD4AZVh/hJv/WNdBY+k1R/q51PkpnOzr0p9RjC9gIW7dbRMNNYuEv?=
 =?us-ascii?Q?qxi0rScPV3OJtv6PvuswF4Epo5JKh9jWphX4KkGWSWCGKPCrCxuP+yVrFwKU?=
 =?us-ascii?Q?fBabi8nOO7uzoEz7iVk6n79D7ZCjEsORZkOsZ3br2BeNOm8GjTmWHn6Og2gG?=
 =?us-ascii?Q?OQ8NfZYIXO3y2MMyL19ujg0IE5w8xeJQdSp1xPhFto7EA6Irqz6dhXxTDeUo?=
 =?us-ascii?Q?uDEY6M9QXheIqzQ4SVKo0q34m4vGaahE2+mhuCY2Ci6KqD0hbZW+ri8Ccrr5?=
 =?us-ascii?Q?xvjcTv30MyHVojxQ5wRAXiWuSLN7mWxze8uBQCuwP8U7bpWstUiv8U+0Y4Iu?=
 =?us-ascii?Q?0pyGDar5j9k35oOxPqiCuk8u26zx9ud88dRt/TvDSIl1WH5hdKBbFTxmLZmk?=
 =?us-ascii?Q?keXRBPIFJL3eW+/PcumaevDkp/VDngbE1vONkvsX58n5E4RLqIos+WC9/CBv?=
 =?us-ascii?Q?my7wuJUxzinqOtV8OeA3xaJ1QoAeiNBo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 05:37:52.5244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4a6eec-dbf8-41fd-42b4-08dca16b9bd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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
v3: set start time only when mcbp enabled.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 32 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |  3 +++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2f24a6aa13bf..8a2fdf5a310c 100644
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
@@ -197,7 +222,8 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
 		}
 	}
 
-	to_amdgpu_fence(fence)->start_timestamp = ktime_get();
+	if (adev->gfx.mcbp)
+		set_fence_start_time(fence, ktime_get());
 
 	/* This function can't be called concurrently anyway, otherwise
 	 * emitting the fence would mess up the hardware ring buffer.
@@ -428,7 +454,7 @@ u64 amdgpu_fence_last_unsignaled_time_us(struct amdgpu_ring *ring)
 		return 0;
 
 	return ktime_us_delta(ktime_get(),
-		to_amdgpu_fence(fence)->start_timestamp);
+		get_fence_start_time(fence));
 }
 
 /**
@@ -451,7 +477,7 @@ void amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring, uint32_t seq,
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

