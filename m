Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2FDC369AB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 14:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C2110E2B9;
	Tue, 15 Apr 2025 14:19:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pH25OmCG";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08AA410E2B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOX0kEv7MzFwK2/aCLokzELIfthiSN1qI7w27boSpGG/WPHtojJ0D7s2+ZeqcUHFeqADq+43DWbsl/PHPpHPvbu2zzBUg6ARg41KHnHWfQJ43Gneu7fwnGu8R0sOKLpcoMWlFd29yeY/HOyzsRI6xAhbNlxv4wtfBSwTF1S6pPZxpE5El71vLEf00fEZTC6bjUp9yocMqxm+1v0M8w5+eXv+qkcyZ7aKQgnR13JPBMspCSvcvTb3yQ/vQQ3OZkZxFQLgCNmS0V+Ly1RELLE1IoOHW8/XPa1e/x+9Cu0wP69IarTn/y2nGPv0mNj6qkdnSPDojXoLGiSD3cnMrU5aAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyQI0emr+Eo/yPkuiBfSmDQLHryUZ5W9cHHjU6q66nk=;
 b=HzcOdFLtq9jPvIPXF1weit8gmrUFcsa0gciGGCZlj/4AyRZggg82w3+4HJfg0zWTFAhpbsQs1pVBCp5i5sAOr06q1MtA0mBptAuG1cSviZ+NLlBzmfrB4g4wVW6IqkPdap5rMoge0gqlFeoi+vg9D7UYV+ppmnb7MDFLZl8gBesUU16nxP/SDiu+UCWbEP5fOyxhmLoJMD3Do/j5M5Hyvf9qPj9mmJP5nCKNpVxZDW3W9v+OiVD21UaW9zs4QYAsdV029OYAQ5zr84WGzwDhMQP24qV4SddVY+KADqQMARGAsorsVD89ZJIdPn0Qw6mjKbg3O3pYi9L9MisrDQIaVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyQI0emr+Eo/yPkuiBfSmDQLHryUZ5W9cHHjU6q66nk=;
 b=pH25OmCGNuRLFzutHdKInr+DuHLLFp9qNOhy8u4o4WKJQnXFsKNmW8AJgfvHkUrwjKWDIjWHoF52nQWYpJAtSpckHA1M+r0jV8uVEgheWEoTKzRPC0DhckBk5kJcTv8J9AWsyJaiojhynFDj3VbHIBCottOyYG3KMcK3IK6sXHI=
Received: from BLAP220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::21)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 14:19:22 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::4a) by BLAP220CA0016.outlook.office365.com
 (2603:10b6:208:32c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Tue,
 15 Apr 2025 14:19:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:19:21 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Apr 2025 09:19:13 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>, <Arunpravin.PaneerSelvam@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Arvind Yadav
 <arvind.yadav@amd.com>
Subject: [PATCH] drm/amdgpu: only keep most recent fence for each context
Date: Tue, 15 Apr 2025 19:48:48 +0530
Message-ID: <20250415141848.58478-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|SJ1PR12MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 9162f6e7-28e8-4cd1-8565-08dd7c288418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2xNcVdVcUhWRFhESGVOalRuSzNhK3g4cFBXUW5ZemJmU2p2aFp2bXlHSmI0?=
 =?utf-8?B?azZ3QWd0WG9SNXlOZ29LQnJLWnJYRjE2THZ1MU9Pc0RhdzE1bjlyUTZQc3Zn?=
 =?utf-8?B?TEg1eUduUDl2c3BUL2V4M0JlRklIZGNiTE1GTlZUMk9PSDBRelFkWDNscC9x?=
 =?utf-8?B?bU9ydHJFbm9DRnZLUW9ZMFZpWng1Mzd1NHVtWVRtZ0JGMjRRekhHNUtoMk1t?=
 =?utf-8?B?bjdPZ0Z4OGFvOXRVZS9DdWZ5RjhMQXV3OUt5djU2SEJ6eUMrYmIxV2JESTh1?=
 =?utf-8?B?RVFRNmY5amI0ZnErZzdaWkZ0WW9iT2UzT0p0RXJXaWZTdmN4TC81OTExMk9r?=
 =?utf-8?B?NkdlcnlhMCsyUnpWL1dMWTRLcUZsM0F6UFZ5cWtucXAvRi9KTzFIZjc2MlRy?=
 =?utf-8?B?Ui9MeFEwVDVlNTRWR2NQck9Bay9ZUElQYVdldFpnQWc1anB6bzlaaTR0QjF6?=
 =?utf-8?B?V0pRRHowMFBMbVlzbDF0OHZYcXhDWTFuTHRrVUhyemdBTW1aUE40SHdSUWEw?=
 =?utf-8?B?L1pYa0ZFZDFveW4yZjdzODRYQUtyT1JValE3SVZCRUY1WHEyT2tobGgwZW9Y?=
 =?utf-8?B?NGFHYUEzRy8wSDBXSFQxL2Z2amdoR0tjRXJ2cFVJN2hxVCt4dWM1MHVQWUhz?=
 =?utf-8?B?cStjSzhUSklKcENLeXFlaDg1Ymg0VThSM29iemJJREg3WEU2VDA5dVlNeGJm?=
 =?utf-8?B?azB0dENIZ1ZuSUtObmtiaHMrbWxrVWdWcnZmUzZkTW10YlYyMEpOMElGemhU?=
 =?utf-8?B?SGtRNnpERzhFd1JMZ1pHOHJzeUQvV1hIbWdWWUFaNDFhbHcyUGRHcitYOEdy?=
 =?utf-8?B?cCtDV3AvNW9WZ0ZCSU5ZbVpBV0tXVHdNNitSeGhnaFlqMjZUREZYbkl2TjB6?=
 =?utf-8?B?cWVpcmhLZFBncXp2M21ZRjZiNnlRMmROODF0N3g1NC9NWXBjZVQzTUlwQ0FV?=
 =?utf-8?B?TnR2anlLeXFvRlJUZjRMZUdWL0F3VS9oemhiazBrczFsYThUa0UwYmc5Vmpo?=
 =?utf-8?B?RVI3ZytyOHhiUld0UEZqUkV0dlhuZld5NCtBMW93aFlWaFJxT0RkeDR4Ynd0?=
 =?utf-8?B?ZzJvUHNneFVETms2TFhGSkRBMG5uejNMTVpieTExVUx2R0QycUk0ZnZ1cnVW?=
 =?utf-8?B?WGlXMWEwd3VlejcwTVhhVXVpQk5GWnkyZTRNNXRNWnhHclg4MW55TkMrenNh?=
 =?utf-8?B?bWh1NWRNZzZlSUdTdGIwakpwcDQ3K3JPVExXZUJhVUlwZG81aE1TQWZUY0NR?=
 =?utf-8?B?U0ZZK0tpeWZkWFFRdnlucWFIYTBES3hPcnhOL1AvNXRDNnZOb1dDbGxOOXUy?=
 =?utf-8?B?VGozd3FTMFhhSUdSalhNZE50SUozK2xNSzB6Z0t6VEk1Njl5dGIzcm1WeGFi?=
 =?utf-8?B?aE0rd3NNR2QyRGpVMlZNbWJlRTZDRnMrUDdaZWxTRXFGQUtrWk82bituQWVP?=
 =?utf-8?B?NnR2TVdRczhVMWlSbU9Cd2xSaUpzdEtadytIWENaMTJXNFJPTjQyUEdqMmFo?=
 =?utf-8?B?TlVoZVZiOHlhS0p0cTh6OXdMRTE3dk1oeko4T3A2ZEFBak1LVk9UQWMxbkxG?=
 =?utf-8?B?ME9Yai9pVXc0N2xYd1U2MFFZT3UxSlNVUHM2bjhNVkNtTllaZ1NBb1VqNlVt?=
 =?utf-8?B?TTVrU25XMk4xSFRxUDZqcm1jUGdhK0FrRm5nQUpkNkZBbk5wM0poazBBNk9w?=
 =?utf-8?B?bkJ4UHJ1VEZ3aC82TWthRXhUQzZNd0Y5c3RpMnV2NUFWOHNxK2RvQWQ3eWE2?=
 =?utf-8?B?T2QyMUxTNDRrMndRbzNBMmVFdUh6TXhWdXZpVTM2dVNHOTRoOXNzRVdMUVd1?=
 =?utf-8?B?aUZPbGdZSVA3NWlKZmVlQ1dTZ1JNWER6KzdQalF2ekpKc1p3cWNpK0ZiODNB?=
 =?utf-8?B?M01TOGdiS1hWWk9NdWNWQXpUbDZhUEZFYXBpN05pTmZYdGhqdmZuYVZLMlZz?=
 =?utf-8?B?MFF1dndiSVQ1dzBya0Znd2VEUXgwWUNMWE01WjI3RzNtYkp4VTY3VnRoQk5F?=
 =?utf-8?B?eDErSnJjZzR6MWRrbGpGTVloK3pZWXg2K3pqV0U4Nk9kSC9LZnpGVnZvY2ZG?=
 =?utf-8?Q?LLhzL0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:19:21.2778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9162f6e7-28e8-4cd1-8565-08dd7c288418
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218
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

Mesa passes shared bo, fence syncobj to userq_ioctl.
There can be duplicates here or some fences that are old.
This patch is remove duplicates fence and only keep
the most recent fence for each context.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a4953d668972..9a09d545ceb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -25,6 +25,7 @@
 #include <linux/kref.h>
 #include <linux/slab.h>
 #include <linux/dma-fence-unwrap.h>
+#include <linux/sort.h>
 
 #include <drm/drm_exec.h>
 #include <drm/drm_syncobj.h>
@@ -584,6 +585,24 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 #endif
 
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+static int fence_cmp(const void *_a, const void *_b)
+{
+	struct dma_fence *a = *(struct dma_fence **)_a;
+	struct dma_fence *b = *(struct dma_fence **)_b;
+
+	if (a->context < b->context)
+		return -1;
+	else if (a->context > b->context)
+		return 1;
+
+	if (dma_fence_is_later(b, a))
+		return 1;
+	else if (dma_fence_is_later(a, b))
+		return -1;
+
+	return 0;
+}
+
 int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp)
 {
@@ -840,6 +859,24 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			fences[num_fences++] = fence;
 		}
 
+		if (num_fences > 1) {
+			int j = 0;
+
+			sort(fences, num_fences, sizeof(*fences), fence_cmp, NULL);
+
+			/*
+			 * Only keep the most recent fence for each context.
+			 */
+			for (int i = 1; i < num_fences; i++) {
+				if (fences[i]->context == fences[j]->context)
+					dma_fence_put(fences[i]);
+				else
+					fences[++j] = fences[i];
+			}
+
+			num_fences = ++j;
+		}
+
 		for (i = 0, cnt = 0; i < num_fences; i++) {
 			struct amdgpu_userq_fence_driver *fence_drv;
 			struct amdgpu_userq_fence *userq_fence;
-- 
2.34.1

