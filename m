Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A6BC28B2E
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 15:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0CCD10EBD4;
	Fri,  7 Mar 2025 15:16:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UtSDy/rR";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFB6610EBD4
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 15:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izB0x1FJXJZXVIVbv8bI1n6X4uI4kEWwtSFjZr+kV0ixad8bolodLL67d2fNCEQSalYx7iwhCDwzlLqpCTidiRVpsLr0z3BMlaw8WjIEnDMPbVp9r8G9H9YLjiKabxs2W7n+4KkWLPITXkrWkX2ieDlIHXjyklISgF1sa+X9VKMlhG7dEAC+W0SEeZw2u8MfFwcIycQIW8QlW3dh4jkBlolIKh52ri0Rzlw9ZyCjWoTPt0O4+RekKucTFGlC24lsqE9vw4fvDlaDZNUPrZ5aQ574uPA4QbXAxl8WEbvBC8Vkb+lHZ8tEP46ifyZ8U6jMJxG7kD5gAjDVav4GwED7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2xCmy7bzHw2E13wYpn1vjdkdEJKwxcfIGciKPHxdSY=;
 b=w/+RrVTDuhwubmfbvJxIHTfP4ZzW8IYmeB27ZdB5j3uMuzN7i8Pw1e5FzsKJoLAk0+WPtHpT9obOZ8QKKqGKs0iV8GRX3ADdfiwob1Mv4QYuAyAcbS/Vwmbc8qfdiUdmEGs0xFQNSsINX5WHvDNQrVzXIeaU8RMCqsQegXPHkWiBCv9ioS4W4eOWobljU1MUpDF/lN4azYTMs/okr7pQAGDh5mZoWpdXVyx0jUOcbFcLzOneAKFlru07mlBvFEqyFqT5VO5gCXj0SvCuemv1tiAz2bZcCg89Z6wNpOqyrj+uwZzslFmJvk/ZWNk1kus7a5o3LTqfiKFmjJD+RtE8Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2xCmy7bzHw2E13wYpn1vjdkdEJKwxcfIGciKPHxdSY=;
 b=UtSDy/rRyDwJVJXuHgmagXQDqI0jAZDybXZGWHZBbdhywc+wlFNn7ZyZzb1Urt0EcrhJstm1udJRdg4Is60WgpR9PtBoaaqDpOaQ2RgwSUdIoI/rjdSuwj5/dPZBaE4tbr7ay09ML4BLGYjXz14JwT4AX9Rxz46Dv6/QR8dr4Yg=
Received: from DS7PR07CA0018.namprd07.prod.outlook.com (2603:10b6:5:3af::27)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 15:16:24 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::53) by DS7PR07CA0018.outlook.office365.com
 (2603:10b6:5:3af::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 15:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 15:16:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 09:16:21 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/11] drm/amdgpu/gfx12: add support for disable_kq
Date: Fri, 7 Mar 2025 10:16:02 -0500
Message-ID: <20250307151605.946109-9-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: a9141b9c-6f4b-4975-1021-08dd5d8b05ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?29Eepw6sWJ0d+lHX46G5W+buoLAQMzd3aiL14K6/ee0tQMn8o8iY2tVkAcF+?=
 =?us-ascii?Q?3ZPUWY8+KuyMWXEZEANTLeNk42ST/KDU72DzV1mUhGFaXrDuIluOLseFHfEZ?=
 =?us-ascii?Q?6hmR99abdGkyP3Bj2/p6hKqBRra7bu1vIEncVPwE2QydlMKANRN9Rp+bJLVL?=
 =?us-ascii?Q?qhZDS+4tkUjoY3roKz//vpSY4pscaTwn1BlcJSaYeJ1cum+om6Q+sPWx2LW1?=
 =?us-ascii?Q?KdKR5VR8Z1Oh/XEf4JFsmJos375xMFdB+cOeptWrLhRarr2fipTkCPHB/ai9?=
 =?us-ascii?Q?t7V0g0Sj6/PxweTkZ/1cqTh+YxfdXAJLSf/giLKmX7u0lSyy6IfIGVVHtR6W?=
 =?us-ascii?Q?4UAH9Jk+rRk84dOIRF7EZRXiID81UuSjvnnBsnkfonwvdN4JZCr/kLsP4/5H?=
 =?us-ascii?Q?yc5HHzca2uY3zO2vCB/2Ep+7onbX3XeqP8IDgHC9Uvx90cYIrDb02oSjh0VZ?=
 =?us-ascii?Q?jVcW8SIGhzxERrwI0ujU7qtbghrdV4PXNhmjrFxSpo5GyoPvlXSq3Q11l/n/?=
 =?us-ascii?Q?VV6KtTT8Jkm4At+Pvsh3xC12bJDbQgjELWhZi8Pb6dzXxHdotN1075yFQVCU?=
 =?us-ascii?Q?cgA4RzSCUBCUiF22BbmVGq8FBMzkscIMaUY285xXLTZBmWOAe1wcLKOyP/2g?=
 =?us-ascii?Q?AYksoxdxXXItn1QL97XN+xLeQdphfJaRZcyUGzxtWDBHgwR9uKn7PAtJpe7M?=
 =?us-ascii?Q?HMNkjxxn0mct3hWyWesTQCOni+3QKWvXKwW5Gj01IvizkLnsWCF8HxiupqDJ?=
 =?us-ascii?Q?01MAL+AS2+okrUdm8QSoSY3IHIlpywl6AdZQgkQj+bDr6iQePbJpLMlM9CaN?=
 =?us-ascii?Q?UhROOiDxhzak1SnVzFKikidHzgQ8WpmigIlR4BMTu6/j/LZgU1udVr/OR35G?=
 =?us-ascii?Q?oVYriacHaGzM2tDDleQ5sClr9lE8tdQFU5MXPtbKFDCWeziWM9RltA8kf61B?=
 =?us-ascii?Q?GhuH7Tgyvie42uzf+04Pk573gSwiM7Zfwc+k3i9mKh5t1tHduuFOPqvCnAaV?=
 =?us-ascii?Q?MXrDZ+JKBk7ofvRl6AnNRvn1FFWpJp0NezA7qvngOdM5ZLPloMY8RlFYJRgZ?=
 =?us-ascii?Q?em+1qWi4er0It+5tlultUttu+RY91fFFJV052JvqlBa5sOZ3Ud06Co3dIEBe?=
 =?us-ascii?Q?OpCwfqa4nCzozRo3xD9bJwDhUAtq5xI/l0SPJ4whkF6KQ754iXhYv1vQyksL?=
 =?us-ascii?Q?N8yzwOH403sN9EIkju/uqpeR+z4Z5yrC077qxkc5hiUT7549lcMxWbS0OAdz?=
 =?us-ascii?Q?7+I9G5bcMvpixpzx5EOuHcmDuKYz8Jdrx4wjB2ith77K4HcVNpwGNjsYYT5F?=
 =?us-ascii?Q?+F71zN9rwzSIjY+AQbjUgWhqlE/HalOFQmNvPxldzZtwbICVsdQtbVjK7MrF?=
 =?us-ascii?Q?EXoVxblg/mPNFc/L/Esh4lqw7XmcxLPdpwshoYLAH4Qfprj/PZnbD9EyJsDA?=
 =?us-ascii?Q?mVLOkp9u09jzZUbgf+ZShNVwYLZS8OBbY+xhjvoHViiV8c7b0sKkmuwY/DYX?=
 =?us-ascii?Q?73Y5sjD+geLhQbc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:16:23.7980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9141b9c-6f4b-4975-1021-08dd5d8b05ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196
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

Plumb in support for disabling kernel queues.

v2: use ring counts per Felix' suggestion

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 96 ++++++++++++++++----------
 1 file changed, 58 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 34cf187e72d9f..23ee4651cbffb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1421,11 +1421,13 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
-	/* recalculate compute rings to use based on hardware configuration */
-	num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
-			     adev->gfx.mec.num_queue_per_pipe) / 2;
-	adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
-					  num_compute_rings);
+	if (adev->gfx.num_compute_rings) {
+		/* recalculate compute rings to use based on hardware configuration */
+		num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
+				     adev->gfx.mec.num_queue_per_pipe) / 2;
+		adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
+						  num_compute_rings);
+	}
 
 	/* EOP Event */
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
@@ -1471,37 +1473,41 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 	}
 
-	/* set up the gfx ring */
-	for (i = 0; i < adev->gfx.me.num_me; i++) {
-		for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
-			for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
-				if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
-					continue;
-
-				r = gfx_v12_0_gfx_ring_init(adev, ring_id,
-							    i, k, j);
-				if (r)
-					return r;
-				ring_id++;
+	if (adev->gfx.num_gfx_rings) {
+		/* set up the gfx ring */
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
+					if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
+						continue;
+
+					r = gfx_v12_0_gfx_ring_init(adev, ring_id,
+								    i, k, j);
+					if (r)
+						return r;
+					ring_id++;
+				}
 			}
 		}
 	}
 
-	ring_id = 0;
-	/* set up the compute queues - allocate horizontally across pipes */
-	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
-		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
-			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
-				if (!amdgpu_gfx_is_mec_queue_enabled(adev,
-								0, i, k, j))
-					continue;
+	if (adev->gfx.num_compute_rings) {
+		ring_id = 0;
+		/* set up the compute queues - allocate horizontally across pipes */
+		for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
+			for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
+					if (!amdgpu_gfx_is_mec_queue_enabled(adev,
+									     0, i, k, j))
+						continue;
 
-				r = gfx_v12_0_compute_ring_init(adev, ring_id,
-								i, k, j);
-				if (r)
-					return r;
+					r = gfx_v12_0_compute_ring_init(adev, ring_id,
+									i, k, j);
+					if (r)
+						return r;
 
-				ring_id++;
+					ring_id++;
+				}
 			}
 		}
 	}
@@ -3495,12 +3501,18 @@ static int gfx_v12_0_cp_resume(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	if (!amdgpu_async_gfx_ring) {
-		r = gfx_v12_0_cp_gfx_resume(adev);
-		if (r)
-			return r;
+	if (adev->gfx.num_gfx_rings) {
+		if (!amdgpu_async_gfx_ring) {
+			r = gfx_v12_0_cp_gfx_resume(adev);
+			if (r)
+				return r;
+		} else {
+			r = gfx_v12_0_cp_async_gfx_ring_resume(adev);
+			if (r)
+				return r;
+		}
 	} else {
-		r = gfx_v12_0_cp_async_gfx_ring_resume(adev);
+		r = gfx_v12_0_cp_gfx_start(adev);
 		if (r)
 			return r;
 	}
@@ -3809,11 +3821,19 @@ static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	if (amdgpu_disable_kq == 1)
+		adev->gfx.disable_kq = true;
+
 	adev->gfx.funcs = &gfx_v12_0_gfx_funcs;
 
-	adev->gfx.num_gfx_rings = GFX12_NUM_GFX_RINGS;
-	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
-					  AMDGPU_MAX_COMPUTE_RINGS);
+	if (adev->gfx.disable_kq) {
+		adev->gfx.num_gfx_rings = 0;
+		adev->gfx.num_compute_rings = 0;
+	} else {
+		adev->gfx.num_gfx_rings = GFX12_NUM_GFX_RINGS;
+		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
+						  AMDGPU_MAX_COMPUTE_RINGS);
+	}
 
 	gfx_v12_0_set_kiq_pm4_funcs(adev);
 	gfx_v12_0_set_ring_funcs(adev);
-- 
2.48.1

