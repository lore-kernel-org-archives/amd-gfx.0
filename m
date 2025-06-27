Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE9FC83010
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DF1610E94E;
	Fri, 27 Jun 2025 03:40:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TPwoKGqq";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4BD910E944
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqei8ePxe1ZcG74MuKRwoVhis8kI3zThLZv6O9u7rvUB3WegiQb/hPPEKRYwPXRRo5bSfAqhhk47Z/dfUhYhOc4JjE6IM94qxBUkaIVLwgkbHHzR94oagi2ML4YTzLj9epFi079O25uOmp+0OcCAtfOpplgPr27hwzWqSMUnsLzCunTVRawKX10lwtjnkodIR3Ru8uxuyNb6ISlEWK9zpYw+LU8dJYpw8fMSE+H5xREZxNc7mKvrI7Nzo+Wdlqk0DOiNYLMJwMA1vilKaSYNZ72VqbFlPdNGmZMcSsFw29lXXjBFY8mUrB+GBOYdsFF65dVNac2Cr8ylkKzRTvsQ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8eFJ/jVkRvKx6Ll7gObfAg3bVRNc/PMypaMrIvAxPI=;
 b=r/jzbMEiU2vo7jsuz87EVEJzFVTea9L84tBTn4Gvbqu6rWFDRePJJSAxAENMey1jbpTnqbL87soaoExHfPyc2D2MsV8CzFAkMscr18XfL2J10fGEZn6AwylYOs55jGqRjedyHWt+9CL0XbfKMahcEgWRYpYUYblL6zKbQrhCsq37Z90x5BV3RKwnxIP76tLszgHWK1DkCGbygAHyKw7dE0/ZUmmrbIsPrc2bJuoM6h6nPsK2xal/Kb6yCb6mn74AxfpOYZTmpUlB7qUpqpwe8UEGjZxKvEluM2js/vI+tk2xyRnqM/Z6pRucYn0Ngtk/KQfTAkPiEkgS8Bt9CvIFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8eFJ/jVkRvKx6Ll7gObfAg3bVRNc/PMypaMrIvAxPI=;
 b=TPwoKGqqeGDbf5TXiV91vLcSsZc2B39IOVgIXTKtTbwlLgcOaiRTeufka5JEzr7l0EW2G4ZspBhRrXRqoOsX0MediPfFfxWuyBnZds2b5f2HuF1pOnqJLOCg/yrvX/XNJfX8MsCz+J4wgHi1FZnBEMb6Vb5B2kicKSqF4iW2l68=
Received: from BL1PR13CA0189.namprd13.prod.outlook.com (2603:10b6:208:2be::14)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 27 Jun
 2025 03:40:36 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::a) by BL1PR13CA0189.outlook.office365.com
 (2603:10b6:208:2be::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.9 via Frontend Transport; Fri,
 27 Jun 2025 03:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 22/33] drm/amdgpu/jpeg4.0.3: re-emit unprocessed state on ring
 reset
Date: Thu, 26 Jun 2025 23:39:51 -0400
Message-ID: <20250627034002.5590-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|CY3PR12MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: 75901899-3fe9-4542-cc16-08ddb52c606d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WIOOI70sLRXu2J4r0Z7XlE2EJeZu/8HUN5aMSznLe7KSnMVnS0yBHWnQvcVC?=
 =?us-ascii?Q?QN6DBHXflyx397ifprc3JEsFWTV2l5L3a5htxLGWjeeSng/LpaWEJPoHDp/n?=
 =?us-ascii?Q?UJntlF3v+tpKUKV4mHPinv+7tKleATna5FNTj5ZFUVAxycyHlvrGJE7EPbXy?=
 =?us-ascii?Q?7Cdr3VyBqdvSb3ZVVs2XmXYO8btQ+ficeZ/ypTpu8zPDAhyK2jHZ9cKZPPz7?=
 =?us-ascii?Q?w42/0p2IaQdjWpVtBbW38QLtRKpkbvvMKx5sI7qEjfY9XEmI3+sZLuXyo/6r?=
 =?us-ascii?Q?jreCwaKVmO3IFTI76d3YVfrUBsK0ZGU2Odn1dcdgas6QVyM2X8phNmYYVi2m?=
 =?us-ascii?Q?z6bLMzJ/6cXP5At2FFnBA4hFX5FMlcGf47qHfe+f6P0v7d3PyVC6jsY9ldx1?=
 =?us-ascii?Q?2DtZGoh55xKVJiGRchcn3eiFfOMZkES8M/jZ9j2FvN+MJXb0A57LSP0qUbaM?=
 =?us-ascii?Q?/PIRr0zIqyDXK7UjQkGzSHClxvCSb7J76ZOAd7qeZjhn8wgpzqD0SEZvPK85?=
 =?us-ascii?Q?hOkYqMwj0HNGw+cHYIOkzwgzkmj3m2IiBGtJBjOMTcitG0sY4LhS4Bya2se8?=
 =?us-ascii?Q?clQDTw/jCTGj31/L9eob+yLy0XMUnYpaoOG//H0lnB/z0HSz0zZAL7BH2q2Y?=
 =?us-ascii?Q?PHIVZPIFElSesrQLSjuOd3FW6iivR0LxoHucrrJBI1wQ1/EkBvyc/H2M6Mt9?=
 =?us-ascii?Q?qETYRhAXTTHy41E+8cMVnDORd9x0E7aOc+SNO39Daa1e8lXKWxS7krNMN6Wq?=
 =?us-ascii?Q?hu0ruMVX2gp9BhFaytjX/BV9fhyI+SrHhiBceIwljlmPIfJT2WVPPKPgcGoh?=
 =?us-ascii?Q?t1V2kzLPZ9j9+o/+OSTU0Xtal+QgXztMfqX4DNJ11/lOm152VZBisc0SRL3z?=
 =?us-ascii?Q?AMKV3NEjovJI7jeKXz1ExqCWAuQYmN/17Rbwz32NZx/jRBPx/CXe7UM2UnBY?=
 =?us-ascii?Q?H8am6dz64+ECxLurnGy7hG92oPsqk02gkm7SxgldkXa8D29JNrqfZL22c6Qn?=
 =?us-ascii?Q?7g3XzNOqTnGFZCAKrpSzeZK18N4KddU3t7BYHHRG/3jUCQXTyUAkVp0+uR66?=
 =?us-ascii?Q?sJReaHWoardlN51mYqs1OOXGS9IoxXtQAxVlDimX2w9n0vMzUR47KEZ6midn?=
 =?us-ascii?Q?LBzLk5X8HM/Dnrymn1Eq/TmrscosvIfuH8aiCItTTZojHSQZDj3S8qwwl5Z/?=
 =?us-ascii?Q?x91RTFlKpgnTuLKfd9EbtL8hu0qq55txeuZpTm73YF3KtudDfLF+lxjiPn5/?=
 =?us-ascii?Q?1Seei4ldvFDf5ZF4TXRII8wWK83IfpBmGuC+NkWtMxtuTzoWRUt12vppFogw?=
 =?us-ascii?Q?k6RRC67inc3CCH27fsMs5xAgi9dLF0IuJbz0amFJoNzrhQuxyDvf4jVHSGTL?=
 =?us-ascii?Q?UV4aBD3pr8v9H+ZFzE9xo+qEcWjEHI95Mf/Gu62G4ynidqGq7gUL+CbxX01Y?=
 =?us-ascii?Q?y4usGj/CalojqkAhFHANXxy0GdqKbxmC0MIV4xqIX8lU4apXm7SSQufv+zFg?=
 =?us-ascii?Q?NsNEqNGoTuSCABig76q8xC7aRI+qGDQgEa3o?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:35.7039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75901899-3fe9-4542-cc16-08ddb52c606d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577
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

Re-emit the unprocessed state after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 78441f8fce972..c3f73a2a911b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1147,20 +1147,13 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v4_0_3_core_stall_reset(ring);
 	jpeg_v4_0_3_start_jrbc(ring);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
-- 
2.50.0

