Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67458CA0ED3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 07:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F2EC10E688;
	Wed,  4 Sep 2024 07:12:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="unvtZjAp";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3682C10E688
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 07:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAlj+ysxqmraIqldn6jM6+eCqtFlWOUj314c/aqBWZlqnYyPYG5O0dKYyYMfzDR8A8ycs8zDGfXiDYzmTqX32DdUlRvTjDmIzOs/rbicxBlY0J3LM66ZTpN+hAwb6lDA8cdtLBtirFFcmBNPvmv0/RbI53WdJruFSGh5Vy51VzJttRN4kZuN0speofqT5R3xQKYDd8dV/cA8Beh4LYVKQVNRuh6MkORfD5cU5k+IHzaCSxHQ12AkTHuH4DnXiIdD+uvQJzFN3IYMG4Fy92Ht3MPlT5qwX+XAI1Un05ZF33UY8gtKJblHhjzsY247G69H2eoxRhDOs3qdw9OD0P9Qzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zSy9Kz7fGspvDgm/tDN++epCU1zgdmv1Fhm3dwstdE=;
 b=jSWewS5DYVK45jtGVnSy6910iejKOyYekk23FVUkRTpSzHfFyqzad3JXlmaafJ8EjW4EyZ5r1pPJlaPjSjk8X+wLztVNY49KRAtCbHZNcSg608iqQ1x5/a0MGlj3dntEjy19aipiTkHD4R26Hqlyz3cojl9QgpnP/cCbHhXbiZTgdRTFDNptVoLdsKA4LBvJCMN2khKBsQ+fcmm96LCE5YEf77NITcPP73rErZuhxHKMm9IqOGQmo/qVGIydCh4IGMPlIBi/vhFbM+qdRSEc3w/52xnwyNSAkY9Vw3JFaU+xpXclf5ANmJA8AayXI7Xm8SiDDRsBMy7yBM+lr4hS6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zSy9Kz7fGspvDgm/tDN++epCU1zgdmv1Fhm3dwstdE=;
 b=unvtZjApqcb11p1n/swi7iZ3BWf5vrP3x270a7ZfanW4ivci67XV6MDVh3tXc/Ul6SZq7SORkeduO0ZGlFceIpb1tLqfRv8szlAAZfAsnCO2o3sO3I1iOPwBinppfE/fz00TgIHer60bhc5idLqR0N8g/bPp2zyEjIRVfK9blko=
Received: from BN9PR03CA0366.namprd03.prod.outlook.com (2603:10b6:408:f7::11)
 by SN7PR12MB7153.namprd12.prod.outlook.com (2603:10b6:806:2a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 07:12:45 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:f7:cafe::9b) by BN9PR03CA0366.outlook.office365.com
 (2603:10b6:408:f7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 07:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7962.2 via Frontend Transport; Wed, 4 Sep 2024 07:12:45 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 02:12:43 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Replace 'amdgpu_job_submit_direct' with
 'drm_sched_entity' in cleaner shader
Date: Wed, 4 Sep 2024 12:42:29 +0530
Message-ID: <20240904071229.1702075-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|SN7PR12MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 63172e7a-bff7-4db0-3551-08dcccb0f99c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ylhzdk5wMFhVOWFHN1JrMTA5ZmJMcmx0YzZNNnhPZm9KeU5JMjB0UFVBc1NP?=
 =?utf-8?B?MWpQbFNZeVNNSHRpMG5MZVhpUUlqRWJnYkR1Y2V4dU5QZEk3MTc4aHJIbnN3?=
 =?utf-8?B?b1U5eFFBcVZRY2NvZGRFTy9mZnlSb1l3NnJkbVk1M09FQkp6SHdoQjRncEJ4?=
 =?utf-8?B?UUFVdzh0a0xLWXQ4czNwdFBtcXUvd3FMbkI5WXpmY2xCcVlvOXJFS0c4RVRV?=
 =?utf-8?B?K2lObEpGRVZsUDVaZGc4NWZBMkYwYytwSWJXZjFrWHp2TTBsSmR6VkhyVHQw?=
 =?utf-8?B?aVc3Q3RXRjNsVWtzM2RyYTVPYUM0Tmx1eUNHbFRsYWxWSHA4S0FzZXFERTlp?=
 =?utf-8?B?cTJtRlRXejAyN3F0K28yZDFxd3BtUWQ4ZlRHeTNTN1VON2V5TkJ5V3hvMldB?=
 =?utf-8?B?QzA0UkJmT0FGbTh6aTdlaGFDeS9QbXF2anRiM0VoWGNsNnA2ZmIzSENSK290?=
 =?utf-8?B?SThibkl4Uk1RcXBmUWdUU3NqRm05NnEyT29zSEFlWDRtMnF1dE9MQ1ZldDh4?=
 =?utf-8?B?OThucGdocWR1NWN0Q3FoNzd3R2pRYUhBZEZNbFBIZTVXWlpaUHlnM1JWNXVF?=
 =?utf-8?B?MmIwR0FSeE94ZmtkTHpsSDlRWHRwWTNiNkpxSzNObjdzZEsvcU1HM0VtN1NQ?=
 =?utf-8?B?bjcyZUtIOGh0eFRpZmdaYU01VkNneEY5RURUNTkvVVh2SkpZMkE1Y3RSU3l4?=
 =?utf-8?B?T0FERDJqL3JvbzRDS3ZhNW1yUUpDaG41cVFOUmIwQVFSQk9EckhIQTk3MjZI?=
 =?utf-8?B?L25TUFlkQXpQVVFaYW81eHFaUEtialcwQ0d3ZXhkd0lrUVk3bHlGUWpmSnhz?=
 =?utf-8?B?QXM1cVRlVG9yZ2Q1VTZCTGMxWjExaEZSc09IQUd2K0s4OGpuaXMrNnorbi9k?=
 =?utf-8?B?alkrTXFhSWVKcFVEWWxXdFdSdU5BeDdyS25zVGt2VXdzeVhNRCtGZy9kd3VC?=
 =?utf-8?B?SG40YnZydVJCZFJJVHkyU1VjNm5sa1VsNGt1YjlhYTZoaERVdlAxR3lOYVZR?=
 =?utf-8?B?RFUzakdSM1NEZnB3TENZNjdYeklmRnlNc1d0Q1l2TzVWNnhFeUVPQjI2cGVE?=
 =?utf-8?B?TUlvK1lxSEFDYlhMamJraGd3bVJtbzUvdjN4V0I4SGovRGdQaWhmc3FvbUg2?=
 =?utf-8?B?V2lCV1FKanpmS25YTUsxMnhJSXNwMzRMOHdlK0FPTllrZnY1czJUb2V0WU42?=
 =?utf-8?B?WHpPZ3MwREVrK2RqN0ZjMk9HNm84MlE2S2IxTHN5cml6QnM1YVRXSU0yTWpv?=
 =?utf-8?B?ZGdGREpsUEZINkpIVWtFaktsQ1lRY09PbzRaMjkwdWIyUk0xRmZZRzBUcU0v?=
 =?utf-8?B?cFBJQ1d3SzRHeXM1ZC9neGdCNGdIYVphK3gvRGNUYVkybFJiRTk1eHhlaUFH?=
 =?utf-8?B?UVVKaitUVkNNUWdxaWRCZ2YvYkZGWTdnRFE4SzdONDFVOG1LdGFmU1pDc3p6?=
 =?utf-8?B?Rmc4anA5TW9yS2JTOTRIWkJLc0tHQk03YkJnNGZtWFEyZWNLWmJFeWtiRXBD?=
 =?utf-8?B?eURMZDdNdzhsUlk2aDFQNlVVZUNjblJFVDJ6UmpTWGV4dkVaYnRhRFl2SFZR?=
 =?utf-8?B?aGQwbDFnNXJVOHdrLzJOeDBNYXB2Sms5L05qV0gyL2RBRkhSelZ1bEwrQklJ?=
 =?utf-8?B?aUpoL3kxaGdjSHdPelBrT0FscUR6bS9ndGhZeTZQeGhPUjhMUmxoUHZRbHJy?=
 =?utf-8?B?cnRubEtvWXdCK3JuVzhiWlRoQkk2V09HZG9JRkxZdEJ1dU1weWM3OEZ3MFpF?=
 =?utf-8?B?L01PYnRtak5EOWNlMlkwNWZybzlHdXVCU1c2OGNybldyNFBRMXZ6aEUzOURr?=
 =?utf-8?B?S1hXRy9KcHlZWHk5WHFOZkh5UHdNMEJENVZteEhLKzQ1NE5NQWd4b1pQZ1kx?=
 =?utf-8?B?SU5mUWlYNEg2aFYzTnMzMTdZcDEvVmEydStmaHVDUDZ6NHRHZDdzUmZyTEdq?=
 =?utf-8?Q?3IXVs6NnU5gm14EP72tLGwEG5yvimHY7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:12:45.3217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63172e7a-bff7-4db0-3551-08dcccb0f99c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7153
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

This commit replaces the use of amdgpu_job_submit_direct which submits
the job to the ring directly, with drm_sched_entity in the cleaner
shader job submission process. The change allows the GPU scheduler to
manage the cleaner shader job.

- The job is then submitted to the GPU using the
  drm_sched_entity_push_job function, which allows the GPU scheduler to
  manage the job.

This change improves the reliability of the cleaner shader job
submission process by leveraging the capabilities of the GPU scheduler.

Fixes: f70111466165 ("drm/amdgpu: Add sysfs interface for running cleaner shader")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 32 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b779d47a546a..149939c4eaed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1397,14 +1397,22 @@ static ssize_t amdgpu_gfx_get_available_compute_partition(struct device *dev,
 static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	long timeout = msecs_to_jiffies(1000);
+	struct drm_gpu_scheduler *sched = &ring->sched;
 	struct dma_fence *f = NULL;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(adev, NULL, NULL,
-				     64, AMDGPU_IB_POOL_DIRECT,
+	/* Initialize the scheduler entity */
+	r = drm_sched_entity_init(&adev->gfx.entity, DRM_SCHED_PRIORITY_NORMAL,
+				  &sched, 1, NULL);
+	if (r) {
+		dev_err(adev->dev, "Failed setting up GFX kernel entity.\n");
+		goto err;
+	}
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->gfx.entity, NULL,
+				     64, 0,
 				     &job);
 	if (r)
 		goto err;
@@ -1416,24 +1424,16 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 		ib->ptr[i] = ring->funcs->nop;
 	ib->length_dw = ring->funcs->align_mask + 1;
 
-	r = amdgpu_job_submit_direct(job, ring, &f);
+	f = amdgpu_job_submit(job);
+	r = dma_fence_wait(f, false);
 	if (r)
-		goto err_free;
-
-	r = dma_fence_wait_timeout(f, false, timeout);
-	if (r == 0)
-		r = -ETIMEDOUT;
-	else if (r > 0)
-		r = 0;
-
-	amdgpu_ib_free(adev, ib, f);
+		goto err;
 	dma_fence_put(f);
 
+	/* Clean up the scheduler entity */
+	drm_sched_entity_destroy(&adev->gfx.entity);
 	return 0;
 
-err_free:
-	amdgpu_job_free(job);
-	amdgpu_ib_free(adev, ib, f);
 err:
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 5644e10a86a9..3c268476dec8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -472,6 +472,7 @@ struct amdgpu_gfx {
 	struct mutex                    kfd_sch_mutex;
 	u64				kfd_sch_req_count[MAX_XCP];
 	bool				kfd_sch_inactive[MAX_XCP];
+	struct drm_sched_entity	entity;
 };
 
 struct amdgpu_gfx_ras_reg_entry {
-- 
2.34.1

