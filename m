Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AFCC83028
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C12EC10E956;
	Fri, 27 Jun 2025 03:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kiiKpOK3";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 639DE10E935
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWobjZaJ9IZ+dl5fPr6SaUEYV1fNPMxX+EEDYqNYEL7zvaCEM8EW4XSj1fHAAX2hadocyW/KeYN+H99xtOzq6ubL27ARhInRXJjZh39hFy/6jloTvyhzuS3MLVFxjBYhnP3iGBVQC2vGt6P1aoi38kRDGmE7lTXNgKXlJkbTpcWuu52g2t8ND37y4FffdjSLQq10qKYUc+6KiTOLJNrZVxN66gvNLDYbfOB0s9nayIQFYlbYEKG2yMCJbC249QUWkxXifnxw2ZMDEMGNvCEAAQyUaTevHTW9shFi9vO1/i88IIBWdpmIhtp54zmTwuKlybeqs/CvmsK7bQWwNcSZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfNeoHSh0PIJDYAwtOXZYf7u0R8IIOPFJ9fm2hsXSjI=;
 b=Quu6L5pYRiTWHrR5csl+8hTw0MwEmifSEU9NvGxV+Sfe6K5CI9mXBqJROfA0L7vTZ7WuxmMdStrLw8NFsSXxYMwOCddmE0y4EkQWohhhOgpqsmDdgm4L2v8UYAIl1LBbw4jhh4fmMY5ReByCqOpTP8C9cxNhSIMyFdSlX8tS8YfQyRTKQO1SAlFMOJxWbZUzQJ+SLCZKllPM2slDHlDQCJSNHhnPXQuI+tF+BbBjjXRfcv0IyHXwGaXdgvxPikuJpQMQHFNKUuaZUwyNcUrD09De01oFJbCD1tw+lnuLB7PEClmicTKv/8AFN1FSA5TqXjn5QBFnkoo060H2o9FhQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfNeoHSh0PIJDYAwtOXZYf7u0R8IIOPFJ9fm2hsXSjI=;
 b=kiiKpOK3j8b698s+H75aTLA/UPdxe5zneeKQDseAAfM5h8J8l2H4REF+bwlx8206I3iP41xEvRTp96n5FnYz0F0ZXdyudh0Plin4gJKHicYxREjT0IFW7RxCRb2tjb1VKFcjGt6XHTvp4wdCvzn3awdd0KPxN+kZG4j2TD7g9nc=
Received: from MN2PR08CA0030.namprd08.prod.outlook.com (2603:10b6:208:239::35)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.31; Fri, 27 Jun
 2025 03:40:29 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::ee) by MN2PR08CA0030.outlook.office365.com
 (2603:10b6:208:239::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Fri,
 27 Jun 2025 03:40:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/33] drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq
 reset
Date: Thu, 26 Jun 2025 23:39:39 -0400
Message-ID: <20250627034002.5590-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 2075d295-3e33-47a7-b661-08ddb52c5cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FJL8GHDM9XR+1X5L4MfDGauXkLDKaAK/wnNalScixk2fUK2KLDm+SVQh91Kg?=
 =?us-ascii?Q?VEx5pKo5r0rAZ34EQ8VnweQZNIrVgM68bPfLW2fc1krldmkhQKXynArBCLH1?=
 =?us-ascii?Q?KCgd647vSCAWyVEVbVADyRpMwqNewgd1tUF7DkQei3tiIwaCOF42Y/qeRRdA?=
 =?us-ascii?Q?CbdTr72BnJj4IwINDzzwu0jLjB5gGrb+M3dU2o478IgfcJC7lbAwXojeTSgD?=
 =?us-ascii?Q?bRIdKtXGD64mVbSLL91RSPTQl/Ri7v7DHq7az6dAOJbimrTaFqQnu7gQaSWJ?=
 =?us-ascii?Q?ve4eB4OGZS75wAox5f0hzGjiPwbp9UmyfBYrNlG6o2mZVBFqgV0jCHJ+IngW?=
 =?us-ascii?Q?RrrKqDQ3H5CaMib41S73j7IhcM7Ldg3+RQRJCAlO05qIRFdz4RfG4ExVI2dx?=
 =?us-ascii?Q?RfS/HGdlRbcMK2a6VEXVhwxkzYjcICOb2WpwrkSq3TqpMRIffqz58SFjHeC4?=
 =?us-ascii?Q?hSjkPudo/eUjYvM2b3MCp0ALM25un7TEJubpS7aQOcAZzfvQbPBLLlSS6RbU?=
 =?us-ascii?Q?XuGtYGJfnHSVqMBIdS7V0ManNGskWJiRcm+e1/hn2k4u9d88vyJrZPoQ5Nn2?=
 =?us-ascii?Q?1GmYv5lUEg/sTeyuoySVf3PDE6zpa98Hh4ouT882F5tGLCWJvrmfnPsCpLjS?=
 =?us-ascii?Q?eBYIiqSjlNnFi4C2LNZvRparPANvu4cFoZxZqo8lFAqgnbsSmu1AxoGktVXr?=
 =?us-ascii?Q?2H3H8+8tHeRGJJ0qNI2fDoc9Ivk6rnClwDO30rE65XSaM2EtAgEd/oaJQbya?=
 =?us-ascii?Q?3xQ33ebcZuWPfoiHYiK9dcaSI89zEWWf2MFr9c+V8oFLPfibt7Ldlovhva9a?=
 =?us-ascii?Q?RruxAcDQZ7icQcbu8HtlvUCIzvyVWubhcsg4LG+sUX4ssfpFKX/WnhK3cjnR?=
 =?us-ascii?Q?l5n5ObAthTAkOa8I2VN69W9dCnLDBW3z39LyxYZ7cE9eOHbIkFxEjqot1GCC?=
 =?us-ascii?Q?kwToW0ExkKeaGz7JycWJs4NWLFtrSd7fWpkkkg4b/FwDqQBSWwE8cYOyMsQ6?=
 =?us-ascii?Q?QKywjJh/G35nweLwUJhuLW2A64fk44M6nsFNVNUgB/sdex+XEUgXHurayWdg?=
 =?us-ascii?Q?lqA8YJ0jSwFthCANkZuHYrRhfYEQYh2JoI7SU31seV/c6m+cdJzLIK6Zpl3F?=
 =?us-ascii?Q?EDzVuQeTB5gp5Xz8zXmNQJ957mc2SHR5LRglhmbH5zZ0rpljOR2wiQdInWoX?=
 =?us-ascii?Q?2XX5KjCo3l7nMyuxrp1qFnaPNLFAw7yWkwGYQ+mpWh5HjrGn4L380d0S2ubF?=
 =?us-ascii?Q?gOgtQYRPW5gDdfC+aruvIcioLCWqscEgggOR+6cUrCO3Dkl0cNx07j9jQTlx?=
 =?us-ascii?Q?qDALMUv+FvwTxQzB/Anrp580S8RxklE/OT/+YSzzkiORNjgRhLCJRIBk5Ulu?=
 =?us-ascii?Q?986q1cfN2TpaMTle4rXBiEIc8ioNMmgu84CN1rxLcheQZvV8ufar3H9qvCUH?=
 =?us-ascii?Q?A/ecjHbSMtRtbD51OEwi1jTPIRyXlvhX5E2ngh728rc9ihIoWJZzZcE5zx+l?=
 =?us-ascii?Q?v34ZWvtAYFYnGbS3srDqPIJhRf1wAAgOnQTa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:29.6478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2075d295-3e33-47a7-b661-08ddb52c5cd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index daed0f187bda5..21bdf9746db7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3567,7 +3567,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -3615,20 +3615,14 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		dev_err(adev->dev, "fail to remap queue\n");
 		return r;
 	}
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 enum amdgpu_gfx_cp_ras_mem_id {
-- 
2.50.0

