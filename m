Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937AFC7EE39
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C203710E800;
	Wed, 25 Jun 2025 21:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WtEPo5PW";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F083810E7EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySpTOSrmPixaBnKmOnxvPmalx/97beADUYaY5Wwklep9BW/iQjsCx3A74IdYxvRMmPWBWgsJAxSHOKgob+67nYhKfs5vzgHRIpL0Su0KlG6BTwI1uzYkiGhFm0+33hySvWZ18PnO8/REBZ4vXPuEYdJ7YQAV4tRx2KJV1a6KWg+4E73zQRO80lSWersFahRDmJGDTu5H4Zj7qj4aq3a6tbN91+IFg3Fl0DhbOKtMAHXUn1tG4o6TjETI3zcGa09H04xG+EEVxQK0xaCisMSVf3oOzs3kNgR80lFFA5rS1ayrFHtyV5SqXl3fwWz740/h0OlJK60/k/s5SN55cNOJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daUudhgTTg/3xKs9+qpbFdH7J6ALb+OrB14Q8IuaLZ8=;
 b=prtkwiKdk9k8cd6rxEANeuHysBoE6/9WeZibxGWRm66VMqAuFC9/SM3SMyJPO1n485h44bGMoHfzujoYXtldgzueYM42+gi1WyFmmdE7vCG+bMPFqLLGpCgVZH540MHzCKb2Qx99vsfNorUdZKSN6ZWOaseBdX+4idqyefzrTakNl3Z8zoxFJlrodTeq8N3V4TD+ynMunB2Nss/wc+V4k8EzUDFVEjBwzTg2yJIZjKAfXKdmpa5uPM/Hy7OFwrZEFW5IcEDxbSGDSjC4ZijsjiaJMovA8um0j8QKwVqkYJ4+WMzFVMtLCwrUnSCp3ST4ECx5HkVuYcm6nwpqd5/WFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daUudhgTTg/3xKs9+qpbFdH7J6ALb+OrB14Q8IuaLZ8=;
 b=WtEPo5PW+RwVvWT36O3wVEqOfEdoup+lJ+nwCTRPB/SvXDViPeYHU70cYFxeALd7w9clUzEcia2WVlWkVdorC37kv1OdYud4zyzZj5E/PG8uMtCtz4JZPsECdLzSBha/TDxor+oXa4Ng/2j5lbzitKM+yKRRcBcDwPgXwYCg+dk=
Received: from BYAPR01CA0030.prod.exchangelabs.com (2603:10b6:a02:80::43) by
 CY3PR12MB9656.namprd12.prod.outlook.com (2603:10b6:930:101::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 21:06:55 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::b5) by BYAPR01CA0030.outlook.office365.com
 (2603:10b6:a02:80::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:06:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:06:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/30] drm/amdgpu: update ring reset function signature
Date: Wed, 25 Jun 2025 17:06:10 -0400
Message-ID: <20250625210638.422479-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|CY3PR12MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c05618-8db8-4032-cf91-08ddb42c375c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjJWNU96dW9uekxTSENoRGxsQ1I0YjRnSXBEb2RTM1hhSkw4eEM0RkhodVZH?=
 =?utf-8?B?SmFPd2RTN1JVM0l4SUxWRmNndmFNUlluSDZMU3BYejhHVjJKUnZmMXlkdFIz?=
 =?utf-8?B?UE5XY2ZvbkZxSkpYUjNzN2tSSTBTVkNucTFKZlRwQ2NKUmtiRkFjZllOMXV0?=
 =?utf-8?B?UzJPbW91TENZQ1lFMmZjeU1PUW9PbmNxVVF6TmorSjBqWE5YSTc2cnh0RWRy?=
 =?utf-8?B?ZXYrQ3VsVlltUm5qZ3RmOGVlMk5kVWdUaUdmcEdMUFhaU3ZOU3BWTlJwSlNz?=
 =?utf-8?B?SVhhZnZNTTQzdkNWOXc1TjdHY0NVS1JPc3lyUFNra2tJdzh4aDRvb0o5L05n?=
 =?utf-8?B?bjZQcWlvN2hsTlVweWdvS1FmQXF5cmhhVGtNdFJzL3Q3K3FpYTFzWXYycGZM?=
 =?utf-8?B?TTZqb29ObzZDQnFGZGRtT21nNXowaVhxbi9sSDdNNUNYVGE4KzcvdlJzaWY5?=
 =?utf-8?B?UHhvRWRBaXczbHJMaUtZcnVSK3JsaDBlVE9uWi8vTWNmM3YzSU5qZ3ExUkh0?=
 =?utf-8?B?cmlQQnZXeE1kd3pnZENQM3hZVFhYckkwczFwUmFGU1RvcXk3cG9CMzkvLzl4?=
 =?utf-8?B?UDVReUNyL3BucmVwcU5FTG5hSkthQ0NlclRZakhmVFY5RFdSVDNvZE9MVmc2?=
 =?utf-8?B?aUlPN0VGVTI0VGRmY0ZVN0JUU1dCc1hVdGN1bUN6Y2NVSXNZeVl2ZEVWdDdw?=
 =?utf-8?B?K1h2VlFuY2t2WVhWNVVQQkN0SXhFMkpWVGZFdFFlcDV6Q0hDSE9kcWMxTmUw?=
 =?utf-8?B?VCtaM29MRENMNXltNGlGbVpyOWlwdGdJN0dYTVVYYWxwUHppRE1BRjNjZkh1?=
 =?utf-8?B?MU1HK1dwNC9iWWJiNGRLbGgvTUQzZUtFNUVEMFlOSm1SOHdmT2kwb0JkV0tk?=
 =?utf-8?B?d2xGK0krdjluNi9FTEpvcGhqU2JZcVJDaTlWZjJXczVXNE5BZ1hUNmdXSCtR?=
 =?utf-8?B?THV6ZUQzdWdsbXNQQmVldjFLQzlwdVAyNGt1Vk1wL0h4N0xDNG45bldZYk8r?=
 =?utf-8?B?RWwveno1NkRsMUx2VkV0V2MvMUVNV0doNDdPTjdJeWFYaERPTEtEMGJUcnEw?=
 =?utf-8?B?dXhLdTF5MVZlQml3Wjk1cU9hMGRoU2M1MmFKMENlbWcxWUZ5dXhqL3N0OEl3?=
 =?utf-8?B?N1cwVHUvOEEvc3hYYzNCRzZTc2dhcnVsczJ0ZnUwelZyTmYzbUFYUW5RbldC?=
 =?utf-8?B?VlFtRTJKMFhNWEZqOWV3YWxlZHlHNElVU0xsdzlKUCtueUcvL0ZqMjBOWXVw?=
 =?utf-8?B?ejlva2hocTd6SkJ0TzdTdHcvTEc4ck5EZUZ4Ni9FM0Vzc3BwUW1xR1pSQnFw?=
 =?utf-8?B?MFNyWEhXUXM0UWxHMGhVbk1iQkVLZkM1cnBqWGhyRmVlSW9EYURPSGZ0QjJL?=
 =?utf-8?B?Z3VsWkRVM05ZOWNDUDFROERlWFBQNDFaRHlTVVYwcG5PTHQ4VDBWY0xyRWJa?=
 =?utf-8?B?UmZzZ0Q0eHFRMm9PSWwzNzZQajJyTXZwVGZMbWFsTWlhbTErZ3NQVW9mdmM5?=
 =?utf-8?B?UEhrNVE2NTJmT2lLN24yS3VOdm84RjZCNmZBU281Q2FHdWR1c2lCMjhYNFh5?=
 =?utf-8?B?R3FseWp6ditDTzZjc3pHVUZucXJQYU5FN3NWbXBrQTJvb1FGMnllUENCZUJz?=
 =?utf-8?B?YnJxZjNBbXZaMkZmdUpuT3B5TnAvYkF1b213Zk1FaGZoOFZuS3lCQ256MVkr?=
 =?utf-8?B?NVkyd0JHenlTSytPYUxMaEZ5emhabjh4Y1JGZllVSk5qVFg4Vm5kdTdQdVNy?=
 =?utf-8?B?WFhGSml5Vko2eW1WVXRuejNBZ0oxVERJYnl3T1dzbisza294REdCcURGUXdO?=
 =?utf-8?B?VThOWm1vL25tUEJYd0EvTFBXcSt1VXd0bTBGdFBRZjRyQWdjblF4R3FpbUc5?=
 =?utf-8?B?aktGanY2RUhCbkFBbmhnbldPK0tXRzNSWkxSR04rMm5rZU5QUWZNV2VycFFQ?=
 =?utf-8?B?TERvQzJ2bGpnQWdvWVdRdVBPb3RiVnFiTnd4MjVoa3NCdk9oMFkyU1Q5b1h1?=
 =?utf-8?B?MUovOGFiWkFGbC92Nk1hQXI4eUVPbFd2aDR4a3pXVjZQTDdSZ2syNEh5K1VQ?=
 =?utf-8?Q?bxvzoJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:06:55.5512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c05618-8db8-4032-cf91-08ddb42c375c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9656
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

Going forward, we'll need more than just the vmid.  Add the
guilty amdgpu_fence.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 4 +++-
 22 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index ddb9d3269357c..a7ff1fa4c778e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -155,7 +155,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		if (is_guilty)
 			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
-		r = amdgpu_ring_reset(ring, job->vmid);
+		r = amdgpu_ring_reset(ring, job->vmid, NULL);
 		if (!r) {
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_stop(&ring->sched, s_job);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 9ae522baad8e7..de972f69d96e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -268,7 +268,8 @@ struct amdgpu_ring_funcs {
 	void (*patch_cntl)(struct amdgpu_ring *ring, unsigned offset);
 	void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
 	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
-	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
+	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid,
+		     struct amdgpu_fence *timedout_fence);
 	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
 	bool (*is_guilty)(struct amdgpu_ring *ring);
 };
@@ -425,7 +426,7 @@ struct amdgpu_ring {
 #define amdgpu_ring_patch_cntl(r, o) ((r)->funcs->patch_cntl((r), (o)))
 #define amdgpu_ring_patch_ce(r, o) ((r)->funcs->patch_ce((r), (o)))
 #define amdgpu_ring_patch_de(r, o) ((r)->funcs->patch_de((r), (o)))
-#define amdgpu_ring_reset(r, v) (r)->funcs->reset((r), (v))
+#define amdgpu_ring_reset(r, v, f) (r)->funcs->reset((r), (v), (f))
 
 unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
 int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 75ea071744eb5..4b2af95203b26 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9522,7 +9522,9 @@ static void gfx_v10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 	amdgpu_ring_insert_nop(ring, num_nop - 1);
 }
 
-static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
@@ -9579,7 +9581,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
-			       unsigned int vmid)
+			       unsigned int vmid,
+			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ec9b84f92d467..8d5c0ab016d2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6811,7 +6811,9 @@ static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r;
@@ -6973,7 +6975,9 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 1234c8d64e20d..795bd353a9cea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5307,7 +5307,9 @@ static int gfx_v12_reset_gfx_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r;
@@ -5421,7 +5423,9 @@ static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 866e39f6fab3f..d91e0423c4820 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7172,7 +7172,8 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 }
 
 static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
-			      unsigned int vmid)
+			      unsigned int vmid,
+			      struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c233edf605694..272f0f8e41d45 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3552,7 +3552,8 @@ static int gfx_v9_4_3_reset_hw_pipe(struct amdgpu_ring *ring)
 }
 
 static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
-				unsigned int vmid)
+				unsigned int vmid,
+				struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 4cde8a8bcc837..93eb71d2ce304 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -764,7 +764,9 @@ static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
+				unsigned int vmid,
+				struct amdgpu_fence *timedout_fence)
 {
 	jpeg_v2_0_stop(ring->adev);
 	jpeg_v2_0_start(ring->adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 8b39e114f3be1..45b8702d20ad9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -643,7 +643,9 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
+				unsigned int vmid,
+				struct amdgpu_fence *timedout_fence)
 {
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 2f8510c2986b9..9bd0ae4a24a1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -555,7 +555,9 @@ static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
+				unsigned int vmid,
+				struct amdgpu_fence *timedout_fence)
 {
 	jpeg_v3_0_stop(ring->adev);
 	jpeg_v3_0_start(ring->adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index f17ec5414fd69..4fc1ef85b2945 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -720,7 +720,9 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
+				unsigned int vmid,
+				struct amdgpu_fence *timedout_fence)
 {
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 79e342d5ab28d..bdc7612ba56a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1143,7 +1143,9 @@ static void jpeg_v4_0_3_core_stall_reset(struct amdgpu_ring *ring)
 	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
 }
 
-static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *timedout_fence)
 {
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 3b6f65a256464..aee4f50a0f52e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -834,7 +834,9 @@ static void jpeg_v5_0_1_core_stall_reset(struct amdgpu_ring *ring)
 	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
 }
 
-static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *timedout_fence)
 {
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 08ddef027f21f..b8828432c98a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1675,7 +1675,9 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
 	return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
 }
 
-static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
+				   unsigned int vmid,
+				   struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 id = ring->me;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 37f4b5b4a098f..2fd72c85cf014 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1539,7 +1539,9 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 0b40411b92a0b..21421f1bd2095 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1452,7 +1452,9 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 2f3250d30bb01..2cd5f60aef859 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1566,7 +1566,9 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	return r;
 }
 
-static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int i, r;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 86903eccbd4e5..6210be7e4a52f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -802,7 +802,9 @@ static bool sdma_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	return false;
 }
 
-static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int i, r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index b5071f77f78d2..244359fa4aacb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1967,7 +1967,9 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 	return 0;
 }
 
-static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 5a33140f57235..75c07ebf7fe4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1594,7 +1594,9 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *timedout_fence)
 {
 	int r = 0;
 	int vcn_inst;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 16ade84facc78..731f7762c3e0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1465,7 +1465,9 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index f8e3f0b882da5..f975994b3ff44 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1192,7 +1192,9 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-- 
2.50.0

