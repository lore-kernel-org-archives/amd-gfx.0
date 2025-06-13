Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ED7C7114A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035AB10EA51;
	Fri, 13 Jun 2025 21:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JaIoGYlj";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8545410EA5D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TO7llbh3xiQ0fG2MbFt2kMdz430V6hNsOErFvbfSfS3s5RVr46aEzvYsTn3/uw7h5PWqVOU6FOXjFsN38WeTsXpXmgD2ENeEuyAY0ab9MtRnGS4XBGOqKctTwfVZX0gi6hweh0wD5gKlHj7LeL6oDI0HbVXXsXEIVMXQHTNJv5cxrQL4RoV8JEVvz9kFUslJkMQGx6z2Aj1tx70YEu599IicIZzYPz4ADPvN0OSGZ6qW2dvE3LAFKY6LZqH4iLdPN2AmXUTd/xwgITzH5z0fU/DTEVOip426AuZByKopibARYpdo8aTB4pz8fa11pPSoRVUxgy8HKRpK79k8rIerRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyqB4eUbNOA/pYp4g+0l1eGAqH49pUxGq0Y3Jahgavw=;
 b=TXk76/JaaHoqIW+cbqrv6meZ7kgm18TWlRLUwCoSWoZs3kPsdpNPkBjgUamfqFusyg28H2mWrrVJEQu5JpX302HBbQi0iye1h8ya8IwL+rqz8TCdCL8QgUycywSlwNdPwNqIwhrXTv/2lvehoqaD+NUBiND0K5JLoaidpQuLSJUROy6BkbuO8ueJFx9gQvbzVM+KRJDXGr9OAGqm4/i79fUlSjyvVeXvxGAyJWNU1gy9sRsh4XA3JFawvap94IRaCFqKsVy1XnmegYkjW20Z81oYs9AxzGZqtB0KP4y2g0gc6YvSBz9DpcSA62fGuIWGt1FzZcAwXXS5JNARlGx9DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyqB4eUbNOA/pYp4g+0l1eGAqH49pUxGq0Y3Jahgavw=;
 b=JaIoGYljPvR/8TuX12mEOgjDpij6ZiXIf756RzD2nW53f5QeIwZAaRlIi+rKo5m9cHIrkQSvgKV0kVi1rGAnhD0SF1HX1jlIhSZcfQ8+7EuUZU6ptUY3MnkZvyvxI2f1vw5z2z2OVwKalorB0neV392BaaDfD8jYUN3YH9DDHLg=
Received: from CH5PR04CA0010.namprd04.prod.outlook.com (2603:10b6:610:1f4::18)
 by CY5PR12MB6035.namprd12.prod.outlook.com (2603:10b6:930:2d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 21:48:08 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::fe) by CH5PR04CA0010.outlook.office365.com
 (2603:10b6:610:1f4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/27] drm/amdgpu: rework queue reset scheduler interaction
Date: Fri, 13 Jun 2025 17:47:26 -0400
Message-ID: <20250613214748.5889-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|CY5PR12MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea4bcc3-1de8-426b-9427-08ddaac3fc69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXIvV1JhcUJEYlZxVmdZNE1qaDZoV2NvTFFUYjB1Vno3V2IvcjJmWnhsTUlG?=
 =?utf-8?B?M21tdDBtT2g1NVhCNkxmTUluR1R1Tndwd1BXNmdFZXlGczBDc1YzNjF0ZEtl?=
 =?utf-8?B?YkExMlB0QTZVNi9LZ2hDNlFQK3UrMk5UN1B0ay96K1cwbXJYUHNxVVIxODJs?=
 =?utf-8?B?NHFIeXFXa1VBdytMcVF5SUYvRkttOS8zdFhVU1o1cDYwWUpsWElMUkJGSStx?=
 =?utf-8?B?V08xczNpK3JLV1c0V0Nha2Z6ZUpLSUlVUlp1ZU9pQnVuY1JhUkdHQWJjVHZU?=
 =?utf-8?B?UUdlaDA0Mm9saHB1eG80eTJ1NVp3WXFVdVF2TTZxZFd3aUFaeTZrSzFIQTVN?=
 =?utf-8?B?Q3MrWGU3Y3BBOXdwejUwMFpnQ2RSNHZGMHRlT21vK1g5eksrMEcvWm1id1Uy?=
 =?utf-8?B?WFdYWmE3N0tJK0NMaEtwNng3NkpyS1R6WENIQWIxNFhVbHdjYnpoUFd4ZTlO?=
 =?utf-8?B?SHc2b2lSU0hNTEljeXk2czViL3ZvNlVVNEVCSjN2ZGhhY3AxZWVlSXFta3J2?=
 =?utf-8?B?aGMvMEdxYUVwa1pQWU1FOU5xUjZiVzUwU0s0SXFvMEtZVFR3Q1hRenZJaDZN?=
 =?utf-8?B?cTBtdXhseDdxaWMrZGYrcythbTYrdGJMYytWYVpUZUpsYWJIYU5kUlRoYWhz?=
 =?utf-8?B?SnNYZmtMZHZTRFZ1UlJ5azhCV3V2RE5OU0IwNFJVOFBoZUlER09xTWJNdXhM?=
 =?utf-8?B?eDFKUUZhVUowaWhpMFJtYmd5VVVmUE0vazdPbGhhbnN1MFRxMnd6YlhFOHFw?=
 =?utf-8?B?YXRGekl5Skh3NXhQcTk0YjRYeXBvTWF0bmpUNVJDQkRSeXFGejdMUGhLMnc1?=
 =?utf-8?B?cFRyaFNneUhGeW96UkZYZXZweVhIS0hDbmNna1JBekVOK3FkTGJzZ1QwL3Jq?=
 =?utf-8?B?ejd5TW1ZRG1GSmsvTnhTVjR6ckN6MVBVQzRvK1pkMEZWNXEvNzE0QlBsV2My?=
 =?utf-8?B?R3R4TTdBZi8xcTViRWpPc29kRURlWS8rSXhLdWhiQ2ExTzBLM2JUcTBLV3Nk?=
 =?utf-8?B?ZTE1alZZMnNJOXhrVUJDYXpTY3gybEI1NXJjdXlRSXZnREcyaFQvem1yQWE0?=
 =?utf-8?B?QjhnRmNBVWlSaWl4dUVHNGdaeFpzN1NWR0lQMFRxVk44dG1mc1ZoZUFmVnND?=
 =?utf-8?B?anNQZ1J6SC9YWGcvWUh3aWlidmhKSS9BOEJnZ0FtUmpZVlE4ME8xWStQTnJD?=
 =?utf-8?B?OXJIMEJvU0pNUGFEYVJzbWFpb1Zrdm5mbE9kTHkwK2Q5Z29QZFNFd2NLRE9w?=
 =?utf-8?B?QzNYUi93OFhDZUYzT3FwWkdsWlNrVTR6VGpDYlRHc2IxUWxMVGdRblN0WEU0?=
 =?utf-8?B?eDFLSmpPejlSUzJDd254cC9zU2FoYkE1TG9pNFEzUkxLelpmY1M2UkdTRmxC?=
 =?utf-8?B?bkhQWEtXRSs0VEtiTWg4eTJGalUxOWU0dU01eVVXc3IvTFRIMkZSeEJFc3hr?=
 =?utf-8?B?NVhZMTlyNGRGUzlDM3NBUUtwTVhPeXRtWXRwL1pVdGE4cnROVjU4Q214U0ZU?=
 =?utf-8?B?cjBvWHh0ZythcVh1aVByMkxUS2dUYTBmMUJTdHZCd0hYS3FKNFh1RTdkbFJm?=
 =?utf-8?B?dkVqclpXSWtMZEczaG1zOHRPcE1MeDJPR2pwTTFjOGlrc1hNRE5mdmF6Tk83?=
 =?utf-8?B?MFBSNTdSL3NaRUVjYitEVy9EcWVua3RZaXdLcHlRRnRiaVhsNTZ3SXBoeTlP?=
 =?utf-8?B?aXIvSzB3QThHV2Z5aDdZMzF4QUZUS3l5cU43U1lrQiticitKZ0k5UUxNOCtC?=
 =?utf-8?B?b1VVQURnd3BwY2tKR3l2bEN0eDJNRU1tOTVvSG1GYW54NktxV2s4SGdvaEpH?=
 =?utf-8?B?NGJmVHhNUlNtWHFlMlBHdk1SK1hwcjgxL29zdjk2aEhrazE2TkNIa01WR0xq?=
 =?utf-8?B?dEk0UXcvMUxYTFluRVBlTjFyRFYwSS9yRzE4WDV6RXNaa09Ecms3RWdJb2tZ?=
 =?utf-8?B?Wm1qL3JzZUxaenI0d1BaQm56Zk9FSXRqMDgzV21zMWhBYUprdVN5MWJLN2s4?=
 =?utf-8?B?Mmx3MjU3Y0RZLy8xQmFtRThtZk1mbFhHRU92NUVXNmRzREpqcnVPRktHVEd0?=
 =?utf-8?Q?zkZWBr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:08.6060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea4bcc3-1de8-426b-9427-08ddaac3fc69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6035
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 35 ++++++++++++++-----------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index a7ff1fa4c778e..93413be59e08f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -91,8 +91,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
 	struct amdgpu_task_info *ti;
 	struct amdgpu_device *adev = ring->adev;
-	int idx;
-	int r;
+	bool set_error = false;
+	int idx, r;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
 		dev_info(adev->dev, "%s - device unplugged skipping recovery on scheduler:%s",
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
 
@@ -152,26 +154,29 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		else
 			is_guilty = true;
 
-		if (is_guilty)
+		if (is_guilty) {
 			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
+			set_error = true;
+		}
 
 		r = amdgpu_ring_reset(ring, job->vmid, NULL);
 		if (!r) {
-			if (amdgpu_ring_sched_ready(ring))
-				drm_sched_stop(&ring->sched, s_job);
 			if (is_guilty) {
 				atomic_inc(&ring->adev->gpu_reset_counter);
 				amdgpu_fence_driver_force_completion(ring);
 			}
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
-	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
+
+	if (!set_error)
+		dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
 		struct amdgpu_reset_context reset_context;
-- 
2.49.0

