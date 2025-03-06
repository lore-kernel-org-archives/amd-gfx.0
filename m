Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E3BC28B26
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 18:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E303E10EA79;
	Thu,  6 Mar 2025 18:46:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uLHg+sZ0";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BDC210EA71
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 18:46:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qT953LwYf0Mk0eAyb/0yuaBNR7X5BLftQ2SOAo+nweGWsXJ9OOKp6+uxk0I+KA0P8xHbxCCwz0EhMc9naVb7tc5b7XDayxFllWafJkkSWGgiC/ejcDUDef5Iq7/U5BSVkqt7YpLCutbi4KefXfZ4akkzmqJQlCiiNzTkjM8QVW5ER4WRzfdTrlZCbQojr+bMfd3Y736CuZ6pqLHimXsjD3GFg7I1QyzYHYu6g+KqYqdeHyeEMIGkUP1Vpx1bUJSyN1l8zmjXdQRlYZ88NuQ2FBuTdYuZ5UERPrYajhduvDacb8To5DEEAh5huN9+a710zGj9ALQRZOuktl7clnUKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pEAdS17UvgPcn7uZrUuTdz4d6nVdIPH8G44H5SHGhQ=;
 b=Ur8SBOMTazqBRVyRMQ++7d5hI/GVbCXmURlvUIgTGCXKmeaENm5ssqiDmCg6Q+Fe2XTc1G0ijdt8nPQ16G8N/BfKR1GaiC1HN4ITpL9ngBVCI1HhDzJDUUrMxOcSjOw3mQD527LT5qnExhCQiSFbFsKLu4VKAi0uokrK67znN+1TSxsq2GXz9GnqTVO3nfRD+hUvYLNl0x0eEAyy621apvCguhJSZ1pd2tOW9haKApaFK22m9IevKERMWdtZzVkvhFh8Hpa3aXxqnUfdIU/IhA6OuLzQMNuo9c9BO81DdEzMmGKxdPsFJ+bmp0OMhDgYMtTe4K1UKXzjD4Mzsq8SJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pEAdS17UvgPcn7uZrUuTdz4d6nVdIPH8G44H5SHGhQ=;
 b=uLHg+sZ0WnUKZceL6mi1gtirkQx+yaoQZhHyzcHhyD/IzSburMgJA06J9N+EGD7ywgeOLDtBgAGLY6YwxoVn+l3bOt5BimtEZ3IF08yvTq5tTCmrJ0TTpmRhn+0zRSPfpIOH+aHDIvkAilNwIXf3E6N/UTKIDFAyrm3hTSDzy/g=
Received: from MN2PR01CA0066.prod.exchangelabs.com (2603:10b6:208:23f::35) by
 SA3PR12MB8022.namprd12.prod.outlook.com (2603:10b6:806:307::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.18; Thu, 6 Mar 2025 18:46:29 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::27) by MN2PR01CA0066.outlook.office365.com
 (2603:10b6:208:23f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Thu,
 6 Mar 2025 18:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 18:46:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 12:46:25 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
Date: Thu, 6 Mar 2025 13:46:02 -0500
Message-ID: <20250306184612.8910-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306184612.8910-1-alexander.deucher@amd.com>
References: <20250306184612.8910-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SA3PR12MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: dab97e97-ac1b-4290-0e95-08dd5cdf338c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?liIaHI5KcUGcrtcXYzzJIf29tioB0/TV2iTD3q7LlxDETb3EQBDkYwZ+T/16?=
 =?us-ascii?Q?/8iqIoxlfs7w2/Pjbdy6ntxd+hsP0HOEMZmlKQmvxwnIAqRFNHBEveuAQi0q?=
 =?us-ascii?Q?oiTahbYCeBuv0srYVlXtN/lxEV8tuQ8iAQ6lUBozu/Xc9BBtmjuoiXUCFrlI?=
 =?us-ascii?Q?tqaC2u3UpQwN1Juu6y9dC/YXL+uXQb+syJ3XvVSpPoQVYpNBq+7IhkAozUE1?=
 =?us-ascii?Q?5Uu8zfRF6iSsiwITCfb2mc65aV/UHo//tnkcbcMfSIaOwSr/8U1imymKpjWF?=
 =?us-ascii?Q?b01pTM6W0zI72h3TnOpbKrrFb+nXpzKRsGs2y1rwUUjTbjyKy2Yp/d3cxAAQ?=
 =?us-ascii?Q?7aklk0v2Y5IOSiZMOBb82wPJD+wr+PWoeZGMDZKfvi4PA3qO6BOsaTLygocx?=
 =?us-ascii?Q?KtM1LIQwuQpzQ1tB55bNnOZ5HDW/n9CJZbmnjTBsnve3rcxX2YHKbVudIuHo?=
 =?us-ascii?Q?K1MYjTOYSQ4Sc4MVBP9n/lifQK7ERkm5p4FxNMNrcPTSQCGoEabhmAq1VglP?=
 =?us-ascii?Q?ZjREuDusQ6tXYNPAPBOctI4HyC4tQu29ChqNebhgZO2Oyd1QMSxSuFX+hsHK?=
 =?us-ascii?Q?dm/Ghg4bfuIGeT9HnJzKRS4zXFAqODVxq0BSS9NJEIOgqatHqqixiYpHoJha?=
 =?us-ascii?Q?ZD70tEzZ9lv7Mem5LjwMhQyGt1uifhW8XGBFCP58J10lQv2uf4WwYqT4grtt?=
 =?us-ascii?Q?CbNbfmdh4ahxFa70bVeYL3J35kVTPrK9k/PK3mzhgiHLAFRFpGxi9CEzWhkh?=
 =?us-ascii?Q?4W+V6DLoK9Gb+scW7vNm4SknfC2Nm91v53BVHFS6QYUgE0Qi3K6mS2D5boFN?=
 =?us-ascii?Q?2YxQU3eeKRqcRGNFBH4d7hKPjDtFY1038ZQkFgGnkMHLFB25Ebo7r24F1Xtb?=
 =?us-ascii?Q?APcH5LbBNbb0qsFw/sdidVpobWbpEw2wI09w5rw2Ur0phS39X1Dala2QV6iQ?=
 =?us-ascii?Q?QXLaGNmUMKFiT53cXL7TSfzitftUpvoyvPdOAxVzKvZL2Pk7m4Jz1CW0ZY4q?=
 =?us-ascii?Q?rtEd5/fv0GqtsTTiwfldXcjP6c/O7k0Td9r/IUNv14jXba1lnKIjyxXfAD0n?=
 =?us-ascii?Q?1dM6YNNUeyvpxOzcac3RR/bBh2BqzX+BurceHpSgOzZUmI5toy1LmEsxXKdo?=
 =?us-ascii?Q?Vc9xkC6Ip3STY1fNwf+Urgjb8Yt0gTW3ed1z3XQuoJ0cHiItMPSlAAbs/zsd?=
 =?us-ascii?Q?IfCayoRB/8DQY/i+9FHn6vgm+Drm/j+yji+/xilXw4VgviZFI+BwG1/aW7tb?=
 =?us-ascii?Q?Xaa/ImqgK8dwE9lg0A0ddP3ktGZYsKAH5+uaAUR+9JK4lmxswOTwnIVbsREu?=
 =?us-ascii?Q?oUVnKkOEZDkQuVjxKSXn2TW9cnYAF8SkNlOFwLQThQKezzMuGJV1BCgxu79/?=
 =?us-ascii?Q?jRMXV2m8Nxea38OHlkwGztbMcmgzUSIgGAZeSGSgg7pvHJCs+xD3lCpL10nG?=
 =?us-ascii?Q?WZU0xRf3kdQwIii4fMFIW6uwQBEb2Ef/4g3x0E3qirt+6iJW1TjQRLGzEzKf?=
 =?us-ascii?Q?WjRh895thFWwfcU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:46:26.8132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dab97e97-ac1b-4290-0e95-08dd5cdf338c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8022
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

This would be set by IPs which only accept submissions
from the kernel, not userspace, such as when kernel
queues are disabled. Don't expose the rings to userspace
and reject any submissions in the CS IOCTL.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 30 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +-
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 5df21529b3b13..5cc18034b75df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -349,6 +349,10 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 	ring = amdgpu_job_ring(job);
 	ib = &job->ibs[job->num_ibs++];
 
+	/* submissions to kernel queus are disabled */
+	if (ring->no_user_submission)
+		return -EINVAL;
+
 	/* MM engine doesn't support user fences */
 	if (p->uf_bo && ring->funcs->no_user_fence)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index cd6eb7a3bc58a..3b7dfd56ccd0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -408,7 +408,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	case AMDGPU_HW_IP_GFX:
 		type = AMD_IP_BLOCK_TYPE_GFX;
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
-			if (adev->gfx.gfx_ring[i].sched.ready)
+			if (adev->gfx.gfx_ring[i].sched.ready &&
+			    !adev->gfx.gfx_ring[i].no_user_submission)
 				++num_rings;
 		ib_start_alignment = 32;
 		ib_size_alignment = 32;
@@ -416,7 +417,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	case AMDGPU_HW_IP_COMPUTE:
 		type = AMD_IP_BLOCK_TYPE_GFX;
 		for (i = 0; i < adev->gfx.num_compute_rings; i++)
-			if (adev->gfx.compute_ring[i].sched.ready)
+			if (adev->gfx.compute_ring[i].sched.ready &&
+			    !adev->gfx.compute_ring[i].no_user_submission)
 				++num_rings;
 		ib_start_alignment = 32;
 		ib_size_alignment = 32;
@@ -424,7 +426,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	case AMDGPU_HW_IP_DMA:
 		type = AMD_IP_BLOCK_TYPE_SDMA;
 		for (i = 0; i < adev->sdma.num_instances; i++)
-			if (adev->sdma.instance[i].ring.sched.ready)
+			if (adev->sdma.instance[i].ring.sched.ready &&
+			    !adev->gfx.gfx_ring[i].no_user_submission)
 				++num_rings;
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
@@ -435,7 +438,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->uvd.harvest_config & (1 << i))
 				continue;
 
-			if (adev->uvd.inst[i].ring.sched.ready)
+			if (adev->uvd.inst[i].ring.sched.ready &&
+			    !adev->uvd.inst[i].ring.no_user_submission)
 				++num_rings;
 		}
 		ib_start_alignment = 256;
@@ -444,7 +448,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	case AMDGPU_HW_IP_VCE:
 		type = AMD_IP_BLOCK_TYPE_VCE;
 		for (i = 0; i < adev->vce.num_rings; i++)
-			if (adev->vce.ring[i].sched.ready)
+			if (adev->vce.ring[i].sched.ready &&
+			    !adev->vce.ring[i].no_user_submission)
 				++num_rings;
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
@@ -456,7 +461,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 				continue;
 
 			for (j = 0; j < adev->uvd.num_enc_rings; j++)
-				if (adev->uvd.inst[i].ring_enc[j].sched.ready)
+				if (adev->uvd.inst[i].ring_enc[j].sched.ready &&
+				    !adev->uvd.inst[i].ring_enc[j].no_user_submission)
 					++num_rings;
 		}
 		ib_start_alignment = 256;
@@ -468,7 +474,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
 
-			if (adev->vcn.inst[i].ring_dec.sched.ready)
+			if (adev->vcn.inst[i].ring_dec.sched.ready &&
+			    !adev->vcn.inst[i].ring_dec.no_user_submission)
 				++num_rings;
 		}
 		ib_start_alignment = 256;
@@ -481,7 +488,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 				continue;
 
 			for (j = 0; j < adev->vcn.inst[i].num_enc_rings; j++)
-				if (adev->vcn.inst[i].ring_enc[j].sched.ready)
+				if (adev->vcn.inst[i].ring_enc[j].sched.ready &&
+				    !adev->vcn.inst[i].ring_enc[j].no_user_submission)
 					++num_rings;
 		}
 		ib_start_alignment = 256;
@@ -496,7 +504,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 				continue;
 
 			for (j = 0; j < adev->jpeg.num_jpeg_rings; j++)
-				if (adev->jpeg.inst[i].ring_dec[j].sched.ready)
+				if (adev->jpeg.inst[i].ring_dec[j].sched.ready &&
+				    !adev->jpeg.inst[i].ring_dec[j].no_user_submission)
 					++num_rings;
 		}
 		ib_start_alignment = 256;
@@ -504,7 +513,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		break;
 	case AMDGPU_HW_IP_VPE:
 		type = AMD_IP_BLOCK_TYPE_VPE;
-		if (adev->vpe.ring.sched.ready)
+		if (adev->vpe.ring.sched.ready &&
+		    !adev->vpe.ring.no_user_submission)
 			++num_rings;
 		ib_start_alignment = 256;
 		ib_size_alignment = 4;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index b4fd1e17205e9..4a97afcb38b78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -297,6 +297,7 @@ struct amdgpu_ring {
 	struct dma_fence	*vmid_wait;
 	bool			has_compute_vm_bug;
 	bool			no_scheduler;
+	bool			no_user_submission;
 	int			hw_prio;
 	unsigned 		num_hw_submission;
 	atomic_t		*sched_score;
@@ -310,7 +311,6 @@ struct amdgpu_ring {
 	unsigned int    entry_index;
 	/* store the cached rptr to restore after reset */
 	uint64_t cached_rptr;
-
 };
 
 #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
-- 
2.48.1

