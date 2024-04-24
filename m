Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9384C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 01:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 620A810E681;
	Wed, 24 Apr 2024 01:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HWazPE8f";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76FE810E681
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 01:19:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTaliBbJrHjr9GAFaylC6GabOZEl0n9sSsQzbcpWnHCSRSoMkpgBiWm3kSkCkzgXQF9XcNzjDEMeWHhGQJuirAmsuEEW/BRpJd0Bg5RhS8nxhVYTeIFL33mZDV2iwsc3OvXOdu7tcnnRybZS/pFQ22j1fPTHfytTmGn7WbtuccW86mfwLyZg82JQGFPHRig18ShL8oI3JNrR6vmn4W2kN5gkQgdpFqH+LhRl1T1mejvUY5pb0D2G9sokrVNPGGA6IOfgBW/xIYvNAYrjYHTOYIE+1HLx6TWYvc9/T+RJyEjFqnKbPRayu/XT7Qz8tCbfKRugKHSXzHVjgUgbGcmIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgdn94DCq4rv9+QZbwf5RNd1AcJGGg/y5UVrRn2KHtw=;
 b=S+e9fdKWmFRw0v7AtsSm0G+zJqtbfVuM7CSJ9cvrjpS9AX/6r6XhVNIVeHnkF+jxYj3jQo2jV+RXQ73N/s7goFQjkRwP0HTRB54TakulhkOUNFDiAaZrofHY6Vs16Zlx76m6QqxtGrhmKm2D7gaD/8oBjaPHbmhAdSgnLONETC51aVpo0SAWFWyA1szN3qOY9wbdNVeBmByLXOpCZJrUooESMf2v6pAGuyaWs7Uo2X9y3bNbz42bC08CZMfT7bvz2/tKS2nZy9/8lNMjtrH8TgyUn35rvEny5pCAdTZvjJqJS4E3RXamZzOb3pQT6y1gB4NApBDB5dYlmmsrRfMzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgdn94DCq4rv9+QZbwf5RNd1AcJGGg/y5UVrRn2KHtw=;
 b=HWazPE8fRKCw7WKu4Fhlzqvh0fl9O2FyKkxCMEPu1+p1WGbnSq2zzds9GTZlkMJAJ0J1HDn+fx7D4M67J/sTdnxdD7gA0LSNb3tPRU/Pls1UssRUqFhQp0VneOgJ9sddnqL69RUbHkvd3tw+Dd6dV8dzTBMCVSFD3Zl3ESFCdoQ=
Received: from MW4P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::15)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 01:19:49 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::36) by MW4P223CA0010.outlook.office365.com
 (2603:10b6:303:80::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Wed, 24 Apr 2024 01:19:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Wed, 24 Apr 2024 01:19:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 20:19:47 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Apr 2024 20:19:40 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix some uninitialized variables
Date: Wed, 24 Apr 2024 09:19:40 +0800
Message-ID: <20240424011940.723906-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ede5bb-13de-49a5-e6db-08dc63fca25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oF7UerdWYt5nMqjvsw74UKx+wENW25971VJxvXw9JaFstwA3ird6waUiMpNl?=
 =?us-ascii?Q?wTv53x/pB5zLhcfRmsk90BQMF5zVG23Hg+VOzUz/tcH9Zv2/7Oc9OByOuG9O?=
 =?us-ascii?Q?FycT46Yw7caSEOydtpaJDehPEqpcfiCrMCFK+WbGMzBF3VR55VItNY+y4xWw?=
 =?us-ascii?Q?ZByZcqcGG5wQ/HHQu7qAV5b/pbby5vlKj44LvksF7tX9ckJWe3/vVOU7vG8g?=
 =?us-ascii?Q?mDNmQS3y2qSlfP5p8wBv+DBLFqEU2NoSZ1RXa5qTOY/8WecCAOlzeZF7wZeM?=
 =?us-ascii?Q?P9AlvFj+xAJGkVWjm/Xo58kvhIjDCWZjmkQCY68dUw4qIv/RIxo11LgHbPeI?=
 =?us-ascii?Q?GlpAUwzpyHB4PQnPG9icaZpvo7L6Z4d5kmBtfTkMBi/eTgQvb/4gCkjykfFb?=
 =?us-ascii?Q?1t9yOiPTdikvkBMWADyUof3IPkZGSjO78umV4PoDpGsps3rgbArLID2F4NHS?=
 =?us-ascii?Q?7J9zMhATyG56tNeLk5UWr/H4Fk4Us1QYZJqnUDGMYtcE+M1pjPlNcsuL6uhr?=
 =?us-ascii?Q?+m60h1cvWc6MBPuJWfZ1/87ksAKL8SEcCqxFrDNiAzPFvjtg5mwACVEMQrcL?=
 =?us-ascii?Q?OAg3uw4iOQfD4tZ4UIwTAZC02wkiv9hZWTBSU1txNx3X3n5OcsAQN3A17blF?=
 =?us-ascii?Q?gGA2LZk7qxT9rsbuHiAwbhgu0zeqrN2C1FfPZB1yHrqRBD4s+n3v6xSGrSzd?=
 =?us-ascii?Q?cRj8fccriccWbUk0NCOBK0sgp3oD42nuCvDVFVj4jqDBeoKZpQY2+chBSBTK?=
 =?us-ascii?Q?AW04mgDQSGTP8i0FaskkvqS68oDXNLYiktWfK8NNsUppswcOUjvYplVebGAo?=
 =?us-ascii?Q?rFvCISbFZMMTHwLsm2HgOmZvhP/UsL7i1ZZ1hCl+D3nSxeqZ/SEJpaHOHO0V?=
 =?us-ascii?Q?4GAUC+4QSKvMQbL16y83d7AhH7Y/w1Pe9U5xNSZvYn+p5X6cswyMLdfE12Bz?=
 =?us-ascii?Q?ZmSX1dphSzuZoF24XGlelsmOXSrRKeWn+PYShLrMCEziFbXJUIUyoPVQi0Ux?=
 =?us-ascii?Q?eWPdVDUWpOVXuuYBRgsZxSF6S1r68N17CrrS0EV5xBYPIwOWRjBLXc/2UMTr?=
 =?us-ascii?Q?jzPSknkaPR3tc0yMapd7CD4OkyXZzn0t1akJlRL0TOXTcKsTaYZ+h6LpokX+?=
 =?us-ascii?Q?ONoT/myDxvFO35Gz41MoSgkSXG8XiMkCqWuIW7pXmfUu0Vivv4caIqxJ7Pwj?=
 =?us-ascii?Q?DDMTuAZYdtM5Gg8+7O+r0xr+7RlkOnF752k9imNRm+3fYPdk9c2lT18H+PS3?=
 =?us-ascii?Q?3caHGZmM7Ztnf/p6fnws5nT3GAN0Y5P60ek+W4EE0YjKmxlIyUlRL2DY0DaT?=
 =?us-ascii?Q?HuFcmHChvawrm9zcwzv+hSTpKroghkP4g6w5+vhBLqbZOuuT1QcGAPO+VQh1?=
 =?us-ascii?Q?soVW1yGzwt+I7geuIE5uRssH/+3u?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 01:19:48.5307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ede5bb-13de-49a5-e6db-08dc63fca25f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949
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

Fix some variables not initialized before use.
Scan them out using Synopsys tools.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/atom.c       | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c  | 3 ++-
 6 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 59acf424a078..60d97cd14855 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -742,7 +742,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 	uint32_t destroyed = 0;
 	uint32_t created = 0;
 	uint32_t allocated = 0;
-	uint32_t tmp, handle = 0;
+	uint32_t tmp = 0, handle = 0;
 	uint32_t *size = &tmp;
 	unsigned int idx;
 	int i, r = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 677eb141554e..13125ddd5e86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -410,6 +410,11 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 			else
 				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
+			if (amdgpu_fence_count_emitted(adev->jpeg.inst->ring_dec))
+				new_state.jpeg = VCN_DPG_STATE__PAUSE;
+			else
+				new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
+
 			adev->vcn.pause_dpg_mode(adev, j, &new_state);
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 72362df352f6..d552e013354c 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1243,6 +1243,7 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 	ectx.ps_size = params_size;
 	ectx.abort = false;
 	ectx.last_jump = 0;
+	ectx.last_jump_jiffies = 0;
 	if (ws) {
 		ectx.ws = kcalloc(4, ws, GFP_KERNEL);
 		ectx.ws_size = ws;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 45a2d0a5a2d7..b7d33d78bce0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -999,7 +999,8 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
 	r = amdgpu_ring_alloc(ring, 20);
 	if (r) {
 		DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
-		amdgpu_device_wb_free(adev, index);
+		if (!ring->is_mes_queue)
+			amdgpu_device_wb_free(adev, index);
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 43e64b2da575..cc9e961f0078 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -839,7 +839,8 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
 	r = amdgpu_ring_alloc(ring, 20);
 	if (r) {
 		DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
-		amdgpu_device_wb_free(adev, index);
+		if (!ring->is_mes_queue)
+			amdgpu_device_wb_free(adev, index);
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 1f4877195213..c833b6b8373b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -861,7 +861,8 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 	r = amdgpu_ring_alloc(ring, 5);
 	if (r) {
 		DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
-		amdgpu_device_wb_free(adev, index);
+		if (!ring->is_mes_queue)
+			amdgpu_device_wb_free(adev, index);
 		return r;
 	}
 
-- 
2.25.1

