Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5C5C71156
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E389310EA59;
	Fri, 13 Jun 2025 21:48:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y9Sv7Eby";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DFDA10EA5E
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwdaJN6KKjeHm3FQHp24y6FZhj5M5c4zmdz6GcVV4pqT2HlxrmEEbExk9Nn6NUodXDz63/UIwyPdef648ZNZ8DWHdLEAsBM4/RlfOGVnqbks5N9N08eudtXC/fpyuLMOTGbxuZ1Dm9hVAKA3lPXJFkE4LwBlFUP+SFNoLo97T//968TyC16WbYX39vrKRnx0PdFQaZdhfsCswRHNauIR8cw3OgUwG+f2Vta7fzgdcEubtG20NN7L+fBXmoxV4l/TKjHuLqkzGypoTsRENGsJiHwSBpv0fUr4OfnQ4gv/jqaQqsNfncfkC2AMqKTOoWtkCcNG+z0IF3iEcVyNm4zbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XqyQkxVMvHRTiQIGFkKj29EEhhG5UcPzY2tS377vs0=;
 b=hXPB4IKOjHlsCJ8AKMF49UsXFtwn1ab2S9cgJFnlci0bGn96Fkzq598pO45x0a50B10z4OwAQo0smAWb354vUQ49/laWyZ1AI5O93XvfzZLUMgtIJXw56i/T86cM0Ubt/j6tPQ5KxCTWVO4c1ZmIE/fi13TkZ73CssMtEwaDPQoNf1LyYsJTglSqgpAcWTEXW+rAF0ZsDjB9L9EbgllbLnQ/oLsB2KZoBrplackwQbTjwJ4iL8ult95HHWofjuPjtUGilxoJQZaavPXW8HdeU/7m4DWX2O2gqDhlYkNUuuhfsBv4msLLQCdWI8AolGkV0LhG1J0MO+nimLj9wdzLFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XqyQkxVMvHRTiQIGFkKj29EEhhG5UcPzY2tS377vs0=;
 b=Y9Sv7EbynxtnmGa9YqyITm8ZODJfWwK2gkK6rCQnKYH3X3t++XI6Zbio+EtR3BSjL8IXrAI3kGvzrUF5aqSj3lq79Y8m1rX1I4q5GX7vcrG2kugUJx0KoVAWE3qg3vqXBz2+oYloIkmXvJhKe0MucdH9NG1lpfa+rEN3yzS0MRY=
Received: from CH5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:610:1f4::7)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 21:48:09 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::8f) by CH5PR04CA0007.outlook.office365.com
 (2603:10b6:610:1f4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/27] drm/amdgpu: move force completion into ring resets
Date: Fri, 13 Jun 2025 17:47:27 -0400
Message-ID: <20250613214748.5889-7-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df168f9-7f04-4cfd-4410-08ddaac3fcbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHNIdWVoOUFyVkVPdXNUOEoyRGZyMm9uWnB6ZlBxcklRRVlnd3RBYnBMaWtW?=
 =?utf-8?B?ZmkxQXROZ1FESVhNYUEveWtEQ05raDlXNlZmVmZuL2pDSzhhYStrSCt4TjJs?=
 =?utf-8?B?ZWJPMHB0OXk0dzlVQUFnUlowazNlSFdDVTh4UngrZUE4S1IvMTBTQlNub0M3?=
 =?utf-8?B?QW5reXlndWdOY2x6dUNCYVVrUUtMbjZCa2FzakVWOVBPVUp3bVFyaE9FR2dl?=
 =?utf-8?B?bm52eHdrQTI5dmtDUHR6L3RZY1hDS2NoYzk5cjRmUkdGRXV3dHZqU0FyMjNi?=
 =?utf-8?B?TXZKR0JUVzhRS1R5Zmk2WUNGSEVOVW5FSGdQcnZTRnVVQmRIaWg4eDk1TDJG?=
 =?utf-8?B?Y1RibFg2amhYaS9VSU9MLzZpKzdJa1pSMG5VYWtaUGFxdVluWm9manJZeXpM?=
 =?utf-8?B?Qjd6bmdyYWliY3FIU2syZE4vWUV4WXgxNnEvdEpPeXltVlNsTmNlRTBJT2lz?=
 =?utf-8?B?bkVWZGJPVnNzbjZnc2ZtVjIyRUZRa0NKeG81V3BaNXV4SHZDY0dJV090ZnF0?=
 =?utf-8?B?REhiUmVURXYxSFpBVGMvUm9LQnp6UEFkQm42QjNYOHRyTCtyOVZ2ZzRHbHNR?=
 =?utf-8?B?RE4zWVJMcTNHK0JNbTVtREx1SGsrZHNscmcyYWpOMU4wK1hkMmNPdEF1Unl1?=
 =?utf-8?B?WjFoQWl4U0U2ZVdlTHhJa2tyaHkrZ2NPVTIxdE5wQTF4VGE3WFljQWFRck9C?=
 =?utf-8?B?RUdzMEJWZ2RYSlVTdmRVL1ZnYzhHbmIydzUyeWtzTWNmZkx1MkpKVEZ1VkJl?=
 =?utf-8?B?UEZWdzR3bkxQc21nZ1NaYUlpR0VrYmo5U0ErVDQwdGwwa1ZKYVltWkF6RFdo?=
 =?utf-8?B?VVBKeGlraCtHUnoyWlFtd3cyeGlJQzFPa2kzNlkxeS9oYmpvRHhmL1BUbHpF?=
 =?utf-8?B?c3Z0OHN3MzFlRTlFV2t1TTdEc0RBTHNTYmRUdHVJdDRVaGUreTBqTmV6N2I3?=
 =?utf-8?B?OVdXN1N6T3NGeC9KYU5Qa2ptcGNwSjBKd3pzZGV1L3I1S21HWUErSjlRekxm?=
 =?utf-8?B?VVlWT1pJWGhCVXBVbTVudlhwalQ4aFBrellIbHZ4MENJVFZDY2JkdGFPYi9E?=
 =?utf-8?B?N05CTk1pSWFCMitFOXpkbm84bW9uN3FJSEQ3VHEzZ3BUUnNZVWlaOUI1QlM3?=
 =?utf-8?B?dGxnOVU3WWJpdlh4VEhBUm5nd1AvL2NSMENzSWpMU2FPK0doWHlOU3kyZTVi?=
 =?utf-8?B?bTJaTkZsdzZ0ZE5rUmZXQVNDOWZMOGk4TTZTdEwxdmdac0tleVZPRTZFN0pL?=
 =?utf-8?B?YUF1ZFliVUhQS1dwby95ajd3Y0JOOTdpY3J6RkFaNzR3OTVHTkIveHM4YXBw?=
 =?utf-8?B?NFo5M1FJVXhlM21qN1QySGZ0QTZZdHJsbG9LWjRWWjQyMUVYL1BkUGxvdExq?=
 =?utf-8?B?VUZSeHduaWhPVUhlalRFS0NwMi9HZFdNbXpOcUNwZWRUaTkybytuQ25qNE5q?=
 =?utf-8?B?eG5ENEhxZzNnVUNNRk9SQ3NsM3orR2FScW9BeC9tRkNhNnpjYnQ3cWtxeUhi?=
 =?utf-8?B?UzQrMUppbmF0UkNiVVl2OFA2UUFmQ3ZWRVhYTkw0ZkJmOCtFZHhYYnEvWGF5?=
 =?utf-8?B?WlNHQktFR1dFWnBabjRFdi9xYlVLMVN5REVGUytQWnFlVjM5Z0ppRnJaUDFj?=
 =?utf-8?B?TmFRWEJwZ1gvb3k0Y2RTeTRRUFZCbXBYcGQrTVpqVlI5L3FGNmJqZXNUUTdV?=
 =?utf-8?B?SmF3ejRsRm1wU3Bkdzg4TDNDL1FmQmpVUFdubWJDbnBwbzlxdnlWcE1UOEty?=
 =?utf-8?B?dGZTK2I0OGRvandXalNNTkFHeWtjdTFqcHBLOEE1aGZoWEhIanpFSk4ybEMw?=
 =?utf-8?B?aG5QWk1obC9aVFlpUHpzRkFIWjFCbjRVRWd5eHdrM2xzV1NVN3dmVHBYZ0pO?=
 =?utf-8?B?R201NU5kY3BjTDl4V29Vdy9DQ1BTaGFyaHNiQ0IvdHB3ZkJwOFFmbXhiRUti?=
 =?utf-8?B?SWJGK0JzUlFqdjhPUk5IcUJuRWwrSVBVUUZNZmtyeGxta1V5MTZCdElCUDVu?=
 =?utf-8?B?eUV2dlRmRDZmTThVWWVlYnpXQlE3NVBpajBMbDQyOXZiRDhOeWppM2JIK1h0?=
 =?utf-8?Q?OKvqPQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:09.1607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df168f9-7f04-4cfd-4410-08ddaac3fcbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501
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

Move the force completion handling into each ring
reset function so that each engine can determine
whether or not it needs to force completion on the
jobs in the ring.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  4 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  7 ++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  7 ++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  7 ++++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  7 ++++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  7 ++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  7 ++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  7 ++++++-
 21 files changed, 136 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 93413be59e08f..177f04491a11b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -161,10 +161,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 		r = amdgpu_ring_reset(ring, job->vmid, NULL);
 		if (!r) {
-			if (is_guilty) {
+			if (is_guilty)
 				atomic_inc(&ring->adev->gpu_reset_counter);
-				amdgpu_fence_driver_force_completion(ring);
-			}
 			drm_sched_wqueue_start(&ring->sched);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
 				ring->sched.name);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 444753b0ac885..b4f4ad966db82 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9577,7 +9577,11 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
@@ -9650,7 +9654,11 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	return amdgpu_ring_test_ring(ring);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static void gfx_v10_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 4293f2a1b9bfb..5707ce7dd5c82 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6842,7 +6842,11 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -7004,7 +7008,11 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index aea21ef177d05..259a83c3acb5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5337,7 +5337,11 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -5452,7 +5456,11 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c0ffe7afca9b8..e0dec946b7cdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7223,7 +7223,12 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 		DRM_ERROR("fail to remap queue\n");
 		return r;
 	}
-	return amdgpu_ring_test_ring(ring);
+
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 79d4ae0645ffc..e5fcc63cd99df 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3620,7 +3620,12 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 		dev_err(adev->dev, "fail to remap queue\n");
 		return r;
 	}
-	return amdgpu_ring_test_ring(ring);
+
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 enum amdgpu_gfx_cp_ras_mem_id {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 4c1ff6d0e14ea..0b1fa35a441ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -768,9 +768,15 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *guilty_fence)
 {
+	int r;
+
 	jpeg_v2_0_stop(ring->adev);
 	jpeg_v2_0_start(ring->adev);
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 5a18b8644de2f..7a9e91f6495de 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -647,9 +647,15 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *guilty_fence)
 {
+	int r;
+
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 4963feddefae5..81ee1ba4c0a3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -559,9 +559,15 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *guilty_fence)
 {
+	int r;
+
 	jpeg_v3_0_stop(ring->adev);
 	jpeg_v3_0_start(ring->adev);
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 327adb474b0d3..06f75091e1304 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -724,12 +724,18 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *guilty_fence)
 {
+	int r;
+
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EINVAL;
 
 	jpeg_v4_0_stop(ring->adev);
 	jpeg_v4_0_start(ring->adev);
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index c951b4b170c5b..10a7b990b0adf 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1147,12 +1147,18 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *guilty_fence)
 {
+	int r;
+
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
 	jpeg_v4_0_3_core_stall_reset(ring);
 	jpeg_v4_0_3_start_jrbc(ring);
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 51ae62c24c49e..88dea7a47a1e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -838,12 +838,18 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *guilty_fence)
 {
+	int r;
+
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
 	jpeg_v5_0_1_core_stall_reset(ring);
 	jpeg_v5_0_1_init_jrbc(ring);
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 83596e032ee35..c5e0d2e730740 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1674,6 +1674,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 				   unsigned int vmid,
 				   struct amdgpu_fence *guilty_fence)
 {
+	bool is_guilty = ring->funcs->is_guilty(ring);
 	struct amdgpu_device *adev = ring->adev;
 	u32 id = ring->me;
 	int r;
@@ -1684,8 +1685,13 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 	amdgpu_amdkfd_suspend(adev, false);
 	r = amdgpu_sdma_reset_engine(adev, id);
 	amdgpu_amdkfd_resume(adev, false);
+	if (r)
+		return r;
 
-	return r;
+	if (is_guilty)
+		amdgpu_fence_driver_force_completion(ring);
+
+	return 0;
 }
 
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 6cdaf60826923..09419db2d49a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1544,8 +1544,13 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
+	int r;
 
-	return amdgpu_sdma_reset_engine(adev, inst_id);
+	r = amdgpu_sdma_reset_engine(adev, inst_id);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 1f7e21994b796..365c710ee9e8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1457,8 +1457,13 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
+	int r;
 
-	return amdgpu_sdma_reset_engine(adev, inst_id);
+	r = amdgpu_sdma_reset_engine(adev, inst_id);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 43bb4a7456b90..746f14862d9ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1561,7 +1561,11 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	return sdma_v6_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v6_0_gfx_resume_instance(adev, i, true);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static int sdma_v6_0_set_trap_irq_state(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index b5c168cb1354d..2e4c658598001 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -826,7 +826,11 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	return sdma_v7_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v7_0_gfx_resume_instance(adev, i, true);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 083fde15e83a1..0d73b2bd4aad6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1973,6 +1973,7 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
@@ -1980,7 +1981,11 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 	vcn_v4_0_stop(vinst);
 	vcn_v4_0_start(vinst);
 
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 57c59c4868a50..bf9edfef2107e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1623,8 +1623,10 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	vcn_v4_0_3_hw_init_inst(vinst);
 	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
 	r = amdgpu_ring_test_helper(ring);
-
-	return r;
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 4aad7d2e36379..3a3ed600e15f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1471,6 +1471,7 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
@@ -1478,7 +1479,11 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 	vcn_v4_0_5_stop(vinst);
 	vcn_v4_0_5_start(vinst);
 
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index b9c8a2b8c5e0d..c7953116ad532 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1198,6 +1198,7 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
@@ -1205,7 +1206,11 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 	vcn_v5_0_0_stop(vinst);
 	vcn_v5_0_0_start(vinst);
 
-	return amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+	amdgpu_fence_driver_force_completion(ring);
+	return 0;
 }
 
 static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
-- 
2.49.0

