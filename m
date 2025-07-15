Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95306C83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 16:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 259AB10E604;
	Tue, 15 Jul 2025 16:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BRaAoA98";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA0D010E38F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 16:01:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vqk5D2hWEde6JtgN3iEk/C+7gq68RKTb6W0oOwNJVfzChEc7iK8EpM6V3KzufhMg3aimkxOopkSCxrPDwJoW02shtTDoxCPXC79fP98tEv9bHzxLPmzoEX/XYGIbWQT8hajBEbyrPaXnAXuQBpM3DI+1sahnrgIyEkVO1J/6d2kmU1URnXcX/3pYKFOdCpKcemqyoZRFjrAlfxs8n4fLNHC91o5DS5Lc83TTSmtqe41Je9cXAcVoaVfEhg11HtB0E0HSeVvGEvVTNRvc5R0Wy/R16EKX++fHAHlLQ6JSr8OCK7NCK7dJ7polgMNFUiAuNV+IVnUVwK3TAvRc7iauPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VO9izBu+Tjl/31O6JaHhe71Rz6aRRQZuM88lUrjBrgY=;
 b=jB5zxhPQbCHTKhelhb55FrHy59yccO0hma5v+2Tym1/mosqAgM27FbWcf3BUFTO0wO5/kCn7igEhePVzMBaYGAKyo51IfRu85YWoxYvDi0piQa8GwxbiRWlhll7W+Ffytm4PzU0O3EWuqiK3C7PiOsmsjv2aKEjFdBFh26+Pd7UzOUNuIGFAjbRFRKCI4Swg1hF8Ext3pb1jAxDNO0B9++KPicPuxHVqErgYE4/d6hUz+4btTn9hVMEydkNIhySlJowyeLpQYWZw2FU/t174HAgyBrT2QItn7KNA7iW3TPH/MYb0ShZgARsooPTMUy6NHCJhyceiG9ClZVaG60iGfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VO9izBu+Tjl/31O6JaHhe71Rz6aRRQZuM88lUrjBrgY=;
 b=BRaAoA98wKvxnvuliH7bjiT7Ax6QtDI0yadjee++tGmjEfPU6ighOnAh2dYwg3k2dGgupCMkhezcSnkmjzt8txBqQbcRixhcF/1BhbCNz6V692mqqb09qZY6cdgQwej+Wh7YoTpd+9QDsPn61RRrTFExyLQxtBtEwphya4iwbsU=
Received: from SJ0PR05CA0210.namprd05.prod.outlook.com (2603:10b6:a03:330::35)
 by DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 16:01:10 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::4d) by SJ0PR05CA0210.outlook.office365.com
 (2603:10b6:a03:330::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.16 via Frontend Transport; Tue,
 15 Jul 2025 16:01:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 16:01:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 11:01:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/jpeg: clean up reset type handling
Date: Tue, 15 Jul 2025 12:00:50 -0400
Message-ID: <20250715160051.533747-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|DS7PR12MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f880164-5985-4280-d4bf-08ddc3b8cfee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LYswuE792VFuatsC1GuDrlqStr2qBAAfDbiz1AhMFyn5qqwxPfPol0pQnBH2?=
 =?us-ascii?Q?y+Ha9WUxcLA+xKBnT/lX/VB/opwgg1/w663QFD7w8LL6x2QVbHZqZq16YiJY?=
 =?us-ascii?Q?bU5R51irOWM0jrPAVCy7tYulJfUQGiI7wT2fDZ4e056qBXM56dPDnYEc8hsh?=
 =?us-ascii?Q?QcUKq+SdrG+yN6KvGaW5QfRjtdHILjW4boIYUKMtl1sQtjWVZ0RI06a9bA+q?=
 =?us-ascii?Q?tdkkUPN1clSMlLsEHW3u5xLc5UFwmlD6yleH/M255xXh5MQ8Qk+9bxmKLYPK?=
 =?us-ascii?Q?jLHpSsqvtKGFeOl9Ca0aG1ZoyibXeo85fXpPDdiyDbyyZFbh6Df0NfCnNUtL?=
 =?us-ascii?Q?f/VIsQLagSlTMTwWahZkslSReTAWIe+nsOXLBeoiwQxub8sc13wJEFNmhWZ3?=
 =?us-ascii?Q?GlSyj3o51VmrVRB05wmNA9Yf2rUYRTL6BcFRlI1FONofWIrIeTvzW6nSMLRV?=
 =?us-ascii?Q?fPh9KgG1bHr4BXX/oZW52W3P/BvCKzO63cakxGrO+ndUNmDgx2oyQME65qAF?=
 =?us-ascii?Q?uSWkcmTKS1wPS+gpV3LopUCiGpoZWT4IJok/IfiaWOMuuoCpqNJoHHYB3sFQ?=
 =?us-ascii?Q?wvJUXx3UXiL3dgSrJ27IXtefq8epHPSALmwfbYQRaGBNUwMkSuXoHYj467WG?=
 =?us-ascii?Q?b0Z69CrhRF2M13K5OkmTCqpqtwFXiPkklChPcNBCLOpOOv0IKOu3yuRcPlaY?=
 =?us-ascii?Q?ITwiZ5tXkIDHK3YOdPvJXYXrh2YRQ3dfQkFdzPpOiJRjvAOv9A1YTl7RjL+e?=
 =?us-ascii?Q?L9lOqt9B9IgHXWHEZ02YtdChyZpoCCn/f9pTL5z0nvvOuXKvp00K2tk49/yk?=
 =?us-ascii?Q?6mnebHVL/0q6/gQrICdiDxUUg1FoFW9AU/M80oEg0G4aR811WkXSmj62+lO2?=
 =?us-ascii?Q?r4L1+qqMvKmftdwFfQMJFxFNo76pbkjFHproIB9WSM93bW06aC+DOKX0QAei?=
 =?us-ascii?Q?o0CgQNv2QT/ie8jS4vBHvOifDEGadRYWlcC7u+3cpzG5Vrp0su4QVU7K18vu?=
 =?us-ascii?Q?73HAwsydZ+2XKnYOlcMDtffn5GGQg+rWcP+Qv4GqFuB8ARGH6r1coQ6yqMui?=
 =?us-ascii?Q?w8eUAyJsr0F0bmSjzdM10AAlGZI4dX/Gv0740PEAfAu7ddoHJI+qVP5dRNpL?=
 =?us-ascii?Q?QTiO9euw/TTIzHXgZ6jG9AjMBFD47Y0xeqmJ4HlsrRagWouTWvZIzE/NXCOa?=
 =?us-ascii?Q?0qtDZ/aroHhIhpUs+MXPT4K/LdiZEhKn2T7FrIs9UZzLzg4pMVJTn/IR0i07?=
 =?us-ascii?Q?uhPPEBk8FtwdXhf7HQtkZ0oja8ZS9T4kZa+jANIsyj7g1H/6NmRGUgzv4bsr?=
 =?us-ascii?Q?BlL44zf7OPb1qutHBeQSpdf7uQ5sH1B/j20Hthk3ademVM8KjhCEKkVAG/lk?=
 =?us-ascii?Q?6X26GzCgKNSNs/ruUk9LlrKDYfr1UDhYuqe6HePRGxDRTxZQxTfJSvfVFS6L?=
 =?us-ascii?Q?KNKoIG6+arjRD7Be2YUb/LS4jQsDmxfl3gmAF49so0VxJ2QmJnJ/xgXKgqIk?=
 =?us-ascii?Q?FTrn31NzaxpVV8XGHEi9BRCb5K/r5yfQ/c+d?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 16:01:08.4147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f880164-5985-4280-d4bf-08ddc3b8cfee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9474
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

Make the handling consistent with other IPs and across
JPEG versions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 14 ++++++--------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  7 +++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 16 +++++++---------
 8 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 554af4b9930e3..b93d6af8f6e54 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -118,8 +118,10 @@ static int jpeg_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->jpeg.supported_reset =
+		amdgpu_get_soft_full_reset_mask(adev->jpeg.inst[0].ring_dec);
 	if (!amdgpu_sriov_vf(adev))
-		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 4e489a7e21157..b6d5ba0bdc143 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -167,8 +167,10 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->jpeg.supported_reset =
+		amdgpu_get_soft_full_reset_mask(adev->jpeg.inst[0].ring_dec);
 	if (!amdgpu_sriov_vf(adev))
-		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index d4bc4fca460c8..a229d7eb900c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -132,8 +132,10 @@ static int jpeg_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->jpeg.supported_reset =
+		amdgpu_get_soft_full_reset_mask(adev->jpeg.inst[0].ring_dec);
 	if (!amdgpu_sriov_vf(adev))
-		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index ca3debe371c5a..f3a9073b8b243 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -143,8 +143,10 @@ static int jpeg_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->jpeg.supported_reset =
+		amdgpu_get_soft_full_reset_mask(adev->jpeg.inst[0].ring_dec);
 	if (!amdgpu_sriov_vf(adev))
-		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index c3f73a2a911b4..b86288a69e7b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -216,12 +216,11 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	if (!amdgpu_sriov_vf(adev)) {
-		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
-		r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
-		if (r)
-			return r;
-	}
+	adev->jpeg.supported_reset =
+		amdgpu_get_soft_full_reset_mask(adev->jpeg.inst[0].ring_dec);
+	if (!amdgpu_sriov_vf(adev))
+		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 
 	return 0;
 }
@@ -242,8 +241,7 @@ static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	if (!amdgpu_sriov_vf(adev))
-		amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 
 	r = amdgpu_jpeg_sw_fini(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 5a69a44e0f855..1892c278ea3c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -177,7 +177,7 @@ static int jpeg_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->jpeg.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
 	if (!amdgpu_sriov_vf(adev))
-		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index d6b565c29b4b2..0b4de0c6476ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -123,11 +123,10 @@ static int jpeg_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->jpeg.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
 	if (!amdgpu_sriov_vf(adev))
-		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
-	if (r)
-		return r;
-	return 0;
+
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 5473cbaa5c0e8..e622db1f818bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -200,14 +200,13 @@ static int jpeg_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	if (!amdgpu_sriov_vf(adev)) {
-		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
-		r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
-		if (r)
-			return r;
-	}
+	adev->jpeg.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
+	if (!amdgpu_sriov_vf(adev))
+		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
 
-	return 0;
+	return r;
 }
 
 /**
@@ -226,8 +225,7 @@ static int jpeg_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	if (!amdgpu_sriov_vf(adev))
-		amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 
 	r = amdgpu_jpeg_sw_fini(adev);
 
-- 
2.50.1

