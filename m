Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D225FC3DA6F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC9310E8DC;
	Thu, 18 Jul 2024 14:08:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w9hEZWeN";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1BAB10E8F4
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoIGOls1cJxK24QTuMbHHgzRfl3IBAUeNmV8HigSiJ4ImpYKLumKt6YlAPWRbGPGdymNL2zHSTwJ4tJbIl3nL++RPEVbTcHEoLtgn67Xrdm+wh7gtsE/qj/kbXgqxO8fQ8MLHqeONi+Uns5+HfO0HcO3iBbLJ42Synt7b/K3eBUmCMpCHm8JFBiRMYbo7jOBDsZyU092Ej0Db02cVdVSC8MgPIIISdnMBNvoiX+iJUxRKAC9W5oj+ge1dJz+QiudzNDC05DC0kmQUTl/momRp/XNfeJe5CZHnJbv5J01Iq+0bDgKWdLVz+f24U4ZC/NzoIG1yj/vL6M/Im5xAG03WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZb8j5vO5dkJJkFfZvyXjTUoxTRDzkdEjrobmUxishs=;
 b=RoW3w3EDYQdevOl5nmmSjaxxNJ3CFAJSnyRrBfGIvz2krlcX2PcOToxl6YKatvfeN+qss54yQFNDZsRkMf6NMT3sl8ARk5nerWTwpZyzJH+P+Y/am7B8/aPWYUnAo3dJVu8M9427faoABm3DFwLZaT+b/Oa29Hq4DEauiRC21R/Ymc5NSZZbqe/yvZXT6bQGH/maDTq0SmICIhAAZYoZuLmpODCd96ZGHdBMNLhByBmrrVCaL9OqDp9zKGj4mjCHttU+JchscTXn86UpcPBe+wJ6uqndLx0ajDYeUIhQYJ2zb/ayHuHsjodlsI9wFR8u5Jr90lElT05MKETAr+Ijrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZb8j5vO5dkJJkFfZvyXjTUoxTRDzkdEjrobmUxishs=;
 b=w9hEZWeNDek5+/HAk2j5vNuR7EtVGZS+eVxhQD33Lrs12/Y+RgNp/DWZQYYneYlMNP6gwaqMid4a9Czgf5OBwW5ICaPXScn1tPrMHQravZNC6zTAwiMByjYjL4sYGHmJeBuA8X1fTePihSiHoerliqsj9RH36XCSlkBkKVhV8TY=
Received: from BLAPR03CA0039.namprd03.prod.outlook.com (2603:10b6:208:32d::14)
 by SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 14:08:01 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::2a) by BLAPR03CA0039.outlook.office365.com
 (2603:10b6:208:32d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:07:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Prike Liang <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/34] drm/amdgpu: increase the reset counter for the queue
 reset
Date: Thu, 18 Jul 2024 10:07:08 -0400
Message-ID: <20240718140733.1731004-10-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dadb6aa-58f9-4080-3076-08dca73308b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WgtCVcc7vWhd7ru4HnZanVA7f8UWZQ/jed44aYjppILWOow995VspEJwUSxi?=
 =?us-ascii?Q?mIfaDfDj1NkjrYUo7A4vs8yvQ0CKbpN5FV7tE+/fDM82+DIPmSt3mdIRNIiO?=
 =?us-ascii?Q?EQD8amWUJXX6Nca/lGWVAD6tsbYvkZhvR12Jkii4qxnEuV99Xw7JiciWdO/e?=
 =?us-ascii?Q?loDA4lydmRwiSxOw4usxuoCVLUVdDTxj3hSZBx/81a1cz+VX8M5x5auv1XOQ?=
 =?us-ascii?Q?p5vEU1i6BFPxDkVD9AX/sosDJO9rKt21LtMtBd3GSe3VmTlKazfXI56PznFi?=
 =?us-ascii?Q?wDYsslyqTNQp0JHvbFFzPoszzglvps6o3Y+3BB0n5rgpMDDoYdU5FeYwgcsF?=
 =?us-ascii?Q?BjCwQqXfAsFRuny1xHtU5EYYb7ag0QCZ0Xupk3eO010OJ8JSr3SLS6FgWSDk?=
 =?us-ascii?Q?VIrmmH18o0/ZmU0Bw6kqwEmcXBY8+4BOSE8TGXZRcPT7B9oSSgbQ72GDemoM?=
 =?us-ascii?Q?MCwUkkGtWDcLzOMnaPqyUEN6w383hvbQjEG0+E3CtTG3iNUqs4YLVQxsmoJX?=
 =?us-ascii?Q?BiDToqDjqtmyYmM3ftyw6P+4oU+FZqfj4LirsKJWoIbYbqCgIjxrs8umGstD?=
 =?us-ascii?Q?uZK+Qz2xlPzJTqCF9dUVfrS7Gx5/yiV5ic1Ji0+syRmfdLidlXftygvkkvYl?=
 =?us-ascii?Q?P5XHLAEL8S+Na0zEcDGvXsOQO4YeVwla/Qjuh1v47K6a9MMWZQfReXgaCQxX?=
 =?us-ascii?Q?CSFyMhAf3h5HSGyE3YwSmUws5EGmFCx8ExeDVlsDDkg+oF5GWW2Uwr1V8nO5?=
 =?us-ascii?Q?gN5sebtzkzhzCKDfdC2UyW9hGyaHl/3ZsQLLlPbHuI0xevTCyXoCgyVOMYC8?=
 =?us-ascii?Q?clVq7tjWREL78NlKFB+2Jceswcktm7502jN8EUXeY4gzB+AwKtIPo96nR6/A?=
 =?us-ascii?Q?UQbBAfdcHjAi9Q/xFLrVEAiND1NNfp6U2oxN6BM0mPiblGedSQNhk22Byda5?=
 =?us-ascii?Q?87+auFhS/cXX3ZEk/HyZYivn2MFsZvRVEYg4XvR3YyVUEsVgFW6Q057eq5LR?=
 =?us-ascii?Q?1lD6lNkw+0omlJHEHnAyelt/CJli271jPpQJsjWv5f9FHS7uiPshvwJ0XKxA?=
 =?us-ascii?Q?50dIUNJNwgdTEDdN2YM3QqORIK5iA0QNMwSlfXg7H5jL0y5Xd/bcNR4IAkxl?=
 =?us-ascii?Q?CtTnBFyqdr8yXtxgs6A4U2+Ag5Np+r9tEJ5yXEP+VVTMeQP7WUhbCLVe/UGJ?=
 =?us-ascii?Q?lf5Yx4//Y5QAR04slkATPt9gNvf/yCLxYo+SKz4GI4WjOOP9J5FQLrCsH2/O?=
 =?us-ascii?Q?Wdav+dwMyGxs6s8lGLl3Pv+cxDoQg5C+qSkzZtRD8amBRfEp2+9di+agUJ1k?=
 =?us-ascii?Q?f6jJ3b++3AmGVhdWOBSHIa9D0hOhjfloWaxpb5QTn6M75gvSuUxdEZIGAD+C?=
 =?us-ascii?Q?c1CkpypJk29B68mSuOMZRxM19ylL8YMQL+5U+cKOh76inJX5CuS2YeALMIen?=
 =?us-ascii?Q?t786MDVVrzDyCwSN99GraRdc9Jp1xgkO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:00.7386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dadb6aa-58f9-4080-3076-08dca73308b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988
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

From: Prike Liang <Prike.Liang@amd.com>

Update the reset counter for the amdgpu_cs_query_reset_state()

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 5d4883df64d8..7107c4d3a3b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -80,6 +80,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		r = amdgpu_ring_reset(ring, job->vmid);
 		if (!r) {
 			/* XXX: these are required for subsequent jobs to work */
+			atomic_inc(&ring->adev->gpu_reset_counter);
 			amdgpu_fence_driver_clear_job_fences(ring);
 			amdgpu_fence_driver_force_completion(ring);
 			drm_sched_increase_karma(s_job);
-- 
2.45.2

