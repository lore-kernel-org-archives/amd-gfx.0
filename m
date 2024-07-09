Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5EEC2BD09
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jul 2024 06:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CD2310E21D;
	Tue,  9 Jul 2024 06:56:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Vd8mtFt";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0378210E21D
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jul 2024 06:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdtYp9AryLnvkR2C5CSd4tpxsddd1nWNDMJ8mgTWBQhP2VWgeMqBsnD08Gi8CPsK+/9YUG8spoTI2nTJSDpI1c+sCK77JE9kpwVz7oP2m2Bes8LDSqyW3YpSNLDBNnOy8SxsRCXDmXafziG44p7pwQWmlC7QrbqXugpvJSqW6jrtLHgAhCU3bmDD+6jYTMx8b88ksOG2I9fd8QsmgQQ+2+vSyIu9K2xwrUV0XrfWHkaRFKreKjAnjVvzEOOecXLHxSYY2V2NZgn5V2hKoH7KyOft/MUlt7Xc0PRZt8F6cQfaY9Pn/wqfbU3WovMbvgO759lqjmWVyayX1RGsab01RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A17HT/sVpRVvxyxm3YiHPQYPl7/tg5vO7tIwH2M2vXM=;
 b=h5gsqLItkm7KiEvfyG8Vb5yXzavRrIe2khYoFPRUKGQvUL19A7GssKT4PxAWv9+6kRy+oSRLRRBd02f3U005pjmopeKvZb90nHvtwY6yrirLaQgXBAT3qzNSx+RASGdGIEb4BEt+eK7B0rxFeyn6hM5oGaivQFrbWhuet/mR1MVN6czK9rmHM38ELxGJyPoTd7xy+XTF5sq2BpL+1Ipn/oVMAygQD3t+WN4OY5saWLMQEQWW/f2ttelMfquEuP96Ks5t+u937247knusK4wDHAom+knDzyWHNbdfuhx/TqzmbAohsVugYz+QeM6Yqyljewl2f7HizzGOOB/s201R+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A17HT/sVpRVvxyxm3YiHPQYPl7/tg5vO7tIwH2M2vXM=;
 b=5Vd8mtFtBxmVJ9BOoofE0KXHvBjYhUtlB/qIeV6+UpWQCxBjy5PRfV0JoxH3KUk31KXEF2B8SEiSU6Q5LasKWPOFmPlxRgR3i7BKrF3b/s5muyOtvPKIajG4k9zU6sqnYVhMqm+1z3zpyQ6LzO4o4yXGMedOK2SOxi3FE2OYeQ4=
Received: from SJ0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:a03:39f::18)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 06:56:12 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::d4) by SJ0PR03CA0223.outlook.office365.com
 (2603:10b6:a03:39f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Tue, 9 Jul 2024 06:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 06:56:11 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 01:56:08 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH] drm/amdgpu: set start timestamp of fence in the right place
Date: Tue, 9 Jul 2024 14:55:47 +0800
Message-ID: <20240709065547.1639176-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: 9581993f-490c-4654-f28e-08dc9fe437c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fOEc+ATcrAd6q4HjZoAEcdeoO+VvupfUhKLdVSJ0b/Pn5q2FTIYW+5Bq46Cl?=
 =?us-ascii?Q?W+DYPNs/TP1gHvxrDMajX2StQdmq4I3eepKz+0AxslepunYZkL6TcsZtIsDs?=
 =?us-ascii?Q?bzywJAaAKpQbo4tlpTiM+E9zXJsyT4RiyhY59LDvYdR/6cKQftHP/TDAIWOz?=
 =?us-ascii?Q?jTU3maiKlMZyT9jgjz5NT+d8dGwLjwYXRrmT9WX6GDKnuysEepJ4ydOycb5Z?=
 =?us-ascii?Q?XGTlWiXWSon8U1UCyAHWAOU3NILHK0Wug8Z51k0i3GsdyZ9coqXc8voHhNJ+?=
 =?us-ascii?Q?XOAU2YTKwjtswD7XoYP/5/n5npnpxyveyBDyOPplg6cl+Nd6CPc1eUm2fL4D?=
 =?us-ascii?Q?JG6j5TEep7WikdarM4ADjPR6jYShQqKkYRcOLEiole6V71vRG3oUYbuF1vqi?=
 =?us-ascii?Q?9/aWkaDro+P5VecMZCovSoZAaB/kGtlV3M0u27augxQo1o9vc3xb1v9ZO/Tz?=
 =?us-ascii?Q?dPHNQqLtzCZl4+IpINc4hiNbYmPkW8c8hsZKCDUPp10pU/VBCPD4uTcuVGP3?=
 =?us-ascii?Q?6zXF6JZ9lHZB3ctQ+Grknml+L24cbPzdg72L6TkSYe2vBNpRbeLqt8g3GTc/?=
 =?us-ascii?Q?Ly0A1/29PLsbWB3caB0REetv9XrC4S4rG2E5zXAur2zujaqezoaWI7VlOAaH?=
 =?us-ascii?Q?b8CXVTInqseTNeQwtbaoSSj2nFvfoDBDknaLHwsGDTfI+N3pQp5fzGwLR7Zv?=
 =?us-ascii?Q?DXrlV7lc3VSeaanSCrokXpL9gdyh96cOhpN1N6/6KJ9Eh20lNEkRWS2AHQ0d?=
 =?us-ascii?Q?s5y7YVkaqQBZMtP1cX7jmsCGNyTq+SyRxXqQcd5b2SZvacgRJ2rrcmMFTOqG?=
 =?us-ascii?Q?6Pq0IZTW6yS2Mwg+0U3V/x+2WmajxZT2s9qZvRjW+5DQskrFOeTl30ajwGty?=
 =?us-ascii?Q?d7tH3+30RMw9Qet7IAHfIvBr9yWEzxfQr9tDZZADJHvlM97CQey5itOD9MQN?=
 =?us-ascii?Q?m5N/QGEyy6Osii+BLyAQDztw+7HZkho6ikxlLJftfj1Ah45FyT8EdeAgWko1?=
 =?us-ascii?Q?FdqXpv+9Gn43IllcUzOHxvVRm4EoC4/plf0MGHwQVib2M7/xI3n6UNwv11LZ?=
 =?us-ascii?Q?GPf+8Na/lZekMQaLYBJFlySFicC3h3iC40okh1OeDyUOMURQ2oW9c9/iLHc9?=
 =?us-ascii?Q?VNgsdf0r8/VR79lOGmANeA1KMdRnH7nx208dvsQbe7aagwugpNHU6SEGHeZ4?=
 =?us-ascii?Q?fqH4A6UZfXdAsD7CAZHcsuazbxn+MKfPYMPD6G17p+WsVzIFnCRjJPhVVxCk?=
 =?us-ascii?Q?0j2lwo++iXSYN4dpzF1w9l/VZIFJ8zLeTGUao+aEgRsBFsl/ItWiQ1iwwzj0?=
 =?us-ascii?Q?sW9aUmLjzDTyDDPhe1vETSiFxjeEwabcylQMYP4FfJvOUfjcH6I72wc7lHh4?=
 =?us-ascii?Q?qcgtwxJ7R23k8NDWjYevCmX4TWv720Am5ZmzRLQwbLqDFYS/V2adDOfLvmuu?=
 =?us-ascii?Q?2UPPXiywIZAoFtqjxwGCzi1F81uGG0xy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 06:56:11.3369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9581993f-490c-4654-f28e-08dc9fe437c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
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

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 33 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |  4 +++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2f24a6aa13bf..60c14d2e1c39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -88,6 +88,33 @@ static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
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
+	if (f->ops == &amdgpu_fence_ops) {
+		struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
+
+		return __f->start_timestamp;
+	} else if (f->ops == &amdgpu_job_fence_ops) {
+		struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
+
+		return job->start_timestamp;
+	}
+	return ktime_get();
+}
+
 /**
  * amdgpu_fence_write - write a fence value
  *
@@ -197,7 +224,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
 		}
 	}
 
-	to_amdgpu_fence(fence)->start_timestamp = ktime_get();
+	set_fence_start_time(fence, ktime_get());
 
 	/* This function can't be called concurrently anyway, otherwise
 	 * emitting the fence would mess up the hardware ring buffer.
@@ -428,7 +455,7 @@ u64 amdgpu_fence_last_unsignaled_time_us(struct amdgpu_ring *ring)
 		return 0;
 
 	return ktime_us_delta(ktime_get(),
-		to_amdgpu_fence(fence)->start_timestamp);
+		get_fence_start_time(fence));
 }
 
 /**
@@ -451,7 +478,7 @@ void amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring, uint32_t seq,
 	if (!fence)
 		return;
 
-	to_amdgpu_fence(fence)->start_timestamp = timestamp;
+	set_fence_start_time(fence, timestamp);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index a963a25ddd62..68a80e31ba0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -73,11 +73,15 @@ struct amdgpu_job {
 	uint64_t		gds_va;
 	bool			init_shadow;
 
+	/* start timestamp for hw_fence*/
+	ktime_t			start_timestamp;
+
 	/* job_run_counter >= 1 means a resubmit job */
 	uint32_t		job_run_counter;
 
 	uint32_t		num_ibs;
 	struct amdgpu_ib	ibs[];
+
 };
 
 static inline struct amdgpu_ring *amdgpu_job_ring(struct amdgpu_job *job)
-- 
2.25.1

