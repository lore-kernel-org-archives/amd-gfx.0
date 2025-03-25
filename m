Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051A6C35FFC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 15:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F9AB10E552;
	Tue, 25 Mar 2025 15:24:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bejeh+x+";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C757C10E552
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 15:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8HuRt7yE7jD5RQ1Url0VzFTY1O6hgWCv0YA6mIUeRzTvrvADZBp1eGr+w0/yU0/1pBHYNkowOsKx74w3LkV6J5Ccu5yrj9TO7k8GPNyizX0lLRBa6jgmQPFFWb8okZLbz7eeVbtJ/g8UA4qfZWhVw42iREOVAs/c70dCja4NwaYC/XwWKRSYY61as+EHNa61bxxrd6ptGl2ql8pV61qjbB4Hgy4ANRsvsaFfwcULbywZNCCaS+trX0nK/md0tsHJ2jqpdFmaW3u8m8Lr+hgPUErjQXBj9XlJ0IBTX6xbIIWVe/XaKXWxVUHiX6iEMkEzRhKORd4PTpwT0bxW1tX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWnHBlwCniovX3So3Th/B9lywqIVMVz0yfglzO+lmz4=;
 b=O/PB880x+K5KV0WvgGXG6cj152/HbrsLscbd655QnAICYLomrq/igqbUq//sxISoX/X+4jAQPQkrPgOh3CC24IAL++0+JbbWQxhLBwc/GFs+hl0uU1f9hhdeZjbPS/zGFRlbZ91rLRYsyIm50ydOuyErjexYiIuywikVHcgVfklX9RQ+XX+wj3LNxU6twVtusszFI0DND2Gg4/rB9uFe8+5YKKuZyKr5Jjbik+C6Bw+rsjs0eeFOdnckh/iz6Z6F4gTVOYCVLb+IaPDSnYe/qlwzb9yiF5VZk1Pj8UmewQwq+x65un21x9eEp1JrwnNuhd3yj9cw6Alge50B5afy2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWnHBlwCniovX3So3Th/B9lywqIVMVz0yfglzO+lmz4=;
 b=Bejeh+x+aEyWKfL9hE/gOU+IEAgPnIG6b/4YGlSZASBn+J0UFW1/brHBQUO69QHZKqgNFUBSqqJLMvDg4ZTZroRuctK59DyB2mUtEm1moLwJWdoSDFct7onOOMBVAuUAMdvUY+7tiB/smRmJksrNh6GPTGg34VMmMsxBSkAH1OI=
Received: from MN2PR01CA0008.prod.exchangelabs.com (2603:10b6:208:10c::21) by
 PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 15:24:22 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::34) by MN2PR01CA0008.outlook.office365.com
 (2603:10b6:208:10c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 15:24:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.2 via Frontend Transport; Tue, 25 Mar 2025 15:24:22 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Mar 2025 10:24:20 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix Manual Execution of Cleaner Shader in Gang
 Submissions
Date: Tue, 25 Mar 2025 20:54:07 +0530
Message-ID: <20250325152407.2543116-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 126525d8-0b25-49ee-1e16-08dd6bb11e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFJ4cGVmS2RyQnZablR6eFozVVEwaUVQWDMzdW5wSm9pU2Z5RnpVNmhLRTFq?=
 =?utf-8?B?UU5GVXZKVlBOaFFpN1hIL3VyMFZOZEl5WlJGU3gwSEtNeXpyOXVaS2ZDb2ZT?=
 =?utf-8?B?eStTenJjVkdRYmlVZ3R0MFVPc25tUU4zY3IvTzRNV1M5ZVJiM1JsamVXS3Mw?=
 =?utf-8?B?cjZDOEdhYSt5L2RjdXRtVTB2QWRHajh1TkZsNEk2dnJlSGtPb3VFaC9BQmpD?=
 =?utf-8?B?d3A4ZURETVJIRTk0N01sN3RSY0dlWnRlUU04WGVneE5jb2lPbGVXL0RSWEJ4?=
 =?utf-8?B?UmJzdmdEV0FKNysxQ3QxN09YUEF2U2pVa2cxcy9ncXZMYitjcFVRbVczMXl5?=
 =?utf-8?B?dkV4TzRmYi9Cd1RmcmNWTythMlFLaUtLNE5DQUVqbW84V01VZ3BWL2ZnUGJW?=
 =?utf-8?B?eS9kUXI2eHRhRTJCb1JWSkxpanV5SnFPdnJ2NVdIald4dUhnYU5GdEVOQnox?=
 =?utf-8?B?TjU4UWpGRWQzN094ZzdQdEt3SmNJYTAvM0FqMHkyYndEZ2xNTW9KOUhDNTJX?=
 =?utf-8?B?K1ZyenU0aWlpaDF5eW5HUmVpZWF3MUVIQmVBbFF5VXFScWFRRzl5TTBxV1lW?=
 =?utf-8?B?U1hqbk13MXFZMDA3cnJ0RjNLbUxEQmZRUDlYUGhXeHUvdys3ejE3UG5WRTN5?=
 =?utf-8?B?NW5DMzV5R1ZaS2diM3R3WlZwb2dqeFFrRVVOOGsyUlZqeDdYb0lGVUxTdE52?=
 =?utf-8?B?MHNUNDB2MW1XZERTaTVXUS9YTE5BVWU1ek56UDZ0Mmx5eUZ2cVhVOUxpUTFM?=
 =?utf-8?B?TzZFSEl0QVVzVm1iV3RaVWxHMFZkRk1SelF2RFRMbVFsVlFlb2xBQ3gzQU9R?=
 =?utf-8?B?TlBDK3A0Z2phdURLSjA4L0MrbHJBOW1rcmpZV3JYLy9GbkdOZkNNM0NwWTJ0?=
 =?utf-8?B?NkNxdEpQdzduclZtUjQveXlkVVBGYVYxYkJZWGVqRjMweFVlZ25EQ09OSDNr?=
 =?utf-8?B?bC8rdDFnZUlTMUZNQ2VTOGFCMFJjQ3BuNnZjUGdGV3UxT0xKN2xOSUt5MFpD?=
 =?utf-8?B?YjFGUGhuZUthZk1lWktudVNUVlFEdWJodFhpeGhlckZybExQeVN3T3lIb3Ny?=
 =?utf-8?B?ekJMNFJ3L0xGVnB1ZTFzSW1iQ2JoR1N3TTNzYkduVDlNWXptN3k0eUtNaHY1?=
 =?utf-8?B?SDBWcUZIU1djNTdQTU0vR0U3bElySjRpZjhrMzR2RkZKb1BIczdhcDZHakNS?=
 =?utf-8?B?VmZPSWFQdHFMYVluYmtFZWNVakdLeVNXd0RMazJMMXc3WkNZVlpxb1A5Z1FM?=
 =?utf-8?B?ZmIwSm9vSkRrSnI4NkQ4Q2UxS3NJay96UWVSVEQ0bDFRZ3ZzSmVHWGlNOHI3?=
 =?utf-8?B?MWZCeEZqWFdQTUpnVFNvYTRKdzB5TlJLVXFwRUtWMytpRi9CK1pZdWpiVmti?=
 =?utf-8?B?VHVkZFZhMGNxbGJPQkxZaWNFandpVnp5ejhnanh5R1lxWDM2L1JvdThHdjJa?=
 =?utf-8?B?Y0k1SGx1aVpYT21aR0E0dFZNZUFtTENDWXpRUjRUcWVQSC9qWVNrVlFLdWtK?=
 =?utf-8?B?TkQ0bFpqRTRtTnN3QXM3RUgyTDJBR2F3TXhrR1Znam9tSFBtOHg1ZjU5bjg5?=
 =?utf-8?B?dzZRbHdwOE91MEdPRTJNR0RHSUNNbnoyLzBsNmhWTENPSTNlRkMrL1FSTllW?=
 =?utf-8?B?NzcxMFg3RS9KcjdxcGRKV29tRTRFbENrcG1FL0ZUOHJVUjdYQlpyQkxsbk9p?=
 =?utf-8?B?bklkWTZmY1duNmhWTUU5UjRhYStXczRzTWRpRWxwSllmT2VXTjVjR2dLZDVV?=
 =?utf-8?B?RGFDaDcxN09uRGdDTWhLNVo2QmNkMTVxUTRXbElFaE43aFN1RVFEK051SGI1?=
 =?utf-8?B?NWFNbGdXVHB3b01ESVNUb0VjdS84eDV0akhtaCtCWVNNUVhIN05sMWpRR1d6?=
 =?utf-8?B?N0NEQWVHUmNWTmxnK3lXOEpMbXVXMkM4S3NaY0F1d3dKbE15RE84eE9rZmRP?=
 =?utf-8?B?K0ZQdFlwd3B2TFQydmxNMGF4RVBGSWtuTG14eGRESEwxU1R3WU5xUUpaMWVB?=
 =?utf-8?Q?YP3VhrWgh+m9lNMA/ob8F+rXcaw+rs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 15:24:22.1404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 126525d8-0b25-49ee-1e16-08dd6bb11e84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884
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

This commit addresses the issue where the cleaner shader was not
correctly executed during gang submissions due to improper handling of
the isolation spearhead.

- Enhanced the `amdgpu_gfx_run_cleaner_shader_job` function to
  initialize `isolation->spearhead` with the job's scheduled fence for
  cleaner shader calls.
- Updated the `amdgpu_vm_flush` function to properly initialize
  `isolation->spearhead` to the job's scheduled fence when the cleaner
  shader is required.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 72af5e5a894a..807f17093006 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1436,6 +1436,7 @@ static ssize_t amdgpu_gfx_get_available_compute_partition(struct device *dev,
 static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_isolation *isolation = &adev->isolation[ring->xcp_id];
 	struct drm_gpu_scheduler *sched = &ring->sched;
 	struct drm_sched_entity entity;
 	struct dma_fence *f;
@@ -1464,6 +1465,9 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 		ib->ptr[i] = ring->funcs->nop;
 	ib->length_dw = ring->funcs->align_mask + 1;
 
+	if (job->base.s_fence)
+		isolation->spearhead = dma_fence_get(&job->base.s_fence->scheduled);
+
 	f = amdgpu_job_submit(job);
 
 	r = dma_fence_wait(f, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b5ddfcbbc9fc..e23400b53489 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -692,8 +692,10 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (need_pipe_sync)
 		amdgpu_ring_emit_pipeline_sync(ring);
 
-	if (cleaner_shader_needed)
+	if (cleaner_shader_needed) {
+		isolation->spearhead = dma_fence_get(&job->base.s_fence->scheduled);
 		ring->funcs->emit_cleaner_shader(ring);
+	}
 
 	if (vm_flush_needed) {
 		trace_amdgpu_vm_flush(ring, job->vmid, job->vm_pd_addr);
-- 
2.34.1

