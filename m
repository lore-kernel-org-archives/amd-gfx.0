Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB89105D991
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 01:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 236BC10E4F5;
	Wed,  8 Apr 2026 01:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uy9WUG90";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBB0310E4F5
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 01:17:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rEh2rTvI0nAaxA1/WFX7P1vRSpHBzek5Hm3i7d2DbWkBGqys/DvyGUQYQVswtNLwAax/ZKp5tbMLEjkmxMxQvNoAFUR9PyNPD9CQSwOctYGEAL+hfg4rRszX4dAnysL+azhrwVXhzSKDx1fa0DOzaeLZOq+Ev1T3cH/XINOyMsOUulosSZnY2XMhepcn1lf9Ez1B6ODQ0UMkp4Nn5GdZM5jndGayaHMGOpr+9uhZ+XK2q8lRsdqDQkrimywChc0rFzm00L20LyI95aBkICTLyRtkdHdm0vZNPa2YVrn3AmkQlJZdoiB8DnbC+IO5ZuNnf0LvlBn0idCWhT5MOdmMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hI0ziM6cB2MhWmCRsqT44ddqBYlbXNO3dpiyokPlCg=;
 b=SkQL1iMXuhEMzLsLQrIFmppyWAPDkTV99lSv1MoVbg5tsrb7r0f4r6zlXTTIYaobbYBhdn8XcmU8HBDGkFPaN/OVNyh8ea4oYn1qzU+qFV7Ezo5H0S1EDNI4rgDYxLPeK+vJDluSyUflzxrEQmidG9fB4eMa6fxNUlcbWS1ikcbXQvPZMN7UodiS6AFU2Fe+bZgabZE7G8BafrUZKvBSgNMxbcVBhDGpSDB3EKQoMfApBLb43nJoOR1wYTEpCRm0WSi5wvHaQo81wxdGKPFd9GIXVmesI8yIN2azJxzBs5UcLQE8m1fYCMY4zWyz+fQskFd9JeuCqbfxjB5W1BWkeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hI0ziM6cB2MhWmCRsqT44ddqBYlbXNO3dpiyokPlCg=;
 b=Uy9WUG90zvZueqChIn+E1cKnv5HMndmFuPlggTe/uS1zA/4Y/f8VqnGl5ZkYvvRIYHBmNVn5R/treUR/8fWLYriM8bXh+LXsghCXbOcmPs9/sgl6nyuWbBKz49brMU19PRPy3mgUzJjs9WdHHRnXTJWL5iC4bRLa0ekFOd6GzzQ=
Received: from BN9PR03CA0486.namprd03.prod.outlook.com (2603:10b6:408:130::11)
 by DS5PPFBABE93B01.namprd12.prod.outlook.com (2603:10b6:f:fc00::65f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 8 Apr
 2026 01:16:57 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:130:cafe::96) by BN9PR03CA0486.outlook.office365.com
 (2603:10b6:408:130::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Wed,
 8 Apr 2026 01:16:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Wed, 8 Apr 2026 01:16:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 7 Apr
 2026 20:16:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Apr
 2026 20:16:56 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Apr 2026 20:16:44 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 5/5] drm/amdgpu/gfx_v12_0: enable compute pipe reset flag
Date: Wed, 8 Apr 2026 09:15:12 +0800
Message-ID: <20260408011600.2512734-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260408011600.2512734-1-Jesse.Zhang@amd.com>
References: <20260408011600.2512734-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|DS5PPFBABE93B01:EE_
X-MS-Office365-Filtering-Correlation-Id: b8014455-effd-4c50-6823-08de950c86ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: GBknLU0rGSKsFYrsJZXoNymvAr0b3HoELdRey/ROblane5QwJF6jF0aN6ELvQvWnMOICNPI1zpp0WO612shyaldU4mGVmHJeLdIhjQhXvUw8WFrhtabtJvDS6sl581zqRLjPkSpRSAp8bxnBhOLhzUcpydyOw0XQcEblqcSzhoLeJ/Z9n1uFvOYRysAM2pRf+rx7YR8u/8nL2uvZaXhkltUDh6oV96QQqCcYh5+fKJx8XCL/+Z4yJTsc2A8caTskW8eaDuj11RS6KRV+CY2tEA4FvJmuXuVsBDsVTzvwhaXLQiFNXG8wbVy0ZVk0STL+krHqBq6skJ0VKT5rHYKOAsbTj337cgvKYnQM/VCFSlXPt3dvl7JMOkzoU3koFTIbdgKDEHZRwybb1Keq6xCa2r2kAgBTMYvOhxpE8Rwitdd5cOZk665ps8W+lsUzb0qM87sP/B7RYDBfgDGTWJZbYRUk1Co6L0TM7974hP4D1D1+wkVj/3+uqTrZBsK2GjJJIlfvb7cNqTJzvMWUaEbSrfIApg+pOisUEkvUSb1ygxJU/8BJCS8L5vQ2t4qTkvZuS0M9pB/D/fZUvccP7DzUExgwfTTMmLIUvD2TjQYG/Datyv78vgx+fOO4RjrQdBveKGkWu60+qm0U4pXDfd1SHuXvy+JpOBX50es25aaKPz32cadfYl3yaNmoernDAxOLCM8FjiGyrs9369ku08VcUeBBVKQhHG8cvBHYfpRW9+7LjPAbRQsHmnXHFI3bXb8yS4et6Nmgf36KsE/xv8dX9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3Xokr0pHQnZDIf4Sp0rqliGVRyRs+JEv0AZp8OBCbO4RYSqqMOm43Eff3zxsmdO2DHPJ3wYdPpyHa0Wf+DjXvCtfET99TQ6qJkh4CYJcr9XGBxej1JJWYScEb9nxYDOJZsC7kcO0PjXgF91SbnWlEDmLR0FYR4sPMof6+3GzZgjYwM20rfItZ1DLR514ohnYRp8lpBheWWiTcvzB0CqlMwwzjT0jgCfYeBTXXYItgXpNcIt+Cq3uF1oyK5+WcIIy45eCP4ZvNb1HxpJjUbeY0vlcv7uLtpZzqgExX+Ia8BZ0kFpm/VCe0PrwzTCl/kafwWVVdDFM9UdSQgJCpu1INjyh+fn2pyLpjcTQSIBeVxFpVv+AuazvvkUiQ2CkypBxcdWISUhtEOF0Pv3qtOTr2DnBLCsBaE2Rpz7NCIQj9J0lYj7s+nIMxHXltNDezwD3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 01:16:56.8718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8014455-effd-4c50-6823-08de950c86ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFBABE93B01
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

This allows the driver to fall back to pipe-level reset when per-queue
reset fails, improving recovery success for hung compute or graphics
rings.

V2: replace both gfx_v11_compute_pipe_reset_support() and gfx_v11_pipe_reset_support() with
    amdgpu_ring_is_reset_type_supported (Alex)

Suggested-by:  Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 00cbd1c09cd2..34a2ccabacf0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1563,6 +1563,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		    !amdgpu_sriov_vf(adev) &&
 		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		}
 		break;
@@ -5264,22 +5265,12 @@ static void gfx_v12_ip_dump(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
-static bool gfx_v12_pipe_reset_support(struct amdgpu_device *adev)
-{
-	/* Disable the pipe reset until the CPFW fully support it.*/
-	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
-	return false;
-}
-
 static int gfx_v12_reset_gfx_pipe(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t reset_pipe = 0, clean_pipe = 0;
 	int r;
 
-	if (!gfx_v12_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
 	gfx_v12_0_set_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -5340,6 +5331,9 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
 	if (r) {
 		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
+		if (!amdgpu_ring_is_reset_type_supported(ring,
+							 AMDGPU_RESET_TYPE_PER_PIPE))
+			return r;
 		r = gfx_v12_reset_gfx_pipe(ring);
 		if (r)
 			return r;
@@ -5396,9 +5390,6 @@ static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	uint32_t reset_val, clean_val;
 	int r = 0;
 
-	if (!gfx_v12_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
 	gfx_v12_0_set_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -5488,6 +5479,9 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
+		if (!amdgpu_ring_is_reset_type_supported(ring,
+							 AMDGPU_RESET_TYPE_PER_PIPE))
+			return r;
 		amdgpu_gfx_mec_pipe_reset_prepare(adev, ring);
 		r = gfx_v12_0_reset_compute_pipe(ring);
 		if (r) {
-- 
2.49.0

