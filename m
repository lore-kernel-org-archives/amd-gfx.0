Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A35DC77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 15:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2621910E3D8;
	Fri, 28 Apr 2023 15:57:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8425E10E3D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 15:57:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hwlobjb0y2QLXg/5JmjmCU5tr5anOVnF0O3x1VcJaYxehFwsq71N8DfAYeG/U9lNv2AW1kqkZRBKIILGNywhaQ3dquqFskBtl9ZYH9XrLoJToD4vTAOS24MtTLJdp1C69NoJ6UQFJY3VtyzfQkjsBNyhtptex426Z8ArOgd2O6pBH7pcse9mre10njWErNL9Si0RM/OQzi2+cQk4PIF5KGXid4eGUpeFAJ5ZAuHVaUqW9Htdy4TYnDW7TgmJwmEunwkOn4Z7WlSRWAB5aGXF74WDHFYZ9TGUUU/gPwti37OuFTjyORvmMyhBakMZyJs8U8zuM0Q6M1rminwGiBs46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQWKnS0LUEfZxpYznGqJsyP6ycn7VcNYZ9nh2q6j58k=;
 b=J2aYDPoFaAkj5GWfAO3Xyzig9oRg/3ktIXv8GLDQaE50fOBPrs4T7tuYpRIB8G1//retBtmvyP90p+FLookjt3ynn2JfHE52ljMbyL2g83MKKaJeuj/A1yYpxEfuSnLIsCNDmFZBVrG6Dg1j1tU8yAggJOtlvDO8KoIcbnu7XXURzGoYFT7bdk/4CjYvUE6ZQ16D2Zt06PFeAH27rsEOXe1eDEaHUDkRXpnzorv6i8+9xwjuJLBEUPb3J9VurXBQvC508BFnHegkGQzLl16TKRUNoduqvX/zox+Wg1nYZTvWauNrQD7nM+/KmD6tkdENQFlT5KEnn8v4ZWo4u/EpIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQWKnS0LUEfZxpYznGqJsyP6ycn7VcNYZ9nh2q6j58k=;
 b=MSQpZOpB41X4Qa+3A1Yd3qIlTmEK0nvZtT0MKJ8HCupExXYs7E19Ibib1WMZSKhwlYOd4z3jybZwlXMjnpXsrtUYV1EbfOpFbzMMK18uKLR2nbxggVjRc8bm+lGLFNk1p+mqz2FcL25gf1gzDI8rY8JRUKs3xmTf+GmcVYSLPm0=
Received: from MW4P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::28)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Fri, 28 Apr
 2023 15:57:32 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::55) by MW4P221CA0023.outlook.office365.com
 (2603:10b6:303:8b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 15:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.24 via Frontend Transport; Fri, 28 Apr 2023 15:57:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 28 Apr
 2023 10:57:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: put MQDs in VRAM
Date: Fri, 28 Apr 2023 11:57:14 -0400
Message-ID: <20230428155714.1141266-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: c144152d-2a18-4b18-44c8-08db48014623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ck2PagHWJPkoIe6/b95OSFJ5FjroRsysLUdXhUFGS1XsBO4fMUTdXEmkiAN+ZxF4nYdKEDKUdb3E7kRGtuvXFCfcvc0GDawztjAUU2fwFTRDKdupgGh1Fey519z/605epGfjeunM4x6XCt6SBmne4SdMchTbh95u2kVbyg0KrI0oBZYCXBtmVRGxT9cEIyHaYRBjDx3E5G4cxBDxztShQVNHlul8RGq20xzAjJ43lZr5mpHwqDjk3W6sUwDRmtNm4zwuScXEeMyz/O9FLroPBY0XeEYPPVqO33b5zBPRYHHbJeEjL4Bxl08TRuGAe6t5jS82Kon4TJrzpmtdOZmlKecLGjxN8rAC80gS4CL/H8skHp/xFVGO+kqhRkABYKnuhZprqU9O8IwRR5lMZjtilsd8UizyuuaMoQXlzQIseh4oGH/Q6QBglDZjYZ/7JMv+nlcROa89GkJx5UIDbeeyMI8L4HNLQrTST/2G9RRVRvUclaT5OQal8rv9hxX9XXPqjuX2MfkXr8aE1Ssy4+KxKo5SlllG/U/TjRExO34nH92HVxYbxn+ej995rC9FR4aiEyaRQEMELFKGC2AP8fZXErJuiY00kQmHJWLzhazsFL9aPPNWWYBzMYXkPK/UI6VVpWJ5AP1MsXvCIo9Et3n3m0OjsNAF23XdGgnIk+w/jWjAivpQByvoU0hmGo/ZrYbsB95xHLj2fxVcPvcg2pciAlfPmV1PQ+EG6p3PXdOi0oA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(316002)(186003)(1076003)(82310400005)(26005)(16526019)(2616005)(5660300002)(336012)(70206006)(70586007)(426003)(83380400001)(36860700001)(2906002)(36756003)(6916009)(6666004)(82740400003)(4326008)(86362001)(356005)(41300700001)(478600001)(7696005)(81166007)(47076005)(8676002)(8936002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 15:57:31.0378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c144152d-2a18-4b18-44c8-08db48014623
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reduces preemption latency.
Only enable this for gfx10 and 11 for now
to avoid changing behavior on gfx 8 and 9.

v2: move MES MQDs into VRAM as well (YuBiao)
v3: enable on gfx10, 11 only (Alex)
v4: minor style changes, document why gfx10/11 only (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 90f5d302d5f3..b91be56ba773 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -382,6 +382,11 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 	int r, i, j;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *ring = &kiq->ring;
+	u32 domain = AMDGPU_GEM_DOMAIN_GTT;
+
+	/* Only enable on gfx10 and 11 for now to avoid changing behavior on older chips */
+	if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 0, 0))
+		domain |= AMDGPU_GEM_DOMAIN_VRAM;
 
 	/* create MQD for KIQ */
 	if (!adev->enable_mes_kiq && !ring->mqd_obj) {
@@ -413,7 +418,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 			ring = &adev->gfx.gfx_ring[i];
 			if (!ring->mqd_obj) {
 				r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
-							    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
+							    domain, &ring->mqd_obj,
 							    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 				if (r) {
 					dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
@@ -435,7 +440,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		ring = &adev->gfx.compute_ring[j];
 		if (!ring->mqd_obj) {
 			r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
-						    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
+						    domain, &ring->mqd_obj,
 						    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 			if (r) {
 				dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 0599f8a6813e..4560476c7c31 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -901,6 +901,7 @@ static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev,
 		return 0;
 
 	r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM |
 				    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
 				    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e853bcb892fc..3adb450eec07 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -999,6 +999,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
 		return 0;
 
 	r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM |
 				    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
 				    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 	if (r) {
-- 
2.40.0

