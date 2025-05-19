Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07297C2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 18:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5EDB10E357;
	Mon, 19 May 2025 18:22:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ur6h6BCx";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA58F10E39F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 18:22:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CO9WI3OhTchjkhQVaXRug4jltLYDM6/gQHQf0GzPmWmuGxeohoJwJJU16LgYYVIEv5hlpC7FAsK5/7wxc9cARdDNfFIOenawz0m4F7JZusGJclaIzMJdBoT51Niw934ptH35RHxxNyVV1hoCSRL2PsK09n5uOK1Jh7P9su5Nn56+krlX9Ctx9wulTcASw5CAp2Cxid2cEhOa8w4YHtt2mfWUhX2O0R3Nu3j2SmqY3xDqvjUIAIRbNIG4XnvfBgJrp9Tzk/jOp9J+w0wfKpACp9qyRsRU1nYCFBG74Xp8uVPKJcQaKkkmadnA/GzheodupjAP7e+Y3nRWYDbfRHetxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YhP26ziqP22PNi6DrVQBpaRRoB87t1IR0nv6HnuOXc=;
 b=PpQ83MfEe1H3zKo2LApw/EqXIvpDeoubUtdKyp7tt5D9RDg6VK2CeA4BxaF/VkAqYxeqVnvURfWmcn3KZF+GcgoDpiHck1cO8mvLX8xYtQ6ePv09b+h0TCEyGSWIjB+cPspsOQxS0fl66BV7PyIic2iFXcPSe4l2h7miRqC0LDizp0jB4uJ1Z/ukXTnwGn7hQNZP4R2++Tb+Xf+s1/s+jRhxzyzudP+Z3UFrexwFuZnROY/YvEuGeRtg/PuncmfChaqTDRAq/IijO/CBC+3o8xVf/BlkgsjtbE6K5X9MPKoHRjHl31HYxizjrSHRvUlrit+SNZoWAB029Z+Eel0/HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YhP26ziqP22PNi6DrVQBpaRRoB87t1IR0nv6HnuOXc=;
 b=Ur6h6BCxHKqmi1kRvpPBqZOd266zxT68tfNDz3UsqHZOAIiESceLjQMdFnZu6TnTZUBLk/AohZ7DrqECrrVT35Jwsh0AQAXGYyF6x/L+2n9/WzU/I3/l0jxCJ6aE91WFI8T+WjFAHS4RaoTT+Lzt+tCHH0T9yQtvidVpDol9iNA=
Received: from MW4PR03CA0305.namprd03.prod.outlook.com (2603:10b6:303:dd::10)
 by SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 18:22:24 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::6b) by MW4PR03CA0305.outlook.office365.com
 (2603:10b6:303:dd::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Mon,
 19 May 2025 18:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 18:22:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 13:22:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/8] drm/amdgpu: rework queue reset scheduler interaction
Date: Mon, 19 May 2025 14:22:03 -0400
Message-ID: <20250519182209.18273-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519182209.18273-1-alexander.deucher@amd.com>
References: <20250519182209.18273-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|SN7PR12MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de11c4d-b363-432e-76da-08dd97021a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlZsWVI3VUtOdTRrOEJod09TbnlmMzlTblFJWDgzdG5ic3NUSHhmWW5DVHNM?=
 =?utf-8?B?eTczelFqRWpIaUN1WDVaY0psOW03c1k0bWk3RFBoMjVoZEFpL0JqMW9yaHJE?=
 =?utf-8?B?ejF1Z2w0Uk9LN09QaElXcGZPSWFKbXcrdmJ5RnRtTjU0c1J0dXJrM2ZzVGt3?=
 =?utf-8?B?TjZCVHhrVUtyM1NmOUc3MVZSRzZ2SEtIRS8xam1jWXB2UVpBZHFaRVNDQ2N1?=
 =?utf-8?B?bnBDRG83U0pmclJ3T2JkRHduQWJ6WWcyc2RRSm9CQnhUWGZBMHhSSmNEL2Jr?=
 =?utf-8?B?dm5GRVNjOFllK1lOMjhSM3ZPNDEvQUlnZXlzN0FRaEk3YTJZUVNYem1EbThn?=
 =?utf-8?B?OWFSZXVsNk9NYitUMmk1aTE0Rmp1TkR2anQ0ejZobnd3MFBGWFhtQjRIdHF0?=
 =?utf-8?B?T2pDWlYyYVlndU1scG5qVVIvdCsyN3dDQmZkY0hpSmluemZrL3psWlAyQlgr?=
 =?utf-8?B?ZHRWaDZ3a052QlVxWStnU1dWVGRYQk5BUzgwWnUxTzJFZVBaWDJJOWdQK1Ux?=
 =?utf-8?B?eXdZWm5mMjBGN3Q3em91K1UzbndDUWFDY3cwaUJNSUhiR29wL3hiTjJtNlI4?=
 =?utf-8?B?dHNpU1hUTFE4anpZSzlsMjQ1NjJLUFcyZjJhRmtIVWtnckNablhUalpEZnJO?=
 =?utf-8?B?akNKQzkwdU5nQnFhWHFvZTRkbDNrQldRQzduUWNvWmFyQnV2L3NsVUR6TU4z?=
 =?utf-8?B?S3NVdWNaeTNJYVhWRnM5YXlHSDFvb0pnQ0pGcjVhV1NUR05MeTJGdEZRWitB?=
 =?utf-8?B?Qi84Z0ptRHVEbzNRaDlnMFgvRnVCTjk3QUcveWFMRXlMdVN4SGV0ejJGOCtV?=
 =?utf-8?B?SUczMkxUV0NhQURaRGdKUWRDVDEzeEVCSGtNWkR3NHRvTDkxNnFNL053Vytq?=
 =?utf-8?B?NmlseXB0N3lwK1RnQ1cvQi9iSFhrY2ZFajEzQzdQMnBScnduRWtGY0FpZWVX?=
 =?utf-8?B?U2VSc292QU9GcTBYekVHMmp0aFhDSFB5RWdmbTZ5Sk5oZUpWWm9DNVQrY0dL?=
 =?utf-8?B?bm83Q3RzR2F3QkVsUVIrZFdNdThWeERkMmI0Z1QxSnM5RFZGVlNDRGtBSWUv?=
 =?utf-8?B?dmk1VGUzYlQ1dTUrRmtJamFUYXJmbUFNU3kxbWRFeWtTdjJDN2NGcDNGQ0RF?=
 =?utf-8?B?WndqNG9nMzU3MHN4NGUyYWhXSk5HSmpDbnVVNnpWV1V3R280dG5pMUdyOE1M?=
 =?utf-8?B?ei81eC83S1dyM2xKRC9uOU00R1EycHVlbGtCSlBvTTdxSXF2MFhtaWY0WXVy?=
 =?utf-8?B?dzJ5Z0tLNzVmakgyNUh4YnNJTzlqb2hFQmtjOTYyYkh1UkRQK2dOeHcwSTZn?=
 =?utf-8?B?ZmdkZ0gyZXdQbTQwQ0VGZjFPbGJnR1IvVmxtaUw3MFNSNTc2OUFFWEUxejVT?=
 =?utf-8?B?RVM0KzRZZzR0cDFoRC9lOHFzNWxkQnJPcmpweWsvMWVQSS9icjBWWXUrMlVa?=
 =?utf-8?B?UjdyUS9qTFRheXJqMDhFQndGMmpVekJKUGZ5KzR3Qm9rY3M5VVlTdDI2aWRy?=
 =?utf-8?B?Q0lkUWk2dzFFRFBGTGV2TTN2MzVxbWpxczh2YmU3eWxNOEd6WGltTHdFUGpi?=
 =?utf-8?B?dTZJOFJCaUpYSTFxMXJ2c0pjOXJIQ1I1eGhtSU5qelJJWVZjYVgzRDFRQlU4?=
 =?utf-8?B?aVpaNnBwc1dIV1dwVnlMVGY0cmYvODhCR2wvUjd0STFQSFp0bzJXKytERWFz?=
 =?utf-8?B?d2ErQU1jVjFOZ3hJbG1HdFdZWnJraUxCYVpMQlBqNDFodGxMTUhiTDJMa3NQ?=
 =?utf-8?B?V0Z4K3FQUHI3T2I3alJTSE5MQThPV2tmdTZ2OU1GSHFpR1RhNjFUNndycXdL?=
 =?utf-8?B?TWtEWGQrMmRIVmJCWE1nM0lUb1k0Y2lBOWZBaDloS2xxckZzRGozU3Z3aTd6?=
 =?utf-8?B?MW5NcmFjSkY1bnFsV0loellqMkFHeGd2V2ExMDl1NnBqVGROakVSUFk5eTND?=
 =?utf-8?B?MlBoUy9qSXE5M1RQSndna2ZLVlZVUmtRbFRRUy8ySHQzdVh3T3ZLM2NFWTVu?=
 =?utf-8?B?Z01vL2VCOCtxRkE2VEFsUWJBbXc4RDdPQXRndXE5T2pLWnRsUVVEYnZISjVx?=
 =?utf-8?Q?4F/vk8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 18:22:24.2653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de11c4d-b363-432e-76da-08dd97021a57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

Stopping the scheduler for queue reset is generally a good idea because
it prevents any worker from touching the ring buffer.

But using amdgpu_fence_driver_force_completion() before restarting it was
a really bad idea because it marked fences as failed while the work was
potentially still running.

Stop doing that and cleanup the comment a bit.

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 27 ++++++++++++-------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index acb21fc8b3ce5..a0fab947143b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -136,10 +136,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
 		bool is_guilty;
 
-		dev_err(adev->dev, "Starting %s ring reset\n", s_job->sched->name);
-		/* stop the scheduler, but don't mess with the
-		 * bad job yet because if ring reset fails
-		 * we'll fall back to full GPU reset.
+		dev_err(adev->dev, "Starting %s ring reset\n",
+			s_job->sched->name);
+
+		/*
+		 * Stop the scheduler to prevent anybody else from touching the
+		 * ring buffer.
 		 */
 		drm_sched_wqueue_stop(&ring->sched);
 
@@ -157,19 +159,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 		r = amdgpu_ring_reset(ring, job->vmid);
 		if (!r) {
-			if (amdgpu_ring_sched_ready(ring))
-				drm_sched_stop(&ring->sched, s_job);
-			if (is_guilty) {
+			if (is_guilty)
 				atomic_inc(&ring->adev->gpu_reset_counter);
-				amdgpu_fence_driver_force_completion(ring);
-			}
-			if (amdgpu_ring_sched_ready(ring))
-				drm_sched_start(&ring->sched, 0);
-			dev_err(adev->dev, "Ring %s reset succeeded\n", ring->sched.name);
-			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
+			drm_sched_wqueue_start(&ring->sched);
+			dev_err(adev->dev, "Ring %s reset succeeded\n",
+				ring->sched.name);
+			drm_dev_wedged_event(adev_to_drm(adev),
+					     DRM_WEDGE_RECOVERY_NONE);
 			goto exit;
 		}
-		dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.name);
+		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
 	}
 	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
-- 
2.49.0

