Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C665103E17A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42D8110E82E;
	Wed, 18 Mar 2026 14:09:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5sDhbWNb";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74BE010E82E
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mC5rwH2eIMRWDMeztVehYundgf+5DAt+lotd2H6hkHcORIK3J+IHCE3xlMSuvaEzfGKlsYohBeymMealj4/QJUSMoGkvgEl13hAO7Il2YUPuzpchyj+x5+GCYq5h9xOK/8C8oNdGI+AFJMqPTArK3izqVCm4OVQv/bPxbTd/SNfyOI0z5rl9RKE4uOBUTNDfdhg9JNjW5GYNKRZTGC3hokF4GO4LY+gmqWl9j2Ck3VjCweTQuU7l8YjM1JzeD1tlV3jb1WWLPNPSlas9ZiFJOu53u+PXAWuqGmRzASRhIAdeLnyxLqSYGLqHIF1iLkUpgSMrWmjaKjKmz23UkYNDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8jM88lUbxNH43qU7r6fkhlGuWtCcCmg1fo240qoi8s=;
 b=B6L80/rkYxw/qDZwFWI0zl7yYRBQ+cCzJD4108hTKMn0+luDszVtlD2LacUhYX0fLk9wyGRGfDfw6DPCfhr5tRwx93kZ986Ri+lpO+UVUV53at1BAM1lTAynrW7HLO7jvJ4kS4/JOUyix8wOftASsvz58H2ZPebPsx4oskkLqz4LQNETwMadFlUJ0oRfoZtIXERTIYX8/cFZJyltWo+VfVKCdlt25z1Iqpij9stC7+/AL13Eq5A72bMh+IVrkhp3H/5S4jr+1qAMrcT2E89+3nv6u5/e9x7qXAY28dSjEckwy5P3dfyBZ7OXOXPYX6vCFLl2r9dQ2Iwkwr7uwgbgRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8jM88lUbxNH43qU7r6fkhlGuWtCcCmg1fo240qoi8s=;
 b=5sDhbWNbDd5Esu0k6wGGMqV7LLI1OqBdjsripImj+N9QdbwGTL1JxnfVzG8/ud3KowlBYXZQwbnijCMdAEbqyR8+UwLKCmZng6EAdMPzMplNQomCcCabufKKcMMq5vwuu0grQaMRW7ykhI49UH7kvQn0ic4Zp0podrrwn9cj1yk=
Received: from BYAPR11CA0088.namprd11.prod.outlook.com (2603:10b6:a03:f4::29)
 by DS5PPFA33D606F8.namprd12.prod.outlook.com (2603:10b6:f:fc00::65b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 14:09:04 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::2c) by BYAPR11CA0088.outlook.office365.com
 (2603:10b6:a03:f4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:09:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:09:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:09:03 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:09:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/16] drm/amdgpu: don't set queue priorities for kernel queues
Date: Wed, 18 Mar 2026 10:08:37 -0400
Message-ID: <20260318140837.582776-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318140837.582776-1-alexander.deucher@amd.com>
References: <20260318140837.582776-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|DS5PPFA33D606F8:EE_
X-MS-Office365-Filtering-Correlation-Id: e615b1f0-f7fb-4929-be37-08de84f7e96c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: I9Y9+QH+8EMT36qvrSdzpdp3XjKy+kizRzyYFJJuLZlhp8yfpdwiDrE/PgN5QGN5De5GZpCJVjyCf46RmhBMu8Z1Fj2GrNSdbrI+5kVvrVActNuvojClCYtRQlCoWwx+QwyxzITvFX766WLCUTtAq7h7dEe/ADuavb1iLA50p0lU+G7C6vn2a4yT0oPPEZHQ2t9XJF1K7sHr/x+ydG8I8SEOvrnD0t9tKAcCkKeE84YK8vGJvQjjcsGYFD5qGbVGzSK4fTCKQxzb1d1SyCZYG/c/usHAXPLfITQsiIKL4f4iuD4cMSmJBmMnxBCp2ChW+B/XRkp3t1huO6kz+Af3SahGtOVoNYzcl9h+PmdyfC8mtrnaDp0DRn58SfRwjJ4drenLlUam2BVnmWPyZ2W/drwxRuF/QNdP2hsU0UzHkVwd47E7dRBuFEoLiHTVbNUwTM9aTRGgaS21dbSKAmaW2WfNFqqQEvNy33SA7P8K/ItDme6Kai3SPhpm1AlRYxNMUUUmAUSuFiSJ6BNrDpvhplR24Onmd7uRGftXqEl+NtNgmhSvxDZQsbEd6McpysN5hKTA+ugxCtO/WqjWi/nbXO4aozd3TLfqO1nxHG+pea8iVc+wrrQ8hflr+bXjC+kmyxXEjXq96Fid7r7yRKWfcxgsgNJWOqnQHWGOLVR1OJQUDvagT3T1moc8wqPq67OIScM0vXDpyp/8Qomia88chTELIcIbKdSOEGLXIr+EEURwslayC8N20W7Fo7jXonEFQwCKhgicInKArHzrzUlmxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C4kjW6Gh6tEQ3zmDxAH05uUR3QSkawDTC9v3gyvXXPM6+uqA+LgfSd3Y9m1k0TjAwkr2+O/wDSnpgSUsQDQc5RoXnKighNZ7EpytosvbhDUSQo4icMnaeP4y5e8ydiPGNoUn+yvCHnul2pEYk4rCtiN2mNW/aiI1R2tkkmdFMoDa1U4DFR9jVvS9Vgt7PZeCBUgaTMxZrsSd8wRLdG4fGHqQP2LluzvTh3CM6btKAU2//mOJMNeSgy7E0ayNhuuSsrsKNAmP/A2cCjALfX8xrM64RU6jOHBvMhqsPze/Yok0UBx0bsVj3IcUJ08TaT/xJmQ0wd7d+Rejl2PJa8LZq9g+K/bOfxCqLG5fu99PPnypVD9uCRI8FJl8D8AtHQlTcXqCg10vLyMymUlESdDI5lkMW4ZSDEdXTLl6S8XjCkG/WF9epccF3WMRtYi7QZV6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:09:04.0393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e615b1f0-f7fb-4929-be37-08de84f7e96c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA33D606F8
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

Align with KFD and don't set queue priorities for kernel
queues.  This can result in starvation of lower priority
queues.

v2: fix GC 8 and 9

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 2 --
 4 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 83750ab4e81b5..ccfbb6fc5f440 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -780,10 +780,8 @@ static void amdgpu_ring_to_mqd_prop(struct amdgpu_ring *ring,
 	prop->hqd_active = ring->funcs->type == AMDGPU_RING_TYPE_KIQ;
 
 	prop->allow_tunneling = is_high_prio_compute;
-	if (is_high_prio_compute || is_high_prio_gfx) {
+	if (is_high_prio_compute || is_high_prio_gfx)
 		prop->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
-		prop->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
-	}
 }
 
 int amdgpu_ring_init_mqd(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 49999bdb13499..b29dde9297b20 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4390,8 +4390,6 @@ static void gfx_v8_0_mqd_set_priority(struct amdgpu_ring *ring, struct vi_mqd *m
 	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
 		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring)) {
 			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
-			mqd->cp_hqd_queue_priority =
-				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index aaf75c82b1bf5..150040625c440 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3540,8 +3540,6 @@ static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd *m
 	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
 		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring)) {
 			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
-			mqd->cp_hqd_queue_priority =
-				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index e843793112638..cec64a8f21ebd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1817,8 +1817,6 @@ static void gfx_v9_4_3_mqd_set_priority(struct amdgpu_ring *ring, struct v9_mqd
 	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
 		if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring)) {
 			mqd->cp_hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
-			mqd->cp_hqd_queue_priority =
-				AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
 		}
 	}
 }
-- 
2.53.0

