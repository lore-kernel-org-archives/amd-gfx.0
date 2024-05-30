Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20723C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 14:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72FE310E22D;
	Thu, 30 May 2024 14:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2dFglvAx";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FFF710E22D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 14:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBEdxoz1SAa68sGThr6YEBUD5N2qBa9W2aDj2OBpRQqt/tGRY5YAqZVLhkn7E9tGhXS4STjlH9kYI+1wEhsaG4P7e7VfK1Ql0KldvQu+xNQ0GlVD19Q2J4uWFgk8Fc+FEOzVGppFtlcNGykDc8tZUdR05X24cgr3UfxxvGxsT9NB94ZQhp1Rv1QGHZh2D3cn2T6QFaca8lySh3GR7XJEGzHhGAPYRsQ0GN78YqimHKJ+ezOmVNcISJumnv8cwxg22bCbm0N8id3Fm7zKU0TlXMpbcCfcEeU6aRztyH+jIl7QCoGnj9K++eh1jI8VuCgM32XnO/DI742o8WARztQSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KN/b5XL6ch7PuxA9Vb108y9NA3PGFscToiJDPv1VH0I=;
 b=KUUKq2dLH8rkBMU7o/TY9UcR22Fcveb5k+0wcrk29B7AWICLtgK49ed3Gx9lJRM0q82IYEQJBGDVPRu6xjSPcOzn1IFx6mwPME+ErqkC4RVgzHCwGm6i0+4ptAkCQGYpOq9shHXC9p2DO+9lCUaFmZIPaescQFbeZIQbXoGtxf22C9sn6yUOYnYQA+PBWAiR0GVPxi0/fONe1sOAIg3EuoxUEgUitbQ4y2/Wxm7WSGnw+OSWCM5bT7vvrJRpQI8EHi8wvYBnTuwJ9/hPS6gdKw9UV2oIKbChqgY3vi5/idUamWE9v411BDNspn408cE8uiI9VrSdHdxWNxkWbn0uwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KN/b5XL6ch7PuxA9Vb108y9NA3PGFscToiJDPv1VH0I=;
 b=2dFglvAxAexEhb4D7AavO54/J8CoAZTcszlLTSNuJvpzoY6hdzPIDn3QfuPyK4NScNnrlIPmaYLa4kRX7jm2lnT78W7koI8D/yQyr5d6hT8KOI+n0hF+E/P1I3FMbZXTIn6GohR0f4t+HDNuBYq9TndLWLzeNbuENV+QUk4gmvw=
Received: from BN8PR15CA0033.namprd15.prod.outlook.com (2603:10b6:408:c0::46)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 14:59:10 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:c0:cafe::47) by BN8PR15CA0033.outlook.office365.com
 (2603:10b6:408:c0::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Thu, 30 May 2024 14:59:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7656.0 via Frontend Transport; Thu, 30 May 2024 14:59:10 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 May 2024 09:59:09 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH] drm/amdgpu: drop some kernel messages in VCN code
Date: Thu, 30 May 2024 10:58:58 -0400
Message-ID: <20240530145858.4022206-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b3d6d2-4255-4e13-a1b6-08dc80b90ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JsrjHMs8N2op0U/xICYk9sLwbwe1qCeaQjpPThhruy+fPfWwA2Kq7YF0MgKC?=
 =?us-ascii?Q?UY+jSY771PyumiaQ3Dx4mVs1GQDfXPJS1VjAXtCFm43ErgrTz+p59/yoXu0Z?=
 =?us-ascii?Q?S/+X97qdB5wb9NtK0Z/PX8KsS6JTx9NJwDQcvALlL5acZMdDv31QkuYjpzq3?=
 =?us-ascii?Q?NjbN/E1qiV7i1FA3MBszFUlMRveiFYtql85LkOvtmFOLKUGRUVE0eCZ5DyTC?=
 =?us-ascii?Q?jviBhrivDtXVsuF79vDhkyCD/HsjCrRvTzqFrE26pBQMMhYAbyYiBcr70nMO?=
 =?us-ascii?Q?xXPPYnou1NhwYakRiCXkm4br9DaA5bJAZ3uCNGqyPehV7MMojUzLPJbH6gb2?=
 =?us-ascii?Q?Yq9QKXVAEAQRuyHcsdFPJWOHcV+85T3g2C7JiA9T0VS3aV2eGSfGp7e5vIGA?=
 =?us-ascii?Q?8BAxX2uzg5zkAByNZXa6fly2NP5MWHQ6mnZUjhXNlFt1znuVmlMAxjTkegmu?=
 =?us-ascii?Q?5ahKNIsuanShU0rWuhGfyTyXzwtZ1sFsRUB0ztHWBNTeSXCrK4z7WLvDuHW+?=
 =?us-ascii?Q?RP4N50pOjA+C7tlWztPg+hoTW/CnHAVwCWastgnNbh1SpZbTbvyoI43/57KI?=
 =?us-ascii?Q?4BqhnUcULl0d3F0DqXu6AF9hNubVf2mrSZyafscuo/GcPU3Jq1T6J4fgvPI1?=
 =?us-ascii?Q?wlncwN1pM4BzlV/2iI/VgwiKpzPEuwfsIoUt3VqK109rNapcRR10FmWtgQaw?=
 =?us-ascii?Q?EWakts9+GwUBaVjvteRUVcI2k9YA/HnjVV1p7zbnEMutXcjgCZSn9htPNr3Z?=
 =?us-ascii?Q?Tzm8/acaIiqr+0ucH2A/dO6YCh22UEYgMaf/y/1mbxUL4td+OEeyK6YtV4da?=
 =?us-ascii?Q?MY7L7ksxjiPiH8uQr0BYhiehRgIRbcXc9t2G6bRwEh3aV26bMKm6JT5jDeNA?=
 =?us-ascii?Q?RhvRP3MB75R59PDgxNb+h2VFwu/UniMRlAHkttI+C7FYvO0L+/d72y/Cjoeb?=
 =?us-ascii?Q?7f6EvkbTw4cpu6Bfcx+/N5yo6ynlGW4VWDckcjk9mvkBuquwrjf7rnlslmDo?=
 =?us-ascii?Q?lntxBOouR2RME4m2wTzf8B20KKNwDGVfiewVJ63zY8rydUpRETL1xVao6zp7?=
 =?us-ascii?Q?5KbKJazz/BHbecp/Fvrey0pA3AFg/80dzPuTR7H7VyKS9B/WTW3o8TemW35z?=
 =?us-ascii?Q?f7tkKmR2zSiYyQ+5lCZuPIMWPK4mj5OvJGZHsOZxoDuj2phSJqATabpaE7le?=
 =?us-ascii?Q?yfja+RYTdSauAJGNLTITehXK20414dyKUAp6ZIxK+Eli7vTgXGM9/+jqC7Tp?=
 =?us-ascii?Q?qjqwkj4r1Mc+a+WYyJn6ycdnOjPJUgyZ9V2Cx5TPQXtI9neE3iJn7jsWsdoa?=
 =?us-ascii?Q?M/c4R59rRrOwKRPd9INVtruUYZFeEUkvrmDxYouGujygZQY36DV8/ozysd8a?=
 =?us-ascii?Q?jT+8qnCK0O4weDGAwyAGtHK+CyNm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 14:59:10.4097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b3d6d2-4255-4e13-a1b6-08dc80b90ff1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
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

Similar to commit 15681da214b where some kernel log
messages are dropped. With this commit, more log
messages in older version of VCN/JPEG code are dropped.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c   |  1 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  8 +-------
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  3 ---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 10 +---------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  3 ---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 --
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  5 -----
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 14 ++------------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    | 14 +++-----------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 11 ++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 16 +++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 14 ++------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 10 ++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 10 +---------
 14 files changed, 17 insertions(+), 104 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 77595e9622da..71f43a5c7f72 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -581,7 +581,6 @@ static const struct amdgpu_ring_funcs jpeg_v1_0_decode_ring_vm_funcs = {
 static void jpeg_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
 	adev->jpeg.inst->ring_dec->funcs = &jpeg_v1_0_decode_ring_vm_funcs;
-	DRM_INFO("JPEG decode is enabled in VM mode\n");
 }
 
 static const struct amdgpu_irq_src_funcs jpeg_v1_0_irq_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index ef3e42f6b841..99adf3625657 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -131,16 +131,11 @@ static int jpeg_v2_0_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
-	int r;
 
 	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 		(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
 
-	r = amdgpu_ring_test_helper(ring);
-	if (!r)
-		DRM_INFO("JPEG decode initialized successfully.\n");
-
-	return r;
+	return amdgpu_ring_test_helper(ring);
 }
 
 /**
@@ -795,7 +790,6 @@ static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
 static void jpeg_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
 	adev->jpeg.inst->ring_dec->funcs = &jpeg_v2_0_dec_ring_vm_funcs;
-	DRM_INFO("JPEG decode is enabled in VM mode\n");
 }
 
 static const struct amdgpu_irq_src_funcs jpeg_v2_0_irq_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index afeaf3c64e27..d8ef95c847c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -196,8 +196,6 @@ static int jpeg_v2_5_hw_init(void *handle)
 			return r;
 	}
 
-	DRM_INFO("JPEG decode initialized successfully.\n");
-
 	return 0;
 }
 
@@ -728,7 +726,6 @@ static void jpeg_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
 		else  /* CHIP_ALDEBARAN */
 			adev->jpeg.inst[i].ring_dec->funcs = &jpeg_v2_6_dec_ring_vm_funcs;
 		adev->jpeg.inst[i].ring_dec->me = i;
-		DRM_INFO("JPEG(%d) JPEG decode is enabled in VM mode\n", i);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 1c7cf4800bf7..31cfa3ce6528 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -146,18 +146,11 @@ static int jpeg_v3_0_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
-	int r;
 
 	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 		(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
 
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-
-	DRM_INFO("JPEG decode initialized successfully.\n");
-
-	return 0;
+	return amdgpu_ring_test_helper(ring);
 }
 
 /**
@@ -593,7 +586,6 @@ static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
 static void jpeg_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
 	adev->jpeg.inst->ring_dec->funcs = &jpeg_v3_0_dec_ring_vm_funcs;
-	DRM_INFO("JPEG decode is enabled in VM mode\n");
 }
 
 static const struct amdgpu_irq_src_funcs jpeg_v3_0_irq_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 237fe5df5a8f..3dac8f259d7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -181,8 +181,6 @@ static int jpeg_v4_0_hw_init(void *handle)
 			return r;
 	}
 
-	DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
-
 	return 0;
 }
 
@@ -755,7 +753,6 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_dec_ring_vm_funcs = {
 static void jpeg_v4_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
 	adev->jpeg.inst->ring_dec->funcs = &jpeg_v4_0_dec_ring_vm_funcs;
-	DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
 }
 
 static const struct amdgpu_irq_src_funcs jpeg_v4_0_irq_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index d66af11aa66c..04d8966423de 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -341,7 +341,6 @@ static int jpeg_v4_0_3_hw_init(void *handle)
 			}
 		}
 	}
-	DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
 
 	return 0;
 }
@@ -1100,7 +1099,6 @@ static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev)
 		adev->jpeg.inst[i].aid_id =
 			jpeg_inst / adev->jpeg.num_inst_per_aid;
 	}
-	DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
 }
 
 static const struct amdgpu_irq_src_funcs jpeg_v4_0_3_irq_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 4c8f9772437b..f96ac6bce526 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -191,7 +191,6 @@ static int jpeg_v4_0_5_hw_init(void *handle)
 
 	// TODO: Enable ring test with DPG support
 	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
-		DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully under DPG Mode");
 		return 0;
 	}
 
@@ -205,9 +204,6 @@ static int jpeg_v4_0_5_hw_init(void *handle)
 			return r;
 	}
 
-	if (!r)
-		DRM_INFO("JPEG decode initialized successfully under SPG Mode\n");
-
 	return 0;
 }
 
@@ -805,7 +801,6 @@ static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev)
 
 		adev->jpeg.inst[i].ring_dec->funcs = &jpeg_v4_0_5_dec_ring_vm_funcs;
 		adev->jpeg.inst[i].ring_dec->me = i;
-		DRM_DEV_INFO(adev->dev, "JPEG%d decode is enabled in VM mode\n", i);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index cb253bd3a2a2..a280b9fecb77 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -202,24 +202,17 @@ static int vcn_v1_0_hw_init(void *handle)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-		goto done;
+		return r;
 
 	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
 		ring = &adev->vcn.inst->ring_enc[i];
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			goto done;
+			return r;
 	}
 
 	ring = adev->jpeg.inst->ring_dec;
 	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		goto done;
-
-done:
-	if (!r)
-		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
-			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
 
 	return r;
 }
@@ -2043,7 +2036,6 @@ static const struct amdgpu_ring_funcs vcn_v1_0_enc_ring_vm_funcs = {
 static void vcn_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
 	adev->vcn.inst->ring_dec.funcs = &vcn_v1_0_dec_ring_vm_funcs;
-	DRM_INFO("VCN decode is enabled in VM mode\n");
 }
 
 static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev)
@@ -2052,8 +2044,6 @@ static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
 		adev->vcn.inst->ring_enc[i].funcs = &vcn_v1_0_enc_ring_vm_funcs;
-
-	DRM_INFO("VCN encode is enabled in VM mode\n");
 }
 
 static const struct amdgpu_irq_src_funcs vcn_v1_0_irq_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index f18fd61c435e..d3d096909a7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -237,7 +237,7 @@ static int vcn_v2_0_hw_init(void *handle)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-		goto done;
+		return r;
 
 	//Disable vcn decode for sriov
 	if (amdgpu_sriov_vf(adev))
@@ -247,15 +247,10 @@ static int vcn_v2_0_hw_init(void *handle)
 		ring = &adev->vcn.inst->ring_enc[i];
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			goto done;
+			return r;
 	}
 
-done:
-	if (!r)
-		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
-			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
-
-	return r;
+	return 0;
 }
 
 /**
@@ -2074,7 +2069,6 @@ static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
 static void vcn_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
 	adev->vcn.inst->ring_dec.funcs = &vcn_v2_0_dec_ring_vm_funcs;
-	DRM_INFO("VCN decode is enabled in VM mode\n");
 }
 
 static void vcn_v2_0_set_enc_ring_funcs(struct amdgpu_device *adev)
@@ -2083,8 +2077,6 @@ static void vcn_v2_0_set_enc_ring_funcs(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
 		adev->vcn.inst->ring_enc[i].funcs = &vcn_v2_0_enc_ring_vm_funcs;
-
-	DRM_INFO("VCN encode is enabled in VM mode\n");
 }
 
 static const struct amdgpu_irq_src_funcs vcn_v2_0_irq_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index baec14bde2a2..96f60c303161 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -314,22 +314,17 @@ static int vcn_v2_5_hw_init(void *handle)
 
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				goto done;
+				return r;
 
 			for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
 				ring = &adev->vcn.inst[j].ring_enc[i];
 				r = amdgpu_ring_test_helper(ring);
 				if (r)
-					goto done;
+					return r;
 			}
 		}
 	}
 
-done:
-	if (!r)
-		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
-			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
-
 	return r;
 }
 
@@ -1710,7 +1705,6 @@ static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
 			continue;
 		adev->vcn.inst[i].ring_dec.funcs = &vcn_v2_5_dec_ring_vm_funcs;
 		adev->vcn.inst[i].ring_dec.me = i;
-		DRM_INFO("VCN(%d) decode is enabled in VM mode\n", i);
 	}
 }
 
@@ -1725,7 +1719,6 @@ static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev)
 			adev->vcn.inst[j].ring_enc[i].funcs = &vcn_v2_5_enc_ring_vm_funcs;
 			adev->vcn.inst[j].ring_enc[i].me = j;
 		}
-		DRM_INFO("VCN(%d) encode is enabled in VM mode\n", j);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 6b31cf4b8aac..24f947751c46 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -303,7 +303,7 @@ static int vcn_v3_0_hw_init(void *handle)
 	if (amdgpu_sriov_vf(adev)) {
 		r = vcn_v3_0_start_sriov(adev);
 		if (r)
-			goto done;
+			return r;
 
 		/* initialize VCN dec and enc ring buffers */
 		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
@@ -348,24 +348,18 @@ static int vcn_v3_0_hw_init(void *handle)
 
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				goto done;
+				return r;
 
 			for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
 				ring = &adev->vcn.inst[i].ring_enc[j];
 				r = amdgpu_ring_test_helper(ring);
 				if (r)
-					goto done;
+					return r;
 			}
 		}
 	}
 
 	return 0;
-done:
-	if (!r)
-		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
-			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
-
-	return r;
 }
 
 /**
@@ -2041,8 +2035,6 @@ static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 		else
 			adev->vcn.inst[i].ring_dec.funcs = &vcn_v3_0_dec_sw_ring_vm_funcs;
 		adev->vcn.inst[i].ring_dec.me = i;
-		DRM_INFO("VCN(%d) decode%s is enabled in VM mode\n", i,
-			  DEC_SW_RING_ENABLED?"(Software Ring)":"");
 	}
 }
 
@@ -2058,8 +2050,6 @@ static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev)
 			adev->vcn.inst[i].ring_enc[j].funcs = &vcn_v3_0_enc_ring_vm_funcs;
 			adev->vcn.inst[i].ring_enc[j].me = i;
 		}
-		if (adev->vcn.num_enc_rings > 0)
-			DRM_INFO("VCN(%d) encode is enabled in VM mode\n", i);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index ac1b8ead03b3..f6d96a44d75f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -258,7 +258,7 @@ static int vcn_v4_0_hw_init(void *handle)
 	if (amdgpu_sriov_vf(adev)) {
 		r = vcn_v4_0_start_sriov(adev);
 		if (r)
-			goto done;
+			return r;
 
 		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 			if (adev->vcn.harvest_config & (1 << i))
@@ -269,7 +269,6 @@ static int vcn_v4_0_hw_init(void *handle)
 			ring->wptr_old = 0;
 			vcn_v4_0_unified_ring_set_wptr(ring);
 			ring->sched.ready = true;
-
 		}
 	} else {
 		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
@@ -283,18 +282,11 @@ static int vcn_v4_0_hw_init(void *handle)
 
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				goto done;
-
+				return r;
 		}
 	}
 
 	return 0;
-done:
-	if (!r)
-		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
-			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
-
-	return r;
 }
 
 /**
@@ -1900,8 +1892,6 @@ static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev)
 		adev->vcn.inst[i].ring_enc[0].funcs =
 		       (const struct amdgpu_ring_funcs *)&vcn_v4_0_unified_ring_vm_funcs;
 		adev->vcn.inst[i].ring_enc[0].me = i;
-
-		DRM_INFO("VCN(%d) encode/decode are enabled in VM mode\n", i);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 2279d8fce03d..f53054e39ebb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -210,7 +210,7 @@ static int vcn_v4_0_3_hw_init(void *handle)
 	if (amdgpu_sriov_vf(adev)) {
 		r = vcn_v4_0_3_start_sriov(adev);
 		if (r)
-			goto done;
+			return r;
 
 		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 			ring = &adev->vcn.inst[i].ring_enc[0];
@@ -246,15 +246,10 @@ static int vcn_v4_0_3_hw_init(void *handle)
 
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
-				goto done;
+				return r;
 		}
 	}
 
-done:
-	if (!r)
-		DRM_DEV_INFO(adev->dev, "VCN decode initialized successfully(under %s).\n",
-			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
-
 	return r;
 }
 
@@ -1450,7 +1445,6 @@ static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev)
 		adev->vcn.inst[i].aid_id =
 			vcn_inst / adev->vcn.num_inst_per_aid;
 	}
-	DRM_DEV_INFO(adev->dev, "VCN decode is enabled in VM mode\n");
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 81fb99729f37..f45495de6875 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -234,16 +234,10 @@ static int vcn_v4_0_5_hw_init(void *handle)
 
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
-			goto done;
+			return r;
 	}
 
 	return 0;
-done:
-	if (!r)
-		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
-			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
-
-	return r;
 }
 
 /**
@@ -1558,8 +1552,6 @@ static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev)
 
 		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v4_0_5_unified_ring_vm_funcs;
 		adev->vcn.inst[i].ring_enc[0].me = i;
-
-		DRM_INFO("VCN(%d) encode/decode are enabled in VM mode\n", i);
 	}
 }
 
-- 
2.34.1

