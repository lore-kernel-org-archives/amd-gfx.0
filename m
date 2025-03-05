Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D9CC282EC
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 20:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A07C10E331;
	Wed,  5 Mar 2025 20:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fr+layXS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E43A110E328
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 20:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1weObSiAwDAIfjEf3iwotDTw6NfVCanlDdxvkKsp3RYAhqeQUy3u/rnwqCIPej8fyHVvqJT/2z5k/aTS0c5sU5KJjO1tyY9QISX02H/LPNVqyhgXMaXZO8dV27GvtZZY2FsKZmAiSzuelgQFmvnuwN5qYXaB2ZzvSR6PBdKPhmAQcsB4F3E9IMn907m7zEK5QTqJzczUeXUF+b+e14RUiS9Tm3dBMRGJHAvhwi/L9/O31NNMMLk5MpFTku2/RprOSApOfTQ1cS3MFhBTvPlEtDyXdbVwVC9Ryfh4CumZhis46zHoVxvDGITzc33UOFTLjTlPhgN8J/EskU558NiLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UB5llGbaTAnDHGIHS+oM3mWaJiKt1DiAimkjf98VMfA=;
 b=y+ACpH40GfOjCn7PONhzMC1PtRStblijUxGTjHd9sQDrXbCajAvPCZaQMabIlTmvtTWEno/+9Fj273I+Oah9BZ2hXCA61YJ3ZAOSo211uVwwEKlRS44JDwKyH2GYD2Mn3VY6VgM6fSGGuhdi/v9ndiyfNboVzJF0rU8wUeXx86C8/hHAs8VHzr6kV9BYpyXrt9K2d1cAGMoVjIvbyjOMJGvOjKrFq9LcU0cdv6wdb+ShTDIw11oKUN1Xcth8VuXDgR7cw6eh5tciSx9TB8ULiFCB0NaqsHYcd9dlQH1EqK/NikXjBwn7BOV6+FYEnLlBYzTvHZ5alakN2p2XMjM34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UB5llGbaTAnDHGIHS+oM3mWaJiKt1DiAimkjf98VMfA=;
 b=fr+layXS+qaAIBJa17psk9rlzCGk+0qU2VipO0OX1/+frU1TacJc4BBFF4eCG8CpBmsIHCSjuWfa2Z5Zbje324BaeGpg1B1opKWQNoG9m2SXTKSZ/plSLRqu3zf2SIZR1NgLXvJotA099fLlCYLaVewoRp6Irk0PhHThg+KVYic=
Received: from DM6PR17CA0023.namprd17.prod.outlook.com (2603:10b6:5:1b3::36)
 by SA0PR12MB7477.namprd12.prod.outlook.com (2603:10b6:806:24b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 20:47:41 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::12) by DM6PR17CA0023.outlook.office365.com
 (2603:10b6:5:1b3::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.27 via Frontend Transport; Wed,
 5 Mar 2025 20:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 20:47:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 14:47:37 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/11] drm/amdgpu/gfx11: add support for disable_kq
Date: Wed, 5 Mar 2025 15:47:17 -0500
Message-ID: <20250305204721.1213836-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204721.1213836-1-alexander.deucher@amd.com>
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SA0PR12MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc4a5c7-8924-49a6-c9c5-08dd5c26f932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8vyMtpvBftCaBG6NsGwy2pFe7/sCawn3J3C12ske2H5xnkD5rEcjVJ9fDyHW?=
 =?us-ascii?Q?vZXl/gqQn0K9TvEAPRx8+ZltSHuFhuVkoQSvCbWp54HWqgcO8FhVFAi/VxMK?=
 =?us-ascii?Q?es9cvEfYgNzwO/JSucSxkOR9B+xkr+RPQB46+aQrhQBUiFEv8TOPBHuV7OK3?=
 =?us-ascii?Q?+XrCYbUURwpJV5pGkVyf5M1rot7fEb+z76JQoXwqaYSwnJZIhP7377DXircw?=
 =?us-ascii?Q?HB89j+4M+PotdV8a3xeti1nH4WKAonEzanupvJhWY98CDONxFIv7uryjw6fV?=
 =?us-ascii?Q?kQDdz03r+i9NQT3zfmEyeBThBB1bgC7Du7tXU3cKJfANnJxGmfJvkWVSdFuX?=
 =?us-ascii?Q?5dpA0Q3RhV5kDDoXpeZzt53X7HkuDnyCXTub8BsulB18UJSMUnvBN+Q3Q7kZ?=
 =?us-ascii?Q?xt/MPVMqnHNKlX/8AsoafJ7ARyRMc9fn4wppu7t9v5qQj1XLDh6NCI6LFzX1?=
 =?us-ascii?Q?HHojlqjjkv1GvR78alNczrAbGcPDqkCHsSIB7BE0kQmnQ3lpF0mxvAlQ+UVN?=
 =?us-ascii?Q?oYyNhUGC3PdBVwS6y91bBKTjjHno9BcPwB8Cwiwfz50ikJU1TZCpVVBYLCbD?=
 =?us-ascii?Q?h0DFGcDRojph4eCyhCOLBpulj8FlBwAfaE1t4UBt4+z6dh+rHlKogP5TWu/d?=
 =?us-ascii?Q?MoCDxY7WRALAr0LfBP0TTnIGSjewjbPjP52gnt8Al37bgI/8dP442BPC6jOY?=
 =?us-ascii?Q?lCd4ByTDu+d/ZMc+Df7mtaw7Y3JKT48CDfdubLT5gYxINUPQthF8cW9Xh6i0?=
 =?us-ascii?Q?PM3q2w0Z5WAFA8TgjGBfL4s4tvRfV/UuUUR6oz9wx8EnMfG8+ucaxZk67o8m?=
 =?us-ascii?Q?zJho++F81PapE9Cpefzd7K+P/2oKt2C+Lrg62iNqdIGJjSQ0FG2SOCWkQ45B?=
 =?us-ascii?Q?tTMr+xzsCNmPljwBc4/Q+64EnqWGJiH2b1Wxg+H3N+Kb555RuwZQCMl3K9NM?=
 =?us-ascii?Q?aPUwnXKubcQh6heKs380vuMRNNW4zxfpADDfESlKtbAJ1zyAPUv7c0Z9qFnW?=
 =?us-ascii?Q?y6zt0wYAQZweWdfoSBeNxRnyYHYZ+2IfjfqqpYyopFsSVRlFhbLFTYs6Jd44?=
 =?us-ascii?Q?x8AGU+NmNR78Oq33e2RqdVTp2ih5lPy/bA/+EEK4xaVzh7ZvP2OmbytxJbFz?=
 =?us-ascii?Q?UkJiDqKB78+edtEZEBIAycv13TaF09ibrczutXxMhDPcLlIEUWTpNOH987pJ?=
 =?us-ascii?Q?GYOgaz+ivPjQNNwyW3+16BmAYeMtpFHUcCnd1v5jovA0lH6VTH8yuRa4laRI?=
 =?us-ascii?Q?wjjnxM+uo9MEK68///4hPUrJRhHY8qfoQGTJquAO63SyExyRE9COe11scvVv?=
 =?us-ascii?Q?2MHLNi2W+ZRpQ/f6jd/JcsWuAyjwVmbXqBFoFjVSWuTSfY5CaEP0oWUOsF5x?=
 =?us-ascii?Q?IKxaORBxD9DLGGEBp2Qsb8GRCM8a4goFPZdYFQSsBgDpPGgeJdNSWricP2Gg?=
 =?us-ascii?Q?IL+Zf+mlqb0AMx05LAlpCajjyhzsz8SiOw0U1n4RcTpX8UR0OU5lUEwYBKBy?=
 =?us-ascii?Q?tUgPy/gLotIUfKE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:47:41.3971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc4a5c7-8924-49a6-c9c5-08dd5c26f932
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7477
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

Plumb in support for disabling kernel queues in
GFX11.  We have to bring up a GFX queue briefly in
order to initialize the clear state.  After that
we can disable it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 77 +++++++++++++++++---------
 1 file changed, 51 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 3e49c0f399e02..e18100c5faa2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1128,6 +1128,10 @@ static int gfx_v11_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
 
 	ring->ring_obj = NULL;
 	ring->use_doorbell = true;
+	if (adev->gfx.disable_kq) {
+		ring->no_scheduler = true;
+		ring->no_user_submission = true;
+	}
 
 	if (!ring_id)
 		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
@@ -1709,21 +1713,23 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
-	ring_id = 0;
-	/* set up the compute queues - allocate horizontally across pipes */
-	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
-		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
-			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
-				if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
-								     k, j))
-					continue;
+	if (!adev->gfx.disable_kq) {
+		ring_id = 0;
+		/* set up the compute queues - allocate horizontally across pipes */
+		for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
+			for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
+					if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
+									     k, j))
+						continue;
 
-				r = gfx_v11_0_compute_ring_init(adev, ring_id,
-								i, k, j);
-				if (r)
-					return r;
+					r = gfx_v11_0_compute_ring_init(adev, ring_id,
+									i, k, j);
+					if (r)
+						return r;
 
-				ring_id++;
+					ring_id++;
+				}
 			}
 		}
 	}
@@ -1823,8 +1829,10 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
-	for (i = 0; i < adev->gfx.num_compute_rings; i++)
-		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
+	if (!adev->gfx.disable_kq) {
+		for (i = 0; i < adev->gfx.num_compute_rings; i++)
+			amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
+	}
 
 	amdgpu_gfx_mqd_sw_fini(adev, 0);
 
@@ -4489,6 +4497,9 @@ static int gfx_v11_0_kcq_resume(struct amdgpu_device *adev)
 	if (!amdgpu_async_gfx_ring)
 		gfx_v11_0_cp_compute_enable(adev, true);
 
+	if (adev->gfx.disable_kq)
+		return 0;
+
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		ring = &adev->gfx.compute_ring[i];
 
@@ -4561,18 +4572,29 @@ static int gfx_v11_0_cp_resume(struct amdgpu_device *adev)
 			return r;
 	}
 
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		ring = &adev->gfx.gfx_ring[i];
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			return r;
-	}
+	if (adev->gfx.disable_kq) {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+			ring = &adev->gfx.gfx_ring[i];
+			/* we don't want to set ring->ready */
+			r = amdgpu_ring_test_ring(ring);
+			if (r)
+				return r;
+		}
+		amdgpu_gfx_disable_kgq(adev, 0);
+	} else {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+			ring = &adev->gfx.gfx_ring[i];
+			r = amdgpu_ring_test_helper(ring);
+			if (r)
+				return r;
+		}
 
-	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		ring = &adev->gfx.compute_ring[i];
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			return r;
+		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+			ring = &adev->gfx.compute_ring[i];
+			r = amdgpu_ring_test_helper(ring);
+			if (r)
+				return r;
+		}
 	}
 
 	return 0;
@@ -5111,6 +5133,9 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	if (amdgpu_disable_kq == 1)
+		adev->gfx.disable_kq = true;
+
 	adev->gfx.funcs = &gfx_v11_0_gfx_funcs;
 
 	adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
-- 
2.48.1

