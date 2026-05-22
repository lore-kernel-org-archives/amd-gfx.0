Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C0DCD5BAF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6EC310F490;
	Fri, 22 May 2026 00:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ezmOpyUo";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011034.outbound.protection.outlook.com
 [40.93.194.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10C1210F487
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X68JABUF85iOz1Lw5FKnMgaVjLMBwkbn2I8PES8Nl85/a+FVYnbjxgV5FcXs4/ZBXuI+064HV2vsdKiZK8SdlalyuzjeRRo4hgK8eZiVR1+jQDaP8SU4uw2UzaDIe1m7wx7LnTKYIRX4owoJ29A7pmpSX1+GJa9qKZz08aG8AcjP7bad8nvaKcBiIlgHZNcR7c5ZpL5SyK2BMMwUEqVptXHjiRryN4tFy73TpMpTct6OpeMURedxGzS7GKXu7+xIZB4qoKi5pcvbjb3cbuEVaJOHAPEHbylAWluQ8LrIClrfTPVTDiOGK358he2B5uE6/yqEES97COfzOOZZk+0RxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZeWV+M245BoPhMQdRIygqGjMqR4QfODE1o+sI/EJhI=;
 b=ajXM/QuXkKnAost+wihf0/4zobPd6QMS4E9W66xzG88m2WmDfHJyng1yacG1sdyzgSmLY9uRIxq5/1Mbq1myLjF9NvVHsY3TjIlrAe05qXoNqeaa0MjeDvH4ohr5liLmTMu/nBrf9CSTl6hfueD5mXAgAlMX+LXrYjpS2yKXAVFCq7e6SuJKEzzBoTNSZnJFjM46edQsIBV6t64/0+3g/kv2QZ1TlnB99gvKqsB34eujltOe3e+x9PDIbccFnoGnovRXcBSN8uZMR///28mEWFjmelMMA9y99RIFWU2kP5HPNc1//xgB+PwtzxEyyYm5EzImoIGBqZ4FgVzbdAdzvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZeWV+M245BoPhMQdRIygqGjMqR4QfODE1o+sI/EJhI=;
 b=ezmOpyUoCamMz3TmsxgzEfEKZCWqJ/kIMKkBebLpXmv7T0k3H53LuBCilXkqb7BymjQ6QK/WIqynrBRIHI0SXhVvfusN7Eaad3kRkaLgwKrIPBIa15POd9MN9tUAikutugcnnPYd6+5UVchXwHwVLlfQ97aOZVjzQJcOZ0kjqo4=
Received: from CH2PR15CA0019.namprd15.prod.outlook.com (2603:10b6:610:51::29)
 by DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Fri, 22 May 2026 00:22:16 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::48) by CH2PR15CA0019.outlook.office365.com
 (2603:10b6:610:51::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:22:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:22:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 21 May
 2026 19:22:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 May
 2026 19:22:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:22:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 33/42] drm/amdgpu: Use a common KGQ and KCQ reset helper for
 gfx11/12
Date: Thu, 21 May 2026 20:20:39 -0400
Message-ID: <20260522002048.98506-34-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f3433d-c26f-4698-04b8-08deb7982dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: mTVIbi26r422sp11h/LCgIYj3ucnTjfh625YI7P7lXT7NAlOyy30s8qIb76bWZmxI6GkzXM9uhnRSEeBMqluVLCZC+LQX7t5RbXbpyOH/sZ3QuhQ38SkMbBji33VLJE3fqY9+xTjaLEffLIlf4Eip2mUhZoAgwoyRc3vteYK21Tw59ncYV4V9QEBu6rj3fLY/92GTuFUNgrPw+nCCa0PoLKxlrYn9cRGh8KWMr6BQVfCrEv59cF9A0OW1SYB6LIzXHRj7XVe47uRU/q9KeERDKdg1a/gpjR5TAqibGqSA9iSvIJw8atEAE19AHKwGxQZLwHHsJKRJzC9MXeKbh91Wcc1OGQq9ehwewPAU2ycDNaeuwbsfoR3Gtg/ITECYe/NomKb25pZizSMH3h7wrGyQKZcMu8X8X+D5f0/Hl2cs/E/e1/HamnY3ZhPD3kLcFJyK+eBzGTkLOSptGOff8Eo4dpES6qC2huvD1ku85RXLemIrrUw9e/kUYzS2EZKEjRSR73pSOmKL2DKq3AIrqMfSiUCRTc8ty1a/XYz9Klt7uvBZMkqqsoz1JsbQzvY8TSadS3RYG6kZs36q+NDcVI1OwVKi5rEqzHuOPqWJjCJMlS7rFFpyQ3XyvWXdYByCI+Vfs+51H8IKWloIFbRKvEAch/8p380iu47mNlgRCVOtxKXaS2RKFeVz4o+UqIEr4YAPxPZ+XFsKWQtCvMryHwBrAVQBF077tDLJwKgZD70mT4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L1Gqxx4mlc3Uozgus0NFHalemT8tEAMYRefSI87VsIiiEGHwo1+lDnvlM41qEVawGtU/IasbTRndkvJcNHlkAsRuXJ+78RV41I2FqLP401vmuf+8WDOX52vtWZXNOZQW9OecAqqw42TJdxBO2yfJmSvQ01kzWeIaU8pErj7Ob1slkdQXeJR+HcZctQ3VBJuUEKVJmPqpNnbpNlkmrL12GxabpfZo6Ye00wy52Yo9/8mTff+gef0twowcKPJGM117VMSA19fWYfnrV/8GkD5Y8RSCqP+OpDAEt5JrLCkfhVLQbr2fazAytyzW3oDGKOSU+pgxIy278+rXvGgNB7kexUJtNfkH5rTI9eqcvV9otxvaMT/e1S6Iafg4l8LmlOMHefsdsyAXz35cFkvQ5Dg8667iNcY0YPborQycKjmDQgJQakbpThVbXVVazY/mZlQI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:22:16.6128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f3433d-c26f-4698-04b8-08deb7982dee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464
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

They are all the same so use a common implementation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 33 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  6 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 46 ++-----------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 46 ++-----------------------
 4 files changed, 41 insertions(+), 90 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index aba21afd2b32a..de8c85dfc4c62 100644
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
index 22fb90e229dd4..f9175faa64ab7 100644
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
index 50d3990a00c30..1a214c274ad02 100644
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
index 03b1fcc046552..5beb0ae980d0b 100644
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
2.54.0

