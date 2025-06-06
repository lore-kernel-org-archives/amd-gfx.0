Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D51C61DB8
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A57110E068;
	Fri,  6 Jun 2025 06:44:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IyyYulfP";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E0310EA06
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGklrVvaNuhgaij2adsVJJbQ1OTUeA+Mrfs6TGOG1xcwFWq8GMm+khpY5T1kkGt2bNW/BWBEbOaJzZPSc0beZafpWNape388uS2CuZ3PVettGDO9f+sTrXvgJD7kibw4ANMLhfZhWgNTjm8n7Crg9MDoWLWlGyekFBR9gI5Iy71HChb98RxsrN7GA0D4H0QgVwmTET29wiuW5qhY8x7n3ZYu03cCZANFbtYXsDqBkhqOVG9/BVF5k2vGd9PP1FtkSV6ufGgKvDDjJ/pj6iTacbGgo28ihca8Vq76c4aJPTaYc6aBdhoc5X02cMu2+/KRqZSOjPD5zFXGePBoCJj6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmcwpZQV4EZ8RCQCNLgdkCY7ryqBWXMEYzptPTVqt9Q=;
 b=nTD0i4Oy0sAv/K7zAqx8VryFalA/4o2u6Gss4Jb55OBF4juA1JMmuFBDbjJoPCUV88oIuYQQBlaYMh6WW03MqwPqzeBCE1t/t5A7v4WuKPQgLzSTMUW+M+/WdcGwFAFY7PpFEoSWEJl5yi4I1tOYTfPqP+1YtvB2sXLNBX4Hm7SuQDFCTL3eUxlcAsO1q1VnwFDU6bG4vwvR2aNuLpiJZcTcgU64DVxkamTuBjgaU9dtNIubZ2KY4PU8+YhIHnWrclZdedSNizB0LTFivmCT95Qkd+cBfPIQgPkzeJZfE1WW1Khjp3mnwbnJo27SzAh+WbHn5miKP2XZKjdAtvc2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmcwpZQV4EZ8RCQCNLgdkCY7ryqBWXMEYzptPTVqt9Q=;
 b=IyyYulfPNM59QTQGo7g+bVt48pqDk/P/3xmIJH6fBkQiyjfnDjocYVabLlcotK6yzPX82UnGEP1K3LS+x3kWfDmZ/YbfHNMF97/2liFABE2e4xhhBx8TATx9Aqzi3SogeVO/kEtq17bhbbMOlhZTvA/EMsnRx3N5dMjaMdmWPb8=
Received: from SJ0PR05CA0066.namprd05.prod.outlook.com (2603:10b6:a03:332::11)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Fri, 6 Jun
 2025 06:44:16 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::60) by SJ0PR05CA0066.outlook.office365.com
 (2603:10b6:a03:332::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.17 via Frontend Transport; Fri,
 6 Jun 2025 06:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/29] drm/amdgpu: move force completion into ring resets
Date: Fri, 6 Jun 2025 02:43:33 -0400
Message-ID: <20250606064354.5858-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 96250964-f328-4081-fc6a-08dda4c58e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWVVS1ZVdUFCRmFyKzVUUlkzVmJXMDRITW1LS1EzYlZGNnV4ZTJSWmtSSnpv?=
 =?utf-8?B?b1AzRW1iSTdpVHFqZVViNG9zb05lN01WQm93bFZlaElHNVpmU09MZHBrSXFK?=
 =?utf-8?B?dFk2V2pVdmFsNGU1QjdCWHdiZGhobkFKbWdET1hhRlpjZEZZSmxvcHJ4c1hh?=
 =?utf-8?B?QXg3MHhSdVp4ZUVldUQ1NUI0YjMvR3NZRGMrL04vOFAyY0x5ZEF2S0ErbVNt?=
 =?utf-8?B?QStrblR4N0hQbWx6NGNVbVBCTEkzMUp2cDFrejBpL2M3NUdtbTJnbTIzOExi?=
 =?utf-8?B?MVB2OHlyS2piYXRURzVTeEVsVmRrcUVhUXRnRldKK2IxZW9GclpKemJySE9B?=
 =?utf-8?B?WTd1b2JidXpaN0ZIY1BxYk5xRGxSakJ4SkhjWWRRRGlpeTFjVkFKWmsvRUpR?=
 =?utf-8?B?SmpGSytlVVVKRm5aTWtQR0M2cE1UTjhIRVc3KzBpcEpoVkZEK1QreEZTdko3?=
 =?utf-8?B?ZU5NQXhHN2gwTGFFZ1JibWNpajdsNlIwckZ2U1RxV2lTb1hVRDJPTVNseExP?=
 =?utf-8?B?TjJoejJ1MWtzRVcwemhjZ3BOaCtPc2NMNFRWQStaRVhIUXRyWGdVc2ZDTTJC?=
 =?utf-8?B?RW4xY2JLYlhLZGdvMWtCM25iNXh0eTNubm1ZWklsTVYvME1rSjVmQUl4cDR3?=
 =?utf-8?B?MGJUMFlsMmIwTU5TUGFYekVzNFZmcTl3dFFwekFjRlBsZnNhaUpaelZNK0h5?=
 =?utf-8?B?LzRKdnV0RHo2OGdtZmU5elhxS25TRlg4OTZ1Z3JMc0J2YkQyZXJkSm8zaHBP?=
 =?utf-8?B?NlAxZEpZTjdGSzRibXBFWnlnZWRMNlZTb0VlYXE4alRmQVRUdlVSd0N2NVk5?=
 =?utf-8?B?bTMxSEZGQmhQNkRzb2ZNWnZxYkp4ZVRNU0VHSFYrY3QzRHlpc2Fnd3RiN2pp?=
 =?utf-8?B?UEJiN2JqeFp3QitLVWhrYlBMQ0tsWEdNZ20wdTh1VUlFYlpwenU4Yyt0MGxa?=
 =?utf-8?B?V0F5VGc2MUZWVjRaSlpLaVdrM3BxWnZvYmxTWEgzWDJIYXdyaUxzM3lMRUpl?=
 =?utf-8?B?QTFaRWQrR1VseTN3Rm1TRFBtTzJZaEhVclpHTTBzaUFUNmlQRFZnei9FMEJu?=
 =?utf-8?B?ZlFTMkF6Nk83bEd0a3k0SXNzRjU1WHZjSDZEWG9YTTI1Q0pVWHF1eHNIZEVL?=
 =?utf-8?B?Wm8vWW8vd0JNQ21udkg0NXl5eHhmOHFoemI3UHN3VFFkYlJMYS8zY1Yyajlo?=
 =?utf-8?B?dG5KanJheUJjU05TRzUvc1FvYUxEbDZ4N1c0cTlBMkViSzFPK2M3V2FMWHdk?=
 =?utf-8?B?SllqcVNnVTRzVWo0dXdFeEFYVzRQZHlia2VIWDUwdW9zUVpCb1pJSnN1TnBt?=
 =?utf-8?B?ZGlRa3BXQ0FMV2RUWDQvdlpRY0UvRVJZbDZuWmxBQzFCcHU2a3hKZVhyUFRW?=
 =?utf-8?B?cndtTzNWcUlUVkRxZ0JyVjV4ek9LUEhxcDM5MUdyaGNuUG9mL3pTbmQzTTlh?=
 =?utf-8?B?bmJ6ZUN4MEF4aUt2aWxTK0hERWh1YjdyR2FscE9BcStzUXhEZ3JyZ3Z1dDFk?=
 =?utf-8?B?ZGZwM203dTVvU1grZW5SaUdxNFlaazhNUzdTWUZRVmxaS1FLV2xuNy9yWXhW?=
 =?utf-8?B?R0RsRTdreENvMFNuMTl5SmhlVGNsRmQxYVAwemZCQ0FuUjR4dmVPTzFyNUl6?=
 =?utf-8?B?ZkRKZW5BTy91MmZIS3d5NzQxanl3VjExclBTWDBzbU1CMEV0WlVpOG5YdGRP?=
 =?utf-8?B?dTVnQ0NDaDhmVW5JYnZHZWFRL3J3T1Q0Y2tNcyt2bHBZdjVRRUVUT2VtK0lQ?=
 =?utf-8?B?Y3YxbWsrUlFydHYyMHVVWXEyMGx5UVk5eHZHemtuT1pHMUIvelFJU2hXQ25P?=
 =?utf-8?B?a1pXSStlQW4raDhSWSsxUDMwVU5Da2JRM2xXcUhSeW5yUThOMzRRdHoyeHpa?=
 =?utf-8?B?d0JsenNXbjE4bnFxazdZMGdZU0JTdXlPT0g5cERCaEROc3BVUUxxY3YxMW1W?=
 =?utf-8?B?dlRHWUFkblBGMUUzZkYxNDRveHFDcjJudWQxL3NobGtLZDJQMS9GVVQveGtZ?=
 =?utf-8?B?ZDNwOFNvYkgvaGVXenFCa0FVNFZ6VVdoMUVwRmZXaFN4aERGMDBKaGxVYklF?=
 =?utf-8?Q?sfvGm9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:16.0497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96250964-f328-4081-fc6a-08dda4c58e70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030
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
index b398e7d097cc8..461bd551546de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -161,10 +161,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 		r = amdgpu_ring_reset(ring, job);
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
index c58e7040c732a..7a82c60d923ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9576,7 +9576,11 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
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
@@ -9648,7 +9652,11 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
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
index 0ee7bdd509741..9ad4f6971f8bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6836,7 +6836,11 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
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
@@ -6997,7 +7001,11 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
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
index a26417d53411b..3c628e3de5000 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5336,7 +5336,11 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
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
@@ -5450,7 +5454,11 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
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
index 5e650cc5fcb26..e64b02bb04e26 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7222,7 +7222,12 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
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
index a7dadff3dca31..0c2e80f73ba49 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3619,7 +3619,12 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
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
index 6cd3fbe00d6b9..cd7c45a77120f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -767,9 +767,15 @@ static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
 static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
 				struct amdgpu_job *job)
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
index 8ed41868f6c32..d936f0063039c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -646,9 +646,15 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
 				struct amdgpu_job *job)
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
index 3512fbb543301..9e1ae935c6663 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -558,9 +558,15 @@ static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
 static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 				struct amdgpu_job *job)
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
index c8efeaf0a2a69..da27eac1115ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -723,12 +723,18 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
 static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
 				struct amdgpu_job *job)
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
index 8b07c3651c579..f1a6fe7f7b3af 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1146,12 +1146,18 @@ static void jpeg_v4_0_3_core_stall_reset(struct amdgpu_ring *ring)
 static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 				  struct amdgpu_job *job)
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
index 0a21a13e19360..3d2b9d38c306a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -837,12 +837,18 @@ static void jpeg_v5_0_1_core_stall_reset(struct amdgpu_ring *ring)
 static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
 				  struct amdgpu_job *job)
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
index ffd67d51b335f..73328e213c247 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1671,6 +1671,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 				   struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool is_guilty = ring->funcs->is_guilty(ring);
 	u32 id = GET_INST(SDMA0, ring->me);
 	int r;
 
@@ -1680,8 +1681,13 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
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
index 46affee1c2da0..8d1c43ed39994 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1543,8 +1543,13 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
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
index 581e75b7d01a8..f700ac64fb616 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1456,8 +1456,13 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
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
index d9866009edbfc..25c01acac2cd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1560,7 +1560,11 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
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
index c546e73642296..97ea5392ab85d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -825,7 +825,11 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
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
index 47a0deceff433..f3ff3c6c155fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1972,6 +1972,7 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
@@ -1979,7 +1980,11 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
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
index d961a824d2098..e15057333a459 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1622,8 +1622,10 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
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
index 10bd714592278..9fd3127dc8828 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1470,6 +1470,7 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
@@ -1477,7 +1478,11 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
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
index 7e6a7ead9a086..c5afe2a7f9f5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1197,6 +1197,7 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
+	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
@@ -1204,7 +1205,11 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
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

