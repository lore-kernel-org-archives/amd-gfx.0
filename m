Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A87C19F32
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 15:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BE7710EBC8;
	Fri,  7 Mar 2025 15:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LS0Gi6xm";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3072D10EBC8
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 15:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9QVfypTaZ1woPQ3x8LCLudm7MH5pQiWWb6cgsBT2A5OgQggjgn38AAFyF+ijb1ki7fSVbL/0Co4j1tVbk4l/yj5QVsd32LSyefJD4/5F/ZCJpYoKGZ+DxVNJ7CPc/3O4XpA7FMtqHsR7BOBOmzyEBwuvARC+Yb2tOeMIpNJfFK2zYT8fXvwYlCukVR3NTTTg2J7q63Ln4K2bE05vTNFr9908U+Qo76nK19nCcD3YH0PzICTtL/z3yXXFOu4O70qqzzXqh1kRup43E9tm3I1b1Roie+djtuz3TupM1dFZyX5qBDGLzRV5MZ6RO3JSM2roJpnvTBrEeTKcdsjTMPJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pEAdS17UvgPcn7uZrUuTdz4d6nVdIPH8G44H5SHGhQ=;
 b=CZovzYM7VETicqzPbJKgeGOxlImbpMVVRXqCDHbgkahcRahtZ35pn2bo2crTtg//HlxCANqa7tYzer42LthfpdZneuSbMDnZupyCYiBHxxiQIns134v2ObY1pVt6758sA2cdcEj6wOjono+dx9cHvLHMef5EcV7XWmJ5Unltc7xRBlD5475ucoIo/HgZOZw8WiSEHssm6Cf7i2SwW/quFETSLnUWjI5LAWHUnW1MQla2X9IMPQMSpAp+wR47DCIstn3ON/BBjh/Qu8Sn3UjHxDFS1EJ/9gN6tqtXMwEP7m3bCY05NVXYdrBpJSoT1dsZEl93yrqZTK7XPgupcTNXtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pEAdS17UvgPcn7uZrUuTdz4d6nVdIPH8G44H5SHGhQ=;
 b=LS0Gi6xmh/fmsfsP/NEJoCxtAYwf0qmXNHoRqeqAkMBUeLLmN7nBHJ5vW9GGwdb5W0Ks5HfSY95++LuX/fo56kX9OWcZK0PdfpAbmi/6ZSvCr6SZF+bss1SEEEYggPuaOTxvl+2L06Qngf4KeVZEtdpnGgq5s5F5+Nw4V5poDwE=
Received: from DS7PR07CA0021.namprd07.prod.outlook.com (2603:10b6:5:3af::23)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Fri, 7 Mar
 2025 15:16:20 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::fc) by DS7PR07CA0021.outlook.office365.com
 (2603:10b6:5:3af::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 15:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 15:16:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 09:16:18 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
Date: Fri, 7 Mar 2025 10:15:56 -0500
Message-ID: <20250307151605.946109-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307151605.946109-1-alexander.deucher@amd.com>
References: <20250307151605.946109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ecb949c-91a6-4b2d-288f-08dd5d8b03f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?haPOtoBJw7k+2OL/Hex0l6KVyi7LIU3DHqRzlHwerVLq3eOMZlTtR9NoNGrh?=
 =?us-ascii?Q?g8p/Z0P0VCmcSax5ISEOAY9w9n5sGESoyieQOF1sUzJSjJqWr8R/sqnsAU8K?=
 =?us-ascii?Q?nOR9m9TLduC9GZPgXeDk0BYNxR20Ncn+zi/xvKU6zzEghqsegDWT2ZsIu/Nn?=
 =?us-ascii?Q?0zMmxNF307jzCjFnkEaCbB+/XVmr7G92w8lZMo2Pskva69GzgY4lzV5/S3KE?=
 =?us-ascii?Q?v/vsVPqx6nN0IPZgPsT1exR7tkPl8F2RCj/BtYueLapBka0T0s5YJTpgEPw3?=
 =?us-ascii?Q?Mr/xBQARrn5uNcEakmWNXU7HxH/gUxcp3gTdywaEzHLbTQjrMq/qeoYtR1/5?=
 =?us-ascii?Q?tYiz/xIQDMfxkb/huORk5JPTCd2p0I4b9v9bnzQ4fN70T/BT8QVIlkM6jgll?=
 =?us-ascii?Q?vfponDUaTZYdj6yqYETfakW+XkYyfHpemFU0d0yz7hqUVaQPs06F02yxvE+Q?=
 =?us-ascii?Q?FilPnWy29QXMYjQtOwRhdZcJGpn/GAfk6KHykS2M468K6qshb4BB8Cy+Dr30?=
 =?us-ascii?Q?MJxlVdPo08sE7+XXMSsho0YsajsTkgDBp/YYJ5Y4gTvqZ2Bf0o0eB+czL3+D?=
 =?us-ascii?Q?wv7Z3asG/5d0WuiX82QyZnV94GBbdssqA0aCOIibcbKYfPK06qzr1jeOxCX/?=
 =?us-ascii?Q?lzpnSGAkEapnWARbFF4QzJRGeWOHSmKdchWkuPWJF4+fp0HFZ47QfCaIIiDk?=
 =?us-ascii?Q?XcYaW22XmEf9FWJt17GfwWuCknFeRR28DT5fjD/HZsOrgv3YKLyEz+496pdE?=
 =?us-ascii?Q?K1bFHiYhd19q/6br9/OYCVZjNCc/q3NLBvlty3XIk+nxr5ccbRXfvad5DEmz?=
 =?us-ascii?Q?337xkd5RV1JcOf9BbfRvVEqUoXw3xTDaCRXZ6SuGRo8us0NYVEWIfGSNZpA2?=
 =?us-ascii?Q?hMT34ZDIc9U8eFaMC+u8HTTshvvKYz0ZImK0P6CIYQ7Vf8wzfoLGqeIin7Qy?=
 =?us-ascii?Q?YTpN+VzX0tHOuicVKRBKRb0yCleT7I588NyEHwG5WVgSN5cx7b52fabRt+KM?=
 =?us-ascii?Q?76lq7lAzxwxGwogN8fvYojlq7g3GoK/trNrGTSJDXHvxDsG+viuAEFaKHqL8?=
 =?us-ascii?Q?c755F1EZZtsbDHjo1b0YtidYdFOAPSgXVKS/UW1rGRpN2sGPMsDIevGLdzmc?=
 =?us-ascii?Q?+HHFCJWm8cXmdDZ7BxwbVKqnbRty6Nyn+GPYtjyztZ/mbCWIrMaR/fnNRbfc?=
 =?us-ascii?Q?NuqHAx2QAOdzgHVEPSv3yfGsHoVj8qTh9K2OkGLCoa/18AS4JgqMw1nHA2qx?=
 =?us-ascii?Q?E6G3kmYOr6FPsHfe+sIlzCIjaXTstA8g1Hy1fsULtXnYa6LS4wP68gVHV3Wy?=
 =?us-ascii?Q?5Jm+jsMMHFCWIxABSZdVyHIWaPp7X+h3Ud62BYTgsEQ0XvHbIYLEbFiyGWDF?=
 =?us-ascii?Q?/Pc0+OkSp1/Q2MyC+/D4PedY6zJKb6X4oUICz0dSylNr8HeqGcKKOJs7zD0+?=
 =?us-ascii?Q?9bLp+vr+g988ulqqt+mU+c6RjJUG+rCQWX1FV8HHLPbk35msvWcgsGzqYQz1?=
 =?us-ascii?Q?sk3x3a1d5ujK35o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:16:20.3448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecb949c-91a6-4b2d-288f-08dd5d8b03f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270
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

