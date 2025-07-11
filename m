Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BA9C83F25
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1C8010EAE1;
	Fri, 11 Jul 2025 22:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LcziqhnO";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6909B10EAE3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6vbbjlYCuulLFQB68LWQMY1rGZ5kCGgVIUcb1aJQuMDKHLcyK3uEaJAge2+//eaX/1hsFI3WPwMmQDTmVNGcOtihvbHUpy3NnwmH3x5VO3VIZ47yrG7DDiwK1J50oFp4nS5FwoEw9kTLLPSmEeEH/cILN88OkCMkcQQv2BeUN6SHpkKwW5amgL70VUkKG5AI6y38/Id3/ErScMFhhPUSwmNwr30ZJj6g66cb4IqFSpiXZKTWtPqZBGRo/mnaqotCdpRq6M7BplAgT/Mjh8oc5m8p1UoUKNIpJ0VTv+Efjtvut3FSMuWhHYssqpfQlN5EO6kGl1hLTmj/XgT/Fyn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQtUqlg43eX8D8vgzzHjiuMrJmI6rxQH5jFwBTLNKc0=;
 b=UbBszGY4iefNkBHThux54gzNBCuG1Ax2MK08SpMnd6yNUTO7qbIiRnZPuDTFnLyc5L2Ln3YNRVtDN8agheTs2vl0wnvOj4zLA9gjLujVROaXAOTKyO+t1psGsTPP0aRXc79m5908pFCakWQ4GMO3smHPLWrk15Q7fOA1E/PtW/f/XfnMKR3R+cYiN07+RIcqHf9/TRyEqL4oOqVley7/smI5tktwIF/X7zpck8D3G4fPaiGtv9U62MOyUw+sRtFqYVmeYNrD6FpfnmEVPBKS1oW1NRIBHU3Xz/O1UipRW7cJFd/4kUB76ScKJb4eMIP3DT5bf58jE0U+SB+IaFV6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQtUqlg43eX8D8vgzzHjiuMrJmI6rxQH5jFwBTLNKc0=;
 b=LcziqhnO1g4+WSBkNsBBnJHFL7FyGffrLUpia5uKOJP77TjCjwNuVRpjLZo8W8D7iVwzSS7AWZ86q4tFcHUuEvq5QXehiVdFW6d/QuCMhWndiQjd2x5Jbobz1vh7ehgSLkVRiNBh4be7gPo+S2HjsuJC7Ox2astGDyAF58vPe8s=
Received: from SJ0PR03CA0212.namprd03.prod.outlook.com (2603:10b6:a03:39f::7)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 22:40:44 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::c7) by SJ0PR03CA0212.outlook.office365.com
 (2603:10b6:a03:39f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.27 via Frontend Transport; Fri,
 11 Jul 2025 22:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/33] drm/amdgpu: clean up GC reset functions
Date: Fri, 11 Jul 2025 18:39:58 -0400
Message-ID: <20250711224024.410506-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: e25dd9e1-ca36-4a6b-d424-08ddc0cbf8b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jQNtan7P2bPG9Phh4E8OkFbGi7b/7eb+Sr0oRFUbd9pMm9LqgF6bQ51MoBGG?=
 =?us-ascii?Q?VjIlmmTL9QnzGQ6IprVrddf28kWH/k6lwWJo4Ur27sYAmN2fjVP123RkrwEr?=
 =?us-ascii?Q?wvOfuKnkpRysz/DntR+iOpJTZU7WbjhFTmG+MOO8V1BNi7HumUTaeY7C+LWT?=
 =?us-ascii?Q?fmHuWZho36+mPVr2tQGaWJg3EdBqpZbjej9ff9ISolNdrn9Py68luYj1YYrU?=
 =?us-ascii?Q?BK/SrWgZGPEUt5mLzdUktfU8VZYi/KymSciTt5EmFUQTnfKFCWJzdDzSbD/P?=
 =?us-ascii?Q?DiPcB7geBLY9KvzmSbwidWdNcFchgCmrnIr3hEr7Zz/DESbHzvL6t3qW+wWq?=
 =?us-ascii?Q?2cXBaEdVsjxWeqcxaTO41FqY/IKGSsx96SL4i/Ofu9gKFlsxZUcINQ4gNCnF?=
 =?us-ascii?Q?W45YvEcT3PeOCkEq+vWCAqcKN76gb9w8vD8kduSHJGDR6uXW0kFzYti9UrzX?=
 =?us-ascii?Q?lCA0wyMAkCPIpRopUXL88MsqFmOSYKd4njF/kw4JG3SaBhaOXGIQGYta28yF?=
 =?us-ascii?Q?JWuwPKxUmNq6PLmYxJFmIUru7X+YBeEMPOu4V1QF+BuWMwjKuiicBpOrUcxs?=
 =?us-ascii?Q?sKWmARQ92OtCsZIEJ+mXnebhkjV2VtPNeH0ZPVogTmPiwN1yNjttGII74Rdf?=
 =?us-ascii?Q?5n5bdfjnyDeJ9bE7do/ph3XXSxpR9ZUvsVEb4CX20XiICwZ1bQskRLkcBBKz?=
 =?us-ascii?Q?ybs5Fzr0qpIBwyUCjF4CNNfA7361qcaPuqC6HVXR5b67gII7/KlDv9Anwbm+?=
 =?us-ascii?Q?cFYA7/SlXK32S9ruKXGOTgSjhNrbStj9pSN3WfBuojDllZohdw84KhN55hOM?=
 =?us-ascii?Q?pO6DjOyCq+PiagCuaRvQRDNdpwDFl/aiMzj8kdvuKf6iXiJIZqrKhZC4Ktj2?=
 =?us-ascii?Q?fRncPyAZACNnZje4/8/5i3RbsxrqveGTSrhspK2L2d8tFvCVUtYG1kkn70Gc?=
 =?us-ascii?Q?GBbs7AQktC/S9G6zxQJPCdl1FNydhRHngm4QBXH7eWtfSQ3mEl9UNSQ06bvM?=
 =?us-ascii?Q?30xVRGqeCPF4FSwwaSxXW6mQECTCcbQLOnkTdG+TJpoKxU2z9PwNhn0FxOBL?=
 =?us-ascii?Q?Flei4CipORX00NLiVI1ol5p8Fn3vh2pUrZj8zFWVA6GA3oXRBrakN8oenm9r?=
 =?us-ascii?Q?B7jjeuxB/vr6dzyaM644+HBMbAXhgOltaMsrCjHCEud3TQFETdM7BGbYWnXi?=
 =?us-ascii?Q?u5UzbzaavEmqDgkbWWjMg4XGaYgKzBQZLxj5gfo7tjgjIuDK3eLj+y3clnFH?=
 =?us-ascii?Q?HAHoxunJRyvBIDk7DutfcHY5sKXV349WMLazEDxgZQmUtcO0MSUyZ0r/Wy4Q?=
 =?us-ascii?Q?HWxFV7/xu8xY/6kBQeCwBV+iR9uK4mTYnOgj0zss5az7Fj6QDOhlt+ca0Y2A?=
 =?us-ascii?Q?QBIlINCh/F2jidYilSDwQfi+WZYSOyUcHGWPn6NgsWTLnkKn0gIUcQ9J6RtU?=
 =?us-ascii?Q?vR0KdcK0tK7/aEpF0O5p2eJpFX6sFUEfvrQdF4gO2vMEhqSgkkDfhRr1FDg9?=
 =?us-ascii?Q?eswesy7wqSARSzsHiAAHMswFzkY8GQ/Ws832?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:43.9421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e25dd9e1-ca36-4a6b-d424-08ddc0cbf8b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168
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

Make them consistent and use the reset flags.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 14 +++++++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 19 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 18 +++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 14 +++++++++-----
 5 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d739bfb20383e..506454ed27bde 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4952,11 +4952,15 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 			}
 		}
 	}
-	/* TODO: Add queue reset mask when FW fully supports it */
+
 	adev->gfx.gfx_supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
 	adev->gfx.compute_supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
+	if (!amdgpu_sriov_vf(adev)) {
+		adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+	}
 
 	r = amdgpu_gfx_kiq_init(adev, GFX10_MEC_HPD_SIZE, 0);
 	if (r) {
@@ -9534,8 +9538,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	u64 addr;
 	int r;
 
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
+	if (!(adev->gfx.gfx_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
@@ -9607,8 +9611,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	unsigned long flags;
 	int i, r;
 
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
+	if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 37dcec2d07841..372dceceff359 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1806,12 +1806,17 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
 		if ((adev->gfx.me_fw_version >= 2280) &&
-			    (adev->gfx.mec_fw_version >= 2410)) {
-				adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
-				adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		    (adev->gfx.mec_fw_version >= 2410) &&
+		    !amdgpu_sriov_vf(adev)) {
+			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		}
 		break;
 	default:
+		if (!amdgpu_sriov_vf(adev)) {
+			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		}
 		break;
 	}
 
@@ -6818,8 +6823,8 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
+	if (!(adev->gfx.gfx_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
 
 	drm_sched_wqueue_stop(&ring->sched);
 
@@ -6989,8 +6994,8 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	int r = 0;
 
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
+	if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
 
 	drm_sched_wqueue_stop(&ring->sched);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index e4fc42470cf3e..7220ed2fa2a33 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1542,10 +1542,14 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
 		if ((adev->gfx.me_fw_version >= 2660) &&
-			    (adev->gfx.mec_fw_version >= 2920)) {
-				adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
-				adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		    (adev->gfx.mec_fw_version >= 2920) &&
+		    !amdgpu_sriov_vf(adev)) {
+			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		}
+		break;
+	default:
+		break;
 	}
 
 	if (!adev->enable_mes_kiq) {
@@ -5314,8 +5318,8 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
+	if (!(adev->gfx.gfx_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
 
 	drm_sched_wqueue_stop(&ring->sched);
 
@@ -5437,8 +5441,8 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
+	if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
 
 	drm_sched_wqueue_stop(&ring->sched);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 4c61157405b07..ac058697054f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2410,6 +2410,8 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
 	adev->gfx.compute_supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
+	if (!amdgpu_sriov_vf(adev))
+		adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	r = amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE, 0);
 	if (r) {
@@ -7181,8 +7183,8 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	unsigned long flags;
 	int i, r;
 
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
+	if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 5f92975cc3058..e2ff4b373a319 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1148,13 +1148,15 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
-		if (adev->gfx.mec_fw_version >= 155) {
+		if ((adev->gfx.mec_fw_version >= 155) &&
+		    !amdgpu_sriov_vf(adev)) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
 		}
 		break;
 	case IP_VERSION(9, 5, 0):
-		if (adev->gfx.mec_fw_version >= 21) {
+		if ((adev->gfx.mec_fw_version >= 21) &&
+		    !amdgpu_sriov_vf(adev)){
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
 		}
@@ -3561,8 +3563,8 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	unsigned long flags;
 	int r;
 
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
+	if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
@@ -3594,7 +3596,9 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 		dev_err(adev->dev, "fail to wait on hqd deactive and will try pipe reset\n");
 
 pipe_reset:
-	if(r) {
+	if (r) {
+		if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_PIPE))
+			return -EOPNOTSUPP;
 		r = gfx_v9_4_3_reset_hw_pipe(ring);
 		dev_info(adev->dev, "ring: %s pipe reset :%s\n", ring->name,
 				r ? "failed" : "successfully");
-- 
2.50.0

