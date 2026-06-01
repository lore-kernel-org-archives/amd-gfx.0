Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72533CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 101DD112DD9;
	Mon,  1 Jun 2026 05:54:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ds2l2u3s";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C46B112DD9
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:54:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhlqRtRbfvONuq2kVzmwoX7qiu7VtMgaKvPzPnfW4A+jh/2SAx7x90ZBf2G5Kmrrr5wvK6mdMn0WtVWW7vuAIXO59+i51EDE3CPNphcL6cciyaBMcXCcCq+f7zCrZ8VG2YtNmafxe+9ioGc3vwlTsDNLLuAYqgay2Mh5/jevRh4F6widz2ydw0Sgmz8Rnhu/yU21vxpefBpTj/uC9yPgy9wqoSqTJ1tFCYBRVi9FA1M2nXGkETnpYxihyS9/hVZjj9lRQsJ9M8A0WE9bdhQBOb+JQYnr18cphY2a+va6gU7TQiUZR2MRtgJSXlcrDmtzM8ZgJ/7uDJdbWtydfUXP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrhD4VI5LO/wArIUXUHcgumHvSSUMHPG61M5lsVi4cs=;
 b=YOCO/5mYXKhQcAdEjKYlCWNduKVqktPIRpL+XVwHITeQSeWyjuf9GMnBO3cgC2Zc3G+6VlH+zWHs9nmkvM0t6PLnlpYOvCibVvb7HkcYWr0JeRWMaxHpg7X+AVyW1X/NCavxpvmoTj8HwqGqkY+CZEqXe4OqLoL2kYy++b35AqZhRO1iCijHDv5KpD4sy8TyfuxeJFTGJHk9LbLT4lthYZzYA9USKgVnayspJstF1g3kv7l9Hdqj6BS79xeHS8AYZwjl2OlZxCqHeGRdZJoreyJkzoEAwwlQ5ngGdkpN1R6+SU5Lr+pPw0QJQvYZxqJuDQhvk64tPSPbY0L4HSuyhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrhD4VI5LO/wArIUXUHcgumHvSSUMHPG61M5lsVi4cs=;
 b=ds2l2u3syPE58hwORPvgY9RLw9OqkL4GeSsM2zoLzFuAak/K7hbqZ8gzKfk478PMGuoGxKHJka/lAFqorTrtWtcWG5rvY+g2U2nUegnRg1zfrizIbE6IX+XPqc5qT0amUZ9E/jCQWqcswvqshpIYlM4rwfSDPD0c8Ot3NiJwLio=
Received: from BN0PR04CA0171.namprd04.prod.outlook.com (2603:10b6:408:eb::26)
 by SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 1 Jun 2026
 05:54:41 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:eb:cafe::ab) by BN0PR04CA0171.outlook.office365.com
 (2603:10b6:408:eb::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:54:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:54:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:54:40 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:54:34 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 33/42] drm/amdgpu: Use a common KGQ and KCQ reset helper
 for gfx11/12
Date: Mon, 1 Jun 2026 13:49:19 +0800
Message-ID: <20260601055034.3700921-33-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|SA3PR12MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa9b857-86c7-4d6d-7e19-08debfa245e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 6uBNQLB4GWWPtKanmNEkOx2rHrrgmBORzNcOPk9siJvu6y1Ul7aJ+/gsIcS7sezifWHc1W1UsSoLFpjBPV51V3WutgG7RGcxZeya+woKyPrNvvNd+pE0QVmqFZv/xBNQePEH1ganb0CAAymDZ/3WTutPIHxHLH3uMfL5lz5UaeEoXLzZYyIWkDuIBN0KyheTsGx+dWhMxWetXlk9Y0yp4uOAnc1mDT7VAx+l6N0V60q+CLqwxdrbY8HDixSoaQdgxOhxXS79WPaFuVKfSo3CGymrRIT/iS14j9tVIGsDpDMVIPtrd22IigTNQChwhMTGIzEVr7JysJwVnUrggLjoVpeOgcv2uyrDHmKcYfLSR0mKywNgPUZ/vhEnB1MfDQoLFXBHqfeiN67iLNa1wNitGpSkE6TX/YeK4m4vQqgc9OafkPtXw7AWwhT3Z1qp8bJP6MA2Koz60vcQZz5xZYwOIaHqOYZvpaxOoY74Ee4iWCWPqSGYyzqtyiCjVNN1dNuPH8juiGT7gEpstOF4J+iPEGq3bfCLyOmnzSMbt8sRWtKsaFIfbEzCdQV6MV/1jH3bzi8lSUWXb5TCEkFMKlCTA0WGEo4bCbMw9G1SaKHe1dm9EdazN4CBGHPIuwRELs+wz33oIytFF7CDemP1GjCDjFYwK9/DQO6cq3nDp215yHnlX4fOgYcAIcmqHmjZHimB7ACxsklSHZ5Yyb12pMA4Lf3HMn9WiDD93/393iqnBIY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y+JKs9TbLmXIDbIVMDlAVeGKq6r74QOrViTXd9hX4TB/yTl6cN7HyqKZfVjX5DlrutcaxEMUAFXWFhX6cEPHXLH5lmRB9BDV6BhLViUnny/vAJCaak9iP+mpmRluQGYY7UtUQ2mk8SXi/szkNjA0h7EZCLZ+YoIlWCMraCvQ8vlH3ShWUfSRRTcEoKLJjvarndjunIyOd7KDcToCss5z5tHSMER7pxtc+UD1KUuY5XcZDa6ppWAcdcc22xLF9E0vvRqa2/GckD2wqEOtSAo9dwKSQWvNGEHl5MTbhG1TJp80G7FawECUHgWIwrtHqZOAH9g7XbdBeFEORwk1XjmUYUI2dIjh3ySEXKwUnVAd56GElTMMsJAccPfqTp1HQ1k9MLQKijxLQ19RkPh1yKwd9r04MYQCfxP+wLU3GneE4qvHUk4oUOMv6JCTVOwU8dOh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:54:41.1048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa9b857-86c7-4d6d-7e19-08debfa245e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8761
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

From: Alex Deucher <alexander.deucher@amd.com>

They are all the same so use a common implementation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 33 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  6 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 46 ++-----------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 46 ++-----------------------
 4 files changed, 41 insertions(+), 90 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index aba21afd2b32..de8c85dfc4c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -377,7 +377,7 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 	return 0;
 }
 
-void amdgpu_gfx_mqd_reset_restore(struct amdgpu_ring *ring)
+static void amdgpu_gfx_mqd_reset_restore(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int mqd_idx, mqd_size;
@@ -1970,6 +1970,37 @@ static ssize_t amdgpu_gfx_get_compute_reset_mask(struct device *dev,
 	return amdgpu_show_reset_mask(buf, adev->gfx.compute_supported_reset);
 }
 
+int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *timedout_fence,
+			       bool use_mmio)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int r;
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
+	if (r)
+		return r;
+
+	if (use_mmio) {
+		r = amdgpu_mes_unmap_legacy_queue(adev, ring,
+						  RESET_QUEUES, 0, 0, 0);
+		if (r)
+			return r;
+		amdgpu_gfx_mqd_reset_restore(ring);
+
+		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
+		if (r) {
+			dev_err(adev->dev, "failed to remap kgq\n");
+			return r;
+		}
+	}
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static DEVICE_ATTR(run_cleaner_shader, 0200,
 		   NULL, amdgpu_gfx_set_run_cleaner_shader);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 22fb90e229dd..f9175faa64ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -588,7 +588,6 @@ void amdgpu_gfx_kiq_fini(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 			unsigned hpd_size, int xcc_id);
 
-void amdgpu_gfx_mqd_reset_restore(struct amdgpu_ring *ring);
 int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 			   unsigned mqd_size, int xcc_id);
 void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id);
@@ -669,6 +668,11 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
 
 int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring);
 
+int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *timedout_fence,
+			       bool use_mmio);
+
 static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 {
 	switch (mode) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 50d3990a00c3..1a214c274ad0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6784,29 +6784,8 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	bool use_mmio = adev->gfx.me.use_mmio_for_reset;
-	int r;
-
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
-	if (r)
-		return r;
-
-	if (use_mmio) {
-		r = amdgpu_mes_unmap_legacy_queue(adev, ring,
-						  RESET_QUEUES, 0, 0, 0);
-		if (r)
-			return r;
-		amdgpu_gfx_mqd_reset_restore(ring);
-
-		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
-		if (r) {
-			dev_err(adev->dev, "failed to remap kgq\n");
-			return r;
-		}
-	}
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_gfx_mes_reset_queue(ring, vmid, timedout_fence, use_mmio);
 }
 
 static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
@@ -6815,29 +6794,8 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
-	int r = 0;
-
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
-	if (r)
-		return r;
-
-	if (use_mmio) {
-		r = amdgpu_mes_unmap_legacy_queue(adev, ring,
-						  RESET_QUEUES, 0, 0, 0);
-		if (r)
-			return r;
-		amdgpu_gfx_mqd_reset_restore(ring);
-
-		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
-		if (r) {
-			dev_err(adev->dev, "failed to remap kcq\n");
-			return r;
-		}
-	}
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_gfx_mes_reset_queue(ring, vmid, timedout_fence, use_mmio);
 }
 
 static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 03b1fcc04655..5beb0ae980d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5220,29 +5220,8 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	bool use_mmio = adev->gfx.me.use_mmio_for_reset;
-	int r;
-
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
-	if (r)
-		return r;
-
-	if (use_mmio) {
-		r = amdgpu_mes_unmap_legacy_queue(adev, ring,
-						  RESET_QUEUES, 0, 0, 0);
-		if (r)
-			return r;
-		amdgpu_gfx_mqd_reset_restore(ring);
-
-		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
-		if (r) {
-			dev_err(adev->dev, "failed to remap kgq\n");
-			return r;
-		}
-	}
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_gfx_mes_reset_queue(ring, vmid, timedout_fence, use_mmio);
 }
 
 static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
@@ -5251,29 +5230,8 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
-	int r;
-
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
-	if (r)
-		return r;
-
-	if (use_mmio) {
-		r = amdgpu_mes_unmap_legacy_queue(adev, ring,
-						  RESET_QUEUES, 0, 0, 0);
-		if (r)
-			return r;
-		amdgpu_gfx_mqd_reset_restore(ring);
-
-		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
-		if (r) {
-			dev_err(adev->dev, "failed to remap kcq\n");
-			return r;
-		}
-	}
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return amdgpu_gfx_mes_reset_queue(ring, vmid, timedout_fence, use_mmio);
 }
 
 static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
-- 
2.49.0

